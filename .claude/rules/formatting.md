CI runs `sfn fmt --check` on every `.sfn` file under `compiler/src/` and
`runtime/`, and fails the build if any file would be reformatted. Agents
routinely forget this step and discover it via a red CI run after pushing.

Before committing changes that touch any `.sfn` file:

1. Run `sfn fmt --write <files>` (or `build/native/sailfin fmt --write
   compiler/src/ runtime/`) on every modified file. The formatter is
   zero-configuration — there is no formatting decision to make.
2. Then run `sfn fmt --check` on the same paths to confirm a clean
   round-trip. If `--check` still flags a file, re-run `--write` and read
   the diff before committing — `fmt` may have collapsed or expanded a
   construct in a way that's worth knowing about.
3. Memory cap and timeout still apply: prefix with `ulimit -v 8388608` and
   wrap with `timeout 30` per file.

Formatting is canonical — never hand-tune indentation, brace placement,
or import ordering after `fmt` has run. If the formatter produces output
you disagree with, that's a bug in `sfn fmt`, not a license to deviate.
