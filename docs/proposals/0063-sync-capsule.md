---
sfep: 0063
title: sfn/sync — scope and blocking predecessor for a synchronization capsule
status: Accepted
type: language
created: 2026-08-01
updated: 2026-08-02
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0063 — `sfn/sync`: scope and blocking predecessor for a synchronization capsule

## 1. Summary

`capsules/sfn/sync/` is an empty reserved shell left over from the removal of
the untyped `channel`/`parallel`/`spawn` exports that once fronted no-op C
bridges (`capsules/sfn/sync/src/mod.sfn:1-30`). Everything that actually ships
today — `spawn`, `parallel`, `routine { }`, `channel(N)` — is language-level,
not capsule surface. This proposal evaluates what a real `sfn/sync` library
(`Mutex`, `RwLock`, `Semaphore`, `WaitGroup`, `select`) would need to export and
concludes the library is **buildable today but not safely reclaimable**:
ordinary struct-typed sync objects (a `Mutex` backed by a `pthread_mutex_t`, an
atomic cell) are not owned/affine types, so the ownership checker's
spawn-capture move rule never fires on them and they can already be shared
across `spawn`-family closures. What is missing is the substrate to tear one
down safely once shared: the reference-counting runtime never invokes a stored
destructor at refcount zero, and nothing tracks who is responsible for
releasing a shared handle. This proposal authorizes only a **Phase 0**
correction — stop advertising a capsule wrapper that does not exist and stop
declaring an `io` capability the capsule does not use — and defers the library
itself to a follow-up SFEP that closes the reclamation gap.

## 2. Motivation

`capsules/sfn/sync/src/mod.sfn` is nothing but a comment: zero exports, zero
functions. Its capsule manifest nonetheless declares
`[capabilities] required = ["io"]` (`capsules/sfn/sync/capsule.toml:8-9`) for a
capsule that performs no I/O, and its module comment cites artifacts that no
longer exist — a deleted C file
(`runtime/native/src/sailfin_runtime.c`), a retired bash test
(`test_sync_rejects_unimplemented_concurrency.sh`, now
`compiler/tests/e2e/sync_rejects_unimplemented_concurrency_test.sfn`), and a
"structured-concurrency runtime" that has since shipped
(`runtime/sfn/concurrency/nursery.sfn`, `runtime/sfn/concurrency/channel.sfn`).
Three further sites — `docs/status.md:748`,
`site/src/content/docs/docs/reference/standard-library.md:322-323,344-345`,
and `site/src/content/docs/docs/learn/concurrency.md:93` — tell readers a
"typed `sfn/sync` capsule wrapper" is pending, without saying what it would
actually contain or why it hasn't shipped. None of this is merely stale prose:
an over-broad manifest on an empty capsule undercuts the Reach pillar's claim
that Sailfin's capability manifests are tight and trustworthy, and "wrapper
coming later" reads as a scheduling gap when the real blocker is an
undesigned reclamation story for shared concurrent objects (§3.1).

Before correcting the record, this proposal first asks the substantive
question the status quo begs: what would `sfn/sync` actually export, and what,
concretely, is stopping it? §3 answers both.

## 3. Design

### 3.1 The central finding: sync objects are buildable today, but not safely reclaimable

A synchronization primitive — a mutex, a semaphore, a wait group — exists to
be held by more than one concurrent worker at once. It is tempting to assume
the ownership checker's spawn-capture rule forecloses that, but it does not:
`_consume_spawn_captures` (`compiler/src/ownership_checker.sfn:438-473`,
called from the `Spawn`, `parallel`-task, and `serve`-handler arms at lines
960, 981, and 993) routes each free variable of the closure through
`_consume_identifier`, which gates immediately on `if !binding.is_owned {
return scope; }` (`ownership_checker.sfn:373`). `is_owned` comes from
`is_owned_type` (`compiler/src/typecheck_types/expr_type_rules.sfn:232-239`),
which returns true for exactly four annotation spellings: `OwnedBuf`,
`OwnedBuf<`, `Affine<`, `Linear<`. An ordinary `struct Mutex` or an `i64`/`*u8`
handle has `is_owned == false`, so no rule fires and no move is recorded —
`ownership_checker.sfn:104-105` states this directly. Two `spawn` closures
capturing the same ordinary struct or handle compile today.

