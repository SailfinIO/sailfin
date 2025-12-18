#include "sailfin_runtime.h"

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

// These helpers are implemented inside the stage2-compiled IR objects (e.g.
// prelude.o, native_lowering.o). The native runtime calls into them but must
// not provide its own definitions, or the final link will fail with duplicate
// symbols.
extern bool strings_equal(char *a, char *b);
extern char *char_at(char *text, double index);

static void _print_line(const char *prefix, const char *msg)
{
    if (!msg)
    {
        msg = "";
    }
    if (prefix)
    {
        fputs(prefix, stderr);
    }
    fputs(msg, stderr);
    fputc('\n', stderr);
    fflush(stderr);
}

void sailfin_runtime_mark_persistent(char *ptr)
{
    (void)ptr;
}

void sailfin_runtime_print_info(char *msg) { _print_line("[info] ", msg); }
void sailfin_runtime_print_warn(char *msg) { _print_line("[warn] ", msg); }
void sailfin_runtime_print_error(char *msg) { _print_line("[error] ", msg); }

void sailfin_runtime_sleep(double seconds)
{
    if (seconds <= 0.0)
    {
        return;
    }
    double micros = seconds * 1000000.0;
    if (micros > 2147483647.0)
    {
        micros = 2147483647.0;
    }
    usleep((useconds_t)micros);
}

int64_t sailfin_runtime_string_length(char *text)
{
    if (!text)
    {
        return 0;
    }

    int64_t length = (int64_t)strlen(text);

    const char *trace = getenv("SAILFIN_TRACE_STRING_LENGTH");
    if (trace && trace[0] != '\0')
    {
        static int trace_budget = 32;
        if (trace_budget > 0)
        {
            trace_budget--;
            unsigned char b0 = (unsigned char)text[0];
            unsigned char b1 = 0;
            bool has_b1 = false;

            // Safe peek: only read a second byte when strlen proved it exists.
            if (length >= 1)
            {
                b1 = (unsigned char)text[1];
                has_b1 = true;
            }

            if (has_b1)
            {
                fprintf(stderr, "[stage2-native] string_length(%p)=%lld first_bytes=%02x%02x\n", (void *)text, (long long)length, b0, b1);
            }
            else
            {
                fprintf(stderr, "[stage2-native] string_length(%p)=%lld first_byte=%02x\n", (void *)text, (long long)length, b0);
            }
            fflush(stderr);
        }
    }

    return length;
}

char *sailfin_runtime_substring(char *text, int64_t start, int64_t end)
{
    if (!text)
    {
        char *out = (char *)malloc(1);
        if (out)
        {
            out[0] = '\0';
        }
        return out;
    }

    int64_t n = (int64_t)strlen(text);
    if (start < 0)
    {
        start = 0;
    }
    if (start > n)
    {
        start = n;
    }
    if (end < start)
    {
        end = start;
    }
    if (end > n)
    {
        end = n;
    }

    int64_t length = end - start;

    char *out = (char *)malloc((size_t)length + 1);
    if (!out)
    {
        return NULL;
    }
    if (length > 0)
    {
        memcpy(out, text + start, (size_t)length);
    }
    out[length] = '\0';
    return out;
}

char *sailfin_runtime_string_concat(char *a, char *b)
{
    if (!a)
    {
        a = "";
    }
    if (!b)
    {
        b = "";
    }
    size_t alen = strlen(a);
    size_t blen = strlen(b);
    char *out = (char *)malloc(alen + blen + 1);
    if (!out)
    {
        return NULL;
    }
    memcpy(out, a, alen);
    memcpy(out + alen, b, blen);
    out[alen + blen] = '\0';
    return out;
}

static SailfinPtrArray *_alloc_array(int64_t len)
{
    SailfinPtrArray *arr = (SailfinPtrArray *)malloc(sizeof(SailfinPtrArray));
    if (!arr)
    {
        return NULL;
    }

    // Defensive: corrupted lengths can cause OOM and get the process SIGKILLed.
    // Stage2 should never build arrays anywhere near this size.
    if (len < 0)
    {
        len = 0;
    }
    if (len > 10000000)
    {
        fprintf(stderr, "[stage2-native] refusing to allocate array of len=%lld\n", (long long)len);
        abort();
    }

    arr->len = len;

    // Stage2 IR frequently uses a non-null backing buffer for empty arrays.
    // Preserve that property to avoid null pointer arithmetic in generated code.
    size_t slots = (len > 0) ? (size_t)len : 1u;
    arr->data = (char **)calloc(slots, sizeof(char *));
    if (!arr->data)
    {
        free(arr);
        return NULL;
    }
    return arr;
}

SailfinPtrArray *sailfin_runtime_concat(SailfinPtrArray *a, SailfinPtrArray *b)
{
    int64_t alen = a ? a->len : 0;
    int64_t blen = b ? b->len : 0;
    if (alen < 0)
    {
        alen = 0;
    }
    if (blen < 0)
    {
        blen = 0;
    }

    SailfinPtrArray *out = _alloc_array(alen + blen);
    if (!out)
    {
        return NULL;
    }

    int64_t i = 0;
    if (a && a->data)
    {
        for (; i < alen; i++)
        {
            out->data[i] = a->data[i];
        }
    }
    if (b && b->data)
    {
        for (int64_t j = 0; j < blen; j++)
        {
            out->data[i + j] = b->data[j];
        }
    }

    return out;
}

