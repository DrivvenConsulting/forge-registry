# Workflow: Implementation (Phase 3)

Implement one or more GitHub issues: produce code commits and infrastructure changes. This is Phase 3 of the AI Spec-Driven Development Framework.

**Workflow id:** `implementation`  
**Phases:** 3

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.
- **Tooling and access:** This workflow relies on GitHub and infrastructure tooling (CLI/MCP/API, Terraform, CI/CD) for fetching issues, updating code, and opening PRs. **If the required tooling or authentication is not available in the current environment, stop execution, explain what is missing, and ask the user to either authorize a suitable environment or run the external commands themselves. Do not attempt to create new credentials or reconfigure authentication silently.**

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| issue_ids | User | One or more issue numbers (or URLs) to implement. |
| owner | User | GitHub org or owner. |
| repo | User | Repository containing the issues. |
| target_repo | User | Target repository for implementation (may be same as repo). |

## Outputs

- **Code commits and/or infrastructure changes** – PRs linked to the respective implementation sub-issues (Task issues) and, when applicable, their parent feature issue. If a gap is discovered not covered by any subtask, stop, create a gap report, and route back to Phase 2. Never patch silently.
- **Repo alignment decision** – A short summary indicating whether the spec/feasibility definitions are aligned with the current repo state (`proceed` vs `re-plan`) plus any detected drift.

## Implementing skills

**Registry skill ids:** api-implementation, ui-implementation, terraform; backend-task-breakdown, lovable-prompts, terraform-github-actions; github-issue-operations, github-pr-operations (for fetching issues and opening PRs).

## Steps

0. **Review definitions vs repo state (required):**
   - Fetch the specified issues (and, when available, their parent feature issue) using **github-issue-operations** and gather:
     - The Phase 1 spec and any feasibility artifacts (`feature-definition.json`, `technical-feasibility.json`, `channel-feasibility-*.json`) from `artifacts/feature-definitions/<feature_name>/`.
     - The current `target_repo` state (key modules, services, infra definitions) relevant to the issues.
   - Compare the spec/feasibility definitions against the current repo state to detect drift, such as:
     - Renamed or removed services, APIs, or modules referenced in the spec or issues.
     - Significant contract changes (e.g. request/response schema changes) that invalidate acceptance criteria.
     - Infra resources that no longer exist or are materially different from the feasibility assumptions.
   - Produce a **repo alignment summary**:
     - If everything is consistent or only minor clarifications are needed, mark the decision as `proceed` and continue to Step 1.
     - If meaningful drift or gaps are found, stop implementation work, mark the decision as `re-plan`, and create a gap report attached to the parent issue (or project notes) so Phase 2 can update the spec and tasks before implementation resumes.

1. **Fetch issue(s)** – Load the specified issues and their subtasks. Confirm scope (backend, frontend, devops, data) from labels or body.
2. **Run the appropriate implementation agent(s):**
   - **Backend/APIs:** Use the **api-implementation** skill.
   - **Frontend/UI:** Use the **ui-implementation** skill.
   - **Infrastructure/DevOps:** Use the **terraform** skill.
3. **Gap handling:** If a gap is discovered not covered by any subtask (including from the repo alignment review), stop, document the gap, and route back to Phase 2. Do not patch silently.

## Agent rules (Phase 3)

- Backend: when implementing APIs, always use the `api-implementation` skill.
- Frontend: when building UI, always use the `ui-implementation` skill.
- DevOps: when touching infrastructure, always use the `terraform` skill.
- All agents: if a gap is discovered not covered by any subtask, stop, create a gap report, and route back to Phase 2. Never patch silently.
- All agents: when opening or updating a PR for work tracked by a sub-issue, always link the PR directly to that specific implementation sub-issue (Task issue) in GitHub (and, when relevant, also to the parent feature issue) so the board reflects the relationship.
- All agents: when working on a sub-issue that has a parent feature issue, ensure the sub-issue title is prefixed with the parent issue identifier in the form `[Parent #<parent-issue-number>]`. For example, `[#123] Implement API for feature X` becomes `[Parent #45] [#123] Implement API for feature X` if `#45` is the parent feature issue. Keep the rest of the sub-issue title intact.

## How to reference in Cursor

- Install to `.cursor/workflows/implementation/`.
- Run the workflow with id **implementation**. Use plan mode and required inputs per this file.
