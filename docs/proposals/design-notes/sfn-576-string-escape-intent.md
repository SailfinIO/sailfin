# SFN-576 — Preserve string escape intent through interpolation lowering

> Single-issue design note (no SFEP number). This closes SFEP-0057's literal
> `${` escape while keeping the proposal's ordinary string-escape semantics
> unchanged.

## Decision

`\$` is a recognized string escape and decodes to `$`. It is only semantically
necessary before `{`, where `\${` produces literal `${` text instead of opening
an interpolation. Other unknown escapes retain the existing backslash-drop
behavior: `\z` decodes to `z`.

The parser stores both the decoded `StringLiteral.value` and the original,
quoted `StringLiteral.lexeme`. AST-to-Sailfin and AST-to-native emission use the
lexeme when it is present; synthetic string AST nodes keep `lexeme: null` and
continue to quote their decoded value.

This representation is necessary because decoding alone loses information:
`\${name}` and `\\${name}` would otherwise both reach the emitter as the same
decoded `\${name}` value. Keeping the lexeme lets the existing lowering scanner
observe the original escape parity:

- `\${name}` skips the escaped `$` and lowers as literal `${name}`.
- `\\${name}` decodes the escaped backslash in the literal fragment, then
  lowers `${name}` as interpolation.

No interpolation-scanner behavior changes.

## Alternatives

- **Preserve the backslash for every unknown escape.** Rejected because it
  changes all unknown-escape semantics and still cannot distinguish the two
  required interpolation cases after AST decoding.
- **Reject unknown escapes.** Rejected as a broader language change than
  SFEP-0057 requires and incompatible with the established backslash-drop
  behavior.
- **Encode escape intent with a sentinel inside `StringLiteral.value`.**
  Rejected because the decoded value is a semantic AST field used by other
  consumers; an internal sentinel could leak outside emission.

## Audit and coverage

The required `compiler/tests/**` and `runtime/**` regex audit found no live
string literal relying on an unknown escape's dropped backslash. Matches were
comments describing regex, NUL, or path syntax. The regression test deliberately
adds `\z == z` to pin the compatibility decision alongside both interpolation
escape-parity cases.

Verification is the SFN-576 contract:

- `build/bin/sfn test compiler/tests/unit/interpolation_dollar_test.sfn`
- `make compile`
- `make check`
