#!/usr/bin/env python3
# File: region_repository.py
# Author: Oluwatobiloba Light
"""Region Repository"""

from typing import Sequence, TypeVar, Union
from uuid import UUID
from sqlalchemy import delete, select, update
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.model.region import Region
from app.repository.base_repository import BaseRepository
from app.schema.region_schema import CreateRegion
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError, GeneralError, NotFoundError
from sqlalchemy.orm import joinedload


T = TypeVar("T", bound=Region)


class RegionRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = Region

        super().__init__(db_adapter, Region)

    async def create(self, schema: CreateRegion) -> Region:
        """Create a region"""
        # return await super().create(schema)
        async with self.db_adapter.session() as session, session.begin():
            query = self.model(**schema.model_dump(exclude_none=True))

            try:
                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)
            except IntegrityError as e:
                await self.db_adapter.rollback(session)
                raise DuplicatedError(detail=str(e.orig))
            except Exception as e:
                if "duplicate" in str(e).lower():
                    error_msg = "Region exists!"
                    raise DuplicatedError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

            return query

    async def update_by_id(self, region_id: UUID, updated_fields: dict[str, any]):
        """Update a region by ID"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                if self.model.id != region_id:
                    raise NotFoundError(
                        detail="Region not found or has been deleted")

                query = update(self.model).where(self.model.id == region_id).values(
                    {}).execution_options(synchronize_session="fetch")

                result = (await session.execute(query))

                q = select(self.model).where(self.model.id == region_id)

                updated_record = (await session.execute(q)).scalar_one_or_none()

                if result and result.rowcount < 1:
                    return updated_record

                return updated_record
            except:
                await self.db_adapter.rollback(session)
                raise

    async def delete_by_id(self, region_id: UUID) -> bool:
        """Delete a region by ID"""
        region_deleted: bool = False
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = delete(self.model).where(self.model.id == region_id)

                result = (await session.execute(query))

                if result.rowcount < 1:
                    region_deleted = False
                else:
                    region_deleted = True
            except Exception as e:
                return False

        return region_deleted

    async def find_all(self) -> Sequence[Region]:
        """Returns a list of all regions"""
        async with self.db_adapter.session() as session, session.begin():
            query = select(self.model)

            try:
                result = (await session.execute(query)).scalars().all()

                return result
            except Exception as e:
                raise GeneralError(detail=str(e))

    async def find_by_id(self, region_id: UUID) -> Union[Region, None]:
        """Find a region by ID"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = select(self.model).where(self.model.id == region_id).options(
                    joinedload(self.model.sites))

                result = (await session.execute(query)).scalar_one_or_none()

                return result
            except:
                raise
