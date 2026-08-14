# Status

Updated: 2026-08-14 (SFN-756). Seed pinned to `0.9.5` (`bootstrap.toml`
`[seed].version` — SFEP-0047); the compiler version source of truth is
`compiler/capsule.toml`.

This document is the **current-state source of truth**: what ships today,
what is partial, and what is planned. Consult it before editing docs,
examples, or making claims about feature availability.

It is **not a changelog.** Per-change narrative lives in the merged PR, the
linked issue, and the [GitHub Releases](https://github.com/SailfinIO/sailfin/releases)
notes (auto-generated per tag). When a feature's status changes: flip the
row, update the one-line note, link the PR/issue — do not append prose. If a
detail matters long-term, it belongs in the spec or a `docs/proposals/*`
design doc (e.g. `docs/proposals/0025-native-runtime-architecture.md`), not
here.

## Toolchain (Current)

- **Private-capsule manifest policy — schema.** `[capsule] publish` is parsed
  as a strict boolean and defaults to `true` for existing manifests. The typed
  `toml_get_publish` accessor returns no policy value plus a manifest error for
  strings, integers, arrays, malformed values, or duplicate declarations
  (SFEP-0020 §3.6, SFN-707).
- **Private-capsule manifest policy — publish enforcement** (SFEP-0020 §3.6,
  SFEP-0002 §3.7 Phase 5, SFN-714). `sfn publish` rejects a capsule declaring
  `[capsule] publish = false`, and any capsule whose `publish` value fails to
  resolve, before credential discovery, packaging, and the registry upload; the
  refusal is `E0612`, names the capsule, and exits 1. The gate reads the
  manifest already loaded for name/version, so an explicit `[path]`,
  current-directory discovery, and an `SFN_REGISTRY` override all reach it.
  The compiler's own `compiler/capsule.toml` declares `publish = false`, so
  `sfn publish compiler` is covered by the same refusal path (SFN-734).
- **Private-capsule manifest policy — resolver provenance** (SFEP-0020 §3.6,
  SFN-715). Every `CapsuleSource` carries an `origin` stamped by the locator
  that resolved it — `local` (relative imports, the entry module, the project's
  own `src/`), `workspace` (a declared member or in-tree `capsules/` checkout),
  or `cache` (the `~/.sfn/cache` tree `sfn add` populates). A declared local
  member may carry `publish = false` and builds normally; a cache-resolved
  candidate whose manifest denies publication — including one whose `publish`
  value fails to resolve — is refused with `E0613` before any of its sources are
  collected, staged, or compiled. Because a fetched private candidate is
  rejected outright, it can neither shadow nor substitute for a declared local
  private member. `stage_capsule_imports` additionally refuses any source whose
  origin is empty or unrecognized, so a future locator cannot bypass the gate by
  omitting provenance. The pinned seed (0.9.5) parses a globbed member
  list, resolves private members from local paths, orders them transitively, and
  links them into a binary, so adopting the field in compiler manifests needs no
  seed cut (`compiler/tests/e2e/seed_private_workspace_fixture_test.sfn`).
- **Compiler syntax capsule** (SFN-741, SFEP-0020 §§3.2, 3.6, 3.7 step 3).
  `sfn/syntax` is the first physical compiler implementation capsule, rooted at
  `compiler/capsules/syntax/` and exposed through its private `src/mod.sfn`
  facade. The compiler and its tests import that facade; lexer, token, AST, and
  parser implementation files no longer live under `compiler/src`. The capsule
  declares `publish = false`, depends only on `sfn/strings`, and requires no
  capabilities. The boundary ratchet classifies those files from their physical
  capsule path with no syntax naming-convention fallback. The pinned 0.9.5 seed
  resolves the capsule's transitive dependency closure, and the reusable move
  and rename-only determinism procedure is recorded in
  `docs/conventions/compiler-capsule-extractions.md`.
- **Compiler IR capsule** (SFN-744, SFEP-0020 §§3.2, 3.3, 3.7 step 3).
  `sfn/ir` is the second physical compiler implementation capsule, rooted at
  `compiler/capsules/ir/` and exposed through its private `src/mod.sfn`
  facade. Native IR parsing and representation contracts, the IR-facing LLVM
  lowering-diagnostic carrier, target-neutral intrinsic-effect metadata, typed
  SSA data/render/verification, and tensor IR data/fusion/verification now live
  behind that facade. Typed-SSA production and tensor lowering/emission are
  codegen-owned under `compiler/capsules/codegen/src/`; the
  tensor link harness is driver-owned under `compiler/src/build/`. The capsule
  declares `publish = false`, depends only on `sfn/strings` plus the permitted
  implicit runtime prelude, and requires no capabilities. The boundary ratchet
  classifies the moved files exclusively from their physical capsule path.
- **Compiler analyzer capsule** (SFN-746, SFEP-0020 §§3.2, 3.3, 3.5.6,
  3.7 step 4). `sfn/analyzer` owns type and effect checking, ownership,
  decorators, import/re-export validation, type models, and semantic diagnostic
  data under `compiler/capsules/analyzer/`. Its private `src/mod.sfn` facade
  exposes the authority-free `AnalyzerInput -> AnalyzerResult` analyzed-program
  contract; narrow legacy consumers import explicit analyzer submodules. The
  capsule depends only on `sfn/syntax`, `sfn/ir`, and `sfn/strings`, declares
  `publish = false`, and requires no capabilities. The check engine, CLI/JSON
  rendering, filesystem-backed import loading, and build-path effect sink remain
  driver-owned. The boundary ratchet classifies analyzer sources exclusively
  from their physical capsule path and walks the extracted check-analysis
  closure while preserving the no-LLVM-lowering gate.
- **Compiler codegen capsule** (SFN-748, SFEP-0020 §§3.2, 3.3, 3.5.4–5,
  3.5.7, 3.7 step 5). `sfn/codegen` owns target-neutral native emission,
  Sailfin source emission, lambda preparation, typed-SSA production, and tensor
  lowering under `compiler/capsules/codegen/`. Its private facade returns IR
  lines/artifacts plus explicit diagnostics; it performs no filesystem write,
  process execution, target discovery, assembly, or linking. Capture analysis
  finishes in `sfn/analyzer` and the driver supplies `LambdaCaptureRecord[]`
  before entering codegen, so the capsule imports neither parsing nor capture
  analysis. The capsule depends only on `sfn/syntax`, `sfn/analyzer`, `sfn/ir`,
  and the narrow `sfn/strings` leaf, declares `publish = false`, and requires no
  capabilities. Diagnostic printing, artifact publication, subprocess retry,
  and the tensor link harness remain driver-owned. The physical-path ratchet
  asserts this graph and has no codegen string-helper or authority exceptions.
- **Compiler LLVM-provider capsule** (SFN-749, SFEP-0020 §§3.2–4, 3.7 step
  6; SFEP-0066 §3.2). `sfn/codegen-llvm` owns LLVM-specific lowering under
  `compiler/capsules/codegen-llvm/` and exposes a narrow private facade from
  verified `sfn/ir` inputs to LLVM artifact text plus diagnostic data. The
  capsule depends only on `sfn/ir` and the narrow `sfn/strings` leaf, declares
  `publish = false`, and requires no capabilities. The boundary ratchet asserts
  that it cannot import syntax, analyzer, target-neutral codegen, the compiler
  driver, runtime implementation, or authority-bearing standard-library
  capsules, and scans the moved source for filesystem, process, network, and
  capability effects. Target discovery, persistent artifact I/O, assembly,
  external-tool execution, and final linking remain in `sfn/compiler`.
  `sfn/codegen-native` remains a reserved name and does not exist on disk.
- **Build driver.** `<seed> build -p compiler` is the sole self-build driver
  (`compiler/src/cli_main.sfn` + `capsule_resolver.sfn` — pure orchestration,
  no fixups). The `scripts/build.sh` orchestrator (Stage E PR7, #383) and the
  Python fixup script `selfhost_native.py` are retired. Per-module emit,
  `.ll`-to-`.o` assembly, and runtime object compilation share one bounded
  native subprocess pool; `_cr_resolve_jobs` applies the same CPU/RAM ceiling
  and `SAILFIN_BUILD_JOBS=1` serial escape hatch across all three phases
  (SFN-612).
- **Toolchain version pinning — Phase 1** (SFEP-0046, SFN-167). `capsule.toml`
  / `workspace.toml` accept an additive `[toolchain]` section (`sfn =
  "<floor>"`, optional `channel = "stable"|"rc"|"beta"|"alpha"`), parsed by
  `toml_parser.sfn` (`toml_get_toolchain_sfn`/`_channel`). `sfn
  build`/`run`/`check`/`test` gate on it after project/workspace-root
  resolution (`capsule_resolver.sfn::toolchain_gate`): **floor semantics** —
  the running `sfn` must be `>=` the pin (semver §11 precedence, via the new
  `compiler/src/semver.sfn`) — with a member `capsule.toml` pin overriding a
  `workspace.toml` pin per field, and no `[toolchain]` present is a no-op
  (additive). The sailfin repo adopts this at the workspace tier: its root
  `workspace.toml` declares a `[toolchain]` floor (`sfn = "0.8.0-alpha.3"`,
  `channel = "alpha"`) as the default for every member (SFEP-0051 Phase 2,
  SFN-414), making the self-host toolchain contract explicit; the compiler
  member's `capsule.toml` raises `sfn` per field for its own seedcheck gate,
  and the floor stays `<=` the released compiler version so `make compile`
  self-hosts. A mismatch is a hard error (non-zero exit, actionable
  diagnostic); `--skip-toolchain-check`, `SAILFIN_SKIP_TOOLCHAIN_CHECK=1`, or
  `SAILFIN_TOOLCHAIN=off`/`=0` downgrade it to a warning and proceed. `sfn
  init` scaffolds `[toolchain] sfn = "<running version>"` (`toml_generate`).
  **Phase 2 acquire — `sfn toolchain install <version>`** (SFEP-0046 §3.5,
  SFN-168) fetches the pinned release asset
  (`sailfin_<version>_<os>_<arch>.tar.gz`) plus the signed `SHA256SUMS` +
  `SHA256SUMS.sig` natively (`http.download`, `![io, net]` — no shell-out to
  `install.sh`). GitHub release-asset URLs return a 3xx redirect to a signed CDN
  URL, which the native HTTP client now follows (SFN-213). It verifies the
  manifest signature against the embedded release key
  (`sfn/crypto::ed25519_verify_utf8`) and the asset's SHA-256 against the
  manifest, then extracts into the version store. Artifact SHA-256 is computed
  by the binary-safe in-process build hasher (SFN-660), so verification no
  longer depends on a host `sha256sum`/`shasum` command and the same fail-closed
  install path is functional on native Windows. The installer writes under
  `~/.local/share/sailfin/versions/<version>/{sailfin,sfn,runtime/,.sha256}`,
  honoring `INSTALL_BASE`/`SAILFIN_HOME`). Verification is **fail-closed** —
  any signature/digest failure aborts before extraction with nothing written;
  a re-install re-verifies the signed manifest without re-downloading the
  tarball. `SAILFIN_TOOLCHAIN_RELEASE_BASE` overrides the release host for
  air-gapped mirrors (verification stays mandatory). The compiler's own
  `[capabilities] required` gained `net` (SFEP-0046 §4). **Re-exec dispatch**
  (SFEP-0046 §3.5, SFN-172) is shipped: on a floor-check failure, `sfn
  build`/`run`/`check`/`test` consult `SAILFIN_TOOLCHAIN` — `auto` (default)
  ensures the pinned toolchain is in the version store (fetching it via the
  SFN-168 install path if absent) and transparently re-execs it with the
  original argv; `local` verifies only and never fetches; `<version>` forces
  that exact dispatch target; `off`/`0` skips the gate. A re-entrancy guard
  (`SAILFIN_TOOLCHAIN_DISPATCHED=<version>`) hard-fails loudly rather than
  looping if a dispatched toolchain still doesn't satisfy the pin. Offline, an
  already-stored toolchain dispatches after re-verifying its completeness
  marker; offline with no stored toolchain prints the `sfn toolchain install
  <version>` hint. SFEP-0046 tracks six issues (SFN-167–172); with pin/verify,
  install, and dispatch now shipped, the proposal stays `Accepted` pending the
  remaining tracked issues.
- **Compiler bootstrap manifest — `bootstrap.toml` + `sfn dev bootstrap`**
  (SFEP-0047, SFN-197). A root `bootstrap.toml` is the compiler checkout's
  exact bootstrap-seed policy — `[seed].version/source/repo/asset_prefix/policy`,
  `[store].install_base/bin_dir`, `[verify]` — distinct from the
  capsule/workspace `[toolchain]` *floor* (SFEP-0046): it answers "which exact
  released compiler bootstraps this checkout?", not "can this toolchain build
  this capsule?". The reader (`compiler/src/bootstrap_manifest.sfn`) is a
  shallow TOML subset over `toml_get_string`, fail-closed on a missing version,
  an unsupported `policy`, an unknown `source`, or `required = false` for a
  github-release seed. `sfn build -p compiler` enters **bootstrap mode**
  (`bootstrap_gate_or_dispatch`, `build.sfn`): when the running toolchain's core
  version already equals the pinned seed — every `make compile` self-host pass —
  it is a no-op and builds in-process; a *different* toolchain acquires the
  exact seed into the repo-local store (reusing the SFN-168 fail-closed
  fetch/verify installer against `build/toolchains/seed`) and re-execs it with a
  `SAILFIN_BOOTSTRAP_DISPATCHED` re-entrancy guard (`SAILFIN_BOOTSTRAP=off`
  skips the gate). Maintainer commands live under a dev namespace kept out of
  the primary `sfn --help`: `sfn dev bootstrap fetch|build|check|pin`.
  `bootstrap.toml` `[seed].version` is the sole source of truth for the pinned
  self-host seed. The Makefile bootstrap recipes stay as transitional
  compatibility shims.
- **Native bootstrap install + fingerprint gate** (SFN-679). `sfn dev
  bootstrap build` no longer stops at `build/sailfin/program` — it now owns
  publishing a working compiler end to end. A new whole-tree source digest
  (`compiler/src/build/source_fingerprint.sfn`: SHA-256 over a path-sorted
  `<sha256(content)>\t<path>` manifest of every `*.sfn` under `compiler/src`,
  `compiler/capsules`, and `runtime`, content-addressed so restoring stale content under a fresh
  mtime cannot look current) gates the build: snapshot the fingerprint,
  short-circuit when it matches the already-installed binary's recorded
  digest, otherwise build via the pinned seed, re-fingerprint afterwards to
  catch a source edit landing mid-build, install atomically to
  `build/bin/sfn` (`.exe` on Windows), and only then record the digest — a
  binary that fails to run is never recorded as current, so the next build
  retries instead of wedging on a false "up to date". New leaves: `sfn dev
  bootstrap fingerprint [<root>...]` prints the digest; `sfn dev bootstrap
  install [--from <path>]` publishes an already-built binary and records it.
  Overrides: `--force` on `build`, `SAILFIN_BOOTSTRAP_FORCE=1` (also accepts
  `true`/`yes`); `make compile` additionally honours `FORCE=1`.
  `scripts/compiler_source_fingerprint.sh` is retired — `make compile` /
  `make rebuild` and the two CI sites delegate to the native command instead;
  the native digest deliberately does not byte-match the retired script's
  git-blob-SHA1-based output. **Two caveats.** (1) The install/fingerprint
  policy is executed *by* the pinned seed (`sfn dev bootstrap build` is a
  seed-run command), so it is only exercisable once a seed carrying it is
  pinned — until then `make compile` remains the practical path, and it
  already delegates the same install + fingerprint logic to the freshly
  built compiler, landing at the same path with the same recorded digest.
  (2) The digest scope covers both compiler source populations plus `runtime`;
  it does not cover top-level dependency capsules under `capsules/*/src/` or
  `compiler/capsule.toml` itself, so a capsule-dependency edit or a manifest
  version bump does not invalidate the gate (`make compile` reports
  up-to-date regardless); workaround is `FORCE=1 make compile` or `sfn dev
  bootstrap build --force`. Prerequisite for the final Makefile sweep in the
  Makefile Retirement epic (`docs/proposals/0006-build-architecture.md`
  Stage D): `compile-impl`/`rebuild-impl` no longer own install/fingerprint
  policy, though the Makefile itself still exists.
- **Native clean command** (SFN-680). `sfn dev clean build|dist|all
  [--include-seed] [--dry-run]` (`compiler/src/cli/commands/dev_clean.sfn`)
  replaces the `make clean-build` / `make clean` / `make clean-all` shell
  recipes: `build` removes every top-level `build/` entry except the fetched
  seed toolchain store (derived from `bootstrap.toml [store]`), `--include-seed`
  (or `SAILFIN_CLEAN_KEEP_SEED=0`; `make clean-build KEEP_SEED=0` translates
  into it) additionally removes that store, and `dist` removes the
  packaged-release output directory. It refuses
  to run outside a compiler checkout and never touches the global
  content-addressed cache root that `sfn cache clean` owns. Like SFN-679, this
  is a seed-run command, so it is only exercisable once a seed carrying it is
  pinned — until then the Makefile recipes probe for support and fall back to
  their transitional shell path.
- **Native pipeline verify command** (SFN-725). `sfn dev verify [--fast]
  [--full-pass1] [--json] [--strict] [--jobs N] [--test-timeout SECS]`
  (`compiler/src/cli/commands/dev_verify.sfn`, hidden `dev` namespace like
  `dev bootstrap`/`dev clean`) sequences the `make check` pipeline as a
  five-phase ledger — `compile` → `smoke-pass1` → `tests-pass1` (skipped
  unless `--full-pass1`) → `selfhost` → `tests-seedcheck` — and emits the
  agent verdict block itself, replacing the bash `scripts/agent_report.sh`
  banner-scraper. Phase identity is structural: the verb dispatches each
  phase directly instead of inferring it from a log banner, so the
  `#1502`-class ledger drift is no longer possible. Classification is
  producer-emitted from child exit status rather than regexed from log
  text: exit `2` → `setup-error`, `124` → `timeout` (a supervisor-owned
  native deadline), `137` → `oom` (the 8 GiB `RLIMIT_AS` self-cap),
  `139`/`135`/`136`/`132` → `crash`, else `compile-error`/`test-failure` by
  phase kind; a stage2/stage3 fixed-point mismatch classifies as
  `nondeterminism` with `status:"warn"` and exit `0`. `sfn selfhost --json`
  gained a new `sailfin-selfhost/1` sub-envelope in the same change
  (sub-phases `stage2`, `seedcheck-smoke`, `stage3`, `fixed-point`, plus
  flat scalars `failed_phase`, `fixed_point_checked`, `fixed_point`,
  `binary_match`, and the existing determinism diff nested under
  `determinism`) — previously `--json` printed only the determinism diff,
  suppressed all phase structure, and emitted nothing on an early exit.
  `verify` splices that line into its report verbatim and scrapes the flat
  scalars, since `compiler/src` has no JSON parser and cannot import
  `sfn/json` (build cycle). `build/agent-report.verify.json` is rewritten
  via atomic rename after each phase completes, carrying `"complete":
  false` until the verdict lands, so a `SIGKILL` of the supervisor still
  leaves the last completed phase readable — a net gain over
  `agent_report.sh`, whose report write runs only from the `EXIT` trap. The
  verdict envelope stays `sailfin-make/1` with a new `target` value
  `"verify"`; the rename to `sailfin-run/2` is SFEP-0014 Phase 7 (SFN-726),
  deliberately not interleaved. Like SFN-679 and SFN-680, this is a
  seed-run command, so it is only exercisable once a seed carrying it is
  pinned — until then `make check` remains the practical path.
- **Release signing (producer side).** Every release publishes a `SHA256SUMS`
  manifest over its assets plus a detached Ed25519 signature (`SHA256SUMS.sig`,
  128 hex chars) — generated by `scripts/sign-release-manifest.sh`, wired into
  `.github/workflows/release-tag.yml`, signing with the
  `SAILFIN_RELEASE_SIGNING_KEY` CI secret. The matching verification public key
  is pinned into the `sfn` binary at build time
  (`compiler/src/release_trust.sfn::release_signing_public_key_hex()`, queryable
  via `sfn version --signing-key`), so a
  fetched toolchain can be verified in-process with
  `sfn/crypto::ed25519_verify_utf8` — no trust-on-first-use. This is the
  supply-chain root for toolchain auto-fetch (SFN-171); the consumer
  fetch+verify path is SFN-168. Trust model + key rotation:
  `docs/release-signing.md`. The user-facing verification guide publishes the
  production PEM, raw key, and SHA-256 SPKI fingerprint at
  `site/src/content/docs/docs/getting-started/verify-download.md`, with the PEM
  also served directly from `/.well-known/sailfin-release-signing-key.pem`
  (SFN-203). The bootstrap installers (`install.sh` and `install.ps1`) embed the
  same public key and verify the signed manifest plus the selected archive's
  digest before extraction. They warn and continue only when verification is
  unavailable (an unsigned older release or no suitable OpenSSL), and abort on
  an invalid signature or digest mismatch (SFN-204). Design: SFEP-0046 §3.5.
- **CLI dispatch.** `sailfin_cli_main_v2` (`compiler/src/cli/main.sfn`) is the
  sole command router: it builds a root `Command` via the `sfn/cli` capsule
  from each subcommand's `command_def()` and dispatches to per-command
  `cli/commands/<name>.sfn` `run` handlers, handling the residual
  help / `selfhost` / bare-`.sfn`-file / unknown-command paths inline. As of
  SFEP-0027 Phase C (#1797) the former `sailfin_cli_main_legacy` shim is gone;
  `cli_main.sfn` retains only the `@main` entry shims (`main`,
  `native_cli_main`, `sailfin_cli_main_with_paths`, `_arena_telemetry_*`) plus
  `_usage`. The former `cli_commands.sfn` / `cli_commands_utils.sfn` emitters
  were deleted, their bodies relocated by consumer (driver-owned helpers to
  `compiler/src/build/`; the role-oriented private capsule graph is deferred to
  SFEP-0020 / #345). Per-worker peak RSS drop drove the sequencing
  (SFEP-0027 §2.1); a line-budget sentinel
  (`compiler/tests/unit/cli_main_line_budget_test.sfn`) guards against
  re-ballooning.
- **Terminal color.** `sfn/cli` emits real ANSI SGR sequences through its
  `bold` / color and `paint_*` helpers, with `Style` policy for
  `auto|always|never` and `NO_COLOR`. The compiler accepts the root option
  `sfn --color <auto|always|never> <command>` and applies the resolved stderr
  style to the severity label of human diagnostics; structured JSON output
  continues to use the plain renderer. `auto` enables ANSI only when the
  selected stream is a terminal and `NO_COLOR` is empty; redirected and
  captured output remains plain by default.
- **Deterministic self-hosting.** The compiler is a verified fixed point — the
  seedcheck generation and the generation it rebuilds produce byte-identical
  LLVM IR across all modules; `make check` enforces this. The triple-pass
  validation (seedcheck + fixed-point rebuild with per-generation `.ll`
  scratch isolation, hello-world smoke gate,
  fixed-point IR diff, and seedcheck→canonical promotion) is owned by the
  compiler as the internal `sfn selfhost` command (`compiler/src/cli_selfhost.sfn`,
  #1502, epic #513 Phase 1) — `make check`'s `check-impl` is now a one-line
  invocation of it rather than ~90 lines of shell. The verb is internal
  (absent from `sfn --help`; CI / `make check` are its only callers, mirroring
  Go's `cmd/dist` and Rust's `x.py`). A non-fixed-point result warns by default
  (parity with the former shell); `sfn selfhost --strict` makes it fatal.
- **Unified resolver.** `sfn build` / `sfn run` / `sfn check` / `sfn test`
  all resolve dependencies through `capsule_resolver.sfn`
  (`prepare_project_capsules*`): relative imports, manifest `[dependencies]`,
  and workspace-implicit `sfn/X` imports in one pass. Textual import inlining
  is gone (Stages A–B). Standalone files resolve bundled workspace imports
  from the running compiler's `binary_dir`, so `check`, `build`, and `run`
  keep the same import closure when the caller changes cwd (SFN-352 / #2312),
  while unresolved specs still fall back to the user capsule cache. By-name
  and relative imports of a workspace capsule converge to one mangled symbol
  (#873). Test lowering retains imported free-function signatures for direct
  and aliased calls, including struct-returning capsule APIs such as
  `sfn/tensor`, and does not synthesize scalar helpers over imported symbols
  (SFN-436). Lowering fails closed with `E1001` when an imported local name
  collides with a function defined in the importing module, or when the import
  set exceeds the mangling safety bound, rather than dropping the affected
  rewrite and emitting a binary with the wrong symbol (SFN-530).
- **Capsule resolver — import-reachable filtering (build path)** (SFEP-0070,
  SFN-833). `sfn build`, `sfn run`, and the `sfn test` link path narrow
  `resolved.sources` to the import-reachable closure before staging: a
  declared dependency capsule nothing imports now contributes zero modules to
  the build and the link, and a submodule of an imported capsule that neither
  the capsule's barrel re-exports nor any sibling imports is likewise dropped.
  `sfn check` stays deliberately unfiltered, so the build set is always a
  subset of the check set. A capsule reached through a bare spec (`import ...
  from "sfn/crypto"`) still retains everything its barrel re-exports, so a
  capsule whose barrel re-exports its whole surface — `sfn/crypto` today —
  sees no reduction yet; narrowing individual re-exported names is SFN-834.
  The filter **fails open**: if it cannot prove its own closure invariant it
  prints a diagnostic, falls back to the unfiltered set, and the build
  proceeds unchanged — it can only ever remove modules, never add one.
  `SAILFIN_CAPSULE_FILTER=off` (also `0`/`false`) disables the filter
  entirely, reproducing the pre-filter artifact set exactly;
  `SAILFIN_TRACE_CAPSULE_FILTER=1` prints retained/dropped module counts and
  the dropped slug list to stderr. Measured on the three
  `docs/perf/consumer-baseline.csv` fixtures, the mechanism itself produced no
  change in `modules_staged`, ctor count, or binary size, because all three
  reach `sfn/crypto` through its whole-surface barrel — the mechanism is in
  place, and the measurable win arrives with SFN-834's re-export name
  narrowing.
- **Workspace default targets.** At a workspace root, bare `sfn build` and
  `sfn test` fan out over `[workspace].default-members`; when the field is
  absent they target every member. Each member has distinguishable output and
  the command fails if any selected member fails (SFEP-0051 Phase 5, SFN-422).
- **Build cache.** Content-addressed cache defaulting to a shared per-user root
  (`$XDG_CACHE_HOME/sailfin/v2` or `$HOME/.cache/sailfin/v2`, schema-suffixed;
  `$SAILFIN_BUILD_CACHE_DIR` override; in-tree `build/cache/v2` fallback when
  `$HOME` is unresolvable and pinned in-tree for the compiler self-host build —
  SFEP-0040 §3.1) with per-source dep manifests,
  `--no-cache` / `--clean` / `--cache-trace` flags, a `[cache]` summary on
  stderr for `sfn build`, and opt-in `sfn run` cache telemetry via
  `--cache-trace` (Stage C PR1–1f, #254–#259). `sfn cache info/prune/clean` (SFEP-0040
  §3.2–3.4, #1893) adds bounded-size GC over the same store: `info` reports
  root/entry-count/size, `prune [--max-size <bytes>] [--max-age <days>]`
  evicts LRU (mtime touched on cache hit) with conservative defaults (~5 GiB /
  30 days) and is opt-in only (no implicit prune on builds), and `clean
  [--all-schemas]` removes the current schema tree, optionally sweeping stale
  sibling `v<M>` schema trees too. Runtime C/LL/sfn objects share the same
  cache across work-dirs (#915, #1096). `sfn test` content-addresses each
  linked test binary by the compiler binary's SHA-256 as well as its source,
  dependency, runtime, and flag inputs; byte-identical compilers share entries
  across commits, while different compiler binaries always miss (SFN-545,
  #1230, #1233). `make check` passes
  `--no-test-cache` so the full gate always cold-builds. **Runtime object
  invalidation (#1197):** with the C runtime retired (#822/#823) the entire
  runtime is now `sfn-sources` (`runtime/capsule.toml`) emitted by the Sailfin
  compiler, so a codegen change in `compiler/src` alters a runtime module's IR
  without touching its source bytes. The runtime sfn-source `.o` (and
  `.sfn-asm` import-context) cache therefore folds the emitting compiler's
  identity (`cache_compiler_identity` — the build-stamp commit hash, plus the
  binary SHA-256 for `.dirty` stamps) into its key, so a recompiled compiler
  busts the cache automatically — no manual `secsplit*` tag bump or
  `rm build/sailfin/*.o`. Which binary emits the runtime: during a cold
  `make compile` the *seed* emits the first-pass binary's runtime, so a
  runtime codegen fix only reaches the linked runtime after the *next* pass
  emits it (the first-pass binary re-emits for `seedcheck`, and `make check`'s
  test binaries link those first-pass-emitted objects); a codegen fix that must
  change the runtime shipped in `build/native` therefore still requires a fresh
  seed pin (same seed dependency as #1193's E0808 class).
- **Per-capsule artifacts.** `sfn build -p` writes
  `build/capsules/<scope>/<name>/` with a `manifest.json` sidecar
  (schema v1) enumerating per-module IR + cache keys (Stage C2, #261–#264).
- **`sfn package`.** Sailfin-native packaging: compiler mode, user-capsule
  mode (`-p`), and `--installer` mode produce tarball + sha256 + JSON
  manifest (Stage C4, #265–#267); replaces `tools/package.sh`.
- **Structured output.** `sfn build --json` emits a schema-versioned
  `BuildReport` (#259); `sfn check --json` emits the `sailfin-check/1`
  envelope (`docs/reference/check-json-schema.md`), consumed by the MCP
  server.
- **Driver-owned import-context loading (SFN-736, SFEP-0020 §§3.3, 3.5).**
  `compiler/src/import_context.sfn` now owns staged-artifact root selection,
  relative/module-alias resolution, transitive discovery, and every
  `.layout-manifest`, `.sfn-asm`, and `.slugalias` read. LLVM lowering accepts
  an explicit IR-owned `ImportedModuleContext`, including resolved alias-to-
  provider mappings for pure symbol mangling; it has no process-global root
  setter and performs no import-context filesystem access. The public lowering
  surface exposes only context-carrying entry points, reducing the I/O-effect
  ratchets from 13 to 11 in `entrypoints.sfn` and from 6 to 4 in
  `lowering_core/file_emission.sfn`. Check-only capsule preparation and native
  staging bypass `main.sfn` and the LLVM lowering subtree; the compiler capsule
  boundary suite walks the multi-capsule check import closure to keep that
  separation enforced.
- **Driver-drained LLVM lowering events (SFN-743, SFEP-0020 §4).** Flag-gated
  lowering and test-runner traces append to a provider-owned ordered buffer
  beside the resolved LLVM debug state instead of writing stderr from the
  provider. Provider diagnostics use the same stream, preserving their exact
  order relative to traces. The driver drains after every provider return and
  before interpreting success or failure, so events emitted before a returned
  lowering failure survive. No callback or sink parameter enters the lowering
  call graph, and the LLVM authority ratchet has no remaining I/O exceptions.
  Provider-side `test llvm: phase=… ms=…` timing was retired because it read
  the clock inside the capability-free library (including one unconditional
  read on ordinary lowering); driver `--timing` is the canonical timing
  surface, while `SAILFIN_TRACE_TEST_RUNNER` retains ordered progress events.
  Asynchronous process-crash telemetry remains a separate runtime concern; the
  provider buffer does not claim signal- or abort-safe delivery.
- **Pure analyzer boundary (SFN-713, SFEP-0020 §3.5.6).**
  `compiler/capsules/analyzer/src/analyzer.sfn` exposes an authority-free
  `AnalyzerInput -> AnalyzerResult` contract over parsed syntax, imported
  interfaces/symbols, resolved import context, runtime-global names, and
  effect policy. It returns analyzed program data plus producer-tagged semantic
  diagnostics without importing driver, codegen, or LLVM modules.
  Target-neutral intrinsic identities and semantic effects live in
  `sfn/ir`'s `intrinsic_effects.sfn`; the analyzer consumes that pure registry
  directly. LLVM does not import the semantic registry: its descriptors own
  only the provider-local target lookup plus symbol/type/ABI lowering data.
  `check/engine.sfn` remains driver-owned: it resolves workspaces and relative
  modules, reads sources/runtime context and policy, calls the facade, and
  renders the existing text or `sailfin-check/1` JSON presentation unchanged.
- **Driver-owned artifact publication (SFN-712, SFEP-0020 §3.5.5).**
  Target-neutral emission returns native artifact identity, line data, and
  typed diagnostics; LLVM lowering returns the corresponding LLVM artifact
  result rather than accepting a destination path. Codegen modules no longer
  import driver filesystem publication helpers. `main.sfn` chooses native and
  LLVM destinations, reports lowering failures, removes stale output after a
  fatal lowering result, and publishes line payloads through the existing
  sibling-temp atomic rename path. Artifact bytes, short-write handling,
  failed-rename cleanup, and resolver cache policy remain unchanged.
- **Diagnostics.** One renderer (`diagnostics_render.sfn`) serves check and
  build paths. Semantic analysis uses analyzer-owned `Diag`/`Span` values from
  `diagnostic.sfn`, including code, string severity, file path, producing
  stage, optional span, and structured fix-it. Frontend producers still mint
  the legacy token-backed `Diagnostic` and convert at the sink boundary, so
  `sailfin-check/1` and human output remain byte-compatible (SFEP-0061 S1,
  SFN-534). Effect diagnostics
  carry structured `FixSuggestion`/`TextEdit` for `sfn fix` / LSP (Track B).
  LLVM lowering carries an IR-owned `LoweringDiagnostic[]` sidecar through its
  result graph without importing analyzer contracts: every retained `[fatal]`
  string has a coded lowering-stage diagnostic, direct
  statement/`let`/routine consumers attach their `NativeSourceSpan`, and the
  legacy string array remains the fail-closed gate boundary with unchanged
  text (SFEP-0061 S2, SFN-535; SFN-745).
  `sfn check` surfaces parse errors (`E0500`, #974) and implicit re-export
  bans (`E0600`) via the shared `reexport_check.sfn`. Malformed-but-dispatched
  top-level declarations — a broken parameter list (`fn broken( {`), a missing
  variable initializer (`let x = ;`), and a missing struct field type
  (`struct S { x: }`) — now produce `E0501`/`E0502`/`E0503` parse diagnostics
  in `sfn check` and are rejected by `build` before LLVM lowering/linking
  (SFN-18); recovery still lets an independent following declaration parse
  and report on its own. A `let` binding whose name is not an identifier
  (`let{`, `let 3`) produces `E0504`, and a function body that opens with `{`
  but hits EOF before its closing `}` (a truncated/cut-off program) produces
  `E0505` — both reject in `check` and `build` before lowering, so a truncated
  body can no longer silently lose `main` and surface as a missing-`main`
  linker ICE (SFN-384).
- **Import-resolution checking (#1953).** `sfn check` now diagnoses a
  relative `import { ... } from "./x"`/`"../x"` that resolves to no module
  on disk (`E0430`) and a named specifier defined nowhere in the staged
  import closure (`E0431`, closure-wide "defined somewhere" — Sailfin
  resolves imports globally by name, not per-declaring-module export).
  Narrows the check≠build gap (#1389) for the wrong-import-depth class
  (e.g. #1952). Scope: only `./`/`../` specs; `sfn/...` and runtime imports
  are unaffected; checked only in `sfn check`, not the build path.
- **Five more check≠build divergences closed (SFN-385, SFN-562, SFN-584).** A method call on a
  primitive receiver that resolves to no primitive method and no in-scope
  free function (`E0012`, e.g. `field.to_uppercase()` on a `string`), an
  arithmetic op mixing a proven `int` and `float` operand (`E0306`), array
  arithmetic such as `int[] + int[]` (`E0307`, anchored on the operator;
  explicit `.concat(...)` remains the concatenation surface), proven struct
  arithmetic such as `Point + Point` (`E0308`, anchored on the operator), and a
  malformed array-type spelling such as `[int]`/`[]string` (`E0830`,
  canonical form is `T[]`) previously passed `sfn check` and only failed
  fatally at LLVM lowering; all five now surface as frontend diagnostics
  before lowering. Fail-open: each fires only when the frontend can prove
  invalidity, so string methods, imported free functions, canonical `T[]`
  arrays, and same-type/mixed-width integer arithmetic are unaffected.
- **Basic primitive type and value resolution diagnostics (SFN-675).** The
  shared frontend now rejects a proven primitive mismatch at an annotated
  `let`, a body-bearing callable's parameter default, local free-function
  argument, or declared return (`E0309`), and an unresolved identifier in a
  checked function-body value expression (`E0014`), including member receivers
  and structured-concurrency operands. Both `sfn check` and build stop before
  lowering, with source spans. Declaration-only extern/interface defaults are
  outside this slice. The rule remains fail-open for compound, imported,
  generic, and otherwise uninferred types, and preserves the language's
  existing numeric compatibility boundaries: `int`/`float` coercions remain
  accepted here, while the established lowering gate continues to own
  boolean-to-numeric `E0537` and its explicit-cast fix-it.
- **Emit pipeline.** Parallel per-module emit fan-out (Stage E PR3, #278)
  with a shared retry + validator cascade (#515); driver `--work-dir` flag
  (#378); cross-Windows packaging leg (`ci-cross-windows`, #280).
- **Experimental LLVM JIT** execution is available for targeted backend
  coverage. CI builds/tests via `.github/workflows/ci.yml`; compiler tests
  live in `compiler/tests/{unit,integration,e2e}`.

## Compiler Pipeline (Current)

- `compiler/src/` is the primary toolchain; `make compile` produces
  `build/bin/sfn`. Pipeline: Lexer → Parser → Type Checker →
  Effect Checker → Native Emitter (`.sfn-asm`) → LLVM Lowering.
- **Shape-typed tensor IR foundation** (SFEP-0053, SFN-427): the compiler has
  an in-memory tensor tier for static dense `f64` elementwise add/multiply,
  full reduction sum, and 2D matrix multiplication. Tensor graphs verify
  dtype, shape, layout, SSA ordering, and operation invariants before passing
  through the explicit fusion seam and deterministic scalar-reference exit.
  That exit emits ordinary `.sfn-asm` loops and provides the CPU numerical
  oracle. Checked-AST construction and automatic tensor-function selection are
  not yet wired, so ordinary source programs continue directly to the native
  emitter; StableHLO, dynamic shapes, autodiff, and device codegen remain
  planned follow-ons.
- **Tensor-IR matmul executes end-to-end** (SFEP-0052 Track A Rung 1, SFN-447):
  the tensor-IR scalar matmul lowering now links to a runnable native binary and
  is numerically verified against an independent naive oracle within relative
  error ≤ 1e-12 (identical f64 accumulation order — effectively exact). This
  closed a latent gap where the scalar-reference exit emitted a `.fn` header with
  no `.param` declarations, so the native-IR parser bound zero arguments and the
  kernel lowered to a valid-looking but uncallable `define`; the prior snapshot
  test only asserted the emitted LLVM contained `define`, never running it. The
  emitted kernel is exposed as a swappable callable
  (`build_tensor_matmul_kernel_binary`, `tensor_ir_link_harness.sfn`) so later
  Rung-1 leaves (SIMD, cache-blocking, parallel) reuse the same equivalence +
  timing harness. Single-thread scalar baseline anchor (hardware-dependent, for
  measuring later deltas — not a CI threshold): **~1.0 GFLOP/s at 128³, ~0.6
  GFLOP/s at 256³** (naive f64, `.push`-allocating). Cross-check: the Rung-0
  cache-blocked `sfn/tensor` capsule oracle is ~0.64 GFLOP/s single-thread at
  128³ (SFN-425).
- **Tensor-IR scalar matmul auto-vectorization probe** (SFEP-0052 Track A
  Rung 1, SFN-448): row-major matmul lowers as row → K → column so the
  innermost loop walks the right operand and output contiguously while
  preserving each result element's ascending-K accumulation order. The tensor
  lowering proves the static buffer extents once, uses unchecked loads only
  inside that verified extent, and marks the contiguous loop with
  `llvm.loop.vectorize.enable` through a dedicated `.loop vectorize` native-IR
  hint. On the same Apple-silicon host and 20-iteration 128³ harness, this
  measured **3.65 GFLOP/s versus 1.27 GFLOP/s for SFN-447 (2.87×)** while
  retaining the numerical oracle gate. Clang 18 still reports the forced loop
  as not vectorized because it cannot identify array bounds for the
  heap-backed `float[]` result, and the optimized IR contains no vector body.
  The positive gain therefore comes from contiguous scalar traversal plus
  removing repeated proven bounds checks; explicit vector IR remains justified
  for the SFN-449 chain. These figures are local decision-gate measurements,
  not CI thresholds.
- **StableHLO substrate-exit spike** (SFEP-0052 §3.1(3), SFN-429): the tensor
  IR's SFN-427 op set (elementwise add/multiply, reduction sum, 2D matmul) emits
  portable StableHLO text (`emit_stablehlo_module`,
  `compiler/capsules/codegen/src/tensor_ir_emit_stablehlo.sfn`) — the first Track-A substrate
  exit, so an external accelerator middle-end (XLA) supplies fusion/tiling/layout
  instead of hand-authored codegen. Elementwise ops render `stablehlo.add`/
  `stablehlo.multiply`, matmul `stablehlo.dot`, and reduction the compact
  `stablehlo.reduce(... init: ...) applies stablehlo.add` form over a scalar zero
  constant; the emitter deliberately does not fuse before the exit (the substrate
  does that). Coverage is a golden-emit snapshot plus a round-trip leg that
  parses/verifies through `stablehlo-opt` when present and skips cleanly when the
  tool is absent (`compiler/tests/e2e/tensor_ir_stablehlo_emit_test.sfn`). A spike
  — full op coverage, autodiff lowering, the vendor-FFI exit, collectives, and
  dynamic shapes are out of scope.
- **Backend seam** (`compiler/src/backend.sfn`, #1112; SFEP-0066 §3.2): a
  `Backend` interface hides the driver's codegen/link `process.run` call
  sites; `LlvmTextBackend` (today's textual-LLVM-IR + clang path) is the
  sole impl. Zero behavior change — the driver still computes runtime
  objects, linker selection, dead-strip, and link-libs; the backend owns
  only the final argv + `process.run`. The seam is not pluggable dispatch:
  `compiler/src` does not self-host interface-typed values, so the driver
  constructs `LlvmTextBackend {}` concretely. A future code generator — the
  LLVM C-API binding (#347) or a seal-sufficient native backend
  (SFEP-0066 §3.3) — plugs in at the capsule boundary instead (a
  `sfn/codegen-native` capsule beside `sfn/codegen-llvm`), not through this
  interface. On Linux x86-64/aarch64 the final link is no longer a clang
  invocation: `direct_link.sfn` builds a bare `ld.lld` argv and tries it
  first, falling back to a traced clang invocation on any missing
  prerequisite (SFEP-0066 §3.1 role table). `SAILFIN_TRACE_LINK=1` echoes
  the resolved link argv to stderr (`[trace-link] <argv>`, #1908, naming
  `ld.lld` or `clang` per the path taken) for both the program and test
  link layouts; linker-choice diagnostics (`[link] ...`) are trace-gated
  too. On Darwin, the backend self-supplies the SDK and host deployment
  target so outdated Homebrew LLVM does not infer stale macOS versions
  during links. The trace path has no behavior change when unset.
  **Object-only link boundary (SFN-453):** program, capsule-dependency, and test
  LLVM inputs are content-addressed and assembled before `Backend.link`;
  `LinkPlan` contains only object paths, so clang's assembler and linker-driver
  roles no longer share one invocation. A read-only shared object cache falls
  back to ephemeral objects beside the IR, never to raw `.ll` at final link.
  **Independence status:** the external-tool invocation seam and the
  object-only link boundary are complete; Link is owned on Linux
  x86-64/aarch64 (`docs/backend-independence.md` §7). Typed SSA's L1
  declaration producer is also reachable through
  `sfn emit typed-ssa`: scalar signatures, linkage, and canonical effect sets
  are parsed from `.sfn-asm`, verified, and rendered deterministically; an
  unsupported signature rejects the whole module. The typed SSA model,
  verifier, and renderer define explicit, non-inferring scalar conversion
  kinds for integer widths/signs, integer/float boundaries, float widths, and
  pointer/integer boundaries. The post-v0 structural type foundation is also
  present as a module-local, owner-qualified graph and deterministic interner:
  it distinguishes raw pointers from checked references, canonicalizes unions,
  includes exact effect rows and call kind in function identity, and carries
  intrinsic/nominal constructor ownership metadata. Source-annotation
  resolution, inference/finalization, `.sfn-asm` type-table transport, semantic
  consumer migration, body production, and backend consumption remain
  unconnected. Function bodies, capability derivation/manifests, direct linker
  ownership, native object/code emission, gated call sites, and native-backend
  self-hosting are not shipped. #343's mold/lld selection still runs behind
  clang on the fallback path and is not itself an owned link path
  (`docs/backend-independence.md` §7).
- **Native TLS 1.3 (SFEP-0036/SFEP-0048, SFN-341).** The `sfn/crypto` capsule
  and `runtime/sfn/platform/tls_record.sfn` replace the OpenSSL-linked TLS
  stack; the toolchain links no `-lssl`/`-lcrypto`, and OpenSSL is no longer a
  build-host or link-host dependency for the compiler, the runtime, or any
  per-test binary the suite links. The narrowing this trades for: the native
  server handshake (`sfn_serve_tls`) accepts an Ed25519 server certificate
  only — CertificateVerify signing is Ed25519-only per SFEP-0048 §6.3, where
  the OpenSSL-backed stack accepted any certificate OpenSSL could load.
  RSA/ECDSA signing is out of scope for that section; ECDSA-P256 signing is
  the tracked follow-on that closes the gap. Windows gets a working native
  handshake and honors `SAILFIN_TLS_CAFILE`, but has no system
  certificate-store binding yet.
- **Effect enforcement is a build gate** (Phases A–F, shipped 2026-04-26):
  `validate_effects()` runs from every `compile_to_*` entry and fails the
  build on undeclared effects. `SAILFIN_EFFECT_ENFORCE=warning|off` are the
  transitional opt-outs. Diagnostics carry source spans and per-call-site
  carets.
- **Cross-module effect propagation** (`E0402`, Phase E/E2): callers inherit
  imported callees' declared effects; aliased imports, statically resolved
  member callees, and imported decorator effects resolve. Unresolved or dynamic
  callees yield no guessed effect.
- **Capsule capability cross-check** (`E0403`, Phase F): `[capabilities]
  required = [...]` is a compile-time contract; an empty surface skips the
  check.
- **Name-resolution-driven effect detection** (epic #1180, Phase G): every
  effect requirement is resolved through the symbol table (local + imported)
  and the runtime descriptor registry — not text heuristics. The legacy
  text-pattern fallback (`collect_effects_from_text`) was proven redundant by
  a parity harness (#1185) and **deleted in #1186**; parse-failure `Raw`/
  `Unknown` nodes are effect-blind by design (they carry no resolvable call).
  A #1627 audit confirmed that invariant held *except* for `<operand> as <type>`
  casts: an identifier-typed cast parsed as a structured `Cast` the checker never
  walked, and a pointer-typed cast (`as * T`) over an effectful operand degraded
  the whole expression to `Raw` — so `print.info(x) as * i64` reached codegen with
  no `![io]`. #1627 adds a `Cast` effect-checker arm (walks the operand) and lifts
  pointer cast targets into `Cast` **for effect-bearing (non-identifier) operands**,
  so a cast can no longer hide its operand's effects (`E0400`). Bare-identifier
  pointer casts (`<fn>`/`<ptr-value> as * u8`) intentionally stay `Raw` — they
  carry no effect, and this preserves the #1147 function-reference diagnostics and
  the shadow-parser lowering unchanged. The ternary `? :` escape is closed the
  same way in **#1690**: a ternary now parses into a structured `Conditional`
  node (`cond ? then : else`) the effect checker walks, unioning the effects of
  all three children, so `cond ? readFile() : x` can no longer reach codegen
  effect-free (`E0400`); native lowering supports numeric unary-negation in
  either branch while preserving defined then/else/merge control flow. The
  disambiguation leaves the postfix `?` try operator
  (`a()?`, `a()?.b()?`) untouched — a `?` is ternary only when the token after it
  can start an expression *and* a top-level `:` follows. The previously
  Raw-degraded effect-escapes are now structured into real AST nodes the effect
  checker walks: casts (#1627/#1737), prefix `*`/`&` (#1737), ternary (#1690),
  assignment-as-expression (#1745), and typed `channel:Type` (#1750) — so each
  surfaces its operand's effects instead of silently degrading to `Raw`. With
  those structured (epic #1180), the blanket fail-closed `Raw` backstop
  (**E0818**, #1743) is **shipped** as defense-in-depth: any non-empty
  `Expression.Raw` reaching the typecheck expression walk that is not a recognized
  fn-reference (`& fn` / `<fn> as T`, still handled by `check_fn_reference_raw`)
  emits E0818 ("unstructured expression cannot be analyzed; rewrite so the compiler
  can parse it"); match-arm shorthand-destructure patterns (legitimately Raw) are
  exempt via `walk_match_pattern`. Diagnostic factory:
  `make_unanalyzable_raw_diagnostic` (`typecheck_types.sfn`). Regression test:
  `compiler/tests/unit/effect_raw_failclosed_test.sfn`. E0818 fires on node
  shape, not text content. Ahead of the backstop, two familiar-but-unsupported
  shapes are classified to dedicated, actionable diagnostics (SFN-442):
  a value-position `if` (`let n = if c { a } else { b };`) → **E0834** with a
  `?:` conditional-expression rewrite, and a character literal
  (`text[i] == '|'`) → **E0835** stating the byte value and integer-comparison
  rewrite. Classifiers `check_value_if_raw` / `check_char_literal_raw` run before
  `check_unanalyzable_raw`; regression coverage in
  `compiler/tests/unit/parser_value_if_char_literal_diag_test.sfn` and
  `compiler/tests/e2e/value_if_char_literal_diag_test.sfn`. E0819 (nested `Unknown` fail-closed) shipped separately
  in #1755; E0817 was reassigned to enum-field conflicts (#1746).
  The `is` type-guard hole is **closed in #1753**: `<operand> is T` now parses
  to a structured `Is` AST node (not `Expression.Raw`), and the effect checker
  walks the operand — so `readFile() is T` correctly requires `![io]`. Effect
  polymorphism (`!E` variables, polymorphic HOFs) remains post-1.0.
- **Sub-effect detection + manifest tightening** (SFEP-0017 §6, gate G7,
  SFN-98/SFN-99): the target-neutral intrinsic registry attributes narrow sub-effects for
  four families — `fs.*` → `io.fs`, `print.*`/`console.*` → `io.console`,
  `http.*` → `net.http`, `websocket.*` → `net.ws` — as refinements within the
  locked six roots (`io.fs ⊑ io`). A bare-root grant subsumes every narrow
  requirement, so existing `![io]`/`![net]` annotations are unaffected; a
  narrow grant (`![io.fs]`) is independently sufficient, and
  `[capabilities] required = ["io.fs"]` tightens a capsule's authorized
  surface (`E0403` on a sibling `![io.console]`).
- **`websocket.*` runtime bridge** (epic #1180 Phase G): the `websocket.connect`/
  `.send`/`.close`/`.serve` registry rows in `runtime_helpers.sfn` now point at
  real `sfn_websocket_*` symbols in `runtime/sfn/adapters/websocket.sfn` — the
  `sfn_websocket_unbridged` metadata-only sentinel is gone for this family, so
  the calls lower, link, and self-host like any other member-call bridge (e.g.
  `http.*`). Client (#1876): `ws://` connect + a single masked TEXT send
  + close. Server (#1877): `websocket.serve(port)` binds/listens/accepts,
  dispatching each connection to a shared worker pool (#1923) that runs an
  RFC 6455 echo loop with unmasked server frames, ping/pong keepalive,
  bounded fragmented-message reassembly, and a status-code close handshake
  (#1924); an unmasked or over-large (> 1 MiB) client frame is refused with
  the matching close code (`1002`/`1009`). No `wss://`. `![net]` is enforced
  via the registry rows (single source of truth since #1601); `websocket.send`
  additionally requires `![io]` — any `.send(...)` member call trips the
  checker's pre-existing conservative, receiver-agnostic channel-op rule
  (shared with `channel.send`) on top of the registry's `net` row. Durable
  convention: a registry-driven member-call bridge marshals scalar arguments
  only — `websocket.serve(8080)` is the canonical call shape; an object literal
  (`websocket.serve({ port })`) is unreachable without bespoke lowering.
  Follow-ups tracked under epic #1180: `wss://`/TLS (#1925), a per-client
  handler API — `server.clients()`/`onMessage`/per-client send (#1926), typed
  message channels/backpressure (#1927), and client-side receive.
- **Undefined free-function rejection** (`E0420`, #616/#812, SFN-544):
  unresolvable bare-identifier callees fail typecheck at their use-site span;
  when the staged workspace exports the name, the diagnostic also identifies
  the module to import. These user errors stop before backend linking and are
  not presented as ICEs.
- **Named functions as typed values** (SFN-667 / SFEP-0030 item 1): a concrete,
  synchronous module-local top-level function may fill an exact expected `fn(A) -> R
  ![effects]` slot in a typed local/assignment, call argument, return, array
  element, or struct initializer. It materializes the same `{fn_ptr, env}` pair
  as a closure through one deduplicated internal tail-call adapter with a null
  env; ordinary `worker(x)` calls stay direct. LLVM's stricter `musttail`
  contract cannot apply because the adapter has one extra hidden-env parameter;
  the `tail` hint plus the `-O2` code-quality gate keeps the adapter frame-free.
  Source effects must be subsumed
  by the expected row and calls through a stored value impose that row. Generic,
  nested, async, entry-point, signature-mismatched, or otherwise unsupported
  values remain rejected (`E0808`/`E0839`); non-pointer-width aggregate
  signatures fail closed with `E0840`. General fn-typed struct-field storage and
  member dispatch remain SFEP-0030 item 3 (SFN-674). Imported/prelude names also
  fail closed in a typed fn-value slot until the import table carries the full
  parameter/generic/async/ABI proof required for safe materialization. Raw C-ABI address-taking
  remains separate: `<fn> as * u8` / typed `* fn` use the original symbol
  (#1146/#1147), and `* fn (A) -> R` calls retain their env-less indirect path
  (#1089).
- **Bare function-type annotation rejection** (`E0826`, #1845): the sole
  canonical function-type spelling is `fn(...) -> R` (spec §5, SFEP-0030). A
  bare `(int) -> int` — which the parser accepts but lowering silently
  miscompiled to an opaque `i8*` instead of the `{i8*, i8*}` closure pair —
  now fails typecheck with `E0826` and a fix-it steering to `fn(int) -> int`,
  enforced at every position that accepts a type annotation: fn/method/interface
  signatures, variable declarations (scope- and lambda-body-local), struct
  fields, lambda parameter/return annotations, enum variant fields, and type
  aliases.
- **Nominal object model — object literals and intersections** (`E0828`/`E0829`,
  SFEP-0039, #1860): data is constructed only through a concrete `struct`. A
  bare object literal `{ ... }` whose resolved target is an **interface**, an
  **array** type (a bare literal never yields an array, so this fires
  regardless of the element type — even `Named[]` where `Named` is a struct), a
  **generic instantiation** whose head names a non-struct (classified by base
  name, e.g. `Iface<...>`), or an **unannotated `let`** the compiler cannot
  infer a struct for, fails typecheck with `E0828`; `let p: Person = { name: "Alice" }`
  against a `struct Person` is the sanctioned path (#1855) and is unaffected.
  Coverage is now complete across value positions — `let` (#1899), parameter
  defaults and array/generic-head target normalization (#1900), return
  position (#1904), and lambda-body `let` / lambda return (#1905) — via a
  unified `TypeckCtx` expected-type/typing-environment context threaded
  through both typecheck walk families (SFEP-0041). The named-`struct`
  construction path (the `Struct` AST variant) stays exempt. Separately, `A &
  B` used as a **data/value type** (variable, parameter, field, or return
  annotation, or the RHS of a `type X = A & B` alias) fails typecheck with
  `E0829` — `A & B` stays in the grammar but is reserved for generic
  trait-bound composition (`<T: A + B>`, SFEP-0038) and is not diagnosed in
  bound position. The sibling
  rule that interface members must be method signatures (`E0827`, SFEP-0039,
  #1888) is now enforced: the parser detects a data-field-shaped interface
  member (an identifier followed by `:` or `->` where a method signature was
  expected) and typecheck emits `E0827` with a fix-it steering the field to a
  concrete `struct` that implements the interface, instead of silently
  dropping the member. Interface *signature conformance* (checking that an
  implementing struct's method signatures match the interface) remains a
  separate, still-draft effort (`draft-interface-signature-conformance`).
- **LLVM lowering fails closed on fabricated fallback values** (`E1002`,
  SFN-527, SFN-565):
  the eight lowering consumers that previously fell back to a fabricated
  `default_return_literal` when a sub-lowering failed — bare `return;` in a
  value-returning function, a `return`/assignment/`let`-initializer whose
  operand didn't lower or couldn't coerce to its target type, and a struct
  literal omitting a declared field (the SFN-392 zero-fill gap) — now emit a
  tagged `llvm lowering [fatal] [E1002]` diagnostic (naming the enclosing
  function, or a source span for the struct-literal site) and fail the build
  non-zero, instead of silently emitting `ret 0`/`store 0`/
  `insertvalue <default>` at exit 0. The placeholder value is still emitted so
  the rest of the pass sees structurally valid IR. Lowering-stage gate only —
  `sfn check` still passes on these programs; closing the typecheck half for
  unresolvable field accesses is separate (SFN-543). SFN-565 closes the
  remaining function-body fallback: `emit_llvm_function` walks the emitted
  LLVM basic-block graph and tags a value-returning body's implicit
  `ret <default>` only when the final block is reachable from `block.entry`.
  A genuine fall-off-the-end now fails closed and names the function, while
  the structurally required terminator in a disconnected block (for example,
  an infinite `loop` exit with no `break`) remains untagged. Enum matches use
  pointer-tolerant LLVM-type lookup and recover opaque generic boxes from the
  subject's source annotation, so exhaustive monomorphic or `Result<T, E>`
  matches whose arms all return are likewise recognized as terminating rather
  than mistaken for a reachable merge, including all-unit enums whose variants
  carry no payload fields. The
  lowering-generated constant-true wrapper for `unsafe { ... }` is also
  recognized, so its synthetic false merge does not create a spurious
  fallthrough. Design notes:
  `docs/proposals/design-notes/sfn-526-lowering-fatal-gate-audit.md` and
  `docs/proposals/design-notes/sfn-565-fallthrough-reachability.md`. The gate
  unmasked a live shipped miscompile in
  `runtime/sfn/adapters/websocket.sfn::_ws_handle_fd` — a cast over a
  parenthesized `<<` expression didn't lower, so fd reassembly returned `0`
  and every websocket send/close operated on fd 0 (stdin). SFN-560 fixed the
  cast-separator scanner by limiting generic angle-depth tracking to top-level
  type syntax, restored `_ws_handle_fd`'s inline cast, and pins both emitted IR
  and the computed result beside the neighbouring `>>`/`&`/`*` spellings.
- **LLVM instruction lowering fails closed instead of dropping instructions**
  (`E1003`, SFN-528): `break` and `continue` outside a loop, plus any
  instruction tag not handled by `lower_instruction_range`, now emit a tagged
  `llvm lowering [fatal] [E1003]` diagnostic and fail the build non-zero.
  Unsupported-tag diagnostics include both the numeric tag and enclosing
  function name. These conditions previously emitted only an untagged
  diagnostic, so the instruction and any side effect it carried vanished from
  the LLVM function while the build exited 0. Design note:
  `docs/proposals/design-notes/sfn-526-lowering-fatal-gate-audit.md`.
- **Range-`for` lowering fails closed on invalid ranges** (`E1004`, SFN-533):
  a literal zero stride now emits a tagged diagnostic naming the enclosing
  function and stops lowering the loop, instead of emitting a guard whose two
  stride-direction arms were both false and silently compiling a loop that
  never executed. A malformed numeric range with a missing start or end now
  surfaces its range-parser diagnostic and fails the build, instead of falling
  through to array-iteration lowering. Non-zero literal strides, computed
  strides, and array iterables are unchanged. Design note:
  `docs/proposals/design-notes/sfn-526-lowering-fatal-gate-audit.md`.
- **Native-IR layout parsing fails closed instead of truncating layouts**
  (`E1005`, SFN-532): malformed `.layout` field, enum-variant, and enum-payload
  lines now emit a tagged `llvm lowering [fatal] [E1005]` diagnostic that names
  the enclosing struct or enum and includes the offending line. The parser
  previously forwarded only untagged leaf diagnostics, dropped the malformed
  entry, and allowed lowering to continue with wrong field offsets. Well-formed
  whitespace-bearing generic field and payload types remain valid: their
  `type=` value ends at the first keyed layout attribute. Well-formed
  `.sfn-asm` emission is byte-identical. Design note:
  `docs/proposals/design-notes/sfn-526-lowering-fatal-gate-audit.md`.

## Feature Matrix

| Feature | Status | Notes |
|---|---|---|
| `let` / `let mut` | Shipped | Annotations optional; limited inference |
| `thread_local let mut` | Shipped | Top-level only; ELF TLS; immutable form rejected (`E0807`) |
| Functions (`fn`) | Shipped | Generics, default params, decorators |
| `async fn` | Parsed | Structural only; `spawn`/`await` on spawned tasks works end-to-end (v0, #1084 closed, #1474/#1477/#1546); `await` on `async fn` return values is not wired into the live typecheck walk (the channel-`receive` half shipped in #1944; the `async fn` half stays pending the live inferencer, #829). Use `spawn fn() -> T { ... }` + `await` instead |
| Structs | Shipped | Generic params, `implements` clause. Sole sanctioned bare-object-literal target (`E0828`, SFEP-0039/SFEP-0041, #1860/#1899/#1900/#1904/#1905) — a literal targeting an interface, an un-inferable unannotated `let`, any array type (regardless of element type), or a non-struct generic-instantiation head is rejected at every value position: `let`, parameter defaults, return, and lambda-body/return |
| Interfaces | Shipped | Trait-style method signatures, enforced method-only: a data-field-shaped member is rejected at typecheck with `E0827` (SFEP-0039, #1888), fix-it points at a concrete `struct`. Interface *signature conformance* checking is separate and still draft |
| Enums / ADTs | Shipped | Payload variants; generic payloads monomorphise per instantiation (#830). >8-byte by-value payload layouts not yet emitted |
| Type aliases | Shipped | Including generic params. `A & B` is reserved for generic trait bounds, not a data type — `type X = A & B` is rejected at the definition (`E0829`, SFEP-0039, #1860) |
| Module exports | **Shipped** | Block form `export { name };` / `export { x } from "./m";` and inline `export <declaration>` (`export fn`/`export struct`/`export enum`/`export interface`/`export type`/`export let`/`export extern …`/`export thread_local let mut`). Inline form added in SFEP-0031 (#1681); equivalent to `<decl> export { name };` |
| `if`/`else`, `for` | Shipped | |
| `loop` / `while` / `break` / `continue` | Shipped | `while condition { body }` desugars to `loop { if !condition { break; } body }`; `break`, `continue`, nesting, and ordinary block scope reuse the canonical loop path |
| `match` | Shipped | Literals, `_`, guards, enum-variant destructuring |
| `x is T` type-guard operator | **Shipped** (enum operands; #1753) | Parses to a structured `Is` AST node; effect checker walks the operand (closes the `Raw`-degradation effect-blind hole in epic #1180). Lowers to the enum's discriminant tag test and narrows the operand to the matched variant in the then-branch — same flow-sensitive narrowing as `match`. v1 scope: **named `enum` operands only**; non-enum unions, primitives, and plain structs are deferred. Else-branch complement narrowing is also deferred. See `examples/advanced/type-guards.sfn` |
| `try`/`catch`/`finally` | Shipped | Maps to runtime exceptions |
| String interpolation (`${ }`) | Shipped | Primitive values and `int \| null` union payloads stringify in direct, narrowed, and match-bound positions (SFN-343); primitive-element arrays (`int[]`/`float[]`/`number[]`/`boolean[]`/`string[]`) and nested arrays render bracketed (`[1, 2, 3]`, `[1.5, 2.5]`, `[[19, 22], [43, 50]]`) (SFN-408, SFN-410). Floats narrower than `double` (`f32`/`f16`/`bf16`) widen and format identically to the concatenation path (SFN-610) — `bf16` through the SFN-609 bit-manipulation widen, since `fpext bfloat` has no AArch64 selection pattern. Any interpolation operand with no stringify arm — e.g. a struct — fails the build loudly (`E0832 [fatal]`), never the old silent empty output. `${ }` is the sole interpolation form (SFEP-0057, SFN-482/SFN-483); `{{ }}` has been removed and now passes through as ordinary literal text with no diagnostic. `\${` produces a literal `${` without interpolation, while `\\${name}` produces a literal backslash followed by the interpolated value (SFN-576). |
| `string + <numeric \| bool>` concatenation | **Shipped** (SFN-548, SFN-552, SFN-554) | `string + n` (either operand order) is sugar for `string + (n as string)`, reusing the `as string` cast's display path — `f16`/`bf16` widen to `double` inside that chain — and, since SFN-610, in `${ }` interpolation too — while booleans render `"true"`/`"false"` consistently through concatenation, `as string`, and interpolation. Keyed off the `{i8*, i64}` string aggregate specifically, so raw-pointer arithmetic (`*u8 + int`) is unaffected and still lowers as pointer offsetting. No expression-type inferencer exists (#829), so `sfn check` does not flag a mismatched concat operand — this is a lowering-time sugar, not a typecheck-level guarantee. Pinned by `compiler/tests/unit/string_concat_numeric_test.sfn` |
| Pattern-match exhaustiveness | Partial | Runtime backstop (`match_exhaustive_failed`) |
| Effect annotations (`![...]`) | Shipped | |
| Effect enforcement — `io`, `net`, `clock` | **Enforced** | Build fails on undeclared use (Phase D default `error`) |
| Effect enforcement — `model` | Reserved | Declarable; detector lands with the `sfn/ai` capsule (post-1.0) |
| Effect enforcement — sub-effects (`io.fs`, `io.console`, `net.http`, `net.ws`) | **Enforced** | Detection attributes narrow sub-effects; bare-root grants subsume (backward compatible); narrow grants + manifest tightening (`required = ["io.fs"]`, `E0403`); SFEP-0017 §6/G7, SFN-99 |
| Effect enforcement — `gpu` | **Enforced** (device-dispatch boundary) | `sfn/device::matmul_f64` / `::synchronize` (SFN-428, SFEP-0052 §3.2) establish the `![gpu]` boundary end-to-end: they carry `![gpu]` on their declarations, it propagates to callers via the existing callee-effect propagation, and a caller without `![gpu]` fails effect-check with a spanned diagnostic + fix-it. **`![gpu]` is the capability to dispatch work to a device backend — not a claim that an accelerator exists.** The only registered backend in any current build is the CPU reference kernel (`sfn/device::has_accelerator()` returns `false`; there is no NVPTX/AMDGPU/SPIR-V backend in tree). The gate ships ahead of a real backend so programs written against this surface need no annotation migration when one lands. Scope: only the `sfn/device` dispatch entry points carry the effect — there is no auto call-name detector, and a raw `extern` to a vendor API bypasses the gate (externs carry no effect, `E0804`), the same limitation `rand` has |
| Effect enforcement — `rand` | **Enforced** (entropy boundary) | `sfn/crypto::random_bytes` (SFEP-0048 Phase D) establishes the `![rand]` boundary end-to-end: it propagates to callers via the existing callee-effect propagation and a caller without `![rand]` fails effect-check. Scope: only `random_bytes` carries the effect — there is still no auto call-name detector for arbitrary RNG identifiers |
| Cross-module effect propagation | **Shipped** | `E0402` (Phases E/E2); free functions, aliases, statically resolved members, and imported decorator effects |
| Capsule capability cross-check | **Shipped** | `E0403` (Phase F) |
| Hierarchical sub-effects (`io.fs`, `net.http`) | **Shipped (G6)** | Dotted sub-effect names parse as single effect strings and satisfy by subsumption — a broad grant subsumes a narrow requirement (`io.fs ⊑ io`), so every existing `![io]` stays valid and a manifest may *tighten* with `required = ["io.fs"]` (SFEP-0017 D1/D2/D4). Unrecognized effect roots are rejected (`E0404`). `canonical_effects()` is unchanged — the six roots stay locked; sub-effects refine *within* them. G7 detection narrows registered operations to the four shipped families; other registered operations conservatively retain their bare root. `effect_taxonomy.sfn`: `effect_root` / `is_recognized_effect` / `effect_subsumes` |
| `websocket.*` (`connect`/`send`/`close`; `serve(port)`) | **Shipped (v0)** | RFC 6455 `ws://` bridged end-to-end to real `sfn_websocket_*` runtime symbols (`runtime/sfn/adapters/websocket.sfn`), replacing the `sfn_websocket_unbridged` metadata-only sentinel — client (#1876), single-connection blocking echo server (#1877), epic #1180 Phase G. `![net]` enforced via the registry rows (#1601). v0 scope: `ws://` only (no `wss://`), no fragmentation/ping-pong, unmasked server frames, one connection at a time. Follow-ups: #1923 (pool dispatch), #1924 (ping/pong + fragmentation + close codes), #1925 (`wss://`/TLS), #1926 (per-client handler API), #1927 (typed channels/backpressure) |
| `int` / `float` numeric types | **Shipped** | Slices A–E complete (#296 closed): i64/f64 annotations, bitwise/shift ops, the `as` cast lowering matrix, integer-literal default, full source migration, strict int↔float refusal with `as` fix-it, bool-kind tightening (#537). `number` is an alias for `float` |
| Sized-integer (`u8`/`u16`/`u32`/`u64`/`usize`) `as`-cast sign correctness | **Shipped** (identifier/parameter operands; SFN-503, SFN-570) | Widening `as` casts from an unsigned source emit `zext` (was always `sext`); int→float from an unsigned source emits `uitofp`. Float→integer casts use LLVM's saturating intrinsics for both signed and unsigned targets: they truncate toward zero in range, clamp at the target bounds, and convert NaN to zero, so no bare `fptoui`/`fptosi` poison is reachable through `as` (SFN-570). Integer-source sign is recovered from the operand's source-level annotation via its local/parameter binding, so a compound integer operand (`s.field as u64`, `xs[i] as u64`, `f() as u64`) still has no annotation to recover and still selects the signed forms — scoped to the typecheck slice of SFEP-0058 §3.3 (SFN-501) |
| Sized-integer call-boundary sign correctness | **Shipped** (SFN-575) | Narrow unsigned call arguments and results zero-extend when the destination widens them; narrow signed values continue to sign-extend. Argument coercion recovers a local/parameter operand's source annotation, while result coercion carries the resolved callee return annotation into the caller's expected-type conversion. This covers `u8`/`u16`/`u32` returns consumed as wider numeric/string values and bound `u16`/`i8` arguments passed to `int` parameters without changing the narrow value's LLVM representation or arithmetic width. Pinned by `compiler/tests/e2e/narrow_int_params_test.sfn` |
| Sized-integer binary-operator sign correctness (`>>`, `/`, `%`, ordered comparisons) | **Shipped** (identifier/parameter operands; SFN-573) | Companion to the `as`-cast fix above: `>>`/`/`/`%` and `<`/`<=`/`>`/`>=` now select `lshr`/`udiv`/`urem`/`icmp u{lt,le,gt,ge}` when the operand's declared binding is unsigned, instead of unconditionally emitting the signed form (`4000000000u32 < 100u32` previously evaluated `true`). `==`/`!=`/`<<`/`&`/`\|`/`^` are sign-independent and unchanged. Sign recovery mirrors SFN-503's identifier/parameter-only scope via `integer_type_is_signed` — a compound operand (`(a + b) >> 4`, `xs[i] / 2`, `f() % 3`) still selects the signed form, and a mixed-width or mixed-signed pair keeps the signed form because the harmoniser sign-extends one operand first; both close with SFN-501's implicit-conversion work. Widths covered: i8/u8, i32/u32, i64/u64 — i16/u16 ordered comparisons still hit the pre-existing "unsupported comparison operator" diagnostic, unrelated to this fix |
| `f16` / `bf16` low-precision floats | **Shipped (SFEP-0054 Phase 1)** | `f16`/`bf16` are real scalar annotations lowering to LLVM `half`/`bfloat` (SFN-426). No lexer/parser change (generic type-annotation identifiers); typecheck accepts them as the coarse `"float"` kind; `f16` conversions to/from `f32`/`f64` lower as `fpext` (widen) / `fptrunc` (narrow); **every `bf16` conversion instead lowers as an explicit bit sequence on all targets** — LLVM 18's AArch64 backend can select no `bfloat` conversion at all (SFN-609), so widening is an exact mantissa zero-extend and narrowing is a round-to-nearest-even, with the `f64` and `i64`/`u64` sources pre-rounded to odd so the result is correctly rounded in a single step per SFEP-0054 §3.4 (design note: `docs/proposals/design-notes/sfn-609-bf16-conversion-lowering.md`); a decimal literal bound to an `f16`/`bf16` expected type (`let x: bf16 = 0.001;`) now rounds once, directly from the exact decimal value to the destination bit pattern — the literal text converts to the target significand in exact numerator/denominator rational arithmetic with no floating-point intermediate (`compiler/capsules/codegen-llvm/src/expression_lowering/native/core_decimal_float.sfn`) and emits an LLVM hex-float constant (`half 0xH…` / `bfloat 0xR…`) instead of a `double` constant narrowed a second time by `fptrunc`; overflow yields a signed infinity and underflow a correctly rounded subnormal or signed zero, not a diagnostic (SFN-611; exhaustive oracle diff over every representable value and midpoint of both formats plus near-midpoint perturbations — 130,973 `f16` and 134,557 `bf16` literals, zero mismatches, 31,743/32,639 of which differ from the prior double-rounded result, cross-checked against LLVM's own APFloat fold). **This closes SFEP-0054 §3.3 for the expected-type binding form only** — §3.3 names the cast form (`0.125 as bf16`) in the same paragraph, and a cast still lowers its operand with a neutral expected type (`core_cast_lowering.sfn`), so a literal cast is still rounded to `double` first and then narrowed; the same decimal therefore yields different bits depending on spelling (SFN-669). Extern ABI accept-list; arrays/params/returns carry the exact `half`/`bfloat` carrier. Scope is Phase 1 only — fp8/tf32, distinct-kind exact-identity enforcement (`E0910`–`E0915`), direct `half`↔`bfloat` casts, and single-rounding for the `as`-cast literal form remain follow-on SFEP-0054 work. Tests: `numeric_low_precision_test.sfn` (unit), `decimal_low_precision_literal_test.sfn` (unit), `numeric_cast_test.sfn` (e2e) |
| Bitwise operators (`&`, `\|`, `^`, `<<`, `>>`) | **Shipped** | Slice B; rejected on `double` operands |
| `Result<T, E>` + `?` operator | **Shipped** | Prelude `Result`/`Error` (#832), typed `?` (`E0810`–`E0812`, #833), pure control-flow desugar (#834), and pointer-erased `Result<T, E>` struct fields round-trip through member reads (SFN-568); spec §12. `From<E>` coercion and the `E: Error` bound gate on generic constraints |
| Closures with capture | **Shipped** | Capture inference (#458) → env synthesis (#459) → lifting + hidden-env dispatch (#689); multi-capture fix #1106; mutable captures lower by reference so assignment-position reads/writes of enclosing `let mut` bindings (including module globals) are observed by the enclosing scope (#1747/SFN-88) |
| Nested / local function declarations | **Shipped** (call-by-name) | Statement-position `fn name(...) -> T ![effects] { ... }` inside a function or lambda body (SFEP-0042, #1922, epic #1609). Non-capturing static items (Rust model): block-hoisted so siblings mutually recurse and a nested fn self-recurses; lifted to plain top-level functions (`sfn_nested_<name>_<N>`, no env/fat-pointer) and called by name via static dispatch. Referencing an enclosing local/parameter is rejected (`E0421`, fix-it → `let f = fn(...) => ...`); a same-named nested-fn parameter legally shadows. A declared-but-uncalled nested `fn foo() ![io]` imposes no effect on its parent; a *call* requires the effects transitively, and each nested body is effect-checked against its own row. Parser: `compiler/capsules/syntax/src/parser/statements/block.sfn`; scope/E0421: `compiler/capsules/analyzer/src/typecheck/function_scopes.sfn`; target-neutral lift: `compiler/capsules/codegen/src/lambda_lowering.sfn`; effects: `compiler/capsules/analyzer/src/effect_checker/mod.sfn`. SFN-667's first-class named-function path deliberately accepts top-level functions only; nested fn values remain Sub-issue B (#1935). Tests: `nested_function_declaration_test.sfn` (unit + e2e), `nested_function_effect_test.sfn` |
| Lambda short form `fn(x) => expr` | **Shipped** | Additive expression-bodied lambda (SFEP-0029, #1683): `fn(x) => x * x` desugars to a single-`return` block, equivalent to `fn(x) { return x * x; }`. The block form is untouched; the typed-head form `fn(x: int) -> int => expr` is also valid. `fn` lead-in keeps dispatch zero-lookahead, so the body `=>` never collides with the match-arm `=>`. `compiler/capsules/syntax/src/parser/expressions/lambdas.sfn` (`parse_lambda_expression`); the fragile return-type capture was rerouted through the real type parser, retiring the #1546 class. Tests: `parser_lambda_body_test.sfn`, `parser_lambda_arrow_vs_match_test.sfn` |
| Untyped lambda callbacks | **Shipped** (covered cases) | An untyped lambda passed to a callback now infers its parameter/return types from the callee's expected `fn(...) -> R` before lifting (#1683, SFEP-0032), so `[1,2,3].map(fn(x) => x * x)` (no annotations) lowers and runs — previously a segfault. Covered: untyped lambda arguments to user/method higher-order functions (param declared `fn(int) -> int`) and the builtin `int[]` `.map`/`.filter`/`.reduce`. Syntax-independent: the untyped block form `fn(x) { ... }` is fixed identically. Non-`int` element arrays stay gated on generics (SFEP-0028 / #766); typed lambdas are a no-op (zero regression surface). Target-neutral preparation lives in `compiler/capsules/codegen/src/lambda_param_inference.sfn`; the shared function-type interchange parser lives in `compiler/capsules/ir/src/native_ir_utils_text.sfn`. E2e: `compiler/tests/e2e/untyped_lambda_callback_test.sfn` |
| `array.map` / `.filter` / `.reduce` (closure) | **Shipped** (pointer-width int elements) | `arr.map(fn (x: int) -> int { ... })`, `arr.filter(fn (x: int) -> bool { ... })`, `arr.reduce(init, fn (acc: int, x: int) -> int { ... })` dispatch via `runtime_array_map_fn` / `_filter_fn` / `_reduce_fn` → `sfn_array_sfn_{map,filter,reduce}` (`runtime/sfn/array.sfn`) over the runtime-callable closure-apply seam (#1507 seam + `map`, #1508 `filter`/`reduce`); by-value `{i8*, i8*}` closure pair; capturing closures work. The callback may be fully typed or an untyped lambda (`.map(fn(x) => x * x)`) — untyped param/return types are inferred from the mapper signature (#1683). Scope: pointer-width (`i64`) element/accumulator arrays plus the first pointer-width array-element mapper lane: `int[]` mapper results on `int[][]` receivers produce `int[][]` (#1943 / SFN-112). Other generic element widths (`float[]`, `string[]`, struct arrays) are still designed in SFEP-0028 and remain rejected with diagnostics until their width-specific lowering lands. Epic #1118 (closed); #766 closed as completed. E2e: `compiler/tests/e2e/array_{map,filter,reduce}_closure_test.sfn` |
| Range `.map` / `.filter` / `.reduce` (eager sugar) | **Shipped** (SFN-114) | `(start..end).map(f)` / `.reduce(init, f)` / `.filter(f)`. A `Range` has no method surface (it is otherwise consumed only by `for`-loop lowering), so the emitter materializes `[start, …, end-1]` into an `int[]` `SfnArray` via `sfn_range_materialize(start, end)` (`runtime/sfn/array.sfn`, descriptor `runtime_range_materialize_fn`) and dispatches the shipped array-HOF seam above; the range element is always pointer-width `int`, so no new width machinery is needed. Untyped callback params (e.g. `fn(acc, k) -> int`) infer as `int` from the range receiver (`receiver_element_type` Range arm, `lambda_param_inference.sfn`). Eager sugar over array HOFs; the lazy `Iterator` protocol is the post-1.0 successor (SFEP-0028 (D)). E2e: `compiler/tests/e2e/range_map_test.sfn`. Deeply-nested lambdas over ranges/arrays with **transitive** `int` captures (e.g. `matrix-multiplication.sfn`) are separately blocked on nested-capture env typing — SFN-396. |
| Generic type inference | Partial | Type params captured; coverage limited |
| Generic type constraints | Partial | `fn sort<T: Comparable>`, real `Array<T>` / `HashMap<K, V>` / `Channel<T>`. Declaration-time bound validation shipped (#1868): a bound must name a real interface (E0821) of correct arity (E0822). Instantiation-site satisfaction shipped (#1870): a concrete type argument must satisfy every declared bound (E0820), with bound propagation for in-scope type parameters, enforced live at `implements I<Args>` sites; a generic-struct static constructor under a `let` annotation (e.g. `let x: List<int> = List.new()`) resolves via return-type-site instantiation (#1941, SFN-110): the monomorphizer rewrites the call to its `List$int` specialization from the binding's expected type. End-to-end construction can now use explicit type-argument struct literals (e.g. `List<int> { items: [] }`, SFN-342), and `int \| null` interpolation no longer drops optional results (SFN-343). **SFN-110 now ships end-to-end**: the specialized constructor body itself lowers correctly too — a second `_mono_rewrite_expr` sweep over specialized struct methods mangles the return literal's type arguments (`List<int> { items: [] }` → `List$int { items: [] }`), fixing a prior collapse to `ret i8* null` that trapped every caller — so `examples/advanced/generic-structures.sfn` builds, runs, and prints its first element (removed from `scripts/check-examples.sh`'s `KNOWN_FAILING`). Remaining gap: an unannotated/uninstantiable call site (e.g. bare `let n = List.new()` with no expected-type context) still passes `sfn check` but hits a raw lowering fatal at build; a clean frontend diagnostic for that case is tracked as SFN-404 (not yet fixed). General function-call instantiation-site inference remains open. Monomorphization shipped (SFEP-0038 §3.3): a native-IR pass (`compiler/capsules/codegen-llvm/src/monomorphize.sfn`) specializes each distinct concrete instantiation — generic functions (#1869) and generic structs with inline field layout (#1871: `Box<T>` constructed as `Box{value: 42}` lowers to a concrete `%Box$int = type { i64 }`, fixing the prior silent-empty/unsized-`%T` miscompile). Bound interface-method call resolution shipped (#1872): a `T: Comparable` call `a.compare(b)` resolves in the `T = Widget` specialization to a direct static `Widget.compare`, not a vtable dispatch. All five sub-tracks (SFEP-0038, epic #1867) are `Implemented`; see `reference/preview/generics.md`. v1 scope: pointer-width `T` only (int/float/bool/string/ptr and boxed/pointer struct references) — an arbitrary by-value aggregate `T` (a struct/enum whose size ≠ 8) is **not** yet laid out inline correctly, because the generic layout manifest defaults an unresolved field type to pointer size/align 8; that arbitrary-width by-value case and generic collections (Map/Set) remain |
| `StrMap` (string-keyed map) | **Shipped** (#1710) | Concrete non-generic string→string map in `runtime/sfn/collections.sfn`; import with `import { str_map_new, str_map_set, str_map_get, str_map_has, str_map_delete, str_map_keys, str_map_len } from "runtime/sfn/collections"`. Open-addressed hash table (FNV-1a, linear probing, tombstone deletion, load-factor resize); amortized O(1); validated with a 10k-insert smoke test. **Not in the prelude** (prelude struct-returning calls cannot resolve signatures from separately-compiled consumers in the current seed; a module import merges the source). `StrMap` is the concrete-now bridge until generic `HashMap<K, V>` lands with the generic-constraints epic — it becomes a deprecated alias when generics ship |
| Raw pointer types (`*T`) enforced | Planned | Pointer-typed struct fields lower correctly (#713, seed-blocker); full typecheck enforcement pending |
| Deterministic drop emission | In flight | M1.5 epic #322 (`LocalBinding.allocation_kind` + `emit_scope_drops`); v0 escape rule is function-return promotion only |
| Atomic intrinsics (M0) | **Shipped** | All six builtins lower to LLVM atomics, `seq_cst` at v0 (#323, #331–#335); arity/type validation `E0806` |
| Linux x86-64 raw syscall primitive | **Shipped (compiler seam; SFN-510)** | The reserved `syscall1`…`syscall6` family lowers to one register-pinned, side-effecting LLVM inline-asm `syscall`, with `rcx`, `r11`, and memory clobbers. `E1019` rejects wrong arity/type, non-Linux/non-x86-64 targets, and every caller except `runtime/sfn/platform/syscall_linux.sfn`; runtime consumers remain gated on the next seed cut. |
| Interface conformance validation | Partial | Basic checks; variance not enforced |
| `Affine<T>` / `Linear<T>` | Single-use enforced | Move / use-after-move enforced on owned/affine-typed bindings (#1214, E5 of #1209): a moved binding that is read, passed, or returned again raises `E0901`; a second `let`-binding of a moved value raises `E0904`. `Affine<T>` is at-most-once (the move rules are its whole story). `Linear<T>` is exactly-once: a linear value never consumed (moved/returned/passed/freed) before it leaves scope raises `E0907` (#1216, E7 of #1209). Shared borrows are Phase U |
| `OwnedBuf` / `Slice` owned-buffer family | Ownership-enforced (buffers); memory/string core migrated (Phase R1) | Library types in `runtime/sfn/memory/ownedbuf.sfn` (#1212, E3 of #1209): parse/typecheck/lower via the existing struct + i64 paths. `OwnedBuf` bindings are move-tracked (#1214, `E0901`/`E0904`); in-place mutation of a stale buffer raises `E0902`, use-after-free raises `E0903`, and a raw-pointer escape into an `extern fn` outside `unsafe` raises `E0906` (#1215, E6 of #1209). **Phase R1 (#1217, E8 of #1209):** the memory/string hot path is migrated onto `OwnedBuf` with the raw-pointer interior behind `unsafe` — `arena.sfn`'s grow-at-tip realloc and `ownedbuf.sfn`'s alloc/grow externs are wrapped `unsafe`, and `string.sfn`'s `sfn_str_sfn_append` / `_concat` return an owned `OwnedBuf` (consume-and-return move). The in-place grow-at-tip is reachable from safe code only through a unique `OwnedBuf`, so the #1205 aliasing hazard is closed structurally (gated by `compiler/tests/e2e/test_owned_buf_grow_determinism.sh`). `string.sfn` inlines the `OwnedBuf` struct + a same-module `_str_buf_*` move helper because the runtime-sfn-source emit path can't resolve a cross-module struct-returning call (#1283 — *not* the closed, unrelated #306). `sfn_str_sfn_slice` is **not** migrated: a non-owning `Slice` over an immediate-codepoint pseudo-pointer is unsound until that encoding is retired (#822 / the M1.A.2 aggregate flip — see #1283), so it keeps its allocating `* u8` body. **Phase R1 (#1218, E9 of #1209):** the rest of the memory core — `rc.sfn` (alloc header-init + release-to-zero `free`), `mem.sfn` (`copy_bytes`/`get_field`/`bounds_check`/`free`/`alloc_struct`), and `array.sfn` (in-place push/grow + concat over the `_v2` element-storage trampolines) — now carries the same explicit `unsafe { }` raw-region boundary. These primitives use raw `* u8` (not owned bindings), so they pass enforcement (no `E0902`/`E0903`/`E0906`); `unsafe` marks the author-asserted raw interiors and the rc release-to-zero `free` is bounded by the `prev == 1` last-reference proof. Gated by `test_runtime_memory_rc.sh` / `_mem.sh` / `test_runtime_array.sh`. `Slice` view-lifetime tracking is Phase U. Pinned by `compiler/tests/e2e/test_owned_buf_roundtrip.sh` |
| Ownership checker pass | Move + mutation/UAF/escape + linear-consume + spawn-capture-move enforced | Standalone `compiler/capsules/analyzer/src/ownership_checker.sfn` after effect-check (#1213 skeleton → #1214 move core → #1215 E6 → #1216 E7 → #1220 E11). Walks the effect-checker scope structure, tracks an `Owned`/`Moved`/`Freed` lattice per owned/affine binding, and gates the build on use-after-move (`E0901`), second-live-binding (`E0904`), in-place mutation of a possibly-aliased buffer (`E0902`), use-after-free (`E0903`), raw-pointer FFI escape (`E0906`), and an unconsumed `Linear<T>` value at scope exit (`E0907`). **E11 (#1220):** a `spawn`/`parallel`/`serve` worker outlives the spawning scope, so an owned value its closure captures is a move (sender binding → `Moved`); post-spawn use on the sender is use-after-move (`E0901`). The lift is gated at the spawn site, not the `Lambda` arm, so an ordinary lambda still captures as a read. This is the static complement to #1094's RC-promote drop-emission (drops reclaim memory; ownership proves no live aliased use remains). channel-send of a bare owned identifier already moves via the generic call-argument path. Copyable values are untracked and the un-migrated runtime passes raw `*u8`/`Cast` args (never a bare owned identifier), so the compiler self-hosts unaffected. `unsafe { }` / `unsafe fn` interiors are skipped (#1211) |
| `&T` / `&mut T` borrows | Parsed only | Exclusivity not checked |
| `PII<T>` / `Secret<T>` | Parsed only | No taint enforcement; deferred post-1.0 |
| `model`/`prompt`/`tool`/`pipeline` blocks | **Removed** | Moved to the post-1.0 `sfn/ai` capsule; the `![model]` effect stays |
| `routine { }` blocks | Works (v0 nursery) | Lowers to a real structured-concurrency nursery (#1181): `sfn_nursery_enter`/`sfn_nursery_exit` (`runtime/sfn/concurrency/nursery.sfn`) bracket the body, `sfn_spawn` registers each task against the per-thread current nursery, and exit blocks (join-all) until every child completes — no task spawned in the routine outlives its scope. Non-local exit (`return`/`throw`/`break`/`continue`) out of a routine is rejected fail-closed. v0: join-all (no cancel-on-fault), join-without-destroy, per-thread (no cross-thread inheritance). Parser/emit are #1079/#1081/#1084 |
| `await` | Parsed | Typing helpers exist (#1082, `E0814`); `await ch.receive()` result typing is now **wired into the live walk** (#1944) — an un-annotated receive target adopts the channel's element kind, and a `Channel<fn() -> void>` element dispatches `task()` through the closure seam (SFEP-0030 item 2). `await` on `spawn`/future values is still classified by kind (six future kinds), not live-inferred; lowering is #1084 |
| `channel()` | Works (v0, untyped) | Bounded MPMC channels run end-to-end: `channel(N)` → `sfn_channel_create(i64 cap, i64 elem_size, i64 owned)`, `send`/`receive`/`close` lower against `runtime/sfn/concurrency/channel.sfn` with the by-pointer element ABI (#1085/#1091, aligned #1266). A channel created inside `routine {}` is nursery-bound: assigning it directly or through a local alias to an outer scalar, aggregate field, indexed collection, or module global fails at check time with the shared handle-escape diagnostic **E0838** (SFN-694). Routine-local use remains legal, and an ambient/module-global channel created outside a nursery is unaffected. That check is what licenses reclamation: because an escaping handle is now a compile error, `sfn_channel_create` registers every nursery-scoped handle with the enclosing nursery (`sfn_nursery_register_channel`, `runtime/sfn/concurrency/nursery.sfn`) and `sfn_nursery_exit` destroys them strictly after its join-all barrier, closing the prior per-channel leak of the mutex, both condvars, and the ring buffer (~336 B/channel measured before, flat ~1.8 B/channel after) (SFN-688). A channel created **outside** any `routine` is deliberately not reclaimed and lives until process exit: it is constructed before any nursery exists, so no scope end proves that no thread still holds the handle. Method dispatch routes from local, parameter, **and module-global** channel bindings — a global `let g_ch = channel(N)` (or explicit `channel<K>`) carries the canonical `channel` / `channel:K` annotation into lowering (#1474), making a capture-free shared channel possible. Pointer-sized elements only; a bare `channel(N)` receive needs an `int`/`float`-annotated target to load the element at the right width. A typed `Channel<T>` binding annotation binds the element kind and enforces it on `ch.send(v)` (`E0815`, frontend; #1942); live await-result typing ships alongside, so a `Channel<fn() -> void>` element round-trips the pointer-width ring and dispatches after `await ch.receive()` (#1944, SFEP-0030 item 2). `send`/`receive` are **effect-transparent** (SFEP-0049): `channel_send`/`channel_receive` have no target-neutral semantic rows, so a pure `ch.send(v)`/`ch.receive()` requires nothing and any effect comes from the value flowing through — e.g. `ch.send(fs.read(p)?)` requires `![io]` from the argument (single source of truth, #1655) |
| `spawn` / `await` | Works (v0) | `spawn fn() -> T { ... }` lifts the non-capturing task lambda and routes through the typed `sfn_spawn_<kind>_ctx` family (`runtime/sfn/concurrency/future.sfn`), so the task runs on the runtime thread pool; `await` joins it and returns the typed result (#1474/#1477). The parser preserves the source return annotation without applying semantic rules; typecheck/analyzer resolves the future kind and retains `E0813`/`E0814` frontend failures (#1082, SFN-708). **Capture-env ownership (#1475, epic #1466):** a capturing spawn lambda's env is allocated via `sfn_env_alloc` (malloc-backed, not arena-routed) so it is individually freeable; the trampoline frees it exactly once after the worker body runs; the sender binding is statically `Moved` (E11/#1220, `E0901` on reuse). OwnedBuf/string capture-buffer ABI across the thread boundary is deferred (#1476). **Effectful task lambdas (#1546):** an effect annotation on the task lambda's return type (`spawn fn() -> int ![io] { ... }`) is no longer folded into the return-type text — the lambda parser now stops the return-type capture at the effect marker `!` (mirroring the fn-decl parser), so the future-kind classifier resolves the real kind (`int`) instead of the `ptr` catch-all and the typed result survives `await` **Effect (effect-transparent, SFEP-0049):** `spawn` contributes no effect of its own — `spawn_task` has no target-neutral semantic row (single source of truth, #1655) — so the caller inherits exactly the spawned body's effects: a pure body requires nothing, an `io` body (e.g. one calling `print`) still requires `![io]`. Join-side (`await`/nursery-exit) effect semantics stay out of scope (SFN-124). **Inferred-empty handle arrays (`E0831`, SFN-386):** accumulating task handles in an un-annotated `let mut hs = []` is rejected at check — the empty literal has no element type (its slot defaults to `double`, which corrupts the pushed future pointer). `Task<T>` (SFN-441 / SFEP-0055) now provides the writable handle type this diagnostic used to say didn't exist: annotate `let mut hs: Task<int>[] = []`, push spawned handles into it, and call `join_all(hs)` for input-ordered results. E0831 still fires unchanged for the un-annotated case — the guard is not weakened, just given an annotated escape path; a `[fatal]` lowering backstop fails closed on any future→scalar-slot shape the frontend rule does not enumerate |
| `parallel [...]` | Works (v0) | Fans every task lambda out onto the shared scheduler pool via the runtime `sfn_parallel(fn_ptrs, ctxs, count)` fan-out/join combinator (`runtime/sfn/concurrency/parallel.sfn`) and joins them all before returning (#1474). Each task's lifted closure pair `{i8*, i8*}` is unpacked to an `(fn_ptr, ctx)` pair; tasks execute concurrently. Result handle is the raw joined results array. A bounded-channel produce/consume proof runs concurrently end-to-end (#1474 AC2). **Capture-env ownership (#1475, epic #1466):** capturing parallel task lambdas route through the `_sfn_trampoline_ptr_ctx` path; the trampoline frees the `sfn_env_alloc`-allocated env exactly once after the worker body (null-safe; non-capturing tasks keep the bare path). OwnedBuf/string capture-buffer ABI is deferred (#1476). Typed result-array collection (`results[i]`) is delivered for the handle-array case by `join_all(Task<T>[]) -> T[]` (SFN-441 / SFEP-0055, see the `Task<T>` row below); `parallel`'s own raw joined-results handle is unchanged. **Effect (effect-transparent, SFEP-0049):** `parallel` is fan-out of spawns and contributes no effect of its own (`spawn_task` has no target-neutral semantic row; single source of truth, #1655), so the caller inherits the union of the task bodies' effects — pure tasks require nothing, an `io` task still requires `![io]` |
| `Task<T>` / `join_all` | Ownership-enforced (v0) | A user-writable typed task-handle type (SFN-441 / SFEP-0055): `spawn fn() -> T { ... }` has type `Task<T>`, so `let mut hs: Task<int>[] = []` is a legal, pointer-width-typed handle array. `join_all(handles: Task<T>[]) -> T[]` awaits a dynamic collection of handles and returns their results in **input order**, regardless of completion order — empty input returns `[]`, a singleton returns one element, multiple handles return an input-ordered array. Implemented as a phantom newtype over the existing future pointer (`llvm/type_mapping.sfn` resolves `Task<T>` to the same `%SailfinFuture<Kind>*`, zero runtime cost) and lowers to a new runtime combinator `sfn_join_all` (a join-only sibling of `sfn_parallel`, `runtime/sfn/concurrency/parallel.sfn`) that builds a real indexable `T[]` via `sfn_array_new_pointer_width` (`runtime/sfn/array.sfn`). Pointer-width result kinds only — **int, number, string, ptr**; `join_all` over `Task<void>[]`/`Task<bool>[]` (a `void[]` is meaningless, a `bool[]` needs a sub-word `i1` slot) and over a non-`Task` array are both **rejected fail-closed** (a `[fatal]` lowering backstop, so an ordinary `int[]` cannot silently `await` its integers as future pointers). A heterogeneous handle push (`Task<string>` into a `Task<int>[]`) fails at check with **E0836**. `Task<T>` and `Task<T>[]` are affine: direct `await`, closure capture, movement into task arrays or aggregate fields, conditional selection, member/indexed extraction (which consumes the aggregate owner or collection as a whole), and `join_all` consume their handles. A Task-capturing closure is itself affine and carries nursery provenance. Declared struct-field metadata, including generic field substitution, keeps empty-but-typed Task collections and Task-bearing parameters/`self`/method receivers affine without misclassifying sibling non-Task fields. Declared local/imported Task-returning calls, first-class lambdas and moved function values, and callable-typed parameters preserve identity without a redundant local annotation; callable shadowing and receiver-qualified method lookup—including inferred, generic, `self`, nested-member, and struct-literal receivers—avoid name-only false positives; and flow joins conservatively retain possible consumption across blocks, mutually exclusive expressions, loops (including repeated iterations and nursery provenance on `for` targets), and try/catch paths. A second consumption fails during checking with **E0837**. A live handle spawned inside a `routine {}` cannot reach an outer binding past nursery exit (**E0838**), including direct or conditional returns, Task-capturing closures, nested aggregate/indexed stores, and module globals. Nursery provenance follows explicit `spawn` and local helpers/callables whose every Task return is provably fresh; passing a nursery Task through an opaque helper or method is rejected fail-closed unless the resolved operation is the unshadowed builtin `join_all` or a Task-collection push, preventing spelling-only helper-mediated escape. A declared Task return type alone does not misclassify an ambient identity helper. Consuming a tracked destination directly or through `join_all`, or clearing it with `tasks = []`, before exit remains valid (SFN-446). |
| `\|>` pipeline operator | Not implemented | Planned post-1.0 |
| Currency / time literals | Not implemented | Use numeric literals |
| `unsafe` / `extern` | Boundary enforced (locally-declared externs) | `extern fn` declarations are fully shipped (see Runtime Migration); `unsafe { }` blocks and `unsafe fn` carry an `is_unsafe` AST marker (#1211). The ownership checker skips `unsafe` interiors and treats the boundary as load-bearing: a bare owned value escaping into an `extern fn` outside `unsafe` raises `E0906` (#1215). Scope at E6: only externs **declared in the same compilation unit** are recognized; implicitly-linked prelude/runtime externs (e.g. `memcpy`) are not yet matched — a deliberate, self-host-safe false negative widened in a follow-up. Raw-pointer ops *inside* `unsafe` stay author-asserted |
| Policy decorators (`@policy`) | Parsed only | No compiler or runtime effect |
| Capsule-defined decorators | Works (Tier-1 entry hook) | SFEP-0023 §4.4–4.5 (SFN-72): a decorator imported from a capsule lowers to a normal call into the imported (mangled) symbol at function entry, marshalling `(args, fn_name)` — Tier-1, no literal-argument forwarding yet. `sfn/log` ships `@logExecution` (`[INFO] <fn>`) and `@trace` (`[TRACE] → entered <fn>`). The un-imported built-in `@logExecution`/`@trace` still lowers to the `runtime_log_execution_fn` fallback and `sfn check` emits the `W0211` `deprecated-api` lint pointing at `import { logExecution } from "log"`; deleting the built-in string-match + runtime body is seed-gated (SFEP-0023 steps E/F) |
| `sfn fmt` | **Shipped** | Zero-config token-stream formatter, `--check`/`--write`, CI-enforced; generic type arguments containing function types (for example, `Channel<fn() -> void>`) keep tight angle brackets without fusing the close with a following assignment, and lowering consumes the formatter-canonical `fn (` spelling through the shared balanced function-type parser so formatting cannot change typed-channel behavior (SFN-434); architecture + limitations in `docs/proposals/0007-fmt-architecture.md` |
| `sfn check` | **Shipped** | Parse + typecheck + effect-check, no codegen; `--json` envelope; cross-module conformance; directory mode completes the full 156-file tree (~295 s — perf, not stability, is the open item); relative-import resolution (`E0430`/`E0431`, #1953) |
| `sfn test` | **Shipped** | Discovery, `-k`/`--tag` filtering (#849), lifecycle hooks (#975, ordering only), snapshots + `--update-snapshots` (#977), `--jobs N` parallel runner (#1236), per-test binary cache (#1230/#1233). **Recoverable test harness (SFN-17):** the synthesized `@main` harness (`compiler/capsules/codegen-llvm/src/lowering/lowering_core/test_harness.sfn`) wraps each hook/test call in an inline setjmp/longjmp frame and recovers — a failing test no longer aborts later tests in the same file; a failing `before_each` marks each affected test `fail` naming the hook, and `after_each`/`after_all` failures attribute to the hook rather than a test. `sfn test --json` gains a `hook` event kind; `schema_version` 1→2. Design: `docs/proposals/design-notes/sfn-17-recoverable-test-harness.md`. **Test-runner perf (SFEP-0044, 2026-07-08):** per warm test-file child (macOS 8-core): ~4 s → 2.9 s (in-process SHA-256 for text artifacts, #1995, PR #2000) → 1.75 s (invocation-scoped runtime-identity stamp, #1996, PR #2007); clang link window 2.9 s → 1.13 s. Direct `sfn test` and `sfn dev shard run` parallelism defaults natively to `min(cores, ((RAM * 80%) - 5 GiB) / 3 GiB)`, floor 1, cap 16, with a macOS cap of 2 — 3 GiB/job matches a measured pooled test child, and the explicit 5 GiB term reserves the parent runner, which compiles the whole dependency closure in-process before fanning out (SFN-547, re-sized SFN-626, re-sized SFN-781); `SAILFIN_TEST_JOBS` and explicit `--jobs N` override it in that order (SFN-91). Pooled children spawn with `SAILFIN_BUILD_JOBS=1` so a nested build's own emit fan-out cannot multiply the peak (SFN-547). The Makefile's `TEST_JOBS` compatibility default uses the same policy (#1998, PR #2001); `make check` runs ONE cold full suite (seedcheck leg, `--no-test-cache` backstop) + a pass1 smoke gate, `CHECK_FULL_PASS1=1` restores the old shape. CI shard legs restore a per-OS+shard test-binary cache across runs (#2008, PR #2009); safety is in the self-validating entry keys (#1233). Known residual: unit-tier cold cost dominated by per-child dep-closure compilation (~15 s CPU/file measured) — tracked as #2010; resolver sharing is #1997. Binary and text artifact hashing now share one binary-safe in-process path (`_read_file_bytes` + streaming `sha256_hex_of_bytes`, SFN-659/SFN-660); the former 64 KiB subprocess threshold and whole-message `int[]` materialization are retired. **Harness↔runner IPC (SFEP-0050, SFN-393):** the harness now writes framed `SFTR` records to fd 2 and the runner demuxes them off the child's captured stderr pipe inline (via `io.poll_any` + the SFN-402 process-handle primitives), retiring the `results.log`/`fail.bin`/`_subframe_summary.json` file side-channel (SFN-17). Per-process pipe ownership makes the nesting/pool collision structurally impossible, so the IPC-key scrubbing (`_pool_child_env`, the nested-runner `clean_runner_env`) is no longer load-bearing for harness IPC — it now only isolates the `SAILFIN_TEST_SCRATCH` build-cache root, which survives. The `--json` v2 schema is unchanged. |
| `sfn bench` | **Shipped** | Native benchmarking command (epic #1503). Three modes: `--compiler` (per-module compiler emit time + peak RSS across `compiler/src/**/*.sfn` and `compiler/capsules/**/*.sfn`, SFN-61), `[<path>...]` runtime-workload runner (build once, warm up, time K iterations, aggregate min/median inner-ms + peak RSS, SFN-63; default path `benchmarks/runtime`), and `--consumer` (consumer-build benchmark: builds each fixture under `--fixtures DIR`, default `benchmarks/consumer`, twice — cold, then warm against the cache the cold run populated — and records per fixture cold/warm wall time, stripped binary bytes, `.init_array` ctor-slot count, modules staged, and cold/warm cache hit/miss counts; builds only, never executes fixtures, so no `![net]` is needed; `--json` is rejected (exit 2, points at `--csv`); `--top`/`--budget-time`/`--budget-mem` are accepted but ignored, SFN-830). Shared `--top`/`--csv`/`--budget-time`/`--budget-mem`/`--work-dir` flags with exit 2 on budget violation (compiler/runtime modes only); `--json` emits the versioned `sailfin.bench/v1` envelope (SFN-64, `docs/reference/bench-json-schema.md`), also exposed as the `sailfin_bench` MCP passthrough. `make bench` / `make bench-runtime` / `make bench-consumer` are thin wrappers; the former bench shell scripts are retired. Reference: `site/src/content/docs/docs/reference/bench.md` |
| Agent-language benchmark harness | **Shipped (v2.8 bounded pilot stopped; confirmation rejected)** | `benchmarks/llm/sfn350.sfn` records the SFN-364 machine-readable failure taxonomy per failed iteration, excludes provider/setup invalidations from language denominators, retains implementation defects as Track A adoption failures while excluding their paired instances from Track B learnability estimates, and exports blinded manual-classification templates plus a separate audit key. Seeded, paired Track B `examples`, `diagnostics`, and `primitive` ablation schedules are secondary-only and cannot authorize the primary decision. SFN-365 corrected current OpenAI models to use the Responses API, passed all setup and unscored gates, and completed the OpenAI Track A schedule. That family showed Sailfin one-shot success at 72.2% versus Scala at 77.7% and Python at 88.8%, but Python had no varying template. The Anthropic Track A batch was invalidated by thinking-only `max_tokens` responses, so Track B was not run and confirmatory spend was rejected under v2.1.0. SFN-368 replaces the aliased four-way task clones with independently allocated frozen prompts and hidden fixtures, records their SHA-256 identities, and rejects cumulative markers or duplicate fixture sets. SFN-369 teaches the shipped Sailfin `routine` / `spawn fn() -> T { ... }` / `await` surface, freezes equivalent Scala and Python guidance, and makes the Track A concurrency grader reject output-equivalent sequential programs with a distinct `missing_concurrency` diagnostic. SFN-376 applies the same frozen structural requirement to Sailfin-B and translated Rill-17 sources before semantic execution. Every v2.1.0 structured-concurrency observation is ineligible for selection, rerun, or pooling with v2.5.0; v2.4.0 produced no scored output. SFN-437 rejected v2.7 before packet exposure or scoring when `claude-sonnet-5` rejected manual `thinking.type=enabled`; SFN-438 froze v2.8 with adaptive thinking, explicit medium effort, truthful non-enforceable answer-headroom recording, and fail-closed probes. The fresh v2.8 setup and ten authorization smokes passed. OpenAI completed all 120 Track A attempts: Sailfin/Scala/Python one-shot rates were 66.6%/72.2%/91.6%, all solved by iteration 5, and Python exceeded the 90% useful-variance ceiling. Anthropic stopped on its fifth Track A observation after three `overloaded_error` responses exhausted the symmetric retry policy; Track B was not purchased. Both tracks therefore remain non-decision-grade, confirmation and external-adoption spend are NO-GO, and no v2.7 or v2.8 observation may be selectively rerun or pooled. SFN-439 tracks the required new-corpus/task-difficulty design. Protocol: `benchmarks/llm/PROTOCOL-V2.md`; readout and failure corpus: `benchmarks/llm/PILOT-V2.md` |
| `sfn vet` | **Retracted** | Not planned as a command. Lint ships *inside* `sfn check` as the `W02xx` warning range (`W0210` bare assert, `W0211` deprecated decorator), home `tools/check.sfn` per `docs/style-guide.md`. A new advisory check is a new `W02xx` code, not a new verb; a check that should fail a build is an `Exxxx` code in the range owning its domain. Rationale + the rule-by-rule reassignment audit: SFEP-0003 §2.1 |
| `sfn fix` | Planned — no gate | The `FixSuggestion`/`TextEdit` machinery ships (see Diagnostics above) and `E04xx` + `W0210` already populate it; what is missing is an edit applier (reverse-order splicing), producer coverage, and an overlap rule. Agents can already apply edits from the `sailfin-check/1` envelope without the command. SFEP-0003 §3.7 |
| `sfn doc` | Deferred — gated on a prose-location decision | Cannot be built as originally designed: it assumed `///` doc comments, which the language does not have and the lexer cannot distinguish from `//`. The machine-readable half already ships as `sfn symbols --json` (signatures, effects, import paths). Open question is whether hand-written API prose lives in source (a language change) or only in `site/`. SFEP-0003 §3.6 |
| `sfn lsp` / editor integration | Deferred — gated on resident incremental analysis (unowned) | Syntax highlighting, effect-annotation recognition, and snippets ship today via the `SailfinIO.sfn` VS Code extension; diagnostics, go-to-definition, hover, and completion need a language server. The real prerequisite is analysis that survives between requests (resident process, content-hash file cache, per-request arena reclamation) — larger than the LSP itself and owned by no proposal. `sailfin-check/1` already supplies the diagnostic wire format. SFEP-0003 §3.5; `site/src/content/docs/docs/getting-started/editor-setup.md` |
| Package registry (`sfn init/add/publish`) | Shipped | Default registry `pkg.sfn.dev`; `SFN_REGISTRY` / `sfn config set registry` override |
| Toolchain pinning (`[toolchain]` manifest + version/channel gate) | **Shipped (Phase 1)** | SFEP-0046 §3.1–3.4, SFN-167: floor-semver + channel gate on `sfn build`/`run`/`check`/`test`; `sfn init` scaffolds the pin; `--skip-toolchain-check` / `SAILFIN_SKIP_TOOLCHAIN_CHECK` / `SAILFIN_TOOLCHAIN=off` escape hatches. Root `workspace.toml` `[toolchain]` floor adopted repo-wide (SFEP-0051 Phase 2, SFN-414): default floor for every member, member `capsule.toml` overrides per field. |
| Native toolchain install (`sfn toolchain install`) | **Shipped (Phase 2 acquire)** | SFEP-0046 §3.5, SFN-168/SFN-660: native fetch + fail-closed Ed25519-signature + binary-safe in-process SHA-256 verification into the version store, including native Windows; `SAILFIN_TOOLCHAIN_RELEASE_BASE` mirror override. |
| Toolchain re-exec dispatch (`SAILFIN_TOOLCHAIN=auto`/`local`/`<version>`/`off`) | **Shipped** | SFEP-0046 §3.5, SFN-172: on a `[toolchain]` floor-check failure, `sfn build`/`run`/`check`/`test` fetch (if needed, `auto`, default) + verify + re-exec the pinned toolchain with the original argv; re-entrancy guard `SAILFIN_TOOLCHAIN_DISPATCHED`; offline falls back to the install hint. SFEP-0046 tracks six issues (SFN-167–172); it stays `Accepted` pending the remainder. |
| `workspace.lock` (`sfn lock` write + resolver consume) | **Shipped** | Explicit `sfn lock` writes the root lockfile (#1070); `sfn lock --work-dir DIR` sets the workspace-discovery start dir so the command can run against a workspace without `cd`. Resolver prefers `workspace → workspace.lock → capsule.lock → cache → registry` for external deps, sibling-first untouched (#1071). Roots own lockfiles; library capsules don't commit them. Committing the root `workspace.lock` is #1050, gated on a seed embedding #1071 (satisfied at `v0.7.0-alpha.31`) |
| Workspace capability envelope (`[workspace.capabilities]` allow/deny/grants + enforce/warn gate) | **Shipped (declared surface, enforced)** | SFEP-0051 Phase 4. Declared-surface audit (SFN-416, 4a): each member's `capsule.toml [capabilities] required` is checked against the workspace envelope `effective(M) = (allow ∪ grants[M]) \ deny` (reuses SFEP-0017 subsumption, so an `io` entry covers `io.*`); a drifting effect emits `E0405`, a malformed envelope entry `E0406`. Enforcement gate (SFN-419, 4c): `sfn check` and `sfn build` at workspace scope run the audit and **fail on drift** by default (`enforce`); `[workspace.capabilities] mode = "warn"` reports without failing (migration aid only, not the marketed state). The envelope is **opt-in** — the gate activates only when the workspace declares a non-empty `allow` ceiling, so envelope-free workspaces (including this repo) are never retroactively broken. `sfn capabilities audit` prints the per-member required-vs-effective table and exits non-zero on drift (CI-dashboard surface). Inferred-`![...]`-surface audit (Phase 4b, SFN-418) is still open, so the SFEP stays `Accepted`; the declared-surface gate is enforced end-to-end. |
| `sfn cache` (`info`/`prune`/`clean`) | **Shipped** | Bounded-size GC over the content-addressed build cache (SFEP-0040 §3.2–3.4, #1893): `info` prints root/entry-count/size; `prune [--max-size <bytes>] [--max-age <days>]` evicts oldest-first by true LRU (mtime touched on cache hit), defaults ~5 GiB/30 days, opt-in only; `clean [--all-schemas]` removes the current schema tree and optionally stale sibling `v<M>` trees. `![io]` command, no eager auto-sweep on builds |
| `sfn symbols` (`--json`/`--capsule`) | **Shipped** | Versioned, deterministic `sailfin-symbols/1` index of the public callable surface (auto-imported prelude globals + in-tree `sfn/*` capsule `src/mod.sfn` free functions) for agents/tooling (SFN-444, `docs/reference/symbols-json-schema.md`). `--capsule <slug>` filters to one capsule; an unresolvable slug is a structured `E_SYMBOLS_UNRESOLVED_CAPSULE` error, exit 1. v1: `src/mod.sfn` top-level only (no submodule re-exports), intrinsic/ABI helpers excluded |
| Notebook support | Not started | Post-1.0 |

## Print API (Current)

- `print(value)` is the canonical output builtin (stdout, no prefix).
- `print.err(value)` writes to stderr.
- `print.info`/`print.warn`/`print.error` are deprecated legacy variants; new
  code uses `print()` and `print.err()`.
- The `sfn/log` capsule provides structured logging (`log.*`); `log.warn` and
  `log.error` route to stderr.

## Standard Library Capsules (Current)

Capsules ship under `capsules/sfn/` and are imported by bare name
(e.g. `from "strings"`).

| Capsule | Import | Status | Effects | Description |
|---------|--------|--------|---------|-------------|
| `sfn/strings` | `"strings"` | Shipped | None | Trim, explicit ASCII-only `ascii_uppercase` / `ascii_lowercase` conversion (non-ASCII bytes unchanged), split/join, find/replace |
| `sfn/json` | `"json"` | Shipped | None | JSON parsing, serialization, pretty-print; `parse_with_limits(text, ParseLimits)` enforces caller-configurable nesting-depth and input-size caps (defaults via `default_limits()`: depth 1000, length 10M) and returns a `ParseOutcome { ok, error, value }` that cleanly reports a guard breach instead of crashing on adversarial input (SFN-156) |
| `sfn/crypto` | `"crypto"` | Shipped | `![rand]` (`random_bytes` only), `![io]` (`trust_store_load`/`trust_store_load_from` only) | Pure Sailfin SHA-256/SHA-1/SHA-384/SHA-512 + base64, HMAC-SHA-256, HKDF-SHA-256, ChaCha20, Poly1305, and bit/constant-time helpers (SFEP-0048 Phase A + Phase D prep) — SHA-384 and SHA-512 share one 64-bit limb-pair compression core (`capsules/sfn/crypto/src/sha512.sfn`, SFN-652), SHA-384 being that core under a distinct IV truncated to 6 words; `sha512(data: string) -> string` (`"sha512:"`-prefixed) and `sha512_hex(data: string) -> string` are the public digests, with a byte-oriented `sha512_bytes(msg: int[]) -> int[]` kept capsule-internal for RFC 8032 Ed25519 signing/verification (SFN-699/SFN-655) and, structurally identical, `sha384_bytes(msg: int[]) -> int[]` kept capsule-internal as the sole SHA-384 digest the TLS 1.3 key schedule consumes (SFN-662); pure Sailfin X25519 (Curve25519 ECDH, RFC 7748) — `x25519(scalar: int[], u: int[]) -> int[]`, `x25519_base(scalar: int[]) -> int[]`, `x25519_is_zero(shared: int[]) -> bool` (`capsules/sfn/crypto/src/x25519.sfn`, SFN-335), no effects, 16×16-bit limb representation, constant-time Montgomery ladder with no secret-dependent branch or array index, fails closed to `[]` on a non-32-byte scalar or u-coordinate; `x25519_is_zero` exists because RFC 8446 §7.4.2 requires a TLS 1.3 handshake to abort on an all-zero shared secret; design gate: `docs/proposals/design-notes/sfn-335-x25519-limb-strategy.md`; pure Sailfin Ed25519 verification (`capsules/sfn/crypto/src/ed25519.sfn`, SFN-655) shares that field layer, implements the RFC 8032 twisted-Edwards group law and SHA-512 challenge, preserves the hexadecimal `ed25519_verify` / `ed25519_verify_utf8` API, rejects non-canonical and low-order points plus `S >= L`, and contains no OpenSSL extern; pure Sailfin Ed25519 signing (`capsules/sfn/crypto/src/ed25519_sign.sfn`, SFN-699) exposes `ed25519_sign(seed: int[], message: int[]) -> int[]`, returning a deterministic canonical 64-byte RFC 8032 signature or `[]` for a wrong-length seed, with fixed-round secret base-point multiplication and no secret-dependent branch or array index; `ed25519_seed_from_pkcs8_der` / `ed25519_seed_from_pkcs8_pem` decode the canonical unencrypted RFC 8410 version-0 PrivateKeyInfo subset into a binary-safe 32-byte seed and fail closed on other algorithms, parameters, extensions, encrypted labels, trailing data, or malformed input; signing is the pure primitive required by the TLS 1.3 server CertificateVerify state machine (SFN-654) and eventual OpenSSL body swap (SFN-341), neither of which is implemented by SFN-699; `random_bytes(n: int) -> int[] ![rand]` (`capsules/sfn/crypto/src/rand.sfn`) — the capsule's sole effectful function, returning `n` cryptographically secure bytes from the OS entropy source (`getentropy`/`getrandom`, `/dev/urandom` read-loop fallback) via the runtime primitive `sfn_rand_fill` (`runtime/sfn/platform/rand.sfn`); fails closed to `[]` on non-positive `n` or an entropy-source error (never zeroed/partial output). Backs the WebSocket adapter's masking key and handshake key generation, retiring its OpenSSL `RAND_bytes` extern (SHA-1/`EVP_EncodeBlock` OpenSSL externs remain, so `-lssl -lcrypto` is still linked); TLS 1.3 client handshake (RFC 8446 §4, SFN-337, SFEP-0048 Phase B) — `capsules/sfn/crypto/src/tls13_handshake.sfn` + `tls13_handshake_codec.sfn`: a `ClientHandshake` state machine (ClientHello encode; ServerHello/EncryptedExtensions/Certificate/CertificateVerify/Finished parse) driving the existing record layer (`tls13_record.sfn`) and key schedule (`tls13_schedule.sfn`), with a running transcript hash, X25519 key exchange, and both handshake/application traffic secrets plus traffic key/IV derivation (RFC 8446 §7.3) checked bit-for-bit against the RFC 8448 §3 "Simple 1-RTT Handshake" trace (16 tests, `capsules/sfn/crypto/tests/tls13_handshake_test.sfn`, plus 34 fail-closed codec tests in `tls13_handshake_codec_test.sfn`). Pure computation, no socket I/O — `runtime/sfn/platform/tls.sfn` still uses OpenSSL (the swap is SFN-341). CertificateVerify checking now dispatches on the peer's chosen signature scheme (SFN-767): `rsa_pss_verify_sha256`/`rsa_pss_verify_sha384` (SFN-658), `ecdsa_p256_verify_sha256` (SFN-657), or `ed25519_verify` (SFN-655), with the verifying key derived from the leaf certificate the peer actually presented (`x509_parse` → `spki_algorithm`/`spki_key`) rather than supplied by the caller, and a scheme naming a key type the leaf does not hold rejected, not skipped; the RFC 8448 §3 trace is now driven through this verifying path and its RSA-PSS signature is genuinely checked against the 1024-bit RSA key in the certificate the trace itself carries, leaving `server_certificate_verified = true` — the former `hs_client_recv_certificate_verify_without_authenticating` escape hatch has been deleted; `ClientHello` now offers `ecdsa_secp256r1_sha256`, `rsa_pss_rsae_sha256`, `rsa_pss_rsae_sha384`, `ed25519` in that preference order (previously `ed25519` only), which is what makes a handshake with a real public server possible at all; the Certificate message now retains the full DER chain (`CertificateMsg.chain`, `ClientHandshake.server_certificate_chain`), not just the leaf; chain building and the trust decision are now reachable from handshake state via `hs_client_verify_peer(hs, hostname, anchors, now_ms)`, which composes `x509_parse` → `x509_verify_chain` → `x509_hostname_matches` (SFN-340's capability, now wired in) and refuses to run unless `server_certificate_verified` is already true, so a trusted chain is never reported for a peer that has not proved possession of the leaf key — no resumption, 0-RTT, or HelloRetryRequest (detected and rejected, not mis-parsed); the server-side handshake shipped separately (SFN-654, described below). The client now offers both SHA-256 cipher suites in `ClientHello` — `TLS_CHACHA20_POLY1305_SHA256` first, then `TLS_AES_128_GCM_SHA256` (SFN-814) — closing the RFC 8446 §9.1 mandatory-cipher-suite interop gap, so the native client can complete a handshake with an AES-GCM-only server. The order is deliberate and inverts the usual AES-NI-era preference: `runtime/sfn/platform/tls.sfn` now dispatches on the negotiated suite, sending ChaCha20-Poly1305 records through the `*u8` pointer-idiom record layer (SFN-768, `platform/tls_record.sfn`, **measured** ~233 MB/s) but AES-GCM records through the capsule's `int[]` layer (`tls13_record.sfn`), whose throughput is stated as a **bound, not a measurement**: the capsule *primitive* measures ~1.0 MB/s at `-O2` (`benchmarks/runtime/aes_gcm_seal_bench.sfn`) and the runtime path adds three `int[]` marshalling passes, record framing, and a writeback loop on top, so **≤1.0 MB/s** is a ceiling this path cannot exceed rather than its rate. The two figures are therefore not directly comparable — one is a runtime layer, the other a capsule primitive, which is the same conflation that put the design note's estimate out by ~36× above, in the opposite direction. What is safe to say is that AES-GCM is a working interop fallback orders of magnitude slower than the preferred path; SFN-817 ports it to the `*u8` idiom and measures it properly. `platform/tls_record.sfn` itself stays ChaCha20-only with its strict 32-byte key guard intact, deliberately, so a suite it cannot carry never reaches it — AES-256-GCM's key is also 32 bytes, so loosening that guard without an algorithm selector would silently encrypt an AES-256 key's traffic with ChaCha20, failing at the peer rather than locally. `TLS_AES_256_GCM_SHA384` is still neither offered nor accepted; capsule version 0.29.0 → 0.30.0 for the two new suite-aware record exports and the changed `ClientHello` bytes; minimal DER/ASN.1 reader (`capsules/sfn/crypto/src/der.sfn`, SFN-504, design: SFEP-0048 Phase C) — definite-length TLV only (BER indefinite-length form is rejected as invalid DER), covering SEQUENCE, SET, INTEGER, OBJECT IDENTIFIER, BIT STRING, OCTET STRING, BOOLEAN, NULL, UTCTime/GeneralizedTime, and the directory-string types, hardened with explicit nesting-depth (default 64) and total-input-length (default 1 MiB) guards (SFN-156 precedent), and rejecting non-minimal length/integer/OID-arc encodings, non-canonical booleans, and length fields wider than 4 octets; X.509 certificate structure parse plus RFC 6125 §6.4.3 hostname matching (`capsules/sfn/crypto/src/x509.sfn`, SFN-504) — `x509_parse`/`x509_parse_with_limits` extract version, serial, issuer/subject Name (with commonName), validity window, SubjectPublicKeyInfo, SAN `dNSName` entries, and the basicConstraints/keyUsage/extendedKeyUsage extensions (every extension additionally exposed verbatim via `X509Extension`); the parse is strict against differential-parsing tricks — tbsCertificate fields must appear once and in RFC 5280 order (so a second `[3]` extensions block cannot smuggle a `subjectAltName`), every fixed-arity container must end exactly where its last expected child does, a repeated extension OID is rejected per RFC 5280 §4.2, and the extension count is capped at 64 so the duplicate-OID scan cannot be driven quadratic; a pure `x509_validity_at(cert, unix_millis)` classifies a caller-supplied Unix-millisecond snapshot against the validity window — the module never reads ambient time, so the capsule stays effect-free; the caller owns `![clock]` and the fallible `sfn/time::unix_millis()` read (SFN-623); `x509_hostname_matches`/`x509_dns_name_matches` match only SAN `dNSName` entries (commonName is deliberately not consulted, RFC 6125 §6.4.4), with a leftmost-only whole-label wildcard refused below 3 labels. **This is inspection only, not certificate validation by this module:** no signature is verified, no chain is built, and basicConstraints/keyUsage/extendedKeyUsage are parsed and exposed but never enforced here — chain verification and the trust store now ship separately (`x509_verify.sfn` + `trust_store.sfn`, SFN-340, below), and the parsing surface itself is still not wired into `runtime/sfn/platform/tls.sfn`. Pure Sailfin RSASSA-PKCS1-v1_5 signature verification (RFC 8017 §8.2.2, SFN-656) — `rsa_pkcs1_v1_5_verify_sha256(n_bytes: int[], e: int, message: int[], sig: int[]) -> bool` and `rsa_pkcs1_v1_5_verify_sha384(n_bytes: int[], e: int, message: int[], sig: int[]) -> bool` (same signature), both re-exported from `src/mod.sfn` as the capsule's only public surface for this feature; backed by a new capsule-internal variable-length bignum layer (`capsules/sfn/crypto/src/bignum.sfn`) — 26-bit limbs, CIOS Montgomery multiplication, a public square-and-multiply modexp — with limb width and overflow margins from design gate `docs/proposals/design-notes/sfn-653-p256-rsa-bigint-strategy.md` §6 (the note that applies the SFN-335 width search to RSA and P-256; module split in §7.2); deliberately not constant time, the inverse of the X25519/Ed25519 constant-time requirement above — verification touches only public data (public modulus, exponent, signature, and message), so there is no secret to leak, and none of this is approved for signing or any other private-key operation; supports 1024–4096-bit moduli (128–512 bytes) and a public exponent that must be odd, at least 3, and within a positive 31-bit int, a DoS bound on untrusted certificates; the encoding check compares the whole reconstructed EMSA-PKCS1-v1_5 encoding against the whole recovered one (RFC 8017 §9.2) rather than parsing the recovered encoding, which is what closes the Bleichenbacher'06 forgery class; fails closed (`false`, never a panic) on a zero/even/out-of-range modulus, a signature length that differs from the modulus length, a signature not less than the modulus, and a bad exponent, and tolerates a DER INTEGER's leading zero sign octet on the modulus; gated by NIST CAVP FIPS 186-3 `SigVer15_186-3.rsp` `[mod = 2048]` vectors — one passing SHA-256 case, one passing SHA-384 case, and the changed-message/changed-signature/changed-exponent failing cases — plus forgery-shaped encoding tests (`capsules/sfn/crypto/tests/rsa_pkcs1_test.sfn`); one 2048-bit verify measures 13 ms under the -O0 test build. Pure Sailfin RSASSA-PSS signature verification (RFC 8017 §8.1.2, SFN-658) — `rsa_pss_verify_sha256(n_bytes: int[], e: int, message: int[], sig: int[]) -> bool` and `rsa_pss_verify_sha384(n_bytes: int[], e: int, message: int[], sig: int[]) -> bool`, both re-exported from `src/mod.sfn`; reuses this exact `_rsa_public_op`/bignum core rather than forking a second modexp path, adding capsule-internal MGF1 (RFC 8017 §B.2.1) and EMSA-PSS-VERIFY (RFC 8017 §9.1.2) helpers; salt length is fixed at the digest length (32 for SHA-256, 48 for SHA-384) — the only length TLS 1.3's `rsa_pss_rsae_*`/`rsa_pss_pss_*` schemes permit — so variable salt lengths and the RFC's salt-length-recovery mode are deliberately not implemented; exists because RFC 8446 §4.2.3 removes the `rsa_pkcs1_*` schemes from TLS 1.3 CertificateVerify entirely, making PSS mandatory for RSA server keys, while v1.5 (SFN-656) remains the scheme for X.509 certificate signatures — neither substitutes for the other; deliberately not constant time, same rationale as SFN-656 above — verification touches only public data, and none of this is approved for signing or any other private-key operation; fails closed (`false`, never a panic) on an empty/all-zero modulus, a signature length differing from the modulus length, a signature not less than the modulus, an even or out-of-range exponent, a wrong-length digest, and an encoding too short to hold the salt and digest, and tolerates a DER INTEGER's leading zero sign octet on the modulus; gated by NIST CAVP FIPS 186-3 `SigVerPSS_186-3.rsp` `[mod = 2048]` vectors — 8 SHA-256 records and 2 SHA-384 records covering a positive under four distinct keys plus all five of NIST's failure classes (message changed, signature changed, public key exponent changed, EM format with the hash moved left, EM format with the pad terminator removed) — plus structural forgery tests (0xbc trailer, non-zero leftmost bit, missing 0x01 delimiter, non-zero PS, mismatched H') pinned directly against the decision function `_emsa_pss_verify` so no modexp is paid per case (32 tests, `capsules/sfn/crypto/tests/rsa_pss_test.sfn`). There is still no RSA signing, key generation, decryption, or OAEP. Pure Sailfin ECDSA-P256 signature verification (FIPS 186-4 §6.4.2, SFN-657) — new `capsules/sfn/crypto/src/p256.sfn` implements NIST P-256 field, scalar, and point arithmetic: 10 little-endian limbs of 26 bits in Montgomery form for both the field prime `p` and the subgroup order `n`, reusing this same `bignum.sfn` CIOS `_mont_mul` through two fixed 10-limb `MontCtx` values rather than founding a second CIOS; Jacobian point arithmetic (`dbl-2001-b` doubling using the a = -3 shortcut, `add-2007-bl` addition); SEC1 point decoding (uncompressed `0x04` and compressed `0x02`/`0x03`); and Straus joint multiplication for `u1*G + u2*Q`. New `capsules/sfn/crypto/src/ecdsa.sfn` parses the DER `Ecdsa-Sig-Value` (reusing SFN-504's `der.sfn`, not a second parser) and runs the FIPS 186-4 §6.4.2 verify sequence. Public API, both re-exported from `src/mod.sfn`: `ecdsa_p256_verify_digest(public_key: int[], digest: int[], signature: int[]) -> bool` and `ecdsa_p256_verify_sha256(public_key: int[], message: int[], signature: int[]) -> bool`; `public_key` is a SEC1 point and `signature` is a DER `Ecdsa-Sig-Value` — the digest entry point is what an X.509 chain verifier wants (it hashes the tbsCertificate itself), the message entry point is the `ecdsa-with-SHA256` profile (RFC 5758 §3.2). **Verify only** — signing and key generation are deliberately out of scope for both curves (the private-key side is where the constant-time and nonce hazards live), and no curve besides P-256 and P-384 (no P-521 or secp256k1) is implemented. Gated by RFC 6979 appendix A.2.5 (P-256/SHA-256, messages `sample` and `test`) and NIST CAVP FIPS 186-4 `186-4ecdsatestvectors.zip` → `SigVer.rsp`, group `[P-256,SHA-256]` (a passing record plus the supplied `Message changed`, `R changed`, `S changed`, and `Q changed` failures) (`capsules/sfn/crypto/tests/ecdsa_p256_test.sfn`). `bignum.sfn`'s export block widened to expose the scalar/field helpers `p256.sfn` needs; still capsule-internal, not in `mod.sfn`'s public barrel. X.509 chain verification now dispatches to this for ECDSA-P256 certificate signatures (`x509_verify_chain`, SFN-340, below); TLS 1.3 handshake's CertificateVerify checking now accepts ECDSA P-256 too (SFN-767). Capsule version 0.23.0 → 0.24.0. NIST P-384 (secp384r1) verification (SFN-811) adds `capsules/sfn/crypto/src/p384.sfn` — 15 little-endian limbs of 26 bits in Montgomery form (R = 2^390) driving the same shared `bignum.sfn` CIOS `_mont_mul`, a deliberate parallel of `p256.sfn` rather than a shared generic core — and `ecdsa_p384_verify_digest(public_key: int[], digest: int[], signature: int[]) -> bool` / `ecdsa_p384_verify_sha384(public_key: int[], message: int[], signature: int[]) -> bool` in `ecdsa.sfn`, both re-exported from `src/mod.sfn`; the DER `Ecdsa-Sig-Value` walk is now shared between the two curves, only the scalar range check is per-curve. Verify only, same as P-256 — no P-384 signing. Gated by RFC 6979 appendix A.2.6 known-answer vectors, cross-checked against OpenSSL 3.6.3 before embedding (`capsules/sfn/crypto/tests/ecdsa_p384_test.sfn`, 25 tests). X.509 chain verification now dispatches to this for `ecdsa-with-SHA384` certificate signatures too (1.2.840.10045.4.3.3, `x509_verify_chain`, SFN-340/SFN-811, below) — unblocking real-world HTTPS chains, since a P-256 leaf under a P-384 intermediate is a common CA topology; TLS 1.3 handshake's CertificateVerify checking does not offer or accept P-384. Capsule version 0.30.0 → 0.31.0. Certificate-signature RSA verification (PKCS1-v1.5, SFN-656) is consumed by X.509 chain verification (`x509_verify_chain`, SFN-340, below), not CertificateVerify — RFC 8446 §4.2.3 forbids PKCS1-v1.5 there, so that stays permanent, not a gap; RSASSA-PSS verification (SFN-658) is now wired into CertificateVerify (SFN-767), and `runtime/sfn/platform/tls.sfn` still uses OpenSSL (SFN-341); the TLS 1.3 server (SFN-654) still signs with Ed25519 only, since RSA signing remains unimplemented. Adds a `sfn/strings` dependency edge (capsule version 0.18.0 → 0.19.0); `[capabilities] required` stays `[]`. TLS 1.3 **server** handshake (RFC 8446 §4, SFN-654, SFEP-0048 Phase B) — `capsules/sfn/crypto/src/tls13_server_handshake.sfn`: a `ServerHandshake` state machine (ClientHello parse; ServerHello/EncryptedExtensions/Certificate/CertificateVerify/Finished encode, client Finished verify), the sibling of the SFN-337 client, driving the same record layer (`tls13_record.sfn`) and key schedule (`tls13_schedule.sfn`) with its own running transcript hash and the X25519 key share wired into the schedule so the record layer can be rekeyed at each transition; checked bit-for-bit against the RFC 8448 §3 "Simple 1-RTT Handshake" trace from the server side (11 tests, `capsules/sfn/crypto/tests/tls13_server_handshake_test.sfn`), plus a client/server interop test running both state machines against each other over a real X25519 exchange with a real Ed25519 CertificateVerify the client verifies, both Finished MACs cross-checked, and a sealed/opened application record. `tls13_handshake_codec.sfn` gained the server-direction encoders (`encode_server_hello`, `encode_encrypted_extensions`, `encode_certificate`, `encode_certificate_verify`) plus `struct ClientHelloMsg` / `parse_client_hello`, completing the codec's other direction. New `capsules/sfn/crypto/src/pem.sfn` (`pem_decode_blocks`, `pem_certificates_to_der`; 20 tests) decodes PEM → DER for loading a certificate chain — binary-safe unlike `mod.sfn`'s `string`-returning `base64_decode`, which cannot carry DER's 0x00 bytes. **Pure computation, no socket I/O** — the module consumes handshake messages the caller has already deframed and returns bytes the caller must send; `runtime/sfn/platform/tls.sfn` is untouched and still OpenSSL-backed (`tls_accept_fd`/`tls_server_ctx` unchanged), and swapping those bodies onto the native stack is SFN-341. CertificateVerify signs with Ed25519 only (`ed25519_sign`, SFN-699) — a ClientHello that does not offer ed25519 is refused at the CertificateVerify step; RSA-PSS signing and ECDSA-P256 signing are unimplemented — SFN-658 shipped RSA-PSS *verification* only and SFN-657 shipped ECDSA-P256 *verification* only, and neither has a signing counterpart yet. No client authentication/mTLS, no session resumption, no tickets, no 0-RTT, no HelloRetryRequest. No certificate chain verification — the server treats its configured chain as opaque DER; chain verification now exists as a capsule primitive (`x509_verify_chain`, SFN-340, below) but is not wired into this state machine, and the trust decision remains the client's. SHA-256 cipher suites only: ChaCha20-Poly1305 and AES-128-GCM share the key schedule, and the capsule can now seal records with both (SFN-814) — ChaCha20-Poly1305 via the runtime's `*u8` pointer-idiom layer, AES-128-GCM via the capsule's `int[]` layer, ~230x slower at `-O2` (above). Capsule version 0.21.0 → 0.22.0; `[capabilities] required` stays `[]`. X.509 certification-path validation and the system trust store (SFEP-0048 Phase C completion, SFN-340) — new `capsules/sfn/crypto/src/x509_verify.sfn`, pure (no effects; caller supplies the Unix-millisecond snapshot, the same boundary `x509_validity_at` established under SFN-504): `x509_verify_chain(leaf: X509Certificate, intermediates: X509Certificate[], anchors: X509Certificate[], options: X509VerifyOptions) -> X509ChainResult`, `x509_verify_options(now_ms: int) -> X509VerifyOptions`, `x509_verify_default_max_depth() -> int` (8), all re-exported from `src/mod.sfn`; chain building takes the leaf explicitly, treats `intermediates` as an unordered bag (order irrelevant, off-path certificates ignored), and walks greedily without backtracking — safe because a candidate issuer is accepted only after its signature over the subject verifies, each intermediate is consumed at most once, and the turn count is bounded by the bag size, so it cannot cycle; signature dispatch on the certificate's signature-algorithm OID covers Ed25519 (1.3.101.112), ECDSA-P256/SHA-256 (1.2.840.10045.4.3.2, SFN-657), ECDSA-P384/SHA-384 (1.2.840.10045.4.3.3, SFN-811), RSASSA-PKCS1-v1.5 with SHA-256 (1.2.840.113549.1.1.11) and SHA-384 (1.2.840.113549.1.1.12, SFN-656) — the certificate-signature RSA mode, distinct from PSS — and, since SFN-824, `id-RSASSA-PSS` (1.2.840.113549.1.1.10) routed to the same `rsa_pss_verify_sha256`/`rsa_pss_verify_sha384` (SFN-658) but accepted only under the RFC 4055 §3.1 `RSASSA-PSS-params` profile MGF1-over-the-signature-hash with salt length equal to the digest (32 for SHA-256, 48 for SHA-384) and trailerField 1, with the inner and outer AlgorithmIdentifier `parameters` required byte-identical for this OID only — every other params encoding, including the RFC 4055 default taken by an absent or partial `parameters` field (SHA-1), rejects as unsupported-algorithm rather than being assumed; any other OID rejects the link rather than skipping it; enforces RFC 5280 §4.1.1.2 outer/inner signatureAlgorithm agreement, validity at every position in the path (not just the leaf), basicConstraints CA flag, keyUsage keyCertSign when present, pathLenConstraint, and extendedKeyUsage serverAuth on the leaf when present (on by default via `require_server_auth`); trust anchors are not exempt from validity or CA constraints; distinguishable outcome codes on `X509ChainResult { ok, code, error, depth, anchor_subject_cn }`: ok, bad-input, no-anchor, bad-signature, unsupported-algorithm, algorithm-mismatch, expired, not-yet-valid, not-a-ca, path-len-exceeded, eku, path-too-long, name-constraint, name-constraint-unsupported. New `capsules/sfn/crypto/src/trust_store.sfn`: `trust_store_from_pem(pem: string) -> TrustStore` is pure (decode via `pem_certificates_to_der_with_limits` + `x509_parse`), now composed from the shared parse tail `trust_store_from_der_blocks(blocks: int[][]) -> TrustStore` (SFN-808), which a module-private platform-roots decoder also feeds; only `trust_store_load() -> TrustStore ![io]` and `trust_store_load_from(path: string) -> TrustStore ![io]` carry an effect. A PEM block that fails to parse as a certificate is skipped and counted on `TrustStore { ok, error, source, anchors, skipped }` rather than failing the load (a dropped anchor only shrinks trust, never grows it); a bundle where nothing parses fails. `trust_store_load()` consults `SAILFIN_TLS_CAFILE` then `SSL_CERT_FILE` (the first that is *set* wins outright — a non-resolving override is an error, never a silent fallback to the system bundle), then the platform trust store (SFN-808: `sfn_cert_roots_blob()`, `runtime/sfn/platform/cert_roots.sfn`/`cert_roots_windows.sfn`, swapped by basename per target), then probes `trust_store_default_paths()`; `SAILFIN_TLS_CAFILE` is honoured first and deliberately, because it is the override the OpenSSL-backed `runtime/sfn/platform/tls.sfn` already reads, so a program configured against today's stack keeps its custom CA when SFN-341 swaps those bodies onto the native one instead of silently falling back to the public bundle. **Platform trust store (SFN-808):** on Windows, `sfn_cert_roots_blob()` enumerates the system `ROOT` certificate store through Crypt32 (`CertOpenSystemStoreA`/`CertEnumCertificatesInStore`/`CertFreeCertificateContext`/`CertCloseStore`, `-lcrypt32` linked) and hands back raw DER in one self-describing blob, decoded through `trust_store_from_der_blocks`; a store enumerated this way reports `source = "windows-system-root-store"`. This compiles, emits valid LLVM IR for a Windows target, and is pinned by unit/e2e tests, but has **not been executed on a native Windows host** — the dev container is Linux-only — so per the project's Stage1 bar it is implemented and IR-verified, not host-validated. It reaches a Windows binary only through `target_condition_runtime_sfn_sources`, so it applies to programs the driver builds for a Windows target; `cert_roots.sfn` is excluded from the hand-rolled `ci-cross-windows` `RUNTIME_MODS` loop that produces the RELEASED Windows seed, where `@sfn_cert_roots_blob` still resolves to the null stub in `runtime/ir/windows_stubs.ll` — so the shipped `sfn.exe` itself keeps the `SAILFIN_TLS_CAFILE` requirement until that bridge learns to stage a capsule dependency (the same carry as `@sfn_rand_fill`); **macOS caveat, unchanged by SFN-808:** the real macOS system trust store is the Keychain, not a file, and is not read by this path (the POSIX leg of `sfn_cert_roots_blob()` returns null on macOS, meaning "no enumerable platform store", routing straight to the path probe below); `/etc/ssl/cert.pem` is probed and exists on macOS but does not reflect Keychain trust decisions (user-added or administratively-revoked anchors are invisible) — a caller needing Keychain fidelity must supply anchors via `trust_store_from_pem`; a Security.framework binding is outside SFEP-0048's chosen cut. **The CA-bundle path probe accepts a real bundle as of SFN-807:** a trust store may declare up to 512 PEM blocks (`_trust_store_max_blocks()`, clamped by `pem.sfn`'s own 4096 ceiling), raised from the generic 16-block wire-chain cap that had discarded every real bundle outright — the 17th block failed the *whole* file rather than truncating it — and the per-block body decode is linear rather than quadratic, so a stock 152-certificate Ubuntu bundle loads at `ok: true, anchors: 152` in ~94 ms instead of leaking ~193 MB per load. `x509.sfn` gained three fields on `X509Certificate` so a signature can be checked at all — `signature_algorithm_outer`, `tbs_der` (the exact signed byte range), `signature_value` — exposed, never enforced there; SFN-824 added two more, `signature_algorithm_params: int[]` and `signature_algorithm_params_outer: int[]`, retaining each signatureAlgorithm's DER `parameters` verbatim (previously stepped over and discarded) so `x509_verify.sfn` can decode `RSASSA-PSS-params` — opaque to `x509.sfn` like the other three, which still makes no trust decision. Tests: `capsules/sfn/crypto/tests/x509_verify_test.sfn` (60, was 32) and `trust_store_test.sfn` (12), fixtures real OpenSSL 3.6.3-generated certificates cross-checked with `openssl verify` — Ed25519/ECDSA-P256/ECDSA-P384/RSA-2048 three-cert chains, a 3-deep chain, a non-CA issuer, a pathlen:0 root over two intermediates, an intermediate expiring inside an otherwise-current chain, the live `example.com` chain verified offline against its real P-384 anchor (SFN-811), a P-521/ecdsa-with-SHA512 chain for the unsupported-algorithm path, a clientAuth-only leaf, and, since SFN-824, 8 RSASSA-PSS fixtures generated with OpenSSL 3.0.13 rather than 3.6.3 — SHA-256, SHA-384, salt-length-20 taken by the RFC-default omission, an explicit salt-64 encoding, MGF1-SHA-384-under-SHA-256, and byte-level splices for absent parameters and a tampered signature (the last two synthetic, since no signer emits them). **Still not done:** none of this is wired into `runtime/sfn/platform/tls.sfn` (still OpenSSL-backed, SFN-341); RFC 5280 §6.1.3(f) is enforced at every position: a certificate asserting a **critical** extension outside the recognised set (basicConstraints, keyUsage, extendedKeyUsage, subjectAltName, nameConstraints — exactly what this module acts on) rejects the chain rather than being processed with that extension ignored; critical `policyConstraints`/`inhibitAnyPolicy` remain outside that set and still reject as `unrecognized-critical-extension`, and non-critical unrecognised extensions besides nameConstraints are ignored as RFC 5280 §4.2 permits. **`nameConstraints` (2.5.29.30, SFN-765, RFC 5280 §4.2.1.10)** is now parsed and enforced per-chain — not merely refused as an unrecognised critical extension — closing the hole where a technically-constrained sub-CA's constraint was previously never evaluated: `x509.sfn` decodes `permittedSubtrees`/`excludedSubtrees` for the dNSName and iPAddress GeneralName forms only; every other form (directoryName, rfc822Name, otherName, ...) in either list rejects the whole chain with `name-constraint-unsupported`, critical or not — silently ignoring an unimplemented form in `excludedSubtrees` would be the fail-open version of this bug. `x509_verify_chain` checks excluded subtrees first and unconditionally, checks permitted subtrees only for a form the issuer actually asserts, and applies both against every certificate already accepted below the issuer being evaluated (per-chain, not just the certificate it directly signed); a SAN wildcard label (`*.corp.example`) is honoured when testing an excluded subtree and rejected when testing a permitted one, since a wildcard can resolve into an excluded name but must not buy permitted coverage it was never granted; a leaf asserting its own `nameConstraints` is rejected outright, since RFC 5280 permits the extension only in CA certificates. An encoded `GeneralSubtree` `minimum` or `maximum` is a parse failure — DER's default-encoding rule already forbids an encoded `minimum` of 0, so either field's mere presence is non-conforming. **`ok: true` is a path result, not an authentication result** — it does not match a hostname (`x509_hostname_matches` is a separate call a TLS caller still owes), does not check revocation, and enforces extendedKeyUsage on the leaf only rather than nested down the path. No OCSP/CRL/revocation, no client-cert/mTLS; pinning a self-signed end-entity certificate is a distinct trust model and is not implemented — an anchor must assert basicConstraints CA:TRUE, which `openssl req -x509` supplies by default; one deliberate strictness beyond RFC 5280 — §6.1.4 excludes *self-issued* intermediates (the CA key-rollover shape) from the pathLenConstraint count and this implementation counts every intermediate, so a path padded with a self-issued CA can be rejected where the RFC would admit it; the deviation is one-directional (it can only reject a chain, never accept one) and is left in place rather than loosened without a fixture exercising the rollover shape; nameConstraints enforcement (SFN-765, below) makes the identical deliberate choice for the same reason — the same self-issued carve-out is not implemented there either, so a self-issued intermediate's own SAN is checked against every governing ancestor's constraints rather than exempted, which again can only reject a chain the RFC would admit, never accept one it would reject; leaf `keyUsage` is likewise parsed but not enforced — the bit that matters depends on the negotiated key exchange, which is the handshake's concern rather than the path validator's, and CA `keyCertSign` *is* enforced; RSASSA-PSS certificate signatures are now accepted, restricted to the MGF1-SHA-256/salt-32 and MGF1-SHA-384/salt-48 profiles above (SFN-824) — a PSS-only SPKI algorithm OID (RFC 4055 §3.3) on the issuer key is still not accepted, so the issuer key must be `rsaEncryption`. Capsule version 0.25.0 → 0.26.0; `[capabilities] required` stays `[]` (the `fs.*`/`env.*` globals are compiler-provided, following the `random_bytes`/`![rand]` precedent of the effect living on the function, not the manifest). **AES-128-GCM and AES-256-GCM AEAD** (SP 800-38D, SFN-339, design gate `docs/proposals/design-notes/sfn-339-aes-gcm-strategy.md`, which withdrew SFEP-0048 §6.3's deferral) — `aes_gcm_seal(key, nonce, aad, plaintext) -> int[]` (ciphertext‖tag, `[]` fail-closed) and `aes_gcm_open(key, nonce, aad, ciphertext_with_tag) -> Result<int[], string>`, plus `aes_encrypt_block`/`aes_ctr_xor` and an `aead_*` dispatch registry, all re-exported from `src/mod.sfn`; five new modules `aes_sbox.sfn`, `aes.sfn`, `ghash.sfn`, `aead_aes_gcm.sfn`, `aead.sfn`. 96-bit nonces only (RFC 8446 §5.3's shape; a general-length IV would need `J0 = GHASH_H(IV)` and nothing here needs it) and a full 16-byte tag, compared with `ct_eq_bytes` before any decryption. **Constant-time by construction, and table-free including the key schedule:** the S-box is `affine(x^254)` over GF(2^8) computed bitsliced across 32 byte-lanes — not the Boyar–Peralta circuit, which the design gate §3 rejected as un-sourceable rather than as wrong — and GHASH multiplies by masked-integer carryless multiplication rather than an `H`-indexed window table, since recovering `H` yields tag forgery. No lookup table and no branch or array index dependent on the key, plaintext, or `H` exists in any of these modules; the one data-dependent branch, `_inc32`'s carry early-return, is on the *counter*, public only because of the 96-bit-nonce restriction — a coupling recorded on the function so general-IV support cannot silently break it. No automated constant-time verification (ct-verif, dudect) is run; the property is established by construction and review, per design gate §8. Vectors: FIPS-197 C.1/C.3 and A.1, SP 800-38A CTR F.5.1/F.5.5, and SP 800-38D GCM test cases 1, 2, 3, 4, 13, 14, 16; the S-box is additionally verified over **all 256 inputs** against an independent scalar oracle (branching shift-and-xor GF multiply, square-and-multiply exponentiation) and asserted to be a permutation, and `_clmul32(4294967295, 4294967295) == 6148914691236517205` pins the design note's 0.813-bit i64 headroom at the exact worst case (`compiler/capsules/codegen-llvm/src/` emits no `nsw`/`nuw`, so a violation wraps and fails that KAT rather than being UB). 52 tests across `aes_sbox_test.sfn`, `aes_test.sfn`, `ghash_test.sfn`, `aead_aes_gcm_test.sfn`, `aead_test.sfn`. **Measured throughput ceiling (capsule primitive) — this is an interop primitive, not a bulk-transfer one.** AES-128-GCM seal measures **0.37 MB/s at `-O0`** (`capsules/sfn/crypto/tests/aes_gcm_throughput_test.sfn`) and **1.0 MB/s at `-O2`** (`benchmarks/runtime/aes_gcm_seal_bench.sfn`), against ChaCha20-Poly1305 in the same capsule and representation at **6.4 MB/s `-O2`** (`benchmarks/runtime/chacha20_poly1305_seal_bench.sfn`, added alongside so the comparison is measured rather than extrapolated). The 6.4× ratio matches the design note's ~193-vs-~30 ops/byte model exactly; its *absolute* ~36 MB/s estimate was wrong by ~36× because it scaled from SFN-768's 233 MB/s `*u8` pointer-idiom **runtime** record layer instead of the ~5 MB/s capsule `int[]` oracle (design gate §3.2 records the correction). So AES-GCM is now **negotiable**, which clears the RFC 8446 §9.1 interop blocker SFN-339 exists for. SFN-817 ports it to the `*u8` runtime record layer and measures that path directly — see `platform/tls_record.sfn` below for the result, which is **not** ~20× under the bar this note describes, though it still does not clear it. **Not shipped here (as of SFN-339):** no TLS negotiation change and no runtime change — `runtime/sfn/platform/tls.sfn` offered ChaCha20-Poly1305 only, so the native client could not yet *use* AES-GCM; SFN-814 has since wired AES-128-GCM into both the `ClientHello` offer and `runtime/sfn/platform/tls.sfn`'s per-suite record dispatch (above); no AES-192 (deliberate, design gate §7); no `TLS_AES_256_GCM_SHA384` cipher suite (it needs `hash_len = 48` threaded through `tls13_handshake.sfn`, whose `_hash_len()` returns a constant 32, and there is no RFC 8448 SHA-384 trace to check it against — the AES-256 *AEAD* does ship); no AES-NI (it would need a `seed-blocker` intrinsic family and a queued seed cut, since `compiler/capsule.toml` declares `sfn/crypto` so the **pinned seed** compiles it — design gate §6 — and it would be a pure optimization over an already-shipped software path). Zero seed dependency. Capsule version 0.28.1 → 0.29.0; `[capabilities] required` stays `[]` |
| `sfn/math` | `"math"` | Shipped | None | abs, min/max, clamp, floor/ceil/round, pow, sum/mean |
| `sfn/path` | `"path"` | Shipped | None | Path join, dirname, basename, ext, normalize |
| `sfn/toml` | `"toml"` | Shipped | None | TOML v1.0 parsing, serialization, dotted-path access |
| `sfn/fs` | `"fs"` | Shipped | `io` | File read/write/append, exists, mkdir, read_dir, perms, mkdtemp, is_directory, symlink, read_link |
| `sfn/os` | `"os"` | Shipped | `clock`, `io` | Env vars, home dir, exec, exit; typed `Env` (`env_empty`/`env_set`/`env_from_current`) and `run_capture(args, env, cwd)`; child-process control over a `ProcessHandle` — `spawn_with_env`, framed stdout line/chunk reads plus the stderr chunk twin, `handle_stdout_fd`/`handle_stderr_fd` and the `*_at_eof` predicates for `io.poll_any` demultiplexing, and `handle_kill` (SIGKILL). `drain_to_exit(h, deadline_ms)` pumps both streams to exit under an optional wall-clock deadline and reports `timed_out` as a boolean rather than remapping the exit code (a SIGKILL wait yields 137, indistinguishable from an OOM kill); `run_bounded` pairs it with `spawn_with_env`. `![clock]` is scoped to the deadline paths |
| `sfn/log` | `"log"` | Shipped | `io`, `clock` | Structured leveled logging with named loggers |
| `sfn/time` | `"time"` | Shipped | `clock` | Sleep, monotonic timing/elapsed, and fallible signed Unix epoch milliseconds via `unix_millis() -> Result<int, string> ![clock]`; realtime reads ship on Linux x86-64, Linux arm64, macOS arm64, and Windows x86-64, fail closed on provider error, and may move in either direction after clock adjustment |
| `sfn/cli` | `"cli"` | Shipped | `io` | Arg parsing, subcommands, help generation, TTY-aware ANSI terminal styling with `NO_COLOR` and `auto|always|never` policy |
| `sfn/test` | `"test"` | Partial | None (pure tier) / `io`, `clock` | Assertions: legacy `assert_*` (`![io]`), `pure_assert_*`, free-function `expect_*` tier, snapshot tier (#977). Fluent `expect(x).to_be(y)` deferred on generic monomorphization + cross-module method-dispatch ABI. Process-lifetime *structure* (SFEP-0010 §3.2, `src/process_control.sfn`), now scoped to what `sfn/os` has no opinion about: `start_background`/`stop_background`/`with_background` scope a blocking server's lifetime over a `Background { handle: ProcessHandle, label }`, killed+reaped on scope exit including the throwing path (`![clock, io]`); `wait_until` polls readiness in-process; `describe_outcome` renders a `ProcessDrain`. Bounded running (`run_bounded`, deadline, stdout/stderr demux) moved to `sfn/os` — this capsule deliberately does not wrap it, to avoid a second `run_bounded` at call sites importing both; `run_bounded_in`/`run_bounded_stdin`/`ChildOutcome` are retired. `os::ProcessDrain.timed_out` disambiguates a deadline kill from exit code `137`. Capsule `required` capabilities widened `["io"]` → `["clock", "io"]` for this addition (ceiling on the capsule's own functions only, not inherited by consumers). **Host tool probing (SFN-840, `src/tool_probe.sfn`):** `tool_present(tool)` and `first_present_tool(candidates)` answer "is this external tool on `PATH`" without spawning a shell, replacing the `sh -c "command -v <tool>"` probe that 15 e2e files each carried privately (22 sites, none of which worked on a native Windows host). `tool_present` is a faithful `command -v` — true when the binary resolved and executed, *including* a tool that runs but rejects `--version` — because the hand-rolled `exit == 0` form it replaces is stricter than `command -v` and silently skips coverage on such a host. Guarded by the zero-tolerance ratchet `compiler/tests/e2e/no_shell_tool_probe_test.sfn`. The `timeout` argv vehicle and its skip-when-absent branches are untouched and tracked separately (SFN-889) |
| `sfn/bench` | `"sfn/bench"` | Shipped | `clock`, `io` | Microbenchmark harness (SFN-62), the counterpart to `sfn/test`: auto-calibrating `benchmark(name, body)`, fixed-count `benchmark_fixed(name, ops, body)`, `keep(x)` black-box sink. Each call emits one `bench-record/1 ops=… inner_ms=… name=…` line that `sfn bench`'s runtime mode parses. Reference: `site/src/content/docs/docs/reference/bench.md` |
| `sfn/http` | `"sfn/http"` | Partial (Waves 1–4 shipped) | `net`, `io` | GET/POST client wrappers; typed `fetch(method, url, headers, body) -> Response` client surfacing status + headers (`sfn_http_request_raw`); pure-Sailfin wire layer (parse/serialize/accessors, request + response parsers); typed HTTP/1.1 `serve` on the M4 runtime (`sfn_serve_framed`); POST/PUT bodies drained via `Content-Length` (1 MiB cap). real DNS host resolution via `getaddrinfo` (#1707, shared with `sfn/net`). client decodes `Transfer-Encoding: chunked` responses on the get/post/download path, length-tracked (#1708). HTTP/1.1 keep-alive connection reuse on the server loop + a native single-connection-reuse client (`sfn_http_conn_open`/`_send`/`_close`) (#1711). runtime TLS ships end-to-end on the native TLS 1.3 stack (SFEP-0036/SFEP-0048 Implemented, SFN-341, epic #1540 B1; `runtime/sfn/platform/tls.sfn` over `sfn/crypto`, no OpenSSL): outbound client `https://` on `http.*`/capsule `get`/`post`, typed `fetch`, and keep-alive client connections with peer-chain + hostname verification against `sfn/crypto`'s trust store (`trust_store_load()`, `capsules/sfn/crypto/src/trust_store.sfn`: `SAILFIN_TLS_CAFILE`/`SSL_CERT_FILE` override, then the platform trust store, then a CA-bundle path probe accepting up to 512 PEM blocks (SFN-807), then fail-closed — SFN-808), verify-on by default and fail-closed on a bad/untrusted cert (#1784); inbound TLS termination in the `serve` accept loop via the low-level `sfn_serve_tls(handler, port, cert, key)` runtime entry (#1783) and the typed `sfn/http` `serve_tls(handler: fn(Request) -> Response, port, cert, key)` wrapper backed by `sfn_serve_framed_tls` (#1933). e2e coverage: `runtime_tls_https_client_test.sfn`, `runtime_tls_verify_failure_test.sfn`, `serve_tls_loopback_test.sfn`, `tls_loopback_test.sfn`. TLS-scoped limits: mTLS/client-cert request and OCSP/CRL are post-1.0; Windows system-root-store discovery (SFN-808, see `sfn/crypto` below) is implemented and IR-verified but has not been run on a native Windows host (the dev container is Linux-only); macOS Keychain discovery is unchanged and stays post-1.0. Other v0 limits: blocking/single-process, no chunked *request* decode on `serve`; routing pending. (#1321; #1324 Content-Length drain; #1325 typed client; #1707 DNS; #1708 chunked client decode; #1711 keep-alive; #1540 B1 client TLS) |
| `sfn/net` | `"net"` | Partial (TCP client + server) | `net`, `io` | Real TCP socket I/O via `runtime/sfn/adapters/net.sfn`: client `connect`/`write_all`/`read_all`/`read_bytes`/`close`, server `listen`/`accept`/`close_listener` (loopback round-trip tested in-process), and DNS `resolve` via libc `getaddrinfo` (first IPv4/A record). Host resolution across the client is `localhost`, numeric dotted-quad IPv4, and real DNS. v0 limits: text bodies (NUL-terminated), no TLS at the raw-socket layer (TLS lives one layer up in `sfn/http` via `runtime/sfn/platform/tls.sfn`, SFEP-0036), IPv4-only DNS (no AAAA/caching/happy-eyeballs). UDP (`udp_bind`/`send_to`/`recv_from`) still stubbed (#1582; DNS #1707; epic #1540 B6/B2) |
| `sfn/sync` | `"sync"` | Reserved name, no exports | None | Concurrency is language-level, not capsule surface: use `routine`, `spawn`/`await`, `parallel`, `channel`, `Task<T>`/`join_all` directly. **No capsule wrapper is planned.** A real `Mutex`/`RwLock`/`Semaphore` library is buildable (an ordinary struct is not an owned type, so the spawn-capture move rule never fires on it) but not safely reclaimable — the nursery registry records bare handles with a hardcoded channel destructor, and `sfn_rc_sfn_release` frees at refcount zero without invoking its stored `drop_fn`. The capability both gaps need — an indirect call through a stored function pointer — already ships; what remains is wiring it into the nursery registry and `rc.sfn`. Scope and verdicts: SFEP-0063 |
| `sfn/tensor` | `"tensor"` | Shipped (CPU) | `gpu` (manifest ceiling; unused by code) | Tensor ops, matmul, transpose. CPU-only and effect-free by design — no function carries `![gpu]`, and it does not depend on `sfn/device`. Device dispatch is the separate, capability-gated `sfn/device` surface (SFN-428). The manifest's `required = ["gpu"]` is a permission ceiling, not a requirement |
| `sfn/layers` | `"layers"` | Shipped (CPU) | `gpu` (manifest ceiling; unused by code) | Linear layers, ReLU, sequential models. CPU-only and effect-free; see the `sfn/tensor` note |
| `sfn/nn` | `"nn"` | Shipped (CPU) | `gpu` (manifest ceiling; unused by code) | Activations, normalization, argmax, one_hot. CPU-only and effect-free; see the `sfn/tensor` note |
| `sfn/device` | `"sfn/device"` | Shipped (v0, CPU reference backend) | `gpu` | The capability-gated device-dispatch boundary (SFN-428, SFEP-0052 §3.2). `backends()` / `active_backend()` / `has_accelerator()` are effect-free queries; `matmul_f64` and `synchronize` carry `![gpu]`. v0 scope: one dense f64 matmul entry point and a barrier, executed by a CPU reference kernel. `has_accelerator()` is `false` in every current build — there is no GPU backend in tree |
| `sfn/losses` | `"losses"` | Shipped | None | MSE, MAE, Huber, hinge |

## Runtime (Current)

- The binary's entry point is the Sailfin-emitted `@main` (M5, #451); no C
  code participates in startup. **`runtime/native/` is deleted (#822).** The
  runtime capsule root is now `runtime/` (manifest at `runtime/capsule.toml`;
  `kind = "runtime"`, `name = "sfn/runtime-native"`). All Sailfin runtime
  sources live under `runtime/sfn/` and `runtime/prelude.sfn`; `ll-sources` is
  now empty. `runtime/ir/windows_stubs.ll` (moved from `runtime/native/ir/`)
  is used only by the `ci-cross-windows` Makefile bridge.
- The native CLI locates a bundled runtime next to the executable
  (`SAILFIN_RUNTIME_ROOT` override). No Python shims remain.
- String concat chains lower to `string_append` (realloc in-place extend)
  instead of `string_concat` (malloc+copy) for intermediates — a pure
  lowering optimization.
- **Concurrency runtime (v0, M4):** `runtime/sfn/concurrency/` ships the
  worker-pool scheduler with the task lifecycle
  (`sfn_task_create/run/join/destroy`, #1089), the `sfn_spawn` / `sfn_await`
  surface (#1090), channels, the `sfn_parallel` fan-out/join combinator
  (#1093), and the structured-concurrency **nursery** (`nursery.sfn`,
  `sfn_nursery_enter/register/exit`, #1181) that `routine { }` lowers to.
  Language-construct lowering: `routine` → nursery scope (#1181); `channel`
  end-to-end (#1085/#1091); `spawn`/`await` value-surface lowering is #1084.
  The auto-detected pool floors at **two workers**
  (`sfn_scheduler_resolve_thread_count`): a producer/consumer pair sharing a
  bounded channel needs both tasks on their own thread or the fixed pool
  deadlocks (#1474). The macOS core-detection bug (Darwin's `_SC_NPROCESSORS_ONLN`
  is 58, not the Linux 84) is **fixed** via the emit-time
  `sailfin_intrinsic_sc_nprocessors_onln` sentinel (#1480/#1498/#1501), which
  folds to the correct per-target `i32` immediate at emit time.
  Coverage: `channel_producer_consumer_exec_test.sfn`,
  `parallel_concurrent_execution_test.sfn`,
  `spawn_await_concurrent_execution_test.sfn`, `serve_loopback_test.sfn`, and
  the whole-program ASAN-interleave gate over the moved-OwnedBuf surface
  (`concurrency_ownedbuf_asan_interleave_test.sfn`, #1567). Design:
  `docs/proposals/0025-native-runtime-architecture.md` §3.7.

### Runtime Migration (C → Sailfin)

Design and subsystem detail: `docs/proposals/0025-native-runtime-architecture.md`
(SFEP-0025). This table is the live migration record — one row per migration
unit; history in the linked issues.

| Unit | Status | Notes |
|---|---|---|
| `extern fn` declarations | **Shipped** | Parser + typecheck (`E0801`–`E0805` C-ABI validation) + LLVM `declare` emission |
| `platform/libc.sfn` skeleton | **Shipped** (2026-05-01) | 12 libc declarations; extended with stat/dirent externs (#814) |
| `platform/pthread.sfn` / `posix.sfn` / `net.sfn` skeletons | **Shipped** (2026-05-02) | Richer C-ABI shapes; seeds for scheduler, process, http modules |
| `io.sfn` (`sfn_write_fd`) | **Shipped** (2026-05-04) | First Sailfin-native service wrapper over an imported extern |
| `io.read_fd` / `io.read_line` stdin builtins | **Shipped** (#1579, epic #1540 Track A gap A2; typed returns SFN-154) | `io.read_fd(fd, n) -> OwnedBuf` (owned, length-explicit, binary-safe; `len` is the byte count from one `read(2)` of ≤ n bytes; empty/EOF/error/`n<=0` yields the canonical `{0,0,0,0}`) and `io.read_line(fd) -> string?` (byte-at-a-time up to the next newline, no over-read; `null` means immediate EOF, `Some("")` means a blank line) over the `read` extern in `runtime/sfn/io.sfn`; registered in `runtime_helpers.sfn` + declare-tracked in `lowering_helpers.sfn`, mirroring `io.poll_readable` (#1580). Lets a process read its own fd 0 (e.g. the MCP proxy's JSON-RPC frames). Effect-gated `![io]` (E0400 on a non-`![io]` caller). Retiring `login.sfn`'s `sh -c "head -1"` workaround still waits on a seed cut: the compiler is seed-compiled, so a compiler-source consumer must wait for a seed cut that includes the builtin. Pinned by `compiler/tests/integration/io_read_fd_test.sfn` (including EOF-null and blank-line cases) + `compiler/tests/e2e/io_read_fd_effect_test.sfn` |
| `io.poll_any` multi-fd readiness builtin | **Shipped** (SFN-155, epic #1540 Track A gap A3) | `io.poll_any(fds: int[], timeout_ms) -> int` — the multi-fd companion to `io.poll_readable`: waits on every fd in `fds` with a single `poll(2)` and returns which fd is ready (`>= 0`), or `-1` for timeout / empty list / error, so a stdio forwarder can wait on `{own stdin, child stdout, child stderr}` together without deadlock. Return shape is a sentinel `int` (`-1` == none), not an optional `fd?` — `int?` optional value-extraction isn't yet supported by the compiler (only `== null` round-trips). Sailfin-native body in `runtime/sfn/process.sfn` (`sfn_io_poll_any`); Windows stub in `runtime/sfn/platform/process_windows.sfn` returns `-1`. Descriptor in `compiler/capsules/codegen-llvm/src/runtime_helpers/registry_process.sfn` (`io.poll_any`); declare-tracked in `lowering_helpers.sfn`. Pinned by `compiler/tests/integration/io_poll_any_test.sfn` (pipe-driven, `![io]`, 5 cases) |
| Sleep: call-site routing → `@sfn_sleep` over `nanosleep` → ms semantics | **Shipped** (#397, #307) | `runtime/sfn/clock.sfn` is the sole definition site; `sleep(ms)` end-to-end |
| Clock readers (`sfn_clock_monotonic_nanos`, `sfn_clock_millis`) | **Shipped** (#878, #819) | M3.3 |
| Fallible Unix epoch milliseconds (`sfn_clock_unix_millis`) | **Shipped** (SFN-623) | `sfn/time::unix_millis() -> Result<int, string> ![clock]` reads the vendor realtime clock exactly once into an out-parameter-backed runtime ABI, returns signed completed milliseconds since the Unix epoch, and reports provider failure separately from the value. The Linux x86-64/Linux arm64/macOS arm64/Windows x86-64 paths keep the existing `clock_gettime` vendor seam (including libc/vDSO where available); realtime adjustment may move readings backward or forward, while all existing monotonic APIs retain their prior semantics |
| `exe_path` host-aware intrinsic + `exec.sfn` cutover | **Shipped** (#967, #968) | Second intrinsic-registry sentinel after errno (#877/#901) |
| Darwin process memory-footprint intrinsic | **Shipped** (SFN-607, SFEP-0022) | Compiler-only `sailfin_intrinsic_mem_footprint() -> i64 ![io]` seed predecessor for SFN-66. Darwin emission calls `getpid` + `proc_pid_rusage(RUSAGE_INFO_V2)` and reads `ri_phys_footprint`, returning zero on observation failure; Linux and Windows fold to zero without Darwin symbols. Pinned by `compiler/tests/e2e/mem_footprint_intrinsic_test.sfn`; no runtime budget/monitor consumer ships in this unit |
| `kind = "runtime"` capsule schema + `sfn-sources` link-time consumer | **Shipped** (#308) | Env-var debug toggles replaced flag-file IPC (#311, #312) |
| Arena allocator (`memory/arena.sfn`) | **Shipped** (M2.1 #394, M2.2 #477) | Real page-chain bump allocator; mark/rewind (#927). **Thread-safe (SFN-558):** the default arena is now `thread_local` (each thread privately owns its `Arena`), closing a data race reachable from `routine`/`spawn`/`parallel`; leaks until process exit by design, alloc-fast-path cost +4–7% (peak memory unchanged). Design note: `docs/proposals/design-notes/sfn-558-arena-thread-safety.md`; regression coverage: `compiler/tests/e2e/arena_concurrent_alloc_test.sfn` |
| In-loop arena reclamation (`llvm/lowering/instructions_loops.sfn`, `_for.sfn`, `_for_range.sfn`) | **Shipped** (#1514, #1515, epic #1513, 2026-06-23) | The emitter wraps a loop body in `sfn_arena_sfn_mark` / `sfn_arena_sfn_rewind` so per-iteration arena structs are reclaimed each pass instead of growing RSS linearly. **Scope:** non-escaping loop-local arena allocations only — generic `loop` (#1514), `for x in arr`, and `for i in a..b` (#1515). Gated by `loop_body_rewind_eligible` (`instructions_helpers.sfn`): fires only when the body's lowered IR allocates via a real `@sfn_alloc_struct`, every body-scope heap local is an all-primitive-scalar struct still `allocation_kind=="arena"` (not promoted to `rc`, consumed, or loop-carried into an ancestor binding), and the body has no other call/store that could grow an ancestor container in the arena (which the rewind would free → use-after-free). `continue`/`break`/`return` paths skip the rewind — a safe missed reclamation, never a dangling pointer. Measured (single-loop form, the #1514/#1515 shipping measurement): 30M non-escaping `Cell`s drop from ~691 MB (1.01× the raw allocation size) to a **flat ~1.7 MB** peak. The migrated `benchmarks/runtime/arena_alloc_bench` allocates inside a directly-timed inner loop (30,000 batches × 1,000) so the `sfn/bench` harness still exercises the rewind — peak RSS stays flat (~6 MB, bounded by the batch), not growing with the total allocation count. Strategy B (scalar-replacement / stack-alloca) and nested-loop mark stacking are post-1.0. |
| Phase-scoped arena reclamation (`compiler/src/arena_relocate.sfn`) | **Shipped** (SFEP-0043, branch `claude/reduce-peak-rss-arena-phase-rewind`) | Takes an arena mark before `parse_program`; after emit produces `native_lines`, joins them to a single flat string via `lines_to_native_text`, relocates that string's data buffer to malloc'd memory via `relocate_string_to_heap` (`compiler/src/arena_relocate.sfn`), rewinds the arena to reclaim the entire AST/typecheck/emit region, lowers via the flat-text artifact entry `lower_native_text_to_llvm_artifact[_with_context]`, then frees the heap buffer. `import_asm_paths` is allocated below the mark and survives natively. Gated by `SAILFIN_ARENA_PHASE_REWIND` (default ON). Byte-identical `.ll` output confirmed by `compiler/tests/e2e/arena_phase_rewind_ll_identity_test.sfn`; self-hosts clean, no seed cut. **Measured (199 modules, rewind OFF vs ON):** peak RSS 1,211 MB → 1,009 MB (−16.7%); sum of per-module peak RSS 72.4 GB → 56.1 GB (−22.5%); mean 364 MB → 282 MB; wall time neutral (−0.5%). Global win across all pipeline stages (typecheck −26%, parser −28%, effect_checker −27%, lowering −17–23%). Known regressions: `capsule_resolver` +18%, `core_literals_lowering` +8% — front-half modules where copy exceeds reclaimed garbage; neither sets the new peak. |
| Atomic refcounting (`memory/rc.sfn`) | **Shipped** (M2.3 #395) | drop_fn invocation deferred to destructor synthesis (M2.4/M2.6) |
| Memory primitives (`memory/mem.sfn`) | **Shipped** (#927) | `get_field`/`copy_bytes`/`bounds_check`/`free`; carries `seed-blocker` |
| Process spawning (`process.sfn`) | **Shipped** (M2.9 #405) | `posix_spawnp` + `waitpid`; framed stdout/stderr consumption fails closed on allocation failure by dropping the unread stash, so drain-to-EOF loops make progress and never expose uncompacted bytes as valid (SFN-505; mirrored by `platform/process_windows.sfn`); same-generation compiler resolution requires an executable candidate so a sibling `sailfin` cache directory cannot be passed to `run_capture` on native Linux (SFN-579); the Windows process family lives in `platform/process_windows.sfn` |
| Type-metadata registry (`type_meta.sfn`) | **Shipped** (M2.10 #402) | Descriptor globals + module-init ctors; value-side tagging deferred |
| Prelude facade flipped to `sfn_*` symbols | **M2 closed** (M2.12, #407/#408) | Every M2-replaced call lands on the canonical `sfn_*` symbol; M3 lifts the remaining C trampolines |
| Filesystem adapter wave 1a (`adapters/filesystem.sfn`) | **Shipped** (M3.1a #814) | read/write/append; `fs.appendFile` reports `false` on open, short-write, or flush failure without deleting pre-existing content (SFN-577); wave 1b (dir ops, #815) next; bulk C deletion at M3.9 after a seed cut |
| `sfn_fs_list_dir` host-aware enumeration (`adapters/filesystem.sfn`) | **Shipped** (SFN-374, epic #1485 M5) | `sfn_fs_list_dir` delegates directory enumeration to the `sailfin_intrinsic_fs_list_dir` sentinel instead of a hardcoded POSIX `opendir`/`readdir` loop: the POSIX leg keeps `opendir`/`readdir`/`closedir` (name at `dirent + _fs_dirent_dname_offset()`), the Windows leg walks `FindFirstFileA`/`FindNextFileA`/`FindClose` reading `WIN32_FIND_DATAA.cFileName` — fixing the 4096 source-enumeration cap in `enumerate_binary_capsule_sources` on native Windows. The sentinel returns unsorted; the wrapper preserves the empty-path → `"."` normalization and `strcmp`-sorts via `_fs_sort_str_array`. Consumer half of the SFN-51 seed-gated split (sentinel capability: SFN-51 / PR #2355, in the pinned seed since `v0.8.0`); POSIX `list_dir` behavior unchanged. Pinned by `compiler/tests/e2e/fs_list_dir_intrinsic_test.sfn` |
| aarch64-Linux host layout constants | **Shipped** (SFN-471, SFEP-0056 §3.2–3.3) | LLVM lowering now resolves a non-shelling host-arch dimension via `SAILFIN_TARGET_ARCH` or the `/lib/ld-linux-aarch64.so.1` marker, defaulting to `x86_64`. The `sailfin_intrinsic_fs_get_perms` sentinel bakes `struct stat.st_mode` offset 16 for Linux+aarch64 while preserving 24 on Linux+x86_64 and 4 on Darwin. The `jmp_buf` reserve is 512 bytes on both paths: the heap-backed exception frame in `runtime/sfn/exception.sfn` (SFN-471) and, since SFN-644, the three compiler-emitted stack `jmp_buf` allocas in `llvm/lowering/instructions_try.sfn`, `llvm/lowering/emission.sfn`, and `llvm/lowering/lowering_core/test_harness.sfn` — the ones compiler-emitted `try` actually executes, and which stayed 256 bytes (short of glibc aarch64's ~312) until SFN-644 — covering glibc aarch64 while leaving try/throw behavior unchanged. The glibc-common errno locator, `CLOCK_MONOTONIC`, `_SC_NPROCESSORS_ONLN`, and 160-byte `struct stat` reserve remain arch-invariant. Pinned by `compiler/tests/e2e/st_mode_arch_layout_test.sfn`, `runtime_exception_frames_test.sfn`, and `jmp_buf_alignment_test.sfn` |
| `char_from_code` byte-write primitive | **Shipped** (#874) | Byte 0 unrepresentable until the `SfnString` aggregate flip (M1.A.2); macOS arm64 `char_code` immediate-decode caveat tracked at #1136 |
| Pointer-typed struct fields | **Shipped** (#713) | Layout + stores emit; retires the `i64`-slot workarounds after the next seed cut (`seed-blocker`) |
| Extern return-type defaulting hardened | **Shipped** (#306 Phase A) | Unresolvable callee signatures fail loud instead of emitting malformed IR; Phases B/C deferred |
| Self-applied memory budget (`platform/rlimit.sfn`) | **Shipped** (2026-06-12) | `fn main` (cli_main.sfn) self-applies an 8 GiB `RLIMIT_AS` on Linux at startup, replacing the caller-side `ulimit -v 8388608` ritual + PreToolUse hook. `SAILFIN_MEM_LIMIT=<bytes>` overrides, `unlimited` disables (ASAN escape hatch), inherited external caps always win, `SAILFIN_TRACE_MEM_LIMIT=1` traces. Toolchain-only — compiled user programs are not capped. No-op on macOS/Windows (Linux `/proc` probe gate). Pinned by `compiler/tests/e2e/test_mem_limit_selfcap.sh`. Carried by the pinned seed since 0.7.0-alpha.33, so every toolchain invocation — including the seed during `make compile` — self-caps; CI's step-level `ulimit -v` defense lines were dropped in the same cleanup |
| String accessor family (`string.sfn`) | **Shipped** (#1315, C4 of epic #1308, 2026-06-15) | `sfn_str_byte_at`, `sfn_str_find_byte`, `sfn_str_codepoint`, `sfn_str_grapheme_at`, `sfn_str_grapheme_count` are now real Sailfin bodies (bare emission targets) in `runtime/sfn/string.sfn`; the C namesakes in `sailfin_runtime.c` are `static`. The `_sfn_` infix wrappers for these five are retired. Two C bridge primitives remain: `sfn_str_read_byte` and `sfn_str_grapheme_byte` (seed cannot lower a sub-word `* u8` load; retire with #822). `sfn_str_decode_owned` and `sfn_str_immediate_codepoint` **flipped to trivial Sailfin bodies in #1421** (encoding retired by #1420; header protos deleted). `codepoint`/`grapheme_count` return `f64` to preserve the registry `double` ABI — no `runtime_helpers.sfn` change, no seed cut. Behaviour byte-identical to prior C trampolines. Pinned by `capsules/sfn/strings/tests/strings_test.sfn`. |
| Mechanical string ops (`string.sfn`) | **Shipped** (#1372, C5 of epic #1308, 2026-06-17) | All four — `sfn_str_len` (`string.length`), `sfn_str_eq` (string `==`), `sfn_str_to_number` (`string.to_number`), and `sfn_str_slice` (`substring`) — are now real Sailfin bodies (bare emission targets) in `runtime/sfn/string.sfn`; the C namesakes in `sailfin_runtime.c` are `static`. `len`/`eq`/`to_number` call `sfn_str_immediate_codepoint` (classify) and `sfn_str_decode_owned` (identity pass-through); **both are now trivial Sailfin bodies after #1421** (encoding retired by #1420 — immediate-arms are provably dead, deleted at #822). `len` → bounded libc `strnlen` (16 MiB cap), `eq` → codepoint compare / length + `memcmp` (`_sfn_imm_eq_real` UTF-8 byte compare), `to_number` → ASCII-digit fast path / `strtod`. `slice` clamps `f64` indices and calls `sailfin_runtime_substring_unchecked`. **Two compiler bugs were fixed to enable this:** (1) `core_type_mapping.sfn::map_primitive_type` was missing `f64`/`f32`; seed bump to **0.7.0-alpha.37**. (2) UTF-8 masks use decimal literals (no `0x` hex in lexer). ABI unchanged; all four `sfn_str_*` symbols resolve into `string.o`. `concat`/`append` remain in #1318. Pinned by `capsules/sfn/strings/tests/strings_test.sfn`. |
| Allocating string ops (`string.sfn`) | **Shipped** (#1318, C5 of epic #1308, 2026-06-17) | `sfn_str_concat` (the `string.concat`/`+` emission target) and `sfn_str_append` (no emission site — `native_signature: null`; ported for link-completeness) are now real Sailfin bodies in `runtime/sfn/string.sfn` over the registry's SfnString `{i8*, i64}` ABI; the C namesakes in `sailfin_runtime.c` are `static`. Each `{i8*, i64}` operand splits into a `(data, len)` scalar pair (the `io.sfn` `sfn_getenv` precedent — the only self-host-safe spelling, since an `SfnString`-typed *parameter* hits the aggregate-by-value gap); the body returns a bare `* u8` that the `-> SfnString` return-path coercion re-wraps. `concat` derefs the `SfnArena **` slot once, decodes immediate-codepoint operands via the `sfn_str_decode_owned` bridge before two `memcpy` + NUL, and applies the `SAILFIN_MAX_STRING_CONCAT` limit/overflow gate. The trailing NUL is written with the word read-modify-write `_num_put_byte`, so the arena allocation is 8-aligned and rounded to a multiple of 8 (ABI-invisible). **Reuse-window correction:** the C concat is window-agnostic — the `_concat_reuse_*` globals are vestigial (declared, never read/written) — so the port adds no `_runtime_enter` / reuse-seq bump (the O(n²)/OOM failure mode of the abandoned real-buffer attempt, avoided by construction). The retired `sfn_str_sfn_concat`/`_append` OwnedBuf wrappers had the wrong ABI; `owned_buf_append` and the prelude's presence-only `sfn_str_sfn_concat` import are dropped. ABI unchanged (`runtime_helpers.sfn` not edited); `sfn_str_concat`/`sfn_str_append` now resolve into `string.o`, not the C runtime object (relink gate). Pinned by `compiler/tests/unit/string_concat_immediate_test.sfn` + `capsules/sfn/strings/tests/strings_test.sfn`. |
| Immediate-codepoint encoding retired — producer flip (`string.sfn`) | **Shipped** (#1420, epic #1308, 2026-06-19) | The `(byte << 32)` immediate-codepoint pseudo-pointer encoding is **retired at source**: both producers — `sailfin_runtime_grapheme_at` and `sfn_str_grapheme_byte` — now return a real 1-byte arena/heap buffer on every platform. The Linux-only `#if !defined(__APPLE__)` fast-paths that emitted tagged pointers are deleted; this was already the macOS path since #1136. No immediate-codepoint value can exist at runtime from this point forward. The `_is_immediate_codepoint_string` classifier and ~36 consumer guards in `sailfin_runtime.c` are now **dead code** (no producer feeds them) and retire with the C file deletion at #822. Seed cut to `0.7.0-alpha.39` (bakes the producer flip). |
| Immediate-codepoint bridge flip (`string.sfn`) | **Shipped** (#1421, epic #1308, 2026-06-19) | `sfn_str_immediate_codepoint` and `sfn_str_decode_owned` are now **trivial Sailfin bodies** in `runtime/sfn/string.sfn` (`-> -1` and `-> s` identity respectively); the C definitions and their header prototypes are deleted. Post producer-flip, classification always returns "not an immediate" and decode is the identity. The old `_runtime_enter` concat-reuse bump in the C `decode_owned` is dropped — the `_concat_reuse_*` globals are vestigial (write-only, never read). The remaining immediate-arms in the Sailfin bodies are now provably dead and retire with the `#822` C-file deletion. Relink residual dropped from 9 → 7 across #1419+#1421. |
| `sfn_str_to_cstr` flip + `sfn_str_from_cstr` deleted (`string.sfn`) | **Shipped** (#1422, epic #1308, 2026-06-19) | `sfn_str_to_cstr` (called by `process.sfn` for `execve`/`posix_spawn`) is now a **trivial Sailfin identity body** (`return s`); the C definition is deleted. Post-encoding-teardown every `* u8` is already a real NUL-terminated buffer, so the decode is a no-op. `sfn_str_from_cstr` is **deleted outright** — no caller, no emission row. Relink residual dropped from 7 → 6. Residual-6 remaining C symbols: `sfn_str_read_byte` + `sfn_str_grapheme_byte` (seed cannot lower a sub-word `* u8` load — retire with the SfnString aggregate flip at #822), `sailfin_runtime_string_concat` (legacy 2-arg, ABI-hard, 8 C-internal callers), `sfn_default_arena`, `serve`, `mark_persistent`. |
| Length-aware query-side string ABI (`string.sfn`, `runtime_helpers.sfn`, `core_operands.sfn`) | **Shipped** (#1704, SFEP-0033, 2026-06-26) | The query-side string helpers gained length-aware `*_lv` siblings over the `{i8*, i64}` aggregate so they consume the carried byte length instead of `strnlen` (NUL-scan) — the prerequisite for a sound non-owning `string.slice` (#1454), since an interior view is not NUL-terminated and a `strnlen` consumer over-reads. `sfn_str_eq_lv`/`sfn_str_cmp_lv` (hardcoded `==`/`!=`/`<`/`<=`/`>`/`>=` sites in `core_operands.sfn` now recover `(data, len)` per operand and call the `_lv` symbol; declare-only `string.eq_lv`/`string.cmp_lv` descriptor rows drive the line-scan declare), `sfn_str_codepoint_lv`/`grapheme_count_lv`/`grapheme_at_lv` (descriptor `native_signature` repointed, `parameter_types` flipped to `{i8*, i64}`; `double` C-ABI return preserved). `sfn_str_byte_at`/`find_byte` re-signatured in place (runtime-internal, no descriptor). **`string.length` is deliberately untouched** — aggregate `.length` already reads field 1 directly (fast path), and flipping it would re-enter the `i8*`→`{i8*, i64}` coercion shim (circular dep). The bare `sfn_str_eq`/`sfn_str_cmp`/`codepoint`/`grapheme_*` bodies are kept verbatim as the old-`(i8*, i8*)` ABI trampolines the pinned seed (and `rlimit.sfn`'s extern) still emit during `make compile`, so the whole change self-hosts in one pass with **no seed cut**; a later trampoline-deletion cleanup is the only seed-gated follow-up. Pinned by `compiler/tests/e2e/string_length_aware_lv_test.sfn` (C-harness: non-NUL-terminated interior view honored). |
| NUL-termination at the cstr boundary (`string.sfn`, `process.sfn`, `process_windows.sfn`, `assert.sfn`) | **Shipped** (#1705, SFEP-0025 §3.3, 2026-06-27) | The extern cstr-boundary helpers materialize a real NUL-terminated buffer instead of returning the input pointer unchanged (the #1422 identity body), so a non-NUL-terminated interior view (#1454) handed to a libc call cannot over-read past its slice. `sfn_str_to_cstr` re-signatured to `(s_data: * u8, s_len: i64, arena_slot: * u8) -> * u8` — copies the **carried** `s_len` bytes into the resolved arena (`_sfn_resolve_arena`, `null` slot → the calling thread's default arena, `thread_local` since SFN-558) with a `roundup8(s_len + 1)` 8-aligned alloc + `_num_put_byte` trailing NUL, the `sfn_str_concat` discipline; `sfn_str_sfn_to_cstr` forwards to it. `sfn_str_sfn_from_cstr` recovers length via bounded `memchr` (16 MiB cap) and returns the `{i8*, i64}` aggregate (`-> SfnString` return-coercion). Callers pass `(x as * u8, x.length, null)` — `.length` is a direct `extractvalue` of the carried field (no NUL-scan), so every boundary call is an all-scalar 3-arg call (no aggregate-by-value), self-hosting in one pass with **no seed cut** (the new compiler built from the old seed compiles the new call sites). No `runtime_helpers.sfn` change (to_cstr/from_cstr have no emission descriptor — runtime-to-runtime FFI). Pinned by `compiler/tests/e2e/string_cstr_boundary_test.sfn` (C-harness: a `"abcXYZ"` buffer with `len = 3` round-trips through `to_cstr` as a fresh `"abc\0"`, no over-read into `"XYZ"`). |
| Worker capture-env move/free discipline (`memory/mem.sfn`, `concurrency/future.sfn`, `concurrency/parallel.sfn`) | **Shipped** (#1475, epic #1466, 2026-06-22) | `sfn_env_alloc`/`sfn_env_free` — a malloc-backed allocator pair in `runtime/sfn/memory/mem.sfn` — own the heap env for capturing spawn/parallel task lambdas. Unlike the arena-routed `sfn_alloc_struct`, these are unconditional libc `calloc`/`free` and are individually freeable after the worker crosses the thread boundary. Emission change (Option A): a spawn/parallel-target capturing lambda's env is allocated via `@sfn_env_alloc` (tagged `owned_env`); synchronous closures keep the arena fast-path unchanged. The six `_sfn_trampoline_<kind>_ctx` trampolines in `future.sfn` call `sfn_env_free(user_ctx)` after the worker body (null-safe; non-capturing tasks unaffected). `sfn_parallel` routes capturing tasks through the `_sfn_trampoline_ptr_ctx` path so the worker frees the env exactly once. The sender binding is statically `Moved` post-spawn/parallel-capture (E11/#1220, `E0901` on reuse). Scope: env-container lifetime for value/pointer-identity captures; OwnedBuf/string capture-buffer ABI across the thread boundary is deferred (#1476). |
| TLS 1.3 record layer, `*u8` idiom (`platform/tls_record.sfn`) | **Shipped** (SFN-768, SFEP-0048 Phase D2, 2026-08-08) | New `runtime/sfn/platform/tls_record.sfn` re-expresses the encrypted `TLSCiphertext` seal/open path (RFC 8446 §5) in the runtime's `*u8` pointer idiom — ChaCha20 keystream generated 64 bytes at a time, Poly1305 accumulated over a pointer, zero intermediate `int[]` copies — wired into `runtime/capsule.toml` `sfn-sources`. The key schedule, X25519, X.509, and both handshake state machines stay `int[]`-vendored in `runtime/sfn/crypto/` (they run once per connection; the record layer runs per byte), and `capsules/sfn/crypto/src/tls13_record.sfn` remains the byte-exact differential oracle (`compiler/tests/e2e/tls_record_pointer_differential_test.sfn`, 5 tests: seal/open differential across a 0–16384 length sweep with sequence numbers crossing the 32-bit boundary, every fail-closed path, seal-side range guards, and an RFC 8439 §2.8.2 ChaCha20 vector; RFC 8448 §3 negotiates AES-128-GCM so it carries no ChaCha20-Poly1305 record vector of its own — RFC conformance for the tag comes transitively through byte-identity with the RFC-validated oracle). Measured on the dev host, 1 MiB over 64 max-size records: seal/open ~42–43 MB/s at `-O0` (~11x the oracle's 3.7 MB/s) and ~233–235 MB/s at `-O2` (~47x the oracle's 5 MB/s), both clearing the design note's ~20 MB/s `-O2` bar by 10x+, so **no throughput ceiling applies**; guarded against regression by `compiler/tests/e2e/tls_record_throughput_test.sfn`. **Scope: seal/open only** — plaintext/`change_cipher_spec` framing, handshake defragmentation, and the alert codec belong to the I/O driver slice (SFN-341/D4); the module is not yet wired to a socket, `runtime/sfn/platform/tls.sfn` still carries the OpenSSL externs, and the link line is unchanged. Design: `docs/proposals/design-notes/sfn-341-native-tls-runtime-swap.md` §3.3. |
| AES-128/256-GCM, `*u8` idiom (`platform/tls_record.sfn`) | **Shipped, below the runtime-layer bar** (SFN-817) | `sfn_tls_record_seal`/`sfn_tls_record_open` take an algorithm selector (`_tlsrec_alg_chacha20_poly1305`/`_tlsrec_alg_aes_128_gcm`/`_tlsrec_alg_aes_256_gcm`, matching `capsules/sfn/crypto/src/aead.sfn`'s identifiers value-for-value) and derive the required key length from it rather than checking a standalone constant — the fix for the hazard SFN-814 flagged and routed around: AES-256-GCM's key is also 32 bytes, so a length-only guard cannot tell it apart from a ChaCha20-Poly1305 key, and a mismatch would otherwise run the wrong cipher and fail only at the peer. AES-GCM's bitsliced S-box, ShiftRows, MixColumns, and AddRoundKey (ported from `capsules/sfn/crypto/src/aes_sbox.sfn`/`aes.sfn`, SFN-339) run over local `i64` scalars for the whole encrypt2 core rather than a workspace buffer — a first cut wired the oracle's buffer-passing form directly into the pointer idiom and measured *slower* than the capsule's own `int[]` ceiling despite the pointer path, because the workspace is `malloc`'d heap memory LLVM's SROA/mem2reg can never promote to registers; every GF(2^8) multiply/square and every round step was closed-form scalar-inlined instead — correctness rests on the differential sweep below against the capsule oracle, itself anchored to SP 800-38D GCM test cases 1-4/13/14/16 for both key sizes (`capsules/sfn/crypto/tests/aead_aes_gcm_test.sfn`). GHASH is the same masked-integer carryless-multiplication technique as `ghash.sfn`, streamed over the AAD/ciphertext pointers directly (`_tlsrec_poly1305_tag`'s region-streaming pattern), never materializing a concatenated GHASH input. `compiler/tests/e2e/tls_record_pointer_differential_test.sfn` gained an AES-128-GCM sweep (0–16640 bytes, every fail-closed path) against `tls13_seal_record_aead`/`tls13_open_record_aead`, plus a cross-algorithm test (seal under ChaCha20-Poly1305, open under AES-256-GCM with the identical 32-byte key — only the AEAD tag can reject it, since the length guard passes both). **Measured on the dev host, 4 MiB over 256 16 KiB records: seal ~6.3 MB/s / open ~6.3 MB/s at `-O0`, seal ~15.8 MB/s / open ~15.6 MB/s at `-O2`** — a 15–23x gain over the AES-GCM buffer-based first cut and ~10-16x the capsule `int[]` ceiling above, but **still under** the ~20 MB/s `-O2` bar in `docs/proposals/design-notes/sfn-341-native-tls-runtime-swap.md` §3.3 (~79% of it). Without AES-NI (out of scope — a `seed-blocker` intrinsic family, since `compiler/capsule.toml` declares `sfn/crypto` so the pinned seed compiles it) an ~8-way-parallel bitsliced software cipher may simply not clear that bar; this is reported as the honest ceiling rather than tuned or omitted. The `tls.sfn` capsule-`int[]`-record-layer fallback SFN-814 added for AES-GCM is deleted outright — every negotiable suite now goes through this module. Out of scope: AES-NI, `TLS_AES_256_GCM_SHA384` (needs `hash_len = 48` threaded through `tls13_handshake.sfn`, unrelated to this port). |
| Demand-driven `sfn-sources` selection (`[sfn-source-gates]`) | **Shipped** (SFN-882) | `runtime/capsule.toml` previously declared all 35 `sfn-sources` unconditionally, 8 of them pulling in `sfn/crypto`, so a `print`-only hello-world staged 69 modules (38 crypto) and drove a nightly self-host wall-time regression. A new `[sfn-source-gates]` table — last-in-file (`toml_get_string_array` scans header-to-header, so an earlier insertion would truncate `sfn-sources` under the pinned seed), keyed by canonical effect name — compiles a gated source only when the build's demand set (the union of `[capabilities] required` and every `![...]` token across the unfiltered source set, each normalized through `effect_root()`) contains that effect; an ungated source always compiles. One key ships today, `net`, covering the TLS 1.3 stack, the socket/HTTP/WebSocket adapters, and the server loop. Measured on a 4 vCPU/15 GiB runner, cold `sfn run examples/basics/hello-world.sfn`: 69 → 29 modules staged, 38 → 0 crypto modules, 58.32 s → 20.32 s wall (2.87x), 1,915 MB → 361 MB peak RSS (5.3x). `SAILFIN_RUNTIME_SOURCE_GATES=off` (also `0`/`false`) forces the retain-everything sentinel, reproducing the pre-SFN-882 artifact set exactly (the bisect handle); `SAILFIN_TRACE_RUNTIME_GATES=1` prints the computed demand set to stderr. `[build] full-runtime = true` opts an artifact out of selection entirely — set on `compiler/capsule.toml`, since the compiler binary is the runtime provider surface and must carry every runtime module regardless of what its own sources declare. Does not change binary size (the gated modules were already dead-strippable under the separate SFN-860 retain-root policy; this removes them from the link line, a different lever) and does not affect `sfn check` (never links, unchanged by construction). `sfn build -p compiler` is deliberately unaffected — it retains everything, so `make compile` gets no faster; the win lands on every other build. Design: `docs/proposals/design-notes/runtime-demand-driven-sources.md` |

## Installer (Current)

- Release tarballs follow `sailfin_<version>_<os>_<arch>.tar.gz`. Release builds
  publish Linux x86_64, Linux arm64, macOS arm64 (Apple Silicon), and Windows
  x86_64 installer assets. Release publication requires both the native
  `sailfin-native-linux-arm64-<version>.tar.gz` payload and the matching
  `sailfin_<version>_linux_arm64.tar.gz` installer; cadence seed pinning checks
  that exact pair independently before opening or auto-merging a pin PR, whose
  CI runs the pinned ARM installer and native-seed self-host smoke (SFN-799).
  The aarch64 release leg self-hosts on the pinned native `linux-arm64` seed
  once the pin carries arm64 assets — the steady state since SFN-580 (pinned
  seed `0.9.1` carries them) — and falls back to bootstrapping the first native
  compiler from the pinned x86_64 seed under qemu (SFN-472) only when rebuilding
  a tag whose pin predates them; see `docs/build-aarch64-linux.md`. Other
  OS/architecture pairs detected by the bootstrap scripts are not supported
  until a matching release asset is published.
- The bootstrap installers verify the signed `SHA256SUMS` manifest and selected
  archive digest before extraction when OpenSSL 1.1.1+ raw-Ed25519 support is
  available. A missing manifest/signature (for an older unsigned release) or
  unsuitable OpenSSL produces an explicit warning and continues; malformed or
  invalid signed metadata, a missing/duplicate asset entry, or a digest
  mismatch aborts installation.
- Linux/macOS installs versioned files under
  `~/.local/share/sailfin/versions/<version>` and exposes `sailfin` plus `sfn`
  in `~/.local/bin` (`INSTALL_BASE` / `GLOBAL_BIN_DIR` overrides). Windows uses
  `%LOCALAPPDATA%\sailfin\versions\<version>` and
  `%LOCALAPPDATA%\sailfin\bin`, adding the bin directory to the user `PATH`.
- Current release: `v0.9.3` (see `bootstrap.toml` `[seed].version`
  for the pinned self-host seed, which may trail the latest release).

### Support Tiers

Two independent axes, easy to conflate: **base support** (the toolchain
builds, the suite passes, CI runs the platform, an installer asset is
published) and **sealed support** (owned codegen, owned syscalls, no
un-gated syscall path — the SFEP-0016 capability seal). A platform can carry
the former with zero work toward the latter.

| Platform | Base support | Sealed support |
|---|---|---|
| Linux x86-64 | Shipped; primary CI host (`ci.yml`); release asset published | In progress — direct `ld.lld` link path exists (`build/direct_link.sfn::resolve_direct_ld_lld`); owned syscall layer not started — the raw-syscall primitive ships (`compiler/capsules/codegen-llvm/src/syscall.sfn`, SFEP-0060), its sole permitted consumer `runtime/sfn/platform/syscall_linux.sfn` is unwritten |
| macOS arm64 (Apple Silicon) | Shipped; CI host; release asset published; effect enforcement partial (#613) | Not a target — mediated vendor-library shim (SFEP-0016 §3.1; no stable raw-syscall ABI) |
| Windows x86-64 | **Tier 3 — best effort** (`docs/conventions/target-tiers.md`). Cross-compiled from Linux (`ci-cross-windows`); release asset published. The only merge-blocking Windows validation is `smoke-windows`: the cross-built `.exe` boots (`--version`) and runs `sfn check` on one example — frontend only. Codegen, linking, the test suite, and self-hosting are never exercised by the merge gate on Windows — the native MSVC build/self-host path runs only in the exploratory, dispatch-only `windows-native-selfhost.yml` harness; native MSVC self-host in progress (SFEP-0021, tracking SFN-53–58) | Not a target — mediated vendor-library shim (SFEP-0016 §3.1) |
| Linux aarch64 | **Tier 2** (`docs/conventions/target-tiers.md`). Source PRs and merge queues require the `aarch64-linux-result` aggregate, which covers cross-emission, the native pass-1/pass-2 fixed point and smoke probe, shard-cover, and all eight cached test shards (SFN-826, SFN-476). The daily scheduled workflow adds a cold unsharded `--no-test-cache` suite under the native 16-GiB job budget. v0.9.3 publishes the native and installer ARM64 assets; release publication and seed pinning require both (SFN-581, SFN-799). Host-layout support and the direct `ld.lld` fast path are shipped (SFN-471, SFN-473, SFEP-0056). | Not a target |

**Base support is never a claim that the seal holds on that platform** — the
same discipline as the `![gpu]` row above ("not a claim that an accelerator
exists"): a build/test/CI/installer green light says nothing about owned
codegen or a gated syscall path. SFEP-0056 records the live precedent for
conflating the two: `install.sh` maps `aarch64|arm64` to the
`sailfin_<ver>_linux_arm64.tar.gz` asset now produced by the release workflow;
that downloadable base support does not imply a capability seal.

## Known Design Issues (Pre-1.0 Syntax Reform)

Tracked in the [roadmap](https://sailfin.dev/roadmap) and
`docs/proposals/0005-colon-type-annotations.md`. This section records the
*problem*; the roadmap records the *plan*.

- **Type annotations (`:` vs `->`)** — **migrated.** `:` for params, vars,
  fields; `->` for return types only. Parser enforces both positions.
- **String interpolation (`{{ }}` vs `${ }`)** — **migrated.** `{{ }}` meant
  the opposite of its meaning in every mainstream template language; LLMs
  systematically generated wrong code. `${ }` is now the sole interpolation
  form; `{{ }}` has been removed entirely and a `{{ name }}` in a string
  literal is plain literal text with no special-casing and no diagnostic
  (SFN-482/SFN-483). The `\${` literal escape now ships and produces literal
  `${` text without interpolation (SFN-576). SFEP-0057
  (`docs/proposals/0057-string-interpolation-dollar.md`) is **Implemented**.
- **Error handling** — largely closed. `Result<T, E>` + `?` ship end-to-end
  (#832–#834, spec §12). Remaining: `From<E>` coercion and the `E: Error`
  bound, both gated on generic constraints. `try`/`catch` remains for
  unrecoverable conditions.
- **Ownership enforcement (in progress)** — the memory-safety epic (#1209)
  is landing a bounded ownership analysis as a 1.0 soundness floor (not a
  fourth pillar). Move / use-after-move (`E0901`/`E0904`, #1214) plus in-place
  mutation of a possibly-aliased buffer (`E0902`), use-after-free (`E0903`), and
  raw-pointer FFI escape (`E0906`) are now enforced on owned/affine bindings
  (`Affine<T>`, `Linear<T>`, `OwnedBuf`) (#1215, E6). `Linear<T>` exactly-once
  enforcement — an unconsumed linear value at scope exit raises `E0907` (#1216,
  E7) — has landed. Shared borrows and `Slice` view lifetimes (Phase U) are
  still in flight.
- **Unenforced syntax** — `&T`, `&mut T`, `PII<T>`, `Secret<T>` are parsed but
  not enforced and are explicitly deferred post-1.0. Sailfin's safety story is
  **effects and capabilities** plus the bounded ownership floor above — not a
  full borrow checker or taint tracking; unenforced guarantees are not marketed.
- **Strategic focus** — three differentiators: (1) effect system,
  (2) capability-based security, (3) structured concurrency. AI integration,
  ownership enforcement, and taint tracking are post-1.0.

## AI / Model Constructs (Moved to Library)

The `model` / `prompt` / `tool` / `pipeline` keywords were **removed from the
language** (parser, AST, typecheck, emitter, runtime stubs all deleted) and
will ship as ordinary library APIs in the post-1.0 `sfn/ai` capsule. The
`![model]` effect remains as the language-level capability gate; once the
capsule ships, its functions carry `![model]` and effect checking propagates
transitively as it does for `io`/`net`/`clock`. Design discussion:
`docs/proposals/0024-model-engines-and-training.md`.
