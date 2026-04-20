#!/usr/bin/env bash
# UserPromptSubmit hook: inject a one-line git snapshot on every prompt so
# the model always knows branch/dirty/unpushed state without running `git
# status` itself. Stdout is appended to the user's prompt as context.
#
# Keep this fast — it runs on every turn.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

git rev-parse --git-dir >/dev/null 2>&1 || exit 0

branch=$(git branch --show-current 2>/dev/null || echo "detached")
dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

if git rev-parse "@{upstream}" >/dev/null 2>&1; then
  unpushed=$(git rev-list --count "@{upstream}..HEAD" 2>/dev/null || echo 0)
else
  unpushed="no-upstream"
fi

printf '<git-context branch="%s" dirty="%s" unpushed="%s" />\n' \
  "$branch" "$dirty" "$unpushed"
