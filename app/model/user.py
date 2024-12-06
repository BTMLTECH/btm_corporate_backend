#!/usr/bin/env python3
# File: user.py
# Author: Oluwatobiloba Light
"""User Model"""


from datetime import datetime
from pydantic import EmailStr
from sqlalchemy import Boolean, Column, DateTime, String, Boolean
from sqlalchemy.sql import func
from sqlmodel import Field
from app.model.base_model import BaseModel


# class BaseMixin(object):
#     @classmethod
#     def create(cls, **kw: 'User'):
#         print("creating...")
#         pass


class User(BaseModel, table=True):
    __tablename__: str = 'users'

    name: str = Field(sa_column=Column(
        String(255), unique=False, nullable=False))

    email: EmailStr = Field(sa_column=Column(
        String(255), unique=True, nullable=False))

    password: str = Field(sa_column=Column(
        String(255), default=None, nullable=True))

    phone: str = Field(sa_column=Column(
        String(24), default=None, nullable=True))

    provider: str = Field(sa_column=Column(
        String(24), default=None, nullable=True))

    email_verified: bool = Field(sa_column=Column(Boolean, default=False))

    address: str = Field(sa_column=Column(
        String(255), default=None, nullable=True)
    )
    is_admin: bool = Field(sa_column=Column(Boolean, default=False))

    is_active: bool = Field(sa_column=Column(Boolean, default=True))

    last_login_at: datetime = Field(sa_column=Column(
        DateTime(timezone=True), server_default=func.now()))
