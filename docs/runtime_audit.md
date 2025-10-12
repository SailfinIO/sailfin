# Runtime Helper Audit

Updated: October 2025

This audit tracks runtime helpers that the Sailfin stage1 toolchain currently sources from the Python bootstrap runtime (`runtime/runtime_support.py`). Items marked "Sailfin-native" already live in `runtime/prelude.sfn` and are compiled by stage1. Items marked "Python bridge" still delegate to the bootstrap helpers and should gain Sailfin-native implementations alongside regression coverage before we can remove the Python runtime dependency entirely.

| Helper | Current implementation | Status | Notes / Follow-up |
|--------|------------------------|--------|-------------------|
| `array_map`, `array_filter`, `array_reduce`, `parallel` | `runtime/prelude.sfn` | Sailfin-native | Covered by `compiler/tests/test_runtime_prelude.py`. |
| `substring`, `find_char`, `char_code`, `clamp` | `runtime/prelude.sfn` | Sailfin-native | ASCII + UTF-8 behaviour documented in `docs/spec.md` §10.2; regression coverage in `compiler/tests/test_runtime_prelude.py` and `compiler/tests/test_string_utils.py`. |
| `sleep`, `channel`, `spawn`, `serve`, `http`, `websocket`, `logExecution`, `console`, `fs` | Aliases to `runtime.runtime_support` | Python bridge | Require Sailfin-native implementations or thin effect-aware shims; track under "Capability bridges" and "Concurrency substrate" roadmap tasks. |
| `match_exhaustive_failed` | `runtime/runtime_support.py` | Python bridge | Port into `runtime/prelude.sfn` with a direct Sailfin `throw` once structured diagnostics exist; add matcher regression tests. |
| `EnumType`, `EnumInstance` helpers | `runtime/runtime_support.py` | Python bridge | Needed for enum constructors and reflective access; design Sailfin struct-backed equivalents plus stage1 lowering tests. |
| `struct_repr` | `runtime/runtime_support.py` | Python bridge | Replace with Sailfin string builder helper; pair with struct emission tests. |
| `check_type` and `_resolve_runtime_type` | `runtime/runtime_support.py` | Python bridge | Used for bootstrap `is` operator; plan Sailfin-native type reflection once semantic metadata lands. |
| `format_string` | `runtime/runtime_support.py` | Python bridge | Stage1 string interpolation still defers to Python; needs Sailfin expression evaluation or IR support. |
| `_WebSocket*`, `_HttpModule`, `_Request`, `_Response` mock helpers | `runtime/runtime_support.py` | Python bridge | Replace with Sailfin stubs once capability bridges are in place; covered by roadmap capability workstream. |

Next actions:

1. Port `match_exhaustive_failed` into `runtime/prelude.sfn`, extending stage1 match lowering tests.
2. Design Sailfin-native enum container (`EnumType`/`EnumInstance`) plus struct formatting utility, then update the emitter to exercise them.
3. Define a plan for type reflection (`check_type`) and string interpolation (`format_string`) that does not depend on Python evaluation.
