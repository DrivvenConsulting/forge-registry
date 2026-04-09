---
name: postman-collection-sync
description: Sync new or modified API endpoints to the Postman Adlyze workspace. Use after implementing or modifying API endpoints to keep the collection current.
---

# Postman Collection Sync

Keep the Postman **Adlyze** workspace up to date whenever a backend API endpoint is created or modified. This skill locates or creates the relevant collection, updates request definitions, response examples, and authentication settings so the workspace always reflects the deployed API contract.

## When to Use

- You have just implemented or modified one or more API endpoints and need to reflect those changes in the shared API workspace.
- The work item scope includes API contract changes (new routes, changed request/response models, updated auth requirements).

Equip this skill after completing API implementation steps; do not reference Postman tool or MCP names in agent instructions — this skill encapsulates the mechanism.

## Steps

1. **Identify scope** – From the implementation work item and the API changes in the PR, list every new or modified endpoint: HTTP method, path, request body schema, response schema, and authentication requirement.
2. **Locate the Adlyze workspace** – Use the available Postman integration to find the workspace named "Adlyze". If multiple workspaces match, use the one whose slug or name exactly equals "Adlyze".
3. **Find or create the collection** – Search the Adlyze workspace for a collection matching the API domain (e.g. the service or resource group). If a matching collection exists, use it; if not, create a new collection inside the Adlyze workspace with a name derived from the service or resource group (e.g. "User Management API").
4. **Update request definitions** – For each endpoint in scope:
   - If the request already exists in the collection, update its method, path, headers, body schema, and query parameters to match the implementation.
   - If the request does not exist, create it with a clear name (e.g. "Create User"), the correct method and URL template, and any required headers.
5. **Update response examples** – Add or refresh at least one example response per request: the happy-path 2xx response with a realistic payload derived from the Pydantic response model. Add relevant error examples (400, 401, 403, 404) where applicable.
6. **Set authentication** – Apply the correct auth type at the collection or folder level (e.g. Bearer token / Cognito JWT) so consumers can authenticate without per-request setup. Do not hardcode token values; use Postman variables (e.g. `{{access_token}}`).
7. **Verify and report** – Confirm all updated items are saved in the Adlyze workspace. Report a short sync summary: workspace name, collection name, endpoints added/updated, and any items skipped with the reason.

## Do

- Work within the existing Adlyze workspace; do not create a new workspace.
- Use Postman variables for environment-specific values (base URLs, tokens, IDs) so the collection is portable across environments.
- Derive collection and folder names from the service/resource domain, not from implementation detail (e.g. "Orders API", not "order_router.py").
- If the Postman integration is unavailable or unauthenticated, stop and report which capability is missing; do not proceed silently.

## Do Not

- Hardcode environment-specific base URLs, secret values, or credentials in request definitions; use Postman variables.
- Rename or delete existing requests outside the scope of the current work item; only add or update what was implemented in this PR.
- Create a new Postman workspace; always use the existing Adlyze workspace.
