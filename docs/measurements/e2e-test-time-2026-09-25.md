# E2E test-time follow-up — 2026-09-25

Source: [PR CI run 36058353248](https://github.com/SailfinIO/sailfin/actions/runs/36058353248),
successful on 2026-09-24. This is a follow-up to the
[September 22 audit](test-time-2026-09-22.md), after exhaustive compiler
work-directory parity moved to nightly soak. Timings below come from the
run's `ci-test-timing-*` JSONL artifacts. Per-file values deduplicate
`file_elapsed_ms` by file; they are not additive wall-clock estimates when
files execute concurrently.

| Target | E2E shard job range | E2E per-file elapsed sum | Longest E2E shard |
| --- | ---: | ---: | ---: |
| Windows x86_64 | 59–72 min | 19,704 s | e2e-c, 72 min |
| macOS arm64 | 28–51 min, including grouped unit/integration work | 9,042 s | e2e-c + int-caps, 51 min |
| Linux x86_64 | 23–27 min | No per-file sidecars | e2e-b, 27 min |
| Linux arm64 | 15–22 min | 4,778 s | e2e-d, 22 min |

The shared compiler build precedes these jobs: 13 minutes on Windows,
9 minutes on Linux x86_64, and 3 minutes on macOS arm64 in this run.
Consequently even a 20-minute shard ceiling would not by itself make the
whole PR gate finish in 20 minutes.

The four Windows e2e shards each own about 102–103 files and report
4,342–5,387 seconds of deduplicated per-file work. Their test phases reported
about 57–70 minutes, with only 0–3 test-binary cache hits per shard.
The Windows action leaves per-file parallelism to the native memory-based
budget, while Linux x86_64 and macOS arm64 explicitly request three jobs.
Raising the Windows worker count without measuring peak memory would ignore
the OOM history behind that budget. Splitting Windows e2e into more physical
legs is the safer scheduling experiment, but needs a coverage check and a
run that confirms the available Windows runner capacity.

The most costly Windows e2e files in this run were:

| File | Windows elapsed |
| --- | ---: |
| `runtime_demand_driven_sources_test.sfn` | 791 s |
| `target_flag_cache_key_test.sfn` | 629 s |
| `workspace_default_members_cli_test.sfn` | 615 s |
| `test_bin_cache_test.sfn` | 556 s |
| `toolchain_dispatch_test.sfn` | 491 s |
| `run_cache_flags_test.sfn` | 435 s |
| `user_config_precedence_test.sfn` | 423 s |
| `test_shared_runtime_obj_cache_test.sfn` | 383 s |

This change combines the cold, warm, bypass, and source-edit checks in
`test_bin_cache_test.sfn` into one fixture lifecycle: four nested `sfn test`
invocations instead of six. It also combines warm shared-runtime-cache and
`--no-test-cache` checks against one genuinely cold baseline: three nested
invocations instead of four. The assertions and subprocess behavior remain
covered. A new cross-platform CI run is required to measure the wall-clock
gain; the old file times cannot establish it.

## Path to a 20-minute test-phase target

1. Measure the next run's test phase and worker count per target, separately
   from checkout, cache transfer, and shared compiler build.
2. Profile the remaining six Windows files above that perform repeated nested
   builds. Preserve cold/invalidation assertions, but share setup within each
   file where the scenarios permit it. `runtime_demand_driven_sources` and
   `target_flag_cache_key` are platform-skewed and need Windows measurements.
3. Trial finer Windows-only e2e partitioning with the existing weighted
   partitioner, retaining an exhaustive cover assertion. Compare actual job
   wall time and queue delay before adopting it. At the current 19,704-second
   aggregate, 16 perfectly balanced serial legs would have a 20.5-minute
   per-leg lower bound before setup, so 16 is insufficient if the workload
   does not shrink. Around 20 legs gives a 16.4-minute arithmetic lower bound,
   but runner availability and skew decide the observed result.
4. Keep compiler-scale parity and other long soak checks on nightly/release
   gates as documented in [CI test topology](../conventions/ci-test-topology.md);
   do not remove language or runtime regression coverage merely to meet a
   wall-clock number.
