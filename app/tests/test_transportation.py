from uuid import UUID
import pytest
from app.core.exceptions import DuplicatedError
from app.model.transportation import Transportation
from app.schema.transportation_schema import CreateTransportation
from app.tests.services.test_transportation_service import service
from app.tests.repositories.test_transportation_repository import repository
from app.tests.core.test_container import container


@pytest.fixture
def valid_transportation_data():
    return {
        "name": "Test Transportation 1",
        "description": "Test Description",
        # Add other required fields based on your Transportation model
    }


@pytest.mark.asyncio
async def test_add_transportation_success(container, service, repository, valid_transportation_data):
    # Arrange
    schema = CreateTransportation(**valid_transportation_data)
    expected_transportation = Transportation(**valid_transportation_data)
    repository.create.return_value = expected_transportation
    
    # Act
    result = await service.add(schema)
    
    # Assert
    assert isinstance(result, Transportation)
    repository.create.assert_awaited_once_with(schema)


@pytest.mark.asyncio
async def test_add_transportation_duplicate_error(container, service, repository, valid_transportation_data):
    # Arrange
    schema = CreateTransportation(**valid_transportation_data)
    repository.create.side_effect = DuplicatedError(detail="Transportation exists!")
    
    # Act & Assert
    with pytest.raises(DuplicatedError) as exc_info:
        await service.add(schema)
    
    assert str(exc_info.value.detail) == "Transportation exists!"
    repository.create.assert_awaited_once_with(schema)


@pytest.mark.asyncio
async def test_delete_transportation_success(container, service, repository):
    # Arrange
    transportation_id = str(UUID('12345678-1234-5678-1234-567812345678'))
    repository.delete_by_id.return_value = True
    
    # Act
    result = await service.delete_by_id(transportation_id)
    
    # Assert
    assert result is True
    repository.delete_by_id.assert_awaited_once_with(UUID(transportation_id))


@pytest.mark.asyncio
async def test_delete_transportation_not_found(container, service, repository):
    # Arrange
    transportation_id = str(UUID('12345678-1234-5678-1234-567812345678'))
    repository.delete_by_id.return_value = False
    
    # Act
    result = await service.delete_by_id(transportation_id)
    
    # Assert
    assert result is False
    repository.delete_by_id.assert_awaited_once_with(UUID(transportation_id))


@pytest.mark.asyncio
async def test_delete_transportation_invalid_uuid(container, service, repository):
    # Arrange
    invalid_id = "not-a-uuid"
    
    # Act & Assert
    with pytest.raises(ValueError):
        await service.delete_by_id(invalid_id)
    
    repository.delete_by_id.assert_not_awaited()


# # Add test for BaseService inheritance
# @pytest.mark.asyncio
# async def test_base_service_methods_available(service):
#     # Assert that methods from BaseService are available
#     assert hasattr(service, 'create')
#     assert hasattr(service, 'delete_by_id')
#     # assert hasattr(service, 'update')