# Skill: Lovable prompts

Write prompts for Lovable (or similar frontend generators) that are clear, deterministic, and aligned with the frontend specification and acceptance criteria.

## When to use

- You are the frontend engineer and must generate UI via Lovable (or similar) from an approved user story.
- The spec has screens, flows, and validations that must all be reflected in the generated app.
- You need to avoid vague or open-ended prompts that lead to rework or scope creep.

## Steps

1. **Gather inputs** – Approved issue (acceptance criteria), frontend spec (screens, flows, validations), backend API contracts, and any UI/UX guidelines.
2. **List deliverables** – Enumerate every screen, navigation path, form field, validation rule, and error state the prompt must cover.
3. **Structure the prompt** – Use a consistent format, e.g.:
   - **Context**: app purpose, user role, tech stack (React, TypeScript, etc.).
   - **Screens**: name, route, main elements, and key actions.
   - **Flows**: step-by-step user journeys (e.g. sign up → verify → dashboard).
   - **Validations**: per field or per form; error messages and when they show.
   - **API**: endpoints and request/response shapes the UI must use.
4. **Make it deterministic** – Prefer explicit instructions (“Show error message X under the email field when invalid”) over vague ones (“Handle errors nicely”). Include exact copy or placeholders when possible.
5. **Review** – Check that every acceptance criterion maps to at least one concrete instruction in the prompt.

## Do

- One prompt = one coherent feature or flow when possible.
- Reference backend contracts by method and payload, not by implementation detail.
- Align with project rules (e.g. frontend-standards: maintainable, performant, accessible).

## Do not

- Leave room for “the AI to decide” on critical behavior or copy.
- Omit validations or error states mentioned in the spec.
- Change backend or data contracts inside the prompt.

## Related rules

- `frontend-standards`: React/TypeScript, maintainable and accessible UIs.
