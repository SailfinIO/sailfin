# Test a Specific Feature

Run targeted tests for a specific compiler feature or area.

## Feature: $ARGUMENTS

## Steps

1. Find relevant test files:
   - Search `compiler/tests/unit/` for tests matching the feature name
   - Search `compiler/tests/integration/` for integration tests
   - Search `compiler/tests/e2e/` for end-to-end tests

2. Run the targeted tests:
   ```
   timeout 60 build/bin/sfn test <test_file>
   ```

3. If tests pass, also run the full suite to check for regressions:
   ```
   make test
   ```

4. Report results: which tests passed, which failed, and for failures include the diagnostic output with source locations.

## Important

- The compiler self-caps memory (8 GiB on Linux); see `.claude/rules/compiler-safety.md`.
- If you can't find tests for the feature, say so — don't skip this step silently.
