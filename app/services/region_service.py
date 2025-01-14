#!/usr/bin/env python3
# File: region_service.py
# Author: Oluwatobiloba Light
"""Region Services"""


from uuid import UUID
from app.core.exceptions import GeneralError, NotFoundError, ServerError
from app.model.region import Region
from app.repository.region_repository import RegionRepository
from app.schema.region_schema import CreateRegion, UpdateRegion
from app.services.base_service import BaseService
from sqlalchemy.exc import DBAPIError, CompileError, SQLAlchemyError


class RegionService(BaseService):
    def __init__(self, region_repository: RegionRepository):
        self.region_repository = region_repository

        super().__init__(region_repository)

    async def add(self, schema: CreateRegion) -> Region:
        """Create a region"""
        return await self.region_repository.create(schema)

    async def update_by_id(self, region_id: str, updated_fields: UpdateRegion):
        """Update a region by id"""
        try:
            region_id = UUID(region_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid Region ID")

        try:
            region = await self.region_repository.update_by_id(region_id, updated_fields.model_dump(exclude_none=True))

            if not region:
                raise NotFoundError(
                    detail="Region not found or has been deleted")

            return region
        except (Exception, CompileError, DBAPIError) as e:
            if "column names" in str(e).lower():
                raise GeneralError(
                    detail="You cannot update an invalid field")

            if "invalid input" in str(e).lower():
                raise GeneralError(detail="Invalid field type")

            raise GeneralError(detail=str(e))
        except Exception as e:
            raise GeneralError(detail="An unknown error has occured")

    async def delete_by_id(self, region_id: str):
        """Delete a region by id"""
        return await self.region_repository.delete_by_id(UUID(region_id))

    async def find_all_regions(self):
        """Get all regions"""
        try:
            return await self.region_repository.find_all()
        except:
            raise GeneralError(detail="An unknown error has occured!")

    async def find_by_id(self, region_id: str):
        """Find a region by ID"""
        try:
            region_id = UUID(region_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid region ID")

        try:
            region = await self.region_repository.find_by_id(region_id)

            if not region:
                raise NotFoundError(detail="Region does not exist")

            return region
        except Exception as e:
            raise GeneralError(detail=str(e))
        except:
            raise ServerError(detail="An unknown error has occured")
