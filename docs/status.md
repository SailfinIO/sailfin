# Status

Updated: April 28, 2026 (Stage C cache milestone shipped — PR1–1f / #254–#259)

This document tracks what works today and what is in progress. It is the source
of truth — consult it before editing docs, examples, or making claims about
feature availability.

## Build Pipeline (Current)

- `scripts/build.sh` is the sole build driver for the compiler's self-build —
  pure shell, no fixups. It stages in-tree capsule sources
  (`capsules/<scope>/<name>/src/`) as import-context artifacts so the seed can
  resolve imports like `from "sfn/cli"` during the bootstrap.
- End-user `sfn build` and `sfn run` resolve every dependency through one
  unified resolver in `compiler/src/capsule_resolver.sfn`
  (`prepare_project_capsules`). The resolver combines three paths in one
  pass: (1) relative imports walked from the entry, (2) manifest-declared
  `[dependencies]`, (3) **workspace-implicit** imports — any `sfn/X`
  reference the source uses without declaring, resolved against the
  workspace.toml member list. The textual `inline_imports_for_source`
  fallback in `sfn run` is gone (Stage B PR1).
- `sfn build -p <capsule-path>` builds a capsule by manifest path. Reads
  `[build].kind`: `"library"` (default for stdlib capsules) emits a `.o`
  via `clang -c`; `"binary"` links an executable; `"runtime"` errors as a
  Stage F deferral.
- **`sfn check` runs through the unified resolver** as of A2: a single
  `prepare_project_capsules_for_check` pass stages every dep's
  `.sfn-asm` artifact, `typecheck_import_loader.sfn` converts those
  artifacts into AST interface declarations, and
  `check_source_with_imports` feeds them to
  `typecheck_diagnostics_with_imports`. Cross-module `implements`
  conformance (E0301) is now live for end users without any textual
  import inlining — covered by
  `compiler/tests/e2e/test_check_cross_module_conformance.sh`.
- **Diagnostic infrastructure Phase 1** (A3): the `Diagnostic` struct
  now carries `severity` ("error" | "warning" | "hint" | "info") and
  `file_path`; the renderer reads both from the struct rather than
  hand-threaded parameters. Import-context load warnings (`W0001`
  missing artifact, `W0002` parse failure) flow through the same
  `render_diagnostic` pipeline as typecheck and effect errors,
  unblocking the upcoming `--json` output flag and `sfn lsp`. Phase 2
  (`secondary` source locations + `FixSuggestion`/`TextEdit` for
  `sfn fix`) lands later.
- **`sfn test` runs through the unified resolver** (Stage B PR2,
  shipped 2026-04-26). `handle_test_command` partitions discovered
  test files by `(project_root, workspace_root)`, invokes
  `prepare_project_capsules_for_test` once per group to stage
  `.sfn-asm` import-context AND compile each capsule dependency to
  its own `.ll`, then per-test routes typecheck through
  `compile_tests_to_llvm_file_with_module_imports` and link through
  `_clang_link_test_cmd_with_deps` — same shape `cli_check.sfn`
  adopted in A2. Test sources lower with `mangle_symbols=true`; the
  inline harness in
  `lower_to_llvm_lines_with_parsed_context_for_tests` appends the
  test module's `__<module_suffix>` to each `test:` symbol so
  harness call sites match the mangled definition.
  The textual import inliner (`_inline_relative_imports_cmd`,
  `inline_imports_for_source`, the test-specific writer chain) is
  gone — A4 of Track A in `docs/proposals/check-architecture.md` is
  complete. **`llvm-objcopy --weaken native.linked.o` retired
  (Stage B PR3, 2026-04-28).** Empirical investigation showed the
  weak-object backstop was masking a trailing-slash bug in
  `_collect_test_files_cmd`, not providing genuinely missing
  symbols; a one-line `_strip_trailing_slashes_cmd` call (mirroring
  the Phase 5a fix to `_collect_sfn_files_cmd`) lets the resolver
  produce the full closure of dep `.ll` files, and the 47-line
  weaken block + 25-line `_resolve_llvm_objcopy_cmd` helper +
  `cross_module_shim.o` push all delete. `sfn/compiler-lib`
  extraction is reframed as a Stage G concern, not a Stage B
  blocker. **Stage B is fully closed.**
- **Stage C cache milestone shipped (PR1–1f, #254–#259, 2026-04-28).**
  Six PRs deliver an end-to-end content-addressed build cache that
  every `sfn build` / `sfn run` honours by default:
  - **PR1 (#254)** — `compiler/src/build_cache.sfn` foundation:
    `cache_key_for(source, deps, version, flags)` derives a
    sha256 digest sharded under `build/cache/v1/<prefix>/<key>/`;
    `cache_lookup_complete` / `cache_store` implement a
    content-addressed entry. Schema-versioned (`v1`) so a future
    key-shape change can age old entries out cleanly.
  - **PR1b (#255)** — wired into `_cr_compile_one` so each
    per-capsule module compile checks the cache before lowering
    and stores the resulting `.ll` after a fresh build.
    `SAILFIN_CACHE_TRACE=1` prints `[cache hit/miss/store]
    <slug>` per module.
  - **PR1c (#256)** — `CacheStats { hits, misses, stores,
    invalid_keys, copy_failures }` accumulated per build and
    surfaced as a single `[cache] hits=N misses=M …` summary
    line. `sfn build` gains `--no-cache`, `--clean`, and
    `--cache-trace` flags layered over the env-var defaults.
    `lookup_attempted` flag suppresses the summary on
    `--no-cache` runs (the cache was never consulted).
  - **PR1d (#257)** — same flag surface mirrored onto
    `sfn run`. Six-test e2e (`test_run_cache_flags.sh`) locks
    the build/run lockstep so future drift fails CI.
  - **PR1e (#258)** — per-source dep manifests:
    `_cr_collect_per_source_dep_manifests` replaces the
    conservative "all staged manifests" key input with the
    actual transitive imports each source reaches. An unrelated
    capsule changing busts only the modules that import it.
    Manifest interface stability propagates the invalidation
    transitively, so direct deps suffice in the key. 10–100×
    cache-hit-rate improvement on incremental builds with
    multiple capsules.
  - **PR1f (#259)** — `sfn build --json` emits a single line of
    schema-versioned JSON to stdout instead of human output.
    `compiler/src/build_report.sfn` defines the `BuildReport`
    struct and the `build_report_to_json(report)` serializer;
    `compiler/tests/e2e/test_build_json_schema.sh` (uses `jq`)
    locks every top-level field. Foundation for `sfn lsp`, the
    MCP server's structured compile feedback, CI cache-hit-rate
    gates, and future structured link errors (proposal §4.11 —
    the `diagnostics: []` slot is the forward-compat hook).
- `make compile` builds the compiler from a released seed. `make check`
  validates the seedcheck binary can run `hello-world.sfn` and pass the test suite.
- **Deterministic self-hosting**: the compiler is a verified fixed point —
  stage2 and stage3 produce byte-identical LLVM IR across all modules.
  `make check` enforces this.
- The legacy Python fixup script (`selfhost_native.py`) was removed after the
  compiler reached clean LLVM IR output (v0.5.0-alpha.22+).

## Compiler Pipeline (Current)

- The self-hosted native compiler in `compiler/src/` is the primary toolchain;
  `make compile` produces `build/native/sailfin`.
- Pipeline: Lexer → Parser → Type Checker → Native Emitter
  (`.sfn-asm` IR) → LLVM Lowering.
- **Effect checker status**: `validate_effects()` is invoked from every
  `compile_to_*` entry point in `main.sfn` and **fails the build by
  default** on undeclared effects (Phases B/C/D — shipped 2026-04-26;
  see below). The `SAILFIN_EFFECT_ENFORCE` env var lets capsule
  authors opt into the pre-Phase-D modes: unset / `=error` is the
  enforced default; `=warning` keeps the gate as a non-blocking
  warning (transitional mode); `=off` skips validation entirely
  (build-path only — `sfn check` still runs validation per
  proposal §4.7). Tracked by `docs/proposals/effect-validation.md`
  (Phases A–G; Phases A/B/C/D landed 2026-04-26).
- **Effect diagnostic source spans (Phase A — shipped 2026-04-26).** The
  `EffectViolation` struct now carries `signature_token`, `trigger`, and
  `severity` slots, populated from `FunctionSignature.name_span` via
  `_token_from_signature` in `effect_checker.sfn`. The renderer in
  `tools/check.sfn` reads `violation.trigger` into `Diagnostic.primary`,
  so effect diagnostics now render with `--> file:line:column` and a
  caret pointing at the function declaration — matching typecheck output
  shape. New `compiler/src/effect_taxonomy.sfn` exports the locked-in
  canonical effect set (`canonical_effects()` returns `["clock", "gpu",
  "io", "model", "net", "rand"]`) as the authoritative 1.0 list. The
  taxonomy module is the regression-test anchor and the future home for
  every effect-name decision; wiring `effect_checker.sfn` and
  `tools/check.sfn` to consume it (e.g. rejecting unknown effect names
  in `analyze_routine`, sorting `missing_effects` for deterministic
  rendering) lands later in Phase G alongside the name-resolution
  detector. Per-expression trigger tokens were threaded into the AST
  in Track B PR1 (B1, see below); the renderer now carets effect
  diagnostics at the offending call site rather than the routine
  declaration.
- **Effect diagnostic per-call-site carets (Track B PR1 / B1 —
  shipped 2026-04-26).** `Expression.Identifier`, `Expression.Member`,
  and `Expression.Call` now carry an optional `span: SourceSpan?`
  populated by the parser at every construction site.
  `EffectRequirement` gained a `trigger: Token?` slot; the body walker
  in `collect_effects_from_expression` populates it from the namespace
  identifier (`fs` / `print` / `http` / `console` / `websocket`) or
  the bare-callee identifier (`spawn` / `sleep` / `serve`) so each
  per-effect requirement remembers where it came from. `analyze_routine`
  picks the first non-null trigger from the missing-requirements list
  as the violation's `trigger`; the synthesized signature_token stays
  as the fallback for the residual text-pattern (`Raw`-body) path,
  decorator-implied effects, and synthesized expressions. End-to-end
  result: a long routine with one effectful call deep in the body now
  carets the diagnostic at that call (`--> file:N:M`) rather than the
  signature line. Coverage: 6 new B1 unit tests in
  `compiler/tests/unit/effect_checker_test.sfn` (16 total) plus
  `compiler/tests/e2e/test_check_effect_call_site_caret.sh` (4 e2e
  cases). Tracked by `docs/proposals/check-architecture.md` Track B.
- **Effect validation as build gate (Phases B/C/D — shipped 2026-04-26).**
  `validate_and_render_effects` (in `compiler/src/effect_gate.sfn`)
  runs after typecheck in every `compile_to_*` entry point. The
  rendering surface from `tools/check.sfn` extracted into
  `compiler/src/diagnostics_render.sfn` so the build path and
  `sfn check` share one source of truth — diagnostic shape, severity
  selection, and caret rendering match across both surfaces. Severity
  is resolved from `SAILFIN_EFFECT_ENFORCE` via
  `resolve_effect_enforcement`; the env-var read uses a
  `process.run`-based shell helper because the 0.5.x seed compiler
  has a known runtime-helper-collection bug for the `env.get`
  intrinsic (it emits the call but not the LLVM `declare`). Each
  build worker derives a process-unique tmp path from its file_path
  to avoid races on `make compile -j4`. Off-mode emits a one-line
  stderr notice per file so contributors can see the gate was
  consciously bypassed.

  Phase C audited the in-tree compiler under warning mode and added
  `![io]` to the 11 functions that legitimately emit `print.err`
  debug traces (lexer/parser entry points and lowering helpers).
  Phase D flipped the unset env-var default from `warning` to
  `error`, so unannotated effect usage now fails `make compile`,
  `sfn build`, `sfn run`, `sfn test`, and `sfn check` by default.
  All `examples/*.sfn` build cleanly under the new default. Capsule
  authors who need to migrate gradually can opt into
  `SAILFIN_EFFECT_ENFORCE=warning` for telemetry-only mode.
- **Cross-module effect propagation (Phase E — shipped 2026-04-26).**
  When a caller invokes an `Identifier` that resolves to an imported
  function with declared effects, `validate_effects_with_imports`
  promotes the call into a per-call effect requirement and emits
  `E0402` (cross-module) instead of the in-module `E0400` if the
  caller's signature doesn't propagate the effect. The new
  `compiler/src/effect_imports.sfn` module owns the
  `ImportSymbolTable` data shape; the loader
  (`typecheck_import_loader.sfn`) populates it as a side-channel of
  the same `.sfn-asm` artifact read that already produces the
  `Statement.InterfaceDeclaration` list. `tools/check.sfn`,
  `effect_gate.sfn`, `cli_check.sfn`, and `cli_commands.sfn` thread
  the table through to every analysis surface.

  Alias resolution: `import { foo as bar } from "..."` registers
  `bar` in the localized table with `foo`'s effect set, so the AST
  walker sees `Call(Identifier("bar"))` and resolves correctly. The
  scope filter in `localize_import_symbols_for_program` ensures a
  same-named in-module function never picks up a global table
  entry's effects. E1 covers direct `Identifier` callees;
  `Member`-callee resolution (`mod.fn()`) and decorator-implied
  transitives are deferred to a follow-up Phase E2.
- **Capsule capability cross-check (Phase F — shipped 2026-04-26).**
  The capsule manifest's `[capabilities] required = [...]` list is
  now a real compile-time contract. Any function declaring an
  effect outside the manifest's allowed surface fails with
  diagnostic code `E0403` ("declares effect ![X] outside capsule
  capability surface ![A, B, ...]"). Empty surface (no
  `[capabilities]` section, or standalone .sfn outside any capsule)
  degrades the check to a no-op, so pre-Phase-F projects keep
  building.

  Plumbing: `toml_get_capabilities_required` parses the manifest;
  `capsule_resolver.sfn` exposes `capabilities_required: string[]`
  on `CheckCapsuleResolution` and `TestCapsuleResolution`;
  `effect_checker.validate_capsule_capabilities` does the cross-
  check; `diagnostics_render.capability_violation_to_diagnostic`
  emits the diagnostic with a fix-it hint suggesting either widening
  the manifest or narrowing the function. `effect_gate.sfn` exposes
  `validate_and_render_effects_with_capabilities` so build-path
  callers (`compile_tests_to_llvm_file_with_module_imports`) and
  the `sfn check` path render E0400/E0401/E0402/E0403 through the
  same severity contract.

  Audit: `compiler/capsule.toml` widened from `["io"]` to
  `["io", "clock"]` so `compile_to_llvm_with_module_timed`'s
  `![io, clock]` declaration (used by `sfn emit llvm --timing`)
  fits the surface. All `capsules/sfn/*/capsule.toml` manifests
  were already correct against their declared effects — no
  changes needed.
- Experimental LLVM JIT execution is available for targeted backend coverage.
- CI uses the native build workflow (`.github/workflows/ci.yml`) to build, test,
  and attach release assets.
- Native compiler tests live in `compiler/tests/{unit,integration,e2e}` and run
  via `sfn test` or `make test-unit`, `make test-integration`, `make test-e2e`.

## Feature Matrix

| Feature | Status | Notes |
|---|---|---|
| `let` / `let mut` variables | Shipped | Type annotations optional; limited inference |
| Functions (`fn`) | Shipped | Including generics, default params, decorators |
| `async fn` | Parsed | `await` is **not** parsed; async is structural only |
| Structs | Shipped | Including generic params, `implements` clause |
| Interfaces | Shipped | Trait-style method signatures |
| Enums / ADTs | Shipped | Variants with payloads |
| Type aliases | Shipped | Including generic params |
| `if`/`else` | Shipped | |
| `for` / `while` loops | Shipped | |
| `match` | Shipped | Literals, `_` wildcard, guards; destructuring enum variants |
| `try`/`catch`/`finally` | Shipped | Maps to runtime exceptions |
| String interpolation (`{{ }}`) | Shipped | |
| Pattern matching exhaustiveness | Partial | Runtime backstop via `match_exhaustive_failed` |
| Effect annotations (`![...]`) | Shipped | Parsing and declaration |
| Effect enforcement — `io` | **Enforced** | Checker detects `print.*`, `console.*`, `fs.*`, `@logExecution`; build fails on undeclared usage by default (Phase D shipped 2026-04-26) |
| Effect enforcement — `net` | **Enforced** | Checker detects `http.*`, `websocket.*`, `serve`; build fails on undeclared usage by default |
| Effect enforcement — `model` | Reserved | Declarable; effect-checker has no detector yet. The `sfn/ai` capsule (post-1.0) supplies the call sites Phase G's name-resolution detector will key on |
| Effect enforcement — `clock` | **Enforced** | Checker detects `sleep` / `runtime.sleep`; build fails on undeclared usage by default |
| Effect enforcement — `gpu`, `rand` | Parsed only | Reserved at 1.0 in the canonical taxonomy; no detector logic yet |
| Effect enforcement as compilation gate | **Shipped (Phase D, 2026-04-26)** | `validate_and_render_effects` runs after typecheck in every `compile_to_*` entry; default severity is `error` so undeclared effects fail the build. `SAILFIN_EFFECT_ENFORCE=warning` opt-in for capsule authors mid-migration; `=off` build-path escape hatch (proposal §4.7) |
| Cross-module effect propagation | **Shipped (Phase E, 2026-04-26)** | A caller of an imported function inherits the callee's declared effects; missing propagation fails the build with `E0402`. Aliased imports (`import { foo as bar }`) resolve under the local name. E1 covers direct `Identifier` calls; `Member`-callee resolution and decorator-implied transitives deferred to Phase E2 |
| Capsule capability cross-check | **Shipped (Phase F, 2026-04-26)** | `[capabilities] required = [...]` in `capsule.toml` is a real compile-time contract; functions declaring an effect outside the surface fail with `E0403`. Empty surface skips the check (standalone .sfn unchanged). Phase G (post-1.0) replaces the text-pattern checker with name-resolution detection and adds effect polymorphism |
| Generic type inference | Partial | Type params captured; inference coverage is limited |
| Interface conformance validation | Partial | Basic checks; variance not yet enforced |
| `Affine<T>` / `Linear<T>` | Parsed only | Ownership wrappers accepted; move/consume rules not enforced |
| `&T` / `&mut T` borrows | Parsed only | Accepted syntactically; exclusivity not checked |
| `PII<T>` / `Secret<T>` | Parsed only | Parsed as nominal types; no taint enforcement |
| `model` / `prompt` / `tool` / `pipeline` blocks | **Removed** | Moved to the `sfn/ai` library capsule (post-1.0). The `![model]` effect remains as the capability gate |
| `routine { }` blocks | **Not implemented** | Not parsed |
| `await` | **Not implemented** | Not parsed |
| `channel()` concurrency | **Not implemented** | Not parsed as concurrency primitive |
| `spawn` | **Not implemented** | Not parsed |
| `\|>` pipeline operator | **Not implemented** | Planned post-1.0 expression operator (unrelated to the removed `pipeline` block) |
| Currency literals (`$0.05`) | **Not implemented** | Use numeric literal + comment |
| Time literals (`1s`, `150ms`) | **Not implemented** | Use numeric literals |
| `scope.with_timeout(...)` | **Not implemented** | |
| `unsafe` / `extern` | Parsed only | Syntax accepted; enforcement not active |
| Policy decorators (`@policy(...)`) | Parsed only | No compiler or runtime effect |
| `sfn fmt` (formatter) | **Shipped** | Token-stream formatter: indentation, spacing, inline blocks, unary operator handling, import sorting & specifier reordering, blank line normalization, `--check`/`--write` modes, CI enforcement; see `docs/proposals/fmt-architecture.md` for architecture and known limitations |
| `sfn check` (fast analysis) | **Shipped (v1 + Track B B1/B2/B3/B4 + Phase 5a)** | Runs parse + typecheck + effect-check on `.sfn` sources without emitting IR or invoking `clang`. Reports diagnostics to stderr with a summary on stdout. Exits non-zero on findings. Cross-module `implements` conformance live via the unified resolver (A2). Diagnostics carry `severity` and `file_path` and route load warnings (`W0001`/`W0002`) through the same renderer as errors (A3). Effect violations caret at the offending call site, not the function declaration (B1). `--json` emits the `sailfin-check/1` envelope (flat events array + summary) — schema documented at `docs/reference/check-json-schema.md`, locked by `compiler/tests/e2e/test_check_json_schema.sh`, and consumed by the MCP server's `sailfin_diagnostics` tool (B2). E0400/E0401/E0402 effect diagnostics now carry a structured `FixSuggestion` with a `TextEdit` that splices `![effects] ` in at the function body's opening brace — `sfn fix` and the upcoming LSP code-action handler consume the structured edit directly (B3). The build path (`sfn run`/`sfn build`/`sfn test`) now emits the same `error[Exxxx]: --> file:line:col` shape as `sfn check` — the legacy `[typecheck]`-prefixed renderer in `main.sfn` is gone (~150 lines deleted) and every `compile_to_*` entry routes through `diagnostics_render.render_diagnostic` (B4). Directory-mode checks (`sfn check compiler/src/`) now reclaim arena scratch between iterations via `sailfin_intrinsic_runtime_arena_mark` / `..._rewind`, so the full 132-file compiler tree completes in ~130 s under `SAILFIN_USE_ARENA=1` instead of SIGSEGVing at ~120 s — see `docs/proposals/phase-5a-arena-reset.md` and `docs/build-performance.md` Phase 5a. |
| `sfn vet` (static analyzer) | Planned | Pre-1.0; see `docs/proposals/tooling.md` |
| `sfn lsp` (language server) | Planned | Phase 1 pre-1.0; see `docs/proposals/tooling.md` |
| `sfn doc` (doc generator) | Planned | 1.0; see `docs/proposals/tooling.md` |
| `sfn fix` (auto-rewriter) | Planned | 1.0; see `docs/proposals/tooling.md` |
| Notebook support | Not started | Post-1.0 |
| Package registry (`sfn init/add/publish`) | Shipped | CLI commands implemented; default registry at `pkg.sfn.dev`; configurable via `sfn config set registry <url>` or `SFN_REGISTRY` env var |

## Print API (Current)

- `print(value)` is the canonical output builtin (stdout, no prefix).
- `print.err(value)` writes to stderr.
- `print.info`/`print.warn`/`print.error` are deprecated legacy variants kept for
  backward compatibility; new code should use `print()` and `print.err()`.
- The `sfn/log` capsule provides structured logging (`log.info`, `log.warn`,
  `log.error`, `log.debug`) with named loggers and fields. `log.warn` and
  `log.error` route to stderr via `print.err()`.

## Standard Library Capsules (Current)

The following capsules ship as part of the Sailfin standard library under
`capsules/sfn/`. Users import them by bare name (e.g. `from "fmt"`).

| Capsule | Import | Status | Effects | Description |
|---------|--------|--------|---------|-------------|
| `sfn/fmt` | `"fmt"` | Shipped | None | String formatting, trim, case conversion, split/join |
| `sfn/json` | `"json"` | Shipped | None | JSON parsing, serialization, pretty-print |
| `sfn/crypto` | `"crypto"` | Shipped | None | SHA-256, base64 encode (via C runtime) |
| `sfn/math` | `"math"` | Shipped | None | abs, min/max, clamp, floor/ceil/round, pow, sum/mean |
| `sfn/path` | `"path"` | Shipped | None | Path join, dirname, basename, ext, normalize |
| `sfn/toml` | `"toml"` | Shipped | None | TOML v1.0 parsing, serialization, dotted-path access |
| `sfn/fs` | `"fs"` | Shipped | `io` | File read/write/append, exists, mkdir, read_dir |
| `sfn/os` | `"os"` | Shipped | `io` | Env vars, home dir, exec, exit |
| `sfn/log` | `"log"` | Shipped | `io`, `clock` | Structured leveled logging with named loggers |
| `sfn/time` | `"time"` | Shipped | `clock` | Sleep, monotonic timing, elapsed |
| `sfn/http` | `"http"` | Partial | `net`, `io` | GET/POST client (via C runtime); server stubbed |
| `sfn/sync` | `"sync"` | Stubbed | `io` | channel/parallel/spawn API (pending concurrency runtime) |
| `sfn/net` | `"net"` | Stubbed | `net`, `io` | TCP/UDP socket API (pending runtime intrinsics) |
| `sfn/tensor` | `"tensor"` | Shipped (CPU) | `gpu` (planned) | Tensor ops, matmul, transpose; GPU dispatch not yet implemented |
| `sfn/layers` | `"layers"` | Shipped (CPU) | `gpu` (planned) | Linear layers, ReLU, sequential models |
| `sfn/nn` | `"nn"` | Shipped (CPU) | `gpu` (planned) | Activations, normalization, argmax, one_hot |
| `sfn/losses` | `"losses"` | Shipped | None | MSE, MAE, Huber, hinge loss functions |
| `sfn/cli` | `"cli"` | Shipped | `io` | CLI arg parsing, subcommands, help generation, terminal styling |

## Runtime (Current)

- The runtime is implemented in C under `runtime/native/` and linked into the
  native compiler binary.
- The native CLI locates a bundled runtime next to the executable (override with
  `SAILFIN_RUNTIME_ROOT`).
- Legacy Python runtime shims have been removed; the toolchain does not rely on
  `runtime/*.py` helpers.
- The native filesystem adapter supports `readFile`, `writeFile`, `appendFile`,
  `writeLines`, and directory helpers.
- **String concat optimization (`string_append`)**: The LLVM lowering emits
  `sailfin_runtime_string_append` (realloc-based in-place extend) for intermediate
  results in chained `+` concat chains instead of `sailfin_runtime_string_concat`
  (malloc+copy). This eliminates 2 dead intermediate allocations per 4-way concat
  and is estimated to reduce per-module peak memory 30-50% for string-heavy
  compilation paths. Pure lowering optimization — no user-visible syntax change.
  Implemented in `compiler/src/llvm/expression_lowering/native/core_strings.sfn`
  and `core_ops_lowering.sfn`; runtime entry point in
  `runtime/native/src/sailfin_runtime.c`.
- **The C runtime will be replaced by a pure Sailfin runtime before 1.0.** No C
  shim — the entire runtime (~90 ABI functions across strings, arrays, I/O,
  exceptions, crypto, time, and process execution) will be rewritten in Sailfin.
  This is a hard prerequisite for the 1.0 release.

### Runtime Migration Prerequisites

The runtime rewrite depends on compiler features that must ship first. The
[roadmap](https://sailfin.dev/roadmap) sequences these as numbered phases:

| Compiler Feature | Status | Runtime Subsystems It Unblocks |
|---|---|---|
| `extern fn` (LLVM `declare` emission) | In progress (type-checker registration needed) | All — nothing can call `malloc`/`fopen`/`write` without it |
| `int` / `float` numeric types | Planned | Sizes, indices, bitwise ops; fixes f64 precision hazard |
| Raw pointer types (`*T`) enforced | Planned | OS handles (`*FILE`, `*DIR`, `*pthread_t`), buffer pointers |
| `Result<T, E>` + `?` operator | Planned | Every fallible operation (file I/O, allocation, network) |
| Bitwise integer operators | Planned | SHA-256, Base64, flags, enum tag extraction |
| Closures with capture | Planned | `map`/`filter`/`reduce`, spawn handlers, route handlers |
| Generic type constraints | Planned | `Array<T>`, `Slice<T>`, `HashMap<K, V>`, `Channel<T>` |
| Deterministic drop emission | Planned | Memory reclamation — enables `string_drop` and `array_drop` |
| Atomic intrinsics | Planned | Reference counting, task queues, channel implementation |

See `docs/runtime_audit.md` for the full migration plan.

## Installer (Current)

- The installer defaults to `~/.local/bin` on all platforms (override with
  `GLOBAL_BIN_DIR`).
- Pinned stable version for development: `v0.1.1-alpha.135`.

## Known Design Issues (Pre-1.0 Syntax Reform)

The following design issues have been identified through external review and must
be resolved before 1.0 to avoid breaking a public API. Each is tracked in
the [roadmap](https://sailfin.dev/roadmap) and `docs/proposals/colon-type-annotations.md`. This section records the *problem*; the
roadmap records the *plan*.

### Type annotation syntax (`->` vs `:`) — **migrated**

**Resolution**: The compiler source, runtime, capsules, tests, and examples
all use `:` for parameter, variable, and field type annotations. Function
return types continue to use `->`.

```sfn
fn add(x: number, y: number) -> number { ... }
let name: string = "Sailfin";
struct User { id: number; name: string; }
```

**Remaining work**: None — migration complete. The parser now enforces
`:` in annotation positions and `->` in return-type positions.

### String interpolation (`{{ }}` vs `${ }`)

**Problem**: `{{ }}` universally means "escape interpolation" in template
languages (Jinja2, Handlebars, Mustache, Angular) and "literal braces" in
Rust's `format!`. Sailfin uses it for the *opposite* meaning.

**Impact**: Medium-high. Every developer will be confused. LLM code generators
trained on billions of lines of `{{ }}` = "literal braces" will systematically
produce wrong Sailfin code.

### Numeric type system (`number` = f64 only)

**Problem**: The sole numeric type is `number` (64-bit float). This causes:
- Precision loss for integers above 2^53
- Semantically wrong array indexing (floats as indices)
- Unreliable bit operations
- The "double-encoded pointers" fixup category (~12 of ~69 compiler fixups) —
  pointers are encoded as doubles because that's what `number` compiles to

**Impact**: High. This is a systems language targeting LLVM. JavaScript made
this choice and added BigInt 25 years later to compensate. Don't repeat it.

### Error handling gaps

**Problem**: Errors are invisible in function signatures. `try`/`catch` is the
only structured mechanism, supplemented by ad-hoc union return types
(`number | DivisionError`) with no propagation operator.

**Impact**: Medium. No `Result<T, E>` or `?` operator means every error-handling
call site requires manual `match`. Error types proliferate across module
boundaries with no composition mechanism.

### Unenforced syntax (deferred to post-1.0)

**Decision**: `Affine<T>`, `Linear<T>`, `&T`, `&mut T`, `PII<T>`, `Secret<T>`
are all parsed but not enforced. Rather than marketing unenforced guarantees,
these features are explicitly deferred to post-1.0. Sailfin's safety story is
**effects and capabilities**, not borrow checking or taint tracking — those will
ship when they can be enforced end-to-end.

**Status**: Ownership and taint types remain in the parser for forward
compatibility but are not advertised as shipped features. They will be removed
from marketing materials and the homepage.

### Strategic focus

**Decision**: Sailfin's three differentiators are: (1) effect system,
(2) capability-based security, (3) structured concurrency. All pre-1.0 effort
focuses on making these world-class. AI integration, ownership enforcement,
and taint tracking are post-1.0 library and compiler work.

## AI / Model Constructs (Moved to Library)

The `model`, `prompt`, `tool`, and `pipeline` keywords were originally designed
as language-level syntax. They have been **removed from the language** and will
be delivered as ordinary library APIs in the post-1.0 `sfn/ai` capsule.
Rationale:

- AI APIs change faster than language grammars can evolve
- Library-level features can iterate independently of compiler releases
- The `![model]` effect — the capability gate — remains a language-level feature
- Keyword syntax reserved unnecessary grammar surface for features that had no
  runtime behaviour

**Current state**: The parser, AST, typecheck, effect-checker, native emitter,
LLVM runtime-helper descriptors, and C runtime stubs for these constructs have
all been removed. The `![model]` effect is the only AI-specific construct that
remains in the language.

**What stays in the language**: The `![model]` effect annotation, which gates
AI operations through the capability system. Once the `sfn/ai` capsule ships,
its functions will carry `![model]` in their signatures and effect checking
will propagate transitively the same way it does for `io`, `net`, and `clock`.

Design-level discussion for the future library API is preserved in
`docs/proposals/model-engines-and-training.md`.
