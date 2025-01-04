#!/usr/bin/env python3
# File: app/util/generate_reference.py
# Author: Oluwatobiloba Light
from datetime import datetime
import uuid


def generate_transaction_reference() -> str:
    """
    Generate a transaction reference in the format:
    BTM-TOUR-PACKAGE-<timestamp>-<randomly-generated-string>
    """
    # Get the current timestamp
    timestamp = datetime.now().strftime("%Y%m%d%H%M%S")  # Format: YYYYMMDDHHMMSS
    # Generate a random UUID and convert it to a string
    random_string = str(uuid.uuid4()).replace("-", "")  # Remove hyphens
    # Format the transaction reference
    transaction_ref = f"BTM-TOUR-PACKAGE-{timestamp}-{random_string}"
    return transaction_ref
