# Reserved Keywords in Sailfin (Bootstrap Compiler)

The bootstrap compiler recognises the following tokens as reserved keywords.
They may not be repurposed as identifiers. The set is expected to expand as
the language matures.

### Control Flow and Error Handling

- `if`
- `else`
- `match`
- `return`
- `assert`
- `try`
- `catch`
- `finally`
- `throw`

### Functions, Types, and Declarations

- `fn`
- `async`
- `await`
- `let`
- `mut`
- `const`
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

### Concurrency and Utilities

- `routine`
- `scope`
- `with`
- `print` and `info` (surface syntax for logging: use `print.info(...)`)

### Literals

- `true`
- `false`
- `null`

### Prompt Composition

- `prompt`
- `system`
- `user`
- `assistant`
- `tool`


### Reserved identifiers (not keywords)

- None specific to printing. In the bootstrap backend, `print` is bound to `runtime.console` so that `print.info(...)` is the idiomatic and supported form. Older docs may show `console.info(...)`; prefer `print.info(...)` in source.

> **Notes:**
> * `is` is reserved for prospective pattern or type guard syntax; it is not yet part of the stable surface.
