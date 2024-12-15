#!/usr/bin/env python3
# File: activity.py
# Author: Oluwatobiloba Light
"""Activity Model"""
from sqlalchemy import Column, Float, String
from app.model.base_model import BaseModel
from sqlmodel import Field


class Activity(BaseModel, table=True):
    __tablename__: str = "activities"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False, unique=True))
    
    description: str = Field(sa_column=Column("description",
                                       String(2000), default=None, nullable=True))
    
    price: str = Field(sa_column=Column("price",
                                       Float, default=0, nullable=False))
