#!/bin/bash
# PreToolUse hook: Warn before git push to ensure changes are reviewed
INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if echo "$COMMAND" | grep -qE '^\s*git\s+push'; then
  BRANCH=$(git branch --show-current 2>/dev/null)
  UNPUSHED=$(git log --oneline "@{u}..HEAD" 2>/dev/null | wc -l | tr -d ' ')

  echo "About to push to branch: ${BRANCH:-unknown}" >&2
  if [ "$UNPUSHED" -gt 0 ]; then
    echo "${UNPUSHED} unpushed commit(s). Please confirm this is intentional." >&2
  fi

  if echo "$COMMAND" | grep -qE '\-\-force|\-f'; then
    echo "BLOCKED: Force push detected. This is a destructive operation." >&2
    exit 2
  fi
fi

exit 0
