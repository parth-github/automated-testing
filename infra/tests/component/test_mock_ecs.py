from unittest.mock import patch
import boto3

@patch("boto3.client")
def test_mock_ecs_service(mock_boto_client):
    mock_ecs = mock_boto_client.return_value

    # Mock the list_services response
    mock_ecs.list_services.return_value = {
        'serviceArns': ['arn:aws:ecs:us-east-1:1234567890:service/my-service']
    }

    ecs = boto3.client('ecs', region_name='us-east-1')
    services = ecs.list_services(cluster='fake-cluster')

    assert 'my-service' in services['serviceArns'][0]
