#!/usr/bin/env python3
# File: /service/payment/flutter_pay.py
# Author: Oluwatobiloba Light
"""Flutter Payment"""


from app.services.base_payment_service import PaymentGateway


class FlutterPaymentGateway(PaymentGateway):
    """Flutter payment gateway service"""
    def __init__(self, flutter: str):
        self.flutter = flutter

    def process_payment(self, payment_request):
        print("flutterrr")
