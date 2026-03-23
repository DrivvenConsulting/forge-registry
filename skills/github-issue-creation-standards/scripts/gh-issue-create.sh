#!/usr/bin/env bash
set -euo pipefail

# gh-issue-create.sh
#
# Helper script to create a GitHub issue that follows the
# "GitHub Issue Creation Standards" skill for project 6.
#
# Requirements:
#   - GitHub CLI (gh) authenticated (gh auth login)
#
# Usage:
#   OWNER=DrivvenConsulting REPO=adlyze TITLE="My feature" \
#   LABEL="backend" ISSUE_TYPE="Task" \
#   ./scripts/gh-issue-create.sh
#
# Environment variables:
#   OWNER        - GitHub organization or user (e.g. DrivvenConsulting)
#   REPO         - Repository name (e.g. adlyze)
#   TITLE        - Issue title
#   LABEL        - Implementation label for tasks (backend, frontend, data-engineering, devops, internal, quality-assurance).
#                  For parent Feature issues, leave empty.
#   ISSUE_TYPE   - "Feature" or "Task" (used in body metadata note). Defaults to "Task".
#   BODY_FILE    - Optional path to a Markdown body file; if unset, the standard template in assets/issue-template.md is used.
#

if [[ -z "${OWNER:-}" || -z "${REPO:-}" || -z "${TITLE:-}" ]]; then
  echo "OWNER, REPO, and TITLE must be set." >&2
  exit 1
fi

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
DEFAULT_BODY="${SCRIPT_DIR%/scripts}/assets/issue-template.md"
BODY_FILE="${BODY_FILE:-$DEFAULT_BODY}"

if [[ ! -f "$BODY_FILE" ]]; then
  echo "Body file not found: $BODY_FILE" >&2
  exit 1
fi

ISSUE_TYPE="${ISSUE_TYPE:-Task}"

echo "Creating issue in ${OWNER}/${REPO}"
echo "Title: ${TITLE}"
echo "Issue type (metadata note): ${ISSUE_TYPE}"
if [[ -n "${LABEL:-}" ]]; then
  echo "Label: ${LABEL}"
fi

TEMP_BODY="$(mktemp)"
cat "$BODY_FILE" > "$TEMP_BODY"

{
  echo
  echo "---"
  echo "_Metadata: Issue type: ${ISSUE_TYPE}; Milestone: MVP; Status: Backlog; Assignee: JnsFerreira_"
} >> "$TEMP_BODY"

GH_ARGS=(issue create --repo "${OWNER}/${REPO}" --title "${TITLE}" --milestone "MVP" --assignee "JnsFerreira" --body-file "$TEMP_BODY")

if [[ -n "${LABEL:-}" ]]; then
  GH_ARGS+=(--label "${LABEL}")
fi

gh "${GH_ARGS[@]}"

rm -f "$TEMP_BODY"

