# Design note — SFN-526: audit of the `[fatal]` lowering severity gate

- **Issue:** SFN-526 (`audit(lowering)`: find every lowering diagnostic discarded
  for lacking a `[fatal]` tag)
- **Related:** SFN-492 (unknown field access drops the enclosing expression),
  SFN-392 (struct literals silently zero-filled)
- **Author:** agent:Sailbot (orchestrator)
- **Status:** Draft (single-issue design gate; not a new SFEP)
- **Date:** 2026-07-25
- **Compiler audited:** `build/bin/sfn` 0.8.0, self-hosted from seed 0.8.0

---

## 1. The mechanism

`has_fatal_lowering_diagnostic` (`compiler/src/llvm/lowering/lowering_core.sfn:841`)
returns true iff some diagnostic string contains the literal substring
`[fatal]`. It is the only thing that turns a lowering diagnostic into a build
failure. Diagnostics travel as untyped `string[]` in
`LoweredLLVMLinesResult.diagnostics` (`compiler/src/llvm/types.sfn:128`) — no
code, no span, no severity field.

Five sites consult the gate:

| Site | Prints the cause? | Extra action |
|---|---|---|
| `lowering_core.sfn:742` | yes — every `[fatal]` line | deletes a stale `.ll` |
| `lowering_core.sfn:809` | yes | dry-run gate for `emit native` |
| `entrypoints.sfn:287` | yes | refuses before printing IR |
| `entrypoints.sfn:335` | **no** | returns `false` silently |
| `entrypoints_tests_writer.sfn:151` | **no** | returns `false` silently |

**There is no advisory channel.** An untagged diagnostic is not a warning — it
is a discard. The only path that ever surfaces one is
`entrypoints.sfn:316-328`, which prints `diagnostics[0]` (one entry, not the
list) and only when `lines.length == 0` — i.e. only when the build is already
failing for a different reason. On any successful build, every untagged
diagnostic is computed, collected, and dropped with no output.

Confirmed empirically — the SFN-492 repro emits three accurate diagnostics and
produces **zero** stderr output at exit 0.

### 1.1 Tag spellings in use

`[fatal]` is the only sentinel tag in the tree. Two spellings coexist, both
valid because the gate is a substring match:

- `llvm lowering [fatal] [E0806]: …` — `atomics.sfn`, `byte_load.sfn`
- `[fatal] llvm lowering: …` — `instructions_routine.sfn`, `core_operands.sfn`

Only two E-codes ever appear in `llvm/`: `E0806` (15 sites, all in
`atomics.sfn`/`byte_load.sfn`) and `E0817` (2, the enum-field conflict). Every
other tagged site carries no code at all, so the user gets a fatal build failure
with nothing to look up.

**On counts.** `grep '\[fatal\]'` over `compiler/src/llvm/` reports 45 hits and
`diagnostics.push`-family statements report 586, but neither is a site count:
tagged messages are built across multi-line string concatenations, and roughly
140 of the pushes are pure forwarding-loop copies (§6) rather than distinct
diagnostics. The enumerated distinct emission sites are ~26 tagged and ~150
untagged. Treat the enumeration in §3–§5 as authoritative and the greps as
navigation aids.

A third, harder-to-audit form exists: **conditional escalation**, where a
`"llvm lowering: "` prefix is swapped for `"llvm lowering [fatal]: "` only when
the underlying message matches a substring (usually `"ABI primitive mismatch"`)
or a specific type shape — `core_call_emission.sfn:64`,
`statement_assignment.sfn:487`, `core_literals_lowering.sfn:838` and `:1267`,
`core_concurrency_lowering.sfn:1408`. Grepping `\[fatal\]` does not find these
at the construction site.

---

## 2. Headline finding: severity is a property of the *consumption* site

The audit's premise was that untagged emission sites are the defect. That is
not where the wrong code comes from.

Nearly every leaf lowering failure does the same safe thing: it pushes a
diagnostic and returns `operand: null`. Whether that produces wrong code is
decided entirely by **what the consumer does with the null**, and consumers
fall into five behaviours:

