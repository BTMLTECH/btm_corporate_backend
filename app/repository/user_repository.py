#!/usr/bin/env python3
# File: user_repository.py
# Author: Oluwatobiloba Light
"""User Repository"""

from pydantic import EmailStr
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.schema.user_schema import CreateUser
from app.model.user import User
from typing import Sequence, TypeVar, Union
from psycopg2 import IntegrityError
from sqlalchemy import UUID, select, update
from app.core.exceptions import DuplicatedError
from app.model.user import User
from app.repository.base_repository import BaseRepository

T = TypeVar("T", bound=User)


class UserRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = User

        super().__init__(db_adapter, User)

    async def create(self, schema: CreateUser) -> User:
        """Creates a new user"""
        query = self.model(**schema.model_dump(exclude_none=True))

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
                    error_msg = "An account with that email address exists!"
                    raise DuplicatedError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

        return query

    async def update(self, schema: T, updated_fields: dict[str, any]) -> Union[User, None]:
        """Updte user record in the DB"""
        async with self.db_adapter.session() as session, session.begin():
            query = (update(self.model).where(self.model.email ==
                                              schema.email).values(**updated_fields).execution_options(synchronize_session="fetch"))

            try:
                result = (await session.execute(query))

                q = select(self.model).where(self.model.email == schema.email)

                updated_record = (await session.execute(q)).scalar_one_or_none()

                if result.rowcount < 1:
                    return updated_record

                return updated_record
            except Exception as e:
                await self.db_adapter.rollback(session)
                raise e
            except:
                raise

    async def get_by_email(self, email: EmailStr, eager: bool = False) -> Union[User, None]:
        """
        Get a user by their email
        """
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = select(self.model).where(self.model.email == email)

                query = (await session.execute(
                    query)).scalar()

                if query is None:
                    return None
                return query
            except Exception as e:
                print("An error has occured", e)
                raise e

    async def get_by_id(self, id: UUID) -> Union[User, None]:
        """Get a user by id"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = select(self.model).where(self.model.id == id)

                query = (await session.execute(
                    query)).scalar()

                return query
            except Exception as e:
                print("An error has occured", e)
                raise e

    async def get_all(self) -> Sequence[User]:
        """Get all users"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = select(self.model)

                query = (await session.execute(
                    query)).scalars().all()

                return query
            except Exception as e:
                print("An error has occured", e)
                raise e

    async def update_by_id(self, id: UUID, updated_fields: dict[str, any]) -> Union[User, None]:
        """Update a user by ID"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = (update(self.model).where(self.model.id == id).values(**updated_fields).execution_options(synchronize_session="fetch"))
                result= (await session.execute(query))

                q= select(self.model).where(self.model.id == id)

                updated_record= (await session.execute(q)).scalar_one_or_none()

                if result.rowcount < 1:
                    return updated_record

                return updated_record
            except Exception as e:
                await self.db_adapter.rollback(session)
                raise e
