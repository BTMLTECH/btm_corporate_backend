#!/usr/bin/env python3
# File: services/tour_package_payment.py
# Author: Oluwatobiloba Light
"""Tour Package Payment Services"""


from uuid import UUID

from aiohttp import ClientConnectorDNSError
from app.core.exceptions import AuthForbiddenError, DuplicatedError, GeneralError, NotFoundError, ServerError
from app.repository.payment_repository import PaymentRepository
from app.schema.payment_schema import FlutterPaymentRequest, PackagePaymentSchema
from app.schema.tour_package_schema import CreateTourPackage, CreateTourPackageAndMakePayment
from app.services.base_payment_service import BasePaymentGateway, PaymentService
from app.services.base_service import BaseService
from app.services.payment.flutter_pay import FlutterPaymentGateway
from app.services.payment_service import PaymentGatewayService
from app.services.tour_package_service import TourPackageService
from app.services.user_service import UserService


class TourPackagePaymentService(BaseService):
    def __init__(
        self,
        tour_package_service: TourPackageService,
        payment_service: PaymentGatewayService,
    ):
        self.tour_package_service = tour_package_service
        self.payment_service = payment_service

    async def create_tour_package(self, schema: CreateTourPackageAndMakePayment):
        """Orchestrate tour package creation and payment processing."""
        print(schema)
        return None
        # Step 1: Validate and create the tour package
        # tour_package = await self.tour_package_service.add(schema)

        # Step 2: Process payment
        # payment_request = {}
        payment_result = await self.payment_service.process_payment()

        # Step 3: Update the tour package with payment details (optional)
        tour_package.payment_intent_id = payment_result["payment_intent_id"]
        await self.tour_package_service.update(tour_package)

        return tour_package