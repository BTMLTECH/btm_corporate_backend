#!/usr/bin/env python3
# File: activity_schema.py
# Author: Oluwatobiloba Light
"""Activity Schema"""

from typing import Union
from uuid import UUID
from pydantic import BaseModel

from app.model.tour_sites_region import TourSitesRegion
from app.schema.base_schema import ModelBaseInfo


class CreateActivity(BaseModel):
    name: str
    description: Union[str, None] = None
    price: float = 0
    tour_sites_region_id: UUID


class ActivitySchema(ModelBaseInfo):
    name: str
    description: Union[str, None] = None
    price: float = 0
    tour_sites_region_id: UUID
    tour_sites_region: TourSitesRegion
