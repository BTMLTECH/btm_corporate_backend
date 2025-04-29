#!/usr/bin/env python3
# File: app/model/itinerary.py
# Author: Oluwatobiloba Light
# Date created: 28/04/2025 08:04PM

"""A tour package itinerary model"""


from typing import Optional
from uuid import UUID
from sqlalchemy import Column, Integer, ForeignKey, Text, String
from sqlmodel import Field, Relationship
from app.model.base_model import BaseModel


class Itinerary(BaseModel, table=True):
    __tablename__: str = "itineraries"

    tour_package_id: UUID = Field(
        sa_column=Column(
            "tour_package_id", ForeignKey(column="tour_packages.id", ondelete="CASCADE")
        )
    )

    title: Optional[str] = Field(
        sa_column=Column(String(255), nullable=True, default=None)
    )

    day_number: int = Field(sa_column=Column(Integer, nullable=False))
    description: str = Field(sa_column=Column(Text, nullable=False))

    # --- Relationships ---
    tour_package: Optional["TourPackage"] = Relationship(back_populates="itineraries")
