#!/usr/bin/env python3
# File: region.py
# Author: Oluwatobiloba Light
"""Region endpoint"""


from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from app.core.dependencies import get_current_user
from app.core.exceptions import GeneralError
from app.model.region import Region
from app.model.user import User
from app.schema.region_schema import CreateRegion
from app.services.region_service import RegionService
from app.core.container import Container


router = APIRouter(
    prefix="/region",
    tags=["Region"],
    
)


@router.post("/add", response_model=Region)
@inject
async def add_region(region: CreateRegion, service: RegionService = Depends(Provide[Container.region_service]), current_user: User = Depends(get_current_user)):
    """Route to add a region"""
    region = await service.add(region)

    return region

@router.delete("{region_id}")
@inject
async def delete_region(region_id: str, service: RegionService = Depends(Provide[Container.region_service]), current_user: User = Depends(get_current_user)):
    """Route to delete a region by id"""
    region = await service.delete_by_id(region_id)

    if not region:
        raise GeneralError(detail="Region has been deleted or does not exist")

    return region