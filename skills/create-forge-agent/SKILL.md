---
name: create-forge-agent
description: Create a new agent in Forge registry format. Use when the user wants to create an agent for the Forge registry, add an agent to a registry repo, or scaffold agent manifest and content (agent.md) that can be installed via forge install agent.
---
# Creating Forge Registry Agents

This skill guides you through creating a new **agent** in the Forge registry format. The result can be added to a Forge registry repo and installed into projects with `forge install agent <id>`.

## When to Use

- User wants to create a new agent for the Forge registry.
- User is working in a registry repo (or a folder to be copied into one) and wants to add an agent.
- User asks for agent scaffolding that matches Forge’s validated format.

---

## Forge Registry Format (Agents)

### Directory layout

```
agents/
  <id>/
    manifest.yaml   # Required
    agent.md        # Required (convention; any .md is accepted at install time)
```

- **id**: Lowercase, hyphens allowed, no spaces (e.g. `backend-engineer`, `data-reviewer`).
- **manifest.yaml**: Must contain `version`, `project_types`, and optional `description`.
- **agent.md**: Markdown content; when installed via Forge this becomes `.cursor/agents/<id>.md`.

### manifest.yaml schema

| Field | Type | Required | Description |
|-------|------|----------|-------------|
| `version` | string | Yes | Non-empty, e.g. `1.0.0`. |
| `project_types` | list of strings | Yes | One or more of: `data`, `backend`, `frontend`, `infra`. |
| `description` | string | No | Short description of the agent. |

Example:

```yaml
version: "1.0.0"
project_types:
  - backend
  - infra
description: Agent that implements backend and infra tasks following team standards.
```

---

## Gather Requirements

Before creating the agent, collect:

1. **id**: Unique identifier (lowercase, hyphens). If working inside an existing registry, confirm it does not already exist under `agents/<id>/`.
2. **project_types**: Which project types this agent applies to (`data`, `backend`, `frontend`, `infra`). At least one.
3. **description** (optional): One line for the manifest.
4. **Content**: What the agent does—instructions, tone, constraints, and any examples. This becomes the body of `agent.md`.

Infer from conversation context when possible. Use AskQuestion when available if id, project_types, or purpose are unclear.

---

## Produce the Agent

1. **Create directory**: `agents/<id>/`.
2. **Write manifest.yaml** in that directory with `version`, `project_types`, and optional `description`. Use only allowed `project_types` values.
3. **Write agent.md** in the same directory with the agent instructions (markdown). No frontmatter required in the content file unless the user wants it; the manifest holds metadata.
4. **Validation**: Ensure `manifest.yaml` is valid YAML, `project_types` only include `data`, `backend`, `frontend`, `infra`, and `agent.md` exists.

If the user is not in a registry root, create the structure under a clear path (e.g. `agents/<id>/` relative to current directory or a path the user specifies) so they can copy it into their registry.

---

## Checklist

Before finishing, verify:

- [ ] Directory is `agents/<id>/` with no spaces in `id`.
- [ ] `manifest.yaml` has `version` (non-empty string) and `project_types` (non-empty list).
- [ ] Every `project_types` value is one of: `data`, `backend`, `frontend`, `infra`.
- [ ] `agent.md` exists in the same directory and contains the agent instructions.
- [ ] After install via Forge, this agent will appear as `.cursor/agents/<id>.md` in consuming projects.
