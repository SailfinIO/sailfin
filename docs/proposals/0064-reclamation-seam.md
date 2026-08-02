---
sfep: 0064
title: Generic resource-reclamation seam
status: Draft
type: runtime
created: 2026-08-02
updated: 2026-08-02
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0064 — Generic resource-reclamation seam

## 1. Summary

The nursery already owns and reclaims the channels created in its scope, but the
seam is channel-specific: the registry stores a bare handle and
`sfn_nursery_exit` hardcodes `sfn_channel_close` + `sfn_channel_destroy`. This
proposal generalizes it into a **resource-reclamation seam** — a registry of
`(handle, destructor)` pairs, drained after the join-all barrier by calling
through the stored destructor. Doing so requires one compiler capability the
language does not have: an **indirect call through a thin, C-ABI function
pointer**. Sailfin can *produce* a function address today (`<fn> as * u8`,
shipped as the `pthread_create` start-routine primitive) but cannot *consume*
one — the only indirect-call path in the lowering is closure dispatch, which
assumes a fat `{i8*, i8*}` pair and an env-first ABI. This proposal designs the
thin function-pointer type `*fn (A, …) -> R`, the seam that consumes it, and the
phasing, and closes the identical gap in `runtime/sfn/memory/rc.sfn` (`drop_fn`
is stored but never dereferenced). It does **not** design a synchronization
library; that is SFEP-0063's downstream concern.

## 2. Motivation

### 2.1 The shipped pattern, and the two places it is welded to channels

Scope-bound reclamation works. `sfn_channel_create` hands each new handle to
`sfn_nursery_current()` as its final step — so a handle whose pthread init
failed is never registered — and `sfn_nursery_exit`
(`runtime/sfn/concurrency/nursery.sfn:287`) destroys every registered channel
*strictly after* the join-all barrier, then frees the list. That ordering turns
`sfn_channel_destroy`'s documented precondition ("no thread still holds the
handle") into a structural one. SFEP-0063 §3.6 records this as the mechanism a
sync capsule would build on.

It is welded to channels in exactly two places:

1. `sfn_nursery_register_channel(n: i64, ch: i64)`
   (`runtime/sfn/concurrency/nursery.sfn:240`) records a **bare handle**. No
   destructor travels with it.
2. The teardown loop in `sfn_nursery_exit`
   (`runtime/sfn/concurrency/nursery.sfn:308-320`) **hardcodes**
   `sfn_channel_close` then `sfn_channel_destroy`.

A `Mutex`, a `WaitGroup`, or a third-party capsule's handle cannot ride this. The
scaling alternatives are a parallel `register_mutex` list per resource type
(which does not survive a third type) or generalizing the registry.

### 2.2 The mirror-image gap in `rc.sfn`

`runtime/sfn/memory/rc.sfn` reserves the slot and never uses it. The 16-byte
header is refcount `i64` at offset 0, `drop_fn: *u8` at offset 8;
`sfn_rc_sfn_alloc` stores the pointer (`rc.sfn:103`), and
`sfn_rc_sfn_release` — at `prev == 1` — calls libc `free` **directly**
(`rc.sfn:142`) without ever dereferencing it. The file header says invocation is
"deferred to M2.4/M2.6." It has been deferred because the capability does not
exist, not because the design is unsettled.

`rc.sfn` has **zero production consumers** — only `compiler/tests/e2e/runtime_memory_rc_test.sfn`
drives it, passing a null `drop_fn` so the gap is explicitly modeled. It is a
proof-of-life module; its shape is free to change.

### 2.3 Both gaps are one capability

Both need: *call a `fn(*u8) -> void` whose address was stored in memory at
runtime.* That is a single, concrete, small capability with two known consumers
today and at least two more already documented as blocked
(`runtime/sfn/platform/pthread.sfn`'s typed `start` parameter,
`runtime/sfn/concurrency/scheduler.sfn`'s `Task` entry field, which its header
calls "unspellable today"). Designing it once, generally, is cheaper than
keyholing it — and the seed-cut economics in §7 make "once" close to mandatory.

## 3. Design

### 3.1 The pivotal finding: the capability is **not** expressible today, and the reason is a type overload

