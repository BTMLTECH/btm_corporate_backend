import datetime

from pydantic import Field


class UserTimestamp:
    """User timestamp"""
    created_at: datetime = Field(default=datetime.now())
    updated_at: datetime = Field(default=datetime.now())
    last_login_at: datetime = Field(default=datetime.now())
    deleted_at: datetime = Field(default=datetime.now())

class Timestamp:
    """Timestamp"""
    created_at: datetime = Field(default=datetime.now())
    updated_at: datetime = Field(default=datetime.now())