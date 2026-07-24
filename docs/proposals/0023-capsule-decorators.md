---
sfep: 23
title: Capsule-Defined Decorators
status: Accepted
type: language
created: 2026-06-15
updated: 2026-07-24
author: "agent:compiler-architect"
tracking: "#1557"
supersedes:
superseded-by:
graduates-to:
---

# Capsule-Defined Decorators

Status: proposal (design gate)
Author: compiler architecture
Related: `docs/proposals/0008-effect-validation.md`,
`docs/proposals/0004-check-architecture.md`,
`docs/proposals/0020-compiler-decomposition.md` §7 (stdlib dogfooding),
`docs/proposals/0003-tooling.md` (deprecated-api lint).

## 1. Goal

Let capsules define, export, and import decorators as ordinary library
functions, and use that mechanism to move the two compiler-built-in decorators
(`@logExecution`, `@trace`) out of the compiler + always-linked runtime and
into the `sfn/log` capsule — without breaking self-hosting and without
weakening end-to-end effect enforcement.

## 2. Current state (verified)

`@logExecution` / `@trace` are **compiler built-ins, matched by literal string**
in three passes:

| Pass | Location | Behavior |
|---|---|---|
| Effect inference (parse-time) | `compiler/src/decorator_semantics.sfn:19-21` (`infer_effects`) | name `== "trace"`/`"logExecution"`/`"logexecution"` → force `![io]` into the signature |
| Effect checking | `compiler/src/effect_checker.sfn:387-398` (`analyze_routine`) | same string match → treat `io` as satisfied |
| Helper-use marking | `compiler/src/llvm/effects.sfn:473-481` | mark `runtime_log_execution_fn` used |
| Lowering | `compiler/src/llvm/lowering/emission.sfn:473-517` | emit `emit_runtime_call("runtime_log_execution_fn", [fn_name])` at function entry |

The lowering target resolves through the **always-linked runtime**:

- helper registry row: `compiler/src/llvm/runtime_helpers.sfn:673-675`
  (`target: "runtime_log_execution_fn"`, `symbol: "sfn_log_execution"`,
  ABI `(i8*) -> i8*`, `effects: ["io"]`).
- prelude alias: `runtime/prelude.sfn:71` (`let runtime_log_execution_fn = sfn_log_execution;`).
- body: `runtime/sfn/io.sfn:447` (`sfn_log_execution(value: * u8) -> * u8 ![io]`)
  — prints `[info] <fn-name>` and returns the value unchanged.

The decorator therefore receives **only the function name string** today. It
does **not** see args, return value, or timing. The `@trace` name lowers to the
identical hook (no distinct behavior).

Independently, `capsules/sfn/log/src/mod.sfn` is a real library capsule
(`Logger`, `log_info/warn/error/debug`, `info/warn/error/debug`, `timed`,
`timed_end`) with **no connection** to the decorator. `capsule.toml` declares
`required = ["io", "clock"]`.

The AST already models decorators with arguments:
`compiler/src/ast.sfn:209-217` (`Decorator { name, arguments: DecoratorArgument[] }`).
Parsing lives in `compiler/src/parser/declarations.sfn:124-217` and is applied to
functions, struct methods, structs, enums, interfaces.

**Critical self-hosting fact (verified):** the compiler and runtime sources use
**no** decorators (`grep` for `@log*`/`@trace` in `compiler/src` and `runtime`
returns only string-match logic, no usage sites). So the dogfooding migration
never has to route the compiler's own build through a capsule-resolved decorator.
This removes the hardest self-hosting risk up front.

There is already a clean precedent for the cross-module effect plumbing we need:
`ImportSymbolTable` / `ImportedFunctionSignature`
(`compiler/src/effect_imports.sfn:44-123`) carries `(name, effects)` for every
imported function, localized per-program with alias rewrite
(`localize_import_symbols_for_program`). The effect checker already looks up
imported call targets there. Decorator-implied effects can ride the **same
table** instead of a hardcoded string list.

## 3. Constraints

- **Self-hosting invariant.** `make compile` must pass at every step. The seed
  binary still string-matches `@logExecution`/`@trace` and still emits the
  `runtime_log_execution_fn` call, so any change to the *meaning* of those names
  must keep the old shapes alive until a post-flip seed is pinned.
