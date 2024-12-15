# from abc import ABC, abstractmethod
# from dataclasses import dataclass
# from typing import Any, Callable, Generic, List, Optional, Type, TypeVar

# from pydantic import UUID4, BaseModel
# from sqlalchemy.orm import joinedload

# from app.core.exceptions import NotFoundError
# # from app.util.query_builder import dict_to_sqlalchemy_filter_options
# from sqlalchemy.ext.asyncio import (
#     AsyncSession,
# )

# # Define generic type variables
# T = TypeVar('T', bound=BaseModel)  # For domain models
# ID = TypeVar('ID', int, str, UUID4)  # For ID types

# @dataclass
# class QueryOptions:
#     """Class for handling query parameters and filters"""
#     filters: dict = None
#     sort_by: str = None
#     order: str = "asc"
#     page: int = 1
#     page_size: int = 10

#     def __post_init__(self):
#         self.filters = self.filters or {}

# class RepositoryException(Exception):
#     """Base exception for repository operations"""
#     pass

# class EntityNotFoundException(RepositoryException):
#     """Raised when an entity is not found"""
#     pass


# class RepositoryProtocol(Generic[T, ID], ABC):
#     """
#     Generic repository interface defining standard CRUD operations
#     """

#     @abstractmethod
#     def get_by_id(self, id: ID) -> Optional[T]:
#         """Retrieve an entity by its ID"""
#         pass

#     @abstractmethod
#     def get_all(self, options: QueryOptions) -> List[T]:
#         """Retrieve all entities matching the given criteria"""
#         pass

#     @abstractmethod
#     def create(self, entity: T) -> T:
#         """Create a new entity"""
#         pass

#     @abstractmethod
#     def update(self, id: ID, entity: T) -> T:
#         """Update an existing entity"""
#         pass

#     @abstractmethod
#     def delete(self, id: ID) -> bool:
#         """Delete an entity by its ID"""
#         pass

#     @abstractmethod
#     def exists(self, id: ID) -> bool:
#         """Check if an entity exists"""
#         pass


# class BaseRepository(RepositoryProtocol[T, ID]):
#     """
#     Base implementation of the repository pattern with common functionality
#     """

#     def __init__(self):
#         self._session = None  # Initialize your database session here

#     def get_by_id(self, id: ID) -> Optional[T]:
#         try:
#             entity = self._find_by_id(id)
#             if not entity:
#                 raise EntityNotFoundException(f"Entity with id {id} not found")
#             return entity
#         except Exception as e:
#             raise RepositoryException(f"Error retrieving entity: {str(e)}")

#     def get_all(self, options: QueryOptions) -> List[T]:
#         try:
#             return self._find_all(options)
#         except Exception as e:
#             raise RepositoryException(f"Error retrieving entities: {str(e)}")

#     def create(self, entity: T) -> T:
#         try:
#             return self._save(entity)
#         except Exception as e:
#             raise RepositoryException(f"Error creating entity: {str(e)}")

#     def update(self, id: ID, entity: T) -> T:
#         try:
#             if not self.exists(id):
#                 raise EntityNotFoundException(f"Entity with id {id} not found")
#             return self._update(id, entity)
#         except EntityNotFoundException:
#             raise
#         except Exception as e:
#             raise RepositoryException(f"Error updating entity: {str(e)}")

#     def delete(self, id: ID) -> bool:
#         try:
#             if not self.exists(id):
#                 raise EntityNotFoundException(f"Entity with id {id} not found")
#             return self._delete(id)
#         except EntityNotFoundException:
#             raise
#         except Exception as e:
#             raise RepositoryException(f"Error deleting entity: {str(e)}")

#     def exists(self, id: ID) -> bool:
#         try:
#             return self._exists(id)
#         except Exception as e:
#             raise RepositoryException(f"Error checking entity existence: {str(e)}")

#     # Protected methods to be implemented by concrete repositories
#     def _find_by_id(self, id: ID) -> Optional[T]:
#         raise NotImplementedError

#     def _find_all(self, options: QueryOptions) -> List[T]:
#         raise NotImplementedError

#     def _save(self, entity: T) -> T:
#         raise NotImplementedError

#     def _update(self, id: ID, entity: T) -> T:
#         raise NotImplementedError

#     def _delete(self, id: ID) -> bool:
#         raise NotImplementedError

#     def _exists(self, id: ID) -> bool:
#         raise NotImplementedError


# class BaseRepositoryTemp:

