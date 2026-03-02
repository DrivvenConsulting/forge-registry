---
name: feasibility-assessment
description: Assess technical and data feasibility of a backlog work item against current architecture; produce technical-feasibility.json and update the work item with a Markdown summary; move to Ready or keep in Backlog.
---

# Feasibility Assessment

Validate that a user story (work item in **Backlog**) is technically and data-wise feasible within the current architecture. Produce a **technical feasibility JSON** and update the work item with a **human-readable** **Technical Feasibility** section (Markdown only). If implementation is viable, move the item to **Ready**; otherwise leave it in **Backlog** with a clear blocker reason.

## When to Use

- The workflow or parent agent needs a technical feasibility assessment for a backlog work item (e.g. before moving to Ready).
- You are in **product-owner** feasibility assessment mode.

Equip this skill when your role includes assessing feasibility. Use **confluence-fetch** for architecture and data guidelines when not already supplied. Use **github-issue-operations** to update the work item; use **github-project-board** to move to Ready or document the intended state.

## Steps

1. **Review the work item** – Parse user stories, acceptance criteria, assumptions, and any Channel Feasibility section (e.g. from channel specialist).
2. **Fetch architecture and data guidelines** – Use **confluence-fetch** when not already supplied. Assess alignment with storage, pipelines, and compute patterns.
3. **Validate data and architecture** – Check whether required data is available, latency and volume are within capabilities, and schemas can support the AC. Incorporate Channel Specialist constraints if present.
4. **Decide feasibility** – Set **approved** only if implementation is viable with current or clearly scoped work; otherwise **blocked** and state what must change.
5. **Produce technical-feasibility.json** – Write to **`artifacts/feature-definitions/<feature_name>/technical-feasibility.json`** when feature name is provided.
6. **Update the work item** – Append (or add as comment) a **Markdown** **Technical Feasibility** section derived from the JSON. **Do not post raw JSON** on the issue.
7. **Update project state** – If **approved**: move work item to **Ready** (GitHub project board). If **blocked**: leave in **Backlog**; optionally add a short note on what would unblock.

## Output schema

```json
{
  "technical_feasibility": "approved | blocked",
  "data_considerations": "<tables, pipelines, freshness>",
  "dependencies": ["<service or infra needed>"],
  "blocker_reason": "<only if blocked: what is missing or must change>"
}
```

- **technical_feasibility**: `"approved"` (implementation is viable) or `"blocked"` (not viable).
- **data_considerations**: Relevant tables, pipelines, data freshness.
- **dependencies**: Array of services, infra, or refactors required; use `[]` or `["Existing stack"]` if none.
- **blocker_reason**: Only when blocked; otherwise empty string or omit.

## Do

- Base the assessment on current architecture and any Channel Specialist notes.
- Use only Markdown summary on the issue; never paste raw JSON.

## Do Not

- Change the user story or acceptance criteria; only validate and document.
- Assume unplanned new systems unless explicitly in scope.
