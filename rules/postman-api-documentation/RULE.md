---
description: "API documentation standard: all new or modified endpoints must be synced to the Postman Adlyze workspace as part of implementation."
alwaysApply: false
---

# Postman API Documentation Standard

## Purpose

Ensure that every API endpoint created or modified during implementation is reflected in the shared Postman Adlyze workspace, so the API contract is always up to date and consumable by other teams, agents, and integration tests.

## Standard

- **All new API endpoints** created during a backend implementation work item must be added to the Postman Adlyze workspace before the PR is considered complete.
- **All modified API endpoints** (changed path, method, request/response schema, or auth requirement) must be updated in the Postman Adlyze workspace before the PR is considered complete.
- Updates must be made using the **postman-collection-sync** skill; do not update the Postman workspace manually or through undeclared tooling.
- Documentation must reflect the **actual implemented contract**: use Pydantic response models as the source of truth for response schemas; never document a contract that has not yet been implemented.
- Use Postman variables for all environment-specific values (base URLs, auth tokens, resource IDs). Do not hardcode environment values.

## Do

- Sync Postman after tests pass and before opening the PR (the final step of the api-implementation skill).
- Include the Postman sync confirmation in the PR description under "API / service changes" so reviewers can verify the collection is current.
- Group endpoints by service or resource domain (collection or folder) to keep the Adlyze workspace organized.

## Do Not

- Skip the sync because "the endpoint is internal" or "only used in tests" — all implemented endpoints belong in the collection.
- Hardcode tokens, secrets, or environment-specific URLs in the Postman collection.
- Create a new Postman workspace; always use the existing Adlyze workspace.
- Merge a PR that introduces or modifies API endpoints without confirming the Postman collection has been updated.
