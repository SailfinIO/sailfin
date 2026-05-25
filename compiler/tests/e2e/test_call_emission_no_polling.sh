#!/usr/bin/env bash
# End-to-end test for M2.7c — call-site exception polling removal
# (issue #406, epic #389). Pins that compiler-emitted IR contains zero
# `call ... @sailfin_runtime_has_exception` instructions, the
# per-call-site polling that the legacy TLS-based try/catch path
# emitted after every function call inside a try body.
#
# What this PR ships, end-to-end (in concert with M2.7a/#400 and
# M2.7b/#404):
#
#   1. The legacy TLS-polling shape — `clear_exception` at try entry,
#      `has_exception` poll + branch after every call in the try body,
#      `take_exception` at catch entry, and a propagate-poll on the
#      merge edge — was replaced wholesale by inline setjmp/longjmp
#      primitives when `instructions_try.sfn` was rewritten (PR #733).
#      The "two instructions per call site on the happy path" (the
#      `has_exception` call + the conditional branch on its result)
#      promised in #406's description are already gone in the current
#      compiler.
#   2. This test locks that property in: compiler-emitted IR for the
#      heavy modules and a representative try/catch fixture contains
#      zero `call ... @sailfin_runtime_has_exception` lines. A future
#      regression that reintroduces per-call-site polling will fail
#      this test before it lands.
#
# We deliberately check `call` lines, not `declare` lines — the
# compiler-side `RuntimeHelperDescriptor` for `has_exception` stays
# registered for ABI completeness (and the C symbol stays exported
# until M3 deletes the C runtime body), so a `declare i1
# @sailfin_runtime_has_exception()` may still surface in some emitted
# modules. What MUST be zero is the call site count — if the IR ever
# `call`s the symbol, the polling has crept back into emission.
#
# Usage:
#   compiler/tests/e2e/test_call_emission_no_polling.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_call_emission_no_polling.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
REPO_ROOT="$(cd "$SCRIPT_DIR/../../.." && pwd)"

PASS=0
FAIL=0

SCRATCH="$(mktemp -d -t sfn-call-no-polling-XXXXXX)"
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

emit_llvm() {
    local source="$1"
    local out="$2"
    local log="$3"
    "$BINARY" emit -o "$out" llvm "$source" > "$log" 2>&1
}

# Dump a captured emit log to the test output stream, prefixed for
# readability. Called from each test on emit failure so CI logs show
# the compiler diagnostic without needing a local rerun.
dump_emit_log() {
    local log="$1"
    if [ -s "$log" ]; then
        sed 's/^/[test]     /' "$log"
    else
        echo "[test]     (emit produced no stderr/stdout)"
    fi
}

# Count `call` instructions targeting a symbol. Matches the LLVM
# call shapes that show up in compiler-emitted IR:
#
#   %t = call <ty> @sailfin_runtime_has_exception()
#        call void @sailfin_runtime_has_exception()
#
# but NOT `declare i1 @sailfin_runtime_has_exception()`. We pick the
# narrowest disambiguator: the literal substring ` call ` (with bounding
# spaces) immediately preceding the symbol mention — `declare` lines
# don't contain that token, but every call site does.
#
# Exits the script (non-zero) when the IR file is missing or grep
# reports an error other than "no matches" (exit 1). Returning an
# empty string here would let the caller's `[ "$count" -ne 0 ]`
# comparison silently pass on a missing file, masking the very
# regression this test guards against. `grep -c` exit codes:
#   0 — at least one match (count > 0)
#   1 — no matches (count == 0)
#   2 — file I/O or pattern error — propagate as a hard failure
count_call_sites() {
    local ll="$1"
    local symbol="$2"
    if [ ! -r "$ll" ]; then
        echo "[count_call_sites] IR file missing or unreadable: $ll" >&2
        exit 1
    fi
    local count
    local rc=0
    count="$(grep -cE "[[:space:]]call[[:space:]].*@${symbol}\b" "$ll")" || rc=$?
    if [ "$rc" -ne 0 ] && [ "$rc" -ne 1 ]; then
        echo "[count_call_sites] grep failed (exit $rc) on $ll" >&2
        exit 1
    fi
    printf '%s' "${count:-0}"
}

