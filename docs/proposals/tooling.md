# Proposal: Sailfin Built-in Tooling

Status: Draft
Date: April 15, 2026
Authors: Core Team

## Motivation

Languages that ship with built-in tooling (Go, Rust, Zig) achieve dramatically
faster adoption than those that rely on third-party ecosystems. Go's `gofmt`
alone eliminated an entire class of code review friction on day one. Rust's
`cargo check`, `clippy`, and `rust-analyzer` are considered table-stakes by
developers evaluating the language.

Sailfin faces a unique bootstrapping challenge: zero AI training data exists for
`.sfn` files, and the developer community is nascent. Built-in tooling serves
double duty — it improves human productivity AND reduces LLM error rates by
establishing canonical patterns. Every `sfn fmt` run produces training signal;
every diagnostic with a fix-it hint teaches correct usage.

This proposal covers what tooling to build, where it lives architecturally,
a rough sketch of each tool's design, and how to prioritize delivery relative
to the 1.0 roadmap.

## Inventory of Proposed Tools

| Tool | CLI Surface | Priority | Ships |
|------|------------|----------|-------|
| `sfn fmt` | Formatter | P0 (now) | Pre-1.0 |
| `sfn check` | Fast analysis (no codegen) | P0 (now) | Pre-1.0 |
| `sfn vet` | Static analyzer / linter | P1 | Pre-1.0 |
| `sfn doc` | Documentation generator | P2 | 1.0 |
| `sfn fix` | Automated code rewriter | P2 | 1.0 |
| `sfn lsp` | Language Server Protocol | P1 | Pre-1.0 (basic), 1.0 (full) |
| `sfn bench` | Benchmarking framework | P3 | Post-1.0 |

Existing commands (`sfn test`, `sfn build`, `sfn run`) are shipped and stable.
Package-management commands (`sfn init`, `sfn add`, `sfn publish`, `sfn login`)
are implemented and functional against `registry.sailfin.dev`. None of these
are covered here.


## Architectural Decision: Where Does Tooling Live?

### The Compiler-as-Library Pattern

The central architectural question is how tools access the parser, AST, type
checker, and effect checker. Three options were evaluated:

**Option A: Subcommands in the compiler binary (Go model)**
All tools ship as subcommands of `sfn`. They share the parser and analysis
passes directly because they live in the same compilation unit.

- Pros: Single binary, always in sync, zero duplication
- Cons: Increases compiler binary size; 13-16 min rebuild for any tool change

**Option B: Separate binaries with duplicated parsing**
Each tool is its own capsule with its own parser copy.

- Pros: Independent development and release
- Cons: Parser drift, massive duplication, version skew bugs

**Option C: Compiler-as-library capsule + tool binaries (Rust model)**
Extract the front-end (lexer, parser, AST, typecheck, effect checker) into a
reusable `sfn/compiler` library capsule. Tools import from it.

- Pros: Independent tool binaries, shared analysis, no duplication
- Cons: Requires capsule system and cross-capsule imports to be solid first

### Recommendation: Phased Hybrid (A now, C later)

**Phase 1 (pre-1.0):** Build `sfn fmt`, `sfn check`, and `sfn vet` as
subcommands inside the compiler binary (Option A). This is pragmatic — the
capsule system and cross-capsule imports are not yet mature enough for Option C,
and these tools need to ship soon to aid development.

**Phase 2 (1.0):** Once the capsule/workspace system is solid (roadmap item 6),
extract the compiler front-end into `sfn/compiler` as a library capsule. Migrate
`sfn lsp` and `sfn doc` to use it as standalone binaries.

**Phase 3 (post-1.0):** All tools become independent capsules importing
`sfn/compiler`. The compiler binary itself becomes a thin CLI that orchestrates
library calls. This mirrors how `rust-analyzer` relates to `rustc`.

### Where in the Source Tree

```
compiler/
  src/
    tools/              # New directory for tool implementations
      fmt.sfn           # Formatter logic
      check.sfn         # Fast analysis pass
      vet.sfn           # Static analysis rules
      fix.sfn           # Automated rewriting
    cli_main.sfn        # Add subcommand dispatch for new tools
    cli_commands.sfn     # Tool command handlers
```

