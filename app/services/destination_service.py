#!/usr/bin/env python3
# File: app/services/destination_service.py
# Author: Oluwatobiloba Light
# Date created: 29/04/2025
"""Destination Services"""


from typing import Sequence
from app.model.destination import Destination
from app.repository.destination_repository import DestinationRepository
from app.schema.destination_schema import CreateDestinationSchema
from app.services.base_service import BaseService


class DestinationService(BaseService):
    def __init__(self, destination_repository: DestinationRepository):
        self.destination_repository = destination_repository

        super().__init__(destination_repository)

    async def create_destination(
        self, destination: CreateDestinationSchema
    ) -> Destination:
        """Create a new destination"""
        return await self.destination_repository.create(destination)

    async def get_destinations(self) -> Sequence[Destination]:
        return await self.destination_repository.get_all()
