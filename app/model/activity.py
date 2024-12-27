#!/usr/bin/env python3
# File: activity.py
# Author: Oluwatobiloba Light
"""Activity Model"""
from typing import List
from sqlalchemy import Column, Float, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship
from app.model.tour_package_activity import TourPackageActivityLink


class Activity(BaseModel, table=True):
    __tablename__: str = "activities"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False, unique=True))
    
    description: str = Field(sa_column=Column("description",
                                       String(2000), default=None, nullable=True))
    
    price: float = Field(sa_column=Column("price",
                                       Float, default=0, nullable=False))

    tour_packages: List["TourPackage"] = Relationship(back_populates="activities", link_model=TourPackageActivityLink)
