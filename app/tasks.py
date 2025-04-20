#!/usr/bin/env python3
# File: app/tasks.py
# Author: Oluwatobiloba Light
import asyncio
from uuid import UUID
from app.services.auth_service import AuthService
from app.services.mail_service import EmailService
from app.celery_app import celery_app
from dependency_injector.wiring import Provide
from app.core.container import Container

"""Celery Tasks"""


@celery_app.task
def send_email(email: str, subject: str, content: str, content_type: str = "plain"):
    """Celery task to send email"""

    async def start_email_service():
        email_service: EmailService = Container.email_service()

        await email_service.send_mail(email, subject, content, content_type)

    asyncio.run(start_email_service())

    return f"Email sent to {email}"


@celery_app.task
def send_verification_email(
    name: str,
    email: str,
    session_id: UUID,
    verification_url: str,
):
    """Celery task to send verification email"""

    async def start_email_service():
        email_service: EmailService = Container.email_service()

        await email_service.send_verification_email(session_id, name, email, verification_url)

    asyncio.run(start_email_service())

    return f"Verification email sent to {email}"
