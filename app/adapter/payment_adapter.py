#!/usr/bin/env python3
# File: /adapter/payment_adapter.py
# Author: Oluwatobiloba Light
"""Payment Adapter"""

from abc import ABC, abstractmethod
from typing import Any

class PaymentAdapter(ABC):
    """Payment operations"""
    @abstractmethod
    async def make_payment(self, payload: Any) -> None:
        pass
    
