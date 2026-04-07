#!/bin/bash
# Autonomous Agent Launcher
# Claude Code + Context Engineering 기반 자율 에이전트 실행
#
# Usage:
#   ./run-agent.sh "Create a Python web scraper for news headlines"
#   ./run-agent.sh --resume

set -euo pipefail

GOAL="${1:-}"
MAX_TURNS="${MAX_TURNS:-200}"

if [[ "$GOAL" == "--resume" ]]; then
    GOAL="Read TODO.md and WORKLOG.md to understand current state. Continue working on the next pending task. Update TODO.md and WORKLOG.md as you make progress."
elif [[ -z "$GOAL" ]]; then
    echo "Usage: ./run-agent.sh <goal>"
    echo "       ./run-agent.sh --resume"
    echo ""
    echo "Environment: MAX_TURNS=200 (default)"
    exit 1
fi

PROMPT="$(cat <<EOF
## Goal
${GOAL}

## Execution Protocol
1. Read TODO.md, LESSONS.md (global → project), WORKLOG.md to understand current state.
2. Determine the activity mode from the goal and read the corresponding agent_docs/CLAUDE.<mode>.md (e.g., survey, development, research, planning). Follow its rules strictly.
3. Break the goal into subtasks and update TODO.md.
4. Execute each subtask. After each, reflect: what worked, what didn't?
5. Record lessons in LESSONS.md. Record decisions inline in WORKLOG.md (→ 결정: marker).
6. Update TODO.md as tasks complete.
7. Commit at every meaningful milestone (git add → git commit). Do not defer all commits to the end.
8. Continue until the goal is fully achieved — do not stop to ask.
9. When done, update WORKLOG.md with final status and summary, then commit.
EOF
)"

echo "=== Autonomous Agent Starting ==="
echo "Goal: ${GOAL}"
echo "Max turns: ${MAX_TURNS}"
echo "================================="

claude --verbose \
    --allowedTools "Read,Write,Edit,Bash,Glob,Grep,WebSearch,WebFetch,Agent" \
    --max-turns "${MAX_TURNS}" \
    -p "${PROMPT}"
