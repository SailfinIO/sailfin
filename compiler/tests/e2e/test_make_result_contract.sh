#!/usr/bin/env bash
# End-to-end smoke test for the make verdict-block contract (#1060,
# epic #1056 Phase 1). Locks the keystone shipped by #1059
# (scripts/agent_report.sh + Makefile wiring): every agent-facing make
# target ends — on success AND failure — with a single greppable
#
#   ===SAILFIN-RESULT===
#   {"schema_version":"sailfin-make/1","target":...,"status":...,...}
#   ===END-SAILFIN-RESULT===
#
# block as its final output, so an agent can classify the outcome from a
# tail-truncated log. Schema: docs/reference/make-result-schema.md.
#
# This is the Phase-1 *contract* smoke test: it proves the sentinel is
# emitted as the final block, the enclosed line parses as JSON, and
# `status` is `pass` on a passing target and `fail` (with a non-null
# `failure`) on a forced failure. The full field-level schema-lock
# (every `sailfin-make/1` field + the warn/nondeterminism path) is
# Phase 3's `test_make_result_schema.sh` and is deliberately out of
# scope here.
#
# Cases (chosen to be cheap, deterministic, and network-free):
#   - pass:  `make compile` — in every context this test runs (the e2e
#            suite executes *after* the compiler is built from the same
#            sources), compile is up-to-date and returns in ~0.04s with
#            status "pass". (A pathological stale tree would rebuild;
#            that only happens when the suite is run on un-rebuilt
#            sources, which is already a broken workflow.)
#   - fail:  `make check-fast NATIVE_BIN=/nonexistent` — the guard
#            prints "run: make compile" before any work, a deterministic
#            failure agent_report classifies as setup-error.
#
# Usage:
#   compiler/tests/e2e/test_make_result_contract.sh <compiler-binary>

set -uo pipefail

BINARY="${1:?usage: test_make_result_contract.sh <compiler-binary>}"
# Enforce the argument contract before any work. `set -e` is
# intentionally off (failures are classified explicitly below), so a
# bad/missing path must be rejected here rather than silently degrading
# into a false-green — and the check must precede `realpath`, whose
# failure on a missing path would otherwise leave BINARY empty.
if [ ! -x "$BINARY" ]; then
    echo "test_make_result_contract.sh: '$BINARY' is not an executable compiler binary" >&2
    exit 2
fi
BINARY="$(realpath "$BINARY")"
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
cd "$REPO_ROOT"

PASS=0
FAIL=0
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

SCRATCH="$(mktemp -d -t sfn-make-result-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

# `timeout` is GNU coreutils (linux-x86_64 CI); absent on macos-arm64.
# Use it when available so a wedged target can't hang the suite. The
# up-to-date `make compile` returns in well under a second and the
# fail case aborts at the guard; 300s is generous headroom that still
# trips loudly if a pathological stale tree forces a full rebuild.
TIMEOUT_PREFIX=""
if command -v timeout >/dev/null 2>&1; then TIMEOUT_PREFIX="timeout 300"; fi

# Run a make target with the verdict wrapper active. The e2e `.sh`
# harness runs under `make test-e2e`, whose agent_report wrapper exports
# SAILFIN_INNER=1 — which would make the nested target run transparently
# and emit NO sentinel. Clearing it here restores the outer-target
# behavior so the target we invoke prints its own verdict block.
# Combined stdout+stderr is captured to the logfile ($1; make prints its
# own `make: *** … Error N` trailer to stderr on failure).
run_make() {
    local logfile="$1"
    shift
    # `--no-print-directory`: when this test runs under the e2e harness
    # (itself a recursive make), an invoked sub-make would otherwise
    # print `make[N]: Leaving directory …` AFTER its recipe — i.e. after
    # the verdict block — which is make's own framing noise, not the
    # wrapped target's output. Suppressing it keeps the captured log
    # clean; assert_final_block tolerates any residual make framing too.
    (
      env -u SAILFIN_INNER ${TIMEOUT_PREFIX} make --no-print-directory "$@" ) \
        > "$logfile" 2>&1
    return 0
}

# Line number of the last `===SAILFIN-RESULT===` / END marker (or "").
_last_marker_line() { grep -n -- "$2" "$1" | tail -n1 | cut -d: -f1; }

