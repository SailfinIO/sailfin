# Status

Updated: 2026-07-24. Seed pinned to `0.8.0-alpha.5` (`bootstrap.toml`
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

- **Build driver.** `<seed> build -p compiler` is the sole self-build driver
  (`compiler/src/cli_main.sfn` + `capsule_resolver.sfn` — pure orchestration,
  no fixups). The `scripts/build.sh` orchestrator (Stage E PR7, #383) and the
  Python fixup script `selfhost_native.py` are retired.
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
  manifest, then extracts into the version store
  (`~/.local/share/sailfin/versions/<version>/{sailfin,sfn,runtime/,.sha256}`,
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
  exact stage0 seed policy — `[seed].version/source/repo/asset_prefix/policy`,
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
  were deleted, their bodies relocated by consumer (backend-shared helpers to
  `compiler/src/build/`; the `compiler-common` boundary is deferred to
  SFEP-0020 / #345). Per-worker peak RSS drop drove the sequencing
  (SFEP-0027 §2.1); a line-budget sentinel
  (`compiler/tests/unit/cli_main_line_budget_test.sfn`) guards against
  re-ballooning.
- **Deterministic self-hosting.** The compiler is a verified fixed point —
  stage2 and stage3 produce byte-identical LLVM IR across all modules;
  `make check` enforces this. The triple-pass validation (stage2 + stage3
  builds with per-stage `.ll` scratch isolation, hello-world smoke gate,
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
  (SFN-436).
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
  linked test binary, cross-commit-stable (#1230, #1233); `make check` passes
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
- **Diagnostics.** One renderer (`diagnostics_render.sfn`) serves check and
  build paths; diagnostics carry `severity` + `file_path`. Effect diagnostics
  carry structured `FixSuggestion`/`TextEdit` for `sfn fix` / LSP (Track B).
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
- **Three more check≠build divergences closed (SFN-385).** A method call on a
  primitive receiver that resolves to no primitive method and no in-scope
  free function (`E0012`, e.g. `field.to_uppercase()` on a `string`), an
  arithmetic op mixing a proven `int` and `float` operand (`E0306`), and a
  malformed array-type spelling such as `[int]`/`[]string` (`E0830`,
  canonical form is `T[]`) previously passed `sfn check` and only failed
  fatally at LLVM lowering; all three now surface as frontend diagnostics
  with fix-it hints. Fail-open: each fires only when the frontend can prove
  invalidity, so string methods, imported free functions, canonical `T[]`
  arrays, and same-type/mixed-width integer arithmetic are unaffected.
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
  `compiler/src/tensor_ir_emit_stablehlo.sfn`) — the first Track-A substrate
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
- **Backend seam** (`compiler/src/backend.sfn`, #1112; SFEP-15 Stage 0):
  every codegen/link `clang` invocation routes through a `Backend` interface
  whose sole impl is `LlvmTextBackend` (today's textual-LLVM-IR + clang path).
  Zero behavior change — the driver still computes runtime objects, linker
  selection, dead-strip, and link-libs; the backend owns only the final argv +
  `process.run`. The seam is the prerequisite for the LLVM C-API backend (#347)
  and the seal-sufficient native backend (#1640) to plug in without
  re-hardcoding LLVM across the driver. `SAILFIN_TRACE_LINK=1` echoes the
  resolved clang link argv to stderr (`[trace-link] <argv>`, #1908) for both
  the program and test link layouts; linker-choice diagnostics (`[link] ...`)
  are trace-gated too. On Darwin, the backend self-supplies the SDK and host
  deployment target so outdated Homebrew LLVM does not infer stale macOS
  versions during links. The trace path has no behavior change when unset.
  **Object-only link boundary (SFN-453):** program, capsule-dependency, and test
  LLVM inputs are content-addressed and assembled before `Backend.link`;
  `LinkPlan` contains only object paths, so clang's assembler and linker-driver
  roles no longer share one invocation. A read-only shared object cache falls
  back to ephemeral objects beside the IR, never to raw `.ll` at final link.
  **Independence status:** Stage 0 and this first Stage-1 isolation slice are
  complete; direct linker ownership, typed metadata-carrying SSA IR, native
  object/code emission, gated call sites, and native-backend self-hosting are
  not shipped. #343's mold/lld selection still runs behind clang and is a
  Stage-1 precursor, not an owned link path.
- **Build-host OpenSSL dependency** (SFEP-0036, #1782/#1821). The native
  runtime links `-lssl -lcrypto` (TLS; `runtime/sfn/platform/tls.sfn`), so
  **every** Sailfin binary — including the compiler and each per-test binary
  the suite links — needs OpenSSL present on the link host, the same class of
  build-host dependency as `-lm` / `-lpthread`. On Linux `libssl-dev` sits on
  clang's default search path (no-op). On macOS Homebrew's `openssl@3` is
  keg-only, so the build driver injects a single `-L<openssl>/lib` link-search
  flag (`_openssl_link_search_flags`, `compiler/src/build/runtime_objs.sfn`):
  it honors `SAILFIN_OPENSSL_PREFIX` (a supported public override) first, then
  the standard kegs, `brew --prefix openssl@3`, and a `pkg-config
  --libs-only-L openssl` fallback for non-Homebrew installs. Dead-strip drops
  the unreferenced `SSL_*` symbols from binaries that never call TLS, but the
  libraries are still linked, so their presence on the host is mandatory. See
  the OpenSSL build-dependency runbook (`docs/runbooks/openssl-build-dependency.md`).
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
  SFN-98/SFN-99): the runtime-helper registry attributes narrow sub-effects for
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
- **Undefined free-function rejection** (`E0420`, #616/#812): unresolvable
  bare-identifier callees fail typecheck.
- **Function references**: a bare fn name in value position lowers to the
  function's address (#1146); unsupported reference forms are rejected at
  typecheck (`E0808`/`E0809`, #1147); `* fn (A) -> R` values call through an
  env-less indirect call (#1089), distinct from closure `{fn_ptr, env}`
  dispatch.
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
| String interpolation (`{{ }}`) | Shipped | Primitive values and `int \| null` union payloads stringify in direct, narrowed, and match-bound positions (SFN-343); primitive-element arrays (`int[]`/`float[]`/`number[]`/`boolean[]`/`string[]`) and nested arrays render bracketed (`[1, 2, 3]`, `[1.5, 2.5]`, `[[19, 22], [43, 50]]`) (SFN-408, SFN-410). Any interpolation operand with no stringify arm — e.g. a struct — fails the build loudly (`E0832 [fatal]`), never the old silent empty output. `${ }` migration planned pre-1.0 (see Known Design Issues) |
| Pattern-match exhaustiveness | Partial | Runtime backstop (`match_exhaustive_failed`) |
| Effect annotations (`![...]`) | Shipped | |
| Effect enforcement — `io`, `net`, `clock` | **Enforced** | Build fails on undeclared use (Phase D default `error`) |
| Effect enforcement — `model` | Reserved | Declarable; detector lands with the `sfn/ai` capsule (post-1.0) |
| Effect enforcement — sub-effects (`io.fs`, `io.console`, `net.http`, `net.ws`) | **Enforced** | Detection attributes narrow sub-effects; bare-root grants subsume (backward compatible); narrow grants + manifest tightening (`required = ["io.fs"]`, `E0403`); SFEP-0017 §6/G7, SFN-99 |
| Effect enforcement — `gpu` | Parsed only | Reserved in the taxonomy; no detectors yet |
| Effect enforcement — `rand` | **Enforced** (entropy boundary) | `sfn/crypto::random_bytes` (SFEP-0048 Phase D) establishes the `![rand]` boundary end-to-end: it propagates to callers via the existing callee-effect propagation and a caller without `![rand]` fails effect-check. Scope: only `random_bytes` carries the effect — there is still no auto call-name detector for arbitrary RNG identifiers |
| Cross-module effect propagation | **Shipped** | `E0402` (Phases E/E2); free functions, aliases, statically resolved members, and imported decorator effects |
| Capsule capability cross-check | **Shipped** | `E0403` (Phase F) |
| Hierarchical sub-effects (`io.fs`, `net.http`) | **Shipped (G6)** | Dotted sub-effect names parse as single effect strings and satisfy by subsumption — a broad grant subsumes a narrow requirement (`io.fs ⊑ io`), so every existing `![io]` stays valid and a manifest may *tighten* with `required = ["io.fs"]` (SFEP-0017 D1/D2/D4). Unrecognized effect roots are rejected (`E0404`). `canonical_effects()` is unchanged — the six roots stay locked; sub-effects refine *within* them. G7 detection narrows registered operations to the four shipped families; other registered operations conservatively retain their bare root. `effect_taxonomy.sfn`: `effect_root` / `is_recognized_effect` / `effect_subsumes` |
| `websocket.*` (`connect`/`send`/`close`; `serve(port)`) | **Shipped (v0)** | RFC 6455 `ws://` bridged end-to-end to real `sfn_websocket_*` runtime symbols (`runtime/sfn/adapters/websocket.sfn`), replacing the `sfn_websocket_unbridged` metadata-only sentinel — client (#1876), single-connection blocking echo server (#1877), epic #1180 Phase G. `![net]` enforced via the registry rows (#1601). v0 scope: `ws://` only (no `wss://`), no fragmentation/ping-pong, unmasked server frames, one connection at a time. Follow-ups: #1923 (pool dispatch), #1924 (ping/pong + fragmentation + close codes), #1925 (`wss://`/TLS), #1926 (per-client handler API), #1927 (typed channels/backpressure) |
| `int` / `float` numeric types | **Shipped** | Slices A–E complete (#296 closed): i64/f64 annotations, bitwise/shift ops, the `as` cast lowering matrix, integer-literal default, full source migration, strict int↔float refusal with `as` fix-it, bool-kind tightening (#537). `number` is an alias for `float` |
| `f16` / `bf16` low-precision floats | **Shipped (SFEP-0054 Phase 1)** | `f16`/`bf16` are real scalar annotations lowering to LLVM `half`/`bfloat` (SFN-426). No lexer/parser change (generic type-annotation identifiers); typecheck accepts them as the coarse `"float"` kind; explicit `as` conversions to/from `f32`/`f64` lower as `fpext` (widen) / `fptrunc` (narrow); expected-type literal binding (`let x: f16 = 0.5`) narrows the `double` literal constant via `fptrunc`; extern ABI accept-list; arrays/params/returns carry the exact `half`/`bfloat` carrier. Scope is Phase 1 only — fp8/tf32, distinct-kind exact-identity enforcement (`E0910`–`E0915`), direct `half`↔`bfloat` casts, and single-rounding decimal→low-precision literals remain follow-on SFEP-0054 work. Tests: `numeric_low_precision_test.sfn` (unit), `numeric_cast_test.sfn` (e2e) |
| Bitwise operators (`&`, `\|`, `^`, `<<`, `>>`) | **Shipped** | Slice B; rejected on `double` operands |
| `Result<T, E>` + `?` operator | **Shipped** | Prelude `Result`/`Error` (#832), typed `?` (`E0810`–`E0812`, #833), pure control-flow desugar (#834); spec §12. `From<E>` coercion and the `E: Error` bound gate on generic constraints |
| Closures with capture | **Shipped** | Capture inference (#458) → env synthesis (#459) → lifting + hidden-env dispatch (#689); multi-capture fix #1106; mutable captures lower by reference so assignment-position reads/writes of enclosing `let mut` bindings (including module globals) are observed by the enclosing scope (#1747/SFN-88) |
| Nested / local function declarations | **Shipped** (call-by-name) | Statement-position `fn name(...) -> T ![effects] { ... }` inside a function or lambda body (SFEP-0042, #1922, epic #1609). Non-capturing static items (Rust model): block-hoisted so siblings mutually recurse and a nested fn self-recurses; lifted to plain top-level functions (`sfn_nested_<name>_<N>`, no env/fat-pointer) and called by name via static dispatch. Referencing an enclosing local/parameter is rejected (`E0421`, fix-it → `let f = fn(...) => ...`); a same-named nested-fn parameter legally shadows. A declared-but-uncalled nested `fn foo() ![io]` imposes no effect on its parent; a *call* requires the effects transitively, and each nested body is effect-checked against its own row. Parser: `compiler/src/parser/statements.sfn`; scope/E0421: `compiler/src/typecheck.sfn`; lift: `compiler/src/llvm/expression_lowering/native/lambda_lowering.sfn`; effects: `compiler/src/effect_checker.sfn`. Using a nested fn's bare name as a first-class *value* is Sub-issue B (#1935, gated on #1609's `{fnptr, null-env}` item). Tests: `nested_function_declaration_test.sfn` (unit + e2e), `nested_function_effect_test.sfn` |
| Lambda short form `fn(x) => expr` | **Shipped** | Additive expression-bodied lambda (SFEP-0029, #1683): `fn(x) => x * x` desugars to a single-`return` block, equivalent to `fn(x) { return x * x; }`. The block form is untouched; the typed-head form `fn(x: int) -> int => expr` is also valid. `fn` lead-in keeps dispatch zero-lookahead, so the body `=>` never collides with the match-arm `=>`. `compiler/src/parser/expressions.sfn` (`parse_lambda_expression`); the fragile return-type capture was rerouted through the real type parser, retiring the #1546 class. Tests: `parser_lambda_body_test.sfn`, `parser_lambda_arrow_vs_match_test.sfn` |
| Untyped lambda callbacks | **Shipped** (covered cases) | An untyped lambda passed to a callback now infers its parameter/return types from the callee's expected `fn(...) -> R` before lifting (#1683, SFEP-0032), so `[1,2,3].map(fn(x) => x * x)` (no annotations) lowers and runs — previously a segfault. Covered: untyped lambda arguments to user/method higher-order functions (param declared `fn(int) -> int`) and the builtin `int[]` `.map`/`.filter`/`.reduce`. Syntax-independent: the untyped block form `fn(x) { ... }` is fixed identically. Non-`int` element arrays stay gated on generics (SFEP-0028 / #766); typed lambdas are a no-op (zero regression surface). `compiler/src/llvm/expression_lowering/native/lambda_param_inference.sfn`. E2e: `compiler/tests/e2e/untyped_lambda_callback_test.sfn` |
| `array.map` / `.filter` / `.reduce` (closure) | **Shipped** (pointer-width int elements) | `arr.map(fn (x: int) -> int { ... })`, `arr.filter(fn (x: int) -> bool { ... })`, `arr.reduce(init, fn (acc: int, x: int) -> int { ... })` dispatch via `runtime_array_map_fn` / `_filter_fn` / `_reduce_fn` → `sfn_array_sfn_{map,filter,reduce}` (`runtime/sfn/array.sfn`) over the runtime-callable closure-apply seam (#1507 seam + `map`, #1508 `filter`/`reduce`); by-value `{i8*, i8*}` closure pair; capturing closures work. The callback may be fully typed or an untyped lambda (`.map(fn(x) => x * x)`) — untyped param/return types are inferred from the mapper signature (#1683). Scope: pointer-width (`i64`) element/accumulator arrays plus the first pointer-width array-element mapper lane: `int[]` mapper results on `int[][]` receivers produce `int[][]` (#1943 / SFN-112). Other generic element widths (`float[]`, `string[]`, struct arrays) are still designed in SFEP-0028 and remain rejected with diagnostics until their width-specific lowering lands. Epic #1118 (closed); #766 closed as completed. E2e: `compiler/tests/e2e/array_{map,filter,reduce}_closure_test.sfn` |
| Range `.map` / `.filter` / `.reduce` (eager sugar) | **Shipped** (SFN-114) | `(start..end).map(f)` / `.reduce(init, f)` / `.filter(f)`. A `Range` has no method surface (it is otherwise consumed only by `for`-loop lowering), so the emitter materializes `[start, …, end-1]` into an `int[]` `SfnArray` via `sfn_range_materialize(start, end)` (`runtime/sfn/array.sfn`, descriptor `runtime_range_materialize_fn`) and dispatches the shipped array-HOF seam above; the range element is always pointer-width `int`, so no new width machinery is needed. Untyped callback params (e.g. `fn(acc, k) -> int`) infer as `int` from the range receiver (`receiver_element_type` Range arm, `lambda_param_inference.sfn`). Eager sugar over array HOFs; the lazy `Iterator` protocol is the post-1.0 successor (SFEP-0028 (D)). E2e: `compiler/tests/e2e/range_map_test.sfn`. Deeply-nested lambdas over ranges/arrays with **transitive** `int` captures (e.g. `matrix-multiplication.sfn`) are separately blocked on nested-capture env typing — SFN-396. |
| Generic type inference | Partial | Type params captured; coverage limited |
| Generic type constraints | Partial | `fn sort<T: Comparable>`, real `Array<T>` / `HashMap<K, V>` / `Channel<T>`. Declaration-time bound validation shipped (#1868): a bound must name a real interface (E0821) of correct arity (E0822). Instantiation-site satisfaction shipped (#1870): a concrete type argument must satisfy every declared bound (E0820), with bound propagation for in-scope type parameters, enforced live at `implements I<Args>` sites; a generic-struct static constructor under a `let` annotation (e.g. `let x: List<int> = List.new()`) resolves via return-type-site instantiation (#1941, SFN-110): the monomorphizer rewrites the call to its `List$int` specialization from the binding's expected type. End-to-end construction can now use explicit type-argument struct literals (e.g. `List<int> { items: [] }`, SFN-342), and `int \| null` interpolation no longer drops optional results (SFN-343). **SFN-110 now ships end-to-end**: the specialized constructor body itself lowers correctly too — a second `_mono_rewrite_expr` sweep over specialized struct methods mangles the return literal's type arguments (`List<int> { items: [] }` → `List$int { items: [] }`), fixing a prior collapse to `ret i8* null` that trapped every caller — so `examples/advanced/generic-structures.sfn` builds, runs, and prints its first element (removed from `scripts/check-examples.sh`'s `KNOWN_FAILING`). Remaining gap: an unannotated/uninstantiable call site (e.g. bare `let n = List.new()` with no expected-type context) still passes `sfn check` but hits a raw lowering fatal at build; a clean frontend diagnostic for that case is tracked as SFN-404 (not yet fixed). General function-call instantiation-site inference remains open. Monomorphization shipped (SFEP-0038 §3.3): a native-IR pass (`compiler/src/llvm/monomorphize.sfn`) specializes each distinct concrete instantiation — generic functions (#1869) and generic structs with inline field layout (#1871: `Box<T>` constructed as `Box{value: 42}` lowers to a concrete `%Box$int = type { i64 }`, fixing the prior silent-empty/unsized-`%T` miscompile). Bound interface-method call resolution shipped (#1872): a `T: Comparable` call `a.compare(b)` resolves in the `T = Widget` specialization to a direct static `Widget.compare`, not a vtable dispatch. All five sub-tracks (SFEP-0038, epic #1867) are `Implemented`; see `reference/preview/generics.md`. v1 scope: pointer-width `T` only (int/float/bool/string/ptr and boxed/pointer struct references) — an arbitrary by-value aggregate `T` (a struct/enum whose size ≠ 8) is **not** yet laid out inline correctly, because the generic layout manifest defaults an unresolved field type to pointer size/align 8; that arbitrary-width by-value case and generic collections (Map/Set) remain |
| `StrMap` (string-keyed map) | **Shipped** (#1710) | Concrete non-generic string→string map in `runtime/sfn/collections.sfn`; import with `import { str_map_new, str_map_set, str_map_get, str_map_has, str_map_delete, str_map_keys, str_map_len } from "runtime/sfn/collections"`. Open-addressed hash table (FNV-1a, linear probing, tombstone deletion, load-factor resize); amortized O(1); validated with a 10k-insert smoke test. **Not in the prelude** (prelude struct-returning calls cannot resolve signatures from separately-compiled consumers in the current seed; a module import merges the source). `StrMap` is the concrete-now bridge until generic `HashMap<K, V>` lands with the generic-constraints epic — it becomes a deprecated alias when generics ship |
| Raw pointer types (`*T`) enforced | Planned | Pointer-typed struct fields lower correctly (#713, seed-blocker); full typecheck enforcement pending |
| Deterministic drop emission | In flight | M1.5 epic #322 (`LocalBinding.allocation_kind` + `emit_scope_drops`); v0 escape rule is function-return promotion only |
| Atomic intrinsics (M0) | **Shipped** | All six builtins lower to LLVM atomics, `seq_cst` at v0 (#323, #331–#335); arity/type validation `E0806` |
| Interface conformance validation | Partial | Basic checks; variance not enforced |
| `Affine<T>` / `Linear<T>` | Single-use enforced | Move / use-after-move enforced on owned/affine-typed bindings (#1214, E5 of #1209): a moved binding that is read, passed, or returned again raises `E0901`; a second `let`-binding of a moved value raises `E0904`. `Affine<T>` is at-most-once (the move rules are its whole story). `Linear<T>` is exactly-once: a linear value never consumed (moved/returned/passed/freed) before it leaves scope raises `E0907` (#1216, E7 of #1209). Shared borrows are Phase U |
| `OwnedBuf` / `Slice` owned-buffer family | Ownership-enforced (buffers); memory/string core migrated (Phase R1) | Library types in `runtime/sfn/memory/ownedbuf.sfn` (#1212, E3 of #1209): parse/typecheck/lower via the existing struct + i64 paths. `OwnedBuf` bindings are move-tracked (#1214, `E0901`/`E0904`); in-place mutation of a stale buffer raises `E0902`, use-after-free raises `E0903`, and a raw-pointer escape into an `extern fn` outside `unsafe` raises `E0906` (#1215, E6 of #1209). **Phase R1 (#1217, E8 of #1209):** the memory/string hot path is migrated onto `OwnedBuf` with the raw-pointer interior behind `unsafe` — `arena.sfn`'s grow-at-tip realloc and `ownedbuf.sfn`'s alloc/grow externs are wrapped `unsafe`, and `string.sfn`'s `sfn_str_sfn_append` / `_concat` return an owned `OwnedBuf` (consume-and-return move). The in-place grow-at-tip is reachable from safe code only through a unique `OwnedBuf`, so the #1205 aliasing hazard is closed structurally (gated by `compiler/tests/e2e/test_owned_buf_grow_determinism.sh`). `string.sfn` inlines the `OwnedBuf` struct + a same-module `_str_buf_*` move helper because the runtime-sfn-source emit path can't resolve a cross-module struct-returning call (#1283 — *not* the closed, unrelated #306). `sfn_str_sfn_slice` is **not** migrated: a non-owning `Slice` over an immediate-codepoint pseudo-pointer is unsound until that encoding is retired (#822 / the M1.A.2 aggregate flip — see #1283), so it keeps its allocating `* u8` body. **Phase R1 (#1218, E9 of #1209):** the rest of the memory core — `rc.sfn` (alloc header-init + release-to-zero `free`), `mem.sfn` (`copy_bytes`/`get_field`/`bounds_check`/`free`/`alloc_struct`), and `array.sfn` (in-place push/grow + concat over the `_v2` element-storage trampolines) — now carries the same explicit `unsafe { }` raw-region boundary. These primitives use raw `* u8` (not owned bindings), so they pass enforcement (no `E0902`/`E0903`/`E0906`); `unsafe` marks the author-asserted raw interiors and the rc release-to-zero `free` is bounded by the `prev == 1` last-reference proof. Gated by `test_runtime_memory_rc.sh` / `_mem.sh` / `test_runtime_array.sh`. `Slice` view-lifetime tracking is Phase U. Pinned by `compiler/tests/e2e/test_owned_buf_roundtrip.sh` |
| Ownership checker pass | Move + mutation/UAF/escape + linear-consume + spawn-capture-move enforced | Standalone `compiler/src/ownership_checker.sfn` after effect-check (#1213 skeleton → #1214 move core → #1215 E6 → #1216 E7 → #1220 E11). Walks the effect-checker scope structure, tracks an `Owned`/`Moved`/`Freed` lattice per owned/affine binding, and gates the build on use-after-move (`E0901`), second-live-binding (`E0904`), in-place mutation of a possibly-aliased buffer (`E0902`), use-after-free (`E0903`), raw-pointer FFI escape (`E0906`), and an unconsumed `Linear<T>` value at scope exit (`E0907`). **E11 (#1220):** a `spawn`/`parallel`/`serve` worker outlives the spawning scope, so an owned value its closure captures is a move (sender binding → `Moved`); post-spawn use on the sender is use-after-move (`E0901`). The lift is gated at the spawn site, not the `Lambda` arm, so an ordinary lambda still captures as a read. This is the static complement to #1094's RC-promote drop-emission (drops reclaim memory; ownership proves no live aliased use remains). channel-send of a bare owned identifier already moves via the generic call-argument path. Copyable values are untracked and the un-migrated runtime passes raw `*u8`/`Cast` args (never a bare owned identifier), so the compiler self-hosts unaffected. `unsafe { }` / `unsafe fn` interiors are skipped (#1211) |
| `&T` / `&mut T` borrows | Parsed only | Exclusivity not checked |
| `PII<T>` / `Secret<T>` | Parsed only | No taint enforcement; deferred post-1.0 |
| `model`/`prompt`/`tool`/`pipeline` blocks | **Removed** | Moved to the post-1.0 `sfn/ai` capsule; the `![model]` effect stays |
| `routine { }` blocks | Works (v0 nursery) | Lowers to a real structured-concurrency nursery (#1181): `sfn_nursery_enter`/`sfn_nursery_exit` (`runtime/sfn/concurrency/nursery.sfn`) bracket the body, `sfn_spawn` registers each task against the per-thread current nursery, and exit blocks (join-all) until every child completes — no task spawned in the routine outlives its scope. Non-local exit (`return`/`throw`/`break`/`continue`) out of a routine is rejected fail-closed. v0: join-all (no cancel-on-fault), join-without-destroy, per-thread (no cross-thread inheritance). Parser/emit are #1079/#1081/#1084 |
| `await` | Parsed | Typing helpers exist (#1082, `E0814`); `await ch.receive()` result typing is now **wired into the live walk** (#1944) — an un-annotated receive target adopts the channel's element kind, and a `Channel<fn() -> void>` element dispatches `task()` through the closure seam (SFEP-0030 item 2). `await` on `spawn`/future values is still classified by kind (six future kinds), not live-inferred; lowering is #1084 |
| `channel()` | Works (v0, untyped) | Bounded MPMC channels run end-to-end: `channel(N)` → `sfn_channel_create(i64 cap, i64 elem_size)`, `send`/`receive`/`close` lower against `runtime/sfn/concurrency/channel.sfn` with the by-pointer element ABI (#1085/#1091, aligned #1266). Method dispatch routes from local, parameter, **and module-global** channel bindings — a global `let g_ch = channel(N)` (or explicit `channel<K>`) carries the canonical `channel` / `channel:K` annotation into lowering (#1474), making a capture-free shared channel possible. Pointer-sized elements only; a bare `channel(N)` receive needs an `int`/`float`-annotated target to load the element at the right width. A typed `Channel<T>` binding annotation binds the element kind and enforces it on `ch.send(v)` (`E0815`, frontend; #1942); live await-result typing ships alongside, so a `Channel<fn() -> void>` element round-trips the pointer-width ring and dispatches after `await ch.receive()` (#1944, SFEP-0030 item 2). `send`/`receive` are **effect-transparent** (SFEP-0049): the `channel_send`/`channel_receive` registry rows carry no effect of their own, so a pure `ch.send(v)`/`ch.receive()` requires nothing and any effect comes from the value flowing through — e.g. `ch.send(fs.read(p)?)` requires `![io]` from the argument (single source of truth, #1655) |
| `spawn` / `await` | Works (v0) | `spawn fn() -> T { ... }` lifts the non-capturing task lambda and routes through the typed `sfn_spawn_<kind>_ctx` family (`runtime/sfn/concurrency/future.sfn`), so the task runs on the runtime thread pool; `await` joins it and returns the typed result (#1474/#1477). Future-kind resolver + `E0813`/`E0814` (#1082). **Capture-env ownership (#1475, epic #1466):** a capturing spawn lambda's env is allocated via `sfn_env_alloc` (malloc-backed, not arena-routed) so it is individually freeable; the trampoline frees it exactly once after the worker body runs; the sender binding is statically `Moved` (E11/#1220, `E0901` on reuse). OwnedBuf/string capture-buffer ABI across the thread boundary is deferred (#1476). **Effectful task lambdas (#1546):** an effect annotation on the task lambda's return type (`spawn fn() -> int ![io] { ... }`) is no longer folded into the return-type text — the lambda parser now stops the return-type capture at the effect marker `!` (mirroring the fn-decl parser), so the future-kind classifier resolves the real kind (`int`) instead of the `ptr` catch-all and the typed result survives `await` **Effect (effect-transparent, SFEP-0049):** `spawn` contributes no effect of its own — the `spawn_task` registry row carries none (single source of truth, #1655) — so the caller inherits exactly the spawned body's effects: a pure body requires nothing, an `io` body (e.g. one calling `print`) still requires `![io]`. Join-side (`await`/nursery-exit) effect semantics stay out of scope (SFN-124). **Inferred-empty handle arrays (`E0831`, SFN-386):** accumulating task handles in an un-annotated `let mut hs = []` is rejected at check — the empty literal has no element type (its slot defaults to `double`, which corrupts the pushed future pointer). `Task<T>` (SFN-441 / SFEP-0055) now provides the writable handle type this diagnostic used to say didn't exist: annotate `let mut hs: Task<int>[] = []`, push spawned handles into it, and call `join_all(hs)` for input-ordered results. E0831 still fires unchanged for the un-annotated case — the guard is not weakened, just given an annotated escape path; a `[fatal]` lowering backstop fails closed on any future→scalar-slot shape the frontend rule does not enumerate |
| `parallel [...]` | Works (v0) | Fans every task lambda out onto the shared scheduler pool via the runtime `sfn_parallel(fn_ptrs, ctxs, count)` fan-out/join combinator (`runtime/sfn/concurrency/parallel.sfn`) and joins them all before returning (#1474). Each task's lifted closure pair `{i8*, i8*}` is unpacked to an `(fn_ptr, ctx)` pair; tasks execute concurrently. Result handle is the raw joined results array. A bounded-channel produce/consume proof runs concurrently end-to-end (#1474 AC2). **Capture-env ownership (#1475, epic #1466):** capturing parallel task lambdas route through the `_sfn_trampoline_ptr_ctx` path; the trampoline frees the `sfn_env_alloc`-allocated env exactly once after the worker body (null-safe; non-capturing tasks keep the bare path). OwnedBuf/string capture-buffer ABI is deferred (#1476). Typed result-array collection (`results[i]`) is delivered for the handle-array case by `join_all(Task<T>[]) -> T[]` (SFN-441 / SFEP-0055, see the `Task<T>` row below); `parallel`'s own raw joined-results handle is unchanged. **Effect (effect-transparent, SFEP-0049):** `parallel` is fan-out of spawns and contributes no effect of its own (the `spawn_task` row carries none; single source of truth, #1655), so the caller inherits the union of the task bodies' effects — pure tasks require nothing, an `io` task still requires `![io]` |
| `Task<T>` / `join_all` | Works (v0) | A user-writable typed task-handle type (SFN-441 / SFEP-0055): `spawn fn() -> T { ... }` has type `Task<T>`, so `let mut hs: Task<int>[] = []` is a legal, pointer-width-typed handle array. `join_all(handles: Task<T>[]) -> T[]` awaits a dynamic collection of handles and returns their results in **input order**, regardless of completion order — empty input returns `[]`, a singleton returns one element, multiple handles return an input-ordered array. Implemented as a phantom newtype over the existing future pointer (`llvm/type_mapping.sfn` resolves `Task<T>` to the same `%SailfinFuture<Kind>*`, zero runtime cost) and lowers to a new runtime combinator `sfn_join_all` (a join-only sibling of `sfn_parallel`, `runtime/sfn/concurrency/parallel.sfn`) that builds a real indexable `T[]` via `sfn_array_new_pointer_width` (`runtime/sfn/array.sfn`). Pointer-width result kinds only — **int, number, string, ptr**; `join_all` over `Task<void>[]`/`Task<bool>[]` (a `void[]` is meaningless, a `bool[]` needs a sub-word `i1` slot) and over a non-`Task` array are both **rejected fail-closed** (a `[fatal]` lowering backstop, so an ordinary `int[]` cannot silently `await` its integers as future pointers). A heterogeneous handle push (`Task<string>` into a `Task<int>[]`) fails at check with **E0836**. The ownership/lifetime diagnostics — double-await/use-after-move (**E0837**) and a handle escaping its `routine {}` nursery (**E0838**) — are planned (SFN-446) |
| `\|>` pipeline operator | Not implemented | Planned post-1.0 |
| Currency / time literals | Not implemented | Use numeric literals |
| `unsafe` / `extern` | Boundary enforced (locally-declared externs) | `extern fn` declarations are fully shipped (see Runtime Migration); `unsafe { }` blocks and `unsafe fn` carry an `is_unsafe` AST marker (#1211). The ownership checker skips `unsafe` interiors and treats the boundary as load-bearing: a bare owned value escaping into an `extern fn` outside `unsafe` raises `E0906` (#1215). Scope at E6: only externs **declared in the same compilation unit** are recognized; implicitly-linked prelude/runtime externs (e.g. `memcpy`) are not yet matched — a deliberate, self-host-safe false negative widened in a follow-up. Raw-pointer ops *inside* `unsafe` stay author-asserted |
| Policy decorators (`@policy`) | Parsed only | No compiler or runtime effect |
| Capsule-defined decorators | Works (Tier-1 entry hook) | SFEP-0023 §4.4–4.5 (SFN-72): a decorator imported from a capsule lowers to a normal call into the imported (mangled) symbol at function entry, marshalling `(args, fn_name)` — Tier-1, no literal-argument forwarding yet. `sfn/log` ships `@logExecution` (`[INFO] <fn>`) and `@trace` (`[TRACE] → entered <fn>`). The un-imported built-in `@logExecution`/`@trace` still lowers to the `runtime_log_execution_fn` fallback and `sfn check` emits the `W0211` `deprecated-api` lint pointing at `import { logExecution } from "log"`; deleting the built-in string-match + runtime body is seed-gated (SFEP-0023 steps E/F) |
| `sfn fmt` | **Shipped** | Zero-config token-stream formatter, `--check`/`--write`, CI-enforced; architecture + limitations in `docs/proposals/0007-fmt-architecture.md` |
| `sfn check` | **Shipped** | Parse + typecheck + effect-check, no codegen; `--json` envelope; cross-module conformance; directory mode completes the full 156-file tree (~295 s — perf, not stability, is the open item); relative-import resolution (`E0430`/`E0431`, #1953) |
| `sfn test` | **Shipped** | Discovery, `-k`/`--tag` filtering (#849), lifecycle hooks (#975, ordering only), snapshots + `--update-snapshots` (#977), `--jobs N` parallel runner (#1236), per-test binary cache (#1230/#1233). **Recoverable test harness (SFN-17):** the synthesized `@main` harness (`compiler/src/llvm/lowering/lowering_core.sfn`) wraps each hook/test call in an inline setjmp/longjmp frame and recovers — a failing test no longer aborts later tests in the same file; a failing `before_each` marks each affected test `fail` naming the hook, and `after_each`/`after_all` failures attribute to the hook rather than a test. `sfn test --json` gains a `hook` event kind; `schema_version` 1→2. Design: `docs/proposals/design-notes/sfn-17-recoverable-test-harness.md`. **Test-runner perf (SFEP-0044, 2026-07-08):** per warm test-file child (macOS 8-core): ~4 s → 2.9 s (in-process SHA-256 for text artifacts, #1995, PR #2000) → 1.75 s (invocation-scoped runtime-identity stamp, #1996, PR #2007); clang link window 2.9 s → 1.13 s. Direct `sfn test` and `sfn dev shard run` parallelism defaults natively to `min(cores, RAM/384 MiB)`, floor 1, cap 16, with a macOS cap of 2; `SAILFIN_TEST_JOBS` and explicit `--jobs N` override it in that order (SFN-91). The Makefile's `TEST_JOBS` compatibility default uses the same policy (#1998, PR #2001); `make check` runs ONE cold full suite (seedcheck leg, `--no-test-cache` backstop) + a pass1 smoke gate, `CHECK_FULL_PASS1=1` restores the old shape. CI shard legs restore a per-OS+shard test-binary cache across runs (#2008, PR #2009); safety is in the self-validating entry keys (#1233). Known residual: unit-tier cold cost dominated by per-child dep-closure compilation (~15 s CPU/file measured) — tracked as #2010; resolver sharing is #1997; binary-safe file read (retires the text/binary hash split) is #1999. **Harness↔runner IPC (SFEP-0050, SFN-393):** the harness now writes framed `SFTR` records to fd 2 and the runner demuxes them off the child's captured stderr pipe inline (via `io.poll_any` + the SFN-402 process-handle primitives), retiring the `results.log`/`fail.bin`/`_subframe_summary.json` file side-channel (SFN-17). Per-process pipe ownership makes the nesting/pool collision structurally impossible, so the IPC-key scrubbing (`_pool_child_env`, the nested-runner `clean_runner_env`) is no longer load-bearing for harness IPC — it now only isolates the `SAILFIN_TEST_SCRATCH` build-cache root, which survives. The `--json` v2 schema is unchanged. |
| `sfn bench` | **Shipped** | Native benchmarking command (epic #1503). Two modes: `--compiler` (per-module compiler emit time + peak RSS across `compiler/src/**.sfn`, SFN-61) and `[<path>...]` runtime-workload runner (build once, warm up, time K iterations, aggregate min/median inner-ms + peak RSS, SFN-63; default path `benchmarks/runtime`). Shared `--top`/`--csv`/`--budget-time`/`--budget-mem`/`--work-dir` flags with exit 2 on budget violation; `--json` emits the versioned `sailfin.bench/v1` envelope (SFN-64, `docs/reference/bench-json-schema.md`), also exposed as the `sailfin_bench` MCP passthrough. `make bench` / `make bench-runtime` are thin wrappers; the former bench shell scripts are retired. Reference: `site/src/content/docs/docs/reference/bench.md` |
| Agent-language benchmark harness | **Shipped (v2.8 bounded pilot stopped; confirmation rejected)** | `benchmarks/llm/sfn350.sfn` records the SFN-364 machine-readable failure taxonomy per failed iteration, excludes provider/setup invalidations from language denominators, retains implementation defects as Track A adoption failures while excluding their paired instances from Track B learnability estimates, and exports blinded manual-classification templates plus a separate audit key. Seeded, paired Track B `examples`, `diagnostics`, and `primitive` ablation schedules are secondary-only and cannot authorize the primary decision. SFN-365 corrected current OpenAI models to use the Responses API, passed all setup and unscored gates, and completed the OpenAI Track A schedule. That family showed Sailfin one-shot success at 72.2% versus Scala at 77.7% and Python at 88.8%, but Python had no varying template. The Anthropic Track A batch was invalidated by thinking-only `max_tokens` responses, so Track B was not run and confirmatory spend was rejected under v2.1.0. SFN-368 replaces the aliased four-way task clones with independently allocated frozen prompts and hidden fixtures, records their SHA-256 identities, and rejects cumulative markers or duplicate fixture sets. SFN-369 teaches the shipped Sailfin `routine` / `spawn fn() -> T { ... }` / `await` surface, freezes equivalent Scala and Python guidance, and makes the Track A concurrency grader reject output-equivalent sequential programs with a distinct `missing_concurrency` diagnostic. SFN-376 applies the same frozen structural requirement to Sailfin-B and translated Rill-17 sources before semantic execution. Every v2.1.0 structured-concurrency observation is ineligible for selection, rerun, or pooling with v2.5.0; v2.4.0 produced no scored output. SFN-437 rejected v2.7 before packet exposure or scoring when `claude-sonnet-5` rejected manual `thinking.type=enabled`; SFN-438 froze v2.8 with adaptive thinking, explicit medium effort, truthful non-enforceable answer-headroom recording, and fail-closed probes. The fresh v2.8 setup and ten authorization smokes passed. OpenAI completed all 120 Track A attempts: Sailfin/Scala/Python one-shot rates were 66.6%/72.2%/91.6%, all solved by iteration 5, and Python exceeded the 90% useful-variance ceiling. Anthropic stopped on its fifth Track A observation after three `overloaded_error` responses exhausted the symmetric retry policy; Track B was not purchased. Both tracks therefore remain non-decision-grade, confirmation and external-adoption spend are NO-GO, and no v2.7 or v2.8 observation may be selectively rerun or pooled. SFN-439 tracks the required new-corpus/task-difficulty design. Protocol: `benchmarks/llm/PROTOCOL-V2.md`; readout and failure corpus: `benchmarks/llm/PILOT-V2.md` |
| `sfn vet` / `sfn lsp` / `sfn doc` / `sfn fix` | Planned | See `docs/proposals/0003-tooling.md` |
| Package registry (`sfn init/add/publish`) | Shipped | Default registry `pkg.sfn.dev`; `SFN_REGISTRY` / `sfn config set registry` override |
| Toolchain pinning (`[toolchain]` manifest + version/channel gate) | **Shipped (Phase 1)** | SFEP-0046 §3.1–3.4, SFN-167: floor-semver + channel gate on `sfn build`/`run`/`check`/`test`; `sfn init` scaffolds the pin; `--skip-toolchain-check` / `SAILFIN_SKIP_TOOLCHAIN_CHECK` / `SAILFIN_TOOLCHAIN=off` escape hatches. Root `workspace.toml` `[toolchain]` floor adopted repo-wide (SFEP-0051 Phase 2, SFN-414): default floor for every member, member `capsule.toml` overrides per field. |
| Native toolchain install (`sfn toolchain install`) | **Shipped (Phase 2 acquire)** | SFEP-0046 §3.5, SFN-168: native fetch + fail-closed Ed25519-signature + SHA-256 verification into the version store; `SAILFIN_TOOLCHAIN_RELEASE_BASE` mirror override. |
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
| `sfn/crypto` | `"crypto"` | Shipped | `![rand]` (`random_bytes` only) | Pure Sailfin SHA-256/SHA-1/SHA-384 + base64, HMAC-SHA-256, HKDF-SHA-256, ChaCha20, Poly1305, and bit/constant-time helpers (SFEP-0048 Phase A + Phase D prep); OpenSSL-backed Ed25519 verify; `random_bytes(n: int) -> int[] ![rand]` (`capsules/sfn/crypto/src/rand.sfn`) — the capsule's sole effectful function, returning `n` cryptographically secure bytes from the OS entropy source (`getentropy`/`getrandom`, `/dev/urandom` read-loop fallback) via the runtime primitive `sfn_rand_fill` (`runtime/sfn/platform/rand.sfn`); fails closed to `[]` on non-positive `n` or an entropy-source error (never zeroed/partial output). Backs the WebSocket adapter's masking key and handshake key generation, retiring its OpenSSL `RAND_bytes` extern (SHA-1/`EVP_EncodeBlock` OpenSSL externs remain, so `-lssl -lcrypto` is still linked) |
| `sfn/math` | `"math"` | Shipped | None | abs, min/max, clamp, floor/ceil/round, pow, sum/mean |
| `sfn/path` | `"path"` | Shipped | None | Path join, dirname, basename, ext, normalize |
| `sfn/toml` | `"toml"` | Shipped | None | TOML v1.0 parsing, serialization, dotted-path access |
| `sfn/fs` | `"fs"` | Shipped | `io` | File read/write/append, exists, mkdir, read_dir, perms, mkdtemp, symlink, read_link |
| `sfn/os` | `"os"` | Shipped | `io` | Env vars, home dir, exec, exit |
| `sfn/log` | `"log"` | Shipped | `io`, `clock` | Structured leveled logging with named loggers |
| `sfn/time` | `"time"` | Shipped | `clock` | Sleep, monotonic timing, elapsed |
| `sfn/cli` | `"cli"` | Shipped | `io` | Arg parsing, subcommands, help generation, terminal styling |
| `sfn/test` | `"test"` | Partial | None (pure tier) / `io` | Assertions: legacy `assert_*` (`![io]`), `pure_assert_*`, free-function `expect_*` tier, snapshot tier (#977). Fluent `expect(x).to_be(y)` deferred on generic monomorphization + cross-module method-dispatch ABI |
| `sfn/bench` | `"sfn/bench"` | Shipped | `clock`, `io` | Microbenchmark harness (SFN-62), the counterpart to `sfn/test`: auto-calibrating `benchmark(name, body)`, fixed-count `benchmark_fixed(name, ops, body)`, `keep(x)` black-box sink. Each call emits one `bench-record/1 ops=… inner_ms=… name=…` line that `sfn bench`'s runtime mode parses. Reference: `site/src/content/docs/docs/reference/bench.md` |
| `sfn/http` | `"sfn/http"` | Partial (Waves 1–4 shipped) | `net`, `io` | GET/POST client wrappers; typed `fetch(method, url, headers, body) -> Response` client surfacing status + headers (`sfn_http_request_raw`); pure-Sailfin wire layer (parse/serialize/accessors, request + response parsers); typed HTTP/1.1 `serve` on the M4 runtime (`sfn_serve_framed`); POST/PUT bodies drained via `Content-Length` (1 MiB cap). real DNS host resolution via `getaddrinfo` (#1707, shared with `sfn/net`). client decodes `Transfer-Encoding: chunked` responses on the get/post/download path, length-tracked (#1708). HTTP/1.1 keep-alive connection reuse on the server loop + a native single-connection-reuse client (`sfn_http_conn_open`/`_send`/`_close`) (#1711). runtime TLS ships end-to-end (SFEP-0036 Implemented, epic #1540 B1; `runtime/sfn/platform/tls.sfn`): outbound client `https://` on `http.*`/capsule `get`/`post`, typed `fetch`, and keep-alive client connections with peer-chain + hostname verification against the system CA trust store (default verify paths + `/etc/ssl/certs/ca-certificates.crt` fallback, `SAILFIN_TLS_CAFILE` override), verify-on by default and fail-closed on a bad/untrusted cert (#1784); inbound TLS termination in the `serve` accept loop via the low-level `sfn_serve_tls(handler, port, cert, key)` runtime entry (#1783) and the typed `sfn/http` `serve_tls(handler: fn(Request) -> Response, port, cert, key)` wrapper backed by `sfn_serve_framed_tls` (#1933). e2e coverage: `runtime_tls_https_client_test.sfn`, `runtime_tls_verify_failure_test.sfn`, `serve_tls_loopback_test.sfn`, `tls_loopback_test.sfn`. TLS-scoped limits: mTLS/client-cert request, OCSP/CRL, and macOS/Windows CA-store discovery are post-1.0. Other v0 limits: blocking/single-process, no chunked *request* decode on `serve`; routing pending. (#1321; #1324 Content-Length drain; #1325 typed client; #1707 DNS; #1708 chunked client decode; #1711 keep-alive; #1540 B1 client TLS) |
| `sfn/net` | `"net"` | Partial (TCP client + server) | `net`, `io` | Real TCP socket I/O via `runtime/sfn/adapters/net.sfn`: client `connect`/`write_all`/`read_all`/`read_bytes`/`close`, server `listen`/`accept`/`close_listener` (loopback round-trip tested in-process), and DNS `resolve` via libc `getaddrinfo` (first IPv4/A record). Host resolution across the client is `localhost`, numeric dotted-quad IPv4, and real DNS. v0 limits: text bodies (NUL-terminated), no TLS at the raw-socket layer (TLS lives one layer up in `sfn/http` via `runtime/sfn/platform/tls.sfn`, SFEP-0036), IPv4-only DNS (no AAAA/caching/happy-eyeballs). UDP (`udp_bind`/`send_to`/`recv_from`) still stubbed (#1582; DNS #1707; epic #1540 B6/B2) |
| `sfn/sync` | `"sync"` | Stubbed | `io` | channel/parallel/spawn API (capsule API not yet built; use language constructs `channel`, `spawn`, `parallel`, `routine`, `join_all` directly — the runtime ships, the typed capsule wrapper does not) |
| `sfn/tensor` | `"tensor"` | Shipped (CPU) | `gpu` (planned) | Tensor ops, matmul, transpose; no GPU dispatch yet |
| `sfn/layers` | `"layers"` | Shipped (CPU) | `gpu` (planned) | Linear layers, ReLU, sequential models |
| `sfn/nn` | `"nn"` | Shipped (CPU) | `gpu` (planned) | Activations, normalization, argmax, one_hot |
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
| `io.poll_any` multi-fd readiness builtin | **Shipped** (SFN-155, epic #1540 Track A gap A3) | `io.poll_any(fds: int[], timeout_ms) -> int` — the multi-fd companion to `io.poll_readable`: waits on every fd in `fds` with a single `poll(2)` and returns which fd is ready (`>= 0`), or `-1` for timeout / empty list / error, so a stdio forwarder can wait on `{own stdin, child stdout, child stderr}` together without deadlock. Return shape is a sentinel `int` (`-1` == none), not an optional `fd?` — `int?` optional value-extraction isn't yet supported by the compiler (only `== null` round-trips). Sailfin-native body in `runtime/sfn/process.sfn` (`sfn_io_poll_any`); Windows stub in `runtime/sfn/platform/process_windows.sfn` returns `-1`. Descriptor in `compiler/src/llvm/runtime_helpers.sfn` (`io.poll_any`); declare-tracked in `lowering_helpers.sfn`. Pinned by `compiler/tests/integration/io_poll_any_test.sfn` (pipe-driven, `![io]`, 5 cases) |
| Sleep: call-site routing → `@sfn_sleep` over `nanosleep` → ms semantics | **Shipped** (#397, #307) | `runtime/sfn/clock.sfn` is the sole definition site; `sleep(ms)` end-to-end |
| Clock readers (`sfn_clock_monotonic_nanos`, `sfn_clock_millis`) | **Shipped** (#878, #819) | M3.3 |
| `exe_path` host-aware intrinsic + `exec.sfn` cutover | **Shipped** (#967, #968) | Second intrinsic-registry sentinel after errno (#877/#901) |
| `kind = "runtime"` capsule schema + `sfn-sources` link-time consumer | **Shipped** (#308) | Env-var debug toggles replaced flag-file IPC (#311, #312) |
| Arena allocator (`memory/arena.sfn`) | **Shipped** (M2.1 #394, M2.2 #477) | Real page-chain bump allocator; mark/rewind (#927) |
| In-loop arena reclamation (`llvm/lowering/instructions_loops.sfn`, `_for.sfn`, `_for_range.sfn`) | **Shipped** (#1514, #1515, epic #1513, 2026-06-23) | The emitter wraps a loop body in `sfn_arena_sfn_mark` / `sfn_arena_sfn_rewind` so per-iteration arena structs are reclaimed each pass instead of growing RSS linearly. **Scope:** non-escaping loop-local arena allocations only — generic `loop` (#1514), `for x in arr`, and `for i in a..b` (#1515). Gated by `loop_body_rewind_eligible` (`instructions_helpers.sfn`): fires only when the body's lowered IR allocates via a real `@sfn_alloc_struct`, every body-scope heap local is an all-primitive-scalar struct still `allocation_kind=="arena"` (not promoted to `rc`, consumed, or loop-carried into an ancestor binding), and the body has no other call/store that could grow an ancestor container in the arena (which the rewind would free → use-after-free). `continue`/`break`/`return` paths skip the rewind — a safe missed reclamation, never a dangling pointer. Measured (single-loop form, the #1514/#1515 shipping measurement): 30M non-escaping `Cell`s drop from ~691 MB (1.01× the raw allocation size) to a **flat ~1.7 MB** peak. The migrated `benchmarks/runtime/arena_alloc_bench` allocates inside a directly-timed inner loop (30,000 batches × 1,000) so the `sfn/bench` harness still exercises the rewind — peak RSS stays flat (~6 MB, bounded by the batch), not growing with the total allocation count. Strategy B (scalar-replacement / stack-alloca) and nested-loop mark stacking are post-1.0. |
| Phase-scoped arena reclamation (`compiler/src/arena_relocate.sfn`) | **Shipped** (SFEP-0043, branch `claude/reduce-peak-rss-arena-phase-rewind`) | Takes an arena mark before `parse_program`; after emit produces `native_lines`, joins them to a single flat string via `lines_to_native_text`, relocates that string's data buffer to malloc'd memory via `relocate_string_to_heap` (`compiler/src/arena_relocate.sfn`), rewinds the arena to reclaim the entire AST/typecheck/emit region, lowers via the flat-text entry `write_llvm_ir_from_native_text[_with_context]`, then frees the heap buffer. `import_asm_paths` is allocated below the mark and survives natively. Gated by `SAILFIN_ARENA_PHASE_REWIND` (default ON). Byte-identical `.ll` output confirmed by `compiler/tests/e2e/arena_phase_rewind_ll_identity_test.sfn`; self-hosts clean, no seed cut. **Measured (199 modules, rewind OFF vs ON):** peak RSS 1,211 MB → 1,009 MB (−16.7%); sum of per-module peak RSS 72.4 GB → 56.1 GB (−22.5%); mean 364 MB → 282 MB; wall time neutral (−0.5%). Global win across all pipeline stages (typecheck −26%, parser −28%, effect_checker −27%, lowering −17–23%). Known regressions: `capsule_resolver` +18%, `core_literals_lowering` +8% — front-half modules where copy exceeds reclaimed garbage; neither sets the new peak. |
| Atomic refcounting (`memory/rc.sfn`) | **Shipped** (M2.3 #395) | drop_fn invocation deferred to destructor synthesis (M2.4/M2.6) |
| Memory primitives (`memory/mem.sfn`) | **Shipped** (#927) | `get_field`/`copy_bytes`/`bounds_check`/`free`; carries `seed-blocker` |
| Process spawning (`process.sfn`) | **Shipped** (M2.9 #405) | `posix_spawnp` + `waitpid`; Windows impl is a follow-up |
| Type-metadata registry (`type_meta.sfn`) | **Shipped** (M2.10 #402) | Descriptor globals + module-init ctors; value-side tagging deferred |
| Prelude facade flipped to `sfn_*` symbols | **M2 closed** (M2.12, #407/#408) | Every M2-replaced call lands on the canonical `sfn_*` symbol; M3 lifts the remaining C trampolines |
| Filesystem adapter wave 1a (`adapters/filesystem.sfn`) | **Shipped** (M3.1a #814) | read/write/append; wave 1b (dir ops, #815) next; bulk C deletion at M3.9 after a seed cut |
| `sfn_fs_list_dir` host-aware enumeration (`adapters/filesystem.sfn`) | **Shipped** (SFN-374, epic #1485 M5) | `sfn_fs_list_dir` delegates directory enumeration to the `sailfin_intrinsic_fs_list_dir` sentinel instead of a hardcoded POSIX `opendir`/`readdir` loop: the POSIX leg keeps `opendir`/`readdir`/`closedir` (name at `dirent + _fs_dirent_dname_offset()`), the Windows leg walks `FindFirstFileA`/`FindNextFileA`/`FindClose` reading `WIN32_FIND_DATAA.cFileName` — fixing the 4096 source-enumeration cap in `enumerate_binary_capsule_sources` on native Windows. The sentinel returns unsorted; the wrapper preserves the empty-path → `"."` normalization and `strcmp`-sorts via `_fs_sort_str_array`. Consumer half of the SFN-51 seed-gated split (sentinel capability: SFN-51 / PR #2355, in the pinned seed since `v0.8.0`); POSIX `list_dir` behavior unchanged. Pinned by `compiler/tests/e2e/fs_list_dir_intrinsic_test.sfn` |
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
| NUL-termination at the cstr boundary (`string.sfn`, `process.sfn`, `process_windows.sfn`, `assert.sfn`) | **Shipped** (#1705, SFEP-0025 §3.3, 2026-06-27) | The extern cstr-boundary helpers materialize a real NUL-terminated buffer instead of returning the input pointer unchanged (the #1422 identity body), so a non-NUL-terminated interior view (#1454) handed to a libc call cannot over-read past its slice. `sfn_str_to_cstr` re-signatured to `(s_data: * u8, s_len: i64, arena_slot: * u8) -> * u8` — copies the **carried** `s_len` bytes into the resolved arena (`_sfn_resolve_arena`, `null` slot → process-global arena) with a `roundup8(s_len + 1)` 8-aligned alloc + `_num_put_byte` trailing NUL, the `sfn_str_concat` discipline; `sfn_str_sfn_to_cstr` forwards to it. `sfn_str_sfn_from_cstr` recovers length via bounded `memchr` (16 MiB cap) and returns the `{i8*, i64}` aggregate (`-> SfnString` return-coercion). Callers pass `(x as * u8, x.length, null)` — `.length` is a direct `extractvalue` of the carried field (no NUL-scan), so every boundary call is an all-scalar 3-arg call (no aggregate-by-value), self-hosting in one pass with **no seed cut** (the new compiler built from the old seed compiles the new call sites). No `runtime_helpers.sfn` change (to_cstr/from_cstr have no emission descriptor — runtime-to-runtime FFI). Pinned by `compiler/tests/e2e/string_cstr_boundary_test.sfn` (C-harness: a `"abcXYZ"` buffer with `len = 3` round-trips through `to_cstr` as a fresh `"abc\0"`, no over-read into `"XYZ"`). |
| Worker capture-env move/free discipline (`memory/mem.sfn`, `concurrency/future.sfn`, `concurrency/parallel.sfn`) | **Shipped** (#1475, epic #1466, 2026-06-22) | `sfn_env_alloc`/`sfn_env_free` — a malloc-backed allocator pair in `runtime/sfn/memory/mem.sfn` — own the heap env for capturing spawn/parallel task lambdas. Unlike the arena-routed `sfn_alloc_struct`, these are unconditional libc `calloc`/`free` and are individually freeable after the worker crosses the thread boundary. Emission change (Option A): a spawn/parallel-target capturing lambda's env is allocated via `@sfn_env_alloc` (tagged `owned_env`); synchronous closures keep the arena fast-path unchanged. The six `_sfn_trampoline_<kind>_ctx` trampolines in `future.sfn` call `sfn_env_free(user_ctx)` after the worker body (null-safe; non-capturing tasks unaffected). `sfn_parallel` routes capturing tasks through the `_sfn_trampoline_ptr_ctx` path so the worker frees the env exactly once. The sender binding is statically `Moved` post-spawn/parallel-capture (E11/#1220, `E0901` on reuse). Scope: env-container lifetime for value/pointer-identity captures; OwnedBuf/string capture-buffer ABI across the thread boundary is deferred (#1476). |

## Installer (Current)

- Release tarballs follow `sailfin_<version>_<os>_<arch>.tar.gz`; the
  installer defaults to `~/.local/bin` (`GLOBAL_BIN_DIR` override).
- Current release: `v0.8.0` (see `bootstrap.toml` `[seed].version`
  for the pinned self-host seed, which may trail the latest release).

## Known Design Issues (Pre-1.0 Syntax Reform)

Tracked in the [roadmap](https://sailfin.dev/roadmap) and
`docs/proposals/0005-colon-type-annotations.md`. This section records the
*problem*; the roadmap records the *plan*.

- **Type annotations (`:` vs `->`)** — **migrated.** `:` for params, vars,
  fields; `->` for return types only. Parser enforces both positions.
- **String interpolation (`{{ }}` vs `${ }`)** — open. `{{ }}` means the
  opposite of its meaning in every mainstream template language; LLMs
  systematically generate wrong code. `${ }` migration is planned pre-1.0.
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
