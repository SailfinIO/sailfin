---
sfep: TBD
title: Derivable Interface Implementations (@derive)
status: Draft
type: language
created: 2026-07-01
updated: 2026-07-01
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to: reference/preview/derive.md
---

# SFEP-XXXX — Derivable Interface Implementations (@derive)

## 1. Summary

Introduce `@derive(Eq, Hash, Debug, Clone, Ord)` as a **compiler-recognized
decorator** on `struct` and `enum` declarations. For each named derivable, the
compiler synthesizes the corresponding standard-library interface implementation
directly from the type's fields (structs) or variants-and-payloads (enums) — so
`@derive(Eq, Hash)` on a struct produces field-by-field `Eq` and `Hashable`
method bodies without the author writing them. The mechanism reuses the existing
`Decorator` AST node (`compiler/src/ast.sfn:284-292`), adds **no new syntax**, and
is not a macro system: a fixed, closed set of five derivables is expanded by a
dedicated post-typecheck pass into ordinary `MethodDeclaration`s before the
emitter runs. This is the feature that lets user-defined types satisfy the
`Eq` / `Hashable` / `Ord` bounds the generics-constraints and generic-collections
work depends on — the enabler that makes user types usable as `Map`/`Set` keys.

## 2. Motivation

Sailfin's object model is nominal `struct` / `enum` + `interface` with an explicit
`implements` clause; conformance is checked structurally against interface members
(`compiler/src/typecheck_types.sfn:95-134`) and interfaces lower to vtables
(`compiler/src/llvm/rendering_helpers.sfn:49-107`). To make a user type comparable,
hashable, cloneable, or printable today, the author must hand-write the entire
interface implementation — an `equals` method that compares every field, a `hash`
method that folds every field, a `clone` method that copies every field, and so on.

This boilerplate is:

- **The single largest metaprogramming gap.** Rust (`#[derive(Debug, Eq, Clone)]`)
  and Swift (`Equatable`/`Hashable`/`Codable` synthesis via macros) make these
  free; users arriving from those languages take structural `Eq`/`Hash`/`Debug`/
  `Clone`/`Ord` for granted. It is the #1 thing they reach for and do not find.
- **Error-prone.** A hand-written `hash` that forgets a field, or an `equals` that
  compares the wrong subset of fields, is a silent correctness bug — exactly the
  kind of hazard the `Hashable`/`Eq` contract exists to prevent.
- **A hard prerequisite for generic collections.** A `Map<K, V>` or `Set<K>` needs
  `K: Hashable + Eq`. Without derive, every key type must hand-roll both interfaces,
  which makes the ergonomic story for the generic collections work
  (`draft-generic-collections.md`) unacceptable. Derive is what turns "you may use
  any type as a key" from a promise into a one-line reality.
- **Repetitive in the compiler itself.** The compiler's own AST and IR structs are
  prime candidates for derived `Eq`/`Debug`/`Clone` once the feature lands (post-
  seed), reducing hand-maintained boilerplate in `ast.sfn` and `native_ir.sfn`.

There is no existing lever. There is no macro system, no `comptime`, no reflection,
and no derive anywhere in the tree. Decorators exist as an AST node but are almost
entirely **inert metadata** — `@policy`, for instance, is "Parsed only, no compiler
or runtime effect" (`docs/status.md:212`). This proposal gives a small, closed set
of decorator names real, enforced compiler meaning without opening the general
macro door.

## 3. Design

### 3.1 Surface syntax

`@derive(...)` is applied to a `struct` or `enum` declaration using the grammar the
parser already accepts for decorators-with-arguments
(`compiler/src/parser/declarations.sfn`, applied to structs and enums; the AST node
is `StructDeclaration.decorators` / `EnumDeclaration.decorators`,
`compiler/src/ast.sfn:373,394`):

