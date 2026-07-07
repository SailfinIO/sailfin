# Contributing to Sailfin

Thank you for helping shape Sailfin. This guide covers the workflow, testing
expectations, and documentation process for contributions to the pre-release
repository.

## 1. Getting Started

- See `README.md` for a project overview and `docs/README.md` for the doc
  navigation map.
- Review `docs/status.md` to understand which features ship today vs what is
  planned.
- Check the [roadmap](https://sfn.dev/roadmap) for current tasks and sequencing.
- Familiarise yourself with `docs/style-guide.md` for Sailfin module layout,
  file naming, and doc/test mirroring conventions.
- Ensure you have `bash` and the LLVM toolchain available, including `clang`
  and `llvm-link` (no Conda or Python required).

## 2. Coding Workflow

1. **Branch & scope** — Keep work focused; reference open issues or roadmap
   items when possible.
2. **Development commands**
   - Run tests: `make test`
   - Compile Sailfin sources: `make compile` (self-hosted native compiler).
   - Install the built compiler: `make install` (defaults to `~/.local/bin`).
   - Fast PR gate: `make check-fast` runs `sfn check compiler/src/ runtime/`
     in ~2 min. Surfaces parser, typecheck, and effect-system breakage
     without a full selfhost rebuild.
3. **Testing expectations**
   - Add or update unit tests under `compiler/tests/` for compiler changes.
   - Reflect behaviour updates in `docs/status.md` and the relevant module docs.
   - Run `make test` before submitting.

### Optional Pre-Commit Hook

Contributors actively touching `compiler/src/` or `runtime/` can opt into a
pre-commit hook that runs `make check-fast` automatically:

```bash
bash scripts/install_precommit.sh           # install
bash scripts/install_precommit.sh --remove  # uninstall
```

The hook only runs when staged changes touch `compiler/src/` or `runtime/`,
and is silently skipped when `build/native/sailfin` is missing. Bypass with
`SAILFIN_SKIP_PRECOMMIT=1 git commit ...` or the standard `--no-verify`.

### Notes on Release Automation

Releases are cut by `.github/workflows/release.yml`, which bumps the version
source of truth (`compiler/capsule.toml`) and stamps the related version files.
Per-release notes are generated automatically: GitHub's `gh release create
--generate-notes` writes commit/PR-derived notes onto the tag. There is no
hand-maintained `CHANGELOG.md`; the merged PR, its linked issue, and the
[GitHub Releases](https://github.com/SailfinIO/sailfin/releases) notes are the
per-change record.

## 3. Documentation Process

When behaviour, coverage, or roadmap status changes:

1. Update `docs/status.md` first — keep the feature matrix authoritative.
2. Sync the language spec at `site/src/content/docs/docs/reference/spec/`
   (update the relevant §N chapter) and add/amend design notes under
   `.../reference/preview/` if the feature is not yet shipped.
3. Adjust the [roadmap](https://sfn.dev/roadmap) (source: `site/src/pages/roadmap.astro`) for sequencing changes.
4. Touch the relevant folder README (e.g., `compiler/README.md`,
   `runtime/README.md`, `examples/README.md`) so local guidance stays accurate.
5. For a forward-looking design decision, record it as an **SFEP** (see below).

Please reference the updated documents in your pull request description.

### Design Records (SFEPs)

Forward-looking design decisions with real surface area or longevity are
recorded as **SFEPs** (Sailfin Enhancement Proposals) — numbered design records
under `docs/proposals/`. Write (or update) an SFEP for a new/changed **language**
feature, a **runtime/ABI** design, a **toolchain** design, or the design behind a
**roadmap epic** before it is groomed into issues.

Not everything is an SFEP. A rule we already follow lives in `docs/conventions/`,
a post-incident analysis in `docs/rca/`, an operational playbook in
`docs/runbooks/`, and a single-issue implementation design gate in
`docs/proposals/design-notes/`. Small or mechanical work (a one-line fix, a
localized bug, a routine refactor) needs no SFEP — the issue body is enough. When
unsure, follow the decision tree in [SFEP-0001 §1](docs/proposals/0001-sfep-process.md).

To create one:

1. Copy `docs/proposals/template.md` to `docs/proposals/draft-<slug>.md`, set
   `status: Draft`, and fill **every** required section (Summary, Motivation,
   Design, Effect & capability impact, Self-hosting impact, Alternatives
   considered, Stage1 readiness mapping, Test plan, References). An incomplete
   proposal stays `Draft`.
2. Numbers are allocated from the registry in
   [`docs/proposals/README.md`](docs/proposals/README.md) (next number = `max + 1`).
   Keep `sfep: TBD` and the `draft-<slug>.md` name while in review; fix the number
   and add the registry row in the PR that merges the proposal.
3. The lifecycle is `Draft → Accepted → Implemented` (plus terminal `Withdrawn` /
   `Rejected` / `Superseded`). A proposal becomes `Accepted` at the design gate and
   graduates to `Implemented` only when the work clears the Stage1 Readiness
   Checklist end-to-end and self-hosts — "parsed but not enforced" is not
   `Implemented`.

The SFEP is the durable design record (the *why*); issues and PRs are the
execution. An issue implementing an SFEP cites it (e.g. `Design: SFEP-0017`)
rather than duplicating the design. The full process is
[SFEP-0001](docs/proposals/0001-sfep-process.md); SFEP files are Markdown and are
not subject to `sfn fmt` or the self-host gate.

## 4. Commit & Review Style

- Use clear, atomic commits. Conventional prefixes (`feat(compiler):`, `fix(bootstrap):`)
  are encouraged.
- Note: releases are **not** cut automatically from commit prefixes. They are triggered
  manually via `gh workflow run release.yml -f channel=<alpha|beta|stable> -f bump=<prerelease|minor|…>`
  (`workflow_dispatch`), and the release workflow is pure bash — there is no
  `python-semantic-release` or any Python in the toolchain. The version source of truth is
  `[capsule] version` in `compiler/capsule.toml`. Conventional Commit prefixes still aid
  changelog readability, but they do not gate whether a version is cut.
- Document how you validated the change (commands, tests, screenshots).
- When behaviour shifts, include reproduction steps and link to the relevant
  roadmap/status entries.

## 5. Pull Requests

Each PR should include:

- Summary of the change and impacted areas.
- Verification commands (`make test`, targeted runs, etc.).
- Notes on documentation updates (status/spec/roadmap).

Reviewers will check for:

- Test coverage and passing CI.
- Alignment with docs/status and roadmap.
- Clear rollback path if needed.

## 6. Code Style

[`docs/style-guide.md`](docs/style-guide.md) is the single source of truth for
coding conventions — naming, comments, effect-annotation style, error-handling
idiom, file organization, and size budgets. Read it before your first `.sfn`
change; the short version:

- `sfn fmt --write` then `sfn fmt --check` on every touched `.sfn` file
  (mechanics are the formatter's, everything else is the guide's).
- `snake_case` functions/files, `PascalCase` types, `_underscore` private
  helpers, alphabetical effect lists (`![io, net]`).
- Comments explain *why* and cite issues/SFEPs — no `TODO`s, no
  commented-out code, no "this PR" language.
- Examples: keep inputs minimal, avoid generated artefacts, and annotate
  future-only constructs.

## 7. Questions & Help

For questions about design direction or roadmap priorities, start with
`docs/status.md` and the [roadmap](https://sfn.dev/roadmap). If additional context is required, open
an issue referencing the relevant section or proposal.

Welcome aboard, and thanks for advancing Sailfin! \*\*\*!
