#!/usr/bin/env python3
# File: main.py
# Author: Oluwatobiloba Light
"""Event Ticketing entry point"""


from contextlib import asynccontextmanager
from fastapi import FastAPI, Request
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse
from starlette.middleware.cors import CORSMiddleware

from app.api.routes import routers
from app.core.config import configs
from app.core.container import Container
from app.util.class_object import singleton
from starlette.middleware.sessions import SessionMiddleware
from sqlalchemy.ext.asyncio import AsyncSession


@asynccontextmanager
async def lifespan(app: FastAPI):
    # Startup: create database connection and any other async resources
    db = app.state.db
    try:
        await db.create_async_database()
        print("✅ Database initialized")
    except Exception as e:
        print(f"❌ Error initializing database: {e}")
        raise

    yield  # FastAPI is running

    # Shutdown
    print("🛑 Shutting down...")
    await db.close()


@singleton
class AppCreator:
    def __init__(self):
        # Create container first
        self.container = Container()

        # Get database from container
        self.db = self.container.db()

        # set app default
        self.app = FastAPI(
            title=configs.PROJECT_NAME,
            # openapi_url=f"{configs.API}/openapi.json",
            version="0.0.1",
            description="BTM Corporate Web Server",
            lifespan=lifespan
        )

        # Store db in app state for access in lifespan context manager
        self.app.state.db = self.db

        if configs.SECRET_KEY is None:
            raise "Missing Secret Key"

        self.app.add_middleware(
            SessionMiddleware, secret_key=configs.SECRET_KEY, max_age=1800,  # 30 minutes
            same_site="lax")

        # set cors
        if configs.BACKEND_CORS_ORIGINS:
            self.app.add_middleware(
                CORSMiddleware,
                allow_origins=[str(origin)
                               for origin in configs.BACKEND_CORS_ORIGINS],
                allow_credentials=True,
                allow_methods=["*"],
                allow_headers=["*"],
            )

        # set routes
        @self.app.get("/")
        def root():
            return "service is working"

        @self.app.middleware("http")
        async def db_session_middleware(request: Request, call_next):
            """Middleware to manage database sessions."""
            request.state.db = AsyncSession(
                autocommit=False, autoflush=False)
            try:
                response = await call_next(request)
                # await request.state.db.commit()
                return response
            except Exception as e:
                await request.state.db.rollback()
                raise e
            finally:
                await request.state.db.close()

        self.app.include_router(routers, prefix=configs.API)


app_creator = AppCreator()

app = app_creator.app


@app.exception_handler(RequestValidationError)
async def validation_exception_handler(_, exc):
    errors = {}
    for error in exc.errors():
        field = ''.join(error['loc'][1]) if len(
            error['loc']) > 1 else error['loc'][0]
        errors['{}'.format(field)] = error['msg']
        # errors['message'] = error['msg']
        # errors.append({
        #     'field': field,
        #     'message': error['msg']
        # })
    return JSONResponse(status_code=422, content={
        "detail": "Validation error", "errors": errors})

db = app_creator.db

print("✅ Up and running...")

# print(db._engine.url, configs.DB_USER)

container = app_creator.container

# @app.middleware("http")
# async def db_session_middleware(request: Request, call_next):
#     """Middleware to manage database sessions."""
#     request.state.db_session = AsyncSession(autocommit=False, autoflush=False)
#     print("hgfdfrtghybnjm")
#     try:
#         response = await call_next(request)
#         # await request.state.db.commit()
#         return response
#     except Exception as e:
#         # await request.state.db.rollback()
#         raise e
#     finally:
#         await request.state.db_session.close()
