#!/usr/bin/env bash
# diag_valgrind_sweep.sh — Parallel Valgrind memcheck sweep on the actual -O2
# seed binary. No recompilation — instruments the binary at runtime. Catches
# invalid reads/writes, use-after-free, and uninitialised value use.
#
# Lower parallelism than unsanitized sweeps due to ~10-20x valgrind slowdown.
#
# Usage:
#   scripts/diag_valgrind_sweep.sh [--seed PATH] [--jobs N] [--iters N]
#
# Defaults: --seed build/native/sailfin  --jobs 4  --iters 3
# Output:   /tmp/sailfin-diag-vg/logs/*.vg  (one per invocation)
#           /tmp/sailfin-diag-vg/results.tsv

set -u
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SEED="${SEED:-$REPO_ROOT/build/native/sailfin}"
PAR=4
ITERS=3

while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed)  SEED="$2"; shift 2 ;;
        --jobs)  PAR="$2"; shift 2 ;;
        --iters) ITERS="$2"; shift 2 ;;
        *) echo "unknown option: $1" >&2; exit 2 ;;
    esac
done

command -v valgrind >/dev/null 2>&1 || { echo "valgrind not found on PATH" >&2; exit 2; }
[[ -x "$SEED" ]]         || { echo "missing seed: $SEED" >&2; exit 2; }

OUT_DIR="/tmp/sailfin-diag-vg/out"
LOG_DIR="/tmp/sailfin-diag-vg/logs"
IMPORT_CACHE="$REPO_ROOT/build/native/import-context"

[[ -d "$IMPORT_CACHE" ]] || { echo "missing import-context (run make compile first)" >&2; exit 2; }

rm -rf /tmp/sailfin-diag-vg
mkdir -p "$OUT_DIR" "$LOG_DIR"

do_module() {
    local src="$1"
    local rel="${src#$REPO_ROOT/}"
    local slug="${rel#compiler/src/}"
    slug="${slug#runtime/}"
    slug="${slug%.sfn}"
    [[ "$rel" == runtime/* ]] && slug="runtime/$slug"
    local safe
    safe=$(echo "$slug" | tr '/' '_')

    local mod_cwd="/tmp/sailfin-diag-vg/cwd/$safe"
    rm -rf "$mod_cwd"
    mkdir -p "$mod_cwd/build/native"
    cp -a "$IMPORT_CACHE" "$mod_cwd/build/native/import-context"
    rm -f "$mod_cwd/build/native/import-context/${slug}.sfn-asm" \
          "$mod_cwd/build/native/import-context/${slug}.layout-manifest"

    local hashes="" sizes=""
    for (( k=1; k<=ITERS; k++ )); do
        rm -rf "$mod_cwd/build/sailfin"
        mkdir -p "$mod_cwd/build/sailfin"
        local out="$OUT_DIR/${safe}.iter${k}.ll"
        local vg_log="$LOG_DIR/${safe}.iter${k}.vg"
        ( ulimit -v 16777216 2>/dev/null || true  # 16GB for valgrind overhead
          cd "$mod_cwd" || exit 99
          timeout 600 valgrind \
              --tool=memcheck \
              --track-origins=yes \
              --undef-value-errors=yes \
              --log-file="$vg_log" \
              --error-exitcode=0 \
              "$SEED" emit -o "$out" llvm "$src"
        ) 2>/dev/null
        local sz=0 h="EMPTY"
        if [[ -s "$out" ]]; then
            sz=$(stat -c%s "$out" 2>/dev/null || stat -f%z "$out" 2>/dev/null || echo 0)
            h=$(sha256sum "$out" 2>/dev/null | awk '{print $1}' || shasum -a 256 "$out" | awk '{print $1}')
        fi
        hashes="$hashes $h"; sizes="$sizes $sz"
    done
    local distinct
    distinct=$(echo "$hashes" | tr ' ' '\n' | grep -v '^$' | LC_ALL=C sort -u | wc -l)
    printf '%s\t%d\t%s\n' "$slug" "$distinct" "$sizes"
}
export -f do_module
export REPO_ROOT SEED OUT_DIR IMPORT_CACHE ITERS LOG_DIR

mapfile -t SOURCES < <(find "$REPO_ROOT/compiler/src" "$REPO_ROOT/runtime" -name '*.sfn' -print | LC_ALL=C sort)
echo "[vg-sweep] seed=$SEED modules=${#SOURCES[@]} jobs=$PAR iters=$ITERS" >&2

printf 'module\tdistinct\tsizes\n' > /tmp/sailfin-diag-vg/results.tsv
printf '%s\n' "${SOURCES[@]}" | xargs -P "$PAR" -I {} bash -c 'do_module "$@"' _ {} >> /tmp/sailfin-diag-vg/results.tsv

echo "[vg-sweep] done" >&2
echo "" >&2
echo "=== non-deterministic modules ===" >&2
awk -F'\t' 'NR>1 && $2 > 1 {print}' /tmp/sailfin-diag-vg/results.tsv >&2

VG_ERRORS=0; VG_UNINIT=0
for f in "$LOG_DIR"/*.vg; do
    [[ -f "$f" ]] || continue
    grep -q "ERROR SUMMARY: [1-9]" "$f" 2>/dev/null && VG_ERRORS=$((VG_ERRORS+1))
    grep -q "Uninitialised\|uninitialised\|uninitialized" "$f" 2>/dev/null && VG_UNINIT=$((VG_UNINIT+1))
done
echo "" >&2
echo "=== Valgrind: $VG_ERRORS logs with errors, $VG_UNINIT with uninit warnings ===" >&2

if [[ "$VG_ERRORS" -gt 0 ]]; then
    echo "--- unique error signatures ---" >&2
    for f in "$LOG_DIR"/*.vg; do
        grep "Invalid read\|Invalid write\|Use of uninitialised\|Conditional jump.*uninitialised" "$f" 2>/dev/null
    done | sort -u | head -20 >&2
    echo "" >&2
    echo "--- first log with errors ---" >&2
    first_err=$(grep -l "ERROR SUMMARY: [1-9]" "$LOG_DIR"/*.vg | head -1)
    grep -A2 "ERROR SUMMARY\|Invalid read\|Invalid write\|Uninitialised" "$first_err" | head -40 >&2
fi
