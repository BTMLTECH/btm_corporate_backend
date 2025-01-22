from abc import ABC, abstractmethod
from typing import Any, Dict, Optional


class RedisClientInterface(ABC):
    """Abstract interface for Redis clients."""

    @abstractmethod
    def set(self, key: str, value: str, ex: Optional[int] = None) -> bool:
        pass

    @abstractmethod
    def hset(self, key: str, value: Dict[str, Any], ex: Optional[int] = None) -> bool:
        pass

    @abstractmethod
    def get(self, key: str) -> Optional[Any]:
        pass

    @abstractmethod
    def delete(self, key: str) -> int:
        pass