**Producing** a function address ships. `<fn> as * u8` materializes the address
of a concrete, non-generic, C-ABI function; misuse is diagnosed by `E0808`
(function used as a value in an unsupported position) and `E0809` (address of a
generic function), both in
`compiler/src/typecheck_types/symbol_table_and_raw_exprs.sfn:214-283`.
`runtime/sfn/concurrency/scheduler.sfn:187-193` already uses it to hand
`sfn_scheduler_worker`'s address to `pthread_create`.

**Consuming** one does not. The only indirect-call path in native lowering is
`emit_closure_dispatch`
(`compiler/src/llvm/expression_lowering/native/core_call_emission/closure_dispatch.sfn`),
reached via `try_resolve_closure_callee`
(`.../core_call_resolution/closure_callee.sfn:223`). It assumes the callee
operand is a **fat** `{i8*, i8*}` aggregate and emits, unconditionally:

```llvm
%fp  = extractvalue { i8*, i8* } %closure, 0
%env = extractvalue { i8*, i8* } %closure, 1
%f   = bitcast i8* %fp to void (i8*, i8*)*
       call void %f(i8* %env, i8* %arg)      ; env is a HIDDEN FIRST ARGUMENT
```

Two things follow. First, a `*u8` holding a raw function address is not an
aggregate — `extractvalue` on it is invalid IR. Second, even if it were, the
emitted call passes `env` as argument 0, which a plain
`fn sfn_channel_destroy(ch: *u8)` does not accept. There is no env-less
indirect-call form anywhere in the lowering.

**The overload is the real finding.** The spelling `fn (A) -> R` already means
two incompatible things depending on position:

| Position | Meaning today | LLVM shape | ABI |
|---|---|---|---|
| `extern fn` parameter | thin C function pointer, via `is_c_abi_function_pointer` (`compiler/src/typecheck_types/extern_abi.sfn:307`) | `i8*` | plain C |
| Sailfin `let` / parameter annotation | closure pair (`#688`), via `_looks_like_fn_pointer_annotation` | `{i8*, i8*}` | env-first |

So the "fix" that `pthread.sfn`'s header asks for — loosening
`is_c_abi_function_pointer` to accept the `fn (` spelling that `sfn fmt`
produces — is the **wrong fix**. It would not unblock anything (the extern side
already lowers to `i8*`; the problem was never the extern side) and it would
cement a spelling whose meaning silently flips between two ABIs. Writing
`let d: fn (*u8) -> void = some_ptr; d(x);` today is precisely the trap: the
annotation matches the closure predicate and lowering emits `extractvalue` on an
`i8*`.

The capability therefore needs a **distinct thin spelling**, not a relaxed
accept-list.

### 3.2 The thin function-pointer type: `*fn (A, …) -> R`

Introduce a pointer-to-function type spelled with the existing pointer sigil:

```sfn
// Thin: a raw C-ABI function pointer. LLVM `R (A, ...)*`. No environment.
let reclaim: *fn (*u8) -> void = sfn_channel_reclaim as *fn (*u8) -> void;
reclaim(handle);

// Fat, unchanged: a Sailfin closure. LLVM `{i8*, i8*}`. Env-first ABI.
let add: fn (int) -> int = (n) => n + 1;
```

Rationale, against the "boring syntax wins" test: C spells this
`void (*)(void *)`; Rust spells it `fn(*mut u8)` and reserves the `Fn*` traits
for closures. Sailfin already spent the bare `fn (…) -> R` spelling on closures,
so the thin form needs a mark, and `*` — "pointer to" — is the mark the language
already uses. No new keyword; `*fn (…)` composes with the existing `*T` / `**T`
grammar.

Scope bound for the first landing: **every parameter type and the return type
must be a C-ABI scalar or pointer** — the same accept-list
`is_c_abi_function_pointer` already enforces. No generics, no varargs, no
by-value aggregates, no closures as parameters, no effect rows (see §4).

Both spellings (`*fn(` and `*fn (`) are accepted from day one on the new path.
`_parse_fn_pointer_annotation` (`closure_callee.sfn:43-57`) already demonstrates
the two-spelling pattern; the formatter's canonical output is `*fn (`.

Lowering emits the env-less form, structurally distinct from closure dispatch —
**no `extractvalue`, no hidden argument**:

```llvm
%f = bitcast i8* %fp to void (i8*)*
     call void %f(i8* %arg)
```

