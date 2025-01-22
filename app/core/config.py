#!/usr/bin/env python3
# File: config.py
# Author: Oluwatobiloba Light
"""Config"""


import os
from typing import List, Union
from dotenv import load_dotenv
from pydantic_settings import BaseSettings

load_dotenv()

ENV: str = "dev"


class Configs(BaseSettings):
    # base
    ENV: str = os.getenv("ENV", "dev")
    API: str = "/api"
    PROJECT_NAME: str = "BTM Corporate Web Server"
    # ENV_DATABASE_MAPPER: dict = {
    #     "prod": "btm_corp_ws_prod",
    #     "stage": "btm_corp_ws_stage",
    #     "dev": "btm_corp_ws_dev",
    #     "test": "btm_corp_ws_test",
    # }

    ENV_DATABASE_MAPPER: dict = {
        "production": os.getenv("DB"),
        # "stage": "btm_corp_ws_stage",
        "dev": os.getenv("DB"),
        # "test": "btm_corp_ws_test",
    }

    DB_ENGINE_MAPPER: dict = {
        "postgresql": "postgresql+asyncpg",
        "mysql": "mysql+mysqldb",
        "postgresqlasync": "postgresql+asyncpg"
        # "postgresql+asyncpg":
    }

    PROJECT_ROOT: str = os.path.dirname(os.path.dirname(
        os.path.dirname(os.path.abspath(__file__))))

    # date
    DATETIME_FORMAT: str = "%Y-%m-%dT%H:%M:%S"
    DATE_FORMAT: str = "%Y-%m-%d"

    # auth
    SECRET_KEY: str = os.getenv("SECRET_KEY", "")
    # 60 minutes * 24 hours * 30 days = 30 days
    ACCESS_TOKEN_EXPIRE_MINUTES: int = 60
    GOOGLE_CLIENT_ID: Union[str, None] = os.getenv("GOOGLE_CLIENT_ID")
    GOOGLE_CLIENT_SECRET: Union[str, None] = os.getenv("GOOGLE_CLIENT_SECRET")
    # os.path.join("./", "client_secret.json")
    GOOGLE_CLIENT: str = os.path.join("./", "client_secret.json")
    GOOGLE_SCOPES: List[str] = ['https://www.googleapis.com/auth/userinfo.profile',
                                'https://www.googleapis.com/auth/userinfo.email', 'openid']
    GOOGLE_LOCAL_LOGIN_REDIRECT_URI: str = os.getenv(
        "GOOGLE_LOCAL_OAUTH_LOGIN_REDIRECT_URI")
    GOOGLE_LOCAL_REGISTER_REDIRECT_URI: str = os.getenv(
        "GOOGLE_LOCAL_OAUTH_REGISTER_REDIRECT_URI")
    
    GOOGLE_LOGIN_REDIRECT_URI: str = os.getenv(
        "GOOGLE_OAUTH_LOGIN_REDIRECT_URI")
    GOOGLE_REGISTER_REDIRECT_URI: str = os.getenv(
        "GOOGLE_OAUTH_REGISTER_REDIRECT_URI")

    # CORS
    BACKEND_CORS_ORIGINS: List[str] = ["*"]

    # Email
    EMAIL_PORT: int = os.getenv("EMAIL_PORT", 587)
    SMTP_SERVER: Union[str, None] = os.getenv("SMTP_SERVER")
    EMAIL_USERNAME: Union[str, None] = os.getenv("EMAIL_USERNAME")
    EMAIL_PASSWORD: Union[str, None] = os.getenv("EMAIL_PASSWORD")
    SENDER_EMAIL: Union[str, None] = os.getenv(
        "SENDER_EMAIL", "info@btmghana.net")

    # database
    DB: str = os.getenv("DB", "postgresql")
    DB_ASYNC: str = os.getenv("DB", "postgresqlasync")
    DB_USER: Union[str, None] = os.getenv("DB_USER")
    DB_PASSWORD: Union[str, None] = os.getenv("DB_PASSWORD")
    DB_HOST: Union[str, None] = os.getenv("DB_HOST")
    DB_PORT: str = os.getenv("DB_PORT", "3306")
    DB_ENGINE: str = DB_ENGINE_MAPPER.get(DB, "postgresql")
    DB_ASYNC_ENGINE: str = DB_ENGINE_MAPPER.get(DB_ASYNC, "postgresql+asyncpg")

    DATABASE_URI_FORMAT: str = "{db_engine}://{user}:{password}@{host}:{port}/{database}"

    DATABASE_URI: str = "{db_engine}://{user}:{password}@{host}:{port}/{database}".format(
        db_engine=DB_ASYNC_ENGINE,
        user=DB_USER,
        password=DB_PASSWORD,
        host=DB_HOST,
        port=DB_PORT,
        database=ENV_DATABASE_MAPPER[ENV],
    )

    DATABASE_LOCAL_URI: str = "{db_engine}://{user}:{password}@{host}:{port}/{database}".format(
        db_engine=DB_ASYNC_ENGINE,
        user=os.getenv("DB_LOCAL_USER"),
        password=os.getenv("DB_LOCAL_PASSWORD"),
        host=os.getenv("DB_LOCAL_HOST"),
        port=os.getenv("DB_LOCAL_PORT"),
        database=os.getenv("DB_LOCAL"),
    )

    # Flutterwave
    FLUTTERWAVE_SEC_KEY: Union[str, None] = os.getenv("FLUTTERWAVE_SEC_KEY")
    FLUTTERWAVE_PUB_KEY: Union[str, None] = os.getenv("FLUTTERWAVE_pub_KEY")

    # REDIS
    REDIS_URL: str = os.getenv(
        "REDIS_HOST", None)
    REDIS_HOST: str = os.getenv("REDIS_HOST", "localhost")
    REDIS_PORT: str = os.getenv("REDIS_PORT", 6379)
    REDIS_DB: str = os.getenv("REDIS_DB", 0)
    # REDIS_USERNAME: str = os.getenv("REDIS_USERNAME")
    REDIS_PASSWORD: str = os.getenv("REDIS_PASSWORD")

    # find query
    PAGE: int = 1
    PAGE_SIZE: int = 10
    ORDERING: str = "-id"

    class Config:
        case_sensitive = True


class TestConfigs(Configs):
    ENV: str = "test"

configs = Configs()

if ENV == "prod":
    pass
elif ENV == "stage":
    pass
elif ENV == "dev":
    setting = TestConfigs()
