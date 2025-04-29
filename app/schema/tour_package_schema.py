#!/usr/bin/env python3
# File: schemas/tour_package_schema.py
# Author: Oluwatobiloba Light
"""Tour Package Schema"""

import json
from typing import List, Optional, Union
from uuid import UUID
from pydantic import BaseModel, Field, field_validator, validator

# from sqlmodel import Field
from app.model.activity import Activity
from app.model.destination import Destination
from app.model.exclusion import Exclusion
from app.model.inclusion import Inclusion
from app.model.itinerary import Itinerary
from app.model.terms_condition import TermsCondition
from app.model.tour_sites_region import TourSitesRegion
from app.model.transportation import Transportation
from app.schema.accommodation_schema import AccommodationSchema
from app.schema.exclusion_schema import CreateExclusionSchema
from app.schema.inclusion_schema import CreateInclusionSchema
from app.schema.itinerary_schema import CreateItinerarySchema, ItinerarySchema
from app.schema.payment_schema import PaymentRequest
from app.schema.region_schema import RegionSchema
from app.schema.terms_condition_schema import CreateTermsConditionSchema
from app.schema.user_schema import UserResponseSchema
from datetime import date


class CreateTourPackage(BaseModel):
    accommodation_id: str
    # accommodation: AccommodationSchema
    activities: List[str] = Field(default=[])

    no_of_people_attending: int = Field(default=1)
    # no_of_nights: int = Field(default=1)

    start_date: date
    end_date: date

    name: str
    email: str
    contact: Union[str, None] = None
    address: Union[str, None] = None
    # user_id: str
    # user: UserSchema

    region_id: str
    # region: RegionSchema

    transportations: List[str] = Field(default=[])
    tour_sites_region: List[str] = Field(default=[])

    class Config:
        json_encoders = {
            UUID: lambda v: str(v),  # Convert UUID to string during serialization
        }


class CreateTourPackageAndMakePayment(CreateTourPackage, PaymentRequest): ...


class UserTourPackageSchema(BaseModel):
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


class TourPackageSchema(BaseModel):
    id: UUID
    title: str
    slug: str
    description: Union[str, None] = None

    duration_days: int
    duration_nights: int

    price_per_person_usd: float
    destinations: List[Destination] = Field(default=[])

    accommodation_details: Union[str, None] = None
    meals_included: Union[str, None] = None

    transport_info: Union[str, None] = None
    itineraries: Optional[List[Itinerary]]
    inclusions: Optional[List[Inclusion]]
    exclusions: Optional[List[Exclusion]]
    terms_conditions: Optional[List[TermsCondition]]

    thumbnail_url: str
    
    images_url: Optional[List[str]] = None

    package_type: str

    class Config:
        json_encoders = {
            UUID: lambda v: str(v),  # Convert UUID to string during serialization
        }


class CreateTourPackageSchema(BaseModel):
    title: str
    description: Union[str, None] = None

    duration_days: int
    duration_nights: int

    price_per_person_usd: float
    destinations: List[Destination] = Field(default=[])

    accommodation_details: Union[str, None] = None
    meals_included: Union[str, None] = None

    transport_info: Union[str, None] = None
    itineraries: Optional[List[CreateItinerarySchema]] = None

    inclusions: Union[List[CreateInclusionSchema], None] = None
    exclusions: Union[List[CreateExclusionSchema], None] = None
    terms_conditions: Union[List[CreateTermsConditionSchema], None] = None

    thumbnail_url: str

    images_url: Optional[List[str]] = None

    package_type: str
