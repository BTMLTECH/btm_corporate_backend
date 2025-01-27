import json
from typing import Any, Optional
from redis import Redis, RedisError
from app.adapter.cache_adapter import RedisClientInterface
from app.core.config import configs


class RedisClient(RedisClientInterface):
    """Concrete implementation of the Redis client interface."""

    def __init__(self, client: Redis):
        self._client = client

    def set(self, key: str, value: Any, ex: Optional[int] = 3600) -> bool:
        """Set a value in Redis with an optional expiration time."""
        serialized_value = json.dumps(value)
        return self._client.set(key, serialized_value, ex=ex)

    def hset(self, key: str, value: Any, ex: Optional[int] = None):
        """Set a dict as value in Redis with an optional expiration time."""
        return self._client.hset(key, value)

    def get(self, key: str) -> Optional[Any]:
        """Get a value from Redis by key."""
        return self._client.get(key)

    def delete(self, key: str):
        """Delete a key from Redis."""
        return self._client.delete(key)
