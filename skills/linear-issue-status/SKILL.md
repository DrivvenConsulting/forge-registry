---
name: linear-issue-status
description: Move issue to a workflow state (Backlog, Ready, Available, Reviewed, Approved, Released, Canceled, Duplicate). Use when you need to move a work item or parent issue to a different state in Linear.
---

# Linear Issue Status

Move an issue to a specified workflow state in Linear. This is the Linear equivalent of moving a card to a column on a project board (e.g. Backlog → Ready → Available → Reviewed → Approved → Released).

## When to Use

- You need to move the root (parent) issue to **Ready** after refinement or feasibility approval is complete.
- You need to move a work item to **Available** when starting implementation work on it.
- You need to move a work item to **Reviewed**, **Approved**, or **Released** as required by the team workflow.

Equip this skill when your role includes updating the workflow state of an issue **using the Linear MCP configured in Cursor**; do not hardcode HTTP endpoints or ad-hoc integrations in agent logic.

## Status names (Drivven team)

Use these exact status names when moving issues:

| Stage | Linear status | When |
|-------|----------------|------|
| Backlog | **Backlog** | After requirements / before feasibility or refinement. |
| Ready for implementation | **Ready** | After feasibility approval (idea-to-backlog) or refinement complete (backlog-to-ready). |
| In progress | **Available** | Implementation work in progress. |
| Under review | **Reviewed** | PR(s) or deliverable under review. |
| Approved | **Approved** | Review approved. |
| Shipped | **Released** | Merged and shipped. |
| Exceptional | **Canceled**, **Duplicate** | Resolution states. |

Normal flow for idea-to-backlog and backlog-to-ready: **Backlog** → **Ready**. Implementation flow: **Ready** → **Available** → **Reviewed** → **Approved** → **Released**.

## Steps

1. **Identify issue and target state** – Know the issue identifier (e.g. LIN-123) or ID and the target state name (e.g. Ready, Available, Reviewed, Approved, Released) for the team.
2. **Update the state** – Use the **Linear MCP configured in Cursor** to set the issue's state to the target status. If the MCP cannot update the state, add a prominent comment on the issue (e.g. "Refinement complete – **move this issue to Ready**") and note in your summary that the issue must be moved manually.
3. **Confirm or document** – If the update succeeded, state so in your output; if not, document that a human or parent agent should move the issue and include the requested state.

## Do

- Move the root issue to **Ready** when refinement or feasibility is complete and no blockers remain.
- When blocked, do not move the issue; leave it in Backlog and add a comment listing blockers.
- Prefer using the integration when available; fall back to clear comments when not.

## Do Not

- Move issues when blockers exist; document blockers on the issue instead.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
