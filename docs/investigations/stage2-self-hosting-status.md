# Stage2 Self-Hosting: Current Status & Findings

## Summary

Recent work expanded the Stage2 toolchain surface area: we taught `tools/compile_with_stage1.py`
how to optionally bootstrap Stage2 artefacts and link them into an executable, enhanced the Stage2
test fixture suite to exercise native-text generation, LLVM IR validation, and MCJIT execution, and
added bootstrap-side safeguards (string constant synthesis and optional verification) to make the
self-hosted pipeline more deterministic. These improvements exposed a set of gaps that are still
blocking a clean self-host round-trip.

## Implemented Enhancements

- `tools/compile_with_stage1.py` now accepts `--stage2`, `--stage2-out`, and `--stage2-binary`
  switches. When invoked, we drive `scripts/bootstrap_stage2.py`, collect all generated `.ll`
  artefacts, and (optionally) invoke `clang` to link a Stage2 compiler binary.
- `compiler/tests/test_stage2_self_hosted_compiler.py` grew three new cases:
  - `test_stage2_emits_native_artifacts` validates that the Stage2 path produces both
    `sailfin-native-text` and layout manifests for a minimal program.
  - `test_stage2_generates_valid_llvm` parses the Stage2 IR through llvmlite to ensure we emit
    structurally valid modules.
  - `test_stage2_executes_compiled_program` JITs the Stage2 and Stage1 IR for a numeric function and
    compares their return values.
- The Stage2 bootstrap script now synthesises missing string constant definitions using the source
  literals (falling back to the first-pass lowering results), and can optionally scan for runtime
  helper references to inject missing `declare` stubs.
- `Stage2Runner` gained additional adapters (string helpers and array concatenation) so the native
  runtime bridge is aware of the new helper descriptors. When we inject “synthetic” string constant
  definitions we also propagate them into the runner so tests can exercise the playground IR
  directly.
- String addition now lowers through the dedicated `sailfin_runtime_string_concat` helper instead of
  emitting `add i8*` instructions. `effect_checker` and other modules that build qualified routine
  names no longer crash llvmlite’s parser, and Stage2Runner registers the helper so MCJIT can realise
  concatenated strings. The regression lives in
  `compiler/tests/test_string_lowering_improvements.py::test_string_addition_lowering`.
- Property-based runtime helper detection now canonicalises `.length` into the `string.length`
  descriptor (alongside the legacy `len(string)` alias) and avoids the substring/equality path that
  Stage2 previously failed to lower. We replaced the `contains_dot_property` implementation with a
  Stage2-friendly scanner that respects escaped quotes and uses `char_at` instead of dynamic indexing,
  eliminating the llvmlite verifier crashes triggered by pointer arithmetic on strings.
- `format_suspension_location` no longer materialises temporary arrays or relies on `join_strings`;
  it now concatenates segments directly, which reduced the bootstrap diagnostic count (Stage2 now
  reports eight warnings, down from the mid-teens prior to this iteration).

## Outstanding Issues

Despite the new scaffolding, the Stage2 bootstrap and runner still fail in several places:

1. **Runtime helper declarations drift**  
   With `.length` canonicalised we now emit declarations for `sailfin_runtime_string_length`
   without bootstrap patches, but helper discovery still relies on textual heuristics. Calls such as
   `value.concat(other)` and trait dispatch fallbacks can slip past the detector, so the bootstrap
   script still carries a safety net that injects missing `declare` statements before invoking
   llvmlite. The detector should be unified with the lowering pipeline so declarations are emitted
   deterministically from the source IR.

2. **Invalid LLVM CFG (PHI hazards)**  
   After string/helper patches, llvmlite’s verifier reports multiple “instruction does not dominate
   all uses” and “PHI node entries do not match predecessors” errors inside
   `effect_checker.ll`. These stem from the existing Stage2 lowering pipeline, not the new harness,
   and prevent us from running verification. To keep tests moving we wrapped the verification call in
   a `try/except`, but the resulting IR is still malformed. When we attempt to execute the module the
   MCJIT finalizer crashes (`Segmentation fault: 11`) once optimisation tries to fold the broken phi
   nodes.

3. **Stage2 bootstrap remains noisy**  
   Even with deduplicated string constants, a Stage2 bootstrap run still emits a large number of
   warnings (“unsupported expression `collected_string_constants`”, “condition produced no value in
   `lower_expression`”, etc.). These diagnostics were already present before this iteration but they
   continue to block a clean self-host pipeline and complicate automated verification.

## Next Steps

1. **Fix helper target canonicalisation**  
   Align the helper descriptor table and target inference so `*.length`/`*.concat` calls resolve to
   the expected runtime symbols without needing textual `declare` injection. Once aligned, we should
   remove the ad-hoc helper declaration patching in `Stage2Runner`.

2. **Repair Stage2 PHI construction**  
   Triage the loops emitted by `effect_checker.sfn` and friends: confirm that each `phi` node has
   entries aligned with its predecessor blocks and that all `load`/`store` instructions dominate their
   uses. This will let us re-enable mandatory verification in `Stage2Runner` instead of silently
   swallowing errors.

3. **Stabilise bootstrap warnings**  
   The long tail of “unsupported expression `collected_string_constants`” and “condition produced no
   value” diagnostics are masking genuine lowering gaps. Addressing them will make it easier to catch
   regressions when the Stage2 pipeline finally self-hosts.

4. **Retest end-to-end once IR validates**  
   After addressing canonicalisation and CFG issues, rerun the new Stage2 tests plus the Stage2
   bootstrap CLI. The target success criteria are: (a) pytest suite passes without segmentation
   faults, (b) the linked Stage2 binary launches, and (c) bootstrap warnings are limited to known,
   tracked gaps.
- **Reduce residual bootstrap noise**  
  The current Stage2 bootstrap finishes with eight non-fatal diagnostics: two `collected_string_constants`
  fallbacks and four condition failures split between `lower_expression` and the reformulated
  `format_suspension_location`. Tightening those code paths (and teaching the lowering pipeline how to
  serialise their data structures) will bring us closer to a clean Stage2 run and make the MCJIT
  verifier failures easier to reason about.

The current branch captures the tooling needed to iterate quickly on Stage2, but the pipeline still
fails due to existing lowering bugs. The items above should be prioritised before flipping the Stage2
switch as the default compiler path.
