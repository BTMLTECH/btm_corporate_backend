#!/usr/bin/env python3
# File: terms_conditions_service.py
# Author: Oluwatobiloba Light
"""TermsConditions Services"""


from uuid import UUID
from app.core.exceptions import GeneralError
from app.model.terms_condition import TermsConditions
from app.repository.terms_conditions_repository import TermsConditionsRepository
from app.schema.terms_condition_schema import CreateTermsConditionsSchema
from app.services.base_service import BaseService


class TermsConditionsService(BaseService):
    def __init__(self, terms_conditions_repository: TermsConditionsRepository):
        self.terms_conditions_repository = terms_conditions_repository

        super().__init__(terms_conditions_repository)

    async def add(self, schema: CreateTermsConditionsSchema) -> TermsConditions:
        """Create a terms_conditions"""
        return await self.terms_conditions_repository.create(schema)

    async def delete_by_id(self, terms_conditions_id: str):
        """Delete a terms_conditions by id"""
        return await self.terms_conditions_repository.delete_by_id(UUID(terms_conditions_id))
    
    async def get_all(self):
        """Get list of terms and conditions"""
        try:
            return await self.terms_conditions_repository.get_all()
        except:
            raise GeneralError(detail="An unknown error has occured!")
