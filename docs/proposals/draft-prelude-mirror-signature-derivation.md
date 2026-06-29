---
sfep: TBD
title: Deriving prelude-mirror registry signatures from the prelude (kill latent ABI drift)
status: Draft
type: runtime
created: 2026-06-29
updated: 2026-06-29
author: "agent:compiler-architect; human review"
tracking: "#572"
supersedes:
superseded-by:
graduates-to:
---

# SFEP-XXXX — Deriving prelude-mirror registry signatures from the prelude (kill latent ABI drift)

> Re-grooming of issue #572 ("derive prelude-mirror registry signatures from
> prelude AST"). The issue was filed 2026-05-14; the runtime landscape has moved
> substantially since (C runtime deleted, `extern fn` shipped, the #633
> import-shadow mitigation landed, the `{i8*, i64}` length-aware string ABI of
> SFEP-0033 reworked these exact rows). This SFEP re-evaluates the four options
> against today's tree and makes a decisive, sequenced recommendation.

## 1. Summary

A handful of `RuntimeHelperDescriptor` rows in
`compiler/src/llvm/runtime_helpers.sfn` are **prelude mirrors**: `target ==
symbol`, `native_signature: null`, and an LLVM signature
(`return_type` + `parameter_types`) that is **hand-typed to match a function
defined in `runtime/prelude.sfn`** — with no cross-check between the two. Today
there are exactly **6** such rows (`char_code`, `char_at`, `char_from_code`,
`find_char`, `string_starts_with`, `record_eq_flag_message`). On a normal build
the #633 import-shadow guard suppresses these rows in favour of the prelude's
own emitted `declare`, so the hand-typed shape only fires as a **fallback** in
trees where the prelude is not in the import context (the `test`-command path,
partial seedcheck sandboxes). The hazard is therefore **latent**: a drift
between a mirror row and its prelude definition is invisible on a normal
self-host build and surfaces only as a silent ABI mismatch (or a stale
`declare` the linker resolves to a mis-shaped body) on a fallback path.

This SFEP recommends a **sequenced** fix:

1. **Near-term (recommended, ship pre-1.0): a reconciliation guard.** A new
   pass cross-checks each of the 6 mirror rows against the prelude function's
   actual lowered signature and **fatals on mismatch** — wired so it fires on
   *every* build where the prelude is present (normal builds), and a regression
   test pins the invariant. This converts the silent-drift class into a loud,
   build-time failure for a few hours of work, without removing the duplication.
2. **Follow-up (sequenced next, not deferred): full derivation.** Generate the
   mirror rows from the prelude rather than hand-typing them, eliminating the
   duplication structurally. This is the larger cleanup the original issue asked
   for. It is sequenced *after* the guard for a concrete safety reason — the
   guard first proves, on every build, that the derived shapes match the
   hand-typed ones, so deleting the hand-typed rows carries no behavioral risk —
   **not** because it is low priority. Both sub-issues are filed as actionable
   work; the second is blocked only by the first, and should be picked up
   promptly once the guard lands so the duplication is actually removed and we
   do not re-litigate this coupling in a few months.

## 2. Motivation

### 2.1 The coupling, precisely

`compiler/src/llvm/runtime_helpers.sfn` builds a registry of
`RuntimeHelperDescriptor` (defined in `compiler/src/llvm/types.sfn:67-91`:
`target`, `symbol`, `return_type`, `parameter_types`, `effects`,
`native_signature: string?`, `c_abi_return_type: string?`). The registry is
assembled from 12 chunked builders `_rh_descriptors_00..11` via
`runtime_helper_descriptors()` (`runtime_helpers.sfn:1642`).

A **prelude-mirror row** is one where:

- `target == symbol` (the descriptor's emitted symbol IS a prelude free
  function, not a `target != symbol` alias like `monotonic_millis →
  sfn_clock_millis`);
- `native_signature: null` (no Sailfin-native ABI redirect); and
- the `return_type` / `parameter_types` are an LLVM transcription of a function
  body defined in `runtime/prelude.sfn`, maintained by hand.

The 6 surviving mirror rows, each verified against its prelude definition:

