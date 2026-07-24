---
sfep: 0047
title: Compiler Bootstrap Manifest
status: Implemented
type: tooling
created: 2026-07-10
updated: 2026-07-24
author: "agent:codex; human review: Michael Curtis"
tracking: SFN-197
supersedes:
superseded-by:
graduates-to:
---

# SFEP-0047 — Compiler Bootstrap Manifest

## 1. Summary

Introduce a root `bootstrap.toml` for the Sailfin compiler repository's
self-hosting seed policy and make it the input to a Sailfin-native compiler-dev
bootstrap path. The steady-state command for contributors should be `sfn build -p
compiler`, not `make compile`: when the driver is building the compiler checkout,
it reads `bootstrap.toml`, acquires/verifies the exact released seed, and
re-execs that seed for the self-host build. This does not change the public
`[toolchain]` surface from SFEP-0046. `[toolchain]` remains the
capsule/workspace compatibility floor users see; `bootstrap.toml` is
compiler-repo bootstrap policy for building the next compiler from an exact
released seed.

## 2. Motivation

Sailfin currently has two related but distinct version declarations:

- `compiler/capsule.toml` `[toolchain] sfn = "..."` says which `sfn` version is
  sufficient to build or use the compiler capsule. Per SFEP-0046 this is
  user-facing, additive, and uses floor semantics.
- `.seed-version` says which exact released `sfn` binary `make fetch-seed` and
  `make compile` use as stage0 to self-host the compiler.

The second file is intentionally small and hard to misread. That is a strength
while it is only a scalar. The weakness is that the project is intentionally
retiring legacy build orchestration: SFEP-0006 already names "one build driver"
and "no orchestration layer above `sfn`" as the target. The compiler build should
dogfood the same native toolchain UX product capsules get, with `sfn` owning the
seed acquisition, dispatch, build, check, package, and benchmark workflows.

That makes the bootstrap contract larger than one line. The seed is fetched from
release assets, installed into a repo-local store under `build/toolchains/seed`,
must match the native installer/toolchain-store layout, should eventually be
verified with the same signed-manifest machinery used by native toolchain
dispatch, and needs clear rules for exact-seed vs local override. Today those
decisions live in Makefile variables, comments, and release scripts rather than
in one explicit native build-system input.

The project should not overload `[toolchain]` with exact-stage0 semantics. A
capsule compatibility floor and a self-hosting bootstrap input are both compiler
versions, but they answer different questions:

- "Can this toolchain build this capsule?" (`[toolchain]`, floor).
- "Which exact released compiler bootstraps this checkout?" (`bootstrap.toml`,
  exact seed).

Keeping those roles separate matches the peer-language shape: Go modules and
workspaces declare toolchain requirements, while building Go from source still
uses a distinct bootstrap compiler (`PATH`/`GOROOT_BOOTSTRAP`). Rust projects can
pin a toolchain with `rust-toolchain.toml`, while `rustc` itself uses a staged
bootstrap system driven by bootstrap configuration.

The user-experience goal is still Go-shaped: once a user has any sufficiently
new `sfn` installed, a fresh compiler checkout plus `sfn build -p compiler`
should do the right thing. Manual bootstrap controls are for Sailfin compiler
developers and automation, not for ordinary Sailfin application authors.
`install.sh` remains only the first-binary escape hatch for a machine with no
`sfn` at all.

## 3. Design

### 3.1 File location and ownership

`bootstrap.toml` lives at the repository root of the Sailfin compiler checkout:

```text
bootstrap.toml
compiler/capsule.toml
workspace.toml
```

It is not part of the public capsule manifest schema. Downstream product
capsules should not create or read it. The intended primary reader is `sfn`
itself: `sfn build -p compiler`, `sfn dev bootstrap fetch`, release-pin tooling,
and seedcheck logic may read it before any newly built compiler exists.

The first version of the file should stay deliberately shallow so the bootstrap
path does not depend on a full TOML parser before the seed exists. The accepted
subset is:

- section headers (`[seed]`, `[store]`, `[verify]`);
- string key/value pairs;
- boolean key/value pairs for verification flags;
- comments and blank lines.

If the file later grows arrays, inline tables, or nested tables, the bootstrap
reader must become a real parser first. Do not grow an ad hoc TOML language in a
compatibility Makefile or shell wrapper.

### 3.2 Initial schema

```toml
[seed]
version = "0.8.0-alpha.3"
source = "github-release"
repo = "SailfinIO/sailfin"
asset_prefix = "sailfin"
policy = "exact"

[store]
install_base = "build/toolchains/seed/versions"
bin_dir = "build/toolchains/seed/bin"

[verify]
mode = "signed-sha256sums"
manifest = "SHA256SUMS"
signature = "SHA256SUMS.sig"
required = true
```

