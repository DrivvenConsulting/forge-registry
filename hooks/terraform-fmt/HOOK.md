---
name: terraform-fmt
description: Auto-format Terraform files with terraform fmt --recursive after writing.
---

# terraform-fmt

Runs `terraform fmt --recursive` on the working directory immediately after Claude writes any `.tf` file.

## Trigger

| Field   | Value                   |
|---------|------------------------|
| Event   | `PostToolUse`           |
| Matcher | `Write`                 |
| Guard   | file path ends in `.tf` |

## Files

- **`hooks.json`** — hook definition; merge the `PostToolUse` entry into your project's `.claude/settings.json`.
- **`scripts/terraform-fmt.sh`** — script executed by the hook; copy to `.claude/hooks/terraform-fmt.sh` in the consuming project.

## Installing

1. Copy `scripts/terraform-fmt.sh` to `.claude/hooks/terraform-fmt.sh` and make it executable:
   ```bash
   chmod +x .claude/hooks/terraform-fmt.sh
   ```
2. Merge `hooks.json` into `.claude/settings.json` under the top-level `"hooks"` key.

## Prerequisites

- [`terraform`](https://developer.hashicorp.com/terraform/install) installed (`brew install terraform` or via `tfenv`)
- [`jq`](https://jqlang.org/) installed (`brew install jq`)
