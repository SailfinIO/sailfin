# M1.A.2 — `string` → `{i8*, i64}` ABI flip (WIP status)

Tracking issue: #1363. This branch implements the M1.A.2 flip of the
language-level `string` type from a bare `i8*` to the by-value
`{i8*, i64}` (data, len) SfnString aggregate, so the runtime string
family (epic #1308) can take/return strings by value with their length.

## Done and verified

1. **Scalar `string` → `{i8*, i64}` self-hosts.** A cold
   `make clean-build && make check` produced **0 invalid-IR / parallel-emit
   errors** — the compiler compiles itself with the new ABI. This disproves
   the architect's "mandatory seed cut" verdict: the flip lands in **one PR**
   (pass-1 internals are uniformly `i8*` (seed-built); pass-2 gets matching
   extern/def shapes via the `exec.sfn` `* u8` signatures).

2. **Three parallel type-mapping modules flipped consistently.** The bug that
   broke string parameter `.length` (call side passed only the data pointer)
   was that only `type_mapping.sfn` was flipped; `core_type_mapping.sfn` and
   `statement_type_mapping.sfn` still mapped `string` → `i8*`. All three now
   agree: scalar `string` → `{i8*, i64}`.

3. **Container scoping.** `string[]` elements, optional `string?`, module
   globals, and catch-bindings stay `i8*` (string-in-a-container keeps the
   legacy pointer shape; only scalar locals/params/returns flip). The
   `{i8*,i64}` ↔ pointer cast arm (`core_literals_lowering.sfn`) and the
   removed let-binding `i8*` clamp (`instructions_let.sfn`) support this.

4. **Struct string fields → `{i8*, i64}` (16 bytes)** with the field-layout
   size updated in `emit_native_layout.sfn::analyze_type_layout`.

## Update (current state)

- **Self-host corruption FIXED.** The layout cycle-guard bug (`append_string`
  mutating the `visiting` chain in place, undercounting repeated by-value
  fields) is fixed via `visiting_branch` (commit `ac50304`). `sfn build -p
  compiler --work-dir` now succeeds; `make compile` self-hosts.
- **Canonical sizes corrected** (`Statement` 128→184) and now match the fixed
  engine's computed manifests.
- **Concat returns the `{i8*,i64}` aggregate** (commit `ea5588d`).

### Remaining blocker — cross-module string-construction miscompile

`make check` still fails ~127 first-pass tests (confirmed **real regressions**
vs the pre-flip baseline — the same tests pass on `86c7366~1`). Root cause
narrowed to a **garbage `.length`** on strings built by the compiler's own
string-heavy code under string=16:

- `emit_native_text_with_module_name(...)` returns a string with a valid,
  NUL-terminated data pointer but an **undef/garbage length field**, so
  `index_of`/length-dependent ops on the emitted asm fail → the bulk of the
  127 (any test that emits + searches asm).
- Narrowed to `join_with_separator` / the `string[]`-iterate-then-concat
  pattern. **The identical code works inline in `main`** (`len=5`) **but
  yields garbage when imported from `emit_native_state.sfn`** — i.e. an
  *elusive cross-module* miscompile, not a single construction site. The
  per-field coercion (`i8*`→`{i8*,i64}` via `sfn_str_len`), the let-binding
  coercion, and the index lowering all look correct in isolation.

This needs a focused cross-module IR diff (the same function compiled in two
modules) to find why the length field is dropped in the imported build. It is
the gating item before the ~20 stale-`i8*`-ABI test-pin updates.

## Remaining blocker — canonical layout-table fixed-point (RESOLVED — see Update above)

`emit_native_layout.sfn::canonical_type_layouts()` hand-pins by-value sizes
for ~28 well-known compiler/runtime types (to break recursive/incomplete
layout inference). These encoded the old `string=8` ABI. With 16-byte string
fields, types with by-value `string` fields grow.

- **Leaf/struct sizes are regenerated and fixed-point-verified** (e.g.
  `TypeAnnotation` 8→16, `Expression` 48→64, `MatchCase` 64-field set = 104,
  `DecoratorArgument` 56→72).
- **The cyclic enum cluster does not converge by hand.** `Statement` (an enum)
  embeds `ForClause`/`MatchCase` by value, and the canonical table is consulted
  *before* the `visiting` cycle-guard for nested types, so each hand-iteration
  inflates the next (`Statement` 96→128→184 …). The old `string=8` values were
  a hand-found fixed point of this cyclic system.

**Disabling the table is not an option** — it raises regressions (157 vs ~125
with the table), so it is load-bearing.

### Recommended fix
Make the canonical table **self-computing to a fixed point** rather than
hand-pinned: iterate `calculate_record_layout` over the AST/runtime types until
sizes stabilize (or compute the cyclic enum payloads directly from the LLVM
type sizes, which LLVM resolves independently for the non-enum members). This
removes the hand-maintenance burden and is robust to future field changes.

## Also remaining (smaller)
- ~20 tests pin the **old** `i8*` ABI and must be updated to the aggregate
  (e.g. `abi_value_return_test` asserts `fn s() -> string` lowers to
  `define i8* @s` and *not* `{i8*, i64}`; `test_struct_field_separator.sh`
  pins `%Pair = type { i8*, double }`). These are expected M1.A.2 updates, not
  bugs.
- The runtime string-family body rewrites (read `s.len` off the aggregate) are
  the **follow-up** this unblocks (#1315/#1318), not part of this flip.

## Baseline note
The container's baseline `make test` already fails 3 tests (pre-existing,
e.g. `atomic_add_sub_test` whitespace handling); compare against that, not a
fully-green baseline.
