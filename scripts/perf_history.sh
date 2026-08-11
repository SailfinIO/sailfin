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
#            vs that median, plus a whole-build wall-time budget breach and a
#            per-fixture consumer-build comparison). Cold start (fewer than N
#            prior runs, or a module/fixture lacking N baseline samples) no-ops
#            cleanly rather than alerting on thin history.
#            Rows are kind,name,metric,current,comparison,pct; kind is
#            "rolling-median", "budget", or "consumer-median" so reporting
#            preserves which comparison produced the regression (SFN-567: a
#            kind that blends comparisons hides the stricter one).
#
# The accumulating files on the bench-data orphan branch:
#   compile.csv  run_sha,run_date,module,time_s,peak_kb,ir_lines,status,seed_version
#   runtime.csv  run_sha,run_date,workload,inner_ms_min,inner_ms_median,peak_kb,ops,ops_per_ms,status,seed_version,platform
#   build.csv    run_sha,run_date,build_wall_s,budget_s
#   consumer.csv run_sha,run_date,fixture,cold_s,warm_s,binary_bytes,ctors,modules_staged,cold_cache_misses,cache_hits,cache_misses,status,seed_version,platform
#
# The raw per-run CSVs come straight from `sfn bench --compiler --csv`,
# `sfn bench benchmarks/runtime --csv`, and `sfn bench --consumer --csv`; this
# script only prepends the two run columns. The whole-build budget row is
# separate because the compile bench sums *isolated* per-module emit times
# (serial), which is not the parallel clean-build wall-time the SFEP-0006 <5 min
# target measures — the workflow times a real build and records it in build.csv
# (see docs/perf/bench-history.md).

set -euo pipefail

