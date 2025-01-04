#!/usr/bin/env python3
# File: schemas/tour_package_schema.py
# Author: Oluwatobiloba Light
"""Tour Package Schema"""

from typing import List, Union
from uuid import UUID
from pydantic import BaseModel
from sqlmodel import Field
from app.model.activity import Activity
from app.model.tour_sites_region import TourSitesRegion
from app.model.transportation import Transportation
from app.schema.accommodation_schema import AccommodationSchema
from app.schema.base_schema import ModelBaseInfo
from app.schema.payment_schema import PaymentRequest
from app.schema.region_schema import RegionSchema
from app.schema.user_schema import UserResponseSchema, UserSchema
from datetime import date


class CreateTourPackage(BaseModel):
    accommodation_id: str 
    # accommodation: AccommodationSchema
    activities: List[str] = Field(default=[])

    no_of_people_attending: int = Field(default=1)
    # no_of_nights: int = Field(default=1)

    start_date: date
    end_date: date

    user_id: str
    # user: UserSchema

    region_id: str
    # region: RegionSchema

    transportations: List[str] = Field(default=[])
    tour_sites_region: List[str] = Field(default=[])

    class Config:
        json_encoders = {
            UUID: lambda v: str(v),  # Convert UUID to string during serialization
        }

class CreateTourPackageAndMakePayment(CreateTourPackage, PaymentRequest):
    ...

class TourPackageSchema(BaseModel):
    id: UUID
    
    # accommodation_id: str
    accommodation: AccommodationSchema
    activities: List[Activity] = Field(default=[])

    no_of_people_attending: int = Field(default=1)
    # no_of_nights: int = Field(default=1)

    start_date: date
    end_date: date

    # user_id: UUID
    user: UserResponseSchema

    # region_id: UUID
    region: RegionSchema

    transportation: List[Transportation] = Field(default=[])
    tour_sites_region: List[TourSitesRegion] = Field(default=[])

    class Config:
        json_encoders = {
            UUID: lambda v: str(v),  # Convert UUID to string during serialization
        }