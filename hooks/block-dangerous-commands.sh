#!/bin/bash
# PreToolUse hook: Block dangerous bash commands
# Exit 0 with JSON deny = block, Exit 0 without output = allow

INPUT=$(cat)
COMMAND=$(echo "$INPUT" | jq -r '.tool_input.command // empty')

if [ -z "$COMMAND" ]; then
  exit 0
fi

# Strip heredoc blocks and single-quoted strings to avoid false positives
# (e.g., commit messages containing "git push --force" as description text)
EXECUTABLE=$(echo "$COMMAND" | sed "/<<[[:space:]]*['\"]\\{0,1\\}EOF/,/^[[:space:]]*EOF/d" \
  | sed "/<<[[:space:]]*['\"]\\{0,1\\}EOM/,/^[[:space:]]*EOM/d" \
  | sed "s/'[^']*'//g" \
  | sed 's/"[^"]*"//g')

# Dangerous patterns — checked against executable lines only
BLOCKED_PATTERNS=(
  'rm -rf /'
  'rm -rf ~'
  'rm -rf \.\.'
  'git push --force'
  'git push -f '
  'git reset --hard'
  'DROP TABLE'
  'DROP DATABASE'
  'mkfs\.'
  ':(){:|:&};:'
  '> /dev/sda'
  'chmod -R 777 /'
  'dd if=/dev'
)

for pattern in "${BLOCKED_PATTERNS[@]}"; do
  if echo "$EXECUTABLE" | grep -qiE "$pattern"; then
    jq -n \
      --arg reason "BLOCKED: Destructive command detected ($pattern). Use a safer alternative." \
      '{
        "hookSpecificOutput": {
          "hookEventName": "PreToolUse",
          "permissionDecision": "deny",
          "permissionDecisionReason": $reason
        }
      }'
    exit 0
  fi
done

# Warn (but allow) sudo commands
if echo "$EXECUTABLE" | grep -qE '^sudo '; then
  jq -n '{
    "hookSpecificOutput": {
      "hookEventName": "PreToolUse",
      "permissionDecision": "defer",
      "additionalContext": "WARNING: sudo command detected. Ensure this is necessary and minimal in scope."
    }
  }'
  exit 0
fi

exit 0