#### `[seed]`

`version` is required. It names the exact released Sailfin compiler used as the
stage0 seed for this checkout.

`source` is required. Initial values:

- `github-release` — fetch from the release assets for `repo`;
- `local-path` — use a developer-supplied local toolchain path, only through an
  explicit override field or environment variable, not as the committed default.

`repo` is required when `source = "github-release"` and defaults to the current
release repository only if omitted during a compatibility period. A mirror may
be added later as `base_url` or `release_base`, but the initial schema should not
invent a second release naming convention.

`asset_prefix` defaults to `sailfin` and exists so the bootstrap reader does not
hard-code the tarball prefix in several places. It must remain aligned with the
native `sfn toolchain install` release-asset layout from SFEP-0046.

`policy` is required and initially only accepts `exact`. A stage0 seed is not a
floor. CI and release validation should use the same seed unless the user
explicitly overrides it.

#### `[store]`

`install_base` and `bin_dir` define the repo-local seed store. They replace the
current Makefile defaults:

```make
SEED_INSTALL_BASE ?= build/toolchains/seed/versions
SEED_GLOBAL_BIN_DIR ?= build/toolchains/seed/bin
```

The user-facing install store under `~/.local/share/sailfin/versions` is not
changed by this proposal. `bootstrap.toml` describes the compiler repo's local
stage0 cache, not a global toolchain manager.

#### `[verify]`

Remote seeds must be verified. `mode = "signed-sha256sums"` means:

1. download the release asset;
2. download `manifest` and `signature`;
3. verify the manifest signature against the embedded or configured release key;
4. verify the asset digest before installation;
5. only then expose the seed as `build/toolchains/seed/bin/sfn`.

`required = false` is not allowed for `source = "github-release"` in committed
configuration. If a developer needs a local experimental compiler, they should
use an explicit local override that is visible in command output.

### 3.3 Native build behavior and developer command surface

The native driver owns the steady-state bootstrap path.

When `sfn build -p compiler` is run inside a checkout containing
`bootstrap.toml`, the driver enters compiler-bootstrap mode:

1. Read `bootstrap.toml`.
2. Resolve `[seed].version` as an exact released toolchain, not a floor.
3. Ensure the seed exists in `[store]` by using the same fail-closed
   fetch/verify/install discipline as SFEP-0046's native `sfn toolchain install`.
4. Re-exec the seed `sfn` with the original build arguments and a re-entrancy
   guard such as `SAILFIN_BOOTSTRAP_DISPATCHED=<version>`.
5. The dispatched seed performs the normal `sfn build -p compiler` pipeline.

This keeps `sfn build` as the only source-to-artifact build path. Bootstrap mode
selects the exact stage0 compiler before the build starts; it does not introduce
a second compiler-build implementation. The normal-user command remains the
obvious command:

```text
sfn build -p compiler
```

No ordinary Sailfin program needs to run a bootstrap command.

The explicit bootstrap subcommands are compiler-developer conveniences and CI
hooks. They live under a dev namespace rather than the primary command list:

```text
sfn dev bootstrap fetch     # acquire + verify the configured seed only
sfn dev bootstrap build     # fetch if needed, then build with the exact seed
sfn dev bootstrap check     # build + seedcheck / determinism gate
```

`sfn dev bootstrap build` and `sfn build -p compiler` should converge on the
same underlying implementation. The former is explicit for maintainers and
agents doing compiler-repo work; the latter is the desired day-to-day
contributor UX.

The command should be discoverable without making the normal help noisy:

- `sfn --help` lists user-facing commands and may include a short "developer
  commands: see `sfn dev --help`" footer.
- `sfn dev --help` lists compiler/toolchain-maintainer commands.
- `sfn dev bootstrap ...` refuses outside a checkout with `bootstrap.toml`,
  unless a future explicit `--config` path is supplied.
- In machine-readable help, `dev` commands are tagged as `"audience": "developer"`
  so agents can choose them only when working on the Sailfin compiler/toolchain.

During the transition, `make fetch-seed`, `make compile`, `make rebuild`, and
seedcheck may read `bootstrap.toml` as compatibility shims. They are not the
target architecture. Any Makefile reader must stay temporary and must not grow
independent bootstrap semantics.

During migration:

1. Teach the current build scripts to reject disagreement between
   `bootstrap.toml` and `.seed-version`, while old seeds still consume
   `.seed-version`.
2. Land native `sfn dev bootstrap fetch` and `sfn dev bootstrap build`.
3. Make `sfn build -p compiler` dispatch through bootstrap mode by default.
4. Once the pinned seed contains the native bootstrap reader, delete
   `.seed-version` in a dedicated cleanup issue.

