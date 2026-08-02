---
sfep: 0065
title: sfn/sync — public API surface and semantics
status: Draft
type: language
created: 2026-08-02
updated: 2026-08-02
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0065 — `sfn/sync`: public API surface and semantics

## 1. Summary

SFEP-0063 established that synchronization objects are already *buildable* in
Sailfin — an ordinary `struct`-typed handle is not owned/affine, so the
ownership checker's spawn-capture move rule never fires and two `spawn`
closures can share one today — and that the single remaining blocker is
**reclamation**: nothing invokes a stored destructor when a shared object dies.
This proposal designs the other half: **what `sfn/sync` exports, and with what
semantics**, given a language with no `defer`, no RAII, and no user-facing drop
hook.

The core decision is that **`sfn/sync` exports no unlock operation at all.**
Mutual exclusion is offered exclusively through scoped closure combinators —
`with_lock(m, body)`, `with_read_lock`, `with_permit` — which acquire, run the
body inside a `try`/`catch`, release on both the normal and the throwing path,
and re-throw. This is not a stylistic preference: with no `defer`, a public
`unlock()` is unguarded against early `return` and `throw`, and a leaked lock
is a permanent deadlock — the worst failure mode a synchronization library can
ship. The combinator form makes the leak *structurally unrepresentable*, and
Sailfin already has the exact precedent in production
(`capsules/sfn/test/src/fixtures.sfn:55`, `with_tmp_dir`).

Two further decisions follow from what the language actually provides today.
**The capsule exposes no atomics wrapper** — `atomic_load`/`atomic_store`/
`atomic_add`/`atomic_sub`/`atomic_cas`/`atomic_fence` are already
user-reachable language builtins lowering to real `seq_cst` LLVM atomics
(`compiler/src/llvm/atomics.sfn:1-30`), and a capsule export bearing one of
those names would be *silently unreachable* because `is_atomic_builtin`
short-circuits ahead of call resolution. And **`Once` ships first**, ahead of
everything else, because it holds no OS resource and therefore needs no
teardown.

**Gating.** Everything from `Mutex` onward is gated on the reclamation seam —
the generic `(handle, destructor)` nursery registry and `rc.sfn`'s `drop_fn`
invocation — designed in the sibling proposal now in flight (SFEP-0064). This
document deliberately does **not** design that seam, design around it, or
duplicate its decisions. It depends only on the seam's *existence*, not its
shape. The one place where the shape leaks into the API surface (whether a
`routine { }` scope can be probed for absence at creation time) is recorded in
§3.8 as an open question rather than guessed.

## 2. Motivation

SFEP-0063 Phase 0 made `capsules/sfn/sync/` honest — an empty reserved shell
with `[capabilities] required = []` and a comment pointing at the reason. That
correction removed a false advertisement but left a real question unanswered:
when the reclamation gap closes, what should this capsule actually be?

Answering that *now*, in parallel with the seam, is worth doing for three
reasons.

**The API surface is independent of the seam's shape.** The seam decides how a
destructor travels with a handle inside the runtime. Nothing about that choice
changes whether the user writes `with_lock(m, body)` or `m.lock()`. Settling
the surface in parallel converts a serial two-proposal chain into one, and
means the session that lands the seam can be followed immediately by a session
that lands `Mutex` against an already-reviewed design.

**The hard constraint is a language property, not a runtime one, and it will
not be relieved by the seam.** Sailfin has no `defer`, no RAII, and no
user-facing Drop hook. A design that assumes scope-exit cleanup — the shape
every mainstream systems language uses for locks — is not merely inconvenient
here, it is unimplementable, and will stay unimplementable after the seam
lands. Discovering that during implementation would produce exactly the
API-shaped-like-Rust-but-unenforceable outcome that SFEP-0063 §6 already
rejected once.

