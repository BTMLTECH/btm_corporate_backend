#!/usr/bin/env python3
# File: accommodation.py
# Author: Oluwatobiloba Light
"""Accommodation Model"""
from sqlalchemy import Column, Float, String
from app.model.base_model import BaseModel
from sqlmodel import Field


class Accommodation(BaseModel, table=True):
    __tablename__: str = "accommodations"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False, unique=True))
    
    type: str = Field(sa_column=Column("type",
                                       String(2000), default=None, nullable=True))
    
    price: float = Field(sa_column=Column("price",
                                       Float, default=0, nullable=False))
