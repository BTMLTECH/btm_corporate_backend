#!/usr/bin/env python3
# File: auth.py
# Author: Oluwatobiloba Light
"""Auth endpoint"""


from typing import Any, Mapping, Optional
from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends, Request, responses, status
from fastapi.encoders import jsonable_encoder
from app.core.dependencies import get_current_user
from app.core.exceptions import AuthError, GeneralError
from app.model.google import GoogleVerification
from app.model.user import User
from app.schema.google_schema import GoogleSchema
from app.schema.user_schema import UserSchema
from app.services.user_service import UserService
from app.util.redis import redis_client
from app.core.container import Container
from app.schema.auth_schema import CreateUser, GoogleCallbackData, GoogleSignIn, SignIn, UserLogin, VerifyUser
from app.services.auth_service import AuthService
from app.util.google import GoogleAuth, google_login_auth, google_register_auth
from app.core.config import configs


router = APIRouter(
    prefix="/auth",
    tags=["Auth"],
)


@router.post("/sign-in", response_model=None)
@inject
async def sign_in(user_info: UserLogin, service: AuthService =
                  Depends(Provide[Container.auth_service])):

    user = await service.sign_in(user_info)

    return user


@router.post("/sign-up", response_model=UserSchema)
@inject
async def sign_up(user_info: CreateUser, service: AuthService =
                  Depends(Provide[Container.auth_service])):

    user = await service.sign_up(user_info)

    return user


@router.get("/google/login", summary="Google Login")
@inject
async def google_login(request: Request, service: AuthService =
                       Depends(Provide[Container.auth_service])):
    """"""
    authorization_url, state = google_login_auth.get_google_auth_state()

    await service.store_google_state(state, "Login")

    return responses.RedirectResponse(authorization_url)


@router.post("/google/login/callback", summary="Google Login Authentication")
@inject
async def google_login_callback(request: Request, google_data: GoogleCallbackData, service: AuthService =
                                Depends(Provide[Container.auth_service])):
    """Google Login callback"""
    return await service.google_sign_in_temp(google_data.code, google_data.state)


@router.get("/google/register", summary="Google Sign Up")
@inject
async def google_signup(request: Request, service: AuthService =
                        Depends(Provide[Container.auth_service])):
    """"""
    authorization_url, state = google_register_auth.get_google_auth_state()

    await service.store_google_state(state, "Register")

    return responses.RedirectResponse(authorization_url)


@router.post("/google/register/callback", summary="Google Login Authentication")
@inject
async def google_register_callback(request: Request, google_data: GoogleCallbackData, service: AuthService =
                                   Depends(Provide[Container.auth_service])):
    """Google Login callback"""
    return await service.google_sign_up_temp(google_data.code, google_data.state)


@router.post("/verify", summary="Verify user registration")
@inject
async def verify_sign_up(user_verification: VerifyUser, auth: AuthService = Depends(Provide[Container.auth_service])):
    """"""
    verified = await auth.verify_user_sign_up(user_verification.session_id)

    if not verified:
        raise AuthError(detail="Action cannot be completed!")

    return {"verified": True}

@router.post("/validate-session")
@inject
async def validate_session(service: UserService = Depends(Provide[Container.user_service]), current_user: User = Depends(get_current_user)):
    """Update a user profile"""
    return current_user