**Part of the surface is not gated at all and can ship immediately.** §3.4
shows `Once` is buildable today against shipped builtins, and §3.5 shows the
atomics question resolves to "export nothing." That is a full session's worth
of shippable, ungated work that the current framing ("the whole capsule waits
on reclamation") would have left on the floor.

There is also a live correctness hazard the design must dodge. SFEP-0063 §3.5
records that `import { Channel, channel } from "sync"` appears in two examples
and in the spec's canonical import example, resolving only because
`Channel`/`channel` are compiler-special-cased builtins — `sfn check` performs
no import validation. Any name this capsule exports that collides with a
compiler-special-cased or builtin name inherits that ambiguity. §3.5 turns that
hazard into a hard naming rule.

## 3. Design

### 3.1 Shape of a handle, and why sharing needs no new machinery

Every object in this capsule is an **opaque handle struct wrapping a heap
address**, following `runtime/sfn/concurrency/channel.sfn`'s pointer-as-address
convention:

```sfn
// Opaque handle. The address points at a heap block holding the
// PthreadMutex storage from runtime/sfn/platform/pthread_layout.sfn.
// Copying the handle copies the address, not the lock.
struct Mutex {
    addr: i64;
}
```

Three properties fall out of this shape, and all three are load-bearing.

**Sharing already works, with zero diagnostics.** `Mutex` is an ordinary
struct, so `is_owned_type` (`compiler/src/typecheck_types/expr_type_rules.sfn:232-239`)
is false for it — it matches only `OwnedBuf`, `OwnedBuf<`, `Affine<`, and
`Linear<`. `_consume_identifier` therefore returns immediately at its
`if !binding.is_owned` gate (`compiler/src/ownership_checker.sfn:373`), and two
`spawn` closures capturing the same `Mutex` compile with no move recorded. This
proposal introduces **no carrier type** and requests **no ownership-checker
exemption**; SFEP-0063 §3.1 settled that there is no sharing problem to solve.

**Copying the handle is the sharing mechanism, and it is copy-cheap.** A
capture copies eight bytes; the pointee is shared. This is exactly how
`sfn_channel_*` already operates across worker threads.

**The struct is opaque by convention, not by enforcement.** Sailfin has no
private-field mechanism, so a caller can read `m.addr`. The capsule documents
the field as internal and does not promise its stability. This is the same
posture the runtime already takes with its handle structs, and it is not worth
a language feature.

### 3.2 The lock API: scoped combinators, and no public unlock

**Decision: the only way to hold a lock is to run a closure under it. There is
no exported `lock`, `unlock`, `acquire`, or `release`, in any phase.**

```sfn
// Run `body` with `m` held. The lock is released before this function
// returns, on both the normal and the throwing path.
fn with_lock(m: Mutex, body: fn () -> int) -> int {
    // acquire (module-private)
    try {
        let result = body();
        // release
        return result;
    } catch (e) {
        // release, then propagate the caller's error unchanged
        throw e;
    }
}
```

The precedent is direct and already in production:
`capsules/sfn/test/src/fixtures.sfn:55`'s `with_tmp_dir(body: fn (string) -> int) -> int ![io]`
uses precisely this acquire / `try` / cleanup-on-both-paths / re-throw shape to
guarantee a temp directory is removed even when the body throws. The mechanism
is proven; this proposal applies it to a lock.

**Why this closes every leak vector.** Three control-flow escapes can strand a
lock, and the closure boundary handles each by a different mechanism:

| Escape | Why it cannot leak the lock |
|---|---|
| Early `return` in the body | Returns from the *closure*, not the enclosing function. Control lands on `with_lock`'s release path. |
| `break` / `continue` targeting an enclosing loop | Not expressible across a lambda boundary at all. |
| `throw` from the body | Caught by the combinator's `catch`, released, then re-thrown unchanged. |

The first two are structural properties of the closure boundary and cost
nothing to guarantee. Only the third needs code, and it is four lines.

**What the body cannot do.** Because effects and control flow are contained,
the body also cannot `return` a value out of the enclosing function — it must
thread it back through `with_lock`'s return value. That is a real ergonomic
cost, paid deliberately. It is the same cost `with_tmp_dir` already imposes and
that `sfn/test` accepted.

**Rejected: explicit `lock()` / `unlock()`.** Every leak vector above becomes
live. A user who writes `lock(m); if bad { return -1; } unlock(m);` has written
a deadlock that no pass in the compiler will diagnose — no borrow checker, no
linear typing on the handle (§3.1: the handle is deliberately *not* affine), no
`defer`. The failure is not a crash but a hang, the least debuggable outcome
available, and it will most often manifest under contention in CI rather than
locally. Shipping the raw pair and documenting the discipline is exactly the
"parsed but not enforced" posture CLAUDE.md forbids marketing, transposed to a
library. Raw acquire/release remain as module-private helpers implementing the
combinators; they are not exported.

**Rejected: a `routine`-integrated form** (e.g. `routine holding m { ... }` or
registering a lock with the nursery for scope-exit release). This loses on
three counts. It is new syntax, so it violates "libraries over keywords" and
requires a compiler change plus a seed cut for what a library function does
today. Nursery scope is the wrong granularity — a nursery exists to bound the
lifetime of *spawned children*, and a lock held for the whole nursery scope
serializes precisely the workers it was introduced to coordinate. And it
conflates two distinct roles the nursery would then play for the same object:
reclamation owner (correct, per SFEP-0063 §3.6) and mutual-exclusion scope
(wrong). Keeping the nursery purely as the reclamation owner keeps the seam
general.

**Non-blocking probe.** Contention is an expected outcome, not a failure, so it
gets its own combinator rather than an error variant on the primary one:

```sfn
// Attempt to acquire without blocking. On success, runs `body` under the
// lock and returns Ok(<body result>). On contention, does not run `body`
// and returns Err(SyncError.Busy).
fn with_try_lock(m: Mutex, body: fn () -> int) -> Result<int, SyncError>
```

### 3.3 `Mutex<T>` or bare `Mutex`

**Decision: bare `Mutex` — a standalone lock the programmer pairs with the data
it guards by convention. `Mutex<T>` is deferred, and §3.9 records the
value-cell form as its intended successor.**

The data-owning `Mutex<T>` is the modern default and is genuinely safer, so
this deserves an honest accounting rather than a shrug at generics.

**Generics are not the blocker.** Generic structs and generic functions parse,
typecheck, and monomorphize — `compiler/tests/e2e/fixtures/mono_box_int.sfn`,
`mono_pair_struct.sfn`, and `compiler/tests/unit/monomorphize_generic_fn_test.sfn`
all exercise `struct Box<T>` / `.fn id<T>` end to end, and `Result<T, E>` is a
generic prelude enum (`runtime/prelude.sfn:162`) already consumed by shipped
capsule code (`capsules/sfn/time/src/mod.sfn:34`). `struct Mutex<T>` would
compile.

**The blocker is that the safety property is unenforceable.** The entire value
of `Mutex<T>` is that unsynchronized access is *unrepresentable* — the only
route to the `T` is a guard, and the guard cannot outlive the critical section.
Sailfin has no borrow checker (SFEP-0018 is unshipped), no reference type with
a lifetime, and no escape analysis. A `with_lock(m, fn (guard: T) -> int { ... })`
that hands the payload to the body cannot prevent the body from storing it in a
module global and reading it after release. `Mutex<T>` would therefore deliver
the *shape* of the guarantee with none of the enforcement — a stronger-looking
API that is exactly as safe as the bare lock, which is worse than the bare lock
because it invites reliance. That is the "parsed but not enforced" failure
transposed to a type.

**A secondary, weaker consideration worth recording:** no production `.sfn`
under `compiler/src/`, `runtime/`, or `capsules/` currently declares a generic
struct or generic function — the coverage is entirely in test fixtures, and
`capsules/sfn/test/src/expect.sfn:17-19` records a shipped capsule backing away
from generics because "generic monomorphization + `where` clauses" did not meet
its needs. That is a maturity signal, not a proof of impossibility, and it
argues for proving generics in this capsule's *simplest* surface first (§3.9)
rather than in its foundational type.

### 3.4 `Once` — the ungated phase

**Decision: `Once` ships first, before the seam, because it holds no OS
resource.**

The distinction that matters is not "does it allocate" but "does freeing it
require running a destructor." A `Mutex` owns a `pthread_mutex_t`: `free`-ing
it without `pthread_mutex_destroy` is unsound, and destroying it while another
thread holds it is unsound, so it genuinely needs the seam. A `Once` owns a
single `i64` word. Leaking it costs eight bytes for the process lifetime and
loses nothing.

```sfn
// Opaque handle to a process-lifetime once-cell. Deliberately never freed:
// it owns no OS resource, so the reclamation seam is not required.
struct Once {
    addr: i64;
}

fn once_create() -> Result<Once, SyncError>

// Run `init` exactly once across all callers sharing `o`. Concurrent
// callers that lose the race block until the winner's `init` returns,
// then return the winner's value. Returns `init`'s result.
fn once_do(o: Once, init: fn () -> int) -> int
```

**It is buildable today.** `atomic_cas(ptr, expected, new) -> boolean` is a
shipped builtin lowering to `cmpxchg` with `seq_cst` ordering
(`compiler/src/llvm/atomics.sfn:20,26-30`). The winner is the caller whose
`atomic_cas(state, 0, 1)` succeeds; it runs `init`, stores the result, then
`atomic_store(state, 2)`. Losers spin on `atomic_load(state)` until it reads 2.
No mutex, no condvar, no destructor.

Three consequences to record honestly:

- **Losers busy-wait.** For one-time initialization — the only thing `Once` is
  for — the wait is bounded by the initializer and typically microseconds. A
  futex/condvar-backed park is a later refinement and would move `Once` behind
  the seam, so it is explicitly not part of the first phase.
- **The cell is heap-allocated because Sailfin has no address-of operator.** A
  module-level `let mut` cannot yield a `*int`, and the runtime idiom is
  uniformly `malloc` + cast (`runtime/sfn/memory/rc.sfn:119,133`). So
  `once_create` allocates. This is a decided point, not an open question, and it
  does not change the phase ordering.
- **The intentional leak must be declared to leak-checking test legs.** An
  ASAN/LSAN run will see the eight bytes. The `Once` phase must either suppress
  it explicitly or route the allocation through an allocator the leg already
  excludes; whichever it does, the reason belongs in a comment naming this
  section, per `docs/conventions/sanitizer-tests.md`.

### 3.5 Atomics — export nothing

**Decision: the capsule exposes no atomics wrapper. It documents the builtins
and stops.**

Six atomic builtins already ship and are reachable from any Sailfin source:
`atomic_load`, `atomic_store`, `atomic_add`, `atomic_sub`, `atomic_cas`, and
`atomic_fence`. They lower directly to LLVM atomic instructions with `seq_cst`
ordering rather than to runtime helper calls, and their type contract
(`*int`/`int`/`boolean`) is already enforced with diagnostic `E0806`
(`compiler/src/llvm/atomics.sfn:15-23`). `atomic_add`/`atomic_sub` return the
**old** value; `atomic_cas` returns the success bit.

A capsule wrapper over these would be redundant at best, and at worst
introduces two concrete hazards:

1. **A same-named export would be silently unreachable.** `is_atomic_builtin`
   short-circuits *before* the runtime-helper registry is consulted
   (`compiler/src/llvm/atomics.sfn:49-62`, dispatched from
   `core_call_lowering.sfn`), so `fn atomic_add(...)` exported from
   `sfn/sync` would never be called even by a module that imported it
   explicitly. That is the SFEP-0063 §3.5 `Channel` shadowing hazard exactly,
   reproduced deliberately.
2. **A differently-named wrapper is a real function call** where the builtin is
   a single inlined instruction, and it would fork the vocabulary: two spellings
   for the same operation, one of which is slower.

**The naming rule this generalizes to, binding on every phase:** `sfn/sync`
must never export a name that is a compiler builtin or a compiler-special-cased
identifier. Concretely this forbids the six atomic names above and the
`Channel`/`channel` pair named in SFEP-0063 §3.5. Because this proposal exports
no `Channel`, the three decorative `import { Channel, channel } from "sync"`
sites that SFEP-0063 §3.5 flags do not change meaning under any phase here —
that hazard is dodged rather than managed, and no phase needs to sequence
around them.

What the capsule *may* add later, without collision, is a **composed** helper
that is not one-to-one with a builtin — a saturating counter, or a bounded
`spin_until(cell, value, max_iterations)` with the guard counter the code-style
rule requires on input-driven loops. None of that is in the shipped scope here.

### 3.6 Error and failure semantics

**Decision: three tiers, uniform across every type in the capsule.**

**Construction is fallible and returns `Result`.** `malloc` can return null;
`pthread_mutex_init` and `pthread_cond_init` can fail. This is where the real,
recoverable failure lives, and it gets the `Result<T, E>` + `?` treatment the
style rule mandates for new fallible code.

```sfn
enum SyncError {
    OutOfMemory,
    InitFailed(int),   // the errno-style code returned by the pthread call
    Busy,              // try-acquire found the lock held; not a failure
    NoScope,           // created outside any routine { } scope — see §3.8
    SelfDeadlock       // recursive acquire detected; see "Reentrancy" below
}

fn mutex_create() -> Result<Mutex, SyncError>
```

**Operations on a validly-constructed object do not return `Result`.**
`with_lock(m, body) -> int`, not `Result<int, SyncError>`. The argument is that
these operations are not fallible in the sense the style rule addresses: a
nonzero return from `pthread_mutex_lock` on a mutex this capsule itself
initialized, with attributes it chose, indicates memory corruption or
use-after-destroy — not a condition a caller can meaningfully handle. Wrapping
it in `Result` would be actively harmful, because the ergonomic pressure of a
`Result` on *every* critical section produces `let _ = with_lock(m, body);` at
call sites, and a **silently skipped critical section** is a data race that
looks like working code. Response instead: **fail closed** — print a diagnostic
naming the mutex address and the pthread return code to stderr, and abort. A
crash with a message beats a race without one. This is the same reasoning that
makes `lock().unwrap()` idiomatic in Rust, reached independently.

**Expected non-success outcomes are discriminated, not raised.**
`with_try_lock` returns `Err(SyncError.Busy)` for contention. `Busy` is
enumerated alongside genuine errors for a single error type across the capsule,
but the doc comment must state plainly that it is an outcome, not a fault.

**No poisoning.** When a body throws, `with_lock` releases and re-throws; it
does **not** mark the mutex as poisoned, and the next acquirer sees an ordinary
lock. Three reasons:

1. **The fault already propagates.** The re-throw reaches the enclosing scope,
   and under a `routine { }` nursery with cancel-on-fault (the
   concurrency-cancellation work in draft) the fault tears the scope down. A
   poison flag would be a second, weaker signal about an event the first
   mechanism already handles.
2. **It costs the ergonomics we just bought.** Poisoning is only meaningful if
   observed, which forces `Result` onto every `lock` — the exact tax rejected
   above.
3. **The prior art has soured on it.** Rust's poisoning is widely treated as a
   design mistake and routinely bypassed; `parking_lot` omits it.

What the capsule owes users instead is a plain statement of the contract:
**a throw across a critical section releases the lock but does not roll back
partial mutations.** If a later cancel-on-fault design demands poisoning, it is
strictly additive — a `with_lock_checked` returning `Result` alongside the
existing combinator, no breaking change.

**Reentrancy.** The default pthread mutex is non-recursive, so a nested
`with_lock` on the same handle self-deadlocks — a hang with no diagnostic,
which is the outcome this whole design exists to prevent. The recommendation is
therefore to initialize with the **error-checking** mutex type, so the nested
acquire returns `EDEADLK` and the capsule converts it into a thrown
`SyncError.SelfDeadlock` naming both acquisition sites. Two implementation
notes: this needs `pthread_mutexattr_settype`, where `channel.sfn` currently
passes a null attr; and the type constant is platform-dependent, so it belongs
next to the existing per-target layout constants in
`runtime/sfn/platform/pthread_layout.sfn` rather than inline. If measurement
shows the error-checking mutex is materially slower on the hot path, the
fallback is default attributes plus a documented non-reentrancy contract — but
the burden of proof sits with the faster-and-hangs option, not the
slower-and-diagnoses one.

### 3.7 The rest of the surface

`RwLock` and `Semaphore` follow the same combinator discipline, with no
exported acquire/release:

```sfn
fn rwlock_create() -> Result<RwLock, SyncError>
fn with_read_lock(l: RwLock, body: fn () -> int) -> int
fn with_write_lock(l: RwLock, body: fn () -> int) -> int
fn with_try_write_lock(l: RwLock, body: fn () -> int) -> Result<int, SyncError>

fn semaphore_create(permits: int) -> Result<Semaphore, SyncError>
fn with_permit(s: Semaphore, body: fn () -> int) -> int
fn with_permits(s: Semaphore, n: int, body: fn () -> int) -> int
```

**A semaphore's asymmetric use is deliberately not served.** The classic
counting-semaphore pattern — one worker signals, another waits, with no lexical
pairing — cannot be expressed by a scoped combinator. That pattern is
`Channel<T>`, which ships, and routing users there keeps the capsule
consistent with the CSP grain SFEP-0063 §3.3 asks it to respect. `with_permits`
covers the legitimate scoped use: bounding concurrency to N inside a nursery.

`WaitGroup` is **not** in this surface, per SFEP-0063 §3.2 — `routine { }`
already joins every child at scope exit. `select` over channels is out of
scope, per the same section, and blocked on separate fd-bridge plumbing.

**Timed variants** are a later phase and carry an effect (§4):

```sfn
fn with_lock_timeout(m: Mutex, timeout_ms: int, body: fn () -> int) -> Result<int, SyncError> ![clock]
```

### 3.8 Lifetime, and the one open question

Under the reclamation seam, creation registers the handle with the current
`routine { }` scope — exactly as `sfn_channel_create` hands each new handle to
`sfn_nursery_current()` as its final step, so a handle whose init failed is
never registered (SFEP-0063 §3.6). Two API-visible consequences follow.

**A sync object created in a `routine { }` scope dies at that scope's exit, and
must not be stored anywhere that outlives it.** With no borrow checker this is
a documented contract, not an enforced one. It is the strongest candidate for
the capsule's eventual first diagnostic (§4).

**Creating one outside any `routine { }` scope should fail closed**, returning
`Err(SyncError.NoScope)` rather than silently allocating an object nothing will
ever reclaim. The cost of this strictness is near zero in practice: a lock is
only useful alongside concurrency, and concurrency is nursery-scoped, so the
scope the check demands is one the program already has.

> **Open question — depends on the seam's shape, not decided here.** Whether
> "there is no current scope" is *observable* at creation time is a property of
> the generalized registry the sibling proposal defines. `sfn_channel_create`
> registers unconditionally against whatever `sfn_nursery_current()` returns; it
> is not established here that a top-level call yields a distinguishable
> sentinel, nor that the generalized seam intends to expose such a probe.
> **If the seam exposes a scope-presence probe, `mutex_create` returns
> `Err(SyncError.NoScope)` at top level. If it does not, the fallback is
> process-lifetime registration with a documented leak** — which is sound (a
> top-level mutex lives as long as the process anyway) but weaker, and would
> make `SyncError.NoScope` dead. This is the only place in this document where
> the API cannot be finalized without the seam; it must be resolved when
> SFEP-0064 is accepted, and it is a one-variant change either way.

### 3.9 Evolution: the value-cell form

The intended successor to the bare `Mutex` is not the guard-passing `Mutex<T>`
rejected in §3.3, but a **by-value cell with functional update**:

```sfn
// Future phase. The lock owns the value; the body receives a copy and
// returns the replacement, so no reference to the payload can escape.
fn with_cell<T>(c: Cell<T>, body: fn (T) -> T) -> void
```

This gets the real safety property `Mutex<T>` promises — unsynchronized access
is unrepresentable — *without* a borrow checker, because a copy-typed payload
handed by value has nothing to escape with. It costs a copy per critical
section, which is right for small guarded state and wrong for large aggregates.
It is listed here so the bare-`Mutex` decision reads as a first step rather than
a dead end, and because it is the natural place to prove generics in production
capsule code, being the smallest generic surface in the capsule.

### 3.10 Phasing

Each phase is one session's work, `Ready` to merged PR, ordered so the least
gated ships first. Only Phase 1 can start before the reclamation seam.

| Phase | Contents | Gate |
|---|---|---|
| **1 — Once + the atomics decision** | `Once`, `once_create`, `once_do`, `SyncError`. Capsule docs recording §3.5's "no atomics wrapper" rule and the builtin names it forbids exporting. Manifest stays `required = []`. | **Ungated.** Uses only shipped builtins (§5). Workable during the seam's seed-cut wait. |
| **2 — `Mutex`** | `Mutex`, `mutex_create`, `with_lock`, `with_try_lock`, error-checking mutex type + `SelfDeadlock` (§3.6), nursery registration + the §3.8 resolution, ASAN reclamation leg. | **Seam, in the pinned seed.** Carries `## Required in pinned seed: <seam predecessor>`. |
| **3 — `RwLock` + `Semaphore`** | `RwLock` and `Semaphore` with their combinators (§3.7). | Seam. Unblocked with Phase 2; no additional gate. |
| **4 — Timed variants** | `with_lock_timeout` and siblings, `![clock]`, manifest becomes `required = ["clock"]` (§4). | Seam. Independent of Phase 3; can precede or follow it. |
| **5 — Value cell** | `Cell<T>` / `with_cell<T>` (§3.9). | Seam, plus a generics feasibility probe in production capsule source (§3.3). |

Two notes on the ordering. **Phases 2 and 3 should not be split further** —
`RwLock` and `Semaphore` are the same handle shape, the same combinator
discipline, and the same test skeleton as `Mutex`, so splitting each primitive
into its own issue would manufacture review cycles without isolating any real
risk; Phase 2 is separate from Phase 3 only because Phase 2 additionally
carries the reentrancy, registration, and sanitizer work that the later
primitives then inherit for free. And **Phase 4 is deliberately last among the
gated phases**, because it is the only one that changes the capsule manifest,
and that change should land with the feature that justifies it rather than
ahead of it.

## 4. Effect & capability impact

**The core surface is effect-free, and blocking implies nothing.** `with_lock`,
`with_read_lock`, `with_permit`, `once_do`, and their try-variants declare no
effects. This follows SFEP-0049's transparency model rather than extending it:
`Channel`'s `send`/`receive` already block and carry no effect, and consistency
demands the same of a mutex. The substantive argument is that `![clock]` marks
*reading* the clock — an information channel and a nondeterminism source — not
the passage of time. A thread parked on a mutex learns nothing and observes
nothing; it is not exercising a capability.

**Body effects need no polymorphism.** A `fn () -> int` parameter carries no
effect row, and the effect checker attributes a closure's effects to the scope
that *defines* it — recorded at `capsules/sfn/bench/src/mod.sfn:18-23` and
`capsules/sfn/test/src/fixtures.sfn`. So a caller passing an `![io]` body to
`with_lock` already accounts for that `io` in its own signature, and `with_lock`
declares only what it uses directly, which is nothing. This is why the
combinator design imposes no effect-system work at all.

**Manifest.** `capsules/sfn/sync/capsule.toml` keeps `[capabilities] required = []`
— the value SFEP-0063 Phase 0 just set — through every ungated and
`Mutex`/`RwLock`/`Semaphore` phase. pthread mutual exclusion is none of `clock`,
`gpu`, `io`, `model`, `net`, or `rand`, and re-broadening the manifest would
undo the Reach-pillar correction Phase 0 just made.

**The one justified future change** is the timed-variant phase (§3.7).
`pthread_mutex_timedlock` takes an absolute deadline, which the capsule must
build by reading `CLOCK_REALTIME` — a genuine clock read. So `with_lock_timeout`
and its siblings carry `![clock]`, and *only when that phase lands* does the
manifest become `required = ["clock"]`. Recording the trigger here means the
change arrives as a designed consequence rather than an unexplained
re-broadening.

**Diagnostics: this proposal allocates none.** A library capsule surfaces
failures as `Result` and `throw`, not as compiler diagnostics, and no phase here
introduces a static rule for a compiler pass to enforce. The relevant existing
code is `E0806`, which already governs the atomic builtins' type contract and is
not extended.

A verified scan of allocated codes (`rg -o --no-filename '[EW][0-9]{4}' compiler
runtime docs site | sort -u`) shows `E08xx` occupied through `E0839`, `E09xx`
holding `E0901`–`E0907` and `E0910`–`E0915`, `E10xx` holding `E1001`–`E1019`,
and `E1100`–`E1114` belonging to SFEP-0062. **`E1200`–`E1299` is entirely
unallocated**, and that is the range a future `sfn/sync` diagnostic should draw
from. The likely first candidate is the §3.8 lifetime rule — a sync handle
created in a `routine { }` scope escaping into longer-lived storage — which
needs an escape analysis that does not exist and is therefore not proposed here.

## 5. Self-hosting impact

**No compiler pass changes. Not one.** Every phase is capsule source under
`capsules/sfn/sync/src/`, compiled by the existing frontend against existing
builtins and existing pthread externs. The lexer, parser, AST, typechecker,
effect checker, `emit_native.sfn`, and the LLVM lowering are all untouched. The
compiler's own build graph does not include `capsules/`, so `make compile` is
unaffected and the self-hosting invariant is preserved trivially.

**Seed dependency, per `.claude/rules/seed-dependency.md`.** The two situations
that rule governs resolve as follows.

*The ungated phase carries no seed dependency.* `Once` uses `atomic_cas`,
`atomic_load`, `atomic_store`, `malloc`, and function-typed parameters — all
long-shipped and present in any current seed. It bundles its capsule tests in
the same PR and needs no cut.

*The gated phases inherit a seed gate they do not own.* The reclamation seam
is a compiler/runtime capability consumed by **runtime source** — the nursery
registry in `runtime/sfn/concurrency/nursery.sfn` and `drop_fn` invocation in
`runtime/sfn/memory/rc.sfn`. That is the explicit carve-out in the
seed-dependency rule: the **pinned seed** compiles the working-tree runtime, so
bundling does not help and the capability must land alone as `seed-blocker`.
That gate belongs to the sibling proposal, not to this one. The consequence for
phasing is concrete and must be planned for: **`Mutex` and everything after it
cannot merge until a seed carrying the seam is pinned**, and the issue for the
first gated phase carries `## Required in pinned seed: <the seam predecessor>`.
Per the same rule, that queued cut batches onto the next scheduled cadence bump
rather than triggering a reactive one.

The practical scheduling consequence is the reason §3.4 matters: **the ungated
`Once`/atomics-decision phase can be worked during the seam's seed-cut wait**,
so the gate costs no wall-clock time.

**Formatting.** All capsule source is subject to `sfn fmt --check`. Note that
`fmt` renders function-type annotations as `fn (int) -> int` with a space
(visible throughout `runtime/sfn/array.sfn:550,594,640`); snippets in this
document follow that spelling, and implementers should not hand-tune it.

## 6. Alternatives considered

- **Explicit `lock()` / `unlock()`.** Rejected in §3.2: with no `defer`, every
  early `return` and every `throw` is a permanent deadlock that no pass
  diagnoses. Enforcing the pairing would need affine typing on the handle —
  which would also break the sharing that §3.1 depends on, since affine
  spellings are exactly what `_consume_spawn_captures` moves.
- **A `routine`-integrated lock scope.** Rejected in §3.2: new syntax for what a
  library function already does, the wrong lifetime granularity (nursery scope
  serializes the workers the lock coordinates), and it conflates the nursery's
  reclamation role with a mutual-exclusion role.
- **`Mutex<T>` with a guard passed to the body.** Rejected in §3.3: generics
  would compile, but with no borrow checker or escape analysis the guard can be
  stored past release, so the API would advertise a guarantee it cannot keep.
  The value-cell form in §3.9 is the honest version of the same idea.
- **A typed atomics wrapper.** Rejected in §3.5: the builtins are already
  user-reachable `seq_cst` LLVM atomics, a same-named export would be silently
  unreachable behind `is_atomic_builtin`'s short-circuit, and a
  differently-named one forks the vocabulary while being slower.
- **Poisoning after a fault.** Rejected in §3.6: the re-throw plus cancel-on-fault
  already propagates the fault, observing poison would force `Result` onto every
  acquisition, and the prior art has moved away from it. Additive later if
  needed.
- **`Result` on every lock operation.** Rejected in §3.6: it produces
  `let _ = with_lock(...)` at call sites, converting a crash into a silently
  skipped critical section. Fail-closed with a diagnostic is strictly more
  debuggable.
- **Waiting for the seam before shipping anything.** Rejected in §3.4: `Once`
  and the atomics decision hold no OS resource and need no teardown, so gating
  them on the seam would idle a full session's work behind a queued seed cut for
  no safety benefit.
- **Deferring the whole API design until the seam is accepted.** Rejected in §2:
  the surface depends on the seam's existence, not its shape, and the one place
  it genuinely does depend on the shape is isolated as an open question in §3.8
  rather than guessed.

## 7. Stage1 readiness mapping

This proposal adds no language feature, so the compiler-pass rows are not
applicable; the capsule source must nonetheless clear the same bar as any
`.sfn`.

- [ ] Parses — capsule source only; no new syntax.
- [ ] Type-checks / effect-checks — the core surface declares no effects (§4);
      the timed phase declares `![clock]`.
- [N/A] Emits valid `.sfn-asm` — no codegen change; capsule source flows through
      the existing path.
- [N/A] Lowers to LLVM IR — same.
- [ ] Regression coverage — §8.
- [x] Self-hosts — no compiler pass changes; `capsules/` is outside the
      compiler's build graph (§5).
- [ ] `sfn fmt --check` clean — applies to every capsule source and test file.
- [ ] Documented in `docs/status.md` + spec — each phase updates the
      `sfn/sync` row and
      `site/src/content/docs/docs/reference/standard-library.md`, replacing the
      SFEP-0063 Phase 0 "no capsule wrapper planned" wording with the surface
      that phase actually shipped.

## 8. Test plan

All tests are Sailfin `*_test.sfn` files using `sfn/test`, per
`.claude/rules/no-bash-e2e.md` — no `.sh` surface exists.

**Capsule tests, `capsules/sfn/sync/tests/`:**

- `once_test.sfn` — single-threaded `once_do` runs the initializer once and
  returns its value; a second `once_do` on the same handle does not re-run it.
  Contended: N workers spawned in one `routine { }` all call `once_do` on a
  shared handle; assert a counter incremented by the initializer reads exactly 1
  and every worker observed the same returned value.
- `mutex_counter_test.sfn` — N workers each perform M `with_lock` increments of a
  shared heap cell inside one `routine { }`; assert the total is exactly N*M.
  This is the primary mutual-exclusion proof and must run with enough iterations
  to fail reliably if the lock is absent.
- `mutex_throw_unlocks_test.sfn` — the leak-vector regression, and the most
  important test in the suite. A `with_lock` body throws; the caller catches;
  a subsequent `with_try_lock` on the same handle returns `Ok`, proving the
  release ran on the throwing path. Repeat for `with_read_lock`,
  `with_write_lock`, and `with_permit`.
- `try_lock_busy_test.sfn` — `with_try_lock` from a second worker while the lock
  is held returns `Err(SyncError.Busy)` and does **not** run its body (assert via
  a side-effect counter).
- `mutex_create_error_test.sfn` — `mutex_create` returns `Ok` in a nursery scope;
  the top-level behaviour asserted here is whichever §3.8's open question
  resolves to, and this test is the record of that resolution.
- `rwlock_test.sfn` — concurrent readers all make progress under
  `with_read_lock`; a writer excludes them.
- `semaphore_test.sfn` — `with_permits(s, k, body)` never admits more than k
  concurrent bodies (assert via a peak-concurrency counter).
- `self_deadlock_test.sfn` — a nested `with_lock` on the same handle throws
  `SyncError.SelfDeadlock` rather than hanging. Must carry a timeout so a
  regression fails the suite instead of wedging it.

**E2E, `compiler/tests/e2e/`:** one executable test compiling and running a
program that shares a `Mutex` across `spawn` closures, confirming end to end that
no ownership diagnostic fires on the shared handle (the §3.1 property) and that
the program's guarded total is exact.

**Reclamation coverage** lands with the first gated phase: an ASAN leg
(`docs/conventions/sanitizer-tests.md`, with `SAILFIN_MEM_LIMIT=unlimited` and a
skip-not-fail guard) asserting a `Mutex` created in a `routine { }` is destroyed
and freed at scope exit, and that `Once`'s intentional process-lifetime cell is
the only outstanding allocation.

**Verification commands.**

```
sfn fmt --check capsules/sfn/sync/src/*.sfn capsules/sfn/sync/tests/*_test.sfn
sfn check capsules/sfn/sync/src/mod.sfn
build/bin/sfn test capsules/sfn/sync/tests/
build/bin/sfn test compiler/tests/e2e/ -k mutex_shared_spawn
make compile
make check
```

`make compile` is not strictly required by any phase — no compiler source
changes — but is run once per phase to confirm that claim rather than assume it.

## 9. References

- SFEP-0063 (`docs/proposals/0063-sync-capsule.md`) — scope, per-candidate
  verdicts (§3.2), the reclamation finding (§3.1), the nursery-seam state at
  acceptance (§3.6), and the import-shadowing defect (§3.5). This proposal is
  the API half of the follow-up it defers to.
- SFEP-0049 (`docs/proposals/0049-concurrency-effect-transparency.md`) — the
  effect-transparency model §4 applies.
- SFEP-0055 (`docs/proposals/0055-typed-task-handles.md`) — adjacent
  concurrency-typing predecessor.
- SFEP-0018 (`docs/proposals/0018-borrow-checking-1.0.md`) — the unshipped
  borrow checking whose absence decides §3.3.
- The in-flight reclamation-seam proposal (generic `(handle, destructor)`
  nursery registry and `rc.sfn` `drop_fn` invocation) — the gate on every phase
  after `Once`, and the owner of §3.8's open question.
- `compiler/src/llvm/atomics.sfn:1-30,49-62` — the six atomic builtins, their
  `seq_cst` lowering, the old-value return contract, `E0806`, and the
  `is_atomic_builtin` short-circuit that decides §3.5.
- `compiler/src/ownership_checker.sfn:373` and
  `compiler/src/typecheck_types/expr_type_rules.sfn:232-239` — the `is_owned`
  gate and the four owned/affine spellings; the reason §3.1 needs no carrier.
- `runtime/sfn/concurrency/channel.sfn` — the in-tree existence proof: a
  heap-allocated `pthread_mutex_t` + two `pthread_cond_t` object shared across
  worker threads, written in Sailfin. The handle shape in §3.1 follows it.
- `runtime/sfn/platform/pthread_layout.sfn` — the single source of truth for
  pthread storage sizes, and where §3.6's mutex-type constant belongs.
- `capsules/sfn/test/src/fixtures.sfn:55` (`with_tmp_dir`) — the production
  precedent for the acquire / `try` / cleanup-on-both-paths / re-throw
  combinator in §3.2.
- `capsules/sfn/bench/src/mod.sfn:18-23` — the recorded rule that a `fn () -> int`
  parameter carries no effect row and closure effects are attributed to the
  defining scope; the basis for §4.
- `capsules/sfn/test/src/expect.sfn:17-19` — a shipped capsule backing away from
  generics; the maturity signal in §3.3.
- `compiler/tests/e2e/fixtures/mono_box_int.sfn`,
  `compiler/tests/e2e/fixtures/mono_pair_struct.sfn`,
  `compiler/tests/unit/monomorphize_generic_fn_test.sfn` — generic struct and
  generic function monomorphization coverage.
- `runtime/prelude.sfn:162` (`Result<T, E>`), `capsules/sfn/time/src/mod.sfn:34`
  — generic `Result` in shipped capsule code.
- `.claude/rules/seed-dependency.md` — the runtime-source carve-out that makes
  the seam a `seed-blocker` and gates §5's later phases.
- `docs/conventions/sanitizer-tests.md` — the skip-not-fail ASAN procedure §8
  and §3.4 depend on.
