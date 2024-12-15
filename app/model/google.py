#!/usr/bin/env python3
# File: google.py
# Author: Oluwatobiloba Light
"""Google Verification Model"""


from sqlalchemy import Column, String
from sqlmodel import Field
from app.model.base_model import BaseModel


class GoogleVerification(BaseModel, table=True):
    __tablename__: str = 'google_verification'

    # code: str = Field(sa_column=Column("code",
    #                                    String(255), default=None, nullable=False))

    state: str = Field(sa_column=Column("state",
                                        String(255), default=None, nullable=False))
    
    auth_type: str = Field(sa_column=Column("auth_type",
                                        String(255), default=None, nullable=False))
