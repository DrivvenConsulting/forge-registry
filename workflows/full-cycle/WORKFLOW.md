# Workflow: Full cycle (Phases 1→5)

Run the complete AI Spec-Driven Development lifecycle from raw idea through deployment and monitoring: Discovery → Planning → Implementation → Testing & Validation → Feedback & Monitoring. Output is a feedback report after the feature is deployed and monitored.

**Workflow id:** `full-cycle`  
**Phases:** 1→5

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.
- **Tooling and access:** This workflow orchestrates other phases that depend on GitHub, AWS, Terraform, monitoring, and other integrations. **If any required CLI, MCP, or external API access for a downstream phase is not available or not authenticated in the current environment, stop before that phase, explain what is missing, and ask the user to either authorize a suitable environment or run the external steps themselves. Do not attempt to create new credentials or reconfigure authentication silently.**
- **Human checkpoints:** Phase 4 requires human sign-off before deployment. Phase 5 requires human decision on hotfix vs. new feature.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| raw_idea | User | Raw idea or problem statement. |
| owner | User | GitHub org or owner (for issues and implementation). |
| repo | User | Repository name. |
| target_repo | User | Target repository for implementation. |
| context (optional) | User | Optional vision doc, constraints, or prior context. |

## Outputs

- **Phase 1:** Spec file.
- **Phase 2:** GitHub issues with subtasks.
- **Phase 3:** Code commits, infrastructure changes (PRs).
- **Phase 4:** QA report and human sign-off before deployment.
- **Phase 5:** Feedback report (metrics vs. success criteria, flagged issues, improvement ideas).

## Implementing skills

**Registry skill ids:** All skills from discovery, planning, implementation, testing-validation, and feedback-monitoring (spec-writing, github-issue, aws-context, api-implementation, ui-implementation, terraform, qa-validation, aws-cli, monitoring, plus delegated skills per phase).

## Steps

1. **Discovery (Phase 1):** Run the **discovery** workflow with **product-owner** in spec-writing mode (and optional feasibility pass when configured with a feature name). Output: spec file with acceptance criteria and success metrics (and, optionally, feasibility artifacts). Discovery does **not** create GitHub issues.
2. **Planning (Phase 2):** Run the **planning** workflow with the spec (and any feasibility artifacts). Output: GitHub issues with subtasks mapped to acceptance criteria. All parent issues and subissues are created in this phase.
3. **Implementation (Phase 3):** Run the **implementation** workflow with the created issue IDs. Output: PRs and infra changes. If gaps are found, route back to Phase 2 (or Phase 1 if spec gap).
4. **Testing & Validation (Phase 4):** Run the **testing-validation** workflow with issue IDs, spec, and implementation refs. Output: QA report. **Human must sign off before deployment.**
5. **Deployment:** Deploy to target environment (process is team-specific; this workflow assumes deployment happens here).
6. **Feedback & Monitoring (Phase 5):** Run the **feedback-monitoring** workflow with deployed feature ref, acceptance criteria, and production logs/metrics. Output: Feedback report. **Human reviews and decides: hotfix or new feature.**

## Conditionals

- **Gap in spec (Phase 1):** Loop back to Discovery; do not invent requirements in Planning.
- **Gap in tasks (Phase 2):** Document gap, loop back to Planning (or Discovery if spec change needed).
- **Gap during implementation (Phase 3):** Stop, create gap report, route back to Phase 2. Never patch silently.
- **Phase 4 fails (Fix/Escalate):** Address fixes and re-run validation, or escalate; do not deploy without human sign-off.
- **Phase 5:** Hotfixes → Phase 2; new features → full cycle from Phase 1.

## How to reference in Cursor

- Install to `.cursor/workflows/full-cycle/`.
- Run the workflow with id **full-cycle**. Use plan mode and required inputs per this file.
