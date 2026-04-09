---
name: ruff-format
description: Auto-format Python files with ruff after writing.
---

# ruff-format

Runs `ruff format` on any Python file immediately after Claude writes it.

## Trigger

| Field   | Value                   |
|---------|------------------------|
| Event   | `PostToolUse`           |
| Matcher | `Write`                 |
| Guard   | file path ends in `.py` |

## Files

- **`hooks.json`** — hook definition; merge the `PostToolUse` entry into your project's `.claude/settings.json`.
- **`scripts/ruff-format.sh`** — script executed by the hook; copy to `.claude/hooks/ruff-format.sh` in the consuming project.

## Installing

1. Copy `scripts/ruff-format.sh` to `.claude/hooks/ruff-format.sh` and make it executable:
   ```bash
   chmod +x .claude/hooks/ruff-format.sh
   ```
2. Merge `hooks.json` into `.claude/settings.json` under the top-level `"hooks"` key.

## Prerequisites

- [`uv`](https://docs.astral.sh/uv/) installed (`brew install uv` or `curl -LsSf https://astral.sh/uv/install.sh | sh`)
- [`jq`](https://jqlang.org/) installed (`brew install jq`)
