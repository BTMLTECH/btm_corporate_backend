#!/usr/bin/env python3
# File: model/transportation.py
# Author: Oluwatobiloba Light
"""Transportation Database model"""


from typing import List
from sqlalchemy import Column, Float, String
from sqlmodel import Field, Relationship
from app.model.base_model import BaseModel
from app.model.tour_package_transportation import TourPackageTransportationLink


class Transportation(BaseModel, table=True):
    __tablename__: str = "transportation"

    name: str = Field(sa_column=Column("name",
                                       String(255), default=None, nullable=False, unique=True))

    price: float = Field(sa_column=Column(Float, default=0, nullable=False))

    tour_packages: List["TourPackage"] = Relationship(back_populates="transportation", link_model=TourPackageTransportationLink)
