# Shard weights regenerated from corrected per-file timing (2026-08-31)

Measurement record for SFN-1223. Regenerates `compiler/tests/shard_weights.tsv`
from the first CI run whose sidecars carry SFN-1222's `file_elapsed_ms`, and
settles three questions the SFN-863 / SFN-883 / SFN-891 / SFN-1220 chain left
open: what the old weights actually encoded, whether the corrected weights are
partition-invariant, and whether SFN-869's target list survives.

**Headline.** Measured out-of-sample on the first CI run carrying the
corrected table, the e2e leg spread falls on every target: linux-arm64
**1.85x -> 1.26x**, linux-x86_64 **1.73x -> 1.44x**, macos-arm64
**1.21x -> 1.10x**, cutting 20% / 30% / 11% off each target's e2e critical
path (section 5). The weights are nonetheless **not** partition-invariant —
neither across targets nor across runs — so SFN-863's "target-neutral by
construction" claim is downgraded here to *ranking signal*, and 1.0x is not
reachable by repartitioning alone.

## Provenance

| field | value |
| --- | --- |
| run | [33407348555](https://github.com/SailfinIO/sailfin/actions/runs/33407348555) |
| head | `7133ccae` (PR #3172, the SFN-1222 fix) |
| date | 2026-08-31 |
| targets | `linux-arm64`, `macos-arm64` |
| sidecars | 16 artifacts, 14,344 `test` rows, **100%** carrying `file_elapsed_ms` |
| files | 880 per target (previous table: 777) |

CI's own `shard-weights-candidate` job ran the corrected
`scripts/aggregate_shard_weights.sh` on these artifacts. Its
`shard_weights.candidate.tsv` and an independent local regeneration are
**byte-identical** over all 880 data rows, so the applied table is reproducible
from the artifacts rather than trusted from one execution.

## 1. What the old weights encoded

Recomputing the *old* method (`duration_ms`) and the *new* method
(`file_elapsed_ms`) over the **same** sidecars isolates the divisor with no
run-to-run confound. If SFN-1222's diagnosis is right, the ratio between them
must be exactly proportional to each file's test count.

    (new / old) / test_count  over 880 files:
      mean 0.3830   min 0.3756   max 0.4023   sd 0.0031   cv 0.82%

A single constant, to under one percent, across three orders of magnitude of
test count: no file departs from it by more than 5%. The old weight of a file
was its new weight divided by its test count, times one suite-wide constant
(0.383, explained below). This confirms SFN-1222's diagnosis at suite scale
rather than on the seven files it sampled.

Worked examples (same run, both methods):

| file | tests | old | new | ratio |
| --- | ---: | ---: | ---: | ---: |
| `dep_closure_prewarm_test.sfn` | 1 | 136,610 | 52,784 | 0.39x |
| `work_dir_parity_test.sfn` | 2 | 137,700 | 106,411 | 0.77x |
| `build_json_schema_test.sfn` | 9 | 5,991 | 20,836 | 3.48x |
| `closure_capture_test.sfn` | 10 | 429 | 1,633 | 3.81x |
| `capsule_artifact_sidecar_test.sfn` | 18 | 577 | 3,957 | 6.86x |

The global 0.383 factor is suite-total normalisation: summing undivided file
elapsed makes the denominator ~2.6x larger, so every share shrinks uniformly.
That factor is common to all files and cancels in the partition; the
`test_count` factor does not, and is the whole bug.

## 2. Is the corrected weight partition-invariant?

**No, on both axes.** Reported plainly, per SFN-1223's acceptance criteria.

**Across targets, within one run.** The same file's share of its own target's
suite, `macos-arm64` over `linux-arm64`:

    geomean 1.149    p10 0.826   p50 1.118   p90 1.657   (raw, median included)
    4.3% of files outside 0.5x-2.0x

A file does not have *a* weight; it has one per target, spanning a 2.0x band
between the deciles. `max over targets` therefore selects whichever target
gave that file the larger share of its **own** suite — not whichever host is
slower, which is precisely what normalising by suite total cancels. That is a
defensible conservative choice, but it is not the targets agreeing on a
number, and the table should not be described as if it were.

The 1.118 median is composition, not a uniform per-file penalty: macos-arm64's
suite total is 8565 s against linux-arm64's 5088 s (1.68x), and the heavy tail
does not scale by that same factor on both hosts, so the median file takes a
slightly larger slice of the macos suite.

**Across runs, same method.** Comparing the old method on this run against the
committed table (same method, run 31816730331), so the only variable is the
run:

    n=772 common files
    geomean 0.869    p10 0.575   p50 0.867   p90 1.314   (raw, median included)
    9.5% of files outside 0.5x-2.0x

The 772 is not a coverage regression. Of the five old-table paths absent from
the new one, four were deleted from the tree (`agent_report_abort_test.sfn`,
`check_phase_ledger_test.sfn`, `make_report_contract_test.sfn`,
`make_result_contract_test.sfn`) and one was renamed
(`lowering_diagnostic_gate_integrity_test.sfn` ->
`lowering_error_diag_gate_integrity_test.sfn`, present in the new table). No
live file loses a measured weight and falls back to the default.

The 0.869 median shift is suite growth, not drift — 777/880 = 0.883 dilutes
every share by almost exactly that factor. The *spread around* it is the real
signal: **once that median shift is divided out**, the p10-p90 band is
0.66x-1.51x, and one file in ten moves by more than 2x between runs. (The raw
band quoted above, 0.575x-1.314x, still carries the dilution.)

**Consequence.** The weight table is a *ranking* signal that is stable enough
to separate a 100,000-weight file from a 500-weight file, and far too noisy to
be read as a per-file cost model. The generated table header and
`docs/conventions/ci-test-topology.md` are updated to say so.

## 3. Measured leg spread

Per SFN-1223, **measured wall-clock only**. The modeled figure under the new
table is 1.0001x; it is recorded here solely to note that it is not evidence.
SFN-883's table modeled its four legs balanced to 32 parts in 268,000 — a
0.01% predicted imbalance — and those same legs measured between 1.48x and
1.85x across the two runs below. A modeled figure has been wrong by three
orders of magnitude once already; it does not get cited again.

**Same-day control** (run 33407348555, old table applied), e2e legs:

| target | a | b | c | d | spread |
| --- | ---: | ---: | ---: | ---: | ---: |
| linux-x86_64 | 1275 s | 1768 s | 1074 s | 1025 s | **1.73x** |
| linux-arm64 | 963 s | 1317 s | 841 s | 710 s | **1.85x** |

These are the numbers section 5 measures the corrected table against.

SFN-1223's stated baseline was 1.60x / 1.48x from an earlier run. The same
table measured on this run gives 1.73x / 1.85x — so the imbalance itself is not
stable run to run, and any single-run baseline is one sample. Both figures are
carried forward.

`macos-arm64` e2e legs are grouped with other shards (SFN-873) and are not
comparable as pure e2e legs: 1703 / 1904 / 1827(+int-caps) / 2069(+unit-b) s.

**The legs are almost entirely test time.** Step-level timing on the
linux-arm64 e2e legs — the compiler arrives as a downloaded artifact, so there
is no build to amortise:

| leg | `Test shard` step | leg total | fixed overhead |
| --- | ---: | ---: | ---: |
| e2e-a | 938 s | 963 s | 25 s |
| e2e-b | 1290 s | 1317 s | 27 s |
| e2e-c | 812 s | 841 s | 29 s |
| e2e-d | 682 s | 710 s | 28 s |

This retires SFN-1220's proposed mechanism as a *material* cause on these legs:
per-leg fixed setup is 25-29 s against 682-1290 s of test time — at worst 4.1%,
and mostly a 14 s LLVM toolchain install (the compiler arrives as a downloaded
artifact; there is no build to amortise). It is real, it is a per-leg constant,
and it cannot produce a 1.85x spread.

## 4. Does the corrected table fix it?

Repartitioning this run's **measured** per-file work (`file_elapsed_ms`, deduped
per target) under the old and new leg memberships. Same work, same run, only the
assignment changes:

| target | partition | a | b | c | d | spread |
| --- | --- | ---: | ---: | ---: | ---: | ---: |
| linux-arm64 | old | 949 s | 1292 s | 960 s | 744 s | 1.74x |
| linux-arm64 | **new** | 1009 s | 952 s | 1000 s | 984 s | **1.06x** |
| macos-arm64 | old | 1721 s | 1844 s | 1651 s | 1447 s | 1.27x |
| macos-arm64 | **new** | 1538 s | 1712 s | 1660 s | 1754 s | **1.14x** |

Totals are conserved exactly — 3945.0 s and 6663.7 s under both partitions —
so this is redistribution, not a measurement artifact. (Per-leg figures are
rounded, so a column may sum to 6663 or 6664.) The corrected partition moves
~74% of e2e files to a
different leg — 67-73 of each leg's 91-96 files — so it is a genuine
repartition, not a refresh at the margin.

Measured work tracks measured wall-clock closely on these legs — work divided
by the `Test shard` step is 1.01, 1.00, 1.18, 1.09 — which is what makes the
retrodiction meaningful, and also bounds how much of it can survive. That
conversion is itself 18% wide, so **even a perfectly balanced work partition
lands near 1.18x wall-clock** on these four legs. Balancing work is necessary
for convergence; it is not sufficient, and 1.0x is not reachable by
repartitioning alone.

**Two honest caveats.**

1. **This is in-sample.** The table was derived from run 33407348555 and is
   scored on run 33407348555. Section 2 measured the out-of-sample penalty
   directly: weights move with a p10-p90 band of 0.66x-1.51x between runs, so
   expect the realised spread to land above 1.06x.
2. **`macos-arm64` keeps a 1.14x residual** even in-sample, and that is the
   price of one shared table: section 2's cross-target disagreement means a
   partition that balances linux cannot also balance macos.

**Prediction, to be checked out-of-sample on the first run carrying this
table:** linux-arm64 e2e spread falls from 1.85x to roughly **1.2x-1.4x** —
the ~1.18x floor from the work-to-wall conversion above, widened by the
out-of-sample weight drift measured in section 2.
`linux-x86_64` should improve too but by less and less reliably — it emits no
sidecars, so every one of its weights is extrapolated from the two arm64
targets, across exactly the cross-target gap section 2 measured.

## 5. Out-of-sample result

Run [33418715318](https://github.com/SailfinIO/sailfin/actions/runs/33418715318)
is the first CI run carrying the regenerated table. It is a different run from
the one the weights were derived from, so this is the real test — everything in
section 4 was retrodiction.

| target | old table (33407348555) | spread | **new table (33418715318)** | **spread** | critical path |
| --- | --- | ---: | --- | ---: | ---: |
| linux-x86_64 | 1275 / 1768 / 1074 / 1025 s | 1.73x | 1209 / 1130 / 854 / 1233 s | **1.44x** | 1768 -> 1233 s (**-30%**) |
| linux-arm64 | 963 / 1317 / 841 / 710 s | 1.85x | 1057 / 985 / 840 / 877 s | **1.26x** | 1317 -> 1057 s (**-20%**) |
| macos-arm64 | 1703 / 1904 / 1827 / 2069 s | 1.21x | 1788 / 1837 / 1775 / 1670 s | **1.10x** | 2069 -> 1837 s (**-11%**) |

Against SFN-1223's stated 1.60x / 1.48x baseline, both linux targets now come
in under it (1.44x and 1.26x). `macos-arm64` legs are grouped with other shards
(SFN-873), so its figures cover more than e2e and are not directly comparable
to the arm64 e2e-only numbers — the direction still agrees.

**The prediction held.** Section 4 predicted linux-arm64 at 1.2x-1.4x, floored
near 1.18x by the work-to-wall conversion; it measured **1.26x**. It also
predicted `linux-x86_64` would improve by less because every one of its weights
is extrapolated from the arm64 targets; it did (1.44x against 1.26x). The
in-sample 1.06x did not survive contact with a new run, exactly as caveat 1
said it would not.

linux-arm64's `Test shard` step spread is 1.27x against a 1.26x leg spread,
confirming these legs remain test-dominated and that the residual is in the
tests, not in leg overhead.

**Where the remaining 1.26x lives.** Roughly 1.18x of it is the work-to-wall
conversion (section 4) — pooling and tail effects inside a leg, not
misallocation between legs. The rest is the run-to-run weight drift of section
2. Neither is addressable by re-partitioning, which is the negative half of
this result: the weight table has now done nearly all it can do, and further
e2e critical-path reduction has to come from making the heavy files cheaper
(SFN-869, SFN-1221) rather than from moving them around.

## 6. Rulings on dependent issues

**SFN-869** (per-file dedup on the e2e heavy tail) — **strategy survives,
target list does not.** Its approach is independent of this bug. Its targets
were picked off contaminated rankings, and only **5 of the top 15** e2e files
survive re-ranking:

| corrected top 15 (e2e) | weight | in old top 15? |
| --- | ---: | --- |
| `work_dir_parity_test.sfn` | 106,411 | yes |
| `dep_closure_prewarm_test.sfn` | 52,784 | yes |
| `test_bin_cache_test.sfn` | 44,379 | yes |
| `test_shared_runtime_obj_cache_test.sfn` | 30,217 | no |
| `run_cache_flags_test.sfn` | 28,320 | no |
| `workspace_default_members_cli_test.sfn` | 27,527 | yes |
| `build_json_schema_test.sfn` | 20,836 | no |
| `dep_object_cache_test.sfn` | 17,133 | yes |
| `test_filter_cache_key_test.sfn` | 14,235 | no |
| `runtime_demand_driven_sources_test.sfn` | 14,095 | no |
| `runtime_obj_shared_cache_test.sfn` | 12,701 | no |
| `add_registry_index_test.sfn` | 12,088 | no |
| `tensor_matmul_exec_test.sfn` | 11,428 | no |
| `bench_consumer_test.sfn` | 11,391 | no |
| `array_map_closure_test.sfn` | 10,717 | no |

The direction of the error is the opposite of what it looks like. Dividing by
test count *suppressed* multi-test files and left single-test files intact, so
the old ranking promoted the thin ones: the ten files that fell out of the top
15 carry **17 tests between them** (eight are 1-2 test files), while the ten
that replaced them carry **46**. What the old table hid was precisely the
multi-test heavy tail SFN-869 exists to attack. SFN-869 should be requalified
against this list, not the SFN-883 one.

**SFN-1221** (the two heaviest e2e fixtures) — **premise intact.**
`work_dir_parity_test.sfn` and `dep_closure_prewarm_test.sfn` are still the two
heaviest after correction; only their order swaps. Both are 1-2 test files, the
regime where the old division was near-identity, which is why they survived.

**SFN-1224** (silent table decay, `_shard_default_weight`) — **no new hazard
from this table.** The median moves 282 to 447 with the rescale, but the
unchanged constant 2136 sits at p89.2 under the old table and p90.9 under the
new one. It remains a conservative high estimate at the same percentile, so
applying this table does not make an unlisted file's weight newly wrong.
SFN-1224 should still derive it from the table, and when it does, the comment
at `compiler/src/cli/commands/test/arg_and_jobs.sfn:316-319` needs correcting
with it — it still calls 2136 the "Median weight of the generated table",
which this table's own header now explicitly contradicts. Not urgent because
of this change.

## Reproducing

```bash
gh run download 33407348555 -R SailfinIO/sailfin -p 'ci-test-timing-*' -D ci-timing
scripts/aggregate_shard_weights.sh ci-timing compiler/tests/shard_weights.tsv
sfn dev shard list e2e-a
```

Leg durations come from the Actions API (`gh api
repos/SailfinIO/sailfin/actions/runs/<id>/jobs`); the `Test shard` step
timings come from the same payload.
