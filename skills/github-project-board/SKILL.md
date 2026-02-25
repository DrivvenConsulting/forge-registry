---
name: github-project-board
description: Move issue or card to a project column (e.g. Backlog to Ready, In Progress). Use when you need to move a work item or parent issue to a project column.
---

# GitHub Project Board

Move an issue (or its project card) to a specified column on a GitHub project board, e.g. Backlog → Ready, or to In Progress.

## When to Use

- You need to move the root (parent) issue to **Ready** after refinement is complete.
- You need to move a work item to **In Progress** when starting work on it.
- You need to move a work item to **In Review** or another column as required by the team workflow.

Equip this skill when your role includes updating the project board state of an issue; do not hardcode tool names in agent logic.

## Steps

1. **Identify issue and target column** – Know the issue number (or owner, repo, issue number) and the target column name (e.g. Ready, In Progress, In Review) for the project (e.g. project 6 in the org).
2. **Move the card** – Use the available GitHub integration to update the issue's project card to the target column. If the integration does not support moving cards, add a prominent comment on the issue (e.g. "Refinement complete – **move this issue to Ready**") and note in your summary that the issue must be moved manually.
3. **Confirm or document** – If the move succeeded, state so in your output; if not, document that a human or parent agent should move the card and include the requested column.

## Do

- Move the root issue to Ready when refinement is complete and no blockers remain.
- When blocked, do not move the issue; leave it in Backlog and add a comment listing blockers.
- Prefer using the integration when available; fall back to clear comments when not.

## Do Not

- Move issues when blockers exist; document blockers on the issue instead.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
