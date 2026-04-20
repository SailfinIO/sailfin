#!/usr/bin/env bash
# PreToolUse Bash guard: enforce the 8GB memory cap rule from
# .claude/rules/compiler-safety.md. Blocks compiler invocations that
# forgot to set `ulimit -v 8388608`.
#
# Input: JSON on stdin describing the pending tool call.
# Exit 0  -> allow.
# Exit 2  -> block; stderr is surfaced back to Claude as feedback.

set -euo pipefail

# Fail open if jq isn't available: a missing dependency must not block every
# Bash tool call. Surface a one-time breadcrumb on stderr so the user can
# install jq and restore the safety guard.
if ! command -v jq >/dev/null 2>&1; then
  echo "[check-ulimit] jq not found — compiler-safety guard disabled. Install jq to re-enable." >&2
  exit 0
fi

input=$(cat)

tool=$(printf '%s' "$input" | jq -r '.tool_name // empty')
[[ "$tool" == "Bash" ]] || exit 0

cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
[[ -n "$cmd" ]] || exit 0

# Already capped -> allow.
case "$cmd" in
  *"ulimit -v"*) exit 0 ;;
esac

# Only match at command boundaries — start of string or after a shell
# operator (`;`, `&&`, `||`, `|`, `(`, `)`). Without this, the guard
# false-positives on prose inside quoted args (e.g. `git commit -m "…
# blocks make test …"`), which previously made it impossible to commit
# without tripping the hook.
needs_cap=0

make_re='(^|[;&|()`])[[:space:]]*make[[:space:]]+(compile|rebuild|check|test|test-unit|test-integration|test-e2e|bench)([[:space:]]|$|[;&|])'
if [[ "$cmd" =~ $make_re ]]; then
  needs_cap=1
fi

# Direct compiler invocations. Require the binary to appear at a
# command-boundary position (optionally preceded by a relative-path
# prefix like `./`).
sfn_re='(^|[;&|()`])[[:space:]]*(\./)?build/native/sailfin(-seedcheck)?([[:space:]]|$)'
if [[ "$cmd" =~ $sfn_re ]]; then
  needs_cap=1
fi

if [[ "$needs_cap" -eq 1 ]]; then
  cat >&2 <<'MSG'
Sailfin compiler invocations require an 8GB memory cap (see .claude/rules/compiler-safety.md).
Prepend `ulimit -v 8388608 && ` to the command and try again.
MSG
  exit 2
fi

exit 0
