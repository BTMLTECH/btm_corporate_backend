#!/usr/bin/env python3
# File: accommodation_schema.py
# Author: Oluwatobiloba Light
"""Accommodation Schema"""

from typing import Union
from pydantic import BaseModel
from app.schema.base_schema import ModelBaseInfo


class CreateAccommodation(BaseModel):
    name: str
    type: Union[str, None] = None
    price: float = 0