COMPILE_HEADER="run_sha,run_date,module,time_s,peak_kb,ir_lines,status,seed_version"
RUNTIME_HEADER="run_sha,run_date,workload,inner_ms_min,inner_ms_median,peak_kb,ops,ops_per_ms,status,seed_version,platform"
BUILD_HEADER="run_sha,run_date,build_wall_s,budget_s"
CONSUMER_HEADER="run_sha,run_date,fixture,cold_s,warm_s,binary_bytes,ctors,modules_staged,cold_cache_misses,cache_hits,cache_misses,status,seed_version,platform"

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
    local data_dir="" sha="" date="" compile="" runtime="" consumer="" build_wall="" budget=""
    while [ $# -gt 0 ]; do
        case "$1" in
            --data-dir) data_dir="$2"; shift 2 ;;
            --sha) sha="$2"; shift 2 ;;
            --date) date="$2"; shift 2 ;;
            --compile) compile="$2"; shift 2 ;;
            --runtime) runtime="$2"; shift 2 ;;
            --consumer) consumer="$2"; shift 2 ;;
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
    if [ -n "$consumer" ] && [ -s "$consumer" ]; then
        if _sha_present "$data_dir/consumer.csv" "$sha"; then
            echo "perf_history: consumer rows for $sha already present — skipping"
        else
            _append_tagged "$consumer" "$data_dir/consumer.csv" "$CONSUMER_HEADER" "$sha" "$date"
            echo "perf_history: appended consumer rows for $sha"
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
    local data_dir="" sha="" min_runs="7" threshold="10" count_threshold="0" budget="300" out=""
    while [ $# -gt 0 ]; do
        case "$1" in
            --data-dir) data_dir="$2"; shift 2 ;;
            --sha) sha="$2"; shift 2 ;;
            --min-runs) min_runs="$2"; shift 2 ;;
            --threshold-pct) threshold="$2"; shift 2 ;;
            --count-threshold-pct) count_threshold="$2"; shift 2 ;;
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
    #
    # A missing compile.csv skips the per-module comparison only — it must not
    # return, or a run whose compile bench aborted before writing its CSV would
    # silently skip the whole-build budget check and the consumer comparison
    # too. Reading /dev/null lands in the awk program's own cold-start path
    # (zero prior runs) and writes nothing.
    local compile_csv="$data_dir/compile.csv"
    if [ ! -f "$compile_csv" ]; then
        echo "perf_history: no compile.csv yet — cold start, no per-module comparison"
        compile_csv="/dev/null"
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
            sha = $1; module = $3; t = $4 + 0; p = $5 + 0; st = $7; sv = $8
            if (!(sha in seen)) { seen[sha] = 1; order[++n] = sha }
            runseed[sha] = sv
            k = sha SUBSEP module
            tval[k] = t; pval[k] = p; sval[k] = st; svval[k] = sv
            if (sha == CUR) { curmods[module] = 1; cur_seed = sv }
        }
        END {
            pc = 0
            for (i = 1; i <= n; i++) if (order[i] != CUR) prior[++pc] = order[i]
            if (pc < N) {
                printf("perf_history: cold start — %d prior run(s) < %d required; no comparison\n", pc, N) > "/dev/stderr"
                exit 0
            }
            # Seed-scoped baseline: a module is compared only against prior
            # samples produced by the SAME pinned seed (compile.csv col 8,
            # seed_version). A seed bump rebuilds every module with a different
            # compiler binary, shifting all timings/RSS at once; comparing
            # across that boundary flags the whole tree as regressed and floods
            # triage (SFN-330). After a bump a module has < N same-seed samples
            # and falls through the per-module cold-start skip below until N
            # nightlies accrue under the new seed.
            if (cur_seed != "" && runseed[prior[pc]] != "" && runseed[prior[pc]] != cur_seed) {
                printf("perf_history: seed changed %s -> %s; per-module baselines reset (need %d same-seed runs before comparison resumes)\n", runseed[prior[pc]], cur_seed, N) > "/dev/stderr"
            }
            for (module in curmods) {
                ck = CUR SUBSEP module
                if (!(ck in tval) || sval[ck] ~ /FAIL/) continue
                # Same-seed, non-FAIL prior samples for this module, in
                # chronological (append) order; the rolling window is the last
                # N of these.
                tc = 0
                for (i = 1; i <= pc; i++) {
                    bk = prior[i] SUBSEP module
                    if ((bk in tval) && sval[bk] !~ /FAIL/ && svval[bk] == cur_seed) {
                        tsamp[++tc] = tval[bk]; psamp[tc] = pval[bk]
                    }
                }
                if (tc < N) { delete tsamp; delete psamp; continue }
                w = 0
                for (i = tc - N + 1; i <= tc; i++) { wt[++w] = tsamp[i]; wp[w] = psamp[i] }
                mt = median(wt, N); mp = median(wp, N)
                ct = tval[ck]; cp = pval[ck]
                if (mt > 0 && ct > mt * (1 + TH / 100))
                    printf("rolling-median\t%s\ttime_s\t%.4f\t%.4f\t%.1f\n", module, ct, mt, (ct / mt - 1) * 100)
                if (mp > 0 && cp > mp * (1 + TH / 100))
                    printf("rolling-median\t%s\tpeak_kb\t%.0f\t%.0f\t%.1f\n", module, cp, mp, (cp / mp - 1) * 100)
                delete tsamp; delete psamp; delete wt; delete wp
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
                    printf("budget\t<whole-build>\tbuild_wall_s\t%.1f\t%.1f\t%.1f\n", wall, BUD, (wall / BUD - 1) * 100)
            }
        ' "$build_csv" >> "$out"
    fi

    # Per-fixture consumer-build compare (SFEP-0070). Same rolling-median shape
    # and same seed scoping as the per-module block above, over a different
    # series: `sfn bench --consumer` measures whole `sfn build` runs of fixed
    # fixtures, so what it catches is the capsule source closure re-inflating —
    # a cost every consumer of the language pays, which the per-module compile
    # bench cannot see because it never resolves a dependency closure.
    #
    # Two thresholds, because the series mixes two kinds of number. `cold_s` is
    # a wall time on a shared runner and gets the same noise band as the compile
    # bench (TH). `ctors` and `modules_staged` are derived counts that are
    # deterministic for a given tree and seed, so they get CTH — 0 by default,
    # i.e. any sustained rise above the median. A 10% band would silently absorb
    # a 32 -> 35 constructor rise, which is precisely the regression this series
    # exists to catch.
    #
    # NOT compared, deliberately: `binary_bytes` (dead-stripping already keeps
    # it flat, so it is recorded as evidence, not as a signal —
    # docs/perf/consumer-baseline.md) and `warm_s` (a ~1.8s control measurement
    # whose relative jitter on a shared runner is far wider than any drift worth
    # reporting). Both accumulate on the branch for the dashboard, matching how
    # runtime.csv is recorded but not alerted on.
    local consumer_csv="$data_dir/consumer.csv"
    if [ -f "$consumer_csv" ]; then
        awk -F, \
            -v CUR="$sha" -v N="$min_runs" -v TH="$threshold" -v CTH="$count_threshold" \
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
                sha = $1; fixture = $3; st = $12; sv = $13
                if (!(sha in seen)) { seen[sha] = 1; order[++n] = sha }
                runseed[sha] = sv
                k = sha SUBSEP fixture
                have[k] = 1; sval[k] = st; svval[k] = sv
                val[k, "cold_s"] = $4 + 0
                val[k, "ctors"] = $7 + 0
                val[k, "modules_staged"] = $8 + 0
                if (sha == CUR) { curfix[fixture] = 1; cur_seed = sv }
            }
            END {
                pc = 0
                for (i = 1; i <= n; i++) if (order[i] != CUR) prior[++pc] = order[i]
                if (pc < N) {
                    printf("perf_history: consumer cold start — %d prior run(s) < %d required; no comparison\n", pc, N) > "/dev/stderr"
                    exit 0
                }
                if (cur_seed != "" && runseed[prior[pc]] != "" && runseed[prior[pc]] != cur_seed) {
                    printf("perf_history: seed changed %s -> %s; per-fixture consumer baselines reset (need %d same-seed runs before comparison resumes)\n", runseed[prior[pc]], cur_seed, N) > "/dev/stderr"
                }
                nm = split("cold_s ctors modules_staged", metrics, " ")
                for (fixture in curfix) {
                    ck = CUR SUBSEP fixture
                    if (!(ck in have) || sval[ck] ~ /FAIL/) continue
                    for (mi = 1; mi <= nm; mi++) {
                        metric = metrics[mi]
                        cv = val[ck, metric]
                        # The harness writes -1 for a metric it could not
                        # derive. Only `ctors` also carries a status token
                        # (`noctor`); `modules_staged` is a missing JSON key and
                        # reports -1 with the status still `ok`, so the negative
                        # value — not the status column — is the reliable test.
                        # Unavailable is not a measurement: it neither alerts nor
                        # sits in a window as a value orders of magnitude below
                        # the rest.
                        if (cv < 0) continue
                        sc = 0
                        for (i = 1; i <= pc; i++) {
                            bk = prior[i] SUBSEP fixture
                            if ((bk in have) && sval[bk] !~ /FAIL/ && svval[bk] == cur_seed && val[bk, metric] >= 0)
                                samp[++sc] = val[bk, metric]
                        }
                        if (sc < N) { delete samp; continue }
                        w = 0
                        for (i = sc - N + 1; i <= sc; i++) wt[++w] = samp[i]
                        md = median(wt, N)
                        th = (metric == "cold_s") ? TH : CTH
                        fires = 0
                        if (md > 0) fires = (cv > md * (1 + th / 100))
                        else if (metric != "cold_s" && cv > 0) fires = 1
                        # A zero median with a non-zero current is an unbounded
                        # rise, not an absent comparison. The `md > 0` guard
                        # exists to protect the division; letting it also decide
                        # whether to report would drop the strictest form of the
                        # regression the counts watch for. A wall time is
                        # excluded because a 0.0s prior median means the harness
                        # did not run, not that the build was free.
                        if (fires) {
                            pctstr = (md > 0) ? sprintf("%.1f", (cv / md - 1) * 100) : "inf"
                            if (metric == "cold_s")
                                printf("consumer-median\tconsumer/%s\t%s\t%.4f\t%.4f\t%s\n", fixture, metric, cv, md, pctstr)
                            else
                                printf("consumer-median\tconsumer/%s\t%s\t%.0f\t%.0f\t%s\n", fixture, metric, cv, md, pctstr)
                        }
                        delete samp; delete wt
                    }
                }
            }
            ' "$consumer_csv" >> "$out"
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
                          [--compile CSV] [--runtime CSV] [--consumer CSV]
                          [--build-wall SECONDS --budget SECONDS]
  perf_history.sh compare --data-dir DIR --sha SHA --out FILE
                          [--min-runs N] [--threshold-pct PCT]
                          [--count-threshold-pct PCT] [--budget SECONDS]
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