An existence proof already ships in-tree:
`runtime/sfn/concurrency/channel.sfn` is a heap-allocated object guarded by a
`pthread_mutex_t` and two `pthread_cond_t`, shared across worker threads,
written in Sailfin against `runtime/sfn/platform/pthread_layout.sfn:43-65`.
Structurally that is a mutex plus condvars, and it works.

> **Update (2026-08-02, at acceptance).** The leak described in the next
> paragraph has since been fixed, and the fix validated this section's
> analysis: reclamation now happens at `routine { }` scope exit, strictly
> after the join-all barrier, which is exactly the point this proposal
> predicted. The paragraph is kept as written because it is the evidence the
> argument rests on. What it does **not** do is unblock the capsule — see
> §3.6 for what the fix changed and what it left.

That same file also demonstrates the gap, not just the capability. It defines
a complete and correct teardown — `sfn_channel_destroy`
(`runtime/sfn/concurrency/channel.sfn:286-327`) destroys both condvars and the
mutex, drains abandoned owned elements, and frees the ring buffer and the
handle — and **nothing ever calls it**.
`compiler/src/llvm/runtime_helpers/registry_services.sfn` registers
`channel_create` (line 184) and `channel_close` (line 193); there is no
`channel_destroy` row, and every remaining mention in the tree is a comment.
`channel_close` is not teardown: it flips the closed flag and broadcasts the
condvars (`channel.sfn:275-279`) so blocked peers wake, leaving the resources
alive. So every `channel(N)` in every Sailfin program leaks a `pthread_mutex_t`,
two `pthread_cond_t`, the ring buffer, and the handle. The shipped
synchronization object is constructible, correct in operation, and has no
reachable reclamation point — which is precisely the claim of this section,
demonstrated in production code rather than argued from first principles. This
is filed as a separate runtime bug; §3.4 does not fix it.

The real gap is reclamation, not construction. `sfn_rc_sfn_release`
(`runtime/sfn/memory/rc.sfn:130-143`) decrements the refcount and, when
`prev == 1`, calls libc `free` **directly** — it never invokes the stored
`drop_fn`. `rc.sfn:34-39` says so explicitly: "M2.3 stores the address but
never dereferences it; releases that hit zero call `free` directly and skip
the destructor hook," with invocation deferred. A shared `Mutex` can
therefore never run `pthread_mutex_destroy` at refcount zero — the runtime
would either leak the pthread resources or `free` them without destroying,
both unsound. Beyond that, nothing tracks who releases a shared handle:
captures copy the handle by value, and no rule tracks ownership of the
pointee across the spawn boundary, so a shared sync object leaks or races on
teardown even once a destructor hook exists. Both gaps are runtime/RC
substrate work, not an ownership-checker exemption, and belong in a dedicated
follow-up SFEP.

A soundness observation worth recording here: because `is_owned_type` matches
on annotation *text*, a library author opts into or out of E11 (SFEP-0018's
capture-move workstream label; see `docs/proposals/0018-borrow-checking-1.0.md:771`)
move-tracking purely by how a type is spelled. `Affine<Mutex>` gets
capture-move enforcement; `struct Mutex` gets none. The tracked-ness of a type
is a naming convention, not a property of the type — worth knowing before
anyone designs on top of the ownership pass.

For context, the historical workaround for sharing a `Channel` across
`spawn`/`parallel` was a **module global**
(`compiler/tests/e2e/channel_producer_consumer_exec_test.sfn:20-25`), adopted
because "the lambda capture-env ABI is carved out to #1475/#1476." Both
carve-outs have since landed — see `compiler/tests/e2e/spawn_capture_env_free_test.sfn`
(IR, runtime, and ASAN coverage) and the `sfn_spawn_*_owned_ctx` /
`_owned_buf_ctx` descriptor families at
`compiler/src/llvm/runtime_helpers/registry_concurrency.sfn:119-160` — so
module-global sharing is no longer the only mechanism available; it is
superseded history, not the current constraint.

