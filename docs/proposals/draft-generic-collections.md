---
sfep: TBD
title: Generic Collections — Map, Set, and Tuple
status: Draft
type: language
created: 2026-07-01
updated: 2026-07-06
author: "agent:compiler-architect; human review"
tracking: "#1941"
supersedes:
superseded-by:
graduates-to: reference/preview/collections.md
---

# SFEP-XXXX — Generic Collections — Map, Set, and Tuple

> Design record for the aggregate-collection gap: Sailfin ships arrays and a
> concrete `StrMap`, but has no generic `Map<K, V>`, no `Set<T>`, and no tuple
> type. See [`0001-sfep-process.md`](./0001-sfep-process.md) for the process.

## 1. Summary

Sailfin has exactly two aggregate literal shapes in the AST —
`Expression.Array{elements}` and `Expression.Object{fields}` /
`Expression.Struct{type_name, fields}` (`compiler/src/ast.sfn:75-77`) — and one
hash-map data structure, the concrete non-generic string→string `StrMap`
(`runtime/sfn/collections.sfn`; `docs/status.md:193`). There is **no** generic
`Map<K, V>`, **no** `Set<T>`, and **no** tuple type anywhere in the tree. This
is the single most glaring standard-library gap versus Go (`map`/slice
literals), Rust (`HashMap`/`HashSet`/tuples), TypeScript (`Map`/`Set`), and
Swift (`Dictionary`/`Set`/tuples). This SFEP designs three additions:
`Map<K: Hashable, V>` and `Set<T: Hashable>` as **library generic types backed
by compiler-known layouts** (the generalization of the `StrMap` precedent), and
tuples `(A, B, ...)` as a **language-level structural type** with literal
syntax, type syntax, and `.0` / `.1` positional access. Map and set are
monomorphized per instantiation exactly as the generics and typed-HOF work
prescribe; tuples get a dedicated AST node lowering to a fixed-layout struct.
`Map<string, string>` supersedes `StrMap`, which becomes a deprecated alias.

## 2. Motivation

Every non-trivial program needs keyed lookup, membership testing, and small
heterogeneous grouping. Today Sailfin offers none of these generically:

```sfn
// Keyed lookup — only string→string, via a bespoke import surface:
import { str_map_new, str_map_set, str_map_get } from "runtime/sfn/collections";
let m = str_map_new();
str_map_set(m, "ada", "1815");   // string keys and string values ONLY

// What every other language spells trivially, and Sailfin cannot express:
let counts: Map<string, int> = ...;   // no int-valued map
let seen: Set<int> = ...;             // no set at all
let pair: (int, string) = (1, "ada"); // no tuple type or literal
fn divmod(a: int, b: int) -> (int, int) { ... } // no multi-return via tuple
```

Who hits it: essentially everyone, and the compiler itself. The compiler
routinely wants a `Map<string, SomeNode>` (symbol tables, interned-string
tables, per-module caches) and today either falls back to `StrMap`
(string-valued only, so structured values get serialized) or hand-rolls
parallel arrays with linear scans. `StrMap` exists precisely as a documented
stopgap: its own header (`runtime/sfn/collections.sfn:5-7`) and
`docs/status.md:193` both say it "becomes a deprecated alias when generic
`HashMap<K, V>` lands with the generic-constraints epic." Tuples are the
missing lightweight product type: without them, multi-value return and ad-hoc
grouping force a named `struct` per call site, which is boilerplate the
structural pair-type removes.

The status quo is insufficient because the workarounds are not merely verbose —
they are lossy (`StrMap` stringifies non-string values), slow (parallel-array
maps are O(N) per lookup), and they leak an implementation-specific API surface
into every consumer instead of a uniform generic vocabulary.

## 3. Design

This SFEP consumes, and does **not** re-specify, the generic type-parameter
constraint system designed in `0038-generic-constraints.md` (the
`Hashable` / `Eq` bounds and the monomorphization pass). That constraint system
is a **hard dependency** (§7 dependencies): `Map<K, V>` and `Set<T>` cannot ship
until `<K: Hashable>` bounds are solvable and monomorphizable. Tuples do **not**
depend on generics and can land independently.

### 3.1 Tuples — language-level structural product type

