---
name: create-forge-rule
description: Create a new rule in Forge registry format. Use when the user wants to create a rule for the Forge registry, add a rule to a registry repo, or scaffold rule manifest and RULE.md that can be installed via forge install rule.
---
# Creating Forge Registry Rules

This skill guides you through creating a new **rule** in the Forge registry format. The result can be added to a Forge registry repo and installed into projects with `forge install rule <id>`. After install, the rule appears at `.cursor/rules/<id>/RULE.md`.

## When to Use

- User wants to create a new rule for the Forge registry.
- User is working in a registry repo (or a folder to be copied into one) and wants to add a rule.
- User asks for rule scaffolding that matches Forge’s validated format.

---

## Forge Registry Format (Rules)

### Directory layout

```
rules/
  <id>/
    manifest.yaml   # Required
    RULE.md         # Required (exact filename)
```

- **id**: Lowercase, hyphens allowed, no spaces (e.g. `framework-fastapi`, `typescript-standards`).
- **manifest.yaml**: Must contain `version`, `project_types`, and optional `description`.
- **RULE.md**: Rule content. When installed via Forge this becomes `.cursor/rules/<id>/RULE.md`. You can use Cursor rule frontmatter inside RULE.md (e.g. `description`, `globs`, `alwaysApply`) so the rule behaves correctly after install.

### manifest.yaml schema

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `version` | string | Yes | Non-empty, e.g. `1.0.0`. |
| `project_types` | list of strings | Yes | One or more of: `data`, `backend`, `frontend`, `infra`. |
| `description` | string | No | Short description of the rule. |

Example:

```yaml
version: "1.0.0"
project_types:
  - backend
description: FastAPI backend API and Pydantic conventions.
```

### RULE.md content

RULE.md can follow Cursor rule conventions so it works once installed:

- Optional YAML frontmatter: `description`, `globs` (file pattern), `alwaysApply` (boolean).
- Body: rule content (what to enforce, examples, do/don’t).

Example RULE.md:

```markdown
---
description: FastAPI and Pydantic standards for backend APIs
globs: **/*.py
alwaysApply: false
---

# Backend API Rules

- Use Pydantic for request/response models.
- Keep endpoints thin; delegate to services.
...
```

---

## Gather Requirements

Before creating the rule, collect:

1. **id**: Unique identifier (lowercase, hyphens). If working inside an existing registry, confirm it does not already exist under `rules/<id>/`.
2. **project_types**: Which project types this rule applies to (`data`, `backend`, `frontend`, `infra`). At least one.
3. **description** (optional): One line for the manifest.
4. **Rule scope**: Should it always apply or only for specific files? If file-specific, which globs (e.g. `**/*.py`, `backend/**/*.ts`)?
5. **Rule content**: What the rule enforces—standards, examples, good/bad patterns. Keep concise (e.g. under 50 lines when possible).

Infer from conversation context when possible. Use AskQuestion when available if id, project_types, scope, or globs are unclear.

---

## Produce the Rule

1. **Create directory**: `rules/<id>/`.
2. **Write manifest.yaml** in that directory with `version`, `project_types`, and optional `description`. Use only allowed `project_types` values.
3. **Write RULE.md** in the same directory. Include Cursor frontmatter if the rule is file-specific or should always apply; then add the rule body.
4. **Validation**: Ensure `manifest.yaml` is valid YAML, `project_types` only include `data`, `backend`, `frontend`, `infra`, and `RULE.md` exists with the exact filename.

If the user is not in a registry root, create the structure under a clear path (e.g. `rules/<id>/` relative to current directory or a path the user specifies) so they can copy it into their registry.

---

## Checklist

Before finishing, verify:

- [ ] Directory is `rules/<id>/` with no spaces in `id`.
- [ ] `manifest.yaml` has `version` (non-empty string) and `project_types` (non-empty list).
- [ ] Every `project_types` value is one of: `data`, `backend`, `frontend`, `infra`.
- [ ] Content file is named exactly `RULE.md` (not rule.md or Rule.md) and is in the same directory as `manifest.yaml`.
- [ ] RULE.md content is concise and includes scope (frontmatter) and actionable guidance.
- [ ] After install via Forge, this rule will appear at `.cursor/rules/<id>/RULE.md` in consuming projects.
