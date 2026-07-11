#!/usr/bin/env bash
# scripts/perf_history.sh — perf time-series bookkeeping for the nightly
# perf-history job (SFEP-0037 §3.3). Two subcommands, both pure data logic
# with no network/gh dependency so the compare path is unit-testable offline:
#
#   append   Tag a run's raw bench CSVs with (run_sha, run_date) and append
#            them to the accumulating time-series files on the bench-data
#            checkout. Idempotent per commit: a run_sha already present is a
#            no-op (safe re-runs of the nightly job).
#
#   compare  Compute the rolling median of the last N prior runs per module
#            and emit a TSV of regressions (>THRESHOLD% wall-time or peak-RSS
#            vs that median, plus a whole-build wall-time budget breach). Cold
#            start (fewer than N prior runs, or a module lacking N baseline
#            samples) no-ops cleanly rather than alerting on thin history.
#
# The accumulating files on the bench-data orphan branch:
#   compile.csv  run_sha,run_date,module,time_s,peak_kb,ir_lines,status,seed_version
#   runtime.csv  run_sha,run_date,workload,inner_ms_min,inner_ms_median,peak_kb,ops,ops_per_ms,status,seed_version,platform
#   build.csv    run_sha,run_date,build_wall_s,budget_s
#
# The raw per-run CSVs come straight from `sfn bench --compiler --csv` and
# `sfn bench benchmarks/runtime --csv`; this script only prepends the two run
# columns. The whole-build budget row is separate because the compile bench
# sums *isolated* per-module emit times (serial), which is not the parallel
# clean-build wall-time the SFEP-0006 <5 min target measures — the workflow
# times a real build and records it in build.csv (see docs/perf/bench-history.md).

set -euo pipefail

COMPILE_HEADER="run_sha,run_date,module,time_s,peak_kb,ir_lines,status,seed_version"
RUNTIME_HEADER="run_sha,run_date,workload,inner_ms_min,inner_ms_median,peak_kb,ops,ops_per_ms,status,seed_version,platform"
BUILD_HEADER="run_sha,run_date,build_wall_s,budget_s"

die() {
    echo "perf_history: $*" >&2
    exit 1
}

# --- append -----------------------------------------------------------------

# _sha_present <accumulated-csv> <sha> -> 0 if the sha already appears in col 1
_sha_present() {
    local file="$1" sha="$2"
    [ -f "$file" ] || return 1
    awk -F, -v s="$sha" 'NR>1 && $1==s { found=1; exit } END { exit found?0:1 }' "$file"
}

# _append_tagged <raw-csv> <accumulated-csv> <header> <sha> <date>
# Prepends run_sha,run_date to every data row of the raw CSV (its own header is
# dropped) and appends to the accumulated file, writing the header first if the
# accumulated file does not yet exist.
_append_tagged() {
    local raw="$1" acc="$2" header="$3" sha="$4" date="$5"
    [ -f "$acc" ] || echo "$header" > "$acc"
    awk -F, -v OFS=, -v s="$sha" -v d="$date" 'NR>1 && NF>0 { print s, d, $0 }' "$raw" >> "$acc"
}

