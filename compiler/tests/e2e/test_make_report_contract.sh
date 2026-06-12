#!/usr/bin/env bash
# End-to-end smoke test for the make `JSON=1` report-file contract
# (#1125, epic #1056 Phase 2). Sibling of
# compiler/tests/e2e/test_make_result_contract.sh (which locks the
# verdict-block contract). This test locks the *report-file* behavior
# shipped by #1119 (the gate + stub) and #1123 (the composer):
#
#   JSON=1 make <target>  -> writes build/agent-report.<target>.json,
#                            a parseable `sailfin-make/1` report whose
#                            `report` field self-references that path, and
#                            sets the verdict block's `report` to the same
#                            path.
#   make <target>         -> writes NO report file; the verdict block's
#                            `report` field stays null (the additive,
#                            default-off invariant).
#
# Schema/design: docs/reference/make-result-schema.md,
# docs/proposals/agent-output-orchestration.md §3.
#
# This is the Phase-2 *contract* smoke test: it proves the per-target
# report file appears under the gate, parses, self-references, and is
# absent (with `report:null`) when the gate is off — plus per-target path
# distinctness across two targets. The full field-by-field schema-lock of
# every report field (and the warn/nondeterminism path) is Phase 3's
# `test_make_result_schema.sh` and is deliberately out of scope here, as
# is any case that needs a full `make check` run.
#
# Cases (chosen to be cheap, deterministic, and network-free):
#   - off:    `make compile` with the gate explicitly cleared -> no file,
#             verdict `report` null. compile is up-to-date in every context
#             this suite runs (it executes after the compiler is built from
#             the same sources), so it returns in well under a second.
#   - on:     `JSON=1 make compile` -> build/agent-report.compile.json
#             exists, parses, `target`=="compile", `report` self-references
#             the path, `phases` is an array, and the verdict block's
#             `report` equals the same path.
#   - paths:  per-target path distinctness. A second, instantly
#             deterministic target — `check-fast NATIVE_BIN=/nonexistent`,
#             whose guard fails before any work (the same canonical fast
#             failure the sibling test uses) — writes a *distinct*
#             build/agent-report.check-fast.json. No test target completes
#             cheaply/deterministically enough for an e2e smoke, so this
#             stands in for "a cheap second target"; it exercises the
#             identical per-target `build/agent-report.${TARGET}.json`
#             path-substitution code.
#
# Usage:
#   compiler/tests/e2e/test_make_report_contract.sh <compiler-binary>

set -uo pipefail

BINARY="${1:?usage: test_make_report_contract.sh <compiler-binary>}"
# Enforce the argument contract before any work. `set -e` is intentionally
# off (failures are classified explicitly below), so a bad/missing path
# must be rejected here rather than silently degrading into a false-green —
# and the check must precede `realpath`, whose failure on a missing path
# would otherwise leave BINARY empty.
if [ ! -x "$BINARY" ]; then
    echo "test_make_report_contract.sh: '$BINARY' is not an executable compiler binary" >&2
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

SCRATCH="$(mktemp -d -t sfn-make-report-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

# `timeout` is GNU coreutils (linux-x86_64 CI); absent on macos-arm64. Use
# it when available so a wedged target can't hang the suite. The up-to-date
# `make compile` returns in well under a second and the check-fast guard
# aborts immediately; 300s is generous headroom that still trips loudly if
# a pathological stale tree forces a full rebuild.
TIMEOUT_PREFIX=""
if command -v timeout >/dev/null 2>&1; then TIMEOUT_PREFIX="timeout 300"; fi

# Per-target report paths under test.
COMPILE_REPORT="build/agent-report.compile.json"
CHECKFAST_REPORT="build/agent-report.check-fast.json"

# Run a make target with the verdict wrapper active and the JSON=1
# report-file gate ON. Clears SAILFIN_INNER (so the outer target emits its
# own verdict block + report file rather than running transparently as a
# nested target) and passes JSON=1 on the command line, which the Makefile
# maps to the exported SAILFIN_AGENT_REPORT=1 that agent_report.sh reads.
# `--no-print-directory`: under the recursive e2e harness an invoked
# sub-make would otherwise print `make[N]: Leaving directory …` after the
# verdict block; suppressing it keeps the captured log clean.
run_make_json() {
    local logfile="$1"
    shift
    (
      env -u SAILFIN_INNER ${TIMEOUT_PREFIX} \
          make JSON=1 --no-print-directory "$@" ) \
        > "$logfile" 2>&1
    return 0
}