Tuples are a structural, positionally-indexed, fixed-arity product type. They
are a language feature (not a library type) because their literal syntax, type
syntax, and positional field access must be understood by the parser, type
checker, and lowering directly.

**Type syntax:** `(A, B)`, `(A, B, C)`, … — a parenthesized, comma-separated
list of ≥ 2 type annotations. `(A)` is **not** a tuple; it is a parenthesized
type equal to `A` (matching Rust and Swift). The one-tuple is deliberately
unspellable to keep parenthesization unambiguous.

**Literal syntax:** `(a, b)`, `(a, b, c)`, … — a parenthesized, comma-separated
list of ≥ 2 expressions, **or** a single expression with a trailing comma
`(a,)`. This resolves the parser ambiguity with parenthesized grouping (below).

**Access:** `t.0`, `t.1`, … — a constant integer field selector. The index must
be an integer literal in bounds of the tuple's arity; a non-literal or
out-of-range index is a type error (`E09xx`, "tuple index must be a constant in
`0..arity`"). Tuples are **not** indexable with `t[i]` (that stays for arrays,
whose element type is uniform; tuples are heterogeneous so a runtime index has
no single result type).

**Parser ambiguity resolution.** The lexer already produces `(` … `)`; today
`(expr)` parses as a grouped expression. The disambiguation rule is purely
structural and requires **zero lookahead beyond the closing paren**:

- After parsing the first parenthesized expression, if the next token is `,`,
  it is a tuple; continue parsing comma-separated elements until `)`. Arity ≥ 2
  (or the single-element trailing-comma form `(a,)`) is therefore a tuple.
- If the closing `)` follows immediately (no comma), it is a grouped
  expression, unchanged.

The same rule applies in type position: `(A, B)` after the first type sees `,`
→ tuple type; `(A)` sees `)` → parenthesized type = `A`. This is the identical
rule Rust and Swift use and matches "boring syntax wins."

**AST.** Tuples need dedicated nodes; they cannot reuse `Array` (heterogeneous
element types, positional access) or `Object`/`Struct` (no field names). Per the
`ast.sfn` variant-slotting discipline (each field name occupies one union slot;
appended fields keep positional GEP indexing stable — see the `Assignment`
`rhs`-not-`value` note at `compiler/src/ast.sfn:159`), add a new expression
variant and a new member-access form:

```sfn
// in enum Expression, appended after existing variants:
Tuple { elements: Expression[], span: SourceSpan? },
// tuple positional access `t.0`; `index` is the constant selector.
// A distinct variant (not Member, whose `member` is a string name) so the
// typechecker/lowering read a numeric slot without string-parsing.
TupleIndex { object: Expression, index: int, span: SourceSpan? },
```

`elements` reuses the `Expression[]` slot already present on `Array` and `Call`
(`arguments`) etc.; because enum reads slot by field **name**, the new
`elements` on `Tuple` shares the existing `elements` name-slot with `Array` —
which is safe here because both are `Expression[]` with identical semantics
(they are never read from the same node). If sharing proves risky under the
seed's name-keyed GEP model, use a fresh name (`tuple_elements`) — the
implementer picks based on the `ast.sfn` slotting audit; the recommendation is
to reuse `elements` (same type, no collision) and fall back to `tuple_elements`
only if the audit shows a hazard. Tuple **types** ride the existing
`TypeAnnotation { text }` (`compiler/src/ast.sfn:12-14`) — the annotation text
is `"(A, B)"` and the type checker parses tuple structure from that text, the
same way it already parses `T[]` and generic `Foo<T>` from annotation text; no
new type-AST node is required.

**Lowering.** A tuple of arity N lowers to an **anonymous fixed-layout struct**
`{ T0, T1, …, T(N-1) }` — an LLVM literal struct type with the natural ABI of
each field. `Tuple` literal → `insertvalue`/`alloca`+`store` sequence exactly
as struct literals lower today; `TupleIndex{ i }` → `extractvalue`/GEP at
constant offset `i`. There is no runtime metadata and no boxing — tuples are
zero-overhead value types, identical in layout to an unnamed `struct`. Tuple
types are structurally equal iff arity and per-position types match.

### 3.2 `Map<K: Hashable, V>` and `Set<T: Hashable>` — library generic types

