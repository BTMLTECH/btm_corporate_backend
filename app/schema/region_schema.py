#!/usr/bin/env python3
# File: region_schema.py
# Author: Oluwatobiloba Light
"""Region Schema"""

from typing import Union
from uuid import UUID
from pydantic import BaseModel
from app.schema.base_schema import ModelBaseInfo


class CreateRegion(BaseModel):
    name: str


class RegionSchema(ModelBaseInfo):
    id: UUID
    name: str


class UpdateRegion(BaseModel):
    name: Union[str, None] = None
