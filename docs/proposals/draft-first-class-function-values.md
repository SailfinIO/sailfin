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
> not shipped.

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
existing seam, and it states precisely where generics gate the ABI. It records
design and tradeoffs only; it commits to no release window. Sequencing is decided
at grooming once the shared generics dependency (with SFEP-0012 and SFEP-0028)
has a plan.

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
call) used in `fn(...)` value position becomes a callable `{fn_ptr, null-env}`
pair, so call sites dispatch through the same seam as a closure.

**Lowering.** A named function has no captured environment, so its closure pair
is `{ bitcast(@<fn> to i8*), null }`:

```
; materialize `worker` as a fn(int)->int value
%fp   = bitcast i64 (i64)* @worker to i8*
%pair = insertvalue {i8*, i8*} { i8* undef, i8* null }, i8* %fp, 0
; %pair is the {i8*, i8*} closure pair; env slot stays null
```

This is the env-less sibling of the closure pair, and it reuses the seam exactly:
`core_call_emission.sfn:430-445` extracts `fn_ptr` and `env*` (here `null`), and
the bitcast at `:458-462` reconstructs the typed signature. The hidden `env*`
first argument is passed as `null` — **but the named function's real LLVM
signature has no env parameter.** Two ways to reconcile this, in the order the
implementer should try them:

- **(1a) Reuse the env-less indirect-call path (preferred).** The plain
  `* fn (A) -> R` code-pointer call already lowers to an **env-LESS** indirect
  call — `bitcast` to the typed fn-ptr type, then `call <ret> %fp(<args>)` with
  **no** hidden env argument (proven by `plain_fn_ptr_call_test.sfn:120-142`,
  which asserts the IR contains a typed-fn-ptr bitcast, an env-less `call`, and
  *no* `extractvalue {i8*, i8*}`). A named-function value is exactly that case
  with a `{i8*, i8*}`-typed *carrier*: store the address in the pair's slot 0,
  and at dispatch select the **env-less** call shape when slot 1 is statically
  `null`. This keeps the named function's real signature intact (no synthesized
  env parameter) and reuses an already-shipped emission path.

- **(1b) Generate a forwarding trampoline.** Emit `@worker__closure_adapter(i8*
  env, i64 n)` that ignores `env` and tail-calls `@worker(n)`, and point slot 0
  at the adapter. Uniform with the closure ABI (every pair is called the same
  way) but adds one emitted function per referenced named function and an extra
  call frame. Kept as the fallback if (1a)'s static-null discrimination proves
  fragile across the seam.

The recommendation is **(1a)**: it composes the two emission paths the compiler
already has (closure-pair carrier + env-less indirect call) rather than minting
trampolines.

**The #1147 guard change.** `check_fn_reference_raw`
(`typecheck_types.sfn:1785-1841`) and `make_fn_value_position_diagnostic`
(`:1733`) must be **narrowed, not deleted**. Today they fire `E0808` for a bare
function name in value position, `& fn`, and `<fn> as <non-* u8>`. The change:

- A bare function name used where a `fn(...)`-typed value is expected (parameter
  whose annotation maps to `{i8*, i8*}`, a `let f: fn(...) = name`, a struct-field
  initializer of `fn(...)` type) is now **legal** — the typechecker records the
  function reference as a closure-pair-producing value instead of emitting
  `E0808`. This requires the value-position check to know the **expected type**
  at the use site; the guard currently keys only off "the head identifier
  resolves to a function" without consulting the expected type, so it must gain
  an expected-type parameter (the same context the assignment/param-binding
  typecheck already has).
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
source-agnostic on the *carrier* side.

### Item 3 — fn-typed struct fields

**Goal.** Populate a `fn(...)` struct field with a fn/closure value and dispatch
through it.

**What already works.** The field **type** checks and lays out: a field typed
`fn (int) -> int` maps to `{i8*, i8*}` via `type_mapping.sfn:440-441`, so the
struct's LLVM layout already reserves the closure-pair slot. The gap is purely
**population** and **field-dispatch**:

