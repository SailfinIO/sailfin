# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

Sailfin is an AI-native, systems-friendly programming language designed for precision, safety, and introspection. The repository hosts the **self-hosted native compiler** (primary toolchain), plus legacy bootstrap code kept for emergency recovery while marching toward 1.0.

**Current architecture:**

- **Native compiler (primary)**: Self-hosted compiler targeting LLVM with `.sfn-asm` intermediate representation; release artifacts install as `sailfin`/`sfn`.

Note: the codebase may still contain historical `stage2` names in internal paths; prefer “native compiler” terminology.

The runtime currently ships as C under `runtime/native/` and is planned to move into Sailfin for the 1.0 release.

The language features effect types (`![io, net, model, gpu, rand, clock]`), ownership-aware linear/affine types, capability-based security, and first-class AI constructs (models, prompts, pipelines, tools).

## Essential Commands

### Environment Setup

### Development Workflow

```bash
make compile          # Build the compiler by self-hosting from a released seed (preferred)
make install          # Install the built compiler into PREFIX/bin (default: ~/.local/bin)
make rebuild          # Force a rebuild from a released seed
make check            # Compile (if needed) then run the full test suite
make test             # Run full suite
make test-unit        # Run Sailfin-native unit tests
make test-integration # Run Sailfin-native integration tests
make bench            # Benchmark per-module compile time and memory
```

### Build Artifacts

```bash
make clean            # Remove dist/ artifacts
make clean-build       # Remove build/* artifacts (keeps build/seed by default)
```

## Architecture & Key Concepts

### Compiler Pipeline (native)

The compiler (`compiler/src/`) follows this flow:

1. **Lexer** (`lexer.sfn`) → tokens
2. **Parser** (`parser.sfn`) → AST (`ast.sfn`)
3. **Type Checker** (`typecheck.sfn`) → duplicate symbols, interface conformance
4. **Effect Checker** (`effect_checker.sfn`) → validates `![effect, ...]` annotations
5. **Native Emitter** (`emit_native.sfn`) → `.sfn-asm` IR (`native_ir.sfn`)
6. **LLVM Lowering** (`compiler/src/llvm/lowering/entrypoints.sfn`) → LLVM IR

**Critical files:**

- `compiler/capsule.toml` — Version source of truth and capsule manifest
- `compiler/src/main.sfn` — Entry point orchestrating all passes
- `compiler/src/ast.sfn` — Canonical AST node definitions
- `compiler/src/native_ir.sfn` — `.sfn-asm` intermediate representation
- `runtime/prelude.sfn` — Sailfin-native runtime (collections, strings, type checks)
- `runtime/native/` — Current C runtime implementation (planned to move into Sailfin pre-1.0)

### Effect System

Functions/tests/pipelines declare required capabilities:

```sfn
fn fetch_order(id: OrderId) -> Order ![io, net] { ... }
```

**Canonical effects:** `io`, `net`, `model`, `gpu`, `rand`, `clock`

**Enforcement** (via `effect_checker.sfn`):

- `model`: required for `prompt` blocks
- `io`: required for `print.*`, `console.*`, `fs.*`, decorators like `@logExecution`
- `net`: required for `http.*`, `websocket.*`, `serve`
- `clock`: required for `sleep`, `runtime.sleep`

Effect checking walks nested blocks, lambdas, and `routine` scopes. Missing effects emit diagnostics with source spans and fix-it hints.

### Ownership & Borrowing (Native Compiler)

Sailfin uses move-by-default semantics with explicit borrows:

- `Affine<T>`: may be dropped, not duplicated
- `Linear<T>`: must be consumed exactly once
- `&T`: shared (read-only) borrow
- `&mut T`: exclusive mutable borrow

**Bootstrap status:** Parsed but not enforced. The native LLVM backend tracks ownership metadata, rejects conflicting borrows, and flags use-after-move.

### Runtime Bridges

The runtime currently ships as C under `runtime/native/`.

### Testing Philosophy

- **Unit tests**: `compiler/tests/unit/*_test.sfn`
- **Integration tests**: `compiler/tests/integration/*_test.sfn`
- **E2E tests**: `compiler/tests/e2e/*_test.sfn`

## Workflow Orchestration

Slash commands orchestrate multi-phase workflows using specialized subagents. Use them instead of manually driving each step. The user types a single command and Claude drives the full workflow, stopping only at explicit approval gates.

### Available Workflows