#     def __init__(self, session_factory: Callable[[], AsyncSession], model: Type[T]) -> None:
#         self.session_factory = session_factory
#         self.model = model

#     # def read_by_options(self, schema: T, eager: bool = False) -> dict:
#     #     with self.session_factory() as session:
#     #         schema_as_dict: dict = schema.dict(exclude_none=True)
#     #         ordering: str = schema_as_dict.get("ordering", configs.ORDERING)
#     #         order_query = (
#     #             getattr(self.model, ordering[1:]).desc()
#     #             if ordering.startswith("-")
#     #             else getattr(self.model, ordering).asc()
#     #         )
#     #         page = schema_as_dict.get("page", configs.PAGE)
#     #         page_size = schema_as_dict.get("page_size", configs.PAGE_SIZE)
#     #         filter_options = dict_to_sqlalchemy_filter_options(self.model, schema.dict(exclude_none=True))
#     #         query = session.query(self.model)
#     #         if eager:
#     #             for eager in getattr(self.model, "eagers", []):
#     #                 query = query.options(joinedload(getattr(self.model, eager)))
#     #         filtered_query = query.filter(filter_options)
#     #         query = filtered_query.order_by(order_query)
#     #         if page_size == "all":
#     #             query = query.all()
#     #         else:
#     #             query = query.limit(page_size).offset((page - 1) * page_size).all()
#     #         total_count = filtered_query.count()
#     #         return {
#     #             "founds": query,
#     #             "search_options": {
#     #                 "page": page,
#     #                 "page_size": page_size,
#     #                 "ordering": ordering,
#     #                 "total_count": total_count,
#     #             },
#     #         }

#     async def read_by_id(self, id: int, eager: bool = False):
#         async with self.session_factory() as session:
#             query = session.query(self.model)
#             if eager:
#                 for eager in getattr(self.model, "eagers", []):
#                     query = query.options(
#                         joinedload(getattr(self.model, eager)))
#             query = query.filter(self.model.id == id).first()
#             if not query:
#                 raise NotFoundError(detail=f"not found id : {id}")
#             return query

#     async def create(self, schema: T):
#         """Create an object in the database."""
#         pass

#     def update(self, id: int, schema: T):
#         """Update record in db"""
#         # with self.session_factory() as session:
#         #     session.query(self.model).filter(self.model.id == id).update(
#         #         schema.dict(exclude_none=True))
#         #     session.commit()
#         #     return self.read_by_id(id)
#         pass

#     def update_attr(self, id: int, column: str, value: Any):
#         with self.session_factory() as session:
#             session.query(self.model).filter(
#                 self.model.id == id).update({column: value})
#             session.commit()
#             return self.read_by_id(id)

#     def whole_update(self, id: int, schema: T):
#         with self.session_factory() as session:
#             session.query(self.model).filter(
#                 self.model.id == id).update(schema.dict())
#             session.commit()
#             return self.read_by_id(id)

#     def delete_by_id(self, id: int):
#         with self.session_factory() as session:
#             query = session.query(self.model).filter(
#                 self.model.id == id).first()
#             if not query:
#                 raise NotFoundError(detail=f"not found id : {id}")
#             session.delete(query)
#             session.commit()

#     def close_scoped_session(self):
#         with self.session_factory() as session:
#             return session.close()


from typing import Any, Protocol, Type, TypeVar

from psycopg2 import IntegrityError
from sqlmodel import SQLModel
from app.adapter.database_adapter import DatabaseAdapter
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.core.exceptions import DuplicatedError
from app.model.base_model import BaseModel

T = TypeVar('T',  bound=BaseModel)


class BaseRepository:
    def __init__(self, db_adapter: SQLAlchemyAdapter, model: Type[T]) -> None:
        self.db_adapter = db_adapter
        self.model = model

    async def create(self, schema: T):
        """Create an object in the database."""
        query = self.model(**schema.model_dump(exclude_none=True))

        async with self.db_adapter.session() as session, session.begin():
            try:
                await self.db_adapter.add(session, query)
                await self.db_adapter.flush(session)
                await self.db_adapter.refresh(session, query)
            except IntegrityError as e:
                await self.db_adapter.rollback(session)
                raise DuplicatedError(detail=str(e.orig))
            except Exception as e:
                if "duplicate" in str(e).lower():
                    error_msg = "Duplicate entry!"
                    raise DuplicatedError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

        return query

    async def update(self, id: int, schema: T):
        """Update a record in the database."""
        pass  # Implement the update logic

    async def get_by_id(self, id):
        pass
