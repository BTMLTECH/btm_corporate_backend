#!/usr/env/bin python3
# File: app/model/destination.py
# Author: Oluwatobiloba Light
# Date created: 23/04/2025
"""Destinations model"""


from typing import List, Optional
from sqlalchemy import Column, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship

from app.model.destination_region import DestinationRegionLink
from app.model.destination_tour_package import DestinationTourPackageLink


class Destination(BaseModel, table=True):
    __tablename__: str = "destinations"

    name: str = Field(
        sa_column=Column("name", String(255), default=None, nullable=False, unique=True)
    )

    tour_packages: Optional[List["TourPackage"]] = Relationship(
        back_populates="destinations", link_model=DestinationTourPackageLink
    )

    regions: Optional[List["Region"]] = Relationship(back_populates="destination", link_model=DestinationRegionLink)
