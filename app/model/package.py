#!/usr/bin/env python3
# File: app/api/model/package.py
# Author: Oluwatobiloba Light
"""Package Model"""


from app.model.base_model import BaseModel


class Package(BaseModel, table=True):
    __tablename__:str = "packages"