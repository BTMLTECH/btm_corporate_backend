#!/usr/bin/env python3
# File: routes.py
# Author: Oluwatobiloba Light
"""Routes"""


from fastapi import APIRouter
from app.api.endpoints.auth import router as auth_router
# from app.api.endpoints.user import router as user_router

routers = APIRouter()
router_list = [auth_router]

for router in router_list:
    routers.include_router(router)
