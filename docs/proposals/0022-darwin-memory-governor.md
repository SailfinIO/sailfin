---
sfep: 22
title: Darwin (macOS arm64) Memory Governor
status: Accepted
type: runtime
created: 2026-06-20
updated: 2026-07-24
author: "agent:compiler-architect"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# Darwin (macOS arm64) memory governor for the Sailfin toolchain

Status: proposal (design only). Spike measurements below were run on this
machine (Apple Silicon, 12 cores, 64 GiB) against seed `0.7.0-alpha.47`.

## 1. Problem (one paragraph)

On Linux the toolchain self-applies an 8 GiB `RLIMIT_AS` at startup
(`runtime/sfn/platform/rlimit.sfn:130` `apply_default_mem_limit`, called from
`compiler/src/cli_main.sfn:2930`), inherited across fork/exec so every emit
worker + `clang`/`llvm-link` child runs under the same hard cap. On Darwin that
function returns early at `rlimit.sfn:136` (`/proc/self/status` absent), so the
macOS toolchain has **zero memory backpressure**. A single `sfn test` fixture
build fans out to `min(nproc, 8)` parallel `sfn emit` workers
(`capsule_resolver.sfn:436` `_cr_resolve_jobs`, dispatched via `xargs -0 -P N`
at `capsule_resolver.sfn:738`), each of which can peak in the multi-GB range
(measured below). On a ~7 GiB `macos-26` CI runner, 8 concurrent uncapped emits
blow past RAM and the kernel (Jetsam) SIGKILLs them — the 216×137 / 2×134
pattern on PR #1532's `int-e2e-caps` shard. `int-e2e-caps` tips first because it
is the only shard that builds binaries (integration + e2e + capsule fixtures).

## 2. Spike results (measured, not assumed)

### 2.1 What the kernel exposes (symbol reachability)

All in `libsystem_kernel.dylib` (`nm -gU`), reachable as plain externs — no new
C runtime needed for the observe path:

| Symbol | Reachable | Verdict |
|---|---|---|
| `proc_pid_rusage` | yes | **observe** — `RUSAGE_INFO_V2.ri_phys_footprint`, flat struct, `getpid()` arg, no mach port |
| `task_info(TASK_VM_INFO)` | yes | observe — `phys_footprint`, but needs `mach_task_self()` + count dance |
| `task_set_phys_footprint_limit` | yes (in SDK header) | **rejected — does not enforce** |
| `setrlimit`/`getrlimit` | yes | already used; `RLIMIT_AS`/`RLIMIT_DATA` **rejected** |
| `sysctlbyname` | yes | **used** — `hw.memsize` for RAM-aware fan-out |

### 2.2 Hard-cap mechanisms — all ruled out on Darwin

Confirmed by `clang`-compiled probes (`/tmp/sfn_spike/*.c`):

