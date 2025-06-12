#!/usr/bin/env python3
# File: package.py
# Author: Oluwatobiloba Light
"""Tour Package Model"""

from typing import Optional, List
from sqlalchemy import (
    Boolean,
    Column,
    Numeric,
    String,
    Text,
    Integer,
    Float,
    DECIMAL,
    Enum,
)
from sqlmodel import Field, Relationship
from app.model.base_model import BaseModel
from app.model.destination_tour_package import DestinationTourPackageLink
import enum


class TourPackagePriceType(str, enum.Enum):
    PER_PERSON = "PER_PERSON"
    PER_FAMILY = "PER_FAMILY"


TourPackagePriceTypeEnum: Enum = Enum(
    TourPackagePriceType,
    name="tour_package_price_type_enum",
    create_constraint=True,
    metadata=BaseModel.metadata,
    validate_strings=True,
)


class TourPackage(BaseModel, table=True):
    __tablename__: str = "tour_packages"

    title: str = Field(sa_column=Column(String(255), nullable=False))
    slug: str = Field(sa_column=Column(String(255), nullable=False, unique=True))
    description: Optional[str] = Field(sa_column=Column(Text, default=None))

    duration_days: int = Field(sa_column=Column(Integer, nullable=False))
    duration_nights: int = Field(sa_column=Column(Integer, nullable=False))

    currency: Optional[str] = Field(
        sa_column=Column(String(10), nullable=True, default="USD")
    )

    price_per_family_usd: Optional[float] = Field(
        sa_column=Column(Numeric(10, 2), nullable=True, default=None)
    )

    price_per_person_usd: Optional[float] = Field(
        sa_column=Column(Numeric(10, 2), nullable=True, default=None)
    )

    number_of_travelers: Optional[int] = Field(
        sa_column=Column(Integer, nullable=False, default=1)
    )

    traveler_adults: int = Field(sa_column=Column(Integer, nullable=False, default=1))
    traveler_children: int = Field(sa_column=Column(Integer, nullable=True, default=0))

    is_group_pricing: Optional[bool] = Field(
        sa_column=Column(Boolean, nullable=True, default=None)
    )

    destinations: List[str] = Field(sa_column=Column(Text), default=[])

    accommodation_details: Optional[str] = Field(sa_column=Column(Text, default=None))
    meals_included: Optional[str] = Field(sa_column=Column(Text, default=None))

    transport_info: Optional[str] = Field(sa_column=Column(Text, default=None))

    price_type: Optional[TourPackagePriceType] = Field(
        sa_column=Column(
            Enum(TourPackagePriceType, name="tour_package_price_type_enum"),
            default=None,
            nullable=True,
        )
    )

    package_type: str = Field(sa_column=Column(String(50), nullable=False))

    thumbnail_url: str = Field(sa_column=Column(String(255), nullable=False))

    images_url: Optional[List[str]] = Field(sa_column=Column(Text, default=None))

    # relationships here
    destinations: List["Destination"] = Relationship(
        back_populates="tour_packages",
        link_model=DestinationTourPackageLink,
        sa_relationship_kwargs={"cascade": "all, delete"},
    )

    itineraries: Optional[List["Itinerary"]] = Relationship(
        back_populates="tour_package", sa_relationship_kwargs={"cascade": "all, delete"}
    )

    inclusions: Optional[List["Inclusion"]] = Relationship(
        back_populates="tour_package", sa_relationship_kwargs={"cascade": "all, delete"}
    )

    exclusions: Optional[List["Exclusion"]] = Relationship(
        back_populates="tour_package", sa_relationship_kwargs={"cascade": "all, delete"}
    )

    terms_conditions: Optional[List["TermsConditions"]] = Relationship(
        back_populates="tour_package", sa_relationship_kwargs={"cascade": "all, delete"}
    )
    # contact_phone: Optional[str] = Field(sa_column=Column(String(50), default=None))
    # contact_email: Optional[str] = Field(sa_column=Column(String(100), default=None))

    # ForeignKey relationship (Many packages can belong to one region)
    # region_id: Optional[str] = Field(foreign_key="regions.id, default=None")
    # region: Optional["Region"] = Relationship(back_populates="tour_packages")
