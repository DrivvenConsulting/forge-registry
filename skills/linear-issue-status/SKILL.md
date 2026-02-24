---
name: linear-issue-status
description: Move issue to a workflow state (Backlog, Todo, In Progress, In Review, Done). Use when you need to move a work item or parent issue to a different state in Linear.
---

# Linear Issue Status

Move an issue to a specified workflow state in Linear. This is the Linear equivalent of moving a card to a column on a project board (e.g. Backlog → Ready → In Progress → In Review → Done).

## When to Use

- You need to move the root (parent) issue to **Todo** (Ready) after refinement is complete.
- You need to move a work item to **In Progress** when starting work on it.
- You need to move a work item to **In Review** or **Done** as required by the team workflow.

Equip this skill when your role includes updating the workflow state of an issue **using the Linear MCP configured in Cursor**; do not hardcode HTTP endpoints or ad-hoc integrations in agent logic.

## Status names (Drivven team)

Use these status names when moving issues:

| Workflow column | Linear status |
|-----------------|---------------|
| Backlog         | Backlog       |
| Ready           | Todo          |
| In Progress     | In Progress   |
| In Review       | In Review     |
| Done            | Done          |

Other states (Canceled, Duplicate) are for exceptional cases; normal flow uses the five above.

## Steps

1. **Identify issue and target state** – Know the issue identifier (e.g. LIN-123) or ID and the target state name (e.g. Todo, In Progress, In Review, Done) for the team.
2. **Update the state** – Use the **Linear MCP configured in Cursor** to set the issue's state to the target status. If the MCP cannot update the state, add a prominent comment on the issue (e.g. "Refinement complete – **move this issue to Todo (Ready)**") and note in your summary that the issue must be moved manually.
3. **Confirm or document** – If the update succeeded, state so in your output; if not, document that a human or parent agent should move the issue and include the requested state.

## Do

- Move the root issue to Todo (Ready) when refinement is complete and no blockers remain.
- When blocked, do not move the issue; leave it in Backlog and add a comment listing blockers.
- Prefer using the integration when available; fall back to clear comments when not.

## Do Not

- Move issues when blockers exist; document blockers on the issue instead.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
