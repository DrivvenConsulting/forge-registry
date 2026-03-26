---
name: github-project-board
description: Move issue or card to a GitHub Project Status value (e.g. Backlog → In progress → Ready for testing → Reviewed/Tested). Use when you need to move a work item or parent issue to a project Status.
---

# GitHub Project Board

Move an issue (or its project card) to a specified **Status** value on a GitHub Project (Projects v2).

**Canonical Status sequence:** Backlog → In progress → Ready for testing → Reviewed/Tested → Approved (human) → Released

When you need to update the **Status** field via the GitHub CLI, use **github-project-status** (and its helper script) to perform the underlying Status change.

## When to Use

- You need to move a work item to **In progress** when starting work on it.
- You need to move work items to **Ready for testing** when implementation PRs are closed and testing should start.
- You need to move work items to **Reviewed/Tested** when testing-validation passes.
- You need to move work items back to **In progress** when testing-validation fails.

Equip this skill when your role includes updating the project board state of an issue; do not hardcode tool names in agent logic. **If the required GitHub integration (CLI, MCP, or API) is not available or not authenticated in the current environment, stop execution, explain what is missing, and ask the user to either authorize a suitable environment or move the card manually. Do not attempt to reconfigure authentication silently.**

## Steps

1. **Identify issue(s) and target Status** – Know the issue number(s) (or owner, repo, issue number) and the target Status name (e.g. Backlog, In progress, Ready for testing, Reviewed/Tested) for the project (e.g. project 6 in the org).
2. **Move the card / Status** – Use the available GitHub integration to update the issue's project card to the target column. When you are using the GitHub CLI with Projects v2, follow **github-project-status** (or its helper script `skills/github-project-status/scripts/gh-project-set-status.sh`) to update the Status field to the desired value.
3. **Confirm or document** – If the move succeeded, state so in your output; if not, document that a human or parent agent should move the card and include the requested column.

## Do

- Use the exact Status option labels as shown on the project board (case-sensitive).
- When testing-validation is involved, move the **parent issue and all related sub-issues** together so the board reflects the real workflow stage.
- When blocked, do not move the issue; leave it in Backlog and add a comment listing blockers.
- Prefer using the integration when available; fall back to clear comments when not.

## Do Not

- Move issues when blockers exist; document blockers on the issue instead.
- Move issues to **Approved (human)** or **Released**. Those states are controlled by humans and/or release automation outside agent scope.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
