---
title: Runtime ABI
description: Sailfin's native runtime ABI specification.
section: reference
sidebar:
  order: 7
---

## Goals

- Performance-first data layouts
- Stable, versioned ABI
- Zero-copy slices
- Clear interop boundaries for FFI

## Core Data Layouts

### String

```
{ u8* data, i64 len }   // UTF-8, not NUL-terminated
```

### Array (Owned)

```
{ T* data, i64 len, i64 cap }
```

### Slice (Borrowed)

```
{ T* data, i64 len }    // Non-resizable view
```

### Dynamic Value

```
{ i64 tag, union{...} payload }   // Tagged union
```

## Ownership Model (v0)

Hybrid approach: reference counting + arenas.

- **Arenas** for short-lived allocations (within a scope)
- **Reference counting** for values that escape their scope
- **Explicit retain/release** for RC-managed values

## Allocation Helpers

The compiler emits calls to two arena-aware helpers for boxed allocations
that the bump-allocator arena (`runtime/native/src/sailfin_arena.c`) can
reclaim in bulk via `runtime.arena_mark` / `runtime.arena_rewind`.
Both fall through to libc `calloc` / `free` when the arena is disabled
(`SAILFIN_USE_ARENA=0`), so off-arena callers retain the original
malloc-based lifetime contract.

| Symbol | Signature | When emitted | Pairs with | Arena | Off-arena |
| --- | --- | --- | --- | --- | --- |
| `sailfin_runtime_alloc_struct` | `i8* (i64 size_bytes)` | string-literal materialization, struct/array literal boxing, scalar→`i8*` coercion | `sailfin_runtime_free` (or arena bulk reclaim) | `_rt_calloc` → arena | `calloc(1, size)` |
| `sailfin_runtime_free` | `void (i8*)` | await-unboxing of a boxed-struct future return | `sailfin_runtime_alloc_struct` | no-op (arena reclaims at rewind / exit) | `free(ptr)` |

Important: `sailfin_runtime_free` must only be paired with pointers from
`sailfin_runtime_alloc_struct` (or other `_rt_calloc`-routed allocations).
Calling it on a libc-`malloc`/`calloc` pointer while the arena is
enabled would leak that pointer; calling libc `free` on an arena-allocated
pointer corrupts glibc chunk metadata.

The async-context calloc/free pair in `compiler/src/llvm/lowering/emission_async.sfn`
intentionally stays on raw `@calloc` / `@free` because both ends of the
allocation are libc-resident regardless of arena state.

## Typed Closures

A typed closure is represented at the ABI boundary as a two-word aggregate:

```llvm
%sfn_closure = type { i8*, i8* }   ; { fn_ptr, env_ptr }
```

The first word is the function pointer for the lifted lambda body; the
second is the captured-environment pointer. Both slots are erased to
`i8*` so that closure values are uniformly passable across runtime
boundaries (spawn handlers, channels, higher-order helpers) without
per-capture-shape ABI variants.

**Hidden-env-first calling convention.** The lifted lambda is lowered
with the env pointer as its first (hidden) parameter, ahead of every
declared source parameter:

```llvm
define <ret_ty> @sfn_lambda_<id>(i8* %env, <decl_param_tys>...)
```

Callers materialize the closure pair at the lambda expression site and
pass `env_ptr` as the first argument on every invocation. Non-capturing
lambdas use the same signature — the `%env` parameter is unused but
present, so the call shape is uniform.

**Env-struct allocation.** Captures are packed into a per-lambda env
struct laid out in first-use order (deterministic across runs of the
same source). The compiler synthesises the env type, allocates it via
the runtime, and populates each slot at the expression site. The
helper API in `compiler/src/llvm/closures.sfn` settles this contract:

- `closure_env_type_name(lambda_id)` — the `%sfn_closure_env_<id>` name.
- `synthesize_closure_env_struct(captures, lambda_id)` — the
  `ClosureEnvLayout` (type declaration plus field index map).
- `emit_closure_env_alloc(layout, operands, temp_index)` — the alloc +
  GEP+store sequence at the lambda expression site. The allocation
  routes through the [`sailfin_runtime_alloc_struct`](#allocation-helpers)
  entry point documented above, sized via the standard size-of idiom
  (no `inbounds`):

  ```llvm
  %size_ptr = getelementptr %sfn_closure_env_<id>,
                            %sfn_closure_env_<id>* null, i32 1
  %size_i64 = ptrtoint %sfn_closure_env_<id>* %size_ptr to i64
  ```
- `emit_closure_env_load_prologue(layout, env_param_name, temp_index)` —
  the GEP+load prologue inside the lifted lambda body that rebinds each
  capture to a local SSA name keyed by `Capture.name`.

**Non-capturing case.** When `captures.length == 0` the layout is
flagged `is_empty` and both emit helpers return no lines. The closure
pair is materialized with `env_ptr = null` (an `i8* null` literal); the
lifted lambda still takes the hidden `%env` parameter and simply ignores
it. Callers should treat `env_ptr` as opaque — nullness for the
non-capturing case is an implementation detail, not a stable contract,
and the uniform call shape means non-capturing dispatch needs no
special case.

**Lifetime stance (env outlives the closure pair; no drop yet).** The
env struct is allocated through `sailfin_runtime_alloc_struct`, which
routes through the arena when `SAILFIN_USE_ARENA=1` and through libc
`calloc` otherwise. The compiler does **not** emit a paired
`sailfin_runtime_free` for the env on closure-pair drop; arena reclaim
covers the arena case, and the off-arena case leaks until the process
exits. This is intentional for M1.5: the closure pair has no
deterministic owner (it can be copied into spawn handlers, channels, or
returned upward), so a drop point cannot be assigned without escape
analysis. Per-capture RC retain/release and a deterministic env drop
are deferred to a post-M1 issue; until then, treat the env as an
arena-lifetime allocation. See
[`docs/runtime_architecture.md` §3.4 "Typed Closures"](https://github.com/SailfinIO/sailfin/blob/main/docs/runtime_architecture.md#34-typed-closures)
for the design rationale and the M2 ownership plan.

## Exception / Unwind ABI

Structured frames with deterministic unwind. Currently implemented via C runtime's `setjmp`/`longjmp`, planned to move to native structured exceptions.

---

*The runtime is actively migrating from C to Sailfin. See the [runtime audit](https://github.com/SailfinIO/sailfin/blob/main/docs/runtime_audit.md) for current status.*