| Command | Phases | When to use |
|---|---|---|
| `/add-feature <name>` | architect → implement → review → test → docs | Adding any new language feature |
| `/debug-compile <file>` | isolate → trace → deep diagnosis → fix → verify | Any compilation failure |
| `/check` | clean build → full test suite → seedcheck | Pre-commit validation |
| `/test-feature <name>` | find tests → run targeted → run full suite | Testing a specific area |
| `/release` | version check → confirm → dispatch workflow | Cutting a new release |

### Specialized Agents

| Agent | Model | Role | When to spawn |
|---|---|---|---|
| `compiler-architect` | Opus | Designs features, refactors, and fixes with forward-thinking plans | Before implementing anything non-trivial; when a change touches multiple pipeline stages |
| `seed-stabilizer` | Opus | Deep diagnosis of compiler bugs — miscompilation, IR errors, performance regressions | When a build fails or produces wrong output and the cause isn't obvious |
| `compiler-explorer` | Sonnet | Traces how features flow through the pipeline; finds implementations | When you need to understand how something currently works |
| `code-reviewer` | Sonnet | Reviews changes for correctness, safety, and conventions | After implementing, before committing |
| `test-runner` | Sonnet | Runs tests safely with memory caps; analyzes failures | After changes, to validate correctness |
| `docs-updater` | Sonnet | Updates status.md, spec.md, roadmap.md in sync | After a feature ships or changes status |

### Workflow Patterns for Unscripted Tasks

Not every task has a slash command. For tasks that don't, follow these patterns:

**Performance optimization:**
1. Spawn `seed-stabilizer` to profile and identify the bottleneck
2. Spawn `compiler-architect` to design the fix (if non-trivial)
3. Implement the fix
4. Benchmark with `make bench` before and after
5. Spawn `test-runner` to verify no regressions

**Refactoring compiler internals:**
1. Spawn `compiler-architect` to produce a migration plan where each step self-hosts
2. Implement one step at a time, running `make compile` after each
3. Spawn `code-reviewer` after all steps complete
4. Spawn `test-runner` for full validation

**Investigating "how does X work":**
1. Spawn `compiler-explorer` — it traces features through the full pipeline with file/line references

**Fixing a self-hosting break:**
1. Spawn `seed-stabilizer` to diagnose the root cause (Opus — these bugs are hard)
2. If the fix is structural, spawn `compiler-architect` to validate the approach
3. Implement the fix
4. Run `make clean-build && make check` to fully validate

### Approval Gates

Workflows pause for user approval at these points:
- **Design gate** (`/add-feature`): After the architect produces a plan, before any code is written
- **Destructive operations**: Before `make clean-build`, force pushes, or branch deletions
- All other phases proceed autonomously unless a failure occurs

### When NOT to Use Agents

Use direct tools (Read, Grep, Glob) instead of agents when:
- You already know which file to read or edit
- The search is a simple keyword lookup
- The task is a one-line change with obvious correctness

Agents add value for open-ended investigation, cross-cutting analysis, and tasks requiring deep reasoning. Don't spawn an agent for work you can do in one tool call.

## Task Tracking

The roadmap (`docs/roadmap.md`) is strategic — it lists epics, not session-sized work. Actual day-to-day work lives in **GitHub Issues**, scoped tightly enough that a single Claude session can take an issue from open to merged PR.

### The flow

```
docs/roadmap.md (epics)
       │
       │  /groom <epic>           — compiler-architect breaks epic into XS/S/M issues
       ▼
GitHub Issues (claude-ready)
       │
       │  /triage                 — auto-audits issue hygiene; releases stale work
       ▼
GitHub Issues (pickable)
       │
       │  /pickup [#N]            — claim, branch, work, PR (autonomous)
       ▼
PR opened, issue auto-closed on merge
```

### Issue contract

Every `claude-ready` issue uses the template at `.github/ISSUE_TEMPLATE/claude-task.md` and contains:

- **Goal** — one sentence
- **Scope** — explicit `In:` and `Out:` lists (prevents scope creep)
- **Acceptance Criteria** — verifiable, pass/fail items
- **Files Affected** — every file the implementation touches
- **Verification** — exact commands a reviewer can run
- **Size** — XS (<1hr) / S (1-3hr) / M (3-6hr) — never L
- **Type** — feature / bug / perf / refactor (determines workflow)
- **Blocked by** — issue numbers that must close first

If any section is missing or vague, the issue is not pickable.

### Labels

