#!/usr/bin/env python3
# File: base_model.py
# Author: Oluwatobiloba Light
"""Base Model"""


from datetime import datetime
from typing import Optional
from uuid import UUID, uuid4

from pydantic import ConfigDict
from sqlalchemy import Column, DateTime
from sqlmodel import SQLModel, Field
from sqlalchemy.sql import func
from app.core.database import Base


# class MappedUUID(Mapped[UUID]):
#     @classmethod
#     def __get_pydantic_core_schema__(cls, schema_generator):
#         return schema_generator.generate_schema(UUID)

class BaseModel(Base, SQLModel):
    __abstract__ = True

    id: UUID = Field(
        default_factory=uuid4,
        primary_key=True,
        nullable=False
    )

    created_at: datetime = Field(
        default_factory=datetime.now,
        nullable=False,
        sa_column_kwargs={
            'server_default': func.now()
        }
    )

    updated_at: datetime = Field(
        default_factory=datetime.now,
        nullable=False,
        sa_column_kwargs={
            'server_default': func.now(),
            'onupdate': func.now()
        }
    )

    deleted_at: Optional[datetime] = Field(
        default=None,
        nullable=True
    )

    # user_deleted_at: datetime = Field(
    #     sa_column=Column(
    #         "deleted_at",
    #         DateTime(timezone=True),
    #         nullable=True,
    #         default=None
    #     )
    # )