Compatibility rules:

1. If `bootstrap.toml` exists, it is the desired seed source of truth.
2. If only `.seed-version` exists, legacy behavior continues until the migration
   issue removes it.
3. If both exist, their versions must match or the build fails with a diagnostic
   naming both files.
4. The final state has `bootstrap.toml` only.

Environment overrides remain possible but must be explicit in output:

- `SEED_VERSION=...` overrides `[seed].version` for local experiments;
- `SEED=...` may point at an already installed seed binary during migration;
- a future `SEED_SOURCE=local-path` or `SEED_PATH=...` may bypass release fetch
  for compiler developers.

Overrides must not silently edit `bootstrap.toml`.

### 3.4 Pin update workflow

The pin workflow updates the exact bootstrap seed and the public compiler
toolchain floor together:

```text
bootstrap.toml       [seed].version = "0.8.0-alpha.N"
compiler/capsule.toml [toolchain].sfn = "0.8.0-alpha.N"
compiler/capsule.toml [capsule].version = "0.8.0-alpha.N"
docs/status.md       seed/toolchain status line
```

The values usually match, but they are not the same contract:

- `bootstrap.toml` is exact and build-system-facing.
- `[toolchain]` is floor-based and capsule-facing.
- `[capsule].version` is the version of the compiler being built.

The update tool should fail if it would raise `[toolchain]` ahead of
`[capsule].version`, because the first-pass self-host binary gates itself when
building seedcheck.

In the final state, `/pin-seed` or `sfn dev bootstrap pin <version>` updates
`bootstrap.toml` instead of `.seed-version`. It must still update the compiler
capsule's public `[toolchain]` pin when the source version advances.

### 3.5 What belongs outside `bootstrap.toml`

`bootstrap.toml` should not become a general build configuration file. In
particular, the initial design excludes:

- optimization levels;
- test shard lists;
- local developer preferences;
- arbitrary Makefile variables;
- package dependency pins;
- user-facing toolchain dispatch policy.

Those belong in build scripts, CI configuration, `capsule.toml`, `workspace.toml`,
or `SAILFIN_TOOLCHAIN` depending on the surface. The bootstrap manifest exists
only to make the stage0 compiler contract explicit and verifiable.

## 4. Effect & capability impact

The proposal does not change the Sailfin language effect system. It changes
bootstrap tooling.

Fetching a remote seed is an IO/network operation. In the target architecture,
the fetch path is Sailfin-native and must carry `![io, net]`, matching
SFEP-0046's native `sfn toolchain install` behavior. Parsing `bootstrap.toml`
itself is `![io]` plus pure string parsing.

Verification uses cryptographic checks over downloaded bytes and adds no new
effect beyond the IO needed to read files and the network effect needed to fetch
remote assets.

## 5. Self-hosting impact

No compiler passes change. Lexer, parser, AST, typecheck, effect-checker,
emitter, and LLVM lowering are untouched.

The sensitive point is bootstrapping order. The repository cannot assume the
new compiler has already been built, so the first native `bootstrap.toml` reader
must ship in a released seed before `.seed-version` can be deleted. Acceptable
transition implementations:

- current Makefile/CI compatibility checks that only compare the version field;
- a small, tested bootstrap-reader script checked into `tools/` for migration;
- native `sfn dev bootstrap` support once a seed containing that command is
  pinned.

The target implementation is native `sfn`, not a permanent script or Makefile
parser.

The reader must fail closed on ambiguous or malformed config. If the bootstrap
manifest cannot be read, the build should not guess a seed version.

Self-host validation remains the same semantically: fetch the exact seed, build
the compiler, build seedcheck, and compare or validate according to the current
gate. The operational difference is that the user-facing command becomes
`sfn build -p compiler`, while the explicit maintainer gate becomes
`sfn dev bootstrap check` rather than `make check` / `make compile`, and the seed
contract is structured rather than spread across `.seed-version` plus Makefile
defaults.

## 6. Alternatives considered

### Keep `.seed-version` indefinitely

This is the simplest option and remains valid while the only committed seed
contract is a single exact version. It loses once source, store, verification,
mirror policy, and native bootstrap dispatch matter enough to need one explicit
record. A one-line file cannot express those fields without inventing parallel
env vars and comments, and it keeps the compiler build tied to legacy
orchestration instead of making `sfn` the build system.

### Put the exact seed in `[toolchain]`

Rejected. `[toolchain]` is the public compatibility surface and uses floor
semantics. A bootstrap seed is an exact stage0 input. Overloading the field would
either make user capsules inherit compiler self-hosting semantics or make
self-hosting less reproducible.

### Add `[bootstrap]` to `compiler/capsule.toml`

