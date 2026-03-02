---
name: aws-resource-discovery
description: Read-only AWS CLI exploration (Cognito, DynamoDB, Lambda, S3, SNS, API Gateway, etc.). Use when you need to list or describe existing AWS resources for feasibility or QA discovery.
---

# AWS Resource Discovery

Discover existing AWS resources in an account using read-only operations. List or describe Cognito user pools, DynamoDB tables, Lambda functions, S3 buckets, SNS topics, API Gateway APIs, and related resources without creating or modifying anything.

## When to Use

- You need to check which AWS resources exist before or after implementation (technical feasibility, QA discovery).
- You need to document existing resources and how they relate to an issue (e.g. endpoints, ARNs, environment).
- You need to derive endpoints or resource identifiers (e.g. API ID, function names, User Pool ID) for verification or for updating an issue body.

Equip this skill when your role includes read-only AWS discovery; do not hardcode tool or MCP names in agent logic.

## Steps

1. **Choose resources to discover** – From the issue or task, identify which resource types are relevant (e.g. Cognito, DynamoDB, Lambda, S3, SNS, API Gateway). Use read-only commands only (e.g. list-user-pools, list-tables, list-functions, ls, list-topics, get-rest-apis).
2. **Run discovery** – Use the available AWS integration to execute the read-only commands in the appropriate region and account. You can also run the local helper script `skills/aws-cli/scripts/aws-discover-resources.sh` to get a quick overview. Do not create, update, or delete any resources.
3. **Document findings** – Record which resources exist, their identifiers (IDs, ARNs, names), and how they relate to the issue. For APIs, record base URLs or endpoint patterns (e.g. environment, API Gateway base URL).
4. **Report gaps** – If expected resources do not exist, state that explicitly (e.g. "Resource does not exist; to be created by Terraform" or "Endpoints to be discovered by QA after implementation").

## Do

- Use only read-only AWS operations.
- Specify region and account when relevant (e.g. sa-east-1, dev vs prod account).
- Align with project conventions (e.g. single allowed region, account IDs per environment).

## Do Not

- Create or modify any AWS resources from this skill.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.

## References

- AWS discovery commands and examples: see `references/REFERENCE.md`

