#!/bin/bash
# PreToolUse hook: Prevent editing protected files

INPUT=$(cat)
FILE_PATH=$(echo "$INPUT" | jq -r '.tool_input.file_path // empty')

if [ -z "$FILE_PATH" ]; then
  exit 0
fi

# Protected file patterns (secrets and credentials only)
# Note: .claude/settings.json is intentionally NOT protected
# so that hooks can be managed programmatically.
PROTECTED_PATTERNS=(
  '\.env$'
  '\.env\.'
  'credentials\.json'
  'secrets\.json'
  'secrets\.yaml'
  '\.pem$'
  '\.key$'
  'id_rsa'
  'id_ed25519'
  '\.p12$'
  '\.pfx$'
)

for pattern in "${PROTECTED_PATTERNS[@]}"; do
  if echo "$FILE_PATH" | grep -qiE "$pattern"; then
    jq -n \
      --arg reason "BLOCKED: Protected file ($FILE_PATH). Editing secrets/credentials is not allowed." \
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

exit 0
