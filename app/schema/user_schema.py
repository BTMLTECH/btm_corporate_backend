#!/usr/bin/env python3
# File: user_schema.py
# Author: Oluwatobiloba Light
"""User Schema"""


from datetime import datetime
from typing import Literal, Union
from uuid import UUID
from pydantic import UUID4, BaseModel, EmailStr


class BaseUser(BaseModel):
    id: UUID4

    created_at: datetime
    updated_at: datetime
    deleted_at: Union[datetime, None] = None
    last_login_at: datetime

    is_active: bool
    is_admin: bool

    class Config:
        from_attributes = True

class UserModel(BaseUser):
    name: str
    email: EmailStr


class UserCredentials(BaseModel):
    email: EmailStr
    password: str


class UserSchema(BaseUser):
    id: UUID
    name: str
    email: EmailStr
    password: Union[str, None] = None
    phone: Union[str, None] = None
    provider: Literal["google", "email"]
    email_verified: bool
    address: Union[str, None] = None


class UserVerificationSchema(BaseModel):
    session_id: str
    token: str
    email: EmailStr

    class Config:
        from_attributes = True


class CreateUser(UserCredentials):
    name: str

class UpdateUser(BaseModel):
    name: Union[str, None] = None
    password: Union[str, None] = None
    phone: Union[str, None] = None
    address: Union[str, None] = None
