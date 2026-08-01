---
sfep: 61
title: Diagnostic Unification — One Coded, Spanned, Severity-Bearing Diagnostic
status: Accepted
type: tooling
created: 2026-07-25
updated: 2026-07-30
author: "agent:compiler-architect; agent:Sailbot (orchestrator); project owner (design gate 2026-07-25)"
tracking: "SFN-534, SFN-535, SFN-536, SFN-537, SFN-538, SFN-539, SFN-540, SFN-541, SFN-608"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0061 — Diagnostic Unification

## 1. Summary

Sailfin's compiler carries **six** diagnostic channels with four incompatible
representations. The frontend's `Diagnostic` (`compiler/src/typecheck_types.sfn:56`)
is correct — code, severity, span, and structured fix-it. The backend never
adopted it, and instead uses a bare `string[]` in which severity is encoded as
the literal substring `[fatal]`, scanned by `has_fatal_lowering_diagnostic`
(`compiler/src/llvm/lowering/lowering_core/diagnostics.sfn`).

| Channel | Code | Span | Severity | Fix-it |
|---|---|---|---|---|
| `Diagnostic` — `typecheck_types.sfn:56` | yes | yes (`primary: Token?`) | yes | yes |
| `TssaDiagnostic` — `typed_ssa_verify.sfn:22` | yes | no | no | no |
| `LoweredLLVMLinesResult.diagnostics` — `llvm/types.sfn:128` | no | no | no | no |
| `TensorVerifyResult.diagnostics` — `tensor_ir_verify.sfn:17` | no | no | no | no |
| `ParseNativeResult.diagnostics` — `native_ir.sfn:187` | no | no | no | no |
| `EmitNativeResult.diagnostics` — `emit_native.sfn:97` | no | no | no | **never read** |

This proposes a single `Diag` type with a code, a real `Span`, a severity, and
a producing stage, migrated **sink-first** so no stage is a flag day and every
stage self-hosts.

**Motivation is not tidiness.** The SFN-526 audit
(`docs/proposals/design-notes/sfn-526-lowering-fatal-gate-audit.md`) established
that this representation is why the compiler ships silent wrong code: with no
severity field, ~150 emission sites are indistinguishable from noise and are
discarded; with no span, a fatal that *does* fire reaches the user as raw text
with nothing to look up. Every prior fix in this area — SFN-34, SFN-119,
SFN-385, SFN-390, SFN-404, SFN-442, and the seven SFN-527…533 leaves — treated
an instance of it.

## 2. The crux: spans are already carried

The decisive question was whether `.sfn-asm` preserves source locations. **It
does**, at statement granularity, which makes this "adopt a struct" rather than
"add source-location fidelity to the native IR."

`emit_span_if_present` / `emit_initializer_span_if_present`
(`compiler/src/emit_native.sfn:456-464`) write `.span <sl> <sc> <el> <ec>` and
`.init-span`, round-tripping into `NativeInstruction.{Return,Expression,Let,Throw}.span`
and `NativeParameter.span`, typed `NativeSourceSpan?` (`compiler/src/native_ir.sfn:59-64`).

Coverage is exactly accountable. In `build/sailfin/.../array.sfn-asm` (1007 lines):
88 `.let` + 67 `eval` + 68 `.param` + 46 `ret` = **269 spanned constructs, 269
`.span` directives**, and **zero** for `.if`/`.loop`/`break`/`continue`, whose
`NativeInstruction` variants (`native_ir.sfn:24-50`) have no span field.

### 2.1 The loss point

`lower_instruction_range` (`llvm/lowering/instructions.sfn:61`) holds the span.
It survives into `lower_let_instruction` and `lower_expression_statement`. It
dies at:

```
compiler/src/llvm/expression_lowering/native/core.sfn:778
fn lower_expression(expression: string, bindings, locals, temp_index, lines,
                    functions, context, expected_type) -> ExpressionResult
```

No span parameter, and `ExpressionResult` (`llvm/types.sfn:248-254`) has
`diagnostics: string[]` with nowhere to put one. That single boundary blinds
339 of the ~586 push sites.

**The tree already concedes the point.** `coerce_operand_to_type` was given a
span by #540, and for want of a field, `format_coerce_span_location`
(`core_operands.sfn:44`) *string-formats it into the message*. Same at
`format_suspension_location` (`core.sfn:770`). The compiler has spans at these
sites and is packing them into prose. That is a struct problem.

### 2.2 The three sets

