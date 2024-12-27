#!/usr/bin/env python3
# File: region.py
# Author: Oluwatobiloba Light
"""Tour Package Model"""

from typing import List
from uuid import UUID
from sqlalchemy import Column, Date, DateTime, ForeignKey, Integer, String, func, text
from sqlmodel import Field, Relationship
from app.model.accommodation import Accommodation
from app.model.base_model import BaseModel
from app.model.region import Region
from app.model.tour_package_accommodation import TourPackageAccommodationLink
from app.model.tour_package_activity import TourPackageActivityLink
from app.model.tour_package_tour_sites_region import TourPackageTourSitesRegionLink
from app.model.tour_package_transportation import TourPackageTransportationLink
from app.model.user import User
from datetime import datetime, date, timedelta
from sqlalchemy.sql import func


class TourPackage(BaseModel, table=True):
    __tablename__: str = "tour_packages"

    user_id: UUID = Field(sa_column=Column(
        "user_id", ForeignKey(column="users.id", ondelete="CASCADE")))

    user: User = Relationship(back_populates="tour_packages")

    region_id: UUID = Field(sa_column=Column(
        "region_id", ForeignKey(column="regions.id", ondelete="CASCADE")))

    region: Region = Relationship(back_populates="tour_packages")

    tour_sites_region: List["TourSitesRegion"] = Relationship(
        back_populates="tour_packages", link_model=TourPackageTourSitesRegionLink)

    accommodation_id: UUID = Field(sa_column=Column(
        "accommodation_id", ForeignKey(column="accommodations.id", ondelete="CASCADE")))

    accommodation: Accommodation = Relationship(
        back_populates="tour_packages", link_model=TourPackageAccommodationLink)

    # transportations: List["Transportation"] = Relationship(link_model=TourPackageTransportationLink)

    no_of_people_attending: int = Field(sa_column=Column(
        "no_of_people_attending", Integer, default=1, nullable=False))

    start_date: date = Field(sa_column=Column(
        "start_date", Date, server_default=func.current_date()))

    end_date: date = Field(sa_column=Column(
        "end_date", Date, server_default=text("CURRENT_DATE + INTERVAL '3 days'")))

    activities: List["Activity"] = Relationship(
        back_populates="tour_packages", link_model=TourPackageActivityLink)

    transportation: List["Transportation"] = Relationship(
        back_populates="tour_packages", link_model=TourPackageTransportationLink)
