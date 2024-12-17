#!/usr/bin/env python3
# File: base_schema.py
# Author: Oluwatobiloba Light
"""Base Schema"""


from datetime import datetime
from typing import List, Optional, Union
from uuid import UUID
from pydantic import BaseModel, ConfigDict, Field


class ModelBaseInfo(BaseModel):
    # model_config = ConfigDict(
    #     arbitrary_types_allowed=True, from_attributes=True)
    
    id: UUID
    created_at: datetime
    updated_at: datetime
    deleted_at: Union[datetime, None] = None

    class Config:
        model_config = ConfigDict(
            arbitrary_types_allowed=True, from_attributes=True)
        from_attributes = True
        orm_mode = True


class FindBase(BaseModel):
    ordering: Optional[str]
    page: Optional[int]
    page_size: Optional[Union[int, str]]
    pages: Optional[int]
