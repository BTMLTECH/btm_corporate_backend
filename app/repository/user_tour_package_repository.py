#!/usr/bin/env python3
# File: repository/user_tour_package_repository.py
# Author: Oluwatobiloba Light
"""User Tour Package Repository"""

from typing import Sequence, TypeVar
from uuid import UUID
from sqlalchemy import delete, select
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.model.accommodation import Accommodation
from app.model.activity import Activity
from app.model.region import Region
from app.model.user_tour_package import UserTourPackage, TourPackagePaymentStatusType
from app.model.tour_sites_region import TourSitesRegion
from app.model.transportation import Transportation
from app.model.user import User
from app.repository.base_repository import BaseRepository
from app.schema.tour_package_schema import CreateTourPackage
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError, GeneralError, NotFoundError
from sqlalchemy.orm import selectinload


T = TypeVar("T", bound=UserTourPackage)


class UserTourPackageRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = UserTourPackage
        self.tour_sites_region_model = TourSitesRegion

        super().__init__(db_adapter, UserTourPackage)

    async def create(self, schema: CreateTourPackage, user: User):
        """Create a tour package"""
        async with self.db_adapter.session() as session, session.begin():
            try:

                # query = self.model(**schema)

                # query = self.model(active=False, user_id=user.id, accommodation_id=schema.accommodation_id, no_of_people_attending=schema.no_of_people_attending, start_date=schema.start_date, end_date=schema.end_date, activities=schema.activities, name=schema.name, email=schema.email, contact=schema.contact, address=schema.address, region_id=schema.region_id, transportations=schema.transportations, tour_sites_region=schema.tour_sites_region,)

                # query = self.model()

                region_query = select(Region).where(Region.id == schema.region_id)

                region_result = (
                    await session.execute(region_query)
                ).scalar_one_or_none()

                if not region_result:
                    raise NotFoundError(
                        detail=f"Region not found or deleted: {', '.join(map(str, schema.region_id))}"
                    )

                # query.region = region

                accommodation_query = select(Accommodation).where(
                    Accommodation.id == schema.accommodation_id
                )

                accommodation_result = (
                    await session.execute(accommodation_query)
                ).scalar_one_or_none()

                if not accommodation_result:
                    raise NotFoundError(
                        detail=f"Accommodation not found or deleted: {', '.join(map(str, schema.accommodation_id))}"
                    )

                # query.accommodation = accommodation

                tour_sites_tour_package_ids = set(schema.tour_sites_region)

                tour_sites_query = select(TourSitesRegion).where(
                    TourSitesRegion.id.in_(tour_sites_tour_package_ids)
                )

                tour_sites_region_result = (
                    (await session.execute(tour_sites_query)).scalars().all()
                )

                existing_tour_sites_tour_package_ids = set(
                    str(tour_sites.id) for tour_sites in tour_sites_region_result
                )

                missing_tour_sites_ids = (
                    tour_sites_tour_package_ids - existing_tour_sites_tour_package_ids
                )

                if missing_tour_sites_ids:
                    raise NotFoundError(
                        detail=f"Tour sites region(s) not found or deleted: {', '.join(map(str, missing_tour_sites_ids))}"
                    )

                # query.tour_sites_region = tour_sites_region_result

                # Validate Activities
                activities_ids = set(schema.activities)

                activities_query = select(Activity).where(
                    Activity.id.in_(activities_ids)
                )

                activities_result = (
                    (await session.execute(activities_query)).scalars().all()
                )

                existing_activities_ids = set(
                    str(activity.id) for activity in activities_result
                )

                missing_activities_ids = activities_ids - existing_activities_ids
                if missing_activities_ids:
                    raise NotFoundError(
                        detail=f"Activity(s) not found or deleted: {', '.join(map(str, missing_activities_ids))}"
                    )

                # query.activities = activities_result

                # Validate Transportation
                transportations_ids = set(schema.transportations)
                transportations_query = select(Transportation).where(
                    Transportation.id.in_(transportations_ids)
                )

                transportation_result = (
                    (await session.execute(transportations_query)).scalars().all()
                )

                existing_transportations_ids = set(
                    str(transportation.id) for transportation in transportation_result
                )

                missing_transportations_ids = (
                    transportations_ids - existing_transportations_ids
                )
                if missing_transportations_ids:
                    raise NotFoundError(
                        detail=f"Transportation(s) not found or deleted: {', '.join(map(str, missing_transportations_ids))}"
                    )

                # query.transportation = transportation_result

                schema_dict = {
                    "active": False,
                    "accommodation_id": schema.accommodation_id,
                    "accommodation": accommodation_result,
                    "region_id": schema.region_id,
                    "region": region_result,
                    "activities": activities_result,
                    "tour_sites_region": tour_sites_region_result,
                    "transportation": transportation_result,
                    "no_of_people_attending": schema.no_of_people_attending,
                    "user_id": user.id,
                    "start_date": schema.start_date,
                    "end_date": schema.end_date,
                    "payment_status": TourPackagePaymentStatusType.PENDING,
                }

                query = self.model(**schema_dict)

                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)

                query_result = (
                    select(self.model)
                    .options(
                        selectinload(self.model.accommodation),
                        selectinload(self.model.activities),
                        selectinload(self.model.tour_sites_region),
                        selectinload(self.model.transportation),
                        selectinload(self.model.region),
                        selectinload(self.model.user),
                    )
                    .where(self.model.id == query.id)
                )

                query = (await session.execute(query_result)).scalar_one()
            except IntegrityError as e:
                await session.rollback()
                raise DuplicatedError(detail=str(e.orig))
            except NotFoundError as e:
                await session.rollback()
                raise e
            except Exception as e:
                print("error", e)
                await session.rollback()
                raise GeneralError(detail=str(e))
            except:
                await session.rollback()
                raise
            else:
                await self.db_adapter.commit(session)

            return query

    async def delete_by_id(self, tour_package_id: UUID) -> bool:
        """Delete a tour_sites_region by ID"""
        tour_package: bool = False
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = delete(self.model).where(self.model.id == tour_package_id)

                result = await session.execute(query)

                if result.rowcount < 1:
                    tour_package = False
                else:
                    tour_package = True
            except Exception as e:
                return False

        return tour_package

    async def get_user_tour_packages(self, user_id: UUID) -> Sequence[UserTourPackage]:
        """..."""
        query = (
            select(self.model)
            .options(
                selectinload(self.model.accommodation),
                selectinload(self.model.activities),
                selectinload(self.model.tour_sites_region),
                selectinload(self.model.transportation),
                selectinload(self.model.region),
                selectinload(self.model.user),
            )
            .where(self.model.user_id == user_id)
        )

        async with self.db_adapter.session() as session, session.begin():
            try:
                result = (await session.execute(query)).scalars().all()

                return result
            except Exception as e:
                print("repo", e)
                return []
                return GeneralError(detail="Something happened")
