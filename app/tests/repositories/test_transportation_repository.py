import pytest
from app.tests.core.test_container import container

@pytest.fixture
def repository(container):
    return container.transportation_repository()