# ---- (1) heavy compiler module: lowering_core.sfn ----
test_lowering_core_no_polling() {
    local source="$REPO_ROOT/compiler/src/llvm/lowering/lowering_core.sfn"
    local ll="$SCRATCH/lowering_core.ll"
    local log="$SCRATCH/lowering_core.emit.log"
    if ! emit_llvm "$source" "$ll" "$log"; then
        echo "[test]   sfn emit llvm failed for lowering_core.sfn"
        dump_emit_log "$log"
        return 1
    fi
    local count
    count="$(count_call_sites "$ll" "sailfin_runtime_has_exception")"
    if [ "$count" -ne 0 ]; then
        echo "[test]   expected 0 has_exception call sites in lowering_core.ll, got $count:"
        grep -nE "[[:space:]]call[[:space:]].*@sailfin_runtime_has_exception\b" "$ll" \
            | head -20 | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

# ---- (2) heavy compiler module: instructions_try.sfn (the migration target) ----
test_instructions_try_no_polling() {
    local source="$REPO_ROOT/compiler/src/llvm/lowering/instructions_try.sfn"
    local ll="$SCRATCH/instructions_try.ll"
    local log="$SCRATCH/instructions_try.emit.log"
    if ! emit_llvm "$source" "$ll" "$log"; then
        echo "[test]   sfn emit llvm failed for instructions_try.sfn"
        dump_emit_log "$log"
        return 1
    fi
    local count
    count="$(count_call_sites "$ll" "sailfin_runtime_has_exception")"
    if [ "$count" -ne 0 ]; then
        echo "[test]   expected 0 has_exception call sites in instructions_try.ll, got $count:"
        grep -nE "[[:space:]]call[[:space:]].*@sailfin_runtime_has_exception\b" "$ll" \
            | head -20 | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

# ---- (3) try/catch fixture: ensure the emission path that USES try
#         doesn't reintroduce polling at any call site ----
test_try_catch_fixture_no_polling() {
    local fixture="$SCRATCH/try_catch.sfn"
    cat > "$fixture" <<'SFN'
fn helper(x: int) -> int { return x + 1; }

fn main() ![io] {
    try {
        let a: int = helper(1);
        let b: int = helper(a);
        let c: int = helper(b);
        print("ok");
    } catch (e) {
        print("caught: " + e);
    }
}
SFN
    local ll="$SCRATCH/try_catch.ll"
    local log="$SCRATCH/try_catch.emit.log"
    if ! emit_llvm "$fixture" "$ll" "$log"; then
        echo "[test]   sfn emit llvm failed for try/catch fixture"
        dump_emit_log "$log"
        return 1
    fi
    local count
    count="$(count_call_sites "$ll" "sailfin_runtime_has_exception")"
    if [ "$count" -ne 0 ]; then
        echo "[test]   expected 0 has_exception call sites in try/catch fixture IR, got $count"
        echo "[test]   (this is the regression that M2.7c guards against: a"
        echo "[test]    rewrite of instructions_try.sfn must not re-emit"
        echo "[test]    per-call-site polling alongside the setjmp/longjmp path)"
        grep -nE "[[:space:]]call[[:space:]].*@sailfin_runtime_has_exception\b" "$ll" \
            | head -20 | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

# ---- (4) representative non-try module: pure function-call traffic
#         must also be polling-free (catches the worst case where a
#         future change would emit polling unconditionally after every
#         call, not just inside try bodies) ----
test_pure_call_traffic_no_polling() {
    local fixture="$SCRATCH/pure_calls.sfn"
    cat > "$fixture" <<'SFN'
fn add(a: int, b: int) -> int { return a + b; }
fn mul(a: int, b: int) -> int { return a * b; }

fn compute(seed: int) -> int {
    let a: int = add(seed, 1);
    let b: int = mul(a, 2);
    let c: int = add(b, mul(seed, 3));
    return c;
}

fn main() ![io] {
    let result: int = compute(7);
    print("done");
}
SFN
    local ll="$SCRATCH/pure_calls.ll"
    local log="$SCRATCH/pure_calls.emit.log"
    if ! emit_llvm "$fixture" "$ll" "$log"; then
        echo "[test]   sfn emit llvm failed for pure-calls fixture"
        dump_emit_log "$log"
        return 1
    fi
    local count
    count="$(count_call_sites "$ll" "sailfin_runtime_has_exception")"
    if [ "$count" -ne 0 ]; then
        echo "[test]   expected 0 has_exception call sites in pure-calls IR, got $count:"
        grep -nE "[[:space:]]call[[:space:]].*@sailfin_runtime_has_exception\b" "$ll" \
            | head -20 | sed 's/^/[test]     /'
        return 1
    fi
    return 0
}

run_test "no has_exception polling in lowering_core.sfn IR" \
    test_lowering_core_no_polling
run_test "no has_exception polling in instructions_try.sfn IR" \
    test_instructions_try_no_polling
run_test "no has_exception polling in try/catch fixture IR" \
    test_try_catch_fixture_no_polling
run_test "no has_exception polling in pure call-traffic IR" \
    test_pure_call_traffic_no_polling

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -gt 0 ]; then
    exit 1
fi
