#!/usr/bin/env python3
# File: api/endpoints/tour_package.py
# Author: Oluwatobiloba Light
"""Tour Package endpoint"""


from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from app.core.dependencies import is_user_admin
from app.schema.payment_schema import PaymentRequest
from app.schema.tour_package_schema import CreateTourPackage, CreateTourPackageAndMakePayment, TourPackageSchema
from app.core.container import Container
from app.schema.user_schema import UserResponseSchema
from app.services.tour_package_payment_service import TourPackagePaymentService
from app.services.tour_package_service import TourPackageService


router = APIRouter(
    prefix="/tour-package",
    tags=["Tour Package"],

)


@router.post("/add", response_model=TourPackageSchema, description="Create a new Tour Package")
@inject
async def add_tour_package(tour_package: CreateTourPackage, payment_request: PaymentRequest, service: TourPackagePaymentService = Depends(Provide[Container.tour_package_payment_service])):
    """Route to add a tour package"""
    result = await service.create_tour_package(tour_package, payment_request)

    return result
