Feature: ECS Fargate Service Availability

  Scenario: ECS service is healthy after deployment
    Given the ECS service endpoint is deployed
    When I perform a health check
    Then the service should return status 200
