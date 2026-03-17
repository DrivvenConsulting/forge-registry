# Workflow: Testing & Validation (Phase 4)

Validate implementation against the spec and subtasks: produce a QA report with pass/fail per acceptance criterion, integration test results, and a recommendation (Approve / Fix / Escalate). This is Phase 4 of the AI Spec-Driven Development Framework.

**Workflow id:** `testing-validation`  
**Phases:** 4

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.
- **Tooling and access:** This workflow relies on GitHub and AWS integrations (CLI/MCP/API) for reading issues/PRs and performing integration validation. **If the required tooling or authentication is not available in the current environment, stop execution, explain what is missing, and ask the user to either authorize a suitable environment or run the external commands themselves. Do not attempt to create new credentials or reconfigure authentication silently.**
- **Human review:** Human must review and sign off before deployment.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| issue_ids | User | Issue number(s) or URLs that were implemented. Used to look up spec and implementation refs. |
| spec | GitHub Issue | Spec file or path (acceptance criteria to validate against), resolved from the issue(s) and their linked artifacts. |
| implementation_refs | GitHub Issue | PR(s), commit(s), or deployment refs to validate, resolved from the issue(s), their linked PRs, and project state. |
| owner | User | GitHub org or owner. |
| repo | User | Repository name. |

## Outputs

- **QA report** – Pass/fail per acceptance criterion, integration test results, and a recommendation (Approve / Fix / Escalate). Every test must map to an acceptance criterion or a real integration point; no superficial tests.

## Implementing skills

**Registry skill ids:** qa-validation, aws-cli; aws-cognito-integration-check, aws-api-gateway-integration-check, aws-lambda-integration-check; github-issue-operations, github-pr-operations (for issue/PR context).

## Steps

1. **Resolve spec and implementation refs from issues:**
   - Use **github-issue-operations** (and related GitHub skills) with `owner`, `repo`, and `issue_ids` to:
     - Locate the canonical spec (acceptance criteria) linked from the issue(s) (for example, spec files, Phase 1 artifacts, or in-issue spec sections).
     - Collect implementation references (linked PRs, commits, deployment notes, or environment links) associated with the issue(s).
   - Treat the resolved spec and implementation refs as the canonical inputs for this phase. If they cannot be resolved from the issue(s), stop and request human clarification or updates to the backlog before proceeding.
2. **Spec validation:** Run the **qa-validation** skill against the resolved spec and implementation refs. Map each test to an acceptance criterion.
3. **Integration validation (if applicable):** Run the **aws-cli** skill for integration checks on deployed or target services.
4. **Produce QA report** – Per-criterion pass/fail with evidence, plus recommendation (Approve / Fix / Escalate). Human must review and sign off before deployment.

## Agent rules (Phase 4)

- Spec validation: always use the `qa-validation` skill.
- Integration validation: always use the `aws-cli` skill.
- Every test must map to an acceptance criterion or a real integration point. No superficial tests.
- **Human must review and sign off before deployment.**

## How to reference in Cursor

- Install to `.cursor/workflows/testing-validation/`.
- Run the workflow with id **testing-validation**. Use plan mode and required inputs per this file.
