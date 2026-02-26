---
name: github-sub-issue-linking
description: Create sub-issues (tasks) and link them to a parent. Use when you need to create sub-issues under a parent with implementation labels (backend, frontend, data-engineering, devops, internal, quality-assurance) and attach them.
---

# GitHub Sub-Issue Linking

Create new sub-issues in a repository and link each one to a parent issue so they appear as child issues in the project. Sub-issues follow **github-issue-creation-standards**: they are **Task**-type issues with exactly one implementation label and the standard body sections; do **not** use title prefixes.

## When to Use

- You need to create one or more sub-issues (tasks) under a parent issue for different implementers (backend, frontend, data-engineering, devops, internal, quality-assurance).
- Each sub-issue is identified by an **implementation label**, not a title prefix; the skill handles creating the issue and attaching it to the parent.

Equip this skill when your role includes breaking a parent issue into tasks for different agents or teams. Do not hardcode tool names in agent logic.

## Steps

1. **Create each sub-issue** – Use the available GitHub integration to create an issue in the same owner and repo. Follow **github-issue-creation-standards**: descriptive title (no prefixes), five body sections (Description, User Stories, Acceptance Criteria, Assumptions, References), Issue type **Task**, exactly one implementation label (backend, frontend, data-engineering, devops, internal, quality-assurance), and metadata (Milestone MVP, Status Backlog, Assignee). Obtain the created issue's identifier (ID) from the response—use the ID returned by the create operation, not the issue number, for linking.
2. **Link to parent** – For each created sub-issue, use the integration to add it as a sub-issue of the parent (parent issue number and sub-issue ID). This establishes the parent-child relationship on the project board.
3. **Confirm** – After all sub-issues are created and linked, you can list sub-issues via **github-issue-operations** if you need to verify or pass references to downstream steps.

## Do

- Use the same owner and repo for parent and sub-issues.
- Use the correct identifier from the create response when linking (often the issue ID, not the issue number).
- Follow **github-issue-creation-standards** for title, body, Issue type (Task), labels, milestone, status, and assignee.
- Assign exactly one implementation label per sub-issue (backend, frontend, data-engineering, devops, internal, quality-assurance).

## Do Not

- Use title prefixes (e.g. [dev], [ops], [data], [front], [qa], [int]); use labels instead.
- Create a sub-issue without an implementation label or with more than one implementation label.
- Use this skill to only read or update existing issues; use **github-issue-operations** for that.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
