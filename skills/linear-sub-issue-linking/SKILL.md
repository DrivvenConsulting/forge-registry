---
name: linear-sub-issue-linking
description: Create sub-issues with Agents labels and link them to a parent. Use when you need to create sub-issues under a parent, each assigned to an agent via Agents label (Backend Engineer, DevOps Enginner, etc.).
---

# Linear Sub-Issue Linking

Create new sub-issues in Linear **with the appropriate Agents label** (not title prefix) and link each one to a parent issue so they appear as child issues. Titles are descriptive; no prefix required.

## When to Use

- You need to create one or more sub-issues under a parent issue, each assigned to an agent via **Agents label** (Backend Engineer, DevOps Enginner, Quality Assurance, Data Engineer, Frontend Engineer, Tech Lead).
- Titles are descriptive; no prefix required. The skill handles creating the issue with the correct label and attaching it to the parent.

Equip this skill when your role includes breaking a parent issue into work items for different agents or teams. Do not hardcode tool names in agent logic.

## Steps

1. **Create each sub-issue** – Use the available Linear integration to create an issue in the same team (and project if applicable) with a **descriptive title** (no prefix), **description**, and **labels** including the correct **Agents** label. Obtain the created issue's **ID** from the response—use the ID (not the identifier like LIN-123) when linking to the parent.
2. **Link to parent** – For each created sub-issue, use the integration to add it as a sub-issue of the parent (parent issue ID and sub-issue ID). This establishes the parent-child relationship.
3. **Confirm** – After all sub-issues are created and linked, you can list sub-issues via **linear-issue-operations** if you need to verify or pass references to downstream steps.

## Agent (id) → Linear Agents label

| Agent (id)         | Linear Agents label (exact) |
|--------------------|-----------------------------|
| backend-engineer    | Backend Engineer            |
| devops-engineer     | DevOps Enginner             |
| qa-tester           | Quality Assurance           |
| integration-tester  | Quality Assurance           |
| data-engineers      | Data Engineer               |
| frontend-engineer   | Frontend Engineer           |
| tech-lead           | Tech Lead                   |

Note: "DevOps Enginner" is the exact label name in Linear. For **integration-tester**, Linear has no separate label; use **Quality Assurance** and distinguish integration-specific work by description or title.

## Do

- Use the same team (and project) for parent and sub-issues.
- Use the **issue ID** from the create response when linking to the parent, not the identifier.
- Set the **Agents label** on each sub-issue so agents can find their work by label.

## Do Not

- Use this skill to only read or update existing issues; use **linear-issue-operations** for that.
- Reference specific tool or MCP names in agent instructions; the skill encapsulates the mechanism.
