from email.mime.text import MIMEText
from smtplib import SMTP
from typing import Optional, Dict, Any
from uuid import uuid4
from pydantic import EmailStr
import logging

from app.core.exceptions import GeneralError


class EmailService:
    def __init__(
        self,
        smtp_server: str,
        smtp_port: int,
        username: str,
        password: str,
        sender_email: str,
        sender_name: str = "BTM Ghana",
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
        content_type: str = "plain",
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

            self.logger.info(f"Sending email to {to_email}")
            with SMTP(self.smtp_server, self.smtp_port) as server:
                server.starttls()
                server.login(self.username, self.password)
                server.sendmail(self.sender_email, to_email, message.as_string())

            self.logger.info(f"Email sent successfully to {to_email}")
            return True

        except Exception as e:
            print("errrr", e)
            self.logger.error(f"Failed to send email to {to_email}: {str(e)}")
            raise EmailServiceException(f"Failed to send email: {str(e)}")

    async def send_verification_email(
        self,
        session_id: str,
        name: str,
        email: EmailStr,
        verification_url: str,
        expiration_minutes: int = 15,
    ) -> Dict[str, Any]:
        """Send verification email to new users.

        Args:
            email: User's email address
            verification_url: Base URL for verification
            expiration_minutes: Token expiration time in minutes
            content_type: Email content type

        Returns:
            Dict containing verification data
        """

        verification_data = {
            "session_id": session_id,
            "email": email,
            "expiration_minutes": expiration_minutes,
        }

        verification_link = f"{verification_url}?token={session_id}"
        from app.util.email import verification_style_2

        email_content = f"""
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Verify your email</title>
    <style>
 body {{
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      margin: 0;
      padding: 0;
      background-color: #f9f5ff;
      color: #333;
    }}
    .container {{
      max-width: 600px;
      margin: 0 auto;
      padding: 20px;
    }}
    .logo-container {{
      text-align: center;
      margin-bottom: 24px;
      position: relative;
      max-width: 100px;
      margin: 0 auto;
    }}
    .logo {{
      background-color: #ffffff;
      border-radius: 6px;
      padding: 16px;
      box-shadow: 0 1px 3px rgba(0,0,0,0.1);
      display: flex;
      justify-content: center;
    }}
    .header {{
      text-align: center;
      margin-bottom: 32px;
    }}
    h1 {{
      color: #2e1065;
      font-size: 24px;
      margin-bottom: 8px;
    }}
    .button-container {{
      text-align: center;
      margin: 24px 0;
    }}
    .button {{
      background-color: #2563eb;
      color: white;
      padding: 12px 24px;
      border-radius: 6px;
      text-decoration: none;
      font-weight: 500;
      display: inline-block;
    }}
    .footer {{
      text-align: center;
      font-size: 14px;
      color: #666;
      margin-top: 32px;
    }}
    
  </style>
</head>
<body>
  <div class="container">
    <div class="logo-container">
      <div class="logo">
                <img src="https://res.cloudinary.com/djjoidnbp/image/upload/v1745099902/btm-logo_rmp4vj.png" alt="BTM Ghana" style="max-width: 100px;">
      </div>
    </div>
    
    <div class="header">
      <h1>Please verify your email 😊</h1>
      <p>We are happy you signed up for <strong>BTM Ghana</strong>! To complete your registration, please click on the link below to verify your email address. This helps keep your account secure.</p>
    </div>
    
    <div class="button-container">
      <a style="color: white;" href="{verification_link}" class="button">Verify my account</a>
    </div>
    
    <div class="footer">
      <p>
        You're receiving this email because you have an account on BTM Ghana. 
        If you are not sure why you're receiving this, please contact us by replying to this email.
      </p>
    </div>
  </div>
</body>
</html>
"""

        try:
            print("Sending...")
            await self.send_email(
                to_email=email,
                subject="BTM Ghana - Email Verification",
                content=email_content,
                content_type="html",
            )
            print("Sent")
            return verification_data
        except Exception as e:
            print("An error has occured", e)
            raise GeneralError(detail="Failure in sending email.")

    async def send_mail(
        self,
        email: EmailStr,
        subject: str,
        content: str,
        content_type: str = "plain",
    ):
        """Send an email"""
        try:
            await self.send_email(
                to_email=email,
                subject=subject,
                content=content,
                content_type=content_type,
            )
            return True
        except Exception as e:
            print("An error has occured", e)
            raise GeneralError(detail="Failure in sending email.")


class EmailServiceException(Exception):
    """Custom exception for email service related errors."""

    pass
