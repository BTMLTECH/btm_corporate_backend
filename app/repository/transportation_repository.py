#!/usr/bin/env python3
# File: transportation_repository.py
# Author: Oluwatobiloba Light
"""Transportation Repository"""

from typing import TypeVar
from uuid import UUID
from sqlalchemy import delete
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.model.transportation import Transportation
from app.repository.base_repository import BaseRepository
from app.schema.transportation_schema import CreateTransportation
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError


T = TypeVar("T", bound=Transportation)


class TransportationRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = Transportation

        super().__init__(db_adapter, Transportation)

    async def create(self, schema: CreateTransportation) -> Transportation:
        """Create a transportation"""
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
                    error_msg = "Transportation exists!"
                    raise DuplicatedError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

            return query

    async def delete_by_id(self, region_id: UUID) -> bool:
        """Delete a transportation by ID"""
        transportation_deleted: bool = False
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = delete(self.model).where(self.model.id == region_id)

                result = (await session.execute(query))

                if result.rowcount < 1:
                    transportation_deleted = False
                else:
                    transportation_deleted = True
            except Exception as e:
                return False

        return transportation_deleted
