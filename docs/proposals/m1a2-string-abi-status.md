# M1.A.2 — `string` → `{i8*, i64}` ABI flip (status)

Tracking issue: #1363. This branch flips the language-level `string` type from a
bare `i8*` to the by-value `{i8*, i64}` (data, len) SfnString aggregate in
**scalar register positions** (locals, params, returns), so the runtime string
family (epic #1308) can take/return strings by value with their length.

## The model: aggregate in registers, `i8*` in memory

The flip is **scoped to scalar register positions**. Strings remain a bare
`i8*` data pointer in every *memory container* shape; they only widen to the
`{i8*, i64}` aggregate when materialised as a scalar local/param/return. The
`i8* → {i8*, i64}` bridge (`coerce_pointer_or_struct`, length recovered via
`sfn_str_len`) and the reverse `extractvalue ..., 0` are emitted at each
boundary crossing:

| Position | Shape | Why |
|---|---|---|
| local / param / return | `{i8*, i64}` | by-value length is the point of the flip |
| struct / enum field | `i8*` | a 16-byte field would shift every following field's offset and break the imported-AST layout contract |
| array element (`string[]`) | `i8*` | container element ABI is pointer-sized |
| optional (`string?`) | `i8*` | nullable pointer |
| module global, catch binding | `i8*` | storage slots |
| closure-env capture field | `i8*` | env is a heap container struct |
| runtime-ABI trampoline (`fn(* u8)`) | `* u8` | the C runtime calls it with a single-pointer convention |

Keeping fields/elements pointer-sized means the AST struct/enum layouts are
**byte-identical to the seed**, so the flip self-hosts in one pass with no seed
cut (the architect's "mandatory seed cut" verdict was disproved empirically).

## Done and verified

1. **Self-hosts.** `make compile` builds the compiler with the new ABI.
2. **Scalar `string` → `{i8*, i64}`** in `type_mapping.sfn` (`map_type_annotation`
   / `map_return_type`) and the two parallel expression/statement type-mapping
   modules (`core_type_mapping.sfn`, `statement_type_mapping.sfn`).
3. **Container clamps** keep fields/elements/optionals/globals/captures at `i8*`
   (`map_struct_field_annotation`, the array/optional branches,
   `closure_field_llvm_type`).
4. **Boundary coercions** at every crossing:
   - struct-field store / read (existing field coercion + `i8*` clamp),
   - array push (`extractvalue` in `lower_array_push_in_place`),
   - closure-env capture **store** (`extractvalue` in `emit_closure_env_alloc`,
     type threaded through `ClosureCaptureOperand`),
   - string concat returns the full aggregate (`emit_string_concat`),
   - interpolation / stringify pass-through for `{i8*, i64}`
     (`coerce_operand_to_string`),
   - cast arm `{i8*, i64}` ↔ pointer (`core_literals_lowering.sfn`),
   - drop / RC release extracts field 0 (`_emit_rc_release_triplet`), and
     `is_heap_type` now treats `{i8*, i64}` as heap.
5. **Runtime-helper descriptor** `char_code` flipped to a `{i8*, i64}` param
   (its symbol IS the pure-Sailfin prelude `char_code`; C-symbol descriptors
   stay `i8*`).
6. **`sfn/http` serve trampoline** kept on the `* u8` runtime ABI
   (`_sfn_http_trampoline`) — a `string` param there mismatched the runtime's
   single-pointer call and truncated POST bodies.

## Regressions fixed (all were boundary-coercion gaps the flip exposed)

The flip is invasive precisely because *every* `i8*`↔aggregate boundary needs a
coercion. Each of these was a real miscompile (garbage length, dropped
statement, or invalid IR), root-caused and fixed:

- imported-AST field-offset corruption (struct string fields had been flipped to
  16 bytes → `noop` function bodies) — reverted field flip + layout manifest.
- `char_code(literal)` returned -1 (descriptor ABI mismatch) → broke `trim_text`,
  `is_atomic_builtin`, escape-promotion predicates.
- string interpolation silently dropped (`coerce_operand_to_string` had no
  aggregate arm).
- channel string payload truncated (interpolation path).
- try-body string `let` lost its drop sentinel (`is_heap_type`) and would have
  emitted `bitcast {i8*, i64} to i8*` (release path).
- closure string capture: env field clamp + capture-store `extractvalue`.
- HTTP POST body truncated (trampoline ABI).
- build-and-run programs with string-capturing lambdas (`sailfin_main_entry` /
  `_panic`).

## Test pins updated (expected M1.A.2 ABI changes, not bugs)

- `abi_value_return_test`: `-> string` now lowers to `define {i8*, i64} @s`.
- `test_drop_emission_try_catch.sh`: `try_with_rc` returns `{i8*, i64}`.
- `escape_promotion_test`: `{i8*, i64}` is now a heap type (droppable).

`test_struct_field_separator.sh`'s `%Pair = type { i8*, double }` stays valid —
struct string fields remain `i8*`.

## Known pre-existing failures (NOT M1.A.2)

`test_http_capsule_serve.sh` (the loopback POST round-trip) and `test_lock.sh`
fail **identically on the clean `origin/main` baseline** inside this sandbox
container (loopback/networking + workspace-detection artifacts); they pass on
GitHub CI for `main`. They are container-environment issues, not introduced by
this branch.

## Follow-ups this unblocks

The runtime string-family body rewrites that read `s.len` off the aggregate
(#1315 / #1318) and the C-runtime retirement (#1308) are the follow-ups this
flip enables — not part of it.
