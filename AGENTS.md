# Repository Guidelines

## Project Structure & Module Organization

- `compiler/src/` carries the Sailfin-native compiler sources; the **self-hosted native compiler** (legacy internal path name: stage2) is the primary toolchain.
- `runtime/prelude.sfn` and `runtime/sfn/` host the Sailfin-native runtime. The former C runtime under `runtime/native/` has been deleted; do not add C runtime startup/linkage workarounds.
- `docs/` has a navigation guide (`docs/README.md`), the canonical status matrix (`docs/status.md`), and engineering references. The language specification, grammar, and keyword references live on the docs site under `site/src/content/docs/docs/reference/` and are published at [sailfin.dev/docs/reference/](https://sailfin.dev/docs/reference/). The roadmap lives at [sailfin.dev/roadmap](https://sailfin.dev/roadmap) (source: `site/src/pages/roadmap.astro`). Update the status doc first whenever behaviour changes, then adjust the spec/roadmap accordingly.
- `docs/proposals/` is the Sailfin Enhancement Proposal (SFEP) registry. Use `docs/proposals/0001-sfep-process.md` and `docs/proposals/template.md` for forward-looking language, runtime/ABI, toolchain, or roadmap-epic design work. Keep single-issue design notes in `docs/proposals/design-notes/`.

## Build, Test, and Development Commands

- `sfn check <files>` (or `build/native/sailfin check <files>`) is the fast inner loop for parse/type/effect checking; it does not prove codegen, linking, or self-hosting.
- `make compile` self-hosts the compiler from the released seed pinned by `.seed-version`.
- `make rebuild` forces a rebuild from the seed.
- `make check` compiles if needed and runs the full validation gate, including seedcheck self-host validation.
- `make test`, `make test-unit`, `make test-integration`, and `make test-e2e` run Sailfin-native test suites.
- `make bench` measures compile time and memory.
- `make fetch-seed` downloads the pinned seed; `make install` installs the built compiler into `PREFIX/bin` (default: `~/.local/bin`).
- `make clean` removes packaged artifacts (`dist/`); `make clean-build` removes build artifacts while keeping the seed and is destructive enough to call out before use.
- If you need scratch scripts or reproductions, place them under `/scratch`.

## Compiler Safety & Self-Hosting Invariants

- The compiler self-applies an 8 GiB Linux `RLIMIT_AS` at startup (`SAILFIN_MEM_LIMIT` overrides; `unlimited`/`off`/`0` disables it). Do **not** add caller-side `ulimit` guards or Codex/Claude pre-tool hooks for ordinary compiler runs.
- Timeouts still matter: wrap direct single-file compiler invocations with `timeout 60`; `make` targets manage their own timeouts.
- Before committing changes to `compiler/src/*.sfn`, run `make compile` (or `make check`) before test-only validation so tests do not run against a stale compiler binary.
- If a change is structural (file splits, module graph changes, renamed exports), run `make clean-build` before rebuilding.
- Fix compiler failures in `compiler/src/*.sfn`; the build driver (`compiler/src/cli_main.sfn` + `compiler/src/capsule_resolver.sfn`) is pure orchestration and must not grow fixups.

## Style, Tests, and Documentation

- `docs/style-guide.md` is the single source of truth for coding conventions (naming, comments, effect-annotation style, error handling, file size budgets); `.claude/rules/code-style.md` is the always-loaded summary. Headline rules: effects spelled explicitly and listed alphabetically (`fn foo() -> Bar ![io, model]`); `snake_case` functions/locals, `PascalCase` types, `_underscore` private helpers; comments explain *why* and cite issues/SFEPs — never `TODO`s, commented-out code, or "this PR" language.
- Align terminology with the language spec at `site/src/content/docs/docs/reference/spec/` (capsule, fleet, provenance card) and note currency or latency literals as comments until syntax support arrives.
- Before committing touched `.sfn` files under `compiler/src/` or `runtime/`, run `sfn fmt --write <files>` and then `sfn fmt --check <files>` (or the equivalent `build/native/sailfin` commands).
- Stage regression tests beside related coverage in `compiler/tests/`; prefer Sailfin-native tests and slim fixtures over recorded generated output.
- When adding language surface or runtime behavior, extend coverage and update `docs/status.md` first, then the relevant spec/preview page and roadmap if needed.
- For non-trivial design changes, create or update an SFEP under `docs/proposals/` rather than burying design in issues or PR prose. Do not mark an SFEP `Implemented` until the feature meets the Stage1 readiness bar end-to-end and self-hosts.

## Commit & Pull Request Guidelines

- History mixes imperative commits and Conventional Commit prefixes; favor `feat(compiler): …`, `fix(runtime): …`, `docs(sfep): …`, etc., for clarity.
- Keep commits atomic, mention touched capsules/passes, and co-author docs/status/spec changes in the same PR as behavior changes.
- Pull requests should summarize scope, link issues/SFEPs, list verification commands, and attach screenshots or trace snippets when behavior shifts.

## Codex Workflow Notes

- Codex-specific setup lives under `.codex/`: `config.toml` enables hooks/skills, `hooks/` mirrors the provider-neutral session safeguards, `skills/` holds reusable Sailfin workflows, and `prompts/` contains web/CLI prompt templates.
- For autonomous issue pickup in Codex web or CLI, use `.codex/prompts/pickup.md`; it mirrors the Claude `/pickup` flow but branches as `codex/<issue>-<slug>`.
- For SFEP work in Codex, use `.codex/prompts/sfep.md` and the proposal process in `docs/proposals/0001-sfep-process.md`.
- If Codex does not auto-load repo-local skills/hooks in a given environment, explicitly mention the relevant `.codex/skills/*/SKILL.md` file or paste the matching `.codex/prompts/*.md` template.
