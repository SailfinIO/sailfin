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
./install.sh              # Install a released sfn (a clean tree has none)
sfn dev bootstrap build    # Build the compiler from seed
build/bin/sfn test         # Verify everything works
```

For host dependencies, OpenSSL/LLVM setup, and supported CLI build
flags, see the
[compiler and runtime development setup](https://github.com/SailfinIO/sailfin/blob/main/docs/development-setup.md).

3. Create a feature branch:

```bash
git checkout -b feature/my-feature main
```

## Development Workflow

### Making Changes

1. Edit compiler source in `compiler/src/*.sfn`
2. Rebuild: `sfn dev bootstrap build`
3. Run tests: `build/bin/sfn test`
4. Validate self-hosting: `sfn dev verify`

### Adding a Language Feature

1. Update the parser (`compiler/capsules/syntax/src/parser/mod.sfn`)
2. Add AST nodes (`compiler/capsules/syntax/src/ast.sfn`)
3. Update the emitter (`compiler/capsules/codegen/src/emit_native.sfn`)
4. Extend LLVM lowering (`compiler/capsules/codegen-llvm/src/lowering/`)
5. Add regression tests (`compiler/tests/`)
6. Update `docs/status.md`, the source of truth for shipped behavior
7. Update the language spec (`site/src/content/docs/docs/reference/spec/NN-*.md`
   or `.../reference/preview/*.md`) and then adjust roadmap and public claims

### Guarding public claims

Behavior-changing work updates `docs/status.md` first. Public examples and
claims are adjusted only after that source of truth is current. Before
submitting changes to the homepage, onboarding docs, README, installer copy, or
release templates, run:

```bash
sfn dev bootstrap fetch
cd site
npm run check:public-claims
npm run build
npm run check:internal-links
```

The public-claim guard compiler-checks the canonical homepage and first-run
examples, asserts the missing-effect diagnostic by code and bounded message
fragment, rejects curated retired wording, and checks critical link and release
asset contracts. Its deliberately stale fixtures live under
`site/scripts/fixtures/`; add a focused case there when extending a guard
category. Failures identify the category, source file, and expected contract.

### Self-Hosting Invariant

The compiler must always compile itself. Before submitting:

```bash
sfn dev bootstrap build    # Build from seed
sfn dev verify             # Validate seedcheck binary
build/bin/sfn test         # Full test suite
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

1. Ensure `sfn dev verify` and `build/bin/sfn test` pass
2. Open a PR against the `main` branch
3. Include test coverage for new features or bug fixes
4. Update documentation if the change affects language behavior

## License

Sailfin is licensed under the [GNU General Public License v2](https://github.com/SailfinIO/sailfin/blob/main/LICENSE). By submitting a contribution, you agree that your work will be distributed under the same license.

The runtime libraries include a [Runtime Library Exception](https://github.com/SailfinIO/sailfin/blob/main/RUNTIME_LIBRARY_EXCEPTION) so that programs compiled by Sailfin are not subject to the GPL — users can license their own programs however they choose.
