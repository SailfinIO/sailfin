#!/usr/bin/env bash
# Pin the self-applied compiler memory budget contract
# (`runtime/sfn/platform/rlimit.sfn`, called from `fn main` in
# `compiler/src/cli_main.sfn`).
#
# The compiler driver self-applies an 8 GiB RLIMIT_AS on Linux at
# startup, replacing the repo's historical caller-side
# `ulimit -v 8388608` prefix ritual (and the PreToolUse hook that
# enforced it). Contracts pinned here, all observed via the
# `SAILFIN_TRACE_MEM_LIMIT=1` stderr trace (deterministic token,
# no RSS measurement):
#
#   1. Inherited cap wins: under an external `ulimit -v`, the driver
#      leaves the limit alone ("inherited RLIMIT_AS cap left in
#      place").
#   2. Explicit override: `SAILFIN_MEM_LIMIT=<bytes>` applies even
#      when an external cap exists ("RLIMIT_AS set from
#      SAILFIN_MEM_LIMIT").
#   3. Disable: `SAILFIN_MEM_LIMIT=unlimited` skips the self-cap
#      ("self-cap disabled").
#   4. Invalid values (< 1 MiB or suffixed like "4G", which strtoll
#      truncates) are rejected with a trace and the run proceeds on
#      the default — never an 8-byte budget that kills the process.
#   5. Default-apply: in an uncapped shell, the 8 GiB default lands
#      ("set to the 8 GiB default"). Only runs when the harness
#      shell itself is uncapped (CI legs that set a step-level
#      `ulimit -v` exercise contract 1 instead).
#
# Non-Linux: RLIMIT_AS is not honored (Darwin) — the driver no-ops
# via its /proc probe, so this test skips entirely.

set -euo pipefail

BINARY="${1:?usage: test_mem_limit_selfcap.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

if [ ! -f /proc/self/status ]; then
    echo "[test] SKIP: non-Linux platform — RLIMIT_AS self-cap is a no-op here"
    exit 0
fi

run_case() {
    local name="$1" expect_token="$2" shell_cmd="$3"
    local err_out
    err_out="$(bash -c "$shell_cmd" 2>&1 >/dev/null || true)"
    if printf '%s' "$err_out" | grep -qF "$expect_token"; then
        echo "[test] PASS: $name"
        PASS=$((PASS + 1))
    else
        echo "[test] FAIL: $name"
        echo "[test]   expected stderr token: $expect_token"
        echo "[test]   got: $err_out"
        FAIL=$((FAIL + 1))
    fi
}

# 1. Inherited external cap wins (4 GiB ulimit in a subshell).
run_case "inherited external cap left in place" \
    "[mem-limit] inherited RLIMIT_AS cap left in place" \
    "ulimit -v 4194304; SAILFIN_TRACE_MEM_LIMIT=1 SAILFIN_MEM_LIMIT= '$BINARY' version"

# 2. Explicit override applies under an external cap (1 GiB, below
#    the 4 GiB hard cap so setrlimit cannot fail on the raise path).
run_case "explicit SAILFIN_MEM_LIMIT override" \
    "[mem-limit] RLIMIT_AS set from SAILFIN_MEM_LIMIT" \
    "ulimit -v 4194304; SAILFIN_TRACE_MEM_LIMIT=1 SAILFIN_MEM_LIMIT=1073741824 '$BINARY' version"

# 3. unlimited disables the self-cap.
run_case "SAILFIN_MEM_LIMIT=unlimited disables" \
    "[mem-limit] self-cap disabled via SAILFIN_MEM_LIMIT" \
    "SAILFIN_TRACE_MEM_LIMIT=1 SAILFIN_MEM_LIMIT=unlimited '$BINARY' version"

# 4. Suffixed/too-small values are rejected, run proceeds on default.
run_case "suffixed value rejected (strtoll truncation guard)" \
    "[mem-limit] invalid SAILFIN_MEM_LIMIT" \
    "ulimit -v 4194304; SAILFIN_TRACE_MEM_LIMIT=1 SAILFIN_MEM_LIMIT=4G '$BINARY' version"

# Invalid value must not abort the invocation itself.
if SAILFIN_MEM_LIMIT=4G "$BINARY" version >/dev/null 2>&1; then
    echo "[test] PASS: invalid SAILFIN_MEM_LIMIT does not block the run"
    PASS=$((PASS + 1))
else
    echo "[test] FAIL: invalid SAILFIN_MEM_LIMIT blocked the run"
    FAIL=$((FAIL + 1))
fi

# 5. Default-apply — only observable when this harness shell is
#    itself uncapped (otherwise contract 1 governs, already pinned).
vmem_cap="$(ulimit -v 2>/dev/null || echo unlimited)"
if [ "$vmem_cap" = "unlimited" ]; then
    run_case "8 GiB default applies in an uncapped shell" \
        "[mem-limit] RLIMIT_AS set to the 8 GiB default" \
        "SAILFIN_TRACE_MEM_LIMIT=1 SAILFIN_MEM_LIMIT= '$BINARY' version"
else
    echo "[test] SKIP: harness shell carries ulimit -v $vmem_cap — default-apply leg covered by the inherited-cap case"
fi

echo "[test] mem-limit selfcap: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
