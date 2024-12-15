#!/usr/bin/env python3
# File: activity_schema.py
# Author: Oluwatobiloba Light
"""Activity Schema"""

from pydantic import BaseModel
from app.schema.base_schema import ModelBaseInfo


class CreateActivity(BaseModel):
    name: str
