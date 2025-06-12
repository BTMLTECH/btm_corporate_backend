#!/usr/bin/env python3
# File: container.py
# Author: Oluwatobiloba Light
"""Container"""

from dependency_injector import containers, providers
from app.adapter.flutter_payment_adapter import FlutterPaymentAdapter
from app.adapter.redis_adapter import RedisAdapter
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.core.config import configs
from app.core.database import Database, RedisConnection
from app.repository import *
from app.repository import payment_repository
from app.repository.accommodation_repository import AccommodationRepository
from app.repository.activity_repository import ActivityRepository
from app.repository.auth_repository import AuthRepository
from app.repository.destination_repository import DestinationRepository
from app.repository.google_repository import GoogleRepository
from app.repository.payment_repository import PaymentRepository
from app.repository.region_repository import RegionRepository
from app.repository.terms_conditions_repository import TermsConditionsRepository
from app.repository.tour_package_repository import TourPackageRepository
from app.repository.user_tour_package_repository import UserTourPackageRepository
from app.repository.tour_sites_region_repository import TourSitesRegionRepository
from app.repository.transportation_repository import TransportationRepository
from app.repository.user_repository import UserRepository
from app.repository.user_verification_repository import UserVerificationRepository
from app.services.accommodation_service import AccommodationService
from app.services.activity_service import ActivityService
from app.services.auth_service import AuthService
from app.services.base_payment_service import PaymentService
from app.services.cache.redis_service import RedisService
from app.services.destination_service import DestinationService
from app.services.payment.flutter_pay import FlutterPaymentGateway
from app.services.payment_service import PaymentGatewayService
from app.services.region_service import RegionService
from app.services.terms_conditions_service import TermsConditionsService
from app.services.tour_package_service import TourPackageService
from app.services.user_tour_package_service import UserTourPackageService
from app.services.tour_sites_service import TourSitesRegionService
from app.services.transportation_service import TransportationService
from app.services.user_service import UserService
from app.services import *
from rave_python import Rave
from app.core.config import configs


class Container(containers.DeclarativeContainer):
    wiring_config = containers.WiringConfiguration(
        modules=[
            "app.api.endpoints.accommodation",
            "app.api.endpoints.activity",
            "app.api.endpoints.auth",
            "app.api.endpoints.user",
            "app.api.endpoints.region",
            "app.api.endpoints.transportation",
            "app.api.endpoints.tour_package",
            "app.api.endpoints.payment",
            "app.api.endpoints.destination",
            "app.api.endpoints.terms_conditions",
            "app.core.dependencies",
        ]
    )

    db = providers.Singleton(
        Database,
        db_url=(
            configs.DATABASE_URI
            if configs.ENV == "production"
            else configs.DATABASE_URI
        ),
    )

    # Database Adapter
    database_adapter = providers.Factory(SQLAlchemyAdapter, session=db.provided.session)

    flutter_payment_gateway = providers.Singleton(FlutterPaymentGateway)

    redis_client = providers.Singleton(
        RedisConnection,
        host="localhost" if configs.ENV == "dev" else configs.REDIS_URL,
        port=6379,
        db=0,
    )

    redis_adapter = providers.Factory(
        RedisAdapter, client=redis_client.provided.connection
    )

    # Repositories
    user_repository = providers.Factory(UserRepository, db_adapter=database_adapter)

    auth_repository = providers.Factory(AuthRepository, db_adapter=database_adapter)

    user_verification_repository = providers.Factory(
        UserVerificationRepository, db_adapter=database_adapter
    )

    google_repository = providers.Factory(GoogleRepository, db_adapter=database_adapter)

    region_repository = providers.Factory(RegionRepository, db_adapter=database_adapter)

    activity_repository = providers.Factory(
        ActivityRepository, db_adapter=database_adapter
    )

    accommodation_repository = providers.Factory(
        AccommodationRepository, db_adapter=database_adapter
    )

    destination_repository = providers.Factory(
        DestinationRepository, db_adapter=database_adapter
    )

    transportation_repository = providers.Factory(
        TransportationRepository, db_adapter=database_adapter
    )

    tour_sites_region_repository = providers.Factory(
        TourSitesRegionRepository, db_adapter=database_adapter
    )

    tour_package_repository = providers.Factory(
        TourPackageRepository, db_adapter=database_adapter
    )

    terms_conditions_repository = providers.Factory(
        TermsConditionsRepository, db_adapter=database_adapter
    )

    user_tour_package_repository = providers.Factory(
        UserTourPackageRepository, db_adapter=database_adapter
    )

    payment_repository = providers.Factory(PaymentRepository, database_adapter)

    # Services
    email_service = providers.Factory(
        EmailService,
        configs.SMTP_SERVER,
        configs.EMAIL_PORT,
        configs.EMAIL_USERNAME,
        configs.EMAIL_PASSWORD,
        configs.SENDER_EMAIL,
    )
    accommodation_service = providers.Factory(
        AccommodationService, accommodation_repository=accommodation_repository
    )

    activity_service = providers.Factory(
        ActivityService, activity_repository=activity_repository
    )

    redis_service = providers.Factory(RedisService, redis_adapter=redis_adapter)

    auth_service = providers.Factory(
        AuthService,
        auth_repository=auth_repository,
        user_verification_repository=user_verification_repository,
        user_repository=user_repository,
        google_repository=google_repository,
        redis_service=redis_service,
        email_service=email_service,
    )

    destination_service = providers.Factory(
        DestinationService, destination_repository=destination_repository
    )

    payment_gateway_service = providers.Factory(
        PaymentGatewayService, payment_repository, flutter_payment_gateway
    )

    # payment_service = providers.Factory(
    #     PaymentGatewayService, payment_repository, flutter_payment_gateway)

    region_service = providers.Factory(
        RegionService, region_repository=region_repository
    )

    terms_conditions_service = providers.Factory(
        TermsConditionsService, terms_conditions_repository
    )

    tour_sites_region_service = providers.Factory(
        TourSitesRegionService, tour_sites_region_repository
    )

    tour_package_service = providers.Factory(
        TourPackageService, tour_package_repository
    )

    user_tour_package_service = providers.Factory(
        UserTourPackageService, user_tour_package_repository
    )

    transportation_service = providers.Factory(
        TransportationService, transportation_repository
    )

    user_service = providers.Factory(UserService, user_repository=user_repository)
