import json
from pydantic import BaseModel, constr, conint, HttpUrl

class TaskDefinitionContract(BaseModel):
    family: str
    cpu: conint(gt=0)
    memory: conint(gt=0)
    networkMode: constr(regex='^(awsvpc|bridge|host)$')
    taskRoleArn: str
    containerDefinitions: list

def test_task_definition_contract():
    with open("artifacts/task_def.json") as f:
        data = json.load(f)
    TaskDefinitionContract.model_validate(data)


# Generate a sample task definition JSON for testing
def generate_sample_task_definition():  
    return {
        "family": "sample-task",
        "cpu": 256,
        "memory": 512,
        "networkMode": "awsvpc",
        "taskRoleArn": "arn:aws:iam::123456789012:role/ecsTaskExecutionRole",
        "containerDefinitions": [
            {
                "name": "sample-container",
                "image": "nginx:latest",
                "essential": True,
                "portMappings": [
                    {
                        "containerPort": 80,
                        "hostPort": 80
                    }
                ]
            }
        ]
    }