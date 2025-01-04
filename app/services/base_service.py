from abc import ABC
from typing import Any, Protocol, TypeVar, Union
from app.model.base_model import BaseModel
from app.repository.base_repository import BaseRepository


T = TypeVar("T")

class RepositoryProtocol(ABC,):
    async def add(self, schema: Any) -> Any: ...

    # async def update(self, id: int, schema: Any) -> Any: ...

    # async def update_attr(self, id: int, attr: str, value: Any) -> Any: ...

    # async def whole_update(self, id: int, schema: Any) -> Any: ...

    # async def delete_by_id(self, id: int) -> Any: ...

    async def get_by_id(self, id: int) -> Any: ...


class BaseService:
    def __init__(self, repository: BaseRepository):
        self._repository = repository

    async def add(self, schema: T) -> T:
        """Add a new record."""
        return await self._repository.create(schema)
    
    async def get_by_id(self, id: str) -> Union[Any, None]:
        """Get document by id"""
        return await self._repository.get_by_id(id)
