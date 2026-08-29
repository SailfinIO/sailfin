---
sfep: 75
title: Struct Value Semantics and the Mutability Floor
status: Draft
type: language
created: 2026-08-29
updated: 2026-08-29
author: "agent:compiler-architect (drafted); project owner (direction + decisions)"
tracking: SFN-692, SFN-1127
supersedes:
superseded-by:
graduates-to: reference/spec/06-types.md
---

# SFEP-0075 — Struct Value Semantics and the Mutability Floor

## 1. Summary

Sailfin `struct` values today have **reference semantics**: `let b = a` binds a
second name to one object, and a callee can mutate its caller's struct through
an ordinary parameter. This is undocumented, unenforced, contradicted by the
spec, and contradicted by the compiler's own source, which is written
throughout as if structs were value types.

This proposal decides that **structs are value types**. It also separates three
layers that SFN-692 conflates, and resolves each independently:

| Layer | Decision |
|---|---|
| **1. Language semantics** | Structs are **value types**. A bind, a pass, a return, or a store copies. Projection through a place (`s.f`, `arr[i]`) is *not* a copy — it stays an lvalue. |
| **2. Mutability enforcement** | `let` vs `let mut` and `mut` parameters become **enforced**, with new diagnostics `E0919`/`E0920`. Field-level `mut` is deprecated (`W0921`) rather than promoted to a second gate. |
| **3. ABI transport** | **Unchanged.** Every user struct keeps crossing a call boundary as `%T*`. Transport and semantics are independent; this proposal fixes the vocabulary that has been treating them as one thing. |

The engineering result is that layer 2 pays for layer 1. Because a struct can
only be written through a *mutable place*, and because a mutable place is
introduced at exactly the syntactic points a copy would be emitted, the value
model is obtained without eager copying: the overwhelming majority of binds and
calls forward the same pointer they forward today, bit-for-bit.

## 2. Motivation

### 2.1 The observed behaviour

Reproduced on the pinned seed 0.10.6, Linux x86_64. `sfn check` is clean in
every case:

```sfn
struct P { mut a: int; mut b: int; }
fn mutate(p: P) { p.a = 999; }
fn main() ![io] {
    let orig = P { a: 1, b: 2 };
    let copy = orig;
    copy.a = 42;
    print("orig.a=${orig.a}");   // prints 42, not 1
    let m = P { a: 1, b: 2 };
    mutate(m);
    print("m.a=${m.a}");         // prints 999, not 1
}
```