Tools live under `compiler/src/tools/` and are wired into the CLI via
`cli_main.sfn`. They import from the existing parser, AST, typecheck, and
effect checker modules — no new dependencies.


## Tool Designs

### 1. `sfn fmt` — Canonical Formatter

**What it does:** Reads `.sfn` source, lexes it into a token stream, and
reprints it in canonical style while preserving comments. A parse step may
run for validation, but formatting operates on the token stream, not the AST.
Like `gofmt` — one true style, no configuration.

**Why it's high priority:**
- Eliminates style debates in code review
- Produces consistent `.sfn` files that become implicit training data for LLMs
- The compiler's own 120 source files would benefit immediately
- Enables `--check` mode for CI enforcement

**Design sketch:**

```
sfn fmt [--check] [--write] [path...]
```

- `sfn fmt .` — format all `.sfn` files recursively, print to stdout
- `sfn fmt --write .` — format in place
- `sfn fmt --check .` — exit non-zero if any file would change (CI mode)

**Implementation approach:**

The formatter operates on the token stream, not the AST. This preserves
comments (which the AST discards). The algorithm:

1. Lex the source into tokens (reuse `lexer.sfn`)
2. Walk the token stream, applying formatting rules:
   - Indentation: 4 spaces per nesting level
   - Braces: opening brace on same line as declaration
   - Spacing: single space around binary operators, after commas
   - Blank lines: one between top-level declarations, none inside blocks
   - Trailing: no trailing whitespace, single newline at EOF
   - Imports: sorted alphabetically, grouped (stdlib / relative / absolute)
3. Emit the reformatted token stream as text

**Key design decisions:**
- **No configuration.** One style. This is a feature, not a limitation.
  `gofmt` proved that eliminating choice is more valuable than enabling it.
- **Token-stream based**, not AST-based. Comments attach to adjacent tokens
  via proximity. This avoids the "lost comments" problem that plagues
  AST-based formatters.
- **Idempotent.** Running `sfn fmt` twice produces identical output.

**Estimated scope:** ~800-1200 lines of Sailfin. The lexer already exists;
the formatter is a token-stream printer with indentation tracking.

**Files affected:**
- New: `compiler/src/tools/fmt.sfn`
- Modified: `compiler/src/cli_main.sfn` (add `fmt` subcommand dispatch)
- Modified: `compiler/src/cli_commands.sfn` (add `handle_fmt_command`)


### 2. `sfn check` — Fast Analysis Without Codegen

**What it does:** Runs the front-end passes (parse, typecheck, effect check)
without emitting `.sfn-asm` IR or LLVM IR. Returns diagnostics only.

**Why it's high priority:**
- The full `sfn build` pipeline takes seconds per file (emit + LLVM lowering +
  clang). `sfn check` skips all codegen and returns in milliseconds.
- This is the foundation for fast IDE feedback (LSP will call `check` internally)
- Enables a `make check-fast` target that validates all 120 compiler modules
  without a full rebuild
- Catches type errors, duplicate symbols, effect violations, and interface
  conformance issues instantly

**Design sketch:**

```
sfn check [path...]
```

- `sfn check compiler/src/` — check all `.sfn` files, report diagnostics
- `sfn check file.sfn` — check a single file
- Exit code 0 = clean, 1 = diagnostics found

**Implementation approach:**

1. For each input file, read source and call `parse_program(source)`
2. Run `typecheck_diagnostics(program)` to collect type errors
3. Run `validate_effects(program)` to collect effect violations
4. Format and report all diagnostics with source context
5. Stop. No emit, no LLVM, no clang.

**Diagnostic enhancement (prerequisite):**

The current `Diagnostic` struct (`typecheck_types.sfn`) only carries:
- `code: string` — error code
- `message: string` — human-readable description
- `primary: Token?` — single source location

For `sfn check` to be truly useful, diagnostics should be extended to:

```sfn
struct Diagnostic {
    code: string;
    severity: string;       // "error" | "warning" | "hint"
    message: string;
    primary: Token?;
    secondary: Token[];     // Related locations (e.g., "first defined here")
    suggestion: string?;    // Fix-it text (e.g., "add ![io] to function signature")
}
```

This enhancement also unblocks `sfn fix` and LSP quick-fix support.