`extern fn` parameters migrate to the thin spelling
(`extern fn pthread_create(thread: *usize, attr: *PthreadAttr, start: *fn (*u8) -> *u8, arg: *u8) -> i32`),
retiring the `* u8`-and-cast degradation. The bare `fn (…)` spelling in extern
position is **deprecated, not fixed** — `is_c_abi_function_pointer`'s literal
`fn(` rule stays exactly as it is, so no existing extern changes meaning, and
new code has one unambiguous way to say "thin."

### 3.3 The seam: a stride-16 pair registry

Replace the bare-handle list with a single array of 16-byte records — handle at
`+0`, destructor address at `+8`:

```
channels_addr / chan_count / chan_capacity
  ->  resources_addr / res_count / res_capacity     (stride 16, not 8)

  slot i:  [ i*16 + 0 ]  handle    (i64)
           [ i*16 + 8 ]  reclaim   (i64, a `*fn (*u8) -> void` address)
```

```sfn
// Registration: one entry point for every resource type.
fn sfn_nursery_register_resource(n: i64, handle: i64, reclaim: *u8) -> i64 { … }

// Channels register themselves at creation, as today, with their reclaimer.
// (inside sfn_channel_create, as the final step)
sfn_nursery_register_resource(
    sfn_nursery_current(),
    ch as i64,
    sfn_channel_reclaim as *u8
);
```

Teardown, still strictly after the join loop:

```sfn
let mut c: i64 = 0;
loop {
    if c >= nursery.res_count { break; }
    let base: i64 = nursery.resources_addr;
    let handle_addr: i64 = base + c * 16;
    let dtor_addr: i64 = handle_addr + 8;
    let handle_slot: *i64 = handle_addr as *i64;
    let dtor_slot: *i64 = dtor_addr as *i64;
    let handle: i64 = atomic_load(handle_slot);
    let dtor: i64 = atomic_load(dtor_slot);
    // Clear BEFORE invoking: a re-entrant exit sees a dead slot.
    atomic_store(handle_slot, 0);
    if handle != 0 {
        if dtor != 0 {
            let reclaim: *fn (*u8) -> void = dtor as *fn (*u8) -> void;
            reclaim(handle as *u8);
        }
    }
    c = c + 1;
}
```

Note the three-statement offset split is preserved — the existing loop uses it
deliberately to stay clear of the cast-of-pointer-arithmetic miscompile
(`nursery.sfn:263-268`), and stride 16 does not change that requirement.

**Why a struct-of-pairs and not two parallel arrays.** One allocation, one
`realloc`, one `free`, and — decisively — the handle and its destructor cannot
desynchronize, because there is no second count to keep in step. The invariant
becomes structural rather than maintained. A third word later (a debug kind tag,
a quiesce hook) grows the stride in one place. The only cost is that the
existing array is stride-8, and that is a contained edit in the three sites that
touch it: growth, append, and drain.

### 3.4 One destructor, not two phases — and `sfn_channel_reclaim`

Channel teardown is `close` then `destroy` today. The generic seam takes **one**
destructor, and quiescing is the resource's own business:

```sfn
// runtime/sfn/concurrency/channel.sfn
// Total, idempotent, single-argument reclaimer. The seam registers THIS.
fn sfn_channel_reclaim(ch: *u8) -> void {
    if ch as i64 == 0 { return; }
    sfn_channel_close(ch);
    sfn_channel_destroy(ch);
}
```

Reasons a two-phase (quiesce, then destroy) protocol is not worth its width:

- **The precondition already makes phase one near-vacuous.** The drain runs
  strictly after the join-all barrier, so no thread is blocked on the handle.
  `close` at that point is defensive, not load-bearing.
- **Two phases double the registry width and the contract surface** to encode
  ordering the resource module already knows. `sfn_channel_reclaim` puts the
  ordering where it belongs — next to `sfn_channel_close` — rather than in the
  generic scope owner.
- **It is not a one-way door.** If a resource ever genuinely needs a global
  quiesce-all pass before any destroy (a plausible future for cancellation), the
  stride grows to 24 and the drain becomes two loops over the same array. The
  pair registry is a prefix of that design, not a rival to it.

**Reclaimer contract** (written, not enforceable — state it in the module
header):

1. Signature is exactly `fn(*u8) -> void`. Total: it may not fail, and it has no
   way to report failure.
2. Called **at most once** per registered handle, on a non-null handle, after
   every child of the scope has joined.
3. Must tolerate being called with a handle it already reclaimed (belt and
   braces — the seam guarantees once, the reclaimer should not rely on it).
4. Must not register new resources with any nursery.
5. Must not be effectful in the `![…]` sense (§4).

