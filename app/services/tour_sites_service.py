#!/usr/bin/env python3
# File: tour_sites_region_service.py
# Author: Oluwatobiloba Light
"""TourSitesRegion Services"""


from typing import Sequence
from uuid import UUID
from app.core.exceptions import GeneralError, ServerError
from app.model.tour_sites_region import TourSitesRegion
from app.repository.tour_sites_region_repository import TourSitesRegionRepository
from app.schema.tour_sites_region_schema import CreateTourSitesRegion, UpdateTourSitesRegion
from app.services.base_service import BaseService


class TourSitesRegionService(BaseService):
    def __init__(self, tour_sites_region_repository: TourSitesRegionRepository):
        self.tour_sites_region_repository = tour_sites_region_repository

        super().__init__(tour_sites_region_repository)

    async def add(self, schema: CreateTourSitesRegion):
        """Create a tour_sites_region"""
        return await self.tour_sites_region_repository.create(schema)

    async def delete_by_id(self, tour_sites_region_id: str):
        """Delete a tour_sites_region by id"""
        return await self.tour_sites_region_repository.delete_by_id(UUID(tour_sites_region_id))

    async def find_all_tour_sites(self) -> Sequence[TourSitesRegion]:
        """Get all regions"""
        return await self.tour_sites_region_repository.find_all()

    async def find_all_tour_sites_by_region(self, region_id: str):
        """Find a tour site by a region using it's id"""
        try:
            region_id = UUID(region_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid region ID")

        return await self.tour_sites_region_repository.find_all_tour_sites_by_region_id(region_id)

    async def update_by_id(self, tour_site_id: str, updated_fields: UpdateTourSitesRegion):
        """Update a tour site by ID"""
        try:
            tour_site_id = UUID(tour_site_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid region ID")

        try:
            return await self.tour_sites_region_repository.update_by_id(tour_site_id, updated_fields.model_dump(exclude_none=True))
        except (TypeError, ) as e:
            raise ServerError(detail="An unknown error has occured")
        except:
            raise GeneralError(detail="An unknown error has occured")
