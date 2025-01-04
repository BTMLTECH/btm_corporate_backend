#!/usr/bin/env python3
# File: /model/personal_package_payment.py
# Author: Oluwatobiloba Light
"""Flutterwave Payment Model"""
from typing import List, Union
from uuid import UUID
from sqlalchemy import Column, ForeignKey, Integer, String
from app.model.base_model import BaseModel
from sqlmodel import Field, Relationship
from app.model.user import User


class FlutterwavePayment(BaseModel, table=True):
    __tablename__: str = "flutterwave_payment"

    transaction_ref: str = Field(sa_column=Column("transaction_ref",
                                       String(255), default=None, nullable=False, unique=True))
    
    payment_ref: Union[str, None] = Field(sa_column=Column("payment_ref", String(255), default=None, nullable=True, unique=True))
    
    user_id: UUID = Field(sa_column=Column(
        "user_id", ForeignKey(column="users.id", ondelete="CASCADE")))

    user: User = Relationship(back_populates="payments")

    # payment_status: str = Field(sa_column=Column("payment_status",
    #                                    String(255), default=None, nullable=False))
    
    amount: int = Field(sa_column=Column("amount",
                                       Integer, default=None, nullable=False))
    
    currency: str  = Field(sa_column=Column("currency",
                                       String(255), default=None, nullable=False))
    
    tour_package_id: UUID = Field(sa_column=Column(
        "payment_id", ForeignKey(column="tour_packages.id", ondelete="CASCADE")))
    
    tour_package: "TourPackage" = Relationship(back_populates="payment")