### 3.5 Double-registration and double-destroy

**Double-registration is prevented by construction, not by scanning.** The
invariant is: *a handle is registered by exactly one site — its creation
function — as that function's final step.* `sfn_channel_create` already obeys
it. Do not add a linear duplicate scan at registration: it is O(n²) over the
scope's resource count and it defends an invariant no correct call site can
violate. Record the invariant in the module header instead.

**Double-destroy is prevented by clearing the slot before the call** (§3.3). A
destructor that somehow re-entered `sfn_nursery_exit` would find a zeroed handle
and skip it. This is cheap and, unlike duplicate scanning, it defends against a
case the seam cannot rule out by construction.

### 3.6 Failure semantics

- **Registration OOM: fail closed, unchanged.** On a failed `realloc`, set
  `nursery.faulted = 1`, unlock, return 0, and do **not** record the resource.
  The resource leaks rather than being destroyed while potentially live —
  exactly the discipline `sfn_nursery_register_channel:237-239` documents today,
  now covering the pair write rather than a single slot.
- **Null destructor: fail closed the same way.** A registration with
  `reclaim == 0` is a caller bug. Do not record it and return 1 — "the resource
  is valid and usable, simply unowned," mirroring the existing `n == 0`
  module-global precedent (`nursery.sfn:230-235`). A leaked resource is strictly
  better than a resource the drain will skip in a way nobody notices.
- **A destructor that faults mid-loop: teardown continues.** The drain loop has
  no early exit and accumulates no error from destructors. This follows from the
  reclaimer being total (§3.4 contract 1): a `void` return has no channel to
  report failure through, and there is no sensible recovery at scope exit — the
  alternatives are leak-the-rest or abort, and leaking the rest is the worse
  one. **`nursery.faulted` continues to reflect registration failures only**;
  this is a deliberate narrowing, not an oversight. A destructor that *traps*
  (segfault, `panic`) terminates the process, as it would anywhere else in the
  runtime; the seam does not and cannot catch it.

### 3.7 `rc.sfn`: the second consumer, and why direct dispatch does not replace the seam

The `rc.sfn` change is small and mechanical once the capability exists:

```sfn
fn sfn_rc_sfn_release(payload: *u8) -> void {
    let slots = payload as *i64;
    let refcount_ptr = slots - 2;
    let prev = atomic_sub(refcount_ptr, 1);
    if prev == 1 {
        let header = refcount_ptr as *RcHeader;
        let drop_fn = header.drop_fn;
        if drop_fn as i64 != 0 {
            let drop: *fn (*u8) -> void = drop_fn as *fn (*u8) -> void;
            drop(payload);          // payload, not header — user sees the payload
        }
        unsafe { free(refcount_ptr as *u8); }
    }
}
```

Note the ordering: the destructor runs on the **payload** pointer, before the
header block is freed. The `prev == 1` guard is the same uniqueness proof that
already licenses the raw `free` (`rc.sfn:134-143`); it licenses the destructor
call for the same reason.

**Could a compiler-known type dispatch a *direct* call instead, sidestepping
indirect calls entirely?** Considered and rejected as the general mechanism:

- For `rc.sfn`, the whole point of the `drop_fn` slot is that the payload is
  type-erased behind a `*u8` at the release site. Recovering a static type would
  mean monomorphizing `sfn_rc_sfn_release` per payload type
  (`sfn_rc_release_SfnString`, …), which costs a symbol per type, defeats the
  shared runtime function, and still cannot serve a heterogeneous container
  holding `Rc`s of different types.
- For the nursery seam it is strictly worse: the resource set is *open*. A
  third-party capsule's handle type is not known to `nursery.sfn`, which is the
  entire reason SFEP-0063 needs the seam rather than a hardcoded list.

It remains a legitimate **optimization**: where the compiler knows the concrete
type at a release site, it may devirtualize to a direct
`call @sfn_drop_SfnString`. That is a peephole on top of the seam, not a
substitute for it.

**Landing order.** The two consumers are genuinely independent — different
modules, no shared code beyond the compiler feature — and each is small. They
land as two issues that can run in parallel once the capability is pinned
(§7). Neither gates the other, and because both consume the *same* already-
pinned capability, splitting them costs no extra seed cut.

## 4. Effect & capability impact