### 3.2 Per-candidate verdicts

| Candidate | Verdict | Reason |
|---|---|---|
| `Mutex` | Buildable, unsafe to reclaim | No destructor hook fires at refcount zero, and nothing tracks who releases a shared handle (§3.1). The blocker is substrate completion, not an ownership-checker exemption. |
| `RwLock` | Buildable, unsafe to reclaim | Same root cause as `Mutex`. |
| `Semaphore` | Buildable, unsafe to reclaim | Same root cause as `Mutex`. |
| `Once` | ~~Buildable, unsafe to reclaim~~ — **superseded by SFEP-0065 §3.4** | This row lumped `Once` in with `Mutex` without analysing it. SFEP-0065 §3.4 overrides it: `Once` owns a single `i64` and no OS resource, so the destructor question this row gates on is vacuous for the type, and it ships *before* the reclamation seam. |
| Atomics (`AtomicInt`, etc.) | ~~Buildable, unsafe to reclaim~~ — **superseded by SFEP-0065 §3.5** | SFEP-0065 §3.5 overrides this row by exporting no atomic surface at all, on a different and concrete ground: `is_atomic_builtin` short-circuits ahead of the runtime-helper registry, so a capsule-defined `atomic_*` would be silently unreachable even when explicitly imported. |
| `WaitGroup` | Rejected as redundant | `routine { }` already joins every spawned child at scope exit (`runtime/sfn/concurrency/nursery.sfn:1-13`); a `WaitGroup` would be that same barrier reimplemented with a manual, unsafe counter. |
| `select` over channels | Blocked on separate plumbing | `sfn_io_poll_any` (`runtime/sfn/process.sfn:836`) is a real N-way `poll` with timeout, but it is strictly fd-based; `Channel<T>` signals readiness via `pthread_cond_t` (`runtime/sfn/concurrency/channel.sfn:85-93,155-278`), which has no fd, and no self-pipe/eventfd bridge between the two exists. This blocker is independent of §3.1's reclamation gap. |

### 3.3 A design-philosophy note: be conservative about scope

The concurrency surface that ships today is CSP-flavored — share by
communicating over `channel`, structure lifetimes with `routine { }` nurseries
— not lock-and-shared-state. A lock-centric library sits partly against the
grain of that model. This is not an argument that locks are never warranted
(some algorithms genuinely need mutual exclusion over shared state that
channels express awkwardly), but it is a reason to keep `sfn/sync`'s eventual
scope narrow and to let the reclamation-substrate follow-up SFEP, not this
one, decide how much lock-based surface is worth adding once safe teardown is
possible at all.

### 3.4 Phase 0 — the only phase this proposal authorizes

Phase 0 is purely corrective: it removes inaccurate claims and does not add
any new surface.

1. Rewrite `capsules/sfn/sync/src/mod.sfn`'s header comment. The current text
   cites a deleted file (`runtime/native/src/sailfin_runtime.c`), a retired
   bash test (superseded by
   `compiler/tests/e2e/sync_rejects_unimplemented_concurrency_test.sfn`), and
   tells readers to wait for a structured-concurrency runtime that has since
   shipped. The rewritten comment should instead point at this SFEP as the
   reason the capsule stays an empty, reserved shell.
2. Change `capsules/sfn/sync/capsule.toml`'s `[capabilities] required = ["io"]`
   to `required = []`. The capsule has zero lines of code and performs no I/O;
   an empty capsule claiming `io` in its manifest is exactly the kind of
   over-claim that undercuts the Reach pillar's promise that Sailfin's
   capability manifests are tight and complete.