- **Population.** A struct literal `Router { handler: <fn-or-closure-value> }`
  must store a `{i8*, i8*}` pair into the `handler` field. The right-hand side is
  produced by item 1 (named function → pair) or by the existing lambda lowering
  (closure → pair). The struct-initializer emission must accept a closure-pair
  operand for a `fn(...)`-typed field with **no coercion** (mirroring the
  slot-0 bypass at `core_call_emission.sfn:111-114`) — the pair is already the
  field's representation. The aggregate→pointer boxing fallback in
  `core_operands.sfn:1290-1346` must **not** fire on a `{i8*, i8*}` field value
  (that path boxes a by-value aggregate into a heap `i8*`; a closure pair stored
  into a struct field is stored directly, not boxed).
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
`i8* ({i8*,i8*}-derived)*` parameter types from whatever the call-site operand
happens to be, and a by-value `{i8*, i64}` argument crossing an indirect call
needs the **callee's real ABI** (by-value aggregate passing / sret) to match —
which the call-site-derived signature does not guarantee. This is the **same
class of constraint** SFEP-0028 §3 identifies for array HOFs: the callback ABI is
fixed at pointer width, and typed/aggregate element shapes need either
**monomorphization** (specialize the body per concrete type, giving each the
*natural* ABI for its shape) or a **width-aware ABI** (explicit width/kind tags).

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

## 4. Effect & capability impact

**The seam is effect-agnostic, and that is correct.** A closure carries its
body's effects through the call: when a `fn (...) ![io]` value is dispatched, the
effect requirement is a property of the **closure's body**, enforced by
`effect_checker.sfn` at the lambda/function definition site and propagated to the
caller through the existing closure-call effect propagation (the same path that
already makes `closure_mixed_capture` and the array-HOF `![io]` lambda-as-param
cases type-check). The dispatch mechanics in `core_call_emission.sfn` do not
inspect or alter effects — they emit the indirect call; the effect contract is
established upstream in the checker.

Items 1–3 do **not** change this. A named-function value carries the named
function's declared effects; a fn-typed struct field carries the effect row of
its declared `fn (...) ![...]` type; dispatch through either propagates effects
identically to the v0 closure-param path. There is **no new capability surface**:
no new effect, no new way to escape an effect annotation. A function value cannot
launder effects — calling it requires the caller to satisfy the value's declared
effect row, exactly as a direct call would. The one thing to verify during
implementation (not change): that the narrowed #1147 guard does not let a
function reference *drop* its effect annotation when materialized as a value —
the `fn(...)` annotation that the field/param/let carries must include the effect
row, and the checker must unify against it.

## 5. Self-hosting impact

Passes touched, in pipeline order:

