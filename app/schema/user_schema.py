#!/usr/bin/env python3
# File: user_schema.py
# Author: Oluwatobiloba Light
"""User Schema"""


from datetime import datetime
from typing import Literal, Union
from uuid import UUID
from pydantic import UUID4, BaseModel, EmailStr


class BaseUser(BaseModel):
    # email: str

    # first_name: Optional[str]
    # last_name: Optional[str]

    # is_active: bool
    # is_admin: bool

    # phone_no: Optional[str]

    id: UUID

    created_at: datetime
    updated_at: datetime
    deleted_at: Union[datetime, None] = None
    last_login_at: datetime

    is_active: bool
    is_admin: bool

    class Config:
        from_attributes = True


class UserSchema(BaseUser):
    name: str
    email: EmailStr
    password: Union[str, None] = None
    phone: Union[str, None] = None
    provider: Literal["google", "email"]
    email_verified: bool
    address: Union[str, None] = None
