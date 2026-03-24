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
- Do **not** use implementation title prefixes such as `[dev]`, `[ops]`, `[data]`, `[front]`, `[qa]`, `[int]`—use **labels** instead.

### Parent prefix convention for subissues

Subissues (tasks) may include a **parent issue prefix** in the title so it is easy to see which feature they belong to:

- Format: `[#<parent_number>] <Subissue title>`
  - Example: `[#57] Implement backend ingestion pipeline`
- This prefix:
  - Is **optional** for parents (Feature issues) and **recommended** for subissues (Task issues) created by planning workflows.
  - Is purely for parent identification and **does not** encode implementation type (backend/frontend/etc.).
  - May be added automatically by skills such as `github-sub-issue-linking` when creating subissues.

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

[Links to docs, tickets, or other relevant material. For specs from Phase 1, follow **Canonical spec reference (planning / Phase 2)** below. Use "None" if none.]
```

## Canonical spec reference (planning / Phase 2)

When issues are created from a Phase 1 spec (Phase 2 planning):

- **References** must include at least one line that identifies the spec as **`OWNER/REPO/<repo-relative-path>`**, where `<repo-relative-path>` is the path from the repository root to the spec file (for example `docs/specs/export-reports.md`).
- Use the **`OWNER/REPO`** for the repository where the spec lives (usually the same repository where the issue is created). If the spec lives in a different repository, use that repository's owner and name.
- **Do not** use a bare filename alone (for example `spec.md` or `export-reports.md`) as the only pointer to the spec.
- **Optional:** Add a second line with a markdown link to `https://github.com/OWNER/REPO/blob/<default-branch>/<repo-relative-path>` when the default branch is known.

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

If the integration cannot set project fields (Issue type, Status) or assignee, add a short note in the issue body or a comment (e.g. "Issue type: Task; Status: Backlog; Assignee: JnsFerreira") so a human or script can set them. When you later need to move an issue between Status values on the project (e.g. Backlog → Ready, In Progress), use **github-project-board** and **github-project-status** (or its helper script) to perform the Status change in a consistent way.

## Do

- Include all five body sections (Description, User Stories, Acceptance Criteria, Assumptions, References) with clear headings.
- Set Issue type to **Feature** for parents and **Task** for sub-issues.
- Assign exactly one implementation label per sub-issue (backend, frontend, data-engineering, devops, internal, quality-assurance).
- Set Milestone to MVP, Status to Backlog, and Assignee to JnsFerreira for new issues.
- Use descriptive titles without prefixes.
- For planning-sourced issues tied to a Phase 1 spec in a repository, include the canonical spec line **`OWNER/REPO/<repo-relative-path>`** in **References**.

## Do Not

- Use title prefixes like `[dev]`, `[ops]`, `[data]`, `[front]`, `[qa]`, `[int]`.
- Create a sub-issue without an implementation label or with more than one implementation label.
- Omit any of the five body sections; use "TBD" or "None" only when appropriate.
- Reference specific tool or MCP names in agent instructions; the skill defines the format only.
- List only a spec **filename** without **`OWNER/REPO/`** and a repo-relative path when the work is tied to a Phase 1 spec file in a Git repository.

## CLI helpers and templates

- Use `assets/issue-template.md` as the canonical Markdown body template when creating issues manually or via scripts.
- Use `scripts/gh-issue-create.sh` as a reference for how to create a standards-compliant issue with the GitHub CLI (`gh issue create`).
- See `references/REFERENCE.md` for concrete `gh` command examples and links to the GitHub CLI manual.

