---
name: linear-issue-operations
description: Read issue(s), get sub-issues, create issue, update issue body, add comment. Use when you need to fetch a Linear issue, list or filter sub-issues, create or update an issue, or add a comment.
---

# Linear Issue Operations

Perform read and write operations on Linear issues: fetch an issue, list or filter sub-issues, create a new issue, update an issue description, or add a comment.

## When to Use

- You need to fetch a single issue by identifier (e.g. LIN-123) or issue ID; team and project can be name or ID (e.g. Drivven, Adlyze).
- You need to list or filter issues (or sub-issues of a parent) by **label** (e.g. Agents label "Backend Engineer", "Quality Assurance") and optionally state, to find work items or **list tasks available to an agent**.
- You need to create a new issue in a team/project.
- You need to update an issue's description or add a comment to an issue.

Equip this skill whenever your task involves reading or updating Linear issue content; do not hardcode tool names in agent logic.

## Steps

1. **Fetch an issue** – Use the available Linear integration to get issue details by identifier (e.g. LIN-123) or issue ID. Extract user story, acceptance criteria, labels, and state as needed.
2. **Get sub-issues / list issues** – When given a parent issue, use the integration to retrieve its sub-issues (e.g. via parent relation or list filtered by parent). Filter by **label** (e.g. Agents label "Backend Engineer", "Quality Assurance") and optionally by state (Todo, In Progress). To **list tasks available to an agent**, list issues (team Drivven, project Adlyze if applicable) with that agent's **Agents label** and state **Todo** or **In Progress**.
3. **Create an issue** – When creating a new issue, use the integration to create it in the specified team and optional project with the given title, description, and optional labels. Return the new issue identifier and ID for linking.
4. **Update issue description** – When enriching or refining an issue description, use the integration to update the issue description with the new content.
5. **Add a comment** – When you need to add a summary, refinement note, or blocker comment, use the integration to add a comment to the specified issue.

## Do

- Use the appropriate operation for the current step (fetch, list, create, update, comment).
- Preserve issue structure and formatting when updating descriptions.
- Include clear, actionable text in comments (e.g. "Refinement complete – move this issue to Ready" or "This issue was refined by [agent name]").
- Use issue identifier (e.g. LIN-123) or issue ID as required by the integration; team and project can be name or ID.

## Do Not

- Create or link sub-issues in this skill; use **linear-sub-issue-linking** for creating and attaching sub-issues to a parent.
- Change issue state in this skill; use **linear-issue-status** for moving issues to Backlog, Todo, In Progress, In Review, or Done.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
