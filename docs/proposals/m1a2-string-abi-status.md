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

## Update (current state) — RESOLVED via in-memory `i8*` / register `{i8*,i64}` split

The earlier blocker (universal `noop` function bodies / garbage AST reads) was
**root-caused and fixed**. The mistake was flipping struct/enum *string fields*
to the 16-byte `{i8*, i64}` aggregate. That shifted the byte offset of every
field following a `string` field (e.g. `Block { tokens; text: string;
statements }` moved `statements` from offset 16 → 24), and the imported-AST
field-offset contract — encoded by the layout engine and the hand-pinned
canonical table at the baseline 8-byte width — no longer held. The compiler
then misread its own parsed AST: `block.statements.length` read as `0`, so
`emit_native_text_with_module_name` emitted `noop` for *every* function body,
breaking every test that emits + searches asm or navigates the AST
(parser_*, effect_checker_*, numeric_*, …). (The "garbage `.length`" diagnosis
in the prior session was a red herring caused by the
string-builtin-in-`test {}`-body harness quirk; lengths read correctly through
helper `fn`s.)

### The fix: strings are `i8*` in memory, `{i8*, i64}` in registers

- **Struct/enum string *fields* stay `i8*`** (8 bytes). `map_struct_field_annotation`
  (`llvm/type_mapping.sfn`) clamps a scalar-string field back to `i8*`, and
  `emit_native_layout.sfn` is reverted to the baseline (8-byte string-field)
  layout + canonical table. AST struct layout is therefore **byte-identical to
  the seed**, so no seed cut and no canonical-table rewrite is needed.
- **Scalar `string` (locals, params, returns) keeps the `{i8*, i64}` flip** —
  this is what the runtime string family (#1308) needs to take/return strings
  by value with their length. Loading a string field into a scalar recovers the
  length via the existing `i8*` → `{i8*, i64}` `sfn_str_len` coercion bridge;
  storing a scalar string into a field extracts the data pointer.

This also **reduces** test-pin churn: struct-field ABI pins
(`test_struct_field_separator.sh` → `%Pair = type { i8*, double }`) stay valid;
only scalar return/param pins (`abi_value_return_test`) legitimately move to the
aggregate.

### Validation
- `make compile` self-hosts (exit 0).
- The previously-failing unit tests pass (numeric_bitwise, parser_block_let,
  effect_checker, parser_lambda_body, … verified). Remaining unit fails are
  non-regressions: `atomic_add_sub` / `atomic_cas` (pre-existing baseline
  whitespace-predicate failures) and `async_struct_return_boxed` (parallel
  `build/sailfin/program.ll` cache flake — passes run solo).

## Also remaining (smaller)
- A few tests pin the **old** `i8*` *scalar return* ABI and must be updated to
  the aggregate (e.g. `abi_value_return_test` asserts `fn s() -> string` lowers
  to `define i8* @s` rather than `{i8*, i64}`). These are expected M1.A.2
  updates, not bugs. Struct-field pins are unaffected.
- The runtime string-family body rewrites (read `s.len` off the aggregate) are
  the **follow-up** this unblocks (#1315/#1318), not part of this flip.

## Baseline note
The container's baseline `make test` already fails 3 tests (pre-existing,
e.g. `atomic_add_sub_test` whitespace handling); compare against that, not a
fully-green baseline.
