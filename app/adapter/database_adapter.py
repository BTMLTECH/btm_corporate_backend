from abc import ABC, abstractmethod
from typing import Any

class DatabaseAdapter(ABC):
    """Database operations"""
    @abstractmethod
    async def add(self, instance: Any) -> None:
        pass
    
    @abstractmethod
    async def flush(self) -> None:
        pass

    @abstractmethod
    async def refresh(self, instance: Any) -> None:
        pass

    @abstractmethod
    async def commit(self) -> None:
        pass

    @abstractmethod
    async def rollback(self) -> None:
        pass

