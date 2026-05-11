#!/usr/bin/env bash
# Codex PreToolUse hook: block make/compiler commands that omit Sailfin's 8GB
# virtual-memory cap. The compiler can otherwise exhaust local WSL/IDE hosts.

set -euo pipefail

# Fail open if python3 isn't available: a missing dependency must not block every
# Bash tool call. Surface a one-time breadcrumb on stderr so the user can
# install python3 and restore the safety guard.
if ! command -v python3 >/dev/null 2>&1; then
  echo "[check-ulimit] python3 not found — compiler-safety guard disabled. Install python3 to re-enable." >&2
  exit 0
fi

payload=$(cat || true)
cmd=$(
  PAYLOAD="$payload" python3 - <<'PY'
import json
import os

payload = os.environ.get("PAYLOAD", "")
try:
    data = json.loads(payload) if payload.strip() else {}
except json.JSONDecodeError:
    data = {}

candidates = []

def collect(value):
    if isinstance(value, str):
        candidates.append(value)
    elif isinstance(value, list):
        candidates.extend(str(part) for part in value)
    elif isinstance(value, dict):
        for key in ("command", "cmd", "script", "input", "args"):
            if key in value:
                collect(value[key])

collect(data)
for key in ("tool_input", "toolInput", "params", "arguments"):
    collect(data.get(key))

print(" ".join(candidates))
PY
)

# If Codex passes no structured payload for this version, do not block unknown
# commands. The guidance still lives in AGENTS.md and the session-start hook.
[[ -z "${cmd// }" ]] && exit 0

needs_cap=0

make_re='(^|[;&|()`])[[:space:]]*make[[:space:]]+(compile|rebuild|check|test|test-unit|test-integration|test-e2e|bench|clean-build)([[:space:]]|$|[;&|])'
if [[ "$cmd" =~ $make_re ]]; then
  needs_cap=1
fi

if [[ "$cmd" =~ (^|[[:space:];&|])((\./)?build/native/sailfin(-seedcheck)?)([[:space:];&|]|$) ]]; then
  needs_cap=1
fi

if [[ "$needs_cap" -eq 1 && ! "$cmd" =~ ulimit[[:space:]]+-v[[:space:]]+8388608 ]]; then
  cat >&2 <<'MSG'
Sailfin compiler invocations require an 8GB memory cap.
Prepend `ulimit -v 8388608 && ` to the command and try again.
MSG
  exit 2
fi

exit 0
