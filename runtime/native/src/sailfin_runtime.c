#include "sailfin_runtime.h"

#include <ctype.h>
#include <stdio.h>
#include <signal.h>
#include <stdlib.h>
#include <string.h>
#include <stdint.h>

#if defined(_WIN32)
#include <windows.h>
#include <process.h>
#include <io.h>
#include <direct.h>
#else
#include <unistd.h>
#include <spawn.h>
#include <sys/wait.h>
#endif

#if !defined(__APPLE__)
#include <time.h>
#endif

#if defined(__APPLE__)
#include <mach/mach.h>
#include <mach/mach_vm.h>
#include <mach/mach_time.h>
#endif
#include <errno.h>
#include <sys/stat.h>
#include <dirent.h>
#include <setjmp.h>
#include <pthread.h>

#if defined(__APPLE__)
#include <execinfo.h>
#endif

/* Windows mkdir takes only one argument (no mode). */
#if defined(_WIN32)
#define sfn_mkdir(path, mode) mkdir(path)
#else
#define sfn_mkdir(path, mode) mkdir(path, mode)
#endif

#if defined(_WIN32)
extern char **_environ;
#define environ _environ
#else
extern char **environ;
#endif

static bool _env_enabled(const char *name);
static int _env_int(const char *name, int fallback);

static void _print_line(FILE *stream, const char *prefix, const char *msg);

typedef struct SailfinTryContext
{
    jmp_buf env;
    struct SailfinTryContext *prev;
} SailfinTryContext;

static _Thread_local SailfinTryContext *_sailfin_try_stack = NULL;
static _Thread_local char *_sailfin_exception_message = NULL;

double sailfin_runtime_monotonic_millis(void)
{
#if defined(__APPLE__)
    // Use the same clock as other macOS codepaths in this runtime.
    // mach_absolute_time is monotonic.
    static mach_timebase_info_data_t timebase;
    if (timebase.denom == 0)
    {
        mach_timebase_info(&timebase);
    }
    uint64_t t = mach_absolute_time();
    // Convert to nanoseconds.
    uint64_t ns = (t * (uint64_t)timebase.numer) / (uint64_t)timebase.denom;
    return (double)(ns / 1000000ull);
#else
    struct timespec ts;
    if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0)
    {
        return 0.0;
    }
    uint64_t ms = (uint64_t)ts.tv_sec * 1000ull + (uint64_t)ts.tv_nsec / 1000000ull;
    return (double)ms;
#endif
}

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
        _print_line(stderr, "[stage2-native] ", "out of memory entering try");
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
        _print_line(stderr, "[stage2-native] uncaught exception: ", _sailfin_exception_message);
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

/* Global safe buffer for unresolved get_field calls.  Zeroed memory acts as:
   - empty string (first byte NUL)
   - array with length 0 ({NULL, 0})
   - false boolean / 0.0 number
   This prevents SIGSEGV while the LLVM IR fixup pass handles known fields. */
static char _get_field_safe_buf[4096] __attribute__((aligned(16)));

char *sailfin_runtime_get_field(char *base, char *field)
{
    /* For remaining calls not handled by the GEP replacement pass,
       return a pointer to zeroed memory instead of NULL to avoid SIGSEGV.
       The zeroed buffer reads as empty string / zero array / false / 0.0. */
    return _get_field_safe_buf;
}

static bool _is_immediate_codepoint_string(const char *text, uint32_t *out_codepoint)
{
    if (!text)
    {
        return false;
    }

    uintptr_t raw = (uintptr_t)text;
    // Secondary encoding: sometimes a single-byte grapheme leaks through as a
    // near-null pointer (e.g. 0x2e for '.'). Treat ASCII values as immediate
    // codepoints so we never attempt to dereference them as C strings.
    if (raw < 4096u)
    {
        uint32_t codepoint = (uint32_t)raw;
        if (codepoint > 0 && codepoint <= 0x7fu)
        {
            if (out_codepoint)
            {
                *out_codepoint = codepoint;
            }
            return true;
        }
        return false;
    }

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

#if defined(__APPLE__) && !defined(SAILFIN_WITH_ASAN)
    // On macOS it is possible (though rare) to have a real, mapped pointer
    // whose low 32 bits are zero. The upper-32-bit heuristic would wrongly
    // classify that as an "immediate" codepoint string, causing subtle memory
    // corruption when the value is later treated as a C string.
    //
    // Guard: only treat this encoding as immediate when the address is not
    // mapped as a readable region.
    {
        // Cache the (rare but expensive) address mapping check.
        // Immediate-codepoint pseudo strings repeat heavily (e.g. '/', '.',
        // letters when building paths), so without caching this guard can
        // dominate runtime and cause timeouts.
        enum
        {
            MAP_CACHE_SIZE = 256,
            MAP_CACHE_PROBES = 8
        };
        static uintptr_t map_cache_keys[MAP_CACHE_SIZE];
        static uint8_t map_cache_vals[MAP_CACHE_SIZE];
        // vals: 0 empty, 1 mapped+readable, 2 not-mapped-or-not-readable

        uintptr_t key = raw;
        uint32_t h = (uint32_t)(key ^ (key >> 32) ^ (key >> 12));
        uint32_t slot = h & (MAP_CACHE_SIZE - 1);

        uint8_t cached_val = 0;
        for (uint32_t probe = 0; probe < MAP_CACHE_PROBES; probe++)
        {
            uint32_t idx = (slot + probe) & (MAP_CACHE_SIZE - 1);
            uintptr_t existing = map_cache_keys[idx];
            uint8_t existing_val = map_cache_vals[idx];
            if (existing == key && existing_val != 0)
            {
                cached_val = existing_val;
                break;
            }
            if (existing_val == 0)
            {
                break;
            }
        }

        if (cached_val == 1)
        {
            return false;
        }
        if (cached_val == 2)
        {
            // Known-unmapped immediate; skip the expensive kernel query.
            goto apple_upper32_immediate_done;
        }

        bool mapped_readable = false;
        {
            mach_vm_address_t query = (mach_vm_address_t)(uintptr_t)text;
            mach_vm_address_t region = query;
            mach_vm_size_t region_size = 0;
            vm_region_basic_info_data_64_t info;
            mach_msg_type_number_t count = VM_REGION_BASIC_INFO_COUNT_64;
            mach_port_t object_name = MACH_PORT_NULL;

            kern_return_t kr = mach_vm_region(
                mach_task_self(),
                &region,
                &region_size,
                VM_REGION_BASIC_INFO_64,
                (vm_region_info_t)&info,
                &count,
                &object_name);

            if (object_name != MACH_PORT_NULL)
            {
                mach_port_deallocate(mach_task_self(), object_name);
            }

            if (kr == KERN_SUCCESS)
            {
                bool readable = (info.protection & VM_PROT_READ) != 0;
                bool contains = (query >= region) && (query < (region + region_size));
                mapped_readable = readable && contains;
            }
        }

        // Store the result.
        for (uint32_t probe = 0; probe < MAP_CACHE_PROBES; probe++)
        {
            uint32_t idx = (slot + probe) & (MAP_CACHE_SIZE - 1);
            if (map_cache_vals[idx] == 0 || map_cache_keys[idx] == key)
            {
                map_cache_keys[idx] = key;
                map_cache_vals[idx] = mapped_readable ? 1 : 2;
                break;
            }
        }

        if (mapped_readable)
        {
            return false;
        }
    }

apple_upper32_immediate_done:
#endif

    if (out_codepoint)
    {
        *out_codepoint = codepoint;
    }
    return true;
}

// Encode a Unicode codepoint as UTF-8 into buf (which must have room for 5 bytes).
// Returns the number of bytes written (1-4), or 0 on error.
static int _codepoint_to_utf8(uint32_t cp, char *buf)
{
    if (cp <= 0x7fu)
    {
        buf[0] = (char)cp;
        buf[1] = '\0';
        return 1;
    }
    if (cp <= 0x7ffu)
    {
        buf[0] = (char)(0xc0u | (cp >> 6));
        buf[1] = (char)(0x80u | (cp & 0x3fu));
        buf[2] = '\0';
        return 2;
    }
    if (cp <= 0xffffu)
    {
        buf[0] = (char)(0xe0u | (cp >> 12));
        buf[1] = (char)(0x80u | ((cp >> 6) & 0x3fu));
        buf[2] = (char)(0x80u | (cp & 0x3fu));
        buf[3] = '\0';
        return 3;
    }
    if (cp <= 0x10ffffu)
    {
        buf[0] = (char)(0xf0u | (cp >> 18));
        buf[1] = (char)(0x80u | ((cp >> 12) & 0x3fu));
        buf[2] = (char)(0x80u | ((cp >> 6) & 0x3fu));
        buf[3] = (char)(0x80u | (cp & 0x3fu));
        buf[4] = '\0';
        return 4;
    }
    buf[0] = '\0';
    return 0;
}

// Fast string equality check that handles immediate codepoint strings.
// Called from the LLVM-level replacement of the prelude's grapheme-based
// strings_equal (which is O(n^2) due to per-character grapheme_at calls).
bool _strings_equal_fast(const char *a, const char *b)
{
    if (a == b)
    {
        return true;
    }
    if (!a || !b)
    {
        return false;
    }

    uint32_t a_cp = 0, b_cp = 0;
    bool a_imm = _is_immediate_codepoint_string(a, &a_cp);
    bool b_imm = _is_immediate_codepoint_string(b, &b_cp);

    if (a_imm && b_imm)
    {
        return a_cp == b_cp;
    }
    if (a_imm)
    {
        char buf[5];
        _codepoint_to_utf8(a_cp, buf);
        return strcmp(buf, b) == 0;
    }
    if (b_imm)
    {
        char buf[5];
        _codepoint_to_utf8(b_cp, buf);
        return strcmp(a, buf) == 0;
    }
    return strcmp(a, b) == 0;
}

#if defined(__APPLE__) && !defined(SAILFIN_WITH_ASAN)
static SAILFIN_NOINLINE int _string_ptr_mapped_readable(const void *ptr)
{
    if (!ptr)
    {
        return 0;
    }

    uintptr_t raw = (uintptr_t)ptr;
    uintptr_t key = raw & ~(uintptr_t)0xfff;
    enum
    {
        MAP_CACHE_SIZE = 256,
        MAP_CACHE_PROBES = 8
    };
    static uintptr_t map_cache_keys[MAP_CACHE_SIZE];
    static uint8_t map_cache_vals[MAP_CACHE_SIZE];

    uint32_t h = (uint32_t)(key ^ (key >> 32) ^ (key >> 12));
    uint32_t slot = h & (MAP_CACHE_SIZE - 1);

    uint8_t cached_val = 0;
    for (uint32_t probe = 0; probe < MAP_CACHE_PROBES; probe++)
    {
        uint32_t idx = (slot + probe) & (MAP_CACHE_SIZE - 1);
        uintptr_t existing = map_cache_keys[idx];
        uint8_t existing_val = map_cache_vals[idx];
        if (existing == key && existing_val != 0)
        {
            cached_val = existing_val;
            break;
        }
        if (existing_val == 0)
        {
            break;
        }
    }

    if (cached_val == 1)
    {
        return 1;
    }
    if (cached_val == 2)
    {
        return 0;
    }

    bool mapped_readable = false;
    {
        mach_vm_address_t query = (mach_vm_address_t)(uintptr_t)ptr;
        mach_vm_address_t region = query;
        mach_vm_size_t region_size = 0;
        vm_region_basic_info_data_64_t info;
        mach_msg_type_number_t count = VM_REGION_BASIC_INFO_COUNT_64;
        mach_port_t object_name = MACH_PORT_NULL;

        kern_return_t kr = mach_vm_region(
            mach_task_self(),
            &region,
            &region_size,
            VM_REGION_BASIC_INFO_64,
            (vm_region_info_t)&info,
            &count,
            &object_name);

        if (object_name != MACH_PORT_NULL)
        {
            mach_port_deallocate(mach_task_self(), object_name);
        }

        if (kr == KERN_SUCCESS)
        {
            bool readable = (info.protection & VM_PROT_READ) != 0;
            bool contains = (query >= region) && (query < (region + region_size));
            mapped_readable = readable && contains;
        }
    }

    for (uint32_t probe = 0; probe < MAP_CACHE_PROBES; probe++)
    {
        uint32_t idx = (slot + probe) & (MAP_CACHE_SIZE - 1);
        if (map_cache_vals[idx] == 0 || map_cache_keys[idx] == key)
        {
            map_cache_keys[idx] = key;
            map_cache_vals[idx] = mapped_readable ? 1 : 2;
            break;
        }
    }

    return mapped_readable ? 1 : 0;
}
#endif

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
// Persistent pointer set.
// These pointers must never be freed by the runtime (e.g., static literals).
// This is a hot path during compilation; use a hash set rather than linear scans.
static char **_sailfin_persistent_table = NULL;
static size_t _sailfin_persistent_table_cap = 0;
static size_t _sailfin_persistent_table_len = 0;

static pthread_mutex_t _sailfin_owned_string_lock = PTHREAD_MUTEX_INITIALIZER;
// Owned-string set.
// Stores malloc'd strings allocated by the runtime so we can free them safely.
// This is a hot path during compilation; use a hash set rather than linear scans.
// We support removals (string_drop), so use tombstones.
static char **_sailfin_owned_table = NULL;
static size_t _sailfin_owned_table_cap = 0;
static size_t _sailfin_owned_table_len = 0;
static size_t _sailfin_owned_table_tombstones = 0;

// =============================================================================
// Recent string allocation tracking (debugging aid)
// =============================================================================

struct SailfinRecentString
{
    const char *base;
    size_t len;
};

static pthread_mutex_t _sailfin_recent_string_lock = PTHREAD_MUTEX_INITIALIZER;
static struct SailfinRecentString _sailfin_recent_strings[4096];
static size_t _sailfin_recent_string_cursor = 0;

// =============================================================================
// Allocation statistics (debug)
// =============================================================================

static int _alloc_stats_init = 0;
static int _alloc_stats_enabled = 0;
static uint64_t _alloc_stats_string_concat_calls = 0;
static uint64_t _alloc_stats_string_concat_bytes = 0;
static uint64_t _alloc_stats_substring_calls = 0;
static uint64_t _alloc_stats_substring_bytes = 0;
static uint64_t _alloc_stats_array_alloc_calls = 0;
static uint64_t _alloc_stats_array_alloc_bytes = 0;

static void _print_alloc_stats(void);

static void _maybe_init_alloc_stats(void)
{
    if (_alloc_stats_init)
    {
        return;
    }
    _alloc_stats_init = 1;
    _alloc_stats_enabled = _env_enabled("SAILFIN_TRACE_ALLOC_STATS") ? 1 : 0;
    if (_alloc_stats_enabled)
    {
        atexit(_print_alloc_stats);
    }
}