- **Three pillars unchanged.** Decorators are a library/convenience mechanism,
  not a fourth pillar. No new keyword if a marker can do the job.
- **No unenforced safety claims.** Decorator-implied effects must be *enforced*
  (not just inferred-and-forgotten). A decorator carrying `![io]` must force its
  target to satisfy `io` end-to-end, or we do not ship it.
- **Boring syntax wins / libraries over keywords.** A decorator is just a
  function you import and apply with `@`. No bespoke decorator-declaration
  grammar if an attribute marker suffices.
- **Opt-in linking.** A capsule is dependency-resolved; the runtime helper is
  always linked. A capsule-resolved decorator must only link when its capsule is
  an actual dependency, and must produce a clean diagnostic when it is not.

## 4. Design

### 4.1 What a decorator *is* (the contract)

A decorator is an ordinary exported function, marked as decorator-eligible. The
"boring" framing: `@foo` on a function means "instrument `foo_target` with the
imported function `foo`." We deliberately pick the **simplest contract that
covers the current behavior and the `sfn/log` library shape**, and leave the
richer wrapping contract as an explicit open question (§9).

Two contract tiers, shipped in order:

**Tier 1 — entry hook (matches today's behavior, ships first).**
A decorator is a function called at the decorated function's entry, receiving the
decorator's own arguments followed by a descriptor of the call site. The
descriptor in Tier 1 = the function name (string); decorator arguments precede it
(resolved decision §9.5). Signature shape:

```sfn
// in capsules/sfn/log/src/mod.sfn
@decorator
fn logExecution(args: string[], fn_name: string) -> void ![io] {
    info(fn_name);          // reuses the library's own info()
}
```

`@decorator` is a **compiler-recognized marker attribute** on a function
declaration, not a new keyword (it reuses the existing decorator/attribute
grammar — `@decorator` parses today as a `Decorator { name: "decorator" }` on
the function, and the compiler interprets that marker). This honors "libraries
over keywords": no grammar change, the marker is just a recognized name.

The contract for Tier 1:
- Receives: the decorated function's name as `string`.
- Returns: `void` (the hook is fire-and-forget at entry).
- Effects: whatever the decorator body declares (`![io]` here). These propagate
  to the decorated function (§4.3).

This is intentionally narrower than a general wrapper. It reproduces
`@logExecution` exactly and unblocks the dogfooding. The signature is validated
(`(string[], string) -> void` arity/shape — args then function-name descriptor)
so "decorator" is enforced, not just parsed.

**Tier 2 — wrapper (post-dogfood, gated behind §9 resolution).** A decorator
that observes args/return/timing needs a wrapping contract (the function value
+ a way to invoke it). That requires closures-with-capture and/or a reflective
call ABI that the runtime does not yet expose. Tier 2 is **explicitly out of
scope for the dogfooding migration** and tracked separately so we do not ship a
half-built wrapper.

### 4.2 Resolution: `@foo` → an imported symbol

Today `@logExecution` is a free-floating name. Under this design a
capsule-defined decorator must be **imported into scope** exactly like any other
symbol, then applied:

```sfn
import { logExecution } from "log";

@logExecution
fn handler() ![io] { ... }
```

Resolution algorithm (new pass, runs after import resolution, before effect
inference finalization):

1. For each function/method, walk its `decorators: Decorator[]`.
2. For each decorator name, look it up in the program's localized import table
   (`localize_import_symbols_for_program` already produces this), restricted to
   symbols whose definition carries the `@decorator` marker.
3. Resolve to a `ResolvedDecorator { local_name, capsule, export_name, effects,
   tier }` record stored alongside the AST node (a new sidecar list, mirroring
   how `ImportSymbolTable` is threaded — no change to the `Decorator` struct
   layout, which is seed-layout-sensitive per `decorator_semantics.sfn:6-10`).
4. A decorator name that resolves to a non-`@decorator` symbol → `E07xx`
   "`foo` is imported but not a decorator." A decorator name that resolves to
   nothing and is not a recognized built-in → `E07xx` "unknown decorator `foo`
   (did you forget to import it?)."

**Capsule resolver interaction.** `capsule_resolver.sfn` already resolves
`import … from "log"` to the capsule's exported symbols and their signatures
(this is how `log_info`'s `![io]` already reaches the effect checker via the
import table). The decorator pass needs one extra bit per exported function:
**is it `@decorator`-marked?** That bit is carried in the same artifact metadata
that already carries each export's `effects` (the `.sfn-asm` /
`ImportedFunctionSignature` channel). Concretely: extend the staged export
record with an `is_decorator: boolean` (and the validated arity/return shape) so
the resolver can populate `ResolvedDecorator` without re-parsing the capsule.

