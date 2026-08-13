# RCA: CI e2e Shard Time Doubled When the Runtime Gained a `sfn/crypto` Dependency Edge

- **Date:** 2026-08-13
- **Author:** Opus (with Michael Curtis)
- **Severity:** High — PR CI wall time +93%; ~68 additional runner-minutes per
  run across the linux-x86_64 shard matrix, paid on every PR and every target
- **Affected range:** `main` from `8a67001e` (2026-08-09) onward; still present
  at `76329349`
- **Status:** Open. Diagnosis complete and measured; no fix landed. Tracked as
  SFN-860 through SFN-869 (see [Tracked work](#tracked-work)).

## TL;DR

`b20a31ec` (#2857) swapped the `tls_*` runtime surface off OpenSSL onto the
native Sailfin TLS 1.3 stack and declared `[dependencies] "sfn/crypto" = "*"`
in `runtime/capsule.toml`. That dependency edge is unioned into *every*
project's resolution, and `_runtime_retain_root_flags`
(`compiler/src/build/link.sfn:172-198`) then force-roots every defined global
whose name contains `sfn` via `-Wl,-u,`, defeating `--gc-sections` for the
whole reachable closure.

Under OpenSSL those roots terminated at *dynamic* `SSL_*` symbols and cost
zero static bytes. After the swap they reach ~15k lines of pure-Sailfin
crypto that must be statically linked into every binary.

The TLS swap itself is correct and its intrinsic cost is small: **+15.8 KB**.
The over-retention multiplies that by roughly 20x to **+300.8 KB**, and the
front-end cost of emitting the widened closure — not the link — is what
doubled CI.

## Impact

Sum of the eight `linux-x86_64` shard jobs, per `ci.yml` run:

| period | mean | range |
|---|---|---|
| 2026-07-05 → 08-08 (n=13) | 4,394 s | 3,877–5,855 |
| 2026-08-10 → 08-13 (n=5) | 8,468 s | 7,916–8,738 |

**1.93x.** The two populations are fully separated — `max(pre) 5,855 <
min(post) 7,916` — across 18 different branches. Corroborated independently by
`main`'s scheduled series, which sat at 1,982–2,544 s for nine consecutive days
through 08-08, then stepped to 4,292 s on 08-09 and 5,483 s on 08-10.

The step lands between the 2026-08-08 11:21 UTC and 2026-08-09 11:22 UTC
scheduled runs, i.e. `main` range `15c14e0f..8a67001e`.

Per-shard test-step ratios, `2bf1c4d3` (08-08) → `32197d12` (08-13):

| shard | before | after | ratio |
|---|---|---|---|
| unit-a | 391 s | 464 s | 1.19x |
| unit-b | 332 s | 379 s | 1.14x |
| unit-c | 359 s | 442 s | 1.23x |
| int-caps | 319 s | 454 s | 1.42x |
| e2e-a | 767 s | 2,065 s | **2.69x** |
| e2e-b | 394 s | 1,243 s | **3.15x** |
| e2e-c | 800 s | 1,665 s | **2.08x** |
| e2e-d | 854 s | 1,537 s | **1.80x** |

Aggregate: unit + int-caps **1.18x**, e2e **2.45x**.

The asymmetry is the mechanism. 308 of 325 e2e files spawn nested
`sfn build`/`test`/`run` subprocesses (1,285 spawn call sites); unit tests
build once and do not fan out. A per-build regression is therefore multiplied
by the e2e fan-out and barely visible in unit.

Test count over the same window grew only 5% (78 → 82 files in `e2e-a`), and
job overhead — checkout, apt, artifact download, cache restore — stayed flat at
30–65 s per shard. Neither explains the step.

## Measurements

Same seed (0.9.5) against three worktrees, same trivial `print("hi")` program,
`SAILFIN_RUNTIME_ROOT` pointed at each tree's runtime. Holding the seed fixed
isolates runtime/capsule-closure effects from compiler changes.

| | `15c14e0f` (pre) | `8a67001e` | `76329349` (HEAD) |
|---|---|---|---|
| binary bytes | 162,072 | 383,776 | 475,832 (**2.94x**) |
| link objects | 1 | 29 | 35 |
| `.sfn-asm` emitted per build | 33 | — | 102 (**3.09x**) |
| `.layout-manifest` | 0 | — | 34 |
| `.text` | 92,207 | — | 333,093 |
| build wall | 11.96 s | — | 27.99 s (**2.34x**) |
| peak RSS | 278 MB | — | 494 MB |
| `libssl`/`libcrypto` NEEDED | yes (22 undef) | — | no (0) |

Window 1 accounts for 71% of the growth; the subsequent crypto burst
(AES-GCM, TLS records, RSASSA-PSS, ECDSA P-384) accounts for the rest.

The **2.34x per-build wall time maps almost exactly onto the measured 2.45x
e2e shard ratio.**

### Attribution: 95% is the retain-root policy, not the TLS swap

Relinking HEAD's *identical* object set under different root sets:

| link variant | size | crypto text syms |
|---|---|---|
| all roots (reproduces the real build) | 483,824 | 434 |
| roots minus TLS/HTTP/WS/serve/cert_roots objects | **127,824** | **0** |
| no roots at all | 43,608 | 0 |
| *pre-regression tree, actual* | *167,256* | *—* |

Of the +316,568 B delta, **+300,784 B (95%) is the retain-root policy** and
only **+15,784 B (5%) is intrinsic** to needing native TLS.

Scoping the roots would put HEAD binaries at **127,824 B — 24% smaller than
the pre-regression 167,256 B**, because the OpenSSL dynamic-link overhead
disappears too.

## Mechanism

Three components compound:

1. **`compiler/src/capsule_resolver/discovery.sfn:414-453`** unions the runtime
   capsule's `[dependencies]` into every project's resolution.
2. **`compiler/src/build/link_contract.sfn:40-67`** (`missing_runtime_dep_specs`)
   *enforces* that every declared runtime dep contributes to the link set.
   Reaching every link is a checked invariant, not an accident.
3. **`compiler/src/build/link.sfn:172-198`** (`_runtime_retain_root_flags`)
   shells `nm` over the runtime objects and emits `-Wl,-u,<name>` for every
   defined global matching `/sfn/`:

   ```
   nm ... | awk 'NF >= 3 && $2 ~ /^[A-TV-Z]$/ && $3 ~ /sfn/ {print $3}' | sort -u
   ```

   Every such symbol becomes an undefined-symbol root, so `--gc-sections`
   cannot drop its closure.

`link.sfn:352-355` already documents this exact hazard — that including
program/capsule objects in the root set "would force-retain their entire
closure and defeat dead stripping." The guard holds literally: all 35 crypto
objects are `runtime-native`, not capsule objects. The closure is retained
*transitively* anyway, which the guard does not cover.

`runtime/capsule.toml:96-106` shows the cost was anticipated in kind but not in
magnitude — the declaration was "deliberately held back from that PR so the
per-binary ctor floor is paid where the benefit lands (SFN-341)." A per-binary
*ctor floor* was expected; a 2x CI regression was not.

## Where the time actually goes

**Not the link.** Linking is 0.09 s at HEAD vs 0.08 s pre-regression.

The 16 s per-build delta is the front end. `compiler/src/capsule_emit_parallel.sfn`
spawns a child compiler process per module (`_cr_emit_child_argv:647`,
`spawn_with_env:498`) with **no emit-level cache gate**. A HEAD build reported
`[cache] hits=69 misses=0` — every `.o` served from cache — yet still emitted
102 `.sfn-asm` and 34 `.layout-manifest`. So ~34 extra child compiler processes
run per build regardless of object-cache state.

Under the e2e test pool these are pinned to `SAILFIN_BUILD_JOBS=1` (SFN-547) so
they run **serially**, and 308 of 325 e2e files pay it per nested build.

## The two defects

**Defect A — unscoped retain roots.** `_runtime_retain_root_flags`
(`compiler/src/build/link.sfn:172-198`), applied unconditionally at its call
site (`link.sfn:336-351`). Its own stated justification is partly that "the
C→Sailfin migration tests assert the compiler binary keeps the full `sfn_*`
family defined" — a test assertion about **one** binary, paid by **every**
binary. Gating the root set on producing a provider surface (the compiler
binary or the shipped runtime archive) rather than final executables, or
excluding the networking/TLS runtime objects from the root set, takes HEAD
below the pre-regression size with zero crypto retained.

**Defect B — no emit-level cache.** `capsule_emit_parallel.sfn` re-emits every
module's `.sfn-asm`/`.layout-manifest` even on a full object-cache hit. A
key/`fs.exists` gate mirroring the existing object cache would remove the
~34 redundant child compiler processes per build.

## Contributing conditions

These did not cause the regression but let it run unnoticed and amplified it:

- **The busiest lane reports no timing.** `single_process_run.sfn:411` computes
  `file_elapsed_ms` on every path, then lines 439 and 506 print
  `[test] PASS: <name>` and discard it. Per-file timing survives only under
  `--json`, which `.github/actions/sailfin-build/action.yml:409-414` enables
  solely on `macos-arm64` and `linux-arm64`, to read one unrelated field
  (`cache.test_bin_hit_rate`). A 2x regression on `linux-x86_64` was invisible
  for five days.
- **Per-shard times do not exist on `main`.** The `Build + Test` matrix is
  skipped on scheduled runs in favour of a cold soak, so the trend had to be
  reconstructed from PR runs on 18 different branches.
- **The shard map is file-count balanced, never time-weighted.**
  `dev_shard.sfn:59-89` plus the modulo stride in
  `test/arg_and_jobs.sfn:255-258` partition an alphabetically sorted list, which
  clusters by name prefix. Measured skew 2.13x (e2e-a 3,716 s vs e2e-b 1,746 s);
  `e2e-a` owns 6 of the surface's 10 slowest files. A greedy LPT repartition of
  the identical files yields `[2712, 2714, 2712, 2714]` s — critical path
  −27% with no test changed. `sfn dev shard cover` proves the partition is
  disjoint and complete but says nothing about time, so this drifted silently.
- **A heavy head predates the regression.** 16 of 325 e2e files (4.9%) hold 47%
  of e2e time; four run `make compile` or `sfn build -p compiler` *inside* an
  e2e test (`work_dir_parity` 840 s, `build_json_schema` 628 s,
  `make_result_contract` 493 s, `make_report_contract` 399 s).
- **Whole-shard retry-once.** `.github/actions/sailfin-build/action.yml:448-460`
  re-runs the entire shard on any failure, so shard duration is bimodal and
  single-run comparisons can mislead.

## Tracked work

The regression itself is the first two rows; the rest are conditions this
investigation surfaced, which let a 2x regression run unnoticed or which
independently cost CI time.

| Issue | What | Priority |
|---|---|---|
| SFN-860 | Scope the runtime retain-root set (Defect A — the regression) | Urgent |
| SFN-861 | Gate `.sfn-asm`/`.layout-manifest` emit on a cache key (Defect B) | High |
| SFN-862 | Report per-file durations + slowest-N on the default path | High |
| SFN-863 | Time-weight the shard map (2.13x skew, −27% critical path) | High |
| SFN-864 | Stop self-hosting the compiler inside four e2e tests | Medium |
| SFN-865 | Test-bin cache: 0% hits while still paying a 282 MB save | Medium |
| SFN-866 | No shard timing baseline (no metrics on x86_64, no matrix on `main`) | Medium |
| SFN-867 | Whole-shard retry-once makes shard duration bimodal | Low |
| SFN-868 | Seed bundle declares a runtime dep it ships no sources for | High |
| SFN-869 | The e2e heavy tail beyond the four self-hosting outliers | Medium |

SFN-860 carries `needs-design`: scoping the roots changes link behaviour and
requires adjusting the migration-test assertions that motivated the broad root
set. SFN-863 is blocked by SFN-862 — a time-weighted map needs per-file timing
to weight from.

## Confidence and falsifiers

High (~90%). The causal chain is measured end-to-end, and the three-way relink
isolates the root policy from the dependency edge. Known limits:

- Seed 0.9.5 was used against all three trees rather than each tree's own
  pinned seed, deliberately, to isolate closure effects from compiler changes.
  A compiler-side contribution inside the window would be invisible to this
  method. **Falsifier:** building the pre-regression tree with seed 0.9.1 yields
  materially different numbers.
- A minimal program was measured, not a real test binary. **Falsifier:** a real
  e2e test binary showing crypto not retained, or a size ratio far from 2.07x.
- Defect B is inferred from artifact counts plus the absence of a cache gate in
  the code, not from a phase-level profile. **Falsifier:** `make bench` showing
  emit time flat and the delta elsewhere.

`9c940670` (#2846, `fix(lowering): resolve imported modules at minimum depth`)
was the leading initial suspect and is **refuted** — it does not widen the
emitted closure.

## Reproduction

```bash
git worktree add --detach /tmp/wt-old 15c14e0f
mkdir -p /tmp/wt-old/capsules/sfn/zhello/src
printf 'fn main() -> void ![io] {\n    print("hi");\n}\n' \
  > /tmp/wt-old/capsules/sfn/zhello/src/main.sfn
printf '[capsule]\nname = "sfn/zhello"\nversion = "0.1.0"\nkind = "binary"\nentry = "src/main.sfn"\n' \
  > /tmp/wt-old/capsules/sfn/zhello/capsule.toml
cd /tmp/wt-old/capsules/sfn/zhello && SAILFIN_RUNTIME_ROOT=/tmp/wt-old/runtime \
  timeout 900 build/toolchains/seed/versions/0.9.5/sfn \
  build src/main.sfn --work-dir /tmp/wk-old -o /tmp/hello-old
# repeat at HEAD, then compare:
size -A /tmp/hello-old /tmp/hello-head
nm /tmp/hello-head | grep -c __sfn__crypto__
```

## Separate finding worth verifying

Seed 0.9.5's bundle ships `runtime/capsule.toml` declaring
`[dependencies] "sfn/crypto"` but no `capsules/` directory, so a standalone
build fails:

```
sfn build: runtime capsule `sfn/runtime-native` declares dependency `sfn/crypto`
but its sources were not found next to .../versions/0.9.5/runtime
```

`locate_runtime_dep_capsule_src` (`compiler/src/capsule_resolver/locate.sfn:113+`)
expects `<prefix>/capsules/<scope>/<name>/src`. This may be an artifact of
partial local seed extraction rather than the published release asset — verify
against a real release tarball before filing.
