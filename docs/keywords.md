# Reserved Keywords in Sailfin

Updated: October 2025

This reference lists the tokens that the Python bootstrap compiler (stage0)
reserves today, along with notes about the Sailfin-native parser experiments.
For an implementation snapshot across the toolchain, consult `docs/status.md`.

## Bootstrap Keyword Set

The following keywords cannot be reused as identifiers in the stage0 compiler.

### Control Flow & Errors

- `if`
- `else`
- `match`
- `return`
- `assert`
- `try`
- `catch`
- `finally`
- `throw`

### Functions, Types & Declarations

- `fn`
- `async`
- `await`
- `let`
- `mut`
- `struct`
- `enum`
- `interface`
- `implements`
- `type`
- `is`
- `import`
- `from`
- `model`
- `tool`
- `pipeline`
- `test`

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
- Channels (`system`, `user`, `assistant`, `tool`) are ordinary identifiers in
  bootstrap; the canonical set is not enforced.

### Reserved Identifiers (Bootstrap Runtime)

- `print` and `info` tokenise specially to support `print.info(...)`. The code
  generator injects `print = runtime.console`; avoid shadowing `print`.

> Behaviour notes:
> - `assert` lowers to Python’s `assert`.
> - `is` lowers to `runtime.check_type`.
> - `model`, `pipeline`, `tool`, and `test` parse today but generate simple
>   stubs; the pipeline operator `|>` remains design-stage syntax.

## Self-Hosted Parser Notes

- The Sailfin-native parser mirrors the keyword set above and emits structured
  nodes for `interface`, `enum`, `type`, `prompt`, and decorator-bearing
  blocks.
- Decorator metadata is analysed so `@trace` implies an `io` effect when missing.
- Future keywords discussed in proposals (e.g., `training`) remain unimplemented
  until they appear in `docs/status.md`.

Track additions or removals through `docs/roadmap.md` and update this file when
new keywords land in stage0.
