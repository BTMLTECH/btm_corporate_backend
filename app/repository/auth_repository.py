#!/usr/bin/env python3
# File: auth_repository.py
# Author: Oluwatobiloba Light
"""Auth Repository"""

from typing import Callable, TypeVar, Union
from psycopg2 import IntegrityError
from pydantic import EmailStr
from sqlalchemy import select
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.core.exceptions import DuplicatedError
from app.model.user import User, UserVerification
from app.repository.base_repository import BaseRepository
from sqlalchemy.ext.asyncio import AsyncSession

from app.repository.user_repository import UserRepository

T = TypeVar("T", bound=User)


class AuthRepository(BaseRepository):
    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = User
        self.user_repository = UserRepository
        
        super().__init__(db_adapter, User)

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

    async def create(self, schema: T) -> User:
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
    
    async def update_user_verification(self, ):
        """"""