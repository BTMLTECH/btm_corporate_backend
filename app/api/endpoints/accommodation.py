#!/usr/bin/env python3
# File: accommodation.py
# Author: Oluwatobiloba Light
"""Accommodation endpoint"""


from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from app.core.dependencies import is_user_admin
from app.core.exceptions import GeneralError
from app.model.accommodation import Accommodation
from app.model.user import User
from app.schema.accommodation_schema import CreateAccommodation
from app.services.accommodation_service import AccommodationService
from app.core.container import Container


router = APIRouter(
    prefix="/accommodation",
    tags=["Accommodation"],

)


@router.post("/add", response_model=Accommodation)
@inject
async def add_accommodation(accommodation: CreateAccommodation, service: AccommodationService = Depends(Provide[Container.accommodation_service]), current_user: User = Depends(is_user_admin)):
    """Route to add an accommodation"""
    accommodation = await service.add(accommodation)

    return accommodation


@router.delete("{accommodation_id}")
@inject
async def delete_accommodation(accommodation_id: str, service: AccommodationService = Depends(Provide[Container.accommodation_service]), current_user: User = Depends(is_user_admin)):
    """Route to delete an accommodation by ID"""
    accommodation = await service.delete_by_id(accommodation_id)

    if not accommodation:
        raise GeneralError(detail="Accommodation has been deleted or does not exist")

    return accommodation
