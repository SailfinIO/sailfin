# Runtime Helper Audit

Updated: October 2025

This audit tracks runtime helpers that the Sailfin stage1 toolchain currently sources from the Python bootstrap runtime (`runtime/runtime_support.py`). Items marked "Sailfin-native" already live in `runtime/prelude.sfn` and are compiled by stage1. Items marked "Python bridge" still delegate to the bootstrap helpers and should gain Sailfin-native implementations alongside regression coverage before we can remove the Python runtime dependency entirely.

| Helper | Current implementation | Status | Notes / Follow-up |
|--------|------------------------|--------|-------------------|
| `array_map`, `array_filter`, `array_reduce`, `parallel` | `runtime/prelude.sfn` | Sailfin-native | Covered by `compiler/tests/test_runtime_prelude.py`. |
| `substring`, `find_char`, `char_code`, `clamp` | `runtime/prelude.sfn` | Sailfin-native | ASCII + UTF-8 behaviour documented in `docs/spec.md` §10.2; regression coverage in `compiler/tests/test_runtime_prelude.py` and `compiler/tests/test_string_utils.py`. |
| `sleep`, `channel`, `spawn`, `serve`, `http`, `websocket`, `logExecution`, `console`, `fs` | Aliases to `runtime.runtime_support` | Python bridge | Require Sailfin-native implementations or thin effect-aware shims; track under "Capability bridges" and "Concurrency substrate" roadmap tasks. |
| `match_exhaustive_failed` | `runtime/prelude.sfn` | Sailfin-native | Raises a ValueError via `runtime.raise_value_error`; regression covered by `compiler/tests/test_runtime_prelude.py`. |
| `EnumType`, `EnumInstance` helpers | `runtime/prelude.sfn` | Sailfin-native | Enum metadata + instantiation handled in Sailfin with lowering rewrites; regression coverage in `compiler/tests/test_runtime_prelude.py`. |
| `struct_repr` | `runtime/prelude.sfn` | Sailfin-native | Struct `__repr__` generation wired through lowering with helper coverage in `compiler/tests/test_runtime_prelude.py`. |
| `check_type` and `_resolve_runtime_type` | `runtime/prelude.sfn` (+ helpers in `runtime/runtime_support.py`) | Sailfin-native | Descriptor parser + recursive evaluator now live in Sailfin; still depends on `resolve_runtime_type` bridge until module metadata lands. |
| `format_interpolated` | `runtime/prelude.sfn` (+ shim in `runtime/runtime_support.py`) | Sailfin-native | Interpolation now lowers to segment arrays without Python `eval`; coverage in `compiler/tests/test_runtime_prelude.py` and `compiler/tests/test_string_interpolation.py`. |
| `_WebSocket*`, `_HttpModule`, `_Request`, `_Response` mock helpers | `runtime/runtime_support.py` | Python bridge | Replace with Sailfin stubs once capability bridges are in place; covered by roadmap capability workstream. |

Next actions:

1. Generate module type metadata so named descriptors no longer rely on `resolve_runtime_type` bridge.
2. Update the legacy Stage0 fallback to share the Sailfin interpolation helper so `runtime.format_string` can retire.
3. Remove the remaining Python bridges once regression coverage proves the Sailfin-native helpers pass across Stage0/Stage1 pipelines.
