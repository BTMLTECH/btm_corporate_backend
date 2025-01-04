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

from app.services.base_payment_service import BasePaymentGateway
from app.util.generate_reference import generate_transaction_reference


class FlutterPaymentGateway(BasePaymentGateway):
    """Flutter payment gateway service"""

    def __init__(self):
        self._url: str = "https://api.flutterwave.com/v3/"

    @property
    def url(self):
        return self._url

    async def _charge_card(self, payload: FlutterPaymentRequest):
        """Start a card transaction"""
        payload_dict = payload.model_dump(exclude=["fields", "mode"])

        payload_dict["redirect_url"] = "http://127.0.0.1:8000/api/payment/verify"
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
                                                    print(
                                                        response_data["data"])
                                                    return {
                                                        "tx_ref": response_data["data"]["tx_ref"],
                                                        "flw_ref": response_data["data"]["flw_ref"],
                                                        "message": response_data["data"]["processor_response"],
                                                        **response_data["meta"]
                                                    }
                                            return {
                                                "message": response_data["data"]["processor_response"],
                                                **response_data["meta"]
                                            }
                                elif "meta" in response_data:
                                    if "authorization" in response_data["meta"]:
                                        if response_data["meta"]["authorization"]["mode"] == "otp":
                                            # return response_data
                                            print(
                                                response_data["data"])
                                            return {
                                                "tx_ref": response_data["data"]["tx_ref"],
                                                "flw_ref": response_data["data"]["flw_ref"],
                                                "message": response_data["data"]["processor_response"],
                                                **response_data["meta"]
                                            }
                                        return {
                                            "message": response_data["data"]["processor_response"],
                                            **response_data["meta"]
                                        }
                except:
                    print("error in _charge_card")
                    raise
            return response_data
        except:
            raise

    async def initiate_payment(self, payment_request):
        print("flutterrr")
        return await self._charge_card(payment_request)

    def getKey(self, secret_key):
        hashedseckey = hashlib.md5(secret_key.encode("utf-8")).hexdigest()
        hashedseckeylast12 = hashedseckey[-12:]
        seckeyadjusted = secret_key.replace('FLWSECK-', '')
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
