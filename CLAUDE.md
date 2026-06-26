# CLAUDE.md

Guidance for Claude Code when working in this repository.

> **Companion files (auto-loaded, authoritative — don't restate them here):**
> `.claude/rules/` enforces the memory cap, self-hosting invariant, formatting,
> and change discipline. `.claude/agents/*.md` define the specialist subagents.
> `.github/AGENTS.md` defines the autonomous GitHub agent pyramid. This file is
> the project map; those files are the law.

## Project Overview

Sailfin is a systems language with compile-time capability enforcement. This
repo hosts the **self-hosted native compiler** (the primary toolchain), marching
toward a 1.0 release with a pure Sailfin toolchain — no Python, no C runtime, no
downstream fixup scripts.

The compiler self-hosts from a released seed binary via `<seed> build -p compiler`,
and its entry point is the Sailfin-emitted `@main`. The runtime is pure Sailfin
(`runtime/sfn/` + `runtime/prelude.sfn`); the former C runtime under
`runtime/native/` was deleted (#822), so no C code participates in startup or
links into the compiler.

**Three pillars (the differentiators — don't dilute them):**
1. **Effect types** (`![io, net, model, clock]`) for compile-time capability enforcement
2. **Capability-based security** via capsule manifests and dependency auditing
3. **Structured concurrency** (planned)

AI integration is a library concern (`sfn/ai` capsule, post-1.0) gated by the
`![model]` effect — not language syntax.

> Internal paths may still use the historical `stage2` name. Prefer "native
> compiler" in new code and docs.

## Essential Commands

```bash
sfn check <files>     # Fast static analysis (parse + typecheck + effect-check) — the inner loop
make compile          # Self-host the compiler from a released seed (preferred)
make rebuild          # Force a rebuild from the seed
make install          # Install the built compiler into PREFIX/bin (default: ~/.local/bin)
make check            # Compile (if needed) + run the full suite + validate self-hosting
make test             # Run the full suite
make test-unit        # Sailfin-native unit tests
make test-integration # Sailfin-native integration tests
make test-e2e         # Sailfin-native e2e tests
make bench            # Benchmark per-module compile time and memory
make fetch-seed       # Download the pinned seed (.seed-version)
make clean            # Remove dist/ artifacts
make clean-build      # Remove build/* artifacts (keeps build/seed) — destructive, gate on approval
make mcp-server       # Build the MCP server wrapper
```

Run examples: `make compile && build/native/sailfin run examples/basics/hello-world.sfn`.
See `examples/README.md` for per-example capability requirements.

**Validation ladder — use the cheapest tool that catches the error.** `sfn check`
and `make check` are different tools, not fast/slow versions of the same one:

1. **`sfn check <files>`** — fast static analysis (parse + typecheck + effect-check),
   no IR / `clang` / self-host. Seconds for a few files, ~5 min for the whole
   `compiler/src/` tree. Use it as the **inner loop** after every edit. It catches
   type, effect, and parse errors but does **not** prove self-hosting. Because it
   models no codegen or link, a narrow class of **build-only failures can still pass
   `check`** — `check` green is not a build guarantee (#1389). The known instance
   (runtime-evaluated module globals failing at link, #1386) is fixed and guarded by
   `compiler/tests/e2e/check_build_agree_module_global_test.sfn`; clear the bar with
   `make compile` before declaring any `compiler/src/*.sfn` change done.
2. **`make compile`** — self-hosts the compiler. Required before committing any
   `compiler/src/*.sfn` change (the self-host invariant).
3. **`make check`** — full triple-pass self-host + suite (~15–20 min). Reserve for
   declaring a feature shipped, cutting a release, or after a structural change.

Don't burn `make check` to discover a type or effect error `sfn check` would have
caught in seconds. (Use `build/native/sailfin check <path>` if `sfn` is not on `PATH`.)

**MCP tools (agentic clients).** When running as an MCP client (e.g. Claude Code
with the `sailfin` server registered in `.mcp.json`), prefer the `sailfin_*` tools
for the inner loop instead of shelling out: `sailfin_check` / `sailfin_diagnostics`
(fast static analysis, JSON envelope), `sailfin_fmt_write` + `sailfin_fmt_check`
(format then verify a touched file), `sailfin_build` (build a `.sfn` file or capsule),
and `sailfin_test` (a targeted suite dir or a single `_test.sfn` file, with `-k` to
run one named test). Each is a pure passthrough to one `sailfin` subcommand. They
do **not** replace `make compile` (the compiler self-host needs seed + extern
pre-staging the tools deliberately don't replicate) or `make check` — use those
for the self-host invariant and the full gate. See `tools/mcp-server/README.md`.

## Compiler Pipeline

`compiler/src/` follows this flow:

1. **Lexer** (`lexer.sfn`) → tokens
2. **Parser** (`parser.sfn`) → AST (`ast.sfn`)
3. **Type Checker** (`typecheck.sfn`) → duplicate symbols, interface conformance
4. **Effect Checker** (`effect_checker.sfn`) → validates `![effect, ...]` annotations
5. **Native Emitter** (`emit_native.sfn`) → `.sfn-asm` IR (`native_ir.sfn`)
6. **LLVM Lowering** (`compiler/src/llvm/lowering/entrypoints.sfn`) → LLVM IR

**Critical files:**

| File | Role |
|---|---|
| `compiler/capsule.toml` | Version source of truth + capsule manifest |
| `compiler/src/main.sfn` | Entry point orchestrating all passes |
| `compiler/src/ast.sfn` | Canonical AST node definitions |
| `compiler/src/native_ir.sfn` | `.sfn-asm` intermediate representation |
| `compiler/src/cli_main.sfn` + `capsule_resolver.sfn` | The build driver — **pure orchestration, no fixups** |
| `compiler/src/build_stamp.sfn` | Writes `build/native/.build-stamp` (`<version>+dev.<hash>`) |
| `runtime/prelude.sfn` | Sailfin-native runtime (collections, strings, type checks) |
| `runtime/sfn/` | Sailfin-native runtime modules (memory, string, io, concurrency) |
| `compiler/tests/{unit,integration,e2e}/*_test.sfn` | Regression coverage |

## Effect System

Functions/tests/pipelines declare required capabilities:

```sfn
fn fetch_order(id: OrderId) -> Order ![io, net] { ... }
```

**Canonical effects:** `io`, `net`, `model`, `gpu`, `rand`, `clock`

**Enforcement** (`effect_checker.sfn`) walks nested blocks, lambdas, and `routine`
scopes; missing effects emit diagnostics with source spans and fix-it hints:

- `model` → `prompt` blocks
- `io` → `print.*`, `console.*`, `fs.*`, decorators like `@logExecution`
- `net` → `http.*`, `websocket.*`, `serve`
- `clock` → `sleep`, `runtime.sleep`

Effect enforcement is real on Linux x86_64 but partial on macOS arm64 (see #613
for the open headline-integrity gaps). When a function calls an effectful helper
without declaring the effect: check the inference in `effect_checker.sfn`, add
the effect to the signature, and ensure parent callers declare it transitively.

## Build & Self-Hosting

The compiler self-hosts from a released seed using `<seed> build -p compiler` —
the unified Sailfin-native driver.

**`make check`** is the full validation gate:
1. Builds the compiler from the seed (first-pass binary)
2. Runs the full suite on the first-pass binary (early gate)
3. Builds the seedcheck binary from the first-pass binary
4. Validates seedcheck can run `examples/basics/hello-world.sfn`
5. Runs the full suite on the seedcheck binary directly

If `make check` fails, the compiler has a bug — **fix the compiler, not the
build.** All fixes land in `compiler/src/*.sfn`. The driver is pure
orchestration; add no fixups or post-processing. The seedcheck binary must be a
fully functional standalone compiler.

Build performance plan and target (<5 min) live in `docs/proposals/0006-build-architecture.md` (Build performance section).

## Stage1 Readiness Checklist

Before declaring a feature "shipped":

1. Parses (`parser.sfn`)
2. Type-checks / effect-checks (`typecheck.sfn`, `effect_checker.sfn`)
3. Emits valid `.sfn-asm` (`emit_native.sfn`)
4. Lowers to LLVM IR (`llvm/lowering/entrypoints.sfn`)
5. Has regression coverage (`compiler/tests/`)
6. Self-hosts (compiler compiles itself)
7. Passes `sfn fmt --check` on every touched `.sfn` file (CI gate)
8. Documented in `docs/status.md` and the relevant spec §N chapter

"Parsed but not enforced" is **not** "shipped" — never market or document an
unenforced feature.

## Adding a Language Feature

Use `/add-feature <name>` for the orchestrated workflow. The pipeline stages:

1. `parser.sfn` — recognize new syntax
2. `ast.sfn` — add AST node(s)
3. `emit_native.sfn` — emit `.sfn-asm`
4. `llvm/lowering/` — lower to LLVM IR
5. `compiler/tests/` — regression tests
6. Spec: `site/src/content/docs/docs/reference/spec/` (shipped, §N chapter) or
   `.../reference/preview/` (planned, design preview)
7. `docs/status.md` — implementation status
8. `sfn fmt --write` on every touched `.sfn` file

The design behind a non-trivial feature is recorded as an **SFEP** under
`docs/proposals/` (the architect drafts it; it's `Accepted` at the design gate
and graduated to `Implemented` when it ships). See `.claude/rules/proposals.md`.

Writing a regression test:

```sfn
// compiler/tests/unit/my_feature_test.sfn
import { parse_program } from "../../src/parser/mod";

test "parser: parses effectful fn" {
    let source = "fn foo() ![io] { print.info(\"hello\"); }";
    let program = parse_program(source);
    assert program.statements.length == 1;
}
```

## Design Decision Framework

When adding features or making design choices:

- **Boring syntax wins.** Match TypeScript/Rust/Python conventions unless there's
  a compelling semantic reason not to. Every deviation adds learning curve with
  zero expressiveness gain.
- **AI agents are users.** LLMs have zero `.sfn` training data; conventional
  syntax reduces error rates in generated code. Unusual choices cause systematic
  LLM failures.
- **Pick 3 differentiators.** Effects, capabilities, concurrency. Everything else
  is a library concern or post-1.0. Don't dilute the core with half-finished
  ownership, AI syntax, or GPU features.
- **Don't ship unfinished safety claims.** "Parsed but not enforced" is worse than
  absent — it teaches users to ignore the feature. Taint and AI constructs stay
  out of marketing until enforced end-to-end. **Exception:** runtime
  ownership/aliasing enforcement *is* shipped end-to-end for the native runtime
  (Phase R1, epic #1209), so it may be documented as enforced for that surface;
  user-facing ownership stays previewed until Phase U.
- **Libraries over keywords.** A keyword can never become a variable name. Only
  add keywords for constructs that can't be library functions. AI constructs
  (`model`, `prompt`, `tool`, `pipeline`) are migrating to the `sfn/ai` capsule;
  the `![model]` effect stays as a language-level capability gate.
- **Fix the foundation first.** Integer types, `Result<T, E>`, generic
  constraints, hierarchical effects, and effect polymorphism are prerequisites
  for everything else.
- **Chase timeless problems.** Effects and capability security matter in 20 years;
  AI API wrappers change every 6 months. Language syntax is permanent; library
  APIs can iterate.

## Pre-1.0 Syntax Reform (Active)

Prefer the new forms where the parser already accepts them. Full plan:
`docs/proposals/0005-colon-type-annotations.md` and the roadmap.

1. **Type annotations: `:` not `->`** — `x: number`, not `x -> number`, for params,
   vars, fields. Return types keep `->`. Parser accepts both (`TypeSep = "->" | ":"`).
2. **String interpolation: `${ }` not `{{ }}`** — parser change pending; keep
   `{{ }}` until updated.
3. **Integer types** — `int` (i64) / `float` (f64) will replace `number`
   (`number` becomes an alias for `float`). Not yet in parser.
4. **`Result<T, E>` + `?` operator** — typed error handling. Not yet in parser.
5. **Closures with capture** — lambdas must capture enclosing variables.

## Deferred / Not Yet Shipped

- No pipeline operator (`|>`) — use function calls
- No currency literals — use numeric literals with comments (`0.05 // USD`)
- **Ownership/aliasing analysis** — a bounded unique-ownership / no-aliased-mutation
  / no-use-after-free analysis is **enforced on the native runtime** for 1.0 as a
  memory-safety floor (`ownership_checker.sfn`, epic #1209; closes the #1205
  aliasing-corruption hazard structurally). It is **not a fourth pillar** — it is a
  soundness requirement in the same category as type checking, not a marketed
  differentiator; the three pillars stay effects, capabilities, concurrency.
  `Affine<T>` / `Linear<T>` are enforced single-use where used (`E0901`/`E0907`);
  `OwnedBuf` / `Slice` carry the runtime's owned-buffer surface. **User-facing
  ownership and full borrow checking remain post-1.0** (Phase U). The model is a
  deliberately **extensible floor** built upward from (D1 expansion mandate),
  **not** a Rust-style borrow checker. See `reference/preview/ownership.md`.
- `PII<T>` / `Secret<T>` parsed, no runtime enforcement (post-1.0)
- `model` / `prompt` / `tool` / `pipeline` blocks emit metadata only (migrating
  to the `sfn/ai` capsule)
- No concurrency runtime (`routine`, `spawn`, `channel`, `await`)

The 1.0 critical path (runtime enablement phases, effect-system hardening) and
the LLM-adoption strategy live in the roadmap and `docs/status.md` — those
are the source of truth and change too often to mirror here.

## Workflows & Agents

Slash commands orchestrate multi-phase workflows via specialist subagents — use
them instead of hand-driving each step. Agent definitions live in
`.claude/agents/*.md`; the orchestrator persona governs delegation.

| Command | When to use |
|---|---|
| `/add-feature <name>` | Adding any language feature (architect → implement → review → test → docs) |
| `/debug-compile <file>` | Any compilation failure |
| `/check` | Pre-commit validation (clean build → suite → seedcheck) |
| `/test-feature <name>` | Testing a specific area |
| `/perf <subsystem>` | Performance hot path |
| `/release`, `/release-plan` | Cutting / planning a release |
| `/groom`, `/triage`, `/pickup`, `/sweep` | Issue lifecycle (see Task Tracking) |
| `/sfep <new\|status\|list\|graduate>` | Create/transition a design proposal (SFEP) — see `.claude/rules/proposals.md` |

**Approval gates** — pause for explicit user approval before: the design gate in
`/add-feature` (after the architect's plan, before code), destructive ops
(`make clean-build`, force-push, branch deletion), and shared-state changes
(pushing, opening/closing PRs, releases). Everything else proceeds autonomously;
when something fails, diagnose root cause before trying a different approach.

**Use direct tools (Read/Grep/Glob/Edit), not an agent,** when you know the file,
the search is a simple keyword, or the change is a one-line obvious fix. Agents
earn their cost on open-ended investigation and cross-cutting analysis.

## Task Tracking

The roadmap (`site/src/pages/roadmap.astro`, [sailfin.dev/roadmap](https://sailfin.dev/roadmap))
is strategic — epics, not session-sized work. Day-to-day work lives in **GitHub
Issues**, scoped so a single session takes an issue from open to merged PR.

```
roadmap (epics) ──/groom──▶ Issues (claude-ready) ──/triage──▶ pickable
                                   │
                                   └──/pickup [#N]──▶ PR opened, issue auto-closed on merge
```

**Issue contract** (template: `.github/ISSUE_TEMPLATE/claude-task.md`): Goal,
Scope (`In:`/`Out:`), Acceptance Criteria, Files Affected, Verification, Size
(XS/S/M — never L), Type, Blocked by. Missing or vague → not pickable.

**Design records (SFEPs).** A substantive epic's design lives in an **SFEP** —
a numbered proposal under `docs/proposals/` (`docs/proposals/README.md` is the
registry; process in `.claude/rules/proposals.md`). `/groom` creates or links the
epic's SFEP and sub-issues cite it (`## Design: SFEP-NNNN`) instead of
duplicating the design; `/pickup` reads it as the brief; it graduates to
`Implemented` when the feature ships. The SFEP is the durable *why*; the issue is
the session-sized *what*.

**Labels** are registered in `.github/labels.yml`; conventions and the lifecycle
diagram are in `docs/conventions/issue-naming.md`. Key ones: `claude-ready`,
`needs-grooming`, `in-progress`, `blocked`, `type:*`, `size:*`, `priority:*`,
`area:*`, `epic`/`tracking`. Slash commands that flip labels must follow with
`.claude/scripts/sync-project-status.sh <N> --from-labels` to move the
Sailfin Tracker (org project SailfinIO/4) card.

**Anti-patterns:** don't pick up `needs-grooming` (groom first); don't expand
scope mid-session (comment and pause); don't bundle issues into one PR; don't
`/pickup` from the roadmap (it isn't pickable — issues are).

## Source-of-Truth Documents

When uncertain about feature status or semantics:

1. **`docs/status.md`** — what ships today
2. **Language spec** — `site/src/content/docs/docs/reference/spec/` (§1–§11) and
   `.../reference/preview/` (design previews); rendered at
   [sailfin.dev/docs/reference/spec/](https://sailfin.dev/docs/reference/spec/)
3. **[sailfin.dev/roadmap](https://sailfin.dev/roadmap)** — active workstreams (`site/src/pages/roadmap.astro`)
4. **`docs/status.md` (Runtime Migration table)** — C→Sailfin runtime migration tracker
5. **`docs/proposals/0006-build-architecture.md`** — build architecture and perf baseline
6. **`docs/strategy/decision-brief.md`** — strategic overlay binding the internal
   vision (the capstone `docs/proposals/0016-capability-sealed-runtime.md`) to the
   market: what's *enforced now* (compile-time effects) vs. the *runtime seal*
   (built, not yet shipped), and the seal-sufficient-vs-perf-parity fork. As of
   2026-06-26 the capability-sealed runtime is a **1.0 hallmark / GA blocker**
   (epic #1639), not a post-1.0 capstone — see the brief's repositioning banner.
   Proposal docs win on architecture; the brief wins on positioning.

Examples are compiler-only unless marked with future-syntax comments.

## Versioning & Releases

- **Semver:** `v0.5.0-alpha.22` — `MAJOR.MINOR.PATCH[-channel.N]`
- **Version source of truth:** `compiler/capsule.toml` (`[capsule] version`)
- **Resolution:** `compiler/src/version.sfn:resolve_compiler_version()` reads
  `capsule.toml` at runtime; for local dev builds it reads `build_stamp.sfn`'s
  `build/native/.build-stamp` first; installed binaries fall back to
  `__version_fallback__`.
- **Release automation:** `.github/workflows/release.yml` (manual
  `workflow_dispatch`, pure bash). Release notes: `.github/workflows/release-notes.md`.
- **Seed pinning is separate from release cutting** — `.seed-version` is bumped by
  `/pin-seed` after `release-tag.yml` uploads binaries, never by `release.yml`.
  The `seed-blocker` label tracks "must close before next seed bump" issues.
- **Curation:** only `channel=alpha bump=prerelease` is uncurated; every other
  combo consults the `release:*` labels and the per-cycle `Release: vX.Y.Z`
  tracking issue. See `docs/conventions/issue-naming.md`.

Releases are **not** automatic on merge:

```bash
gh workflow run release.yml -f channel=alpha -f bump=prerelease            # new alpha prerelease
gh workflow run release.yml -f channel=alpha -f bump=minor                 # start a new minor cycle
gh workflow run release.yml -f channel=beta  -f bump=prerelease            # promote to beta
gh workflow run release.yml -f channel=stable -f bump=prerelease           # ship GA
gh workflow run release.yml -f channel=alpha -f bump=prerelease -f dry_run=true  # dry run
```

## Branch Strategy (trunk-based)

- **`main`** — primary development; all feature work merges here; releases cut from here.
- **`beta` / `rc`** — short-lived, cut from `main` for `-beta.N` / `-rc.N` prereleases.
  Do **not** merge back into `main`; delete after the cycle.
- Fixes land on `main` first, then cherry-pick forward. When cherry-picking from
  `beta`/`rc`, avoid commits touching `compiler/capsule.toml`,
  `compiler/src/version.sfn`, or `CHANGELOG.md`.

## Key Terminology

- **Capsule** — a Sailfin package with a `capsule.toml` manifest declaring capability requirements
- **Workspace** — multi-capsule project with shared `workspace.toml` policies
- **Effect** — capability annotation (`![io]`, `![net]`, …); the core differentiator
- **Capability enforcement** — compile-time guarantee that code cannot exceed its declared effects
- **Native IR** — `.sfn-asm` textual intermediate representation
- **Prelude** — core runtime library (`runtime/prelude.sfn`)
- **Seed** — a released compiler binary used to self-host the current source
- **Seedcheck** — the second-pass binary built by the first-pass binary; proves self-hosting
