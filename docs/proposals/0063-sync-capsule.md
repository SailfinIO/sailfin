---
sfep: 63
title: sfn/sync — scope and blocking predecessor for a synchronization capsule
status: Draft
type: language
created: 2026-08-01
updated: 2026-08-01
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
concludes the library is **blocked on a single missing language primitive**: a
user-facing shared-ownership carrier. Locks, semaphores, and similar objects
are by construction shared by two or more concurrent workers, and Sailfin's
ownership checker currently has no way to hand the same owned value to two
`spawn`-family closures without moving it out from under the first. This
proposal authorizes only a **Phase 0** correction — stop advertising a capsule
wrapper and an `io` capability that do not exist — and defers the library
itself to a follow-up SFEP that designs the shared-ownership carrier.

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
coming later" reads as a scheduling gap when the real blocker is a missing
ownership-system feature that has not yet been designed.

Before correcting the record, this proposal first asks the substantive
question the status quo begs: what would `sfn/sync` actually export, and what,
concretely, is stopping it? §3 answers both.

## 3. Design

### 3.1 The central finding: no synchronization object can be shared today

A synchronization primitive — a mutex, a semaphore, a wait group — exists to
be held by more than one concurrent worker at once. Sailfin's ownership
checker forecloses that today at the one place concurrency escapes a scope:
`_consume_spawn_captures` (`compiler/src/ownership_checker.sfn:438-475`,
called from the `Spawn`, `parallel`-task, and `serve`-handler arms at lines
960, 981, and 993). Its own header states the rule precisely: a
`spawn`/`parallel`/`serve` worker outlives the spawning scope, so *every* free
variable of its closure that resolves to an owned live binding is consumed as
a move (`Owned -> Moved`), and any later use on the sender becomes
use-after-move (`E0901`). That rule is correct and load-bearing for the single
case it targets (one value escaping to one worker) — but it means two workers
capturing the same `Mutex` cannot both compile: the first `spawn` moves it out
of the parent scope, and the second capture is `E0901`.

The only sharing mechanism that exists today routes around this by never
capturing at all. `compiler/tests/e2e/channel_producer_consumer_exec_test.sfn`
adopts it explicitly and says so in its own header (lines 20-25): the shared
channel is a **module global** (`let g_ch = channel(2)`), because a global
handle is "the capture-free way to share one channel across two tasks — the
lambda capture-env ABI is carved out to #1475/#1476." This is the existing
precedent for sharing across `spawn`/`parallel`, and it is not an acceptable
foundation for a synchronization library API: a module global permits no
per-instance lock, no lock embedded inside a data structure, and no lock
passed as a function argument. A `Mutex` field on a struct, or a `Semaphore`
returned from a constructor and threaded through several call sites, is
exactly the shape a real library needs and exactly the shape module-global
sharing cannot express.

