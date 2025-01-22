#!/usr/bin/env python3
# File: dependencies.py
# Author: Oluwatobiloba Light
"""Dependencies"""


import json
from json.decoder import JSONDecodeError
from dependency_injector.wiring import Provide, inject
from fastapi import Depends
from jose import jwt, JWTError
from pydantic import ValidationError

from app.core.config import configs
from app.core.container import Container
from app.core.exceptions import AuthError, GeneralError
from app.core.security import ALGORITHM, JWTBearer
from app.model.user import User
from app.schema.auth_schema import Payload
from app.services.cache.redis_service import RedisService
from app.services.user_service import UserService


@inject
async def get_current_user(
    token: str = Depends(JWTBearer()),
    service: UserService = Depends(Provide[Container.user_service]),
    redis_service: RedisService = Depends(Provide[Container.redis_service])
) -> User:
    try:
        payload = jwt.decode(token, configs.SECRET_KEY, algorithms=ALGORITHM)

        token_data = Payload(**payload)
    except (JWTError, ValidationError):
        raise AuthError(detail="Could not validate credentials")

    current_user = redis_service.retrieve_data(token_data.id)

    if not current_user:
        raise AuthError(detail="User not found")
    
    # current_user = await service.get_by_id(token_data.id)

    try:
        current_user = json.loads(current_user)

        if "user" not in current_user:
            raise AuthError("User not found")

        if not current_user:
            raise AuthError(detail="User not found")

        return current_user["user"]
    except JSONDecodeError as e:
        raise GeneralError(
            detail="An unknown error has occured during serialization.")

    if "user" not in current_user:
        raise AuthError("User not found")

    if not current_user:
        raise AuthError(detail="User not found")

    return current_user["user"]


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
