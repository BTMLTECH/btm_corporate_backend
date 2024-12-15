from email.mime.text import MIMEText
from smtplib import SMTP
from typing import Optional, Dict, Any
from uuid import uuid4
from pydantic import EmailStr
import logging


class EmailService:
    def __init__(
        self,
        smtp_server: str,
        smtp_port: int,
        username: str,
        password: str,
        sender_email: str,
        sender_name: str = "BTM Ghana"
    ):
        """Initialize the email service with SMTP configuration.

        Args:
            smtp_server: SMTP server address
            smtp_port: SMTP server port
            username: Email username for authentication
            password: Email password for authentication
            sender_email: Default sender email address
            sender_name: Name to be displayed as sender
        """
        self.smtp_server = smtp_server
        self.smtp_port = smtp_port
        self.username = username
        self.password = password
        self.sender_email = sender_email
        self.sender_name = sender_name
        self.logger = logging.getLogger(__name__)

    async def send_email(
        self,
        to_email: EmailStr,
        subject: str,
        content: str,
        content_type: str = "plain"
    ) -> bool:
        """Generic method to send emails.

        Args:
            to_email: Recipient email address
            subject: Email subject
            content: Email content
            content_type: Content type (plain/html)

        Returns:
            bool: True if email was sent successfully, False otherwise
        """
        try:
            message = MIMEText(content, content_type)
            message["Subject"] = subject
            message["From"] = f"{self.sender_name} <{self.sender_email}>"
            message["To"] = to_email

            with SMTP(self.smtp_server, self.smtp_port) as server:
                server.starttls()
                server.login(self.username, self.password)
                server.sendmail(self.sender_email, to_email,
                                message.as_string())

            self.logger.info(f"Email sent successfully to {to_email}")
            return True

        except Exception as e:
            print("errrr", e)
            self.logger.error(f"Failed to send email to {to_email}: {str(e)}")
            raise EmailServiceException(f"Failed to send email: {str(e)}")

    async def send_verification_email(
        self,
        session_id: str,
        email: EmailStr,
        verification_url: str,
        expiration_minutes: int = 15,
    ) -> Dict[str, Any]:
        """Send verification email to new users.

        Args:
            email: User's email address
            verification_url: Base URL for verification
            expiration_minutes: Token expiration time in minutes
            redis_client: Optional Redis client for token storage

        Returns:
            Dict containing verification data
        """

        verification_data = {
            "session_id": session_id,
            "email": email,
            "expiration_minutes": expiration_minutes
        }

        verification_link = f"{verification_url}?token={session_id}"

        email_content = f"""
        Hi,

        Thanks for signing up on BTM Ghana!

        To complete your registration, please click on the link below to verify your email address:

        {verification_link}

        This link will expire in {expiration_minutes} minutes.

        If you didn't request this email, please ignore it.

        Best regards,
        BTM Ghana
        btmghana.net
        """

        # Store verification data in Redis if client is provided
        # if redis_client:
        #     await redis_client.set(
        #         session_id,
        #         verification_data,
        #         expire=expiration_minutes * 60
        #     )

        # Send the verification email
        await self.send_email(
            to_email=email,
            subject="BTM Ghana - Email Verification",
            content=email_content
        )

        return verification_data


class EmailServiceException(Exception):
    """Custom exception for email service related errors."""
    pass
