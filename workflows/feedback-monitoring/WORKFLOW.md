# Workflow: Feedback & Monitoring (Phase 5)

Produce a feedback report from a deployed feature: metrics vs. success criteria, flagged issues, and improvement opportunities formatted as raw ideas for Phase 1. Immediate fixes route to Phase 2 as hotfix tasks; improvements trigger a full Phase 1→5 cycle. This is Phase 5 of the AI Spec-Driven Development Framework.

**Workflow id:** `feedback-monitoring`  
**Phases:** 5

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.
- **Human review:** Human reviews and decides: hotfix or new feature.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| deployed_feature_ref | User | Reference to the deployed feature (e.g. release, env URL, feature flag). |
| acceptance_criteria | User | Acceptance criteria or spec excerpt used for success metrics. |
| production_logs_or_metrics | User | Access to production logs, metrics, or monitoring dashboard. |

## Outputs

- **Feedback report** – Metrics vs. success criteria, flagged issues, improvement opportunities (formatted as raw ideas for Phase 1). Recommendations: immediate fixes → Phase 2 hotfix tasks; improvements → full Phase 1→5 cycle.

## Implementing skills

**Registry skill ids:** monitoring.

## Steps

1. **Run the monitoring agent** using the **monitoring** skill. Ingest deployed feature ref, acceptance criteria, and production logs/metrics.
2. **Produce feedback report** – Compare metrics to success criteria; flag issues; list improvement opportunities as raw ideas.
3. **Route recommendations:** Immediate fixes → Phase 2 (hotfix tasks, skip Phase 1). Improvements → full Phase 1→5 cycle. Human reviews and decides: hotfix or new feature.

## Agent rules (Phase 5)

- Always use the `monitoring` skill.
- Immediate fixes → routed to Phase 2 as hotfix tasks (skip Phase 1).
- Improvements → full Phase 1→5 cycle.
- **Human reviews and decides: hotfix or new feature.**

## How to reference in Cursor

- Install to `.cursor/workflows/feedback-monitoring/`.
- Run the workflow with id **feedback-monitoring**. Use the prompt in `prompts/workflows/feedback-monitoring.md` for plan mode and required inputs.
