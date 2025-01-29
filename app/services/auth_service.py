#!/usr/bin/env python3
# File: auth_service.py
# Author: Oluwatobiloba Light
"""Auth Service"""


from datetime import timedelta, timezone
import json
import secrets
from typing import Any, Mapping, Optional, Union
from uuid import uuid4

from fastapi import BackgroundTasks
from pydantic import EmailStr
from app.core.config import configs
from app.core.exceptions import AuthError, GeneralError, ValidationError
from app.core.security import JWTBearer, create_access_token, get_password_hash, \
    verify_password
from app.model.google import GoogleVerification
from app.model.user import User, UserVerification
from app.repository.auth_repository import AuthRepository
from app.repository.google_repository import GoogleRepository
from app.repository.user_repository import UserRepository
from app.repository.user_verification_repository import UserVerificationRepository
from app.schema.auth_schema import CreateUser, GoogleSignIn, Payload, SignIn, UserLogin
from app.schema.user_schema import UserSchema
from smtplib import SMTP
from email.mime.text import MIMEText
from os import getenv
from app.services.base_service import BaseService
from app.services.cache.redis_service import RedisService
from app.services.mail_service import EmailService
from app.util.google import google_login_auth, google_register_auth
from datetime import datetime


class AuthService(BaseService):
    def __init__(self, auth_repository: AuthRepository, user_verification_repository: UserVerificationRepository, user_repository: UserRepository, google_repository: GoogleRepository, redis_service: RedisService):
        self.auth_repository = auth_repository
        self.user_verification_repository = user_verification_repository
        self.user_repository = user_repository
        self.google_repository = google_repository
        self.redis_service = redis_service

        super().__init__(auth_repository)

    async def sign_in(self, sign_in_info: UserLogin):
        user = await self.user_repository.get_by_email(sign_in_info.email)

        if not user:
            raise AuthError(detail="Incorrect email or password")

        if user.provider == 'google':
            raise AuthError(detail="You signed up using a different method.")

        if (user.password and sign_in_info.password) and\
                not verify_password(sign_in_info.password, user.password):
            raise AuthError(detail="Incorrect email or password")

        if not user.is_active:
            raise AuthError(detail="Account is not active")

        delattr(user, "password")

        payload = Payload(
            id=str(user.id),
            name=user.name,
            email=user.email,
            is_admin=user.is_admin,
        )

        token_lifespan = timedelta(
            minutes=configs.ACCESS_TOKEN_EXPIRE_MINUTES)

        access_token, expiration_datetime = create_access_token(
            payload.model_dump(), token_lifespan)

        await self.user_repository.update_by_id(user.id, {"last_login_at": datetime.now()})

        csrf_token = secrets.token_hex(32)

        user_data = {
            "id": str(user.id),
            "created_at": str(user.created_at),
            "updated_at": str(user.updated_at),
            "last_login_at": str(user.last_login_at),
            **user.model_dump(exclude=["id", "created_at", "updated_at", "deleted_at", "last_login_at"]),
            "csrf_token": csrf_token,
            "access_token": access_token,
        }

        await self.redis_service.cache_data(
            f"user:{user.id}", user_data)

        sign_in_result = {
            "access_token": access_token,
            "csrf_token": csrf_token,
            "user": user,
        }

        return sign_in_result

    async def google_sign_in(self, sign_in_info: UserLogin):
        user = await self.user_repository.get_by_email(sign_in_info.email)

        if user and user.provider != 'google':
            return AuthError(detail="You signed up using a different method")

        payload = Payload(
            id=str(user.id),
            email=user.email,
            name=user.name,
            is_admin=user.is_admin,
        )

        token_lifespan = timedelta(
            minutes=configs.ACCESS_TOKEN_EXPIRE_MINUTES)

        access_token, expiration_datetime = create_access_token(
            payload.model_dump(), token_lifespan)

        csrf_token = secrets.token_hex(32)

        user_data = {
            "id": str(user.id),
            "created_at": str(user.created_at),
            "updated_at": str(user.updated_at),
            "last_login_at": str(user.last_login_at),
            **user.model_dump(exclude=["id", "created_at", "updated_at", "deleted_at", "last_login_at"]),
            "csrf_token": csrf_token,
            "access_token": access_token,
        }

        await self.redis_service.cache_data(
            f"user:{user.id}", user_data)

        sign_in_result = {
            "access_token": access_token,
            "csrf_token": csrf_token,
            "user": user,
        }

        return sign_in_result

    async def does_user_exist(self, email: str) -> Union[User, None]:
        """"""
        if email is None or not email:
            raise ValidationError("Email cannot be blank")

        return await self.user_repository.get_by_email(email)

    async def sign_up(self, user_info: CreateUser, background_tasks: BackgroundTasks) -> UserSchema:
        if len(user_info.password) < 6:
            raise ValidationError("Password is too short!")

        user = User(**user_info.model_dump(exclude_none=True),
                    is_active=True, is_admin=False, provider="email")

        user.password = get_password_hash(user_info.password)

        new_user: User

        try:
            new_user = await self.auth_repository.create(user)

            payload = Payload(
                id=str(new_user.id),
                email=new_user.email,
                name=new_user.name,
                is_admin=new_user.is_admin,
            )

            token_lifespan = timedelta(
                minutes=15)

            access_token, _ = create_access_token(
                payload.model_dump(), token_lifespan)

            email_service = EmailService(configs.SMTP_SERVER, configs.EMAIL_PORT,
                                         configs.EMAIL_USERNAME, configs.EMAIL_PASSWORD, configs.SENDER_EMAIL)

            session_id = uuid4()

            user_verification = UserVerification(
                session_id=session_id, email=user.email, token=access_token)

            await self.user_verification_repository.create(user_verification)

            # await email_service.send_verification_email(session_id, new_user.email, getenv("API_URI", "https://btmghana.net") + "/verify")

            print("sending verification email in background...")

            verification_url = getenv(
                "API_URI", "https://btmghana.net") + "/verify"

            background_tasks.add_task(
                email_service.send_verification_email, session_id, new_user.email, verification_url)
        except Exception as e:
            print("error", e)
            raise GeneralError(detail=str(e))

        delattr(new_user, "password")
        return UserSchema(**new_user.model_dump(exclude_none=True))

    async def google_sign_up(self, user_info: GoogleSignIn, background_tasks: BackgroundTasks):
        """Google Signup"""

        user_exists: User = await self.user_repository.get_by_email(user_info.email)

        if not user_exists or user_exists is None:
            # register user here
            user = User(**user_info.model_dump(exclude_none=True), is_active=True,
                        is_admin=False, provider="google")

            try:
                new_user = await self.user_repository.create(user)

                payload = Payload(
                    id=str(new_user.id),
                    email=new_user.email,
                    name=new_user.name,
                    is_admin=new_user.is_admin,
                )

                token_lifespan = timedelta(
                    minutes=configs.ACCESS_TOKEN_EXPIRE_MINUTES)

                access_token, expiration_datetime = create_access_token(
                    payload.model_dump(), token_lifespan)

                email_service = EmailService(configs.SMTP_SERVER, configs.EMAIL_PORT,
                                             configs.EMAIL_USERNAME, configs.EMAIL_PASSWORD, configs.SENDER_EMAIL)

                
                background_tasks.add_task(
                email_service.send_email, new_user.email, subject="Welcome to BTM Ghana!",
                                               content="You have successfully signed up on BTM Ghana. Welcome")
                print("Sending email...")

                google_signup_result = {
                    "access_token": access_token,
                    "expiration": expiration_datetime,
                    "user": new_user,
                }

                return google_signup_result
            except Exception as e:
                print("error", e)
                raise GeneralError(detail="An unknown error has occured") from str(e)

        return self.sign_in(sign_in_info=SignIn(email=user_info.email))

    async def google_sign_up_temp(self, code: str, state: str):
        """"""
        if not code:
            return GeneralError(detail="Authorization code is missings")

        stored_state = await self.get_google_state(state)

        received_state = state

        if not stored_state or not received_state or stored_state.state != received_state:
            return AuthError(detail="Authentication failed. Please try again")

        flow = google_register_auth.google_auth_flow(code)

        if flow is None:
            return AuthError(detail="Authorization failed. Please try again!")

        credentials = flow.credentials

        # request.session['credentials'] = {
        #     'token': credentials.token,
        #     'refresh_token': credentials.refresh_token,
        #     'token_uri': credentials.token_uri,
        #     'client_id': credentials.client_id,
        #     'client_secret': credentials.client_secret,
        #     'scopes': credentials.scopes,
        # }

        try:
            user_info: Optional[Mapping[str, Any]] = google_register_auth.verify_google_token(
                id_token=credentials._id_token)

            # check if user already exists
            existing_user = await self.user_repository.get_by_email(user_info.get('email'))

            if stored_state.auth_type == 'Register' and existing_user:
                await self.google_repository.delete_by_state(state)
                return AuthError(detail="Account exists! Please login.")

            await self.google_repository.delete_by_state(state)
            background_tasks = BackgroundTasks()
            return await self.google_sign_up(GoogleSignIn(**user_info), background_tasks)
        except Exception as e:
            return GeneralError(detail=str(e))

    async def google_sign_in_temp(self, code: str, state: str):
        """"""
        if not code:
            return GeneralError(detail="Authorization code is missing")

        # Verify state
        stored_state = await self.get_google_state(state)

        received_state = state

        if not stored_state or not received_state or stored_state.state != received_state:
            await self.google_repository.delete_by_state(state)
            return AuthError(detail="Authentication failed. Please try again")

        flow = google_login_auth.google_auth_flow(code)

        if flow is None:
            await self.google_repository.delete_by_state(state)
            return GeneralError(detail="Authorization failed. Please try again!")

        credentials = flow.credentials

        # request.session['credentials'] = {
        #     'token': credentials.token,
        #     'refresh_token': credentials.refresh_token,
        #     'token_uri': credentials.token_uri,
        #     'client_id': credentials.client_id,
        #     'client_secret': credentials.client_secret,
        #     'scopes': credentials.scopes,
        # }

        try:
            user_info: Optional[Mapping[str, Any]] = google_login_auth.verify_google_token(
                id_token=credentials._id_token)

            existing_user: Union[User, None]
            if user_info is not None:
                # check if user already exists
                existing_user = await self.user_repository.get_by_email(user_info.get('email', ""))

            if existing_user is not None:
                await self.google_repository.delete_by_state(state)
                return await self.google_sign_in(sign_in_info=SignIn(email=existing_user.email))

            await self.google_repository.delete_by_state(state)
            return AuthError(detail="Account does not exist! Please sign up")
        except Exception as e:
            return GeneralError(detail=str(e))

    async def reset_user_password(self, email: str):
        """Reset a user's password"""
        return await self.user_repository.reset_password(email)

    async def verify_u_sign_up(self, token: str):
        """"""
        verified = await self.user_repository.verify_sign_up(token)

        return verified

    async def send_sign_up_verification_email(self, email: EmailStr, token: str, expiration_time: int = 15):
        """"""
        token_id = str(uuid4())

        # verification_data = {
        #     "id": token_id,
        #     "email": email,
        #     "token": token
        # }

        # Plain text content
        text = """\
        Hi,
        Thanks for signing up on BTM Ghana!
        To complete your registration, please click on the link below to verify your email address:
        
        https://btmghana.net/verify?token={0}
        
        If you didn't request this email, please ignore it.
        
        Best regards,
        BTM Ghana
        btmghana.net
        """.format(token_id)

        # Create MIMEText object
        message = MIMEText(text, "plain")
        message["Subject"] = "BTM Ghana - Email Verification"
        message["From"] = "{0} {1}".format("BTMGhana", configs.SENDER_EMAIL)
        message["To"] = "oluwatobilobagunloye@gmail.com"

        # set token in redis here
        from app.util.redis import redis_client

        try:

            # Send the email
            with SMTP(configs.SMTP_SERVER, configs.EMAIL_PORT) as server:
                server.starttls()  # Secure the connection
                server.login(configs.EMAIL_USERNAME, configs.EMAIL_PASSWORD)
                server.sendmail(configs.SENDER_EMAIL, "oluwatobilobagunloye@gmail.com",
                                message.as_string())

            # redis_client.set(token_id, verification_data,
            #                  expiry_seconds=60*expiration_time)

            return True
        except Exception as e:
            raise e

        return False

    async def reset_password(self, email: EmailStr):
        """"""

    async def verify_user_sign_up(self, session_id: str) -> bool:
        """Verify a user's account after sign up"""
        session_id_exists = await self.user_verification_repository.verify_sign_up(session_id)

        if session_id_exists is not None:
            from datetime import datetime

            jwt = JWTBearer()

            verified = jwt.verify_jwt(session_id_exists.token)

            if not verified:
                delete_verification = await self.user_verification_repository.delete(session_id_exists.session_id)
                if delete_verification or not delete_verification:
                    return False
                return False

            current_time_utc = datetime.now(timezone.utc)

            if current_time_utc > session_id_exists.expires_at:
                await self.user_verification_repository.delete(session_id_exists.session_id)
                return False

            else:
                user = await self.user_repository.get_by_email(session_id_exists.email)

                if user is None:
                    return False

                user_updated = await self.user_repository.update(user, {
                    "email_verified": True
                })

                if user_updated is None:
                    return False

                delete_verification = await self.user_verification_repository.delete(session_id_exists.session_id)

                if delete_verification or not delete_verification:
                    return True

                return True

        return False

    async def store_google_state(self, state: str, auth_type: str = "Login") -> GoogleVerification:
        """Store google state"""
        google_state = GoogleVerification(state=state, auth_type=auth_type)

        stored_state = await self.google_repository.create(google_state)

        return stored_state

    async def get_google_state(self, state: str):
        """Get google state"""
        google_state = await self.google_repository.get_by_state(state)

        return google_state

    async def resend_verification(self, user: UserSchema):
        """This service resends verification link to a user"""
        try:
            payload = Payload(
                id=str(user.id),
                email=user.email,
                name=user.name,
                is_admin=user.is_admin,
            )

            token_lifespan = timedelta(
                minutes=15)

            access_token, _ = create_access_token(
                payload.model_dump(), token_lifespan)

            email_service = EmailService(configs.SMTP_SERVER, configs.EMAIL_PORT,
                                         configs.EMAIL_USERNAME, configs.EMAIL_PASSWORD, configs.SENDER_EMAIL)

            session_id = uuid4()

            user_verification = UserVerification(
                session_id=session_id, email=user.email, token=access_token)

            await self.user_verification_repository.create(user_verification)

            await email_service.send_verification_email(session_id, user.email, getenv("API_URI", "https://btmghana.net") + "/verify")

        except Exception as e:
            if "recently" in str(e):
                raise GeneralError(detail=str(e))
            raise GeneralError(detail=str(e))

        return {
            "success": True,
            "message": "Verification link has been sent"
        }
