#!/usr/bin/env python3
# File: /service/base_payment_service.py
# Author: Oluwatobiloba Light
"""Base Payment Gateway Service"""


from abc import ABC, abstractmethod
from typing import Any, Dict

from app.repository.base_repository import BaseRepository


class BasePaymentGateway(ABC):
    @abstractmethod
    async def initiate_payment(self, payment_request: Dict[str, any]) -> Dict[str, Any]:
        """Process payment"""
        pass


class PaymentService:
    """Payment Service"""
    def __init__(self, repository: BaseRepository, payment_gateway: BasePaymentGateway):
        self._repository = repository
        self._payment_gateway = payment_gateway

    async def make_payment(self, payment_request: Dict[str, any]):
        """kjh"""
        return await self._payment_gateway.initiate_payment(payment_request)
    
