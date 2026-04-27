#!/usr/bin/env bash
# End-to-end schema-lock test for `sfn check --json`.
#
# B2 (Track B in docs/proposals/check-architecture.md) shipped the
# `sailfin-check/1` JSON envelope. This test is the contract:
# `docs/reference/check-json-schema.md` is the human-readable spec,
# this script is the machine-checkable enforcement.
#
# We assert
#   - top-level field set is exactly the documented set
#   - summary field set is exactly the documented set
#   - event field set is exactly the documented set
#   - schema_version literal matches "sailfin-check/1"
#   - exit_code, severity, producer values come from the locked enums
#
# Adding a new field is intentionally caught here: if you mean to
# extend the schema, update `docs/reference/check-json-schema.md` and
# this script in the same PR. If you mean to ship a breaking change,
# bump schema_version to `sailfin-check/2` (and update both files).
#
# Usage:
#   compiler/tests/e2e/test_check_json_schema.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_check_json_schema.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

if ! command -v jq >/dev/null 2>&1; then
    echo "[test] SKIP: jq not installed (required for schema validation)" >&2
    exit 0
fi

SCRATCH="$(mktemp -d -t sfn-check-json-XXXXXX)"
trap 'rm -rf "$SCRATCH"' EXIT

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

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

mkdir -p "$SCRATCH/src"

ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/workspace.toml" <<'EOF'
[workspace]
members = []
EOF

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "check-json-schema-test"
version = "0.1.0"
description = "E2E schema lock for sfn check --json (Track B PR2)"

[capabilities]
required = ["io"]

[build]
entry = "src/clean.sfn"
EOF

# A clean file (no diagnostics) — exercises the empty-events path.
cat > "$SCRATCH/src/clean.sfn" <<'EOF'
fn add(a: number, b: number) -> number {
    return a + b;
}

fn main() {
    let _ = add(1, 2);
}

export { add };
EOF

# A file that triggers exactly one E0400 effect violation.
cat > "$SCRATCH/src/leak.sfn" <<'EOF'
fn noisy_helper(x: number) -> number {
    let mut total: number = 0;
    total = total + x;
    print.info("recording");
    return total;
}

fn main() ![io] {
    let _ = noisy_helper(1);
}

export { noisy_helper };
EOF

cd "$SCRATCH"

# ---- Test 1: clean file emits empty events + clean summary ----
test_clean_envelope() {
    local out
    out="$("$BINARY" check --json src/clean.sfn 2>/dev/null || true)"
    if [ -z "$out" ]; then
        echo "[test]   no JSON output produced"
        return 1
    fi
    local schema; schema=$(jq -r '.schema_version' <<<"$out")
    if [ "$schema" != "sailfin-check/1" ]; then
        echo "[test]   expected schema_version sailfin-check/1, got: $schema"
        return 1
    fi
    local exit_code; exit_code=$(jq -r '.exit_code' <<<"$out")
    if [ "$exit_code" != "0" ]; then
        echo "[test]   expected exit_code 0 on clean file, got: $exit_code"
        return 1
    fi
    local errors; errors=$(jq -r '.summary.errors' <<<"$out")
    if [ "$errors" != "0" ]; then
        echo "[test]   expected summary.errors == 0, got: $errors"
        return 1
    fi
    local nevents; nevents=$(jq -r '.events | length' <<<"$out")
    if [ "$nevents" != "0" ]; then
        echo "[test]   expected events array empty, got length: $nevents"
        return 1
    fi
    return 0
}
run_test "clean run: empty events + clean summary" test_clean_envelope

# ---- Test 2: top-level field set is exactly the documented set ----
test_top_level_field_set() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local actual; actual=$(jq -r 'keys | sort | join(",")' <<<"$out")
    local expected="command,events,exit_code,schema_version,summary"
    if [ "$actual" != "$expected" ]; then
        echo "[test]   top-level keys diverged from schema"
        echo "[test]   expected: $expected"
        echo "[test]   actual:   $actual"
        return 1
    fi
    return 0
}
run_test "top-level field set matches schema" test_top_level_field_set

# ---- Test 3: summary field set ----
test_summary_field_set() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local actual; actual=$(jq -r '.summary | keys | sort | join(",")' <<<"$out")
    local expected="duration_ms,errors,files_checked,warnings"
    if [ "$actual" != "$expected" ]; then
        echo "[test]   summary keys diverged from schema"
        echo "[test]   expected: $expected"
        echo "[test]   actual:   $actual"
        return 1
    fi
    return 0
}
run_test "summary field set matches schema" test_summary_field_set

# ---- Test 4: event field set (using the leak fixture) ----
test_event_field_set() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local actual; actual=$(jq -r '.events[0] | keys | sort | join(",")' <<<"$out")
    local expected="code,file_path,kind,message,primary,producer,secondary,severity,suggestion"
    if [ "$actual" != "$expected" ]; then
        echo "[test]   event keys diverged from schema"
        echo "[test]   expected: $expected"
        echo "[test]   actual:   $actual"
        return 1
    fi
    return 0
}
run_test "event field set matches schema" test_event_field_set

# ---- Test 5: primary token field set ----
test_primary_token_field_set() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local actual; actual=$(jq -r '.events[0].primary | keys | sort | join(",")' <<<"$out")
    local expected="column,label,lexeme,line"
    if [ "$actual" != "$expected" ]; then
        echo "[test]   primary token keys diverged from schema"
        echo "[test]   expected: $expected"
        echo "[test]   actual:   $actual"
        return 1
    fi
    return 0
}
run_test "primary token field set matches schema" test_primary_token_field_set

