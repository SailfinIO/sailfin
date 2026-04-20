# Functional Examples

Explores first-class functions, higher-order patterns, method-style collection helpers, and immutable-style transformations.

## Files

- **`higher-order-functions.sfn`** – Passing functions as values (`apply` + `double`).
- **`map-reduce.sfn`** – Inline lambdas with `map` and `reduce` style helpers to transform and aggregate a list.

## Notes

- Function types like `(number) -> number` are parsed; deeper type inference & closure capture analysis will land in the self-hosted compiler.
- The `|>` pipeline operator is a planned post-1.0 feature — not yet in the parser.
