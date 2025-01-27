#!/usr/bin/env python3
# File: api/endpoints/tour_package.py
# Author: Oluwatobiloba Light
"""Tour Package endpoint"""


from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, BackgroundTasks, Depends
from app.core.dependencies import get_current_user, is_user_admin
from app.model.user import User
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


@router.post("/add", response_model=None, description="Create a new Tour Package")
@inject
async def add_tour_package(background_tasks: BackgroundTasks, tour_package: CreateTourPackage, payment_request: PaymentRequest, service: TourPackagePaymentService = Depends(Provide[Container.tour_package_payment_service]), current_user: User = Depends(get_current_user)):
    """Route to add a tour package"""
    result = await service.create_tour_package(tour_package, payment_request, current_user.id, background_tasks)

    return result
