# Colon Type Annotations Migration Plan

**Status:** Proposed
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

## Emitter Updates (Post-Migration)

After all source files are migrated, update the emitters to output `:` for
annotation positions:

1. **`compiler/src/emitter_sailfin_expr.sfn:25`** — `format_type_annotation()`
   currently hardcodes `" -> "`. Change to `": "` for parameter/variable/field
   annotations.

2. **`compiler/src/emit_native_format.sfn:279`** — IR emitter writes `" -> "` for
   parameters. Update to `": "`.

3. **`compiler/src/native_ir_utils_parse.sfn:761`** — IR parser only recognizes
   `"->"`. Update to accept both, then prefer `":"`. These two changes (emitter +
   parser) must land atomically.

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
