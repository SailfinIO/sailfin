---
sfep: TBD
title: Import-surface compaction across the phase rewind to cut emit peak RSS
status: Draft
type: runtime
created: 2026-07-17
updated: 2026-07-17
author: "agent:compiler-architect; agent:seed-stabilizer verification; human review"
tracking: SFN-382; supersedes SFN-94
supersedes:
superseded-by:
graduates-to:
---

# SFEP-XXXX — Import-surface compaction across the phase rewind to cut emit peak RSS

> Draft — claims `max + 1` (SFEP-0049) and an Index row when it merges. Design
> record preserved from the shelved SFN-94 investigation so it survives the
> ephemeral session container. Implementing issue: **SFN-382**. Supersedes the
> original **SFN-94** mechanism (canceled).

## 1. Summary

A per-module emit subprocess must not let the full `.sfn-asm` texts of its
direct imports co-reside with the LLVM lowering peak. This SFEP compacts the
imported native texts to a single flat blob — every structural line kept,
`.fn` instruction bodies dropped — **before** the SFEP-0043 phase rewind,
relocates that one blob across the rewind with the existing
`relocate_string_to_heap` primitive, and lowers from the compact surface. The
rewind then reclaims the full import texts alongside the AST/typecheck/emit
arena, so they never contribute to the high-water mark. Emitted `.ll` stays
byte-identical for every module. No new runtime primitive, no seed cut.

## 2. Motivation

SFN-94 asked a per-module emit subprocess to stop holding full direct-import
`.sfn-asm` texts resident through lowering, graded on `make bench` peak RSS
(≥10% drop on ≥2 heavy modules). Two facts — both verified against source and
confirmed empirically in prior sessions — mean SFN-94's *in-scope* approaches
cannot clear that bar:

1. **The bump arena never frees on reference-drop.** `sfn_mem_free` is a hard
   no-op while the arena is enabled (`runtime/sfn/memory/mem.sfn:185-187`), and
   the arena is the sole allocator. Peak RSS = arena high-water mark = every
   byte allocated since the last `rewind`. So SFN-94 approach (a) "stop
   accumulating the `native_texts` array" and (b) "free the parse tree" are
   **no-ops for peak RSS** — dropping a reference or calling `free` never
   retracts the bump pointer. Only a `rewind` reclaims.

2. **The redundant-load fix is inert on the benched path.** A redundant-load
   elimination targeting the `-p` double read (`main.sfn` reload +
   `lowering_core.sfn:446` re-read) measured **0% RSS change** across all 203
   modules in the prototype (`capsule_resolver` +0.3%, `cli__commands__test`
   +0.2%, `native__core` +0.0%; zero modules moved ≥5% either way). It
   self-hosts and is byte-identical, but reducing a *transient* second read
   cannot lower the high-water mark that the arena never gives back.

   > Note on the benchmark: an earlier investigation recorded that `make bench`
   > ran `sfn emit llvm` with **no** `--import-context`, routing through the
   > context-free writers. That is now stale — the current bench target passes
   > `--import-context build/compiler/import-context` (`Makefile:498`), so it
   > exercises the import-context path this SFEP targets. The arena high-water
   > argument above is the load-bearing reason regardless.

The only mechanism that lowers the high-water mark is to reclaim the import
texts at the phase rewind. That requires reaching the `main.sfn` SFEP-0043
rewind bracket — a semantic unit outside SFN-94's `In:` scope — plus two pure
helpers, which is why it is a distinct, larger design rather than an in-place
SFN-94 tweak.

Post-#1816 Linux x86_64 baselines (broad-closure modules): `capsule_resolver`,
`cli__commands__test`, `llvm__…__native__core` are the targets.

## 3. Design

### 3.1 The compact surface: a flat `.sfn-asm` blob with `.fn` bodies stripped

Both lowering consumers already read `.sfn-asm` **text**:

