#!/usr/bin/env python3
# File: transportation.py
# Author: Oluwatobiloba Light
"""Transportation endpoint"""


from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from app.core.dependencies import is_user_admin
from app.core.exceptions import GeneralError
from app.model.transportation import Transportation
from app.model.user import User
from app.schema.transportation_schema import CreateTransportation
from app.services.transportation_service import TransportationService
from app.core.container import Container


router = APIRouter(
    prefix="/transportation",
    tags=["Transportation"],

)


@router.post("/add", response_model=Transportation)
@inject
async def add_transportation(transportation: CreateTransportation, service: TransportationService = Depends(Provide[Container.transportation_service]), current_user: User = Depends(is_user_admin)):
    """Route to add atransportation"""
    transportation = await service.add(transportation)

    return transportation


@router.delete("/{transportation_id}")
@inject
async def delete_transportation(transportation_id: str, service: TransportationService = Depends(Provide[Container.transportation_service]), current_user: User = Depends(is_user_admin)):
    """Route to delete a transportation by ID"""
    transportation = await service.delete_by_id(transportation_id)

    if not transportation:
        raise GeneralError(detail="Transportation has been deleted or does not exist")

    return transportation
