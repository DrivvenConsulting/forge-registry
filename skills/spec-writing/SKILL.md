---
name: spec-writing
description: Produce the Phase 1 spec from a raw idea: functional requirements, technical constraints, edge cases, acceptance criteria, and success metrics.
---

# Spec Writing (Phase 1)

Produce a spec file that turns a raw idea into a well-defined specification with functional requirements, technical constraints, edge cases, acceptance criteria, and success metrics. This is the canonical output of Phase 1 (Discovery) in the AI Spec-Driven Development Framework.

## When to Use

- You are performing Phase 1 (Discovery) and need to turn a raw idea into a spec.
- The spec must be produced before proceeding to Phase 2 (Planning). Do not proceed until acceptance criteria are explicitly defined.

Equip this skill when your role is discovery or spec authoring. You may also use **confluence-fetch** for product vision or context when the parent has not already supplied it.

## Steps

1. **Ingest the raw idea** – Take the raw idea (and optional context: vision doc, constraints, prior context).
2. **Define functional requirements** – List what the feature must do from a user and system perspective.
3. **Capture technical constraints** – Note infrastructure, stack, or integration constraints.
4. **Identify edge cases** – Document important edge cases and assumptions.
5. **Write acceptance criteria** – Each criterion must be testable (observable pass/fail). Do not finish the spec without explicit acceptance criteria.
6. **Define success metrics** – How success will be measured (e.g. performance, adoption, quality).
7. **Flag ambiguity** – If requirements are ambiguous, request clarification before proceeding; do not invent details.

## Do

- Produce a single spec artifact (e.g. markdown or structured doc) with all sections above.
- Ensure every acceptance criterion is testable.
- Align with product vision when context is available (e.g. via confluence-fetch).

## Do Not

- Proceed to Phase 2 until acceptance criteria are explicitly defined.
- Invent requirements; ask for clarification when critical context is missing.
