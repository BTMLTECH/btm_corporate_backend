#!/usr/bin/env python3
# File: repository/payment_repository.py
# Author: Oluwatobiloba Light
"""Payment Gateway Repository"""

from typing import TypeVar
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
# from app.model.payment import Payment
from app.model.user_payment import UserPayment
from app.repository.base_repository import BaseRepository
from app.schema.payment_schema import PackagePaymentSchema
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError, GeneralError, NotFoundError


T = TypeVar("T", bound=UserPayment)


class PaymentRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = UserPayment

        super().__init__(db_adapter, UserPayment)

    async def create(self, schema: PackagePaymentSchema):
        """Create payment object in the database."""
        query = self.model(**schema.model_dump(exclude_none=True))


        async with self.db_adapter.session() as session, session.begin():
            try:
                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)
            except IntegrityError as e:
                await session.rollback()
                raise DuplicatedError(detail=str(e.orig))
            except NotFoundError as e:
                await session.rollback()
                raise e
            except Exception as e:
                await session.rollback()
                raise GeneralError(detail=str(e))
            except:
                await session.rollback()
                raise
            else:
                await self.db_adapter.commit(session)

        return query
