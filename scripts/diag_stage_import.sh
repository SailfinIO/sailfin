#!/usr/bin/env bash
# diag_stage_import.sh — Run `seed emit native <src>` N times per module and
# verify each output is byte-identical. Non-determinism here means corruption
# in the stage_import_context step (the .sfn-asm generation path).
#
# Usage:
#   scripts/diag_stage_import.sh [--seed PATH] [--iters N]
#
# Defaults: --seed build/native/sailfin  --iters 3

set -u
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SEED="${SEED:-$REPO_ROOT/build/native/sailfin}"
ITERS=3

while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed)  SEED="$2"; shift 2 ;;
        --iters) ITERS="$2"; shift 2 ;;
        *) echo "unknown option: $1" >&2; exit 2 ;;
    esac
done

[[ -x "$SEED" ]] || { echo "missing seed: $SEED" >&2; exit 2; }

OUT_DIR="/tmp/sailfin-diag-stage/iters"
RESULTS="/tmp/sailfin-diag-stage/results.tsv"
SUMMARY="/tmp/sailfin-diag-stage/summary.txt"

rm -rf /tmp/sailfin-diag-stage
mkdir -p "$OUT_DIR"
printf 'module\tdistinct_hashes\tsizes\n' > "$RESULTS"

mapfile -t SOURCES < <(find "$REPO_ROOT/compiler/src" "$REPO_ROOT/runtime" -name '*.sfn' -print | LC_ALL=C sort)
echo "[stage-diag] seed=$SEED iters=$ITERS modules=${#SOURCES[@]}" >&2

BAD_MODULES=0

for src in "${SOURCES[@]}"; do
    rel="${src#$REPO_ROOT/}"
    slug="${rel#compiler/src/}"
    slug="${slug#runtime/}"
    slug="${slug%.sfn}"
    [[ "$rel" == runtime/* ]] && slug="runtime/$slug"
    safe=$(echo "$slug" | tr '/' '_')
    mkdir -p "$OUT_DIR/$safe"

    HASHES="" SIZES=""
    for (( i=1; i<=ITERS; i++ )); do
        out="$OUT_DIR/$safe/iter.$i.asm"
        ( ulimit -v 8388608 2>/dev/null || true
          timeout 60 "$SEED" emit native "$src"
        ) > "$out" 2>/dev/null
        sz=$(stat -c%s "$out" 2>/dev/null || stat -f%z "$out" 2>/dev/null || echo 0)
        h="EMPTY"
        [[ "$sz" -gt 0 ]] && h=$(sha256sum "$out" 2>/dev/null | awk '{print $1}' || shasum -a 256 "$out" | awk '{print $1}')
        HASHES="$HASHES $h"; SIZES="$SIZES $sz"
    done

    distinct=$(echo "$HASHES" | tr ' ' '\n' | grep -v '^$' | LC_ALL=C sort -u | wc -l)
    printf '%s\t%d\t%s\n' "$slug" "$distinct" "$SIZES" >> "$RESULTS"

    if [[ "$distinct" -gt 1 ]]; then
        BAD_MODULES=$((BAD_MODULES+1))
        echo "[stage-diag] NON-DETERMINISTIC: $slug distinct=$distinct sizes=$SIZES" >&2
    fi
done

{
    echo "stage_import determinism check"
    echo "modules:            ${#SOURCES[@]}"
    echo "iterations/module:  $ITERS"
    echo "non-deterministic:  $BAD_MODULES"
    echo ""
    if [[ "$BAD_MODULES" -gt 0 ]]; then
        echo "Divergent modules:"
        awk -F'\t' '$2 > 1 {print "  " $1 " (distinct=" $2 ", sizes=" $3 ")"}' "$RESULTS"
    fi
} | tee "$SUMMARY" >&2
