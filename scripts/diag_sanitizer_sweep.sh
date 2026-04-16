#!/usr/bin/env bash
# diag_sanitizer_sweep.sh — Parallel sweep using an ASan/MSan-instrumented seed.
# Combines the ASan and MSan sweep workflows into one script.
#
# Prerequisites: build the sanitized seed first:
#   SANITIZE=asan,ubsan bash scripts/build.sh --out build/native/sailfin-asan --work-dir build/selfhost/native-asan
#   SANITIZE=msan       bash scripts/build.sh --out build/native/sailfin-msan --work-dir build/selfhost/native-msan
#
# Usage:
#   scripts/diag_sanitizer_sweep.sh --seed build/native/sailfin-asan --sanitizer asan [--jobs N] [--iters N]
#   scripts/diag_sanitizer_sweep.sh --seed build/native/sailfin-msan --sanitizer msan [--jobs N] [--iters N]
#
# Defaults: --jobs 4  --iters 5
# Output:   /tmp/sailfin-diag-san/logs/  (per-process sanitizer reports)
#           /tmp/sailfin-diag-san/results.tsv

set -u
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
SEED=""
SANITIZER=""
PAR=4
ITERS=5

while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed)      SEED="$2"; shift 2 ;;
        --sanitizer) SANITIZER="$2"; shift 2 ;;
        --jobs)      PAR="$2"; shift 2 ;;
        --iters)     ITERS="$2"; shift 2 ;;
        *) echo "unknown option: $1" >&2; exit 2 ;;
    esac
done

[[ -n "$SEED" ]]      || { echo "--seed PATH is required" >&2; exit 2; }
[[ -x "$SEED" ]]      || { echo "seed not found or not executable: $SEED" >&2; exit 2; }
[[ -n "$SANITIZER" ]]  || { echo "--sanitizer asan|msan is required" >&2; exit 2; }

OUT_DIR="/tmp/sailfin-diag-san/out"
LOG_DIR="/tmp/sailfin-diag-san/logs"
IMPORT_CACHE="$REPO_ROOT/build/native/import-context"

[[ -d "$IMPORT_CACHE" ]] || { echo "missing import-context (run make compile first)" >&2; exit 2; }

rm -rf /tmp/sailfin-diag-san
mkdir -p "$OUT_DIR" "$LOG_DIR"

case "$SANITIZER" in
    asan)
        export ASAN_OPTIONS="detect_leaks=0:halt_on_error=0:abort_on_error=0:print_summary=1:log_path=$LOG_DIR/asan:print_stats=0:allocator_may_return_null=1:handle_segv=1:color=never"
        export UBSAN_OPTIONS="print_stacktrace=1:halt_on_error=0:log_path=$LOG_DIR/ubsan:color=never"
        ;;
    msan)
        export MSAN_OPTIONS="halt_on_error=0:print_stats=0:log_path=$LOG_DIR/msan:color=never:exit_code=0"
        ;;
    *) echo "unknown sanitizer: $SANITIZER (want asan or msan)" >&2; exit 2 ;;
esac

do_module() {
    local src="$1"
    local rel="${src#$REPO_ROOT/}"
    local slug="${rel#compiler/src/}"
    slug="${slug#runtime/}"
    slug="${slug%.sfn}"
    [[ "$rel" == runtime/* ]] && slug="runtime/$slug"
    local safe
    safe=$(echo "$slug" | tr '/' '_')

    local mod_cwd="/tmp/sailfin-diag-san/cwd/$safe"
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
        ( cd "$mod_cwd" || exit 99
          timeout 180 "$SEED" emit -o "$out" llvm "$src"
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
echo "[san-sweep] seed=$SEED sanitizer=$SANITIZER modules=${#SOURCES[@]} jobs=$PAR iters=$ITERS" >&2

printf 'module\tdistinct\tsizes\n' > /tmp/sailfin-diag-san/results.tsv
printf '%s\n' "${SOURCES[@]}" | xargs -P "$PAR" -I {} bash -c 'do_module "$@"' _ {} >> /tmp/sailfin-diag-san/results.tsv

echo "[san-sweep] done" >&2
echo "" >&2
echo "=== non-deterministic modules ===" >&2
awk -F'\t' 'NR>1 && $2 > 1 {print}' /tmp/sailfin-diag-san/results.tsv >&2

SAN_FILES=$(ls "$LOG_DIR"/${SANITIZER}.* "$LOG_DIR"/ubsan.* 2>/dev/null | wc -l)
echo "" >&2
echo "=== Sanitizer report files: $SAN_FILES ===" >&2
if [[ "$SAN_FILES" -gt 0 ]]; then
    echo "--- unique report signatures ---" >&2
    for f in "$LOG_DIR"/${SANITIZER}.* "$LOG_DIR"/ubsan.* 2>/dev/null; do
        [[ -f "$f" ]] && grep -m1 "Uninitialized\|use-of-uninitialized\|Invalid\|ERROR" "$f" 2>/dev/null
    done | sort -u | head -20 >&2

    RUNTIME_HITS=$(grep -l "sailfin_runtime\|sailfin_adapter\|string_concat\|array_push" "$LOG_DIR"/${SANITIZER}.* 2>/dev/null | wc -l)
    echo "=== Reports mentioning sailfin runtime: $RUNTIME_HITS ===" >&2
fi
