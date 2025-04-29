#!/usr/bin/env python3
# File: api/endpoints/destination.py
# Author: Oluwatobiloba Light
# Date created: 29/05/2025
"""Destination endpoint"""


from typing import Sequence
from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from app.schema.destination_schema import (
    CreateDestinationSchema,
    CreatedDestinationSchema,
    DestinationSchema,
)
from app.core.container import Container
from app.services.destination_service import DestinationService


router = APIRouter(
    prefix="/destination",
    tags=["Destinations"],
)


@router.post(
    "/create",
    response_model=CreatedDestinationSchema,
    description="Create a new Destination",
)
@inject
async def add_destination(
    destination: CreateDestinationSchema,
    service: DestinationService = Depends(Provide[Container.destination_service]),
):
    """Route to create a new destination"""
    result = await service.create_destination(destination)

    return result


@router.get(
    "/all",
    response_model=Sequence[DestinationSchema],
    description="Get a list of destinations",
)
@inject
async def get_destinations(
    service: DestinationService = Depends(Provide[Container.destination_service]),
):
    """Route to get all destinations"""
    result = await service.get_destinations()

    return result
