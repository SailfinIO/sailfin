---
sfep: 12
title: "Result<T, E> and the ? Operator"
status: Implemented
type: language
created: 2026-05-27
updated: 2026-07-24
author: "agent:compiler-architect"
tracking: "#321, #323"
supersedes:
superseded-by:
graduates-to: reference/spec/12-result-and-errors.md
---

# `Result<T, E>` and the Postfix `?` Error-Propagation Operator

**Status:** Proposed (design only — no code changes in this issue).
**Issue:** R.0 ([#372](https://github.com/SailfinIO/sailfin/issues/372)).
**Epic:** Typed error handling ([#371](https://github.com/SailfinIO/sailfin/issues/371)).
**Parent / siblings:** parent [#321](https://github.com/SailfinIO/sailfin/issues/321), sibling [#323](https://github.com/SailfinIO/sailfin/issues/323).
**Roadmap ref:** [sailfin.dev/roadmap](https://sailfin.dev/roadmap) — Foundation: typed error handling (Phase 1 critical path).
**Date:** 2026-05-27

## Summary

Add a first-class `Result<T, E>` type and a postfix `?` operator that
propagates the error arm of a `Result` to the enclosing function's return.
`?` desugars to an **early `return Err(e)`** — the same zero-cost lowering
Rust uses — not to a thread-local-storage (TLS) exception throw. This gives
Sailfin a typed, effect-free error-handling path that complements (and over
time supersedes) the existing `throw` / `try` / `catch` machinery, and it
unblocks the runtime-migration work that already assumes `Result` exists
(`docs/proposals/0025-native-runtime-architecture.md#1-summary`).

```sfn
struct Error {
    message: string;
}

fn read_config(path: string) -> Result<Config, Error> ![io] {
    let text = read_file(path)?;        // propagates Err on failure
    let cfg = parse_config(text)?;      // propagates Err on failure
    return Result.Ok { value: cfg };
}
```

All examples in this proposal use Sailfin's **current** enum surface:
qualified construction (`Result.Ok { value: x }`) and `Pattern : expr`
match arms, as exercised by `compiler/tests/unit/match_tagged_enum_test.sfn`.
Unqualified constructors (`Ok(x)`) and `=>` match arms are *not* assumed —
adding ergonomic bare `Ok` / `Err` constructors would be a separate language
change and is listed under [Future Considerations](#future-considerations).

The `?` here is the new **expression-level postfix** operator. It is
unrelated to the existing **type-annotation `?`** (`Config?`, `TypeAnnotation?`)
that marks a nullable type — they share a glyph and nothing else (see
[§ Disambiguating the two `?`s](#disambiguating-the-two-s)).

## Motivation

1. **Foundation first.** `Result<T, E>` + `?` is one of the four named
   pre-1.0 syntax-reform items in `CLAUDE.md` ("`Result<T, E>` + `?`
   operator — typed error handling to complement try/catch"). The runtime
   audit (Runtime Migration table in `docs/status.md`) and `docs/proposals/0025-native-runtime-architecture.md`
   both block on it: every OS call (`sfn_fs_read_file`, sockets, process
   spawn) can fail, and the C-to-Sailfin port needs a typed failure channel
   that does not depend on the exception runtime.

2. **Boring syntax wins.** Rust, Swift (`try`), Kotlin (`Result`), and Zig
   (`!T` + `try`) all expose typed fallibility. Rust's `Result<T, E>` + `?`
   is the closest match to Sailfin's value semantics and the form LLMs
   generate most reliably. Matching it reduces generated-code error rates
   (CLAUDE.md "AI agents are users").

3. **Effects stay honest.** Exceptions in Sailfin are an opaque control-flow
   side channel — they carry no type and propagate invisibly. `Result`
   makes the failure type part of the signature, which is exactly the kind
   of compile-time-visible contract Sailfin's effect/capability story is
   built around. It does *not* add a new effect (see Q5).

4. **Don't ship unfinished safety.** Today `result_types_test.sfn` fakes
   typed errors with union return types (`int | DivisionError`) and the
   tests cannot even `match` on the result — they assert `1 == 1` with a
   comment pointing at the segfault in [#50](https://github.com/SailfinIO/sailfin/issues/50).
   That is a "parsed but not usable" state. `Result` replaces it with a
   real, end-to-end-enforced construct.

## Current State

### There is no `Result` and no generic enum anywhere

`runtime/prelude.sfn` defines no `Result`, no `Option`, and no `Ok` / `Err`
/ `Some` / `None`. A grep for `enum [A-Z]` and `enum.*<` in the prelude
returns nothing. **No generic enum declaration (`enum Foo<T> { ... }`)
exists anywhere in the compiler source, the prelude, or the test suite.**
This is the single most important fact in this proposal and it drives Q3.

### Monomorphic enum payloads DO work end-to-end

Non-generic enums with payload fields are exercised by passing regression
tests and lower correctly through all stages:

- `compiler/tests/unit/enum_mixed_field_types_test.sfn` defines
  `enum Node { Optional { payload: Cell?, tag: int }, Direct { payload: Cell, tag: int }, Missing { tag: int } }`
  and asserts `.payload` reads the right value per tag — locking a real fix
  in `lower_enum_member_access`
  (`compiler/src/llvm/expression_lowering/native/core_member_lowering.sfn`).
- `compiler/tests/unit/enum_match_struct_test.sfn`,
  `enum_complex_test.sfn`, `enum_state_machine_test.sfn`, and
  `match_tagged_enum_test.sfn` cover match dispatch, enum-as-struct-field,
  and tagged-enum member access.

The AST already models everything a payload-carrying enum needs:
`EnumVariant { name; fields: FieldDeclaration[]; name_span }`
(`compiler/src/ast.sfn:146`), and `EnumDeclaration` already carries
`type_parameters: TypeParameter[]` (`compiler/src/ast.sfn:257`,
`TypeParameter` at `compiler/src/ast.sfn:16`). **The grammar and AST can
already represent `enum Result<T, E>`; what is unverified is whether the
type checker and LLVM lowering monomorphise a *generic* payload-carrying
enum.** They do not — no such enum has ever been compiled. This is hidden
work R.2 must absorb (see Q3 and Risks).

### The existing typed-error stopgap is union returns, and it is broken

`compiler/tests/integration/result_types_test.sfn` uses
`fn _safe_divide(a: int, b: int) -> int | DivisionError`. Its own header
comment states: *"match on union return types ... causes a compiler segfault
during LLVM lowering ... cannot yet inspect the result via match
destructuring. See #50."* `Result<T, E>` supersedes this pattern; #50's
union-match path is out of scope here.

### The exception path is TLS/setjmp-heavy

Exceptions lower through `compiler/src/llvm/lowering/instructions_try.sfn`
(627 lines) and the runtime-helper descriptors in
`compiler/src/llvm/runtime_helpers.sfn`:

- `clear_exception` → `sailfin_runtime_clear_exception` (line 844)
- `has_exception` → `sailfin_runtime_has_exception`, returns `i1` (line 847)
- `try_enter` → `sailfin_runtime_try_enter` (line 850)
- `throw` → `sailfin_runtime_throw`, takes `i8*` (line 856)
- `take_exception` → `sailfin_runtime_take_exception`, returns `i8*` (line 859)

The current M2.7b emission (`instructions_try.sfn:233-259`) stack-allocates
a `[3 x i64]` exception frame plus a `[32 x i64]` (256-byte) `jmp_buf` *in
every function prologue that contains a `try`*, calls
`sfn_exception_push_frame`, executes an inline `setjmp`, and on the throw
path performs a `longjmp` back into that frame followed by
`sfn_take_exception_frame` to recover the `i8*` message
(`instructions_try.sfn:451-456`). The legacy shape it replaced
(`instructions_try.sfn:234-236`) polled `has_exception` after the try body
and again post-merge to decide propagation. Either shape touches
thread-local / frame state and a 256-byte buffer per fallible scope. This
cost is the crux of Q1.

### Where `?` would be parsed

The postfix chain lives in `parse_postfix_chain`
(`compiler/src/parser/expressions.sfn:495`). The loop already handles `as`
casts (line 521), `.` member access (line 543), `(` calls (line 564), `[`
indexing (line 582), and `{` struct literals (line 603). A postfix `?`
arm slots into this same loop. The token `?` currently appears in the
grammar only as a *type-annotation suffix* (`TypeAnnotation?`,
`VariableDeclaration.type_annotation: TypeAnnotation?` at
`compiler/src/ast.sfn:212`), which is consumed by the **type parser**, not
the **expression** parser — so adding an expression-level postfix `?` does
not collide (see Q's disambiguation note).

## Disambiguating the two `?`s

Sailfin will have two unrelated uses of the `?` glyph after this lands:

| Position | Meaning | Parsed by | Example |
|---|---|---|---|
| **Type suffix** (existing) | nullable type | type-annotation parser | `let x: Config?`, `field: Cell?` |
| **Expression postfix** (new) | propagate `Err` | `parse_postfix_chain` | `let x = read()?;` |

They never overlap: the type parser only runs in annotation position (after
`:` / `->` / inside `<...>` / after a field name), and the expression
parser only runs in value position. `read_file(path)?` is unambiguous —
`?` follows a *call expression*, which only the expression grammar can
produce. This proposal does **not** unify or alias the two; they remain
syntactically distinct constructs that happen to share a token. Swift is the
closest precedent for one glyph spanning both nullability and propagation
(`T?` optional types alongside `try?`); Rust uses `?` only for the postfix
operator and has no type-suffix `?`, so it is not the right analogy for the
*two-uses* point (Rust remains the precedent for the operator's semantics —
see Q1).

## The Eight Open Questions

### Q1 — `?` semantics: early `Err` return, not a TLS throw

**Decision: `?` desugars to an early `return Err(e)` (Rust-style), with no
exception runtime involvement.**

Rationale (pipeline-stage cost + peer precedent): the exception path forces
every fallible scope to pay for state Sailfin can avoid entirely. As shown
above, the `try` lowering in `instructions_try.sfn:254-259` emits a
`[32 x i64]` (256-byte) `jmp_buf` alloca plus a `[3 x i64]` frame alloca in
the function prologue, calls `sfn_exception_push_frame`, and runs an inline
`setjmp`; recovery requires a `longjmp` and a `sfn_take_exception_frame`
call returning an `i8*` (`instructions_try.sfn:451-456`), and the legacy
variant additionally polled `sailfin_runtime_has_exception`
(`runtime_helpers.sfn:847`) at the merge point. Routing `?` through that
machinery would mean a `setjmp`/frame-push on entry to any `?`-using
function and a TLS/frame poll after every fallible call — pure overhead
for a value that is *already in a register*. The early-return desugaring
instead lowers to a tag test on the `Result` discriminant and a branch to
either the continuation or a `ret`; this is the same shape as an `if`, the
control flow the LLVM optimizer already collapses well, and it matches
Rust's documented zero-cost `?` (which compiles to a discriminant `switch`
and a `return`). It also keeps the failure value fully typed (`E`) instead
of degrading it to the exception channel's untyped `i8*` message.

### Q2 — Where `?` may appear

**Decision: in the initial epic, `?` is only legal inside a function whose
declared return type is `Result<T, E>`, and the `E` of the propagated
`Result` must match the `E` of the enclosing function's `Result` exactly.
No `From<E>` coercion in R.0–R.5.**

Rationale (dependency-driven): Rust's `?` additionally allows the enclosing
function to return any type implementing `From<the-error>` (the `?`
operator inserts a `From::from` call on the error before returning). That
flexibility is genuinely useful, but it has a hard prerequisite: a generic
*trait/interface constraint* mechanism (`E: From<F>`) plus method
resolution against it. Generic type constraints are a Phase-2 prerequisite
in `CLAUDE.md` ("Generic type constraints (`fn sort<T: Comparable>`)") and
are not yet in the parser. Locking `?` to an exact-`E` match keeps R.0–R.5
on the Phase-1 critical path with zero dependency on constraints; the
`From<E>`-coercion form is documented here as an explicit follow-up
(see Q7 and Future Considerations) to be groomed once generic constraints
ship. Demanding exact-`E` now is the boring, shippable subset.

### Q3 — Representation: generic enum in the prelude (load-bearing)

**Decision: `Result<T, E>` is a generic enum declared in
`runtime/prelude.sfn`, NOT a compiler-magic primitive — but R.2 must first
deliver generic payload-carrying enum monomorphisation, which does not yet
exist. This is the load-bearing decision and it has hidden work.**

```sfn
// runtime/prelude.sfn (new)
enum Result<T, E> {
    Ok { value: T },
    Err { error: E }
}
```

Rationale (design principle + verified pipeline cost): "Libraries over
keywords" (CLAUDE.md) — a prelude enum can never become magic that the
language is stuck special-casing forever, and it composes with `match`,
member access, and generics like any other type. **Verification performed
for this proposal:** monomorphic payload-carrying enums lower end-to-end
(see `enum_mixed_field_types_test.sfn`, `enum_match_struct_test.sfn`, et
al.), and the AST already supports type parameters on enums
(`ast.sfn:257`, `EnumVariant` at `ast.sfn:146`). **However, no generic
enum has ever been compiled** — there is no `enum Foo<T>` in the prelude,
compiler, or tests. The type checker's monomorphisation of a generic
payload enum and the LLVM lowering's per-instantiation struct layout
(`%"Result<int,Error>"` etc.) are therefore *unproven*. The
compiler-magic alternative (a built-in two-word `{i8 tag, i8* payload}`)
would dodge that work but permanently special-case the most important
error type in the language and block `match` from treating it uniformly.
We choose the prelude enum and explicitly fold "make generic
payload-carrying enums monomorphise" into R.2's scope — it is the gating
sub-task, not a freebie. If R.2 discovers generic-enum lowering is larger
than an `M`, it must be split out and `Result` blocks behind it rather
than falling back to magic.

### Q4 — Interaction with `try` / `catch`

**Decision: inside a `Result`-returning function, a `throw` remains an
exception (it is NOT auto-converted to `Err`). The two systems coexist;
`Result` is the preferred path for new code and the long-term winner, but
`try`/`catch`/`throw` is not removed in this epic.**

Rationale (staging + compiler-internal reality): the compiler uses `throw`
/ `try` itself, and ripping it out under a self-hosting toolchain is a
multi-epic migration (see Q6). Auto-converting `throw` to `Err` would also
require the compiler to synthesize an `E` value out of an untyped exception
message — there is no typed error to convert, so the conversion would be
lossy and surprising. Keeping them orthogonal is the honest staging:
`throw` keeps its exact current semantics (`sfn_throw_frame` →
`longjmp`), and `?`/`Result` is a parallel, typed path. The long-term
intent (documented, not yet scheduled) is for `Result` to subsume the
ergonomic uses of `try`/`catch`, with `throw` surviving only for truly
unrecoverable conditions (panics). No code is deleted here.

### Q5 — Effect-checker treatment

**Decision: `?` introduces NO effect. It is pure control flow and the
effect checker ignores it entirely.**

Rationale: `?` is sugar for a tag test plus an early `return` — both are
ordinary control flow with no capability surface. The effectful work is
done by the *call that produces the `Result`* (e.g. `read_file(path)`
carries `![io]`), and that call is already effect-checked at its own site.
The `?` that follows merely inspects an in-register value. Adding an effect
for `?` would be double-counting and would contradict the principle that
effects track *capabilities*, not control-flow shapes. `effect_checker.sfn`
needs no change for `?`.

### Q6 — Migrating the compiler's own `try`/`catch` sites

**Decision: out of scope for this epic. The compiler's internal exception
sites are NOT migrated to `Result` as part of R.0–R.5. The migration is a
separate follow-up that gets its own `/groom`, not a milestone here.**

Rationale (real count + self-hosting risk): the compiler's actual `try`
usage is far smaller than the "~20" estimate in the epic. The AST has a
single `TryStatement` node (`ast.sfn:302`) parsed by one function,
`parse_try_statement` (`compiler/src/parser/statements.sfn:1107`), and a
grep for `try {` blocks in `compiler/src/` finds only **2** real
occurrences (the rest of the "try" matches are substrings like `entry` /
`retry` or comments). The `catch` keyword is consumed in exactly one place
(`statements.sfn:1135`). So the migration surface is small, but it is still
*self-hosting-critical*: changing how the compiler handles its own errors
must round-trip through the seed. Bundling that into the same epic that
introduces `Result` would entangle "does `Result` work" with "did we break
the compiler's error handling," doubling the blast radius of any failure.
We ship `Result` first, prove it on new code and tests, then groom a
dedicated follow-up ("Migrate compiler-internal `try`/`catch` to `Result`")
once a seed containing `Result` exists. That follow-up is explicitly *not*
given a milestone in this epic.

### Q7 — `Err` payload constraint (`E: Error`?)

**Decision: `E` is unconstrained in R.0–R.5 — any type may be the error
arm. An `E: Error` interface bound is deferred to the same follow-up as the
`From<E>` coercion (Q2), gated on generic constraints + closures.**

Rationale (dependency-driven, design principle): requiring `E` to implement
an `Error` interface (a `message() -> string` method, say) would force two
features that do not yet exist — generic type constraints (Phase 2
prerequisite, not in parser) and the interface method-resolution path they
ride on. Imposing the bound now would block `Result` behind Phase 2 and
violate "fix the foundation first" by coupling a Phase-1 deliverable to
Phase-2 work. Leaving `E` unconstrained keeps `Result<T, AnyType>` legal
immediately, costs nothing, and is forward-compatible: adding an `E: Error`
bound later only *narrows* the set of legal programs, and the prelude can
ship a default `Error` type now (Q8) so that *idiomatic* usage already
satisfies the future bound. Closures + constraints (Phase 2) are the named
prerequisites for ever tightening this.

### Q8 — Standard `Error` type in the prelude

**Decision: yes — the prelude ships a concrete default `Error` type, and
the dangling `Result<SfnString, Error>` reference in the runtime
architecture doc becomes real (it is at line 944, not 864 as the epic
states — see Cross-links).**

Rationale (close the loop): `docs/proposals/0025-native-runtime-architecture.md` already
writes *"`sfn_fs_read_file(path: SfnString, Arena*) -> SfnString` (or
`Result<SfnString, Error>` once `Result` lands)"*, committing the runtime
port to a named `Error` type. Shipping that type now makes the reference
real instead of aspirational and gives every runtime function a uniform
default error to return. To avoid coupling to features that do not exist
yet, the default is a **struct**, not a trait-bound hierarchy:

```sfn
// runtime/prelude.sfn (new)
struct Error {
    message: string;
}
```

This is the minimum viable error: a struct with a `message` field, no
interface, no generics. It satisfies the unconstrained `E` of Q7, matches
the `Result<SfnString, Error>` reference verbatim, and can later *implement*
a future `Error` interface without changing its shape. Users who want
richer error types use their own `E`.

## Design

### Grammar / parser

Add a single arm to `parse_postfix_chain`
(`compiler/src/parser/expressions.sfn:495`), in the existing postfix loop
alongside `.` / `(` / `[` / `as`. When the current token is the symbol `?`
**and** the parser is in expression position (which `parse_postfix_chain`
always is), wrap the current expression in a new `TryOperator` expression
node (see [AST](#ast)) and advance:

```
postfix := primary ( "." ident | "(" args ")" | "[" expr "]" | "as" type | "?" )*
```

Because the loop left-associates, `a()?.b()?` parses as
`((a()?).b())?` — chained propagation, matching Rust. The type-annotation
`?` is unaffected: it is consumed by the type-annotation parser in
annotation position and never reaches `parse_postfix_chain`.

### AST

Add one expression variant named `TryOperator` (it echoes Rust's internal
`ExprKind::Try` but is named in full to stay distinct from the
statement-level `TryStatement` at `ast.sfn:302`; R.1 must implement exactly
this name):

```sfn
// compiler/src/ast.sfn — Expression enum
TryOperator { operand: Expression, span: SourceSpan? }
```

No change to `EnumVariant` / `TypeParameter`; `Result` reuses the existing
generic-enum AST shape (`ast.sfn:146`, `:257`).

### Type rules (`typecheck.sfn`)

For `TryOperator { operand }` inside function `f`:

1. Infer the type of `operand`. It must unify with `Result<T, E>` for some
   `T`, `E`. If not, emit **`E0810`** ("`?` applied to non-`Result` value").
2. The enclosing function `f` must have declared return type
   `Result<U, F>`. If `f`'s return type is not a `Result`, emit **`E0811`**
   ("`?` only valid in a function returning `Result`").
3. `E` must equal `F` (exact match — Q2). If not, emit **`E0812`** with both
   types in the message.
4. The type of the whole `TryOperator` expression is `T` (the unwrapped
   success type).

These reserve the next free slots in the existing `E08xx` type-checker
range (`compiler/src/typecheck_types.sfn` currently tops out at `E0806`),
matching the numeric-code convention rather than inventing a string-keyed
scheme.

`Result` itself type-checks as an ordinary generic enum; this is where R.2's
generic-enum monomorphisation work is exercised (Q3).

### Native IR (`emit_native.sfn`)

Lower `TryOperator { operand }` by desugaring to the equivalent `match`
*before* emission (a pure AST→AST rewrite in the emitter, so the rest of
the pipeline sees only constructs that already lower):

```
TryOperator(operand)   ==>   match operand {
                                 Result.Ok { value }
                                 : value,                       // expression result
                                 Result.Err { error }
                                 : return Result.Err { error: error }
                             }
```

This reuses the existing enum `match` and enum-construction `.sfn-asm`
emission paths — no new IR opcode. The `return Result.Err { error: error }`
arm emits the same `ret` sequence any explicit early return uses. Because `match` on
payload-carrying enums already emits correct IR (per
`enum_match_struct_test.sfn` et al.), the only new requirement is that the
*generic* instantiation `Result<U, F>` is monomorphised (Q3 / R.2).

### LLVM lowering (`compiler/src/llvm/lowering/`)

No new lowering code is needed *if* the emitter desugars to `match` +
`return` as above — the discriminant test lowers via the existing
`instructions_match.sfn` path and the early return via the standard `ret`.
The single dependency is generic-enum layout: the lowering must assign a
concrete LLVM struct (`{ i<tag>, <T-or-E payload> }`) per `Result<T, E>`
instantiation, which is the R.2 monomorphisation work flagged in Q3. It does
**not** touch `instructions_try.sfn` (the exception path) at all — `?` and
`throw` are independent.

### Effect checker

No change (Q5).

## Worked Example

Source using `?` (chosen lowering form):

```sfn
struct Error { message: string; }

fn parse_int(s: string) -> Result<int, Error> {
    if s == "" { return Result.Err { error: Error { message: "empty" } }; }
    return Result.Ok { value: string_to_int(s) };
}

fn sum_two(a: string, b: string) -> Result<int, Error> {
    let x = parse_int(a)?;   // unwrap or early-return Err
    let y = parse_int(b)?;
    return Result.Ok { value: x + y };
}
```

The same `sum_two` body, written out as the `match` desugaring the emitter
produces (semantically identical, no `?`):

```sfn
fn sum_two(a: string, b: string) -> Result<int, Error> {
    let x = match parse_int(a) {
        Result.Ok { value }
        : value,
        Result.Err { error }
        : return Result.Err { error: error }
    };
    let y = match parse_int(b) {
        Result.Ok { value }
        : value,
        Result.Err { error }
        : return Result.Err { error: error }
    };
    return Result.Ok { value: x + y };
}
```

Note both forms are pure control flow — no `setjmp`, no
`sailfin_runtime_throw`, no TLS poll. Contrast the exception equivalent,
which would prologue-allocate a 256-byte `jmp_buf` and a frame
(`instructions_try.sfn:254-259`) and `longjmp` on failure.

## Migration Plan (sub-issues R.1–R.5)

Each step produces a self-hosting compiler. `Result` is *additive* — the
seed never needs to understand `?` to build a compiler that emits `?`,
because the compiler source itself does not use `?` until a post-epic
follow-up (Q6). The old seed compiles the new compiler unchanged.

1. **R.1 — Parser + AST.** Add the `?` postfix arm to
   `parse_postfix_chain` (`expressions.sfn:495`) and the `TryOperator` AST
   node (`ast.sfn`). **Do not add `Result`/`Error` to the prelude yet** — a
   generic enum the compiler cannot monomorphise (Q3) would break
   `make compile` before R.2 lands. R.1 ships parser + AST only; the new
   parser still accepts everything the old one did, so the seed builds it.
   **Gate:** `make compile`, parser unit tests.
2. **R.2 — Generic enum monomorphisation + prelude `Result` + type-check.**
   Make a generic payload-carrying enum (`Result<T, E>`) monomorphise
   through the type checker and LLVM lowering (the hidden work from Q3),
   then add `enum Result<T, E>` and `struct Error` to `runtime/prelude.sfn`
   in the *same* sub-issue so the prelude never contains an un-lowerable
   type. This is the largest sub-issue and may itself need splitting.
   **Gate:** a standalone `.sfn` defining and matching `Result<int, Error>`
   compiles and runs, and `make compile` succeeds with the prelude addition.
3. **R.3 — Type rules for `?`.** Implement the four `typecheck.sfn` rules
   above, including the three diagnostics. **Gate:** the must-error test
   cases below produce the right diagnostics.
4. **R.4 — Emitter desugaring.** Implement the `TryOperator` → `match` +
   `return Err` rewrite in `emit_native.sfn`. **Gate:** the worked-example
   round-trips and runs.
5. **R.5 — Docs + spec.** Update `docs/status.md`, add a spec chapter under
   `site/src/content/docs/docs/reference/spec/`, update `llms.txt`, and
   replace `result_types_test.sfn`'s union-return stopgap with real
   `Result` tests. Make the runtime architecture
   `Result<SfnString, Error>` reference real (Q8) — see `docs/proposals/0025-native-runtime-architecture.md`.

**Follow-up (separate `/groom`, not in this epic):** migrate the
compiler-internal `TryStatement` site and add `From<E>` coercion + `E: Error`
bound once generic constraints ship (Q2, Q6, Q7).

## Files Affected

Grouped by pipeline stage. (R.0 changes none of these — this is the design;
the file list is the implementation map for R.1–R.5.)

| Stage | File | Change |
|---|---|---|
| Prelude | `runtime/prelude.sfn` | add `enum Result<T, E>`, `struct Error` (lands in **R.2**, not R.1 — needs generic-enum monomorphisation first) |
| Parser | `compiler/src/parser/expressions.sfn` (~`:495`) | `?` postfix arm in `parse_postfix_chain` |
| AST | `compiler/src/ast.sfn` | `Expression.TryOperator` variant |
| Type checker | `compiler/src/typecheck.sfn` | `?` rules + 3 diagnostics; generic-enum monomorphisation (R.2) |
| Emitter | `compiler/src/emit_native.sfn` | `TryOperator` → `match` + `return Err` desugaring |
| LLVM lowering | `compiler/src/llvm/lowering/lowering_phase_types.sfn`, `instructions_match.sfn` | per-instantiation `Result` layout (R.2); no change to `instructions_try.sfn` |
| Effect checker | `compiler/src/effect_checker.sfn` | none (Q5) |
| Tests | `compiler/tests/integration/result_types_test.sfn` (+ new unit tests) | replace union stopgap; add `?` round-trip + must-error cases |
| Docs | `docs/status.md`, `site/.../reference/spec/`, `llms.txt`, `docs/proposals/0025-native-runtime-architecture.md` | status, spec chapter, LLM ref, make `Result` reference real |

## Dependencies

- **Hard:** generic payload-carrying enum monomorphisation (Q3 / R.2) —
  does not currently exist; R.2 must build it.
- **Soft (deferred, do NOT block this epic):** generic type constraints +
  closures (Phase 2) — only the `From<E>` coercion (Q2) and `E: Error`
  bound (Q7) need them, and both are explicitly out of scope.
- **None:** the effect system, the exception runtime, and the seed's
  understanding of `?` (the feature is additive — Q6).

## Risks

| Risk | Detection | Mitigation |
|---|---|---|
| Generic enum lowering is larger than an `M` (Q3) | R.2 spike: try to compile a standalone `Result<int, Error>` match | Split R.2; block `Result` behind it; never fall back to compiler-magic |
| `?` token collides with nullable `?` | Parser unit tests on `let x: Config? = read()?;` | Type-`?` and expr-`?` parse in disjoint positions (verified above) |
| Self-hosting break from prelude additions | `make compile` after R.2 | Prelude additions land only after generic-enum lowering works (R.2); they are new symbols, old code untouched |
| Union-match segfault (#50) leaks into `Result` match | Run R.2 standalone match test | `Result` uses named enum match, not union match — distinct path |
| `throw`-vs-`Err` confusion in mixed code | Docs + a test mixing both in one fn | Q4 keeps them orthogonal; spec documents the boundary |

## Verification

```bash
# After R.1 (parser/AST only — no prelude change yet):
ulimit -v 8388608 && make compile
ulimit -v 8388608 && timeout 60 build/bin/sfn test compiler/tests/unit/result_parse_test.sfn

# After R.2 (generic enum monomorphisation + prelude Result/Error):
ulimit -v 8388608 && timeout 60 build/bin/sfn test compiler/tests/unit/result_enum_lowering_test.sfn

# After R.3 (type rules):
ulimit -v 8388608 && timeout 60 build/bin/sfn test compiler/tests/unit/result_question_typecheck_test.sfn

# After R.4 (emitter):
ulimit -v 8388608 && timeout 60 build/bin/sfn test compiler/tests/integration/result_types_test.sfn

# Full self-host + suite:
make clean-build && make check

# Formatting gate (every touched .sfn):
build/bin/sfn fmt --check compiler/src/ runtime/
```

## Test Plan (R.1–R.5 round-trip cases)

These representative inputs must behave as stated end-to-end.

1. **`?` on `Result<int, Error>` returning `int`.**
   `fn f() -> Result<int, Error> { let x = g()?; return Result.Ok { value: x }; }`
   where `g() -> Result<int, Error>` — compiles, `x` has type `int`, runs.
2. **`?` on a variable (not a call).**
   `let r: Result<int, Error> = g(); let x = r?;` — `?` works on any
   `Result`-typed expression, not just calls.
3. **`?` chained through 3 calls.**
   `let x = a()?; let y = b(x)?; return Result.Ok { value: c(y)? };` — all
   three propagate to the same `Err` return; success path threads through.
4. **`?` on a non-`Result` expression (must error).**
   `let x: int = 5; let y = x?;` — emits `E0810`.
5. **`?` in a function whose return type is not `Result` (must error).**
   `fn h() -> int { let x = g()?; return x; }` — emits `E0811`.
6. **`?` whose `E` differs from the enclosing `E` (must error).**
   `fn f() -> Result<int, Error> { let x = k()?; ... }` where
   `k() -> Result<int, OtherErr>` — emits `E0812` (no `From` coercion — Q2).
7. **`?` postfix vs. nullable type `?` coexist in one statement.**
   `let x: Config? = load()?;` — type-annotation `?` and expression
   postfix `?` both parse, unrelated (disambiguation section).
8. **`Result` round-trips both arms via `match`.**
   `match g() { Result.Ok { value } : value, Result.Err { error } : error.message }`
   — confirms the generic enum (R.2) matches and reads payloads, the same
   path the `?` desugaring relies on.

## Cross-links

- Epic: typed error handling — [#371](https://github.com/SailfinIO/sailfin/issues/371)
- This issue: R.0 — [#372](https://github.com/SailfinIO/sailfin/issues/372)
- Parent: [#321](https://github.com/SailfinIO/sailfin/issues/321)
- Sibling: [#323](https://github.com/SailfinIO/sailfin/issues/323)
- Union-match segfault superseded by `Result`: [#50](https://github.com/SailfinIO/sailfin/issues/50)
- Migration sites:
  - `compiler/src/parser/expressions.sfn:495` (`parse_postfix_chain` — `?` postfix arm)
  - `runtime/prelude.sfn` (new `Result` enum + default `Error`)
  - `docs/proposals/0025-native-runtime-architecture.md` (the `Result<SfnString, Error>`
    reference to make real)
  - `compiler/src/ast.sfn:146` (`EnumVariant`), `:257` (`EnumDeclaration`
    with `type_parameters`), `:16` (`TypeParameter`)
  - `compiler/src/parser/statements.sfn:1107` (`parse_try_statement` —
    the single parser entrypoint for `try`/`catch`; only 2 `try {` usage
    sites exist in `compiler/src/`, Q6)

## Future Considerations

- **`From<E>` coercion + `E: Error` bound** (Q2, Q7): unlocks once generic
  type constraints (Phase 2) ship; documented here, groomed separately.
- **Ergonomic bare constructors** (`Ok(x)` / `Err(e)`) and `=>` match arms:
  every example here uses today's qualified `Result.Ok { value: x }` /
  `Pattern : expr` forms. Sugar for unqualified single-payload constructors
  is a possible quality-of-life follow-up but a distinct language change,
  out of scope for R.0–R.5.
- **`Option<T>`**: the same generic-enum machinery (R.2) makes a prelude
  `Option<T>` trivial; sibling [#323](https://github.com/SailfinIO/sailfin/issues/323)
  may pick it up.
- **Compiler-internal `try` → `Result` migration** (Q6): a self-hosting-
  sensitive follow-up gated on a seed that already contains `Result`.
- **Runtime port** (Runtime Migration table in `docs/status.md`): every ported OS call returns
  `Result<_, Error>`; this proposal is the prerequisite that unblocks that
  Phase-3 work.
- **`throw` reduction**: long-term, `Result` subsumes recoverable-error
  uses of `try`/`catch`, leaving `throw` for panics only (Q4) — no schedule
  attached.
