#!/usr/bin/env python3
# File: accommodation_service.py
# Author: Oluwatobiloba Light
"""Accommodation Services"""


from uuid import UUID
from app.core.exceptions import GeneralError
from app.model.accommodation import Accommodation
from app.repository.accommodation_repository import AccommodationRepository
from app.schema.accommodation_schema import CreateAccommodation
from app.services.base_service import BaseService


class AccommodationService(BaseService):
    def __init__(self, accommodation_repository: AccommodationRepository):
        self.accommodation_repository = accommodation_repository

        super().__init__(accommodation_repository)

    async def add(self, schema: CreateAccommodation) -> Accommodation:
        """Create an accommodation"""
        return await self.accommodation_repository.create(schema)

    async def delete_by_id(self, accommodation_id: str):
        """Delete an accommodation by id"""
        return await self.accommodation_repository.delete_by_id(UUID(accommodation_id))

    async def get_all(self):
        """Get list of accommodations"""
        try:
            return await self.accommodation_repository.get_all()
        except Exception as e:
            print(e)
            raise GeneralError(detail="An unknown error has occured!")