**Destructors carry no effect row, and this is a decision, not an omission.**
Effect checking is static; a function address stored in memory erases the
signature's effect row, so the seam cannot know what a stored destructor is
permitted to do. The v0 contract is therefore that a reclaimer is
`fn(*u8) -> void` with an empty effect row, and the type system enforces this at
the *address-taking* site: `<fn> as *fn (*u8) -> void` should be rejected when
the named function declares effects, for the same reason `E0809` rejects taking
a generic function's address — there is no single, honest thing the resulting
pointer could mean.

The consequence worth naming: **a resource whose reclamation needs `![io]`
cannot ride this seam in v0.** File-descriptor reclamation is the obvious next
want. The mitigation already exists in the runtime's layering — primitives such
as `close(2)` are `extern fn` declarations with no effect annotation, and
effects attach to *adapters* that wrap them (the discipline `rc.sfn:52-56`
states). So a low-level fd reclaimer is expressible; an adapter-level one is
not. Lifting that restriction means either an effect row on the thin
function-pointer type (`*fn (*u8) -> void ![io]`, checked at the address-taking
site and propagated to the call site) or an effect-polymorphic seam. Both are
post-1.0; neither is designed here.

Capability manifests are unaffected: no new effect is introduced, no manifest
entry changes, and the seam introduces no reachable-effect edge the effect
checker cannot already see.

## 5. Self-hosting impact

**Phase A (compiler capability) is purely additive.** No file under
`compiler/src/` uses `*fn (…)`, and none should in the landing PR. The pinned
seed's parser never sees the new type form, so it compiles the new compiler
exactly as before; the new compiler then understands the form. `make compile`
holds throughout. Passes touched:

| Stage | Change |
|---|---|
| Lexer | none — `*`, `fn`, `(`, `->` are all existing tokens |
| Parser (`compiler/src/parser/`, type grammar) | parse `*fn (P, …) -> R` as a type in let/parameter/field/extern position; preserve the verbatim annotation text as the existing `fn (…)` path does. The `-> R` / enclosing-signature ambiguity is already solved by the paren-depth handling `#688` shipped for fat annotations |
| AST | no new node — the annotation is carried as type text, matching the existing function-pointer handling |
| Typecheck (`compiler/src/typecheck_types/`) | `extern_abi.sfn`: accept `*fn (…)` in extern signatures with the existing C-ABI element accept-list. `symbol_table_and_raw_exprs.sfn`: extend the `E0808`/`E0809` address-of rules so `<fn> as *fn (…) -> R` is a supported target and shape-checks against the named function's signature; reject an effectful function (§4) |
| Effects | none |
| `emit_native.sfn` / `native_ir.sfn` | carry the annotation through to the local/parameter binding so lowering can see it; no new `.sfn-asm` instruction |
| LLVM lowering | `core_call_resolution/closure_callee.sfn`: recognise a `*fn (…)`-annotated local/parameter as a **thin** callee, distinct from the fat path. New emitter beside `core_call_emission/closure_dispatch.sfn`: bitcast + `call`, no `extractvalue`, no env argument. `core_type_mapping.sfn`: map `*fn (…)` to `i8*` at boundaries and to `R (P, …)*` at the call site |
| `sfn fmt` | canonical spelling `*fn (P, …) -> R`; round-trip idempotence in all four positions |

**Phases B and C touch runtime source only** (`runtime/sfn/concurrency/`,
`runtime/sfn/memory/rc.sfn`) and no compiler pass. They are compiled by the
**pinned seed** — see §7.

## 6. Alternatives considered

**A tagged-kind enum with a dispatch switch (the no-new-capability fallback).**
Store `(handle, kind)` and switch on `kind` in `sfn_nursery_exit`, calling
`sfn_channel_reclaim` / `sfn_mutex_reclaim` / … directly. It needs zero compiler
work and would ship today. Rejected as the design, kept as the contingency:

- It **inverts the dependency**. `nursery.sfn` — the generic scope owner — would
  have to import and link every resource module. Every new resource type edits
  the nursery.
- It **cannot close the `rc.sfn` gap at all**. `drop_fn` is genuinely dynamic;
  there is no finite kind set.
- It **makes the sync capsule un-shippable as a capsule** (SFEP-0063): a
  third-party resource type could never register, because it could never add a
  variant to a runtime-internal enum.
