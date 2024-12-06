from contextlib import AbstractAsyncContextManager, AbstractContextManager
from typing import Any, Callable, Type, TypeVar

from sqlalchemy.exc import IntegrityError
from sqlalchemy.orm import joinedload

from app.core.database import Database
from app.core.exceptions import DuplicatedError, NotFoundError
from app.model.base_model import BaseModel
# from app.util.query_builder import dict_to_sqlalchemy_filter_options
from sqlalchemy.ext.asyncio import (
    AsyncSession,
    async_scoped_session,
    async_sessionmaker,
    create_async_engine,
)

T = TypeVar("T", bound=BaseModel)


class BaseRepository:

    def __init__(self, session_factory: Callable[[], AsyncSession], model: Type[T]) -> None:
        self.session_factory = session_factory
        self.model = model

    # def read_by_options(self, schema: T, eager: bool = False) -> dict:
    #     with self.session_factory() as session:
    #         schema_as_dict: dict = schema.dict(exclude_none=True)
    #         ordering: str = schema_as_dict.get("ordering", configs.ORDERING)
    #         order_query = (
    #             getattr(self.model, ordering[1:]).desc()
    #             if ordering.startswith("-")
    #             else getattr(self.model, ordering).asc()
    #         )
    #         page = schema_as_dict.get("page", configs.PAGE)
    #         page_size = schema_as_dict.get("page_size", configs.PAGE_SIZE)
    #         filter_options = dict_to_sqlalchemy_filter_options(self.model, schema.dict(exclude_none=True))
    #         query = session.query(self.model)
    #         if eager:
    #             for eager in getattr(self.model, "eagers", []):
    #                 query = query.options(joinedload(getattr(self.model, eager)))
    #         filtered_query = query.filter(filter_options)
    #         query = filtered_query.order_by(order_query)
    #         if page_size == "all":
    #             query = query.all()
    #         else:
    #             query = query.limit(page_size).offset((page - 1) * page_size).all()
    #         total_count = filtered_query.count()
    #         return {
    #             "founds": query,
    #             "search_options": {
    #                 "page": page,
    #                 "page_size": page_size,
    #                 "ordering": ordering,
    #                 "total_count": total_count,
    #             },
    #         }

    async def read_by_id(self, id: int, eager: bool = False):
        async with self.session_factory() as session:
            query = session.query(self.model)
            if eager:
                for eager in getattr(self.model, "eagers", []):
                    query = query.options(
                        joinedload(getattr(self.model, eager)))
            query = query.filter(self.model.id == id).first()
            if not query:
                raise NotFoundError(detail=f"not found id : {id}")
            return query

    async def create(self, schema: T):
        """Create an object in the database."""
        pass

    def update(self, id: int, schema: T):
        """Update record in db"""
        # with self.session_factory() as session:
        #     session.query(self.model).filter(self.model.id == id).update(
        #         schema.dict(exclude_none=True))
        #     session.commit()
        #     return self.read_by_id(id)
        pass

    def update_attr(self, id: int, column: str, value: Any):
        with self.session_factory() as session:
            session.query(self.model).filter(
                self.model.id == id).update({column: value})
            session.commit()
            return self.read_by_id(id)

    def whole_update(self, id: int, schema: T):
        with self.session_factory() as session:
            session.query(self.model).filter(
                self.model.id == id).update(schema.dict())
            session.commit()
            return self.read_by_id(id)

    def delete_by_id(self, id: int):
        with self.session_factory() as session:
            query = session.query(self.model).filter(
                self.model.id == id).first()
            if not query:
                raise NotFoundError(detail=f"not found id : {id}")
            session.delete(query)
            session.commit()

    def close_scoped_session(self):
        with self.session_factory() as session:
            return session.close()
