# Runtime Helper Audit

Updated: October 2025

This audit tracks runtime helpers that the Sailfin stage1 toolchain currently sources from the Python bootstrap runtime (`runtime/runtime_support.py`). Items marked "Sailfin-native" already live in `runtime/prelude.sfn` and are compiled by stage1. Items marked "Python bridge" still delegate to the bootstrap helpers and should gain Sailfin-native implementations alongside regression coverage before we can remove the Python runtime dependency entirely.

| Helper                                                                       | Current implementation                                            | Status         | Notes / Follow-up                                                                                                                                                                            |
| ---------------------------------------------------------------------------- | ----------------------------------------------------------------- | -------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| `array_map`, `array_filter`, `array_reduce`, `parallel`                      | `runtime/prelude.sfn`                                             | Sailfin-native | Covered by `compiler/tests/test_runtime_prelude.py`.                                                                                                                                         |
| `substring`, `find_char`, `char_code`, `clamp`                               | `runtime/prelude.sfn`                                             | Sailfin-native | ASCII + UTF-8 behaviour documented in `docs/spec.md` §10.2; regression coverage in `compiler/tests/test_runtime_prelude.py` and `compiler/tests/test_string_utils.py`.                       |
| `sleep`, `channel`, `spawn`, `serve`, `websocket`, `logExecution`, `console` | Aliases to `runtime.runtime_support`                              | Python bridge  | Require Sailfin-native implementations or thin effect-aware shims; tracked under concurrency and runtime roadmap tasks.                                                                      |
| `capability_grant`, `fs_bridge`, `http_bridge`, `model_bridge`               | Sailfin wrappers + Python delegate                                | Hybrid         | Runtime capability grants enforce `io`/`net`/`model` permissions while delegating to bootstrap shims. Regression: `compiler/tests/test_runtime_prelude.py::test_runtime_capability_bridges`. |
| `match_exhaustive_failed`                                                    | `runtime/prelude.sfn`                                             | Sailfin-native | Raises a ValueError via `runtime.raise_value_error`; regression covered by `compiler/tests/test_runtime_prelude.py`.                                                                         |
| `EnumType`, `EnumInstance` helpers                                           | `runtime/prelude.sfn`                                             | Sailfin-native | Enum metadata + instantiation handled in Sailfin with lowering rewrites; regression coverage in `compiler/tests/test_runtime_prelude.py`.                                                    |
| `struct_repr`                                                                | `runtime/prelude.sfn`                                             | Sailfin-native | Struct `__repr__` generation wired through lowering with helper coverage in `compiler/tests/test_runtime_prelude.py`.                                                                        |
| `check_type` and `_resolve_runtime_type`                                     | `runtime/prelude.sfn` (+ helpers in `runtime/runtime_support.py`) | Sailfin-native | Descriptor parser + recursive evaluator now live in Sailfin; still depends on `resolve_runtime_type` bridge until module metadata lands.                                                     |
| `format_interpolated`                                                        | `runtime/prelude.sfn` (+ shim in `runtime/runtime_support.py`)    | Sailfin-native | Interpolation now lowers to segment arrays without Python `eval`; coverage in `compiler/tests/test_runtime_prelude.py` and `compiler/tests/test_string_interpolation.py`.                    |
| `_WebSocket*`, `_HttpModule`, `_Request`, `_Response` mock helpers           | `runtime/runtime_support.py`                                      | Python bridge  | Replace with Sailfin stubs once capability bridges are in place; covered by roadmap capability workstream.                                                                                   |

## Stage2 Adapter Registration

As of October 2025, Stage2Runner now registers capability adapters that bridge LLVM ABI calls to Python runtime helpers. The adapter registration happens in `Stage2Runner.__init__` via the `_initialise_runtime_helpers` method, which:

1. Maps adapter symbol names (e.g., `sailfin_adapter_fs_read_file`) to Python callback implementations
2. Enforces capability requirements before executing adapter operations
3. Marshals LLVM pointer arguments to/from Python strings and objects

### Registered Adapters

