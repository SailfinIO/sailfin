# Reserved Keywords in Sailfin

Updated: October 2025

This reference lists the tokens that the Sailfin compiler reserves today, along
with notes about parser behavior. For an implementation snapshot across the
toolchain, consult `docs/status.md`.
For an implementation snapshot across the toolchain, consult `docs/status.md`.

## Current Keyword Set

The following keywords cannot be reused as identifiers in the compiler.

### Control Flow & Errors

- `if`
- `else`
- `for`
- `in`
- `match`
- `return`
- `assert`
- `try`
- `catch`
- `finally`
- `throw`
- `loop`
- `break`
- `continue`

### Functions, Types & Declarations

- `fn`
- `async`
- `await`
- `extern`
- `let`
- `mut`
- `unsafe`
- `struct`
- `enum`
- `interface`
- `implements`
- `type`
- `is`
- `import`
- `export`
- `from`
- `as` — Type casting operator (e.g., `ptr as *i32`)
- `model`
- `tool`
- `pipeline`
- `test`

### Unsafe & FFI

- `unsafe` — Marks functions or blocks that perform low-level operations
- `extern` — Declares external C ABI functions
- `raw` — Raw pointer creation expression (`&raw value`)
- `opaque` — Target type for opaque foreign pointers (`*opaque`)

### Concurrency & Utilities

- `routine`
- `scope` *(reserved for future structured concurrency; not usable yet)*
- `with`

### Literals

- `true`
- `false`
- `null`

### Prompt Composition

- `prompt`
- Channels (`system`, `user`, `assistant`, `tool`) are ordinary identifiers
  unless the prompt syntax is used; the canonical set is not enforced yet.

### Reserved Identifiers (Runtime)

- `print` and `info` tokenise specially to support `print.info(...)`. Avoid
  shadowing `print`.

> Behaviour notes:
> - `is` lowers to `runtime.check_type`.
> - `model`, `pipeline`, `tool`, and `test` parse today but may generate stubs;
>   the pipeline operator `|>` remains design-stage syntax.

## Parser Notes

- The Sailfin-native parser mirrors the keyword set above and emits structured
  nodes for `interface`, `enum`, `type`, `prompt`, and decorator-bearing
  blocks.
- Decorator metadata is analysed so `@trace` implies an `io` effect when missing.
- Future keywords discussed in proposals (e.g., `training`) remain unimplemented
  until they appear in `docs/status.md`.

Track additions or removals through `docs/roadmap.md` and update this file when
new keywords land.