| Set | Sites | Needed |
|---|---|---|
| **A** — spanned today | 133 pushes under `llvm/lowering/`; covers **every** SFN-527 fabricating consumer and SFN-528's `statement.sfn:229` | nothing; the span is a local |
| **B** — needs an additive `.span` | SFN-528's `instructions.sfn:532/584/659`; SFN-533's `instructions_for_range.sfn:269` | ~30 lines: emit `.span` before control-flow directives, add the field, attach in the parser |
| **C** — structurally span-blind | the 339 pushes under `llvm/expression_lowering/` | statement-granularity only; `.sfn-asm` models expressions as opaque strings |

**Set C's ceiling is acceptable.** `render_diagnostic`
(`compiler/src/diagnostics_render.sfn:419-447`) reads only `token.line`,
`token.column`, and `lexeme` width — a point plus a caret. A statement span is
strictly more than the frontend renders today.

For Set C the mechanism is **fill-down, not thread-down**: do not add a span
parameter to `lower_expression` and its fan-out. The instruction-scoped caller
stamps its span onto every returned diagnostic whose span is null
(`stamp_spans`), so ~6 call sites cover all 339 downstream sites with no hot-path
signature churn.

## 3. The unified type

`Token` (`compiler/src/token.sfn:17-22`) is the wrong span carrier: it is a
*point*, the renderer ignores its `kind`, and the backend has no tokens.
`SourceSpan` (`ast.sfn:28-33`) and `NativeSourceSpan` (`native_ir.sfn:59-64`)
are already structurally identical — a fifth duplication — and carry start and
end.

New leaf module `compiler/src/diagnostic.sfn`:

```
struct Span { start_line: int; start_column: int; end_line: int; end_column: int; }

struct Diag {
    code: string;          // "E1003"; "" permitted only at note severity
    severity: string;      // "error" | "warning" | "note"
    message: string;       // no "llvm lowering: " prefix, no "[fatal]" tag
    file_path: string;     // "" when unknown
    span: Span?;           // null when unknown
    stage: string;         // parse|typecheck|effect|emit-native|lowering|tssa|tensor
    suggestion: FixSuggestion?;
}
```

`stage` absorbs the `producer` field currently threaded *alongside* the
diagnostic via `CheckJsonEvent.producer` (`diagnostics_json.sfn:149`) and
replaces the `"llvm lowering: "` prefix concatenated at ~300 sites.

### 3.1 Converge the sink, not the source

The backend must **not** import `Diagnostic` from `typecheck_types.sfn`: that
module imports `ast.sfn` and `token.sfn`, so doing so drags the frontend AST
across the emit boundary. (Verified: `llvm/` has no such import today — all
`Diagnostic` matches under `llvm/` are comments.)

Instead the **renderer and JSON encoder become `Diag`-native**, with
`diag_from_typecheck(d: Diagnostic) -> Diag` applied at the frontend's handful
of sinks. Token → Span uses `end = (line, column + lexeme.length)`, which is
exactly what `_dr_build_caret` computes today, so rendering stays byte-identical.
The frontend keeps producing `Diagnostic` unchanged — **zero blast radius on the
hundreds of typecheck factory sites** — and other sources converge one at a
time afterwards.

### 3.2 Deliberate non-changes

- **`severity` stays a `string`**, not an enum. It is already a string, the
  `sailfin-check/1` schema documents it as one, and changing a field's type
  mid-struct is the GEP-layout hazard recorded at `typecheck_types.sfn:62-70`
  and post-mortemed in `docs/rca/2026-04-18-reexport-diagnostic-gep.md`. Add
  `diag_is_error(d) -> boolean` instead.
- **Do not unify `SourceSpan`/`NativeSourceSpan`/`Span` by re-export.** That
  same RCA *is* a re-export bug — an implicit re-export emitted no `.fn` entry
  and silently mis-lowered every call. Define `Span` once, provide two 4-field
  converters; collapsing the three structs is an optional follow-up.
- **No `ice` severity** — `compiler/src/ice.sfn` owns that seam.

## 4. Severity model

Today only two states exist: fails the build (`[fatal]`), and discarded.

| Level | Behaviour | New user-visible behaviour? |
|---|---|---|
| `error` | fails the build, printed | **no** — identical to `[fatal]` |
| `warning` | printed, does not fail | **yes, new** |
| `note` | printed only under `SAILFIN_DEBUG_LOWERING`/`--verbose` | **no default change** — "silently dropped" becomes "dropped unless asked" |

