#!/usr/bin/env python3
# File: auth.py
# Author: Oluwatobiloba Light
"""Auth endpoint"""


from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, BackgroundTasks, Depends, Request, Response, responses
from fastapi.encoders import jsonable_encoder
from app.core.dependencies import get_current_user
from app.core.exceptions import AuthError
from app.model.user import User
from app.schema.user_schema import UserSchema
from app.services.cache.redis_service import RedisService
from app.services.mail_service import EmailService
from app.services.user_service import UserService
from app.core.container import Container
from app.schema.auth_schema import (
    CreateUser,
    ForgotPasswordSchema,
    GoogleCallbackData,
    UserLogin,
    VerifyUser,
)
from app.services.auth_service import AuthService
from app.tasks import send_email
from app.util.google import google_login_auth, google_register_auth
from app.core.config import configs


router = APIRouter(
    prefix="/auth",
    tags=["Auth"],
)


@router.post("/sign-in", response_model=None)
@inject
async def sign_in(
    user_info: UserLogin,
    service: AuthService = Depends(Provide[Container.auth_service]),
):
    """Route to sign in"""
    user = await service.sign_in(user_info)

    response = responses.JSONResponse(
        content={
            "message": "Login successful",
            "user": jsonable_encoder(user.get("user")),
            "csrf_token": user.get("csrf_token"),
            "access_token": user.get("access_token"),
        }
    )

    response.set_cookie(
        path="/",
        key="access_token",
        value=user.get("access_token"),
        httponly=True,  # Ensure HTTPS is used in production
        secure=True,
        samesite="none",  # Adjust based on your frontend/backend architecture
        max_age=2 * 60 * 60,
        # domain="127.0.0.1"
    )

    # Set non-HTTP-only cookie for CSRF token
    response.set_cookie(
        path="/",
        key="csrf_token",
        value=user.get("csrf_token"),
        httponly=True,  # Accessible to JavaScript
        secure=True,  # Ensure HTTPS in production
        samesite="lax",
        max_age=2 * 60 * 60,
        # domain="127.0.0.1"
    )

    return response


@router.get("/test-email")
async def test_background_task(background_tasks: BackgroundTasks):
    session_id = "12345"
    email = "thekccfyouth@gmail.com"
    verification_url = "https://example.com/verify"
    email_service = EmailService(
        configs.SMTP_SERVER,
        configs.EMAIL_PORT,
        configs.EMAIL_USERNAME,
        configs.EMAIL_PASSWORD,
        configs.SENDER_EMAIL,
    )

    await email_service.send_verification_email(session_id, email, verification_url)

    background_tasks.add_task(
        email_service.send_verification_email, session_id, email, verification_url
    )

    return {"message": "Email task added"}


@router.post("/sign-up", response_model=UserSchema)
@inject
async def sign_up(
    response: Response,
    background_tasks: BackgroundTasks,
    user_info: CreateUser,
    service: AuthService = Depends(Provide[Container.auth_service]),
):
    """Router to sign up"""
    user = await service.sign_up(user_info, background_tasks)

    return user


@router.get("/google/login", summary="Google Login")
@inject
async def google_login(
    request: Request, service: AuthService = Depends(Provide[Container.auth_service])
):
    """Route to login using Google"""
    authorization_url, state = google_login_auth.get_google_auth_state()

    await service.store_google_state(state, "Login")

    return responses.RedirectResponse(authorization_url)


@router.post("/google/login/callback", summary="Google Login Authentication")
@inject
async def google_login_callback(
    background_tasks: BackgroundTasks,
    google_data: GoogleCallbackData,
    service: AuthService = Depends(Provide[Container.auth_service]),
):
    """Google Login callback"""
    data = await service.google_sign_in_temp(google_data.code, google_data.state)

    email_content = """
                Welcome to BTM Ghana! We're excited to have you on board. Since you signed up using Google, you’re all set—no extra steps needed!

                Here’s what you can do next:
                    ✅ Get started with creating your customized tour package or booking a flight.

                If you ever have any questions, feel free to reach out to our support team at {0}.

                We’re thrilled to have you with us! 🚀

                Cheers,
                BTM Ghana
                https://btmghana.net
            """.format(
        "info@btmghana.net"
    )

    user = dict(jsonable_encoder(data.get("user")))

    send_email.delay(
        user.get("email"),
        "Welcome to BTM Ghana – We're Glad You're Here! 🎉",
        email_content,
    )

    return jsonable_encoder(data)


@router.get("/google/register", summary="Google Sign Up")
@inject
async def google_signup(
    request: Request, service: AuthService = Depends(Provide[Container.auth_service])
):
    """Route to sign up using Google"""
    authorization_url, state = google_register_auth.get_google_auth_state()

    await service.store_google_state(state, "Register")

    return responses.RedirectResponse(authorization_url)


@router.post("/google/register/callback", summary="Google Login Authentication")
@inject
async def google_register_callback(
    background_tasks: BackgroundTasks,
    google_data: GoogleCallbackData,
    service: AuthService = Depends(Provide[Container.auth_service]),
):
    """Google Login callback"""
    return await service.google_sign_up_temp(
        google_data.code, google_data.state, background_tasks
    )


@router.post("/verify", summary="Verify user registration")
@inject
async def verify_sign_up(
    user_verification: VerifyUser,
    auth: AuthService = Depends(Provide[Container.auth_service]),
):
    """Route to verify sign up"""
    verified = await auth.verify_user_sign_up(user_verification.session_id)

    if not verified:
        raise AuthError(detail="Action cannot be completed!")

    return {"verified": True}


@router.get("/validate-session")
@inject
async def validate_session(
    service: UserService = Depends(Provide[Container.user_service]),
    current_user: User = Depends(get_current_user),
):
    """Route to validate user session"""
    if not current_user.is_active:
        raise AuthError(detail="Account is not active")
    return current_user


@router.post("/resend-verification")
@inject
async def resend_verification(
    service: AuthService = Depends(Provide[Container.auth_service]),
    current_user: User = Depends(get_current_user),
):
    """Route to re-send verification link"""
    return await service.resend_verification(current_user)


@router.post("/forgot-password")
@inject
async def forgot_password(
    user: ForgotPasswordSchema,
    service: AuthService = Depends(Provide[Container.auth_service]),
):
    """Route to forgot password"""
    result = await service.reset_password(user.email)
    return result


@router.post("/logout")
@inject
async def logout(
    response: Response,
    redis_service: RedisService = Depends(Provide[Container.redis_service]),
    current_user: User = Depends(get_current_user),
):
    """Route to logout"""
    await redis_service.delete_data(str(current_user.id))

    response.delete_cookie("access_token")
    response.delete_cookie("csrf_token")

    return {"message": "Logout successful"}
