---
name: github-project-status
description: Move an issue’s Project v2 Status field (e.g. Backlog → In progress, Ready for testing) using the GitHub CLI. Use when you need to change the Status of a work item on a GitHub project board.
---

# GitHub Project Status (CLI)

Use this skill to move an issue between Status values (e.g. **Backlog**, **In progress**, **Ready for testing**, **Reviewed/Tested**) on a GitHub Project (Projects v2) using the `gh` CLI. The Status field is a single‑select project field; updating it requires field and option IDs, not just the visible names.

This skill is typically used together with **github-project-board** (which decides *when* to move an item) and higher‑level workflow skills (e.g. moving items to **In progress** when implementation starts, or to **Ready for testing** when a PR is closed).

## When to Use

- You need to move an issue from one Status (e.g. Backlog) to another (e.g. In progress, Ready for testing, Reviewed/Tested) on a GitHub Project (Projects v2).
- You are running automation or helper scripts that use `gh project` to update project item fields.
- You want a repeatable way to change Status by name (e.g. `"In progress"`) without manually looking up internal IDs each time.

Equip this skill when your role includes **programmatically** updating project Status via the GitHub CLI. It assumes `gh` and `jq` are installed and authenticated. **If the required CLI or authentication is not available from the current environment, stop execution, explain what is missing, and ask the user to either authorize a suitable environment or run the necessary commands themselves. Do not attempt to reconfigure authentication silently.**

## Prerequisites

1. **GitHub CLI auth scope**
   - Ensure the `project` scope is granted:
   - `gh auth refresh -s project`

2. **Inputs you must know**
   - `OWNER` – GitHub user or org that owns the project (e.g. `DrivvenConsulting` or your username).
   - `PROJECT_NUMBER` – The **project number** (e.g. `6`), not the project ID.
   - `ISSUE_NUMBER` – The repository issue number you want to move (e.g. `42`).
   - `STATUS_NAME` – The exact target Status option name as shown in the project (case‑sensitive, e.g. `"In progress"`).

## Core Steps (Conceptual)

1. **Get the Project ID**
   - Use `gh project view` to fetch the project and extract `.id` (e.g. `PVT_...`).
2. **Get Status field and option IDs**
   - Use `gh project field-list` to list fields for the project.
   - Find the `"Status"` field and capture:
     - `STATUS_FIELD_ID` – the field’s ID.
     - `TARGET_OPTION_ID` – the option ID whose `.name` matches your desired status (e.g. `"In progress"`).
3. **Get the project item ID for the issue**
   - Use `gh project item-list` and filter by `.content.number == <ISSUE_NUMBER>` to get the item that represents your issue on the project.
   - Extract its `.id` (e.g. `PVTI_...`).
4. **Edit the item to set Status**
   - Call `gh project item-edit` with:
     - `--project-id <PROJECT_ID>`
     - `--id <ITEM_ID>`
     - `--field-id <STATUS_FIELD_ID>`
     - `--single-select-option-id <TARGET_OPTION_ID>`

## Reference CLI Flow (Manual)

Below is the end‑to‑end flow, using environment variables for clarity. Replace `OWNER`, `PROJECT_NUMBER`, `ISSUE_NUMBER`, and `"In progress"` with your own values.

```bash
OWNER="your-username-or-org"
PROJECT_NUMBER=6
ISSUE_NUMBER=42
TARGET_STATUS_NAME="In progress"

# 1) Ensure auth scope
gh auth refresh -s project

# 2) Get project ID
PROJECT_ID=$(gh project view "$PROJECT_NUMBER" --owner "$OWNER" --format json | jq -r '.id')

# 3) Get Status field and desired option IDs
FIELDS=$(gh project field-list "$PROJECT_NUMBER" --owner "$OWNER" --format json)

STATUS_FIELD_ID=$(echo "$FIELDS" \
  | jq -r '.fields[] | select(.name == "Status") | .id')

TARGET_OPTION_ID=$(echo "$FIELDS" \
  | jq -r --arg name "$TARGET_STATUS_NAME" \
      '.fields[] | select(.name == "Status") | .options[] | select(.name == $name) | .id')

# 4) Get the project item ID for the issue
ITEM_ID=$(gh project item-list "$PROJECT_NUMBER" --owner "$OWNER" --format json --limit 1000 \
  | jq -r --argjson n "$ISSUE_NUMBER" '.items[] | select(.content.number == $n) | .id')

# 5) Update the Status field
gh project item-edit "$PROJECT_NUMBER" \
  --id "$ITEM_ID" \
  --project-id "$PROJECT_ID" \
  --field-id "$STATUS_FIELD_ID" \
  --single-select-option-id "$TARGET_OPTION_ID"
```

To change to a different Status, only update `TARGET_STATUS_NAME` (e.g. `"Backlog"`, `"In progress"`, `"Ready for testing"`, `"Reviewed/Tested"`).

## Recommended Helper Script

Use the helper script `skills/github-project-status/scripts/gh-project-set-status.sh` to avoid repeating the full CLI flow. The script:

- Accepts arguments for `OWNER`, `PROJECT_NUMBER`, `ISSUE_NUMBER`, and `STATUS_NAME`.
- Looks up the project ID, Status field ID, and option ID.
- Finds the project item for the given issue.
- Calls `gh project item-edit` to set the Status.

### Usage (example)

```bash
skills/github-project-status/scripts/gh-project-set-status.sh \
  --owner DrivvenConsulting \
  --project 6 \
  --issue 42 \
  --status "In progress"
```

Agents should not hardcode the script path, but may reference this skill as the canonical way to change Status on the project when a GitHub CLI integration is available.

## Do

- Use this skill whenever you must **programmatically** move an item between Status values on a GitHub Project (Projects v2).
- Treat `STATUS_NAME` as case‑sensitive and ensure it matches the option label on the project board.
- Reuse the helper script instead of re‑implementing the CLI sequence.

## Do Not

- Assume that the visible Status name is accepted directly by the API or CLI; you must resolve field and option IDs first (as shown above).
- Hardcode project IDs, field IDs, or option IDs in code; always resolve them dynamically from `gh project` commands.
- Reference specific MCP tool names or internal implementation details in agent prompts; refer to this skill instead.

