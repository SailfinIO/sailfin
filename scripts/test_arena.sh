#!/usr/bin/env bash
set -euo pipefail

# test_arena.sh — Verify that SAILFIN_USE_ARENA=1 produces byte-identical
# LLVM IR to the baseline (no-arena) compilation of a given module.
#
# This is the correctness gate for the Phase 0 arena allocator. Before the
# arena is implemented, the env var is a no-op and the two outputs will
# trivially match — the harness itself is still valid. Once the arena lands,
# any divergence means the allocator is corrupting compiler output and must
# be fixed before further arena work proceeds.
#
# Usage:
#   bash scripts/test_arena.sh                                # hello-world.sfn
#   bash scripts/test_arena.sh examples/basics/functions.sfn  # specific module
#   bash scripts/test_arena.sh --all                          # all basics/

SEED="${SEED:-build/native/sailfin}"
WORK_DIR="${WORK_DIR:-build/arena-test}"
IMPORT_CONTEXT="${IMPORT_CONTEXT:-build/native/import-context}"

# ---------------------------------------------------------------------------
# Arg parsing
# ---------------------------------------------------------------------------

MODULES=()
if [[ $# -eq 0 ]]; then
    MODULES=("examples/basics/hello-world.sfn")
elif [[ "${1:-}" == "--all" ]]; then
    while IFS= read -r f; do
        MODULES+=("$f")
    done < <(find examples/basics -maxdepth 1 -name '*.sfn' | sort)
else
    MODULES=("$@")
fi

# ---------------------------------------------------------------------------
# Validate environment
# ---------------------------------------------------------------------------

if [[ ! -x "$SEED" ]]; then
    echo "[test-arena] error: seed not found at $SEED" >&2
    echo "[test-arena] hint: run 'make compile' first" >&2
    exit 1
fi

if [[ ! -d "$IMPORT_CONTEXT" ]]; then
    echo "[test-arena] error: import-context not found at $IMPORT_CONTEXT" >&2
    echo "[test-arena] hint: run 'make compile' first" >&2
    exit 1
fi

REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
ABS_SEED="$(cd "$(dirname "$SEED")" && echo "$(pwd)/$(basename "$SEED")")"
ABS_IC="$(cd "$IMPORT_CONTEXT" && pwd)"

mkdir -p "$WORK_DIR"

# ---------------------------------------------------------------------------
# Compile one module twice (no-arena, with-arena) and diff
# ---------------------------------------------------------------------------

compile_once() {
    local src="$1"
    local mode="$2"          # "no_arena" or "with_arena"
    local module_cwd="$3"
    local out_ll="$4"
    local stderr_log="$5"

    mkdir -p "$module_cwd/build/native" "$module_cwd/build/sailfin"
    rm -rf "$module_cwd/build/native/import-context"
    cp -a "$ABS_IC" "$module_cwd/build/native/import-context"

    local abs_src
    abs_src="$(cd "$REPO_ROOT" && realpath "$src")"

    if [[ "$mode" == "with_arena" ]]; then
        (cd "$module_cwd" && SAILFIN_USE_ARENA=1 "$ABS_SEED" emit -o "$out_ll" llvm "$abs_src") 2>"$stderr_log"
    else
        (cd "$module_cwd" && "$ABS_SEED" emit -o "$out_ll" llvm "$abs_src") 2>"$stderr_log"
    fi
}

check_module() {
    local src="$1"
    local name
    name="$(basename "${src%.sfn}")"

    local base="$WORK_DIR/$name"
    rm -rf "$base"
    mkdir -p "$base/no_arena" "$base/with_arena"

    local no_ll="$base/no_arena.ll"
    local yes_ll="$base/with_arena.ll"
    local no_err="$base/no_arena.stderr"
    local yes_err="$base/with_arena.stderr"

    compile_once "$src" "no_arena"   "$base/no_arena"   "$no_ll"  "$no_err"  || {
        echo "[test-arena] FAIL (no-arena compile failed): $src"
        tail -20 "$no_err" >&2 || true
        return 1
    }
    compile_once "$src" "with_arena" "$base/with_arena" "$yes_ll" "$yes_err" || {
        echo "[test-arena] FAIL (with-arena compile failed): $src"
        tail -20 "$yes_err" >&2 || true
        return 1
    }

    if ! [[ -s "$no_ll" ]]; then
        echo "[test-arena] FAIL: no-arena output empty/missing for $src"
        return 1
    fi
    if ! [[ -s "$yes_ll" ]]; then
        echo "[test-arena] FAIL: with-arena output empty/missing for $src"
        return 1
    fi

    if diff -q "$no_ll" "$yes_ll" > /dev/null; then
        local bytes
        bytes="$(wc -c < "$no_ll")"
        echo "[test-arena] PASS: $src (${bytes} bytes identical)"
        return 0
    else
        echo "[test-arena] FAIL: $src LLVM IR differs with/without SAILFIN_USE_ARENA"
        echo "[test-arena]   no-arena: $no_ll"
        echo "[test-arena]   arena:    $yes_ll"
        echo "[test-arena]   first 30 lines of diff:"
        diff "$no_ll" "$yes_ll" | head -30 | sed 's/^/    /'
        return 1
    fi
}

# ---------------------------------------------------------------------------
# Run across all requested modules
# ---------------------------------------------------------------------------

echo "[test-arena] seed: $SEED"
echo "[test-arena] import-context: $IMPORT_CONTEXT"
echo "[test-arena] modules: ${#MODULES[@]}"
echo ""

pass=0
fail=0
for m in "${MODULES[@]}"; do
    if check_module "$m"; then
        pass=$((pass + 1))
    else
        fail=$((fail + 1))
    fi
done

echo ""
echo "[test-arena] summary: $pass passed, $fail failed (of ${#MODULES[@]})"
exit $(( fail > 0 ? 1 : 0 ))
