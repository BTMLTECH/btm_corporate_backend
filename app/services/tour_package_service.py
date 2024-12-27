#!/usr/bin/env python3
# File: services/tour_package_service.py
# Author: Oluwatobiloba Light
"""Tour package Services"""


from uuid import UUID
from app.core.exceptions import DuplicatedError, GeneralError, NotFoundError
from app.repository.tour_package_repository import TourPackageRepository
from app.schema.tour_package_schema import CreateTourPackage
from app.services.base_payment_service import PaymentService
from app.services.base_service import BaseService


class TourPackageService(BaseService):
    def __init__(self, tour_package_repository: TourPackageRepository, payment_service: PaymentService):
        self.tour_package_repository = tour_package_repository
        self.payment_service = payment_service

        super().__init__(tour_package_repository)

    async def add(self, schema: CreateTourPackage):
        """Create a Tour package after validating input data."""
        def validate_uuid(value, field_name):
            """Validate a UUID string and return the UUID object."""
            try:
                UUID(value)
                return value
            except ValueError:
                raise GeneralError(detail=f"Invalid {field_name} ID")

        # Validate UUIDs for accommodation, region, and user
        schema.accommodation_id = validate_uuid(
            schema.accommodation_id, "Accommodation")
        schema.region_id = validate_uuid(schema.region_id, "Region")
        schema.user_id = validate_uuid(schema.user_id, "User")

        # Validate that lists are not empty
        if not schema.activities:
            raise GeneralError(detail="You must select at least one activity!")
        if not schema.tour_sites_region:
            raise GeneralError(
                detail="You must select at least one tour site in a region!")
        if not schema.transportations:
            raise GeneralError(
                detail="You must select at least one mode of transportation!")

        # Validate UUIDs in lists
        schema.activities = [validate_uuid(
            activity_id, "Activity") for activity_id in schema.activities]
        schema.tour_sites_region = [validate_uuid(
            tour_sites_region_id, "Tour Sites Region") for tour_sites_region_id in schema.tour_sites_region]
        schema.transportations = [validate_uuid(
            transportation_id, "Transportation") for transportation_id in schema.transportations]

        try:
            # Create the tour package
            self.payment_service.process_payment({"hi": 123})
            return None
            return await self.tour_package_repository.create(schema)
        except NotFoundError as e:
            # Handle NotFoundError from the repository
            raise NotFoundError(detail=e.detail)
        except DuplicatedError as e:
            # Handle DuplicatedError from the repository
            raise DuplicatedError(detail=e.detail)
        except GeneralError as e:
            # Handle GeneralError from the repository
            raise GeneralError(detail=e.detail)
        except Exception as e:
            # Handle any other unexpected errors
            raise GeneralError(detail=str(e))
