# ECS Testing

This repository contains Terraform configurations and scripts for testing ECS deployments, including end-to-end tests, acceptance tests, resiliency tests, and performance tests.

## Workflow Overview

The GitHub Actions workflow defined in `.github/workflows/terraform-test.yaml` automates the testing process for ECS deployments. It includes steps for:

- Setting up the environment
- Initializing Terraform
- Planning and applying Terraform configurations
- Running end-to-end tests
- Running acceptance tests
- Running resiliency tests
- Running performance tests
- Validating post-deployment health checks
- Rolling back if health checks fail

## Scripts

The scripts in the `scripts/` directory are used to perform various tasks during the testing process:

- `e2e_test.py`: Runs end-to-end tests.
- `acceptance_test.py`: Runs acceptance tests.
- `resiliency_test.py`: Runs resiliency tests.
- `performance_test.py`: Runs performance tests.
- `health_check.py`: Validates the health of the deployment after applying changes.

## Usage

To run the tests, you can trigger the GitHub Actions workflow by pushing changes to the repository. The workflow will automatically execute the defined steps, including running the scripts and performing the necessary Terraform operations.

## Requirements

- Terraform
- Python 3.x
- Required Python packages (as specified in `requirements.txt`)
- GitHub Actions runner with access to AWS credentials
- SonarQube for code quality checks
- Grafana k6 for performance testing
- Checkov and tfsec for security scanning
- tfsec for Terraform code quality checks

## Deployment Pipeline Diagram

### 📦 ECS Fargate Deployment Pipeline (Terraform + GitHub Actions)

```mermaid
graph TD
    A[GitHub Push / PR] --> B[Terraform Validate & Lint]
    B --> C[Security Scan<br>(tfsec, checkov)]
    C --> D[Component Tests<br>pytest + boto3]
    D --> E[Terraform Plan]
    E --> F[Integration Tests]
    F --> G[Terraform Apply to Staging]
    G --> H[End-to-End + Acceptance + Contract Tests]
    H --> I[Blue/Green Deploy to Prod]
    I --> J[Post-Deployment Health Check]
    J -->|Pass| K[Promote to Green]
    J -->|Fail| L[Automatic Rollback]
    K --> M[Performance Tests]
    M --> N[Performance Monitoring]
    L --> O[Rollback to Last Known Good State]
    O --> P[Notify Dev Team]
    P --> Q[Continuous Monitoring & Alerts]
```

### Testing Flow Diagram

```mermaid
graph TD
    A[GitHub Push / PR] --> B[Terraform Validate & Lint]
    B --> C[Security Scan<br>(tfsec, checkov)]
    C --> D[Component Tests<br>pytest + boto3]
    D --> E[Terraform Plan]
    E --> F[Integration Tests]
    F --> G[Terraform Apply to Staging]
    G --> H[End-to-End + Acceptance + Contract Tests]
    H --> I[Blue/Green Deploy to Prod]
    I --> J[Post-Deployment Health Check]
    J -->|Pass| K[Promote to Green]
    J -->|Fail| L[Automatic Rollback]
    K --> M[Performance Tests]
    M --> N[Performance Monitoring]
    L --> O[Rollback to Last Known Good State]
    O --> P[Notify Dev Team]
    P --> Q[Continuous Monitoring & Alerts]
```

### 🧪 Full Test Matrix Flow

```mermaid
graph LR
    A[Terraform Validate]
    A --> B[Unit Tests]
    A --> C[Lint Check (tflint)]
    A --> D[Security (tfsec, checkov)]

    D --> E[Component Test<br>(boto3)]
    E --> F[Contract Test<br>(pydantic)]
    E --> G[Integration Test<br>(real apply)]

    G --> H[Acceptance Test<br>(behave)]
    H --> I[E2E Test<br>(Python Requests)]
    I --> J[Resiliency Test<br>(Kill ECS Task)]
    J --> K[Performance Test<br>(k6)]
    K --> L[Blue/Green Deploy]
    L --> M[Health Check]
    M -->|Fail| N[Rollback]
    M -->|Pass| O[Complete 🚀]
```


## Contributing

Contributions are welcome! If you have suggestions for improvements or new tests, please open an issue or submit a pull request.