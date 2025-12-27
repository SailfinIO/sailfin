#include "sailfin_runtime.h"

#include <ctype.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>
#include <unistd.h>
#include <spawn.h>
#include <sys/wait.h>
#include <errno.h>
#include <sys/stat.h>
#include <dirent.h>
#include <setjmp.h>
#include <pthread.h>

#if defined(__APPLE__)
#include <execinfo.h>
#endif

extern char **environ;

static void _print_line(const char *prefix, const char *msg);

typedef struct SailfinTryContext
{
    jmp_buf env;
    struct SailfinTryContext *prev;
} SailfinTryContext;

static _Thread_local SailfinTryContext *_sailfin_try_stack = NULL;
static _Thread_local char *_sailfin_exception_message = NULL;

void sailfin_runtime_set_exception(char *message)
{
    _sailfin_exception_message = message ? message : "";
}

void sailfin_runtime_clear_exception(void)
{
    _sailfin_exception_message = NULL;
}

bool sailfin_runtime_has_exception(void)
{
    return _sailfin_exception_message != NULL;
}

int32_t sailfin_runtime_try_enter(char **out_handle)
{
    SailfinTryContext *ctx = (SailfinTryContext *)malloc(sizeof(SailfinTryContext));
    if (!ctx)
    {
        _print_line("[stage2-native] ", "out of memory entering try");
        abort();
    }
    ctx->prev = _sailfin_try_stack;
    _sailfin_try_stack = ctx;
    if (out_handle)
    {
        *out_handle = (char *)ctx;
    }
    return (int32_t)setjmp(ctx->env);
}

void sailfin_runtime_try_leave(char *handle)
{
    SailfinTryContext *ctx = (SailfinTryContext *)handle;
    if (!ctx)
    {
        return;
    }

    if (_sailfin_try_stack == ctx)
    {
        _sailfin_try_stack = ctx->prev;
    }
    else
    {
        // Defensive unlink in case of mismatched leaves.
        SailfinTryContext *prev = NULL;
        SailfinTryContext *cur = _sailfin_try_stack;
        while (cur)
        {
            if (cur == ctx)
            {
                if (prev)
                {
                    prev->prev = cur->prev;
                }
                else
                {
                    _sailfin_try_stack = cur->prev;
                }
                break;
            }
            prev = cur;
            cur = cur->prev;
        }
    }

    free(ctx);
}

void sailfin_runtime_throw(char *message)
{
    _sailfin_exception_message = message ? message : "";
    if (!_sailfin_try_stack)
    {
        _print_line("[stage2-native] uncaught exception: ", _sailfin_exception_message);
        abort();
    }
    SailfinTryContext *ctx = _sailfin_try_stack;
    longjmp(ctx->env, 1);
}

char *sailfin_runtime_take_exception(void)
{
    char *msg = _sailfin_exception_message;
    _sailfin_exception_message = NULL;
    return msg ? msg : "";
}

#if defined(__clang__)
#define SAILFIN_NOINLINE __attribute__((noinline))
#define SAILFIN_OPTNONE __attribute__((optnone))
#else
#define SAILFIN_NOINLINE
#define SAILFIN_OPTNONE
#endif

#if defined(__clang__)
#if __has_feature(address_sanitizer)
#define SAILFIN_WITH_ASAN 1
#endif
#endif

#if !defined(SAILFIN_WITH_ASAN) && defined(__SANITIZE_ADDRESS__)
#define SAILFIN_WITH_ASAN 1
#endif

// These helpers are implemented inside the stage2-compiled IR objects (e.g.
// prelude.o, native_lowering.o). The native runtime calls into them but must
// not provide its own definitions, or the final link will fail with duplicate
// symbols.
extern bool strings_equal(char *a, char *b);
// NOTE: Do not declare/resolve a `char_at` symbol here.
// The stage2 build links in a Sailfin-level `char_at` helper with that name;
// calling it from here would recurse back into `sailfin_runtime_grapheme_at`.

char *sailfin_runtime_get_field(char *base, char *field)
{
    if (!base || !field)
    {
        return "";
    }
    return "";
}

static bool _is_immediate_codepoint_string(const char *text, uint32_t *out_codepoint)
{
    if (!text)
    {
        return false;
    }

    uintptr_t raw = (uintptr_t)text;

    // Heuristic: sometimes a "string" leaks as an integer codepoint shifted
    // into the upper 32 bits (e.g., 0x0000003c00000000). Treat that as a
    // single-codepoint UTF-8 string.
    if ((raw & 0xffffffffu) != 0)
    {
        return false;
    }

    uint32_t codepoint = (uint32_t)(raw >> 32);
    if (codepoint == 0 || codepoint > 0x10ffffu)
    {
        return false;
    }

    if (out_codepoint)
    {
        *out_codepoint = codepoint;
    }
    return true;
}

