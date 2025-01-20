#!/usr/bin/env python3
# File: /model/personal_package_payment.py
# Author: Oluwatobiloba Light
"""Personal Package Payment Model"""
import enum
from typing import List, Union
from uuid import UUID
from sqlalchemy import Column, Enum, ForeignKey, ForeignKeyConstraint, Integer, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship
from app.model.user import User


class PackagePaymentStatusType(str, enum.Enum):
    """Tour Package payment Type"""
    FLUTTERWAVE = "Flutterwave"
    STRIPE = "Stripe"


PackagePaymentStatusTypeEnum: Enum = Enum(
    PackagePaymentStatusType,
    name="payment_status_type_enum",
    create_constraint=True,
    metadata=BaseModel.metadata,
    validate_strings=True,
)


class PersonalPackagePayment(BaseModel, table=True):
    __tablename__: str = "personal_package_payment"

    transaction_ref: str = Field(sa_column=Column("transaction_ref",
                                                  String(255), default=None, nullable=False, unique=True))

    payment_ref: Union[str, None] = Field(sa_column=Column(
        "payment_ref", String(255), default=None, nullable=True, unique=True))

    user_id: UUID = Field(sa_column=Column(
        "user_id", ForeignKey(column="users.id", ondelete="CASCADE")))

    user: User = Relationship(back_populates="payments")

    payment_gateway: PackagePaymentStatusType = Field(sa_column=Column(
        "payment_gateway", PackagePaymentStatusTypeEnum, default=PackagePaymentStatusType.FLUTTERWAVE))

    amount: int = Field(sa_column=Column("amount",
                                         Integer, default=None, nullable=False))

    currency: str = Field(sa_column=Column("currency",
                                           String(255), default=None, nullable=False))

    tour_package_id: UUID = Field(sa_column=Column(
        "tour_package_id", ForeignKey(column="user_tour_packages.id")))

    tour_package: "TourPackage" = Relationship(back_populates="payment")

    # __table_args__ = (
    #     ForeignKeyConstraint(
    #         ['tour_package_id'],
    #         ['user_tour_packages.id'],
    #         name='fk_personal_package_payment_tour_package',  # Add a name
    #         deferrable=True,
    #         initially='deferred'
    #     ),
    # )