| Label | Meaning |
|---|---|
| `claude-ready` | Fully groomed, no blockers, ready for `/pickup` |
| `needs-grooming` | Exists as a placeholder; needs scope/criteria filled in |
| `in-progress` | Currently being worked; do not pick up |
| `blocked` | Has open dependencies; recheck after blocker closes |
| `type:feature` / `type:bug` / `type:perf` / `type:refactor` | Determines pickup workflow |
| `size:xs` / `size:s` / `size:m` | Effort estimate (no `size:l` — L items must be groomed down) |
| `priority:critical` / `priority:high` | Pickup priority overrides |

### When to use what

| Situation | Command |
|---|---|
| User requests a roadmap-sized initiative | `/groom <epic>` to break into issues, then work them |
| User requests a specific small change | Skip the issue tracker — just do the work or use `/add-feature` directly |
| Scheduled / autonomous session | `/pickup` (no args) — picks the highest-priority unblocked issue |
| Working a specific known issue | `/pickup <N>` |
| Issue queue feels stale | `/triage` |
| Performance hot path identified | `/perf <subsystem>` (with or without an issue) |

### Anti-patterns

- **Don't pick up a `needs-grooming` issue.** Run `/groom` on it first to flesh out the contract, then pick it up.
- **Don't expand scope mid-session.** If an issue's `In:` is wrong, comment on the issue and pause for human input.
- **Don't bundle multiple issues into one PR** unless they're explicitly listed as a single issue. Issues were sized to be standalone.
- **Don't use `/pickup` to pull from the roadmap directly.** The roadmap isn't pickable. Issues are.

## Common Development Patterns

### Adding a Language Feature

Use `/add-feature <name>` for the full orchestrated workflow. The pipeline stages are:

1. Update `compiler/src/parser.sfn` to recognize new syntax
2. Add AST node(s) to `compiler/src/ast.sfn`
3. Update `compiler/src/emit_native.sfn` to emit `.sfn-asm`
4. Extend `compiler/src/llvm/lowering/` (e.g. `entrypoints.sfn`) for LLVM
5. Add regression tests to `compiler/tests/`
6. Update `docs/spec.md` (Part A if shipped, Part B if planned)
7. Update `docs/status.md` with implementation status

### Fixing Effect Checker Issues

Effect diagnostics include source spans and suggested fixes. If a function calls an effectful helper without declaring the effect:

1. Check `compiler/src/effect_checker.sfn` for the inference logic
2. Add the required effect to the function signature: `fn foo() ![io] { ... }`
3. Ensure parent callers also declare transitive effects

### Working with the Native Compiler (LLVM Backend)

Native compiler coverage lives in Sailfin-native tests under `compiler/tests/`:

```bash
make test         # Run unit + integration + e2e suites
make test-unit
make test-integration
make test-e2e
```

**Key files:**

- `compiler/src/llvm/` — LLVM IR generation (lowering, rendering, runtime helpers)
- `compiler/tests/` — Sailfin-native unit/integration/e2e suites
- `runtime/native/` — C runtime linked into the native compiler

### Running Examples

Examples in `examples/` demonstrate language features:

```bash
make compile
build/native/sailfin run examples/basics/hello-world.sfn
```

Check `examples/README.md` for capability requirements (`![io]`, `![model]`, etc.).

## Source of Truth Documents

When uncertain about feature status or semantics:

1. **`docs/status.md`** — What ships today (Stage0/1/2 breakdown)
2. **`docs/spec.md`** — Language reference (Part A: bootstrap, Part B: planned)
3. **`docs/roadmap.md`** — Active workstreams and sequencing
4. **`docs/runtime_audit.md`** — Python→Sailfin migration tracker

**Examples are bootstrap-only** unless marked with future syntax comments (e.g., `|>` pipeline operator, currency literals like `$0.05`).

## Stabilization Goals (Pre-1.0)

The project is marching toward a 1.0 release with a **pure Sailfin toolchain** — no Python, no C runtime, no downstream fixup scripts. All compiler improvements must target the compiler source code itself (`compiler/src/*.sfn`), not external workarounds.

**Full stabilization guide:** See `docs/build-performance.md` for the build performance analysis and optimization plan.

### Seed Strategy

The compiler self-hosts from a released seed binary using `scripts/build.sh` (pure shell, no fixups). The current seed (0.5.0-alpha.22+) produces clean LLVM IR — no Python post-processing required.

**Build flow:**
1. Fetch a released seed: `make fetch-seed`
2. Build the compiler from the seed: `make compile` (uses `build.sh`)
3. Run tests: `make test`
4. Validate self-hosting: `make check` (builds seedcheck from first-pass binary, runs tests on it)

