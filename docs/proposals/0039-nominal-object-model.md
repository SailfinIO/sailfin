---
sfep: 0039
title: Nominal Object Model — Honest Rejection of TypeScript-Shaped Data Syntax
status: Implemented
type: language
created: 2026-07-04
updated: 2026-07-24
author: "agent:compiler-architect; human review"
tracking: "#1860, #1887, #1888, #1838, #1855, #1900, #1904, #1905"
supersedes:
superseded-by:
graduates-to: reference/spec/06-types.md
---

# SFEP-0039 — Nominal Object Model — Honest Rejection of TypeScript-Shaped Data Syntax

> Design record for the object-model honesty fix tracked in #1860 (with the
> #1838 fixture and the #1855 concrete-struct path as context). This is a
> **correctness/soundness fix**, not a new feature: the front end today
> leniently *accepts* TypeScript-shaped data syntax the backend never
> implemented, then silently miscompiles it to `null`/`0`. The decision to
> commit to a nominal, Rust/Go-shaped object model for 1.0 is already made
> (repo owner); this SFEP records *how* to make the type system honest about it.

## 1. Summary

Sailfin's backend already ships a **nominal, Rust/Go-shaped object model**:
interfaces are method-only contracts, interface-typed values are `{i8*, i8*}`
trait objects dispatched through a vtable, and data field access is static-GEP
on concrete `struct` layouts. The front end, however, leniently *parses* three
TypeScript-shaped data constructs it never implemented and then lowers each to a
zeroed placeholder with at most a non-fatal diagnostic:

1. A **data-field-shaped interface member** (`interface Admin { isAdmin: boolean }`)
   is silently dropped by the interface member loop, leaving a zero-member
   interface.
2. A **bare object literal whose target type is not a concrete struct** (an
   interface, an intersection alias, or an un-inferable unannotated `let`) falls
   through literal lowering and stores the target's default: `store i8* null`,
   `store ... zeroinitializer`, or `store double 0.0`.
3. An **intersection type `A & B`** in value/type-annotation position is stored
   as raw text and never decomposed; used as a data type it resolves to `i8*`
   and stores `null`.

The result is a language that reads back empty strings and zeros for code that
type-checked clean (`sfn check` passes) — the worst failure mode, a silent
miscompile of syntax the language advertises by accepting.