* `gather_imported_module_symbols` parses via
  `parse_native_artifact_for_import_with_bindings` with
  `(include_instructions=false, include_top_level_bindings=true)` — it
  **already skips** `.fn` instruction bodies.
* `apply_module_symbol_mangling` runs raw scans:
  `extract_module_name_from_native_text` (first `.module ` directive,
  `lowering_helpers.sfn:331-359`) and `_collect_struct_method_symbols`
  (`.struct`/`.method`/`.endstruct` triples,
  `lowering_helpers_mangling.sfn:60-126`).

The union of lines either consumer reads: `.module`,
`.struct`/`.field`/`.method`/`.endstruct`, `.enum`/variants, `.interface`,
`.fn` **headers** with their `.endfn` delimiter, `.let`/`.extern-var`
bindings, `.import`/`.export`. The **only** dead lines are the instruction
lines strictly between a `.fn` header and its `.endfn` — the bulk of every
non-trivial module.

**Compaction** = drop exactly those in-body lines, keep both delimiters.
Concatenate per-import compact texts with a reserved separator (an `\x1e`
record separator or a sentinel `.import-blob-sep` line), preserving import
order so the manifest-by-index association (`lowering_phase_imports.sfn:133`)
is unchanged.

### 3.2 Where compaction, relocation, and rewind happen

Fold import loading into the **existing** SFEP-0043 bracket in
`compile_to_llvm_file_with_module_imports` (`main.sfn`, ~L680). Today it loads
imports pre-rewind for the effect table and re-loads them post-rewind. The
redesign loads once, compacts pre-rewind, and relocates the compact blob
alongside the module's own native text across the rewind:

```sfn
let mark = sfn_arena_sfn_mark();                     // before parse (unchanged)
// … parse, typecheck, effects, ownership, emit … (unchanged) …
let import_blob      = compact_import_surface(loaded.native_texts);   // NEW: one flat string
let heap_module_text = relocate_string_to_heap(lines_to_native_text(native_lines));
let heap_import_blob = relocate_string_to_heap(import_blob);          // existing primitive
sfn_arena_sfn_rewind(mark);      // reclaims AST + typecheck + emit + FULL import texts
let compact_texts = split_import_surface(heap_import_blob);           // NEW: re-split (small now)
let ok = write_llvm_ir_from_native_text_with_context(
    heap_module_text, module_name, out_path, compact_texts);
free_heap_string(heap_module_text);
free_heap_string(heap_import_blob);
return ok;
```

Two flat heap survivors (by-value `{data,len}` scalars). What SFEP-0043 §6
forbids is relocating an arena `string[]` **spine** (use-after-free →
SIGABRT); that is avoided by concatenating to one blob and re-splitting
**after** the rewind.

### 3.3 Draining the second, in-lowering full-text load (the harder half)

