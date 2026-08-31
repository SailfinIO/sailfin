# SFN-1161 — cross-module function values in struct fields

Single-issue implementation design gate. Not an SFEP: SFEP-0030 (first-class
function values) and SFEP-0074 (`sfn dev` verb registration) already own the
surrounding design, and this note only records how one bug fix took its shape,
which `.claude/rules/proposals.md` puts below the SFEP bar (the "single-issue
design gate" genre → `design-notes/`).

Issue: `SFN-1161` — "function-as-value is rejected (E0808) when the target
struct type is imported" (type:bug, area:compiler, High, 3 points).

**Verified empirically.** Unlike the `sfn-1006` precedent, a self-hosted
`build/bin/sfn` was available throughout. Every claim below was run, on both
seed 0.10.6 and the compiler built from `main` at `b2c3a18`.

---

## 0. Executive summary — the four decisions

| Ask | Decision |
|---|---|
| **A. How imported struct declarations reach typecheck** | **A separate `imported_structs` channel — never a widened `ctx.declarations`.** The data is already parsed and discarded (§1.2), so this is a plumbing extension of an existing pass, not a new pass. Widening `ctx.declarations` instead would light up three latent fail-open diagnostics across the compiler (§3). This is the single most important constraint in the change. |
| **B. Imported *functions* as values** | **Stays rejected, with a new `E0843` that names the real restriction.** SFN-1161's acceptance criteria permit either outcome; making it typecheck would mean changing a positionally-indexed struct and rewriting a fail-closed guard on a PR whose output becomes a seed, with no consumer asking for it (§4). |
| **C. Facet 3 — `E0840` on named-struct parameters** | **Bundled, though the issue does not mention it.** Without it the seed does not unblock the bare-name registry form and SFN-1173 cuts twice; `.claude/rules/seed-dependency.md` says cross an unavoidable gate once with the complete family (§5). Relaxation is narrow: parameters only, named structs only. |
| **D. Is SFN-1161 actually a blocker?** | **No — and this is worth recording.** The lambda form already compiles and runs end-to-end cross-module today (§2). SFN-1161 → SFN-1173 → SFN-1159 is a convenience chain, not a hard gate. |

---

## 1. Current state

### 1.1 The two reported facets

Both reproduce identically on seed 0.10.6 and on the compiler built from `main`.

| Facet | Shape | Verdict |
|---|---|---|
| 1 | imported struct type, **local** function: `Entry { run: local_one }` | `E0808` |
| — | identical **local** struct, same function: `LocalEntry { run: local_one }` | passes |
| 2 | **local** struct type, **imported** function: `LocalEntry { run: imported_one }` | `E0808` |
| — | same, via a local forwarding wrapper | passes |

**Facet 1's chain.** `_struct_field_expected_type`
(`compiler/capsules/analyzer/src/typecheck/expression_walk.sfn:668-690`) linear-scans
`ctx.declarations` for a matching `StructDeclaration`. `ctx.declarations` is
populated at exactly one site — `compiler/capsules/analyzer/src/typecheck/statement_checks.sfn:79`,
with `program.statements`, this module's own AST. Imported struct declarations
are never merged. The field's expected type resolves `null`, so the `Identifier`
arm's expected-type gates (`expression_walk.sfn:561,582`) never fire and the bare
name falls through to `make_fn_value_position_diagnostic`
(`expression_walk.sfn:590`, defined at
`compiler/capsules/analyzer/src/typecheck_types/symbol_table_and_raw_exprs.sfn:370-382`).

Interfaces already do get merged across modules —
`local_interfaces.concat(_filter_interface_declarations(imported_interfaces))` at
`compiler/capsules/analyzer/src/typecheck/mod.sfn:151-153` — but
`typecheck_diagnostics_full` has no `imported_structs` parameter at all, so there
is no channel for structs to arrive through.

**Facet 2's chain.** `_collect_imported_call_symbols`
(`compiler/capsules/analyzer/src/typecheck/symbols.sfn:221-247`) registers imported
names with `kind: "import"` and every signature field blank. The gate at
`expression_walk.sfn:564-569` then fail-closes on `kind == "import"`/`"prelude"`
unconditionally once an expected fn-type is present — before
`check_named_fn_value_compatibility`
(`compiler/capsules/analyzer/src/typecheck_types/named_fn_values.sfn:18`) can run.
The fail-close is correct in substance (the import table genuinely carries no
parameter types) but its diagnostic is not.

### 1.2 The data facet 1 needs is already parsed, then dropped

`interfaces_from_native_artifact` (`compiler/src/typecheck_import_loader.sfn:107-149`)
calls `parse_native_artifact_for_import_context(text)`, whose `ParseNativeResult`
(`compiler/capsules/ir/src/native_ir.sfn:322-330`) **already carries
`structs: NativeStruct[]`** with fields fully parsed. It is discarded.

The `.sfn-asm` round-trip preserves what matters: `.field <name>: <type text>` is
emitted verbatim (`compiler/capsules/codegen/src/emit_native_format.sfn:632-637`)
and parsed by splitting on the *first* `": "`
(`compiler/capsules/ir/src/native_ir_utils_parse.sfn:595-625`), so
`run: fn(int) -> int ![clock, io, net]` survives intact, effect row included.

Two fidelity gaps follow from the artifact format, and both shape the design:

- **`NativeStruct` has no `type_parameters`** (`native_ir.sfn:153-159`);
  `parse_struct_header` (`native_ir_utils_parse.sfn:297-309`) parses only
  `implements`, though `emit_struct` does write `format_type_parameters`
  (`emit_native.sfn:601`). An imported generic struct reconstructs with
  `type_parameters: []`.
- **`NativeStruct.methods` carry no bodies**, so a reconstructed declaration must
  carry `methods: []`.

Reusing codegen's equivalent collection (`compiler/capsules/codegen-llvm/src/lowering/lowering_phase_imports.sfn:143-222`)
is not an option: `codegen-llvm` sits downstream of `analyzer`, so consuming it
analyzer-side inverts the dependency. Nothing needs lifting — the analyzer-side
loader holds the identical `ParseNativeResult` already.

---

## 2. The finding that reframes the issue: the lambda form works

The `fn (…) => …` lambda literal never reaches the `Identifier` arm, so it
bypasses the named-fn-value gate entirely. The exact registry shape SFEP-0074
§2.2 describes — imported struct type, fn-typed field, forwarding lambda,
cross-module dispatch through the field — **compiles and runs today**:

```
// verb_ty.sfn
struct Verb { name: string; run: fn(Ctx, string[]) -> int ![clock, io, net]; }

// shard.sfn
fn shard_verb() -> Verb ![io] {
    return Verb { name: "shard",
        run: fn (c: Ctx, args: string[]) -> int ![clock, io, net] => shard_run(c, args) };
}

// main.sfn
let v: Verb = shard_verb();
let rc = v.run(c, no_args);   // prints "shard ran" / "done", exits clean
```

This satisfies SFEP-0074's "one new file plus one registration line" goal,
because the lambda lives in the verb's own module. It costs a restated parameter
list, and the factory must declare the callee's effect row — the lambda body's
effects are attributed to the enclosing function, so a narrower row on
`shard_verb` raises `E0400`.

**Consequence, recorded so it is not rediscovered:** SFN-1161 is not a hard
blocker for SFN-1159. The serialization through SFN-1173's seed cut buys the
nicer bare-name spelling, not the capability.

---

## 3. Facet 1 — a separate channel, not a widened `ctx.declarations`

`ctx.declarations` has three other consumers, and every one is a **fail-open**
check whose silence today depends on imported structs being absent:

| Consumer | What widening would do |
|---|---|
| `unknown_field_diagnostics` → `_find_struct_declaration` (`typecheck/field_access.sfn:21-31,83`) | `E0015` returns `[]` for imported structs today ("Not declared in this program — unproven"). Widening turns it on tree-wide — and it would **false-positive on every imported-struct method call**, because reconstructed declarations necessarily carry `methods: []` (§1.2), so `_struct_declares_method` always returns false. |
| `_array_element_class` (`typecheck/array_element_rules.sfn:65`) | Newly proves imported element classes → new `E0310`. |
| `_struct_field_annotation_text` (`typecheck/array_element_rules.sfn:104`) | Same. |

Widening on a seed PR would light up three latent diagnostics across ~60k lines
of compiler source, discovered only at bootstrap. So: `TypeckCtx` gains a
distinct `imported_structs` field, consulted by exactly one lookup, and
`ctx.declarations` is untouched.

Imported structs are also deliberately **not** merged into `local_structs`
(`typecheck/mod.sfn:163`), which feeds `_generic_struct_names` and
`check_generic_instantiation_sites` — the owners of `E0833`.

### 3.1 The one-word decision that keeps this safe

`ctx.expected_type` is read at exactly two places: `_array_element_expected_type`
(`expression_walk.sfn:248`) and the fn-value gate (`expression_walk.sfn:561,582-585`).
Everything else clears it. So routing the imported annotation **only** into
`ctx_with_expected_type` provably cannot emit any new diagnostic except through
the fn-value gate — which is the fix.

`check_array_element_type` therefore keeps receiving `local_expected`, not the
merged value. Passing the imported annotation there would open `E0310`, and
because imported generic structs lose their type parameters (§1.2), the
`is_generic_struct` guard could not suppress an unsubstituted `T[]` field on an
imported `Box<T>`.

### 3.2 Resolution semantics

- **Collisions:** local wins by construction — the imported list is consulted
  only on a local miss. Matches how interfaces resolve (`mod.sfn:153` concatenates
  locals first; lookups take the first match).
- **Aliased imports** (`import { Entry as E }`): not handled. `E { … }` finds
  nothing and yields today's `E0808` — a strict non-regression. Matching the alias
  needs the specifier map that `_collect_imported_call_symbols` already builds for
  *call* names; deliberately out of scope here.
- **Re-exports:** work already. The loader merges structs from every staged
  artifact in the closure with no per-module export filter — the same
  global-by-name resolution documented at `typecheck_import_loader.sfn:600-616`.
- **Perf:** no index. The imported scan runs only on a local miss, and the parse
  cost is already paid unconditionally. If `sfn check` over the full compiler
  regresses measurably, the cheap follow-up is to convert only structs declaring
  at least one `fn(`-typed field — a filter that exactly matches the consumer.

---

## 4. Facet 2 — `E0843`, not resolution

Rejected alternative: enrich `ImportedFunctionSignature`
(`compiler/capsules/analyzer/src/effect_imports.sfn:45-90`) with parameter types,
async-ness and generic-ness so `check_named_fn_value_compatibility` can run.

Three reasons it loses:

1. **No consumer needs it.** SFEP-0074's registry has each verb module supplying
   its own module-local `run`; the six delegated verbs at
   `compiler/src/cli/commands/dev.sfn:1465-1501` are each `<verb>_run(matches, ctx)`
   defined in their own module, so the local-row form is natural rather than a
   workaround.
2. **Wrong risk profile for a seed PR.** It changes a struct the seed indexes
   positionally, changes a signature with four call sites, and rewrites a
   fail-closed guard — on a PR whose output becomes the binary every later build
   depends on. It would also make `"import"` entries start driving
   `_call_argument_expected_type` (`expression_walk.sfn:621-640`) tree-wide, since
   that reads `function_parameter_types` for function-kind entries.
3. **The acceptance criterion permits the alternative verbatim** — "or is
   rejected with a diagnostic that names the real restriction rather than the
   C-ABI advice."

`E0843` (verified unused tree-wide, as are `E0844`–`E0849`) replaces
`make_fn_value_position_diagnostic` on the `kind == "import"`/`"prelude"` branch
only, naming the restriction and the escape hatch: the import table carries
effects and arity but not parameter types, async-ness or generic-ness, so wrap
the callee in a module-local function or a `fn (...) => <name>(...)` lambda.

**Consequence for SFN-1173:** unchanged. It still cuts and pins exactly one
seed, carrying facets 1 and 3. Facet 2a becomes a separate future issue with its
own gate — and only if a consumer ever materializes.

---

## 5. Facet 3 — relax `E0840` for named-struct *parameters*

Not described in SFN-1161; found while checking whether facets 1+2 would actually
unblock the consumer. With an **entirely module-local** struct and function — no
imports anywhere:

```
error[E0840]: function value `shard_run` has non-pointer-width aggregate parameter
              type `Ctx`; aggregate function-value signatures require monomorphized
              ABI support
```

`_fn_value_type_is_pointer_width` (`named_fn_values.sfn:116-127`) allowlists only
extern primitives, `number`/`boolean`/`ptr`, and `*`-prefixed types; every named
user type falls through to `false`. The gate is **stale relative to the 0.5.8+
boxed-struct ABI**: `map_return_type`
(`compiler/capsules/codegen-llvm/src/type_mapping.sfn:741-748`) maps a user struct
to `%T*` — genuinely pointer-width.

Without this, a seed carrying facets 1+2 still rejects
`DevVerb { run: shard_run }`, so SFN-1173 would cut twice.
`.claude/rules/seed-dependency.md`: cross an unavoidable gate once, with the
complete capability family.

**Scope — deliberately narrow:**

- **Parameters only, not returns.** A user struct is `%T*` in both
  `_compute_function_pointer_type`
  (`compiler/capsules/codegen-llvm/src/expression_lowering/native/core_closure_lowering.sfn:334-349`)
  and the real `define`, so an adapter's forwarded parameter types match the
  callee's by construction. Returns are `%T*` today too, but
  `core_expression_tail.sfn:326-331` explicitly warns that
  `_compute_function_pointer_type` can diverge from the real `define` ABI for
  struct-returning functions (sret adjustments it does not model). Relaxing
  returns needs an sret audit; it is a follow-up.
- **Named structs only — never `string`.** `string` maps to `{i8*, i64}`
  (`type_mapping.sfn:690-693`), a real two-eightbyte aggregate. `E0840` is correct
  there and SFEP-0030 §3's "Gated" verdict stands.
- The struct-name set is built from actual `StructDeclaration`s only, never from
  `known_types`, which mixes in interfaces (`{i8*, i8*}`) that must stay rejected.

Facet 1's channel supplies the imported half of that name set for free — `Matches`
comes from `sfn/cli` and `CliContext` from `compiler/src/cli/context.sfn`, both
imported into the `dev_*` modules.

---

## 6. Effect-row subsumption — unaffected

`_fn_value_effect_is_covered` (`named_fn_values.sfn:104-113`) calls
`effect_subsumes` (`compiler/capsules/analyzer/src/effect_taxonomy.sfn:96-101`),
driven off `entry.function_effects` against the row parsed from the field
annotation by `parse_fn_type_text`
(`compiler/capsules/ir/src/native_ir_utils_text.sfn:105`). It only ever sees two
strings, so it is indifferent to where the struct is declared. Once facet 1 makes
`ctx.expected_type` non-null, the imported path lands in the *identical*
`check_named_fn_value_compatibility` call and inherits local behaviour: `![io]`
into `![clock, io, net]` accepted, the reverse `E0839`. Pinned by the existing
tests at `compiler/tests/unit/fn_reference_typecheck_test.sfn:225-236`.

---

## 7. What an implementer must confirm

| Claim | Cheapest confirmation |
|---|---|
| The plumbing changes nothing on its own | The facet-1 repro still emits `E0808` after steps 1-3 |
| Facet 1's lookup fixes the imported-struct case | `sfn check` on the two-file repro → clean |
| Facet 3 is independent of imports | `sfn check` on the all-local struct-parameter fixture → clean |
| Cross-module dispatch works at runtime, not just at `check` | The `cross_module_fn_field_dispatch` e2e — **build and run**, per acceptance criterion 3 |
| `E0843` replaced the C-ABI advice | e2e asserts stderr contains `E0843` and **not** `as * u8` |
| No latent diagnostic was woken | `sfn dev clean build` then `sfn dev verify` — mandatory here, this is a seed PR |

---

## 8. Reconciliation carried by this change

- `docs/proposals/0030-first-class-function-values.md` §3 — the `fn(Point) -> Point`
  row is listed wholesale as gated; after facet 3 the *parameter* half is
  supported under the boxed-struct ABI and only the return half remains gated.
- `capsules/sfn/test/src/expect.sfn` and
  `capsules/sfn/test/tests/lifecycle_test.sfn` — both state "a thunk cannot be
  stored in a struct field and called". That is **wrong today**, not merely
  stale: SFN-674 shipped it, `compiler/tests/e2e/fn_field_dispatch_test.sfn`
  proves it, and a direct check confirms the local case type-checks clean. They
  are corrected to name the real cross-module restriction.
- `docs/style-guide.md` — `E0843` row in the `E08xx` range.

`docs/status.md` is deliberately **not** touched: per `CLAUDE.md` it is
reconciled on the release cadence by `/status-sweep`, never in a feature PR.
