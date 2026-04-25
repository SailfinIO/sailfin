# Architecture: `sfn check` — Fast Analysis Without Codegen

Status: Shipped (initial v1 — parse + typecheck + effect-check, default stderr rendering, `--quiet`)
Date: April 15, 2026 (design); shipped April 18, 2026; A1 (cross-module conformance hookup) shipped April 25, 2026; A2 (resolver wiring) shipped April 25, 2026; A3 (Phase 1 diagnostic infrastructure — severity + file_path on Diagnostic, structured load warnings) shipped April 25, 2026
Parent: [docs/proposals/tooling.md](../proposals/tooling.md)

## Implementation Status

The initial implementation ships in `compiler/src/tools/check.sfn` and is wired
into the CLI as `sfn check`. Covered by `compiler/tests/unit/check_tool_test.sfn`.

### Continuation: Track A — retire textual import inlining

Track A migrates `sfn check` off the legacy textual inliner so it can share
the unified resolver introduced in Stage B PR1 of the build architecture
(`docs/proposals/build-architecture.md`). The track splits into four
sub-PRs:

- **A1 — typechecker hookup (shipped April 25, 2026).**
  New leaf module `compiler/src/typecheck_imports.sfn` converts
  `NativeInterface` descriptors (extracted from `.sfn-asm` import-context
  artifacts) into `Statement.InterfaceDeclaration` values the typechecker
  understands. New entry point `typecheck_diagnostics_with_imports(program,
  imported_interfaces)` accepts that converted list and concatenates it
  onto the program's local interface set before running
  `check_program_scopes`. The original `typecheck_diagnostics(program)`
  becomes a one-line wrapper that calls the new entry with `[]`. Coverage:
  16 unit tests in `compiler/tests/unit/typecheck_imports_test.sfn`. The
  empty-imports path is exercised on every module during selfhost; the
  stage2/stage3 fixed-point holds.
- **A2 — resolver wiring (shipped April 25, 2026).** New module
  `compiler/src/typecheck_import_loader.sfn` exports
  `interfaces_from_native_artifact(text)` (pure) and
  `load_imported_interfaces_from_paths(paths) ![io]` returning
  `ImportedInterfaceLoadResult { interfaces, missing_paths,
  skipped_paths }`. `compiler/src/capsule_resolver.sfn` gains
  `prepare_project_capsules_for_check(input_path) ->
  CheckCapsuleResolution` — same enumerate + dedupe + stage as
  `prepare_project_capsules`, but stops before
  `compile_capsule_modules` so no `.ll` is emitted (check-mode is
  `O(stage)` not `O(stage + lower)`). `compiler/src/tools/check.sfn`
  exposes `check_source_with_imports(source, file_path,
  imported_interfaces)` and `check_source` delegates with `[]`.
  `compiler/src/cli_check.sfn` no longer imports
  `inline_imports_for_source`; one resolver pass anchored on
  `files[0]` loads imports once and reuses the converted
  `Statement[]` across every file in the run. Slug collisions /
  staging failures return exit code 2 (setup error) to match
  check-architecture.md's documented contract. Coverage:
  `compiler/tests/e2e/test_check_cross_module_conformance.sh`.
- **A3 — diagnostic enhancement (shipped April 25, 2026).** The
  `Diagnostic` struct now carries `severity: string` ("error" |
  "warning" | "hint" | "info") and `file_path: string` directly. All
  six factories in `compiler/src/typecheck_types.sfn` plus the inline
  literal in `effect_violation_to_diagnostic` populate the new fields;
  severity is hardcoded to `"error"` at every factory. The renderer
  in `compiler/src/tools/check.sfn` drops its `file_path` parameter
  and reads `d.severity` / `d.file_path` from the struct, with a
  post-hoc stamping pass in `check_source_with_imports` writing the
  originating module path onto each diagnostic before rendering.
  `cli_check.sfn:_emit_load_warnings` was rewritten to emit
  `Diagnostic { code: "W0001"|"W0002", severity: "warning", ... }`
  and route through `render_diagnostic` with `kind="load"`. Coverage:
  21 unit tests in `compiler/tests/unit/check_tool_test.sfn`
  (including seven new tests guarding severity prefix invariance,
  file_path on the location-only branch, and W01xx code distinctness).
  Phase 2 features (`secondary` source locations,
  `FixSuggestion`/`TextEdit`) remain deferred — they land alongside
  `sfn fix` / `sfn lsp`.
