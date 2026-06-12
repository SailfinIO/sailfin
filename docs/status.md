# Status

Updated: 2026-06-10. Seed pinned to `0.7.0-alpha.31` (`.seed-version`);
the compiler version source of truth is `compiler/capsule.toml`.

This document is the **current-state source of truth**: what ships today,
what is partial, and what is planned. Consult it before editing docs,
examples, or making claims about feature availability.

It is **not a changelog.** Per-change narrative lives in the merged PR, the
linked issue, and `CHANGELOG.md`. When a feature's status changes: flip the
row, update the one-line note, link the PR/issue — do not append prose. If a
detail matters long-term, it belongs in the spec, a `docs/proposals/*` design
doc, or `docs/runtime_architecture.md`, not here.

## Toolchain (Current)

- **Build driver.** `<seed> build -p compiler` is the sole self-build driver
  (`compiler/src/cli_main.sfn` + `capsule_resolver.sfn` — pure orchestration,
  no fixups). The `scripts/build.sh` orchestrator (Stage E PR7, #383) and the
  Python fixup script `selfhost_native.py` are retired.
- **Deterministic self-hosting.** The compiler is a verified fixed point —
  stage2 and stage3 produce byte-identical LLVM IR across all modules;
  `make check` enforces this.
- **Unified resolver.** `sfn build` / `sfn run` / `sfn check` / `sfn test`
  all resolve dependencies through `capsule_resolver.sfn`
  (`prepare_project_capsules*`): relative imports, manifest `[dependencies]`,
  and workspace-implicit `sfn/X` imports in one pass. Textual import inlining
  is gone (Stages A–B). By-name and relative imports of a workspace capsule
  converge to one mangled symbol (#873).
- **Build cache.** Content-addressed cache under `build/cache/v1`
  (`$SAILFIN_BUILD_CACHE_DIR` override) with per-source dep manifests,
  `--no-cache` / `--clean` / `--cache-trace` flags, and a `[cache]` summary on
  stderr (Stage C PR1–1f, #254–#259). Runtime C/LL/sfn objects share the same
  cache across work-dirs (#915, #1096). `sfn test` content-addresses each
  linked test binary, cross-commit-stable (#1230, #1233); `make check` passes
  `--no-test-cache` so the full gate always cold-builds.
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
  bans (`E0600`) via the shared `reexport_check.sfn`.
- **Emit pipeline.** Parallel per-module emit fan-out (Stage E PR3, #278)
  with a shared retry + validator cascade (#515); driver `--work-dir` flag
  (#378); cross-Windows packaging leg (`ci-cross-windows`, #280).
- **Experimental LLVM JIT** execution is available for targeted backend
  coverage. CI builds/tests via `.github/workflows/ci.yml`; compiler tests
  live in `compiler/tests/{unit,integration,e2e}`.

## Compiler Pipeline (Current)

- `compiler/src/` is the primary toolchain; `make compile` produces
  `build/native/sailfin`. Pipeline: Lexer → Parser → Type Checker →
  Effect Checker → Native Emitter (`.sfn-asm`) → LLVM Lowering.
- **Effect enforcement is a build gate** (Phases A–F, shipped 2026-04-26):
  `validate_effects()` runs from every `compile_to_*` entry and fails the
  build on undeclared effects. `SAILFIN_EFFECT_ENFORCE=warning|off` are the
  transitional opt-outs. Diagnostics carry source spans and per-call-site
  carets.
- **Cross-module effect propagation** (`E0402`, Phase E): callers inherit
  imported callees' declared effects; aliased imports resolve. `Member`-callee
  resolution and decorator-implied transitives are Phase E2 (deferred).
- **Capsule capability cross-check** (`E0403`, Phase F): `[capabilities]
  required = [...]` is a compile-time contract; an empty surface skips the
  check. Phase G (post-1.0) moves to name-resolution detection + effect
  polymorphism.
- **Undefined free-function rejection** (`E0420`, #616/#812): unresolvable
  bare-identifier callees fail typecheck.
- **Function references**: a bare fn name in value position lowers to the
  function's address (#1146); unsupported reference forms are rejected at
  typecheck (`E0808`/`E0809`, #1147); `* fn (A) -> R` values call through an
  env-less indirect call (#1089), distinct from closure `{fn_ptr, env}`
  dispatch.

## Feature Matrix

| Feature | Status | Notes |
|---|---|---|
| `let` / `let mut` | Shipped | Annotations optional; limited inference |
| `thread_local let mut` | Shipped | Top-level only; ELF TLS; immutable form rejected (`E0807`) |
| Functions (`fn`) | Shipped | Generics, default params, decorators |
| `async fn` | Parsed | Structural only; language-level concurrency lowering pending (#1084) — the v0 runtime surface itself ships (see Runtime) |
| Structs | Shipped | Generic params, `implements` clause |
| Interfaces | Shipped | Trait-style method signatures |
| Enums / ADTs | Shipped | Payload variants; generic payloads monomorphise per instantiation (#830). >8-byte by-value payload layouts not yet emitted |
| Type aliases | Shipped | Including generic params |
| `if`/`else`, `for` | Shipped | |
| `loop` / `break` / `continue` | Shipped | `while` is intentionally not a keyword (`E0411` with a `loop` fix-it) |
| `match` | Shipped | Literals, `_`, guards, enum-variant destructuring |
| `try`/`catch`/`finally` | Shipped | Maps to runtime exceptions |
| String interpolation (`{{ }}`) | Shipped | `${ }` migration planned pre-1.0 (see Known Design Issues) |
| Pattern-match exhaustiveness | Partial | Runtime backstop (`match_exhaustive_failed`) |
| Effect annotations (`![...]`) | Shipped | |
| Effect enforcement — `io`, `net`, `clock` | **Enforced** | Build fails on undeclared use (Phase D default `error`) |
| Effect enforcement — `model` | Reserved | Declarable; detector lands with the `sfn/ai` capsule (post-1.0) |
| Effect enforcement — `gpu`, `rand` | Parsed only | Reserved in the taxonomy; no detectors yet |
| Cross-module effect propagation | **Shipped** | `E0402` (Phase E); E2 deferred |
| Capsule capability cross-check | **Shipped** | `E0403` (Phase F) |
| `int` / `float` numeric types | **Shipped** | Slices A–E complete (#296 closed): i64/f64 annotations, bitwise/shift ops, the `as` cast lowering matrix, integer-literal default, full source migration, strict int↔float refusal with `as` fix-it, bool-kind tightening (#537). `number` is an alias for `float` |
| Bitwise operators (`&`, `\|`, `^`, `<<`, `>>`) | **Shipped** | Slice B; rejected on `double` operands |
| `Result<T, E>` + `?` operator | **Shipped** | Prelude `Result`/`Error` (#832), typed `?` (`E0810`–`E0812`, #833), pure control-flow desugar (#834); spec §12. `From<E>` coercion and the `E: Error` bound gate on generic constraints |
| Closures with capture | **Shipped** | Capture inference (#458) → env synthesis (#459) → lifting + hidden-env dispatch (#689); multi-capture fix #1106 |
| Generic type inference | Partial | Type params captured; coverage limited |
| Generic type constraints | Planned | `fn sort<T: Comparable>`, real `Array<T>` / `HashMap<K, V>` / `Channel<T>` |
| Raw pointer types (`*T`) enforced | Planned | Pointer-typed struct fields lower correctly (#713, seed-blocker); full typecheck enforcement pending |
| Deterministic drop emission | In flight | M1.5 epic #322 (`LocalBinding.allocation_kind` + `emit_scope_drops`); v0 escape rule is function-return promotion only |
| Atomic intrinsics (M0) | **Shipped** | All six builtins lower to LLVM atomics, `seq_cst` at v0 (#323, #331–#335); arity/type validation `E0806` |
| Interface conformance validation | Partial | Basic checks; variance not enforced |
| `Affine<T>` / `Linear<T>` | Single-use enforced | Move / use-after-move enforced on owned/affine-typed bindings (#1214, E5 of #1209): a moved binding that is read, passed, or returned again raises `E0901`; a second `let`-binding of a moved value raises `E0904`. `Affine<T>` is at-most-once (the move rules are its whole story). `Linear<T>` is exactly-once: a linear value never consumed (moved/returned/passed/freed) before it leaves scope raises `E0907` (#1216, E7 of #1209). Shared borrows are Phase U |
| `OwnedBuf` / `Slice` owned-buffer family | Ownership-enforced (buffers); memory/string core migrated (Phase R1) | Library types in `runtime/sfn/memory/ownedbuf.sfn` (#1212, E3 of #1209): parse/typecheck/lower via the existing struct + i64 paths. `OwnedBuf` bindings are move-tracked (#1214, `E0901`/`E0904`); in-place mutation of a stale buffer raises `E0902`, use-after-free raises `E0903`, and a raw-pointer escape into an `extern fn` outside `unsafe` raises `E0906` (#1215, E6 of #1209). **Phase R1 (#1217, E8 of #1209):** the memory/string hot path is migrated onto `OwnedBuf` with the raw-pointer interior behind `unsafe` — `arena.sfn`'s grow-at-tip realloc and `ownedbuf.sfn`'s alloc/grow externs are wrapped `unsafe`, and `string.sfn`'s `sfn_str_sfn_append` / `_concat` return an owned `OwnedBuf` (consume-and-return move) while `sfn_str_sfn_slice` returns a non-owning `Slice`. The in-place grow-at-tip is reachable from safe code only through a unique `OwnedBuf`, so the #1205 aliasing hazard is closed structurally (gated by `compiler/tests/e2e/test_owned_buf_grow_determinism.sh`). `string.sfn` inlines the `OwnedBuf`/`Slice` structs + a same-module `_str_buf_*` move helper (issue #306 blocks the cross-module struct-returning call). `Slice` view-lifetime tracking is Phase U. Pinned by `compiler/tests/e2e/test_owned_buf_roundtrip.sh` |
| Ownership checker pass | Move + mutation/UAF/escape + linear-consume enforced | Standalone `compiler/src/ownership_checker.sfn` after effect-check (#1213 skeleton → #1214 move core → #1215 E6 → #1216 E7). Walks the effect-checker scope structure, tracks an `Owned`/`Moved`/`Freed` lattice per owned/affine binding, and gates the build on use-after-move (`E0901`), second-live-binding (`E0904`), in-place mutation of a possibly-aliased buffer (`E0902`), use-after-free (`E0903`), raw-pointer FFI escape (`E0906`), and an unconsumed `Linear<T>` value at scope exit (`E0907`). Copyable values are untracked and the un-migrated runtime passes raw `*u8`/`Cast` args (never a bare owned identifier), so the compiler self-hosts unaffected. `unsafe { }` / `unsafe fn` interiors are skipped (#1211) |
| `&T` / `&mut T` borrows | Parsed only | Exclusivity not checked |
| `PII<T>` / `Secret<T>` | Parsed only | No taint enforcement; deferred post-1.0 |
| `model`/`prompt`/`tool`/`pipeline` blocks | **Removed** | Moved to the post-1.0 `sfn/ai` capsule; the `![model]` effect stays |
| `routine { }` blocks | Parsed | Frontend nodes only (#1079/#1081); no typecheck or lowering yet |
| `await` | Parsed | Typing helpers exist (#1082, `E0814`) but are **not wired into the live walk** (pending #829); lowering is #1084 |
| `channel()` | Works (v0, untyped) | Bounded MPMC channels run end-to-end: `channel(N)` → `sfn_channel_create(i64 cap, i64 elem_size)`, `send`/`receive`/`close` lower against `runtime/sfn/concurrency/channel.sfn` with the by-pointer element ABI (#1085/#1091, aligned #1266). Pointer-sized elements only; `channel<T>` parsing pending (#829) |
| `spawn` | Parsed | Future-kind resolver + `E0813` (#1082); lowering is #1084 |
| `\|>` pipeline operator | Not implemented | Planned post-1.0 |
| Currency / time literals | Not implemented | Use numeric literals |
| `unsafe` / `extern` | Boundary enforced (locally-declared externs) | `extern fn` declarations are fully shipped (see Runtime Migration); `unsafe { }` blocks and `unsafe fn` carry an `is_unsafe` AST marker (#1211). The ownership checker skips `unsafe` interiors and treats the boundary as load-bearing: a bare owned value escaping into an `extern fn` outside `unsafe` raises `E0906` (#1215). Scope at E6: only externs **declared in the same compilation unit** are recognized; implicitly-linked prelude/runtime externs (e.g. `memcpy`) are not yet matched — a deliberate, self-host-safe false negative widened in a follow-up. Raw-pointer ops *inside* `unsafe` stay author-asserted |
| Policy decorators (`@policy`) | Parsed only | No compiler or runtime effect |
| `sfn fmt` | **Shipped** | Zero-config token-stream formatter, `--check`/`--write`, CI-enforced; architecture + limitations in `docs/proposals/fmt-architecture.md` |
| `sfn check` | **Shipped** | Parse + typecheck + effect-check, no codegen; `--json` envelope; cross-module conformance; directory mode completes the full 156-file tree (~295 s — perf, not stability, is the open item) |
| `sfn test` | **Shipped** | Discovery, `-k`/`--tag` filtering (#849), lifecycle hooks (#975, ordering only), snapshots + `--update-snapshots` (#977), `--jobs N` parallel runner (#1236), per-test binary cache (#1230/#1233) |
| `sfn vet` / `sfn lsp` / `sfn doc` / `sfn fix` | Planned | See `docs/proposals/tooling.md` |
| Package registry (`sfn init/add/publish`) | Shipped | Default registry `pkg.sfn.dev`; `SFN_REGISTRY` / `sfn config set registry` override |
| `workspace.lock` (`sfn lock` write + resolver consume) | **Shipped** | Explicit `sfn lock` writes the root lockfile (#1070); resolver prefers `workspace → workspace.lock → capsule.lock → cache → registry` for external deps, sibling-first untouched (#1071). Roots own lockfiles; library capsules don't commit them. Committing the root `workspace.lock` is #1050, gated on a seed embedding #1071 (satisfied at `v0.7.0-alpha.31`) |
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
| `sfn/strings` | `"strings"` | Shipped | None | Trim, case conversion, split/join, find/replace |
| `sfn/json` | `"json"` | Shipped | None | JSON parsing, serialization, pretty-print |
| `sfn/crypto` | `"crypto"` | Shipped | None | SHA-256, base64 encode (via C runtime) |
| `sfn/math` | `"math"` | Shipped | None | abs, min/max, clamp, floor/ceil/round, pow, sum/mean |
| `sfn/path` | `"path"` | Shipped | None | Path join, dirname, basename, ext, normalize |
| `sfn/toml` | `"toml"` | Shipped | None | TOML v1.0 parsing, serialization, dotted-path access |
| `sfn/fs` | `"fs"` | Shipped | `io` | File read/write/append, exists, mkdir, read_dir, perms, mkdtemp, symlink |
| `sfn/os` | `"os"` | Shipped | `io` | Env vars, home dir, exec, exit |
| `sfn/log` | `"log"` | Shipped | `io`, `clock` | Structured leveled logging with named loggers |
| `sfn/time` | `"time"` | Shipped | `clock` | Sleep, monotonic timing, elapsed |
| `sfn/cli` | `"cli"` | Shipped | `io` | Arg parsing, subcommands, help generation, terminal styling |
| `sfn/test` | `"test"` | Partial | None (pure tier) / `io` | Assertions: legacy `assert_*` (`![io]`), `pure_assert_*`, free-function `expect_*` tier, snapshot tier (#977). Fluent `expect(x).to_be(y)` deferred on generic monomorphization + cross-module method-dispatch ABI |
| `sfn/http` | `"http"` | Partial | `net`, `io` | GET/POST client (via C runtime); server stubbed |
| `sfn/net` | `"net"` | Stubbed | `net`, `io` | TCP/UDP socket API (pending runtime intrinsics) |
| `sfn/sync` | `"sync"` | Stubbed | `io` | channel/parallel/spawn API (pending concurrency runtime) |
| `sfn/tensor` | `"tensor"` | Shipped (CPU) | `gpu` (planned) | Tensor ops, matmul, transpose; no GPU dispatch yet |
| `sfn/layers` | `"layers"` | Shipped (CPU) | `gpu` (planned) | Linear layers, ReLU, sequential models |
| `sfn/nn` | `"nn"` | Shipped (CPU) | `gpu` (planned) | Activations, normalization, argmax, one_hot |
| `sfn/losses` | `"losses"` | Shipped | None | MSE, MAE, Huber, hinge |

## Runtime (Current)

- The binary's entry point is the Sailfin-emitted `@main` (M5, #451); no C
  code participates in startup. Remaining C helpers (strings, arrays,
  exceptions, the C arena, crypto, `sfn_*` trampolines) live under
  `runtime/native/src/` and are linked into the compiler binary; **M3 ports
  the ~90 remaining ABI functions into `runtime/sfn/` and then deletes
  `runtime/native/` — a hard 1.0 prerequisite.**
- The native CLI locates a bundled runtime next to the executable
  (`SAILFIN_RUNTIME_ROOT` override). No Python shims remain.
- String concat chains lower to `string_append` (realloc in-place extend)
  instead of `string_concat` (malloc+copy) for intermediates — a pure
  lowering optimization.
- **Concurrency runtime (v0, M4):** `runtime/sfn/concurrency/` ships the
  worker-pool scheduler with the task lifecycle
  (`sfn_task_create/run/join/destroy`, #1089), the `sfn_spawn` / `sfn_await`
  surface (#1090), channels, and the `sfn_parallel` fan-out/join combinator
  (#1093). Language-construct lowering (`routine`/`await`/`spawn`/`channel`)
  is #1084. Design: `docs/runtime_architecture.md` §2.6.

### Runtime Migration (C → Sailfin)

Full plan and sequencing: `docs/runtime_audit.md` and
`docs/runtime_architecture.md`. One row per migration unit; history in the
linked issues.

| Unit | Status | Notes |
|---|---|---|
| `extern fn` declarations | **Shipped** | Parser + typecheck (`E0801`–`E0805` C-ABI validation) + LLVM `declare` emission |
| `platform/libc.sfn` skeleton | **Shipped** (2026-05-01) | 12 libc declarations; extended with stat/dirent externs (#814) |
| `platform/pthread.sfn` / `posix.sfn` / `net.sfn` skeletons | **Shipped** (2026-05-02) | Richer C-ABI shapes; seeds for scheduler, process, http modules |
| `io.sfn` (`sfn_write_fd`) | **Shipped** (2026-05-04) | First Sailfin-native service wrapper over an imported extern |
| Sleep: call-site routing → `@sfn_sleep` over `nanosleep` → ms semantics | **Shipped** (#397, #307) | `runtime/sfn/clock.sfn` is the sole definition site; `sleep(ms)` end-to-end |
| Clock readers (`sfn_clock_monotonic_nanos`, `sfn_clock_millis`) | **Shipped** (#878, #819) | M3.3 |
| `exe_path` host-aware intrinsic + `exec.sfn` cutover | **Shipped** (#967, #968) | Second intrinsic-registry sentinel after errno (#877/#901) |
| `kind = "runtime"` capsule schema + `sfn-sources` link-time consumer | **Shipped** (#308) | Env-var debug toggles replaced flag-file IPC (#311, #312) |
| Arena allocator (`memory/arena.sfn`) | **Shipped** (M2.1 #394, M2.2 #477) | Real page-chain bump allocator; mark/rewind (#927) |
| Atomic refcounting (`memory/rc.sfn`) | **Shipped** (M2.3 #395) | drop_fn invocation deferred to destructor synthesis (M2.4/M2.6) |
| Memory primitives (`memory/mem.sfn`) | **Shipped** (#927) | `get_field`/`copy_bytes`/`bounds_check`/`free`; carries `seed-blocker` |
| Process spawning (`process.sfn`) | **Shipped** (M2.9 #405) | `posix_spawnp` + `waitpid`; Windows impl is a follow-up |
| Type-metadata registry (`type_meta.sfn`) | **Shipped** (M2.10 #402) | Descriptor globals + module-init ctors; value-side tagging deferred |
| Prelude facade flipped to `sfn_*` symbols | **M2 closed** (M2.12, #407/#408) | Every M2-replaced call lands on the canonical `sfn_*` symbol; M3 lifts the remaining C trampolines |
| Filesystem adapter wave 1a (`adapters/filesystem.sfn`) | **Shipped** (M3.1a #814) | read/write/append; wave 1b (dir ops, #815) next; bulk C deletion at M3.9 after a seed cut |
| `char_from_code` byte-write primitive | **Shipped** (#874) | Byte 0 unrepresentable until the `SfnString` aggregate flip (M1.A.2); macOS arm64 `char_code` immediate-decode caveat tracked at #1136 |
| Pointer-typed struct fields | **Shipped** (#713) | Layout + stores emit; retires the `i64`-slot workarounds after the next seed cut (`seed-blocker`) |
| Extern return-type defaulting hardened | **Shipped** (#306 Phase A) | Unresolvable callee signatures fail loud instead of emitting malformed IR; Phases B/C deferred |

## Installer (Current)

- Release tarballs follow `sailfin_<version>_<os>_<arch>.tar.gz`; the
  installer defaults to `~/.local/bin` (`GLOBAL_BIN_DIR` override).
- Current release: `v0.7.0-alpha.31` (see `.seed-version` for the pinned
  self-host seed, which may trail the latest release).

## Known Design Issues (Pre-1.0 Syntax Reform)

Tracked in the [roadmap](https://sailfin.dev/roadmap) and
`docs/proposals/colon-type-annotations.md`. This section records the
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
`docs/proposals/model-engines-and-training.md`.
