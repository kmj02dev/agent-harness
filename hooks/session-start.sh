#!/bin/bash
# SessionStart hook: Inject Execution Protocol into every session
# This makes the harness work in interactive claude sessions,
# not just through run-agent.sh

INPUT=$(cat)
EVENT=$(echo "$INPUT" | jq -r '.hook_event_name // empty')
CWD=$(echo "$INPUT" | jq -r '.cwd // empty')

# Build context based on what session files exist in cwd
CONTEXT="## Execution Protocol (auto-injected by harness)\n"
CONTEXT+="1. Read TODO.md, LESSONS.md (global → project), WORKLOG.md to understand current state.\n"
CONTEXT+="2. Break the goal into subtasks and update TODO.md.\n"
CONTEXT+="3. Execute each subtask. After each, reflect: what worked, what didn't?\n"
CONTEXT+="4. Record lessons in LESSONS.md. Record decisions inline in WORKLOG.md (→ 결정: marker).\n"
CONTEXT+="5. Update TODO.md as tasks complete.\n"
CONTEXT+="6. Continue until the goal is fully achieved — do not stop to ask.\n"
CONTEXT+="7. When done, update WORKLOG.md with final status and summary.\n"

# Check if session files exist in cwd
if [ -d "$CWD" ]; then
  FILES_STATUS=""
  for f in TODO.md WORKLOG.md LESSONS.md; do
    if [ -f "$CWD/$f" ]; then
      FILES_STATUS+="  - $f: exists\n"
    else
      FILES_STATUS+="  - $f: not found\n"
    fi
  done
  CONTEXT+="\nSession files in $CWD:\n$FILES_STATUS"
fi

jq -n --arg ctx "$(echo -e "$CONTEXT")" '{"additionalContext": $ctx}'