### Build Driver Configuration

```bash
make compile                    # Build from seed (uses scripts/build.sh)
make rebuild                    # Force rebuild from seed
```

### Development Principles

- **Fix the compiler, not the build script.** All compiler improvements go into `compiler/src/*.sfn`. The build script (`scripts/build.sh`) is pure orchestration — no fixups, no post-processing.
- **The seedcheck binary must be a fully functional standalone compiler.** `make check` validates that it can run `hello-world.sfn` and pass the test suite directly.
- **Build must be fast and deterministic.** Current: ~13 min. Target: under 5 minutes. See `docs/build-performance.md` for the optimization plan.
- **Reduce complexity, don't add it.** The build uses `scripts/build.sh` (pure shell, no fixups).

### `make check` Validation

`make check` does:
1. Builds the compiler from the seed using `build.sh`
2. Runs the full test suite on the first-pass binary (early gate)
3. Builds seedcheck from the first-pass binary using `build.sh`
4. Validates the seedcheck can actually run `examples/basics/hello-world.sfn`
5. Runs the full test suite using the seedcheck binary directly

If `make check` fails, it means the compiler has a bug. Fix the compiler.

## Pre-1.0 Syntax Reform (Active)

The following breaking syntax changes are planned before 1.0. All new code
written by agents or humans should prefer the new forms where the parser already
accepts them. See `docs/roadmap.md` §0 for the full plan and rationale.

1. **Type annotations: `:` not `->`** — Use `x: number` not `x -> number` for
   parameters, variables, and fields. Return types keep `->`. The parser already
   accepts both via `TypeSep = "->" | ":"`.
2. **String interpolation: `${ }` not `{{ }}`** — Target delimiter is `${ expr }`.
   Parser change pending; continue using `{{ }}` until the parser is updated.
3. **Integer types** — `int` (i64) and `float` (f64) will replace the single
   `number` type. `number` becomes an alias for `float`. Not yet in parser.
4. **`Result<T, E>` + `?` operator** — Typed error handling to complement
   `try`/`catch`. Not yet in parser.
5. **Closures with capture** — Lambdas must capture enclosing variables.

### Design Decision Framework

When adding features or making design choices, apply these principles:

- **Boring syntax wins.** Every deviation from mainstream conventions adds
  learning curve with zero expressiveness gain. Match TypeScript/Rust/Python
  conventions unless there's a compelling semantic reason not to.
- **AI agents are users.** LLMs have zero `.sfn` training data. Conventional
  syntax reduces error rates in generated code. Unusual choices cause systematic
  LLM failures.
- **Pick 3 differentiators.** Sailfin's top 3 are: (1) effect system,
  (2) capability-based security, (3) structured concurrency. Don't dilute these
  with half-finished ownership, AI constructs, or GPU features.
- **Don't ship unfinished safety claims.** "Parsed but not enforced" is worse
  than not having the syntax at all — it teaches users to ignore the feature.
- **Keywords are expensive.** A keyword can never become a variable name. Only
  add keywords for constructs that can't be expressed as library functions.
- **Fix the foundation first.** Integer types, `Result<T, E>`, and generic
  constraints are prerequisites for everything else.

## Important Constraints

### Bootstrap Limitations

- No pipeline operator (`|>`) — use function calls
- No currency literals — use numeric literals with comments (`0.05 // USD`)
- `Affine<T>`/`Linear<T>` parsed but not enforced
- `PII<T>`/`Secret<T>` parsed but no runtime enforcement
- `model` blocks emit metadata only (no `.call()` execution)
- `prompt` blocks are parsed but don't send messages

### Bootstrap (stage1) Readiness Checklist

Before declaring a feature "shipped in Stage1":

1. Parses correctly (`compiler/src/parser.sfn`)
2. Type-checks or effect-checks (`compiler/src/typecheck.sfn`, `compiler/src/effect_checker.sfn`)
3. Emits valid `.sfn-asm` (`compiler/src/emit_native.sfn`)
4. Lowers to LLVM IR (`compiler/src/llvm/lowering/entrypoints.sfn`)
5. Has regression coverage (`compiler/tests/`)
6. Self-hosts (compiler compiles itself)
7. Documented in `docs/status.md` and `docs/spec.md` Part A

### Do Not Use Python Bootstrap (Stage0)

All development goes through the bootstrap compiler (legacy name: stage1) and the self-hosted native compiler (legacy name: stage2):

