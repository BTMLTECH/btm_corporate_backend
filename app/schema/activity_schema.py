#!/usr/bin/env python3
# File: activity_schema.py
# Author: Oluwatobiloba Light
"""Activity Schema"""

from typing import Union
from pydantic import BaseModel
from app.schema.base_schema import ModelBaseInfo


class CreateActivity(BaseModel):
    name: str
    description: Union[str, None] = None
    price: float = 0
