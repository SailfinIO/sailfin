# Runtime Audit: Sailfin-Native Runtime Plan

This audit documents the remaining runtime work required to remove the C
dependency and ship a fully Sailfin-native compiler/runtime before 1.0. It
reflects the current self-hosted native compiler, with legacy Python compiler
artifacts kept only for emergency recovery. The audit is scoped to the native
compiler toolchain and the runtime surface declared in
`runtime/native/include/sailfin_runtime.h`.

## Toolchain Snapshot (Current)

- The self-hosted native compiler is the primary toolchain (`make compile`
  produces `build/native/sailfin`).
- The runtime is still implemented in C under `runtime/native/` and linked
  into the native compiler binary.
- Legacy Python compiler artifacts live under `compiler/build/` and are kept
  for emergency recovery only; they will be removed before 1.0.
- Python runtime shims remain only to support the legacy artifacts and should
  be deleted once `compiler/build/` is removed.

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
- `runtime/prelude.sfn`
- `runtime/native_runner.py` (temporary; slated for removal pre-1.0)
- `docs/runtime_abi.md` (target Sailfin-native ABI spec)

## C Runtime Architecture (Current)

This section reflects how the C runtime behaves today and how the self-hosted
compiler relies on it.

### ABI and value representation

- **Strings**: `char*` NUL-terminated C strings. The runtime also accepts
  "immediate-codepoint" pseudo-strings encoded in pointer bits to avoid
  allocations for single-byte graphemes.
- **Arrays**: `{ i8**, i64 }` for pointer arrays. The runtime stores capacity
  and canaries in a hidden header *before* `data` for arrays it allocates.
- **Numbers**: `double` at the ABI (including for chars/bytes in some helpers).
- **Booleans**: `bool` (i1 in LLVM IR).
- **Exceptions**: thread-local exception message string + setjmp/longjmp stack
  used by `sailfin_runtime_try_enter/throw`, while the compiler lowering uses
  `set_exception/has_exception/take_exception` today.

### Memory/ownership model (bootstrap-era)

- Strings are a mix of static literals, immediate-codepoint pseudo-strings,
  runtime-owned malloc strings, and foreign pointers. The runtime tracks owned
  and persistent pointers in hash sets to avoid freeing invalid memory.
- `sailfin_runtime_string_drop` is effectively disabled by default because the
  compiler does not yet emit safe ownership/RC signals; large strings are
  forcibly marked persistent to avoid reuse-related corruption.
- Array growth for pointer arrays uses a custom header and canaries to detect
  memory stomps caused by ABI mismatches or mis-lowered code.

### Functional areas (current behavior)

- **Logging + timing**: implemented (`print_*`, `sleep`, `monotonic_millis`).
- **Strings**: length, concat, substring, grapheme helpers implemented with
  defensive guards against invalid pointers and non-canonical addresses.
- **Arrays**: concat/append/push for pointer arrays; generic `array_push_slot`
  for non-pointer element arrays using a separate header format.
- **Process**: `process.run` implemented via `posix_spawnp`.
- **Filesystem**: `read_file`, `write_file`, `write_lines`, `list_directory`,
  `delete_file`, `create_directory`, `exists` implemented.
- **Exceptions**: `set_exception/has_exception/take_exception` implemented;
  `try_enter/throw` uses `setjmp/longjmp` but is not wired into current
  lowering.
- **Concurrency**: `spawn/parallel/channel/serve` are stubs; futures use
  per-task pthreads for `spawn_*` and `await_*`.
- **Reflection/type checks**: `is_*`, `resolve_type`, `instance_of`,
  `get_field` are stubs or return defaults.
- **Adapters**: HTTP/model adapters are stubs; capability bridge creators are
  stubs.

### Notable debug/diagnostic hooks

- Extensive runtime guards for pointer plausibility, string length scanning,
  array canary checks, and optional tracing via `SAILFIN_TRACE_*` env vars.
