# Reserved Keywords in Sailfin (Bootstrap Compiler)

The bootstrap compiler recognises the following tokens as reserved keywords.
They may not be repurposed as identifiers. The set is expected to expand as
the language matures.

### Control Flow and Error Handling

- `if`
- `else`
- `match`
- `return`
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
- `import`
- `from`

### Concurrency and Utilities

- `routine`
- `print`
- `info`

### Literals

- `true`
- `false`
- `null`

> **Note:** `print` and `info` are reserved so that the idiomatic
> `print.info(...)` helper can be recognised uniformly. The compiler currently
> treats them like ordinary identifiers when emitting Python code, so shadowing
> them is discouraged but technically possible.