**Estimated scope:** ~200-400 lines for the command handler; ~300 lines for
diagnostic struct enhancement across `typecheck_types.sfn` and
`effect_checker.sfn`.

**Files affected:**
- New: `compiler/src/tools/check.sfn`
- Modified: `compiler/src/typecheck_types.sfn` (extend Diagnostic struct)
- Modified: `compiler/src/effect_checker.sfn` (emit enhanced diagnostics)
- Modified: `compiler/src/cli_main.sfn` (add `check` subcommand)


### 3. `sfn vet` — Static Analyzer

**What it does:** Performs deeper static analysis beyond type checking. Catches
common mistakes, suspicious patterns, and style violations that are legal
Sailfin but probably wrong.

**Why it matters:** Go's `go vet` catches bugs that the type system can't.
For Sailfin, this is especially valuable because the type system is still
maturing — `vet` can enforce rules that the type checker doesn't yet handle.

**Design sketch:**

```
sfn vet [--rules rule1,rule2] [path...]
```

**Initial rule set (P1 — ship pre-1.0):**

| Rule | Description |
|------|-------------|
| `unused-import` | Import specifier not referenced in module |
| `unused-variable` | `let` binding never read |
| `unused-parameter` | Function parameter never referenced |
| `dead-code` | Code after unconditional `return`, `break`, or `throw` |
| `missing-effect` | Function calls effectful code without declaring effect |
| `empty-block` | `if`, `for`, `match` with empty body |
| `shadowed-builtin` | Variable shadows a builtin name (`print`, `assert`) |
| `redundant-mut` | `let mut` where binding is never reassigned |
| `unreachable-match-arm` | Match arm shadowed by a previous wildcard or identical pattern |
| `infinite-loop` | `loop { }` with no `break` or `return` |

**Extended rule set (P2 — ship at 1.0):**

| Rule | Description |
|------|-------------|
| `unchecked-result` | Ignoring return value of a function returning `Result<T, E>` |
| `effect-escalation` | Function declares more effects than it uses |
| `capsule-capability-mismatch` | Code uses effects not listed in `capsule.toml` |
| `deprecated-api` | Calling `print.info` / `print.warn` / `print.error` (use `sfn/log`) |
| `match-exhaustiveness` | Non-exhaustive match without `_` default |
| `borrow-escape` | Reference outlives its scope (once ownership enforced) |

**Implementation approach:**

Each vet rule is an AST visitor function with signature:
```sfn
fn check_unused_imports(program: Program) -> Diagnostic[]
```

The `vet` command runs all enabled rules and merges diagnostics. Rules are
independent — adding a new rule is adding one function + registering it.

**Estimated scope:** ~100-200 lines per rule, ~200 lines for the harness.
Initial 10 rules = ~1500-2200 lines total.

**Files affected:**
- New: `compiler/src/tools/vet.sfn` (harness + rules)
- Modified: `compiler/src/cli_main.sfn` (add `vet` subcommand)


### 4. `sfn lsp` — Language Server Protocol

**What it does:** Provides IDE integration — diagnostics, go-to-definition,
hover info, completions, rename, and quick fixes.

**Why it matters:** Developer experience makes or breaks adoption. The existing
TypeScript LSP wrapper in a separate repo was a 20-minute prototype; a proper
LSP built on the real compiler front-end would provide accurate diagnostics
and completions that stay in sync with language evolution.

**Design sketch:**

```
sfn lsp [--stdio] [--port PORT]
```

The LSP server is a long-running process that communicates via JSON-RPC over
stdio (standard for VS Code) or TCP (for other editors).

**Phased delivery:**

**Phase 1 (pre-1.0 — basic):**
- Diagnostics on save (calls `sfn check` internally)
- Go-to-definition for local symbols (same file)
- Hover: show type annotation for variables and function signatures
- Wire protocol: stdio JSON-RPC

**Phase 2 (1.0 — full):**
- Real-time diagnostics (on-type, debounced)
- Cross-file go-to-definition (using import resolution)
- Completions: keywords, local variables, imported symbols, struct fields
- Signature help for function calls
- Quick fixes from diagnostic suggestions (wired to `sfn fix`)
- Rename symbol (local scope)
- Document symbols / outline

