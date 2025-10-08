# Type System Examples

Focuses on advanced type constructs: recursive structs, tagged unions / algebraic data types, and pattern matching with destructuring.

## Files

- **`recursive-types.sfn`** – Binary tree with optional (`?`) child references and an inorder traversal.
- **`tagged-unions.sfn`** – ADT-style enum with multiple payload variants and a total `match` computing area.

## Notes

- Optionals use the `Type?` suffix.
- Pattern matching with struct-like variant destructuring will expand to support guards & exhaustive checking in the self-hosted compiler.
