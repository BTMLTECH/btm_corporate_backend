#!/usr/bin/env python3
# File: api/endpoints/tour_package.py
# Author: Oluwatobiloba Light
"""Tour Package endpoint"""


from typing import Sequence
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
async def add_tour_package(background_tasks: BackgroundTasks, tour_package: CreateTourPackage, service: TourPackageService = Depends(Provide[Container.tour_package_service]), current_user: User = Depends(get_current_user)):
    """Route to add a tour package"""
    result = await service.add_tour_package(tour_package, current_user, background_tasks)

    return result


@router.get("", response_model=Sequence[TourPackageSchema], description="Get all Tour Packages")
@inject
async def get_tour_packages(service: TourPackageService = Depends(Provide[Container.tour_package_service]), current_user: User = Depends(get_current_user)):
    """Route to add a tour package"""
    result = await service.get_user_packages(current_user.id)

    print(result[0])

    return result
