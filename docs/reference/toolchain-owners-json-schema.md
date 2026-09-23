# Resolved tool owners JSON

`sfn toolchain owners --json` emits one compact JSON object on stdout. Its
`schema_version` is `1`; consumers must reject unknown versions. Field order is
stable. The command exits `0` only when the active native target has a complete
default LLVM object and direct-link contract. Missing prerequisites, an
unsupported target, or an explicit migration oracle exit nonzero with an
`error` string in the same object.

| Field | Meaning |
|---|---|
| `target`, `object_format` | Logical target triple and ELF, Mach-O, or COFF object format. |
| `target_profile` | Effective LLVM object triple and the CPU, features, relocation, code, exception, frame-pointer, section, and TLS/COFF flags used by object emission. `applies` is false for the explicit clang oracle or an unresolved provider. |
| `clang_free` | True only for a complete default LLVM and direct-link contract. |
| `object_provider.selected`, `object_provider.default` | Actual object selection and `llvm-cli`. An explicit `clang-oracle` remains visible even if its executable is missing. |
| `object_provider.fingerprint` | Object provider cache fingerprint. |
| `object_provider.validator`, `optimizer`, `emitter` | Resolved `path` and complete `--version` output for LLVM tools. Empty when the role is not selected or resolution fails. |
| `object_provider.oracle` | Explicit clang oracle path and version, empty for the default provider. |
| `link.selected`, `link.default`, `link.path`, `link.version` | Active and default link providers, selected linker executable, and its version. An explicit link oracle appears as `clang-oracle`; paths are empty if resolution fails. |
| `link.sdk_root`, `sdk_version`, `crt_root`, `crt_version`, `deployment_target`, `identity` | Target-specific SDK/MSVC identity. Empty where inapplicable. `identity` is the existing Darwin or Windows link identity; Linux reports its resolved inputs separately. |
| `link.crt1`, `crti`, `crtn`, `crtbegin`, `crtend`, `dynamic_loader`, `search_dirs` | The Linux direct-link CRT and library-search contract. Empty on other targets. |
| `foreign_c.state`, `foreign_c.configured` | `inactive` unless the optional compiler is configured; the configured value is shown without reading unrelated environment settings. |
| `prerequisites.object`, `prerequisites.link` | Per-role `ok` and failure `reason`; Link also has `required` to distinguish a missing owned prerequisite from an unowned target or explicit oracle. |
| `error` | Empty on success; reason the clang-free probe is unavailable otherwise. |

The report uses the same LLVM provider and direct-link resolvers as `sfn build`.
It does not download or install missing tools. The optional foreign C setting
is reported separately from first-party ownership.
