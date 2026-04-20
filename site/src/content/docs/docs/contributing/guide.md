---
title: Contributor Guide
description: How to contribute to the Sailfin project.
section: contributing
sidebar:
  order: 1
---

## Getting Started

1. Fork and clone the repository:

```bash
git clone https://github.com/SailfinIO/sailfin.git
cd sailfin
```

2. Set up the development environment:

```bash
make compile   # Build the compiler from seed
make test      # Verify everything works
```

3. Create a feature branch:

```bash
git checkout -b feature/my-feature main
```

## Development Workflow

### Making Changes

1. Edit compiler source in `compiler/src/*.sfn`
2. Rebuild: `make compile`
3. Run tests: `make test`
4. Validate self-hosting: `make check`

### Adding a Language Feature

1. Update the parser (`compiler/src/parser.sfn`)
2. Add AST nodes (`compiler/src/ast.sfn`)
3. Update the emitter (`compiler/src/emit_native.sfn`)
4. Extend LLVM lowering (`compiler/src/llvm/lowering/`)
5. Add regression tests (`compiler/tests/`)
6. Update the language spec (`site/src/content/docs/docs/reference/spec/NN-*.md` or `.../reference/preview/*.md`) and `docs/status.md`

### Self-Hosting Invariant

The compiler must always compile itself. Before submitting:

```bash
make compile   # Build from seed
make check     # Validate seedcheck binary
make test      # Full test suite
```

## Branch Strategy

- **`main`** — Primary development branch; all feature work merges here
- **`beta`** / **`rc`** — Short-lived branches cut from `main` for beta and release candidate cycles
- Feature branches merge to `main`

## Principles

- **Fix the compiler, not the build script.** Don't add fixup passes — fix the root cause in `compiler/src/`.
- **Reduce complexity.** The fixup pass count should decrease over time.
- **Build must be fast and deterministic.** Under 5 minutes, zero retries.

## Submitting Changes

1. Ensure `make check` and `make test` pass
2. Open a PR against the `main` branch
3. Include test coverage for new features or bug fixes
4. Update documentation if the change affects language behavior

## License

Sailfin is licensed under the [GNU General Public License v2](https://github.com/SailfinIO/sailfin/blob/main/LICENSE). By submitting a contribution, you agree that your work will be distributed under the same license.

The runtime libraries include a [Runtime Library Exception](https://github.com/SailfinIO/sailfin/blob/main/RUNTIME_LIBRARY_EXCEPTION) so that programs compiled by Sailfin are not subject to the GPL — users can license their own programs however they choose.
