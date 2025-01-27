#!/usr/bin/env python3
# File: services/tour_package_payment.py
# Author: Oluwatobiloba Light
"""Tour Package Payment Services"""


import json
from typing import Any, Dict
from uuid import UUID

from fastapi import BackgroundTasks
from fastapi.encoders import jsonable_encoder
from app.core.exceptions import GeneralError
from app.model.personal_package_payment import PersonalPackagePayment
from app.model.tour_package import TourPackage
from app.schema.payment_schema import PaymentRequest
from app.schema.tour_package_schema import CreateTourPackage
from app.services.mail_service import EmailService
from app.services.payment_service import PaymentGatewayService
from app.services.tour_package_service import TourPackageService
from app.core.config import configs


class TourPackagePaymentService:
    def __init__(
        self,
        tour_package_service: TourPackageService,
        payment_service: PaymentGatewayService,
    ):
        self.tour_package_service = tour_package_service
        self.payment_service = payment_service

    async def create_tour_package(self, tour_package: CreateTourPackage, payment_request: PaymentRequest, user_id: UUID, background_tasks: BackgroundTasks):
        """Orchestrate tour package creation and payment processing."""
        # Step 1: Validate and create the tour package
        new_tour_package: TourPackage
        try:
            new_tour_package = await self.tour_package_service.add(tour_package, user_id)

            # send email notification
            email_service = EmailService(configs.SMTP_SERVER, configs.EMAIL_PORT,
                                         configs.EMAIL_USERNAME, configs.EMAIL_PASSWORD, configs.SENDER_EMAIL)

            email_content = f"""
            Dear {tour_package.name},
                We are thrilled to inform you that your customized tour package has been successfully created! 🎉
                
                Here are the key details of your package:
                    Destination(s): {new_tour_package.region}
                    Travel Dates: {new_tour_package.start_date} to {new_tour_package.end_date}
                    Inclusions: [Brief list of highlights, e.g., accommodations, activities, transportation, etc.]
                
                At BTM Ghana, we are committed to making your travel experience seamless and memorable. If you have any questions or need further adjustments, please don’t hesitate to reach out to us at info@btmghana.net or call us at +2330302743234.\n\n
                
                
                We look forward to helping you embark on an incredible journey!\n
                Warm regards,
            """

            # await email_service.send_email(to_email=tour_package.email, subject="Your custom tour package is ready!", content=email_content)
            print("sending email...")
            background_tasks.add_task(email_service.send_email, tour_package.email, "Your custom tour package is ready!", email_content)
        except Exception as e:
            # delete tour package
            return GeneralError(detail=str(e))

        # Step 2: Process payment
        try:
            payment_request.tour_package_id = str(new_tour_package.id)

            payment_result = await self.payment_service.process_payment(payment_request, user_id)

        except Exception as e:
            # delete tour package
            err: Dict[str, Any] = jsonable_encoder(e)
            print(e)

            try:
                if err["detail"]["success"] is not None:
                    raise GeneralError(detail=err['detail'])
            except KeyError:
                # await self.tour_package_service.delete_by_id(str(new_tour_package.id))
                raise GeneralError(detail="Key does not exist")

            # await self.tour_package_service.delete_by_id(str(new_tour_package.id))

            raise GeneralError(detail=e.detail)

        return payment_result

        # Step 3: Update the tour package with payment details (optional)
        tour_package.payment_intent_id = payment_result["payment_intent_id"]
        await self.tour_package_service.update(tour_package)

        return tour_package