```sfn
@derive(Eq, Hash, Debug, Clone)
struct Point {
    x: int;
    y: int;
}

@derive(Eq, Ord, Debug)
enum Color {
    Red,
    Green,
    Rgb { r: int; g: int; b: int },
}
```

Each argument to `@derive(...)` is a **bare identifier** naming a derivable. The
five recognized names, and the standard-library interface each generates an
implementation of:

| Derivable | Interface generated | Synthesized member(s) |
|---|---|---|
| `Eq` | `Eq` | `equals(other: Self) -> bool` |
| `Hash` | `Hashable` | `hash() -> int` |
| `Debug` | `Debug` (a.k.a. `Display` surface) | `debug() -> string` |
| `Clone` | `Clone` | `clone() -> Self` |
| `Ord` | `Ord` (a.k.a. `Comparable`) | `compare(other: Self) -> int` |

These are the **same interfaces** that `draft-generic-constraints.md` uses as
constraint bounds (`K: Hashable + Eq`, `T: Ord`). Derive is the primary means by
which a user type comes to satisfy those bounds. The interface names are owned by
that SFEP / the prelude; this proposal consumes them and must match their exact
member signatures (see §3.6). If the constraint SFEP has not fixed the final
interface names, this proposal tracks them — derivable-name → interface-name is a
lookup table in one place (`derive.sfn`, §3.3) and is trivially retargeted.

`@derive()` with no arguments is a no-op (warning: empty derive list, `W0710`). An
unrecognized name inside `@derive(...)` — e.g. `@derive(Serialize)` — is a hard
error `E0711` "`Serialize` is not a derivable interface (known: Eq, Hash, Debug,
Clone, Ord)". User-defined derivables are explicitly **out of scope** (§3.8), so
the set is closed and the error is exhaustive.

### 3.2 What each derivable generates

Semantics are **structural**, computed from the declaration the decorator sits on.

**Struct, over fields `f_1 .. f_n`:**

- **`Eq`** → `equals(other: Self) -> bool`: `self.f_1 == other.f_1 && … &&
  self.f_n == other.f_n`. Each field comparison uses `==` on the field type, which
  itself resolves to that field type's `Eq` (recursively derived or hand-written).
  Zero-field struct → `return true`.
- **`Hash`** → `hash() -> int`: a fold over field hashes, e.g. seeded FNV/`31*h + …`
  combine of `self.f_i.hash()` in field order. Zero-field struct → a fixed constant.
- **`Debug`** → `debug() -> string`: `"Point { x: " + self.x.debug() + ", y: " +
  self.y.debug() + " }"` — the type name, then `field: value` pairs in declaration
  order, delegating to each field's own `debug()`.
- **`Clone`** → `clone() -> Self`: construct a fresh `Self { f_1: self.f_1.clone(),
  … }`. For value/scalar fields `clone()` is identity; for owned/heap fields it is a
  deep field-wise clone (interacts with the ownership floor — see §4).
- **`Ord`** → `compare(other: Self) -> int`: lexicographic over fields in
  declaration order — compare `f_1`; if non-zero return it, else `f_2`, etc.;
  returns `<0 / 0 / >0`. Requires each field type to be `Ord` (`compare`-capable);
  a field type that is not `Ord` → `E0712` "cannot derive `Ord` for `Point`: field
  `x` of type `Widget` does not implement `Ord`". The analogous field-capability
  check applies to `Eq`/`Hash`/`Clone` (each field must itself satisfy the derived
  interface), reported as `E0712` with the offending field named.

**Enum, over variants `V_1 .. V_m`:**

- **`Eq`** → `equals`: variants equal iff same variant *and*, for payload-carrying
  variants, all payload fields pairwise equal (a `match` on `self` with a nested
  discriminant/payload check against `other`). Different variants → `false`.
- **`Hash`** → `hash`: combine the variant discriminant (its index) with the fold
  of payload-field hashes for that variant.
- **`Debug`** → `debug`: `"Red"` for a unit variant; `"Rgb { r: …, g: …, b: … }"`
  for a payload variant, delegating to payload-field `debug()`.