**Introducing the level is not the same as populating it.** Every currently
untagged site migrates to `note`, never `warning`. Promoting ~150 sites to
`warning` would spew on every green build, and SFN-526 §4 is explicit that the
class-(b) sites describe checks **the language does not yet claim to make** —
surfacing them would market unenforced features, violating "parsed but not
enforced is not shipped." Each promotion is a separate per-site decision.

**E-code range.** Lowering owns none today; it squats in typecheck's `E08xx`
(`E0806`, `E0817`, `E0832`). Allocate **`E10xx` = lowering/backend**, homed at
`compiler/src/llvm/`. The three existing codes are **not** renumbered — retired
codes are never reused.

## 5. Migration

### 5.1 The shim that removes the flag day

`diag_to_legacy_string(d: Diag) -> string` reproduces today's spelling exactly
(`"llvm lowering [fatal] [E1003]: …"` for errors, `"llvm lowering: …"`
otherwise). With it, any one of the **72** `diagnostics: string[]` carrier
fields flips independently in either direction, and
`has_fatal_lowering_diagnostic` stays operational on `string[]` throughout.

At no intermediate point can a diagnostic that fails the build today stop
failing it: it is either still a `[fatal]` string or an `error` `Diag`, and both
gates stay live until the final stage.

> The real migration surface is **72 struct fields**, not 586 push sites —
> ~40 of them in `llvm/types.sfn` alone. Push sites follow their carrier
> mechanically.

**`diag_to_legacy_string` is a back-compat shim, never a renderer.** Note what
"reproduces today's spelling exactly" means at the severity every migrated site
lands on: the `[fatal]` tag *and* the `[Exxxx]` code are emitted only for
`error`, so a `note` renders as `"<stage>: <message>"` with **no code at all**.
That is correct for the shim's stated contract and is pinned by
`compiler/tests/unit/diagnostic_test.sfn`. It is wrong for anything a user
reads.

The hazard is that every caller is currently safe by accident — all of them feed
it `Diag`s from `lowering_error_diag`, which hardcodes `severity: "error"`. Under
§4/D2 the ~150 untagged sites all migrate to `note`, at which point any
render-through-the-shim silently drops its code with no compiler complaint.
SFN-538 hit exactly this: its first cut rendered notes without codes and a test
caught it. **A stage that displays a diagnostic must build the line explicitly**
— read `Diag.stage` and `Diag.code` rather than hardcoding either, as
`emit_native_diag_lines` (`compiler/src/emit_native.sfn`) does. S5 is the
central resolution: once the legacy channel is gone, the shim should be deleted
outright rather than left as a rendering foot-gun.

### 5.2 Stages

Each self-hosts (`.claude/rules/selfhost-invariant.md`); none weakens
fail-closed behaviour.

**Scope each stage by tracing a real build, not by grepping the carrier type.**
The "72 struct fields" framing above is the right *size* estimate and the wrong
*discovery* method, because a carrier grep cannot see a sibling function that
duplicates the producing logic and drops the carrier entirely. S7 was scoped
that way and missed its own path: `emit_native_lines_with_module_name` is a
near-verbatim duplicate of `emit_native_with_module_name` that accumulates the
same diagnostics and returns only the line array, so the four `EmitNativeResult`
call sites S7 named turned out to be fallback-only and the common path stayed
silent (SFN-538 shipped the sidecar; SFN-608 carries the remainder).

The same shape sits around `LoweredLLVMLinesResult`, which S3/S5 target:
`LoweredLLVMResult` has no `diags` field, and the two `lower_to_llvm_with_*`
entry points hand-copy every field except that one; `lower_to_llvm_ir_from_text`
— the primary path — consults no fatal gate at all, unlike its two siblings; and
three unused entry points hardcode `diags: []`. Before implementing a stage,
enumerate the entry points reaching its carrier and check each for a
duplicate-body or field-dropping conversion.

- **S1 — sink converges.** `compiler/src/diagnostic.sfn` (`Span`, `Diag`,
  constructors, `diag_to_legacy_string`, `diag_is_error`, `stamp_spans`,
  converters) **bundled with** making the renderer and JSON encoder
  `Diag`-native. Acceptance: `sfn check --json` byte-identical.
- **S2 — lowering produces `Diag` behind the legacy boundary.** Add
  `LoweredLLVMLinesResult.diags: Diag[]` **appended after** the existing field
  (GEP-append discipline). Convert the ~26 tagged sites and the SFN-527/528
  consumers, with a real `Span` wherever the `NativeInstruction` is in scope
  (Set A). This is where SFN-404/SFN-34's "raw fatal, no code, no span" is fixed.
