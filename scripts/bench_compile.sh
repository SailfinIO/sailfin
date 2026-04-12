#!/usr/bin/env bash
set -euo pipefail

# bench_compile.sh — Benchmark compiler build performance.
#
# Measures per-module compile time and peak memory for a set of representative
# modules (or all modules). Outputs a summary table and optionally writes CSV
# for tracking regressions.
#
# Usage:
#   bash scripts/bench_compile.sh                    # benchmark all modules
#   bash scripts/bench_compile.sh --top 10           # benchmark 10 heaviest
#   bash scripts/bench_compile.sh --module emit_native --module parser/mod
#   bash scripts/bench_compile.sh --csv build/bench.csv
#   bash scripts/bench_compile.sh --budget-time 60 --budget-mem 512000

SEED="${SEED:-build/native/sailfin}"
WORK_DIR="${WORK_DIR:-build/bench}"
IMPORT_CONTEXT="${IMPORT_CONTEXT:-build/native/import-context}"
CSV_OUT=""
TOP_N=0
BUDGET_TIME=0        # seconds; 0 = no budget
BUDGET_MEM=0         # KB; 0 = no budget
MODULES=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed)     SEED="$2"; shift 2 ;;
        --csv)      CSV_OUT="$2"; shift 2 ;;
        --top)      TOP_N="$2"; shift 2 ;;
        --module)   MODULES+=("$2"); shift 2 ;;
        --budget-time) BUDGET_TIME="$2"; shift 2 ;;
        --budget-mem)  BUDGET_MEM="$2"; shift 2 ;;
        --import-context) IMPORT_CONTEXT="$2"; shift 2 ;;
        --work-dir) WORK_DIR="$2"; shift 2 ;;
        *)          echo "unknown option: $1" >&2; exit 1 ;;
    esac
done

# ---------------------------------------------------------------------------
# Validate environment
# ---------------------------------------------------------------------------

if [[ ! -x "$SEED" ]]; then
    echo "[bench] error: seed not found at $SEED" >&2
    echo "[bench] hint: run 'make compile' first" >&2
    exit 1
fi

# Detect GNU time for memory measurement (optional).
GNU_TIME=""
if command -v /usr/bin/time &>/dev/null && /usr/bin/time -v true 2>/dev/null; then
    GNU_TIME="/usr/bin/time"
elif command -v gtime &>/dev/null && gtime -v true 2>/dev/null; then
    GNU_TIME="gtime"
fi
if [[ -z "$GNU_TIME" ]]; then
    echo "[bench] warning: GNU time not found; memory measurement disabled" >&2
    echo "[bench] hint: apt-get install time (Linux) or brew install gnu-time (macOS)" >&2
fi

if [[ ! -d "$IMPORT_CONTEXT" ]]; then
    echo "[bench] error: import-context not found at $IMPORT_CONTEXT" >&2
    echo "[bench] hint: run 'make compile' first to generate import artifacts" >&2
    exit 1
fi

SEED_VERSION="$("$SEED" version 2>/dev/null || echo "unknown")"
echo "[bench] seed: $SEED ($SEED_VERSION)"
if [[ -n "$GNU_TIME" ]]; then
    echo "[bench] memory: enabled (via $GNU_TIME)"
else
    echo "[bench] memory: disabled (GNU time not available)"
fi

# ---------------------------------------------------------------------------
# Collect source modules
# ---------------------------------------------------------------------------

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"

module_name_from_path() {
    local src="$1"
    local rel="${src#$REPO_ROOT/compiler/src/}"
    rel="${rel%.sfn}"
    echo "$rel" | sed 's|/|__|g'
}

slug_from_path() {
    # Import-context uses slash-delimited paths (e.g. llvm/types.sfn-asm),
    # so the slug must preserve slashes for artifact cleanup to work.
    local src="$1"
    local rel="${src#$REPO_ROOT/compiler/src/}"
    rel="${rel%.sfn}"
    echo "$rel"
}