| descriptor (runtime_helpers.sfn) | prelude def (prelude.sfn) | registry LLVM sig | prelude source sig |
|---|---|---|---|
| `char_code` (:1315-1317) | `char_code` (:706) | `i64` ← `["{i8*, i64}"]` | `(character: string) -> int` |
| `char_at` (:1331-1333) | `char_at` (:177) | `{i8*, i64}` ← `["{i8*, i64}", "i64"]` | `(value: string, index: int) -> string` |
| `char_from_code` (:1343-1345) | `char_from_code` (:741) | `i8*` ← `["i64"]` | `(code: int) -> string` |
| `find_char` (:1629-1631) | `find_char` (:652) | `i64` ← `["{i8*, i64}", "{i8*, i64}", "i64"]` | `(text: string, character: string, start: int = 0) -> int` |
| `string_starts_with` (:1632-1634) | `string_starts_with` (:358) | `i1` ← `["{i8*, i64}", "{i8*, i64}"]` | `(value: string, prefix: string) -> boolean` |
| `record_eq_flag_message` (:1635-1637) | `record_eq_flag_message` (:647) | `i1` ← `["i1", "{i8*, i64}", "i1", "{i8*, i64}"]` | `(boolean, string, boolean, string) -> boolean` |

Each registry row is a manual lowering of the prelude signature
(`string → {i8*, i64}`, `int → i64`, `boolean → i1`). Nothing in the build
verifies the transcription stayed correct as the string ABI moved
(SFEP-0033 / #1719 / #1728 flipped `string` from bare `i8*` to the
length-aware `{i8*, i64}` aggregate, touching `char_code` / `char_at` /
`find_char` / `string_starts_with` directly). The next ABI move that lands in
the prelude but is forgotten in the registry drifts silently.

### 2.2 What changed since #572 was filed — the stale premise

The 2026-05-14 issue framed this against a tree that no longer exists:

