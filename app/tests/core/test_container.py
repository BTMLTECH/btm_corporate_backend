from unittest.mock import AsyncMock, Mock
from dependency_injector import containers, providers
import pytest

from app.services.transportation_service import TransportationService


class TestContainer(containers.DeclarativeContainer):
    """Test container for transportation service tests"""

    # Mock repository
    transportation_repository = providers.Factory(
        Mock,
        create=AsyncMock(),
        delete_by_id=AsyncMock()
    )

    # Service with mocked repository
    transportation_service = providers.Factory(
        TransportationService,
        transportation_repository=transportation_repository
    )


@pytest.fixture
def container():
    container = TestContainer()
    container.init_resources()
    return container