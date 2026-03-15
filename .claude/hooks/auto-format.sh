#!/bin/bash
# PostToolUse hook: Auto-format edited files with Prettier
INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ] || [ ! -f "$FILE_PATH" ]; then
  exit 0
fi

# Only format file types that Prettier handles
case "$FILE_PATH" in
  *.ts|*.tsx|*.js|*.jsx|*.json|*.jsonc|*.css|*.scss|*.html|*.yml|*.yaml|*.md)
    npx prettier --write "$FILE_PATH" >/dev/null 2>&1
    ;;
esac

exit 0
