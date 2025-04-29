#!/usr/bin/env python3
# File: app/mode/inclusion.py
# Author: Oluwatobiloba Light
# Date created: 29/05/2025
"""Tour package Inclusion model"""


from typing import Optional
from uuid import UUID
from sqlalchemy import Column, ForeignKey, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship


class Inclusion(BaseModel, table=True):
    ___tablename__: str = "tour_package_inclusions"

    description: str = Field(
        sa_column=Column("description", String(2048), nullable=False, default=None)
    )

    tour_package_id: UUID = Field(
        sa_column=Column(
            "tour_package_id", ForeignKey(column="tour_packages.id", ondelete="CASCADE")
        )
    )

     # --- Relationships ---
    tour_package: Optional["TourPackage"] = Relationship(back_populates="inclusions")

