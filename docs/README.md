# Sailfin Documentation Guide

This directory holds engineering documentation: status matrices, runtime
audits, performance notes, proposals, and RCAs. **User-facing language
documentation lives on the docs site.**

## Where to find things

- **What runs today (feature matrix)** → `docs/status.md`
- **Language specification** → [sailfin.dev/docs/reference/spec/](https://sailfin.dev/docs/reference/spec/)
  (source under `site/src/content/docs/docs/reference/spec/`, split by chapter)
- **Grammar (EBNF)** → [sailfin.dev/docs/reference/grammar](https://sailfin.dev/docs/reference/grammar)
- **Keywords** → [sailfin.dev/docs/reference/keywords](https://sailfin.dev/docs/reference/keywords)
- **Runtime ABI** → [sailfin.dev/docs/reference/runtime-abi](https://sailfin.dev/docs/reference/runtime-abi)
- **Roadmap** → [sailfin.dev/roadmap](https://sailfin.dev/roadmap) (source: `site/src/pages/roadmap.astro`)
- **Runtime migration tracker** → `docs/runtime_audit.md`
- **Runtime architecture notes** → `docs/runtime_architecture.md`
- **Build performance plan** → `docs/build-performance.md`
- **Repository style guide** → `docs/style-guide.md`
- **Proposals** → `docs/proposals/` (future-facing designs)
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
