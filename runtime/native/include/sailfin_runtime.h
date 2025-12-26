#pragma once

#include <stdbool.h>
#include <stddef.h>
#include <stdint.h>

#ifdef __cplusplus
extern "C"
{
#endif

    // Stage2 currently uses a legacy C-string ABI for many runtime calls.
    // This header intentionally keeps the ABI minimal and conservative.

    // Matches LLVM `{ i8**, i64 }` used broadly in stage2 IR.
    typedef struct SailfinPtrArray
    {
        char **data;
        int64_t len;
    } SailfinPtrArray;

    // ---- Core helpers (minimal set) ----

    void sailfin_runtime_mark_persistent(char *ptr);

    void sailfin_runtime_print_info(char *msg);
    void sailfin_runtime_print_warn(char *msg);
    void sailfin_runtime_print_error(char *msg);

    void sailfin_runtime_sleep(double seconds);

    // ---- String helpers ----

    int64_t sailfin_runtime_string_length(char *text);
    // `end` is an absolute index (like Python slicing), not a length.
    char *sailfin_runtime_substring(char *text, int64_t start, int64_t end);
    char *sailfin_runtime_string_concat(char *a, char *b);
    // Dynamic member access for boxed/runtime values.
    // Currently used for `.variant` on boxed enums.
    char *sailfin_runtime_get_field(char *base, char *field);

    // ---- Array helpers ----

    // For `{ i8**, i64 }*` concatenation, stage2 uses `@sailfin_runtime_concat({i8**,i64}*,{i8**,i64}*)`.
    SailfinPtrArray *sailfin_runtime_concat(SailfinPtrArray *a, SailfinPtrArray *b);
    SailfinPtrArray *sailfin_runtime_append_string(SailfinPtrArray *a, char *text);

    // ---- Process helpers ----
    // Execute a command (argv[0] is program). Returns the exit code.
    double sailfin_runtime_process_run(SailfinPtrArray *argv);

    // Additional prelude/runtime helpers (currently minimal implementations).
    void sailfin_runtime_copy_bytes(char *dest, char *src, int64_t length);
    char *sailfin_runtime_log_execution(char *value);
    char *sailfin_runtime_channel(double capacity);
    char *sailfin_runtime_parallel(char *thunk);
    void sailfin_runtime_spawn(char *thunk, char *name);
    void sailfin_runtime_serve(char *handler, char *config);

    // ---- Futures (stage2-native) ----

    typedef struct SailfinFutureNumber SailfinFutureNumber;
    typedef struct SailfinFutureVoid SailfinFutureVoid;
    typedef struct SailfinFutureString SailfinFutureString;

    SailfinFutureNumber *sailfin_runtime_spawn_number(double (*fn)(void));
    SailfinFutureNumber *sailfin_runtime_spawn_number_ctx(double (*fn)(void *), void *ctx);
    double sailfin_runtime_await_number(SailfinFutureNumber *future);

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

    bool sailfin_runtime_is_decimal_digit(int8_t ch);
    bool sailfin_runtime_is_whitespace_char(int8_t ch);

    // ---- Safety ----

    void sailfin_runtime_bounds_check(int64_t index, int64_t length);

    // ---- Stubs for capability/bridge APIs (to be implemented) ----

    void *sailfin_runtime_create_capability_grant(void *effects);
    void *sailfin_runtime_create_filesystem_bridge(void *config);
    void *sailfin_runtime_create_http_bridge(void *config);
    void *sailfin_runtime_create_model_bridge(void *config);

    // Filesystem adapter stubs.
    void *sailfin_adapter_fs_read_file(void *path);
    void sailfin_adapter_fs_write_file(void *path, void *contents);
    SailfinPtrArray *sailfin_adapter_fs_list_directory(void *path);
    bool sailfin_adapter_fs_delete_file(void *path);
    bool sailfin_adapter_fs_create_directory(void *path, bool recursive);
    bool sailfin_intrinsic_fs_exists(void *path);

    // HTTP/model stubs.
    void *sailfin_adapter_http_get(void *request);
    void *sailfin_adapter_http_post(void *request, void *body);
    void *sailfin_adapter_model_invoke_with_prompt(void *model, void *prompt);

    // Misc stubs.
    void *sailfin_runtime_to_debug_string(void *value);
    void sailfin_runtime_raise_value_error(void *message);

    // ---- Exceptions (stage2-native minimal) ----

    // Exception state helpers (used by stage2-native lowering).
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
