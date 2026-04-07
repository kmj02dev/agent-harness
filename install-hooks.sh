#!/bin/bash
# Install harness hooks into ~/.claude/settings.json
# Run this from shell (not from Claude Code) — one-time setup per machine.
set -e

HARNESS_DIR="$(cd "$(dirname "$0")" && pwd)"
SETTINGS_DIR=~/.claude
SETTINGS="$SETTINGS_DIR/settings.json"
HOOKS_SOURCE="$HARNESS_DIR/harness-hooks.json"

# Check jq
if ! command -v jq &>/dev/null; then
  echo "ERROR: jq is required. Install with: sudo apt install jq"
  exit 1
fi

# Ensure .claude directory exists
mkdir -p "$SETTINGS_DIR"

# Create settings.json if missing
if [ ! -f "$SETTINGS" ]; then
  echo '{}' > "$SETTINGS"
  echo "Created $SETTINGS"
fi

# Backup
BACKUP="${SETTINGS}.backup.$(date +%s)"
cp "$SETTINGS" "$BACKUP"
echo "Backup: $BACKUP"

# Merge hooks into settings (preserves all existing settings)
HOOKS=$(cat "$HOOKS_SOURCE")
jq --argjson hooks "$HOOKS" '.hooks = $hooks' "$SETTINGS" > "${SETTINGS}.tmp" \
  && mv "${SETTINGS}.tmp" "$SETTINGS"

echo "Hooks installed into $SETTINGS"
echo ""
echo "Installed hooks:"
echo "  - PreToolUse/Bash: block-dangerous-commands.sh"
echo "  - PreToolUse/Edit|Write: protect-files.sh"
echo "  - PostToolUse/Edit|Write: verify-reminder.sh"
