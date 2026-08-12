# SFN-736 — Driver-owned import-context artifact reading

> Single-issue implementation design note (no SFEP number). Applies
> SFEP-0020 §§3.3 and 3.5 to the staged module-interface seam. No language,
> runtime, native-IR text, cache-key, or artifact-format change is involved.

## 1. Decision

The compiler driver owns import-context root selection, artifact-path
resolution, transitive import discovery, and all persistent reads. LLVM
lowering receives one explicit `ImportedModuleContext` value containing parsed
layout manifests, already-read native texts, discovery diagnostics, and the
driver-resolved import-slug-to-provider-slug aliases used for symbol mangling.

The payload is defined in `native_ir.sfn`, not under `llvm/`, because it is an
IR interchange contract: the driver produces it and target providers consume
it. `import_context.sfn` is the driver adapter. It resolves relative and
path-shaped module slugs, `/mod` fallbacks, `.slugalias` files, and the bounded
transitive import/export walk before calling lowering.

There is no compatibility entry point that silently re-discovers artifacts.
Every production and test lowering call supplies a context. Callers without
imports use an explicit empty value.

## 2. Authority boundary

Before this change, `llvm/imports.sfn` combined two responsibilities:

1. pure import-slug and layout-manifest application; and
2. process-global root selection plus `.layout-manifest`, `.sfn-asm`, and
   `.slugalias` discovery and reads.

That made code generation a hidden filesystem client and made its output depend
on mutable process-global state. It also forced check-oriented capsule staging
through the resolver facade and emission helpers whose import closure reached
`main.sfn` and LLVM lowering.

After the split:

| Responsibility | Owner |
|---|---|
| Work-directory to import-context-root mapping | driver `import_context.sfn` |
| Artifact existence checks, reads, aliases, and transitive BFS | driver `import_context.sfn` |
| Parsed manifests/native texts/diagnostics/aliases payload | IR `ImportedModuleContext` |
| Module-slug normalization and layout application | LLVM, pure functions only |
| LLVM generation from the supplied payload | LLVM lowering |
| Check-only resolver entry and native staging | driver modules without `main.sfn` or LLVM lowering |

The CLI's `--import-context` value is threaded through emit retry and the main
driver adapter as an ordinary argument. The previous root setter and backing
global are deleted, so concurrent or nested compilation cannot redirect a
lowering operation through ambient state.

## 3. Check closure

`check/engine.sfn` imports the check-only resolver entry directly.
`capsule_resolver/check.sfn` performs resolve/dedupe/stage work, while
`native_emit_subprocess.sfn` owns the native-only subprocess command and
`native_artifact_writer.sfn` preserves the in-process type, parse, re-export,
effect, ownership, diagnostic, and atomic-publication gates.

For check diagnostics, the resolver may reuse a configured project entry's
already-staged native artifact as best-effort provider inventory when the
entry is outside the requested file set. Reuse requires the ordinary staging
cache contract: native text and layout artifacts must exist, and the recorded
source hash must match the current entry. The check never stages or validates
an unrelated entry, so a broken entry cannot turn a healthy-file check into a
resolver setup failure. When the entry itself is requested, ordinary per-file
analysis remains authoritative.

LLVM text validation was separated into `llvm_validation.sfn` so the parallel
capsule emitter does not regain a `main.sfn` edge through the generic emit
helper. A source-graph regression test walks the multi-capsule check closure
and rejects both `compiler/src/main.sfn` and every
`compiler/capsules/codegen-llvm/src/lowering/` module.

## 4. Effect and API ratchets

The filesystem operations disappeared from `llvm/imports.sfn`; only literal
runtime-helper names such as `fs.readFile` remain in LLVM registry data. The
boundary inventory records these signature reductions:

| Module | I/O-effect declarations before | After |
|---|---:|---:|
| `llvm/lowering/entrypoints.sfn` | 13 | 11 |
| `llvm/lowering/lowering_core/file_emission.sfn` | 6 | 4 |
| `llvm/lowering/lowering_helpers.sfn` | 1 | 0 |

The remaining `![io]` declarations cover provider-context installation and
diagnostic sinks, not staged-artifact reads. The boundary test retains the
numeric inventories so future convenience wrappers cannot silently restore
the old authority.

## 5. Compatibility and seed posture

Artifact names and bytes are unchanged. The transitive walk retains the prior
depth limit, export-at-current-depth behavior, `/mod` probe, alias handling,
missing-artifact diagnostics, and direct-import native-text retention. The
resolved `.slugalias` mapping travels in the explicit context so pure symbol
mangling uses the canonical provider slug without reopening the sidecar. The
line-array emit-to-lower path remains direct; import discovery parses its
already-emitted lines without introducing a join/split round trip. Arena-rewind
lowering reloads context only after the rewind, through the driver adapter, so
no arena-backed context crosses the mark.

No pinned-seed capability is required. The change uses existing syntax,
runtime functions, artifact formats, and compiler entry points, and therefore
has no seed gate or seed cut.

## 6. Verification contract

The acceptance gate is:

```text
make compile
build/bin/sfn test compiler/tests/unit/compiler_capsule_boundary_test.sfn
build/bin/sfn test compiler/tests/e2e -k "check"
build/bin/sfn test compiler/tests/integration -k "emit"
```

Touched compiler sources must also pass `sfn fmt --check`; the high-risk
compiler boundary change receives the full self-hosting gate. Cold trivial and
examples `sfn check` RSS is appended to
`docs/perf/decomposition-baseline.md`, with the same-host restriction kept
explicit.
