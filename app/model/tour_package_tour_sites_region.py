#!/usr/bin/env python3
# File: model/tour_package_activity.py
# Author: Oluwatobiloba Light
"""Tour Package Activity Link Model"""
from uuid import UUID
from sqlalchemy import Column, ForeignKey
from app.model.base_model import BaseModel
from sqlmodel import Field


class TourPackageTourSitesRegionLink(BaseModel, table=True):
    __tablename__: str = "tour_package_tour_sites_region"

    tour_package_id: UUID = Field(
        sa_column=Column("tour_package_id", ForeignKey(
            "user_tour_packages.id", ondelete="CASCADE")),
    )
    tour_sites_region_id: UUID = Field(
        sa_column=Column("tour_sites_region_id", ForeignKey(
            "tour_sites_region.id", ondelete="CASCADE")),
    )