- **Parser** — **no change.** `fn(...)` / `fn (...)` annotations already parse
  (#688, `parser_function_types_test.sfn`); bare identifiers and member-access
  call targets already parse. No new syntax.
- **AST** — **no change.** Function-value references are existing identifier /
  member-access nodes; closure values are existing lambda nodes.
- **Typecheck** (`typecheck_types.sfn`) — **narrow the #1147 guard**
  (`check_fn_reference_raw` `:1785-1841`, `make_fn_value_position_diagnostic`
  `:1733`) to accept a named function in `fn(...)`-value position by consulting
  the expected type, while still rejecting generic functions, `& fn`, and
  non-`* u8` casts. Add the non-pointer-width-signature diagnostic for item 4.
- **Effect checker** — **no change** (§4); verify, don't modify.
- **Emitter / LLVM lowering** —
  - *Item 1:* materialize a named function as `{fn_ptr, null-env}` and dispatch
    via the env-less indirect-call path (`plain_fn_ptr_call` shape) — reuse, no
    new IR shape.
  - *Item 3:* generalize `try_resolve_closure_callee`
    (`core_call_resolution.sfn:358-376`) to recognize a member-access call
    target whose field maps to `{i8*, i8*}`; teach struct-literal emission to
    store a closure pair into a `fn(...)` field without firing the
    `core_operands.sfn:1290-1346` boxing fallback.
  - The **dispatch seam itself** (`core_call_emission.sfn:386-504`) does **not
    change** — it stays the single place closures dispatch.
- **Runtime** — **no change.** Unlike SFEP-0028, this feature touches no
  `runtime/sfn/array.sfn` body; it is purely a frontend/lowering capability.

**Self-hosting invariant + seed dependency.** Named-fn-value lowering and the
narrowed guard are **compiler-source capabilities**: a consumer that writes
`apply(worker, 5)` or a fn-typed struct field cannot self-host until that
capability is in the **pinned seed**. Per `.claude/rules/seed-dependency.md`, the
default is **bundle the capability with its single consumer in one PR**, so
`make compile` builds the new compiler from the old seed and that compiler
compiles the consumer in the same pass — **no seed cut, no `/pin-seed`**. The
named consumer here is **#1172** (the test runner's named-fn + closure callback
table). Concretely:

- Items 1 + 3 (the new capabilities) should land **bundled with #1172's
  adoption** of them in one PR where feasible, per the seed-dependency rule —
  this avoids manufacturing a seed-cut gate between "capability" and "the test
  runner that uses it."
- If grooming splits a capability away from #1172 (e.g. because item 1 and item 3
  are large enough to ship independently, or because #1172 lands in stages), the
  capability PR carries `seed-blocker`, #1172 carries `## Required in pinned
  seed: #<capability>`, and the seed advance **queues against the next cadence
  bump** — it does not trigger a reactive cut.

The compiler does **not** currently use named-fn-as-value or fn-typed struct
fields in its own source (it uses the `<fn> as * u8` C-ABI form for concurrency
trampolines, which is unchanged), so landing items 1/3 incrementally does not
regress the existing self-host.

## 6. Alternatives considered

