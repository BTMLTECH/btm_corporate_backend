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
from app.services.activity_service import ActivityService
from app.core.container import Container


router = APIRouter(
    prefix="/activity",
    tags=["Activity"],

)


@router.post("/add", response_model=Activity)
@inject
async def add_activity(activity: CreateActivity, service: ActivityService = Depends(Provide[Container.activity_service]), current_user: User = Depends(is_user_admin)):
    """Route to add an activity"""
    activity = await service.add(activity)

    return activity


@router.delete("{activity_id}")
@inject
async def delete_activity(activity_id: str, service: ActivityService = Depends(Provide[Container.activity_service]), current_user: User = Depends(is_user_admin)):
    """Route to delete an activity by ID"""
    activity = await service.delete_by_id(activity_id)

    if not activity:
        raise GeneralError(detail="Activity has been deleted or does not exist")

    return activity
