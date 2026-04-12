# Full Compiler Validation

Run the full `make check` validation pipeline for the Sailfin compiler. This validates that the compiler can self-host and pass all tests.

## Steps

1. Set a memory cap to protect against runaway compilation: `ulimit -v 8388608`
2. Run `make clean-build` to ensure a fresh build state
3. Run `make check` which:
   - Builds the compiler from the seed
   - Runs the full test suite on the first-pass binary
   - Builds seedcheck from the first-pass binary
   - Validates seedcheck can run `examples/basics/hello-world.sfn`
   - Runs the full test suite using the seedcheck binary
4. If any step fails, diagnose the failure — read the error output carefully, identify the failing module/test, and report what went wrong with the relevant source location.

## Important

- Always apply `ulimit -v 8388608` before invoking the compiler.
- If the build runs longer than 20 minutes, something is likely wrong — investigate.
- If `make check` fails, the compiler has a bug. Do not work around it in the build script.
