---
applyTo: "runtime/**"
---

# Runtime Instructions

When working in the runtime directory:

- `runtime/` is the runtime capsule root (manifest at `runtime/capsule.toml`, `kind = "runtime"`, `name = "sfn/runtime-native"`). `runtime/native/` is deleted (#822).
- `runtime/sfn/` contains the Sailfin-native runtime modules; `runtime/prelude.sfn` is the Sailfin-native runtime facade (collections, strings, type checks).
- The runtime is linked into every compiled binary; keep it lean.
- Document runtime ABI changes in `site/src/content/docs/docs/reference/runtime-abi.md` (published at [sailfin.dev/docs/reference/runtime-abi](https://sailfin.dev/docs/reference/runtime-abi)).
- Track C→Sailfin migration progress in `docs/runtime_audit.md`.
