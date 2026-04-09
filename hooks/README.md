# Hooks

Claude Code hooks that run automatically in response to tool events. Each hook lives in its own directory with a `manifest.yaml` and a `HOOK.md`.

## Available hooks

| ID | Event | Matcher | Guard | Description |
|----|-------|---------|-------|-------------|
| `ruff-format` | PostToolUse | Write | `*.py` | Format Python files with `ruff format` |
| `terraform-fmt` | PostToolUse | Write | `*.tf` | Format Terraform files with `terraform fmt --recursive` |

## Asset layout

```
hooks/
  <hook-id>/
    manifest.yaml   # version, description, project_types, event, matcher
    HOOK.md         # trigger table, settings snippet, prerequisites
```

## Installing a hook

Copy the settings snippet from the hook's `HOOK.md` and merge it into your project's `.claude/settings.local.json`. If multiple hooks share the same event+matcher, merge their `hooks` arrays under a single matcher entry.

## Adding a new hook

1. Create `hooks/<hook-id>/manifest.yaml` with `version`, `description`, `project_types`, `event`, and `matcher`.
2. Create `hooks/<hook-id>/HOOK.md` with a trigger table, settings snippet, and prerequisites.
3. If the hook belongs to a bundle, add it to `bundles/<name>/manifest.yaml` under `items:` with `kind: hook`.
