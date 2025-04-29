#!/usr/bin/env python3
# File: app/model/destination_tour_package.py
# Author: Oluwatobiloba Light
# Date created: 29/05/2025
"""Destination and Region Link Model"""
from uuid import UUID
from sqlalchemy import Column, ForeignKey
from app.model.base_model import BaseModel
from sqlmodel import Field


class DestinationRegionLink(BaseModel, table=True):
    __tablename__: str = "destination_regions"

    region_id: UUID = Field(
        sa_column=Column("region_id", ForeignKey(
            column="regions.id", ondelete="CASCADE")),
    )
    destination_id: UUID = Field(
        sa_column=Column("destination_id", ForeignKey(
            column="destinations.id", ondelete="CASCADE")),
    )
