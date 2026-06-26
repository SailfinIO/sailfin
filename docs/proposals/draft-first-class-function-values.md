---
sfep: TBD
title: First-Class Function Values
status: Draft
type: language
created: 2026-06-26
updated: 2026-06-26
author: "agent:compiler-architect; human review"
tracking: "#1609, #1610, #1172"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0029 — First-Class Function Values

> Retroactive design record for epic **#1609** — "First-class function values
> (named fns, fn-typed struct fields, capturing closures as general params)".
> The epic was filed 2026-06-24, before the SFEP process (SFEP-0001) landed
> 2026-06-26; this SFEP is its durable design record, required because the work
> is a language feature that needs an architect pass before fan-out. See
> [`0001-sfep-process.md`](./0001-sfep-process.md) for the process. This is a
> `Draft`: only the v0 baseline (item 2) is built — everything else is designed,
> not shipped. The four design forks the architect originally flagged for the
> design gate are **resolved and committed** in §3.5 below (and reflected in
> §3.1, §4, §5, §7, §8); there are no remaining open forks.

## 1. Summary

Sailfin lambdas already lower to a `{i8*, i8*}` closure pair (`fn_ptr`, `env*`)
and dispatch through a single seam in
`compiler/src/llvm/expression_lowering/native/core_call_emission.sfn:386-504`.
That seam already makes one shape of first-class function value work end-to-end:
a **capturing closure passed as a `fn(...)` parameter** to a user-defined
higher-order function (#1610, closed 2026-06-25 — the v0 baseline this SFEP
documents). What does **not** work yet is the rest of the function-value surface
a production language is expected to have: (1) referencing a **named function**
as a typed `fn(...)` value (today only `<fn> as * u8` C-ABI address-taking is
allowed; the #1147 `E0808` guard rejects every other value-position use), (3)
**populating and dispatching through fn-typed struct fields**, and (4) a clear
**ABI verdict** for non-pointer-width signatures (`fn(string) -> string` where
`string` is `{i8*, i64}`). This SFEP designs all four items so that *every*
function value — named or closure, in a parameter, a local, or a struct field —
materializes the same `{fn_ptr, env}` pair and dispatches through the **one**
existing seam, and it states precisely where generics gate the ABI. The
governing bar is a **performant, production-ready compiler/runtime/capsule
ecosystem competitive with Go and Rust**: the design is optimized so that
function-value dispatch matches Go's uniform-closure and Rust's zero-cost
`fn`-item/branchless-`Fn` cost models, not for minimal implementation effort.
It commits to no release window; sequencing is decided at grooming once the
shared generics dependency (with SFEP-0012 and SFEP-0028) has a plan.

## 2. Motivation

First-class functions are table stakes. Sailfin can pass a lambda to a
higher-order function and dispatch it, but it cannot yet treat a **named**
function as a value, store a function in a struct field, or carry a function
across a non-pointer-width signature. The status quo strands three idioms:

```sfn
fn worker(n: int) -> int { return n + 1; }

fn apply(cb: fn (int) -> int, x: int) -> int { return cb(x); }

fn main() ![io] {
    // (1) Named function as a value — REJECTED today (E0808). The only
    // allowed value-position use of `worker` is `worker as * u8` (a raw
    // C-ABI code pointer, #1142/#1146), which is not a callable fn(int)->int.
    print(apply(worker, 5));

    // (2) Capturing closure as a general fn(...) param — WORKS today (#1610).
    let bias: int = 10;
    print(apply(fn (n: int) -> int { return n + bias; }, 5));

    // (3) fn-typed struct field — the field TYPE checks (it lays out as the
    // {i8*, i8*} closure pair), but populating it with a fn/closure value and
    // dispatching through it is not wired.
    let r = Router { handler: worker };   // population gap
    print(r.handler(5));                  // field-dispatch gap
}

struct Router { handler: fn (int) -> int; }
```

**The concrete blocked consumer (#1172).** The native test runner needs to
inject **named compiler functions** *and* **capturing closures** as typed
callbacks — a registry of `fn (TestCtx) -> TestResult` handlers, some of which
are bare named functions and some of which are closures that capture per-suite
state. Item (2) already lets it pass the closures; items (1) and (3) are what
block it from registering the named functions and from storing the handler set
in a struct. Until a named function can become a `fn(...)` value and a struct
field can hold one, #1172 cannot express its callback table without a workaround
(wrapping every named function in a trivial forwarding lambda — which works, but
is exactly the boilerplate first-class functions exist to remove).

**Today's rejection is deliberate, not accidental.** The #1147 `E0808` guard
(`compiler/src/typecheck_types.sfn:1729-1841`,
`make_fn_value_position_diagnostic` + `check_fn_reference_raw`) was added so that
"function used as a value here" fails *loudly* rather than silently miscompiling
to an un-lowerable form. The blessed exception is `<fn> as * u8` (and the precise
`<fn> as * fn (...) -> T`) for a concrete C-ABI function — the `pthread_create`
start-routine idiom (#1146, #1193). Lifting items (1) and (3) means **narrowing
that guard**, not removing it: the now-supported `fn(...)`-value form must pass,
while genuinely un-lowerable forms (generic functions, casts to a non-pointer or
a typed data pointer) must still be rejected.

## 3. Design

The unifying principle: **every function value — named or closure, in any
position — is the same `{i8*, i8*}` pair, and dispatch always goes through the
one seam.** That seam already exists and is load-bearing today:

- **Resolution** —
  `core_call_resolution.sfn:354-376` sets `is_closure_dispatch = true` when the
  call target resolves to a closure binding (`try_resolve_closure_callee`), and
  `:1407-1426` (`resolve_call_signature`) injects the `{i8*, i8*}` self slot as
  `expected_params[0]` and uses the closure's resolved return/param types.
- **Threading** — `core_call_lowering.sfn:335-340` reads
  `resolution.is_closure_dispatch` and forwards it through `resolve_call_signature`
  into `coerce_and_emit_call` (`:629`).
- **Emission** — `core_call_emission.sfn:386-504` is the *single place closures
  dispatch*: it `extractvalue`s `fn_ptr` (index 0) and `env*` (index 1) from the
  pair (`:430-445`), reconstructs the typed function-pointer type from the
  call-site operand types (`:447-462`), `bitcast`s, and emits the call with
  `env*` as the hidden first argument (`:464-503`). The closure-pair operand
  bypasses coercion via the slot-0 guard at `:111-114`.
- **Type mapping** — `compiler/src/llvm/type_mapping.sfn:440-441` (and the
  twin at `:626-627`) already maps `fn(...)` / `fn (...)` annotations to
  `{i8*, i8*}`, and `:433-434` maps the `__closure__@…` sentinel the same way.
  So a `fn(...)` annotation **anywhere** — param, local, struct field — already
  lays out as the closure pair.

The four items below are all about **producing a closure-pair operand** for new
sources (a named function, a struct-field load) and **routing it into the
existing seam**, plus deciding the ABI envelope. No new dispatch mechanism is
introduced.

### Item 1 — Named function → `fn(...)` value

**Goal.** A bare `worker` (a name that resolves to a top-level function, not a
call) used in `fn(...)` value position becomes a callable function value that
dispatches through the same seam as a closure — **with zero overhead relative to
Go/Rust on both the materialized-value path and the statically-known-callee
path.**

**Lowering — committed: the two-path hybrid (decision D1, §3.5).** The deciding
factor is **hot-path dispatch cost**, not codegen simplicity. Go gives function
values produced from named functions (and method values) a *uniform closure
representation* so the indirect call is a single branchless `CALL` through the
func value; Rust coerces a `fn`-item to a `fn`-pointer **zero-cost** and keeps
`Fn`-trait dispatch uniform and branchless. A production-grade Sailfin must match
both — so this SFEP commits to a hybrid that is branchless on the common indirect
path **and** zero-indirection when the callee is statically a named function:

- **Path A — statically-known named callee → direct call (zero indirection).**
  When the call target *is* a bare named function at the call site (the callee is
  monomorphically known, no `fn(...)` value is materialized — e.g. `worker(5)`,
  the overwhelmingly common case), lowering emits a **direct** `call <ret>
  @worker(<args>)` with **no** pair, **no** env, **no** indirection. This is the
  existing direct-call path and is unchanged; it is the Rust `fn`-item-call
  equivalent (the value is never reified). The only new work is ensuring the
  narrowed #1147 guard (below) does not divert this case into value
  materialization.

- **Path B — named fn materialized into a `fn(...)` value → trampoline pair
  `{trampoline_ptr, null}` (branchless indirect).** When a named function *flows
  as a value* through the seam (passed to `apply(worker, …)`, stored in a struct
  field, assigned to a `fn(...)` local), it is reified as the closure pair
  `{ bitcast(@worker__fnval_adapter to i8*), null }`, where
  `@worker__fnval_adapter(i8* env, <args>)` ignores `env` and **tail-calls**
  `@worker(<args>)`:

  ```
  ; emitted once per named fn materialized as a value (deduplicated by symbol)
  define i64 @worker__fnval_adapter(i8* %env, i64 %n) {
    %r = musttail call i64 @worker(i64 %n)
    ret i64 %r
  }
  ; at the materialization site
  %fp   = bitcast i64 (i8*, i64)* @worker__fnval_adapter to i8*
  %pair = insertvalue {i8*, i8*} { i8* undef, i8* null }, i8* %fp, 0
  ```

  This makes **every** value flowing through the dispatch seam — closure or
  named-fn — carry the *identical* `(i8* env, <args>)` calling convention, so the
  seam at `core_call_emission.sfn:430-503` stays a **single, branchless** indirect
  `call` with the env passed unconditionally. There is **no per-call static-null
  branch** on the hot indirect path. The `musttail` tail-call is collapsed by
  LLVM (the adapter is a thin forwarding shim in guaranteed tail position), so
  Path B's steady-state cost is one indirect call — the same instruction count Go
  pays for a func value and Rust pays for `Fn` dispatch. The adapter is emitted
  **once per named function actually materialized as a value** (deduplicated by
  symbol, like a monomorphization cache), not once per call site, so binary-size
  growth is bounded by the count of distinct named functions used as values.

**Why the trampoline pair, not the env-less `{ptr, null}` carrier.** An earlier
draft considered carrying `@worker` directly in slot 0 and selecting an *env-less*
call shape when slot 1 is statically `null` (the "1a carrier"). That is **rejected
on the performance bar.** "Statically `null`" is only knowable when the pair's
provenance is visible at the call site; once a `fn(...)` value crosses an
abstraction boundary (a struct field, a function parameter, a collection element)
the seam **cannot** prove slot 1 is null, so it would have to emit a **runtime**
null-check + two call sites (env-less and env-ful) on *every* indirect closure
call — a conditional branch and duplicated call that Go and Rust pay nowhere.
That is precisely the hot-path tax this SFEP exists to avoid. The trampoline pair
makes the convention uniform so the check disappears entirely. The env-less
carrier survives **only** as a fused special case of Path A (a named callee whose
value never escapes), where it degenerates to the direct call and no pair is built
— that is exactly the existing `plain_fn_ptr_call` env-less indirect path
(`plain_fn_ptr_call_test.sfn:120-142`), which remains the lowering for an
explicit `* fn (A) -> R` C-ABI code pointer and is untouched.

**Verification probe (decided direction, not an open fork).** The trampoline-pair
representation is committed. One implementation-time measurement gates a possible
*optimization*, not the design: confirm LLVM elides the `@worker__fnval_adapter`
frame under `musttail` + `-O2` so Path B is a single indirect call with no extra
frame in the linked binary. Probe: build
`compiler/tests/e2e/fixtures/named_fn_value/main.sfn`, disassemble the dispatch
site, assert no surviving adapter prologue/epilogue between the indirect `call`
and `@worker`'s body. If a frame survives on a target, the fallback is to inline
the adapter at emission (open-code the forwarding) — still branchless, still a
single representation; the *design* (uniform trampoline pair, no per-call null
branch) does not change. This is a codegen-quality check, not a representation
fork.

**The #1147 guard change.** `check_fn_reference_raw`
(`typecheck_types.sfn:1785-1841`) and `make_fn_value_position_diagnostic`
(`:1733`), plus the structured-`Identifier` arm at `typecheck.sfn:1058-1066`
(which today unconditionally fires `E0808` for any bare identifier resolving to a
function), must be **narrowed, not deleted**. The change:

- A bare function name used where a `fn(...)`-typed value is expected becomes
  **legal** — the typechecker records the function reference as a
  closure-pair-producing value (Path B) instead of emitting `E0808`. This is
  driven by the **expected type** at the use site, threaded to the check per
  decision D2 (§3.5).
- Still **rejected** (E0808 / E0809 unchanged): a generic function used as a
  value (`is_generic == true`, `typecheck_types.sfn:1830-1831`) — monomorphizing
  a function-reference value is out of scope here and shares the SFEP-0028/0012
  generics dependency; `& fn` address-of (no unary `&` lowering); `<fn> as
  <non-pointer>` and `<fn> as * <typed-data-ptr>` (reinterpreting a code address
  as a data pointer). The `<fn> as * u8` / `<fn> as * fn (...) -> T` C-ABI forms
  stay valid and untouched.

The guard's load-bearing self-host role (`<value> as * u8` on **non-function**
operands like `label as * u8` in the driver must stay clean —
`typecheck_types.sfn:1779-1783`) is preserved: the narrowing only affects the
case where the head resolves to a function *and* the use site expects a
`fn(...)` value.

### Item 2 — Capturing closure as a general `fn(...)` param (v0 baseline, shipped)

This is the **working baseline**, shipped via #1610 (closed 2026-06-25) and the
#688/#689 closure-dispatch foundation. It is documented here as the seam
generalization the other three items build on, not as new work.

A user-defined HOF whose parameter is typed `fn(int) -> int` accepts a closure
value and dispatches it through the seam. This is **not** the array-HOF
runtime-descriptor special case (`runtime_array_map_fn` in
`compiler/src/llvm/runtime_helpers.sfn`, which threads the pair by value into
`sfn_array_sfn_map` in `runtime/sfn/array.sfn`); it is the **general**
parameter path. Verified end-to-end:

- `compiler/tests/e2e/fixtures/closure_higher_order/main.sfn` — `fn apply(cb:
  fn (int) -> int, x: int)` dispatches a **non-capturing** lambda → `10`.
- `compiler/tests/e2e/fixtures/closure_two_int_capture/main.sfn` — the same
  `apply` dispatches a lambda **capturing two ints** → `31`. This is the
  precise #1610 case (a capturing closure passed to a user-defined HOF); the
  prior miscompile (truncated env struct from comma-splitting the encoded
  captures) is fixed and now has runtime e2e coverage.
- `compiler/tests/e2e/fixtures/closure_mixed_capture/main.sfn` — a lambda
  capturing **a string and an int** dispatched through `apply` → `xv42`,
  proving the seam already carries a non-pointer-width capture *inside the env
  struct* (the env is a real struct; only the **callback signature** is
  pointer-width-constrained — see item 4).
- `compiler/tests/e2e/fixtures/closure_inferred_capture/main.sfn` — an
  un-annotated inferred-int capture through a `fn(int) -> int` param → `105`.

**What remains for item 2: nothing for the pointer-width signature surface.**
The residual constraints are entirely item-4 (the *callback signature* ABI:
`fn(int) -> int` works; `fn(string) -> string` does not) — those are not item-2
gaps, they are the shared generics gate. Item 2 is the proof that the seam is
**source-agnostic on the env side**; items 1 and 3 extend it to be
source-agnostic on the *carrier* side. Under decision D1, a closure value and a
named-fn value now present the *same* `(i8* env, <args>)` convention to this
parameter path, so item 2 dispatches both with no per-call discrimination.

### Item 3 — fn-typed struct fields

**Goal.** Populate a `fn(...)` struct field with a fn/closure value and dispatch
through it.

**What already works.** The field **type** checks and lays out: a field typed
`fn (int) -> int` maps to `{i8*, i8*}` via `type_mapping.sfn:440-441`, so the
struct's LLVM layout already reserves the closure-pair slot. The gap is purely
**population** and **field-dispatch**:

- **Population.** A struct literal `Router { handler: <fn-or-closure-value> }`
  must store a `{i8*, i8*}` pair into the `handler` field. The right-hand side is
  produced by item 1 Path B (named function → trampoline pair) or by the existing
  lambda lowering (closure → pair). The struct-initializer emission must accept a
  closure-pair operand for a `fn(...)`-typed field with **no coercion** (mirroring
  the slot-0 bypass at `core_call_emission.sfn:111-114`) — the pair is already
  the field's representation. The aggregate→pointer boxing fallback in
  `core_operands.sfn:1290-1346` must **not** fire on a `{i8*, i8*}` field value
  (that path boxes a by-value aggregate into a heap `i8*`; a closure pair stored
  into a struct field is stored directly, not boxed). Because every field value —
  named or closure — is the same convention under D1, the field stores one shape
  and dispatch reads one shape.
- **Field-dispatch.** `r.handler(5)` must (a) load the `{i8*, i8*}` pair from the
  field via GEP+load, then (b) route that operand into the closure-dispatch seam.
  Mechanically this is `try_resolve_closure_callee`
  (`core_call_resolution.sfn:358-376`) generalized: today it recognizes a call
  target that is a **local/parameter** with a closure type; it must additionally
  recognize a **member-access call target** (`<expr>.<field>(...)`) where the
  field's resolved type maps to `{i8*, i8*}`, produce the field-load as the
  closure-pair operand, set `is_closure_dispatch = true`, and let the seam
  proceed unchanged. The note at `:364-365` ("must run BEFORE method-dispatch
  fan-out because a closure binding can shadow a member name") becomes
  doubly relevant: a fn-typed field call must be recognized as closure dispatch
  *before* it is mistaken for a struct-method call.

No new IR shape is introduced — field-dispatch is "load the pair, then the
existing seam." The work is teaching resolution to **find** the pair on a member
access.

### Item 4 — ABI boundary verdict

**What the v0 closure ABI supports.** The seam reconstructs the typed
function-pointer signature from the **call-site operand LLVM types**
(`core_call_emission.sfn:447-462`): each user argument's `llvm_type` becomes a
parameter type, prefixed by the hidden `i8*` env. This works cleanly for
**pointer-width and scalar** signatures — `fn(int) -> int` (`i64`), `fn(int) ->
bool` (`i1`), pointer-typed args/returns — because each maps to a single LLVM
value of a fixed width and the bitcast-to-fn-ptr is faithful.

**Where it gates.** A signature whose argument or return is a **non-pointer-width
aggregate** is *not* safe through v0. The canonical case is `fn(string) ->
string`: `string` is the two-word `{i8*, i64}` value. The seam would synthesize
parameter types from whatever the call-site operand happens to be, and a by-value
`{i8*, i64}` argument crossing an indirect call needs the **callee's real ABI**
(by-value aggregate passing / sret) to match — which the call-site-derived
signature does not guarantee. This is the **same class of constraint** SFEP-0028
§3 identifies for array HOFs: the callback ABI is fixed at pointer width, and
typed/aggregate element shapes need either **monomorphization** (specialize the
body per concrete type, giving each the *natural* ABI for its shape) or a
**width-aware ABI** (explicit width/kind tags).

**Verdict for v0 (this SFEP):**

- **Supported:** named-fn values, fn-typed struct fields, and general `fn(...)`
  params for **pointer-width / scalar** signatures (`fn(int) -> int`,
  `fn(int) -> bool`, pointer args/returns). Captures *inside* the env may be any
  shape (the env is a real struct — `closure_mixed_capture` proves a captured
  `string` works); the constraint is on the **callback signature**, not the
  capture set.
- **Gated (rejected with a diagnostic, not miscompiled):** any `fn(...)` value
  whose **signature** carries a non-pointer-width aggregate argument or return
  (`fn(string) -> string`, `fn(Point) -> Point`). These wait on generic
  constraints + monomorphization.

**Relationship to SFEP-0012 and SFEP-0028.** All three wait on the **same**
foundation — generic type constraints + monomorphization:

- **SFEP-0012** (`Result<T, E>` + `?`) needs generic constraint solving to type
  the `T`/`E` parameters.
- **SFEP-0028** (typed array HOFs) needs monomorphization to give
  `float[]`/`string[]`/struct-array callbacks their natural element ABI; it
  reads the monomorphization-vs-width-tag tradeoff in its §3 (recommended end
  state (A) monomorphized bodies; (C) width-tagged descriptors as a no-generics
  interim).
- **SFEP-0029** (this SFEP) shares the **closure-dispatch seam** with SFEP-0028
  but is a **distinct feature**: SFEP-0028 is about array **element-type
  discipline** (threading typed elements through `sfn_array_sfn_*` runtime
  bodies); SFEP-0029 is the **general function-value surface** (named fns,
  struct fields, general params) independent of arrays. They intersect at one
  point — both want non-pointer-width signatures through the seam — and that
  intersection is the shared generics gate. The width verdict here is
  **deliberately consistent** with SFEP-0028 §3: monomorphization is the
  principled end state (each concrete signature gets its natural ABI, the seam
  generalizes without a new mechanism because the "resolved type" is just the
  concrete type); a width-tagged interim is possible but not recommended as the
  end state. This SFEP does **not** re-litigate that choice — it inherits it and
  defers the non-pointer-width function-value surface to whenever the shared
  generics work lands.

### 3.5 Resolved design decisions

The four forks flagged during the architect pass are resolved here as committed
decisions, each justified against the **Go/Rust-competitive performance +
production-readiness** bar. None remains an open fork; the two that carry an
implementation-time check are recorded as *decided directions with a named
verification step*, not alternatives to choose between later.

**D1 — Named-fn lowering: committed to the two-path hybrid (Path A direct call +
Path B trampoline pair `{trampoline_ptr, null}`).** Rationale: the decision is
made on **hot-path dispatch cost**, not codegen simplicity. The rejected env-less
carrier ("1a") forces a *runtime* slot-1 null-check and a duplicated call site on
**every** indirect closure call once a value escapes its definition site, because
the seam cannot statically prove the env is null across an abstraction boundary —
a conditional branch Go and Rust pay nowhere (Go: uniform closure representation
for func-values-from-funcs and method values; Rust: zero-cost `fn`-item→`fn`-ptr
coercion + branchless `Fn` dispatch). The trampoline pair makes the calling
convention **uniform** (`i8* env, <args>` for every value, env passed
unconditionally), so the common indirect path is a single branchless `call`; and
Path A keeps the statically-known-named-callee case at a **direct call, zero
indirection** — matching Rust's `fn`-item call. Net: Sailfin pays exactly the
Go/Rust cost on both paths. Verification step (codegen quality, not design):
confirm `musttail` + `-O2` elides the adapter frame; fallback is to open-code the
forwarding at emission — same representation, still branchless. Committed in §3.1
Item 1. Full text and the IR shape live there.

**D2 — Expected-type plumbing: committed to complete coverage at every
function-reference use site.** Production-ready means *no partial coverage* — a
named-fn value must be accepted (and effect-checked) wherever a `fn(...)` value
is expected, never only in some positions. The `fn(...)`-value-position check
(today the structured-`Identifier` arm at `typecheck.sfn:1058-1066` and the
`Raw`-form `check_fn_reference_raw` at `:1072-1073`, both of which currently take
no expected type) is threaded an **expected-type argument** and exercised at all
of:

  1. **Variable / `let` binding with annotation** — `let f: fn (int) -> int =
     worker;` (the annotation supplies the expected type).
  2. **Assignment to a typed lvalue** — `f = worker;` where `f`'s declared type
     is `fn(...)`.
  3. **Function-call argument position** — `apply(worker, 5)` (the callee's
     parameter type `cb: fn (int) -> int` supplies the expected type; this is the
     #1172 path).
  4. **Struct-literal field initializer** — `Router { handler: worker }` (the
     field's declared type supplies the expected type; the item-3 population path).
  5. **Array / collection literal element** — `let hs: (fn (int) -> int)[] =
     [worker, doubler];` (the element type supplies the expected type; #1172's
     handler *table* needs this).
  6. **Return position** — `fn pick() -> fn (int) -> int { return worker; }` (the
     enclosing function's declared return type supplies the expected type).

  Reach confirmation: the value-position check is reached from the typecheck
  expression walk (`typecheck.sfn`, the `Identifier`/`Raw` arms above). Sites
  (1)–(4) and (6) flow through statement/argument/field/return typechecks that
  **already carry the declared target type** in their local context, so threading
  it to the walk is mechanical (add the expected type as a walk parameter,
  defaulting to "none" → preserve today's `E0808` when there is genuinely no
  `fn(...)` expectation). Site (5) is the one that needs the array/collection
  literal element type propagated into the element walk; in current typecheck the
  collection-literal element type is available at the literal node but is not
  always pushed down per element. **Scoped sub-task:** if pushing the element type
  down per element is not already wired, it lands as a small predecessor within
  the same epic ("thread collection-literal element type into element typecheck")
  — it is *not* deferred or made best-effort; complete coverage includes (5).
  Committed in §3.1 Item 1 (guard change) and §5.

**D3 — Effect-row preservation: committed as a hard soundness invariant.** This
is non-negotiable for the effect-system pillar. The effect row is **part of the
`fn(...)` type's identity**, not metadata that may be dropped or widened when a
function becomes a value. The committed rules:

  - **Type identity.** `fn (A) -> R ![E]` and `fn (A) -> R ![E']` are the *same*
    function-value type only when `E` and `E'` denote the same effect set under
    the canonical taxonomy. The effect row participates in `fn(...)` type
    equality.
  - **Subtyping / coercion (subsumption, consistent with SFEP-0017).** A value of
    type `fn (A) -> R ![E]` is assignable to an expected `fn (A) -> R ![F]` iff
    `E ⊆ F` (the value promises *at most* `F`'s effects). Because SFEP-0017 models
    hierarchical sub-effects as **subsumption within the locked six** (`io.fs ⊑
    io`), set membership here is computed under that refinement order: a value
    declared `![io.fs]` satisfies an expected `![io]` (a refinement is ⊑ its
    parent), but a value declared `![io]` does **not** satisfy an expected
    `![io.fs]`. Effect rows are thus contravariant-by-subsumption in the
    value-coercion direction (a function value may be *more* restricted than the
    slot it fills, never less). Function-value parameter/return types compose this
    rule structurally.
  - **Materialization.** When a named function (or a closure) is materialized into
    a `fn(...)` value at any of the D2 sites, the materialized value's type
    carries the source function's declared effect row; the checker **unifies it
    against the expected `fn(...)` type's effect row under the ⊆ rule** and
    rejects (a new diagnostic, not a silent widen) if the source's effects exceed
    the expected row. A function value can never *launder* an effect by becoming a
    value.
  - **Call-site soundness rule (stated explicitly).** Calling a `fn (...) ![E]`
    value requires the caller's own declared effect row to **⊇ E** — exactly as a
    direct call to a function declaring `![E]` would. Dispatch through the seam
    does not relax this; the effect obligation is discharged at the call site
    against the value's *type-level* effect row, independent of which concrete
    function the pair points at.

  Mechanically the effect row already lives on the `fn(...)` annotation and on
  function signatures; D3 commits that the value-coercion check (D2's
  expected-type unification) and the call-site effect check **both** consult it,
  and adds the confirming effect-checker test in §8. The dispatch *mechanics*
  (`core_call_emission.sfn`) stay effect-agnostic — correctly, because the
  contract is enforced in the checker, not at emission. Committed in §4.

**D4 — Bundle-vs-split for #1172: committed grooming directive.** Per
`.claude/rules/seed-dependency.md`, named-fn-value lowering (item 1) and the
fn-typed-field capability (item 3) are **compiler-source capabilities** their
consumers need present in the **pinned seed**. The directive `/groom` applies
deterministically:

  - **Default — BUNDLE.** Items 1 + 3 (the capability) land in **one PR together
    with #1172's adoption** of them (the first and, at this time, only consumer).
    `make compile` builds the new compiler from the old seed; that freshly-built
    compiler then compiles #1172's named-fn + closure callback table in the same
    self-host pass → **no seed cut, no `/pin-seed`.** This is the production-
    efficient path: it avoids manufacturing a release cycle between capability and
    consumer.
  - **Exact split condition (the only thing that overrides the default).** Split
    the capability into a standalone `seed-blocker` predecessor **iff** *either*:
    (a) **multiple independent consumers** of the capability land before or
    alongside #1172 (so the capability genuinely serves more than its first
    consumer and merits standalone shipping), *or* (b) the **combined blast radius
    of items 1 + 3 + #1172 exceeds one reviewable PR** (an honest S/M ceiling —
    never bundle into an L). On a split, the capability PR carries `seed-blocker`,
    #1172 carries `## Required in pinned seed: #<capability>`, and the seed advance
    **queues against the next cadence seed bump** (it does **not** trigger a
    reactive cut). Item 4's negative diagnostic is frontend-only and may ride
    either PR.

  Committed in §5.

## 4. Effect & capability impact

**The seam is effect-agnostic, and that is correct.** A closure carries its
body's effects through the call: when a `fn (...) ![io]` value is dispatched, the
effect requirement is a property of the **function's type-level effect row**,
enforced by `effect_checker.sfn` and the value-coercion check, not by the
dispatch mechanics. `core_call_emission.sfn` does not inspect or alter effects —
it emits the indirect call; the effect contract is established upstream.

**D3 (§3.5) is the committed hard invariant for this section.** Restating the
load-bearing rules so they are normative here, not advisory:

- The effect row is **part of `fn(...)` type identity** — never dropped or
  silently widened when a function (named or closure) is materialized as a value,
  stored in a field, passed as a param, put in a collection, or returned.
- **Coercion is by subsumption:** `fn (A) -> R ![E]` is assignable to an expected
  `fn (A) -> R ![F]` iff `E ⊆ F` under the SFEP-0017 sub-effect order (`io.fs ⊑
  io`), so a *more* restricted value fills a *broader* slot but never the reverse.
  Materialization at every D2 site unifies the source row against the expected row
  under this rule and **rejects** (diagnostic, not widen) on exceedance.
- **Call-site soundness:** calling a `fn (...) ![E]` value requires the caller to
  declare **⊇ E** — identical to a direct call to an `![E]` function. A function
  value cannot launder an effect by becoming a value.

There is **no new capability surface**: no new effect atom (the taxonomy stays the
locked six, SFEP-0017), no new way to escape an effect annotation. Items 1–3 do
not change the effect *model*; they extend its enforcement to the new
function-value carriers and commit that enforcement is total, which is what a
capability-security pillar requires. The confirming effect-checker test is in §8.

## 5. Self-hosting impact

Passes touched, in pipeline order:

- **Parser** — **no change.** `fn(...)` / `fn (...)` annotations already parse
  (#688, `parser_function_types_test.sfn`); bare identifiers and member-access
  call targets already parse. No new syntax.
- **AST** — **no change.** Function-value references are existing identifier /
  member-access nodes; closure values are existing lambda nodes.
- **Typecheck** (`typecheck.sfn` + `typecheck_types.sfn`) — **narrow the #1147
  guard** (the `Identifier`/`Raw` arms at `typecheck.sfn:1058-1073`,
  `check_fn_reference_raw` `:1785-1841`, `make_fn_value_position_diagnostic`
  `:1733`) to accept a named function in `fn(...)`-value position by consulting
  the **expected type threaded to every D2 use site** (variable/let, assignment,
  call argument, struct-field initializer, collection-literal element, return),
  while still rejecting generic functions, `& fn`, and non-`* u8` casts. Add the
  **D3 effect-row unification** to the value-coercion check (reject on `E ⊄ F`
  under the SFEP-0017 sub-effect order) and the **item-4 non-pointer-width
  diagnostic**. The one possibly-not-yet-wired piece (D2 site 5) is the scoped
  collection-literal-element-type push-down sub-task noted in §3.5.
- **Effect checker** (`effect_checker.sfn`) — **call-site rule unchanged in
  mechanism, extended in reach:** the existing "caller must declare ⊇ callee
  effects" check now also fires on a closure-pair call whose type-level effect row
  is `![E]`; confirm it already walks closure-dispatch call sites (it does for the
  v0 closure-param path) and that the value-coercion check feeds it the right row.
- **Emitter / LLVM lowering** —
  - *Item 1 (D1):* Path A is the unchanged direct call; Path B emits a
    deduplicated `@<fn>__fnval_adapter` (`musttail` forward to `@<fn>`) and the
    `{adapter_ptr, null}` pair at the materialization site. The seam
    (`core_call_emission.sfn:386-504`) is **unchanged** — it dispatches the
    uniform `(i8* env, <args>)` convention with no per-call null branch.
  - *Item 3:* generalize `try_resolve_closure_callee`
    (`core_call_resolution.sfn:358-376`) to recognize a member-access call target
    whose field maps to `{i8*, i8*}`; teach struct-literal emission to store a
    closure pair into a `fn(...)` field without firing the
    `core_operands.sfn:1290-1346` boxing fallback.
  - The **dispatch seam itself** stays the single place closures dispatch.
- **Runtime** — **no change.** Unlike SFEP-0028, this feature touches no
  `runtime/sfn/array.sfn` body; it is purely a frontend/lowering capability.

**Performance consequence of D1 on self-host.** The trampoline-pair adapters are
emitted **only** when a named function is materialized *as a value* (Path B),
deduplicated per symbol. The compiler's own hot call paths are ordinary direct
calls (Path A) and existing closure dispatch — neither materializes a named-fn
value today — so D1 adds **zero** adapters and zero indirect-call overhead to the
current self-host; the compiler keeps its present codegen. Adapters appear only in
modules that adopt the new surface (e.g. #1172's test runner), bounded by the
distinct named functions they use as values. There is no build-time or
runtime-speed regression to the self-hosting build.

**Self-hosting invariant + seed dependency (D4).** Named-fn-value lowering and the
narrowed guard are compiler-source capabilities a consumer needs in the **pinned
seed**. The committed grooming directive (D4, §3.5): **default to bundling items
1 + 3 with #1172's adoption in one PR** → `make compile` builds the new compiler
from the old seed and that compiler compiles #1172 in the same pass → **no seed
cut, no `/pin-seed`.** Split into a standalone `seed-blocker` predecessor **only**
if (a) multiple independent consumers land before/with #1172, or (b) the combined
blast radius exceeds one reviewable PR; on a split the seed advance **queues
against the next cadence bump**, never a reactive cut. The compiler does **not**
currently use named-fn-as-value or fn-typed struct fields in its own source (it
uses the `<fn> as * u8` C-ABI form for concurrency trampolines, unchanged), so
landing items 1/3 does not regress the existing self-host.

## 6. Alternatives considered

- **Keep `<fn> as * u8`-only forever (status quo).** Rejected: it permanently
  forces the test runner (#1172) and every future callback-table consumer to
  wrap named functions in trivial forwarding lambdas, and it leaves "function as
  a value" — a baseline expectation for any language — unsupported. The C-ABI
  cast is a code-pointer escape hatch, not a callable `fn(...)` value.
- **Env-less `{ptr, null}` carrier with a per-call static-null branch (the "1a"
  carrier) as the named-fn representation.** Rejected on the performance bar
  (D1): once a value escapes its definition site the seam cannot prove the env is
  null, forcing a runtime null-check + duplicated call site on every indirect
  call — a branch Go's uniform closure rep and Rust's branchless `Fn` dispatch
  pay nowhere. The env-less indirect call survives only as the existing
  `plain_fn_ptr_call` lowering for an explicit `* fn (A) -> R` C-ABI pointer, and
  as the degenerate Path A direct call. The committed answer is the uniform
  trampoline pair.
- **Fat pointer instead of the `{fn_ptr, env}` pair.** Rejected: the
  `{i8*, i8*}` pair is already the shipped, self-hosting closure representation
  (`type_mapping.sfn:440`, `closures.sfn`), already dispatched by the one seam,
  and already proven across captures of mixed shapes. A different fat-pointer
  encoding would fork the representation and re-implement the seam for no gain.
  The whole design leans on **one** representation.
- **Partial expected-type coverage (accept named-fn values in only some
  positions).** Rejected (D2): a production language must accept a function value
  wherever a `fn(...)` is expected, including collection literals and return
  position (both of which #1172's handler table needs). Partial coverage teaches
  users the feature is unreliable. Full coverage is committed; the one
  not-yet-wired propagation (collection-literal element type) is a scoped
  sub-task, not a deferral.
- **Treat the effect row as droppable/wideneable metadata on materialization.**
  Rejected (D3): silently dropping or widening a function value's effects breaks
  the capability-security pillar — it is exactly the "parsed but not enforced"
  anti-pattern. The effect row is committed as part of `fn(...)` type identity,
  unified by subsumption (SFEP-0017) at every materialization and call site.
- **Require explicit closure-construction syntax** (e.g. `closure(worker)` to
  lift a named function to a value). Rejected: it violates "boring syntax wins"
  — TypeScript/Rust/Python all let a bare function name be a value with no
  ceremony, and LLMs (per the AI-agents-are-users principle) expect that. The
  conversion is implicit at a `fn(...)`-typed use site, driven by the expected
  type, not a keyword.
- **Support non-pointer-width signatures now via uniform boxing.** Rejected for
  the same reasons SFEP-0028 §3(B) rejects it (allocation storm, the
  number-boxing-into-`any` hazard, value-type unsoundness) and because it would
  diverge the function-value ABI from the array-HOF ABI that should share the
  monomorphization end state. The non-pointer-width surface waits for generics.
- **Width-tagged function-pointer descriptors (SFEP-0028 §3(C)) for this
  feature.** Considered as an interim for `fn(string) -> string`; deferred. It is
  viable but should be decided **once, jointly** with SFEP-0028 rather than
  independently here — the two features share the seam and should not grow two
  different width-tag schemes.

## 7. Stage1 readiness mapping

Only the **v0 baseline (item 2)** is built and self-hosting today. Items 1, 3,
and the item-4 verdict are designed, not shipped — every box below is for the
*new* surface (items 1/3/4), now reflecting the committed decisions:

- [ ] Parses (no new syntax — `fn(...)` annotations and member-access calls
      already parse; no-op box, listed for completeness)
- [ ] Type-checks / effect-checks — narrowed #1147 guard with **expected type
      threaded to all six D2 use sites** (incl. the scoped collection-literal
      element-type push-down) + **D3 effect-row unification by subsumption** +
      item-4 non-pointer-width diagnostic
- [ ] Emits valid `.sfn-asm`
- [ ] Lowers to LLVM IR — **D1 hybrid:** Path A direct call; Path B deduplicated
      `musttail` trampoline pair `{adapter_ptr, null}`; struct-field load → seam.
      Includes the D1 codegen-quality probe (adapter-frame elision under
      `musttail` + `-O2`)
- [ ] Regression coverage (§8) — incl. the dispatch-cost / branchless-seam check
      and the effect-row-preservation test
- [ ] Self-hosts (bundled with #1172 per D4 → no seed cut)
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` + spec (function-value section; record the
      D1 cost model, D3 effect-subsumption rule, and the non-pointer-width gate
      as pending generics)

(Item 2 — capturing closure as a general `fn(...)` param — is already
end-to-end and self-hosting via #1610; its boxes are effectively checked but it
is documented here as the baseline, not re-shipped.)

## 8. Test plan

E2e fixtures + tests mirroring the established
`compiler/tests/e2e/closure_capture_test.sfn` /
`compiler/tests/e2e/array_{map,filter,reduce}_closure_test.sfn` pattern (drive
the compiler-under-test as a subprocess with `process.run_capture`, assert on
captured stdout / emitted IR). One per item plus the decision-specific tests:

- **Item 1 — named-fn-as-value (D1).**
  `compiler/tests/e2e/fixtures/named_fn_value/main.sfn`: `fn worker(n: int) ->
  int { return n + 1; }` + `fn apply(cb: fn (int) -> int, x: int) -> int { return
  cb(x); }` + `print(apply(worker, 5))` → `6`. IR assertions: (a) a deduplicated
  `@worker__fnval_adapter` with a `musttail call @worker`; (b) the materialization
  builds a `{adapter_ptr, null}` pair; (c) the **dispatch seam is branchless** —
  a single indirect `call` through the pair with **no** per-call null-check /
  duplicated call site (the D1 hot-path guarantee); (d) `sfn check` exits 0 (no
  `E0808`). **Dispatch-cost probe** (decided-direction verification): disassemble
  the linked dispatch site and assert no surviving adapter prologue/epilogue
  between the indirect `call` and `@worker` under `-O2`.
- **D1 Path A direct-call pin.** A fixture where `worker(5)` is called directly
  (no value materialized) asserts the IR emits a **direct** `call @worker` with
  no pair and no `@worker__fnval_adapter` reference — the zero-indirection path.
- **Item 3 — fn-typed struct field dispatch.**
  `compiler/tests/e2e/fixtures/fn_field_dispatch/main.sfn`: `struct Router {
  handler: fn (int) -> int; }` populated with **both** a named function and a
  capturing closure (two fixtures or two fields), then `r.handler(5)` dispatched
  → expected sums. Asserts the field-load engages the closure seam
  (`extractvalue {i8*, i8*}` present) and does **not** box the field
  (`core_operands.sfn` boxing fallback not fired).
- **D2 — expected-type coverage.** A multi-site fixture exercising each of the
  six use sites — `let f: fn(int)->int = worker`; assignment; call argument
  (`apply(worker,…)`); struct-field initializer; **collection literal**
  (`[worker, doubler]` typed `(fn(int)->int)[]`, dispatched in a loop); and
  **return position** (`fn pick() -> fn(int)->int { return worker; }`) — each
  `sfn check`s clean and runs to the expected result, proving no position is
  left rejecting a valid named-fn value.
- **D3 — effect-row preservation (effect-checker test).**
  `compiler/tests/e2e/fn_value_effect_row_test.sfn` (+ a `compiler/tests/unit`
  peer): (a) a `fn (...) ![io]` named function materialized into a `fn(...) ![io]`
  slot type-checks; (b) materializing it into a `fn(...) ![]` (pure) slot is
  **rejected** (effect exceedance, not silently widened); (c) a `![io.fs]` value
  satisfies an expected `![io]` slot (SFEP-0017 subsumption) but a `![io]` value
  does **not** satisfy an expected `![io.fs]` slot; (d) calling a stored
  `fn (...) ![io]` value from a caller that does **not** declare `![io]` is
  rejected (call-site ⊇ E rule).
- **Item 2 — regression pin (already shipped).** Keep the existing
  `closure_higher_order` / `closure_two_int_capture` / `closure_mixed_capture` /
  `closure_inferred_capture` cases green as the v0 baseline guard.
- **Item 4 — ABI boundary negative test.**
  `compiler/tests/e2e/fn_value_abi_boundary_test.sfn`: a `fn(string) -> string`
  value (named or closure) used as a function value is **rejected with a
  diagnostic** (not miscompiled), so the non-pointer-width gate never silently
  mis-dispatches before generics land. Mirrors SFEP-0028's "diagnostic-not-mis-map"
  negative test.
- **Guard-preservation unit test** in `compiler/tests/unit/`: the narrowed
  #1147 guard still rejects a **generic** function used as a value, `& fn`, and
  `<fn> as * i32` (typed-data-ptr), and still accepts `<fn> as * u8` /
  `<fn> as * fn (...) -> T`.
- `make compile` self-hosts; `make check` triple-pass green.

## 9. References

- **#1609** — epic "First-class function values (named fns, fn-typed struct
  fields, capturing closures as general params)"; this SFEP is its design record.
- **#1610** — capturing closure as a general `fn(...)` param (the v0 baseline;
  the prior miscompile, fixed and closed 2026-06-25; covered by
  `closure_two_int_capture`).
- **#1172** — the native test runner consumer that needs named compiler fns +
  capturing closures as typed callbacks (the concrete blocked motivation, and the
  bundle target for D4).
- **#1142 / #1146** — `<fn> as * u8` C-ABI code-pointer address-taking (the only
  currently-blessed function-value form; unchanged by this SFEP).
- **#1147** — the `E0808`/`E0809` value-position guard
  (`typecheck_types.sfn:1729-1841`, `typecheck.sfn:1058-1073`) that this SFEP
  narrows.
- **#1118** — runtime-callable closure application primitive (the foundation the
  seam is built on).
- **#1507 / #1508** — the closure-apply seam + pointer-width array
  `map`/`filter`/`reduce` bodies (the runtime-descriptor special case this
  SFEP's general path is distinguished from).
- **#688 / #689** — `fn(...)` type-annotation parsing and the original
  closure-callee dispatch (`closure_higher_order`).
- **SFEP-0012** (`Result<T, E>` + `?`) — shares the generic-constraint dependency.
- **SFEP-0017** (`0017-hierarchical-effects.md`, Accepted) — hierarchical
  sub-effects as subsumption within the locked six; the effect-set order D3 uses
  for function-value effect-row coercion (`io.fs ⊑ io`).
- **SFEP-0025 §3.4** (`0025-native-runtime-architecture.md`, "Typed Closures") —
  the documented `{fn_ptr, env*}` closure ABI this design builds on.
- **SFEP-0028** (`0028-typed-array-higher-order-fns.md`) — the typed-array HOF
  feature that **shares the closure-dispatch seam** but is distinct; its §3 is
  the canonical monomorphization-vs-width-tag framing this SFEP's item-4 verdict
  is kept consistent with.
- **File anchors:**
  `compiler/src/llvm/expression_lowering/native/core_call_emission.sfn:386-504`
  (the seam),
  `…/core_call_resolution.sfn:354-376, 1407-1426` (resolution + signature),
  `…/core_call_lowering.sfn:335-340, 629` (threading),
  `…/core_operands.sfn:1290-1346` (boxing fallback to avoid for fn-typed fields),
  `compiler/src/llvm/closures.sfn` (env-struct + pair ABI),
  `compiler/src/llvm/type_mapping.sfn:440-441` (`fn(...)` → `{i8*, i8*}`),
  `compiler/src/typecheck.sfn:1058-1073` (the `Identifier`/`Raw` value-position
  arms D2 threads expected type into),
  `compiler/src/typecheck_types.sfn:1729-1841` (the #1147 guard),
  `compiler/tests/e2e/plain_fn_ptr_call_test.sfn` (the env-less C-ABI indirect
  call that remains the `* fn (A) -> R` lowering),
  `compiler/tests/e2e/fixtures/closure_two_int_capture/main.sfn` (the #1610 v0
  baseline).
