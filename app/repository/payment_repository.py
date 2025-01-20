#!/usr/bin/env python3
# File: repository/payment_repository.py
# Author: Oluwatobiloba Light
"""Payment Gateway Repository"""

from typing import Sequence, TypeVar, Union
from uuid import UUID
from sqlalchemy.orm import aliased
from sqlalchemy import and_, delete, select, update
from app.adapter.flutter_payment_adapter import FlutterPaymentAdapter
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.model.accommodation import Accommodation
from app.model.activity import Activity
# from app.model.payment import Payment
from app.model.personal_package_payment import PersonalPackagePayment
from app.model.tour_package import TourPackage
from app.model.tour_sites_region import TourSitesRegion
from app.model.transportation import Transportation
from app.model.user import User
from app.repository.base_repository import BaseRepository
from app.repository.payment_base_repository import BasePaymentRepository
from app.repository.user_repository import UserRepository
from app.schema.payment_schema import FlutterPaymentRequest, PackagePaymentSchema
from psycopg2 import IntegrityError
from app.core.exceptions import DuplicatedError, GeneralError, NotFoundError
from sqlalchemy.orm import joinedload, selectinload


T = TypeVar("T", bound=PersonalPackagePayment)


class PaymentRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = PersonalPackagePayment

        super().__init__(db_adapter, PersonalPackagePayment)

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
