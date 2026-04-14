#!/usr/bin/env bash
# diag_emit_harness.sh — Hammer `sailfin emit llvm` on a single module and
# record per-iteration outcome (exit, sha256, size, llvm-as parse status, byte
# positions of any non-ASCII bytes).
#
# Replicates the isolation pattern in scripts/build.sh:build_module (staged
# import-context, self-artifact removed, clean build/sailfin IPC dir per run).
#
# Usage:
#   scripts/diag_emit_harness.sh <src-relative-to-repo> <module-name> [iterations] [--seed PATH]
#
# Example:
#   scripts/diag_emit_harness.sh compiler/src/llvm/effects.sfn llvm__effects 200
#   scripts/diag_emit_harness.sh compiler/src/llvm/effects.sfn llvm__effects 100 --seed build/native/sailfin-fixed

set -u
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

SRC_REL="${1:-}"
MODULE="${2:-}"
ITERS="${3:-200}"
SEED="${SEED:-$REPO_ROOT/build/native/sailfin}"

# Parse optional --seed from remaining args
shift 3 2>/dev/null || true
while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed) SEED="$2"; shift 2 ;;
        *) echo "unknown option: $1" >&2; exit 2 ;;
    esac
done

if [[ -z "$SRC_REL" || -z "$MODULE" ]]; then
    echo "usage: $0 <src-relative-to-repo> <module-name> [iterations] [--seed PATH]" >&2
    exit 2
fi

SRC_ABS="$REPO_ROOT/$SRC_REL"
IMPORT_CACHE="$REPO_ROOT/build/native/import-context"
WORK_ROOT="/tmp/sailfin-diag-emit/$MODULE"
MODULE_CWD="$WORK_ROOT/seed_cwd"
RESULTS="$WORK_ROOT/results.tsv"

[[ -x "$SEED" ]]             || { echo "missing seed: $SEED" >&2; exit 2; }
[[ -f "$SRC_ABS" ]]          || { echo "missing source: $SRC_ABS" >&2; exit 2; }
[[ -d "$IMPORT_CACHE" ]]     || { echo "missing import-context: $IMPORT_CACHE (run make compile first)" >&2; exit 2; }

SLUG="${SRC_REL#compiler/src/}"
SLUG="${SLUG#runtime/}"
SLUG="${SLUG%.sfn}"
[[ "$SRC_REL" == runtime/* ]] && SLUG="runtime/$SLUG"

echo "[harness] module=$MODULE src=$SRC_REL slug=$SLUG iters=$ITERS" >&2
echo "[harness] seed=$SEED" >&2

mkdir -p "$WORK_ROOT"
rm -f "$RESULTS"
printf 'iter\texit\tsize\tsha256\tllvm_as\tnon_ascii_count\tfirst_bad_offset\n' > "$RESULTS"

LLVM_AS=""
for cand in llvm-as llvm-as-{18..14}; do
    command -v "$cand" >/dev/null 2>&1 && { LLVM_AS="$cand"; break; }
done
echo "[harness] llvm-as: ${LLVM_AS:-<none, will skip parse check>}" >&2

rm -rf "$MODULE_CWD"
mkdir -p "$MODULE_CWD/build/native"
cp -a "$IMPORT_CACHE" "$MODULE_CWD/build/native/import-context"
rm -f "$MODULE_CWD/build/native/import-context/${SLUG}.sfn-asm" \
      "$MODULE_CWD/build/native/import-context/${SLUG}.layout-manifest"

PASS=0; FAIL_EMIT=0; FAIL_PARSE=0
HASHES_FILE="$WORK_ROOT/hashes.txt"
: > "$HASHES_FILE"

for (( i=1; i<=ITERS; i++ )); do
    rm -rf "$MODULE_CWD/build/sailfin"
    mkdir -p "$MODULE_CWD/build/sailfin"

    OUT_LL="$WORK_ROOT/out.$i.ll"
    OUT_ERR="$WORK_ROOT/out.$i.stderr"
    rm -f "$OUT_LL" "$OUT_ERR"

    ( ulimit -v 8388608 2>/dev/null || true
      cd "$MODULE_CWD" || exit 99
      timeout 60 "$SEED" emit -o "$OUT_LL" llvm "$SRC_ABS"
    ) 2>"$OUT_ERR"
    EXIT=$?

    if [[ -s "$OUT_LL" ]]; then
        SIZE=$(stat -c%s "$OUT_LL" 2>/dev/null || stat -f%z "$OUT_LL" 2>/dev/null || echo 0)
        SHA=$(sha256sum "$OUT_LL" 2>/dev/null | awk '{print $1}' || shasum -a 256 "$OUT_LL" | awk '{print $1}')
    else
        SIZE=0; SHA="EMPTY"
    fi

    NON_ASCII=0; FIRST_BAD=-1
    if [[ "$SIZE" -gt 0 ]]; then
        NON_ASCII=$(tr -d '\000-\177' < "$OUT_LL" | wc -c)
        if [[ "$NON_ASCII" -gt 0 ]]; then
            FIRST_BAD=$(LC_ALL=C grep -oba '[^\x00-\x7f]' "$OUT_LL" 2>/dev/null | head -1 | cut -d: -f1)
            [[ -z "$FIRST_BAD" ]] && FIRST_BAD=-1
        fi
    fi

    PARSE="skip"
    if [[ -n "$LLVM_AS" && "$SIZE" -gt 0 ]]; then
        "$LLVM_AS" -disable-output "$OUT_LL" >/dev/null 2>&1 && PARSE="ok" || PARSE="fail"
    fi

    printf '%d\t%d\t%d\t%s\t%s\t%d\t%s\n' "$i" "$EXIT" "$SIZE" "$SHA" "$PARSE" "$NON_ASCII" "$FIRST_BAD" >> "$RESULTS"
    echo "$SHA" >> "$HASHES_FILE"

    if [[ "$EXIT" -ne 0 || "$PARSE" == "fail" || "$NON_ASCII" -gt 0 ]]; then
        [[ "$EXIT" -ne 0 || "$SIZE" -eq 0 ]] && FAIL_EMIT=$((FAIL_EMIT+1))
        [[ "$PARSE" == "fail" || "$NON_ASCII" -gt 0 ]] && FAIL_PARSE=$((FAIL_PARSE+1))
    else
        PASS=$((PASS+1)); rm -f "$OUT_LL"
    fi
    [[ ! -s "$OUT_ERR" ]] && rm -f "$OUT_ERR"
    (( i % 25 == 0 )) && echo "[harness] $i/$ITERS  pass=$PASS emit_fail=$FAIL_EMIT parse_fail=$FAIL_PARSE" >&2
done

DISTINCT=$(grep -v '^EMPTY$' "$HASHES_FILE" | LC_ALL=C sort -u | wc -l)
TOP=$(grep -v '^EMPTY$' "$HASHES_FILE" | LC_ALL=C sort | uniq -c | LC_ALL=C sort -rn | head -5)

{
    echo "module:       $MODULE"
    echo "iterations:   $ITERS"
    echo "seed:         $SEED"
    echo "pass:         $PASS"
    echo "emit_fail:    $FAIL_EMIT   (exit!=0 or empty output)"
    echo "parse_fail:   $FAIL_PARSE  (llvm-as failed or non-ascii bytes present)"
    echo "distinct hashes: $DISTINCT (1 = deterministic)"
    echo ""
    echo "top hash buckets:"
    echo "$TOP"
} | tee "$WORK_ROOT/summary.txt" >&2