// ---- Stage2-native memory tracking (bootstrap-safe) ----
//
// Stage2 currently uses a raw `char *` ABI for strings, with a mix of:
// - static literals (must never be freed)
// - immediate-codepoint pseudo-strings (must never be freed)
// - runtime-allocated strings (malloc) that can be safely freed
// - foreign pointers (boxed structs/opaque pointers) passed as `i8*`
//
// To avoid freeing the wrong thing, we only free pointers that the native
// runtime itself allocated and registered.

static pthread_mutex_t _sailfin_persistent_lock = PTHREAD_MUTEX_INITIALIZER;
static char **_sailfin_persistent_ptrs = NULL;
static size_t _sailfin_persistent_len = 0;
static size_t _sailfin_persistent_cap = 0;

static pthread_mutex_t _sailfin_owned_string_lock = PTHREAD_MUTEX_INITIALIZER;
static char **_sailfin_owned_strings = NULL;
static size_t _sailfin_owned_string_len = 0;
static size_t _sailfin_owned_string_cap = 0;

static bool _ptr_list_contains(char **list, size_t len, const char *ptr)
{
    if (!list || len == 0 || !ptr)
    {
        return false;
    }
    for (size_t i = 0; i < len; i++)
    {
        if (list[i] == ptr)
        {
            return true;
        }
    }
    return false;
}

static void _ptr_list_add_unique(char ***list, size_t *len, size_t *cap, char *ptr)
{
    if (!ptr)
    {
        return;
    }

    if (*list && _ptr_list_contains(*list, *len, ptr))
    {
        return;
    }

    if (*len >= *cap)
    {
        size_t new_cap = (*cap == 0) ? 64 : (*cap * 2);
        char **next = (char **)realloc(*list, new_cap * sizeof(char *));
        if (!next)
        {
            // Best-effort: do not abort during bootstrap memory bookkeeping.
            return;
        }
        *list = next;
        *cap = new_cap;
    }

    (*list)[*len] = ptr;
    *len = *len + 1;
}

static bool _ptr_list_remove(char **list, size_t *len, const char *ptr)
{
    if (!list || !len || *len == 0 || !ptr)
    {
        return false;
    }
    for (size_t i = 0; i < *len; i++)
    {
        if (list[i] == ptr)
        {
            // swap-remove
            list[i] = list[*len - 1];
            *len = *len - 1;
            return true;
        }
    }
    return false;
}

static void _track_owned_string(char *ptr)
{
    if (!ptr)
    {
        return;
    }
    if (_is_immediate_codepoint_string(ptr, NULL))
    {
        return;
    }
    pthread_mutex_lock(&_sailfin_owned_string_lock);
    _ptr_list_add_unique(&_sailfin_owned_strings, &_sailfin_owned_string_len, &_sailfin_owned_string_cap, ptr);
    pthread_mutex_unlock(&_sailfin_owned_string_lock);
}

static bool _is_persistent_ptr(char *ptr)
{
    if (!ptr)
    {
        return false;
    }
    pthread_mutex_lock(&_sailfin_persistent_lock);
    bool ok = _ptr_list_contains(_sailfin_persistent_ptrs, _sailfin_persistent_len, ptr);
    pthread_mutex_unlock(&_sailfin_persistent_lock);
    return ok;
}

static int _cmp_cstr_ptr(const void *a, const void *b)
{
    const char *sa = *(const char *const *)a;
    const char *sb = *(const char *const *)b;
    if (!sa)
    {
        return sb ? -1 : 0;
    }
    if (!sb)
    {
        return 1;
    }
    return strcmp(sa, sb);
}

static size_t _utf8_encode(uint32_t codepoint, unsigned char out[5])
{
    if (codepoint <= 0x7fu)
    {
        out[0] = (unsigned char)codepoint;
        out[1] = 0;
        return 1;
    }
    if (codepoint <= 0x7ffu)
    {
        out[0] = (unsigned char)(0xc0u | (codepoint >> 6));
        out[1] = (unsigned char)(0x80u | (codepoint & 0x3fu));
        out[2] = 0;
        return 2;
    }
    if (codepoint <= 0xffffu)
    {
        out[0] = (unsigned char)(0xe0u | (codepoint >> 12));
        out[1] = (unsigned char)(0x80u | ((codepoint >> 6) & 0x3fu));
        out[2] = (unsigned char)(0x80u | (codepoint & 0x3fu));
        out[3] = 0;
        return 3;
    }

    out[0] = (unsigned char)(0xf0u | (codepoint >> 18));
    out[1] = (unsigned char)(0x80u | ((codepoint >> 12) & 0x3fu));
    out[2] = (unsigned char)(0x80u | ((codepoint >> 6) & 0x3fu));
    out[3] = (unsigned char)(0x80u | (codepoint & 0x3fu));
    out[4] = 0;
    return 4;
}

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

