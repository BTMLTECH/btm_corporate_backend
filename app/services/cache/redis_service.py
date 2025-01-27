#!/usr/bin/env python3
# File: /service/cache/redis_service.py
# Author: Oluwatobiloba Light
"""Cache Service"""


import json
from typing import Any, Dict, Optional, Union
from app.adapter.cache_adapter import RedisClientInterface
from app.adapter.redis_adapter import RedisClient
from app.core.config import configs
from app.core.exceptions import GeneralError


class RedisService:
    """A service that uses a Redis client."""

    def __init__(self, redis_adapter: RedisClientInterface):
        self.redis_adapter = redis_adapter

    def cache_data(self, key: str, value: Any, expiration: int = 3600) -> bool:
        """Cache data in Redis."""
        try:
            # if not isinstance(value, (str, int, float, bool)):
            #     value = json.dumps(value)
            return self.redis_adapter.set(key, value, ex=expiration)
        except Exception as e:
            print('error setting data in redis', e)
            raise GeneralError(detail="Error setting data in Redis")

    def retrieve_data(self, key: str) -> Union[Any, Dict[str, Any], None]:
        """Retrieve cached data from Redis."""
        # return self.redis_adapter.get(key)
        try:
            value = self.redis_adapter.get(key)  # This is always a string (or None)
            if value is None:
                return None
            # Converts JSON string back to Python object
            return value
        except json.JSONDecodeError:
            raise GeneralError("Something went wrong retrieving your data")

    def delete_data(self, key: str) -> int:
        """Delete a cached data from redis"""
        return self.redis_adapter.delete(key)


host = "localhost" if configs.ENV == "dev" else configs.REDIS_URL

# redis_adapter = RedisClient(host)

# redis_service = RedisService(redis_adapter)
