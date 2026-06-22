#!/usr/bin/env bash
set -euo pipefail

# bench_runtime.sh — Benchmark runtime-execution performance.
#
# Builds each workload under benchmarks/runtime/ ONCE, then runs the
# compiled binary K+1 times (discarding a warm-up run), parsing the
# machine-parseable `RESULT <name> <inner_ms> <ops>` line each program
# prints. Reports min/median inner-loop time and max peak RSS, and
# optionally writes CSV for tracking regressions.
#
# This is the runtime-execution counterpart to bench_compile.sh: that one
# measures how fast the compiler *emits IR*; this one measures how fast
# *compiled Sailfin programs run* — the surface the C→Sailfin runtime
# rewrite most affects.
#
# Usage:
#   bash scripts/bench_runtime.sh                         # all workloads
#   bash scripts/bench_runtime.sh --iterations 10         # 10 timed runs each
#   bash scripts/bench_runtime.sh --workload arena_alloc  # one workload
#   bash scripts/bench_runtime.sh --csv build/runtime.csv
#   bash scripts/bench_runtime.sh --top 3 --budget-time 1000 --budget-mem 512000

SEED="${SEED:-build/native/sailfin}"
WORK_DIR="${WORK_DIR:-build/bench-runtime}"
CSV_OUT=""
TOP_N=0
ITERATIONS=5         # timed runs per workload (plus one discarded warm-up)
BUDGET_TIME=0        # ms; 0 = no budget (median inner_ms)
BUDGET_MEM=0         # KB; 0 = no budget (peak RSS)
WORKLOADS=()

while [[ $# -gt 0 ]]; do
    case "$1" in
        --seed)        SEED="$2"; shift 2 ;;
        --csv)         CSV_OUT="$2"; shift 2 ;;
        --top)         TOP_N="$2"; shift 2 ;;
        --iterations)  ITERATIONS="$2"; shift 2 ;;
        --workload)    WORKLOADS+=("$2"); shift 2 ;;
        --budget-time) BUDGET_TIME="$2"; shift 2 ;;
        --budget-mem)  BUDGET_MEM="$2"; shift 2 ;;
        --work-dir)    WORK_DIR="$2"; shift 2 ;;
        *)             echo "unknown option: $1" >&2; exit 1 ;;
    esac
done

# ---------------------------------------------------------------------------
# Validate environment
# ---------------------------------------------------------------------------

if [[ ! -x "$SEED" ]]; then
    echo "[bench-runtime] error: seed not found at $SEED" >&2
    echo "[bench-runtime] hint: run 'make compile' first" >&2
    exit 1
fi
# Resolve to absolute — the seed and binaries are invoked from the work dir.
SEED="$(cd "$(dirname "$SEED")" && echo "$(pwd)/$(basename "$SEED")")"

# Detect GNU time for memory measurement (optional). Same detection as
# bench_compile.sh.
GNU_TIME=""
if command -v /usr/bin/time &>/dev/null && /usr/bin/time -v true 2>/dev/null; then
    GNU_TIME="/usr/bin/time"
elif command -v gtime &>/dev/null && gtime -v true 2>/dev/null; then
    GNU_TIME="gtime"
fi
if [[ -z "$GNU_TIME" ]]; then
    echo "[bench-runtime] warning: GNU time not found; memory measurement disabled" >&2
    echo "[bench-runtime] hint: apt-get install time (Linux) or brew install gnu-time (macOS)" >&2
fi

SEED_VERSION="$("$SEED" version 2>/dev/null || echo "unknown")"
PLATFORM="$(uname -sm)"
echo "[bench-runtime] seed: $SEED ($SEED_VERSION)"
echo "[bench-runtime] platform: $PLATFORM"
if [[ -n "$GNU_TIME" ]]; then
    echo "[bench-runtime] memory: enabled (via $GNU_TIME)"
else
    echo "[bench-runtime] memory: disabled (GNU time not available)"
fi

# ---------------------------------------------------------------------------
# Collect workloads
# ---------------------------------------------------------------------------

REPO_ROOT="$(cd "$(dirname "$0")/.." && pwd)"
BENCH_DIR="$REPO_ROOT/benchmarks/runtime"

