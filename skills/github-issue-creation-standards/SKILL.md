---
name: github-issue-creation-standards
description: Defines how GitHub issues must be created for DrivvenConsulting project 6: body sections, Issue type (Feature/Task), labels, milestone, status, assignee. Use when creating or drafting GitHub issues for project 6, adlyze, or DrivvenConsulting work tracking.
---

# GitHub Issue Creation Standards

Single source of truth for creating GitHub issues in **DrivvenConsulting project 6**. Ensures consistent structure, metadata, and labeling so issues can be tracked and filtered correctly.

## When to Use

- Creating a new parent (feature) issue or sub-issue (task) in project 6.
- Drafting issue content before creation (e.g. requirements_refiner, tech_lead).
- Checking that an issue matches the required format (sections, type, labels, milestone, status, assignee).

Equip this skill when your role includes creating or defining work items for DrivvenConsulting project 6; use **github-issue-operations** and **github-sub-issue-linking** for the actual create/link operations.

## Target

- **Org:** DrivvenConsulting
- **Project:** 6 ([project board](https://github.com/orgs/DrivvenConsulting/projects/6))
- **Repo:** Same repo as the parent issue (typically **adlyze**). Create issues in the repo where the work is tracked; do not hardcode a single repo if the workflow uses another.

## Title

- Descriptive and concise; avoid run-on or vague titles.
- No fixed character limit; prefer clarity over brevity.
- Do **not** use title prefixes such as `[dev]`, `[ops]`, `[data]`, `[front]`, `[qa]`, `[int]`—use **labels** instead.

## Issue Body Sections

Every issue body must include these five sections as markdown headings. Populate each; use "TBD" or "None" only when genuinely not yet known.

```markdown
## Description

[Clear summary of what this issue covers and why it matters.]

## User Stories

[One or more user stories in the form: As a [role], I want [goal] so that [benefit].]

## Acceptance Criteria

[Testable criteria that must be met for the issue to be considered done. Use a list.]

## Assumptions

[Assumptions about context, dependencies, or scope. Use "None" if none.]

## References

[Links to docs, tickets, or other relevant material. Use "None" if none.]
```

## Parent vs Subissue (Task)

| Kind           | Issue type (project field) | Labels                                      |
|----------------|----------------------------|---------------------------------------------|
| **Parent**     | **Feature**                | None (no implementation label).             |
| **Subissue**   | **Task**                   | Exactly one from the implementation labels.  |

- **Parent (feature):** Represents a feature or epic. Set Issue type to **Feature**. Do not add backend/frontend/data-engineering/devops/internal/quality-assurance labels.
- **Subissue (task):** Represents work for a specific implementer. Set Issue type to **Task** and add **exactly one** label indicating who implements it (see Labels below). Do **not** use title prefixes; the label identifies the implementer.

## Labels (Implementation)

Use these **repository labels** for sub-issues (tasks) to indicate who implements the work. Each task gets exactly one of:

| Label               | Implementer / use |
|---------------------|-------------------|
| **backend**         | Backend engineer  |
| **frontend**        | Frontend engineer |
| **data-engineering**| Data engineer     |
| **devops**          | DevOps engineer   |
| **internal**        | Internal / other  |
| **quality-assurance** | QA / testing    |

These labels replace the previous prefix-based convention ([dev], [ops], [data], etc.). Agents list their tasks by filtering sub-issues by the appropriate label (see **github-fetch-my-subissues**).

## Metadata (All Issues)

Apply to **every** new issue (parent and sub-issues), unless a different rule is specified for the project:

| Field      | Value        |
|-----------|--------------|
| **Milestone** | **MVP** (for now, all tasks go in MVP). |
| **Status**    | **Backlog** (new issues start in Backlog). |
| **Assignee**  | **JnsFerreira** |

If the integration cannot set project fields (Issue type, Status) or assignee, add a short note in the issue body or a comment (e.g. "Issue type: Task; Status: Backlog; Assignee: JnsFerreira") so a human or script can set them.

## Do

- Include all five body sections (Description, User Stories, Acceptance Criteria, Assumptions, References) with clear headings.
- Set Issue type to **Feature** for parents and **Task** for sub-issues.
- Assign exactly one implementation label per sub-issue (backend, frontend, data-engineering, devops, internal, quality-assurance).
- Set Milestone to MVP, Status to Backlog, and Assignee to JnsFerreira for new issues.
- Use descriptive titles without prefixes.

## Do Not

- Use title prefixes like `[dev]`, `[ops]`, `[data]`, `[front]`, `[qa]`, `[int]`.
- Create a sub-issue without an implementation label or with more than one implementation label.
- Omit any of the five body sections; use "TBD" or "None" only when appropriate.
- Reference specific tool or MCP names in agent instructions; the skill defines the format only.

## CLI helpers and templates

- Use `assets/issue-template.md` as the canonical Markdown body template when creating issues manually or via scripts.
- Use `scripts/gh-issue-create.sh` as a reference for how to create a standards-compliant issue with the GitHub CLI (`gh issue create`).
- See `references/REFERENCE.md` for concrete `gh` command examples and links to the GitHub CLI manual.