- **Keep `<fn> as * u8`-only forever (status quo).** Rejected: it permanently
  forces the test runner (#1172) and every future callback-table consumer to
  wrap named functions in trivial forwarding lambdas, and it leaves "function as
  a value" — a baseline expectation for any language — unsupported. The C-ABI
  cast is a code-pointer escape hatch, not a callable `fn(...)` value.
- **Fat pointer instead of the `{fn_ptr, env}` pair.** Rejected: the
  `{i8*, i8*}` pair is already the shipped, self-hosting closure representation
  (`type_mapping.sfn:440`, `closures.sfn`), already dispatched by the one seam,
  and already proven across captures of mixed shapes. Introducing a different
  fat-pointer encoding would fork the representation and re-implement the seam
  for no gain. The whole design leans on **one** representation.
- **Trampoline-per-named-function (1b) as the primary path.** Rejected as the
  default in favor of (1a): the env-less indirect call already exists
  (`plain_fn_ptr_call`), so a named-fn value composes two shipped paths rather
  than minting an adapter function (and an extra call frame) per reference.
  (1b) is kept as the documented fallback if static-null env discrimination is
  fragile.
- **Require explicit closure-construction syntax** (e.g. `closure(worker)` to
  lift a named function to a value). Rejected: it violates "boring syntax wins"
  — TypeScript/Rust/Python all let a bare function name be a value with no
  ceremony, and LLMs (per the AI-agents-are-users principle) expect that. The
  conversion should be implicit at a `fn(...)`-typed use site, driven by the
  expected type, not a keyword.
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
*new* surface (items 1/3/4):

- [ ] Parses (no new syntax — `fn(...)` annotations and member-access calls
      already parse; this is a no-op box, listed for completeness)
- [ ] Type-checks / effect-checks (narrowed #1147 guard + expected-type-driven
      named-fn-value acceptance; non-pointer-width diagnostic)
- [ ] Emits valid `.sfn-asm`
- [ ] Lowers to LLVM IR (named-fn → `{fn_ptr, null}`; struct-field load → seam)
- [ ] Regression coverage (§8)
- [ ] Self-hosts
- [ ] `sfn fmt --check` clean
- [ ] Documented in `docs/status.md` + spec (function-value section; mark the
      non-pointer-width signature gate as pending generics)

(Item 2 — capturing closure as a general `fn(...)` param — is already
end-to-end and self-hosting via #1610; its boxes are effectively checked but it
is documented here as the baseline, not re-shipped.)

## 8. Test plan

E2e fixtures + tests mirroring the established
`compiler/tests/e2e/closure_capture_test.sfn` /
`compiler/tests/e2e/array_{map,filter,reduce}_closure_test.sfn` pattern (drive
the compiler-under-test as a subprocess with `process.run_capture`, assert on
captured stdout / emitted IR). One per item, each distinguishing the real
behavior from the current diagnostic:

- **Item 1 — named-fn-as-value.**
  `compiler/tests/e2e/fixtures/named_fn_value/main.sfn`: `fn worker(n: int) ->
  int { return n + 1; }` + `fn apply(cb: fn (int) -> int, x: int) -> int { return
  cb(x); }` + `print(apply(worker, 5))` → `6`. Companion IR assertion mirroring
  `plain_fn_ptr_call_test.sfn`: the materialized value bitcasts `@worker` to
  `i8*` and dispatches env-less (slot-1 `null`), and `sfn check` exits 0 (no
  `E0808`).
- **Item 3 — fn-typed struct field dispatch.**
  `compiler/tests/e2e/fixtures/fn_field_dispatch/main.sfn`: `struct Router {
  handler: fn (int) -> int; }` populated with **both** a named function and a
  capturing closure (two fixtures or two fields), then `r.handler(5)` dispatched
  → expected sums. Asserts the field-load engages the closure seam
  (`extractvalue {i8*, i8*}` present) and does **not** box the field
  (`core_operands.sfn` boxing fallback not fired).
- **Item 2 — regression pin (already shipped).** Keep the existing
  `closure_higher_order` / `closure_two_int_capture` / `closure_mixed_capture` /
  `closure_inferred_capture` cases green as the v0 baseline guard.
- **Item 4 — ABI boundary negative test.**
  `compiler/tests/e2e/fn_value_abi_boundary_test.sfn`: assert that a `fn(string)
  -> string` value (named or closure) used as a function value is **rejected
  with a diagnostic** (not miscompiled), so the non-pointer-width gate never
  silently mis-dispatches before generics land. Mirrors SFEP-0028's
  "diagnostic-not-mis-map" negative test.
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
  capturing closures as typed callbacks (the concrete blocked motivation).
- **#1142 / #1146** — `<fn> as * u8` C-ABI code-pointer address-taking (the only
  currently-blessed function-value form; unchanged by this SFEP).
- **#1147** — the `E0808`/`E0809` value-position guard
  (`typecheck_types.sfn:1729-1841`) that this SFEP narrows.
- **#1118** — runtime-callable closure application primitive (the foundation the
  seam is built on).
- **#1507 / #1508** — the closure-apply seam + pointer-width array
  `map`/`filter`/`reduce` bodies (the runtime-descriptor special case this
  SFEP's general path is distinguished from).
- **#688 / #689** — `fn(...)` type-annotation parsing and the original
  closure-callee dispatch (`closure_higher_order`).
- **SFEP-0012** (`Result<T, E>` + `?`) — shares the generic-constraint dependency.
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
  `compiler/src/typecheck_types.sfn:1729-1841` (the #1147 guard),
  `compiler/tests/e2e/plain_fn_ptr_call_test.sfn` (env-less indirect-call IR
  shape item 1 reuses),
  `compiler/tests/e2e/fixtures/closure_two_int_capture/main.sfn` (the #1610 v0
  baseline).