static bool _env_enabled(const char *name)
{
    const char *value = getenv(name);
    return value && value[0] != '\0' && value[0] != '0';
}

static int _env_int(const char *name, int fallback)
{
    const char *value = getenv(name);
    if (!value || value[0] == '\0')
    {
        return fallback;
    }
    char *end = NULL;
    long parsed = strtol(value, &end, 10);
    if (end == value)
    {
        return fallback;
    }
    if (parsed < 0)
    {
        return 0;
    }
    if (parsed > 1000)
    {
        return 1000;
    }
    return (int)parsed;
}

static void _maybe_print_string_backtrace(
    const char *context,
    const char *a,
    bool a_immediate,
    bool a_poisoned,
    bool a_truncated,
    const char *b,
    bool b_immediate,
    bool b_poisoned,
    bool b_truncated)
{
    if (!_env_enabled("SAILFIN_TRACE_STRING_BACKTRACE"))
    {
        return;
    }

    static int remaining = -1;
    if (remaining < 0)
    {
        remaining = _env_int("SAILFIN_TRACE_STRING_BACKTRACE_BUDGET", 3);
    }
    if (remaining <= 0)
    {
        return;
    }
    remaining--;

    fprintf(
        stderr,
        "[stage2-native] backtrace (%s): a=%p%s%s%s b=%p%s%s%s\n",
        context ? context : "?",
        (void *)a,
        a_immediate ? " immediate" : "",
        a_poisoned ? " poisoned" : "",
        a_truncated ? " truncated" : "",
        (void *)b,
        b_immediate ? " immediate" : "",
        b_poisoned ? " poisoned" : "",
        b_truncated ? " truncated" : "");
    fflush(stderr);

#if defined(__APPLE__)
    void *frames[64];
    int count = backtrace(frames, (int)(sizeof(frames) / sizeof(frames[0])));
    if (count > 0)
    {
        backtrace_symbols_fd(frames, count, fileno(stderr));
    }
#endif
}

static SAILFIN_NOINLINE bool _asan_poisoned(const void *addr);

static SAILFIN_NOINLINE SAILFIN_OPTNONE size_t _safe_strlen_asan(const char *text, bool *out_truncated)
{
    if (out_truncated)
    {
        *out_truncated = false;
    }
    if (!text)
    {
        return 0;
    }

    // Guard against obviously invalid/near-null pointers (common symptom of
    // mis-tagged values being treated as `char *`).
    if ((uintptr_t)text < 4096u)
    {
        if (out_truncated)
        {
            *out_truncated = true;
        }
        return 0;
    }

    // Defensive cap: most stage2 compiler strings are tiny, but avoid scanning
    // unbounded memory if we get a wildly unterminated pointer.
    const size_t max_scan = 1u << 20; // 1 MiB

    for (size_t i = 0; i < max_scan; i++)
    {
        const char *p = text + i;

        // Avoid consulting ASAN shadow or reading memory for near-null pointers.
        if ((uintptr_t)p < 4096u)
        {
            if (out_truncated)
            {
                *out_truncated = true;
            }
            return i;
        }

        if (_asan_poisoned(p))
        {
            if (out_truncated)
            {
                *out_truncated = true;
            }
            return i;
        }

        // Volatile read to prevent the optimizer from hoisting the load above
        // the poison check under ASAN builds.
        unsigned char byte = *(const volatile unsigned char *)p;
        if (byte == '\0')
        {
            return i;
        }
    }

    if (out_truncated)
    {
        *out_truncated = true;
    }
    return max_scan;
}

#if defined(SAILFIN_WITH_ASAN)
extern int __asan_address_is_poisoned(const volatile void *addr);
static SAILFIN_NOINLINE bool _asan_poisoned(const void *addr)
{
    if (!addr)
    {
        return false;
    }
    return __asan_address_is_poisoned((const volatile void *)addr) != 0;
}
#else
static SAILFIN_NOINLINE bool _asan_poisoned(const void *addr)
{
    (void)addr;
    return false;
}
#endif

void sailfin_runtime_mark_persistent(char *ptr)
{
    if (!ptr)
    {
        return;
    }
    if (_is_immediate_codepoint_string(ptr, NULL))
    {
        return;
    }
    pthread_mutex_lock(&_sailfin_persistent_lock);
    _ptr_list_add_unique(&_sailfin_persistent_ptrs, &_sailfin_persistent_len, &_sailfin_persistent_cap, ptr);
    pthread_mutex_unlock(&_sailfin_persistent_lock);
}