These are **library** types (defined in `runtime/sfn/collections.sfn`), generic
over their type parameters, backed by the same open-addressed hash-table layout
`StrMap` already uses (FNV-1a, linear probing, tombstone deletion, load-factor
resize — `runtime/sfn/collections.sfn:20-52`). The only differences from
`StrMap` are (1) the key/value arrays are `K[]` / `V[]` instead of `string[]`,
and (2) hashing and equality are dispatched through the `Hashable` / `Eq`
bounds from `0038-generic-constraints.md` instead of the hard-coded
`_fnv1a(string)`:

```sfn
struct Map<K: Hashable, V> {
    slot_state: int[];   // 0 empty | 1 live | 2 tombstone (as StrMap)
    slot_key: K[];
    slot_val: V[];
    cap: int; count: int; used: int;
}
struct Set<T: Hashable> {
    slot_state: int[];
    slot_elem: T[];
    cap: int; count: int; used: int;
}

fn map_new<K: Hashable, V>() -> Map<K, V> { ... }
fn map_set<K: Hashable, V>(m: Map<K, V>, key: K, value: V) -> Map<K, V> { ... }
fn map_get<K: Hashable, V>(m: Map<K, V>, key: K) -> V? { ... }
fn map_has<K: Hashable, V>(m: Map<K, V>, key: K) -> bool { ... }
fn map_delete<K: Hashable, V>(m: Map<K, V>, key: K) -> Map<K, V> { ... }
fn map_keys<K: Hashable, V>(m: Map<K, V>) -> K[] { ... }
fn map_len<K: Hashable, V>(m: Map<K, V>) -> int { ... }
// Set mirrors: set_new / set_add / set_has / set_delete / set_elems / set_len.
```

`Hashable` supplies `hash(self) -> int`; `Eq` supplies structural `==` for probe
comparison. For key types where the compiler can `derive(Hash, Eq)` (see
`draft-derive.md`), user structs become usable as keys for free; primitive keys
(`int`, `string`, `bool`) get built-in `Hashable`/`Eq` instances. `string`
keys reuse the existing `_fnv1a` mix; `int` keys hash by value-mix; struct keys
fold their derived field hashes.

**Higher-order methods.** `Map`/`Set` support `map` / `filter` / `reduce` /
`each` over their entries, consistent with SFEP-0028 (typed array HOFs): e.g.
`m.filter(fn (k, v) => v > 0)`, `s.map(fn (x) => x * 2)`. These are defined in
terms of the array HOFs over the live-slot projection, so they inherit
SFEP-0028's monomorphized closure-dispatch seam rather than introducing a new
one — this SFEP does not re-specify HOF lowering.

### 3.3 Literal syntax for maps and sets — collision resolution

The obvious `{ k: v, ... }` map literal **collides** with the existing
`Expression.Object { fields }` (`compiler/src/ast.sfn:76`), which already owns
`{ ... }` for anonymous-object / struct-shorthand literals. Overloading `{}` to
mean "map when keys are expressions, object when keys are identifiers" is a
context-sensitive parse that violates "boring syntax wins" and would make LLM
codegen error-prone (the CLAUDE.md "AI agents are users" principle). Three
options were weighed (§6); the **recommendation** is:

- **Map literal:** `[k: v, k2: v2]` — bracket-delimited, `key: value` pairs.
  This reuses the `[` … `]` bracket family (already the array-literal
  delimiter, so it reads as "keyed array"), and the `key: value` inner form is
  unambiguous because array elements are bare expressions while map entries
  carry a `:` separator. The empty map is `[:]` (a single colon disambiguates
  the empty map from the empty array `[]`), matching Swift's `[:]`.
