import json
from typing import Any, Callable, Optional
from app.adapter.cache_adapter import RedisClientAdapter
from app.core.config import configs
from redis.asyncio.client import Redis


class RedisAdapter(RedisClientAdapter):
    """Concrete implementation of the Redis client interface."""

    def __init__(self, client: Callable[[], Redis]):
        self._client = client

    async def set(self, client: Redis, key: str, value: Any, ex: Optional[int] = 3600) -> bool:
        """Set a value in Redis with an optional expiration time."""
        serialized_value = json.dumps(value)
        return await client.set(key, serialized_value, ex=ex)

    async def hset(self, client: Redis, key: str, value: Any, ex: Optional[int] = None):
        """Set a dict as value in Redis with an optional expiration time."""
        return await client.hset(key, value)

    async def get(self, client: Redis, key: str) -> Optional[Any]:
        """Get a value from Redis by key."""
        return await client.get(key)

    async def delete(self, client: Redis, key: str):
        """Delete a key from Redis."""
        return await client.delete(key)
