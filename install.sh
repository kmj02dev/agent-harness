#!/bin/bash
set -e

HARNESS_DIR="$(cd "$(dirname "$0")" && pwd)"

# Global symlinks
ln -sf "$HARNESS_DIR/CLAUDE.md" ~/CLAUDE.md
ln -sf "$HARNESS_DIR/LESSONS.md" ~/LESSONS.md
ln -sf "$HARNESS_DIR/agent_docs" ~/agent_docs
ln -sf "$HARNESS_DIR/domains" ~/domains
ln -sf "$HARNESS_DIR/run-agent.sh" ~/run-agent.sh
ln -sf "$HARNESS_DIR/run-agent.py" ~/run-agent.py
echo "Global harness symlinks installed."

# Project init (optional: pass project path as argument)
if [ -n "$1" ]; then
  PROJECT_DIR="$1"
  mkdir -p "$PROJECT_DIR"
  for tmpl in "$HARNESS_DIR"/templates/*.template; do
    target="$PROJECT_DIR/$(basename "${tmpl%.template}")"
    [ -f "$target" ] || cp "$tmpl" "$target"
  done
  echo "Session files initialized in $PROJECT_DIR"
fi
