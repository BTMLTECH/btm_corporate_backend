#!/usr/bin/env python3
# File: region_schema.py
# Author: Oluwatobiloba Light
"""Region Schema"""

from pydantic import BaseModel
from app.schema.base_schema import ModelBaseInfo


class CreateRegion(BaseModel):
    name: str


class RegionSchema(ModelBaseInfo):
    name: str