- **`Clone`** → `clone`: reconstruct the same variant with field-wise cloned
  payload.
- **`Ord`** → `compare`: first by variant declaration order (earlier variant <
  later); ties broken lexicographically over the shared variant's payload fields.

The enum forms are **variant-aware**: they pattern-match on the receiver (and the
argument, for binary operations) using the existing `MatchStatement` / `MatchCase`
AST (`compiler/src/ast.sfn:412`). No new expression forms are introduced — the
synthesized bodies are ordinary Sailfin the parser and typechecker already model.

### 3.3 Mechanism: a post-typecheck synthesis pass

The core mechanism is a **new pass, `derive_expand`, that runs after type checking
resolves fields and interfaces, and before the native emitter**. Placement in the
existing driver (`compiler/src/main.sfn`): typecheck runs (e.g.
`typecheck_has_errors_with_prelude` at `main.sfn:82,205,259`), and only if it is
clean does emission proceed (`emit_native_text_with_module_name`,
`main.sfn:217,271`). `derive_expand` is invoked on the `Program` **between those two
points** — after typecheck has confirmed the declaration is well-formed (fields
have known, resolved types; the type is not already implementing the target
interface in a conflicting way), and before `emit_native` walks the AST.

The pass is mechanically simple and lives in a new module
`compiler/src/derive.sfn`:

1. Walk every top-level `StructDeclaration` / `EnumDeclaration` in the `Program`.
2. For each, scan `decorators` for a decorator named `derive`
   (`decorator_names(...)`, `compiler/src/ast.sfn:294`). Skip declarations without
   one.
3. Parse the `@derive(...)` `arguments: DecoratorArgument[]` into a list of
   derivable identifiers. Validate each against the closed set (§3.1); emit
   `E0711` for unknowns and stop expanding that declaration.
