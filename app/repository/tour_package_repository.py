#!/usr/bin/env python3
# File: repository/tour_package_repository.py
# Author: Oluwatobiloba Light
"""Tour Package Repository"""

from typing import List, TypeVar
from uuid import UUID

from asyncpg import NotNullViolationError
from sqlalchemy import select
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.model.destination import Destination
from app.model.exclusion import Exclusion
from app.model.inclusion import Inclusion
from app.model.itinerary import Itinerary
from app.model.terms_condition import TermsCondition
from app.model.tour_package import TourPackage
from app.repository.base_repository import BaseRepository
from app.schema.exclusion_schema import CreateExclusionSchema
from app.schema.inclusion_schema import CreateInclusionSchema
from app.schema.itinerary_schema import CreateItinerarySchema
from app.schema.tour_package_schema import CreateTourPackageSchema
from sqlalchemy.orm import selectinload
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError, GeneralError, NotFoundError
from app.util.slugify import slugify

T = TypeVar("T", bound=TourPackage)


class TourPackageRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = TourPackage
        self.itineraries = Itinerary

        super().__init__(db_adapter, TourPackage)

    async def create(self, schema: CreateTourPackageSchema):
        """Creates a new tour package record in the database"""
        itineraries = [
            Itinerary(**itinerary.model_dump()) for itinerary in schema.itineraries
        ]

        inclusions = [
            Inclusion(**inclusion.model_dump()) for inclusion in schema.inclusions
        ]

        exclusions = (
            [Exclusion(**exclusion.model_dump()) for exclusion in schema.exclusions]
            if schema.exclusions and len(schema.exclusions) >= 1
            else []
        )

        terms_conditions = (
            [
                TermsCondition(**term_condition.model_dump())
                for term_condition in schema.terms_conditions
            ]
            if schema.terms_conditions and len(schema.terms_conditions) >= 1
            else []
        )

        query = self.model(
            destinations=(
                await self.resolve_destinations(
                    [destination.model_dump() for destination in schema.destinations]
                )
            ),
            itineraries=itineraries,
            slug=slugify(schema.title),
            inclusions=inclusions,
            exclusions=exclusions,
            terms_conditions=terms_conditions,
            **schema.model_dump(
                exclude=[
                    "destinations",
                    "itineraries",
                    "slug",
                    "inclusions",
                    "exclusions",
                    "terms_conditions",
                ]
            ),
        )

        async with self.db_adapter.session() as session, session.begin():
            try:
                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)

                query_result = (
                    select(self.model)
                    .options(
                        selectinload(self.model.destinations),
                        selectinload(self.model.itineraries),
                        selectinload(self.model.inclusions),
                        selectinload(self.model.exclusions),
                        selectinload(self.model.terms_conditions),
                    )
                    .where(self.model.id == query.id)
                )

                query = (await session.execute(query_result)).scalar_one()
            except IntegrityError as e:
                await self.db_adapter.rollback(session)
                raise DuplicatedError(detail=str(e.orig))
            except Exception as e:
                if "duplicate" in str(e).lower():
                    error_msg = "This tour package '{}' exists!".format(query.title)
                    raise DuplicatedError(detail=error_msg)
                elif "null value" in str(e).lower():
                    error_msg = "One or more fields required!"
                    raise GeneralError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

        return query

    async def get_by_id(self, tour_package_id: UUID):
        """Get a tour package record from the database by ID"""
        query = (
            select(self.model)
            .options(
                selectinload(self.model.destinations),
                selectinload(self.model.itineraries),
                selectinload(self.model.inclusions),
                selectinload(self.model.exclusions),
                selectinload(self.model.terms_conditions),
            )
            .where(self.model.id == tour_package_id)
        )

        async with self.db_adapter.session() as session, session.begin():
            try:
                result = (await session.execute(query)).scalar_one_or_none()
                return result
            except Exception as e:
                print("err", e)
                raise GeneralError(detail=str(e))

    async def get_all(self):
        """Get all tour package records from the database"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = (
                    (
                        await session.execute(
                            select(self.model)
                            .options(
                                selectinload(self.model.destinations),
                                selectinload(self.model.itineraries),
                                selectinload(self.model.inclusions),
                                selectinload(self.model.exclusions),
                                selectinload(self.model.terms_conditions),
                            )
                            .order_by(self.model.created_at.desc())
                        )
                    )
                    .scalars()
                    .all()
                )

                # sorted_tour_packages = sorted(query, key=lambda i: i.created_at, reverse=True)

                return query
            except Exception as e:
                raise GeneralError(detail=str(e))
        return None

    async def update(self):
        """"""

        return None

    async def delete(self):
        """"""

    async def create_itinerary(
        self,
        tour_package_schema: CreateTourPackageSchema,
        itinerary_list_schema: List[CreateItinerarySchema],
    ):
        """"""
        print("creating itinerary...")
        print(tour_package_schema, itinerary_list_schema)
        return None

    async def get_or_create_destination(self, name: str) -> Destination:
        from app.model.destination import Destination

        query = select(Destination).where(Destination.name == name)

        async with self.db_adapter.session() as session, session.begin():
            try:
                existing = (await session.execute(query)).scalars().first()

                if existing:
                    return existing

                new_dest = Destination(name=name)
                await self.db_adapter.add(session, new_dest)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, new_dest)

            except IntegrityError as e:
                await self.db_adapter.rollback(session)
                raise DuplicatedError(detail=str(e.orig))
            except Exception as e:
                if "duplicate" in str(e).lower():
                    print(str(e))
                    error_msg = "This tour package '{}' exists!".format(query.title)
                    raise DuplicatedError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

            return new_dest

    async def resolve_destinations(
        self, destination_data: list[dict]
    ) -> list[Destination]:
        return [
            (await self.get_or_create_destination(d["name"])) for d in destination_data
        ]

    async def create_inclusions(self, schema: CreateInclusionSchema):
        """Creates a tour package inclusion"""
        query = Inclusion(**schema.model_dump())
        async with self.db_adapter.session() as session, session.begin():
            try:
                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)

                query_result = (
                    select(Inclusion)
                    .options(
                        selectinload(Inclusion.tour_package),
                    )
                    .where(Inclusion.id == query.id)
                )

                query = (await session.execute(query_result)).scalar_one()
            except IntegrityError as e:
                await self.db_adapter.rollback(session)
                raise DuplicatedError(detail=str(e.orig))
            except Exception as e:
                if "duplicate" in str(e).lower():
                    error_msg = "This tour package '{}' exists!".format(query.title)
                    raise DuplicatedError(detail=error_msg)
                elif "null value" in str(e).lower():
                    error_msg = "One or more fields required!"
                    raise GeneralError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

        return query

    async def create_exclusions(self, schema: CreateExclusionSchema):
        """Creates a tour package exclusion"""
        query = Exclusion(**schema.model_dump())
        async with self.db_adapter.session() as session, session.begin():
            try:
                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)

                query_result = (
                    select(Exclusion)
                    .options(
                        selectinload(Exclusion.tour_package),
                    )
                    .where(Exclusion.id == query.id)
                )

                query = (await session.execute(query_result)).scalar_one()
            except IntegrityError as e:
                await self.db_adapter.rollback(session)
                raise DuplicatedError(detail=str(e.orig))
            except Exception as e:
                if "duplicate" in str(e).lower():
                    error_msg = "This tour package '{}' exists!".format(query.title)
                    raise DuplicatedError(detail=error_msg)
                elif "null value" in str(e).lower():
                    error_msg = "One or more fields required!"
                    raise GeneralError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

        return query
