#!/usr/bin/env python3
# File: activity_service.py
# Author: Oluwatobiloba Light
"""Activity Services"""


from uuid import UUID
from app.core.exceptions import GeneralError
from app.model.activity import Activity
from app.repository.activity_repository import ActivityRepository
from app.schema.activity_schema import CreateActivity
from app.services.base_service import BaseService


class ActivityService(BaseService):
    def __init__(self, activity_repository: ActivityRepository):
        self.activity_repository = activity_repository

        super().__init__(activity_repository)

    async def add(self, schema: CreateActivity) -> Activity:
        """Create an activity"""
        return await self.activity_repository.create(schema)

    async def delete_by_id(self, activity_id: str):
        """Delete an activity by id"""
        return await self.activity_repository.delete_by_id(UUID(activity_id))
    
    async def get_all(self):
        """Get list of activities"""
        try:
            return await self.activity_repository.get_all()
        except:
            raise GeneralError(detail="An unknown error has occured!")
