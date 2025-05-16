#!/usr/bin/env python3
# File: app/schemas/terms_condition_schema.py
# Author: Oluwatobiloba Light
"""Tour Package Terms & Conditions Schema"""

from typing import Optional, Union
from uuid import UUID
from pydantic import BaseModel, Field

from app.model.tour_package import TourPackage


# Terms &Condition schema here
class CreateTermsConditionsSchema(BaseModel):
    title: Union[str, None] = None
    description: str = Field(..., min_length=1)
    


class TermsConditionSchema(BaseModel):
    id: UUID

    title: Optional[str]
    description: str
    
    tour_package_id: UUID
    tour_package: Optional[TourPackage]