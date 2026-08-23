#!/usr/bin/env bash
# Reproduce a self-hosting build failure and capture the last 80 lines.
# Saves the full log to build/debug/compile-<ts>.log for later inspection.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

mkdir -p build/debug
ts=$(date -u +%Y%m%dT%H%M%SZ)
log="build/debug/compile-${ts}.log"

if sfn dev bootstrap build >"$log" 2>&1; then
  echo "sfn dev bootstrap build succeeded — nothing to debug. Log at $log"
  exit 0
else
  status=$?
fi

echo "sfn dev bootstrap build FAILED (exit $status). Tail of $log:"
echo "----"
tail -n 80 "$log"
echo "----"
echo "Full log: $log"
exit $status
