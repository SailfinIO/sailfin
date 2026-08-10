# GEMINI.md

Sailfin is a systems language that **emits proof, not just binaries**: every build
produces a machine-checked contract about the code — what it can reach, what
numbers it produces, what it costs to run — verifiable by someone who does not use
Sailfin. This repo is the **self-hosted native compiler**, marching toward 1.0 on a
pure Sailfin toolchain — no Python, no C runtime, no fixup scripts. The compiler
self-hosts from a released seed via `<seed> build -p compiler`; the runtime is pure
Sailfin (`runtime/sfn/` + `runtime/prelude.sfn`).

**Three pillars — don't dilute them.** Each is a *proof*, not a prohibition:

| Pillar | Claim | Mechanism |
|---|---|---|
| **Reach** | the compiler derives a capability manifest and proves it **complete** | effect types (`![io, net, …]`), capsule manifests, `E0402`/`E0403`, the seal (SFEP-0016) as runtime enforcement |
| **Result** | the same program yields the same bits, and mixed precision cannot compile | numerics contract (SFEP-0054/0062): exact dtype identity, no implicit promotion, ≥f32 accumulators, no reassociation, bit-exact oracle |
| **Cost** | this schedule, on this target, hits these numerics at this measured throughput — and finishes or is cancelled | schedule-as-contract; structured concurrency (nurseries, cancel-on-fault, deadlines) as the liveness half |

Pillar names are **positioning words, never identifiers** — "Result" collides with
`Result<T, E>` (SFEP-0012), so code, artifacts, and diagnostics use `contract`.
The externally honest phrasing today is "gradeable by a stranger, trusting our
arithmetic"; "verifiable" lands when SFEP-0062 Phase 5 ships the derivation
vectors.

**The restriction-vs-power test — apply it before committing capacity.** A feature
that only *forbids* something needs a power attached or it does not ship as a
headline. "Declare `![net]` so reviewers can see reach" fails (payer ≠
beneficiary); "the compiler derives a complete manifest you can ship and attest"
passes. Governance is a feature of a language people already chose, never a reason
to choose one. Full reasoning and the retraction list:
`docs/strategy/decision-brief.md`.

AI integration is a post-1.0 library concern (`sfn/ai`), gated by `![model]`,
never language syntax.

> Internal paths may still say `stage2`. Prefer "native compiler" in new work.

## The validation ladder

`sfn check` and `make check` are **different tools**, not fast/slow versions of the same one. Use the cheapest rung that catches the error.