- **A4 — delete legacy helpers.** Remove `inline_imports_for_source`,
  `_inline_relative_imports_cmd`, and `_is_stdlib_capsule_cmd` once
  the test path (Stage B PR2's `sfn test` migration) lands too.

### Still deferred to a follow-up

- Fix-it suggestion edits (Phase 2 — `FixSuggestion`/`TextEdit` structs).
- Source spans on effect violations — `EffectViolation` does not
  carry tokens today, so effect diagnostics still ship with
  `primary: null`. Plumbing tokens through `effect_checker.sfn` is
  tracked as a separate workstream.
- Harmonising `format_typecheck_diagnostic` in `main.sfn` (used by
  full-build `report_typecheck_errors`) with the `sfn check`
  renderer. A3 left it untouched to keep scope tight.
- `make check-fast` target and CI pre-build wiring.
- Parallel / cached multi-file checking.
- `--json` output (LLM Adoption Strategy lever #3 — see CLAUDE.md).


## Overview

`sfn check` runs the compiler's analysis passes (parse, typecheck, effect
check) without emitting `.sfn-asm` IR, LLVM IR, or invoking `clang`. It
returns diagnostics in seconds rather than the 13-16 minutes a full
`make compile` takes. This document covers the architecture, the prerequisite
diagnostic infrastructure enhancement, implementation plan, and how `sfn check`
becomes the foundation for `sfn vet`, `sfn fix`, and `sfn lsp`.

## CLI Interface

```
sfn check [--quiet] [path...]
```

| Invocation | Behavior |
|---|---|
| `sfn check file.sfn` | Check a single file, report diagnostics to stderr |
| `sfn check dir/` | Recursively check all `.sfn` files under `dir/` |
| `sfn check .` | Check all `.sfn` files in the current directory tree |
| `sfn check` | Same as `sfn check .` |
| `sfn check --quiet file.sfn` | Exit code only; suppress diagnostic output |

Exit codes: 0 = no diagnostics, 1 = one or more diagnostics found,
2 = setup error (bad arguments, missing path, slug collision in the
project's capsule graph, or `stage_capsule_imports` failure). The
common thread for exit 2 is "the command could not run analysis at
all"; it is distinct from "analysis ran and found problems" (exit 1).

Multiple paths can be given: `sfn check compiler/src/ runtime/prelude.sfn`.

### Output Format

Diagnostics are printed to stderr, one per file, using the same format the
compiler already uses for typecheck errors:

```
[check] compiler/src/foo.sfn
[typecheck] duplicate function `bar` declared
             --> line 12, column 5
              |
           12 | fn bar() {
              |    ^^^
[effect] function `process` is missing required effects
          --> line 30, column 1
           |
         30 | fn process(data: Data) {
           |    ^^^^^^^
         missing: ![io, net]
         required by:
           - `fs.readFile` requires ![io]
           - `http.get` requires ![net]
         suggestion: fn process(data: Data) ![io, net] {
```

The `[check]` prefix gives the file path. Each diagnostic gets a `[typecheck]`
or `[effect]` prefix indicating which pass produced it. This makes it trivial
to grep for specific error classes.

### Summary Line

After all files are checked, a summary is printed to stdout:

```
checked 120 files: 3 errors, 2 warnings
```

Or on success:

```
checked 120 files: ok
```

## What Gets Checked

`sfn check` runs three analysis stages in sequence. Each stage runs to
completion regardless of earlier failures — all diagnostics are collected,
not just the first error.

### Stage 1: Parse

Call `parse_program(source)` after import inlining. The parser currently
does not produce diagnostics — it returns a partial AST and silently drops
unparsable statements. Parse-stage errors are a future enhancement (see
"Future Considerations").

**Current behavior:** If the parser can't handle the input, the typechecker
will catch downstream issues (e.g., a malformed function will be missing from
the symbol table, and calls to it will fail type checking).

### Stage 2: Type Check

Call `typecheck_diagnostics(program)` on the parsed AST. This currently
catches:

| Check | Error Code | Description |
|---|---|---|
| Duplicate symbols | `E0001` | Two declarations with the same name at the same scope |
| Missing interface members | `E0301` | Struct implements interface but lacks a required method |
| Interface type argument mismatch | `E0302` | Wrong number/type of generic arguments on `implements` |
| Scope violations | various | Variables used outside their declaring scope |

The type checker returns `Diagnostic[]`. Each diagnostic has a `code`,
`message`, and optional `primary` token for source location.

### Stage 3: Effect Check

Call `validate_effects(program)` on the parsed AST. This catches:

| Check | Description |
|---|---|
| Missing effect declaration | Function calls effectful APIs without declaring `![effect]` |
| Decorator-implied effects | `@logExecution` or `@trace` require `![io]` but function doesn't declare it |
| Transitive effect requirements | Calling a function that requires `![io]` means the caller must also declare `![io]` |

The effect checker returns `EffectViolation[]` — a different type than
`Diagnostic`. Each violation identifies the routine name, missing effects,
and the specific requirements that triggered the violation.

**Key insight:** The effect checker currently exists (`effect_checker.sfn`)
but is **not called** in the main compilation pipeline (`main.sfn`). Effect
checking runs during the test suite but not during `sfn build` or `sfn emit`.
`sfn check` is the right place to wire it in as a first-class pass, giving
developers fast effect validation without a full build.

## Architecture

### Component Diagram

```
                            sfn check file.sfn
                                   │
                            ┌──────▼──────┐
                            │  CLI Layer   │
                            │  (dispatch,  │
                            │   flags,     │
                            │   file I/O)  │
                            └──────┬──────┘
                                   │
                      ┌────────────▼────────────┐
                      │    Import Resolution     │
                      │  inline_imports_for_     │
                      │  source(src, base_dir)   │
                      └────────────┬────────────┘
                                   │ combined source
                      ┌────────────▼────────────┐
                      │         Parser           │
                      │  parse_program(source)   │
                      │  → Program               │
                      └────────────┬────────────┘
                                   │ AST
                    ┌──────────────┼──────────────┐
                    ▼                              ▼
          ┌─────────────────┐            ┌─────────────────┐
          │   Type Checker   │            │  Effect Checker  │
          │  typecheck_      │            │  validate_       │
          │  diagnostics()   │            │  effects()       │
          │  → Diagnostic[]  │            │  → EffectViol[]  │
          └────────┬────────┘            └────────┬────────┘
                   │                              │
                   └──────────────┬───────────────┘
                                  │ all diagnostics
                      ┌───────────▼───────────┐
                      │   Diagnostic Renderer  │
                      │   format & print       │
                      │   to stderr            │
                      └───────────┬───────────┘
                                  │
                              exit code
```

### Key Architectural Decisions

**1. Reuse existing passes — no new analysis logic.**

`sfn check` is purely orchestration. It calls the same `parse_program`,
`typecheck_diagnostics`, and `validate_effects` that the compiler uses.
No new checking logic is introduced. This means `sfn check` automatically
benefits from any improvements to the type checker or effect checker.

**2. Run all passes regardless of earlier failures.**

Unlike `compile_to_llvm` in `main.sfn` which early-exits on typecheck
errors, `sfn check` runs both type checking AND effect checking regardless.
This gives developers the full picture in one run rather than fix-one-
recheck-find-next cycles.

**3. Import inlining is required.**

The type checker operates on a single `Program` AST — it has no concept of
multi-file resolution. Each file must be inlined via
`inline_imports_for_source()` before checking. This is the same flow that
`sfn test` and `sfn run` use today.

**4. Effect violations are normalized to `Diagnostic`.**

The effect checker returns `EffectViolation[]`, not `Diagnostic[]`. The
check command normalizes these into the `Diagnostic` type before rendering.
This keeps the renderer simple and prepares for the unified diagnostic
infrastructure that `sfn vet`, `sfn fix`, and `sfn lsp` will share.

## Diagnostic Infrastructure Enhancement

A3 shipped Phase 1: `severity` and `file_path` fields on
`Diagnostic`, plus structured warnings on the load/staging layer.
Phase 2 (`secondary`, `suggestion`) is still deferred and lands
alongside `sfn fix` / `sfn lsp`.

### Phase 1 — Shipped (April 25, 2026)

```sfn
// compiler/src/typecheck_types.sfn
struct Diagnostic {
    code: string;        // "E0001", "E0301", "W0001", ...
    severity: string;    // "error" | "warning" | "hint" | "info"
    message: string;
    file_path: string;   // originating module path; "" until stamped
    primary: Token?;     // source location (or null for spans the
                         // producer can't carry — e.g. effect
                         // violations until EffectViolation gains
                         // tokens)
}
```

The renderer in `compiler/src/tools/check.sfn` reads `severity` and
`file_path` from the struct directly. `check_source_with_imports`
runs a post-hoc stamping pass over typecheck and effect diagnostics
to populate `file_path` before rendering. `_emit_load_warnings` in
`cli_check.sfn` emits structured `W01xx` warnings through the same
renderer.

### What Phase 1 still lacks

- Severity levels are present; `secondary` and `suggestion` are not.
- No `SourceLocation` struct yet (primary is still `Token?`).
- No fix-it suggestions ("add `![io]` to function signature").
- No structured source spans for multi-line annotations.

### Target State (Phase 2 — deferred)

```sfn
struct Diagnostic {
    code: string;
    severity: string;          // "error" | "warning" | "hint" | "info"
    message: string;
    file_path: string;         // Source file path (empty for inlined)
    primary: SourceLocation?;
    secondary: SourceLocation[];
    suggestion: FixSuggestion?;
}

struct SourceLocation {
    token: Token?;
    label: string;             // "first defined here", "this call requires ![io]"
}

struct FixSuggestion {
    message: string;           // "add ![io] to function signature"
    edits: TextEdit[];
}

struct TextEdit {
    start_line: number;
    start_column: number;
    end_line: number;
    end_column: number;
    replacement: string;
}
```

### Enhancement Strategy: Two Phases

**Phase 1 (shipped April 25, 2026 in A3):** `severity` and `file_path`
on `Diagnostic`. All six factories in `typecheck_types.sfn` and the
inline literal in `tools/check.sfn` populate the new fields; severity
is hardcoded to `"error"` at every factory (the only `"warning"`
producers today are the W01xx load-warning literals in
`cli_check.sfn:_emit_load_warnings`, which build Diagnostic literals
directly). The renderer in `tools/check.sfn` dropped its `file_path`
parameter and reads from the struct. A post-hoc stamping pass in
`check_source_with_imports` writes the originating module path onto
each diagnostic before rendering.

**Phase 2 (deferred, blocks `sfn fix` / `sfn lsp`):** Add
`secondary: SourceLocation[]` and `suggestion: FixSuggestion?`. This
phase requires the `SourceLocation`, `FixSuggestion`, and `TextEdit`
struct definitions. ~200 lines of new type definitions plus ~400
lines to update producers to emit secondary spans and suggestions.

### Effect Violation → Diagnostic Normalization

The effect checker returns `EffectViolation[]`. The check command converts
these into `Diagnostic[]`:

```sfn
fn effect_violation_to_diagnostic(violation: EffectViolation) -> Diagnostic {
    let effects_str = join_effects(violation.missing_effects);
    let mut desc = "function `" + violation.routine_name + "` is missing required effects: ![" + effects_str + "]";

    // Build requirement details
    let mut req_lines: string[] = [];
    let mut i: number = 0;
    loop {
        if i >= violation.requirements.length { break; }
        let req = violation.requirements[i];
        req_lines.push("  - " + req.description + " requires ![" + req.effect + "]");
        i += 1;
    }
    if req_lines.length > 0 {
        desc = desc + "\n" + join_lines(req_lines);
    }

    return Diagnostic {
        code: "E0400",
        severity: "error",
        message: desc,
        file_path: "",
        primary: null, // Effect checker doesn't currently carry tokens
    };
}
```

**Error code allocation:** `E04xx` for effect violations, keeping them
distinct from `E00xx` (symbol) and `E03xx` (interface) ranges:

| Code | Meaning |
|---|---|
| `E0400` | Missing effect declaration |
| `E0401` | Decorator-implied effect missing |
| `E0402` | Transitive effect not propagated |

**Warning code allocation:** `W01xx` is reserved for non-fatal
load/staging warnings emitted by `sfn check` infrastructure (the
import-context loader, capsule resolver staging, and any future
artifact-loading layer). These warnings flow through the same
`render_diagnostic` pipeline as errors with `severity: "warning"` and
`kind: "load"`, so downstream consumers (`--json`, `sfn lsp`, CI
scrapers) can filter on the producing layer. Program-analysis
warnings (e.g. future `sfn vet` lints for unused imports or dead
code) will live in `W02xx`+ to keep the load-vs-analysis distinction
machine-checkable.

| Code | Meaning |
|---|---|
| `W0001` | Missing import-context artifact (resolver staged a path that's no longer on disk) |
| `W0002` | Import-context artifact parse failed (artifact existed but the native-IR parser produced diagnostics) |

## Data Flow: Single-File Check

```
1. Read source from disk
   source = fs.readFile("compiler/src/foo.sfn")

2. Resolve imports
   combined = inline_imports_for_source(source, dirname("compiler/src/foo.sfn"))
   // Recursively inlines relative imports (depth limit: 10)
   // Circular import detection via visited set

3. Parse
   program = parse_program(combined)
   // Returns Program { statements: Statement[] }
   // No diagnostics from parser currently

4. Type check
   type_diags = typecheck_diagnostics(program)
   // Returns Diagnostic[] — duplicate symbols, interface conformance, scope issues

5. Effect check
   effect_violations = validate_effects(program)
   // Returns EffectViolation[] — missing effects, decorator-implied effects

6. Normalize
   effect_diags = effect_violations.map(effect_violation_to_diagnostic)
   all_diags = type_diags.concat(effect_diags)

7. Render
   for each diagnostic in all_diags:
       render_diagnostic(diagnostic, combined_source, file_path)
       // Print to stderr with source context and caret pointers

8. Return
   exit_code = if all_diags.length > 0 { 1 } else { 0 }
```

## Data Flow: Multi-File Check

When `sfn check dir/` is given a directory, the command collects all `.sfn`
files and processes each independently:

```
1. Collect files
   files = _collect_sfn_files_cmd("dir/")
   // Recursively finds all .sfn files, max_depth not limited

2. For each file:
   a. Read, inline, parse, typecheck, effect-check (as above)
   b. Print file header: [check] dir/foo.sfn
   c. Render diagnostics for this file
   d. Accumulate error/warning counts

3. Print summary
   "checked N files: X errors, Y warnings" or "checked N files: ok"

4. Return
   exit_code = if total_errors > 0 { 1 } else { 0 }
```

**Each file is checked independently.** There is no cross-file analysis.
This matches the compiler's current model — each compilation unit is a
single file with imports inlined. Cross-file analysis would require a module
graph, which is a capsule-system feature (roadmap item 6), not a check-tool
feature.

### File Collection

Reuse `_collect_sfn_files_cmd(root: string) -> string[] ![io]` from
`cli_commands_utils.sfn`. This function already handles:
- Recursive directory traversal
- Filtering for `.sfn` extension
- Skipping non-file entries

For single-file arguments, skip collection and check directly.

### Test File Handling

`sfn check` checks ALL `.sfn` files including test files (`*_test.sfn`).
Test files are valid Sailfin — they should typecheck and effect-check
correctly. If a user wants to exclude test files, they can pass a specific
directory: `sfn check compiler/src/` vs `sfn check compiler/`.

## File Layout

```
compiler/
  src/
    tools/
      check.sfn          # Check orchestration + diagnostic rendering (~400-600 lines)
    cli_main.sfn          # Add `check` dispatch (minor edit)
    cli_commands.sfn      # Add handle_check_command (minor edit)
    typecheck_types.sfn   # Add severity + file_path fields (minor edit)
```

### Module Breakdown

**`compiler/src/tools/check.sfn`** — Check orchestration and rendering

| Function | Responsibility | ~Lines |
|---|---|---|
| `check_file(path: string) -> CheckResult ![io]` | Read, inline, parse, typecheck, effect-check one file | 40 |
| `check_files(paths: string[]) -> CheckSummary ![io]` | Iterate files, accumulate results, print summary | 40 |
| `effect_violation_to_diagnostic(v: EffectViolation) -> Diagnostic` | Normalize EffectViolation into Diagnostic | 30 |
| `render_diagnostic(d: Diagnostic, source: string, file: string) ![io]` | Format and print one diagnostic to stderr | 80 |
| `render_diagnostic_source_context(d: Diagnostic, lines: string[]) -> string` | Build source context with line numbers and caret | 60 |
| `render_effect_diagnostic(d: Diagnostic) -> string` | Effect-specific rendering with requirement list and suggestion | 50 |
| `render_summary(summary: CheckSummary) ![io]` | Print "checked N files: X errors, Y warnings" | 15 |
| `join_effects(effects: string[]) -> string` | Join effect names with ", " for display | 10 |
| `classify_path(path: string) -> string` | Single file vs directory detection | 10 |

**Supporting types:**

```sfn
struct CheckResult {
    file_path: string;
    diagnostics: Diagnostic[];
    error_count: number;
    warning_count: number;
}

struct CheckSummary {
    files_checked: number;
    total_errors: number;
    total_warnings: number;
}
```

**`compiler/src/cli_commands.sfn`** — Command handler (addition)

```sfn
fn handle_check_command(args: string[]) -> number ![io] {
    // Parse --quiet flag and path arguments
    // Collect .sfn files from paths
    // Call check_files(paths)
    // Return exit code based on error count
}
```

~50-80 lines of CLI plumbing.

## Diagnostic Rendering

### Current Renderer (reusable)

`main.sfn` already has `format_typecheck_diagnostic()` which produces
Rust-style diagnostic output with source context, line numbers, and caret
pointers. `sfn check` reuses this rendering logic but extends it with:

1. **File path prefix** — the current renderer assumes single-file
   compilation and doesn't show the file name
2. **Effect diagnostics** — the current renderer doesn't handle effect
   violations (they're a different type)
3. **Severity labels** — "error" vs "warning" prefix

### Rendering Examples

**Type check error (duplicate symbol):**

```
error[E0001]: duplicate function `process` declared
  --> compiler/src/foo.sfn:12:5
   |
12 | fn process(data: Data) {
   |    ^^^^^^^
```

**Effect check error:**

```
error[E0400]: function `process` is missing required effects
  --> compiler/src/foo.sfn:30:1
   |
30 | fn process(data: Data) {
   | ^^
   |
   = missing: ![io, net]
   = required by:
       `fs.readFile` requires ![io]
       `http.get` requires ![net]
   = suggestion: fn process(data: Data) ![io, net] {
```

**Warning (future, when severity support is added):**

```
warning[W0100]: unused import `TokenKind`
  --> compiler/src/bar.sfn:3:10
  |
3 | import { Token, TokenKind } from "./token";
  |                 ^^^^^^^^^
```

### Rendering Architecture

The renderer is a pure function: `Diagnostic + source lines → string`. No
I/O. The CLI layer handles printing to stderr.

```sfn
fn render_diagnostic(d: Diagnostic, source_lines: string[], file_path: string) -> string {
    let mut parts: string[] = [];

    // Header: severity[code]: message
    let header = d.severity + "[" + d.code + "]: " + d.message;
    parts.push(header);

    // Location: --> file:line:column
    if d.primary != null {
        let loc = "  --> " + file_path + ":" +
                  number_to_string(d.primary.line) + ":" +
                  number_to_string(d.primary.column);
        parts.push(loc);

        // Source context with caret
        let context = render_source_context(d.primary, source_lines);
        parts.push(context);
    }

    return join_lines(parts);
}
```

## Implementation Plan

### Step 1: Minimal Check Command

**Goal:** `sfn check file.sfn` runs typecheck only and reports diagnostics
using the existing rendering.

- Create `compiler/src/tools/check.sfn` with `check_file()` that calls
  `inline_imports_for_source`, `parse_program`, `typecheck_diagnostics`,
  and the existing `report_typecheck_errors`
- Add `check` dispatch to `cli_main.sfn`
- Add `handle_check_command` to `cli_commands.sfn` with argument parsing
- Support single file and directory paths
- Verify `make compile` succeeds (self-hosting invariant)

**Test:** `sfn check compiler/src/token.sfn` exits 0 (no errors).
Create a file with a duplicate function; verify `sfn check` catches it.

**Deliverable:** Working `sfn check` with typecheck-only diagnostics.

### Step 2: Wire Effect Checking

**Goal:** `sfn check` also runs the effect checker and reports violations.

- Implement `effect_violation_to_diagnostic()` normalization
- Call `validate_effects(program)` after typecheck in `check_file()`
- Implement basic effect violation rendering (routine name, missing effects,
  requirements list)
- Assign `E04xx` error codes to effect violations

**Test:** Write a function that calls `print.info()` without declaring
`![io]`; verify `sfn check` reports the missing effect.

**Deliverable:** Full type + effect checking in one pass.

### Step 3: Enhanced Rendering

**Goal:** Rust-quality diagnostic output with file paths, severity labels,
and structured source context.

- Add `severity` and `file_path` fields to `Diagnostic` (Phase 1 of
  diagnostic enhancement)
- Update the five `make_*_diagnostic` factory functions to set severity
- Implement `render_diagnostic()` with file path, severity prefix, and
  proper source context formatting
- Add `render_effect_diagnostic()` with requirement listing and suggestion
- Add summary line (`checked N files: X errors, Y warnings`)
- Add `--quiet` flag support

**Test:** Multi-file check on `compiler/src/` produces per-file headers
and a summary line.

**Deliverable:** Production-quality diagnostic output suitable for CI and
developer workflows.

### Step 4: Performance & Integration

**Goal:** Fast enough for interactive use; integrated into Makefile.

- Add `make check-fast` target that runs `sfn check compiler/src/`
- Benchmark: check all 120 compiler files, target < 5 seconds total
- Profile and optimize if needed (likely bottleneck: import inlining I/O)
- Add to CI as a pre-build validation step
- Handle edge cases:
  - Files with syntax errors (parser produces partial AST)
  - Circular imports (handled by `inline_imports_for_source` depth limit)
  - Binary/non-text files in `.sfn` search
  - Empty files
  - Very large files (>10K lines)
  - Files outside capsule root (no `capsule.toml`)

**Test:** `make check-fast` completes in < 10 seconds on the full compiler
source tree.

**Deliverable:** `sfn check` as a fast development inner loop tool.

## Relationship to Other Tools

`sfn check` is the foundation that other tools build on:

```
                          sfn check
                    (parse + typecheck + effects)
                              │
              ┌───────────────┼───────────────┐
              │               │               │
          sfn vet         sfn lsp         sfn fix
      (additional AST     (check on      (apply fixes
       analysis rules)     every save)    from suggestions)
```

### `sfn vet` — Additional Analysis

`sfn vet` runs `sfn check` first, then runs additional AST visitor rules
(unused imports, dead code, etc.). It extends the diagnostic set — it never
replaces or skips the typecheck/effect passes.

### `sfn lsp` — Continuous Checking

The LSP server calls `check_file()` on every file save (Phase 1) or on every
edit (Phase 2, debounced). The check result is published as LSP diagnostics.
The LSP never calls `sfn check` as a subprocess — it calls the same
`check_file()` function directly (since it lives in the same binary).

### `sfn fix` — Applying Suggestions

`sfn fix` runs `check_file()` to collect diagnostics, then applies the
`FixSuggestion` edits from diagnostics that have them. This requires the
Phase 2 diagnostic enhancement (suggestion field). Without suggestions,
`sfn fix` has nothing to apply.

### `make check-fast` — Development Workflow

A new Makefile target for rapid validation during development:

```makefile
check-fast:
	$(COMPILER) check compiler/src/
```

This runs in seconds (vs 13-16 minutes for `make compile`) and catches
the majority of errors that would cause a build failure. The development
loop becomes:

```
edit → sfn check file.sfn → fix errors → sfn check file.sfn → make compile
```

Instead of:

```
edit → make compile (13 min) → see error at minute 12 → fix → repeat
```

## Performance Considerations

### Expected Performance

Each file check involves:
1. **File I/O:** Read source + read imported files (~1-5ms per file)
2. **Import inlining:** String concatenation for imports (~1-10ms per file)
3. **Lexing:** Tokenize combined source (~1-5ms per file, already fast)
4. **Parsing:** Build AST (~5-20ms per file)
5. **Type checking:** Symbol collection + scope checking (~5-20ms per file)
6. **Effect checking:** AST walk for effect violations (~2-10ms per file)

**Expected total per file:** ~15-60ms  
**Expected total for 120 compiler files:** ~2-7 seconds

This is dramatically faster than a full build because:
- No `.sfn-asm` emission (the emitter is the heaviest pass)
- No LLVM IR generation
- No `clang` invocation
- No linking

### Optimization Opportunities (if needed)

1. **Parallel file checking:** Check files in parallel. Each file is
   independent after import inlining. This requires Sailfin's concurrency
   model to mature first — defer unless performance is a problem.

2. **Import cache:** Cache inlined results for files that appear as imports
   in multiple checked files. A simple `Map<path, source>` would avoid
   re-reading and re-inlining shared imports like `./ast` or `./token`.

3. **Incremental checking:** Only re-check files modified since the last
   check. Requires a file modification timestamp cache. Defer to `sfn lsp`
   which naturally maintains this state.

None of these optimizations are needed for v1. The sequential single-threaded
approach should be fast enough for 120 files.

## Self-Hosting Considerations

`sfn check` must compile with the self-hosted compiler. The constraints
that apply:

- **No closures with capture.** The `effect_violations.map(fn)` pattern
  from the overview must be a manual loop.
- **No `Result<T, E>`.** File I/O errors must be handled with null checks
  or by letting the runtime crash (current pattern).
- **`number` only.** No `int` / `float` distinction for counts and indices.
- **No generics.** `CheckResult` and `CheckSummary` are concrete types.
- **String concatenation for building output.** No string interpolation
  (`${}` not yet available).

These are the same constraints the existing CLI commands operate under.
The `handle_test_command` implementation is a good reference — it uses
the same patterns (file iteration, import inlining, error reporting) that
`handle_check_command` needs.

## Testing Strategy

### Unit Tests (`compiler/tests/unit/check_tool_test.sfn`)

Test the normalization and rendering functions in isolation:

```sfn
test "check: effect violation to diagnostic" {
    let violation = EffectViolation {
        routine_name: "process",
        missing_effects: ["io", "net"],
        requirements: [
            EffectRequirement { effect: "io", description: "fs.readFile" },
            EffectRequirement { effect: "net", description: "http.get" },
        ],
    };
    let diag = effect_violation_to_diagnostic(violation);
    assert diag.code == "E0400";
    assert diag.severity == "error";
    assert string_contains(diag.message, "process");
    assert string_contains(diag.message, "io");
    assert string_contains(diag.message, "net");
}

test "check: render diagnostic with source context" {
    let diag = Diagnostic {
        code: "E0001",
        severity: "error",
        message: "duplicate function `foo` declared",
        file_path: "test.sfn",
        primary: Token {
            kind: TokenKind.Identifier(),
            lexeme: "foo",
            line: 3,
            column: 4,
        },
    };
    let source_lines = ["", "", "fn foo() {", "}"];
    let rendered = render_diagnostic(diag, source_lines, "test.sfn");
    assert string_contains(rendered, "error[E0001]");
    assert string_contains(rendered, "test.sfn:3:4");
    assert string_contains(rendered, "fn foo()");
}
```

### Integration Tests (`compiler/tests/integration/check_integration_test.sfn`)

Test the full `check_file()` flow on real files:

```sfn
test "check: clean file has no diagnostics" ![io] {
    let result = check_file("compiler/src/token.sfn");
    assert result.error_count == 0;
}

test "check: duplicate symbol detected" ![io] {
    // Write a temp file with duplicate function
    let source = "fn foo() { }\nfn foo() { }\n";
    fs.writeFile("/tmp/sfn_check_test.sfn", source);
    let result = check_file("/tmp/sfn_check_test.sfn");
    assert result.error_count > 0;
    assert result.diagnostics[0].code == "E0001";
}
```

### Self-Hosting Validation

The ultimate validation — check the compiler's own source:

```bash
sfn check compiler/src/
# Should exit 0 — the compiler's source must be clean
```

If `sfn check` finds errors in the compiler source, those are real bugs
that should be fixed. The compiler currently passes typecheck (it compiles
successfully), but it has never been effect-checked — `sfn check` may
surface effect violations in the compiler's own code that have been
silently ignored.

## Edge Cases

### 1. Import Resolution Failures

If `inline_imports_for_source` can't find an imported file, it strips the
import line and continues. This means the type checker will see calls to
undefined functions. The error messages will be about missing symbols, not
missing files. This is acceptable for v1 — a proper "file not found"
diagnostic requires import resolution changes.

### 2. Files with Parse Errors

The parser doesn't crash on invalid syntax — it produces a partial AST and
skips unrecognized statements. The type checker then reports issues with the
partial AST. This means `sfn check` on a badly broken file will still
produce diagnostics, just not the most helpful ones. Parser error recovery
is a future enhancement.

### 3. Effect Checker False Positives

The effect checker may report violations for functions that call builtins
which don't actually require effects (e.g., `print` in a test context).
The test harness provides implicit `![io]` capability, but the effect
checker doesn't know about that context. For v1, accept these as valid
diagnostics — the function should declare its effects even in tests.

### 4. Large Inlined Files

Import inlining can produce very large combined source strings (a file
that imports 20 modules could produce 10K+ lines of combined source).
This is the same behavior as `sfn test` and `sfn build` — no new risk, 
but worth monitoring for performance.

### 5. Capsule Dependencies

Files that import from capsule dependencies (`import { x } from "sfn/json"`)
require those capsules to be installed locally. `inline_imports_for_source`
resolves capsule paths via `capsule.toml` and the local capsule cache. If
a dependency isn't installed, the import is stripped (same as missing files).

## Future Considerations (Out of Scope for v1)

- **Parser error diagnostics:** Add error recovery and diagnostic production
  to the parser. Currently the parser is silent on errors — it just skips
  bad input. This would give `sfn check` a third category of diagnostics.
- **Cross-file analysis:** Check imports are valid (file exists, exported
  symbols match). Requires a module graph and symbol table per file.
- **Incremental checking:** Only re-check files that changed. Requires a
  modification timestamp or content-hash cache.
- **Watch mode (`--watch`):** Re-check on file change. Natural fit once
  incremental checking exists. Defer to `sfn lsp` which provides this
  functionality.
- **JSON output (`--format json`):** Machine-readable diagnostic output for
  editor integrations and CI tools. Useful for `sfn lsp` Phase 1 (the LSP
  can parse JSON diagnostics rather than scraping stderr).
- **Diagnostic deduplication:** If the same symbol is imported and inlined
  multiple times, the type checker may report duplicate diagnostics. A
  dedup pass on diagnostics would clean this up.
- **Source mapping for inlined imports:** Diagnostics currently show line
  numbers in the combined (inlined) source, not the original file. A source
  map would translate back to original file + line. This is a significant
  enhancement that requires tracking source origins during inlining.
