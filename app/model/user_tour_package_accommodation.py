#!/usr/bin/env python3
# File: model/tour_package_accommodation.py
# Author: Oluwatobiloba Light
"""Tour Package Accommodation Link Model"""
from uuid import UUID
from sqlalchemy import Column, ForeignKey
from app.model.base_model import BaseModel
from sqlmodel import Field


class UserTourPackageAccommodationLink(BaseModel, table=True):
    __tablename__: str = "user_tour_package_accommodations"

    user_tour_package_id: UUID = Field(
        sa_column=Column("user_tour_package_id", ForeignKey(
            column="user_tour_packages.id", ondelete="CASCADE")),
    )
    accommodation_id: UUID = Field(
        sa_column=Column("accommodation_id", ForeignKey(
            column="accommodations.id", ondelete="CASCADE")),
    )
