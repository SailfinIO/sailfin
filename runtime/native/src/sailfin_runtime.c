#include "sailfin_runtime.h"
#include "sailfin_arena.h"

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
#include <poll.h>
#endif

#if !defined(_WIN32)
/* `<time.h>` is needed on every POSIX target (Linux, macOS, BSD) for
 * `time_t`, `struct timespec`, and other clock helpers used by the
 * remaining C runtime (e.g. monotonic-millis). The `sailfin_runtime_sleep`
 * caller was deleted in PR 2 of the sleep migration (issue #397).
 * macOS's `<mach/mach_time.h>` does not transitively export these. */
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

#if defined(_WIN32)
/* MinGW does not ship POSIX `realpath`, but
 * `runtime/sfn/platform/exec.sfn::exe_path()` calls it on every
 * platform to canonicalize the path returned by the
 * `sailfin_intrinsic_exe_path` sentinel. Forward to `_fullpath`
 * (matching the retired C driver's macro). The Sailfin callers in
 * `exe_path` / `resolve_runtime_root` pass NULL for `resolved`, so
 * `_fullpath` mallocs the buffer.
 *
 * The Windows `readlink` stub that previously lived here is gone:
 * the exe-path lowering now emits `GetModuleFileNameA` on the
 * Windows target (#967) rather than `readlink`, and `exec.sfn` no
 * longer declares or calls `readlink` directly (#968), so nothing
 * references the symbol on this platform anymore (#971). */
#include <windows.h>
#include <stdlib.h>

char *realpath(const char *path, char *resolved)
{
    return _fullpath(resolved, path, MAX_PATH);
}
#endif

static bool _env_enabled(const char *name);
static int _env_int(const char *name, int fallback);
static int64_t _clamp_to_i64(double v);
static inline int _is_corrupted_string_ptr(const char *ptr);

static void _print_line(FILE *stream, const char *prefix, const char *msg);

typedef struct SailfinTryContext
{
    jmp_buf env;
    struct SailfinTryContext *prev;
} SailfinTryContext;

static _Thread_local SailfinTryContext *_sailfin_try_stack = NULL;
static _Thread_local char *_sailfin_exception_message = NULL;

// Forward declaration — defined near the concat reuse globals below.
static inline void _runtime_enter(void);

// =============================================================================
// ABI version check (issue #392 / M1.C; issue #462)
// =============================================================================
// Every emitted Sailfin LLVM module defines `@sfn_abi_version` and
// `@sfn_abi_hash` with `linkonce_odr` linkage. At process startup
// `_runtime_init` reads the version and aborts with a diagnostic if it
// does not match the value the runtime was built against.
//
// `@sfn_abi_hash` is an FNV-1a 64-bit digest over a stable rendering of
// the locked SfnString / SfnArray aggregate layouts (see
// `compiler/src/llvm/lowering/abi_hash.sfn`). Compiler and runtime run
// in the same address space, so the `i64` symbol is read as `uint64_t`
// directly — no endianness handling is required today. If we ever need
// to ship a precompiled artifact across architectures, the hash would
// have to be re-encoded as a byte sequence; that's an out-of-scope
// change for #462.
//
// The C runtime also provides weak fallback definitions of both
// symbols. Mach-O's static linker (unlike ELF ld) errors on
// unresolved weak references, so a runtime-only build without any
// Sailfin LLVM module would fail to link otherwise. With the
// fallbacks in place:
//   - When the LLVM IR also defines them (every Sailfin program),
//     `linkonce_odr` (which lowers to `weak_def_can_be_hidden` on
//     Mach-O) coexists with the C `weak` definition; the linker
//     picks one and both carry the same value, so the check passes.
//   - When only the C definition exists (runtime-only smoke test),
//     the fallback is used and the check passes.
//   - When the LLVM-emitted hash diverges (layout drift), the
//     LLVM `weak_def_can_be_hidden` definition outranks the C
//     `weak` fallback so the diagnostic fires.
#define SAILFIN_ABI_VERSION_EXPECTED 1
// FNV-1a 64-bit of `sfn_abi_locked_layout_string()`. Recompute via
//   build/native/sailfin emit llvm examples/basics/hello-world.sfn \
//     | grep '@sfn_abi_hash'
// after touching the locked layouts (or run the FNV-1a algorithm
// against the layout string directly). The current value pins
// `SfnString{f0:i8*@8;f1:i64@8};SfnArray{f0:i8**@8;f1:i64@8;f2:i64@8}`.
#define SAILFIN_ABI_HASH_EXPECTED UINT64_C(13458649150685806382)

__attribute__((weak)) const int32_t sfn_abi_version = SAILFIN_ABI_VERSION_EXPECTED;
__attribute__((weak)) const uint64_t sfn_abi_hash = SAILFIN_ABI_HASH_EXPECTED;

static void _runtime_init(void) __attribute__((constructor));
static void _runtime_init(void)
{
    // SAILFIN_ABI_FORCE_MISMATCH lets the unit-test harness drive the
    // failure path without rebuilding the runtime. Setting it to "hash"
    // forces a hash mismatch; any other non-empty / non-"0" value forces
    // a version mismatch. Production binaries leave it unset.
    const char *force = getenv("SAILFIN_ABI_FORCE_MISMATCH");
    int force_version = 0;
    int force_hash = 0;
    if (force && force[0] != '\0' && force[0] != '0')
    {
        if (strcmp(force, "hash") == 0)
        {
            force_hash = 1;
        }
        else
        {
            force_version = 1;
        }
    }

    int32_t observed_version = sfn_abi_version;
    if (force_version)
    {
        observed_version = SAILFIN_ABI_VERSION_EXPECTED + 1;
    }
    if (observed_version != SAILFIN_ABI_VERSION_EXPECTED)
    {
        fprintf(stderr,
                "[sailfin] ABI version mismatch: runtime expects %d but "
                "linked module reports %d. Rebuild the compiler "
                "(`make rebuild`) so the runtime and emitted IR agree.\n",
                SAILFIN_ABI_VERSION_EXPECTED, observed_version);
        fflush(stderr);
        _exit(70);
    }

    uint64_t observed_hash;
    if (force_hash)
    {
        observed_hash = SAILFIN_ABI_HASH_EXPECTED ^ UINT64_C(0xDEADBEEFCAFEBABE);
    }
    else
    {
        observed_hash = sfn_abi_hash;
    }
    if (observed_hash != SAILFIN_ABI_HASH_EXPECTED)
    {
        fprintf(stderr,
                "[sailfin] ABI hash mismatch: runtime expects 0x%016llx "
                "but linked module reports 0x%016llx. Layout drift "
                "detected — rebuild the compiler.\n",
                (unsigned long long)SAILFIN_ABI_HASH_EXPECTED,
                (unsigned long long)observed_hash);
        fflush(stderr);
        _exit(70);
    }
}

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
    _runtime_enter();
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
// Concat reuse optimization
// =============================================================================
// When chained concatenations happen (a + b + c + d), the LLVM IR is:
//   %t1 = call concat(a, b)
//   %t2 = call concat(%t1, c)
//   %t3 = call concat(%t2, d)
// Each intermediate (%t1, %t2) is used exactly once as the first arg of the
// next concat. We can append in-place if the first arg is the result of the
// immediately preceding concat call AND no other runtime function was called
// in between (the call sequence counter guarantees this).
//
// Safety: _runtime_call_seq is incremented at ENTRY to every exported runtime
// function. The reuse is only valid when _concat_reuse_seq == _runtime_call_seq,
// meaning the CURRENT concat call is the very next runtime call after the
// previous concat. Any intervening call (array_push, number_to_string, strlen,
// fs.readFile, etc.) bumps the counter and invalidates the window. This is
// strictly stronger than tracking only "store" calls — it catches ALL
// intervening activity including LLVM store instructions that call runtime
// helpers and any function that might observe the string.
static char *_concat_reuse_ptr = NULL; // last concat result pointer
static size_t _concat_reuse_cap = 0;   // allocated capacity of that buffer
static size_t _concat_reuse_len = 0;   // current string length in the buffer
static uint64_t _concat_reuse_seq = 0; // call_seq when last result was produced
static uint64_t _runtime_call_seq = 0; // incremented at entry to every exported fn

// Call this at the top of every exported runtime function.
static inline void _runtime_enter(void) { _runtime_call_seq++; }

// Used by array_push / concat / string_drop to invalidate the concat-reuse
// window. #892: this was gutted to a no-op under the assumption that EVERY
// exported runtime fn calls _runtime_enter() (which bumps the seq and thereby
// invalidates the window). That assumption is false — a family of exported
// trampolines (sfn_int_to_str, sfn_str_byte_at, the array_push_slot variants,
// ...) never entered, so a `lines.push(...)` between two `+` operations left a
// stale in-place-append window pointing at the just-pushed buffer, eating its
// prefix (the non-deterministic declare/body-line clobber). Bumping the seq
// here restores invalidation for every site that already calls this, and is
// always correctness-safe: the counter's only consumer is the reuse guard, so
// an extra bump can only miss a reuse (alloc fresh), never produce wrong data.
static inline void _invalidate_concat_reuse(void) { _runtime_enter(); }

// =============================================================================
// Arena-aware allocation helpers (M0.5)
// =============================================================================
// When SAILFIN_USE_ARENA=1, all string/array allocations route through the
// process-global arena. In arena mode the owned-string hash table and
// persistent-pointer set are bypassed entirely — memory is freed in bulk at
// process exit.

static inline void *_rt_malloc(size_t size)
{
    if (sfn_arena_enabled())
        return sfn_arena_alloc(sfn_arena_global(), size, 8);
    return malloc(size);
}

static inline void *_rt_calloc(size_t count, size_t size)
{
    if (sfn_arena_enabled())
    {
        size_t total = count * size;
        if (count != 0 && total / count != size)
            return NULL; /* overflow */
        void *p = sfn_arena_alloc(sfn_arena_global(), total, 8);
        if (p)
            memset(p, 0, total);
        return p;
    }
    return calloc(count, size);
}

static inline void *_rt_realloc(void *ptr, size_t old_size, size_t new_size)
{
    if (sfn_arena_enabled())
        return sfn_arena_realloc(sfn_arena_global(), ptr, old_size, new_size, 8);
    (void)old_size;
    return realloc(ptr, new_size);
}

/* No-op in arena mode; free() in malloc mode. */
static inline void _rt_free(void *ptr)
{
    if (sfn_arena_enabled())
        return;
    free(ptr);
}

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
static uint64_t _alloc_stats_string_append_calls = 0;
static uint64_t _alloc_stats_string_append_bytes = 0;
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
        "[stage2-native] alloc_stats string_concat calls=%llu bytes=%llu string_append calls=%llu bytes=%llu substring calls=%llu bytes=%llu array_alloc calls=%llu bytes=%llu\n",
        (unsigned long long)_alloc_stats_string_concat_calls,
        (unsigned long long)_alloc_stats_string_concat_bytes,
        (unsigned long long)_alloc_stats_string_append_calls,
        (unsigned long long)_alloc_stats_string_append_bytes,
        (unsigned long long)_alloc_stats_substring_calls,
        (unsigned long long)_alloc_stats_substring_bytes,
        (unsigned long long)_alloc_stats_array_alloc_calls,
        (unsigned long long)_alloc_stats_array_alloc_bytes);
    fflush(stderr);
}

// =============================================================================
// Arena allocator process-exit telemetry (debug)
// =============================================================================
//
// Ported from the retired C driver in M5.5
// (#473). Gated on `SAILFIN_DUMP_ARENA_STATS=1`; emits a single
// `[sailfin-arena] label=... pages=... capacity=... ...` line on
// process exit when the arena is on, or `stats=disabled` when an
// explicit `SAILFIN_USE_ARENA={0,'',false}` opt-out is in effect.
// `test_arena_default_on.sh` pins the contract.
//
// The C-driver entry point used to register the atexit hook directly;
// post-#473, Sailfin's `fn main` (`compiler/src/cli_main.sfn`) walks
// argv on the Sailfin side, picks the label, and calls
// `sailfin_runtime_install_arena_telemetry(label)` once at startup.
// The hook itself stays in C because there is no Sailfin-level
// `atexit` primitive yet.
//
// `_arena_stats_label` is sized for typical CLI invocations
// (`sfn run examples/basics/hello-world.sfn`); paths longer than
// 255 bytes are truncated for the label only — the caller-owned
// label string is unaffected.
static char _arena_stats_label[256] = "<unknown>";
static int _arena_stats_installed = 0;

static int _arena_stats_telemetry_enabled(void)
{
    const char *flag = getenv("SAILFIN_DUMP_ARENA_STATS");
    return flag && flag[0] != '\0' && flag[0] != '0';
}

static void _arena_stats_atexit(void)
{
    if (!_arena_stats_telemetry_enabled())
    {
        return;
    }
    if (!sfn_arena_enabled())
    {
        // Explicit opt-out (`SAILFIN_USE_ARENA={0,'',false}`); surface
        // the value so the log line is self-explanatory.
        const char *opt_out = getenv("SAILFIN_USE_ARENA");
        fprintf(stderr,
                "[sailfin-arena] label=%s stats=disabled "
                "(SAILFIN_USE_ARENA=\"%s\" opt-out)\n",
                _arena_stats_label,
                opt_out ? opt_out : "");
        return;
    }
    fprintf(stderr, "[sailfin-arena] label=%s ", _arena_stats_label);
    sfn_arena_print_stats(sfn_arena_global());
}

