#!/usr/bin/env python3
# File: app/celery_app.py
# Author: Oluwatobiloba Light
"""Celery"""

from celery import Celery
import os

celery_app = Celery(
    "worker",
    broker=os.getenv("CELERY_REDIS_BROKER"),
    backend=os.getenv("CELERY_REDIS_BACKEND"),
    include=["app.tasks"]
)

celery_app.autodiscover_tasks()