| Adapter Symbol                             | Effect    | Signature            | Purpose                                                         |
| ------------------------------------------ | --------- | -------------------- | --------------------------------------------------------------- |
| `sailfin_adapter_fs_read_file`             | `io`      | `(i8*) -> i8*`       | Reads file contents; bridges to `runtime_support.fs.readFile`   |
| `sailfin_adapter_fs_write_file`            | `io`      | `(i8*, i8*) -> void` | Writes file contents; bridges to `runtime_support.fs.writeFile` |
| `sailfin_adapter_fs_list_directory`        | `io`      | `(i8*) -> i8*`       | Lists directory entries; returns JSON array representation      |
| `sailfin_adapter_http_get`                 | `net`     | `(i8*) -> i8*`       | HTTP GET request; bridges to `runtime_support.http.get`         |
| `sailfin_adapter_http_post`                | `net`     | `(i8*, i8*) -> i8*`  | HTTP POST request; returns JSON response                        |
| `sailfin_adapter_model_invoke_with_prompt` | `model`   | `(i8*, i8*) -> i8*`  | Model invocation; mock implementation                           |
| `sailfin_adapter_serve_start`              | `io`      | `(i8*, i8*) -> void` | Starts HTTP server; mock implementation                         |
| `sailfin_adapter_serve_handler_dispatch`   | `io`      | `(i8*, i8*) -> i8*`  | Dispatches handler; returns JSON response                       |
| `sailfin_adapter_spawn_task`               | `spawn`   | `(i8*, i8*) -> void` | Spawns async task; mock implementation                          |
| `sailfin_adapter_channel_create`           | `channel` | `(i64) -> i8*`       | Creates channel; bridges to `runtime_support.channel`           |
| `sailfin_adapter_channel_send`             | `channel` | `(i8*, i8*) -> void` | Sends to channel; mock implementation                           |
| `sailfin_adapter_channel_receive`          | `channel` | `(i8*) -> i8*`       | Receives from channel; mock implementation                      |

### Capability Enforcement

The adapter registration flow ensures capability requirements are checked before execution:

1. **Compilation**: Adapter calls in Sailfin code emit LLVM external declarations annotated with effect metadata
2. **Registration**: `Stage2Runner.__init__` creates C function wrappers for each adapter symbol via `_make_adapter`
3. **Execution**: When native code invokes an adapter, the wrapper:
   - Retrieves the active `CapabilityGrant` from context variable
   - Calls `grant.require(effect)` to verify the required capability is granted
   - If authorized, marshals arguments and delegates to the Python runtime helper
   - If unauthorized, raises `PermissionError` with diagnostic message

### Memory Management

The current adapter implementation uses simplified memory management:

- String arguments: LLVM `i8*` pointers are cast to `ctypes.c_char_p` and decoded as UTF-8
- String returns: Python strings are encoded to UTF-8 and wrapped in `ctypes.create_string_buffer`
- Object lifetimes: String buffers created in adapters have automatic lifetime tied to the Python wrapper scope

Production-ready adapters will need explicit memory management (arena allocation, reference counting) once Stage2 moves beyond Python runtime bridges.

### Regression Coverage

End-to-end adapter tests in `compiler/tests/test_native_llvm_execution.py`:

- `test_stage2_runner_executes_fs_operations` — filesystem write/read round-trip
- `test_stage2_runner_executes_http_request` — HTTP GET with mock adapter
- `test_stage2_runner_executes_model_prompt` — model invocation with mock adapter
- `test_stage2_runner_executes_serve_handler` — server handler registration and dispatch
- `test_stage2_runner_executes_spawn_and_channel` — spawn task and channel communication
- `test_stage2_runner_enforces_capability_restrictions` — validates `PermissionError` when capabilities are missing

Next actions:

1. Replace simplified string marshalling with arena-based memory management for production use
2. Implement full async runtime integration for `spawn`, `channel`, and `serve` adapters (currently mock implementations)
3. Migrate adapter implementations from Python bridges to native Sailfin once capability workstream completes

Next actions:

1. Generate module type metadata so named descriptors no longer rely on `resolve_runtime_type` bridge.
2. Update the legacy Stage0 fallback to share the Sailfin interpolation helper so `runtime.format_string` can retire.
3. Remove the remaining Python bridges once regression coverage proves the Sailfin-native helpers pass across Stage0/Stage1 pipelines.
