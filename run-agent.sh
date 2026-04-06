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
    GOAL="Read TODO.md and continue working on the next pending task. Update TODO.md as you make progress."
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
1. Read TODO.md, LESSONS.md, DECISIONS.md to understand current state.
2. Break the goal into subtasks and update TODO.md.
3. Execute each subtask. After each, reflect: what worked, what didn't?
4. Record lessons in LESSONS.md. Record decisions in DECISIONS.md.
5. Update TODO.md as tasks complete.
6. Continue until the goal is fully achieved — do not stop to ask.
7. When done, update WORKLOG.md with a summary.
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
