#!/usr/bin/env python3
# File: /repository/payment_base_repository.py
# Author: Oluwatobiloba Light
"""Payment Base Repository"""
from typing import Any, Protocol, Type, TypeVar

from psycopg2 import IntegrityError
from sqlmodel import SQLModel
from app.adapter.database_adapter import DatabaseAdapter
from app.adapter.flutter_payment_adapter import FlutterPaymentAdapter
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.core.exceptions import DuplicatedError
from app.model.base_model import BaseModel

T = TypeVar('T',  bound=BaseModel)


class BasePaymentRepository:
    def __init__(self, db_adapter: SQLAlchemyAdapter, 
                #  payment_adapter: FlutterPaymentAdapter, 
                 model: Type[T]) -> None:
        self.db_adapter = db_adapter
        # self.payment_adapter = payment_adapter
        self.model = model

    async def create(self, schema: T):
        """Create an object in the database."""
        query = self.model(**schema.model_dump(exclude_none=True))
        # payment_query = self.payment_adapter.make_payment()

        async with self.db_adapter.session() as session, session.begin():
            try:
                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)
            except IntegrityError as e:
                await self.db_adapter.rollback(session)
                raise DuplicatedError(detail=str(e.orig))
            except Exception as e:
                if "duplicate" in str(e).lower():
                    error_msg = "Duplicate entry!"
                    raise DuplicatedError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

        return query

    async def update(self, id: int, schema: T):
        """Update a record in the database."""
        pass  # Implement the update logic

    async def get_by_id(self, id):
        pass
    