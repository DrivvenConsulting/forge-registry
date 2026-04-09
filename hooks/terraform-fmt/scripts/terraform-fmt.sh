#!/bin/bash
FILE=$(jq -r '.tool_input.file_path // empty')
echo "$FILE" | grep -qE '\.tf$' || exit 0
terraform fmt --recursive
