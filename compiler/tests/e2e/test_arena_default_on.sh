#!/usr/bin/env bash
# Issue #324: pin the arena allocator default-on contract for installed
# binaries.
#
# Until this issue, only selfhost builds (`make compile`/`make check`/
# `make test`) got the arena via `scripts/build.sh`'s
# `SAILFIN_USE_ARENA=${SAILFIN_USE_ARENA:-1}` export. End-user
# installations (e.g. `sfn check` after `make install`) ran on the
# malloc path unless the user manually opted in.
#
# The flip in `runtime/native/src/sailfin_arena.c::_init_arena_enabled`
# makes the arena on by default. This test pins three contracts:
#
#   1. Default-on: `unset SAILFIN_USE_ARENA` runs under the arena.
#   2. Explicit opt-in: `SAILFIN_USE_ARENA=1` continues to enable
#      (no behavioural delta from unset, but explicit confirmation
#      should not regress).
#   3. Opt-out matrix: `SAILFIN_USE_ARENA=0`, `=`, and `=false` each
#      disable the arena, mirroring the standard `_env_flag` contract
#      in `compiler/src/cli_commands_utils.sfn::_env_flag`.
#
# The probe is `SAILFIN_DUMP_ARENA_STATS=1`, which causes the
# `native_driver.c` atexit hook to print either:
#   "[sailfin-arena] label=... pages=... capacity=..."  (arena on)
# or:
#   "[sailfin-arena] label=... stats=disabled (SAILFIN_USE_ARENA=\"<v>\" opt-out)"
# (arena off; `<v>` echoes the explicit opt-out value — `0`, `""`,
# or `false` — since unset now means "take the default" and never
# reaches this branch). Grepping for either token is a deterministic
# signal without relying on RSS measurements or process-internal state.

set -euo pipefail

BINARY="${1:?usage: test_arena_default_on.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
EXAMPLE="$REPO_ROOT/examples/basics/hello-world.sfn"
if [ ! -f "$EXAMPLE" ]; then
    echo "[test] FATAL: missing fixture $EXAMPLE"
    exit 2
fi

SCRATCH="$(mktemp -d -t sfn-arena-default-XXXXXX)"
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

# Run the compiler on the hello-world fixture with arena-stats
# emission enabled, plus whatever SAILFIN_USE_ARENA prefix the
# caller specifies. Returns the stderr log path on $1.
exercise_run() {
    local stderr_log="$1"
    shift
    # `sfn run` compiles + links + executes. The resulting child
    # process inherits the arena-enable env, so the atexit hook
    # observes the same state as the compiler itself. We redirect
    # the program's stdout to /dev/null because hello-world prints
    # to stdout; the arena-stats line goes to stderr.
    "$@" "$BINARY" run "$EXAMPLE" \
        > /dev/null 2> "$stderr_log"
}

# Default-on: with SAILFIN_USE_ARENA unset, the dump should report
# `pages=`, never `stats=disabled`.
test_unset_defaults_to_arena_on() {
    local log="$SCRATCH/unset.log"
    if ! exercise_run "$log" env -u SAILFIN_USE_ARENA SAILFIN_DUMP_ARENA_STATS=1; then
        echo "[test]   exercise failed under unset SAILFIN_USE_ARENA:"
        cat "$log"
        return 1
    fi
    if grep -q 'stats=disabled' "$log"; then
        echo "[test]   arena was OFF when unset (expected default-on):"
        head -20 "$log"
        return 1
    fi
    if ! grep -q '\[sailfin-arena\] label=.* pages=' "$log"; then
        echo "[test]   missing 'pages=' telemetry under unset SAILFIN_USE_ARENA:"
        head -20 "$log"
        return 1
    fi
    return 0
}

# Explicit opt-in: SAILFIN_USE_ARENA=1 must continue to enable the
# arena. Identical to the unset case in behaviour, but exercising
# the explicit branch guards against a regression that distinguished
# unset from set.
test_explicit_one_enables() {
    local log="$SCRATCH/one.log"
    if ! exercise_run "$log" env SAILFIN_USE_ARENA=1 SAILFIN_DUMP_ARENA_STATS=1; then
        echo "[test]   exercise failed under SAILFIN_USE_ARENA=1:"
        cat "$log"
        return 1
    fi
    if grep -q 'stats=disabled' "$log"; then
        echo "[test]   arena was OFF when SAILFIN_USE_ARENA=1 (regression):"
        head -20 "$log"
        return 1
    fi
    if ! grep -q '\[sailfin-arena\] label=.* pages=' "$log"; then
        echo "[test]   missing 'pages=' telemetry under SAILFIN_USE_ARENA=1:"
        head -20 "$log"
        return 1
    fi
    return 0
}

# Opt-out matrix: 0, "" (empty), and "false" must each disable
# the arena. This is the regression-bisect escape hatch the issue
# explicitly preserves.
test_optout_matrix_disables() {
    local rc=0
    for case in "zero" "empty" "false"; do
        local log="$SCRATCH/off_${case}.log"
        local prefix
        case "$case" in
            zero)  prefix="env SAILFIN_USE_ARENA=0 SAILFIN_DUMP_ARENA_STATS=1" ;;
            empty) prefix="env SAILFIN_USE_ARENA= SAILFIN_DUMP_ARENA_STATS=1" ;;
            false) prefix="env SAILFIN_USE_ARENA=false SAILFIN_DUMP_ARENA_STATS=1" ;;
        esac
        if ! exercise_run "$log" $prefix; then
            echo "[test]   exercise failed in '$case' opt-out case:"
            cat "$log"
            rc=1
            continue
        fi
        if ! grep -q 'stats=disabled' "$log"; then
            echo "[test]   arena was ON in '$case' opt-out case (expected off):"
            head -20 "$log"
            rc=1
        fi
    done
    return $rc
}

run_test "SAILFIN_USE_ARENA unset → arena on (default)" \
    test_unset_defaults_to_arena_on
run_test "SAILFIN_USE_ARENA=1 → arena on (explicit)" \
    test_explicit_one_enables
run_test "SAILFIN_USE_ARENA={0,'',false} → arena off (opt-out)" \
    test_optout_matrix_disables

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
