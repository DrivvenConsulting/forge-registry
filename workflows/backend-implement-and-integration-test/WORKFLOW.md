# Workflow: Backend implement and integration test

Implement backend (and infra if needed) for a refined issue, then validate deployed AWS services (Cognito, API Gateway, Lambda) using the integration-tester agent. Assumes deployment has been performed after PRs are merged.

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided. Optional inputs (marked "User (optional)" in the table) may use defaults or be prompted as needed.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| owner | User | GitHub org or owner. |
| repo | User | Repository name. |
| parent_issue_number | User | Parent issue number. |
| target_repo | User | Target repository. |
| ops_first | User (optional) | If true, run devops-engineer before backend-engineer when [ops] exist. |
| region | User | AWS region (e.g. sa-east-1). |
| environment | User | Environment (e.g. dev, prod). |
| base_url | User (optional) | API base URL or "discover from QA/tech-lead summary". |

## Outputs

- **PR(s) for [dev] and [ops]** – From backend-engineer and devops-engineer.
- **Integration test report** – Pass/fail by severity (Critical, High, Medium, Low) for Cognito, API Gateway, and Lambda.

## Steps

1. **Run devops-engineer** (if [ops] sub-issues exist) with parent issue and target_repo. Then **run backend-engineer** with parent issue and target_repo. Assume PRs are merged and deployment is done (by CI/CD or manual deploy).

2. **Run integration-tester** with: region, environment, and endpoints. Endpoints can come from the [qa] sub-issue body (after QA discovery), from the tech-lead summary comment, or from user input (base_url / resource identifiers). The integration-tester uses skills: aws-cognito-integration-check, aws-api-gateway-integration-check, aws-lambda-integration-check.

## Conditionals

- **If [ops] sub-issues exist:** Run devops-engineer before backend-engineer in step 1.
- **If endpoints are unknown:** Document "discover from QA/tech-lead summary" or run qa-tester first to populate the [qa] issue with discovered endpoints, then run integration-tester.

## How to reference in Cursor

- Install to `.cursor/workflows/backend-implement-and-integration-test/`.
- Run step 1 (implementation); after deploy, run step 2 (integration-tester) with region, environment, and endpoints.
- An orchestrator agent can read this file and invoke the agents in order, passing post-deploy context into the integration-tester step.
