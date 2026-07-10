---
sfep: 20
title: Compiler Decomposition
status: Accepted
type: tooling
created: 2026-06-22
updated: 2026-06-22
author: "agent:compiler-architect"
tracking: "#345"
supersedes:
superseded-by:
graduates-to:
---

# Compiler Decomposition — Two-Way Split + Shared Common

**Status:** Design (epic #345, sub-issue 1 of 9). Rewritten 2026-06-22.
**Supersedes:** `build-architecture.md` §4.10 / §Stage G (the post-1.0 4-way
`sfn/compiler-parser` / `-typecheck` / `-emit` / `-llvm` sketch). This doc
locks the **pre-1.0 2-way split** (frontend + backend) plus a shared
`sfn/compiler-common` and a thin `sfn/compiler` binary capsule. The 4-way
split stays post-1.0 and is explicitly out of scope here.

Cross-references: `build-architecture.md` §2.13 (sub-directories as hidden
sub-capsules), §Stage C (in-process driver + per-capsule artifact tree),
§Stage G (the deferred 4-way split this narrows).

---

## 1. Goal

Decompose the monolithic compiler capsule (166 `.sfn` files, ~99,093 LOC under
`compiler/src/`, 1,089 intra-compiler relative-import edges) into four capsules
under the single `sfn/*` namespace — `sfn/compiler-frontend`,
`sfn/compiler-backend`, `sfn/compiler-common`, and the `publish = false` binary
`sfn/compiler` — so that each member has an independent dep graph, cache key,
and (eventually) parallel worker slot, and so `sfn check` / `sfn lsp` can depend
on the frontend alone. The split must keep `make compile` green between every
PR (self-host invariant), and must not be gated by namespace — internal-vs-
published is a new `[build] publish` bool.

This sub-issue produces **the design only**: the file-partition table, the
cyclic-import resolution that defines `sfn/compiler-common`'s exact contents,
the two-segment artifact-path fix, the `[build] publish` spec, the stdlib-
dogfooding inventory, the bootstrap ordering proof, and the sub-issue sequence.
No source is moved here.

---

## 2. Current state (measured)

All counts below are extracted statically from `compiler/src/` on
2026-06-22 (`build/bin/sfn` is absent in this environment; every claim
is grounded in a path + line, not a compiler run).

- **166** `.sfn` files, **99,093** LOC total.
- **1,089** internal (intra-`compiler/src/`) relative-import edges; **9**
  external edges (`runtime/prelude` ×4, `sfn/cli` ×5 — already a source-capsule
  dependency since #1159); **0** unresolved.
- `ast.sfn` (384 LOC) imports exactly one module — `token.sfn` (31 LOC, a
  zero-import leaf). The AST/token pair is the frontend's "data spine."
- `native_ir.sfn` (313 LOC) is a **zero-import leaf** — pure `.sfn-asm` struct
  definitions. This fact is load-bearing for §4 below.
- The backend subtree (`llvm/`, `emit_native*`, `emitter_sailfin*`,
  `native_ir*`, `emit_helpers.sfn`) is **111 files / ~52K LOC** — the bulk.

### 2.1 Provisional segment counts (before cycle resolution)

| Segment | Files | Notes |
|---|---:|---|
| frontend | 25 | `parser/` (7) + `lexer`/`token`/`ast` + `typecheck*` (5) + `effect_*` (4) + `decorator_semantics`, `diagnostics_render`, `ownership_checker`, `reexport_check`, `prelude_globals`, `prelude_scan` |
| backend | 111 | `llvm/` (97) + `emit_native*` (5) + `emitter_sailfin*` (3) + `native_ir*` (8) + `emit_helpers` |
| binary | 15 | CLI orchestration + build/dist/version/lock/test-runner-state |
| `cli/` subtree | 5 | epic earmarks for `sfn/cli`; **flagged** — see §3.4 |
| `tools/` subtree | 3 | `check`, `fmt`, `fmt_rules` — **flagged** — see §3.5 |
| common candidates | 7 | `assert_failure`, `bare_assert_check`, `diagnostics_json`, `num_format`, `string_utils`, `test_runner_json`, `toml_parser` |

The "common candidates" are the seven files that fit no clean home and whose
final disposition is the output of the §4 cycle analysis.

---

## 3. Source-file partitioning table

Every `.sfn` file is assigned to exactly one capsule. Capsule legend:
**FE** = `sfn/compiler-frontend`, **BE** = `sfn/compiler-backend`,
**CO** = `sfn/compiler-common`, **BIN** = `sfn/compiler` (binary, `publish=false`).
A `→ stdlib` annotation means the file is *deleted* and its callers swap to a
shipped capsule (see §6); residue (if any) lands in CO.

### 3.1 Frontend (`sfn/compiler-frontend`) — 25 files

| File | LOC | Rationale |
|---|---:|---|
| `lexer.sfn` | 397 | stage 1 |
| `token.sfn` | 31 | zero-import leaf; data spine |
| `ast.sfn` | 384 | AST node defs; imports only `token` |
| `parser/mod.sfn` | 488 | stage 2 |
| `parser/declarations.sfn` | 1888 | |
| `parser/expressions.sfn` | 1647 | |
| `parser/statements.sfn` | 1605 | |
| `parser/token_utils.sfn` | 884 | |
| `parser/types.sfn` | 244 | |
| `parser/utils.sfn` | 189 | |
| `typecheck.sfn` | 1278 | stage 3 |
| `typecheck_types.sfn` | 2113 | type defs (`Diagnostic`, `TextEdit`, `FixSuggestion`) |
| `typecheck_captures.sfn` | 691 | lambda capture analysis — **see §4.2 (backend re-uses)** |
| `typecheck_imports.sfn` | 165 | **has a frontend→backend edge — see §4.1** |
| `typecheck_import_loader.sfn` | 209 | **has a frontend→backend edge — see §4.1** |
| `effect_checker.sfn` | 1051 | stage 4 |
| `effect_gate.sfn` | 175 | |
| `effect_imports.sfn` | 182 | |
| `effect_taxonomy.sfn` | 64 | |
| `decorator_semantics.sfn` | 56 | |
| `diagnostics_render.sfn` | 437 | imports `effect_checker`, `typecheck_types`, `token`, `string_utils` — all FE/CO |
| `ownership_checker.sfn` | 1257 | frontend analysis |
| `reexport_check.sfn` | 175 | |
| `prelude_globals.sfn` | 135 | |
| `prelude_scan.sfn` | 96 | |

### 3.2 Backend (`sfn/compiler-backend`) — 111 files

Confirmed: the entire `llvm/` subtree (97 files, including
`llvm/lowering/`, `llvm/expression_lowering/native/`) goes to BE. Plus:

- `emit_native.sfn`, `emit_native_desugar_try.sfn`, `emit_native_format.sfn`,
  `emit_native_layout.sfn`, `emit_native_state.sfn`
- `emitter_sailfin.sfn`, `emitter_sailfin_expr.sfn`, `emitter_sailfin_utils.sfn`
- `native_ir.sfn` (data leaf — **but see §4.1, its data types move to CO**),
  `native_ir_api.sfn`, `native_ir_parser.sfn`, `native_ir_parser_defs.sfn`,
  `native_ir_parser_instructions.sfn`, `native_ir_utils_layout.sfn`,
  `native_ir_utils_parse.sfn`, `native_ir_utils_text.sfn`
- `emit_helpers.sfn` — **has a backend→binary edge — see §4.3**

### 3.3 Binary (`sfn/compiler`, `publish = false`) — 14 files

| File | LOC | Rationale |
|---|---:|---|
| `main.sfn` | 751 | entry point / pass orchestration |
| `cli_main.sfn` | 3037 | driver |
| `cli_commands.sfn` | 3768 | command dispatch (incl. `handle_publish_command`) |
| `cli_commands_utils.sfn` | 704 | **FS-atomic helpers used by backend — see §4.3** |
| `cli_check.sfn` | 515 | |
| `capsule_resolver.sfn` | 4675 | dep resolution / source enumeration |
| `capsule_artifact.sfn` | 644 | per-capsule artifact manifest (`parse_scope_name`) |
| `runtime_capsule_resolver.sfn` | 381 | runtime-capsule wiring |
| `build_cache.sfn` | 988 | |
| `build_report.sfn` | 540 | |
| `dist_manifest.sfn` | 174 | |
| `version.sfn` | 238 | |
| `lock.sfn` | 231 | |
| `build_stamp.sfn` | 111 | (epic omitted it; it is a binary-only concern) |

`test_runner_state.sfn` (197) — epic listed it as binary, but **backend imports
it 6 times** (§4.4); it moves to **CO**, not BIN.

### 3.4 `cli/` subtree (5 files) — BIN; `sfn/cli` is already dogfooded

The epic earmarked `cli/` for "an expanded `sfn/cli`," but that framing is a
category error and is **corrected here**: the `sfn/cli` dogfooding is **already
done**. Four of the five files (`cli/main.sfn`, `cli/commands/{guillermo,init,
version}.sfn`) already `import ... from "sfn/cli"` (the generic `Command` /
`Matches` / `command` toolkit, since #1159/#351). What these files *are* is the
compiler's own **subcommand implementations** — `init` scaffolds a capsule
(`toml_generate`), `version` resolves the compiler version, `guillermo` is the
mascot — so they also import binary-internal modules (`../cli_main`,
`../../version`, `../../toml_parser`, `../cli_commands_utils`). They belong in
**BIN** as consumers of `sfn/cli`; pushing compiler subcommands *down* into the
generic CLI library would create the stdlib→binary cycle §7 forbids. There is
**nothing to move and nothing to defer** — the consume-`sfn/cli` relationship is
the correct end state and exists today. `cli/` therefore comes **off the
dogfooding inventory** (it is not an open swap). Files: `cli/main.sfn`,
`cli/context.sfn`, `cli/commands/{guillermo,init,version}.sfn` — all BIN.

### 3.5 `tools/` subtree (3 files) — split, do NOT treat as one unit

- `tools/fmt.sfn` (1644) + `tools/fmt_rules.sfn` (180) → **BIN** (the formatter
  is a CLI subcommand; `tools/fmt.sfn` imports the parser/lexer for tokenizing —
  i.e. it depends on **FE**, which BIN already does).
- `tools/check.sfn` (382) → **BIN**, but it has a **tools→backend** edge: it
  imports `runtime_helper_call_names` from `llvm/runtime_helpers.sfn`
  (`tools/check.sfn:42`). BIN depends on BE, so this is benign **once** `tools/`
  is BIN; flag it only so the mover does not mistakenly place `tools/check.sfn`
  in FE (it is a check *driver*, not a frontend pass).

---

## 4. Cyclic-import analysis — the blocker

This is the heart of the proposal. The cut is across the
**frontend↔backend** boundary; the expected data handoff is one-directional
(FE produces AST → BE consumes AST). The cross-segment edge matrix (importer →
imported), measured from the 1,089 internal edges:

| importer → imported | edges | verdict |
|---|---:|---|
| backend → common-candidate | 69 | resolves with CO |
| binary → common-candidate | 22 | fine (BIN sees all) |
| binary → frontend | 21 | fine |
| frontend → common-candidate | 15 | resolves with CO |
| **backend → frontend** | **15** | **cycle risk — §4.1, §4.2** |
| binary → backend | 13 | fine |
| tools → frontend | 13 | fine (tools→BIN) |
| **backend → binary** | **9** | **layering violation — §4.3, §4.4** |
| common-cand → frontend | 4 | CO must not depend on FE — §4.5 |
| cli → binary | 4 | §3.4 |
| common-cand → common-cand | (incl. above) | fine |
| **frontend → backend** | **2** | **true cycle creator — §4.1** |
| common-cand → backend | 1 | §4.5 |
| tools → backend | 1 | §3.5 (tools→BIN, benign) |

There are **four distinct problem classes**, resolved below. The net output is
the concrete contents of `sfn/compiler-common`.

### 4.1 The native-IR data-type cycle (FE↔BE) — move types to CO

Two frontend files reach into the backend, and fifteen backend files reach back
into the frontend's AST. Trace:

- **frontend → backend (2 edges):**
  - `typecheck_imports.sfn:36` — `import { NativeInterface, NativeParameter,
    NativeInterfaceSignature } from "./native_ir"`. These are consumed by pure
    converters (`parameter_from_native`, `function_signatures_from_native`,
    `interface_statement_from_native`) that turn parsed `.sfn-asm` import-context
    shapes into AST shapes. The file's own header comment
    (`typecheck_imports.sfn:15-19`) already notes it "depends only on `ast` and
    `native_ir`, both of which are themselves [leaf]."
  - `typecheck_import_loader.sfn:31` — `import {
    parse_native_artifact_for_import_context } from "./native_ir_api"` (plus it
    imports `interfaces_from_native` from `typecheck_imports`).

  This is the **import-context path**: when the typechecker imports a
  precompiled capsule, it parses that capsule's emitted `.sfn-asm` interface and
  lifts it back into AST. It is a genuine FE→BE dependency and, combined with the
  15 BE→FE `ast` edges below, forms a **cycle** the moment the seam is cut.

- **backend → frontend (15 edges):** thirteen are `emit_native*` /
  `emitter_sailfin*` / `llvm/closures` / `llvm/.../core` importing `ast.sfn`
  (and two `token.sfn`) — the *expected* AST-consumption handoff. The other two
  are §4.2.

**Resolution (locked choice: move shared data types to CO).** Split the leaf
data modules so their *struct definitions* live in CO while their *behavior*
(parsers, emitters) stays in BE:

- Move the import-context **data types** consumed across the seam —
  `NativeInterface`, `NativeParameter`, `NativeInterfaceSignature` (and any
  sibling structs `native_ir_api`'s `parse_native_artifact_for_import_context`
  returns) — into a new **`compiler-common/native_ir_types.sfn`**. `native_ir.sfn`
  itself is a zero-import leaf (`rg 'from "' native_ir.sfn` → empty), so this is
  a clean carve: BE's `native_ir.sfn` re-exports them (or is renamed), the
  parsers in `native_ir_api.sfn` stay in BE, and FE imports only the **types**
  from CO.
- The **converter** `interfaces_from_native` / `parameter_from_native` family
  (currently in FE's `typecheck_imports.sfn`) operates on `NativeInterface*`
  (now CO) → `Statement`/`Parameter` (FE's `ast`). Keep these converters in FE;
  they import the types from CO and the AST from within FE. No edge crosses into
  BE.
- The **parse entrypoint** `parse_native_artifact_for_import_context`
  (`native_ir_api.sfn`, BE) returns CO types. FE's `typecheck_import_loader.sfn`
  imports it. This is now a **FE→BE** call that returns **CO** data — still a
  cycle. **Resolve by relocating `parse_native_artifact_for_import_context`'s
  thin entrypoint into CO** as `native_ir_types.sfn`'s companion
  `native_ir_import_parse.sfn`, since interface-only parsing needs just the text
  utilities and the CO types (verify the transitive closure: it pulls
  `native_ir_parser`, `native_ir_utils_*` — these are the `.sfn-asm` *reader*,
  distinct from the *emitter*). If that closure is too large to hoist cleanly,
  fall back to **inverting the call**: BIN (which owns both FE and BE) drives
  import-context parsing and hands the typechecker a pre-parsed AST, removing the
  FE→BE edge entirely. The architect's recommendation is to **try the CO hoist
  first** (the `.sfn-asm` reader is self-contained and a natural CO citizen — it
  is the cross-seam interchange format), and fall back to call-inversion only if
  the reader's closure drags in emitter code.

**Net:** after this, FE imports CO (types + reader) and never BE; BE imports FE's
`ast`/`token` (one-directional handoff). Cycle broken.

### 4.2 `lambda_lowering` re-parses lambda bodies (BE→FE) — keep, document

`llvm/expression_lowering/native/lambda_lowering.sfn` imports from FE:
- `:61` `Parser` from `parser/types`
- `:62` `parse_block` from `parser/statements`
- `:63` `LambdaCaptureRecord, analyze_lambda_captures` from `typecheck_captures`

The backend **re-parses and re-analyzes lambda bodies during lowering**
(comments at `:296`, `:574` confirm it re-runs capture analysis). This is a
BE→FE edge but **not** a cycle: FE never imports `lambda_lowering` (or anything
in BE except the §4.1 native-IR path, which §4.1 removes). So once §4.1 is
resolved, **BE→FE is a clean acyclic dependency** (backend depends on frontend;
frontend depends on neither). This is architecturally defensible: the AST,
parser, and capture analyzer are frontend services the backend consumes.

**Decision:** leave `lambda_lowering`'s FE imports as-is. `sfn/compiler-backend`
declares a dependency on `sfn/compiler-frontend`. Do **not** duplicate the
parser into CO. Document the dependency direction in the backend's `capsule.toml`
header so future maintainers know BE→FE is intentional and FE→BE is forbidden.

### 4.3 `emit_helpers` → `cli_commands_utils` (BE→BIN) — move FS helpers to CO

`emit_helpers.sfn:40` imports `_mktemp_sibling_cmd`, `_atomic_rename_into_place`
from `cli_commands_utils.sfn` (BIN). These are **atomic-write FS primitives**
(mktemp-sibling + rename-into-place), not CLI logic. A backend module must not
import a binary module.

**Resolution (b/c): hoist to CO or prelude.** Atomic file write is broadly
useful runtime plumbing, not compiler-specific. **Move `_mktemp_sibling_cmd` and
`_atomic_rename_into_place` into `runtime/prelude.sfn`** if they are pure `![io]`
helpers with no compiler types in their signatures (verify: they take/return
`string` paths) — this is option (b), the broadest fix, and retires the residual
copy in `cli_commands_utils`. If prelude promotion is contentious for an `![io]`
helper, fall back to **CO `compiler-common/atomic_fs.sfn`** (option a). Either
way `cli_commands_utils.sfn` re-imports from the new home, and the BE→BIN edge
becomes BE→prelude (or BE→CO). Recommendation: **prelude** — atomic rename is a
1.0 stdlib-IO staple.

### 4.4 `test_runner_trace` (BE→BIN ×6) — move to CO

Six backend files import `test_runner_trace` (and `test_runner_active`) from
`test_runner_state.sfn`:
`llvm/effects.sfn:33`, `llvm/imports.sfn:24`,
`llvm/lowering/emission.sfn:51`, `llvm/lowering/instructions.sfn`,
`llvm/lowering/lowering_core.sfn:97`,
`llvm/expression_lowering/native/statement.sfn`. This is a debug/trace toggle
read all over the compiler. `test_runner_state.sfn` imports `ast` (FE) and
`string_utils` (CO).

**Resolution: move `test_runner_state.sfn` to CO**, but first sever its FE
dependency: it imports `Decorator, Statement, Expression` from `ast`
(`test_runner_state.sfn:1`). If those types are only used by a test-discovery
helper (not by the `trace`/`active` globals BE needs), **split the file**: the
`test_runner_trace` / `test_runner_active` globals + their string formatting go
to **CO `compiler-common/trace.sfn`** (depends only on `string_utils`/CO), and
the AST-touching test-discovery half stays in **BIN** as `test_runner_state.sfn`
importing the CO trace module. This keeps CO free of any FE dependency (§4.5).

### 4.5 CO must not depend on FE or BE — the common-candidate triage

The seven "common candidates" are **not** uniformly leaf-pure. Measured deps:

| candidate | imports → | disposition |
|---|---|---|
| `string_utils.sfn` | `runtime/prelude` only | **CO** (the canonical shared leaf) — but see §6.1 |
| `num_format.sfn` | `runtime/prelude` only | **CO** |
| `toml_parser.sfn` | `string_utils` (CO) | **BIN** (manifest parsing is a driver concern) or **dogfood to `sfn/toml`** — §6.2 |
| `bare_assert_check.sfn` | `ast` (FE) | **FE** (it walks `Program`/`Statement`/`Block` — a frontend analysis, mis-bucketed as common) |
| `diagnostics_json.sfn` | `token` (FE), `string_utils` (CO), `typecheck_types` (FE) | **FE** (renders FE diagnostic types) or **dogfood JSON to `sfn/json`**, FE residue — §6.3 |
| `assert_failure.sfn` | `string_utils` (CO), `native_ir_utils_text` (BE!) | **CO**, after severing the BE edge — see below |
| `test_runner_json.sfn` | `ast` (FE), `string_utils` (CO), `assert_failure` | **BIN** (test-runner JSON output is a driver concern; it touches FE `ast`) |

Two of these create the **common→backend (1)** and **common→frontend (4)**
edges in the matrix:

- `assert_failure.sfn:23` imports `split_lines` from `native_ir_utils_text.sfn`
  (BE). `split_lines` is a generic string helper sitting in a backend file.
  **Resolution:** move `split_lines` into `string_utils.sfn` (CO) — it has no
  backend semantics. Then `assert_failure` depends only on CO, and the
  **common→backend** edge disappears.
- `bare_assert_check`, `diagnostics_json`, `test_runner_json` import FE types.
  Resolution above relocates them to **FE / BIN**, not CO. CO ends up with **no
  FE dependency**, satisfying the layering rule (prelude → runtime → CO → FE → BE
  → BIN; see §7).

### 4.6 Final contents of `sfn/compiler-common`

After the above, `sfn/compiler-common` (`publish = true`) contains exactly:

1. **`string_utils.sfn`** — the shared string toolkit (`substring`, `clamp`,
   `find_char`, `find_char_local`, `grapheme_count/at`, `char_code`,
   `char_code_at_text`, `sanitize_symbol`, `strings_equal`, `index_of`,
   `starts_with`, `ends_with`, `strip_prefix`, `contains_string`, …), **plus**
   `split_lines` relocated from `native_ir_utils_text.sfn` (§4.5). Imports only
   `runtime/prelude`. (Long-term: dogfood most of this to `sfn/strings`, leaving
   a thin compiler-specific residue — §6.1.)
2. **`num_format.sfn`** — numeric → string formatting; imports only prelude.
3. **`native_ir_types.sfn`** (new) — the cross-seam `.sfn-asm` interchange data
   types (`NativeInterface`, `NativeParameter`, `NativeInterfaceSignature`, and
   the structs returned by interface-context parsing). Zero imports. This is the
   FE↔BE data contract (§4.1).
4. **`native_ir_import_parse.sfn`** (new, *conditional* — only if the §4.1 CO
   hoist wins over call-inversion) — the interface-context `.sfn-asm` **reader**
   (`parse_native_artifact_for_import_context` + its `native_ir_parser` /
   `native_ir_utils_*` closure). Imports `native_ir_types` (CO) + prelude.
5. **`trace.sfn`** (new) — `test_runner_trace` / `test_runner_active` globals +
   trace string formatting (§4.4). Imports `string_utils` (CO) only.
6. **`atomic_fs.sfn`** (new, *conditional* — only if §4.3's prelude promotion is
   rejected) — `_mktemp_sibling_cmd`, `_atomic_rename_into_place`. `![io]`,
   imports prelude only.

CO depends on **`runtime/prelude` and `sfn/runtime`** only — never on FE, BE, or
BIN. Items 4 and 6 are the two conditional members; the recommended path
(CO hoist for the reader, prelude promotion for atomic-fs) yields the set
{1, 2, 3, 4, 5}.

### 4.7 Cycle-resolution summary

| # | edge class | count | resolution | option |
|---|---|---:|---|---|
| §4.1 | FE→BE (native-IR types/reader) + BE→FE(ast) cycle | 2 + 13 | move types → CO; move reader → CO (or invert into BIN) | (a) |
| §4.2 | BE→FE (lambda re-parse) | 3* | keep — acyclic once §4.1 done; declare BE→FE dep | — |
| §4.3 | BE→BIN (atomic FS) | 1 | promote to prelude (fallback CO) | (b)/(a) |
| §4.4 | BE→BIN (test trace) | 6 | split `test_runner_state`; trace → CO | (a) |
| §4.5 | CO→BE (`split_lines`) | 1 | move `split_lines` → `string_utils` (CO) | (a) |
| §4.5 | CO-candidate→FE | 4 | re-bucket to FE/BIN, not CO | — |

*The 3 lambda edges are a subset of the 15 BE→FE; the other 12 are the
expected `ast`/`token` handoff.

**No residual frontend↔backend cycle remains** after these moves. The only
cross-seam edge is BE→FE (backend consumes frontend AST + parser services),
which is acyclic.

---

## 5. The two-segment binary-capsule artifact-path issue

Today `compiler/capsule.toml` sets `name = "sailfin"` — a **single segment**.
The per-capsule artifact tree (Stage C2b2) special-cases this:
`capsule_artifact.sfn:163` `parse_scope_name("sailfin")` finds no `/` and
returns `ScopeName { scope: "", name: "" }`, which routes the compiler's own
modules to the **legacy flat path** `build/sailfin/capsules/*.ll` instead of
`build/capsules/<scope>/<name>/ir/*.ll`. This is documented in the Makefile
(`Makefile:865` region): *"its `[capsule].name = "sailfin"` is single-segment,
so Stage C2b2 keeps them on the legacy path. Scope/name SOURCE-capsule deps …
route instead to `build/capsules/<scope>/<name>/ir/*.ll`."*

Renaming to two-segment **`sfn/compiler`** flips the compiler itself onto the
scoped path: `parse_scope_name("sfn/compiler")` → `("sfn", "compiler")`, so its
IR lands at `build/capsules/sfn/compiler/ir/*.ll` and the legacy
`build/sailfin/capsules/` branch goes empty for the compiler.

**What breaks / what to fix:**

1. **The `make rebuild` cross-windows IR mirror** (`Makefile` ~L860-895). The
   flat-copy of `build/sailfin/capsules/.` → `build/native/raw/` now misses the
   compiler's own modules (they moved to `build/capsules/sfn/compiler/ir/`). The
   `if [ -d build/capsules ]` flattening loop already in the Makefile
   (`<scope>/<name>/ir/<rel>.ll` → `<scope>__<name>__ir__<rel>.ll`) **already
   handles this** for source-capsule deps — confirm it now also sweeps
   `sfn/compiler/ir/`. **Fix:** the flatten loop is path-generic; verify it
   captures `sfn/compiler` and, if the legacy flat-copy line is now redundant for
   the compiler, leave it (harmless) but rely on the scoped sweep.
2. **`build/bin/sfn` output filename is unchanged.** The *binary* name
   (`name = "sailfin"` → `sfn/compiler`) is decoupled from the *output path*
   (`build/bin/sfn`) — the latter is `$(NATIVE_OUT)` in the Makefile and
   the `cp -f build/sailfin/program $(NATIVE_OUT)` step, driven by the binary
   capsule's `[build] entry`/`kind`, not its `name`. Confirm the binary capsule
   continues to emit `program`/`program.ll` to `build/sailfin/` (the binary
   capsule is `kind="binary"`/non-scoped-output) and the rename only affects the
   *library* members' artifact tree. **Action:** verify `cli_main.sfn`'s
   top-level program emission path (`_resolve_sailfin_cache_dir_for_work`,
   `program.ll`) is keyed off build-kind, not capsule name.
3. **`_runtime_obj_prefix`** (`cli_main.sfn:806`) already sanitizes `/` → `__`
   for runtime-capsule object caches (`"sfn/runtime-native"` →
   `"sfn__runtime-native__"`). The same sanitization is the established pattern;
   the new `sfn/compiler-frontend` / `-backend` / `-common` library members will
   each get a `sfn__compiler-frontend__` etc. object-cache prefix automatically.
   No new code — confirm the prefix function is applied per-member, not once for
   the whole build.
4. **`is_safe_scope_name` / `_ca_is_safe_segment`** (`capsule_artifact.sfn:198-234`)
   accept multi-segment `name` (e.g. `http/client`) but the `scope` must be a
   single safe segment. `sfn/compiler` passes (`scope="sfn"`, `name="compiler"`).
   The hyphenated members `compiler-frontend` etc. are single safe segments
   (hyphen is permitted — confirm `_ca_is_safe_segment` allows `-`). **Action:**
   read `_ca_is_safe_segment` and confirm `-` is not rejected; if it is, that is
   a one-line fix in this sub-issue's downstream PR.

**Net fix scope:** mostly *verification* that the scoped path already works for
two-segment names (it does, for `sfn/cli` and `sfn/runtime-native` today) plus
confirming the Makefile cross-windows sweep covers `sfn/compiler`. No
deep refactor — the special-case is an *absence* (single-segment falls through),
and giving the compiler a scope removes the special case rather than adding one.

---

## 6. `[build] publish` field spec

A new boolean `[build] publish` (default `true`) gates internal-vs-published
**independent of namespace** — the binary `sfn/compiler` is `publish = false`
while `sfn/compiler-frontend` / `-backend` / `-common` are `publish = true`.

### 6.1 Parse site — `toml_parser.sfn`

Mirror the existing `implicit` field exactly:

- **Struct field** (`toml_parser.sfn` ~L18, beside `build_implicit: boolean`):
  add `build_publish: boolean`.
- **Default** (`toml_parser.sfn:173` region, in the empty/initial struct):
  `build_publish: true` (note: this differs from `build_implicit`'s `false`
  default — `publish` defaults *true* so unannotated capsules stay publishable).
- **Parse branch** (`toml_parser.sfn:211-220`, inside `if section == "build"`):
  ```
  if strings_equal(stripped_key, "publish") {
      toml.build_publish = !strings_equal(stripped_value, "false");
  }
  ```
  (Parse as "true unless the literal string `false`" so a malformed value fails
  safe to publishable — or, stricter, `strings_equal(stripped_value, "true")`
  with the default carrying unannotated capsules; pick the former to honor the
  `true` default.)
- **Getter** (`toml_parser.sfn:281` region, beside `toml_get_build_implicit`):
  ```
  fn toml_get_build_publish(text: string) -> boolean {
      let t = _parse_toml_internal(text);
      return t.build_publish;
  }
  ```
- **Round-trip writer** (`toml_parser.sfn:547`/`631` `[build]` serialization):
  emit `publish = false` only when `!build_publish` (omit when true, matching how
  `implicit` is only emitted when set).

### 6.2 Consumer 1 — `handle_publish_command` refuses `publish = false`

`cli_commands.sfn:2552 handle_publish_command`. Before building the publish
payload (currently around the `registry_base + "/api/publish"` POST at
`cli_commands.sfn:2666`), read the target capsule's manifest and call
`toml_get_build_publish`; if `false`, print a clear diagnostic
(`"sfn/compiler is publish=false; refusing to publish a binary/internal
capsule"`) and return a non-zero exit **before** any network call. This is the
hard gate that keeps the binary out of the registry.

### 6.3 Consumer 2 — resolver refuses to satisfy `publish = false` from the registry

The resolver must serve a `publish = false` capsule **only** from a workspace
path, never from the registry. In `capsule_resolver.sfn`, at the point where a
dependency spec is resolved to either a workspace member or a registry fetch
(the `workspace_member_for_spec` / registry-fetch fork around
`capsule_resolver.sfn:2462`), after resolving to a registry candidate, read the
candidate's manifest and reject if `toml_get_build_publish` is `false` with a
diagnostic. Workspace-member resolution is unaffected (the compiler's own
members resolve by path during self-host). This prevents a future where someone
accidentally depends on `sfn/compiler` from the registry.

---

## 7. Stdlib dogfooding inventory

Each private copy that overlaps a shipped capsule, the swap, the residue, and
the **API-surface gap** in the target capsule that must be filled first. All
four target capsules exist today (`capsules/sfn/{strings,toml,json,cli}/`).

**Net scope for #345:** `sfn/json` (clean, §7.3) and `sfn/strings` (after an
in-scope API-fill predecessor, §7.1) are the in-scope swaps. `sfn/cli` is
**already dogfooded** (§7.4 — banked, not an open swap). `sfn/toml` is the **one
genuine deferral** (§7.2 — API-shape mismatch + the single-line-array quirk).

### 7.1 `string_utils.sfn` → `sfn/strings` (residue stays in CO)

`sfn/strings` (`capsules/sfn/strings/src/mod.sfn`, 22 fns) **covers**:
`starts_with`, `ends_with`, `contains` (≈ `contains_string`), `find`
(≈ `find_char`/`index_of` semantics differ — verify), `split`, `join`,
`replace`, `repeat`, `trim*`, case ops.

**GAP — `sfn/strings` is missing the compiler's most-used helpers:**
`substring`, `clamp`, `grapheme_count`, `grapheme_at`, `char_code`,
`char_code_at_text`, `char_at`, `find_char_local`, `index_of` (exact
signature), `strip_prefix`, `find_last_index_of_char`. These would need to be
added to `sfn/strings` before a full swap.

**Recommended residue:** the epic names `sanitize_symbol`, `find_char_local`,
`char_code_at_text` as compiler-specific residue — confirmed: `sanitize_symbol`
(`string_utils.sfn:46`) is LLVM-symbol mangling (compiler-only), and
`find_char_local`/`char_code_at_text` (`:78`,`:69`) are the byte-level primitives
`sanitize_symbol` and the lexer build on. **Keep these three + `clamp` +
`grapheme_*` (Unicode width, compiler-formatting-specific) in CO**; migrate the
genuinely generic ones (`starts_with`/`ends_with`/`contains_string`/`split`/etc.)
to `sfn/strings` consumption once `sfn/strings` gains `substring` and `index_of`
with matching signatures.

**This is an API gap, not a design blocker.** The missing helpers are mundane —
`sfn/strings` simply doesn't export them yet. Land an explicit **`sfn/strings`
API-fill predecessor PR** (sub-issue 7a) that adds `substring`, `index_of`,
`grapheme_count/at`, `char_code`, `char_at` with signatures matching the
compiler's current `string_utils` usage; then the consumption swap (sub-issue
7b) is mechanical. Both fit inside #345 — this is in-scope, not deferred.

### 7.2 `toml_parser.sfn` → `sfn/toml` (CAUTION: single-line-array quirk)

`compiler/src/toml_parser.sfn` (662 LOC) exposes a **string-getter API**
(`toml_get_name`, `toml_get_version`, `toml_get_entry`, `toml_get_build_kind`,
`toml_get_build_implicit`, + the new `toml_get_build_publish`). `sfn/toml`
(`capsules/sfn/toml/src/mod.sfn`) is a **structured value-tree parser**
(`TomlValue`, `array_val`, `table_val`, …) — a *different API shape* entirely.

**GAP (two):**
1. **API mismatch** — every compiler call site uses `toml_get_*` string getters,
   not a `TomlValue` tree. A swap requires either adding getter wrappers to
   `sfn/toml` or rewriting ~dozens of resolver/CLI call sites. Large surface.
2. **The single-line-array quirk (load-bearing).** `runtime/capsule.toml:29-31`
   explicitly documents that the compiler's `_toml_parse_string_array`
   *"recognises arrays whose `[...]` is on one line. Multi-line … reformatting
   here would silently make every getter return `[]`."* The runtime manifest's
   `sfn-sources = [...]` (`runtime/capsule.toml:49`) is a single physical line
   **on purpose** to satisfy this quirk. **`sfn/toml`, being a real tokenizer,
   parses multi-line arrays** — so it would *fix* the quirk, but the runtime
   manifest currently *depends on the bug not mattering* (the single line works
   under both parsers). **Verify** `sfn/toml` returns the same `sfn-sources`
   array for the single-line form; if it normalizes/round-trips the manifest to
   multi-line on any write path, that is a regression hazard. **Recommendation:**
   keep `toml_parser.sfn` in **BIN** (not CO, not dogfooded) for the MVP — manifest
   parsing is a pure driver concern and the API/quirk gap makes the swap a
   separate, risky workstream. Flag the `sfn/toml` getter-API gap as a tracked
   follow-up, not part of epic #345.

### 7.3 `diagnostics_json.sfn` → `sfn/json` (FE residue)

`diagnostics_json.sfn` (301 LOC) imports FE types (`Token`, `typecheck_types`'
`Diagnostic`/`TextEdit`/`FixSuggestion`) and hand-rolls JSON serialization of
them. `sfn/json` (`capsules/sfn/json/capsule.toml` exists).

**GAP:** `sfn/json` provides generic JSON *encoding* primitives; the
diagnostic-shape serialization (which fields, what envelope — must match the
`sfn check --json` contract consumed by `assert_compiles` and MCP tooling) is
compiler-specific and stays. **Swap:** replace the manual string-concatenation
escaping inside `diagnostics_json.sfn` with `sfn/json`'s string-escape/encoder,
keeping the diagnostic-shape mapping. **Residue:** the diagnostic→JSON shape
function stays, classified to **FE** (it serializes FE diagnostic types). Verify
`sfn/json` exposes a string-escape primitive (the one gap to confirm); if not,
that primitive is the predecessor. Low risk — additive, FE-local.

### 7.4 `cli/` → `sfn/cli` — ALREADY DONE, not an open swap (see §3.4)

This row is **closed, not deferred**. The compiler already consumes `sfn/cli`'s
generic toolkit (`Command`/`Matches`/`command`) in 4 of the 5 `cli/` files since
#1159/#351 — the dogfooding win is banked. The remaining content of `cli/` is
compiler-specific subcommand logic (`init`/`version`/`guillermo`) that correctly
lives in BIN as a *consumer* of `sfn/cli`; moving it into the library would
invert the layering (§7). There is no swap to perform and no blocker to clear.
`cli/` is therefore removed from the dogfooding inventory.

---

## 8. Bootstrap / self-host ordering

Once `sfn/compiler` (binary) depends on `sfn/compiler-frontend`, `-backend`,
`-common`, **and** `sfn/runtime` (renamed from `sfn/runtime-native`), plus
stdlib capsules (`sfn/strings` etc. once dogfooded), the resolver must topo-order
the workspace so the **first-pass binary builds every library/runtime member
before linking itself**.

### 8.1 Does the resolver topo-sort? — Partially; verify the workspace layer

- **Intra-capsule** module discovery is a BFS over relative imports with a
  visited-set (`capsule_resolver.sfn:3043 _cr_enumerate_relative_sources_memo`,
  `visited`/`queue`/`head` at `:3049-3110`). This orders *modules within one
  capsule*, not capsules against each other.
- **Inter-capsule** ordering is driven by `load_workspace_members`
  (`capsule_resolver.sfn:2424`) + `workspace_member_for_spec` (`:2462`) +
  `resolve_workspace_lock_entries` (`:2490`). The compiler already builds
  `sfn/cli` (a source-capsule dep) and the `sfn/runtime-native` runtime member
  ahead of itself today (#1159, #940), which **demonstrates the resolver already
  satisfies a multi-member dependency build order**. **Action:** confirm
  `resolve_workspace_lock_entries` produces a dependency-respecting order for an
  N-member workspace (3 library members + runtime + binary), not just the
  2-member (`sfn/cli` + binary) case in use today. If it relies on declaration
  order rather than a true topo-sort, **flag a dedicated sub-issue** to add
  topological ordering keyed off each member's `[dependencies]`. The likely
  reality: it works because the current graph is shallow; the 4-member graph here
  is still a DAG of depth 4 and should sort fine — but this must be *verified*,
  not assumed, before the "move backend" PR (§9 step 5) lands.

### 8.2 The layering is acyclic — proof obligation

Required strict layering (each layer may import only lower layers):

```
runtime/prelude.sfn
   ↓
sfn/runtime            (renamed from sfn/runtime-native)
   ↓
sfn/strings, sfn/json, sfn/toml, sfn/cli   (stdlib — no member imports the compiler)
   ↓
sfn/compiler-common    (prelude + sfn/runtime + stdlib; NO FE/BE/BIN)
   ↓
sfn/compiler-frontend  (CO + prelude/runtime; NO BE)
   ↓
sfn/compiler-backend   (FE + CO; the §4.2 BE→FE dep is here)
   ↓
sfn/compiler (binary, publish=false)  (FE + BE + CO + stdlib)
```

**No stdlib capsule may import the compiler** — verify none of
`capsules/sfn/{strings,json,toml,cli}/` import `sfn/compiler*` (they must not; a
stdlib→compiler edge is an instant cycle). The §4 resolutions guarantee CO has no
FE/BE edge and FE has no BE edge, so the layering is a strict DAG. The only
inter-compiler edge that goes "down then the dependency points up" is BE→FE,
which matches the layering (BE sits above FE). **Acyclic. Confirmed by
construction once §4 lands.**

---

## 9. Sequencing recommendation (sub-issues 2–9)

The epic enumerates sub-issues 2–9 as: manifest flag, renames, skeleton, move
common+frontend, move backend, dogfood, verify MVP, docs. Recommended order,
serialization, and parallelism:

| # | Sub-issue | Depends on | Parallel? | Self-host gate |
|---|---|---|---|---|
| 2 | **`[build] publish` flag** (§6) — parse + 2 consumers | 1 (this doc) | with #3 | additive; old seed ignores `publish`; `make compile` stays green |
| 3 | **Renames** — `sfn/runtime-native`→`sfn/runtime`; binary `name`→`sfn/compiler` (§5) | 1 | with #2 | **serialize as its own PR**; touches artifact path → must `make clean-build && make compile`; pin a new seed after (it changes capsule names the seed resolves) |
| 4 | **Skeleton** — create empty `compiler-common/`, `-frontend/`, `-backend/` `capsule.toml`s + workspace wiring; no source moved | 3 | no | resolver must load the new members (verify §8.1) before any source moves |
| 5 | **Move CO + frontend** (§3.1, §4.1, §4.4-4.5, §4.6) | 4 | no | the **largest correctness step**: defines CO, breaks the FE↔BE cycle. Must land before backend can compile against the new seams |
| 6 | **Move backend** (§3.2, §4.2-4.3) | 5 | no | BE→FE + BE→CO edges now resolve to real capsules; `make clean-build` (structural) |
| 7a | **`sfn/strings` API-fill** — add `substring`/`index_of`/`grapheme_*`/`char_code*` (§7.1) | 6 | with #7-json | additive to a stdlib capsule; `make compile` green |
| 7b | **Dogfood** — `sfn/strings` consumption (after 7a) ∥ `sfn/json` (§7.3) | 7a / 6 | strings vs json independent | each swap its own small PR; `cli/` already done (§7.4); defer only `sfn/toml` (§7.2) |
| 8 | **Verify MVP** — full `make check` triple-pass on the decomposed tree | 7 | no | the self-host proof for the whole split |
| 9 | **Docs** — update `build-architecture.md` §4.10/§Stage G to reflect the *shipped* 2-way split; `docs/status.md`; this proposal → "implemented" | 8 | yes | doc-only |

**Serialization rule:** #5 and #6 each touch hundreds of import edges and
**cannot** be split further without leaving the tree non-self-hosting mid-PR —
they are the two unavoidably-large (M) PRs; keep each as one PR (do not bundle
them together, and do not split #5's "CO" from "frontend" since the cycle break
in §4.1 spans both). #2 and #3 can land in parallel (different files), but **#3
(renames) should pin a fresh seed** before #4, because #4's resolver wiring and
#5/#6's moves all build against the renamed capsules — an old seed that still
calls the binary `sailfin` and the runtime `sfn/runtime-native` cannot resolve
the new workspace.

**Determinism gate (#341):** the source-move PRs (#5, #6) shuffle which physical
file emits which IR module and change `build/capsules/` layout (§5). The
determinism gate compares IR byte-for-byte across rebuilds; a file move that
changes module slugs **will** trip it. **Recommendation:** pause/rebaseline the
#341 determinism gate across #3, #5, #6 (the rename + the two big moves), and
re-arm it at #8 (verify-MVP) against the new stable layout. Do not let #341 block
the moves; do re-baseline once the layout settles.

---

## 10. Risks

| Risk | Detection | Mitigation |
|---|---|---|
| §4.1 reader closure drags emitter code into CO | trace transitive imports of `parse_native_artifact_for_import_context` before the move | fall back to call-inversion (BIN drives import-context parse) — §4.1 |
| Resolver only orders by declaration order, not topo (§8.1) | build a 4-member workspace where a dep is declared *after* its dependent; observe link failure | dedicated topo-sort sub-issue before #6 |
| Two-segment rename breaks cross-windows IR mirror (§5) | `make ci-cross-windows` link-fails with undefined `sfn/compiler` symbols | confirm Makefile flatten loop sweeps `build/capsules/sfn/compiler/ir/` |
| `_ca_is_safe_segment` rejects `-` in `compiler-frontend` | `is_safe_scope_name("sfn","compiler-frontend")` returns false | read the validator; one-line fix in #4 if needed |
| `sfn/toml` normalizes the runtime manifest's single-line array to multi-line (§7.2) | round-trip `runtime/capsule.toml` through `sfn/toml`, diff `sfn-sources` | keep `toml_parser.sfn` in BIN; do not dogfood toml in #345 |
| `sfn/strings` signature drift (`find` vs `find_char`/`index_of`) (§7.1) | unit-diff each helper's semantics before swap | fill `sfn/strings` API first; defer strings dogfood to #7 |
| A stdlib capsule accidentally imports the compiler (§8.2) | `rg 'sfn/compiler' capsules/sfn/*/src` returns hits | CI grep guard; the layering DAG forbids it |
| Determinism gate (#341) red across moves | gate fails on #5/#6 | rebaseline per §9 |

---

## 11. Verification

Per-step, the self-host gate is non-negotiable:

```bash
# After every PR touching compiler/src:
sfn fmt --check compiler/src/ runtime/        # CI formatting gate
make compile                                  # self-host invariant
# After structural moves (#3, #5, #6):
make clean-build && make compile
# MVP proof (#8):
make check                                     # triple-pass self-host + full suite
```

Targeted checks:

- **`[build] publish` (#2):** a `_test.sfn` asserting `toml_get_build_publish`
  defaults `true`, parses `publish = false`, and `handle_publish_command` exits
  non-zero on a `publish=false` manifest; resolver refuses a `publish=false`
  registry candidate.
- **Rename (#3):** `make compile` + `build/bin/sfn --version`; confirm
  `build/bin/sfn` filename unchanged; `build/capsules/sfn/compiler/ir/`
  populated; `make ci-cross-windows` links.
- **Cycle break (#5):** `rg 'from ".*native_ir"' compiler-frontend/` returns
  only CO imports; `rg 'from ".*/(parser|typecheck|ast)' compiler-backend/`
  shows only the documented §4.2 lambda edge; **no** `compiler-frontend` →
  `compiler-backend` edge.
- **Layering (#8):** `rg 'sfn/compiler' capsules/sfn/*/src` empty;
  `rg 'compiler-backend' compiler-frontend/` empty.

---

## 12. Future considerations

- **Post-1.0 4-way split.** `build-architecture.md` §Stage G's
  `sfn/compiler-parser` / `-typecheck` / `-emit` / `-llvm` becomes a *further*
  subdivision of the FE/BE members defined here — FE → {parser, typecheck},
  BE → {emit, llvm}. The CO contract (data spine + `.sfn-asm` interchange types)
  is the stable seam those splits hang off. This doc's `native_ir_types.sfn` and
  `ast`/`token` data spine are exactly the interfaces the 4-way split will
  formalize. Update §4.10/§Stage G in #9 to say so.
- **`sfn check` / `sfn lsp` slimming.** Once FE is a standalone capsule,
  `sfn check` and a future `sfn lsp` depend on FE + CO only — no `llvm/` (52K
  LOC) in their build graph. That is the headline tooling win and the reason the
  cut is FE/BE (not, say, by-pipeline-pass).
- **Parallel builds.** Per-member cache keys + worker slots (build-architecture
  §4.10) become available once the members exist; the IPC-file bottleneck
  (`docs/proposals/0006-build-architecture.md`) is orthogonal but per-member memory caps (the
  7 GB `lowering_core.sfn` is now isolated in BE) stop one member starving
  another.
- **Dogfooding completion.** The `sfn/toml` getter API (§7.2) is the **one**
  deferred swap — tracked as a post-#345 follow-up (getter wrappers + the
  single-line-array-quirk verification) to keep the MVP's blast radius bounded.
  `sfn/cli` is already retired into consumption (§7.4); `sfn/json` and
  `sfn/strings` land inside #345 (§7.1/§7.3).
