#!/usr/bin/env bash
# UserPromptSubmit hook: inject a one-line git snapshot on every prompt so
# the model always knows branch/dirty/unpushed state without running `git
# status` itself. Stdout is appended to the user's prompt as context.
#
# Keep this fast — it runs on every turn.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

git rev-parse --git-dir >/dev/null 2>&1 || exit 0

# One checkout's branch/dirty/unpushed, as attributes. $1 is the directory.
_snapshot() {
  local dir="$1" branch dirty unpushed
  branch=$(git -C "$dir" branch --show-current 2>/dev/null || echo "detached")
  dirty=$(git -C "$dir" status --porcelain 2>/dev/null | wc -l | tr -d ' ')
  if git -C "$dir" rev-parse "@{upstream}" >/dev/null 2>&1; then
    unpushed=$(git -C "$dir" rev-list --count "@{upstream}..HEAD" 2>/dev/null || echo 0)
  else
    unpushed="no-upstream"
  fi
  printf 'branch="%s" dirty="%s" unpushed="%s"' "$branch" "$dirty" "$unpushed"
}

printf '<git-context %s />\n' "$(_snapshot .)"

# `/pickup` works in a worktree under .claude/worktrees/, so the primary
# checkout above reports a clean, idle `main` while the actual work sits
# elsewhere -- the exact opposite of this hook's purpose. Report each linked
# worktree too. `git worktree list --porcelain` emits a `worktree <path>` line
# per entry, the first of which is the primary; skip it.
git worktree list --porcelain 2>/dev/null \
  | awk '/^worktree /{ $1=""; sub(/^ /,""); print }' \
  | tail -n +2 \
  | while read -r wt; do
      [ -d "$wt" ] || continue
      printf '<git-context-worktree path="%s" %s />\n' \
        "${wt#"$PWD"/}" "$(_snapshot "$wt")"
    done
