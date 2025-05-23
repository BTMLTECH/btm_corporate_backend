from abc import ABC, abstractmethod
from typing import Any, Dict, Optional


class RedisClientAdapter(ABC):
    """Abstract interface for Redis clients."""

    @abstractmethod
    async def set(self, key: str, value: str, ex: Optional[int] = None) -> bool:
        pass

    @abstractmethod
    async def hset(self, key: str, value: Dict[str, Any], ex: Optional[int] = None) -> bool:
        pass

    @abstractmethod
    async def get(self, key: str) -> Optional[Any]:
        pass

    @abstractmethod
    async def delete(self, key: str) -> int:
        pass