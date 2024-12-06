#!/usr/bin/env python3
# File: user_schema.py
# Author: Oluwatobiloba Light
"""User Schema"""


from datetime import datetime
import re
from typing import Optional
from uuid import UUID
from fastapi import HTTPException
from pydantic import BaseModel, EmailStr, Field, ValidationError, field_validator
from app.schema.user_schema import UserSchema


class SignIn(BaseModel):
    email: str
    password: Optional[str] = Field(default=None)


class CreateUser(BaseModel):
    name: str = Field(min_length="2")
    email: EmailStr = Field(..., description="user email",
                            example="johndoe@example.com")
    password: str

    class Config:
        error_msg_templates = {
            'value_error.email': 'email address is not valid.',
        }


class UserLogin(BaseModel):
    email: str = Field(
        ...,  # ... means required
        description="User's email address",
        error_messages={
            "required": "Email is required to log in",
            "type_error": "Email must be a valid string",
            "value_error": "Please provide a valid email address"
        }
    )

    password: Optional[str]

    @field_validator('email')
    def validate_email(cls, v):
        email_regex = r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$"

        if not re.match(email_regex, v):
            raise ValueError('Invalid email address')
        if not v:
            raise ValueError("Email cannot be empty")
        if not "@" in v:
            raise ValueError("Invalid email format")
        return v

    # @field_validator('password')
    # def password_must_be_strong(cls, v):
    #     if len(v) < 8:
    #         raise ValueError("Password must be at least 8 characters long")
    #     if not any(c.isupper() for c in v):
    #         raise ValueError(
    #             "Password must contain at least one uppercase letter")
    #     return v

    class Config:
        from_attributes = True


class GoogleSignIn(BaseModel):
    # iss: str
    email: str
    email_verified: Optional[bool]
    name: str
    # family_name: Optional[str]
    # given_name: Optional[str]
    # aud: str
    # iat: int
    # exp: int

class GoogleCallbackData(BaseModel):
    code: str
    state: str

class Payload(BaseModel):
    id: str
    email: str
    name: str
    is_admin: bool


class SignInResponse(BaseModel):
    access_token: str
    expiration: datetime
    user_info: UserSchema


class SignUpResponse(BaseModel):
    new_user: UserSchema
    
class VerifyUser(BaseModel):
    token: str