# Run a make target with the report-file gate explicitly OFF. Besides
# SAILFIN_INNER, clear any inherited SAILFIN_AGENT_REPORT: the outer e2e
# harness may itself be running under JSON=1 and export it, which would
# turn the gate on even without a JSON=1 on this command line. Clearing it
# (and omitting JSON=1) guarantees the default-off path is what we measure.
run_make_off() {
    local logfile="$1"
    shift
    (
      env -u SAILFIN_INNER -u SAILFIN_AGENT_REPORT ${TIMEOUT_PREFIX} \
          make --no-print-directory "$@" ) \
        > "$logfile" 2>&1
    return 0
}

# Line number of the last marker line (or "").
_last_marker_line() { grep -n -- "$2" "$1" | tail -n1 | cut -d: -f1; }

# Extract the JSON line of the final verdict block (the single line after
# the last `===SAILFIN-RESULT===`).
verdict_json() {
    local logfile="$1" start
    start="$(_last_marker_line "$logfile" '===SAILFIN-RESULT===')"
    [ -n "$start" ] || return 1
    sed -n "$((start + 1))p" "$logfile"
}

# Read a flat-JSON string field. Prefers jq when present (also validates
# the line parses); falls back to a sed extraction of "<field>":"<value>"
# / "<field>":null. Mirrors the sibling test's helper. The greedy sed branch
# returns the last `"<field>":` occurrence — safe here because this helper is
# applied ONLY to the single-line verdict block, whose fields are each flat
# and single-occurrence. Report-FILE reads (which nest the same keys inside
# phases[]) go through report_file_field's first-occurrence extraction below,
# never this helper.
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

# Assert a JSON string parses (jq only; a no-op skip when jq is unavailable
# so the test still runs its grep-based field checks).
assert_parses_json() {
    local json="$1"
    command -v jq >/dev/null 2>&1 || return 0
    if ! printf '%s' "$json" | jq -e . >/dev/null 2>&1; then
        echo "  not valid JSON: $json" >&2
        return 1
    fi
    return 0
}

# Read a top-level field from a report FILE. Prefers jq (correctly ignores
# duplicate keys nested under phases[]). The jq-less fallback must NOT
# delegate to json_field above: a report file nests the same keys inside
# phases[] (e.g. a top-level "report" plus phases[].report when a rebuild
# populated the artifact), and json_field's greedy sed would return the
# *last* (nested) occurrence. write_report_file emits every top-level field
# before phases[], so a first-occurrence match selects the top-level value —
# the same idiom test_check_phase_ledger.sh uses for its nested status keys.
report_file_field() {
    local file="$1" field="$2" match
    if command -v jq >/dev/null 2>&1; then
        jq -r ".${field} // \"null\"" "$file" 2>/dev/null
        return
    fi
    match="$(grep -oE "\"${field}\":(\"[^\"]*\"|null)" "$file" | head -n1)"
    case "$match" in
        *:null) printf 'null' ;;
        *) printf '%s' "$match" | sed -E "s/.*:\"([^\"]*)\"/\1/" ;;
    esac
}

# ---- Case 1: gate OFF -> no report file, verdict report:null ----
# Remove any pre-existing report (a prior gated run, or a stale artifact in
# build/) so "no file is created" is measured deterministically.
OFF_LOG="$SCRATCH/off.log"
rm -f "$COMPILE_REPORT"
run_make_off "$OFF_LOG" compile

check_off_case() {
    if [ -e "$COMPILE_REPORT" ]; then
        echo "  default (gate off) make compile must NOT create $COMPILE_REPORT" >&2
        return 1
    fi
    local json
    json="$(verdict_json "$OFF_LOG")" || { echo "  no verdict JSON" >&2; return 1; }
    assert_parses_json "$json" || return 1
    local report
    report="$(json_field "$json" report)"
    if [ "$report" != "null" ]; then
        echo "  expected verdict report:null when the gate is off, got: $report" >&2
        tail -5 "$OFF_LOG" >&2
        return 1
    fi
    return 0
}
run_test "gate off: no report file, verdict report is null" check_off_case

# ---- Case 2: gate ON -> report file exists, parses, self-references ----
ON_LOG="$SCRATCH/on.log"
rm -f "$COMPILE_REPORT"
run_make_json "$ON_LOG" compile

