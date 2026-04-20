#!/usr/bin/env bash
# PreToolUse Bash guard: enforce the 8GB memory cap rule from
# .claude/rules/compiler-safety.md. Blocks compiler invocations that
# forgot to set `ulimit -v 8388608`.
#
# Input: JSON on stdin describing the pending tool call.
# Exit 0  -> allow.
# Exit 2  -> block; stderr is surfaced back to Claude as feedback.

set -euo pipefail

input=$(cat)

tool=$(printf '%s' "$input" | jq -r '.tool_name // empty')
[[ "$tool" == "Bash" ]] || exit 0

cmd=$(printf '%s' "$input" | jq -r '.tool_input.command // empty')
[[ -n "$cmd" ]] || exit 0

# Already capped -> allow.
case "$cmd" in
  *"ulimit -v"*) exit 0 ;;
esac

needs_cap=0

# Heavy `make` targets that shell out to the self-hosting compiler.
if [[ "$cmd" =~ (^|[^[:alnum:]_])make[[:space:]]+(compile|rebuild|check|test|test-unit|test-integration|test-e2e|bench)([[:space:]]|$) ]]; then
  needs_cap=1
fi

# Direct compiler invocations.
case "$cmd" in
  *"build/native/sailfin"*|*"build/native/sailfin-seedcheck"*)
    needs_cap=1
    ;;
esac

if [[ "$needs_cap" -eq 1 ]]; then
  cat >&2 <<'MSG'
Sailfin compiler invocations require an 8GB memory cap (see .claude/rules/compiler-safety.md).
Prepend `ulimit -v 8388608 && ` to the command and try again.
MSG
  exit 2
fi

exit 0