**Built-in fallback during migration.** The compiler keeps a tiny built-in
decorator registry containing exactly `logExecution`/`trace` so that source
which has *not* imported them still works until the deprecation completes (§4.5).
This registry is the seam we delete at the end.

### 4.3 Effect inference: principled, not hardcoded

The current behavior synthetically injects `io` for two names. Replace with:
**a decorator contributes its own declared effects to the decorated function's
required-effect set**, exactly like a call to that function would.

- After resolution (§4.2), each `ResolvedDecorator` carries the decorator
  function's `effects` (from the import table — already populated for every
  exported function).
- `infer_effects` (parse-time, `decorator_semantics.sfn`) can **no longer** know
  effects, because parse-time has no import table. So move decorator-implied
  effect inference **out of the parser** and into the effect-checking stage,
  where the import table exists. `infer_effects` stops special-casing names; it
  becomes a no-op for capsule decorators (it may keep injecting for the
  built-in-fallback names during migration only).
- In `effect_checker.analyze_routine` (and the function/method analogues),
  replace the `name == "trace" || …` block (`effect_checker.sfn:386-398`) with:
  for each resolved decorator on the routine, union its `effects` into
  `declared`-vs-`required` reconciliation. The diagnostic for a missing effect
  becomes the existing `imported \`<name>\`` → `E0402` path
  (`effect_imports.sfn:13-15`) — a decorator is just an implicit call, so it
  reuses the imported-effect diagnostic family rather than inventing one.

This is the key correctness move: decorator effects are now **enforced
transitively** through the same machinery that enforces imported-function
effects. There is no separate hardcoded `io` injection to drift out of sync.

Reconciliation with `effect-validation.md` / `check-architecture.md`: both docs
describe a "decorator-implied effects" gate as a TODO. This design *is* that
gate's implementation — it makes decorator effects a function of the decorator's
signature, satisfying the docs' requirement that the gate not be name-hardcoded.
Update both docs to point at this proposal as the realization.

### 4.4 Lowering

Today: emit `emit_runtime_call("runtime_log_execution_fn", [fn_name])`.

New: when a decorator resolves to a capsule symbol, emit a **normal call to that
imported function** at function entry, passing the descriptor (Tier 1: the
function-name string constant — the exact `getelementptr` operand the current
code already builds at `emission.sfn:499-508`). The call target is the imported
function's mangled symbol, resolved the same way any imported call is lowered —
no runtime-helper registry row, no always-linked dependency.

- Helper-use marking (`llvm/effects.sfn:473-481`): remove the
  `runtime_log_execution_fn` special-case for capsule-resolved decorators. The
  capsule function is reached as an ordinary import, so the existing
  import-driven `declare` emission handles its forward declaration.
- The string-constant + entry-call scaffolding in `emission.sfn:451-520` is
  reused almost verbatim; only the **call target** changes from the fixed helper
  name to the resolved decorator symbol.

