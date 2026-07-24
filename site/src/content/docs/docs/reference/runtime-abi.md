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
[`sfn_alloc_struct`](#allocation-helpers); the arena-
aware helpers (`sfn_str_concat_arena`, `sfn_str_append_arena`) are
**unconditionally** arena-backed by design — the `SAILFIN_USE_ARENA`
opt-out applies only to the legacy `_rt_*` allocation paths and the
2-arg `sailfin_runtime_string_concat` trampoline. Callers that need
the bytes past arena rewind must copy them. The seed-built first-
pass binary still emits some legacy `i8*`-shaped string locals
during the M2.4 cutover; call sites use `extractvalue` to recover
the legacy `i8*` operand where the surrounding lowering still
treats strings as raw pointers.

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
([`sfn_arena_realloc`](https://github.com/SailfinIO/sailfin/blob/main/runtime/sfn/memory/arena.sfn))
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

## Entry Point

Since M5 ([#451](https://github.com/SailfinIO/sailfin/issues/451),
shipped 2026-05-25) the binary's entry point is the
Sailfin-emitted `@main` — no C driver participates in startup.
The compiler emits exactly one definition matching the platform
contract:

```llvm
define i32 @main(i32 %argc, i8** %argv) {
  ; resolve runtime root (walks up from argv[0] looking for a
  ; sibling `runtime/` directory, honouring SAILFIN_RUNTIME_ROOT)
  ; marshal argv into SfnArray<SfnString>
  ; call into the Sailfin CLI: sailfin_cli_main__cli_main
  ; return i32 exit status
}
```

In LLVM IR the entry symbol is spelled `@main`; after linking, tools
like `nm` show it without the `@` sigil. `nm build/bin/sfn |
grep -E ' T main$'` shows exactly one `T main` row, sourced from the
Sailfin-emitted definition in `compiler/src/llvm/lowering/` (see
the Runtime Migration table in `docs/status.md` for the pipeline trace).
`SAILFIN_TRACE_ARGV` prints the argv vector observed by
`sailfin_cli_main` for entry-point debugging.

The previous C entry point (`runtime/native/src/native_driver.c`)
and its Windows MinGW cross-compile rules were deleted as part of
M5; the symbols its `extern` decls referenced
(`compile_to_sailfin` / `compile_to_llvm`, `_resolve_runtime_root`,
`SailfinPtrArray` construction helpers) are now reached entirely
through Sailfin code paths.

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

**Link-time behavior.** The compiler emits `@sfn_abi_version` and
`@sfn_abi_hash` as `linkonce_odr` constants in each Sailfin LLVM module. The
runtime is entirely Sailfin-native under `runtime/sfn/`; the former weak C
fallbacks and C constructor were deleted with `runtime/native/` in #822. A
runtime-only C link mode is therefore no longer part of the supported ABI.

## Allocation Helpers

The compiler emits calls to two arena-aware helpers for boxed
allocations that the Sailfin-native bump allocator in
`runtime/sfn/memory/arena.sfn` reclaims in bulk via `sfn_arena_mark` /
`sfn_arena_rewind`. Both
fall through to libc `calloc` / `free` when the arena is disabled
(`SAILFIN_USE_ARENA=0`), so off-arena callers retain the original
malloc-based lifetime contract.

| Symbol | Signature | When emitted | Pairs with | Arena | Off-arena |
| --- | --- | --- | --- | --- | --- |
| `sfn_alloc_struct` | `i8* (i64 size_bytes)` | string-literal materialization, struct/array literal boxing, scalar→`i8*` coercion | `sfn_mem_free` (or arena bulk reclaim) | arena allocation | `calloc(1, size)` |
| `sfn_mem_free` | `void (i8*)` | await-unboxing of a boxed-struct future return; scope-exit drop of a boxed local | `sfn_alloc_struct` | no-op (arena reclaims at rewind / exit) | `free(ptr)` |

Both helpers are implemented in `runtime/sfn/memory/mem.sfn` and preserve the
arena-mode no-op guard plus the libc allocation/free fallback.

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
on). Off-arena, `sfn_mem_free` fires only at sites with
unambiguous ownership (today: `await` unboxing of boxed-struct
future returns and scope-exit drops of boxed locals), must only be
paired with `_rt_calloc`-routed pointers, and would otherwise leak
or corrupt libc metadata. The
async-context calloc/free pair in
[`emission_async.sfn`](https://github.com/SailfinIO/sailfin/blob/main/compiler/src/llvm/lowering/emission_async.sfn)
intentionally stays on raw `@calloc` / `@free` because both ends
of the allocation are libc-resident regardless of arena state.

**In-loop reclamation (#1514 / #1515).** Beyond the function-scope
rewind, the emitter now reclaims *per-iteration* arena allocations:
it wraps a loop body in `sfn_arena_sfn_mark` at body entry and
`sfn_arena_sfn_rewind` at iteration close, so a hot allocation loop
stops growing RSS linearly (the `arena_alloc` benchmark drops from
~691 MB to a flat ~1.7 MB — see
[`docs/perf/runtime-performance.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/perf/runtime-performance.md)).
This is **gated** on a non-escape proof
(`loop_body_rewind_eligible`, `instructions_helpers.sfn`) and fires
only when the body allocates via a real `@sfn_alloc_struct`, every
body-scope heap local is an all-primitive-scalar struct still routed
to the arena (not promoted to `rc`, consumed, or stored into an
ancestor-scope binding), and the body has no other call/store that
could grow an ancestor container the rewind would then free. It
covers generic `loop`, `for x in arr`, and `for i in a..b`;
`continue` / `break` / `return` paths skip the rewind (a safe missed
reclamation, never a dangling pointer). Scalar-replacement
(strategy B) and nested-loop mark stacking are post-1.0.

**Default arena global.** The Sailfin-native arena module lazily initializes
the process-global arena through `sfn_arena_global()`. Arena-aware helpers
resolve that global when no explicit arena is supplied; no C constructor or
runtime-global fallback participates in startup.

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
[`sfn_alloc_struct`](#allocation-helpers), and emits the
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
`sfn_alloc_struct`; the compiler does **not** emit a
paired free on closure-pair drop because the pair has no
deterministic owner (it can be copied into spawn handlers, channels,
or returned upward). Arena reclaim covers the arena case; the off-
arena case leaks until process exit. Per-capture RC retain/release
and a deterministic env drop are deferred to a post-M1 issue. See
[`docs/proposals/0025-native-runtime-architecture.md` §3.4 "Typed Closures"](https://github.com/SailfinIO/sailfin/blob/main/docs/proposals/0025-native-runtime-architecture.md#393-typed-closures)
for the design rationale.

## Exception / Unwind ABI

Sailfin's exception model is **structured frames with deterministic
unwind**. Today's implementation is `setjmp`/`longjmp`-based and lives in
`runtime/sfn/exception.sfn`. Compiler-emitted try blocks use stack-allocated
frames and call the Sailfin-native exception primitives directly.

| Symbol | Signature | Role |
| --- | --- | --- |
| `sfn_exception_push_frame` | `void (i8*)` | Push a compiler-allocated frame onto the thread-local frame chain. |
| `sfn_exception_pop_frame` | `void (i8*)` | Pop the matching frame from the chain. |
| `sfn_throw` | `void (i8*)` | Store the message on the current frame and `longjmp`; abort if no frame exists. |
| `sfn_take_exception` | `i8* (i8*)` | Read and clear the message from the caught frame. |

**Landingpad shape.** The compiler-emitted IR follows a `call`+`br`
shape rather than LLVM's native `invoke`/`landingpad`:

```llvm
%status = call i32 @setjmp(i8* %jmp_buf)
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
DWARF unwind tables (`.eh_frame`) — rewind happens through the thread-local Sailfin frame chain, not the C++
Itanium ABI. This sidesteps the macOS arm64 /
Linux x86_64 unwinder fragmentation that has historically broken
cross-platform release builds. The trade-off is that intermediate
frames between `throw` and the catching `try` cannot run cleanup
automatically — the compiler emits explicit scope-boundary drops
instead.

**Frame-based catches.** Compiler lowering allocates an
`SfnExceptionFrame` in the function frame, pushes it before `setjmp`, and pops
it on normal exit. A throw records the message on that frame and jumps back to
the saved point; the catch path reads it with `sfn_take_exception`.

**Out of scope today.** Exception propagation across `routine` /
`spawn` boundaries is gated on the M4 concurrency ABI; concurrent
throws are not yet defined. `longjmp` across an `extern fn` is
undefined — FFI boundaries trap at the C body.

---

*The runtime has migrated from C to Sailfin. See the
[Runtime Migration table in `docs/status.md`](https://github.com/SailfinIO/sailfin/blob/main/docs/status.md)
for current status, and Epic
[#450](https://github.com/SailfinIO/sailfin/issues/450) (M1 — ABI lock +
codegen switch) for the lock-in sequencing this doc reflects.*
