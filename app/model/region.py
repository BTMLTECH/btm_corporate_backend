#!/usr/bin/env python3
# File: region.py
# Author: Oluwatobiloba Light
"""Region Model"""
from typing import List
from sqlalchemy import Column, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship


class Region(BaseModel, table=True):
    __tablename__: str = "regions"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False, unique=True))

    # One-to-Many relationship with SitesInRegion
    sites: List["TourSitesRegion"] = Relationship(back_populates="region")

    tour_packages: List["TourPackage"] = Relationship(back_populates="region")