1. **`sfn check <files>`** — parse + typecheck + effect-check. No IR, no `clang`,
   no self-host. Seconds for a few files, ~5 min for all compiler sources.
   The inner loop. It models no codegen or link, so **a build-only failure can
   still pass `check` — green is not a build guarantee** (#1389).
2. **`make compile`** — self-hosts. **Required before any `.sfn` change under
   `compiler/src/` or `compiler/capsules/` is done.** Structural changes (file splits, new modules, renamed
   exports) need `make clean-build` first.
3. **Targeted tests** — `build/bin/sfn test <path>`, `-k <name>` for one test.
   Issue acceptance should name these narrow commands.
4. **`make check`** — full triple-pass self-host + suite, ~15–20 min. Reserve for
   shipping a feature, cutting a release, or after a structural change.

Never burn `make check` to discover what rung 1 or 3 would have caught. Run
`make help` for the full target list.

## Pipeline and critical files

`sfn/syntax` lexer/parser/AST → `sfn/analyzer` type/effect analysis
→ `emit_native.sfn` (`.sfn-asm`) → `llvm/lowering/entrypoints.sfn` (LLVM IR).

| File | Role |
|---|---|
| `compiler/capsule.toml` | Version source of truth + capsule manifest |
| `compiler/src/main.sfn` | Entry point orchestrating all passes |
| `compiler/capsules/syntax/src/ast.sfn` | Canonical AST node definitions |
| `compiler/capsules/analyzer/src/mod.sfn` | Pure analyzed-program facade |
| `compiler/capsules/ir/src/native_ir.sfn` | `.sfn-asm` intermediate representation |
| `compiler/src/cli/` + `capsule_resolver.sfn` | Build driver (`entry.sfn` = `fn main`, `main.sfn` = dispatch) — **pure orchestration, no fixups** |
| `compiler/src/build_stamp.sfn` | Writes `build/native/.build-stamp` |
| `runtime/prelude.sfn`, `runtime/sfn/` | Sailfin-native runtime |
| `compiler/tests/{unit,integration,e2e}/*_test.sfn` | Regression coverage |

**Canonical effects:** `clock`, `gpu`, `io`, `model`, `net`, `rand`
(`compiler/capsules/analyzer/src/effect_taxonomy.sfn::canonical_effects()`).
`compiler/capsules/analyzer/src/effect_checker/` walks nested
blocks, lambdas, and `routine` scopes. Enforcement is real on Linux x86_64,
partial on macOS arm64 (#613). When a function calls an effectful helper without
declaring the effect, add it to the signature and make parent callers declare it
transitively.

## Stage1 readiness

Before calling a feature shipped: parses → type/effect-checks → emits valid
`.sfn-asm` → lowers to LLVM IR → has regression coverage → self-hosts → passes
`sfn fmt --check` → documented in `docs/status.md` and the spec chapter.

**"Parsed but not enforced" is not shipped** — never market or document an
unenforced feature.

## Design judgment

- **Boring syntax wins.** Match TypeScript/Rust/Python unless there's a real
  semantic reason. Every deviation is learning curve for zero expressiveness.
- **AI agents are users.** LLMs have zero `.sfn` training data; conventional
  syntax cuts error rates in generated code.
- **Pick 3 differentiators.** Effects, capabilities, concurrency. Everything else
  is a library concern or post-1.0.
- **Libraries over keywords.** A keyword can never become a variable name.
- **Ownership is a floor, not a pillar.** Runtime ownership/aliasing enforcement
  ships as a memory-safety requirement — not a marketed differentiator.
- **Fix the foundation first.** Prefer unblocking layout/generics/effect
  primitives over features stacked on missing ones.
- **Chase timeless problems.** Effects and capability security matter in 20
  years.

Feature *status* lives in `docs/status.md`, not here — it changes too often to
mirror. Non-trivial designs are recorded as SFEPs (`docs/proposals/`).

## Task tracking

**Linear Initiative → Project (epic) → Issue (`SFN-NNN`)**, scoped so one session
goes from `Ready` to a merged PR. Full playbook:
`docs/conventions/linear-workflow.md`.

Work lands on `gemini/sfn-<N>-<slug>`; the PR cites **`Fixes SFN-<N>`** so Linear
closes the issue on merge. The `sfn-<N>` branch prefix is load-bearing.

**Never invent that number.** Linear binds a branch to `SFN-<N>` on the *name
alone* and starts that issue on push and resolves it on merge. Naming a number
you did not claim hijacks someone else's issue silently.
**Work with no backing issue takes a prefix with no `sfn-<N>` segment**
(`gemini/<topic>-<slug>`).

Referencing *other* issues has a lesser version of the same effect: any `SFN-<N>`
occurrence in a branch name, commit message, or PR body links that issue.

## Approval gates

Most work proceeds autonomously, including `make clean-build`, pushing to `gemini/*`,
and opening PRs. Pause for explicit approval only before genuinely irreversible or
high-blast-radius actions: cutting releases, merging or closing PRs, and
history-destructive git (`reset --hard`, force-push, branch deletion).

When something fails, diagnose root cause before trying a different approach.

## Versioning and branches

- **Version source of truth:** `compiler/capsule.toml` (`[capsule] version`),
  resolved by `compiler/src/version.sfn:resolve_compiler_version()`.
- **Releases are automatic.** `.github/workflows/release-train.yml` cuts stable
  minors weekly when `main` is green.
- **Seed pinning is automatic.** `cadence-seed-pin.yml` bumps
  `bootstrap.toml [seed].version` after green releases.
- **Trunk-based.** Everything merges to `main`; releases cut from it.

## Gemini Workspace Customizations

Gemini/Antigravity workspace skills are located under `.agents/skills/`:
- `sailfin-check`: Safely run compiler validation, formatting, and tests.
- `sailfin-debug-compile`: Systematically diagnose compiler pass failures.
- `sailfin-pickup`: Autonomous issue pickup, execution, verification, and PR handoff.
- `sailfin-pin-seed`: Update and verify seed pin in `bootstrap.toml` and `compiler/capsule.toml`.
- `sfn-plan`: Audit and structure Linear Initiatives, Projects, and Issues.

## Source of truth

1. **`docs/status.md`** — what ships today, and the runtime migration tracker
2. **Language spec** — `site/src/content/docs/docs/reference/spec/` (shipped) and
   `.../reference/preview/` (design previews)
3. **Linear** Initiatives/Projects/Cycles — planning; `sailfin.dev/roadmap` is
   the reviewed public projection (`docs/conventions/public-roadmap.md`)
4. **`docs/proposals/`** — SFEPs; `0006-build-architecture.md` for build perf
5. **`docs/strategy/decision-brief.md`** — positioning, the three pillars, and the
   retraction list
6. **`docs/style-guide.md`** — coding conventions in full

## Terminology

- **Capsule** — a Sailfin package with a `capsule.toml` declaring capabilities
- **Workspace** — multi-capsule project with shared `workspace.toml` policies
- **Effect** — capability annotation (`![io]`, `![net]`, …)
- **Native IR** — `.sfn-asm`, the textual intermediate representation
- **Prelude** — core runtime library (`runtime/prelude.sfn`)
- **Seed** — a released compiler binary used to self-host the current source
- **Seedcheck** — the second-pass binary built by the first-pass binary
