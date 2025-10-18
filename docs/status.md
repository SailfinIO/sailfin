# Sailfin Status

Updated: October 18, 2025

This document is the source of truth for what ships today in the Python
bootstrap toolchain and what exists only in the Sailfin-native
experiments. Use it as the checklist before updating specs, examples, or
roadmaps.

## Stage Overview

- **Stage1 (production)** — Sailfin-written lexer, parser, semantic passes, and
  native lowering pipeline that compile the Sailfin compiler itself. The stage1
  artifact ships as a versioned release bundle (`sailfin-stage1-<version>.zip`)
  containing `compiler/build/`, the runtime prelude, and the `sailfin-stage1`
  launcher. All developer workflows (`make compile`, `make package`, CI) now go
  through this self-hosted pipeline. The emitted artifacts still target the
  Python runtime (`runtime_support.py`) and rely on the Python-flavoured
  installer scripts; removing those dependencies is tracked in the roadmap
  under the Stage2 backend and toolchain de-Pythonisation workstreams.
- **Stage0 (legacy)** — The Python bootstrap compiler (archived under
  `Legacy/stage0/`) is retained for reference and targeted regression
  hunting, but it no longer participates in packaging or CI. Expect the
  directory to freeze except for emergency diffs.
- **Stage2 (bootstrap complete)** — As of October 2025, the Stage2 bootstrap
  milestone is complete: `make bootstrap-stage2` successfully compiles all
  compiler sources (`compiler/src/*.sfn` and `runtime/prelude.sfn`) to LLVM IR
  modules in `build/stage2/`. The bootstrap script (`scripts/bootstrap_stage2.py`)
  generates 16 LLVM `.ll` files validated by `compiler/tests/test_stage2_bootstrap.py`.
  Stage2 continues to mature with expanded LLVM lowering coverage, cross-module
  linking, and native binary generation tracked in the roadmap. The `.sfn-asm`
  intermediate plus `native_llvm_lowering` provide the compilation infrastructure,
  covering local assignments, structured control flow, structs, enums, interfaces,
  borrows, and more (see detailed Stage2 feature list below). now covering local assignments, structured
  `if`/`else` branching, `loop`/`break`/`continue`, range-based `.for` iteration with
  dynamic stride support, element-wise `.for` loops over primitive arrays (`number[]`,
  `int[]`, `boolean[]`), and `match` dispatch alongside
  boolean and integer primitives for parameters, locals, and returns in the LLVM
  prototype. Struct and enum declarations now emit `.layout` descriptors that
  record size, alignment, and per-field offsets for LLVM consumption. Member
  layout inference now recognises optional fields, nested enums, and recursive
  aggregates, so the compiler AST records concrete sizes without emitting the
  `defaulting to pointer layout` fallbacks (`compiler/tests/test_stage1_pipeline.py::test_native_backend_infers_recursive_layouts`).
  Member
  access expressions in the LLVM prototype now consult those layouts, so `self.field`
  lowers into `getelementptr`/`load` sequences instead of surfacing unsupported
  expression diagnostics. Struct literals now assemble aggregates directly in LLVM
  (`insertvalue` sequences) so Stage2 functions can construct, return, and consume
  user-defined structs without Python fallbacks; the behaviour is exercised by
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_struct_literals`.
  Builtin compiler and runtime aggregates (e.g. `Token`, parser result wrappers, `runtime.StructField`)
  now publish canonical pointer-based ABI descriptors so Stage1 emits consistent layouts without
  surfacing `defaulting to pointer layout` warnings when compiling dependent modules. Regression
  coverage: `compiler/tests/test_stage1_pipeline.py::test_stage1_builtin_ast_layouts_do_not_warn`
  and `compiler/tests/test_runtime_prelude.py::test_runtime_prelude_collection_helpers`.
  Layout manifests now ship alongside each compiled module artifact as
  `module.layout-manifest` files containing all struct and enum layout descriptors in the
  same textual format as the `.sfn-asm` `.layout` directives (e.g., `.layout struct name=Person