SOURCES=()
if [[ ${#MODULES[@]} -gt 0 ]]; then
    for m in "${MODULES[@]}"; do
        found="$(find "$REPO_ROOT/compiler/src" -path "*${m}*.sfn" -print | head -1)"
        if [[ -z "$found" ]]; then
            echo "[bench] warning: no source matching '$m'" >&2
        else
            SOURCES+=("$found")
        fi
    done
else
    while IFS= read -r f; do
        SOURCES+=("$f")
    done < <(find "$REPO_ROOT/compiler/src" -name '*.sfn' -print | sort)
fi

echo "[bench] modules: ${#SOURCES[@]}"

# ---------------------------------------------------------------------------
# Benchmark each module
# ---------------------------------------------------------------------------

mkdir -p "$WORK_DIR"

# Result file — one line per module: name|time|mem|lines|status
RESULTS_FILE="$WORK_DIR/.bench_results"
: > "$RESULTS_FILE"

bench_module() {
    local src="$1"
    local idx="$2"
    local total="$3"
    local name
    name="$(module_name_from_path "$src")"
    local slug
    slug="$(slug_from_path "$src")"

    # Prepare isolated working directory
    local module_cwd="$WORK_DIR/tmp/${name}/seed_cwd"
    mkdir -p "$module_cwd/build/native" "$module_cwd/build/sailfin"
    rm -rf "$module_cwd/build/native/import-context"
    cp -a "$IMPORT_CONTEXT" "$module_cwd/build/native/import-context"
    rm -f "$module_cwd/build/native/import-context/${slug}.sfn-asm" 2>/dev/null || true
    rm -f "$module_cwd/build/native/import-context/${slug}.layout-manifest" 2>/dev/null || true

    local out_ll="$WORK_DIR/${name}.ll"
    local time_log="$WORK_DIR/${name}.time"
    local abs_src
    abs_src="$(cd "$REPO_ROOT" && realpath "$src" 2>/dev/null || ([ "${src#/}" != "$src" ] && echo "$src" || echo "$REPO_ROOT/$src"))"

    # Resolve output paths to absolute so they work from module_cwd
    mkdir -p "$(dirname "$out_ll")"
    local abs_out_ll
    abs_out_ll="$(cd "$(dirname "$out_ll")" && echo "$(pwd)/$(basename "$out_ll")")"
    local abs_time_log
    abs_time_log="$(cd "$(dirname "$time_log")" && echo "$(pwd)/$(basename "$time_log")")"

    local wall_s=0 peak_kb=0 ll_lines=0 status="ok"

    if [[ -n "$GNU_TIME" ]]; then
        # GNU time: capture wall time + peak RSS
        $GNU_TIME -v -o "$abs_time_log" \
            bash -c "cd '$module_cwd' && '$SEED' emit -o '$abs_out_ll' llvm '$abs_src'" \
            2>/dev/null || true

        if [[ -f "$abs_time_log" ]]; then
            wall_s="$(grep 'Elapsed (wall clock)' "$abs_time_log" | sed 's/.*: //' | awk -F: '{
                if (NF==3) printf "%.2f", $1*3600+$2*60+$3;
                else if (NF==2) printf "%.2f", $1*60+$2;
                else printf "%.2f", $1
            }')"
            peak_kb="$(grep 'Maximum resident' "$abs_time_log" | sed 's/[^0-9]//g')"
        fi
    else
        # Fallback: bash time builtin (wall time only, no memory)
        local start_s
        start_s=$(date +%s)
        (cd "$module_cwd" && "$SEED" emit -o "$abs_out_ll" llvm "$abs_src") 2>/dev/null || true
        local end_s
        end_s=$(date +%s)
        wall_s=$(( end_s - start_s ))
        peak_kb=0
    fi

    # Default empty values to 0
    wall_s="${wall_s:-0}"
    peak_kb="${peak_kb:-0}"

    if [[ -f "$abs_out_ll" ]] && [[ -s "$abs_out_ll" ]]; then
        ll_lines="$(wc -l < "$abs_out_ll")"
    else
        status="FAIL"
    fi

    # Budget checks
    if [[ "$BUDGET_TIME" -gt 0 ]]; then
        local wall_int="${wall_s%.*}"
        wall_int="${wall_int:-0}"
        if [[ "$wall_int" -gt "$BUDGET_TIME" ]]; then
            status="SLOW"
        fi
    fi
    if [[ "$BUDGET_MEM" -gt 0 ]] && [[ "${peak_kb}" -gt "$BUDGET_MEM" ]]; then
        if [[ "$status" == "ok" ]]; then
            status="HIGHMEM"
        else
            status="${status}+HIGHMEM"
        fi
    fi

    # Store result
    echo "${name}|${wall_s}|${peak_kb}|${ll_lines}|${status}" >> "$RESULTS_FILE"

    local peak_mb=$(( peak_kb / 1024 ))
    printf "  [%3d/%d] %-50s %6ss  %5dMB  %5d lines  %s\n" \
        "$idx" "$total" "$name" "$wall_s" "$peak_mb" "$ll_lines" "$status"
}

echo ""
echo "[bench] starting benchmark..."
echo ""
printf "  %-55s %8s  %7s  %11s  %s\n" "MODULE" "TIME" "PEAK" "IR LINES" "STATUS"
printf "  %-55s %8s  %7s  %11s  %s\n" "------" "----" "----" "--------" "------"

idx=0
for src in "${SOURCES[@]}"; do
    idx=$((idx + 1))
    bench_module "$src" "$idx" "${#SOURCES[@]}"
done

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------

echo ""
echo "=================================================================="

total_time=0
max_time=0
max_mem=0
max_time_mod=""
max_mem_mod=""
fail_count=0
slow_count=0
highmem_count=0
module_count=0

while IFS='|' read -r name t m lines s; do
    module_count=$((module_count + 1))
    t_int="${t%.*}"
    t_int="${t_int:-0}"
    m="${m:-0}"

    total_time=$(awk "BEGIN { printf \"%.2f\", $total_time + $t }")

    if [[ "$t_int" -gt "${max_time%.*}" ]]; then
        max_time="$t"
        max_time_mod="$name"
    fi
    if [[ "$m" -gt "$max_mem" ]]; then
        max_mem="$m"
        max_mem_mod="$name"
    fi

    case "$s" in
        FAIL*) fail_count=$((fail_count + 1)) ;;
    esac
    if echo "$s" | grep -q "SLOW"; then slow_count=$((slow_count + 1)); fi
    if echo "$s" | grep -q "HIGHMEM"; then highmem_count=$((highmem_count + 1)); fi
done < "$RESULTS_FILE"

max_mem_mb=$(( max_mem / 1024 ))

echo ""
echo "  SUMMARY"
echo "  -------"
echo "  Modules:       $module_count"
echo "  Total time:    ${total_time}s"
echo "  Slowest:       ${max_time}s  (${max_time_mod})"
if [[ -n "$GNU_TIME" ]]; then
    echo "  Peak memory:   ${max_mem_mb}MB  (${max_mem_mod})"
fi
if [[ "$fail_count" -gt 0 ]]; then
    echo "  FAILURES:      $fail_count"
fi
if [[ "$BUDGET_TIME" -gt 0 ]]; then
    echo "  Over budget:   $slow_count modules > ${BUDGET_TIME}s"
fi
if [[ "$BUDGET_MEM" -gt 0 ]]; then
    echo "  Over memory:   $highmem_count modules > $((BUDGET_MEM / 1024))MB"
fi
echo ""

# ---------------------------------------------------------------------------
# CSV output
# ---------------------------------------------------------------------------

if [[ -n "$CSV_OUT" ]]; then
    mkdir -p "$(dirname "$CSV_OUT")"
    echo "module,time_s,peak_kb,ir_lines,status,seed_version" > "$CSV_OUT"
    while IFS='|' read -r name t m lines s; do
        echo "${name},${t},${m},${lines},${s},$SEED_VERSION" >> "$CSV_OUT"
    done < "$RESULTS_FILE"
    echo "[bench] wrote $CSV_OUT"
fi

# ---------------------------------------------------------------------------
# Top N by time (optional)
# ---------------------------------------------------------------------------

if [[ "$TOP_N" -gt 0 ]] && [[ "$module_count" -gt "$TOP_N" ]]; then
    echo ""
    echo "  TOP $TOP_N BY COMPILE TIME"
    echo "  -------------------------"
    sort -t'|' -k2 -rn "$RESULTS_FILE" | head -"$TOP_N" | while IFS='|' read -r name t m lines s; do
        printf "  %-50s %ss\n" "$name" "$t"
    done
    echo ""
fi

# Cleanup
rm -f "$RESULTS_FILE"

# ---------------------------------------------------------------------------
# Exit code: non-zero if any failures or budget violations
# ---------------------------------------------------------------------------

if [[ "$fail_count" -gt 0 ]]; then
    echo "[bench] FAIL: $fail_count modules failed to compile" >&2
    exit 1
fi

if [[ "$slow_count" -gt 0 ]] || [[ "$highmem_count" -gt 0 ]]; then
    echo "[bench] WARNING: budget violations detected" >&2
    exit 2
fi

echo "[bench] all modules within budget"
