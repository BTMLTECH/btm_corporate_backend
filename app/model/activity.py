#!/usr/bin/env python3
# File: activity.py
# Author: Oluwatobiloba Light
"""Activity Model"""
from typing import List
from sqlalchemy import Column, Float, ForeignKey, String, UniqueConstraint
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship
from app.model.tour_package_activity import TourPackageActivityLink
from uuid import UUID

from app.model.tour_sites_region import TourSitesRegion


class Activity(BaseModel, table=True):
    __tablename__: str = "activities"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False))

    description: str = Field(sa_column=Column("description",
                                              String(2000), default=None, nullable=True))

    price: float = Field(sa_column=Column("price",
                                          Float, default=0, nullable=False))

    tour_sites_region_id: UUID = Field(sa_column=Column(
        "tour_sites_region_id", ForeignKey(column="tour_sites_region.id", ondelete="CASCADE"), index=True))

    # Many-to-One relationship with Region
    tour_sites_region: List[TourSitesRegion] = Relationship(
        back_populates="activities")

    tour_packages: List["TourPackage"] = Relationship(
        back_populates="activities", link_model=TourPackageActivityLink)

    __table_args__ = (UniqueConstraint(
        "name", "tour_sites_region_id", name="uq_name_region"),)
