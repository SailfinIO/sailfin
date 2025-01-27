# Reserved Keywords in Sail

The following keywords are reserved in the Sail language and cannot be used as identifiers (e.g., variable names, function names, etc.):

### Control Flow

- `if`
- `else`
- `match`
- `for`
- `while`
- `break`
- `continue`
- `return`
- `throw`
- `try`
- `catch`

### Functions and Methods

- `fn`
- `self`
- `static`
- `print` # Built-in for output to the console

### Types and Data

- `let`
- `mut`
- `struct`
- `enum`
- `interface`
- `type`
- `channel`

### Concurrency

- `routine`
- `parallel`
- `await`

### Special Values

- `null`
- `true`
- `false`

### Modifiers

- `import`
- `export`

### Notes

1. Keywords like `print.info` are reserved because they are built-in functions in the Sail standard library and cannot be overridden or redefined.
2. The list is case-sensitive. For example, `print.info` is not the same as `print.info`.
