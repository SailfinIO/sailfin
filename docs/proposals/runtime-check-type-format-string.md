# Sailfin Runtime: Check Type & String Interpolation Plan

Updated: October 13, 2025  
Owner: Runtime & FFI Foundations Workstream

## 1. Summary

`runtime.check_type` and `runtime.format_string` are the two remaining
bootstrap helpers that every Stage1 program still imports from
`runtime/runtime_support.py`. They gate the removal of the Python runtime
because the `is` operator lowers to `check_type`, and string interpolation
relies on `format_string` to evaluate `{{ expression }}` placeholders. This
plan outlines a Sailfin-native replacement strategy that keeps current
behaviour intact while preparing the Stage2 backends for LLVM/WASM targets.

## 2. Problem Statement

- Stage1 lowers `expr is "type"` checks into runtime calls that defer to
  Python reflection (`isinstance`, dynamic imports, callable checks). The
  bootstrap implementation accepts union (`|`), intersection (`&`), array (`[]`)
  descriptors, and `fn()` predicates. Sailfin sources cannot ship without the
  Python fallback because there is no Sailfin-native reflection API.
- Interpolated strings emit `runtime.format_string(template, locals(), globals())`.
  The helper uses Python `eval(...)`, so any program that prints
  `"Hello {{ name }}"` requires the Python runtime and leaks host scope rules
  into the generated code.
- Stage2 backends must not depend on Python. We need a replacement that keeps
  the language surface stable, surfaces good diagnostics, and plays well with
  capability enforcement.

## 3. Goals

1. Remove the Python-only dependency for `check_type` while preserving current
   descriptor semantics (primitive aliases, unions, intersections, arrays,
   functions, runtime types).
2. Replace `format_string` with Sailfin-generated evaluation code so
   interpolation runs without `eval`.
3. Provide regression coverage that runs entirely through the stage1 pipeline
   (`compiler/tests/`) without importing `runtime_support.py`.
4. Maintain parity for existing Sailfin sources so there is no behaviour
   regression during the transition.

## 4. Non-Goals

- Implement full-fledged reflection or runtime type metadata for the entire
  language. We only target the descriptor features already accepted by the
  bootstrap helper.
- Optimize interpolation output; simple concatenation is acceptable as long as
  observable behaviour matches the bootstrap runtime.
- Solve UTF-8 grapheme semantics; that remains a follow-up item on the runtime
  roadmap.

## 5. Proposed Approach

### 5.1 `check_type`

1. **Descriptor Parsing at Compile Time** – Extend the stage1 parser to emit a
   structured representation for type descriptors when the `is` operator is
   encountered. Instead of lowering directly to a string literal, capture an
   AST that distinguishes primitives, arrays, unions, intersections, and named
   types.
2. **Descriptor Serialization** – Teach the emitter to serialize the descriptor
   AST into a data literal (e.g., nested structs) that the runtime prelude can
   consume. Example shape:
   ```sfn
   struct TypeDescriptor {
   kind -> string; // "primitive", "array", "union", "intersection", "named", "function"
   name -> string?;
   items -> TypeDescriptor[];
   }
   ```
3. **Runtime Type Graph** – Introduce metadata tables for structs, enums, and
   functions as part of module initialization (e.g., `__typeinfo__`). This gives
   `check_type` enough information to resolve `Color` or `Array<number>` without
   resorting to Python reflection.
4. **Sailfin Implementation** – Implement `check_type(descriptor, value)` in
   `runtime/prelude.sfn` using the serialized descriptors and metadata tables.
   The helper should:
   - Map primitive aliases (`number`, `string`, `boolean`, `void`).
   - Evaluate unions/intersections via short-circuit recursion.
   - Handle arrays by recursively checking elements.
   - Treat `fn(...)` as `callable` by inspecting the runtime metadata (function
     registry) or using a generated predicate flag.
   - Resolve named types via the module metadata map built during emission.
