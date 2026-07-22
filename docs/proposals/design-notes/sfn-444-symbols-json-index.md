# SFN-444 — `sfn symbols --json`: a versioned, deterministic public-symbol index

Design doc for the single-issue design gate of SFN-444. **This is not a numbered
SFEP** — `sfn symbols` is a leaf tooling command, not an epic; per
`.claude/rules/proposals.md` a single-issue implementation gate lives here in
`docs/proposals/design-notes/`. The durable *public contract* is the schema doc
`docs/reference/symbols-json-schema.md` (the authoritative record of the shipped
envelope); this note records the *why* behind the design. Where the illustrative
JSON below differs from what shipped, §10 (Implementation notes — as shipped) and
the schema doc are authoritative.

## 1. Summary

Add a CLI command `sfn symbols --json` that emits a versioned, byte-stable JSON
index of the public callable surface Sailfin code can reach: the auto-imported
prelude globals and the exported free functions of resolvable in-tree capsules
(`sfn/strings`, `sfn/math`, …). Each entry carries the canonical name, kind,
rendered signature, structured parameters/return type, known effects, the
canonical import path, and the call form (free vs method). The index lets an
agent or user answer "does symbol X exist, and how do I import and call it?"
without grepping the source tree. Both the schema (`sailfin-symbols/1`) and the
compiler version are stamped, and output is totally ordered so two identical
invocations against an unchanged compiler + capsule set are byte-identical.

## 2. Motivation

Sailfin has no `.sfn` training data, so agents systematically hallucinate API
names, import paths, and signatures. Today the only way to learn that
`ascii_uppercase` lives in `sfn/strings` (not the prelude), or that `parse_int`
returns `Result<int, string>` (not `int`), is to grep `capsules/` and
`runtime/`. A machine-readable index turns "guess and recompile" into "look it
up." This is a direct lever on the CLAUDE.md "AI agents are users" principle: a
stable, self-describing symbol index is the single highest-value discovery
surface we can ship, and it is pure additive tooling — no language change, no
new keyword, no effect-system change.

The four symbols the issue names are the acid test and, importantly, they are
**not** prelude globals — real-file evidence (below) places all four in the
`sfn/strings` capsule. Any design that assumed they were prelude auto-imports
would emit the wrong import path and fail acceptance.

## 3. Design

### 3.0 Ground-truth reconnaissance (real-file evidence)

- The four named symbols live in `capsules/sfn/strings/src/mod.sfn`:
  - `fn ascii_uppercase(text: string) -> string` (L178)
  - `fn ascii_lowercase(text: string) -> string` (L190)
  - `fn int_to_string(value: int) -> string` (L244)
  - `fn parse_int(text: string) -> Result<int, string>` (L267)
  - Manifest `capsules/sfn/strings/capsule.toml` → `name = "sfn/strings"`.
  - Canonical import: `import { ascii_uppercase } from "sfn/strings";`.
  - **None are prelude globals.** `runtime/prelude.sfn` has 49 public `fn`
    (0 underscore-prefixed); `substring`/`char_code` live there, but
    `find`/`trim`/`to_upper`/`to_lower`/the four named functions do not.
- There is **no `export`/`pub` keyword**; a module's public surface is its
  top-level, non-`_`-prefixed `fn` declarations.
- `Program` is `{ statements: Statement[] }` (`ast.sfn` L8). A function is a
  Statement matched by `statement.variant == "FunctionDeclaration"` with
  `statement.signature: FunctionSignature` (matches `ownership_checker.sfn`
  L768, `parser/mod.sfn` L215).
- `FunctionSignature` (`ast.sfn` L274) = `{ name, is_async, parameters:
  Parameter[], return_type: TypeAnnotation?, effects: string[],
  type_parameters, name_span }`.
- `Parameter` (`ast.sfn` L221) = `{ name, type_annotation: TypeAnnotation?,
  default_value, mutable, span }`.
- `TypeAnnotation` (`ast.sfn` L12) = `{ text: string }` — rendering a type is
  literally `annotation.text`; **no walker needed**.
- `parse_program(source) -> Program ![io]` (`parser/mod.sfn` L52). Parsing is
  purely syntactic — it does **not** resolve imports or typecheck, so parsing a
  capsule's `mod.sfn` in isolation succeeds even though it imports peers.
- The parser does **not** import `cli/` (grep clean), so a command module
  importing `parser/mod` is an intra-capsule edge, not a cycle.

### 3.1 Scope decision — parse source, do not read `.sfn-asm` or the intrinsic registry

Three candidate symbol sources exist. The v1 decision:

