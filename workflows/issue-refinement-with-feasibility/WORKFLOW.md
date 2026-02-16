# Workflow: Issue refinement with feasibility validation

Refine a parent GitHub issue into [dev]/[ops]/[qa] sub-issues, then have the backend-engineer and devops-engineer validate that [dev] and [ops] sub-issues are feasible and well-scoped before implementation starts.

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided. Optional inputs (marked "User (optional)" in the table) may use defaults or be prompted as needed.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| owner | User | GitHub org or owner. |
| repo | User | Repository name. |
| issue_number | User | Parent issue number. |
| target_repo | User (optional) | Target repository if different from issue repo. |

## Outputs

- **Sub-issues created and linked** – From step 1 (tech-lead).
- **Feasibility comment from backend** – Backend-engineer review of [dev] sub-issues (scope, feasibility); no code changes.
- **Feasibility comment from devops** – Devops-engineer review of [ops] sub-issues (scope, feasibility); no infra changes.
- **Root issue in Ready or Backlog** – In Ready if refinement and feasibility are OK; in Backlog with comment if blocked.

## Steps

1. **Run tech-lead** with inputs: `owner`, `repo`, `issue_number`, and optionally `target_repo`. Output: sub-issues created, root moved to Ready or Backlog, summary comment.

2. **Run backend-engineer** in review-only mode. Pass the parent issue (owner, repo, issue_number). Instruction: "Review [dev] sub-issues for feasibility and scope; do not implement; add a comment on the parent issue with feedback (feasibility, scope clarity, risks)." Use the parent issue and sub-issues from step 1 as context.

3. **Run devops-engineer** in review-only mode. Pass the parent issue (owner, repo, issue_number). Instruction: "Review [ops] sub-issues for feasibility and scope; do not implement; add a comment on the parent issue with feedback (feasibility, scope clarity, risks)." Use the parent issue and sub-issues from step 1 as context. If there are no [ops] sub-issues, skip this step.

## Conditionals

- **If no [ops] sub-issues exist:** Skip step 3 (devops-engineer).

## How to reference in Cursor

- Install to `.cursor/workflows/issue-refinement-with-feasibility/`.
- Run steps 1, 2, and 3 in order. For steps 2 and 3, ensure the agent is given the explicit "review only; do not implement" instruction so no PRs are opened.
- An orchestrator agent can read this file and run tech-lead first, then invoke backend-engineer and devops-engineer with the review-only prompt.
