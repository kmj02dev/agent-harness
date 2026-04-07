"""Autonomous Agent Launcher — Claude Code CLI wrapper.

Usage:
    python run-agent.py "Create a Python web scraper"
    python run-agent.py --resume
"""

import argparse
import subprocess
import sys


EXECUTION_PROTOCOL = """\
## Execution Protocol
1. Read TODO.md, LESSONS.md (global → project), WORKLOG.md to understand current state.
2. Break the goal into subtasks and update TODO.md.
3. Execute each subtask. After each, reflect: what worked, what didn't?
4. Record lessons in LESSONS.md. Record decisions inline in WORKLOG.md (→ 결정: marker).
5. Update TODO.md as tasks complete.
6. Commit at every meaningful milestone (git add → git commit). Do not defer all commits to the end.
7. Continue until the goal is fully achieved — do not stop to ask.
8. When done, update WORKLOG.md with final status and summary, then commit."""

MAX_TURNS = 200


def run_agent(goal: str) -> int:
    prompt = f"## Goal\n{goal}\n\n{EXECUTION_PROTOCOL}"

    print("=== Autonomous Agent Starting ===")
    print(f"Goal: {goal}")
    print(f"Max turns: {MAX_TURNS}")
    print("=================================\n")

    cmd = [
        "claude", "--verbose",
        "--allowedTools", "Read,Write,Edit,Bash,Glob,Grep,WebSearch,WebFetch,Agent",
        "--max-turns", str(MAX_TURNS),
        "-p", prompt,
    ]

    result = subprocess.run(cmd)
    return result.returncode


def main() -> None:
    parser = argparse.ArgumentParser(description="Autonomous Agent")
    parser.add_argument("goal", nargs="*", help="Goal for the agent")
    parser.add_argument("--resume", action="store_true",
                        help="Resume from TODO.md pending tasks")
    parser.add_argument("--max-turns", type=int, default=MAX_TURNS,
                        help="Max turns (default: 200)")
    args = parser.parse_args()

    global MAX_TURNS
    MAX_TURNS = args.max_turns

    if args.resume:
        goal = "Read TODO.md and WORKLOG.md to understand current state. Continue working on the next pending task. Update TODO.md and WORKLOG.md as you make progress."
    elif args.goal:
        goal = " ".join(args.goal)
    else:
        print("Usage: python run-agent.py <goal>")
        print("       python run-agent.py --resume")
        sys.exit(1)

    sys.exit(run_agent(goal))


if __name__ == "__main__":
    main()
