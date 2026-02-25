---
name: github-issue-operations
description: Read issue(s), get sub-issues, create issue, update issue body, add comment. Use when you need to fetch an issue, list or link sub-issues, create or update an issue, or add a comment.
---

# GitHub Issue Operations

Perform read and write operations on GitHub issues: fetch an issue, list or filter sub-issues, create a new issue, update an issue body, or add a comment.

## When to Use

- You need to fetch a single issue by owner, repo, and issue number.
- You need to list or filter sub-issues of a parent issue (e.g. by title prefix such as [dev], [ops], [qa]).
- You need to create a new issue in a repository.
- You need to update an issue's body or add a comment to an issue.

Equip this skill whenever your task involves reading or updating GitHub issue content; do not hardcode tool names in agent logic.

## Steps

1. **Fetch an issue** – Use the available GitHub integration to get issue details (owner, repo, issue number). Extract user story, acceptance criteria, labels, and state as needed.
2. **Get sub-issues** – When given a parent issue, use the integration to retrieve linked sub-issues. Filter by title prefix or label as required by the workflow (e.g. only [dev] or [ops] sub-issues).
3. **Create an issue** – When creating a new issue, use the integration to create it in the specified repo with the given title, body, and optional labels. Return the new issue identifier for linking.
4. **Update issue body** – When enriching or refining an issue description, use the integration to update the issue body with the new content.
5. **Add a comment** – When you need to add a summary, refinement note, or blocker comment, use the integration to add a comment to the specified issue.

## Do

- Use the appropriate operation for the current step (fetch, list, create, update, comment).
- Preserve issue structure and formatting when updating bodies.
- Include clear, actionable text in comments (e.g. "Refinement complete – move this issue to Ready" or "This issue was refined by [agent name]").

## Do Not

- Create or link sub-issues in this skill; use **github-sub-issue-linking** for creating and attaching sub-issues to a parent.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
