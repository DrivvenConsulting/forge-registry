---
name: github-sub-issue-linking
description: Create sub-issues and link them to a parent. Use when you need to create prefixed sub-issues (e.g. [dev], [ops], [qa]) under a parent and attach them.
---

# GitHub Sub-Issue Linking

Create new sub-issues in a repository and link each one to a parent issue so they appear as child issues in the project.

## When to Use

- You need to create one or more sub-issues under a parent issue (e.g. [dev], [ops], [qa], [int], [data], [front]).
- Each sub-issue title must start with its prefix; the skill handles creating the issue and attaching it to the parent.

Equip this skill when your role includes breaking a parent issue into prefixed work items for different agents or teams. Do not hardcode tool names in agent logic.

## Steps

1. **Create each sub-issue** – Use the available GitHub integration to create an issue in the same owner and repo with the required title (including prefix) and body. Obtain the created issue's identifier (ID) from the response—use the ID returned by the create operation, not the issue number, for linking.
2. **Link to parent** – For each created sub-issue, use the integration to add it as a sub-issue of the parent (parent issue number and sub-issue ID). This establishes the parent-child relationship on the project board.
3. **Confirm** – After all sub-issues are created and linked, you can list sub-issues via **github-issue-operations** if you need to verify or pass references to downstream steps.

## Do

- Use the same owner and repo for parent and sub-issues.
- Use the correct identifier from the create response when linking (often the issue ID, not the issue number).
- Title each sub-issue with the required prefix (e.g. [dev] Add auth endpoint, [ops] Add Cognito Terraform).

## Do Not

- Use this skill to only read or update existing issues; use **github-issue-operations** for that.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
