# Repository topology path-audit classification

SFEP-0072 separates physical repository placement from logical capsule
identity. Use this inventory when reviewing the acceptance audit for a
topology migration leaf:

```sh
rg -n 'compiler/capsules|capsules/sfn|runtime/prelude' \
  workspace.toml Makefile compiler runtime capsules .github scripts docs .codex
```

Every hit belongs to exactly one semantic class. Classification is based on
what the path controls, not on the filename containing it.

| Class | Surfaces in the audit | Migration rule |
|---|---|---|
| `logical` | Compiler capsule boundary and dependency checks; publication/privacy policy; version lockstep and release selection; capability ceilings; artifact namespaces | Resolve the owning workspace member and use `[capsule].name`, dependency metadata, and `publish`. A repository prefix must not grant identity or authority. |
| `physical` | `workspace.toml` discovery; manifest entry/source containment; formatter, watcher, package, and test discovery; living contributor navigation | Expand the workspace inventory and validate the current, transitional, or target domain roots. Update a living path in the same structural slice that moves it. |
| `hybrid` | Module identity, import contexts, source/layout fingerprints, cache keys, and CI cache inputs | Combine canonical capsule identity with capsule-relative paths and content. Absolute checkout paths and legacy domain prefixes are not logical identity. |
| `historical` | Accepted/archived SFEP alternatives, RCAs, design-note incident records, migration fixtures, and provenance comments that describe an earlier layout | Preserve the literal path when it is evidence or intentional fixture data. Historical citations are evidence, not migration defects. |

## Maintained surface inventory

| Audit surface | Class | Expected treatment |
|---|---|---|
| `workspace.toml` and workspace resolver fixtures | `physical` | Keep dual globs only while that migration slice needs them; reject duplicate canonical member names independently. |
| `compiler/tests/unit/repository_topology_test.sfn` and its fixtures | `physical` | Admit only SFEP-0072 current, transitional, and target member shapes; require contained manifests and entries. |
| Dormant `capsules/sfn/prelude` manifest shell | `physical` | Admit only the exact canonical name and `../../../runtime/prelude.sfn` entry while the current layout is supported; remove the exception with SFEP-0072's prelude-adoption slice. |
| `compiler/tests/unit/compiler_capsule_boundary_test.sfn` | `logical` | Replace physical owner prefixes with resolved manifest identity in SFEP-0072 slice 4; do not weaken dependency rules during the transition. |
| `compiler/src/module_paths.sfn` and import ownership/reachability checks | `hybrid` | Resolve physical ownership through the workspace, then derive manifest identity and capsule-relative module paths. |
| `compiler/src/build/source_fingerprint.sfn`, `scripts/module_layout_fingerprint.sh`, CI cache inputs | `hybrid` | Discover physical inputs from the workspace, then hash stable logical identity plus content. |
| Build cache and `build/capsules/<scope>/<name>` artifact routing | `hybrid` | Keep manifest-derived artifact namespaces; exclude absolute checkout location from cache identity. |
| `Makefile`, formatting, benchmarks, package/install inputs, and test discovery | `physical` | Consume discovered roots while preserving existing target names and exact-once coverage. |
| Seed/bootstrap fixtures | `physical` | Prove the pinned seed accepts every committed transitional workspace and dependency closure. |
| Release and release-train workflows | `logical` | Discover manifests physically, then select and lockstep compiler roles by canonical identity. |
| Living docs, `.codex`, `.github/agents`, and repository instructions | `physical` | Update navigation and commands with the slice that changes the path. |
| Accepted/archived proposals, design notes, RCAs, and intentional old-layout fixtures | `historical` | Leave literal citations intact unless the document claims to describe the current tree. |

When one line serves two purposes, split the purposes before migration or mark
it `hybrid`; do not choose whichever class makes a search count smaller. New
audit hits must be assigned by the same authority question: “does this path
locate bytes, identify a capsule, do both, or record history?”
