# Workflow: Backend full cycle

Implement all [dev] (and optionally [ops]) work for a refined parent issue and run QA verification. Assumes the parent issue has already been refined (sub-issues exist and root is in Ready).

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided. Optional inputs (marked "User (optional)" in the table) may use defaults or be prompted as needed.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| owner | User | GitHub org or owner. |
| repo | User | Repository name. |
| parent_issue_number | User | Parent issue number (sub-issues will be fetched from it). |
| target_repo | User | Target repository for implementation. |
| ops_first | User (optional) | If true, run devops-engineer for [ops] before backend-engineer for [dev]. Default: true when [ops] sub-issues exist. |

## Outputs

- **PR(s) for [dev] and [ops]** – One PR per [dev] sub-issue and per [ops] sub-issue, linked to the respective sub-issue.
- **AC verification JSON** – From qa-tester: per–acceptance-criterion pass/fail with evidence.

## Steps

1. **If [ops] sub-issues exist and ops_first:** Run devops-engineer with work item = parent issue (owner, repo, parent_issue_number). The agent will fetch [ops] sub-issues and implement them. Wait for PRs to be merged or in review before proceeding (or proceed when PRs are linked and ready for QA).

2. **Run backend-engineer** with work item = parent issue (owner, repo, parent_issue_number) and target_repo. The agent will fetch [dev] sub-issues and implement each, opening one PR per sub-issue. Wait for PRs to be merged or ready for QA.

3. **Run qa-tester** with work item = [qa] sub-issue (or parent issue). Pass PR references (from [dev] and [ops] sub-issues). The agent will verify each parent acceptance criterion against the implementation and produce the AC verification JSON.

## Conditionals

- **If [ops] sub-issues exist and ops_first is true:** Run step 1 (devops-engineer) before step 2 (backend-engineer).
- **If no [ops] sub-issues exist:** Skip step 1; run backend-engineer then qa-tester.

## How to reference in Cursor

- Install to `.cursor/workflows/backend-full-cycle/`.
- Run steps in order. After step 2 (and step 1 if applicable), ensure PRs are linked to sub-issues; then run qa-tester with the [qa] work item and PR list.
- An orchestrator agent can read this file, fetch sub-issues from the parent, and invoke devops-engineer (if [ops] exist), backend-engineer, and qa-tester in sequence.
