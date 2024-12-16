#!/usr/bin/env python3
# File: model/tourist_sites_region.py
# Author: Oluwatobiloba Light
"""Tourist sites in regions Model"""
from typing import Optional
from uuid import UUID
from sqlalchemy import Column, Float, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship
from app.model.region import Region


class TouristSitesRegion(BaseModel, table=True):
    __tablename__: str = "tourist_sites_region"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False, unique=True))
    
    description: str = Field(sa_column=Column("description",
                                       String(2000), default=None, nullable=True))
    
    price: float = Field(sa_column=Column("price",
                                       Float, default=0, nullable=False))
    
    region_id: UUID = Field(default=None, foreign_key="regions.id", nullable=False)

    # Many-to-One relationship with Region
    region: Region = Relationship(back_populates="sites")
