# Workflow: Discovery (Phase 1)

Turn a raw idea into a spec file with functional requirements, technical constraints, edge cases, acceptance criteria, and success metrics. This is Phase 1 of the AI Spec-Driven Development Framework.

**Workflow id:** `discovery`  
**Phases:** 1

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| raw_idea | User | Raw idea or problem statement to turn into a spec. |
| context (optional) | User | Optional vision doc, constraints, or prior context. |

## Outputs

- **Spec file** – Functional requirements, technical constraints, edge cases, acceptance criteria, and success metrics. Do not proceed to Phase 2 until acceptance criteria are explicitly defined.

## Implementing skills

**Registry skill ids:** spec-writing, confluence-fetch (optional).

## Steps

1. **Run the discovery/spec agent** with the raw idea (and optional context). Use **product-owner** in spec-writing mode; the agent must use the **spec-writing** skill to produce the spec. Flag ambiguous requirements and request clarification before finishing.
2. **Validate** that the spec includes explicit acceptance criteria and success metrics. If not, iterate with the agent until they are defined.

## Agent rules (Phase 1)

- When generating the spec, always use the `spec-writing` skill.
- Do not proceed to Phase 2 until acceptance criteria are explicitly defined.
- Flag ambiguous requirements and request clarification before proceeding.

## How to reference in Cursor

- Install to `.cursor/workflows/discovery/`.
- Run the workflow with id **discovery**. Use plan mode and required inputs per this file.
