#!/usr/bin/env python3
# File: terms_conditions.py
# Author: Oluwatobiloba Light
"""TermsConditions endpoint"""


from dependency_injector.wiring import Provide, inject
from fastapi import APIRouter, Depends
from app.core.dependencies import is_user_admin
from app.core.exceptions import GeneralError
from app.model.terms_condition import TermsConditions
from app.model.user import User
from app.schema.terms_condition_schema import (
    ReadTermsConditionSchema,
    CreateTermsConditionsSchema,
)
from app.services.terms_conditions_service import TermsConditionsService
from app.core.container import Container


router = APIRouter(
    prefix="/terms-conditions",
    tags=["TermsConditions"],
)


@router.post("/add", response_model=ReadTermsConditionSchema)
@inject
async def add_terms_conditions(
    terms_conditions: CreateTermsConditionsSchema,
    service: TermsConditionsService = Depends(
        Provide[Container.terms_conditions_service]
    ),
    current_user: User = Depends(is_user_admin),
):
    """Route to add an terms_conditions"""
    terms_conditions = await service.add(terms_conditions)

    return terms_conditions


@router.delete("/{terms_conditions_id}/delete")
@inject
async def delete_terms_conditions(
    terms_conditions_id: str,
    service: TermsConditionsService = Depends(
        Provide[Container.terms_conditions_service]
    ),
    current_user: User = Depends(is_user_admin),
):
    """Route to delete an terms_conditions by ID"""
    terms_conditions = await service.delete_by_id(terms_conditions_id)

    if not terms_conditions:
        raise GeneralError(detail="TermsConditions has been deleted or does not exist")

    return terms_conditions


@router.get("")
@inject
async def get_terms_conditions(
    service: TermsConditionsService = Depends(
        Provide[Container.terms_conditions_service]
    ),
):
    """Route to get all terms_conditions"""
    return await service.get_all()
