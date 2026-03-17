# Workflow: Discovery (Phase 1)

Turn a raw idea into a spec file with functional requirements, technical constraints, edge cases, acceptance criteria, and success metrics. This is Phase 1 of the AI Spec-Driven Development Framework.

**Workflow id:** `discovery`  
**Phases:** 1

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.
- **Tooling and access:** This workflow may rely on external integrations (e.g. Confluence, GitHub, AWS context) when running skills. **If the required CLI, MCP, or API access is not available or not authenticated in the current environment, stop execution, explain what is missing, and ask the user to either authorize a suitable environment or run the external steps themselves. Do not attempt to reconfigure authentication silently.**

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| raw_idea | User | Raw idea or problem statement to turn into a spec. |
| context (optional) | User | Optional vision doc, constraints, or prior context. |
| feature_name (optional) | User | Snake_case feature slug used for artifact paths under `artifacts/feature-definitions/<feature_name>/`. Required if you want feasibility artifacts. |
| target_repo (optional) | User | Target repository for the feature (e.g. `DrivvenConsulting/adlyze`); used as context for feasibility agents. |

## Outputs

- **Spec file** – Functional requirements, technical constraints, edge cases, acceptance criteria, and success metrics. Do not proceed to Phase 2 until acceptance criteria are explicitly defined.
- **(Optional) Feasibility artifacts** – When `feature_name` is provided and feasibility is in scope:
  - `artifacts/feature-definitions/<feature_name>/channel-feasibility-google-ads.json` (or `channel-feasibility.json` for generic/multi-channel feasibility).
  - `artifacts/feature-definitions/<feature_name>/technical-feasibility.json`.

## Implementing skills

**Registry skill ids:** spec-writing, confluence-fetch (optional), feasibility-assessment (optional), github-issue-operations (optional), aws-context (optional).

## Steps

### Phase 1a – Spec creation

1. **Run the discovery/spec agent** with the raw idea (and optional context). Use **product-owner** in spec-writing mode; the agent must use the **spec-writing** skill to produce the spec. Flag ambiguous requirements and request clarification before finishing.
2. **Validate** that the spec includes explicit acceptance criteria and success metrics. If not, iterate with the agent until they are defined.

### Phase 1b – Optional feasibility pass (pre‑planning)

Run this phase **only when** you have a stable spec, a `feature_name`, and feasibility is required before planning. All feasibility artifacts are written under `artifacts/feature-definitions/<feature_name>/`.

3. **Channel feasibility – Google Ads (optional):**
   - When the feature depends on Google Ads, invoke the **channel_specialist_google_ads** agent with:
     - The Phase 1 spec and/or backlog work item content.
     - `feature_name` for artifact paths (for example, `artifacts/feature-definitions/<feature_name>/channel-feasibility-google-ads.json`).
     - `target_repo` (when known) for additional context.
   - The agent validates the feature against Google Ads capabilities and writes:
     - `artifacts/feature-definitions/<feature_name>/channel-feasibility-google-ads.json` (or `channel-feasibility.json` when multiple channels are in scope) in the same feature-definition directory as the spec and other assets.
   - Optionally, it appends a **Channel Feasibility – Google Ads** Markdown section to the relevant existing work item (for example, a GitHub issue or planning doc), without creating new GitHub issues in this phase.

4. **Technical feasibility via tech-lead (optional):**
   - When a technical/data feasibility check is required before planning, invoke the **tech-lead** agent with:
     - The same Phase 1 spec and any Channel Feasibility notes (for example, the contents of `channel-feasibility-google-ads.json`).
     - The `feature_name` for artifact paths so that technical feasibility is written to `artifacts/feature-definitions/<feature_name>/technical-feasibility.json`.
     - `target_repo` / project information and, when applicable, the existing backlog work item (owner, repo, issue number) used for refinement.
   - The tech-lead agent analyzes technical and data feasibility against the current architecture and data and must:
     - Write `artifacts/feature-definitions/<feature_name>/technical-feasibility.json` in the same feature-definition directory as the spec and channel feasibility JSON.
     - Optionally update the existing work item with a Markdown **Technical Feasibility** section and project state (for example, on a GitHub issue or planning doc), but must not create new GitHub issues in this phase.

## Agent rules (Phase 1)

- When generating the spec, always use the `spec-writing` skill.
- Do not proceed to Phase 2 until acceptance criteria are explicitly defined.
- Flag ambiguous requirements and request clarification before proceeding.
- Only run feasibility (Phase 1b) when a `feature_name` is available and feasibility is in scope; otherwise hand off the spec directly to the planning workflow.

## How to reference in Cursor

- Install to `.cursor/workflows/discovery/`.
- Run the workflow with id **discovery**. Use plan mode and required inputs per this file.
