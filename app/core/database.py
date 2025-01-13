#!/usr/bin/env python3
# File: database.py
# Author: Oluwatobiloba Light
"""Database"""

from contextlib import asynccontextmanager
from typing import Any, AsyncGenerator
from asyncio import current_task
from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy.orm import DeclarativeBase
from sqlalchemy.ext.asyncio import (
    AsyncSession,
    AsyncEngine,
    async_scoped_session,
    async_sessionmaker,
    create_async_engine,
)
from app.core.config import configs



Base: DeclarativeBase = declarative_base()

# class Base(DeclarativeBase):
#     # https://docs.sqlalchemy.org/en/14/orm/extensions/asyncio.html#preventing-implicit-io-when-using-asyncsession
#     __mapper_args__ = {"eager_defaults": True}


class Database:
    """"""

    def __init__(self, db_url: str) -> None:
        self._engine: AsyncEngine = create_async_engine(
            db_url,
            pool_pre_ping=True,
            echo=False,
            # connect_args={ "ssl": True},
        )

        # self._sessionmaker: async_scoped_session = async_scoped_session(
        #     async_sessionmaker(
        #         self._engine,
        #         expire_on_commit=False,
        #         autoflush=False,
        #         future=True,
        #         class_=AsyncSession
        #     ),
        #     scopefunc=current_task,
        # )

        self._sessionmaker = async_sessionmaker(
            self._engine,
            expire_on_commit=False,
            autoflush=False,
            future=True,
            class_=AsyncSession
        )

    async def close(self):
        if self._engine is None:
            raise Exception("Database SessionManager is not initialized")
        await self._engine.dispose()
        # await self._sessionmaker.close()

    async def create_async_database(self) -> None:
        if self._engine:
            async with self._engine.connect() as conn:
                if configs.ENV == "development" or configs.ENV == 'dev':
                    # Drop dependent tables explicitly
                    await conn.run_sync(Base.metadata.drop_all, checkfirst=True)

                # await conn.run_sync(Base.metadata.drop_all)
                await conn.run_sync(Base.metadata.create_all, checkfirst=True)

    @asynccontextmanager
    async def session(self) -> AsyncGenerator[AsyncSession, Any]:
        if self._sessionmaker is None:
            raise Exception("Database SessionManager is not initialized")

        sessionmanager: AsyncSession = self._sessionmaker()

        async with sessionmanager as conn:
            try:
                yield conn
                await conn.commit()
            except Exception as e:
                await conn.rollback()
                raise e
            finally:
                await conn.close()

        # try:
        #     yield session
        # except IntegrityError as exception:
        #     await session.rollback()
        # finally:
        #     await session.close()