- **S3 — fill-down spans (Set C).** `stamp_spans` at ~6 entry points. Also audit
  the ~140 forwarding sites (SFN-526 §6, #631/#1954).
- **S4 — Set B control-flow spans.** Additive `.span` before
  `.if`/`.loop`/`.for`/`.match`/`break`/`continue`. Fail-soft: a stale cached
  `.sfn-asm` is merely span-less, never wrong.
- **S5 — retire the substring; fix gate integrity (closes SFN-529).** Drop
  `diagnostics: string[]` from the hot carriers; `has_fatal_lowering_diagnostic`
  → `has_error_diag`. Size guards must **retain every `error`** rather than
  clearing the array (`lowering_phase_sanitize.sfn:89-96`,
  `lowering_io.sfn:44-59`), and the two silent gates print their cause.
- **S6 — converge `TssaDiagnostic` and `TensorVerifyResult`.** Parallel to S2–S5.
- **S7 — revive the dead `emit_native` channel.** `EmitNativeResult.diagnostics`
  is never read at any of its four `main.sfn` call sites (`:347, 429, 433, 515`),
  despite being the **highest-fidelity** channel in the compiler — full AST,
  every span available.

## 6. Seed dependency

**`Required in pinned seed: None` at every stage.** Per
`.claude/rules/seed-dependency.md`, each stage bundles its capability with its
consumer, so `make compile` builds the new compiler from the old seed and that
fresh compiler compiles the consumer in the same pass.

The runtime carve-out does **not** apply: `grep -rn "Diagnostic\|typecheck_types" runtime/`
returns only *comments* (extern-signature references in
`runtime/sfn/platform/*.sfn`, `runtime/sfn/memory/mem.sfn`). No import, no call.

S4 is the only stage touching the `.sfn-asm` format, and emitter and parser are
always the same binary within one build — no cross-version artifact exchange.
(See §9 open question 1 on cache keying.)

## 7. Relationship to in-flight work

**SFEP-0059 (typed SSA activation) — run alongside; do not block.** SFN-508 is
`Ready`/Urgent; gating it on a diagnostics refactor is the wrong trade.
`TssaDiagnostic` is two fields with one constructor, ~1 point to convert later.
**Constraint on SFN-508, adopted at the design gate: do not add fields to
`TssaDiagnostic`.** It is scheduled for replacement by SFN-537, so a field added
now is a field to migrate twice. Recorded on SFN-508 itself; if that issue has
already extended the type, SFN-537 reconciles rather than reverts.

**Typed SSA is not the natural carrier.** `Instr`/`SsaBlock`/`SsaFunction`
(`typed_ssa.sfn:132-186`) carry **no source locations at all**, and SFEP-0015 §9
does not lock one; SFEP-0059 §2 states v0 "cannot represent any substantial
Sailfin function," so it would carry the type for ~0% of real diagnostics. The
natural carrier is the **sink**, which every channel already reaches.

> Forward note for SFEP-0059: typed SSA should acquire a span slot **before** L3
> makes it load-bearing, or it re-mints exactly this problem.

**SFEP-0015 (native backend) — precede.** Instruction selection, register
allocation, and object emission will mint a new diagnostic surface. Settling
`Diag` first means that surface is born with codes, spans, and severity.
**Adopted at the design gate: SFN-534 and SFN-535 are a prerequisite of the
native-backend *emission* work** — not of SFN-508, which is a producer and is
explicitly unblocked. The bar is deliberately narrow: only the two issues that
establish the type and prove it through one real backend producer. Everything
after them can land while the native backend proceeds.

## 8. Performance

**Not material.** The 586 sites are *potential*, not realized — a green build
produces zero to single-digit diagnostics per module, so struct-vs-string is not
on any success path. `Diag` adds ~48 bytes of header over a string handle;
message payload dominates both. The size guards trip at 1,000,000 entries, three
orders of magnitude above observed counts; the real memory pressure in lowering
is `lines: string[]` (IR text), not diagnostics.

**One thing must stay lazy:** `render_diagnostic` takes `source_lines` to draw
the caret, but lowering runs in per-module subprocesses without the source
resident. Carry `file_path` + `Span` only; let the CLI boundary read the file
once, on the failure path.

*Free win, not a requirement:* ~150 messages are built by multi-concatenation
and then discarded (`instructions.sfn:659` does four concatenations for a message
nobody reads). Deferring construction at `note` severity is an unconditional
gain.

## 9. Decisions taken at the design gate

Owner approval 2026-07-25 deferred the three judgement calls below to the
proposal. They are decisions, not open questions.

**D1 — `.sfn-asm` keeps the module slug; no `.source` directive.** The v1 header
stays `.module runtime/sfn/clock`, with the path reconstructed by
`module_source_filename` (`llvm/lowering/lowering_io.sfn:146-153`). Rationale:
the slug already backs the `.ll` `source_filename`, so a second path notion
would be a divergence to keep in sync; the reconstructed path is correct for
every in-tree module, and the failure mode (a user compiling a file whose
on-disk path differs from its module slug) is cosmetic — a header line, with the
line and column still exact. Revisit only if a real report shows the slug
misleading someone. Adding a directive is cheap and additive later; removing one
is not.

**D2 — no class-(b) site is promoted to `warning` by this epic.** Everything
currently untagged migrates to `note` and stays there. The nine sites in
SFN-526 §4 (`core_ownership.sfn:74/102`, `lifetime.sfn:608-639`,
`statement_suspension.sfn:128/150`, and siblings) describe checks the language
**does not claim to enforce** — borrow exclusivity is "Parsed only"
(`docs/status.md`), and use-after-move is enforced by `ownership_checker.sfn`
(`E0901`), so the lowering copies are vestigial. Surfacing them as warnings
would advertise guarantees that do not hold, which is the "parsed but not
enforced is not shipped" rule in its most consequential form: a warning users
learn to trust is worse than silence when the check behind it is partial.

The correct trigger for promotion is the **enforcement shipping**, not this
refactor. Each promotion belongs to the issue that implements the corresponding
check, and inherits that issue's evidence.

**D3 — `Diagnostic` is not retired; `Diag` converges the sink only.** Both types
stay indefinitely. `Diagnostic` remains the frontend's producer-side type and
converts at the boundary (§3.1). Retiring it would touch hundreds of typecheck
factory sites to delete a converter — a large diff whose only benefit is
uniformity, against a type that already carries everything `Diag` does. If S5
shows the duplication costing real maintenance, reopen it as its own proposal
with that evidence.

### 9.1 Verification items (empirical, not judgement)

These are unverified facts that gate specific issues, carried on those issues:

1. **Build-cache keying for S4** (SFN-536). Does `compiler/src/build_cache.sfn`
   reuse `.sfn-asm` across compiler versions? Degradation is fail-soft, but the
   key should probably include the compiler version.
2. **SFEP-0043 arena rewind** (SFN-535). `compile_to_llvm_file_with_module_imports`
   rewinds an arena; any `Diag[]` outliving it must be materialized first.

*Resolved during drafting:* `llvm/` has no `Diagnostic` import (comments only),
and the schema-lock guard exists as `compiler/tests/e2e/check_json_schema_test.sfn`
— only `docs/reference/check-json-schema.md:21`'s reference to the retired
`.sh` test is stale.

*Unmeasured:* the compile-time cost of `diagnostic.sfn` reaching lowering, and
any #1389-class hazards on first lowering. SFN-534 carries the same risk budget
SFN-508 does.

## 10. Decomposition

Linear Project: **Diagnostic Unification**.

| Issue | Title | Est | Depends on |
|---|---|---|---|
| SFN-534 | introduce `Diag`/`Span`; renderer + JSON encoder become `Diag`-native | 3 | — |
| SFN-535 | lowering emits `Diag` for every `[fatal]` site; allocate `E10xx` | 3 | SFN-534 |
| SFN-536 | `.span` for control-flow directives | 2 | SFN-534 |
| SFN-537 | converge `TssaDiagnostic` + `TensorVerifyResult` | 2 | SFN-534 |
| SFN-538 | surface the discarded `EmitNativeResult.diagnostics` | 2 | SFN-534 |
| SFN-539 | fill statement spans down via `stamp_spans` | 2 | SFN-535 |
| SFN-540 | retire the `[fatal]` substring; guards preserve `error` (**closes SFN-529**) | 3 | SFN-535, SFN-539, SFN-536 |
| SFN-541 | regression guard that a sub-`error` survives every forwarding frame | 2 | SFN-539 |

Order: **534 → {535, 537, 538} → {539, 536} → {540, 541}**. 19 points; three
parallelize immediately after SFN-534.

Three bundles are deliberate: the type ships with its renderer (a type with no
consumer is a manufactured split); issue 5 bundles substring retirement, the
guard carve-out, and the silent gates because all three touch the same gate; and
issue 4's emitter and parser halves are one directive. None is forced by a seed
gate — there is none.
