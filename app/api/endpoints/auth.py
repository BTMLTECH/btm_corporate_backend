#!/usr/bin/env python3
# File: auth.py
# Author: Oluwatobiloba Light
"""Auth endpoint"""


from typing import Any, Mapping, Optional
from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends, Request, responses, status
from fastapi.encoders import jsonable_encoder
from app.core.exceptions import AuthError, GeneralError
from app.schema.user_schema import UserSchema
from app.services.user_service import UserService
from app.util.redis import redis_client
from app.core.container import Container
from app.schema.auth_schema import CreateUser, GoogleCallbackData, GoogleSignIn, SignIn, UserLogin, VerifyUser
from app.services.auth_service import AuthService
from app.util.google import GoogleAuth, google_auth
from app.core.config import configs


router = APIRouter(
    prefix="/auth",
    tags=["auth"],
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
async def google_login(request: Request):
    """"""
    authorization_url, state = google_auth.get_google_auth_state()

    redis_client.set("google_oauth_state", state, 6000)

    return responses.RedirectResponse(authorization_url)


@router.get("/google/register", summary="Google Sign Up")
async def google_signup(request: Request):
    """"""
    google_register_auth = GoogleAuth(client_secrets_file=configs.GOOGLE_CLIENT,
                                      redirect_uri=configs.GOOGLE_REGISTER_REDIRECT_URI, scopes=configs.GOOGLE_SCOPES)

    authorization_url, state = google_register_auth.get_google_auth_state()

    redis_client.set("google_oauth_state", state, 6000)
    redis_client.set("google_sign_up", "signup", 6000)

    return responses.RedirectResponse(authorization_url)


@router.post("/google/login/callback", summary="Google Login Authentication")
@inject
async def google_login_callback(request: Request, google_data: GoogleCallbackData, service: AuthService =
                                Depends(Provide[Container.auth_service])):
    """Google Login callback"""
    # Get the authorization code
    code = google_data.code
    state = google_data.state

    if not code:
        return responses.JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,
            content={"detail": "Authorization code is missing"}
        )

    # Verify state
    stored_state = redis_client.get("google_oauth_state")

    received_state = state

    if not stored_state or not received_state or stored_state != received_state:
        return responses.JSONResponse(
            status_code=status.HTTP_401_UNAUTHORIZED,
            content={"detail": "Authentication failed. Please try again"}
        )

    flow = google_auth.google_auth_flow(code)

    if flow is None:
        return responses.JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,
            content={"detail": "Authorization failed. Please try again!"})

    credentials = flow.credentials

    request.session['credentials'] = {
        'token': credentials.token,
        'refresh_token': credentials.refresh_token,
        'token_uri': credentials.token_uri,
        'client_id': credentials.client_id,
        'client_secret': credentials.client_secret,
        'scopes': credentials.scopes,
    }

    try:
        user_info: Optional[Mapping[str, Any]] = google_auth.verify_google_token(
            id_token=credentials._id_token)

        # check if user already exists
        existing_user = await service.user_repository.get_by_email(user_info.get('email'))

        if existing_user is not None:
            return await service.google_sign_in(sign_in_info=SignIn(email=existing_user.email))

        return await service.google_sign_up(GoogleSignIn(**user_info))
    except Exception as e:
        return GeneralError(detail=str(e))


@router.post("/google/register/callback", summary="Google Login Authentication")
@inject
async def google_register_callback(request: Request, google_data: GoogleCallbackData, service: AuthService =
                                   Depends(Provide[Container.auth_service])):
    """Google Login callback"""
    # Get the authorization code
    google_register_auth = GoogleAuth(client_secrets_file=configs.GOOGLE_CLIENT,
                                      redirect_uri=configs.GOOGLE_REGISTER_REDIRECT_URI, scopes=configs.GOOGLE_SCOPES)

    code = google_data.code
    state = google_data.state

    # print("code", request)

    if not code:
        return responses.JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,
            content={"detail": "Authorization code is missing"}
        )

    # Verify state
    stored_state = redis_client.get("google_oauth_state")

    auth_state = redis_client.get("google_sign_up")

    received_state = state

    if not stored_state or not received_state or stored_state != received_state:
        return responses.JSONResponse(
            status_code=status.HTTP_401_UNAUTHORIZED,
            content={"detail": "Authentication failed. Please try again"}
        )

    flow = google_register_auth.google_auth_flow(code)

    if flow is None:
        return responses.JSONResponse(
            status_code=status.HTTP_400_BAD_REQUEST,
            content={"detail": "Authorization failed. Please try again!"})

    credentials = flow.credentials

    request.session['credentials'] = {
        'token': credentials.token,
        'refresh_token': credentials.refresh_token,
        'token_uri': credentials.token_uri,
        'client_id': credentials.client_id,
        'client_secret': credentials.client_secret,
        'scopes': credentials.scopes,
    }

    try:
        user_info: Optional[Mapping[str, Any]] = google_register_auth.verify_google_token(
            id_token=credentials._id_token)

        # check if user already exists
        existing_user = await service.user_repository.get_by_email(user_info.get('email'))

        if auth_state == 'signup' and existing_user:
            return responses.JSONResponse(
                status_code=status.HTTP_401_UNAUTHORIZED,
                content={"detail": "Account exists! Please login."})


        return await service.google_sign_up(GoogleSignIn(**user_info))
    except Exception as e:
        return GeneralError(detail=str(e))


@router.post("/verify/sign-up", summary="Verify user registration")
@inject
async def verify_sign_up(user_verification: VerifyUser, auth: AuthService = Depends(Provide[Container.auth_service])):
    """"""
    verified = await auth.verify_user_sign_up(user_verification.token)

    if not verified:
        raise AuthError(detail="You cannot do that!")

    return {"verified": True}
# @router.get("/me", response_model=User)
# @inject
# async def get_me(current_user: User = Depends(get_current_active_user)):
#     return current_user
