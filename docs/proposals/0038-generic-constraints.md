---
sfep: 0038
title: Generic Type Parameter Constraints and Monomorphization
status: Implemented
type: language
created: 2026-07-01
updated: 2026-07-05
author: "agent:compiler-architect; human review"
tracking: "#1867, #1868, #1869, #1870, #1871, #1872"
supersedes:
superseded-by:
graduates-to: reference/preview/generics.md
---

# SFEP-0038 — Generic Type Parameter Constraints and Monomorphization

## 1. Summary

Sailfin already **parses** generic type-parameter bounds — `fn sort<T:
Comparable>(...)`, `struct Map<K: Hashable, V> {...}` — but the bound is inert:
it is stored on the AST node and thrown away. This SFEP makes bounds *mean*
something end-to-end. Two coupled mechanisms:

1. **Constraint enforcement (typecheck).** A bound `T: Comparable` is an
   **interface bound**. At every generic *instantiation site* (a call to a
   generic function, a use of a generic struct/enum/type-alias with concrete
   type arguments), the typechecker verifies each concrete type argument
   *implements* every bound interface, reusing the existing
   struct-implements-interface conformance machinery. A failure is a new
   diagnostic, `E0820`, with the bound and the offending type named.

2. **Monomorphization (lowering).** A generic function/struct is lowered by
   **generating one specialized copy per distinct concrete instantiation** —
   the same strategy Rust and Swift use, giving the zero-cost, statically
   dispatched performance the language positions for. This generalizes the
   *only* monomorphization precedent that already ships: enum-payload generics
   (#830), which specialize their payload layout per instantiation but were
   never lifted to functions or structs.

This SFEP is the **root foundation** for the generics work: it is the direct
predecessor of generic collections (`draft-generic-collections.md`), typed
higher-order array functions (SFEP-0028), `Result<T, E>` ergonomics
(`From<E>` / `E: Error` bounds, SFEP-0012), and `derive` (`draft-derive.md`).
None of those can be enforced or lowered soundly until bounds are checked and
generic bodies monomorphize.

## 2. Motivation

### 2.1 The gap is a shipped, unenforced safety surface

The bound already parses. `TypeParameter` carries it
([`compiler/src/ast.sfn:16-20`](../../compiler/src/ast.sfn#L16-L20)):

```sfn
struct TypeParameter {
    name: string;
    bound: TypeAnnotation?;   // parses today; nothing reads it
    span: SourceSpan?;
}
```

`parse_type_parameter_clause`
([`compiler/src/parser/declarations.sfn:313-381`](../../compiler/src/parser/declarations.sfn#L313-L381))
splits each slice on a top-level `:`, keeps the left as `name` and the right as
`bound`. It is shared verbatim by `fn`, `struct`, `interface`, and `type`
declarations (nine call sites in that file), so `T: Comparable` attaches
uniformly wherever a `<...>` clause is legal. The native IR even *parses past*
the bound already: `parse_enum_header_type_parameters`
([`compiler/src/native_ir_parser_defs.sfn:503-528`](../../compiler/src/native_ir_parser_defs.sfn#L503-L528))
explicitly strips `: Display` off `Foo<T : Display, E>` to recover the bare
name.

But `check_type_parameters`
([`compiler/src/typecheck_types.sfn:1556-1572`](../../compiler/src/typecheck_types.sfn#L1556-L1572))
does **exactly one thing**: reject duplicate parameter *names*. It never reads
`type_parameter.bound`. So today:

```sfn
interface Comparable { fn compare(other: Self) -> int; }

fn sort<T: Comparable>(items: T[]) -> T[] { ... }

struct NotComparable { x: int; }

// Compiles clean today. The bound `T: Comparable` is silently ignored,
// even though NotComparable does not implement Comparable. The body's
// `a.compare(b)` call then has no basis to lower.
let bad = sort([NotComparable { x: 1 }, NotComparable { x: 2 }]);
```

This is precisely the "parsed but not enforced" anti-pattern the project's
design framework forbids: a safety-shaped syntax that teaches users a guarantee
the compiler does not provide.

### 2.2 It is the foundation the whole 1.0 generics story stands on

`docs/status.md` records the blast radius directly:

- **line 191** — "Generic type inference: Partial — type params captured;
  coverage limited."
- **line 192** — "Generic type constraints: **Planned** — `fn sort<T:
  Comparable>`, real `Array<T>` / `HashMap<K, V>` / `Channel<T>`."
- **line 193** — `StrMap` (the concrete string→string map) is explicitly "the
  concrete-now bridge until generic `HashMap<K, V>` lands with the
  generic-constraints epic — it becomes a deprecated alias when generics ship."
- **line 186** — `Result<T, E>` ships, but "`From<E>` coercion and the `E:
  Error` bound gate on generic constraints."
- **SFEP-0028 §** — typed `float[]` / `string[]` / struct-array `.map` /
  `.filter` / `.reduce` are "gated on generic type constraints"; today only
  pointer-width `int[]` works because there is no way to monomorphize the
  element type.

Every one of those is blocked on the same two missing mechanisms: *check the
bound* and *specialize the body*. Shipping them one-off (as `StrMap` and the
`int[]`-only HOFs already are) accretes concrete stand-ins that must later be
retired. This SFEP is the shared root that lets them all be built generically
and soundly.

### 2.3 Monomorphization is required, not optional, for these consumers

A generic body cannot lower without knowing the concrete layout of `T`:

- A generic collection stores `T` by value → must know `sizeof(T)` and the
  element GEP stride (exactly the problem #830 solved for enum payloads, and
  the problem the typed-HOF work in SFEP-0028 is stuck on).
- A `T: Comparable` call `a.compare(b)` must resolve to the *concrete* method
  of the substituted type.
- `Result<T, E>` returning `?` must coerce `E` via `From<E>` for the concrete
  error type.

There is no lowering path today that does per-type body specialization for
functions or structs. #830 does it *only* for enum payload fields at match/
construct sites. This SFEP generalizes that machinery into a real
monomorphization pass.

## 3. Design

Four parts: (3.1) what a bound *is*, (3.2) how the typechecker enforces it,
(3.3) how bodies monomorphize, (3.4) the standard-library interfaces the bounds
name.

### 3.1 Bounds are interface bounds

A bound is a comma-free, `+`-separated list of **interface** type annotations:

```sfn
fn sort<T: Comparable>(items: T[]) -> T[] ![pure] { ... }
struct Map<K: Hashable + Eq, V> { ... }          // multiple bounds
type Pair<A: Display, B: Display> = { first: A, second: B };
interface Container<T: Eq> { fn has(x: T) -> bool; }
```

Grammar (an additive refinement of the *already-parsed* form — the parser
splits on `:` today; this adds `+` splitting on the bound side):

```
TypeParamClause := "<" TypeParam ("," TypeParam)* ">"
TypeParam       := Ident (":" BoundList)?
BoundList       := TypeRef ("+" TypeRef)*
TypeRef         := Ident TypeArgs?          // e.g. Comparable, From<ParseError>
```

Semantics:

- Each `TypeRef` in a `BoundList` names an **interface** (`interface Comparable
  { ... }`). Naming a non-interface (a struct, enum, or unknown name) is
  `E0821` ("bound must be an interface").
- A concrete type argument `C` **satisfies** bound `I` iff `C` implements `I`
  — i.e. `C` declares `implements I` and structurally conforms (the exact test
  already run by `check_struct_implements_interfaces`,
  [`typecheck_types.sfn:95-134`](../../compiler/src/typecheck_types.sfn#L95-L134)).
- Multiple bounds are conjunctive: `K: Hashable + Eq` requires `K` to implement
  **both**.
- Bounds are **not** transitive supertrait chains in v1 (an interface does not
  yet declare `interface Ord: Eq`). That is a deliberate deferral (§6) — v1
  bounds name only directly-required interfaces, matching what the conformance
  checker can already prove.

Type-parameter names in scope (`T`) satisfy a bound `I` iff the parameter's own
declared bound already includes `I` (bound propagation): inside `fn sort<T:
Comparable>`, `T` itself is treated as `Comparable`, so calling `helper<U:
Comparable>(x: U)` with a `T`-typed argument type-checks. This is what lets
generic bodies call other bounded generics.

### 3.2 Enforcement — the typecheck pass

Enforcement is added in `compiler/src/typecheck_types.sfn`, reusing the
interface-conformance surface that already lives there. Two new
responsibilities:

**(a) Validate bounds at *declaration* time.** Extend
`check_type_parameters` (currently duplicate-name only,
[`typecheck_types.sfn:1556-1572`](../../compiler/src/typecheck_types.sfn#L1556-L1572))
to take the interface table and, for each parameter with a non-null `bound`,
parse the bound into a `BoundList` (reuse `parse_type_arguments` /
`split_top_level_commas` already in this file; add a `+` splitter) and check
each named `TypeRef` resolves to an interface via `resolve_interface_annotation`
([`typecheck_types.sfn:136-149`](../../compiler/src/typecheck_types.sfn#L136-L149)).
An unresolved or non-interface name → `E0821`. This runs once per declaration;
it is cheap and needs no instantiation context.

**(b) Verify satisfaction at each *instantiation* site.** A new checker,
`check_generic_instantiation(callee_or_type, type_arguments, interfaces,
declared_params) -> Diagnostic[]`, runs wherever concrete type arguments meet a
declared bounded parameter:

- **Generic function calls.** When the typecheck call-resolution path binds a
  call to a generic `fn` declaration, it infers or reads the concrete type
  arguments (inference is already "Partial", status line 191 — this SFEP does
  not expand inference, it consumes whatever the existing binder produced, and
  falls back to explicit `sort::<Widget>(...)` turbofish when inference cannot
  resolve `T`). For each `(param, concrete_arg)` where `param.bound != null`,
  run the satisfaction test.
- **Generic type uses.** A `let m: Map<Widget, int> = ...`, a struct-literal
  `Map<Widget, int> { ... }`, and an `implements Container<Widget>` annotation
  each carry concrete arguments for a bounded declaration. Parse the arguments
  (`parse_type_arguments`, already used by
  `validate_interface_annotation`, [`typecheck_types.sfn:169-188`](../../compiler/src/typecheck_types.sfn#L169-L188)),
  zip against the declared `type_parameters`, and run the satisfaction test per
  bounded position.

The satisfaction test itself, `type_satisfies_bound(concrete: string, bound:
TypeRef, interfaces) -> bool`, is a thin wrapper over the existing conformance
logic:

1. If `concrete` is an in-scope type parameter, consult *its* declared bounds
   (bound propagation, §3.1).
2. Otherwise resolve `concrete` to its struct/enum declaration and ask whether
   it `implements` the bound interface — the same predicate
   `check_struct_implements_interfaces` computes, factored into a reusable
   `struct_implements(struct_decl, interface_name) -> bool`.

**Diagnostics** (new codes — `E0820`+ is the first free slot; the typecheck
band is E0801–E0819 today per `typecheck_types.sfn`, and ownership owns
E0901–E0907, so this SFEP claims **E0820–E0822**):

| Code | Condition | Message shape |
|---|---|---|
| `E0820` | Type argument does not satisfy a bound | `type ` + C + ` does not satisfy bound ` + I + ` on type parameter ` + name + ` of ` + decl (with a fix-it: "add `implements I` to `C`") |
| `E0821` | Bound names a non-interface / unknown type | `bound ` + I + ` on type parameter ` + name + ` is not an interface` |
| `E0822` | Type-argument arity mismatch against a *generic function* | mirrors the struct/interface arity diagnostics already at `typecheck_types.sfn:169-188`, extended to `fn` |

Worked failure:

```
error[E0820]: type NotComparable does not satisfy bound Comparable
  --> src/main.sfn:9:14
   |
 9 | let bad = sort([NotComparable { x: 1 }]);
   |           ^^^^ required by type parameter T of fn sort<T: Comparable>
   = help: add `implements Comparable` to `struct NotComparable` and a
           `compare(other: Self) -> int` method
```

### 3.3 Lowering — monomorphization

**Strategy: monomorphize.** For each *distinct* set of concrete type arguments
a generic declaration is instantiated with, emit one specialized copy with the
type parameters substituted by concrete types. This is the Rust/Swift model and
the systems-performance default the language is positioned for: no boxing, no
per-call indirection, `T`-typed values stored inline at their real width, and
`T: Comparable` method calls resolved to the concrete method at emit time (a
direct call, not a vtable dispatch).

**Generalize #830, don't reinvent it.** The enum-payload path already does the
hard part — recover declared type parameters from a header
(`parse_enum_header_type_parameters`,
[`native_ir_parser_defs.sfn:503-528`](../../compiler/src/native_ir_parser_defs.sfn#L503-L528)),
parse a concrete argument list angle-bracket-aware (`enum_inst_parse_args`,
[`llvm/type_mapping.sfn:164-203`](../../compiler/src/llvm/type_mapping.sfn#L164-L203)),
detect which fields reference a parameter
(`enum_inst_annotation_references_param`,
[`llvm/type_mapping.sfn:210+`](../../compiler/src/llvm/type_mapping.sfn#L210)),
and substitute per instantiation at match/construct sites. This SFEP lifts that
substitution engine from "enum payload fields at use sites" to "any generic
declaration body."

Pipeline shape:

1. **Instantiation collection (new pass, `compiler/src/llvm/monomorphize.sfn`).**
   After typecheck/effect-check, before native emit, walk the program and
   collect the set of concrete instantiations reached: `(decl_name,
   [concrete_args])` tuples for every generic `fn`/`struct`/`enum`/`type` use.
   Seed the worklist from non-generic (`@main`-reachable) code and close it
   transitively — a generic body instantiating another generic adds to the
   worklist (this is what handles `sort<T>` calling `helper<T>`). Deduplicate
   by a **mangled key** (below). This closure is finite because the language
   has no polymorphic recursion in v1 (§6 defers it, guarded by a
   depth/instantiation-count cap that raises a compiler-internal error rather
   than looping).

2. **Specialization.** For each collected instantiation, clone the declaration's
   `.sfn-asm` / native-IR body and substitute each type-parameter token with its
   concrete type — reusing the #830 substitution primitives, generalized to walk
   a whole function/struct body rather than a single payload field. The mangled
   name is `<base>$<arg1>$<arg2>...` (angle brackets and commas are not legal in
   LLVM symbol names, so a `$`-separated mangling mirrors how `channel:<kind>`
   already disambiguates monomorphized channel element kinds at
   [`core.sfn:807-813`](../../compiler/src/llvm/expression_lowering/native/core.sfn#L807)).
   A concrete-argument-free (non-generic) declaration keeps its bare name — zero
   change for the 99% of the compiler that is non-generic.

3. **Call/site rewriting.** Rewrite each generic call/construct site to target
   the mangled specialization. Bounded method calls (`a.compare(b)` where `a:
   T` and `T: Comparable`) resolve, in the specialized copy where `T = Widget`,
   to `Widget.compare` — a direct static call. This is the payoff of interface
   *bounds* (compile-time) versus interface *values* (the existing dynamic
   fat-pointer dispatch, which stays available for `let x: Comparable = ...`).

4. **Emit.** The specialized declarations flow through the *unchanged* native
   emitter and LLVM lowering as ordinary monomorphic declarations — because
   after substitution they *are* monomorphic. No new `.sfn-asm` opcodes; the IR
   is just more (specialized) functions/structs.

**Layout obligation.** A monomorphized struct/collection stores `T` inline at
its concrete width. The >8-byte by-value payload limitation noted for enums
(status line 168, "`>8-byte by-value payload layouts not yet emitted`") is a
*shared* constraint: v1 monomorphization covers pointer-width and pointer-typed
`T` (structs are boxed pointers already; `int`/`float`/`bool`/`string`/`ptr`
are pointer-width), which is exactly the set the existing channel/enum
monomorphization handles. Full arbitrary-width by-value aggregate `T` is
tracked as the same follow-up that gates enum payloads and typed HOFs (§9),
not re-solved here.

### 3.4 Standard-library interfaces

The bounds name interfaces that must exist in the prelude/std. This SFEP
introduces the minimal set the immediate consumers need; each is an ordinary
`interface` (no new language surface):

```sfn
interface Eq         { fn eq(other: Self) -> bool; }
interface Comparable { fn compare(other: Self) -> int; }   // <0 / 0 / >0
interface Hashable   { fn hash() -> int; }
interface Display    { fn to_string() -> string; }
interface From<T>    { fn from(value: T) -> Self; }         // enables From<E>
```

`From<T>` is the bound `Result` error coercion needs (SFEP-0012, status line
186): `?` on a `Result<T, E1>` inside a `-> Result<U, E2>` function is legal iff
`E2: From<E1>`, coercing via `E2.from(e1)`. That rule is *out of scope to
implement here* (it is SFEP-0012's follow-up), but this SFEP is its prerequisite
— it is what makes `E2: From<E1>` a checkable, monomorphizable bound.

`Comparable`/`Hashable`/`Eq` are what `draft-generic-collections.md`'s
`sort`/`HashMap<K: Hashable + Eq, V>` require. Providing them here (as inert
interface declarations) lets the collections SFEP be pure library code over
this foundation.

## 4. Effect & capability impact

**No new effects, no taxonomy change.** Bounds and monomorphization are a
type-system feature; the canonical six (`clock`, `gpu`, `io`, `model`, `net`,
`rand`, per SFEP-0017) are untouched, and `check_type_parameters` runs in
typecheck, strictly before the effect checker.

One interaction to specify: **effect transparency through specialization.** A
generic body carries its own declared effect row (`fn read_all<T>(...) ![io]`);
monomorphization clones the body verbatim, so each specialization inherits the
*same* effect annotation — specialization neither adds nor drops effects. The
effect checker runs on the *pre-monomorphization* generic declaration (once),
not per specialization, so effect diagnostics remain single-sited and the O(1)
effect-check cost does not multiply by instantiation count. A bounded method
call `a.compare(b)` is `![pure]` unless the interface method itself declares an
effect; the interface method's declared effects are the effects the caller must
already cover, exactly as for any ordinary method call. No capability-manifest
(`E0403`) interaction: bounds never widen a capsule's authorized surface.

## 5. Self-hosting impact

Passes touched, in pipeline order:

- **Lexer / parser** — *no change*. `<T: Comparable + Eq>` already tokenizes and
  parses; the only parser refinement is splitting the bound side on `+`
  (additive, inside `parse_type_parameter_clause`), which the current seed's
  parser produces as a single `bound_text` today and the new one splits. The
  old seed ignores `+` in a bound (it stores the whole text); so no source the
  compiler currently uses breaks.
- **AST** — *no change*. `TypeParameter.bound` already exists
  (`ast.sfn:16-20`); this SFEP reads it. No node shape change → the seed's
  positional GEP layout is stable.
- **Typecheck** — the substantive change: extend `check_type_parameters`,
  add `check_generic_instantiation` + `type_satisfies_bound` +
  `struct_implements`, add `E0820`–`E0822`. All within
  `typecheck_types.sfn`, reusing `resolve_interface_annotation` /
  `parse_type_arguments` already there.
- **Effect checker** — *no change* (§4).
- **Native emit** — consumes the new monomorphization pass's specialized
  declarations as ordinary monomorphic ones. No opcode change.
- **LLVM lowering** — new `compiler/src/llvm/monomorphize.sfn` (instantiation
  collection + specialization), generalizing the #830 substitution helpers in
  `llvm/type_mapping.sfn`. Downstream lowering is unchanged because specialized
  declarations are monomorphic.

**Self-hosting invariant.** The feature is **additive and non-self-referential
at first**: the compiler's own source does not yet use bounded generics or
generic collections, so the *old seed* compiles the *new compiler* fine (the new
typecheck logic is dead-but-correct until the compiler source opts in). Ordering:

1. Land constraint enforcement + monomorphization (this SFEP) — compiler source
   still uses no bounded generics, so it self-hosts under the old seed.
2. Cut a seed containing the new compiler.
3. *Then* consumer SFEPs (generic collections, typed HOFs) may use bounded
   generics in library/compiler code, self-hosting under the seed from step 2.

This is the standard additive-then-consume order. Because the *only* consumer
in this SFEP is the standard-library interface declarations (§3.4) — which are
inert `interface`s the old seed already parses — **no seed-cut gate is created
by this SFEP itself**; the gate is between this SFEP and its downstream
consumers, and is handled per `.claude/rules/seed-dependency.md` when those are
groomed (bundle each consumer with the compiler-source capability it needs, or
queue the cut).

## 6. Alternatives considered

**A. Dictionary passing / interface fat-pointers (the runtime-dispatch
alternative).** Sailfin already has interface *values*: a `let c: Comparable =
widget` is a `{data_ptr, vtable_ptr}` fat pointer with dynamic dispatch. A
generic `fn sort<T: Comparable>` could be compiled *once*, with `T` erased to a
fat pointer and `a.compare(b)` an indirect vtable call — Java/Go's model, and
Rust's `dyn Trait`. **Rejected as the default** because it defeats the language's
systems-performance positioning: every element access boxes, every method call
indirects, and `T`-typed collection storage can no longer be inline at native
width (it becomes a pointer, reintroducing exactly the layout indirection
monomorphization removes). It is, however, kept explicitly as a **fallback for
code-size / compile-time**: monomorphization's cost is code duplication and
longer builds (a real concern given the 60–90 min self-host, per
`docs/proposals/0006-build-architecture.md`). If instantiation-count blowup
becomes a build-time problem, a per-declaration `#[dyn]` opt-in (or a compiler
heuristic that shares a dictionary-passing copy for cold, non-perf-critical
generics) can be layered on *without* changing the bound semantics — the bound
is the same interface either way. Monomorphization is the default; dictionary
passing is the escape hatch, not the base case.

**B. Structural (duck-typed) bounds instead of interface bounds.** Let `T:
{ compare(T) -> int }` require a shape without a named interface. **Rejected** —
"boring syntax wins": named interface bounds match Rust/Swift/TypeScript
constraints and reuse the conformance machinery wholesale; structural bounds
would need a new subtyping engine for zero expressiveness gain over declaring
the interface.

**C. Enforce bounds but keep erasing (no monomorphization).** Check `T:
Comparable`, then compile the body once with `T` as an opaque pointer.
**Rejected** — this is alternative A's runtime cost without A's honesty about it,
and it still cannot lower inline `T`-width collection storage, so it does not
actually unblock `draft-generic-collections.md`. Enforcement without
specialization is a half-feature.

**D. Do nothing / keep concrete stand-ins (`StrMap`, `int[]`-only HOFs).**
**Rejected** — each stand-in is technical debt slated for removal (status line
193 names `StrMap` a future "deprecated alias"), and the count only grows
(`FloatMap`? `WidgetMap`?). This SFEP is the root that lets them be one generic
implementation.

## 7. Stage1 readiness mapping

- [x] **Parses** — already true (`parse_type_parameter_clause`); the only add is
  `+`-splitting the bound, an additive parser refinement.
- [x] **Type-checks / effect-checks** — `E0820`–`E0822` in `typecheck_types.sfn`
  (declaration-time validation #1868; instantiation-site satisfaction #1870). No
  effect-check change (§4).
- [x] **Emits valid `.sfn-asm`** — via monomorphization emitting specialized
  monomorphic declarations; no new opcodes.
- [x] **Lowers to LLVM IR** — `llvm/monomorphize.sfn` generalizing the #830
  substitution helpers; generic functions (#1869), generic structs with inline
  field layout (#1871), and bound interface-method resolution (#1872) lower
  through the unchanged backend.
- [x] **Regression coverage** — §8.
- [x] **Self-hosts** — additive, non-self-referential (§5); all sub-tracks
  merged to `main` under the pinned seed. Downstream-consumer enablement gates
  on the cadence seed cut carrying these lowering slices.
- [x] **`sfn fmt --check` clean** — on every touched `.sfn`.
- [x] **Documented** — `docs/status.md` generics-constraints row updated;
  `reference/preview/generics.md` (the `graduates-to` target) written.

Shipped end-to-end for the v1 scope (monomorphize-only, pointer-width `T`):
enforcement (`E0820`–`E0822`) **and** monomorphization (functions, structs,
bound method calls) both land and self-host. Arbitrary-width by-value aggregate
`T`, generic collections, and the dictionary-passing fallback remain deferred
(§3.3, §6) and are tracked as separate follow-ups; the cadence seed cut that
unblocks downstream consumers (#1866, SFEP-0028, generic collections,
SFEP-0012) is queued per `.claude/rules/seed-dependency.md`.

## 8. Test plan

`compiler/tests/unit/`:

- `generic_bound_satisfied_test.sfn` — `sort<T: Comparable>` over a type that
  `implements Comparable` type-checks clean.
- `generic_bound_violation_test.sfn` — `assert_does_not_compile` that a type
  missing the interface raises `E0820`, with the bound + type named.
- `generic_bound_not_interface_test.sfn` — `T: SomeStruct` raises `E0821`.
- `generic_multi_bound_test.sfn` — `K: Hashable + Eq` requires both; missing
  either raises `E0820` naming the specific unmet bound.
- `generic_bound_propagation_test.sfn` — inside `fn f<T: Comparable>`, calling
  `g<U: Comparable>(x: T)` type-checks (T satisfies its own bound); calling
  `h<U: Hashable>(x: T)` does **not**.
- `generic_arg_arity_fn_test.sfn` — `E0822` on `sort<int, int>` (arity 2 vs 1).

`compiler/tests/integration/`:

- `monomorphize_two_instantiations_test.sfn` — `id<T>(x: T)` called with `int`
  and `string` emits two distinct mangled specializations; snapshot the IR
  symbol names (`id$int`, `id$string`).
- `monomorphize_transitive_test.sfn` — `outer<T>` calling `inner<T>` closes the
  worklist so `inner$Widget` is emitted.

`compiler/tests/e2e/`:

- `generic_sort_run_test.sfn` — a `sort<T: Comparable>` over a `Widget[]`
  compiles to a binary and runs, producing correctly ordered output (proves the
  `a.compare(b)` bounded call resolved to the concrete method).
- `generic_pair_struct_run_test.sfn` — a `Pair<A: Display, B: Display>` struct
  instantiated at `<int, string>` builds and prints both fields (proves struct
  monomorphization + inline field layout).

Regression guard: the existing #830 enum-payload tests must stay green — the
generalized substitution engine must not change enum-payload behavior.

## 9. References

- **Gap sites (this tree):** `compiler/src/ast.sfn:16-20` (inert `bound`);
  `compiler/src/typecheck_types.sfn:1556-1572` (`check_type_parameters`,
  duplicate-name only) and `:95-149` / `:169-188` (conformance + arity machinery
  to reuse); `compiler/src/parser/declarations.sfn:313-381` (shared bound parse);
  `compiler/src/native_ir_parser_defs.sfn:503-528` and
  `compiler/src/llvm/type_mapping.sfn:139-203+` (the #830 substitution
  primitives to generalize).
- **Status:** `docs/status.md` lines 168 (enum-payload monomorphization, #830),
  186 (`Result` `From<E>`/`E: Error` gate), 191–193 (generic inference,
  constraints, `StrMap` bridge).
- **Related SFEPs (consumers — this SFEP is their predecessor):**
  `draft-generic-collections.md` (real `Array<T>` / `HashMap<K, V>` /
  `Channel<T>` — depends on this); SFEP-0028
  (`0028-typed-array-higher-order-fns.md`, typed `map`/`filter`/`reduce` —
  depends on this); SFEP-0012 (`0012-result-and-question-operator.md`, whose
  `From<E>` coercion and `E: Error` bound need this); `draft-derive.md`
  (structural `derive(Eq, Hashable, ...)` — generates the very `implements`
  clauses this SFEP checks bounds against).
- **Prior art:** Rust monomorphization + trait bounds; Swift generic
  specialization; the #830 enum-payload per-instantiation model as the in-tree
  precedent.
- **Build cost context:** `docs/proposals/0006-build-architecture.md` (why
  instantiation-count blowup is a real self-host-time risk, motivating the
  dictionary-passing fallback in §6-A).
- **Process:** `docs/proposals/0001-sfep-process.md`;
  `.claude/rules/selfhost-invariant.md`; `.claude/rules/seed-dependency.md`
  (bundle-vs-split for the downstream consumers).
