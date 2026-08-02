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

> **Correction (2026-08-02).** An earlier draft of this proposal asserted that
> a thin, env-less function pointer cannot be *consumed* today, that
> `*fn (A) -> R` was a new spelling this proposal introduces, and that this
> forced a seed cut. **All three claims are false**, and an adversarial review
> falsified them before this draft was accepted. The capability shipped as
> #1089: `try_lower_plain_fn_ptr_call`
> (`compiler/src/llvm/expression_lowering/native/core_call_lowering.sfn:65-92`,
> dispatched at line 268, before closure resolution) already recognizes a
> local/parameter annotated `*fn (A) -> R` (both `*fn(` and `*fn (` spellings)
> and emits a bitcast-plus-`call`, with no `extractvalue` and no environment
> argument. It is documented at `docs/status.md:526-528`, pinned by
> `compiler/tests/e2e/plain_fn_ptr_call_test.sfn`, and already has production
> callers — `runtime/sfn/concurrency/scheduler.sfn:607`,
> `runtime/sfn/concurrency/future.sfn`,
> `runtime/sfn/concurrency/serve.sfn:709,1042,1095,1149,1217`,
> `capsules/sfn/http/src/server.sfn:117,149,160`, and
> `capsules/sfn/http/src/router.sfn:97,247`. Decisively: `runtime/capsule.toml:70`
> lists `sfn/concurrency/scheduler.sfn` in `sfn-sources`, so the **pinned seed**
> already compiles a file that calls through `*fn` on every build — a seed that
> could not parse it could not build the runtime. SFEP-0030
> (`docs/proposals/0030-first-class-function-values.md`, status **Accepted**)
> already documents all of this at lines 103, 211-213, 628, and 798, and already
> considered and rejected an env-less `{ptr, null}` carrier at lines 198-213.
> This draft is rewritten below to reflect that; the history is kept rather
> than hidden because the earlier reasoning — and how it was falsified — is
> useful to a future reader.

