#!/usr/bin/env python3
# File: model/transportation.py
# Author: Oluwatobiloba Light
"""Transportation Database model"""


from sqlalchemy import Column, Float, String
from sqlmodel import Field
from app.model.base_model import BaseModel


class Transportation(BaseModel, table=True):
    __tablename__: str = "transportation"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False, unique=True))

    price: float = Field(sa_column=Column(Float, default=0, nullable=False))
