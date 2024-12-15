#!/usr/bin/env python3
# File: package.py
# Author: Oluwatobiloba Light
"""Package Model"""


from datetime import datetime, timedelta
from uuid import UUID, uuid4
from pydantic import EmailStr
from sqlalchemy import Boolean, Column, DateTime, String, Boolean, text
from sqlalchemy.sql import func
from sqlmodel import Field
from app.model.base_model import BaseModel


class UserVerification(BaseModel, table=True):
    __tablename__: str = 'packages'

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False))