- **Set literal:** there is no low-friction distinct bracket form that does not
  re-collide, so **sets have no dedicated literal**; construct via
  `Set.from([a, b, c])` / `set_from([a, b, c])` (an array → set constructor).
  A set literal is deferred (§10) rather than shipped with a syntax we would
  regret. This keeps the keyword/syntax budget honest ("keywords are
  expensive").

**Desugaring.** `[k: v, k2: v2]` desugars, in the parser, to a `Map` literal
AST node (a sibling of `Tuple`), which the typechecker resolves to a concrete
`Map<K, V>` from the unified key/value types and which lowering emits as a
sequence of `map_new` + `map_set` calls (or a bulk `_map_from_pairs` builder to
avoid intermediate reallocs). A dedicated AST node (not a raw call desugar in
the parser) keeps the literal's source span intact for diagnostics:

```sfn
// in enum Expression, appended:
MapLiteral { keys: Expression[], values: Expression[], span: SourceSpan? },
```

`keys`/`values` are parallel arrays (entry `i` is `keys[i]: values[i]`),
matching the runtime `slot_key`/`slot_val` layout and keeping both fresh
name-slots (no collision with `Object.fields`).

### 3.4 `StrMap` supersession and deprecation path

`Map<string, string>` is the exact generalization of `StrMap`. Once generics
land:

1. `StrMap` and its `str_map_*` free functions stay in
   `runtime/sfn/collections.sfn` as **deprecated aliases** — `str_map_new()`
   forwards to `map_new<string, string>()`, etc. — so existing consumers
   (including any compiler-internal use) keep compiling.
2. `docs/status.md:193` flips `StrMap` from "Shipped bridge" to "Deprecated
   alias of `Map<string, string>`."
3. Compiler-internal `StrMap` uses migrate to `Map<K, V>` opportunistically
   (e.g. a symbol table that wants `Map<string, Symbol>` instead of stringified
   values), tracked as follow-up issues, not as a big-bang rewrite.
4. The aliases are removed no earlier than one release after the deprecation is
   documented, and only once no compiler-source consumer remains (the
   self-host invariant forbids removing a symbol the pinned seed's compiler
   source still imports).

### 3.5 Monomorphization

Consistent with `0038-generic-constraints.md` and SFEP-0028: each concrete
`(K, V)` / `T` instantiation of `Map` / `Set` (and each generic collection
function) is **monomorphized** at the call site. The key/value arrays lower to
`K[]` / `V[]` with the element's natural width (using the `elem_size` already
threaded through the array allocator, per SFEP-0028 §3(A)); `hash`/`==` resolve
to the concrete `Hashable`/`Eq` instance for `K`/`T`. No boxing, no `any` slots.

### 3.6 Return-type-site instantiation for generic-struct static methods (#1941)

The monomorphizer SFEP-0038 v1 shipped infers a generic instantiation from
**argument** types. A static constructor like `List.new()` — or `Map.new()` /
`Set.new()` below — has no `T`-typed argument; the instantiation is knowable only
from the **expected type** at the call site (`let m: Map<K, V> = Map.new()`, a
parameter, or a return annotation). This is exactly Rust's turbofish-free
`let v: Vec<i32> = Vec::new()` inference. Extending the monomorphizer to take its
instantiation from the return-type site is therefore a **prerequisite substrate**
for the library collections here: without it, every collection constructor hits
the `core_call_emission.sfn` fail-closed fatal (`cannot resolve return type for
call to …`). It is proven end-to-end by the user-defined `List<T>` in
`examples/advanced/generic-structures.sfn` and tracked as **#1941** (a bounded
monomorphizer extension, not a general expression-type inferencer). The
collections API in §3.2 is pure library code once #1941 lands.

## 4. Effect & capability impact

None. `Map`, `Set`, and tuple construction/access are pure value operations
below the I/O layer, exactly like arrays and `StrMap` (which uses only structs,
arrays, and loops — `runtime/sfn/collections.sfn:8-11`). No collection operation
requires or grants a capability; `![io]` etc. attach only to adapters a caller
writes around these primitives. A user-supplied HOF callback (`m.filter(fn ...)`)
carries whatever effects its own body requires, propagated by the existing
effect checker through the closure call — unchanged by this SFEP. No new
capability surface.

## 5. Self-hosting impact

Passes touched, in pipeline order:

- **Lexer** (`lexer.sfn`): no new tokens. `(`, `)`, `,`, `[`, `]`, `:`, `.`,
  integer literals already exist. Tuple/map literals and `.0` access are new
  *token sequences*, not new tokens.