**Phase 3 (post-1.0 — advanced):**
- Workspace-wide rename
- Find all references
- Code actions (extract function, add missing import)
- Effect annotation overlays (show required effects inline)
- Inlay hints for inferred types
- Capsule dependency completions

**Implementation approach:**

The LSP server would be a separate binary (`sfn-lsp` or invoked via `sfn lsp`).
In Phase 1, it can live in the compiler binary for simplicity. In Phase 2+,
once `sfn/compiler` exists as a library capsule, it becomes a standalone binary.

The server maintains an in-memory file cache. On each edit:
1. Re-lex and re-parse the changed file
2. Run `sfn check` passes (typecheck + effect check)
3. Publish diagnostics to the editor
4. Update the symbol index for completions and navigation

**Estimated scope:** Phase 1: ~1500-2500 lines (JSON-RPC handler + diagnostic
bridge + basic navigation). Phase 2: ~4000-6000 additional lines.

**Files affected:**
- New: `compiler/src/tools/lsp.sfn` (or `compiler/src/lsp/` directory)
- New: `compiler/src/tools/lsp_protocol.sfn` (JSON-RPC types)
- Modified: `compiler/src/cli_main.sfn` (add `lsp` subcommand)


### 5. `sfn doc` — Documentation Generator

**What it does:** Extracts documentation from source comments and type
signatures, producing HTML or Markdown reference documentation.

**Design sketch:**

```
sfn doc [--format html|md] [--output DIR] [path...]
sfn doc --serve [--port 8080]     # Local preview server (post-1.0)
```

**Documentation conventions:**

```sfn
/// Fetches an order by ID from the database.
///
/// Returns null if the order does not exist. Requires network
/// and IO capabilities for the database connection.
///
/// ## Examples
/// ```sfn
/// let order = fetch_order(OrderId { id: 42 });
/// ```
fn fetch_order(id: OrderId) -> Order? ![io, net] { ... }
```

- `///` comments are doc comments (triple-slash, like Rust)
- `//` comments are regular comments (ignored by doc generator)
- Doc comments support Markdown formatting
- Code examples in doc comments are validated by `sfn test --doc`

**Scope of documentation:**
- Functions: signature, effects, doc comment, examples
- Structs: fields, methods, implements clauses
- Enums: variants with payloads
- Interfaces: method signatures
- Capsules: `capsule.toml` metadata + top-level exports
- Effects: which capabilities a module requires and why

**Estimated scope:** ~1500-2500 lines.

**Files affected:**
- New: `compiler/src/tools/doc.sfn`
- Modified: `compiler/src/cli_main.sfn`
- Modified: `compiler/src/lexer.sfn` (preserve `///` doc comments as tokens)

### 6. `sfn fix` — Automated Rewriter

**What it does:** Applies automated fixes for diagnostics that have suggestions.
This is the `--fix` flag mentioned in the roadmap under "Language Feature
Completeness."

**Design sketch:**

```
sfn fix [--dry-run] [path...]
sfn fix --rule missing-effect [path...]
```

**Fix categories:**
- Add missing `![effect]` annotations (from effect checker suggestions)
- Remove unused imports
- Convert deprecated API calls (`print.info` -> `log.info`)
- Add missing `mut` to reassigned variables
- Remove redundant `mut` from read-only variables
- Sort import statements

**Implementation approach:**

Fixes are text edits derived from diagnostic suggestions. The `Diagnostic`
struct's `suggestion` field carries the replacement text; `sfn fix` applies
them in reverse source order (to preserve offsets).

**Estimated scope:** ~600-1000 lines (edit application engine + fix providers).

**Files affected:**
- New: `compiler/src/tools/fix.sfn`
- Modified: `compiler/src/cli_main.sfn`


## Prerequisite: Diagnostic Infrastructure Enhancement

All tools depend on richer diagnostics. The current `Diagnostic` struct is
minimal (code + message + single token). The enhanced version is a prerequisite
for `sfn check`, `sfn vet`, `sfn fix`, and LSP quick-fixes.

**Current state** (`compiler/src/typecheck_types.sfn`):
```sfn
struct Diagnostic {
    code: string;
    message: string;
    primary: Token?;
}
```

