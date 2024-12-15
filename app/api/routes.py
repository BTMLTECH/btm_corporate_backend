#!/usr/bin/env python3
# File: routes.py
# Author: Oluwatobiloba Light
"""Routes"""


from fastapi import APIRouter
from app.api.endpoints.auth import router as auth_router
from app.api.endpoints.user import router as user_router
from app.api.endpoints.region import router as region_router
from app.api.endpoints.activity import router as activity_router

routers = APIRouter()
router_list = [auth_router, activity_router, user_router, region_router]

for router in router_list:
    routers.include_router(router)
