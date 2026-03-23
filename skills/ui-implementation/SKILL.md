---
name: ui-implementation
description: Build UI and frontend from specs using lovable-prompts and the environment's frontend-generation capability.
---

# UI Implementation (Phase 3)

When building frontend/UI in Phase 3 (Implementation), use this skill. It is satisfied by **lovable-prompts** (prompt structure and requirements) and the available frontend-generation capability in the environment (e.g. Lovable). Do not write frontend code manually; generate via the structured prompt and execution path.

## When to Use

- You are in Phase 3 (Implementation) and the work item is frontend/UI.
- You need to generate screens, components, flows, and validations from a frontend spec and API contracts.

Equip this skill when your role is frontend implementation. Use **lovable-prompts** for prompt structure; use the environment's frontend-generation support for execution. Use **confluence-fetch** for UI/UX guidelines when not already provided.

## Steps

1. **Read work item and frontend spec** – Screens, flows, validations, API contracts for UI.
2. **Build the prompt** – Use **lovable-prompts** to produce a clear, deterministic prompt (feature overview, screens, components, flows, API endpoints and fields, validations, UX constraints).
3. **Execute generation** – Use the available Lovable or frontend-generation capability; do not hardcode tool or MCP names.
4. **Review and commit** – Review generated output for obvious issues; commit and open a PR linked to the work item.
5. **Gap handling** – If a gap is discovered not covered by any subtask, stop, create a gap report, and route back to Phase 2. Never patch silently.

## Do

- Include all screens, flows, and validations in the prompt.
- Link the PR to the work item (e.g. Closes #N).

## Do Not

- Manually write or refactor frontend code; use the UI implementation path only.
- Change backend or data contracts or acceptance criteria.
