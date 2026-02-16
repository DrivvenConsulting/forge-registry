# Workflow: Full story delivery

End-to-end flow from a parent GitHub issue in **Todo** to refined sub-issues, implementation ([ops] then [dev]), QA verification, and optional post-deploy integration test.

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided. Optional inputs (marked "User (optional)" in the table) may use defaults or be prompted as needed.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| owner | User | GitHub org or owner. |
| repo | User | Repository name. |
| issue_number | User | Parent issue number. |
| target_repo | User | Target repository. |
| run_integration_test | User (optional) | If true, run integration-tester after QA using discovered/env endpoints. Default: false. |

## Outputs

- **Sub-issues created and linked** – From step 1 (tech-lead).
- **PR(s) for [dev] and [ops]** – From devops-engineer and backend-engineer.
- **AC verification JSON** – From qa-tester.
- **Integration test report** – From integration-tester (only if run_integration_test is true).

## Steps

1. **Run tech-lead** (issue refinement) with owner, repo, issue_number, target_repo. Output: sub-issues, root in Ready or Backlog, summary comment. If root is left in Backlog due to blockers, stop or resolve blockers before continuing.

2. **If [ops] sub-issues exist:** Run devops-engineer with parent issue and target_repo. Wait for [ops] PRs to be merged or in review.

3. **Run backend-engineer** with parent issue and target_repo. Wait for [dev] PRs to be merged or ready for QA.

4. **Run qa-tester** with [qa] sub-issue (or parent) and the list of PRs from [dev]/[ops]. Output: AC verification JSON.

5. **If run_integration_test:** After deployment (CI/CD or manual), run integration-tester with region, environment, and endpoints. Endpoints can be taken from the [qa] sub-issue body (after QA discovery), from the tech-lead summary, or from user input.

## Conditionals

- **If [ops] sub-issues do not exist:** Skip step 2; run backend-engineer (step 3) then qa-tester (step 4).
- **If run_integration_test is false:** Skip step 5.

## How to reference in Cursor

- Install to `.cursor/workflows/full-story-delivery/`.
- Run steps 1 through 4 in order; optionally run step 5 after deploy.
- An orchestrator agent can read this file and invoke tech-lead, devops-engineer (if [ops]), backend-engineer, qa-tester, and optionally integration-tester, passing context between steps.
