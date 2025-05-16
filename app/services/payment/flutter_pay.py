#!/usr/bin/env python3
# File: /service/payment/flutter_pay.py
# Author: Oluwatobiloba Light
"""Flutter Payment Gateway"""

from typing import Any, Union
from app.core.exceptions import GeneralError
from app.schema.payment_schema import FlutterPaymentRequest
import requests
import json
import requests
import base64
from Crypto.Cipher import DES3
import hashlib
import aiohttp
from app.core.config import configs
from rave_python import Rave, RaveExceptions, rave
from app.services.base_payment_service import BasePaymentGateway
from app.util.generate_reference import generate_transaction_reference
from app.core.config import configs


class FlutterPaymentGateway(BasePaymentGateway):
    """Flutter payment gateway service"""

    def __init__(self):
        self._url: str = "https://api.flutterwave.com/v3/"
        self.public_key = configs.FLUTTERWAVE_PUB_KEY
        self.secret_key = configs.FLUTTERWAVE_SEC_KEY
        self.env = configs.ENV  # 'staging' or 'production'
        self.rave = Rave(
            self.public_key, self.secret_key, production=(self.env == "production")
        )

    @property
    def url(self):
        return self._url

    async def _charge_card(self, payload: FlutterPaymentRequest):
        """Start a card transaction"""
        payload_dict = payload.model_dump(exclude=["fields", "mode"])

        payload_dict["redirect_url"] = "https://btmghana.net/tours/package/payment/verify"
        payload_dict["tx_ref"] = generate_transaction_reference()

        if "mode" in payload.model_dump():
            if payload.fields is not None:
                payload_dict["authorization"] = {
                    **payload.fields, "mode": payload.mode}

        headers = {
            "accept": "application/json",
            "Authorization": "Bearer {}".format(configs.FLUTTERWAVE_SEC_KEY),
            "Content-Type": "application/json"
        }

        if payload.mode == "otp":
            async with aiohttp.ClientSession() as session:
                payload_otp = {
                    "otp": payload.fields.get("otp", "12345"),
                    "type": "card",
                    "flw_ref": payload.fields.get("flw_ref", None),
                }
                try:
                    async with session.post(self.url + "validate-charge", json=payload_otp, headers=headers) as response:
                        response_data = await response.json()

                        if response_data:
                            if "status" in response_data and response_data["status"] != "success":
                                return response_data
                            else:
                                if "data" in response_data:
                                    if response_data["data"]["status"] == "successful":
                                        return {
                                            "status": response_data["status"],
                                            "data": {
                                                "tx_ref": response_data["data"]["tx_ref"],
                                                "flw_ref": response_data["data"]["flw_ref"],
                                                "amount": response_data["data"]["amount"],
                                                "currency": response_data["data"]["currency"],
                                                "status": response_data["data"]["status"],
                                                "payment_type": response_data["data"]["payment_type"],
                                                "processor_response": response_data["data"]["processor_response"],
                                                "created_at": response_data["data"]["customer"]["created_at"],
                                                "name": response_data["data"]["customer"]["name"],
                                                "email": response_data["data"]["customer"]["email"]}
                                        }
                                    elif response_data["data"]["status"] == "pending":
                                        if "meta" in response_data:
                                            if "authorization" in response_data["meta"]:
                                                if response_data["meta"]["authorization"]["mode"] == "otp":
                                                    # return response_data
                                                    raise GeneralError(detail={
                                                        "tx_ref": response_data["data"]["tx_ref"],
                                                        "flw_ref": response_data["data"]["flw_ref"],
                                                        **response_data["meta"]
                                                    })
                                                    return {
                                                        "tx_ref": response_data["data"]["tx_ref"],
                                                        "flw_ref": response_data["data"]["flw_ref"],
                                                        **response_data["meta"]
                                                    }
                                            return response_data
                                elif "meta" in response_data:
                                    return response_data["meta"]
                except Exception as e:
                    print("errororror", e)
                    raise e
            return response_data

        try:
            encrypt_3DES_key = self.encrypt_data(self.getKey(
                configs.FLUTTERWAVE_SEC_KEY), payload_dict if payload.mode != 'otp' else payload_otp)

            # payment payload
            data = {
                "PBFPubKey": configs.FLUTTERWAVE_PUB_KEY,
                "client": encrypt_3DES_key,
                "alg": "3DES-24"
            }

            response_data: Union[Any, None] = None

            async with aiohttp.ClientSession() as session:
                try:
                    async with session.post(self.url + "charges?type=card", json=data, headers=headers) as response:
                        response_data = await response.json()

                        if response_data:
                            if "status" in response_data and response_data["status"] != "success":
                                print("hallla", response_data)
                                raise GeneralError(detail={
                                    "success": False,
                                    **response_data
                                })
                            else:
                                if "data" in response_data:
                                    if response_data["data"]["status"] == "successful":
                                        return {
                                            "status": response_data["status"],
                                            "data": {
                                                "tx_ref": response_data["data"]["tx_ref"],
                                                "flw_ref": response_data["data"]["flw_ref"],
                                                "amount": response_data["data"]["amount"],
                                                "currency": response_data["data"]["currency"],
                                                "status": response_data["data"]["status"],
                                                "payment_type": response_data["data"]["payment_type"],
                                                "processor_response": response_data["data"]["processor_response"],
                                                "created_at": response_data["data"]["customer"]["created_at"],
                                                "name": response_data["data"]["customer"]["name"],
                                                "email": response_data["data"]["customer"]["email"]}
                                        }
                                    elif response_data["data"]["status"] == "pending":
                                        if "meta" in response_data:
                                            if "authorization" in response_data["meta"]:
                                                # Payment is redirected
                                                if response_data["meta"]["authorization"]["mode"] == "redirect":
                                                    return {
                                                        "success": "pending",
                                                        "message": response_data["data"]["processor_response"],
                                                        **response_data["meta"]
                                                    }

                                                # if response_data["meta"]["authorization"]["mode"] == "otp":
                                                #     # return response_data
                                                #     print(
                                                #         response_data["data"])
                                                #     raise GeneralError(detail={
                                                #         "success": False,
                                                #         "tx_ref": response_data["data"]["tx_ref"],
                                                #         "flw_ref": response_data["data"]["flw_ref"],
                                                #         "message": response_data["data"]["processor_response"],
                                                #         **response_data["meta"]
                                                #     })
                                                    return {
                                                        "tx_ref": response_data["data"]["tx_ref"],
                                                        "flw_ref": response_data["data"]["flw_ref"],
                                                        "message": response_data["data"]["processor_response"],
                                                        **response_data["meta"]
                                                    }
                                            # raise GeneralError(detail={
                                            #     "success": False,
                                            #     "message": response_data["data"]["processor_response"],
                                            #     **response_data["meta"]
                                            # })
                                            print("holala", response_data)
                                            return {
                                                "success": "pending",
                                                "message": response_data["data"]["processor_response"],
                                                **response_data["meta"]
                                            }
                                elif "data" not in response_data and "meta" in response_data:
                                    if response_data["status"] == "success":
                                        print("iya baba e", response_data)
                                        return {
                                            "success": response_data["status"],
                                            "message": response_data["message"],
                                            **response_data["meta"]
                                        }
                except Exception as e:
                    print("error in _charge_card")
                    raise
            return response_data
        except:
            raise

    # async def _charge_card(self, payload: dict):
    #     details = {
    #         "card_number": "4556052704172643",
    #         "cvv": "899",
    #         "expiry_month": "01",
    #         "expiry_year": "23",
    #         "currency": "NGN",
    #         "amount": "7500",
    #         "email": "user@example.com",
    #         "fullname": "Flutterwave Developers",
    #         "tx_ref": "YOUR_PAYMENT_REFERENCE",
    #         "redirect_url": "https://example_company.com/success",
    #     }
    #     response = rave.Card.charge(details)
    #     mode = response.get("meta", {}).get("authorization", {}).get("mode", None)
    #     if mode == "pin" or mode == "avs_noauth":
    #         # Store the current payload
    #         # request.session["charge_payload"] = payload
    #         # Now we'll show the user a form to enter
    #         # the requested fields (PIN or billing details)
    #         # request.session["auth_fields"] = response["meta"]["authorization"]["fields"]
    #         # request.session["auth_mode"] = response["meta"]["authorization"]["mode"]
    #         # return redirect('/pay/authorize')
    #         print("working...")
    #     elif mode == "redirect":
    #         # Store the transaction ID
    #         # so we can look it up later with the flw_ref
    #         # redis.set(f'txref-{response['data']['tx_ref']}', response['data']['id'])
    #         # Auth type is a redirect,
    #         # so just redirect to the customer's bank
    #         # auth_url = response["meta"]["authorization"]["redirect"]
    #         # return redirect(auth_url)
    #         print("oh shit")
    #     else:
    #         # No authorization needed; just verify the payment
    #         # transaction = rave.Card.verify(transaction_id)
    #         # if transaction['data']['status'] == "successful":
    #         #     return redirect('/payment-successful')
    #         # elif transaction['data']['status'] == "pending":
    #         #     # Schedule a job that polls for the status of the payment every 10 minutes
    #         #     check_transaction_status(transaction_id)
    #         #     return redirect('/payment-successful')
    #         # else:
    #         #     return redirect('/payment-failed')
    #         print("kasa")

    async def initiate_payment(self, payment_request):
        return await self._charge_card(payment_request)

    def getKey(self, secret_key):
        hashedseckey = hashlib.md5(secret_key.encode("utf-8")).hexdigest()
        hashedseckeylast12 = hashedseckey[-12:]
        seckeyadjusted = secret_key.replace("FLWSECK-", "")
        seckeyadjustedfirst12 = seckeyadjusted[:12]
        return seckeyadjustedfirst12 + hashedseckeylast12

    def encrypt_data(self, key, json_dict):
        # Serialize the JSON dictionary to a string
        plainText = json.dumps(json_dict)

        # Calculate padding
        blockSize = 8
        padDiff = blockSize - (len(plainText) % blockSize)

        # Add padding to the plaintext
        plainText = "{}{}".format(plainText, "".join(chr(padDiff) * padDiff))

        # Convert plaintext to bytes
        plainTextBytes = plainText.encode("utf-8")

        # Initialize the cipher
        cipher = DES3.new(key.encode("utf-8"), DES3.MODE_ECB)

        # Encrypt the data
        encrypted_bytes = cipher.encrypt(plainTextBytes)

        # Encode the encrypted bytes to Base64 for JSON compatibility
        encrypted_base64 = base64.b64encode(encrypted_bytes).decode("utf-8")

        return encrypted_base64

    async def verify_payment(self, tx_ref: str):
        """Verify Flutterwave payment"""

        headers = {
            "accept": "application/json",
            "Authorization": "Bearer {}".format(configs.FLUTTERWAVE_SEC_KEY),
            "Content-Type": "application/json",
        }

        async with aiohttp.ClientSession() as session:
            try:
                async with session.get(
                    "https://api.flutterwave.com/v3/transactions/verify_by_reference?tx_ref={}".format(
                        tx_ref
                    ),
                    headers=headers,
                ) as response:
                    response_data = await response.json()

                    if response_data:
                        if (
                            "status" in response_data
                            and response_data["status"] != "success"
                        ):
                            return response_data
                        else:
                            if "data" in response_data:
                                if response_data["data"]["status"] == "successful":
                                    return {
                                        "status": response_data["status"],
                                        "data": {
                                            "tx_ref": response_data["data"]["tx_ref"],
                                            "flw_ref": response_data["data"]["flw_ref"],
                                            "amount": response_data["data"]["amount"],
                                            "currency": response_data["data"][
                                                "currency"
                                            ],
                                            "status": response_data["data"]["status"],
                                            "payment_type": response_data["data"][
                                                "payment_type"
                                            ],
                                            "processor_response": response_data["data"][
                                                "processor_response"
                                            ],
                                            "created_at": response_data["data"][
                                                "customer"
                                            ]["created_at"],
                                            "name": response_data["data"]["customer"][
                                                "name"
                                            ],
                                            "email": response_data["data"]["customer"][
                                                "email"
                                            ],
                                        },
                                    }
            except:
                print("error in _charge_card")
                raise

        return None


# class FlutterwavePayment:
#     def __init__(self):
#         self.public_key = configs.FLUTTERWAVE_PUB_KEY
#         self.secret_key = configs.FLUTTERWAVE_SEC_KEY
#         self.env = configs.ENV # 'staging' or 'production'
#         self.rave = Rave(self.public_key, self.secret_key, production=(self.env == "production"))

#     # 1. Initialize Payment
#     def initialize_payment(self, data: dict):
#         try:
#             print("initiating payment")
#             res = self.rave.Card.charge(data)
#             return res
#         except RaveExceptions.CardChargeError as e:
#             print(e.err["errMsg"])
#             print(e.err["flwRef"])
#         except RaveError as e:
#             raise Exception(f"Payment initiation failed: {str(e)}")
