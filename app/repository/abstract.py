from abc import ABC, abstractmethod
from typing import TypeVar, Generic, Optional, List

T = TypeVar("T")

class AbstractRepository(ABC, Generic[T]):
    @abstractmethod
    async def get_by_id(self, id: str) -> Optional[T]:
        pass

    @abstractmethod
    async def list(self, skip: int = 0, limit: int = 100) -> List[T]:
        pass

    @abstractmethod
    async def create(self, obj: T) -> T:
        pass

    @abstractmethod
    async def update(self, obj: T) -> T:
        pass

    @abstractmethod
    async def delete(self, id: str) -> None:
        pass