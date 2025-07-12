import boto3
from moto import mock_ecs
import pytest

@mock_ecs
def test_create_and_describe_service():
    ecs = boto3.client("ecs", region_name="us-east-1")

    # Create a cluster
    cluster = ecs.create_cluster(clusterName="test-cluster")
    cluster_arn = cluster["cluster"]["clusterArn"]

    # Register a task definition (required before creating a service)
    ecs.register_task_definition(
        family="test-task",
        containerDefinitions=[
            {
                "name": "test-container",
                "image": "busybox",
                "memory": 64,
                "cpu": 1,
                "essential": True,
            }
        ],
    )

    # Create a service
    service = ecs.create_service(
        cluster=cluster_arn,
        serviceName="test-service",
        taskDefinition="test-task",
        desiredCount=1,
    )

    # Describe the service
    response = ecs.describe_services(cluster=cluster_arn, services=["test-service"])
    assert len(response["services"]) == 1
    assert response["services"][0]["serviceName"] == "test-service"