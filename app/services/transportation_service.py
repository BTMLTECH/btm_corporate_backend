#!/usr/bin/env python3
# File: transportation_service.py
# Author: Oluwatobiloba Light
"""Transportation Services"""


from uuid import UUID
from app.core.exceptions import GeneralError
from app.model.transportation import Transportation
from app.repository.transportation_repository import TransportationRepository
from app.schema.transportation_schema import CreateTransportation
from app.services.base_service import BaseService


class TransportationService(BaseService):
    def __init__(self, transportation_repository: TransportationRepository):
        self.transportation_repository = transportation_repository

        super().__init__(transportation_repository)

    async def add(self, schema: CreateTransportation) -> Transportation:
        """Create a transportation"""
        return await self.transportation_repository.create(schema)

    async def delete_by_id(self, transportation_id: str):
        """Delete a transportation by id"""
        return await self.transportation_repository.delete_by_id(UUID(transportation_id))

    async def get_all(self):
        """Get a list of transportations"""
        try:
            return await self.transportation_repository.get_all()
        except:
            raise GeneralError(detail="An unknown error has occured!")