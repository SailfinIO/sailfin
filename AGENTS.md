# Repository Guidelines

## Project Structure & Module Organization

- `compiler/src/` carries the Sailfin-native compiler sources; the **self-hosted native compiler** (legacy name: stage2) is the primary toolchain.
- `docs/` has a navigation guide (`docs/README.md`), the canonical status matrix (`docs/status.md`), and engineering references (runtime audit/architecture, build performance). The language specification, grammar, and keyword references live on the docs site under `site/src/content/docs/docs/reference/` and are published at [sailfin.dev/docs/reference/](https://sailfin.dev/docs/reference/). The roadmap lives at [sailfin.dev/roadmap](https://sailfin.dev/roadmap) (source: `site/src/pages/roadmap.astro`). Update the status doc first whenever behaviour changes, then adjust the spec/roadmap accordingly.
- `docs/proposals/` holds future-facing designs (e.g., package management); leave implementation notes there until the status page marks them shipped.
- `runtime/native/` hosts the current C runtime implementation; the runtime is planned to move into Sailfin for the 1.0 release.

## Build, Test, and Development Commands

- `make test` runs all test cases (using an already compiled build).
- `make compile` builds the compiler by self-hosting from the latest released seed.
- `make check` compiles (if needed) and runs the full test suite.
- `make install` installs the built compiler binary into `PREFIX/bin` (default: `~/.local/bin`).
- `make clean` removes packaged artifacts (`dist/`).
- If you need to do some debugging, use the /scratch directory and run/place scripts there.
- Sailfin files spell effects explicitly (`fn foo() -> Bar ![io, model]`), keep lists ordered by impact, and use `CamelCase` for models or capsules while locals remain `snake_case`.
- Align terminology with the language spec at `site/src/content/docs/docs/reference/spec/` (capsule, fleet, provenance card) and note currency or latency literals as comments until syntax support arrives.

- Stage tests beside the code in `compiler/tests/` and mirror intent in `docs/status.md` when available.
- Prefer slim golden inputs in `examples/` plus targeted fixtures; avoid recording generated output.
- Run `make test` before submitting and capture reproduction steps for regressions.
- When adding language surface or runtime behaviour, extend coverage in the Sailfin-native tests and reflect the change in `docs/status.md`.

## Commit & Pull Request Guidelines

- History mixes imperative commits and Conventional Commit prefixes; favor `feat(compiler): …`, `fix(bootstrap): …`, etc., for clarity.
- Keep commits atomic, mention touched capsules, and co-author doc changes in the same PR.
- Pull requests should summarize scope, link issues, list verification commands, and attach screenshots or trace snippets when behavior shifts.

## Codex Workflow Notes

- Codex-specific repository setup lives under `.codex/`: `config.toml` enables hooks/skills, `hooks/` mirrors the Claude session and memory-cap safeguards, `skills/` holds reusable Sailfin workflows, and `prompts/` contains web/CLI prompt templates.
- For autonomous issue pickup in Codex web or CLI, use `.codex/prompts/pickup.md`; it mirrors the Claude `/pickup` flow but branches as `codex/<issue>-<slug>`.
- Before running Sailfin compiler or make verification commands from Codex, preserve the safety invariant: `ulimit -v 8388608 && <command>`.
- If Codex does not auto-load repo-local skills/hooks in a given environment, explicitly mention the relevant `.codex/skills/*/SKILL.md` file in the prompt and follow `.codex/README.md`.