**Target state:**
```sfn
struct Diagnostic {
    code: string;
    severity: string;         // "error" | "warning" | "hint" | "info"
    message: string;
    primary: SourceLocation?;
    secondary: SourceLocation[];
    suggestion: FixSuggestion?;
}

struct SourceLocation {
    token: Token?;
    label: string;            // "first defined here", "this call requires ![io]"
}

struct FixSuggestion {
    message: string;          // "add ![io] to function signature"
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

This enhancement is backwards-compatible — existing diagnostic producers can
leave `secondary` empty and `suggestion` null. Enhancement is incremental:
each vet rule or checker can add suggestions over time.

**Estimated scope:** ~200 lines to define the new types; ~400 lines to update
existing typecheck and effect checker call sites.


## Prioritization and Roadmap Integration

### What Helps Development Right Now?

The question is: given that Sailfin is wholly new, what tooling would most
accelerate the compiler improvements and runtime migration already on the
roadmap?

**1. `sfn fmt` (P0 — immediate impact)**

The compiler's 120 source files have no canonical formatting. Every Claude Code
session produces slightly different style. `sfn fmt` would:
- Normalize the compiler source itself (one-time migration, then CI-enforced)
- Make diffs cleaner, code review faster
- Establish the style that all future `.sfn` code follows
- Provide implicit training data for LLMs (every formatted file teaches the style)

**Dependency:** None. Only needs the lexer, which already exists and is stable.

**2. `sfn check` (P0 — immediate impact)**

The compiler rebuild takes 13-16 minutes. During development, most errors are
caught by the type checker or effect checker — the first two passes of the
pipeline. `sfn check` runs those passes without codegen:
- Catch errors in seconds instead of waiting for a full build
- Enable a `make check-fast` target for rapid iteration
- Foundation for LSP diagnostics

**Dependency:** Diagnostic enhancement (minor). Can ship with current diagnostics
and enhance incrementally.

**3. `sfn vet` (P1 — aids runtime migration)**

The planned runtime migration from C to Sailfin (roadmap item 3) will produce
thousands of lines of new Sailfin code. Vet rules catch mistakes the type
checker misses:
- `unused-import` and `unused-variable` keep the migrated code clean
- `missing-effect` catches capability violations early
- `dead-code` flags unreachable paths in the new runtime

**Dependency:** `sfn check` infrastructure (reuses diagnostic types).

**4. `sfn lsp` Phase 1 (P1 — developer experience)**

Even a basic LSP with diagnostics-on-save and go-to-definition would be a
major improvement over the prototype TypeScript wrapper. For Claude Code
sessions, it means real-time feedback instead of waiting for `make compile`.

**Dependency:** `sfn check` (the LSP calls check internally).

### Proposed Roadmap Slot

These tools slot into the existing roadmap as a sub-section of item 4 ("Tooling
and developer workflow"):

```
4. Tooling and developer workflow
   - [x] Remove Python runtime shims
   - [ ] Replace sfn shell wrapper with Sailfin-native CLI binary
   - [ ] Replace C native_driver with Sailfin-native CLI entrypoint
   --- NEW (this proposal) ---
   - [ ] Enhance Diagnostic struct (severity, secondary spans, suggestions)
   - [ ] Implement `sfn fmt` (token-stream formatter, no config)
   - [ ] Implement `sfn check` (fast typecheck + effect check, no codegen)
   - [ ] Implement `sfn vet` (initial 10 rules)
   - [ ] Implement `sfn lsp` Phase 1 (diagnostics + go-to-def + hover)
   - [ ] Format compiler source with `sfn fmt` and add CI check
   - [ ] Implement `sfn doc` (documentation generator)
   - [ ] Implement `sfn fix` (automated rewriter from diagnostics)
   - [ ] Implement `sfn lsp` Phase 2 (completions, cross-file nav, rename)
```

### Sequencing

```
                    Diagnostic Enhancement
                           |
                    +------+------+
                    |             |
                sfn fmt       sfn check
                    |             |
                    |        +----+----+
                    |        |         |
                 CI gate   sfn vet  sfn lsp (Phase 1)
                             |         |
                          sfn fix   sfn lsp (Phase 2)
                             |
                          sfn doc
