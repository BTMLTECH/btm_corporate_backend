from typing import Union
from psycopg2 import IntegrityError
from sqlalchemy import delete, select, update
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.core.exceptions import DuplicatedError
from app.model.google import GoogleVerification
from app.repository.base_repository import BaseRepository


class GoogleRepository(BaseRepository):
    """Repository for handling Google operations"""

    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = GoogleVerification

        super().__init__(db_adapter, GoogleVerification)

    async def create(self, verification: GoogleVerification) -> GoogleVerification:
        """Create google state"""
        query = self.model(**verification.model_dump(exclude_none=True))

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

    async def get_by_state(self, state: str) -> Union[GoogleVerification, None]:
        """Get google state"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = select(self.model).where(self.model.state == state)

                query = (await session.execute(
                    query)).scalar()

                if query is None:
                    return None
                return query
            except Exception as e:
                print("An error has occured", e)
                raise e     
   
    async def delete_by_state(self, state: str) -> bool:
        """Delete user verification data """
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = delete(self.model).where(
                    self.model.state == state)

                result = await session.execute(query)

                if result.rowcount < 1:
                    return False

                return True
            except Exception as e:
                print("An error has occured", e)
                await self.db_adapter.rollback(session)
                raise e
            
