# Runtime Audit: Sailfin-Native Runtime Plan

**Date:** 2026-04-15 (last reviewed 2026-05-04 — see "Status delta" below)
**Previous revision:** pre-April 2026 (dated, superseded)
**Companion docs:** `site/src/content/docs/docs/reference/runtime-abi.md` (target ABI), `docs/build-performance.md`
(self-hosting perf analysis that surfaced the memory-management crisis)

> **Status delta since 2026-04-15** (keep this list short; once an item is
> fully shipped fold it into the body and remove the bullet here):
>
> - **M5 shipped — Sailfin-native entry point (2026-05-25, epic #451).**
>   `runtime/native/src/native_driver.c` and its build-system references
>   are gone. The compiler emits the `@main(i32, i8**)` entry directly,
>   resolves the runtime root in Sailfin, and dispatches the CLI through
>   `sailfin_cli_main__cli_main`. No C code participates in startup. The
>   remaining C helpers under `runtime/native/src/` (strings, arrays,
>   exceptions, crypto) remain pending M3.
>
> - **M2 closed — prelude facade audit shipped 2026-05-26 (M2.12b,
>   issue #408).** Closes the M2 milestone. `runtime/prelude.sfn` no
>   longer goes through the magic `runtime.X` namespace for the M2.10
>   type-meta cluster: the seven aliases `runtime_is_string_fn` /
>   `_is_number_fn` / `_is_boolean_fn` / `_is_array_fn` /
>   `_is_callable_fn` / `_resolve_runtime_type_fn` /
>   `_instance_of_fn` now bind to imports from
>   `runtime/sfn/type_meta.sfn` (`sfn_is_string` / `sfn_is_number` /
>   `sfn_is_boolean` / `sfn_is_array` / `sfn_is_callable` /
>   `sfn_resolve_type` / `sfn_instance_of`). The descriptor
>   registry's `native_signature` rows for these targets (PR #749 /
>   M2.10 #402) already routed compiled IR to the same `@sfn_*`
>   symbols, so emitted user code is byte-identical; the M2.12b
>   flip closes the audit at the Sailfin-source layer.
>
>   The remaining `runtime.X` references in `runtime/prelude.sfn`
>   are scoped to M3, grouped by why the flip is deferred:
>     1. **No `sfn_*` definition anywhere yet** (M3 ports the body
>        alongside the rest of the C runtime): capability bridges
>        (`console`, `fs`, `http`, `websocket`,
>        `create_capability_grant`, `create_filesystem_bridge`,
>        `create_http_bridge`), `monotonic_millis`, `logExecution`,
>        `to_debug_string`, `assert_fail`, `serve`, and `is_void` (no
>        `sfn_is_void` export in `runtime/sfn/type_meta.sfn`).
>     2. **`sfn_*` body exists as a placeholder but not wired**:
>        `array_map`, `array_filter`, `array_reduce`. The Sailfin
>        module exports `sfn_array_sfn_map/filter/reduce` (stubs
>        returning the input), but the helper registry's
>        `runtime_array_*_fn` descriptors still have
>        `native_signature: null` and emit calls to the legacy
>        `sailfin_runtime_array_*` C bodies. Real implementations
>        depend on closures-with-capture, an M3 prerequisite.
>     3. **TLS / setjmp API split**: `raise_value_error` — the
>        TLS-message-slot C entrypoint the compiler lowering
>        actively consumes is semantically distinct from
>        `sfn_throw`'s setjmp/longjmp path; M3 unifies them.
>     4. **`native_signature` routes to a `sfn_*` C trampoline,
>        prelude needs a boundary cast**: `char_code`,
>        `grapheme_count`, `grapheme_at`. The helper registry's
>        `native_signature` routes the emitted IR call to the
>        canonical `sfn_str_codepoint` / `sfn_str_grapheme_count` /
>        `sfn_str_grapheme_at` symbol names, but those symbols are
>        still defined as C trampolines in
>        `runtime/native/src/sailfin_runtime.c` that forward to the
>        legacy `sailfin_runtime_*` bodies (the Sailfin module
>        exports `sfn_str_sfn_*` with the `_sfn_` infix; M3 retires
>        the C trampolines and renames the Sailfin exports to the
>        bare form). The prelude-side `runtime.X` → import flip
>        additionally needs a `string` ↔ `* u8` / `int` ↔ `float`
>        boundary cast that's out of scope per the issue's
>        audit-only `In:` list.
>
>   The audit invariant the M2.12b flip targets is **"every
>   M2-replaced symbol's emitted call lands on the canonical `sfn_*`
>   symbol name"** — that holds end-to-end via either direct sfn
>   import (the type-meta cluster) or the helper registry's
>   `native_signature` routing (`sleep`, `process.run`, the `print*`
>   family, `sfn_str_codepoint`, `sfn_str_grapheme_*`). Several of
>   those `sfn_*` symbols are still C trampolines in
>   `runtime/native/src/sailfin_runtime.c` and stay live until M3
>   lifts each body into a Sailfin module (`runtime/sfn/io.sfn` for
>   `print*`, `runtime/sfn/string.sfn` for the str helpers, …); only
>   `sfn_sleep`, `sfn_process_run`, the `sfn_arena_sfn_*` /
>   `sfn_rc_sfn_*` families, and the M2.10 type-meta surface are
>   defined in Sailfin today. The `sailfin_runtime_*` legacy bodies
>   (e.g. `sailfin_runtime_print_raw`, `sailfin_runtime_string_concat`)
>   are the truly dead-after-M2 portion — still linked for seed
>   compat, but no fresh user emission references them.
>
>   Pinned by the standard `make compile` + `make test` self-host
>   gate; the determinism sweep on
>   `compiler/src/llvm/lowering/lowering_core.sfn` continues to
>   produce byte-identical IR across 20 iterations.
> - **Sleep migration PR 2 shipped (issue #397).** `runtime/sfn/clock.sfn`
>   is now the sole definition site for `@sfn_sleep`; its body calls
>   `nanosleep` directly via `runtime/sfn/platform/posix.sfn`. The C
>   entrypoint `sailfin_runtime_sleep` and the `sfn_sleep` C trampoline
>   (both formerly in `runtime/native/src/sailfin_runtime.c`) are gone,
>   together with the `sailfin_runtime_sleep` import in
>   `runtime/sfn/platform/libc.sfn`, its per-symbol descriptor in
>   `compiler/src/llvm/runtime_helpers.sfn`, and the matching helper-
>   preamble entry in `compiler/src/llvm/lowering/lowering_helpers.sfn`.
>   `runtime/native/capsule.toml`'s `sfn-sources` now lists
>   `../sfn/clock.sfn`, so the runtime-capsule link path picks it up.
>   (#941: the legacy `make rebuild` `build/native/obj/runtime/*.o`
>   staging was deleted — post-#940 every link path emits the runtime
>   from source via the capsule path, so the pre-built objects were no
>   longer read. `ci-cross-windows` now emits its runtime IR itself and
>   the installer bundles `runtime/prelude.sfn` + `runtime/sfn/`.)
>   EINTR-resume landed via bounded retry loop (issue #693,
>   2026-05-26): `sfn_sleep` now wraps the `nanosleep` call in a
>   `loop`-with-`break` capped at 32 iterations that exits on
>   `ret == 0`. The shortcut trusts the return value alone — no
>   `errno` read — because the body's `tv_nsec` clamp + non-negative
>   `tv_sec` + stack-allocated `req` make `EINVAL` and `EFAULT`
>   unreachable in this usage, so a non-zero return is definitionally
>   `EINTR`. Re-passing the same `req` slightly over-sleeps under a
>   signal but preserves the wall-clock-≥-requested contract.
>   Precise remainder tracking (read `rem` back, subtract the
>   consumed portion) and the strict-errno path are tracked in epic
>   [#763](https://github.com/SailfinIO/sailfin/issues/763) alongside
>   the `clock_gettime` migration — both need pointer-read intrinsics
>   that don't ship yet. Pinned by
>   `compiler/tests/e2e/test_runtime_clock_skeleton.sh` (asserts the
>   `call i32 @nanosleep` plus a `br i1` back-edge after it),
>   `test_sleep_unit_semantics.sh` (#307 — still brackets
>   `sleep(75) ≈ 75 ms`), and `test_sleep_eintr_resume.sh` (#693 —
>   asserts `sleep(500)` survives a mid-flight `SIGURG` and returns
>   after ≥ 450 ms).
>
> - **Sleep call-site routing shipped 2026-05-04 (PR 1 of the sleep
>   migration).** Compiled user `sleep(N)` and `runtime.sleep(N)` calls
>   lower to `call void @sfn_sleep(double ...)` via the registry
>   rewire. PR 2 (above) replaced the C-side definition with the
>   Sailfin one; the call-path rewire stays in place.
>
>   **Open follow-ups identified during this work:**
>   - [#305](https://github.com/SailfinIO/sailfin/issues/305) — standalone
>     `sfn emit llvm` produces inconsistent IR for runtime modules
>     under specific output-path / scratch-state combinations.
>   - [#306](https://github.com/SailfinIO/sailfin/issues/306) — extern
>     call return type defaults to `i8*` when call result is unused.
>   - [#307](https://github.com/SailfinIO/sailfin/issues/307) — **resolved
>     2026-05-05.** `sleep()` unit semantics audited and locked to
>     **milliseconds end-to-end** across the prelude / `sfn/time` capsule,
>     `runtime/sfn/clock.sfn` (`sfn_sleep(milliseconds: float)`),
>     `runtime/sfn/platform/libc.sfn`, and the C entrypoint
>     (`sailfin_runtime_sleep(double milliseconds)`). POSIX implementation
>     upgraded from deprecated `usleep` to `nanosleep` with EINTR-resume.
>     Pinned by `compiler/tests/e2e/test_sleep_unit_semantics.sh`.
>   - [#308](https://github.com/SailfinIO/sailfin/issues/308) —
>     **resolved (PR A).** Re-scoped from "scratch-dir isolation"
>     to "remove file-IPC for compiler debug toggles + wire the
>     runtime sfn-sources consumer." Toggle file probes
>     (`build/sailfin/.skip_typecheck`, `.trace_emit`,
>     `.trace_test_runner`, `.dump_test_sources`) now read
>     `SAILFIN_*` env vars first with a one-release file shim;
>     `_compile_runtime_sfn_sources` in `cli_main.sfn` spawns
>     children via `sh -c "VAR= <self> emit ..."` so child env
>     is explicit. Dormant — manifest population + C trampoline
>     removal happen in PR B of the sleep migration.
> - **`kind = "runtime"` capsules' `sfn-sources` schema is now
>   live (M2.1 issue #394 2026-05-07; M2.2 real page-chain bump
>   allocator issue #477 2026-05-25).** The active
>   `runtime/native/capsule.toml` populates `sfn-sources =
>   ["../sfn/memory/arena.sfn", …]` — the first proof-of-life
>   entry. `_compile_runtime_sfn_sources` (the consumer shipped
>   dormant in #308) fires on every `sfn build -p compiler`
>   invocation, producing
>   `build/sailfin/sfn__runtime-native__arena.sfn-O2.o` and
>   threading it into the final link. M2.1 stubbed the five
>   `sfn_arena_sfn_*` exports as libc-wrapper trampolines to
>   prove the link path; M2.2 replaces the bodies with the real
>   page-chain bump allocator per
>   `docs/runtime_architecture.md` §2.1.1 — 24-byte `Arena`
>   handle, 32-byte `ArenaPage` headers, grow-if-at-tip realloc,
>   downstream-chain reuse after reset. The Sailfin module
>   exports `sfn_arena_sfn_*` symbols that coexist with the C
>   arena's `sfn_arena_*` exports — both link side-by-side until
>   M3 retires `runtime/native/src/sailfin_arena.c`.
>   The prior (now retired) `scripts/build.sh`'s
>   `RUNTIME_SFN_ALLOW` allowlist historically mirrored the
>   manifest entry so `make check`'s stage2/stage3 fixed-point
>   binaries linked the same module set; the allowlist retired
>   alongside the script in Stage E PR7 (#383). Pinned by
>   `compiler/tests/e2e/test_runtime_sfn_sources_link_consumer.sh`
>   (synthetic-workspace consumer-fires test, dormant-era
>   regression),
>   `compiler/tests/e2e/test_runtime_sfn_sources_active.sh`
>   (production-binary `nm` audit + manifest/allowlist drift
>   check), and
>   `compiler/tests/e2e/test_runtime_memory_arena.sh`
>   (per-export typecheck/fmt/IR shape).
> - **Sailfin-native RC primitive — shipped 2026-05-21 (M2.3,
>   issue #395).** `runtime/sfn/memory/rc.sfn` exports three
>   `sfn_rc_sfn_*` symbols (`alloc` / `retain` / `release`) and
>   joins the `sfn-sources` array. The header layout
>   (`docs/runtime_architecture.md` §2.1.2) is a 16-byte prefix
>   `{ refcount: i64, drop_fn_addr: i64 }` sitting at
>   `payload - 16`; `sfn_rc_sfn_alloc` returns the payload
>   pointer with refcount initialised to 1, `sfn_rc_sfn_retain`
>   emits `atomicrmw add ptr %p, i64 1 seq_cst, align 8`, and
>   `sfn_rc_sfn_release` emits `atomicrmw sub ptr %p, i64 1
>   seq_cst, align 8` then calls `free` exactly when the
>   post-decrement guard `prev == 1` fires. drop_fn storage uses
>   an `i64` slot (`drop_fn_addr`) rather than `* u8` because the
>   seed compiler's struct-field assignment silently drops stores
>   to `* u8` fields routed through a `* StructTy` pointer;
>   `as i64` lowers to a clean `ptrtoint i8* … to i64` and a
>   64-bit store, byte-equivalent to storing the raw pointer on
>   every Sailfin platform. drop_fn **invocation** is deferred to
>   M2.4/M2.6 per the issue's `Out:` — releases that hit zero
>   call `free` directly until `sfn_drop_SfnString` /
>   `sfn_drop_SfnArray` synthesis lands. The Sailfin module's
>   `sfn_rc_sfn_*` infix coexists with the C runtime's
>   pre-existing `sfn_rc_release` no-op stub
>   (`runtime/native/src/sailfin_runtime.c:1885`, M1.5.2
>   placeholder from #326) without a link collision. Pinned by
>   `compiler/tests/e2e/test_runtime_memory_rc.sh` (typecheck +
>   fmt + LLVM `define` shape per export + `atomicrmw add / sub
>   seq_cst, align 8` IR-shape grep scoped to retain/release +
>   bare-name collision regression + clang-linked functional
>   roundtrip `alloc → retain → release → release` with an
>   interposed `free` counter asserting exactly one `free`).
> - **M0.5 arena-in-C — shipped, default-on** (`runtime/native/src/sailfin_arena.c`,
>   PR #252 + Phase 5a mark/rewind PR #251).
> - **Effect enforcement gate — shipped** (Phases A–F, PRs #241–#245). Effect
>   violations now block compilation by default.
> - **`extern fn` — shipped** (parser + native-IR emitter + LLVM `declare`
>   emission + typecheck registration as of 2026-05-01). Hard prerequisite #6
>   below is satisfied. `runtime/sfn/io.sfn` now proves runtime-module LLVM
>   call lowering against an imported extern (`write` from `./platform/libc`).
>   General typecheck-level call-site resolution remains the open follow-up;
>   today the typecheck symbol table is duplicate-detection-only.
> - **First `runtime/sfn/platform/libc.sfn` skeleton — shipped 2026-05-01**
>   (12 declarations covering libc memory, fd-based I/O, stdio filesystem,
>   environment). Pinned by
>   `compiler/tests/e2e/test_runtime_libc_skeleton.sh` (typecheck + fmt +
>   LLVM `declare` emission for every symbol).
> - **First Sailfin-native runtime service wrapper — shipped 2026-05-04.**
>   `runtime/sfn/io.sfn` imports `write` from `./platform/libc` and exposes
>   `sfn_write_fd(...) ![io]`; pinned by
>   `compiler/tests/e2e/test_runtime_io_skeleton.sh`.
> - **Three further `runtime/sfn/platform/*.sfn` skeletons — shipped
>   2026-05-02.** `pthread.sfn` (11 declarations: pthread_create / join,
>   mutex lifecycle, condition-variable lifecycle), `posix.sfn` (4
>   declarations: posix_spawnp, waitpid, clock_gettime, nanosleep), and
>   `net.sfn` (9 declarations: socket/close, connect/bind/listen/accept,
>   send/recv, setsockopt). Together they validate the extern pipeline
>   on richer C-ABI shapes than libc — pointer-to-pointer (`* * u8` for
>   `pthread_join`'s result and `posix_spawnp`'s argv/envp), primitive-
>   pointer out-parameters (`* i32` for `waitpid`'s status and
>   `accept`'s addrlen), and multiple opaque-struct families
>   (`* PthreadMutex`, `* Timespec`, `* SockAddr`). Function-pointer
>   parameters intentionally degrade to `* u8` until either `sfn fmt`
>   stops inserting a space inside `fn(...)` or
>   `is_c_abi_function_pointer` accepts the `fn (...)` form (see the
>   header of `runtime/sfn/platform/pthread.sfn`). Pinned by
>   `compiler/tests/e2e/test_runtime_{pthread,posix,net}_skeleton.sh`.
>   Not imported anywhere yet; the C runtime continues to serve these
>   calls until M2 (process / clock / sleep adapters) and M3 / M4
>   (HTTP / serve / scheduler).
> - **`int` / `float` numeric type annotations — shipped 2026-05-02**
>   (Phase 1 #2, Slice A). Hard prereq #1 below is partially satisfied:
>   `let x: int = 42` and `let x: float = 3.14` now lower to `i64` and
>   `double` respectively; integer arithmetic dispatch (`add i64` vs
>   `fadd double`) and comparison dispatch (`icmp` vs `fcmp`) are wired.
>   The extern accept-list now admits `int` / `float` so
>   `runtime/sfn/platform/*.sfn` modules can name them.
> - **Numeric Slice C — additional widths shipped 2026-05-02.** `i16`,
>   `u16`, `u32`, `u64`, `isize`, `f32` joined `map_primitive_type` and
>   `is_extern_primitive_type`. The extern accept-list now covers the
>   practical libc surface (errno_t, mode_t, dev_t, ssize_t, short,
>   single-precision floats). User-level arithmetic on these widths
>   still rides L5 (silent widening).
> - **Numeric Slice B — bitwise + shift operators shipped 2026-05-02.**
>   `&`, `|`, `^`, `<<`, `>>` lex, parse, and lower to LLVM
>   `and`/`or`/`xor`/`shl`/`ashr` on integer operands. L4 in the
>   architecture limitations table is now closed for integer operands;
>   the M3 crypto port (SHA-256, Base64 in pure Sailfin) is no longer
>   blocked at the language level. Slices D (`as` casts) and E
>   (bare-literal defaulting + `number` retirement) remain — see
>   `docs/runtime_architecture.md` §3.7 for the full slice taxonomy
>   and the L1–L6 limitations table.

## Purpose

This audit captures the **actual** current state of the Sailfin runtime — what
ships in C today, what is stubbed, what the compiler relies on, and what must
change before a Sailfin-native runtime rewrite can start. It supersedes the
pre-April 2026 audit, which was written before the build-performance work
exposed that filesystem-based IPC was acting as accidental garbage collection.

The scope is the native compiler toolchain and the runtime surface declared in
`runtime/native/include/sailfin_runtime.h` plus the helpers the compiler
requests in `compiler/src/llvm/runtime_helpers.sfn`.

## Executive Summary

- The C runtime is **~9,000 lines** (`runtime/native/src/sailfin_runtime.c`),
  the M0.5 disposable C arena (`sailfin_arena.c`), and small crypto helpers
  for SHA-256 and base64. The ~500-line C driver `native_driver.c` was
  retired in M5 (#451, 2026-05-25) — the binary's entry point is now the
  Sailfin-emitted `@main`.
- Core surfaces (print, sleep, strings, arrays, process spawn, filesystem,
  exceptions, futures-via-pthreads) are **implemented and working**.
- Effect-capability adapters (`sailfin_adapter_*`), reflection
  (`is_*`/`resolve_type`/`instance_of`), and concurrency primitives (`channel`,
  `parallel`, top-level `spawn`, `serve`) are **stubs**.
- Several helper symbols the compiler declares in `runtime_helpers.sfn`
  (e.g. `sailfin_adapter_channel_*`, `sailfin_adapter_spawn_task`)
  **do not exist in the runtime at all** — these
  are declaration-only and would fail at link time if ever emitted. They are
  effectively dead paths in the compiler today.
- **The runtime has no memory management.** Arrays never free. `string_drop`
  is disabled by default because the compiler can't emit safe drop signals.
  Strings ≥64 KB are marked persistent for process lifetime. This is the
  single largest blocker for further self-hosting perf work
  (see `docs/build-performance.md` §"The IPC-as-GC Problem").
- Defensive scaffolding (pointer plausibility checks, ASAN-safe strlen, recent-
  array ring buffers, canaries, immediate-codepoint tagged pointers) exists
  to survive bootstrap-era ABI mismatches. All of it should disappear once a
  native ABI and ownership model are in place.

## Toolchain Snapshot

- Primary toolchain: the self-hosted native compiler. `make compile` produces
  `build/native/sailfin` (statically links the C runtime).
- Runtime root: discovered by the Sailfin-emitted entry-point prologue
  (previously `native_driver.c:_resolve_runtime_root()`; retired in M5,
  #451) — walks up from `argv[0]` looking for a sibling `runtime/`
  directory, or honors `SAILFIN_RUNTIME_ROOT`.
- Python runtime shims were removed from the repository pre-1.0.
- Legacy Python compiler artifacts (`compiler/build/**`) remain only for
  emergency recovery and must be removed before 1.0.

## What the Runtime Actually Implements

The table below reflects `runtime/native/src/sailfin_runtime.c` **as of
2026-04-15** — real behaviour, not declared intent. Line references are from
the current file (6,015 lines total). "Used by compiler" means the compiler
actually emits a call to the symbol today; "Declared but unused" means the
symbol is registered in `runtime_helpers.sfn` but the compiler does not emit
calls to it in current code paths.

### Core logging & timing (implemented)

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_print_raw/err/info/warn/error` | ✅ | stdout/stderr line writes |
| `sfn_sleep` (Sailfin-native) | ✅ | Defined in `runtime/sfn/clock.sfn`; calls libc `nanosleep` directly via `runtime/sfn/platform/posix.sfn`. PR 2 of the sleep migration (#397) deleted the C `sailfin_runtime_sleep` entrypoint and the `sfn_sleep` C trampoline. |
| `sailfin_runtime_monotonic_millis` | ✅ | Superseded by Sailfin-native `sfn_clock_millis` (`runtime/sfn/clock.sfn`, issue #819); `monotonic_millis` registry rows now route there. C body retained for seed compat, dead in fresh emission. |
| `sailfin_runtime_log_execution` | ✅ | Prints value via `print.info`, returns value |

### Strings (implemented, with perf scaffolding)

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_string_length` | ✅ | Uses `_safe_strlen_asan` with ASAN-safe scanning and a tunable `SAILFIN_MAX_STRLEN_SCAN` cap |
| `sailfin_runtime_substring` / `_substring_unchecked` | ✅ | Byte-range memcpy over UTF-8 C strings |
| `sailfin_runtime_string_concat` | ✅ | malloc+copy; guarded by `SAILFIN_MAX_STRING_CONCAT`. **Phase R1 (#1217):** Sailfin-native `sfn_str_sfn_concat(a: *u8, b: *u8) -> OwnedBuf` in `runtime/sfn/string.sfn` now returns an owned buffer built via the global arena; the raw `*u8`-strandable C body stays live for seed-built IR until M3. |
| `sailfin_runtime_string_append` | ✅ | realloc-based in-place extend; compiler emits this for chained `+` intermediates where aliasing is provable. **Phase R1 (#1217):** Sailfin-native `sfn_str_sfn_append(buf: OwnedBuf, ...) -> OwnedBuf` in `runtime/sfn/string.sfn` is now a consume-and-return move; raw grow-at-tip interior behind `unsafe { }` in `arena.sfn`; uniqueness enforced by the ownership checker (#1214/#1215), closing the #1205 aliasing hazard. `sfn_str_sfn_slice` is **not** migrated (a non-owning `Slice` over an immediate-codepoint pseudo-pointer is unsound until that encoding retires — #822 / M1.A.2, tracked at #1283); it keeps its allocating `* u8` body. C bodies stay live for seed-built IR until M3. |
| `sailfin_runtime_string_to_number` / `number_to_string` | ✅ | |
| `sailfin_runtime_grapheme_count` / `grapheme_at` | ✅ | Byte-indexed; returns immediate-codepoint pseudo-strings (tagged pointer `(codepoint << 32)`) for ASCII to avoid allocation on hot paths |
| `sailfin_runtime_byte_at` / `find_byte_index` | ✅ | memchr-backed |
| `sailfin_runtime_char_code` | ✅ | Handles immediate-codepoint and legacy C strings |
| `sailfin_runtime_is_decimal_digit/whitespace_char/alpha_char` | ✅ | |
| `sailfin_runtime_copy_bytes`, `bounds_check` | ✅ | **Ported to Sailfin** (#927): `sfn_mem_copy_bytes` / `sfn_mem_bounds_check` in `runtime/sfn/memory/mem.sfn`. Descriptors flipped; C bodies retained for seed-built IR until M3. |
| `sailfin_runtime_get_field` | ✅ | **Ported to Sailfin** (#927): `sfn_mem_get_field` in `runtime/sfn/memory/mem.sfn`. Returns a lazily-allocated zeroed 4 KB safe buffer (reads as empty string / zero array / `0`/`false`); statically-resolvable members + `.variant` are handled ahead of this fallback by the GEP-replacement pass in `core_member_lowering.sfn`. |
| `sailfin_runtime_free` | ✅ | **Ported to Sailfin** (#927): `sfn_mem_free` in `runtime/sfn/memory/mem.sfn`. Null-safe; arena-mode no-op guard (`sfn_arena_enabled`) preserved so a `runtime.free` under arena mode never hands an arena pointer to libc `free`. |
| `sailfin_intrinsic_runtime_arena_mark` / `_rewind` | ✅ | **Ported to Sailfin** (#927): `sfn_arena_sfn_mark` / `sfn_arena_sfn_rewind` in `runtime/sfn/memory/arena.sfn`. Double-encoded `(page_index << 32) \| used` mark over the process-global arena (`sfn_arena_global`). Uses the `sfn_arena_sfn_*` infix to coexist with the live C `sfn_arena_mark`/`_rewind` until M3. |

**Concat-reuse optimization.** A single-slot cache
(`_concat_reuse_ptr/_cap/_len/_seq`) lets `string_concat` append in place when
the first argument is the result of the *immediately preceding* runtime call
(`_runtime_enter()` bumps `_runtime_call_seq`; any intervening exported call
invalidates the window). This is the mechanism that makes chained `a + b + c`
expressions not blow up memory — but it is **fragile** and disappears as soon
as anything else calls into the runtime between concats.

**The `string_drop` reality.** `sailfin_runtime_string_drop` keys off
`SAILFIN_ENABLE_STRING_FREE`, which defaults to **off**. Even when enabled, any
string ≥64 KB is forcibly marked persistent to avoid nondeterministic use-after-
free caused by the compiler's missing ownership model. Large compiler-generated
strings (LLVM module text, .sfn-asm artifacts) are therefore leaked for process
lifetime. (`sailfin_runtime.c:1641-1703`)

### Arrays (implemented, two distinct layouts)

The runtime carries **two** array representations because the compiler has two
lowering paths:

1. **`SailfinPtrArray` (`{ i8**, i64 }`)** for pointer-element arrays (strings,
   heap objects). Growth is managed in-place via `sailfin_runtime_array_push`
   with a hidden 2-word header (`magic`, `capacity`) before `data`, plus a
   4-slot canary after. Capacity doubles up to 1,024 then grows 25%.
   (`sailfin_runtime.c:3692-3900`)
2. **Byte-addressed arrays** for non-pointer element types. Growth is via
   `sailfin_runtime_array_push_slot(data_ptr_ptr, len_ptr, elem_size)` with a
   separate 4-word header layout (`magic`, `capacity`, `elem_size`, reserved)
   plus 32 canary bytes. (`sailfin_runtime.c:4006+`)

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_concat` | ✅ | Pointer-array concat; allocates new buffer |
| `sailfin_runtime_append_string` | ✅ | In-place push into pointer array |
| `sailfin_runtime_array_push` | ✅ | In-place pointer push (internal to runtime) |
| `sailfin_runtime_array_push_slot` | ✅ | Generic byte-wise grow for non-pointer elements |
| `sailfin_runtime_array_map/filter/reduce` | 🚫 **Stub** | `map`/`filter` return input unchanged; `reduce` returns initial |

**Arrays are never freed.** There is no `array_drop`, no RC, no arena. Every
`string[]`, `NativeFunction[]`, `LocalBinding[]` allocated during compilation
survives until process exit. This is why per-module compiler RAM reaches
0.5–1.5 GB (see `docs/build-performance.md` Root Cause 5).

### Process & filesystem (implemented)

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_process_run` | ✅ | `posix_spawnp` with argv from `SailfinPtrArray` |
| `sailfin_runtime_process_spawn_with_env` | ✅ | **#1102:** descriptor `native_signature` now routes to `@sfn_process_spawn_with_env` in `runtime/sfn/process.sfn` (three-pipe `posix_spawnp` producing the `SailfinProcessHandle` the `handle_*` family consumes; `0` on failure). The C body stays exported for seed-built IR; retired separately under #822 (M4). |
| `sailfin_adapter_fs_read_file` | ✅ | fopen/fread/strdup. **M3.1a (#814):** descriptor `native_signature` now routes to `@sfn_fs_read_file` in `runtime/sfn/adapters/filesystem.sfn` (chunked `fread` + `realloc`); the C body stays exported for seed-built IR. |
| `sailfin_adapter_fs_write_file` / `_append_file` | ✅ | **#1311 (epic #1308 C7):** `@sfn_fs_write_file` / `@sfn_fs_append_file` are **real Sailfin bodies** (`fopen` + `fwrite` + `fclose`, portable C stdio). Pre-M1.A.2 immediate-codepoint *content* falls back to the C adapter (decodes), mirroring `io.sfn`'s print family; path args unguarded per the `read_file` convention. C bodies stay exported for seed-built IR; retire under #822. |
| `sailfin_adapter_fs_write_lines` | ✅ | **#1311:** `@sfn_fs_write_lines` is a **real Sailfin body** — reads the `SfnArray` `data`/`len` via an overlay + `sailfin_intrinsic_pointer_read_i64`, writes newline-terminated lines. Immediate-codepoint entries / absurd counts delegate to the C `_v2` adapter. |
| `sailfin_adapter_fs_list_directory` | ✅ | Returns `SailfinPtrArray`. `_v2` still a C trampoline behind `@sfn_fs_list_dir` (dirent-offset story; #1311 `Out:` → epic #1308 C8). |
| `sailfin_adapter_fs_delete_file` / `_create_directory` | ✅ | |
| `sailfin_intrinsic_fs_exists` | ✅ | stat-based |
| `sailfin_adapter_fs_set_perms` | ✅ | **#1311:** real Sailfin body — `chmod(2)`, masked `& 07777`. No C call. Portable libc (Linux/macOS/Windows). POSIX-only (#366). |
| `sailfin_adapter_fs_get_perms` | ✅ | Stays a C trampoline behind `@sfn_fs_get_perms`: `struct stat`'s `st_mode` offset diverges per platform (24 Linux x86_64 / 4 macOS arm64), so a fixed-offset Sailfin read fails off-Linux (macOS fs tests). #1311 follow-up (gated on a per-platform offset story, #468). POSIX-only (#366). |
| `sailfin_adapter_fs_mkdtemp` | ✅ | Stays a C trampoline behind `@sfn_fs_mkdtemp`: `mkdtemp(3)` has no MinGW symbol, so a pure call breaks the Windows cross-link. #1311 follow-up (#468). POSIX-only (#366). |
| `sailfin_adapter_fs_is_executable` | ✅ | **#1311:** real Sailfin body — `access(X_OK)`. No C call. Portable libc. POSIX-only (#366). |
| `sailfin_adapter_fs_symlink` | ✅ | Stays a C trampoline behind `@sfn_fs_symlink`: `symlink(2)` has no MinGW symbol, so a pure call breaks the Windows cross-link. #1311 follow-up (#468). POSIX-only (#366). |

### HTTP / network

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_http_get` / `http_post_json` / `http_download` | ✅ | Implemented as `curl` subprocess via `popen`. Used by the package manager path |
| `sailfin_adapter_http_get` / `http_post` | 🚫 **Stub** | Return NULL. The adapter path (the effect-wired version) is not implemented — only the curl-subprocess package-manager path is |
| `sailfin_adapter_model_invoke_with_prompt` | 🚫 **Stub** | |
| `sailfin_adapter_serve_start` / `serve_handler_dispatch` | ✅ | **Ported to Sailfin** (#1092): `sfn_serve` / `sfn_serve_handler_dispatch` in `runtime/sfn/concurrency/serve.sfn` — a blocking HTTP/1.1 accept loop on the BSD-sockets surface that dispatches each connection to the M4.1 thread pool (`scheduler.sfn`). The `serve` lowering in `expression_lowering/native/core.sfn` emits `@sfn_serve`; the registry rows carry the `sfn_*` `native_signature`. v0: HTTP only (no TLS), blocking accept (no async), handler ABI `fn (* u8 request) -> * u8 response_body`. The legacy adapter symbols were never defined |

### Concurrency

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_spawn/parallel/channel/serve` | 🚫 **Stub** | Top-level entry points return NULL or no-op |
| `sailfin_runtime_spawn_{number,bool,ptr,void,string}(_ctx)` | ✅ | Per-task pthread via `pthread_create`; no scheduler, no pooling |
| `sailfin_runtime_await_{number,bool,ptr,void,string}` | ✅ | `pthread_join` on the per-task thread |
| `sailfin_adapter_spawn_task` / `_channel_create/send/receive` | ❌ **Missing** | Declared in `runtime_helpers.sfn`; not defined |

### Exceptions (two parallel APIs, one actually wired)

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_set_exception` / `clear_exception` / `has_exception` / `take_exception` | ✅ | TLS message slot; **this is what the compiler lowering uses today** (`compiler/src/llvm/lowering/instructions.sfn`) |
| `sailfin_runtime_try_enter` / `try_leave` / `throw` | ✅ | setjmp/longjmp-based; implemented but **not** used by current lowering |

### Reflection / type metadata

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_is_string/number/boolean/callable/array` | 🚫 **Stub** | `is_void` returns `value == NULL`; all others return `false` |
| `sailfin_runtime_resolve_type` | 🚫 **Stub** | Returns NULL |
| `sailfin_runtime_instance_of` | 🚫 **Stub** | Returns `false` |

### Capability bridges

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_create_capability_grant` | 🚫 **Stub** | |
| `sailfin_runtime_create_filesystem_bridge / _http_bridge / _model_bridge` | 🚫 **Stub** | |

### Crypto / utilities

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_sha256_hex` | ✅ (ported) | SHA-256 reimplemented in pure Sailfin in `capsules/sfn/crypto/src/mod.sfn` (M3, #816); the `crypto.sha256` intrinsic now resolves to the capsule symbol. C body in `sailfin_sha256.c` (~150 lines) stays linked for seed compat until M3.9 deletes it. |
| `sailfin_runtime_base64_encode` | ✅ | Separate file `sailfin_base64.c` |
| `sailfin_runtime_getenv` / `home_dir` / `read_file_bytes` | ✅ | Used by `sfn/os` and package manager |

## Bootstrap-Era Defensive Scaffolding

These exist to survive the current C-string ABI and missing ownership model.
All of them should **disappear** in the Sailfin-native runtime:

- **Immediate-codepoint tagged pointers.** Single-byte ASCII graphemes are
  returned as `(codepoint << 32)` cast to `char*` — never dereferenced, detected
  by `_is_immediate_codepoint_string`. Avoids a malloc per ASCII `grapheme_at`
  call in the hot lexer path, at the cost of a pointer-tag convention every
  runtime helper must check.
- **Owned-string hash table** (`_sailfin_owned_table`) with open addressing,
  tombstones, and a pthread mutex. Tracks strings the runtime allocated so
  `string_drop` can safely free them (when enabled).
- **Persistent-pointer set** (`_sailfin_persistent_table`) for strings marked
  leak-for-process-lifetime.
- **`_is_corrupted_string_ptr`** checks: reject pointers below 4 KiB, reject
  non-canonical high bits, reject known sentinel bit patterns.
- **`_safe_strlen_asan`** scans with a configurable byte cap and ASAN poison
  awareness.
- **Recent-array ring buffer** (`_recent_array_*`) gates unsafe header reads
  on pointer-array `push`/grow paths — only arrays the runtime has recently
  seen get their 2-word header read, because stack-allocated pointer arrays
  don't carry the header and reading `data[-2]` on them would segfault.
- **Canary slots** (4 pointer slots for pointer arrays, 32 bytes for generic
  arrays) detect mis-lowered writes past `len`.
- **`SAILFIN_TRACE_*` env vars** (≥30 of them) expose per-subsystem backtraces,
  allocation stats, and plausibility warnings.

Every one of these is a symptom of the compiler not knowing what it has emitted.
Fixing the compiler to emit typed, ownership-aware IR retires them wholesale.

## Compiler ↔ Runtime Integration

- `compiler/src/llvm/runtime_helpers.sfn` is the authoritative registry of
  runtime helpers the compiler will emit calls to. Each entry records target
  name (Sailfin-level), C symbol, return type, parameter types, and effects.
- `compiler/src/llvm/lowering/` lowers Sailfin-level calls to the registered
  symbols.
- Pointer arrays use `sailfin_runtime_append_string` / `sailfin_runtime_concat`
  to preserve the header/canary convention.
- Non-pointer arrays use `sailfin_runtime_array_push_slot` with the alternate
  header layout.
- Chained string `+` emits `sailfin_runtime_string_append` (realloc-based)
  instead of `sailfin_runtime_string_concat` when the LHS is a provably-
  unaliased intermediate from a prior concat/append (see
  `compiler/src/llvm/expression_lowering/native/core_strings.sfn`).
- Exception lowering uses the `set_exception`/`has_exception`/`take_exception`
  trio, not the `try_enter`/`throw` setjmp path.
- The Sailfin-emitted `@main` (M5, #451; previously `native_driver.c`)
  resolves the runtime root, detects CLI-subcommand invocation vs legacy
  `sailfin file.sfn` usage, and calls into the Sailfin-native CLI
  (`sailfin_cli_main__cli_main`) built from `compiler/src/`.

## The Memory Management Crisis (Blocks Perf, Not Just Rewrite)

This wasn't in the previous audit. Surfaced by `docs/build-performance.md` on
2026-04-15:

> Each IPC write-then-read cycle implicitly "freed" memory by letting the
> original values go out of scope while the file held the data. Removing these
> cycles keeps all intermediate values alive simultaneously, causing per-module
> RAM to spike past the 12 GB limit.

| Resource | Allocation | Deallocation | Status |
|---|---|---|---|
| Strings (<64 KB) | `malloc` | `string_drop` → `free` | **Disabled by default** |
| Strings (≥64 KB) | `malloc` | `mark_persistent` | **Permanently leaked** |
| String arrays | `malloc` | *none* | **Always leaked** |
| NativeFunction / LocalBinding arrays | `malloc` | *none* | **Always leaked** |

Implications for this audit:

1. **The perf path and the rewrite path share a blocker.** The arena allocator
   that `build-performance.md` calls out as Phase 0 is also the minimal
   memory-management primitive the Sailfin-native runtime needs first. Doing
   it once in C — as a temporary unblocker — or doing it once in Sailfin — as
   the real runtime primitive — should be a single decision, not two.
2. **The compiler must gain real drop signals before a safe runtime is
   possible.** The runtime relies on conservative drop emission keyed off
   compiler-known allocation kinds (M1.5, epic #322). Until M1.5 ships,
   the runtime can't trust any drop the compiler claims to emit. This is
   the reason `SAILFIN_ENABLE_STRING_FREE` is off by default today.
   **Stance update (epic #1209, D1/D9):** the broader "ownership types are
   deferred post-1.0" framing no longer holds for the runtime surface. A
   bounded unique-ownership / no-aliased-mutation / no-use-after-free
   analysis is now **enforced on the native runtime** for 1.0
   (`ownership_checker.sfn`) as the *structural* fix for the in-place
   grow-at-tip aliasing corruption (#1205) — proving a buffer is uniquely
   owned makes the in-place mutation sound rather than trusting a
   compiler-emitted drop after the fact. Drop emission (M1.5) and ownership
   enforcement are complementary: drops reclaim memory, ownership proves no
   live alias is stomped. User-facing ownership and full borrow checking
   remain post-1.0 (Phase U).
3. **Files-as-GC is cheap to delete but expensive to replace.** ~336 dotfile
   references to `build/sailfin/.xxx` IPC temp paths remain. Every one of those
   is a latent allocation that needs a real drop when IPC goes away.

## Compiler Prerequisites Before the Sailfin-Native Runtime Rewrite

The user (me) won't spawn a runtime-architect until these compiler-side items
are ready or explicitly deferred. Rationale: a Sailfin runtime that does not
leak, does not use-after-free, and can express itself ergonomically requires
compiler features that do not exist in the current toolchain.

### Hard prerequisites (runtime cannot be written without these)

1. **Integer types (`int` / `float`) — ✅ closed (Slice E.3b, #556, 2026-05-18).**
   Every shipped numeric slice: Slice A (annotated `: int`/`: float`
   lowering, 2026-05-02), Slice B (bitwise + shift, 2026-05-02), Slice
   C (additional widths, 2026-05-02), Slice D (`as` cast LLVM matrix,
   2026-05-03), Slice E.1 (bare-literal default + `number` alias,
   2026-05-08), Slice E.1.5 (observe-only ABI primitive diagnostic,
   2026-05-10), Slice E.2 (instruction-cluster source migration,
   2026-05-12), Slice E.3a (residual `: number` migration including
   prelude and tests, 2026-05-16), Slice E.3a-seedbump-cleanup
   (`number_to_string` mirrors + C-ABI rows, 2026-05-18), and Slice
   E.3b (symmetric strict-refusal reapply, 2026-05-18). The
   `dominant_type` chokepoint now returns an empty-string sentinel
   on mixed int↔float pairs; `harmonise_operands` and
   `coerce_operand_to_type` boundary mode emit a `[fatal]` ABI
   primitive mismatch diagnostic with the canonical fix-it
   `add \`as float\` or \`as int\` to disambiguate`. The four
   documented alias-coverage seams (prelude shadows, C-ABI
   boundaries, the runtime `is_number` predicate, the `Future`
   mapping seam) spell their boundary conversions explicitly. L1's
   array-literal carve-out and L2/L3 silent-widening are all
   closed; only L6 (the `number` keyword itself) remains as a
   deferred alias for `float`, retired by Slice E.4 post-1.0.
2. **`Result<T, E>` and the `?` operator** — roadmap §0. The runtime must be
   able to return structured errors (file open failures, HTTP errors, OOM,
   unicode decode errors) without abusing `try`/`catch` or union-sentinels.
3. **Closures that capture** — roadmap §0, #5. `spawn`, `parallel`, channel
   handlers, and map/filter/reduce all need real capturing closures. Today's
   "thunk pointer + optional ctx" adapter signatures are a workaround.
4. **Generic trait/interface constraints** (`fn sort<T: Comparable>`) —
   roadmap §2. Needed for typed containers: `Channel<T>`, `Array<T>`,
   `Future<T>`, `Hash<K, V>`, `String` wrapper over `{ptr, len}`.
5. **Conservative drop emission scoped to compiler-known allocation kinds
   (M1.5)** — tracked by epic #322 (split out of #321's M1.5 reassessment).
   The compiler emits explicit drop calls at scope exit for every owned local
   whose `LocalBinding.allocation_kind` is `"rc"`; arena-allocated locals
   emit nothing (bulk reset handles them). Conservative escape analysis
   promotes a binding to `"rc"` only at compiler-known boundaries
   (function return in v0; closure capture and channel send once those land).
   This supersedes the previous prereq pair (drop emission as a separate
   bullet, plus a "move/consume enforcement (or explicit removal)" bullet
   for ownership types). **Stance update (epic #1209, D1):** for the runtime
   surface specifically, ownership enforcement is **no longer deferred** — a
   bounded unique-ownership / no-aliased-mutation / no-use-after-free analysis
   (`ownership_checker.sfn`, the `E09xx` diagnostic family) is enforced on the
   native runtime for 1.0 as the structural fix for #1205, and `Affine<T>` /
   `Linear<T>` are enforced single-use where used (`E0901`/`E0907`). The
   runtime now both trusts compiler-emitted drops keyed off allocation kind
   **and** has its in-place mutation proven sound by unique ownership; the two
   are complementary, not alternatives. User-facing ownership / full borrow
   checking stay post-1.0 (Phase U). See `docs/runtime_architecture.md` §3.1
   for the drop seam (`LocalBinding.allocation_kind` + `emit_scope_drops`),
   `reference/preview/ownership.md` for the ownership model, and #322 for the
   sub-issue split.
6. **`extern fn` with typed linker-resolved symbols.** ✅ **Shipped 2026-05-01.**
   The Sailfin runtime must reach platform syscalls (`pthread_create`,
   `fopen`, `posix_spawnp`, `malloc`, `write`, `clock_gettime`, `socket`,
   etc.) from Sailfin source.
   - Parser: `extern fn` parses with optional `unsafe` prefix; emits
     `Statement.ExternFunctionDeclaration` in the AST.
   - Typechecker: registers extern functions in the same symbol table as
     regular fns (`kind: "extern function"`), validates C-ABI compatibility
     of every parameter and return type with diagnostics E0801 (`string`),
     E0802 (`T[]`), E0803 (type parameters), E0804 (effects on the extern),
     E0805 (other non-C-ABI types including `number`). See
     `compiler/src/typecheck_types.sfn:check_extern_signature`.
   - Native-IR emitter: emits `.fn <name>` + `.meta extern` (and `.meta
     unsafe` when applicable) in `.sfn-asm`.
   - LLVM lowering: emits `declare <ret> @<name>(<args>)` directives at
     the module level (`compiler/src/llvm/lowering/emission.sfn:332`).
   - **Runtime-module LLVM import path:** `runtime/sfn/io.sfn` imports
     `write` from `./platform/libc`; lowering emits the imported
     declaration and an unmangled call to `@write`.
   - **Open follow-up:** the typecheck symbol table is duplicate-
     detection-only; typecheck-level call-site resolution is not yet
     wired. When call-site resolution lands, `typecheck_import_loader.sfn`
     gains a parallel `imported_externs` channel keyed off
     `kind == "extern function"` so externs declared in
     `runtime/sfn/platform/*.sfn` resolve in importing modules before
     LLVM lowering.
   - **No C source files authored in the toolchain.** With `extern fn`
     shipped end-to-end, the runtime can reach platform syscalls without
     a permanent C shim. The M0.5 arena-in-C is the *only* exception,
     and it is explicitly disposable. Once the Sailfin runtime lands,
     no `.c` or `.h` file remains in the shipped toolchain.

### Soft prerequisites (runtime rewrite can start but each gap becomes a scar)

7. **Structured-unwind exception emission.** The compiler lowering currently
   threads exceptions through TLS flags and polling (`has_exception` after
   every call). Moving the runtime to Sailfin without also moving to explicit
   landing-pad emission pushes a perf tax onto every function call.
8. **ABI-version metadata in emitted IR.** `runtime_abi.md` assumes a
   `sailfin_abi_version` emitted into IR. No emitter code does this yet.
9. **Array/slice syntax primitives.** Today `string[]` and `T[]` are
   compiler-special. A Sailfin runtime should be able to define `Array<T>`
   and `Slice<T>` in Sailfin and have the compiler lower `T[]` to them.
10. **Tagged-union / sum-type layout control.** For `Value`, `Result<T, E>`,
    `Option<T>`. Enums exist but the compiler does not currently expose
    layout controls needed for niche-filled optionals and stable tag encoding.
11. **Atomic intrinsics.** ✅ **Shipped in M0 (#323).** All six builtins
    (`atomic_load`, `atomic_store`, `atomic_add`, `atomic_sub`, `atomic_cas`,
    `atomic_fence`) are parsed, emitted to native IR, and lowered to LLVM
    intrinsics (`load atomic`, `store atomic`, `atomicrmw add/sub`, `cmpxchg`,
    `fence seq_cst`). Arity and type validation (diagnostic E0806) is enforced
    during LLVM lowering (`compiler/src/llvm/atomics.sfn`); the typecheck pass
    treats atomic calls as ordinary call expressions. Implemented across
    sub-issues #331 (load/store), #332 (add/sub), #333 (cas), and #334 (fence).
    Memory ordering is `seq_cst` for v0; relaxed/acquire/release variants are
    post-1.0. RC and shared-memory concurrency primitives now have a sound
    atomic substrate.

### Items the runtime rewrite can deliberately **not** depend on

- Full concurrency (`routine`, `await`, `channel`, `spawn`) — these can be
  runtime-surfaced as Sailfin-level types once the scheduler lives in Sailfin.
  The runtime rewrite needs the *scheduler plumbing*, not the Sailfin-level
  keywords finalized.
- Model execution / prompt runtime — capability adapters can stay stubbed at
  runtime-rewrite start; they're separable work.
- LSP, notebook, package-registry — post-1.0.

## Memory Model (Target)

`site/src/content/docs/docs/reference/runtime-abi.md` calls the selection "Hybrid: arenas + RC." The audit's
position based on 2026-04-15 evidence:

- **Batch path (compiler) wants arenas, not RC.** The compiler is a short-
  lived process that allocates aggressively and discards everything at exit.
  RC's per-allocation bookkeeping is pure overhead for this workload. Arenas
  map onto the current "everything leaks, exit collects" reality — they just
  make it intentional instead of accidental. `build-performance.md` Phase 0
  makes the same call.
- **Long-running path (user programs) wants RC or arenas-per-scope, not a
  tracing GC.** No cycles to collect if the type system discourages them;
  deterministic drops align with the effect/capability model; tracing-GC stop-
  the-world is incompatible with the latency stories Sailfin wants to tell.
- **Arenas as a first-class Sailfin construct.** If the compiler gains
  explicit `arena { ... }` or `region T { ... }` syntax, both the compiler's
  needs and the user-program low-latency story collapse onto one primitive.

This is a design call, not a decision — the architect spawned after compiler
prerequisites ship should confirm or reject it.

## Pre-1.0 Removal Inventory

Entrypoints that are C-based today and must be gone by 1.0:

- `runtime/native/src/sailfin_runtime.c` (~9,000 lines)
- `runtime/native/src/sailfin_arena.c` (M0.5 disposable C arena — deleted at M3 once the Sailfin `runtime/sfn/memory/arena.sfn` subsumes every caller)
- `runtime/native/include/sailfin_runtime.h`
- `runtime/native/src/native_driver.c` — **REMOVED 2026-05-25 in M5 (#451)**. The binary's entry point is now the Sailfin-emitted `@main`.
- `runtime/native/src/sailfin_sha256.c` + `.h`
- `runtime/native/src/sailfin_base64.c` + `.h`
- `runtime/native/ir/runtime_globals.ll` (small LLVM stub file)
- `compiler/build/**` (legacy Python-generated artifacts; emergency recovery
  only, never built by the current toolchain)

## Pre-1.0 Acceptance Checklist

- [ ] Compiler lowering emits the Sailfin-native ABI — no C strings, no
      `SailfinPtrArray` header convention, no immediate-codepoint tagged
      pointers.
- [ ] C runtime removed from build artifacts and packaging.
- [ ] Native runtime implements core helpers (strings, arrays, exceptions,
      process execution, logging, timing) with equivalent semantics and tests.
- [ ] Native filesystem, HTTP, and model adapters ship, routing through real
      capability grants.
- [ ] Native scheduler implements `spawn`, `channel`, `parallel`, `serve` with
      integration tests covering the concurrency roadmap items.
- [ ] Reflection and type metadata (`is_*`, `resolve_type`, `instance_of`,
      `get_field`) are implemented against a real runtime type registry.
- [x] Sailfin-native CLI replaces `native_driver.c`. **Shipped 2026-05-25 in M5 (#451).** The compiler emits `@main` directly; `native_driver.c` is deleted.
- [ ] Memory management is a first-class runtime primitive (arena, RC, or
      hybrid — decision documented in `runtime_abi.md`). `string_drop` and an
      equivalent `array_drop` (or their native-ABI equivalents) are enabled
      by default and trusted by lowering.
- [ ] Defensive scaffolding (pointer plausibility, immediate-codepoint tag,
      owned/persistent tables, canaries, ASAN-safe strlen) is removed.
- [ ] Dead-declared helpers in `runtime_helpers.sfn` are either implemented or
      deleted.

## Suggested Milestones

Reordered from the previous audit to reflect the April 2026 reality.

- **M0 — Compiler prerequisites** (roadmap §0). Integer types, `Result<T, E>`,
  closures-with-capture. The runtime relies on conservative drop emission keyed
  off compiler-known allocation kinds (M1.5). **Stance update (epic #1209):**
  bounded ownership/aliasing enforcement on the native runtime is **no longer
  deferred** — it ships at 1.0 as the structural fix for #1205 (the
  `E09xx` family in `ownership_checker.sfn`); only *user-facing* ownership and
  full borrow checking remain post-1.0 (Phase U). The runtime rewrite cannot
  produce a better runtime than the compiler can describe.
- **M0.5 — Arena allocator in C** *(optional unblocker)*. If the compiler
  perf work needs a temporary memory-reclamation primitive before M1, it lives
  in the C runtime and is deleted at M3. Scope: bump allocator, reset per
  process. No reuse across modules.
- **M1 — Native ABI lock and codegen switch.** Finalize
  `site/src/content/docs/docs/reference/runtime-abi.md` v0, emit ABI version metadata in IR, switch string and
  array lowering to `{ptr, len, [cap]}` layouts. All subsequent work assumes
  this ABI.
- **M1.5 — Drop emission** (epic #322, split out of #321). Compiler emits
  scope-exit drop calls keyed off `LocalBinding.allocation_kind`
  (`"arena" | "rc" | "static" | "stack"`) via `emit_scope_drops` in
  `instructions_helpers.sfn`. Conservative escape rule promotes
  arena → rc only at function-return boundaries in v0; closure-capture and
  channel-send boundaries follow once those features land. Without this
  milestone every M2 service leaks (no drops emitted) and `string_drop` /
  `array_drop` stay disabled by default — see `runtime_architecture.md` §3.1.
- **M2 — Core runtime in Sailfin.** Strings, arrays, exceptions, logging,
  timing, process spawn. Minimum surface to self-host `hello-world.sfn` and
  run the test suite without the C runtime.
- **M3 — Capability adapters in Sailfin.** Filesystem, HTTP, model. Delete
  the C adapter stubs; delete `sailfin_runtime.c`.
- **M4 — Scheduler and concurrency in Sailfin.** `spawn`, `channel`,
  `parallel`, `serve`. Integrates with the (by-then-shipped) `routine`/`await`
  language features.
- **M5 — Native CLI and driver.** **Shipped 2026-05-25 (#451).** Replaced
  `native_driver.c` with a Sailfin-native `@main` entry point emitted
  directly by the compiler. Removing `runtime/native/` entirely is folded
  into M3 once the remaining C support helpers (`sailfin_runtime.c`,
  crypto, includes) port to Sailfin.

Decoupling M0 from M1-M5 is intentional: M0 is language-level work that has
value even if the runtime rewrite slips. Everything downstream compounds on
top of it.

## Cross-references

- `site/src/content/docs/docs/reference/runtime-abi.md` — target ABI contract (draft v0), updated alongside
  this audit.
- `docs/build-performance.md` — self-hosting perf analysis; source of the
  memory-management crisis findings.
- [sailfin.dev/roadmap](https://sailfin.dev/roadmap) — 1.0 priorities, including syntax reform and
  Sailfin-native runtime.
- `docs/status.md` — current feature matrix and capsule status.