size=16 align=8` followed by `.layout field` entries). The manifest emission function
  (`generate_layout_manifest` in `compiler/src/emit_native.sfn`) walks the program's struct
  and enum declarations, invoking the same `compute_struct_layout_lines` and
  `compute_enum_layout_lines` helpers used for inline `.sfn-asm` layout metadata, then packages
  the result as a second artifact in the `NativeModule.artifacts` array. The native IR parser
  (`compiler/src/native_ir.sfn`) provides a `parse_layout_manifest` function that reconstructs
  minimal `NativeStruct` and `NativeEnum` definitions (with empty field/variant lists but populated
  `layout` metadata) from the manifest text, enabling cross-module layout resolution. The LLVM
  lowering pipeline (`compiler/src/native_llvm_lowering.sfn`) can consume these manifests via
  the existing `build_type_context` function, which accepts struct and enum arrays with layout
  metadata regardless of whether they originated from the current module or were loaded from an
  imported manifest. This infrastructure enables Stage2 to resolve referenced structs/enums defined
  in dependencies without pointer fallbacks, though full cross-module dependency resolution (loading
  manifests for imported modules and merging them into the type context) remains roadmap work.
  Regression coverage: `compiler/tests/test_stage1_pipeline.py::test_native_backend_emits_layout_manifest`
  validates manifest generation and content, while
  `compiler/tests/test_stage1_pipeline.py::test_native_backend_parses_layout_manifest` verifies
  that the parser can reconstruct struct and enum layout metadata from the manifest format.
  Cross-module layout regression coverage now locks the manifest infrastructure end-to-end
  via `compiler/tests/test_stage1_pipeline.py::test_native_backend_cross_module_layout_resolution`
  (stage1 pipeline) and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_cross_module_layout_resolution`
  (stage2 LLVM execution). These tests exercise a minimal multi-module fixture where a types
  module defines shared structs (Point, Rectangle) and enums (Color, Shape) with payload
  variants, exports constructor functions, and emits a layout manifest, while a consumer module
  imports and uses those types in local bindings, function calls, and match expressions. The
  stage1 test verifies manifest emission and parsing for the types module and confirms the
  consumer compiles without fatal errors. The stage2 test validates that both modules lower to
  LLVM IR with proper type definitions, confirming the layout infrastructure works end-to-end.
  Note that automatic manifest loading for imported modules (enabling the consumer to use
  imported types without pointer fallbacks) remains roadmap work; the current tests validate
  the manifest generation, parsing, and type context building infrastructure that will enable
  full cross-module resolution once dependency tracking is implemented.
  Array literals embed `#element:<type>` metadata so Stage2 can skip per-element
  inference and prepare typed iteration over richer aggregates. LLVM lowering
  now interprets that metadata for struct element types, so `.for` loops can
  walk `Pair[]` (and other user-defined aggregates) without defaulting to
  pointer fallbacks; regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_struct_arrays`.
  Enum array literals now emit `#element:EnumName` metadata (using the enum type
  name, not the variant name), enabling typed iteration over enum arrays. For
  example, `[Color.Red, Color.Green, Color.Blue]` emits `[#element:Color, ...]`.
  Both unit variants and payload variants are supported. LLVM lowering interprets
  the enum metadata to access array elements with proper type information, allowing
  `.for` loops to iterate over enum arrays and match on their tags without Python
  fallbacks. Regression coverage lives in
  `compiler/tests/test_stage1_pipeline.py::test_native_backend_tags_enum_array_literals_with_metadata`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_enum_arrays`,
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_iterates_mixed_enum_arrays`.
  Struct method invocations now lower into `Struct::method` call sites with the
  receiver injected as the leading argument (loading pointers to match recorded
  layouts), removing the lingering `value.method` diagnostics; regression coverage
  lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_calls_struct_methods`.
  Enum declarations now emit `.layout` descriptors that record tag type, size,
  alignment, and per-variant payload layouts, flowing through the native IR into
  LLVM type definitions. Enum types lower to tagged-union representations
  (`{ tag_type, [payload_bytes x payload_size] }`) where the tag identifies the
  active variant and the payload area stores variant-specific fields. Enum
  constructor expressions (both unit variants like `Color.Red` and payload variants
  like `Shape.Circle { radius: 5.0 }`) now fully lower into LLVM: unit variants use
  `insertvalue` to populate the tag field, while payload variants allocate the enum
  on the stack, store the tag, then use `getelementptr` and `bitcast` to store each
  payload field at its correct byte offset within the payload array before loading
  the complete enum value. Regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_basic_enum_types`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_constructs_simple_enum_variant`,
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_stores_enum_payload_fields`.
  Recursive enum payloads now heap-box aggregate values when variant metadata
  describes pointer-shaped storage, so self-referential variants (e.g.,
  `Value.Pair { left -> Value, right -> Value }`) lower without Python fallbacks
  or coercion diagnostics. Coverage: `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_allocates_recursive_enum_payloads`.
  Match expressions now destructure enum operands natively by extracting the tag
  field via `extractvalue` and comparing it against variant tag values, enabling
  Stage2 programs to dispatch on enum variants without Python fallbacks. Both unit
  variants (e.g., `Color.Red`, `Status.Pending`) and payload variants (e.g.,
  `Shape.Circle { radius }`) fully work in match arms. Field binding using shorthand
  syntax (e.g., `Shape.Circle { radius }` extracts the `radius` field into a local
  variable named `radius`) is now implemented, allowing match arms to access and
  compute with payload field values. The implementation uses GEP instructions to
  extract fields from the payload byte array at their correct byte offsets, accounting
  for variant layout metadata.
  Regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_matches_enum_variants`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_matches_mixed_enum_variants`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_matches_payload_enum_by_tag`,
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_extracts_enum_payload_fields_in_match`.
  Interface
  declarations and struct `implements` clauses now flow through the native IR so
  the LLVM backend can reason about trait membership without inspecting source
  ASTs. The LLVM lowering pipeline surfaces this information via
  `LoweredLLVMResult.trait_metadata`, providing structured descriptors for each
  interface (name, generics, signatures) and every struct that implements them.
  Stage2 now emits trait object types and vtable structures for interface support.
  Each interface generates a trait object type definition (`%trait.InterfaceName`)
  represented as `{ i8*, i8* }` (data pointer + vtable pointer). For every
  struct-interface pair, the compiler emits a vtable type definition (e.g.,
  `%vtable.StructName.InterfaceName`) containing function pointer types for each
  interface method, and a corresponding global constant initialized with bitcast
  references to the struct's method implementations. Regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_vtable_type_definitions`,
  `test_native_llvm_execution_emits_vtable_constants`, and
  `test_native_llvm_execution_emits_multiple_vtables`. Method dispatch through
  trait objects now fully works: when assigning a concrete struct value to an
  interface-typed local (e.g., `let greeter -> Greeter = User { ... }`), the
  compiler boxes the struct by allocating it on the stack, casting the struct
  pointer to `i8*`, retrieving the vtable pointer for the struct-interface pair,
  and building a trait object via `insertvalue` instructions. Method calls on
  interface-typed values (e.g., `greeter.greet()`) dispatch dynamically: the
  compiler extracts the data pointer and vtable pointer from the trait object via
  `extractvalue`, casts the vtable to the appropriate function pointer type, loads
  the method pointer from the vtable slot corresponding to the called method, and
  emits an indirect call passing the data pointer as the implicit receiver followed
  by any user-supplied arguments. This enables polymorphism without Python fallbacks,
  allowing functions to accept interface-typed parameters and call methods on them
  regardless of the underlying concrete type. Regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_boxes_struct_into_trait_object`
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_dispatches_through_trait_object`.
  String literals now fully lower to LLVM global constants, enabling functions
  and interface methods to return string values without Python fallbacks. When
  lowering string literals (e.g., `"Hello, World!"`), the compiler unescapes
  standard sequences (`\n`, `\t`, `\"`, `\\`), generates a unique global constant
  name (`@.str.0`, `@.str.1`, etc.), and emits a private unnamed_addr constant
  declaration in the module preamble (`@.str.N = private unnamed_addr constant
  [length x i8] c"content\00"`). The lowered expression references the global via
  `getelementptr inbounds` to produce an `i8*` pointer suitable for string-typed
  returns and assignments. String constants are automatically deduplicated:
  identical literals across multiple functions reuse the same global constant,
  reducing code size and memory footprint. Additionally, struct method `self`
  parameters are now properly typed when implementing interface methods: when a
  method name contains `::` (e.g., `Person::format`), the compiler extracts the
  struct name and infers the `self` parameter type as a pointer to that struct
  (`%Person*`), enabling member access expressions like `self.field` to compile
  correctly without "missing type annotation" diagnostics. This allows interface
  methods to access struct fields and return computed values. Regression coverage
  lives in `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_string_literal`
  (verifies global constant emission and LLVM IR compilation),
  `test_native_llvm_execution_deduplicates_string_constants` (validates that
  identical literals share a single global), and
  `test_native_llvm_execution_returns_string_from_method` (confirms interface
  methods returning string literals compile without "unhandled return expression"
  diagnostics). Method return expression coverage now validates that interface
  methods can return all expression types end-to-end without regressions:
  `test_native_llvm_execution_method_returns_string_literal` verifies string
  literal returns with proper global constant emission and LLVM IR generation,
  `test_native_llvm_execution_method_returns_field_access` validates struct field
  access returns (e.g., `return self.field`) with proper GEP and load instructions,
  `test_native_llvm_execution_method_returns_computed_value` confirms computed
  expressions (e.g., `return self.x + self.y`) with arithmetic operations and field
  access, and `test_native_llvm_execution_method_returns_call_result` validates
  returning function call results (e.g., `return helper(self.data)`) with proper
  call lowering and argument passing. These tests guard against future regressions
  before self-hosting the compiler with Stage2.
  Complex parameter and local type resolution now uses pointer-based fallbacks
  for unresolved types instead of defaulting to `double`, significantly reducing
  spurious diagnostics when compiling modules that reference types from imported
  dependencies not in the current module's type context. When `map_parameter_type`
  or `map_local_type` encounters a type annotation that can't be resolved (e.g.,
  `Decorator` from `ast.sfn` when lowering `decorator_semantics.sfn`), it now
  returns `i8*` (generic pointer) instead of failing to `double`. Similarly,
  `map_array_pointer_type` uses `i8*` as the element type for arrays of unresolved
  types (e.g., `Decorator[]` becomes `{ i8**, i64 }*` instead of failing). This
  enables function parameters like `decorators -> Decorator[]`, `arguments ->
  DecoratorArgument[]`, and `expr -> Expression` to lower to reasonable LLVM types
  even when the struct/enum definitions aren't available during lowering. The
  change eliminates "unsupported parameter type" diagnostics and "member access
  base `double` lacks struct metadata" warnings from Stage2 bootstrap output.
  Remaining "member access base `i8*` lacks struct metadata" and "member access
  base `{ i8**, i64 }*` lacks struct metadata" warnings are expected for operations
  on opaque pointer types (field access, array indexing on imported types) and
  will be addressed once cross-module type resolution (automatic layout manifest
  loading for imports) is implemented. Regression coverage lives in
  `compiler/tests/test_complex_parameter_types.py::test_native_llvm_function_with_struct_array_parameter`
  (validates struct array parameters like `Point[]` don't produce "unsupported
  parameter type" diagnostics),
  `test_native_llvm_function_with_enum_array_parameter` (validates enum array
  parameters like `Color[]` compile cleanly),
  `test_native_llvm_function_with_nested_struct_parameter` (validates nested struct
  parameters like `Rectangle` containing `Point` fields compile correctly), and
  `test_native_llvm_function_with_unresolved_import_type_uses_pointer_fallback`
  (confirms unresolved types like `Token` use `i8*` fallback instead of `double`).
  Array indexing expressions
  (`array[index]`) now fully lower to LLVM, enabling compiler internals to access
  AST node fields, token arrays, and decorator lists without Python fallbacks. The
  implementation recognizes `base[index]` syntax using `parse_index_expression`
  (which splits into base and index expressions by finding the outermost bracket
  pair), then lowers both sub-expressions to LLVM operands. For heap-allocated
  arrays (e.g., `number[]` with LLVM type `{ double*, i64 }*`), the compiler loads
  the array struct, extracts the data pointer (field 0) and length (field 1) via
  `extractvalue`, performs bounds checking (`icmp uge` comparing index against
  length), generates `getelementptr` to compute the element address, and loads
  the element value. String indexing (e.g., `text[0]` where `text` has type `i8*`)
  works similarly but skips length extraction since strings don't carry stored
  length metadata. Bounds checks emit comparison instructions and comments marking
  potential out-of-bounds access (actual trap handling deferred to follow-on work).
  Regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_indexes_primitive_array`
  (validates indexing into `number[]` arrays with variable and literal indices),
  `test_native_llvm_execution_indexes_struct_array` (validates indexing into
  `Token[]` and other struct arrays with field access on indexed results),
  `test_native_llvm_execution_checks_array_bounds` (confirms bounds check
  instructions emit in generated IR), and
  `test_native_llvm_execution_indexes_string_character` (validates character
  access from strings via `text[index]` returning `i8` values). With array
  indexing implemented, Stage2 bootstrap warnings for `unsupported expression
  decorators[index]` and `unsupported expression text[0]` are eliminated,
  unblocking progress on warning-free self-compilation.
  Compound assignment operators (`+=`, `-=`, `*=`, `/=`) now lower to LLVM by
  desugaring into simple assignments during lowering. The `parse_assignment_expression`
  function recognizes compound operators when scanning for `=` characters and
  returns an `operator` field alongside `target` and `value`. When
  `lower_expression_statement` encounters a compound assignment (e.g., `count += 1`),
  it transforms it into an equivalent simple assignment with a binary expression
  (`count = count + 1`) before lowering, reusing the existing binary operation
  infrastructure. This enables mutation-heavy compiler code (loop counters,
  accumulators) to compile without fallback diagnostics. The implementation
  handles `+=` (addition), `-=` (subtraction), `*=` (multiplication), and `/=`
  (division) for both integer and floating-point types, generating appropriate
  LLVM arithmetic instructions (`fadd`, `fsub`, `fmul`, `fdiv` for `number`,
  `add`, `sub`, `mul`, `sdiv` for `int`). Regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_compound_add_assignment`
  (validates `+=` in loop counters and accumulators compiles and executes correctly),
  `test_native_llvm_execution_compound_subtract_assignment` (validates `-=` operator
  with proper arithmetic result), and
  `test_native_llvm_execution_compound_multiply_divide` (validates `*=` and `/=`
  operators in computation sequences). With compound assignment support, Stage2
  bootstrap warnings like "assignment to unknown local `index +`" are eliminated,
  bringing the compiler closer to warning-free self-compilation.
  Logical operators (`&&`, `||`) now lower to LLVM with proper short-circuit
  evaluation semantics, enabling conditional expressions in compiler logic to compile
  without fallbacks. The implementation uses LLVM control flow primitives (basic blocks,
  conditional branches, phi nodes) to skip right operand evaluation when the left
  operand determines the result. For `a && b`, the compiler evaluates `a`, coerces it
  to `i1`, branches to a check_right label if true or directly to merge if false;
  the check_right block evaluates `b`, and the merge block emits a phi node selecting
  `false` (from the short-circuit path) or the evaluated right value. For `a || b`,
  the logic inverts: branch to merge if left is true (short-circuit with `true`),
  otherwise evaluate right. Nested logical operators (e.g., `a && b || c && d`) work
  correctly by recursively emitting sub-expressions with unique label IDs derived from
  incrementing temp indices, ensuring no label collisions. The implementation inserts
  intermediate `right_end` labels after evaluating right operands to isolate control
  flow from nested expressions before branching to the merge label, satisfying LLVM's
  requirement that phi nodes reference actual predecessor blocks. Regression coverage
  lives in `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_logical_and_short_circuits`
  (validates `&&` compiles with proper labels, branches, and phi nodes, and executes
  with correct short-circuit behavior),
  `test_native_llvm_execution_logical_or_short_circuits` (similar for `||`),
  `test_native_llvm_execution_nested_logical_operators` (validates complex expressions
  like `a && b || c && d` and chained operators like `temp1 || temp2 || true` generate
  valid IR with unique labels), and
  `test_native_llvm_execution_logical_operators_with_comparisons` (validates logical
  operators combined with comparison expressions like `x > 0.0 && x < 100.0` compile
  and execute correctly). With logical operator support, Stage2 bootstrap warnings
  like "call to unknown function `requires_io && !contains_effect`" are eliminated,
  bringing the compiler closer to warning-free self-compilation.
  Ternary conditional expressions (`condition ? true_value : false_value`) now lower
  to LLVM with proper control flow and type merging, enabling inline conditionals in
  compiler code to compile without fallbacks. The implementation uses LLVM control flow
  primitives (basic blocks, conditional branches, phi nodes) to evaluate the condition,
  branch to either the `then` or `else` label, evaluate the corresponding expression,
  and merge the results with a phi node. The lowering process generates six labels:
  `cond` (evaluates condition), `then` (evaluates true branch), `then_end` (isolates
  then branch), `else` (evaluates false branch), `else_end` (isolates else branch),
  and `merge` (phi node merge point). The condition expression is coerced to `i1` for
  the branch instruction, and both branches must produce compatible LLVM types for the
  phi merge (validated at compile time with type checking diagnostics). Intermediate
  `then_end` and `else_end` labels isolate nested control flow before branching to
  merge, ensuring phi nodes reference correct predecessor blocks. Nested ternary
  expressions (e.g., `x > 0 ? (x > 10 ? 2 : 1) : 0`) work correctly by recursively
  emitting sub-expressions with unique label IDs derived from incrementing temp
  indices, ensuring no label collisions. Ternary operators integrate with logical
  operators, allowing conditions like `x > 0.0 && x < 100.0 ? result : fallback` to
  compile and execute correctly. Regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_ternary_operator`
  (validates basic ternary expressions compile with proper labels, branches, phi nodes,
  and execute with correct values),
  `test_native_llvm_execution_nested_ternary` (validates nested ternary expressions
  generate valid IR with unique labels and correct execution semantics), and
  `test_native_llvm_execution_ternary_with_logical_operators` (validates ternary
  operators combined with logical operators in the condition compile and execute
  correctly). With ternary operator support, Stage2 can compile inline conditional
  expressions found throughout compiler internals, bringing the compiler closer to
  warning-free self-compilation.
  Borrow expressions now lower into explicit
  LLVM pointer values so functions can accept and forward `&T` / `&mut T`
  parameters without falling back to the Python bridge (guarded by
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_lowers_borrow_expressions`).
  Ownership metadata now threads through `.sfn-asm`, and Stage2 flagging rejects
  conflicting borrows (mutable-with-mutable or mutable-with-shared) during LLVM
  lowering (`compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_conflicting_mut_borrows`
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_conflicting_shared_borrows`).
  Lifetime regions now surface alongside those borrow checks; the LLVM pipeline
  records `LifetimeRegionMetadata` entries (binding, base, mutability, scope id,
  scope depth, and start span) on `LoweredLLVMResult.lifetime_regions` so
  diagnostics and follow-on tooling can reason about scope exits without
  re-parsing `.sfn-asm`. Regions now track release scopes when locals are
  reassigned in nested control flow, so reborrows that end before leaving a
  branch or loop no longer trigger false positives; regression coverage lives in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_lifetime_regions`
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_allows_scoped_reborrow`.
  The recorded scope metadata now feeds borrow-release validation: assignments
  that bind a borrow whose base lives in a deeper scope emit
  `llvm lowering: borrow ... escapes lifetime ...` diagnostics, preventing
  escaped references from crossing scope boundaries. Regression coverage lives
  in
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_borrow_lifetime_violation`.
  Ownership consumption now survives merges across loops, `if`/`else`, and `match`
  blocks, so use-after-move checks on locals and parameters fire when those
  values are reused after being consumed; the execution suite in
  `compiler/tests/test_native_llvm_execution.py` exercises these control-flow
  paths while ensuring legitimate reassignments clear the consumed state, with
  targeted coverage for non-copy aggregates such as `Affine<number[]>`
  (`compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move_for_affine_array`).
  Block lowering now records `LocalMutation` metadata for every `let` binding or
  reassignment lowered through `lower_instruction_range`, preserving the LLVM
  type, stored SSA value, span, and defining label for SSA phi node generation.
  Mutation metadata threads through all control-flow structures (`lower_if_instruction`,
  `lower_loop_instruction`, `lower_for_instruction`, and `lower_match_instruction`),
  accumulating mutations from nested blocks while preserving originating labels.
  For straight-line `if` statements (without `else`), the compiler now emits SSA
  phi nodes at merge points to select between the mutated value (from the `then` branch)
  and the original value (from the base block), storing the result back through the
  local pointer. For full `if`/`else` statements, the compiler emits phi nodes that
  union mutations from both branches, correctly handling cases where both arms mutate
  shared locals and cases where each arm mutates unique locals. Terminated branches are
  skipped during phi generation. For `loop` constructs, the lowering now creates explicit
  preheader, header, body, latch, and exit labels, emitting phi nodes in the header for
  locals mutated in the body (merging values from the preheader and latch), and ensuring
  `continue` targets the latch instead of jumping directly back to the header. For `for`
  loops (both range-based and array iteration), the proper structure (header with condition
  check, body, increment/latch, exit) was already in place with `continue` correctly
  targeting the increment label. For `match` statements, the compiler now emits multi-input
  phi nodes at the shared merge label for each local mutated in any arm, accumulating
  mutations per arm (including guards) with their terminating labels and skipping terminated
  arms during phi generation. All phi node emission functions share common helper logic:
  `find_preloaded_value` retrieves the initial value for a local before control flow diverges,
  `collect_mutation_names` builds a unique set of mutated local names from mutation lists,
  `find_mutation_for_name` looks up mutation metadata for a specific local, `join_strings`
  concatenates phi input strings, and `build_phi_and_store` generates paired phi and store
  instructions (ensuring LLVM's requirement that all phi nodes appear grouped at the top of
  each basic block before any other instructions). This enables LLVM's optimization passes to
  work more effectively with the generated IR. Regression coverage lives in
  `compiler/tests/test_stage2_mutation_capture.py::test_lower_instruction_range_records_local_mutations`
  plus propagation tests (`test_mutations_propagate_through_if_then`,
  `test_mutations_propagate_through_if_else`, `test_mutations_propagate_through_loop`,
  `test_mutations_propagate_through_match`) and execution validation via
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_straight_line_if`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_if_else`,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_phi_for_match`,
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_runs_program`
  (which includes `loop_and_match` with loop accumulators and `sum_for` with for-loop accumulators).
  Move diagnostics now thread source spans from `.sfn-asm` through the native IR,
  so LLVM lowering reports use-after-move errors with line and column ranges
  (`compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move`
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_reports_use_after_move_for_affine_array`).
  Borrowed references still introduce internal effects (`!read`, `!mut`) that
  compose with capability-driven effects. The lowering pipeline now records those
  requirements per function (`LoweredLLVMResult.function_effects`), annotates the
  emitted LLVM IR with effect comments, and wires them into the entry-point
  capability manifest (`LoweredLLVMResult.capability_manifest`) so callers see
  composite requirements. `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_capability_manifest_propagates_composite_effects`
  locks the manifest propagation behaviour, including borrow + capability
  combinations. The Stage2 runner now consumes those manifests: `runtime.stage2_runner.Stage2Runner`
  acquires a capability grant for each entry point before invoking native
  helpers and rejects runtime calls whose effects are absent from the grant
  (`compiler/tests/test_native_llvm_execution.py::test_stage2_runner_applies_capability_manifest`
  and `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_denies_missing_capabilities`).
  Capability-aware intrinsics now declare their required effects at the LLVM
  backend layer. The LLVM lowering pipeline (`native_llvm_lowering.sfn`) defines
  runtime helper descriptors for IO operations (`console.info`, `fs.read`,
  `fs.write`, `fs.exists`), network operations (`http.get`, `http.post`),
  and model operations (`prompt`, `model_invoke`), each tagged with their
  required capabilities (`io`, `net`, or `model`). LLVM IR generation emits
  these intrinsics as `declare` statements prefixed with capability metadata
  comments (e.g., `; intrinsic sailfin_intrinsic_io_print requires capabilities: ![io]`),
  making effect requirements visible in the generated IR. Calls to these
  intrinsics automatically inherit the intrinsic's effects and propagate them
  through the capability manifest. Coverage:
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_emits_intrinsic_declarations`
  validates declaration generation with metadata,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_intrinsic_calls_compile`
  ensures intrinsic calls compile without Python fallbacks, and
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_capability_manifest_includes_intrinsic_effects`
  verifies effects flow into the manifest for entry points.
  Capability adapter declarations now expose `fs`, `http`, `model`, `serve`,
  and concurrency primitives as callable symbols in Stage2 LLVM modules. The
  LLVM lowering pipeline defines adapter function signatures for filesystem
  operations (`fs_read_file`, `fs_write_file`, `fs_list_directory`), HTTP
  operations (`http_get`, `http_post`), model invocation
  (`model_invoke_with_prompt`), server handling (`serve_start`,
  `serve_handler_dispatch`), and concurrency operations (`spawn_task`,
  `channel_create`, `channel_send`, `channel_receive`). Each adapter is tagged
  with appropriate effect annotations (`io`, `net`, `model`, `spawn`, `channel`)
  and emits LLVM external function declarations when referenced. Adapter calls
  route through the existing runtime helper infrastructure, ensuring proper
  symbol resolution and capability metadata propagation. Coverage:
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_calls_fs_adapter`
  validates filesystem adapter declarations,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_calls_http_adapter`
  validates HTTP adapter declarations,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_calls_model_adapter`
  validates model adapter declarations,
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_calls_serve_adapter`
  validates server adapter declarations, and
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_calls_spawn_adapter`
  validates concurrency adapter declarations.
  Stage2Runner now registers capability adapters in `__init__` that bridge LLVM
  ABI calls to Python runtime helpers. The adapter registration flow creates
  C function wrappers for each adapter symbol (e.g., `sailfin_adapter_fs_read_file`),
  enforces capability requirements via active `CapabilityGrant` context, and
  marshals LLVM pointer arguments to/from Python strings and objects. Adapters
  for filesystem operations (`fs_read_file`, `fs_write_file`, `fs_list_directory`),
  HTTP operations (`http_get`, `http_post`), model invocation
  (`model_invoke_with_prompt`), server handling (`serve_start`,
  `serve_handler_dispatch`), and concurrency operations (`spawn_task`,
  `channel_create`, `channel_send`, `channel_receive`) are fully registered
  and enforce their respective effect requirements (`io`, `net`, `model`,
  `spawn`, `channel`) before delegating to `runtime_support.py` implementations.
  When native code attempts an operation without proper capability grants,
  the adapter raises `PermissionError` with a diagnostic message. End-to-end
  regression coverage in
  `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_executes_fs_operations`
  (filesystem write/read round-trip),
  `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_executes_http_request`
  (HTTP GET with mock adapter),
  `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_executes_model_prompt`
  (model invocation with mock adapter),
  `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_executes_serve_handler`
  (server handler registration and dispatch),
  `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_executes_spawn_and_channel`
  (spawn task and channel communication), and
  `compiler/tests/test_native_llvm_execution.py::test_stage2_runner_enforces_capability_restrictions`
  (validates `PermissionError` when capabilities are missing). Adapter ABI,
  registration flow, and capability enforcement documented in
  `docs/runtime_audit.md`.
  Stage2 lowering now rejects suspension points (`await`, `yield`)
  that would keep a mutable borrow or mutable borrow parameter alive, enforcing
  the lattice rule `!mut ⊄ !async`. Diagnostics now attach source spans for both
  the active borrow and the suspension site so LLVM errors cross-link the borrow
  declaration with the offending `await`/`yield`; see
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await`
  and `compiler/tests/test_native_llvm_execution.py::test_native_llvm_allows_await_without_mutable_borrow`
  for the rejection/acceptance coverage. Raw pointer access remains gated behind `unsafe extern`
  declarations and lexical `unsafe { ... }` blocks so Stage2 can target LLVM/WASM
  without exposing unchecked pointer mutation to safe code.
  Snapshot coverage now locks representative `.sfn-asm` and LLVM IR output via
  `compiler/tests/test_stage2_golden.py`, and the `stage2_environment` fixture
  caches Sailfin→LLVM compilations for the entire suite.
  Parameter declarations now emit `.param` span metadata inside `.sfn-asm`, so
  suspension diagnostics also highlight the mutable borrow parameter location;
  regression coverage lives in
  `compiler/tests/test_stage1_pipeline.py::test_native_backend_emits_parameter_spans`
  and still exercises `compiler/tests/test_native_llvm_execution.py::test_native_llvm_rejects_mutable_borrow_across_await`.
- **Registry** — `registry.sailfin.dev` serves capsule and model metadata.
  Integration with the self-hosted toolchain remains roadmap work; manifests
  and CLI flows are tracked separately.

## Feature Snapshot

**Parsing & Declarations**

- Stage0 (legacy): Parses `fn`, `struct`, `enum`, `interface`, `model`, `tool`,
  `pipeline`, `test`, `type`, and `match` declarations.
- Stage1: Mirrors the same surface and now recognises
  block-level `if`/`else`, `for` loops, and `match` statements with `case`
  guards captured as expressions plus inline `=>` expression or `return`
  bodies. Common expressions (member access, function calls, unary `!`/`-`,
  binary operators through `&&`/`||`, range operators (`start..end`),
  indexing (`target[index]`), lambda expressions (`fn (...) { ... }`), and
  literal forms like `[x, y]`, `{ key: value }`, and `Type { field: value }`)
  now lower into structured nodes instead of `Raw` placeholders.

- Stage0 (legacy): Enforces `model`, `io`, `net`, and `clock` via
  `bootstrap/effect_checker.py`, covering prompt blocks, effectful decorators
  (e.g. `@logExecution`), and runtime helpers such as `fs.*`, `http.*`,
  `websocket.*`, `serve`, `spawn`, `print.*`, and `sleep` (including their
  `runtime.*` aliases).
- Stage1: Infers `io` when decorators like `@trace` or
  `@logExecution` appear and scans blocks for prompts, console helpers
  (`print.*`, `console.*`, `runtime.console.*`), runtime timers
  (`sleep`, `runtime.sleep`), and capability helpers such as `fs.*`,
  `runtime.fs.*`, `http.*`, `runtime.http.*`, `websocket.*`,
  `runtime.websocket.*`, `serve`, `runtime.serve`, `spawn`, and
  `runtime.spawn`. The effect checker now walks nested blocks,
  lambdas, and spawned thunks so prompts and capability adapters in
  async contexts propagate their `model`/`io`/`net`/`clock`
  requirements to the enclosing routine. Missing-effect diagnostics now
  emit precise source spans for the originating prompt or helper call
  and flow through the stage1 typechecker as structured errors. Messages
  include `![effect]` fix-it hints and reference the CLI fix prompt so
  teams can annotate signatures faster. Stage1 CLI output and native
  artifact diagnostics now surface those spans with caret-highlighted
  source snippets so developers see the offending line immediately
  (`compiler/tests/test_stage1_diagnostics.py::test_missing_effect_diagnostic_includes_source_snippet`).

- Stage0 (legacy): Performs symbol collection and effect validation inside the
  Python pipeline; deeper type checking remains future work.
- Stage1: `compiler/src/typecheck.sfn` now walks top-level and
  scoped blocks, builds symbol tables for functions/tests, and reports duplicate
  declarations (including parameter and local name clashes). The pass also
  enforces unique struct fields, struct methods, enum variants, interface
  members, model properties, and type parameters so Sailfin sources surface the
  same duplicate errors surfaced by the Python implementation. Struct
  declarations now validate every interface listed in their `implements`
  clause, emitting diagnostics when a required member is missing — including
  generic interface instantiations. Implements clauses now enforce generic
  arity, rejecting missing or extra type arguments for interface instantiations.
  Regression coverage spans `compiler/tests/test_stage1_typecheck_duplicates.py`
  for duplicate detection and
  `compiler/tests/test_stage1_typecheck_interfaces.py` for interface
  conformance (including type argument enforcement). Diagnostics flow through
  `compiler/src/main.sfn` so the bootstrap pipeline surfaces issues during
  round-trips.
- Stage0 (legacy): Prompts require the `model` effect; interpolation is handled by the
  runtime helpers.
- Stage1: Prompt statements are preserved in the AST and emitted
  as comments; deterministic scopes (`with seed(...)`) parse but have stubbed
  semantics.

- Stage0 (legacy): Emits data holders and plain Python functions; no special pipeline
  operator yet.
- Stage1: Uses the same emission strategy while preserving
  properties and effects. The planned `|>` operator remains illustrative only.
  Collection helpers (`array_map`, `array_filter`, `array_reduce`) and the
  sequential `parallel` orchestration now live in `runtime/prelude.sfn`, letting
  the self-hosted runtime exercise native Sailfin loops; regression coverage
  lives in `compiler/tests/test_runtime_prelude.py`. String helpers (`substring`,
  `find_char`), grapheme-aware utilities (`grapheme_count`, `grapheme_at`), and
  ASCII-aware character codes (`char_code`) now share the canonical
  implementation in `runtime/prelude.sfn`, which `compiler/src/string_utils.sfn`
  simply re-exports for the stage1 compiler. Descriptor-driven `check_type`
  now lives in the Sailfin prelude, with unions/intersections/arrays parsed in
  Sailfin and only runtime type resolution delegated to Python bridges. String
  interpolation lowers into segment arrays that call `runtime.format_interpolated`
  so placeholders execute without Python `eval` in Stage1 outputs. Struct
  facades now round-trip their instance methods (`struct Pair { fn sum(self) }`)
  into Python class methods, letting the runtime prelude surface richer helper
  shims without bootstrap fallbacks; validated via
  `compiler/tests/test_stage1_pipeline.py::test_struct_method_lowering`.
  Grapheme helpers now inline the Unicode segmentation tables so
  `grapheme_count`/`grapheme_at` execute without touching
  `runtime_support.py`; regression coverage lives in
  `compiler/tests/test_string_utils.py` (flag, combining-mark fixtures).
  Module parsing, emission, and lowering recognise aliased
  `import`/`export` specifiers so Sailfin sources can re-export runtime helpers;
  regression coverage lives in `compiler/tests/test_stage1_pipeline.py::test_import_export_alias_round_trip`.
  Capability grants plus `fs`/`http`/`model` bridges now expose effect-aware
  shims from `runtime/prelude.sfn` while still delegating to the Python runtime;
  runtime permissions are enforced in
  `compiler/tests/test_runtime_prelude.py::test_runtime_capability_bridges`.
  Native lowering now
  recognises top-level `.let` bindings (e.g., `console = runtime.console`) so
  the prelude compiles without spurious diagnostics.

- Stage0 (legacy): Parses `Affine<T>` / `Linear<T>` without enforcement.
- Stage1: Carries ownership metadata for borrow checking and now emits the data
  needed for Stage2 to diagnose conflicting borrows.

- Stage0 (legacy): Lowers tests to Python functions executed in the `__main__`
  preamble, enforcing required effects.
- Stage1: Generates the same scaffolding.

**Code Generation**

- Bootstrap: Walks the full AST and emits runnable Python against
  `runtime_support.py`. Console helpers cover `print.info`, `print.error`, and
  `print.warn`, each flagged by the effect checker as `io`. (Frozen except for
  hotfixes.)
- Stage1: Lowers Sailfin sources through the native pipeline and prints Python
  scaffolding via `native_lowering.sfn`, rewiring postfix helpers (`.map`,
  `.filter`, `.reduce`, `.concat`, `.length`) into runtime shims and `len(...)`
  calls. Block emission preserves local `let` declarations, loops,
  `if`/`else if`/`else` chains, and `match` statements so compiler sources
  round-trip cleanly. The structured `.sfn-asm` output from `emit_native.sfn`
  feeds both Python and LLVM lowerings; `native_llvm_lowering.sfn` now lifts
  arithmetic routines with local `let`s, assignments, `if`/`else` control
  flow, `loop` blocks (`break`/`continue`), `match` dispatch, and `.for` loops
  over numeric ranges with dynamic stride expressions, inline primitive array
  literals, and locals bound to array expressions (even without explicit type
  annotations) into runnable LLVM IR, with
  `compiler/tests/test_native_llvm_execution.py` executing the emitted IR via
  `llvmlite` as a smoke guard. Runtime console helpers are surfaced as external
  LLVM calls so stage2 lowers `print.info` against the existing Python prelude,
  covered by
  `compiler/tests/test_native_llvm_execution.py::test_native_llvm_execution_invokes_runtime_console`.

**Package Manager (`sfn`)**

- Bootstrap: Not implemented yet.
- Self-hosted prototype: Not implemented; behaviour lives in
  `docs/proposals/package-management.md`.

## Validation Coverage

- `make test` runs the stage1-focused pytest suite (`compiler/tests/`), covering
  the end-to-end self-host check (`test_stage1_artifact.py`) and native lowering
  validation.
- `make test-unit` targets fast Sailfin-specific checks (`pytest -m "unit and not stage2"`), while
  `make test-integration` isolates artifact packaging and self-hosting flows, and
  `make test-stage2` exercises the LLVM/native backend smoke suite.
- `compiler/tests/test_native_llvm_execution.py` lowers numeric, boolean,
  integer, and primitive-array-iterating samples (including `boolean[]` and
  `int[]` literals) to LLVM IR and executes them through `llvmlite` so Stage2
  regressions surface as standard test failures.
- `compiler/tests/test_stage1_pipeline.py::test_native_backend_emits_layout_descriptors`
  locks the `.layout` directives in `.sfn-asm` and the parsed layout metadata
  surfaced through the stage1 native IR parser.
- CI packages the stage1 artifact, uploads it, and semantic-release tags a
  GitHub release. The installer smoke test verifies the archive can rebuild
  stage1 (`scripts/install_stage1.py`).
- `examples/README.md` enumerates every runnable sample with declared effects;
  capability requirements stay in sync with the runtime helpers.
- Registry and CLI workflows remain manual; no automated coverage yet.

## Active Workstreams

1. **Stage2 backend** — Extend `.sfn-asm` lowering to emit runnable LLVM/WASM
   modules, bridge capability shims, and execute smoke binaries end-to-end.
2. **Runtime & FFI lift** — Replace Python runtime helpers with Sailfin
   implementations that surface the same effect guarantees and provide bridged
   access to filesystem, HTTP, model execution, and concurrency primitives.
3. **Diagnostics deepening** — Continue parity work in `typecheck.sfn` and
   `effect_checker.sfn` (hierarchical effects, richer messages) to match the
   historical stage0 behaviour without regressing stage1 self-hosting.
4. **Registry integration** — Wire manifest parsing and publish/resolve
   commands against `registry.sailfin.dev` once the self-host loop remains
   stable.

Track detailed milestones and sequencing in `docs/roadmap.md`. When a
feature graduates from prototype into the shipping stage1 toolchain, update the
table above and trim related “planned” callouts from the spec and examples.

## Test Harness

- Stage1 tests run via `make test` (pytest inside the `sailfin` Conda env). With
  the content-addressed Stage1 cache introduced in October 2025 the full suite
  now completes in **~82 seconds** on an M2 Mac Pro (previously ~11 minutes).
- Cached builds live under `.pytest-stage1/<hash>/compiler` and are derived from
  the contents of `compiler/src/**/*.sfn`, `runtime/**/*.sfn`, generated
  `compiler/build/**/*.py`, and the Python pipeline version. Cache hits and
  misses are logged when `PYTEST_STAGE1_DEBUG=1`.
- Developers can disable the cache with `PYTEST_STAGE1_NO_CACHE=1` or relocate it
  via `PYTEST_STAGE1_CACHE_DIR`. Remove the `.pytest-stage1/` directory to force
  recompilation if stale artefacts are suspected.
- `make warm-stage1-cache` pre-populates the cache (respects
  `PYTEST_STAGE1_CACHE_DIR`) so CI or fresh clones can avoid the first-run
  compile spike.