- To modify the compiler: edit `compiler/src/*.sfn`
- To run tests: `make test` (bootstraps the native compiler as needed)
- To build a native compiler: `make compile`

## Testing Guidance

### Writing Regression Tests

```sfn
// compiler/tests/unit/my_feature_test.sfn
import { parse_program } from "../../src/parser/mod";

test "parser: parses effectful fn" {
    let source = "fn foo() ![io] { print.info(\"hello\"); }";
    let program = parse_program(source);
    assert program.statements.length == 1;
}
```

### Debugging Compilation Failures

1. Isolate the failing `.sfn` source
2. Run `make compile` to see bootstrap compiler errors
3. Run `build/native/sailfin test path/to/test_file.sfn` for focused output
4. Review diagnostics for source spans and fix-it hints

### Self-Hosting Invariants

The compiler must always compile itself. Breaking changes require:

1. Implement in Sailfin (`compiler/src/*.sfn`)
2. Ensure the selfhost build still succeeds (`make compile`)
3. Ensure integration coverage still passes (`make test-integration`)

## Versioning & Releases

- **Semantic versioning:** `v0.5.0-alpha.22` format — `MAJOR.MINOR.PATCH[-channel.N]`
- **Version source of truth:** `compiler/capsule.toml` (`[capsule] version`)
- **Version resolution:** `compiler/src/version.sfn:resolve_compiler_version()` reads `capsule.toml` at runtime; falls back to `__version_fallback__` for installed binaries where `capsule.toml` is not on disk
- **Dev build stamps:** `build.sh` writes `build/native/.build-stamp` with `<version>+dev.<hash>` — the resolver reads this first for local dev builds
- **Release automation:** `.github/workflows/release.yml` — manually triggered via `workflow_dispatch`, pure bash, no Python dependencies
- **Release notes:** `.github/workflows/release-notes.md` — agentic workflow that posts structured, categorized changelog comments on published releases (supplements the auto-generated notes from `gh release create`)
- **Artifacts:** `dist/` is used for packaged artifacts; `release-tag.yml` builds and uploads platform binaries
- **Claude skill:** Use `/release` to trigger a new release from Claude Code

### Triggering a Release

Releases are **not** automatic on merge. Use the GitHub Actions UI or CLI:

```bash
# Cut a new alpha prerelease
gh workflow run release.yml -f channel=alpha -f bump=prerelease

# Promote current version to beta
gh workflow run release.yml -f channel=beta -f bump=prerelease

# Promote to release candidate
gh workflow run release.yml -f channel=rc -f bump=prerelease

# Ship a stable GA release
gh workflow run release.yml -f channel=stable -f bump=prerelease

# Start a new minor alpha cycle
gh workflow run release.yml -f channel=alpha -f bump=minor

# Dry run (compute version without making changes)
gh workflow run release.yml -f channel=alpha -f bump=prerelease -f dry_run=true
```

## Branch Strategy (trunk-based)

- `main`: Primary development branch — all feature work merges here. Releases are cut from `main` via the manual release workflow.
- `beta`: Short-lived, cut from `main` when ready for beta testing. Produces `-beta.N` prereleases. Do **not** merge `beta` back into `main`; delete the branch after the beta cycle completes.
- `rc`: Short-lived, cut from `main` (or `beta`) for release candidates. Produces `-rc.N` prereleases. Do **not** merge `rc` back into `main`; delete the branch after the RC cycle completes.
- Fixes always land on `main` first, then cherry-pick or merge forward from `main` to `beta`/`rc` if needed. If a change made on `beta`/`rc` must be kept, cherry-pick only the non-release commits back to `main` (avoid commits that modify `compiler/capsule.toml`, `compiler/src/version.sfn`, or `CHANGELOG.md`).
- To promote to stable, run the release workflow with `channel=stable bump=prerelease` from `main`.

## Key Terminology

- **Capsule**: A Sailfin package with `capsule.toml` manifest
- **Workspace**: Multi-capsule project with shared `workspace.toml` policies
- **Effect**: Capability annotation (`![io]`, `![net]`, etc.)
- **Generation card**: Provenance metadata for model calls (input hashes, cost, latency, seed)
- **Native IR**: `.sfn-asm` textual intermediate representation
- **Prelude**: Core runtime library (`runtime/prelude.sfn`)
- **Stage0/1/2**: Bootstrap (Python) / Self-hosted (Sailfin→Python) / Native (Sailfin→LLVM)