static void _print_alloc_stats(void)
{
    if (!_alloc_stats_init)
    {
        _maybe_init_alloc_stats();
    }
    if (!_alloc_stats_enabled)
    {
        return;
    }
    fprintf(
        stderr,
        "[stage2-native] alloc_stats string_concat calls=%llu bytes=%llu substring calls=%llu bytes=%llu array_alloc calls=%llu bytes=%llu\n",
        (unsigned long long)_alloc_stats_string_concat_calls,
        (unsigned long long)_alloc_stats_string_concat_bytes,
        (unsigned long long)_alloc_stats_substring_calls,
        (unsigned long long)_alloc_stats_substring_bytes,
        (unsigned long long)_alloc_stats_array_alloc_calls,
        (unsigned long long)_alloc_stats_array_alloc_bytes);
    fflush(stderr);
}

// Debugging: track a specific LLVM module header string pointer once seen.
// If later array ops drop it, that strongly implicates array length/ABI bugs.
static pthread_mutex_t _sailfin_trace_header_lock = PTHREAD_MUTEX_INITIALIZER;
static const char *_sailfin_tracked_source_filename = NULL;

static void _trace_backtrace_budgeted(const char *label);
static int _sailfin_tracked_source_budget = -1;

// Recent array allocation tracking (data pointer ring).
static pthread_mutex_t _sailfin_recent_array_lock = PTHREAD_MUTEX_INITIALIZER;
static const void *_sailfin_recent_arrays[65536];
static size_t _sailfin_recent_array_cursor = 0;

static void _recent_array_record(const void *data)
{
    if (!data)
    {
        return;
    }
    pthread_mutex_lock(&_sailfin_recent_array_lock);
    _sailfin_recent_arrays[_sailfin_recent_array_cursor] = data;
    _sailfin_recent_array_cursor = (_sailfin_recent_array_cursor + 1) % (sizeof(_sailfin_recent_arrays) / sizeof(_sailfin_recent_arrays[0]));
    pthread_mutex_unlock(&_sailfin_recent_array_lock);
}

static bool _recent_array_contains(const void *data)
{
    if (!data)
    {
        return false;
    }
    pthread_mutex_lock(&_sailfin_recent_array_lock);
    const size_t cap = sizeof(_sailfin_recent_arrays) / sizeof(_sailfin_recent_arrays[0]);
    for (size_t i = 0; i < cap; i++)
    {
        if (_sailfin_recent_arrays[i] == data)
        {
            pthread_mutex_unlock(&_sailfin_recent_array_lock);
            return true;
        }
    }
    pthread_mutex_unlock(&_sailfin_recent_array_lock);
    return false;
}

static void _recent_string_record(const char *base, size_t len)
{
    if (!base || len == 0)
    {
        return;
    }
    pthread_mutex_lock(&_sailfin_recent_string_lock);
    _sailfin_recent_strings[_sailfin_recent_string_cursor].base = base;
    _sailfin_recent_strings[_sailfin_recent_string_cursor].len = len;
    _sailfin_recent_string_cursor = (_sailfin_recent_string_cursor + 1) % (sizeof(_sailfin_recent_strings) / sizeof(_sailfin_recent_strings[0]));
    pthread_mutex_unlock(&_sailfin_recent_string_lock);
}

#if defined(__APPLE__)
static void _sailfin_crash_handler(int sig)
{
    fprintf(stderr, "[native] crash signal=%d\n", sig);
    _trace_backtrace_budgeted("crash");
    fflush(stderr);
    _exit(128 + sig);
}

__attribute__((constructor)) static void _sailfin_install_crash_handler(void)
{
    const char *v = getenv("SAILFIN_TRACE_CRASH");
    if (!v || v[0] == '\0' || v[0] == '0')
    {
        return;
    }
    struct sigaction sa;
    memset(&sa, 0, sizeof(sa));
    sa.sa_handler = _sailfin_crash_handler;
    sigemptyset(&sa.sa_mask);
    sigaction(SIGSEGV, &sa, NULL);
    sigaction(SIGABRT, &sa, NULL);
}
#endif

#if defined(__APPLE__)
static void _trace_backtrace_budgeted(const char *label)
{
    // Optional: emit a backtrace for diagnosing large allocations.
    // Use a budget so we don't spam logs.
    static int init = 0;
    static int enabled = 0;
    static int budget = 0;
    if (!init)
    {
        init = 1;
        enabled = _env_enabled("SAILFIN_TRACE_LARGE_ARRAY_BACKTRACE") ? 1 : 0;
        budget = _env_int("SAILFIN_TRACE_LARGE_ARRAY_BACKTRACE_BUDGET", 8);
    }
    if (!enabled || budget <= 0)
    {
        return;
    }
    budget--;

    void *frames[64];
    int n = backtrace(frames, (int)(sizeof(frames) / sizeof(frames[0])));
    char **symbols = backtrace_symbols(frames, n);
    fprintf(stderr, "[stage2-native] backtrace label=%s frames=%d\n", label ? label : "?", n);
    if (symbols)
    {
        for (int i = 0; i < n; i++)
        {
            fprintf(stderr, "  %s\n", symbols[i]);
        }
        free(symbols);
    }
    fflush(stderr);
}
#else
static void _trace_backtrace_budgeted(const char *label)
{
    (void)label;
}
#endif

static bool _recent_string_find_range(const char *ptr, const char **out_base, size_t *out_len, size_t *out_offset)
{
    if (!ptr)
    {
        return false;
    }
    pthread_mutex_lock(&_sailfin_recent_string_lock);
    const size_t cap = sizeof(_sailfin_recent_strings) / sizeof(_sailfin_recent_strings[0]);
    for (size_t i = 0; i < cap; i++)
    {
        const char *base = _sailfin_recent_strings[i].base;
        size_t len = _sailfin_recent_strings[i].len;
        if (!base || len == 0)
        {
            continue;
        }
        if (ptr >= base && ptr < (base + len))
        {
            if (out_base)
            {
                *out_base = base;
            }
            if (out_len)
            {
                *out_len = len;
            }
            if (out_offset)
            {
                *out_offset = (size_t)(ptr - base);
            }
            pthread_mutex_unlock(&_sailfin_recent_string_lock);
            return true;
        }
    }
    pthread_mutex_unlock(&_sailfin_recent_string_lock);
    return false;
}

#define SAILFIN_TOMBSTONE_PTR ((char *)1)

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

static inline uint64_t _ptr_hash_u64(const void *ptr)
{
    // Mix pointer bits; good enough for open addressing.
    uint64_t x = (uint64_t)(uintptr_t)ptr;
    x ^= x >> 33;
    x *= 0xff51afd7ed558ccdULL;
    x ^= x >> 33;
    x *= 0xc4ceb9fe1a85ec53ULL;
    x ^= x >> 33;
    return x;
}

static bool _owned_table_resize_unlocked(size_t new_cap)
{
    if (new_cap < 1024)
    {
        new_cap = 1024;
    }
    // Ensure power-of-two.
    size_t cap = 1;
    while (cap < new_cap)
    {
        cap <<= 1;
    }

    char **next = (char **)calloc(cap, sizeof(char *));
    if (!next)
    {
        return false;
    }

    if (_sailfin_owned_table && _sailfin_owned_table_cap)
    {
        size_t old_cap = _sailfin_owned_table_cap;
        char **old = _sailfin_owned_table;

        size_t mask = cap - 1;
        for (size_t i = 0; i < old_cap; i++)
        {
            char *ptr = old[i];
            if (!ptr || ptr == SAILFIN_TOMBSTONE_PTR)
            {
                continue;
            }
            size_t idx = (size_t)_ptr_hash_u64(ptr) & mask;
            while (next[idx])
            {
                idx = (idx + 1) & mask;
            }
            next[idx] = ptr;
        }
        free(old);
    }

    _sailfin_owned_table = next;
    _sailfin_owned_table_cap = cap;
    _sailfin_owned_table_tombstones = 0;
    // _sailfin_owned_table_len remains unchanged.
    return true;
}

static bool _owned_table_contains_unlocked(const char *ptr)
{
    if (!_sailfin_owned_table || _sailfin_owned_table_cap == 0 || !ptr)
    {
        return false;
    }
    size_t mask = _sailfin_owned_table_cap - 1;
    size_t idx = (size_t)_ptr_hash_u64(ptr) & mask;
    for (size_t probe = 0; probe < _sailfin_owned_table_cap; probe++)
    {
        char *slot = _sailfin_owned_table[idx];
        if (!slot)
        {
            return false;
        }
        if (slot != SAILFIN_TOMBSTONE_PTR && slot == ptr)
        {
            return true;
        }
        idx = (idx + 1) & mask;
    }
    return false;
}

static void _owned_table_insert_unlocked(char *ptr)
{
    if (!ptr)
    {
        return;
    }

    if (!_sailfin_owned_table || _sailfin_owned_table_cap == 0)
    {
        if (!_owned_table_resize_unlocked(1024))
        {
            return;
        }
    }

    // If too many tombstones, rehash in place.
    if (_sailfin_owned_table_tombstones * 10 >= _sailfin_owned_table_cap * 3)
    {
        (void)_owned_table_resize_unlocked(_sailfin_owned_table_cap);
    }

    // Resize at ~70% load factor counting tombstones.
    size_t effective = _sailfin_owned_table_len + _sailfin_owned_table_tombstones + 1;
    if (effective * 10 >= _sailfin_owned_table_cap * 7)
    {
        (void)_owned_table_resize_unlocked(_sailfin_owned_table_cap * 2);
    }

    size_t mask = _sailfin_owned_table_cap - 1;
    size_t idx = (size_t)_ptr_hash_u64(ptr) & mask;
    size_t first_tombstone = (size_t)(-1);

    for (;;)
    {
        char *slot = _sailfin_owned_table[idx];
        if (!slot)
        {
            if (first_tombstone != (size_t)(-1))
            {
                _sailfin_owned_table[first_tombstone] = ptr;
                _sailfin_owned_table_tombstones--;
            }
            else
            {
                _sailfin_owned_table[idx] = ptr;
            }
            _sailfin_owned_table_len++;
            return;
        }
        if (slot == ptr)
        {
            return;
        }
        if (slot == SAILFIN_TOMBSTONE_PTR && first_tombstone == (size_t)(-1))
        {
            first_tombstone = idx;
        }
        idx = (idx + 1) & mask;
    }
}

static bool _owned_table_remove_unlocked(const char *ptr)
{
    if (!_sailfin_owned_table || _sailfin_owned_table_cap == 0 || !ptr)
    {
        return false;
    }

    size_t mask = _sailfin_owned_table_cap - 1;
    size_t idx = (size_t)_ptr_hash_u64(ptr) & mask;
    for (size_t probe = 0; probe < _sailfin_owned_table_cap; probe++)
    {
        char *slot = _sailfin_owned_table[idx];
        if (!slot)
        {
            return false;
        }
        if (slot != SAILFIN_TOMBSTONE_PTR && slot == ptr)
        {
            _sailfin_owned_table[idx] = SAILFIN_TOMBSTONE_PTR;
            _sailfin_owned_table_len--;
            _sailfin_owned_table_tombstones++;
            return true;
        }
        idx = (idx + 1) & mask;
    }
    return false;
}

static bool _persistent_table_contains_unlocked(const char *ptr)
{
    if (!_sailfin_persistent_table || _sailfin_persistent_table_cap == 0 || !ptr)
    {
        return false;
    }

    size_t mask = _sailfin_persistent_table_cap - 1;
    size_t idx = (size_t)_ptr_hash_u64(ptr) & mask;
    for (size_t probe = 0; probe < _sailfin_persistent_table_cap; probe++)
    {
        char *slot = _sailfin_persistent_table[idx];
        if (!slot)
        {
            return false;
        }
        if (slot == ptr)
        {
            return true;
        }
        idx = (idx + 1) & mask;
    }
    return false;
}

static bool _persistent_table_resize_unlocked(size_t new_cap)
{
    if (new_cap < 1024)
    {
        new_cap = 1024;
    }
    // Ensure power-of-two.
    size_t cap = 1;
    while (cap < new_cap)
    {
        cap <<= 1;
    }

    char **next = (char **)calloc(cap, sizeof(char *));
    if (!next)
    {
        return false;
    }

    // Rehash.
    if (_sailfin_persistent_table && _sailfin_persistent_table_cap)
    {
        size_t old_cap = _sailfin_persistent_table_cap;
        char **old = _sailfin_persistent_table;

        size_t mask = cap - 1;
        for (size_t i = 0; i < old_cap; i++)
        {
            char *ptr = old[i];
            if (!ptr)
            {
                continue;
            }
            size_t idx = (size_t)_ptr_hash_u64(ptr) & mask;
            while (next[idx])
            {
                idx = (idx + 1) & mask;
            }
            next[idx] = ptr;
        }

        free(old);
    }

    _sailfin_persistent_table = next;
    _sailfin_persistent_table_cap = cap;
    return true;
}

static void _persistent_table_insert_unlocked(char *ptr)
{
    if (!ptr)
    {
        return;
    }

    // Lazy init.
    if (!_sailfin_persistent_table || _sailfin_persistent_table_cap == 0)
    {
        if (!_persistent_table_resize_unlocked(1024))
        {
            return;
        }
    }

    // Resize at ~70% load factor.
    if ((_sailfin_persistent_table_len + 1) * 10 >= _sailfin_persistent_table_cap * 7)
    {
        (void)_persistent_table_resize_unlocked(_sailfin_persistent_table_cap * 2);
    }

    // Insert if absent.
    size_t mask = _sailfin_persistent_table_cap - 1;
    size_t idx = (size_t)_ptr_hash_u64(ptr) & mask;
    for (;;)
    {
        char *slot = _sailfin_persistent_table[idx];
        if (!slot)
        {
            _sailfin_persistent_table[idx] = ptr;
            _sailfin_persistent_table_len++;
            return;
        }
        if (slot == ptr)
        {
            return;
        }
        idx = (idx + 1) & mask;
    }
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
    _owned_table_insert_unlocked(ptr);
    pthread_mutex_unlock(&_sailfin_owned_string_lock);
}

