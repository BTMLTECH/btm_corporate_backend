#!/usr/bin/env python3
# File: user.py
# Author: Oluwatobiloba Light
"""User endpoint"""


from typing import Any, List, Mapping, Optional, Union
from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends, Request, responses, status
from fastapi.encoders import jsonable_encoder
from app.core.dependencies import get_current_user
from app.core.exceptions import AuthError, GeneralError
from app.model.google import GoogleVerification
from app.model.user import User
from app.schema.google_schema import GoogleSchema
from app.schema.user_schema import UpdateUser, UserSchema
from app.services.user_service import UserService
from app.util.redis import redis_client
from app.core.container import Container
from app.schema.auth_schema import CreateUser, GoogleCallbackData, GoogleSignIn, SignIn, UserLogin, VerifyUser
from app.services.auth_service import AuthService
from app.util.google import GoogleAuth, google_login_auth, google_register_auth
from app.core.config import configs


router = APIRouter(
    prefix="/user",
    tags=["User"],
)


@router.get("/{user_id}", response_model=Union[User, None])
@inject
async def get_user_profile(user_id: str,
                           service: UserService = Depends(
                               Provide[Container.user_service]),
                           current_user: User = Depends(get_current_user)):
    """Get a user profile"""
    user = await service.get_by_id(user_id)

    if user is None:
        return None

    delattr(user, "password")

    return user


@router.get("/all", response_model=List[User])
@inject
async def get_users(service: UserService = Depends(Provide[Container.user_service]), current_user: User = Depends(get_current_user)):
    """Get list of users"""
    users = await service.get_all()

    return users


@router.patch("", response_model=Union[User, None])
@inject
async def update(update_user: UpdateUser, service: UserService = Depends(Provide[Container.user_service]), current_user: User = Depends(get_current_user)):
    """Update a user profile"""
    user = await service.update_by_id(current_user.id, update_user.model_dump(exclude_none=True))

    return user

