---
sfep: TBD
title: Signature-Checked Interface Conformance
status: Draft
type: language
created: 2026-07-01
updated: 2026-07-01
author: "agent:compiler-architect; human review"
tracking:
supersedes:
superseded-by:
graduates-to: reference/spec/06-types.md
---

# SFEP-XXXX — Signature-Checked Interface Conformance

> Design record for closing the interface-conformance soundness gap tracked in
> `docs/status.md` ("Interface conformance validation | Partial | Basic checks;
> variance not enforced"). This is a correctness/soundness fix, not a new
> feature: today's name-only conformance check can install a wrong-typed
> function pointer into an interface vtable slot, which is then called
> indirectly at the interface's expected type.

## 1. Summary

`check_struct_implements_interfaces` (`compiler/src/typecheck_types.sfn:95-134`)
currently verifies interface conformance by name only: a struct "implements" an
interface if it has a method for every member *name* the interface declares. It
never compares parameter types, arity, or return type against the interface's
declared signature. Because interface method calls lower to an indirect call
through a vtable slot whose function-pointer type is derived from the *call
site*, not from the *installed function* (`core_call_emission.sfn:558-596`), a
struct method with the same name but an incompatible signature is silently
installed into that slot and called through the wrong LLVM function type — a
type-unsound indirect call, not merely a missing diagnostic. This proposal
extends `check_struct_implements_interfaces` to check arity, parameter types,
and return type for exact compatibility (1.0 has no variance), adds a new
diagnostic family (`E0303`) distinct from the existing missing-member
diagnostic (`E0301`), and ships the tightening behind the same
`SAILFIN_EFFECT_ENFORCE`-style transitional severity knob the effect system
used to migrate the in-tree corpus before flipping to hard-error.

## 2. Motivation

### The bug, precisely

`check_struct_implements_interfaces` walks each `implements` annotation,
resolves the interface declaration by name via `resolve_interface_annotation`
(`typecheck_types.sfn:136-149`), and for each interface member does exactly
one check:

```sfn
if !contains_string(method_names, member.name) {
    diagnostics.push(make_missing_interface_member_diagnostic(statement.name, interface_name, member.name));
}
```

`method_names` is built by pushing `statement.methods[_mi].signature.name` for
every struct method (`:98-104`) — names only, no signature data retained. The
three adjacent validators don't fill the gap either:

- `validate_interface_annotation` (`:169-188`) checks only generic
  type-*argument arity* on the `implements Container<T>` annotation itself
  (does the struct supply the right number of type arguments) — it never looks
  at method bodies.
- `check_interface_members` (`:785-808`) validates the *interface declaration*
  is well-formed (`check_function_signature` → `check_type_parameters`, plus a
  duplicate-member-name check) — it runs over the interface, never cross-checks
  against any implementing struct.
- `check_struct_methods` (called from `typecheck.sfn:463`) validates the
  struct's own methods in isolation — again, no cross-check against interfaces
  it claims to implement.

So today, this compiles with **zero diagnostics**:

```sfn
interface Greeter {
    fn greet(self, name: string) -> string;
}

struct Loud {
    volume: int;
}
impl Loud {
    // same name "greet", wrong arity AND wrong param/return types —
    // accepted today because only the name is checked.
    fn greet(self) -> int {
        return self.volume;
    }
}
```
(Sailfin does not have a separate `impl` block — methods live directly in the
`struct` body per `03-declarations.md` §3.3 — but the shape of the mismatch is
the same wherever `fn greet` is declared inside `struct Loud { ... }` with
`implements Greeter`.)

### Why this is a soundness bug, not a missing lint

Interface-typed values lower to a two-word trait object `{ i8*, i8* }` (data
pointer + vtable pointer; `rendering_helpers.sfn:31-44`). The vtable itself is a
struct of function-pointer-typed slots, one per interface member, populated at
each `implements`-resolution site by `bitcast (<fn-ptr-type> @<method> to
<fn-ptr-type>)` (`rendering_helpers.sfn:72-107`) — `<fn-ptr-type>` there is
whatever the *actual* struct method's signature lowers to.

A dynamic dispatch call site (`core_call_emission.sfn:507-660`, the
`trait_dispatch__<Interface>__<method>` path) does the reverse: it builds
`function_type` from the **call site's own operand types**
(`fp_param_types` built from `final_operands`, `:558-567`) plus the
**interface's declared `llvm_return`**, then loads the raw `i8*` from the
vtable slot and `bitcast`s it to that call-site-derived function type
(`:576-596`) before calling through it.

If the installed method's real signature differs from the interface's declared
signature — different parameter count, different parameter LLVM types
(`i64` vs a boxed struct pointer, for instance), or a different return type —
the `bitcast` reinterprets a function pointer as having a type it does not
actually have. Calling through it is undefined behavior at the LLVM level:
arguments land in the wrong registers/stack slots, the return value is
misinterpreted, and in the aggregate-parameter/return case this manifests as
memory corruption, not merely "the wrong number came back." This is the same
class of hazard the project already treats as urgent for owned-value handling
(#1205-style aliasing corruption) — an indirect call through a mismatched
function type is a compiler-introduced memory-safety bug, reachable from
ordinary, valid-looking source with no unsafe/extern escape hatch involved.

### Who hits it, and why silently

Any interface with more than a trivial single-signature member is at risk the
moment a struct's method for that name drifts from the interface (a common
refactor mistake: renaming a parameter's type, adding an optional parameter,
changing `-> string` to `-> string?`). There is no compiler feedback — `sfn
check` is green, `make compile` succeeds, and the failure only surfaces at
runtime as a crash or corrupted data, often far from the actual defect. Per
the project principle "don't ship unfinished safety claims," a name-only check
that market-facing docs and the interface's own type signature imply is a real
contract is actively worse than no check: it teaches users the `implements`
clause is verified when it is not.

## 3. Design

### 3.1 Scope of the check

Extend `check_struct_implements_interfaces` so that, for each interface
member the struct has a same-named method for, it additionally verifies:

1. **Arity** — the struct method's `parameters` list has the same length as
   the interface member's `parameters` list.
2. **Parameter types, pairwise, in order** — after substituting the
   interface's type parameters with the concrete arguments from the
   `implements Container<T>` annotation (see §3.3), each pair of parameter
   type-annotation texts must be *exactly equal* (no variance — see §3.4).
3. **Return type** — same substitution-then-exact-text-equality rule applied
   to `return_type` (interface member's, possibly absent/`void`, vs. the
   struct method's).
4. **`self` receiver** — both signatures' first parameter, by convention
   named `self` (per `03-declarations.md` §3.3/§3.5: "the first parameter is
   bare `self`"), is a structural fixture, not a type to compare. It is
   **excluded** from the parameter-type comparison entirely: `self` carries no
   `type_annotation` today (bare `self`, no `: Type` suffix — confirmed by
   every interface/struct example in the spec), so comparing it as a normal
   parameter would either vacuously pass (both sides `null`) or, if a future
   syntax allows an explicit `self: T` receiver annotation, incorrectly reject
   valid conformance. The rule: **if the first parameter's name is exactly
   `"self"` on both sides, skip it for the type comparison and start the
   pairwise walk at index 1; require both sides to agree on whether index 0 is
   present and named `self`** (a member with a `self` receiver cannot be
   satisfied by a method without one, and vice versa — that mismatch is
   reported as an arity/shape mismatch under the same new diagnostic, not
   silently ignored).

This mirrors the existing exact-match philosophy of `check_try_operator`'s
`?`-operator error-type check (`E0812`, `typecheck_types.sfn:420-438`): "`?`
requires an exact match (no `From` coercion yet)" is the same posture applied
here to interface parameter/return types, for the same reason — this compiler
pass has no expression-type inferencer (#829) and no subtyping/variance
lattice, so anything short of exact text equality (after substitution) is
unimplementable without a much larger prerequisite.

### 3.2 New function: `check_interface_member_signature_match`

Add a pure helper next to `check_struct_implements_interfaces`:

```sfn
fn check_interface_member_signature_match(
    struct_name: string,
    interface_name: string,
    member: FunctionSignature,
    method: MethodDeclaration,
    substitution: TypeSubstitution
) -> Diagnostic[]
```

Called from inside the existing `_mbi` loop in
`check_struct_implements_interfaces`, **only when** the name lookup already
found a matching struct method (i.e. it runs alongside, not instead of, the
existing `E0301` missing-member check — a member that's missing by name still
reports `E0301` and is not also signature-checked, since there is nothing to
compare against). The loop needs the matched `MethodDeclaration`, not just the
boolean `contains_string` result, so `check_struct_implements_interfaces`
changes its lookup from `contains_string(method_names, member.name)` to a new
helper `find_method_by_name(statement.methods, member.name) -> MethodDeclaration?`
that returns the method (or `null`), used for both the existing missing-member
branch (`null` case, unchanged `E0301`) and the new signature check (non-null
case).

`check_interface_member_signature_match` body, in order:

1. **Shape/arity check.** Compare `self`-receiver presence (§3.1 rule) between
   `member.parameters` and `method.signature.parameters`. If they disagree, or
   if the non-`self` parameter counts differ, emit **one** `E0303` diagnostic
   summarizing the arity/shape mismatch (message shows both full rendered
   signatures — see §3.5) and return early (no point comparing types
   position-by-position against a misaligned list).
2. **Parameter type check.** Walk the non-`self` parameters pairwise. For each
   interface parameter, apply `apply_type_substitution` (already exists,
   `typecheck_types.sfn:271-291`) with `substitution` to its
   `type_annotation.text`, then compare the substituted text against the
   struct method parameter's `type_annotation.text` via `strings_equal`
   (`string_utils`, already imported). On any mismatch push **one** `E0303`
   for that parameter, naming the parameter, expected substituted type, and
   actual type; continue checking remaining parameters (report every
   mismatched parameter in one pass, not just the first — matches the existing
   convention of returning a `Diagnostic[]` rather than stopping at first
   error, as seen throughout `typecheck_types.sfn`).
3. **Return type check.** Same substitution + `strings_equal` comparison
   between `member.return_type` and `method.signature.return_type`, treating
   `null` (no declared return type / implicit void) on both sides as a match,
   and a `null`/non-`null` mismatch as a failure. Emit **one** `E0303` if
   mismatched.

All three checks are independent (not early-return after step 1's arity check
fails to find a mismatch) — a caller can have both a wrong parameter type and
a wrong return type; both are reported in the same pass, consistent with the
compiler's general practice of surfacing all diagnostics per node rather than
one-at-a-time.

### 3.3 Generic interfaces: instantiating the member signature

For `interface Container<T> { fn get(self, index: int) -> T?; fn len(self) ->
int; }` implemented as `struct IntList { ... } ` with `implements
Container<int>`, the member's declared return type text is `T?` — this must be
substituted to `int?` before comparing against the struct's actual `fn
get(self, index: int) -> int?` method.

`check_struct_implements_interfaces` already has everything needed to build
this substitution — it is the same shape `resolve_enum_variant_field_type`
uses (`typecheck_types.sfn:299-319`):

```sfn
let provided_arguments = parse_type_arguments(annotation.text);   // already computed for arity validation
let substitution = build_type_substitution(interface_definition.type_parameters, provided_arguments);
```

`build_type_substitution` and `apply_type_substitution` already exist unchanged
(`:225-291`) — this proposal adds no new substitution machinery, only a new
call site. Compute `substitution` once per `implements` annotation (right
after the existing `validate_interface_annotation` call, which already
guarantees arity is correct — §3.1's signature check only runs when arity
validated cleanly, so a `substitution` with mismatched-length `olds`/`news`
never reaches the per-member comparison) and thread it into
`check_interface_member_signature_match` for every member of that
`implements` entry.

For a non-generic interface (`expected_count == 0`), `parse_type_arguments`
returns `[]` and `build_type_substitution` naturally produces an empty
substitution — `apply_type_substitution` is then a no-op passthrough (no
identifier matches `substitution.olds` because it's empty), so the same code
path handles both generic and non-generic interfaces without a branch.

### 3.4 Compatibility rule: exact match, no variance (1.0 scope)

Per the project's "fix the foundation first" and "don't ship unfinished safety
claims" principles, this check does not attempt covariant return types,
contravariant parameters, or any subtyping relaxation — those require a real
type lattice this compiler does not have (types are compared as post-
substitution annotation *text*, per the existing `type_is_result` / `?`-operator
precedent, `typecheck_types.sfn:355-378`). **Exact textual equality after
substitution** is the complete 1.0 rule:

- `int` matches `int`; `int` does **not** match `int?` (nullability is part of
  the type text and is not unified).
- `T?` (substituted to `int?`) matches only literal `int?`, not `int` and not
  `Optional<int>` or any other spelling.
- Whitespace/formatting differences in the annotation text must not cause a
  false mismatch — reuse `trim_text` (already used throughout this file, e.g.
  `:184`) on both sides before `strings_equal`, so `fn get(self, index:int)`
  and `fn get(self, index: int)` compare equal.
- No structural equivalence for compound types beyond substitution — `Array<T>`
  substituted to `Array<int>` must match a literal `Array<int>` spelling on the
  struct method; `int[]` is a *different* spelling and does not match
  `Array<int>` even if they denote the same runtime type today. This is a
  known, documented limitation (type annotations are compared as strings, not
  as resolved types — the same limitation `apply_type_substitution`'s own
  docstring already lives with) and is not a regression this proposal
  introduces; tightening it further needs the type-annotation resolver work
  generic constraints will need anyway (§6, cross-reference to
  `0038-generic-constraints.md`).

### 3.5 New diagnostic: `E0303`

The missing-member diagnostic is `E0301`
(`make_missing_interface_member_diagnostic`, `:2085-2097`); the type-argument-
arity family is `E0302` (`make_interface_type_argument_mismatch_diagnostic` and
its two siblings, `:1865-1907`). `E0303` is the next free code in that family
(confirmed clear — a repo-wide scan of `compiler/src` finds no existing
`E0303` use). One diagnostic factory, parameterized by a `kind` so the three
sub-cases (§3.2 steps 1–3) share rendering plumbing but produce
distinguishable messages:

```sfn
// E0303 — struct method signature does not match the interface member's
// declared signature (arity, a parameter type, or the return type).
fn make_interface_signature_mismatch_diagnostic(
    struct_name: string,
    interface_name: string,
    member_name: string,
    expected_signature: string,
    actual_signature: string,
    detail: string,          // e.g. "parameter `index`: expected `int`, got `string`"
    span: SourceSpan?
) -> Diagnostic {
    return Diagnostic {
        code: "E0303",
        severity: "error",
        message: "struct " + struct_name + " implements " + interface_name
            + " but method `" + member_name + "` does not match the interface's"
            + " declared signature: " + detail
            + ". Expected `" + expected_signature + "`, found `" + actual_signature + "`.",
        file_path: "",
        primary: token_from_name(member_name, span),
        suggestion: null
    };
}
```

`expected_signature` / `actual_signature` are the full rendered `fn name(params)
-> return` text (reuse or extend `format_interface_signature`'s sibling
formatting helpers) so the user sees the whole shape, not just the one
differing token — this matches how `E0812`'s `?`-operator diagnostic names
both full types rather than only the mismatched token. `suggestion` starts
`null` (no auto-fix in v1 — the fix depends on developer intent, whether the
struct method or the interface declaration is wrong, mirroring why
`make_missing_interface_member_diagnostic` also carries no `suggestion`
today); a fix-it (retype the parameter to match) is a natural fast-follow once
this ships, tracked separately.

### 3.6 Enforcement severity: transitional flag, mirroring `SAILFIN_EFFECT_ENFORCE`

This is a **backward-incompatible tightening**: any struct/interface pair in
an existing capsule that "conforms" today only because names match — with a
divergent parameter or return type — newly fails to compile once this ships
as a hard error. The effect system shipped an identical class of tightening
(Phase D of `docs/proposals/0008-effect-validation.md`, flipping the default
from warning to error only after an in-tree audit) behind
`SAILFIN_EFFECT_ENFORCE`; this proposal reuses that exact transitional shape
rather than inventing a new one.

Add `SAILFIN_INTERFACE_ENFORCE` (a distinct env var — interface conformance
and effect enforcement are unrelated concerns and must not share a toggle),
read via a new `interface_gate.sfn`, structurally identical to
`effect_gate.sfn` (`compiler/src/effect_gate.sfn:58-83`):

```sfn
fn resolve_interface_enforcement(raw: string) -> string {
    if raw == "off" { return "off"; }
    if raw == "warning" { return "warning"; }
    return "error";   // unset / "" / "error" → default
}

fn read_interface_enforcement_env() -> string ![io] {
    return env.get("SAILFIN_INTERFACE_ENFORCE");
}
```

Ship this feature with the **default already at "error"** for
`E0303` specifically — unlike the effect system's Phase B (which *shipped*
warning-by-default and flipped later), here the migration path is: (a) land
the checker with `E0303` gated by `SAILFIN_INTERFACE_ENFORCE`, **defaulted to
`"warning"` for one release cycle** so the in-tree compiler corpus and any
existing capsules get one alpha cycle of visibility before the check is
fatal, then (b) a fast-follow flips the unset default to `"error"` once an
audit (mirroring the effect system's Phase C in-tree audit) confirms
`compiler/src/*.sfn` itself has no violations. This two-step landing (warn
first release, error next) is the one deliberate divergence from a
same-PR error-default — justified because, unlike a fresh new diagnostic
class the effect system didn't have before, this specifically *replaces* a
check that previously reported nothing at all, so the blast radius on
unaudited downstream capsules is unknown at land time. `E0301` (missing
member) is unaffected — it stays an unconditional hard error exactly as
today; only the *new* `E0303` signature-mismatch class is gated by
`SAILFIN_INTERFACE_ENFORCE` during the transition. `=off` skips only the
`E0303` signature comparison (§3.2), never the `E0301` name-presence check
or the `E0302` arity check — both continue to run unconditionally, matching
how `SAILFIN_EFFECT_ENFORCE=off` still runs `sfn check`'s own gate
(`effect_gate.sfn:28-34`) even while skipping the *build*-path gate.

Wire the severity into `check_struct_implements_interfaces`'s call site in
`typecheck.sfn` the same way `validate_and_render_effects_with_capabilities`
threads `severity` onto each `EffectViolation` before rendering
(`effect_gate.sfn:141-148`): the new `E0303` `Diagnostic`s get their
`severity` field overwritten by the resolved enforcement level before being
appended to the returned `Diagnostic[]`, so "warning" mode still surfaces the
message (visibility) without failing `make compile` / `sfn check`.

### 3.7 Worked example

```sfn
interface Container<T> {
    fn get(self, index: int) -> T?;
    fn len(self) -> int;
}

struct IntList {
    items: int[];
}

// OK: `get` and `len` both match Container<int>'s instantiated signatures.
struct GoodIntList {
    items: int[];
    fn get(self, index: int) -> int? { return null; }
    fn len(self) -> int { return 0; }
    implements Container<int>;
}

// E0303: `get`'s return type is `int`, but Container<int>.get is `int?`.
struct BadIntList {
    items: int[];
    fn get(self, index: int) -> int { return 0; }
    fn len(self) -> int { return 0; }
    implements Container<int>;
}
```

(Field/method/`implements` ordering above follows the existing
`03-declarations.md` §3.3 struct-body shape; exact placement of `implements`
is unaffected by this proposal.)

## 4. Effect & capability impact

None. `check_struct_implements_interfaces` and the new
`check_interface_member_signature_match` are pure functions over already-parsed
`Statement`/`FunctionSignature`/`MethodDeclaration` AST data — no new effectful
operation is introduced anywhere in the typecheck pass itself. The one
`![io]`-effectful piece, `read_interface_enforcement_env` (an `env.get` call,
mirroring `read_effect_enforcement_env`), is confined to the same build-path
orchestration layer the effect gate already lives in (`main.sfn` /
`tools/check.sfn` call sites), not the pure typecheck core. No capability
manifest surface changes: `SAILFIN_INTERFACE_ENFORCE` is a compiler-internal
transitional knob, not a capsule-declarable capability.

## 5. Self-hosting impact

Passes touched, in pipeline order:

- **AST** (`ast.sfn`) — no change. `FunctionSignature`, `MethodDeclaration`,
  `Parameter`, `TypeAnnotation` all already carry every field this check reads
  (`parameters`, `return_type`, `type_annotation.text`, `name`).
- **Type Checker** (`typecheck_types.sfn`) — the only pipeline stage that
  changes:
  - `check_struct_implements_interfaces` (`:95-134`) gains the substitution
    computation (§3.3) and replaces its `contains_string` boolean lookup with
    a `find_method_by_name` lookup that also drives the new signature check.
  - New `find_method_by_name(methods: MethodDeclaration[], name: string) ->
    MethodDeclaration?` helper.
  - New `check_interface_member_signature_match` (§3.2).
  - New `make_interface_signature_mismatch_diagnostic` (§3.5, `E0303`).
- **New file `compiler/src/interface_gate.sfn`** (§3.6) — the
  `SAILFIN_INTERFACE_ENFORCE` read + severity resolution, structurally mirrors
  `effect_gate.sfn`. Wired into the same `main.sfn` / `tools/check.sfn`
  call sites that currently invoke `validate_and_render_effects*`, so the
  severity-overwrite happens at the same orchestration layer, not inside
  `typecheck_types.sfn` itself (keeping that file's functions pure, per its
  existing convention — none of its `check_*` functions read the environment
  today).
- **Effect Checker, Native Emitter, LLVM Lowering** — no change. This proposal
  is purely a *rejection* of programs the pipeline would otherwise lower
  unsoundly; it adds no new IR shape, no new lowering path, and does not touch
  `emit_native.sfn` or any file under `llvm/`. (The vtable/dispatch mechanism
  in `core_call_emission.sfn` and `rendering_helpers.sfn` described in §2 is
  cited to establish *why* the check matters — it is not modified by this
  proposal. A previously-accepted mismatched program simply becomes a
  diagnostic instead of reaching that lowering code at all.)

**Self-hosting invariant.** This is additive to the compiler's own source: the
compiler's `interface`/`implements` usages are checked against the same rule
their consumers are. Before landing, run `make compile` with
`SAILFIN_INTERFACE_ENFORCE=warning` and read the emitted warnings — if
`compiler/src/*.sfn` itself has zero pre-existing signature drifts (expected,
since the compiler was written assuming exact conformance informally), the
warning-mode landing and the later error-mode flip both self-host cleanly with
no compiler-source changes required. If the audit *does* find drift in
`compiler/src/*.sfn`, fixing those call sites is a prerequisite sub-step before
the warning-to-error flip (not before the initial warning-mode land) — this
mirrors exactly how the effect system's Phase C audit (11 debug-trace routines)
preceded Phase D's default flip (`effect_gate.sfn:19-26`). Both landing steps
are single-PR, no-seed-cut changes per `.claude/rules/seed-dependency.md`: the
capability (`E0303` check + gate) and its only consumer (the compiler's own
`interface`/`implements` declarations, already present in the pinned seed's
grammar) ship together — `make compile` builds the new compiler from the old
seed, and that new compiler self-checks its own `implements` sites in the same
pass. No new seed is required for either the warning-default landing or the
later error-default flip.

## 6. Alternatives considered

- **Do nothing / leave it a documented "Partial" limitation.** Rejected — this
  is not a missing convenience feature, it is a reachable memory-safety hazard
  (§2). `docs/status.md`'s own "Partial" note already flags it; this proposal
  closes it rather than leaving a soundness hole documented-but-open
  indefinitely.
- **Enforce only arity, not full type equality.** Rejected — arity-only still
  permits the `bitcast`-to-wrong-function-type hazard whenever a parameter's
  *type* (not count) diverges (e.g. `int` vs a boxed struct pointer), which is
  exactly the case most likely to corrupt memory (aggregate/pointer ABI
  mismatch) rather than merely misread an integer.
- **Enforce with structural/variance-aware type equality (covariant returns,
  contravariant parameters) instead of exact match.** Rejected for 1.0 — the
  compiler has no expression-type inferencer or type lattice (#829); building
  one is a much larger prerequisite than this fix, and the project's "fix the
  foundation first" principle puts real subtyping behind more basic
  primitives (integer types, `Result<T,E>`, generic constraints) that don't
  yet exist either. Exact-match-after-substitution is implementable today with
  the substitution machinery that already exists (§3.3) and matches the
  precedent already set by the `?`-operator's `E0812` exact-match rule.
- **Fatal from day one, no transitional flag.** Rejected — mirrors exactly why
  the effect system didn't do this either (`effect_gate.sfn` Phase B/C/D
  history): an unknown amount of existing capsule code may rely on today's
  name-only conformance without ever having hit the runtime hazard, and a
  same-PR hard break with no visibility window is more disruptive than
  necessary. The two-step warning-then-error landing gives one alpha cycle of
  signal.
- **Fold this into the general effect-enforcement flag
  (`SAILFIN_EFFECT_ENFORCE`) instead of a new one.** Rejected — interface
  conformance and capability/effect enforcement are unrelated axes (one is a
  type-soundness check, the other is a capability-security check); sharing a
  toggle would force an operator who wants to silence one to also silence the
  other, and would misuse a flag whose name and existing documentation
  (`docs/status.md`, `0008-effect-validation.md`) is specifically about
  effects.
- **Runtime (rather than compile-time) signature check — e.g. tag the vtable
  slot with a signature hash and check it at dispatch.** Rejected — Sailfin's
  differentiator is compile-time capability/type enforcement; a runtime check
  adds cost to every dynamic dispatch call for a defect class that is fully
  determinable at compile time (all types involved are statically known at
  the `implements` site). It would also only convert a memory-corruption bug
  into a runtime panic, not prevent the unsound program from being accepted at
  all.

## 7. Stage1 readiness mapping

- [ ] **Parses** — no parser change required; `implements`, `interface`, and
  struct-method syntax already parse today. (N/A — this proposal touches no
  grammar.)
- [ ] **Type-checks / effect-checks** — `check_interface_member_signature_match`
  + `E0303` + `find_method_by_name`, wired into
  `check_struct_implements_interfaces`; `interface_gate.sfn`'s severity
  threading. Not yet implemented.
- [ ] **Emits valid `.sfn-asm`** — N/A; this proposal rejects programs before
  emission, it adds no new IR shape.
- [ ] **Lowers to LLVM IR** — N/A; no lowering change (§5).
- [ ] **Regression coverage** — see §8, not yet written.
- [ ] **Self-hosts** — `make compile` with `SAILFIN_INTERFACE_ENFORCE=warning`
  must succeed with zero `E0303` warnings against `compiler/src/*.sfn`'s own
  `interface`/`implements` sites before the error-mode flip; not yet run.
- [ ] **`sfn fmt --check` clean** — applies to `interface_gate.sfn` and the
  `typecheck_types.sfn` diff once written.
- [ ] **Documented in `docs/status.md` + spec** — `docs/status.md`'s
  "Interface conformance validation" row flips from "Partial" to "Shipped"
  (warning-mode landing keeps it "Partial" with an updated note; only the
  error-default flip graduates it to "Shipped", consistent with "parsed but
  not enforced is not shipped"). `graduates-to:
  reference/spec/06-types.md` — interfaces have no existing spec-chapter
  section yet (`03-declarations.md` §3.5 currently covers `interface`
  declaration syntax only); this proposal's graduation adds the conformance
  rule to `06-types.md` as the canonical home for interface *type* semantics,
  cross-linked from `03-declarations.md` §3.5.

## 8. Test plan

- **`compiler/tests/unit/interface_signature_conformance_test.sfn`** —
  direct unit coverage of `check_interface_member_signature_match` /
  `check_struct_implements_interfaces`:
  - Matching arity + parameter types + return type → no diagnostics.
  - Wrong parameter type (non-generic interface) → one `E0303`, message names
    both types.
  - Wrong return type → one `E0303`.
  - Wrong arity (extra/missing non-`self` parameter) → one `E0303`, shape
    message, no attempted pairwise type comparison.
  - Missing `self` receiver on one side only → one `E0303` (shape mismatch),
    distinct from the "both have `self`, compare from index 1" path.
  - Generic interface (`Container<T>` / `implements Container<int>`): member
    return type `T?` substituted to `int?` matches a real `int?` method,
    rejects a real `int` or `string?` method.
  - Multiple simultaneous mismatches (both a parameter and the return type
    wrong) → two `E0303` diagnostics in one pass, not one.
  - Whitespace-only differences (`int` vs ` int `) → no false-positive
    mismatch (trim before compare).
  - Existing `E0301` (missing member) and `E0302` (arity) behavior unchanged —
    regression-guard the current passing tests in this file's neighborhood
    (`typecheck_types.sfn`'s existing interface tests, if any, must still
    pass unmodified).
- **`compiler/tests/integration/interface_enforcement_gate_test.sfn`** —
  `SAILFIN_INTERFACE_ENFORCE` contract: `resolve_interface_enforcement("off"
  | "warning" | "" | "error")` returns the right severity string (mirrors
  `effect_gate_test.sfn`'s existing shape for `resolve_effect_enforcement`, if
  present — reuse that test's structure); a `warning`-mode run surfaces the
  diagnostic without a non-zero build exit; an `error`-mode (or unset, once
  flipped) run fails the build; `off` skips only `E0303`, not `E0301`/`E0302`.
- **`compiler/tests/e2e/interface_signature_mismatch_test.sfn`** — an
  `![io]` e2e test (per `.claude/rules/no-bash-e2e.md`) that spawns
  `sfn check` against a fixture source string containing the exact `Loud`/
  `Greeter`-shaped mismatch from §2, asserting the captured stderr contains
  `E0303` and does not contain a successful build marker; a companion
  positive-case fixture (matching signatures) asserts a clean `sfn check`
  exit.
- **Self-host verification** — `make compile` (first with
  `SAILFIN_INTERFACE_ENFORCE=warning` to confirm zero in-tree violations
  surface as warnings, then a full `make check` once the checker lands) per
  `.claude/rules/selfhost-invariant.md`.

## 9. References

- `docs/status.md` — "Interface conformance validation | Partial | Basic
  checks; variance not enforced" (the row this proposal closes); the
  Diagnostics section describing the shared `diagnostics_render.sfn` renderer
  and `E05xx`/`E06xx` families used as an env-var/severity precedent.
- `docs/proposals/0008-effect-validation.md` — the `SAILFIN_EFFECT_ENFORCE`
  Phase B/C/D transitional-severity precedent this proposal's
  `SAILFIN_INTERFACE_ENFORCE` mirrors structurally.
- `compiler/src/effect_gate.sfn` — the concrete file structure
  (`resolve_*_enforcement`, `read_*_enforcement_env`, severity-overwrite
  wiring) `interface_gate.sfn` is modeled on line-for-line.
- `compiler/src/typecheck_types.sfn:95-134` (`check_struct_implements_interfaces`),
  `:136-149` (`resolve_interface_annotation`), `:169-188`
  (`validate_interface_annotation`), `:225-291` (`TypeSubstitution` /
  `build_type_substitution` / `apply_type_substitution` — reused unchanged),
  `:355-438` (the `?`-operator `type_is_result` / `E0810`–`E0812` exact-match
  precedent), `:785-808` (`check_interface_members`), `:1865-1907` (the
  `E0302` arity-diagnostic family), `:2085-2097`
  (`make_missing_interface_member_diagnostic`, `E0301`).
- `compiler/src/llvm/expression_lowering/native/core_call_emission.sfn:507-660`
  — the `trait_dispatch__<Interface>__<method>` vtable dispatch lowering that
  makes this a soundness bug, not a missing lint (call-site-derived
  `function_type` bitcast onto the loaded vtable slot).
- `compiler/src/llvm/rendering_helpers.sfn:31-107` — trait-object layout
  (`{ i8*, i8* }`), vtable type definitions, and vtable-constant population
  (`bitcast (<fn-ptr-type> @<method> to <fn-ptr-type>)`).
- `site/src/content/docs/docs/reference/spec/03-declarations.md` §3.3, §3.5 —
  current documented `struct`/`interface`/`implements` syntax (bare `self`
  receiver convention this proposal's §3.1 rule depends on).
- `0038-generic-constraints.md` (forthcoming SFEP) — constraint satisfaction
  for generic bounds (`fn foo<T: Container>(...)`) will need to answer "does
  `T` satisfy `Container`" using the same conformance check this proposal
  hardens; today's name-only check would let an ill-typed `T` satisfy a bound
  it does not actually meet, silently propagating this same vtable hazard into
  generic-constraint-gated code. This proposal is a direct prerequisite.
- `draft-derive.md` (forthcoming SFEP) — derived interface implementations
  (e.g. a future `#[derive(Serializable)]`-style mechanism) must produce
  methods that pass this same signature check; deriving is only sound if the
  generated method's signature is verified against the interface exactly like
  a hand-written one, so this proposal's checker is the gate derive-generated
  impls run through, not a parallel bespoke validation path.
- `.claude/rules/seed-dependency.md` — the bundle-not-split reasoning in §5.