- **`RLIMIT_AS`**: on Darwin `RLIMIT_AS == 5 == RLIMIT_RSS` (not 9 as on Linux).
  `setrlimit(RLIMIT_AS, 2 GiB)` returns `-1 / EINVAL(22)`; a 3 GiB touch
  survived. Not honored. (Matches the prompt's diagnosis.)
- **`RLIMIT_DATA`** (resource 2): `setrlimit(RLIMIT_DATA, 256 MiB)` also returns
  `-1 / EINVAL(22)`; even ignoring that, a 400 MiB `malloc`+touch survived —
  Darwin's allocator is mmap-backed, so `RLIMIT_DATA` (brk/sbrk segment) does
  not bound it. Useless here.
- **`task_set_phys_footprint_limit(mach_task_self(), 256, &old)`**: returned
  `kr=8`, and a 400 MiB touch under the "256 MiB cap" survived. It is a
  Jetsam-coordination private API, not a self-imposed hard kill for an ordinary
  process. Rejected.

**Conclusion: there is no inheritable, fork/exec-propagating hard memory cap on
Darwin equivalent to Linux `RLIMIT_AS`.** The Linux design (cap once in `fn
main`, inherit everywhere) has no Darwin twin. This is the load-bearing finding
that shapes the whole design.

### 2.3 Observation works and is accurate

`proc_pid_rusage(getpid(), RUSAGE_INFO_V2)` reported `phys_footprint`
1,245,544 B at start and 211,091,960 B after a +200 MiB touch — tracks
within noise. `task_info(TASK_VM_INFO)` agreed (1,261,928 B). `proc_pid_rusage`
is the simpler call and the recommended observe primitive.

### 2.4 Per-module-emit peak footprint (the number that sizes fan-out)

`SAILFIN_MEM_LIMIT=unlimited /usr/bin/time -l <seed> emit ... llvm <module>`:

| Module | Lines | max RSS | peak footprint |
|---|---|---|---|
| `capsule_resolver.sfn` (heaviest) | 4675 | **3.23 GiB** | 8.5 MiB* |
| `typecheck_types.sfn` (typical-heavy) | 2113 | **1.08 GiB** | 8.5 MiB* |
| `build_stamp.sfn` (small) | 111 | 59 MiB | — |

\* `peak memory footprint` from `time -l` under-reports here (it samples the
final value, not the peak of a short-lived process); **max RSS is the figure
that matters for Jetsam**, and it is what the runtime governor reads live via
`phys_footprint` (which *does* track the peak as it climbs). The headline: a
single heavy-module emit peaks above **3 GiB RSS**. Eight of those concurrently
is ~25 GiB of demand on a 7 GiB runner — exactly the Jetsam trigger.

This is the spike's most important quantitative result: **even 2 concurrent
heavy emits (~6.4 GiB) exceed a 7 GiB runner's usable RAM.** The safe
steady-state fan-out on a 7 GiB runner is effectively **1–2**, not 8.

> Caveat: measured on a 64 GiB machine where the allocator is under no pressure;
> absolute RSS on the constrained runner may differ (the allocator releases more
> aggressively under pressure), but the *ratio* (heavy ≈ 3 GiB, ~30× a small
> module) and the >RAM-on-7GiB conclusion are robust. The exact runner peak
> needs one CI confirmation run (see §7).

## 3. Recommended mechanism: two layers

Because no hard cap exists, the design is **defense-in-depth**, with the cheap
layer carrying almost all the weight:

### Layer 1 (primary, ships first): RAM-aware fan-out governor

Make `_cr_resolve_jobs()` (`capsule_resolver.sfn:436`) **memory-aware on
Darwin**, not just CPU-aware. Today it returns `min(nproc, 8)`. Replace the
clamp with `min(nproc, 8, ram_budget_jobs)` where:

```
ram_budget_jobs = max(1, floor(usable_ram_bytes / per_job_reserve_bytes))
usable_ram_bytes = hw.memsize * SAFETY_FRACTION   (e.g. 0.66)
per_job_reserve_bytes = 3 GiB                       (the measured heavy-emit RSS)
```

On a 7 GiB runner: `floor(7*0.66 / 3) = floor(1.54) = 1` → **serial emit**.
On a 64 GiB dev box: `floor(64*0.66 / 3) = 14` → still clamped to 8 (unchanged
local behavior). On a 16 GiB laptop: `floor(16*0.66/3)=3`.

`hw.memsize` is read via `sysctlbyname` (confirmed reachable). This is **the
fix for the concurrent-clang multiplier** and it is cheap, deterministic, and
needs no per-process monitoring. `SAILFIN_BUILD_JOBS` still overrides
everything (explicit user/CI intent wins, including the existing escape hatch).

Apply the RAM clamp on **all** platforms, not just Darwin — it is a strictly
better default than the blind `min(nproc, 8)` everywhere (Linux benefits too on
small runners), but it is *only load-bearing* on Darwin because Linux still has
the inherited `RLIMIT_AS` hard floor underneath. Gate the *aggressiveness* by
platform if desired (Linux can keep a looser fraction since RLIMIT_AS catches
the tail), but a single shared formula is simpler and the doc recommends that.

### Layer 2 (the real governor, ships second): self-monitor soft cap

A best-effort in-process watchdog that mirrors the Linux *intent* (a per-process
budget the process refuses to exceed), implemented as periodic observation since
no kernel enforcement exists. Add a Darwin branch to
`apply_default_mem_limit()` that, instead of `setrlimit`, **arms a footprint
monitor**:

- A background mechanism polls `proc_pid_rusage(getpid(),
  RUSAGE_INFO_V2).ri_phys_footprint` against the same 8 GiB target (and the
  `SAILFIN_MEM_LIMIT` override / `unlimited`/`off`/`0` disable).
- When footprint crosses the budget, it prints the existing-style
  `[mem-limit] ...` trace and **aborts the process** (a controlled
  `abort()`/`_exit(137)`-style exit) *before* the runner OOMs — converting a
  random Jetsam SIGKILL of an arbitrary victim into a deterministic,
  attributable self-kill of the actual offender, with a diagnostic line.

**Polling vehicle — the honest uncertainty.** Sailfin has no thread/timer
primitive exposed to `runtime/sfn/` today (concurrency runtime is unshipped per
CLAUDE.md). Three options, in order of preference:

1. **Allocator hook (no thread):** wire the check into a coarse allocation path
   so footprint is sampled on a 1-in-N allocation basis. Cleanest (no
   background thread, fully inheritable semantics within one process) but
   requires a hook point in the Sailfin/runtime allocator — needs a feasibility
   probe (does `runtime/native` expose a single malloc choke point we can
   instrument without a C edit?). **Flag: likely needs a small C helper** in
   `runtime/native/src/` (an `extern fn sfn_mem_footprint_check() -> void` that
   does the `proc_pid_rusage` read + threshold compare + abort). This is the one
   place a C helper may be genuinely required; call it out for an architect
   decision rather than forcing pure-Sailfin.
2. **`SIGALRM`/`setitimer` watchdog (C helper):** arm a repeating timer whose
   handler reads `phys_footprint` and aborts past budget. Inheritable across
   fork only if re-armed in the child; `xargs`-spawned `sfn emit` children would
   each re-arm via their own `apply_default_mem_limit()` in *their* `fn main`
   (each worker is a fresh `sfn emit` process — see §4). Needs a C signal
   helper.
3. **Coarse checkpoint calls (pure Sailfin):** insert `mem_footprint_check()`
   calls at a few known-hot loop boundaries in the emitter/lowering. Pure
   Sailfin, no thread, but coverage is only as good as the checkpoint placement
   — misses a single pathological allocation between checkpoints. Lowest risk to
   ship, weakest guarantee.

**Recommendation:** Layer 1 (fan-out) is the actual CI fix and should ship
alone first. Layer 2 is a safety net; implement it as **option 3 (pure-Sailfin
checkpoints) first** (zero new C, mirrors the soft-cap intent), and only escalate
to option 1/2 (C helper) if CI shows single-process emits still OOM after
fan-out is serialized — which the spike suggests they will *not* (a single heavy
emit is ~3 GiB, comfortably under 7 GiB once it's the only one running).

### Why not a hard cap at all

The spike proves Darwin offers no self-imposed hard memory kill. Marketing or
documenting a "macOS memory cap" with the same hard-guarantee language as Linux
would be a "parsed but not enforced"-class overclaim (CLAUDE.md design
framework). The Darwin governor is explicitly a **soft, best-effort** floor;
document it as such. The hard guarantee on Darwin is delivered by *not creating
the over-subscription in the first place* (Layer 1), not by catching it after.

## 4. How the budget propagates across the fan-out

Linux relies on `RLIMIT_AS` inheritance across fork/exec. On Darwin there is no
inherited limit, so propagation is structural:

- The emit workers are **separate `sfn emit` processes** spawned via `xargs -0
  -P N sh worker` (`capsule_resolver.sfn:738`), each running its own `fn main` →
  `apply_default_mem_limit()`. So each worker *independently* arms its own
  Darwin governor (Layer 2) — no inheritance needed; the budget is re-derived
  per process. This is actually cleaner than Linux's inheritance model.
- Layer 1 (fan-out) governs the *parent's* decision of how many workers to
  spawn — it is the only thing that prevents N-way over-subscription, and it
  lives entirely in the parent (`_cr_resolve_jobs`). `clang`/`llvm-link` grand-
  children are not Sailfin processes and cannot self-cap; the only lever for
  them is *also* the fan-out count (fewer parallel `sfn emit` ⇒ fewer concurrent
  `clang`). This reinforces that Layer 1 is the primary mechanism.

## 5. Constraints honored

- **Self-hosting invariant:** all changes are in `capsule_resolver.sfn` and
  `rlimit.sfn` (both compiled into the toolchain). `make compile` must pass
  after each step. The fan-out change is pure arithmetic on existing helpers —
  no new language feature, so the old seed compiles the new compiler (additive).
- **`SAILFIN_MEM_LIMIT` contract** (`.claude/rules/compiler-safety.md`):
  `unlimited`/`off`/`0` must still fully disable. The Darwin branch reuses the
  *exact* env-parsing block already in `rlimit.sfn:142-170` (factor it out so
  Linux and Darwin share one parse), so the disable path and the `< 1 MiB`
  rejection are identical. **Sanitizer legs:** ASAN reserves ~16 TB vmem; the
  fan-out clamp never blocks it (it only reduces parallelism), and the Layer-2
  monitor must early-return under `unlimited`/`off`/`0` exactly as Linux does —
  so an ASAN run with `SAILFIN_MEM_LIMIT=unlimited` arms *no* monitor. Preserved
  by construction.
- **Windows cross-link exclusion** (`rlimit.sfn:47-55`): unchanged. The Darwin
  branch is gated behind a Darwin probe (see §6) that is false on the Windows
  cross-link too; Windows continues to resolve the strong no-op stub in
  `runtime/ir/windows_stubs.ll`. Do **not** add new externs to `rlimit.sfn`
  that the mingw link can't resolve — `proc_pid_rusage`/`sysctlbyname` are
  Darwin-only, so if they live in `rlimit.sfn` they must be added to the
  cross-windows RUNTIME_MODS exclusion *or* (preferred) the Darwin-only externs
  live in a **separate `runtime/sfn/platform/darwin_mem.sfn` module** that is
  itself excluded from the Windows bridge (same precedent as `process.sfn`).
  Pin the exclusion in `test_cross_windows_runtime_modules.sh`'s peer test.
- **#306 inline-extern discipline:** new externs (`proc_pid_rusage`,
  `sysctlbyname`) declared inline at point of use, per the directory convention.
- **Pure-Sailfin goal:** Layer 1 is pure Sailfin. Layer 2 option 3 is pure
  Sailfin. A C helper is only needed for Layer 2 options 1/2 — flagged, not
  assumed.

## 6. Platform detection on Darwin

The Linux gate is `sfn_fs_exists("/proc/self/status")` (`rlimit.sfn:136`). For
the Darwin branch, the symmetric probe is **the absence of `/proc` AND presence
of a Darwin marker**. Cheapest reliable Darwin marker without a `uname`
subprocess: `sfn_fs_exists("/System/Library/CoreServices")` (always present on
macOS, absent on Linux/Windows). Alternatively `sysctlbyname("hw.memsize", ...)`
succeeding (returns 0) is itself a Darwin signal and is the value we need
anyway — prefer that (one call serves detection + the RAM number). The control
flow in `apply_default_mem_limit()`:

```
if /proc/self/status exists      -> Linux path (unchanged setrlimit)
else if sysctlbyname hw.memsize ok -> Darwin path (arm soft monitor / no-op for now)
else                              -> other (Windows stub / unknown): no-op (unchanged)
```

Layer 1's `_cr_resolve_jobs` reads `hw.memsize` via `sysctl -n hw.memsize` (it
already shells `sysctl -n hw.ncpu` at `capsule_resolver.sfn:451`, so the shell
path is established — reuse `_cr_shell_read`, no new extern in that file).

