#!/usr/bin/env python3
# File: /service/cache/redis_service.py
# Author: Oluwatobiloba Light
"""Cache Service"""


import json
from typing import Any, Dict, Optional, Union
from app.adapter.cache_adapter import RedisClientAdapter
from app.adapter.redis_adapter import RedisAdapter
from app.core.config import configs
from app.core.exceptions import GeneralError


class RedisService:
    """A service that uses a Redis client."""

    def __init__(self, redis_adapter: RedisAdapter):
        self.redis_adapter = redis_adapter

    async def cache_data(self, key: str, value: Any, expiration: int = 3600) -> bool:
        """Cache data in Redis."""
        async with self.redis_adapter._client() as redis_cache:
            
            try:
                if not isinstance(value, (str, int, float, bool)):
                    value = json.dumps(value)
                return await redis_cache.set(key, value, ex=expiration)
            except Exception as e:
                print('error setting data in redis', e)
                raise GeneralError(detail="Error setting data in Redis")

    async def retrieve_data(self, key: str) -> Union[Any, Dict[str, Any], None]:
        """Retrieve cached data from Redis."""
        async with self.redis_adapter._client() as redis_cache:
        # return self.redis_adapter.get(key)
            try:
                value = await redis_cache.get(key)  # This is always a string (or None)
                if value is None:
                    return None
                # Converts JSON string back to Python object
                return value
            except json.JSONDecodeError:
                raise GeneralError("Something went wrong retrieving your data")

    async def delete_data(self, key: str) -> int:
        """Delete a cached data from redis"""
        async with self.redis_adapter._client() as redis_cache:
            return await redis_cache.delete(key)


host = "localhost" if configs.ENV == "dev" else configs.REDIS_URL

# redis_adapter = RedisClient(host)

# redis_service = RedisService(redis_adapter)