- These exist to survive bootstrap-era ABI mismatches and should be retired or
  reduced once a native ABI and ownership model are stable.

## Compiler <-> Runtime Integration (Current)

- The native compiler lowers runtime calls using
  `compiler/src/llvm/runtime_helpers.sfn`, which maps Sailfin-level intrinsics
  to external C symbols (e.g., `string.concat` -> `sailfin_runtime_string_concat`).
- Array lowering has two distinct paths:
  - `i8*` arrays use `sailfin_runtime_append_string` and `sailfin_runtime_concat`
    to preserve the runtime's pointer-array header conventions.
  - Non-pointer arrays use `sailfin_runtime_array_push_slot` to grow buffers
    with a separate header layout.
- Exception lowering in `compiler/src/llvm/lowering/instructions.sfn` relies on
  `set_exception/has_exception/take_exception` rather than `try_enter/throw`.
- The C `native_driver` embeds the Sailfin-native CLI, resolves a runtime root
  via `SAILFIN_RUNTIME_ROOT` or a bundled `runtime/` directory, and calls into
  `native_cli_main__cli_main`.
- The Sailfin `runtime/prelude.sfn` exposes `runtime.*` helpers that are wired
  to these runtime symbols; this is the primary interface for compiled code.

## Removal Inventory (Pre-1.0)

The following entrypoints are still Python/C-based and must be removed or
replaced before 1.0 ships:

- Python runtime shims: `runtime/runtime_support.py`,
  `runtime/native_runner.py`, `runtime/native_runner_impl.py`, `runtime/__init__.py`.
- Native C runtime: `runtime/native/src/sailfin_runtime.c`,
  `runtime/native/include/sailfin_runtime.h`.
- Native C driver: `runtime/native/src/native_driver.c`.
- Python-generated compiler artifacts that import `runtime_support`
  (e.g., `compiler/build/**`). These are legacy recovery-only artifacts and
  should be removed from the 1.0 toolchain and release artifacts.

## Python Removal Map (Pre-1.0)

The following replacements must land before Python can be removed from the
runtime/toolchain.

### Runtime shims → removal conditions

- `runtime/runtime_support.py`, `runtime/native_runner.py`,
  `runtime/native_runner_impl.py`, and `runtime/__init__.py` are only required
  by the emergency fallback Python compiler artifacts under `compiler/build/**`.
  They can be deleted once that fallback is removed; no separate native
  replacements are required purely to retire these shims.

### Compiler artifacts → native pipeline

- `compiler/build/**` (Python-generated compiler artifacts) → remove from the
  1.0 toolchain once the native compiler and CLI cover compile/run/test flows.
- Any generated Python entrypoints (e.g., `compiler/build/cli_main.py`) →
  Sailfin-native CLI modules.

### Guardrails

- CI should fail if any Python runtime shim is imported or executed.
- Packaging should exclude Python runtime files from 1.0 artifacts.

## Gaps Blocking C Removal

1. **ABI ownership**: The native compiler toolchain still targets a C ABI
   (NUL-terminated strings, pointer arrays). A Sailfin-native runtime must move
   the compiler lowering to a native ABI (string/array layouts, tagged values,
   ownership rules).
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
   `runtime/native_runner.py`. Native adapters must replace these before 1.0.
6. **Driver/CLI**: the C driver and Python runners are still part of the
   toolchain. A Sailfin-native CLI must replace them before 1.0.
7. **Incomplete helpers**: `get_field`, `array_map/filter/reduce`,
   `to_debug_string`, and `log_execution` are minimal. These must be fully
   implemented with correct semantics and tests.

## Production-Ready Runtime Work Ahead

This is the concrete work needed to move from the current C runtime to a
production-grade Sailfin-native runtime and toolchain.

### Architecture alignment

- Define and lock a Sailfin-native ABI (string/array layouts, tagged values,
  ownership rules) and update compiler lowering to emit it directly.
