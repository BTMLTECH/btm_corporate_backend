#!/usr/bin/env python3
# File: user.py
# Author: Oluwatobiloba Light
"""User Model"""


from datetime import datetime, timedelta
from typing import List
from uuid import UUID, uuid4
from pydantic import EmailStr
from sqlalchemy import Boolean, Column, DateTime, String, Boolean, text
from sqlalchemy.sql import func
from sqlmodel import Field, Relationship
from app.model.base_model import BaseModel


# class BaseMixin(object):
#     @classmethod
#     def create(cls, **kw: 'User'):
#         print("creating...")
#         pass


class User(BaseModel, table=True):
    __tablename__: str = 'users'

    name: str = Field(sa_column=Column("name", String(255), nullable=False))

    email: EmailStr = Field(sa_column=Column("email",
                                             String(255), unique=True, nullable=False))

    password: str = Field(sa_column=Column("password",
                                           String(255), default=None, nullable=True,))

    phone: str = Field(sa_column=Column("phone",
                                        String(24), default=None, nullable=True,))

    provider: str = Field(sa_column=Column("provider",
                                           String(24), default=None, nullable=True, ))

    email_verified: bool = Field(sa_column=Column("email_verified",
                                                  Boolean, default=False, ))

    address: str = Field(sa_column=Column("address",
                                          String(255), default=None, nullable=True, ))
    
    payments: List["PersonalPackagePayment"] = Relationship(back_populates="user")
    
    # tour_packages: List["TourPackage"] = Relationship(back_populates="user")

    is_admin: bool = Field(sa_column=Column(
        "is_admin", Boolean, default=False, ))

    is_active: bool = Field(sa_column=Column(
        "is_active", Boolean, default=True, ))

    last_login_at: datetime = Field(sa_column=Column("last_login_at", DateTime(
        timezone=True), server_default=func.now()), default_factory=datetime.now)


class UserVerification(BaseModel, table=True):
    __tablename__: str = 'user_verification'

    session_id: UUID = Field(
        default_factory=uuid4,
        primary_key=True,
        nullable=False
    )

    email: EmailStr = Field(sa_column=Column("email",
                                             String(255), unique=True, nullable=False))

    token: str = Field(sa_column=Column("token",
                                        String(350), default=None, nullable=False))

    expires_at: datetime = Field(sa_column=Column("expires_at",
                                                  DateTime(timezone=True), default=lambda: datetime.now() + timedelta(minutes=10), server_default=text("(NOW() AT TIME ZONE 'UTC') + INTERVAL '10 minutes'"), nullable=False))
