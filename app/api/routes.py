#!/usr/bin/env python3
# File: routes.py
# Author: Oluwatobiloba Light
"""Routes"""


from fastapi import APIRouter
from app.api.endpoints.auth import router as auth_router
from app.api.endpoints.user import router as user_router
from app.api.endpoints.region import router as region_router
from app.api.endpoints.activity import router as activity_router
from app.api.endpoints.accommodation import router as accommodation_router
from app.api.endpoints.transportation import router as transportation_router
from .endpoints.tour_package import router as tour_package_router
from .endpoints.payment import router as payment_router

routers = APIRouter()
router_list = [auth_router, accommodation_router, activity_router, user_router, region_router, transportation_router, tour_package_router, payment_router]

for router in router_list:
    routers.include_router(router)
