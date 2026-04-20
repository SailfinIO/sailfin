---
applyTo: "runtime/**"
---

# Runtime Instructions

When working in the runtime directory:

- `runtime/native/` contains the current C runtime (planned for migration to Sailfin pre-1.0).
- `runtime/prelude.sfn` is the Sailfin-native runtime facade (collections, strings, type checks).
- Changes to the C runtime should be minimal — prefer implementing new functionality in Sailfin.
- The runtime is linked into every compiled binary; keep it lean.
- Document runtime ABI changes in `site/src/content/docs/docs/reference/runtime-abi.md` (published at [sailfin.dev/docs/reference/runtime-abi](https://sailfin.dev/docs/reference/runtime-abi)).
- Track C→Sailfin migration progress in `docs/runtime_audit.md`.