## 7. CI

- **Fix the stale comment** at `ci.yml:~681` ("int-e2e-caps runs serially
  [green]") — it is false; the shard runner is serial (`--jobs 1` in
  `test_shards.sh run`) but each fixture build fans out internally. The comment
  should say the *test runner* is serial while *per-build emit* fans out, and
  reference this governor.
- **Interim stopgap (ship in the same PR as Layer 1, or before it):** set
  `SAILFIN_BUILD_JOBS=1` (or `2`) on the macOS `build-macos` job env in
  `ci.yml`, and on the `build-compiler-macos` job. This is the zero-risk
  unblock — it forces serial emit immediately, independent of any compiler
  change, and is exactly what Layer 1 will compute anyway on a 7 GiB runner. Set
  it as an env on the job and **remove it once Layer 1 lands and a CI run
  confirms the governor self-selects ≤2**. Document the stopgap inline so it is
  not mistaken for a permanent setting.
- **One CI confirmation run** is needed to validate the per-job reserve constant
  (3 GiB) against the runner's real peak RSS, since the spike was on a 64 GiB
  box. If the runner peaks higher under memory pressure, bump `per_job_reserve`
  or `SAFETY_FRACTION`. This is the one number that needs CI validation rather
  than local proof.

## 8. Staged implementation plan (smallest blast radius first)

