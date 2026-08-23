#!/usr/bin/env bash
# Full compiler validation runner. Invoked by the `check` skill.
#
# Steps:
#   1. `sfn dev clean build` — fresh build state
#   2. `sfn dev verify` — builds from seed, runs the first-pass smoke gate,
#      validates self-hosting, and runs the full suite with seedcheck
#
# Writes a timestamped log to build/logs/check-<ts>.log and prints the tail
# plus the log path so callers can cite it.

set -euo pipefail

cd "${CLAUDE_PROJECT_DIR:-$(pwd)}"

ts=$(date -u +%Y%m%dT%H%M%SZ)
log="build/logs/check-${ts}.log"
clean_log=$(mktemp)
trap 'rm -f "$clean_log"' EXIT

echo "==> sfn dev clean build" | tee "$clean_log"
if sfn dev clean build >>"$clean_log" 2>&1; then
  :
else
  status=$?
  echo "clean build failed (exit $status). Tail:"
  tail -n 80 "$clean_log"
  echo
  exit $status
fi

# Cleaning may remove build/bin/sfn and build/logs. Re-resolve `sfn` so the
# pinned seed or another installed toolchain can run the full gate, then create
# the durable log after the clean completes.
hash -r
mkdir -p build/logs
cp "$clean_log" "$log"

echo "==> sfn dev verify" | tee -a "$log"
if sfn dev verify >>"$log" 2>&1; then
  :
else
  status=$?
  echo "verify failed (exit $status). Tail of $log:"
  tail -n 80 "$log"
  echo
  echo "Full log: $log"
  exit $status
fi

echo "OK — full validation passed. Log at $log"
