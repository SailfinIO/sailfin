# Basics Examples

Foundational language constructs: variables, functions, conditionals, pattern matching, enums, interfaces, structs, tests, and basic error handling. These examples map closely to sections §3–§4 of `docs/spec.md` and the grammar in `docs/enbf.md`.

## Files

- **`hello-world.sfn`** – Minimal entry point printing to the console.
- **`variables.sfn`** – `let` vs `let mut`, simple mutation, and scope.
- **`functions.sfn`** – Function declarations, default parameters, return types.
- **`conditionals.sfn`** – `if/else if/else` plus a `match` with literals and wildcard.
- **`error-handling.sfn`** – Simple union return for error signalling via a struct.
- **`basic-enum.sfn`** – Declaring & comparing simple enums.
- **`tagged-enum.sfn`** – Enum variants with payloads + pattern matching to extract fields.
- **`interfaces.sfn`** – Interface declaration and dynamic dispatch through an interface-typed binding.
- **`structs.sfn`** – Struct with method illustrating `self` usage.
- **`struct-composition.sfn`** – Multiple concrete types implementing a common interface.
- **`tests.sfn`** – Example of a `test` block with assertions (effect list illustrative).
- **`try-catch-finally.sfn`** – Exception style error handling with `try/catch/finally`.

## Notes

- Pattern matching uses `match` with arrow clauses; wildcard is `_`.
- Union-like error signalling (e.g. `number | DivisionError`) will later integrate with richer result / effect typing.
- The bootstrap runtime stubs some behaviours (e.g. strict type checks or capability enforcement) that will tighten in the self-hosted compiler.
