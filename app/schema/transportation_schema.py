#!/usr/bin/env python3
# File: transportation_schema.py
# Author: Oluwatobiloba Light
"""Transportation Schema"""

from typing import Union
from pydantic import BaseModel
from app.schema.base_schema import ModelBaseInfo


class CreateTransportation(BaseModel):
    name: str
    price: float = 0