- Replace pointer-tagging hacks (immediate codepoints, C string heuristics)
  with explicit value representations in the native ABI.
- Specify a real memory model (RC/arena/GC) and reflect it in codegen, runtime
  helpers, and drop semantics.

### Core runtime subsystems

- Implement native equivalents for string/array operations with correct UTF-8
  grapheme semantics and predictable allocation behavior.
- Implement type metadata emission, descriptors, and runtime queries
  (`is_*`, `resolve_type`, `instance_of`, `get_field`).
- Replace the current exception model with a compiler/runtime design that
  supports structured unwind and preserves diagnostics.

### Concurrency and effects

- Replace stubbed `spawn/channel/parallel/serve` with a scheduler, channel
  implementation, and server dispatch.
- Provide native adapters for filesystem, HTTP, and model effects that match
  the prelude contracts and capability enforcement.

### Tooling and integration

- Replace `native_driver.c` with a Sailfin-native CLI binary.
- Remove runtime shims and Python legacy artifacts once the native runtime and
  CLI cover all compile/run/test workflows.

### Performance and diagnostics

- Remove bootstrap-era defensive padding and pointer-safety heuristics once the
  ABI is stabilized.
- Add profiling hooks and structured logging for runtime services.

## ABI Recommendation

Adopt a **Sailfin-native ABI** (versioned) and retire the C ABI entirely before
1.0. This provides predictable memory layouts, explicit ownership rules, and
room for future runtime features (type metadata, exception frames, concurrency,
and safer FFI).

### Proposed Native ABI Primitives (Initial Sketch)

See `docs/runtime_abi.md` for the draft v0 ABI contract and migration plan.

- **String**: `{ i8* data, i64 len }` with UTF-8 bytes; no implicit NUL.
- **Array/Slice**: `{ T* data, i64 len, i64 cap }` for owned arrays and
  `{ T* data, i64 len }` for borrowed slices.
- **Value**: tagged payload for dynamic values (`enum`-like layout with tag +
  inline/ptr storage).
- **Exception frame**: explicit frame structure holding message pointer and
  unwind linkage (compiler/runtime owned).

### Compatibility Strategy

- Migrate the compiler lowering to emit native ABI calls directly.
- Avoid shipping a compatibility shim in 1.0; use targeted migration helpers
  during development only.

## Recommendations

- **Decide ABI direction early**: Lock the Sailfin-native ABI and document the
  initial layouts + versioning strategy in this file.
- **Bootstrap with a "native runtime MVP"**: Prioritize strings, arrays,
  exceptions, filesystem, and logging so the compiler can self-host without
  C.
- **Parallelize adapters and async runtime**: These are high-surface features
  but can be developed in parallel once the ABI and core helpers are stable.

## Pre-1.0 Acceptance Checklist

- [ ] Compiler lowering emits the Sailfin-native ABI (no C ABI or C strings).
- [ ] C runtime removed from build artifacts and packaging.
- [ ] Python runtime shims removed from the runtime package and toolchain.
- [ ] Native runtime implements required helpers (strings, arrays, exceptions,
      type metadata, process execution, logging).
- [ ] Native capability adapters ship for filesystem, HTTP, and model calls.
- [ ] Native async runtime implements spawn/channel/serve with tests.
- [ ] Sailfin-native CLI replaces Python/C drivers for `sfn` workflows.

## Suggested Milestones

- **M0: ABI Decision + Audit**: Lock ABI strategy, document in this file.
- **M1: Core Runtime**: Strings, arrays, exceptions, bounds checks, logging,
  process execution, and type metadata.
- **M2: Capability Adapters**: FS/HTTP/model adapters in Sailfin; remove
  Python shims from native execution.
- **M3: Async Runtime**: Spawn, channel, serve; integrate with coroutine
  lowering and add native execution tests.
- **M4: Native CLI + Driver**: Replace the C driver and Python runner
  with Sailfin-native CLI, update packaging/tooling.
