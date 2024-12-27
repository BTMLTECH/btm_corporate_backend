#!/usr/bin/env python3
# File: /service/base_payment_service.py
# Author: Oluwatobiloba Light
"""Base Payment Gateway Service"""


from abc import ABC, abstractmethod


class PaymentGateway(ABC,):
    @abstractmethod
    def process_payment(self, payment_request: dict[str, any]):
        """Process payment"""
        pass


class PaymentService:
    """Payment Service"""
    def __init__(self, payment_gateway: PaymentGateway):
        self.payment_gateway = payment_gateway

    def process_payment(self, payment_request):
        return self.payment_gateway.process_payment(payment_request)