# Extract the JSON line of the final verdict block (the single line
# after the last `===SAILFIN-RESULT===`).
verdict_json() {
    local logfile="$1" start
    start="$(_last_marker_line "$logfile" '===SAILFIN-RESULT===')"
    [ -n "$start" ] || return 1
    sed -n "$((start + 1))p" "$logfile"
}

# True iff the verdict block is the FINAL block: a START/END pair exists
# and nothing but blank lines or make's own framing lines
# (`make[N]: Leaving directory …`, `make: *** … Error N`) follows the
# last END marker. This mirrors #1059's `tail | grep` contract while
# tolerating make's own trailing framing — emitted by make itself, not
# by the wrapped target — when the wrapper exits (non-zero, or as a
# recursive sub-make).
assert_final_block() {
    local logfile="$1" start end after
    start="$(_last_marker_line "$logfile" '===SAILFIN-RESULT===')"
    end="$(_last_marker_line "$logfile" '===END-SAILFIN-RESULT===')"
    if [ -z "$start" ] || [ -z "$end" ]; then
        echo "  no ===SAILFIN-RESULT=== … ===END-SAILFIN-RESULT=== block found" >&2
        tail -5 "$logfile" >&2
        return 1
    fi
    if [ "$end" -le "$start" ]; then
        echo "  END marker (line $end) does not follow START (line $start)" >&2
        return 1
    fi
    after="$(tail -n +"$((end + 1))" "$logfile" \
             | sed '/^[[:space:]]*$/d' \
             | grep -vE '^make(\[[0-9]+\])?: ' || true)"
    if [ -n "$after" ]; then
        echo "  unexpected output after the verdict block:" >&2
        echo "$after" >&2
        return 1
    fi
    return 0
}

# Read a flat-JSON string field without a hard jq dependency. Prefers jq
# when present (also validates the line parses); falls back to a sed
# extraction of "<field>":"<value>" / "<field>":null.
json_field() {
    local json="$1" field="$2"
    if command -v jq >/dev/null 2>&1; then
        printf '%s' "$json" | jq -r ".${field} // \"null\"" 2>/dev/null
        return
    fi
    if printf '%s' "$json" | grep -q "\"${field}\":null"; then
        printf 'null'
        return
    fi
    printf '%s' "$json" | sed -nE "s/.*\"${field}\":\"([^\"]*)\".*/\1/p"
}

# Assert the verdict line parses as JSON (jq only; a no-op skip when jq
# is unavailable so the test still runs its grep-based field checks).
assert_parses_json() {
    local json="$1"
    command -v jq >/dev/null 2>&1 || return 0
    if ! printf '%s' "$json" | jq -e . >/dev/null 2>&1; then
        echo "  verdict line is not valid JSON: $json" >&2
        return 1
    fi
    return 0
}

# ---- Case 1: passing target -> status "pass" ----
PASS_LOG="$SCRATCH/pass.log"
run_make "$PASS_LOG" compile

check_pass_case() {
    assert_final_block "$PASS_LOG" || return 1
    local json; json="$(verdict_json "$PASS_LOG")" || { echo "  no verdict JSON" >&2; return 1; }
    assert_parses_json "$json" || return 1
    local schema; schema="$(json_field "$json" schema_version)"
    if [ "$schema" != "sailfin-make/1" ]; then
        echo "  expected schema_version sailfin-make/1, got: $schema" >&2; return 1
    fi
    local target; target="$(json_field "$json" target)"
    if [ "$target" != "compile" ]; then
        echo "  expected target compile, got: $target" >&2; return 1
    fi
    local status; status="$(json_field "$json" status)"
    if [ "$status" != "pass" ]; then
        echo "  expected status pass on a passing target, got: $status" >&2
        tail -5 "$PASS_LOG" >&2; return 1
    fi
    local failure; failure="$(json_field "$json" failure)"
    if [ "$failure" != "null" ]; then
        echo "  expected failure null on pass, got: $failure" >&2; return 1
    fi
    return 0
}
run_test "passing target: verdict is the final block with status=pass" check_pass_case

# ---- Case 2: forced failure -> status "fail" + non-null failure ----
# A bad NATIVE_BIN trips check-fast's guard ("run: make compile") before
# any real work — a deterministic, network-free failure that
# agent_report classifies as setup-error.
FAIL_LOG="$SCRATCH/fail.log"
run_make "$FAIL_LOG" check-fast NATIVE_BIN=/nonexistent/sailfin

