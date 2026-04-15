# Colon Type Annotations Migration Plan

**Status:** Phases 1–6 implemented (migration complete).
**Roadmap ref:** `docs/roadmap.md` Section 0 — Syntax reform (breaking, do first)
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

### Parser already accepts both forms

`consume_type_separator()` in `compiler/src/parser/declarations.sfn:88` and
`expression_tokens_consume_type_separator()` in
`compiler/src/parser/expressions.sfn:78` both accept `:` and `->` interchangeably
via the shared `TypeSep = "->" | ":"` rule.

The AST does not store which separator was parsed — it is discarded at parse
time. This means both forms produce identical ASTs and the rest of the pipeline
(type checker, effect checker, emitter, LLVM lowering) is agnostic to the
separator.

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

## Emitter Updates (Phase 5 — Deferred to Follow-up Branch)

After all source files are migrated, update the emitters to output `:` for
annotation positions. The actual surface is larger than the original three call
sites and must be changed atomically with the IR parser to preserve
self-hosting:

**Sailfin source emitter** (`fn`/struct rendering for diagnostics, formatter, etc.):

- `compiler/src/emitter_sailfin_expr.sfn:25` — `format_type_annotation()`. Used
  for both annotations (params/vars) and return types; needs to be split into
  `format_type_annotation` (`:`) and `format_return_type_annotation` (`->`),
  with the lambda return-type call site (line 149) updated.
- `compiler/src/emitter_sailfin.sfn:682,726` — field and parameter rendering.
  Line 667 is a return type and stays as `->`.

**Native IR emitter** (`.sfn-asm` text format):

- `compiler/src/emit_native_format.sfn:279,318` — parameter and field
  declarations in the IR. Line 253 is a return type and stays as `->`.
- `compiler/src/emit_native.sfn:799` — parameter declaration in the alternate
  IR emitter.
- `compiler/src/llvm/rendering_helpers.sfn:265` — parameter rendering used
  during LLVM lowering. Line 237 is a return type and stays as `->`.

**Native IR parsers** (must accept the new `:` form, ideally tolerating `->`
for any cached IR):

- `compiler/src/native_ir_utils_parse.sfn:761` — main `.sfn-asm` parameter
  parser.
- `compiler/src/llvm/lowering/lowering_recovery.sfn:178,195,579` — recovery
  parser used when the structured parser bails out. Method/parameter/field
  arrow lookups must accept both separators.

**Test fixtures and assertions** that currently embed the IR text format:

- `compiler/tests/unit/data/stage2/metadata.sfn-asm` — golden IR fixture.
- `compiler/tests/unit/emit_native_format_test.sfn:147,154` — hardcoded
  `"x -> number"` and `"mut x -> number"` assertions.

Self-hosting validation: emitter and parser changes must be in the same
commit, validated by `make clean-build && make check`. Because the IR is
regenerated from source on each build (not persisted across builds), the
new emitter/parser pair only needs to be self-consistent — there is no
on-disk legacy IR to migrate.

## Parser Finalization (Optional, Separate PR)

After migration is complete and all source uses `:`, split the shared
`TypeSep` rule:

- `AnnotationSep = ":"` — for parameters, variables, fields
- `ReturnSep = "->"` — for function return types
- Make `->` a parse error in annotation position
- Make `:` a parse error in return-type position

This is a cleanup step, not a prerequisite for migration.

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

1. Update code samples in `spec.md`, `status.md`, `roadmap.md`, `style-guide.md`
2. Update EBNF in `docs/enbf.md`
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

### Same-named struct + capsule resolution = SIGSEGV

Renamed `compiler/tests/unit/layers_test.sfn` →
`compiler/tests/unit/nn_layers_test.sfn` to work around a compiler crash. The
test file shares its base name with the capsule `sfn/layers`, and both define
a `Linear` struct. Bisection findings:

- All-colon test struct + all-colon capsule struct → SIGSEGV during
  compilation of the test file (compiler dies, never reaches user-code
  execution).
- Reverting **any single field** in the test's struct from `:` to `->` makes
  it pass.
- Renaming the test file (identical content) makes it pass — even with both
  files using all colons.
- Issue does **not** reproduce in a minimal `/tmp/` test with the same struct
  shape.

The compiler appears to auto-resolve `compiler/tests/unit/<name>_test.sfn`
against capsule `sfn/<name>` when the names align, and the resulting
duplicate-symbol path crashes instead of producing a clean diagnostic. The
crash predates this migration but was not exercised because pre-migration
both definitions used arrows.

### Capsule-flavored unit tests should move to their capsules

`compiler/tests/unit/{layers,nn,tensor,losses}_test.sfn` and similar are
exercising capsule functionality, not language features per se. The
long-term home for these is alongside the capsule (`capsules/sfn/layers/tests/`,
etc.), reached by per-capsule test infrastructure that does not yet exist.
The rename above is a temporary workaround. Do not move these tests until
the capsule-test infra exists, or coverage will silently drop. When moves
happen, draft new compiler-focused regression tests that re-cover whichever
language behavior the moved tests were incidentally validating (e.g., the
duplicate-name segfault case above).

### Migration script is one-way and was deleted

`scripts/migrate_colon_annotations.py` was used once on each path and is not
needed again. It was deleted in this PR. If a future tree-wide refactor
needs a similar tool, write a fresh one — keeping single-use scripts in tree
just creates rot.
