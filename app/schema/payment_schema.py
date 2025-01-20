#!/usr/bin/env python3
# File: /schema/flutter_payment_schema.py
# Author: Oluwatobiloba Light
"""Payment schema"""


from typing import Any, Dict, Union
from uuid import UUID
from pydantic import BaseModel, Field


class FlutterPaymentRequest(BaseModel):
    amount: Union[str, int] = 1
    currency: str = "USD"
    card_number: str = Field(default="5531886652142950")
    cvv: str = Field(default="564")
    expiry_month: Union[str, int]
    expiry_year: Union[str, int]
    name: str
    email: str
    user_id: Union[str, None] = None
    # tx_ref: str
    tour_package_id: str
    # redirect_url: Union[str, None] = Field(default=None)
    mode: Union[str, None] = Field(default=None)
    fields: Union[Dict[str, Any], None] = Field(default=None)


class PaymentRequest(BaseModel):
    amount: Union[str, int] = 1
    currency: str = "USD"
    card_number: str = Field(default="5531886652142950")
    cvv: str = Field(default="564")
    expiry_month: Union[str, int]
    expiry_year: Union[str, int]
    email: str
    user_id: Union[str, None] = None
    # tx_ref: str
    tour_package_id: str
    # redirect_url: Union[str, None] = Field(default=None)
    mode: Union[str, None] = Field(default=None)
    fields: Union[Dict[str, Any], None] = Field(default=None)


class PackagePaymentSchema(BaseModel):
    transaction_ref: str
    payment_ref: Union[str, None] = None
    user_id: UUID
    payment_gateway: str = "Flutterwave"
    amount: Union[str, int] = 1
    currency: str = "USD"
    tour_package_id: str

class VerifyPayment(BaseModel):
    tx_ref: str