check_fail_case() {
    assert_final_block "$FAIL_LOG" || return 1
    local json; json="$(verdict_json "$FAIL_LOG")" || { echo "  no verdict JSON" >&2; return 1; }
    assert_parses_json "$json" || return 1
    local schema; schema="$(json_field "$json" schema_version)"
    if [ "$schema" != "sailfin-make/1" ]; then
        echo "  expected schema_version sailfin-make/1, got: $schema" >&2; return 1
    fi
    local status; status="$(json_field "$json" status)"
    if [ "$status" != "fail" ]; then
        echo "  expected status fail on forced failure, got: $status" >&2
        tail -6 "$FAIL_LOG" >&2; return 1
    fi
    local failure; failure="$(json_field "$json" failure)"
    if [ -z "$failure" ] || [ "$failure" = "null" ]; then
        echo "  expected non-null failure on forced failure, got: $failure" >&2; return 1
    fi
    # Tighten to the expected classification without over-pinning: the
    # bad-binary guard is a setup-error in the closed taxonomy.
    if [ "$failure" != "setup-error" ]; then
        echo "  expected failure=setup-error from the bad-NATIVE_BIN guard, got: $failure" >&2
        tail -6 "$FAIL_LOG" >&2; return 1
    fi
    return 0
}
run_test "forced failure: verdict is the final block with status=fail + failure" check_fail_case

# ---- Case 3: failed cold rebuild -> status "fail" (regression for #1192) ----
# A failed cold self-host rebuild must make `make compile` FAIL (non-zero
# exit + status:"fail"), not silently fall back to the prior
# build/native/sailfin and report status:"pass". The bug: compile-impl
# chained `$(MAKE) rebuild; echo ...` with `;`, so a failed rebuild's
# non-zero exit was masked by the trailing echo's 0 and the if-compound
# returned 0. The fix chains with `&&`.
#
# To exercise the rebuild branch fast/deterministically/network-free, we
# force it (FORCE=1) with a stub "seed" that answers --version (passing
# rebuild-impl's preflight) but fails `build`. No real cold self-host runs.
# FORCE / SEED_NATIVE are read from the shell env by the recipe, so they
# go through `env` rather than as make-command-line variables.
FAKESEED="$SCRATCH/fakeseed"
cat > "$FAKESEED" <<'STUB'
#!/usr/bin/env bash
# Minimal seed stub: viable enough to clear rebuild-impl's `--version`
# preflight but deliberately fails the actual `build` so the cold rebuild
# fails. Every other subcommand (e.g. the platform-module `emit`
# pre-stage) is a harmless no-op.
case "${1:-}" in
  --version) echo "sailfin-fakeseed 0.0.0" ;;
  build)     echo "[fakeseed] build deliberately failing for #1192 regression" >&2; exit 1 ;;
  *)         exit 0 ;;
esac
STUB
chmod +x "$FAKESEED"

BREAK_LOG="$SCRATCH/break.log"
(
  env -u SAILFIN_INNER FORCE=1 SEED_NATIVE="$FAKESEED" \
      ${TIMEOUT_PREFIX} make --no-print-directory compile ) \
    > "$BREAK_LOG" 2>&1 || true

check_failed_rebuild_case() {
    assert_final_block "$BREAK_LOG" || return 1
    local json; json="$(verdict_json "$BREAK_LOG")" || { echo "  no verdict JSON" >&2; return 1; }
    assert_parses_json "$json" || return 1
    local target; target="$(json_field "$json" target)"
    if [ "$target" != "compile" ]; then
        echo "  expected target compile, got: $target" >&2; return 1
    fi
    local status; status="$(json_field "$json" status)"
    if [ "$status" != "fail" ]; then
        echo "  expected status fail when the cold rebuild fails (no stale fallback), got: $status" >&2
        tail -8 "$BREAK_LOG" >&2; return 1
    fi
    local failure; failure="$(json_field "$json" failure)"
    if [ -z "$failure" ] || [ "$failure" = "null" ]; then
        echo "  expected non-null failure on a failed rebuild, got: $failure" >&2; return 1
    fi
    return 0
}
run_test "failed rebuild: make compile reports status=fail (no stale fallback)" check_failed_rebuild_case

echo "[test] make result contract: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
