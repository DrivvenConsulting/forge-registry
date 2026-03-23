---
name: aws-context
description: Validate infrastructure assumptions before creating subtasks. Read-only; use when planning work that involves AWS.
---

# AWS Context (Planning)

Validate infrastructure assumptions before creating subtasks or issues. Use **read-only** exploration so planning is grounded in what actually exists (or explicitly document what does not exist yet). This skill delegates to **aws-resource-discovery** for the actual discovery; use it whenever the spec or plan involves AWS resources.

## When to Use

- You are in Phase 2 (Planning) and the spec mentions infrastructure or AWS.
- You need to validate that assumed resources exist (or document that they will be created) before creating subtasks.
- Do not invent requirements; if a dependency is missing from the spec, loop back to Phase 1.

Equip this skill together with your issue-creation skills when the work involves AWS. The runner or environment should provide **aws-resource-discovery** (or equivalent read-only AWS discovery) to perform the checks.

## Steps

1. **Identify assumed resources** – From the spec or issue, list AWS resources that the feature assumes (e.g. Cognito, DynamoDB, Lambda, S3, API Gateway).
2. **Validate via discovery** – Use **aws-resource-discovery** (read-only) to list or describe those resources in the relevant region and account. Do not create or modify anything.
3. **Document findings** – Record which resources exist, their identifiers, and how they relate to the plan. If a resource does not exist, state that explicitly (e.g. "To be created by Terraform" or "Endpoints to be discovered by QA after implementation").
4. **Inform subtask creation** – Use this context when creating GitHub issues or subtasks so scope and environment/endpoints are accurate. If the spec is missing a dependency, do not invent it; loop back to Phase 1.

## Do

- Use only read-only operations.
- Specify region and account when relevant (e.g. sa-east-1, dev vs prod).

## Do Not

- Create or modify any AWS resources.
- Invent requirements; if something is missing from the spec, route back to Phase 1.
