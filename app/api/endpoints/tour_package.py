#!/usr/bin/env python3
# File: api/endpoints/tour_package.py
# Author: Oluwatobiloba Light
"""Tour Package endpoint"""


from typing import Optional, Sequence
from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, BackgroundTasks, Depends
from app.core.dependencies import get_current_user, is_user_admin
from app.model.user import User
from app.schema.exclusion_schema import CreateExclusionSchema, ExclusionSchema
from app.schema.inclusion_schema import CreateInclusionSchema, InclusionSchema
from app.schema.itinerary_schema import CreateItinerarySchema, ItinerarySchema
from app.schema.payment_schema import PaymentRequest
from app.schema.tour_package_schema import (
    CreateTourPackage,
    CreateTourPackageAndMakePayment,
    CreateTourPackageSchema,
    TourPackageSchema,
    UserTourPackageSchema,
)
from app.core.container import Container
from app.schema.user_schema import UserResponseSchema
from app.services.tour_package_service import TourPackageService
from app.services.user_tour_package_service import UserTourPackageService


router = APIRouter(
    prefix="/tour-package",
    tags=["Tour Package"],
)


@router.post(
    "/add", response_model=None, description="Create a new customized user Tour Package"
)
@inject
async def add_user_tour_package(
    background_tasks: BackgroundTasks,
    tour_package: CreateTourPackage,
    service: UserTourPackageService = Depends(
        Provide[Container.user_tour_package_service]
    ),
    current_user: User = Depends(get_current_user),
):
    """Route to add a user tour package"""
    result = await service.add_user_tour_package(
        tour_package, current_user, background_tasks
    )

    return result


@router.post(
    "/create", response_model=TourPackageSchema, description="Create a new Tour Package"
)
@inject
async def create_tour_package(
    tour_package: CreateTourPackageSchema,
    service: TourPackageService = Depends(Provide[Container.tour_package_service]),
    # current_user: User = Depends(get_current_user),
):
    """Route to add a tour package"""
    result = await service.create_tour_package(tour_package)
    return result


@router.get(
    "/all",
    response_model=Sequence[TourPackageSchema],
    description="Get all Tour Packages",
)
@inject
async def get_tour_packages(
    service: TourPackageService = Depends(Provide[Container.tour_package_service]),
    # current_user: User = Depends(get_current_user),
):
    """Route to add a tour package"""
    result = await service.get_tour_packages()

    return result


@router.get(
    "/view/{tour_package_id}",
    response_model=Optional[TourPackageSchema],
    description="Get a Tour Package by ID",
)
@inject
async def get_tour_package_by_id(
    tour_package_id: str,
    service: TourPackageService = Depends(Provide[Container.tour_package_service]),
):
    """Route to get a tour package by it's ID"""
    result = await service.get_tour_package_by_id(tour_package_id)

    return result

@router.post(
    "/itinerary/create",
    response_model=ItinerarySchema,
    description="Create a tour package itinerary",
)
@inject
async def create_tour_package_itinerary(
    itinerary: CreateItinerarySchema,
    service: TourPackageService = Depends(Provide[Container.tour_package_service]),
):
    """Route to create a tour package itinerary"""
    result = await service.create_tour_package_itinerary(itinerary)

    return result

@router.post(
    "/inclusion/create",
    response_model=InclusionSchema,
    description="Create a tour package inclusion",
)
@inject
async def create_tour_package_inclusion(
    inclusion: CreateInclusionSchema,
    service: TourPackageService = Depends(Provide[Container.tour_package_service]),
):
    """Route to create a tour package inclusion"""
    result = await service.create_tour_package_inclusion(inclusion)

    return result


@router.post(
    "/exclusion/create",
    response_model=ExclusionSchema,
    description="Create a tour package exclusion",
)
@inject
async def create_tour_package_exclusion(
    exclusion: CreateExclusionSchema,
    service: TourPackageService = Depends(Provide[Container.tour_package_service]),
):
    """Route to create a tour package exclusion"""
    result = await service.create_tour_package_exclusion(exclusion)

    return result
