#!/usr/bin/env bash
# Full compiler validation runner. Invoked by the `check` skill.
#
# Steps:
#   1. `make clean-build` — fresh build state
#   2. `make check` — builds from seed, runs suite, builds seedcheck, reruns
#      suite, validates hello-world via seedcheck
#
# Writes a timestamped log to build/logs/check-<ts>.log and prints the tail
# plus the log path so callers can cite it.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

mkdir -p build/logs
ts=$(date -u +%Y%m%dT%H%M%SZ)
log="build/logs/check-${ts}.log"

echo "==> make clean-build" | tee "$log"
if ! ( ulimit -v 8388608 && make clean-build ) >>"$log" 2>&1; then
  status=$?
  echo "clean-build failed (exit $status). Tail of $log:"
  tail -n 80 "$log"
  echo
  echo "Full log: $log"
  exit $status
fi

echo "==> make check" | tee -a "$log"
if ! ( ulimit -v 8388608 && make check ) >>"$log" 2>&1; then
  status=$?
  echo "check failed (exit $status). Tail of $log:"
  tail -n 80 "$log"
  echo
  echo "Full log: $log"
  exit $status
fi

echo "OK — full validation passed. Log at $log"