4. For each valid derivable, run the derivable-name → interface-name lookup, then
   check the type does not already declare a method of the target member name in
   `methods` (structs) — if it does, that is a conflict (`E0713` "`Point` both
   derives and hand-implements `equals`"; the author should drop one). This
   prevents silent shadowing.
5. **Field-capability check** (§3.2): confirm each field/payload type satisfies the
   derived interface. This uses the same resolved type information the typechecker
   already computed; failures are `E0712`.
6. **Synthesize** a `MethodDeclaration` per derivable (structural body per §3.2),
   pushing it onto the declaration's `methods` list, and add the target interface
   to `implements_types` if not already present so the vtable/conformance machinery
   picks it up. For enums (which have no `methods`/`implements_types` field today —
   `EnumDeclaration`, `compiler/src/ast.sfn:389-395`), see §3.4.

After `derive_expand`, the rest of the pipeline sees **ordinary methods and an
ordinary `implements` clause**. The emitter (`emit_native.sfn`), LLVM lowering
(`llvm/lowering/entrypoints.sfn`), vtable rendering
(`rendering_helpers.sfn:49-107`), and conformance checking all operate unchanged —
they never learn that these methods were synthesized. This is the key design
choice: **derive is desugaring, not a codegen special case.** The blast radius is
one new pass plus the AST hooks it writes into; emit and lowering are untouched.

Because the synthesized methods are plain AST, they are also **re-typechecked in
place** is unnecessary (typecheck already ran), but the synthesis must produce
well-typed AST by construction. To keep this honest, `derive_expand` re-runs the
narrow conformance/signature check on each synthesized method (§3.6) rather than
trusting itself blindly — cheap, and it catches a synthesis bug as a compiler
diagnostic instead of malformed IR.

### 3.4 Enums: methods and conformance

`EnumDeclaration` today has no `methods` or `implements_types` fields
(`compiler/src/ast.sfn:389-395`), whereas `StructDeclaration` has both
(`ast.sfn:366-374`). Enums cannot currently carry method implementations or an
`implements` clause. Two options:

- **(A) Extend `EnumDeclaration`** with `methods: MethodDeclaration[]` and
  `implements_types: TypeAnnotation[]`, mirroring `StructDeclaration`. This is the
  clean, general answer and is almost certainly wanted independently (users will
  expect enums to implement interfaces). But it is a **`EnumDeclaration` AST layout
  change**, which is seed-layout-sensitive (a released seed may treat the node with
  a fixed shape). It must therefore land additively and be seed-gated before the
  compiler *uses* enum methods in its own source.
- **(B) Lower enum derivables to free functions** (`Color_equals(self, other)`,
  dispatched without a vtable) for the initial ship, deferring enum interface
  conformance until (A) lands.

**Decision: (A), staged.** Extending `EnumDeclaration` is the correct model and
unblocks user-defined enum interface impls generally, not just derive. It lands as
an additive AST change in its own step (new fields default-empty; the old seed
never populates them, so it round-trips), the seed is cut, and only then does the
enum-derive path populate them. Until that seed is pinned, `@derive` on an enum is a
diagnostic `E0714` "deriving on enums requires a newer compiler" — an honest gate,
not a half-feature (per "don't ship unfinished safety claims"). Struct derive ships
first and does not wait on this.

### 3.5 Effect: derived methods are pure

Every synthesized method (`equals`, `hash`, `debug`, `clone`, `compare`) is `![pure]`
— structural comparison/hashing/cloning/formatting performs no `io`/`net`/etc. The
synthesizer stamps the empty/`pure` effect set on the generated `FunctionSignature`
(`effects: []`). See §4.

### 3.6 Conformance to signature-checked interfaces

`draft-interface-signature-conformance.md` tightens `implements` conformance from
"a method of the right *name* exists" (today's check,
`typecheck_types.sfn:121-128`, which only tests `contains_string(method_names,
member.name)`) to a full **signature** match (parameter and return types). Derived
methods **must pass that stricter check.** This is a constraint on the synthesizer,
not a problem: the synthesizer knows the exact interface member signature it is
targeting (it looked the interface up in §3.3 step 4), so it emits a
`FunctionSignature` that matches by construction — same parameter names/types, same
return type, same effect set.

Concretely, the ordering is:

1. This SFEP's synthesizer generates methods that match the *current* interface
   member signatures.
2. When signature-checked conformance lands, the derived methods already match
   (they were generated from the signature), so they pass with no change.

To avoid drift, `derive_expand` reuses the interface member's own
`FunctionSignature` as the template for the synthesized method's signature
(copying parameter/return annotations from the interface definition, filling in the
body), rather than reconstructing the signature independently. That guarantees the
derived signature is *definitionally* the interface signature. The two SFEPs are
mutually reinforcing: signature-checked conformance is what makes "derived impls are
correct" a checked property rather than a hopeful one.

### 3.7 Worked expansion (illustrative)

```sfn
@derive(Eq, Debug)
struct Point { x: int; y: int; }
```

expands (conceptually, before emit) to:

```sfn
struct Point implements Eq, Debug {
    x: int;
    y: int;

    fn equals(other: Point) -> bool ![pure] {
        return self.x == other.x && self.y == other.y;
    }

    fn debug() -> string ![pure] {
        return "Point { x: " + self.x.debug() + ", y: " + self.y.debug() + " }";
    }
}
```

The right-hand side is entirely ordinary Sailfin. Nothing downstream of
`derive_expand` distinguishes it from a hand-written impl.

### 3.8 Explicitly out of scope for 1.0

- **User-defined derive macros.** Only the five built-in derivables are recognized;
  the set is closed and hardcoded in `derive.sfn`. A general "define your own
  `@derive(Foo)`" mechanism is a macro system, which is explicitly deferred to
  post-1.0 and would get its own SFEP. This keeps the feature **bounded and
  non-macro**: it is table-driven desugaring of five known names, not a
  metaprogramming facility.
- **Field-level attributes** (`@derive`-skip a field, custom hash for a field, etc.)
  — post-1.0.
- **`Serialize`/`Deserialize`/`Codable`-style derives** — depend on a serialization
  library surface that does not exist; post-1.0.
- **Recursive-type cycle handling for `Debug`/`Hash`** beyond what the structural
  fold naturally gives — a self-referential type (a struct containing itself through
  a pointer) will produce infinite recursion in `debug`/`hash`; the initial ship
  detects a **direct** self-referential derivable field and errors (`E0715`) rather
  than emitting non-terminating code. Indirect cycles are documented as a known
  limitation.

## 4. Effect & capability impact

Minimal and deliberately so. Every synthesized method is `![pure]`:
structural equality, hashing, comparison, and formatting are pure computations, and
field-wise `clone` is pure by the same argument the runtime's owned-buffer clone is
pure. The synthesizer stamps `effects: []` on each generated `FunctionSignature`, so
no capability is granted or required by deriving. A type that derives `Debug` does
**not** thereby gain `![io]` — `debug()` returns a `string`; it is the *caller* who
prints it that needs `io`. This keeps derive out of the effect-system surface
entirely: it is a code-synthesis convenience, not a capability.

One interaction worth stating: **`Clone` and the ownership floor.** The native
runtime enforces a unique-ownership / no-aliased-mutation memory-safety floor
(`ownership_checker.sfn`, epic #1209). Derived `clone` produces a genuinely
independent copy (field-wise deep clone for owned fields), which is exactly what the
ownership model wants — `clone` is the sanctioned way to get a second owned value,
so derived `Clone` is *aligned with* the floor, not in tension with it. The
synthesizer must emit field clones that go through each field type's own `clone`
(recursively), never a shallow aliasing copy, so a derived `clone` never
manufactures an aliased mutable owner. The field-capability check (§3.2) guarantees
every field is itself `Clone` before `clone` is synthesized.

## 5. Self-hosting impact

**Passes changed:** exactly one new pass (`derive_expand`) is inserted into the
driver between typecheck and emit; a small AST extension for enums (§3.4). The
lexer, parser, effect checker, native emitter, and LLVM lowering are **unchanged** —
they see synthesized methods as ordinary methods.

- **Parser / AST:** `@derive(Eq, ...)` already parses today (decorators-with-args on
  structs/enums, `parser/declarations.sfn`; `Decorator`/`DecoratorArgument`,
  `ast.sfn:284-292`). No parser change for structs. The only AST change is the
  additive `EnumDeclaration` extension (§3.4), which round-trips through an old seed
  because the new fields default empty and the old seed never populates them.
- **Typecheck:** `derive_expand` runs *after* typecheck, so typecheck is not
  modified for the mechanism. (The field-capability and conflict diagnostics
  E0711–E0715 live in `derive.sfn`, not `typecheck.sfn`.) When signature-checked
  conformance (`draft-interface-signature-conformance.md`) lands, derived methods
  pass it by construction (§3.6).
- **Self-hosting invariant.** The compiler source **does not use `@derive` on
  itself** in the initial ship — the feature lands additively and the compiler's own
  AST/IR structs keep their hand-written (or absent) impls until a seed containing
  `derive_expand` is pinned. This decouples self-hosting from the feature exactly as
  SFEP-0023 decouples decorators: `make compile` builds the new compiler from the
  old seed (which never sees `@derive` because the compiler source doesn't use it),
  and the new compiler then expands `@derive` for *user* code. Only after the
  `derive_expand`-containing seed is pinned may the compiler dogfood `@derive` on its
  own structs — a separate, later step, and one that requires the struct-derive path
  first, then the enum extension seed for any enum use.
- **Seed-dependency (per `.claude/rules/seed-dependency.md`).** The `derive_expand`
  capability and its first *external* consumer (a test fixture / user code) are
  bundled in one PR — `make compile` builds the new compiler from the old seed and
  that compiler compiles the fixture in the same pass, so **no seed cut is needed to
  ship the feature.** A seed cut is only needed for the compiler to *dogfood* derive
  on its own source (and, separately, for the enum-methods AST extension before enum
  derive is used in-tree) — both queued against the cadence, not reactive.

## 6. Alternatives considered

- **A general macro / `comptime` system.** Deriving is the textbook motivating case
  for compile-time metaprogramming. Rejected for 1.0: a macro system is a large,
  open-ended language surface with its own hygiene, phasing, and effect questions,
  and it dilutes the three pillars. The five built-in derivables cover the
  overwhelming majority of real demand as **closed, table-driven desugaring** with a
  tiny surface. A macro system can come later and subsume `@derive` as a built-in
  set without breaking this design.
- **Reflection at runtime** (a runtime `TypeInfo` that `equals`/`hash`/`debug`
  consult generically). Rejected: it defeats static dispatch (interfaces lower to
  vtables today), imposes a runtime metadata cost on every type, and pushes what can
  be a compile-time correctness guarantee into runtime. Derive-as-desugaring keeps
  everything static and monomorphic.
- **A new keyword (`derive Eq for Point { }` or `deriving`).** Rejected per
  "libraries/markers over keywords" and "boring syntax wins": a keyword can never
  become an identifier, and the decorator grammar already expresses "attach
  compiler-recognized metadata to a declaration." `@derive(...)` reads like Rust's
  `#[derive(...)]`, which is exactly the prior art users expect — the boring choice.
- **Special-casing derived types in the emitter / LLVM lowering** (synthesize IR
  directly, skipping AST). Rejected: it duplicates every codegen path for the derived
  case, is far harder to keep correct as the object model evolves, and bypasses the
  conformance checker. Expanding to AST before emit means one code path, checked by
  the existing machinery.
- **Making the built-in interfaces (`Eq`/`Hashable`/…) auto-implemented for all
  types** (implicit conformance, Go-style). Rejected: it conflicts with nominal
  `implements` conformance, makes "is this type hashable?" invisible at the
  declaration site, and would silently make every type a valid map key even when its
  fields are not hashable. Explicit `@derive` keeps the author's intent — and the
  field-capability check — at the declaration.

## 7. Stage1 readiness mapping

- [x] **Parses** — `@derive(Eq, ...)` on structs/enums parses today via the existing
  decorator-with-arguments grammar; no parser change for structs. (Enum AST
  extension in §3.4 is additive.)
- [ ] **Type-checks / effect-checks** — the new `derive_expand` pass runs after
  typecheck; synthesized methods are `![pure]` and pass conformance (and
  signature-checked conformance once it lands, §3.6). E0711–E0715 diagnostics.
- [ ] **Emits valid `.sfn-asm`** — synthesized `MethodDeclaration`s flow through
  `emit_native.sfn` as ordinary methods; no emitter change.
- [ ] **Lowers to LLVM IR** — ordinary methods + `implements` → existing vtable
  lowering (`rendering_helpers.sfn:49-107`); no lowering change.
- [ ] **Regression coverage** — §8.
- [ ] **Self-hosts** — feature lands additively; compiler source does not use
  `@derive` on itself until a `derive_expand`-containing seed is pinned (§5).
- [ ] **`sfn fmt --check` clean** — on the new `derive.sfn` and any touched files.
- [ ] **Documented** — `docs/status.md` (flip `@derive` from absent to shipped once
  enforced end-to-end) and `reference/preview/derive.md` → `reference/spec/` on ship.

## 8. Test plan

`compiler/tests/unit/`:

- **Parse/recognition:** `@derive(Eq, Hash, Debug, Clone, Ord)` on a struct is
  recognized; `@derive()` warns `W0710`; `@derive(Serialize)` errors `E0711`.
- **Struct `Eq`:** two `Point{1,2}` values compare equal; `Point{1,2}` vs
  `Point{1,3}` unequal; zero-field struct always equal.
- **Struct `Hash`:** equal values hash equal (the `Eq`/`Hash` contract);
  distinct-fielded values hash distinctly for a representative sample.
- **Struct `Ord`:** lexicographic ordering across fields; `compare` returns the
  sign of the first differing field.
- **Struct `Debug`/`Clone`:** `debug()` renders `Type { field: value, ... }`;
  `clone()` produces an independent, field-equal copy.
- **Enum forms:** `Eq`/`Hash`/`Ord`/`Debug`/`Clone` across unit and payload
  variants; different variants unequal; variant-declaration-order dominates `Ord`.
- **Field-capability errors:** `@derive(Ord)` on a struct with a non-`Ord` field →
  `E0712` naming the field; likewise `Eq`/`Hash`/`Clone`.
- **Conflict:** a struct that both `@derive(Eq)` and hand-writes `equals` → `E0713`.
- **Enum gate (pre-extension seed):** `@derive` on an enum → `E0714` until the
  §3.4 seed is pinned; after, the enum forms above.
- **Self-referential guard:** a directly self-referential derivable field → `E0715`.

`compiler/tests/integration/`:

- **Conformance:** a `@derive(Eq, Hash)` struct satisfies an `implements Eq,
  Hashable` requirement and passes signature-checked conformance
  (`draft-interface-signature-conformance.md`) with no hand-written method.

`compiler/tests/e2e/` (`*_test.sfn`, per `.claude/rules/no-bash-e2e.md`):

- **Map/Set key end-to-end:** compile and run a fixture that uses a `@derive(Eq,
  Hash)` struct as a `Map`/`Set` key (bundled with `draft-generic-collections.md`),
  asserting insert/lookup/dedup behavior — the payoff test proving derive enables
  keys. Thread `SAILFIN_TEST_SCRATCH`/`PATH` per the build-isolation rule.
- **Runtime behavior:** a fixture that prints `debug()`, clones, and compares
  derived values, asserting on captured stdout.

## 9. References

- **AST / current state:** `compiler/src/ast.sfn:284-292` (`Decorator` /
  `DecoratorArgument`), `:254-264` (`MethodDeclaration`, `EnumVariant`),
  `:366-395` (`StructDeclaration`, `EnumDeclaration`); `docs/status.md:212`
  (`@policy` "Parsed only, no compiler or runtime effect").
- **Conformance & vtables:** `compiler/src/typecheck_types.sfn:95-134`
  (`check_struct_implements_interfaces`); `compiler/src/llvm/rendering_helpers.sfn:49-107`
  (vtable type/constant rendering).
- **Pipeline placement:** `compiler/src/main.sfn:82,205,259` (typecheck gate) →
  `:217,271` (`emit_native_text_with_module_name`) — `derive_expand` inserts
  between.
- **Related SFEPs:** `draft-generic-constraints.md` (the interfaces `@derive`
  targets are the constraint bounds `K: Hashable + Eq`, `T: Ord`);
  `draft-generic-collections.md` (derived `Hash`/`Eq` → usable as `Map`/`Set`
  keys — the payoff consumer); `draft-interface-signature-conformance.md` (derived
  impls must pass signature-checked conformance, §3.6); **SFEP-0023**
  (`0023-capsule-decorators.md`) — contrast: those are *user-imported* decorators
  resolved to library functions; `@derive` is a *compiler-recognized*, closed-set
  decorator with no library resolution. Both share the "reuse the `Decorator` AST
  node, no new syntax" principle and both avoid editing the `Decorator` struct
  layout.
- **Rules:** `.claude/rules/seed-dependency.md` (bundle capability + consumer; no
  seed cut to ship, seed cut only to dogfood), `.claude/rules/selfhost-invariant.md`.
- **Prior art:** Rust `#[derive(Debug, Eq, Hash, Clone, PartialOrd)]`; Swift
  automatic `Equatable`/`Hashable` synthesis and the macro-based `Codable`.
