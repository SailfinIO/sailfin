#!/usr/bin/env bash
# Reproduce a self-hosting build failure and capture the last 80 lines.
# Saves the full log to build/debug/compile-<ts>.log for later inspection.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

mkdir -p build/debug
ts=$(date -u +%Y%m%dT%H%M%SZ)
log="build/debug/compile-${ts}.log"

if ( ulimit -v 8388608 && make compile ) >"$log" 2>&1; then
  echo "make compile succeeded — nothing to debug. Log at $log"
  exit 0
fi

status=$?
echo "make compile FAILED (exit $status). Tail of $log:"
echo "----"
tail -n 80 "$log"
echo "----"
echo "Full log: $log"
exit $status