- **"~50+ `symbol != target` rows genuinely describe a foreign C ABI and should
  stay hand-typed."** Obsolete. The C runtime (`runtime/native/`) was **deleted
  (#822)**. Most non-mirror rows now route to Sailfin-native `sfn_*` symbols
  defined in `runtime/sfn/` (e.g. the grapheme/codepoint accessors at
  `runtime_helpers.sfn:1364-1372` carry `native_signature: sfn_str_*_lv`). The
  "foreign C ABI must stay hand-typed" justification for the bulk of the
  registry is gone.
- **"~12 mirror rows."** Now **6** (§2.1). #633 and subsequent consolidation
  retired the rest.
- **`extern fn` did not yet exist as the issue's "cleaner declaration
  mechanism" speculation.** It now ships and is used throughout `runtime/sfn/`
  and the prelude itself (`runtime/prelude.sfn:739 extern fn
  sfn_str_from_byte(...)`). The filesystem **sentinel** rows
  (`runtime_helpers.sfn:415-445`) already encode the pattern "registry sentinel
  carries no concrete signature; the firing module's `extern fn` provides the
  `declare`" — prior art for one structural fix direction.

### 2.3 The hazard is latent, not silent-on-every-build

A partial mitigation already landed in **#633**. The declare-emitter
`render_runtime_helper_declarations()` (`rendering.sfn:105`) computes
`effective_symbol` (`native_signature` if set, else `symbol`,
`rendering.sfn:296-300`) and, at `rendering.sfn:306-325`, **skips a `target ==
symbol` mirror row when its symbol is in `imported_symbols`** (it sets
`_shadowed_by_import` and `continue`s). The symmetric half lives in
`render_imported_function_declarations` (`rendering.sfn:419-433`): the imported
declare — carrying the prelude's source-of-truth lowered types — wins.

So on a **normal build** (prelude `.sfn-asm` staged and imported), the prelude's
own emitted `declare` fires and the hand-typed registry row does **not**. The
registry row only fires as a **fallback** in trees where the prelude is not in
the import context (the `test`-command path; partial seedcheck sandboxes that
do not stage the prelude).

This is a **suppress-if-imported guard, not a reconciliation**: there is no
cross-check anywhere between the registry's `return_type`/`parameter_types` and
the prelude's actual lowered `define`. The two can disagree and:

- on a normal build the disagreement is **invisible** (the row is suppressed);
- on a fallback path the **stale registry shape is emitted as the `declare`**,
  and the linker resolves the call against the real prelude body — an ABI
  mismatch that is a silent miscompile (wrong return-register class, truncated
  aggregate) rather than a clean error.

Characterizing this honestly: it is **not** "every build silently miscompiles."
It is "drift is uncaught everywhere and *exploitable* on the fallback paths."
For a production-bound 1.0 compiler, an uncaught silent-miscompile class — even
a latent one — is the thing to close.

## 3. Design (recommended: reconciliation guard, then sequenced derivation)

### 3.1 The recommended near-term fix — a mirror-row reconciliation pass

**Goal:** make any drift between a mirror row and its prelude definition a
**loud, build-time fatal on a normal build**, plus a pinned regression. This
closes the silent-miscompile class without touching the duplication.

**Feasibility — the data is already in hand.** The declare-emitter already
receives `imported_functions: NativeFunction[]` and `local_functions:
NativeFunction[]` (`rendering.sfn:105`). `NativeFunction`
(`native_ir.sfn:73-82`) carries `name`, `parameters: NativeParameter[]`, and
`return_type` — the prelude function's *actual* lowered signature. The
reconciliation does not need a new artifact or a build-graph change: it compares
the registry row against the `NativeFunction` already present in the import
context.

**Where it lives.** Extend the existing shadow check in
`render_runtime_helper_declarations` (`rendering.sfn:306-325`). Today, when a
`target == symbol` row's symbol is in `imported_symbols`, the code sets
`_shadowed_by_import = true` and skips. The reconciliation inserts a check
*before* the skip:

1. Locate the imported `NativeFunction` whose `name` (sanitized) equals
   `effective_symbol`.
2. Lower its `parameters[*].native_type` and `return_type` to the same LLVM
   shape strings the registry uses (reusing the existing type-mapping the
   emitter already applies to render imported declares — `string → {i8*, i64}`,
   `int → i64`, `boolean → i1`, etc.; this mapping is already exercised by
   `render_imported_function_declarations`).
3. Compare element-by-element against the descriptor's `parameter_types` and
   `return_type`.
4. **On mismatch: emit a fatal diagnostic** naming the descriptor `target`, the
   registry shape, and the prelude shape — e.g.
   `runtime-helper mirror row 'char_code' signature drift: registry declares i64(...{i8*, i64}...) but prelude 'char_code' lowers to i64(...i8*...); update runtime_helpers.sfn or the prelude in lock-step`.
5. **On match: skip as today** (`_shadowed_by_import = true`).

Because this fires exactly when the prelude IS in the import context — i.e. on
**every normal build, including `make compile`** — drift is caught at the moment
it is introduced, by whoever introduces it, on the cheapest gate that sees both
shapes. The fallback paths (where the prelude is absent and the registry row
fires) keep emitting the registry shape; the guarantee is that on a normal build
that shape is *proven* to match the real define, so the fallback shape is
trustworthy by construction.

**Scope of the reconciliation set.** Restrict to the `target == symbol &&
native_signature == null` rows (the mirror class). The 6 rows of §2.1 are the
universe today; the predicate is self-maintaining — any future row matching it
is automatically reconciled, and any row that gains a `native_signature`
(joining the redirect class) drops out, which is correct (redirected rows do not
mirror a prelude define).

**Why this shape (vs. a standalone pass).** Folding the check into the existing
`_shadowed_by_import` branch reuses the exact `imported_functions` data and
type-mapping the emitter already has, adds no new traversal, and keeps the
fatal physically adjacent to the suppression it guards — the two are the same
decision ("is the prelude define present, and does it agree?").

```sfn
// Illustrative shape of the inserted check in
// render_runtime_helper_declarations (rendering.sfn ~:316), pseudo-code:
if descriptor.target == descriptor.symbol && descriptor.native_signature == null {
    if string_array_contains(imported_symbols, effective_symbol) {
        // NEW (#572): reconcile registry shape against the prelude define
        // before deferring to it.
        let imported = find_imported_fn(imported_functions, effective_symbol);
        if imported != null {
            let prelude_ret = lower_native_return(imported.return_type);
            let prelude_params = lower_native_params(imported.parameters);
            if prelude_ret != descriptor.return_type
                || !param_lists_equal(prelude_params, descriptor.parameter_types) {
                fatal_mirror_drift(descriptor, prelude_ret, prelude_params);
            }
        }
        _shadowed_by_import = true;
    }
}
```

### 3.2 The follow-up structural fix — derive the rows (sequenced next)

The reconciliation guard makes drift *loud* but leaves the duplication in place.
The structural fix the original issue asked for — **generate the mirror rows
from the prelude rather than hand-typing them** — is the second sub-issue, picked
up promptly once the guard lands. It reduces to a variant of Option C (§6): have
the declare-emitter consult the prelude's emitted define directly for the 6
mirror symbols and drop the hand-typed rows entirely, keeping the registry only
for true non-prelude symbols. With the reconciliation guard already proving the
shapes agree on every build, the derivation becomes a pure de-duplication with
no behavioral risk — that is *why* it is sequenced second, not because it is low
priority. The guard closes the correctness gap immediately; the derivation
removes the duplication so this coupling cannot resurface. Both are actionable
work to be done in close sequence, not a now-versus-someday split. See §6 for
why A and B lost and why C-derivation is the structural target rather than A.

## 4. Effect & capability impact

None. These are runtime-helper ABI descriptors and a declare-emitter check with
no effect surface. The runtime capsule declares `required = []`
(`runtime/capsule.toml`). No `![...]` annotation changes. The reconciliation is
a pure compile-time consistency check; it neither grants nor requires a
capability.

## 5. Self-hosting impact

### 5.1 Recommended near-term guard

**Passes touched:** exactly one file changes — the LLVM rendering pass
`compiler/src/llvm/rendering.sfn` (the `render_runtime_helper_declarations`
function, ~:306-325, plus small private helpers to find the imported function
and lower its parameter/return types — reusing the type-mapping already applied
by `render_imported_function_declarations`). No lexer/parser/AST/typecheck/
effect-checker/emitter change.

**Why `make compile` stays green:** the guard is purely *additive and
conditional* — it inserts a comparison that only fatals on a *genuine* mismatch.
The 6 mirror rows are verified in §2.1 to already match their prelude
definitions today (the `{i8*, i64}` ABI work of SFEP-0033 kept them in sync), so
on the current tree the reconciliation passes silently and the build is
byte-identical to today. The new compiler built by the **pinned seed** during
the first `make compile` pass simply carries the extra check; it does not change
any emitted IR for a tree whose rows are in sync. The seedcheck/stage2/stage3
passes likewise see matching rows and proceed. **No seed cut is required** — the
change is entirely in compiler/src, lands in one PR, and self-hosts in a single
pass because it alters no ABI and no symbol (per `.claude/rules/seed-dependency.md`
this is a no-seed-dependency change: the new compiler's behavior on in-sync rows
is identical to the seed's).

**Failure mode this introduces:** if a future PR drifts a mirror row, the *next*
`make compile` fatals during rendering with the §3.1 diagnostic — which is the
entire point. This is strictly safer than the status quo (silent fallback-path
miscompile).

### 5.2 Follow-up derivation

Its self-hosting analysis (consulting the prelude define directly, dropping the
hand-typed rows) is in §6 under Option C. It lands after the guard-protected
tree makes the de-duplication risk-free — the sequencing is a safety ordering,
not a deferral. It carries its own detailed self-hosting analysis at its design
gate (it does change what the fallback paths emit, so the build must stay green
on both normal and `test`-command paths).

## 6. Alternatives considered

The issue posed four options. Re-evaluated against today's tree:

**Option A — Compiler-generated signature table.** Emit a `prelude_signatures`
artifact from the prelude AST during the prelude compile; `runtime_helpers`
consumes it for the mirror rows. **Rejected for now.** It introduces a new
build artifact and a **bootstrap/cold-build ordering** problem: the registry is
compiled *into the compiler*, but the artifact is produced by *running* the
compiler on the prelude — a chicken-and-egg the build graph does not currently
have (the registry is static data today). On a cold build with no prior
artifact, the registry would have no signatures to consume. Solving that
(staging a checked-in artifact, or a two-phase prelude compile) is real
build-architecture work (cf. SFEP-0006) for a 6-row problem. The reconciliation
guard achieves the safety goal with zero build-graph change. A is over-built for
the current scale.

**Option B — Declare-emitter reconciliation (consult the prelude's emitted
`define`, fatal on mismatch).** **This is essentially the recommended fix** —
and the key re-evaluation finding is that **#633 already built the suppression
half.** B reduces to "extend the existing `_shadowed_by_import` shadow-check
into a reconciliation that *also* validates before deferring." The circular-
build-ordering concern the original issue raised does **not** apply: the check
reads `imported_functions` (`NativeFunction` structs already in hand,
`native_ir.sfn:73-82`) at render time — there is no second compile, no artifact,
no new build phase. **Adopted as §3.1.** (The one nuance: on fallback paths the
prelude is absent, so B cannot *reconcile* there — only suppress-or-emit. That
is acceptable: the guarantee is established on every normal build, and the
fallback shape is proven correct transitively.)

**Option C — Hybrid: declare-emitter consults the prelude AST for mirror rows
directly; registry is fallback for non-prelude symbols.** This is the
**follow-up structural fix** (§3.2). It is the right *end state* — it removes the
duplication, not just the silent-drift — but it is a strict superset of B's
risk: dropping the hand-typed rows changes what the fallback paths emit (they
would need the prelude define available, or a derived stand-in). Sequencing C
*after* B is the safe order: B proves the shapes agree on every build, then C
deletes the now-redundant hand-typed rows knowing the derivation matches.
**Sequenced as the immediate follow-up to B**, tracked as Sub-issue 2 and picked
up once the guard lands — a safety ordering, not a deferral.

**Option D — Tighten the warning regime to a fatal on mirror-row ABI mismatch.**
The cheapest framing. The subtlety re-evaluated here: today there is **no
warning to tighten** — there is no cross-check at all, only suppression. So
"D-tightened" is not a one-line severity flip; it *is* the reconciliation of B
(you cannot fatal on a mismatch you never compute). The recommended §3.1 fix is
therefore the honest realization of D's intent: add the comparison, make it
fatal, fire it on every build. Pure-D (a fatal with no reconciliation) is
incoherent given the current code. **Subsumed into the recommendation.**

### Recommendation (one paragraph)

**Adopt Option B as the immediate reconciliation guard (§3.1), then land the
full Option-C derivation as its sequenced follow-up (§3.2) — both actionable
now, not a now-versus-post-1.0 split.** The decisive
factors: (1) the hazard is a latent silent-miscompile class — uncaught
everywhere, exploitable on the fallback paths — and for a production-bound 1.0
compiler closing that class is worth a few hours now; (2) #633 already built the
suppression half, so B is a small, surgical extension of one existing branch in
one file, with no new artifact, no build-graph change, and no seed cut; (3) the
data B needs (`imported_functions: NativeFunction[]` with real lowered
signatures) is already passed to the declare-emitter, so the original issue's
bootstrap/circularity objections do not apply; (4) the rows are in sync *today*
(SFEP-0033 kept them aligned), so the guard is byte-neutral on the current tree
and only ever fatals on a *genuine future drift* — exactly when you want it to.
Option A is over-engineered for 6 rows and adds a cold-build ordering problem;
Option C is the correct end-state but is a strict superset of B's risk and
belongs *after* B has proven the shapes agree. Sequencing B-then-C kills the
silent-miscompile class immediately and de-duplicates structurally as soon as it
is safe to delete the hand-typed rows — both pieces are committed work, not a
deferred someday-cleanup. Parking the structural half is precisely what left
this coupling unresolved since #572 was filed; this SFEP files both halves as
actionable issues so the duplication is actually removed.

## 7. Stage1 readiness mapping

For the recommended near-term guard (§3.1):

- [x] **Parses** — no new syntax; pure compiler-internal logic.
- [x] **Type-checks / effect-checks** — no effect surface; the change is a
  compile-time comparison.
- [x] **Emits valid `.sfn-asm`** — unchanged; the guard only validates and may
  fatal, never alters emitted IR on an in-sync tree.
- [x] **Lowers to LLVM IR** — the change *is* in the LLVM declare-emitter; on an
  in-sync tree the emitted declares are byte-identical to today.
- [ ] **Regression coverage** — added by this work (§8).
- [ ] **Self-hosts** — `make compile` must stay green (it will: §5.1); this box
  is checked when the guard lands and self-hosts.
- [ ] **`sfn fmt --check` clean** — required on the touched `rendering.sfn`.
- [ ] **Documented** — add a line to `docs/conventions/runtime-helpers.md` (the
  descriptor contract doc) describing the mirror-row reconciliation invariant;
  no `docs/status.md`/spec entry needed (this is an internal correctness gate,
  not a user-facing feature).

The follow-up Option-C derivation (Sub-issue 2) carries its own readiness
mapping at its design gate, picked up promptly after the guard lands.

## 8. Test plan

Per `.claude/rules/no-bash-e2e.md`, no bash e2e.

**T1 — integration regression: mirror-row reconciliation positive path
(`compiler/tests/integration/`).** A test that drives the declare-emitter with
the real registry and a prelude import context and asserts the 6 mirror rows
reconcile cleanly (no fatal). This pins the §2.1 table: if any of `char_code`,
`char_at`, `char_from_code`, `find_char`, `string_starts_with`,
`record_eq_flag_message` drifts from its prelude define, this test goes red.
Concretely, it builds (or frontend-checks via `assert_compiles` from `sfn/test`)
a module that imports the prelude and uses each of the 6 functions, and asserts
the build succeeds with no `signature drift` diagnostic.

**T2 — unit regression: reconciliation *fatals* on injected drift
(`compiler/tests/unit/`).** A unit test over `render_runtime_helper_declarations`
that feeds a synthetic mirror descriptor whose `return_type`/`parameter_types`
deliberately disagree with the imported `NativeFunction`, and asserts the
function emits the `signature drift` fatal diagnostic (asserting the message
names the `target` and both shapes). This proves the guard actually fires, not
just that the happy path is green — the failure mode the whole SFEP exists to
catch.

**T3 — e2e drift sentinel (`compiler/tests/e2e/*_test.sfn`).** An `![io]`
`*_test.sfn` that uses `assert_does_not_compile` (from `sfn/test`) on a fixture
constructed to surface a mismatch, or — more robustly — a build-and-check test
that compiles a small program exercising the 6 prelude functions and asserts a
clean exit, mirroring `compiler/tests/e2e/guillermo_test.sfn`'s subprocess shape
and threading `PATH`/`SAILFIN_TEST_SCRATCH` per the build-isolation rules in
`.claude/rules/no-bash-e2e.md`. This guards the *normal-build* path end-to-end.

**Binding gate.** `make compile` is the load-bearing check: the guard fires
during rendering on the first self-host pass, so a green `make compile` proves
the 6 rows reconcile against the prelude under the real build. `sfn check`
cannot prove it (no codegen/declare-emission), so this work is **not** done
until `make compile` is green (per the validation ladder in `CLAUDE.md`).

## 9. References

- **Issue #572** — original "derive prelude-mirror registry signatures from
  prelude AST" (this re-grooming).
- **#633** — the import-shadow mitigation this SFEP extends
  (`rendering.sfn:306-325, 419-433`).
- **#822** — C runtime (`runtime/native/`) deletion (stale-premise driver).
- **SFEP-0033** (`docs/proposals/0033-string-runtime-length-aware-abi.md`) —
  the accepted `{i8*, i64}` length-aware string ABI (#1704/#1719/#1728) that
  reworked `char_code`/`char_at`/`find_char`/`string_starts_with`; this SFEP
  must stay consistent with it (the mirror rows' `{i8*, i64}` parameter shapes
  derive from it).
- **SFEP-0025** (`docs/proposals/0025-native-runtime-architecture.md`),
  **SFEP-0015** (`docs/proposals/0015-llvm-independence.md`) — runtime/backend
  framing.
- **SFEP-0006** (`docs/proposals/0006-build-architecture.md`) — build graph,
  relevant to why Option A's artifact approach is deferred.
- `compiler/src/llvm/runtime_helpers.sfn:1315-1317, 1331-1333, 1343-1345,
  1629-1637` (the 6 mirror rows); `:415-445` (filesystem sentinel prior art);
  `:1642` (`runtime_helper_descriptors()`).
- `compiler/src/llvm/types.sfn:67-91` (`RuntimeHelperDescriptor`).
- `compiler/src/llvm/rendering.sfn:105` (`render_runtime_helper_declarations`),
  `:296-300` (`effective_symbol`), `:306-325` (`_shadowed_by_import` skip — the
  insertion point), `:419-433` (symmetric imported-declare win).
- `compiler/src/native_ir.sfn:73-82` (`NativeFunction`: `parameters`,
  `return_type` — the reconciliation data source).
- `runtime/prelude.sfn:177` (`char_at`), `:358` (`string_starts_with`),
  `:647` (`record_eq_flag_message`), `:652` (`find_char`), `:706` (`char_code`),
  `:739` (`extern fn sfn_str_from_byte`), `:741` (`char_from_code`).
- `docs/conventions/runtime-helpers.md` — the descriptor contract doc to update.

---

## Appendix — sub-issue breakdown (ready for `/groom`)

Two sub-issues, both actionable. Per the recommended sequence, the first is the
immediate safety guard; the second is the structural de-duplication, blocked
only by the first and picked up promptly once it lands — not deferred.

### Sub-issue 1 (near-term, recommended): "Reconcile prelude-mirror registry rows against the prelude define; fatal on drift" — size **S**

- **Type:** `type:enhancement` (correctness gate) · `area:llvm` ·
  `priority:` (pre-1.0; closes a latent silent-miscompile class).
- **Design:** SFEP-XXXX §3.1.
- **In:**
  - Extend `render_runtime_helper_declarations` (`rendering.sfn:306-325`) so a
    `target == symbol && native_signature == null` mirror row, when its symbol
    is in the import context, **reconciles** its `return_type`/`parameter_types`
    against the imported `NativeFunction`'s lowered signature **before**
    deferring (`_shadowed_by_import`).
  - On mismatch, emit a **fatal** diagnostic naming the `target`, the registry
    shape, and the prelude shape (§3.1 message).
  - Small private helpers: find the imported `NativeFunction` by sanitized name;
    lower its `parameters`/`return_type` to LLVM shape strings (reuse the
    type-mapping `render_imported_function_declarations` already applies).
  - Tests T1 (integration: 6 rows reconcile clean) and T2 (unit: injected drift
    fatals) from §8.
  - One-line entry in `docs/conventions/runtime-helpers.md` documenting the
    invariant.
- **Out:** removing/deriving the hand-typed rows (that is Sub-issue 2); any
  change to non-mirror (`target != symbol` or `native_signature != null`) rows;
  any new build artifact or build-graph change; the optional T3 e2e (may be
  folded in or filed separately).
- **Acceptance criteria:**
  - The 6 mirror rows of §2.1 reconcile cleanly; `make compile` is green and
    emits byte-identical declares for the current (in-sync) tree.
  - A deliberately-drifted mirror descriptor produces the fatal diagnostic
    (T2), and the message names the target and both shapes.
  - `sfn fmt --check` clean on `rendering.sfn`; T1 + T2 pass under
    `make test`.
- **Verification:** `make compile` (binding gate); `sailfin test
  compiler/tests/integration` and `.../unit` for T1/T2.
- **Files affected:** `compiler/src/llvm/rendering.sfn`;
  `compiler/tests/integration/<new>_test.sfn`,
  `compiler/tests/unit/<new>_test.sfn`; `docs/conventions/runtime-helpers.md`.
- **Blocked by:** none.

### Sub-issue 2 (follow-up, blocked by Sub-issue 1): "Derive prelude-mirror declares from the prelude; drop the 6 hand-typed rows" — size **M**

- **Type:** `type:refactor` · `area:llvm` · actionable; sequenced immediately
  after Sub-issue 1 (the guard is its safety predecessor, not a postponement).
- **Design:** SFEP-XXXX §3.2 / §6 Option C.
- **In:**
  - Have the declare-emitter source the mirror symbols' declares from the
    prelude's emitted define directly (Option C), and **remove** the 6
    hand-typed rows from `runtime_helpers.sfn`.
  - Handle the fallback paths (prelude absent): either guarantee the prelude
    define is staged for those paths, or derive a stand-in from a checked-in
    signature source — to be settled in this issue's design gate, with the
    reconciliation guard (Sub-issue 1) as the safety net during the transition.
- **Out:** Option A's separate build artifact unless the fallback-path analysis
  forces it; any change to non-mirror rows.
- **Acceptance criteria:**
  - The 6 hand-typed mirror rows are gone; mirror-symbol declares come from the
    prelude; `make compile` and `make check` green on both normal and
    fallback (`test`-command) paths.
  - Sub-issue 1's reconciliation either still holds (now trivially, no rows to
    drift) or is retired as redundant — decided in design.
- **Blocked by:** Sub-issue 1 (the guard proves the shapes agree before the
  rows are deleted). Picked up promptly once Sub-issue 1 lands — this is a safety
  ordering between two committed issues, not a deferral.
