# Stage2 string constant collision investigation

## Summary

Stage2 LLVM builds reference a global string constant named `@.str.27`, but no Stage2 module actually defines it. Several generated IR files emit `getelementptr` instructions against `@.str.27`, leading LLVM to dereference an undefined symbol during the Stage2 bootstrap of Sailfin.

## Evidence collected

- Multiple Stage2 IR artefacts reference `@.str.27`:
  - `build/stage2/native_llvm_lowering.ll` (e.g. lines 64039, 70022)
  - `build/stage2/parser.ll` (lines 17599, 17679, 17764, 21539)
  - Additional references occur in `build/stage2/decorator_semantics.ll`, `build/stage2/effect_checker.ll`, and `build/stage2/emit_native.ll`.
- No Stage2 module defines a global named `@.str.27`; a project-wide search for `^@\.str\.27` across `build/stage2/*.ll` returns no results.
- The Stage1 lowering code that emits string constants, `compiler/build/native_llvm_lowering.py`, names each constant with the current temporary register index:

  ```python
  # compiler/build/native_llvm_lowering.py @ ~9,980
  def lower_string_literal(literal, temp_index, lines):
      content = unescape_string_literal(literal)
      global_name = "@.str." + number_to_string(temp_index)
      constant = StringConstant(
          name=global_name, content=content, byte_count=len(content))
      ...
  ```

  Because `temp_index` resets for each lowered function, different functions can (and do) reuse names such as `@.str.27` for unrelated literals.

- String constants are merged globally using only the constant **name** as the deduplication key:

  ```python
  # compiler/build/native_llvm_lowering.py @ ~10,170
  def merge_string_constants(existing, new_constants):
      ...
      found_by_name = find_string_constant_by_name(result, candidate.name)
      if found_by_name == None:
          result = append_string_constant(result, candidate)
      ...
  ```

  When two distinct literals share the same name (because their `temp_index` collided), only the first survives, and the other is silently dropped. If the surviving entry belongs to another module the collisions cause missing global definitions like the observed `@.str.27` gap.

- `compiler/build/native_llvm_lowering.py` already ships with an unused helper `find_string_constant(constants, content)`, hinting that the original intent was to deduplicate by **content**, not name.

## Root cause

The global naming strategy in `lower_string_literal` is unstable: it depends on the per-function temporary index rather than the string content. As a result:

1. Distinct literals in different functions can receive the same global name (e.g. `@.str.27`).
2. `merge_string_constants` deduplicates by name only, so later occurrences of the same name—possibly representing different content—are discarded.
3. Once the earlier definition is also merged out (for example by module ordering), downstream modules still reference the symbol, but no definition is emitted anywhere in Stage2.

## Required work

1. **Adopt content-stable names for string literals**

   - Update `lower_string_literal` (`compiler/src/native_llvm_lowering.sfn` and the generated `compiler/build/native_llvm_lowering.py`) so that `global_name` derives from the literal’s content (e.g. a deterministic hash or a sanitised prefix with a hash suffix).
   - Ensure the name format is valid for LLVM globals and remains collision-resistant.

2. **Reuse existing constants by content**

   - Before appending a new `StringConstant`, look up existing entries by content using `find_string_constant` (currently unused).
   - If an identical literal already exists, reuse its global name instead of creating a duplicate definition.

3. **Deduplicate by content, not just name**

   - Adjust `merge_string_constants` so it treats two constants with the same content as identical, even if their names differ. This protects against legacy artefacts and ensures that identical literals share storage.

4. **Regenerate Stage1 Python after changes**

   - Modify the Sailfin source file `compiler/src/native_llvm_lowering.sfn`, then run `make compile` (or the appropriate regeneration pipeline) to regenerate `compiler/build/native_llvm_lowering.py` so Stage1 and Stage2 stay in sync.

5. **Validate the fix**
   - Rebuild Stage2 (`make compile` followed by the Stage2 bootstrap procedure).
   - Confirm that all references to `@.str.*` in `build/stage2/*.ll` have corresponding definitions (e.g. via `rg '^@\.str\.' build/stage2/*.ll`).
   - Execute the Stage2 bootstrap / self-host run that originally surfaced the error to ensure the missing symbol no longer appears.

## Additional notes

- After the naming change, expect a large diff in the generated Stage2 IR because many `@.str.N` references will be renamed. Plan to review those diffs carefully and update any downstream tooling that may assume the old numbering scheme.
- Consider encapsulating the name-generation logic in a helper so that future emitters (enum metadata, dynamic member access, etc.) can reuse the same canonical scheme.
- If the chosen naming strategy relies on hashing, prefer a stable, collision-resistant digest (e.g. SHA-1) truncated to a manageable length, and document the choice in code comments to aid future maintenance.