1. **Prelude/runtime library functions (slice b) — INCLUDE via source parse.**
   Parse `<runtime>/prelude.sfn` with the real parser and walk
   `FunctionDeclaration` statements. This yields real signatures + effects
   directly from source. **Excluded from the prelude category:** `runtime/sfn/**`
   (the `sfn_str_*` ABI layer takes `*u8`/`i64` and is not user-callable — pure
   noise for a discovery index). `runtime/prelude.sfn` is the literal
   "prelude symbols" surface and is clean (0 underscore-prefixed of 49).

2. **Installed capsule exports (slice c) — INCLUDE via source parse.** Parse
   each in-tree `capsules/<scope>/<name>/src/mod.sfn`. This is chosen over the
   `.sfn-asm` artifact path (`interfaces_from_native_artifact`) because
   artifacts are build outputs under `build/compiler/import-context/` that need
   not exist for a fresh toolchain, whereas source is always present, is
   canonical, and gives the same signatures (verified: the staged
   `mod.sfn-asm` for strings carries `.fn ascii_uppercase(text: string) ->
   string` etc., i.e. identical to source). One mechanism (parse) covers both
   slice (b) and slice (c).

3. **Compiler intrinsic surface (slice a) — EXCLUDE from v1.**
   `runtime_helper_descriptors()` (~197 chunked entries) is the ABI intrinsic
   layer behind the prelude — `*u8`/`i64` shapes a user cannot call. No
   acceptance criterion needs it. Reserve `kind: "intrinsic"` as a future
   extension; do not recombine the `_rh_descriptors_00..11` chunks (#1512).

**Self-host / build-cycle risk: none.** `commands/symbols.sfn` and the new
`symbols_index.sfn` live in the `compiler` capsule alongside the parser;
`commands/check.sfn` already imports compiler internals (`../../check/engine`).
The parser does not import back into `cli/` or `symbols_index`, so no import
cycle is introduced. Because the capability (parse-driven collection) and its
only consumer (the command) land in **one PR**, `make compile` builds the new
compiler from the old seed and that compiler self-hosts the command in the same
pass — **no seed cut** (per `.claude/rules/seed-dependency.md`).

### 3.2 Source discovery at runtime

- **Prelude root:** reuse the `_pg_find_runtime_dir()` pattern
  (`prelude_globals.sfn` L83) — it returns the dir `D` where `D/prelude.sfn`
  exists (the `runtime/` dir), via `resolve_runtime_root(exe_path())` plus
  `runtime`/`../runtime`/`../../runtime` fallbacks. Prelude source =
  `D/prelude.sfn`.
- **Capsules root (default enumeration):** `project_root = parent(D)`;
  capsules root = `project_root/capsules`. Walk `capsules/*/*/capsule.toml`
  (scope/name), read `name` from each manifest, parse its `[build] entry`
  (default `src/mod.sfn`). This covers all 21 in-tree `sfn/*` capsules
  including `sfn/strings`. If `project_root/capsules` does not exist (installed
  toolchain with no in-tree capsules), default capsule enumeration is empty —
  the prelude still emits, and named lookup is available through `--capsule`
  (below).
- **`--capsule <slug>` filter:** resolve a single slug through the existing
  full resolver `_cr_capsule_source_dir` (`capsule_resolver.sfn` L897), which
  checks in-tree `capsules/<scope>/<name>/src` first, then
  `~/.sfn/cache/capsules/<scope>/<name>/<ver>/src` — so a named lookup works on
  an installed toolchain. An unresolvable slug drives the error path (§3.5).

### 3.3 JSON schema (`sailfin-symbols/1`)

Hand-rolled encoder, mirroring the `diagnostics_json.sfn` precedent (the
compiler-proper convention; `sailfin-check/1` stamps schema first). Rationale
for hand-roll over importing `sfn/json`: (a) full control of field order and no
map-iteration nondeterminism → guaranteed byte-stability; (b) no new capsule
dependency in the compiler's own build graph; (c) matches the existing envelope
style so the two schemas read alike. The `diagnostics_json.sfn` `_json_*`
helpers are module-private, so mirror the ~15-line escape/quote/field helpers as
private `_sym_json_*` in `symbols_index.sfn` rather than exporting them.

Success envelope (field order is fixed and load-bearing):

```json
{
  "schema_version": "sailfin-symbols/1",
  "compiler_version": "0.5.0-alpha.NN+dev.<hash>",
  "symbols": [
    {
      "name": "ascii_uppercase",
      "kind": "function",
      "origin": "capsule",
      "import_path": "sfn/strings",
      "form": "free",
      "signature": "fn ascii_uppercase(text: string) -> string",
      "parameters": [ { "name": "text", "type": "string" } ],
      "return_type": "string",
      "effects": []
    }
  ],
  "parse_failures": []
}
```

- `schema_version` is always the **first** field, `compiler_version` second
  (from `resolve_compiler_version(ctx.binary_dir)`).
- Per-symbol field order is fixed: `name, kind, origin, import_path, form,
  signature, parameters, return_type, effects`.
- `kind`: `"function"` for all v1 entries (reserve `struct`/`enum`/`intrinsic`).
- `origin`: `"prelude"` or `"capsule"`.
- `import_path`: `null` for prelude (auto-imported, no import needed); the
  capsule slug (e.g. `"sfn/strings"`) for capsule origin.
- `form`: `"free"` for all v1 entries (reserve `"method"` for
  receiver-attached APIs, e.g. future `string.` methods).
- `signature`: rendered `fn <name>(<p>: <T>, …) -> <R> ![<effects>]`; the
  `-> <R>` clause omitted when `return_type` is null; the `![…]` clause omitted
  when effects are empty.
- `parameters[].type` / `return_type`: raw `TypeAnnotation.text` (source-text
  strings — e.g. `"Result<int, string>"`), `return_type` null when absent.
- `effects`: `FunctionSignature.effects`, re-sorted alphabetically for stability
  (they should already be canonical per `effect_taxonomy.sfn`).
- `parse_failures`: sorted array of `{ "path": "...", "reason": "..." }` for any
  enumerated source that failed to parse — keeps default enumeration
  best-effort **and** deterministic/diagnosable (a broken capsule contributes 0
  symbols but is visible, rather than silently vanishing or aborting the whole
  index).

### 3.4 Determinism strategy

Total order over `symbols`: sort by the tuple `(origin, import_path, name,
signature)` where `origin` orders `prelude` before `capsule`, and a null
`import_path` sorts as the empty string. `(origin, import_path, name)` is
already effectively total (a module cannot define two `fn` of the same name),
and `signature` is a defensive final tie-breaker. `parse_failures` sorts by
`path`. `effects` arrays sort alphabetically. Capsule enumeration itself sorts
manifest slugs before parsing, so even the `parse_failures` ordering is
input-order-independent. Given fixed compiler + source bytes, the encoder is a
pure function of sorted data → byte-identical across runs.

### 3.5 Error model

- **Exit codes:** `0` success; `1` for a resolved-operation failure (unresolved
  `--capsule` slug). A single stable nonzero (`1`) keeps the contract simple;
  document it.
- **Structured error envelope** (still stamps schema + version so consumers can
  parse errors the same way):

```json
{
  "schema_version": "sailfin-symbols/1",
  "compiler_version": "0.5.0-alpha.NN+dev.<hash>",
  "error": {
    "code": "E_SYMBOLS_UNRESOLVED_CAPSULE",
    "message": "capsule 'sfn/nope' could not be resolved",
    "capsule": "sfn/nope"
  }
}
```

- **v1 filter surface (minimum that satisfies "invalid filters return
  machine-readable errors"):** exactly one filter, `--capsule <slug>`. An
  unresolvable slug → `E_SYMBOLS_UNRESOLVED_CAPSULE`, exit `1`. This single
  filter exercises the entire error contract without over-building name/kind
  filters (the issue calls filtering "implied but not central"). `--json` is
  the only output mode in v1; a bare `sfn symbols` with no `--json` may either
  default to `--json` or print a short "use --json" notice — recommend
  **default to JSON** so the command has one behavior.

## 4. Effect & capability impact

No effect-system change. `run(matches, ctx) -> int ![io]` (it reads files and
prints); the collection core in `symbols_index.sfn` is pure except the
`parse_program` call chain, which is `![io]`. The command reports effects it
discovers on target symbols (from `FunctionSignature.effects`) but does not
itself introduce or gate any new capability. The command requires no capability
beyond `![io]` for source discovery.

## 5. Self-hosting impact

Passes touched: **CLI dispatch** (`cli/main.sfn`), **parser** (consumed, not
changed — `parse_program`), **AST** (consumed, not changed). No lexer, type
checker, effect checker, emitter, or LLVM-lowering change. The new modules are
leaf consumers; the parser gains no back-edge to them. The capability and its
sole consumer ship in one PR, so `make compile` self-hosts the whole thing from
the current pinned seed with no seed cut (`.claude/rules/seed-dependency.md`).

## 6. Alternatives considered

- **Read `.sfn-asm` artifacts (`interfaces_from_native_artifact`) instead of
  parsing source.** Rejected: artifacts are build outputs that need not exist,
  making the command fail on a fresh toolchain; source is always present and
  canonical. (The artifact path remains a valid future optimization if parse
  cost ever matters.)
- **Include the intrinsic registry (`runtime_helper_descriptors`).** Rejected
  for v1: ABI-level `*u8`/`i64` symbols are not user-callable and pollute the
  "how do I call this" answer. Reserved as `kind:"intrinsic"`.
- **Import `sfn/json` for encoding.** Rejected: adds a capsule dependency to the
  compiler build and cedes field-order/determinism control; hand-rolled matches
  `diagnostics_json.sfn` precedent and guarantees byte-stability.
- **Name-only scan (`prelude_global_names_from_source`).** Rejected: yields no
  signatures/effects, failing "how to call it."
- **Rich filter grammar (`--name`, `--kind`, `--effect`).** Deferred: one
  `--capsule` filter satisfies the error-path criterion; more is scope creep.

## 7. Stage1 readiness mapping

- [ ] Parses — N/A (no new syntax; consumes existing parser)
- [ ] Type-checks / effect-checks — N/A (no new construct)
- [ ] Emits valid `.sfn-asm` — N/A
- [ ] Lowers to LLVM IR — N/A
- [x] Regression coverage — unit (`symbols_index`) + e2e (`sfn symbols --json`)
- [x] Self-hosts — `make compile` green, one-PR bundle, no seed cut
- [x] `sfn fmt --check` clean — on all touched `.sfn`
- [x] Documented — `reference/cli.md`, new `docs/reference/symbols-json-schema.md`,
      `docs/status.md`

(The first four are marked N/A because this is a tooling command, not a language
feature — it adds no syntax or IR.)

## 8. Test plan

- `compiler/tests/unit/symbols_index_test.sfn` (pure, in-process): feed a fixed
  source string containing `ascii_uppercase`/`parse_int`-shaped functions to the
  collection + encoder core; assert (a) the rendered signature and `import_path`
  are correct, (b) sort order is total/stable, (c) two encode calls on the same
  data are byte-identical, (d) `_`-prefixed functions are excluded.
- `compiler/tests/e2e/symbols_json_test.sfn` (subprocess, mirrors
  `check_json_schema_test.sfn`): `process.run_capture([_sfn_bin(), "symbols",
  "--json"], env)`; assert the raw JSON contains `sailfin-symbols/1`, a
  `compiler_version`, `"sfn/strings"`, `"ascii_uppercase"`, and the
  `Result<int, string>` return type for `parse_int`; run it **twice** and assert
  byte-equality; run `symbols --json --capsule sfn/nope` and assert nonzero exit
  + `E_SYMBOLS_UNRESOLVED_CAPSULE` in output.
- `compiler/tests/integration/cli_symbols_command_test.sfn` (in-process, mirrors
  `cli_version_command_test.sfn`): build the root `Command`, `parse(["symbols",
  "--json", "--capsule", "sfn/nope"])`, call `run` directly, assert the returned
  int is `1`.

## 9. References

- Linear `SFN-444`.
- Precedent: `compiler/src/diagnostics_json.sfn` (`sailfin-check/1` envelope),
  `docs/reference/check-json-schema.md`.
- CLI structure: `compiler/src/cli/main.sfn`, `compiler/src/cli/commands/*.sfn`,
  `compiler/src/cli/context.sfn`; deep-nesting miscompile note (#1773).
- Symbol sources: `runtime/prelude.sfn`, `capsules/sfn/strings/src/mod.sfn`,
  `compiler/src/prelude_globals.sfn` (`_pg_find_runtime_dir`),
  `compiler/src/capsule_resolver.sfn` (`_cr_capsule_source_dir`).
- AST: `compiler/src/ast.sfn` (`Program`, `FunctionSignature`, `Parameter`,
  `TypeAnnotation`); `compiler/src/parser/mod.sfn` (`parse_program`).
- Seed policy: `.claude/rules/seed-dependency.md` (one-PR bundle, no seed cut).

## 10. Implementation notes (as shipped)

Two deliberate v1 simplifications differ from the illustrative examples above;
`docs/reference/symbols-json-schema.md` documents the shipped shape exactly:

- **`signature` has no `fn ` prefix.** The shipped renderer emits
  `ascii_uppercase(text: string) -> string` (name + params + return + effects),
  not `fn ascii_uppercase(...)`. The index describes a symbol, not a declaration;
  the `import_path`/`form` fields carry the "how to call it" story.
- **`--capsule <slug>` filters the enumerated in-tree set** rather than routing
  through `_cr_capsule_source_dir`. On an in-tree checkout (where acceptance
  runs) this resolves every `sfn/*` capsule; on an installed toolchain with no
  `capsules/` tree, a named `--capsule` lookup is unavailable and returns the
  `E_SYMBOLS_UNRESOLVED_CAPSULE` error. Wiring the cache-aware resolver is a
  clean follow-up. `parse_failures` ships as an array of source-path strings
  (not `{path, reason}` objects) — the path localizes the failure and keeps the
  array trivially sortable.

The rest of the design — parse-source collection for both prelude and capsules,
the hand-rolled `sailfin-symbols/1` envelope, the total-order determinism
strategy, and the one-PR/no-seed-cut bundling — shipped as designed.
