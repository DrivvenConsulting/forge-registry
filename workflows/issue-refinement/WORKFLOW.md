# Workflow: Issue refinement

Turn a parent GitHub issue in **Todo** into refined [dev]/[ops]/[qa] sub-issues and move the root issue to **Ready** (or leave in Backlog with a comment if blocked).

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

- **Sub-issues created and linked** – [dev], [ops] (if infra needed), and [qa] sub-issues under the parent, with correct title prefixes.
- **Root issue in Ready or Backlog** – Moved to Ready when refinement is complete; left in Backlog with a comment if blocked.
- **Summary comment on parent** – Findings (AWS resources, related repos), environment and endpoints, list of sub-issues, and whether the story was moved to Ready or left in Backlog with reason.

## Steps

1. **Run tech-lead** with inputs: `owner`, `repo`, `issue_number`, and optionally `target_repo`. The tech-lead agent will analyze the issue, check AWS resources and related repos (read-only), create prefixed sub-issues, and move the root to Ready or leave it in Backlog with a comment.

## Conditionals

- None. This workflow is a single-agent step.

## How to reference in Cursor

- Install this workflow to `.cursor/workflows/issue-refinement/` (e.g. via `forge install workflow issue-refinement` if supported).
- Run the tech-lead agent with the inputs above; no further steps required for this workflow.
- An orchestrator agent can read this file and prompt for owner, repo, and issue_number, then invoke the tech-lead agent.
