#!/usr/bin/env python3
# File: region_service.py
# Author: Oluwatobiloba Light
"""Region Services"""


from uuid import UUID
from app.model.region import Region
from app.repository.region_repository import RegionRepository
from app.schema.region_schema import CreateRegion
from app.services.base_service import BaseService


class RegionService(BaseService):
    def __init__(self, region_repository: RegionRepository):
        self.region_repository = region_repository

        super().__init__(region_repository)

    async def add(self, schema: CreateRegion) -> Region:
        """Create a region"""
        return await self.region_repository.create(schema)
    
    async def delete_by_id(self, region_id: str):
        """Delete a region by id"""
        return await self.region_repository.delete_by_id(UUID(region_id))
