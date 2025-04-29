#!/usr/bin/env python3
# File: app/repository/destination_repository.py
# Author: Oluwatobiloba Light
# Date created: 29/04/2025
"""Destination Repository"""

from sqlalchemy import select
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from typing import Sequence, TypeVar
from app.model.destination import Destination
from app.repository.base_repository import BaseRepository
from app.schema.destination_schema import CreateDestinationSchema
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError, GeneralError, NotFoundError
from sqlalchemy.orm import selectinload

T = TypeVar("T", bound=Destination)


class DestinationRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = Destination

        super().__init__(db_adapter, Destination)

    async def create(self, schema: CreateDestinationSchema) -> Destination:
        """Creates a new record of Destination in the database"""
        query = self.model(**schema.model_dump(exclude_none=True))

        async with self.db_adapter.session() as session, session.begin():
            try:
                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)

                query_result = (
                    select(self.model)
                    # .options(
                    #     selectinload(self.model.tour_packages),
                    #     selectinload(self.model.regions),
                    # )
                    .where(self.model.id == query.id)
                )

                query = (await session.execute(query_result)).scalar_one()
            except IntegrityError as e:
                await self.db_adapter.rollback(session)
                raise DuplicatedError(detail=str(e.orig))
            except Exception as e:
                if "duplicate" in str(e).lower():
                    error_msg = "This destination '{}' exists!".format(query.name)
                    raise DuplicatedError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

        return query

    async def get_all(self) -> Sequence[Destination]:
        """Return all destination records from the database"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = select(self.model).options(
                    selectinload(self.model.tour_packages),
                    selectinload(self.model.regions),
                )

                query = (await session.execute(query)).scalars().all()

                return query
            except Exception as e:
                raise GeneralError(detail=str(e))
