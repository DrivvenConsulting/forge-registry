# Workflow: Testing & Validation (Phase 4)

Validate implementation against the spec and subtasks: produce a QA report with pass/fail per acceptance criterion, integration test results, and a recommendation (Approve / Fix / Escalate). This is Phase 4 of the AI Spec-Driven Development Framework.

**Workflow id:** `testing-validation`  
**Phases:** 4

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.
- **Human review:** Human must review and sign off before deployment.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| issue_ids | User | Issue number(s) or URLs that were implemented. |
| spec | User | Spec file or path (acceptance criteria to validate against). |
| implementation_refs | User | PR(s), commit(s), or deployment refs to validate. |
| owner | User | GitHub org or owner. |
| repo | User | Repository name. |

## Outputs

- **QA report** – Pass/fail per acceptance criterion, integration test results, and a recommendation (Approve / Fix / Escalate). Every test must map to an acceptance criterion or a real integration point; no superficial tests.

## Implementing skills

**Registry skill ids:** qa-validation, aws-cli; aws-cognito-integration-check, aws-api-gateway-integration-check, aws-lambda-integration-check; github-issue-operations, github-pr-operations (for issue/PR context).

## Steps

1. **Spec validation:** Run the **qa-validation** skill against the spec and implementation. Map each test to an acceptance criterion.
2. **Integration validation (if applicable):** Run the **aws-cli** skill for integration checks on deployed or target services.
3. **Produce QA report** – Per-criterion pass/fail with evidence, plus recommendation (Approve / Fix / Escalate). Human must review and sign off before deployment.

## Agent rules (Phase 4)

- Spec validation: always use the `qa-validation` skill.
- Integration validation: always use the `aws-cli` skill.
- Every test must map to an acceptance criterion or a real integration point. No superficial tests.
- **Human must review and sign off before deployment.**

## How to reference in Cursor

- Install to `.cursor/workflows/testing-validation/`.
- Run the workflow with id **testing-validation**. Use the prompt in `prompts/workflows/testing-validation.md` for plan mode and required inputs.
