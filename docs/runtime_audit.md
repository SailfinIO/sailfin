# Runtime Audit: Native Self-Hosting Gap Analysis

This audit documents the remaining runtime work required to remove the C
dependency and ship a fully Sailfin-native compiler/runtime. It is scoped to
the Stage2 native toolchain and the runtime surface declared in
`runtime/native/include/sailfin_runtime.h`.

## Current Surface Area

The C runtime provides (or stubs) the following categories of helpers:

- Core logging + sleep: `sailfin_runtime_print_*`, `sailfin_runtime_sleep`
- Strings: `sailfin_runtime_string_length`, `sailfin_runtime_substring`,
  `sailfin_runtime_string_concat`, `sailfin_runtime_grapheme_*`,
  `sailfin_runtime_char_code`
- Arrays: `sailfin_runtime_concat`, `sailfin_runtime_append_string`
- Process execution: `sailfin_runtime_process_run`
- Reflection/type checks: `sailfin_runtime_is_*`, `sailfin_runtime_resolve_type`,
  `sailfin_runtime_instance_of`, `sailfin_runtime_get_field`
- Effects/capabilities: `sailfin_runtime_create_*_bridge`,
  `sailfin_adapter_fs_*`, `sailfin_adapter_http_*`, `sailfin_adapter_model_*`
- Concurrency: `sailfin_runtime_channel`, `sailfin_runtime_spawn`,
  `sailfin_runtime_parallel`, `sailfin_runtime_serve`
- Exceptions: `sailfin_runtime_try_enter/leave/throw/take_exception`,
  `sailfin_runtime_set_exception/clear_exception/has_exception`

Primary sources:
- `runtime/native/include/sailfin_runtime.h`
- `runtime/native/src/sailfin_runtime.c`
- `runtime/stage2_runtime_stub.c`
- `runtime/prelude.sfn`
- `runtime/stage2_runner.py`

## Gaps Blocking C Removal

1. **ABI ownership**: Stage2 still targets a legacy C-string ABI and pointer
   arrays. A Sailfin-native runtime must either preserve this ABI or the
   compiler lowering must move to a native ABI (string/array layouts, tagged
   values, ownership rules).
2. **Exception model**: The current runtime uses `setjmp/longjmp` and TLS
   state in C. A Sailfin-native runtime needs an equivalent mechanism or a
   compiler-driven EH strategy with compatible entrypoints.
3. **Type metadata**: `is_*`, `resolve_type`, and `instance_of` are currently
   stubs. Native runtime needs a type registry, emitted descriptors, and
   instance tests usable by `runtime/prelude.sfn`.
4. **Concurrency runtime**: `spawn`, `channel`, `parallel`, and `serve` are
   no-ops in C. A native scheduler, channels, and server dispatch are required
   for examples and capability enforcement.
5. **Capability adapters**: Filesystem is implemented in C, HTTP/model are
   stubs, and Python shims remain in `runtime/runtime_support.py` and
   `runtime/stage2_runner.py`. Native adapters must replace these.
6. **Driver/CLI**: `runtime/native/src/stage2_driver.c` and Python runners are
   still part of the toolchain. A Sailfin-native CLI should replace them for
   the full self-hosted workflow.
7. **Incomplete helpers**: `get_field`, `array_map/filter/reduce`,
   `to_debug_string`, and `log_execution` are minimal. These must be fully
   implemented with correct semantics and tests.

## ABI Recommendation (Long-Term Stable Direction)

Adopt a **Sailfin-native ABI** (versioned) and treat the legacy C-string ABI as
a temporary compatibility layer. This provides predictable memory layouts,
explicit ownership rules, and room for future runtime features (type metadata,
exception frames, concurrency, and safer FFI).

### Proposed Native ABI Primitives (Initial Sketch)

- **String**: `{ i8* data, i64 len }` with UTF-8 bytes; no implicit NUL.
- **Array/Slice**: `{ T* data, i64 len, i64 cap }` for owned arrays and
  `{ T* data, i64 len }` for borrowed slices.
- **Value**: tagged payload for dynamic values (`enum`-like layout with tag +
  inline/ptr storage).
- **Exception frame**: explicit frame structure holding message pointer and
  unwind linkage (compiler/runtime owned).

### Compatibility Strategy

- Keep a **legacy ABI shim** that maps existing C-string calls to the native
  ABI. The shim should be implemented in Sailfin where possible and only use
  minimal platform FFI.
- Migrate the compiler lowering to emit native ABI calls, then retire the shim
  once all intrinsics and tests are updated.

## Recommendations

- **Decide ABI direction early**: Lock the Sailfin-native ABI and document the
  initial layouts + versioning strategy in this file.
- **Bootstrap with a "native runtime MVP"**: Prioritize strings, arrays,
  exceptions, filesystem, and logging so the compiler can self-host without
  C.
- **Parallelize adapters and async runtime**: These are high-surface features
  but can be developed in parallel once the ABI and core helpers are stable.

## Suggested Milestones

- **M0: ABI Decision + Audit**: Lock ABI strategy, document in this file.
- **M1: Core Runtime**: Strings, arrays, exceptions, bounds checks, logging,
  process execution, and type metadata.
- **M2: Capability Adapters**: FS/HTTP/model adapters in Sailfin; remove
  Python shims from native execution.
- **M3: Async Runtime**: Spawn, channel, serve; integrate with coroutine
  lowering and add native execution tests.
- **M4: Native CLI + Driver**: Replace `stage2_driver.c` and Python runner
  with Sailfin-native CLI, update packaging/tooling.
