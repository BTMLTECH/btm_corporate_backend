#!/usr/bin/env python3
# File: terms_conditions_repository.py
# Author: Oluwatobiloba Light
"""TermsConditions Repository"""

from typing import TypeVar
from uuid import UUID
from sqlalchemy import delete, select
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.model.terms_condition import TermsConditions
from app.repository.base_repository import BaseRepository
from app.schema.terms_condition_schema import CreateTermsConditionsSchema
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError
from sqlalchemy.orm import selectinload

T = TypeVar("T", bound=TermsConditions)


class TermsConditionsRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = TermsConditions

        super().__init__(db_adapter, TermsConditions)

    async def create(self, schema: CreateTermsConditionsSchema) -> TermsConditions:
        """Create terms_condition"""
        # return await super().create(schema)
        async with self.db_adapter.session() as session, session.begin():
            query = self.model(**schema.model_dump(exclude_none=True))

            try:
                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)

                query = select(self.model).options(
                    selectinload(self.model.tour_package),
                ).where(self.model.id == query.id)

                query = (await session.execute(query)).scalar_one()
            except IntegrityError as e:
                await self.db_adapter.rollback(session)
                raise DuplicatedError(detail=str(e.orig))
            except Exception as e:
                if "duplicate" in str(e).lower():
                    error_msg = "TermsConditions exists!"
                    raise DuplicatedError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

            return query

    async def delete_by_id(self, region_id: UUID) -> bool:
        """Delete a terms_condition by ID"""
        terms_condition_deleted: bool = False
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = delete(self.model).where(self.model.id == region_id)

                result = (await session.execute(query))

                if result.rowcount < 1:
                    terms_condition_deleted = False
                else:
                    terms_condition_deleted = True
            except Exception as e:
                return False

        return terms_condition_deleted

    async def get_all(self):
        """Get list of terms and conditions"""
        query = select(self.model).options(
            selectinload(self.model.tour_package),
        )

        async with self.db_adapter.session() as session, session.begin():
            try:
                result = (await session.execute(query)).scalars().fetchall()

                return result
            except:
                raise
