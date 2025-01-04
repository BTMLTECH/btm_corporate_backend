#!/usr/bin/env python3
# File: payment.py
# Author: Oluwatobiloba Light
"""Payment endpoint"""


from typing import Sequence, Union
from uuid import UUID
from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from fastapi.encoders import jsonable_encoder
from app.core.dependencies import get_current_active_user, get_current_user, is_user_admin
from app.core.exceptions import GeneralError
from app.model.personal_package_payment import PersonalPackagePayment
from app.model.user import User
from app.schema.payment_schema import FlutterPaymentRequest
from app.services.payment_service import PaymentGatewayService, PaymentService
from app.core.container import Container


router = APIRouter(
    prefix="/payment",
    tags=["Payment"],

)


@router.post("/process-payment", response_model=None)
@inject
async def initiate_payment(payment_request: FlutterPaymentRequest, service: PaymentGatewayService = Depends(Provide[Container.payment_gateway_service]), current_user: User = Depends(get_current_active_user)):
    """Route to Initiate a payment"""
    payment_request.user_id = current_user.id
    payment = await service.process_payment(payment_request)

    return payment


@router.get("/verify", response_model=None)
@inject
async def initiate_payment(service: PaymentGatewayService = Depends(Provide[Container.payment_gateway_service])):
    """Route to Initiate a payment"""
    return {}
