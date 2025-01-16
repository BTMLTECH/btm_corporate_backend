#!/usr/bin/env python3
# File: services/payment_service.py
# Author: Oluwatobiloba Light
"""Payment package Services"""


from uuid import UUID

from aiohttp import ClientConnectorDNSError
from app.core.exceptions import AuthForbiddenError, DuplicatedError, GeneralError, NotFoundError, ServerError
from app.repository.payment_repository import PaymentRepository
from app.schema.payment_schema import FlutterPaymentRequest, PackagePaymentSchema
from app.services.base_payment_service import BasePaymentGateway, PaymentService
from app.services.base_service import BaseService
from app.services.payment.flutter_pay import FlutterPaymentGateway
from app.services.tour_package_service import TourPackageService
from app.services.user_service import UserService


class PaymentGatewayService(BaseService):
    def __init__(self, repository: PaymentRepository, payment_gateway: BasePaymentGateway):
        self.repository = repository
        self._payment_gateway = payment_gateway

        super().__init__(repository)

    async def process_payment(self, payment_request: FlutterPaymentRequest):
        try:
            req = await self._payment_gateway.initiate_payment(payment_request)

            if 'status' in req:
                if req["status"] == "success":
                    if "data" in req:
                        if "status" in req["data"]:
                            if req["data"]["status"] == "successful":
                                # save payment data to database here
                                tx_ref = req["data"]["tx_ref"]
                                flw_ref = req["data"]["flw_ref"]
                                amount = req["data"]["amount"]
                                currency = req["data"]["currency"]

                                package_payment = await self.repository.create(PackagePaymentSchema(
                                    amount=amount, currency=currency, user_id=payment_request.user_id, transaction_ref=tx_ref, payment_gateway="Flutterwave", payment_ref=flw_ref, tour_package_id=payment_request.tour_package_id))

                                return package_payment
                else:
                    raise GeneralError(detail=str(req["message"]))
            return req
        except ClientConnectorDNSError as e:
            print("e", e)
            raise ServerError(
                detail="Client is not connected to the internet or connection failed")
        except Exception as e:
            print("errr", e)
            raise GeneralError(detail=str(e))

    async def verify_payment(self, tx_ref: str):
        """whoo"""
        try:
            return await self._payment_gateway.verify_payment(tx_ref)
        except:
            raise GeneralError(detail="Payment failed")