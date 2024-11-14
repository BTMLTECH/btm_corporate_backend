from datetime import datetime
from typing import Literal

from pydantic import UUID4, BaseModel, EmailStr, Field

from schema.timestamp import UserTimestamp


class User(BaseModel, UserTimestamp):
    """"""
    id: UUID4
    name: str = Field(
        ..., title="Name", description="The user's full name")
    email: EmailStr = Field(
        ..., title="Email", description="The user's email")
    phone: str = Field(
        ..., title="Phone", description="The user's phone")
    address: str = Field(
        ..., title="Address", description="The user's address")
    provider: Literal["google", "email"] = Field(
        ..., title="Provider Type", description="Must be either 'google' or 'email'")
    email_verified: bool = Field(
        ..., title="Email Verified", description="Email verification status", default=False)