```

`sfn fmt` and `sfn check` have no dependency on each other and can proceed in
parallel. Both only depend on the diagnostic enhancement landing first (and
`sfn fmt` can actually ship before that since it doesn't produce diagnostics
in the traditional sense — it only needs the lexer).


## Impact on the 1.0 Critical Path

This tooling does NOT block the 1.0 release — it accelerates it. Specifically:

| Roadmap Item | How Tooling Helps |
|---|---|
| Syntax reform (item 0) | `sfn fmt` enforces new syntax style after migration; `sfn fix` automates `{{ }}` → `${ }` rewrite |
| Compiler stabilization (item 1) | `sfn check` catches regressions without full rebuilds; `sfn vet` catches dead code and unused vars in compiler source |
| Language feature completeness (item 2) | `sfn check` validates new features instantly; diagnostic enhancement gives richer error messages for users |
| Runtime migration (item 3) | `sfn vet` catches common mistakes in new Sailfin runtime code; `sfn check` validates effect annotations on new capability adapters |
| Capsule system (item 6) | `sfn doc` generates capsule API documentation; `sfn vet` validates capsule capability declarations |

The `sfn fmt` + `sfn check` combination is especially valuable for the runtime
migration. The migration will produce ~6000+ lines of new Sailfin code replacing
the C runtime. Having formatting and fast analysis available means each new
module can be validated in seconds rather than waiting for a full build cycle.

## Self-Hosting Considerations

All tools must be written in Sailfin and compile with the self-hosted compiler.
This means:
- No external dependencies (all tools use the existing parser/AST/typecheck)
- Tools must compile under the current language subset (no `await`, no `Result<T, E>`,
  no closures-with-capture until those features land)
- Each tool addition must pass `make compile` (self-hosting invariant)
- Keep tool implementations simple — the compiler currently has no closures,
  limited generics, and `number` as the only numeric type

This is actually an advantage: the tools become additional self-hosting
validation. If `sfn fmt` can format the compiler's own source files and the
compiler can still compile itself, that's a strong correctness signal.

## Cost Estimate

| Tool | Estimated Lines | Implementation Sessions |
|------|----------------|------------------------|
| Diagnostic enhancement | ~600 | 1-2 |
| `sfn fmt` | ~800-1200 | 2-3 |
| `sfn check` | ~200-400 | 1 |
| `sfn vet` (10 rules) | ~1500-2200 | 3-4 |
| `sfn lsp` Phase 1 | ~1500-2500 | 3-5 |
| `sfn doc` | ~1500-2500 | 2-3 |
| `sfn fix` | ~600-1000 | 1-2 |

**Total: ~6700-10400 lines across 13-20 sessions.**

For context, the compiler is currently ~14,300 lines across 120 files.
The tooling would add roughly 50-70% more code, but unlike compiler passes,
tool code is largely independent and testable in isolation.

## Open Questions

1. **Formatter: token-stream or CST?** This proposal recommends token-stream
   for simplicity. A Concrete Syntax Tree (CST) preserves more structure but
   requires a second parser. Revisit if the token-stream approach can't handle
   comment placement correctly.

2. **LSP: in-process or out-of-process?** Phase 1 proposes in-process (a
   subcommand). If the compiler's memory footprint is too large for a
   long-running LSP process, Phase 2 should use a separate lightweight binary.

3. **Doc comment syntax:** This proposal uses `///` (Rust convention). Alternative:
   `/** */` (Java/TypeScript). Recommend `///` since it's simpler to lex and
   the language already uses `//` for comments.

4. **Vet rule configuration:** Should users be able to disable specific rules
   via `capsule.toml`? Recommend yes for `[vet]` section in `capsule.toml`,
   but ship with all rules enabled by default and no config initially.

## References

- Go tooling philosophy: https://go.dev/blog/tool-chain
- Rust Clippy architecture: independent lint passes over HIR
- `docs/roadmap.md` — items 2 (diagnostics), 4 (tooling), 6 (capsule system)
- `docs/status.md` — current diagnostic and testing capabilities
- `compiler/src/typecheck_types.sfn` — current Diagnostic struct
- `compiler/src/effect_checker.sfn` — current effect validation
- `compiler/src/cli_main.sfn` — CLI subcommand dispatch