**Linking / opt-in.** Because the decorator lowers to a call into an imported
capsule, the capsule must be a real dependency. The resolution pass (§4.2)
already errors if `@logExecution` is used without `import { logExecution } from
"log"`. There is no path where we emit a call to a symbol whose capsule was not
linked, because resolution fails first. The diagnostic ("unknown decorator —
import it from `log`") *is* the missing-dependency story.

**Built-in fallback lowering.** Until the deprecation completes, a
`@logExecution` that was *not* imported (legacy code) still lowers to the old
`runtime_log_execution_fn` helper. This is the seam removed in the final stage.

### 4.5 Dogfooding migration: `@logExecution`/`@trace` → `sfn/log`

End state:
- `logExecution` (and a distinct `trace`) live in `capsules/sfn/log/src/mod.sfn`
  marked `@decorator`, bodies built on the library's own `info`/`Logger`.
- The compiler no longer string-matches the names.
- `sfn_log_execution` (runtime body), its helper-registry row, and the
  `runtime_log_execution_fn` prelude alias are deleted.

Path (ordered, each step self-hosts — see §5/§7):

1. Ship the generic mechanism (resolution + effect-from-signature + capsule-call
   lowering) **alongside** the existing built-in fallback. New behavior is
   additive; old names still work via fallback. The compiler builds with the old
   seed because the old seed only sees old shapes (the compiler source uses no
   decorators).
2. Add `@decorator`-marked `logExecution`/`trace` to `sfn/log`. The library is
   not yet wired into anything; this is pure addition.
3. Switch the **built-in fallback** to a deprecation: using `@logExecution`
   without importing it from `log` emits a `deprecated-api` lint
   (the lint surface already steers `print.*` → `sfn/log`, per
   `tooling.md:268`), pointing users at `import { logExecution } from "log"`.
   Behavior unchanged; only a warning added.
4. Cut a seed that contains the generic mechanism. **`/pin-seed`.** Now the
   compiler-under-build can rely on capsule-resolved decorators.
5. Delete the built-in string-match registry, the `runtime_log_execution_fn`
   prelude alias (`runtime/prelude.sfn:71`), the helper-registry row
   (`runtime_helpers.sfn:673-675`), and the `sfn_log_execution` body
   (`runtime/sfn/io.sfn:447`). The string-match blocks in
   `decorator_semantics.sfn`, `effect_checker.sfn`, `llvm/effects.sfn`, and the
   fixed-helper branch in `emission.sfn` go away. After this, `@logExecution`
   *only* works via `import … from "log"`.

**Seed-gating the runtime deletion.** The pinned seed (pre-step-4) still emits
`runtime_log_execution_fn` references for any legacy `@logExecution` it compiles.
So the runtime body/alias/row cannot be deleted until the seed used by
`make compile` is the step-4 seed. This mirrors the `@runtime` magic-namespace
seed-gating documented at `runtime/prelude.sfn:46-51` and tracked in
the Runtime Migration table in `docs/status.md`. Step 5 is therefore **blocked on the step-4 seed pin**
and carries the `seed-blocker` label until then. Add a `docs/status.md` Runtime Migration row
for `sfn_log_execution` so the deletion is tracked with the other seed-gated
runtime symbols.

### 4.6 Self-hosting impact

- The compiler/runtime sources use **no** decorators, so steps 1–5 never route
  the compiler's own build through a capsule decorator. Self-hosting is decoupled
  from the feature's correctness for the compiler binary itself.
- The only self-hosting risk is the `Decorator` struct layout note
  (`decorator_semantics.sfn:6-10`): released seeds may treat `Decorator` as
  opaque. The design **does not change** the `Decorator` struct (it adds a
  sidecar `ResolvedDecorator[]` threaded separately, like `ImportSymbolTable`),
  so this hazard is avoided.
- Steps that touch `runtime/prelude.sfn` / `runtime/sfn/io.sfn` are guarded by
  the seed pin (step 4) before deletion (step 5).

## 5. Migration plan (each step a valid self-hosting compiler)

| Step | What | Self-host check |
|---|---|---|
| A | Carry `is_decorator` + validated shape in the export/import metadata channel; add `ResolvedDecorator` sidecar + resolution pass (no behavior change yet — built-in fallback still primary) | `make compile` (old seed sees old shapes; new metadata is additive) |
| B | Move decorator-implied effects from `infer_effects` (parser) to the effect checker, sourcing effects from `ResolvedDecorator`; keep built-in names as a fallback effect source | `make check` (effect enforcement unchanged for existing tests) |
| C | Capsule-resolved lowering: `@imported_decorator` lowers to a normal call into the capsule symbol; built-in `@logExecution` (un-imported) still uses the helper | `make check` + new e2e: import-and-apply a user decorator from a fixture capsule |
| D | Add `@decorator` `logExecution`/`trace` to `sfn/log`; add deprecation lint for un-imported built-in use | `make check` |
| E | **Cut seed + `/pin-seed`** | seed contains A–D |
| F | Delete built-in string-match registry + `runtime_log_execution_fn` alias/row/body | `make clean-build && make check` against the step-E seed |

## 6. Files affected (by pipeline stage)

**Parser / AST**
- `compiler/src/ast.sfn` — no struct change to `Decorator`; possibly a helper to
  carry the `@decorator` marker recognition. (Verify no `Decorator` layout edit.)
- `compiler/src/parser/declarations.sfn:863,950,1276` — stop calling
  `infer_effects` for decorator-implied effects at parse time (step B); the
  parser still records decorator names.
- `compiler/src/decorator_semantics.sfn` — `infer_effects` drops the
  `trace`/`logExecution` string match (kept only as fallback through migration,
  deleted in step F).

**Resolution / capsule**
- New module (e.g. `compiler/src/decorator_resolver.sfn`) — the `ResolvedDecorator`
  sidecar + resolution pass (mirrors `effect_imports.sfn`).
- `compiler/src/capsule_resolver.sfn` — carry `is_decorator` + shape in resolved
  exports.
- `compiler/src/effect_imports.sfn` — extend `ImportedFunctionSignature` (or a
  parallel decorator table) with the decorator marker bit; reuse
  `localize_import_symbols_for_program`.

**Type / effect checking**
- `compiler/src/effect_checker.sfn:372-398` (and the fn/method analogues) —
  replace the hardcoded `io` injection with per-`ResolvedDecorator` effect union
  routed through the `imported \`<name>\`` / `E0402` diagnostic.
- Diagnostic codes: new `E07xx` for "not a decorator" / "unknown decorator."

**Lowering**
- `compiler/src/llvm/lowering/emission.sfn:451-520` — branch: capsule-resolved
  decorator → call the imported symbol; built-in fallback → existing helper.
- `compiler/src/llvm/effects.sfn:464-484` — only mark `runtime_log_execution_fn`
  for the built-in fallback; capsule decorators use ordinary import declares.
- `compiler/src/llvm/runtime_helpers.sfn:673-675` — delete row in step F.

**Runtime / stdlib**
- `capsules/sfn/log/src/mod.sfn` — add `@decorator` `logExecution`/`trace`.
- `runtime/prelude.sfn:52,71` — delete `sfn_log_execution` import + alias (step F).
- `runtime/sfn/io.sfn:447` — delete `sfn_log_execution` body (step F).
- `docs/status.md` (Runtime Migration table) — add `sfn_log_execution` seed-gated deletion row.

**Tests**
- `compiler/tests/unit/` — resolution (import → resolve; unimported → error),
  effect-from-signature (decorator `![io]` forces target `io`; missing → E0402).
- `compiler/tests/e2e/` — `*_test.sfn` that compiles a fixture importing a
  user-defined `@decorator` and asserts on its output (per `no-bash-e2e.md`).
- Negative: `@logExecution` without import → deprecation lint (step D), then
  hard error (step F).

**Docs**
- `docs/status.md`, a spec §N chapter (decorators), `effect-validation.md` and
  `check-architecture.md` (point the decorator-implied-effects gate here),
  `compiler-decomposition.md` §7 (mark `@logExecution`/`@trace` dogfooded).

## 7. Staged issues (XS/S/M, dependency-ordered)

The unblocker is the **resolution + effect-from-signature mechanism**; the
**dogfooding** is the payoff. Per decomposition discipline, the runtime deletion
is bundled where it shares a seed gate, and the capsule-side decorator is bundled
with the lowering consumer that exercises it.

1. **[M] Decorator resolution + capsule export metadata** (steps A) —
   `is_decorator` bit through capsule_resolver + import table, `ResolvedDecorator`
   sidecar, resolution pass, `E07xx` diagnostics. Unit tests only. *Blocks all.*
   *Unblocker.*
2. **[S] Decorator-implied effects from signature** (step B) — move inference to
   the effect checker, union `ResolvedDecorator` effects via the imported-effect
   path. Depends on #1.
3. **[M] Capsule-resolved decorator lowering + `sfn/log` decorators + e2e**
   (steps C+D bundled) — lowering branch to call the imported symbol, add
   `@decorator` `logExecution`/`trace` to `sfn/log`, deprecation lint for
   un-imported built-in use, e2e fixture test. *Bundled because the capsule
   decorator (capability consumer) and the lowering (capability) are exercised in
   one session; splitting forces a seed-cut between them for no benefit.*
   Depends on #2.
4. **[Seed task] Cut + pin seed** (step E) — operational, after #3 merges.
   Carries the new mechanism into the pinned seed. Gates #5.
5. **[S] Delete built-in decorator string-match + `sfn_log_execution` runtime**
   (step F) — remove the string-match registry, prelude alias
   (`runtime/prelude.sfn:71`), helper row (`runtime_helpers.sfn:673-675`), and
   runtime body (`runtime/sfn/io.sfn:447`); `docs/status.md` Runtime Migration row.
   `seed-blocker` until #4. Depends on #4.
   *`sfn_log_execution` is Sailfin-defined (`runtime/sfn/io.sfn`) and reached
   only through the helper-registry emission, so this is a clean Sailfin-side
   deletion — the runtime is pure Sailfin, so there is no C body to retire.*

## 8. Risks & mitigations

- **Seed still emits the old helper.** Mitigated by the explicit seed pin (#4)
  gating the runtime deletion (#5); `seed-blocker` label + `docs/status.md`
  Runtime Migration row.
- **`Decorator` struct layout / opaque-seed hazard.** Mitigated by *not* editing
  the `Decorator` struct — all new data rides a sidecar like `ImportSymbolTable`.
- **Effect drift / unenforced claim.** Mitigated by routing decorator effects
  through the existing enforced imported-effect path (`E0402`), not a parallel
  injector. A decorator carrying `![io]` whose target lacks `io` *fails the
  build* — that is the enforcement test in issue #2.
- **`@decorator` marker collides with a future user symbol named `decorator`.**
  It is an attribute on a declaration, not a value namespace; low risk. If it
  becomes a concern, gate recognition on a reserved capsule/origin.
- **Two consumers of the mechanism (user convenience + dogfooding) tempt over-
  splitting.** Mitigated by bundling #3.

## 9. Resolved decisions (design gate)

The design-gate review settled all five open questions:

1. **Tier 1 vs Tier 2 contract → Tier 1 only.** Ship the entry-hook contract;
   defer the wrapping (return/timing exit-hook) contract to a post-dogfood issue
   once closures-with-capture / a call ABI land. Shipping a half-wrapper would
   violate "parsed but not enforced."
2. **Marker vs keyword → `@decorator` marker attribute.** No new keyword; reuse
   the existing decorator/attribute grammar ("libraries over keywords").
3. **Import strictness → require an import.** `@foo` requires `import { foo }
   from "…"`; no global decorator namespace. The built-in fallback for
   `@logExecution`/`@trace` is a temporary deprecation bridge only (deleted in
   step F).
4. **`@trace` vs `@logExecution` → diverge now, within Tier 1 limits.** They get
   **distinct entry-hook bodies** in `sfn/log`: `@logExecution` → `info(fn_name)`
   (`[INFO] <fn>`); `@trace` → a distinct trace-level body (e.g. a
   `logger("trace")` entry line such as `[TRACE] → entered <fn>`). **Full
   timing-style tracing (entry + exit) stays a Tier 2 follow-up** — it needs the
   exit hook we are deferring in (1), so step D ships two *entry-only* bodies, not
   a timing wrapper. Step D therefore defines **two bodies**, not one.
5. **Decorator arguments → wire now.** Thread `DecoratorArgument[]` into the
   Tier 1 call ahead of the function-name descriptor, so `@trace("label")` /
   `@logExecution("label")` work immediately. This enlarges issue #1 (the entry
   hook contract now carries `(args, fn_name)` and the lowering must marshal the
   parsed arguments).

### Contract impact of (4) + (5)

The Tier 1 entry-hook signature becomes args-then-name, e.g.:

```sfn
// capsules/sfn/log/src/mod.sfn
@decorator
fn logExecution(args: string[], fn_name: string) -> void ![io] {
    info(fn_name);                     // [INFO] <fn>
}

@decorator
fn trace(args: string[], fn_name: string) -> void ![io] {
    let t = logger("trace");
    log_info(t, "→ entered " + fn_name);   // distinct trace-level entry line
}
```

(Exact arg-marshalling shape — `string[]` vs a typed descriptor — is an
implementation detail for issue #1; the contract is "decorator args precede the
function-name descriptor.") Signature validation (§4.1) updates to
`(string[], string) -> void` arity/shape. Issue #1 absorbs the arg wiring;
issue #3 ships the two distinct bodies + the deprecation lint.
