# Pipeline stage failure lookup

Use this table to map a compiler diagnostic to the file(s) most likely to contain the bug. Stages run top-to-bottom; an error at stage N means stages 1..N-1 accepted the input.

| Diagnostic shape | Stage | Canonical file(s) |
|---|---|---|
| Unexpected token / unterminated literal | Lex | `compiler/src/lexer.sfn` |
| Expected `<construct>` / unexpected syntax | Parse | `compiler/src/parser/` |
| Unknown AST node shape in downstream pass | AST | `compiler/src/ast.sfn` |
| Type mismatch / undefined symbol / duplicate symbol | Typecheck | `compiler/src/typecheck.sfn`, `compiler/src/typecheck_types.sfn` |
| Missing effect annotation / effect not declared | Effects | `compiler/src/effect_checker.sfn` |
| `.sfn-asm` emission error / malformed IR instruction | Emit | `compiler/src/emit_native.sfn`, `compiler/src/emit_native_state.sfn`, `compiler/src/native_ir.sfn` |
| LLVM `clang` rejects generated `.ll` | Lowering | `compiler/src/llvm/lowering/` (start at `entrypoints.sfn`) |
| Linker: undefined / duplicate symbol | Emission header / globals | `compiler/src/llvm/lowering/emission_header.sfn`, `module_globals.sfn` |
| Runtime crash in a valid program | Runtime / lowering runtime bridge | `runtime/prelude.sfn`, `runtime/native/`, `compiler/src/llvm/runtime.sfn` |
| Self-hosting regression (seed OK, seedcheck broken) | LLVM lowering | Compare first-pass vs second-pass IR of the same module |

## Diagnostic conventions

- Sailfin diagnostics carry source spans. Grep the failing file for the span's line to find the surrounding construct.
- Effect errors include the effect name that would satisfy them — trust the suggestion.
- LLVM errors reference IR line numbers in the generated `.ll`, not the `.sfn` source. Use the `isolate.sh` script to get the `.ll` alongside the `.sfn-asm` and correlate manually.

## When to escalate

Escalate to the `seed-stabilizer` agent (Opus) when:

- The failure is in a self-hosting build (`make check` breaks but `make compile` works, or vice versa).
- The same source compiles correctly under the seed but fails under seedcheck.
- LLVM rejects generated IR and the defect isn't obvious from a line-level diff against a working module.
- Memory use spikes >4GB for a single module during compilation.

Escalate to the `compiler-architect` agent when the fix is structural (changes cross multiple passes or requires a migration plan).
