---
name: github-pr-operations
description: Create branch, open PR, link PR to issue (Closes #N), fetch PR/diff. Use when you need to open a PR, link it to a work item, or fetch PR details or diffs.
---

# GitHub PR Operations

Create branches and pull requests, link PRs to issues (e.g. Closes #N), and fetch PR details or diffs for review or verification.

## When to Use

- You need to create a branch, commit changes, and open a pull request.
- You need to link a PR to a work item (sub-issue or parent) so that merging the PR closes the issue (Closes #&lt;number&gt; or Fixes #&lt;number&gt;).
- You need to fetch PR description, diff, or linked branches for verification or AC mapping.

Equip this skill whenever your task involves opening a PR or reading PR content; do not hardcode tool names in agent logic.

## Steps

1. **Create branch and open PR** – Use the available GitHub integration to create a new branch from the target branch, then create a pull request with the given title, description, and base/head refs.
2. **Link to work item** – In the PR title or description, include **Closes #&lt;number&gt;** (or **Fixes #&lt;number&gt;**), where &lt;number&gt; is the **sub-issue number** of the work item you implemented. This links the PR to the issue and closes it when the PR is merged. Optionally mention the parent issue in the body (e.g. "Parent issue: #X") for traceability.
3. **Fetch PR details** – When you need to verify implementation or map acceptance criteria, use the integration to fetch the PR description, file list, and diff for the given PR number(s).

## Do

- One PR per work item (one PR per [dev] or [ops] sub-issue when applicable).
- Populate the PR description with the required structure (description, changes, linked issue, acceptance criteria mapping).
- Use the sub-issue number for Closes #N, not only the parent.

## Do Not

- Combine unrelated sub-issues in a single PR.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
