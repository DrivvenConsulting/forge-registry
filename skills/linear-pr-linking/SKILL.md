---
name: linear-pr-linking
description: Attach PR link to a Linear issue when a PR is opened or merged. Use when you need to link a pull request to the work item (sub-issue) that implemented it.
---

# Linear PR Linking

When a pull request is opened or merged for a work item, attach the PR as a link on the corresponding Linear issue so the issue has a traceable reference to the implementing PR. PRs remain on GitHub; Linear holds the link for visibility and traceability.

## When to Use

- You have opened (or merged) a PR that implements a specific work item (sub-issue) and need to record that link on the Linear issue.
- You need to add a link attachment to an issue with the PR URL and a descriptive title (e.g. "PR #123").

Equip this skill whenever your task involves associating a PR with a Linear work item after opening or merging the PR.

## Steps

1. **Identify the work item and PR** – The work item is the Linear sub-issue you implemented (e.g. the [dev] or [ops] sub-issue). The PR is the GitHub pull request URL and number.
2. **Add the link** – Use the available Linear integration to add a link attachment to the issue: URL = the PR URL, title = a short label (e.g. "PR #123" or "Backend implementation"). If the integration replaces existing links, include any existing links when updating so they are not removed.
3. **Confirm** – State in your output that the PR was linked to the issue so the parent or QA can see the association.

## Do

- One PR per work item (one PR per [dev], [ops], [data], [front] sub-issue when applicable).
- Link to the **sub-issue** that was implemented, not only the parent.
- Use a clear link title (e.g. "PR #45 – Auth endpoint").

## Do Not

- Combine unrelated sub-issues in a single PR; each sub-issue gets its own PR and link.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
