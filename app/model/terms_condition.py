#!/usr/bin/env python3
# File: app/mode/terms_condition.py
# Author: Oluwatobiloba Light
# Date created: 29/05/2025
"""Tour package terms and conditions model"""


from typing import Optional
from uuid import UUID
from sqlalchemy import Column, ForeignKey, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship


class TermsConditions(BaseModel, table=True):
    ___tablename__: str = "terms_conditions"

    title: Optional[str] = Field(
        sa_column=Column("title",String(50), nullable=True, default=None)
    )

    description: str = Field(
        sa_column=Column("description", String(2048), nullable=False, default=None)
    )

    tour_package_id: UUID = Field(
        sa_column=Column(
            "tour_package_id", ForeignKey(column="tour_packages.id", ondelete="CASCADE")
        )
    )

     # --- Relationships ---
    tour_package: Optional["TourPackage"] = Relationship(back_populates="terms_conditions")

