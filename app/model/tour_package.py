#!/usr/bin/env python3
# File: region.py
# Author: Oluwatobiloba Light
"""Tour Package Model"""

import enum
from typing import List, Union
from uuid import UUID
from sqlalchemy import Boolean, Column, Date, Enum, ForeignKey, ForeignKeyConstraint, Integer, String, func, text
from sqlmodel import Field, Relationship
from app.model.accommodation import Accommodation
from app.model.base_model import BaseModel
# from app.model.personal_package_payment import PersonalPackagePayment
from app.model.region import Region
from app.model.tour_package_accommodation import TourPackageAccommodationLink
from app.model.tour_package_activity import TourPackageActivityLink
from app.model.tour_package_tour_sites_region import TourPackageTourSitesRegionLink
from app.model.tour_package_transportation import TourPackageTransportationLink
from app.model.user import User
from datetime import date
from sqlalchemy.sql import func


class TourPackagePaymentStatusType(str, enum.Enum):
    """Tour Package payment Type"""
    PENDING = "PENDING"
    SUCCESS = "SUCCESS"
    FAILED = "FAILED"


TourPackagePaymentStatusTypeEnum: Enum = Enum(
    TourPackagePaymentStatusType,
    name="tour_package_payment_status_type_enum",
    create_constraint=True,
    metadata=BaseModel.metadata,
    validate_strings=True,
)


class TourPackage(BaseModel, table=True):
    __tablename__: str = "user_tour_packages"

    active: bool = Field(sa_column=Column("active", Boolean, default=False))

    user_id: UUID = Field(sa_column=Column(
        "user_id", ForeignKey(column="users.id", ondelete="CASCADE")))

    user: User = Relationship(back_populates="tour_packages")

    # payment_id: Union[UUID, None] = Field(sa_column=Column(
    #     "payment_id", ForeignKey(column="personal_package_payment.id"), default=None, nullable=True))

    payment: "PersonalPackagePayment" = Relationship(
        back_populates="tour_package")

    payment_status: Union[TourPackagePaymentStatusType, None] = Field(sa_column=Column("payment_status", Enum(
        TourPackagePaymentStatusType, name="tour_package_payment_status_type_enum"), default=TourPackagePaymentStatusType.PENDING, nullable=True))

    tx_ref: str = Field(sa_column=Column(
        "tx_ref", String(255), default=None, nullable=True))

    payment_gateway: str = Field(sa_column=Column(
        "payment_gateway", String(255), default=None, nullable=True))

    currency: str = Field(sa_column=Column(
        "currency", String(255), default=None, nullable=True))

    region_id: UUID = Field(sa_column=Column(
        "region_id", ForeignKey(column="regions.id", ondelete="CASCADE")))

    region: Region = Relationship(back_populates="tour_packages")

    tour_sites_region: List["TourSitesRegion"] = Relationship(
        back_populates="tour_packages", link_model=TourPackageTourSitesRegionLink)

    accommodation_id: UUID = Field(sa_column=Column(
        "accommodation_id", ForeignKey(column="accommodations.id")))

    accommodation: Accommodation = Relationship(
        back_populates="tour_packages", link_model=TourPackageAccommodationLink)

    no_of_people_attending: int = Field(sa_column=Column(
        "no_of_people_attending", Integer, default=1, nullable=False))

    start_date: date = Field(sa_column=Column(
        "start_date", Date, server_default=func.current_date()))

    end_date: date = Field(sa_column=Column(
        "end_date", Date, server_default=text("CURRENT_DATE + INTERVAL '3 days'")))

    activities: List["Activity"] = Relationship(
        back_populates="tour_packages", link_model=TourPackageActivityLink)

    transportation: List["Transportation"] = Relationship(
        back_populates="tour_packages", link_model=TourPackageTransportationLink)

#     __table_args__ = (
#     ForeignKeyConstraint(
#         ['payment_id'],
#         ['personal_package_payment.id'],
#         name='fk_tour_package_payment',
#         deferrable=True,
#         initially='deferred'
#     ),
# )
