# Runtime Helper Conventions

This is the canonical reference for adding new entries to the runtime
helper registry in `compiler/src/llvm/runtime_helpers.sfn` and routing
their call sites through the LLVM lowering. It supersedes the
per-target alias `declare` path that was retired in M1.7.5b (#502).

---

## Descriptor-only contract

New runtime helpers populate `native_signature` only. ABI shims (C
trampolines) remain only for legitimate parameter-shape bridging —
never as the migration vehicle.

In practice this means:

- **`native_signature` is the canonical name.** Set it to a
  `sfn_<domain>_<op>` symbol (e.g. `sfn_str_concat`,
  `sfn_array_push_slot`). The LLVM lowering emits the `call` against
  that symbol; the linker resolves it to the helper's body, whether
  that body lives in `runtime/sfn/...` (Sailfin-native) or
  `runtime/native/src/...` (C, as a temporary bridge).
- **`symbol` records the legacy C entrypoint** (typically
  `sailfin_runtime_*`) for archeology. Once `native_signature` is
  populated the alias declare for `symbol` is no longer emitted —
  call sites flow through `native_signature` exclusively.
- **`target`** is the lookup key used by `emit_runtime_call`. It
  matches what the lowering writes as `runtime.<op>` in the
  `.sfn-asm` IR; the dispatch maps it back to a descriptor at
  emit time.

## C trampolines are not the migration vehicle

A C trampoline (`runtime/native/src/sailfin_runtime.c`) is justified
only when the calling convention or parameter shape genuinely cannot
be expressed in the source language we are migrating to. Examples
that qualify:

- A helper that needs to bridge a Sailfin `String` slot to a C
  `const char *` while the Sailfin-side allocator is still in the
  legacy ABI.
- An intrinsic that calls into a libc surface (`memcpy`, `setjmp`)
  with a fixed register class that the Sailfin source cannot yet
  produce directly.

A trampoline is **not** justified merely because the Sailfin body
"is not written yet." That is the migration itself — write the
Sailfin body, register it under `native_signature`, and route the
call sites through `emit_runtime_call`. Adding a C trampoline as a
permanent stand-in re-introduces exactly the legacy surface
M1.7.5a / M1.7.5b worked to retire.

## Call-site dispatch

Every helper call site goes through `emit_runtime_call`
(`compiler/src/llvm/expression_lowering/native/runtime_call.sfn`).
The dispatch:

1. Looks up the descriptor by `target`.
2. Selects `native_signature` (preferred) or `symbol` (legacy).
3. Emits the `call <type> @<symbol>(...)` line plus any pre/post
   coercions described by the descriptor's `c_abi_return_type` or
   `parameter_types` rows.

The two collection passes (`collect_runtime_helper_targets` in
`compiler/src/llvm/effects.sfn` and the post-lowering
`collect_runtime_helper_targets_from_lines` in
`compiler/src/llvm/lowering/lowering_helpers.sfn`) observe the
emitted IR and add the discovered targets to `used_targets`. The
preamble's `render_runtime_helper_declarations` then emits a single
`declare` per used target's effective symbol — no aliases, no
per-target fallbacks.

## Returning the `{i8*, i64}` aggregate from a Sailfin body (`SfnString`)

A handful of helpers carry the `{i8*, i64}` SfnString aggregate return ABI
(`env.get` / `env.home`). The string accessor family (`sfn_str_byte_at`,
`sfn_str_find_byte`, `sfn_str_codepoint`, `sfn_str_grapheme_at`,
`sfn_str_grapheme_count`) followed the bare-name pattern established by #1314
(C3 of epic #1308): real Sailfin bodies now define the bare `sfn_str_*`
symbols in `runtime/sfn/string.sfn`; the `sfn_str_sfn_*` `_sfn_` infix
wrappers for these five are retired (#1315, C4 of epic #1308). These accessors
return `f64` (not `SfnString`) and so do not use the aggregate-return ABI,
but they follow the same link-ownership-flip mechanic. The compiler returns every *user* struct by pointer (`%T*`,
the "boxed-struct ABI" in `type_mapping.sfn` — deliberate, to dodge an
AArch64 aggregate-return legalizer miscompile), so a runtime body that must
satisfy a by-value `{i8*, i64}` call site cannot just `return` a normal
struct.

The mechanism (the M1.A.2 capability; its first consumer is the #1312 env
flip): a reserved return/parameter type **spelling `SfnString`** that
`map_return_type` / `map_type_annotation` intercept and map to the literal
`{i8*, i64}`, routing the *definition* onto the by-value aggregate ABI without
changing any other struct. It is narrow and opt-in by design:

- **Return:** spell the return type `SfnString` (→ `define {i8*, i64} @f`).
  The body returns a bare `* u8`; the return-path coercion
  (`coerce_pointer_or_struct`) wraps it into `{i8*, i64}`, recovering the
  length via `sfn_str_len`. A `string`-typed return still maps to `i8*` —
  `SfnString` is the only spelling that opts in.
- **Parameter:** a by-value `{i8*, i64}` argument classifies as two INTEGER
  eightbytes, identical to a `(data: * u8, len: i64)` scalar pair (the print
  family's trick). Take the two scalars, not an `SfnString` param — the body
  has no struct fields to read.
- `SfnString` is a **runtime-internal ABI spelling, not a user-facing
  type** — keep it out of the language spec; it appears only in
  `runtime/sfn/*.sfn` bodies whose descriptor carries `{i8*, i64}`.
- Safe only for ≤16B, all-INTEGER-class aggregates (`{i8*, i64}` is exactly
  that). Do **not** generalize to other shapes via a layout heuristic — that
  re-exposes the boxed-ABI's AArch64 hazard. A second by-value shape, if ever
  needed, is a deliberate new decision.

## When the registry is the wrong tool

The runtime helper registry is for descriptors that:

- Are referenced by lowering at known call sites
  (`emit_runtime_call` or the `expression_lowering/native/*`
  modules), and
- Need a `declare` line in every module that calls them.

It is **not** the right place for:

- Preamble-inlined declares (spawn/await family, arena primitives,
  the rc-release helper). Those are emitted unconditionally by
  `render_llvm_preamble` (`lowering_phase_render.sfn:110-112` and
  `:173-185`); the preamble-inline filter in
  `render_runtime_helper_declarations` skips them to avoid the
  `llvm-as: invalid redefinition` failure #740 caught. New
  preamble-inlined helpers extend that filter list rather than
  adding a descriptor.
- Helpers reached only through prelude module-level let bindings
  (`runtime_array_map_fn = runtime.array_map`, etc.). These are
  invisible to both walkers and remain in
  `seed_default_runtime_helpers` (`lowering_helpers.sfn`) with an
  in-line WHY comment explaining why dynamic discovery cannot see
  them.
- `extern fn` declares emitted by the user-facing extern path. The
  type-checker registration handles those; the runtime helper
  registry is not involved.

---

## References

- `compiler/src/llvm/runtime_helpers.sfn` — descriptor registry.
- `compiler/src/llvm/rendering.sfn:render_runtime_helper_declarations` — preamble emission.
- `compiler/src/llvm/lowering/lowering_helpers.sfn:collect_runtime_helper_targets_from_lines` — post-lowering scan that observes every emitted call site.
- `compiler/src/llvm/lowering/lowering_helpers.sfn:seed_default_runtime_helpers` — last-resort top-up list for genuinely undiscoverable helpers (each entry carries a WHY comment).
- Issues: #501 (M1.7.5a — dynamic discovery), #502 (M1.7.5b — alias path retired), #461 / Epic #450 — `native_signature` rollout history.
