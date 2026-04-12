The Sailfin compiler must always be able to compile itself. Before committing any change to compiler source files (compiler/src/*.sfn):

1. Run `make test` (not just a version check) to verify the test suite passes
2. If the change is structural (file splits, new modules, renamed exports), run `make clean-build` before rebuilding
3. Fix the compiler source, never the build script — `scripts/build.sh` is pure orchestration with no fixups
