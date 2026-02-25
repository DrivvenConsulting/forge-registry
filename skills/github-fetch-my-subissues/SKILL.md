---
name: github-fetch-my-subissues
description: Lists sub-issues of a parent issue that belong to the current agent by filtering by label. Use when an implementer agent (backend, frontend, data-engineering, devops, internal, quality-assurance) needs to find their tasks under a parent issue.
---

# Fetch My Subissues (by Label)

Teaches implementer agents how to get **their** tasks from a parent issue by filtering sub-issues by **label**, not by title prefix. Use with **github-issue-operations** for the actual list/filter operations.

## When to Use

- You are an implementer agent (backend-engineer, frontend-engineer, data-engineers, devops-engineer, qa-tester, integration-tester, or internal) and need to list work items assigned to you.
- You have a parent issue (owner, repo, issue number) and need to find which of its sub-issues are yours to implement.
- The workflow uses labels (backend, frontend, data-engineering, devops, internal, quality-assurance) to assign tasks; do **not** rely on title prefixes like [dev] or [data].

Equip this skill together with **github-issue-operations** when your role is to implement tasks under a parent issue and you must discover your sub-issues by label.

## Steps

1. **Obtain the parent issue** – You need the parent issue identifier: owner (e.g. DrivvenConsulting), repo (e.g. adlyze), and issue number. The parent or orchestrator typically provides this.
2. **List sub-issues of the parent** – Use the available GitHub integration (via **github-issue-operations**) to retrieve all sub-issues linked to that parent.
3. **Filter by your label** – Keep only sub-issues that have the **label** that matches your role (see Label ↔ agent mapping below). Those are your tasks to implement.

## Label ↔ Agent Mapping

| Label               | Agent(s)              |
|---------------------|------------------------|
| **backend**         | backend-engineer       |
| **frontend**        | frontend-engineer      |
| **data-engineering**| data-engineers         |
| **devops**          | devops-engineer        |
| **internal**        | internal / other       |
| **quality-assurance** | qa-tester, integration-tester (when applicable) |

When you are the data engineer agent, filter for sub-issues with label **data-engineering**. When you are the backend engineer, filter for **backend**. Do not filter by title prefix.

## Do

- Filter sub-issues by the **label** that corresponds to your role.
- Use **github-issue-operations** to fetch the parent and list/filter its sub-issues.
- Treat the filtered list as your work queue for that parent.

## Do Not

- Rely on title prefixes (e.g. [data], [dev], [ops]) to find your tasks; use labels only.
- Assume all sub-issues of the parent are yours; filter by your implementation label.
- Reference specific tool or MCP names in agent instructions; the skill describes the workflow; **github-issue-operations** encapsulates the integration.