SOURCES=()
if [[ ${#WORKLOADS[@]} -gt 0 ]]; then
    for w in "${WORKLOADS[@]}"; do
        src="$BENCH_DIR/${w}.sfn"
        if [[ ! -f "$src" ]]; then
            echo "[bench-runtime] warning: no workload named '$w' ($src)" >&2
        else
            SOURCES+=("$src")
        fi
    done
else
    while IFS= read -r f; do
        SOURCES+=("$f")
    done < <(find "$BENCH_DIR" -maxdepth 1 -name '*.sfn' -print | sort)
fi

if [[ ${#SOURCES[@]} -eq 0 ]]; then
    echo "[bench-runtime] error: no workloads to run" >&2
    exit 1
fi

echo "[bench-runtime] workloads: ${#SOURCES[@]}"
echo "[bench-runtime] timed runs per workload: $ITERATIONS (+1 warm-up)"

# ---------------------------------------------------------------------------
# Benchmark each workload
# ---------------------------------------------------------------------------

mkdir -p "$WORK_DIR"

# Result file — one line per workload:
#   name|inner_ms_min|inner_ms_median|peak_kb|ops|ops_per_ms|status
RESULTS_FILE="$WORK_DIR/.bench_runtime_results"
: > "$RESULTS_FILE"

# median of whitespace-separated integers on stdin.
median() {
    sort -n | awk '{ a[NR] = $1 } END {
        if (NR == 0) { print 0; exit }
        if (NR % 2 == 1) { print a[(NR + 1) / 2] }
        else { printf "%d", (a[NR/2] + a[NR/2 + 1]) / 2 }
    }'
}

bench_workload() {
    local src="$1"
    local idx="$2"
    local total="$3"
    local name
    name="$(basename "$src" .sfn)"

    local bin="$WORK_DIR/${name}"
    local build_log="$WORK_DIR/${name}.build.log"
    local time_log="$WORK_DIR/${name}.time"

    local status="ok"
    local inner_min=0 inner_median=0 peak_kb=0 ops=0 ops_per_ms="0"

    # --- Build once (build failure → BUILDFAIL, skip runs) ---
    if ! timeout 120 "$SEED" build -o "$bin" "$src" >"$build_log" 2>&1; then
        status="BUILDFAIL"
        echo "${name}|0|0|0|0|0|${status}" >> "$RESULTS_FILE"
        printf "  [%2d/%d] %-22s %8s  %8s  %10s  %s\n" \
            "$idx" "$total" "$name" "-" "-" "-" "$status"
        return
    fi

    # --- Warm-up run (discarded) ---
    timeout 60 "$bin" >/dev/null 2>&1 || true

    # --- K timed runs ---
    local inner_samples=()
    local run=0
    local runfail=0
    while [[ "$run" -lt "$ITERATIONS" ]]; do
        run=$((run + 1))
        local out=""
        if [[ -n "$GNU_TIME" ]]; then
            out="$($GNU_TIME -v -o "$time_log" timeout 60 "$bin" 2>/dev/null || true)"
            local sample_kb
            sample_kb="$(grep 'Maximum resident' "$time_log" 2>/dev/null | sed 's/[^0-9]//g')"
            sample_kb="${sample_kb:-0}"
            if [[ "$sample_kb" -gt "$peak_kb" ]]; then
                peak_kb="$sample_kb"
            fi
        else
            out="$(timeout 60 "$bin" 2>/dev/null || true)"
        fi

        # Parse the RESULT line: RESULT <name> <inner_ms> <ops>
        local result_line
        result_line="$(echo "$out" | grep -E "^RESULT ${name} " | head -1)"
        if [[ -z "$result_line" ]]; then
            runfail=1
            continue
        fi
        local r_ms r_ops
        r_ms="$(echo "$result_line" | awk '{print $3}')"
        r_ops="$(echo "$result_line" | awk '{print $4}')"
        inner_samples+=("$r_ms")
        ops="$r_ops"
    done

    if [[ ${#inner_samples[@]} -eq 0 ]]; then
        status="RUNFAIL"
        echo "${name}|0|0|${peak_kb}|0|0|${status}" >> "$RESULTS_FILE"
        printf "  [%2d/%d] %-22s %8s  %8s  %10s  %s\n" \
            "$idx" "$total" "$name" "-" "-" "-" "$status"
        return
    fi
    if [[ "$runfail" -eq 1 ]]; then
        status="RUNFAIL"
    fi

    inner_min="$(printf '%s\n' "${inner_samples[@]}" | sort -n | head -1)"
    inner_median="$(printf '%s\n' "${inner_samples[@]}" | median)"

    if [[ "$inner_median" -gt 0 ]]; then
        ops_per_ms="$(awk "BEGIN { printf \"%.1f\", $ops / $inner_median }")"
    fi

    # Budget checks (median inner_ms; peak RSS).
    if [[ "$BUDGET_TIME" -gt 0 ]] && [[ "$inner_median" -gt "$BUDGET_TIME" ]]; then
        if [[ "$status" == "ok" ]]; then status="SLOW"; else status="${status}+SLOW"; fi
    fi
    if [[ "$BUDGET_MEM" -gt 0 ]] && [[ "$peak_kb" -gt "$BUDGET_MEM" ]]; then
        if [[ "$status" == "ok" ]]; then status="HIGHMEM"; else status="${status}+HIGHMEM"; fi
    fi

    echo "${name}|${inner_min}|${inner_median}|${peak_kb}|${ops}|${ops_per_ms}|${status}" >> "$RESULTS_FILE"

    local peak_mb=$(( peak_kb / 1024 ))
    printf "  [%2d/%d] %-22s %6dms  %5dMB  %10s  %s\n" \
        "$idx" "$total" "$name" "$inner_median" "$peak_mb" "$ops_per_ms" "$status"
}

echo ""
echo "[bench-runtime] starting benchmark..."
echo ""
printf "  %-31s %8s  %7s  %10s  %s\n" "WORKLOAD" "MEDIAN" "PEAK" "OPS/MS" "STATUS"
printf "  %-31s %8s  %7s  %10s  %s\n" "--------" "------" "----" "------" "------"

idx=0
for src in "${SOURCES[@]}"; do
    idx=$((idx + 1))
    bench_workload "$src" "$idx" "${#SOURCES[@]}"
done

# ---------------------------------------------------------------------------
# Summary
# ---------------------------------------------------------------------------

echo ""
echo "=================================================================="

workload_count=0
buildfail_count=0
runfail_count=0
slow_count=0
highmem_count=0
max_mem=0
max_mem_wl=""
slowest_ms=0
slowest_wl=""

while IFS='|' read -r name imin imed pkb ops opms s; do
    workload_count=$((workload_count + 1))
    pkb="${pkb:-0}"
    imed="${imed:-0}"

    if [[ "$pkb" -gt "$max_mem" ]]; then
        max_mem="$pkb"
        max_mem_wl="$name"
    fi
    if [[ "$imed" -gt "$slowest_ms" ]]; then
        slowest_ms="$imed"
        slowest_wl="$name"
    fi

    case "$s" in
        BUILDFAIL*) buildfail_count=$((buildfail_count + 1)) ;;
    esac
    if echo "$s" | grep -q "RUNFAIL"; then runfail_count=$((runfail_count + 1)); fi
    if echo "$s" | grep -q "SLOW"; then slow_count=$((slow_count + 1)); fi
    if echo "$s" | grep -q "HIGHMEM"; then highmem_count=$((highmem_count + 1)); fi
done < "$RESULTS_FILE"

max_mem_mb=$(( max_mem / 1024 ))

echo ""
echo "  SUMMARY"
echo "  -------"
echo "  Workloads:     $workload_count"
echo "  Slowest:       ${slowest_ms}ms  (${slowest_wl})"
if [[ -n "$GNU_TIME" ]]; then
    echo "  Peak memory:   ${max_mem_mb}MB  (${max_mem_wl})"
fi
if [[ "$buildfail_count" -gt 0 ]]; then
    echo "  BUILD FAILS:   $buildfail_count"
fi
if [[ "$runfail_count" -gt 0 ]]; then
    echo "  RUN FAILS:     $runfail_count"
fi
if [[ "$BUDGET_TIME" -gt 0 ]]; then
    echo "  Over budget:   $slow_count workloads > ${BUDGET_TIME}ms"
fi
if [[ "$BUDGET_MEM" -gt 0 ]]; then
    echo "  Over memory:   $highmem_count workloads > $((BUDGET_MEM / 1024))MB"
fi
echo ""

# ---------------------------------------------------------------------------
# CSV output
# ---------------------------------------------------------------------------

if [[ -n "$CSV_OUT" ]]; then
    mkdir -p "$(dirname "$CSV_OUT")"
    echo "workload,inner_ms_min,inner_ms_median,peak_kb,ops,ops_per_ms,status,seed_version,platform" > "$CSV_OUT"
    while IFS='|' read -r name imin imed pkb ops opms s; do
        echo "${name},${imin},${imed},${pkb},${ops},${opms},${s},${SEED_VERSION},${PLATFORM}" >> "$CSV_OUT"
    done < "$RESULTS_FILE"
    echo "[bench-runtime] wrote $CSV_OUT"
fi

# ---------------------------------------------------------------------------
# Top N by median inner time (optional)
# ---------------------------------------------------------------------------

if [[ "$TOP_N" -gt 0 ]] && [[ "$workload_count" -gt "$TOP_N" ]]; then
    echo ""
    echo "  TOP $TOP_N BY MEDIAN INNER TIME"
    echo "  ------------------------------"
    sort -t'|' -k3 -rn "$RESULTS_FILE" | head -"$TOP_N" | while IFS='|' read -r name imin imed pkb ops opms s; do
        printf "  %-31s %6dms\n" "$name" "$imed"
    done
    echo ""
fi

# Cleanup
rm -f "$RESULTS_FILE"

# ---------------------------------------------------------------------------
# Exit code: non-zero on any build/run failure or budget violation.
# ---------------------------------------------------------------------------

if [[ "$buildfail_count" -gt 0 ]] || [[ "$runfail_count" -gt 0 ]]; then
    echo "[bench-runtime] FAIL: $buildfail_count build failure(s), $runfail_count run failure(s)" >&2
    exit 1
fi

if [[ "$slow_count" -gt 0 ]] || [[ "$highmem_count" -gt 0 ]]; then
    echo "[bench-runtime] WARNING: budget violations detected" >&2
    exit 2
fi

echo "[bench-runtime] all workloads within budget"