- Crucially, it **saves almost nothing on the runtime side**. The registry
  generalization (stride-16 pairs) is the *same* work either way; only the drain
  loop's dispatch differs. So the fallback is available cheaply if Phase A slips
  — land the pair registry storing a kind tag, then swap the tag for a pointer
  later — but taking it *by choice* buys a few weeks and pays for them twice.

**Two parallel arrays (`channels_addr` + `destructors_addr`).** Smaller diff
(the existing stride-8 growth code survives). Rejected: two counts that must
stay in lockstep is an invariant maintained by discipline, where stride-16 makes
it structural. The seam is exactly the place where a desynchronized index is a
use-after-free.

**A keyhole intrinsic — `sailfin_intrinsic_call_ptr_v1(f: *u8, a0: *u8)`.**
Zero new type syntax; mirrors the existing
`sailfin_intrinsic_pointer_read_i64` idiom the runtime already uses. Tempting,
and genuinely smaller. Rejected on the seed economics: `.claude/rules/seed-dependency.md`'s
runtime carve-out says that because the gate is unavoidable, cross it **once**
and land the complete capability family in that single PR. A keyhole covering
only `fn(*u8) -> void` guarantees a second crossing for the *already documented*
`fn(*u8) -> *u8` (scheduler worker entry) and whatever comes third, each costing
its own seed cut. The general type is more work in one PR and less work in
total, and it also unblocks the two spelling complaints in `pthread.sfn` and
`scheduler.sfn` that the keyhole leaves standing.

**Loosening `is_c_abi_function_pointer` to accept the `fn (` spelling.** This is
what `runtime/sfn/platform/pthread.sfn:19-32` asks for, and it is the wrong fix
(§3.1): it unblocks nothing, because the extern side already lowers to `i8*`,
and it cements a spelling whose ABI silently flips between extern position
(thin) and Sailfin position (fat, env-first). Rejected in favour of a distinct
spelling and leaving the existing rule untouched.

**Reusing the closure pair — register a `{i8*, i8*}` lambda as the
destructor.** Fails mechanically: reconstituting an aggregate from two loaded
`i64` slots needs `insertvalue`, which Sailfin source cannot express, and the
loaded value's LLVM type must be `{i8*, i8*}` for `extractvalue` to be valid.
It also drags closure-env lifetime into scope teardown, which is precisely the
problem the seam exists to solve.

**Monomorphizing `sfn_rc_sfn_release` per payload type.** Covered in §3.7:
retained as a future devirtualization, rejected as the mechanism.

## 7. Phasing and seed dependency

This is **runtime source calling a compiler capability the pinned seed lacks** —
the structural carve-out in `.claude/rules/seed-dependency.md`. Bundling does not
help: `make compile` builds the new compiler from the old seed, but the *seed*
is what compiles working-tree runtime source
(`_compile_runtime_sfn_sources`, `compiler/src/build/runtime_objs.sfn`). So the
capability **must land alone, labelled `seed-blocker`**, and the consumers carry
`## Required in pinned seed: #<Phase A>`. Precedent, recorded verbatim in
`runtime/sfn/string.sfn`: "seed 0.7.0-alpha.41 carries the `load_byte` builtin."

Because the gate is unavoidable, the rule's instruction is to **cross it once**
with the complete capability family, not per consumer. That is the decisive
argument for the general `*fn (…)` type over a keyhole intrinsic (§6).

**One seed cut is forced.** It queues onto the next scheduled cadence bump
(SFEP-0026 WS-C) — this is not release-critical and does not justify a reactive
cut.

| Phase | Scope | Size | Gate |
|---|---|---|---|
| **A** | The `*fn (…) -> R` capability: parser type grammar, extern accept-list, `E0808`/`E0809` extension for the new cast target, effect rejection, native-IR annotation carry-through, thin indirect-call lowering, `sfn fmt`. Compiler-side tests only — **no runtime consumer in this PR** | M–L (deliberately the one large issue; bounded by the C-ABI-scalars-and-pointers restriction in §3.2) | `seed-blocker`; lands alone |
| *(seed cut)* | Cadence bump pins a seed carrying Phase A | — | queued, not reactive |
| **B** | Generic nursery seam: stride-16 registry, `sfn_nursery_register_resource`, `sfn_channel_reclaim`, drain loop calls through the pointer, `sfn_channel_create` registers the pair | M | `## Required in pinned seed: #<A>` |
| **C** | `rc.sfn` `drop_fn` invocation; retire the "deferred to M2.4/M2.6" header note; extend the e2e test off its null-`drop_fn` shape | S | `## Required in pinned seed: #<A>`; parallel with B |
| **D** | Runtime spelling migration: `pthread.sfn` / `scheduler.sfn` externs and the `Task` entry field move from `* u8`-and-cast to `*fn (…)`; delete the two header workaround notes | S | `## Required in pinned seed: #<A>`; parallel with B and C |

