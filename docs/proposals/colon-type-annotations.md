# Colon Type Annotations Migration Plan

**Status:** Phases 1–6 implemented (migration complete).
**Roadmap ref:** [sailfin.dev/roadmap](https://sailfin.dev/roadmap) — Syntax reform (pre-1.0)
**Date:** 2026-04-15

## Summary

Replace `->` with `:` in parameter, variable, and struct/enum field type
annotation positions. Function return types keep `->`.

```sfn
// Before
fn add(x -> number, y -> number) -> number {
    let result -> number = x + y;
    return result;
}

struct Point {
    x -> number;
    y -> number;
}

// After
fn add(x: number, y: number) -> number {
    let result: number = x + y;
    return result;
}

struct Point {
    x: number;
    y: number;
}
```

## Rationale

- `->` for "has type" conflicts with its universal meaning of "returns/maps-to"
- Every mainstream typed language (TypeScript, Rust, Python, Kotlin, Swift, Zig)
  uses `:` for annotations
- The current syntax is the single most likely reason a new user bounces
- LLMs have zero `.sfn` training data; conventional syntax reduces generated
  code error rates

## Current State

### Parser enforces separator roles

`consume_annotation_separator()` in `compiler/src/parser/declarations.sfn`
accepts only `:` for parameter, variable, and field annotations.
`consume_return_type_separator()` in the same file accepts only `->` for
function return types. `expression_tokens_consume_type_separator()` in
`compiler/src/parser/expressions.sfn` uses boolean flags `accept_colon` and
`accept_arrow` to select the correct separator per context.

The AST does not store which separator was parsed — it is discarded at parse
time. Both annotation and return-type positions produce identical ASTs and
the rest of the pipeline (type checker, effect checker, emitter, LLVM
lowering) is agnostic to the separator.

### Three files already migrated

17 function parameter annotations in `compiler/src/llvm/lowering/` already use
`:` and compile successfully, confirming end-to-end compatibility:

- `lowering_phase_imports.sfn` (3 functions)
- `lowering_phase_sanitize.sfn` (9 functions)
- `lowering_phase_types.sfn` (5 functions)

### Seed compatibility confirmed

The current seed binary (v0.5.0-alpha.22+) uses the same dual-accepting parser.
Migrated source files compile with the seed immediately — no bootstrap risk.

## Migration Surface

| Category | Files | Annotations to change |
|---|---|---|
| Compiler source (`compiler/src/`) | 120 `.sfn` | ~5,877 |
| Tests (`compiler/tests/`) | 69 `.sfn` | ~1,055 |
| Examples (`examples/`) | 51 `.sfn` | ~98 |
| Runtime (`runtime/`) | 1 `.sfn` | ~67 |
| Docs (code samples) | 6 `.md` | ~30 samples |
| **Total** | **~241 files** | **~7,100 annotations** |

### Three categories of `->` that change

1. **Function parameters:** `fn foo(param -> Type)` becomes `fn foo(param: Type)`
2. **Variable declarations:** `let [mut] name -> Type = ...` becomes
   `let [mut] name: Type = ...`
3. **Struct/enum fields:** `field -> Type;` becomes `field: Type;`

### What does NOT change

- **Return types:** `fn foo() -> Type` stays as `->` (universal convention)
- **`->` inside string literals:** ~35 occurrences (e.g., `"->"` in parser code)
- **`->` inside comments:** ~12 occurrences (e.g., path descriptions)
- **`.sfn-asm` IR format:** internal format, updated separately

## Migration Script Design

The script (`scripts/migrate_colon_annotations.py`) performs a context-aware
find-and-replace on `.sfn` files. It must distinguish three `->` contexts:

### Patterns that change (annotation `->`)

```
# Function parameters (inside parentheses)
fn foo(name -> Type, other -> Type) -> ReturnType
         ^^                ^^          (change these)

# Variable declarations
let name -> Type = value;
let mut name -> Type = value;
         ^^     (change these)

# Struct/enum fields (indented, inside braces)
struct Foo {
    field -> Type;
          ^^ (change this)
}
```

### Patterns that stay (return type `->`)

```
fn foo() -> Type        # after ) or effect list
fn foo() ![io] -> Type  # after effect annotation
```

### Patterns to skip entirely

```
"string containing -> arrow"   # inside string literals
// comment with -> arrow        # inside line comments
```

### Algorithm

1. Parse each line tracking string literal state (inside `"..."` or not)
2. Skip lines that are pure comments
3. For lines containing `->` outside strings:
   a. If it matches `let [mut] <name> -> <Type>` — replace with `:`
   b. If it matches `<name> -> <Type>` inside a parameter list — replace with `:`
   c. If it matches `) -> <Type>` or `] -> <Type>` or effect list `-> <Type>` — keep as `->`
4. Report a summary of changes per file

## Emitter Updates (Phase 5 — Complete)

All emitters now output `:` for annotation positions. The IR parsers accept
both `:` (preferred) and `->` (fallback) for backward compatibility with any
cached IR. The earliest valid separator is selected to handle function types
containing `:` in cached `->` IR (e.g., `handler -> fn(req: Request) -> Response`).

**Sailfin source emitter:**

- `compiler/src/emitter_sailfin_expr.sfn` — `format_type_annotation()` returns
  `": " + text`; `format_return_type_annotation()` returns `" -> " + text`.
- `compiler/src/emitter_sailfin.sfn` — field and parameter rendering uses `": "`.

**Native IR emitter:**

- `compiler/src/emit_native_format.sfn` — parameter and field in `.sfn-asm`.
- `compiler/src/emit_native.sfn` — `.param` metadata.
- `compiler/src/llvm/rendering_helpers.sfn` — interface parameter rendering.

**Native IR parsers** (accept both, earliest wins):

- `compiler/src/native_ir_utils_parse.sfn` — `parse_struct_field_line`,
  `parse_enum_variant_field`, `parse_parameter_entry`.
- `compiler/src/llvm/lowering/lowering_recovery.sfn` — recovery parser for
  `.param` and `.field` lines.

## Parser Finalization (Phase 6 — Complete)

The shared `consume_type_separator()` was split into:

- `consume_annotation_separator()` — accepts only `:` (parameters, variables,
  struct/enum fields)
- `consume_return_type_separator()` — accepts only `->` (function, pipeline,
  tool return types)

All 14 call sites in `declarations.sfn` and 2 in `expressions.sfn` were
updated. `->` is now a parse error in annotation position and `:` is a parse
error in return-type position.

## Execution Plan

### Phase 1: Migration script

Write and test `scripts/migrate_colon_annotations.py`. Validate on a few files
manually before running on the full codebase.

### Phase 2: Compiler source migration

1. Run script on `compiler/src/`
2. Run `make compile` (critical self-hosting gate)
3. Fix any edge cases
4. Run `make test`

### Phase 3: Tests, examples, runtime

1. Run script on `compiler/tests/`, `examples/`, `runtime/`
2. Run `make test`

### Phase 4: Documentation

1. Update code samples in the language spec (`site/src/content/docs/docs/reference/spec/`), `docs/status.md`, `roadmap.astro`, `style-guide.md`
2. Update EBNF in `site/src/content/docs/docs/reference/grammar.md`
3. Remove "syntax reform" callout boxes that describe this as pending
4. Mark checkbox in `roadmap.md`

### Phase 5: Emitter updates

1. Update `format_type_annotation()` to emit `": "`
2. Update `.sfn-asm` emitter and parser atomically
3. Run `make compile && make test`

### Phase 6: Parser split (separate PR)

1. Split `consume_type_separator` into `consume_annotation_sep` / `consume_return_sep`
2. Run `make compile && make test`

## Risk Assessment

| Risk | Likelihood | Mitigation |
|---|---|---|
| Script corrupts a file | Low | Git diff review before committing; dry-run mode |
| Return type `->` accidentally changed | Medium | Pattern requires `) ->` or `] ->` or effect `->` to stay |
| `->` inside string literal changed | Low | String-aware parsing in script |
| Self-hosting break during migration | Very low | Parser accepts both; migrate incrementally |
| Seed can't compile migrated source | None | Seed uses same dual-accepting parser |

## Effort Estimate

| Phase | Effort |
|---|---|
| Migration script | 1-2 hours |
| Compiler source + validation | 1-2 hours |
| Tests/examples/runtime | 30 min |
| Docs | 30 min |
| Emitter updates | 30 min |
| Parser split (optional) | 1 hour |
| **Total** | **4-6 hours** |

## Lessons Learned (Phases 1–4)

Captured during execution to inform the deferred follow-ups.

### Capsule directory was missing from the original migration scope

The proposal table listed `compiler/src`, `compiler/tests`, `examples`, and
`runtime`, but omitted `capsules/` (18 files, 702 annotations). Always include
`capsules/` in any tree-wide refactor; it is a first-class part of the code
under self-hosting.

### Same-named struct + capsule resolution = SIGSEGV (resolved by relocation)

Originally `compiler/tests/unit/layers_test.sfn` was renamed to
`nn_layers_test.sfn` to work around a compiler crash: the test file shared
its base name with the capsule `sfn/layers`, both defined a `Linear`
struct, and all-colon annotations on both crashed the compiler.

The capsule-test reorganization (May 2026) made the workaround unnecessary:
all capsule-flavored tests now live under `capsules/<scope>/<name>/tests/`,
where the auto-resolve heuristic that triggered the crash does not fire.
Verified on `0.5.10-alpha.9` — a same-name `Linear` struct in
`capsules/sfn/layers/tests/layers_test.sfn` compiles cleanly. The bug shape
no longer has a live reproducer; if it resurfaces, add a regression test
under `compiler/tests/unit/` matching the original `<capsule-name>_test.sfn`
pattern.

### Capsule-flavored unit tests have moved to their capsules

Done. `compiler/tests/unit/{layers,nn,tensor,losses,math,path,toml,fmt,
json_structs}_test.sfn` were moved to `capsules/sfn/<name>/tests/`, run via
the new `make test-capsules` target. Helpers stay inlined for now — see the
header comment in each moved file for the follow-ups blocking a switch to
`import { ... } from "../src/mod"`. Briefly:

- Importing capsule functions that internally iterate arrays surfaces a
  duplicate-`declare round` LLVM error in the test module.
- The runtime `floor`/`round`/`_truncate` chain that array indexing relies
  on returns wrong values for some inputs.

### Migration script is one-way and was deleted

`scripts/migrate_colon_annotations.py` was used once on each path and is not
needed again. It was deleted in this PR. If a future tree-wide refactor
needs a similar tool, write a fresh one — keeping single-use scripts in tree
just creates rot.
