#!/usr/bin/env bash
# End-to-end test for the runtime/sfn/concurrency/scheduler.sfn skeleton.
#
# Companion to test_runtime_pthread_skeleton.sh. The scheduler
# skeleton pins the struct byte layouts for the v0 fixed thread pool
# (see `docs/runtime_architecture.md` §2.6.1 "Fixed Thread Pool, Not
# Work-Stealing") — `Scheduler`, `Task`, `TaskQueue`, and the opaque
# `PthreadMutex`/`PthreadCond` byte-storage types. The module is
# imported nowhere yet (queue ops and the worker pool land in
# follow-up M4 issues), so `make compile`/`make test` would not
# otherwise typecheck it. This script keeps it from bitrotting until
# it is wired into the runtime build, exactly as the platform
# skeleton tests do for pthread.sfn / libc.sfn.
#
# Acceptance:
#   - `sfn check runtime/sfn/concurrency/scheduler.sfn` exits 0.
#   - `sfn fmt --check runtime/sfn/concurrency/scheduler.sfn` exits 0.
#
# Usage:
#   compiler/tests/e2e/test_runtime_scheduler_skeleton.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_runtime_scheduler_skeleton.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
SKELETON="$REPO_ROOT/runtime/sfn/concurrency/scheduler.sfn"

SCRATCH="$(mktemp -d -t sfn-scheduler-skeleton-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

run_test() {
    local name="$1"
    shift
    if "$@"; then
        echo "[test] PASS: $name"
        PASS=$((PASS + 1))
    else
        echo "[test] FAIL: $name"
        FAIL=$((FAIL + 1))
    fi
}

# ---- Test: sfn check passes cleanly ----
test_check_clean() {
    local log="$SCRATCH/check.log"
    if ! "$BINARY" check "$SKELETON" > "$log" 2>&1; then
        echo "[test]   sfn check exited non-zero on scheduler.sfn:"
        cat "$log"
        return 1
    fi
    if ! grep -q "checked .* ok" "$log"; then
        echo "[test]   sfn check did not report 'ok':"
        cat "$log"
        return 1
    fi
    return 0
}

# ---- Test: sfn fmt --check is clean ----
test_fmt_clean() {
    if ! "$BINARY" fmt --check "$SKELETON" > /dev/null 2>&1; then
        echo "[test]   $SKELETON needs formatting (run: sfn fmt --write $SKELETON)"
        return 1
    fi
    return 0
}

run_test "sfn check runtime/sfn/concurrency/scheduler.sfn passes" test_check_clean
run_test "sfn fmt --check runtime/sfn/concurrency/scheduler.sfn is canonical" test_fmt_clean

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
