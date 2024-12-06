#!/usr/bin/env python3
# File: base_model.py
# Author: Oluwatobiloba Light
"""Base Model"""


from datetime import datetime
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

    # id: UUID = Field(mapped_column(primary_key=True, default=uuid4()))

    # created_at: Mapped[datetime] = Field(mapped_column(
    #     DateTime(timezone=True), server_default=func.now(), default=datetime.now()))

    # # created_at: Mapped[datetime] = mapped_column(
    # #     DateTime(timezone=True), server_default=func.now(), default=datetime.now())

    # updated_at: Mapped[datetime] = Field(mapped_column(
    #     DateTime(timezone=True), onupdate=datetime.now(), server_default=func.now(), default=datetime.now()))

    # deleted_at: Mapped[datetime] = Field(mapped_column(
    #     DateTime(timezone=True), server_default=func.now(), default=None))

    # # updated_at: datetime = Field(sa_column=Column(
    # #     DateTime, onupdate=datetime.now()), default=datetime.now())

    id: UUID = Field(
        default_factory=uuid4,
        primary_key=True,
        nullable=False
    )

    created_at: datetime = Field(
        sa_column=Column(
            DateTime(timezone=True),
            server_default=func.now(),
            nullable=False
        ),
        default_factory=datetime.now
    )

    updated_at: datetime = Field(
        sa_column=Column(
            DateTime(timezone=True),
            server_default=func.now(),
            onupdate=func.now(),
            nullable=False
        ),
        default_factory=datetime.now
    )

    deleted_at: datetime = Field(
        sa_column=Column(
            DateTime(timezone=True),
            nullable=True
        ),
        default=None
    )