cmd_append() {
    local data_dir="" sha="" date="" compile="" runtime="" build_wall="" budget=""
    while [ $# -gt 0 ]; do
        case "$1" in
            --data-dir) data_dir="$2"; shift 2 ;;
            --sha) sha="$2"; shift 2 ;;
            --date) date="$2"; shift 2 ;;
            --compile) compile="$2"; shift 2 ;;
            --runtime) runtime="$2"; shift 2 ;;
            --build-wall) build_wall="$2"; shift 2 ;;
            --budget) budget="$2"; shift 2 ;;
            *) die "append: unknown flag '$1'" ;;
        esac
    done
    [ -n "$data_dir" ] || die "append: --data-dir required"
    [ -n "$sha" ] || die "append: --sha required"
    [ -n "$date" ] || die "append: --date required"
    mkdir -p "$data_dir"

    # Per-file idempotency: each accumulated CSV is guarded on its OWN sha
    # column, not on compile.csv alone. A run where the compile bench produced
    # no CSV (aborted before writing) must not let a re-run duplicate the
    # runtime/build rows — so every stream checks whether $sha is already
    # recorded in its own file before appending.
    if [ -n "$compile" ] && [ -s "$compile" ]; then
        if _sha_present "$data_dir/compile.csv" "$sha"; then
            echo "perf_history: compile rows for $sha already present — skipping"
        else
            _append_tagged "$compile" "$data_dir/compile.csv" "$COMPILE_HEADER" "$sha" "$date"
            echo "perf_history: appended compile rows for $sha"
        fi
    fi
    if [ -n "$runtime" ] && [ -s "$runtime" ]; then
        if _sha_present "$data_dir/runtime.csv" "$sha"; then
            echo "perf_history: runtime rows for $sha already present — skipping"
        else
            _append_tagged "$runtime" "$data_dir/runtime.csv" "$RUNTIME_HEADER" "$sha" "$date"
            echo "perf_history: appended runtime rows for $sha"
        fi
    fi
    if [ -n "$build_wall" ]; then
        [ -n "$budget" ] || die "append: --budget required when --build-wall is set"
        if _sha_present "$data_dir/build.csv" "$sha"; then
            echo "perf_history: build row for $sha already present — skipping"
        else
            [ -f "$data_dir/build.csv" ] || echo "$BUILD_HEADER" > "$data_dir/build.csv"
            echo "$sha,$date,$build_wall,$budget" >> "$data_dir/build.csv"
            echo "perf_history: appended build wall time ${build_wall}s for $sha"
        fi
    fi
}

# --- compare ----------------------------------------------------------------

