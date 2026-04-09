#!/bin/bash
FILE=$(jq -r '.tool_input.file_path // empty')
echo "$FILE" | grep -qE '\.py$' || exit 0
uvx ruff format "$FILE"