| # | Consumer behaviour | Wrong code? | Example |
|---|---|---|---|
| 1 | **Fabricate** — substitute `default_return_literal` | **Yes** | `statement.sfn:609` emits `ret <default>` |
| 2 | **Skip** — drop the instruction/store/construct | **Yes** (lost side effect) | `instructions.sfn:659` drops the instruction |
| 3 | **Degrade** — pass the uncoerced/mismatched operand on | **Possibly** | `core_call_lowering.sfn:519-598` |
| 4 | **Propagate** — return `operand: null` upward | Only via 1–3 | most leaf sites |
| 5 | **Fail closed** — `[fatal]` | No | the ~26 tagged sites |

So the ~150 untagged leaf sites are not individually class (a) or (b). They are
*conditionally* dangerous, and which they are depends on the syntactic position
of the failing expression, not on the diagnostic.

**This changes the recommended fix.** Tagging 150 emission sites `[fatal]` is
both enormous and wrong-shaped. Making the small set of *fabricating and
skipping consumers* fail closed fixes the entire class at ~8 sites.

`default_return_literal` (`compiler/src/llvm/expressions_helpers.sfn:155` →
`0` / `0.0` / `false` / `null` / `zeroinitializer`) is the fabrication
primitive. **Both SFN-492 and SFN-392 bottom out in it.** They are one root,
not two mechanisms — SFN-392's note that its diagnostic "never surfaces at all"
is not a second mechanism, it is the general rule from §1.

### 2.1 Reproduction of the two behaviours

```sfn
struct T { a: i32; }
fn in_return(t: T) -> i32 { return t.nope; }
fn in_assign(t: T) -> i32 { let mut x: i32 = 41; x = t.nope; return x; }
```

`sfn check` reports `ok`; `sfn emit llvm` exits 0 with no stderr.

```llvm
define i32 @in_return__fab(%T* %t) {
block.entry:
  ret i32 0                      ; fabricated (behaviour 1)
}
define i32 @in_assign__fab(%T* %t) {
block.entry:
  %l0 = alloca i32
  store i32 41, i32* %l0
  %t0 = load i32, i32* %l0       ; assignment skipped (behaviour 2) — returns stale 41
  ret i32 %t0
}
```

---

## 3. Class (a) — masks wrong code

Grouped by the consumer that produces the defect. Each row is a filed issue
(§6).

### A1 — Fabricating consumers

| Site | Function | On failure |
|---|---|---|
| `expression_lowering/native/statement.sfn:494-499` | `lower_return_instruction` | empty return expr → `ret <default>` |
| `.../statement.sfn:594-609` | `lower_return_instruction` | `lowered.operand == null` → `ret <default>` |
| `.../statement.sfn:678-697` | `lower_return_instruction` | coercion failed → `ret <default>` |
| `.../statement.sfn:229-253` | `lower_expression_statement` | coercion failed → `store <default>` into the local |
| `lowering/instructions_let.sfn:730-739` | `lower_let_instruction` | uncoercible initializer → `store <default>` |
| `lowering/emission.sfn:636-637` | `emit_llvm_function` | body falls off the end → `ret <default>` |

`instructions_let.sfn:730` is the sharpest single site outside `statement.sfn`:
a genuinely uncoercible initializer is silently replaced with `0`/`false`/`null`
in the binary, gated by nothing.

### A2 — Skipping consumers

| Site | Function | On failure |
|---|---|---|
| `lowering/instructions.sfn:532` | `lower_instruction_range` | `break` outside loop → instruction becomes a no-op |
| `lowering/instructions.sfn:584` | `lower_instruction_range` | `continue` outside loop → no-op |
| `lowering/instructions.sfn:659` | `lower_instruction_range` | unsupported instruction tag → dropped, zero IR |
| `.../statement.sfn:229-243` | `lower_expression_statement` | failed lower → store skipped, assignment vanishes |

`instructions.sfn:659` is a generic catch-all: any instruction the lowerer does
not recognise is silently omitted from the function body.

### A3 — Gate integrity (the gate itself can lose a `[fatal]`)