Each step independently `sfn check`-able and `make compile`-able.

**Step 0 — CI stopgap (no compiler change, ships immediately).**
Set `SAILFIN_BUILD_JOBS=2` (conservative) on the macOS jobs in `ci.yml`. Unblocks
PR #1532's shard now. Verify: re-run `int-e2e-caps`; expect zero 137/134 exits.

**Step 1 — Darwin-aware fan-out governor (Layer 1, the real low-risk fix).**
- `capsule_resolver.sfn:436` `_cr_resolve_jobs`: after the `SAILFIN_BUILD_JOBS`
  override and the `nproc` read, add a RAM clamp: read `sysctl -n hw.memsize`
  via `_cr_shell_read`, compute `ram_budget_jobs` (§3 formula), return
  `min(nproc_clamped, ram_budget_jobs)`. Keep the `SAILFIN_BUILD_JOBS` override
  ahead of the clamp (explicit intent wins).
- Verify: `sfn check compiler/src/capsule_resolver.sfn`; `make compile`; on this
  box confirm `_cr_resolve_jobs` still yields 8 (64 GiB ⇒ 14 clamped to 8);
  add a unit test (§ test strategy) asserting the formula. Then drop the Step-0
  stopgap to `SAILFIN_BUILD_JOBS` *unset* on a trial CI run and confirm the
  governor self-selects ≤2 on the runner. **This is the step that closes the CI
  failure on its own.** Bundle the `ci.yml` comment fix here.

