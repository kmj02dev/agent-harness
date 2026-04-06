#!/bin/bash
# PostToolUse hook: Remind to run tests after code file changes

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Only trigger for code files
if echo "$FILE_PATH" | grep -qE '\.(py|js|ts|jsx|tsx|go|rs|java|c|cpp|h)$'; then
  jq -n '{
    "additionalContext": "VERIFY LOOP: Code file modified. Remember to run lint/typecheck → test → build before marking task as done."
  }'
  exit 0
fi

exit 0