SailfinPtrArray *sailfin_runtime_append_string(SailfinPtrArray *a, char *text)
{
    int64_t alen = a ? a->len : 0;
    if (alen < 0)
    {
        alen = 0;
    }
    SailfinPtrArray *out = _alloc_array(alen + 1);
    if (!out)
    {
        return NULL;
    }
    for (int64_t i = 0; i < alen; i++)
    {
        out->data[i] = (a && a->data) ? a->data[i] : NULL;
    }
    out->data[alen] = text;
    return out;
}
bool sailfin_runtime_is_decimal_digit(int8_t ch)
{
    return (ch >= '0' && ch <= '9');
}

bool sailfin_runtime_is_whitespace_char(int8_t ch)
{
    return (ch == ' ' || ch == '\t' || ch == '\n' || ch == '\r');
}

void sailfin_runtime_bounds_check(int64_t index, int64_t length)
{
    if (index < 0 || index >= length)
    {
        fprintf(stderr, "[stage2-native] bounds_check failed: index=%lld length=%lld\n", (long long)index,
                (long long)length);
        abort();
    }
}

void sailfin_runtime_copy_bytes(char *dest, char *src, int64_t length)
{
    if (!dest || !src || length <= 0)
    {
        return;
    }
    memcpy(dest, src, (size_t)length);
}

char *sailfin_runtime_log_execution(char *value)
{
    return value;
}

char *sailfin_runtime_channel(double capacity)
{
    (void)capacity;
    return NULL;
}

char *sailfin_runtime_parallel(char *thunk)
{
    (void)thunk;
    return NULL;
}

void sailfin_runtime_spawn(char *thunk, char *name)
{
    (void)thunk;
    (void)name;
}

void sailfin_runtime_serve(char *handler, char *config)
{
    (void)handler;
    (void)config;
}

char *sailfin_runtime_array_map(char *array, char *fn)
{
    (void)fn;
    return array;
}

char *sailfin_runtime_array_filter(char *array, char *fn)
{
    (void)fn;
    return array;
}

char *sailfin_runtime_array_reduce(char *array, char *fn, char *initial)
{
    (void)array;
    (void)fn;
    return initial;
}

double sailfin_runtime_grapheme_count(char *text)
{
    return (double)sailfin_runtime_string_length(text);
}

char *sailfin_runtime_grapheme_at(char *text, double index)
{
    return char_at(text, index);
}

bool sailfin_runtime_is_string(char *value)
{
    (void)value;
    return false;
}

bool sailfin_runtime_is_number(char *value)
{
    (void)value;
    return false;
}

bool sailfin_runtime_is_boolean(char *value)
{
    (void)value;
    return false;
}

bool sailfin_runtime_is_void(char *value)
{
    return value == NULL;
}

bool sailfin_runtime_is_array(char *value)
{
    (void)value;
    return false;
}

bool sailfin_runtime_is_callable(char *value)
{
    (void)value;
    return false;
}

char *sailfin_runtime_resolve_type(char *value)
{
    (void)value;
    return NULL;
}

bool sailfin_runtime_instance_of(char *value, char *type_descriptor)
{
    (void)value;
    (void)type_descriptor;
    return false;
}

double sailfin_runtime_char_code(char *text)
{
    if (!text || !text[0])
    {
        return -1.0;
    }

    // Stage2 currently uses a legacy UTF-8 C-string ABI; most compiler logic
    // assumes ASCII punctuation/operators. Match Python's `ord(text[0])` for
    // the first byte.
    unsigned char ch = (unsigned char)text[0];
    return (double)ch;
}

// ---- Stubs / placeholders ----

void *sailfin_runtime_create_capability_grant(void *effects)
{
    (void)effects;
    return NULL;
}

void *sailfin_runtime_create_filesystem_bridge(void *config)
{
    (void)config;
    return NULL;
}

void *sailfin_runtime_create_http_bridge(void *config)
{
    (void)config;
    return NULL;
}

void *sailfin_runtime_create_model_bridge(void *config)
{
    (void)config;
    return NULL;
}

void *sailfin_adapter_fs_read_file(void *path)
{
    (void)path;
    return NULL;
}

void sailfin_adapter_fs_write_file(void *path, void *contents)
{
    (void)path;
    (void)contents;
}

void *sailfin_adapter_fs_list_directory(void *path)
{
    (void)path;
    return NULL;
}

bool sailfin_adapter_fs_delete_file(void *path)
{
    (void)path;
    return false;
}

bool sailfin_adapter_fs_create_directory(void *path, bool recursive)
{
    (void)path;
    (void)recursive;
    return false;
}

bool sailfin_intrinsic_fs_exists(void *path)
{
    (void)path;
    return false;
}

void *sailfin_adapter_http_get(void *request)
{
    (void)request;
    return NULL;
}

void *sailfin_adapter_http_post(void *request, void *body)
{
    (void)request;
    (void)body;
    return NULL;
}

void *sailfin_adapter_model_invoke_with_prompt(void *model, void *prompt)
{
    (void)model;
    (void)prompt;
    return NULL;
}

void *sailfin_runtime_to_debug_string(void *value)
{
    return value;
}

void sailfin_runtime_raise_value_error(void *message)
{
    _print_line("[value_error] ", (const char *)message);
    abort();
}
