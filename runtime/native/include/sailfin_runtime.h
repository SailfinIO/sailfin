#pragma once

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#include "sailfin_arena.h"

#ifdef __cplusplus
extern "C"
{
#endif

    // The native runtime currently uses a legacy C-string ABI for many runtime calls.
    // This header intentionally keeps the ABI minimal and conservative.

    // Matches LLVM `{ i8**, i64 }` used broadly in native IR.
    typedef struct SailfinPtrArray
    {
        char **data;
        int64_t len;
    } SailfinPtrArray;

    // Matches LLVM `{ i8*, i64 }` — the M1 ABI shape for SfnString
    // (UTF-8 bytes + byte length). See docs/runtime_architecture.md §2.2.1.
    // M1.A locks the call-boundary shape; bodies still treat the data
    // pointer as NUL-terminated until M2.4 ships length-aware C bodies
    // (or the Sailfin-native runtime port replaces them entirely).
    typedef struct SfnString
    {
        char *data;
        int64_t len;
    } SfnString;

    // Matches LLVM `{ T*, i64, i64 }` — the M1 ABI shape for SfnArray
    // (data pointer + element count + capacity). See
    // docs/runtime_architecture.md §2.3.1. M1.B (#393) locks the call-
    // boundary shape; the legacy SailfinPtrArray with hidden 2-word /
    // canary header stays exported for seed-compiled IR. New compiler
    // output routes through `_v2` entrypoints that read/write `cap`
    // directly from the struct, so the hidden-header logic in
    // `_alloc_array` becomes dead code on the new call paths.
    //
    // `data` is `void*` here so the same struct can carry pointer-
    // typed elements (`char**` for string arrays — i.e., LLVM
    // `{i8**, i64, i64}`) or value-typed elements (`int64_t*` for
    // `{i64*, i64, i64}`, etc.). Each v2 entrypoint that consumes
    // an `SfnArray` interprets `data` according to the Sailfin
    // call site that emitted the call — a string-array helper
    // treats `data` as `char**`, an `i64`-array helper treats it
    // as `int64_t*`, and the polymorphic byte-wise helpers
    // (`array_push_slot_v2`) expose `data` to the caller as
    // `void**` so the caller can keep its element type.
    typedef struct SfnArray
    {
        void *data;
        int64_t len;
        int64_t cap;
    } SfnArray;

    // ---- Core helpers (minimal set) ----

    void sailfin_runtime_mark_persistent(char *ptr);

    void sailfin_runtime_print_raw(char *msg);
    void sailfin_runtime_print_err(char *msg);
#if !defined(_WIN32) && !defined(__MINGW32__)
    double print(char *msg) __attribute__((weak)); // weak alias for legacy seed compatibility
#else
    double print(char *msg); // strong on Windows (mingw ld does not support weak)
#endif
    void sailfin_runtime_print_info(char *msg);
    void sailfin_runtime_print_warn(char *msg);
    void sailfin_runtime_print_error(char *msg);

    /* The bare `sfn_print*` SfnString-by-value trampolines (M2.8 #401)
     * are now defined natively in `runtime/sfn/io.sfn` over `write(2)`
     * (#1310, C4/R3 of #1308); their C definitions and these prototypes
     * were removed so the `extern` declaration does not collide with the
     * Sailfin definition site. The `sailfin_runtime_print_*` entrypoints
     * above remain for internal C callers until #822. */

    /* `sailfin_runtime_sleep` and the `sfn_sleep` C trampoline were
     * deleted in PR 2 of the sleep migration (issue #397). The
     * `@sfn_sleep` symbol is now defined in Sailfin at
     * `runtime/sfn/clock.sfn` and linked via the runtime capsule's
     * `sfn-sources`. Compiled user `sleep(N)` calls continue to
     * resolve through the registry's `target: "sleep" -> symbol:
     * "sfn_sleep"` entry without any header surface here. */

    // Monotonic clock for profiling/timing.
    // Returns an integer millisecond count as a `double` for stage2 ABI.
    double sailfin_runtime_monotonic_millis(void);

    // ---- String helpers ----

    int64_t sailfin_runtime_string_length(char *text);
    // `end` is an absolute index (like Python slicing), not a length.
    char *sailfin_runtime_substring(char *text, int64_t start, int64_t end);
    // Legacy NUL-terminated entrypoint. Kept exported so seed-compiled
    // IR (which still emits `call i8* @sailfin_runtime_string_concat(i8*, i8*)`)
    // continues to link during the 2-pass self-host build. New compiler
    // output routes through `sailfin_runtime_string_concat_v2` below.
    char *sailfin_runtime_string_concat(char *a, char *b);

    // M1.A: takes the SfnString aggregate ABI by value. Body extracts
    // `a.data` / `b.data` and forwards to the legacy NUL-terminated
    // implementation until M2.4 rewrites for length-aware concat. Return
    // type stays `char*` (legacy NUL-terminated heap buffer) —
    // string-typed locals don't flip to aggregate until M1.A.2. The
    // suffix lets the legacy entrypoint above stay link-stable while the
    // seed bumps catch up; once the floor seed knows the new ABI the
    // suffix can retire.
    char *sailfin_runtime_string_concat_v2(SfnString a, SfnString b);
    // Append suffix to buf in-place (realloc). buf is consumed (ownership
    // transferred); suffix is borrowed. Only emitted by the compiler when buf
    // is a provably-unaliased intermediate from a prior concat/append.
    char *sailfin_runtime_string_append(char *buf, char *suffix);

    // M2.4b (#398): arena-aware concat / append entrypoints. The
    // compiler's fresh emission passes `ptr @sfn_default_arena`
    // (the address of the global pointer declared below) so these
    // signatures receive `SfnArena **` and dereference once. See
    // sailfin_runtime.c for the full migration note.
    //
    // #715 (post-#714 rename): the canonical names are the bare
    // `sfn_str_concat` / `sfn_str_append`. The `_arena`-suffixed
    // declarations are transitional trampolines kept until the
    // seed cut after #715 lands — seed v0.7.0-alpha.7 still emits
    // `@sfn_str_concat_arena` IR against this entrypoint. The next
    // seed bump retires both `_arena` declarations in a follow-up.
    // #1318 (C5 of epic #1308): the bare `sfn_str_concat` / `sfn_str_append`
    // are now real Sailfin bodies in `runtime/sfn/string.sfn`; their C
    // definitions are `static`, so the external prototypes are dropped here
    // (the same-TU `_arena` forwarders below bind to the static copies). The
    // `_arena`-suffixed prototypes stay until the seed cut after #1318 / #822.
    SfnString sfn_str_concat_arena(SfnString a, SfnString b, SfnArena **arena_slot);
    void sfn_str_append_arena(SfnString *dst, SfnString suffix, SfnArena **arena_slot);
    // #1315 (C4 of epic #1308): exported bridge primitives the Sailfin
    // string-accessor bodies in `runtime/sfn/string.sfn` call (immediate
    // decode, single-byte read, platform-gated grapheme production). These
    // retire with the immediate-encoding deletion (#1283 / #822); do not
    // grow this surface. See the bridge block in `sailfin_runtime.c`.
    // #1308: sfn_str_decode_owned / sfn_str_immediate_codepoint flipped to
    // trivial Sailfin bodies (string.sfn); C defs + protos deleted.
    int64_t sfn_str_read_byte(const char *s, int64_t idx);
    char *sfn_str_grapheme_byte(const char *real, int64_t idx);
    extern SfnArena *sfn_default_arena;
    // Drop/free a runtime-owned string (no-op for non-owned/persistent values).
    void sailfin_runtime_string_drop(char *text);
    // Scope-exit drop helper for owned RC locals (M1.5.2 / issue #326).
    // Called by emit_scope_drops at function-body scope close. Today the
    // compiler never emits a call (no local has `allocation_kind == "rc"`
    // until M1.5.5 escape promotion ships); the stub is a no-op so a
    // future caller against an arena pointer cannot trigger UAF.
    void sfn_rc_release(void *ptr);
    double sailfin_runtime_string_to_number(char *text);
    // Dynamic member access for boxed/runtime values.
    // Currently used for `.variant` on boxed enums.
    char *sailfin_runtime_get_field(char *base, char *field);

    // ---- Struct helpers ----
    // Allocate zero-initialized memory for a boxed struct literal. Part of the
    // boxed-struct ABI migration (0.5.8+): user structs are returned by pointer
    // (%Struct*) instead of as first-class LLVM aggregates, to sidestep the
    // AArch64 aggregate-return legalization ambiguity that caused cross-module
    // non-deterministic truncation under seed 0.5.7 on Apple Silicon.
    void *sailfin_runtime_alloc_struct(int64_t size_bytes);

    // Arena-aware free counterpart for `sailfin_runtime_alloc_struct`. When the
    // arena is enabled (default-on for selfhost / installed binaries) this is a
    // no-op; the arena reclaims the allocation on `runtime.arena_rewind` or
    // process exit. When the arena is disabled it falls through to libc free,
    // matching the lifetime contract that the boxed-struct ABI inherited from
    // the previous raw `@calloc` / `@free` pairing in the await unboxing path.
    // Callers must pair this with `sailfin_runtime_alloc_struct` (or any other
    // `_rt_calloc`-routed allocation) — calling it on a libc-allocated pointer
    // while the arena is on would leak that pointer.
    void sailfin_runtime_free(void *ptr);

    // ---- Array helpers ----

    // Legacy (M1 pre-cap) entrypoints. Kept exported so seed-compiled IR
    // (which still emits `{ i8**, i64 }*` array shapes) keeps linking
    // through the 2-pass self-host build. New compiler output (post #393)
    // routes through the `_v2` family below — those bodies read/write
    // capacity directly from the SfnArray struct's `cap` field instead
    // of the hidden 2-word + canary header that `_alloc_array` plants
    // in the legacy buffers.
    SailfinPtrArray *sailfin_runtime_concat(SailfinPtrArray *a, SailfinPtrArray *b);
    SailfinPtrArray *sailfin_runtime_append_string(SailfinPtrArray *a, char *text);
    SailfinPtrArray *sailfin_runtime_array_push(SailfinPtrArray *array, char *value);

    // M1.B v2 array helpers — `sailfin_runtime_concat_v2` /
    // `sailfin_runtime_append_string_v2` are now defined in
    // `runtime/sfn/array.sfn` (#1308 link-ownership flip); the C bodies are
    // retained `static` with no external linkage, so their prototypes are
    // dropped here. They accept the SfnArray struct (heap-boxed) by pointer
    // with `cap` exposed inline. Legacy entrypoints above remain the
    // first-pass / seed-compiled IR's link target.

    // M5.3 (#471): convert C `(argc, argv)` into the SfnArray ABI shape
    // that user `fn main(argv: string[])` expects. The emitted `@main`
    // wrapper calls this from its prologue; argv[0] is preserved so
    // user code observes the C convention (argv[0] = program name).
    SfnArray *sailfin_runtime_argv_to_string_array(int argc, char **argv);

    // M5.3 (#471): emit an uncaught-panic message + newline to stderr.
    // Lives behind a distinct symbol from the user-facing `sfn_print_*`
    // family so the IO-flip pin in
    // `compiler/tests/e2e/test_runtime_io_extended.sh` (which forbids
    // `sailfin_runtime_print_*` references in user IR) doesn't snag
    // the wrapper's catch-pad emission.
    void sailfin_runtime_panic_emit(char *msg);

    // M5.5 (#473): install the arena-allocator process-exit telemetry
    // hook ported from the retired C driver. Called once from the
    // compiler's Sailfin `fn main` prologue with a label string
    // (typically argv[0] — the binary path); idempotent for embedders
    // that may invoke it more than once. No-op unless
    // `SAILFIN_DUMP_ARENA_STATS` is set to a truthy value. The label
    // selection (last non-flag positional, value-flag-aware) that the
    // retired C driver performed in pre-main now happens in
    // `compiler/src/cli_main.sfn::main`. Pinned by
    // `compiler/tests/e2e/test_arena_default_on.sh`.
    void sailfin_runtime_install_arena_telemetry(char *label);

    // Generic (byte-wise) array push for non-pointer element types.
    // Mutates the backing buffer to ensure capacity and returns a pointer to the
    // newly appended slot (caller writes the element bytes there).
    char *sailfin_runtime_array_push_slot(char **data_ptr_ptr, int64_t *len_ptr, int64_t elem_size);

    // M1.B v2 byte-wise push: now defined in `runtime/sfn/array.sfn`
    // (#1308 link-ownership flip); the C body is retained `static` only, so
    // its prototype is dropped here. Takes an explicit cap pointer, grows by
    // realloc when `*len_ptr == *cap_ptr` (doubling cap, minimum 8), writes
    // the new buffer back through `*data_ptr` and the new capacity through
    // `*cap_ptr`, and returns a pointer to the just-incremented slot.

    // ---- Byte helpers ----

    // Returns the raw byte at `index` as a `number` (double) for the native ABI.
    double sailfin_runtime_byte_at(char *text, int64_t index);
    // Find byte in string using memchr. Returns index or -1 if not found.
    double sailfin_runtime_find_byte_index(char *text, double byte_value, double start_index);

    // ---- Process helpers ----
    // Execute a command (argv[0] is program). Returns the exit code.
    double sailfin_runtime_process_run(SailfinPtrArray *argv);

    // M1.B v2: same contract as `sailfin_runtime_process_run`, but
    // accepts the SfnArray ABI (cap-bearing) for argv. Body decomposes
    // and forwards to the legacy implementation pathway.
    double sailfin_runtime_process_run_v2(SfnArray *argv);

    // Terminate the process with the given exit code. Never returns.
    void sailfin_runtime_process_exit(double code);

    // Issue #365: capturing / streaming process APIs.
    //
    // `run_capture` runs the child to completion with both stdout and
    // stderr piped, drained concurrently via poll(2) to avoid pipe-
    // buffer deadlock. The exit code is returned directly (matching the
    // i64 ABI); captured stdout/stderr are stashed in thread-local
    // storage and retrieved by the Sailfin wrapper via
    // `_capture_take_stdout` / `_capture_take_stderr`. Passing `NULL`
    // for `env_flat` inherits the parent environment; an empty
    // SfnArray means "no env vars set". Non-empty `env_flat` is a flat
    // list of `"KEY=VALUE"` strings.
    //
    // Returns `-1` when the runtime itself can't complete the call
    // (invalid argv, OOM, pipe/spawn failure) — distinct from a
    // legitimate child exit code of 127 ("command not found" in the
    // shell convention).
    int64_t sailfin_runtime_process_run_capture(SfnArray *argv, SfnArray *env_flat);
    char *sailfin_runtime_process_capture_take_stdout(void);
    char *sailfin_runtime_process_capture_take_stderr(void);

    // `spawn_with_env` returns a malloc'd opaque handle cast to int64
    // (handle == 0 indicates spawn failure). The Sailfin wrapper drives
    // the child's streams via `_handle_write` / `_handle_read_stdout` /
    // `_handle_read_stderr` / `_handle_close_stdin` and reaps the child
    // with `_handle_wait`, which closes any still-open fds and frees
    // the handle. `_handle_*` calls against handle == 0 are no-ops.
    int64_t sailfin_runtime_process_spawn_with_env(SfnArray *argv, SfnArray *env_flat);
    int64_t sailfin_runtime_process_handle_write(int64_t handle_id, char *data);
    void sailfin_runtime_process_handle_close_stdin(int64_t handle_id);
    char *sailfin_runtime_process_handle_read_stdout(int64_t handle_id);
    char *sailfin_runtime_process_handle_read_stderr(int64_t handle_id);
    int64_t sailfin_runtime_process_handle_wait(int64_t handle_id);

    // Execute `cmd` via popen("r") and return its stdout as a
    // freshly-allocated runtime string. Used by `_shell_read_cmd`
    // and friends to capture command output without the shared-tmp-
    // file dance that previously raced across concurrent processes
    // (every caller writing to `/tmp/.sfn_shell_read_cmd_tmp`).
    // Returns "" on popen failure or non-zero exit; callers cannot
    // distinguish those from a legitimately empty output, matching
    // the pre-existing `_shell_read_cmd` contract.
    char *sailfin_runtime_shell_capture(char *cmd);

    // Additional prelude/runtime helpers (currently minimal implementations).
    void sailfin_runtime_copy_bytes(char *dest, char *src, int64_t length);
    char *sailfin_runtime_log_execution(char *value);
    // Issue #617: these three untyped exports are deprecated stubs
    // (silent NULL/no-op). The Sailfin-level wrappers in `sfn/sync`,
    // the prelude `runtime.channel/_spawn/_parallel` bindings, and
    // the LLVM lowering descriptors that reached them are all gone,
    // so freshly-built compilers no longer emit calls to these
    // symbols. They remain DECLARED here only because the currently
    // pinned seed's pre-built `prelude.o` still calls them; remove
    // both the declarations and the definitions below once a new
    // seed without those references is pinned. Tracked as a
    // `seed-blocker` cleanup. The typed `spawn_*` / `await_*`
    // variants further down are real pthread implementations and
    // are unaffected.
    char *sailfin_runtime_channel(double capacity);
    char *sailfin_runtime_parallel(char *thunk);
    void sailfin_runtime_spawn(char *thunk, char *name);

    // ---- Futures (native runtime) ----

    typedef struct SailfinFutureNumber SailfinFutureNumber;
    typedef struct SailfinFutureInt SailfinFutureInt;
    typedef struct SailfinFutureBool SailfinFutureBool;
    typedef struct SailfinFuturePtr SailfinFuturePtr;
    typedef struct SailfinFutureVoid SailfinFutureVoid;
    typedef struct SailfinFutureString SailfinFutureString;

    SailfinFutureNumber *sailfin_runtime_spawn_number(double (*fn)(void));
    SailfinFutureNumber *sailfin_runtime_spawn_number_ctx(double (*fn)(void *), void *ctx);
    double sailfin_runtime_await_number(SailfinFutureNumber *future);

    SailfinFutureInt *sailfin_runtime_spawn_int(int64_t (*fn)(void));
    SailfinFutureInt *sailfin_runtime_spawn_int_ctx(int64_t (*fn)(void *), void *ctx);
    int64_t sailfin_runtime_await_int(SailfinFutureInt *future);

    SailfinFutureBool *sailfin_runtime_spawn_bool(bool (*fn)(void));
    SailfinFutureBool *sailfin_runtime_spawn_bool_ctx(bool (*fn)(void *), void *ctx);
    bool sailfin_runtime_await_bool(SailfinFutureBool *future);

    SailfinFuturePtr *sailfin_runtime_spawn_ptr(void *(*fn)(void));
    SailfinFuturePtr *sailfin_runtime_spawn_ptr_ctx(void *(*fn)(void *), void *ctx);
    void *sailfin_runtime_await_ptr(SailfinFuturePtr *future);

    SailfinFutureVoid *sailfin_runtime_spawn_void(void (*fn)(void));
    SailfinFutureVoid *sailfin_runtime_spawn_void_ctx(void (*fn)(void *), void *ctx);
    void sailfin_runtime_await_void(SailfinFutureVoid *future);

    SailfinFutureString *sailfin_runtime_spawn_string(char *(*fn)(void));
    SailfinFutureString *sailfin_runtime_spawn_string_ctx(char *(*fn)(void *), void *ctx);
    char *sailfin_runtime_await_string(SailfinFutureString *future);

    char *sailfin_runtime_array_map(char *array, char *fn);
    char *sailfin_runtime_array_filter(char *array, char *fn);
    char *sailfin_runtime_array_reduce(char *array, char *fn, char *initial);

    double sailfin_runtime_grapheme_count(char *text);
    char *sailfin_runtime_grapheme_at(char *text, double index);

    bool sailfin_runtime_is_string(char *value);
    bool sailfin_runtime_is_number(char *value);
    bool sailfin_runtime_is_boolean(char *value);
    bool sailfin_runtime_is_void(char *value);
    bool sailfin_runtime_is_array(char *value);
    bool sailfin_runtime_is_callable(char *value);
    char *sailfin_runtime_resolve_type(char *value);
    bool sailfin_runtime_instance_of(char *value, char *type_descriptor);

    double sailfin_runtime_char_code(char *text);

    // ---- Character helpers (runtime-provided) ----

    // The native ABI represents characters/bytes as `number` (double).
    bool sailfin_runtime_is_decimal_digit(double ch);
    bool sailfin_runtime_is_whitespace_char(double ch);
    bool sailfin_runtime_is_alpha_char(double ch);

    // ---- Safety ----

    void sailfin_runtime_bounds_check(int64_t index, int64_t length);

    // ---- Stubs for capability/bridge APIs (to be implemented) ----

    void *sailfin_runtime_create_capability_grant(void *effects);
    void *sailfin_runtime_create_filesystem_bridge(void *config);
    void *sailfin_runtime_create_http_bridge(void *config);

    // Filesystem adapter stubs.
    void *sailfin_adapter_fs_read_file(void *path);
    void sailfin_adapter_fs_write_file(void *path, void *contents);
    void sailfin_adapter_fs_append_file(void *path, void *contents);
    SailfinPtrArray *sailfin_adapter_fs_list_directory(void *path);

    // M1.B v2 fs adapters — SfnArray-shaped string arrays.
    void sailfin_adapter_fs_write_lines_v2(void *path, SfnArray *lines);
    SfnArray *sailfin_adapter_fs_list_directory_v2(void *path);
    bool sailfin_adapter_fs_delete_file(void *path);
    bool sailfin_adapter_fs_create_directory(void *path, bool recursive);
    bool sailfin_intrinsic_fs_exists(void *path);

    // P5 (#366): perms / mkdtemp / symlink / is_executable. POSIX-only;
    // Windows builds stub to a benign failure return.
    bool sailfin_adapter_fs_set_perms(void *path, int64_t mode);
    int64_t sailfin_adapter_fs_get_perms(void *path);
    void *sailfin_adapter_fs_mkdtemp(void *prefix);
    bool sailfin_adapter_fs_is_executable(void *path);
    bool sailfin_adapter_fs_symlink(void *target, void *link);

    // Arena mark/rewind. Phase 5a (`docs/proposals/phase-5a-arena-reset.md`)
    // exposes the existing bump-allocator's mark/rewind primitive to
    // Sailfin code so in-process multi-module tools (`sfn check`,
    // `sfn test`'s test-discovery loop) can reclaim per-iteration
    // scratch allocations without invalidating cross-iteration state.
    //
    // The mark is encoded as a Sailfin `number` (double-precision
    // float; 53-bit mantissa holds any integer ≤ 2^53). Encoding:
    // page_index * 2^32 + used. When the arena is disabled
    // (SAILFIN_USE_ARENA unset) both functions are no-ops and the
    // encoded mark is 0; the rewind side accepts any value without
    // crashing.
    double sailfin_intrinsic_runtime_arena_mark(void);
    void sailfin_intrinsic_runtime_arena_rewind(double encoded_mark);

    // HTTP adapter stubs.
    void *sailfin_adapter_http_get(void *request);
    void *sailfin_adapter_http_post(void *request, void *body);

    // Package-manager HTTP helpers (curl subprocess).
    char *sailfin_runtime_http_get(const char *url);
    char *sailfin_runtime_http_post_json(const char *url, const char *json_body,
                                         const char *auth_header);
    char *sailfin_runtime_http_download(const char *url, const char *output_path);

    // Environment & path helpers.
    char *sailfin_runtime_getenv(const char *name);
    char *sailfin_runtime_home_dir(void);
    /* M2.8b (#726): the `{i8*, i64}` SfnString aggregate-ABI env readers
     * `sfn_getenv` / `sfn_home_dir` (`env.get` / `env.home`) moved to
     * `runtime/sfn/io.sfn` (C7/R7 of #1308, issue #1312). The C bodies and
     * these prototypes are removed together; emitted `call {i8*, i64}
     * @sfn_getenv(...)` now binds to the Sailfin definition. The legacy
     * single-pointer trampolines above stay (seed-built `i8*` ABI; retire
     * with #822). */
    char *sailfin_runtime_read_file_bytes(const char *path, int64_t *out_length);

    // Misc stubs.
    void *sailfin_runtime_to_debug_string(void *value);
    void sailfin_runtime_raise_value_error(void *message);

    /* Structured assertion failure hook.
     *
     * Replaces the stdout-grep heuristic in scripts/run_native_test.sh:
     * a failing `assert` lowers to a call into this helper, which
     * writes a typed record describing (file, line, col, message)
     * before the process aborts. The test runner consumes the
     * record after the test exits and surfaces a typed
     * AssertFailure to the caller — no regex matching.
     *
     * Sink resolution (first match wins):
     *   1. `SAILFIN_TEST_FAIL_FD` env var set to an open writable fd.
     *   2. `${SAILFIN_TEST_SCRATCH}/fail.bin` (append).
     *   3. No sink → write nothing. Non-test callers see the same
     *      abort path as `sailfin_runtime_raise_value_error`.
     *
     * Wire format: newline-delimited key:value text, NUL-free so the
     * record survives Sailfin's NUL-terminated string read path.
     * Documented next to the helper implementation in
     * sailfin_runtime.c.
     */
    void sailfin_assert_fail(const char *file, int64_t line, int64_t col, const char *msg);

    // ---- Exceptions (native runtime minimal) ----

    // Exception state helpers (used by native lowering).
    void sailfin_runtime_set_exception(char *message);
    void sailfin_runtime_clear_exception(void);
    bool sailfin_runtime_has_exception(void);

    // Enter a try region. Writes an opaque handle into `out_handle` and returns
    // 0 on first entry, non-zero when returning from a throw.
    int32_t sailfin_runtime_try_enter(char **out_handle);
    // Leave a try region previously entered with `sailfin_runtime_try_enter`.
    void sailfin_runtime_try_leave(char *handle);
    // Raise an exception and transfer control to the nearest enclosing try/catch.
    void sailfin_runtime_throw(char *message);
    // Retrieve the most recent exception message (clears the stored message).
    char *sailfin_runtime_take_exception(void);

#ifdef __cplusplus
}
#endif
