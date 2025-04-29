#!/usr/bin/env python3
# File: app/schemas/itinerary_package_schema.py
# Author: Oluwatobiloba Light
"""Tour Package Itinerary Schema"""

from typing import Optional, Union
from uuid import UUID
from pydantic import BaseModel, Field

from app.model.tour_package import TourPackage


# Itinerary schema here
class CreateItinerarySchema(BaseModel):
    day_number: int
    title: Union[str, None] = None
    description: str = Field(..., min_length=1)
    


class ItinerarySchema(BaseModel):
    id: UUID

    day_number: int
    title: Optional[str]
    description: str
    
    tour_package_id: UUID
    tour_package: Optional[TourPackage]