import boto3
import pytest

ecs = boto3.client('ecs')

CLUSTER_NAME = "your-ecs-cluster"
SERVICE_NAME = "your-ecs-service"

def test_ecs_service_exists():
    services = ecs.list_services(cluster=CLUSTER_NAME)
    assert any(SERVICE_NAME in arn for arn in services['serviceArns']), f"ECS Service {SERVICE_NAME} not found"

def test_service_running_task_count():
    response = ecs.describe_services(cluster=CLUSTER_NAME, services=[SERVICE_NAME])
    service = response['services'][0]
    assert service['runningCount'] > 0, "No running tasks in service"

# test_ecs.py using boto3
def test_ecs_service_created():
    ecs = boto3.client("ecs")
    services = ecs.list_services(cluster="my-cluster")
    assert "my-ecs-service" in services["serviceArns"]

def test_ecs_service_task_definition():
    ecs = boto3.client("ecs")
    response = ecs.describe_services(cluster="my-cluster", services=["my-ecs-service"])
    task_definition = response["services"][0]["taskDefinition"]
    assert task_definition == "my-task-definition:1", "Task definition does not match expected value"
