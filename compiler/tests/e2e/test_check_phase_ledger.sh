#!/usr/bin/env bash
# End-to-end test for the seven-phase `make check` ledger (#1124, epic #1056
# Phase 2). Locks the `phases[]` array that scripts/agent_report.sh composes
# into build/agent-report.check.json when `make check` runs under the report
# gate (JSON=1 / SAILFIN_AGENT_REPORT=1).
#
# Rather than run the real ~20-min `make check`, this drives agent_report.sh
# directly with a stub command that echoes the human phase banners check-impl
# prints, then asserts the derived ledger. The composer keys off exactly those
# banners (the same marker set detect_check_phase uses), so a stub that prints
# them exercises the real derivation logic deterministically in milliseconds.
#
# Cases:
#   - green:  all seven banners + fixed-point match, exit 0
#             -> seven phases in order, every status "pass".
#   - fail:   banners through seedcheck-tests then a test-failure, exit 1
#             -> seedcheck-tests "fail", stage3-build + fixed-point "skipped",
#                top-level status "fail" / phase "seedcheck-tests".
#   - warn:   all banners but `stage2 != stage3`, exit 0
#             -> fixed-point "warn", top-level status "warn" /
#                failure "nondeterminism", exit 0.
#
# Schema: docs/reference/make-result-schema.md (`sailfin-make/1`, phases[]).
#
# Usage:
#   compiler/tests/e2e/test_check_phase_ledger.sh [compiler-binary]
# (The compiler binary arg is accepted for harness uniformity but unused —
#  this test exercises the shell composer, not the compiler.)

set -uo pipefail

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
WRAPPER="$REPO_ROOT/scripts/agent_report.sh"
if [ ! -f "$WRAPPER" ]; then
    echo "test_check_phase_ledger.sh: missing $WRAPPER" >&2
    exit 2
fi

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

SCRATCH="$(mktemp -d -t sfn-check-ledger-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

# Read a top-level JSON string/null field without a hard jq dependency.
# Unlike test_make_result_contract.sh's flat-JSON helper, the check report
# nests seven `"status"` keys inside phases[], so the jq-less fallback must
# take the *first* occurrence of the key — a greedy/last match would shadow
# the top-level value with a phase value. The report writes every top-level
# field before phases[], so first-occurrence is the top-level value.
json_field() {
    local json="$1" field="$2" match
    if command -v jq >/dev/null 2>&1; then
        printf '%s' "$json" | jq -r ".${field} // \"null\"" 2>/dev/null
        return
    fi
    match="$(printf '%s' "$json" | grep -oE "\"${field}\":(\"[^\"]*\"|null)" | head -n1)"
    case "$match" in
        *:null) printf 'null' ;;
        *) printf '%s' "$match" | sed -E "s/.*:\"([^\"]*)\"/\1/" ;;
    esac
}

# Run agent_report.sh for `--target check` over a stub that prints $1 (a banner
# script) and exits with $2. Writes the report under $SCRATCH/build and echoes
# the report path. SAILFIN_INNER is cleared so the wrapper claims the verdict
# (this test itself runs under the wrapped test-e2e-sh, which exports it).
run_check_stub() {
    local banners="$1" rc="$2" sub
    sub="$SCRATCH/run.$$"
    rm -rf "$sub"
    mkdir -p "$sub"
    ( cd "$sub"
      env -u SAILFIN_INNER SAILFIN_AGENT_REPORT=1 \
          bash "$WRAPPER" --target check -- \
          bash -c "$banners"$'\n'"exit $rc" >/dev/null 2>&1 || true )
    printf '%s' "$sub/build/agent-report.check.json"
}

# Banner fragments matching check-impl's human output (Makefile check-impl).
B_FPTESTS='echo "[check] running test suite on first-pass binary (early gate)..."'
B_SCBUILD='echo "[check] first-pass tests passed — proceeding to seedcheck build..."'
B_SCSMOKE='echo "[check] validating seedcheck binary can run programs..."'
B_SCTESTS='echo "[check] running test suite with seedcheck binary (no fallbacks)..."'
B_S3BUILD='echo "[check] stage2 tests passed — building stage3 for fixed-point comparison..."'
B_FIXED='echo "[check] comparing stage2 vs stage3 LLVM IR (fixed-point check)..."'

# Assert the report's phases[] names are the canonical seven in order.
assert_seven_names() {
    local report="$1" json names
    [ -f "$report" ] || { echo "  missing report $report" >&2; return 1; }
    json="$(cat "$report")"
    if command -v jq >/dev/null 2>&1; then
        if ! printf '%s' "$json" | jq -e \
            '[.phases[].name] == ["compile","first-pass-tests","seedcheck-build","seedcheck-smoke","seedcheck-tests","stage3-build","fixed-point"]' \
            >/dev/null 2>&1; then
            echo "  phases[] names not the canonical seven in order:" >&2
            printf '%s' "$json" | jq -c '.phases' >&2 2>/dev/null || echo "$json" >&2
            return 1
        fi
        return 0
    fi
    # jq-less fallback: check the names substring in order.
    names='"name":"compile".*"name":"first-pass-tests".*"name":"seedcheck-build".*"name":"seedcheck-smoke".*"name":"seedcheck-tests".*"name":"stage3-build".*"name":"fixed-point"'
    printf '%s' "$json" | grep -Eq "$names" || {
        echo "  phases[] names not the canonical seven in order: $json" >&2
        return 1
    }
}

