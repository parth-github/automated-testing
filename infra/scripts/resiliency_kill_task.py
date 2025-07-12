import boto3
import sys

CLUSTER_NAME = "your-ecs-cluster"
SERVICE_NAME = "your-ecs-service"

ecs = boto3.client("ecs")

def kill_one_task():
    try:
        tasks = ecs.list_tasks(cluster=CLUSTER_NAME, serviceName=SERVICE_NAME)
        if not tasks['taskArns']:
            print("[INFO] No tasks found to kill.")
            sys.exit(0)

        task_arn = tasks['taskArns'][0]
        response = ecs.stop_task(cluster=CLUSTER_NAME, task=task_arn, reason="Resiliency test")
        print(f"[SUCCESS] Stopped task: {task_arn}")
    except Exception as e:
        print(f"[ERROR] Failed to stop ECS task: {e}")
        sys.exit(1)

if __name__ == "__main__":
    kill_one_task()