`collect_imported_module_context_for_module` (`lowering_core.sfn:446`) also
loads full depth-0 texts, **inside** lowering (post-rewind, under the peak).
Its outputs are layout manifests (from `.layout-manifest` sidecars — already
compact, keep) and `native_texts` for the embedded-import union. Preferred
fix: route the compact blob as the sole depth-0 text source, so `collect_*`
contributes manifests only. The staged `import_asm_paths` already includes
every direct import (incl. the #984 walk-excluded `-p` entry), so the compact
blob is a superset of the embedded-import scan. **This must validate that
#999 cross-module signature resolution is preserved.** Documented fallback:
compact-before-return inside `collect_*` (a partial win that may miss the ≥10%
bar — report rather than expand scope if so).

### 3.4 Consumer migration

* `gather_imported_module_symbols` — **no change** (already
  `include_instructions=false`).
* `apply_module_symbol_mangling` raw scans — no scanner change; byte-identity
  hinges on: `.module` stays the first directive (non-line-anchored `index_of`
  safe), and `.struct`/`.method`/`.endstruct` are all preserved by compaction.

## 4. Effect & capability impact

None. No new frontend capability, no effect-system change, no new user-facing
surface. The two new helpers are `![pure]` string transforms.

## 5. Self-hosting impact

Source-only, **no seed cut** — `relocate_string_to_heap` is already in the
pinned seed. Passes touched: `main.sfn` (the rewind bracket),
`lowering_core.sfn`, `imports.sfn`, plus two pure helpers. Every module's
`.ll` must be **byte-identical** — the same gate SFEP-0043 met — and
`make compile` self-hosts the changed compiler in one pass.

## 6. Alternatives considered

* **SFN-94 approaches (a)/(b) — drop the `native_texts` array / free the parse
  tree.** Rejected: no-ops for peak RSS under the bump arena (§2.1). Verified
  empirically at 0% RSS movement.
* **Redundant-load elimination on the `-p` path.** Rejected as insufficient:
  removes a transient second read, not the high-water mark; measured 0%.
* **A new precompiled on-disk "interface file" format.** Out of scope — larger
  surface, changes on-disk artifacts, and unnecessary: the in-memory compact
  blob achieves the residency win without a format change. A possible future
  direction, not this SFEP.
* **A runtime `mark`/`rewind` window around each import load.** Rejected: data
  extracted inside a mark/rewind window does not survive the rewind, so the
  kept surface would have to be copied out anyway — which is exactly the
  compact-blob relocation this SFEP does, at whole-closure granularity.

## 7. Stage1 readiness mapping

This is a residency/lowering optimization, not a language feature — the
readiness bar is byte-identity + self-host + bench, not new syntax.

- [x] Parses — no new syntax.
- [x] Type-checks / effect-checks — no new surface; helpers are `![pure]`.
- [ ] Emits valid `.sfn-asm` — unchanged emitter; `.ll` byte-identity gate.
- [ ] Lowers to LLVM IR — byte-identical output for every module.
- [ ] Regression coverage — see §8.
- [ ] Self-hosts — `make compile`.
- [ ] `sfn fmt --check` clean.
- [ ] Documented — `docs/status.md` build-perf / RSS row + this SFEP flips to
  `Implemented` on ship.

## 8. Test plan

1. `make compile` self-hosts.
2. Byte-identical `.ll` gate — extend `arena_phase_rewind_ll_identity_test.sfn`
   to diff compaction ON vs OFF behind `SAILFIN_IMPORT_SURFACE_COMPACT`.
3. New unit `import_surface_compaction_test.sfn` — fixture with a `.fn` body
   containing lines that *look* like directives; assert compaction drops
   exactly the in-body instructions, round-trips through
   `split_import_surface`, and both consumers
   (`gather_imported_module_symbols`, the mangling raw scans) return identical
   results on full vs compact text.
4. Existing cross-module gates stay green:
   `cross_module_signature_resolution_test.sfn`,
   `inline_export_cross_module_test.sfn`,
   `emit_llvm_unresolved_callee_exit_test.sfn`.
5. `make check`.
6. `make bench` — ≥10% peak-RSS drop on ≥2 heavy modules, no >5% regression;
   before/after table in the PR.

## 9. References

* Implementing issue: **SFN-382**. Supersedes **SFN-94** (canceled).
* SFEP-0043 (`docs/proposals/0043-phase-scoped-arena-reclamation.md`,
  Implemented, #1989) — phase rewind + single-string relocation; §6
  array-spine UAF forces the flat-blob shape.
* Arena model: `runtime/sfn/memory/mem.sfn:185-187`,
  `runtime/sfn/memory/arena.sfn`; relocation: `arena_relocate.sfn`.
* Load sites: `main.sfn` (~L680–L750); `lowering_core.sfn:446-460`.
* Consumers: `lowering_phase_imports.sfn:119,133`,
  `lowering_helpers_mangling.sfn:60-126`, `lowering_helpers.sfn:331-359`.
* SFEP-0027 (`docs/proposals/0027-cli-rss-modularization.md`) Phase A —
  established import-closure size as the dominant RSS mechanism.
