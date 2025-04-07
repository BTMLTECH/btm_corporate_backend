#!/usr/bin/env python3
# File: dependencies.py
# Author: Oluwatobiloba Light
"""Dependencies"""


from datetime import datetime
import json
from json.decoder import JSONDecodeError
from typing import Literal, Tuple, Union
from uuid import UUID
from dependency_injector.wiring import Provide, inject
from fastapi import Depends, HTTPException, Header, Request
from fastapi.encoders import jsonable_encoder
from jose import jwt, JWTError
from pydantic import BaseModel, EmailStr, ValidationError

from app.core.config import configs
from app.core.container import Container
from app.core.exceptions import AuthError, AuthForbiddenError, GeneralError
from app.core.security import ALGORITHM, CookieBearer, JWTBearer
from app.model.user import User
from app.schema.auth_schema import Payload
from app.services.cache.redis_service import RedisService
from app.services.user_service import UserService


class CachedUser(BaseModel):
    id: UUID

    name: str
    email: EmailStr
    # password: Union[str, None] = None
    phone: Union[str, None] = None
    provider: Literal["google", "email"]
    email_verified: bool
    address: Union[str, None] = None

    is_active: bool
    is_admin: bool

    created_at: datetime
    updated_at: datetime
    deleted_at: Union[datetime, None] = None
    last_login_at: datetime

    class Config:
        from_attributes = True


@inject
async def get_current_user(
    request: Request,
    # csrf_token_cookie: str = Depends(CookieBearer()),
    token: str = Depends(JWTBearer()),
    service: UserService = Depends(Provide[Container.user_service]),
    redis_service: RedisService = Depends(Provide[Container.redis_service])
) -> User:

    # csrf_token_header = request.headers.get("X-CSRF-Token")

    # if not csrf_token_header:
    #     raise AuthForbiddenError(detail="CSRF token is missing")

    # csrf_token_cookie = request.cookies.get("csrf_token")

    # if not csrf_token_cookie:
    #     raise AuthForbiddenError(detail="CSRF token cookie is missing")

    # if csrf_token_header != csrf_token_cookie:
    #     raise AuthForbiddenError(detail="Invalid CSRF token")
    try:
        payload = jwt.decode(
            token, configs.SECRET_KEY, algorithms=ALGORITHM)

        token_data = Payload(**payload)

        redis_data = await redis_service.retrieve_data(f"user:{token_data.id}")

        current_user: Union[User, None] = None

        if not redis_data:
            current_user = await service.get_by_id(token_data.id)

            user_data = {
                "id": str(current_user.id),
                "created_at": str(current_user.created_at),
                "updated_at": str(current_user.updated_at),
                "last_login_at": str(current_user.last_login_at),
                **current_user.model_dump(exclude=["id", "created_at", "updated_at", "deleted_at", "last_login_at"]),
                "csrf_token": "csrf_token_cookie",
                "access_token": token,
            }

            await redis_service.cache_data(f"user:{current_user.id}", user_data)
            return current_user
        else:
            user_data = json.loads(redis_data)

            # if user_data["csrf_token"] != csrf_token_header:
            #     raise AuthForbiddenError(
            #         detail="Could not validate credentials")

            user = CachedUser(**user_data)

            return User(**user.model_dump())

    except (JWTError, ValidationError) as e:
        raise AuthError(detail="Could not validate credentials") from e


# @inject
# async def get_current_user(
#     token: str = Depends(JWTBearer()),
#     service: UserService = Depends(Provide[Container.user_service]),
#     redis_service: RedisService = Depends(Provide[Container.redis_service])
# ) -> User:
#     try:
#         payload = jwt.decode(token, configs.SECRET_KEY, algorithms=ALGORITHM)

#         token_data = Payload(**payload)

#         redis_data = redis_service.retrieve_data(token_data.id)

#         current_user: Union[User, None] = None

#         print(current_user, redis_data)

#         if not redis_data:
#             current_user = await service.get_by_id(token_data.id)
#         else:
#             user_data = json.loads(redis_data)

#             if "user" not in user_data:
#                 current_user = await service.get_by_id(token_data.id)

#             print("user_data", user_data)

#         # # Parse Redis data and convert it to UserSchema
#         # user_data = json.loads(redis_data)

#         # if "user" not in user_data:
#         #     current_user = await service.get_by_id(token_data.id)

#         return current_user
#     except (JWTError, ValidationError) as e:
#         raise AuthError(detail="Could not validate credentials") from e

#     current_user = redis_service.retrieve_data(token_data.id)

#     if not current_user:
#         raise AuthError(detail="User not found")

#     try:
#         current_user = CachedUser(**json.loads(current_user))

#         if "user" not in current_user:
#             raise AuthError("User not found")

#         if not current_user:
#             raise AuthError(detail="User not found")

#         return current_user.user
#     except JSONDecodeError as e:
#         raise GeneralError(
#             detail="Invalid cached data.")

#     if "user" not in current_user:
#         raise AuthError("User not found")

#     if not current_user:
#         raise AuthError(detail="User not found")

#     return current_user["user"]


async def is_user_admin(current_user: User = Depends(get_current_user)):
    """Checks if user is an admin"""
    if not current_user.is_active:
        raise AuthError("Inactive user")
    if not current_user.is_admin:
        raise AuthError("User is not an admin!")
    return current_user


def get_current_active_user(current_user: User = Depends(get_current_user)) -> User:
    if not current_user.is_active:
        raise AuthError("Inactive user")
    return current_user


# def get_current_user_with_no_exception(
#     token: str = Depends(JWTBearer()),
#     service: UserService = Depends(Provide[Container.user_service]),
# ) -> Optional[User]:
#     try:
#         payload = jwt.decode(token, configs.SECRET_KEY, algorithms=ALGORITHM)
#         token_data = Payload(**payload)
#     except (JWTError, ValidationError):
#         return None
#     current_user: User = service.get_by_id(token_data.id)
#     if not current_user:
#         return None
#     return current_user


# def get_current_super_user(current_user: User = Depends(get_current_user)) -> User:
#     if not current_user.is_active:
#         raise AuthError("Inactive user")
#     if not current_user.is_admin:
#         raise AuthError("User is not an admin!")
#     return current_user


# async def get_dbs():
#     async with Database(configs.DATABASE_URI).session() as session:
#         try:
#             yield session
#         finally:
#             await session.close()


# def get_db(request: Request) -> AsyncSession:
#     """
#     FastAPI dependency to obtain a database connection.
#     """
#     # This is set up in the database middleware.
#     print("rrrrr", request.state.db_session)
#     return request.state.db_session
