#!/usr/bin/env python3
# File: model/tour_package_activity.py
# Author: Oluwatobiloba Light
"""Tour Package Activity Link Model"""
from uuid import UUID
from sqlalchemy import Column, ForeignKey
from app.model.base_model import BaseModel
from sqlmodel import Field


class TourPackageActivityLink(BaseModel, table=True):
    __tablename__: str = "tour_package_activities"

    tour_package_id: UUID = Field(
        sa_column=Column("tour_package_id", ForeignKey(
            column="user_tour_packages.id", ondelete="CASCADE")),
    )
    activity_id: UUID = Field(
        sa_column=Column("activity_id", ForeignKey(
            column="activities.id", ondelete="CASCADE")),
    )
