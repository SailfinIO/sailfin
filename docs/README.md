# Sailfin Documentation Guide

This directory holds engineering documentation: status matrices, runtime
audits, performance notes, proposals, and RCAs. **User-facing language
documentation lives on the docs site.**

## Where to find things

- **What runs today (feature matrix)** → `docs/status.md`
- **Compiler/runtime development setup** → `docs/development-setup.md`
- **Language specification** → [sailfin.dev/docs/reference/spec/](https://sailfin.dev/docs/reference/spec/)
  (source under `site/src/content/docs/docs/reference/spec/`, split by chapter)
- **Grammar (EBNF)** → [sailfin.dev/docs/reference/grammar](https://sailfin.dev/docs/reference/grammar)
- **Keywords** → [sailfin.dev/docs/reference/keywords](https://sailfin.dev/docs/reference/keywords)
- **Runtime ABI** → [sailfin.dev/docs/reference/runtime-abi](https://sailfin.dev/docs/reference/runtime-abi)
- **Roadmap** → [sailfin.dev/roadmap](https://sailfin.dev/roadmap) (source: `site/src/pages/roadmap.astro`)
- **Runtime migration tracker** → `docs/status.md` (Runtime Migration table)
- **Native runtime architecture** → `docs/proposals/0025-native-runtime-architecture.md` (SFEP-0025)
- **Build architecture and performance baseline** → `docs/proposals/0006-build-architecture.md` (SFEP-0006)
- **Runtime execution perf baseline** → `docs/perf/runtime-performance.md`
- **Coding conventions & repository style guide** → `docs/style-guide.md`
  (the single source of truth for naming, comments, effects style, error
  handling, and file organization; narrow single-topic conventions live under
  `docs/conventions/`)
- **Proposals (SFEPs)** → `docs/proposals/` — numbered design records;
  index + process in [`docs/proposals/README.md`](proposals/README.md) and
  [SFEP-0001](proposals/0001-sfep-process.md)
- **Root-cause analyses** → `docs/rca/`
- **Perf notes** → `docs/perf/`
- **Examples** → `examples/` (category index in `examples/README.md`)

## Updating docs

When behaviour, coverage, or roadmap status changes:

1. Refresh `docs/status.md` once behaviour or coverage changes.
2. Update the language spec on the site under
   `site/src/content/docs/docs/reference/spec/` (the appropriate §N chapter)
   or `.../reference/preview/` for planned features.
3. Cross-link roadmap items and proposals to the relevant source files or tests.