check_on_case() {
    if [ ! -f "$COMPILE_REPORT" ]; then
        echo "  JSON=1 make compile must create $COMPILE_REPORT" >&2
        tail -5 "$ON_LOG" >&2
        return 1
    fi
    # The report file itself parses as JSON.
    if command -v jq >/dev/null 2>&1; then
        if ! jq -e . "$COMPILE_REPORT" >/dev/null 2>&1; then
            echo "  $COMPILE_REPORT is not valid JSON" >&2
            return 1
        fi
    fi
    local schema target report phases_type
    schema="$(report_file_field "$COMPILE_REPORT" schema_version)"
    if [ "$schema" != "sailfin-make/1" ]; then
        echo "  expected report schema_version sailfin-make/1, got: $schema" >&2
        return 1
    fi
    target="$(report_file_field "$COMPILE_REPORT" target)"
    if [ "$target" != "compile" ]; then
        echo "  expected report target compile, got: $target" >&2
        return 1
    fi
    # `report` self-references the file's own path.
    report="$(report_file_field "$COMPILE_REPORT" report)"
    if [ "$report" != "$COMPILE_REPORT" ]; then
        echo "  expected report to self-reference $COMPILE_REPORT, got: $report" >&2
        return 1
    fi
    # `phases` is present and an array (contents — degraded [] vs a
    # single-entry — are Phase 3's field-by-field lock, not pinned here).
    if command -v jq >/dev/null 2>&1; then
        phases_type="$(jq -r '.phases | type' "$COMPILE_REPORT" 2>/dev/null)"
        if [ "$phases_type" != "array" ]; then
            echo "  expected report phases to be an array, got: $phases_type" >&2
            return 1
        fi
    fi
    # The verdict block's `report` field equals the report path.
    local json vreport
    json="$(verdict_json "$ON_LOG")" || { echo "  no verdict JSON" >&2; return 1; }
    assert_parses_json "$json" || return 1
    vreport="$(json_field "$json" report)"
    if [ "$vreport" != "$COMPILE_REPORT" ]; then
        echo "  expected verdict report to match $COMPILE_REPORT, got: $vreport" >&2
        tail -5 "$ON_LOG" >&2
        return 1
    fi
    return 0
}
run_test "gate on: per-target report file exists, parses, self-references" check_on_case

# ---- Case 3: per-target path distinctness ----
# A second, instantly-deterministic target writes its OWN distinctly-named
# report file. `check-fast NATIVE_BIN=/nonexistent` trips check-fast's guard
# ("run: make compile") before any work — a network-free failure that still
# runs the agent_report wrapper, so under JSON=1 it writes
# build/agent-report.check-fast.json.
CF_LOG="$SCRATCH/checkfast.log"
rm -f "$CHECKFAST_REPORT"
run_make_json "$CF_LOG" check-fast NATIVE_BIN=/nonexistent/sailfin

check_distinct_paths_case() {
    # Both targets' report files exist, at distinct paths.
    if [ ! -f "$COMPILE_REPORT" ]; then
        echo "  expected $COMPILE_REPORT from the earlier gated compile" >&2
        return 1
    fi
    if [ ! -f "$CHECKFAST_REPORT" ]; then
        echo "  JSON=1 make check-fast must create $CHECKFAST_REPORT" >&2
        tail -6 "$CF_LOG" >&2
        return 1
    fi
    if [ "$COMPILE_REPORT" = "$CHECKFAST_REPORT" ]; then
        echo "  per-target report paths must be distinct" >&2
        return 1
    fi
    # Each report's target + self-reference matches its own path.
    local ct cr ft fr
    ct="$(report_file_field "$COMPILE_REPORT" target)"
    cr="$(report_file_field "$COMPILE_REPORT" report)"
    if [ "$ct" != "compile" ] || [ "$cr" != "$COMPILE_REPORT" ]; then
        echo "  compile report mismatch: target=$ct report=$cr" >&2
        return 1
    fi
    ft="$(report_file_field "$CHECKFAST_REPORT" target)"
    fr="$(report_file_field "$CHECKFAST_REPORT" report)"
    if [ "$ft" != "check-fast" ] || [ "$fr" != "$CHECKFAST_REPORT" ]; then
        echo "  check-fast report mismatch: target=$ft report=$fr" >&2
        return 1
    fi
    return 0
}
run_test "per-target paths: compile vs check-fast reports are distinct + self-referential" check_distinct_paths_case

echo "[test] make report contract: $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
