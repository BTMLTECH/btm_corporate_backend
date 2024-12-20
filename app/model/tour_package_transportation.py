#!/usr/bin/env python3
# File: model/tour_package_activity.py
# Author: Oluwatobiloba Light
"""Tour Package Activity Link Model"""
from uuid import UUID
from sqlalchemy import Column, ForeignKey
from app.model.base_model import BaseModel
from sqlmodel import Field


class TourPackageTransportationLink(BaseModel, table=True):
    __tablename__: str = "tour_package_transportations"

    tour_package_id: UUID = Field(
        sa_column=Column("tour_package_id", ForeignKey(
            "tour_packages.id", ondelete="CASCADE")),
    )
    transportation_id: UUID = Field(
        sa_column=Column("transportation_id", ForeignKey(
            "transportation.id", ondelete="CASCADE")),
    )
