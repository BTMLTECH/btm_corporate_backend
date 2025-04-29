#!/usr/bin/env python3
# File: services/tour_package_service.py
# Author: Oluwatobiloba Light
"""Tour package Services"""


from typing import Optional, Sequence, Union
from uuid import UUID

from app.core.exceptions import GeneralError
from app.model.inclusion import Inclusion
from app.model.itinerary import Itinerary
from app.model.tour_package import TourPackage
from app.repository.tour_package_repository import TourPackageRepository
from app.schema.exclusion_schema import CreateExclusionSchema
from app.schema.inclusion_schema import CreateInclusionSchema
from app.schema.itinerary_schema import CreateItinerarySchema
from app.schema.tour_package_schema import CreateTourPackageSchema
from app.services.base_service import BaseService


class TourPackageService(BaseService):
    def __init__(self, tour_package_repository: TourPackageRepository):
        self.tour_package_repository = tour_package_repository

        super().__init__(tour_package_repository)

    async def create_tour_package(self, schema: CreateTourPackageSchema):
        """Creates a new tour package"""
        return await self.tour_package_repository.create(schema)

    async def get_tour_packages(self) -> Sequence[TourPackage]:
        """Gets a list of tour packages"""
        return await self.tour_package_repository.get_all()

    async def get_tour_package_by_id(
        self, tour_package_id: Union[str, UUID]
    ) -> Optional[TourPackage]:
        """Get a tour package by ID"""

        try:
            tour_package_id = UUID(tour_package_id)
            return await self.tour_package_repository.get_by_id(tour_package_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid ID")
        
    async def create_tour_package_itinerary(
        self, schema: CreateItinerarySchema
    ) -> Itinerary:
        """Creates a tour package itinerary"""
        return await self.tour_package_repository.create_itinerary(schema)

    async def create_tour_package_inclusion(
        self, schema: CreateInclusionSchema
    ) -> Inclusion:
        """Creates a tour package inclusion"""
        return await self.tour_package_repository.create_inclusions(schema)

    async def create_tour_package_exclusion(
        self, schema: CreateExclusionSchema
    ) -> Inclusion:
        """Creates a tour package exclusion"""
        return await self.tour_package_repository.create_exclusions(schema)