This SFEP makes the type system **honest**: each of the three constructs becomes
a **compile-time diagnostic** (`E0827`, `E0828`, `E0829`) that names the
sanctioned path — data construction through a concrete `struct` (the path #1855
already fixed and which produces correct output today). `A & B` is **reserved**
in the grammar as generic trait-bound composition (`<T: A & B>`, whose full
enforcement is SFEP-0038's scope); it is a diagnostic only in *data* position,
not dropped from the parser. The `examples/advanced/unions.sfn` rewrite to a
concrete `struct` implementing method-only interfaces is the positive exemplar.

## 2. Motivation

### 2.1 The bug, precisely

The canonical reproduction is the current `examples/advanced/unions.sfn`:

```sfn
interface Admin { isAdmin: boolean; }   // field-shaped member — silently dropped
interface User  { name: string; }       // field-shaped member — silently dropped
type AdminUser = Admin & User;           // intersection — stored as raw text

fn main() ![io] {
    let admin: AdminUser = { name: "Alice", isAdmin: true };  // bare literal, non-struct target
    print("Admin: {{admin.name}}");                            // prints "Admin: " (empty)
}
```

Every stage accepts this. The interface member loop
(`parser/declarations.sfn`) requires `fn`; a field-shaped member makes
`parse_interface_member` return `success: false`, and the loop then
**silently `skip_struct_member`s it** — the interface ends with zero members and
no diagnostic. The alias RHS `Admin & User` is stored as
`TypeAnnotation { text: "Admin & User" }` and never decomposed. The bare literal,
annotated with an alias that resolves to an intersection, falls through
`lower_expression` to a non-fatal diagnostic and stores the resolved type's
default — here `i8* null`. `admin.name` then reads back empty. The third line
prints `Admin: ` and exits 0. `sfn check` is green throughout.

### 2.2 Why "reject" and not "implement"

The decision to commit to the nominal object model is fixed (see the header).
The alternative — building a structural/dynamic object model (a real
`sfn_mem_set_field`, dynamic field maps) — is explicitly *not* to be built:
`sfn_mem_get_field` (`runtime/sfn/memory/mem.sfn`) is a deliberate zeroed-safe-buffer
stub, there is no `sfn_mem_set_field` anywhere in the repo, and real field access
is the static GEP-replacement pass in `core_member_lowering.sfn`. A structural
model would dilute the nominal backend the compiler already self-hosts on and
contradict the pillar discipline (effects, capabilities, concurrency — not a
second object model).

The honest move under "**don't ship unfinished safety claims**" is to make the
front end reject what the backend does not implement, and point users at the one
path that works. `let admin: AdminUser = {...}` printing `Admin: ` is strictly
worse than a diagnostic — it teaches users the construct works.

### 2.3 Why now

The #1838 e2e fixture (`union_named_variant_match_probe.sfn`) deliberately
asserts only the `admin:` *prefix* — it pins an orthogonal field-name-global
regression and cannot assert the value because the value is wrong pending this
fix. Closing this SFEP lets that fixture assert `admin:Alice`, converting a
known-wrong-value carve-out into a real value assertion. The object model is
also a prerequisite the accepted language slate leans on:
`draft-interface-signature-conformance` (interfaces are method-only contracts
whose signatures are checked), SFEP-0034 (`x is T` narrows *nominal* types), and
SFEP-0038 (generic trait bounds — the reserved home for `A & B`).

## 3. Design

The nominal object model for 1.0 is stated as three rules, each enforced by one
diagnostic. All three fire in the **front end** (parser + typecheck) so
`sfn check` catches them — the whole point is to stop the silent miscompile that
`check` currently passes.

### 3.1 Rule 1 — interfaces are method-only contracts (`E0827`)

An interface member must be a method signature (`fn name(...) -> T`). A
data-field-shaped member (`name: Type`) is a diagnostic, not a silent skip.

```sfn
interface Named {
    isAdmin: boolean;          // E0827: interface members must be method signatures;
                               //        for data fields, declare a `struct`.
    fn name() -> string;       // OK — method-only contract
}
```

**Where it fires.** In the interface member loop in `parser/declarations.sfn`:
when `parse_interface_member` returns `success: false` **and** the pending
tokens have a field shape (an identifier followed by a type separator — `:`,
or the legacy `->`), emit `E0827` at the member's span and then continue error recovery
by skipping the member (do not cascade). The check is a bounded lookahead the
loop already has the position for; it replaces the unconditional
`skip_struct_member` on the failure path. A member that is neither a valid `fn`
nor a field shape (genuine garbage) keeps today's recovery behaviour.

**Message + fix-it.** `interface members must be method signatures` with a
fix-it: *"declare a `struct` with this field and have the struct implement the
interface."*

### 3.2 Rule 2 — bare object literals require a concrete `struct` target (`E0828`)

A bare `{ ... }` object literal is data construction. Its target type must
resolve to a **registered `struct`** — the only sanctioned data-construction path
(`resolve_struct_info_from_llvm_type` → `lower_struct_literal` → static
`insertvalue`, the #1855 path). A target that is an **interface**, or an
**un-inferable unannotated** binding, is a diagnostic. (An **intersection**
target is diagnosed by Rule 3, which takes precedence — see §3.4.)

```sfn
struct AdminUser { name: string; isAdmin: boolean; }

let ok:  AdminUser = { name: "Alice", isAdmin: true };  // OK — concrete struct target
let bad: Named     = { name: "Alice" };                 // E0828 — interface target
let huh            = { name: "Alice" };                 // E0828 — no inferable struct target
```

**Where it fires.** In typecheck, at the point where an object literal's
*expected type* is resolved (the `let`/parameter/field/return annotation
resolution, and the unannotated-inference path). If the resolved expected type
is not a registered `struct`:

- expected type is an interface (`%trait.<Name>`) → `E0828`, message names the
  interface and points at the concrete-struct path;
- expected type cannot be inferred to any concrete struct (unannotated `let`,
  no contextual struct) → `E0828`, message asks for a struct annotation.

This replaces the silent default-store fall-through
(`instructions_let.sfn` / `default_return_literal` in `expressions_helpers.sfn`)
with a hard typecheck error. Because it is a typecheck diagnostic, lowering is
never reached for the illegal case and the placeholder store is dead.

**Message + fix-it.** `object literal requires a concrete struct type; <T> is
not a struct` with a fix-it: *"declare a `struct` and annotate the binding with
it."*

**Coverage status: complete across value positions (closed by SFEP-0041).**
`E0828` shipped (#1899) at exactly one position — the `let` site
(`check_statement`'s `VariableDeclaration` branch). Three follow-up issues have since closed every other
residual position, via SFEP-0041's unified `TypeckCtx` expected-type /
typing-environment context threaded through both typecheck walk families
(statements and the lighter expression family lambda bodies use):

- [x] `let` site (#1899) — the original enforcement.
- [x] Array targets and generic-instantiation-head targets (#1900) — `let x:
      Named[] = { ... }` fires `E0828` regardless of the element type, and a
      generic instantiation target (`Iface<...>`) is classified by its base
      name rather than falling through unrejected.
- [x] Parameter-default initializers (#1900) — `fn f(p: Iface = { ... })` is
      classified against `parameter.type_annotation` the same way the `let`
      site is.
- [x] Return-position object literals (#1904) — `fn f() -> Iface { return {
      ... }; }` now has the enclosing function's declared return type threaded
      down through `check_block` → `check_statement` to the `ReturnStatement`
      branch, so it can call the classifier.
- [x] Lambda-body `let` and lambda-return object literals (#1905) — the
      lighter expression-family walk (`walk_expression` →
      `walk_block_expressions` → `walk_statement_expressions`) now carries
      `top_level` and an enclosing return type, so a lambda body's `let` and
      `return` positions run the same classifier as the top-level walk.

`E0828` is therefore enforced at **every** value position that can hold a bare
object literal — `let`, parameter defaults, return, and lambda-body/return —
with array and generic-instantiation-head target normalization applied
uniformly. The named-`struct` construction path (the `Struct` AST variant, the
#1855 path) remains exempt throughout. See SFEP-0041
(`docs/proposals/0041-typeck-expected-type-context.md`) for the `TypeckCtx`
mechanism; struct-field defaults, generic-instantiation arguments, and call
arguments remain open future consumers of that same channel, tracked
separately.

### 3.3 Rule 3 — `A & B` is not a data type (`E0829`); it is reserved for generic bounds

`A & B` **stays in the grammar**. In **value / type-annotation position** — a
variable, parameter, field, or return-type annotation, and the RHS of a `type`
alias resolved as a value type — an intersection is a hard typecheck error
`E0829`. It is **not decomposed** into a structural record of the two interfaces'
members. `A & B` is *reserved* for **generic trait-bound composition**
(`<T: A & B>`, "T implements both A and B"), whose full multi-bound enforcement
is SFEP-0038's scope, not this SFEP's.

```sfn
type AdminUser = Admin & User;          // E0829 at the alias definition
let x: Admin & User = get();            // E0829 at the annotation

fn describe<T: Admin & User>(v: T) {}   // reserved (generic bound) — SFEP-0038's scope,
                                        // NOT diagnosed by this SFEP
```

**The 1.0 rule, stated minimally and coherently.** An intersection annotation in
value/type-annotation position is rejected at typecheck with `E0829`; it is never
turned into fields. To fix it, the user (1) declares a concrete `struct` that
implements both interfaces and annotates with that struct, or (2) if they wanted
"a value satisfying both interfaces" in a generic context, writes the bound
`<T: A & B>` (SFEP-0038). The `type X = A & B` alias declaration is itself
flagged `E0829` at the *definition* (its RHS is an intersection resolved as a
value type), so the diagnostic points at the source of the intersection rather
than only at each use site.

**Where it fires.** In typecheck type resolution, at the single choke point where
a `TypeAnnotation` is resolved as a value type: if the annotation has a
top-level `&`, emit `E0829`. Two entry points feed this one helper — the `type`
alias declaration (resolve its stored RHS) and every value-position annotation
site (including one that resolves through an alias to an intersection). Bound
position (`TypeParameter.bound`) is *not* routed through this helper, so
`<T: A & B>` is untouched by `E0829` and left to SFEP-0038.

**Precedence with Rule 2.** `let admin: AdminUser = {...}` where `AdminUser` is
an intersection alias matches both the object-literal target check and the
intersection annotation check. **`E0829` (the intersection annotation) takes
precedence** — the annotation is fundamentally illegal regardless of the RHS
form. Rule 2's `E0828` is reserved for interface / un-inferable targets. This
precedence is fixed so tests are deterministic.

### 3.4 Field access is unchanged

This SFEP does not alter field access. Interface-typed values dispatch methods
through the vtable (already shipped; committed by
`draft-interface-signature-conformance`). **Data field access is only on
concrete structs** via the static GEP-replacement pass
(`core_member_lowering.sfn`). Because Rules 1–3 guarantee that any value whose
fields are accessed is a concrete struct (interfaces have no data fields;
object literals must target a struct; intersections cannot be a value type),
field access never reaches the zeroed `sfn_mem_get_field` stub for a
type-checked program.

### 3.5 The positive exemplar — `examples/advanced/unions.sfn`

The example is rewritten to the nominal idiom: method-only interfaces and a
concrete `struct` that implements them (the tagged-union `match` portion is
already nominal and unchanged).

```sfn
interface Named  { fn name() -> string; }
interface Scoped { fn is_admin() -> boolean; }

struct AdminUser {
    name: string;
    isAdmin: boolean;
}

impl AdminUser {
    fn name() -> string { return self.name; }
    fn is_admin() -> boolean { return self.isAdmin; }
}

fn main() ![io] {
    let admin: AdminUser = { name: "Alice", isAdmin: true };  // concrete struct — #1855 path
    print("Admin: {{admin.name}}");                            // prints "Admin: Alice"
}
```

The exact `impl`/method surface used in the exemplar is an implementation
detail of the rewrite issue; the load-bearing points are (a) interfaces carry
only method signatures and (b) the value is a concrete `struct` constructed
through the #1855 path, so `admin.name` reads back `Alice`. The #1838 fixture
(`union_named_variant_match_probe.sfn`) is migrated the same way, letting its
e2e test assert `admin:Alice` instead of only the `admin:` prefix.

### 3.6 Diagnostic codes allocated

The E08xx object/typecheck range is dense: `E0801`–`E0826` are in use or
pre-reserved (`E0824`–`E0825` reserved by drafts; `E0826` shipped —
SFEP-0030 bare function-type rejection). This SFEP claims the next three free
codes; none appear anywhere in `compiler/src`, `runtime`, or `docs/`:

| Code | Rule | Fires in |
|---|---|---|
| `E0827` | data-field-shaped interface member | parser (interface member loop) |
| `E0828` | object literal without a concrete `struct` target (interface / un-inferable) | typecheck (object-literal expected-type resolution) |
| `E0829` | `A & B` intersection in value/type-annotation position | typecheck (value-type annotation resolution) |

## 4. Effect & capability impact

None. All three diagnostics are pure parser/typecheck rejections with no effect
interaction: they add no effects, read no capabilities, and change no effect
inference. The effect checker is untouched. The rewritten example keeps its
existing `![io]` annotations.

## 5. Self-hosting impact

Passes touched: **parser** (`E0827` in the interface member loop) and
**typecheck** (`E0828`, `E0829`). No changes to the emitter or LLVM lowering —
the illegal cases never reach lowering once rejected, and the placeholder-store
fall-throughs become dead code for type-checked programs.

The change is **additive and stricter**, and the self-host invariant is
preserved by a **pre-flight audit**: before the enforcement lands, the tree
(`compiler/src`, `runtime`, `examples`, `compiler/tests`) is audited for the
three illegal idioms and any straggler is migrated to the nominal form. Because
the compiler's own interfaces are already method-only in the AST
(`InterfaceDeclaration.members: FunctionSignature[]`) and the compiler is written
in the sane subset, the audit is expected to find only the `unions.sfn` example
and the #1838 fixture. The self-host proof is exactly this: `make compile`
builds the new (stricter) compiler from the **old seed** (which accepts the
additive source), and the new first-pass compiler then re-compiles the compiler
source to produce seedcheck — which only succeeds if the compiler source is
clean of the now-rejected idioms. A clean seedcheck *is* the audit passing.

**No seed cut is required.** The diagnostics are compiler-source changes whose
only consumers are in-tree `assert_does_not_compile` tests and the migrated
example/fixture, all of which land in the same PR as the diagnostic that
enforces them. `make compile` builds the new compiler from the old seed and that
compiler compiles the consumers in one self-host pass (see the seed analysis in
the decomposition). Required-in-pinned-seed: none.

## 6. Alternatives considered

- **Build a structural/dynamic object model.** Implement `sfn_mem_set_field`,
  dynamic field maps, and structural intersection decomposition so the
  TypeScript-shaped syntax actually works. Rejected: it contradicts the fixed
  nominal decision, dilutes the three pillars with a second object model, and
  would be a large runtime + lowering build to make already-accepted syntax do
  what a `struct` already does correctly.
- **Leave the front end lenient, fix only lowering to error non-fatally.** The
  status quo already emits a non-fatal diagnostic and stores a default. Rejected:
  it keeps `sfn check` green on a miscompile — the exact "parsed but not
  enforced" trap — and leaves users with empty strings at runtime.
- **Decompose `type X = A & B` into a synthetic struct of both interfaces'
  fields.** Rejected: interfaces have no data fields under the nominal model, so
  there is nothing to decompose; and it would resurrect the structural model by
  the back door. `A & B` belongs in bound position (SFEP-0038), not data
  position.
- **Drop `A & B` from the grammar entirely.** Rejected: it is the natural syntax
  for multi-interface generic bounds (`<T: A & B>`), which SFEP-0038 owns.
  Removing it now would force a grammar re-addition later. Reserve, don't remove.
- **Allocate the three codes in the E03xx interface-conformance range.**
  Rejected: keeping the object-model trio contiguous in E082x makes the SFEP's
  surface self-documenting and avoids interleaving with the conformance codes
  (`E0301`–`E0303`) that `draft-interface-signature-conformance` owns.

## 7. Stage1 readiness mapping

- [x] Parses — no new syntax; the grammar is unchanged (`A & B` stays parseable).
- [x] Type-checks / effect-checks — `E0827` (parser) and `E0828`/`E0829`
      (typecheck) are the deliverable; no effect-check change.
- [x] Emits valid `.sfn-asm` — N/A for rejected cases; the sanctioned
      concrete-struct path already emits correctly (#1855).
- [x] Lowers to LLVM IR — N/A for rejected cases; unchanged for structs.
- [x] Regression coverage — `assert_does_not_compile` tests per code +
      migrated #1838 e2e asserting `admin:Alice`.
- [x] Self-hosts — pre-flight audit + `make compile`/seedcheck (see §5).
- [x] `sfn fmt --check` clean — on every touched `.sfn`.
- [x] Documented — `docs/status.md` (interfaces method-only; object literals
      require a concrete struct; `A & B` reserved for generic bounds) + spec
      §06-types.

## 8. Test plan

- **Unit / integration (`assert_does_not_compile`)** — one per diagnostic:
  - `E0827`: an interface with a data-field-shaped member is rejected; a
    method-only interface still parses; a mixed interface reports `E0827` only on
    the field member.
  - `E0828`: a bare object literal targeting an interface is rejected; targeting
    an un-inferable unannotated `let` is rejected; targeting a registered
    `struct` still compiles (the #1855 positive path).
  - `E0829`: `type X = A & B` is rejected at the definition; `let x: A & B = ...`
    is rejected at the annotation; `let x: AliasToIntersection = ...` is rejected
    through the alias; a `<T: A & B>` bound is **not** flagged by `E0829`.
  - Precedence: `let admin: AliasToIntersection = { ... }` reports `E0829`
    (not `E0828`).
- **e2e (`compiler/tests/e2e`)** — the migrated
  `union_named_variant_match_test.sfn` builds the nominal fixture to a binary,
  runs it, and asserts `admin:Alice` (upgraded from the `admin:` prefix carve-out
  pending this SFEP), plus the existing `string:Sailfin` / `number:42` union-arm
  assertions.
- **Example gate** — `examples/advanced/unions.sfn` compiles and runs under the
  strict compiler, printing `Admin: Alice`.

## 9. References

- Issues: #1860 (this fix), #1838 (union field-name-global fixture / e2e),
  #1855 (concrete-struct literal path — the sanctioned construction route).
- Related SFEPs: `draft-interface-signature-conformance` (interfaces are
  method-only contracts with checked signatures; `{i8*, i8*}` interface-value
  representation), SFEP-0034 (`x is T` type-guard over nominal types),
  SFEP-0038 (generic type-parameter constraints and monomorphization — the
  reserved home for `A & B` in bound position).
- Spec / preview: `reference/spec/06-types.md` (interfaces, structs, type
  aliases), `docs/status.md` (Interfaces; Interface conformance validation;
  Generic type constraints rows).
- Code anchors: `parser/declarations.sfn` (interface member loop,
  `parse_interface_member`, `skip_struct_member`); `ast.sfn`
  (`InterfaceDeclaration.members: FunctionSignature[]`, `TypeAnnotation.text`);
  `typecheck.sfn` / `typecheck_types.sfn` (`resolve_struct_info_from_llvm_type`,
  annotation resolution); `llvm/lowering/instructions_let.sfn`,
  `expressions_helpers.sfn` (`default_return_literal` fall-through);
  `core_member_lowering.sfn` (static GEP field access);
  `runtime/sfn/memory/mem.sfn` (`sfn_mem_get_field` stub — no `set_field` exists).
