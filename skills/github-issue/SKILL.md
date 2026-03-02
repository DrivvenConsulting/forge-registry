---
name: github-issue
description: Create and manage GitHub issues and subtasks for planning (Phase 2). Use github-issue-operations and github-issue-creation-standards when creating.
---

# GitHub Issue (Planning)

When creating or updating GitHub issues and subtasks in Phase 2 (Planning), use this skill. It is satisfied by **github-issue-operations** (fetch, list, create, update, comment) and **github-issue-creation-standards** when creating new issues (body sections, issue type, milestone, status). Each issue or subtask must reference at least one acceptance criterion from the spec.

## When to Use

- You are in Phase 2 (Planning) and need to create issues or subtasks from a spec.
- You need to fetch, update, or comment on issues in a repository.

Equip this skill when your role includes planning or issue creation. The runner or environment should provide **github-issue-operations** and, for creation, **github-issue-creation-standards** (and **github-project-board** if adding issues to a project).

## Steps

1. **From spec to issues** – Map acceptance criteria to issues or subtasks; each subtask should reference at least one acceptance criterion.
2. **Create or update issues** – Use **github-issue-operations** to create or update issues. When creating, follow **github-issue-creation-standards** (body sections: Description, User Stories, Acceptance Criteria, Assumptions, References; issue type, milestone, status as per project).
3. **Link subtasks** – Use **github-sub-issue-linking** to attach sub-issues to a parent when applicable.
4. **Project board** – Use **github-project-board** to add issues to a project or move columns when the integration supports it.

## Do

- Map every subtask to at least one acceptance criterion.
- Preserve issue structure and formatting when updating bodies.

## Do Not

- Create issues without linking them to acceptance criteria from the spec.
- Invent requirements; if a dependency is missing from the spec, loop back to Phase 1.