static bool _is_persistent_ptr(char *ptr)
{
    if (!ptr)
    {
        return false;
    }
    pthread_mutex_lock(&_sailfin_persistent_lock);
    bool ok = _persistent_table_contains_unlocked(ptr);
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

static void _print_line(FILE *stream, const char *prefix, const char *msg)
{
    if (!stream)
    {
        stream = stderr;
    }
    if (!msg)
    {
        msg = "";
    }
    if (prefix)
    {
        fputs(prefix, stream);
    }

    uint32_t codepoint = 0;
    if (_is_immediate_codepoint_string(msg, &codepoint))
    {
        unsigned char buf[5] = {0};
        _utf8_encode(codepoint, buf);
        fputs((const char *)buf, stream);
    }
    else
    {
        fputs(msg, stream);
    }
    fputc('\n', stream);
    fflush(stream);
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
    if (parsed > 100000000)
    {
        return 100000000;
    }
    return (int)parsed;
}

static size_t _env_sizet(const char *name, size_t fallback)
{
    const char *value = getenv(name);
    if (!value || value[0] == '\0')
    {
        return fallback;
    }

    char *end = NULL;
    unsigned long long parsed = strtoull(value, &end, 10);
    if (end == value)
    {
        return fallback;
    }
    if (parsed > (unsigned long long)SIZE_MAX)
    {
        return (size_t)SIZE_MAX;
    }
    return (size_t)parsed;
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

static void _maybe_print_array_backtrace(const char *context, const void *ptr)
{
    if (!_env_enabled("SAILFIN_TRACE_ARRAY_BACKTRACE"))
    {
        return;
    }

    static int remaining = -1;
    if (remaining < 0)
    {
        remaining = _env_int("SAILFIN_TRACE_ARRAY_BACKTRACE_BUDGET", 3);
    }
    if (remaining <= 0)
    {
        return;
    }
    remaining--;

    fprintf(
        stderr,
        "[stage2-native] backtrace (%s): array=%p\n",
        context ? context : "?",
        ptr);
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

    // Guard against non-canonical pointers.
    // On arm64 macOS the virtual address space is not a full 64-bit range;
    // mis-tagged values (notably IEEE-754 doubles like 1.0 => 0x3ff0...) can
    // otherwise be interpreted as pointers and fault on the first read.
    // Treat these as truncated/invalid instead of crashing.
    {
        uintptr_t addr = (uintptr_t)text;
        uintptr_t high = addr >> 48;
        if (high != 0u && high != 0xffffu)
        {
            if (out_truncated)
            {
                *out_truncated = true;
            }
            return 0;
        }
    }

#if defined(__APPLE__) && !defined(SAILFIN_WITH_ASAN)
    static int guard_init = 0;
    static int guard_enabled = 0;
    if (!guard_init)
    {
        guard_init = 1;
        guard_enabled = _env_int("SAILFIN_GUARD_STRING_PTRS", 0) ? 1 : 0;
    }
    if (guard_enabled && !_string_ptr_mapped_readable(text))
    {
        if (out_truncated)
        {
            *out_truncated = true;
        }
        return 0;
    }
#endif

    // Defensive cap: most stage2 compiler strings are tiny, but the compiler
    // also manipulates large strings (notably full LLVM modules) that can
    // exceed 1 MiB. Keep a bounded scan to avoid runaway reads for invalid
    // pointers, but allow a higher default and make it configurable.
    // Cache the result to avoid calling getenv on every string_length call.
    static size_t cached_max_scan = 0;
    if (!cached_max_scan)
    {
        cached_max_scan = _env_sizet("SAILFIN_MAX_STRLEN_SCAN", 16u * 1024u * 1024u);
        if (cached_max_scan < 4096u)
        {
            cached_max_scan = 4096u;
        }
        if (cached_max_scan > (512u * 1024u * 1024u))
        {
            cached_max_scan = (512u * 1024u * 1024u);
        }
    }
    size_t max_scan = cached_max_scan;

#if !defined(SAILFIN_WITH_ASAN)
    // Fast path for non-ASAN builds: rely on libc's bounded scan.
    // We keep the pointer plausibility guards above to avoid the most common
    // "mis-tagged value as char*" crashes, but we don't pay per-byte overhead.
    size_t n = strnlen(text, max_scan);
    if (out_truncated)
    {
        *out_truncated = (n == max_scan);
    }
    return n;
#else

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
#endif
}

#if defined(SAILFIN_WITH_ASAN)
extern int __asan_address_is_poisoned(const volatile void *addr);
static SAILFIN_NOINLINE bool _asan_poisoned(const void *addr)
{
    if (!addr)
    {
        return false;
    }

    // Some invalid/mis-tagged values can look like pointers (notably IEEE-754
    // doubles such as 3.0 => 0x4008...) and crash inside ASAN's shadow mapping
    // logic. Treat these as poisoned without calling into ASAN.
    {
        uintptr_t raw = (uintptr_t)addr;
        if (raw < 4096u)
        {
            return true;
        }
        uintptr_t high = raw >> 48;
        if (high != 0u && high != 0xffffu)
        {
            return true;
        }
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
    _persistent_table_insert_unlocked(ptr);
    pthread_mutex_unlock(&_sailfin_persistent_lock);
}

void sailfin_runtime_string_drop(char *text)
{
    static int free_enabled = -1;
    if (free_enabled < 0)
    {
        // Stage2 currently lacks a precise ownership/RC model for strings.
        // In particular, strings are frequently stored inside arrays while the
        // original locals are still dropped, leading to use-after-free.
        //
        // Default to *not* freeing strings to keep compiler output correct.
        // You can opt in to freeing for debugging/profiling experiments.
        if (_env_enabled("SAILFIN_DISABLE_STRING_FREE"))
        {
            free_enabled = 0;
        }
        else
        {
            free_enabled = _env_enabled("SAILFIN_ENABLE_STRING_FREE") ? 1 : 0;
        }
    }
    if (!free_enabled)
    {
        return;
    }

    if (!text)
    {
        return;
    }
    if (_is_immediate_codepoint_string(text, NULL))
    {
        return;
    }

    // Defensive: the stage2 compiler produces some very large strings (notably
    // full LLVM modules). We've observed nondeterministic corruption when such
    // strings are dropped and their storage is reused while still in use.
    // Instead of freeing large strings, mark them persistent for the lifetime
    // of the process.
    bool truncated = false;
    size_t n = _safe_strlen_asan(text, &truncated);
    (void)truncated;
    if (n >= (64u * 1024u))
    {
        sailfin_runtime_mark_persistent(text);
        return;
    }

    if (_is_persistent_ptr(text))
    {
        return;
    }

    pthread_mutex_lock(&_sailfin_owned_string_lock);
    bool owned = _owned_table_remove_unlocked(text);
    pthread_mutex_unlock(&_sailfin_owned_string_lock);
    if (!owned)
    {
        return;
    }
    free(text);
}

void sailfin_runtime_print_raw(char *msg)
{
    if (msg)
    {
        fputs(msg, stdout);
        fputc('\n', stdout);
        fflush(stdout);
    }
}
void sailfin_runtime_print_err(char *msg)
{
    if (msg)
    {
        fputs(msg, stderr);
        fputc('\n', stderr);
        fflush(stderr);
    }
}
// Bridge: older seeds (< v0.5) that don't have the "print" runtime helper
// descriptor emit bare `@print` calls when compiling `print("text")`.
// The seed may emit `call double @print(i8*)` (default return type), so this
// returns double for ABI compatibility. The return value is unused.
// Can be removed once all seeds include the "print" → "sailfin_runtime_print_raw" mapping.
#if !defined(_WIN32) && !defined(__MINGW32__)
__attribute__((weak))
#endif
double print(char *msg)
{
    sailfin_runtime_print_raw(msg);
    return 0.0;
}
void sailfin_runtime_print_info(char *msg) { _print_line(stdout, "[info] ", msg); }
void sailfin_runtime_print_warn(char *msg) { _print_line(stderr, "[warn] ", msg); }
void sailfin_runtime_print_error(char *msg) { _print_line(stderr, "[error] ", msg); }

// Debug: print a pointer value as hex to stderr
void sailfin_runtime_debug_ptr(const char *label, const void *ptr)
{
    fprintf(stderr, "[dbg] %s = %p", label ? label : "ptr", ptr);
    if (ptr && (uintptr_t)ptr >= 4096u)
    {
        // Try to read first 8 bytes
        const unsigned char *p = (const unsigned char *)ptr;
        fprintf(stderr, " bytes=[%02x %02x %02x %02x %02x %02x %02x %02x]",
                p[0], p[1], p[2], p[3], p[4], p[5], p[6], p[7]);
    }
    fprintf(stderr, "\n");
    fflush(stderr);
}

// -----------------------------------------------------------------------------
// Debug helpers (best-effort; used by selfhost crash instrumentation)
// -----------------------------------------------------------------------------

static int _sailfin_debug_dump_budget = -1;

static bool _sailfin_debug_dump_allowed(void)
{
    if (_sailfin_debug_dump_budget < 0)
    {
        const char *env = getenv("SAILFIN_DEBUG_DUMP_BUDGET");
        if (!env || env[0] == '\0')
        {
            _sailfin_debug_dump_budget = 32;
        }
        else
        {
            long v = strtol(env, NULL, 10);
            if (v < 0)
            {
                v = 0;
            }
            if (v > 1000000)
            {
                v = 1000000;
            }
            _sailfin_debug_dump_budget = (int)v;
        }
    }

    if (_sailfin_debug_dump_budget <= 0)
    {
        return false;
    }

    _sailfin_debug_dump_budget -= 1;
    return true;
}

void sailfin_runtime_debug_dump_u64(uint64_t value)
{
    if (!_sailfin_debug_dump_allowed())
    {
        return;
    }
    fprintf(stderr, "[debug] u64=0x%016llx (%llu)\n", (unsigned long long)value, (unsigned long long)value);
    fflush(stderr);
}

void sailfin_runtime_debug_dump_ptr(void *ptr)
{
    if (!_sailfin_debug_dump_allowed())
    {
        return;
    }
    fprintf(stderr, "[debug] ptr=%p\n", ptr);
    fflush(stderr);
}

void sailfin_runtime_sleep(double seconds)
{
    if (seconds <= 0.0)
    {
        return;
    }
#if defined(_WIN32)
    double millis = seconds * 1000.0;
    if (millis > 4294967295.0)
    {
        millis = 4294967295.0;
    }
    Sleep((DWORD)millis);
#else
    double micros = seconds * 1000000.0;
    if (micros > 2147483647.0)
    {
        micros = 2147483647.0;
    }
    usleep((useconds_t)micros);
#endif
}

/* Check if a string pointer looks like a corrupted double-encoded value.
   On macOS ARM64, valid user-space pointers are < 0x800000000000.
   Double-encoded pointers (via ptrtoint→sitofp→double→bitcast back) produce
   addresses with high bits set that are not valid user memory. */
static inline int _is_corrupted_string_ptr(const char *ptr)
{
    uintptr_t value = (uintptr_t)ptr;
    /* NULL or very low addresses are already handled elsewhere */
    if (value == 0)
        return 0;
    /* Pointers above 48-bit user-space range are likely corrupted doubles */
    if (value > (uintptr_t)0x7FFFFFFFFFFF)
        return 1;
    return 0;
}

int64_t sailfin_runtime_string_length(char *text)
{
    if (!text || _is_corrupted_string_ptr(text))
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

        // Optional, low-volume debugging to track down mis-tagged values being
        // treated as `char *`.
        _maybe_print_string_backtrace(
            "string_length",
            text,
            _is_immediate_codepoint_string(text, NULL),
            _asan_poisoned(text),
            true,
            NULL,
            false,
            false,
            false);
    }

    static int trace_enabled = -1;
    if (trace_enabled < 0)
    {
        const char *trace = getenv("SAILFIN_TRACE_STRING_LENGTH");
        trace_enabled = (trace && trace[0] != '\0' && trace[0] != '0') ? 1 : 0;
    }

    if (trace_enabled)
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
    _maybe_init_alloc_stats();
    if (!text)
    {
        char *out = (char *)malloc(1);
        if (out)
        {
            out[0] = '\0';
        }
        if (_alloc_stats_enabled && out)
        {
            _alloc_stats_substring_calls++;
            _alloc_stats_substring_bytes += 1;
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
        if (_alloc_stats_enabled)
        {
            _alloc_stats_substring_calls++;
            _alloc_stats_substring_bytes += (uint64_t)((size_t)length + 1u);
        }
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
    if (_alloc_stats_enabled)
    {
        _alloc_stats_substring_calls++;
        _alloc_stats_substring_bytes += (uint64_t)((size_t)length + 1u);
    }
    _track_owned_string(out);
    return out;
}

char *sailfin_runtime_substring_unchecked(char *text, int64_t start, int64_t end)
{
    _maybe_init_alloc_stats();
    if (!text)
    {
        char *out = (char *)malloc(1);
        if (out)
        {
            out[0] = '\0';
        }
        if (_alloc_stats_enabled && out)
        {
            _alloc_stats_substring_calls++;
            _alloc_stats_substring_bytes += 1;
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
        if (_alloc_stats_enabled)
        {
            _alloc_stats_substring_calls++;
            _alloc_stats_substring_bytes += (uint64_t)((size_t)length + 1u);
        }
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

    // Truly unchecked: trust the caller's bounds (they already checked via
    // .length which calls strlen once).  Removing the per-call strlen turns
    // per-character scanning loops from O(n²) to O(n).
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
    if (_alloc_stats_enabled)
    {
        _alloc_stats_substring_calls++;
        _alloc_stats_substring_bytes += (uint64_t)((size_t)length + 1u);
    }
    _track_owned_string(out);
    return out;
}

char *sailfin_runtime_string_concat(char *a, char *b)
{
    _maybe_init_alloc_stats();
    static int strict_strings = -1;
    if (strict_strings < 0)
    {
        strict_strings = _env_enabled("SAILFIN_STRICT_STRINGS") ? 1 : 0;
    }

    char *a_in = a;
    char *b_in = b;
    if (!a || _is_corrupted_string_ptr(a))
    {
        if (strict_strings && a)
        {
            fprintf(stderr, "[stage2-native] string_concat got NULL lhs\n");
            fflush(stderr);
            abort();
        }
        a = "";
    }
    if (!b || _is_corrupted_string_ptr(b))
    {
        if (strict_strings && b)
        {
            fprintf(stderr, "[stage2-native] string_concat got NULL rhs\n");
            fflush(stderr);
            abort();
        }
        b = "";
    }

    uint32_t a_codepoint = 0;
    uint32_t b_codepoint = 0;
    bool a_immediate = _is_immediate_codepoint_string(a, &a_codepoint);
    bool b_immediate = _is_immediate_codepoint_string(b, &b_codepoint);

    static int trace_immediate = -1;
    if (trace_immediate < 0)
    {
        trace_immediate = _env_enabled("SAILFIN_TRACE_IMMEDIATE_STRINGS") ? 1 : 0;
    }

    if (trace_immediate && (a_immediate || b_immediate))
    {
        static int immediate_budget = 64;
        if (immediate_budget > 0)
        {
            immediate_budget--;
            fprintf(
                stderr,
                "[stage2-native] string_concat immediate arg(s): a=%p%s cp=%u (0x%x) b=%p%s cp=%u (0x%x)\n",
                (void *)a,
                a_immediate ? " immediate" : "",
                (unsigned)a_codepoint,
                (unsigned)a_codepoint,
                (void *)b,
                b_immediate ? " immediate" : "",
                (unsigned)b_codepoint,
                (unsigned)b_codepoint);
            fflush(stderr);

            // Backtrace is gated separately to keep noise low by default.
            _maybe_print_string_backtrace(
                "string_concat immediate",
                a,
                a_immediate,
                false,
                false,
                b,
                b_immediate,
                false,
                false);
        }
    }

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

    static int trace_enabled = -1;
    if (trace_enabled < 0)
    {
        const char *trace = getenv("SAILFIN_TRACE_STRING_CONCAT");
        trace_enabled = (trace && trace[0] != '\0' && trace[0] != '0') ? 1 : 0;
    }

    if (trace_enabled)
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

    static int concat_limit_init = 0;
    static size_t concat_limit = 0;
    if (!concat_limit_init)
    {
        concat_limit_init = 1;
        int limit = _env_int("SAILFIN_MAX_STRING_CONCAT", 20000000);
        if (limit < 0)
        {
            limit = 0;
        }
        concat_limit = (size_t)limit;
    }
    if (concat_limit > 0 && (alen + blen) > concat_limit)
    {
        fprintf(
            stderr,
            "[stage2-native] string_concat limit exceeded (alen=%zu blen=%zu limit=%zu)\n",
            alen,
            blen,
            concat_limit);
        fflush(stderr);
        sailfin_runtime_raise_value_error("string concat limit exceeded");
    }
    if (alen > SIZE_MAX - blen)
    {
        fprintf(
            stderr,
            "[stage2-native] string_concat overflow (alen=%zu blen=%zu)\n",
            alen,
            blen);
        fflush(stderr);
        sailfin_runtime_raise_value_error("string concat overflow");
    }
    if (concat_limit > 0 && alen > concat_limit - blen)
    {
        fprintf(
            stderr,
            "[stage2-native] string_concat limit exceeded (alen=%zu blen=%zu limit=%zu)\n",
            alen,
            blen,
            concat_limit);
        fflush(stderr);
        sailfin_runtime_raise_value_error("string concat limit exceeded");
    }

    static int trace_min_len_init = 0;
    static size_t trace_min_len = 0;
    if (!trace_min_len_init)
    {
        trace_min_len_init = 1;
        trace_min_len = _env_sizet("SAILFIN_TRACE_STRING_CONCAT_MIN_LEN", 0);
    }

    if (trace_min_len > 0)
    {
        size_t total_len = alen + blen;
        if (total_len >= trace_min_len)
        {
            fprintf(
                stderr,
                "[stage2-native] string_concat large total=%zu alen=%zu blen=%zu a=%p%s%s cp=%u b=%p%s%s cp=%u\n",
                total_len,
                alen,
                blen,
                (void *)a,
                a_immediate ? " immediate" : "",
                a_truncated ? " truncated" : "",
                (unsigned)a_codepoint,
                (void *)b,
                b_immediate ? " immediate" : "",
                b_truncated ? " truncated" : "",
                (unsigned)b_codepoint);
            fflush(stderr);

            if ((a_immediate || b_immediate) || (a_truncated || b_truncated))
            {
                _maybe_print_string_backtrace(
                    "string_concat large",
                    a,
                    a_immediate,
                    a_poisoned,
                    a_truncated,
                    b,
                    b_immediate,
                    b_poisoned,
                    b_truncated);
            }
        }
    }

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

        if (!b_truncated)
        {
            unsigned char preview_buf[9] = {0};
            size_t preview_len = blen;
            if (preview_len > 8)
            {
                preview_len = 8;
            }

            if (b_immediate)
            {
                memcpy(preview_buf, b_buf, preview_len);
            }
            else
            {
                memcpy(preview_buf, (const unsigned char *)b, preview_len);
            }

            if (blen == 1 && preview_buf[0] >= 32 && preview_buf[0] < 127)
            {
                fprintf(stderr, "[stage2-native] string_concat: rhs preview '%c' (0x%02x)\n", (char)preview_buf[0], (unsigned)preview_buf[0]);
            }
            else
            {
                fprintf(stderr, "[stage2-native] string_concat: rhs preview bytes");
                for (size_t i = 0; i < preview_len; i++)
                {
                    fprintf(stderr, " %02x", (unsigned)preview_buf[i]);
                }
                fprintf(stderr, "\n");
            }
            fflush(stderr);
        }

        _maybe_print_string_backtrace(
            "string_concat unterminated",
            a,
            a_immediate,
            a_poisoned,
            a_truncated,
            b,
            b_immediate,
            b_poisoned,
            b_truncated);
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
        fprintf(
            stderr,
            "[stage2-native] string_concat OOM (alen=%zu blen=%zu total=%zu) a=%p b=%p a_in=%p b_in=%p\n",
            alen,
            blen,
            alen + blen + 1 + pad,
            (void *)a,
            (void *)b,
            (void *)a_in,
            (void *)b_in);
        fflush(stderr);
        if (strict_strings)
        {
            abort();
        }
        return NULL;
    }

    if (_alloc_stats_enabled)
    {
        _alloc_stats_string_concat_calls++;
        _alloc_stats_string_concat_bytes += (uint64_t)(alen + blen + 1 + pad);
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

    // Record recent large string allocations to help debug cases where
    // downstream code accidentally returns a pointer into the middle of a
    // concatenated buffer (dropping prefixes like the LLVM module header).
    if (alen + blen >= 1024)
    {
        _recent_string_record(out, alen + blen);
    }

    static int trace_llvm_prefix_init = 0;
    static int trace_llvm_prefix_enabled = 0;
    static size_t trace_llvm_prefix_min_len = 0;
    static int trace_llvm_prefix_budget = 0;
    if (!trace_llvm_prefix_init)
    {
        trace_llvm_prefix_init = 1;
        trace_llvm_prefix_enabled = _env_enabled("SAILFIN_TRACE_LLVM_CORRUPT_PREFIX") ? 1 : 0;
        trace_llvm_prefix_min_len = _env_sizet("SAILFIN_TRACE_LLVM_CORRUPT_PREFIX_MIN_LEN", 0);
        trace_llvm_prefix_budget = _env_int("SAILFIN_TRACE_LLVM_CORRUPT_PREFIX_BUDGET", 5);
    }

    if (trace_llvm_prefix_enabled)
    {
        size_t total_len = alen + blen;
        if (total_len >= trace_llvm_prefix_min_len && total_len >= 5)
        {
            // Observed corrupt output tends to start with a stray one-letter
            // prefix (historically 'r', sometimes 'q') followed by whitespace
            // and then an indented instruction.
            // Example prefixes:
            //   "r\n  %t..."
            //   "r\n  br ..."
            //   "q\n  store ..."
            //   "r  %t..."
            int k = 1;
            while (k < 10 && (out[k] == ' ' || out[k] == '\n' || out[k] == '\r' || out[k] == '\t'))
            {
                k++;
            }
            unsigned char next = (k < 10) ? (unsigned char)out[k] : 0;
            bool looks_like_instr = (next == '%') || (next >= 'a' && next <= 'z') || (next >= 'A' && next <= 'Z');
            // Require at least one whitespace character after the leading
            // stray prefix to avoid false positives like "raw_target".
            bool has_ws_after_prefix = (total_len >= 2) && (out[1] == ' ' || out[1] == '\n' || out[1] == '\r' || out[1] == '\t');
            bool is_stray_prefix = (out[0] == 'r' || out[0] == 'q');
            if (is_stray_prefix && has_ws_after_prefix && k < 10 && looks_like_instr)
            {
                if (trace_llvm_prefix_budget > 0)
                {
                    trace_llvm_prefix_budget--;
                    long long a_source_at = -1;
                    long long b_source_at = -1;
                    long long out_source_at = -1;
                    {
                        const char *needle = "source_filename";
                        size_t needle_len = strlen(needle);

                        if (!a_immediate && a && alen >= needle_len)
                        {
                            size_t limit = alen;
                            if (limit > (size_t)(2 * 1024 * 1024))
                            {
                                limit = (size_t)(2 * 1024 * 1024);
                            }
                            for (size_t i = 0; i + needle_len <= limit; i++)
                            {
                                if (((const char *)a)[i] == needle[0] && memcmp(((const char *)a) + i, needle, needle_len) == 0)
                                {
                                    a_source_at = (long long)i;
                                    break;
                                }
                            }
                        }

                        if (!b_immediate && b && blen >= needle_len)
                        {
                            size_t limit = blen;
                            if (limit > (size_t)(2 * 1024 * 1024))
                            {
                                limit = (size_t)(2 * 1024 * 1024);
                            }
                            for (size_t i = 0; i + needle_len <= limit; i++)
                            {
                                if (((const char *)b)[i] == needle[0] && memcmp(((const char *)b) + i, needle, needle_len) == 0)
                                {
                                    b_source_at = (long long)i;
                                    break;
                                }
                            }
                        }

                        if (out && total_len >= needle_len)
                        {
                            size_t limit = total_len;
                            if (limit > (size_t)(2 * 1024 * 1024))
                            {
                                limit = (size_t)(2 * 1024 * 1024);
                            }
                            for (size_t i = 0; i + needle_len <= limit; i++)
                            {
                                if (((const char *)out)[i] == needle[0] && memcmp(((const char *)out) + i, needle, needle_len) == 0)
                                {
                                    out_source_at = (long long)i;
                                    break;
                                }
                            }
                        }
                    }
                    char a_preview[40];
                    char b_preview[40];
                    a_preview[0] = '\0';
                    b_preview[0] = '\0';

                    if (a)
                    {
                        if (a_immediate)
                        {
                            unsigned char tmp[5] = {0};
                            size_t n = _utf8_encode(a_codepoint, tmp);
                            size_t take = n < 32 ? n : 32;
                            if (take > 0)
                            {
                                memcpy(a_preview, tmp, take);
                            }
                            a_preview[take] = '\0';
                        }
                        else
                        {
                            bool truncated = false;
                            size_t n = _safe_strlen_asan(a, &truncated);
                            size_t take = n < 32 ? n : 32;
                            if (take > 0)
                            {
                                memcpy(a_preview, a, take);
                            }
                            a_preview[take] = '\0';
                        }
                    }
                    if (b)
                    {
                        if (b_immediate)
                        {
                            unsigned char tmp[5] = {0};
                            size_t n = _utf8_encode(b_codepoint, tmp);
                            size_t take = n < 32 ? n : 32;
                            if (take > 0)
                            {
                                memcpy(b_preview, tmp, take);
                            }
                            b_preview[take] = '\0';
                        }
                        else
                        {
                            bool truncated = false;
                            size_t n = _safe_strlen_asan(b, &truncated);
                            size_t take = n < 32 ? n : 32;
                            if (take > 0)
                            {
                                memcpy(b_preview, b, take);
                            }
                            b_preview[take] = '\0';
                        }
                    }

                    fprintf(
                        stderr,
                        "[stage2-native] suspicious llvm output prefix from string_concat out=%p len=%zu alen=%zu blen=%zu a_source_at=%lld b_source_at=%lld out_source_at=%lld a_preview=\"%s\" b_preview=\"%s\"\n",
                        (void *)out,
                        total_len,
                        alen,
                        blen,
                        a_source_at,
                        b_source_at,
                        out_source_at,
                        a_preview,
                        b_preview);
                    fflush(stderr);
                }

                _maybe_print_string_backtrace(
                    "llvm_corrupt_prefix",
                    a,
                    a_immediate,
                    a_poisoned,
                    a_truncated,
                    b,
                    b_immediate,
                    b_poisoned,
                    b_truncated);
            }
        }
    }

    if (trace_min_len > 0)
    {
        size_t total_len = alen + blen;
        if (total_len >= trace_min_len)
        {
            char preview_buf[40];
            preview_buf[0] = '\0';
            size_t take = total_len < 32 ? total_len : 32;
            if (take > 0)
            {
                memcpy(preview_buf, out, take);
            }
            preview_buf[take] = '\0';
            fprintf(
                stderr,
                "[stage2-native] string_concat large out=%p preview=\"%s\"\n",
                (void *)out,
                preview_buf);
            fflush(stderr);
        }
    }

    return out;
}

char *sailfin_runtime_number_to_string(double value)
{
    static int trace_enabled = -1;
    if (trace_enabled < 0)
    {
        const char *trace = getenv("SAILFIN_TRACE_NUMBER_TO_STRING");
        trace_enabled = (trace && trace[0] != '\0' && trace[0] != '0') ? 1 : 0;
    }
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
    if (trace_enabled)
    {
        static int trace_budget = 32;
        if (trace_budget > 0)
        {
            trace_budget--;
            fprintf(stderr, "[stage2-native] number_to_string(%.6f) -> %s\n", value, out);
            fflush(stderr);
        }
    }
    return out;
}

double sailfin_runtime_string_to_number(char *text)
{
    if (!text)
    {
        return 0.0;
    }
    char *end = NULL;
    double out = strtod(text, &end);
    return out;
}

static SailfinPtrArray *_alloc_array(int64_t len)
{
    static int array_len_limit_init = 0;
    static int64_t array_len_limit = 0;
    if (!array_len_limit_init)
    {
        array_len_limit_init = 1;
        int limit = _env_int("SAILFIN_MAX_ARRAY_LEN", 5000000);
        if (limit < 0)
        {
            limit = 0;
        }
        array_len_limit = (int64_t)limit;
    }
    if (array_len_limit > 0 && len > array_len_limit)
    {
        fprintf(
            stderr,
            "[stage2-native] array alloc limit exceeded (len=%lld limit=%lld)\n",
            (long long)len,
            (long long)array_len_limit);
        fflush(stderr);
        sailfin_runtime_raise_value_error("array alloc limit exceeded");
    }
    _maybe_init_alloc_stats();
    SailfinPtrArray *arr = (SailfinPtrArray *)malloc(sizeof(SailfinPtrArray));
    if (!arr)
    {
        return NULL;
    }

    // NOTE: Stage2 arrays are represented in LLVM as `{ i8**, i64 }`.
    // We cannot extend the struct to store capacity without breaking ABI.
    // Instead, we store a small header immediately *before* `arr->data`:
    //   data[-2] = magic tag
    //   data[-1] = capacity (as an integer cast through a pointer)
    // Canaries are placed after `capacity` slots.

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

    // Preserve the historical "len+2" padding behaviour to tolerate occasional
    // off-by-one/off-by-two writes from stage2-native code.
    size_t min_capacity = 2u;
    if (len > 0)
    {
        min_capacity = (size_t)len + 2u;
    }

    // Capacity policy:
    // - Small arrays: round up to the next power-of-two (reduces churn).
    // - Large arrays: allocate close to requested size to avoid large over-allocation
    //   (which can explode peak RSS during compilation).
    size_t capacity = min_capacity;
    if (capacity < 8u)
    {
        capacity = 8u;
    }
    if (capacity <= 1024u)
    {
        size_t pow2 = 8u;
        while (pow2 < capacity)
        {
            pow2 *= 2u;
        }
        capacity = pow2;
    }
    if (capacity > 10000000u)
    {
        capacity = 10000000u;
    }

    const size_t header_slots = 2u;
    const size_t canary_slots = 4u;
    const uintptr_t header_magic = (uintptr_t)0x5341494c46494e43ull; // "SAILFINC" tag
    char **raw = (char **)calloc(header_slots + capacity + canary_slots, sizeof(char *));
    if (!raw)
    {
        free(arr);
        return NULL;
    }

    if (_alloc_stats_enabled)
    {
        _alloc_stats_array_alloc_calls++;
        _alloc_stats_array_alloc_bytes += (uint64_t)sizeof(SailfinPtrArray);
        _alloc_stats_array_alloc_bytes += (uint64_t)((header_slots + capacity + canary_slots) * sizeof(char *));
    }

    raw[0] = (char *)header_magic;
    raw[1] = (char *)(uintptr_t)capacity;
    arr->data = raw + header_slots;

    for (size_t i = 0; i < canary_slots; i++)
    {
        arr->data[capacity + i] = (char *)(header_magic + i);
    }

    _recent_array_record((const void *)arr->data);

    // Optional diagnostics: trace very large array allocations.
    static int trace_large_init = 0;
    static size_t trace_large_min_cap = 0;
    static int trace_large_budget = 0;
    if (!trace_large_init)
    {
        trace_large_init = 1;
        trace_large_min_cap = _env_sizet("SAILFIN_TRACE_LARGE_ARRAY_ALLOC_MIN_CAP", 0);
        trace_large_budget = _env_int("SAILFIN_TRACE_LARGE_ARRAY_ALLOC_BUDGET", 16);
    }
    if (trace_large_min_cap > 0 && trace_large_budget > 0 && capacity >= trace_large_min_cap)
    {
        trace_large_budget--;
        fprintf(
            stderr,
            "[stage2-native] large_array_alloc len=%lld cap=%zu arr=%p data=%p\n",
            (long long)len,
            capacity,
            (void *)arr,
            (void *)arr->data);
        fflush(stderr);
        _trace_backtrace_budgeted("large_array_alloc");
    }

    return arr;
}

static int _array_is_suspicious_ptr(const void *ptr)
{
    uintptr_t value = (uintptr_t)ptr;
    if (value < 4096u)
    {
        return 1;
    }
    return 0;
}

static void _array_check_canary(const char *label, SailfinPtrArray *arr)
{
    if (_array_is_suspicious_ptr(arr))
    {
        if (label)
        {
            fprintf(
                stderr,
                "[stage2-native] array_canary skipped suspicious ptr label=%s arr=%p\n",
                label,
                (void *)arr);
            fflush(stderr);
        }
        return;
    }
    static int canary_init = 0;
    static int canary_enabled = 0;
    if (!canary_init)
    {
        canary_init = 1;
        canary_enabled = _env_enabled("SAILFIN_TRACE_ARRAY_CANARY") ? 1 : 0;
    }
    if (!canary_enabled)
    {
        return;
    }
    if (!arr || !arr->data)
    {
        return;
    }

    // Skip canary validation for arrays not allocated by `_alloc_array`.
    // Stage2 frequently passes stack-allocated array literals into runtime
    // helpers; those buffers are not padded with canaries.
    if (!_recent_array_contains((const void *)arr->data))
    {
        return;
    }
    // Arrays allocated by `_alloc_array` include a small header at data[-2..-1].
    const uintptr_t canary_value = (uintptr_t)0x5341494c46494e43ull;
    uintptr_t magic = (uintptr_t)arr->data[-2];
    if (magic != canary_value)
    {
        return;
    }
    size_t capacity = (size_t)(uintptr_t)arr->data[-1];
    if (capacity == 0 || capacity > 10000000u)
    {
        return;
    }
    const size_t canary_slots = 4u;
    for (size_t i = 0; i < canary_slots; i++)
    {
        uintptr_t expected = canary_value + i;
        uintptr_t got = (uintptr_t)arr->data[capacity + i];
        if (got != expected)
        {
            fprintf(
                stderr,
                "[stage2-native] array_canary CORRUPTED label=%s arr=%p data=%p len=%lld slot=%zu expected=0x%llx got=0x%llx\n",
                label ? label : "?",
                (void *)arr,
                (void *)arr->data,
                (long long)arr->len,
                capacity + i,
                (unsigned long long)expected,
                (unsigned long long)got);
            fflush(stderr);
            break;
        }
    }
}

SailfinPtrArray *sailfin_runtime_concat(SailfinPtrArray *a, SailfinPtrArray *b)
{
    if (_array_is_suspicious_ptr(a))
    {
        fprintf(
            stderr,
            "[stage2-native] array_concat suspicious a=%p (treating as NULL)\n",
            (void *)a);
        fflush(stderr);
        a = NULL;
    }
    if (_array_is_suspicious_ptr(b))
    {
        fprintf(
            stderr,
            "[stage2-native] array_concat suspicious b=%p (treating as NULL)\n",
            (void *)b);
        fflush(stderr);
        b = NULL;
    }
    _array_check_canary("concat.a", a);
    _array_check_canary("concat.b", b);

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

    static int trace_arrays_init = 0;
    static size_t trace_arrays_min_len = 0;
    static int trace_arrays_budget = 0;
    if (!trace_arrays_init)
    {
        trace_arrays_init = 1;
        trace_arrays_min_len = _env_sizet("SAILFIN_TRACE_ARRAY_CONCAT_MIN_LEN", 0);
        trace_arrays_budget = _env_int("SAILFIN_TRACE_ARRAY_CONCAT_BUDGET", 64);
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

    // If we are tracking a particular source_filename string, detect when
    // concat drops it from the head.
    const char *tracked = NULL;
    pthread_mutex_lock(&_sailfin_trace_header_lock);
    tracked = _sailfin_tracked_source_filename;
    pthread_mutex_unlock(&_sailfin_trace_header_lock);
    if (tracked)
    {
        char *a0 = (a && a->data && a->len > 0) ? a->data[0] : NULL;
        char *b0 = (b && b->data && b->len > 0) ? b->data[0] : NULL;
        char *o0 = (out && out->data && out->len > 0) ? out->data[0] : NULL;
        bool a_has = (a0 == tracked);
        bool b_has = (b0 == tracked);
        bool out_has = (o0 == tracked);

        // Budgeted breadcrumb so we can confirm whether the tracked header
        // array flows through concat operations at all.
        static int track_budget_init = 0;
        static int track_budget = 0;
        if (!track_budget_init)
        {
            track_budget_init = 1;
            track_budget = _env_int("SAILFIN_TRACE_ARRAY_TRACK_BUDGET", 0);
        }
        if (track_budget > 0 && (a_has || b_has))
        {
            track_budget--;
            fprintf(
                stderr,
                "[stage2-native] TRACK source_filename seen in concat: a=%p alen=%lld b=%p blen=%lld out=%p outlen=%lld out_has=%d\n",
                (void *)a,
                (long long)(a ? a->len : 0),
                (void *)b,
                (long long)(b ? b->len : 0),
                (void *)out,
                (long long)(out ? out->len : 0),
                out_has ? 1 : 0);
            fflush(stderr);
        }

        if ((a_has || b_has) && !out_has)
        {
            fprintf(
                stderr,
                "[stage2-native] TRACK source_filename DROPPED by concat: a=%p alen=%lld a0=%p b=%p blen=%lld b0=%p out=%p outlen=%lld out0=%p tracked=%p\n",
                (void *)a,
                (long long)(a ? a->len : 0),
                (void *)a0,
                (void *)b,
                (long long)(b ? b->len : 0),
                (void *)b0,
                (void *)out,
                (long long)(out ? out->len : 0),
                (void *)o0,
                (void *)tracked);
            fflush(stderr);
        }
    }

    if (trace_arrays_min_len > 0 && trace_arrays_budget > 0)
    {
        size_t total = (size_t)((alen >= 0 ? alen : 0) + (blen >= 0 ? blen : 0));
        if (total >= trace_arrays_min_len)
        {
            trace_arrays_budget--;

            if (a && a->len == 0 && a->data && a->data[0] != NULL)
            {
                fprintf(
                    stderr,
                    "[stage2-native] array_concat suspicious: a len==0 but a->data[0]=%p (possible len stomp) a=%p\n",
                    (void *)a->data[0],
                    (void *)a);
                fflush(stderr);
            }
            if (b && b->len == 0 && b->data && b->data[0] != NULL)
            {
                fprintf(
                    stderr,
                    "[stage2-native] array_concat suspicious: b len==0 but b->data[0]=%p (possible len stomp) b=%p\n",
                    (void *)b->data[0],
                    (void *)b);
                fflush(stderr);
            }

            char *first = NULL;
            if (out->len > 0 && out->data)
            {
                first = out->data[0];
            }
            uint32_t first_cp = 0;
            bool first_immediate = _is_immediate_codepoint_string(first, &first_cp);

            char preview_buf[40];
            preview_buf[0] = '\0';
            if (first)
            {
                if (first_immediate)
                {
                    unsigned char tmp[5] = {0};
                    size_t n = _utf8_encode(first_cp, tmp);
                    size_t take = n < (sizeof(preview_buf) - 1) ? n : (sizeof(preview_buf) - 1);
                    if (take > 0)
                    {
                        memcpy(preview_buf, tmp, take);
                    }
                    preview_buf[take] = '\0';
                }
                else
                {
                    bool preview_truncated = false;
                    size_t n = _safe_strlen_asan(first, &preview_truncated);
                    size_t take = n < 32 ? n : 32;
                    if (take > 0)
                    {
                        memcpy(preview_buf, first, take);
                    }
                    preview_buf[take] = '\0';
                }
            }
            fprintf(
                stderr,
                "[stage2-native] array_concat large alen=%lld blen=%lld total=%zu a=%p b=%p out=%p first=%p%s cp=%u preview=\"%s\"\n",
                (long long)alen,
                (long long)blen,
                total,
                (void *)a,
                (void *)b,
                (void *)out,
                (void *)first,
                first_immediate ? " immediate" : "",
                (unsigned)first_cp,
                preview_buf);
            fflush(stderr);

            // Optionally scan for key module header markers inside the array.
            static int trace_markers_init = 0;
            static int trace_markers_enabled = 0;
            static size_t trace_markers_limit = 0;
            if (!trace_markers_init)
            {
                trace_markers_init = 1;
                trace_markers_enabled = _env_enabled("SAILFIN_TRACE_ARRAY_MARKERS") ? 1 : 0;
                trace_markers_limit = _env_sizet("SAILFIN_TRACE_ARRAY_MARKERS_LIMIT", 64);
                if (trace_markers_limit == 0)
                {
                    trace_markers_limit = 64;
                }
            }
            if (trace_markers_enabled && out && out->data && out->len > 0)
            {
                long long source_idx = -1;
                long long proto_idx = -1;
                size_t limit = (size_t)out->len;
                if (limit > trace_markers_limit)
                {
                    limit = trace_markers_limit;
                }
                for (size_t idx = 0; idx < limit; idx++)
                {
                    char *s = out->data[idx];
                    uint32_t cp = 0;
                    if (!s)
                    {
                        continue;
                    }
                    if (_is_immediate_codepoint_string(s, &cp))
                    {
                        continue;
                    }
                    if (source_idx < 0 && strncmp(s, "source_filename", strlen("source_filename")) == 0)
                    {
                        source_idx = (long long)idx;
                    }
                    if (proto_idx < 0 && strncmp(s, "; Sailfin Native Prototype", strlen("; Sailfin Native Prototype")) == 0)
                    {
                        proto_idx = (long long)idx;
                    }
                    if (source_idx >= 0 && proto_idx >= 0)
                    {
                        break;
                    }
                }
                fprintf(
                    stderr,
                    "[stage2-native] array_markers out=%p len=%lld source_idx=%lld proto_idx=%lld\n",
                    (void *)out,
                    (long long)out->len,
                    source_idx,
                    proto_idx);
                fflush(stderr);
            }
        }
    }

    return out;
}

SailfinPtrArray *sailfin_runtime_append_string(SailfinPtrArray *a, char *text)
{
    if (_array_is_suspicious_ptr(a))
    {
        fprintf(
            stderr,
            "[stage2-native] append_string suspicious a=%p (treating as NULL)\n",
            (void *)a);
        fflush(stderr);
        _maybe_print_array_backtrace("append_string suspicious", a);
        a = NULL;
    }
    _array_check_canary("append.in", a);

    int64_t raw_alen = a ? a->len : 0;
    int64_t alen = raw_alen;
    if (alen < 0)
    {
        alen = 0;
    }

    // Historically, append allocated a fresh array and copied on every call,
    // which is catastrophically expensive for tight loops like split_lines.
    // Stage1 semantics (Python list.append) are in-place; match that here.
    SailfinPtrArray *out = a;
    if (!out)
    {
        out = _alloc_array(0);
        if (!out)
        {
            return NULL;
        }
    }

    out = sailfin_runtime_array_push(out, text);
    if (!out)
    {
        return NULL;
    }

    // High-signal hook: report if the LLVM module preamble line is ever
    // appended into a string array. This lets us distinguish "never added"
    // from "added then lost" failures.
    static int trace_append_source_init = 0;
    static int trace_append_source_enabled = 0;
    if (!trace_append_source_init)
    {
        trace_append_source_init = 1;
        trace_append_source_enabled = _env_enabled("SAILFIN_TRACE_ARRAY_APPEND_SOURCE") ? 1 : 0;
    }
    if (trace_append_source_enabled && text)
    {
        uint32_t tcp = 0;
        if (!_is_immediate_codepoint_string(text, &tcp))
        {
            const char *needle = "source_filename";
            if (strncmp(text, needle, strlen(needle)) == 0)
            {
                pthread_mutex_lock(&_sailfin_trace_header_lock);
                _sailfin_tracked_source_filename = text;
                pthread_mutex_unlock(&_sailfin_trace_header_lock);
                fprintf(
                    stderr,
                    "[stage2-native] array_append SAW source_filename out=%p len=%lld text=%p\n",
                    (void *)out,
                    (long long)out->len,
                    (void *)text);
                fflush(stderr);
            }
        }
    }

    // If we are tracking a particular source_filename string, detect when
    // append drops it from the head (often via a corrupted/incorrect len).
    const char *tracked = NULL;
    pthread_mutex_lock(&_sailfin_trace_header_lock);
    tracked = _sailfin_tracked_source_filename;
    pthread_mutex_unlock(&_sailfin_trace_header_lock);
    if (tracked)
    {
        char *a0 = (a && a->data && a->len > 0) ? a->data[0] : NULL;
        char *o0 = (out && out->data && out->len > 0) ? out->data[0] : NULL;

        static int track_budget_init = 0;
        static int track_budget = 0;
        if (!track_budget_init)
        {
            track_budget_init = 1;
            track_budget = _env_int("SAILFIN_TRACE_ARRAY_TRACK_BUDGET", 0);
        }
        if (track_budget > 0 && a0 == tracked)
        {
            track_budget--;
            fprintf(
                stderr,
                "[stage2-native] TRACK source_filename seen in append: a=%p raw_alen=%lld alen=%lld out=%p outlen=%lld out_has=%d\n",
                (void *)a,
                (long long)raw_alen,
                (long long)alen,
                (void *)out,
                (long long)(out ? out->len : 0),
                (o0 == tracked) ? 1 : 0);
            fflush(stderr);
        }
        if (a0 == tracked && o0 != tracked)
        {
            fprintf(
                stderr,
                "[stage2-native] TRACK source_filename DROPPED by append: a=%p raw_alen=%lld alen=%lld a0=%p out=%p outlen=%lld out0=%p tracked=%p\n",
                (void *)a,
                (long long)raw_alen,
                (long long)alen,
                (void *)a0,
                (void *)out,
                (long long)(out ? out->len : 0),
                (void *)o0,
                (void *)tracked);
            fflush(stderr);
        }

        if (a && raw_alen == 0 && a->data && a->data[0] == tracked)
        {
            fprintf(
                stderr,
                "[stage2-native] TRACK source_filename LEN_STOMP? append saw a->len==0 but a->data[0]==tracked a=%p data=%p tracked=%p\n",
                (void *)a,
                (void *)a->data,
                (void *)tracked);
            _trace_backtrace_budgeted("array_len_stomp");
            fflush(stderr);
        }
    }

    static int trace_append_init = 0;
    static size_t trace_append_min_len = 0;
    static int trace_append_budget = 0;
    static int trace_append_skip_proto = 0;
    if (!trace_append_init)
    {
        trace_append_init = 1;
        trace_append_min_len = _env_sizet("SAILFIN_TRACE_ARRAY_APPEND_MIN_LEN", 0);
        trace_append_budget = _env_int("SAILFIN_TRACE_ARRAY_APPEND_BUDGET", 64);
        trace_append_skip_proto = _env_enabled("SAILFIN_TRACE_ARRAY_APPEND_SKIP_PROTO") ? 1 : 0;
    }
    if (trace_append_min_len > 0 && trace_append_budget > 0)
    {
        size_t total = (size_t)(out && out->len >= 0 ? out->len : 0);
        if (total >= trace_append_min_len)
        {
            char *first = NULL;
            if (out->len > 0 && out->data)
            {
                first = out->data[0];
            }

            // Many compilation paths build large Sailfin-native text buffers
            // ("; Sailfin Native Prototype" preamble). Those are very noisy and
            // not relevant to missing LLVM module headers; optionally skip them.
            if (trace_append_skip_proto && first)
            {
                uint32_t fcp = 0;
                if (!_is_immediate_codepoint_string(first, &fcp))
                {
                    const char *proto = "; Sailfin Native Prototype";
                    if (strncmp(first, proto, strlen(proto)) == 0)
                    {
                        return out;
                    }
                }
            }

            trace_append_budget--;

            uint32_t first_cp = 0;
            bool first_immediate = _is_immediate_codepoint_string(first, &first_cp);
            uint32_t value_cp = 0;
            bool value_immediate = _is_immediate_codepoint_string(text, &value_cp);

            char first_preview[40];
            first_preview[0] = '\0';
            if (first)
            {
                if (first_immediate)
                {
                    unsigned char tmp[5] = {0};
                    size_t n = _utf8_encode(first_cp, tmp);
                    size_t take = n < 32 ? n : 32;
                    if (take > 0)
                    {
                        memcpy(first_preview, tmp, take);
                    }
                    first_preview[take] = '\0';
                }
                else
                {
                    bool truncated = false;
                    size_t n = _safe_strlen_asan(first, &truncated);
                    size_t take = n < 32 ? n : 32;
                    if (take > 0)
                    {
                        memcpy(first_preview, first, take);
                    }
                    first_preview[take] = '\0';
                }
            }

            char value_preview[40];
            value_preview[0] = '\0';
            if (text)
            {
                if (value_immediate)
                {
                    unsigned char tmp[5] = {0};
                    size_t n = _utf8_encode(value_cp, tmp);
                    size_t take = n < 32 ? n : 32;
                    if (take > 0)
                    {
                        memcpy(value_preview, tmp, take);
                    }
                    value_preview[take] = '\0';
                }
                else
                {
                    bool truncated = false;
                    size_t n = _safe_strlen_asan(text, &truncated);
                    size_t take = n < 32 ? n : 32;
                    if (take > 0)
                    {
                        memcpy(value_preview, text, take);
                    }
                    value_preview[take] = '\0';
                }
            }

            uint32_t cp = 0;
            bool imm = _is_immediate_codepoint_string(text, &cp);
            fprintf(
                stderr,
                "[stage2-native] array_append len=%lld total=%zu a=%p out=%p first=%p%s cp=%u first_preview=\"%s\" value=%p%s cp=%u value_preview=\"%s\"\n",
                (long long)alen,
                total,
                (void *)a,
                (void *)out,
                (void *)first,
                first_immediate ? " immediate" : "",
                (unsigned)first_cp,
                first_preview,
                (void *)text,
                imm ? " immediate" : "",
                (unsigned)cp,
                value_preview);
            fflush(stderr);

            static int trace_markers_init = 0;
            static int trace_markers_enabled = 0;
            static size_t trace_markers_limit = 0;
            if (!trace_markers_init)
            {
                trace_markers_init = 1;
                trace_markers_enabled = _env_enabled("SAILFIN_TRACE_ARRAY_MARKERS") ? 1 : 0;
                trace_markers_limit = _env_sizet("SAILFIN_TRACE_ARRAY_MARKERS_LIMIT", 64);
                if (trace_markers_limit == 0)
                {
                    trace_markers_limit = 64;
                }
            }
            if (trace_markers_enabled && out && out->data && out->len > 0)
            {
                long long source_idx = -1;
                long long proto_idx = -1;
                size_t limit = (size_t)out->len;
                if (limit > trace_markers_limit)
                {
                    limit = trace_markers_limit;
                }
                for (size_t idx = 0; idx < limit; idx++)
                {
                    char *s = out->data[idx];
                    uint32_t scp = 0;
                    if (!s)
                    {
                        continue;
                    }
                    if (_is_immediate_codepoint_string(s, &scp))
                    {
                        continue;
                    }
                    if (source_idx < 0 && strncmp(s, "source_filename", strlen("source_filename")) == 0)
                    {
                        source_idx = (long long)idx;
                    }
                    if (proto_idx < 0 && strncmp(s, "; Sailfin Native Prototype", strlen("; Sailfin Native Prototype")) == 0)
                    {
                        proto_idx = (long long)idx;
                    }
                    if (source_idx >= 0 && proto_idx >= 0)
                    {
                        break;
                    }
                }
                fprintf(
                    stderr,
                    "[stage2-native] array_append_markers out=%p len=%lld source_idx=%lld proto_idx=%lld\n",
                    (void *)out,
                    (long long)out->len,
                    source_idx,
                    proto_idx);
                fflush(stderr);
            }
        }
    }
    return out;
}

SailfinPtrArray *sailfin_runtime_array_push(SailfinPtrArray *array, char *value)
{
    _array_check_canary("push.in", array);

    if (!array)
    {
        return NULL;
    }

    int64_t len = array->len;
    if (len < 0)
    {
        len = 0;
        array->len = 0;
    }

    // Ensure we have a heap backing buffer with capacity metadata.
    size_t capacity = 0;
    const uintptr_t header_magic = (uintptr_t)0x5341494c46494e43ull;
    bool has_header = false;
    if (array->data && _recent_array_contains((const void *)array->data))
    {
        if ((uintptr_t)array->data[-2] == header_magic)
        {
            capacity = (size_t)(uintptr_t)array->data[-1];
            if (capacity > 0 && capacity <= 10000000u)
            {
                has_header = true;
            }
        }
    }

    if (!array->data || !has_header)
    {
        // Convert unknown/stack buffers to a managed heap allocation.
        SailfinPtrArray *fresh = _alloc_array(len);
        if (!fresh)
        {
            return NULL;
        }
        for (int64_t i = 0; i < len; i++)
        {
            fresh->data[i] = (array && array->data) ? array->data[i] : NULL;
        }
        array->data = fresh->data;
        array->len = fresh->len;
        // Leak the temporary struct; stage2-native does not reliably free arrays.
        free(fresh);

        capacity = (size_t)(uintptr_t)array->data[-1];
        has_header = true;
    }

    if ((size_t)len >= capacity)
    {
        // Grow backing store in-place.
        size_t new_capacity = capacity;
        if (new_capacity < 8u)
        {
            new_capacity = 8u;
        }

        // For small arrays, doubling is fine; for large arrays, grow by ~25%
        // to avoid runaway memory amplification.
        if (new_capacity <= 1024u)
        {
            new_capacity *= 2u;
        }
        else
        {
            new_capacity += (new_capacity / 4u);
        }

        if (new_capacity < (size_t)len + 2u)
        {
            new_capacity = (size_t)len + 2u;
        }
        if (new_capacity > 10000000u)
        {
            new_capacity = 10000000u;
        }

        const size_t header_slots = 2u;
        const size_t canary_slots = 4u;
        char **raw = array->data - header_slots;
        char **grown = (char **)realloc(raw, (header_slots + new_capacity + canary_slots) * sizeof(char *));
        if (!grown)
        {
            return NULL;
        }

        // Zero out newly-added capacity slots.
        if (new_capacity > capacity)
        {
            memset(
                grown + header_slots + capacity,
                0,
                (new_capacity - capacity) * sizeof(char *));
        }

        grown[0] = (char *)header_magic;
        grown[1] = (char *)(uintptr_t)new_capacity;
        array->data = grown + header_slots;
        capacity = new_capacity;

        for (size_t i = 0; i < canary_slots; i++)
        {
            array->data[capacity + i] = (char *)(header_magic + i);
        }

        _recent_array_record((const void *)array->data);

        static int trace_grow_init = 0;
        static size_t trace_grow_min_cap = 0;
        static int trace_grow_budget = 0;
        if (!trace_grow_init)
        {
            trace_grow_init = 1;
            trace_grow_min_cap = _env_sizet("SAILFIN_TRACE_LARGE_ARRAY_GROW_MIN_CAP", 0);
            trace_grow_budget = _env_int("SAILFIN_TRACE_LARGE_ARRAY_GROW_BUDGET", 16);
        }
        if (trace_grow_min_cap > 0 && trace_grow_budget > 0 && new_capacity >= trace_grow_min_cap)
        {
            trace_grow_budget--;
            fprintf(
                stderr,
                "[stage2-native] large_array_grow old_cap=%zu new_cap=%zu len=%lld arr=%p data=%p\n",
                (size_t)(uintptr_t)array->data[-1],
                new_capacity,
                (long long)array->len,
                (void *)array,
                (void *)array->data);
            fflush(stderr);
            _trace_backtrace_budgeted("large_array_grow");
        }
    }

    static int trace_push_init = 0;
    static size_t trace_push_min_len = 0;
    static int trace_push_budget = 0;
    if (!trace_push_init)
    {
        trace_push_init = 1;
        trace_push_min_len = _env_sizet("SAILFIN_TRACE_ARRAY_PUSH_MIN_LEN", 0);
        trace_push_budget = _env_int("SAILFIN_TRACE_ARRAY_PUSH_BUDGET", 64);
    }

    array->data[len] = value;
    array->len = len + 1;

    if (array->len == 0 && array->data && array->data[0] != NULL)
    {
        fprintf(
            stderr,
            "[stage2-native] array_push suspicious: in len==0 but in->data[0]=%p (possible len stomp) in=%p\n",
            (void *)array->data[0],
            (void *)array);
        fflush(stderr);
    }

    if (trace_push_min_len > 0 && (size_t)(len + 1) >= trace_push_min_len && trace_push_budget > 0)
    {
        trace_push_budget--;
        char *first = NULL;
        if (array->len > 0 && array->data)
        {
            first = array->data[0];
        }

        uint32_t first_cp = 0;
        bool first_immediate = _is_immediate_codepoint_string(first, &first_cp);
        uint32_t value_cp = 0;
        bool value_immediate = _is_immediate_codepoint_string(value, &value_cp);

        char first_preview[40];
        first_preview[0] = '\0';
        if (first)
        {
            if (first_immediate)
            {
                unsigned char tmp[5] = {0};
                size_t n = _utf8_encode(first_cp, tmp);
                size_t take = n < 32 ? n : 32;
                if (take > 0)
                {
                    memcpy(first_preview, tmp, take);
                }
                first_preview[take] = '\0';
            }
            else
            {
                bool truncated = false;
                size_t n = _safe_strlen_asan(first, &truncated);
                size_t take = n < 32 ? n : 32;
                if (take > 0)
                {
                    memcpy(first_preview, first, take);
                }
                first_preview[take] = '\0';
            }
        }

        char value_preview[40];
        value_preview[0] = '\0';
        if (value)
        {
            if (value_immediate)
            {
                unsigned char tmp[5] = {0};
                size_t n = _utf8_encode(value_cp, tmp);
                size_t take = n < 32 ? n : 32;
                if (take > 0)
                {
                    memcpy(value_preview, tmp, take);
                }
                value_preview[take] = '\0';
            }
            else
            {
                bool truncated = false;
                size_t n = _safe_strlen_asan(value, &truncated);
                size_t take = n < 32 ? n : 32;
                if (take > 0)
                {
                    memcpy(value_preview, value, take);
                }
                value_preview[take] = '\0';
            }
        }

        fprintf(
            stderr,
            "[stage2-native] array_push len=%lld out=%p first=%p%s cp=%u first_preview=\"%s\" value=%p%s cp=%u value_preview=\"%s\"\n",
            (long long)len,
            (void *)array,
            (void *)first,
            first_immediate ? " immediate" : "",
            (unsigned)first_cp,
            first_preview,
            (void *)value,
            value_immediate ? " immediate" : "",
            (unsigned)value_cp,
            value_preview);
        fflush(stderr);

        static int trace_markers_init = 0;
        static int trace_markers_enabled = 0;
        static size_t trace_markers_limit = 0;
        if (!trace_markers_init)
        {
            trace_markers_init = 1;
            trace_markers_enabled = _env_enabled("SAILFIN_TRACE_ARRAY_MARKERS") ? 1 : 0;
            trace_markers_limit = _env_sizet("SAILFIN_TRACE_ARRAY_MARKERS_LIMIT", 64);
            if (trace_markers_limit == 0)
            {
                trace_markers_limit = 64;
            }
        }
        if (trace_markers_enabled && array && array->data && array->len > 0)
        {
            long long source_idx = -1;
            long long proto_idx = -1;
            size_t limit = (size_t)array->len;
            if (limit > trace_markers_limit)
            {
                limit = trace_markers_limit;
            }
            for (size_t idx = 0; idx < limit; idx++)
            {
                char *s = array->data[idx];
                uint32_t cp = 0;
                if (!s)
                {
                    continue;
                }
                if (_is_immediate_codepoint_string(s, &cp))
                {
                    continue;
                }
                if (source_idx < 0 && strncmp(s, "source_filename", strlen("source_filename")) == 0)
                {
                    source_idx = (long long)idx;
                }
                if (proto_idx < 0 && strncmp(s, "; Sailfin Native Prototype", strlen("; Sailfin Native Prototype")) == 0)
                {
                    proto_idx = (long long)idx;
                }
                if (source_idx >= 0 && proto_idx >= 0)
                {
                    break;
                }
            }
            fprintf(
                stderr,
                "[stage2-native] array_markers out=%p len=%lld source_idx=%lld proto_idx=%lld\n",
                (void *)array,
                (long long)array->len,
                source_idx,
                proto_idx);
            fflush(stderr);
        }
    }

    return array;
}

char *sailfin_runtime_array_push_slot(char **data_ptr_ptr, int64_t *len_ptr, int64_t elem_size)
{
    if (!data_ptr_ptr || !len_ptr)
    {
        return NULL;
    }
    if (elem_size <= 0 || elem_size > (int64_t)(1024 * 1024))
    {
        return NULL;
    }

    int64_t len = *len_ptr;
    if (len < 0)
    {
        len = 0;
        *len_ptr = 0;
    }
    static int array_push_limit_init = 0;
    static int64_t array_push_limit = 0;
    if (!array_push_limit_init)
    {
        array_push_limit_init = 1;
        int limit = _env_int("SAILFIN_MAX_ARRAY_LEN", 5000000);
        if (limit < 0)
        {
            limit = 0;
        }
        array_push_limit = (int64_t)limit;
    }
    if (array_push_limit > 0 && len > array_push_limit)
    {
        fprintf(
            stderr,
            "[stage2-native] array_push len exceeded (len=%lld limit=%lld)\n",
            (long long)len,
            (long long)array_push_limit);
        fflush(stderr);
        sailfin_runtime_raise_value_error("array push limit exceeded");
    }

    const uint64_t header_magic = 0x5341494c46494e43ull;
    const size_t header_words = 4u; // magic, capacity, elem_size, reserved
    const size_t header_bytes = header_words * sizeof(uint64_t);
    const size_t canary_bytes = 32u;

    uint8_t *data = (uint8_t *)(*data_ptr_ptr);
    if (data && (uintptr_t)data < 4096u)
    {
        fprintf(
            stderr,
            "[stage2-native] array_push suspicious data=%p (resetting array)\n",
            (void *)data);
        fflush(stderr);
        data = NULL;
        *data_ptr_ptr = NULL;
        *len_ptr = 0;
        len = 0;
    }
    size_t capacity = 0;
    bool has_header = false;

    if (data && _recent_array_contains((const void *)data))
    {
        uint64_t *hdr = (uint64_t *)(data - header_bytes);
        if (hdr[0] == header_magic)
        {
            size_t cap = (size_t)hdr[1];
            size_t esz = (size_t)hdr[2];
            if (cap > 0 && cap <= 10000000u && esz == (size_t)elem_size)
            {
                capacity = cap;
                has_header = true;
            }
        }
    }

    if (!data || !has_header)
    {
        size_t want = (size_t)len + 1u;
        size_t new_capacity = want;
        if (new_capacity < 8u)
        {
            new_capacity = 8u;
        }
        if (new_capacity <= 1024u)
        {
            // round up to power of two
            size_t p = 1u;
            while (p < new_capacity)
            {
                p <<= 1u;
            }
            new_capacity = p;
        }
        else
        {
            new_capacity += (new_capacity / 4u);
        }
        if (new_capacity < want)
        {
            new_capacity = want;
        }
        if (new_capacity > 10000000u)
        {
            new_capacity = 10000000u;
        }

        size_t payload = new_capacity * (size_t)elem_size;
        uint8_t *raw = (uint8_t *)calloc(1, header_bytes + payload + canary_bytes);
        if (!raw)
        {
            return NULL;
        }
        uint64_t *hdr = (uint64_t *)raw;
        hdr[0] = header_magic;
        hdr[1] = (uint64_t)new_capacity;
        hdr[2] = (uint64_t)elem_size;
        hdr[3] = 0;

        uint8_t *new_data = raw + header_bytes;
        if (data && len > 0)
        {
            memcpy(new_data, data, (size_t)len * (size_t)elem_size);
        }
        for (size_t i = 0; i < canary_bytes; i++)
        {
            new_data[payload + i] = (uint8_t)(0xC3u ^ (uint8_t)i);
        }

        data = new_data;
        capacity = new_capacity;
        has_header = true;
        *data_ptr_ptr = (char *)data;
        _recent_array_record((const void *)data);
    }

    if ((size_t)len >= capacity)
    {
        size_t new_capacity = capacity;
        if (new_capacity < 8u)
        {
            new_capacity = 8u;
        }
        if (new_capacity <= 1024u)
        {
            new_capacity *= 2u;
        }
        else
        {
            new_capacity += (new_capacity / 4u);
        }
        size_t want = (size_t)len + 1u;
        if (new_capacity < want)
        {
            new_capacity = want;
        }
        if (new_capacity > 10000000u)
        {
            new_capacity = 10000000u;
        }

        size_t old_payload = capacity * (size_t)elem_size;
        size_t new_payload = new_capacity * (size_t)elem_size;
        uint8_t *raw = data - header_bytes;
        uint8_t *grown = (uint8_t *)realloc(raw, header_bytes + new_payload + canary_bytes);
        if (!grown)
        {
            return NULL;
        }
        uint64_t *hdr = (uint64_t *)grown;
        hdr[0] = header_magic;
        hdr[1] = (uint64_t)new_capacity;
        hdr[2] = (uint64_t)elem_size;
        uint8_t *new_data = grown + header_bytes;
        if (new_payload > old_payload)
        {
            memset(new_data + old_payload, 0, new_payload - old_payload);
        }
        for (size_t i = 0; i < canary_bytes; i++)
        {
            new_data[new_payload + i] = (uint8_t)(0xC3u ^ (uint8_t)i);
        }

        data = new_data;
        capacity = new_capacity;
        *data_ptr_ptr = (char *)data;
        _recent_array_record((const void *)data);
    }

    uint8_t *slot = data + ((size_t)len * (size_t)elem_size);
    *len_ptr = len + 1;
    return (char *)slot;
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

// Find the index of the first occurrence of a byte in a string starting from a given index.
// Uses memchr for O(n) performance without per-character strlen overhead.
// Returns -1 if not found.
double sailfin_runtime_find_byte_index(char *text, double byte_value, double start_index)
{
    if (!text)
    {
        return -1.0;
    }
    int64_t start = (int64_t)start_index;
    if (start < 0)
    {
        start = 0;
    }
    // Get string length once
    bool truncated = false;
    int64_t len = (int64_t)_safe_strlen_asan(text, &truncated);
    if (start >= len)
    {
        return -1.0;
    }
    unsigned char target = (unsigned char)(int64_t)byte_value;
    char *found = (char *)memchr(text + start, target, (size_t)(len - start));
    if (!found)
    {
        return -1.0;
    }
    return (double)(found - text);
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
    if (_is_corrupted_string_ptr(text))
    {
        return "";
    }
    static int trace_enabled = -1;
    if (trace_enabled < 0)
    {
        const char *trace = getenv("SAILFIN_TRACE_GRAPHEME_AT");
        trace_enabled = (trace && trace[0] != '\0' && trace[0] != '0') ? 1 : 0;
    }
    if (trace_enabled)
    {
        static int trace_budget = 64;
        if (trace_budget > 0)
        {
            trace_budget--;
            uintptr_t raw = (uintptr_t)text;
            unsigned char b0 = 0;
            unsigned char b1 = 0;
            bool has_bytes = false;
            if (text && raw >= 4096u)
            {
                b0 = (unsigned char)text[0];
                b1 = (unsigned char)text[1];
                has_bytes = true;
            }
            if (has_bytes)
            {
                fprintf(stderr, "[stage2-native] grapheme_at(%p, %.2f) first_bytes=%02x%02x\n", (void *)text, index, b0, b1);
            }
            else
            {
                fprintf(stderr, "[stage2-native] grapheme_at(%p, %.2f)\n", (void *)text, index);
            }
            fflush(stderr);
        }
    }
    if (!text)
    {
        return "";
    }

    // Immediate-codepoint pseudo-strings are tagged pointers and must never be
    // dereferenced. Treat them as a single grapheme at index 0.
    uint32_t immediate_codepoint = 0;
    if (_is_immediate_codepoint_string(text, &immediate_codepoint))
    {
        int64_t idx = (int64_t)index;
        if ((double)idx != index)
        {
            return "";
        }
        if (idx == 0)
        {
            return text;
        }
        return "";
    }

    int64_t idx = (int64_t)index;
    if ((double)idx != index)
    {
        // Non-integer indexes aren't meaningful here.
        return "";
    }

    if (idx < 0)
    {
        return "";
    }

    int64_t len = sailfin_runtime_string_length(text);
    if (len <= 0)
    {
        return "";
    }
    if (idx >= len)
    {
        return "";
    }

    // Keep the same pointer plausibility guards as `_safe_strlen_asan`.
    // The stage2 compiler occasionally carries mis-tagged values that can be
    // interpreted as `char*`; avoid crashing on the first dereference.
    if ((uintptr_t)text < 4096u)
    {
        return "";
    }
    {
        uintptr_t addr = (uintptr_t)text;
        uintptr_t high = addr >> 48;
        if (high != 0u && high != 0xffffu)
        {
            return "";
        }
    }

    unsigned char byte = (unsigned char)text[idx];

    // Bootstrap implementation: treat each UTF-8 byte as a grapheme.
    // To avoid allocating on hot paths (compiler parsing), return an
    // immediate-codepoint pseudo-string for ASCII bytes.
    //
    // NOTE: For bytes >= 0x80 we preserve legacy behaviour (a raw single-byte
    // C string) because immediate-codepoint strings are interpreted as Unicode
    // codepoints by other runtime helpers.
    if (byte <= 0x7fu)
    {
        uintptr_t packed = ((uintptr_t)byte) << 32;
        return (char *)packed;
    }

    char *out = (char *)malloc(2);
    if (!out)
    {
        return NULL;
    }
    out[0] = (char)byte;
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

#if defined(_WIN32)
    /* Build a single command-line string for CreateProcess. */
    size_t total = 0;
    for (int64_t i = 0; i < len; i++)
    {
        if (argv->data[i])
            total += strlen(argv->data[i]) + 3; /* quotes + space */
    }
    char *cmdline = (char *)malloc(total + 1);
    if (!cmdline)
        return 127.0;
    cmdline[0] = '\0';
    for (int64_t i = 0; i < len; i++)
    {
        if (i > 0)
            strcat(cmdline, " ");
        strcat(cmdline, "\"");
        if (argv->data[i])
            strcat(cmdline, argv->data[i]);
        strcat(cmdline, "\"");
    }

    STARTUPINFOA si;
    PROCESS_INFORMATION pi;
    memset(&si, 0, sizeof(si));
    si.cb = sizeof(si);
    memset(&pi, 0, sizeof(pi));

    if (!CreateProcessA(NULL, cmdline, NULL, NULL, FALSE, 0, NULL, NULL, &si, &pi))
    {
        free(cmdline);
        return 127.0;
    }
    free(cmdline);

    WaitForSingleObject(pi.hProcess, INFINITE);
    DWORD exit_code = 0;
    GetExitCodeProcess(pi.hProcess, &exit_code);
    CloseHandle(pi.hProcess);
    CloseHandle(pi.hThread);
    return (double)exit_code;
#else
    /* POSIX: use posix_spawnp. */
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
#endif
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
    if (!text)
    {
        return -1.0;
    }

    uint32_t codepoint = 0;
    if (_is_immediate_codepoint_string(text, &codepoint))
    {
        return (double)codepoint;
    }

    unsigned char first = (unsigned char)text[0];
    if (first == 0)
    {
        return -1.0;
    }

    // Stage2 currently uses a legacy UTF-8 C-string ABI; most compiler logic
    // assumes ASCII punctuation/operators. Match Python's `ord(text[0])` for
    // the first byte.
    return (double)first;
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

    static int trace_write_init = 0;
    static int trace_write_enabled = 0;
    if (!trace_write_init)
    {
        trace_write_init = 1;
        const char *v = getenv("SAILFIN_TRACE_FS_WRITE_FILE");
        trace_write_enabled = (v && v[0] && v[0] != '0') ? 1 : 0;
    }

    FILE *f = fopen(path_str, "wb");
    if (!f)
    {
        _print_line(stderr, "[native] fs.writeFile failed", path_str);
        return;
    }

    uint32_t codepoint = 0;
    bool immediate = _is_immediate_codepoint_string(contents_str, &codepoint);

    // Enhanced debugging for zero-length writes
    if (trace_write_enabled)
    {
        uintptr_t addr = (uintptr_t)contents_str;
        fprintf(stderr, "[native] fs.writeFile PRE-LENGTH contents=%p immediate=%d cp=%u addr_low32=0x%x addr_high32=0x%x\n",
                (void *)contents_str, immediate ? 1 : 0, (unsigned)codepoint,
                (unsigned)(addr & 0xffffffffu), (unsigned)(addr >> 32));
        fflush(stderr);

        // Check for premature null termination around 65535
        if (!immediate && contents_str)
        {
            size_t check_start = 65530;
            size_t check_end = 65545;
            fprintf(stderr, "[native] fs.writeFile checking bytes %zu-%zu\n", check_start, check_end);
            for (size_t i = check_start; i < check_end; i++)
            {
                unsigned char byte = (unsigned char)contents_str[i];
                if (byte == 0)
                {
                    fprintf(stderr, "[native] fs.writeFile found NULL at offset %zu\n", i);
                    break;
                }
            }
            fflush(stderr);
        }
    }
    if (trace_write_enabled)
    {
        char preview_buf[40];
        preview_buf[0] = '\0';
        int64_t len64 = -1;

        if (immediate)
        {
            unsigned char tmp[5] = {0};
            size_t n = _utf8_encode(codepoint, tmp);
            size_t take = n < 32 ? n : 32;
            if (take > 0)
            {
                memcpy(preview_buf, tmp, take);
            }
            preview_buf[take] = '\0';
            len64 = (int64_t)n;
        }
        else
        {
            len64 = sailfin_runtime_string_length((char *)contents_str);
            bool truncated = false;
            size_t n = _safe_strlen_asan(contents_str, &truncated);
            size_t take = n < 32 ? n : 32;
            if (take > 0)
            {
                memcpy(preview_buf, contents_str, take);
            }
            preview_buf[take] = '\0';
        }

        long long source_filename_at = -1;
        long long prototype_at = -1;
        const char *range_base = NULL;
        size_t range_len = 0;
        size_t range_offset = 0;
        bool in_recent_range = false;
        if (!immediate && len64 > 0)
        {
            const char *hay = contents_str;
            size_t hay_len = (size_t)len64;

            const char *needle1 = "source_filename";
            size_t n1 = strlen(needle1);
            const char *needle2 = "; Sailfin Native Prototype";
            size_t n2 = strlen(needle2);

            size_t limit = hay_len;
            if (limit > (size_t)(2 * 1024 * 1024))
            {
                limit = (size_t)(2 * 1024 * 1024);
            }

            for (size_t i = 0; i + n1 <= limit; i++)
            {
                if (hay[i] == needle1[0] && memcmp(hay + i, needle1, n1) == 0)
                {
                    source_filename_at = (long long)i;
                    break;
                }
            }
            for (size_t i = 0; i + n2 <= limit; i++)
            {
                if (hay[i] == needle2[0] && memcmp(hay + i, needle2, n2) == 0)
                {
                    prototype_at = (long long)i;
                    break;
                }
            }

            in_recent_range = _recent_string_find_range(contents_str, &range_base, &range_len, &range_offset);
        }

        fprintf(
            stderr,
            "[native] fs.writeFile path=%s contents=%p%s cp=%u len=%lld preview=\"%s\" marker_source_filename=%lld marker_prototype=%lld range_base=%p range_len=%zu range_offset=%zu\n",
            path_str,
            (void *)contents_str,
            immediate ? " immediate" : "",
            (unsigned)codepoint,
            (long long)len64,
            preview_buf,
            source_filename_at,
            prototype_at,
            in_recent_range ? (void *)range_base : NULL,
            in_recent_range ? range_len : 0u,
            in_recent_range ? range_offset : 0u);
        fflush(stderr);
    }

    if (immediate)
    {
        unsigned char buf[5] = {0};
        size_t len = _utf8_encode(codepoint, buf);
        if (len > 0)
        {
            (void)fwrite(buf, 1, len, f);
        }
    }
    else
    {
        int64_t len64 = sailfin_runtime_string_length((char *)contents_str);
        if (len64 > 0)
        {
            (void)fwrite(contents_str, 1, (size_t)len64, f);
        }
    }
    fclose(f);
}

void sailfin_adapter_fs_append_file(void *path, void *contents)
{
    const char *path_str = (const char *)path;
    const char *contents_str = (const char *)contents;
    if (!path_str || !contents_str)
    {
        return;
    }

    FILE *f = fopen(path_str, "ab");
    if (!f)
    {
        _print_line(stderr, "[native] fs.appendFile failed", path_str);
        return;
    }

    uint32_t codepoint = 0;
    bool immediate = _is_immediate_codepoint_string(contents_str, &codepoint);
    if (immediate)
    {
        unsigned char buf[5] = {0};
        size_t len = _utf8_encode(codepoint, buf);
        if (len > 0)
        {
            (void)fwrite(buf, 1, len, f);
        }
    }
    else
    {
        int64_t len64 = sailfin_runtime_string_length((char *)contents_str);
        if (len64 > 0)
        {
            (void)fwrite(contents_str, 1, (size_t)len64, f);
        }
    }

    fclose(f);
}

void sailfin_adapter_fs_write_lines(void *path, SailfinPtrArray *lines)
{
    const char *path_str = (const char *)path;
    if (!path_str || !lines)
    {
        return;
    }

    FILE *f = fopen(path_str, "wb");
    if (!f)
    {
        _print_line(stderr, "[native] fs.writeLines failed", path_str);
        return;
    }

    int64_t n = lines->len;
    if (n < 0)
    {
        n = 0;
    }

    // Safety guard: if the array ABI is corrupted (e.g. wrong pointer passed),
    // `len` can become a huge positive value and we will effectively hang
    // writing for a very long time.
    if (n > (int64_t)10000000)
    {
        fprintf(stderr, "[native] fs.writeLines refusing to write absurd line count=%lld (possible ABI corruption)\n", (long long)n);
        fclose(f);
        return;
    }

    if (!lines->data && n > 0)
    {
        fprintf(stderr, "[native] fs.writeLines missing data pointer (len=%lld)\n", (long long)n);
        fclose(f);
        return;
    }

    for (int64_t i = 0; i < n; i++)
    {
        const char *line = NULL;
        if (lines->data)
        {
            line = (const char *)lines->data[i];
        }
        if (!line)
        {
            // Treat missing entries as empty lines.
            (void)fwrite("\n", 1, 1, f);
            continue;
        }

        uint32_t codepoint = 0;
        bool immediate = _is_immediate_codepoint_string(line, &codepoint);
        if (immediate)
        {
            unsigned char buf[5] = {0};
            size_t len = _utf8_encode(codepoint, buf);
            if (len > 0)
            {
                (void)fwrite(buf, 1, len, f);
            }
        }
        else
        {
            int64_t len64 = sailfin_runtime_string_length((char *)line);
            if (len64 > 0)
            {
                (void)fwrite(line, 1, (size_t)len64, f);
            }
        }

        (void)fwrite("\n", 1, 1, f);
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
        if (sfn_mkdir(path_str, 0777) == 0)
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
                if (sfn_mkdir(scratch, 0777) != 0 && errno != EEXIST)
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

/* ---- Package-manager HTTP helpers (curl subprocess) ---- */

static char *_popen_read_all(const char *cmd)
{
    FILE *fp = popen(cmd, "r");
    if (!fp)
        return NULL;

    size_t cap = 4096;
    size_t len = 0;
    char *buf = (char *)malloc(cap);
    if (!buf)
    {
        pclose(fp);
        return NULL;
    }

    size_t n;
    while ((n = fread(buf + len, 1, cap - len - 1, fp)) > 0)
    {
        len += n;
        if (len + 1 >= cap)
        {
            cap *= 2;
            char *tmp = (char *)realloc(buf, cap);
            if (!tmp)
            {
                free(buf);
                pclose(fp);
                return NULL;
            }
            buf = tmp;
        }
    }

    int status = pclose(fp);
    if (status != 0)
    {
        free(buf);
        return NULL;
    }

    buf[len] = '\0';
    return buf;
}

/* Shell-escape a string for safe embedding in a single-quoted context.
 * Caller must free the result. */
static char *_shell_escape(const char *s)
{
    if (!s)
        return NULL;
    size_t len = strlen(s);
    /* Worst case: every char is a single quote → replace with '\'' (4 chars) */
    char *out = (char *)malloc(len * 4 + 3); /* + quotes + NUL */
    if (!out)
        return NULL;
    size_t j = 0;
    out[j++] = '\'';
    for (size_t i = 0; i < len; i++)
    {
        if (s[i] == '\'')
        {
            out[j++] = '\'';
            out[j++] = '\\';
            out[j++] = '\'';
            out[j++] = '\'';
        }
        else
        {
            out[j++] = s[i];
        }
    }
    out[j++] = '\'';
    out[j] = '\0';
    return out;
}

char *sailfin_runtime_http_get(const char *url)
{
    if (!url)
        return NULL;
    char *esc_url = _shell_escape(url);
    if (!esc_url)
        return NULL;

    /* curl -sfS: silent, fail on HTTP errors, show errors on stderr */
    size_t cmd_len = strlen(esc_url) + 64;
    char *cmd = (char *)malloc(cmd_len);
    if (!cmd)
    {
        free(esc_url);
        return NULL;
    }
    snprintf(cmd, cmd_len, "curl -sfS %s", esc_url);
    free(esc_url);

    char *result = _popen_read_all(cmd);
    free(cmd);
    return result;
}

char *sailfin_runtime_http_post_json(const char *url, const char *json_body,
                                     const char *auth_header)
{
    if (!url || !json_body)
        return NULL;

    /* Write JSON body to a temp file to avoid shell-escaping issues */
    char tmppath[] = "/tmp/sfn_publish_XXXXXX";
    int fd = mkstemp(tmppath);
    if (fd < 0)
        return NULL;

    size_t body_len = strlen(json_body);
    ssize_t written = write(fd, json_body, body_len);
    close(fd);
    if (written < 0 || (size_t)written != body_len)
    {
        unlink(tmppath);
        return NULL;
    }

    char *esc_url = _shell_escape(url);
    if (!esc_url)
    {
        unlink(tmppath);
        return NULL;
    }

    size_t cmd_len = strlen(esc_url) + strlen(tmppath) + 256;
    if (auth_header)
        cmd_len += strlen(auth_header) + 32;

    char *cmd = (char *)malloc(cmd_len);
    if (!cmd)
    {
        free(esc_url);
        unlink(tmppath);
        return NULL;
    }

    if (auth_header && auth_header[0])
    {
        char *esc_auth = _shell_escape(auth_header);
        if (!esc_auth)
        {
            free(cmd);
            free(esc_url);
            unlink(tmppath);
            return NULL;
        }
        snprintf(cmd, cmd_len,
                 "curl -sfS -X POST -H 'Content-Type: application/json' "
                 "-H 'Authorization: '%s -d @%s %s",
                 esc_auth, tmppath, esc_url);
        free(esc_auth);
    }
    else
    {
        snprintf(cmd, cmd_len,
                 "curl -sfS -X POST -H 'Content-Type: application/json' "
                 "-d @%s %s",
                 tmppath, esc_url);
    }
    free(esc_url);

    char *result = _popen_read_all(cmd);
    free(cmd);
    unlink(tmppath);
    return result;
}

char *sailfin_runtime_http_download(const char *url, const char *output_path)
{
    if (!url || !output_path)
        return NULL;

    char *esc_url = _shell_escape(url);
    char *esc_path = _shell_escape(output_path);
    if (!esc_url || !esc_path)
    {
        free(esc_url);
        free(esc_path);
        return NULL;
    }

    size_t cmd_len = strlen(esc_url) + strlen(esc_path) + 64;
    char *cmd = (char *)malloc(cmd_len);
    if (!cmd)
    {
        free(esc_url);
        free(esc_path);
        return NULL;
    }
    snprintf(cmd, cmd_len, "curl -sfS -o %s %s", esc_path, esc_url);
    free(esc_url);
    free(esc_path);

    int status = system(cmd);
    free(cmd);

    if (status == 0)
    {
        char *ok = (char *)malloc(3);
        if (ok)
        {
            ok[0] = 'o';
            ok[1] = 'k';
            ok[2] = '\0';
        }
        return ok;
    }
    return NULL;
}

/* ---- Environment & path helpers ---- */

char *sailfin_runtime_getenv(const char *name)
{
    if (!name)
        return NULL;
    const char *val = getenv(name);
    if (!val)
        return NULL;
    return strdup(val);
}

char *sailfin_runtime_home_dir(void)
{
#if defined(_WIN32)
    const char *home = getenv("USERPROFILE");
#else
    const char *home = getenv("HOME");
#endif
    if (!home)
        return NULL;
    return strdup(home);
}

char *sailfin_runtime_read_file_bytes(const char *path, int64_t *out_length)
{
    if (!path || !out_length)
        return NULL;

    FILE *f = fopen(path, "rb");
    if (!f)
        return NULL;

    fseek(f, 0, SEEK_END);
    long n = ftell(f);
    fseek(f, 0, SEEK_SET);

    if (n < 0)
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
    *out_length = (int64_t)read_n;
    return buf;
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
    _print_line(stderr, "[value_error] ", (const char *)message);
    abort();
}

/* Alias: the compiler emits calls to runtime_raise_value_error_fn when the
 * runtime helper symbol resolution doesn't fire (e.g. in test lowering). */
void runtime_raise_value_error_fn(void *message)
    __attribute__((alias("sailfin_runtime_raise_value_error")));

/* Wrapper: the compiler may emit calls to substring_unchecked with double
 * params (Sailfin number type) instead of i64.  Forward to the real impl. */
char *substring_unchecked(char *text, double start, double end)
{
    return sailfin_runtime_substring_unchecked(text, (int64_t)start, (int64_t)end);
}

// Debug helper: validate an "identifier name" pointer and dump context if suspicious.
// Called with the Expression* that should contain the identifier.
void sailfin_runtime_debug_validate_identifier(void *expr_ptr, void *name_ptr)
{
    static int check_enabled = -1;
    if (check_enabled < 0)
    {
        check_enabled = _env_enabled("SAILFIN_DEBUG_IDENTIFIER_VALIDATION") ? 1 : 0;
    }
    if (!check_enabled)
    {
        return;
    }

    const char *name = (const char *)name_ptr;
    if (!name)
    {
        fprintf(stderr, "[debug] validate_identifier: name=NULL expr=%p\n", expr_ptr);
        return;
    }

    // Check if this looks like a double bit pattern (especially 3.0 = 0x4008000000000000).
    uintptr_t val = (uintptr_t)name;
    if (val == 0x4008000000000000ULL)
    {
        fprintf(
            stderr,
            "[debug] validate_identifier: SUSPICIOUS name=%p (double 3.0 bit pattern!) expr=%p\n",
            name_ptr,
            expr_ptr);
        fflush(stderr);

        // Dump the Expression struct (tag + payload bytes).
        if (expr_ptr)
        {
            fprintf(stderr, "[debug] Expression hexdump (first 64 bytes at %p):\n", expr_ptr);
            const unsigned char *bytes = (const unsigned char *)expr_ptr;
            for (int i = 0; i < 64 && i < 64; i += 16)
            {
                fprintf(stderr, "  %04x: ", i);
                for (int j = 0; j < 16 && (i + j) < 64; j++)
                {
                    fprintf(stderr, "%02x ", bytes[i + j]);
                }
                fprintf(stderr, "\n");
            }
            fflush(stderr);

            // Interpret as { i32 tag, [4 x i8] pad, [40 x i8] payload }.
            const uint32_t *tag_ptr = (const uint32_t *)expr_ptr;
            fprintf(stderr, "[debug]   tag = %u (0x%x)\n", *tag_ptr, *tag_ptr);
            const unsigned char *payload_start = bytes + 8; // after tag+pad
            fprintf(stderr, "[debug]   payload[0..8] as ptr: %p\n", *(void **)payload_start);
            const double *payload_as_double = (const double *)payload_start;
            fprintf(stderr, "[debug]   payload[0..8] as double: %g\n", *payload_as_double);
            fflush(stderr);
        }

#if defined(__APPLE__)
        // Print backtrace.
        void *callstack[128];
        int frames = backtrace(callstack, 128);
        char **strs = backtrace_symbols(callstack, frames);
        if (strs)
        {
            fprintf(stderr, "[debug] backtrace:\n");
            for (int i = 0; i < frames; i++)
            {
                fprintf(stderr, "%s\n", strs[i]);
            }
            free(strs);
        }
        fflush(stderr);
#endif
    }
}