void sailfin_runtime_string_drop(char *text)
{
    if (!text)
    {
        return;
    }
    if (_is_immediate_codepoint_string(text, NULL))
    {
        return;
    }
    if (_is_persistent_ptr(text))
    {
        return;
    }

    pthread_mutex_lock(&_sailfin_owned_string_lock);
    bool owned = _ptr_list_remove(_sailfin_owned_strings, &_sailfin_owned_string_len, text);
    pthread_mutex_unlock(&_sailfin_owned_string_lock);
    if (!owned)
    {
        return;
    }
    free(text);
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

    uint32_t codepoint = 0;
    if (_is_immediate_codepoint_string(text, &codepoint))
    {
        unsigned char buf[5] = {0};
        size_t len = _utf8_encode(codepoint, buf);
        return (int64_t)len;
    }

    bool truncated = false;
    int64_t length = (int64_t)_safe_strlen_asan(text, &truncated);

    if (truncated)
    {
        fprintf(stderr, "[stage2-native] string_length: unterminated string at %p; treating length=%lld\n", (void *)text, (long long)length);
        fflush(stderr);
    }

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
        _track_owned_string(out);
        return out;
    }

    uint32_t codepoint = 0;
    if (_is_immediate_codepoint_string(text, &codepoint))
    {
        unsigned char buf[5] = {0};
        int64_t n = (int64_t)_utf8_encode(codepoint, buf);
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
            memcpy(out, buf + start, (size_t)length);
        }
        out[length] = '\0';
        _track_owned_string(out);
        return out;
    }

    bool truncated = false;
    int64_t n = (int64_t)_safe_strlen_asan(text, &truncated);
    if (truncated)
    {
        fprintf(stderr, "[stage2-native] substring: unterminated string at %p; treating length=%lld\n", (void *)text, (long long)n);
        fflush(stderr);
    }
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
    _track_owned_string(out);
    return out;
}

