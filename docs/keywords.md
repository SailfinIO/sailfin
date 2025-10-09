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
- `scope` (reserved keyword for planned structured concurrency API; not usable in bootstrap)
- `with`

Note on logging identifiers:
- In the lexer, `print` and `info` are tokens that enable the `print.info(...)`
	and `print.error(...)` style. The bootstrap code generator injects
	`print = runtime.console` so this pattern works; avoid shadowing `print` in
	user code. Prefer `print.info(...)` over `console.info(...)` in Sailfin
	sources.

### Literals

- `true`
- `false`
- `null`

### Prompt Composition

- `prompt`
- Channel names are ordinary identifiers in bootstrap; the canonical set is
	`system`, `user`, `assistant`, `tool`. There is no enforcement of this set in
	stage0.


### Reserved identifiers (not keywords)

- None specific to printing. In the bootstrap backend, `print` is bound to `runtime.console` so that `print.info(...)` is the idiomatic and supported form. Older docs may show `console.info(...)`; prefer `print.info(...)` in source.

> Notes:
> - `assert` is implemented as a statement (no parentheses required) and lowers
>   to Python `assert` in the bootstrap backend.
> - `is` is implemented as a binary type-check operator and lowers to
>   `runtime.check_type(value, "Type")` in the bootstrap backend.
> - `model`, `pipeline`, `tool`, and `test` are implemented as declarations in
>   the parser. The code generator emits simple stubs: models as data objects,
>   pipelines/tools as plain functions, and tests as ordinary routines. No
>   special pipeline operator exists in stage0.

### Self-hosted parser status

- The Sailfin-native parser now surfaces `interface`, `enum`, and `type`
	declarations as first-class AST nodes, matching the bootstrap compiler's
	structure for downstream analysis.
- Block bodies preserve `prompt` statements structurally, allowing effect
	checking without heuristics.
