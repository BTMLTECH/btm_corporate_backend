#!/usr/bin/env python3
# File: region.py
# Author: Oluwatobiloba Light
"""Region Model"""
from typing import List, Optional
from uuid import UUID
from sqlalchemy import Column, ForeignKey, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship


class Region(BaseModel, table=True):
    __tablename__: str = "regions"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False, unique=True))

    # One-to-Many relationship with SitesInRegion
    sites: List["TourSitesRegion"] = Relationship(back_populates="region")

    # tour_packages: List["TourPackage"] = Relationship(back_populates="region")

    destination_id: Optional[UUID] = Field(
        sa_column=Column("destination_id", ForeignKey(column="destinations.id")),
        default=None,
    )

    destination: Optional["Destination"] = Relationship(back_populates="regions")
    
