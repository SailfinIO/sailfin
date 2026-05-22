---
title: Runtime ABI
description: Sailfin's native runtime ABI specification.
section: reference
sidebar:
  order: 7
---

## Goals

- Performance-first data layouts.
- Stable, versioned ABI — a coarse `i32` version counter plus a
  fine-grained `i64` FNV-1a hash over the locked aggregate layouts.
  The runtime refuses to start if a linked module disagrees with the
  runtime's expected version or hash. See
  [ABI Versioning](#abi-versioning) for the link-time contract.
- Zero-copy slices.
- Clear interop boundaries for FFI.

## Core Data Layouts

### SfnString — `{ i8*, i64 }`

```llvm
%SfnString = type { i8*, i64 }   ; { data, length }
```

| Field | Offset | Size | Alignment | Meaning |
| --- | --- | --- | --- | --- |
| `data` | 0 | 8 | 8 | Pointer to UTF-8 bytes (not NUL-terminated). |
| `length` | 8 | 8 | 8 | Byte length (i64). |

Total 16 bytes, aggregate alignment 8. Locked at M1.A (issue #392) —
perturbing either field changes `@sfn_abi_hash` and trips the
runtime's startup check.

**Ownership.** `data` is owned by whichever side allocated it.
String-literal materialization routes through
[`sailfin_runtime_alloc_struct`](#allocation-helpers); arena-aware
helpers (`sfn_str_concat_arena`, `sfn_str_append_arena`) allocate
from the global arena when `SAILFIN_USE_ARENA=1` (today's default —
[issue #324](https://github.com/SailfinIO/sailfin/issues/324)) and
from libc `calloc` otherwise. Callers that need the bytes past
arena rewind must copy them. The seed-built first-pass binary still
emits some legacy `i8*`-shaped string locals during the M2.4
cutover; call sites use `extractvalue` to recover the legacy `i8*`
operand where the surrounding lowering still treats strings as raw
pointers.

### SfnArray — `{ T*, i64, i64 }`

```llvm
%SfnArray = type { i8**, i64, i64 }   ; { data, length, capacity }
```

| Field | Offset | Size | Alignment | Meaning |
| --- | --- | --- | --- | --- |
| `data` | 0 | 8 | 8 | Pointer to contiguous element storage. |
| `length` | 8 | 8 | 8 | Element count (i64). |
| `capacity` | 16 | 8 | 8 | Allocated slot count (i64). |

Total 24 bytes, aggregate alignment 8. Locked at M1.B (issue #393).

**Element-type genericity.** `T` is erased to `i8*` in every runtime
helper signature and in the ABI hash's layout string (canonical form
`SfnArray{f0:i8**@8;f1:i64@8;f2:i64@8}`). Specialized element types
are recovered at the call site through the
`array_concat_element_type` / `array_push_element_type` parameters
threaded through [`coerce_and_emit_call`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/expression_lowering/native/core_call_emission.sfn);
runtime bodies never index into elements directly.

**Growth policy.** `length` and `capacity` are independent — appends
fitting `capacity` mutate in place, overflows allocate a fresh page
through the arena (or libc `realloc` off-arena) and copy existing
slots. The arena's grow-if-at-tip realloc
([`sfn_arena_realloc`](https://github.com/SailfinIO/sailfin/blob/main/runtime/native/src/sailfin_arena.c))
preserves the in-place fast path for typical append loops. Doubling
is not part of the ABI — it is an implementation detail of the
array helpers — but no helper may shrink `capacity` below `length`
or leave a slot uninitialized within `[0, length)`.

### Slice & Dynamic

```llvm
%SfnSlice   = type { i8**, i64 }            ; { data, length }
%SfnDynamic = type { i64, [16 x i8] }       ; { tag, payload }
```

`SfnSlice` is a non-resizable view into another aggregate's storage,
materializable from `SfnArray` by a no-op `extractvalue` of the
`{data, length}` prefix; lifetime is enforced statically by the
compiler, not carried in the aggregate. `SfnDynamic` is a tagged
union for `any`/`dynamic` interop boundaries; its 16-byte payload
inlines an `SfnString` or a 64-bit scalar, and out-of-line values
store their pointer in the first 8 bytes.

## ABI Versioning

Every emitted Sailfin LLVM module defines two global symbols with
`linkonce_odr` linkage so duplicates coalesce at link time:

```llvm
@sfn_abi_version = linkonce_odr constant i32 1
@sfn_abi_hash    = linkonce_odr constant i64 13458649150685806382
```

Emission lives in
[`lowering_phase_render.sfn:205-207`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/lowering/lowering_phase_render.sfn);
the hash value is computed at compile time by
[`abi_hash.sfn:sfn_abi_hash_decimal()`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/lowering/abi_hash.sfn).

**Version semantics.** `@sfn_abi_version` is a coarse monotonic
counter (current value `1`); it bumps when a breaking shape change
ships that the hash cannot describe — a new aggregate, a renumbered
exception ABI, or a calling-convention change. `@sfn_abi_hash` is
an FNV-1a 64-bit digest over the order-sensitive layout string

```
SfnString{f0:i8*@8;f1:i64@8};SfnArray{f0:i8**@8;f1:i64@8;f2:i64@8}
```

Hand-perturbing any field type, offset, alignment, or aggregate name
changes the hash. The FNV-1a routine lives in pure Sailfin (no
`extern fn`) and carries its state as four 16-bit limbs so earlier
seeds, which compiled `int` as f64, still produced exact results.

**Link-time behavior.** The runtime's C side provides weak fallback
definitions at
[`sailfin_runtime.c:120-121`](https://github.com/SailfinIO/sailfin/blob/main/runtime/native/src/sailfin_runtime.c)
(`__attribute__((weak))`) because Mach-O's static linker errors on
unresolved weak references — a runtime-only build with no Sailfin
LLVM module would otherwise fail to link. When the LLVM IR defines
the symbols, `linkonce_odr` (lowered to `weak_def_can_be_hidden`
on Mach-O) outranks the C `weak` fallback, so layout drift in the
IR-emitted hash trips the diagnostic. Compiler and runtime share an
address space, so the `i64` symbol is read as `uint64_t` directly —
no endianness handling. Cross-architecture precompiled artifacts
would need to re-encode the hash as a byte sequence.

**Startup check.** A `__attribute__((constructor))` in
[`_runtime_init`](https://github.com/SailfinIO/sailfin/blob/main/runtime/native/src/sailfin_runtime.c)
compares the linked module's symbols to the runtime's expected
constants and `_exit(70)` with a diagnostic on mismatch — version
first, then hash. The unit-test harness can drive the failure path
without rebuilding the runtime via `SAILFIN_ABI_FORCE_MISMATCH`:
`hash` forces the observed hash to `expected ^ 0xDEADBEEFCAFEBABE`;
any other non-empty / non-`0` value forces the observed version to
`expected + 1`; unset or `0` is the production path.

## Allocation Helpers

The compiler emits calls to two arena-aware helpers for boxed
allocations that the bump-allocator arena
([`sailfin_arena.c`](https://github.com/SailfinIO/sailfin/blob/main/runtime/native/src/sailfin_arena.c))
reclaims in bulk via `sfn_arena_mark` / `sfn_arena_rewind`. Both
fall through to libc `calloc` / `free` when the arena is disabled
(`SAILFIN_USE_ARENA=0`), so off-arena callers retain the original
malloc-based lifetime contract.

| Symbol | Signature | When emitted | Pairs with | Arena | Off-arena |
| --- | --- | --- | --- | --- | --- |
| `sailfin_runtime_alloc_struct` | `i8* (i64 size_bytes)` | string-literal materialization, struct/array literal boxing, scalar→`i8*` coercion | `sailfin_runtime_free` (or arena bulk reclaim) | `_rt_calloc` → arena | `calloc(1, size)` |
| `sailfin_runtime_free` | `void (i8*)` | await-unboxing of a boxed-struct future return | `sailfin_runtime_alloc_struct` | no-op (arena reclaims at rewind / exit) | `free(ptr)` |

**Alignment.** Both helpers guarantee 8-byte alignment — the arena
path passes `align=8` to `sfn_arena_alloc`, and `calloc` aligns to
at least `max_align_t` (`≥ 8` on every supported target).

**Lifetime (arena-backed by default).** Per
[issue #324](https://github.com/SailfinIO/sailfin/issues/324),
installed binaries default to `SAILFIN_USE_ARENA=1` — `unset` takes
the default, only an explicit `0`/`""`/`"false"` opts out. Arena
allocations live until the next `sfn_arena_rewind` to a prior mark
or until process exit; the compiler does not emit per-allocation
drops for arena-routed pointers (M1.5.5 escape promotion is not yet
on). Off-arena, `sailfin_runtime_free` fires only at sites with
unambiguous ownership (today: `await` unboxing of boxed-struct
future returns), must only be paired with `_rt_calloc`-routed
pointers, and would otherwise leak or corrupt libc metadata. The
async-context calloc/free pair in
[`emission_async.sfn`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/lowering/emission_async.sfn)
intentionally stays on raw `@calloc` / `@free` because both ends
of the allocation are libc-resident regardless of arena state.

**Default arena global.** Arena-aware string helpers take an explicit
`SfnArena *` operand. Every emitted module declares the slot
(`@sfn_default_arena = external global ptr`); a constructor in
`sailfin_runtime.c` primes it from `sfn_arena_global()` at module
load, and call sites pass `ptr @sfn_default_arena` as the arena
operand.

## Native Signature Registry

Every entry in
[`runtime_helpers.sfn`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/runtime_helpers.sfn)
carries an optional `native_signature` field (issue #392). When set,
the LLVM lowering emits calls to the canonical Sailfin-native symbol
(`sfn_<domain>_<op>`) instead of the legacy C entrypoint
(`sailfin_runtime_*`). Consumers are
[`render_runtime_helper_declarations`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/rendering.sfn)
(emits the `declare`) and
[`coerce_and_emit_call`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/expression_lowering/native/core_call_emission.sfn)
(emits the call site); both prefer `native_signature` over `symbol`
when populated, so unflipped entries keep routing through the legacy
C body during the M2.4 / M2.6 migration.

**Naming convention.** `sfn_<domain>_<op>` — short, lowercase,
underscore-separated. Domains are allocated in priority order so ABI
hazards surface in the smallest pilot first:

1. `sfn_str_*` — string ops. Smallest ABI surface, no effects.
2. `sfn_array_*` — array/collection ops.
3. `sfn_fs_*` — filesystem ops (needs `![io]` capability bridging).
4. `sfn_net_*` — network ops (needs `![net]` capability bridging).
5. `sfn_clock_*` — clock/time ops (mostly already direct-emitted).

**Pilot list.** Twelve descriptors carry a populated
`native_signature` today (9 string + 3 array):

| Descriptor `target` | Native symbol | Wave |
| --- | --- | --- |
| `substring` | `sfn_str_slice` | M2.4a (#430) |
| `substring_unchecked` | `sfn_str_slice` | M2.4a (#430) |
| `string.length` | `sfn_str_len` | M2.4a (#430) |
| `strings_equal` | `sfn_str_eq` | M2.4a (#430) |
| `string.concat` | `sfn_str_concat_arena` | M2.4b (#398) |
| `string.starts_with` | `sfn_str_starts_with` | M1.2 (#461) |
| `string.ends_with` | `sfn_str_ends_with` | M1.2 (#461) |
| `string.contains` | `sfn_str_contains` | M1.2 (#461) |
| `string.repeat` | `sfn_str_repeat` | M1.2 (#461) |
| `append_string` | `sfn_array_push_string` | M2.6 (#466) |
| `concat` (array) | `sfn_array_concat` | M2.6 (#466) |
| `array_push_slot` | `sfn_array_push_slot` | M2.6 (#466) |

**Rollout status.** Roughly 107 descriptors remain on the legacy
`sailfin_runtime_*` shape. The per-wave checklist lives as a header
comment at the top of `runtime_helpers.sfn`; each wave picks a 5–10
helper batch in a single domain, populates `native_signature`, and
adds C trampolines for any hardcoded LLVM call sites that bypass
the descriptor table.

## Typed Closures

A typed closure is a two-word aggregate `{ fn_ptr, env_ptr }` with
both slots erased to `i8*`, so closure values pass uniformly across
runtime boundaries (spawn handlers, channels, higher-order helpers)
without per-capture-shape ABI variants:

```llvm
%sfn_closure = type { i8*, i8* }   ; { fn_ptr, env_ptr }
```

**Hidden-env-first calling convention.** The lifted lambda is
lowered with the env pointer as a hidden first parameter:

```llvm
define <ret_ty> @sfn_lambda_<id>(i8* %env, <decl_param_tys>...)
```

Non-capturing lambdas use the same signature — `%env` is unused but
present, so the call shape is uniform.

**Env-struct allocation.** Captures are packed into a per-lambda env
struct in first-use order (deterministic across runs). The helper
API in [`closures.sfn`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/closures.sfn)
synthesizes the type (`%sfn_closure_env_<id>`), allocates it via
[`sailfin_runtime_alloc_struct`](#allocation-helpers), and emits the
GEP+load prologue inside the lifted body. Non-capturing closures
materialize with `env_ptr = i8* null`.

**Call-site dispatch.** Closure calls extract the slots, bitcast the
function pointer to `<ret_ty> (i8*, <param_tys>)*`, and invoke with
the env pointer first:

```llvm
%fn_ptr = extractvalue {i8*, i8*} %closure, 0
%env    = extractvalue {i8*, i8*} %closure, 1
%typed  = bitcast i8* %fn_ptr to <ret_ty> (i8*, <param_tys>)*
%result = call <ret_ty> %typed(i8* %env, <args>...)
```

This mirrors the trait-dispatch shape, keeping the IR-shape
vocabulary uniform across closures, trait objects, and any future
indirect-call primitive. The bitcast signature is recovered from
either the lifted lambda's internal `__closure__@sfn_lambda_<N>`
sentinel or a user-written `fn(<param_tys>) -> <ret_ty>` annotation.

**Lifetime stance.** The env struct routes through
`sailfin_runtime_alloc_struct`; the compiler does **not** emit a
paired free on closure-pair drop because the pair has no
deterministic owner (it can be copied into spawn handlers, channels,
or returned upward). Arena reclaim covers the arena case; the off-
arena case leaks until process exit. Per-capture RC retain/release
and a deterministic env drop are deferred to a post-M1 issue. See
[`docs/runtime_architecture.md` §3.4](https://github.com/SailfinIO/sailfin/blob/main/docs/runtime_architecture.md#34-typed-closures)
for the design rationale.

## Exception / Unwind ABI

Sailfin's exception model is **structured frames with deterministic
unwind**. Today's implementation is `setjmp`/`longjmp`-based,
exposed through four C runtime entrypoints in
[`sailfin_runtime.c`](https://github.com/SailfinIO/sailfin/blob/main/runtime/native/src/sailfin_runtime.c).
The M2.7 migration
([issue #404](https://github.com/SailfinIO/sailfin/issues/404))
replaces the TLS-polling path with stack-allocated frames; both
phases share the IR-level ABI (`i32` returns + explicit
`take_exception` calls).

| Symbol | Signature | Role |
| --- | --- | --- |
| `sailfin_runtime_try_enter` | `i32 (i8**)` | Push a `SailfinTryContext` onto the TLS try stack; return `setjmp(ctx->env)` — 0 on first entry, 1 on `longjmp` rewind. Out-param receives the frame handle. |
| `sailfin_runtime_try_leave` | `void (i8*)` | Pop and free the matching context. Tolerates mismatched leaves. |
| `sailfin_runtime_throw` | `void (i8*)` | Store `message` in a `_Thread_local` slot and `longjmp` to the top-of-stack context; abort if no context. |
| `sailfin_runtime_take_exception` | `i8* (void)` | Read and clear the TLS message at catch entry. |

**Landingpad shape.** The compiler-emitted IR follows a `call`+`br`
shape rather than LLVM's native `invoke`/`landingpad`:

```llvm
%status = call i32 @sailfin_runtime_try_enter(i8** %frame_slot)
%caught = icmp ne i32 %status, 0
br i1 %caught, label %catch.entry, label %try.body
```

The init-sentinel cleanup at catch entry (M1.5.4 /
[issue #328](https://github.com/SailfinIO/sailfin/issues/328))
emits guarded `sfn_rc_release` calls for owned RC locals initialized
before the throw — the sentinel slot lives in the function frame
and is set at each declaration site by
[`instructions_let.sfn`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/lowering/instructions_let.sfn).

**Unwind tables.** The setjmp/longjmp path does **not** require
DWARF unwind tables (`.eh_frame`) — rewind happens through TLS
state, not the C++ Itanium ABI. This sidesteps the macOS arm64 /
Linux x86_64 unwinder fragmentation that has historically broken
cross-platform release builds. The trade-off is that intermediate
frames between `throw` and the catching `try` cannot run cleanup
automatically — the compiler emits explicit scope-boundary drops
instead.

**Frame-based catches (M2.7 trajectory).**
[Issue #404](https://github.com/SailfinIO/sailfin/issues/404)
migrates `instructions_try.sfn` from TLS polling to stack-allocated
`SfnExceptionFrame` records and renames the entrypoints to
`sfn_try_enter` / `sfn_try_leave` / `sfn_take_exception`. Frames
allocate in the function prologue (no per-try malloc); a follow-up
M2.7c PR removes the per-call-site `has_exception` polling the
legacy TLS path relies on. The IR shape stays `call i32` + `br` —
a rename plus a frame-allocation move, not a switch to native
landingpads (deferred to post-1.0).

**Out of scope today.** Exception propagation across `routine` /
`spawn` boundaries is gated on the M4 concurrency ABI; concurrent
throws are not yet defined. `longjmp` across an `extern fn` is
undefined — FFI boundaries trap at the C body.

---

*The runtime is actively migrating from C to Sailfin. See the
[runtime audit](https://github.com/SailfinIO/sailfin/blob/main/docs/runtime_audit.md)
for current status, and Epic
[#450](https://github.com/SailfinIO/sailfin/issues/450) (M1 — ABI lock +
codegen switch) for the lock-in sequencing this doc reflects.*
