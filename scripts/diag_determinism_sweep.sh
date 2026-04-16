#!/usr/bin/env bash
# diag_determinism_sweep.sh — Run `emit llvm` N times per module across all
# source files. Hash every output. Any module producing more than one distinct
# hash is a candidate corruption site.
#
# This is the primary repro harness for the intermittent IR corruption bug.
# Run at P=4-8 to stress heap layout; corruption only manifests under
# concurrent load (single-module isolation is always clean).
#
# Usage:
#   scripts/diag_determinism_sweep.sh [--seed PATH] [--jobs N] [--iters N]
#
# Defaults: --seed build/native/sailfin  --jobs 4  --iters 10
# Output:   /tmp/sailfin-diag-det/results.tsv + per-module .ll files

set -u
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SEED="${SEED:-$REPO_ROOT/build/native/sailfin}"
PAR=4
ITERS=10

while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed)  SEED="$2"; shift 2 ;;
        --jobs)  PAR="$2"; shift 2 ;;
        --iters) ITERS="$2"; shift 2 ;;
        *) echo "unknown option: $1" >&2; exit 2 ;;
    esac
done

OUT_DIR="/tmp/sailfin-diag-det/out"
IMPORT_CACHE="$REPO_ROOT/build/native/import-context"

[[ -x "$SEED" ]]         || { echo "missing seed: $SEED" >&2; exit 2; }
[[ -d "$IMPORT_CACHE" ]] || { echo "missing import-context (run make compile first)" >&2; exit 2; }

rm -rf /tmp/sailfin-diag-det
mkdir -p "$OUT_DIR"

do_module() {
    local src="$1"
    local rel="${src#$REPO_ROOT/}"
    local slug="${rel#compiler/src/}"
    slug="${slug#runtime/}"
    slug="${slug%.sfn}"
    [[ "$rel" == runtime/* ]] && slug="runtime/$slug"
    local safe
    safe=$(echo "$slug" | tr '/' '_')

    local mod_cwd="/tmp/sailfin-diag-det/cwd/$safe"
    rm -rf "$mod_cwd"
    mkdir -p "$mod_cwd/build/native"
    cp -a "$IMPORT_CACHE" "$mod_cwd/build/native/import-context"
    rm -f "$mod_cwd/build/native/import-context/${slug}.sfn-asm" \
          "$mod_cwd/build/native/import-context/${slug}.layout-manifest"

    local hashes="" sizes="" nonascii_total=0
    for (( k=1; k<=ITERS; k++ )); do
        rm -rf "$mod_cwd/build/sailfin"
        mkdir -p "$mod_cwd/build/sailfin"
        local out="$OUT_DIR/${safe}.iter${k}.ll"
        ( ulimit -v 8388608 2>/dev/null || true
          cd "$mod_cwd" || exit 99
          timeout 60 "$SEED" emit -o "$out" llvm "$src"
        ) 2>/dev/null
        local sz=0 h="EMPTY"
        if [[ -s "$out" ]]; then
            sz=$(stat -c%s "$out" 2>/dev/null || stat -f%z "$out" 2>/dev/null || echo 0)
            h=$(sha256sum "$out" 2>/dev/null | awk '{print $1}' || shasum -a 256 "$out" | awk '{print $1}')
            local na; na=$(tr -d '\000-\177' < "$out" | wc -c)
            nonascii_total=$((nonascii_total + na))
        fi
        hashes="$hashes $h"; sizes="$sizes $sz"
    done
    local distinct
    distinct=$(echo "$hashes" | tr ' ' '\n' | grep -v '^$' | LC_ALL=C sort -u | wc -l)
    printf '%s\t%d\t%d\t%s\n' "$slug" "$distinct" "$nonascii_total" "$sizes"
}
export -f do_module
export REPO_ROOT SEED OUT_DIR IMPORT_CACHE ITERS

mapfile -t SOURCES < <(find "$REPO_ROOT/compiler/src" "$REPO_ROOT/runtime" -name '*.sfn' -print | LC_ALL=C sort)
echo "[det-sweep] seed=$SEED modules=${#SOURCES[@]} jobs=$PAR iters=$ITERS" >&2

printf 'module\tdistinct\tnonascii_total\tsizes\n' > /tmp/sailfin-diag-det/results.tsv
printf '%s\n' "${SOURCES[@]}" | xargs -P "$PAR" -I {} bash -c 'do_module "$@"' _ {} >> /tmp/sailfin-diag-det/results.tsv

echo "[det-sweep] done" >&2
echo "" >&2
echo "=== modules with distinct > 1 (non-deterministic) ===" >&2
awk -F'\t' 'NR>1 && $2 > 1 {print}' /tmp/sailfin-diag-det/results.tsv >&2
echo "" >&2
echo "=== modules with nonascii_total > 0 ===" >&2
awk -F'\t' 'NR>1 && $3 > 0 {print}' /tmp/sailfin-diag-det/results.tsv >&2
echo "" >&2
total_nondet=$(awk -F'\t' 'NR>1 && $2 > 1 {c++} END{print c+0}' /tmp/sailfin-diag-det/results.tsv)
total_nonascii=$(awk -F'\t' 'NR>1 && $3 > 0 {c++} END{print c+0}' /tmp/sailfin-diag-det/results.tsv)
echo "totals: non-deterministic=$total_nondet nonascii=$total_nonascii" >&2
