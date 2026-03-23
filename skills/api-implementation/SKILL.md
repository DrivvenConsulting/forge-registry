---
name: api-implementation
description: Implement APIs and backend services using backend-task-breakdown and project rules (FastAPI, architecture-decoupling).
---

# API Implementation (Phase 3)

When implementing backend APIs and services, use this skill to ensure consistent structure: thin endpoints, service-layer business logic, and project rules (e.g. **framework-fastapi**, **architecture-decoupling**). This skill delegates to **backend-task-breakdown** for task decomposition and relies on project rules for patterns.

## When to Use

- You are in Phase 3 (Implementation) and the work item is backend/API work.
- You need to implement or extend API endpoints, services, and tests.

Equip this skill when your role is backend implementation. Use **backend-task-breakdown** for breaking down user stories into tasks; follow **framework-fastapi**, **architecture-decoupling**, **security-authentication**, and **code-quality-python** (or equivalent project rules).

## Steps

1. **Scope from the work item** – Read user stories and acceptance criteria; use **backend-task-breakdown** to derive API, service, and test tasks.
2. **Implement endpoints and services** – Keep endpoints thin; delegate business logic to services. Use request/response models and dependency injection per project rules.
3. **Auth and validation** – Apply authentication (e.g. JWT, Cognito) and authorization on protected routes; validate inputs with Pydantic.
4. **Integrate data layer** – Use repositories or abstractions; do not put data access directly in endpoints.
5. **Tests** – Add or extend tests (e.g. pytest) for new or changed behavior; mirror source layout in `tests/`.
6. **Gap handling** – If a gap is discovered not covered by any subtask, stop, create a gap report, and route back to Phase 2. Never patch silently.

## Do

- Follow project backend and security rules.
- Map each acceptance criterion to implementation in the PR description.

## Do Not

- Put business logic in route handlers.
- Patch gaps silently; always document and route back to Phase 2.