| Site | Problem |
|---|---|
| `lowering_phase_sanitize.sfn:89-96` (`sanitize_diagnostics`, called at `lowering_core.sfn:881`) | if the inbound array exceeds 1,000,000 entries the **whole array is replaced with `[]`** — including any `[fatal]` |
| `lowering_io.sfn:44-59` (`extend_string_lines_checked`, used at `lowering_core.sfn:945, 971, 1048, 1272`) | an oversized batch is replaced by one generic "skipped oversized" line, discarding every individual message including `[fatal]` |
| `entrypoints.sfn:335`, `entrypoints_tests_writer.sfn:151` | refuse the build without printing *why* |

The thresholds are impractical to reach, but there is no "keep any `[fatal]`"
carve-out, and the two silent gate sites make a fatal failure indistinguishable
from an ordinary one at the CLI.

### A4 — Wrong symbol bound

`lowering_helpers_mangling.sfn:290` — when an import's alias collides with a
locally-defined function symbol, the import is `continue`d out of the mangling
rewrite table. Call sites that meant the **import** silently keep resolving to
the **local** definition. Untagged.

`lowering_helpers_mangling.sfn:137` drops the entire import list past a size
guard, stopping cross-module call-site rewriting altogether.

### A5 — Lowering continues past a failed runtime-call dispatch

`expression_lowering/arrays.sfn:156, 195, 237, 274` — `lower_struct_array_concat`
forwards each `emit_runtime_call` result's diagnostics but **never checks the
operand**. It keeps compositing bitcast/GEP/store IR on top of a possibly-failed
`alloc_struct` / `copy_bytes` dispatch. (`emit_runtime_call` can itself emit
`[fatal]`, so the build is often saved — but only by luck of that sub-call's
own tagging, not by anything in `arrays.sfn`.)

### A6 — `.sfn-asm` layout parse failures truncate layouts

`native_ir_utils_layout.sfn` — ~60 push sites, **zero** tagged. Its diagnostics
reach the same untagged channel via `native_ir_parser_defs.sfn` →
`ParseNativeResult.diagnostics` → `lowering_core.sfn:943-945`. On a malformed
`.layout` line the caller silently drops the offending field/variant/payload
from the constructed layout (`native_ir_parser_defs.sfn:408-409` only pushes on
`success`), or emits the struct with `layout: null`. A truncated layout yields
a struct with fewer fields than the source declares, and the build succeeds.

### A7 — Zero stride compiles an infinite loop

`instructions_for_range.sfn:269` — a literal stride normalising to `0.0` pushes
an untagged diagnostic and **does not return early**; lowering proceeds to build
the loop with the zero stride. A guaranteed infinite loop is compiled as-is.

Related shape at `instructions_for_range.sfn` generally: `lower_for_range`
returns `null` on failure, and `instructions_for.sfn:436` then falls through to
the **array-based** `.for` path — so a broken numeric range is silently
reinterpreted as an array iteration rather than failing.

---

## 4. Class (b) — genuinely advisory, correct to continue

These are untagged and should stay untagged.

