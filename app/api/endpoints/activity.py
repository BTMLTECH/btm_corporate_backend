#!/usr/bin/env python3
# File: activity.py
# Author: Oluwatobiloba Light
"""Activity endpoint"""


from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from app.core.dependencies import is_user_admin
from app.core.exceptions import GeneralError
from app.model.activity import Activity
from app.model.user import User
from app.schema.activity_schema import CreateActivity
from app.services.region_service import RegionService
from app.core.container import Container


router = APIRouter(
    prefix="/activity",
    tags=["Activity"],

)


@router.post("/add", response_model=Activity)
@inject
async def add_activity(region: CreateActivity, service: RegionService = Depends(Provide[Container.region_service]), current_user: User = Depends(is_user_admin)):
    """Route to add an activity"""
    region = await service.add(region)

    return region


@router.delete("{activity_id}")
@inject
async def delete_activity(activity_id: str, service: RegionService = Depends(Provide[Container.region_service]), current_user: User = Depends(is_user_admin)):
    """Route to delete an activity by ID"""
    region = await service.delete_by_id(activity_id)

    if not region:
        raise GeneralError(detail="Region has been deleted or does not exist")

    return region
