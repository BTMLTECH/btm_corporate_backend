#!/usr/bin/env python3
# File: /adapter/flutter_payment_adapter.py
# Author: Oluwatobiloba Light
"""Flutter Payment Adapter"""
from abc import ABC, abstractmethod
from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from typing import Any, Callable, Dict
from app.adapter.payment_adapter import PaymentAdapter
from app.services.payment.flutter_pay import FlutterPaymentGateway


class FlutterPaymentAdapter(PaymentAdapter):
    def __init__(self, payment_gateway: FlutterPaymentGateway) -> None:
        self.payment_gateway = payment_gateway

    async def make_payment(self, payload: Dict[str, any]):
        """Initiate payment transaction"""
        return self.payment_gateway.process_payment(payload)
    
    