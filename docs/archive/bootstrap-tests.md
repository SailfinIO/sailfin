# Archived Bootstrap (Stage0) Test Suite

As of the Stage1 testing migration, the Python bootstrap test modules have been
removed from active CI runs. The historical sources previously lived under
`bootstrap/tests/` and covered:

- lexer, parser, effect checker, and type checker unit tests
- native lowering smoke tests for the bootstrap code generator
- end-to-end compiler smoke tests that executed every example capsule

These files remain available in version control history (see commit prior to
this change) and can be restored locally if deeper stage0 debugging is
required. New regression coverage should target the Sailfin-native pipeline via
`compiler/tests/`.