| Site | Why continuing is correct |
|---|---|
| `runtime_call.sfn:209` | falls back to the **original uncoerced operand** — a real value, not a fabrication; degraded but not invented |
| `core_call_lowering.sfn:396, 411` | non-terminal; the arity backstop at `:436` fail-closes on the resulting drift |
| `core_concurrency_lowering.sfn:1410` (non-`double` await) | deliberate accepted gap for the still-untyped `i8*`/ptr await path, documented in-source (#829); the `double` shape *is* escalated |
| `lowering_core.sfn:329` | informational: test module defines its own `main`, harness skipped |
| `emission.sfn:249` | parameter missing a type annotation defaults to `i8*` — pre-existing ABI policy, not a lowering failure |
| `statement_suspension.sfn:128, 150` | suspension-conflict notes; borrows are documented "Parsed only" (`docs/status.md:529`) |
| `core_ownership.sfn:74, 102` | use-after-move — **enforcement lives elsewhere**: `ownership_checker.sfn`, wired fail-closed at `main.sfn:145, 326, 382, 413`, raising `E0901`/`E0904`. These lowering copies are vestigial detectors, not the gate. |
| `lifetime.sfn:608-639` (`detect_borrow_conflicts`) | borrow exclusivity is documented unimplemented (`docs/status.md:529`, "Exclusivity not checked") |

The last two matter: read in isolation they look like severe unenforced
memory-safety checks. They are not. Enforcement either lives in a different
pass, or the feature is documented as not yet shipped. Tagging them `[fatal]`
would fail-close a check the language does not yet claim to make.

---

## 5. Class (c) — dead

| Site | Status |
|---|---|
| `typed_ssa_verify.sfn:891` (`verify_module`) | zero production callers; **deliberate and documented** (`typed_ssa.sfn:12`, SFN-454) — checked and self-hostable but not yet selected. Unit tests call it directly. |
| `lifetime.sfn:796` (`validate_borrow_lifetimes`) | zero callers anywhere; defined and re-exported (`llvm/mod.sfn:198`) but never invoked. Undocumented, unlike the above. Cleanup candidate; not filed, since borrow lifetimes are documented unimplemented. |
| `type_context.sfn:143, 160, 163` (`fixup_enum_layouts`) | bypassed in the live pipeline; `lowering_phase_types.sfn:84-88` documents why (seed's struct-returning cross-module ABI segfaults). Test-only. |
| `atomics.sfn:101-104` | fallthrough for an unknown atomic builtin; every name is wired, so unreachable today. Correctly `[fatal]` anyway. |

**`lowering_recovery.sfn` emits no diagnostics at all.** It re-derives
functions/imports/structs/enums by text-scanning when the structured parse looks
corrupt, and every decision point is behind a `debug_lowering` stderr trace. A
caller cannot tell from `diagnostics` whether the primary parse succeeded or the
compiler quietly fell back to recovery — including when recovery itself fails
and returns `[]` (`recover_functions_for_lowering:878`). Not a discarded
diagnostic; a *missing* one. Recorded here because the audit's question ("where
does the compiler know something is wrong and ship anyway?") has an answer here
that a diagnostics census structurally cannot find.

---

## 6. Historical precedent — this bug class is proven, not hypothetical

The compiler's own source records two prior instances where a branch of
`lower_instruction_range` failed to forward a sub-lowering's diagnostics, so a
`[fatal]` was swallowed and the build exited 0 with a call's side effect
dropped:

- `instructions.sfn:311-316` (#631) — the expression-statement branch.
- `instructions.sfn:336-341` (#1954) — the `return` branch.

Both were fixed by threading the diagnostics forward. Notably, **the fix each
time was "forward the diagnostic", never "make the sub-call fail closed"** —
which is precisely how the fabricating consumers in §3 A1 survived.

There are ~140 such forwarding sites. A missing forward at any of them
reproduces #631/#1954 exactly, and nothing tests for it.

---

## 7. The `[fatal]` contract

Documented at the definition site (`lowering_core.sfn`, above
`has_fatal_lowering_diagnostic`) by this issue. In summary:

1. `[fatal]` anywhere in a diagnostic string fails the build. There is no other
   severity, and no advisory channel — untagged means **discarded**.
2. Tag when reaching the diagnostic implies the emitted IR is wrong. Do not tag
   a condition the language does not yet claim to enforce.
3. **Tag at the site that fabricates or drops IR, not at the site that detects
   the problem.** A leaf returning `operand: null` is safe; a consumer
   substituting `default_return_literal` for it is not.
4. Prefer `llvm lowering [fatal] [E0xxx]: …` (the `atomics.sfn` form) and
   allocate an E-code.
5. Every intermediate frame must forward sub-result diagnostics (#631, #1954).

---

## 8. Filed follow-up issues

| Finding | Issue |
|---|---|
| A1 fabricating consumers | SFN-527 |
| A2 skipping consumers | SFN-528 |
| A3 gate integrity | SFN-529 |
| A4 import-shadow mangling | SFN-530 |
| A5 `arrays.sfn` unchecked dispatch | SFN-531 |
| A6 layout-parse truncation | SFN-532 |
| A7 zero-stride infinite loop | SFN-533 |

SFN-492 and SFN-392 are the two already-tracked instances of A1 and remain
valid as written; A1 is their shared generalization.

## 9. Verification

```
build/bin/sfn test compiler/tests/unit/     # pass
make compile                                # self-hosts
sfn fmt --check compiler/src/llvm/lowering/lowering_core.sfn
```

This note and the contract comment change no behaviour.
