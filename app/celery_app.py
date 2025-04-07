#!/usr/bin/env python3
# File: app/celery_app.py
# Author: Oluwatobiloba Light
"""Celery"""

from celery import Celery

celery_app = Celery(
    "worker",
    broker="redis://localhost:6379/0",
    backend="redis://localhost:6379/0",
    include=["app.tasks"]
)

celery_app.autodiscover_tasks()