Rejected for the initial design. It puts compiler-repo bootstrap policy inside a
capsule manifest that downstream users also learn from, and it requires the
build system to parse a broader package manifest before it has a seed. Keeping a
root bootstrap manifest makes the boundary explicit.

### Use environment variables only

Rejected as the primary mechanism. Environment variables are good overrides but
poor committed policy. CI, release scripts, and contributors need a checked-in
bootstrap contract.

### Keep bootstrap policy in the Makefile

Rejected. This is the status quo and directly conflicts with SFEP-0006's "one
build driver" direction. A Makefile can remain as a short compatibility wrapper,
but it must not be the source of truth for seed version, store paths,
verification, or dispatch.

### Adopt a large Rust-style bootstrap configuration now

Rejected. Rust's bootstrap system configures a large multi-stage compiler,
standard library, LLVM, tools, and profiles. Sailfin does not need that surface
yet. The initial manifest should stay narrow and can grow only when there is a
real bootstrap policy field to add.

## 7. Stage1 readiness mapping

This is a tooling/process SFEP with no language syntax or codegen surface.

- [ ] Parses — N/A for `.sfn` grammar; `bootstrap.toml` reader parses the
  constrained TOML subset.
- [ ] Type-checks / effect-checks — native `sfn dev bootstrap` and
  compiler-build dispatch code must pass `sfn check`.
- [ ] Emits valid `.sfn-asm` — N/A.
- [ ] Lowers to LLVM IR — N/A.
- [ ] Regression coverage — required for the bootstrap reader and migration
  behavior.
- [ ] Self-hosts — required: `sfn dev bootstrap build` and
  `sfn build -p compiler` must build from a clean checkout once a
  bootstrap-aware seed is pinned; legacy `make compile` may remain only during
  migration.
- [ ] `sfn fmt --check` clean — required only for any touched `.sfn` files.
- [ ] Documented in `docs/status.md` + relevant build/toolchain docs.

## 8. Test plan

- Unit coverage for the bootstrap reader:
  - reads all required fields from a valid `bootstrap.toml`;
  - rejects missing `[seed].version`;
  - rejects unsupported `policy`;
  - rejects `required = false` for `source = "github-release"`;
  - rejects malformed duplicate or ambiguous fields.
- Native bootstrap coverage:
  - `sfn dev bootstrap fetch` reads `[seed].version` from `bootstrap.toml`;
  - `sfn dev bootstrap build` fetches when needed, then re-execs the exact seed;
  - `sfn build -p compiler` enters bootstrap mode and uses the same exact seed;
  - the re-entrancy guard prevents dispatch loops;
  - malformed or unverifiable config fails before any build starts.
- Migration coverage:
  - fallback to `.seed-version` still works during the migration window;
  - mismatched `bootstrap.toml` and `.seed-version` fails with a clear diagnostic;
  - `SEED_VERSION=...` override is reported in output and does not edit files.
- Self-host coverage:
  - `sfn dev bootstrap build` from a clean checkout uses the configured seed
    store paths;
  - `sfn dev bootstrap check` or the seedcheck gate continues to validate the
    built compiler;
  - any Makefile wrapper, if retained, delegates to `sfn` and does not implement
    a separate build path.
- Verification coverage once signed seed verification is wired:
  - bad manifest signature refuses installation before exposing `bin/sfn`;
  - digest mismatch refuses installation;
  - already fetched verified seed is reused without network when complete.

## 9. References

- SFEP-0046 — Native Toolchain Version Pinning + Dispatch. Defines the public
  `[toolchain]` capsule/workspace surface and deliberately keeps bootstrap seed
  policy separate.
- `compiler/capsule.toml` — the compiler capsule version and `[toolchain]` dogfood
  pin.
- `.seed-version` — current exact stage0 seed version.
- `Makefile` — current `SEED_VERSION`, `SEED_INSTALL_BASE`,
  `SEED_GLOBAL_BIN_DIR`, `fetch-seed`, `compile`, `rebuild`, and seedcheck
  orchestration that this proposal migrates into native `sfn` commands.
- SFEP-0006 — Unified Build Architecture. Names the target principles: one build
  driver, no orchestration layer above `sfn`, and eventual Makefile retirement.
- `install.sh` — current release-asset layout and user-facing toolchain install
  store.
- Go source bootstrap: Go modules/workspaces declare toolchain requirements, but
  building Go from source still uses a distinct bootstrap compiler from `PATH` or
  `GOROOT_BOOTSTRAP`; Go's distribution build/test machinery is exposed through
  the developer-oriented `go tool dist` surface rather than ordinary application
  build commands.
- Rust bootstrap: Rust projects can use `rust-toolchain.toml`/`rust-version`,
  while `rustc` itself uses staged bootstrap configuration.
