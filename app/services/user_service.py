#!/usr/bin/env python3
# File: user_service.py
# Author: Oluwatobiloba Light
"""User Services"""


from typing import Sequence, Union
from uuid import UUID
from pydantic import UUID4
from app.core.exceptions import AuthError
from app.core.security import get_password_hash
from app.model.user import User
from app.repository.user_repository import UserRepository
from app.schema.user_schema import UserModel
from app.services.base_service import BaseService


class UserService(BaseService):
    def __init__(self, user_repository: UserRepository):
        self.user_repository = user_repository

        super().__init__(user_repository)

    async def get_by_id(self, id: str) -> Union[User, None]:
        """Get a user by id"""
        try:
            uid = UUID(id)
            return await self.user_repository.get_by_id(uid)
        except Exception as e:
            return None
        except ValueError as e:
            return None

    async def get_all(self) -> Sequence[User]:
        return await self.user_repository.get_all()

    async def update_by_id(self, id: UUID, updated_fields: dict[str, any]) -> Union[User, None]:
        """Update user by ID"""
        password = updated_fields.get("password", None)

        if password is not None:
            if len(password) < 6:
                raise AuthError(detail='Password is too short')

            # #TODO implement strong password algorithm here

            password = get_password_hash(password)

        updated_fields.update({'password': password})
        return await self.user_repository.update_by_id(id, updated_fields)
