#!/usr/bin/env python3
# File: app/schemas/inclusion_schema.py
# Author: Oluwatobiloba Light
"""Tour Package Inclusion Schema"""

from typing import Optional, Union
from uuid import UUID
from pydantic import BaseModel, Field

from app.model.tour_package import TourPackage


# Inclusion schema here
class CreateInclusionSchema(BaseModel):
    description: str = Field(..., min_length=1)


class InclusionSchema(BaseModel):
    id: UUID
    description: str

    tour_package_id: UUID
    tour_package: Optional[TourPackage]
