# Runtime Audit: Sailfin-Native Runtime Plan

**Date:** 2026-04-15 (last reviewed 2026-05-04 — see "Status delta" below)
**Previous revision:** pre-April 2026 (dated, superseded)
**Companion docs:** `site/src/content/docs/docs/reference/runtime-abi.md` (target ABI), `docs/build-performance.md`
(self-hosting perf analysis that surfaced the memory-management crisis)

> **Status delta since 2026-04-15** (keep this list short; once an item is
> fully shipped fold it into the body and remove the bullet here):
>
> - **M0.5 arena-in-C — shipped, default-on** (`runtime/native/src/sailfin_arena.c`,
>   PR #252 + Phase 5a mark/rewind PR #251).
> - **Effect enforcement gate — shipped** (Phases A–F, PRs #241–#245). Effect
>   violations now block compilation by default.
> - **`extern fn` — shipped** (parser + native-IR emitter + LLVM `declare`
>   emission + typecheck registration as of 2026-05-01). Hard prerequisite #7
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

- The C runtime is **~6,000 lines** (`runtime/native/src/sailfin_runtime.c`)
  plus a ~500-line C driver (`native_driver.c`) and small crypto helpers for
  SHA-256 and base64.
- Core surfaces (print, sleep, strings, arrays, process spawn, filesystem,
  exceptions, futures-via-pthreads) are **implemented and working**.
- Effect-capability adapters (`sailfin_adapter_*`), reflection
  (`is_*`/`resolve_type`/`instance_of`), and concurrency primitives (`channel`,
  `parallel`, top-level `spawn`, `serve`) are **stubs**.
- Several helper symbols the compiler declares in `runtime_helpers.sfn`
  (e.g. `sailfin_intrinsic_io_read`, `sailfin_adapter_channel_*`,
  `sailfin_adapter_spawn_task`) **do not exist in the runtime at all** — these
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
- Runtime root: discovered by `native_driver.c:_resolve_runtime_root()` — walks
  up from `argv[0]` looking for a sibling `runtime/` directory, or honors
  `SAILFIN_RUNTIME_ROOT`.
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
| `sailfin_runtime_sleep` | ✅ | Accepts milliseconds as double |
| `sailfin_runtime_monotonic_millis` | ✅ | Clock-backed, used for bench |
| `sailfin_runtime_log_execution` | ✅ | Prints value via `print.info`, returns value |

### Strings (implemented, with perf scaffolding)

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_string_length` | ✅ | Uses `_safe_strlen_asan` with ASAN-safe scanning and a tunable `SAILFIN_MAX_STRLEN_SCAN` cap |
| `sailfin_runtime_substring` / `_substring_unchecked` | ✅ | Byte-range memcpy over UTF-8 C strings |
| `sailfin_runtime_string_concat` | ✅ | malloc+copy; guarded by `SAILFIN_MAX_STRING_CONCAT` |
| `sailfin_runtime_string_append` | ✅ | realloc-based in-place extend; compiler emits this for chained `+` intermediates where aliasing is provable |
| `sailfin_runtime_string_to_number` / `number_to_string` | ✅ | |
| `sailfin_runtime_grapheme_count` / `grapheme_at` | ✅ | Byte-indexed; returns immediate-codepoint pseudo-strings (tagged pointer `(codepoint << 32)`) for ASCII to avoid allocation on hot paths |
| `sailfin_runtime_byte_at` / `find_byte_index` | ✅ | memchr-backed |
| `sailfin_runtime_char_code` | ✅ | Handles immediate-codepoint and legacy C strings |
| `sailfin_runtime_is_decimal_digit/whitespace_char/alpha_char` | ✅ | |
| `sailfin_runtime_copy_bytes`, `bounds_check` | ✅ | |
| `sailfin_runtime_get_field` | ✅ | Only implemented for `.variant` on boxed enums — everything else returns NULL |

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
| `sailfin_adapter_fs_read_file` | ✅ | fopen/fread/strdup |
| `sailfin_adapter_fs_write_file` / `_append_file` / `_write_lines` | ✅ | |
| `sailfin_adapter_fs_list_directory` | ✅ | Returns `SailfinPtrArray` |
| `sailfin_adapter_fs_delete_file` / `_create_directory` | ✅ | |
| `sailfin_intrinsic_fs_exists` | ✅ | stat-based |

### HTTP / network

| Symbol | Status | Notes |
|---|---|---|
| `sailfin_runtime_http_get` / `http_post_json` / `http_download` | ✅ | Implemented as `curl` subprocess via `popen`. Used by the package manager path |
| `sailfin_adapter_http_get` / `http_post` | 🚫 **Stub** | Return NULL. The adapter path (the effect-wired version) is not implemented — only the curl-subprocess package-manager path is |
| `sailfin_adapter_model_invoke_with_prompt` | 🚫 **Stub** | |
| `sailfin_adapter_serve_start` / `serve_handler_dispatch` | ❌ **Missing** | Declared in `runtime_helpers.sfn`; not defined in the runtime |

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
| `sailfin_runtime_sha256_hex` | ✅ | Separate file `sailfin_sha256.c` (~150 lines) |
| `sailfin_runtime_base64_encode` | ✅ | Separate file `sailfin_base64.c` |
| `sailfin_runtime_getenv` / `home_dir` / `read_file_bytes` | ✅ | Used by `sfn/os` and package manager |
| `sailfin_enum_tag_from_instruction_array` | ✅ | Seedcheck workaround for reading `i32` enum tags when `match`/field-access is unavailable |

### Helpers the compiler declares but never emits (link-time landmines)

`compiler/src/llvm/runtime_helpers.sfn` registers these symbols in the runtime
helper descriptor table, but they have **no C definition**. They appear to be
aspirational placeholders left over from earlier effect-adapter plans:

- `sailfin_intrinsic_io_read`
- `sailfin_intrinsic_fs_read`, `sailfin_intrinsic_fs_write`
- `sailfin_intrinsic_model_invoke`
- `sailfin_intrinsic_net_request`
- `sailfin_intrinsic_http_get`, `sailfin_intrinsic_http_post`
- `sailfin_adapter_serve_start`, `sailfin_adapter_serve_handler_dispatch`
- `sailfin_adapter_spawn_task`
- `sailfin_adapter_channel_create`, `_channel_send`, `_channel_receive`

No current compiler path emits calls to these, so the build links clean. If
someone ever extends an existing lowering path to route through one of these
(e.g. wires `io.read()` to `sailfin_intrinsic_io_read`), the build will fail at
link time. Worth cleaning up when the ABI is locked: either delete the entries
from the registry, or define stub C symbols so the names mean something.

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
- The C `native_driver` resolves the runtime root, detects CLI-subcommand
  invocation vs legacy `sailfin file.sfn` usage, and calls into the Sailfin-
  native CLI (`sailfin_cli_main__cli_main`) built from `compiler/src/`.

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
   possible.** Affine/Linear are parsed but not enforced; without enforcement,
   the runtime can't trust any drop the compiler claims to emit. This is the
   reason `SAILFIN_ENABLE_STRING_FREE` is off by default today.
3. **Files-as-GC is cheap to delete but expensive to replace.** ~336 dotfile
   references to `build/sailfin/.xxx` IPC temp paths remain. Every one of those
   is a latent allocation that needs a real drop when IPC goes away.

## Compiler Prerequisites Before the Sailfin-Native Runtime Rewrite

The user (me) won't spawn a runtime-architect until these compiler-side items
are ready or explicitly deferred. Rationale: a Sailfin runtime that does not
leak, does not use-after-free, and can express itself ergonomically requires
compiler features that do not exist in the current toolchain.

### Hard prerequisites (runtime cannot be written without these)

1. **Integer types (`int` / `float`)** — roadmap §0. **Slice A shipped
   2026-05-02.** Annotated locals/parameters/returns of `int` and `float`
   now lower to `i64` / `double` respectively; integer arithmetic dispatch
   and comparison dispatch are wired. The extern accept-list admits both.
   Slices B–E (bitwise ops, additional widths, `as` casts, bare-literal
   defaulting + `number` retirement) remain — see
   `docs/runtime_architecture.md` §3.7 for the slice taxonomy and the
   limitations table (L1–L6). The pre-Slice-A "everything is a double"
   ABI rationale below still applies to bare literals (L1) until Slice E
   migrates the compiler source off `number`.
2. **`Result<T, E>` and the `?` operator** — roadmap §0. The runtime must be
   able to return structured errors (file open failures, HTTP errors, OOM,
   unicode decode errors) without abusing `try`/`catch` or union-sentinels.
3. **Closures that capture** — roadmap §0, #5. `spawn`, `parallel`, channel
   handlers, and map/filter/reduce all need real capturing closures. Today's
   "thunk pointer + optional ctx" adapter signatures are a workaround.
4. **Generic trait/interface constraints** (`fn sort<T: Comparable>`) —
   roadmap §2. Needed for typed containers: `Channel<T>`, `Array<T>`,
   `Future<T>`, `Hash<K, V>`, `String` wrapper over `{ptr, len}`.
5. **Destructors / deterministic drop emission** — no roadmap entry yet.
   The compiler needs to emit explicit drop calls at scope exit for any type
   that owns heap state. Without this, the runtime can't distinguish "caller
   handed me this to consume" from "caller wants to keep using this."
6. **Affine/Linear enforcement (or explicit removal)** — roadmap §2. Either
   actually enforce move/consume so the runtime can trust drop signals, or
   remove the syntax. "Parsed but unenforced" is worse than absent because
   it implies a guarantee the runtime can't rely on.
7. **`extern fn` with typed linker-resolved symbols.** ✅ **Shipped 2026-05-01.**
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

8. **Structured-unwind exception emission.** The compiler lowering currently
   threads exceptions through TLS flags and polling (`has_exception` after
   every call). Moving the runtime to Sailfin without also moving to explicit
   landing-pad emission pushes a perf tax onto every function call.
9. **ABI-version metadata in emitted IR.** `runtime_abi.md` assumes a
   `sailfin_abi_version` emitted into IR. No emitter code does this yet.
10. **Array/slice syntax primitives.** Today `string[]` and `T[]` are
    compiler-special. A Sailfin runtime should be able to define `Array<T>`
    and `Slice<T>` in Sailfin and have the compiler lower `T[]` to them.
11. **Tagged-union / sum-type layout control.** For `Value`, `Result<T, E>`,
    `Option<T>`. Enums exist but the compiler does not currently expose
    layout controls needed for niche-filled optionals and stable tag encoding.
12. **Atomic intrinsics.** Reference counting and the scheduler's task queue
    need atomic increment/decrement, compare-and-swap, and fence operations.
    LLVM provides these as intrinsics; the compiler must expose them as
    typed Sailfin builtins (e.g. `atomic_add`, `atomic_cas`). Without this,
    RC and any shared-memory concurrency primitive is unsound.

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

- `runtime/native/src/sailfin_runtime.c` (~6,015 lines)
- `runtime/native/include/sailfin_runtime.h`
- `runtime/native/src/native_driver.c` (~504 lines)
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
- [ ] Sailfin-native CLI replaces `native_driver.c`.
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

- **M0 — Compiler prerequisites** (roadmap §0 + ownership enforcement).
  Integer types, `Result<T, E>`, closures-with-capture, destructors,
  enforceable ownership. The runtime rewrite cannot produce a better runtime
  than the compiler can describe.
- **M0.5 — Arena allocator in C** *(optional unblocker)*. If the compiler
  perf work needs a temporary memory-reclamation primitive before M1, it lives
  in the C runtime and is deleted at M3. Scope: bump allocator, reset per
  process. No reuse across modules.
- **M1 — Native ABI lock and codegen switch.** Finalize
  `site/src/content/docs/docs/reference/runtime-abi.md` v0, emit ABI version metadata in IR, switch string and
  array lowering to `{ptr, len, [cap]}` layouts. All subsequent work assumes
  this ABI.
- **M2 — Core runtime in Sailfin.** Strings, arrays, exceptions, logging,
  timing, process spawn. Minimum surface to self-host `hello-world.sfn` and
  run the test suite without the C runtime.
- **M3 — Capability adapters in Sailfin.** Filesystem, HTTP, model. Delete
  the C adapter stubs; delete `sailfin_runtime.c`.
- **M4 — Scheduler and concurrency in Sailfin.** `spawn`, `channel`,
  `parallel`, `serve`. Integrates with the (by-then-shipped) `routine`/`await`
  language features.
- **M5 — Native CLI and driver.** Replace `native_driver.c` with a Sailfin-
  native entrypoint; remove `runtime/native/` entirely.

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
