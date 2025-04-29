#!/usr/bin/env python3
# File: app/model/user_payment.py
# Author: Oluwatobiloba Light
"""User Payment Model"""


from uuid import UUID
from pydantic import EmailStr
from sqlmodel import Field, Relationship
from sqlalchemy import Column, ForeignKey, String
from datetime import datetime

from app.model.base_model import BaseModel
from app.model.user import User
from app.model.user_tour_package_payment import UserTourPackagePaymentLink


class UserPayment(BaseModel, table=True):
    __tablename__: str = "user_payment"

    payment_date: datetime = Field(default=None)

    currency: str = Field(sa_column=Column("currency", String(3), default=None))

    amount: int = Field(default=None)

    email_address: EmailStr = Field(
        sa_column=Column("email_address", String(255), default=None)
    )

    user_id: UUID = Field(
        sa_column=Column("user_id", ForeignKey(column="users.id", ondelete="CASCADE"))
    )

    user: User = Relationship(back_populates="payments")

    tx_ref: str = Field(
        sa_column=Column("tx_ref", String(255), default=None, nullable=False)
    )

    user_tour_package: "UserTourPackage" = Relationship(
        back_populates="payment", link_model=UserTourPackagePaymentLink
    )