**Step 2 — Darwin branch in `apply_default_mem_limit` (Layer 2 scaffolding,
pure-Sailfin no-op + trace).**
- Factor the `SAILFIN_MEM_LIMIT` parse out of `rlimit.sfn` into a shared helper
  returning `(target, explicit, disabled)`.
- Add the Darwin detection branch (§6). For this step it only emits a
  `[mem-limit] darwin soft monitor armed (target=N)` trace and returns 0 — no
  enforcement yet. Establishes the env contract + detection + Windows-exclusion
  plumbing with zero behavioral risk.
- If Darwin-only externs are introduced, create
  `runtime/sfn/platform/darwin_mem.sfn` and add it to the cross-windows
  exclusion; update `test_cross_windows_runtime_modules.sh`'s peer.
- Verify: `make compile`; `make check`; cross-windows link still resolves;
  `SAILFIN_TRACE_MEM_LIMIT=1 sfn version` on macOS shows the new trace; on Linux
  the trace is unchanged.

**Step 3 — Layer 2 enforcement (pure-Sailfin checkpoint monitor).**
- Add `mem_footprint_check()` reading `proc_pid_rusage`/`phys_footprint`,
  comparing to the budget, aborting past it with a `[mem-limit]` diagnostic.
  Honor `unlimited`/`off`/`0` (no-op). Wire calls at a few hot emit/lowering
  loop boundaries.
- Verify: `make compile`; a `*_test.sfn` regression (below) that sets a tiny
  `SAILFIN_MEM_LIMIT` and asserts the diagnostic + nonzero exit on macOS; and
  asserts `unlimited` produces no abort (sanitizer-leg safety).