void sailfin_runtime_install_arena_telemetry(char *label)
{
    // Idempotent: multiple Sailfin `fn main` invocations (e.g. when a
    // test fixture re-enters via dlopen + dlsym) must not register
    // the hook twice.
    if (_arena_stats_installed)
    {
        return;
    }
    if (!_arena_stats_telemetry_enabled())
    {
        return;
    }
    if (label && label[0] != '\0')
    {
        strncpy(_arena_stats_label, label, sizeof(_arena_stats_label) - 1);
        _arena_stats_label[sizeof(_arena_stats_label) - 1] = '\0';
    }
    atexit(_arena_stats_atexit);
    _arena_stats_installed = 1;
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

// Scrub a stale data pointer from the ring buffer. Called before realloc
// frees the old backing so that future _recent_array_contains() calls
// cannot match against the freed address (which may be reused by malloc
// for a non-array allocation, causing array_push_slot to read a bogus
// header at old_ptr - 32 and corrupt output).
static void _recent_array_remove(const void *data)
{
    if (!data)
    {
        return;
    }
    pthread_mutex_lock(&_sailfin_recent_array_lock);
    const size_t cap = sizeof(_sailfin_recent_arrays) / sizeof(_sailfin_recent_arrays[0]);
    for (size_t i = 0; i < cap; i++)
    {
        if (_sailfin_recent_arrays[i] == data)
        {
            _sailfin_recent_arrays[i] = NULL;
        }
    }
    pthread_mutex_unlock(&_sailfin_recent_array_lock);
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
    if (sfn_arena_enabled())
    {
        return; /* Arena handles bulk deallocation — no per-string tracking. */
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
    if (sfn_arena_enabled())
    {
        return; /* Arena handles bulk deallocation — no persistent tracking. */
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
    _invalidate_concat_reuse();
    if (sfn_arena_enabled())
    {
        return; /* Arena handles bulk deallocation. */
    }
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

/* Scope-exit drop helper for owned RC locals (M1.5.2 / issue #326).
 *
 * The compiler emits `call void @sfn_rc_release(i8* %ptr)` for every
 * owned local with `allocation_kind == "rc"` at scope close. Until
 * M1.5.5 ships escape promotion, no local is ever marked rc — the
 * compiler emits zero calls today and this stub is unreachable from
 * user code. The stub is intentionally a no-op so a future caller
 * against an arena-allocated pointer cannot trigger a use-after-free;
 * M2 will replace this with the real refcount-decrement-and-free path
 * once `runtime/sfn/memory.sfn` lands.
 */
void sfn_rc_release(void *ptr)
{
    (void)ptr;
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

/* M2.8 (#401): SfnString migration trampolines for the print
 * family. Mirrors the M2.4a wave-1 trampolines above (`sfn_str_len`,
 * `sfn_str_eq`, ...). The compiler's runtime_helpers.sfn registry
 * carries `parameter_types: ["{i8*, i64}"]` + `native_signature:
 * "sfn_print*"` on each descriptor, so fresh user emission produces
 *   call void @sfn_print_info({i8*, i64} %s)
 * with the SfnString aggregate passed by value. The bodies forward
 * verbatim to the legacy `sailfin_runtime_print_*` entrypoints —
 * today's SfnString.data is NUL-terminated end-to-end (literal
 * lowering writes a trailing 0 past the byte payload, and the
 * arena-routed concat in `sfn_str_concat` preserves the +1
 * NUL byte), so the legacy `char *`-consuming bodies remain
 * correct without a second formatting strategy. Once M2.4b/M2.8
 * length-aware print bodies arrive, the forwarding here retires
 * in a single rollback-safe rename. */
void sfn_print(SfnString s) { sailfin_runtime_print_raw(s.data); }
void sfn_print_err(SfnString s) { sailfin_runtime_print_err(s.data); }
void sfn_print_info(SfnString s) { sailfin_runtime_print_info(s.data); }
void sfn_print_warn(SfnString s) { sailfin_runtime_print_warn(s.data); }
void sfn_print_error(SfnString s) { sailfin_runtime_print_error(s.data); }

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

/* `sailfin_runtime_sleep` and the `sfn_sleep` C trampoline were
 * deleted in PR 2 of the sleep migration (issue #397). The
 * `@sfn_sleep` symbol is now defined by `runtime/sfn/clock.sfn`,
 * which calls `nanosleep` directly via
 * `runtime/sfn/platform/posix.sfn`. The Sailfin module is linked
 * into every compiler binary via `runtime/native/capsule.toml`'s
 * `sfn-sources` entry. See `docs/runtime_audit.md` for the
 * migration trail.
 *
 * Windows: a Sailfin-native Win32 `Sleep` path is a follow-up; the
 * platform was already implicitly POSIX-only because the pre-PR
 * Windows branch above was unreachable from the runtime's release
 * targets (Linux x86_64 + macOS arm64).
 */

/* M2.4a (#396): SfnString migration trampolines. After the
 * runtime-helper registry flip in compiler/src/llvm/runtime_helpers.sfn,
 * fresh compiler emission lowers `s.length`, `a == b` (string),
 * `substring(...)`, and the `i8*` to `{i8*, i64}` length-recovery
 * shim in core_operands.sfn to `@sfn_str_*` calls instead of the
 * legacy `@sailfin_runtime_string_length` / `@strings_equal` /
 * `@substring_unchecked` C entrypoints. These four trampolines
 * provide the new symbol surface against the existing C bodies so
 * test binaries (scripts/run_native_test.sh only links the
 * runtime/native/src C sources) and the compiler binary itself
 * resolve at link time without depending on a Sailfin-side
 * definition that lives outside the test linker's reach.
 *
 * The Sailfin definition site is runtime/sfn/string.sfn, which
 * exports the same five operations under the `sfn_str_sfn_*`
 * infix to coexist (mirrors runtime/sfn/memory/arena.sfn's
 * `sfn_arena_sfn_*` parallel namespace). M2.4b retires these
 * trampolines once the aggregate-by-value parameter flip
 * (M1.A.2) lands and the Sailfin bodies become the sole
 * definition site — at that point the `_sfn_` infix is removed
 * in a single rollback-safe PR.
 *
 * sfn_str_eq routes through `_strings_equal_fast` (this file)
 * rather than `strings_equal` (defined in runtime/prelude.sfn)
 * to keep the C trampoline link-self-sufficient: every test
 * binary links sailfin_runtime.o, but the prelude .o does not
 * always reach the link line on every code path (e.g. the
 * standalone `sfn test <project>` flow assembles the link from
 * the project's CWD without a guaranteed prelude.o probe). */
int64_t sailfin_runtime_string_length(char *text);

char *sailfin_runtime_substring_unchecked(char *text, int64_t start, int64_t end);

/* #716: Immediate-codepoint pseudo-pointer guard for the `sfn_str_*`
 * trampoline family.
 *
 * `char_at(text, i)` (and other single-grapheme readers) sometimes
 * returns a codepoint *tagged into the pointer itself* rather than a
 * heap/literal `i8*` — the legacy `(codepoint << 32)` encoding, plus a
 * near-null ASCII form, both classified by
 * `_is_immediate_codepoint_string` above. A trampoline that dereferences
 * its operand directly (via `_safe_strlen_asan`, `memchr`, `s[i]`,
 * `strtod`, …) will SIGSEGV on such a value: `_safe_strlen_asan` rejects
 * the near-null form but the `(cp << 32)` form has zero high bits and
 * sails through into an unmapped read (this is exactly the
 * `0x6800000000` crash from #714). Any body that does NOT trampoline
 * through a legacy `sailfin_runtime_*` entry that already decodes MUST
 * route its operand through one of these helpers first.
 *
 * `_sfn_str_decode_immediate` writes the 1-4 UTF-8 bytes (+ NUL) into a
 * caller-owned 5-byte scratch buffer and is for within-call consumption.
 * Retires with the M1.A.2 type-mapping flip that eliminates the encoding
 * entirely. */
static const char *_sfn_str_decode_immediate(const char *s, unsigned char scratch[5])
{
    uint32_t cp = 0;
    if (_is_immediate_codepoint_string(s, &cp))
    {
        _utf8_encode(cp, scratch); /* NUL-terminates the buffer */
        return (const char *)scratch;
    }
    return s;
}

/* #716: Owning variant for the identity ABI bridges (`sfn_str_to_cstr` /
 * `sfn_str_from_cstr`) whose result outlives the call, so a stack
 * scratch buffer cannot back it. Materializes an immediate codepoint
 * into a tracked `_rt_malloc` buffer; genuine pointers pass through
 * untouched (preserving the identity-bridge contract for real strings).
 * On allocation failure it returns the original operand — no worse than
 * today's behaviour, and OOM is already fatal elsewhere. */
static const char *_sfn_str_decode_immediate_owned(const char *s)
{
    uint32_t cp = 0;
    if (!_is_immediate_codepoint_string(s, &cp))
    {
        return s;
    }
    unsigned char buf[5];
    size_t n = _utf8_encode(cp, buf);
    char *out = (char *)_rt_malloc(n + 1);
    if (!out)
    {
        return s;
    }
    memcpy(out, buf, n);
    out[n] = '\0';
    _track_owned_string(out);
    return (const char *)out;
}

/* #716 audit: safe by delegation — `sailfin_runtime_string_length`
 * (line ~2803) opens with an `_is_immediate_codepoint_string` guard and
 * returns the decoded grapheme count, so the immediate pseudo-pointer
 * never reaches a raw dereference here. */
int64_t sfn_str_len(const char *s)
{
    return sailfin_runtime_string_length((char *)s);
}

/* #716 audit: safe by delegation — `_strings_equal_fast` (line ~576)
 * decodes BOTH operands via `_is_immediate_codepoint_string` before any
 * byte compare, so immediate ⇄ immediate and immediate ⇄ real pointer
 * mixes are all handled. */
bool sfn_str_eq(const char *a, const char *b)
{
    // #892: sfn_str_eq is an exported runtime boundary (the lowering target of
    // string `==`, core_operands.sfn:125). It MUST bump _runtime_call_seq at
    // entry like every other exported helper (see the concat-reuse contract at
    // line ~724). Without this, an equality check between two chained concats
    // (e.g. string_array_contains scanning declared symbols mid-`declare`-line
    // build) does NOT invalidate the in-place concat-reuse window, so a later
    // concat stomps a buffer a live string[] element still points at — the
    // non-deterministic 0x40→0xE7 clobber of an unrelated declare line. Reads
    // never observe stale data, so a missing bump here is a pure correctness
    // hole; restoring the invariant is the minimal fix.
    _runtime_enter();
    return _strings_equal_fast(a, b);
}

/* #716 audit: safe by delegation — `sailfin_runtime_substring_unchecked`
 * (line ~2987) guards immediate codepoints before slicing. */
char *sfn_str_slice(const char *text, double start, double end)
{
    /* Route through `_clamp_to_i64` (defined later in this file,
     * forward-declared at the top) so NaN / out-of-range doubles
     * produce defined results — matches `substring_unchecked`'s
     * own double→i64 discipline. A direct `(int64_t)` cast would
     * be UB for those inputs. */
    return sailfin_runtime_substring_unchecked((char *)text, _clamp_to_i64(start), _clamp_to_i64(end));
}

/* `sfn_str_to_cstr` / `sfn_str_from_cstr` are pure ABI bridges in
 * the M2.4a wave: the legacy `i8*` ABI's data pointer is itself
 * NUL-terminated (the literal lowering in `core_strings.sfn`
 * always writes a trailing 0 past the byte payload), so the
 * boundary is the identity function for real pointers. M2.4b
 * replaces these with arena-routed copies once SfnString stops
 * carrying its NUL-termination guarantee.
 *
 * #716: because these are identity (they delegate to no legacy
 * decoder), an immediate-codepoint pseudo-pointer would pass
 * straight through and crash the *caller* the moment it treats the
 * result as a C string. `_sfn_str_decode_immediate_owned`
 * materializes such inputs into a real, tracked NUL-terminated
 * buffer so the returned pointer is always dereferenceable; genuine
 * pointers are still returned unchanged. */
const char *sfn_str_to_cstr(const char *s)
{
    return _sfn_str_decode_immediate_owned(s);
}

const char *sfn_str_from_cstr(const char *s)
{
    return _sfn_str_decode_immediate_owned(s);
}

/* M2.5 (#403): wave-2 trampolines for the canonical sfn_str_* / sfn_*_to_str
 * names. Mirror the M2.4a wave-1 pattern: the compiler's runtime_helpers.sfn
 * registry flips `native_signature` on the matching descriptors so fresh
 * user emission targets these bare canonical names; the bodies forward to
 * the legacy `sailfin_runtime_*` entrypoints until the M2.A.2 type-mapping
 * flip lets the bodies move into Sailfin and consume the SfnString
 * aggregate / arena directly. Per acceptance criterion #1, the legacy
 * `sailfin_runtime_grapheme_count / _grapheme_at / _byte_at /
 * _find_byte_index / _char_code / _string_to_number / _number_to_string`
 * symbols become unreferenced in user emission once the seven descriptors
 * flip; the C bodies stay exported so seed-built IR keeps linking
 * (parallel to the wave-1 `strings_equal` / `sailfin_runtime_string_length`
 * coexistence). */
double sailfin_runtime_grapheme_count(char *text);
char *sailfin_runtime_grapheme_at(char *text, double index);
double sailfin_runtime_char_code(char *text);
double sailfin_runtime_string_to_number(char *text);
char *sailfin_runtime_number_to_string(double value);

/* Returns `double` to match the legacy C ABI's register class —
 * `sailfin_runtime_grapheme_count` returns `double` (the post-#639
 * descriptor exposes it to Sailfin as `i64` and `emit_runtime_call`
 * splices a `round + fptosi` coercion at every call site). The
 * trampoline preserves that ABI so the M2.5 flip doesn't disturb
 * the coercion machinery; the eventual Sailfin body retires the
 * double-return convention alongside the wider `int`/`float`
 * landing. */
/* #716 audit: safe by delegation — `sailfin_runtime_grapheme_count`
 * (line ~5872) guards immediate codepoints (counts them as a single
 * grapheme) before any dereference. */
double sfn_str_grapheme_count(const char *s)
{
    return sailfin_runtime_grapheme_count((char *)s);
}

/* #716 audit: safe by delegation — `sailfin_runtime_grapheme_at`
 * (line ~5877) returns the immediate pseudo-pointer itself at index 0
 * and never dereferences it. */
char *sfn_str_grapheme_at(const char *s, double idx)
{
    return sailfin_runtime_grapheme_at((char *)s, idx);
}

/* Legacy `sailfin_runtime_byte_at` returns `double`; the architect spec
 * is `(SfnString, i64) -> i64` (§2.2.2). No compiler emission site calls
 * the legacy entrypoint today — `sailfin_runtime_byte_at` is an orphan
 * from a prior design. This trampoline ships the architect-spec ABI
 * (int64 return, int64 index) so the first caller routes through the
 * canonical shape from the outset. */
int64_t sfn_str_byte_at(const char *s, int64_t idx)
{
    _runtime_enter(); // #892: bump seq to invalidate the concat-reuse window
    if (!s || idx < 0)
    {
        return -1;
    }
    /* #716: this body dereferences its operand directly
     * (`_safe_strlen_asan` + `s[idx]`), so an immediate-codepoint
     * pseudo-pointer must be materialized into real UTF-8 bytes first
     * or the length probe / index read would fault on a tagged
     * address. */
    unsigned char imm_scratch[5];
    s = _sfn_str_decode_immediate(s, imm_scratch);
    /* Upper-bound check via the same `_safe_strlen_asan` length probe
     * `sfn_str_find_byte` uses, so out-of-range indexes return -1
     * instead of dereferencing past the buffer (Copilot review on
     * PR #747). The architect's eventual `(SfnString, i64) -> i64`
     * body reads `s.len` directly off the aggregate and skips the
     * scan; until that lands the proof-of-life trampoline must
     * defend the legacy `* u8` boundary itself. */
    bool truncated = false;
    int64_t len = (int64_t)_safe_strlen_asan((char *)s, &truncated);
    if (idx >= len)
    {
        return -1;
    }
    unsigned char byte = (unsigned char)s[idx];
    return (int64_t)byte;
}

/* memchr-backed first-occurrence scan. Architect spec
 * (`(SfnString, i64, i64) -> i64`, §2.2.2). No compiler emission site
 * targets `sailfin_runtime_find_byte_index` today — same orphan story
 * as `_byte_at`. The trampoline takes int64s end-to-end so callers
 * never round-trip through `double`. */
int64_t sfn_str_find_byte(const char *s, int64_t byte_value, int64_t start_index)
{
    _runtime_enter(); // #892: bump seq to invalidate the concat-reuse window
    if (!s)
    {
        return -1;
    }
    /* #716: `_safe_strlen_asan` + `memchr(s + start, ...)` dereference
     * the operand, so decode immediate codepoints into real bytes
     * before scanning. */
    unsigned char imm_scratch[5];
    s = _sfn_str_decode_immediate(s, imm_scratch);
    int64_t start = start_index < 0 ? 0 : start_index;
    bool truncated = false;
    int64_t len = (int64_t)_safe_strlen_asan((char *)s, &truncated);
    if (start >= len)
    {
        return -1;
    }
    unsigned char target = (unsigned char)(byte_value & 0xff);
    char *found = (char *)memchr(s + start, target, (size_t)(len - start));
    if (!found)
    {
        return -1;
    }
    return (int64_t)(found - s);
}

/* First-codepoint reader. The legacy `sailfin_runtime_char_code` carries
 * the immediate-codepoint pseudo-string fast path and reads the first byte
 * of a NUL-terminated UTF-8 buffer; the architect spec name is
 * `sfn_str_codepoint` (§2.2.2). Returns `double` to match the legacy
 * register class — same rationale as `sfn_str_grapheme_count` above.
 *
 * #716 audit: safe by delegation — `sailfin_runtime_char_code`
 * (line ~7085) carries the immediate-codepoint fast path and returns
 * the tagged value's codepoint without dereferencing it. */
double sfn_str_codepoint(const char *s)
{
    return sailfin_runtime_char_code((char *)s);
}

/* 1-4 byte UTF-8 encode. Architect spec
 * (`(i64, Arena*) -> SfnString`, §2.2.2). Today's proof-of-life trampoline
 * shape drops the arena (no `Arena*` is threaded through the Sailfin
 * call surface yet) and returns a freshly `malloc`-ed NUL-terminated
 * buffer so the boundary stays compatible with the legacy `* u8` ABI.
 * Invalid codepoints (negative or > U+10FFFF) produce an empty string.
 * UTF-16 surrogate range (U+D800..U+DFFF) is rejected with empty too
 * — those are reserved for UTF-16 encoding and never appear in valid
 * UTF-8. */
char *sfn_str_from_codepoint(int64_t cp)
{
    _runtime_enter(); // #892: bump seq to invalidate the concat-reuse window
    unsigned char buf[5];
    size_t len = 0;
    if (cp >= 0 && cp < 0x80)
    {
        buf[0] = (unsigned char)cp;
        len = 1;
    }
    else if (cp >= 0x80 && cp < 0x800)
    {
        buf[0] = (unsigned char)(0xC0u | ((uint32_t)cp >> 6));
        buf[1] = (unsigned char)(0x80u | ((uint32_t)cp & 0x3Fu));
        len = 2;
    }
    else if (cp >= 0x800 && cp < 0x10000 && (cp < 0xD800 || cp > 0xDFFF))
    {
        buf[0] = (unsigned char)(0xE0u | ((uint32_t)cp >> 12));
        buf[1] = (unsigned char)(0x80u | (((uint32_t)cp >> 6) & 0x3Fu));
        buf[2] = (unsigned char)(0x80u | ((uint32_t)cp & 0x3Fu));
        len = 3;
    }
    else if (cp >= 0x10000 && cp <= 0x10FFFF)
    {
        buf[0] = (unsigned char)(0xF0u | ((uint32_t)cp >> 18));
        buf[1] = (unsigned char)(0x80u | (((uint32_t)cp >> 12) & 0x3Fu));
        buf[2] = (unsigned char)(0x80u | (((uint32_t)cp >> 6) & 0x3Fu));
        buf[3] = (unsigned char)(0x80u | ((uint32_t)cp & 0x3Fu));
        len = 4;
    }
    else
    {
        len = 0;
    }
    char *out = (char *)_rt_malloc(len + 1);
    if (!out)
    {
        return NULL;
    }
    if (len > 0)
    {
        memcpy(out, buf, len);
    }
    out[len] = '\0';
    _track_owned_string(out);
    return out;
}

/* #716: unlike the other delegators, `sailfin_runtime_string_to_number`
 * (line ~3871) does NOT guard immediate codepoints — it hands the
 * operand straight to `strtod`, which would dereference a tagged
 * pseudo-pointer. Decode inline before delegating. A single decoded
 * codepoint that isn't a digit parses to 0.0, exactly as `strtod` would
 * yield for the equivalent real one-char string. */
double sfn_str_to_number(const char *s)
{
    unsigned char imm_scratch[5];
    s = _sfn_str_decode_immediate(s, imm_scratch);
    return sailfin_runtime_string_to_number((char *)s);
}

char *sfn_number_to_str(double v)
{
    return sailfin_runtime_number_to_string(v);
}

/* Hand-rolled int-to-string. Architect §2.2.2 calls for hand-rolling
 * (~100 LOC each per Rust `std::fmt` precedent) rather than reaching
 * for variadic snprintf in v0. Writes into a 21-byte stack buffer
 * (the worst-case INT64_MIN decimal width is 20 digits + sign + NUL),
 * copies into a heap buffer, and returns the NUL-terminated result.
 * The arena threading lives in the eventual Sailfin body; this
 * trampoline keeps the legacy `* u8` return ABI so the descriptor
 * flip doesn't need to thread `@sfn_default_arena` through the call
 * site. */
char *sfn_int_to_str(int64_t v)
{
    // #892: this is the format_temp_name backend ("%t" + number_to_string(n)),
    // called between every concat during IR line emission. Without the seq
    // bump, a following lines.push(...) left a stale in-place-append window
    // that ate the "  %tN = insertval" prefix of the just-pushed line.
    _runtime_enter();
    char buf[21];
    size_t pos = sizeof(buf);
    buf[--pos] = '\0';
    bool negative = false;
    uint64_t magnitude;
    if (v < 0)
    {
        negative = true;
        /* INT64_MIN has no positive int64 representation; widen through
         * the unsigned domain before negating. */
        magnitude = (uint64_t)(-(v + 1)) + 1u;
    }
    else
    {
        magnitude = (uint64_t)v;
    }
    if (magnitude == 0)
    {
        buf[--pos] = '0';
    }
    else
    {
        while (magnitude > 0 && pos > 0)
        {
            buf[--pos] = (char)('0' + (magnitude % 10u));
            magnitude /= 10u;
        }
    }
    if (negative && pos > 0)
    {
        buf[--pos] = '-';
    }
    size_t len = sizeof(buf) - 1 - pos;
    char *out = (char *)_rt_malloc(len + 1);
    if (!out)
    {
        return NULL;
    }
    memcpy(out, buf + pos, len);
    out[len] = '\0';
    _track_owned_string(out);
    return out;
}

/* M2.9 (#405): expose the libc `environ` global to the
 * Sailfin-native `sfn_process_run` in `runtime/sfn/process.sfn`.
 * Sailfin has no `extern var` syntax — declaring `environ` as an
 * `extern fn` would link the variable as if it were a function
 * pointer and crash on call. This one-line bridge wraps the
 * variable in a function-call ABI Sailfin can express. The
 * pre-M2.9 C `sailfin_runtime_process_run` reached `environ`
 * directly; this helper preserves child-env-inheritance semantics
 * across the migration (pinned by
 * `compiler/tests/e2e/test_subprocess_emit_clean_env.sh`). */
char **sailfin_runtime_get_environ(void)
{
    return environ;
}

/* M2.4b (#398): arena-aware concat. The new compiler emits
 *   %t = call {i8*, i64} @sfn_str_concat({i8*, i64} a,
 *                                        {i8*, i64} b,
 *                                        ptr @sfn_default_arena)
 *   %p = extractvalue {i8*, i64} %t, 0
 * at every `let s = a + b` site. The third argument is the
 * address of the global pointer `sfn_default_arena` (declared
 * below), so the C signature receives `SfnArena **` and
 * dereferences once. The constructor `_sfn_default_arena_init`
 * primes the slot at module load.
 *
 * Body: bump `a.len + b.len + 1` bytes in the arena (the +1
 * keeps NUL-termination for legacy callers that still treat
 * the result as a C string), memcpy both payloads, write the
 * trailing NUL, and return the aggregate `{data, a.len + b.len}`.
 *
 * History: #714 (M2.4b) introduced this entrypoint under the
 * `_arena` suffix and kept a legacy 2-arg `sfn_str_concat`
 * trampoline alive so the pre-arena seed could still link.
 * #715 retires that legacy 2-arg trampoline and promotes the
 * arena-aware function to the bare canonical name; the
 * `sfn_str_concat_arena` forwarder below survives one more
 * release cycle so seed v0.7.0-alpha.7 — which still emits
 * `@sfn_str_concat_arena` IR — keeps linking. The next seed
 * bump retires that forwarder in a follow-up PR. */
/* M2.4b (#398) — concat-limit / overflow gate shared between the
 * arena-aware `sfn_str_concat_arena` and `sfn_str_append_arena`
 * entrypoints. Mirrors the legacy `sailfin_runtime_string_concat`
 * guard (around line 2725 of this file) so the new ABI path can't
 * silently exhaust the arena with a runaway concatenation.
 *
 * Returns the validated total byte count, or raises ValueError
 * (which aborts the process via `sailfin_runtime_raise_value_error`)
 * on limit-exceeded / overflow. The legacy guard's exact env-var
 * default (`SAILFIN_MAX_STRING_CONCAT=20000000`) and message
 * format are preserved; the only difference is the diagnostic
 * label, which the caller supplies so concat vs append shows up
 * correctly in stderr. */
static size_t _sfn_str_check_concat_limit(size_t alen, size_t blen, const char *label)
{
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
        fprintf(stderr,
                "[stage2-native] %s limit exceeded (alen=%zu blen=%zu limit=%zu)\n",
                label, alen, blen, concat_limit);
        fflush(stderr);
        sailfin_runtime_raise_value_error("string concat limit exceeded");
    }
    if (alen > SIZE_MAX - blen)
    {
        fprintf(stderr,
                "[stage2-native] %s overflow (alen=%zu blen=%zu)\n",
                label, alen, blen);
        fflush(stderr);
        sailfin_runtime_raise_value_error("string concat overflow");
    }
    return alen + blen;
}

SfnString sfn_str_concat(SfnString a, SfnString b, SfnArena **arena_slot)
{
    /* Design note on `SAILFIN_USE_ARENA` opt-out: the arena-aware
     * path is the M1 minimal-viable design per
     * `docs/runtime_architecture.md` §2.1.1 ("the compiler emits a
     * global `@sfn_default_arena` ... all string and array
     * allocations route through this arena"). The env var stays
     * meaningful for the LEGACY C entrypoints (`_rt_malloc` and the
     * 2-arg `sailfin_runtime_string_concat`); fresh user emission
     * targeting `@sfn_str_concat` (post-#715 rename) is
     * unconditionally arena-backed by design. Documented as a deliberate scope
     * delta in PR #714 (see Copilot review reply). */
    SfnArena *arena;
    if (arena_slot != NULL && *arena_slot != NULL)
    {
        arena = *arena_slot;
    }
    else
    {
        /* Defensive: if the constructor hasn't run yet (rare —
         * static-init order would have to be very unusual) or the
         * slot pointer is NULL (defensive coding), fall back to
         * the process-global arena directly. The arena module's
         * pthread_once guard makes this safe under any thread. */
        arena = sfn_arena_global();
        if (arena_slot != NULL && *arena_slot == NULL)
        {
            *arena_slot = arena;
        }
    }

    /* The pre-M1.A.2 frontend lowers `string` to `i8*` for locals
     * and parameters, which means the legacy runtime's tagged
     * immediate codepoint encoding (a single-codepoint "string"
     * encoded as `((uint64_t)codepoint << 32)`, recognised by
     * `_is_immediate_codepoint_string`) reaches us in the
     * `{i8*, i64}` aggregate's data slot. Decode those into a
     * stack buffer before the memcpy so we never dereference the
     * tagged pointer as a real address.
     *
     * `_is_immediate_codepoint_string` covers BOTH the
     * upper-32-bits encoding (e.g. `0x6800000000` for 'h') and
     * the near-null ASCII encoding (e.g. `(char *)0x2e` for '.').
     * `_utf8_encode` writes 1-4 UTF-8 bytes for any valid
     * codepoint, matching the byte length the caller computed via
     * `sfn_str_len` / `sailfin_runtime_string_length` (both walk
     * `_utf8_encode` for immediate inputs and return the same byte
     * count). */
    unsigned char a_imm_buf[5] = {0};
    unsigned char b_imm_buf[5] = {0};
    const char *a_data = a.data;
    const char *b_data = b.data;
    uint32_t a_cp = 0;
    uint32_t b_cp = 0;
    if (_is_immediate_codepoint_string(a.data, &a_cp))
    {
        _utf8_encode(a_cp, a_imm_buf);
        a_data = (const char *)a_imm_buf;
    }
    if (_is_immediate_codepoint_string(b.data, &b_cp))
    {
        _utf8_encode(b_cp, b_imm_buf);
        b_data = (const char *)b_imm_buf;
    }

    /* Apply the same limit/overflow gate the legacy
     * `sailfin_runtime_string_concat` uses (Copilot review feedback
     * on PR #714). Without this, a runaway concat would exhaust the
     * arena's page chain instead of raising a ValueError. */
    size_t alen = a.len < 0 ? 0 : (size_t)a.len;
    size_t blen = b.len < 0 ? 0 : (size_t)b.len;
    size_t total_sz = _sfn_str_check_concat_limit(alen, blen, "string_concat");
    int64_t total = (int64_t)total_sz;

    /* +1 keeps the trailing NUL so legacy `i8*` callers (the
     * extractvalue at every call site discards the length but
     * passes the data pointer to code that may strlen it) stay
     * correct. The NUL byte sits at index `total` inside the
     * `total + 1`-byte arena allocation. */
    char *data = (char *)sfn_arena_alloc(arena, (size_t)(total + 1), 1);
    if (data == NULL)
    {
        SfnString empty = {NULL, 0};
        return empty;
    }
    if (a.len > 0 && a_data != NULL)
    {
        memcpy(data, a_data, (size_t)a.len);
    }
    if (b.len > 0 && b_data != NULL)
    {
        memcpy(data + a.len, b_data, (size_t)b.len);
    }
    data[total] = '\0';

    SfnString result;
    result.data = data;
    result.len = total;
    return result;
}

/* M2.4b (#398): arena-aware in-place append.
 *
 * Compiler-emitted optimization for chained concatenation where
 * the buffer is a known-unaliased intermediate (the same
 * peephole that drives `sailfin_runtime_string_append`). The
 * arena-tip realloc path inside `sfn_arena_realloc` extends in
 * place when `dst->data` is the most-recent allocation; otherwise
 * it allocates fresh and copies. Either way the updated `data`
 * and `len` are written through `dst`.
 *
 * No call sites in the compiler emit this yet — the descriptor
 * row in `runtime_helpers.sfn` is metadata + symbol parking for
 * the first caller (likely the M1.A.2 type-mapping flip when
 * `string` locals become aggregates and the peephole moves into
 * `core_ops_lowering`). Shipping the body now closes the wave 1b
 * surface area so the migration is mechanically complete. */
void sfn_str_append(SfnString *dst, SfnString suffix, SfnArena **arena_slot)
{
    if (dst == NULL)
    {
        return;
    }
    if (suffix.len == 0 || suffix.data == NULL)
    {
        return;
    }

    /* Defensive: refuse to realloc through a corrupted or
     * immediate-codepoint `dst->data` pointer (Copilot review
     * feedback on PR #714). The legacy
     * `sailfin_runtime_string_append` falls back to a fresh
     * concat in this case rather than reallocating; we degrade to
     * a no-op + leave `dst` untouched here because no caller
     * currently routes through this entrypoint (the existing
     * peephole still emits `@sailfin_runtime_string_append`). The
     * first real caller — #717 — will replace this branch with
     * the fresh-concat fallback. */
    if (dst->data != NULL && _is_corrupted_string_ptr(dst->data))
    {
        return;
    }
    if (_is_immediate_codepoint_string(dst->data, NULL))
    {
        return;
    }

    SfnArena *arena;
    if (arena_slot != NULL && *arena_slot != NULL)
    {
        arena = *arena_slot;
    }
    else
    {
        arena = sfn_arena_global();
        if (arena_slot != NULL && *arena_slot == NULL)
        {
            *arena_slot = arena;
        }
    }

    /* Decode tagged immediate codepoint encoding for the suffix
     * (same rationale as `sfn_str_concat` above — the
     * pre-M1.A.2 frontend can present `b.data` as a tagged
     * pointer when the source value is a 1-codepoint literal). */
    unsigned char suffix_imm_buf[5] = {0};
    const char *suffix_data = suffix.data;
    uint32_t suffix_cp = 0;
    if (_is_immediate_codepoint_string(suffix.data, &suffix_cp))
    {
        _utf8_encode(suffix_cp, suffix_imm_buf);
        suffix_data = (const char *)suffix_imm_buf;
    }

    /* Apply the shared limit/overflow gate (same as
     * `sfn_str_concat` — Copilot review feedback on PR #714). */
    size_t old_sz = dst->len < 0 ? 0 : (size_t)dst->len;
    size_t suffix_sz = suffix.len < 0 ? 0 : (size_t)suffix.len;
    size_t new_sz = _sfn_str_check_concat_limit(old_sz, suffix_sz, "string_append");
    int64_t old_len = dst->len;
    int64_t new_len = (int64_t)new_sz;

    /* +1 on both old_size / new_size keeps the trailing NUL. */
    char *grown = (char *)sfn_arena_realloc(arena,
                                            dst->data,
                                            (size_t)(old_len + 1),
                                            (size_t)(new_len + 1),
                                            1);
    if (grown == NULL)
    {
        return;
    }
    memcpy(grown + old_len, suffix_data, (size_t)suffix.len);
    grown[new_len] = '\0';

    dst->data = grown;
    dst->len = new_len;
}

/* #715: transitional `_arena`-suffixed forwarders. Seed
 * v0.7.0-alpha.7 still emits `@sfn_str_concat_arena` /
 * `@sfn_str_append_arena` IR (its baked-in
 * runtime_helpers descriptor predates the bare-name rename).
 * Until the next seed bump pins a binary that emits the bare
 * symbols, the seed-built first-pass binary needs these symbols
 * to resolve at link time. The bodies are one-line forwards to
 * the canonical entrypoints; both forwarders retire in a
 * follow-up PR once `.seed-version` advances. */
SfnString sfn_str_concat_arena(SfnString a, SfnString b, SfnArena **arena_slot)
{
    return sfn_str_concat(a, b, arena_slot);
}

void sfn_str_append_arena(SfnString *dst, SfnString suffix, SfnArena **arena_slot)
{
    sfn_str_append(dst, suffix, arena_slot);
}

/* `@sfn_default_arena` — the IR-visible global pointer that
 * every fresh `sfn_str_concat` / `sfn_str_append` call site
 * passes as the arena argument. The declaration in
 * `compiler/src/llvm/lowering/lowering_phase_render.sfn` is
 * `@sfn_default_arena = external global ptr`; the storage is
 * 8 bytes on 64-bit (a single `SfnArena *`). The constructor
 * below primes the slot at module load by snapshotting
 * `sfn_arena_global()`.
 *
 * Constructor priority 101: runs before any default-priority
 * (>= 65535) constructor, so other static initializers that
 * touch string concatenation see a populated slot. The defensive
 * fallback inside the arena-aware functions handles the unlikely
 * case where a lower-priority constructor allocates before us. */
SfnArena *sfn_default_arena = NULL;

__attribute__((constructor(101))) static void _sfn_default_arena_init(void)
{
    /* Skip the pre-fetch when the legacy `SAILFIN_USE_ARENA=0`
     * opt-out is set so we don't force `sfn_arena_global()` to
     * spin up the page chain at module load (Copilot review
     * feedback on PR #714). The fallback in `sfn_str_concat`
     * / `sfn_str_append` still hits `sfn_arena_global()`
     * lazily on the first call, so this gate only saves the
     * eager init; the new arena-aware path remains
     * arena-backed by design (see the design note inside
     * `sfn_str_concat`). */
    if (!sfn_arena_enabled())
    {
        return;
    }
    sfn_default_arena = sfn_arena_global();
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
    _runtime_enter();
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
    _runtime_enter();
    _maybe_init_alloc_stats();
    if (!text)
    {
        char *out = (char *)_rt_malloc(1);
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
        char *out = (char *)_rt_malloc((size_t)length + 1);
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

    char *out = (char *)_rt_malloc((size_t)length + 1);
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
    _runtime_enter();
    _maybe_init_alloc_stats();
    if (!text)
    {
        char *out = (char *)_rt_malloc(1);
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
        char *out = (char *)_rt_malloc((size_t)length + 1);
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
    char *out = (char *)_rt_malloc((size_t)length + 1);
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

// M1.A: legacy NUL-terminated implementation, exported under its
// historical name so seed-compiled IR (which still emits
// `call i8* @sailfin_runtime_string_concat(i8*, i8*)`) keeps linking
// during the 2-pass self-host build. New compiler IR routes through
// `sailfin_runtime_string_concat_v2`, which extracts the data pointers
// from the SfnString aggregates and forwards here.
char *sailfin_runtime_string_concat(char *a, char *b)
{
    _runtime_enter();
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

    // ---- Concat reuse: DISABLED ----
    // In-place append is not safe because LLVM store instructions between
    // consecutive concat calls are invisible to the runtime call-sequence
    // counter. A stored concat result can be mutated by a subsequent in-place
    // append, corrupting the stored copy. Enabling this optimization requires
    // either compiler-level support (emitting a separate concat_reuse call for
    // known-safe intermediates) or reference counting on strings.
    // The 2x growth factor below still helps by reducing malloc overhead for
    // strings that DO get produced.

    // ---- Normal allocation path ----
    const size_t pad = 64;
    size_t alloc_size = alen + blen + 1 + pad;
    char *out = (char *)_rt_malloc(alloc_size);
    if (!out)
    {
        fprintf(
            stderr,
            "[stage2-native] string_concat OOM (alen=%zu blen=%zu total=%zu) a=%p b=%p a_in=%p b_in=%p\n",
            alen,
            blen,
            alloc_size,
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
        _alloc_stats_string_concat_bytes += (uint64_t)alloc_size;
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

// M1.A: SfnString-by-value entrypoint. The new compiler emits
// `call i8* @sailfin_runtime_string_concat_v2({i8*, i64} %a, {i8*, i64} %b)`
// at every concat site (registry-locked in `runtime_helpers.sfn`).
// We extract the data pointers and forward to the legacy NUL-terminated
// impl until M2.4 ships a length-aware body. The `_v2` suffix lets the
// pre-aggregate `sailfin_runtime_string_concat(char*, char*)` entrypoint
// stay link-stable for seed-compiled IR during the 2-pass self-host
// build; once the floor seed embeds the new ABI we can retire the
// suffix and the legacy entrypoint together.
char *sailfin_runtime_string_concat_v2(SfnString a, SfnString b)
{
    return sailfin_runtime_string_concat(a.data, b.data);
}

// =============================================================================
// String Append (compiler-emitted optimization for chained concatenation)
// =============================================================================
//
// The compiler emits string_append instead of string_concat when it can prove
// the first argument (`buf`) is an intermediate that:
//   - Was produced by a prior string_concat or string_append call
//   - Has not been stored to memory or passed to any other function
//   - Will not be used after this call (it is consumed)
//
// This allows in-place buffer reuse via realloc, avoiding a fresh malloc+copy
// for each link in a concatenation chain like `a + b + c + d`.

char *sailfin_runtime_string_append(char *buf, char *suffix)
{
    _runtime_enter();
    _maybe_init_alloc_stats();

    // buf is CONSUMED: caller transfers ownership, old pointer becomes invalid.
    // suffix is BORROWED: not freed, not modified.

    if (!buf || _is_corrupted_string_ptr(buf))
    {
        // Degenerate case: fall back to concat semantics.
        return sailfin_runtime_string_concat(buf, suffix);
    }
    if (!suffix || _is_corrupted_string_ptr(suffix))
    {
        // Nothing to append — return buf unchanged.
        if (!suffix)
        {
            return buf;
        }
        // Corrupted suffix: fall back to concat for its diagnostics.
        return sailfin_runtime_string_concat(buf, suffix);
    }

    bool buf_truncated = false;
    size_t buf_len = _safe_strlen_asan(buf, &buf_truncated);
    if (buf_truncated)
    {
        // Unterminated buffer — fall back to concat for safety.
        return sailfin_runtime_string_concat(buf, suffix);
    }

    uint32_t suffix_codepoint = 0;
    bool suffix_immediate = _is_immediate_codepoint_string(suffix, &suffix_codepoint);
    unsigned char suffix_buf[5] = {0};
    bool suffix_truncated = false;
    size_t suffix_len = suffix_immediate
                            ? _utf8_encode(suffix_codepoint, suffix_buf)
                            : _safe_strlen_asan(suffix, &suffix_truncated);

    if (suffix_truncated)
    {
        return sailfin_runtime_string_concat(buf, suffix);
    }

    if (suffix_len == 0)
    {
        return buf;
    }

    // Overflow / limit checks (same as string_concat).
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
    if (concat_limit > 0 && (buf_len + suffix_len) > concat_limit)
    {
        fprintf(stderr,
                "[stage2-native] string_append limit exceeded (buf_len=%zu suffix_len=%zu limit=%zu)\n",
                buf_len, suffix_len, concat_limit);
        fflush(stderr);
        sailfin_runtime_raise_value_error("string append limit exceeded");
    }
    if (buf_len > SIZE_MAX - suffix_len)
    {
        sailfin_runtime_raise_value_error("string append overflow");
    }

    const size_t pad = 64;
    size_t alloc_size = buf_len + suffix_len + 1 + pad;
    char *out;
    if (sfn_arena_enabled())
    {
        /* Arena realloc: grow-if-at-tip, else alloc+copy.
         * old_size uses the full prior allocation (buf_len + 1 + pad) so the
         * grow-at-tip check matches the actual bump pointer position. For the
         * first append (unknown prior padding), fall back to buf_len + 1. */
        size_t old_alloc = buf_len + 1 + pad;
        out = (char *)sfn_arena_realloc(sfn_arena_global(), buf,
                                        old_alloc, alloc_size, 8);
    }
    else
    {
        out = (char *)realloc(buf, alloc_size);
    }
    if (!out)
    {
        // On POSIX, realloc failure does not free buf — it remains valid.
        // buf is still in the owned table so string_drop can eventually free it.
        fprintf(stderr,
                "[stage2-native] string_append OOM (buf_len=%zu suffix_len=%zu total=%zu)\n",
                buf_len, suffix_len, alloc_size);
        fflush(stderr);
        return NULL;
    }

    // Remove old buf pointer from owned table now that realloc succeeded.
    // (realloc may have returned the same pointer or a new one; either way,
    // remove the old entry and track the new one below.)
    if (out != buf && !sfn_arena_enabled())
    {
        pthread_mutex_lock(&_sailfin_owned_string_lock);
        _owned_table_remove_unlocked(buf);
        pthread_mutex_unlock(&_sailfin_owned_string_lock);
    }

    if (suffix_immediate)
    {
        memcpy(out + buf_len, suffix_buf, suffix_len);
    }
    else
    {
        memcpy(out + buf_len, suffix, suffix_len);
    }
    memset(out + buf_len + suffix_len, 0, 1 + pad);

    _track_owned_string(out);

    if (_alloc_stats_enabled)
    {
        _alloc_stats_string_append_calls++;
        _alloc_stats_string_append_bytes += (uint64_t)alloc_size;
    }

    if (buf_len + suffix_len >= 1024)
    {
        _recent_string_record(out, buf_len + suffix_len);
    }

    return out;
}

char *sailfin_runtime_number_to_string(double value)
{
    _runtime_enter();
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

    char *out = (char *)_rt_malloc(len + 1);
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

char *number_to_string(double value)
{
    return sailfin_runtime_number_to_string(value);
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
    SailfinPtrArray *arr = (SailfinPtrArray *)_rt_malloc(sizeof(SailfinPtrArray));
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
    char **raw = (char **)_rt_calloc(header_slots + capacity + canary_slots, sizeof(char *));
    if (!raw)
    {
        _rt_free(arr);
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

    // Use the ring buffer to gate the header read — direct magic reads on
    // stack-allocated arrays can segfault. Ring + eviction (see array_push)
    // prevents most stale-entry false positives.
    if (!_recent_array_contains((const void *)arr->data))
    {
        return;
    }
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

// Boxed-struct allocation (0.5.8+ ABI). Returns a pointer to zero-initialized
// memory of the requested size. Routes through the arena when enabled (default-on
// in selfhost builds), otherwise falls back to calloc. Callers use GEP+store to
// populate fields, and return the pointer directly as %Struct*. This replaces
// the pre-0.5.8 LLVM first-class aggregate return (%Struct with chained
// insertvalue), which triggered non-deterministic AArch64 aggregate-return
// legalization mismatches at cross-module boundaries on Apple Silicon.
void *sailfin_runtime_alloc_struct(int64_t size_bytes)
{
    if (size_bytes <= 0)
        return NULL;
    return _rt_calloc(1, (size_t)size_bytes);
}

/* Arena-aware free for `sailfin_runtime_alloc_struct` allocations. The async
 * await unboxing path in `compiler/src/llvm/expression_lowering/native/core.sfn`
 * frees the boxed struct returned by an `async fn -> %T` after copying the
 * value onto the awaiter's stack. Pre-Phase-5a-followup that path used raw
 * `@free`, which assumed the box lived in libc heap. With the boxed-struct
 * literal lowering routed through the arena, libc `free` on an arena pointer
 * corrupts glibc's chunk metadata (`munmap_chunk(): invalid pointer`). This
 * wrapper preserves the no-leak contract under the malloc fallback while
 * letting the arena reclaim the allocation in bulk. */
void sailfin_runtime_free(void *ptr)
{
    if (!ptr)
        return;
    _rt_free(ptr);
}

SailfinPtrArray *sailfin_runtime_concat(SailfinPtrArray *a, SailfinPtrArray *b)
{
    _invalidate_concat_reuse();
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
    _runtime_enter(); // #892: bump seq to invalidate the concat-reuse window
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
    _invalidate_concat_reuse();
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
    // Use ring buffer to gate header read — stack-allocated arrays don't have
    // headers and reading data[-2] on them can segfault. Ring + eviction
    // (see realloc path below) prevents most stale-entry false positives.
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
        // Free the temporary wrapper in malloc mode; in arena mode _rt_free()
        // is a no-op and the backing store stays attached to `array`.
        _rt_free(fresh);

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
        // Evict stale data pointer before realloc frees the old backing.
        _recent_array_remove((const void *)array->data);
        size_t old_alloc = (header_slots + capacity + canary_slots) * sizeof(char *);
        size_t new_alloc = (header_slots + new_capacity + canary_slots) * sizeof(char *);
        char **grown = (char **)_rt_realloc(raw, old_alloc, new_alloc);
        if (!grown)
        {
            // realloc failed — re-record since old buffer is still valid.
            _recent_array_record((const void *)array->data);
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
    _runtime_enter(); // #892: bump seq to invalidate the concat-reuse window
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

    // Use ring buffer to gate header read — stack/unknown arrays don't have
    // headers and reading data[-header_bytes] on them can segfault. Ring +
    // eviction (see realloc path below) prevents most stale-entry false
    // positives.
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
        uint8_t *raw = (uint8_t *)_rt_calloc(1, header_bytes + payload + canary_bytes);
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
        // Evict the old data pointer from the ring BEFORE realloc frees it.
        // Without this, a future push_slot call could match the stale address
        // in the ring, read a bogus header from freed/reused memory, and
        // corrupt the array contents.
        _recent_array_remove((const void *)data);
        size_t old_raw_size = header_bytes + old_payload + canary_bytes;
        size_t new_raw_size = header_bytes + new_payload + canary_bytes;
        uint8_t *grown = (uint8_t *)_rt_realloc(raw, old_raw_size, new_raw_size);
        if (!grown)
        {
            // realloc failed — re-record the old pointer since it's still valid.
            _recent_array_record((const void *)data);
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

// Issue #617: the Sailfin-level entry points to these three stubs
// (the `sfn/sync` `channel` / `parallel` / `spawn` exports, the
// prelude `runtime.channel/_spawn/_parallel` bindings, and the
// LLVM lowering descriptors that pointed at them) have all been
// removed, so freshly-built compilers never emit a call to any
// of the three. The stub bodies remain ONLY because the currently
// pinned seed's pre-built `prelude.o` still has unresolved
// references to these symbols and would refuse to link
// otherwise — they are seed-blocker cleanup once a new seed
// without those references is pinned. Callers that want
// concurrency today must use the typed `spawn_*` / `await_*`
// variants below (real pthread implementations); structured
// concurrency proper is tracked under #500 (roadmap M4).
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

struct SailfinFutureInt
{
    pthread_t thread;
    int64_t (*fn0)(void);
    int64_t (*fn1)(void *);
    void *ctx;
    bool has_ctx;
    int64_t result;
};

static void *sailfin_future_int_entry(void *arg)
{
    struct SailfinFutureInt *future = (struct SailfinFutureInt *)arg;
    if (future->has_ctx)
    {
        future->result = future->fn1 ? future->fn1(future->ctx) : 0;
    }
    else
    {
        future->result = future->fn0 ? future->fn0() : 0;
    }
    return NULL;
}

struct SailfinFutureInt *sailfin_runtime_spawn_int(int64_t (*fn)(void))
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureInt *future = (struct SailfinFutureInt *)calloc(1, sizeof(struct SailfinFutureInt));
    if (!future)
    {
        return NULL;
    }
    future->fn0 = fn;
    future->has_ctx = false;
    if (pthread_create(&future->thread, NULL, sailfin_future_int_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

struct SailfinFutureInt *sailfin_runtime_spawn_int_ctx(int64_t (*fn)(void *), void *ctx)
{
    if (!fn)
    {
        return NULL;
    }
    struct SailfinFutureInt *future = (struct SailfinFutureInt *)calloc(1, sizeof(struct SailfinFutureInt));
    if (!future)
    {
        return NULL;
    }
    future->fn1 = fn;
    future->ctx = ctx;
    future->has_ctx = true;
    if (pthread_create(&future->thread, NULL, sailfin_future_int_entry, future) != 0)
    {
        free(future);
        return NULL;
    }
    return future;
}

int64_t sailfin_runtime_await_int(struct SailfinFutureInt *future)
{
    if (!future)
    {
        return 0;
    }
    pthread_join(future->thread, NULL);
    int64_t result = future->result;
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

void sailfin_runtime_process_exit(double code)
{
    int exit_code = (int)code;
    exit(exit_code);
}

/* ===================================================================
 * Process run_capture / spawn_with_env (issue #365)
 *
 * Stdout/stderr-capturing variants that complement `process.run`.
 * `run_capture` runs the child to completion and stashes the captured
 * streams in thread-local storage; the Sailfin wrapper retrieves them
 * via `_capture_take_stdout` / `_capture_take_stderr` after the call
 * returns. `spawn_with_env` returns a malloc'd handle (cast through
 * int64_t for ABI symmetry with the i64 runtime helpers); the
 * `_handle_*` helpers drive the child's streams and reap it via
 * `_handle_wait`. Envp is a NULL-terminated SfnArray of "KEY=VALUE"
 * strings, or a NULL SfnArray to inherit the parent environment.
 *
 * POSIX path uses `posix_spawnp` with `posix_spawn_file_actions_t`
 * to wire dup2/close cleanly (no stray parent fds in the child) and
 * `poll(2)` to drain stdout/stderr concurrently without deadlock on
 * large pipe writes. Windows path is stub-only — these APIs target
 * the test-infra workstream, which runs on POSIX in CI.
 * =================================================================== */

#if !defined(_WIN32)

static __thread char *_sfn_capture_stdout_stash = NULL;
static __thread char *_sfn_capture_stderr_stash = NULL;

/* Read every remaining byte from `fd` into a malloc-backed buffer
 * (NUL-terminated, returned via the function value; effective byte
 * count returned through *out_len when non-NULL). Returns NULL on
 * allocation failure or unrecoverable I/O error. Caller frees. */
static char *_sfn_read_fd_all(int fd, size_t *out_len)
{
    size_t cap = 4096;
    size_t len = 0;
    char *buf = (char *)malloc(cap);
    if (!buf)
        return NULL;
    for (;;)
    {
        if (len + 1 >= cap)
        {
            size_t new_cap = cap * 2;
            char *r = (char *)realloc(buf, new_cap);
            if (!r)
            {
                free(buf);
                return NULL;
            }
            buf = r;
            cap = new_cap;
        }
        ssize_t n = read(fd, buf + len, cap - len - 1);
        if (n > 0)
        {
            len += (size_t)n;
        }
        else if (n == 0)
        {
            break;
        }
        else
        {
            if (errno == EINTR)
                continue;
            free(buf);
            return NULL;
        }
    }
    buf[len] = '\0';
    if (out_len)
        *out_len = len;
    return buf;
}

/* Materialize a NULL-terminated C argv from an SfnArray of strings.
 * Returns calloc'd `char **` (caller frees the outer array; the
 * element pointers are borrowed from the SfnArray and must not be
 * freed). NULL on allocation failure or empty/invalid input. */
static char **_sfn_build_argv(SfnArray *arr)
{
    if (!arr || arr->len < 0 || !arr->data)
        return NULL;
    size_t n = (size_t)arr->len;
    char **out = (char **)calloc(n + 1, sizeof(char *));
    if (!out)
        return NULL;
    char **src = (char **)arr->data;
    for (size_t i = 0; i < n; i++)
        out[i] = src[i];
    out[n] = NULL;
    return out;
}

/* Drain `fd_out` and `fd_err` concurrently with poll(2), appending
 * received bytes to the respective buffers. Returns 0 on success,
 * -1 on allocation failure. Both file descriptors are closed by the
 * time this returns. */
static int _sfn_drain_pipes(int fd_out, int fd_err,
                            char **buf_out_ptr, size_t *len_out_ptr,
                            char **buf_err_ptr, size_t *len_err_ptr)
{
    size_t cap_out = *len_out_ptr > 4096 ? *len_out_ptr * 2 : 4096;
    size_t cap_err = *len_err_ptr > 4096 ? *len_err_ptr * 2 : 4096;
    char *buf_out = (char *)malloc(cap_out);
    char *buf_err = (char *)malloc(cap_err);
    if (!buf_out || !buf_err)
    {
        free(buf_out);
        free(buf_err);
        if (fd_out >= 0)
            close(fd_out);
        if (fd_err >= 0)
            close(fd_err);
        return -1;
    }
    size_t len_out = 0, len_err = 0;
    int open_count = 0;
    if (fd_out >= 0)
        open_count++;
    if (fd_err >= 0)
        open_count++;
    while (open_count > 0)
    {
        struct pollfd pfds[2];
        int nfds = 0;
        if (fd_out >= 0)
        {
            pfds[nfds].fd = fd_out;
            pfds[nfds].events = POLLIN;
            pfds[nfds].revents = 0;
            nfds++;
        }
        if (fd_err >= 0)
        {
            pfds[nfds].fd = fd_err;
            pfds[nfds].events = POLLIN;
            pfds[nfds].revents = 0;
            nfds++;
        }
        int pr = poll(pfds, (nfds_t)nfds, -1);
        if (pr < 0)
        {
            if (errno == EINTR)
                continue;
            break;
        }
        for (int i = 0; i < nfds; i++)
        {
            short revents = pfds[i].revents;
            if (revents == 0)
                continue;
            int fd = pfds[i].fd;
            char tmp[4096];
            ssize_t n = read(fd, tmp, sizeof(tmp));
            if (n > 0)
            {
                char **buf_pp = (fd == fd_out) ? &buf_out : &buf_err;
                size_t *len_p = (fd == fd_out) ? &len_out : &len_err;
                size_t *cap_p = (fd == fd_out) ? &cap_out : &cap_err;
                if (*len_p + (size_t)n + 1 > *cap_p)
                {
                    size_t new_cap = *cap_p;
                    while (*len_p + (size_t)n + 1 > new_cap)
                        new_cap *= 2;
                    char *r = (char *)realloc(*buf_pp, new_cap);
                    if (!r)
                    {
                        free(buf_out);
                        free(buf_err);
                        if (fd_out >= 0)
                            close(fd_out);
                        if (fd_err >= 0)
                            close(fd_err);
                        return -1;
                    }
                    *buf_pp = r;
                    *cap_p = new_cap;
                }
                memcpy(*buf_pp + *len_p, tmp, (size_t)n);
                *len_p += (size_t)n;
            }
            else if (n == 0 || (revents & (POLLHUP | POLLERR | POLLNVAL)))
            {
                if (fd == fd_out)
                {
                    close(fd_out);
                    fd_out = -1;
                }
                else
                {
                    close(fd_err);
                    fd_err = -1;
                }
                open_count--;
            }
            else if (n < 0 && errno != EINTR && errno != EAGAIN)
            {
                if (fd == fd_out)
                {
                    close(fd_out);
                    fd_out = -1;
                }
                else
                {
                    close(fd_err);
                    fd_err = -1;
                }
                open_count--;
            }
        }
    }
    if (fd_out >= 0)
        close(fd_out);
    if (fd_err >= 0)
        close(fd_err);
    buf_out[len_out] = '\0';
    buf_err[len_err] = '\0';
    *buf_out_ptr = buf_out;
    *len_out_ptr = len_out;
    *buf_err_ptr = buf_err;
    *len_err_ptr = len_err;
    return 0;
}

int64_t sailfin_runtime_process_run_capture(SfnArray *argv, SfnArray *env_flat)
{
    if (_sfn_capture_stdout_stash)
    {
        free(_sfn_capture_stdout_stash);
        _sfn_capture_stdout_stash = NULL;
    }
    if (_sfn_capture_stderr_stash)
    {
        free(_sfn_capture_stderr_stash);
        _sfn_capture_stderr_stash = NULL;
    }

    if (!argv || argv->len <= 0 || !argv->data)
        return -1;

    char **child_argv = _sfn_build_argv(argv);
    if (!child_argv || !child_argv[0])
    {
        free(child_argv);
        return -1;
    }

    /* env_flat NULL means "no SfnArray given" — inherit parent env.
     * env_flat with len == 0 means "empty environment". Sailfin
     * callers that want inheritance pass `env_from_current()`; an
     * `Env { entries: [] }` is interpreted as the empty environment. */
    char **child_envp = NULL;
    bool inherit_env = (env_flat == NULL);
    if (!inherit_env)
    {
        if (env_flat->len == 0)
        {
            child_envp = (char **)calloc(1, sizeof(char *));
            if (!child_envp)
            {
                free(child_argv);
                return -1;
            }
            child_envp[0] = NULL;
        }
        else
        {
            child_envp = _sfn_build_argv(env_flat);
            if (!child_envp)
            {
                free(child_argv);
                return -1;
            }
        }
    }

    int out_pipe[2] = {-1, -1};
    int err_pipe[2] = {-1, -1};
    if (pipe(out_pipe) < 0)
    {
        free(child_argv);
        free(child_envp);
        return -1;
    }
    if (pipe(err_pipe) < 0)
    {
        close(out_pipe[0]);
        close(out_pipe[1]);
        free(child_argv);
        free(child_envp);
        return -1;
    }

    posix_spawn_file_actions_t actions;
    if (posix_spawn_file_actions_init(&actions) != 0)
    {
        close(out_pipe[0]);
        close(out_pipe[1]);
        close(err_pipe[0]);
        close(err_pipe[1]);
        free(child_argv);
        free(child_envp);
        return -1;
    }
    /* Child closes the parent-side read ends, dup2's the write ends
     * over stdout/stderr, and closes the original write fds so the
     * parent's `read` sees EOF when the child exits. */
    posix_spawn_file_actions_addclose(&actions, out_pipe[0]);
    posix_spawn_file_actions_addclose(&actions, err_pipe[0]);
    posix_spawn_file_actions_adddup2(&actions, out_pipe[1], STDOUT_FILENO);
    posix_spawn_file_actions_adddup2(&actions, err_pipe[1], STDERR_FILENO);
    posix_spawn_file_actions_addclose(&actions, out_pipe[1]);
    posix_spawn_file_actions_addclose(&actions, err_pipe[1]);

    char *const *envp = inherit_env ? environ : child_envp;
    pid_t pid;
    int spawn_err = posix_spawnp(&pid, child_argv[0], &actions, NULL, child_argv, envp);
    posix_spawn_file_actions_destroy(&actions);
    if (spawn_err != 0)
    {
        close(out_pipe[0]);
        close(out_pipe[1]);
        close(err_pipe[0]);
        close(err_pipe[1]);
        free(child_argv);
        free(child_envp);
        return -1;
    }

    /* Parent closes the write ends so the read ends see EOF on child
     * exit. */
    close(out_pipe[1]);
    close(err_pipe[1]);
    free(child_argv);
    free(child_envp);

    char *buf_out = NULL;
    char *buf_err = NULL;
    size_t len_out = 0;
    size_t len_err = 0;
    int drain_err = _sfn_drain_pipes(out_pipe[0], err_pipe[0],
                                     &buf_out, &len_out,
                                     &buf_err, &len_err);
    if (drain_err < 0)
    {
        waitpid(pid, NULL, 0);
        return -1;
    }

    int status = 0;
    if (waitpid(pid, &status, 0) < 0)
    {
        free(buf_out);
        free(buf_err);
        return -1;
    }

    _sfn_capture_stdout_stash = buf_out;
    _sfn_capture_stderr_stash = buf_err;

    if (WIFEXITED(status))
        return (int64_t)WEXITSTATUS(status);
    if (WIFSIGNALED(status))
        return (int64_t)(128 + WTERMSIG(status));
    return -1;
}

char *sailfin_runtime_process_capture_take_stdout(void)
{
    char *result = _sfn_capture_stdout_stash;
    _sfn_capture_stdout_stash = NULL;
    if (!result)
    {
        result = (char *)malloc(1);
        if (result)
            result[0] = '\0';
    }
    return result;
}

char *sailfin_runtime_process_capture_take_stderr(void)
{
    char *result = _sfn_capture_stderr_stash;
    _sfn_capture_stderr_stash = NULL;
    if (!result)
    {
        result = (char *)malloc(1);
        if (result)
            result[0] = '\0';
    }
    return result;
}

typedef struct
{
    pid_t pid;
    int stdin_fd;
    int stdout_fd;
    int stderr_fd;
    /* Per-stream stash buffers populated by `_sfn_handle_drain_one`.
     * The poll-based drain reads from both pipes whenever either side
     * has data so a child writing >PIPE_BUF to one stream cannot
     * deadlock by filling its kernel buffer while the parent is
     * blocked reading the other. Whatever the caller didn't ask for
     * stays in the stash for the matching `_handle_read_*` call. */
    char *stdout_buf;
    size_t stdout_len;
    size_t stdout_cap;
    char *stderr_buf;
    size_t stderr_len;
    size_t stderr_cap;
} SailfinProcessHandle;

int64_t sailfin_runtime_process_spawn_with_env(SfnArray *argv, SfnArray *env_flat)
{
    if (!argv || argv->len <= 0 || !argv->data)
        return 0;

    char **child_argv = _sfn_build_argv(argv);
    if (!child_argv || !child_argv[0])
    {
        free(child_argv);
        return 0;
    }

    char **child_envp = NULL;
    bool inherit_env = (env_flat == NULL);
    if (!inherit_env)
    {
        if (env_flat->len == 0)
        {
            child_envp = (char **)calloc(1, sizeof(char *));
            if (!child_envp)
            {
                free(child_argv);
                return 0;
            }
            child_envp[0] = NULL;
        }
        else
        {
            child_envp = _sfn_build_argv(env_flat);
            if (!child_envp)
            {
                free(child_argv);
                return 0;
            }
        }
    }

    int in_pipe[2] = {-1, -1};
    int out_pipe[2] = {-1, -1};
    int err_pipe[2] = {-1, -1};
    if (pipe(in_pipe) < 0)
    {
        free(child_argv);
        free(child_envp);
        return 0;
    }
    if (pipe(out_pipe) < 0)
    {
        close(in_pipe[0]);
        close(in_pipe[1]);
        free(child_argv);
        free(child_envp);
        return 0;
    }
    if (pipe(err_pipe) < 0)
    {
        close(in_pipe[0]);
        close(in_pipe[1]);
        close(out_pipe[0]);
        close(out_pipe[1]);
        free(child_argv);
        free(child_envp);
        return 0;
    }

    posix_spawn_file_actions_t actions;
    if (posix_spawn_file_actions_init(&actions) != 0)
    {
        close(in_pipe[0]);
        close(in_pipe[1]);
        close(out_pipe[0]);
        close(out_pipe[1]);
        close(err_pipe[0]);
        close(err_pipe[1]);
        free(child_argv);
        free(child_envp);
        return 0;
    }
    posix_spawn_file_actions_addclose(&actions, in_pipe[1]);
    posix_spawn_file_actions_addclose(&actions, out_pipe[0]);
    posix_spawn_file_actions_addclose(&actions, err_pipe[0]);
    posix_spawn_file_actions_adddup2(&actions, in_pipe[0], STDIN_FILENO);
    posix_spawn_file_actions_adddup2(&actions, out_pipe[1], STDOUT_FILENO);
    posix_spawn_file_actions_adddup2(&actions, err_pipe[1], STDERR_FILENO);
    posix_spawn_file_actions_addclose(&actions, in_pipe[0]);
    posix_spawn_file_actions_addclose(&actions, out_pipe[1]);
    posix_spawn_file_actions_addclose(&actions, err_pipe[1]);

    char *const *envp = inherit_env ? environ : child_envp;
    pid_t pid;
    int spawn_err = posix_spawnp(&pid, child_argv[0], &actions, NULL, child_argv, envp);
    posix_spawn_file_actions_destroy(&actions);
    if (spawn_err != 0)
    {
        close(in_pipe[0]);
        close(in_pipe[1]);
        close(out_pipe[0]);
        close(out_pipe[1]);
        close(err_pipe[0]);
        close(err_pipe[1]);
        free(child_argv);
        free(child_envp);
        return 0;
    }

    /* Parent keeps the write end of stdin and the read ends of
     * stdout/stderr; the child-side originals were closed by the
     * file_actions list. */
    close(in_pipe[0]);
    close(out_pipe[1]);
    close(err_pipe[1]);
    free(child_argv);
    free(child_envp);

    SailfinProcessHandle *h = (SailfinProcessHandle *)malloc(sizeof(SailfinProcessHandle));
    if (!h)
    {
        close(in_pipe[1]);
        close(out_pipe[0]);
        close(err_pipe[0]);
        waitpid(pid, NULL, 0);
        return 0;
    }
    h->pid = pid;
    h->stdin_fd = in_pipe[1];
    h->stdout_fd = out_pipe[0];
    h->stderr_fd = err_pipe[0];
    h->stdout_buf = NULL;
    h->stdout_len = 0;
    h->stdout_cap = 0;
    h->stderr_buf = NULL;
    h->stderr_len = 0;
    h->stderr_cap = 0;
    return (int64_t)(intptr_t)h;
}

int64_t sailfin_runtime_process_handle_write(int64_t handle_id, char *data)
{
    SailfinProcessHandle *h = (SailfinProcessHandle *)(intptr_t)handle_id;
    if (!h || h->stdin_fd < 0 || !data)
        return -1;
    size_t total = strlen(data);
    size_t written = 0;
    while (written < total)
    {
        ssize_t n = write(h->stdin_fd, data + written, total - written);
        if (n < 0)
        {
            if (errno == EINTR)
                continue;
            return -1;
        }
        written += (size_t)n;
    }
    return (int64_t)written;
}

void sailfin_runtime_process_handle_close_stdin(int64_t handle_id)
{
    SailfinProcessHandle *h = (SailfinProcessHandle *)(intptr_t)handle_id;
    if (!h || h->stdin_fd < 0)
        return;
    close(h->stdin_fd);
    h->stdin_fd = -1;
}

/* Drain stdout and stderr concurrently into the handle's stash
 * buffers, returning the requested stream. Polling both fds at once
 * is mandatory: a sequential read on one side would let the child
 * block on a full pipe buffer when writing the other side (~64KiB
 * on Linux), deadlocking against the parent's blocking read. The
 * "other" stream's bytes stay in the handle for the matching
 * `_handle_read_*` call. Returns malloc'd NUL-terminated string;
 * caller owns. */
static char *_sfn_handle_drain_one(SailfinProcessHandle *h, bool want_stdout)
{
    while ((want_stdout && h->stdout_fd >= 0) || (!want_stdout && h->stderr_fd >= 0))
    {
        struct pollfd pfds[2];
        int nfds = 0;
        if (h->stdout_fd >= 0)
        {
            pfds[nfds].fd = h->stdout_fd;
            pfds[nfds].events = POLLIN;
            pfds[nfds].revents = 0;
            nfds++;
        }
        if (h->stderr_fd >= 0)
        {
            pfds[nfds].fd = h->stderr_fd;
            pfds[nfds].events = POLLIN;
            pfds[nfds].revents = 0;
            nfds++;
        }
        if (nfds == 0)
            break;
        int pr = poll(pfds, (nfds_t)nfds, -1);
        if (pr < 0)
        {
            if (errno == EINTR)
                continue;
            break;
        }
        for (int i = 0; i < nfds; i++)
        {
            short revents = pfds[i].revents;
            if (revents == 0)
                continue;
            int fd = pfds[i].fd;
            bool is_stdout = (fd == h->stdout_fd);
            char tmp[4096];
            ssize_t n = read(fd, tmp, sizeof(tmp));
            if (n > 0)
            {
                char **buf_pp = is_stdout ? &h->stdout_buf : &h->stderr_buf;
                size_t *len_p = is_stdout ? &h->stdout_len : &h->stderr_len;
                size_t *cap_p = is_stdout ? &h->stdout_cap : &h->stderr_cap;
                size_t needed = *len_p + (size_t)n + 1;
                if (needed > *cap_p)
                {
                    size_t new_cap = *cap_p > 0 ? *cap_p : 4096;
                    while (needed > new_cap)
                        new_cap *= 2;
                    char *r = (char *)realloc(*buf_pp, new_cap);
                    if (!r)
                    {
                        /* OOM — stop draining; whatever we already
                         * stashed will still be returned below. */
                        if (h->stdout_fd >= 0)
                        {
                            close(h->stdout_fd);
                            h->stdout_fd = -1;
                        }
                        if (h->stderr_fd >= 0)
                        {
                            close(h->stderr_fd);
                            h->stderr_fd = -1;
                        }
                        goto drain_done;
                    }
                    *buf_pp = r;
                    *cap_p = new_cap;
                }
                memcpy(*buf_pp + *len_p, tmp, (size_t)n);
                *len_p += (size_t)n;
            }
            else if (n == 0 || (revents & (POLLHUP | POLLERR | POLLNVAL)))
            {
                if (is_stdout)
                {
                    close(h->stdout_fd);
                    h->stdout_fd = -1;
                }
                else
                {
                    close(h->stderr_fd);
                    h->stderr_fd = -1;
                }
            }
            else if (n < 0 && errno != EINTR && errno != EAGAIN)
            {
                if (is_stdout)
                {
                    close(h->stdout_fd);
                    h->stdout_fd = -1;
                }
                else
                {
                    close(h->stderr_fd);
                    h->stderr_fd = -1;
                }
            }
        }
    }
drain_done:;
    char **take_buf = want_stdout ? &h->stdout_buf : &h->stderr_buf;
    size_t *take_len = want_stdout ? &h->stdout_len : &h->stderr_len;
    size_t *take_cap = want_stdout ? &h->stdout_cap : &h->stderr_cap;
    char *result = *take_buf;
    if (!result)
    {
        result = (char *)malloc(1);
        if (result)
            result[0] = '\0';
    }
    else
    {
        if (*take_len + 1 > *take_cap)
        {
            char *r = (char *)realloc(result, *take_len + 1);
            if (r)
                result = r;
        }
        result[*take_len] = '\0';
    }
    *take_buf = NULL;
    *take_len = 0;
    *take_cap = 0;
    return result;
}

char *sailfin_runtime_process_handle_read_stdout(int64_t handle_id)
{
    SailfinProcessHandle *h = (SailfinProcessHandle *)(intptr_t)handle_id;
    if (!h)
    {
        char *r = (char *)malloc(1);
        if (r)
            r[0] = '\0';
        return r;
    }
    return _sfn_handle_drain_one(h, true);
}

char *sailfin_runtime_process_handle_read_stderr(int64_t handle_id)
{
    SailfinProcessHandle *h = (SailfinProcessHandle *)(intptr_t)handle_id;
    if (!h)
    {
        char *r = (char *)malloc(1);
        if (r)
            r[0] = '\0';
        return r;
    }
    return _sfn_handle_drain_one(h, false);
}

int64_t sailfin_runtime_process_handle_wait(int64_t handle_id)
{
    SailfinProcessHandle *h = (SailfinProcessHandle *)(intptr_t)handle_id;
    if (!h)
        return -1;
    if (h->stdin_fd >= 0)
    {
        close(h->stdin_fd);
        h->stdin_fd = -1;
    }
    if (h->stdout_fd >= 0)
    {
        close(h->stdout_fd);
        h->stdout_fd = -1;
    }
    if (h->stderr_fd >= 0)
    {
        close(h->stderr_fd);
        h->stderr_fd = -1;
    }
    int status = 0;
    int64_t result = -1;
    if (waitpid(h->pid, &status, 0) >= 0)
    {
        if (WIFEXITED(status))
            result = (int64_t)WEXITSTATUS(status);
        else if (WIFSIGNALED(status))
            result = (int64_t)(128 + WTERMSIG(status));
        else
            result = 127;
    }
    /* Free any bytes still in the stash from an unmatched
     * `_handle_read_*` (e.g. the caller drained stdout but didn't ask
     * for the stashed stderr). The handle itself goes away below. */
    if (h->stdout_buf)
    {
        free(h->stdout_buf);
        h->stdout_buf = NULL;
    }
    if (h->stderr_buf)
    {
        free(h->stderr_buf);
        h->stderr_buf = NULL;
    }
    free(h);
    return result;
}

#else /* _WIN32 — stubs; the test-infra workstream that consumes these is POSIX-only. */

int64_t sailfin_runtime_process_run_capture(SfnArray *argv, SfnArray *env_flat)
{
    (void)argv;
    (void)env_flat;
    return -1;
}

char *sailfin_runtime_process_capture_take_stdout(void)
{
    char *r = (char *)malloc(1);
    if (r)
        r[0] = '\0';
    return r;
}

char *sailfin_runtime_process_capture_take_stderr(void)
{
    char *r = (char *)malloc(1);
    if (r)
        r[0] = '\0';
    return r;
}

int64_t sailfin_runtime_process_spawn_with_env(SfnArray *argv, SfnArray *env_flat)
{
    (void)argv;
    (void)env_flat;
    return 0;
}

int64_t sailfin_runtime_process_handle_write(int64_t handle_id, char *data)
{
    (void)handle_id;
    (void)data;
    return -1;
}

void sailfin_runtime_process_handle_close_stdin(int64_t handle_id) { (void)handle_id; }

char *sailfin_runtime_process_handle_read_stdout(int64_t handle_id)
{
    (void)handle_id;
    char *r = (char *)malloc(1);
    if (r)
        r[0] = '\0';
    return r;
}

char *sailfin_runtime_process_handle_read_stderr(int64_t handle_id)
{
    (void)handle_id;
    char *r = (char *)malloc(1);
    if (r)
        r[0] = '\0';
    return r;
}

int64_t sailfin_runtime_process_handle_wait(int64_t handle_id)
{
    (void)handle_id;
    return -1;
}

#endif

/*
 * sailfin_runtime_shell_capture
 *
 * Run `cmd` through popen and return its stdout as a freshly-
 * allocated runtime string. Replaces the cross-process-racey pattern
 * `_shell_read_cmd` previously implemented in Sailfin source —
 *
 *   process.run(["sh","-c", cmd + " > /tmp/.sfn_shell_read_cmd_tmp"])
 *   fs.readFile("/tmp/.sfn_shell_read_cmd_tmp")
 *
 * — where every concurrent invocation across a process boundary
 * (xargs-spawned compile workers, parallel `sfn test` invocations,
 * `make compile`'s subprocess-stage import-context) collided on the
 * single fixed tmp path. One process's redirect-truncate would
 * empty another's just-written output mid-flight, producing
 * silently-corrupt env reads, broken cache hashes, and ultimately
 * `clang: error: no such file or directory: build/sailfin/capsules/<slug>.ll`
 * at link time when the cache key drifted away from the real input.
 *
 * Allocation lifetime matches the existing `_popen_read_all`-using
 * helpers (`sailfin_runtime_http_get`, etc.): the buffer is
 * `_rt_calloc`-routed via `_runtime_enter` so arena mode reclaims it
 * in bulk, and malloc mode owns it through the runtime's standard
 * lifecycle. Callers must not free.
 *
 * Empty output is returned as a freshly-allocated empty string (not
 * NULL) so Sailfin-side `.length == 0` checks behave identically
 * to the pre-existing `_shell_read_cmd` contract.
 */
static char *_popen_read_all(const char *cmd);

/*
 * Static empty-string fallback for `sailfin_runtime_shell_capture`'s
 * OOM paths. The Sailfin caller treats the return value as a
 * `string` (i8*) and immediately reads `.length` / iterates over it;
 * returning NULL would crash the trim loop in
 * `_shell_read_cmd` / `_cr_shell_read`. A static `""` is safe under
 * either allocator mode — the caller never frees it (string_drop is
 * a no-op for `mark_persistent`-style pointers, and arena mode skips
 * free entirely), and even if a future caller did free it, the C
 * heap-validator catches that as a clear "tried to free a static"
 * abort, not a silent corruption. The address is unique and stable,
 * so equality checks against this sentinel keep working.
 */
static char _sailfin_runtime_shell_capture_empty[1] = { '\0' };

char *sailfin_runtime_shell_capture(char *cmd)
{
    _runtime_enter();
    if (!cmd)
    {
        return _sailfin_runtime_shell_capture_empty;
    }
    char *captured = _popen_read_all(cmd);
    if (!captured)
    {
        return _sailfin_runtime_shell_capture_empty;
    }
    /* `_popen_read_all` returns malloc-allocated memory for legacy
     * compatibility with `sailfin_runtime_http_*`. Copy into the
     * runtime allocator so arena mode can reclaim it; malloc mode's
     * `_rt_calloc` is just a `calloc`, so the copy is the only
     * change in cost. */
    size_t len = strlen(captured);
    char *out = (char *)_rt_calloc(1, len + 1);
    if (!out)
    {
        /* OOM during the rt-side copy — fall through to the static
         * empty string so the Sailfin caller never sees NULL. */
        free(captured);
        return _sailfin_runtime_shell_capture_empty;
    }
    memcpy(out, captured, len);
    free(captured);
    return out;
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

void *sailfin_adapter_fs_read_file(void *path)
{
    _runtime_enter();
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
    _runtime_enter();
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
    _runtime_enter();
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
    _runtime_enter();
    const char *path_str = (const char *)path;
    if (!path_str)
    {
        return false;
    }
    struct stat st;
    return stat(path_str, &st) == 0;
}

/* ------------------------------------------------------------------ */
/* P5 (#366): Filesystem stdlib gap-fill — perms / mkdtemp /          */
/* symlink / is_executable. POSIX-only; Windows stubs return a        */
/* benign failure code so callers under WSL/MSYS see a consistent     */
/* "not supported" result rather than a link-time miss.               */
/* ------------------------------------------------------------------ */

/* fs.set_perms(path, mode) — `chmod(2)` equivalent. Returns true on  */
/* success, false on any error. `mode` is interpreted as the POSIX    */
/* permission bits (lower 12 bits of `mode_t`); higher bits are       */
/* masked off before the syscall to keep the surface narrow.          */
bool sailfin_adapter_fs_set_perms(void *path, int64_t mode)
{
    _runtime_enter();
    const char *path_str = (const char *)path;
    if (!path_str)
    {
        return false;
    }
#if defined(_WIN32)
    (void)mode;
    return false;
#else
    mode_t masked = (mode_t)(mode & 07777);
    return chmod(path_str, masked) == 0;
#endif
}

/* fs.get_perms(path) — returns the lower 12 bits of `st_mode`        */
/* (perm + sticky/setuid/setgid). Returns -1 on any error. The        */
/* 12-bit mask matches `stat -c '%a'` and Rust's                      */
/* `Permissions::mode() & 0o7777` convention.                         */
int64_t sailfin_adapter_fs_get_perms(void *path)
{
    _runtime_enter();
    const char *path_str = (const char *)path;
    if (!path_str)
    {
        return -1;
    }
    struct stat st;
    if (stat(path_str, &st) != 0)
    {
        return -1;
    }
    return (int64_t)(st.st_mode & 07777);
}

/* fs.mkdtemp(prefix) — uses `mkdtemp(3)` so the kernel guarantees a  */
/* unique name. The returned path is allocated via `malloc` and owned */
/* by the Sailfin caller; mode is `0700` per `mkdtemp` semantics.     */
/* Returns an empty malloc'd string on error (the Sailfin caller can  */
/* check for zero length).                                            */
void *sailfin_adapter_fs_mkdtemp(void *prefix)
{
    _runtime_enter();
    const char *prefix_str = prefix ? (const char *)prefix : "";
#if defined(_WIN32)
    /* Windows lacks mkdtemp; the issue scopes this to POSIX.         */
    char *empty = (char *)malloc(1);
    if (empty)
    {
        empty[0] = '\0';
    }
    return empty;
#else
    /* Determine the parent directory. If `prefix` is absolute or     */
    /* contains a `/`, treat it as a full template prefix; otherwise  */
    /* anchor under `$TMPDIR` (or `/tmp`).                            */
    const char *tmpdir = NULL;
    bool has_dir = false;
    for (const char *p = prefix_str; *p; p++)
    {
        if (*p == '/')
        {
            has_dir = true;
            break;
        }
    }
    if (!has_dir)
    {
        tmpdir = getenv("TMPDIR");
        if (!tmpdir || tmpdir[0] == '\0')
        {
            tmpdir = "/tmp";
        }
    }

    size_t prefix_len = strlen(prefix_str);
    size_t dir_len = tmpdir ? strlen(tmpdir) : 0;
    /* Layout: [dir] [/] [prefix] [XXXXXX] [\0]                       */
    size_t needed = dir_len + (dir_len > 0 ? 1 : 0) + prefix_len + 6 + 1;
    char *template_buf = (char *)malloc(needed);
    if (!template_buf)
    {
        char *empty = (char *)malloc(1);
        if (empty)
        {
            empty[0] = '\0';
        }
        return empty;
    }
    size_t off = 0;
    if (dir_len > 0)
    {
        memcpy(template_buf + off, tmpdir, dir_len);
        off += dir_len;
        template_buf[off++] = '/';
    }
    memcpy(template_buf + off, prefix_str, prefix_len);
    off += prefix_len;
    memcpy(template_buf + off, "XXXXXX", 6);
    off += 6;
    template_buf[off] = '\0';

    char *created = mkdtemp(template_buf);
    if (!created)
    {
        free(template_buf);
        char *empty = (char *)malloc(1);
        if (empty)
        {
            empty[0] = '\0';
        }
        return empty;
    }
    /* `mkdtemp` returns the same buffer it mutated in place.         */
    return created;
#endif
}

/* fs.is_executable(path) — true iff the current process has         */
/* execute access. Maps to `access(path, X_OK)`. Missing files and   */
/* permission errors both collapse to `false` per the issue spec.    */
bool sailfin_adapter_fs_is_executable(void *path)
{
    _runtime_enter();
    const char *path_str = (const char *)path;
    if (!path_str)
    {
        return false;
    }
#if defined(_WIN32)
    return false;
#else
    return access(path_str, X_OK) == 0;
#endif
}

/* fs.symlink(target, link) — creates `link` pointing at `target`.   */
/* Per POSIX, the target need not exist; dangling symlinks are       */
/* valid. Returns true on success.                                    */
bool sailfin_adapter_fs_symlink(void *target, void *link)
{
    _runtime_enter();
    const char *target_str = (const char *)target;
    const char *link_str = (const char *)link;
    if (!target_str || !link_str)
    {
        return false;
    }
#if defined(_WIN32)
    return false;
#else
    return symlink(target_str, link_str) == 0;
#endif
}

/* ------------------------------------------------------------------ */
/* Phase 5a: arena mark / rewind                                      */
/* ------------------------------------------------------------------ */

/*
 * Encode an SfnArenaMark into a Sailfin `number` (LLVM `double`).
 * Sailfin's runtime-helper-descriptor mechanism passes scalars
 * through; structs would require ABI work the seed compiler isn't
 * ready for. `double` has a 53-bit mantissa, so any integer up to
 * 2^53 round-trips losslessly.
 *
 * Encoding: page_index * 2^32 + used. The value 0 therefore means
 * "page 0, used 0" — a partial reset. A null page (arena disabled
 * / never allocated) encodes as 0 and round-trips harmlessly:
 * rewind on a disabled arena is a no-op.
 */
double sailfin_intrinsic_runtime_arena_mark(void)
{
    _runtime_enter();
    if (!sfn_arena_enabled())
        return 0.0;

    SfnArena *arena = sfn_arena_global();
    SfnArenaMark mark = sfn_arena_mark(arena);
    if (!mark.page)
        return 0.0;

    /* Find the index of the marked page. */
    int64_t page_index = 0;
    for (SfnArenaPage *p = arena->first; p; p = p->next)
    {
        if (p == mark.page)
            break;
        page_index++;
    }
    int64_t encoded = (page_index << 32) | (int64_t)(mark.used & 0xFFFFFFFFu);
    return (double)encoded;
}

void sailfin_intrinsic_runtime_arena_rewind(double encoded_mark)
{
    _runtime_enter();
    if (!sfn_arena_enabled())
        return;

    SfnArena *arena = sfn_arena_global();
    if (!arena || !arena->first)
        return;

    int64_t encoded = (int64_t)encoded_mark;
    int64_t page_index = encoded >> 32;
    size_t used = (size_t)(encoded & 0xFFFFFFFFu);

    /* Walk to the marked page. If page_index is out of range
     * (corrupt mark, arena reset between mark/rewind, etc.) bail
     * silently — better than crashing. */
    SfnArenaPage *page = arena->first;
    int64_t i = 0;
    while (page && i < page_index)
    {
        page = page->next;
        i++;
    }
    if (!page)
        return;

    SfnArenaMark mark;
    mark.page = page;
    mark.used = used;
    sfn_arena_rewind(arena, mark);
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

/* M2.8b (#726): SfnString aggregate ABI for `env.get` / `env.home`.
 * The runtime_helpers.sfn descriptors carry
 * `parameter_types: ["{i8*, i64}", "ptr"]` (env.get) /
 * `parameter_types: ["ptr"]` (env.home) and
 * `return_type: "{i8*, i64}"`. The compiler's call-site dispatch
 * splices `ptr @sfn_default_arena` as the trailing arg (mirrors
 * `sfn_str_concat` from #714); the bodies below NUL-marshal the
 * name through the arena and wrap the libc result via
 * `sfn_str_from_cstr` + `sfn_str_len`. The legacy
 * `sailfin_runtime_getenv` / `sailfin_runtime_home_dir` entrypoints
 * stay exported above so seed-built IR (which still emits the legacy
 * `i8*` ABI) keeps linking through the 2-pass self-host build. */
SfnString sfn_getenv(SfnString name, SfnArena **arena_slot)
{
    SfnString result = {NULL, 0};
    if (name.data == NULL || name.len <= 0)
        return result;

    /* Resolve arena — mirrors `sfn_str_concat`'s slot/fallback gate. */
    SfnArena *arena;
    if (arena_slot != NULL && *arena_slot != NULL)
    {
        arena = *arena_slot;
    }
    else
    {
        arena = sfn_arena_global();
        if (arena_slot != NULL && *arena_slot == NULL)
        {
            *arena_slot = arena;
        }
    }

    /* Decode pre-M1.A.2 tagged immediate-codepoint inputs into a
     * stack buffer before the memcpy, mirroring `sfn_str_concat`'s
     * handling: single-codepoint "strings" (e.g. literal `"X"`) are
     * lowered to `((uint64_t)codepoint << 32)` rather than a real
     * pointer; dereferencing `name.data` directly would segfault.
     * `_utf8_encode` writes 1-4 UTF-8 bytes for the codepoint and
     * the byte length matches what `sfn_str_len` returned at the
     * call site. */
    unsigned char name_imm_buf[5] = {0};
    const char *name_data = name.data;
    uint32_t name_cp = 0;
    if (_is_immediate_codepoint_string(name.data, &name_cp))
    {
        _utf8_encode(name_cp, name_imm_buf);
        name_data = (const char *)name_imm_buf;
    }

    /* NUL-marshal `name` into the arena so getenv() sees a clean C
     * string regardless of the aggregate's NUL invariant. Today's
     * SfnString.data is NUL-terminated (literal lowering writes a
     * trailing 0; arena-routed concat preserves it), but the spec'd
     * invariant only covers `len` bytes — copying through the arena
     * keeps the contract independent of the data slot's terminator. */
    size_t nlen = (size_t)name.len;
    char *cname = (char *)sfn_arena_alloc(arena, nlen + 1, 1);
    if (cname == NULL)
        return result;
    if (nlen > 0)
        memcpy(cname, name_data, nlen);
    cname[nlen] = '\0';

    const char *val = getenv(cname);
    if (val == NULL)
        return result;

    /* Wrap the libc-owned pointer via `sfn_str_from_cstr` (identity
     * bridge in the M2.4a wave). `getenv()` guarantees a
     * NUL-terminated buffer stable until the next mutating call on
     * the same key, so the aggregate's data slot keeps the
     * literal/concat NUL-termination invariant. Length recovered via
     * `sfn_str_len` (the `native_signature` flip from M2.4a routes
     * through `sailfin_runtime_string_length` for safe walking). */
    const char *wrapped = sfn_str_from_cstr(val);
    result.data = (char *)wrapped;
    result.len = sfn_str_len(wrapped);
    return result;
}

SfnString sfn_home_dir(SfnArena **arena_slot)
{
#if defined(_WIN32)
    static const char k_home_name[] = "USERPROFILE";
#else
    static const char k_home_name[] = "HOME";
#endif
    SfnString name;
    name.data = (char *)k_home_name;
    name.len = (int64_t)(sizeof(k_home_name) - 1);
    return sfn_getenv(name, arena_slot);
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

void *sailfin_runtime_to_debug_string(void *value)
{
    return value;
}

void sailfin_runtime_raise_value_error(void *message)
{
    _print_line(stderr, "[value_error] ", (const char *)message);
    abort();
}

/* Wrapper: the compiler emits calls to runtime_raise_value_error_fn when the
 * runtime helper symbol resolution doesn't fire (e.g. in test lowering). */
void runtime_raise_value_error_fn(void *message)
{
    sailfin_runtime_raise_value_error(message);
}

/* sailfin_assert_fail — structured assertion-failure record writer.
 *
 * Wire format (newline-delimited key:value, ASCII / UTF-8, NUL-free):
 *
 *   line 1: "SFAF"            (magic; sentinel for the runner's reader)
 *   line 2: "v:1"             (format version; future readers gate on it)
 *   line 3: "file:<path>"     (test source path; may be empty)
 *   line 4: "line:<decimal>"  (signed decimal line number, 1-based)
 *   line 5: "col:<decimal>"   (signed decimal column, 1-based)
 *   line 6: "msg:<text>"      (assertion message; UTF-8, no embedded \n)
 *
 * Each line is terminated with a single '\n'. The record is
 * NUL-free on purpose: the test runner reads the file via
 * `fs.readFile`, which goes through Sailfin's NUL-terminated string
 * ABI. A length-prefixed binary record would survive `read(2)` but
 * be truncated at the first 0x00 inside any little-endian integer
 * field. Text avoids that whole class of bug; ints are still
 * unambiguous because every line has an explicit key prefix and the
 * value is bounded by the next '\n'. Forward-compat is via the
 * version line: readers that don't recognise `v:N` skip the record
 * entirely instead of misinterpreting unknown fields.
 *
 * Sink resolution (first match wins):
 *   1. SAILFIN_TEST_FAIL_FD set to a writable fd (parent opens before
 *      spawn; child inherits the fd unchanged via posix_spawnp).
 *   2. ${SAILFIN_TEST_SCRATCH}/fail.bin (append).
 *   3. No sink → caller is not a test runner; write nothing. The
 *      diagnostic still hits stderr via sailfin_runtime_raise_value_error
 *      and the process aborts — same observable behavior as before.
 *
 * Append mode is intentional: a single test process that triggers
 * multiple `assert false` calls before aborting will leave one
 * record per call, in order. The runner reads the first valid one
 * (consistent with C's "first crash wins" stack-unwind expectation).
 */
static FILE *_sfn_open_assert_fail_sink(int *out_fd_borrowed)
{
    /* Returns a FILE* the caller must fclose unless `*out_fd_borrowed`
     * is non-zero, in which case the caller must `fflush` only —
     * closing would close the parent's fd. */
    *out_fd_borrowed = 0;
    const char *fd_env = getenv("SAILFIN_TEST_FAIL_FD");
    if (fd_env && *fd_env)
    {
        char *end = NULL;
        long parsed = strtol(fd_env, &end, 10);
        if (end != fd_env && parsed >= 0 && parsed <= 65535)
        {
#if defined(_WIN32)
            FILE *fp = _fdopen((int)parsed, "ab");
#else
            FILE *fp = fdopen((int)parsed, "ab");
#endif
            if (fp)
            {
                *out_fd_borrowed = 1;
                return fp;
            }
        }
    }
    const char *scratch = getenv("SAILFIN_TEST_SCRATCH");
    if (scratch && *scratch)
    {
        size_t need = strlen(scratch) + sizeof("/fail.bin");
        char *path = (char *)malloc(need);
        if (!path)
            return NULL;
        snprintf(path, need, "%s/fail.bin", scratch);
        FILE *fp = fopen(path, "ab");
        free(path);
        return fp;
    }
    return NULL;
}

/* Replace any '\n' in `s` with ' ' so the value cannot leak across
 * record-line boundaries. Returns a freshly-malloc'd buffer the
 * caller must free, or NULL on allocation failure. */
static char *_sfn_strip_newlines(const char *s)
{
    if (!s)
        s = "";
    size_t n = strlen(s);
    char *out = (char *)malloc(n + 1);
    if (!out)
        return NULL;
    for (size_t i = 0; i < n; i++)
    {
        char c = s[i];
        out[i] = (c == '\n' || c == '\r') ? ' ' : c;
    }
    out[n] = '\0';
    return out;
}

void sailfin_assert_fail(const char *file, int64_t line, int64_t col, const char *msg)
{
    int fd_borrowed = 0;
    FILE *sink = _sfn_open_assert_fail_sink(&fd_borrowed);
    if (sink)
    {
        char *file_clean = _sfn_strip_newlines(file ? file : "");
        char *msg_clean = _sfn_strip_newlines(msg ? msg : "assertion failed");
        if (file_clean && msg_clean)
        {
            fprintf(
                sink,
                "SFAF\nv:1\nfile:%s\nline:%lld\ncol:%lld\nmsg:%s\n",
                file_clean,
                (long long)line,
                (long long)col,
                msg_clean);
        }
        free(file_clean);
        free(msg_clean);
        fflush(sink);
        if (!fd_borrowed)
            fclose(sink);
    }
    sailfin_runtime_raise_value_error((void *)(msg ? msg : "assertion failed"));
}

/* Sailfin-callable trampoline: the parser emits
 *   runtime_assert_fail_fn(file, line, col, msg)
 * with line/col passed as Sailfin `number` (LLVM `double`). The
 * spec-defined symbol (`sailfin_assert_fail`) takes int64_t, so we
 * clamp/convert here. Mirrors `substring_unchecked`'s double→i64
 * trampoline. The descriptor is kept on `double` so the seed-compiled
 * compiler binary (which still embeds assert calls with double-coerced
 * line/col) links cleanly; Slice E.3b's (#556) boundary-mode refusal
 * is intentionally asymmetric (only `float → int` is fatal) so the
 * `int → double` silent widening of integer line/col literals at the
 * call site continues to compile. */
void runtime_assert_fail_fn(const char *file, double line, double col, const char *msg)
{
    sailfin_assert_fail(file, _clamp_to_i64(line), _clamp_to_i64(col), msg);
}

/* Wrapper: the compiler may emit calls to substring_unchecked with double
 * params (Sailfin number type) instead of i64.  Forward to the real impl.
 * Guards against UB from NaN/out-of-range double→int64_t casts. */
static int64_t _clamp_to_i64(double v)
{
    if (v != v)
        return 0; /* NaN */
    if (v < (double)INT64_MIN)
        return INT64_MIN;
    if (v > (double)INT64_MAX)
        return INT64_MAX;
    return (int64_t)v;
}

char *substring_unchecked(char *text, double start, double end)
{
    return sailfin_runtime_substring_unchecked(text, _clamp_to_i64(start), _clamp_to_i64(end));
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

/* =====================================================================
 * M1.B v2 array helpers — accept the SfnArray ABI (`{T*, i64, i64}*`)
 * and use only plain malloc/realloc for backing storage. The legacy
 * `_alloc_array` / `_array_check_canary` / hidden-header path stays
 * exclusively bound to the `SailfinPtrArray` entrypoints above; v2
 * callers (post-#393 compiler IR) never touch it. The bodies are
 * intentionally simple — once the legacy entrypoints retire (M3 per
 * docs/runtime_architecture.md §2.3), these can absorb any growth-
 * amortization heuristics that the hidden-header path used to
 * provide. For now linear copy on concat / doubling on push is
 * sufficient for the workloads new-compiler IR exercises.
 * ===================================================================== */

static SfnArray *_sfn_array_alloc_v2(int64_t initial_cap, size_t elem_size)
{
    SfnArray *out = (SfnArray *)_rt_malloc(sizeof(SfnArray));
    if (!out)
    {
        return NULL;
    }
    out->data = NULL;
    out->len = 0;
    out->cap = 0;
    if (initial_cap > 0)
    {
        size_t bytes = (size_t)initial_cap * elem_size;
        if (elem_size != 0 && bytes / elem_size != (size_t)initial_cap)
        {
            /* multiplication overflow — free the struct so malloc-mode
             * doesn't leak. `_rt_free` is a no-op under arena mode. */
            _rt_free(out);
            return NULL;
        }
        out->data = _rt_calloc((size_t)initial_cap, elem_size);
        if (!out->data)
        {
            _rt_free(out);
            return NULL;
        }
        out->cap = initial_cap;
    }
    return out;
}

SfnArray *sailfin_runtime_concat_v2(SfnArray *a, SfnArray *b)
{
    int64_t alen = (a && a->len > 0) ? a->len : 0;
    int64_t blen = (b && b->len > 0) ? b->len : 0;
    int64_t total = alen + blen;
    SfnArray *out = _sfn_array_alloc_v2(total, sizeof(char *));
    if (!out)
    {
        return NULL;
    }
    out->len = total;
    char **buf = (char **)out->data;
    if (buf)
    {
        if (a && a->data)
        {
            char **adata = (char **)a->data;
            for (int64_t i = 0; i < alen; i++)
            {
                buf[i] = adata[i];
            }
        }
        if (b && b->data)
        {
            char **bdata = (char **)b->data;
            for (int64_t j = 0; j < blen; j++)
            {
                buf[alen + j] = bdata[j];
            }
        }
    }
    return out;
}

/* M5.3 (#471): emit an uncaught-panic message and newline to stderr,
 * then flush. The emitted `@main` wrapper invokes this from its catch
 * landing pad before returning exit code 1 — equivalent in effect to
 * `sailfin_runtime_print_err` but kept under a dedicated symbol so the
 * IO-flip pin in test_runtime_io_extended.sh (which forbids
 * `sailfin_runtime_print_*` references in user IR after the SfnString
 * migration) doesn't have to whitelist the wrapper's call site. */
void sailfin_runtime_panic_emit(char *msg)
{
    if (msg)
    {
        fputs(msg, stderr);
        fputc('\n', stderr);
        fflush(stderr);
    }
}

/* M5.3 (#471): build a Sailfin `string[]` (SfnArray of `char*`) from
 * the C `(argc, argv)` the emitted `@main` wrapper receives. Pointer-
 * copies argv[0..argc) without `strdup` — the C runtime keeps these
 * strings live for the lifetime of `main`, and `main` cannot outlive
 * them. argv[0] (the program name) is preserved so user code sees the
 * standard C convention; the compiler's own `sailfin_cli_main_with_paths`
 * (M5.4 caller) will strip it if it wants the bare argument list. */
SfnArray *sailfin_runtime_argv_to_string_array(int argc, char **argv)
{
    /* Defensive: a NULL argv with argc > 0 would leave the resulting
     * SfnArray with `len = argc` and NULL element pointers, which the
     * user's `argv[i]` deref would then segfault on. Clamp argc to 0
     * when argv is NULL so callers always observe a consistent
     * (empty) array instead. */
    if (argc < 0 || argv == NULL)
    {
        argc = 0;
    }
    SfnArray *arr = _sfn_array_alloc_v2((int64_t)argc, sizeof(char *));
    if (!arr)
    {
        return NULL;
    }
    arr->len = (int64_t)argc;
    if (argc > 0 && arr->data && argv)
    {
        char **dest = (char **)arr->data;
        for (int i = 0; i < argc; i++)
        {
            dest[i] = argv[i];
        }
    }
    return arr;
}

SfnArray *sailfin_runtime_append_string_v2(SfnArray *a, char *text)
{
    _runtime_enter(); // #892: bump seq to invalidate the concat-reuse window
    if (!a)
    {
        a = _sfn_array_alloc_v2(0, sizeof(char *));
        if (!a)
        {
            return NULL;
        }
    }
    int64_t len = a->len < 0 ? 0 : a->len;
    int64_t cap = a->cap < 0 ? 0 : a->cap;
    if (len >= cap)
    {
        /* Take `max(cap*2, len+1, 8)` so a corrupted `len > cap` state
         * (e.g., ABI mismatch) can't realloc to a too-small buffer
         * and then write past the new tail. The doubling overflow
         * guard catches `cap * 2` wrapping past INT64_MAX. */
        int64_t doubled = cap < 8 ? 8 : cap * 2;
        if (doubled < cap)
        {
            return NULL;
        }
        int64_t need = len + 1;
        int64_t new_cap = doubled > need ? doubled : need;
        if (new_cap < 0 || (size_t)new_cap > SIZE_MAX / sizeof(char *))
        {
            return NULL; /* multiplication overflow */
        }
        size_t old_bytes = (size_t)cap * sizeof(char *);
        size_t new_bytes = (size_t)new_cap * sizeof(char *);
        void *new_data = _rt_realloc(a->data, old_bytes, new_bytes);
        if (!new_data)
        {
            return NULL;
        }
        /* Zero the freshly grown tail so unused slots read as NULL. */
        memset((char *)new_data + old_bytes, 0, new_bytes - old_bytes);
        a->data = new_data;
        a->cap = new_cap;
    }
    ((char **)a->data)[len] = text;
    a->len = len + 1;
    return a;
}

char *sailfin_runtime_array_push_slot_v2(void **data_ptr, int64_t *len_ptr,
                                         int64_t *cap_ptr, int64_t elem_size)
{
    _runtime_enter(); // #892: bump seq to invalidate the concat-reuse window
    if (!data_ptr || !len_ptr || !cap_ptr)
    {
        return NULL;
    }
    if (elem_size <= 0 || elem_size > (int64_t)(1024 * 1024))
    {
        return NULL;
    }
    int64_t len = *len_ptr;
    int64_t cap = *cap_ptr;
    if (len < 0)
    {
        len = 0;
        *len_ptr = 0;
    }
    if (cap < 0)
    {
        cap = 0;
        *cap_ptr = 0;
    }
    if (len >= cap)
    {
        /* Take `max(cap*2, len+1, 8)`. `len > cap` shouldn't happen
         * under normal compiler emission, but a corrupted struct
         * (uninitialized cap, ABI mismatch with seed-compiled IR)
         * would otherwise let the slot at `[len]` land past the
         * realloc'd buffer's end. The grow rule guarantees
         * `new_cap >= len + 1` so the write below is in-bounds. */
        int64_t doubled = cap < 8 ? 8 : cap * 2;
        if (doubled < cap)
        {
            return NULL;
        }
        int64_t need = len + 1;
        int64_t new_cap = doubled > need ? doubled : need;
        if (new_cap < 0 || (size_t)new_cap > SIZE_MAX / (size_t)elem_size)
        {
            return NULL; /* multiplication overflow */
        }
        size_t old_bytes = (size_t)cap * (size_t)elem_size;
        size_t new_bytes = (size_t)new_cap * (size_t)elem_size;
        void *new_data = _rt_realloc(*data_ptr, old_bytes, new_bytes);
        if (!new_data)
        {
            return NULL;
        }
        memset((char *)new_data + old_bytes, 0, new_bytes - old_bytes);
        *data_ptr = new_data;
        *cap_ptr = new_cap;
        cap = new_cap;
    }
    char *base = (char *)(*data_ptr);
    char *slot = base + (size_t)len * (size_t)elem_size;
    *len_ptr = len + 1;
    return slot;
}

/* =====================================================================
 * M2.6 (#399) — `sfn_array_*` C trampolines.
 *
 * The compiler's `runtime_helpers.sfn` registry and the direct emission
 * sites in `compiler/src/llvm/expression_lowering/arrays.sfn` flipped
 * from `sailfin_runtime_(concat|append_string|array_push_slot)_v2` to
 * the canonical `sfn_array_*` names. These trampolines are the link
 * targets — every test binary already pulls
 * `runtime/native/src/<star>.c` via `_clang_link_test_cmd_with_deps`,
 * so placing the bare names here makes them resolvable everywhere
 * without wiring the runtime/sfn/<star>.o files into the test linker
 * (a separate Stage D workstream). They mirror the M2.4a string
 * trampolines in this same file (`sfn_str_len` / `sfn_str_eq` /
 * `sfn_str_slice` at lines 2107-2120) which the M2.4a string-module
 * proof-of-life under `runtime/sfn/string.sfn` shadows under
 * `sfn_str_sfn_*`. The Sailfin side at `runtime/sfn/array.sfn`
 * carries the same bodies under `sfn_array_sfn_*` — when M3 retires
 * these trampolines, the Sailfin module's exports rename to the
 * bare canonical form in a single rollback-safe PR.
 * ===================================================================== */

SfnArray *sfn_array_concat(SfnArray *a, SfnArray *b)
{
    /* Today's compiler-emitted call is 2-arg (matches the M1.B `_v2`
     * shape pre-#399); the registry's `parameter_types` for `concat`
     * still emits `declare ... @sfn_array_concat({...}*, {...}*)`,
     * so this trampoline keeps the 2-arg contract to avoid the UB
     * that would otherwise arise from a 2-arg call landing on a
     * 4-arg definition. The architect spec's
     * `(elem_size, *Arena)` shape (§2.3) belongs on a future
     * `sfn_array_concat_v3` (or the M3 in-place rewrite) once the
     * compiler threads arena pointers through array-allocation
     * sites. The Sailfin proof-of-life surface in
     * `runtime/sfn/array.sfn::sfn_array_sfn_concat` keeps the 4-arg
     * spec signature so the migration unit stays visible at the
     * Sailfin layer; that body retires alongside this trampoline
     * when the spec form lights up. */
    return sailfin_runtime_concat_v2(a, b);
}

SfnArray *sfn_array_push_string(SfnArray *a, char *text)
{
    /* Drop-in replacement for `sailfin_runtime_append_string_v2`;
     * emitted by `lower_array_push_in_place` for the `i8*`-element
     * fast path. #892: bump at this emitter boundary so the seq
     * advances even though the delegate also enters. */
    _runtime_enter();
    return sailfin_runtime_append_string_v2(a, text);
}

char *sfn_array_push_slot(void **data_ptr, int64_t *len_ptr,
                          int64_t *cap_ptr, int64_t elem_size)
{
    /* Drop-in replacement for `sailfin_runtime_array_push_slot_v2`;
     * emitted by `lower_array_push_in_place` for typed-element pushes
     * (every non-`i8*` element type, e.g. `Token` during lexing).
     * #892: bump at this emitter boundary so the seq advances even
     * though the delegate also enters. */
    _runtime_enter();
    return sailfin_runtime_array_push_slot_v2(data_ptr, len_ptr,
                                              cap_ptr, elem_size);
}

SfnArray *sfn_array_create(int64_t cap, int64_t elem_size, void *arena)
{
    /* Stub matching the spec ABI. The first compiler-emitted callers
     * land in M2.7 when array-literal lowering flips from
     * `sailfin_runtime_alloc_struct` to this path. Today it returns
     * NULL — calling it from user code surfaces immediately at the
     * next push/concat. */
    (void)cap;
    (void)elem_size;
    (void)arena;
    return NULL;
}

void sfn_array_push(SfnArray *arr, void *elem_ptr, int64_t elem_size,
                    void *arena)
{
    /* Stub. Compiler emission today routes through `sfn_array_push_slot`
     * (the slot-returning helper above); the spec-aligned by-value
     * push lights up post-closures-with-capture. #892: honor the seq-bump
     * invariant up front so the by-value path is safe when it lights up. */
    _runtime_enter();
    (void)arr;
    (void)elem_ptr;
    (void)elem_size;
    (void)arena;
}

void *sfn_array_slice(SfnArray *arr, int64_t start, int64_t end)
{
    /* Stub returning the input pointer untouched. Real slice
     * materialisation happens once `SfnSlice` lands as a Sailfin
     * operand type. */
    (void)start;
    (void)end;
    return arr;
}

SfnArray *sfn_array_map(SfnArray *arr)
{
    /* Closure-gated per §2.3.3. Matches the prelude's existing
     * `array.map` behaviour (returns input unchanged) until
     * closures-with-capture lights up real bodies. */
    return arr;
}

SfnArray *sfn_array_filter(SfnArray *arr) { return arr; }

void *sfn_array_reduce(SfnArray *arr, void *init)
{
    /* Closure-gated. Returns `init` to match the prelude's existing
     * `array.reduce` shape. */
    (void)arr;
    return init;
}

double sailfin_runtime_process_run_v2(SfnArray *argv)
{
    /* The legacy body reads `data` / `len` only — no hidden-header
     * lookups, no canary checks. Stack-temp a SailfinPtrArray that
     * mirrors the SfnArray's data pointer and length so we can reuse
     * the legacy implementation without duplicating the fork/exec
     * logic. The temp lives only on this frame; we never let the
     * legacy body grow or reallocate it. */
    if (!argv)
    {
        return 127.0;
    }
    SailfinPtrArray temp;
    temp.data = (char **)argv->data;
    temp.len = argv->len;
    return sailfin_runtime_process_run(&temp);
}

#if defined(_WIN32)
/* M2.9 (#405): on Windows the Sailfin-native `sfn_process_run` in
 * `runtime/sfn/process.sfn` cannot link — its body calls
 * `posix_spawnp` + `waitpid`, neither of which mingw-w64 provides.
 * The cross-windows Makefile path intentionally skips compiling
 * `process.sfn`; this C wrapper provides the same symbol so the
 * compiler's runtime-helper descriptor (which redirects
 * `process.run` to `@sfn_process_run` via `native_signature`)
 * still resolves on Windows. The wrapper forwards to the existing
 * `_v2` entrypoint, which in turn dispatches to the legacy
 * `CreateProcessA`-based body inside `sailfin_runtime_process_run`.
 *
 * Both Sailfin and C definitions cannot coexist on the same
 * platform without a duplicate-symbol link error, hence the
 * `#if defined(_WIN32)` guard — on POSIX the Sailfin file owns
 * the symbol; on Windows the C wrapper does. */
double sfn_process_run(SfnArray *argv)
{
    return sailfin_runtime_process_run_v2(argv);
}
#endif

void sailfin_adapter_fs_write_lines_v2(void *path, SfnArray *lines)
{
    /* Same shim strategy as `process_run_v2` — legacy body only reads
     * data/len, stack-temp a SailfinPtrArray and forward. */
    if (!lines)
    {
        return;
    }
    SailfinPtrArray temp;
    temp.data = (char **)lines->data;
    temp.len = lines->len;
    sailfin_adapter_fs_write_lines(path, &temp);
}

SfnArray *sailfin_adapter_fs_list_directory_v2(void *path)
{
    /* Production path: build the SfnArray fresh with malloc-backed
     * storage. Mirrors the legacy `sailfin_adapter_fs_list_directory`
     * behaviour (sorted entry names, omits "." and "..") but never
     * routes through `_alloc_array` / hidden header / canary slots. */
    const char *path_str = (const char *)path;
    if (!path_str || path_str[0] == '\0')
    {
        path_str = ".";
    }

    DIR *dir = opendir(path_str);
    if (!dir)
    {
        return _sfn_array_alloc_v2(0, sizeof(char *));
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
                for (size_t i = 0; i < len; i++)
                {
                    free(names[i]);
                }
                free(names);
                closedir(dir);
                return NULL;
            }
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

    SfnArray *out = _sfn_array_alloc_v2((int64_t)len, sizeof(char *));
    if (!out)
    {
        for (size_t i = 0; i < len; i++)
        {
            free(names[i]);
        }
        free(names);
        return NULL;
    }
    char **out_data = (char **)out->data;
    for (size_t i = 0; i < len; i++)
    {
        if (out_data)
        {
            out_data[i] = names[i];
        }
    }
    out->len = (int64_t)len;
    free(names);
    return out;
}
