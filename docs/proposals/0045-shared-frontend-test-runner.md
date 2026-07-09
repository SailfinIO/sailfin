---
sfep: 0045
title: Shared-frontend test runner — parent compiles, children only execute
status: Accepted
type: tooling
created: 2026-07-08
updated: 2026-07-08
author: "agent:compiler-architect; human review"
tracking: "#2010, #1997"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0045 — Shared-frontend test runner: parent compiles, children only execute

## 1. Summary

`sfn test <dir>` forks one `sfn test <file>` child per test file, and every
child re-does the full compiler frontend+lowering pipeline — capsule resolution
(~32 s) and import-context lowering (~9 s after #2016; was ~25 s) — from
scratch, work that is **identical across every child of one invocation**. On a
heavy-closure test that is ~41 s of duplicated per-child labor against 0.5 s of
actual test execution. This SFEP makes the **parent** run the frontend
(resolve + typecheck + emit + lower + link) **once per resolver group** in its
own already-warm in-process state — the exact shape the single-process serial
path already uses today (`test.sfn:1017-1420`) — and demotes children to
`exec(test_binary)` under a timeout. Fault isolation (a crashing/hanging test
must not take down the runner) and per-child scratch isolation are preserved
because *execution* stays in a subprocess; only *frontend recomputation* is
eliminated. This is the resolver-sharing work SFEP-0044 §3-C explicitly deferred
(issue #1997) and the structural fix for #2010 sub-item (b). Target: heavy child
≈ light child (marginal ~1.5–2.5 s per file, per the Phase 0 probe math), macOS
unit shards ~15–22 min (post-#2016) → ~8–10 min, full local suite within a few ×
of the ~90 s compiler self-build.

## 2. Motivation

### The measured problem (#2010; corrected by instrumented probe, 2026-07-08)

Per-child anatomy for a heavy-closure test
(`compiler/tests/unit/routine_nursery_test.sfn`, ~130 compiler-module deps),
**all caches warm**. The original #2010 anatomy attributed ~25.6 s to
"typechecking against 130 interfaces"; phase timers (instrumented
`main.sfn:482` + `lowering_core.sfn`) showed that attribution was wrong —
**typecheck proper is ~1 ms**; the cost was LLVM lowering's per-compile
re-parsing of the imported `.sfn-asm` texts. Corrected, post-#2016 anatomy:

| Phase | Cost | Constant across children of one invocation? |
|---|---|---|
| resolver pass (`prepare_project_capsules_for_test`, `capsule_resolver.sfn:3476`) | **31.9 s** | Yes — same project/workspace roots, same dep closure |
| parse test src + typecheck + effect/ownership + emit `.sfn-asm` | **~110 ms** | Genuinely per-file, already cheap |
| LLVM lowering (`gather_imported_module_symbols` + mangle re-scan over the 130 imported texts) | **~9 s** (was 25.3 s; #2016 / PR #2018 collapsed 5 parses per text to 1; ~4 s of the residue is `collect_available_import_module_names` re-scanning the same texts) | Yes — pure function of the group's `native_texts` + manifests, byte-identical across every file in the group |
| clang link | ~1 s (was 8.3 s; #2013 dep `.ll`→`.o` cache, PR #2014) | — |
| test execution | **0.5 s** | No — this is the only genuinely per-file work |

So ~41 s of every heavy child (resolver ~32 s + lowering ~9 s) is work re-done
from scratch, byte-for-byte identical across children in the same resolver
group. Light tests pay ~4.5 s total. CI macOS unit shards sat at **24–32 min**
pre-#2016 (~15–22 min after) and are the PR-CI critical path; nightly
`make check`'s cold seedcheck suite pays the same tail.

### Why the duplication exists at all

The multi-file runner (issue #848, `test.sfn:583`) forks a `sfn test <file>`
subprocess per file for three reasons, all real:

1. **Fault isolation** — a test that `assert false`s calls `abort()` and brings
   its whole process down; a hanging test must be killable by a per-child
   `timeout`. One crashing test must not abort the runner or its siblings.
2. **Per-child scratch isolation** — each child gets its own
   `SAILFIN_TEST_SCRATCH` (#1333) so parallel compiles don't collide on the fixed
   `build/sailfin/program.ll`.
3. **Resolver-union conflict avoidance** — the *original* single-process path
   (pre-#848) grouped every test under one resolver pass whose `native_texts` was
   the **union** of every test's imports, and tests with conflicting descriptors
   for the same symbol (the `number_to_string` `![pure]`-int vs. `double`-runtime
   case, `test.sfn:562-576`) cannot coexist. It also OOM'd/segfaulted on the real
   suite because the whole ~120-module closure accumulated in one never-freed
   bump arena (`test.sfn:1019-1025`).

**The key observation this SFEP rests on:** the single-process serial path that
*still exists today* (`test.sfn:1017-1420`, taken when `test_files.length <= 1`
or in the per-child leaf) already solved (3): it partitions tests into **resolver
groups** by `(discover_project_root, discover_workspace_root)` + consumer, runs
`prepare_project_capsules_for_test` **once per group**, and reuses
`interfaces` / `native_texts` / `dep_ll_paths` / `function_effects` /
`capabilities_required` across every test in the group, rewinding the arena
(`sailfin_intrinsic_runtime_arena_mark`/`_rewind`) between files so the closure
does **not** accumulate. The union conflict is avoided by *grouping*, not by
*forking*. The OOM is avoided by *arena rewind*, not by *forking*. The only thing
the fork still buys that grouping+rewind does not is **fault isolation of
execution** (reason 1) and **per-child scratch** (reason 2) — and both of those
apply to *running the binary*, not to *compiling it*.

Today the multi-file path throws away the parent's warm resolver state and makes
each child rebuild it. This SFEP keeps the warm frontend in the parent and forks
only for the 0.5 s exec.

## 3. Design

### 3.1 Recommended approach: **parent compiles, child only executes** (Alternative 2)

The parent process, which already partitions tests into resolver groups and warms
runtime objects into `sub_root`, additionally **compiles and links every test
binary in-process**, reusing its resident resolver/typecheck state across the
group exactly as the serial path does today. Each test's linked binary is written
into the shared objdir. Children are reduced to a thin
`timeout <secs> <test_binary>` exec with per-child scratch — no compiler,
no resolver, no typecheck. The bounded worker pool (`--jobs N`) moves from
"compile+run per child" to "**parent compiles** (serially, arena-rewound), **pool
runs** the resulting binaries".

This is chosen over the serialized-snapshot (Alt 1) and daemon/IPC (Alt 3)
approaches in §6. The decisive facts making it low-risk:

**Core compiler passes hold zero cross-compilation mutable state.** Grepping every
`compiler/src/**.sfn` for module-level `let mut`:

- `typecheck.sfn`, `typecheck_types.sfn`, `emit_native.sfn`,
  `effect_checker.sfn`, `ast.sfn`: **0** module-level `let mut`. No global type
  interner, no monomorphization cache, no symbol table accumulator that would
  corrupt across files.
- `backend.sfn`: `_macos_sdk_probe_done` / `_macos_sdk_root` — an idempotent
  memoized SDK probe, **invocation-constant**, correct to reuse.
- `llvm/lowering_debug_state.sfn`: errno/clock/nprocessors/stat-offset locators —
  all idempotent memoized host probes, invocation-constant.
- `ice.sfn`: `_ice_stage`/`_ice_source`/`_ice_binary_dir` — set-per-compile ICE
  context, overwritten each file, never read across files.
- `test_runner_state.sfn`: `_active`/`_trace`/`_filter_name`/`_filter_tag` — set
  once at runner entry, identical for every file in the invocation.

There is **no per-compilation mutable accumulator** that makes in-process reuse
across files unsound. The serial path already proves this daily: it compiles
~75 self-host-suite tests back-to-back in one process. This SFEP extends that
proven path to the multi-file case rather than inventing new machinery.

### 3.2 Mechanism

**Phase 0 — marginal-compile probe (RUN 2026-07-08; gate results recorded).**
An env-gated fork bypass forced the serial group loop for two heavy same-group
files in one process. Result: 1 file = 64.9 s; 2 files = 95.3 s — **marginal
cost of the second file ≈ 30 s**, falsifying the original "seconds once
interfaces are resident" assumption. Phase-timer attribution of the marginal
30 s: typecheck ~1 ms; the cost was `gather_imported_module_symbols`
re-parsing each of the 130 imported `.sfn-asm` texts five times (~21 s) plus
the `collect_available_import_module_names` mangle re-scan (~4 s) — per-file
recomputation of a value that is a pure function of the group's
`native_texts`. Two consequences, both already acted on:

1. The 21 s share was an algorithmic defect fixed independently of this SFEP
   (#2016 / PR #2018, 5 parses → 1), cutting the marginal in-process compile
   to ~9–10 s and every fork-path child by the same amount.
2. The residual ~9–10 s marginal (lowering's remaining single parse + the
   ~4 s mangle re-scan + ~1 s link) still exceeds the target, so **Phase A
   explicitly includes group-scoped memoization**: compute
   `ImportedModuleSymbols` (and the mangle pass's available-module-names
   list) **once per resolver group** and reuse it for every file in the
   group — both are pure functions of the group's `native_texts` +
   manifests, so this is a cache of an invocation-constant value, not new
   semantics. Projected marginal per-file cost after Phase A:
   **~1.5–2.5 s** (one cheap per-file lowering pass + clang link + exec).

With the corrected numbers, serial parent-compile at ~2 s/file beats the fork
path (~43 s/child post-#2016 ÷ jobs) for any realistic `--jobs`, so the
serial-parent design holds without Phase C.

**Phase A — hoist the compile loop into the multi-file parent.** Today the
multi-file branch (`test.sfn:583`) forks children; the serial compile+link loop
lives below it (`test.sfn:1017-1420`) and is only reached when `test_files.length
<= 1`. Refactor so the multi-file parent:

1. Runs the existing resolver-group partition + per-group
   `prepare_project_capsules_for_test` + `load_imported_interfaces_from_paths`
   (already present at `test.sfn:1017-1067`).
2. Warms runtime objects into `sub_root` once (already present, `test.sfn:657`)
   and writes the SFEP-0044 stamp (already present, `test.sfn:666`).
3. **Computes the group's lowering import context once** (Phase 0 finding):
   `gather_imported_module_symbols` over the group's `native_texts` +
   manifests, and the mangle pass's `collect_available_import_module_names`
   list, are pure functions of group-constant inputs — memoize both per
   resolver group and thread the memo into the per-file lowering call
   instead of recomputing per file (~9–10 s → amortized once per group).
   The memo must be keyed per group so it never leaks across the #848
   union-conflict groups.
4. **Compiles + links each test binary in-process**, reusing the group's warm
   interfaces/native_texts/dep_ll_paths, with `arena_mark`/`arena_rewind` around
   each file (the existing per-test rewind, `test.sfn:1419`). The linked binary
   is written to a stable per-file path in `sub_root` (e.g.
   `sub_root/bin/<sanitized_test_path>`), and the test-bin content cache
   (`test_bin_cache_key`) is consulted/populated exactly as the serial path does
   now (`test.sfn:1194-1222`) — a cache hit skips lower+link entirely.
5. Records, per file, the binary path and the pre-parsed `TestEntry[]` (for
   `--json` attribution and the aggregate `start` total, already computed at
   `test.sfn:679-694`).

**Phase B — the exec-only child.** Introduce a new internal dispatch the parent
invokes per file: `sfn __run-test-bin <binary_path>` (a hidden subcommand, not in
`command_def()`'s help surface), which is a bare
`exec`-with-`argv`+`timeout`+scratch wrapper carrying **no compiler code path**.
Its entire job: set up per-child scratch, `exec` the prebuilt binary, forward its
stdout/stderr and per-test JSON sub-frame events, and exit with the binary's code.
The bounded pool loop (`test.sfn:705-856`) is retargeted to spawn *these*
exec-only children instead of full `sfn test <file>` children. Fault isolation is
identical to today — a crashing test still dies in its own subprocess, still
retried on 137/139 via the existing gate, still killed by `timeout` on hang — but
the child no longer runs a compiler.

The exec-only child does **not** need `SAILFIN_TEST_RUNTIME_OBJDIR`,
`SAILFIN_TEST_RUNTIME_STAMP`, the resolver, or the interface loader, because the
binary is already linked. It needs only `PATH`/`HOME`/`TMPDIR` (for any `![io]`
test that itself spawns), its own scratch, and the JSON sub-frame flag. This
*shrinks* the per-child env surface (`_pool_child_env`).

**Phase C — parallel compile (optional, gated, deferred).** Phase A compiles
serially in the parent. If serial parent-compile becomes the new bottleneck once
the ~41 s tax is gone (it will not for macOS's 3-vCPU runners, but may for large
many-core CI hosts), a follow-up can fan the *compile* step across a bounded
thread pool. This is explicitly **out of scope for the shipping phases** — it
depends on the structured-concurrency runtime maturing and on the compiler being
proven thread-safe across concurrent in-process compiles (the zero-mutable-state
finding above is necessary but the arena is a shared bump allocator, so
concurrent compiles would need per-thread arenas first). Serial parent-compile
already hits the target.

### 3.3 Interplay with existing caches (must keep working)

- **Test-bin content cache (`test_bin_cache_key`, `build_cache.sfn:1281`).**
  Unchanged and *more* effective: the parent now populates and reads it
  in-process, so a warm cache means the parent skips lower+link and just writes
  the binary path for the exec-only child. Its key still folds test source +
  dep closure + compiler identity + runtime identity — none of which this SFEP
  alters.
- **#2013 dep `.ll`→`.o` cache (PR #2014).** Unchanged — it accelerates the link
  the parent now performs, which is exactly where its ~7 s→~1 s win lands. The
  parent linking many binaries against the same warm dep `.o` set is the ideal
  consumer of this cache.
- **SFEP-0044 runtime-identity stamp (#1996).** Still written by the parent warm;
  now *consumed by the parent's own compile loop* (which computes
  `_test_bin_runtime_identity` once, `test.sfn:1149`) rather than by children.
  The stamp's per-child value evaporates — but the parent path was always its
  cheaper consumer. The stamp file remains for the single-file leaf path and for
  seedcheck's pinned-objdir runs.

### 3.4 Worked shape

```
parent (one `sfn test <dir>` process):
  partition test_files into resolver groups          [existing, test.sfn:970]
  for each group:
    prepare_project_capsules_for_test(group)          [existing, ~32s ONCE/group]
    load_imported_interfaces_from_paths(group)        [existing]
  warm runtime objects -> sub_root; write stamp       [existing, test.sfn:657]
  arena_mark()
  for each test_file:                                 [MOVED UP from leaf path]
    if test_bin_cache hit -> restore binary
    else compile_tests_to_llvm_file_with_module_imports(...)  [~cheap, interfaces resident]
         llvm_assemble + clang link -> sub_root/bin/<file>
         store test-bin cache
    record (binary_path, entries)
    arena_rewind()
  pool (--jobs N) over recorded binaries:
    spawn `sfn __run-test-bin <binary_path>` with per-child scratch + timeout
    reap in order; retry 137/139; aggregate JSON sub-frames   [existing pool logic]
```

The pool loop, reaping, retry gate, JSON aggregation, and suite-banner
attribution (`test.sfn:705-960`) are **reused verbatim** — only the spawned argv
(`_pool_child_argv`) and env (`_pool_child_env`) change, and the thing being
spawned is a linked binary rather than a compiler.

## 4. Effect & capability impact

None. All changes are within `![io]` build/test-driver code
(`compiler/src/cli/commands/test.sfn`, plus a hidden `__run-test-bin` dispatch).
The new exec-only child carries a *smaller* effect surface than today's child
(no resolver/frontend), and the parent's in-process compile uses the same
`![io]` entrypoints (`compile_tests_to_llvm_file_with_module_imports`,
`assemble_runtime_capsule_link_inputs`, `llvm_assemble`) already invoked on the
serial path. No user-facing effect surface changes; no capsule-manifest surface
changes.

## 5. Self-hosting impact

No compiler *pass* changes — lexer → parser → AST → typecheck → effects →
emitter → LLVM lowering are all untouched. The change is entirely in the
test-runner orchestration:

- `compiler/src/cli/commands/test.sfn` — hoist the compile loop into the
  multi-file parent; add the exec-only child dispatch; retarget the pool.

The self-hosting invariant is preserved because (a) the *serial single-file*
compile path is unchanged and already self-hosts, and (b) `make check`'s
seedcheck suite runs through this exact runner — if the parent-compile path
produced a different binary than the per-child path, the suite would fail. Each
phase self-hosts independently:

- **Phase A** hoists an *existing, proven* loop up one level and gates the fork
  behind it. Intermediate state: parent compiles in-process **and** still forks
  full children (belt-and-suspenders) → correct, just not yet faster; then flip
  children to exec-only. In practice A+B land together (see bundling below).
- **Phase B** is the exec-only child; it self-hosts because the binary it execs
  is produced by the same compile path the serial leaf uses.

**Seed dependency: NONE.** This is pure driver orchestration in
`compiler/src/*.sfn` using capabilities the seed already has
(`process.spawn_with_env`, `process.handle_wait`, arena intrinsics, the existing
compile entrypoints). Per `.claude/rules/seed-dependency.md`, no language/runtime
capability absent from the pinned seed is introduced. `make compile` builds the
new runner from the old seed in one pass; no seed cut, no `/pin-seed`.

**Bundling (per `.claude/rules/seed-dependency.md`).** Phases A and B are a single
cohesive capability (parent-compiles) plus its single consumer (exec-only child);
they should land **in one PR** — the exec-only child is useless without the
parent producing binaries, and the parent producing binaries with no exec-only
consumer is dead code. Splitting them manufactures an intermediate PR with no
shippable value (and no seed-cut gate either way, since there is no seed
dependency). Phase C is genuinely independent (parallel compile) and defers.

## 6. Alternatives considered

**Alternative 1 — serialized frontend snapshot.** Parent runs the resolver +
interface load once, serializes the resolved interfaces / module graph /
effect tables to a versioned snapshot file in the shared objdir; children
deserialize instead of recomputing, then compile the test source themselves.
*Assessment:* the state to serialize is `Statement[]` interface ASTs +
`LayoutManifest[]` + `native_texts: string[]` + `ImportSymbolTable` (function
name → `effects: string[]`) + `capabilities_required: string[]`. The
`native_texts` and interface `.sfn-asm` are **already on disk** as staged
artifacts (`resolution.asm_paths`), so a "snapshot" is largely re-reading files
the resolver already wrote — which is exactly the per-child cost the Phase 0
probe attributed (the child re-parses the 130 `.sfn-asm` texts in lowering,
~9 s post-#2016, plus the ~32 s resolver staging walk). A stable binary serialization of the parsed/typechecked interface state
does not exist today and would require freezing an on-disk format for AST +
`ImportSymbolTable` (interface-serialization *drift* risk: any AST/effect-table
field change silently invalidates or misreads snapshots — a whole new versioning
surface). And this still leaves the child running typecheck + emit + lower +
link, so it only removes the resolver's *staging* cost, not the interface-load or
compile cost. **Rejected:** more machinery, new format-drift risk, and it does
not eliminate the dominant per-child work (the child still compiles). This is the
shape 0006 flags as filesystem-IPC-bound — the very bottleneck we are trying to
escape.

**Alternative 3 — resolver daemon / IPC (the 0006 shape).** A long-lived frontend
server holds resolved interfaces resident; children query it over IPC per
compile. *Assessment:* the most general and the most machinery — needs a wire
protocol, a server lifecycle, crash/restart handling, and a client in every
child. It also re-introduces per-query IPC round-trips (0006's primary
bottleneck) unless the payload is kept tiny, and the payload here (interface
ASTs) is not tiny. It solves a problem we do not have: we do not need *many
independent clients* querying a shared frontend; we need *one* process that
already holds the frontend to also do the compiles. **Rejected as premature** —
Alternative 2 achieves the target with no new protocol by observing that the
parent *is* the natural frontend server and the compile *is* the query. A daemon
is the right shape only if/when `sfn check` / `sfn build` (not just `sfn test`)
need cross-invocation frontend sharing; that is the 0006 redesign, out of scope
here.

**Why Alternative 2 wins:** it reuses the *already-proven* in-process serial
compile path (zero new correctness surface — the serial path self-hosts today),
introduces no serialization format and no IPC protocol, keeps every existing
cache working, and preserves execution fault-isolation exactly. It moves one loop
up one scope and shrinks the child, rather than building new infrastructure.

**Sub-decision — keep forking for execution vs. run in-process.** Could the
parent also *run* the tests in-process (no children at all)? **Rejected:** an
`assert false` calls `abort()`, taking the whole runner down; a hanging test is
unkillable without a subprocess `timeout`; and per-test process teardown is the
only reliable way to reclaim a test that leaks fds/threads. Execution isolation
is load-bearing and stays in children. This is precisely why the split is
"parent compiles, child executes" and not "parent does everything."

## 7. Stage1 readiness mapping

Tooling change; no language surface.

- [ ] Parses — N/A (no new syntax; `__run-test-bin` is a dispatch string)
- [ ] Type-checks / effect-checks — `test.sfn` passes `sfn check`
- [ ] Emits valid `.sfn-asm` — exercised by `make compile`
- [ ] Lowers to LLVM IR — exercised by `make compile`
- [ ] Regression coverage — see §8
- [ ] Self-hosts — `make compile` then `make check` (the suite runs through this
      runner; a divergence between parent-compile and per-child-compile binaries
      fails the suite by construction)
- [ ] `sfn fmt --check` clean — on `test.sfn`
- [ ] Documented in `docs/status.md` — note the test-runner architecture change;
      this SFEP is the design record

## 8. Test plan

The load-bearing property is: **parent-compiled binaries are byte-equivalent in
behavior to per-child-compiled binaries, and execution fault-isolation is
preserved.** `make check` already exercises the whole suite through the runner,
so the strongest regression is that `make check` stays green. Targeted additions:

- `compiler/tests/e2e/parent_compile_multifile_test.sfn` — `![io]`: run a small
  multi-file suite (2–3 fixtures with distinct imports so they exercise the
  per-group resolver reuse) via a spawned `sfn test <dir>`; assert all pass and
  the aggregate counts match a per-file `sfn test <file>` baseline. Proves the
  parent-compile path produces working binaries.
- `compiler/tests/e2e/test_runner_crash_isolation_test.sfn` — `![io]`: a suite
  containing one fixture that `assert false`s (aborts) and one that passes;
  assert the passing one still runs and is reported passed, the aborting one is
  reported failed, and the runner exits nonzero — i.e. the abort did not take
  down the runner or the sibling. Proves execution isolation survived the
  refactor. (This is the regression that would catch an accidental "parent runs
  in-process" mistake.)
- `compiler/tests/e2e/test_runner_timeout_isolation_test.sfn` — `![io]`: a
  fixture with an infinite loop; assert it is killed by the per-child `timeout`
  (exit 124) and siblings complete. Proves hang-killing survived.
- `compiler/tests/e2e/test_bin_cache_parent_hit_test.sfn` — `![io]`: run a suite
  twice; assert the second run reports a high `cache.test_bin_hit_rate` (the
  parent now populates/reads the test-bin cache in-process). Proves the #2013 /
  `test_bin_cache_key` interplay.
- Existing `check_build_agree_module_global_test.sfn` and the JSON sub-frame
  aggregation tests continue to gate output correctness.

**Perf gate (informational, not CI-blocking):** `make bench`-style timing of a
heavy-closure suite before/after, asserting the per-file cost drops from ~43 s
(fork path, post-#2016) to the ~1.5–2.5 s marginal the Phase 0 math projects.
Recorded in the PR, not a test assertion (timing is host-dependent).

**Memory (Darwin, SFEP-0022).** The parent now holds full frontend state
(resolved interfaces + dep `.ll` closure for the largest resolver group) while
children run. macOS runners are 3-vCPU/7 GiB with no `RLIMIT_AS`. Mitigation: the
parent already holds this state on the serial path today without OOM (arena
rewind between files keeps per-file allocations bounded; the resident set is one
group's interface closure, not the union of all groups — groups are processed and
their transient staging freed sequentially). The exec-only children are now
*tiny* (a linked binary + a `timeout` wrapper) versus today's full-compiler
children, so total concurrent RSS **drops**: N heavy compilers → 1 parent
compiler + N thin execs. Verify with `make check` on a macOS runner and a
`--jobs` sweep; the peak-RSS regression guard is that seedcheck (which pins
scratch and runs the full suite) stays under budget.

## 9. References

- **#2010** — the epic; this is the structural fix for sub-item (b). Comment
  4918225130 carries the measured per-child breakdown quoted in §2.
- **#1997** — the resolver-sharing follow-up SFEP-0044 §3-C deferred; this SFEP
  is that work. Fold #1997's scope in.
- **SFEP-0044** (`docs/proposals/0044-test-runner-invocation-cache.md`) — the
  parent-warms-once / children-consume pattern (#940 runtime objdir, #1996
  invocation stamp) this SFEP extends from backend artifacts to the frontend;
  §3-C is the explicit deferral of resolver sharing gated on 0006.
- **#2013 / PR #2014** — dep `.ll`→`.o` cache that cut the link from 8.3 s to
  ~1 s; the parent's link consumes it (§3.3).
- **#2016 / PR #2018** — single-parse import gather, the algorithmic fix the
  Phase 0 probe surfaced (5 parses per imported text → 1; lowering 25.3 s →
  ~9 s; unit tier −30.5% wall). Phase A's group-scoped memo extends the same
  observation (`ImportedModuleSymbols` is group-constant) from "parse once
  per compile" to "compute once per group."
- **SFEP-0006** (`docs/proposals/0006-build-architecture.md`) — build/IPC
  bottleneck root cause; §6 explains why Alt 1 (snapshot, filesystem-IPC-bound)
  and Alt 3 (daemon/IPC) are the shapes to avoid here.
- **SFEP-0022** (`docs/proposals/0022-darwin-memory-governor.md`) — Darwin memory
  budget the parent-holds-state design must fit (§8).
- **#848** — the multi-file per-child isolation this SFEP restructures;
  `test.sfn:557-576` documents why forking exists.
- **#940** — the shared-objdir runtime warm; **#1333** — per-child scratch
  isolation; **#1236 / #1303** — the bounded worker pool + signal-kill retry gate
  reused verbatim.
- Key code paths: `compiler/src/cli/commands/test.sfn:583` (multi-file fork
  branch), `:657` (parent runtime warm), `:1017-1067` (per-group resolver +
  interface load), `:1156-1420` (the serial compile+link+run loop this SFEP
  hoists into the parent), `:705-960` (bounded pool + reap + retry + JSON
  aggregation reused for exec-only children); `compiler/src/main.sfn:482`
  (`compile_tests_to_llvm_file_with_module_imports`);
  `compiler/src/capsule_resolver.sfn:3476`
  (`prepare_project_capsules_for_test`); `compiler/src/build_cache.sfn:1281`
  (`test_bin_cache_key`).
