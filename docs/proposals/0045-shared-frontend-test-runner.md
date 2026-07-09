---
sfep: 0045
title: Shared-frontend test runner — parent compiles, children only execute
status: Draft
type: tooling
created: 2026-07-08
updated: 2026-07-09
author: "agent:compiler-architect; human review"
tracking: "SFN-152, #2010, #1997"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0045 — Shared-frontend test runner: parent compiles, children only execute

## 1. Summary

`sfn test <dir>` forks one `sfn test <file>` child per test file, and every
child re-does the full compiler frontend+lowering pipeline — capsule resolution
(~32 s) and import-context lowering (~9 s after #2016) — from scratch, work that
is **identical across every child of one invocation**. This SFEP set out to make
the **parent** run the frontend (resolve + typecheck + emit + lower + link)
**once per resolver group** in its own already-warm in-process state, and demote
children to `exec(test_binary)` under a timeout, preserving execution fault
isolation while eliminating frontend recomputation.

The originally-Accepted design (now the rejected alternative in §6) rested on a premise that a
real implementation **falsified**: it assumed grouping tests by
`(project_root, workspace_root)` avoids the resolver-union descriptor conflict
that per-file forking was built to sidestep. It does not — for the compiler's
own suite, which is the primary consumer (every `make check` / seedcheck run goes
through this runner), *all* of `compiler/tests/{unit,integration,e2e}` share one
project root and therefore collapse into a single ~400-file resolver group whose
unioned import descriptors conflict pervasively. The full parent-compiles
orchestration was built, self-hosts, and passes on small/medium suites, but
**fails `make test`** (0 passed, 435 `compile failed`, ~2 h runaway). This
revision demotes the SFEP to `Draft`, records the post-mortem honestly, retracts
the false claim in the motivation and design, and reframes §3 as a set of
candidate directions with an explicit prerequisite (fixing the within-project
descriptor conflict) plus a decomposition into groomable issues. The one
salvageable, independently-landable piece — the exec-only child — is called out
as such.

## 1a. Post-mortem — why the Accepted design failed

The Accepted design was implemented end-to-end (parent compiles per resolver
group, children only execute), self-hosts via `make compile`, and **passes** on
standalone multi-file dirs, single-capsule dirs, and `sailfin test capsules`
(38/38). It **fails the real gate** — `make test`, i.e.
`sailfin test compiler/tests/unit compiler/tests/integration compiler/tests/e2e
capsules --jobs N` — with **0 passed, 435 `compile failed`, and a ~2-hour
runaway**. Four findings, in priority order, and all treated here as ground
truth from that run:

### Finding 1 — the central claim is false: grouping does NOT avoid the resolver-union conflict

§2 of the Accepted text asserted "the union conflict is avoided by *grouping*,
not by *forking*," citing the single-process serial path
(`test.sfn:1017-1420`) as having "already solved it." That serial group-union
machinery was **dead code**: the #848 multi-file fork branch (`test.sfn:583`,
`if test_files.length > 1`) returns before the serial path is ever reached, so
the group loop had **never** run with more than one file per group. The premise
was therefore never validated by any real multi-file run.

When the fork bypass is removed and the serial group loop is actually
activated on the compiler suite:

- All of `compiler/tests/{unit,integration,e2e}` share project root
  `compiler/`, so they land in **one resolver group of ~400 files**.
- `prepare_project_capsules_for_test(group.entry_paths, …)`
  (`capsule_resolver.sfn:3476`) **unions** the import descriptors of all ~400
  entry paths and picks **one descriptor per symbol**. Files that expected a
  different descriptor for the same symbol lose.

Grouping only separates *different* project roots. The conflicting files live
under the *same* root, so grouping is structurally incapable of helping — this
is exactly the conflict #848's per-file forking was built to avoid
(`test.sfn:557-576`). The conflicts are **pervasive, not a handful**:

