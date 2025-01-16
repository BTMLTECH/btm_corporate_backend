#!/usr/bin/env python3
# File: services/tour_package_payment.py
# Author: Oluwatobiloba Light
"""Tour Package Payment Services"""


from typing import Any, Dict
from app.core.exceptions import GeneralError
from app.model.personal_package_payment import PersonalPackagePayment
from app.model.tour_package import TourPackage
from app.schema.payment_schema import PaymentRequest
from app.schema.tour_package_schema import CreateTourPackage
from app.services.payment_service import PaymentGatewayService
from app.services.tour_package_service import TourPackageService


class TourPackagePaymentService:
    def __init__(
        self,
        tour_package_service: TourPackageService,
        payment_service: PaymentGatewayService,
    ):
        self.tour_package_service = tour_package_service
        self.payment_service = payment_service

    async def create_tour_package(self, tour_package: CreateTourPackage, payment_request: PaymentRequest):
        """Orchestrate tour package creation and payment processing."""
        # Step 1: Validate and create the tour package
        new_tour_package: TourPackage
        try:
            new_tour_package = await self.tour_package_service.add(tour_package)
        except Exception as e:
            # delete tour package
            return GeneralError(detail="Tour failed")
        # Step 2: Process payment
        try:
            payment_request.tour_package_id = str(new_tour_package.id)

            payment_result = await self.payment_service.process_payment(payment_request)
        except Exception as e:
            # delete tour package
            await self.tour_package_service.delete_by_id(str(new_tour_package.id))
            return e
            return GeneralError(detail="Payment failed")


        return payment_result

        # Step 3: Update the tour package with payment details (optional)
        tour_package.payment_intent_id = payment_result["payment_intent_id"]
        await self.tour_package_service.update(tour_package)

        return tour_package
