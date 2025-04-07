#!/usr/bin/env python3
# File: app/tasks.py
# Author: Oluwatobiloba Light
import asyncio
from app.services.auth_service import AuthService
from app.services.mail_service import EmailService
from app.celery_app import celery_app
from dependency_injector.wiring import Provide
from app.core.container import Container

"""Celery Tasks"""

@celery_app.task
def send_email(email: str, subject: str, content: str):
    print(f"Sending email to {email}")

    async def start_email_service():
        email_service: EmailService = Container.email_service()

        await email_service.send_mail(email, subject, content)
    
    asyncio.run(start_email_service())

    return f"Email sent to {email}"
