#!/usr/bin/env python3
# File: payment.py
# Author: Oluwatobiloba Light
"""Payment endpoint"""


from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from app.core.dependencies import (
    get_current_active_user,
)
from app.model.user import User
from app.schema.payment_schema import FlutterPaymentRequest, VerifyPayment
from app.services.payment_service import PaymentGatewayService
from app.core.container import Container


router = APIRouter(
    prefix="/payment",
    tags=["Payment"],
)


@router.post("/process", response_model=None)
@inject
async def initiate_payment(
    payment_request: FlutterPaymentRequest,
    service: PaymentGatewayService = Depends(
        Provide[Container.payment_gateway_service]
    ),
    current_user: User = Depends(get_current_active_user),
):
    """Route to Initiate a payment"""
    payment = await service.process_payment(payment_request, current_user)

    return payment


@router.post("/verify", response_model=None)
@inject
async def verify_payment(
    payment: VerifyPayment,
    service: PaymentGatewayService = Depends(
        Provide[Container.payment_gateway_service]
    ),
):
    """Route to Initiate a payment"""
    return await service.verify_payment(payment.tx_ref)
