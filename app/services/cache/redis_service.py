#!/usr/bin/env python3
# File: /service/cache/redis_service.py
# Author: Oluwatobiloba Light
"""Cache Service"""


from typing import Any, Dict, Optional, Union
from app.adapter.cache_adapter import RedisClientInterface
from app.adapter.redis_adapter import RedisClient
from app.core.config import configs
from app.core.exceptions import GeneralError


class RedisService:
    """A service that uses a Redis client."""

    def __init__(self, redis_client: RedisClientInterface):
        self.redis_client = redis_client

    def cache_data(self, key: str, value: Any, expiration: int = 3600) -> bool:
        """Cache data in Redis."""
        try:
              return self.redis_client.set(key, value, ex=expiration)
        except Exception as e:
            print('error setting data in redis', e)
            raise GeneralError(detail="Error setting data in Redis")


    def retrieve_data(self, key: str) -> Union[Any, Dict[str, Any], None]:
        """Retrieve cached data from Redis."""
        return self.redis_client.get(key)


host = "localhost" if configs.ENV == "dev" else configs.REDIS_HOST

redis_client = RedisClient(host)

redis_service = RedisService(redis_client)