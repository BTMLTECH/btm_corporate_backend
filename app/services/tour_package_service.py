#!/usr/bin/env python3
# File: services/tour_package_service.py
# Author: Oluwatobiloba Light
"""Tour package Services"""


from typing import Optional, Sequence, Union
from uuid import UUID

from app.core.exceptions import GeneralError
from app.model.exclusion import Exclusion
from app.model.inclusion import Inclusion
from app.model.itinerary import Itinerary
from app.model.terms_condition import TermsConditions
from app.model.tour_package import TourPackage
from app.repository.tour_package_repository import TourPackageRepository
from app.schema.exclusion_schema import CreateExclusionSchema
from app.schema.inclusion_schema import CreateInclusionSchema
from app.schema.itinerary_schema import CreateItinerarySchema
from app.schema.terms_condition_schema import CreateTermsConditionsSchema
from app.schema.tour_package_schema import CreateTourPackageSchema
from app.services.base_service import BaseService


class TourPackageService(BaseService):
    def __init__(self, tour_package_repository: TourPackageRepository):
        self.tour_package_repository = tour_package_repository

        super().__init__(tour_package_repository)

    async def create_tour_package(self, schema: CreateTourPackageSchema):
        """Creates a new tour package"""
        try:
            return await self.tour_package_repository.create(schema)
        except Exception as e:
            print("Error", e)
            raise GeneralError(detail=f"An error has occured while creating a tour package: {e}")

    async def get_tour_packages(self) -> Sequence[TourPackage]:
        """Gets a list of tour packages"""
        try:
            return await self.tour_package_repository.get_all()
        except Exception as e:
            print("error", e)
            raise GeneralError(detail="An error has occured fetching all tour packages")

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
    ) -> Exclusion:
        """Creates a tour package exclusion"""
        return await self.tour_package_repository.create_exclusions(schema)


    async def create_tour_package_terms_conditions(self, schema: CreateTermsConditionsSchema) -> TermsConditions:
        """Create a tour package terms and conditions"""
        try:
            return await self.tour_package_repository.create_terms_conditions(schema)
        except Exception as e:
            raise GeneralError(detail="An error has occured while creating terms and conditions for tour package")