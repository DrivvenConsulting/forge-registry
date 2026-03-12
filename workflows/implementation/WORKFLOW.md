# Workflow: Implementation (Phase 3)

Implement one or more GitHub issues: produce code commits and infrastructure changes. This is Phase 3 of the AI Spec-Driven Development Framework.

**Workflow id:** `implementation`  
**Phases:** 3

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| issue_ids | User | One or more issue numbers (or URLs) to implement. |
| owner | User | GitHub org or owner. |
| repo | User | Repository containing the issues. |
| target_repo | User | Target repository for implementation (may be same as repo). |

## Outputs

- **Code commits and/or infrastructure changes** – PRs linked to the respective issues. If a gap is discovered not covered by any subtask, stop, create a gap report, and route back to Phase 2. Never patch silently.

## Implementing skills

**Registry skill ids:** api-implementation, ui-implementation, terraform; backend-task-breakdown, lovable-prompts, terraform-github-actions; github-issue-operations, github-pr-operations (for fetching issues and opening PRs).

## Steps

1. **Fetch issue(s)** – Load the specified issues and their subtasks. Confirm scope (backend, frontend, devops, data) from labels or body.
2. **Run the appropriate implementation agent(s):**
   - **Backend/APIs:** Use the **api-implementation** skill.
   - **Frontend/UI:** Use the **ui-implementation** skill.
   - **Infrastructure/DevOps:** Use the **terraform** skill.
3. **Gap handling:** If a gap is discovered not covered by any subtask, stop, document the gap, and route back to Phase 2. Do not patch silently.

## Agent rules (Phase 3)

- Backend: when implementing APIs, always use the `api-implementation` skill.
- Frontend: when building UI, always use the `ui-implementation` skill.
- DevOps: when touching infrastructure, always use the `terraform` skill.
- All agents: if a gap is discovered not covered by any subtask, stop, create a gap report, and route back to Phase 2. Never patch silently.

## How to reference in Cursor

- Install to `.cursor/workflows/implementation/`.
- Run the workflow with id **implementation**. Use plan mode and required inputs per this file.
