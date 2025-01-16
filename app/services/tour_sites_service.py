#!/usr/bin/env python3
# File: tour_sites_region_service.py
# Author: Oluwatobiloba Light
"""TourSitesRegion Services"""


from typing import Sequence
from uuid import UUID
from app.core.exceptions import GeneralError, NotFoundError, ServerError
from app.model.tour_sites_region import TourSitesRegion
from app.repository.tour_sites_region_repository import TourSitesRegionRepository
from app.schema.tour_sites_region_schema import CreateTourSitesRegion, UpdateTourSitesRegion
from app.services.base_service import BaseService
from sqlalchemy.exc import DBAPIError, SQLAlchemyError, CompileError


class TourSitesRegionService(BaseService):
    def __init__(self, tour_sites_region_repository: TourSitesRegionRepository):
        self.tour_sites_region_repository = tour_sites_region_repository

        super().__init__(tour_sites_region_repository)

    async def add(self, schema: CreateTourSitesRegion):
        """Create a tour_sites_region"""
        return await self.tour_sites_region_repository.create(schema)

    async def delete_by_id(self, tour_sites_region_id: str):
        """Delete a tour_sites_region by id"""
        try:
            tour_sites_region_id = UUID(tour_sites_region_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid ID")

        try:
            return await self.tour_sites_region_repository.delete_by_id(tour_sites_region_id)
        except (TypeError, ) as e:
            raise ServerError(detail="An unknown error has occured")
        except (Exception, ValueError) as e:
            if "'uuid'" in str(e).lower():
                raise GeneralError(detail="Invalid ID")
            raise GeneralError(detail="An error has occured")
        except:
            raise GeneralError(detail="An unknown error has occured")

    async def get_all_tour_sites(self) -> Sequence[TourSitesRegion]:
        """Get all regions"""
        return await self.tour_sites_region_repository.find_all()

    async def find_all_tour_sites_by_region(self, region_id: str):
        """Find a tour site by a region using it's id"""
        try:
            region_id = UUID(region_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid region ID")

        return await self.tour_sites_region_repository.find_all_tour_sites_by_region_id(region_id)

    async def update_by_id(self, tour_site_id: str, updated_fields: UpdateTourSitesRegion) -> TourSitesRegion:
        """Update a tour site by ID"""
        try:
            tour_site_id = UUID(tour_site_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid Tour site ID")

        try:
            tour_site = await self.tour_sites_region_repository.update_by_id(tour_site_id, updated_fields.model_dump(exclude_none=True))

            if not tour_site:
                raise NotFoundError(
                    detail="Tour site not found or has been deleted")

            return tour_site
        except (TypeError) as e:
            raise ServerError(detail="An unknown error has occured")
        except (Exception, CompileError, DBAPIError, SQLAlchemyError, TypeError) as e:
            if "column names" in str(e).lower():
                raise GeneralError(
                    detail="You cannot update an invalid field")

            if "invalid input" in str(e).lower():
                raise GeneralError(detail="Invalid field type")

            raise GeneralError(detail=str(e))
        except:
            raise ServerError(detail="An unknown error has occured")

    async def get_by_id(self, tour_site_id: str):
        """Get a tour site by ID"""
        try:
            tour_site_id = UUID(tour_site_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid tour site ID")

        try:
            tour_site = await self.tour_sites_region_repository.find_by_id(tour_site_id)

            if not tour_site:
                raise NotFoundError(detail="Tour site does not exist")

            return tour_site
        except Exception as e:
            raise GeneralError(detail=str(e))
        except:
            raise ServerError(detail="An unknown error has occured")
