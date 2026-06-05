#!/usr/bin/env bash
# Closure-bloat guard (#1050, epic #1046).
#
# Pins the dead-code strip behavior added in #1047: when a consumer
# imports ONE symbol from a multi-function capsule, the dep's
# unreferenced functions must NOT survive into the linked binary.
# Before #1047 the capsule link step linked every `.ll` from a dep's
# whole `src/` tree with no garbage collection, so a binary that used
# only `sfn/math::abs` still dragged `clamp`, `mean`, `pow`, and the
# rest of the capsule's closure into the executable.
#
# The guard builds a consumer that imports a single `sfn/math` symbol
# and asserts via `nm` that:
#   - the USED symbol is present (the capsule actually linked — this
#     keeps the absence checks below from passing vacuously if the
#     dep silently failed to link), and
#   - clearly-unreferenced sibling symbols are ABSENT (dead-strip ran).
#
# `sfn/math` is a deliberate fixture: `abs` is a standalone function
# (no internal calls), while `clamp` and `mean` are not reachable from
# it, so a correct dead-strip drops them. Reverting #1047's
# `-ffunction-sections` / `--gc-sections` (Linux) / `-dead_strip`
# (Darwin) flags locally makes the absence assertions fail — that is
# the regression this guard catches.
#
# Usage:
#   compiler/tests/e2e/test_capsule_dead_strip_guard.sh <compiler-binary>

set -euo pipefail

BINARY="${1:?usage: test_capsule_dead_strip_guard.sh <compiler-binary>}"
BINARY="$(realpath "$BINARY")"
PASS=0
FAIL=0

if ! command -v nm >/dev/null 2>&1; then
    echo "[test] SKIP: nm not installed (required for symbol inspection)" >&2
    exit 0
fi

SCRATCH="$(mktemp -d -t sfn-dead-strip-guard-XXXXXX)"
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

# ---- Setup: a consumer importing ONLY abs from the multi-fn sfn/math ----
mkdir -p "$SCRATCH/src"

# Link (rather than copy) the in-tree capsules/ dir so the resolver's
# in-tree lookup finds sfn/math without needing the user cache.
ln -s "$REPO_ROOT/capsules" "$SCRATCH/capsules"

cat > "$SCRATCH/capsule.toml" <<'EOF'
[capsule]
name = "dead-strip-guard"
version = "0.1.0"
description = "Closure-bloat guard: one symbol from a multi-fn capsule"

[dependencies]
"sfn/math" = "0.1.0"

[capabilities]
required = ["io"]

[build]
entry = "src/main.sfn"
EOF

# Import a SINGLE symbol. `clamp`, `mean`, `pow`, `sign`, ... are never
# referenced, so a correct dead-strip must collect them.
cat > "$SCRATCH/src/main.sfn" <<'EOF'
import { abs } from "sfn/math";

fn main() ![io] {
    let a = abs(-7);
    if a != 7 {
        print("FAIL abs(-7)");
    } else {
        print("OK");
    }
}
EOF

BUILD_LOG="$SCRATCH/build.log"

build_consumer() {
    cd "$SCRATCH" || return 1
    local rc=0
    "$BINARY" build -o build/program src/main.sfn > "$BUILD_LOG" 2>&1 || rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   sfn build exited with code $rc; output:" >&2
        tail -40 "$BUILD_LOG" >&2
    fi
    return $rc
}

# ---- Test 1: the consumer builds and runs ----
test_build_and_run() {
    build_consumer || return 1
    [ -x "$SCRATCH/build/program" ] || return 1
    local rc=0
    "$SCRATCH/build/program" > "$SCRATCH/program.stdout" 2>&1 || rc=$?
    if [ "$rc" -ne 0 ]; then
        echo "[test]   binary exited with code $rc; output:" >&2
        cat "$SCRATCH/program.stdout" >&2
        return 1
    fi
    grep -q "^OK$" "$SCRATCH/program.stdout"
}
run_test "consumer importing one capsule symbol builds and runs" test_build_and_run

# Capsule functions lower to LLVM symbols mangled `<fn>__sfn__<scope>__<mod>`
# (e.g. `abs__sfn__math__mod`). Matching the full mangled suffix keeps the
# assertions precise — no false hits from unrelated symbols that happen to
# contain a substring like `abs` or `mean`.
MANGLE_SUFFIX="__sfn__math__mod"

# Match a *defined* capsule function symbol in `nm` output, precisely:
#   - ` [Tt] ` — a defined symbol in the text section (external `T` or
#     local `t`); anything else (undefined `U`, data, etc.) is ignored.
#   - `_?`    — ld64 on Darwin prefixes user symbols with a leading
#     underscore (`_abs__…`); GNU nm on Linux does not. Tolerate both.
#   - `…$`    — anchor at end-of-line so the whole mangled name must match,
#     not a substring of some longer symbol.
# Args: <symbol-table-dump> <bare-fn-name>
symbol_defined() {
    printf '%s\n' "$1" | grep -qE "[[:space:]][Tt][[:space:]]_?${2}${MANGLE_SUFFIX}$"
}

# ---- Test 2: the USED symbol survives (sanity: the dep really linked) ----
# Without this check the absence assertions in Test 3 could pass
# vacuously if the whole capsule failed to link or got dropped.
# Capture the symbol table once. Capturing into a variable (rather than
# piping `nm | grep -q`) is deliberate: under `set -o pipefail`, `grep -q`
# closes the pipe on its first match and `nm` dies with SIGPIPE, which would
# make the *pipeline* report failure even on a successful match (and, worse,
# would make a leak check silently miss a present symbol). Grepping a
# captured string sidesteps the early-close entirely.
dump_symbols() {
    nm "$SCRATCH/build/program" 2>/dev/null || true
}

test_used_symbol_present() {
    [ -x "$SCRATCH/build/program" ] || { echo "[test]   no binary to inspect" >&2; return 1; }
    local syms
    syms="$(dump_symbols)"
    if ! symbol_defined "$syms" "abs"; then
        echo "[test]   used symbol 'abs${MANGLE_SUFFIX}' missing from binary — capsule did not link?" >&2
        printf '%s\n' "$syms" | grep -i "$MANGLE_SUFFIX" >&2 || true
        return 1
    fi
    return 0
}
run_test "used capsule symbol (abs) is present in the linked binary" test_used_symbol_present

# ---- Test 3: unreferenced sibling symbols are dead-stripped (#1047) ----
# `clamp` and `mean` are never reachable from `abs`; a correct
# dead-strip drops them. If #1047's strip flags regress, these
# functions reappear and this assertion fails.
test_unreferenced_symbols_stripped() {
    [ -x "$SCRATCH/build/program" ] || { echo "[test]   no binary to inspect" >&2; return 1; }
    local syms
    syms="$(dump_symbols)"
    local leaked=""
    for sym in clamp mean; do
        if symbol_defined "$syms" "$sym"; then
            leaked="$leaked $sym"
        fi
    done
    if [ -n "$leaked" ]; then
        echo "[test]   unreferenced sfn/math symbol(s) leaked into binary:$leaked" >&2
        echo "[test]   (dead-strip regressed — see #1047 / #1050)" >&2
        printf '%s\n' "$syms" | grep -i "$MANGLE_SUFFIX" >&2 || true
        return 1
    fi
    return 0
}
run_test "unreferenced capsule symbols (clamp, mean) are stripped" test_unreferenced_symbols_stripped

# ---- Summary ----
echo ""
echo "[test] $PASS passed, $FAIL failed"
[ "$FAIL" -eq 0 ]