# Assert phase <name> has status <want> in the report (jq required; skip when
# jq is unavailable — the names check above already runs jq-less).
assert_phase_status() {
    local report="$1" name="$2" want="$3" got
    command -v jq >/dev/null 2>&1 || return 0
    got="$(jq -r --arg n "$name" '.phases[] | select(.name==$n) | .status' "$report" 2>/dev/null)"
    if [ "$got" != "$want" ]; then
        echo "  phase $name: expected status $want, got '$got'" >&2
        jq -c '.phases' "$report" >&2 2>/dev/null
        return 1
    fi
}

# ---- Case 1: green tree -> seven phases, all pass ----
check_green() {
    local report
    report="$(run_check_stub "$B_FPTESTS"$'\n'"$B_SCBUILD"$'\n'"$B_SCSMOKE"$'\n'"$B_SCTESTS"$'\n'"$B_S3BUILD"$'\n'"$B_FIXED"$'\n''echo "[check] stage2 == stage3: compiler is a fixed point"' 0)"
    assert_seven_names "$report" || return 1
    local p
    for p in compile first-pass-tests seedcheck-build seedcheck-smoke seedcheck-tests stage3-build fixed-point; do
        assert_phase_status "$report" "$p" pass || return 1
    done
    # Top-level verdict is a clean pass.
    local json status
    json="$(cat "$report")"
    status="$(json_field "$json" status)"
    [ "$status" = "pass" ] || { echo "  top-level status: expected pass, got $status" >&2; return 1; }
}
run_test "green check: seven phases in order, all pass" check_green

# ---- Case 2: seedcheck-tests failure -> fail + trailing skipped ----
check_fail() {
    local report
    # Banners through the seedcheck-tests start, then a test-failure marker.
    report="$(run_check_stub "$B_FPTESTS"$'\n'"$B_SCBUILD"$'\n'"$B_SCSMOKE"$'\n''echo "[check] seedcheck binary runs hello-world.sfn OK"'$'\n'"$B_SCTESTS"$'\n''echo "═══ unit: 3/4 passed, 1 failed ═══"' 1)"
    assert_seven_names "$report" || return 1
    assert_phase_status "$report" compile pass || return 1
    assert_phase_status "$report" first-pass-tests pass || return 1
    assert_phase_status "$report" seedcheck-build pass || return 1
    assert_phase_status "$report" seedcheck-smoke pass || return 1
    assert_phase_status "$report" seedcheck-tests fail || return 1
    assert_phase_status "$report" stage3-build skipped || return 1
    assert_phase_status "$report" fixed-point skipped || return 1
    local json status phase failure
    json="$(cat "$report")"
    status="$(json_field "$json" status)"
    phase="$(json_field "$json" phase)"
    failure="$(json_field "$json" failure)"
    [ "$status" = "fail" ] || { echo "  top-level status: expected fail, got $status" >&2; return 1; }
    [ "$phase" = "seedcheck-tests" ] || { echo "  top-level phase: expected seedcheck-tests, got $phase" >&2; return 1; }
    [ "$failure" = "test-failure" ] || { echo "  top-level failure: expected test-failure, got $failure" >&2; return 1; }
}
run_test "seedcheck-tests fail: that phase fail, trailing skipped" check_fail

# ---- Case 3: nondeterminism -> fixed-point warn, exit 0 ----
check_warn() {
    local report
    report="$(run_check_stub "$B_FPTESTS"$'\n'"$B_SCBUILD"$'\n'"$B_SCSMOKE"$'\n'"$B_SCTESTS"$'\n'"$B_S3BUILD"$'\n'"$B_FIXED"$'\n''echo "[check][WARN] stage2 != stage3: compiler output is not yet a fixed point"' 0)"
    assert_seven_names "$report" || return 1
    local p
    for p in compile first-pass-tests seedcheck-build seedcheck-smoke seedcheck-tests stage3-build; do
        assert_phase_status "$report" "$p" pass || return 1
    done
    assert_phase_status "$report" fixed-point warn || return 1
    local json status failure
    json="$(cat "$report")"
    status="$(json_field "$json" status)"
    failure="$(json_field "$json" failure)"
    [ "$status" = "warn" ] || { echo "  top-level status: expected warn, got $status" >&2; return 1; }
    [ "$failure" = "nondeterminism" ] || { echo "  top-level failure: expected nondeterminism, got $failure" >&2; return 1; }
}
run_test "nondeterminism: fixed-point warn, top-level warn, exit 0" check_warn

echo "[test] check phase ledger: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
