#!/usr/bin/env python3
# File: app/model/user_tour_package_payment.py
# Author: Oluwatobiloba Light
# Date created: 23/04/2025
"""User Tour Package Payment model"""

from app.model.base_model import BaseModel
from uuid import UUID
from sqlalchemy import Column, ForeignKey
from sqlmodel import Field


class UserTourPackagePaymentLink(BaseModel, table=True):
    __tablename__: str = "user_tour_package_payments"


    user_tour_package_id: UUID = Field(
        sa_column=Column("user_tour_package_id", ForeignKey(
            "user_tour_packages.id", ondelete="CASCADE")),
    )

    payment_id: UUID = Field(
        sa_column=Column("payment_id", ForeignKey(
            "user_payment.id", ondelete="CASCADE")),
    )
