#pragma once

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

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

    void sailfin_runtime_sleep(double seconds);

    // Monotonic clock for profiling/timing.
    // Returns an integer millisecond count as a `double` for stage2 ABI.
    double sailfin_runtime_monotonic_millis(void);

    // ---- String helpers ----

    int64_t sailfin_runtime_string_length(char *text);
    // `end` is an absolute index (like Python slicing), not a length.
    char *sailfin_runtime_substring(char *text, int64_t start, int64_t end);
    char *sailfin_runtime_string_concat(char *a, char *b);
    // Append suffix to buf in-place (realloc). buf is consumed (ownership
    // transferred); suffix is borrowed. Only emitted by the compiler when buf
    // is a provably-unaliased intermediate from a prior concat/append.
    char *sailfin_runtime_string_append(char *buf, char *suffix);
    // Drop/free a runtime-owned string (no-op for non-owned/persistent values).
    void sailfin_runtime_string_drop(char *text);
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

    // ---- Array helpers ----

    // For `{ i8**, i64 }*` concatenation, native IR uses `@sailfin_runtime_concat({i8**,i64}*,{i8**,i64}*)`.
    SailfinPtrArray *sailfin_runtime_concat(SailfinPtrArray *a, SailfinPtrArray *b);
    SailfinPtrArray *sailfin_runtime_append_string(SailfinPtrArray *a, char *text);
    SailfinPtrArray *sailfin_runtime_array_push(SailfinPtrArray *array, char *value);

    // Generic (byte-wise) array push for non-pointer element types.
    // Mutates the backing buffer to ensure capacity and returns a pointer to the
    // newly appended slot (caller writes the element bytes there).
    char *sailfin_runtime_array_push_slot(char **data_ptr_ptr, int64_t *len_ptr, int64_t elem_size);

    // ---- Byte helpers ----

    // Returns the raw byte at `index` as a `number` (double) for the native ABI.
    double sailfin_runtime_byte_at(char *text, int64_t index);
    // Find byte in string using memchr. Returns index or -1 if not found.
    double sailfin_runtime_find_byte_index(char *text, double byte_value, double start_index);

    // ---- Process helpers ----
    // Execute a command (argv[0] is program). Returns the exit code.
    double sailfin_runtime_process_run(SailfinPtrArray *argv);

    // Terminate the process with the given exit code. Never returns.
    void sailfin_runtime_process_exit(double code);

    // Additional prelude/runtime helpers (currently minimal implementations).
    void sailfin_runtime_copy_bytes(char *dest, char *src, int64_t length);
    char *sailfin_runtime_log_execution(char *value);
    char *sailfin_runtime_channel(double capacity);
    char *sailfin_runtime_parallel(char *thunk);
    void sailfin_runtime_spawn(char *thunk, char *name);
    void sailfin_runtime_serve(char *handler, char *config);

    // ---- Futures (native runtime) ----

    typedef struct SailfinFutureNumber SailfinFutureNumber;
    typedef struct SailfinFutureBool SailfinFutureBool;
    typedef struct SailfinFuturePtr SailfinFuturePtr;
    typedef struct SailfinFutureVoid SailfinFutureVoid;
    typedef struct SailfinFutureString SailfinFutureString;

    SailfinFutureNumber *sailfin_runtime_spawn_number(double (*fn)(void));
    SailfinFutureNumber *sailfin_runtime_spawn_number_ctx(double (*fn)(void *), void *ctx);
    double sailfin_runtime_await_number(SailfinFutureNumber *future);

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

    // ---- Fast string helpers (unchecked) ----

    // These helpers assume the caller has already validated bounds.
    // They exist to avoid repeatedly scanning large strings with strlen.
    char *sailfin_runtime_substring_unchecked(char *text, int64_t start, int64_t end);

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
    bool sailfin_adapter_fs_delete_file(void *path);
    bool sailfin_adapter_fs_create_directory(void *path, bool recursive);
    bool sailfin_intrinsic_fs_exists(void *path);

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
    char *sailfin_runtime_read_file_bytes(const char *path, int64_t *out_length);

    // Misc stubs.
    void *sailfin_runtime_to_debug_string(void *value);
    void sailfin_runtime_raise_value_error(void *message);

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