char *sailfin_runtime_substring_unchecked(char *text, int64_t start, int64_t end)
{
    if (!text)
    {
        char *out = (char *)malloc(1);
        if (out)
        {
            out[0] = '\0';
        }
        _track_owned_string(out);
        return out;
    }

    // Preserve immediate-codepoint strings without dereferencing.
    uint32_t codepoint = 0;
    if (_is_immediate_codepoint_string(text, &codepoint))
    {
        unsigned char buf[5] = {0};
        int64_t n = (int64_t)_utf8_encode(codepoint, buf);
        if (start < 0)
        {
            start = 0;
        }
        if (end < start)
        {
            end = start;
        }
        if (start > n)
        {
            start = n;
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
            memcpy(out, buf + start, (size_t)length);
        }
        out[length] = '\0';
        _track_owned_string(out);
        return out;
    }

    if (start < 0)
    {
        start = 0;
    }
    if (end < start)
    {
        end = start;
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
    _track_owned_string(out);
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

    uint32_t a_codepoint = 0;
    uint32_t b_codepoint = 0;
    bool a_immediate = _is_immediate_codepoint_string(a, &a_codepoint);
    bool b_immediate = _is_immediate_codepoint_string(b, &b_codepoint);

    bool a_poisoned = (!a_immediate && _asan_poisoned(a));
    bool b_poisoned = (!b_immediate && _asan_poisoned(b));
    if (a_poisoned || b_poisoned)
    {
        fprintf(
            stderr,
            "[stage2-native] string_concat got poisoned arg(s): a=%p%s%s b=%p%s%s\n",
            (void *)a,
            a_immediate ? " immediate" : "",
            a_poisoned ? " poisoned" : "",
            (void *)b,
            b_immediate ? " immediate" : "",
            b_poisoned ? " poisoned" : "");
        fflush(stderr);
    }

    const char *trace = getenv("SAILFIN_TRACE_STRING_CONCAT");
    if (trace && trace[0] != '\0')
    {
        static int trace_budget = 64;
        if (trace_budget > 0)
        {
            trace_budget--;
            fprintf(
                stderr,
                "[stage2-native] string_concat(a=%p%s%s, b=%p%s%s)\n",
                (void *)a,
                a_immediate ? " immediate" : "",
                a_poisoned ? " poisoned" : "",
                (void *)b,
                b_immediate ? " immediate" : "",
                b_poisoned ? " poisoned" : "");
            fflush(stderr);
        }
    }

    unsigned char a_buf[5] = {0};
    unsigned char b_buf[5] = {0};
    bool a_truncated = false;
    bool b_truncated = false;
    size_t alen = a_immediate ? _utf8_encode(a_codepoint, a_buf) : _safe_strlen_asan(a, &a_truncated);
    size_t blen = b_immediate ? _utf8_encode(b_codepoint, b_buf) : _safe_strlen_asan(b, &b_truncated);

    if (a_poisoned || b_poisoned || (uintptr_t)a < 4096 || (uintptr_t)b < 4096)
    {
        _maybe_print_string_backtrace(
            "string_concat suspicious",
            a,
            a_immediate,
            a_poisoned,
            a_truncated,
            b,
            b_immediate,
            b_poisoned,
            b_truncated);
    }

    if (a_truncated || b_truncated)
    {
        fprintf(
            stderr,
            "[stage2-native] string_concat: unterminated input(s) a=%p%s b=%p%s (using alen=%zu blen=%zu)\n",
            (void *)a,
            a_truncated ? " (truncated)" : "",
            (void *)b,
            b_truncated ? " (truncated)" : "",
            alen,
            blen);
        fflush(stderr);
    }

    // Allocate a padding region beyond the primary terminator.
    // During bootstrap we still have a few codegen/runtime mismatches that can
    // clobber 1–N bytes just past the logical end of a string (typically via
    // off-by-one writes when treating strings as arrays). Providing a NUL pad
    // prevents `strlen`/friends from running off the end of the heap object
    // while we iterate on correctness.
    const size_t pad = 64;
    char *out = (char *)malloc(alen + blen + 1 + pad);
    if (!out)
    {
        return NULL;
    }

    if (a_immediate)
    {
        memcpy(out, a_buf, alen);
    }
    else
    {
        memcpy(out, a, alen);
    }

    if (b_immediate)
    {
        memcpy(out + alen, b_buf, blen);
    }
    else
    {
        memcpy(out + alen, b, blen);
    }

    memset(out + alen + blen, 0, 1 + pad);
    _track_owned_string(out);
    return out;
}

char *sailfin_runtime_number_to_string(double value)
{
    char buf[64];
    // Use a `%.15g` style to match the typical language-level printing of numbers:
    // integers render without a trailing `.0`, floats preserve useful precision.
    int written = snprintf(buf, sizeof(buf), "%.15g", value);
    if (written < 0)
    {
        return NULL;
    }
    size_t len = (size_t)written;
    if (len >= sizeof(buf))
    {
        len = sizeof(buf) - 1;
        buf[len] = '\0';
    }

    char *out = (char *)malloc(len + 1);
    if (!out)
    {
        return NULL;
    }
    memcpy(out, buf, len + 1);
    _track_owned_string(out);
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

SailfinPtrArray *sailfin_runtime_array_push(SailfinPtrArray *array, char *value)
{
    int64_t len = array ? array->len : 0;
    if (len < 0)
    {
        len = 0;
    }

    SailfinPtrArray *out = _alloc_array(len + 1);
    if (!out)
    {
        return NULL;
    }

    for (int64_t i = 0; i < len; i++)
    {
        out->data[i] = (array && array->data) ? array->data[i] : NULL;
    }
    out->data[len] = value;
    return out;
}

double sailfin_runtime_byte_at(char *text, int64_t index)
{
    if (!text || index < 0)
    {
        return -1.0;
    }

    unsigned char byte = (unsigned char)text[index];
    return (double)byte;
}

bool sailfin_runtime_is_decimal_digit(double ch)
{
    int64_t v = (int64_t)ch;
    if ((double)v != ch)
    {
        return false;
    }
    unsigned char c = (unsigned char)(v & 0xff);
    return (c >= (unsigned char)'0' && c <= (unsigned char)'9');
}

bool sailfin_runtime_is_whitespace_char(double ch)
{
    int64_t v = (int64_t)ch;
    if ((double)v != ch)
    {
        return false;
    }
    unsigned char c = (unsigned char)(v & 0xff);
    return (c == (unsigned char)' ' || c == (unsigned char)'\t' || c == (unsigned char)'\n' || c == (unsigned char)'\r');
}

bool sailfin_runtime_is_alpha_char(double ch)
{
    int64_t v = (int64_t)ch;
    if ((double)v != ch)
    {
        return false;
    }
    unsigned char c = (unsigned char)(v & 0xff);
    return ((c >= (unsigned char)'a' && c <= (unsigned char)'z') || (c >= (unsigned char)'A' && c <= (unsigned char)'Z'));
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
    if (value)
    {
        sailfin_runtime_print_info(value);
    }
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

// ---- Futures (stage2-native) ----

struct SailfinFutureNumber
{
    pthread_t thread;
    double (*fn0)(void);
    double (*fn1)(void *);
    void *ctx;
    bool has_ctx;
    double result;
};

static void *sailfin_future_number_entry(void *arg)
{
    struct SailfinFutureNumber *future = (struct SailfinFutureNumber *)arg;
    if (future->has_ctx)
    {
        future->result = future->fn1 ? future->fn1(future->ctx) : 0.0;
    }
    else
    {
        future->result = future->fn0 ? future->fn0() : 0.0;
    }
    return NULL;
}

struct SailfinFutureNumber *sailfin_runtime_spawn_number(double (*fn)(void))
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureNumber *future = (struct SailfinFutureNumber *)calloc(1, sizeof(struct SailfinFutureNumber));
    if (!future)
    {
        return NULL;
    }
    future->fn0 = fn;
    future->has_ctx = false;
    if (pthread_create(&future->thread, NULL, sailfin_future_number_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

struct SailfinFutureNumber *sailfin_runtime_spawn_number_ctx(double (*fn)(void *), void *ctx)
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureNumber *future = (struct SailfinFutureNumber *)calloc(1, sizeof(struct SailfinFutureNumber));
    if (!future)
    {
        return NULL;
    }
    future->fn1 = fn;
    future->ctx = ctx;
    future->has_ctx = true;
    if (pthread_create(&future->thread, NULL, sailfin_future_number_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

double sailfin_runtime_await_number(struct SailfinFutureNumber *future)
{
    if (!future)
    {
        return 0.0;
    }
    pthread_join(future->thread, NULL);
    double result = future->result;
    free(future);
    return result;
}

struct SailfinFutureVoid
{
    pthread_t thread;
    void (*fn0)(void);
    void (*fn1)(void *);
    void *ctx;
    bool has_ctx;
};

static void *sailfin_future_void_entry(void *arg)
{
    struct SailfinFutureVoid *future = (struct SailfinFutureVoid *)arg;
    if (future->has_ctx)
    {
        if (future->fn1)
        {
            future->fn1(future->ctx);
        }
    }
    else
    {
        if (future->fn0)
        {
            future->fn0();
        }
    }
    return NULL;
}

struct SailfinFutureVoid *sailfin_runtime_spawn_void(void (*fn)(void))
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureVoid *future = (struct SailfinFutureVoid *)calloc(1, sizeof(struct SailfinFutureVoid));
    if (!future)
    {
        return NULL;
    }
    future->fn0 = fn;
    future->has_ctx = false;
    if (pthread_create(&future->thread, NULL, sailfin_future_void_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

struct SailfinFutureVoid *sailfin_runtime_spawn_void_ctx(void (*fn)(void *), void *ctx)
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureVoid *future = (struct SailfinFutureVoid *)calloc(1, sizeof(struct SailfinFutureVoid));
    if (!future)
    {
        return NULL;
    }
    future->fn1 = fn;
    future->ctx = ctx;
    future->has_ctx = true;
    if (pthread_create(&future->thread, NULL, sailfin_future_void_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

void sailfin_runtime_await_void(struct SailfinFutureVoid *future)
{
    if (!future)
    {
        return;
    }
    pthread_join(future->thread, NULL);
    free(future);
}

struct SailfinFutureString
{
    pthread_t thread;
    char *(*fn0)(void);
    char *(*fn1)(void *);
    void *ctx;
    bool has_ctx;
    char *result;
};

static void *sailfin_future_string_entry(void *arg)
{
    struct SailfinFutureString *future = (struct SailfinFutureString *)arg;
    if (future->has_ctx)
    {
        future->result = future->fn1 ? future->fn1(future->ctx) : NULL;
    }
    else
    {
        future->result = future->fn0 ? future->fn0() : NULL;
    }
    return NULL;
}

struct SailfinFutureString *sailfin_runtime_spawn_string(char *(*fn)(void))
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureString *future = (struct SailfinFutureString *)calloc(1, sizeof(struct SailfinFutureString));
    if (!future)
    {
        return NULL;
    }
    future->fn0 = fn;
    future->has_ctx = false;
    if (pthread_create(&future->thread, NULL, sailfin_future_string_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

struct SailfinFutureString *sailfin_runtime_spawn_string_ctx(char *(*fn)(void *), void *ctx)
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureString *future = (struct SailfinFutureString *)calloc(1, sizeof(struct SailfinFutureString));
    if (!future)
    {
        return NULL;
    }
    future->fn1 = fn;
    future->ctx = ctx;
    future->has_ctx = true;
    if (pthread_create(&future->thread, NULL, sailfin_future_string_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

char *sailfin_runtime_await_string(struct SailfinFutureString *future)
{
    if (!future)
    {
        return NULL;
    }
    pthread_join(future->thread, NULL);
    char *result = future->result;
    free(future);
    return result;
}

struct SailfinFutureBool
{
    pthread_t thread;
    bool (*fn0)(void);
    bool (*fn1)(void *);
    void *ctx;
    bool has_ctx;
    bool result;
};

static void *sailfin_future_bool_entry(void *arg)
{
    struct SailfinFutureBool *future = (struct SailfinFutureBool *)arg;
    if (future->has_ctx)
    {
        future->result = future->fn1 ? future->fn1(future->ctx) : false;
    }
    else
    {
        future->result = future->fn0 ? future->fn0() : false;
    }
    return NULL;
}

struct SailfinFutureBool *sailfin_runtime_spawn_bool(bool (*fn)(void))
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureBool *future = (struct SailfinFutureBool *)calloc(1, sizeof(struct SailfinFutureBool));
    if (!future)
    {
        return NULL;
    }
    future->fn0 = fn;
    future->has_ctx = false;
    if (pthread_create(&future->thread, NULL, sailfin_future_bool_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

struct SailfinFutureBool *sailfin_runtime_spawn_bool_ctx(bool (*fn)(void *), void *ctx)
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureBool *future = (struct SailfinFutureBool *)calloc(1, sizeof(struct SailfinFutureBool));
    if (!future)
    {
        return NULL;
    }
    future->fn1 = fn;
    future->ctx = ctx;
    future->has_ctx = true;
    if (pthread_create(&future->thread, NULL, sailfin_future_bool_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

bool sailfin_runtime_await_bool(struct SailfinFutureBool *future)
{
    if (!future)
    {
        return false;
    }
    pthread_join(future->thread, NULL);
    bool result = future->result;
    free(future);
    return result;
}

struct SailfinFuturePtr
{
    pthread_t thread;
    void *(*fn0)(void);
    void *(*fn1)(void *);
    void *ctx;
    bool has_ctx;
    void *result;
};

static void *sailfin_future_ptr_entry(void *arg)
{
    struct SailfinFuturePtr *future = (struct SailfinFuturePtr *)arg;
    if (future->has_ctx)
    {
        future->result = future->fn1 ? future->fn1(future->ctx) : NULL;
    }
    else
    {
        future->result = future->fn0 ? future->fn0() : NULL;
    }
    return NULL;
}

struct SailfinFuturePtr *sailfin_runtime_spawn_ptr(void *(*fn)(void))
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFuturePtr *future = (struct SailfinFuturePtr *)calloc(1, sizeof(struct SailfinFuturePtr));
    if (!future)
    {
        return NULL;
    }
    future->fn0 = fn;
    future->has_ctx = false;
    if (pthread_create(&future->thread, NULL, sailfin_future_ptr_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

struct SailfinFuturePtr *sailfin_runtime_spawn_ptr_ctx(void *(*fn)(void *), void *ctx)
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFuturePtr *future = (struct SailfinFuturePtr *)calloc(1, sizeof(struct SailfinFuturePtr));
    if (!future)
    {
        return NULL;
    }
    future->fn1 = fn;
    future->ctx = ctx;
    future->has_ctx = true;
    if (pthread_create(&future->thread, NULL, sailfin_future_ptr_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

void *sailfin_runtime_await_ptr(struct SailfinFuturePtr *future)
{
    if (!future)
    {
        return NULL;
    }
    pthread_join(future->thread, NULL);
    void *result = future->result;
    free(future);
    return result;
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
    if (!text)
    {
        return "";
    }

    int64_t len = sailfin_runtime_string_length(text);
    if (len <= 0)
    {
        return "";
    }

    int64_t idx = (int64_t)index;
    if ((double)idx != index)
    {
        // Non-integer indexes aren't meaningful here.
        return "";
    }
    if (idx < 0 || idx >= len)
    {
        return "";
    }

    // Bootstrap implementation: treat each UTF-8 byte as a grapheme.
    // This is sufficient for ASCII-heavy compiler sources while we iterate.
    char *out = (char *)malloc(2);
    if (!out)
    {
        return NULL;
    }
    out[0] = text[idx];
    out[1] = '\0';
    _track_owned_string(out);
    return out;
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

double sailfin_runtime_process_run(SailfinPtrArray *argv)
{
    if (!argv || argv->len <= 0 || !argv->data || !argv->data[0])
    {
        return 127.0;
    }

    int64_t len = argv->len;
    if (len < 0)
    {
        len = 0;
    }

    // posix_spawnp expects a NULL-terminated argv.
    size_t n = (size_t)len;
    char **child_argv = (char **)calloc(n + 1, sizeof(char *));
    if (!child_argv)
    {
        return 127.0;
    }

    for (size_t i = 0; i < n; i++)
    {
        child_argv[i] = argv->data[i];
    }
    child_argv[n] = NULL;

    pid_t pid;
    int spawn_err = posix_spawnp(&pid, child_argv[0], NULL, NULL, child_argv, environ);
    if (spawn_err != 0)
    {
        free(child_argv);
        return 127.0;
    }

    int status = 0;
    if (waitpid(pid, &status, 0) < 0)
    {
        free(child_argv);
        return 127.0;
    }

    free(child_argv);

    if (WIFEXITED(status))
    {
        return (double)WEXITSTATUS(status);
    }
    if (WIFSIGNALED(status))
    {
        return (double)(128 + WTERMSIG(status));
    }
    return 127.0;
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
    const char *path_str = (const char *)path;
    if (!path_str)
    {
        return NULL;
    }

    FILE *f = fopen(path_str, "rb");
    if (!f)
    {
        return NULL;
    }
    if (fseek(f, 0, SEEK_END) != 0)
    {
        fclose(f);
        return NULL;
    }
    long n = ftell(f);
    if (n < 0)
    {
        fclose(f);
        return NULL;
    }
    if (fseek(f, 0, SEEK_SET) != 0)
    {
        fclose(f);
        return NULL;
    }

    char *buf = (char *)malloc((size_t)n + 1);
    if (!buf)
    {
        fclose(f);
        return NULL;
    }
    size_t read_n = fread(buf, 1, (size_t)n, f);
    fclose(f);
    buf[read_n] = '\0';
    return buf;
}

void sailfin_adapter_fs_write_file(void *path, void *contents)
{
    const char *path_str = (const char *)path;
    const char *contents_str = (const char *)contents;
    if (!path_str || !contents_str)
    {
        return;
    }

    FILE *f = fopen(path_str, "wb");
    if (!f)
    {
        _print_line("[stage2-native] fs.writeFile failed", path_str);
        return;
    }

    size_t len = strlen(contents_str);
    if (len > 0)
    {
        (void)fwrite(contents_str, 1, len, f);
    }
    fclose(f);
}

SailfinPtrArray *sailfin_adapter_fs_list_directory(void *path)
{
    const char *path_str = (const char *)path;
    if (!path_str || path_str[0] == '\0')
    {
        path_str = ".";
    }

    DIR *dir = opendir(path_str);
    if (!dir)
    {
        // Mirror the bootstrap/JIT behaviour: tolerate missing/unreadable directories.
        return _alloc_array(0);
    }

    size_t cap = 32;
    size_t len = 0;
    char **names = (char **)calloc(cap, sizeof(char *));
    if (!names)
    {
        closedir(dir);
        return NULL;
    }

    struct dirent *entry = NULL;
    while ((entry = readdir(dir)) != NULL)
    {
        const char *name = entry->d_name;
        if (!name)
        {
            continue;
        }
        if (strcmp(name, ".") == 0 || strcmp(name, "..") == 0)
        {
            continue;
        }

        if (len >= cap)
        {
            size_t next_cap = cap * 2;
            char **next = (char **)realloc(names, next_cap * sizeof(char *));
            if (!next)
            {
                // Best-effort cleanup.
                for (size_t i = 0; i < len; i++)
                {
                    free(names[i]);
                }
                free(names);
                closedir(dir);
                return NULL;
            }
            // Ensure new slots are null.
            memset(next + cap, 0, (next_cap - cap) * sizeof(char *));
            names = next;
            cap = next_cap;
        }

        char *copy = strdup(name);
        if (!copy)
        {
            for (size_t i = 0; i < len; i++)
            {
                free(names[i]);
            }
            free(names);
            closedir(dir);
            return NULL;
        }
        names[len++] = copy;
    }
    closedir(dir);

    if (len > 1)
    {
        qsort(names, len, sizeof(char *), _cmp_cstr_ptr);
    }

    SailfinPtrArray *out = _alloc_array((int64_t)len);
    if (!out)
    {
        for (size_t i = 0; i < len; i++)
        {
            free(names[i]);
        }
        free(names);
        return NULL;
    }

    for (size_t i = 0; i < len; i++)
    {
        out->data[i] = names[i];
    }
    out->len = (int64_t)len;
    free(names);
    return out;
}

bool sailfin_adapter_fs_delete_file(void *path)
{
    const char *path_str = (const char *)path;
    if (!path_str)
    {
        return false;
    }
    return unlink(path_str) == 0;
}

bool sailfin_adapter_fs_create_directory(void *path, bool recursive)
{
    const char *path_str = (const char *)path;
    if (!path_str || path_str[0] == '\0')
    {
        return false;
    }

    if (!recursive)
    {
        if (mkdir(path_str, 0777) == 0)
        {
            return true;
        }
        return errno == EEXIST;
    }

    size_t len = strlen(path_str);
    char *scratch = (char *)malloc(len + 1);
    if (!scratch)
    {
        return false;
    }
    memcpy(scratch, path_str, len + 1);

    // Iterate path components and mkdir as we go.
    // Handles relative paths and absolute paths.
    for (size_t i = 1; i <= len; i++)
    {
        if (scratch[i] == '/' || scratch[i] == '\0')
        {
            char saved = scratch[i];
            scratch[i] = '\0';
            if (scratch[0] != '\0')
            {
                if (mkdir(scratch, 0777) != 0 && errno != EEXIST)
                {
                    scratch[i] = saved;
                    free(scratch);
                    return false;
                }
            }
            scratch[i] = saved;
        }
    }

    free(scratch);
    return true;
}

bool sailfin_intrinsic_fs_exists(void *path)
{
    const char *path_str = (const char *)path;
    if (!path_str)
    {
        return false;
    }
    struct stat st;
    return stat(path_str, &st) == 0;
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