Both aliasing faces are live: **assignment** (`let b = a` shares one object) and
**parameter passing** (the callee writes the caller's struct). Neither is
documented, and no diagnostic covers either.

### 2.2 The spec already says otherwise, and contradicts itself

`site/src/content/docs/docs/reference/spec/03-declarations.md:16` documents
`name = "Other";` after `let name = "Sailfin";` as `// ERROR: immutable
binding`. Verified: it compiles clean and prints `Other`. Line 91 says "Fields
default to immutable; `mut` allows reassignment" — also unenforced — and §3.3's
own example mutates a non-`mut` field:

```sfn
fn rename(self, new_name: string) { self.name = new_name; }
```

So the spec asserts a rule, contradicts it two subsections later, and the
compiler enforces neither. Mutability is **recorded everywhere and enforced
nowhere**: `Parameter.mutable`
(`compiler/capsules/syntax/src/ast.sfn:236-241`), `FieldDeclaration.mutable`
(`ast.sfn:272-277`) and `VariableDeclaration.mutable` (`ast.sfn:381-389`) are
all parsed, threaded through `emit_native` (`emit_native.sfn:491,822`;
`emit_native_format.sfn:599,634`), re-parsed into `NativeParameter.mutable`
(`native_ir_utils_parse.sfn:779-783`) — and then read by nothing. The only
`mut`-related diagnostic in the analyzer is `E0807` (thread-local requires
`mut`).

### 2.3 The compiler is already written as if structs were values

This is the decisive evidence. A mechanical pass over 480 `.sfn` files, 543
user struct types, 5,147 `fn` bodies and 743 field-write statements found:

- **Category A — mutation through a struct parameter: 15 statements, 8
  functions, 6 files.** Exactly one is load-bearing (§2.4). Seven of the
  remainder reach a struct through a struct-*array* parameter and depend on
  `arr[i].f = v` staying a place, not on parameter aliasing. The rest are
  incidental — `_cr_enumerate_relative_sources_memo`
  (`compiler/src/capsule_resolver/relative.sfn:198`) threads its memo by return
  value and says so in its own comment, "rather than relying on in-place
  mutation of the memo argument".
- **Category B — aliased local (`let b = a; b.f = …`): 111 sites, no confirmed
  break.** The codebase converged on the functional-update idiom:
  `let mut updated = table; updated.f = x; return updated;` —
  `compiler/capsules/ir/src/typed_ssa.sfn:269-274` and 27 sibling sites,
  `compiler/src/toolchain/index_json.sfn` (20 sites),
  `compiler/capsules/analyzer/src/type_interner.sfn` (9 sites). Under today's
  reference semantics each of these performs a *second, unintended* write to
  the caller's struct, benign only because every caller immediately rebinds to
  the returned value. Value semantics removes that latent write. It is strictly
  better at all 111 sites.

`typed_ssa.sfn:813-817` names the discipline outright — "All builder mutation
therefore copies the field into a local, pushes, and writes it back — the same
**value-struct discipline** `tensor_ir.sfn` follows." Worth recording honestly:
that convergence was **forced by a compiler limitation** (the lowerer cannot
resolve `.push()` on a struct-field array — the build-only failure class of
#1389), not chosen on design grounds. Value semantics ratifies an idiom the
codebase already writes.

### 2.4 The one genuine break, and why it is not what it looks like

`runtime/sfn/memory/secretbuf.sfn:452`,
`fn secret_buf_zeroize(self: SecretBuf) -> void`, writes
`self.ptr_addr/len/cap/cleanup_token = 0` at lines 483-486. It returns `void`;
its only effect on the caller is via aliasing. Its own comment states the
contract: zeroing `cleanup_token` is what makes a second `secret_buf_zeroize`
on the same descriptor take the early return rather than a use-after-free,
"which would re-enter the drain path and **double-free** both the backing block
and the record". `compiler/tests/e2e/secret_buf_runtime_test.sfn:257,272` calls
it twice specifically to exercise that idempotence, and
`secret_buf_declassify_copy` (`:499`, forwarding its own parameter at `:537`)
depends on the same in-place consumption.

Under naive value semantics `self` is a copy, the caller's token stays
non-zero, and the documented double-free goes live. §3.6 resolves this, and the
resolution is not a copy-vs-alias trade: `SecretBuf` is an **affine** type, and
affine values move rather than copy.

### 2.5 Why the status quo cannot stand

- `fn f(x: T)` silently mutating the caller is a correctness hazard that **no
  diagnostic covers and no reader can see at the call site**. It is the class of
  bug that is cheap to write and expensive to find.
- Structs are the vehicle for `OwnedBuf`, `SecretBuf`, TLS session state and
  process handles. A silent alias there is a memory-safety or secrecy bug, not
  a surprise.
- SFEP-0069 §3.2 and §3.4 both defer to this decision by name, and SFEP-0018's
  ownership lattice assumes a settled answer to "what does binding a struct
  do?".
- A 1.0 language must state what assignment means. `docs/status.md:1521` lists
  Structs as **Shipped** and says nothing about it.

## 3. Design

### 3.1 The decision: structs are value types

**A `struct` value is copied when it is bound to a new name, passed as an
argument, returned, or stored into a field, array element, or global.** Two
distinct bindings never observe each other's writes.

Weighed against the design rules in `CLAUDE.md`:

- **"Boring syntax wins — match TypeScript/Rust/Python unless there's a real
  semantic reason."** This cuts both ways and must be argued, not asserted.
  TypeScript objects are references; Rust structs and Go structs are values.
  The tiebreaker is *category*: Sailfin is a systems language with a manual
  memory model, an ownership floor (SFEP-0018), a deterministic-destruction
  requirement (SFEP-0069), and a reproducibility pillar (SFEP-0062). Its peers
  in that category — Rust, Go, C, C++, Zig, Swift — are unanimously value-typed
  for structs. TypeScript's reference model is inseparable from a tracing GC
  Sailfin does not have and will not get. Matching TS here would mean matching
  one surface property of the wrong category while diverging from every peer in
  the right one.
- **"AI agents are users."** This is the argument that most looks like it
  favours references and does not. An LLM emitting Sailfin has no `.sfn`
  training data, so it emits from its nearest neighbours — and its nearest
  neighbours for `struct P { … }` with `fn f(p: P)` are Rust, Go, and C, all of
  which copy. Reference semantics for a construct spelled `struct` is the
  *surprising* choice for a generator, not the safe one. The evidence is in
  this repository: §2.3's 111 Category B sites are model-and-human-authored
  Sailfin written on the value assumption, and the codebase contains **zero**
  sites that deliberately exploit local aliasing.
- **"Ownership is a floor, not a pillar," with user-facing ownership post-1.0.**
  Value semantics is the floor's precondition, not an instance of it. It needs
  no borrow checker, no lifetimes, and no user-visible ownership syntax — it is
  the default every peer language gives away for free. `SFEP-0018`'s affine
  machinery composes on top (§3.6) rather than being pulled forward.
- **The honest cost of the call:** JS/TS-background users *will* be surprised
  that `let b = a; b.x = 1` leaves `a` alone. That surprise is (a) in the
  direction of safety, (b) shared with Rust/Go/C#, and (c) diagnosable — the
  same design makes `let b = a; b.x = 1` an *error* until `b` is `let mut`, so
  the user is stopped at the exact line where their mental model diverges,
  rather than debugging a wrong value three files away.

**Reference-with-explicit-copy is rejected** (§6.3): it is reference semantics
with a `.clone()` method bolted on, and leaves the `fn f(x: T)` hazard
untouched.

### 3.2 What is *not* a copy: places

Value semantics governs **binding**, not **projection**. A *place expression*
denotes storage, and writing through it writes that storage:

```sfn
let mut s = Outer { inner: Inner { x: 1 } };
s.inner.x = 2;        // writes s's storage — one place, no copy
arr[i].field = v;     // writes the array's element storage — a place
let t = s.inner;      // BIND: t is a copy of s.inner
```

**`arr[i]` remains an lvalue.** This is stated as a separate normative decision
because it is where the migration cost lives. Repo-wide, **46 write statements
across 11 files** write a struct through an array element — concentrations in
`compiler/capsules/analyzer/src/typecheck_types/symbol_table_and_raw_exprs.sfn`
(11), `compiler/src/cli/commands/test/multi_file_run.sfn` (9),
`compiler/src/cli/commands/test/discovery.sfn` (8),
`compiler/src/cli/commands/check/engine.sfn` (6), plus
`analyzer/src/diagnostic.sfn:73` (`stamp_spans`), `src/lock.sfn:174-175`,
`src/main.sfn:216,1009`, `src/native_artifact_writer.sfn:29,72`.

If indexing yielded a copy, **all 46 would break silently** — no diagnostic,
just un-stamped diagnostic spans and a lockfile that never updates. Keeping it
an lvalue is not a pragmatic dodge to avoid that: it is what value semantics
means in Rust (`v[i].f = x`), C# (arrays of value structs), C and Go. A
language in which `arr[i].f = v` did not write the array would be the anomaly.
The rule is uniform and one sentence long: **a bind copies; a projection does
not.**

Consequently `let e = arr[i];` *is* a copy, and `e.f = v` does not touch the
array — which is exactly what a reader expects and exactly what the analogous
Rust reads as.

### 3.3 Mutability: the enforced floor

Two rules, both new, both enforced in the typecheck walk:

1. **`E0919` — assignment to an immutable binding.** `let x = …; x = …;` is an
   error. Fix-it: "declare `x` as `let mut x`". This is the rule
   `spec/03-declarations.md:16` already documents.
2. **`E0920` — write through an immutable place.** `p.f = v`, `p.f.g = v`, and
   `p[i].f = v` are errors when the *root* of the place is an immutable binding
   or an immutable parameter. Fix-it names the root and its declaration span.

**Root resolution** walks the place expression to its base: `Identifier` → that
binding; `Member{operand,…}` / `Index{operand,…}` → recurse on `operand`;
`self` → the receiver parameter. Two exemptions:

- **Raw-pointer roots (`*T` / `*mut T`) are outside the model.** A deref write
  through a raw pointer is unsafe-typed FFI surface, governed by SFEP-0018's
  `E0906` and the `unsafe` region rule, not by this proposal. This exemption is
  what makes the runtime migration nearly free: of `runtime/`'s 260 field
  writes, **247 go through explicit raw pointers** (`*TlsSession`, `*GrowBuf`,
  `*PwGrowBuf`, `*RcHeader`, `*SfnExceptionFrame`, `*SailfinProcessHandle`) and
  are untouched. `runtime/prelude.sfn` has zero field writes.
- **`unsafe { }` / `unsafe fn` interiors are skipped**, mirroring the ownership
  checker's existing behaviour (#1211).

**Parameters.** `fn f(p: P)` is immutable; `p.a = 1` is `E0920`. `fn f(mut p:
P)` is mutable and licenses the write — and, per §3.4, the callee gets its own
copy, so the caller is still unaffected. Methods take `fn m(mut self)` for the
same reason.

**Feasibility, probed:** `fn f(mut p: P)` and `fn m(mut self)` **already parse
in the pinned seed**. `parse_single_parameter`
(`compiler/capsules/syntax/src/parser/declarations/syntax.sfn:529-540`) consumes
a leading `mut` before any parameter name, and struct methods route through the
same `parse_parameter_list` (`structs.sfn:280`). The flag already survives to
`NativeParameter.mutable`. No parser predecessor exists; the syntax this
proposal needs is already accepted, merely ignored.

### 3.4 Field-level `mut` is deprecated, not promoted

Sailfin's `struct P { mut a: int; }` has no analogue in Rust, Go, or C. Making
it a *second* gate — "a write needs both a mutable place and a `mut` field" —
was considered and rejected on measurement: the source tree declares **zero
`mut` fields across 543 struct types**, so the second gate would demand a
543-struct annotation migration touching all 743 field-write statements, in
exchange for an expressiveness gain no peer language considers worth having.
"Boring syntax wins" applies directly.

Therefore: **the enforced gate is the place, never the field declaration.**
`mut` on a field becomes a no-op carrying `W0921` (deprecated field modifier),
is removed from spec §3.3, and the modifier itself is dropped from the grammar
post-1.0 once a seed carrying the warning has shipped. The §3.3 self-
contradiction is resolved in the same edit: `fn rename(self, …)` becomes
`fn rename(mut self, …)`.

### 3.5 Where copies are materialized

The normative rule is §3.1. This subsection specifies the **implementation
strategy**, whose soundness condition is stated so a later optimizer can widen
it: *a copy may be elided when no write to either the source place or the
destination place can occur between the bind and the last use of both.*

A copy is emitted at exactly three syntactic positions:

| Position | Emitted? |
|---|---|
| `fn f(mut p: P)` — mutable parameter | **Yes**, in the callee prologue |
| `let mut b = <place>;` — mutable local bound from a place | **Yes**, at the bind |
| `let b = <place>;` / `f(<place>)` / `return <place>` where the place's root is **mutable** | **Yes**, at the use |
| everything else — immutable bind from an immutable place, or any bind from a fresh rvalue (struct literal, call result) | **No** — forward the pointer, byte-identical to today's codegen |

Soundness follows by induction: a struct can only be written through a mutable
place (§3.3); every mutable place is created by a copy; every read *out of* a
mutable place is copied. Therefore no write is observable through any binding
other than the one that performed it.

**Cost, measured.** The paying sites are rare. The repository contains **66**
`let mut <name>: <StructType> = <place>;` bindings and **zero** `mut`
parameters across compiler and runtime source. Row 3 (mutable-source reads) is
bounded above by the 111 Category B sites. Nothing on a hot path — the
typecheck walk threading `TypeckCtx`, the lowering walk threading
`NativeFunction` — pays anything, because those parameters are immutable and
row 4 applies.

This is the load-bearing reason **not** to implement value semantics by eager
copy-on-argument. `TypeckCtx` (17 fields) is threaded through every step of the
typecheck walk; copying it per call would add arena pressure to a compiler that
already runs under an 8 GiB `RLIMIT_AS`
(`.claude/rules/compiler-safety.md`) and whose per-module peak RSS is a tracked
1.0 roadmap item. Eager copying is not a slower correct design; it is a design
that would not fit in the memory budget.

**Copy mechanics.** A copy is `@sfn_alloc_struct(<size>)` plus a bytewise
copy, where `<size>` comes from the existing target-independent
`getelementptr %T* null, i32 1` + `ptrtoint` idiom already used at
`core_literals_lowering.sfn:600-612`. Because nested user-struct fields are
stored **inline** (`type_context.sfn:209-227` strips the pointer suffix for
value-typed fields), the copy is deep through nested structs and shallow
through arrays, strings, and self-referential fields — which is correct:
strings are immutable, arrays are reference types (§3.7), and a
self-referential field is a genuine link, not a component.

The copy is entirely **intra-function**. LLVM applies calling-convention
legalization only to `call`/`ret` signatures (SFEP-0021 R3's own correction),
so a prologue `alloc`+copy carries no ABI exposure on any target.

### 3.6 Composition with SFEP-0069, SFEP-0018, and affine types

**Affine and linear values move; they do not copy.** `OwnedBuf`, `SecretBuf`,
`Linear<T>` and `Affine<T>` are already compiler-recognized as owned, and the
ownership checker already rejects a second live binding with `E0904` and a use
after move with `E0901`. Implicit copy therefore **does not apply to the owned
family** — a copy of an affine value is precisely what `E0904` exists to
reject. This is a carve-out in name only: no new machinery, and it is what
SFEP-0069 §3.2 already assumes when it says the sealed type "is
compiler-recognized as owned, like `OwnedBuf`, regardless of the eventual
decision for ordinary struct assignment in SFN-692".

This resolves §2.4 cleanly, and it is worth being precise about *why*, because
the naive reading is that value semantics makes `SecretBuf` worse.

SFEP-0069's comment at `secretbuf.sfn:449-451` already reasons about exactly
this hazard: "A STALE COPY of a descriptor taken before this call still carries
the old token and is not protected here; that is use-after-zeroize, and
rejecting it is SFN-784's `E0903`." Under §3.1 as applied to *ordinary*
structs, every pass of a `SecretBuf` would manufacture that stale copy — which
is why `SecretBuf` must not be an ordinary struct for this purpose. Under the
affine rule it is not: passing a `SecretBuf` is a **move**, the caller's
binding becomes `Moved`, and a later use is `E0901` at compile time. Value
semantics thus *raises the priority* of SFN-784's enforcement for the owned
family while leaving its correctness argument intact — it does not weaken it.

**The runtime edit, and why it needs no new compiler capability.**
`secret_buf_zeroize` is still rewritten, but the target shape is constrained by
a detail worth stating precisely, because it points the opposite way from the
obvious answer: **the idempotence test drives the function through the C ABI,
not from Sailfin.** `compiler/tests/e2e/secret_buf_runtime_test.sfn:257,272`
emits a C harness whose body calls `secret_buf_zeroize(idem)` twice on a
`void *` descriptor. A C caller cannot observe a Sailfin-level return value it
does not bind, so the returning shape used by `secret_buf_set` /
`secret_buf_append` does not by itself preserve that contract, and a `mut self`
copy-in (Phase 2) would actively break it — the C caller's descriptor would
stop being zeroed.

The recommended resolution is therefore the **raw-pointer form**:

```sfn
fn secret_buf_zeroize(self: *SecretBuf) -> void { …; self.cleanup_token = 0; }
```

This is exempt from the value model by §3.3, preserves the C-ABI contract the
test asserts byte-for-byte, and matches the idiom the rest of the runtime
already uses at 247 sites. `secret_buf_declassify_copy` (`:499,537`) takes the
same treatment for its forwarded parameter.

Two properties make this land without a gate. First, it needs **no new compiler
capability**: `*T` parameters and writes through them ship today and are the
runtime's dominant idiom. Second, it is **bi-semantic** — under the pinned seed
(reference semantics, no mutability enforcement) a `*SecretBuf` parameter
behaves identically to today's `SecretBuf` parameter, and under this proposal
it is a raw-pointer place. The edit is correct before and after, so it can land
in Phase 1 alongside the enforcement it satisfies.

The Sailfin-facing ergonomics are unaffected: safe Sailfin callers still hold an
affine `SecretBuf` and still move it, so a stale-copy use is `E0901` at compile
time. Only the zeroize entry point, which the C harness owns, speaks pointers.

*Open for Phase 1:* if the design gate prefers to keep the safe surface free of
`*T`, the alternative is to rewrite the C harness to bind the returned
descriptor and adopt `fn secret_buf_zeroize(mut self: SecretBuf) -> SecretBuf`.
That is a larger test edit for a cosmetic gain, and it is recorded here as the
considered alternative rather than the recommendation.

### 3.7 Scope: what this proposal does not decide

- **Arrays (`T[]`) remain reference types.** `arr.push(x)` through an immutable
  `arr` binding continues to work, and passing an array does not copy it.
  Aligning arrays with the value model is a separate, much larger decision with
  its own migration; it is deliberately out of scope and should be its own SFEP
  if it is ever wanted. What §3.2 fixes is only that `arr[i]` is a *place*.
- **`&T` / `&mut T`** stay parsed-and-unenforced pending SFEP-0018. When they
  land they become the safe by-reference form; until then `*T` / `*mut T` is
  the escape hatch, as the runtime already uses it.
- **The spec's claim that `*T` is read-only** (`spec/06-types.md:126`) is
  contradicted by 247 runtime write sites. Reconciling that is SFEP-0018's
  business, not this proposal's; it is noted so a later reader does not read
  §3.3's raw-pointer exemption as endorsing the spec text.

### 3.8 Vocabulary: transport is not semantics — a named deliverable

SFN-692 conflates layers 1 and 3, and so does the repository's prose. The
phrase "by-value ABI" appears in `docs/proposals/0021-windows-native-selfhost.md`
(R3 row and §), `compiler/tests/e2e/struct_large_return_test.sfn`,
`compiler/tests/e2e/abi_value_return_test.sfn`, and SFN-650's title — in every
case meaning *transport*, and in every case readable as *semantics*.

This proposal adopts and requires two terms:

- **ABI transport** — how the bits of a value cross a call boundary. Sailfin's
  transport for every user struct and enum is a **boxed pointer** (`%T*`),
  adopted to dodge an AArch64 aggregate-return legalizer miscompile
  (`compiler/capsules/codegen-llvm/src/type_mapping.sfn:724-748`,
  `map_return_type`, with `map_parameter_type` at 640-647 and `map_local_type`
  at 649-654 delegating to it). Interfaces are deliberately by-value fat
  pointers. **This proposal changes none of it.**
- **Value semantics** — what a program observes when it binds, passes, or
  returns a value. This proposal changes exactly this.

The two are independent: a value-typed language may transport by pointer (this
one does), and a reference-typed language may transport by register. The
deliverable is a mechanical rename pass over the four artifacts above plus a
glossary entry, so the next reader is not required to re-derive the distinction
from a test-file comment.

`compiler/tests/e2e/struct_abi_test.sfn:279` asserts the wire signature
`(i64 %head, %P* %p, i64 %tail)` and lines 304-305 assert the *absence* of a
by-value `%P %p` form. **Both assertions must stay green through every phase of
this proposal.** They are the mechanical guard that layer 1 never leaks into
layer 3.

## 4. Effect & capability impact

**None directly.** Value semantics introduces no new effect, changes no
canonical effect (`clock`, `gpu`, `io`, `model`, `net`, `rand`), and adds no
capability. The new diagnostics are pure type/place rules and run in the
typecheck walk, before the effect checker.

One indirect strengthening worth recording: the Reach pillar's manifest
completeness argument assumes a callee cannot reach out and modify its caller's
state through a non-obvious channel. Today an ordinary struct parameter *is*
such a channel. Closing it removes a hole in the informal reasoning behind
`E0402`/`E0403`, without changing any code that computes them.

## 5. Self-hosting impact

### 5.1 Passes changed, by phase

| Pipeline stage | Change |
|---|---|
| Lexer / parser / AST | **None.** `let mut`, `mut <param>`, `mut self`, and `mut` fields all already parse. |
| Analyzer — symbols | `SymbolEntry` (`typecheck_types/symbol_table_and_raw_exprs.sfn:23-67`) gains `is_mutable: boolean`, populated at `typecheck/symbols.sfn:356` (variables) and `typecheck/function_scopes.sfn:76,214` (parameters). |
| Analyzer — typecheck | New place-root check in the `Assignment` arm, `typecheck/expression_walk.sfn:369`. Emits `E0919`/`E0920`. |
| Analyzer — effects / ownership | Unchanged. The affine carve-out (§3.6) is the existing `ownership_checker.sfn` behaviour. |
| `emit_native` | **None.** `mut` already round-trips (`emit_native.sfn:491,822`; `emit_native_format.sfn:599,634`; `native_ir_utils_parse.sfn:779-783`). Phase 4 adds one marker on `Let` values and call arguments. |
| LLVM lowering | `prepare_parameters_from_function` (`lowering/emission.sfn:220-268`) gains its first callee prologue; `lower_let_instruction` (`lowering/instructions_let.sfn:614`) gains a copy branch. A shared `emit_struct_copy` helper. |

The lowering change is the only structurally new thing:
`prepare_parameters_from_function` binds `ParameterBinding.llvm_name` directly
to the incoming SSA register — there is **no callee prologue at all today**, for
scalar or struct parameters. The model to mirror is the local-binding path's
`alloca` at `instructions_let.sfn:614`. Extern (`is_extern`) functions are
excluded: they are not Sailfin bodies.

### 5.2 Seed dependency

Per `.claude/rules/seed-dependency.md`, applied rather than re-derived:

**Phase 1 (mutability enforcement) bundles; no seed cut.** The compiler change
is a new *rejection*, and its consumer is the source migration. `sfn dev
bootstrap build` builds the new compiler from the *old* seed (which has no
check, so the un-migrated tree still compiles it), and that fresh compiler then
compiles the migrated compiler source in the same pass. The migration adds only
`let mut` / `mut <param>` / `mut self`, all of which the pinned seed 0.10.6
already parses (§3.3), so the migrated tree is also acceptable to the old seed.
Splitting the check from its migration would manufacture a release cycle that
bundling does not need.

**The runtime carve-out does not bite.** The carve-out covers runtime source
that *calls* a compiler capability the seed lacks. The runtime edits here —
`let` → `let mut`, `mut self`, and the `-> SecretBuf` returning shape — call no
new capability; every construct already exists in the seed. The rule's own
scope limit is explicit that it "does not extend to runtime source that merely
*changes*". Runtime source is compiled by the pinned seed during the first
pass, and by the freshly built compiler during the seedcheck pass; both accept
the migrated form, so the pass is coherent in both directions.

**Phases 2-4 (copy emission) bundle; no seed cut, with one stated skew.** These
change *emitted code*, not accepted syntax. During pass 1, runtime objects are
built by the old seed (no copies) while compiler objects are built by the new
compiler (with copies). They link and run because the copy is intra-function
and the wire signature is unchanged (§3.5, §3.8). The skew is **semantic, not
ABI**: a `mut` parameter in seed-compiled runtime source does not get its
copy-in until the seed advances. The mitigation is a scheduling rule, not a
gate — **do not introduce `mut` struct parameters into `runtime/` source in the
same PR as Phase 2**; let the cadence seed bump (`cadence-seed-pin.yml`) carry
the capability first. Today there are zero `mut` parameters anywhere, so the
rule costs nothing to follow.

**Net: zero seed cuts across all five phases.** This is a stronger result than
the initial blast-radius reading suggested, and it rests on one specific fact —
that the `SecretBuf` fix needs no new compiler capability — only a `*SecretBuf`
parameter, which is the runtime's dominant idiom at 247 existing sites (§3.6). If a future revision of the design instead
requires a new `inout`/pointer-marker capability for runtime source, the
carve-out applies immediately and the cost is one seed cut; land the complete
capability family in that single PR rather than trickling it per consumer.

### 5.3 Migration size

Every figure below is from a mechanical pass over `compiler/src/`,
`compiler/capsules/` and `runtime/`.

| Edit | Count |
|---|---|
| `let` → `let mut` for whole-binding reassignment (`E0919`) | ~15 bindings / 26 statements |
| `let` → `let mut` for field writes through an immutable local (`E0920`) | **46 distinct bindings** / 247 statements — of which only **2 bindings are in compiler source** (the rest is `runtime/`, concentrated in `lexer.sfn` where one `let state: LexerState` at `:31` covers 54 writes) |
| `self` → `mut self` in methods that write `self` | 0 — the only candidate (`secret_buf_zeroize`) takes the `*SecretBuf` form instead |
| `secret_buf_zeroize` / `secret_buf_declassify_copy` to the `*SecretBuf` form (§3.6) | 2 signatures; call sites unchanged |
| Struct-array element writes (`arr[i].f = v`) | **0** — unaffected by §3.2 |
| `mut` field declarations to remove | **0** — none exist |

The whole migration is on the order of **60-70 one-word edits plus two function
signatures**. It is large in *reach* (many files) and trivial in *depth* (no
logic changes).

### 5.4 Coverage gaps in the measurement, stated rather than papered over

- `compiler/tests/**` was outside the scan and holds ~93 candidate field-write
  lines still unaudited. Phase 1 will surface them as build errors; budget for
  them.
- Transitive mutation was chased **one call level deep** only. A function that
  passes its own struct parameter to a mutating helper two levels down was not
  detected. Phase 1's diagnostic finds these mechanically at the write site, so
  the risk is schedule, not correctness.
- Multi-line assignment statements were not matched, and **non-writing
  aliasing** — identity comparison of two struct bindings, or one struct
  stashed in two collections and expected to stay in sync — was not searched at
  all. The latter is the residual behavioural risk of this proposal, and no
  diagnostic will find it: it fails as a wrong value, not an error.
- `site/`, `examples/` and the spec chapters were unscanned. Examples are
  compiler-only unless marked future-syntax, so they must be re-run.

## 6. Alternatives considered

### 6.1 Keep reference semantics, document it, ship

**Rejected.** It is the zero-migration option and the only one with a real
argument — TypeScript users would find it unsurprising, and the four Category A
runtime sites keep working untouched. It loses on three counts. First, the
`fn f(x: T)` hazard is *undiagnosable* under it: there is no rule the compiler
could add that would flag a callee mutating its caller, because that is the
defined behaviour. Second, the repository disagrees with it — 111 Category B
sites are written on the value assumption and zero sites exploit aliasing, so
"documented reference semantics" would document a model nobody in the codebase
uses. Third, it fights the owned family: `OwnedBuf`/`SecretBuf` need one live
binding, and a language whose default is "two names, one object" makes that a
special case rather than the general rule tightened.

### 6.2 Value types with eager copy on every bind and argument

**Rejected on memory, not on style.** This is the straightforward
implementation and it is what most languages do, because most languages have a
generational GC or stack-allocated aggregates. Sailfin has neither: struct
copies go to the arena, the compiler runs under an 8 GiB `RLIMIT_AS`, and
per-module peak RSS is an open 1.0 roadmap item. Copying `TypeckCtx` on every
typecheck-walk call, or `NativeFunction` on every lowering call, is not a
constant-factor slowdown — it is arena growth proportional to walk steps,
retained until phase rewind. §3.5's mutability-gated elision obtains the same
observable semantics at zero cost for the immutable majority.

### 6.3 Reference semantics plus an explicit `copy` / `.clone()`

**Rejected.** It addresses only the assignment face (`let b = a.clone()`) and
leaves the parameter face — the more dangerous one, because it is invisible at
the call site — exactly as it is. It also adds surface area (`.clone()` on every
struct, or a `copy` keyword, and "libraries over keywords" argues against the
latter) to buy a subset of what §3.1 gives for free. It is the option that
looks like a compromise and is actually the union of both models' costs.

### 6.4 Field-level `mut` as a second gate

**Rejected on measurement.** See §3.4: zero `mut` fields exist across 543
structs, so it is a 543-struct migration for an expressiveness gain no peer
language has. Deprecating the modifier is cheaper and removes a spec
contradiction.

### 6.5 Make `arr[i]` yield a copy

**Rejected.** See §3.2: it breaks 46 statements across 11 files *silently*, and
it is not what value semantics means in any peer language. Nothing recommends
it.

### 6.6 Do value semantics without mutability enforcement

**Rejected as incoherent.** §3.5's elision is *justified* by §3.3 — the argument
that no write is observable through an un-copied binding depends on writes
being confined to mutable places. Without enforcement the only sound
implementation is 6.2, which the memory budget rejects. The two layers are
separable in the *specification* and inseparable in the *implementation*.

## 7. Stage1 readiness mapping

Nothing here is shipped. Per `.claude/rules/proposals.md` this SFEP stays
`Draft` until the design gate passes, then `Accepted`, and reaches
`Implemented` only when **Phase 4** completes — because until then the value
model has a stated observational hole (§3.5 row 3) and "parsed but not
enforced is not shipped".

- [ ] Parses — no new syntax; `mut` in all three positions already parses (§3.3)
- [ ] Type-checks / effect-checks — Phase 1 (`E0919`/`E0920`)
- [ ] Emits valid `.sfn-asm` — Phase 1 requires none; Phase 4 adds one marker
- [ ] Lowers to LLVM IR — Phases 2-4
- [ ] Regression coverage — §8
- [ ] Self-hosts — required per phase; Phase 1 carries the source migration
- [ ] `sfn fmt --check` clean — per phase
- [ ] Documented in `docs/status.md` + spec §3.1/§3.3/§6 — Phase 5

Per-phase readiness is in §9.

## 8. Test plan

**Phase 1 — mutability (`compiler/tests/integration/mutability_check_test.sfn`,
`compiler/tests/e2e/struct_mutability_diagnostics_test.sfn`)**

- `let x = 1; x = 2;` → exactly one `E0919`, span on the assignment.
- `let mut x = 1; x = 2;` → clean.
- `fn f(p: P) { p.a = 1; }` → `E0920`, fix-it naming `p` and its declaration.
- `fn f(mut p: P) { p.a = 1; }` → clean.
- `fn m(self) { self.a = 1; }` → `E0920`; `fn m(mut self)` → clean.
- Nested place: `let s = O{…}; s.inner.x = 1;` → `E0920` rooted at `s`.
- Array place: `let mut a: P[] = …; a[0].f = 1;` → clean (§3.2), and
  `let a: P[] = …; a[0].f = 1;` → `E0920`.
- Raw-pointer exemption: `fn f(s: *S) { s.x = 1; }` → clean, no diagnostic.
- `unsafe { }` interior write through an immutable root → clean.
- `sfn check` and `sfn build` agree on every case above — extend
  `compiler/tests/e2e/check_build_agree_module_global_test.sfn`'s pattern, since
  this is precisely the #1389 build-only class.

**Phases 2-3 — copy emission
(`compiler/tests/e2e/struct_value_semantics_test.sfn`)**

- `fn mutate(mut p: P) { p.a = 999; }` called on `let m = P{a:1}` → `m.a == 1`.
- `let mut c = orig; c.a = 42;` → `orig.a` unchanged.
- Nested struct copy is deep: mutating `c.inner.x` leaves `orig.inner.x`.
- Fresh-rvalue elision emits no `@sfn_alloc_struct` beyond the literal's own —
  an emit-and-inspect assertion, so a future regression to eager copying is
  caught as a *cost* regression, not just a correctness one.
- **`compiler/tests/e2e/struct_abi_test.sfn:279` and `:304-305` stay green**
  unmodified. That file's SFN-692 note at `:24-30` is rewritten to cite this
  SFEP and the §3.8 vocabulary.

**Phase 4 — mutable-source copy**

- `let mut a = P{x:1}; let b = a; a.x = 2;` → `b.x == 1`.
- `fn id(p: P) -> P { return p; } let mut m = …; let r = id(m); m.x = 2;` →
  `r.x` unchanged.

**Affine composition (§3.6)**

- `compiler/tests/e2e/secret_buf_runtime_test.sfn:257,272` — the double-zeroize
  idempotence assertion, driven from the embedded C harness — passes
  **unmodified** against the `*SecretBuf` form. If it needs any edit, the design
  in §3.6 is wrong and must be revisited before Phase 1 merges.
- Passing a `SecretBuf` twice raises `E0901`, not a silent copy.
- `compiler/tests/integration/ownership_e6_test.sfn` unaffected.

**Suite-level**

- `sfn dev bootstrap build` per phase; `sfn dev clean build` for Phase 1
  (structural: new `SymbolEntry` field).
- `sfn dev verify` once, at the end of Phase 4.
- Re-run `examples/` — §5.4 flags them as unscanned.

## 9. Implementation plan

Five phases, sequenced. Sizes assume the "session-sized issue" bar in
`docs/conventions/linear-workflow.md`. Per the decomposition discipline in
`CLAUDE.md`, capability and consumer are bundled wherever they share a session.

**Phase 1 — Mutability enforcement + source migration.** Size **L**, one issue,
one PR. Thread `is_mutable` into `SymbolEntry`; add the place-root check and
`E0919`/`E0920` in `typecheck/expression_walk.sfn`; migrate ~46 bindings, ~15
reassignments and `secret_buf_zeroize`/`_declassify_copy`; fix spec §3.1/§3.3.
*Cannot honestly be split*: the check without the migration does not self-host,
and the migration without the check is a no-op diff. The natural-looking seam
(`E0919` vs `E0920`) shares the `is_mutable` threading and the root-resolution
helper, so splitting it yields two PRs sharing 90% of their infrastructure and
two self-host cycles — a manufactured split. **Clears Stage1 fully.**

**Phase 2+3 — Copy-in for `mut` parameters and mutable local binds.** Size
**M**, one issue. A shared `emit_struct_copy` helper; the callee prologue in
`prepare_parameters_from_function`; the copy branch in `lower_let_instruction`.
Bundled deliberately: the two consumers share the helper, the test file, and
the seed-skew consideration in §5.2. Phase 2 lands with zero call sites in tree
(there are no `mut` parameters yet), so it ships dormant and fully tested.
**Clears Stage1 fully.**

**Phase 4 — Mutable-source copy.** Size **M/L**, one issue. The analyzer marks
a `Let` value or call argument whose source root is a mutable place; lowering
emits the copy only when marked, keeping the lowering dumb and the cost
proportional to actual mutable state. **This is the phase that makes the model
hold**; only on its merge may this SFEP become `Implemented`. **Clears Stage1
fully.**

**Phase 5 — Deprecation, vocabulary, docs.** Size **S**, one issue,
independent of 2-4 and runnable in parallel with them. `W0921` on `mut` field
declarations; the §3.8 rename across SFEP-0021 R3, `struct_large_return_test.sfn`,
`abi_value_return_test.sfn`, `struct_abi_test.sfn:24-30` and SFN-650's title; a
glossary entry; `docs/status.md:1521` and spec §6. **Clears Stage1** (it is a
warning plus documentation; the warning is enforced, so it is not "parsed but
not enforced").

Post-1.0, not part of this proposal: dropping the `mut` field modifier from the
grammar once a seed carrying `W0921` has shipped.

## 10. Diagnostic code allocation

A repo-wide scan
(`rg -o --no-filename '[EW][0-9]{4}' compiler runtime docs site | sort -u`)
finds `E08xx` occupied through `E0842`, `E09xx` through `E0918`, `E10xx`
through `E1024`, and `E1100`-`E1114` owned by SFEP-0062. `E1200`-`E1299` is
unallocated but is where SFEP-0065 §4 points a future `sfn/sync` diagnostic.

This proposal allocates in **`E09xx`** — the ownership/affine range
(`docs/style-guide.md`, home `ownership_checker.sfn`) — because mutability *is*
the ownership floor's first rung and the rules compose directly with
`E0901`-`E0907` (§3.6). Three codes are taken; the home extends to the
typecheck walk, since the check runs there:

| Code | Severity | Meaning |
|---|---|---|
| **`E0919`** | error | Assignment to an immutable binding. `'<name>' is immutable; declare it as \`let mut <name>\`` |
| **`E0920`** | error | Write through an immutable place. `cannot write through '<name>' (declared at <span>); it is an immutable <binding\|parameter>` |
| **`W0921`** | warning | Deprecated field-level `mut` modifier; the enforced gate is the place, not the field declaration (§3.4) |

`E0919`-`E0921` are hereby reserved; other drafts must skip them. `W0921`
follows the existing `E0823`/`W0823` convention of a warning sharing its
number with its family rather than opening a `W09xx` block for one code.

## 11. Migration and compatibility

**What breaks, and how loudly.**

| Change | Loudness |
|---|---|
| Writing through an immutable binding or parameter | **Loud** — `E0919`/`E0920` at check time, with a one-word fix-it |
| A callee mutating its caller's struct | **Loud** — becomes `E0920` unless the parameter is `mut`, at which point it is a copy and the caller is correctly unaffected |
| `let b = a; b.f = v` expecting `a` to change | **Loud** — `E0920` until `b` is `let mut`, then a copy |
| `arr[i].f = v` | **Not a change** (§3.2) |
| Two bindings expected to stay in sync without either being written *in the same function* | **Silent** — the residual risk in §5.4; no diagnostic finds it. Zero instances found, but the search was incomplete |
| `mut` on a struct field | **Soft** — `W0921`, never fails a build |

**No deprecation period is proposed for `E0919`/`E0920`.** A warning phase was
considered and rejected: the migration is ~60 one-word edits with a mechanical
fix-it, it lands in the same PR as the check, and a warning-only phase would
leave the hazard live while advertising that it had been addressed — the exact
"parsed but not enforced" failure the repo rules forbid. The `mut` field
modifier *does* get a deprecation period (`W0921`), because there the removal
is a grammar change that must survive a seed transition.

**External compatibility** is not a constraint: there is no published capsule
ecosystem depending on struct aliasing, and `examples/` is compiler-only unless
marked future-syntax.

## 12. Future considerations

- **Arrays.** The obvious next question is whether `T[]` should follow. It is a
  much larger migration (`.push()` through immutable bindings is pervasive) and
  should not be smuggled in here. §3.2's place rule is deliberately written so
  that an array value-semantics decision would compose with it rather than
  contradict it.
- **`&T` / `&mut T`.** Once SFEP-0018 lands borrow checking, `&mut T` becomes
  the safe explicit by-reference parameter form and `mut <param>`'s copy-in can
  be documented as "the safe default; take `&mut` when you mean to share".
  §3.3's raw-pointer exemption then narrows to genuine FFI.
- **Copy elision widening.** §3.5 states the soundness condition explicitly so
  a later optimizer can elide row-3 copies via escape analysis without
  re-litigating the semantics.
- **`Copy` vs non-`Copy`.** This proposal makes all non-affine structs
  implicitly copyable. If a future design wants opt-out (a large struct that
  should move rather than copy), the affine family (§3.6) is already the
  mechanism; no new axis is needed.

## 13. References

- **SFN-692** — the `needs-design` issue this resolves; source of the
  layer-1/layer-3 conflation this proposal names in §3.8.
- **SFN-1127** — downstream issue blocked on this decision.
- **SFN-784** — `E0903` use-after-zeroize enforcement for `SecretBuf`; §3.6
  raises its priority.
- **SFN-650** — the struct ABI-transport verification whose title carries the
  §3.8 vocabulary error.
- **SFEP-0018** — ownership lattice, the `OwnedBuf` family, `E0901`-`E0907`;
  the affine carve-out in §3.6 is its machinery, unchanged.
- **SFEP-0069** §3.2, §3.4, §3.5 — secret-buffer zeroization; defers to this
  decision by name and supplies the §2.4 break.
- **SFEP-0021** Risk R3 — the boxed-pointer transport rationale and the
  correction establishing that LLVM IR is not ABI-neutral for aggregates;
  source of the §3.5 claim that an intra-function copy carries no ABI exposure.
- **SFEP-0026** WS-B/WS-C, and `.claude/rules/seed-dependency.md` — the
  bundle-by-default rule and the runtime carve-out applied in §5.2.
- `compiler/capsules/codegen-llvm/src/type_mapping.sfn:640-654, 724-748` — the
  boxed-struct ABI.
- `compiler/capsules/codegen-llvm/src/lowering/emission.sfn:220-268` — the
  parameter binding path with no prologue.
- `compiler/capsules/codegen-llvm/src/lowering/instructions_let.sfn:614` — the
  `alloca` model to mirror.
- `compiler/tests/e2e/struct_abi_test.sfn:24-30, 279, 304-305` — the existing
  SFN-692 note and the wire-ABI assertions that must stay green.
- `site/src/content/docs/docs/reference/spec/03-declarations.md:16, 91` and
  §3.3 — the documented-but-unenforced rules and the self-contradiction.
- Prior art: Rust (value structs, `let mut`, `mut` parameters, `v[i].f = x` as
  a place), Go (value structs, explicit `*T`), C# (value `struct` vs reference
  `class`), TypeScript (the rejected reference model).
