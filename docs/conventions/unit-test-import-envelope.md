# Unit-test import envelope

This is the canonical reference for **which `compiler/src` modules a
standalone `*_test.sfn` may import**, and why some symbols must still be
mirrored locally. It exists because the original
`check_tool_test.sfn` header misattributed the constraint to the
`char_code` / `string_utils → runtime` chain; the real constraint is
import-closure size. The full root-cause analysis lives in
[`docs/proposals/unit-test-import-envelope.md`](../proposals/unit-test-import-envelope.md)
(#619).

---

## TL;DR

- The `sfn test` runner links **`runtime/prelude`** (and the full
  runtime/globals capsule) into **every** test. Prelude exports
  (`char_code`, `strings_equal`, `substring`, collection helpers, …)
  always resolve — you never need to mirror them.
- You **may** import exported symbols from a `compiler/src` module whose
  transitive `from "..."` closure is **light**.
- You **may not** (in practice) import symbols anchored in `main.sfn`'s
  closure — that drags the full ~130-module backend into the link line,
  which is wasteful coupling and risks OOM/timeout under the test memory
  cap.

---

## Why closure size, not the runtime chain

The runner builds a single standalone test's link line in
`_clang_link_test_cmd_with_deps` (`compiler/src/cli_commands.sfn:140`)
from three strong inputs (`cli_commands.sfn:120-123`):

1. the test source's own `.ll`,
2. the resolver-produced `.ll` files for the **test's import closure**,
3. the **runtime sources + globals + prelude**, assembled by
   `assemble_runtime_capsule_link_inputs`
   (`cli_commands.sfn:51,176`).

Step 3 means the runtime / `char_code` chain is *already on every test's
link line* — importing a light `src` module that itself uses `char_code`
resolves fine. The cost is **step 2**: the resolver must compile and
link the entire transitive `from "..."` graph of the imported symbol's
home module.

---

## The two closures

| Closure | Modules | Example home module | Verdict |
|---|---|---|---|
| **Light** | ~8 | `diagnostics_render.sfn` (imports `effect_checker`, `string_utils`, `token`, `typecheck_types`) | importable from a unit test |
| **Heavy** | ~130 | `main.sfn`, `tools/check.sfn` (transitively pull `main.sfn` → full backend) | mirror locally; extraction tracked in #986 |

Proven-linkable precedents (standalone unit tests that already import
`src` symbols and pass): `effect_capabilities_test.sfn:30`
(`validate_capsule_capabilities` from `effect_checker`),
`abi_hash_determinism_test.sfn:23` (from `llvm/lowering/abi_hash`),
and `check_tool_test.sfn` (`join_effects`, `code_for_missing_effect`
from `diagnostics_render`).

---

## How to check a module's closure before importing

1. Open the home module of the symbol you want and read its top-of-file
   `import { ... } from "..."` lines.
2. Follow each `from` target transitively. If the graph stays within
   leaf utility modules (`string_utils`, `token`, `typecheck_types`,
   `effect_*`, `ast`, …) and never reaches `main.sfn` or `tools/check.sfn`,
   the closure is light — import the symbol directly.
3. If any path reaches `main.sfn` (or a module that imports it), the
   closure is heavy. Mirror the helper locally with a `_local_*` prefix,
   add a header note explaining the heavy closure, and point at the
   extraction follow-up (#986) rather than re-blaming the linker.

When in doubt, author a throwaway test that imports the symbol and run
it under the cap:

```bash
ulimit -v 8388608; timeout 60 build/native/sailfin test /tmp/probe_test.sfn
```

A light import links and passes in seconds; a heavy import surfaces as an
undefined-reference link failure, OOM, or timeout from the ~130-module
closure.

---

## Struct-literal caveat

When a real signature takes struct arguments, build **flat,
single-level** struct literals with explicit `null` for optional fields
(e.g. `EffectRequirement { effect: "io", description: desc, trigger: null }`).
Nested struct-literal initialisers segfault on some seed compilers;
single-level literals stay clear of that path.
