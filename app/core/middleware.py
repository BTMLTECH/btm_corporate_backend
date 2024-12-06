from functools import wraps
from typing import AsyncGenerator

from dependency_injector.wiring import inject as di_inject
from fastapi import Request
# from loguru import logger

from app.services.base_service import BaseService
from sqlalchemy.ext.asyncio import AsyncSession


def inject(func):
    @di_inject
    @wraps(func)
    def wrapper(*args, **kwargs):
        result = func(*args, **kwargs)
        injected_services = [
            arg for arg in kwargs.values() if isinstance(arg, BaseService)]

        if len(injected_services) == 0:
            return result
        else:
            try:
                injected_services[-1].close_scoped_session()
            except Exception as e:
                print("kjhgfvgh")

    return wrapper


async def get_db(request: Request) -> AsyncGenerator[AsyncSession, None]:
    db: AsyncSession = request.state.db_session
    try:
        yield db
    except Exception as e:
        await db.rollback()
        raise e
    finally:
        await db.close()