3. Correct the three sites advertising an unbuilt "typed `sfn/sync` capsule
   wrapper": `docs/status.md:748`,
   `site/src/content/docs/docs/reference/standard-library.md:322-323,344-345`,
   and `site/src/content/docs/docs/learn/concurrency.md:93`. The corrected
   wording should say that concurrency is language-level today and that no
   capsule wrapper is planned pending the reclamation-substrate predecessor
   described in §3.1. `standard-library.md:344-345` and
   `learn/concurrency.md:93` each bundle a second, still-true claim into the
   same sentence — that the generic `channel<T>(...)` constructor is not yet
   shipped — and the rewrite must preserve that claim unchanged; only the
   `sfn/sync` wrapper half of the sentence is stale.

### 3.5 A defect to record, not fix here

Three files import names from the empty `sfn/sync` capsule and it silently
succeeds: `examples/concurrency/producer-consumer.sfn:2`,
`examples/concurrency/dynamic-task-scheduling.sfn:2`, and
`site/src/content/docs/docs/reference/spec/02-modules.md:10` all write
`import { Channel, channel } from "sync";`. These resolve only because
`Channel`/`channel` are compiler-special-cased language builtins, not because
the capsule exports them — the import itself is decorative and unvalidated
against the capsule's actual (empty) export list. Two consequences follow: (a)
if a future `sfn/sync` phase ever exports its own `Channel`, these three
imports would silently change meaning from "resolve to the language builtin"
to "resolve to the capsule symbol," so any such phase must sequence around
them; (b) `sfn check` performs no import validation at all.

Consequence (b) was confirmed empirically against seed 0.8.4 after this
section was first drafted, and is broader than the `sfn/sync` shell. All three
of these pass `sfn check` with `checked 1 files: ok`: a name that does not
exist in a real capsule (`import { definitely_not_a_real_export } from
"sfn/strings"`), a capsule that does not exist at all (`import { anything }
from "no/such/capsule"`), and a nonexistent import that is actually called —
which then fails `sfn emit llvm` with `cannot resolve return type for call to
...`. Check green, build fatal: an instance of the known "green is not a build
guarantee" gap, reaching a user-source error that surfaces as an unspanned
lowering fatal rather than a spanned `Diagnostic`.

This is filed as a separate compiler bug and this proposal does not design the
fix. Two notes for whoever takes it: the spec's canonical import example
(`02-modules.md:10`) is one of the passing cases, so we are teaching it; and
tightening the check must first settle what happens to the compiler-special-
cased `Channel`/`channel` names, which are the reason these three imports
resolve at all.

### 3.6 State at acceptance: what the channel-leak fix changed, and what it left

The channel leak in §3.1 was fixed before this proposal was accepted, and the
fix is recorded here because it moves the boundary this proposal draws — it
does not erase it.

**What it established.** The nursery now *owns* the channels created in its
scope: `sfn_channel_create` hands each new handle to `sfn_nursery_current()`
as its final step (so a handle that failed pthread init is never registered),
and `sfn_nursery_exit` destroys every registered channel strictly after the
join-all barrier, then frees the list. Ordering after the joins is the whole
point — it is precisely the precondition `sfn_channel_destroy` documents, so
that safety contract is now structural rather than a comment. **Scope-bound
reclamation for shared concurrent objects is a solved, shipped pattern**, and
that is the mechanism a sync capsule would build on.

**What it left.** The seam is channel-specific, in two ways that matter to any
second resource type:

1. `sfn_nursery_register_channel(n: i64, ch: i64)` records a **bare handle**.
   No destructor travels with it.
2. `sfn_nursery_exit` **hardcodes** `sfn_channel_close` followed by
   `sfn_channel_destroy` in its teardown loop.

So a `Mutex` cannot ride the existing seam. It would need either a parallel
`register_mutex` list — which does not scale past a second resource type — or
generalization of the registry to `(handle, destructor)` pairs.

