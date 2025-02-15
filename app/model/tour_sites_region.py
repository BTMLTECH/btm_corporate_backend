#!/usr/bin/env python3
# File: model/tourist_sites_region.py
# Author: Oluwatobiloba Light
"""Tourist sites in regions Model"""
from typing import List, Optional
from uuid import UUID
from sqlalchemy import Column, Float, ForeignKey, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship
from app.model.region import Region
from app.model.tour_package_tour_sites_region import TourPackageTourSitesRegionLink


class TourSitesRegion(BaseModel, table=True):
    __tablename__: str = "tour_sites_region"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False, unique=True))

    description: str = Field(sa_column=Column("description",
                                              String(2000), default=None, nullable=True))

    price: float = Field(sa_column=Column("price",
                                          Float, default=0, nullable=False))

    region_id: UUID = Field(sa_column=Column(
        "region_id", ForeignKey(column="regions.id", ondelete="CASCADE")))

    # Many-to-One relationship with Region
    region: Region = Relationship(back_populates="sites")

    tour_packages: List["TourPackage"] = Relationship(back_populates="tour_sites_region", link_model=TourPackageTourSitesRegionLink)

