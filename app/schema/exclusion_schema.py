#!/usr/bin/env python3
# File: app/schemas/exclusion_schema.py
# Author: Oluwatobiloba Light
"""Tour Package IExclusion Schema"""

from typing import Optional, Union
from uuid import UUID
from pydantic import BaseModel, Field

from app.model.tour_package import TourPackage


# Exclusion schema here
class CreateExclusionSchema(BaseModel):
    description: str = Field(..., min_length=1)


class ExclusionSchema(BaseModel):
    id: UUID
    description: str

    tour_package_id: UUID
    tour_package: Optional[TourPackage]
