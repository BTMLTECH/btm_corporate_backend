#!/usr/bin/env python3
# File: tour_sites_region_repository.py
# Author: Oluwatobiloba Light
"""TourSitesRegion Repository"""

from typing import Sequence, TypeVar, Union
from uuid import UUID
from sqlalchemy import delete, select, update
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.model.region import Region
from app.model.tour_sites_region import TourSitesRegion
from app.repository.base_repository import BaseRepository
from app.schema.tour_sites_region_schema import CreateTourSitesRegion
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError, GeneralError, NotFoundError
from sqlalchemy.orm import joinedload
from sqlalchemy.exc import SQLAlchemyError, CompileError, DBAPIError


T = TypeVar("T", bound=TourSitesRegion)


class TourSitesRegionRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = TourSitesRegion
        self.region = Region

        super().__init__(db_adapter, TourSitesRegion)

    async def create(self, schema: CreateTourSitesRegion) -> TourSitesRegion:
        """Create a tour_sites_region"""
        # return await super().create(schema)
        async with self.db_adapter.session() as session:
            async with session.begin():
                try:
                    region = await session.get(self.region, schema.region_id)

                    if not region:
                        raise NotFoundError(detail="Region not found")

                    query = self.model(**schema.model_dump(exclude_none=True))

                    await self.db_adapter.add(session, query)
                    await self.db_adapter.flush(session)
                    await self.db_adapter.refresh(session, query)
                except IntegrityError as e:
                    await self.db_adapter.rollback(session)
                    raise DuplicatedError(detail=str(e.orig))
                except Exception as e:
                    if "duplicate" in str(e).lower():
                        error_msg = "TourSitesRegion exists!"
                        raise DuplicatedError(detail=error_msg)
                    else:
                        print(f"Other integrity error: {str(e)}")
                        raise DuplicatedError(detail=str(e))
                else:
                    await self.db_adapter.commit(session)

            query.region = region
            return query

    async def update_by_id(self, tour_site_id: UUID, updated_fields: dict[str, any]) -> Union[TourSitesRegion, None]:
        """Update a tour site by ID"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = (update(self.model).where(self.model.id ==
                                                  tour_site_id).values(**updated_fields).execution_options(synchronize_session="fetch"))

                result = (await session.execute(query))

                q = select(self.model).where(self.model.id == tour_site_id).options(
                    joinedload(self.model.region))

                updated_record = (await session.execute(q)).scalar_one_or_none()

                if result.rowcount < 1:
                    return updated_record

                return updated_record
            except:
                await self.db_adapter.rollback(session)
                raise

    async def delete_by_id(self, region_id: UUID) -> bool:
        """Delete a tour_sites_region by ID"""
        tour_sites_region_deleted: bool = False
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = delete(self.model).where(self.model.id == region_id)

                result = (await session.execute(query))

                if result.rowcount < 1:
                    tour_sites_region_deleted = False
                else:
                    tour_sites_region_deleted = True
            except Exception as e:
                return False

        return tour_sites_region_deleted

    async def find_all(self) -> Sequence[TourSitesRegion]:
        """Returns a list of all regions"""
        async with self.db_adapter.session() as session, session.begin():
            query = select(self.model).options(joinedload(self.model.region))

            try:
                result = (await session.execute(query)).scalars().all()

                return result
            except Exception as e:
                raise GeneralError(detail=str(e))

    async def find_by_id(self, tour_site_id: UUID) -> Union[TourSitesRegion, None]:
        """Find a tour site by ID"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = select(self.model).where(self.model.id == tour_site_id).options(
                    joinedload(self.model.region))

                result = await session.get(self.model, tour_site_id, options=[joinedload(self.model.region)])

                return result
            except:
                raise

    async def find_all_tour_sites_by_region_id(self, region_id: UUID):
        """Find all tour sites by region id"""
        async with self.db_adapter.session() as session, session.begin():
            query = select(self.model).where(self.model.region_id == region_id).options(
                joinedload(self.model.region))

            try:
                query = (await session.execute(query)).scalars().all()
            except:
                raise

            return query
