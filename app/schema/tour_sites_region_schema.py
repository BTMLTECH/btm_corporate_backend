#!/usr/bin/env python3
# File: tour_sites_schema.py
# Author: Oluwatobiloba Light
"""TourSitesRegion Schema"""

from typing import Union
from uuid import UUID
from pydantic import BaseModel
from app.schema.base_schema import ModelBaseInfo
from app.schema.region_schema import RegionSchema


class CreateTourSitesRegion(BaseModel):
    name: str
    description: Union[str, None] = None
    price: float = 0
    region_id: UUID

class UpdateTourSitesRegion(BaseModel):
    name: Union[str, None] = None
    description: Union[str, None] = None
    price: Union[float, None] = None

class TourSitesRegionSchema(BaseModel):
    name: str
    description: Union[str, None] = None
    price: float = 0
    region_id: UUID
    region: RegionSchema
