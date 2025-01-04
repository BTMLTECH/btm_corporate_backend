from sqlalchemy.ext.asyncio import AsyncSession
from sqlalchemy.orm import Session
from sqlalchemy.exc import IntegrityError
from typing import Any, Callable
from app.adapter.database_adapter import DatabaseAdapter


class SQLAlchemyAdapter(DatabaseAdapter):
    def __init__(self, session: Callable[[], AsyncSession]) -> None:
        self.session = session

    async def add(self, session: AsyncSession, instance: Any) -> None:
        session.add(instance)

    async def flush(self, session: AsyncSession) -> None:
        await session.flush()

    async def refresh(self, session: AsyncSession, instance: Any) -> None:
        await session.refresh(instance)

    async def commit(self, session: AsyncSession) -> None:
        await session.commit()

    async def rollback(self, session: AsyncSession) -> None:
        await session.rollback()

    async def delete(self, session: AsyncSession, instance: Any):
        await session.delete(instance)
