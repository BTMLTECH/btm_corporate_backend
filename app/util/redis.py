
#!/usr/bin/env python3
# File: redis.py
# Author: Oluwatobiloba Light
"""Redis client"""

import redis
import json
from typing import Optional, Any
from datetime import timedelta
from app.core.config import configs


class RedisClient:
    def __init__(
        self,
        host: str = configs.REDIS_HOST or "localhost",
        port: int = configs.REDIS_PORT or 6379,
        db: int = configs.REDIS_DB or 0,
        password: Optional[str] = configs.REDIS_PASSWORD,
        decode_responses: bool = True,
        # username: str = configs.REDIS_USERNAME
    ):
        """
        Initialize Redis client with connection parameters.

        Args:
            host: Redis host address
            port: Redis port number
            db: Redis database number
            password: Redis password if authentication is required
            decode_responses: Whether to decode byte responses to strings
        """
        self.redis_client = redis.Redis(
            host=host,
            port=port,
            db=db,
            # username=username,
            password=password,
            decode_responses=decode_responses,
        )

    def set(
        self,
        key: str,
        value: Any,
        expiry_seconds: Optional[int] = None
    ) -> bool:
        """
        Set a key-value pair in Redis. Automatically serializes dict/list values to JSON.

        Args:
            key: Redis key
            value: Value to store (can be string, dict, list, etc)
            expiry_seconds: Optional TTL in seconds

        Returns:
            bool: True if successful, False otherwise
        """
        try:
            # Serialize dict/list values to JSON
            if isinstance(value, (dict, list)):
                value = json.dumps(value)

            if expiry_seconds is not None:
                return self.redis_client.setex(
                    name=key,
                    time=expiry_seconds,
                    value=value
                )
            return self.redis_client.set(key, value)
        except Exception as e:
            print(f"Error setting key {key}: {str(e)}")
            return False

    def get(self, key: str, deserialize: bool = True) -> Any:
        """
        Get value from Redis by key. Automatically deserializes JSON values.

        Args:
            key: Redis key
            deserialize: Whether to attempt JSON deserialization

        Returns:
            The value if found, None if key doesn't exist
        """
        try:
            value = self.redis_client.get(key)
            if value and deserialize:
                try:
                    return json.loads(value)
                except json.JSONDecodeError:
                    # Return as-is if not valid JSON
                    return value
            return value
        except Exception as e:
            print(f"Error getting key {key}: {str(e)}")
            return None

    def delete(self, *keys: str) -> int:
        """
        Delete one or more keys from Redis.

        Args:
            *keys: One or more keys to delete

        Returns:
            int: Number of keys deleted
        """
        try:
            return self.redis_client.delete(*keys)
        except Exception as e:
            print(f"Error deleting keys {keys}: {str(e)}")
            return 0

    def exists(self, key: str) -> bool:
        """
        Check if a key exists in Redis.

        Args:
            key: Redis key to check

        Returns:
            bool: True if key exists, False otherwise
        """
        try:
            return bool(self.redis_client.exists(key))
        except Exception as e:
            print(f"Error checking existence of key {key}: {str(e)}")
            return False

    def ttl(self, key: str) -> int:
        """
        Get the remaining time to live for a key in seconds.

        Args:
            key: Redis key

        Returns:
            int: TTL in seconds, -1 if no TTL, -2 if key doesn't exist
        """
        try:
            return self.redis_client.ttl(key)
        except Exception as e:
            print(f"Error getting TTL for key {key}: {str(e)}")
            return -2


redis_client = RedisClient()
