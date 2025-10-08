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
-- `console`
-- `info` (reserved temporarily for `console.info` sugar; may be folded)
- `scope`
- `with`

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

> **Notes:**
> * `console` / `info` are reserved to support an idiomatic `console.info(...)` logging helper. They may become a single intrinsic in a future revision.
> * `is` is reserved for prospective pattern or type guard syntax; it is not yet part of the stable surface.
