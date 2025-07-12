import requests
from behave import given, when, then

ENDPOINT = "https://your-ecs-service.example.com/health"

@given("the ECS service endpoint is deployed")
def step_impl(context):
    context.endpoint = ENDPOINT

@when("I perform a health check")
def step_impl(context):
    context.response = requests.get(context.endpoint, timeout=5)

@then("the service should return status 200")
def step_impl(context):
    assert context.response.status_code == 200
