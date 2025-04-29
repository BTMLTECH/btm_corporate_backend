#!/usr/bin/env python3
# File: app/schema/destination_schema.py
# Author: Oluwatobiloba Light
# Date created: 29/04/2025
"""Destination Schema"""

from typing import List, Optional
from pydantic import BaseModel

from app.model.region import Region
from app.model.tour_package import TourPackage

class CreatedDestinationSchema(BaseModel):
    name: str
    # tour_packages: Optional[List[TourPackage]]
    # regions: Optional[List[Region]]

class DestinationSchema(BaseModel):
    name: str
    tour_packages: Optional[List[TourPackage]]
    regions: Optional[List[Region]]


class CreateDestinationSchema(BaseModel):
    name: str