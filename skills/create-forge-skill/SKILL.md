---
name: create-forge-skill
description: Create a new skill in Forge registry format. Use when the user wants to create a skill for the Forge registry, add a skill to a registry repo, or scaffold skill manifest and SKILL.md that can be installed via forge install skill.
---
# Creating Forge Registry Skills

This skill guides you through creating a new **skill** in the Forge registry format. The result can be added to a Forge registry repo and installed into projects with `forge install skill <id>`. After install, the skill appears at `.cursor/skills/<id>/SKILL.md`.

## When to Use

- User wants to create a new skill for the Forge registry.
- User is working in a registry repo (or a folder to be copied into one) and wants to add a skill.
- User asks for skill scaffolding that matches Forge’s validated format.

---

## Forge Registry Format (Skills)

### Directory layout

```
skills/
  <id>/
    manifest.yaml   # Required
    SKILL.md        # Required (exact filename)
```

- **id**: Lowercase, hyphens allowed, no spaces (e.g. `code-review`, `commit-messages`).
- **manifest.yaml**: Must contain `version`, `project_types`, and optional `description`.
- **SKILL.md**: Skill content. When installed via Forge this becomes `.cursor/skills/<id>/SKILL.md`. SKILL.md should include YAML frontmatter (`name`, `description`) and a clear body so the skill is discoverable and useful after install.

### manifest.yaml schema

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `version` | string | Yes | Non-empty, e.g. `1.0.0`. |
| `project_types` | list of strings | Yes | One or more of: `data`, `backend`, `frontend`, `infra`. |
| `description` | string | No | Short description of the skill. |

Example:

```yaml
version: "1.0.0"
project_types:
  - backend
  - frontend
description: Review code for quality and security following team standards.
```

### SKILL.md content

SKILL.md should follow Cursor skill conventions so it works once installed:

- YAML frontmatter: `name` (skill id or display name), `description` (what the skill does and when to use it—third person, specific, with trigger terms).
- Body: instructions, examples, workflows. Keep main SKILL.md under ~500 lines; use progressive disclosure (e.g. reference.md, examples.md) if needed.

Example SKILL.md:

```markdown
---
name: code-review
description: Review code for quality, security, and maintainability following team standards. Use when reviewing pull requests, examining code changes, or when the user asks for a code review.
---

# Code Review

## Quick Start

When reviewing code:
1. Check correctness and edge cases.
2. Verify security and style.
3. Ensure tests are adequate.

## Checklist

- [ ] Logic correct; edge cases handled
- [ ] No security issues
- [ ] Follows project conventions
```

---

## Gather Requirements

Before creating the skill, collect:

1. **id**: Unique identifier (lowercase, hyphens). If working inside an existing registry, confirm it does not already exist under `skills/<id>/`.
2. **project_types**: Which project types this skill applies to (`data`, `backend`, `frontend`, `infra`). At least one.
3. **description** (optional): One line for the manifest.
4. **Skill purpose**: What task or workflow does this skill support? When should the agent apply it?
5. **Skill content**: Instructions, examples, and any templates or checklists. Keep SKILL.md concise; link to extra files if needed.

Infer from conversation context when possible. Use AskQuestion when available if id, project_types, or purpose are unclear.

---

## Produce the Skill

1. **Create directory**: `skills/<id>/`.
2. **Write manifest.yaml** in that directory with `version`, `project_types`, and optional `description`. Use only allowed `project_types` values.
3. **Write SKILL.md** in the same directory with frontmatter (`name`, `description`) and body. Description in frontmatter should be specific and third-person, with trigger scenarios.
4. **Validation**: Ensure `manifest.yaml` is valid YAML, `project_types` only include `data`, `backend`, `frontend`, `infra`, and `SKILL.md` exists with the exact filename.

If the user is not in a registry root, create the structure under a clear path (e.g. `skills/<id>/` relative to current directory or a path the user specifies) so they can copy it into their registry.

---

## Checklist

Before finishing, verify:

- [ ] Directory is `skills/<id>/` with no spaces in `id`.
- [ ] `manifest.yaml` has `version` (non-empty string) and `project_types` (non-empty list).
- [ ] Every `project_types` value is one of: `data`, `backend`, `frontend`, `infra`.
- [ ] Content file is named exactly `SKILL.md` (not skill.md or Skill.md) and is in the same directory as `manifest.yaml`.
- [ ] SKILL.md has frontmatter with `name` and `description`; description is specific and includes when to use the skill.
- [ ] After install via Forge, this skill will appear at `.cursor/skills/<id>/SKILL.md` in consuming projects.
