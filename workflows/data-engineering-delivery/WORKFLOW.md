# Workflow: Data engineering delivery

Implement data ingestion, transformations, and models for a work item (or parent issue) in Ready. When the same parent has [dev] or [ops] sub-issues, coordinate with backend-engineer and devops-engineer per the parent's specified order.

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided. Optional inputs (marked "User (optional)" in the table) may use defaults or be prompted as needed.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| work_item_or_parent_issue | User | Work item in Ready (e.g. a data-specific issue or sub-issue), or parent issue from which to derive the data work item. |
| target_repo | User | Target repository. |

## Outputs

- **PR(s) linked to data work item** – From data-engineers agent.
- **Optional [dev]/[ops] PRs** – If the parent specifies backend or devops work, those agents run separately; this workflow documents the coordination.

## Steps

1. **Run data-engineers** with work_item_or_parent_issue and target_repo. The agent will implement data pipelines, models, and storage (e.g. Delta Lake in S3) and open a PR linked to the work item.

2. **Coordination with backend/devops:** If the parent issue also has [dev] or [ops] sub-issues and specifies an order (e.g. data then backend then devops), run backend-engineer and/or devops-engineer for those sub-issues in the specified order. This workflow does not invoke them automatically; the WORKFLOW.md serves as documentation. When running multiple agents for the same parent, stay within each agent's domain and avoid overlapping file or resource changes.

## Conditionals

- **If parent has only data work:** Step 1 only.
- **If parent has data + [dev]/[ops]:** Run data-engineers; then run backend-engineer and/or devops-engineer per parent order (document in workflow or run manually).

## How to reference in Cursor

- Install to `.cursor/workflows/data-engineering-delivery/`.
- Run data-engineers with the work item; if the same parent has [dev]/[ops] sub-issues, run the corresponding agents in the order specified by the parent or team.
- An orchestrator agent can read this file and invoke data-engineers, and optionally backend-engineer and devops-engineer, when the parent issue spans data and backend/infra.
