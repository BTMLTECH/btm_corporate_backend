import pytest
from app.tests.core.test_container import container

@pytest.fixture
def service(container):
    return container.transportation_service()
