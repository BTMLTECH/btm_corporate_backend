#!/usr/bin/env python3
# File: repository/tour_package_repository.py
# Author: Oluwatobiloba Light
"""Tour Package Repository"""

from typing import Sequence, TypeVar, Union
from uuid import UUID
from sqlalchemy.orm import aliased
from sqlalchemy import delete, select, update
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.model.accommodation import Accommodation
from app.model.activity import Activity
from app.model.tour_package import TourPackage
from app.model.tour_sites_region import TourSitesRegion
from app.model.transportation import Transportation
from app.model.user import User
from app.repository.base_repository import BaseRepository
from app.schema.tour_package_schema import CreateTourPackage
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError, GeneralError, NotFoundError
from sqlalchemy.orm import joinedload, selectinload


T = TypeVar("T", bound=TourPackage)


class TourPackageRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = TourPackage
        self.tour_sites_region_model = TourSitesRegion

        super().__init__(db_adapter, TourPackage)

    async def create(self, schema: CreateTourPackage) -> TourPackage:
        """Create a tour package"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                user_query = select(User).where(
                    User.id == schema.user_id)

                user_result = (await session.execute(user_query)).scalar_one_or_none()

                if not user_result:
                    raise NotFoundError(detail="User not found or deleted")

                query = self.model(**schema.model_dump(exclude_none=True, exclude=[
                                   "user", "activities", "tour_sites_region", "transportations"]))

                query.user = user_result

                accommodation_query = select(Accommodation).where(
                    Accommodation.id == schema.accommodation_id)

                accommodation = (await session.execute(accommodation_query)).scalar_one_or_none()

                if not accommodation:
                    raise NotFoundError(
                        detail=f"Accommodation not found or deleted: {', '.join(map(str, schema.accommodation_id))}")
                
                query.accommodation = accommodation

                tour_sites_region_ids = set(schema.tour_sites_region)

                tour_sites_query = select(TourSitesRegion).where(
                    TourSitesRegion.id.in_(tour_sites_region_ids))

                tour_sites_region_result = (await session.execute(tour_sites_query)).scalars().all()

                existing_tour_sites_region_ids = set(
                    str(tour_sites.id) for tour_sites in tour_sites_region_result)

                missing_tour_sites_ids = tour_sites_region_ids - existing_tour_sites_region_ids

                if missing_tour_sites_ids:
                    raise NotFoundError(
                        detail=f"Tour sites region(s) not found or deleted: {', '.join(map(str, missing_tour_sites_ids))}"
                    )

                query.tour_sites_region = tour_sites_region_result

                # Validate Activities
                activities_ids = set(schema.activities)
                activities_query = select(Activity).where(
                    Activity.id.in_(activities_ids))
                activities_result = (await session.execute(activities_query)).scalars().all()
                existing_activities_ids = set(
                    str(activity.id) for activity in activities_result)

                missing_activities_ids = activities_ids - existing_activities_ids
                if missing_activities_ids:
                    raise NotFoundError(
                        detail=f"Activity(s) not found or deleted: {', '.join(map(str, missing_activities_ids))}"
                    )

                query.activities = activities_result

                # Validate Transportation
                transportations_ids = set(schema.transportations)
                transportations_query = select(Transportation).where(
                    Transportation.id.in_(transportations_ids))
                
                transportation_result = (await session.execute(transportations_query)).scalars().all()

                existing_transportations_ids = set(
                    str(transportation.id) for transportation in transportation_result)

                missing_transportations_ids = transportations_ids - existing_transportations_ids
                if missing_transportations_ids:
                    raise NotFoundError(
                        detail=f"Transportation(s) not found or deleted: {', '.join(map(str, missing_transportations_ids))}"
                    )

                query.transportation = transportation_result

                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)

                query = select(self.model).options(
                    selectinload(self.model.accommodation),
                    selectinload(self.model.activities),
                    selectinload(self.model.tour_sites_region),
                    selectinload(self.model.transportation),
                    selectinload(self.model.region),
                    selectinload(self.model.user).load_only(User.id, User.email, User.name),
                ).where(self.model.id == query.id)

                query = (await session.execute(query)).scalar_one()
            except IntegrityError as e:
                await session.rollback()
                raise DuplicatedError(detail=str(e.orig))
            except NotFoundError as e:
                await session.rollback()
                raise e
            except Exception as e:
                await session.rollback()
                raise GeneralError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

            return query