cmd_compare() {
    local data_dir="" sha="" min_runs="7" threshold="10" budget="300" out=""
    while [ $# -gt 0 ]; do
        case "$1" in
            --data-dir) data_dir="$2"; shift 2 ;;
            --sha) sha="$2"; shift 2 ;;
            --min-runs) min_runs="$2"; shift 2 ;;
            --threshold-pct) threshold="$2"; shift 2 ;;
            --budget) budget="$2"; shift 2 ;;
            --out) out="$2"; shift 2 ;;
            *) die "compare: unknown flag '$1'" ;;
        esac
    done
    [ -n "$data_dir" ] || die "compare: --data-dir required"
    [ -n "$sha" ] || die "compare: --sha required"
    [ -n "$out" ] || die "compare: --out required"
    : > "$out"

    # Comparison is module-scoped (compile bench) plus the whole-build budget,
    # matching the issue's compare contract ("regression on any module" / "the
    # offending module"). runtime.csv is recorded on the branch for the future
    # dashboard but is NOT compared here yet — per-workload runtime alerting is
    # deferred (SFEP-0037 §3.3 follow-up), not part of this slice.
    local compile_csv="$data_dir/compile.csv"
    if [ ! -f "$compile_csv" ]; then
        echo "perf_history: no compile.csv yet — cold start, no comparison"
        return 0
    fi

    # Per-module rolling-median compare. The awk program builds the distinct
    # run order from column 1 (append order == chronological), takes the last
    # N prior runs (excluding the current sha) as the baseline window, and
    # flags the current run's modules that exceed the median by more than
    # THRESHOLD%. A module without N valid samples in the window is skipped
    # (per-module cold start). asort is avoided (mawk lacks it) — median sorts
    # a small (<=N) copy with an inline insertion sort.
    #
    # Only FAIL-status rows are excluded (a failed compile has no meaningful
    # timing). SLOW/HIGHMEM rows — which only appear if a --budget-time/-mem is
    # ever added to the workflow's BENCH_ARGS — carry valid measurements and
    # ARE the regressions worth catching, so they must stay in the comparison.
    awk -F, \
        -v CUR="$sha" -v N="$min_runs" -v TH="$threshold" \
        '
        function median(a, len,   i, j, tmp, b, m) {
            for (i = 1; i <= len; i++) b[i] = a[i]
            for (i = 2; i <= len; i++) {
                tmp = b[i]; j = i - 1
                while (j >= 1 && b[j] > tmp) { b[j + 1] = b[j]; j-- }
                b[j + 1] = tmp
            }
            if (len % 2 == 1) return b[int(len / 2) + 1]
            m = len / 2
            return (b[m] + b[m + 1]) / 2
        }
        NR == 1 { next }
        NF == 0 { next }
        {
            sha = $1; module = $3; t = $4 + 0; p = $5 + 0; st = $7
            if (!(sha in seen)) { seen[sha] = 1; order[++n] = sha }
            k = sha SUBSEP module
            tval[k] = t; pval[k] = p; sval[k] = st
            if (sha == CUR) curmods[module] = 1
        }
        END {
            pc = 0
            for (i = 1; i <= n; i++) if (order[i] != CUR) prior[++pc] = order[i]
            if (pc < N) {
                printf("perf_history: cold start — %d prior run(s) < %d required; no comparison\n", pc, N) > "/dev/stderr"
                exit 0
            }
            wstart = pc - N + 1
            for (module in curmods) {
                ck = CUR SUBSEP module
                if (!(ck in tval) || sval[ck] ~ /FAIL/) continue
                tc = 0; mc = 0
                for (i = wstart; i <= pc; i++) {
                    bk = prior[i] SUBSEP module
                    if ((bk in tval) && sval[bk] !~ /FAIL/) {
                        tsamp[++tc] = tval[bk]; psamp[++mc] = pval[bk]
                    }
                }
                if (tc < N) { delete tsamp; delete psamp; continue }
                mt = median(tsamp, tc); mp = median(psamp, mc)
                ct = tval[ck]; cp = pval[ck]
                if (mt > 0 && ct > mt * (1 + TH / 100))
                    printf("%s\ttime_s\t%.4f\t%.4f\t%.1f\n", module, ct, mt, (ct / mt - 1) * 100)
                if (mp > 0 && cp > mp * (1 + TH / 100))
                    printf("%s\tpeak_kb\t%.0f\t%.0f\t%.1f\n", module, cp, mp, (cp / mp - 1) * 100)
                delete tsamp; delete psamp
            }
        }
        ' "$compile_csv" >> "$out"

    # Whole-build wall-time budget breach — measured separately from the
    # per-module emit sums (see header). Compare the current run's recorded
    # parallel clean-build wall time against the SFEP-0006 budget.
    local build_csv="$data_dir/build.csv"
    if [ -f "$build_csv" ]; then
        awk -F, -v CUR="$sha" -v BUD="$budget" '
            NR > 1 && $1 == CUR {
                wall = $3 + 0
                if (BUD > 0 && wall > BUD)
                    printf("<whole-build>\tbuild_wall_s\t%.1f\t%.1f\t%.1f\n", wall, BUD, (wall / BUD - 1) * 100)
            }
        ' "$build_csv" >> "$out"
    fi

    if [ -s "$out" ]; then
        echo "perf_history: $(wc -l < "$out") regression line(s) written to $out"
    else
        echo "perf_history: no regressions detected"
    fi
}

# --- dispatch ---------------------------------------------------------------

usage() {
    cat >&2 <<'EOF'
usage:
  perf_history.sh append  --data-dir DIR --sha SHA --date DATE
                          [--compile CSV] [--runtime CSV]
                          [--build-wall SECONDS --budget SECONDS]
  perf_history.sh compare --data-dir DIR --sha SHA --out FILE
                          [--min-runs N] [--threshold-pct PCT] [--budget SECONDS]
EOF
    exit 2
}

[ $# -ge 1 ] || usage
sub="$1"; shift
case "$sub" in
    append) cmd_append "$@" ;;
    compare) cmd_compare "$@" ;;
    -h|--help|help) usage ;;
    *) die "unknown subcommand '$sub'" ;;
esac
