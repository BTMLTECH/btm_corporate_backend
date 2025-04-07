#!/usr/bin/env python3
# File: services/tour_package_service.py
# Author: Oluwatobiloba Light
"""Tour package Services"""


from typing import Union
from uuid import UUID

from fastapi import BackgroundTasks
from sqlalchemy import select
from app.core.exceptions import (
    DuplicatedError,
    GeneralError,
    NotFoundError,
    ServerError,
)
from app.model.tour_package import TourPackage
from app.model.user import User
from app.repository.tour_package_repository import TourPackageRepository
from app.schema.tour_package_schema import CreateTourPackage
from app.services.base_payment_service import PaymentService
from app.services.base_service import BaseService
from app.services.mail_service import EmailService
from app.core.config import configs


class TourPackageService(BaseService):
    def __init__(self, tour_package_repository: TourPackageRepository):
        self.tour_package_repository = tour_package_repository

        super().__init__(tour_package_repository)

    async def add_tour_package(
        self,
        schema: CreateTourPackage,
        user: User,
        background_tasks: BackgroundTasks,
    ):
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
            schema.accommodation_id, "Accommodation"
        )
        schema.region_id = validate_uuid(schema.region_id, "Region")

        # Validate that lists are not empty
        if not schema.activities:
            raise GeneralError(detail="You must select at least one activity!")
        if not schema.tour_sites_region:
            raise GeneralError(
                detail="You must select at least one tour site in a region!"
            )
        if not schema.transportations:
            raise GeneralError(
                detail="You must select at least one mode of transportation!"
            )

        # Validate UUIDs in lists
        schema.activities = [
            validate_uuid(activity_id, "Activity") for activity_id in schema.activities
        ]
        schema.tour_sites_region = [
            validate_uuid(tour_package_id, "Tour Sites Region")
            for tour_package_id in schema.tour_sites_region
        ]
        schema.transportations = [
            validate_uuid(transportation_id, "Transportation")
            for transportation_id in schema.transportations
        ]

        try:
            # Create the tour package
            new_tour_package = await self.tour_package_repository.create(schema, user)

            # send an email
            email_service = EmailService(
                configs.SMTP_SERVER,
                configs.EMAIL_PORT,
                configs.EMAIL_USERNAME,
                configs.EMAIL_PASSWORD,
                configs.SENDER_EMAIL,
            )

            activity_names = [activity.name for activity in new_tour_package.activities]
            transportation_names = [
                transportation.name
                for transportation in new_tour_package.transportation
            ]
            activity_list = ", ".join(activity_names)
            transportation_list = ", ".join(transportation_names)

            email_content = f"""
            Dear {user.name},
            
We are thrilled to inform you that your customized tour package has been successfully created! 🎉
            
Here are the key details of your package:
    Name: {user.name}
    Email: {user.email}
    Destination: {new_tour_package.region.name}
    Accommodation type: {new_tour_package.accommodation.name}
    Travel Dates: {new_tour_package.start_date} to {new_tour_package.end_date}
    Activities: {activity_list}
    Transportation: {transportation_list}
    People attending: {new_tour_package.no_of_people_attending}
    Payment Status: {new_tour_package.payment_status}
        
At BTM Ghana, we are committed to making your travel experience seamless and memorable. If you have any questions or need further adjustments, please don’t hesitate to reach out to us at info@btmghana.net or call us at +2330302743234.\n
We look forward to helping you embark on an incredible journey!\n
Warm regards,
BTM Ghana
            """.format(
                [package.name for package in new_tour_package.activities]
            )

            background_tasks.add_task(
                email_service.send_email,
                user.email,
                "Your custom tour package is ready!",
                email_content,
            )

            return new_tour_package
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
            print("eror", e)
            # Handle any other unexpected errors
            raise GeneralError(detail=str(e))
        except:
            print("eeee", e)
            raise GeneralError(detail=str(e))

    async def create_tour_package(
        self,
        tour_package: CreateTourPackage,
        user: User,
        background_tasks: BackgroundTasks,
    ):
        """Orchestrate tour package creation and payment processing."""
        # Step 1: Validate and create the tour package
        new_tour_package: TourPackage
        try:
            new_tour_package = await self.add(tour_package, user.id)
            print("new tour package created", new_tour_package)

            # send email notification
            email_service = EmailService(
                configs.SMTP_SERVER,
                configs.EMAIL_PORT,
                configs.EMAIL_USERNAME,
                configs.EMAIL_PASSWORD,
                configs.SENDER_EMAIL,
            )

            email_content = f"""
            Dear {user.name},
            We are thrilled to inform you that your customized tour package has been successfully created! 🎉
                
            Here are the key details of your package:
                Destination(s): {new_tour_package.region.name}
                Accommodation type: 
                Travel Dates: {new_tour_package.start_date} to {new_tour_package.end_date}
                Inclusions: [Brief list of highlights, e.g., accommodations, activities, transportation, etc.]
            
            At BTM Ghana, we are committed to making your travel experience seamless and memorable. If you have any questions or need further adjustments, please don’t hesitate to reach out to us at info@btmghana.net or call us at +2330302743234.\n\n
            
            
            We look forward to helping you embark on an incredible journey!\n
            Warm regards,
            """

            background_tasks.add_task(
                email_service.send_email,
                user.email,
                "Your custom tour package is ready!",
                email_content,
            )
            return new_tour_package
        except Exception as e:
            # delete tour package
            return GeneralError(detail=str(e))

    async def get_user_packages(self, user_id: UUID):
        """Get all user's tour packages"""
        return await self.tour_package_repository.get_user_tour_packages(user_id)

    async def delete_by_id(self, tour_package_id: Union[str, UUID]):
        """Delete a tour package by id"""
        try:
            tour_package_id = UUID(tour_package_id)
        except (Exception, ValueError) as e:
            raise GeneralError(detail="Invalid ID")

        try:
            return await self.tour_package_repository.delete_by_id(tour_package_id)
        except (TypeError,) as e:
            raise ServerError(detail="An unknown error has occured")
        except (Exception, ValueError) as e:
            if "'uuid'" in str(e).lower():
                raise GeneralError(detail="Invalid ID")
            raise GeneralError(detail="An error has occured")
        except:
            raise GeneralError(detail="An unknown error has occured")
