#!/usr/bin/env bash
# Codex UserPromptSubmit hook: append fast git state to each prompt so the agent
# has branch/dirty/unpushed context without spending a turn on git status.

set -euo pipefail

repo_root=$(git rev-parse --show-toplevel 2>/dev/null || pwd)
cd "$repo_root"

git rev-parse --git-dir >/dev/null 2>&1 || exit 0

branch=$(git branch --show-current 2>/dev/null || printf 'detached')
dirty=$(git status --porcelain 2>/dev/null | wc -l | tr -d ' ')

if git rev-parse '@{upstream}' >/dev/null 2>&1; then
  unpushed=$(git rev-list --count '@{upstream}..HEAD' 2>/dev/null || printf '0')
else
  unpushed='no-upstream'
fi

printf '<git-context branch="%s" dirty="%s" unpushed="%s" />\n' \
  "$branch" "$dirty" "$unpushed"
