#!/usr/bin/env bash
# End-to-end tests for `sfn fmt`.
#
# Usage:
#   compiler/tests/e2e/test_fmt.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_fmt.sh <compiler-binary>}"
PASS=0
FAIL=0
TMPDIR_BASE="$(mktemp -d)"
trap 'rm -rf "$TMPDIR_BASE"' EXIT

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

# Helper: write input to a temp file, run fmt, compare to expected.
# Note: expected should NOT include a trailing newline — the comparison
# strips trailing newlines from both sides (bash $() strips them).
assert_fmt() {
    local name="$1"
    local input="$2"
    local expected="$3"
    local tmpfile="$TMPDIR_BASE/${name// /_}.sfn"
    printf '%s' "$input" > "$tmpfile"
    local actual
    actual="$("$BINARY" fmt "$tmpfile" 2>&1)" || true
    if [ "$actual" = "$expected" ]; then
        return 0
    else
        echo "  expected:"
        echo "$expected" | head -5 | sed 's/^/    /'
        echo "  actual:"
        echo "$actual" | head -5 | sed 's/^/    /'
        return 1
    fi
}

# Helper: verify formatting is idempotent (format twice = same result)
assert_idempotent() {
    local name="$1"
    local input="$2"
    local tmpfile="$TMPDIR_BASE/${name// /_}.sfn"
    printf '%s' "$input" > "$tmpfile"
    local first second
    first="$("$BINARY" fmt "$tmpfile" 2>&1)" || true
    local tmpfile2="$TMPDIR_BASE/${name// /_}_pass2.sfn"
    printf '%s' "$first" > "$tmpfile2"
    second="$("$BINARY" fmt "$tmpfile2" 2>&1)" || true
    if [ "$first" = "$second" ]; then
        return 0
    else
        echo "  pass1 and pass2 differ (not idempotent)"
        diff <(echo "$first") <(echo "$second") | head -10 || true
        return 1
    fi
}

# ---- Test: empty file ----
run_test "fmt: empty file" assert_fmt "empty" "" ""

# ---- Test: comment-only file ----
run_test "fmt: comment-only file" assert_fmt "comment_only" \
    '// This is a comment
// Another comment' \
    '// This is a comment
// Another comment'

# ---- Test: simple function ----
run_test "fmt: simple function spacing" assert_fmt "simple_fn" \
    'fn hello() -> string { return "world"; }' \
    'fn hello() -> string { return "world"; }'

# ---- Test: unary negation (no space after -) ----
run_test "fmt: unary negation" assert_fmt "unary_neg" \
    "fn neg(x: number) -> number { return -x; }" \
    "fn neg(x: number) -> number { return -x; }"

# ---- Test: unary not (no space after !) ----
run_test "fmt: unary not" assert_fmt "unary_not" \
    'fn check(a: string, b: string) -> boolean { return !strings_equal(a, b); }' \
    'fn check(a: string, b: string) -> boolean { return !strings_equal(a, b); }'

# ---- Test: optional type suffix (no space before ?) ----
# Note: the function body expands because ? isn't yet an inline-context token
run_test "fmt: optional type suffix" assert_fmt "optional_type" \
    "fn find(x: string) -> string? { return x; }" \
    'fn find(x: string) -> string? {
    return x;
}'

# ---- Test: effect annotations ----
run_test "fmt: effect annotations" assert_fmt "effects" \
    'fn fetch(url: string) -> string ![io, net] { return ""; }' \
    'fn fetch(url: string) -> string ![io, net] { return ""; }'

# ---- Test: struct declaration stays multi-line ----
run_test "fmt: struct decl not inlined" assert_fmt "struct_decl" \
    'struct Point {
    x: number;
    y: number;
}' \
    'struct Point {
    x: number;
    y: number;
}'

# ---- Test: import stays inline ----
run_test "fmt: import inline" assert_fmt "import_inline" \
    'import { foo, bar } from "./mod";' \
    'import { foo, bar } from "./mod";'

# ---- Test: let binding ----
run_test "fmt: let binding spacing" assert_fmt "let_binding" \
    'let x: number = 42;' \
    'let x: number = 42;'

# ---- Test: if/else stays inline inside expanded fn ----
# The outer fn body expands (contains nested blocks), but inner if/else
# blocks stay inline on their own line.
run_test "fmt: if/else inline" assert_fmt "if_else_inline" \
    'fn f(x: boolean) -> number { if x { return 1; } else { return 0; } }' \
    'fn f(x: boolean) -> number {
    if x { return 1; } else { return 0; }
}'

# ---- Test: idempotency on real compiler file ----
run_test "fmt: idempotency on string_utils.sfn" assert_idempotent "idem_string_utils" \
    "$(cat compiler/src/string_utils.sfn)"

# ---- Test: idempotency on ast.sfn ----
run_test "fmt: idempotency on ast.sfn" assert_idempotent "idem_ast" \
    "$(cat compiler/src/ast.sfn)"

# ---- Test: idempotency on effect_checker.sfn ----
run_test "fmt: idempotency on effect_checker.sfn" assert_idempotent "idem_effect_checker" \
    "$(cat compiler/src/effect_checker.sfn)"

# ---- Test: --check mode detects unformatted file ----
test_check_mode_detects_diff() {
    local tmpfile="$TMPDIR_BASE/check_diff.sfn"
    printf 'fn   foo( )  ->   string  {  return "bar" ;  }' > "$tmpfile"
    # --check should exit non-zero when file differs from formatted output
    if "$BINARY" fmt --check "$tmpfile" > /dev/null 2>&1; then
        echo "  --check should have exited non-zero for unformatted file"
        return 1
    fi
    return 0
}
run_test "fmt: --check detects unformatted" test_check_mode_detects_diff

# ---- Test: --check mode passes on formatted file ----
test_check_mode_passes() {
    local tmpfile="$TMPDIR_BASE/check_pass.sfn"
    printf 'fn foo() -> string { return "bar"; }' > "$tmpfile"
    # Use --write first, then --check should pass
    "$BINARY" fmt --write "$tmpfile" > /dev/null 2>&1
    if "$BINARY" fmt --check "$tmpfile" > /dev/null 2>&1; then
        return 0
    else
        echo "  --check should have exited 0 for already-formatted file"
        return 1
    fi
}
run_test "fmt: --check passes on formatted" test_check_mode_passes

# ---- Test: --write mode modifies file in place ----
test_write_mode() {
    local tmpfile="$TMPDIR_BASE/write_mode.sfn"
    printf 'fn   foo( )  ->   string  {  return "bar" ;  }' > "$tmpfile"
    "$BINARY" fmt --write "$tmpfile" > /dev/null 2>&1
    # After --write, --check should pass
    if "$BINARY" fmt --check "$tmpfile" > /dev/null 2>&1; then
        return 0
    else
        echo "  --write did not produce formatted output"
        return 1
    fi
}
run_test "fmt: --write modifies file" test_write_mode

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