**The remaining blocker is now runtime-integration work, not a missing
capability.** Generalizing the seam requires calling a destructor through a
*stored function pointer* — and that capability already ships (SFEP-0064
§3.1, #1089): a local or parameter annotated `*fn (A) -> R` already lowers to
a direct indirect call with no compiler change needed. What is missing is the
wiring: the nursery registry still records a bare handle with a hardcoded
channel destructor instead of a `(handle, destructor)` pair, and
`sfn_rc_sfn_release` (`runtime/sfn/memory/rc.sfn`) still calls libc `free`
directly when the refcount hits zero instead of dereferencing the stored
`drop_fn` first. Related and probably entangled: `runtime/sfn/platform/pthread.sfn`'s
header records that the extern accept-list requires a literal `fn(` prefix
while `sfn fmt` rewrites it to `fn (`, so typed function-pointer externs are
currently spelled `* u8` and cast at the call site.

This is a **narrowing**, and a favourable one. At drafting, the blocker was an
undesigned reclamation story. It is now runtime-integration work — generalizing
the nursery registry and wiring `drop_fn` invocation — with two known
consumers (the generic nursery seam, `rc.sfn`'s drop_fn) and one known
adjacent constraint (the extern spelling conflict), and it needs no compiler
capability the seed lacks. That is small enough to design directly, and the
follow-up SFEP this proposal defers to should be scoped to exactly it rather
than to a synchronization library. The library is downstream of that
integration work, not of this document.

## 4. Effect & capability impact

Per SFEP-0049, the concurrency-primitive leaves (`spawn`, `parallel`, channel
`send`/`receive`) are effect-transparent: the registry rows carry no effect of
their own, and the caller inherits exactly the effects of the body passing
through them. If a future `Mutex.lock()` followed that same model, it would be
effect-free in itself, with blocking not implying `![clock]` or any other
effect — but that is an implication of SFEP-0049's existing model to note, not
a decision this proposal makes; the follow-up design that closes §3.1's
reclamation gap is the one that settles it. Phase 0's only capability change
is the manifest edit in §3.4: `capsules/sfn/sync/capsule.toml`'s
`required = ["io"]` becomes `required = []`. This proposal allocates **no**
diagnostic code. For future reference: `E08xx` is nearly exhausted, `E09xx` is
the ownership/affine range, and `E1100`-`E1114` already belongs to SFEP-0062 —
a follow-up proposal is free to allocate from the next open number in `E09xx`
or wherever the reclamation-substrate design lands, should it need a
diagnostic at all.

## 5. Self-hosting impact

Phase 0 touches no compiler pass. The only `.sfn` file it changes is
`capsules/sfn/sync/src/mod.sfn`, and that change is comment-only, so
`sfn fmt --check` applies to it; everything else in Phase 0 is Markdown
(`docs/status.md`, the two site pages) and TOML (`capsule.toml`). Per
`.claude/rules/seed-dependency.md`, the bundling-vs-splitting question that
rule governs does not arise here: Phase 0 adds no compiler capability for
runtime source or anything else to consume, so there is no seed dependency to
bundle or split.

## 6. Alternatives considered

- **Delete the capsule outright.** Forfeits the `sfn/sync` name in the
  workspace, and the shell is harmless once its manifest and comment are
  honest about what it is (Phase 0 makes them so).
- **Build the library now, on top of ordinary (non-owned) struct types.**
  Compiles today (§3.1), but ships an API with no safe way to destroy a
  shared instance — the destructor-hook and release-ownership gaps mean any
  real teardown path either leaks pthread resources or races. Shipping that
  as a library surface would need a breaking redesign the moment the
  reclamation substrate lands.
- **Wire `drop_fn` invocation in `sfn_rc_sfn_release` and stop there, with no
  user-facing carrier type.** This closes fact 2 from §3.1 (the missing
  destructor hook) without inventing new surface, and may be sufficient on
  its own if release-ownership tracking (fact 3) turns out not to need a
  dedicated carrier type either. This is the narrower, cheaper path and the
  follow-up design should weigh it seriously before assuming a carrier is
  needed.
- **Ship `WaitGroup` alone**, since a manual counter needs no sharing
  primitive to implement. Rejected as redundant: `routine { }` already
  provides that exact join-all barrier (§3.2).

## 7. Stage1 readiness mapping

Phase 0 ships no language feature, so nearly every box is not applicable:

- [N/A] Parses — no syntax added.
- [N/A] Type-checks / effect-checks — no new type or effect.
- [N/A] Emits valid `.sfn-asm` — no codegen touched.
- [N/A] Lowers to LLVM IR — no codegen touched.
- [N/A] Regression coverage — see §8; Phase 0 adds none by design.
- [x] Self-hosts — Phase 0's one `.sfn` change is comment-only and does not
      affect self-hosting (§5).
- [x] `sfn fmt --check` clean — applies to the one touched `.sfn` file.
- [x] Documented in `docs/status.md` + spec — §3.4 item 3 is exactly this
      correction.

## 8. Test plan

Phase 0 is comment, manifest, and documentation only, and adds no regression
test — there is no new behavior to pin. The existing
`compiler/tests/e2e/sync_rejects_unimplemented_concurrency_test.sfn` already
pins the fail-closed behavior for the removed `channel`/`parallel`/`spawn`
capsule exports and stays valid unchanged by this proposal; Phase 0 does not
touch it.

## 9. References

- `capsules/sfn/sync/capsule.toml`, `capsules/sfn/sync/src/mod.sfn`
- `compiler/src/ownership_checker.sfn:373` (`_consume_identifier`'s
  `is_owned` gate), `:104-105` (copyable bindings never move-tracked),
  `:438-473` (`_consume_spawn_captures`)
- `compiler/src/typecheck_types/expr_type_rules.sfn:232-239` (`is_owned_type`
  — the four owned/affine annotation spellings)
- `compiler/tests/e2e/channel_producer_consumer_exec_test.sfn:20-25`
  (superseded module-global sharing precedent — both capture-env carve-outs
  it names have since landed)
- `compiler/tests/e2e/spawn_capture_env_free_test.sfn` (capture-env move/free
  discipline that supersedes the module-global-only precedent)
- `compiler/src/llvm/runtime_helpers/registry_concurrency.sfn:119-160`
  (`sfn_spawn_*_owned_ctx` / `_owned_buf_ctx` descriptor families)
- `compiler/tests/e2e/sync_rejects_unimplemented_concurrency_test.sfn`
- `runtime/sfn/memory/rc.sfn:34-39` (drop_fn invocation deferred),
  `:130-143` (`sfn_rc_sfn_release` frees directly, skips `drop_fn`)
- `runtime/sfn/concurrency/nursery.sfn:1-13,32-38` (join-all-only nursery)
- `runtime/sfn/concurrency/channel.sfn` (`pthread_cond_t`-based signaling; the
  in-tree existence proof of a shared mutex/condvar object)
- `runtime/sfn/platform/pthread.sfn`, `runtime/sfn/platform/pthread_layout.sfn:43-65`
- `runtime/sfn/process.sfn:836` (`sfn_io_poll_any`)
- `docs/proposals/0018-borrow-checking-1.0.md:771` (E11 workstream label —
  channel-send / spawn-capture as moves)
- SFEP-0049 (`docs/proposals/0049-concurrency-effect-transparency.md`) —
  effect-transparency model this proposal's §4 extends
- SFEP-0055 (`docs/proposals/0055-typed-task-handles.md`) — typed task
  handles, the adjacent concurrency-typing predecessor
- `docs/proposals/draft-concurrency-cancellation.md` — cancel-on-fault and
  async I/O, the join-half concurrency maturity work this proposal does not
  overlap with
- `docs/status.md:748`,
  `site/src/content/docs/docs/reference/standard-library.md:317-345`,
  `site/src/content/docs/docs/learn/concurrency.md:90-94` (Phase 0 correction
  sites)
- `examples/concurrency/producer-consumer.sfn:2`,
  `examples/concurrency/dynamic-task-scheduling.sfn:2`,
  `site/src/content/docs/docs/reference/spec/02-modules.md:10` (§3.5 defect)

Spotted, not fixed here: `compiler/src/llvm/lowering/module_globals.sfn:136`
carries the same stale "carved out to #1475/#1476" wording as
`channel_producer_consumer_exec_test.sfn`'s header (§3.1). It is a compiler
source comment, out of scope for this docs-only proposal — noted here as a
follow-up cleanup for whoever next touches that file.
