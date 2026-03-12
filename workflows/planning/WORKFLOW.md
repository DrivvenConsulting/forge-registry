# Workflow: Planning (Phase 2)

Turn a spec from Phase 1 into GitHub issues with subtasks, each referencing at least one acceptance criterion. This is Phase 2 of the AI Spec-Driven Development Framework.

**Workflow id:** `planning`  
**Phases:** 2

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| spec | User | Spec file or path from Phase 1 (requirements, acceptance criteria, success metrics). |
| owner | User | GitHub org or owner for issue creation. |
| repo | User | Repository name for issues. |
| project (optional) | User | Optional project board ID or name to add issues to. |

## Outputs

- **GitHub issues** – With subtasks, each referencing at least one acceptance criterion. If the spec mentions infrastructure, validate assumptions using aws-context before creating subtasks.

## Implementing skills

**Registry skill ids:** github-issue, github-issue-operations, github-issue-creation-standards, github-sub-issue-linking, github-project-board; aws-context, aws-resource-discovery (when spec involves infra).

## Steps

1. **Validate infrastructure (if applicable):** If the spec involves infrastructure or AWS, run the **aws-context** skill to validate assumptions before creating subtasks. Do not invent requirements; if a dependency is missing from the spec, loop back to Phase 1.
2. **Run the planning agent** with the spec, owner, and repo. The agent must use the **github-issue** skill to create issues and subtasks, each mapped to at least one acceptance criterion.
3. **Optional:** Add created issues to the specified project board.

## Agent rules (Phase 2)

- When creating issues, always use the `github-issue` skill.
- When validating infrastructure assumptions, always use the `aws-context` skill before creating subtasks.
- If a dependency is missing from the spec, loop back to Phase 1. Do not invent requirements.

## How to reference in Cursor

- Install to `.cursor/workflows/planning/`.
- Run the workflow with id **planning**. Use plan mode and required inputs per this file.
