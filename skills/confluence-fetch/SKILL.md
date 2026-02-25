---
name: confluence-fetch
description: Retrieve product vision, standards, and guidelines from Confluence. Use when you need backend, infra, data, or UI standards or product context.
---

# Confluence Fetch

Retrieve product vision, core concepts, product principles, and technical standards (backend, infra, data, UI/UX) from Confluence so agents can align work with documented guidelines.

## When to Use

- You need product vision, core concepts, or product principles to align a problem statement or requirements.
- You need backend, infrastructure, data architecture, or UI/UX standards that were not already supplied by the parent agent or orchestrator.
- You need architecture or data guidelines for feasibility or implementation alignment.

Equip this skill when your task requires Confluence-sourced context; do not hardcode tool or MCP names in agent logic.

## Steps

1. **Identify what to fetch** – Determine which content is needed: product vision, backend standards (FastAPI, auth, layers), infra standards (Terraform, CI/CD), data standards (Delta Lake, pipelines), or UI/UX guidelines.
2. **Retrieve content** – Use the available Confluence integration to fetch the relevant pages or spaces. If the parent agent has already supplied the content, skip or use only to fill gaps.
3. **Summarize or pass through** – Provide the retrieved content (or a short summary) so the agent can align implementation, wording, or structure with the guidelines.

## Do

- Use this skill when standards or vision are not already in context; avoid redundant fetches when the parent has supplied them.
- Align implementation and wording with the retrieved standards.

## Do Not

- Invent standards; if Confluence is unavailable or empty, state that and proceed with reasonable assumptions, documenting the gap.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
