# Workflow: Planning (Phase 2)

Turn a spec from Phase 1 into GitHub issues with subtasks, each referencing at least one acceptance criterion. This is Phase 2 of the AI Spec-Driven Development Framework.

**Workflow id:** `planning`  
**Phases:** 2

## Before you run

- **Plan mode:** Start in plan mode. Present the plan (this workflow's steps and the inputs below). Do not execute any step until the user confirms the plan.
- **Required inputs:** Before running, prompt the user for every **required** input listed in the Inputs table. Do not execute until all required inputs are provided.
- **Tooling and access:** This workflow relies on GitHub integrations (CLI/MCP/API) for creating issues and updating project boards. **If the required tooling or authentication is not available in the current environment, stop execution, explain what is missing, and ask the user to either authorize a suitable environment or run the GitHub commands themselves. Do not attempt to reconfigure authentication silently.**

## Inputs

| Name | Source | Description |
|------|--------|-------------|
| spec | User | Spec file or path from Phase 1 (requirements, acceptance criteria, success metrics). |
| owner | User | GitHub org or owner for issue creation. |
| repo | User | Repository name for issues. |
| project (optional) | User | Optional project board ID or name to add issues to. |

## Outputs

- **GitHub issues** – With subtasks, each referencing at least one acceptance criterion. If the spec mentions infrastructure, validate assumptions using aws-context before creating subtasks.
- **Parent + subissue structure** – All parent issues and subissues for the feature are created **only** in this phase, never in discovery or implementation. When a GitHub project is provided, all created issues must be added to the project and **explicitly moved to the correct Status (e.g. Backlog, Ready)** using `github-project-status`.

## Implementing skills

**Registry skill ids:** github-issue, github-issue-operations, github-issue-creation-standards, github-sub-issue-linking, github-project-board, github-project-status; aws-context, aws-resource-discovery (when spec involves infra).

## Steps

1. **Validate infrastructure (if applicable):** If the spec involves infrastructure or AWS, run the **aws-context** skill to validate assumptions before creating subtasks. Do not invent requirements; if a dependency is missing from the spec, loop back to Phase 1.
2. **Run the planning agent** with the spec, owner, and repo. The agent must use the **github-issue** skill to create issues and subtasks, each mapped to at least one acceptance criterion. **For every project/repository planned in this phase, the planning agent must create at least one `[ops]` sub-issue whose explicit scope is to create or update GitHub workflows (GitHub Actions) for that project (covering tests, linting, build, and deploy workflows as appropriate).** All issue and subissue creation for this feature must happen here (not in discovery or implementation).
3. **Add issues to the project board (when provided):**
   - When `project` is provided, use **github-project-board** to add the parent feature issue and all subissues to the specified Project v2 board.
   - After each issue is added, use **github-project-status** (or the helper script from `github-project-status`, which wraps `gh project item-edit`) to set the item’s **Status** field explicitly. For new Workflow V2 issues, default to **Backlog** unless the user requests a different initial status.
   - The canonical CLI flow is:

     ```bash
     OWNER="your-username-or-org"
     PROJECT_NUMBER=4
     REPO="your-username/your-repo"

     # 1) Create the issue and capture its URL
     ISSUE_URL=$(gh issue create \
       --repo "$REPO" \
       --title "My new issue" \
       --body "Issue description" \
       --json url --jq '.url')

     # 2) Add the issue to the project and capture the item ID
     ITEM_ID=$(gh project item-add "$PROJECT_NUMBER" \
       --owner "$OWNER" \
       --url "$ISSUE_URL" \
       --format json | jq -r '.id')

     # 3) Resolve project + Status field/option IDs
     PROJECT_ID=$(gh project view "$PROJECT_NUMBER" --owner "$OWNER" --format json | jq -r '.id')
     FIELDS=$(gh project field-list "$PROJECT_NUMBER" --owner "$OWNER" --format json)

     STATUS_FIELD_ID=$(echo "$FIELDS" \
       | jq -r '.fields[] | select(.name == "Status") | .id')

     BACKLOG_OPTION_ID=$(echo "$FIELDS" \
       | jq -r '.fields[] | select(.name == "Status") | .options[] | select(.name == "Backlog") | .id')

     # 4) Set Status to Backlog for the new item
     gh project item-edit "$PROJECT_NUMBER" \
       --id "$ITEM_ID" \
       --project-id "$PROJECT_ID" \
       --field-id "$STATUS_FIELD_ID" \
       --single-select-option-id "$BACKLOG_OPTION_ID"
     ```

4. **Move issues to the target working status:** After planning is complete, use the **github-project-board** and **github-project-status** skills (or the helper script from `github-project-status`) to move the parent issue and all subissues created in this phase from **Backlog** to **Ready** (or another team-defined status) when they are fully planned and ready for implementation, **including the required `[ops]` sub-issue for GitHub workflows for each planned project.**

## Agent rules (Phase 2)

- When creating issues, always use the `github-issue` skill.
- When validating infrastructure assumptions, always use the `aws-context` skill before creating subtasks.
- If a dependency is missing from the spec, loop back to Phase 1. Do not invent requirements.

## How to reference in Cursor

- Install to `.cursor/workflows/planning/`.
- Run the workflow with id **planning**. Use plan mode and required inputs per this file.
