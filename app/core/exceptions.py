#!/usr/bin/env python3
# File: exceptions.py
# Author: Oluwatobiloba Light
"""Exceptions"""


from typing import Any, Dict, Optional
from fastapi import HTTPException, status


class DuplicatedError(HTTPException):
    def __init__(self, detail: Any = None,
                 headers: Optional[Dict[str, Any]] = None) -> None:
        super().__init__(status.HTTP_400_BAD_REQUEST, detail, headers)

    def __str__(self) -> str:
        # Only return the detail without the status code
        return str(self.detail)


class AuthError(HTTPException):
    def __init__(self, detail: Any = None,
                 headers: Optional[Dict[str, Any]] = None) -> None:
        super().__init__(status.HTTP_401_UNAUTHORIZED, detail, headers)

    def __str__(self) -> str:
        # Only return the detail without the status code
        return str(self.detail)


class AuthForbiddenError(HTTPException):
    def __init__(self, detail: Any = None,
                 headers: Optional[Dict[str, Any]] = None) -> None:
        super().__init__(status.HTTP_403_FORBIDDEN, detail, headers)

    def __str__(self) -> str:
        # Only return the detail without the status code
        return str(self.detail)


class NotFoundError(HTTPException):
    def __init__(self, detail: Any = None,
                 headers: Optional[Dict[str, Any]] = None) -> None:
        super().__init__(status.HTTP_404_NOT_FOUND, detail, headers)

    def __str__(self) -> str:
        # Only return the detail without the status code
        return str(self.detail)


class ValidationError(HTTPException):
    def __init__(self, detail: Any = None,
                 headers: Optional[Dict[str, Any]] = None) -> None:
        super().__init__(status.HTTP_422_UNPROCESSABLE_ENTITY, detail, headers)

    def __str__(self) -> str:
        # Only return the detail without the status code
        return str(self.detail)


class ServerError(HTTPException):
    def __init__(self, detail: Any = None,
                 headers: Optional[Dict[str, Any]] = None) -> None:
        super().__init__(status.HTTP_500_INTERNAL_SERVER_ERROR, detail, headers)

    def __str__(self) -> str:
        # Only return the detail without the status code
        return str(self.detail)


class GeneralError(HTTPException):
    def __init__(self, detail: Any = None,
                 headers: Optional[Dict[str, Any]] = None) -> None:
        super().__init__(status.HTTP_400_BAD_REQUEST, detail, headers)

    def __str__(self) -> str:
        # Only return the detail without the status code
        return str(self.detail)
