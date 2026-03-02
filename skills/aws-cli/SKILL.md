---
name: aws-cli
description: Integration validation of deployed AWS services (Cognito, API Gateway, Lambda, etc.) via aws-*-integration-check skills and read-only CLI.
---

# AWS CLI / Integration Validation (Phase 4)

When performing integration validation in Phase 4 (Testing & Validation), use this skill. It is satisfied by **aws-cognito-integration-check**, **aws-api-gateway-integration-check**, and **aws-lambda-integration-check** (and read-only AWS CLI where needed) to validate that deployed services exist, are configured correctly, and interoperate (e.g. Cognito auth → API Gateway → Lambda).

## When to Use

- You are in Phase 4 and need to validate deployed AWS services (not mocks).
- The spec or QA scope includes integration checks (Cognito, API Gateway, Lambda, etc.).
- The **qa-tester** agent uses this skill in **integration validation mode** (post-deploy AWS validation).

Equip this skill when your role is integration testing. Use the aws-*-integration-check skills for structured validation; use read-only AWS CLI for additional checks. **Human must review and sign off before deployment.**

## Steps

1. **Collect identifiers** – Region, environment, resource names/IDs, base URLs from the issue or spec.
2. **Validate each service** – Use the appropriate aws-*-integration-check skill (Cognito, API Gateway, Lambda) to verify existence and key configuration.
3. **Validate interoperability** – e.g. Cognito auth → API Gateway → Lambda execution.
4. **Run discovery helpers (optional)** – Use `scripts/aws-discover-resources.sh` in this skill (or equivalent AWS CLI commands) to list Cognito user pools, Lambda functions, REST APIs, DynamoDB tables, S3 buckets, and SNS topics in the target account and region.
5. **Report results** – Pass/fail per check, evidence, remediation hints. Include the AWS profile used if relevant.
6. **Recommendation** – Feed into the QA report (Approve / Fix / Escalate). Human must sign off before deployment.

## Do

- Use only read-only or validation operations; do not change production.
- Map each check to an acceptance criterion or real integration point.

## Do Not

- Run destructive or mutating commands against production.
- Deploy without human sign-off.

## References

- Helper script: `scripts/aws-discover-resources.sh`
- AWS CLI usage details: see `references/REFERENCE.md`

