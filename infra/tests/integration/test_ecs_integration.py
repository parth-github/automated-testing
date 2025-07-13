import boto3
import pytest
import time

REGION = "us-east-1"  # Adjust if needed
CLUSTER_NAME = "fargate-cluster"
SERVICE_NAME = "sample-service"
TASK_FAMILY = "sample-task"

ecs = boto3.client("ecs", region_name=REGION)
elbv2 = boto3.client("elbv2", region_name=REGION)


def test_ecs_cluster_exists():
    response = ecs.describe_clusters(clusters=[CLUSTER_NAME])
    assert len(response["clusters"]) == 1
    assert response["clusters"][0]["status"] == "ACTIVE"


def test_task_definition_registered():
    response = ecs.list_task_definitions(familyPrefix=TASK_FAMILY)
    assert len(response["taskDefinitionArns"]) > 0


def test_ecs_service_running():
    response = ecs.describe_services(cluster=CLUSTER_NAME, services=[SERVICE_NAME])
    assert len(response["services"]) == 1
    service = response["services"][0]
    assert service["status"] == "ACTIVE"
    assert service["runningCount"] >= 1


# def test_service_health_check_passes():
#     response = ecs.describe_services(cluster=CLUSTER_NAME, services=[SERVICE_NAME])
#     service = response["services"][0]
#     tg_arn = service["loadBalancers"][0]["targetGroupArn"]

#     # Wait a few seconds for targets to register
#     time.sleep(5)

#     health = elbv2.describe_target_health(TargetGroupArn=tg_arn)
#     statuses = [t["TargetHealth"]["State"] for t in health["TargetHealthDescriptions"]]
#     assert all(s == "healthy" for s in statuses)
