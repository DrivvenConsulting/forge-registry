#!/usr/bin/env bash
set -euo pipefail

usage() {
  cat <<EOF
Usage: $(basename "$0") --owner OWNER --project PROJECT_NUMBER --issue ISSUE_NUMBER --status STATUS_NAME

Move a GitHub Project (Projects v2) item's Status field to the given STATUS_NAME
using the GitHub CLI and jq.

Required:
  --owner    GitHub user or org that owns the project (e.g. DrivvenConsulting)
  --project  Project number (e.g. 6)
  --issue    Repository issue number (e.g. 42)
  --status   Target Status name as shown on the project board (case-sensitive, e.g. "Ready")

Environment:
  GITHUB_TOKEN must be set and authorized for project access.

Prerequisites:
  - gh (GitHub CLI)
  - jq

Example:
  $(basename "$0") --owner DrivvenConsulting --project 6 --issue 42 --status "Ready"
EOF
}

OWNER=""
PROJECT_NUMBER=""
ISSUE_NUMBER=""
STATUS_NAME=""

while [[ $# -gt 0 ]]; do
  case "$1" in
    --owner)
      OWNER="$2"
      shift 2
      ;;
    --project)
      PROJECT_NUMBER="$2"
      shift 2
      ;;
    --issue)
      ISSUE_NUMBER="$2"
      shift 2
      ;;
    --status)
      STATUS_NAME="$2"
      shift 2
      ;;
    -h|--help)
      usage
      exit 0
      ;;
    *)
      echo "Unknown argument: $1" >&2
      usage
      exit 1
      ;;
  esac
done

if [[ -z "${OWNER}" || -z "${PROJECT_NUMBER}" || -z "${ISSUE_NUMBER}" || -z "${STATUS_NAME}" ]]; then
  echo "Missing required arguments." >&2
  usage
  exit 1
fi

if ! command -v gh >/dev/null 2>&1; then
  echo "Error: gh (GitHub CLI) is not installed or not in PATH." >&2
  exit 1
fi

if ! command -v jq >/dev/null 2>&1; then
  echo "Error: jq is not installed or not in PATH." >&2
  exit 1
fi

echo "Ensuring GitHub CLI has project scope..."
gh auth refresh -s project >/dev/null 2>&1 || true

echo "Fetching project ID for owner='${OWNER}', project='${PROJECT_NUMBER}'..."
PROJECT_ID=$(gh project view "${PROJECT_NUMBER}" --owner "${OWNER}" --format json | jq -r '.id')

if [[ -z "${PROJECT_ID}" || "${PROJECT_ID}" == "null" ]]; then
  echo "Error: Could not resolve project ID." >&2
  exit 1
fi

echo "Fetching project fields..."
FIELDS=$(gh project field-list "${PROJECT_NUMBER}" --owner "${OWNER}" --format json)

STATUS_FIELD_ID=$(echo "${FIELDS}" \
  | jq -r '.fields[] | select(.name == "Status") | .id')

if [[ -z "${STATUS_FIELD_ID}" || "${STATUS_FIELD_ID}" == "null" ]]; then
  echo "Error: Could not find a 'Status' field on this project." >&2
  exit 1
fi

TARGET_OPTION_ID=$(echo "${FIELDS}" \
  | jq -r --arg name "${STATUS_NAME}" \
      '.fields[] | select(.name == "Status") | .options[] | select(.name == $name) | .id')

if [[ -z "${TARGET_OPTION_ID}" || "${TARGET_OPTION_ID}" == "null" ]]; then
  echo "Error: Could not find Status option named '${STATUS_NAME}'." >&2
  exit 1
fi

echo "Locating project item for issue #${ISSUE_NUMBER}..."
ITEM_ID=$(gh project item-list "${PROJECT_NUMBER}" --owner "${OWNER}" --format json --limit 1000 \
  | jq -r --argjson n "${ISSUE_NUMBER}" '.items[] | select(.content.number == $n) | .id')

if [[ -z "${ITEM_ID}" || "${ITEM_ID}" == "null" ]]; then
  echo "Error: Could not find a project item for issue #${ISSUE_NUMBER}." >&2
  exit 1
fi

echo "Updating Status to '${STATUS_NAME}'..."
gh project item-edit "${PROJECT_NUMBER}" \
  --id "${ITEM_ID}" \
  --project-id "${PROJECT_ID}" \
  --field-id "${STATUS_FIELD_ID}" \
  --single-select-option-id "${TARGET_OPTION_ID}"

echo "Successfully updated Status for issue #${ISSUE_NUMBER} to '${STATUS_NAME}'."