- `number_to_string`: the `![pure]` int-signature import (#633) vs. the
  `double` runtime helper. Union picks one; victims fail with
  `llvm lowering [fatal]: ABI primitive mismatch: callee expects i64 (int) but
  caller produced double` and/or `undefined reference to number_to_string`.
- `runtime_object_cache_key` / `runtime_object_cache_key_with_identity`:
  `llvm lowering [fatal]: cannot resolve return type … callee signature is not
  known to the compiler`.

Because the compiler's own suite is the *primary* consumer of this runner
(`make check` and seedcheck both run through it), a design that mishandles this
suite is a design that does not ship.

### Finding 2 — a reactive per-file resolver fallback does not rescue it

The tried mitigation: compile each file against the shared per-group context
(fast path); on compile/link failure, re-resolve *that one file alone*
(`prepare_project_capsules_for_test([file], …)`) and retry in-process. It
failed on both axes:

- **Correctness** — the solo re-resolve re-stages into the already-populated
  group staging dir and yields an *incomplete* context, so the retry still
  fails with `callee signature not known`.
- **Cost** — each solo re-resolve is a full ~32 s whole-compiler resolution.
  With hundreds of conflict victims (a *large fraction* of files use a
  conflicting symbol), that is the ~2-hour runaway. A fallback that fires on a
  large fraction of the suite is not a fallback; it is the common case, and it
  does not scale by construction.

### Finding 3 — in-process serial compile is slow and has an unaddressed memory hazard

- **Slow.** A single heavy compiler-unit file (imports the ~130-module
  compiler) took **~12 s** to lower in-process (measured `phase=functions
  ms=8121`, `phase=finalize ms=12595`) with **no group memo landed**. ×~400
  files serially ≈ 40 min of compiles alone — the opposite of the perf goal.
  The Accepted §3.2 ~1.5–2.5 s/file projection assumed a group-scoped
  `ImportedModuleSymbols` memo that was never implemented.
- **Memory hazard.** `SAILFIN_USE_ARENA` is **off by default**
  (`test.sfn:1078-1079`: the per-file `arena_mark`/`arena_rewind` is "No-op
  when the arena is disabled"). So the Accepted §3.1/§3.2 memory reclamation is
  a **no-op under `make test`**. Compiling hundreds of heavy files in one
  never-rewound process revives the pre-#848 OOM/segfault that the fork model
  avoided via per-file process teardown (the OOM documented at the original
  `test.sfn:1019-1025`). The Accepted text treated arena-rewind as load-bearing
  without noting it is opt-in and unvalidated as a default.

### Finding 4 — what is sound and salvageable

- The **exec-only child** (Accepted Phase B): a hidden `__run-test-bin`
  dispatch where the parent compiles+links the binary and the child just execs
  it under `timeout` with per-child scratch. This works, preserves fault
  isolation, and is independent of the broken resolver-sharing half.
- **Parent-compile for conflict-free groups.** Where a group has no descriptor
  conflict (standalone multi-file dirs, single-capsule dirs, `capsules`), the
  parent-compiles path is correct and passes today.

The broken half is Phase A's "one shared resolve per project/workspace group"
applied to a group whose descriptors conflict.

### Incidental note (not part of this design)

The implementation attempt surfaced a latent **giant-function codegen
miscompile**: a `bounds_check` abort in `cli/commands/test.sfn::run` that
shifted/vanished when a gated `print.err` was added and when the run phase was
extracted into a helper. It is layout-sensitive and worth a **separate compiler
issue**; it is orthogonal to the runner design and is not addressed here.

## 2. Motivation

### The measured problem (#2010; corrected by instrumented probe, 2026-07-08)

Per-child anatomy for a heavy-closure test
(`compiler/tests/unit/routine_nursery_test.sfn`, ~130 compiler-module deps),
**all caches warm**. Phase timers (instrumented `main.sfn:482` +
`lowering_core.sfn`) show **typecheck proper is ~1 ms**; the cost is LLVM
lowering's per-compile re-parsing of the imported `.sfn-asm` texts.

| Phase | Cost | Constant across children of one invocation? |
|---|---|---|
| resolver pass (`prepare_project_capsules_for_test`, `capsule_resolver.sfn:3476`) | **31.9 s** | Per *resolver group* — same project/workspace roots, same dep closure |
| parse test src + typecheck + effect/ownership + emit `.sfn-asm` | **~110 ms** | Genuinely per-file, already cheap |
| LLVM lowering (`gather_imported_module_symbols` + mangle re-scan over the 130 imported texts) | **~9 s** (post-#2016; ~4 s of the residue is `collect_available_import_module_names` re-scanning) | Per resolver group — pure function of the group's `native_texts` + manifests |
| clang link | ~1 s (post-#2013 dep `.ll`→`.o` cache) | — |
| test execution | **0.5 s** | No — the only genuinely per-file work |

So ~41 s of every heavy child (resolver ~32 s + lowering ~9 s) is re-done from
scratch. The duplication is real and worth eliminating — the question this SFEP
must now answer honestly is **how**, given that the naive "share one resolve
across the whole project group" collapses on the descriptor conflict.

### Why the duplication exists at all

The multi-file runner (#848, `test.sfn:583`) forks a `sfn test <file>`
subprocess per file for three reasons, all real:

1. **Fault isolation** — a test that `assert false`s calls `abort()`; a hanging
   test must be killable by a per-child `timeout`. One crashing test must not
   abort the runner or its siblings.
2. **Per-child scratch isolation** — each child gets its own
   `SAILFIN_TEST_SCRATCH` (#1333) so parallel compiles don't collide on the
   fixed `build/sailfin/program.ll`.
3. **Resolver-union conflict avoidance** — the single-process path unions every
   test's imports into one resolver pass; tests with conflicting descriptors for
   the same symbol (`number_to_string` `![pure]`-int vs. `double`-runtime,
   `test.sfn:562-576`) cannot coexist in that union, and the whole closure
   accumulating in one never-freed arena OOM'd/segfaulted on the real suite.

**Retraction of the Accepted premise.** The Accepted text claimed reason (3) was
"already solved" by the serial group path and that grouping avoids the union
conflict. **This is false** (Finding 1): the serial group path was dead code and
was never exercised with >1 file per group; grouping only separates *different*
project roots, while the conflicting files share one root. Reason (3) is a live,
pervasive obstacle for the compiler's own suite — the very suite `make
check`/seedcheck depend on — and any shared-resolve design must confront it
head-on rather than assume it away. Reasons (1) and (2) remain correct and apply
to *running* the binary, not to *compiling* it — which is why the exec-only
child (Finding 4) is salvageable regardless of how the compile side is resolved.

## 3. Design — candidate directions

The goal is unchanged: stop every child re-doing the ~41 s frontend. The
Accepted single approach ("parent compiles once per project/workspace group") is
**withdrawn** for the compiler suite because a project-root group's descriptors
conflict. Below are the candidate directions, evaluated honestly. None is
re-committed to as *the* answer; the intended shipping order is
prerequisite → exec-only child → one of the sharing strategies, and the
decomposition in §3.6 makes the dependency ordering explicit.

The load-bearing constraint on **every** direction: it must be validated on the
**combined** compiler suite (`unit`+`integration`+`e2e`+`capsules` in one
`make test`/`make check` invocation), because that is the invocation that
exposed the flaw. Passing on small dirs proves nothing.

### 3.1 Direction (i) — fix the underlying within-project descriptor conflict (prerequisite)

**Root cause.** A single project must not be able to resolve one symbol name
(`number_to_string`, `runtime_object_cache_key`, …) to two *incompatible ABIs*
depending on which entry file drives resolution. This is the #633-class
ambiguity: the `![pure]` int-signature import and the `double` runtime helper
are two different callees sharing a name, and the resolver's union picks one.

**Why this is the prerequisite, not just an option.** *Any* shared-resolve
approach — one group, sub-partitioned groups, or shared staged artifacts — is
only sound if a project cannot present two conflicting descriptors for the same
symbol in the first place. If the ambiguity is removed at the source (distinct
mangled names, or a single canonical descriptor the whole project agrees on),
then a project-root group's union has no conflict to lose, and the entire
Accepted approach becomes viable as originally imagined. If it is *not* removed,
every sharing strategy must carry conflict-detection machinery forever.

**Shape (to be designed in its own issue, likely its own SFEP or a #633
follow-up).** Options span: (a) make the two `number_to_string`-class callees
resolve to distinct mangled symbols so both can coexist in one link
(`number_to_string$int` vs. `number_to_string$double`); (b) canonicalize the
project to a single descriptor per symbol so the union is a no-op; (c) diagnose
the conflict at resolve time (`E0xxx`) instead of miscompiling. This direction
is **not** free — it touches the resolver and mangling — but it is the only one
that eliminates the class rather than routing around it, and it is a
**prerequisite** for shipping any parent-compile sharing on the compiler suite.

### 3.2 Direction (ii) — conflict-free sub-partitioning of a group

Rather than fix the conflict at the source, detect descriptor conflicts within a
project-root group and split it into the **minimal set of conflict-free
sub-groups**, running one shared resolve per sub-group. *Assessment:* this keeps
the sharing benefit for the (majority) conflict-free files while isolating the
conflicting ones. Costs, both real: (a) the resolver must expose per-file
descriptor sets so the partitioner can detect conflicts *before* resolving —
new resolver support, non-trivial; (b) the sub-group count is **pathological in
the worst case** — a symbol with two descriptors used by interleaved files can
force many small sub-groups, each paying a full ~32 s resolve, degenerating
toward the per-file cost this SFEP is trying to escape. Sub-partitioning is
therefore a *mitigation* that only pays off if conflicts are rare; on today's
suite they are pervasive (Finding 1), so this direction is weak **unless
paired with (i)** to shrink the conflict set first.

### 3.3 Direction (iii) — keep forking, share the resolver's staged artifacts

Keep per-file forked compilation (so each child's resolver sees only its own
imports — no union, no conflict, fault isolation intact for the compile too),
but eliminate the *recomputation* by sharing the resolver's already-staged
artifacts and a cached lowering import-context across children. This is closer
to SFEP-0044's parent-warms/children-consume shape, extended from backend
artifacts to the frontend:

- The parent stages the dependency `.sfn-asm`/`.ll` closure once (already true —
  `resolution.asm_paths` / `resolution.ll_paths` are on disk).
- Children skip **re-staging** and **re-parsing** by consuming a
  parent-produced, group-keyed cache of `ImportedModuleSymbols` (the pure
  function of `native_texts` + manifests that lowering recomputes today).
- Each child still runs *its own* resolve-scoped typecheck+emit+lower+link
  against *its own* import set, so there is **no union and no descriptor
  conflict**, and no in-process compile-all memory hazard (per-file teardown
  survives).

*Assessment:* this is the most conservative direction — it preserves every
correctness and isolation property of the current fork path and only removes the
duplicated *work*, not the process boundary. The open questions are whether the
shared import-context can be serialized/consumed cheaply (this is close to Alt 1
below and inherits some of its format-drift risk) and how much of the ~41 s it
actually removes (the resolver *staging* walk itself may resist sharing). It does
**not** require Direction (i) as a prerequisite, because it never unions
conflicting descriptors — making it the safest first sharing step if (i) proves
expensive.

### 3.4 Direction (iv) — make in-process compile-all safe before using it

If a future design does move compilation into one long-lived parent process
(the Accepted shape), it must **first** make per-file memory reclamation real,
because `SAILFIN_USE_ARENA` is off by default and the OOM is otherwise
guaranteed at ~400 heavy files (Finding 3). Concretely, one of:

- **Arena-as-default** — turn `SAILFIN_USE_ARENA` on by default *and validate
  it* (correctness + peak-RSS) across the full combined suite, so
  `arena_mark`/`arena_rewind` actually reclaims per-file allocations. This is a
  prerequisite the Accepted text silently assumed; it is its own validation
  effort (SFEP-0022 Darwin budget, seedcheck peak-RSS guard).
- **Bounded subprocess batching** — keep process teardown for memory hygiene but
  amortize the frontend across a *batch* of files per subprocess (e.g. N files
  per worker process, each worker sharing one warm resolve for its batch),
  bounding resident set to one batch while still cutting the per-file frontend
  tax by ~1/N. This is a middle path between "one process compiles everything"
  (OOM) and "one process per file" (full recompute).

Neither is free, and both must clear the combined-suite gate. Direction (iv) is
**not** independently shippable ahead of a decision on (i)/(ii)/(iii); it is the
memory-safety floor any in-process variant must stand on.

### 3.5 Salvage — the exec-only child (independently landable)

Independent of how the compile side is resolved, the exec-only child is sound
and shippable **now** against the *existing fork path*:

- Introduce a hidden internal dispatch `sfn __run-test-bin <binary_path>` (not
  in `command_def()`'s help surface) that carries **no compiler code path**: set
  up per-child scratch, `exec` the prebuilt binary under `timeout`, forward
  stdout/stderr and per-test JSON sub-frame events, exit with the binary's code.
- The parent compiles+links each test binary (via whatever compile strategy is
  in force — today, that is still per-file, so this can land *before* any
  resolver sharing) into a stable per-file path, then the bounded pool
  (`test.sfn:705-856`) spawns `__run-test-bin` children instead of full
  `sfn test <file>` children.

This preserves fault isolation exactly (a crashing test still dies in its own
subprocess, still retried on 137/139, still killed by `timeout` on hang) while
shrinking the per-child env surface (`_pool_child_env` no longer needs the
resolver/objdir/stamp env). It delivers value on its own — the pool no longer
re-links per child on a warm test-bin cache — and it is the natural *consumer*
for any later parent-compile sharing without itself depending on that sharing.
Per `.claude/rules/seed-dependency.md` there is **no seed dependency** (pure
`![io]` driver orchestration using capabilities the pinned seed already has), so
it bundles cleanly with whatever produces the binaries and needs no seed cut.

### 3.6 Decomposition into workable issues

Ordered, groomable SFN-issue candidates with one-line scope + dependencies.
Dependency ordering is explicit so `/groom` can turn this into Linear issues and
`blockedBy` relations directly.

1. **Compiler-issue: giant-function codegen miscompile in `test.sfn::run`.**
   Scope: root-cause and fix the layout-sensitive `bounds_check` abort that
   shifts/vanishes with a gated `print.err` / helper extraction (see the §1a
   incidental note). *Depends on:* nothing. *Independent* — a compiler bug, not
   part of the runner design, but it destabilizes any work in this file, so land
   it first.

2. **Land the exec-only child (`__run-test-bin`) against the existing fork
   path.** Scope: add the hidden dispatch; the parent compiles+links binaries
   per-file as it does today and the pool spawns exec-only children; shrink
   `_pool_child_env`. *No resolver sharing yet.* *Depends on:* (1) for a stable
   file to edit. *Independently shippable* (Finding 4 salvage; §3.5). One PR,
   no seed cut.

3. **Prerequisite: resolve the within-project descriptor ambiguity
   (#633-class).** Scope: ensure a single project cannot resolve one symbol name
   to two incompatible ABIs — `number_to_string` int-vs-`double`,
   `runtime_object_cache_key[_with_identity]` — via distinct mangling, a single
   canonical descriptor, or a resolve-time `E0xxx` diagnostic (§3.1). *Depends
   on:* nothing (but blocks 5/6). Likely warrants its own SFEP or a #633
   follow-up given resolver+mangling blast radius. *Validation:* the combined
   compiler suite resolves with no ABI-mismatch / unknown-signature fatals when
   its entry paths are unioned.

4. **Arena-as-default validation OR subprocess-batched compile.** Scope: either
   (a) enable `SAILFIN_USE_ARENA` by default and validate correctness + peak-RSS
   on the full combined suite (SFEP-0022 budget, seedcheck guard), or (b) design
   bounded subprocess batching so one warm resolve amortizes across N files per
   worker (§3.4). *Depends on:* nothing to start the design; its *outcome* gates
   any in-process compile-all. Choose (a) or (b) at groom time.

5. **Shared staged-artifact / import-context cache across forked children
   (Direction iii).** Scope: parent produces a group-keyed `ImportedModuleSymbols`
   cache; forked children consume it and skip re-parse/re-stage while still
   resolving their own import set (no union). *Depends on:* (2) for the
   exec-only consumer shape; does **not** require (3) (no union → no conflict).
   The safest first *sharing* step; measure how much of the ~41 s it removes
   before committing to (6).

6. **Parent-compiles-once per conflict-free (sub-)group (Direction i+ii+iv
   combined).** Scope: the original Accepted shape, but only after (3) removes
   the descriptor conflict and (4) makes reclamation real; optionally
   sub-partition (Direction ii) any residual conflicts. *Depends on:* (3) AND
   (4) AND (2). *Validation gate is the combined `make test`/`make check`
   suite*, not small dirs. This is the biggest, riskiest issue and must not be
   groomed as ready until its predecessors land.

Recommended shipping order: **1 → 2** (immediate value, no risk to the
sharing question) then **3 and 4 in parallel** (both are prerequisites and
independent of each other) then **5** (conservative sharing win) and only then
**6** if 5's measured win is insufficient.

## 4. Effect & capability impact

None. All changes remain within `![io]` build/test-driver code
(`compiler/src/cli/commands/test.sfn`, `compiler/src/capsule_resolver.sfn`, plus
a hidden `__run-test-bin` dispatch). The exec-only child carries a *smaller*
effect surface than today's child (no resolver/frontend). Direction (i)'s
resolver/mangling change is internal to the compiler and does not alter the
user-facing effect surface or capsule-manifest surface. No new capability is
introduced.

## 5. Self-hosting impact

The salvageable and prerequisite work spans more than pure orchestration now,
because Direction (i) touches the resolver and mangling:

- **Issue 2 (exec-only child)** and **issue 5 (shared import-context)** are
  test-runner orchestration in `test.sfn` — no compiler *pass* changes; they
  self-host because the binaries they exec/consume are produced by the same
  compile path the serial leaf uses.
- **Issue 3 (descriptor ambiguity)** changes name resolution / mangling in
  `capsule_resolver.sfn` (and possibly the lowering mangle pass). This *is* a
  compiler-pass change and must self-host under `make compile`, then be gated by
  `make check` (whose seedcheck suite runs through this very runner — a
  divergence between the two `number_to_string` callees would fail the suite by
  construction).
- **Issue 4 (arena / batching)** changes memory-management defaults or the
  subprocess topology; self-hosting is preserved because the single-file compile
  path is unchanged and the combined suite is the gate.

**Seed dependency.** Issues 2, 4, and 5 are pure driver/runtime orchestration
using capabilities the pinned seed already has → no seed cut. Issue 3 changes
compiler-emitted symbol names; if any *other* compiler-source change depends on
the new mangling being in the pinned seed, apply `.claude/rules/seed-dependency.md`
(bundle with its single consumer by default). Within this SFEP, issue 3 has no
single downstream consumer that must self-host against it before it is in-seed —
its consumers (issues 5/6) build the new compiler from the old seed in the same
`make compile` pass — so **no seed cut is forced** by the ordering here. Call
out any cross-SFEP consumer at groom time.

## 6. Alternatives considered

The Accepted design ("parent compiles once per project/workspace group,
in-process, arena-rewound; children exec only") is now itself the **rejected**
alternative for the compiler suite — see §1a for the empirical falsification.
Its irreducible flaws on the primary consumer: (a) a project-root group unions
conflicting descriptors and miscompiles the losers (Finding 1); (b) in-process
compile-all is slow (~40 min) with no landed memo (Finding 3); (c) the arena
reclamation it depended on is off by default, reviving the OOM (Finding 3). It is
*retained as a target* only under the strict prerequisites of §3.1 and §3.4 (see
issue 6), not as a ready design.

**Alternative 1 — serialized frontend snapshot.** Parent serializes resolved
interfaces / module graph / effect tables to a versioned snapshot; children
deserialize instead of recomputing, then compile the test source themselves.
*Reassessment in light of the failure:* now more attractive *relative to*
in-process compile-all, because it keeps per-file process teardown (no OOM) and
never unions conflicting descriptors (each child still compiles its own import
set). It is essentially Direction (iii) with an explicit on-disk format. The
cost is unchanged and real: `native_texts`/interface `.sfn-asm` are already on
disk, so the win is bounded to skipping re-parse, and a *stable* binary
serialization of parsed/typechecked interface state does not exist and would
introduce a format-drift versioning surface (any AST/effect-table field change
silently invalidates snapshots). **Not easy** — but no longer strictly dominated,
since the approach that dominated it (in-process compile-all) has failed. Prefer
the in-memory group-keyed cache of Direction (iii) first (no on-disk format), and
escalate to a serialized snapshot only if cross-*process* sharing is required.

**Alternative 3 — resolver daemon / IPC (the 0006 shape).** A long-lived frontend
server holds resolved interfaces resident; children query it per compile.
*Reassessment:* the reason it was rejected — "Alternative 2 achieves the target
with no new protocol" — **no longer holds**, because Alternative 2 (in-process
compile-all) failed. A daemon does not suffer the union conflict (each query
carries its own import set) or the single-process OOM (the daemon holds only
resolved interfaces, not the accumulating compile arena of ~400 files). It
remains the **most machinery** — wire protocol, server lifecycle, crash/restart,
a client in every child, and 0006's per-query IPC round-trips on a non-tiny
payload (interface ASTs). It is still **not easy** and still premature relative
to the conservative Direction (iii); but it is now the honest long-term shape if
`sfn check` / `sfn build` (not just `sfn test`) come to need cross-invocation
frontend sharing (the 0006 redesign). Keep it explicitly on the table as the
end-state, not dismissed.

**Sub-decision — keep forking for execution vs. run in-process.** Still
**rejected** to run tests in-process: an `assert false` calls `abort()`, a
hanging test is unkillable without a subprocess `timeout`, and per-test teardown
is the only reliable reclamation of a test that leaks fds/threads. Execution
isolation stays in children under every direction — which is exactly why the
exec-only child (§3.5) is salvageable independent of the compile side.

## 7. Stage1 readiness mapping

Tooling change plus (for issue 3) a resolver/mangling change; no user-facing
language surface.

- [ ] Parses — N/A (no new syntax; `__run-test-bin` is a dispatch string)
- [ ] Type-checks / effect-checks — `test.sfn` and `capsule_resolver.sfn` pass
      `sfn check`
- [ ] Emits valid `.sfn-asm` — exercised by `make compile`
- [ ] Lowers to LLVM IR — exercised by `make compile`; issue 3's mangling change
      must lower cleanly for both `number_to_string` callees
- [ ] Regression coverage — see §8
- [ ] Self-hosts — `make compile` then **`make check` over the combined suite**
      (unit+integration+e2e+capsules in one invocation — the gate that exposed
      the flaw; small-dir passing is insufficient)
- [ ] `sfn fmt --check` clean — on every touched `.sfn`
- [ ] Documented in `docs/status.md` — the test-runner architecture change and
      (for issue 3) the descriptor-disambiguation semantics; this SFEP is the
      design record

## 8. Test plan

The load-bearing property is unchanged — parent/shared-compiled binaries must be
behavior-equivalent to per-file-compiled binaries, and execution fault-isolation
must be preserved — but the **validating invocation is now explicitly the
combined compiler suite**, because that is what falsified the Accepted design.

**Primary gate (non-negotiable):** `make test` and `make check` run
`sailfin test compiler/tests/unit compiler/tests/integration compiler/tests/e2e
capsules --jobs N` in **one** invocation and must be green. Any future design in
§3 is not "shipped" until it clears this exact invocation. A green run on a
standalone multi-file dir, a single-capsule dir, or `capsules` alone is **not**
sufficient evidence — all three passed while `make test` failed 435/435.

Targeted additions (per issue):

- **Issue 3 (descriptor ambiguity).**
  `compiler/tests/e2e/resolver_symbol_abi_conflict_test.sfn` — `![io]`: a suite
  containing both a file that imports the `![pure]` int-signature
  `number_to_string` (#633) and a file that uses the `double` runtime helper,
  compiled through *one* resolver group; assert both link and run correctly (no
  `ABI primitive mismatch`, no `undefined reference`). This is the direct
  regression for Finding 1.
- **Issue 2 (exec-only child).**
  `compiler/tests/e2e/parent_compile_multifile_test.sfn` — `![io]`: a small
  multi-file suite via a spawned `sfn test <dir>`; assert all pass and aggregate
  counts match a per-file baseline.
  `compiler/tests/e2e/test_runner_crash_isolation_test.sfn` — one fixture that
  `assert false`s and one that passes; assert the passing one still runs, the
  aborting one is reported failed, the runner exits nonzero (execution isolation
  survived).
  `compiler/tests/e2e/test_runner_timeout_isolation_test.sfn` — an infinite-loop
  fixture killed by `timeout` (exit 124) while siblings complete.
- **Issue 4 (arena/batching).** A peak-RSS guard: run the combined suite under
  the SFEP-0022 Darwin budget / seedcheck's pinned-scratch full-suite run and
  assert it stays under budget (the Finding 3 OOM regression guard). If
  subprocess batching is chosen, assert a batch worker compiles N files in one
  process without exceeding the per-process cap.
- **Issue 5/6 (sharing).**
  `compiler/tests/e2e/test_bin_cache_parent_hit_test.sfn` — run a suite twice;
  assert a high `cache.test_bin_hit_rate` on the second run.
- Existing `check_build_agree_module_global_test.sfn` and the JSON sub-frame
  aggregation tests continue to gate output correctness.

**Perf gate (informational, not CI-blocking):** record before/after per-file
cost on a heavy-closure suite in the PR. Note that the Accepted ~1.5–2.5 s/file
projection assumed an unlanded memo and is **not** a target any current
direction commits to until measured.

## 9. References

- **#2010** — the epic; this is the structural fix for sub-item (b).
- **#1997** — the resolver-sharing follow-up SFEP-0044 §3-C deferred.
- **#633** — the `![pure]` int-signature import fix whose descriptor coexists
  with the `double` runtime helper; the root of the Finding 1 conflict.
- **SFEP-0044** (`docs/proposals/0044-test-runner-invocation-cache.md`) — the
  parent-warms-once / children-consume pattern; Direction (iii) extends it from
  backend artifacts to a shared frontend import-context; §3-C is the explicit
  deferral of resolver sharing gated on 0006.
- **#2013 / PR #2014** — dep `.ll`→`.o` cache (link 8.3 s → ~1 s).
- **#2016 / PR #2018** — single-parse import gather (lowering 25.3 s → ~9 s);
  the memo Direction (iv)/issue 6 would extend from "parse once per compile" to
  "compute once per group" was **not** landed and is not assumed here.
- **SFEP-0006** (`docs/proposals/0006-build-architecture.md`) — build/IPC
  bottleneck root cause; frames Alt 1 (snapshot) and Alt 3 (daemon/IPC).
- **SFEP-0022** (`docs/proposals/0022-darwin-memory-governor.md`) — the Darwin
  memory budget any in-process compile-all (issue 4/6) must fit.
- **#848** — the multi-file per-child isolation this SFEP restructures;
  `test.sfn:557-576` documents why forking exists and names the
  `number_to_string` conflict.
- **#940** — shared-objdir runtime warm; **#1333** — per-child scratch;
  **#1236 / #1303** — bounded worker pool + signal-kill retry gate.
- Key code paths: `compiler/src/cli/commands/test.sfn:583` (multi-file fork
  branch — returns before the serial path, making the group loop below dead code
  for >1 file; Finding 1); `:657` (parent runtime warm); `:1017-1067` (per-group
  resolver + interface load — the union that conflicts); `:1078-1079` (arena
  rewind is a **no-op** when `SAILFIN_USE_ARENA` is unset — Finding 3);
  `:1156-1420` (the serial compile+link+run loop); `:705-960` (bounded pool +
  reap + retry + JSON aggregation reused for exec-only children);
  `compiler/src/main.sfn:482`
  (`compile_tests_to_llvm_file_with_module_imports`);
  `compiler/src/capsule_resolver.sfn:3476`
  (`prepare_project_capsules_for_test` — the union point);
  `compiler/src/build_cache.sfn:1281` (`test_bin_cache_key`).
