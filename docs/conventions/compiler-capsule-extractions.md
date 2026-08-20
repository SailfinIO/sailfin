# Compiler capsule extraction procedure

Use this procedure for the physical compiler-capsule moves in SFEP-0020 §3.7.
SFN-741 established it with `sfn/syntax`; later leaves should reuse the same
member, manifest, bootstrap, boundary, and determinism checks.

## Workspace and manifest template

Compiler implementation capsules currently live at
`compiler/capsules/<role>/`, are members of the `compiler/capsules/*`
workspace glob, and expose a `src/mod.sfn` facade. SFEP-0072 later relocates
them to `compiler/<role>/`; architectural authority does not follow either
path. Their canonical manifest names (`sfn/syntax`, `sfn/analyzer`, `sfn/ir`,
`sfn/codegen`, and `sfn/codegen-llvm`) select the SFEP-0020 role, privacy,
capability, dependency, release, artifact, and cache policy. Their manifests
use the compiler release version, `publish = false`, `kind = "library"`, and
`required = []`. Consumers import the facade by capsule name rather than
reaching into its physical source tree.

Keep physical member discovery, source/entry containment, formatter and test
enumeration, and retired-root checks path-based. A directory named like a
compiler role must never gain authority unless its resolved manifest carries
the corresponding canonical name; conversely, moving that manifest between an
allowed current or target root must not change its authority.

The compiler freshness fingerprint, fast-check roots, formatter roots,
determinism-sweep roots, release safety paths, and CI cache hashes must all
include `compiler/capsules`. A physical move is incomplete if any of those
gates still sees only `compiler/src`.

## Pinned-seed dependency resolution

The 0.9.3 pinned seed is transitive, not flat. On 2026-08-09 the live
`seed_private_workspace_fixture_test.sfn` probe passed against
`build/toolchains/seed/bin/sfn`: a nested private library depended on a second
private library that the binary did not declare, and the seed staged, linked,
and ran the complete closure. A compiler implementation capsule therefore
declares its own narrow-standard-library dependencies; do not duplicate those
edges on `compiler/capsule.toml` solely for bootstrap resolution. A dependency
the compiler's own source imports directly remains a direct compiler edge.

Re-run the fixture after a seed change before relying on this answer:

```bash
build/bin/sfn test compiler/tests/e2e/seed_private_workspace_fixture_test.sfn
```

## Rename-only artifact classification

Capture representative or complete per-module textual IR before and after the
move. Create a tab-separated map with every old and new path/module spelling,
including both slash-form slugs and mangled `__` forms. Then classify each
paired artifact:

```bash
scripts/classify_rename_only_ir.sh before.ll after.ll rename-map.tsv
```

The classifier normalizes both sides to the same markers and compares the
remaining bytes. It exits 0 only when the files are identical after those
explicit substitutions; an instruction, type, constant, ordering, or other
semantic difference remains visible in its unified diff and exits 1. Map
longer and shorter spellings freely—the tool applies the longest pairs first.

Also emit an unchanged user program before and after the compiler move. That
artifact should normally be byte-identical because compiler implementation
names do not belong in user output. Finish with the issue's determinism sweep
and the clean structural self-host gate.