- **Only if Step 1 + a CI run prove single-process emits still OOM** (spike says
  they won't): escalate to a C-helper allocator hook (Layer 2 option 1/2) under
  a separate issue, with the ASAN-interleave gate from
  `.claude/rules/compiler-safety.md`.

## 9. Test strategy

Mirror `mem_limit_selfcap_test.sfn` and the sanitizer-skip discipline. All
`*_test.sfn`, no bash e2e (`.claude/rules/no-bash-e2e.md`).

- **Fan-out formula (unit, pure):** a `compiler/tests/unit/` test that exercises
  the RAM-clamp arithmetic. Since `_cr_resolve_jobs` shells out, the testable
  surface is the pure formula helper — **extract** `_cr_ram_budget_jobs(memsize:
  i64, nproc: int) -> int` as a pure fn and unit-test it directly: 7 GiB ⇒ 1,
  16 GiB ⇒ ≤3, 64 GiB ⇒ 8 (clamp), `SAILFIN_BUILD_JOBS` override bypasses it.
- **Darwin trace (e2e, `![io]`):** extend `mem_limit_selfcap_test.sfn`. Add a
  `_is_darwin()` peer to `_is_linux()` (`fs.exists("/System/Library/CoreServices")`).
  On Darwin, assert the `[mem-limit] darwin soft monitor armed` (Step 2) /
  enforcement trace appears under `SAILFIN_TRACE_MEM_LIMIT=1`; the existing
  Linux cases keep their `_is_linux()` skip. Each test skips (`assert true`) on
  the non-matching platform — same shape as today's `_is_linux()` guard.
- **Enforcement (e2e, `![io]`, Step 3):** spawn `sfn version` (or a tiny build)
  with a deliberately tiny `SAILFIN_MEM_LIMIT` and assert a nonzero exit + the
  `[mem-limit]` over-budget diagnostic on stdout/stderr (via `sfn/strings`
  `contains`, since `![io]` can't use `![pure]` matchers). A companion case with
  `SAILFIN_MEM_LIMIT=unlimited` asserts the run completes — the sanitizer-leg
  safety regression.
- **Sanitizer-leg safety:** if any test builds with `-fsanitize=address`, it
  must run with `SAILFIN_MEM_LIMIT=unlimited` and skip-not-fail on a non-ASAN
  startup abort, per `.claude/rules/compiler-safety.md` (the monitor must be a
  no-op under `unlimited`, so ASAN's 16 TB reservation is never tripped by our
  code).

## 10. Risks

- **Per-job reserve (3 GiB) wrong on the constrained runner.** Spike was on
  64 GiB; allocator behavior under real pressure may lower or raise peak RSS.
  Mitigate: the one CI confirmation run (§7); the constant is a single named
  value easy to tune; `SAFETY_FRACTION` gives headroom.
- **`floor(...) = 0` starving the build.** Formula uses `max(1, ...)` — a tiny
  runner still gets serial emit, never zero. Verified in §3.
- **Layer 2 checkpoint coverage gaps** (option 3): a pathological single
  allocation between checkpoints could still OOM. Accepted as a soft floor; the
  hard protection is Layer 1's serialization. Escalation path to a C allocator
  hook documented.
- **Windows cross-link regression** from new Darwin-only externs. Mitigate: put
  them in a separate module excluded from the bridge, pin with the existing peer
  test. Highest-blast-radius risk; isolated to Step 2 and gated by `make check`
  + the cross-windows test.
- **Local dev behavior change.** Layer 1 could reduce parallelism on small dev
  machines. Mitigate: `SAFETY_FRACTION=0.66` + 3 GiB reserve keeps a 16 GiB
  laptop at 3 jobs and a 64 GiB box at the existing 8; `SAILFIN_BUILD_JOBS`
  always overrides.

## 11. Verification commands

- Per step: `build/bin/sfn check <touched .sfn>` then `make compile`.
- Step 1 local sanity: confirm `_cr_resolve_jobs` still 8 on this box (a debug
  trace or the unit test on the extracted formula).
- Full gate before "shipped": `make check` (triple-pass self-host + suite),
  `sfn fmt --check` on every touched `.sfn`, cross-windows link test green.
- CI: a trial `int-e2e-caps` run with `SAILFIN_BUILD_JOBS` unset confirming the
  governor self-selects ≤2 and zero 137/134 exits; then remove the Step-0
  stopgap.

## 12. Future considerations (1.0)

- When the concurrency runtime lands, Layer 2 can move from checkpoint polling
  to a proper background watchdog thread — but the *fan-out governor stays* as
  the primary mechanism; structured concurrency does not give Darwin a hard
  memory cap.
- The build-performance plan (`docs/proposals/0006-build-architecture.md`, <5 min target) wants
  *more* parallelism; the RAM-aware governor is the safety valve that lets the
  parallel emit path raise its clamp on big hosts without endangering small
  ones — they are complementary, not opposed.
- A future per-host `per_job_reserve` calibration (measure the actual heaviest
  module's peak once at first build, cache it) would make the formula
  self-tuning; out of scope for the CI unblock.