B, C, and D are three genuinely independent consumers of one pinned capability,
in three different modules, with no shared code. They are not a manufactured
split: each is a separate session, none gates another, and none forces an
additional seed cut. Bundling them would produce one large PR touching
concurrency, memory, and platform for no shipping benefit.

Everything downstream — a second resource type actually riding the seam, i.e.
the sync capsule — is SFEP-0063's, and out of scope here.

**Contingency if Phase A slips.** Ship Phase B with a kind tag in the second
slot and a direct-dispatch switch (§6), then swap tag for pointer when the
capability lands. The registry work is identical; only the drain loop changes.
Take this only under schedule pressure — it is a dead end for `rc.sfn` and for
third-party resources.

## 8. Diagnostics

**Prefer zero new codes.** The producer side is already covered by `E0808` /
`E0809`; extending them to recognise `*fn (…)` as a supported cast target is a
message change, not a new code. Arity and parameter-type mismatch at a thin
indirect call should route through the existing call-checking diagnostics rather
than gain a bespoke code.

**One code is reserved for the case that has no existing home: `E0839`** —
function-pointer *kind* mismatch, i.e. a closure type `fn (A) -> R` and a thin
C-ABI pointer `*fn (A) -> R` used interconvertibly. This is the §3.1 trap
(`let d: fn (*u8) -> void = some_raw_ptr;`), which today produces invalid IR or
an ABI-mismatched call rather than an error; leaving it undiagnosed while adding
a second, near-identical spelling would be negligent. `E0839` is verified free:
`E0801`–`E0838` are in use, with holes at `E0806`, `E0817`, `E0824`, `E0825`
that this proposal does **not** claim (holes are presumed retired codes).
`E09xx` is ownership/affine and untouched.

Allocate `E0839` only if the check genuinely cannot reuse an existing
type-mismatch code with a specific message; the reservation is a ceiling, not a
commitment.

## 9. Stage1 readiness mapping

- [ ] Parses — `*fn (P, …) -> R` in let, parameter, struct-field, and extern
      position
- [ ] Type-checks / effect-checks — C-ABI element accept-list; `<fn> as
      *fn (…)` shape check; effectful-function rejection (§4); closure/thin
      non-interconvertibility
- [ ] Emits valid `.sfn-asm` — annotation carried to the binding; no new
      instruction
- [ ] Lowers to LLVM IR — `bitcast i8*` → `R (P, …)*` + `call`, with **no**
      `extractvalue` and **no** env argument
- [ ] Regression coverage — §10
- [ ] Self-hosts — `make compile` after Phase A; `make clean-build` first, since
      Phase A is structurally a new type form
- [ ] `sfn fmt --check` clean — canonical `*fn (` spelling, idempotent
- [ ] Documented in `docs/status.md` + the spec's type chapter

## 10. Test plan

E2E tests are Sailfin `*_test.sfn` files driving subprocesses via
`process.run_capture` — never bash (`.claude/rules/no-bash-e2e.md`).

**Phase A — compiler.**

- `compiler/tests/unit/` — type-parse round-trip for `*fn (A) -> R` in let,
  parameter, struct-field, and extern position; both `*fn(` and `*fn (`
  spellings accepted; `sfn fmt` idempotence in all four.
- `compiler/tests/unit/` — typecheck accepts `<concrete C-ABI fn> as
  *fn (A) -> R`; rejects a generic function (`E0809`); rejects an effectful
  function; rejects closure↔thin assignment in both directions.
- `compiler/tests/integration/` — **IR shape assertion**, the load-bearing one:
  the emitted call for a thin pointer contains `bitcast i8* … to void (i8*)*`
  followed by `call void %…(i8* %…)` and contains **no** `extractvalue`. This
  is what distinguishes the new path from closure dispatch, and a regression
  here is a silent ABI break, not a compile error.
- `compiler/tests/e2e/` — a program that stores a function's address in a struct
  field, loads it, calls through it, and observes the side effect; plus the
  round-trip through `sfn fmt --write` to prove the canonical spelling still
  compiles.

