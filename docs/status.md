# Status

Updated: 2026-06-21. Seed pinned to `0.7.0-alpha.39` (`.seed-version`);
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
| `OwnedBuf` / `Slice` owned-buffer family | Ownership-enforced (buffers); memory/string core migrated (Phase R1) | Library types in `runtime/sfn/memory/ownedbuf.sfn` (#1212, E3 of #1209): parse/typecheck/lower via the existing struct + i64 paths. `OwnedBuf` bindings are move-tracked (#1214, `E0901`/`E0904`); in-place mutation of a stale buffer raises `E0902`, use-after-free raises `E0903`, and a raw-pointer escape into an `extern fn` outside `unsafe` raises `E0906` (#1215, E6 of #1209). **Phase R1 (#1217, E8 of #1209):** the memory/string hot path is migrated onto `OwnedBuf` with the raw-pointer interior behind `unsafe` — `arena.sfn`'s grow-at-tip realloc and `ownedbuf.sfn`'s alloc/grow externs are wrapped `unsafe`, and `string.sfn`'s `sfn_str_sfn_append` / `_concat` return an owned `OwnedBuf` (consume-and-return move). The in-place grow-at-tip is reachable from safe code only through a unique `OwnedBuf`, so the #1205 aliasing hazard is closed structurally (gated by `compiler/tests/e2e/test_owned_buf_grow_determinism.sh`). `string.sfn` inlines the `OwnedBuf` struct + a same-module `_str_buf_*` move helper because the runtime-sfn-source emit path can't resolve a cross-module struct-returning call (#1283 — *not* the closed, unrelated #306). `sfn_str_sfn_slice` is **not** migrated: a non-owning `Slice` over an immediate-codepoint pseudo-pointer is unsound until that encoding is retired (#822 / the M1.A.2 aggregate flip — see #1283), so it keeps its allocating `* u8` body. **Phase R1 (#1218, E9 of #1209):** the rest of the memory core — `rc.sfn` (alloc header-init + release-to-zero `free`), `mem.sfn` (`copy_bytes`/`get_field`/`bounds_check`/`free`/`alloc_struct`), and `array.sfn` (in-place push/grow + concat over the `_v2` element-storage trampolines) — now carries the same explicit `unsafe { }` raw-region boundary. These primitives use raw `* u8` (not owned bindings), so they pass enforcement (no `E0902`/`E0903`/`E0906`); `unsafe` marks the author-asserted raw interiors and the rc release-to-zero `free` is bounded by the `prev == 1` last-reference proof. Gated by `test_runtime_memory_rc.sh` / `_mem.sh` / `test_runtime_array.sh`. `Slice` view-lifetime tracking is Phase U. Pinned by `compiler/tests/e2e/test_owned_buf_roundtrip.sh` |
| Ownership checker pass | Move + mutation/UAF/escape + linear-consume + spawn-capture-move enforced | Standalone `compiler/src/ownership_checker.sfn` after effect-check (#1213 skeleton → #1214 move core → #1215 E6 → #1216 E7 → #1220 E11). Walks the effect-checker scope structure, tracks an `Owned`/`Moved`/`Freed` lattice per owned/affine binding, and gates the build on use-after-move (`E0901`), second-live-binding (`E0904`), in-place mutation of a possibly-aliased buffer (`E0902`), use-after-free (`E0903`), raw-pointer FFI escape (`E0906`), and an unconsumed `Linear<T>` value at scope exit (`E0907`). **E11 (#1220):** a `spawn`/`parallel`/`serve` worker outlives the spawning scope, so an owned value its closure captures is a move (sender binding → `Moved`); post-spawn use on the sender is use-after-move (`E0901`). The lift is gated at the spawn site, not the `Lambda` arm, so an ordinary lambda still captures as a read. This is the static complement to #1094's RC-promote drop-emission (drops reclaim memory; ownership proves no live aliased use remains). channel-send of a bare owned identifier already moves via the generic call-argument path. Copyable values are untracked and the un-migrated runtime passes raw `*u8`/`Cast` args (never a bare owned identifier), so the compiler self-hosts unaffected. `unsafe { }` / `unsafe fn` interiors are skipped (#1211) |
| `&T` / `&mut T` borrows | Parsed only | Exclusivity not checked |
| `PII<T>` / `Secret<T>` | Parsed only | No taint enforcement; deferred post-1.0 |
| `model`/`prompt`/`tool`/`pipeline` blocks | **Removed** | Moved to the post-1.0 `sfn/ai` capsule; the `![model]` effect stays |
| `routine { }` blocks | Works (v0 nursery) | Lowers to a real structured-concurrency nursery (#1181): `sfn_nursery_enter`/`sfn_nursery_exit` (`runtime/sfn/concurrency/nursery.sfn`) bracket the body, `sfn_spawn` registers each task against the per-thread current nursery, and exit blocks (join-all) until every child completes — no task spawned in the routine outlives its scope. Non-local exit (`return`/`throw`/`break`/`continue`) out of a routine is rejected fail-closed. v0: join-all (no cancel-on-fault), join-without-destroy, per-thread (no cross-thread inheritance). Parser/emit are #1079/#1081/#1084 |
| `await` | Parsed | Typing helpers exist (#1082, `E0814`) but are **not wired into the live walk** (pending #829); lowering is #1084 |
| `channel()` | Works (v0, untyped) | Bounded MPMC channels run end-to-end: `channel(N)` → `sfn_channel_create(i64 cap, i64 elem_size)`, `send`/`receive`/`close` lower against `runtime/sfn/concurrency/channel.sfn` with the by-pointer element ABI (#1085/#1091, aligned #1266). Method dispatch routes from local, parameter, **and module-global** channel bindings — a global `let g_ch = channel(N)` (or explicit `channel<K>`) carries the canonical `channel` / `channel:K` annotation into lowering (#1474), making a capture-free shared channel possible. Pointer-sized elements only; a bare `channel(N)` receive needs an `int`/`float`-annotated target to load the element at the right width; `channel<T>` constructor parsing pending (#829) |
| `spawn` / `await` | Works (v0) | `spawn fn() -> T { ... }` lifts the non-capturing task lambda and routes through the typed `sfn_spawn_<kind>_ctx` family (`runtime/sfn/concurrency/future.sfn`), so the task runs on the runtime thread pool; `await` joins it and returns the typed result (#1474/#1477). Future-kind resolver + `E0813`/`E0814` (#1082). Capturing lambdas (heap env) are #1475; effectful task lambdas (`![io]`) still misclassify their return kind (parser follow-up) |
| `parallel [...]` | Works (v0) | Fans every non-capturing task lambda out onto the shared scheduler pool via the runtime `sfn_parallel(fn_ptrs, ctxs, count)` fan-out/join combinator (`runtime/sfn/concurrency/parallel.sfn`) and joins them all before returning (#1474). Each task's lifted closure pair `{i8*, i8*}` is unpacked to an `(fn_ptr, ctx)` pair; tasks execute concurrently (the former `sfn_spawn_task` stub never enqueued). Result handle is the raw joined results array. A bounded-channel produce/consume proof now runs concurrently end-to-end (#1474 AC2: two `parallel` tasks share a capacity-2 global channel, producer sends 5, consumer drains 5 without deadlocking — `compiler/tests/e2e/channel_producer_consumer_exec_test.sfn`). Typed result-array collection (`results[i]`) and capture-env task lambdas (#1475/#1476) remain follow-ups |
| `\|>` pipeline operator | Not implemented | Planned post-1.0 |
| Currency / time literals | Not implemented | Use numeric literals |
| `unsafe` / `extern` | Boundary enforced (locally-declared externs) | `extern fn` declarations are fully shipped (see Runtime Migration); `unsafe { }` blocks and `unsafe fn` carry an `is_unsafe` AST marker (#1211). The ownership checker skips `unsafe` interiors and treats the boundary as load-bearing: a bare owned value escaping into an `extern fn` outside `unsafe` raises `E0906` (#1215). Scope at E6: only externs **declared in the same compilation unit** are recognized; implicitly-linked prelude/runtime externs (e.g. `memcpy`) are not yet matched — a deliberate, self-host-safe false negative widened in a follow-up. Raw-pointer ops *inside* `unsafe` stay author-asserted |
| Policy decorators (`@policy`) | Parsed only | No compiler or runtime effect |
| `sfn fmt` | **Shipped** | Zero-config token-stream formatter, `--check`/`--write`, CI-enforced; architecture + limitations in `docs/proposals/fmt-architecture.md` |
| `sfn check` | **Shipped** | Parse + typecheck + effect-check, no codegen; `--json` envelope; cross-module conformance; directory mode completes the full 156-file tree (~295 s — perf, not stability, is the open item) |
| `sfn test` | **Shipped** | Discovery, `-k`/`--tag` filtering (#849), lifecycle hooks (#975, ordering only), snapshots + `--update-snapshots` (#977), `--jobs N` parallel runner (#1236), per-test binary cache (#1230/#1233) |
| `sfn vet` / `sfn lsp` / `sfn doc` / `sfn fix` | Planned | See `docs/proposals/tooling.md` |
| Package registry (`sfn init/add/publish`) | Shipped | Default registry `pkg.sfn.dev`; `SFN_REGISTRY` / `sfn config set registry` override |
| `workspace.lock` (`sfn lock` write + resolver consume) | **Shipped** | Explicit `sfn lock` writes the root lockfile (#1070); `sfn lock --work-dir DIR` sets the workspace-discovery start dir so the command can run against a workspace without `cd`. Resolver prefers `workspace → workspace.lock → capsule.lock → cache → registry` for external deps, sibling-first untouched (#1071). Roots own lockfiles; library capsules don't commit them. Committing the root `workspace.lock` is #1050, gated on a seed embedding #1071 (satisfied at `v0.7.0-alpha.31`) |
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
| `sfn/http` | `"sfn/http"` | Partial (Waves 1–4 shipped) | `net`, `io` | GET/POST client wrappers; typed `fetch(method, url, headers, body) -> Response` client surfacing status + headers (`sfn_http_request_raw`); pure-Sailfin wire layer (parse/serialize/accessors, request + response parsers); typed HTTP/1.1 `serve` on the M4 runtime (`sfn_serve_framed`); POST/PUT bodies drained via `Content-Length` (1 MiB cap). v0 limits: blocking/single-process, no TLS, no DNS, no keep-alive, no chunked encoding. Post-v0 (TLS, keep-alive, routing) pending. (#1321; #1324 Content-Length drain; #1325 typed client) |
| `sfn/net` | `"net"` | Stubbed | `net`, `io` | TCP/UDP socket API (pending runtime intrinsics) |
| `sfn/sync` | `"sync"` | Stubbed | `io` | channel/parallel/spawn API (pending concurrency runtime) |
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
  deadlocks (#1474). This also masks a latent macOS bug — Darwin's
  `_SC_NPROCESSORS_ONLN` is 58, not the Linux `84` the runtime currently
  passes to `sysconf`, so core detection fails closed there; the per-target
  constant (an emit-time intrinsic) is a follow-up. Design:
  `docs/runtime_architecture.md` §2.6.

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
| Self-applied memory budget (`platform/rlimit.sfn`) | **Shipped** (2026-06-12) | `fn main` (cli_main.sfn) self-applies an 8 GiB `RLIMIT_AS` on Linux at startup, replacing the caller-side `ulimit -v 8388608` ritual + PreToolUse hook. `SAILFIN_MEM_LIMIT=<bytes>` overrides, `unlimited` disables (ASAN escape hatch), inherited external caps always win, `SAILFIN_TRACE_MEM_LIMIT=1` traces. Toolchain-only — compiled user programs are not capped. No-op on macOS/Windows (Linux `/proc` probe gate). Pinned by `compiler/tests/e2e/test_mem_limit_selfcap.sh`. Carried by the pinned seed since 0.7.0-alpha.33, so every toolchain invocation — including the seed during `make compile` — self-caps; CI's step-level `ulimit -v` defense lines were dropped in the same cleanup |
| String accessor family (`string.sfn`) | **Shipped** (#1315, C4 of epic #1308, 2026-06-15) | `sfn_str_byte_at`, `sfn_str_find_byte`, `sfn_str_codepoint`, `sfn_str_grapheme_at`, `sfn_str_grapheme_count` are now real Sailfin bodies (bare emission targets) in `runtime/sfn/string.sfn`; the C namesakes in `sailfin_runtime.c` are `static`. The `_sfn_` infix wrappers for these five are retired. Two C bridge primitives remain: `sfn_str_read_byte` and `sfn_str_grapheme_byte` (seed cannot lower a sub-word `* u8` load; retire with #822). `sfn_str_decode_owned` and `sfn_str_immediate_codepoint` **flipped to trivial Sailfin bodies in #1421** (encoding retired by #1420; header protos deleted). `codepoint`/`grapheme_count` return `f64` to preserve the registry `double` ABI — no `runtime_helpers.sfn` change, no seed cut. Behaviour byte-identical to prior C trampolines. Pinned by `capsules/sfn/strings/tests/strings_test.sfn`. |
| Mechanical string ops (`string.sfn`) | **Shipped** (#1372, C5 of epic #1308, 2026-06-17) | All four — `sfn_str_len` (`string.length`), `sfn_str_eq` (string `==`), `sfn_str_to_number` (`string.to_number`), and `sfn_str_slice` (`substring`) — are now real Sailfin bodies (bare emission targets) in `runtime/sfn/string.sfn`; the C namesakes in `sailfin_runtime.c` are `static`. `len`/`eq`/`to_number` call `sfn_str_immediate_codepoint` (classify) and `sfn_str_decode_owned` (identity pass-through); **both are now trivial Sailfin bodies after #1421** (encoding retired by #1420 — immediate-arms are provably dead, deleted at #822). `len` → bounded libc `strnlen` (16 MiB cap), `eq` → codepoint compare / length + `memcmp` (`_sfn_imm_eq_real` UTF-8 byte compare), `to_number` → ASCII-digit fast path / `strtod`. `slice` clamps `f64` indices and calls `sailfin_runtime_substring_unchecked`. **Two compiler bugs were fixed to enable this:** (1) `core_type_mapping.sfn::map_primitive_type` was missing `f64`/`f32`; seed bump to **0.7.0-alpha.37**. (2) UTF-8 masks use decimal literals (no `0x` hex in lexer). ABI unchanged; all four `sfn_str_*` symbols resolve into `string.o`. `concat`/`append` remain in #1318. Pinned by `capsules/sfn/strings/tests/strings_test.sfn`. |
| Allocating string ops (`string.sfn`) | **Shipped** (#1318, C5 of epic #1308, 2026-06-17) | `sfn_str_concat` (the `string.concat`/`+` emission target) and `sfn_str_append` (no emission site — `native_signature: null`; ported for link-completeness) are now real Sailfin bodies in `runtime/sfn/string.sfn` over the registry's SfnString `{i8*, i64}` ABI; the C namesakes in `sailfin_runtime.c` are `static`. Each `{i8*, i64}` operand splits into a `(data, len)` scalar pair (the `io.sfn` `sfn_getenv` precedent — the only self-host-safe spelling, since an `SfnString`-typed *parameter* hits the aggregate-by-value gap); the body returns a bare `* u8` that the `-> SfnString` return-path coercion re-wraps. `concat` derefs the `SfnArena **` slot once, decodes immediate-codepoint operands via the `sfn_str_decode_owned` bridge before two `memcpy` + NUL, and applies the `SAILFIN_MAX_STRING_CONCAT` limit/overflow gate. The trailing NUL is written with the word read-modify-write `_num_put_byte`, so the arena allocation is 8-aligned and rounded to a multiple of 8 (ABI-invisible). **Reuse-window correction:** the C concat is window-agnostic — the `_concat_reuse_*` globals are vestigial (declared, never read/written) — so the port adds no `_runtime_enter` / reuse-seq bump (the O(n²)/OOM failure mode of the abandoned real-buffer attempt, avoided by construction). The retired `sfn_str_sfn_concat`/`_append` OwnedBuf wrappers had the wrong ABI; `owned_buf_append` and the prelude's presence-only `sfn_str_sfn_concat` import are dropped. ABI unchanged (`runtime_helpers.sfn` not edited); `sfn_str_concat`/`sfn_str_append` now resolve into `string.o`, not the C runtime object (relink gate). Pinned by `compiler/tests/unit/string_concat_immediate_test.sfn` + `capsules/sfn/strings/tests/strings_test.sfn`. |
| Immediate-codepoint encoding retired — producer flip (`string.sfn`) | **Shipped** (#1420, epic #1308, 2026-06-19) | The `(byte << 32)` immediate-codepoint pseudo-pointer encoding is **retired at source**: both producers — `sailfin_runtime_grapheme_at` and `sfn_str_grapheme_byte` — now return a real 1-byte arena/heap buffer on every platform. The Linux-only `#if !defined(__APPLE__)` fast-paths that emitted tagged pointers are deleted; this was already the macOS path since #1136. No immediate-codepoint value can exist at runtime from this point forward. The `_is_immediate_codepoint_string` classifier and ~36 consumer guards in `sailfin_runtime.c` are now **dead code** (no producer feeds them) and retire with the C file deletion at #822. Seed cut to `0.7.0-alpha.39` (bakes the producer flip). |
| Immediate-codepoint bridge flip (`string.sfn`) | **Shipped** (#1421, epic #1308, 2026-06-19) | `sfn_str_immediate_codepoint` and `sfn_str_decode_owned` are now **trivial Sailfin bodies** in `runtime/sfn/string.sfn` (`-> -1` and `-> s` identity respectively); the C definitions and their header prototypes are deleted. Post producer-flip, classification always returns "not an immediate" and decode is the identity. The old `_runtime_enter` concat-reuse bump in the C `decode_owned` is dropped — the `_concat_reuse_*` globals are vestigial (write-only, never read). The remaining immediate-arms in the Sailfin bodies are now provably dead and retire with the `#822` C-file deletion. Relink residual dropped from 9 → 7 across #1419+#1421. |
| `sfn_str_to_cstr` flip + `sfn_str_from_cstr` deleted (`string.sfn`) | **Shipped** (#1422, epic #1308, 2026-06-19) | `sfn_str_to_cstr` (called by `process.sfn` for `execve`/`posix_spawn`) is now a **trivial Sailfin identity body** (`return s`); the C definition is deleted. Post-encoding-teardown every `* u8` is already a real NUL-terminated buffer, so the decode is a no-op. `sfn_str_from_cstr` is **deleted outright** — no caller, no emission row. Relink residual dropped from 7 → 6. Residual-6 remaining C symbols: `sfn_str_read_byte` + `sfn_str_grapheme_byte` (seed cannot lower a sub-word `* u8` load — retire with the SfnString aggregate flip at #822), `sailfin_runtime_string_concat` (legacy 2-arg, ABI-hard, 8 C-internal callers), `sfn_default_arena`, `serve`, `mark_persistent`. |

## Installer (Current)

- Release tarballs follow `sailfin_<version>_<os>_<arch>.tar.gz`; the
  installer defaults to `~/.local/bin` (`GLOBAL_BIN_DIR` override).
- Current release: `v0.7.0-alpha.39` (see `.seed-version` for the pinned
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
