#!/usr/bin/env python3
# File: package.py
# Author: Oluwatobiloba Light
"""Tour Package Model"""

from typing import Optional, List
from sqlalchemy import Column, Numeric, String, Text, Integer, Float, DECIMAL
from sqlmodel import Field, Relationship
from app.model.base_model import BaseModel
from app.model.destination_tour_package import DestinationTourPackageLink


class TourPackage(BaseModel, table=True):
    __tablename__: str = "tour_packages"

    title: str = Field(sa_column=Column(String(255), nullable=False))
    slug: str = Field(sa_column=Column(String(255), nullable=False, unique=True))
    description: Optional[str] = Field(sa_column=Column(Text, default=None))
    
    duration_days: int = Field(sa_column=Column(Integer, nullable=False))
    duration_nights: int = Field(sa_column=Column(Integer, nullable=False))
    
    price_per_person_usd: float = Field(sa_column=Column(Numeric(10, 2), nullable=False))
    destinations: List[str] = Field(sa_column=Column(Text), default=[])
    
    accommodation_details: Optional[str] = Field(sa_column=Column(Text, default=None))
    meals_included: Optional[str] = Field(sa_column=Column(Text, default=None))
    
    transport_info: Optional[str] = Field(sa_column=Column(Text, default=None))


    package_type: str = Field(sa_column=Column(String(50), nullable=False))

    thumbnail_url: str = Field(sa_column=Column(String(255), nullable=False))

    images_url: Optional[List[str]] = Field(sa_column=Column(Text, default=None))

    # relationships here
    destinations: List["Destination"] = Relationship(back_populates="tour_packages", link_model=DestinationTourPackageLink)
    itineraries: Optional[List["Itinerary"]] = Relationship(back_populates="tour_package")

    inclusions: Optional[List["Inclusion"]] = Relationship(back_populates="tour_package")
    exclusions: Optional[List["Exclusion"]] = Relationship(back_populates="tour_package")

    terms_conditions: Optional[List["TermsCondition"]] = Relationship(back_populates="tour_package")
    # contact_phone: Optional[str] = Field(sa_column=Column(String(50), default=None))
    # contact_email: Optional[str] = Field(sa_column=Column(String(100), default=None))

    # ForeignKey relationship (Many packages can belong to one region)
    # region_id: Optional[str] = Field(foreign_key="regions.id, default=None")
    # region: Optional["Region"] = Relationship(back_populates="tour_packages")
