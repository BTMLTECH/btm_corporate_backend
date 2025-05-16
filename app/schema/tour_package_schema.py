#!/usr/bin/env python3
# File: schemas/tour_package_schema.py
# Author: Oluwatobiloba Light
"""Tour Package Schema"""

from enum import Enum
from typing import List, Optional, Union
from uuid import UUID
from pydantic import BaseModel, Field

# from sqlmodel import Field
from app.model.activity import Activity
from app.model.destination import Destination
from app.model.exclusion import Exclusion
from app.model.inclusion import Inclusion
from app.model.itinerary import Itinerary
from app.model.terms_condition import TermsConditions
from app.model.tour_sites_region import TourSitesRegion
from app.model.transportation import Transportation
from app.schema.accommodation_schema import AccommodationSchema
from app.schema.exclusion_schema import CreateExclusionSchema
from app.schema.inclusion_schema import CreateInclusionSchema
from app.schema.itinerary_schema import CreateItinerarySchema
from app.schema.payment_schema import PaymentRequest
from app.schema.region_schema import RegionSchema
from app.schema.terms_condition_schema import CreateTermsConditionsSchema
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


class TourPackagePriceTypeSchema(str, Enum):
    PER_PERSON = "PER_PERSON"
    PER_FAMILY = "PER_FAMILY"
    

class TourPackageSchema(BaseModel):
    id: UUID
    title: str
    slug: str
    description: Union[str, None] = None

    duration_days: int
    duration_nights: int

    price_per_person_usd: Optional[float] = None
    price_per_family_usd: Optional[float] = None

    number_of_travelers: int

    traveler_adults: int

    traveler_children: Optional[int] = None

    is_group_pricing: Optional[bool] = Field(default=False)

    price_type: Optional[TourPackagePriceTypeSchema] = None

    destinations: List[Destination] = Field(default=[])

    accommodation_details: Union[str, None] = None
    meals_included: Union[str, None] = None

    transport_info: Union[str, None] = None
    itineraries: Optional[List[Itinerary]]
    inclusions: Optional[List[Inclusion]]
    exclusions: Optional[List[Exclusion]]
    terms_conditions: Optional[List[TermsConditions]]

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

    # price_per_person_usd: Optional[float] = None

    price_per_family_usd: Optional[float] = None

    number_of_travelers: int = Field(default=1)

    traveler_adults: int = Field(default=1)

    traveler_children: int = Field(default=0)

    is_group_pricing: Optional[bool] = Field(default=False)

    price_type: Optional[TourPackagePriceTypeSchema] = None


    accommodation_details: Union[str, None] = None
    meals_included: Union[str, None] = None

    transport_info: Union[str, None] = None
    
    destinations: List[Destination] = Field(default=[])
    itineraries: Optional[List[CreateItinerarySchema]] = None
    inclusions: Union[List[CreateInclusionSchema], None] = None
    exclusions: Union[List[CreateExclusionSchema], None] = None
    terms_conditions: Union[List[CreateTermsConditionsSchema], None] = None

    thumbnail_url: str

    images_url: Optional[List[str]] = None

    package_type: str