- **Parser** (`parser/`): (a) tuple literal / tuple type disambiguation
  (comma-after-first-element rule, §3.1); (b) `.<int>` postfix as `TupleIndex`
  distinct from `.<name>` `Member`; (c) `[k: v]` map literal and `[:]` empty
  map. All are **additive** — the old parser produced `Object`/grouped-expr for
  these token shapes; the new forms are only recognized where the old parser
  had no valid parse (a bare `(a, b)` in expression position was previously an
  error or a comma-operator that Sailfin does not have). This additivity is
  what preserves the self-host bootstrap: the pinned seed compiles the new
  compiler source, and the new compiler is the first to *emit* tuple/map
  literals — so the compiler source must not use tuples/maps until they are in
  the pinned seed (the standard capability-before-consumer discipline,
  `.claude/rules/seed-dependency.md`).
- **AST** (`ast.sfn`): add `Tuple`, `TupleIndex`, `MapLiteral` variants,
  appended per the GEP-stability convention (`compiler/src/ast.sfn:60`).
- **Typecheck** (`typecheck.sfn`): tuple structural typing + constant-index
  bounds checking; `Map`/`Set` generic-constraint solving (delegated to the
  `0038-generic-constraints.md` solver — this SFEP adds the `Hashable`/`Eq`
  requirement at map/set key positions, not the solver).
- **Effect checker** (`effect_checker.sfn`): recurse into `Tuple.elements`,
  `TupleIndex.object`, `MapLiteral.keys`/`.values` — mechanical, same pattern
  as `Array`.
- **Emitter / LLVM lowering** (`emit_native.sfn`, `llvm/lowering/`): tuple →
  anonymous struct (`insertvalue`/`extractvalue`); map literal → `map_new` +
  `map_set` sequence; monomorphized `Map`/`Set` bodies per instantiation.
- **Runtime** (`runtime/sfn/collections.sfn`): generic `Map`/`Set` structs and
  functions; `StrMap` demoted to aliases.

**Bundling.** Per `.claude/rules/seed-dependency.md`, the map/set *runtime
bodies* consume the generics/monomorphization *compiler capability*; they must
land bundled with that capability (or after it is in the pinned seed) so
`make compile` self-hosts in one pass. Tuples are self-contained (a language
feature with no runtime consumer) and can land as a standalone bundle: the
parser/AST/typecheck/lowering all move together, and the compiler source does
not use tuples until the tuple-capable compiler is the pinned seed. Whether to
split "tuples" from "map/set" is a grooming decision; the natural split is
**two bundles** — tuples first (no generics dependency), then map/set (gated on
`0038-generic-constraints.md`).

## 6. Alternatives considered

- **`{ k: v }` map literals (overload `Object`)** — rejected. It makes `{}`
  context-sensitive (object vs map depends on whether keys are identifiers or
  expressions), which is a fragile parse and a systematic LLM-codegen trap
  ("AI agents are users"). Swift/Rust both keep maps out of the brace-object
  syntax for the same reason.
- **`Map { ... }` constructor-call literal only, no bracket form** — viable and
  the most conservative (no new literal syntax at all), but it makes the
  single most common data structure verbose at every use site. Rejected as the
  *primary* spelling; `Set.from([...])` uses exactly this shape because sets are
  rarer and the collision-free bracket budget is spent on maps.
- **Set literal `{ a, b, c }`** — rejected: re-collides with `Object`/block and
  a bare `{a, b}` is genuinely ambiguous with a block of two expression
  statements. Deferred behind `Set.from`.
- **Tuples via `Struct`/`Object` with positional field names (`_0`, `_1`)** —
  rejected: it fakes positional access with string field names, loses the
  arity-in-the-type structural equality, and forces the typechecker to
  special-case magic names. A first-class `Tuple`/`TupleIndex` node is cleaner
  and lowers to the same struct anyway.
- **One-tuples `(A)` as tuples** — rejected: makes every parenthesized
  expression ambiguous; matching Rust/Swift, `(A)` is grouping and `(A,)` is the
  one-tuple (which we do not otherwise need).
- **Boxed/`any`-slot map values** — rejected for the same reasons SFEP-0028 §3(B)
  rejects boxing: allocation storm, the scalar-in-`any`-slot stringification
  hazard, and value-type unsoundness. Monomorphization is the principled answer.
- **Ship `Map`/`Set` before generic constraints (hand-written per-type)** —
  rejected: that is what `StrMap` already is, and multiplying it per key/value
  pair (`IntMap`, `StrIntMap`, …) is the combinatorial explosion generics
  exist to prevent.