**Phase B — nursery seam.** Extend
`compiler/tests/e2e/channel_nursery_reclaim_test.sfn`:

- A `routine` creating N channels exits cleanly and each reclaimer runs
  **exactly once** (module-global counter incremented by a test reclaimer).
- Ordering: a reclaimer that observes a still-running child fails the test —
  the drain must be strictly after the join barrier.
- A registration with a null reclaimer is not recorded and does not fault the
  nursery (returns 1, resource unowned).
- Re-entrancy: the cleared-slot guard means a second drain over the same array
  is a no-op.
- `compiler/tests/e2e/channel_nursery_escape_test.sfn` and
  `compiler/tests/{e2e,unit}/routine_nursery_test.sfn` must stay green — the
  module-global (`n == 0`) path is unchanged.

**Phase C — `rc.sfn`.** Extend `compiler/tests/e2e/runtime_memory_rc_test.sfn`
off its current null-`drop_fn` shape: a real `drop_fn` bumping a counter runs
**exactly once**, at the release that takes the refcount to zero and not on
earlier releases; the null-`drop_fn` path still frees without calling anything;
the destructor observes a live payload (it runs before `free`).

**Phase D — spelling migration.** `pthread.sfn` and `scheduler.sfn` typecheck
and `sfn fmt --check` clean under the new spelling; the scheduler's existing
linked single-thread and multi-thread roundtrips stay green, proving the
`pthread_create` start routine still reaches libc as the same `i8*`.

**Every phase:** `make compile` before targeted tests; `make check` before the
Phase A seed-blocker merges, since it changes the type grammar.

## 11. Risks

**The overload trap is the biggest risk.** `fn (A) -> R` and `*fn (A) -> R`
differ by one character and by an entire ABI. A confusion that typechecks
produces a call with a spurious or missing first argument — silent memory
corruption, not a crash at the mismatch. Mitigations, in order of importance:
the `E0839` kind-mismatch check (§8), the IR-shape integration test that asserts
`extractvalue` is absent (§10), and never using the thin form in
`compiler/src/` so a mistake cannot reach the self-host path unnoticed.

**Phase A is the largest single issue in the plan** and the seed gate means it
cannot be de-risked by splitting. Mitigation: the §3.2 restriction to C-ABI
scalars and pointers, and shipping it with compiler-side tests only so no
runtime behaviour rides on the first landing.

**Stride-16 pointer arithmetic in the drain loop.** The existing code uses a
three-statement offset split specifically to avoid a cast-of-pointer-arithmetic
miscompile (`nursery.sfn:263-268`). The new loop computes two offsets per slot
and must keep that discipline; a regression here is a use-after-free at scope
exit, which is the worst possible place for one.

**Effect erasure is a real capability hole**, not just a v0 simplification
(§4). Naming it now avoids someone discovering at sync-capsule time that a
file-handle reclaimer cannot be registered.

## 12. References

- SFEP-0063 (`docs/proposals/0063-sync-capsule.md`) §3.6 — the section that
  scopes this proposal; the downstream synchronization library
- SFEP-0055 — related concurrency design context
- SFEP-0026 (`docs/proposals/0026-delivery-process.md`) WS-B/WS-C — seed
  dependency and cadence batching
- SFEP-0025 (`docs/proposals/0025-native-runtime-architecture.md`)
  `#322-reference-counting`, `#37-scheduler-and-concurrency` — the `RcHeader`
  layout and the scheduler's typed-entry want
- `.claude/rules/seed-dependency.md` — the runtime-source carve-out governing §7
- `runtime/sfn/concurrency/nursery.sfn:225-333` — the seam being generalized
- `runtime/sfn/memory/rc.sfn` — the `drop_fn` gap
- `runtime/sfn/platform/pthread.sfn:19-32`,
  `runtime/sfn/concurrency/scheduler.sfn:29-45` — the two recorded
  "unspellable today" workarounds this retires
- `compiler/src/typecheck_types/extern_abi.sfn:302-317` —
  `is_c_abi_function_pointer`
- `compiler/src/typecheck_types/symbol_table_and_raw_exprs.sfn:214-283` —
  `E0808` / `E0809`, the shipped address-of primitive
- `compiler/src/llvm/expression_lowering/native/core_call_resolution/closure_callee.sfn`,
  `.../core_call_emission/closure_dispatch.sfn` — the fat indirect-call path the
  thin path must not be confused with