# ---- Test 6: severity values come from the locked enum ----
test_severity_enum() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local invalid
    invalid=$(jq -r '[.events[].severity] | map(select(. != "error" and . != "warning" and . != "hint" and . != "info")) | length' <<<"$out")
    if [ "$invalid" != "0" ]; then
        echo "[test]   found severity values outside the locked enum"
        jq -r '[.events[].severity] | unique[]' <<<"$out"
        return 1
    fi
    return 0
}
run_test "severity values within locked enum" test_severity_enum

# ---- Test 7: producer values come from the locked classifier ----
test_producer_enum() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local invalid
    invalid=$(jq -r '[.events[].producer] | map(select(. != "typecheck" and . != "effect" and . != "parse" and . != "load" and . != "unknown")) | length' <<<"$out")
    if [ "$invalid" != "0" ]; then
        echo "[test]   found producer values outside the locked enum"
        jq -r '[.events[].producer] | unique[]' <<<"$out"
        return 1
    fi
    return 0
}
run_test "producer values within locked enum" test_producer_enum

# ---- Test 8: kind discriminator only emits "diagnostic" or "load_warning" ----
test_kind_enum() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local invalid
    invalid=$(jq -r '[.events[].kind] | map(select(. != "diagnostic" and . != "load_warning")) | length' <<<"$out")
    if [ "$invalid" != "0" ]; then
        echo "[test]   found kind values outside the locked enum"
        return 1
    fi
    return 0
}
run_test "kind values within locked enum" test_kind_enum

# ---- Test 9: summary.errors matches actual error count in events ----
test_summary_errors_consistent() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local summary_errs; summary_errs=$(jq -r '.summary.errors' <<<"$out")
    local event_errs; event_errs=$(jq -r '[.events[] | select(.severity == "error")] | length' <<<"$out")
    if [ "$summary_errs" != "$event_errs" ]; then
        echo "[test]   summary.errors ($summary_errs) != count of error-severity events ($event_errs)"
        return 1
    fi
    return 0
}
run_test "summary.errors agrees with event count" test_summary_errors_consistent

# ---- Test 10: leak fixture produces an effect-producer event with primary at line 4 ----
test_effect_event_primary() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local code; code=$(jq -r '.events[0].code' <<<"$out")
    local producer; producer=$(jq -r '.events[0].producer' <<<"$out")
    local primary_line; primary_line=$(jq -r '.events[0].primary.line' <<<"$out")
    local primary_lexeme; primary_lexeme=$(jq -r '.events[0].primary.lexeme' <<<"$out")
    if [ "$code" != "E0400" ]; then
        echo "[test]   expected E0400, got: $code"
        return 1
    fi
    if [ "$producer" != "effect" ]; then
        echo "[test]   expected producer=effect, got: $producer"
        return 1
    fi
    if [ "$primary_line" != "4" ]; then
        echo "[test]   expected primary.line=4 (B1 caret on print call), got: $primary_line"
        return 1
    fi
    if [ "$primary_lexeme" != "print" ]; then
        echo "[test]   expected primary.lexeme=print, got: $primary_lexeme"
        return 1
    fi
    return 0
}
run_test "leak fixture emits E0400 with B1 call-site caret" test_effect_event_primary

# ---- Test 11: --json suppresses stderr human output ----
test_json_quiets_stderr() {
    local stderr_size
    stderr_size=$("$BINARY" check --json src/leak.sfn 2>"$SCRATCH/stderr.txt" >/dev/null || true; wc -c < "$SCRATCH/stderr.txt")
    if [ "$stderr_size" -gt 0 ]; then
        echo "[test]   --json should suppress stderr; got $stderr_size bytes"
        head -3 "$SCRATCH/stderr.txt" >&2
        return 1
    fi
    return 0
}
run_test "--json suppresses stderr human output" test_json_quiets_stderr

# ---- Test 12: secondary/suggestion reserved fields are present (and null/empty) ----
test_reserved_fields_present() {
    local out
    out="$("$BINARY" check --json src/leak.sfn 2>/dev/null || true)"
    local has_suggestion; has_suggestion=$(jq -r '.events[0] | has("suggestion")' <<<"$out")
    local has_secondary; has_secondary=$(jq -r '.events[0] | has("secondary")' <<<"$out")
    local suggestion; suggestion=$(jq -r '.events[0].suggestion' <<<"$out")
    local secondary; secondary=$(jq -r '.events[0].secondary | length' <<<"$out")
    if [ "$has_suggestion" != "true" ]; then
        echo "[test]   suggestion field missing"
        return 1
    fi
    if [ "$has_secondary" != "true" ]; then
        echo "[test]   secondary field missing"
        return 1
    fi
    if [ "$suggestion" != "null" ]; then
        echo "[test]   suggestion should be null pre-B3, got: $suggestion"
        return 1
    fi
    if [ "$secondary" != "0" ]; then
        echo "[test]   secondary should be empty pre-B5, got length: $secondary"
        return 1
    fi
    return 0
}
run_test "reserved fields (secondary, suggestion) present and stub" test_reserved_fields_present

echo "[summary] $PASS passed, $FAIL failed"
if [ "$FAIL" -ne 0 ]; then
    exit 1
fi
exit 0
