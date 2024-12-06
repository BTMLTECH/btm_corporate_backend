#!/usr/bin/env python3
# File: auth_service.py
# Author: Oluwatobiloba Light
"""Auth Service"""


from datetime import timedelta
from typing import Union
from uuid import uuid4

from pydantic import EmailStr
from app.core.config import configs
from app.core.database import Database
from app.core.exceptions import AuthError, ValidationError
from app.core.security import create_access_token, get_password_hash, \
    verify_password
from app.model.user import User
from app.repository.user_repository import UserRepository
from app.schema.auth_schema import CreateUser, GoogleSignIn, Payload, SignIn, UserLogin
from app.schema.user_schema import UserSchema
from app.services.base_service import BaseService
from smtplib import SMTP
from email.mime.text import MIMEText


class AuthService(BaseService):
    def __init__(self, user_repository: UserRepository, db: Database):
        self.user_repository = user_repository
        self.db = db

        super().__init__(user_repository)

    async def sign_in(self, sign_in_info: UserLogin):
        user = await self.user_repository.get_by_email(sign_in_info.email)

        if not user:
            raise AuthError(detail="Incorrect email or password")

        if not user.is_active:
            raise AuthError(detail="Account is not active")

        if user.provider == 'google':
            raise AuthError(detail="You signed up using a different method.")

        if (user.password and sign_in_info.password) and\
                not verify_password(sign_in_info.password, user.password):
            raise AuthError(detail="Incorrect email or password")

        delattr(user, "password")

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

        sign_in_result = {
            "access_token": access_token,
            "expiration": expiration_datetime,
            "user": user,
        }

        return sign_in_result

    async def google_sign_in(self, sign_in_info: UserLogin):
        user = await self.user_repository.get_by_email(sign_in_info.email)

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

        sign_in_result = {
            "access_token": access_token,
            "expiration": expiration_datetime,
            "user": user,
        }

        return sign_in_result

    async def does_user_exist(self, email: str) -> Union[User, None]:
        """"""
        if email is None or not email:
            raise ValidationError("Email cannot be blank")

        return await self.user_repository.get_by_email(email)

    async def sign_up(self, user_info: CreateUser) -> UserSchema:
        if len(user_info.password) < 6:
            raise ValidationError("Password is too short!")

        user = User(**user_info.model_dump(exclude_none=True),
                    is_active=True, is_admin=False, provider="email")

        user.password = get_password_hash(user_info.password)

        created_user: User

        async with self.db.session() as session:
            created_user = await self.user_repository.create(user)

            # Commit transaction here
            await session.commit()

            delattr(created_user, "password")

            payload = Payload(
                id=str(created_user.id),
                email=created_user.email,
                name=created_user.name,
                is_admin=created_user.is_admin,
            )

            token_lifespan = timedelta(
                minutes=15)

            access_token, _ = create_access_token(
                payload.model_dump(), token_lifespan)

            email_verification: bool = False
            # send email to user
            try:
                await self.user_repository.send_sign_up_verification_email(created_user.email, access_token)
            except Exception as e:
                print("error", e)
                raise e
            finally:
                return UserSchema(**created_user.model_dump(exclude_none=True))

        delattr(created_user, "password")

        return UserSchema(**created_user.model_dump(exclude_none=True))

    async def google_sign_up(self, user_info: GoogleSignIn):
        """Google Login"""
        user_exists: User = await self.user_repository.get_by_email(user_info.email)

        if not user_exists or user_exists is None:
            # register user here
            user = User(**user_info.model_dump(exclude_none=True), is_active=True,
                        is_admin=False, provider="google")

            created_user = await self.user_repository.create(user)

            payload = Payload(
                id=str(created_user.id),
                email=created_user.email,
                name=created_user.name,
                is_admin=created_user.is_admin,
            )

            token_lifespan = timedelta(
                minutes=configs.ACCESS_TOKEN_EXPIRE_MINUTES)

            access_token, expiration_datetime = create_access_token(
                payload.model_dump(), token_lifespan)

            google_signup_result = {
                "access_token": access_token,
                "expiration": expiration_datetime,
                "user": created_user,
            }

            return google_signup_result

        return self.sign_in(sign_in_info=SignIn(email=user_info.email))

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

        verification_data = {
            "id": token_id,
            "email": email,
            "token": token
        }

        # Plain text content
        text = """\
        Hi,
        Thanks for signing up on BTM Ghana!
        To complete your registration, please click on the link below to verify your email address:
        
        http://127.0.0.1:5173/verify?token={0}
        
        If you didn't request this email, please ignore it.
        
        Best regards,
        BTM Ghana
        btmghana.net
        """.format(token_id)

        # Create MIMEText object
        message = MIMEText(text, "plain")
        message["Subject"] = "BTM Ghana - Email Verification"
        message["From"] = configs.SENDER_EMAIL
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

            redis_client.set(token_id, verification_data,
                             expiry_seconds=60*expiration_time)
            return True
        except Exception as e:
            raise e

        return False

    async def reset_password(self, email: EmailStr):
        """"""

    async def verify_user_sign_up(self, token: str) -> bool:
        """Verify a user's account after sign up"""
        from app.util.redis import redis_client

        verification_data = redis_client.get(token)

        if verification_data is None:
            return False

        user = await self.user_repository.get_by_email(verification_data['email'])

        if user is None:
            return False

        user.email_verified = True

        update_user = await self.user_repository.update(user, updated_fields={"email_verified": True})

        if update_user is None:
            return False
        
        redis_client.delete(token)

        return True
