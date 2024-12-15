from psycopg2 import IntegrityError
from sqlalchemy import delete, select, update
from app.adapter.sqlalchemy_adapter import SQLAlchemyAdapter
from app.core.exceptions import DuplicatedError
from app.model.user import UserVerification
from app.repository.base_repository import BaseRepository


class UserVerificationRepository(BaseRepository):
    """Repository for handling UserVerification operations"""

    def __init__(self, db_adapter: SQLAlchemyAdapter):
        self.db_adapter = db_adapter
        self.model = UserVerification

        super().__init__(db_adapter, UserVerification)

    async def create(self, verification: UserVerification) -> UserVerification:
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
                    error_msg = "An account with that email address exists!"
                    raise DuplicatedError(detail=error_msg)
                else:
                    print(f"Other integrity error: {str(e)}")
                    raise DuplicatedError(detail=str(e))
            else:
                await self.db_adapter.commit(session)

        return query

    async def verify_sign_up(self, session_id: str):
        """Verify a user's registration"""
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = select(self.model).where(
                    self.model.session_id == session_id)

                result = (await session.execute(query)).scalar()

                if not result or result is None:
                    return None
                return result
            except Exception as e:
                print("An error has occured", e)
                raise e

    async def delete(self, session_id: str) -> bool:
        """Delete user verification data """
        async with self.db_adapter.session() as session, session.begin():
            try:
                query = delete(self.model).where(
                    self.model.session_id == session_id)

                result = await session.execute(query)

                if result.rowcount < 1:
                    return False

                return True
            except Exception as e:
                print("An error has occured", e)
                await self.db_adapter.rollback(session)
                raise e
            
