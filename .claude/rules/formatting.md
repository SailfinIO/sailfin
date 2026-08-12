CI runs `sfn fmt --check` on every `.sfn` file under `compiler/src/`,
`compiler/capsules/`, and `runtime/` and fails the build if any file would be reformatted.

Before committing any `.sfn` change: `sfn fmt --write` the touched files, then
`sfn fmt --check` them to confirm a clean round-trip. If `--check` still flags a
file, re-run `--write` and read the diff — `fmt` may have collapsed or expanded
a construct in a way worth knowing about.

Formatting is canonical. Never hand-tune indentation, brace placement, or import
ordering after `fmt` has run; output you disagree with is a bug in `sfn fmt`, not
a license to deviate.