> **Addendum (2026-08-02) — a structural review found a real capability
> hole, not a false premise this time.** `classify_fn_cast`
> (`compiler/src/typecheck_types/symbol_table_and_raw_exprs.sfn:271-284`)
> accepts `<fn> as * u8` and `<fn> as *fn (…)` for any non-generic function —
> it checks only `entry.is_generic`, never the function's effect row — and
> §3.3's registration path erases the resulting pointer to `*u8` before it
> ever reaches the nursery registry. Nothing today stops an `![io]` function
> from being cast to `*u8`/`*fn (*u8) -> void` and registered as a reclaimer,
> so it can run from effect-free nursery teardown with neither the caller nor
> the derived capability manifest declaring `io`. That is a hole in the Reach
> pillar the seam would ship with, not a stylistic gap: §4 already states the
> *intent* ("`<fn> as *fn (…)` should be rejected when the named function
> declares effects") but that intent is not implemented, not tested, and not
> yet elevated to a blocking condition on this proposal. §4 below now makes
> it one.

## 1. Summary

The nursery already owns and reclaims the channels created in its scope, but
the seam is channel-specific: the registry stores a bare handle and
`sfn_nursery_exit` hardcodes `sfn_channel_close` + `sfn_channel_destroy`. This
proposal generalizes it into a **resource-reclamation seam** — a registry of
`(handle, destructor)` pairs, drained after the join-all barrier by calling
through the stored destructor — and closes the identical gap in
`runtime/sfn/memory/rc.sfn` (`drop_fn` is stored but never dereferenced).

Both consumers need exactly one capability: *call a `fn(*u8) -> void` whose
address was stored in memory at runtime.* That capability already ships
(#1089, see the correction above), so **this proposal requires no compiler
change, no new type, and no seed gate** to do the runtime-source work in §3.3
through §3.7. It does **not** design a synchronization library; that is
SFEP-0063's downstream concern.

Two genuinely small compiler-side gaps remain — `*fn` in struct-field position
and `*fn` in extern-parameter position (§3.2) — but they are independent of
the seam, do not block it, and (per §5) do not force a seed cut either, since
they can land compiler-only with no runtime consumer in the same change.

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
"deferred to M2.4/M2.6." It has been deferred because nobody has wired it yet,
not because the capability is missing — see the correction above.

`rc.sfn` has **zero production consumers** — only `compiler/tests/e2e/runtime_memory_rc_test.sfn`
drives it, passing a null `drop_fn` so the gap is explicitly modeled. It is a
proof-of-life module; its shape is free to change.

### 2.3 Both gaps are already unblocked by one shipped capability

Both need: *call a `fn(*u8) -> void` whose address was stored in memory at
runtime.* That capability already ships as #1089 (see the correction above),
with two production consumer families already exercising it
(`runtime/sfn/concurrency/scheduler.sfn`, `.../serve.sfn`,
`capsules/sfn/http/src/{server,router}.sfn`) and, per §3.2, two positions
(struct-field, extern-parameter) where the *annotation* — not the call — is
still unspellable.

**Correcting a mischaracterization an earlier draft made.** The workarounds
recorded at `runtime/sfn/platform/pthread.sfn:19-32` and
`runtime/sfn/concurrency/scheduler.sfn:39-45` are about **annotation
position**, not about the indirect call itself. `scheduler.sfn` performs that
exact indirect call successfully 560 lines later, at line 607. The header
comments describe a real but narrow gap — a typed `extern fn` parameter or a
typed struct field cannot yet be spelled `*fn (…)`, so the call site casts
through `* u8` — not an inability to call through a stored pointer, which
already works.

## 3. Design

### 3.1 The capability already ships: consuming a thin function pointer

**Producing** a function address ships. `<fn> as * u8` materializes the address
of a concrete, non-generic, C-ABI function; misuse is diagnosed by `E0808`
(function used as a value in an unsupported position) and `E0809` (address of a
generic function), both in
`compiler/src/typecheck_types/symbol_table_and_raw_exprs.sfn:214-283`.
`runtime/sfn/concurrency/scheduler.sfn:187-193` already uses it to hand
`sfn_scheduler_worker`'s address to `pthread_create`.

**Consuming** one also ships, as `*fn (A, …) -> R` (#1089). Native lowering has
two indirect-call paths that are structurally disjoint by a leading `*`:

- The **fat** closure-dispatch path
  (`compiler/src/llvm/expression_lowering/native/core_call_emission/closure_dispatch.sfn`,
  reached via `try_resolve_closure_callee` in
  `.../core_call_resolution/closure_callee.sfn:223`) treats the callee as a
  `{i8*, i8*}` aggregate and emits `extractvalue` for both the function
  pointer and an env-first hidden argument.
- The **thin** path — `try_lower_plain_fn_ptr_call`
  (`compiler/src/llvm/expression_lowering/native/core_call_lowering.sfn:65-92`,
  dispatched at line 268, *before* the closure/method resolution the fat path
  lives behind) — recognizes a local or parameter annotated `*fn (A) -> R` (or
  `*fn(A) -> R`; `_strip_leading_star_fn` accepts both), loads the raw code
  pointer, bitcasts it to the typed function-pointer LLVM type, and emits a
  direct `call <ret> <fnptr>(<args>)` with **no** hidden environment argument.
  Its own comment states the invariant precisely: "The leading `*` makes the
  two spellings structurally disjoint, so the env-prepending closure dispatch
  never fires for a plain pointer."

Regression coverage: `compiler/tests/e2e/plain_fn_ptr_call_test.sfn` and its
fixture `compiler/tests/e2e/fixtures/plain_fn_ptr_call.sfn`. Documentation:
`docs/status.md:526-528`. Production callers:
`runtime/sfn/concurrency/scheduler.sfn:607`,
`runtime/sfn/concurrency/future.sfn`,
`runtime/sfn/concurrency/serve.sfn:709,1042,1095,1149,1217`,
`capsules/sfn/http/src/server.sfn:117,149,160`, and
`capsules/sfn/http/src/router.sfn:97,247`.

**Nothing in §3.3 through §3.7 below needs new grammar, a new type, or a new
lowering path.** Every code sample in this proposal that reads
`let d: *fn (*u8) -> void = addr as *fn (*u8) -> void; d(handle);` already
compiles today.

### 3.2 Genuinely remaining compiler-side gaps: struct-field and extern-parameter position

Two positions still cannot spell `*fn (…)`, and both are small, independent of
the seam below, and — per §5 — do not force a seed cut:

- **Struct-field position.** `Route.handler`
  (`capsules/sfn/http/src/router.sfn:70-77`) and `Task.fn_ptr`
  (`runtime/sfn/concurrency/scheduler.sfn:91-99`) are both still declared `i64`,
  with the call site casting to `*fn (…)` at the use site rather than at the
  field declaration.
- **Extern-parameter position.** `is_c_abi_function_pointer`
  (`compiler/src/typecheck_types/extern_abi.sfn:307`) still requires a literal
  `fn(` prefix and knows nothing of the `*fn (…)` spelling, so a typed
  `extern fn` parameter is still spelled `* u8` and cast at the call site
  (`runtime/sfn/platform/pthread.sfn:19-32`).

**No accept-list restriction is proposed for either gap.** An earlier draft of
this proposal wanted to bound the (nonexistent) new type to "every parameter
and return type must be a C-ABI scalar or pointer, no by-value aggregates."
Shipped code already violates that bound: `*fn (OwnedBuf) -> OwnedBuf`
(`serve.sfn:709`), `*fn (Request) -> Response` (`server.sfn:149`),
`*fn (Request, Params) -> Response` (`router.sfn:97`), and `*fn () -> f64` /
`*fn (*u8) -> bool` (`future.sfn:187,276`) all compile and run today. Imposing
such a bound would reject source that already compiles. Recording this
explicitly so nobody re-proposes it.

These two gaps are small, mechanical parser/typecheck extensions to a
spelling that already works everywhere else. They are out of the critical path
for the nursery seam and `rc.sfn` (§3.3–§3.7), which need neither.

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
            // The contract (§3.4) requires a total reclaimer, but
            // `fn(*u8) -> void` does not prevent `throw` — a `try`/`catch`
            // per call is what actually keeps that promise, not the
            // signature alone. Without it, the first throwing reclaimer
            // unwinds out of the drain loop entirely, skipping every later
            // resource and the nursery's own cleanup below.
            try {
                reclaim(handle as *u8);
            } catch (e) {
                nursery.faulted = 1;
            }
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
   every child of the scope has joined. This is not something the reclaimer can
   independently guard against: `sfn_channel_reclaim` (§3.4) calls
   `sfn_channel_destroy`, which frees the handle, so invoking it a second time
   on that same non-null handle dereferences freed memory. The registry's
   clear-before-call discipline (§3.3, §3.5) is therefore the *only* thing
   standing between a correct reclaimer and a use-after-free, not a belt
   alongside the reclaimer's own braces.
3. Must not register new resources with any nursery.
4. Must not be effectful in the `![…]` sense (§4).

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
- **A destructor that throws mid-loop: teardown continues.** The reclaimer
  contract (§3.4 contract 1) requires totality, but `fn(*u8) -> void` does not
  prevent `throw`, so the drain loop wraps each reclaimer call in its own
  `try`/`catch` (§3.3) rather than trusting the signature: a throwing
  reclaimer's fault is recorded on `nursery.faulted` and the loop proceeds to
  the next slot, instead of unwinding out of the drain entirely and skipping
  every later resource and the nursery's own cleanup. **`nursery.faulted` is
  therefore set on both a registration failure and a throwing reclaimer** —
  a widening from the registration-only signal in earlier drafts, made
  necessary once the per-reclaimer `try`/`catch` exists to observe the fault.
  A destructor that *traps* (segfault, `panic`) still terminates the process,
  as it would anywhere else in the runtime; the seam does not and cannot catch
  that.

### 3.7 `rc.sfn`: the second consumer, and why direct dispatch does not replace the seam

The `rc.sfn` change is small and mechanical, using the already-shipped call
capability:

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
modules, no shared code beyond the shared, already-shipped call capability —
and each is small. They land as two issues that can run in parallel; neither
gates the other, and since both consume a capability that is already in the
pinned seed, nothing about landing them in parallel or in either order forces
a seed cut.

## 4. Effect & capability impact

**Destructors carry no effect row, and this is a decision, not an omission.**
Effect checking is static; a function address stored in memory erases the
signature's effect row, so the seam cannot know what a stored destructor is
permitted to do. The v0 contract is therefore that a reclaimer is
`fn(*u8) -> void` with an empty effect row, and the type system enforces this at
the *address-taking* site: `<fn> as *fn (*u8) -> void` should be rejected when
the named function declares effects, for the same reason `E0809` rejects taking
a generic function's address — there is no single, honest thing the resulting
pointer could mean. This is an augmentation of the existing, shipped
address-of diagnostics, not a new type or new code (§8).

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

**No seed cut is needed, and this proposal makes no compiler-pass change at
all in its critical path.** The capability every code sample in §3.3–§3.7
depends on — an env-less indirect call through a stored `*fn (A) -> R` — is
already in the pinned seed: `runtime/capsule.toml:70` lists
`sfn/concurrency/scheduler.sfn` in `sfn-sources`, and that file already calls
through `*fn` at line 607 on every build. A seed that could not parse or lower
`*fn` could not build the runtime today. `.claude/rules/seed-dependency.md`'s
runtime-source carve-out — the rule that would otherwise force this work to
land as a standalone `seed-blocker` — simply does not bite, because there is no
new capability for the seed to lack.

Concretely, the nursery-seam generalization (§3.3–§3.6) and the `rc.sfn`
`drop_fn` invocation (§3.7) are ordinary runtime-source changes under
`runtime/sfn/concurrency/` and `runtime/sfn/memory/`, compiled by the pinned
seed exactly as today's channel and `rc.sfn` code already is. `make compile`
holds throughout, with no `make clean-build` required — neither change alters
the compiler's own build graph or introduces a new type.

**The two remaining compiler-side gaps (§3.2) are independent and also do not
force a seed cut**, provided they land the way this proposal scopes them: as
compiler-only parser/typecheck extensions (struct-field and extern-parameter
positions for the already-existing `*fn (…)` spelling), with **no runtime
consumer in the same change**. `make compile` then builds the new compiler
from the unchanged pinned seed exactly as before; migrating
`pthread.sfn` / `scheduler.sfn` / `router.sfn` to the new spelling is optional
follow-up cleanup, out of scope here, and whoever does it later applies
ordinary bundling per `.claude/rules/seed-dependency.md` (the migration is
runtime source calling a compiler capability — at that point the capability
would already be in a released seed via ordinary cadence, so bundling works
normally).

## 6. Alternatives considered

**A tagged-kind enum with a dispatch switch.** Store `(handle, kind)` and
switch on `kind` in `sfn_nursery_exit`, calling `sfn_channel_reclaim` /
`sfn_mutex_reclaim` / … directly. Rejected as the design, kept as a note:

- It **inverts the dependency**. `nursery.sfn` — the generic scope owner —
  would have to import and link every resource module. Every new resource type
  edits the nursery.
- It **cannot close the `rc.sfn` gap at all**. `drop_fn` is genuinely dynamic;
  there is no finite kind set.
- It **makes the sync capsule un-shippable as a capsule** (SFEP-0063): a
  third-party resource type could never register, because it could never add a
  variant to a runtime-internal enum.
- It **saves almost nothing on the runtime side**. The registry generalization
  (stride-16 pairs) is the *same* work either way; only the drain loop's
  dispatch differs. Since the pointer-call capability already ships, there is
  no schedule pressure that would make this fallback worth taking.

**Two parallel arrays (`channels_addr` + `destructors_addr`).** Smaller diff
(the existing stride-8 growth code survives). Rejected: two counts that must
stay in lockstep is an invariant maintained by discipline, where stride-16 makes
it structural. The seam is exactly the place where a desynchronized index is a
use-after-free.

**Loosening `is_c_abi_function_pointer` to accept the `fn (` spelling.** This is
what `runtime/sfn/platform/pthread.sfn:19-32` asks for, and it is the wrong fix:
it would not close the extern-parameter gap in §3.2, because the request is to
accept the closure-style `fn (` spelling in extern position, which lowers to
the *fat* `{i8*, i8*}` shape everywhere else in the language — cementing a
spelling whose ABI silently flips between extern position (thin, if accepted)
and Sailfin position (fat, env-first). The correct fix, tracked in §3.2, is to
teach `is_c_abi_function_pointer` about the already-existing `*fn (…)`
spelling instead, leaving the bare `fn (` rule untouched.

**Reusing the closure pair — register a `{i8*, i8*}` lambda as the destructor,
instead of the already-shipped thin `*fn` pointer.** Fails mechanically:
reconstituting an aggregate from two loaded `i64` slots needs `insertvalue`,
which Sailfin source cannot express, and the loaded value's LLVM type must be
`{i8*, i8*}` for `extractvalue` to be valid. It also drags closure-env lifetime
into scope teardown, which is precisely the problem the seam exists to solve.

**Monomorphizing `sfn_rc_sfn_release` per payload type.** Covered in §3.7:
retained as a future devirtualization, rejected as the mechanism.

## 7. Phasing and seed dependency

**No seed cut.** §5 gives the evidence: `runtime/capsule.toml:70` plus
`scheduler.sfn:607` prove the pinned seed already parses and lowers `*fn`, so
`.claude/rules/seed-dependency.md`'s runtime carve-out does not apply — there is
no capability for the seed to lack. This retracts the earlier draft's
conclusion that one seed cut was forced; that conclusion was wrong.

With no seed dependency, the two runtime-source changes and the two
compiler-side gaps are simply independent pieces of work, each sized for one
session:

| Item | Scope | Size | Gate |
|---|---|---|---|
| Nursery seam | Stride-16 registry, `sfn_nursery_register_resource`, `sfn_channel_reclaim`, drain loop, `sfn_channel_create` registers the pair (§3.3–§3.6) | M | none — ordinary `make compile` |
| `rc.sfn` | `drop_fn` invocation; retire the "deferred to M2.4/M2.6" header note; extend the e2e test off its null-`drop_fn` shape (§3.7) | S | none — ordinary `make compile`; parallel with the nursery seam |
| Struct-field `*fn` | `Route.handler`, `Task.fn_ptr` move from `i64`-and-cast to typed `*fn (…)` fields (§3.2) | S | none, provided it lands compiler-only with no runtime consumer in the same PR |
| Extern-parameter `*fn` | `is_c_abi_function_pointer` recognizes `*fn (…)`; `pthread.sfn`'s `start` parameter migrates (§3.2) | S | same as above |

Nothing here queues a cadence seed bump. The struct-field and extern-parameter
items are the only ones with a `seed-dependency.md` consideration at all, and
only if a later change bundles them with a runtime consumer in the same PR —
which this proposal explicitly scopes them not to do.

## 8. Diagnostics

**Prefer zero new codes**, and correcting an earlier draft's E-code survey,
which mixed live and reserved codes into a mistaken "holes are presumed
retired" heuristic:

- `E0806` is **live** — the atomic-builtin type contract
  (`compiler/src/llvm/atomics.sfn:15`), pinned by
  `compiler/tests/e2e/atomic_add_sub_compile_test.sfn:139,158`.
- `E0817` is **live** — the enum same-name field conflict, pinned by
  `compiler/tests/e2e/enum_same_name_field_conflict_test.sfn:140`.
- `E0824`/`E0825` are **reserved by SFEP-0058**
  (`docs/proposals/0058-sized-integer-types.md:211,225`), not retired.

None of these are gaps this proposal may claim. The "holes are presumed
retired codes" reasoning is dropped outright — it would license reusing a live
or already-reserved code, which is exactly the mistake a hole-based heuristic
invites. `E0838` is the highest allocated code; `E0839` is genuinely free.

**Reassessing whether `E0839` is still wanted.** An earlier draft reserved it
for a closure-vs-thin kind-mismatch diagnostic
(`let d: fn (*u8) -> void = some_raw_ptr;`). That confusion risk is far lower
than originally argued: the two spellings are structurally disjoint by the
leading `*` (§3.1), and the two shapes at that boundary are ordinary,
already-diagnosed cases rather than a new gap — assigning a raw `*fn (…)`
pointer where a `fn (…) -> R` closure type is expected (or vice versa) is a
plain type mismatch between an `i8*`-shaped value and a `{i8*, i8*}`-shaped
one, caught by existing type-checking with no bespoke wording needed.
**Dropping the reservation** is therefore the right call: this proposal
allocates no diagnostic code, and `E0839` remains free for whatever next
proposal needs it.

Arity and parameter-type mismatch at a thin indirect call — should the §3.2
extensions ever surface one in a new position — should route through the
existing call-checking diagnostics rather than gain a bespoke code, consistent
with how the already-shipped let/parameter position behaves today.

## 9. Stage1 readiness mapping

The underlying `*fn (A) -> R` capability this proposal builds on is already
Stage1-shipped (`docs/status.md:526-528`); the checklist below is for the work
this proposal actually adds — the nursery-seam generalization and `rc.sfn`
wiring, plus the two small independent compiler gaps in §3.2.

- [ ] Parses — struct-field and extern-parameter `*fn (…)` (§3.2); the
      let/parameter form already parses today and needs no further work
- [ ] Type-checks / effect-checks — effectful-function rejection at the
      address-taking site (§4); C-ABI accept-list extension to
      `is_c_abi_function_pointer` for the extern gap (§3.2)
- [ ] Emits valid `.sfn-asm` / Lowers to LLVM IR — no new instruction or
      lowering path for the nursery seam or `rc.sfn`, which reuse the shipped
      thin-call path as-is; the §3.2 struct-field/extern extensions carry the
      existing annotation through to a new binding position only
- [ ] Regression coverage — §10
- [ ] Self-hosts — `make compile` after each item; no `make clean-build`
      required (§5)
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` — update the nursery/rc.sfn section; the
      underlying call capability is already documented

## 10. Test plan

E2E tests are Sailfin `*_test.sfn` files driving subprocesses via
`process.run_capture` — never bash (`.claude/rules/no-bash-e2e.md`).

**Nursery seam.** Extend
`compiler/tests/e2e/channel_nursery_reclaim_test.sfn`:

- A `routine` creating N channels exits cleanly and each reclaimer runs
  **exactly once** (module-global counter incremented by a test reclaimer).
- Ordering: a reclaimer that observes a still-running child fails the test —
  the drain must be strictly after the join barrier.
- A registration with a null reclaimer is not recorded and does not fault the
  nursery (returns 1, resource unowned).
- Re-entrancy: the cleared-slot guard means a second drain over the same array
  is a no-op.
- A reclaimer that throws sets `nursery.faulted` and the drain continues:
  every later resource is still reclaimed (module-global counters prove each
  ran), rather than the throw unwinding out of the drain loop.
- `compiler/tests/e2e/channel_nursery_escape_test.sfn` and
  `compiler/tests/{e2e,unit}/routine_nursery_test.sfn` must stay green — the
  module-global (`n == 0`) path is unchanged.

**`rc.sfn`.** Extend `compiler/tests/e2e/runtime_memory_rc_test.sfn` off its
current null-`drop_fn` shape: a real `drop_fn` bumping a counter runs
**exactly once**, at the release that takes the refcount to zero and not on
earlier releases; the null-`drop_fn` path still frees without calling anything;
the destructor observes a live payload (it runs before `free`).

**§3.2 struct-field / extern-parameter (if pursued in this pass).**
`compiler/tests/unit/` — type-parse round-trip for `*fn (A) -> R` in
struct-field and extern position; `compiler/tests/e2e/` — `pthread.sfn` and
`scheduler.sfn`/`router.sfn` typecheck and `sfn fmt --check` clean under the
new spelling, and existing linked single-thread/multi-thread roundtrips stay
green. No IR-shape assertion is needed here — that coverage already exists for
the let/parameter position in `compiler/tests/e2e/plain_fn_ptr_call_test.sfn`
and the lowering path is unchanged; these positions only add a new place the
same annotation can appear.

**Every item:** `make compile` before targeted tests. No item in this table
needs `make check` as a merge gate beyond the project's ordinary bar — there is
no seed-blocker to guard.

## 11. Risks

**Effect erasure is a real capability hole**, not just a v0 simplification
(§4). Naming it now avoids someone discovering at sync-capsule time that a
file-handle reclaimer cannot be registered.

**Stride-16 pointer arithmetic in the drain loop.** The existing code uses a
three-statement offset split specifically to avoid a cast-of-pointer-arithmetic
miscompile (`nursery.sfn:263-268`). The new loop computes two offsets per slot
and must keep that discipline; a regression here is a use-after-free at scope
exit, which is the worst possible place for one.

**Confusing the fat and thin spellings remains a real, if now smaller, risk.**
`fn (A) -> R` and `*fn (A) -> R` differ by one character and by an entire ABI.
Because that confusion resolves to an ordinary type mismatch rather than a
silent miscompile (§8), the residual risk is a rejected build, not memory
corruption — but it is still worth flagging to anyone extending the §3.2
positions: verify the new binding positions route through the same
`_strip_leading_star_fn` / `_parse_fn_pointer_annotation` machinery rather than
duplicating an ad hoc check.

## 12. References

- SFEP-0030 (`docs/proposals/0030-first-class-function-values.md`), status
  **Accepted** — the proposal that actually designed and shipped `*fn (A) -> R`
  consumption (#1089), including the rejected env-less `{ptr, null}` carrier
  alternative at lines 198-213. Reviewing against this document before drafting
  would have caught the false premise corrected above; any future proposal
  touching function-pointer types should start here.
- SFEP-0063 (`docs/proposals/0063-sync-capsule.md`) §3.6 — the section that
  scopes this proposal; the downstream synchronization library
- SFEP-0055 — related concurrency design context
- SFEP-0026 (`docs/proposals/0026-delivery-process.md`) WS-B/WS-C — seed
  dependency and cadence batching (referenced for context; does not apply to
  this proposal's critical path per §5/§7)
- SFEP-0025 (`docs/proposals/0025-native-runtime-architecture.md`)
  `#322-reference-counting`, `#37-scheduler-and-concurrency` — the `RcHeader`
  layout and the scheduler's typed-entry want
- `.claude/rules/seed-dependency.md` — the runtime-source carve-out; confirmed
  in §5/§7 not to apply here
- `runtime/sfn/concurrency/nursery.sfn:225-333` — the seam being generalized
- `runtime/sfn/memory/rc.sfn` — the `drop_fn` gap
- `runtime/capsule.toml:70` — `sfn/concurrency/scheduler.sfn` in `sfn-sources`,
  the evidence that the pinned seed already compiles `*fn` call sites
- `runtime/sfn/platform/pthread.sfn:19-32`,
  `runtime/sfn/concurrency/scheduler.sfn:39-45,607` — the two recorded
  annotation-position workarounds (§2.3) and the already-working call site
- `docs/status.md:526-528` — where the shipped `*fn (A) -> R` capability is
  documented
- `compiler/tests/e2e/plain_fn_ptr_call_test.sfn`,
  `compiler/tests/e2e/fixtures/plain_fn_ptr_call.sfn` — regression coverage for
  the shipped capability
- `compiler/src/typecheck_types/extern_abi.sfn:302-317` —
  `is_c_abi_function_pointer`, the site the §3.2 extern-parameter gap touches
- `compiler/src/typecheck_types/symbol_table_and_raw_exprs.sfn:214-283` —
  `E0808` / `E0809`, the shipped address-of primitive
- `compiler/src/llvm/expression_lowering/native/core_call_lowering.sfn:65-92,268` —
  `try_lower_plain_fn_ptr_call` and its dispatch order
- `compiler/src/llvm/expression_lowering/native/core_call_resolution/closure_callee.sfn`,
  `.../core_call_emission/closure_dispatch.sfn` — the fat indirect-call path the
  thin path is structurally disjoint from