The substrate for a shared object already exists — the gap is entirely at the
type/ownership layer, not the runtime layer. `runtime/sfn/memory/rc.sfn`
already implements atomic reference counting: a 16-byte header
(`refcount: i64` at offset 0, `drop_fn: *u8` at offset 8,
`runtime/sfn/memory/rc.sfn:8-20`) with `sfn_rc_sfn_retain` / `sfn_rc_sfn_release`
lowering to `atomicrmw add` / `atomicrmw sub` with `seq_cst` ordering
(`runtime/sfn/memory/rc.sfn:14-20`). What is missing is (a) a user-facing type
that wraps that mechanism — working name `Shared<T>` — and (b) an ownership-
checker rule that recognizes a capture of a `Shared<T>` inside a spawn-family
closure as a **share** (retain the refcount, leave the sender's binding live)
rather than a move. Both parts are a language/ownership-system feature in
their own right, not capsule work, and belong in a dedicated follow-up SFEP —
this proposal states the requirement and its two parts so that follow-up can
start from a concrete brief; it does not design the carrier's syntax, generic
instantiation, or drop-timing semantics here.

### 3.2 Per-candidate verdicts

| Candidate | Verdict | Reason |
|---|---|---|
| `Mutex` | Blocked | Needs the shared-ownership carrier (§3.1) — a lock is definitionally held by ≥2 workers. |
| `RwLock` | Blocked | Same root cause as `Mutex`. |
| `Semaphore` | Blocked | Same root cause as `Mutex`. |
| `Once` | Blocked | Same root cause as `Mutex`. |
| Atomics (`AtomicInt`, etc.) | Blocked | Same root cause as `Mutex` — a shared atomic cell has the identical capture problem even though the update itself is lock-free. |
| `WaitGroup` | Rejected as redundant | `routine { }` already joins every spawned child at scope exit (`runtime/sfn/concurrency/nursery.sfn:1-13`); a `WaitGroup` would be that same barrier reimplemented with a manual, unsafe counter. |
| `select` over channels | Blocked on separate plumbing | `sfn_io_poll_any` (`runtime/sfn/process.sfn:836`) is a real N-way `poll` with timeout, but it is strictly fd-based; `Channel<T>` signals readiness via `pthread_cond_t` (`runtime/sfn/concurrency/channel.sfn:85-93,155-278`), which has no fd, and no self-pipe/eventfd bridge between the two exists. This blocker is independent of §3.1's shared-carrier gap. |

### 3.3 A design-philosophy note: be conservative about scope

The concurrency surface that ships today is CSP-flavored — share by
communicating over `channel`, structure lifetimes with `routine { }` nurseries
— not lock-and-shared-state. A lock-centric library sits partly against the
grain of that model. This is not an argument that locks are never warranted
(some algorithms genuinely need mutual exclusion over shared state that
channels express awkwardly), but it is a reason to keep `sfn/sync`'s eventual
scope narrow and to let the shared-carrier SFEP, not this one, decide how much
lock-based surface is worth adding once sharing is possible at all.

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
   capsule wrapper is planned pending the shared-ownership-carrier predecessor
   described in §3.1.

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

## 4. Effect & capability impact

Per SFEP-0049, the concurrency-primitive leaves (`spawn`, `parallel`, channel
`send`/`receive`) are effect-transparent: the registry rows carry no effect of
their own, and the caller inherits exactly the effects of the body passing
through them. A future `Mutex.lock()` (once the shared-carrier predecessor
lands) should follow the same model — effect-free in itself, with blocking not
implying `![clock]` or any other effect. Phase 0's only capability change is
the manifest edit in §3.4: `capsules/sfn/sync/capsule.toml`'s
`required = ["io"]` becomes `required = []`. This proposal allocates **no**
diagnostic code. For future reference: `E08xx` is nearly exhausted, `E09xx` is
the ownership/affine range that a shared-carrier exemption rule would land in,
and `E1100`-`E1114` already belongs to SFEP-0062 — a follow-up proposal is free
to allocate from the next open number in `E09xx` or wherever the carrier's
design lands.

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
- **Build the library now on module-global-only sharing.** Produces a
  crippled API — no per-instance locks, no lock embedded in a struct, no lock
  passed to a function (§3.1) — that would need a breaking redesign the
  moment the shared-ownership carrier lands.
- **Exempt sync types from the E11 spawn-capture rule via a special case in
  the ownership checker.** This punches a targeted hole in a soundness pass
  for one family of types; the general shared-ownership carrier is the
  correct fix and benefits every future type that needs the same capability,
  not just `sfn/sync`'s.
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
- `compiler/src/ownership_checker.sfn:438-475` (`_consume_spawn_captures`)
- `compiler/tests/e2e/channel_producer_consumer_exec_test.sfn:20-25` (module-
  global sharing precedent)
- `compiler/tests/e2e/sync_rejects_unimplemented_concurrency_test.sfn`
- `runtime/sfn/memory/rc.sfn` (atomic refcount substrate)
- `runtime/sfn/concurrency/nursery.sfn:1-13,32-38` (join-all-only nursery)
- `runtime/sfn/concurrency/channel.sfn` (`pthread_cond_t`-based signaling)
- `runtime/sfn/platform/pthread.sfn`, `runtime/sfn/platform/pthread_layout.sfn:43-65`
- `runtime/sfn/process.sfn:836` (`sfn_io_poll_any`)
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