5. **Bridge Layer Removal** – Once tests pass, drop the bootstrap fallback by
   rewriting `Legacy/stage0` lowering to call the new Sailfin helper or guard it
   behind a feature flag until Stage0 retires.

### 5.2 `format_string`

1. **Parser Emission** – When parsing interpolated strings, build a list of
   literal and expression segments instead of emitting a raw template string.
   Example: `"Hello {{ name }}"` becomes `[(literal "Hello "), (expr name)]`.
2. **Lowering Strategy** – During emission, lower an interpolated string into a
   helper call that accepts an array of closures returning `string`. Each
   expression segment becomes a zero-argument lambda capturing the correct
   scope, e.g. `fn () { return to_string(name); }`. This avoids `eval` and keeps
   evaluation in Sailfin.
3. **Runtime Helper** – Implement `format_segments(segments)` in the prelude.
   It iterates over segments, concatenating literal strings and invoking
   expression lambdas. Existing call sites can become thin wrappers:
   `format_string(segments)` for compatibility while we migrate codegen.
4. **Error Semantics** – Match bootstrap behaviour by preserving placeholders if
   a segment throws. Emit a descriptive error (e.g., prefix with `{{`/`}}`) so
   debugging remains simple.
5. **Migration Path** – Stage the compiler changes behind a gate (`emit_format_segments`
   flag) so we can land runtime support first, then flip the lowering. Update
   both Stage0 and Stage1 emitters to use the new representation once tests pass.

## 6. Implementation Checklist

- [ ] Add descriptor AST / serialization support to stage1 (`parser.sfn`,
  `emit_native.sfn`, `emit_python.sfn`).
- [ ] Generate per-module runtime type metadata tables.
- [ ] Implement Sailfin-native `check_type` leveraging metadata + descriptors.
- [ ] Provide regression coverage for primitives, arrays, unions, intersections,
  named structs/enums, and callable descriptors (`compiler/tests/test_runtime_prelude.py`).
- [ ] Update Stage0 lowering to reuse the new runtime path or guard behind a
  compatibility flag.
- [ ] Introduce string interpolation segment representation in the parser.
- [ ] Implement runtime concatenation helper (`format_segments`).
- [ ] Update emitters to produce segment arrays instead of delegating to Python
  `eval`.
- [ ] Add regression coverage for interpolation errors, nested expressions, and
  escaping.
- [ ] Remove the Python-only helpers from `runtime/runtime_support.py` once the
  suite passes.

## 7. Testing Strategy

- Extend `compiler/tests/test_runtime_prelude.py` with new cases for
  `check_type` and interpolation segments.
- Add integration coverage in `compiler/tests/test_stage1_pipeline.py` to ensure
  interpolated strings compile and execute without the Python runtime.
- Create golden Sailfin examples under `examples/` demonstrating the new
  lowering (e.g., `examples/basics/interpolation.sfn`).
- Validate Stage0 backwards compatibility until the bootstrap compiler can be
  fully retired.

## 8. Open Questions

1. **Callable Detection** – Do we need callable metadata per function, or can we
   rely on the existing emission shape (functions emitted as Python callables)?
   Investigate whether stage1-generated Python already exposes a marker we can
   reuse before adding new metadata.
2. **Type Aliases** – How do declared `type Alias = ...` definitions flow into
   the runtime metadata? We may need to emit alias records so `value is Alias`
   resolves correctly.
3. **Error Handling** – Should interpolation failures propagate exceptions or
   keep the bootstrap behaviour (rendering the placeholder)? Decide before
   implementation so diagnostics stay consistent.
4. **Performance** – Segment-based interpolation introduces extra lambdas.
   Profile once implemented to ensure there is no significant regression for
   hot loops (e.g., log formatting).

## 9. References

- `docs/runtime_audit.md` for the up-to-date helper status matrix.
- `docs/spec.md` §9 for current interpolation semantics.
- `Legacy/stage0/code_generator.py` for the bootstrap lowering that still calls
  `runtime.format_string` and `runtime.check_type`.