## 7. Stage1 readiness mapping

Nothing here is built yet — this is a Draft design record. **Dependency:**
`0038-generic-constraints.md` must be Accepted-and-Implemented (the
`Hashable`/`Eq` bounds + monomorphization) before `Map`/`Set` can clear these
boxes; `draft-derive.md` (`Hash`/`Eq` derivation) makes user structs usable as
keys but is not strictly required for primitive-keyed maps. Tuples have no such
dependency and can clear the checklist independently.

- [ ] Parses (tuple literal/type, `.N` access, `[k: v]` / `[:]` map literal)
- [ ] Type-checks / effect-checks (tuple structural typing; `Hashable`/`Eq`
      key bounds via the constraints solver)
- [ ] Emits valid `.sfn-asm`
- [ ] Lowers to LLVM IR (tuple → anonymous struct; monomorphized `Map`/`Set`)
- [ ] Regression coverage (§8)
- [ ] Self-hosts (bundled with generics capability per §5)
- [ ] `sfn fmt --check` clean (formatter serializes tuples/maps canonically)
- [ ] Documented in `docs/status.md` + `reference/preview/collections.md`

## 8. Test plan

Unit (parser/typecheck) + e2e (`compiler/tests/{unit,integration,e2e}/`):

- **Tuple parse:** `(1, "a")` → `Tuple` node with two elements; `(1)` →
  grouped expr (not a tuple); `(1,)` → one-tuple; `(int, string)` in a
  parameter/return annotation → tuple type; `(int)` → parenthesized `int`.
- **Tuple typecheck:** `let t: (int, string) = (1, "a"); t.0 + 1` typechecks;
  `t.1 + 1` is a type error (string + int); `t.2` is out-of-range error;
  `t[0]` is rejected (tuples not index-subscriptable).
- **Tuple lowering (e2e):** a fixture returning `(int, int)` from `divmod`,
  destructured via `.0`/`.1`, printing the sum — proves the anonymous-struct
  lowering round-trips.
- **Map literal parse/typecheck:** `["ada": 1815, "grace": 1906]` infers
  `Map<string, int>`; `[:]` is the empty map; heterogeneous values
  (`["a": 1, "b": "x"]`) are a type error.
- **Map/Set runtime (e2e, gated on generics):** `Map<string, int>` insert /
  get / has / delete / len parity with the `StrMap` 10k-insert smoke test;
  `Set<int>` add/has/dedup; a `Map<StructKey, V>` using derived `Hash`/`Eq`.
- **`StrMap` alias:** the existing `str_map_*` tests still pass against the
  forwarding aliases (no regression for current consumers).
- **HOF over collections:** `m.filter(...)` / `s.map(...)` consistent with the
  SFEP-0028 fixtures.
- **Negative — key without `Hashable`:** a `Map<K, V>` where `K` lacks a
  `Hashable` instance is rejected with a constraint diagnostic.
- `make compile` self-hosts; `make check` triple-pass green.

## 9. References

- `0038-generic-constraints.md` — **hard dependency**: the `Hashable` / `Eq`
  bounds and monomorphization pass this SFEP consumes for `Map`/`Set` keys.
  This SFEP does not re-specify the constraint system.
- **SFEP-0028** (`0028-typed-array-higher-order-fns.md`) — typed / generic
  array HOFs; `Map`/`Set` `map`/`filter`/`reduce` reuse its monomorphized
  closure-dispatch seam.
- `draft-derive.md` — `Hash` / `Eq` derivation that makes user structs usable
  as map/set keys without hand-written instances.
- **SFEP-0012** (`0012-result-and-question-operator.md`) — shares the
  generic-constraint + monomorphization dependency; sequencing coordinates.
- `runtime/sfn/collections.sfn` — the `StrMap` precedent (open-addressed hash
  table) that `Map`/`Set` generalize; the deprecation target.
- `docs/status.md:192-193` — "Generic type constraints (Planned)" and the
  `StrMap` "deprecated alias when generic `HashMap<K, V>` lands" note this
  SFEP fulfills.
- `compiler/src/ast.sfn:75-77` — the existing `Array` / `Object` / `Struct`
  aggregate variants and (`:60`, `:159`) the variant field-slotting / GEP
  stability convention new nodes must follow.
