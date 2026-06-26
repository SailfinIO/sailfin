---
sfep: 0031
title: Inline `export <declaration>` syntax
status: Accepted
type: language
created: 2026-06-26
updated: 2026-06-26
author: "agent:compiler-architect; human review"
tracking: "#1681, #1680"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0031 — Inline `export <declaration>` syntax

## 1. Summary

Sailfin today supports only the **block** export form — `export { name1, name2 };`
and the re-export `export { x } from "./mod";`. The **inline** form that
TypeScript and Rust users (and LLMs) reach for first — `export fn foo() { ... }`,
`export struct Foo { ... }` — is silently mis-handled: the parser routes *any*
`export` token to the block parser, which expects `{`. The leading declaration
keyword is then mis-parsed and, critically, the declaration's name is **never
added to the module's export manifest**. The declaration is still defined (so it
is callable within its own module), but it is internalized at LLVM level and its
signature is invisible to importers — producing the cross-module
`llvm lowering [fatal]: cannot resolve return type for call to \`...\` — callee
signature is not known to the compiler` (issue #1681 / PR #1680).

This SFEP makes the inline `export <declaration>` form a real, first-class
surface that is exactly equivalent to declaring the item and naming it in a
block export: `export fn f() {}` ≡ `fn f() {} export { f };`. It is additive
(the block form is unchanged and stays the canonical form the compiler tree
uses), it touches only the parser plus docs/tests, and it closes a
"boring-syntax" footgun that today fails with an opaque late-stage error.

## 2. Motivation

### The footgun (root-caused, #1681 / #1680)

A maintainer wrote the natural module API:

```sfn
export struct ShardSpec { valid: boolean, index: int, total: int }
export fn _parse_shard_value(text: string) -> ShardSpec { ... }
export fn _shard_select_indices(count: int, index: int, total: int) -> int[] { ... }
```

`make compile` failed at LLVM lowering with `cannot resolve return type for call
to \`_parse_shard_value\` — callee signature is not known to the compiler`. The
failure is not about the return type (it reproduces for `-> int` too); it is
about the *export* being dropped. The diagnostic appears at stage 6 (LLVM
lowering) in a *different module* (the importer), with no pointer back to the
real cause (the producer's `export fn` was parsed as a no-op export). The
workaround that shipped (`cli_commands_utils.sfn:718-776`) had to flatten a
struct-returning / `int[]`-returning API down to `int`/`boolean` returns and
left a comment blaming a "compiler-robustness follow-up." The real defect is the
unsupported inline export form.

### Why support it (not reject it)

- **Boring syntax wins.** `export fn` / `export struct` is the dominant form in
  TypeScript and (modulo `pub`) Rust. Requiring a separate `export { ... }` block
  is a gratuitous deviation with zero expressiveness gain.
- **AI agents are users.** LLMs have no `.sfn` training corpus; they emit
  conventional `export fn` by default. This is *literally* what triggered #1680.
  Every model-authored module is a latent instance of this bug today.
- **Silent mis-handling is the worst failure mode.** The current behaviour is not
  a clean "unsupported syntax" diagnostic at the `export` site — it is a
  *successful parse* that produces a wrong export manifest and explodes much later
  in an unrelated module. That violates "don't ship unfinished safety claims"
  in spirit: the construct *looks* accepted but is silently wrong.

### Current visibility model (verified — load-bearing for this design)

A bare top-level `fn`/`struct` is **module-private by default**. Cross-module
visibility is opt-in through the export manifest:

- The export manifest is the `.export "..." { name, ... }` directive in a
  module's `.sfn-asm`, emitted from `Statement.ExportDeclaration`
  (`emit_native.sfn:224-232`).
- `collect_exported_symbol_names` (`llvm/rendering_helpers.sfn:393`) reads those
  directives back into the importer's `exported_symbols` set.
- `should_internalize_function` (`llvm/rendering_helpers.sfn:443-451`) marks any
  function that is **not** an entry point, **not** in `exported_symbols`, and not
  one of a few hardcoded driver-API names as LLVM `internal` — i.e. unlinkable
  across modules and signature-invisible to importers. Exported module-global
  `let` bindings are similarly gated (`lowering_phase_imports.sfn:52-76`).

So `export` is **load-bearing, not advisory**: naming a symbol in the export
manifest is exactly what (a) keeps it externally linkable and (b) makes its
signature resolvable cross-module. The inline form's job is therefore narrow and
precise: **parse the declaration normally AND add its name to the same export
manifest the block form populates.** Once the name is in the manifest, every
existing downstream consumer — internalization, signature resolution, binding
inlining — works unchanged, because the producer already emits the full function
body/signature into its `.sfn-asm` regardless of export status (the export
directive is what gates visibility, not the presence of the body text).

## 3. Design

### 3.1 Grammar

Add an inline export production that prefixes an existing top-level declaration:

```
ExportDecl     ::= "export" ExportBlock              // existing: { ... } [from "src"]
                 | "export" ExportableDeclaration    // NEW: inline

ExportableDeclaration ::=
       FunctionDeclaration            // export fn / export async fn
     | StructDeclaration              // export struct
     | EnumDeclaration                // export enum
     | InterfaceDeclaration           // export interface
     | TypeAliasDeclaration           // export type
     | VariableDeclaration            // export let (module globals; Sailfin has no `const`)
     | ExternFunctionDeclaration      // export extern fn / export unsafe extern fn
     | ExternVarDeclaration           // export extern var / export unsafe extern var
```

**Dispatch:** the inline vs. block decision is made on the token *after* `export`:

- `export` followed by `{` → existing block/re-export parser (unchanged).
- `export` followed by any declaration-introducer keyword (`fn`, `async`,
  `struct`, `enum`, `interface`, `type`, `let`, `extern`, `unsafe`,
  `thread_local`) → inline parser.
- `export` followed by anything else → existing behaviour (the block parser's
  `consume_symbol("{")` already produces the current diagnostic for malformed
  exports; no new error path is introduced).

This is a one-token lookahead with no ambiguity: `{` is never a declaration
introducer, and no declaration introducer overlaps the re-export `from` keyword.

### 3.2 Semantics — exact equivalence

```sfn
export fn f() -> int { return 1; }
```

is **exactly equivalent** to

```sfn
fn f() -> int { return 1; }
export { f };
```

The inline form adds the declared name to the module export manifest with **no
alias** (`ExportSpecifier { name: "f", alias: null }`). It never carries a
`from` source (re-export is block-only — there is no declaration to re-export
*and* define). All declaration semantics (effects, decorators, async,
visibility-of-the-body) are identical to the un-prefixed declaration; `export`
adds *only* the manifest entry.

### 3.3 AST representation — lowest blast radius

**Recommended: synthesize the existing `Statement.ExportDeclaration` alongside
the declaration statement. Do not add a new AST node and do not add an
`exported: bool` flag.**

The inline parser produces **two** statements from one source construct:

1. the ordinary declaration statement (`FunctionDeclaration`, `StructDeclaration`,
   …) exactly as the existing declaration parser builds it, and
2. a `Statement.ExportDeclaration { export_specifiers: [ {name, alias: null} ],
   source: "" }` naming the declared symbol.

Rationale:

- **Zero downstream change.** `emit_native.sfn`, `emitter_sailfin.sfn`,
  `reexport_check.sfn`, `collect_exported_symbol_names`,
  `should_internalize_function`, and the binding-export path already consume
  exactly this shape. The block form and the inline form converge on the same IR
  (`.export "..." { f }` + the function body), so the rest of the pipeline cannot
  tell them apart — which is the goal.
- **No flag to thread.** An `exported: bool` on every declaration node would touch
  `ast.sfn`, every constructor site, the native emitter (to translate the flag
  into a `.export` directive), and `count_exported_symbols`. The synthesized-pair
  approach keeps the change inside the parser.

**Statement-list plumbing:** the top-level dispatcher
(`parser/mod.sfn:parse_statement`) returns a single `StatementParseResult`
(one statement per call). The inline export needs to contribute *two*
statements. Two equally-valid options for the implementer (pick one at
implementation, no semantic difference):

- **(A) Emit-order: declaration first, export second.** Have the inline-export
  parser parse the declaration, then push the synthesized `ExportDeclaration` via
  the same mechanism the parser already uses to emit a trailing statement. If the
  statement-collection loop is strictly one-result-per-call, introduce a tiny
  parser-internal "pending statement" queue drained before the next dispatch.
- **(B) Wrap in a block-free group.** If a `Statement` group/sequence node
  already exists for desugaring (check before adding one), reuse it. *Do not add
  a new public AST node solely for this* — option (A) is preferred precisely to
  avoid that.

The architect's recommendation is **(A)**, since it keeps the AST surface
untouched. The export-order (decl before its `.export`) matches what the block
form already does in practice and what `emit_native` expects.

### 3.4 Interactions

- **Coexistence with the block form.** Both forms may appear in the same module.
  A symbol exported both inline and via a block (`export fn f(){} ... export { f };`)
  produces two `.export ... { f }` entries; `collect_exported_symbol_names`
  already de-dupes (`string_array_contains` guard, `rendering_helpers.sfn:419`),
  so this is harmless. **No new double-export diagnostic is required** for 1.0;
  it is a no-op, not an error. (A lint may be added later but is out of scope.)
- **Re-exports (`from`).** Inline export never has a `from` source — there is a
  concrete declaration being defined. The `from` clause stays exclusive to the
  block form. The dispatcher guarantees this: a `from` re-export always starts
  with `{`.
- **Decorators.** The canonical order is **`@deco` before `export`** is *not*
  chosen; instead `export` leads and the decorator attaches to the declaration:
  `export @logExecution fn f() {}`. Rationale: `parse_statement` already collects
  decorators *before* dispatching on the keyword (`mod.sfn:99-112`), and it
  refuses decorators on `export`/`import` today (`mod.sfn:111` →
  `parse_unknown`). The cleanest path is: the inline-export parser, after
  consuming `export`, **re-enters decorator collection** for the declaration it is
  about to parse, so `export @deco fn` works and the decorator lands on the
  function. The leading-`@deco export fn` order stays rejected (consistent with
  today's "no decorators on export" rule) to avoid a second decorator-collection
  site in the top-level dispatcher. **Open question O1** (below) flags this for
  the gate — if the gate prefers `@deco export fn`, the dispatcher's
  `decorators.length > 0 → parse_unknown` guard at `mod.sfn:111` is relaxed to
  forward the already-collected decorators into the inline-export parser instead.
- **Default visibility unchanged.** Bare `fn`/`struct` remains module-private.
  This SFEP does **not** introduce export-by-default. `export` continues to mean
  exactly "add to the manifest"; the inline form is sugar over the existing
  manifest mechanism, nothing more.
- **`thread_local`.** `export thread_local let mut x: int = 0;` is supported by
  routing through the existing `parse_variable_with_storage(..., true)` path
  (`mod.sfn:123-130`) and synthesizing the export entry for `x`. (Module globals
  are already exportable via the block form and value-inlined into importers
  per #1368.)

### 3.5 Worked examples

```sfn
// All five become manifest entries identical to a trailing `export { ... };`
export fn parse(text: string) -> Token[] { ... }     // export { parse };
export async fn fetch(u: string) -> Bytes ![net] {}  // export { fetch };
export struct ShardSpec { valid: boolean, index: int, total: int } // export { ShardSpec };
export enum Color { Red, Green, Blue }               // export { Color };
export type Id = int;                                // export { Id };
export let MAX: int = 256;                           // export { MAX };
export interface Reader { fn read() -> Bytes; }      // export { Reader };
export extern fn write(fd: int, buf: i8*, n: int) -> int;  // export { write };
```

The #1681 case becomes legal verbatim, and the `cli_commands_utils.sfn` shard
helpers can return `ShardSpec` / `int[]` as originally intended (a follow-up
issue, not part of this SFEP's required scope, can restore that API).

### 3.6 Resolved design-gate decisions (2026-06-26)

The three open questions were resolved at the design gate (owner approval):

- **O1 — decorator order: `export @deco fn` (export leads).** The inline-export
  parser re-enters decorator collection after consuming `export`, so
  `export @logExecution fn f() {}` attaches the decorator to `f`. The leading
  `@deco export fn` order stays rejected (the existing `mod.sfn:111` "no
  decorators on export" guard is unchanged), avoiding a second
  decorator-collection site in the top-level dispatcher.
- **O2 — double-export is a harmless de-duped no-op.** A symbol exported both
  inline and via a block produces two `.export` entries that
  `collect_exported_symbol_names` already de-dupes. No diagnostic for 1.0.
- **O3 — all declaration forms ship in the first PR:** `fn` / `async fn`,
  `struct`, `enum`, `interface`, `type`, `let`,
  `extern fn` / `extern var`, and `thread_local let mut`.

## 4. Effect & capability impact

**None.** Export is a visibility/manifest concern, orthogonal to the effect
system. `export fn f() ![io] {}` carries exactly the effects the un-prefixed
declaration would; the effect checker walks the same `FunctionDeclaration` node.
No effect is added, removed, or inferred by the presence of `export`. No
capability surface changes.

## 5. Self-hosting impact

**Passes changed:** parser only (`compiler/src/parser/declarations.sfn`,
`compiler/src/parser/mod.sfn`). AST (`ast.sfn`) is **unchanged** under the
recommended synthesized-pair design. Typecheck, effect checker, native emitter,
and LLVM lowering are unchanged — they already consume `Statement.ExportDeclaration`
and the declaration nodes the inline form produces.

**Self-host invariant:** the change is **purely additive**. The compiler tree
uses the block form exclusively (verified: 65 of 175 `compiler/src` files use
`export { ... }`; **zero** files use any inline `export fn/struct/...`). So:

- The old seed compiles the new compiler with no change to existing source.
- The new compiler accepts a strict superset of the old grammar.
- Nothing in `compiler/src/*.sfn` is rewritten to *use* the new form as part of
  this SFEP, so there is no circular bootstrap dependency.

**Seed dependency (per `.claude/rules/seed-dependency.md`):** the parser change
alters the compiler binary's behaviour, so it is a compiler-source capability.
**But there is no in-tree consumer** — no `compiler/src` file needs the inline
form to self-host. Therefore there is **no bundling decision and no seed-cut
gate**: this SFEP ships as a single parser PR. The new form simply becomes
available to user code (and to future compiler-source rewrites, which would only
land *after* this capability is in the pinned seed). The follow-up that restores
the `ShardSpec`/`int[]` shard API in `cli_commands_utils.sfn` (a compiler-source
*consumer*) is the one that must wait for a seed cut — and is explicitly out of
scope here.

## 6. Alternatives considered

- **(a) Reject inline export with a clean diagnostic (conservative non-feature).**
  Route `export fn`/`export struct` to `Statement.Unknown` and emit a typecheck
  diagnostic at the `export` site (the established idiom — cf. `while` → E0411 via
  `detect_unsupported_statement_keyword`). This *fixes the silent mis-handling*
  (the real hazard) but **rejects the syntax everyone reaches for**, contradicting
  "boring syntax wins" and "AI agents are users." It also forces every model and
  every TS/Rust-trained human to learn a Sailfin-specific export ritual. Rejected:
  the user decision (approved) is to *support*, not reject. The diagnostic-only
  fix is strictly worse than supporting, at comparable implementation cost.

- **(b) Export-by-default + explicit `private`/`internal`.** Make bare top-level
  declarations exported, and add a keyword to hide them. This is a far larger
  semantic change: it inverts the visibility model, changes the meaning of every
  existing bare declaration in the tree (175 files), requires auditing what should
  *not* leak across modules, and risks symbol-collision/over-linkage regressions
  in the self-host link. It also dilutes the manifest's role and is a much bigger
  blast radius for a 1.0 timeline. Rejected: out of proportion to the problem;
  the explicit-`export` model is conventional (TS/Rust) and already shipped.

- **(c) Status quo.** Leave inline export silently mis-handled. Rejected: it is an
  active footgun that fails late, in the wrong module, with an opaque message, and
  disproportionately hits LLM-authored code — the exact audience the project
  optimizes for.

## 7. Stage1 readiness mapping

- [ ] **Parses** — inline-export dispatch + per-declaration parsing in
  `parser/declarations.sfn` / `parser/mod.sfn`.
- [ ] **Type-checks / effect-checks** — no change required (declaration + synthesized
  `ExportDeclaration` are already handled); add tests proving effects survive.
- [ ] **Emits valid `.sfn-asm`** — no change; the synthesized `ExportDeclaration`
  emits the existing `.export "..." { name }` directive. Verify the producer's
  `.sfn-asm` carries the directive for an inline-exported symbol.
- [ ] **Lowers to LLVM IR** — no change; the manifest entry keeps the symbol
  external and signature-resolvable cross-module (the #1681 fatal disappears).
- [ ] **Regression coverage** — parser unit tests per form + cross-module e2e
  (§8).
- [ ] **Self-hosts** — `make compile` green (additive; no tree rewrite).
- [ ] **`sfn fmt --check` clean** — confirm the formatter round-trips
  `export fn`/`export struct` (formatter is parser-driven; verify it does not
  reorder `export` away from the declaration).
- [ ] **Documented** — `docs/status.md` (modules row) + spec
  `02-modules.md` (new inline-export section).

## 8. Test plan

**Parser unit tests** (`compiler/tests/unit/inline_export_*_test.sfn`), one per
form, asserting the program yields both the declaration statement **and** an
`ExportDeclaration` naming it:

- `export fn` and `export async fn`
- `export struct`, `export enum`, `export interface`, `export type`
- `export let` (module globals), `export thread_local let mut`
- `export extern fn` / `export unsafe extern fn` / `export extern var`
- Decorator case: `export @logExecution fn f() {}` parses, decorator lands on `f`,
  `f` is exported (resolves open question O1's chosen order).
- Coexistence: a module with both `export fn f(){}` and a later `export { f };`
  yields a de-duped manifest (no double-export error).
- Negative: `export` followed by neither `{` nor a declaration keyword still
  produces the existing malformed-export behaviour (no regression).

**Integration / emit** (`compiler/tests/integration/`): assert the emitted
`.sfn-asm` for a module with `export fn parse(...)` contains
`.export ... { parse }` (manifest parity with the block form).

**E2E cross-module** (`compiler/tests/e2e/inline_export_cross_module_test.sfn`):
a producer module declares `export struct ShardSpec { ... }`,
`export fn parse_shard(text: string) -> ShardSpec { ... }`, and
`export fn select(count: int, index: int, total: int) -> int[] { ... }`; a
consumer imports all three, calls them, and **builds + runs** to a binary that
prints a value derived from the `int[]` and the struct fields. This is the direct
#1681 regression — it must fail on today's compiler (the lowering fatal) and pass
after the change. Thread `PATH` + `SAILFIN_TEST_SCRATCH` into the nested build per
`.claude/rules/no-bash-e2e.md`.

**Self-host gate:** `make compile` then `make check`.

## 9. References

- Issue #1681 — inline `export fn`/`export struct` cross-module lowering fatal
  (the bug this SFEP resolves).
- PR #1680 — the change that hit it; shipped the `int`/`boolean` shard-helper
  workaround (`cli_commands_utils.sfn:718-776`) blaming a compiler follow-up.
- Issue #1237 — `--shard I/N` partitioning (the feature whose natural
  struct/`int[]` API was flattened by the workaround).
- Spec `site/src/content/docs/docs/reference/spec/02-modules.md` — current
  block-only export documentation (to be extended).
- `compiler/src/parser/declarations.sfn:565-605` (`parse_export`),
  `compiler/src/parser/mod.sfn:110-112` (dispatch),
  `compiler/src/llvm/rendering_helpers.sfn:393-451` (export manifest →
  internalization / visibility model evidence),
  `compiler/src/emit_native.sfn:224-232` (`.export` directive emission).
