---
applyTo: "runtime/**"
---

# Runtime Instructions

When working in the runtime directory:

- `runtime/native/` contains the current C runtime (planned for migration to Sailfin pre-1.0).
- `runtime/prelude.sfn` is the Sailfin-native runtime facade (collections, strings, type checks).
- Changes to the C runtime should be minimal — prefer implementing new functionality in Sailfin.
- The runtime is linked into every compiled binary; keep it lean.
- Document runtime ABI changes in `docs/runtime_abi.md`.
- Track C→Sailfin migration progress in `docs/runtime_audit.md`.
