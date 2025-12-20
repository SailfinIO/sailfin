; ModuleID = 'sailfin'
source_filename = "sailfin"

%ImportSpecifier = type opaque
%ExportSpecifier = type opaque
%SourceSpan = type opaque
%TypeAnnotation = type opaque
%Expression = type opaque
%Decorator = type opaque
%Statement = type opaque
%Parameter = type opaque
%TypeParameter = type opaque
%FieldDeclaration = type opaque
%LoweredPythonResult = type { i8*, { i8**, i64 }* }
%MatchContext = type { i8*, double, i1 }
%LoweredCaseCondition = type { i8*, i1, i1 }
%PythonModuleEmission = type { %PythonBuilder, { i8**, i64 }* }
%PythonFunctionEmission = type { %PythonBuilder, { i8**, i64 }* }
%PythonImportEmission = type { %PythonBuilder, { i8**, i64 }* }
%PythonStructEmission = type { %PythonBuilder, { i8**, i64 }* }
%StructLiteralCapture = type { i8*, double, i1 }
%ExpressionContinuationCapture = type { i8*, double, i1 }
%ExtractedSpan = type { i8*, double, double, i1 }
%PythonBuilder = type { { i8**, i64 }*, double }
%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { %NativeArtifact*, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { %NativeModule, { i8**, i64 }* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeState = type { %TextBuilder, { i8**, i64 }*, %LayoutContext }
%LayoutEmitResult = type { { i8**, i64 }*, { i8**, i64 }* }
%StructFieldLayoutDescriptor = type { i8*, i8*, double, double, double }
%RecordLayoutResult = type { double, double, { %StructFieldLayoutDescriptor*, i64 }*, { i8**, i64 }* }
%EnumVariantLayoutDescriptor = type { i8*, double, double, double, double, { %StructFieldLayoutDescriptor*, i64 }* }
%EnumAggregateLayout = type { double, double, double, double, { %EnumVariantLayoutDescriptor*, i64 }*, { i8**, i64 }* }
%TypeLayoutInfo = type { double, double, { i8**, i64 }* }
%LayoutFieldInput = type { i8*, i8* }
%LayoutStructDefinition = type { i8*, { %LayoutFieldInput*, i64 }* }
%LayoutEnumVariantDefinition = type { i8*, { %LayoutFieldInput*, i64 }* }
%LayoutEnumDefinition = type { i8*, { %LayoutEnumVariantDefinition*, i64 }* }
%CanonicalTypeLayout = type { i8*, double, double }
%LayoutContext = type { { %LayoutStructDefinition*, i64 }*, { %LayoutEnumDefinition*, i64 }* }
%NativeSourceSpan = type { double, double, double, double }
%NativeParameter = type { i8*, i8*, i1, i8*, %NativeSourceSpan* }
%NativeFunction = type { i8*, { %NativeParameter*, i64 }*, i8*, { i8**, i64 }*, { %NativeInstruction*, i64 }* }
%NativeImportSpecifier = type { i8*, i8* }
%NativeImport = type { i8*, i8*, { %NativeImportSpecifier*, i64 }* }
%NativeStructField = type { i8*, i8*, i1 }
%NativeStructLayoutField = type { i8*, i8*, double, double, double }
%NativeStructLayout = type { double, double, { %NativeStructLayoutField*, i64 }* }
%NativeStruct = type { i8*, { %NativeStructField*, i64 }*, { %NativeFunction*, i64 }*, { i8**, i64 }*, %NativeStructLayout* }
%NativeInterfaceSignature = type { i8*, i1, { i8**, i64 }*, { %NativeParameter*, i64 }*, i8*, { i8**, i64 }* }
%NativeInterface = type { i8*, { i8**, i64 }*, { %NativeInterfaceSignature*, i64 }* }
%NativeEnumVariantField = type { i8*, i8*, i1 }
%NativeEnumVariant = type { i8*, { %NativeEnumVariantField*, i64 }* }
%NativeEnumVariantLayout = type { i8*, double, double, double, double, { %NativeStructLayoutField*, i64 }* }
%NativeEnumLayout = type { double, double, i8*, double, double, { %NativeEnumVariantLayout*, i64 }* }
%NativeEnum = type { i8*, { %NativeEnumVariant*, i64 }*, %NativeEnumLayout* }
%NativeBinding = type { i8*, i1, i8*, i8* }
%EnumParseResult = type { %NativeEnum*, double, { i8**, i64 }* }
%CaseComponents = type { i8*, i8* }
%InstructionParseResult = type { { %NativeInstruction*, i64 }*, i1, i1 }
%InstructionGatherResult = type { i8*, double }
%InstructionDepthState = type { double, double, double, i1, i1 }
%StructParseResult = type { %NativeStruct*, double, { i8**, i64 }* }
%InterfaceParseResult = type { %NativeInterface*, double, { i8**, i64 }* }
%InterfaceSignatureParse = type { i1, %NativeInterfaceSignature, { i8**, i64 }* }
%StructHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%InterfaceHeaderParse = type { i8*, { i8**, i64 }*, { i8**, i64 }* }
%HeaderNameParse = type { i8*, { i8**, i64 }*, i8*, { i8**, i64 }* }
%StructLayoutHeaderParse = type { i1, i8*, double, double, { i8**, i64 }* }
%StructLayoutFieldParse = type { i1, %NativeStructLayoutField, { i8**, i64 }* }
%ParseNativeResult = type { { %NativeFunction*, i64 }*, { %NativeImport*, i64 }*, { %NativeStruct*, i64 }*, { %NativeInterface*, i64 }*, { %NativeEnum*, i64 }*, { %NativeBinding*, i64 }*, { i8**, i64 }* }
%EnumLayoutHeaderParse = type { i1, i8*, double, double, i8*, double, double, { i8**, i64 }* }
%EnumLayoutVariantParse = type { i1, %NativeEnumVariantLayout, { i8**, i64 }* }
%EnumLayoutPayloadParse = type { i1, i8*, %NativeStructLayoutField, { i8**, i64 }* }
%NumberParseResult = type { i1, double }
%LayoutManifest = type { { %NativeStruct*, i64 }*, { %NativeEnum*, i64 }*, { i8**, i64 }* }
%BindingComponents = type { i8*, i8*, i8* }

%NativeInstruction = type { i32, [48 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare double @char_code(i8*)
declare i1 @sailfin_runtime_is_whitespace_char(i8)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)
declare void @sailfin_runtime_mark_persistent(i8*)

declare %LayoutContext @build_layout_context(i8*)
declare %EmitNativeResult @emit_native(i8*)
declare %NativeState @emit_statement(%NativeState, i8*)
declare i8* @render_native_specifiers({ %ImportSpecifier*, i64 }*)
declare i8* @render_export_specifiers({ %ExportSpecifier*, i64 }*)
declare i8* @format_native_specifier(i8*, i8*)
declare %NativeState @emit_span_if_present(%NativeState, %SourceSpan*)
declare %NativeState @emit_initializer_span_if_present(%NativeState, %SourceSpan*)
declare i8* @append_optional_type_annotation(i8*, %TypeAnnotation*)
declare i8* @append_optional_initializer(i8*, %Expression*)
declare i8* @format_span(i8*)
declare %NativeState @emit_variable(%NativeState, i8*)
declare %NativeState @emit_function(%NativeState, i8*, i8*, { %Decorator*, i64 }*)
declare %NativeState @emit_pipeline(%NativeState, i8*)
declare %NativeState @emit_tool(%NativeState, i8*)
declare %NativeState @emit_test(%NativeState, i8*)
declare %NativeState @emit_model(%NativeState, i8*)
declare %NativeState @emit_type_alias(%NativeState, i8*)
declare %NativeState @emit_interface(%NativeState, i8*)
declare %NativeState @emit_enum(%NativeState, i8*)
declare %NativeState @emit_struct(%NativeState, i8*)
declare %NativeState @emit_method(%NativeState, i8*)
declare %NativeState @emit_prompt(%NativeState, i8*)
declare %NativeState @emit_with(%NativeState, i8*)
declare %NativeState @emit_for(%NativeState, i8*)
declare %NativeState @emit_loop(%NativeState, i8*)
declare %NativeState @emit_match(%NativeState, i8*)
declare %NativeState @emit_match_case(%NativeState, i8*)
declare %Statement* @select_inline_match_case_statement(i8*)
declare %NativeState @emit_inline_match_case(%NativeState, i8*, i8*)
declare i8* @format_match_case_head(i8*)
declare i8* @format_inline_case_body(i8*)
declare %NativeState @emit_if(%NativeState, i8*)
declare %NativeState @emit_else_branch(%NativeState, i8*)
declare %NativeState @emit_return(%NativeState, i8*)
declare i8* @format_optional_expression(%Expression*)
declare %NativeState @emit_expression_statement(%NativeState, i8*)
declare %NativeState @emit_block(%NativeState, i8*)
declare %NativeState @emit_decorators(%NativeState, { %Decorator*, i64 }*)
declare %NativeState @emit_signature_metadata(%NativeState, i8*)
declare %NativeState @emit_parameter_metadata(%NativeState, { %Parameter*, i64 }*)
declare i8* @format_decorator(i8*)
declare i8* @format_function_signature(i8*)
declare i8* @format_parameters({ %Parameter*, i64 }*)
declare i8* @format_type_parameters({ %TypeParameter*, i64 }*)
declare i8* @format_field(i8*)
declare i8* @format_enum_variant(i8*)
declare %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext, i8*, { %FieldDeclaration*, i64 }*)
declare %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext, i8*)
declare %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext, i8*, { %LayoutEnumVariantDefinition*, i64 }*, { i8**, i64 }*)
declare %RecordLayoutResult @calculate_record_layout(%LayoutContext, { %LayoutFieldInput*, i64 }*, i8*, i8*, { i8**, i64 }*)
declare %TypeLayoutInfo @analyze_type_layout(%LayoutContext, { i8**, i64 }*, i8*, i8*, i8*, i8*)
declare { %LayoutFieldInput*, i64 }* @convert_struct_fields({ %FieldDeclaration*, i64 }*)
declare { %LayoutFieldInput*, i64 }* @convert_variant_fields(i8*)
declare { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }*, %StructFieldLayoutDescriptor)
declare { %EnumVariantLayoutDescriptor*, i64 }* @append_enum_variant_layout({ %EnumVariantLayoutDescriptor*, i64 }*, %EnumVariantLayoutDescriptor)
declare { %LayoutFieldInput*, i64 }* @append_layout_field_input({ %LayoutFieldInput*, i64 }*, %LayoutFieldInput)
declare { %LayoutStructDefinition*, i64 }* @append_layout_struct_definition({ %LayoutStructDefinition*, i64 }*, %LayoutStructDefinition)
declare { %LayoutEnumDefinition*, i64 }* @append_layout_enum_definition({ %LayoutEnumDefinition*, i64 }*, %LayoutEnumDefinition)
declare { %LayoutEnumVariantDefinition*, i64 }* @append_layout_enum_variant_definition({ %LayoutEnumVariantDefinition*, i64 }*, %LayoutEnumVariantDefinition)
declare { %CanonicalTypeLayout*, i64 }* @append_canonical_type_layout({ %CanonicalTypeLayout*, i64 }*, %CanonicalTypeLayout)
declare %LayoutStructDefinition* @find_layout_struct_definition(%LayoutContext, i8*)
declare %LayoutEnumDefinition* @find_layout_enum_definition(%LayoutContext, i8*)
declare { %CanonicalTypeLayout*, i64 }* @canonical_type_layouts()
declare %CanonicalTypeLayout* @lookup_canonical_type_layout(i8*)
declare double @align_to(double, double)
declare i1 @is_array_type(i8*)
declare i1 @is_optional_annotation(i8*)
declare i8* @strip_optional_suffix(i8*)
declare i8* @format_expression(i8*)
declare i8* @format_array_expression({ %Expression*, i64 }*)
declare i8* @infer_array_element_type({ %Expression*, i64 }*)
declare i8* @infer_expression_type(i8*)
declare i8* @quote_string(i8*)
declare i8* @escape_string_char(i8*)
declare i1 @is_trim_char(i8*)
declare { i8**, i64 }* @collect_entry_points(i8*)
declare double @count_exported_symbols(i8*)
declare { i8**, i64 }* @append_unique({ i8**, i64 }*, i8*)
declare i1 @contains_string({ i8**, i64 }*, i8*)
declare %NativeState @state_new(%LayoutContext)
declare %NativeState @state_emit_line(%NativeState, i8*)
declare %NativeState @state_emit_blank(%NativeState)
declare %NativeState @state_push_indent(%NativeState)
declare %NativeState @state_pop_indent(%NativeState)
declare %NativeState @state_add_diagnostic(%NativeState, i8*)
declare %NativeState @state_merge_diagnostics(%NativeState, { i8**, i64 }*)
declare %NativeArtifact @generate_layout_manifest(i8*, %LayoutContext)
declare %NativeState @emit_layout_lines(%NativeState, { i8**, i64 }*)
declare %TextBuilder @builder_emit_line(%TextBuilder, i8*)
declare i8* @trim_right(i8*)
declare i8* @join_type_annotations({ %TypeAnnotation*, i64 }*)
declare %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }*)
declare %NativeArtifact* @select_layout_manifest_artifact({ %NativeArtifact*, i64 }*)
declare %ParseNativeResult @parse_native_artifact(i8*)
declare %NativeSourceSpan* @parse_source_span(i8*)
declare { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }*, %NativeFunction)
declare { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }*, %NativeBinding)
declare { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }*, %NativeImport)
declare { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }*, %NativeStruct)
declare { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }*, %NativeInterface)
declare { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }*, %NativeEnum)
declare { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }*, %NativeEnumVariant)
declare { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }*, %NativeEnumVariantField)
declare { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }*, %NativeStructField)
declare { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }*, %NativeStructLayoutField)
declare double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }*, i8*)
declare { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }*, double, %NativeStructLayoutField)
declare %NativeFunction @append_parameter(%NativeFunction, %NativeParameter)
declare %NativeFunction @append_instruction(%NativeFunction, %NativeInstruction)
declare %NativeBinding @binding_from_instruction(%NativeInstruction)
declare %NativeFunction @apply_meta(%NativeFunction, i8*)
declare %NativeFunction @update_function_meta(%NativeFunction, i8*, { i8**, i64 }*)
declare %InstructionGatherResult @gather_instruction({ i8**, i64 }*, double)
declare i1 @instruction_supports_multiline(i8*)
declare i1 @instruction_requires_continuation(%InstructionDepthState)
declare %InstructionDepthState @initial_instruction_depth_state()
declare %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState, i8*)
declare %InstructionParseResult @parse_instruction(i8*, %NativeSourceSpan*, %NativeSourceSpan*)
declare %NativeInstruction @parse_case_instruction(i8*)
declare { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8*)
declare %NativeInstruction @parse_inline_case_body_instruction(i8*)
declare %CaseComponents @split_case_components(i8*)
declare %NativeImport* @parse_import_entry(i8*, i8*)
declare { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8*)
declare %NativeImportSpecifier @parse_single_specifier(i8*)
declare %StructParseResult @parse_struct_definition({ i8**, i64 }*, double)
declare %InterfaceParseResult @parse_interface_definition({ i8**, i64 }*, double)
declare %StructHeaderParse @parse_struct_header(i8*)
declare %InterfaceHeaderParse @parse_interface_header(i8*)
declare %InterfaceSignatureParse @parse_interface_signature(i8*, i8*)
declare %HeaderNameParse @parse_header_name_and_remainder(i8*)
declare { i8**, i64 }* @parse_type_parameter_entries(i8*)
declare { i8**, i64 }* @parse_implements_list(i8*)
declare { i8**, i64 }* @split_top_level_commas(i8*)
declare double @find_matching_angle(i8*, double)
declare double @find_matching_paren(i8*, double)
declare %EnumParseResult @parse_enum_definition({ i8**, i64 }*, double)
declare %NativeEnumVariant* @parse_enum_variant_line(i8*)
declare { i8**, i64 }* @split_enum_field_entries(i8*)
declare %NativeEnumVariantField* @parse_enum_variant_field(i8*)
declare i8* @text_char_at(i8*, double)
declare i8* @maybe_trim_trailing(i8*)
declare %NativeStructField* @parse_struct_field_line(i8*)
declare %StructLayoutHeaderParse @parse_struct_layout_header(i8*)
declare %StructLayoutFieldParse @parse_struct_layout_field(i8*, i8*)
declare %EnumLayoutHeaderParse @parse_enum_layout_header(i8*)
declare %EnumLayoutVariantParse @parse_enum_variant_layout(i8*, i8*)
declare %EnumLayoutPayloadParse @parse_enum_payload_layout(i8*, i8*)
declare %NativeInstruction @parse_let_instruction(i8*, %NativeSourceSpan*, %NativeSourceSpan*)
declare %BindingComponents @parse_binding_components(i8*)
declare i8* @parse_function_name(i8*)
declare %NativeParameter* @parse_parameter_entry(i8*, %NativeSourceSpan*)
declare i1 @line_looks_like_parameter_entry(i8*)
declare { i8**, i64 }* @split_parameter_entries(i8*)
declare { i8**, i64 }* @parse_effect_list(i8*)
declare { i8**, i64 }* @split_whitespace(i8*)
declare %NumberParseResult @parse_decimal_number(i8*)
declare { i8**, i64 }* @split_lines(i8*)
declare { i8**, i64 }* @split_comma_separated(i8*)
declare i8* @strip_generics(i8*)
declare %LayoutManifest @parse_layout_manifest(i8*)
declare i8* @strip_prefix(i8*, i8*)
declare double @last_index_of(i8*, i8*)
declare i8* @strip_quotes(i8*)
declare { i8**, i64 }* @split_text(i8*, i8*)
declare { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }*, %NativeParameter)
declare i1 @is_symbol_char(i8*)
declare i8* @sanitize_symbol(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"

declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

define %LoweredPythonResult @lower_to_python(%NativeModule %native_module) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %NativeArtifact*
  %l2 = alloca %ParseNativeResult
  %l3 = alloca %PythonModuleEmission
  %l4 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = extractvalue %NativeModule %native_module, 0
  %t13 = call %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }* %t12)
  store %NativeArtifact* %t13, %NativeArtifact** %l1
  %t14 = load %NativeArtifact*, %NativeArtifact** %l1
  %t15 = icmp eq %NativeArtifact* %t14, null
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load %NativeArtifact*, %NativeArtifact** %l1
  br i1 %t15, label %then0, label %merge1
then0:
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = call i8* @malloc(i64 40)
  %t20 = bitcast i8* %t19 to [40 x i8]*
  store [40 x i8] c"no sailfin-native-text artifact present\00", [40 x i8]* %t20
  %t21 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t18, i8* %t19)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l0
  %t22 = call i8* @malloc(i64 1)
  %t23 = bitcast i8* %t22 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t23
  %t24 = insertvalue %LoweredPythonResult undef, i8* %t22, 0
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = insertvalue %LoweredPythonResult %t24, { i8**, i64 }* %t25, 1
  ret %LoweredPythonResult %t26
merge1:
  %t27 = load %NativeArtifact*, %NativeArtifact** %l1
  %t28 = getelementptr %NativeArtifact, %NativeArtifact* %t27, i32 0, i32 2
  %t29 = load i8*, i8** %t28
  %t30 = call %ParseNativeResult @parse_native_artifact(i8* %t29)
  store %ParseNativeResult %t30, %ParseNativeResult* %l2
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t33 = extractvalue %ParseNativeResult %t32, 6
  %t34 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t31, { i8**, i64 }* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l0
  %t35 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t36 = extractvalue %ParseNativeResult %t35, 0
  %t37 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t38 = extractvalue %ParseNativeResult %t37, 1
  %t39 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t40 = extractvalue %ParseNativeResult %t39, 2
  %t41 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t42 = extractvalue %ParseNativeResult %t41, 4
  %t43 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t44 = extractvalue %ParseNativeResult %t43, 5
  %t45 = call %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }* %t36, { %NativeImport*, i64 }* %t38, { %NativeStruct*, i64 }* %t40, { %NativeEnum*, i64 }* %t42, { %NativeBinding*, i64 }* %t44)
  store %PythonModuleEmission %t45, %PythonModuleEmission* %l3
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t48 = extractvalue %PythonModuleEmission %t47, 1
  %t49 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t46, { i8**, i64 }* %t48)
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  %t50 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t51 = extractvalue %PythonModuleEmission %t50, 0
  %t52 = call i8* @builder_to_string(%PythonBuilder %t51)
  store i8* %t52, i8** %l4
  %t53 = load i8*, i8** %l4
  %t54 = insertvalue %LoweredPythonResult undef, i8* %t53, 0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = insertvalue %LoweredPythonResult %t54, { i8**, i64 }* %t55, 1
  ret %LoweredPythonResult %t56
}

define %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }* %functions, { %NativeImport*, i64 }* %imports, { %NativeStruct*, i64 }* %structs, { %NativeEnum*, i64 }* %enums, { %NativeBinding*, i64 }* %bindings) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca %PythonImportEmission
  %l4 = alloca %PythonStructEmission
  %l5 = alloca double
  %l6 = alloca %PythonFunctionEmission
  %t0 = call %PythonBuilder @builder_new()
  store %PythonBuilder %t0, %PythonBuilder* %l0
  %t1 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t2 = ptrtoint [0 x i8*]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to i8**
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t6, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 0, i64* %t12
  store { i8**, i64 }* %t10, { i8**, i64 }** %l1
  %t13 = load %PythonBuilder, %PythonBuilder* %l0
  %t14 = call i8* @malloc(i64 15)
  %t15 = bitcast i8* %t14 to [15 x i8]*
  store [15 x i8] c"import asyncio\00", [15 x i8]* %t15
  %t16 = call %PythonBuilder @builder_emit(%PythonBuilder %t13, i8* %t14)
  store %PythonBuilder %t16, %PythonBuilder* %l0
  %t17 = load %PythonBuilder, %PythonBuilder* %l0
  %t18 = call i8* @malloc(i64 47)
  %t19 = bitcast i8* %t18 to [47 x i8]*
  store [47 x i8] c"from runtime import runtime_support as runtime\00", [47 x i8]* %t19
  %t20 = call %PythonBuilder @builder_emit(%PythonBuilder %t17, i8* %t18)
  store %PythonBuilder %t20, %PythonBuilder* %l0
  %t21 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t22 = ptrtoint [0 x i8*]* %t21 to i64
  %t23 = icmp eq i64 %t22, 0
  %t24 = select i1 %t23, i64 1, i64 %t22
  %t25 = call i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to i8**
  %t27 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t28 = ptrtoint { i8**, i64 }* %t27 to i64
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to { i8**, i64 }*
  %t31 = getelementptr { i8**, i64 }, { i8**, i64 }* %t30, i32 0, i32 0
  store i8** %t26, i8*** %t31
  %t32 = getelementptr { i8**, i64 }, { i8**, i64 }* %t30, i32 0, i32 1
  store i64 0, i64* %t32
  store { i8**, i64 }* %t30, { i8**, i64 }** %l2
  %t33 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t34 = extractvalue { %NativeImport*, i64 } %t33, 1
  %t35 = icmp sgt i64 %t34, 0
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t35, label %then0, label %merge1
then0:
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %t40 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t39)
  store %PythonBuilder %t40, %PythonBuilder* %l0
  %t41 = load %PythonBuilder, %PythonBuilder* %l0
  %t42 = call %PythonImportEmission @emit_python_imports(%PythonBuilder %t41, { %NativeImport*, i64 }* %imports)
  store %PythonImportEmission %t42, %PythonImportEmission* %l3
  %t43 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t44 = extractvalue %PythonImportEmission %t43, 0
  store %PythonBuilder %t44, %PythonBuilder* %l0
  %t45 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t46 = extractvalue %PythonImportEmission %t45, 1
  store { i8**, i64 }* %t46, { i8**, i64 }** %l2
  %t47 = load %PythonBuilder, %PythonBuilder* %l0
  %t48 = load %PythonBuilder, %PythonBuilder* %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge1
merge1:
  %t50 = phi %PythonBuilder [ %t47, %then0 ], [ %t36, %block.entry ]
  %t51 = phi %PythonBuilder [ %t48, %then0 ], [ %t36, %block.entry ]
  %t52 = phi { i8**, i64 }* [ %t49, %then0 ], [ %t38, %block.entry ]
  store %PythonBuilder %t50, %PythonBuilder* %l0
  store %PythonBuilder %t51, %PythonBuilder* %l0
  store { i8**, i64 }* %t52, { i8**, i64 }** %l2
  %t53 = load %PythonBuilder, %PythonBuilder* %l0
  %t54 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t53)
  store %PythonBuilder %t54, %PythonBuilder* %l0
  %t55 = load %PythonBuilder, %PythonBuilder* %l0
  %t56 = call %PythonBuilder @emit_runtime_aliases(%PythonBuilder %t55)
  store %PythonBuilder %t56, %PythonBuilder* %l0
  %t57 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t58 = extractvalue { %NativeBinding*, i64 } %t57, 1
  %t59 = icmp sgt i64 %t58, 0
  %t60 = load %PythonBuilder, %PythonBuilder* %l0
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t59, label %then2, label %merge3
then2:
  %t63 = load %PythonBuilder, %PythonBuilder* %l0
  %t64 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t63)
  store %PythonBuilder %t64, %PythonBuilder* %l0
  %t65 = load %PythonBuilder, %PythonBuilder* %l0
  %t66 = call %PythonBuilder @emit_top_level_bindings(%PythonBuilder %t65, { %NativeBinding*, i64 }* %bindings)
  store %PythonBuilder %t66, %PythonBuilder* %l0
  %t67 = load %PythonBuilder, %PythonBuilder* %l0
  %t68 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge3
merge3:
  %t69 = phi %PythonBuilder [ %t67, %then2 ], [ %t60, %merge1 ]
  %t70 = phi %PythonBuilder [ %t68, %then2 ], [ %t60, %merge1 ]
  store %PythonBuilder %t69, %PythonBuilder* %l0
  store %PythonBuilder %t70, %PythonBuilder* %l0
  %t71 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t72 = extractvalue { %NativeEnum*, i64 } %t71, 1
  %t73 = icmp sgt i64 %t72, 0
  %t74 = load %PythonBuilder, %PythonBuilder* %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t73, label %then4, label %merge5
then4:
  %t77 = load %PythonBuilder, %PythonBuilder* %l0
  %t78 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t77)
  store %PythonBuilder %t78, %PythonBuilder* %l0
  %t79 = load %PythonBuilder, %PythonBuilder* %l0
  %t80 = call %PythonBuilder @emit_enum_definitions(%PythonBuilder %t79, { %NativeEnum*, i64 }* %enums)
  store %PythonBuilder %t80, %PythonBuilder* %l0
  %t81 = load %PythonBuilder, %PythonBuilder* %l0
  %t82 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge5
merge5:
  %t83 = phi %PythonBuilder [ %t81, %then4 ], [ %t74, %merge3 ]
  %t84 = phi %PythonBuilder [ %t82, %then4 ], [ %t74, %merge3 ]
  store %PythonBuilder %t83, %PythonBuilder* %l0
  store %PythonBuilder %t84, %PythonBuilder* %l0
  %t85 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t86 = extractvalue { %NativeStruct*, i64 } %t85, 1
  %t87 = icmp sgt i64 %t86, 0
  %t88 = load %PythonBuilder, %PythonBuilder* %l0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t87, label %then6, label %merge7
then6:
  %t91 = load %PythonBuilder, %PythonBuilder* %l0
  %t92 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t91)
  store %PythonBuilder %t92, %PythonBuilder* %l0
  %t93 = load %PythonBuilder, %PythonBuilder* %l0
  %t94 = call %PythonStructEmission @emit_struct_definitions(%PythonBuilder %t93, { %NativeStruct*, i64 }* %structs)
  store %PythonStructEmission %t94, %PythonStructEmission* %l4
  %t95 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t96 = extractvalue %PythonStructEmission %t95, 0
  store %PythonBuilder %t96, %PythonBuilder* %l0
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t98 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t99 = extractvalue %PythonStructEmission %t98, 1
  %t100 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t97, { i8**, i64 }* %t99)
  store { i8**, i64 }* %t100, { i8**, i64 }** %l1
  %t101 = load %PythonBuilder, %PythonBuilder* %l0
  %t102 = load %PythonBuilder, %PythonBuilder* %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge7
merge7:
  %t104 = phi %PythonBuilder [ %t101, %then6 ], [ %t88, %merge5 ]
  %t105 = phi %PythonBuilder [ %t102, %then6 ], [ %t88, %merge5 ]
  %t106 = phi { i8**, i64 }* [ %t103, %then6 ], [ %t89, %merge5 ]
  store %PythonBuilder %t104, %PythonBuilder* %l0
  store %PythonBuilder %t105, %PythonBuilder* %l0
  store { i8**, i64 }* %t106, { i8**, i64 }** %l1
  %t107 = load %PythonBuilder, %PythonBuilder* %l0
  %t108 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t107)
  store %PythonBuilder %t108, %PythonBuilder* %l0
  %t109 = sitofp i64 0 to double
  store double %t109, double* %l5
  %t110 = load %PythonBuilder, %PythonBuilder* %l0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t113 = load double, double* %l5
  br label %loop.header8
loop.header8:
  %t162 = phi %PythonBuilder [ %t110, %merge7 ], [ %t159, %loop.latch10 ]
  %t163 = phi { i8**, i64 }* [ %t111, %merge7 ], [ %t160, %loop.latch10 ]
  %t164 = phi double [ %t113, %merge7 ], [ %t161, %loop.latch10 ]
  store %PythonBuilder %t162, %PythonBuilder* %l0
  store { i8**, i64 }* %t163, { i8**, i64 }** %l1
  store double %t164, double* %l5
  br label %loop.body9
loop.body9:
  %t114 = load double, double* %l5
  %t115 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t116 = extractvalue { %NativeFunction*, i64 } %t115, 1
  %t117 = sitofp i64 %t116 to double
  %t118 = fcmp oge double %t114, %t117
  %t119 = load %PythonBuilder, %PythonBuilder* %l0
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t122 = load double, double* %l5
  br i1 %t118, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t123 = load %PythonBuilder, %PythonBuilder* %l0
  %t124 = load double, double* %l5
  %t125 = call double @llvm.round.f64(double %t124)
  %t126 = fptosi double %t125 to i64
  %t127 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t128 = extractvalue { %NativeFunction*, i64 } %t127, 0
  %t129 = extractvalue { %NativeFunction*, i64 } %t127, 1
  %t130 = icmp uge i64 %t126, %t129
  ; bounds check: %t130 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t126, i64 %t129)
  %t131 = getelementptr %NativeFunction, %NativeFunction* %t128, i64 %t126
  %t132 = load %NativeFunction, %NativeFunction* %t131
  %t133 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t123, %NativeFunction %t132)
  store %PythonFunctionEmission %t133, %PythonFunctionEmission* %l6
  %t134 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t135 = extractvalue %PythonFunctionEmission %t134, 0
  store %PythonBuilder %t135, %PythonBuilder* %l0
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t137 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t138 = extractvalue %PythonFunctionEmission %t137, 1
  %t139 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t136, { i8**, i64 }* %t138)
  store { i8**, i64 }* %t139, { i8**, i64 }** %l1
  %t140 = load double, double* %l5
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  %t143 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t144 = extractvalue { %NativeFunction*, i64 } %t143, 1
  %t145 = sitofp i64 %t144 to double
  %t146 = fcmp olt double %t142, %t145
  %t147 = load %PythonBuilder, %PythonBuilder* %l0
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t150 = load double, double* %l5
  %t151 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  br i1 %t146, label %then14, label %merge15
then14:
  %t152 = load %PythonBuilder, %PythonBuilder* %l0
  %t153 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t152)
  store %PythonBuilder %t153, %PythonBuilder* %l0
  %t154 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
merge15:
  %t155 = phi %PythonBuilder [ %t154, %then14 ], [ %t147, %merge13 ]
  store %PythonBuilder %t155, %PythonBuilder* %l0
  %t156 = load double, double* %l5
  %t157 = sitofp i64 1 to double
  %t158 = fadd double %t156, %t157
  store double %t158, double* %l5
  br label %loop.latch10
loop.latch10:
  %t159 = load %PythonBuilder, %PythonBuilder* %l0
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t161 = load double, double* %l5
  br label %loop.header8
afterloop11:
  %t165 = load %PythonBuilder, %PythonBuilder* %l0
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t167 = load double, double* %l5
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t169 = load { i8**, i64 }, { i8**, i64 }* %t168
  %t170 = extractvalue { i8**, i64 } %t169, 1
  %t171 = icmp sgt i64 %t170, 0
  %t172 = load %PythonBuilder, %PythonBuilder* %l0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t175 = load double, double* %l5
  br i1 %t171, label %then16, label %merge17
then16:
  %t176 = load %PythonBuilder, %PythonBuilder* %l0
  %t177 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t176)
  store %PythonBuilder %t177, %PythonBuilder* %l0
  %t178 = load %PythonBuilder, %PythonBuilder* %l0
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t180 = call %PythonBuilder @emit_export_list(%PythonBuilder %t178, { i8**, i64 }* %t179)
  store %PythonBuilder %t180, %PythonBuilder* %l0
  %t181 = load %PythonBuilder, %PythonBuilder* %l0
  %t182 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge17
merge17:
  %t183 = phi %PythonBuilder [ %t181, %then16 ], [ %t172, %afterloop11 ]
  %t184 = phi %PythonBuilder [ %t182, %then16 ], [ %t172, %afterloop11 ]
  store %PythonBuilder %t183, %PythonBuilder* %l0
  store %PythonBuilder %t184, %PythonBuilder* %l0
  %t185 = load %PythonBuilder, %PythonBuilder* %l0
  %t186 = insertvalue %PythonModuleEmission undef, %PythonBuilder %t185, 0
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t188 = insertvalue %PythonModuleEmission %t186, { i8**, i64 }* %t187, 1
  ret %PythonModuleEmission %t188
}

define %PythonBuilder @emit_runtime_aliases(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca %PythonBuilder
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = load %PythonBuilder, %PythonBuilder* %l0
  %t1 = call i8* @malloc(i64 24)
  %t2 = bitcast i8* %t1 to [24 x i8]*
  store [24 x i8] c"print = runtime.console\00", [24 x i8]* %t2
  %t3 = call %PythonBuilder @builder_emit(%PythonBuilder %t0, i8* %t1)
  store %PythonBuilder %t3, %PythonBuilder* %l0
  %t4 = load %PythonBuilder, %PythonBuilder* %l0
  %t5 = call i8* @malloc(i64 22)
  %t6 = bitcast i8* %t5 to [22 x i8]*
  store [22 x i8] c"sleep = runtime.sleep\00", [22 x i8]* %t6
  %t7 = call %PythonBuilder @builder_emit(%PythonBuilder %t4, i8* %t5)
  store %PythonBuilder %t7, %PythonBuilder* %l0
  %t8 = load %PythonBuilder, %PythonBuilder* %l0
  %t9 = call i8* @malloc(i64 26)
  %t10 = bitcast i8* %t9 to [26 x i8]*
  store [26 x i8] c"channel = runtime.channel\00", [26 x i8]* %t10
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %t8, i8* %t9)
  store %PythonBuilder %t11, %PythonBuilder* %l0
  %t12 = load %PythonBuilder, %PythonBuilder* %l0
  %t13 = call i8* @malloc(i64 28)
  %t14 = bitcast i8* %t13 to [28 x i8]*
  store [28 x i8] c"parallel = runtime.parallel\00", [28 x i8]* %t14
  %t15 = call %PythonBuilder @builder_emit(%PythonBuilder %t12, i8* %t13)
  store %PythonBuilder %t15, %PythonBuilder* %l0
  %t16 = load %PythonBuilder, %PythonBuilder* %l0
  %t17 = call i8* @malloc(i64 22)
  %t18 = bitcast i8* %t17 to [22 x i8]*
  store [22 x i8] c"spawn = runtime.spawn\00", [22 x i8]* %t18
  %t19 = call %PythonBuilder @builder_emit(%PythonBuilder %t16, i8* %t17)
  store %PythonBuilder %t19, %PythonBuilder* %l0
  %t20 = load %PythonBuilder, %PythonBuilder* %l0
  %t21 = call i8* @malloc(i64 16)
  %t22 = bitcast i8* %t21 to [16 x i8]*
  store [16 x i8] c"fs = runtime.fs\00", [16 x i8]* %t22
  %t23 = call %PythonBuilder @builder_emit(%PythonBuilder %t20, i8* %t21)
  store %PythonBuilder %t23, %PythonBuilder* %l0
  %t24 = load %PythonBuilder, %PythonBuilder* %l0
  %t25 = call i8* @malloc(i64 22)
  %t26 = bitcast i8* %t25 to [22 x i8]*
  store [22 x i8] c"serve = runtime.serve\00", [22 x i8]* %t26
  %t27 = call %PythonBuilder @builder_emit(%PythonBuilder %t24, i8* %t25)
  store %PythonBuilder %t27, %PythonBuilder* %l0
  %t28 = load %PythonBuilder, %PythonBuilder* %l0
  %t29 = call i8* @malloc(i64 20)
  %t30 = bitcast i8* %t29 to [20 x i8]*
  store [20 x i8] c"http = runtime.http\00", [20 x i8]* %t30
  %t31 = call %PythonBuilder @builder_emit(%PythonBuilder %t28, i8* %t29)
  store %PythonBuilder %t31, %PythonBuilder* %l0
  %t32 = load %PythonBuilder, %PythonBuilder* %l0
  %t33 = call i8* @malloc(i64 30)
  %t34 = bitcast i8* %t33 to [30 x i8]*
  store [30 x i8] c"websocket = runtime.websocket\00", [30 x i8]* %t34
  %t35 = call %PythonBuilder @builder_emit(%PythonBuilder %t32, i8* %t33)
  store %PythonBuilder %t35, %PythonBuilder* %l0
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %t37 = call i8* @malloc(i64 36)
  %t38 = bitcast i8* %t37 to [36 x i8]*
  store [36 x i8] c"logExecution = runtime.logExecution\00", [36 x i8]* %t38
  %t39 = call %PythonBuilder @builder_emit(%PythonBuilder %t36, i8* %t37)
  store %PythonBuilder %t39, %PythonBuilder* %l0
  %t40 = load %PythonBuilder, %PythonBuilder* %l0
  %t41 = call i8* @malloc(i64 30)
  %t42 = bitcast i8* %t41 to [30 x i8]*
  store [30 x i8] c"array_map = runtime.array_map\00", [30 x i8]* %t42
  %t43 = call %PythonBuilder @builder_emit(%PythonBuilder %t40, i8* %t41)
  store %PythonBuilder %t43, %PythonBuilder* %l0
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = call i8* @malloc(i64 36)
  %t46 = bitcast i8* %t45 to [36 x i8]*
  store [36 x i8] c"array_filter = runtime.array_filter\00", [36 x i8]* %t46
  %t47 = call %PythonBuilder @builder_emit(%PythonBuilder %t44, i8* %t45)
  store %PythonBuilder %t47, %PythonBuilder* %l0
  %t48 = load %PythonBuilder, %PythonBuilder* %l0
  %t49 = call i8* @malloc(i64 36)
  %t50 = bitcast i8* %t49 to [36 x i8]*
  store [36 x i8] c"array_reduce = runtime.array_reduce\00", [36 x i8]* %t50
  %t51 = call %PythonBuilder @builder_emit(%PythonBuilder %t48, i8* %t49)
  store %PythonBuilder %t51, %PythonBuilder* %l0
  %t52 = load %PythonBuilder, %PythonBuilder* %l0
  %t53 = call i8* @malloc(i64 30)
  %t54 = bitcast i8* %t53 to [30 x i8]*
  store [30 x i8] c"globals()['t' + 'rue'] = True\00", [30 x i8]* %t54
  %t55 = call %PythonBuilder @builder_emit(%PythonBuilder %t52, i8* %t53)
  store %PythonBuilder %t55, %PythonBuilder* %l0
  %t56 = load %PythonBuilder, %PythonBuilder* %l0
  %t57 = call i8* @malloc(i64 32)
  %t58 = bitcast i8* %t57 to [32 x i8]*
  store [32 x i8] c"globals()['f' + 'alse'] = False\00", [32 x i8]* %t58
  %t59 = call %PythonBuilder @builder_emit(%PythonBuilder %t56, i8* %t57)
  store %PythonBuilder %t59, %PythonBuilder* %l0
  %t60 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t60
}

define %PythonBuilder @emit_top_level_bindings(%PythonBuilder %builder, { %NativeBinding*, i64 }* %bindings) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca double
  %l2 = alloca %NativeBinding
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %PythonBuilder, %PythonBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t55 = phi %PythonBuilder [ %t1, %block.entry ], [ %t53, %loop.latch2 ]
  %t56 = phi double [ %t2, %block.entry ], [ %t54, %loop.latch2 ]
  store %PythonBuilder %t55, %PythonBuilder* %l0
  store double %t56, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t5 = extractvalue { %NativeBinding*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %PythonBuilder, %PythonBuilder* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t14 = extractvalue { %NativeBinding*, i64 } %t13, 0
  %t15 = extractvalue { %NativeBinding*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %NativeBinding, %NativeBinding* %t14, i64 %t12
  %t18 = load %NativeBinding, %NativeBinding* %t17
  store %NativeBinding %t18, %NativeBinding* %l2
  %t19 = load %NativeBinding, %NativeBinding* %l2
  %t20 = extractvalue %NativeBinding %t19, 0
  %t21 = call i8* @sanitize_identifier(i8* %t20)
  store i8* %t21, i8** %l3
  %t22 = load i8*, i8** %l3
  %t23 = call i8* @malloc(i64 4)
  %t24 = bitcast i8* %t23 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t24
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t23)
  store i8* %t25, i8** %l4
  %t26 = load %NativeBinding, %NativeBinding* %l2
  %t27 = extractvalue %NativeBinding %t26, 3
  %t28 = icmp ne i8* %t27, null
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = load double, double* %l1
  %t31 = load %NativeBinding, %NativeBinding* %l2
  %t32 = load i8*, i8** %l3
  %t33 = load i8*, i8** %l4
  br i1 %t28, label %then6, label %else7
then6:
  %t34 = load %NativeBinding, %NativeBinding* %l2
  %t35 = extractvalue %NativeBinding %t34, 3
  store i8* %t35, i8** %l5
  %t36 = load i8*, i8** %l4
  %t37 = load i8*, i8** %l5
  %t38 = call i8* @lower_expression(i8* %t37)
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %t38)
  store i8* %t39, i8** %l4
  %t40 = load i8*, i8** %l4
  br label %merge8
else7:
  %t41 = load i8*, i8** %l4
  %t42 = call i8* @malloc(i64 5)
  %t43 = bitcast i8* %t42 to [5 x i8]*
  store [5 x i8] c"None\00", [5 x i8]* %t43
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t42)
  store i8* %t44, i8** %l4
  %t45 = load i8*, i8** %l4
  br label %merge8
merge8:
  %t46 = phi i8* [ %t40, %then6 ], [ %t45, %else7 ]
  store i8* %t46, i8** %l4
  %t47 = load %PythonBuilder, %PythonBuilder* %l0
  %t48 = load i8*, i8** %l4
  %t49 = call %PythonBuilder @builder_emit(%PythonBuilder %t47, i8* %t48)
  store %PythonBuilder %t49, %PythonBuilder* %l0
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l1
  br label %loop.latch2
loop.latch2:
  %t53 = load %PythonBuilder, %PythonBuilder* %l0
  %t54 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t57 = load %PythonBuilder, %PythonBuilder* %l0
  %t58 = load double, double* %l1
  %t59 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t59
}

define %PythonImportEmission @emit_python_imports(%PythonBuilder %builder, { %NativeImport*, i64 }* %imports) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %NativeImport
  %l4 = alloca i8*
  %l5 = alloca i8*
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l1
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l2
  %t13 = load %PythonBuilder, %PythonBuilder* %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t85 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t82, %loop.latch2 ]
  %t86 = phi double [ %t15, %block.entry ], [ %t83, %loop.latch2 ]
  %t87 = phi %PythonBuilder [ %t13, %block.entry ], [ %t84, %loop.latch2 ]
  store { i8**, i64 }* %t85, { i8**, i64 }** %l1
  store double %t86, double* %l2
  store %PythonBuilder %t87, %PythonBuilder* %l0
  br label %loop.body1
loop.body1:
  %t16 = load double, double* %l2
  %t17 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t18 = extractvalue { %NativeImport*, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t16, %t19
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load double, double* %l2
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t28 = extractvalue { %NativeImport*, i64 } %t27, 0
  %t29 = extractvalue { %NativeImport*, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
  %t31 = getelementptr %NativeImport, %NativeImport* %t28, i64 %t26
  %t32 = load %NativeImport, %NativeImport* %t31
  store %NativeImport %t32, %NativeImport* %l3
  %t33 = load %NativeImport, %NativeImport* %l3
  %t34 = extractvalue %NativeImport %t33, 0
  %t35 = call i8* @malloc(i64 7)
  %t36 = bitcast i8* %t35 to [7 x i8]*
  store [7 x i8] c"export\00", [7 x i8]* %t36
  %t37 = call i1 @strings_equal(i8* %t34, i8* %t35)
  %t38 = load %PythonBuilder, %PythonBuilder* %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load double, double* %l2
  %t41 = load %NativeImport, %NativeImport* %l3
  br i1 %t37, label %then6, label %merge7
then6:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load %NativeImport, %NativeImport* %l3
  %t44 = extractvalue %NativeImport %t43, 2
  %t45 = call { i8**, i64 }* @collect_export_names({ i8**, i64 }* %t42, { %NativeImportSpecifier*, i64 }* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l1
  %t46 = load %NativeImport, %NativeImport* %l3
  %t47 = extractvalue %NativeImport %t46, 1
  %t48 = call i8* @trim_text(i8* %t47)
  store i8* %t48, i8** %l4
  %t49 = load i8*, i8** %l4
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = icmp eq i64 %t50, 0
  %t52 = load %PythonBuilder, %PythonBuilder* %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load double, double* %l2
  %t55 = load %NativeImport, %NativeImport* %l3
  %t56 = load i8*, i8** %l4
  br i1 %t51, label %then8, label %merge9
then8:
  %t57 = load double, double* %l2
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l2
  br label %loop.latch2
merge9:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  br label %merge7
merge7:
  %t62 = phi { i8**, i64 }* [ %t60, %merge9 ], [ %t39, %merge5 ]
  %t63 = phi double [ %t61, %merge9 ], [ %t40, %merge5 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l1
  store double %t63, double* %l2
  %t64 = load %NativeImport, %NativeImport* %l3
  %t65 = call i8* @render_python_import(%NativeImport %t64)
  store i8* %t65, i8** %l5
  %t66 = load i8*, i8** %l5
  %t67 = call i64 @sailfin_runtime_string_length(i8* %t66)
  %t68 = icmp sgt i64 %t67, 0
  %t69 = load %PythonBuilder, %PythonBuilder* %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load double, double* %l2
  %t72 = load %NativeImport, %NativeImport* %l3
  %t73 = load i8*, i8** %l5
  br i1 %t68, label %then10, label %merge11
then10:
  %t74 = load %PythonBuilder, %PythonBuilder* %l0
  %t75 = load i8*, i8** %l5
  %t76 = call %PythonBuilder @builder_emit(%PythonBuilder %t74, i8* %t75)
  store %PythonBuilder %t76, %PythonBuilder* %l0
  %t77 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge11
merge11:
  %t78 = phi %PythonBuilder [ %t77, %then10 ], [ %t69, %merge7 ]
  store %PythonBuilder %t78, %PythonBuilder* %l0
  %t79 = load double, double* %l2
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l2
  br label %loop.latch2
loop.latch2:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = load double, double* %l2
  %t84 = load %PythonBuilder, %PythonBuilder* %l0
  br label %loop.header0
afterloop3:
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t89 = load double, double* %l2
  %t90 = load %PythonBuilder, %PythonBuilder* %l0
  %t91 = load %PythonBuilder, %PythonBuilder* %l0
  %t92 = insertvalue %PythonImportEmission undef, %PythonBuilder %t91, 0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = insertvalue %PythonImportEmission %t92, { i8**, i64 }* %t93, 1
  ret %PythonImportEmission %t94
}

define %PythonBuilder @emit_enum_definitions(%PythonBuilder %builder, { %NativeEnum*, i64 }* %enums) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca double
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load %PythonBuilder, %PythonBuilder* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t39 = phi %PythonBuilder [ %t1, %block.entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t2, %block.entry ], [ %t38, %loop.latch2 ]
  store %PythonBuilder %t39, %PythonBuilder* %l0
  store double %t40, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t5 = extractvalue { %NativeEnum*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load %PythonBuilder, %PythonBuilder* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load %PythonBuilder, %PythonBuilder* %l0
  %t11 = load double, double* %l1
  %t12 = call double @llvm.round.f64(double %t11)
  %t13 = fptosi double %t12 to i64
  %t14 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t15 = extractvalue { %NativeEnum*, i64 } %t14, 0
  %t16 = extractvalue { %NativeEnum*, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t13, i64 %t16)
  %t18 = getelementptr %NativeEnum, %NativeEnum* %t15, i64 %t13
  %t19 = load %NativeEnum, %NativeEnum* %t18
  %t20 = call %PythonBuilder @emit_single_enum(%PythonBuilder %t10, %NativeEnum %t19)
  store %PythonBuilder %t20, %PythonBuilder* %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  %t24 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t25 = extractvalue { %NativeEnum*, i64 } %t24, 1
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp olt double %t23, %t26
  %t28 = load %PythonBuilder, %PythonBuilder* %l0
  %t29 = load double, double* %l1
  br i1 %t27, label %then6, label %merge7
then6:
  %t30 = load %PythonBuilder, %PythonBuilder* %l0
  %t31 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t30)
  store %PythonBuilder %t31, %PythonBuilder* %l0
  %t32 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t33 = phi %PythonBuilder [ %t32, %then6 ], [ %t28, %merge5 ]
  store %PythonBuilder %t33, %PythonBuilder* %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load %PythonBuilder, %PythonBuilder* %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load %PythonBuilder, %PythonBuilder* %l0
  %t42 = load double, double* %l1
  %t43 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t43
}

define %PythonBuilder @emit_single_enum(%PythonBuilder %builder, %NativeEnum %definition) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %PythonBuilder
  %l2 = alloca double
  %l3 = alloca %NativeEnumVariant
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = extractvalue %NativeEnum %definition, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @malloc(i64 23)
  %t4 = bitcast i8* %t3 to [23 x i8]*
  store [23 x i8] c" = runtime.enum_type('\00", [23 x i8]* %t4
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t3)
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t6)
  %t8 = call i8* @malloc(i64 3)
  %t9 = bitcast i8* %t8 to [3 x i8]*
  store [3 x i8] c"')\00", [3 x i8]* %t9
  %t10 = call i8* @sailfin_runtime_string_concat(i8* %t7, i8* %t8)
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t10)
  store %PythonBuilder %t11, %PythonBuilder* %l1
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l2
  %t13 = load i8*, i8** %l0
  %t14 = load %PythonBuilder, %PythonBuilder* %l1
  %t15 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t67 = phi %PythonBuilder [ %t14, %block.entry ], [ %t65, %loop.latch2 ]
  %t68 = phi double [ %t15, %block.entry ], [ %t66, %loop.latch2 ]
  store %PythonBuilder %t67, %PythonBuilder* %l1
  store double %t68, double* %l2
  br label %loop.body1
loop.body1:
  %t16 = load double, double* %l2
  %t17 = extractvalue %NativeEnum %definition, 1
  %t18 = load { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t17
  %t19 = extractvalue { %NativeEnumVariant*, i64 } %t18, 1
  %t20 = sitofp i64 %t19 to double
  %t21 = fcmp oge double %t16, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load %PythonBuilder, %PythonBuilder* %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t25 = extractvalue %NativeEnum %definition, 1
  %t26 = load double, double* %l2
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = load { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t25
  %t30 = extractvalue { %NativeEnumVariant*, i64 } %t29, 0
  %t31 = extractvalue { %NativeEnumVariant*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t30, i64 %t28
  %t34 = load %NativeEnumVariant, %NativeEnumVariant* %t33
  store %NativeEnumVariant %t34, %NativeEnumVariant* %l3
  %t35 = load %NativeEnumVariant, %NativeEnumVariant* %l3
  %t36 = extractvalue %NativeEnumVariant %t35, 0
  %t37 = call i8* @sanitize_identifier(i8* %t36)
  store i8* %t37, i8** %l4
  %t38 = load i8*, i8** %l0
  %t39 = call i8* @malloc(i64 32)
  %t40 = bitcast i8* %t39 to [32 x i8]*
  store [32 x i8] c" = runtime.enum_define_variant(\00", [32 x i8]* %t40
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t39)
  %t42 = load i8*, i8** %l0
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t42)
  %t44 = call i8* @malloc(i64 4)
  %t45 = bitcast i8* %t44 to [4 x i8]*
  store [4 x i8] c", '\00", [4 x i8]* %t45
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t44)
  %t47 = load i8*, i8** %l4
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t47)
  %t49 = call i8* @malloc(i64 5)
  %t50 = bitcast i8* %t49 to [5 x i8]*
  store [5 x i8] c"', [\00", [5 x i8]* %t50
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t49)
  %t52 = load %NativeEnumVariant, %NativeEnumVariant* %l3
  %t53 = extractvalue %NativeEnumVariant %t52, 1
  %t54 = call i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %t53)
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %t54)
  %t56 = call i8* @malloc(i64 3)
  %t57 = bitcast i8* %t56 to [3 x i8]*
  store [3 x i8] c"])\00", [3 x i8]* %t57
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t56)
  store i8* %t58, i8** %l5
  %t59 = load %PythonBuilder, %PythonBuilder* %l1
  %t60 = load i8*, i8** %l5
  %t61 = call %PythonBuilder @builder_emit(%PythonBuilder %t59, i8* %t60)
  store %PythonBuilder %t61, %PythonBuilder* %l1
  %t62 = load double, double* %l2
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l2
  br label %loop.latch2
loop.latch2:
  %t65 = load %PythonBuilder, %PythonBuilder* %l1
  %t66 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t69 = load %PythonBuilder, %PythonBuilder* %l1
  %t70 = load double, double* %l2
  %t71 = load %PythonBuilder, %PythonBuilder* %l1
  ret %PythonBuilder %t71
}

define i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %fields) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t1 = extractvalue { %NativeEnumVariantField*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t6 = ptrtoint [0 x i8*]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to i8**
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t12 = ptrtoint { i8**, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { i8**, i64 }*
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 0
  store i8** %t10, i8*** %t15
  %t16 = getelementptr { i8**, i64 }, { i8**, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  store { i8**, i64 }* %t14, { i8**, i64 }** %l0
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l1
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t53 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t51, %loop.latch4 ]
  %t54 = phi double [ %t19, %merge1 ], [ %t52, %loop.latch4 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  store double %t54, double* %l1
  br label %loop.body3
loop.body3:
  %t20 = load double, double* %l1
  %t21 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t22 = extractvalue { %NativeEnumVariantField*, i64 } %t21, 1
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t20, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t32 = extractvalue { %NativeEnumVariantField*, i64 } %t31, 0
  %t33 = extractvalue { %NativeEnumVariantField*, i64 } %t31, 1
  %t34 = icmp uge i64 %t30, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t30, i64 %t33)
  %t35 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t32, i64 %t30
  %t36 = load %NativeEnumVariantField, %NativeEnumVariantField* %t35
  %t37 = extractvalue %NativeEnumVariantField %t36, 0
  %t38 = call i8* @sanitize_identifier(i8* %t37)
  %t39 = add i64 0, 2
  %t40 = call i8* @malloc(i64 %t39)
  store i8 39, i8* %t40
  %t41 = getelementptr i8, i8* %t40, i64 1
  store i8 0, i8* %t41
  call void @sailfin_runtime_mark_persistent(i8* %t40)
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %t38)
  %t43 = add i64 0, 2
  %t44 = call i8* @malloc(i64 %t43)
  store i8 39, i8* %t44
  %t45 = getelementptr i8, i8* %t44, i64 1
  store i8 0, i8* %t45
  call void @sailfin_runtime_mark_persistent(i8* %t44)
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t44)
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t27, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch4
loop.latch4:
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load double, double* %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = call i8* @malloc(i64 3)
  %t59 = bitcast i8* %t58 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t59
  %t60 = call i8* @join_with_separator({ i8**, i64 }* %t57, i8* %t58)
  call void @sailfin_runtime_mark_persistent(i8* %t60)
  ret i8* %t60
}

define i8* @render_python_import(%NativeImport %entry) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = extractvalue %NativeImport %entry, 1
  %t1 = call i8* @normalize_import_module(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = call i8* @malloc(i64 1)
  %t7 = bitcast i8* %t6 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t7
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  ret i8* %t6
merge1:
  %t8 = extractvalue %NativeImport %entry, 2
  %t9 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t8
  %t10 = extractvalue { %NativeImportSpecifier*, i64 } %t9, 1
  %t11 = icmp eq i64 %t10, 0
  %t12 = load i8*, i8** %l0
  br i1 %t11, label %then2, label %merge3
then2:
  %t13 = call i8* @malloc(i64 8)
  %t14 = bitcast i8* %t13 to [8 x i8]*
  store [8 x i8] c"import \00", [8 x i8]* %t14
  %t15 = load i8*, i8** %l0
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t15)
  call void @sailfin_runtime_mark_persistent(i8* %t16)
  ret i8* %t16
merge3:
  %t17 = extractvalue %NativeImport %entry, 2
  %t18 = call i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %t17)
  store i8* %t18, i8** %l1
  %t19 = call i8* @malloc(i64 6)
  %t20 = bitcast i8* %t19 to [6 x i8]*
  store [6 x i8] c"from \00", [6 x i8]* %t20
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t21)
  %t23 = call i8* @malloc(i64 9)
  %t24 = bitcast i8* %t23 to [9 x i8]*
  store [9 x i8] c" import \00", [9 x i8]* %t24
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t23)
  %t26 = load i8*, i8** %l1
  %t27 = call i8* @sailfin_runtime_string_concat(i8* %t25, i8* %t26)
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  ret i8* %t27
}

define i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t39 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t14, %block.entry ], [ %t38, %loop.latch2 ]
  store { i8**, i64 }* %t39, { i8**, i64 }** %l0
  store double %t40, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t17 = extractvalue { %NativeImportSpecifier*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t27 = extractvalue { %NativeImportSpecifier*, i64 } %t26, 0
  %t28 = extractvalue { %NativeImportSpecifier*, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t27, i64 %t25
  %t31 = load %NativeImportSpecifier, %NativeImportSpecifier* %t30
  %t32 = call i8* @render_python_specifier(%NativeImportSpecifier %t31)
  %t33 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t22, i8* %t32)
  store { i8**, i64 }* %t33, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = call i8* @malloc(i64 3)
  %t45 = bitcast i8* %t44 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t45
  %t46 = call i8* @join_with_separator({ i8**, i64 }* %t43, i8* %t44)
  call void @sailfin_runtime_mark_persistent(i8* %t46)
  ret i8* %t46
}

define i8* @render_python_specifier(%NativeImportSpecifier %specifier) {
block.entry:
  %l0 = alloca i8*
  %t0 = extractvalue %NativeImportSpecifier %specifier, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %t3 = extractvalue %NativeImportSpecifier %specifier, 1
  %t4 = icmp eq i8* %t3, null
  br label %logical_or_entry_2

logical_or_entry_2:
  br i1 %t4, label %logical_or_merge_2, label %logical_or_right_2

logical_or_right_2:
  %t5 = extractvalue %NativeImportSpecifier %specifier, 1
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = icmp eq i64 %t6, 0
  br label %logical_or_right_end_2

logical_or_right_end_2:
  br label %logical_or_merge_2

logical_or_merge_2:
  %t8 = phi i1 [ true, %logical_or_entry_2 ], [ %t7, %logical_or_right_end_2 ]
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  %t10 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t10)
  ret i8* %t10
merge1:
  %t11 = load i8*, i8** %l0
  %t12 = call i8* @malloc(i64 5)
  %t13 = bitcast i8* %t12 to [5 x i8]*
  store [5 x i8] c" as \00", [5 x i8]* %t13
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t12)
  %t15 = extractvalue %NativeImportSpecifier %specifier, 1
  %t16 = call i8* @sanitize_identifier(i8* %t15)
  %t17 = call i8* @sailfin_runtime_string_concat(i8* %t14, i8* %t16)
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  ret i8* %t17
}

define i8* @normalize_import_module(i8* %path) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %t0 = call i8* @trim_text(i8* %path)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
merge1:
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @malloc(i64 9)
  %t8 = bitcast i8* %t7 to [9 x i8]*
  store [9 x i8] c"runtime/\00", [9 x i8]* %t8
  %t9 = call i1 @starts_with(i8* %t6, i8* %t7)
  %t10 = load i8*, i8** %l0
  br i1 %t9, label %then2, label %merge3
then2:
  %t11 = load i8*, i8** %l0
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 47, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  %t15 = add i64 0, 2
  %t16 = call i8* @malloc(i64 %t15)
  store i8 46, i8* %t16
  %t17 = getelementptr i8, i8* %t16, i64 1
  store i8 0, i8* %t17
  call void @sailfin_runtime_mark_persistent(i8* %t16)
  %t18 = call i8* @replace_all(i8* %t11, i8* %t13, i8* %t16)
  store i8* %t18, i8** %l1
  %t19 = call i8* @malloc(i64 16)
  %t20 = bitcast i8* %t19 to [16 x i8]*
  store [16 x i8] c"compiler.build.\00", [16 x i8]* %t20
  %t21 = load i8*, i8** %l1
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t21)
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  ret i8* %t22
merge3:
  %t23 = load i8*, i8** %l0
  %t24 = call i8* @malloc(i64 3)
  %t25 = bitcast i8* %t24 to [3 x i8]*
  store [3 x i8] c"./\00", [3 x i8]* %t25
  %t26 = call i1 @starts_with(i8* %t23, i8* %t24)
  %t27 = load i8*, i8** %l0
  br i1 %t26, label %then4, label %merge5
then4:
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l0
  %t30 = call i64 @sailfin_runtime_string_length(i8* %t29)
  %t31 = call i8* @sailfin_runtime_substring(i8* %t28, i64 2, i64 %t30)
  store i8* %t31, i8** %l2
  %t32 = load i8*, i8** %l2
  %t33 = add i64 0, 2
  %t34 = call i8* @malloc(i64 %t33)
  store i8 47, i8* %t34
  %t35 = getelementptr i8, i8* %t34, i64 1
  store i8 0, i8* %t35
  call void @sailfin_runtime_mark_persistent(i8* %t34)
  %t36 = add i64 0, 2
  %t37 = call i8* @malloc(i64 %t36)
  store i8 46, i8* %t37
  %t38 = getelementptr i8, i8* %t37, i64 1
  store i8 0, i8* %t38
  call void @sailfin_runtime_mark_persistent(i8* %t37)
  %t39 = call i8* @replace_all(i8* %t32, i8* %t34, i8* %t37)
  store i8* %t39, i8** %l2
  %t40 = call i8* @malloc(i64 16)
  %t41 = bitcast i8* %t40 to [16 x i8]*
  store [16 x i8] c"compiler.build.\00", [16 x i8]* %t41
  %t42 = load i8*, i8** %l2
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %t42)
  call void @sailfin_runtime_mark_persistent(i8* %t43)
  ret i8* %t43
merge5:
  %t44 = load i8*, i8** %l0
  %t45 = add i64 0, 2
  %t46 = call i8* @malloc(i64 %t45)
  store i8 47, i8* %t46
  %t47 = getelementptr i8, i8* %t46, i64 1
  store i8 0, i8* %t47
  call void @sailfin_runtime_mark_persistent(i8* %t46)
  %t48 = add i64 0, 2
  %t49 = call i8* @malloc(i64 %t48)
  store i8 46, i8* %t49
  %t50 = getelementptr i8, i8* %t49, i64 1
  store i8 0, i8* %t50
  call void @sailfin_runtime_mark_persistent(i8* %t49)
  %t51 = call i8* @replace_all(i8* %t44, i8* %t46, i8* %t49)
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  ret i8* %t51
}

define %PythonStructEmission @emit_struct_definitions(%PythonBuilder %builder, { %NativeStruct*, i64 }* %structs) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %PythonStructEmission
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l1
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l2
  %t13 = load %PythonBuilder, %PythonBuilder* %l0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t15 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t62 = phi %PythonBuilder [ %t13, %block.entry ], [ %t59, %loop.latch2 ]
  %t63 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t60, %loop.latch2 ]
  %t64 = phi double [ %t15, %block.entry ], [ %t61, %loop.latch2 ]
  store %PythonBuilder %t62, %PythonBuilder* %l0
  store { i8**, i64 }* %t63, { i8**, i64 }** %l1
  store double %t64, double* %l2
  br label %loop.body1
loop.body1:
  %t16 = load double, double* %l2
  %t17 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t18 = extractvalue { %NativeStruct*, i64 } %t17, 1
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t16, %t19
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load %PythonBuilder, %PythonBuilder* %l0
  %t25 = load double, double* %l2
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t29 = extractvalue { %NativeStruct*, i64 } %t28, 0
  %t30 = extractvalue { %NativeStruct*, i64 } %t28, 1
  %t31 = icmp uge i64 %t27, %t30
  ; bounds check: %t31 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t27, i64 %t30)
  %t32 = getelementptr %NativeStruct, %NativeStruct* %t29, i64 %t27
  %t33 = load %NativeStruct, %NativeStruct* %t32
  %t34 = call %PythonStructEmission @emit_single_struct(%PythonBuilder %t24, %NativeStruct %t33)
  store %PythonStructEmission %t34, %PythonStructEmission* %l3
  %t35 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t36 = extractvalue %PythonStructEmission %t35, 0
  store %PythonBuilder %t36, %PythonBuilder* %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load %PythonStructEmission, %PythonStructEmission* %l3
  %t39 = extractvalue %PythonStructEmission %t38, 1
  %t40 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t37, { i8**, i64 }* %t39)
  store { i8**, i64 }* %t40, { i8**, i64 }** %l1
  %t41 = load double, double* %l2
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  %t44 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t45 = extractvalue { %NativeStruct*, i64 } %t44, 1
  %t46 = sitofp i64 %t45 to double
  %t47 = fcmp olt double %t43, %t46
  %t48 = load %PythonBuilder, %PythonBuilder* %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load double, double* %l2
  %t51 = load %PythonStructEmission, %PythonStructEmission* %l3
  br i1 %t47, label %then6, label %merge7
then6:
  %t52 = load %PythonBuilder, %PythonBuilder* %l0
  %t53 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t52)
  store %PythonBuilder %t53, %PythonBuilder* %l0
  %t54 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge7
merge7:
  %t55 = phi %PythonBuilder [ %t54, %then6 ], [ %t48, %merge5 ]
  store %PythonBuilder %t55, %PythonBuilder* %l0
  %t56 = load double, double* %l2
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l2
  br label %loop.latch2
loop.latch2:
  %t59 = load %PythonBuilder, %PythonBuilder* %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t65 = load %PythonBuilder, %PythonBuilder* %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load double, double* %l2
  %t68 = load %PythonBuilder, %PythonBuilder* %l0
  %t69 = insertvalue %PythonStructEmission undef, %PythonBuilder %t68, 0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = insertvalue %PythonStructEmission %t69, { i8**, i64 }* %t70, 1
  ret %PythonStructEmission %t71
}

define %PythonBuilder @emit_export_list(%PythonBuilder %builder, { i8**, i64 }* %exports) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i1
  %l4 = alloca double
  %l5 = alloca { i8**, i64 }*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t92 = phi { i8**, i64 }* [ %t13, %block.entry ], [ %t90, %loop.latch2 ]
  %t93 = phi double [ %t14, %block.entry ], [ %t91, %loop.latch2 ]
  store { i8**, i64 }* %t92, { i8**, i64 }** %l0
  store double %t93, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t17 = extractvalue { i8**, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %exports
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call i8* @sanitize_identifier(i8* %t30)
  store i8* %t31, i8** %l2
  store i1 0, i1* %l3
  %t32 = sitofp i64 0 to double
  store double %t32, double* %l4
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = load i8*, i8** %l2
  %t36 = load i1, i1* %l3
  %t37 = load double, double* %l4
  br label %loop.header6
loop.header6:
  %t71 = phi i1 [ %t36, %merge5 ], [ %t69, %loop.latch8 ]
  %t72 = phi double [ %t37, %merge5 ], [ %t70, %loop.latch8 ]
  store i1 %t71, i1* %l3
  store double %t72, double* %l4
  br label %loop.body7
loop.body7:
  %t38 = load double, double* %l4
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load { i8**, i64 }, { i8**, i64 }* %t39
  %t41 = extractvalue { i8**, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t38, %t42
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load double, double* %l1
  %t46 = load i8*, i8** %l2
  %t47 = load i1, i1* %l3
  %t48 = load double, double* %l4
  br i1 %t43, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l4
  %t51 = call double @llvm.round.f64(double %t50)
  %t52 = fptosi double %t51 to i64
  %t53 = load { i8**, i64 }, { i8**, i64 }* %t49
  %t54 = extractvalue { i8**, i64 } %t53, 0
  %t55 = extractvalue { i8**, i64 } %t53, 1
  %t56 = icmp uge i64 %t52, %t55
  ; bounds check: %t56 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t52, i64 %t55)
  %t57 = getelementptr i8*, i8** %t54, i64 %t52
  %t58 = load i8*, i8** %t57
  %t59 = load i8*, i8** %l2
  %t60 = call i1 @strings_equal(i8* %t58, i8* %t59)
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load double, double* %l1
  %t63 = load i8*, i8** %l2
  %t64 = load i1, i1* %l3
  %t65 = load double, double* %l4
  br i1 %t60, label %then12, label %merge13
then12:
  store i1 1, i1* %l3
  br label %afterloop9
merge13:
  %t66 = load double, double* %l4
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l4
  br label %loop.latch8
loop.latch8:
  %t69 = load i1, i1* %l3
  %t70 = load double, double* %l4
  br label %loop.header6
afterloop9:
  %t73 = load i1, i1* %l3
  %t74 = load double, double* %l4
  %t75 = load i1, i1* %l3
  %t76 = xor i1 %t75, 1
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load double, double* %l1
  %t79 = load i8*, i8** %l2
  %t80 = load i1, i1* %l3
  %t81 = load double, double* %l4
  br i1 %t76, label %then14, label %merge15
then14:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l2
  %t84 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t82, i8* %t83)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge15
merge15:
  %t86 = phi { i8**, i64 }* [ %t85, %then14 ], [ %t77, %afterloop9 ]
  store { i8**, i64 }* %t86, { i8**, i64 }** %l0
  %t87 = load double, double* %l1
  %t88 = sitofp i64 1 to double
  %t89 = fadd double %t87, %t88
  store double %t89, double* %l1
  br label %loop.latch2
loop.latch2:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t95 = load double, double* %l1
  %t96 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t97 = ptrtoint [0 x i8*]* %t96 to i64
  %t98 = icmp eq i64 %t97, 0
  %t99 = select i1 %t98, i64 1, i64 %t97
  %t100 = call i8* @malloc(i64 %t99)
  %t101 = bitcast i8* %t100 to i8**
  %t102 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t103 = ptrtoint { i8**, i64 }* %t102 to i64
  %t104 = call i8* @malloc(i64 %t103)
  %t105 = bitcast i8* %t104 to { i8**, i64 }*
  %t106 = getelementptr { i8**, i64 }, { i8**, i64 }* %t105, i32 0, i32 0
  store i8** %t101, i8*** %t106
  %t107 = getelementptr { i8**, i64 }, { i8**, i64 }* %t105, i32 0, i32 1
  store i64 0, i64* %t107
  store { i8**, i64 }* %t105, { i8**, i64 }** %l5
  %t108 = sitofp i64 0 to double
  store double %t108, double* %l1
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t110 = load double, double* %l1
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br label %loop.header16
loop.header16:
  %t146 = phi { i8**, i64 }* [ %t111, %afterloop3 ], [ %t144, %loop.latch18 ]
  %t147 = phi double [ %t110, %afterloop3 ], [ %t145, %loop.latch18 ]
  store { i8**, i64 }* %t146, { i8**, i64 }** %l5
  store double %t147, double* %l1
  br label %loop.body17
loop.body17:
  %t112 = load double, double* %l1
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load { i8**, i64 }, { i8**, i64 }* %t113
  %t115 = extractvalue { i8**, i64 } %t114, 1
  %t116 = sitofp i64 %t115 to double
  %t117 = fcmp oge double %t112, %t116
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = load double, double* %l1
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t117, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load double, double* %l1
  %t124 = call double @llvm.round.f64(double %t123)
  %t125 = fptosi double %t124 to i64
  %t126 = load { i8**, i64 }, { i8**, i64 }* %t122
  %t127 = extractvalue { i8**, i64 } %t126, 0
  %t128 = extractvalue { i8**, i64 } %t126, 1
  %t129 = icmp uge i64 %t125, %t128
  ; bounds check: %t129 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t125, i64 %t128)
  %t130 = getelementptr i8*, i8** %t127, i64 %t125
  %t131 = load i8*, i8** %t130
  %t132 = add i64 0, 2
  %t133 = call i8* @malloc(i64 %t132)
  store i8 34, i8* %t133
  %t134 = getelementptr i8, i8* %t133, i64 1
  store i8 0, i8* %t134
  call void @sailfin_runtime_mark_persistent(i8* %t133)
  %t135 = call i8* @sailfin_runtime_string_concat(i8* %t133, i8* %t131)
  %t136 = add i64 0, 2
  %t137 = call i8* @malloc(i64 %t136)
  store i8 34, i8* %t137
  %t138 = getelementptr i8, i8* %t137, i64 1
  store i8 0, i8* %t138
  call void @sailfin_runtime_mark_persistent(i8* %t137)
  %t139 = call i8* @sailfin_runtime_string_concat(i8* %t135, i8* %t137)
  %t140 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t121, i8* %t139)
  store { i8**, i64 }* %t140, { i8**, i64 }** %l5
  %t141 = load double, double* %l1
  %t142 = sitofp i64 1 to double
  %t143 = fadd double %t141, %t142
  store double %t143, double* %l1
  br label %loop.latch18
loop.latch18:
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t145 = load double, double* %l1
  br label %loop.header16
afterloop19:
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t149 = load double, double* %l1
  %t150 = call i8* @malloc(i64 12)
  %t151 = bitcast i8* %t150 to [12 x i8]*
  store [12 x i8] c"__all__ = [\00", [12 x i8]* %t151
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t153 = call i8* @malloc(i64 3)
  %t154 = bitcast i8* %t153 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t154
  %t155 = call i8* @join_with_separator({ i8**, i64 }* %t152, i8* %t153)
  %t156 = call i8* @sailfin_runtime_string_concat(i8* %t150, i8* %t155)
  %t157 = add i64 0, 2
  %t158 = call i8* @malloc(i64 %t157)
  store i8 93, i8* %t158
  %t159 = getelementptr i8, i8* %t158, i64 1
  store i8 0, i8* %t159
  call void @sailfin_runtime_mark_persistent(i8* %t158)
  %t160 = call i8* @sailfin_runtime_string_concat(i8* %t156, i8* %t158)
  %t161 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t160)
  ret %PythonBuilder %t161
}

define { i8**, i64 }* @collect_export_names({ i8**, i64 }* %existing, { %NativeImportSpecifier*, i64 }* %specifiers) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeImportSpecifier
  %l3 = alloca i8*
  store { i8**, i64 }* %existing, { i8**, i64 }** %l0
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l1
  %t1 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t38 = phi { i8**, i64 }* [ %t1, %block.entry ], [ %t36, %loop.latch2 ]
  %t39 = phi double [ %t2, %block.entry ], [ %t37, %loop.latch2 ]
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  store double %t39, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t5 = extractvalue { %NativeImportSpecifier*, i64 } %t4, 1
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t3, %t6
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %specifiers
  %t14 = extractvalue { %NativeImportSpecifier*, i64 } %t13, 0
  %t15 = extractvalue { %NativeImportSpecifier*, i64 } %t13, 1
  %t16 = icmp uge i64 %t12, %t15
  ; bounds check: %t16 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t12, i64 %t15)
  %t17 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t14, i64 %t12
  %t18 = load %NativeImportSpecifier, %NativeImportSpecifier* %t17
  store %NativeImportSpecifier %t18, %NativeImportSpecifier* %l2
  %t19 = load %NativeImportSpecifier, %NativeImportSpecifier* %l2
  %t20 = call i8* @select_export_name(%NativeImportSpecifier %t19)
  store i8* %t20, i8** %l3
  %t21 = load i8*, i8** %l3
  %t22 = call i64 @sailfin_runtime_string_length(i8* %t21)
  %t23 = icmp sgt i64 %t22, 0
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  %t26 = load %NativeImportSpecifier, %NativeImportSpecifier* %l2
  %t27 = load i8*, i8** %l3
  br i1 %t23, label %then6, label %merge7
then6:
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l3
  %t30 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge7
merge7:
  %t32 = phi { i8**, i64 }* [ %t31, %then6 ], [ %t24, %merge5 ]
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch2
loop.latch2:
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load double, double* %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t42
}

define i8* @select_export_name(%NativeImportSpecifier %specifier) {
block.entry:
  %t1 = extractvalue %NativeImportSpecifier %specifier, 1
  %t2 = icmp ne i8* %t1, null
  br label %logical_and_entry_0

logical_and_entry_0:
  br i1 %t2, label %logical_and_right_0, label %logical_and_merge_0

logical_and_right_0:
  %t3 = extractvalue %NativeImportSpecifier %specifier, 1
  %t4 = call i64 @sailfin_runtime_string_length(i8* %t3)
  %t5 = icmp sgt i64 %t4, 0
  br label %logical_and_right_end_0

logical_and_right_end_0:
  br label %logical_and_merge_0

logical_and_merge_0:
  %t6 = phi i1 [ false, %logical_and_entry_0 ], [ %t5, %logical_and_right_end_0 ]
  br i1 %t6, label %then0, label %merge1
then0:
  %t7 = extractvalue %NativeImportSpecifier %specifier, 1
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  ret i8* %t7
merge1:
  %t8 = extractvalue %NativeImportSpecifier %specifier, 0
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  ret i8* %t8
}

define %PythonStructEmission @emit_single_struct(%PythonBuilder %builder, %NativeStruct %definition) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %PythonBuilder
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca %NativeStructField
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca %NativeFunction
  %l11 = alloca %PythonFunctionEmission
  %t0 = extractvalue %NativeStruct %definition, 0
  %t1 = call i8* @sanitize_identifier(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = call i8* @malloc(i64 7)
  %t3 = bitcast i8* %t2 to [7 x i8]*
  store [7 x i8] c"class \00", [7 x i8]* %t3
  %t4 = load i8*, i8** %l0
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %t4)
  %t6 = add i64 0, 2
  %t7 = call i8* @malloc(i64 %t6)
  store i8 58, i8* %t7
  %t8 = getelementptr i8, i8* %t7, i64 1
  store i8 0, i8* %t8
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t7)
  %t10 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t9)
  store %PythonBuilder %t10, %PythonBuilder* %l1
  %t11 = load %PythonBuilder, %PythonBuilder* %l1
  %t12 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t11)
  store %PythonBuilder %t12, %PythonBuilder* %l1
  %t13 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t14 = ptrtoint [0 x i8*]* %t13 to i64
  %t15 = icmp eq i64 %t14, 0
  %t16 = select i1 %t15, i64 1, i64 %t14
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to i8**
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t20 = ptrtoint { i8**, i64 }* %t19 to i64
  %t21 = call i8* @malloc(i64 %t20)
  %t22 = bitcast i8* %t21 to { i8**, i64 }*
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t22, i32 0, i32 0
  store i8** %t18, i8*** %t23
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  store { i8**, i64 }* %t22, { i8**, i64 }** %l2
  %t25 = extractvalue %NativeStruct %definition, 1
  %t26 = call { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %t25)
  store { i8**, i64 }* %t26, { i8**, i64 }** %l3
  %t27 = call i8* @malloc(i64 18)
  %t28 = bitcast i8* %t27 to [18 x i8]*
  store [18 x i8] c"def __init__(self\00", [18 x i8]* %t28
  store i8* %t27, i8** %l4
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t30 = load { i8**, i64 }, { i8**, i64 }* %t29
  %t31 = extractvalue { i8**, i64 } %t30, 1
  %t32 = icmp sgt i64 %t31, 0
  %t33 = load i8*, i8** %l0
  %t34 = load %PythonBuilder, %PythonBuilder* %l1
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t37 = load i8*, i8** %l4
  br i1 %t32, label %then0, label %merge1
then0:
  %t38 = load i8*, i8** %l4
  %t39 = call i8* @malloc(i64 3)
  %t40 = bitcast i8* %t39 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t40
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t39)
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = call i8* @malloc(i64 3)
  %t44 = bitcast i8* %t43 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t44
  %t45 = call i8* @join_with_separator({ i8**, i64 }* %t42, i8* %t43)
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t45)
  store i8* %t46, i8** %l4
  %t47 = load i8*, i8** %l4
  br label %merge1
merge1:
  %t48 = phi i8* [ %t47, %then0 ], [ %t37, %block.entry ]
  store i8* %t48, i8** %l4
  %t49 = load i8*, i8** %l4
  %t50 = add i64 0, 2
  %t51 = call i8* @malloc(i64 %t50)
  store i8 41, i8* %t51
  %t52 = getelementptr i8, i8* %t51, i64 1
  store i8 0, i8* %t52
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t49, i8* %t51)
  store i8* %t53, i8** %l4
  %t54 = load %PythonBuilder, %PythonBuilder* %l1
  %t55 = load i8*, i8** %l4
  %t56 = add i64 0, 2
  %t57 = call i8* @malloc(i64 %t56)
  store i8 58, i8* %t57
  %t58 = getelementptr i8, i8* %t57, i64 1
  store i8 0, i8* %t58
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t57)
  %t60 = call %PythonBuilder @builder_emit(%PythonBuilder %t54, i8* %t59)
  store %PythonBuilder %t60, %PythonBuilder* %l1
  %t61 = load %PythonBuilder, %PythonBuilder* %l1
  %t62 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t61)
  store %PythonBuilder %t62, %PythonBuilder* %l1
  %t63 = extractvalue %NativeStruct %definition, 1
  %t64 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t63
  %t65 = extractvalue { %NativeStructField*, i64 } %t64, 1
  %t66 = icmp eq i64 %t65, 0
  %t67 = load i8*, i8** %l0
  %t68 = load %PythonBuilder, %PythonBuilder* %l1
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t71 = load i8*, i8** %l4
  br i1 %t66, label %then2, label %else3
then2:
  %t72 = load %PythonBuilder, %PythonBuilder* %l1
  %t73 = call i8* @malloc(i64 5)
  %t74 = bitcast i8* %t73 to [5 x i8]*
  store [5 x i8] c"pass\00", [5 x i8]* %t74
  %t75 = call %PythonBuilder @builder_emit(%PythonBuilder %t72, i8* %t73)
  store %PythonBuilder %t75, %PythonBuilder* %l1
  %t76 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
else3:
  %t77 = sitofp i64 0 to double
  store double %t77, double* %l5
  %t78 = load i8*, i8** %l0
  %t79 = load %PythonBuilder, %PythonBuilder* %l1
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t82 = load i8*, i8** %l4
  %t83 = load double, double* %l5
  br label %loop.header5
loop.header5:
  %t125 = phi %PythonBuilder [ %t79, %else3 ], [ %t123, %loop.latch7 ]
  %t126 = phi double [ %t83, %else3 ], [ %t124, %loop.latch7 ]
  store %PythonBuilder %t125, %PythonBuilder* %l1
  store double %t126, double* %l5
  br label %loop.body6
loop.body6:
  %t84 = load double, double* %l5
  %t85 = extractvalue %NativeStruct %definition, 1
  %t86 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t85
  %t87 = extractvalue { %NativeStructField*, i64 } %t86, 1
  %t88 = sitofp i64 %t87 to double
  %t89 = fcmp oge double %t84, %t88
  %t90 = load i8*, i8** %l0
  %t91 = load %PythonBuilder, %PythonBuilder* %l1
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t94 = load i8*, i8** %l4
  %t95 = load double, double* %l5
  br i1 %t89, label %then9, label %merge10
then9:
  br label %afterloop8
merge10:
  %t96 = extractvalue %NativeStruct %definition, 1
  %t97 = load double, double* %l5
  %t98 = call double @llvm.round.f64(double %t97)
  %t99 = fptosi double %t98 to i64
  %t100 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t96
  %t101 = extractvalue { %NativeStructField*, i64 } %t100, 0
  %t102 = extractvalue { %NativeStructField*, i64 } %t100, 1
  %t103 = icmp uge i64 %t99, %t102
  ; bounds check: %t103 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t99, i64 %t102)
  %t104 = getelementptr %NativeStructField, %NativeStructField* %t101, i64 %t99
  %t105 = load %NativeStructField, %NativeStructField* %t104
  store %NativeStructField %t105, %NativeStructField* %l6
  %t106 = load %NativeStructField, %NativeStructField* %l6
  %t107 = extractvalue %NativeStructField %t106, 0
  %t108 = call i8* @sanitize_identifier(i8* %t107)
  store i8* %t108, i8** %l7
  %t109 = load %PythonBuilder, %PythonBuilder* %l1
  %t110 = call i8* @malloc(i64 6)
  %t111 = bitcast i8* %t110 to [6 x i8]*
  store [6 x i8] c"self.\00", [6 x i8]* %t111
  %t112 = load i8*, i8** %l7
  %t113 = call i8* @sailfin_runtime_string_concat(i8* %t110, i8* %t112)
  %t114 = call i8* @malloc(i64 4)
  %t115 = bitcast i8* %t114 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t115
  %t116 = call i8* @sailfin_runtime_string_concat(i8* %t113, i8* %t114)
  %t117 = load i8*, i8** %l7
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %t117)
  %t119 = call %PythonBuilder @builder_emit(%PythonBuilder %t109, i8* %t118)
  store %PythonBuilder %t119, %PythonBuilder* %l1
  %t120 = load double, double* %l5
  %t121 = sitofp i64 1 to double
  %t122 = fadd double %t120, %t121
  store double %t122, double* %l5
  br label %loop.latch7
loop.latch7:
  %t123 = load %PythonBuilder, %PythonBuilder* %l1
  %t124 = load double, double* %l5
  br label %loop.header5
afterloop8:
  %t127 = load %PythonBuilder, %PythonBuilder* %l1
  %t128 = load double, double* %l5
  %t129 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
merge4:
  %t130 = phi %PythonBuilder [ %t76, %then2 ], [ %t129, %afterloop8 ]
  store %PythonBuilder %t130, %PythonBuilder* %l1
  %t131 = load %PythonBuilder, %PythonBuilder* %l1
  %t132 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t131)
  store %PythonBuilder %t132, %PythonBuilder* %l1
  %t133 = load %PythonBuilder, %PythonBuilder* %l1
  %t134 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t133)
  store %PythonBuilder %t134, %PythonBuilder* %l1
  %t135 = load %PythonBuilder, %PythonBuilder* %l1
  %t136 = call i8* @malloc(i64 20)
  %t137 = bitcast i8* %t136 to [20 x i8]*
  store [20 x i8] c"def __repr__(self):\00", [20 x i8]* %t137
  %t138 = call %PythonBuilder @builder_emit(%PythonBuilder %t135, i8* %t136)
  store %PythonBuilder %t138, %PythonBuilder* %l1
  %t139 = load %PythonBuilder, %PythonBuilder* %l1
  %t140 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t139)
  store %PythonBuilder %t140, %PythonBuilder* %l1
  %t141 = load i8*, i8** %l0
  %t142 = extractvalue %NativeStruct %definition, 1
  %t143 = call i8* @render_struct_repr_fields(i8* %t141, { %NativeStructField*, i64 }* %t142)
  store i8* %t143, i8** %l8
  %t144 = load %PythonBuilder, %PythonBuilder* %l1
  %t145 = load i8*, i8** %l8
  %t146 = call %PythonBuilder @builder_emit(%PythonBuilder %t144, i8* %t145)
  store %PythonBuilder %t146, %PythonBuilder* %l1
  %t147 = load %PythonBuilder, %PythonBuilder* %l1
  %t148 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t147)
  store %PythonBuilder %t148, %PythonBuilder* %l1
  %t149 = load i8*, i8** %l0
  %t150 = call i8* @malloc(i64 13)
  %t151 = bitcast i8* %t150 to [13 x i8]*
  store [13 x i8] c"EnumInstance\00", [13 x i8]* %t151
  %t152 = call i1 @strings_equal(i8* %t149, i8* %t150)
  %t153 = load i8*, i8** %l0
  %t154 = load %PythonBuilder, %PythonBuilder* %l1
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t157 = load i8*, i8** %l4
  %t158 = load i8*, i8** %l8
  br i1 %t152, label %then11, label %merge12
then11:
  %t159 = load %PythonBuilder, %PythonBuilder* %l1
  %t160 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t159)
  store %PythonBuilder %t160, %PythonBuilder* %l1
  %t161 = load %PythonBuilder, %PythonBuilder* %l1
  %t162 = call i8* @malloc(i64 29)
  %t163 = bitcast i8* %t162 to [29 x i8]*
  store [29 x i8] c"def __getattr__(self, item):\00", [29 x i8]* %t163
  %t164 = call %PythonBuilder @builder_emit(%PythonBuilder %t161, i8* %t162)
  store %PythonBuilder %t164, %PythonBuilder* %l1
  %t165 = load %PythonBuilder, %PythonBuilder* %l1
  %t166 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t165)
  store %PythonBuilder %t166, %PythonBuilder* %l1
  %t167 = load %PythonBuilder, %PythonBuilder* %l1
  %t168 = call i8* @malloc(i64 10)
  %t169 = bitcast i8* %t168 to [10 x i8]*
  store [10 x i8] c"index = 0\00", [10 x i8]* %t169
  %t170 = call %PythonBuilder @builder_emit(%PythonBuilder %t167, i8* %t168)
  store %PythonBuilder %t170, %PythonBuilder* %l1
  %t171 = load %PythonBuilder, %PythonBuilder* %l1
  %t172 = call i8* @malloc(i64 12)
  %t173 = bitcast i8* %t172 to [12 x i8]*
  store [12 x i8] c"while True:\00", [12 x i8]* %t173
  %t174 = call %PythonBuilder @builder_emit(%PythonBuilder %t171, i8* %t172)
  store %PythonBuilder %t174, %PythonBuilder* %l1
  %t175 = load %PythonBuilder, %PythonBuilder* %l1
  %t176 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t175)
  store %PythonBuilder %t176, %PythonBuilder* %l1
  %t177 = load %PythonBuilder, %PythonBuilder* %l1
  %t178 = call i8* @malloc(i64 30)
  %t179 = bitcast i8* %t178 to [30 x i8]*
  store [30 x i8] c"if index >= len(self.fields):\00", [30 x i8]* %t179
  %t180 = call %PythonBuilder @builder_emit(%PythonBuilder %t177, i8* %t178)
  store %PythonBuilder %t180, %PythonBuilder* %l1
  %t181 = load %PythonBuilder, %PythonBuilder* %l1
  %t182 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t181)
  store %PythonBuilder %t182, %PythonBuilder* %l1
  %t183 = load %PythonBuilder, %PythonBuilder* %l1
  %t184 = call i8* @malloc(i64 6)
  %t185 = bitcast i8* %t184 to [6 x i8]*
  store [6 x i8] c"break\00", [6 x i8]* %t185
  %t186 = call %PythonBuilder @builder_emit(%PythonBuilder %t183, i8* %t184)
  store %PythonBuilder %t186, %PythonBuilder* %l1
  %t187 = load %PythonBuilder, %PythonBuilder* %l1
  %t188 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t187)
  store %PythonBuilder %t188, %PythonBuilder* %l1
  %t189 = load %PythonBuilder, %PythonBuilder* %l1
  %t190 = call i8* @malloc(i64 27)
  %t191 = bitcast i8* %t190 to [27 x i8]*
  store [27 x i8] c"field = self.fields[index]\00", [27 x i8]* %t191
  %t192 = call %PythonBuilder @builder_emit(%PythonBuilder %t189, i8* %t190)
  store %PythonBuilder %t192, %PythonBuilder* %l1
  %t193 = load %PythonBuilder, %PythonBuilder* %l1
  %t194 = call i8* @malloc(i64 23)
  %t195 = bitcast i8* %t194 to [23 x i8]*
  store [23 x i8] c"if field.name == item:\00", [23 x i8]* %t195
  %t196 = call %PythonBuilder @builder_emit(%PythonBuilder %t193, i8* %t194)
  store %PythonBuilder %t196, %PythonBuilder* %l1
  %t197 = load %PythonBuilder, %PythonBuilder* %l1
  %t198 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t197)
  store %PythonBuilder %t198, %PythonBuilder* %l1
  %t199 = load %PythonBuilder, %PythonBuilder* %l1
  %t200 = call i8* @malloc(i64 19)
  %t201 = bitcast i8* %t200 to [19 x i8]*
  store [19 x i8] c"return field.value\00", [19 x i8]* %t201
  %t202 = call %PythonBuilder @builder_emit(%PythonBuilder %t199, i8* %t200)
  store %PythonBuilder %t202, %PythonBuilder* %l1
  %t203 = load %PythonBuilder, %PythonBuilder* %l1
  %t204 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t203)
  store %PythonBuilder %t204, %PythonBuilder* %l1
  %t205 = load %PythonBuilder, %PythonBuilder* %l1
  %t206 = call i8* @malloc(i64 11)
  %t207 = bitcast i8* %t206 to [11 x i8]*
  store [11 x i8] c"index += 1\00", [11 x i8]* %t207
  %t208 = call %PythonBuilder @builder_emit(%PythonBuilder %t205, i8* %t206)
  store %PythonBuilder %t208, %PythonBuilder* %l1
  %t209 = load %PythonBuilder, %PythonBuilder* %l1
  %t210 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t209)
  store %PythonBuilder %t210, %PythonBuilder* %l1
  %t211 = load %PythonBuilder, %PythonBuilder* %l1
  %t212 = call i8* @malloc(i64 27)
  %t213 = bitcast i8* %t212 to [27 x i8]*
  store [27 x i8] c"raise AttributeError(item)\00", [27 x i8]* %t213
  %t214 = call %PythonBuilder @builder_emit(%PythonBuilder %t211, i8* %t212)
  store %PythonBuilder %t214, %PythonBuilder* %l1
  %t215 = load %PythonBuilder, %PythonBuilder* %l1
  %t216 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t215)
  store %PythonBuilder %t216, %PythonBuilder* %l1
  %t217 = load %PythonBuilder, %PythonBuilder* %l1
  %t218 = load %PythonBuilder, %PythonBuilder* %l1
  %t219 = load %PythonBuilder, %PythonBuilder* %l1
  %t220 = load %PythonBuilder, %PythonBuilder* %l1
  %t221 = load %PythonBuilder, %PythonBuilder* %l1
  %t222 = load %PythonBuilder, %PythonBuilder* %l1
  %t223 = load %PythonBuilder, %PythonBuilder* %l1
  %t224 = load %PythonBuilder, %PythonBuilder* %l1
  %t225 = load %PythonBuilder, %PythonBuilder* %l1
  %t226 = load %PythonBuilder, %PythonBuilder* %l1
  %t227 = load %PythonBuilder, %PythonBuilder* %l1
  %t228 = load %PythonBuilder, %PythonBuilder* %l1
  %t229 = load %PythonBuilder, %PythonBuilder* %l1
  %t230 = load %PythonBuilder, %PythonBuilder* %l1
  %t231 = load %PythonBuilder, %PythonBuilder* %l1
  %t232 = load %PythonBuilder, %PythonBuilder* %l1
  %t233 = load %PythonBuilder, %PythonBuilder* %l1
  %t234 = load %PythonBuilder, %PythonBuilder* %l1
  %t235 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t236 = phi %PythonBuilder [ %t217, %then11 ], [ %t154, %merge4 ]
  %t237 = phi %PythonBuilder [ %t218, %then11 ], [ %t154, %merge4 ]
  %t238 = phi %PythonBuilder [ %t219, %then11 ], [ %t154, %merge4 ]
  %t239 = phi %PythonBuilder [ %t220, %then11 ], [ %t154, %merge4 ]
  %t240 = phi %PythonBuilder [ %t221, %then11 ], [ %t154, %merge4 ]
  %t241 = phi %PythonBuilder [ %t222, %then11 ], [ %t154, %merge4 ]
  %t242 = phi %PythonBuilder [ %t223, %then11 ], [ %t154, %merge4 ]
  %t243 = phi %PythonBuilder [ %t224, %then11 ], [ %t154, %merge4 ]
  %t244 = phi %PythonBuilder [ %t225, %then11 ], [ %t154, %merge4 ]
  %t245 = phi %PythonBuilder [ %t226, %then11 ], [ %t154, %merge4 ]
  %t246 = phi %PythonBuilder [ %t227, %then11 ], [ %t154, %merge4 ]
  %t247 = phi %PythonBuilder [ %t228, %then11 ], [ %t154, %merge4 ]
  %t248 = phi %PythonBuilder [ %t229, %then11 ], [ %t154, %merge4 ]
  %t249 = phi %PythonBuilder [ %t230, %then11 ], [ %t154, %merge4 ]
  %t250 = phi %PythonBuilder [ %t231, %then11 ], [ %t154, %merge4 ]
  %t251 = phi %PythonBuilder [ %t232, %then11 ], [ %t154, %merge4 ]
  %t252 = phi %PythonBuilder [ %t233, %then11 ], [ %t154, %merge4 ]
  %t253 = phi %PythonBuilder [ %t234, %then11 ], [ %t154, %merge4 ]
  %t254 = phi %PythonBuilder [ %t235, %then11 ], [ %t154, %merge4 ]
  store %PythonBuilder %t236, %PythonBuilder* %l1
  store %PythonBuilder %t237, %PythonBuilder* %l1
  store %PythonBuilder %t238, %PythonBuilder* %l1
  store %PythonBuilder %t239, %PythonBuilder* %l1
  store %PythonBuilder %t240, %PythonBuilder* %l1
  store %PythonBuilder %t241, %PythonBuilder* %l1
  store %PythonBuilder %t242, %PythonBuilder* %l1
  store %PythonBuilder %t243, %PythonBuilder* %l1
  store %PythonBuilder %t244, %PythonBuilder* %l1
  store %PythonBuilder %t245, %PythonBuilder* %l1
  store %PythonBuilder %t246, %PythonBuilder* %l1
  store %PythonBuilder %t247, %PythonBuilder* %l1
  store %PythonBuilder %t248, %PythonBuilder* %l1
  store %PythonBuilder %t249, %PythonBuilder* %l1
  store %PythonBuilder %t250, %PythonBuilder* %l1
  store %PythonBuilder %t251, %PythonBuilder* %l1
  store %PythonBuilder %t252, %PythonBuilder* %l1
  store %PythonBuilder %t253, %PythonBuilder* %l1
  store %PythonBuilder %t254, %PythonBuilder* %l1
  %t255 = extractvalue %NativeStruct %definition, 2
  %t256 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t255
  %t257 = extractvalue { %NativeFunction*, i64 } %t256, 1
  %t258 = icmp sgt i64 %t257, 0
  %t259 = load i8*, i8** %l0
  %t260 = load %PythonBuilder, %PythonBuilder* %l1
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t263 = load i8*, i8** %l4
  %t264 = load i8*, i8** %l8
  br i1 %t258, label %then13, label %merge14
then13:
  %t265 = load %PythonBuilder, %PythonBuilder* %l1
  %t266 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t265)
  store %PythonBuilder %t266, %PythonBuilder* %l1
  %t267 = sitofp i64 0 to double
  store double %t267, double* %l9
  %t268 = load i8*, i8** %l0
  %t269 = load %PythonBuilder, %PythonBuilder* %l1
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t272 = load i8*, i8** %l4
  %t273 = load i8*, i8** %l8
  %t274 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t334 = phi %PythonBuilder [ %t269, %then13 ], [ %t331, %loop.latch17 ]
  %t335 = phi { i8**, i64 }* [ %t270, %then13 ], [ %t332, %loop.latch17 ]
  %t336 = phi double [ %t274, %then13 ], [ %t333, %loop.latch17 ]
  store %PythonBuilder %t334, %PythonBuilder* %l1
  store { i8**, i64 }* %t335, { i8**, i64 }** %l2
  store double %t336, double* %l9
  br label %loop.body16
loop.body16:
  %t275 = load double, double* %l9
  %t276 = extractvalue %NativeStruct %definition, 2
  %t277 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t276
  %t278 = extractvalue { %NativeFunction*, i64 } %t277, 1
  %t279 = sitofp i64 %t278 to double
  %t280 = fcmp oge double %t275, %t279
  %t281 = load i8*, i8** %l0
  %t282 = load %PythonBuilder, %PythonBuilder* %l1
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t285 = load i8*, i8** %l4
  %t286 = load i8*, i8** %l8
  %t287 = load double, double* %l9
  br i1 %t280, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t288 = extractvalue %NativeStruct %definition, 2
  %t289 = load double, double* %l9
  %t290 = call double @llvm.round.f64(double %t289)
  %t291 = fptosi double %t290 to i64
  %t292 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t288
  %t293 = extractvalue { %NativeFunction*, i64 } %t292, 0
  %t294 = extractvalue { %NativeFunction*, i64 } %t292, 1
  %t295 = icmp uge i64 %t291, %t294
  ; bounds check: %t295 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t291, i64 %t294)
  %t296 = getelementptr %NativeFunction, %NativeFunction* %t293, i64 %t291
  %t297 = load %NativeFunction, %NativeFunction* %t296
  store %NativeFunction %t297, %NativeFunction* %l10
  %t298 = load %PythonBuilder, %PythonBuilder* %l1
  %t299 = load %NativeFunction, %NativeFunction* %l10
  %t300 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t298, %NativeFunction %t299)
  store %PythonFunctionEmission %t300, %PythonFunctionEmission* %l11
  %t301 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t302 = extractvalue %PythonFunctionEmission %t301, 0
  store %PythonBuilder %t302, %PythonBuilder* %l1
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t304 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t305 = extractvalue %PythonFunctionEmission %t304, 1
  %t306 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t303, { i8**, i64 }* %t305)
  store { i8**, i64 }* %t306, { i8**, i64 }** %l2
  %t307 = load double, double* %l9
  %t308 = sitofp i64 1 to double
  %t309 = fadd double %t307, %t308
  %t310 = extractvalue %NativeStruct %definition, 2
  %t311 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t310
  %t312 = extractvalue { %NativeFunction*, i64 } %t311, 1
  %t313 = sitofp i64 %t312 to double
  %t314 = fcmp olt double %t309, %t313
  %t315 = load i8*, i8** %l0
  %t316 = load %PythonBuilder, %PythonBuilder* %l1
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t319 = load i8*, i8** %l4
  %t320 = load i8*, i8** %l8
  %t321 = load double, double* %l9
  %t322 = load %NativeFunction, %NativeFunction* %l10
  %t323 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t314, label %then21, label %merge22
then21:
  %t324 = load %PythonBuilder, %PythonBuilder* %l1
  %t325 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t324)
  store %PythonBuilder %t325, %PythonBuilder* %l1
  %t326 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t327 = phi %PythonBuilder [ %t326, %then21 ], [ %t316, %merge20 ]
  store %PythonBuilder %t327, %PythonBuilder* %l1
  %t328 = load double, double* %l9
  %t329 = sitofp i64 1 to double
  %t330 = fadd double %t328, %t329
  store double %t330, double* %l9
  br label %loop.latch17
loop.latch17:
  %t331 = load %PythonBuilder, %PythonBuilder* %l1
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t333 = load double, double* %l9
  br label %loop.header15
afterloop18:
  %t337 = load %PythonBuilder, %PythonBuilder* %l1
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t339 = load double, double* %l9
  %t340 = load %PythonBuilder, %PythonBuilder* %l1
  %t341 = load %PythonBuilder, %PythonBuilder* %l1
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t343 = phi %PythonBuilder [ %t340, %afterloop18 ], [ %t260, %merge12 ]
  %t344 = phi %PythonBuilder [ %t341, %afterloop18 ], [ %t260, %merge12 ]
  %t345 = phi { i8**, i64 }* [ %t342, %afterloop18 ], [ %t261, %merge12 ]
  store %PythonBuilder %t343, %PythonBuilder* %l1
  store %PythonBuilder %t344, %PythonBuilder* %l1
  store { i8**, i64 }* %t345, { i8**, i64 }** %l2
  %t346 = load %PythonBuilder, %PythonBuilder* %l1
  %t347 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t346)
  store %PythonBuilder %t347, %PythonBuilder* %l1
  %t348 = load %PythonBuilder, %PythonBuilder* %l1
  %t349 = insertvalue %PythonStructEmission undef, %PythonBuilder %t348, 0
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t351 = insertvalue %PythonStructEmission %t349, { i8**, i64 }* %t350, 1
  ret %PythonStructEmission %t351
}

define { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %fields) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca double
  %l3 = alloca %NativeStructField
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t13 = ptrtoint [0 x i8*]* %t12 to i64
  %t14 = icmp eq i64 %t13, 0
  %t15 = select i1 %t14, i64 1, i64 %t13
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to i8**
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t19 = ptrtoint { i8**, i64 }* %t18 to i64
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to { i8**, i64 }*
  %t22 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 0
  store i8** %t17, i8*** %t22
  %t23 = getelementptr { i8**, i64 }, { i8**, i64 }* %t21, i32 0, i32 1
  store i64 0, i64* %t23
  store { i8**, i64 }* %t21, { i8**, i64 }** %l1
  %t24 = sitofp i64 0 to double
  store double %t24, double* %l2
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t27 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t80 = phi { i8**, i64 }* [ %t26, %block.entry ], [ %t77, %loop.latch2 ]
  %t81 = phi { i8**, i64 }* [ %t25, %block.entry ], [ %t78, %loop.latch2 ]
  %t82 = phi double [ %t27, %block.entry ], [ %t79, %loop.latch2 ]
  store { i8**, i64 }* %t80, { i8**, i64 }** %l1
  store { i8**, i64 }* %t81, { i8**, i64 }** %l0
  store double %t82, double* %l2
  br label %loop.body1
loop.body1:
  %t28 = load double, double* %l2
  %t29 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t30 = extractvalue { %NativeStructField*, i64 } %t29, 1
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t28, %t31
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t35 = load double, double* %l2
  br i1 %t32, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t36 = load double, double* %l2
  %t37 = call double @llvm.round.f64(double %t36)
  %t38 = fptosi double %t37 to i64
  %t39 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t40 = extractvalue { %NativeStructField*, i64 } %t39, 0
  %t41 = extractvalue { %NativeStructField*, i64 } %t39, 1
  %t42 = icmp uge i64 %t38, %t41
  ; bounds check: %t42 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t38, i64 %t41)
  %t43 = getelementptr %NativeStructField, %NativeStructField* %t40, i64 %t38
  %t44 = load %NativeStructField, %NativeStructField* %t43
  store %NativeStructField %t44, %NativeStructField* %l3
  %t45 = load %NativeStructField, %NativeStructField* %l3
  %t46 = extractvalue %NativeStructField %t45, 0
  %t47 = call i8* @sanitize_identifier(i8* %t46)
  store i8* %t47, i8** %l4
  %t48 = load i8*, i8** %l4
  store i8* %t48, i8** %l5
  %t49 = load %NativeStructField, %NativeStructField* %l3
  %t50 = extractvalue %NativeStructField %t49, 1
  %t51 = call i1 @is_optional_type(i8* %t50)
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load double, double* %l2
  %t55 = load %NativeStructField, %NativeStructField* %l3
  %t56 = load i8*, i8** %l4
  %t57 = load i8*, i8** %l5
  br i1 %t51, label %then6, label %else7
then6:
  %t58 = load i8*, i8** %l5
  %t59 = call i8* @malloc(i64 6)
  %t60 = bitcast i8* %t59 to [6 x i8]*
  store [6 x i8] c"=None\00", [6 x i8]* %t60
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t59)
  store i8* %t61, i8** %l5
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t63 = load i8*, i8** %l5
  %t64 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t62, i8* %t63)
  store { i8**, i64 }* %t64, { i8**, i64 }** %l1
  %t65 = load i8*, i8** %l5
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge8
else7:
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load i8*, i8** %l5
  %t69 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t67, i8* %t68)
  store { i8**, i64 }* %t69, { i8**, i64 }** %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge8
merge8:
  %t71 = phi i8* [ %t65, %then6 ], [ %t57, %else7 ]
  %t72 = phi { i8**, i64 }* [ %t66, %then6 ], [ %t53, %else7 ]
  %t73 = phi { i8**, i64 }* [ %t52, %then6 ], [ %t70, %else7 ]
  store i8* %t71, i8** %l5
  store { i8**, i64 }* %t72, { i8**, i64 }** %l1
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  %t74 = load double, double* %l2
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  store double %t76, double* %l2
  br label %loop.latch2
loop.latch2:
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t79 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load double, double* %l2
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t86, { i8**, i64 }* %t87)
  ret { i8**, i64 }* %t88
}

define i8* @render_struct_repr_fields(i8* %class_name, { %NativeStructField*, i64 }* %fields) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeStructField
  %l3 = alloca i8*
  %t0 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t1 = extractvalue { %NativeStructField*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 29)
  %t4 = bitcast i8* %t3 to [29 x i8]*
  store [29 x i8] c"return runtime.struct_repr('\00", [29 x i8]* %t4
  %t5 = call i8* @sailfin_runtime_string_concat(i8* %t3, i8* %class_name)
  %t6 = call i8* @malloc(i64 7)
  %t7 = bitcast i8* %t6 to [7 x i8]*
  store [7 x i8] c"', [])\00", [7 x i8]* %t7
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t5, i8* %t6)
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  ret i8* %t8
merge1:
  %t9 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t10 = ptrtoint [0 x i8*]* %t9 to i64
  %t11 = icmp eq i64 %t10, 0
  %t12 = select i1 %t11, i64 1, i64 %t10
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to i8**
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t16 = ptrtoint { i8**, i64 }* %t15 to i64
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to { i8**, i64 }*
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* %t18, i32 0, i32 0
  store i8** %t14, i8*** %t19
  %t20 = getelementptr { i8**, i64 }, { i8**, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { i8**, i64 }* %t18, { i8**, i64 }** %l0
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l1
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t23 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t63 = phi { i8**, i64 }* [ %t22, %merge1 ], [ %t61, %loop.latch4 ]
  %t64 = phi double [ %t23, %merge1 ], [ %t62, %loop.latch4 ]
  store { i8**, i64 }* %t63, { i8**, i64 }** %l0
  store double %t64, double* %l1
  br label %loop.body3
loop.body3:
  %t24 = load double, double* %l1
  %t25 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t26 = extractvalue { %NativeStructField*, i64 } %t25, 1
  %t27 = sitofp i64 %t26 to double
  %t28 = fcmp oge double %t24, %t27
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  br i1 %t28, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t31 = load double, double* %l1
  %t32 = call double @llvm.round.f64(double %t31)
  %t33 = fptosi double %t32 to i64
  %t34 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t35 = extractvalue { %NativeStructField*, i64 } %t34, 0
  %t36 = extractvalue { %NativeStructField*, i64 } %t34, 1
  %t37 = icmp uge i64 %t33, %t36
  ; bounds check: %t37 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t33, i64 %t36)
  %t38 = getelementptr %NativeStructField, %NativeStructField* %t35, i64 %t33
  %t39 = load %NativeStructField, %NativeStructField* %t38
  store %NativeStructField %t39, %NativeStructField* %l2
  %t40 = load %NativeStructField, %NativeStructField* %l2
  %t41 = extractvalue %NativeStructField %t40, 0
  %t42 = call i8* @sanitize_identifier(i8* %t41)
  store i8* %t42, i8** %l3
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t44 = call i8* @malloc(i64 23)
  %t45 = bitcast i8* %t44 to [23 x i8]*
  store [23 x i8] c"runtime.struct_field('\00", [23 x i8]* %t45
  %t46 = load i8*, i8** %l3
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %t46)
  %t48 = call i8* @malloc(i64 9)
  %t49 = bitcast i8* %t48 to [9 x i8]*
  store [9 x i8] c"', self.\00", [9 x i8]* %t49
  %t50 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t48)
  %t51 = load i8*, i8** %l3
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t50, i8* %t51)
  %t53 = add i64 0, 2
  %t54 = call i8* @malloc(i64 %t53)
  store i8 41, i8* %t54
  %t55 = getelementptr i8, i8* %t54, i64 1
  store i8 0, i8* %t55
  call void @sailfin_runtime_mark_persistent(i8* %t54)
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t52, i8* %t54)
  %t57 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t43, i8* %t56)
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  store double %t60, double* %l1
  br label %loop.latch4
loop.latch4:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load double, double* %l1
  %t67 = call i8* @malloc(i64 29)
  %t68 = bitcast i8* %t67 to [29 x i8]*
  store [29 x i8] c"return runtime.struct_repr('\00", [29 x i8]* %t68
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %class_name)
  %t70 = call i8* @malloc(i64 5)
  %t71 = bitcast i8* %t70 to [5 x i8]*
  store [5 x i8] c"', [\00", [5 x i8]* %t71
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t70)
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = call i8* @malloc(i64 3)
  %t75 = bitcast i8* %t74 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t75
  %t76 = call i8* @join_with_separator({ i8**, i64 }* %t73, i8* %t74)
  %t77 = call i8* @sailfin_runtime_string_concat(i8* %t72, i8* %t76)
  %t78 = call i8* @malloc(i64 3)
  %t79 = bitcast i8* %t78 to [3 x i8]*
  store [3 x i8] c"])\00", [3 x i8]* %t79
  %t80 = call i8* @sailfin_runtime_string_concat(i8* %t77, i8* %t78)
  call void @sailfin_runtime_mark_persistent(i8* %t80)
  ret i8* %t80
}

define i1 @is_optional_type(i8* %type_annotation) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %type_annotation)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t5 = load i8*, i8** %l0
  %t6 = add i64 0, 2
  %t7 = call i8* @malloc(i64 %t6)
  store i8 63, i8* %t7
  %t8 = getelementptr i8, i8* %t7, i64 1
  store i8 0, i8* %t8
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  %t9 = call i1 @ends_with(i8* %t5, i8* %t7)
  ret i1 %t9
}

define i8* @lower_expression(i8* %expression) {
block.entry:
  %t0 = sitofp i64 0 to double
  %t1 = call i8* @lower_expression_with_depth(i8* %expression, double %t0)
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  ret i8* %t1
}

define i8* @lower_expression_with_depth(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %t0 = sitofp i64 8 to double
  %t1 = fcmp ogt double %depth, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i8* @trim_text(i8* %expression)
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
merge1:
  %t3 = call i8* @trim_text(i8* %expression)
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %t4)
  %t6 = icmp eq i64 %t5, 0
  %t7 = load i8*, i8** %l0
  br i1 %t6, label %then2, label %merge3
then2:
  %t8 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  ret i8* %t8
merge3:
  %t9 = load i8*, i8** %l0
  %t10 = call i8* @rewrite_interpolated_string_literal(i8* %t9)
  store i8* %t10, i8** %l1
  %t11 = load i8*, i8** %l1
  %t12 = icmp ne i8* %t11, null
  %t13 = load i8*, i8** %l0
  %t14 = load i8*, i8** %l1
  br i1 %t12, label %then4, label %merge5
then4:
  %t15 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  ret i8* %t15
merge5:
  %t16 = load i8*, i8** %l0
  %t17 = call i8* @lower_struct_literal_expression(i8* %t16, double %depth)
  store i8* %t17, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = icmp ne i8* %t18, null
  %t20 = load i8*, i8** %l0
  %t21 = load i8*, i8** %l1
  %t22 = load i8*, i8** %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load i8*, i8** %l2
  call void @sailfin_runtime_mark_persistent(i8* %t23)
  ret i8* %t23
merge7:
  %t24 = load i8*, i8** %l0
  %t25 = call i8* @lower_array_literal_expression(i8* %t24, double %depth)
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l3
  %t27 = icmp ne i8* %t26, null
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load i8*, i8** %l2
  %t31 = load i8*, i8** %l3
  br i1 %t27, label %then8, label %merge9
then8:
  %t32 = load i8*, i8** %l3
  call void @sailfin_runtime_mark_persistent(i8* %t32)
  ret i8* %t32
merge9:
  %t33 = load i8*, i8** %l0
  %t34 = call i8* @rewrite_expression_intrinsics(i8* %t33)
  store i8* %t34, i8** %l4
  %t35 = load i8*, i8** %l4
  %t36 = call i8* @rewrite_array_literals_inline(i8* %t35, double %depth)
  store i8* %t36, i8** %l5
  %t37 = load i8*, i8** %l5
  %t38 = call i8* @rewrite_struct_literals_inline(i8* %t37, double %depth)
  call void @sailfin_runtime_mark_persistent(i8* %t38)
  ret i8* %t38
}

define i8* @rewrite_interpolated_string_literal(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i64
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca { i8**, i64 }*
  %l10 = alloca double
  %l11 = alloca { i8**, i64 }*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge1:
  %t2 = call i8* @decode_string_literal(i8* %expression)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = icmp eq i8* %t3, null
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then2, label %merge3
then2:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge3:
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @malloc(i64 3)
  %t8 = bitcast i8* %t7 to [3 x i8]*
  store [3 x i8] c"{{\00", [3 x i8]* %t8
  %t9 = call double @find_substring(i8* %t6, i8* %t7)
  %t10 = sitofp i64 0 to double
  %t11 = fcmp olt double %t9, %t10
  %t12 = load i8*, i8** %l0
  br i1 %t11, label %then4, label %merge5
then4:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge5:
  %t13 = load i8*, i8** %l0
  %t14 = call i8* @malloc(i64 3)
  %t15 = bitcast i8* %t14 to [3 x i8]*
  store [3 x i8] c"}}\00", [3 x i8]* %t15
  %t16 = call double @find_substring(i8* %t13, i8* %t14)
  %t17 = sitofp i64 0 to double
  %t18 = fcmp olt double %t16, %t17
  %t19 = load i8*, i8** %l0
  br i1 %t18, label %then6, label %merge7
then6:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge7:
  %t20 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t21 = ptrtoint [0 x i8*]* %t20 to i64
  %t22 = icmp eq i64 %t21, 0
  %t23 = select i1 %t22, i64 1, i64 %t21
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to i8**
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t27 = ptrtoint { i8**, i64 }* %t26 to i64
  %t28 = call i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to { i8**, i64 }*
  %t30 = getelementptr { i8**, i64 }, { i8**, i64 }* %t29, i32 0, i32 0
  store i8** %t25, i8*** %t30
  %t31 = getelementptr { i8**, i64 }, { i8**, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  store { i8**, i64 }* %t29, { i8**, i64 }** %l1
  %t32 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t33 = ptrtoint [0 x i8*]* %t32 to i64
  %t34 = icmp eq i64 %t33, 0
  %t35 = select i1 %t34, i64 1, i64 %t33
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to i8**
  %t38 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t39 = ptrtoint { i8**, i64 }* %t38 to i64
  %t40 = call i8* @malloc(i64 %t39)
  %t41 = bitcast i8* %t40 to { i8**, i64 }*
  %t42 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 0
  store i8** %t37, i8*** %t42
  %t43 = getelementptr { i8**, i64 }, { i8**, i64 }* %t41, i32 0, i32 1
  store i64 0, i64* %t43
  store { i8**, i64 }* %t41, { i8**, i64 }** %l2
  store i64 0, i64* %l3
  %t44 = load i8*, i8** %l0
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t47 = load i64, i64* %l3
  br label %loop.header8
loop.header8:
  %t137 = phi { i8**, i64 }* [ %t45, %merge7 ], [ %t134, %loop.latch10 ]
  %t138 = phi { i8**, i64 }* [ %t46, %merge7 ], [ %t135, %loop.latch10 ]
  %t139 = phi i64 [ %t47, %merge7 ], [ %t136, %loop.latch10 ]
  store { i8**, i64 }* %t137, { i8**, i64 }** %l1
  store { i8**, i64 }* %t138, { i8**, i64 }** %l2
  store i64 %t139, i64* %l3
  br label %loop.body9
loop.body9:
  %t48 = load i64, i64* %l3
  %t49 = load i8*, i8** %l0
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = icmp sgt i64 %t48, %t50
  %t52 = load i8*, i8** %l0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t55 = load i64, i64* %l3
  br i1 %t51, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t56 = load i8*, i8** %l0
  %t57 = call i8* @malloc(i64 3)
  %t58 = bitcast i8* %t57 to [3 x i8]*
  store [3 x i8] c"{{\00", [3 x i8]* %t58
  %t59 = load i64, i64* %l3
  %t60 = sitofp i64 %t59 to double
  %t61 = call double @find_substring_from(i8* %t56, i8* %t57, double %t60)
  store double %t61, double* %l4
  %t62 = load double, double* %l4
  %t63 = sitofp i64 0 to double
  %t64 = fcmp olt double %t62, %t63
  %t65 = load i8*, i8** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t68 = load i64, i64* %l3
  %t69 = load double, double* %l4
  br i1 %t64, label %then14, label %merge15
then14:
  %t70 = load i8*, i8** %l0
  %t71 = load i64, i64* %l3
  %t72 = load i8*, i8** %l0
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = call i8* @sailfin_runtime_substring(i8* %t70, i64 %t71, i64 %t73)
  store i8* %t74, i8** %l5
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load i8*, i8** %l5
  %t77 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t75, i8* %t76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l1
  br label %afterloop11
merge15:
  %t78 = load i8*, i8** %l0
  %t79 = load i64, i64* %l3
  %t80 = load double, double* %l4
  %t81 = call double @llvm.round.f64(double %t80)
  %t82 = fptosi double %t81 to i64
  %t83 = call i8* @sailfin_runtime_substring(i8* %t78, i64 %t79, i64 %t82)
  store i8* %t83, i8** %l6
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = load i8*, i8** %l6
  %t86 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t84, i8* %t85)
  store { i8**, i64 }* %t86, { i8**, i64 }** %l1
  %t87 = load i8*, i8** %l0
  %t88 = call i8* @malloc(i64 3)
  %t89 = bitcast i8* %t88 to [3 x i8]*
  store [3 x i8] c"}}\00", [3 x i8]* %t89
  %t90 = load double, double* %l4
  %t91 = sitofp i64 2 to double
  %t92 = fadd double %t90, %t91
  %t93 = call double @find_substring_from(i8* %t87, i8* %t88, double %t92)
  store double %t93, double* %l7
  %t94 = load double, double* %l7
  %t95 = sitofp i64 0 to double
  %t96 = fcmp olt double %t94, %t95
  %t97 = load i8*, i8** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t100 = load i64, i64* %l3
  %t101 = load double, double* %l4
  %t102 = load i8*, i8** %l6
  %t103 = load double, double* %l7
  br i1 %t96, label %then16, label %merge17
then16:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge17:
  %t104 = load i8*, i8** %l0
  %t105 = load double, double* %l4
  %t106 = sitofp i64 2 to double
  %t107 = fadd double %t105, %t106
  %t108 = load double, double* %l7
  %t109 = call double @llvm.round.f64(double %t107)
  %t110 = fptosi double %t109 to i64
  %t111 = call double @llvm.round.f64(double %t108)
  %t112 = fptosi double %t111 to i64
  %t113 = call i8* @sailfin_runtime_substring(i8* %t104, i64 %t110, i64 %t112)
  %t114 = call i8* @trim_text(i8* %t113)
  store i8* %t114, i8** %l8
  %t115 = load i8*, i8** %l8
  %t116 = call i64 @sailfin_runtime_string_length(i8* %t115)
  %t117 = icmp eq i64 %t116, 0
  %t118 = load i8*, i8** %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t121 = load i64, i64* %l3
  %t122 = load double, double* %l4
  %t123 = load i8*, i8** %l6
  %t124 = load double, double* %l7
  %t125 = load i8*, i8** %l8
  br i1 %t117, label %then18, label %merge19
then18:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge19:
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t127 = load i8*, i8** %l8
  %t128 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t126, i8* %t127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l2
  %t129 = load double, double* %l7
  %t130 = sitofp i64 2 to double
  %t131 = fadd double %t129, %t130
  %t132 = call double @llvm.round.f64(double %t131)
  %t133 = fptosi double %t132 to i64
  store i64 %t133, i64* %l3
  br label %loop.latch10
loop.latch10:
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t136 = load i64, i64* %l3
  br label %loop.header8
afterloop11:
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t142 = load i64, i64* %l3
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t144 = load { i8**, i64 }, { i8**, i64 }* %t143
  %t145 = extractvalue { i8**, i64 } %t144, 1
  %t146 = icmp eq i64 %t145, 0
  %t147 = load i8*, i8** %l0
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t150 = load i64, i64* %l3
  br i1 %t146, label %then20, label %merge21
then20:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge21:
  %t151 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t152 = ptrtoint [0 x i8*]* %t151 to i64
  %t153 = icmp eq i64 %t152, 0
  %t154 = select i1 %t153, i64 1, i64 %t152
  %t155 = call i8* @malloc(i64 %t154)
  %t156 = bitcast i8* %t155 to i8**
  %t157 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t158 = ptrtoint { i8**, i64 }* %t157 to i64
  %t159 = call i8* @malloc(i64 %t158)
  %t160 = bitcast i8* %t159 to { i8**, i64 }*
  %t161 = getelementptr { i8**, i64 }, { i8**, i64 }* %t160, i32 0, i32 0
  store i8** %t156, i8*** %t161
  %t162 = getelementptr { i8**, i64 }, { i8**, i64 }* %t160, i32 0, i32 1
  store i64 0, i64* %t162
  store { i8**, i64 }* %t160, { i8**, i64 }** %l9
  %t163 = sitofp i64 0 to double
  store double %t163, double* %l10
  %t164 = load i8*, i8** %l0
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t167 = load i64, i64* %l3
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t169 = load double, double* %l10
  br label %loop.header22
loop.header22:
  %t200 = phi { i8**, i64 }* [ %t168, %merge21 ], [ %t198, %loop.latch24 ]
  %t201 = phi double [ %t169, %merge21 ], [ %t199, %loop.latch24 ]
  store { i8**, i64 }* %t200, { i8**, i64 }** %l9
  store double %t201, double* %l10
  br label %loop.body23
loop.body23:
  %t170 = load double, double* %l10
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t172 = load { i8**, i64 }, { i8**, i64 }* %t171
  %t173 = extractvalue { i8**, i64 } %t172, 1
  %t174 = sitofp i64 %t173 to double
  %t175 = fcmp oge double %t170, %t174
  %t176 = load i8*, i8** %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t179 = load i64, i64* %l3
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t181 = load double, double* %l10
  br i1 %t175, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t184 = load double, double* %l10
  %t185 = call double @llvm.round.f64(double %t184)
  %t186 = fptosi double %t185 to i64
  %t187 = load { i8**, i64 }, { i8**, i64 }* %t183
  %t188 = extractvalue { i8**, i64 } %t187, 0
  %t189 = extractvalue { i8**, i64 } %t187, 1
  %t190 = icmp uge i64 %t186, %t189
  ; bounds check: %t190 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t186, i64 %t189)
  %t191 = getelementptr i8*, i8** %t188, i64 %t186
  %t192 = load i8*, i8** %t191
  %t193 = call i8* @python_string_literal(i8* %t192)
  %t194 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t182, i8* %t193)
  store { i8**, i64 }* %t194, { i8**, i64 }** %l9
  %t195 = load double, double* %l10
  %t196 = sitofp i64 1 to double
  %t197 = fadd double %t195, %t196
  store double %t197, double* %l10
  br label %loop.latch24
loop.latch24:
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t199 = load double, double* %l10
  br label %loop.header22
afterloop25:
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t203 = load double, double* %l10
  %t204 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t205 = ptrtoint [0 x i8*]* %t204 to i64
  %t206 = icmp eq i64 %t205, 0
  %t207 = select i1 %t206, i64 1, i64 %t205
  %t208 = call i8* @malloc(i64 %t207)
  %t209 = bitcast i8* %t208 to i8**
  %t210 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t211 = ptrtoint { i8**, i64 }* %t210 to i64
  %t212 = call i8* @malloc(i64 %t211)
  %t213 = bitcast i8* %t212 to { i8**, i64 }*
  %t214 = getelementptr { i8**, i64 }, { i8**, i64 }* %t213, i32 0, i32 0
  store i8** %t209, i8*** %t214
  %t215 = getelementptr { i8**, i64 }, { i8**, i64 }* %t213, i32 0, i32 1
  store i64 0, i64* %t215
  store { i8**, i64 }* %t213, { i8**, i64 }** %l11
  %t216 = sitofp i64 0 to double
  store double %t216, double* %l10
  %t217 = load i8*, i8** %l0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t220 = load i64, i64* %l3
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t222 = load double, double* %l10
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br label %loop.header28
loop.header28:
  %t262 = phi { i8**, i64 }* [ %t223, %afterloop25 ], [ %t260, %loop.latch30 ]
  %t263 = phi double [ %t222, %afterloop25 ], [ %t261, %loop.latch30 ]
  store { i8**, i64 }* %t262, { i8**, i64 }** %l11
  store double %t263, double* %l10
  br label %loop.body29
loop.body29:
  %t224 = load double, double* %l10
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t226 = load { i8**, i64 }, { i8**, i64 }* %t225
  %t227 = extractvalue { i8**, i64 } %t226, 1
  %t228 = sitofp i64 %t227 to double
  %t229 = fcmp oge double %t224, %t228
  %t230 = load i8*, i8** %l0
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t233 = load i64, i64* %l3
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t235 = load double, double* %l10
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br i1 %t229, label %then32, label %merge33
then32:
  br label %afterloop31
merge33:
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t239 = load double, double* %l10
  %t240 = call double @llvm.round.f64(double %t239)
  %t241 = fptosi double %t240 to i64
  %t242 = load { i8**, i64 }, { i8**, i64 }* %t238
  %t243 = extractvalue { i8**, i64 } %t242, 0
  %t244 = extractvalue { i8**, i64 } %t242, 1
  %t245 = icmp uge i64 %t241, %t244
  ; bounds check: %t245 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t241, i64 %t244)
  %t246 = getelementptr i8*, i8** %t243, i64 %t241
  %t247 = load i8*, i8** %t246
  %t248 = add i64 0, 2
  %t249 = call i8* @malloc(i64 %t248)
  store i8 40, i8* %t249
  %t250 = getelementptr i8, i8* %t249, i64 1
  store i8 0, i8* %t250
  call void @sailfin_runtime_mark_persistent(i8* %t249)
  %t251 = call i8* @sailfin_runtime_string_concat(i8* %t249, i8* %t247)
  %t252 = add i64 0, 2
  %t253 = call i8* @malloc(i64 %t252)
  store i8 41, i8* %t253
  %t254 = getelementptr i8, i8* %t253, i64 1
  store i8 0, i8* %t254
  call void @sailfin_runtime_mark_persistent(i8* %t253)
  %t255 = call i8* @sailfin_runtime_string_concat(i8* %t251, i8* %t253)
  %t256 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t237, i8* %t255)
  store { i8**, i64 }* %t256, { i8**, i64 }** %l11
  %t257 = load double, double* %l10
  %t258 = sitofp i64 1 to double
  %t259 = fadd double %t257, %t258
  store double %t259, double* %l10
  br label %loop.latch30
loop.latch30:
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t261 = load double, double* %l10
  br label %loop.header28
afterloop31:
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t265 = load double, double* %l10
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t267 = call i8* @malloc(i64 3)
  %t268 = bitcast i8* %t267 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t268
  %t269 = call i8* @join_with_separator({ i8**, i64 }* %t266, i8* %t267)
  %t270 = add i64 0, 2
  %t271 = call i8* @malloc(i64 %t270)
  store i8 91, i8* %t271
  %t272 = getelementptr i8, i8* %t271, i64 1
  store i8 0, i8* %t272
  call void @sailfin_runtime_mark_persistent(i8* %t271)
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %t271, i8* %t269)
  %t274 = add i64 0, 2
  %t275 = call i8* @malloc(i64 %t274)
  store i8 93, i8* %t275
  %t276 = getelementptr i8, i8* %t275, i64 1
  store i8 0, i8* %t276
  call void @sailfin_runtime_mark_persistent(i8* %t275)
  %t277 = call i8* @sailfin_runtime_string_concat(i8* %t273, i8* %t275)
  store i8* %t277, i8** %l12
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t279 = call i8* @malloc(i64 3)
  %t280 = bitcast i8* %t279 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t280
  %t281 = call i8* @join_with_separator({ i8**, i64 }* %t278, i8* %t279)
  %t282 = add i64 0, 2
  %t283 = call i8* @malloc(i64 %t282)
  store i8 91, i8* %t283
  %t284 = getelementptr i8, i8* %t283, i64 1
  store i8 0, i8* %t284
  call void @sailfin_runtime_mark_persistent(i8* %t283)
  %t285 = call i8* @sailfin_runtime_string_concat(i8* %t283, i8* %t281)
  %t286 = add i64 0, 2
  %t287 = call i8* @malloc(i64 %t286)
  store i8 93, i8* %t287
  %t288 = getelementptr i8, i8* %t287, i64 1
  store i8 0, i8* %t288
  call void @sailfin_runtime_mark_persistent(i8* %t287)
  %t289 = call i8* @sailfin_runtime_string_concat(i8* %t285, i8* %t287)
  store i8* %t289, i8** %l13
  %t290 = call i8* @malloc(i64 29)
  %t291 = bitcast i8* %t290 to [29 x i8]*
  store [29 x i8] c"runtime.format_interpolated(\00", [29 x i8]* %t291
  %t292 = load i8*, i8** %l12
  %t293 = call i8* @sailfin_runtime_string_concat(i8* %t290, i8* %t292)
  %t294 = call i8* @malloc(i64 3)
  %t295 = bitcast i8* %t294 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t295
  %t296 = call i8* @sailfin_runtime_string_concat(i8* %t293, i8* %t294)
  %t297 = load i8*, i8** %l13
  %t298 = call i8* @sailfin_runtime_string_concat(i8* %t296, i8* %t297)
  %t299 = add i64 0, 2
  %t300 = call i8* @malloc(i64 %t299)
  store i8 41, i8* %t300
  %t301 = getelementptr i8, i8* %t300, i64 1
  store i8 0, i8* %t301
  call void @sailfin_runtime_mark_persistent(i8* %t300)
  %t302 = call i8* @sailfin_runtime_string_concat(i8* %t298, i8* %t300)
  call void @sailfin_runtime_mark_persistent(i8* %t302)
  ret i8* %t302
}

define i8* @decode_string_literal(i8* %expression) {
block.entry:
  %l0 = alloca i8
  %l1 = alloca i8*
  %l2 = alloca i64
  %l3 = alloca i8
  %l4 = alloca i8
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp slt i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge1:
  %t2 = getelementptr i8, i8* %expression, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  %t5 = load i8, i8* %l0
  %t6 = icmp ne i8 %t5, 34
  br label %logical_and_entry_4

logical_and_entry_4:
  br i1 %t6, label %logical_and_right_4, label %logical_and_merge_4

logical_and_right_4:
  %t7 = load i8, i8* %l0
  %t8 = icmp ne i8 %t7, 39
  br label %logical_and_right_end_4

logical_and_right_end_4:
  br label %logical_and_merge_4

logical_and_merge_4:
  %t9 = phi i1 [ false, %logical_and_entry_4 ], [ %t8, %logical_and_right_end_4 ]
  %t10 = load i8, i8* %l0
  br i1 %t9, label %then2, label %merge3
then2:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge3:
  %t11 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t12 = sub i64 %t11, 1
  %t13 = getelementptr i8, i8* %expression, i64 %t12
  %t14 = load i8, i8* %t13
  %t15 = load i8, i8* %l0
  %t16 = icmp ne i8 %t14, %t15
  %t17 = load i8, i8* %l0
  br i1 %t16, label %then4, label %merge5
then4:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge5:
  %t18 = call i8* @malloc(i64 1)
  %t19 = bitcast i8* %t18 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t19
  store i8* %t18, i8** %l1
  store i64 1, i64* %l2
  %t20 = load i8, i8* %l0
  %t21 = load i8*, i8** %l1
  %t22 = load i64, i64* %l2
  br label %loop.header6
loop.header6:
  %t75 = phi i64 [ %t22, %merge5 ], [ %t73, %loop.latch8 ]
  %t76 = phi i8* [ %t21, %merge5 ], [ %t74, %loop.latch8 ]
  store i64 %t75, i64* %l2
  store i8* %t76, i8** %l1
  br label %loop.body7
loop.body7:
  %t23 = load i64, i64* %l2
  %t24 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t25 = sub i64 %t24, 1
  %t26 = icmp sge i64 %t23, %t25
  %t27 = load i8, i8* %l0
  %t28 = load i8*, i8** %l1
  %t29 = load i64, i64* %l2
  br i1 %t26, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t30 = load i64, i64* %l2
  %t31 = getelementptr i8, i8* %expression, i64 %t30
  %t32 = load i8, i8* %t31
  store i8 %t32, i8* %l3
  %t33 = load i8, i8* %l3
  %t34 = icmp eq i8 %t33, 92
  %t35 = load i8, i8* %l0
  %t36 = load i8*, i8** %l1
  %t37 = load i64, i64* %l2
  %t38 = load i8, i8* %l3
  br i1 %t34, label %then12, label %merge13
then12:
  %t39 = load i64, i64* %l2
  %t40 = add i64 %t39, 1
  store i64 %t40, i64* %l2
  %t41 = load i64, i64* %l2
  %t42 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t43 = sub i64 %t42, 1
  %t44 = icmp sge i64 %t41, %t43
  %t45 = load i8, i8* %l0
  %t46 = load i8*, i8** %l1
  %t47 = load i64, i64* %l2
  %t48 = load i8, i8* %l3
  br i1 %t44, label %then14, label %merge15
then14:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge15:
  %t49 = load i64, i64* %l2
  %t50 = getelementptr i8, i8* %expression, i64 %t49
  %t51 = load i8, i8* %t50
  store i8 %t51, i8* %l4
  %t52 = load i8*, i8** %l1
  %t53 = load i8, i8* %l4
  %t54 = load i8, i8* %l0
  %t55 = add i64 0, 2
  %t56 = call i8* @malloc(i64 %t55)
  store i8 %t53, i8* %t56
  %t57 = getelementptr i8, i8* %t56, i64 1
  store i8 0, i8* %t57
  call void @sailfin_runtime_mark_persistent(i8* %t56)
  %t58 = add i64 0, 2
  %t59 = call i8* @malloc(i64 %t58)
  store i8 %t54, i8* %t59
  %t60 = getelementptr i8, i8* %t59, i64 1
  store i8 0, i8* %t60
  call void @sailfin_runtime_mark_persistent(i8* %t59)
  %t61 = call i8* @decode_escape_sequence(i8* %t56, i8* %t59)
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t52, i8* %t61)
  store i8* %t62, i8** %l1
  %t63 = load i64, i64* %l2
  %t64 = add i64 %t63, 1
  store i64 %t64, i64* %l2
  br label %loop.latch8
merge13:
  %t65 = load i8*, i8** %l1
  %t66 = load i8, i8* %l3
  %t67 = add i64 0, 2
  %t68 = call i8* @malloc(i64 %t67)
  store i8 %t66, i8* %t68
  %t69 = getelementptr i8, i8* %t68, i64 1
  store i8 0, i8* %t69
  call void @sailfin_runtime_mark_persistent(i8* %t68)
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %t68)
  store i8* %t70, i8** %l1
  %t71 = load i64, i64* %l2
  %t72 = add i64 %t71, 1
  store i64 %t72, i64* %l2
  br label %loop.latch8
loop.latch8:
  %t73 = load i64, i64* %l2
  %t74 = load i8*, i8** %l1
  br label %loop.header6
afterloop9:
  %t77 = load i64, i64* %l2
  %t78 = load i8*, i8** %l1
  %t79 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t79)
  ret i8* %t79
}

define i8* @decode_escape_sequence(i8* %escape, i8* %quote) {
block.entry:
  %t0 = load i8, i8* %escape
  %t1 = icmp eq i8 %t0, 110
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 10, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = load i8, i8* %escape
  %t6 = icmp eq i8 %t5, 114
  br i1 %t6, label %then2, label %merge3
then2:
  %t7 = add i64 0, 2
  %t8 = call i8* @malloc(i64 %t7)
  store i8 13, i8* %t8
  %t9 = getelementptr i8, i8* %t8, i64 1
  store i8 0, i8* %t9
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  call void @sailfin_runtime_mark_persistent(i8* %t8)
  ret i8* %t8
merge3:
  %t10 = load i8, i8* %escape
  %t11 = icmp eq i8 %t10, 116
  br i1 %t11, label %then4, label %merge5
then4:
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 9, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  ret i8* %t13
merge5:
  %t15 = load i8, i8* %escape
  %t16 = icmp eq i8 %t15, 92
  br i1 %t16, label %then6, label %merge7
then6:
  %t17 = add i64 0, 2
  %t18 = call i8* @malloc(i64 %t17)
  store i8 92, i8* %t18
  %t19 = getelementptr i8, i8* %t18, i64 1
  store i8 0, i8* %t19
  call void @sailfin_runtime_mark_persistent(i8* %t18)
  call void @sailfin_runtime_mark_persistent(i8* %t18)
  ret i8* %t18
merge7:
  %t20 = call i1 @strings_equal(i8* %escape, i8* %quote)
  br i1 %t20, label %then8, label %merge9
then8:
  call void @sailfin_runtime_mark_persistent(i8* %quote)
  ret i8* %quote
merge9:
  call void @sailfin_runtime_mark_persistent(i8* %escape)
  ret i8* %escape
}

define i8* @python_string_literal(i8* %value) {
block.entry:
  %l0 = alloca i8
  %l1 = alloca i64
  %l2 = alloca i8
  store i8 39, i8* %l0
  store i64 0, i64* %l1
  %t0 = load i8, i8* %l0
  %t1 = load i64, i64* %l1
  br label %loop.header0
loop.header0:
  %t107 = phi i8 [ %t0, %block.entry ], [ %t105, %loop.latch2 ]
  %t108 = phi i64 [ %t1, %block.entry ], [ %t106, %loop.latch2 ]
  store i8 %t107, i8* %l0
  store i64 %t108, i64* %l1
  br label %loop.body1
loop.body1:
  %t2 = load i64, i64* %l1
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = icmp sge i64 %t2, %t3
  %t5 = load i8, i8* %l0
  %t6 = load i64, i64* %l1
  br i1 %t4, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = load i64, i64* %l1
  %t8 = getelementptr i8, i8* %value, i64 %t7
  %t9 = load i8, i8* %t8
  store i8 %t9, i8* %l2
  %t10 = load i8, i8* %l2
  %t11 = icmp eq i8 %t10, 92
  %t12 = load i8, i8* %l0
  %t13 = load i64, i64* %l1
  %t14 = load i8, i8* %l2
  br i1 %t11, label %then6, label %else7
then6:
  %t15 = load i8, i8* %l0
  %t16 = call i8* @malloc(i64 3)
  %t17 = bitcast i8* %t16 to [3 x i8]*
  store [3 x i8] c"\5C\5C\00", [3 x i8]* %t17
  %t18 = add i64 0, 2
  %t19 = call i8* @malloc(i64 %t18)
  store i8 %t15, i8* %t19
  %t20 = getelementptr i8, i8* %t19, i64 1
  store i8 0, i8* %t20
  call void @sailfin_runtime_mark_persistent(i8* %t19)
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %t16)
  %t22 = load i8, i8* %t21
  store i8 %t22, i8* %l0
  %t23 = load i8, i8* %l0
  br label %merge8
else7:
  %t24 = load i8, i8* %l2
  %t25 = icmp eq i8 %t24, 39
  %t26 = load i8, i8* %l0
  %t27 = load i64, i64* %l1
  %t28 = load i8, i8* %l2
  br i1 %t25, label %then9, label %else10
then9:
  %t29 = load i8, i8* %l0
  %t30 = call i8* @malloc(i64 3)
  %t31 = bitcast i8* %t30 to [3 x i8]*
  store [3 x i8] c"\5C'\00", [3 x i8]* %t31
  %t32 = add i64 0, 2
  %t33 = call i8* @malloc(i64 %t32)
  store i8 %t29, i8* %t33
  %t34 = getelementptr i8, i8* %t33, i64 1
  store i8 0, i8* %t34
  call void @sailfin_runtime_mark_persistent(i8* %t33)
  %t35 = call i8* @sailfin_runtime_string_concat(i8* %t33, i8* %t30)
  %t36 = load i8, i8* %t35
  store i8 %t36, i8* %l0
  %t37 = load i8, i8* %l0
  br label %merge11
else10:
  %t38 = load i8, i8* %l2
  %t39 = icmp eq i8 %t38, 10
  %t40 = load i8, i8* %l0
  %t41 = load i64, i64* %l1
  %t42 = load i8, i8* %l2
  br i1 %t39, label %then12, label %else13
then12:
  %t43 = load i8, i8* %l0
  %t44 = call i8* @malloc(i64 3)
  %t45 = bitcast i8* %t44 to [3 x i8]*
  store [3 x i8] c"\5Cn\00", [3 x i8]* %t45
  %t46 = add i64 0, 2
  %t47 = call i8* @malloc(i64 %t46)
  store i8 %t43, i8* %t47
  %t48 = getelementptr i8, i8* %t47, i64 1
  store i8 0, i8* %t48
  call void @sailfin_runtime_mark_persistent(i8* %t47)
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t44)
  %t50 = load i8, i8* %t49
  store i8 %t50, i8* %l0
  %t51 = load i8, i8* %l0
  br label %merge14
else13:
  %t52 = load i8, i8* %l2
  %t53 = icmp eq i8 %t52, 13
  %t54 = load i8, i8* %l0
  %t55 = load i64, i64* %l1
  %t56 = load i8, i8* %l2
  br i1 %t53, label %then15, label %else16
then15:
  %t57 = load i8, i8* %l0
  %t58 = call i8* @malloc(i64 3)
  %t59 = bitcast i8* %t58 to [3 x i8]*
  store [3 x i8] c"\5Cr\00", [3 x i8]* %t59
  %t60 = add i64 0, 2
  %t61 = call i8* @malloc(i64 %t60)
  store i8 %t57, i8* %t61
  %t62 = getelementptr i8, i8* %t61, i64 1
  store i8 0, i8* %t62
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t58)
  %t64 = load i8, i8* %t63
  store i8 %t64, i8* %l0
  %t65 = load i8, i8* %l0
  br label %merge17
else16:
  %t66 = load i8, i8* %l2
  %t67 = icmp eq i8 %t66, 9
  %t68 = load i8, i8* %l0
  %t69 = load i64, i64* %l1
  %t70 = load i8, i8* %l2
  br i1 %t67, label %then18, label %else19
then18:
  %t71 = load i8, i8* %l0
  %t72 = call i8* @malloc(i64 3)
  %t73 = bitcast i8* %t72 to [3 x i8]*
  store [3 x i8] c"\5Ct\00", [3 x i8]* %t73
  %t74 = add i64 0, 2
  %t75 = call i8* @malloc(i64 %t74)
  store i8 %t71, i8* %t75
  %t76 = getelementptr i8, i8* %t75, i64 1
  store i8 0, i8* %t76
  call void @sailfin_runtime_mark_persistent(i8* %t75)
  %t77 = call i8* @sailfin_runtime_string_concat(i8* %t75, i8* %t72)
  %t78 = load i8, i8* %t77
  store i8 %t78, i8* %l0
  %t79 = load i8, i8* %l0
  br label %merge20
else19:
  %t80 = load i8, i8* %l0
  %t81 = load i8, i8* %l2
  %t82 = add i8 %t80, %t81
  store i8 %t82, i8* %l0
  %t83 = load i8, i8* %l0
  br label %merge20
merge20:
  %t84 = phi i8 [ %t79, %then18 ], [ %t83, %else19 ]
  store i8 %t84, i8* %l0
  %t85 = load i8, i8* %l0
  %t86 = load i8, i8* %l0
  br label %merge17
merge17:
  %t87 = phi i8 [ %t65, %then15 ], [ %t85, %merge20 ]
  store i8 %t87, i8* %l0
  %t88 = load i8, i8* %l0
  %t89 = load i8, i8* %l0
  %t90 = load i8, i8* %l0
  br label %merge14
merge14:
  %t91 = phi i8 [ %t51, %then12 ], [ %t88, %merge17 ]
  store i8 %t91, i8* %l0
  %t92 = load i8, i8* %l0
  %t93 = load i8, i8* %l0
  %t94 = load i8, i8* %l0
  %t95 = load i8, i8* %l0
  br label %merge11
merge11:
  %t96 = phi i8 [ %t37, %then9 ], [ %t92, %merge14 ]
  store i8 %t96, i8* %l0
  %t97 = load i8, i8* %l0
  %t98 = load i8, i8* %l0
  %t99 = load i8, i8* %l0
  %t100 = load i8, i8* %l0
  %t101 = load i8, i8* %l0
  br label %merge8
merge8:
  %t102 = phi i8 [ %t23, %then6 ], [ %t97, %merge11 ]
  store i8 %t102, i8* %l0
  %t103 = load i64, i64* %l1
  %t104 = add i64 %t103, 1
  store i64 %t104, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t105 = load i8, i8* %l0
  %t106 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t109 = load i8, i8* %l0
  %t110 = load i64, i64* %l1
  %t111 = load i8, i8* %l0
  %t112 = add i8 %t111, 39
  store i8 %t112, i8* %l0
  %t113 = load i8, i8* %l0
  %t114 = add i64 0, 2
  %t115 = call i8* @malloc(i64 %t114)
  store i8 %t113, i8* %t115
  %t116 = getelementptr i8, i8* %t115, i64 1
  store i8 0, i8* %t116
  call void @sailfin_runtime_mark_persistent(i8* %t115)
  call void @sailfin_runtime_mark_persistent(i8* %t115)
  ret i8* %t115
}

define double @find_substring(i8* %value, i8* %pattern) {
block.entry:
  %l0 = alloca i64
  %l1 = alloca i1
  %l2 = alloca i64
  %t0 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t5 = icmp slt i64 %t3, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %t6 = sitofp i64 -1 to double
  ret double %t6
merge3:
  store i64 0, i64* %l0
  %t7 = load i64, i64* %l0
  br label %loop.header4
loop.header4:
  %t52 = phi i64 [ %t7, %merge3 ], [ %t51, %loop.latch6 ]
  store i64 %t52, i64* %l0
  br label %loop.body5
loop.body5:
  %t8 = load i64, i64* %l0
  %t9 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t10 = add i64 %t8, %t9
  %t11 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t12 = icmp sgt i64 %t10, %t11
  %t13 = load i64, i64* %l0
  br i1 %t12, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  store i1 1, i1* %l1
  store i64 0, i64* %l2
  %t14 = load i64, i64* %l0
  %t15 = load i1, i1* %l1
  %t16 = load i64, i64* %l2
  br label %loop.header10
loop.header10:
  %t39 = phi i1 [ %t15, %merge9 ], [ %t37, %loop.latch12 ]
  %t40 = phi i64 [ %t16, %merge9 ], [ %t38, %loop.latch12 ]
  store i1 %t39, i1* %l1
  store i64 %t40, i64* %l2
  br label %loop.body11
loop.body11:
  %t17 = load i64, i64* %l2
  %t18 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t19 = icmp sge i64 %t17, %t18
  %t20 = load i64, i64* %l0
  %t21 = load i1, i1* %l1
  %t22 = load i64, i64* %l2
  br i1 %t19, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t23 = load i64, i64* %l0
  %t24 = load i64, i64* %l2
  %t25 = add i64 %t23, %t24
  %t26 = getelementptr i8, i8* %value, i64 %t25
  %t27 = load i8, i8* %t26
  %t28 = load i64, i64* %l2
  %t29 = getelementptr i8, i8* %pattern, i64 %t28
  %t30 = load i8, i8* %t29
  %t31 = icmp ne i8 %t27, %t30
  %t32 = load i64, i64* %l0
  %t33 = load i1, i1* %l1
  %t34 = load i64, i64* %l2
  br i1 %t31, label %then16, label %merge17
then16:
  store i1 0, i1* %l1
  br label %afterloop13
merge17:
  %t35 = load i64, i64* %l2
  %t36 = add i64 %t35, 1
  store i64 %t36, i64* %l2
  br label %loop.latch12
loop.latch12:
  %t37 = load i1, i1* %l1
  %t38 = load i64, i64* %l2
  br label %loop.header10
afterloop13:
  %t41 = load i1, i1* %l1
  %t42 = load i64, i64* %l2
  %t43 = load i1, i1* %l1
  %t44 = load i64, i64* %l0
  %t45 = load i1, i1* %l1
  %t46 = load i64, i64* %l2
  br i1 %t43, label %then18, label %merge19
then18:
  %t47 = load i64, i64* %l0
  %t48 = sitofp i64 %t47 to double
  ret double %t48
merge19:
  %t49 = load i64, i64* %l0
  %t50 = add i64 %t49, 1
  store i64 %t50, i64* %l0
  br label %loop.latch6
loop.latch6:
  %t51 = load i64, i64* %l0
  br label %loop.header4
afterloop7:
  %t53 = load i64, i64* %l0
  %t54 = sitofp i64 -1 to double
  ret double %t54
}

define i8* @lower_struct_literal_expression(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { i8**, i64 }*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca i8*
  %t0 = add i64 0, 2
  %t1 = call i8* @malloc(i64 %t0)
  store i8 123, i8* %t1
  %t2 = getelementptr i8, i8* %t1, i64 1
  store i8 0, i8* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  %t3 = call double @index_of(i8* %expression, i8* %t1)
  store double %t3, double* %l0
  %t4 = load double, double* %l0
  %t5 = sitofp i64 0 to double
  %t6 = fcmp olt double %t4, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge1:
  %t8 = load double, double* %l0
  %t9 = call double @find_matching_brace(i8* %expression, double %t8)
  store double %t9, double* %l1
  %t10 = load double, double* %l1
  %t11 = sitofp i64 0 to double
  %t12 = fcmp olt double %t10, %t11
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  br i1 %t12, label %then2, label %merge3
then2:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge3:
  %t15 = load double, double* %l0
  %t16 = call double @llvm.round.f64(double %t15)
  %t17 = fptosi double %t16 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %expression, i64 0, i64 %t17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = call i64 @sailfin_runtime_string_length(i8* %t20)
  %t22 = icmp eq i64 %t21, 0
  %t23 = load double, double* %l0
  %t24 = load double, double* %l1
  %t25 = load i8*, i8** %l2
  br i1 %t22, label %then4, label %merge5
then4:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge5:
  %t26 = load i8*, i8** %l2
  %t27 = call i1 @is_struct_literal_type_candidate(i8* %t26)
  %t28 = xor i1 %t27, 1
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then6, label %merge7
then6:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge7:
  %t32 = load double, double* %l0
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  %t35 = load double, double* %l1
  %t36 = call double @llvm.round.f64(double %t34)
  %t37 = fptosi double %t36 to i64
  %t38 = call double @llvm.round.f64(double %t35)
  %t39 = fptosi double %t38 to i64
  %t40 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t37, i64 %t39)
  store i8* %t40, i8** %l3
  %t41 = load i8*, i8** %l3
  %t42 = call { i8**, i64 }* @split_struct_field_entries(i8* %t41)
  store { i8**, i64 }* %t42, { i8**, i64 }** %l4
  %t43 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t44 = ptrtoint [0 x i8*]* %t43 to i64
  %t45 = icmp eq i64 %t44, 0
  %t46 = select i1 %t45, i64 1, i64 %t44
  %t47 = call i8* @malloc(i64 %t46)
  %t48 = bitcast i8* %t47 to i8**
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t50 = ptrtoint { i8**, i64 }* %t49 to i64
  %t51 = call i8* @malloc(i64 %t50)
  %t52 = bitcast i8* %t51 to { i8**, i64 }*
  %t53 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 0
  store i8** %t48, i8*** %t53
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t52, i32 0, i32 1
  store i64 0, i64* %t54
  store { i8**, i64 }* %t52, { i8**, i64 }** %l5
  %t55 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t56 = ptrtoint [0 x i8*]* %t55 to i64
  %t57 = icmp eq i64 %t56, 0
  %t58 = select i1 %t57, i64 1, i64 %t56
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to i8**
  %t61 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t62 = ptrtoint { i8**, i64 }* %t61 to i64
  %t63 = call i8* @malloc(i64 %t62)
  %t64 = bitcast i8* %t63 to { i8**, i64 }*
  %t65 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 0
  store i8** %t60, i8*** %t65
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t64, i32 0, i32 1
  store i64 0, i64* %t66
  store { i8**, i64 }* %t64, { i8**, i64 }** %l6
  %t67 = sitofp i64 0 to double
  store double %t67, double* %l7
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  %t70 = load i8*, i8** %l2
  %t71 = load i8*, i8** %l3
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t75 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t208 = phi double [ %t75, %merge7 ], [ %t205, %loop.latch10 ]
  %t209 = phi { i8**, i64 }* [ %t73, %merge7 ], [ %t206, %loop.latch10 ]
  %t210 = phi { i8**, i64 }* [ %t74, %merge7 ], [ %t207, %loop.latch10 ]
  store double %t208, double* %l7
  store { i8**, i64 }* %t209, { i8**, i64 }** %l5
  store { i8**, i64 }* %t210, { i8**, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t76 = load double, double* %l7
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t78 = load { i8**, i64 }, { i8**, i64 }* %t77
  %t79 = extractvalue { i8**, i64 } %t78, 1
  %t80 = sitofp i64 %t79 to double
  %t81 = fcmp oge double %t76, %t80
  %t82 = load double, double* %l0
  %t83 = load double, double* %l1
  %t84 = load i8*, i8** %l2
  %t85 = load i8*, i8** %l3
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t89 = load double, double* %l7
  br i1 %t81, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t91 = load double, double* %l7
  %t92 = call double @llvm.round.f64(double %t91)
  %t93 = fptosi double %t92 to i64
  %t94 = load { i8**, i64 }, { i8**, i64 }* %t90
  %t95 = extractvalue { i8**, i64 } %t94, 0
  %t96 = extractvalue { i8**, i64 } %t94, 1
  %t97 = icmp uge i64 %t93, %t96
  ; bounds check: %t97 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t93, i64 %t96)
  %t98 = getelementptr i8*, i8** %t95, i64 %t93
  %t99 = load i8*, i8** %t98
  %t100 = call i8* @trim_text(i8* %t99)
  %t101 = call i8* @trim_trailing_delimiters(i8* %t100)
  store i8* %t101, i8** %l8
  %t102 = load i8*, i8** %l8
  %t103 = call i64 @sailfin_runtime_string_length(i8* %t102)
  %t104 = icmp eq i64 %t103, 0
  %t105 = load double, double* %l0
  %t106 = load double, double* %l1
  %t107 = load i8*, i8** %l2
  %t108 = load i8*, i8** %l3
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t112 = load double, double* %l7
  %t113 = load i8*, i8** %l8
  br i1 %t104, label %then14, label %merge15
then14:
  %t114 = load double, double* %l7
  %t115 = sitofp i64 1 to double
  %t116 = fadd double %t114, %t115
  store double %t116, double* %l7
  br label %loop.latch10
merge15:
  %t117 = load i8*, i8** %l8
  %t118 = add i64 0, 2
  %t119 = call i8* @malloc(i64 %t118)
  store i8 58, i8* %t119
  %t120 = getelementptr i8, i8* %t119, i64 1
  store i8 0, i8* %t120
  call void @sailfin_runtime_mark_persistent(i8* %t119)
  %t121 = call double @index_of(i8* %t117, i8* %t119)
  store double %t121, double* %l9
  %t122 = load double, double* %l9
  %t123 = sitofp i64 0 to double
  %t124 = fcmp olt double %t122, %t123
  %t125 = load double, double* %l0
  %t126 = load double, double* %l1
  %t127 = load i8*, i8** %l2
  %t128 = load i8*, i8** %l3
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t132 = load double, double* %l7
  %t133 = load i8*, i8** %l8
  %t134 = load double, double* %l9
  br i1 %t124, label %then16, label %merge17
then16:
  %t135 = load double, double* %l7
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l7
  br label %loop.latch10
merge17:
  %t138 = load i8*, i8** %l8
  %t139 = load double, double* %l9
  %t140 = call double @llvm.round.f64(double %t139)
  %t141 = fptosi double %t140 to i64
  %t142 = call i8* @sailfin_runtime_substring(i8* %t138, i64 0, i64 %t141)
  %t143 = call i8* @trim_text(i8* %t142)
  store i8* %t143, i8** %l10
  %t144 = load i8*, i8** %l8
  %t145 = load double, double* %l9
  %t146 = sitofp i64 1 to double
  %t147 = fadd double %t145, %t146
  %t148 = load i8*, i8** %l8
  %t149 = call i64 @sailfin_runtime_string_length(i8* %t148)
  %t150 = call double @llvm.round.f64(double %t147)
  %t151 = fptosi double %t150 to i64
  %t152 = call i8* @sailfin_runtime_substring(i8* %t144, i64 %t151, i64 %t149)
  %t153 = call i8* @trim_text(i8* %t152)
  store i8* %t153, i8** %l11
  %t154 = load i8*, i8** %l10
  %t155 = call i64 @sailfin_runtime_string_length(i8* %t154)
  %t156 = icmp eq i64 %t155, 0
  %t157 = load double, double* %l0
  %t158 = load double, double* %l1
  %t159 = load i8*, i8** %l2
  %t160 = load i8*, i8** %l3
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t164 = load double, double* %l7
  %t165 = load i8*, i8** %l8
  %t166 = load double, double* %l9
  %t167 = load i8*, i8** %l10
  %t168 = load i8*, i8** %l11
  br i1 %t156, label %then18, label %merge19
then18:
  %t169 = load double, double* %l7
  %t170 = sitofp i64 1 to double
  %t171 = fadd double %t169, %t170
  store double %t171, double* %l7
  br label %loop.latch10
merge19:
  %t172 = load i8*, i8** %l11
  %t173 = sitofp i64 1 to double
  %t174 = fadd double %depth, %t173
  %t175 = call i8* @lower_expression_with_depth(i8* %t172, double %t174)
  store i8* %t175, i8** %l12
  %t176 = load i8*, i8** %l10
  %t177 = call i8* @sanitize_identifier(i8* %t176)
  store i8* %t177, i8** %l13
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t179 = load i8*, i8** %l13
  %t180 = add i64 0, 2
  %t181 = call i8* @malloc(i64 %t180)
  store i8 61, i8* %t181
  %t182 = getelementptr i8, i8* %t181, i64 1
  store i8 0, i8* %t182
  call void @sailfin_runtime_mark_persistent(i8* %t181)
  %t183 = call i8* @sailfin_runtime_string_concat(i8* %t179, i8* %t181)
  %t184 = load i8*, i8** %l12
  %t185 = call i8* @sailfin_runtime_string_concat(i8* %t183, i8* %t184)
  %t186 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t178, i8* %t185)
  store { i8**, i64 }* %t186, { i8**, i64 }** %l5
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t188 = call i8* @malloc(i64 21)
  %t189 = bitcast i8* %t188 to [21 x i8]*
  store [21 x i8] c"runtime.enum_field('\00", [21 x i8]* %t189
  %t190 = load i8*, i8** %l13
  %t191 = call i8* @sailfin_runtime_string_concat(i8* %t188, i8* %t190)
  %t192 = call i8* @malloc(i64 4)
  %t193 = bitcast i8* %t192 to [4 x i8]*
  store [4 x i8] c"', \00", [4 x i8]* %t193
  %t194 = call i8* @sailfin_runtime_string_concat(i8* %t191, i8* %t192)
  %t195 = load i8*, i8** %l12
  %t196 = call i8* @sailfin_runtime_string_concat(i8* %t194, i8* %t195)
  %t197 = add i64 0, 2
  %t198 = call i8* @malloc(i64 %t197)
  store i8 41, i8* %t198
  %t199 = getelementptr i8, i8* %t198, i64 1
  store i8 0, i8* %t199
  call void @sailfin_runtime_mark_persistent(i8* %t198)
  %t200 = call i8* @sailfin_runtime_string_concat(i8* %t196, i8* %t198)
  %t201 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t187, i8* %t200)
  store { i8**, i64 }* %t201, { i8**, i64 }** %l6
  %t202 = load double, double* %l7
  %t203 = sitofp i64 1 to double
  %t204 = fadd double %t202, %t203
  store double %t204, double* %l7
  br label %loop.latch10
loop.latch10:
  %t205 = load double, double* %l7
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t211 = load double, double* %l7
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t214 = load i8*, i8** %l2
  %t215 = call i8* @sanitize_qualified_identifier(i8* %t214)
  store i8* %t215, i8** %l14
  %t216 = sitofp i64 -1 to double
  store double %t216, double* %l15
  %t217 = sitofp i64 0 to double
  store double %t217, double* %l7
  %t218 = load double, double* %l0
  %t219 = load double, double* %l1
  %t220 = load i8*, i8** %l2
  %t221 = load i8*, i8** %l3
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t225 = load double, double* %l7
  %t226 = load i8*, i8** %l14
  %t227 = load double, double* %l15
  br label %loop.header20
loop.header20:
  %t266 = phi double [ %t227, %afterloop11 ], [ %t264, %loop.latch22 ]
  %t267 = phi double [ %t225, %afterloop11 ], [ %t265, %loop.latch22 ]
  store double %t266, double* %l15
  store double %t267, double* %l7
  br label %loop.body21
loop.body21:
  %t228 = load double, double* %l7
  %t229 = load i8*, i8** %l14
  %t230 = call i64 @sailfin_runtime_string_length(i8* %t229)
  %t231 = sitofp i64 %t230 to double
  %t232 = fcmp oge double %t228, %t231
  %t233 = load double, double* %l0
  %t234 = load double, double* %l1
  %t235 = load i8*, i8** %l2
  %t236 = load i8*, i8** %l3
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t240 = load double, double* %l7
  %t241 = load i8*, i8** %l14
  %t242 = load double, double* %l15
  br i1 %t232, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t243 = load i8*, i8** %l14
  %t244 = load double, double* %l7
  %t245 = call i8* @char_at(i8* %t243, double %t244)
  %t246 = load i8, i8* %t245
  %t247 = icmp eq i8 %t246, 46
  %t248 = load double, double* %l0
  %t249 = load double, double* %l1
  %t250 = load i8*, i8** %l2
  %t251 = load i8*, i8** %l3
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t255 = load double, double* %l7
  %t256 = load i8*, i8** %l14
  %t257 = load double, double* %l15
  br i1 %t247, label %then26, label %merge27
then26:
  %t258 = load double, double* %l7
  store double %t258, double* %l15
  %t259 = load double, double* %l15
  br label %merge27
merge27:
  %t260 = phi double [ %t259, %then26 ], [ %t257, %merge25 ]
  store double %t260, double* %l15
  %t261 = load double, double* %l7
  %t262 = sitofp i64 1 to double
  %t263 = fadd double %t261, %t262
  store double %t263, double* %l7
  br label %loop.latch22
loop.latch22:
  %t264 = load double, double* %l15
  %t265 = load double, double* %l7
  br label %loop.header20
afterloop23:
  %t268 = load double, double* %l15
  %t269 = load double, double* %l7
  %t270 = load double, double* %l15
  %t271 = sitofp i64 0 to double
  %t272 = fcmp oge double %t270, %t271
  %t273 = load double, double* %l0
  %t274 = load double, double* %l1
  %t275 = load i8*, i8** %l2
  %t276 = load i8*, i8** %l3
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t278 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t280 = load double, double* %l7
  %t281 = load i8*, i8** %l14
  %t282 = load double, double* %l15
  br i1 %t272, label %then28, label %merge29
then28:
  %t283 = load i8*, i8** %l14
  %t284 = load double, double* %l15
  %t285 = call double @llvm.round.f64(double %t284)
  %t286 = fptosi double %t285 to i64
  %t287 = call i8* @sailfin_runtime_substring(i8* %t283, i64 0, i64 %t286)
  store i8* %t287, i8** %l16
  %t288 = load i8*, i8** %l14
  %t289 = load double, double* %l15
  %t290 = sitofp i64 1 to double
  %t291 = fadd double %t289, %t290
  %t292 = load i8*, i8** %l14
  %t293 = call i64 @sailfin_runtime_string_length(i8* %t292)
  %t294 = call double @llvm.round.f64(double %t291)
  %t295 = fptosi double %t294 to i64
  %t296 = call i8* @sailfin_runtime_substring(i8* %t288, i64 %t295, i64 %t293)
  store i8* %t296, i8** %l17
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t298 = call i8* @malloc(i64 3)
  %t299 = bitcast i8* %t298 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t299
  %t300 = call i8* @join_with_separator({ i8**, i64 }* %t297, i8* %t298)
  %t301 = add i64 0, 2
  %t302 = call i8* @malloc(i64 %t301)
  store i8 91, i8* %t302
  %t303 = getelementptr i8, i8* %t302, i64 1
  store i8 0, i8* %t303
  call void @sailfin_runtime_mark_persistent(i8* %t302)
  %t304 = call i8* @sailfin_runtime_string_concat(i8* %t302, i8* %t300)
  %t305 = add i64 0, 2
  %t306 = call i8* @malloc(i64 %t305)
  store i8 93, i8* %t306
  %t307 = getelementptr i8, i8* %t306, i64 1
  store i8 0, i8* %t307
  call void @sailfin_runtime_mark_persistent(i8* %t306)
  %t308 = call i8* @sailfin_runtime_string_concat(i8* %t304, i8* %t306)
  store i8* %t308, i8** %l18
  %t309 = call i8* @malloc(i64 26)
  %t310 = bitcast i8* %t309 to [26 x i8]*
  store [26 x i8] c"runtime.enum_instantiate(\00", [26 x i8]* %t310
  %t311 = load i8*, i8** %l16
  %t312 = call i8* @sailfin_runtime_string_concat(i8* %t309, i8* %t311)
  %t313 = call i8* @malloc(i64 4)
  %t314 = bitcast i8* %t313 to [4 x i8]*
  store [4 x i8] c", '\00", [4 x i8]* %t314
  %t315 = call i8* @sailfin_runtime_string_concat(i8* %t312, i8* %t313)
  %t316 = load i8*, i8** %l17
  %t317 = call i8* @sailfin_runtime_string_concat(i8* %t315, i8* %t316)
  %t318 = call i8* @malloc(i64 4)
  %t319 = bitcast i8* %t318 to [4 x i8]*
  store [4 x i8] c"', \00", [4 x i8]* %t319
  %t320 = call i8* @sailfin_runtime_string_concat(i8* %t317, i8* %t318)
  %t321 = load i8*, i8** %l18
  %t322 = call i8* @sailfin_runtime_string_concat(i8* %t320, i8* %t321)
  %t323 = add i64 0, 2
  %t324 = call i8* @malloc(i64 %t323)
  store i8 41, i8* %t324
  %t325 = getelementptr i8, i8* %t324, i64 1
  store i8 0, i8* %t325
  call void @sailfin_runtime_mark_persistent(i8* %t324)
  %t326 = call i8* @sailfin_runtime_string_concat(i8* %t322, i8* %t324)
  call void @sailfin_runtime_mark_persistent(i8* %t326)
  ret i8* %t326
merge29:
  %t327 = load i8*, i8** %l14
  %t328 = add i64 0, 2
  %t329 = call i8* @malloc(i64 %t328)
  store i8 40, i8* %t329
  %t330 = getelementptr i8, i8* %t329, i64 1
  store i8 0, i8* %t330
  call void @sailfin_runtime_mark_persistent(i8* %t329)
  %t331 = call i8* @sailfin_runtime_string_concat(i8* %t327, i8* %t329)
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t333 = call i8* @malloc(i64 3)
  %t334 = bitcast i8* %t333 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t334
  %t335 = call i8* @join_with_separator({ i8**, i64 }* %t332, i8* %t333)
  %t336 = call i8* @sailfin_runtime_string_concat(i8* %t331, i8* %t335)
  %t337 = add i64 0, 2
  %t338 = call i8* @malloc(i64 %t337)
  store i8 41, i8* %t338
  %t339 = getelementptr i8, i8* %t338, i64 1
  store i8 0, i8* %t339
  call void @sailfin_runtime_mark_persistent(i8* %t338)
  %t340 = call i8* @sailfin_runtime_string_concat(i8* %t336, i8* %t338)
  call void @sailfin_runtime_mark_persistent(i8* %t340)
  ret i8* %t340
}

define i1 @is_struct_literal_type_candidate(i8* %text) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l0
  %t3 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t34 = phi double [ %t3, %merge1 ], [ %t33, %loop.latch4 ]
  store double %t34, double* %l0
  br label %loop.body3
loop.body3:
  %t4 = load double, double* %l0
  %t5 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t4, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t9 = load double, double* %l0
  %t10 = load double, double* %l0
  %t11 = sitofp i64 1 to double
  %t12 = fadd double %t10, %t11
  %t13 = call double @llvm.round.f64(double %t9)
  %t14 = fptosi double %t13 to i64
  %t15 = call double @llvm.round.f64(double %t12)
  %t16 = fptosi double %t15 to i64
  %t17 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t14, i64 %t16)
  store i8* %t17, i8** %l1
  %t18 = load i8*, i8** %l1
  %t19 = load i8, i8* %t18
  %t20 = icmp eq i8 %t19, 46
  %t21 = load double, double* %l0
  %t22 = load i8*, i8** %l1
  br i1 %t20, label %then8, label %merge9
then8:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch4
merge9:
  %t26 = load i8*, i8** %l1
  %t27 = call i1 @is_identifier_char(i8* %t26)
  %t28 = load double, double* %l0
  %t29 = load i8*, i8** %l1
  br i1 %t27, label %then10, label %merge11
then10:
  %t30 = load double, double* %l0
  %t31 = sitofp i64 1 to double
  %t32 = fadd double %t30, %t31
  store double %t32, double* %l0
  br label %loop.latch4
merge11:
  ret i1 0
loop.latch4:
  %t33 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t35 = load double, double* %l0
  ret i1 1
}

define i8* @lower_array_literal_expression(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i64
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %expression)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp slt i64 %t2, 2
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge1:
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sailfin_runtime_substring(i8* %t5, i64 0, i64 1)
  %t7 = load i8, i8* %t6
  %t8 = icmp ne i8 %t7, 91
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge3:
  %t10 = load i8*, i8** %l0
  %t11 = call i64 @sailfin_runtime_string_length(i8* %t10)
  %t12 = sub i64 %t11, 1
  store i64 %t12, i64* %l1
  %t13 = load i8*, i8** %l0
  %t14 = load i64, i64* %l1
  %t15 = load i64, i64* %l1
  %t16 = add i64 %t15, 1
  %t17 = call i8* @sailfin_runtime_substring(i8* %t13, i64 %t14, i64 %t16)
  %t18 = load i8, i8* %t17
  %t19 = icmp ne i8 %t18, 93
  %t20 = load i8*, i8** %l0
  %t21 = load i64, i64* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge5:
  %t22 = load i8*, i8** %l0
  %t23 = load i8*, i8** %l0
  %t24 = call i64 @sailfin_runtime_string_length(i8* %t23)
  %t25 = sub i64 %t24, 1
  %t26 = call i8* @sailfin_runtime_substring(i8* %t22, i64 1, i64 %t25)
  store i8* %t26, i8** %l2
  %t27 = load i8*, i8** %l2
  %t28 = call { i8**, i64 }* @split_array_entries(i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l3
  %t29 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t30 = ptrtoint [0 x i8*]* %t29 to i64
  %t31 = icmp eq i64 %t30, 0
  %t32 = select i1 %t31, i64 1, i64 %t30
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to i8**
  %t35 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t36 = ptrtoint { i8**, i64 }* %t35 to i64
  %t37 = call i8* @malloc(i64 %t36)
  %t38 = bitcast i8* %t37 to { i8**, i64 }*
  %t39 = getelementptr { i8**, i64 }, { i8**, i64 }* %t38, i32 0, i32 0
  store i8** %t34, i8*** %t39
  %t40 = getelementptr { i8**, i64 }, { i8**, i64 }* %t38, i32 0, i32 1
  store i64 0, i64* %t40
  store { i8**, i64 }* %t38, { i8**, i64 }** %l4
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t42 = call double @array_literal_start_index({ i8**, i64 }* %t41)
  store double %t42, double* %l5
  %t43 = load i8*, i8** %l0
  %t44 = load i64, i64* %l1
  %t45 = load i8*, i8** %l2
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t48 = load double, double* %l5
  br label %loop.header6
loop.header6:
  %t96 = phi { i8**, i64 }* [ %t47, %merge5 ], [ %t94, %loop.latch8 ]
  %t97 = phi double [ %t48, %merge5 ], [ %t95, %loop.latch8 ]
  store { i8**, i64 }* %t96, { i8**, i64 }** %l4
  store double %t97, double* %l5
  br label %loop.body7
loop.body7:
  %t49 = load double, double* %l5
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t51 = load { i8**, i64 }, { i8**, i64 }* %t50
  %t52 = extractvalue { i8**, i64 } %t51, 1
  %t53 = sitofp i64 %t52 to double
  %t54 = fcmp oge double %t49, %t53
  %t55 = load i8*, i8** %l0
  %t56 = load i64, i64* %l1
  %t57 = load i8*, i8** %l2
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t60 = load double, double* %l5
  br i1 %t54, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t62 = load double, double* %l5
  %t63 = call double @llvm.round.f64(double %t62)
  %t64 = fptosi double %t63 to i64
  %t65 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t66 = extractvalue { i8**, i64 } %t65, 0
  %t67 = extractvalue { i8**, i64 } %t65, 1
  %t68 = icmp uge i64 %t64, %t67
  ; bounds check: %t68 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t64, i64 %t67)
  %t69 = getelementptr i8*, i8** %t66, i64 %t64
  %t70 = load i8*, i8** %t69
  %t71 = call i8* @trim_text(i8* %t70)
  %t72 = call i8* @trim_trailing_delimiters(i8* %t71)
  store i8* %t72, i8** %l6
  %t73 = load i8*, i8** %l6
  %t74 = call i64 @sailfin_runtime_string_length(i8* %t73)
  %t75 = icmp sgt i64 %t74, 0
  %t76 = load i8*, i8** %l0
  %t77 = load i64, i64* %l1
  %t78 = load i8*, i8** %l2
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t81 = load double, double* %l5
  %t82 = load i8*, i8** %l6
  br i1 %t75, label %then12, label %merge13
then12:
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t84 = load i8*, i8** %l6
  %t85 = sitofp i64 1 to double
  %t86 = fadd double %depth, %t85
  %t87 = call i8* @lower_expression_with_depth(i8* %t84, double %t86)
  %t88 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t83, i8* %t87)
  store { i8**, i64 }* %t88, { i8**, i64 }** %l4
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge13
merge13:
  %t90 = phi { i8**, i64 }* [ %t89, %then12 ], [ %t80, %merge11 ]
  store { i8**, i64 }* %t90, { i8**, i64 }** %l4
  %t91 = load double, double* %l5
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  store double %t93, double* %l5
  br label %loop.latch8
loop.latch8:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t95 = load double, double* %l5
  br label %loop.header6
afterloop9:
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t99 = load double, double* %l5
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t100
  %t102 = extractvalue { i8**, i64 } %t101, 1
  %t103 = icmp eq i64 %t102, 0
  %t104 = load i8*, i8** %l0
  %t105 = load i64, i64* %l1
  %t106 = load i8*, i8** %l2
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t109 = load double, double* %l5
  br i1 %t103, label %then14, label %merge15
then14:
  %t110 = call i8* @malloc(i64 3)
  %t111 = bitcast i8* %t110 to [3 x i8]*
  store [3 x i8] c"[]\00", [3 x i8]* %t111
  call void @sailfin_runtime_mark_persistent(i8* %t110)
  ret i8* %t110
merge15:
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t113 = call i8* @malloc(i64 3)
  %t114 = bitcast i8* %t113 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t114
  %t115 = call i8* @join_with_separator({ i8**, i64 }* %t112, i8* %t113)
  store i8* %t115, i8** %l7
  %t116 = load i8*, i8** %l7
  %t117 = add i64 0, 2
  %t118 = call i8* @malloc(i64 %t117)
  store i8 91, i8* %t118
  %t119 = getelementptr i8, i8* %t118, i64 1
  store i8 0, i8* %t119
  call void @sailfin_runtime_mark_persistent(i8* %t118)
  %t120 = call i8* @sailfin_runtime_string_concat(i8* %t118, i8* %t116)
  %t121 = add i64 0, 2
  %t122 = call i8* @malloc(i64 %t121)
  store i8 93, i8* %t122
  %t123 = getelementptr i8, i8* %t122, i64 1
  store i8 0, i8* %t123
  call void @sailfin_runtime_mark_persistent(i8* %t122)
  %t124 = call i8* @sailfin_runtime_string_concat(i8* %t120, i8* %t122)
  call void @sailfin_runtime_mark_persistent(i8* %t124)
  ret i8* %t124
}

define double @array_literal_start_index({ i8**, i64 }* %entries) {
block.entry:
  %l0 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = sitofp i64 0 to double
  ret double %t3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %entries
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t6)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  %t10 = call i8* @trim_text(i8* %t9)
  %t11 = call i8* @trim_trailing_delimiters(i8* %t10)
  store i8* %t11, i8** %l0
  %t12 = load i8*, i8** %l0
  %t13 = call i1 @is_array_metadata_entry(i8* %t12)
  %t14 = load i8*, i8** %l0
  br i1 %t13, label %then2, label %merge3
then2:
  %t15 = sitofp i64 1 to double
  ret double %t15
merge3:
  %t16 = sitofp i64 0 to double
  ret double %t16
}

define i1 @is_array_metadata_entry(i8* %entry) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @malloc(i64 10)
  %t7 = bitcast i8* %t6 to [10 x i8]*
  store [10 x i8] c"#element:\00", [10 x i8]* %t7
  %t8 = call i1 @starts_with(i8* %t5, i8* %t6)
  %t9 = xor i1 %t8, 1
  %t10 = load i8*, i8** %l0
  br i1 %t9, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t11 = load i8*, i8** %l0
  %t12 = load i8*, i8** %l0
  %t13 = call i64 @sailfin_runtime_string_length(i8* %t12)
  %t14 = call i8* @sailfin_runtime_substring(i8* %t11, i64 9, i64 %t13)
  %t15 = call i8* @trim_text(i8* %t14)
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp sgt i64 %t17, 0
  ret i1 %t18
}

define i8* @rewrite_array_literals_inline(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %expression)
  ret i8* %expression
merge1:
  store i8* %expression, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t82 = phi double [ %t4, %merge1 ], [ %t80, %loop.latch4 ]
  %t83 = phi i8* [ %t3, %merge1 ], [ %t81, %loop.latch4 ]
  store double %t82, double* %l1
  store i8* %t83, i8** %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t5, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = call double @find_next_square_open(i8* %t12, double %t13)
  store double %t14, double* %l2
  %t15 = load double, double* %l2
  %t16 = sitofp i64 0 to double
  %t17 = fcmp olt double %t15, %t16
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  br i1 %t17, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l2
  %t23 = call double @find_matching_square(i8* %t21, double %t22)
  store double %t23, double* %l3
  %t24 = load double, double* %l3
  %t25 = sitofp i64 0 to double
  %t26 = fcmp olt double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load double, double* %l2
  %t30 = load double, double* %l3
  br i1 %t26, label %then10, label %merge11
then10:
  br label %afterloop5
merge11:
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = call double @llvm.round.f64(double %t32)
  %t37 = fptosi double %t36 to i64
  %t38 = call double @llvm.round.f64(double %t35)
  %t39 = fptosi double %t38 to i64
  %t40 = call i8* @sailfin_runtime_substring(i8* %t31, i64 %t37, i64 %t39)
  store i8* %t40, i8** %l4
  %t41 = load i8*, i8** %l4
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %depth, %t42
  %t44 = call i8* @lower_array_literal_expression(i8* %t41, double %t43)
  store i8* %t44, i8** %l5
  %t45 = load i8*, i8** %l5
  %t46 = icmp eq i8* %t45, null
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load double, double* %l3
  %t51 = load i8*, i8** %l4
  %t52 = load i8*, i8** %l5
  br i1 %t46, label %then12, label %merge13
then12:
  %t53 = load double, double* %l2
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l1
  br label %loop.latch4
merge13:
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l2
  %t58 = call double @llvm.round.f64(double %t57)
  %t59 = fptosi double %t58 to i64
  %t60 = call i8* @sailfin_runtime_substring(i8* %t56, i64 0, i64 %t59)
  store i8* %t60, i8** %l6
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l3
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  %t65 = load i8*, i8** %l0
  %t66 = call i64 @sailfin_runtime_string_length(i8* %t65)
  %t67 = call double @llvm.round.f64(double %t64)
  %t68 = fptosi double %t67 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %t61, i64 %t68, i64 %t66)
  store i8* %t69, i8** %l7
  %t70 = load i8*, i8** %l6
  %t71 = load i8*, i8** %l5
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %t71)
  %t73 = load i8*, i8** %l7
  %t74 = call i8* @sailfin_runtime_string_concat(i8* %t72, i8* %t73)
  store i8* %t74, i8** %l0
  %t75 = load double, double* %l2
  %t76 = load i8*, i8** %l5
  %t77 = call i64 @sailfin_runtime_string_length(i8* %t76)
  %t78 = sitofp i64 %t77 to double
  %t79 = fadd double %t75, %t78
  store double %t79, double* %l1
  br label %loop.latch4
loop.latch4:
  %t80 = load double, double* %l1
  %t81 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t84 = load double, double* %l1
  %t85 = load i8*, i8** %l0
  %t86 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t86)
  ret i8* %t86
}

define i8* @rewrite_struct_literals_inline(i8* %expression, double %depth) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca double
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %expression)
  ret i8* %expression
merge1:
  store i8* %expression, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t246 = phi double [ %t4, %merge1 ], [ %t244, %loop.latch4 ]
  %t247 = phi i8* [ %t3, %merge1 ], [ %t245, %loop.latch4 ]
  store double %t246, double* %l1
  store i8* %t247, i8** %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t5, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  %t14 = add i64 0, 2
  %t15 = call i8* @malloc(i64 %t14)
  store i8 123, i8* %t15
  %t16 = getelementptr i8, i8* %t15, i64 1
  store i8 0, i8* %t16
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  %t17 = call double @find_substring_from(i8* %t12, i8* %t15, double %t13)
  store double %t17, double* %l2
  %t18 = load double, double* %l2
  %t19 = sitofp i64 0 to double
  %t20 = fcmp olt double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t24 = load double, double* %l2
  store double %t24, double* %l3
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l2
  %t28 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t58 = phi double [ %t28, %merge9 ], [ %t57, %loop.latch12 ]
  store double %t58, double* %l3
  br label %loop.body11
loop.body11:
  %t29 = load double, double* %l3
  %t30 = sitofp i64 0 to double
  %t31 = fcmp ole double %t29, %t30
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l2
  %t35 = load double, double* %l3
  br i1 %t31, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t36 = load i8*, i8** %l0
  %t37 = load double, double* %l3
  %t38 = sitofp i64 1 to double
  %t39 = fsub double %t37, %t38
  %t40 = load double, double* %l3
  %t41 = call double @llvm.round.f64(double %t39)
  %t42 = fptosi double %t41 to i64
  %t43 = call double @llvm.round.f64(double %t40)
  %t44 = fptosi double %t43 to i64
  %t45 = call i8* @sailfin_runtime_substring(i8* %t36, i64 %t42, i64 %t44)
  store i8* %t45, i8** %l4
  %t46 = load i8*, i8** %l4
  %t47 = load i8, i8* %t46
  %t48 = call i1 @sailfin_runtime_is_whitespace_char(i8 %t47)
  %t49 = load i8*, i8** %l0
  %t50 = load double, double* %l1
  %t51 = load double, double* %l2
  %t52 = load double, double* %l3
  %t53 = load i8*, i8** %l4
  br i1 %t48, label %then16, label %merge17
then16:
  %t54 = load double, double* %l3
  %t55 = sitofp i64 1 to double
  %t56 = fsub double %t54, %t55
  store double %t56, double* %l3
  br label %loop.latch12
merge17:
  br label %afterloop13
loop.latch12:
  %t57 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t59 = load double, double* %l3
  %t60 = load double, double* %l3
  store double %t60, double* %l5
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l1
  %t63 = load double, double* %l2
  %t64 = load double, double* %l3
  %t65 = load double, double* %l5
  br label %loop.header18
loop.header18:
  %t108 = phi double [ %t65, %afterloop13 ], [ %t107, %loop.latch20 ]
  store double %t108, double* %l5
  br label %loop.body19
loop.body19:
  %t66 = load double, double* %l5
  %t67 = sitofp i64 0 to double
  %t68 = fcmp ole double %t66, %t67
  %t69 = load i8*, i8** %l0
  %t70 = load double, double* %l1
  %t71 = load double, double* %l2
  %t72 = load double, double* %l3
  %t73 = load double, double* %l5
  br i1 %t68, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t74 = load i8*, i8** %l0
  %t75 = load double, double* %l5
  %t76 = sitofp i64 1 to double
  %t77 = fsub double %t75, %t76
  %t78 = load double, double* %l5
  %t79 = call double @llvm.round.f64(double %t77)
  %t80 = fptosi double %t79 to i64
  %t81 = call double @llvm.round.f64(double %t78)
  %t82 = fptosi double %t81 to i64
  %t83 = call i8* @sailfin_runtime_substring(i8* %t74, i64 %t80, i64 %t82)
  store i8* %t83, i8** %l6
  %t84 = load i8*, i8** %l6
  %t85 = load i8, i8* %t84
  %t86 = icmp eq i8 %t85, 46
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l2
  %t90 = load double, double* %l3
  %t91 = load double, double* %l5
  %t92 = load i8*, i8** %l6
  br i1 %t86, label %then24, label %merge25
then24:
  %t93 = load double, double* %l5
  %t94 = sitofp i64 1 to double
  %t95 = fsub double %t93, %t94
  store double %t95, double* %l5
  br label %loop.latch20
merge25:
  %t96 = load i8*, i8** %l6
  %t97 = call i1 @is_identifier_char(i8* %t96)
  %t98 = load i8*, i8** %l0
  %t99 = load double, double* %l1
  %t100 = load double, double* %l2
  %t101 = load double, double* %l3
  %t102 = load double, double* %l5
  %t103 = load i8*, i8** %l6
  br i1 %t97, label %then26, label %merge27
then26:
  %t104 = load double, double* %l5
  %t105 = sitofp i64 1 to double
  %t106 = fsub double %t104, %t105
  store double %t106, double* %l5
  br label %loop.latch20
merge27:
  br label %afterloop21
loop.latch20:
  %t107 = load double, double* %l5
  br label %loop.header18
afterloop21:
  %t109 = load double, double* %l5
  %t110 = load double, double* %l5
  %t111 = load double, double* %l3
  %t112 = fcmp oeq double %t110, %t111
  %t113 = load i8*, i8** %l0
  %t114 = load double, double* %l1
  %t115 = load double, double* %l2
  %t116 = load double, double* %l3
  %t117 = load double, double* %l5
  br i1 %t112, label %then28, label %merge29
then28:
  %t118 = load double, double* %l2
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  store double %t120, double* %l1
  br label %loop.latch4
merge29:
  %t121 = load i8*, i8** %l0
  %t122 = load double, double* %l5
  %t123 = load double, double* %l3
  %t124 = call double @llvm.round.f64(double %t122)
  %t125 = fptosi double %t124 to i64
  %t126 = call double @llvm.round.f64(double %t123)
  %t127 = fptosi double %t126 to i64
  %t128 = call i8* @sailfin_runtime_substring(i8* %t121, i64 %t125, i64 %t127)
  store i8* %t128, i8** %l7
  %t129 = load i8*, i8** %l7
  %t130 = call i1 @is_struct_literal_type_candidate(i8* %t129)
  %t131 = xor i1 %t130, 1
  %t132 = load i8*, i8** %l0
  %t133 = load double, double* %l1
  %t134 = load double, double* %l2
  %t135 = load double, double* %l3
  %t136 = load double, double* %l5
  %t137 = load i8*, i8** %l7
  br i1 %t131, label %then30, label %merge31
then30:
  %t138 = load double, double* %l2
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l1
  br label %loop.latch4
merge31:
  %t141 = load double, double* %l5
  %t142 = sitofp i64 0 to double
  %t143 = fcmp ogt double %t141, %t142
  %t144 = load i8*, i8** %l0
  %t145 = load double, double* %l1
  %t146 = load double, double* %l2
  %t147 = load double, double* %l3
  %t148 = load double, double* %l5
  %t149 = load i8*, i8** %l7
  br i1 %t143, label %then32, label %merge33
then32:
  %t150 = load i8*, i8** %l0
  %t151 = load double, double* %l5
  %t152 = sitofp i64 1 to double
  %t153 = fsub double %t151, %t152
  %t154 = load double, double* %l5
  %t155 = call double @llvm.round.f64(double %t153)
  %t156 = fptosi double %t155 to i64
  %t157 = call double @llvm.round.f64(double %t154)
  %t158 = fptosi double %t157 to i64
  %t159 = call i8* @sailfin_runtime_substring(i8* %t150, i64 %t156, i64 %t158)
  store i8* %t159, i8** %l8
  %t161 = load i8*, i8** %l8
  %t162 = call i1 @is_identifier_char(i8* %t161)
  br label %logical_or_entry_160

logical_or_entry_160:
  br i1 %t162, label %logical_or_merge_160, label %logical_or_right_160

logical_or_right_160:
  %t163 = load i8*, i8** %l8
  %t164 = load i8, i8* %t163
  %t165 = icmp eq i8 %t164, 46
  br label %logical_or_right_end_160

logical_or_right_end_160:
  br label %logical_or_merge_160

logical_or_merge_160:
  %t166 = phi i1 [ true, %logical_or_entry_160 ], [ %t165, %logical_or_right_end_160 ]
  %t167 = load i8*, i8** %l0
  %t168 = load double, double* %l1
  %t169 = load double, double* %l2
  %t170 = load double, double* %l3
  %t171 = load double, double* %l5
  %t172 = load i8*, i8** %l7
  %t173 = load i8*, i8** %l8
  br i1 %t166, label %then34, label %merge35
then34:
  %t174 = load double, double* %l2
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l1
  br label %loop.latch4
merge35:
  %t177 = load double, double* %l1
  br label %merge33
merge33:
  %t178 = phi double [ %t177, %merge35 ], [ %t145, %merge31 ]
  store double %t178, double* %l1
  %t179 = load i8*, i8** %l0
  %t180 = load double, double* %l2
  %t181 = call double @find_matching_brace(i8* %t179, double %t180)
  store double %t181, double* %l9
  %t182 = load double, double* %l9
  %t183 = sitofp i64 0 to double
  %t184 = fcmp olt double %t182, %t183
  %t185 = load i8*, i8** %l0
  %t186 = load double, double* %l1
  %t187 = load double, double* %l2
  %t188 = load double, double* %l3
  %t189 = load double, double* %l5
  %t190 = load i8*, i8** %l7
  %t191 = load double, double* %l9
  br i1 %t184, label %then36, label %merge37
then36:
  br label %afterloop5
merge37:
  %t192 = load i8*, i8** %l0
  %t193 = load double, double* %l5
  %t194 = load double, double* %l9
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  %t197 = call double @llvm.round.f64(double %t193)
  %t198 = fptosi double %t197 to i64
  %t199 = call double @llvm.round.f64(double %t196)
  %t200 = fptosi double %t199 to i64
  %t201 = call i8* @sailfin_runtime_substring(i8* %t192, i64 %t198, i64 %t200)
  store i8* %t201, i8** %l10
  %t202 = load i8*, i8** %l10
  %t203 = sitofp i64 1 to double
  %t204 = fadd double %depth, %t203
  %t205 = call i8* @lower_struct_literal_expression(i8* %t202, double %t204)
  store i8* %t205, i8** %l11
  %t206 = load i8*, i8** %l11
  %t207 = icmp eq i8* %t206, null
  %t208 = load i8*, i8** %l0
  %t209 = load double, double* %l1
  %t210 = load double, double* %l2
  %t211 = load double, double* %l3
  %t212 = load double, double* %l5
  %t213 = load i8*, i8** %l7
  %t214 = load double, double* %l9
  %t215 = load i8*, i8** %l10
  %t216 = load i8*, i8** %l11
  br i1 %t207, label %then38, label %merge39
then38:
  %t217 = load double, double* %l9
  %t218 = sitofp i64 1 to double
  %t219 = fadd double %t217, %t218
  store double %t219, double* %l1
  br label %loop.latch4
merge39:
  %t220 = load i8*, i8** %l0
  %t221 = load double, double* %l5
  %t222 = call double @llvm.round.f64(double %t221)
  %t223 = fptosi double %t222 to i64
  %t224 = call i8* @sailfin_runtime_substring(i8* %t220, i64 0, i64 %t223)
  store i8* %t224, i8** %l12
  %t225 = load i8*, i8** %l0
  %t226 = load double, double* %l9
  %t227 = sitofp i64 1 to double
  %t228 = fadd double %t226, %t227
  %t229 = load i8*, i8** %l0
  %t230 = call i64 @sailfin_runtime_string_length(i8* %t229)
  %t231 = call double @llvm.round.f64(double %t228)
  %t232 = fptosi double %t231 to i64
  %t233 = call i8* @sailfin_runtime_substring(i8* %t225, i64 %t232, i64 %t230)
  store i8* %t233, i8** %l13
  %t234 = load i8*, i8** %l12
  %t235 = load i8*, i8** %l11
  %t236 = call i8* @sailfin_runtime_string_concat(i8* %t234, i8* %t235)
  %t237 = load i8*, i8** %l13
  %t238 = call i8* @sailfin_runtime_string_concat(i8* %t236, i8* %t237)
  store i8* %t238, i8** %l0
  %t239 = load double, double* %l5
  %t240 = load i8*, i8** %l11
  %t241 = call i64 @sailfin_runtime_string_length(i8* %t240)
  %t242 = sitofp i64 %t241 to double
  %t243 = fadd double %t239, %t242
  store double %t243, double* %l1
  br label %loop.latch4
loop.latch4:
  %t244 = load double, double* %l1
  %t245 = load i8*, i8** %l0
  br label %loop.header2
afterloop5:
  %t248 = load double, double* %l1
  %t249 = load i8*, i8** %l0
  %t250 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t250)
  ret i8* %t250
}

define %StructLiteralCapture @capture_struct_literal_expression(i8* %initial, { %NativeInstruction*, i64 }* %instructions, double %start_index) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca %NativeInstruction
  %l6 = alloca i8*
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %initial)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 123, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  %t5 = call i1 @ends_with(i8* %t1, i8* %t3)
  %t6 = xor i1 %t5, 1
  %t7 = load i8*, i8** %l0
  br i1 %t6, label %then0, label %merge1
then0:
  %t8 = load i8*, i8** %l0
  %t9 = insertvalue %StructLiteralCapture undef, i8* %t8, 0
  %t10 = sitofp i64 0 to double
  %t11 = insertvalue %StructLiteralCapture %t9, double %t10, 1
  %t12 = insertvalue %StructLiteralCapture %t11, i1 0, 2
  ret %StructLiteralCapture %t12
merge1:
  %t13 = load i8*, i8** %l0
  store i8* %t13, i8** %l1
  store double %start_index, double* %l2
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l3
  %t15 = load i8*, i8** %l0
  %t16 = call double @compute_brace_balance(i8* %t15)
  store double %t16, double* %l4
  %t17 = load double, double* %l4
  %t18 = sitofp i64 0 to double
  %t19 = fcmp ole double %t17, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load i8*, i8** %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  %t24 = load double, double* %l4
  br i1 %t19, label %then2, label %merge3
then2:
  %t25 = load i8*, i8** %l0
  %t26 = insertvalue %StructLiteralCapture undef, i8* %t25, 0
  %t27 = sitofp i64 0 to double
  %t28 = insertvalue %StructLiteralCapture %t26, double %t27, 1
  %t29 = insertvalue %StructLiteralCapture %t28, i1 0, 2
  ret %StructLiteralCapture %t29
merge3:
  %t30 = load i8*, i8** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t171 = phi i8* [ %t31, %merge3 ], [ %t167, %loop.latch6 ]
  %t172 = phi double [ %t34, %merge3 ], [ %t168, %loop.latch6 ]
  %t173 = phi double [ %t33, %merge3 ], [ %t169, %loop.latch6 ]
  %t174 = phi double [ %t32, %merge3 ], [ %t170, %loop.latch6 ]
  store i8* %t171, i8** %l1
  store double %t172, double* %l4
  store double %t173, double* %l3
  store double %t174, double* %l2
  br label %loop.body5
loop.body5:
  %t35 = load double, double* %l2
  %t36 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t37 = extractvalue { %NativeInstruction*, i64 } %t36, 1
  %t38 = sitofp i64 %t37 to double
  %t39 = fcmp oge double %t35, %t38
  %t40 = load i8*, i8** %l0
  %t41 = load i8*, i8** %l1
  %t42 = load double, double* %l2
  %t43 = load double, double* %l3
  %t44 = load double, double* %l4
  br i1 %t39, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t45 = load double, double* %l2
  %t46 = call double @llvm.round.f64(double %t45)
  %t47 = fptosi double %t46 to i64
  %t48 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t49 = extractvalue { %NativeInstruction*, i64 } %t48, 0
  %t50 = extractvalue { %NativeInstruction*, i64 } %t48, 1
  %t51 = icmp uge i64 %t47, %t50
  ; bounds check: %t51 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t47, i64 %t50)
  %t52 = getelementptr %NativeInstruction, %NativeInstruction* %t49, i64 %t47
  %t53 = load %NativeInstruction, %NativeInstruction* %t52
  store %NativeInstruction %t53, %NativeInstruction* %l5
  %t54 = load %NativeInstruction, %NativeInstruction* %l5
  %t55 = extractvalue %NativeInstruction %t54, 0
  %t56 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t57 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t58 = icmp eq i32 %t55, 0
  %t59 = select i1 %t58, i8* %t57, i8* %t56
  %t60 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t61 = icmp eq i32 %t55, 1
  %t62 = select i1 %t61, i8* %t60, i8* %t59
  %t63 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t64 = icmp eq i32 %t55, 2
  %t65 = select i1 %t64, i8* %t63, i8* %t62
  %t66 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t55, 3
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t55, 4
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t55, 5
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t55, 6
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t55, 7
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t55, 8
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t55, 9
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t55, 10
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t55, 11
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t55, 12
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t55, 13
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t55, 14
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t55, 15
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t55, 16
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = call i8* @malloc(i64 8)
  %t109 = bitcast i8* %t108 to [8 x i8]*
  store [8 x i8] c"Unknown\00", [8 x i8]* %t109
  %t110 = call i1 @strings_equal(i8* %t107, i8* %t108)
  %t111 = xor i1 %t110, true
  %t112 = load i8*, i8** %l0
  %t113 = load i8*, i8** %l1
  %t114 = load double, double* %l2
  %t115 = load double, double* %l3
  %t116 = load double, double* %l4
  %t117 = load %NativeInstruction, %NativeInstruction* %l5
  br i1 %t111, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t118 = load %NativeInstruction, %NativeInstruction* %l5
  %t119 = extractvalue %NativeInstruction %t118, 0
  %t120 = alloca %NativeInstruction
  store %NativeInstruction %t118, %NativeInstruction* %t120
  %t121 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t120, i32 0, i32 1
  %t122 = bitcast [8 x i8]* %t121 to i8*
  %t123 = bitcast i8* %t122 to i8**
  %t124 = load i8*, i8** %t123
  %t125 = icmp eq i32 %t119, 16
  %t126 = select i1 %t125, i8* %t124, i8* null
  %t127 = call i8* @trim_text(i8* %t126)
  store i8* %t127, i8** %l6
  %t128 = load i8*, i8** %l6
  %t129 = call i64 @sailfin_runtime_string_length(i8* %t128)
  %t130 = icmp sgt i64 %t129, 0
  %t131 = load i8*, i8** %l0
  %t132 = load i8*, i8** %l1
  %t133 = load double, double* %l2
  %t134 = load double, double* %l3
  %t135 = load double, double* %l4
  %t136 = load %NativeInstruction, %NativeInstruction* %l5
  %t137 = load i8*, i8** %l6
  br i1 %t130, label %then12, label %merge13
then12:
  %t138 = load i8*, i8** %l1
  %t139 = add i64 0, 2
  %t140 = call i8* @malloc(i64 %t139)
  store i8 32, i8* %t140
  %t141 = getelementptr i8, i8* %t140, i64 1
  store i8 0, i8* %t141
  call void @sailfin_runtime_mark_persistent(i8* %t140)
  %t142 = call i8* @sailfin_runtime_string_concat(i8* %t138, i8* %t140)
  %t143 = load i8*, i8** %l6
  %t144 = call i8* @sailfin_runtime_string_concat(i8* %t142, i8* %t143)
  store i8* %t144, i8** %l1
  %t145 = load i8*, i8** %l1
  br label %merge13
merge13:
  %t146 = phi i8* [ %t145, %then12 ], [ %t132, %merge11 ]
  store i8* %t146, i8** %l1
  %t147 = load double, double* %l4
  %t148 = load i8*, i8** %l6
  %t149 = call double @compute_brace_balance(i8* %t148)
  %t150 = fadd double %t147, %t149
  store double %t150, double* %l4
  %t151 = load double, double* %l3
  %t152 = sitofp i64 1 to double
  %t153 = fadd double %t151, %t152
  store double %t153, double* %l3
  %t154 = load double, double* %l2
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %t154, %t155
  store double %t156, double* %l2
  %t157 = load double, double* %l4
  %t158 = sitofp i64 0 to double
  %t159 = fcmp ole double %t157, %t158
  %t160 = load i8*, i8** %l0
  %t161 = load i8*, i8** %l1
  %t162 = load double, double* %l2
  %t163 = load double, double* %l3
  %t164 = load double, double* %l4
  %t165 = load %NativeInstruction, %NativeInstruction* %l5
  %t166 = load i8*, i8** %l6
  br i1 %t159, label %then14, label %merge15
then14:
  br label %afterloop7
merge15:
  br label %loop.latch6
loop.latch6:
  %t167 = load i8*, i8** %l1
  %t168 = load double, double* %l4
  %t169 = load double, double* %l3
  %t170 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t175 = load i8*, i8** %l1
  %t176 = load double, double* %l4
  %t177 = load double, double* %l3
  %t178 = load double, double* %l2
  %t179 = load double, double* %l4
  %t180 = sitofp i64 0 to double
  %t181 = fcmp une double %t179, %t180
  %t182 = load i8*, i8** %l0
  %t183 = load i8*, i8** %l1
  %t184 = load double, double* %l2
  %t185 = load double, double* %l3
  %t186 = load double, double* %l4
  br i1 %t181, label %then16, label %merge17
then16:
  %t187 = load i8*, i8** %l0
  %t188 = insertvalue %StructLiteralCapture undef, i8* %t187, 0
  %t189 = sitofp i64 0 to double
  %t190 = insertvalue %StructLiteralCapture %t188, double %t189, 1
  %t191 = insertvalue %StructLiteralCapture %t190, i1 0, 2
  ret %StructLiteralCapture %t191
merge17:
  %t192 = load double, double* %l3
  %t193 = sitofp i64 0 to double
  %t194 = fcmp oeq double %t192, %t193
  %t195 = load i8*, i8** %l0
  %t196 = load i8*, i8** %l1
  %t197 = load double, double* %l2
  %t198 = load double, double* %l3
  %t199 = load double, double* %l4
  br i1 %t194, label %then18, label %merge19
then18:
  %t200 = load i8*, i8** %l0
  %t201 = insertvalue %StructLiteralCapture undef, i8* %t200, 0
  %t202 = sitofp i64 0 to double
  %t203 = insertvalue %StructLiteralCapture %t201, double %t202, 1
  %t204 = insertvalue %StructLiteralCapture %t203, i1 0, 2
  ret %StructLiteralCapture %t204
merge19:
  %t205 = load i8*, i8** %l1
  %t206 = call i8* @trim_text(i8* %t205)
  %t207 = call i8* @trim_trailing_delimiters(i8* %t206)
  store i8* %t207, i8** %l7
  %t208 = load i8*, i8** %l7
  %t209 = add i64 0, 2
  %t210 = call i8* @malloc(i64 %t209)
  store i8 125, i8* %t210
  %t211 = getelementptr i8, i8* %t210, i64 1
  store i8 0, i8* %t211
  call void @sailfin_runtime_mark_persistent(i8* %t210)
  %t212 = call i1 @ends_with(i8* %t208, i8* %t210)
  %t213 = xor i1 %t212, 1
  %t214 = load i8*, i8** %l0
  %t215 = load i8*, i8** %l1
  %t216 = load double, double* %l2
  %t217 = load double, double* %l3
  %t218 = load double, double* %l4
  %t219 = load i8*, i8** %l7
  br i1 %t213, label %then20, label %merge21
then20:
  %t220 = load i8*, i8** %l0
  %t221 = insertvalue %StructLiteralCapture undef, i8* %t220, 0
  %t222 = sitofp i64 0 to double
  %t223 = insertvalue %StructLiteralCapture %t221, double %t222, 1
  %t224 = insertvalue %StructLiteralCapture %t223, i1 0, 2
  ret %StructLiteralCapture %t224
merge21:
  %t225 = load i8*, i8** %l7
  %t226 = insertvalue %StructLiteralCapture undef, i8* %t225, 0
  %t227 = load double, double* %l3
  %t228 = insertvalue %StructLiteralCapture %t226, double %t227, 1
  %t229 = insertvalue %StructLiteralCapture %t228, i1 1, 2
  ret %StructLiteralCapture %t229
}

define i8* @rewrite_expression_intrinsics(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %expression)
  ret i8* %expression
merge1:
  store i8* %expression, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i8* @rewrite_literal_tokens(i8* %t2)
  store i8* %t3, i8** %l0
  %t4 = load i8*, i8** %l0
  %t5 = call i8* @rewrite_logical_operators(i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = call i8* @rewrite_push_calls(i8* %t6)
  store i8* %t7, i8** %l0
  %t8 = load i8*, i8** %l0
  %t9 = call i8* @rewrite_concat_calls(i8* %t8)
  store i8* %t9, i8** %l0
  %t10 = load i8*, i8** %l0
  %t11 = call i8* @rewrite_length_accesses(i8* %t10)
  store i8* %t11, i8** %l0
  %t12 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t12)
  ret i8* %t12
}

define i8* @rewrite_logical_operators(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %expression)
  ret i8* %expression
merge1:
  %t2 = call i8* @malloc(i64 1)
  %t3 = bitcast i8* %t2 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t3
  store i8* %t2, i8** %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t200 = phi i8* [ %t5, %merge1 ], [ %t198, %loop.latch4 ]
  %t201 = phi double [ %t6, %merge1 ], [ %t199, %loop.latch4 ]
  store i8* %t200, i8** %l0
  store double %t201, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  %t17 = call double @llvm.round.f64(double %t13)
  %t18 = fptosi double %t17 to i64
  %t19 = call double @llvm.round.f64(double %t16)
  %t20 = fptosi double %t19 to i64
  %t21 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t18, i64 %t20)
  store i8* %t21, i8** %l2
  %t23 = load i8*, i8** %l2
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 39
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t25, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %t26 = load i8*, i8** %l2
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 34
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t29 = phi i1 [ true, %logical_or_entry_22 ], [ %t28, %logical_or_right_end_22 ]
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then8, label %merge9
then8:
  %t33 = load double, double* %l1
  %t34 = call double @skip_string_literal(i8* %expression, double %t33)
  store double %t34, double* %l3
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  %t37 = load double, double* %l3
  %t38 = call double @llvm.round.f64(double %t36)
  %t39 = fptosi double %t38 to i64
  %t40 = call double @llvm.round.f64(double %t37)
  %t41 = fptosi double %t40 to i64
  %t42 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t39, i64 %t41)
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t42)
  store i8* %t43, i8** %l0
  %t44 = load double, double* %l3
  store double %t44, double* %l1
  br label %loop.latch4
merge9:
  %t45 = load i8*, i8** %l2
  %t46 = load i8, i8* %t45
  %t47 = icmp eq i8 %t46, 38
  %t48 = load i8*, i8** %l0
  %t49 = load double, double* %l1
  %t50 = load i8*, i8** %l2
  br i1 %t47, label %then10, label %merge11
then10:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  %t54 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t55 = sitofp i64 %t54 to double
  %t56 = fcmp olt double %t53, %t55
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l1
  %t59 = load i8*, i8** %l2
  br i1 %t56, label %then12, label %merge13
then12:
  %t60 = load double, double* %l1
  %t61 = sitofp i64 1 to double
  %t62 = fadd double %t60, %t61
  %t63 = load double, double* %l1
  %t64 = sitofp i64 2 to double
  %t65 = fadd double %t63, %t64
  %t66 = call double @llvm.round.f64(double %t62)
  %t67 = fptosi double %t66 to i64
  %t68 = call double @llvm.round.f64(double %t65)
  %t69 = fptosi double %t68 to i64
  %t70 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t67, i64 %t69)
  store i8* %t70, i8** %l4
  %t71 = load i8*, i8** %l4
  %t72 = load i8, i8* %t71
  %t73 = icmp eq i8 %t72, 38
  %t74 = load i8*, i8** %l0
  %t75 = load double, double* %l1
  %t76 = load i8*, i8** %l2
  %t77 = load i8*, i8** %l4
  br i1 %t73, label %then14, label %merge15
then14:
  %t78 = load i8*, i8** %l0
  %t79 = call i8* @malloc(i64 6)
  %t80 = bitcast i8* %t79 to [6 x i8]*
  store [6 x i8] c" and \00", [6 x i8]* %t80
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %t78, i8* %t79)
  store i8* %t81, i8** %l0
  %t82 = load double, double* %l1
  %t83 = sitofp i64 2 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l1
  br label %loop.latch4
merge15:
  %t85 = load i8*, i8** %l0
  %t86 = load double, double* %l1
  br label %merge13
merge13:
  %t87 = phi i8* [ %t85, %merge15 ], [ %t57, %then10 ]
  %t88 = phi double [ %t86, %merge15 ], [ %t58, %then10 ]
  store i8* %t87, i8** %l0
  store double %t88, double* %l1
  %t89 = load i8*, i8** %l0
  %t90 = load double, double* %l1
  br label %merge11
merge11:
  %t91 = phi i8* [ %t89, %merge13 ], [ %t48, %merge9 ]
  %t92 = phi double [ %t90, %merge13 ], [ %t49, %merge9 ]
  store i8* %t91, i8** %l0
  store double %t92, double* %l1
  %t93 = load i8*, i8** %l2
  %t94 = load i8, i8* %t93
  %t95 = icmp eq i8 %t94, 124
  %t96 = load i8*, i8** %l0
  %t97 = load double, double* %l1
  %t98 = load i8*, i8** %l2
  br i1 %t95, label %then16, label %merge17
then16:
  %t99 = load double, double* %l1
  %t100 = sitofp i64 1 to double
  %t101 = fadd double %t99, %t100
  %t102 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t103 = sitofp i64 %t102 to double
  %t104 = fcmp olt double %t101, %t103
  %t105 = load i8*, i8** %l0
  %t106 = load double, double* %l1
  %t107 = load i8*, i8** %l2
  br i1 %t104, label %then18, label %merge19
then18:
  %t108 = load double, double* %l1
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  %t111 = load double, double* %l1
  %t112 = sitofp i64 2 to double
  %t113 = fadd double %t111, %t112
  %t114 = call double @llvm.round.f64(double %t110)
  %t115 = fptosi double %t114 to i64
  %t116 = call double @llvm.round.f64(double %t113)
  %t117 = fptosi double %t116 to i64
  %t118 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t115, i64 %t117)
  store i8* %t118, i8** %l5
  %t119 = load i8*, i8** %l5
  %t120 = load i8, i8* %t119
  %t121 = icmp eq i8 %t120, 124
  %t122 = load i8*, i8** %l0
  %t123 = load double, double* %l1
  %t124 = load i8*, i8** %l2
  %t125 = load i8*, i8** %l5
  br i1 %t121, label %then20, label %merge21
then20:
  %t126 = load i8*, i8** %l0
  %t127 = call i8* @malloc(i64 5)
  %t128 = bitcast i8* %t127 to [5 x i8]*
  store [5 x i8] c" or \00", [5 x i8]* %t128
  %t129 = call i8* @sailfin_runtime_string_concat(i8* %t126, i8* %t127)
  store i8* %t129, i8** %l0
  %t130 = load double, double* %l1
  %t131 = sitofp i64 2 to double
  %t132 = fadd double %t130, %t131
  store double %t132, double* %l1
  br label %loop.latch4
merge21:
  %t133 = load i8*, i8** %l0
  %t134 = load double, double* %l1
  br label %merge19
merge19:
  %t135 = phi i8* [ %t133, %merge21 ], [ %t105, %then16 ]
  %t136 = phi double [ %t134, %merge21 ], [ %t106, %then16 ]
  store i8* %t135, i8** %l0
  store double %t136, double* %l1
  %t137 = load i8*, i8** %l0
  %t138 = load double, double* %l1
  br label %merge17
merge17:
  %t139 = phi i8* [ %t137, %merge19 ], [ %t96, %merge11 ]
  %t140 = phi double [ %t138, %merge19 ], [ %t97, %merge11 ]
  store i8* %t139, i8** %l0
  store double %t140, double* %l1
  %t141 = load i8*, i8** %l2
  %t142 = load i8, i8* %t141
  %t143 = icmp eq i8 %t142, 33
  %t144 = load i8*, i8** %l0
  %t145 = load double, double* %l1
  %t146 = load i8*, i8** %l2
  br i1 %t143, label %then22, label %merge23
then22:
  %t147 = load double, double* %l1
  %t148 = sitofp i64 1 to double
  %t149 = fadd double %t147, %t148
  %t150 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t151 = sitofp i64 %t150 to double
  %t152 = fcmp olt double %t149, %t151
  %t153 = load i8*, i8** %l0
  %t154 = load double, double* %l1
  %t155 = load i8*, i8** %l2
  br i1 %t152, label %then24, label %merge25
then24:
  %t156 = load double, double* %l1
  %t157 = sitofp i64 1 to double
  %t158 = fadd double %t156, %t157
  %t159 = load double, double* %l1
  %t160 = sitofp i64 2 to double
  %t161 = fadd double %t159, %t160
  %t162 = call double @llvm.round.f64(double %t158)
  %t163 = fptosi double %t162 to i64
  %t164 = call double @llvm.round.f64(double %t161)
  %t165 = fptosi double %t164 to i64
  %t166 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t163, i64 %t165)
  store i8* %t166, i8** %l6
  %t167 = load i8*, i8** %l6
  %t168 = load i8, i8* %t167
  %t169 = icmp eq i8 %t168, 61
  %t170 = load i8*, i8** %l0
  %t171 = load double, double* %l1
  %t172 = load i8*, i8** %l2
  %t173 = load i8*, i8** %l6
  br i1 %t169, label %then26, label %merge27
then26:
  %t174 = load i8*, i8** %l0
  %t175 = call i8* @malloc(i64 3)
  %t176 = bitcast i8* %t175 to [3 x i8]*
  store [3 x i8] c"!=\00", [3 x i8]* %t176
  %t177 = call i8* @sailfin_runtime_string_concat(i8* %t174, i8* %t175)
  store i8* %t177, i8** %l0
  %t178 = load double, double* %l1
  %t179 = sitofp i64 2 to double
  %t180 = fadd double %t178, %t179
  store double %t180, double* %l1
  br label %loop.latch4
merge27:
  %t181 = load i8*, i8** %l0
  %t182 = load double, double* %l1
  br label %merge25
merge25:
  %t183 = phi i8* [ %t181, %merge27 ], [ %t153, %then22 ]
  %t184 = phi double [ %t182, %merge27 ], [ %t154, %then22 ]
  store i8* %t183, i8** %l0
  store double %t184, double* %l1
  %t185 = load i8*, i8** %l0
  %t186 = call i8* @malloc(i64 5)
  %t187 = bitcast i8* %t186 to [5 x i8]*
  store [5 x i8] c"not \00", [5 x i8]* %t187
  %t188 = call i8* @sailfin_runtime_string_concat(i8* %t185, i8* %t186)
  store i8* %t188, i8** %l0
  %t189 = load double, double* %l1
  %t190 = sitofp i64 1 to double
  %t191 = fadd double %t189, %t190
  store double %t191, double* %l1
  br label %loop.latch4
merge23:
  %t192 = load i8*, i8** %l0
  %t193 = load i8*, i8** %l2
  %t194 = call i8* @sailfin_runtime_string_concat(i8* %t192, i8* %t193)
  store i8* %t194, i8** %l0
  %t195 = load double, double* %l1
  %t196 = sitofp i64 1 to double
  %t197 = fadd double %t195, %t196
  store double %t197, double* %l1
  br label %loop.latch4
loop.latch4:
  %t198 = load i8*, i8** %l0
  %t199 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t202 = load i8*, i8** %l0
  %t203 = load double, double* %l1
  %t204 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t204)
  ret i8* %t204
}

define i8* @rewrite_literal_tokens(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %expression)
  ret i8* %expression
merge1:
  %t2 = call i8* @malloc(i64 1)
  %t3 = bitcast i8* %t2 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t3
  store i8* %t2, i8** %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t155 = phi i8* [ %t5, %merge1 ], [ %t153, %loop.latch4 ]
  %t156 = phi double [ %t6, %merge1 ], [ %t154, %loop.latch4 ]
  store i8* %t155, i8** %l0
  store double %t156, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = load double, double* %l1
  %t15 = sitofp i64 1 to double
  %t16 = fadd double %t14, %t15
  %t17 = call double @llvm.round.f64(double %t13)
  %t18 = fptosi double %t17 to i64
  %t19 = call double @llvm.round.f64(double %t16)
  %t20 = fptosi double %t19 to i64
  %t21 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t18, i64 %t20)
  store i8* %t21, i8** %l2
  %t23 = load i8*, i8** %l2
  %t24 = load i8, i8* %t23
  %t25 = icmp eq i8 %t24, 39
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t25, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %t26 = load i8*, i8** %l2
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 34
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t29 = phi i1 [ true, %logical_or_entry_22 ], [ %t28, %logical_or_right_end_22 ]
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then8, label %merge9
then8:
  %t33 = load double, double* %l1
  %t34 = call double @skip_string_literal(i8* %expression, double %t33)
  store double %t34, double* %l3
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  %t37 = load double, double* %l3
  %t38 = call double @llvm.round.f64(double %t36)
  %t39 = fptosi double %t38 to i64
  %t40 = call double @llvm.round.f64(double %t37)
  %t41 = fptosi double %t40 to i64
  %t42 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t39, i64 %t41)
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t42)
  store i8* %t43, i8** %l0
  %t44 = load double, double* %l3
  store double %t44, double* %l1
  br label %loop.latch4
merge9:
  %t45 = load i8*, i8** %l2
  %t46 = call i1 @is_identifier_char(i8* %t45)
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load i8*, i8** %l2
  br i1 %t46, label %then10, label %merge11
then10:
  %t50 = load double, double* %l1
  store double %t50, double* %l4
  %t51 = load i8*, i8** %l0
  %t52 = load double, double* %l1
  %t53 = load i8*, i8** %l2
  %t54 = load double, double* %l4
  br label %loop.header12
loop.header12:
  %t84 = phi double [ %t52, %then10 ], [ %t83, %loop.latch14 ]
  store double %t84, double* %l1
  br label %loop.body13
loop.body13:
  %t55 = load double, double* %l1
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l1
  %t58 = load double, double* %l1
  %t59 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t60 = sitofp i64 %t59 to double
  %t61 = fcmp oge double %t58, %t60
  %t62 = load i8*, i8** %l0
  %t63 = load double, double* %l1
  %t64 = load i8*, i8** %l2
  %t65 = load double, double* %l4
  br i1 %t61, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t66 = load double, double* %l1
  %t67 = load double, double* %l1
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  %t70 = call double @llvm.round.f64(double %t66)
  %t71 = fptosi double %t70 to i64
  %t72 = call double @llvm.round.f64(double %t69)
  %t73 = fptosi double %t72 to i64
  %t74 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t71, i64 %t73)
  store i8* %t74, i8** %l5
  %t75 = load i8*, i8** %l5
  %t76 = call i1 @is_identifier_char(i8* %t75)
  %t77 = xor i1 %t76, 1
  %t78 = load i8*, i8** %l0
  %t79 = load double, double* %l1
  %t80 = load i8*, i8** %l2
  %t81 = load double, double* %l4
  %t82 = load i8*, i8** %l5
  br i1 %t77, label %then18, label %merge19
then18:
  br label %afterloop15
merge19:
  br label %loop.latch14
loop.latch14:
  %t83 = load double, double* %l1
  br label %loop.header12
afterloop15:
  %t85 = load double, double* %l1
  %t86 = load double, double* %l4
  %t87 = load double, double* %l1
  %t88 = call double @llvm.round.f64(double %t86)
  %t89 = fptosi double %t88 to i64
  %t90 = call double @llvm.round.f64(double %t87)
  %t91 = fptosi double %t90 to i64
  %t92 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t89, i64 %t91)
  store i8* %t92, i8** %l6
  %t93 = load i8*, i8** %l6
  %t94 = call i8* @malloc(i64 5)
  %t95 = bitcast i8* %t94 to [5 x i8]*
  store [5 x i8] c"null\00", [5 x i8]* %t95
  %t96 = call i1 @strings_equal(i8* %t93, i8* %t94)
  %t97 = load i8*, i8** %l0
  %t98 = load double, double* %l1
  %t99 = load i8*, i8** %l2
  %t100 = load double, double* %l4
  %t101 = load i8*, i8** %l6
  br i1 %t96, label %then20, label %else21
then20:
  %t102 = load i8*, i8** %l0
  %t103 = call i8* @malloc(i64 5)
  %t104 = bitcast i8* %t103 to [5 x i8]*
  store [5 x i8] c"None\00", [5 x i8]* %t104
  %t105 = call i8* @sailfin_runtime_string_concat(i8* %t102, i8* %t103)
  store i8* %t105, i8** %l0
  %t106 = load i8*, i8** %l0
  br label %merge22
else21:
  %t107 = load i8*, i8** %l6
  %t108 = call i8* @malloc(i64 5)
  %t109 = bitcast i8* %t108 to [5 x i8]*
  store [5 x i8] c"true\00", [5 x i8]* %t109
  %t110 = call i1 @strings_equal(i8* %t107, i8* %t108)
  %t111 = load i8*, i8** %l0
  %t112 = load double, double* %l1
  %t113 = load i8*, i8** %l2
  %t114 = load double, double* %l4
  %t115 = load i8*, i8** %l6
  br i1 %t110, label %then23, label %else24
then23:
  %t116 = load i8*, i8** %l0
  %t117 = call i8* @malloc(i64 5)
  %t118 = bitcast i8* %t117 to [5 x i8]*
  store [5 x i8] c"True\00", [5 x i8]* %t118
  %t119 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %t117)
  store i8* %t119, i8** %l0
  %t120 = load i8*, i8** %l0
  br label %merge25
else24:
  %t121 = load i8*, i8** %l6
  %t122 = call i8* @malloc(i64 6)
  %t123 = bitcast i8* %t122 to [6 x i8]*
  store [6 x i8] c"false\00", [6 x i8]* %t123
  %t124 = call i1 @strings_equal(i8* %t121, i8* %t122)
  %t125 = load i8*, i8** %l0
  %t126 = load double, double* %l1
  %t127 = load i8*, i8** %l2
  %t128 = load double, double* %l4
  %t129 = load i8*, i8** %l6
  br i1 %t124, label %then26, label %else27
then26:
  %t130 = load i8*, i8** %l0
  %t131 = call i8* @malloc(i64 6)
  %t132 = bitcast i8* %t131 to [6 x i8]*
  store [6 x i8] c"False\00", [6 x i8]* %t132
  %t133 = call i8* @sailfin_runtime_string_concat(i8* %t130, i8* %t131)
  store i8* %t133, i8** %l0
  %t134 = load i8*, i8** %l0
  br label %merge28
else27:
  %t135 = load i8*, i8** %l0
  %t136 = load i8*, i8** %l6
  %t137 = call i8* @sailfin_runtime_string_concat(i8* %t135, i8* %t136)
  store i8* %t137, i8** %l0
  %t138 = load i8*, i8** %l0
  br label %merge28
merge28:
  %t139 = phi i8* [ %t134, %then26 ], [ %t138, %else27 ]
  store i8* %t139, i8** %l0
  %t140 = load i8*, i8** %l0
  %t141 = load i8*, i8** %l0
  br label %merge25
merge25:
  %t142 = phi i8* [ %t120, %then23 ], [ %t140, %merge28 ]
  store i8* %t142, i8** %l0
  %t143 = load i8*, i8** %l0
  %t144 = load i8*, i8** %l0
  %t145 = load i8*, i8** %l0
  br label %merge22
merge22:
  %t146 = phi i8* [ %t106, %then20 ], [ %t143, %merge25 ]
  store i8* %t146, i8** %l0
  br label %loop.latch4
merge11:
  %t147 = load i8*, i8** %l0
  %t148 = load i8*, i8** %l2
  %t149 = call i8* @sailfin_runtime_string_concat(i8* %t147, i8* %t148)
  store i8* %t149, i8** %l0
  %t150 = load double, double* %l1
  %t151 = sitofp i64 1 to double
  %t152 = fadd double %t150, %t151
  store double %t152, double* %l1
  br label %loop.latch4
loop.latch4:
  %t153 = load i8*, i8** %l0
  %t154 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t157 = load i8*, i8** %l0
  %t158 = load double, double* %l1
  %t159 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t159)
  ret i8* %t159
}

define i8* @rewrite_push_calls(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %expression)
  ret i8* %expression
merge1:
  %t2 = call i8* @malloc(i64 7)
  %t3 = bitcast i8* %t2 to [7 x i8]*
  store [7 x i8] c".push(\00", [7 x i8]* %t3
  store i8* %t2, i8** %l0
  %t4 = call i8* @malloc(i64 9)
  %t5 = bitcast i8* %t4 to [9 x i8]*
  store [9 x i8] c".append(\00", [9 x i8]* %t5
  store i8* %t4, i8** %l1
  %t6 = call i8* @malloc(i64 1)
  %t7 = bitcast i8* %t6 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t7
  store i8* %t6, i8** %l2
  %t8 = sitofp i64 0 to double
  store double %t8, double* %l3
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = load i8*, i8** %l2
  %t12 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t108 = phi i8* [ %t11, %merge1 ], [ %t106, %loop.latch4 ]
  %t109 = phi double [ %t12, %merge1 ], [ %t107, %loop.latch4 ]
  store i8* %t108, i8** %l2
  store double %t109, double* %l3
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l3
  %t14 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t15 = sitofp i64 %t14 to double
  %t16 = fcmp oge double %t13, %t15
  %t17 = load i8*, i8** %l0
  %t18 = load i8*, i8** %l1
  %t19 = load i8*, i8** %l2
  %t20 = load double, double* %l3
  br i1 %t16, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t21 = load double, double* %l3
  %t22 = load double, double* %l3
  %t23 = sitofp i64 1 to double
  %t24 = fadd double %t22, %t23
  %t25 = call double @llvm.round.f64(double %t21)
  %t26 = fptosi double %t25 to i64
  %t27 = call double @llvm.round.f64(double %t24)
  %t28 = fptosi double %t27 to i64
  %t29 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t26, i64 %t28)
  store i8* %t29, i8** %l4
  %t31 = load i8*, i8** %l4
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 39
  br label %logical_or_entry_30

logical_or_entry_30:
  br i1 %t33, label %logical_or_merge_30, label %logical_or_right_30

logical_or_right_30:
  %t34 = load i8*, i8** %l4
  %t35 = load i8, i8* %t34
  %t36 = icmp eq i8 %t35, 34
  br label %logical_or_right_end_30

logical_or_right_end_30:
  br label %logical_or_merge_30

logical_or_merge_30:
  %t37 = phi i1 [ true, %logical_or_entry_30 ], [ %t36, %logical_or_right_end_30 ]
  %t38 = load i8*, i8** %l0
  %t39 = load i8*, i8** %l1
  %t40 = load i8*, i8** %l2
  %t41 = load double, double* %l3
  %t42 = load i8*, i8** %l4
  br i1 %t37, label %then8, label %merge9
then8:
  %t43 = load double, double* %l3
  %t44 = call double @skip_string_literal(i8* %expression, double %t43)
  store double %t44, double* %l5
  %t45 = load i8*, i8** %l2
  %t46 = load double, double* %l3
  %t47 = load double, double* %l5
  %t48 = call double @llvm.round.f64(double %t46)
  %t49 = fptosi double %t48 to i64
  %t50 = call double @llvm.round.f64(double %t47)
  %t51 = fptosi double %t50 to i64
  %t52 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t49, i64 %t51)
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t52)
  store i8* %t53, i8** %l2
  %t54 = load double, double* %l5
  store double %t54, double* %l3
  br label %loop.latch4
merge9:
  %t55 = load double, double* %l3
  %t56 = load i8*, i8** %l0
  %t57 = call i64 @sailfin_runtime_string_length(i8* %t56)
  %t58 = sitofp i64 %t57 to double
  %t59 = fadd double %t55, %t58
  %t60 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t61 = sitofp i64 %t60 to double
  %t62 = fcmp ole double %t59, %t61
  %t63 = load i8*, i8** %l0
  %t64 = load i8*, i8** %l1
  %t65 = load i8*, i8** %l2
  %t66 = load double, double* %l3
  %t67 = load i8*, i8** %l4
  br i1 %t62, label %then10, label %merge11
then10:
  %t68 = load double, double* %l3
  %t69 = load double, double* %l3
  %t70 = load i8*, i8** %l0
  %t71 = call i64 @sailfin_runtime_string_length(i8* %t70)
  %t72 = sitofp i64 %t71 to double
  %t73 = fadd double %t69, %t72
  %t74 = call double @llvm.round.f64(double %t68)
  %t75 = fptosi double %t74 to i64
  %t76 = call double @llvm.round.f64(double %t73)
  %t77 = fptosi double %t76 to i64
  %t78 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t75, i64 %t77)
  store i8* %t78, i8** %l6
  %t79 = load i8*, i8** %l6
  %t80 = load i8*, i8** %l0
  %t81 = call i1 @strings_equal(i8* %t79, i8* %t80)
  %t82 = load i8*, i8** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load i8*, i8** %l2
  %t85 = load double, double* %l3
  %t86 = load i8*, i8** %l4
  %t87 = load i8*, i8** %l6
  br i1 %t81, label %then12, label %merge13
then12:
  %t88 = load i8*, i8** %l2
  %t89 = load i8*, i8** %l1
  %t90 = call i8* @sailfin_runtime_string_concat(i8* %t88, i8* %t89)
  store i8* %t90, i8** %l2
  %t91 = load double, double* %l3
  %t92 = load i8*, i8** %l0
  %t93 = call i64 @sailfin_runtime_string_length(i8* %t92)
  %t94 = sitofp i64 %t93 to double
  %t95 = fadd double %t91, %t94
  store double %t95, double* %l3
  br label %loop.latch4
merge13:
  %t96 = load i8*, i8** %l2
  %t97 = load double, double* %l3
  br label %merge11
merge11:
  %t98 = phi i8* [ %t96, %merge13 ], [ %t65, %merge9 ]
  %t99 = phi double [ %t97, %merge13 ], [ %t66, %merge9 ]
  store i8* %t98, i8** %l2
  store double %t99, double* %l3
  %t100 = load i8*, i8** %l2
  %t101 = load i8*, i8** %l4
  %t102 = call i8* @sailfin_runtime_string_concat(i8* %t100, i8* %t101)
  store i8* %t102, i8** %l2
  %t103 = load double, double* %l3
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l3
  br label %loop.latch4
loop.latch4:
  %t106 = load i8*, i8** %l2
  %t107 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t110 = load i8*, i8** %l2
  %t111 = load double, double* %l3
  %t112 = load i8*, i8** %l2
  call void @sailfin_runtime_mark_persistent(i8* %t112)
  ret i8* %t112
}

define i8* @rewrite_concat_calls(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca double
  %l4 = alloca %ExtractedSpan
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8*
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t73 = phi i8* [ %t0, %block.entry ], [ %t72, %loop.latch2 ]
  store i8* %t73, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %t2 = call i8* @malloc(i64 9)
  %t3 = bitcast i8* %t2 to [9 x i8]*
  store [9 x i8] c".concat(\00", [9 x i8]* %t3
  %t4 = call double @index_of(i8* %t1, i8* %t2)
  store double %t4, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  %t12 = call %ExtractedSpan @extract_object_span(i8* %t10, double %t11)
  store %ExtractedSpan %t12, %ExtractedSpan* %l2
  %t13 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t14 = extractvalue %ExtractedSpan %t13, 3
  %t15 = xor i1 %t14, 1
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = load %ExtractedSpan, %ExtractedSpan* %l2
  br i1 %t15, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t19 = load double, double* %l1
  %t20 = sitofp i64 7 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l3
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l3
  %t24 = call %ExtractedSpan @extract_parenthesized_span(i8* %t22, double %t23)
  store %ExtractedSpan %t24, %ExtractedSpan* %l4
  %t25 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t26 = extractvalue %ExtractedSpan %t25, 3
  %t27 = xor i1 %t26, 1
  %t28 = load i8*, i8** %l0
  %t29 = load double, double* %l1
  %t30 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t31 = load double, double* %l3
  %t32 = load %ExtractedSpan, %ExtractedSpan* %l4
  br i1 %t27, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t33 = load i8*, i8** %l0
  %t34 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t35 = extractvalue %ExtractedSpan %t34, 1
  %t36 = call double @llvm.round.f64(double %t35)
  %t37 = fptosi double %t36 to i64
  %t38 = call i8* @sailfin_runtime_substring(i8* %t33, i64 0, i64 %t37)
  store i8* %t38, i8** %l5
  %t39 = load i8*, i8** %l0
  %t40 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t41 = extractvalue %ExtractedSpan %t40, 2
  %t42 = load i8*, i8** %l0
  %t43 = call i64 @sailfin_runtime_string_length(i8* %t42)
  %t44 = call double @llvm.round.f64(double %t41)
  %t45 = fptosi double %t44 to i64
  %t46 = call i8* @sailfin_runtime_substring(i8* %t39, i64 %t45, i64 %t43)
  store i8* %t46, i8** %l6
  %t47 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t48 = extractvalue %ExtractedSpan %t47, 0
  %t49 = call i8* @trim_text(i8* %t48)
  store i8* %t49, i8** %l7
  %t50 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t51 = extractvalue %ExtractedSpan %t50, 0
  %t52 = call i8* @trim_text(i8* %t51)
  store i8* %t52, i8** %l8
  %t53 = load i8*, i8** %l7
  %t54 = add i64 0, 2
  %t55 = call i8* @malloc(i64 %t54)
  store i8 40, i8* %t55
  %t56 = getelementptr i8, i8* %t55, i64 1
  store i8 0, i8* %t56
  call void @sailfin_runtime_mark_persistent(i8* %t55)
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t53)
  %t58 = call i8* @malloc(i64 6)
  %t59 = bitcast i8* %t58 to [6 x i8]*
  store [6 x i8] c") + (\00", [6 x i8]* %t59
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %t58)
  %t61 = load i8*, i8** %l8
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %t61)
  %t63 = add i64 0, 2
  %t64 = call i8* @malloc(i64 %t63)
  store i8 41, i8* %t64
  %t65 = getelementptr i8, i8* %t64, i64 1
  store i8 0, i8* %t65
  call void @sailfin_runtime_mark_persistent(i8* %t64)
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t64)
  store i8* %t66, i8** %l9
  %t67 = load i8*, i8** %l5
  %t68 = load i8*, i8** %l9
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %t68)
  %t70 = load i8*, i8** %l6
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t70)
  store i8* %t71, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t72 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t74 = load i8*, i8** %l0
  %t75 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t75)
  ret i8* %t75
}

define i8* @rewrite_length_accesses(i8* %expression) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca %ExtractedSpan
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  store i8* %expression, i8** %l0
  %t0 = load i8*, i8** %l0
  br label %loop.header0
loop.header0:
  %t59 = phi i8* [ %t0, %block.entry ], [ %t58, %loop.latch2 ]
  store i8* %t59, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %t2 = call i8* @malloc(i64 8)
  %t3 = bitcast i8* %t2 to [8 x i8]*
  store [8 x i8] c".length\00", [8 x i8]* %t3
  %t4 = call double @index_of(i8* %t1, i8* %t2)
  store double %t4, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  %t12 = call %ExtractedSpan @extract_object_span(i8* %t10, double %t11)
  store %ExtractedSpan %t12, %ExtractedSpan* %l2
  %t13 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t14 = extractvalue %ExtractedSpan %t13, 3
  %t15 = xor i1 %t14, 1
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  %t18 = load %ExtractedSpan, %ExtractedSpan* %l2
  br i1 %t15, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t19 = load i8*, i8** %l0
  %t20 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t21 = extractvalue %ExtractedSpan %t20, 1
  %t22 = call double @llvm.round.f64(double %t21)
  %t23 = fptosi double %t22 to i64
  %t24 = call i8* @sailfin_runtime_substring(i8* %t19, i64 0, i64 %t23)
  store i8* %t24, i8** %l3
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = sitofp i64 7 to double
  %t28 = fadd double %t26, %t27
  %t29 = load i8*, i8** %l0
  %t30 = call i64 @sailfin_runtime_string_length(i8* %t29)
  %t31 = call double @llvm.round.f64(double %t28)
  %t32 = fptosi double %t31 to i64
  %t33 = call i8* @sailfin_runtime_substring(i8* %t25, i64 %t32, i64 %t30)
  store i8* %t33, i8** %l4
  %t34 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t35 = extractvalue %ExtractedSpan %t34, 0
  %t36 = call i8* @trim_text(i8* %t35)
  store i8* %t36, i8** %l5
  %t37 = load i8*, i8** %l5
  %t38 = call i64 @sailfin_runtime_string_length(i8* %t37)
  %t39 = icmp eq i64 %t38, 0
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t43 = load i8*, i8** %l3
  %t44 = load i8*, i8** %l4
  %t45 = load i8*, i8** %l5
  br i1 %t39, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t46 = load i8*, i8** %l3
  %t47 = call i8* @malloc(i64 5)
  %t48 = bitcast i8* %t47 to [5 x i8]*
  store [5 x i8] c"len(\00", [5 x i8]* %t48
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t47)
  %t50 = load i8*, i8** %l5
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t49, i8* %t50)
  %t52 = add i64 0, 2
  %t53 = call i8* @malloc(i64 %t52)
  store i8 41, i8* %t53
  %t54 = getelementptr i8, i8* %t53, i64 1
  store i8 0, i8* %t54
  call void @sailfin_runtime_mark_persistent(i8* %t53)
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %t53)
  %t56 = load i8*, i8** %l4
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t56)
  store i8* %t57, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t58 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t60 = load i8*, i8** %l0
  %t61 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  ret i8* %t61
}

define %ExtractedSpan @extract_object_span(i8* %text, double %dot_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %dot_index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i8* @malloc(i64 1)
  %t3 = bitcast i8* %t2 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t3
  %t4 = insertvalue %ExtractedSpan undef, i8* %t2, 0
  %t5 = sitofp i64 0 to double
  %t6 = insertvalue %ExtractedSpan %t4, double %t5, 1
  %t7 = sitofp i64 0 to double
  %t8 = insertvalue %ExtractedSpan %t6, double %t7, 2
  %t9 = insertvalue %ExtractedSpan %t8, i1 0, 3
  ret %ExtractedSpan %t9
merge1:
  %t10 = sitofp i64 1 to double
  %t11 = fsub double %dot_index, %t10
  store double %t11, double* %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t130 = phi double [ %t15, %merge1 ], [ %t127, %loop.latch4 ]
  %t131 = phi double [ %t14, %merge1 ], [ %t128, %loop.latch4 ]
  %t132 = phi double [ %t16, %merge1 ], [ %t129, %loop.latch4 ]
  store double %t130, double* %l1
  store double %t131, double* %l0
  store double %t132, double* %l2
  br label %loop.body3
loop.body3:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 0 to double
  %t19 = fcmp olt double %t17, %t18
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  br i1 %t19, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t23 = load double, double* %l0
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  %t27 = call double @llvm.round.f64(double %t23)
  %t28 = fptosi double %t27 to i64
  %t29 = call double @llvm.round.f64(double %t26)
  %t30 = fptosi double %t29 to i64
  %t31 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t28, i64 %t30)
  store i8* %t31, i8** %l3
  %t32 = load i8*, i8** %l3
  %t33 = load i8, i8* %t32
  %t34 = icmp eq i8 %t33, 93
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  %t37 = load double, double* %l2
  %t38 = load i8*, i8** %l3
  br i1 %t34, label %then8, label %merge9
then8:
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  %t42 = load double, double* %l0
  %t43 = sitofp i64 1 to double
  %t44 = fsub double %t42, %t43
  store double %t44, double* %l0
  br label %loop.latch4
merge9:
  %t45 = load i8*, i8** %l3
  %t46 = load i8, i8* %t45
  %t47 = icmp eq i8 %t46, 91
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  %t51 = load i8*, i8** %l3
  br i1 %t47, label %then10, label %merge11
then10:
  %t52 = load double, double* %l1
  %t53 = sitofp i64 0 to double
  %t54 = fcmp ogt double %t52, %t53
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  %t58 = load i8*, i8** %l3
  br i1 %t54, label %then12, label %merge13
then12:
  %t59 = load double, double* %l1
  %t60 = sitofp i64 1 to double
  %t61 = fsub double %t59, %t60
  store double %t61, double* %l1
  %t62 = load double, double* %l0
  %t63 = sitofp i64 1 to double
  %t64 = fsub double %t62, %t63
  store double %t64, double* %l0
  br label %loop.latch4
merge13:
  br label %afterloop5
merge11:
  %t65 = load i8*, i8** %l3
  %t66 = load i8, i8* %t65
  %t67 = icmp eq i8 %t66, 41
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  %t70 = load double, double* %l2
  %t71 = load i8*, i8** %l3
  br i1 %t67, label %then14, label %merge15
then14:
  %t72 = load double, double* %l2
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  store double %t74, double* %l2
  %t75 = load double, double* %l0
  %t76 = sitofp i64 1 to double
  %t77 = fsub double %t75, %t76
  store double %t77, double* %l0
  br label %loop.latch4
merge15:
  %t78 = load i8*, i8** %l3
  %t79 = load i8, i8* %t78
  %t80 = icmp eq i8 %t79, 40
  %t81 = load double, double* %l0
  %t82 = load double, double* %l1
  %t83 = load double, double* %l2
  %t84 = load i8*, i8** %l3
  br i1 %t80, label %then16, label %merge17
then16:
  %t85 = load double, double* %l2
  %t86 = sitofp i64 0 to double
  %t87 = fcmp ogt double %t85, %t86
  %t88 = load double, double* %l0
  %t89 = load double, double* %l1
  %t90 = load double, double* %l2
  %t91 = load i8*, i8** %l3
  br i1 %t87, label %then18, label %merge19
then18:
  %t92 = load double, double* %l2
  %t93 = sitofp i64 1 to double
  %t94 = fsub double %t92, %t93
  store double %t94, double* %l2
  %t95 = load double, double* %l0
  %t96 = sitofp i64 1 to double
  %t97 = fsub double %t95, %t96
  store double %t97, double* %l0
  br label %loop.latch4
merge19:
  br label %afterloop5
merge17:
  %t99 = load double, double* %l1
  %t100 = sitofp i64 0 to double
  %t101 = fcmp ogt double %t99, %t100
  br label %logical_or_entry_98

logical_or_entry_98:
  br i1 %t101, label %logical_or_merge_98, label %logical_or_right_98

logical_or_right_98:
  %t102 = load double, double* %l2
  %t103 = sitofp i64 0 to double
  %t104 = fcmp ogt double %t102, %t103
  br label %logical_or_right_end_98

logical_or_right_end_98:
  br label %logical_or_merge_98

logical_or_merge_98:
  %t105 = phi i1 [ true, %logical_or_entry_98 ], [ %t104, %logical_or_right_end_98 ]
  %t106 = load double, double* %l0
  %t107 = load double, double* %l1
  %t108 = load double, double* %l2
  %t109 = load i8*, i8** %l3
  br i1 %t105, label %then20, label %merge21
then20:
  %t110 = load double, double* %l0
  %t111 = sitofp i64 1 to double
  %t112 = fsub double %t110, %t111
  store double %t112, double* %l0
  br label %loop.latch4
merge21:
  %t114 = load i8*, i8** %l3
  %t115 = call i1 @is_identifier_char(i8* %t114)
  br label %logical_or_entry_113

logical_or_entry_113:
  br i1 %t115, label %logical_or_merge_113, label %logical_or_right_113

logical_or_right_113:
  %t116 = load i8*, i8** %l3
  %t117 = load i8, i8* %t116
  %t118 = icmp eq i8 %t117, 46
  br label %logical_or_right_end_113

logical_or_right_end_113:
  br label %logical_or_merge_113

logical_or_merge_113:
  %t119 = phi i1 [ true, %logical_or_entry_113 ], [ %t118, %logical_or_right_end_113 ]
  %t120 = load double, double* %l0
  %t121 = load double, double* %l1
  %t122 = load double, double* %l2
  %t123 = load i8*, i8** %l3
  br i1 %t119, label %then22, label %merge23
then22:
  %t124 = load double, double* %l0
  %t125 = sitofp i64 1 to double
  %t126 = fsub double %t124, %t125
  store double %t126, double* %l0
  br label %loop.latch4
merge23:
  br label %afterloop5
loop.latch4:
  %t127 = load double, double* %l1
  %t128 = load double, double* %l0
  %t129 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t133 = load double, double* %l1
  %t134 = load double, double* %l0
  %t135 = load double, double* %l2
  %t136 = load double, double* %l0
  %t137 = sitofp i64 1 to double
  %t138 = fadd double %t136, %t137
  store double %t138, double* %l4
  %t139 = load double, double* %l4
  %t140 = fcmp oge double %t139, %dot_index
  %t141 = load double, double* %l0
  %t142 = load double, double* %l1
  %t143 = load double, double* %l2
  %t144 = load double, double* %l4
  br i1 %t140, label %then24, label %merge25
then24:
  %t145 = call i8* @malloc(i64 1)
  %t146 = bitcast i8* %t145 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t146
  %t147 = insertvalue %ExtractedSpan undef, i8* %t145, 0
  %t148 = load double, double* %l4
  %t149 = insertvalue %ExtractedSpan %t147, double %t148, 1
  %t150 = insertvalue %ExtractedSpan %t149, double %dot_index, 2
  %t151 = insertvalue %ExtractedSpan %t150, i1 0, 3
  ret %ExtractedSpan %t151
merge25:
  %t152 = load double, double* %l4
  %t153 = call double @llvm.round.f64(double %t152)
  %t154 = fptosi double %t153 to i64
  %t155 = call double @llvm.round.f64(double %dot_index)
  %t156 = fptosi double %t155 to i64
  %t157 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t154, i64 %t156)
  store i8* %t157, i8** %l5
  %t158 = load i8*, i8** %l5
  %t159 = insertvalue %ExtractedSpan undef, i8* %t158, 0
  %t160 = load double, double* %l4
  %t161 = insertvalue %ExtractedSpan %t159, double %t160, 1
  %t162 = insertvalue %ExtractedSpan %t161, double %dot_index, 2
  %t163 = insertvalue %ExtractedSpan %t162, i1 1, 3
  ret %ExtractedSpan %t163
}

define %ExtractedSpan @extract_parenthesized_span(i8* %text, double %open_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = sitofp i64 %t0 to double
  %t2 = fcmp oge double %open_index, %t1
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  %t5 = insertvalue %ExtractedSpan undef, i8* %t3, 0
  %t6 = insertvalue %ExtractedSpan %t5, double %open_index, 1
  %t7 = insertvalue %ExtractedSpan %t6, double %open_index, 2
  %t8 = insertvalue %ExtractedSpan %t7, i1 0, 3
  ret %ExtractedSpan %t8
merge1:
  %t9 = sitofp i64 1 to double
  %t10 = fadd double %open_index, %t9
  %t11 = call double @llvm.round.f64(double %open_index)
  %t12 = fptosi double %t11 to i64
  %t13 = call double @llvm.round.f64(double %t10)
  %t14 = fptosi double %t13 to i64
  %t15 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t12, i64 %t14)
  %t16 = load i8, i8* %t15
  %t17 = icmp ne i8 %t16, 40
  br i1 %t17, label %then2, label %merge3
then2:
  %t18 = call i8* @malloc(i64 1)
  %t19 = bitcast i8* %t18 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t19
  %t20 = insertvalue %ExtractedSpan undef, i8* %t18, 0
  %t21 = insertvalue %ExtractedSpan %t20, double %open_index, 1
  %t22 = insertvalue %ExtractedSpan %t21, double %open_index, 2
  %t23 = insertvalue %ExtractedSpan %t22, i1 0, 3
  ret %ExtractedSpan %t23
merge3:
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %open_index, %t24
  store double %t25, double* %l0
  %t26 = sitofp i64 1 to double
  store double %t26, double* %l1
  %t27 = load double, double* %l0
  %t28 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t113 = phi double [ %t28, %merge3 ], [ %t111, %loop.latch6 ]
  %t114 = phi double [ %t27, %merge3 ], [ %t112, %loop.latch6 ]
  store double %t113, double* %l1
  store double %t114, double* %l0
  br label %loop.body5
loop.body5:
  %t29 = load double, double* %l0
  %t30 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t31 = sitofp i64 %t30 to double
  %t32 = fcmp oge double %t29, %t31
  %t33 = load double, double* %l0
  %t34 = load double, double* %l1
  br i1 %t32, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t35 = load double, double* %l0
  %t36 = load double, double* %l0
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  %t39 = call double @llvm.round.f64(double %t35)
  %t40 = fptosi double %t39 to i64
  %t41 = call double @llvm.round.f64(double %t38)
  %t42 = fptosi double %t41 to i64
  %t43 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t40, i64 %t42)
  store i8* %t43, i8** %l2
  %t44 = load i8*, i8** %l2
  %t45 = load i8, i8* %t44
  %t46 = icmp eq i8 %t45, 40
  %t47 = load double, double* %l0
  %t48 = load double, double* %l1
  %t49 = load i8*, i8** %l2
  br i1 %t46, label %then10, label %else11
then10:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l1
  %t53 = load double, double* %l1
  br label %merge12
else11:
  %t54 = load i8*, i8** %l2
  %t55 = load i8, i8* %t54
  %t56 = icmp eq i8 %t55, 41
  %t57 = load double, double* %l0
  %t58 = load double, double* %l1
  %t59 = load i8*, i8** %l2
  br i1 %t56, label %then13, label %else14
then13:
  %t60 = load double, double* %l1
  %t61 = sitofp i64 1 to double
  %t62 = fsub double %t60, %t61
  store double %t62, double* %l1
  %t63 = load double, double* %l1
  %t64 = sitofp i64 0 to double
  %t65 = fcmp oeq double %t63, %t64
  %t66 = load double, double* %l0
  %t67 = load double, double* %l1
  %t68 = load i8*, i8** %l2
  br i1 %t65, label %then16, label %merge17
then16:
  %t69 = sitofp i64 1 to double
  %t70 = fadd double %open_index, %t69
  %t71 = load double, double* %l0
  %t72 = call double @llvm.round.f64(double %t70)
  %t73 = fptosi double %t72 to i64
  %t74 = call double @llvm.round.f64(double %t71)
  %t75 = fptosi double %t74 to i64
  %t76 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t73, i64 %t75)
  store i8* %t76, i8** %l3
  %t77 = load i8*, i8** %l3
  %t78 = insertvalue %ExtractedSpan undef, i8* %t77, 0
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %open_index, %t79
  %t81 = insertvalue %ExtractedSpan %t78, double %t80, 1
  %t82 = load double, double* %l0
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  %t85 = insertvalue %ExtractedSpan %t81, double %t84, 2
  %t86 = insertvalue %ExtractedSpan %t85, i1 1, 3
  ret %ExtractedSpan %t86
merge17:
  %t87 = load double, double* %l1
  br label %merge15
else14:
  %t89 = load i8*, i8** %l2
  %t90 = load i8, i8* %t89
  %t91 = icmp eq i8 %t90, 34
  br label %logical_or_entry_88

logical_or_entry_88:
  br i1 %t91, label %logical_or_merge_88, label %logical_or_right_88

logical_or_right_88:
  %t92 = load i8*, i8** %l2
  %t93 = load i8, i8* %t92
  %t94 = icmp eq i8 %t93, 39
  br label %logical_or_right_end_88

logical_or_right_end_88:
  br label %logical_or_merge_88

logical_or_merge_88:
  %t95 = phi i1 [ true, %logical_or_entry_88 ], [ %t94, %logical_or_right_end_88 ]
  %t96 = load double, double* %l0
  %t97 = load double, double* %l1
  %t98 = load i8*, i8** %l2
  br i1 %t95, label %then18, label %merge19
then18:
  %t99 = load double, double* %l0
  %t100 = call double @skip_string_literal(i8* %text, double %t99)
  store double %t100, double* %l0
  br label %loop.latch6
merge19:
  %t101 = load double, double* %l0
  br label %merge15
merge15:
  %t102 = phi double [ %t87, %merge17 ], [ %t58, %merge19 ]
  %t103 = phi double [ %t57, %merge17 ], [ %t101, %merge19 ]
  store double %t102, double* %l1
  store double %t103, double* %l0
  %t104 = load double, double* %l1
  %t105 = load double, double* %l0
  br label %merge12
merge12:
  %t106 = phi double [ %t53, %then10 ], [ %t104, %merge15 ]
  %t107 = phi double [ %t47, %then10 ], [ %t105, %merge15 ]
  store double %t106, double* %l1
  store double %t107, double* %l0
  %t108 = load double, double* %l0
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  store double %t110, double* %l0
  br label %loop.latch6
loop.latch6:
  %t111 = load double, double* %l1
  %t112 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t115 = load double, double* %l1
  %t116 = load double, double* %l0
  %t117 = call i8* @malloc(i64 1)
  %t118 = bitcast i8* %t117 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t118
  %t119 = insertvalue %ExtractedSpan undef, i8* %t117, 0
  %t120 = insertvalue %ExtractedSpan %t119, double %open_index, 1
  %t121 = insertvalue %ExtractedSpan %t120, double %open_index, 2
  %t122 = insertvalue %ExtractedSpan %t121, i1 0, 3
  ret %ExtractedSpan %t122
}

define double @skip_string_literal(i8* %text, double %quote_index) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = sitofp i64 1 to double
  %t1 = fadd double %quote_index, %t0
  %t2 = call double @llvm.round.f64(double %quote_index)
  %t3 = fptosi double %t2 to i64
  %t4 = call double @llvm.round.f64(double %t1)
  %t5 = fptosi double %t4 to i64
  %t6 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t3, i64 %t5)
  store i8* %t6, i8** %l0
  %t7 = sitofp i64 1 to double
  %t8 = fadd double %quote_index, %t7
  store double %t8, double* %l1
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t48 = phi double [ %t10, %block.entry ], [ %t47, %loop.latch2 ]
  store double %t48, double* %l1
  br label %loop.body1
loop.body1:
  %t11 = load double, double* %l1
  %t12 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t13 = sitofp i64 %t12 to double
  %t14 = fcmp oge double %t11, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t17 = load double, double* %l1
  %t18 = load double, double* %l1
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  %t21 = call double @llvm.round.f64(double %t17)
  %t22 = fptosi double %t21 to i64
  %t23 = call double @llvm.round.f64(double %t20)
  %t24 = fptosi double %t23 to i64
  %t25 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t22, i64 %t24)
  store i8* %t25, i8** %l2
  %t26 = load i8*, i8** %l2
  %t27 = load i8, i8* %t26
  %t28 = icmp eq i8 %t27, 92
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then6, label %merge7
then6:
  %t32 = load double, double* %l1
  %t33 = sitofp i64 2 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch2
merge7:
  %t35 = load i8*, i8** %l2
  %t36 = load i8*, i8** %l0
  %t37 = call i1 @strings_equal(i8* %t35, i8* %t36)
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  %t40 = load i8*, i8** %l2
  br i1 %t37, label %then8, label %merge9
then8:
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %afterloop3
merge9:
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch2
loop.latch2:
  %t47 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t49 = load double, double* %l1
  %t50 = load double, double* %l1
  ret double %t50
}

define %ExpressionContinuationCapture @capture_expression_continuation(i8* %initial, { %NativeInstruction*, i64 }* %instructions, double %start_index) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i1
  %l8 = alloca i8*
  %l9 = alloca i8*
  %l10 = alloca i1
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca i8*
  %t0 = call i8* @trim_text(i8* %initial)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = insertvalue %ExpressionContinuationCapture undef, i8* %t5, 0
  %t7 = sitofp i64 0 to double
  %t8 = insertvalue %ExpressionContinuationCapture %t6, double %t7, 1
  %t9 = insertvalue %ExpressionContinuationCapture %t8, i1 0, 2
  ret %ExpressionContinuationCapture %t9
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = call double @compute_parenthesis_balance(i8* %t10)
  store double %t11, double* %l1
  %t12 = load i8*, i8** %l0
  %t13 = call double @compute_brace_balance(i8* %t12)
  store double %t13, double* %l2
  %t14 = load i8*, i8** %l0
  %t15 = call double @compute_bracket_balance(i8* %t14)
  store double %t15, double* %l3
  %t16 = load i8*, i8** %l0
  store i8* %t16, i8** %l4
  store double %start_index, double* %l5
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l6
  %t19 = load double, double* %l1
  %t20 = sitofp i64 0 to double
  %t21 = fcmp ogt double %t19, %t20
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t21, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t23 = load double, double* %l2
  %t24 = sitofp i64 0 to double
  %t25 = fcmp ogt double %t23, %t24
  br label %logical_or_entry_22

logical_or_entry_22:
  br i1 %t25, label %logical_or_merge_22, label %logical_or_right_22

logical_or_right_22:
  %t26 = load double, double* %l3
  %t27 = sitofp i64 0 to double
  %t28 = fcmp ogt double %t26, %t27
  br label %logical_or_right_end_22

logical_or_right_end_22:
  br label %logical_or_merge_22

logical_or_merge_22:
  %t29 = phi i1 [ true, %logical_or_entry_22 ], [ %t28, %logical_or_right_end_22 ]
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t30 = phi i1 [ true, %logical_or_entry_18 ], [ %t29, %logical_or_right_end_18 ]
  store i1 %t30, i1* %l7
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load double, double* %l2
  %t34 = load double, double* %l3
  %t35 = load i8*, i8** %l4
  %t36 = load double, double* %l5
  %t37 = load double, double* %l6
  %t38 = load i1, i1* %l7
  br label %loop.header2
loop.header2:
  %t298 = phi double [ %t36, %logical_or_merge_18 ], [ %t291, %loop.latch4 ]
  %t299 = phi double [ %t37, %logical_or_merge_18 ], [ %t292, %loop.latch4 ]
  %t300 = phi i1 [ %t38, %logical_or_merge_18 ], [ %t293, %loop.latch4 ]
  %t301 = phi i8* [ %t35, %logical_or_merge_18 ], [ %t294, %loop.latch4 ]
  %t302 = phi double [ %t32, %logical_or_merge_18 ], [ %t295, %loop.latch4 ]
  %t303 = phi double [ %t33, %logical_or_merge_18 ], [ %t296, %loop.latch4 ]
  %t304 = phi double [ %t34, %logical_or_merge_18 ], [ %t297, %loop.latch4 ]
  store double %t298, double* %l5
  store double %t299, double* %l6
  store i1 %t300, i1* %l7
  store i8* %t301, i8** %l4
  store double %t302, double* %l1
  store double %t303, double* %l2
  store double %t304, double* %l3
  br label %loop.body3
loop.body3:
  %t39 = load double, double* %l5
  %t40 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t41 = extractvalue { %NativeInstruction*, i64 } %t40, 1
  %t42 = sitofp i64 %t41 to double
  %t43 = fcmp oge double %t39, %t42
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l1
  %t46 = load double, double* %l2
  %t47 = load double, double* %l3
  %t48 = load i8*, i8** %l4
  %t49 = load double, double* %l5
  %t50 = load double, double* %l6
  %t51 = load i1, i1* %l7
  br i1 %t43, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t52 = load double, double* %l5
  %t53 = call double @llvm.round.f64(double %t52)
  %t54 = fptosi double %t53 to i64
  %t55 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t56 = extractvalue { %NativeInstruction*, i64 } %t55, 0
  %t57 = extractvalue { %NativeInstruction*, i64 } %t55, 1
  %t58 = icmp uge i64 %t54, %t57
  ; bounds check: %t58 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t54, i64 %t57)
  %t59 = getelementptr %NativeInstruction, %NativeInstruction* %t56, i64 %t54
  %t60 = load %NativeInstruction, %NativeInstruction* %t59
  %t61 = call i8* @continuation_segment_text(%NativeInstruction %t60)
  store i8* %t61, i8** %l8
  %t62 = load i8*, i8** %l8
  %t63 = icmp eq i8* %t62, null
  %t64 = load i8*, i8** %l0
  %t65 = load double, double* %l1
  %t66 = load double, double* %l2
  %t67 = load double, double* %l3
  %t68 = load i8*, i8** %l4
  %t69 = load double, double* %l5
  %t70 = load double, double* %l6
  %t71 = load i1, i1* %l7
  %t72 = load i8*, i8** %l8
  br i1 %t63, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t73 = load i8*, i8** %l8
  %t74 = call i8* @trim_text(i8* %t73)
  store i8* %t74, i8** %l9
  %t75 = load i8*, i8** %l9
  %t76 = call i64 @sailfin_runtime_string_length(i8* %t75)
  %t77 = icmp eq i64 %t76, 0
  %t78 = load i8*, i8** %l0
  %t79 = load double, double* %l1
  %t80 = load double, double* %l2
  %t81 = load double, double* %l3
  %t82 = load i8*, i8** %l4
  %t83 = load double, double* %l5
  %t84 = load double, double* %l6
  %t85 = load i1, i1* %l7
  %t86 = load i8*, i8** %l8
  %t87 = load i8*, i8** %l9
  br i1 %t77, label %then10, label %merge11
then10:
  %t88 = load double, double* %l5
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l5
  %t91 = load double, double* %l6
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  store double %t93, double* %l6
  br label %loop.latch4
merge11:
  %t94 = load i1, i1* %l7
  %t95 = xor i1 %t94, 1
  %t96 = load i8*, i8** %l0
  %t97 = load double, double* %l1
  %t98 = load double, double* %l2
  %t99 = load double, double* %l3
  %t100 = load i8*, i8** %l4
  %t101 = load double, double* %l5
  %t102 = load double, double* %l6
  %t103 = load i1, i1* %l7
  %t104 = load i8*, i8** %l8
  %t105 = load i8*, i8** %l9
  br i1 %t95, label %then12, label %merge13
then12:
  %t106 = load i8*, i8** %l9
  %t107 = call i1 @segment_signals_expression_continuation(i8* %t106)
  %t108 = xor i1 %t107, 1
  %t109 = load i8*, i8** %l0
  %t110 = load double, double* %l1
  %t111 = load double, double* %l2
  %t112 = load double, double* %l3
  %t113 = load i8*, i8** %l4
  %t114 = load double, double* %l5
  %t115 = load double, double* %l6
  %t116 = load i1, i1* %l7
  %t117 = load i8*, i8** %l8
  %t118 = load i8*, i8** %l9
  br i1 %t108, label %then14, label %merge15
then14:
  br label %afterloop5
merge15:
  store i1 1, i1* %l7
  %t119 = load i1, i1* %l7
  br label %merge13
merge13:
  %t120 = phi i1 [ %t119, %merge15 ], [ %t103, %merge11 ]
  store i1 %t120, i1* %l7
  %t121 = load i8*, i8** %l4
  %t122 = add i64 0, 2
  %t123 = call i8* @malloc(i64 %t122)
  store i8 32, i8* %t123
  %t124 = getelementptr i8, i8* %t123, i64 1
  store i8 0, i8* %t124
  call void @sailfin_runtime_mark_persistent(i8* %t123)
  %t125 = call i8* @sailfin_runtime_string_concat(i8* %t121, i8* %t123)
  %t126 = load i8*, i8** %l9
  %t127 = call i8* @sailfin_runtime_string_concat(i8* %t125, i8* %t126)
  store i8* %t127, i8** %l4
  %t128 = load double, double* %l1
  %t129 = load i8*, i8** %l9
  %t130 = call double @compute_parenthesis_balance(i8* %t129)
  %t131 = fadd double %t128, %t130
  store double %t131, double* %l1
  %t132 = load double, double* %l2
  %t133 = load i8*, i8** %l9
  %t134 = call double @compute_brace_balance(i8* %t133)
  %t135 = fadd double %t132, %t134
  store double %t135, double* %l2
  %t136 = load double, double* %l3
  %t137 = load i8*, i8** %l9
  %t138 = call double @compute_bracket_balance(i8* %t137)
  %t139 = fadd double %t136, %t138
  store double %t139, double* %l3
  %t140 = load double, double* %l6
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l6
  %t143 = load double, double* %l5
  %t144 = sitofp i64 1 to double
  %t145 = fadd double %t143, %t144
  store double %t145, double* %l5
  %t147 = load double, double* %l1
  %t148 = sitofp i64 0 to double
  %t149 = fcmp ole double %t147, %t148
  br label %logical_and_entry_146

logical_and_entry_146:
  br i1 %t149, label %logical_and_right_146, label %logical_and_merge_146

logical_and_right_146:
  %t151 = load double, double* %l2
  %t152 = sitofp i64 0 to double
  %t153 = fcmp ole double %t151, %t152
  br label %logical_and_entry_150

logical_and_entry_150:
  br i1 %t153, label %logical_and_right_150, label %logical_and_merge_150

logical_and_right_150:
  %t154 = load double, double* %l3
  %t155 = sitofp i64 0 to double
  %t156 = fcmp ole double %t154, %t155
  br label %logical_and_right_end_150

logical_and_right_end_150:
  br label %logical_and_merge_150

logical_and_merge_150:
  %t157 = phi i1 [ false, %logical_and_entry_150 ], [ %t156, %logical_and_right_end_150 ]
  br label %logical_and_right_end_146

logical_and_right_end_146:
  br label %logical_and_merge_146

logical_and_merge_146:
  %t158 = phi i1 [ false, %logical_and_entry_146 ], [ %t157, %logical_and_right_end_146 ]
  %t159 = load i8*, i8** %l0
  %t160 = load double, double* %l1
  %t161 = load double, double* %l2
  %t162 = load double, double* %l3
  %t163 = load i8*, i8** %l4
  %t164 = load double, double* %l5
  %t165 = load double, double* %l6
  %t166 = load i1, i1* %l7
  %t167 = load i8*, i8** %l8
  %t168 = load i8*, i8** %l9
  br i1 %t158, label %then16, label %merge17
then16:
  store i1 1, i1* %l10
  %t169 = load double, double* %l5
  store double %t169, double* %l11
  %t170 = load i8*, i8** %l0
  %t171 = load double, double* %l1
  %t172 = load double, double* %l2
  %t173 = load double, double* %l3
  %t174 = load i8*, i8** %l4
  %t175 = load double, double* %l5
  %t176 = load double, double* %l6
  %t177 = load i1, i1* %l7
  %t178 = load i8*, i8** %l8
  %t179 = load i8*, i8** %l9
  %t180 = load i1, i1* %l10
  %t181 = load double, double* %l11
  br label %loop.header18
loop.header18:
  %t266 = phi double [ %t181, %then16 ], [ %t264, %loop.latch20 ]
  %t267 = phi i1 [ %t180, %then16 ], [ %t265, %loop.latch20 ]
  store double %t266, double* %l11
  store i1 %t267, i1* %l10
  br label %loop.body19
loop.body19:
  %t182 = load double, double* %l11
  %t183 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t184 = extractvalue { %NativeInstruction*, i64 } %t183, 1
  %t185 = sitofp i64 %t184 to double
  %t186 = fcmp oge double %t182, %t185
  %t187 = load i8*, i8** %l0
  %t188 = load double, double* %l1
  %t189 = load double, double* %l2
  %t190 = load double, double* %l3
  %t191 = load i8*, i8** %l4
  %t192 = load double, double* %l5
  %t193 = load double, double* %l6
  %t194 = load i1, i1* %l7
  %t195 = load i8*, i8** %l8
  %t196 = load i8*, i8** %l9
  %t197 = load i1, i1* %l10
  %t198 = load double, double* %l11
  br i1 %t186, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t199 = load double, double* %l11
  %t200 = call double @llvm.round.f64(double %t199)
  %t201 = fptosi double %t200 to i64
  %t202 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t203 = extractvalue { %NativeInstruction*, i64 } %t202, 0
  %t204 = extractvalue { %NativeInstruction*, i64 } %t202, 1
  %t205 = icmp uge i64 %t201, %t204
  ; bounds check: %t205 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t201, i64 %t204)
  %t206 = getelementptr %NativeInstruction, %NativeInstruction* %t203, i64 %t201
  %t207 = load %NativeInstruction, %NativeInstruction* %t206
  %t208 = call i8* @continuation_segment_text(%NativeInstruction %t207)
  store i8* %t208, i8** %l12
  %t209 = load i8*, i8** %l12
  %t210 = icmp eq i8* %t209, null
  %t211 = load i8*, i8** %l0
  %t212 = load double, double* %l1
  %t213 = load double, double* %l2
  %t214 = load double, double* %l3
  %t215 = load i8*, i8** %l4
  %t216 = load double, double* %l5
  %t217 = load double, double* %l6
  %t218 = load i1, i1* %l7
  %t219 = load i8*, i8** %l8
  %t220 = load i8*, i8** %l9
  %t221 = load i1, i1* %l10
  %t222 = load double, double* %l11
  %t223 = load i8*, i8** %l12
  br i1 %t210, label %then24, label %merge25
then24:
  br label %afterloop21
merge25:
  %t224 = load i8*, i8** %l12
  %t225 = call i8* @trim_text(i8* %t224)
  store i8* %t225, i8** %l13
  %t226 = load i8*, i8** %l13
  %t227 = call i64 @sailfin_runtime_string_length(i8* %t226)
  %t228 = icmp eq i64 %t227, 0
  %t229 = load i8*, i8** %l0
  %t230 = load double, double* %l1
  %t231 = load double, double* %l2
  %t232 = load double, double* %l3
  %t233 = load i8*, i8** %l4
  %t234 = load double, double* %l5
  %t235 = load double, double* %l6
  %t236 = load i1, i1* %l7
  %t237 = load i8*, i8** %l8
  %t238 = load i8*, i8** %l9
  %t239 = load i1, i1* %l10
  %t240 = load double, double* %l11
  %t241 = load i8*, i8** %l12
  %t242 = load i8*, i8** %l13
  br i1 %t228, label %then26, label %merge27
then26:
  %t243 = load double, double* %l11
  %t244 = sitofp i64 1 to double
  %t245 = fadd double %t243, %t244
  store double %t245, double* %l11
  br label %loop.latch20
merge27:
  %t246 = load i8*, i8** %l13
  %t247 = call i1 @segment_signals_expression_continuation(i8* %t246)
  %t248 = load i8*, i8** %l0
  %t249 = load double, double* %l1
  %t250 = load double, double* %l2
  %t251 = load double, double* %l3
  %t252 = load i8*, i8** %l4
  %t253 = load double, double* %l5
  %t254 = load double, double* %l6
  %t255 = load i1, i1* %l7
  %t256 = load i8*, i8** %l8
  %t257 = load i8*, i8** %l9
  %t258 = load i1, i1* %l10
  %t259 = load double, double* %l11
  %t260 = load i8*, i8** %l12
  %t261 = load i8*, i8** %l13
  br i1 %t247, label %then28, label %merge29
then28:
  store i1 0, i1* %l10
  %t262 = load i1, i1* %l10
  br label %merge29
merge29:
  %t263 = phi i1 [ %t262, %then28 ], [ %t258, %merge27 ]
  store i1 %t263, i1* %l10
  br label %afterloop21
loop.latch20:
  %t264 = load double, double* %l11
  %t265 = load i1, i1* %l10
  br label %loop.header18
afterloop21:
  %t268 = load double, double* %l11
  %t269 = load i1, i1* %l10
  %t270 = load i1, i1* %l10
  %t271 = load i8*, i8** %l0
  %t272 = load double, double* %l1
  %t273 = load double, double* %l2
  %t274 = load double, double* %l3
  %t275 = load i8*, i8** %l4
  %t276 = load double, double* %l5
  %t277 = load double, double* %l6
  %t278 = load i1, i1* %l7
  %t279 = load i8*, i8** %l8
  %t280 = load i8*, i8** %l9
  %t281 = load i1, i1* %l10
  %t282 = load double, double* %l11
  br i1 %t270, label %then30, label %merge31
then30:
  %t283 = load i8*, i8** %l4
  %t284 = call i8* @trim_text(i8* %t283)
  %t285 = call i8* @trim_trailing_delimiters(i8* %t284)
  store i8* %t285, i8** %l14
  %t286 = load i8*, i8** %l14
  %t287 = insertvalue %ExpressionContinuationCapture undef, i8* %t286, 0
  %t288 = load double, double* %l6
  %t289 = insertvalue %ExpressionContinuationCapture %t287, double %t288, 1
  %t290 = insertvalue %ExpressionContinuationCapture %t289, i1 1, 2
  ret %ExpressionContinuationCapture %t290
merge31:
  br label %merge17
merge17:
  br label %loop.latch4
loop.latch4:
  %t291 = load double, double* %l5
  %t292 = load double, double* %l6
  %t293 = load i1, i1* %l7
  %t294 = load i8*, i8** %l4
  %t295 = load double, double* %l1
  %t296 = load double, double* %l2
  %t297 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t305 = load double, double* %l5
  %t306 = load double, double* %l6
  %t307 = load i1, i1* %l7
  %t308 = load i8*, i8** %l4
  %t309 = load double, double* %l1
  %t310 = load double, double* %l2
  %t311 = load double, double* %l3
  %t313 = load i1, i1* %l7
  %t314 = xor i1 %t313, 1
  br label %logical_or_entry_312

logical_or_entry_312:
  br i1 %t314, label %logical_or_merge_312, label %logical_or_right_312

logical_or_right_312:
  %t315 = load double, double* %l6
  %t316 = sitofp i64 0 to double
  %t317 = fcmp oeq double %t315, %t316
  br label %logical_or_right_end_312

logical_or_right_end_312:
  br label %logical_or_merge_312

logical_or_merge_312:
  %t318 = phi i1 [ true, %logical_or_entry_312 ], [ %t317, %logical_or_right_end_312 ]
  %t319 = load i8*, i8** %l0
  %t320 = load double, double* %l1
  %t321 = load double, double* %l2
  %t322 = load double, double* %l3
  %t323 = load i8*, i8** %l4
  %t324 = load double, double* %l5
  %t325 = load double, double* %l6
  %t326 = load i1, i1* %l7
  br i1 %t318, label %then32, label %merge33
then32:
  %t327 = load i8*, i8** %l0
  %t328 = insertvalue %ExpressionContinuationCapture undef, i8* %t327, 0
  %t329 = sitofp i64 0 to double
  %t330 = insertvalue %ExpressionContinuationCapture %t328, double %t329, 1
  %t331 = insertvalue %ExpressionContinuationCapture %t330, i1 0, 2
  ret %ExpressionContinuationCapture %t331
merge33:
  %t333 = load double, double* %l1
  %t334 = sitofp i64 0 to double
  %t335 = fcmp ole double %t333, %t334
  br label %logical_and_entry_332

logical_and_entry_332:
  br i1 %t335, label %logical_and_right_332, label %logical_and_merge_332

logical_and_right_332:
  %t337 = load double, double* %l2
  %t338 = sitofp i64 0 to double
  %t339 = fcmp ole double %t337, %t338
  br label %logical_and_entry_336

logical_and_entry_336:
  br i1 %t339, label %logical_and_right_336, label %logical_and_merge_336

logical_and_right_336:
  %t340 = load double, double* %l3
  %t341 = sitofp i64 0 to double
  %t342 = fcmp ole double %t340, %t341
  br label %logical_and_right_end_336

logical_and_right_end_336:
  br label %logical_and_merge_336

logical_and_merge_336:
  %t343 = phi i1 [ false, %logical_and_entry_336 ], [ %t342, %logical_and_right_end_336 ]
  br label %logical_and_right_end_332

logical_and_right_end_332:
  br label %logical_and_merge_332

logical_and_merge_332:
  %t344 = phi i1 [ false, %logical_and_entry_332 ], [ %t343, %logical_and_right_end_332 ]
  %t345 = load i8*, i8** %l0
  %t346 = load double, double* %l1
  %t347 = load double, double* %l2
  %t348 = load double, double* %l3
  %t349 = load i8*, i8** %l4
  %t350 = load double, double* %l5
  %t351 = load double, double* %l6
  %t352 = load i1, i1* %l7
  br i1 %t344, label %then34, label %merge35
then34:
  %t353 = load i8*, i8** %l4
  %t354 = call i8* @trim_text(i8* %t353)
  %t355 = call i8* @trim_trailing_delimiters(i8* %t354)
  store i8* %t355, i8** %l15
  %t356 = load i8*, i8** %l15
  %t357 = insertvalue %ExpressionContinuationCapture undef, i8* %t356, 0
  %t358 = load double, double* %l6
  %t359 = insertvalue %ExpressionContinuationCapture %t357, double %t358, 1
  %t360 = insertvalue %ExpressionContinuationCapture %t359, i1 1, 2
  ret %ExpressionContinuationCapture %t360
merge35:
  %t361 = load i8*, i8** %l0
  %t362 = insertvalue %ExpressionContinuationCapture undef, i8* %t361, 0
  %t363 = sitofp i64 0 to double
  %t364 = insertvalue %ExpressionContinuationCapture %t362, double %t363, 1
  %t365 = insertvalue %ExpressionContinuationCapture %t364, i1 0, 2
  ret %ExpressionContinuationCapture %t365
}

define i8* @continuation_segment_text(%NativeInstruction %instruction) {
block.entry:
  %t0 = extractvalue %NativeInstruction %instruction, 0
  %t1 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t2 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t3 = icmp eq i32 %t0, 0
  %t4 = select i1 %t3, i8* %t2, i8* %t1
  %t5 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t6 = icmp eq i32 %t0, 1
  %t7 = select i1 %t6, i8* %t5, i8* %t4
  %t8 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t9 = icmp eq i32 %t0, 2
  %t10 = select i1 %t9, i8* %t8, i8* %t7
  %t11 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t12 = icmp eq i32 %t0, 3
  %t13 = select i1 %t12, i8* %t11, i8* %t10
  %t14 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t15 = icmp eq i32 %t0, 4
  %t16 = select i1 %t15, i8* %t14, i8* %t13
  %t17 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t18 = icmp eq i32 %t0, 5
  %t19 = select i1 %t18, i8* %t17, i8* %t16
  %t20 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t21 = icmp eq i32 %t0, 6
  %t22 = select i1 %t21, i8* %t20, i8* %t19
  %t23 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t24 = icmp eq i32 %t0, 7
  %t25 = select i1 %t24, i8* %t23, i8* %t22
  %t26 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t27 = icmp eq i32 %t0, 8
  %t28 = select i1 %t27, i8* %t26, i8* %t25
  %t29 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t30 = icmp eq i32 %t0, 9
  %t31 = select i1 %t30, i8* %t29, i8* %t28
  %t32 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t33 = icmp eq i32 %t0, 10
  %t34 = select i1 %t33, i8* %t32, i8* %t31
  %t35 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t36 = icmp eq i32 %t0, 11
  %t37 = select i1 %t36, i8* %t35, i8* %t34
  %t38 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t39 = icmp eq i32 %t0, 12
  %t40 = select i1 %t39, i8* %t38, i8* %t37
  %t41 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t42 = icmp eq i32 %t0, 13
  %t43 = select i1 %t42, i8* %t41, i8* %t40
  %t44 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t45 = icmp eq i32 %t0, 14
  %t46 = select i1 %t45, i8* %t44, i8* %t43
  %t47 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t48 = icmp eq i32 %t0, 15
  %t49 = select i1 %t48, i8* %t47, i8* %t46
  %t50 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t51 = icmp eq i32 %t0, 16
  %t52 = select i1 %t51, i8* %t50, i8* %t49
  %t53 = call i8* @malloc(i64 8)
  %t54 = bitcast i8* %t53 to [8 x i8]*
  store [8 x i8] c"Unknown\00", [8 x i8]* %t54
  %t55 = call i1 @strings_equal(i8* %t52, i8* %t53)
  br i1 %t55, label %then0, label %merge1
then0:
  %t56 = extractvalue %NativeInstruction %instruction, 0
  %t57 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t57
  %t58 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t57, i32 0, i32 1
  %t59 = bitcast [8 x i8]* %t58 to i8*
  %t60 = bitcast i8* %t59 to i8**
  %t61 = load i8*, i8** %t60
  %t62 = icmp eq i32 %t56, 16
  %t63 = select i1 %t62, i8* %t61, i8* null
  call void @sailfin_runtime_mark_persistent(i8* %t63)
  ret i8* %t63
merge1:
  %t64 = extractvalue %NativeInstruction %instruction, 0
  %t65 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t66 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t67 = icmp eq i32 %t64, 0
  %t68 = select i1 %t67, i8* %t66, i8* %t65
  %t69 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t70 = icmp eq i32 %t64, 1
  %t71 = select i1 %t70, i8* %t69, i8* %t68
  %t72 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t73 = icmp eq i32 %t64, 2
  %t74 = select i1 %t73, i8* %t72, i8* %t71
  %t75 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t76 = icmp eq i32 %t64, 3
  %t77 = select i1 %t76, i8* %t75, i8* %t74
  %t78 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t79 = icmp eq i32 %t64, 4
  %t80 = select i1 %t79, i8* %t78, i8* %t77
  %t81 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t82 = icmp eq i32 %t64, 5
  %t83 = select i1 %t82, i8* %t81, i8* %t80
  %t84 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t85 = icmp eq i32 %t64, 6
  %t86 = select i1 %t85, i8* %t84, i8* %t83
  %t87 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t88 = icmp eq i32 %t64, 7
  %t89 = select i1 %t88, i8* %t87, i8* %t86
  %t90 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t91 = icmp eq i32 %t64, 8
  %t92 = select i1 %t91, i8* %t90, i8* %t89
  %t93 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t94 = icmp eq i32 %t64, 9
  %t95 = select i1 %t94, i8* %t93, i8* %t92
  %t96 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t97 = icmp eq i32 %t64, 10
  %t98 = select i1 %t97, i8* %t96, i8* %t95
  %t99 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t100 = icmp eq i32 %t64, 11
  %t101 = select i1 %t100, i8* %t99, i8* %t98
  %t102 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t103 = icmp eq i32 %t64, 12
  %t104 = select i1 %t103, i8* %t102, i8* %t101
  %t105 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t106 = icmp eq i32 %t64, 13
  %t107 = select i1 %t106, i8* %t105, i8* %t104
  %t108 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t109 = icmp eq i32 %t64, 14
  %t110 = select i1 %t109, i8* %t108, i8* %t107
  %t111 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t112 = icmp eq i32 %t64, 15
  %t113 = select i1 %t112, i8* %t111, i8* %t110
  %t114 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t115 = icmp eq i32 %t64, 16
  %t116 = select i1 %t115, i8* %t114, i8* %t113
  %t117 = call i8* @malloc(i64 11)
  %t118 = bitcast i8* %t117 to [11 x i8]*
  store [11 x i8] c"Expression\00", [11 x i8]* %t118
  %t119 = call i1 @strings_equal(i8* %t116, i8* %t117)
  br i1 %t119, label %then2, label %merge3
then2:
  %t120 = extractvalue %NativeInstruction %instruction, 0
  %t121 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t121
  %t122 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t121, i32 0, i32 1
  %t123 = bitcast [16 x i8]* %t122 to i8*
  %t124 = bitcast i8* %t123 to i8**
  %t125 = load i8*, i8** %t124
  %t126 = icmp eq i32 %t120, 0
  %t127 = select i1 %t126, i8* %t125, i8* null
  %t128 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t121, i32 0, i32 1
  %t129 = bitcast [16 x i8]* %t128 to i8*
  %t130 = bitcast i8* %t129 to i8**
  %t131 = load i8*, i8** %t130
  %t132 = icmp eq i32 %t120, 1
  %t133 = select i1 %t132, i8* %t131, i8* %t127
  %t134 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t121, i32 0, i32 1
  %t135 = bitcast [8 x i8]* %t134 to i8*
  %t136 = bitcast i8* %t135 to i8**
  %t137 = load i8*, i8** %t136
  %t138 = icmp eq i32 %t120, 12
  %t139 = select i1 %t138, i8* %t137, i8* %t133
  call void @sailfin_runtime_mark_persistent(i8* %t139)
  ret i8* %t139
merge3:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
}

define i1 @segment_signals_expression_continuation(i8* %segment) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %segment)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = call i8* @malloc(i64 3)
  %t3 = bitcast i8* %t2 to [3 x i8]*
  store [3 x i8] c"&&\00", [3 x i8]* %t3
  %t4 = call i1 @starts_with(i8* %segment, i8* %t2)
  br i1 %t4, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t5 = call i8* @malloc(i64 3)
  %t6 = bitcast i8* %t5 to [3 x i8]*
  store [3 x i8] c"||\00", [3 x i8]* %t6
  %t7 = call i1 @starts_with(i8* %segment, i8* %t5)
  br i1 %t7, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t8 = sitofp i64 0 to double
  %t9 = call i8* @char_at(i8* %segment, double %t8)
  store i8* %t9, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = load i8, i8* %t11
  %t13 = icmp eq i8 %t12, 46
  br label %logical_or_entry_10

logical_or_entry_10:
  br i1 %t13, label %logical_or_merge_10, label %logical_or_right_10

logical_or_right_10:
  %t15 = load i8*, i8** %l0
  %t16 = load i8, i8* %t15
  %t17 = icmp eq i8 %t16, 41
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t17, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t19 = load i8*, i8** %l0
  %t20 = load i8, i8* %t19
  %t21 = icmp eq i8 %t20, 93
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t21, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t22 = load i8*, i8** %l0
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 125
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t25 = phi i1 [ true, %logical_or_entry_18 ], [ %t24, %logical_or_right_end_18 ]
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t26 = phi i1 [ true, %logical_or_entry_14 ], [ %t25, %logical_or_right_end_14 ]
  br label %logical_or_right_end_10

logical_or_right_end_10:
  br label %logical_or_merge_10

logical_or_merge_10:
  %t27 = phi i1 [ true, %logical_or_entry_10 ], [ %t26, %logical_or_right_end_10 ]
  %t28 = load i8*, i8** %l0
  br i1 %t27, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define double @compute_brace_balance(i8* %text) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t43 = phi double [ %t5, %merge1 ], [ %t41, %loop.latch4 ]
  %t44 = phi double [ %t6, %merge1 ], [ %t42, %loop.latch4 ]
  store double %t43, double* %l0
  store double %t44, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = call i8* @char_at(i8* %text, double %t13)
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = load i8, i8* %t15
  %t17 = icmp eq i8 %t16, 123
  %t18 = load double, double* %l0
  %t19 = load double, double* %l1
  %t20 = load i8*, i8** %l2
  br i1 %t17, label %then8, label %else9
then8:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l0
  %t24 = load double, double* %l0
  br label %merge10
else9:
  %t25 = load i8*, i8** %l2
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 125
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  br i1 %t27, label %then11, label %merge12
then11:
  %t31 = load double, double* %l0
  %t32 = sitofp i64 1 to double
  %t33 = fsub double %t31, %t32
  store double %t33, double* %l0
  %t34 = load double, double* %l0
  br label %merge12
merge12:
  %t35 = phi double [ %t34, %then11 ], [ %t28, %else9 ]
  store double %t35, double* %l0
  %t36 = load double, double* %l0
  br label %merge10
merge10:
  %t37 = phi double [ %t24, %then8 ], [ %t36, %merge12 ]
  store double %t37, double* %l0
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  br label %loop.latch4
loop.latch4:
  %t41 = load double, double* %l0
  %t42 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = load double, double* %l0
  ret double %t47
}

define double @compute_parenthesis_balance(i8* %text) {
block.entry:
  %t0 = add i64 0, 2
  %t1 = call i8* @malloc(i64 %t0)
  store i8 40, i8* %t1
  %t2 = getelementptr i8, i8* %t1, i64 1
  store i8 0, i8* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  %t3 = add i64 0, 2
  %t4 = call i8* @malloc(i64 %t3)
  store i8 41, i8* %t4
  %t5 = getelementptr i8, i8* %t4, i64 1
  store i8 0, i8* %t5
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  %t6 = call double @compute_symbol_balance(i8* %text, i8* %t1, i8* %t4)
  ret double %t6
}

define double @compute_bracket_balance(i8* %text) {
block.entry:
  %t0 = add i64 0, 2
  %t1 = call i8* @malloc(i64 %t0)
  store i8 91, i8* %t1
  %t2 = getelementptr i8, i8* %t1, i64 1
  store i8 0, i8* %t2
  call void @sailfin_runtime_mark_persistent(i8* %t1)
  %t3 = add i64 0, 2
  %t4 = call i8* @malloc(i64 %t3)
  store i8 93, i8* %t4
  %t5 = getelementptr i8, i8* %t4, i64 1
  store i8 0, i8* %t5
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  %t6 = call double @compute_symbol_balance(i8* %text, i8* %t1, i8* %t4)
  ret double %t6
}

define double @compute_symbol_balance(i8* %text, i8* %open, i8* %close) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t41 = phi double [ %t5, %merge1 ], [ %t39, %loop.latch4 ]
  %t42 = phi double [ %t6, %merge1 ], [ %t40, %loop.latch4 ]
  store double %t41, double* %l0
  store double %t42, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = call i8* @char_at(i8* %text, double %t13)
  store i8* %t14, i8** %l2
  %t15 = load i8*, i8** %l2
  %t16 = call i1 @strings_equal(i8* %t15, i8* %open)
  %t17 = load double, double* %l0
  %t18 = load double, double* %l1
  %t19 = load i8*, i8** %l2
  br i1 %t16, label %then8, label %else9
then8:
  %t20 = load double, double* %l0
  %t21 = sitofp i64 1 to double
  %t22 = fadd double %t20, %t21
  store double %t22, double* %l0
  %t23 = load double, double* %l0
  br label %merge10
else9:
  %t24 = load i8*, i8** %l2
  %t25 = call i1 @strings_equal(i8* %t24, i8* %close)
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  %t28 = load i8*, i8** %l2
  br i1 %t25, label %then11, label %merge12
then11:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fsub double %t29, %t30
  store double %t31, double* %l0
  %t32 = load double, double* %l0
  br label %merge12
merge12:
  %t33 = phi double [ %t32, %then11 ], [ %t26, %else9 ]
  store double %t33, double* %l0
  %t34 = load double, double* %l0
  br label %merge10
merge10:
  %t35 = phi double [ %t23, %then8 ], [ %t34, %merge12 ]
  store double %t35, double* %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l1
  br label %loop.latch4
loop.latch4:
  %t39 = load double, double* %l0
  %t40 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t43 = load double, double* %l0
  %t44 = load double, double* %l1
  %t45 = load double, double* %l0
  ret double %t45
}

define { i8**, i64 }* @split_struct_field_entries(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  store i8* %t12, i8** %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  store i1 0, i1* %l4
  %t16 = call i8* @malloc(i64 1)
  %t17 = bitcast i8* %t16 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t17
  store i8* %t16, i8** %l5
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load i8*, i8** %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  %t22 = load i1, i1* %l4
  %t23 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t220 = phi i8* [ %t19, %block.entry ], [ %t214, %loop.latch2 ]
  %t221 = phi double [ %t21, %block.entry ], [ %t215, %loop.latch2 ]
  %t222 = phi i1 [ %t22, %block.entry ], [ %t216, %loop.latch2 ]
  %t223 = phi i8* [ %t23, %block.entry ], [ %t217, %loop.latch2 ]
  %t224 = phi double [ %t20, %block.entry ], [ %t218, %loop.latch2 ]
  %t225 = phi { i8**, i64 }* [ %t18, %block.entry ], [ %t219, %loop.latch2 ]
  store i8* %t220, i8** %l1
  store double %t221, double* %l3
  store i1 %t222, i1* %l4
  store i8* %t223, i8** %l5
  store double %t224, double* %l2
  store { i8**, i64 }* %t225, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t24 = load double, double* %l3
  %t25 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t24, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load i1, i1* %l4
  %t33 = load i8*, i8** %l5
  br i1 %t27, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t34 = load double, double* %l3
  %t35 = call i8* @char_at(i8* %text, double %t34)
  store i8* %t35, i8** %l6
  %t36 = load i1, i1* %l4
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load i8*, i8** %l1
  %t39 = load double, double* %l2
  %t40 = load double, double* %l3
  %t41 = load i1, i1* %l4
  %t42 = load i8*, i8** %l5
  %t43 = load i8*, i8** %l6
  br i1 %t36, label %then6, label %merge7
then6:
  %t44 = load i8*, i8** %l1
  %t45 = load i8*, i8** %l6
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %t45)
  store i8* %t46, i8** %l1
  %t47 = load i8*, i8** %l6
  %t48 = load i8, i8* %t47
  %t49 = icmp eq i8 %t48, 92
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l2
  %t53 = load double, double* %l3
  %t54 = load i1, i1* %l4
  %t55 = load i8*, i8** %l5
  %t56 = load i8*, i8** %l6
  br i1 %t49, label %then8, label %else9
then8:
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l3
  %t60 = load double, double* %l3
  %t61 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t62 = sitofp i64 %t61 to double
  %t63 = fcmp olt double %t60, %t62
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = load double, double* %l3
  %t68 = load i1, i1* %l4
  %t69 = load i8*, i8** %l5
  %t70 = load i8*, i8** %l6
  br i1 %t63, label %then11, label %merge12
then11:
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l3
  %t73 = call i8* @char_at(i8* %text, double %t72)
  %t74 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %t73)
  store i8* %t74, i8** %l1
  %t75 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t76 = phi i8* [ %t75, %then11 ], [ %t65, %then8 ]
  store i8* %t76, i8** %l1
  %t77 = load double, double* %l3
  %t78 = load i8*, i8** %l1
  br label %merge10
else9:
  %t79 = load i8*, i8** %l6
  %t80 = load i8*, i8** %l5
  %t81 = call i1 @strings_equal(i8* %t79, i8* %t80)
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load double, double* %l2
  %t85 = load double, double* %l3
  %t86 = load i1, i1* %l4
  %t87 = load i8*, i8** %l5
  %t88 = load i8*, i8** %l6
  br i1 %t81, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  %t89 = load i1, i1* %l4
  br label %merge14
merge14:
  %t90 = phi i1 [ %t89, %then13 ], [ %t86, %else9 ]
  store i1 %t90, i1* %l4
  %t91 = load i1, i1* %l4
  br label %merge10
merge10:
  %t92 = phi double [ %t77, %merge12 ], [ %t53, %merge14 ]
  %t93 = phi i8* [ %t78, %merge12 ], [ %t51, %merge14 ]
  %t94 = phi i1 [ %t54, %merge12 ], [ %t91, %merge14 ]
  store double %t92, double* %l3
  store i8* %t93, i8** %l1
  store i1 %t94, i1* %l4
  %t95 = load double, double* %l3
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l3
  br label %loop.latch2
merge7:
  %t99 = load i8*, i8** %l6
  %t100 = load i8, i8* %t99
  %t101 = icmp eq i8 %t100, 34
  br label %logical_or_entry_98

logical_or_entry_98:
  br i1 %t101, label %logical_or_merge_98, label %logical_or_right_98

logical_or_right_98:
  %t102 = load i8*, i8** %l6
  %t103 = load i8, i8* %t102
  %t104 = icmp eq i8 %t103, 39
  br label %logical_or_right_end_98

logical_or_right_end_98:
  br label %logical_or_merge_98

logical_or_merge_98:
  %t105 = phi i1 [ true, %logical_or_entry_98 ], [ %t104, %logical_or_right_end_98 ]
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l1
  %t108 = load double, double* %l2
  %t109 = load double, double* %l3
  %t110 = load i1, i1* %l4
  %t111 = load i8*, i8** %l5
  %t112 = load i8*, i8** %l6
  br i1 %t105, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t113 = load i8*, i8** %l6
  store i8* %t113, i8** %l5
  %t114 = load i8*, i8** %l1
  %t115 = load i8*, i8** %l6
  %t116 = call i8* @sailfin_runtime_string_concat(i8* %t114, i8* %t115)
  store i8* %t116, i8** %l1
  %t117 = load double, double* %l3
  %t118 = sitofp i64 1 to double
  %t119 = fadd double %t117, %t118
  store double %t119, double* %l3
  br label %loop.latch2
merge16:
  %t121 = load i8*, i8** %l6
  %t122 = load i8, i8* %t121
  %t123 = icmp eq i8 %t122, 123
  br label %logical_or_entry_120

logical_or_entry_120:
  br i1 %t123, label %logical_or_merge_120, label %logical_or_right_120

logical_or_right_120:
  %t125 = load i8*, i8** %l6
  %t126 = load i8, i8* %t125
  %t127 = icmp eq i8 %t126, 91
  br label %logical_or_entry_124

logical_or_entry_124:
  br i1 %t127, label %logical_or_merge_124, label %logical_or_right_124

logical_or_right_124:
  %t128 = load i8*, i8** %l6
  %t129 = load i8, i8* %t128
  %t130 = icmp eq i8 %t129, 40
  br label %logical_or_right_end_124

logical_or_right_end_124:
  br label %logical_or_merge_124

logical_or_merge_124:
  %t131 = phi i1 [ true, %logical_or_entry_124 ], [ %t130, %logical_or_right_end_124 ]
  br label %logical_or_right_end_120

logical_or_right_end_120:
  br label %logical_or_merge_120

logical_or_merge_120:
  %t132 = phi i1 [ true, %logical_or_entry_120 ], [ %t131, %logical_or_right_end_120 ]
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t134 = load i8*, i8** %l1
  %t135 = load double, double* %l2
  %t136 = load double, double* %l3
  %t137 = load i1, i1* %l4
  %t138 = load i8*, i8** %l5
  %t139 = load i8*, i8** %l6
  br i1 %t132, label %then17, label %else18
then17:
  %t140 = load double, double* %l2
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l2
  %t143 = load double, double* %l2
  br label %merge19
else18:
  %t145 = load i8*, i8** %l6
  %t146 = load i8, i8* %t145
  %t147 = icmp eq i8 %t146, 125
  br label %logical_or_entry_144

logical_or_entry_144:
  br i1 %t147, label %logical_or_merge_144, label %logical_or_right_144

logical_or_right_144:
  %t149 = load i8*, i8** %l6
  %t150 = load i8, i8* %t149
  %t151 = icmp eq i8 %t150, 93
  br label %logical_or_entry_148

logical_or_entry_148:
  br i1 %t151, label %logical_or_merge_148, label %logical_or_right_148

logical_or_right_148:
  %t152 = load i8*, i8** %l6
  %t153 = load i8, i8* %t152
  %t154 = icmp eq i8 %t153, 41
  br label %logical_or_right_end_148

logical_or_right_end_148:
  br label %logical_or_merge_148

logical_or_merge_148:
  %t155 = phi i1 [ true, %logical_or_entry_148 ], [ %t154, %logical_or_right_end_148 ]
  br label %logical_or_right_end_144

logical_or_right_end_144:
  br label %logical_or_merge_144

logical_or_merge_144:
  %t156 = phi i1 [ true, %logical_or_entry_144 ], [ %t155, %logical_or_right_end_144 ]
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load i8*, i8** %l1
  %t159 = load double, double* %l2
  %t160 = load double, double* %l3
  %t161 = load i1, i1* %l4
  %t162 = load i8*, i8** %l5
  %t163 = load i8*, i8** %l6
  br i1 %t156, label %then20, label %merge21
then20:
  %t164 = load double, double* %l2
  %t165 = sitofp i64 0 to double
  %t166 = fcmp ogt double %t164, %t165
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t168 = load i8*, i8** %l1
  %t169 = load double, double* %l2
  %t170 = load double, double* %l3
  %t171 = load i1, i1* %l4
  %t172 = load i8*, i8** %l5
  %t173 = load i8*, i8** %l6
  br i1 %t166, label %then22, label %merge23
then22:
  %t174 = load double, double* %l2
  %t175 = sitofp i64 1 to double
  %t176 = fsub double %t174, %t175
  store double %t176, double* %l2
  %t177 = load double, double* %l2
  br label %merge23
merge23:
  %t178 = phi double [ %t177, %then22 ], [ %t169, %then20 ]
  store double %t178, double* %l2
  %t179 = load double, double* %l2
  br label %merge21
merge21:
  %t180 = phi double [ %t179, %merge23 ], [ %t159, %logical_or_merge_144 ]
  store double %t180, double* %l2
  %t181 = load double, double* %l2
  br label %merge19
merge19:
  %t182 = phi double [ %t143, %then17 ], [ %t181, %merge21 ]
  store double %t182, double* %l2
  %t184 = load i8*, i8** %l6
  %t185 = load i8, i8* %t184
  %t186 = icmp eq i8 %t185, 44
  br label %logical_and_entry_183

logical_and_entry_183:
  br i1 %t186, label %logical_and_right_183, label %logical_and_merge_183

logical_and_right_183:
  %t187 = load double, double* %l2
  %t188 = sitofp i64 0 to double
  %t189 = fcmp oeq double %t187, %t188
  br label %logical_and_right_end_183

logical_and_right_end_183:
  br label %logical_and_merge_183

logical_and_merge_183:
  %t190 = phi i1 [ false, %logical_and_entry_183 ], [ %t189, %logical_and_right_end_183 ]
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t192 = load i8*, i8** %l1
  %t193 = load double, double* %l2
  %t194 = load double, double* %l3
  %t195 = load i1, i1* %l4
  %t196 = load i8*, i8** %l5
  %t197 = load i8*, i8** %l6
  br i1 %t190, label %then24, label %else25
then24:
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t199 = load i8*, i8** %l1
  %t200 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t198, i8* %t199)
  store { i8**, i64 }* %t200, { i8**, i64 }** %l0
  %t201 = call i8* @malloc(i64 1)
  %t202 = bitcast i8* %t201 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t202
  store i8* %t201, i8** %l1
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t204 = load i8*, i8** %l1
  br label %merge26
else25:
  %t205 = load i8*, i8** %l1
  %t206 = load i8*, i8** %l6
  %t207 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %t206)
  store i8* %t207, i8** %l1
  %t208 = load i8*, i8** %l1
  br label %merge26
merge26:
  %t209 = phi { i8**, i64 }* [ %t203, %then24 ], [ %t191, %else25 ]
  %t210 = phi i8* [ %t204, %then24 ], [ %t208, %else25 ]
  store { i8**, i64 }* %t209, { i8**, i64 }** %l0
  store i8* %t210, i8** %l1
  %t211 = load double, double* %l3
  %t212 = sitofp i64 1 to double
  %t213 = fadd double %t211, %t212
  store double %t213, double* %l3
  br label %loop.latch2
loop.latch2:
  %t214 = load i8*, i8** %l1
  %t215 = load double, double* %l3
  %t216 = load i1, i1* %l4
  %t217 = load i8*, i8** %l5
  %t218 = load double, double* %l2
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t226 = load i8*, i8** %l1
  %t227 = load double, double* %l3
  %t228 = load i1, i1* %l4
  %t229 = load i8*, i8** %l5
  %t230 = load double, double* %l2
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load i8*, i8** %l1
  %t233 = call i64 @sailfin_runtime_string_length(i8* %t232)
  %t234 = icmp sgt i64 %t233, 0
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t236 = load i8*, i8** %l1
  %t237 = load double, double* %l2
  %t238 = load double, double* %l3
  %t239 = load i1, i1* %l4
  %t240 = load i8*, i8** %l5
  br i1 %t234, label %then27, label %merge28
then27:
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t242 = load i8*, i8** %l1
  %t243 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t241, i8* %t242)
  store { i8**, i64 }* %t243, { i8**, i64 }** %l0
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t245 = phi { i8**, i64 }* [ %t244, %then27 ], [ %t235, %afterloop3 ]
  store { i8**, i64 }* %t245, { i8**, i64 }** %l0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t246
}

define { i8**, i64 }* @split_array_entries(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l0
  %t12 = call i8* @malloc(i64 1)
  %t13 = bitcast i8* %t12 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t13
  store i8* %t12, i8** %l1
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  store i1 0, i1* %l4
  %t16 = call i8* @malloc(i64 1)
  %t17 = bitcast i8* %t16 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t17
  store i8* %t16, i8** %l5
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load i8*, i8** %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  %t22 = load i1, i1* %l4
  %t23 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t220 = phi i8* [ %t19, %block.entry ], [ %t214, %loop.latch2 ]
  %t221 = phi double [ %t21, %block.entry ], [ %t215, %loop.latch2 ]
  %t222 = phi i1 [ %t22, %block.entry ], [ %t216, %loop.latch2 ]
  %t223 = phi i8* [ %t23, %block.entry ], [ %t217, %loop.latch2 ]
  %t224 = phi double [ %t20, %block.entry ], [ %t218, %loop.latch2 ]
  %t225 = phi { i8**, i64 }* [ %t18, %block.entry ], [ %t219, %loop.latch2 ]
  store i8* %t220, i8** %l1
  store double %t221, double* %l3
  store i1 %t222, i1* %l4
  store i8* %t223, i8** %l5
  store double %t224, double* %l2
  store { i8**, i64 }* %t225, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t24 = load double, double* %l3
  %t25 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t24, %t26
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load i1, i1* %l4
  %t33 = load i8*, i8** %l5
  br i1 %t27, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t34 = load double, double* %l3
  %t35 = call i8* @char_at(i8* %text, double %t34)
  store i8* %t35, i8** %l6
  %t36 = load i1, i1* %l4
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t38 = load i8*, i8** %l1
  %t39 = load double, double* %l2
  %t40 = load double, double* %l3
  %t41 = load i1, i1* %l4
  %t42 = load i8*, i8** %l5
  %t43 = load i8*, i8** %l6
  br i1 %t36, label %then6, label %merge7
then6:
  %t44 = load i8*, i8** %l1
  %t45 = load i8*, i8** %l6
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %t45)
  store i8* %t46, i8** %l1
  %t47 = load i8*, i8** %l6
  %t48 = load i8, i8* %t47
  %t49 = icmp eq i8 %t48, 92
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load double, double* %l2
  %t53 = load double, double* %l3
  %t54 = load i1, i1* %l4
  %t55 = load i8*, i8** %l5
  %t56 = load i8*, i8** %l6
  br i1 %t49, label %then8, label %else9
then8:
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  store double %t59, double* %l3
  %t60 = load double, double* %l3
  %t61 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t62 = sitofp i64 %t61 to double
  %t63 = fcmp olt double %t60, %t62
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = load double, double* %l3
  %t68 = load i1, i1* %l4
  %t69 = load i8*, i8** %l5
  %t70 = load i8*, i8** %l6
  br i1 %t63, label %then11, label %merge12
then11:
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l3
  %t73 = call i8* @char_at(i8* %text, double %t72)
  %t74 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %t73)
  store i8* %t74, i8** %l1
  %t75 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t76 = phi i8* [ %t75, %then11 ], [ %t65, %then8 ]
  store i8* %t76, i8** %l1
  %t77 = load double, double* %l3
  %t78 = load i8*, i8** %l1
  br label %merge10
else9:
  %t79 = load i8*, i8** %l6
  %t80 = load i8*, i8** %l5
  %t81 = call i1 @strings_equal(i8* %t79, i8* %t80)
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load i8*, i8** %l1
  %t84 = load double, double* %l2
  %t85 = load double, double* %l3
  %t86 = load i1, i1* %l4
  %t87 = load i8*, i8** %l5
  %t88 = load i8*, i8** %l6
  br i1 %t81, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  %t89 = load i1, i1* %l4
  br label %merge14
merge14:
  %t90 = phi i1 [ %t89, %then13 ], [ %t86, %else9 ]
  store i1 %t90, i1* %l4
  %t91 = load i1, i1* %l4
  br label %merge10
merge10:
  %t92 = phi double [ %t77, %merge12 ], [ %t53, %merge14 ]
  %t93 = phi i8* [ %t78, %merge12 ], [ %t51, %merge14 ]
  %t94 = phi i1 [ %t54, %merge12 ], [ %t91, %merge14 ]
  store double %t92, double* %l3
  store i8* %t93, i8** %l1
  store i1 %t94, i1* %l4
  %t95 = load double, double* %l3
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  store double %t97, double* %l3
  br label %loop.latch2
merge7:
  %t99 = load i8*, i8** %l6
  %t100 = load i8, i8* %t99
  %t101 = icmp eq i8 %t100, 34
  br label %logical_or_entry_98

logical_or_entry_98:
  br i1 %t101, label %logical_or_merge_98, label %logical_or_right_98

logical_or_right_98:
  %t102 = load i8*, i8** %l6
  %t103 = load i8, i8* %t102
  %t104 = icmp eq i8 %t103, 39
  br label %logical_or_right_end_98

logical_or_right_end_98:
  br label %logical_or_merge_98

logical_or_merge_98:
  %t105 = phi i1 [ true, %logical_or_entry_98 ], [ %t104, %logical_or_right_end_98 ]
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t107 = load i8*, i8** %l1
  %t108 = load double, double* %l2
  %t109 = load double, double* %l3
  %t110 = load i1, i1* %l4
  %t111 = load i8*, i8** %l5
  %t112 = load i8*, i8** %l6
  br i1 %t105, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t113 = load i8*, i8** %l6
  store i8* %t113, i8** %l5
  %t114 = load i8*, i8** %l1
  %t115 = load i8*, i8** %l6
  %t116 = call i8* @sailfin_runtime_string_concat(i8* %t114, i8* %t115)
  store i8* %t116, i8** %l1
  %t117 = load double, double* %l3
  %t118 = sitofp i64 1 to double
  %t119 = fadd double %t117, %t118
  store double %t119, double* %l3
  br label %loop.latch2
merge16:
  %t121 = load i8*, i8** %l6
  %t122 = load i8, i8* %t121
  %t123 = icmp eq i8 %t122, 123
  br label %logical_or_entry_120

logical_or_entry_120:
  br i1 %t123, label %logical_or_merge_120, label %logical_or_right_120

logical_or_right_120:
  %t125 = load i8*, i8** %l6
  %t126 = load i8, i8* %t125
  %t127 = icmp eq i8 %t126, 91
  br label %logical_or_entry_124

logical_or_entry_124:
  br i1 %t127, label %logical_or_merge_124, label %logical_or_right_124

logical_or_right_124:
  %t128 = load i8*, i8** %l6
  %t129 = load i8, i8* %t128
  %t130 = icmp eq i8 %t129, 40
  br label %logical_or_right_end_124

logical_or_right_end_124:
  br label %logical_or_merge_124

logical_or_merge_124:
  %t131 = phi i1 [ true, %logical_or_entry_124 ], [ %t130, %logical_or_right_end_124 ]
  br label %logical_or_right_end_120

logical_or_right_end_120:
  br label %logical_or_merge_120

logical_or_merge_120:
  %t132 = phi i1 [ true, %logical_or_entry_120 ], [ %t131, %logical_or_right_end_120 ]
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t134 = load i8*, i8** %l1
  %t135 = load double, double* %l2
  %t136 = load double, double* %l3
  %t137 = load i1, i1* %l4
  %t138 = load i8*, i8** %l5
  %t139 = load i8*, i8** %l6
  br i1 %t132, label %then17, label %else18
then17:
  %t140 = load double, double* %l2
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l2
  %t143 = load double, double* %l2
  br label %merge19
else18:
  %t145 = load i8*, i8** %l6
  %t146 = load i8, i8* %t145
  %t147 = icmp eq i8 %t146, 125
  br label %logical_or_entry_144

logical_or_entry_144:
  br i1 %t147, label %logical_or_merge_144, label %logical_or_right_144

logical_or_right_144:
  %t149 = load i8*, i8** %l6
  %t150 = load i8, i8* %t149
  %t151 = icmp eq i8 %t150, 93
  br label %logical_or_entry_148

logical_or_entry_148:
  br i1 %t151, label %logical_or_merge_148, label %logical_or_right_148

logical_or_right_148:
  %t152 = load i8*, i8** %l6
  %t153 = load i8, i8* %t152
  %t154 = icmp eq i8 %t153, 41
  br label %logical_or_right_end_148

logical_or_right_end_148:
  br label %logical_or_merge_148

logical_or_merge_148:
  %t155 = phi i1 [ true, %logical_or_entry_148 ], [ %t154, %logical_or_right_end_148 ]
  br label %logical_or_right_end_144

logical_or_right_end_144:
  br label %logical_or_merge_144

logical_or_merge_144:
  %t156 = phi i1 [ true, %logical_or_entry_144 ], [ %t155, %logical_or_right_end_144 ]
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load i8*, i8** %l1
  %t159 = load double, double* %l2
  %t160 = load double, double* %l3
  %t161 = load i1, i1* %l4
  %t162 = load i8*, i8** %l5
  %t163 = load i8*, i8** %l6
  br i1 %t156, label %then20, label %merge21
then20:
  %t164 = load double, double* %l2
  %t165 = sitofp i64 0 to double
  %t166 = fcmp ogt double %t164, %t165
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t168 = load i8*, i8** %l1
  %t169 = load double, double* %l2
  %t170 = load double, double* %l3
  %t171 = load i1, i1* %l4
  %t172 = load i8*, i8** %l5
  %t173 = load i8*, i8** %l6
  br i1 %t166, label %then22, label %merge23
then22:
  %t174 = load double, double* %l2
  %t175 = sitofp i64 1 to double
  %t176 = fsub double %t174, %t175
  store double %t176, double* %l2
  %t177 = load double, double* %l2
  br label %merge23
merge23:
  %t178 = phi double [ %t177, %then22 ], [ %t169, %then20 ]
  store double %t178, double* %l2
  %t179 = load double, double* %l2
  br label %merge21
merge21:
  %t180 = phi double [ %t179, %merge23 ], [ %t159, %logical_or_merge_144 ]
  store double %t180, double* %l2
  %t181 = load double, double* %l2
  br label %merge19
merge19:
  %t182 = phi double [ %t143, %then17 ], [ %t181, %merge21 ]
  store double %t182, double* %l2
  %t184 = load i8*, i8** %l6
  %t185 = load i8, i8* %t184
  %t186 = icmp eq i8 %t185, 44
  br label %logical_and_entry_183

logical_and_entry_183:
  br i1 %t186, label %logical_and_right_183, label %logical_and_merge_183

logical_and_right_183:
  %t187 = load double, double* %l2
  %t188 = sitofp i64 0 to double
  %t189 = fcmp oeq double %t187, %t188
  br label %logical_and_right_end_183

logical_and_right_end_183:
  br label %logical_and_merge_183

logical_and_merge_183:
  %t190 = phi i1 [ false, %logical_and_entry_183 ], [ %t189, %logical_and_right_end_183 ]
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t192 = load i8*, i8** %l1
  %t193 = load double, double* %l2
  %t194 = load double, double* %l3
  %t195 = load i1, i1* %l4
  %t196 = load i8*, i8** %l5
  %t197 = load i8*, i8** %l6
  br i1 %t190, label %then24, label %else25
then24:
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t199 = load i8*, i8** %l1
  %t200 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t198, i8* %t199)
  store { i8**, i64 }* %t200, { i8**, i64 }** %l0
  %t201 = call i8* @malloc(i64 1)
  %t202 = bitcast i8* %t201 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t202
  store i8* %t201, i8** %l1
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t204 = load i8*, i8** %l1
  br label %merge26
else25:
  %t205 = load i8*, i8** %l1
  %t206 = load i8*, i8** %l6
  %t207 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %t206)
  store i8* %t207, i8** %l1
  %t208 = load i8*, i8** %l1
  br label %merge26
merge26:
  %t209 = phi { i8**, i64 }* [ %t203, %then24 ], [ %t191, %else25 ]
  %t210 = phi i8* [ %t204, %then24 ], [ %t208, %else25 ]
  store { i8**, i64 }* %t209, { i8**, i64 }** %l0
  store i8* %t210, i8** %l1
  %t211 = load double, double* %l3
  %t212 = sitofp i64 1 to double
  %t213 = fadd double %t211, %t212
  store double %t213, double* %l3
  br label %loop.latch2
loop.latch2:
  %t214 = load i8*, i8** %l1
  %t215 = load double, double* %l3
  %t216 = load i1, i1* %l4
  %t217 = load i8*, i8** %l5
  %t218 = load double, double* %l2
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t226 = load i8*, i8** %l1
  %t227 = load double, double* %l3
  %t228 = load i1, i1* %l4
  %t229 = load i8*, i8** %l5
  %t230 = load double, double* %l2
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load i8*, i8** %l1
  %t233 = call i64 @sailfin_runtime_string_length(i8* %t232)
  %t234 = icmp sgt i64 %t233, 0
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t236 = load i8*, i8** %l1
  %t237 = load double, double* %l2
  %t238 = load double, double* %l3
  %t239 = load i1, i1* %l4
  %t240 = load i8*, i8** %l5
  br i1 %t234, label %then27, label %merge28
then27:
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t242 = load i8*, i8** %l1
  %t243 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t241, i8* %t242)
  store { i8**, i64 }* %t243, { i8**, i64 }** %l0
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t245 = phi { i8**, i64 }* [ %t244, %then27 ], [ %t235, %afterloop3 ]
  store { i8**, i64 }* %t245, { i8**, i64 }** %l0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t246
}

define i8* @trim_trailing_delimiters(i8* %text) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t1 = sitofp i64 %t0 to double
  store double %t1, double* %l0
  %t2 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t2, %block.entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = sitofp i64 0 to double
  %t5 = fcmp ole double %t3, %t4
  %t6 = load double, double* %l0
  br i1 %t5, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t7 = load double, double* %l0
  %t8 = sitofp i64 1 to double
  %t9 = fsub double %t7, %t8
  %t10 = call i8* @char_at(i8* %text, double %t9)
  store i8* %t10, i8** %l1
  %t12 = load i8*, i8** %l1
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 44
  br label %logical_or_entry_11

logical_or_entry_11:
  br i1 %t14, label %logical_or_merge_11, label %logical_or_right_11

logical_or_right_11:
  %t15 = load i8*, i8** %l1
  %t16 = load i8, i8* %t15
  %t17 = icmp eq i8 %t16, 59
  br label %logical_or_right_end_11

logical_or_right_end_11:
  br label %logical_or_merge_11

logical_or_merge_11:
  %t18 = phi i1 [ true, %logical_or_entry_11 ], [ %t17, %logical_or_right_end_11 ]
  %t19 = load double, double* %l0
  %t20 = load i8*, i8** %l1
  br i1 %t18, label %then6, label %merge7
then6:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fsub double %t21, %t22
  store double %t23, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t24 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t26 = load double, double* %l0
  %t27 = load double, double* %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oeq double %t27, %t29
  %t31 = load double, double* %l0
  br i1 %t30, label %then8, label %merge9
then8:
  call void @sailfin_runtime_mark_persistent(i8* %text)
  ret i8* %text
merge9:
  %t32 = load double, double* %l0
  %t33 = call double @llvm.round.f64(double %t32)
  %t34 = fptosi double %t33 to i64
  %t35 = call i8* @sailfin_runtime_substring(i8* %text, i64 0, i64 %t34)
  call void @sailfin_runtime_mark_persistent(i8* %t35)
  ret i8* %t35
}

define double @index_of(i8* %value, i8* %target) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  ret double %t2
merge1:
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l0
  %t4 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t57 = phi double [ %t4, %merge1 ], [ %t56, %loop.latch4 ]
  store double %t57, double* %l0
  br label %loop.body3
loop.body3:
  %t5 = load double, double* %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t7 = sitofp i64 %t6 to double
  %t8 = fadd double %t5, %t7
  %t9 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t10 = sitofp i64 %t9 to double
  %t11 = fcmp ogt double %t8, %t10
  %t12 = load double, double* %l0
  br i1 %t11, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l1
  store i1 1, i1* %l2
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i1, i1* %l2
  br label %loop.header8
loop.header8:
  %t44 = phi i1 [ %t16, %merge7 ], [ %t42, %loop.latch10 ]
  %t45 = phi double [ %t15, %merge7 ], [ %t43, %loop.latch10 ]
  store i1 %t44, i1* %l2
  store double %t45, double* %l1
  br label %loop.body9
loop.body9:
  %t17 = load double, double* %l1
  %t18 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t17, %t19
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i1, i1* %l2
  br i1 %t20, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = fadd double %t24, %t25
  %t27 = call i8* @char_at(i8* %value, double %t26)
  store i8* %t27, i8** %l3
  %t28 = load double, double* %l1
  %t29 = call i8* @char_at(i8* %target, double %t28)
  store i8* %t29, i8** %l4
  %t30 = load i8*, i8** %l3
  %t31 = load i8*, i8** %l4
  %t32 = call i1 @strings_equal(i8* %t30, i8* %t31)
  %t33 = xor i1 %t32, true
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  %t36 = load i1, i1* %l2
  %t37 = load i8*, i8** %l3
  %t38 = load i8*, i8** %l4
  br i1 %t33, label %then14, label %merge15
then14:
  store i1 0, i1* %l2
  br label %afterloop11
merge15:
  %t39 = load double, double* %l1
  %t40 = sitofp i64 1 to double
  %t41 = fadd double %t39, %t40
  store double %t41, double* %l1
  br label %loop.latch10
loop.latch10:
  %t42 = load i1, i1* %l2
  %t43 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t46 = load i1, i1* %l2
  %t47 = load double, double* %l1
  %t48 = load i1, i1* %l2
  %t49 = load double, double* %l0
  %t50 = load double, double* %l1
  %t51 = load i1, i1* %l2
  br i1 %t48, label %then16, label %merge17
then16:
  %t52 = load double, double* %l0
  ret double %t52
merge17:
  %t53 = load double, double* %l0
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l0
  br label %loop.latch4
loop.latch4:
  %t56 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t58 = load double, double* %l0
  %t59 = sitofp i64 -1 to double
  ret double %t59
}

define double @find_matching_brace(i8* %text, double %open_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %open_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t53 = phi double [ %t1, %block.entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t2, %block.entry ], [ %t52, %loop.latch2 ]
  store double %t53, double* %l0
  store double %t54, double* %l1
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l1
  %t4 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t3, %t5
  %t7 = load double, double* %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load double, double* %l1
  %t10 = call i8* @char_at(i8* %text, double %t9)
  store i8* %t10, i8** %l2
  %t11 = load i8*, i8** %l2
  %t12 = load i8, i8* %t11
  %t13 = icmp eq i8 %t12, 123
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  %t16 = load i8*, i8** %l2
  br i1 %t13, label %then6, label %else7
then6:
  %t17 = load double, double* %l0
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l0
  %t20 = load double, double* %l0
  br label %merge8
else7:
  %t21 = load i8*, i8** %l2
  %t22 = load i8, i8* %t21
  %t23 = icmp eq i8 %t22, 125
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  br i1 %t23, label %then9, label %merge10
then9:
  %t27 = load double, double* %l0
  %t28 = sitofp i64 0 to double
  %t29 = fcmp ole double %t27, %t28
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then11, label %merge12
then11:
  %t33 = sitofp i64 -1 to double
  ret double %t33
merge12:
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fsub double %t34, %t35
  store double %t36, double* %l0
  %t37 = load double, double* %l0
  %t38 = sitofp i64 0 to double
  %t39 = fcmp oeq double %t37, %t38
  %t40 = load double, double* %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l2
  br i1 %t39, label %then13, label %merge14
then13:
  %t43 = load double, double* %l1
  ret double %t43
merge14:
  %t44 = load double, double* %l0
  br label %merge10
merge10:
  %t45 = phi double [ %t44, %merge14 ], [ %t24, %else7 ]
  store double %t45, double* %l0
  %t46 = load double, double* %l0
  br label %merge8
merge8:
  %t47 = phi double [ %t20, %then6 ], [ %t46, %merge10 ]
  store double %t47, double* %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = sitofp i64 -1 to double
  ret double %t57
}

define i1 @is_escaped_quote(i8* %text, double %position) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %position, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 0
merge1:
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l0
  %t3 = sitofp i64 1 to double
  %t4 = fsub double %position, %t3
  store double %t4, double* %l1
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t26 = phi double [ %t5, %merge1 ], [ %t24, %loop.latch4 ]
  %t27 = phi double [ %t6, %merge1 ], [ %t25, %loop.latch4 ]
  store double %t26, double* %l0
  store double %t27, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = sitofp i64 0 to double
  %t9 = fcmp olt double %t7, %t8
  %t10 = load double, double* %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = call i8* @char_at(i8* %text, double %t12)
  %t14 = load i8, i8* %t13
  %t15 = icmp ne i8 %t14, 92
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t18 = load double, double* %l0
  %t19 = sitofp i64 1 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l0
  %t21 = load double, double* %l1
  %t22 = sitofp i64 1 to double
  %t23 = fsub double %t21, %t22
  store double %t23, double* %l1
  br label %loop.latch4
loop.latch4:
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l0
  %t31 = sitofp i64 2 to double
  %t32 = frem double %t30, %t31
  %t33 = sitofp i64 1 to double
  %t34 = fcmp oeq double %t32, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then10, label %merge11
then10:
  ret i1 1
merge11:
  ret i1 0
}

define double @find_next_square_open(i8* %text, double %start) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca i1
  %l3 = alloca i8*
  store double %start, double* %l0
  store i1 0, i1* %l1
  store i1 0, i1* %l2
  %t0 = load double, double* %l0
  %t1 = load i1, i1* %l1
  %t2 = load i1, i1* %l2
  br label %loop.header0
loop.header0:
  %t94 = phi i1 [ %t1, %block.entry ], [ %t91, %loop.latch2 ]
  %t95 = phi double [ %t0, %block.entry ], [ %t92, %loop.latch2 ]
  %t96 = phi i1 [ %t2, %block.entry ], [ %t93, %loop.latch2 ]
  store i1 %t94, i1* %l1
  store double %t95, double* %l0
  store i1 %t96, i1* %l2
  br label %loop.body1
loop.body1:
  %t3 = load double, double* %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t3, %t5
  %t7 = load double, double* %l0
  %t8 = load i1, i1* %l1
  %t9 = load i1, i1* %l2
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l0
  %t11 = call i8* @char_at(i8* %text, double %t10)
  store i8* %t11, i8** %l3
  %t12 = load i8*, i8** %l3
  %t13 = load i8, i8* %t12
  %t14 = icmp eq i8 %t13, 39
  %t15 = load double, double* %l0
  %t16 = load i1, i1* %l1
  %t17 = load i1, i1* %l2
  %t18 = load i8*, i8** %l3
  br i1 %t14, label %then6, label %merge7
then6:
  %t20 = load i1, i1* %l2
  %t21 = xor i1 %t20, 1
  br label %logical_and_entry_19

logical_and_entry_19:
  br i1 %t21, label %logical_and_right_19, label %logical_and_merge_19

logical_and_right_19:
  %t22 = load double, double* %l0
  %t23 = call i1 @is_escaped_quote(i8* %text, double %t22)
  %t24 = xor i1 %t23, 1
  br label %logical_and_right_end_19

logical_and_right_end_19:
  br label %logical_and_merge_19

logical_and_merge_19:
  %t25 = phi i1 [ false, %logical_and_entry_19 ], [ %t24, %logical_and_right_end_19 ]
  %t26 = load double, double* %l0
  %t27 = load i1, i1* %l1
  %t28 = load i1, i1* %l2
  %t29 = load i8*, i8** %l3
  br i1 %t25, label %then8, label %merge9
then8:
  %t30 = load i1, i1* %l1
  %t31 = xor i1 %t30, 1
  store i1 %t31, i1* %l1
  %t32 = load i1, i1* %l1
  br label %merge9
merge9:
  %t33 = phi i1 [ %t32, %then8 ], [ %t27, %logical_and_merge_19 ]
  store i1 %t33, i1* %l1
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l0
  br label %loop.latch2
merge7:
  %t37 = load i8*, i8** %l3
  %t38 = load i8, i8* %t37
  %t39 = icmp eq i8 %t38, 34
  %t40 = load double, double* %l0
  %t41 = load i1, i1* %l1
  %t42 = load i1, i1* %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then10, label %merge11
then10:
  %t45 = load i1, i1* %l1
  %t46 = xor i1 %t45, 1
  br label %logical_and_entry_44

logical_and_entry_44:
  br i1 %t46, label %logical_and_right_44, label %logical_and_merge_44

logical_and_right_44:
  %t47 = load double, double* %l0
  %t48 = call i1 @is_escaped_quote(i8* %text, double %t47)
  %t49 = xor i1 %t48, 1
  br label %logical_and_right_end_44

logical_and_right_end_44:
  br label %logical_and_merge_44

logical_and_merge_44:
  %t50 = phi i1 [ false, %logical_and_entry_44 ], [ %t49, %logical_and_right_end_44 ]
  %t51 = load double, double* %l0
  %t52 = load i1, i1* %l1
  %t53 = load i1, i1* %l2
  %t54 = load i8*, i8** %l3
  br i1 %t50, label %then12, label %merge13
then12:
  %t55 = load i1, i1* %l2
  %t56 = xor i1 %t55, 1
  store i1 %t56, i1* %l2
  %t57 = load i1, i1* %l2
  br label %merge13
merge13:
  %t58 = phi i1 [ %t57, %then12 ], [ %t53, %logical_and_merge_44 ]
  store i1 %t58, i1* %l2
  %t59 = load double, double* %l0
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  store double %t61, double* %l0
  br label %loop.latch2
merge11:
  %t63 = load i1, i1* %l1
  %t64 = xor i1 %t63, 1
  br label %logical_and_entry_62

logical_and_entry_62:
  br i1 %t64, label %logical_and_right_62, label %logical_and_merge_62

logical_and_right_62:
  %t65 = load i1, i1* %l2
  %t66 = xor i1 %t65, 1
  br label %logical_and_right_end_62

logical_and_right_end_62:
  br label %logical_and_merge_62

logical_and_merge_62:
  %t67 = phi i1 [ false, %logical_and_entry_62 ], [ %t66, %logical_and_right_end_62 ]
  %t68 = load double, double* %l0
  %t69 = load i1, i1* %l1
  %t70 = load i1, i1* %l2
  %t71 = load i8*, i8** %l3
  br i1 %t67, label %then14, label %merge15
then14:
  %t72 = load i8*, i8** %l3
  %t73 = load i8, i8* %t72
  %t74 = icmp eq i8 %t73, 91
  %t75 = load double, double* %l0
  %t76 = load i1, i1* %l1
  %t77 = load i1, i1* %l2
  %t78 = load i8*, i8** %l3
  br i1 %t74, label %then16, label %merge17
then16:
  %t79 = load double, double* %l0
  ret double %t79
merge17:
  %t80 = load i8*, i8** %l3
  %t81 = load i8, i8* %t80
  %t82 = icmp eq i8 %t81, 93
  %t83 = load double, double* %l0
  %t84 = load i1, i1* %l1
  %t85 = load i1, i1* %l2
  %t86 = load i8*, i8** %l3
  br i1 %t82, label %then18, label %merge19
then18:
  %t87 = sitofp i64 -1 to double
  ret double %t87
merge19:
  br label %merge15
merge15:
  %t88 = load double, double* %l0
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l0
  br label %loop.latch2
loop.latch2:
  %t91 = load i1, i1* %l1
  %t92 = load double, double* %l0
  %t93 = load i1, i1* %l2
  br label %loop.header0
afterloop3:
  %t97 = load i1, i1* %l1
  %t98 = load double, double* %l0
  %t99 = load i1, i1* %l2
  %t100 = sitofp i64 -1 to double
  ret double %t100
}

define double @find_matching_square(i8* %text, double %open_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %open_index, double* %l1
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  %t3 = load i1, i1* %l2
  %t4 = load i1, i1* %l3
  br label %loop.header0
loop.header0:
  %t135 = phi i1 [ %t3, %block.entry ], [ %t131, %loop.latch2 ]
  %t136 = phi double [ %t2, %block.entry ], [ %t132, %loop.latch2 ]
  %t137 = phi i1 [ %t4, %block.entry ], [ %t133, %loop.latch2 ]
  %t138 = phi double [ %t1, %block.entry ], [ %t134, %loop.latch2 ]
  store i1 %t135, i1* %l2
  store double %t136, double* %l1
  store i1 %t137, i1* %l3
  store double %t138, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t5, %t7
  %t9 = load double, double* %l0
  %t10 = load double, double* %l1
  %t11 = load i1, i1* %l2
  %t12 = load i1, i1* %l3
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load double, double* %l1
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = getelementptr i8, i8* %text, i64 %t15
  %t17 = load i8, i8* %t16
  store i8 %t17, i8* %l4
  %t18 = load i8, i8* %l4
  %t19 = icmp eq i8 %t18, 39
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load i1, i1* %l2
  %t23 = load i1, i1* %l3
  %t24 = load i8, i8* %l4
  br i1 %t19, label %then6, label %merge7
then6:
  %t26 = load i1, i1* %l3
  %t27 = xor i1 %t26, 1
  br label %logical_and_entry_25

logical_and_entry_25:
  br i1 %t27, label %logical_and_right_25, label %logical_and_merge_25

logical_and_right_25:
  %t28 = load double, double* %l1
  %t29 = call i1 @is_escaped_quote(i8* %text, double %t28)
  %t30 = xor i1 %t29, 1
  br label %logical_and_right_end_25

logical_and_right_end_25:
  br label %logical_and_merge_25

logical_and_merge_25:
  %t31 = phi i1 [ false, %logical_and_entry_25 ], [ %t30, %logical_and_right_end_25 ]
  %t32 = load double, double* %l0
  %t33 = load double, double* %l1
  %t34 = load i1, i1* %l2
  %t35 = load i1, i1* %l3
  %t36 = load i8, i8* %l4
  br i1 %t31, label %then8, label %merge9
then8:
  %t37 = load i1, i1* %l2
  %t38 = xor i1 %t37, 1
  store i1 %t38, i1* %l2
  %t39 = load i1, i1* %l2
  br label %merge9
merge9:
  %t40 = phi i1 [ %t39, %then8 ], [ %t34, %logical_and_merge_25 ]
  store i1 %t40, i1* %l2
  %t41 = load double, double* %l1
  %t42 = sitofp i64 1 to double
  %t43 = fadd double %t41, %t42
  store double %t43, double* %l1
  br label %loop.latch2
merge7:
  %t44 = load i8, i8* %l4
  %t45 = icmp eq i8 %t44, 34
  %t46 = load double, double* %l0
  %t47 = load double, double* %l1
  %t48 = load i1, i1* %l2
  %t49 = load i1, i1* %l3
  %t50 = load i8, i8* %l4
  br i1 %t45, label %then10, label %merge11
then10:
  %t52 = load i1, i1* %l2
  %t53 = xor i1 %t52, 1
  br label %logical_and_entry_51

logical_and_entry_51:
  br i1 %t53, label %logical_and_right_51, label %logical_and_merge_51

logical_and_right_51:
  %t54 = load double, double* %l1
  %t55 = call i1 @is_escaped_quote(i8* %text, double %t54)
  %t56 = xor i1 %t55, 1
  br label %logical_and_right_end_51

logical_and_right_end_51:
  br label %logical_and_merge_51

logical_and_merge_51:
  %t57 = phi i1 [ false, %logical_and_entry_51 ], [ %t56, %logical_and_right_end_51 ]
  %t58 = load double, double* %l0
  %t59 = load double, double* %l1
  %t60 = load i1, i1* %l2
  %t61 = load i1, i1* %l3
  %t62 = load i8, i8* %l4
  br i1 %t57, label %then12, label %merge13
then12:
  %t63 = load i1, i1* %l3
  %t64 = xor i1 %t63, 1
  store i1 %t64, i1* %l3
  %t65 = load i1, i1* %l3
  br label %merge13
merge13:
  %t66 = phi i1 [ %t65, %then12 ], [ %t61, %logical_and_merge_51 ]
  store i1 %t66, i1* %l3
  %t67 = load double, double* %l1
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l1
  br label %loop.latch2
merge11:
  %t71 = load i1, i1* %l2
  %t72 = xor i1 %t71, 1
  br label %logical_and_entry_70

logical_and_entry_70:
  br i1 %t72, label %logical_and_right_70, label %logical_and_merge_70

logical_and_right_70:
  %t73 = load i1, i1* %l3
  %t74 = xor i1 %t73, 1
  br label %logical_and_right_end_70

logical_and_right_end_70:
  br label %logical_and_merge_70

logical_and_merge_70:
  %t75 = phi i1 [ false, %logical_and_entry_70 ], [ %t74, %logical_and_right_end_70 ]
  %t76 = load double, double* %l0
  %t77 = load double, double* %l1
  %t78 = load i1, i1* %l2
  %t79 = load i1, i1* %l3
  %t80 = load i8, i8* %l4
  br i1 %t75, label %then14, label %merge15
then14:
  %t81 = load i8, i8* %l4
  %t82 = icmp eq i8 %t81, 91
  %t83 = load double, double* %l0
  %t84 = load double, double* %l1
  %t85 = load i1, i1* %l2
  %t86 = load i1, i1* %l3
  %t87 = load i8, i8* %l4
  br i1 %t82, label %then16, label %else17
then16:
  %t88 = load double, double* %l0
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l0
  %t91 = load double, double* %l0
  br label %merge18
else17:
  %t92 = load i8, i8* %l4
  %t93 = icmp eq i8 %t92, 93
  %t94 = load double, double* %l0
  %t95 = load double, double* %l1
  %t96 = load i1, i1* %l2
  %t97 = load i1, i1* %l3
  %t98 = load i8, i8* %l4
  br i1 %t93, label %then19, label %merge20
then19:
  %t99 = load double, double* %l0
  %t100 = sitofp i64 0 to double
  %t101 = fcmp ole double %t99, %t100
  %t102 = load double, double* %l0
  %t103 = load double, double* %l1
  %t104 = load i1, i1* %l2
  %t105 = load i1, i1* %l3
  %t106 = load i8, i8* %l4
  br i1 %t101, label %then21, label %merge22
then21:
  %t107 = sitofp i64 -1 to double
  ret double %t107
merge22:
  %t108 = load double, double* %l0
  %t109 = sitofp i64 1 to double
  %t110 = fsub double %t108, %t109
  store double %t110, double* %l0
  %t111 = load double, double* %l0
  %t112 = sitofp i64 0 to double
  %t113 = fcmp oeq double %t111, %t112
  %t114 = load double, double* %l0
  %t115 = load double, double* %l1
  %t116 = load i1, i1* %l2
  %t117 = load i1, i1* %l3
  %t118 = load i8, i8* %l4
  br i1 %t113, label %then23, label %merge24
then23:
  %t119 = load double, double* %l1
  ret double %t119
merge24:
  %t120 = load double, double* %l0
  br label %merge20
merge20:
  %t121 = phi double [ %t120, %merge24 ], [ %t94, %else17 ]
  store double %t121, double* %l0
  %t122 = load double, double* %l0
  br label %merge18
merge18:
  %t123 = phi double [ %t91, %then16 ], [ %t122, %merge20 ]
  store double %t123, double* %l0
  %t124 = load double, double* %l0
  %t125 = load double, double* %l0
  br label %merge15
merge15:
  %t126 = phi double [ %t124, %merge18 ], [ %t76, %logical_and_merge_70 ]
  %t127 = phi double [ %t125, %merge18 ], [ %t76, %logical_and_merge_70 ]
  store double %t126, double* %l0
  store double %t127, double* %l0
  %t128 = load double, double* %l1
  %t129 = sitofp i64 1 to double
  %t130 = fadd double %t128, %t129
  store double %t130, double* %l1
  br label %loop.latch2
loop.latch2:
  %t131 = load i1, i1* %l2
  %t132 = load double, double* %l1
  %t133 = load i1, i1* %l3
  %t134 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t139 = load i1, i1* %l2
  %t140 = load double, double* %l1
  %t141 = load i1, i1* %l3
  %t142 = load double, double* %l0
  %t143 = sitofp i64 -1 to double
  ret double %t143
}

define double @find_substring_from(i8* %value, i8* %pattern, double %start) {
block.entry:
  %l0 = alloca double
  %l1 = alloca i1
  %l2 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = sitofp i64 0 to double
  %t3 = fcmp olt double %start, %t2
  br i1 %t3, label %then2, label %merge3
then2:
  %t4 = sitofp i64 0 to double
  ret double %t4
merge3:
  %t5 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp ogt double %start, %t6
  br i1 %t7, label %then4, label %merge5
then4:
  %t8 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t9 = sitofp i64 %t8 to double
  ret double %t9
merge5:
  ret double %start
merge1:
  store double %start, double* %l0
  %t10 = load double, double* %l0
  %t11 = sitofp i64 0 to double
  %t12 = fcmp olt double %t10, %t11
  %t13 = load double, double* %l0
  br i1 %t12, label %then6, label %merge7
then6:
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l0
  %t15 = load double, double* %l0
  br label %merge7
merge7:
  %t16 = phi double [ %t15, %then6 ], [ %t13, %merge1 ]
  store double %t16, double* %l0
  %t17 = load double, double* %l0
  br label %loop.header8
loop.header8:
  %t71 = phi double [ %t17, %merge7 ], [ %t70, %loop.latch10 ]
  store double %t71, double* %l0
  br label %loop.body9
loop.body9:
  %t18 = load double, double* %l0
  %t19 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t20 = sitofp i64 %t19 to double
  %t21 = fadd double %t18, %t20
  %t22 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp ogt double %t21, %t23
  %t25 = load double, double* %l0
  br i1 %t24, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  store i1 1, i1* %l1
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l2
  %t27 = load double, double* %l0
  %t28 = load i1, i1* %l1
  %t29 = load double, double* %l2
  br label %loop.header14
loop.header14:
  %t58 = phi i1 [ %t28, %merge13 ], [ %t56, %loop.latch16 ]
  %t59 = phi double [ %t29, %merge13 ], [ %t57, %loop.latch16 ]
  store i1 %t58, i1* %l1
  store double %t59, double* %l2
  br label %loop.body15
loop.body15:
  %t30 = load double, double* %l2
  %t31 = call i64 @sailfin_runtime_string_length(i8* %pattern)
  %t32 = sitofp i64 %t31 to double
  %t33 = fcmp oge double %t30, %t32
  %t34 = load double, double* %l0
  %t35 = load i1, i1* %l1
  %t36 = load double, double* %l2
  br i1 %t33, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t37 = load double, double* %l0
  %t38 = load double, double* %l2
  %t39 = fadd double %t37, %t38
  %t40 = call double @llvm.round.f64(double %t39)
  %t41 = fptosi double %t40 to i64
  %t42 = getelementptr i8, i8* %value, i64 %t41
  %t43 = load i8, i8* %t42
  %t44 = load double, double* %l2
  %t45 = call double @llvm.round.f64(double %t44)
  %t46 = fptosi double %t45 to i64
  %t47 = getelementptr i8, i8* %pattern, i64 %t46
  %t48 = load i8, i8* %t47
  %t49 = icmp ne i8 %t43, %t48
  %t50 = load double, double* %l0
  %t51 = load i1, i1* %l1
  %t52 = load double, double* %l2
  br i1 %t49, label %then20, label %merge21
then20:
  store i1 0, i1* %l1
  br label %afterloop17
merge21:
  %t53 = load double, double* %l2
  %t54 = sitofp i64 1 to double
  %t55 = fadd double %t53, %t54
  store double %t55, double* %l2
  br label %loop.latch16
loop.latch16:
  %t56 = load i1, i1* %l1
  %t57 = load double, double* %l2
  br label %loop.header14
afterloop17:
  %t60 = load i1, i1* %l1
  %t61 = load double, double* %l2
  %t62 = load i1, i1* %l1
  %t63 = load double, double* %l0
  %t64 = load i1, i1* %l1
  %t65 = load double, double* %l2
  br i1 %t62, label %then22, label %merge23
then22:
  %t66 = load double, double* %l0
  ret double %t66
merge23:
  %t67 = load double, double* %l0
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l0
  br label %loop.latch10
loop.latch10:
  %t70 = load double, double* %l0
  br label %loop.header8
afterloop11:
  %t72 = load double, double* %l0
  %t73 = sitofp i64 -1 to double
  ret double %t73
}

define %PythonFunctionEmission @emit_python_function(%PythonBuilder %builder, %NativeFunction %function) {
block.entry:
  %l0 = alloca %PythonBuilder
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { %MatchContext*, i64 }*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca %NativeInstruction
  %l9 = alloca i8*
  %l10 = alloca %StructLiteralCapture
  %l11 = alloca double
  %l12 = alloca %ExpressionContinuationCapture
  %l13 = alloca i8*
  %l14 = alloca %StructLiteralCapture
  %l15 = alloca double
  %l16 = alloca %ExpressionContinuationCapture
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca i8*
  %l20 = alloca %StructLiteralCapture
  %l21 = alloca double
  %l22 = alloca %ExpressionContinuationCapture
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca i8*
  %l26 = alloca i8*
  %l27 = alloca %MatchContext
  %l28 = alloca i8*
  %l29 = alloca i8*
  %l30 = alloca i64
  %l31 = alloca %MatchContext
  %l32 = alloca %LoweredCaseCondition
  %l33 = alloca %MatchContext
  %l34 = alloca i64
  %l35 = alloca %MatchContext
  %l36 = alloca i8*
  %l37 = alloca i8*
  %l38 = alloca i64
  %l39 = alloca %MatchContext
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { i8**, i64 }* %t9, { i8**, i64 }** %l1
  %t12 = extractvalue %NativeFunction %function, 1
  %t13 = call { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* %t12)
  store { i8**, i64 }* %t13, { i8**, i64 }** %l2
  %t14 = call i8* @malloc(i64 5)
  %t15 = bitcast i8* %t14 to [5 x i8]*
  store [5 x i8] c"def \00", [5 x i8]* %t15
  %t16 = extractvalue %NativeFunction %function, 0
  %t17 = call i8* @sanitize_identifier(i8* %t16)
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t14, i8* %t17)
  %t19 = add i64 0, 2
  %t20 = call i8* @malloc(i64 %t19)
  store i8 40, i8* %t20
  %t21 = getelementptr i8, i8* %t20, i64 1
  store i8 0, i8* %t21
  call void @sailfin_runtime_mark_persistent(i8* %t20)
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %t20)
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = call i8* @malloc(i64 3)
  %t25 = bitcast i8* %t24 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t25
  %t26 = call i8* @join_with_separator({ i8**, i64 }* %t23, i8* %t24)
  %t27 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t26)
  %t28 = call i8* @malloc(i64 3)
  %t29 = bitcast i8* %t28 to [3 x i8]*
  store [3 x i8] c"):\00", [3 x i8]* %t29
  %t30 = call i8* @sailfin_runtime_string_concat(i8* %t27, i8* %t28)
  store i8* %t30, i8** %l3
  %t31 = load %PythonBuilder, %PythonBuilder* %l0
  %t32 = load i8*, i8** %l3
  %t33 = call %PythonBuilder @builder_emit(%PythonBuilder %t31, i8* %t32)
  store %PythonBuilder %t33, %PythonBuilder* %l0
  %t34 = load %PythonBuilder, %PythonBuilder* %l0
  %t35 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t34)
  store %PythonBuilder %t35, %PythonBuilder* %l0
  %t36 = extractvalue %NativeFunction %function, 3
  %t37 = load { i8**, i64 }, { i8**, i64 }* %t36
  %t38 = extractvalue { i8**, i64 } %t37, 1
  %t39 = icmp sgt i64 %t38, 0
  %t40 = load %PythonBuilder, %PythonBuilder* %l0
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t43 = load i8*, i8** %l3
  br i1 %t39, label %then0, label %merge1
then0:
  %t44 = load %PythonBuilder, %PythonBuilder* %l0
  %t45 = call i8* @malloc(i64 12)
  %t46 = bitcast i8* %t45 to [12 x i8]*
  store [12 x i8] c"# effects: \00", [12 x i8]* %t46
  %t47 = extractvalue %NativeFunction %function, 3
  %t48 = call i8* @malloc(i64 3)
  %t49 = bitcast i8* %t48 to [3 x i8]*
  store [3 x i8] c", \00", [3 x i8]* %t49
  %t50 = call i8* @join_with_separator({ i8**, i64 }* %t47, i8* %t48)
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t50)
  %t52 = call %PythonBuilder @builder_emit(%PythonBuilder %t44, i8* %t51)
  store %PythonBuilder %t52, %PythonBuilder* %l0
  %t53 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge1
merge1:
  %t54 = phi %PythonBuilder [ %t53, %then0 ], [ %t40, %block.entry ]
  store %PythonBuilder %t54, %PythonBuilder* %l0
  %t55 = extractvalue %NativeFunction %function, 4
  %t56 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t55
  %t57 = extractvalue { %NativeInstruction*, i64 } %t56, 1
  %t58 = icmp eq i64 %t57, 0
  %t59 = load %PythonBuilder, %PythonBuilder* %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t62 = load i8*, i8** %l3
  br i1 %t58, label %then2, label %merge3
then2:
  %t63 = load %PythonBuilder, %PythonBuilder* %l0
  %t64 = call i8* @malloc(i64 5)
  %t65 = bitcast i8* %t64 to [5 x i8]*
  store [5 x i8] c"pass\00", [5 x i8]* %t65
  %t66 = call %PythonBuilder @builder_emit(%PythonBuilder %t63, i8* %t64)
  store %PythonBuilder %t66, %PythonBuilder* %l0
  %t67 = load %PythonBuilder, %PythonBuilder* %l0
  %t68 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t67)
  store %PythonBuilder %t68, %PythonBuilder* %l0
  %t69 = load %PythonBuilder, %PythonBuilder* %l0
  %t70 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t69, 0
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t72 = insertvalue %PythonFunctionEmission %t70, { i8**, i64 }* %t71, 1
  ret %PythonFunctionEmission %t72
merge3:
  %t73 = sitofp i64 0 to double
  store double %t73, double* %l4
  %t74 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t75 = ptrtoint [0 x %MatchContext]* %t74 to i64
  %t76 = icmp eq i64 %t75, 0
  %t77 = select i1 %t76, i64 1, i64 %t75
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to %MatchContext*
  %t80 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t81 = ptrtoint { %MatchContext*, i64 }* %t80 to i64
  %t82 = call i8* @malloc(i64 %t81)
  %t83 = bitcast i8* %t82 to { %MatchContext*, i64 }*
  %t84 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t83, i32 0, i32 0
  store %MatchContext* %t79, %MatchContext** %t84
  %t85 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t83, i32 0, i32 1
  store i64 0, i64* %t85
  store { %MatchContext*, i64 }* %t83, { %MatchContext*, i64 }** %l5
  %t86 = sitofp i64 0 to double
  store double %t86, double* %l6
  %t87 = sitofp i64 0 to double
  store double %t87, double* %l7
  %t88 = load %PythonBuilder, %PythonBuilder* %l0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t91 = load i8*, i8** %l3
  %t92 = load double, double* %l4
  %t93 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t94 = load double, double* %l6
  %t95 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t2616 = phi %PythonBuilder [ %t88, %merge3 ], [ %t2610, %loop.latch6 ]
  %t2617 = phi double [ %t95, %merge3 ], [ %t2611, %loop.latch6 ]
  %t2618 = phi double [ %t92, %merge3 ], [ %t2612, %loop.latch6 ]
  %t2619 = phi { i8**, i64 }* [ %t89, %merge3 ], [ %t2613, %loop.latch6 ]
  %t2620 = phi double [ %t94, %merge3 ], [ %t2614, %loop.latch6 ]
  %t2621 = phi { %MatchContext*, i64 }* [ %t93, %merge3 ], [ %t2615, %loop.latch6 ]
  store %PythonBuilder %t2616, %PythonBuilder* %l0
  store double %t2617, double* %l7
  store double %t2618, double* %l4
  store { i8**, i64 }* %t2619, { i8**, i64 }** %l1
  store double %t2620, double* %l6
  store { %MatchContext*, i64 }* %t2621, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t96 = load double, double* %l7
  %t97 = extractvalue %NativeFunction %function, 4
  %t98 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t97
  %t99 = extractvalue { %NativeInstruction*, i64 } %t98, 1
  %t100 = sitofp i64 %t99 to double
  %t101 = fcmp oge double %t96, %t100
  %t102 = load %PythonBuilder, %PythonBuilder* %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t105 = load i8*, i8** %l3
  %t106 = load double, double* %l4
  %t107 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t108 = load double, double* %l6
  %t109 = load double, double* %l7
  br i1 %t101, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t110 = extractvalue %NativeFunction %function, 4
  %t111 = load double, double* %l7
  %t112 = call double @llvm.round.f64(double %t111)
  %t113 = fptosi double %t112 to i64
  %t114 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t110
  %t115 = extractvalue { %NativeInstruction*, i64 } %t114, 0
  %t116 = extractvalue { %NativeInstruction*, i64 } %t114, 1
  %t117 = icmp uge i64 %t113, %t116
  ; bounds check: %t117 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t113, i64 %t116)
  %t118 = getelementptr %NativeInstruction, %NativeInstruction* %t115, i64 %t113
  %t119 = load %NativeInstruction, %NativeInstruction* %t118
  store %NativeInstruction %t119, %NativeInstruction* %l8
  %t120 = load %NativeInstruction, %NativeInstruction* %l8
  %t121 = extractvalue %NativeInstruction %t120, 0
  %t122 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t123 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t121, 0
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t121, 1
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t121, 2
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t121, 3
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t121, 4
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t121, 5
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t121, 6
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t121, 7
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t121, 8
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t121, 9
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t121, 10
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t121, 11
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t121, 12
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t121, 13
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t121, 14
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %t168 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t169 = icmp eq i32 %t121, 15
  %t170 = select i1 %t169, i8* %t168, i8* %t167
  %t171 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t172 = icmp eq i32 %t121, 16
  %t173 = select i1 %t172, i8* %t171, i8* %t170
  %t174 = call i8* @malloc(i64 7)
  %t175 = bitcast i8* %t174 to [7 x i8]*
  store [7 x i8] c"Return\00", [7 x i8]* %t175
  %t176 = call i1 @strings_equal(i8* %t173, i8* %t174)
  %t177 = load %PythonBuilder, %PythonBuilder* %l0
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t180 = load i8*, i8** %l3
  %t181 = load double, double* %l4
  %t182 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t183 = load double, double* %l6
  %t184 = load double, double* %l7
  %t185 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t176, label %then10, label %else11
then10:
  %t186 = load %NativeInstruction, %NativeInstruction* %l8
  %t187 = extractvalue %NativeInstruction %t186, 0
  %t188 = alloca %NativeInstruction
  store %NativeInstruction %t186, %NativeInstruction* %t188
  %t189 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t188, i32 0, i32 1
  %t190 = bitcast [16 x i8]* %t189 to i8*
  %t191 = bitcast i8* %t190 to i8**
  %t192 = load i8*, i8** %t191
  %t193 = icmp eq i32 %t187, 0
  %t194 = select i1 %t193, i8* %t192, i8* null
  %t195 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t188, i32 0, i32 1
  %t196 = bitcast [16 x i8]* %t195 to i8*
  %t197 = bitcast i8* %t196 to i8**
  %t198 = load i8*, i8** %t197
  %t199 = icmp eq i32 %t187, 1
  %t200 = select i1 %t199, i8* %t198, i8* %t194
  %t201 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t188, i32 0, i32 1
  %t202 = bitcast [8 x i8]* %t201 to i8*
  %t203 = bitcast i8* %t202 to i8**
  %t204 = load i8*, i8** %t203
  %t205 = icmp eq i32 %t187, 12
  %t206 = select i1 %t205, i8* %t204, i8* %t200
  %t207 = call i64 @sailfin_runtime_string_length(i8* %t206)
  %t208 = icmp eq i64 %t207, 0
  %t209 = load %PythonBuilder, %PythonBuilder* %l0
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t212 = load i8*, i8** %l3
  %t213 = load double, double* %l4
  %t214 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t215 = load double, double* %l6
  %t216 = load double, double* %l7
  %t217 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t208, label %then13, label %else14
then13:
  %t218 = load %PythonBuilder, %PythonBuilder* %l0
  %t219 = call i8* @malloc(i64 7)
  %t220 = bitcast i8* %t219 to [7 x i8]*
  store [7 x i8] c"return\00", [7 x i8]* %t220
  %t221 = call %PythonBuilder @builder_emit(%PythonBuilder %t218, i8* %t219)
  store %PythonBuilder %t221, %PythonBuilder* %l0
  %t222 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
else14:
  %t223 = load %NativeInstruction, %NativeInstruction* %l8
  %t224 = extractvalue %NativeInstruction %t223, 0
  %t225 = alloca %NativeInstruction
  store %NativeInstruction %t223, %NativeInstruction* %t225
  %t226 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t225, i32 0, i32 1
  %t227 = bitcast [16 x i8]* %t226 to i8*
  %t228 = bitcast i8* %t227 to i8**
  %t229 = load i8*, i8** %t228
  %t230 = icmp eq i32 %t224, 0
  %t231 = select i1 %t230, i8* %t229, i8* null
  %t232 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t225, i32 0, i32 1
  %t233 = bitcast [16 x i8]* %t232 to i8*
  %t234 = bitcast i8* %t233 to i8**
  %t235 = load i8*, i8** %t234
  %t236 = icmp eq i32 %t224, 1
  %t237 = select i1 %t236, i8* %t235, i8* %t231
  %t238 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t225, i32 0, i32 1
  %t239 = bitcast [8 x i8]* %t238 to i8*
  %t240 = bitcast i8* %t239 to i8**
  %t241 = load i8*, i8** %t240
  %t242 = icmp eq i32 %t224, 12
  %t243 = select i1 %t242, i8* %t241, i8* %t237
  store i8* %t243, i8** %l9
  %t244 = load i8*, i8** %l9
  %t245 = extractvalue %NativeFunction %function, 4
  %t246 = load double, double* %l7
  %t247 = sitofp i64 1 to double
  %t248 = fadd double %t246, %t247
  %t249 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t244, { %NativeInstruction*, i64 }* %t245, double %t248)
  store %StructLiteralCapture %t249, %StructLiteralCapture* %l10
  %t250 = sitofp i64 0 to double
  store double %t250, double* %l11
  %t251 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t252 = extractvalue %StructLiteralCapture %t251, 2
  %t253 = load %PythonBuilder, %PythonBuilder* %l0
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t256 = load i8*, i8** %l3
  %t257 = load double, double* %l4
  %t258 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t259 = load double, double* %l6
  %t260 = load double, double* %l7
  %t261 = load %NativeInstruction, %NativeInstruction* %l8
  %t262 = load i8*, i8** %l9
  %t263 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t264 = load double, double* %l11
  br i1 %t252, label %then16, label %else17
then16:
  %t265 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t266 = extractvalue %StructLiteralCapture %t265, 0
  store i8* %t266, i8** %l9
  %t267 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t268 = extractvalue %StructLiteralCapture %t267, 1
  store double %t268, double* %l11
  %t269 = load i8*, i8** %l9
  %t270 = load double, double* %l11
  br label %merge18
else17:
  %t271 = load i8*, i8** %l9
  %t272 = extractvalue %NativeFunction %function, 4
  %t273 = load double, double* %l7
  %t274 = sitofp i64 1 to double
  %t275 = fadd double %t273, %t274
  %t276 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t271, { %NativeInstruction*, i64 }* %t272, double %t275)
  store %ExpressionContinuationCapture %t276, %ExpressionContinuationCapture* %l12
  %t277 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t278 = extractvalue %ExpressionContinuationCapture %t277, 2
  %t279 = load %PythonBuilder, %PythonBuilder* %l0
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t282 = load i8*, i8** %l3
  %t283 = load double, double* %l4
  %t284 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t285 = load double, double* %l6
  %t286 = load double, double* %l7
  %t287 = load %NativeInstruction, %NativeInstruction* %l8
  %t288 = load i8*, i8** %l9
  %t289 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t290 = load double, double* %l11
  %t291 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  br i1 %t278, label %then19, label %merge20
then19:
  %t292 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t293 = extractvalue %ExpressionContinuationCapture %t292, 0
  store i8* %t293, i8** %l9
  %t294 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t295 = extractvalue %ExpressionContinuationCapture %t294, 1
  store double %t295, double* %l11
  %t296 = load i8*, i8** %l9
  %t297 = load double, double* %l11
  br label %merge20
merge20:
  %t298 = phi i8* [ %t296, %then19 ], [ %t288, %else17 ]
  %t299 = phi double [ %t297, %then19 ], [ %t290, %else17 ]
  store i8* %t298, i8** %l9
  store double %t299, double* %l11
  %t300 = load i8*, i8** %l9
  %t301 = load double, double* %l11
  br label %merge18
merge18:
  %t302 = phi i8* [ %t269, %then16 ], [ %t300, %merge20 ]
  %t303 = phi double [ %t270, %then16 ], [ %t301, %merge20 ]
  store i8* %t302, i8** %l9
  store double %t303, double* %l11
  %t304 = load %PythonBuilder, %PythonBuilder* %l0
  %t305 = call i8* @malloc(i64 8)
  %t306 = bitcast i8* %t305 to [8 x i8]*
  store [8 x i8] c"return \00", [8 x i8]* %t306
  %t307 = load i8*, i8** %l9
  %t308 = call i8* @lower_expression(i8* %t307)
  %t309 = call i8* @sailfin_runtime_string_concat(i8* %t305, i8* %t308)
  %t310 = call %PythonBuilder @builder_emit(%PythonBuilder %t304, i8* %t309)
  store %PythonBuilder %t310, %PythonBuilder* %l0
  %t311 = load double, double* %l7
  %t312 = load double, double* %l11
  %t313 = fadd double %t311, %t312
  store double %t313, double* %l7
  %t314 = load %PythonBuilder, %PythonBuilder* %l0
  %t315 = load double, double* %l7
  br label %merge15
merge15:
  %t316 = phi %PythonBuilder [ %t222, %then13 ], [ %t314, %merge18 ]
  %t317 = phi double [ %t216, %then13 ], [ %t315, %merge18 ]
  store %PythonBuilder %t316, %PythonBuilder* %l0
  store double %t317, double* %l7
  %t318 = load %PythonBuilder, %PythonBuilder* %l0
  %t319 = load %PythonBuilder, %PythonBuilder* %l0
  %t320 = load double, double* %l7
  br label %merge12
else11:
  %t321 = load %NativeInstruction, %NativeInstruction* %l8
  %t322 = extractvalue %NativeInstruction %t321, 0
  %t323 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t324 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t322, 0
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t322, 1
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t322, 2
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t322, 3
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t322, 4
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t322, 5
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t322, 6
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t322, 7
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t322, 8
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t322, 9
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t322, 10
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t322, 11
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t322, 12
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t322, 13
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %t366 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t367 = icmp eq i32 %t322, 14
  %t368 = select i1 %t367, i8* %t366, i8* %t365
  %t369 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t370 = icmp eq i32 %t322, 15
  %t371 = select i1 %t370, i8* %t369, i8* %t368
  %t372 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t373 = icmp eq i32 %t322, 16
  %t374 = select i1 %t373, i8* %t372, i8* %t371
  %t375 = call i8* @malloc(i64 11)
  %t376 = bitcast i8* %t375 to [11 x i8]*
  store [11 x i8] c"Expression\00", [11 x i8]* %t376
  %t377 = call i1 @strings_equal(i8* %t374, i8* %t375)
  %t378 = load %PythonBuilder, %PythonBuilder* %l0
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t381 = load i8*, i8** %l3
  %t382 = load double, double* %l4
  %t383 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t384 = load double, double* %l6
  %t385 = load double, double* %l7
  %t386 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t377, label %then21, label %else22
then21:
  %t387 = load %NativeInstruction, %NativeInstruction* %l8
  %t388 = extractvalue %NativeInstruction %t387, 0
  %t389 = alloca %NativeInstruction
  store %NativeInstruction %t387, %NativeInstruction* %t389
  %t390 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t389, i32 0, i32 1
  %t391 = bitcast [16 x i8]* %t390 to i8*
  %t392 = bitcast i8* %t391 to i8**
  %t393 = load i8*, i8** %t392
  %t394 = icmp eq i32 %t388, 0
  %t395 = select i1 %t394, i8* %t393, i8* null
  %t396 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t389, i32 0, i32 1
  %t397 = bitcast [16 x i8]* %t396 to i8*
  %t398 = bitcast i8* %t397 to i8**
  %t399 = load i8*, i8** %t398
  %t400 = icmp eq i32 %t388, 1
  %t401 = select i1 %t400, i8* %t399, i8* %t395
  %t402 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t389, i32 0, i32 1
  %t403 = bitcast [8 x i8]* %t402 to i8*
  %t404 = bitcast i8* %t403 to i8**
  %t405 = load i8*, i8** %t404
  %t406 = icmp eq i32 %t388, 12
  %t407 = select i1 %t406, i8* %t405, i8* %t401
  store i8* %t407, i8** %l13
  %t408 = load i8*, i8** %l13
  %t409 = extractvalue %NativeFunction %function, 4
  %t410 = load double, double* %l7
  %t411 = sitofp i64 1 to double
  %t412 = fadd double %t410, %t411
  %t413 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t408, { %NativeInstruction*, i64 }* %t409, double %t412)
  store %StructLiteralCapture %t413, %StructLiteralCapture* %l14
  %t414 = sitofp i64 0 to double
  store double %t414, double* %l15
  %t415 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t416 = extractvalue %StructLiteralCapture %t415, 2
  %t417 = load %PythonBuilder, %PythonBuilder* %l0
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t420 = load i8*, i8** %l3
  %t421 = load double, double* %l4
  %t422 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t423 = load double, double* %l6
  %t424 = load double, double* %l7
  %t425 = load %NativeInstruction, %NativeInstruction* %l8
  %t426 = load i8*, i8** %l13
  %t427 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t428 = load double, double* %l15
  br i1 %t416, label %then24, label %else25
then24:
  %t429 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t430 = extractvalue %StructLiteralCapture %t429, 0
  store i8* %t430, i8** %l13
  %t431 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t432 = extractvalue %StructLiteralCapture %t431, 1
  store double %t432, double* %l15
  %t433 = load i8*, i8** %l13
  %t434 = load double, double* %l15
  br label %merge26
else25:
  %t435 = load i8*, i8** %l13
  %t436 = extractvalue %NativeFunction %function, 4
  %t437 = load double, double* %l7
  %t438 = sitofp i64 1 to double
  %t439 = fadd double %t437, %t438
  %t440 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t435, { %NativeInstruction*, i64 }* %t436, double %t439)
  store %ExpressionContinuationCapture %t440, %ExpressionContinuationCapture* %l16
  %t441 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t442 = extractvalue %ExpressionContinuationCapture %t441, 2
  %t443 = load %PythonBuilder, %PythonBuilder* %l0
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t446 = load i8*, i8** %l3
  %t447 = load double, double* %l4
  %t448 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t449 = load double, double* %l6
  %t450 = load double, double* %l7
  %t451 = load %NativeInstruction, %NativeInstruction* %l8
  %t452 = load i8*, i8** %l13
  %t453 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t454 = load double, double* %l15
  %t455 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  br i1 %t442, label %then27, label %merge28
then27:
  %t456 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t457 = extractvalue %ExpressionContinuationCapture %t456, 0
  store i8* %t457, i8** %l13
  %t458 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t459 = extractvalue %ExpressionContinuationCapture %t458, 1
  store double %t459, double* %l15
  %t460 = load i8*, i8** %l13
  %t461 = load double, double* %l15
  br label %merge28
merge28:
  %t462 = phi i8* [ %t460, %then27 ], [ %t452, %else25 ]
  %t463 = phi double [ %t461, %then27 ], [ %t454, %else25 ]
  store i8* %t462, i8** %l13
  store double %t463, double* %l15
  %t464 = load i8*, i8** %l13
  %t465 = load double, double* %l15
  br label %merge26
merge26:
  %t466 = phi i8* [ %t433, %then24 ], [ %t464, %merge28 ]
  %t467 = phi double [ %t434, %then24 ], [ %t465, %merge28 ]
  store i8* %t466, i8** %l13
  store double %t467, double* %l15
  %t468 = load %PythonBuilder, %PythonBuilder* %l0
  %t469 = load i8*, i8** %l13
  %t470 = call i8* @lower_expression(i8* %t469)
  %t471 = call %PythonBuilder @builder_emit(%PythonBuilder %t468, i8* %t470)
  store %PythonBuilder %t471, %PythonBuilder* %l0
  %t472 = load double, double* %l7
  %t473 = load double, double* %l15
  %t474 = fadd double %t472, %t473
  store double %t474, double* %l7
  %t475 = load %PythonBuilder, %PythonBuilder* %l0
  %t476 = load double, double* %l7
  br label %merge23
else22:
  %t477 = load %NativeInstruction, %NativeInstruction* %l8
  %t478 = extractvalue %NativeInstruction %t477, 0
  %t479 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t480 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t481 = icmp eq i32 %t478, 0
  %t482 = select i1 %t481, i8* %t480, i8* %t479
  %t483 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t484 = icmp eq i32 %t478, 1
  %t485 = select i1 %t484, i8* %t483, i8* %t482
  %t486 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t487 = icmp eq i32 %t478, 2
  %t488 = select i1 %t487, i8* %t486, i8* %t485
  %t489 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t490 = icmp eq i32 %t478, 3
  %t491 = select i1 %t490, i8* %t489, i8* %t488
  %t492 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t493 = icmp eq i32 %t478, 4
  %t494 = select i1 %t493, i8* %t492, i8* %t491
  %t495 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t496 = icmp eq i32 %t478, 5
  %t497 = select i1 %t496, i8* %t495, i8* %t494
  %t498 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t499 = icmp eq i32 %t478, 6
  %t500 = select i1 %t499, i8* %t498, i8* %t497
  %t501 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t502 = icmp eq i32 %t478, 7
  %t503 = select i1 %t502, i8* %t501, i8* %t500
  %t504 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t505 = icmp eq i32 %t478, 8
  %t506 = select i1 %t505, i8* %t504, i8* %t503
  %t507 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t508 = icmp eq i32 %t478, 9
  %t509 = select i1 %t508, i8* %t507, i8* %t506
  %t510 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t511 = icmp eq i32 %t478, 10
  %t512 = select i1 %t511, i8* %t510, i8* %t509
  %t513 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t514 = icmp eq i32 %t478, 11
  %t515 = select i1 %t514, i8* %t513, i8* %t512
  %t516 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t517 = icmp eq i32 %t478, 12
  %t518 = select i1 %t517, i8* %t516, i8* %t515
  %t519 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t520 = icmp eq i32 %t478, 13
  %t521 = select i1 %t520, i8* %t519, i8* %t518
  %t522 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t523 = icmp eq i32 %t478, 14
  %t524 = select i1 %t523, i8* %t522, i8* %t521
  %t525 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t526 = icmp eq i32 %t478, 15
  %t527 = select i1 %t526, i8* %t525, i8* %t524
  %t528 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t529 = icmp eq i32 %t478, 16
  %t530 = select i1 %t529, i8* %t528, i8* %t527
  %t531 = call i8* @malloc(i64 4)
  %t532 = bitcast i8* %t531 to [4 x i8]*
  store [4 x i8] c"Let\00", [4 x i8]* %t532
  %t533 = call i1 @strings_equal(i8* %t530, i8* %t531)
  %t534 = load %PythonBuilder, %PythonBuilder* %l0
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t537 = load i8*, i8** %l3
  %t538 = load double, double* %l4
  %t539 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t540 = load double, double* %l6
  %t541 = load double, double* %l7
  %t542 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t533, label %then29, label %else30
then29:
  %t543 = load %NativeInstruction, %NativeInstruction* %l8
  %t544 = extractvalue %NativeInstruction %t543, 0
  %t545 = alloca %NativeInstruction
  store %NativeInstruction %t543, %NativeInstruction* %t545
  %t546 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t545, i32 0, i32 1
  %t547 = bitcast [48 x i8]* %t546 to i8*
  %t548 = bitcast i8* %t547 to i8**
  %t549 = load i8*, i8** %t548
  %t550 = icmp eq i32 %t544, 2
  %t551 = select i1 %t550, i8* %t549, i8* null
  %t552 = call i8* @sanitize_identifier(i8* %t551)
  store i8* %t552, i8** %l17
  %t553 = load i8*, i8** %l17
  %t554 = call i8* @malloc(i64 4)
  %t555 = bitcast i8* %t554 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t555
  %t556 = call i8* @sailfin_runtime_string_concat(i8* %t553, i8* %t554)
  store i8* %t556, i8** %l18
  %t557 = load %NativeInstruction, %NativeInstruction* %l8
  %t558 = extractvalue %NativeInstruction %t557, 0
  %t559 = alloca %NativeInstruction
  store %NativeInstruction %t557, %NativeInstruction* %t559
  %t560 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t559, i32 0, i32 1
  %t561 = bitcast [48 x i8]* %t560 to i8*
  %t562 = getelementptr inbounds i8, i8* %t561, i64 24
  %t563 = bitcast i8* %t562 to i8**
  %t564 = load i8*, i8** %t563
  %t565 = icmp eq i32 %t558, 2
  %t566 = select i1 %t565, i8* %t564, i8* null
  %t567 = icmp ne i8* %t566, null
  %t568 = load %PythonBuilder, %PythonBuilder* %l0
  %t569 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t571 = load i8*, i8** %l3
  %t572 = load double, double* %l4
  %t573 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t574 = load double, double* %l6
  %t575 = load double, double* %l7
  %t576 = load %NativeInstruction, %NativeInstruction* %l8
  %t577 = load i8*, i8** %l17
  %t578 = load i8*, i8** %l18
  br i1 %t567, label %then32, label %else33
then32:
  %t579 = load %NativeInstruction, %NativeInstruction* %l8
  %t580 = extractvalue %NativeInstruction %t579, 0
  %t581 = alloca %NativeInstruction
  store %NativeInstruction %t579, %NativeInstruction* %t581
  %t582 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t581, i32 0, i32 1
  %t583 = bitcast [48 x i8]* %t582 to i8*
  %t584 = getelementptr inbounds i8, i8* %t583, i64 24
  %t585 = bitcast i8* %t584 to i8**
  %t586 = load i8*, i8** %t585
  %t587 = icmp eq i32 %t580, 2
  %t588 = select i1 %t587, i8* %t586, i8* null
  store i8* %t588, i8** %l19
  %t589 = load i8*, i8** %l19
  %t590 = extractvalue %NativeFunction %function, 4
  %t591 = load double, double* %l7
  %t592 = sitofp i64 1 to double
  %t593 = fadd double %t591, %t592
  %t594 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t589, { %NativeInstruction*, i64 }* %t590, double %t593)
  store %StructLiteralCapture %t594, %StructLiteralCapture* %l20
  %t595 = sitofp i64 0 to double
  store double %t595, double* %l21
  %t596 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t597 = extractvalue %StructLiteralCapture %t596, 2
  %t598 = load %PythonBuilder, %PythonBuilder* %l0
  %t599 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t600 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t601 = load i8*, i8** %l3
  %t602 = load double, double* %l4
  %t603 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t604 = load double, double* %l6
  %t605 = load double, double* %l7
  %t606 = load %NativeInstruction, %NativeInstruction* %l8
  %t607 = load i8*, i8** %l17
  %t608 = load i8*, i8** %l18
  %t609 = load i8*, i8** %l19
  %t610 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t611 = load double, double* %l21
  br i1 %t597, label %then35, label %else36
then35:
  %t612 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t613 = extractvalue %StructLiteralCapture %t612, 0
  store i8* %t613, i8** %l19
  %t614 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t615 = extractvalue %StructLiteralCapture %t614, 1
  store double %t615, double* %l21
  %t616 = load i8*, i8** %l19
  %t617 = load double, double* %l21
  br label %merge37
else36:
  %t618 = load i8*, i8** %l19
  %t619 = extractvalue %NativeFunction %function, 4
  %t620 = load double, double* %l7
  %t621 = sitofp i64 1 to double
  %t622 = fadd double %t620, %t621
  %t623 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t618, { %NativeInstruction*, i64 }* %t619, double %t622)
  store %ExpressionContinuationCapture %t623, %ExpressionContinuationCapture* %l22
  %t624 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t625 = extractvalue %ExpressionContinuationCapture %t624, 2
  %t626 = load %PythonBuilder, %PythonBuilder* %l0
  %t627 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t629 = load i8*, i8** %l3
  %t630 = load double, double* %l4
  %t631 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t632 = load double, double* %l6
  %t633 = load double, double* %l7
  %t634 = load %NativeInstruction, %NativeInstruction* %l8
  %t635 = load i8*, i8** %l17
  %t636 = load i8*, i8** %l18
  %t637 = load i8*, i8** %l19
  %t638 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t639 = load double, double* %l21
  %t640 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  br i1 %t625, label %then38, label %merge39
then38:
  %t641 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t642 = extractvalue %ExpressionContinuationCapture %t641, 0
  store i8* %t642, i8** %l19
  %t643 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t644 = extractvalue %ExpressionContinuationCapture %t643, 1
  store double %t644, double* %l21
  %t645 = load i8*, i8** %l19
  %t646 = load double, double* %l21
  br label %merge39
merge39:
  %t647 = phi i8* [ %t645, %then38 ], [ %t637, %else36 ]
  %t648 = phi double [ %t646, %then38 ], [ %t639, %else36 ]
  store i8* %t647, i8** %l19
  store double %t648, double* %l21
  %t649 = load i8*, i8** %l19
  %t650 = load double, double* %l21
  br label %merge37
merge37:
  %t651 = phi i8* [ %t616, %then35 ], [ %t649, %merge39 ]
  %t652 = phi double [ %t617, %then35 ], [ %t650, %merge39 ]
  store i8* %t651, i8** %l19
  store double %t652, double* %l21
  %t653 = load i8*, i8** %l18
  %t654 = load i8*, i8** %l19
  %t655 = call i8* @lower_expression(i8* %t654)
  %t656 = call i8* @sailfin_runtime_string_concat(i8* %t653, i8* %t655)
  store i8* %t656, i8** %l18
  %t657 = load double, double* %l7
  %t658 = load double, double* %l21
  %t659 = fadd double %t657, %t658
  store double %t659, double* %l7
  %t660 = load i8*, i8** %l18
  %t661 = load double, double* %l7
  br label %merge34
else33:
  %t662 = load i8*, i8** %l18
  %t663 = call i8* @malloc(i64 5)
  %t664 = bitcast i8* %t663 to [5 x i8]*
  store [5 x i8] c"None\00", [5 x i8]* %t664
  %t665 = call i8* @sailfin_runtime_string_concat(i8* %t662, i8* %t663)
  store i8* %t665, i8** %l18
  %t666 = load i8*, i8** %l18
  br label %merge34
merge34:
  %t667 = phi i8* [ %t660, %merge37 ], [ %t666, %else33 ]
  %t668 = phi double [ %t661, %merge37 ], [ %t575, %else33 ]
  store i8* %t667, i8** %l18
  store double %t668, double* %l7
  %t669 = load %PythonBuilder, %PythonBuilder* %l0
  %t670 = load i8*, i8** %l18
  %t671 = call %PythonBuilder @builder_emit(%PythonBuilder %t669, i8* %t670)
  store %PythonBuilder %t671, %PythonBuilder* %l0
  %t672 = load double, double* %l7
  %t673 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
else30:
  %t674 = load %NativeInstruction, %NativeInstruction* %l8
  %t675 = extractvalue %NativeInstruction %t674, 0
  %t676 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t677 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t675, 0
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t675, 1
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t675, 2
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t675, 3
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t675, 4
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t675, 5
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t675, 6
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t675, 7
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t675, 8
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t675, 9
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t675, 10
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t675, 11
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t675, 12
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %t716 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t717 = icmp eq i32 %t675, 13
  %t718 = select i1 %t717, i8* %t716, i8* %t715
  %t719 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t720 = icmp eq i32 %t675, 14
  %t721 = select i1 %t720, i8* %t719, i8* %t718
  %t722 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t723 = icmp eq i32 %t675, 15
  %t724 = select i1 %t723, i8* %t722, i8* %t721
  %t725 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t726 = icmp eq i32 %t675, 16
  %t727 = select i1 %t726, i8* %t725, i8* %t724
  %t728 = call i8* @malloc(i64 3)
  %t729 = bitcast i8* %t728 to [3 x i8]*
  store [3 x i8] c"If\00", [3 x i8]* %t729
  %t730 = call i1 @strings_equal(i8* %t727, i8* %t728)
  %t731 = load %PythonBuilder, %PythonBuilder* %l0
  %t732 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t733 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t734 = load i8*, i8** %l3
  %t735 = load double, double* %l4
  %t736 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t737 = load double, double* %l6
  %t738 = load double, double* %l7
  %t739 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t730, label %then40, label %else41
then40:
  %t740 = load %NativeInstruction, %NativeInstruction* %l8
  %t741 = extractvalue %NativeInstruction %t740, 0
  %t742 = alloca %NativeInstruction
  store %NativeInstruction %t740, %NativeInstruction* %t742
  %t743 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t742, i32 0, i32 1
  %t744 = bitcast [8 x i8]* %t743 to i8*
  %t745 = bitcast i8* %t744 to i8**
  %t746 = load i8*, i8** %t745
  %t747 = icmp eq i32 %t741, 3
  %t748 = select i1 %t747, i8* %t746, i8* null
  %t749 = call i8* @trim_text(i8* %t748)
  %t750 = call i8* @rewrite_expression_intrinsics(i8* %t749)
  store i8* %t750, i8** %l23
  %t751 = load %PythonBuilder, %PythonBuilder* %l0
  %t752 = call i8* @malloc(i64 4)
  %t753 = bitcast i8* %t752 to [4 x i8]*
  store [4 x i8] c"if \00", [4 x i8]* %t753
  %t754 = load i8*, i8** %l23
  %t755 = call i8* @sailfin_runtime_string_concat(i8* %t752, i8* %t754)
  %t756 = add i64 0, 2
  %t757 = call i8* @malloc(i64 %t756)
  store i8 58, i8* %t757
  %t758 = getelementptr i8, i8* %t757, i64 1
  store i8 0, i8* %t758
  call void @sailfin_runtime_mark_persistent(i8* %t757)
  %t759 = call i8* @sailfin_runtime_string_concat(i8* %t755, i8* %t757)
  %t760 = call %PythonBuilder @builder_emit(%PythonBuilder %t751, i8* %t759)
  store %PythonBuilder %t760, %PythonBuilder* %l0
  %t761 = load %PythonBuilder, %PythonBuilder* %l0
  %t762 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t761)
  store %PythonBuilder %t762, %PythonBuilder* %l0
  %t763 = load double, double* %l4
  %t764 = sitofp i64 1 to double
  %t765 = fadd double %t763, %t764
  store double %t765, double* %l4
  %t766 = load %PythonBuilder, %PythonBuilder* %l0
  %t767 = load %PythonBuilder, %PythonBuilder* %l0
  %t768 = load double, double* %l4
  br label %merge42
else41:
  %t769 = load %NativeInstruction, %NativeInstruction* %l8
  %t770 = extractvalue %NativeInstruction %t769, 0
  %t771 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t772 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t770, 0
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t770, 1
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t770, 2
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t770, 3
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t770, 4
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t770, 5
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t770, 6
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t770, 7
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t770, 8
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t770, 9
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t770, 10
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t770, 11
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %t808 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t809 = icmp eq i32 %t770, 12
  %t810 = select i1 %t809, i8* %t808, i8* %t807
  %t811 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t812 = icmp eq i32 %t770, 13
  %t813 = select i1 %t812, i8* %t811, i8* %t810
  %t814 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t815 = icmp eq i32 %t770, 14
  %t816 = select i1 %t815, i8* %t814, i8* %t813
  %t817 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t818 = icmp eq i32 %t770, 15
  %t819 = select i1 %t818, i8* %t817, i8* %t816
  %t820 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t821 = icmp eq i32 %t770, 16
  %t822 = select i1 %t821, i8* %t820, i8* %t819
  %t823 = call i8* @malloc(i64 5)
  %t824 = bitcast i8* %t823 to [5 x i8]*
  store [5 x i8] c"Else\00", [5 x i8]* %t824
  %t825 = call i1 @strings_equal(i8* %t822, i8* %t823)
  %t826 = load %PythonBuilder, %PythonBuilder* %l0
  %t827 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t828 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t829 = load i8*, i8** %l3
  %t830 = load double, double* %l4
  %t831 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t832 = load double, double* %l6
  %t833 = load double, double* %l7
  %t834 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t825, label %then43, label %else44
then43:
  %t835 = load double, double* %l4
  %t836 = sitofp i64 0 to double
  %t837 = fcmp ogt double %t835, %t836
  %t838 = load %PythonBuilder, %PythonBuilder* %l0
  %t839 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t840 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t841 = load i8*, i8** %l3
  %t842 = load double, double* %l4
  %t843 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t844 = load double, double* %l6
  %t845 = load double, double* %l7
  %t846 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t837, label %then46, label %else47
then46:
  %t847 = load %PythonBuilder, %PythonBuilder* %l0
  %t848 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t847)
  store %PythonBuilder %t848, %PythonBuilder* %l0
  %t849 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge48
else47:
  %t850 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t851 = extractvalue %NativeFunction %function, 0
  %t852 = call i8* @malloc(i64 25)
  %t853 = bitcast i8* %t852 to [25 x i8]*
  store [25 x i8] c"else without matching if\00", [25 x i8]* %t853
  %t854 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t850, i8* %t851, i8* %t852)
  store { i8**, i64 }* %t854, { i8**, i64 }** %l1
  %t855 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t856 = phi %PythonBuilder [ %t849, %then46 ], [ %t838, %else47 ]
  %t857 = phi { i8**, i64 }* [ %t839, %then46 ], [ %t855, %else47 ]
  store %PythonBuilder %t856, %PythonBuilder* %l0
  store { i8**, i64 }* %t857, { i8**, i64 }** %l1
  %t858 = load %PythonBuilder, %PythonBuilder* %l0
  %t859 = call i8* @malloc(i64 6)
  %t860 = bitcast i8* %t859 to [6 x i8]*
  store [6 x i8] c"else:\00", [6 x i8]* %t860
  %t861 = call %PythonBuilder @builder_emit(%PythonBuilder %t858, i8* %t859)
  store %PythonBuilder %t861, %PythonBuilder* %l0
  %t862 = load %PythonBuilder, %PythonBuilder* %l0
  %t863 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t862)
  store %PythonBuilder %t863, %PythonBuilder* %l0
  %t864 = load %PythonBuilder, %PythonBuilder* %l0
  %t865 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t866 = load %PythonBuilder, %PythonBuilder* %l0
  %t867 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
else44:
  %t868 = load %NativeInstruction, %NativeInstruction* %l8
  %t869 = extractvalue %NativeInstruction %t868, 0
  %t870 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t871 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t869, 0
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t869, 1
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t869, 2
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t869, 3
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t869, 4
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t869, 5
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t869, 6
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t869, 7
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t869, 8
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t869, 9
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t869, 10
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %t904 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t905 = icmp eq i32 %t869, 11
  %t906 = select i1 %t905, i8* %t904, i8* %t903
  %t907 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t908 = icmp eq i32 %t869, 12
  %t909 = select i1 %t908, i8* %t907, i8* %t906
  %t910 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t911 = icmp eq i32 %t869, 13
  %t912 = select i1 %t911, i8* %t910, i8* %t909
  %t913 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t914 = icmp eq i32 %t869, 14
  %t915 = select i1 %t914, i8* %t913, i8* %t912
  %t916 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t917 = icmp eq i32 %t869, 15
  %t918 = select i1 %t917, i8* %t916, i8* %t915
  %t919 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t920 = icmp eq i32 %t869, 16
  %t921 = select i1 %t920, i8* %t919, i8* %t918
  %t922 = call i8* @malloc(i64 6)
  %t923 = bitcast i8* %t922 to [6 x i8]*
  store [6 x i8] c"EndIf\00", [6 x i8]* %t923
  %t924 = call i1 @strings_equal(i8* %t921, i8* %t922)
  %t925 = load %PythonBuilder, %PythonBuilder* %l0
  %t926 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t927 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t928 = load i8*, i8** %l3
  %t929 = load double, double* %l4
  %t930 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t931 = load double, double* %l6
  %t932 = load double, double* %l7
  %t933 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t924, label %then49, label %else50
then49:
  %t934 = load double, double* %l4
  %t935 = sitofp i64 0 to double
  %t936 = fcmp ogt double %t934, %t935
  %t937 = load %PythonBuilder, %PythonBuilder* %l0
  %t938 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t939 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t940 = load i8*, i8** %l3
  %t941 = load double, double* %l4
  %t942 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t943 = load double, double* %l6
  %t944 = load double, double* %l7
  %t945 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t936, label %then52, label %else53
then52:
  %t946 = load %PythonBuilder, %PythonBuilder* %l0
  %t947 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t946)
  store %PythonBuilder %t947, %PythonBuilder* %l0
  %t948 = load double, double* %l4
  %t949 = sitofp i64 1 to double
  %t950 = fsub double %t948, %t949
  store double %t950, double* %l4
  %t951 = load %PythonBuilder, %PythonBuilder* %l0
  %t952 = load double, double* %l4
  br label %merge54
else53:
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t954 = extractvalue %NativeFunction %function, 0
  %t955 = call i8* @malloc(i64 26)
  %t956 = bitcast i8* %t955 to [26 x i8]*
  store [26 x i8] c"endif without matching if\00", [26 x i8]* %t956
  %t957 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t953, i8* %t954, i8* %t955)
  store { i8**, i64 }* %t957, { i8**, i64 }** %l1
  %t958 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge54
merge54:
  %t959 = phi %PythonBuilder [ %t951, %then52 ], [ %t937, %else53 ]
  %t960 = phi double [ %t952, %then52 ], [ %t941, %else53 ]
  %t961 = phi { i8**, i64 }* [ %t938, %then52 ], [ %t958, %else53 ]
  store %PythonBuilder %t959, %PythonBuilder* %l0
  store double %t960, double* %l4
  store { i8**, i64 }* %t961, { i8**, i64 }** %l1
  %t962 = load %PythonBuilder, %PythonBuilder* %l0
  %t963 = load double, double* %l4
  %t964 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge51
else50:
  %t965 = load %NativeInstruction, %NativeInstruction* %l8
  %t966 = extractvalue %NativeInstruction %t965, 0
  %t967 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t968 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t966, 0
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t966, 1
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t966, 2
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t966, 3
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t966, 4
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t966, 5
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t966, 6
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t966, 7
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t966, 8
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t966, 9
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t966, 10
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %t1001 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1002 = icmp eq i32 %t966, 11
  %t1003 = select i1 %t1002, i8* %t1001, i8* %t1000
  %t1004 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1005 = icmp eq i32 %t966, 12
  %t1006 = select i1 %t1005, i8* %t1004, i8* %t1003
  %t1007 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1008 = icmp eq i32 %t966, 13
  %t1009 = select i1 %t1008, i8* %t1007, i8* %t1006
  %t1010 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1011 = icmp eq i32 %t966, 14
  %t1012 = select i1 %t1011, i8* %t1010, i8* %t1009
  %t1013 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1014 = icmp eq i32 %t966, 15
  %t1015 = select i1 %t1014, i8* %t1013, i8* %t1012
  %t1016 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1017 = icmp eq i32 %t966, 16
  %t1018 = select i1 %t1017, i8* %t1016, i8* %t1015
  %t1019 = call i8* @malloc(i64 4)
  %t1020 = bitcast i8* %t1019 to [4 x i8]*
  store [4 x i8] c"For\00", [4 x i8]* %t1020
  %t1021 = call i1 @strings_equal(i8* %t1018, i8* %t1019)
  %t1022 = load %PythonBuilder, %PythonBuilder* %l0
  %t1023 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1024 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1025 = load i8*, i8** %l3
  %t1026 = load double, double* %l4
  %t1027 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1028 = load double, double* %l6
  %t1029 = load double, double* %l7
  %t1030 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1021, label %then55, label %else56
then55:
  %t1031 = load %NativeInstruction, %NativeInstruction* %l8
  %t1032 = extractvalue %NativeInstruction %t1031, 0
  %t1033 = alloca %NativeInstruction
  store %NativeInstruction %t1031, %NativeInstruction* %t1033
  %t1034 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1033, i32 0, i32 1
  %t1035 = bitcast [16 x i8]* %t1034 to i8*
  %t1036 = getelementptr inbounds i8, i8* %t1035, i64 8
  %t1037 = bitcast i8* %t1036 to i8**
  %t1038 = load i8*, i8** %t1037
  %t1039 = icmp eq i32 %t1032, 6
  %t1040 = select i1 %t1039, i8* %t1038, i8* null
  %t1041 = call i8* @trim_text(i8* %t1040)
  %t1042 = call i8* @rewrite_expression_intrinsics(i8* %t1041)
  store i8* %t1042, i8** %l24
  %t1043 = load %PythonBuilder, %PythonBuilder* %l0
  %t1044 = call i8* @malloc(i64 5)
  %t1045 = bitcast i8* %t1044 to [5 x i8]*
  store [5 x i8] c"for \00", [5 x i8]* %t1045
  %t1046 = load %NativeInstruction, %NativeInstruction* %l8
  %t1047 = extractvalue %NativeInstruction %t1046, 0
  %t1048 = alloca %NativeInstruction
  store %NativeInstruction %t1046, %NativeInstruction* %t1048
  %t1049 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1048, i32 0, i32 1
  %t1050 = bitcast [16 x i8]* %t1049 to i8*
  %t1051 = bitcast i8* %t1050 to i8**
  %t1052 = load i8*, i8** %t1051
  %t1053 = icmp eq i32 %t1047, 6
  %t1054 = select i1 %t1053, i8* %t1052, i8* null
  %t1055 = call i8* @sailfin_runtime_string_concat(i8* %t1044, i8* %t1054)
  %t1056 = call i8* @malloc(i64 5)
  %t1057 = bitcast i8* %t1056 to [5 x i8]*
  store [5 x i8] c" in \00", [5 x i8]* %t1057
  %t1058 = call i8* @sailfin_runtime_string_concat(i8* %t1055, i8* %t1056)
  %t1059 = load i8*, i8** %l24
  %t1060 = call i8* @sailfin_runtime_string_concat(i8* %t1058, i8* %t1059)
  %t1061 = add i64 0, 2
  %t1062 = call i8* @malloc(i64 %t1061)
  store i8 58, i8* %t1062
  %t1063 = getelementptr i8, i8* %t1062, i64 1
  store i8 0, i8* %t1063
  call void @sailfin_runtime_mark_persistent(i8* %t1062)
  %t1064 = call i8* @sailfin_runtime_string_concat(i8* %t1060, i8* %t1062)
  %t1065 = call %PythonBuilder @builder_emit(%PythonBuilder %t1043, i8* %t1064)
  store %PythonBuilder %t1065, %PythonBuilder* %l0
  %t1066 = load %PythonBuilder, %PythonBuilder* %l0
  %t1067 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1066)
  store %PythonBuilder %t1067, %PythonBuilder* %l0
  %t1068 = load double, double* %l4
  %t1069 = sitofp i64 1 to double
  %t1070 = fadd double %t1068, %t1069
  store double %t1070, double* %l4
  %t1071 = load %PythonBuilder, %PythonBuilder* %l0
  %t1072 = load %PythonBuilder, %PythonBuilder* %l0
  %t1073 = load double, double* %l4
  br label %merge57
else56:
  %t1074 = load %NativeInstruction, %NativeInstruction* %l8
  %t1075 = extractvalue %NativeInstruction %t1074, 0
  %t1076 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1077 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1078 = icmp eq i32 %t1075, 0
  %t1079 = select i1 %t1078, i8* %t1077, i8* %t1076
  %t1080 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1081 = icmp eq i32 %t1075, 1
  %t1082 = select i1 %t1081, i8* %t1080, i8* %t1079
  %t1083 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1084 = icmp eq i32 %t1075, 2
  %t1085 = select i1 %t1084, i8* %t1083, i8* %t1082
  %t1086 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1087 = icmp eq i32 %t1075, 3
  %t1088 = select i1 %t1087, i8* %t1086, i8* %t1085
  %t1089 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1090 = icmp eq i32 %t1075, 4
  %t1091 = select i1 %t1090, i8* %t1089, i8* %t1088
  %t1092 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1093 = icmp eq i32 %t1075, 5
  %t1094 = select i1 %t1093, i8* %t1092, i8* %t1091
  %t1095 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1096 = icmp eq i32 %t1075, 6
  %t1097 = select i1 %t1096, i8* %t1095, i8* %t1094
  %t1098 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1099 = icmp eq i32 %t1075, 7
  %t1100 = select i1 %t1099, i8* %t1098, i8* %t1097
  %t1101 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1102 = icmp eq i32 %t1075, 8
  %t1103 = select i1 %t1102, i8* %t1101, i8* %t1100
  %t1104 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1105 = icmp eq i32 %t1075, 9
  %t1106 = select i1 %t1105, i8* %t1104, i8* %t1103
  %t1107 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1108 = icmp eq i32 %t1075, 10
  %t1109 = select i1 %t1108, i8* %t1107, i8* %t1106
  %t1110 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1111 = icmp eq i32 %t1075, 11
  %t1112 = select i1 %t1111, i8* %t1110, i8* %t1109
  %t1113 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1114 = icmp eq i32 %t1075, 12
  %t1115 = select i1 %t1114, i8* %t1113, i8* %t1112
  %t1116 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1117 = icmp eq i32 %t1075, 13
  %t1118 = select i1 %t1117, i8* %t1116, i8* %t1115
  %t1119 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1120 = icmp eq i32 %t1075, 14
  %t1121 = select i1 %t1120, i8* %t1119, i8* %t1118
  %t1122 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1123 = icmp eq i32 %t1075, 15
  %t1124 = select i1 %t1123, i8* %t1122, i8* %t1121
  %t1125 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1126 = icmp eq i32 %t1075, 16
  %t1127 = select i1 %t1126, i8* %t1125, i8* %t1124
  %t1128 = call i8* @malloc(i64 7)
  %t1129 = bitcast i8* %t1128 to [7 x i8]*
  store [7 x i8] c"EndFor\00", [7 x i8]* %t1129
  %t1130 = call i1 @strings_equal(i8* %t1127, i8* %t1128)
  %t1131 = load %PythonBuilder, %PythonBuilder* %l0
  %t1132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1133 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1134 = load i8*, i8** %l3
  %t1135 = load double, double* %l4
  %t1136 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1137 = load double, double* %l6
  %t1138 = load double, double* %l7
  %t1139 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1130, label %then58, label %else59
then58:
  %t1140 = load double, double* %l4
  %t1141 = sitofp i64 0 to double
  %t1142 = fcmp ogt double %t1140, %t1141
  %t1143 = load %PythonBuilder, %PythonBuilder* %l0
  %t1144 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1145 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1146 = load i8*, i8** %l3
  %t1147 = load double, double* %l4
  %t1148 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1149 = load double, double* %l6
  %t1150 = load double, double* %l7
  %t1151 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1142, label %then61, label %else62
then61:
  %t1152 = load %PythonBuilder, %PythonBuilder* %l0
  %t1153 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1152)
  store %PythonBuilder %t1153, %PythonBuilder* %l0
  %t1154 = load double, double* %l4
  %t1155 = sitofp i64 1 to double
  %t1156 = fsub double %t1154, %t1155
  store double %t1156, double* %l4
  %t1157 = load %PythonBuilder, %PythonBuilder* %l0
  %t1158 = load double, double* %l4
  br label %merge63
else62:
  %t1159 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1160 = extractvalue %NativeFunction %function, 0
  %t1161 = call i8* @malloc(i64 33)
  %t1162 = bitcast i8* %t1161 to [33 x i8]*
  store [33 x i8] c"endfor without matching for loop\00", [33 x i8]* %t1162
  %t1163 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1159, i8* %t1160, i8* %t1161)
  store { i8**, i64 }* %t1163, { i8**, i64 }** %l1
  %t1164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge63
merge63:
  %t1165 = phi %PythonBuilder [ %t1157, %then61 ], [ %t1143, %else62 ]
  %t1166 = phi double [ %t1158, %then61 ], [ %t1147, %else62 ]
  %t1167 = phi { i8**, i64 }* [ %t1144, %then61 ], [ %t1164, %else62 ]
  store %PythonBuilder %t1165, %PythonBuilder* %l0
  store double %t1166, double* %l4
  store { i8**, i64 }* %t1167, { i8**, i64 }** %l1
  %t1168 = load %PythonBuilder, %PythonBuilder* %l0
  %t1169 = load double, double* %l4
  %t1170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge60
else59:
  %t1171 = load %NativeInstruction, %NativeInstruction* %l8
  %t1172 = extractvalue %NativeInstruction %t1171, 0
  %t1173 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1174 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1175 = icmp eq i32 %t1172, 0
  %t1176 = select i1 %t1175, i8* %t1174, i8* %t1173
  %t1177 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1178 = icmp eq i32 %t1172, 1
  %t1179 = select i1 %t1178, i8* %t1177, i8* %t1176
  %t1180 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1181 = icmp eq i32 %t1172, 2
  %t1182 = select i1 %t1181, i8* %t1180, i8* %t1179
  %t1183 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1184 = icmp eq i32 %t1172, 3
  %t1185 = select i1 %t1184, i8* %t1183, i8* %t1182
  %t1186 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1187 = icmp eq i32 %t1172, 4
  %t1188 = select i1 %t1187, i8* %t1186, i8* %t1185
  %t1189 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1190 = icmp eq i32 %t1172, 5
  %t1191 = select i1 %t1190, i8* %t1189, i8* %t1188
  %t1192 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1193 = icmp eq i32 %t1172, 6
  %t1194 = select i1 %t1193, i8* %t1192, i8* %t1191
  %t1195 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1196 = icmp eq i32 %t1172, 7
  %t1197 = select i1 %t1196, i8* %t1195, i8* %t1194
  %t1198 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1199 = icmp eq i32 %t1172, 8
  %t1200 = select i1 %t1199, i8* %t1198, i8* %t1197
  %t1201 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1202 = icmp eq i32 %t1172, 9
  %t1203 = select i1 %t1202, i8* %t1201, i8* %t1200
  %t1204 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1205 = icmp eq i32 %t1172, 10
  %t1206 = select i1 %t1205, i8* %t1204, i8* %t1203
  %t1207 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1208 = icmp eq i32 %t1172, 11
  %t1209 = select i1 %t1208, i8* %t1207, i8* %t1206
  %t1210 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1211 = icmp eq i32 %t1172, 12
  %t1212 = select i1 %t1211, i8* %t1210, i8* %t1209
  %t1213 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1214 = icmp eq i32 %t1172, 13
  %t1215 = select i1 %t1214, i8* %t1213, i8* %t1212
  %t1216 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1217 = icmp eq i32 %t1172, 14
  %t1218 = select i1 %t1217, i8* %t1216, i8* %t1215
  %t1219 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1220 = icmp eq i32 %t1172, 15
  %t1221 = select i1 %t1220, i8* %t1219, i8* %t1218
  %t1222 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1223 = icmp eq i32 %t1172, 16
  %t1224 = select i1 %t1223, i8* %t1222, i8* %t1221
  %t1225 = call i8* @malloc(i64 5)
  %t1226 = bitcast i8* %t1225 to [5 x i8]*
  store [5 x i8] c"Loop\00", [5 x i8]* %t1226
  %t1227 = call i1 @strings_equal(i8* %t1224, i8* %t1225)
  %t1228 = load %PythonBuilder, %PythonBuilder* %l0
  %t1229 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1230 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1231 = load i8*, i8** %l3
  %t1232 = load double, double* %l4
  %t1233 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1234 = load double, double* %l6
  %t1235 = load double, double* %l7
  %t1236 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1227, label %then64, label %else65
then64:
  %t1237 = load %PythonBuilder, %PythonBuilder* %l0
  %t1238 = call i8* @malloc(i64 12)
  %t1239 = bitcast i8* %t1238 to [12 x i8]*
  store [12 x i8] c"while True:\00", [12 x i8]* %t1239
  %t1240 = call %PythonBuilder @builder_emit(%PythonBuilder %t1237, i8* %t1238)
  store %PythonBuilder %t1240, %PythonBuilder* %l0
  %t1241 = load %PythonBuilder, %PythonBuilder* %l0
  %t1242 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1241)
  store %PythonBuilder %t1242, %PythonBuilder* %l0
  %t1243 = load double, double* %l4
  %t1244 = sitofp i64 1 to double
  %t1245 = fadd double %t1243, %t1244
  store double %t1245, double* %l4
  %t1246 = load %PythonBuilder, %PythonBuilder* %l0
  %t1247 = load %PythonBuilder, %PythonBuilder* %l0
  %t1248 = load double, double* %l4
  br label %merge66
else65:
  %t1249 = load %NativeInstruction, %NativeInstruction* %l8
  %t1250 = extractvalue %NativeInstruction %t1249, 0
  %t1251 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1252 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1250, 0
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1250, 1
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1250, 2
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1250, 3
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1250, 4
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1250, 5
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1250, 6
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1250, 7
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1250, 8
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %t1279 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1280 = icmp eq i32 %t1250, 9
  %t1281 = select i1 %t1280, i8* %t1279, i8* %t1278
  %t1282 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1283 = icmp eq i32 %t1250, 10
  %t1284 = select i1 %t1283, i8* %t1282, i8* %t1281
  %t1285 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1286 = icmp eq i32 %t1250, 11
  %t1287 = select i1 %t1286, i8* %t1285, i8* %t1284
  %t1288 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1289 = icmp eq i32 %t1250, 12
  %t1290 = select i1 %t1289, i8* %t1288, i8* %t1287
  %t1291 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1292 = icmp eq i32 %t1250, 13
  %t1293 = select i1 %t1292, i8* %t1291, i8* %t1290
  %t1294 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1295 = icmp eq i32 %t1250, 14
  %t1296 = select i1 %t1295, i8* %t1294, i8* %t1293
  %t1297 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1298 = icmp eq i32 %t1250, 15
  %t1299 = select i1 %t1298, i8* %t1297, i8* %t1296
  %t1300 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1301 = icmp eq i32 %t1250, 16
  %t1302 = select i1 %t1301, i8* %t1300, i8* %t1299
  %t1303 = call i8* @malloc(i64 8)
  %t1304 = bitcast i8* %t1303 to [8 x i8]*
  store [8 x i8] c"EndLoop\00", [8 x i8]* %t1304
  %t1305 = call i1 @strings_equal(i8* %t1302, i8* %t1303)
  %t1306 = load %PythonBuilder, %PythonBuilder* %l0
  %t1307 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1308 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1309 = load i8*, i8** %l3
  %t1310 = load double, double* %l4
  %t1311 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1312 = load double, double* %l6
  %t1313 = load double, double* %l7
  %t1314 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1305, label %then67, label %else68
then67:
  %t1315 = load double, double* %l4
  %t1316 = sitofp i64 0 to double
  %t1317 = fcmp ogt double %t1315, %t1316
  %t1318 = load %PythonBuilder, %PythonBuilder* %l0
  %t1319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1320 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1321 = load i8*, i8** %l3
  %t1322 = load double, double* %l4
  %t1323 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1324 = load double, double* %l6
  %t1325 = load double, double* %l7
  %t1326 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1317, label %then70, label %else71
then70:
  %t1327 = load %PythonBuilder, %PythonBuilder* %l0
  %t1328 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1327)
  store %PythonBuilder %t1328, %PythonBuilder* %l0
  %t1329 = load double, double* %l4
  %t1330 = sitofp i64 1 to double
  %t1331 = fsub double %t1329, %t1330
  store double %t1331, double* %l4
  %t1332 = load %PythonBuilder, %PythonBuilder* %l0
  %t1333 = load double, double* %l4
  br label %merge72
else71:
  %t1334 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1335 = extractvalue %NativeFunction %function, 0
  %t1336 = call i8* @malloc(i64 30)
  %t1337 = bitcast i8* %t1336 to [30 x i8]*
  store [30 x i8] c"endloop without matching loop\00", [30 x i8]* %t1337
  %t1338 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1334, i8* %t1335, i8* %t1336)
  store { i8**, i64 }* %t1338, { i8**, i64 }** %l1
  %t1339 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge72
merge72:
  %t1340 = phi %PythonBuilder [ %t1332, %then70 ], [ %t1318, %else71 ]
  %t1341 = phi double [ %t1333, %then70 ], [ %t1322, %else71 ]
  %t1342 = phi { i8**, i64 }* [ %t1319, %then70 ], [ %t1339, %else71 ]
  store %PythonBuilder %t1340, %PythonBuilder* %l0
  store double %t1341, double* %l4
  store { i8**, i64 }* %t1342, { i8**, i64 }** %l1
  %t1343 = load %PythonBuilder, %PythonBuilder* %l0
  %t1344 = load double, double* %l4
  %t1345 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge69
else68:
  %t1346 = load %NativeInstruction, %NativeInstruction* %l8
  %t1347 = extractvalue %NativeInstruction %t1346, 0
  %t1348 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1349 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1350 = icmp eq i32 %t1347, 0
  %t1351 = select i1 %t1350, i8* %t1349, i8* %t1348
  %t1352 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1353 = icmp eq i32 %t1347, 1
  %t1354 = select i1 %t1353, i8* %t1352, i8* %t1351
  %t1355 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1356 = icmp eq i32 %t1347, 2
  %t1357 = select i1 %t1356, i8* %t1355, i8* %t1354
  %t1358 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1359 = icmp eq i32 %t1347, 3
  %t1360 = select i1 %t1359, i8* %t1358, i8* %t1357
  %t1361 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1362 = icmp eq i32 %t1347, 4
  %t1363 = select i1 %t1362, i8* %t1361, i8* %t1360
  %t1364 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1365 = icmp eq i32 %t1347, 5
  %t1366 = select i1 %t1365, i8* %t1364, i8* %t1363
  %t1367 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1368 = icmp eq i32 %t1347, 6
  %t1369 = select i1 %t1368, i8* %t1367, i8* %t1366
  %t1370 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1371 = icmp eq i32 %t1347, 7
  %t1372 = select i1 %t1371, i8* %t1370, i8* %t1369
  %t1373 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1374 = icmp eq i32 %t1347, 8
  %t1375 = select i1 %t1374, i8* %t1373, i8* %t1372
  %t1376 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1377 = icmp eq i32 %t1347, 9
  %t1378 = select i1 %t1377, i8* %t1376, i8* %t1375
  %t1379 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1380 = icmp eq i32 %t1347, 10
  %t1381 = select i1 %t1380, i8* %t1379, i8* %t1378
  %t1382 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1383 = icmp eq i32 %t1347, 11
  %t1384 = select i1 %t1383, i8* %t1382, i8* %t1381
  %t1385 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1386 = icmp eq i32 %t1347, 12
  %t1387 = select i1 %t1386, i8* %t1385, i8* %t1384
  %t1388 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1389 = icmp eq i32 %t1347, 13
  %t1390 = select i1 %t1389, i8* %t1388, i8* %t1387
  %t1391 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1392 = icmp eq i32 %t1347, 14
  %t1393 = select i1 %t1392, i8* %t1391, i8* %t1390
  %t1394 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1395 = icmp eq i32 %t1347, 15
  %t1396 = select i1 %t1395, i8* %t1394, i8* %t1393
  %t1397 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1398 = icmp eq i32 %t1347, 16
  %t1399 = select i1 %t1398, i8* %t1397, i8* %t1396
  %t1400 = call i8* @malloc(i64 6)
  %t1401 = bitcast i8* %t1400 to [6 x i8]*
  store [6 x i8] c"Break\00", [6 x i8]* %t1401
  %t1402 = call i1 @strings_equal(i8* %t1399, i8* %t1400)
  %t1403 = load %PythonBuilder, %PythonBuilder* %l0
  %t1404 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1405 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1406 = load i8*, i8** %l3
  %t1407 = load double, double* %l4
  %t1408 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1409 = load double, double* %l6
  %t1410 = load double, double* %l7
  %t1411 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1402, label %then73, label %else74
then73:
  %t1412 = load %PythonBuilder, %PythonBuilder* %l0
  %t1413 = call i8* @malloc(i64 6)
  %t1414 = bitcast i8* %t1413 to [6 x i8]*
  store [6 x i8] c"break\00", [6 x i8]* %t1414
  %t1415 = call %PythonBuilder @builder_emit(%PythonBuilder %t1412, i8* %t1413)
  store %PythonBuilder %t1415, %PythonBuilder* %l0
  %t1416 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
else74:
  %t1417 = load %NativeInstruction, %NativeInstruction* %l8
  %t1418 = extractvalue %NativeInstruction %t1417, 0
  %t1419 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1420 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1421 = icmp eq i32 %t1418, 0
  %t1422 = select i1 %t1421, i8* %t1420, i8* %t1419
  %t1423 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1424 = icmp eq i32 %t1418, 1
  %t1425 = select i1 %t1424, i8* %t1423, i8* %t1422
  %t1426 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1427 = icmp eq i32 %t1418, 2
  %t1428 = select i1 %t1427, i8* %t1426, i8* %t1425
  %t1429 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1430 = icmp eq i32 %t1418, 3
  %t1431 = select i1 %t1430, i8* %t1429, i8* %t1428
  %t1432 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1433 = icmp eq i32 %t1418, 4
  %t1434 = select i1 %t1433, i8* %t1432, i8* %t1431
  %t1435 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1436 = icmp eq i32 %t1418, 5
  %t1437 = select i1 %t1436, i8* %t1435, i8* %t1434
  %t1438 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1439 = icmp eq i32 %t1418, 6
  %t1440 = select i1 %t1439, i8* %t1438, i8* %t1437
  %t1441 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1442 = icmp eq i32 %t1418, 7
  %t1443 = select i1 %t1442, i8* %t1441, i8* %t1440
  %t1444 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1445 = icmp eq i32 %t1418, 8
  %t1446 = select i1 %t1445, i8* %t1444, i8* %t1443
  %t1447 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1448 = icmp eq i32 %t1418, 9
  %t1449 = select i1 %t1448, i8* %t1447, i8* %t1446
  %t1450 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1451 = icmp eq i32 %t1418, 10
  %t1452 = select i1 %t1451, i8* %t1450, i8* %t1449
  %t1453 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1454 = icmp eq i32 %t1418, 11
  %t1455 = select i1 %t1454, i8* %t1453, i8* %t1452
  %t1456 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1457 = icmp eq i32 %t1418, 12
  %t1458 = select i1 %t1457, i8* %t1456, i8* %t1455
  %t1459 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1460 = icmp eq i32 %t1418, 13
  %t1461 = select i1 %t1460, i8* %t1459, i8* %t1458
  %t1462 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1463 = icmp eq i32 %t1418, 14
  %t1464 = select i1 %t1463, i8* %t1462, i8* %t1461
  %t1465 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1466 = icmp eq i32 %t1418, 15
  %t1467 = select i1 %t1466, i8* %t1465, i8* %t1464
  %t1468 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1469 = icmp eq i32 %t1418, 16
  %t1470 = select i1 %t1469, i8* %t1468, i8* %t1467
  %t1471 = call i8* @malloc(i64 9)
  %t1472 = bitcast i8* %t1471 to [9 x i8]*
  store [9 x i8] c"Continue\00", [9 x i8]* %t1472
  %t1473 = call i1 @strings_equal(i8* %t1470, i8* %t1471)
  %t1474 = load %PythonBuilder, %PythonBuilder* %l0
  %t1475 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1476 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1477 = load i8*, i8** %l3
  %t1478 = load double, double* %l4
  %t1479 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1480 = load double, double* %l6
  %t1481 = load double, double* %l7
  %t1482 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1473, label %then76, label %else77
then76:
  %t1483 = load %PythonBuilder, %PythonBuilder* %l0
  %t1484 = call i8* @malloc(i64 9)
  %t1485 = bitcast i8* %t1484 to [9 x i8]*
  store [9 x i8] c"continue\00", [9 x i8]* %t1485
  %t1486 = call %PythonBuilder @builder_emit(%PythonBuilder %t1483, i8* %t1484)
  store %PythonBuilder %t1486, %PythonBuilder* %l0
  %t1487 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
else77:
  %t1488 = load %NativeInstruction, %NativeInstruction* %l8
  %t1489 = extractvalue %NativeInstruction %t1488, 0
  %t1490 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1491 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1489, 0
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1489, 1
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1489, 2
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1489, 3
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1489, 4
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1489, 5
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1489, 6
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %t1512 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1513 = icmp eq i32 %t1489, 7
  %t1514 = select i1 %t1513, i8* %t1512, i8* %t1511
  %t1515 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1516 = icmp eq i32 %t1489, 8
  %t1517 = select i1 %t1516, i8* %t1515, i8* %t1514
  %t1518 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1519 = icmp eq i32 %t1489, 9
  %t1520 = select i1 %t1519, i8* %t1518, i8* %t1517
  %t1521 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1522 = icmp eq i32 %t1489, 10
  %t1523 = select i1 %t1522, i8* %t1521, i8* %t1520
  %t1524 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1525 = icmp eq i32 %t1489, 11
  %t1526 = select i1 %t1525, i8* %t1524, i8* %t1523
  %t1527 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1528 = icmp eq i32 %t1489, 12
  %t1529 = select i1 %t1528, i8* %t1527, i8* %t1526
  %t1530 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1531 = icmp eq i32 %t1489, 13
  %t1532 = select i1 %t1531, i8* %t1530, i8* %t1529
  %t1533 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1534 = icmp eq i32 %t1489, 14
  %t1535 = select i1 %t1534, i8* %t1533, i8* %t1532
  %t1536 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1537 = icmp eq i32 %t1489, 15
  %t1538 = select i1 %t1537, i8* %t1536, i8* %t1535
  %t1539 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1540 = icmp eq i32 %t1489, 16
  %t1541 = select i1 %t1540, i8* %t1539, i8* %t1538
  %t1542 = call i8* @malloc(i64 6)
  %t1543 = bitcast i8* %t1542 to [6 x i8]*
  store [6 x i8] c"Match\00", [6 x i8]* %t1543
  %t1544 = call i1 @strings_equal(i8* %t1541, i8* %t1542)
  %t1545 = load %PythonBuilder, %PythonBuilder* %l0
  %t1546 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1547 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1548 = load i8*, i8** %l3
  %t1549 = load double, double* %l4
  %t1550 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1551 = load double, double* %l6
  %t1552 = load double, double* %l7
  %t1553 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1544, label %then79, label %else80
then79:
  %t1554 = load double, double* %l6
  %t1555 = call i8* @generate_match_subject_name(double %t1554)
  store i8* %t1555, i8** %l25
  %t1556 = load double, double* %l6
  %t1557 = sitofp i64 1 to double
  %t1558 = fadd double %t1556, %t1557
  store double %t1558, double* %l6
  %t1559 = load %NativeInstruction, %NativeInstruction* %l8
  %t1560 = extractvalue %NativeInstruction %t1559, 0
  %t1561 = alloca %NativeInstruction
  store %NativeInstruction %t1559, %NativeInstruction* %t1561
  %t1562 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1561, i32 0, i32 1
  %t1563 = bitcast [16 x i8]* %t1562 to i8*
  %t1564 = bitcast i8* %t1563 to i8**
  %t1565 = load i8*, i8** %t1564
  %t1566 = icmp eq i32 %t1560, 0
  %t1567 = select i1 %t1566, i8* %t1565, i8* null
  %t1568 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1561, i32 0, i32 1
  %t1569 = bitcast [16 x i8]* %t1568 to i8*
  %t1570 = bitcast i8* %t1569 to i8**
  %t1571 = load i8*, i8** %t1570
  %t1572 = icmp eq i32 %t1560, 1
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1567
  %t1574 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1561, i32 0, i32 1
  %t1575 = bitcast [8 x i8]* %t1574 to i8*
  %t1576 = bitcast i8* %t1575 to i8**
  %t1577 = load i8*, i8** %t1576
  %t1578 = icmp eq i32 %t1560, 12
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1573
  %t1580 = call i8* @lower_expression(i8* %t1579)
  store i8* %t1580, i8** %l26
  %t1581 = load %PythonBuilder, %PythonBuilder* %l0
  %t1582 = load i8*, i8** %l25
  %t1583 = call i8* @malloc(i64 4)
  %t1584 = bitcast i8* %t1583 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t1584
  %t1585 = call i8* @sailfin_runtime_string_concat(i8* %t1582, i8* %t1583)
  %t1586 = load i8*, i8** %l26
  %t1587 = call i8* @sailfin_runtime_string_concat(i8* %t1585, i8* %t1586)
  %t1588 = call %PythonBuilder @builder_emit(%PythonBuilder %t1581, i8* %t1587)
  store %PythonBuilder %t1588, %PythonBuilder* %l0
  %t1589 = load i8*, i8** %l25
  %t1590 = insertvalue %MatchContext undef, i8* %t1589, 0
  %t1591 = sitofp i64 0 to double
  %t1592 = insertvalue %MatchContext %t1590, double %t1591, 1
  %t1593 = insertvalue %MatchContext %t1592, i1 0, 2
  store %MatchContext %t1593, %MatchContext* %l27
  %t1594 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1595 = load %MatchContext, %MatchContext* %l27
  %t1596 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t1594, %MatchContext %t1595)
  store { %MatchContext*, i64 }* %t1596, { %MatchContext*, i64 }** %l5
  %t1597 = load double, double* %l6
  %t1598 = load %PythonBuilder, %PythonBuilder* %l0
  %t1599 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge81
else80:
  %t1600 = load %NativeInstruction, %NativeInstruction* %l8
  %t1601 = extractvalue %NativeInstruction %t1600, 0
  %t1602 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1603 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1604 = icmp eq i32 %t1601, 0
  %t1605 = select i1 %t1604, i8* %t1603, i8* %t1602
  %t1606 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1607 = icmp eq i32 %t1601, 1
  %t1608 = select i1 %t1607, i8* %t1606, i8* %t1605
  %t1609 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1610 = icmp eq i32 %t1601, 2
  %t1611 = select i1 %t1610, i8* %t1609, i8* %t1608
  %t1612 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1613 = icmp eq i32 %t1601, 3
  %t1614 = select i1 %t1613, i8* %t1612, i8* %t1611
  %t1615 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1616 = icmp eq i32 %t1601, 4
  %t1617 = select i1 %t1616, i8* %t1615, i8* %t1614
  %t1618 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1619 = icmp eq i32 %t1601, 5
  %t1620 = select i1 %t1619, i8* %t1618, i8* %t1617
  %t1621 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1622 = icmp eq i32 %t1601, 6
  %t1623 = select i1 %t1622, i8* %t1621, i8* %t1620
  %t1624 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1625 = icmp eq i32 %t1601, 7
  %t1626 = select i1 %t1625, i8* %t1624, i8* %t1623
  %t1627 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1628 = icmp eq i32 %t1601, 8
  %t1629 = select i1 %t1628, i8* %t1627, i8* %t1626
  %t1630 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1631 = icmp eq i32 %t1601, 9
  %t1632 = select i1 %t1631, i8* %t1630, i8* %t1629
  %t1633 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1634 = icmp eq i32 %t1601, 10
  %t1635 = select i1 %t1634, i8* %t1633, i8* %t1632
  %t1636 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1637 = icmp eq i32 %t1601, 11
  %t1638 = select i1 %t1637, i8* %t1636, i8* %t1635
  %t1639 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1640 = icmp eq i32 %t1601, 12
  %t1641 = select i1 %t1640, i8* %t1639, i8* %t1638
  %t1642 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1643 = icmp eq i32 %t1601, 13
  %t1644 = select i1 %t1643, i8* %t1642, i8* %t1641
  %t1645 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1646 = icmp eq i32 %t1601, 14
  %t1647 = select i1 %t1646, i8* %t1645, i8* %t1644
  %t1648 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1649 = icmp eq i32 %t1601, 15
  %t1650 = select i1 %t1649, i8* %t1648, i8* %t1647
  %t1651 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1652 = icmp eq i32 %t1601, 16
  %t1653 = select i1 %t1652, i8* %t1651, i8* %t1650
  %t1654 = call i8* @malloc(i64 5)
  %t1655 = bitcast i8* %t1654 to [5 x i8]*
  store [5 x i8] c"Case\00", [5 x i8]* %t1655
  %t1656 = call i1 @strings_equal(i8* %t1653, i8* %t1654)
  %t1657 = load %PythonBuilder, %PythonBuilder* %l0
  %t1658 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1659 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1660 = load i8*, i8** %l3
  %t1661 = load double, double* %l4
  %t1662 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1663 = load double, double* %l6
  %t1664 = load double, double* %l7
  %t1665 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1656, label %then82, label %else83
then82:
  %t1666 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1667 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1666
  %t1668 = extractvalue { %MatchContext*, i64 } %t1667, 1
  %t1669 = icmp eq i64 %t1668, 0
  %t1670 = load %PythonBuilder, %PythonBuilder* %l0
  %t1671 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1672 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1673 = load i8*, i8** %l3
  %t1674 = load double, double* %l4
  %t1675 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1676 = load double, double* %l6
  %t1677 = load double, double* %l7
  %t1678 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1669, label %then85, label %else86
then85:
  %t1679 = load %NativeInstruction, %NativeInstruction* %l8
  %t1680 = extractvalue %NativeInstruction %t1679, 0
  %t1681 = alloca %NativeInstruction
  store %NativeInstruction %t1679, %NativeInstruction* %t1681
  %t1682 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1681, i32 0, i32 1
  %t1683 = bitcast [16 x i8]* %t1682 to i8*
  %t1684 = bitcast i8* %t1683 to i8**
  %t1685 = load i8*, i8** %t1684
  %t1686 = icmp eq i32 %t1680, 13
  %t1687 = select i1 %t1686, i8* %t1685, i8* null
  %t1688 = call i8* @trim_text(i8* %t1687)
  store i8* %t1688, i8** %l28
  %t1689 = call i8* @malloc(i64 40)
  %t1690 = bitcast i8* %t1689 to [40 x i8]*
  store [40 x i8] c"match case without active match context\00", [40 x i8]* %t1690
  store i8* %t1689, i8** %l29
  %t1691 = load i8*, i8** %l28
  %t1692 = call i64 @sailfin_runtime_string_length(i8* %t1691)
  %t1693 = icmp sgt i64 %t1692, 0
  %t1694 = load %PythonBuilder, %PythonBuilder* %l0
  %t1695 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1696 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1697 = load i8*, i8** %l3
  %t1698 = load double, double* %l4
  %t1699 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1700 = load double, double* %l6
  %t1701 = load double, double* %l7
  %t1702 = load %NativeInstruction, %NativeInstruction* %l8
  %t1703 = load i8*, i8** %l28
  %t1704 = load i8*, i8** %l29
  br i1 %t1693, label %then88, label %merge89
then88:
  %t1705 = load i8*, i8** %l29
  %t1706 = call i8* @malloc(i64 12)
  %t1707 = bitcast i8* %t1706 to [12 x i8]*
  store [12 x i8] c" (pattern: \00", [12 x i8]* %t1707
  %t1708 = call i8* @sailfin_runtime_string_concat(i8* %t1705, i8* %t1706)
  %t1709 = load i8*, i8** %l28
  %t1710 = call i8* @sailfin_runtime_string_concat(i8* %t1708, i8* %t1709)
  %t1711 = add i64 0, 2
  %t1712 = call i8* @malloc(i64 %t1711)
  store i8 41, i8* %t1712
  %t1713 = getelementptr i8, i8* %t1712, i64 1
  store i8 0, i8* %t1713
  call void @sailfin_runtime_mark_persistent(i8* %t1712)
  %t1714 = call i8* @sailfin_runtime_string_concat(i8* %t1710, i8* %t1712)
  store i8* %t1714, i8** %l29
  %t1715 = load i8*, i8** %l29
  br label %merge89
merge89:
  %t1716 = phi i8* [ %t1715, %then88 ], [ %t1704, %then85 ]
  store i8* %t1716, i8** %l29
  %t1717 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1718 = extractvalue %NativeFunction %function, 0
  %t1719 = load i8*, i8** %l29
  %t1720 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1717, i8* %t1718, i8* %t1719)
  store { i8**, i64 }* %t1720, { i8**, i64 }** %l1
  %t1721 = load %PythonBuilder, %PythonBuilder* %l0
  %t1722 = call i8* @malloc(i64 42)
  %t1723 = bitcast i8* %t1722 to [42 x i8]*
  store [42 x i8] c"# unsupported: match case without context\00", [42 x i8]* %t1723
  %t1724 = call %PythonBuilder @builder_emit(%PythonBuilder %t1721, i8* %t1722)
  store %PythonBuilder %t1724, %PythonBuilder* %l0
  %t1725 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1726 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge87
else86:
  %t1727 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1728 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1727
  %t1729 = extractvalue { %MatchContext*, i64 } %t1728, 1
  %t1730 = sub i64 %t1729, 1
  store i64 %t1730, i64* %l30
  %t1731 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1732 = load i64, i64* %l30
  %t1733 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1731
  %t1734 = extractvalue { %MatchContext*, i64 } %t1733, 0
  %t1735 = extractvalue { %MatchContext*, i64 } %t1733, 1
  %t1736 = icmp uge i64 %t1732, %t1735
  ; bounds check: %t1736 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1732, i64 %t1735)
  %t1737 = getelementptr %MatchContext, %MatchContext* %t1734, i64 %t1732
  %t1738 = load %MatchContext, %MatchContext* %t1737
  store %MatchContext %t1738, %MatchContext* %l31
  %t1739 = load %MatchContext, %MatchContext* %l31
  %t1740 = extractvalue %MatchContext %t1739, 2
  %t1741 = load %PythonBuilder, %PythonBuilder* %l0
  %t1742 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1743 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1744 = load i8*, i8** %l3
  %t1745 = load double, double* %l4
  %t1746 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1747 = load double, double* %l6
  %t1748 = load double, double* %l7
  %t1749 = load %NativeInstruction, %NativeInstruction* %l8
  %t1750 = load i64, i64* %l30
  %t1751 = load %MatchContext, %MatchContext* %l31
  br i1 %t1740, label %then90, label %merge91
then90:
  %t1752 = load %PythonBuilder, %PythonBuilder* %l0
  %t1753 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1752)
  store %PythonBuilder %t1753, %PythonBuilder* %l0
  %t1754 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge91
merge91:
  %t1755 = phi %PythonBuilder [ %t1754, %then90 ], [ %t1741, %else86 ]
  store %PythonBuilder %t1755, %PythonBuilder* %l0
  %t1756 = load %MatchContext, %MatchContext* %l31
  %t1757 = extractvalue %MatchContext %t1756, 0
  %t1758 = load %NativeInstruction, %NativeInstruction* %l8
  %t1759 = extractvalue %NativeInstruction %t1758, 0
  %t1760 = alloca %NativeInstruction
  store %NativeInstruction %t1758, %NativeInstruction* %t1760
  %t1761 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1760, i32 0, i32 1
  %t1762 = bitcast [16 x i8]* %t1761 to i8*
  %t1763 = bitcast i8* %t1762 to i8**
  %t1764 = load i8*, i8** %t1763
  %t1765 = icmp eq i32 %t1759, 13
  %t1766 = select i1 %t1765, i8* %t1764, i8* null
  %t1767 = load %NativeInstruction, %NativeInstruction* %l8
  %t1768 = extractvalue %NativeInstruction %t1767, 0
  %t1769 = alloca %NativeInstruction
  store %NativeInstruction %t1767, %NativeInstruction* %t1769
  %t1770 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1769, i32 0, i32 1
  %t1771 = bitcast [16 x i8]* %t1770 to i8*
  %t1772 = getelementptr inbounds i8, i8* %t1771, i64 8
  %t1773 = bitcast i8* %t1772 to i8**
  %t1774 = load i8*, i8** %t1773
  %t1775 = icmp eq i32 %t1768, 13
  %t1776 = select i1 %t1775, i8* %t1774, i8* null
  %t1777 = call %LoweredCaseCondition @lower_match_case_condition(i8* %t1757, i8* %t1766, i8* %t1776)
  store %LoweredCaseCondition %t1777, %LoweredCaseCondition* %l32
  %t1778 = load %MatchContext, %MatchContext* %l31
  %t1779 = extractvalue %MatchContext %t1778, 1
  %t1780 = sitofp i64 0 to double
  %t1781 = fcmp oeq double %t1779, %t1780
  %t1782 = load %PythonBuilder, %PythonBuilder* %l0
  %t1783 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1784 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1785 = load i8*, i8** %l3
  %t1786 = load double, double* %l4
  %t1787 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1788 = load double, double* %l6
  %t1789 = load double, double* %l7
  %t1790 = load %NativeInstruction, %NativeInstruction* %l8
  %t1791 = load i64, i64* %l30
  %t1792 = load %MatchContext, %MatchContext* %l31
  %t1793 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1781, label %then92, label %else93
then92:
  %t1794 = load %PythonBuilder, %PythonBuilder* %l0
  %t1795 = call i8* @malloc(i64 4)
  %t1796 = bitcast i8* %t1795 to [4 x i8]*
  store [4 x i8] c"if \00", [4 x i8]* %t1796
  %t1797 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1798 = extractvalue %LoweredCaseCondition %t1797, 0
  %t1799 = call i8* @sailfin_runtime_string_concat(i8* %t1795, i8* %t1798)
  %t1800 = add i64 0, 2
  %t1801 = call i8* @malloc(i64 %t1800)
  store i8 58, i8* %t1801
  %t1802 = getelementptr i8, i8* %t1801, i64 1
  store i8 0, i8* %t1802
  call void @sailfin_runtime_mark_persistent(i8* %t1801)
  %t1803 = call i8* @sailfin_runtime_string_concat(i8* %t1799, i8* %t1801)
  %t1804 = call %PythonBuilder @builder_emit(%PythonBuilder %t1794, i8* %t1803)
  store %PythonBuilder %t1804, %PythonBuilder* %l0
  %t1805 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
else93:
  %t1807 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1808 = extractvalue %LoweredCaseCondition %t1807, 1
  br label %logical_and_entry_1806

logical_and_entry_1806:
  br i1 %t1808, label %logical_and_right_1806, label %logical_and_merge_1806

logical_and_right_1806:
  %t1809 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1810 = extractvalue %LoweredCaseCondition %t1809, 2
  %t1811 = xor i1 %t1810, 1
  br label %logical_and_right_end_1806

logical_and_right_end_1806:
  br label %logical_and_merge_1806

logical_and_merge_1806:
  %t1812 = phi i1 [ false, %logical_and_entry_1806 ], [ %t1811, %logical_and_right_end_1806 ]
  %t1813 = load %PythonBuilder, %PythonBuilder* %l0
  %t1814 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1815 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1816 = load i8*, i8** %l3
  %t1817 = load double, double* %l4
  %t1818 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1819 = load double, double* %l6
  %t1820 = load double, double* %l7
  %t1821 = load %NativeInstruction, %NativeInstruction* %l8
  %t1822 = load i64, i64* %l30
  %t1823 = load %MatchContext, %MatchContext* %l31
  %t1824 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1812, label %then95, label %else96
then95:
  %t1825 = load %PythonBuilder, %PythonBuilder* %l0
  %t1826 = call i8* @malloc(i64 6)
  %t1827 = bitcast i8* %t1826 to [6 x i8]*
  store [6 x i8] c"else:\00", [6 x i8]* %t1827
  %t1828 = call %PythonBuilder @builder_emit(%PythonBuilder %t1825, i8* %t1826)
  store %PythonBuilder %t1828, %PythonBuilder* %l0
  %t1829 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
else96:
  %t1830 = load %PythonBuilder, %PythonBuilder* %l0
  %t1831 = call i8* @malloc(i64 6)
  %t1832 = bitcast i8* %t1831 to [6 x i8]*
  store [6 x i8] c"elif \00", [6 x i8]* %t1832
  %t1833 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1834 = extractvalue %LoweredCaseCondition %t1833, 0
  %t1835 = call i8* @sailfin_runtime_string_concat(i8* %t1831, i8* %t1834)
  %t1836 = add i64 0, 2
  %t1837 = call i8* @malloc(i64 %t1836)
  store i8 58, i8* %t1837
  %t1838 = getelementptr i8, i8* %t1837, i64 1
  store i8 0, i8* %t1838
  call void @sailfin_runtime_mark_persistent(i8* %t1837)
  %t1839 = call i8* @sailfin_runtime_string_concat(i8* %t1835, i8* %t1837)
  %t1840 = call %PythonBuilder @builder_emit(%PythonBuilder %t1830, i8* %t1839)
  store %PythonBuilder %t1840, %PythonBuilder* %l0
  %t1841 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
merge97:
  %t1842 = phi %PythonBuilder [ %t1829, %then95 ], [ %t1841, %else96 ]
  store %PythonBuilder %t1842, %PythonBuilder* %l0
  %t1843 = load %PythonBuilder, %PythonBuilder* %l0
  %t1844 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
merge94:
  %t1845 = phi %PythonBuilder [ %t1805, %then92 ], [ %t1843, %merge97 ]
  store %PythonBuilder %t1845, %PythonBuilder* %l0
  %t1846 = load %PythonBuilder, %PythonBuilder* %l0
  %t1847 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1846)
  store %PythonBuilder %t1847, %PythonBuilder* %l0
  %t1848 = load %MatchContext, %MatchContext* %l31
  %t1849 = extractvalue %MatchContext %t1848, 0
  %t1850 = insertvalue %MatchContext undef, i8* %t1849, 0
  %t1851 = load %MatchContext, %MatchContext* %l31
  %t1852 = extractvalue %MatchContext %t1851, 1
  %t1853 = sitofp i64 1 to double
  %t1854 = fadd double %t1852, %t1853
  %t1855 = insertvalue %MatchContext %t1850, double %t1854, 1
  %t1856 = insertvalue %MatchContext %t1855, i1 1, 2
  store %MatchContext %t1856, %MatchContext* %l33
  %t1857 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1858 = load i64, i64* %l30
  %t1859 = load %MatchContext, %MatchContext* %l33
  %t1860 = sitofp i64 %t1858 to double
  %t1861 = call { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %t1857, double %t1860, %MatchContext %t1859)
  store { %MatchContext*, i64 }* %t1861, { %MatchContext*, i64 }** %l5
  %t1862 = load %PythonBuilder, %PythonBuilder* %l0
  %t1863 = load %PythonBuilder, %PythonBuilder* %l0
  %t1864 = load %PythonBuilder, %PythonBuilder* %l0
  %t1865 = load %PythonBuilder, %PythonBuilder* %l0
  %t1866 = load %PythonBuilder, %PythonBuilder* %l0
  %t1867 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge87
merge87:
  %t1868 = phi { i8**, i64 }* [ %t1725, %merge89 ], [ %t1671, %merge94 ]
  %t1869 = phi %PythonBuilder [ %t1726, %merge89 ], [ %t1862, %merge94 ]
  %t1870 = phi { %MatchContext*, i64 }* [ %t1675, %merge89 ], [ %t1867, %merge94 ]
  store { i8**, i64 }* %t1868, { i8**, i64 }** %l1
  store %PythonBuilder %t1869, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1870, { %MatchContext*, i64 }** %l5
  %t1871 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1872 = load %PythonBuilder, %PythonBuilder* %l0
  %t1873 = load %PythonBuilder, %PythonBuilder* %l0
  %t1874 = load %PythonBuilder, %PythonBuilder* %l0
  %t1875 = load %PythonBuilder, %PythonBuilder* %l0
  %t1876 = load %PythonBuilder, %PythonBuilder* %l0
  %t1877 = load %PythonBuilder, %PythonBuilder* %l0
  %t1878 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge84
else83:
  %t1879 = load %NativeInstruction, %NativeInstruction* %l8
  %t1880 = extractvalue %NativeInstruction %t1879, 0
  %t1881 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1882 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1883 = icmp eq i32 %t1880, 0
  %t1884 = select i1 %t1883, i8* %t1882, i8* %t1881
  %t1885 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1886 = icmp eq i32 %t1880, 1
  %t1887 = select i1 %t1886, i8* %t1885, i8* %t1884
  %t1888 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1889 = icmp eq i32 %t1880, 2
  %t1890 = select i1 %t1889, i8* %t1888, i8* %t1887
  %t1891 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1892 = icmp eq i32 %t1880, 3
  %t1893 = select i1 %t1892, i8* %t1891, i8* %t1890
  %t1894 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1895 = icmp eq i32 %t1880, 4
  %t1896 = select i1 %t1895, i8* %t1894, i8* %t1893
  %t1897 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1898 = icmp eq i32 %t1880, 5
  %t1899 = select i1 %t1898, i8* %t1897, i8* %t1896
  %t1900 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1901 = icmp eq i32 %t1880, 6
  %t1902 = select i1 %t1901, i8* %t1900, i8* %t1899
  %t1903 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1904 = icmp eq i32 %t1880, 7
  %t1905 = select i1 %t1904, i8* %t1903, i8* %t1902
  %t1906 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1907 = icmp eq i32 %t1880, 8
  %t1908 = select i1 %t1907, i8* %t1906, i8* %t1905
  %t1909 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1910 = icmp eq i32 %t1880, 9
  %t1911 = select i1 %t1910, i8* %t1909, i8* %t1908
  %t1912 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1913 = icmp eq i32 %t1880, 10
  %t1914 = select i1 %t1913, i8* %t1912, i8* %t1911
  %t1915 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1916 = icmp eq i32 %t1880, 11
  %t1917 = select i1 %t1916, i8* %t1915, i8* %t1914
  %t1918 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1919 = icmp eq i32 %t1880, 12
  %t1920 = select i1 %t1919, i8* %t1918, i8* %t1917
  %t1921 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1922 = icmp eq i32 %t1880, 13
  %t1923 = select i1 %t1922, i8* %t1921, i8* %t1920
  %t1924 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1925 = icmp eq i32 %t1880, 14
  %t1926 = select i1 %t1925, i8* %t1924, i8* %t1923
  %t1927 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1928 = icmp eq i32 %t1880, 15
  %t1929 = select i1 %t1928, i8* %t1927, i8* %t1926
  %t1930 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1931 = icmp eq i32 %t1880, 16
  %t1932 = select i1 %t1931, i8* %t1930, i8* %t1929
  %t1933 = call i8* @malloc(i64 9)
  %t1934 = bitcast i8* %t1933 to [9 x i8]*
  store [9 x i8] c"EndMatch\00", [9 x i8]* %t1934
  %t1935 = call i1 @strings_equal(i8* %t1932, i8* %t1933)
  %t1936 = load %PythonBuilder, %PythonBuilder* %l0
  %t1937 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1938 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1939 = load i8*, i8** %l3
  %t1940 = load double, double* %l4
  %t1941 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1942 = load double, double* %l6
  %t1943 = load double, double* %l7
  %t1944 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1935, label %then98, label %else99
then98:
  %t1945 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1946 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1945
  %t1947 = extractvalue { %MatchContext*, i64 } %t1946, 1
  %t1948 = icmp eq i64 %t1947, 0
  %t1949 = load %PythonBuilder, %PythonBuilder* %l0
  %t1950 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1951 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1952 = load i8*, i8** %l3
  %t1953 = load double, double* %l4
  %t1954 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1955 = load double, double* %l6
  %t1956 = load double, double* %l7
  %t1957 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1948, label %then101, label %else102
then101:
  %t1958 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1959 = extractvalue %NativeFunction %function, 0
  %t1960 = call i8* @malloc(i64 38)
  %t1961 = bitcast i8* %t1960 to [38 x i8]*
  store [38 x i8] c"endmatch without active match context\00", [38 x i8]* %t1961
  %t1962 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1958, i8* %t1959, i8* %t1960)
  store { i8**, i64 }* %t1962, { i8**, i64 }** %l1
  %t1963 = load %PythonBuilder, %PythonBuilder* %l0
  %t1964 = call i8* @malloc(i64 40)
  %t1965 = bitcast i8* %t1964 to [40 x i8]*
  store [40 x i8] c"# unsupported: endmatch without context\00", [40 x i8]* %t1965
  %t1966 = call %PythonBuilder @builder_emit(%PythonBuilder %t1963, i8* %t1964)
  store %PythonBuilder %t1966, %PythonBuilder* %l0
  %t1967 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1968 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge103
else102:
  %t1969 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1970 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1969
  %t1971 = extractvalue { %MatchContext*, i64 } %t1970, 1
  %t1972 = sub i64 %t1971, 1
  store i64 %t1972, i64* %l34
  %t1973 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1974 = load i64, i64* %l34
  %t1975 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1973
  %t1976 = extractvalue { %MatchContext*, i64 } %t1975, 0
  %t1977 = extractvalue { %MatchContext*, i64 } %t1975, 1
  %t1978 = icmp uge i64 %t1974, %t1977
  ; bounds check: %t1978 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1974, i64 %t1977)
  %t1979 = getelementptr %MatchContext, %MatchContext* %t1976, i64 %t1974
  %t1980 = load %MatchContext, %MatchContext* %t1979
  store %MatchContext %t1980, %MatchContext* %l35
  %t1981 = load %MatchContext, %MatchContext* %l35
  %t1982 = extractvalue %MatchContext %t1981, 2
  %t1983 = load %PythonBuilder, %PythonBuilder* %l0
  %t1984 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1985 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1986 = load i8*, i8** %l3
  %t1987 = load double, double* %l4
  %t1988 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1989 = load double, double* %l6
  %t1990 = load double, double* %l7
  %t1991 = load %NativeInstruction, %NativeInstruction* %l8
  %t1992 = load i64, i64* %l34
  %t1993 = load %MatchContext, %MatchContext* %l35
  br i1 %t1982, label %then104, label %merge105
then104:
  %t1994 = load %PythonBuilder, %PythonBuilder* %l0
  %t1995 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1994)
  store %PythonBuilder %t1995, %PythonBuilder* %l0
  %t1996 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge105
merge105:
  %t1997 = phi %PythonBuilder [ %t1996, %then104 ], [ %t1983, %else102 ]
  store %PythonBuilder %t1997, %PythonBuilder* %l0
  %t1998 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1999 = load i64, i64* %l34
  %t2000 = sitofp i64 %t1999 to double
  %t2001 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t1998, double %t2000)
  store { %MatchContext*, i64 }* %t2001, { %MatchContext*, i64 }** %l5
  %t2002 = load %PythonBuilder, %PythonBuilder* %l0
  %t2003 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge103
merge103:
  %t2004 = phi { i8**, i64 }* [ %t1967, %then101 ], [ %t1950, %merge105 ]
  %t2005 = phi %PythonBuilder [ %t1968, %then101 ], [ %t2002, %merge105 ]
  %t2006 = phi { %MatchContext*, i64 }* [ %t1954, %then101 ], [ %t2003, %merge105 ]
  store { i8**, i64 }* %t2004, { i8**, i64 }** %l1
  store %PythonBuilder %t2005, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2006, { %MatchContext*, i64 }** %l5
  %t2007 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2008 = load %PythonBuilder, %PythonBuilder* %l0
  %t2009 = load %PythonBuilder, %PythonBuilder* %l0
  %t2010 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge100
else99:
  %t2011 = load %NativeInstruction, %NativeInstruction* %l8
  %t2012 = extractvalue %NativeInstruction %t2011, 0
  %t2013 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t2014 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t2015 = icmp eq i32 %t2012, 0
  %t2016 = select i1 %t2015, i8* %t2014, i8* %t2013
  %t2017 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t2018 = icmp eq i32 %t2012, 1
  %t2019 = select i1 %t2018, i8* %t2017, i8* %t2016
  %t2020 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t2021 = icmp eq i32 %t2012, 2
  %t2022 = select i1 %t2021, i8* %t2020, i8* %t2019
  %t2023 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t2024 = icmp eq i32 %t2012, 3
  %t2025 = select i1 %t2024, i8* %t2023, i8* %t2022
  %t2026 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t2027 = icmp eq i32 %t2012, 4
  %t2028 = select i1 %t2027, i8* %t2026, i8* %t2025
  %t2029 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t2030 = icmp eq i32 %t2012, 5
  %t2031 = select i1 %t2030, i8* %t2029, i8* %t2028
  %t2032 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t2033 = icmp eq i32 %t2012, 6
  %t2034 = select i1 %t2033, i8* %t2032, i8* %t2031
  %t2035 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t2036 = icmp eq i32 %t2012, 7
  %t2037 = select i1 %t2036, i8* %t2035, i8* %t2034
  %t2038 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t2039 = icmp eq i32 %t2012, 8
  %t2040 = select i1 %t2039, i8* %t2038, i8* %t2037
  %t2041 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t2042 = icmp eq i32 %t2012, 9
  %t2043 = select i1 %t2042, i8* %t2041, i8* %t2040
  %t2044 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t2045 = icmp eq i32 %t2012, 10
  %t2046 = select i1 %t2045, i8* %t2044, i8* %t2043
  %t2047 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t2048 = icmp eq i32 %t2012, 11
  %t2049 = select i1 %t2048, i8* %t2047, i8* %t2046
  %t2050 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t2051 = icmp eq i32 %t2012, 12
  %t2052 = select i1 %t2051, i8* %t2050, i8* %t2049
  %t2053 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t2054 = icmp eq i32 %t2012, 13
  %t2055 = select i1 %t2054, i8* %t2053, i8* %t2052
  %t2056 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t2057 = icmp eq i32 %t2012, 14
  %t2058 = select i1 %t2057, i8* %t2056, i8* %t2055
  %t2059 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t2060 = icmp eq i32 %t2012, 15
  %t2061 = select i1 %t2060, i8* %t2059, i8* %t2058
  %t2062 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t2063 = icmp eq i32 %t2012, 16
  %t2064 = select i1 %t2063, i8* %t2062, i8* %t2061
  %t2065 = call i8* @malloc(i64 5)
  %t2066 = bitcast i8* %t2065 to [5 x i8]*
  store [5 x i8] c"Noop\00", [5 x i8]* %t2066
  %t2067 = call i1 @strings_equal(i8* %t2064, i8* %t2065)
  %t2068 = load %PythonBuilder, %PythonBuilder* %l0
  %t2069 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2070 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2071 = load i8*, i8** %l3
  %t2072 = load double, double* %l4
  %t2073 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2074 = load double, double* %l6
  %t2075 = load double, double* %l7
  %t2076 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t2067, label %then106, label %else107
then106:
  %t2077 = load %PythonBuilder, %PythonBuilder* %l0
  %t2078 = call i8* @malloc(i64 5)
  %t2079 = bitcast i8* %t2078 to [5 x i8]*
  store [5 x i8] c"pass\00", [5 x i8]* %t2079
  %t2080 = call %PythonBuilder @builder_emit(%PythonBuilder %t2077, i8* %t2078)
  store %PythonBuilder %t2080, %PythonBuilder* %l0
  %t2081 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
else107:
  %t2082 = load %NativeInstruction, %NativeInstruction* %l8
  %t2083 = extractvalue %NativeInstruction %t2082, 0
  %t2084 = alloca %NativeInstruction
  store %NativeInstruction %t2082, %NativeInstruction* %t2084
  %t2085 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2084, i32 0, i32 1
  %t2086 = bitcast [8 x i8]* %t2085 to i8*
  %t2087 = bitcast i8* %t2086 to i8**
  %t2088 = load i8*, i8** %t2087
  %t2089 = icmp eq i32 %t2083, 16
  %t2090 = select i1 %t2089, i8* %t2088, i8* null
  %t2091 = call i8* @trim_text(i8* %t2090)
  store i8* %t2091, i8** %l36
  %t2092 = call i8* @malloc(i64 43)
  %t2093 = bitcast i8* %t2092 to [43 x i8]*
  store [43 x i8] c"unsupported instruction emitted as comment\00", [43 x i8]* %t2093
  store i8* %t2092, i8** %l37
  %t2094 = load i8*, i8** %l36
  %t2095 = call i64 @sailfin_runtime_string_length(i8* %t2094)
  %t2096 = icmp sgt i64 %t2095, 0
  %t2097 = load %PythonBuilder, %PythonBuilder* %l0
  %t2098 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2099 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2100 = load i8*, i8** %l3
  %t2101 = load double, double* %l4
  %t2102 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2103 = load double, double* %l6
  %t2104 = load double, double* %l7
  %t2105 = load %NativeInstruction, %NativeInstruction* %l8
  %t2106 = load i8*, i8** %l36
  %t2107 = load i8*, i8** %l37
  br i1 %t2096, label %then109, label %merge110
then109:
  %t2108 = load i8*, i8** %l37
  %t2109 = call i8* @malloc(i64 3)
  %t2110 = bitcast i8* %t2109 to [3 x i8]*
  store [3 x i8] c": \00", [3 x i8]* %t2110
  %t2111 = call i8* @sailfin_runtime_string_concat(i8* %t2108, i8* %t2109)
  %t2112 = load i8*, i8** %l36
  %t2113 = call i8* @sailfin_runtime_string_concat(i8* %t2111, i8* %t2112)
  store i8* %t2113, i8** %l37
  %t2114 = load i8*, i8** %l37
  br label %merge110
merge110:
  %t2115 = phi i8* [ %t2114, %then109 ], [ %t2107, %else107 ]
  store i8* %t2115, i8** %l37
  %t2116 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2117 = extractvalue %NativeFunction %function, 0
  %t2118 = load i8*, i8** %l37
  %t2119 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2116, i8* %t2117, i8* %t2118)
  store { i8**, i64 }* %t2119, { i8**, i64 }** %l1
  %t2120 = load %PythonBuilder, %PythonBuilder* %l0
  %t2121 = call i8* @malloc(i64 16)
  %t2122 = bitcast i8* %t2121 to [16 x i8]*
  store [16 x i8] c"# unsupported: \00", [16 x i8]* %t2122
  %t2123 = load %NativeInstruction, %NativeInstruction* %l8
  %t2124 = extractvalue %NativeInstruction %t2123, 0
  %t2125 = alloca %NativeInstruction
  store %NativeInstruction %t2123, %NativeInstruction* %t2125
  %t2126 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2125, i32 0, i32 1
  %t2127 = bitcast [8 x i8]* %t2126 to i8*
  %t2128 = bitcast i8* %t2127 to i8**
  %t2129 = load i8*, i8** %t2128
  %t2130 = icmp eq i32 %t2124, 16
  %t2131 = select i1 %t2130, i8* %t2129, i8* null
  %t2132 = call i8* @sailfin_runtime_string_concat(i8* %t2121, i8* %t2131)
  %t2133 = call %PythonBuilder @builder_emit(%PythonBuilder %t2120, i8* %t2132)
  store %PythonBuilder %t2133, %PythonBuilder* %l0
  %t2134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2135 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
merge108:
  %t2136 = phi %PythonBuilder [ %t2081, %then106 ], [ %t2135, %merge110 ]
  %t2137 = phi { i8**, i64 }* [ %t2069, %then106 ], [ %t2134, %merge110 ]
  store %PythonBuilder %t2136, %PythonBuilder* %l0
  store { i8**, i64 }* %t2137, { i8**, i64 }** %l1
  %t2138 = load %PythonBuilder, %PythonBuilder* %l0
  %t2139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2140 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge100
merge100:
  %t2141 = phi { i8**, i64 }* [ %t2007, %merge103 ], [ %t2139, %merge108 ]
  %t2142 = phi %PythonBuilder [ %t2008, %merge103 ], [ %t2138, %merge108 ]
  %t2143 = phi { %MatchContext*, i64 }* [ %t2010, %merge103 ], [ %t1941, %merge108 ]
  store { i8**, i64 }* %t2141, { i8**, i64 }** %l1
  store %PythonBuilder %t2142, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2143, { %MatchContext*, i64 }** %l5
  %t2144 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2145 = load %PythonBuilder, %PythonBuilder* %l0
  %t2146 = load %PythonBuilder, %PythonBuilder* %l0
  %t2147 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2148 = load %PythonBuilder, %PythonBuilder* %l0
  %t2149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2150 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge84
merge84:
  %t2151 = phi { i8**, i64 }* [ %t1871, %merge87 ], [ %t2144, %merge100 ]
  %t2152 = phi %PythonBuilder [ %t1872, %merge87 ], [ %t2145, %merge100 ]
  %t2153 = phi { %MatchContext*, i64 }* [ %t1878, %merge87 ], [ %t2147, %merge100 ]
  store { i8**, i64 }* %t2151, { i8**, i64 }** %l1
  store %PythonBuilder %t2152, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2153, { %MatchContext*, i64 }** %l5
  %t2154 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2155 = load %PythonBuilder, %PythonBuilder* %l0
  %t2156 = load %PythonBuilder, %PythonBuilder* %l0
  %t2157 = load %PythonBuilder, %PythonBuilder* %l0
  %t2158 = load %PythonBuilder, %PythonBuilder* %l0
  %t2159 = load %PythonBuilder, %PythonBuilder* %l0
  %t2160 = load %PythonBuilder, %PythonBuilder* %l0
  %t2161 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2163 = load %PythonBuilder, %PythonBuilder* %l0
  %t2164 = load %PythonBuilder, %PythonBuilder* %l0
  %t2165 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2166 = load %PythonBuilder, %PythonBuilder* %l0
  %t2167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2168 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge81
merge81:
  %t2169 = phi double [ %t1597, %then79 ], [ %t1551, %merge84 ]
  %t2170 = phi %PythonBuilder [ %t1598, %then79 ], [ %t2155, %merge84 ]
  %t2171 = phi { %MatchContext*, i64 }* [ %t1599, %then79 ], [ %t2161, %merge84 ]
  %t2172 = phi { i8**, i64 }* [ %t1546, %then79 ], [ %t2154, %merge84 ]
  store double %t2169, double* %l6
  store %PythonBuilder %t2170, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2171, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2172, { i8**, i64 }** %l1
  %t2173 = load double, double* %l6
  %t2174 = load %PythonBuilder, %PythonBuilder* %l0
  %t2175 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2176 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2177 = load %PythonBuilder, %PythonBuilder* %l0
  %t2178 = load %PythonBuilder, %PythonBuilder* %l0
  %t2179 = load %PythonBuilder, %PythonBuilder* %l0
  %t2180 = load %PythonBuilder, %PythonBuilder* %l0
  %t2181 = load %PythonBuilder, %PythonBuilder* %l0
  %t2182 = load %PythonBuilder, %PythonBuilder* %l0
  %t2183 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2185 = load %PythonBuilder, %PythonBuilder* %l0
  %t2186 = load %PythonBuilder, %PythonBuilder* %l0
  %t2187 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2188 = load %PythonBuilder, %PythonBuilder* %l0
  %t2189 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2190 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
merge78:
  %t2191 = phi %PythonBuilder [ %t1487, %then76 ], [ %t2174, %merge81 ]
  %t2192 = phi double [ %t1480, %then76 ], [ %t2173, %merge81 ]
  %t2193 = phi { %MatchContext*, i64 }* [ %t1479, %then76 ], [ %t2175, %merge81 ]
  %t2194 = phi { i8**, i64 }* [ %t1475, %then76 ], [ %t2176, %merge81 ]
  store %PythonBuilder %t2191, %PythonBuilder* %l0
  store double %t2192, double* %l6
  store { %MatchContext*, i64 }* %t2193, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2194, { i8**, i64 }** %l1
  %t2195 = load %PythonBuilder, %PythonBuilder* %l0
  %t2196 = load double, double* %l6
  %t2197 = load %PythonBuilder, %PythonBuilder* %l0
  %t2198 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2199 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2200 = load %PythonBuilder, %PythonBuilder* %l0
  %t2201 = load %PythonBuilder, %PythonBuilder* %l0
  %t2202 = load %PythonBuilder, %PythonBuilder* %l0
  %t2203 = load %PythonBuilder, %PythonBuilder* %l0
  %t2204 = load %PythonBuilder, %PythonBuilder* %l0
  %t2205 = load %PythonBuilder, %PythonBuilder* %l0
  %t2206 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2208 = load %PythonBuilder, %PythonBuilder* %l0
  %t2209 = load %PythonBuilder, %PythonBuilder* %l0
  %t2210 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2211 = load %PythonBuilder, %PythonBuilder* %l0
  %t2212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2213 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
merge75:
  %t2214 = phi %PythonBuilder [ %t1416, %then73 ], [ %t2195, %merge78 ]
  %t2215 = phi double [ %t1409, %then73 ], [ %t2196, %merge78 ]
  %t2216 = phi { %MatchContext*, i64 }* [ %t1408, %then73 ], [ %t2198, %merge78 ]
  %t2217 = phi { i8**, i64 }* [ %t1404, %then73 ], [ %t2199, %merge78 ]
  store %PythonBuilder %t2214, %PythonBuilder* %l0
  store double %t2215, double* %l6
  store { %MatchContext*, i64 }* %t2216, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2217, { i8**, i64 }** %l1
  %t2218 = load %PythonBuilder, %PythonBuilder* %l0
  %t2219 = load %PythonBuilder, %PythonBuilder* %l0
  %t2220 = load double, double* %l6
  %t2221 = load %PythonBuilder, %PythonBuilder* %l0
  %t2222 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2224 = load %PythonBuilder, %PythonBuilder* %l0
  %t2225 = load %PythonBuilder, %PythonBuilder* %l0
  %t2226 = load %PythonBuilder, %PythonBuilder* %l0
  %t2227 = load %PythonBuilder, %PythonBuilder* %l0
  %t2228 = load %PythonBuilder, %PythonBuilder* %l0
  %t2229 = load %PythonBuilder, %PythonBuilder* %l0
  %t2230 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2231 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2232 = load %PythonBuilder, %PythonBuilder* %l0
  %t2233 = load %PythonBuilder, %PythonBuilder* %l0
  %t2234 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2235 = load %PythonBuilder, %PythonBuilder* %l0
  %t2236 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2237 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge69
merge69:
  %t2238 = phi %PythonBuilder [ %t1343, %merge72 ], [ %t2218, %merge75 ]
  %t2239 = phi double [ %t1344, %merge72 ], [ %t1310, %merge75 ]
  %t2240 = phi { i8**, i64 }* [ %t1345, %merge72 ], [ %t2223, %merge75 ]
  %t2241 = phi double [ %t1312, %merge72 ], [ %t2220, %merge75 ]
  %t2242 = phi { %MatchContext*, i64 }* [ %t1311, %merge72 ], [ %t2222, %merge75 ]
  store %PythonBuilder %t2238, %PythonBuilder* %l0
  store double %t2239, double* %l4
  store { i8**, i64 }* %t2240, { i8**, i64 }** %l1
  store double %t2241, double* %l6
  store { %MatchContext*, i64 }* %t2242, { %MatchContext*, i64 }** %l5
  %t2243 = load %PythonBuilder, %PythonBuilder* %l0
  %t2244 = load double, double* %l4
  %t2245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2246 = load %PythonBuilder, %PythonBuilder* %l0
  %t2247 = load %PythonBuilder, %PythonBuilder* %l0
  %t2248 = load double, double* %l6
  %t2249 = load %PythonBuilder, %PythonBuilder* %l0
  %t2250 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2251 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2252 = load %PythonBuilder, %PythonBuilder* %l0
  %t2253 = load %PythonBuilder, %PythonBuilder* %l0
  %t2254 = load %PythonBuilder, %PythonBuilder* %l0
  %t2255 = load %PythonBuilder, %PythonBuilder* %l0
  %t2256 = load %PythonBuilder, %PythonBuilder* %l0
  %t2257 = load %PythonBuilder, %PythonBuilder* %l0
  %t2258 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2259 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2260 = load %PythonBuilder, %PythonBuilder* %l0
  %t2261 = load %PythonBuilder, %PythonBuilder* %l0
  %t2262 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2263 = load %PythonBuilder, %PythonBuilder* %l0
  %t2264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2265 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge66
merge66:
  %t2266 = phi %PythonBuilder [ %t1246, %then64 ], [ %t2243, %merge69 ]
  %t2267 = phi double [ %t1248, %then64 ], [ %t2244, %merge69 ]
  %t2268 = phi { i8**, i64 }* [ %t1229, %then64 ], [ %t2245, %merge69 ]
  %t2269 = phi double [ %t1234, %then64 ], [ %t2248, %merge69 ]
  %t2270 = phi { %MatchContext*, i64 }* [ %t1233, %then64 ], [ %t2250, %merge69 ]
  store %PythonBuilder %t2266, %PythonBuilder* %l0
  store double %t2267, double* %l4
  store { i8**, i64 }* %t2268, { i8**, i64 }** %l1
  store double %t2269, double* %l6
  store { %MatchContext*, i64 }* %t2270, { %MatchContext*, i64 }** %l5
  %t2271 = load %PythonBuilder, %PythonBuilder* %l0
  %t2272 = load %PythonBuilder, %PythonBuilder* %l0
  %t2273 = load double, double* %l4
  %t2274 = load %PythonBuilder, %PythonBuilder* %l0
  %t2275 = load double, double* %l4
  %t2276 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2277 = load %PythonBuilder, %PythonBuilder* %l0
  %t2278 = load %PythonBuilder, %PythonBuilder* %l0
  %t2279 = load double, double* %l6
  %t2280 = load %PythonBuilder, %PythonBuilder* %l0
  %t2281 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2283 = load %PythonBuilder, %PythonBuilder* %l0
  %t2284 = load %PythonBuilder, %PythonBuilder* %l0
  %t2285 = load %PythonBuilder, %PythonBuilder* %l0
  %t2286 = load %PythonBuilder, %PythonBuilder* %l0
  %t2287 = load %PythonBuilder, %PythonBuilder* %l0
  %t2288 = load %PythonBuilder, %PythonBuilder* %l0
  %t2289 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2290 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2291 = load %PythonBuilder, %PythonBuilder* %l0
  %t2292 = load %PythonBuilder, %PythonBuilder* %l0
  %t2293 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2294 = load %PythonBuilder, %PythonBuilder* %l0
  %t2295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2296 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge60
merge60:
  %t2297 = phi %PythonBuilder [ %t1168, %merge63 ], [ %t2271, %merge66 ]
  %t2298 = phi double [ %t1169, %merge63 ], [ %t2273, %merge66 ]
  %t2299 = phi { i8**, i64 }* [ %t1170, %merge63 ], [ %t2276, %merge66 ]
  %t2300 = phi double [ %t1137, %merge63 ], [ %t2279, %merge66 ]
  %t2301 = phi { %MatchContext*, i64 }* [ %t1136, %merge63 ], [ %t2281, %merge66 ]
  store %PythonBuilder %t2297, %PythonBuilder* %l0
  store double %t2298, double* %l4
  store { i8**, i64 }* %t2299, { i8**, i64 }** %l1
  store double %t2300, double* %l6
  store { %MatchContext*, i64 }* %t2301, { %MatchContext*, i64 }** %l5
  %t2302 = load %PythonBuilder, %PythonBuilder* %l0
  %t2303 = load double, double* %l4
  %t2304 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2305 = load %PythonBuilder, %PythonBuilder* %l0
  %t2306 = load %PythonBuilder, %PythonBuilder* %l0
  %t2307 = load double, double* %l4
  %t2308 = load %PythonBuilder, %PythonBuilder* %l0
  %t2309 = load double, double* %l4
  %t2310 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2311 = load %PythonBuilder, %PythonBuilder* %l0
  %t2312 = load %PythonBuilder, %PythonBuilder* %l0
  %t2313 = load double, double* %l6
  %t2314 = load %PythonBuilder, %PythonBuilder* %l0
  %t2315 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2317 = load %PythonBuilder, %PythonBuilder* %l0
  %t2318 = load %PythonBuilder, %PythonBuilder* %l0
  %t2319 = load %PythonBuilder, %PythonBuilder* %l0
  %t2320 = load %PythonBuilder, %PythonBuilder* %l0
  %t2321 = load %PythonBuilder, %PythonBuilder* %l0
  %t2322 = load %PythonBuilder, %PythonBuilder* %l0
  %t2323 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2324 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2325 = load %PythonBuilder, %PythonBuilder* %l0
  %t2326 = load %PythonBuilder, %PythonBuilder* %l0
  %t2327 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2328 = load %PythonBuilder, %PythonBuilder* %l0
  %t2329 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2330 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge57
merge57:
  %t2331 = phi %PythonBuilder [ %t1071, %then55 ], [ %t2302, %merge60 ]
  %t2332 = phi double [ %t1073, %then55 ], [ %t2303, %merge60 ]
  %t2333 = phi { i8**, i64 }* [ %t1023, %then55 ], [ %t2304, %merge60 ]
  %t2334 = phi double [ %t1028, %then55 ], [ %t2313, %merge60 ]
  %t2335 = phi { %MatchContext*, i64 }* [ %t1027, %then55 ], [ %t2315, %merge60 ]
  store %PythonBuilder %t2331, %PythonBuilder* %l0
  store double %t2332, double* %l4
  store { i8**, i64 }* %t2333, { i8**, i64 }** %l1
  store double %t2334, double* %l6
  store { %MatchContext*, i64 }* %t2335, { %MatchContext*, i64 }** %l5
  %t2336 = load %PythonBuilder, %PythonBuilder* %l0
  %t2337 = load %PythonBuilder, %PythonBuilder* %l0
  %t2338 = load double, double* %l4
  %t2339 = load %PythonBuilder, %PythonBuilder* %l0
  %t2340 = load double, double* %l4
  %t2341 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2342 = load %PythonBuilder, %PythonBuilder* %l0
  %t2343 = load %PythonBuilder, %PythonBuilder* %l0
  %t2344 = load double, double* %l4
  %t2345 = load %PythonBuilder, %PythonBuilder* %l0
  %t2346 = load double, double* %l4
  %t2347 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2348 = load %PythonBuilder, %PythonBuilder* %l0
  %t2349 = load %PythonBuilder, %PythonBuilder* %l0
  %t2350 = load double, double* %l6
  %t2351 = load %PythonBuilder, %PythonBuilder* %l0
  %t2352 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2353 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2354 = load %PythonBuilder, %PythonBuilder* %l0
  %t2355 = load %PythonBuilder, %PythonBuilder* %l0
  %t2356 = load %PythonBuilder, %PythonBuilder* %l0
  %t2357 = load %PythonBuilder, %PythonBuilder* %l0
  %t2358 = load %PythonBuilder, %PythonBuilder* %l0
  %t2359 = load %PythonBuilder, %PythonBuilder* %l0
  %t2360 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2361 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2362 = load %PythonBuilder, %PythonBuilder* %l0
  %t2363 = load %PythonBuilder, %PythonBuilder* %l0
  %t2364 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2365 = load %PythonBuilder, %PythonBuilder* %l0
  %t2366 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2367 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge51
merge51:
  %t2368 = phi %PythonBuilder [ %t962, %merge54 ], [ %t2336, %merge57 ]
  %t2369 = phi double [ %t963, %merge54 ], [ %t2338, %merge57 ]
  %t2370 = phi { i8**, i64 }* [ %t964, %merge54 ], [ %t2341, %merge57 ]
  %t2371 = phi double [ %t931, %merge54 ], [ %t2350, %merge57 ]
  %t2372 = phi { %MatchContext*, i64 }* [ %t930, %merge54 ], [ %t2352, %merge57 ]
  store %PythonBuilder %t2368, %PythonBuilder* %l0
  store double %t2369, double* %l4
  store { i8**, i64 }* %t2370, { i8**, i64 }** %l1
  store double %t2371, double* %l6
  store { %MatchContext*, i64 }* %t2372, { %MatchContext*, i64 }** %l5
  %t2373 = load %PythonBuilder, %PythonBuilder* %l0
  %t2374 = load double, double* %l4
  %t2375 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2376 = load %PythonBuilder, %PythonBuilder* %l0
  %t2377 = load %PythonBuilder, %PythonBuilder* %l0
  %t2378 = load double, double* %l4
  %t2379 = load %PythonBuilder, %PythonBuilder* %l0
  %t2380 = load double, double* %l4
  %t2381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2382 = load %PythonBuilder, %PythonBuilder* %l0
  %t2383 = load %PythonBuilder, %PythonBuilder* %l0
  %t2384 = load double, double* %l4
  %t2385 = load %PythonBuilder, %PythonBuilder* %l0
  %t2386 = load double, double* %l4
  %t2387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2388 = load %PythonBuilder, %PythonBuilder* %l0
  %t2389 = load %PythonBuilder, %PythonBuilder* %l0
  %t2390 = load double, double* %l6
  %t2391 = load %PythonBuilder, %PythonBuilder* %l0
  %t2392 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2393 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2394 = load %PythonBuilder, %PythonBuilder* %l0
  %t2395 = load %PythonBuilder, %PythonBuilder* %l0
  %t2396 = load %PythonBuilder, %PythonBuilder* %l0
  %t2397 = load %PythonBuilder, %PythonBuilder* %l0
  %t2398 = load %PythonBuilder, %PythonBuilder* %l0
  %t2399 = load %PythonBuilder, %PythonBuilder* %l0
  %t2400 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2401 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2402 = load %PythonBuilder, %PythonBuilder* %l0
  %t2403 = load %PythonBuilder, %PythonBuilder* %l0
  %t2404 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2405 = load %PythonBuilder, %PythonBuilder* %l0
  %t2406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2407 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
merge45:
  %t2408 = phi %PythonBuilder [ %t864, %merge48 ], [ %t2373, %merge51 ]
  %t2409 = phi { i8**, i64 }* [ %t865, %merge48 ], [ %t2375, %merge51 ]
  %t2410 = phi double [ %t830, %merge48 ], [ %t2374, %merge51 ]
  %t2411 = phi double [ %t832, %merge48 ], [ %t2390, %merge51 ]
  %t2412 = phi { %MatchContext*, i64 }* [ %t831, %merge48 ], [ %t2392, %merge51 ]
  store %PythonBuilder %t2408, %PythonBuilder* %l0
  store { i8**, i64 }* %t2409, { i8**, i64 }** %l1
  store double %t2410, double* %l4
  store double %t2411, double* %l6
  store { %MatchContext*, i64 }* %t2412, { %MatchContext*, i64 }** %l5
  %t2413 = load %PythonBuilder, %PythonBuilder* %l0
  %t2414 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2415 = load %PythonBuilder, %PythonBuilder* %l0
  %t2416 = load %PythonBuilder, %PythonBuilder* %l0
  %t2417 = load %PythonBuilder, %PythonBuilder* %l0
  %t2418 = load double, double* %l4
  %t2419 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2420 = load %PythonBuilder, %PythonBuilder* %l0
  %t2421 = load %PythonBuilder, %PythonBuilder* %l0
  %t2422 = load double, double* %l4
  %t2423 = load %PythonBuilder, %PythonBuilder* %l0
  %t2424 = load double, double* %l4
  %t2425 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2426 = load %PythonBuilder, %PythonBuilder* %l0
  %t2427 = load %PythonBuilder, %PythonBuilder* %l0
  %t2428 = load double, double* %l4
  %t2429 = load %PythonBuilder, %PythonBuilder* %l0
  %t2430 = load double, double* %l4
  %t2431 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2432 = load %PythonBuilder, %PythonBuilder* %l0
  %t2433 = load %PythonBuilder, %PythonBuilder* %l0
  %t2434 = load double, double* %l6
  %t2435 = load %PythonBuilder, %PythonBuilder* %l0
  %t2436 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2437 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2438 = load %PythonBuilder, %PythonBuilder* %l0
  %t2439 = load %PythonBuilder, %PythonBuilder* %l0
  %t2440 = load %PythonBuilder, %PythonBuilder* %l0
  %t2441 = load %PythonBuilder, %PythonBuilder* %l0
  %t2442 = load %PythonBuilder, %PythonBuilder* %l0
  %t2443 = load %PythonBuilder, %PythonBuilder* %l0
  %t2444 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2446 = load %PythonBuilder, %PythonBuilder* %l0
  %t2447 = load %PythonBuilder, %PythonBuilder* %l0
  %t2448 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2449 = load %PythonBuilder, %PythonBuilder* %l0
  %t2450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2451 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge42
merge42:
  %t2452 = phi %PythonBuilder [ %t766, %then40 ], [ %t2413, %merge45 ]
  %t2453 = phi double [ %t768, %then40 ], [ %t2418, %merge45 ]
  %t2454 = phi { i8**, i64 }* [ %t732, %then40 ], [ %t2414, %merge45 ]
  %t2455 = phi double [ %t737, %then40 ], [ %t2434, %merge45 ]
  %t2456 = phi { %MatchContext*, i64 }* [ %t736, %then40 ], [ %t2436, %merge45 ]
  store %PythonBuilder %t2452, %PythonBuilder* %l0
  store double %t2453, double* %l4
  store { i8**, i64 }* %t2454, { i8**, i64 }** %l1
  store double %t2455, double* %l6
  store { %MatchContext*, i64 }* %t2456, { %MatchContext*, i64 }** %l5
  %t2457 = load %PythonBuilder, %PythonBuilder* %l0
  %t2458 = load %PythonBuilder, %PythonBuilder* %l0
  %t2459 = load double, double* %l4
  %t2460 = load %PythonBuilder, %PythonBuilder* %l0
  %t2461 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2462 = load %PythonBuilder, %PythonBuilder* %l0
  %t2463 = load %PythonBuilder, %PythonBuilder* %l0
  %t2464 = load %PythonBuilder, %PythonBuilder* %l0
  %t2465 = load double, double* %l4
  %t2466 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2467 = load %PythonBuilder, %PythonBuilder* %l0
  %t2468 = load %PythonBuilder, %PythonBuilder* %l0
  %t2469 = load double, double* %l4
  %t2470 = load %PythonBuilder, %PythonBuilder* %l0
  %t2471 = load double, double* %l4
  %t2472 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2473 = load %PythonBuilder, %PythonBuilder* %l0
  %t2474 = load %PythonBuilder, %PythonBuilder* %l0
  %t2475 = load double, double* %l4
  %t2476 = load %PythonBuilder, %PythonBuilder* %l0
  %t2477 = load double, double* %l4
  %t2478 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2479 = load %PythonBuilder, %PythonBuilder* %l0
  %t2480 = load %PythonBuilder, %PythonBuilder* %l0
  %t2481 = load double, double* %l6
  %t2482 = load %PythonBuilder, %PythonBuilder* %l0
  %t2483 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2484 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2485 = load %PythonBuilder, %PythonBuilder* %l0
  %t2486 = load %PythonBuilder, %PythonBuilder* %l0
  %t2487 = load %PythonBuilder, %PythonBuilder* %l0
  %t2488 = load %PythonBuilder, %PythonBuilder* %l0
  %t2489 = load %PythonBuilder, %PythonBuilder* %l0
  %t2490 = load %PythonBuilder, %PythonBuilder* %l0
  %t2491 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2492 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2493 = load %PythonBuilder, %PythonBuilder* %l0
  %t2494 = load %PythonBuilder, %PythonBuilder* %l0
  %t2495 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2496 = load %PythonBuilder, %PythonBuilder* %l0
  %t2497 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2498 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
merge31:
  %t2499 = phi double [ %t672, %merge34 ], [ %t541, %merge42 ]
  %t2500 = phi %PythonBuilder [ %t673, %merge34 ], [ %t2457, %merge42 ]
  %t2501 = phi double [ %t538, %merge34 ], [ %t2459, %merge42 ]
  %t2502 = phi { i8**, i64 }* [ %t535, %merge34 ], [ %t2461, %merge42 ]
  %t2503 = phi double [ %t540, %merge34 ], [ %t2481, %merge42 ]
  %t2504 = phi { %MatchContext*, i64 }* [ %t539, %merge34 ], [ %t2483, %merge42 ]
  store double %t2499, double* %l7
  store %PythonBuilder %t2500, %PythonBuilder* %l0
  store double %t2501, double* %l4
  store { i8**, i64 }* %t2502, { i8**, i64 }** %l1
  store double %t2503, double* %l6
  store { %MatchContext*, i64 }* %t2504, { %MatchContext*, i64 }** %l5
  %t2505 = load double, double* %l7
  %t2506 = load %PythonBuilder, %PythonBuilder* %l0
  %t2507 = load %PythonBuilder, %PythonBuilder* %l0
  %t2508 = load %PythonBuilder, %PythonBuilder* %l0
  %t2509 = load double, double* %l4
  %t2510 = load %PythonBuilder, %PythonBuilder* %l0
  %t2511 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2512 = load %PythonBuilder, %PythonBuilder* %l0
  %t2513 = load %PythonBuilder, %PythonBuilder* %l0
  %t2514 = load %PythonBuilder, %PythonBuilder* %l0
  %t2515 = load double, double* %l4
  %t2516 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2517 = load %PythonBuilder, %PythonBuilder* %l0
  %t2518 = load %PythonBuilder, %PythonBuilder* %l0
  %t2519 = load double, double* %l4
  %t2520 = load %PythonBuilder, %PythonBuilder* %l0
  %t2521 = load double, double* %l4
  %t2522 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2523 = load %PythonBuilder, %PythonBuilder* %l0
  %t2524 = load %PythonBuilder, %PythonBuilder* %l0
  %t2525 = load double, double* %l4
  %t2526 = load %PythonBuilder, %PythonBuilder* %l0
  %t2527 = load double, double* %l4
  %t2528 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2529 = load %PythonBuilder, %PythonBuilder* %l0
  %t2530 = load %PythonBuilder, %PythonBuilder* %l0
  %t2531 = load double, double* %l6
  %t2532 = load %PythonBuilder, %PythonBuilder* %l0
  %t2533 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2534 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2535 = load %PythonBuilder, %PythonBuilder* %l0
  %t2536 = load %PythonBuilder, %PythonBuilder* %l0
  %t2537 = load %PythonBuilder, %PythonBuilder* %l0
  %t2538 = load %PythonBuilder, %PythonBuilder* %l0
  %t2539 = load %PythonBuilder, %PythonBuilder* %l0
  %t2540 = load %PythonBuilder, %PythonBuilder* %l0
  %t2541 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2542 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2543 = load %PythonBuilder, %PythonBuilder* %l0
  %t2544 = load %PythonBuilder, %PythonBuilder* %l0
  %t2545 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2546 = load %PythonBuilder, %PythonBuilder* %l0
  %t2547 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2548 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge23
merge23:
  %t2549 = phi %PythonBuilder [ %t475, %merge26 ], [ %t2506, %merge31 ]
  %t2550 = phi double [ %t476, %merge26 ], [ %t2505, %merge31 ]
  %t2551 = phi double [ %t382, %merge26 ], [ %t2509, %merge31 ]
  %t2552 = phi { i8**, i64 }* [ %t379, %merge26 ], [ %t2511, %merge31 ]
  %t2553 = phi double [ %t384, %merge26 ], [ %t2531, %merge31 ]
  %t2554 = phi { %MatchContext*, i64 }* [ %t383, %merge26 ], [ %t2533, %merge31 ]
  store %PythonBuilder %t2549, %PythonBuilder* %l0
  store double %t2550, double* %l7
  store double %t2551, double* %l4
  store { i8**, i64 }* %t2552, { i8**, i64 }** %l1
  store double %t2553, double* %l6
  store { %MatchContext*, i64 }* %t2554, { %MatchContext*, i64 }** %l5
  %t2555 = load %PythonBuilder, %PythonBuilder* %l0
  %t2556 = load double, double* %l7
  %t2557 = load double, double* %l7
  %t2558 = load %PythonBuilder, %PythonBuilder* %l0
  %t2559 = load %PythonBuilder, %PythonBuilder* %l0
  %t2560 = load %PythonBuilder, %PythonBuilder* %l0
  %t2561 = load double, double* %l4
  %t2562 = load %PythonBuilder, %PythonBuilder* %l0
  %t2563 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2564 = load %PythonBuilder, %PythonBuilder* %l0
  %t2565 = load %PythonBuilder, %PythonBuilder* %l0
  %t2566 = load %PythonBuilder, %PythonBuilder* %l0
  %t2567 = load double, double* %l4
  %t2568 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2569 = load %PythonBuilder, %PythonBuilder* %l0
  %t2570 = load %PythonBuilder, %PythonBuilder* %l0
  %t2571 = load double, double* %l4
  %t2572 = load %PythonBuilder, %PythonBuilder* %l0
  %t2573 = load double, double* %l4
  %t2574 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2575 = load %PythonBuilder, %PythonBuilder* %l0
  %t2576 = load %PythonBuilder, %PythonBuilder* %l0
  %t2577 = load double, double* %l4
  %t2578 = load %PythonBuilder, %PythonBuilder* %l0
  %t2579 = load double, double* %l4
  %t2580 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2581 = load %PythonBuilder, %PythonBuilder* %l0
  %t2582 = load %PythonBuilder, %PythonBuilder* %l0
  %t2583 = load double, double* %l6
  %t2584 = load %PythonBuilder, %PythonBuilder* %l0
  %t2585 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2586 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2587 = load %PythonBuilder, %PythonBuilder* %l0
  %t2588 = load %PythonBuilder, %PythonBuilder* %l0
  %t2589 = load %PythonBuilder, %PythonBuilder* %l0
  %t2590 = load %PythonBuilder, %PythonBuilder* %l0
  %t2591 = load %PythonBuilder, %PythonBuilder* %l0
  %t2592 = load %PythonBuilder, %PythonBuilder* %l0
  %t2593 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2594 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2595 = load %PythonBuilder, %PythonBuilder* %l0
  %t2596 = load %PythonBuilder, %PythonBuilder* %l0
  %t2597 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2598 = load %PythonBuilder, %PythonBuilder* %l0
  %t2599 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2600 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge12
merge12:
  %t2601 = phi %PythonBuilder [ %t318, %merge15 ], [ %t2555, %merge23 ]
  %t2602 = phi double [ %t320, %merge15 ], [ %t2556, %merge23 ]
  %t2603 = phi double [ %t181, %merge15 ], [ %t2561, %merge23 ]
  %t2604 = phi { i8**, i64 }* [ %t178, %merge15 ], [ %t2563, %merge23 ]
  %t2605 = phi double [ %t183, %merge15 ], [ %t2583, %merge23 ]
  %t2606 = phi { %MatchContext*, i64 }* [ %t182, %merge15 ], [ %t2585, %merge23 ]
  store %PythonBuilder %t2601, %PythonBuilder* %l0
  store double %t2602, double* %l7
  store double %t2603, double* %l4
  store { i8**, i64 }* %t2604, { i8**, i64 }** %l1
  store double %t2605, double* %l6
  store { %MatchContext*, i64 }* %t2606, { %MatchContext*, i64 }** %l5
  %t2607 = load double, double* %l7
  %t2608 = sitofp i64 1 to double
  %t2609 = fadd double %t2607, %t2608
  store double %t2609, double* %l7
  br label %loop.latch6
loop.latch6:
  %t2610 = load %PythonBuilder, %PythonBuilder* %l0
  %t2611 = load double, double* %l7
  %t2612 = load double, double* %l4
  %t2613 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2614 = load double, double* %l6
  %t2615 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t2622 = load %PythonBuilder, %PythonBuilder* %l0
  %t2623 = load double, double* %l7
  %t2624 = load double, double* %l4
  %t2625 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2626 = load double, double* %l6
  %t2627 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2628 = load %PythonBuilder, %PythonBuilder* %l0
  %t2629 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2630 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2631 = load i8*, i8** %l3
  %t2632 = load double, double* %l4
  %t2633 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2634 = load double, double* %l6
  %t2635 = load double, double* %l7
  br label %loop.header111
loop.header111:
  %t2688 = phi %PythonBuilder [ %t2628, %afterloop7 ], [ %t2685, %loop.latch113 ]
  %t2689 = phi { i8**, i64 }* [ %t2629, %afterloop7 ], [ %t2686, %loop.latch113 ]
  %t2690 = phi { %MatchContext*, i64 }* [ %t2633, %afterloop7 ], [ %t2687, %loop.latch113 ]
  store %PythonBuilder %t2688, %PythonBuilder* %l0
  store { i8**, i64 }* %t2689, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t2690, { %MatchContext*, i64 }** %l5
  br label %loop.body112
loop.body112:
  %t2636 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2637 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2636
  %t2638 = extractvalue { %MatchContext*, i64 } %t2637, 1
  %t2639 = icmp eq i64 %t2638, 0
  %t2640 = load %PythonBuilder, %PythonBuilder* %l0
  %t2641 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2642 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2643 = load i8*, i8** %l3
  %t2644 = load double, double* %l4
  %t2645 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2646 = load double, double* %l6
  %t2647 = load double, double* %l7
  br i1 %t2639, label %then115, label %merge116
then115:
  br label %afterloop114
merge116:
  %t2648 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2649 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2648
  %t2650 = extractvalue { %MatchContext*, i64 } %t2649, 1
  %t2651 = sub i64 %t2650, 1
  store i64 %t2651, i64* %l38
  %t2652 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2653 = load i64, i64* %l38
  %t2654 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2652
  %t2655 = extractvalue { %MatchContext*, i64 } %t2654, 0
  %t2656 = extractvalue { %MatchContext*, i64 } %t2654, 1
  %t2657 = icmp uge i64 %t2653, %t2656
  ; bounds check: %t2657 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2653, i64 %t2656)
  %t2658 = getelementptr %MatchContext, %MatchContext* %t2655, i64 %t2653
  %t2659 = load %MatchContext, %MatchContext* %t2658
  store %MatchContext %t2659, %MatchContext* %l39
  %t2660 = load %MatchContext, %MatchContext* %l39
  %t2661 = extractvalue %MatchContext %t2660, 2
  %t2662 = load %PythonBuilder, %PythonBuilder* %l0
  %t2663 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2664 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2665 = load i8*, i8** %l3
  %t2666 = load double, double* %l4
  %t2667 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2668 = load double, double* %l6
  %t2669 = load double, double* %l7
  %t2670 = load i64, i64* %l38
  %t2671 = load %MatchContext, %MatchContext* %l39
  br i1 %t2661, label %then117, label %merge118
then117:
  %t2672 = load %PythonBuilder, %PythonBuilder* %l0
  %t2673 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2672)
  store %PythonBuilder %t2673, %PythonBuilder* %l0
  %t2674 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge118
merge118:
  %t2675 = phi %PythonBuilder [ %t2674, %then117 ], [ %t2662, %merge116 ]
  store %PythonBuilder %t2675, %PythonBuilder* %l0
  %t2676 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2677 = extractvalue %NativeFunction %function, 0
  %t2678 = call i8* @malloc(i64 30)
  %t2679 = bitcast i8* %t2678 to [30 x i8]*
  store [30 x i8] c"unterminated match expression\00", [30 x i8]* %t2679
  %t2680 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2676, i8* %t2677, i8* %t2678)
  store { i8**, i64 }* %t2680, { i8**, i64 }** %l1
  %t2681 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2682 = load i64, i64* %l38
  %t2683 = sitofp i64 %t2682 to double
  %t2684 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t2681, double %t2683)
  store { %MatchContext*, i64 }* %t2684, { %MatchContext*, i64 }** %l5
  br label %loop.latch113
loop.latch113:
  %t2685 = load %PythonBuilder, %PythonBuilder* %l0
  %t2686 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2687 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header111
afterloop114:
  %t2691 = load %PythonBuilder, %PythonBuilder* %l0
  %t2692 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2693 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2694 = load %PythonBuilder, %PythonBuilder* %l0
  %t2695 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2696 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2697 = load i8*, i8** %l3
  %t2698 = load double, double* %l4
  %t2699 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2700 = load double, double* %l6
  %t2701 = load double, double* %l7
  br label %loop.header119
loop.header119:
  %t2726 = phi %PythonBuilder [ %t2694, %afterloop114 ], [ %t2723, %loop.latch121 ]
  %t2727 = phi double [ %t2698, %afterloop114 ], [ %t2724, %loop.latch121 ]
  %t2728 = phi { i8**, i64 }* [ %t2695, %afterloop114 ], [ %t2725, %loop.latch121 ]
  store %PythonBuilder %t2726, %PythonBuilder* %l0
  store double %t2727, double* %l4
  store { i8**, i64 }* %t2728, { i8**, i64 }** %l1
  br label %loop.body120
loop.body120:
  %t2702 = load double, double* %l4
  %t2703 = sitofp i64 0 to double
  %t2704 = fcmp ole double %t2702, %t2703
  %t2705 = load %PythonBuilder, %PythonBuilder* %l0
  %t2706 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2707 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2708 = load i8*, i8** %l3
  %t2709 = load double, double* %l4
  %t2710 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2711 = load double, double* %l6
  %t2712 = load double, double* %l7
  br i1 %t2704, label %then123, label %merge124
then123:
  br label %afterloop122
merge124:
  %t2713 = load %PythonBuilder, %PythonBuilder* %l0
  %t2714 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2713)
  store %PythonBuilder %t2714, %PythonBuilder* %l0
  %t2715 = load double, double* %l4
  %t2716 = sitofp i64 1 to double
  %t2717 = fsub double %t2715, %t2716
  store double %t2717, double* %l4
  %t2718 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2719 = extractvalue %NativeFunction %function, 0
  %t2720 = call i8* @malloc(i64 32)
  %t2721 = bitcast i8* %t2720 to [32 x i8]*
  store [32 x i8] c"unterminated control-flow block\00", [32 x i8]* %t2721
  %t2722 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2718, i8* %t2719, i8* %t2720)
  store { i8**, i64 }* %t2722, { i8**, i64 }** %l1
  br label %loop.latch121
loop.latch121:
  %t2723 = load %PythonBuilder, %PythonBuilder* %l0
  %t2724 = load double, double* %l4
  %t2725 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header119
afterloop122:
  %t2729 = load %PythonBuilder, %PythonBuilder* %l0
  %t2730 = load double, double* %l4
  %t2731 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2732 = load %PythonBuilder, %PythonBuilder* %l0
  %t2733 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2732)
  store %PythonBuilder %t2733, %PythonBuilder* %l0
  %t2734 = load %PythonBuilder, %PythonBuilder* %l0
  %t2735 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t2734, 0
  %t2736 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2737 = insertvalue %PythonFunctionEmission %t2735, { i8**, i64 }* %t2736, 1
  ret %PythonFunctionEmission %t2737
}

define { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %values, %MatchContext %value) {
block.entry:
  %t0 = getelementptr [1 x %MatchContext], [1 x %MatchContext]* null, i32 1
  %t1 = ptrtoint [1 x %MatchContext]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %MatchContext*
  %t6 = getelementptr %MatchContext, %MatchContext* %t5, i64 0
  store %MatchContext %value, %MatchContext* %t6
  %t7 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t8 = ptrtoint { %MatchContext*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %MatchContext*, i64 }*
  %t11 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t10, i32 0, i32 0
  store %MatchContext* %t5, %MatchContext** %t11
  %t12 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values, i32 0, i32 0
  %t14 = load %MatchContext*, %MatchContext** %t13
  %t15 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t10, i32 0, i32 0
  %t18 = load %MatchContext*, %MatchContext** %t17
  %t19 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %MatchContext], [1 x %MatchContext]* null, i32 0, i32 1
  %t22 = ptrtoint %MatchContext* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %MatchContext*
  %t27 = bitcast %MatchContext* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %MatchContext* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %MatchContext* %t18 to i8*
  %t32 = getelementptr %MatchContext, %MatchContext* %t26, i64 %t16
  %t33 = bitcast %MatchContext* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t35 = ptrtoint { %MatchContext*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %MatchContext*, i64 }*
  %t38 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t37, i32 0, i32 0
  store %MatchContext* %t26, %MatchContext** %t38
  %t39 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %MatchContext*, i64 }* %t37
}

define { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %values, double %index, %MatchContext %replacement) {
block.entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t1 = ptrtoint [0 x %MatchContext]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %MatchContext*
  %t6 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t7 = ptrtoint { %MatchContext*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %MatchContext*, i64 }*
  %t10 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t9, i32 0, i32 0
  store %MatchContext* %t5, %MatchContext** %t10
  %t11 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %MatchContext*, i64 }* %t9, { %MatchContext*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t47 = phi { %MatchContext*, i64 }* [ %t13, %block.entry ], [ %t45, %loop.latch2 ]
  %t48 = phi double [ %t14, %block.entry ], [ %t46, %loop.latch2 ]
  store { %MatchContext*, i64 }* %t47, { %MatchContext*, i64 }** %l0
  store double %t48, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t17 = extractvalue { %MatchContext*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = fcmp oeq double %t22, %index
  %t24 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %else7
then6:
  %t26 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t27 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t26, %MatchContext %replacement)
  store { %MatchContext*, i64 }* %t27, { %MatchContext*, i64 }** %l0
  %t28 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  br label %merge8
else7:
  %t29 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t34 = extractvalue { %MatchContext*, i64 } %t33, 0
  %t35 = extractvalue { %MatchContext*, i64 } %t33, 1
  %t36 = icmp uge i64 %t32, %t35
  ; bounds check: %t36 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t32, i64 %t35)
  %t37 = getelementptr %MatchContext, %MatchContext* %t34, i64 %t32
  %t38 = load %MatchContext, %MatchContext* %t37
  %t39 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t29, %MatchContext %t38)
  store { %MatchContext*, i64 }* %t39, { %MatchContext*, i64 }** %l0
  %t40 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  br label %merge8
merge8:
  %t41 = phi { %MatchContext*, i64 }* [ %t28, %then6 ], [ %t40, %else7 ]
  store { %MatchContext*, i64 }* %t41, { %MatchContext*, i64 }** %l0
  %t42 = load double, double* %l1
  %t43 = sitofp i64 1 to double
  %t44 = fadd double %t42, %t43
  store double %t44, double* %l1
  br label %loop.latch2
loop.latch2:
  %t45 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t46 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t49 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t51
}

define { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %values, double %end_index) {
block.entry:
  %l0 = alloca { %MatchContext*, i64 }*
  %l1 = alloca double
  %t0 = sitofp i64 0 to double
  %t1 = fcmp ole double %end_index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t3 = ptrtoint [0 x %MatchContext]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to %MatchContext*
  %t8 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t9 = ptrtoint { %MatchContext*, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { %MatchContext*, i64 }*
  %t12 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t11, i32 0, i32 0
  store %MatchContext* %t7, %MatchContext** %t12
  %t13 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  ret { %MatchContext*, i64 }* %t11
merge1:
  %t14 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t15 = ptrtoint [0 x %MatchContext]* %t14 to i64
  %t16 = icmp eq i64 %t15, 0
  %t17 = select i1 %t16, i64 1, i64 %t15
  %t18 = call i8* @malloc(i64 %t17)
  %t19 = bitcast i8* %t18 to %MatchContext*
  %t20 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t21 = ptrtoint { %MatchContext*, i64 }* %t20 to i64
  %t22 = call i8* @malloc(i64 %t21)
  %t23 = bitcast i8* %t22 to { %MatchContext*, i64 }*
  %t24 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t23, i32 0, i32 0
  store %MatchContext* %t19, %MatchContext** %t24
  %t25 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t23, i32 0, i32 1
  store i64 0, i64* %t25
  store { %MatchContext*, i64 }* %t23, { %MatchContext*, i64 }** %l0
  %t26 = sitofp i64 0 to double
  store double %t26, double* %l1
  %t27 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t28 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t49 = phi { %MatchContext*, i64 }* [ %t27, %merge1 ], [ %t47, %loop.latch4 ]
  %t50 = phi double [ %t28, %merge1 ], [ %t48, %loop.latch4 ]
  store { %MatchContext*, i64 }* %t49, { %MatchContext*, i64 }** %l0
  store double %t50, double* %l1
  br label %loop.body3
loop.body3:
  %t29 = load double, double* %l1
  %t30 = fcmp oge double %t29, %end_index
  %t31 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t33 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t34 = load double, double* %l1
  %t35 = call double @llvm.round.f64(double %t34)
  %t36 = fptosi double %t35 to i64
  %t37 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %values
  %t38 = extractvalue { %MatchContext*, i64 } %t37, 0
  %t39 = extractvalue { %MatchContext*, i64 } %t37, 1
  %t40 = icmp uge i64 %t36, %t39
  ; bounds check: %t40 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t36, i64 %t39)
  %t41 = getelementptr %MatchContext, %MatchContext* %t38, i64 %t36
  %t42 = load %MatchContext, %MatchContext* %t41
  %t43 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t33, %MatchContext %t42)
  store { %MatchContext*, i64 }* %t43, { %MatchContext*, i64 }** %l0
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch4
loop.latch4:
  %t47 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t48 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t51 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l0
  ret { %MatchContext*, i64 }* %t53
}

define i8* @generate_match_subject_name(double %counter) {
block.entry:
  %t0 = call i8* @malloc(i64 15)
  %t1 = bitcast i8* %t0 to [15 x i8]*
  store [15 x i8] c"__match_value_\00", [15 x i8]* %t1
  %t2 = call i8* @number_to_string(double %counter)
  %t3 = call i8* @sailfin_runtime_string_concat(i8* %t0, i8* %t2)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
}

define %LoweredCaseCondition @lower_match_case_condition(i8* %subject_name, i8* %pattern, i8* %guard) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i1
  %l7 = alloca i8*
  %t0 = call i8* @trim_text(i8* %pattern)
  store i8* %t0, i8** %l0
  store i8* null, i8** %l1
  %t1 = icmp ne i8* %guard, null
  %t2 = load i8*, i8** %l0
  %t3 = load i8*, i8** %l1
  br i1 %t1, label %then0, label %merge1
then0:
  %t4 = call i8* @trim_text(i8* %guard)
  store i8* %t4, i8** %l2
  %t5 = load i8*, i8** %l2
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = icmp sgt i64 %t6, 0
  %t8 = load i8*, i8** %l0
  %t9 = load i8*, i8** %l1
  %t10 = load i8*, i8** %l2
  br i1 %t7, label %then2, label %merge3
then2:
  %t11 = load i8*, i8** %l2
  store i8* %t11, i8** %l1
  %t12 = load i8*, i8** %l1
  br label %merge3
merge3:
  %t13 = phi i8* [ %t12, %then2 ], [ %t9, %then0 ]
  store i8* %t13, i8** %l1
  %t14 = load i8*, i8** %l1
  br label %merge1
merge1:
  %t15 = phi i8* [ %t14, %merge3 ], [ %t3, %block.entry ]
  store i8* %t15, i8** %l1
  %t17 = load i8*, i8** %l0
  %t18 = call i64 @sailfin_runtime_string_length(i8* %t17)
  %t19 = icmp eq i64 %t18, 0
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t19, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t20 = load i8*, i8** %l0
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 95
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t23 = phi i1 [ true, %logical_or_entry_16 ], [ %t22, %logical_or_right_end_16 ]
  %t24 = load i8*, i8** %l0
  %t25 = load i8*, i8** %l1
  br i1 %t23, label %then4, label %merge5
then4:
  %t26 = load i8*, i8** %l1
  %t27 = icmp eq i8* %t26, null
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  br i1 %t27, label %then6, label %merge7
then6:
  %t30 = call i8* @malloc(i64 5)
  %t31 = bitcast i8* %t30 to [5 x i8]*
  store [5 x i8] c"True\00", [5 x i8]* %t31
  %t32 = insertvalue %LoweredCaseCondition undef, i8* %t30, 0
  %t33 = insertvalue %LoweredCaseCondition %t32, i1 1, 1
  %t34 = insertvalue %LoweredCaseCondition %t33, i1 0, 2
  ret %LoweredCaseCondition %t34
merge7:
  %t35 = load i8*, i8** %l1
  %t36 = call i8* @lower_expression(i8* %t35)
  store i8* %t36, i8** %l3
  %t37 = load i8*, i8** %l3
  %t38 = insertvalue %LoweredCaseCondition undef, i8* %t37, 0
  %t39 = insertvalue %LoweredCaseCondition %t38, i1 0, 1
  %t40 = insertvalue %LoweredCaseCondition %t39, i1 1, 2
  ret %LoweredCaseCondition %t40
merge5:
  %t41 = load i8*, i8** %l0
  %t42 = call i8* @lower_expression(i8* %t41)
  store i8* %t42, i8** %l4
  %t43 = call i8* @malloc(i64 5)
  %t44 = bitcast i8* %t43 to [5 x i8]*
  store [5 x i8] c" == \00", [5 x i8]* %t44
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %subject_name, i8* %t43)
  %t46 = load i8*, i8** %l4
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t46)
  store i8* %t47, i8** %l5
  store i1 0, i1* %l6
  %t48 = load i8*, i8** %l1
  %t49 = icmp ne i8* %t48, null
  %t50 = load i8*, i8** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load i8*, i8** %l4
  %t53 = load i8*, i8** %l5
  %t54 = load i1, i1* %l6
  br i1 %t49, label %then8, label %merge9
then8:
  %t55 = load i8*, i8** %l1
  %t56 = call i8* @lower_expression(i8* %t55)
  store i8* %t56, i8** %l7
  %t57 = load i8*, i8** %l5
  %t58 = add i64 0, 2
  %t59 = call i8* @malloc(i64 %t58)
  store i8 40, i8* %t59
  %t60 = getelementptr i8, i8* %t59, i64 1
  store i8 0, i8* %t60
  call void @sailfin_runtime_mark_persistent(i8* %t59)
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %t57)
  %t62 = call i8* @malloc(i64 8)
  %t63 = bitcast i8* %t62 to [8 x i8]*
  store [8 x i8] c") and (\00", [8 x i8]* %t63
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t62)
  %t65 = load i8*, i8** %l7
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %t65)
  %t67 = add i64 0, 2
  %t68 = call i8* @malloc(i64 %t67)
  store i8 41, i8* %t68
  %t69 = getelementptr i8, i8* %t68, i64 1
  store i8 0, i8* %t69
  call void @sailfin_runtime_mark_persistent(i8* %t68)
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t68)
  store i8* %t70, i8** %l5
  store i1 1, i1* %l6
  %t71 = load i8*, i8** %l5
  %t72 = load i1, i1* %l6
  br label %merge9
merge9:
  %t73 = phi i8* [ %t71, %then8 ], [ %t53, %merge5 ]
  %t74 = phi i1 [ %t72, %then8 ], [ %t54, %merge5 ]
  store i8* %t73, i8** %l5
  store i1 %t74, i1* %l6
  %t75 = load i8*, i8** %l5
  %t76 = insertvalue %LoweredCaseCondition undef, i8* %t75, 0
  %t77 = insertvalue %LoweredCaseCondition %t76, i1 0, 1
  %t78 = load i1, i1* %l6
  %t79 = insertvalue %LoweredCaseCondition %t77, i1 %t78, 2
  ret %LoweredCaseCondition %t79
}

define i8* @number_to_string(double %value) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca i8*
  %t0 = sitofp i64 0 to double
  %t1 = fcmp oeq double %value, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = add i64 0, 2
  %t3 = call i8* @malloc(i64 %t2)
  store i8 48, i8* %t3
  %t4 = getelementptr i8, i8* %t3, i64 1
  store i8 0, i8* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = call i8* @malloc(i64 11)
  %t6 = bitcast i8* %t5 to [11 x i8]*
  store [11 x i8] c"0123456789\00", [11 x i8]* %t6
  store i8* %t5, i8** %l0
  store double %value, double* %l1
  %t7 = call i8* @malloc(i64 1)
  %t8 = bitcast i8* %t7 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t8
  store i8* %t7, i8** %l2
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t62 = phi i8* [ %t11, %merge1 ], [ %t60, %loop.latch4 ]
  %t63 = phi double [ %t10, %merge1 ], [ %t61, %loop.latch4 ]
  store i8* %t62, i8** %l2
  store double %t63, double* %l1
  br label %loop.body3
loop.body3:
  %t12 = load double, double* %l1
  %t13 = sitofp i64 0 to double
  %t14 = fcmp ole double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load i8*, i8** %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load double, double* %l1
  store double %t18, double* %l3
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l4
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  %t23 = load double, double* %l3
  %t24 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t41 = phi double [ %t23, %merge7 ], [ %t39, %loop.latch10 ]
  %t42 = phi double [ %t24, %merge7 ], [ %t40, %loop.latch10 ]
  store double %t41, double* %l3
  store double %t42, double* %l4
  br label %loop.body9
loop.body9:
  %t25 = load double, double* %l3
  %t26 = sitofp i64 10 to double
  %t27 = fcmp olt double %t25, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load double, double* %l1
  %t30 = load i8*, i8** %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  br i1 %t27, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t33 = load double, double* %l3
  %t34 = sitofp i64 10 to double
  %t35 = fsub double %t33, %t34
  store double %t35, double* %l3
  %t36 = load double, double* %l4
  %t37 = sitofp i64 1 to double
  %t38 = fadd double %t36, %t37
  store double %t38, double* %l4
  br label %loop.latch10
loop.latch10:
  %t39 = load double, double* %l3
  %t40 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t43 = load double, double* %l3
  %t44 = load double, double* %l4
  %t45 = load double, double* %l3
  store double %t45, double* %l5
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l5
  %t48 = load double, double* %l5
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  %t51 = call double @llvm.round.f64(double %t47)
  %t52 = fptosi double %t51 to i64
  %t53 = call double @llvm.round.f64(double %t50)
  %t54 = fptosi double %t53 to i64
  %t55 = call i8* @sailfin_runtime_substring(i8* %t46, i64 %t52, i64 %t54)
  store i8* %t55, i8** %l6
  %t56 = load i8*, i8** %l6
  %t57 = load i8*, i8** %l2
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t57)
  store i8* %t58, i8** %l2
  %t59 = load double, double* %l4
  store double %t59, double* %l1
  br label %loop.latch4
loop.latch4:
  %t60 = load i8*, i8** %l2
  %t61 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t64 = load i8*, i8** %l2
  %t65 = load double, double* %l1
  %t66 = load i8*, i8** %l2
  call void @sailfin_runtime_mark_persistent(i8* %t66)
  ret i8* %t66
}

define { i8**, i64 }* @render_python_parameters({ %NativeParameter*, i64 }* %parameters) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeParameter
  %l3 = alloca i8*
  %t0 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t1 = extractvalue { %NativeParameter*, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t4 = ptrtoint [0 x i8*]* %t3 to i64
  %t5 = icmp eq i64 %t4, 0
  %t6 = select i1 %t5, i64 1, i64 %t4
  %t7 = call i8* @malloc(i64 %t6)
  %t8 = bitcast i8* %t7 to i8**
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t8, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 0, i64* %t14
  ret { i8**, i64 }* %t12
merge1:
  %t15 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t16 = ptrtoint [0 x i8*]* %t15 to i64
  %t17 = icmp eq i64 %t16, 0
  %t18 = select i1 %t17, i64 1, i64 %t16
  %t19 = call i8* @malloc(i64 %t18)
  %t20 = bitcast i8* %t19 to i8**
  %t21 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t22 = ptrtoint { i8**, i64 }* %t21 to i64
  %t23 = call i8* @malloc(i64 %t22)
  %t24 = bitcast i8* %t23 to { i8**, i64 }*
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 0
  store i8** %t20, i8*** %t25
  %t26 = getelementptr { i8**, i64 }, { i8**, i64 }* %t24, i32 0, i32 1
  store i64 0, i64* %t26
  store { i8**, i64 }* %t24, { i8**, i64 }** %l0
  %t27 = sitofp i64 0 to double
  store double %t27, double* %l1
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t29 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t72 = phi { i8**, i64 }* [ %t28, %merge1 ], [ %t70, %loop.latch4 ]
  %t73 = phi double [ %t29, %merge1 ], [ %t71, %loop.latch4 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  store double %t73, double* %l1
  br label %loop.body3
loop.body3:
  %t30 = load double, double* %l1
  %t31 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t32 = extractvalue { %NativeParameter*, i64 } %t31, 1
  %t33 = sitofp i64 %t32 to double
  %t34 = fcmp oge double %t30, %t33
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t37 = load double, double* %l1
  %t38 = call double @llvm.round.f64(double %t37)
  %t39 = fptosi double %t38 to i64
  %t40 = load { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %parameters
  %t41 = extractvalue { %NativeParameter*, i64 } %t40, 0
  %t42 = extractvalue { %NativeParameter*, i64 } %t40, 1
  %t43 = icmp uge i64 %t39, %t42
  ; bounds check: %t43 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t39, i64 %t42)
  %t44 = getelementptr %NativeParameter, %NativeParameter* %t41, i64 %t39
  %t45 = load %NativeParameter, %NativeParameter* %t44
  store %NativeParameter %t45, %NativeParameter* %l2
  %t46 = load %NativeParameter, %NativeParameter* %l2
  %t47 = extractvalue %NativeParameter %t46, 0
  store i8* %t47, i8** %l3
  %t48 = load %NativeParameter, %NativeParameter* %l2
  %t49 = extractvalue %NativeParameter %t48, 3
  %t50 = icmp ne i8* %t49, null
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load double, double* %l1
  %t53 = load %NativeParameter, %NativeParameter* %l2
  %t54 = load i8*, i8** %l3
  br i1 %t50, label %then8, label %merge9
then8:
  %t55 = load i8*, i8** %l3
  %t56 = call i8* @malloc(i64 4)
  %t57 = bitcast i8* %t56 to [4 x i8]*
  store [4 x i8] c" = \00", [4 x i8]* %t57
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t56)
  %t59 = load %NativeParameter, %NativeParameter* %l2
  %t60 = extractvalue %NativeParameter %t59, 3
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t60)
  store i8* %t61, i8** %l3
  %t62 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t63 = phi i8* [ %t62, %then8 ], [ %t54, %merge7 ]
  store i8* %t63, i8** %l3
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l3
  %t66 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t64, i8* %t65)
  store { i8**, i64 }* %t66, { i8**, i64 }** %l0
  %t67 = load double, double* %l1
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l1
  br label %loop.latch4
loop.latch4:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t75 = load double, double* %l1
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t76
}

define %PythonBuilder @builder_new() {
block.entry:
  %t0 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1 = ptrtoint [0 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t7 = ptrtoint { i8**, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { i8**, i64 }*
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 0
  store i8** %t5, i8*** %t10
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  %t12 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t9, 0
  %t13 = sitofp i64 0 to double
  %t14 = insertvalue %PythonBuilder %t12, double %t13, 1
  ret %PythonBuilder %t14
}

define %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %line) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %t0 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %builder)
  ret %PythonBuilder %t2
merge1:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  store i8* %t3, i8** %l0
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l1
  %t6 = load i8*, i8** %l0
  %t7 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t22 = phi i8* [ %t6, %merge1 ], [ %t20, %loop.latch4 ]
  %t23 = phi double [ %t7, %merge1 ], [ %t21, %loop.latch4 ]
  store i8* %t22, i8** %l0
  store double %t23, double* %l1
  br label %loop.body3
loop.body3:
  %t8 = load double, double* %l1
  %t9 = extractvalue %PythonBuilder %builder, 1
  %t10 = fcmp oge double %t8, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load i8*, i8** %l0
  %t14 = call i8* @malloc(i64 5)
  %t15 = bitcast i8* %t14 to [5 x i8]*
  store [5 x i8] c"    \00", [5 x i8]* %t15
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t14)
  store i8* %t16, i8** %l0
  %t17 = load double, double* %l1
  %t18 = sitofp i64 1 to double
  %t19 = fadd double %t17, %t18
  store double %t19, double* %l1
  br label %loop.latch4
loop.latch4:
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l0
  %t27 = call i8* @sailfin_runtime_string_concat(i8* %t26, i8* %line)
  store i8* %t27, i8** %l2
  %t28 = extractvalue %PythonBuilder %builder, 0
  %t29 = load i8*, i8** %l2
  %t30 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t28, i8* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l3
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t32 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t31, 0
  %t33 = extractvalue %PythonBuilder %builder, 1
  %t34 = insertvalue %PythonBuilder %t32, double %t33, 1
  ret %PythonBuilder %t34
}

define %PythonBuilder @builder_emit_blank(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %PythonBuilder %builder, 0
  %t1 = call i8* @malloc(i64 1)
  %t2 = bitcast i8* %t1 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t2
  %t3 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %t1)
  store { i8**, i64 }* %t3, { i8**, i64 }** %l0
  %t4 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t5 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t4, 0
  %t6 = extractvalue %PythonBuilder %builder, 1
  %t7 = insertvalue %PythonBuilder %t5, double %t6, 1
  ret %PythonBuilder %t7
}

define %PythonBuilder @builder_push_indent(%PythonBuilder %builder) {
block.entry:
  %t0 = extractvalue %PythonBuilder %builder, 0
  %t1 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t0, 0
  %t2 = extractvalue %PythonBuilder %builder, 1
  %t3 = sitofp i64 1 to double
  %t4 = fadd double %t2, %t3
  %t5 = insertvalue %PythonBuilder %t1, double %t4, 1
  ret %PythonBuilder %t5
}

define %PythonBuilder @builder_pop_indent(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca double
  %t0 = extractvalue %PythonBuilder %builder, 1
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ogt double %t1, %t2
  %t4 = load double, double* %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load double, double* %l0
  %t6 = sitofp i64 1 to double
  %t7 = fsub double %t5, %t6
  store double %t7, double* %l0
  %t8 = load double, double* %l0
  br label %merge1
merge1:
  %t9 = phi double [ %t8, %then0 ], [ %t4, %block.entry ]
  store double %t9, double* %l0
  %t10 = extractvalue %PythonBuilder %builder, 0
  %t11 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t10, 0
  %t12 = load double, double* %l0
  %t13 = insertvalue %PythonBuilder %t11, double %t12, 1
  ret %PythonBuilder %t13
}

define i8* @builder_to_string(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca i8*
  %t0 = extractvalue %PythonBuilder %builder, 0
  %t1 = add i64 0, 2
  %t2 = call i8* @malloc(i64 %t1)
  store i8 10, i8* %t2
  %t3 = getelementptr i8, i8* %t2, i64 1
  store i8 0, i8* %t3
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  %t4 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* %t2)
  store i8* %t4, i8** %l0
  %t5 = load i8*, i8** %l0
  %t6 = call i64 @sailfin_runtime_string_length(i8* %t5)
  %t7 = icmp eq i64 %t6, 0
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %t9 = call i8* @malloc(i64 1)
  %t10 = bitcast i8* %t9 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t10
  call void @sailfin_runtime_mark_persistent(i8* %t9)
  ret i8* %t9
merge1:
  %t11 = load i8*, i8** %l0
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 10, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t13)
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  ret i8* %t15
}

define i8* @sanitize_identifier(i8* %name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = call i8* @malloc(i64 1)
  %t1 = bitcast i8* %t0 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t1
  store i8* %t0, i8** %l0
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l1
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t50 = phi i8* [ %t3, %block.entry ], [ %t48, %loop.latch2 ]
  %t51 = phi double [ %t4, %block.entry ], [ %t49, %loop.latch2 ]
  store i8* %t50, i8** %l0
  store double %t51, double* %l1
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l1
  %t6 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t7 = sitofp i64 %t6 to double
  %t8 = fcmp oge double %t5, %t7
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  br i1 %t8, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t11 = load double, double* %l1
  %t12 = call double @llvm.round.f64(double %t11)
  %t13 = fptosi double %t12 to i64
  %t14 = getelementptr i8, i8* %name, i64 %t13
  %t15 = load i8, i8* %t14
  store i8 %t15, i8* %l2
  %t16 = load i8, i8* %l2
  %t17 = add i64 0, 2
  %t18 = call i8* @malloc(i64 %t17)
  store i8 %t16, i8* %t18
  %t19 = getelementptr i8, i8* %t18, i64 1
  store i8 0, i8* %t19
  call void @sailfin_runtime_mark_persistent(i8* %t18)
  %t20 = call i1 @is_identifier_char(i8* %t18)
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load i8, i8* %l2
  br i1 %t20, label %then6, label %else7
then6:
  %t24 = load i8*, i8** %l0
  %t25 = load i8, i8* %l2
  %t26 = add i64 0, 2
  %t27 = call i8* @malloc(i64 %t26)
  store i8 %t25, i8* %t27
  %t28 = getelementptr i8, i8* %t27, i64 1
  store i8 0, i8* %t28
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  %t29 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %t27)
  store i8* %t29, i8** %l0
  %t30 = load i8*, i8** %l0
  br label %merge8
else7:
  %t31 = load i8, i8* %l2
  %t32 = icmp eq i8 %t31, 32
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load i8, i8* %l2
  br i1 %t32, label %then9, label %merge10
then9:
  %t36 = load i8*, i8** %l0
  %t37 = add i64 0, 2
  %t38 = call i8* @malloc(i64 %t37)
  store i8 95, i8* %t38
  %t39 = getelementptr i8, i8* %t38, i64 1
  store i8 0, i8* %t39
  call void @sailfin_runtime_mark_persistent(i8* %t38)
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %t38)
  store i8* %t40, i8** %l0
  %t41 = load i8*, i8** %l0
  br label %merge10
merge10:
  %t42 = phi i8* [ %t41, %then9 ], [ %t33, %else7 ]
  store i8* %t42, i8** %l0
  %t43 = load i8*, i8** %l0
  br label %merge8
merge8:
  %t44 = phi i8* [ %t30, %then6 ], [ %t43, %merge10 ]
  store i8* %t44, i8** %l0
  %t45 = load double, double* %l1
  %t46 = sitofp i64 1 to double
  %t47 = fadd double %t45, %t46
  store double %t47, double* %l1
  br label %loop.latch2
loop.latch2:
  %t48 = load i8*, i8** %l0
  %t49 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l0
  %t55 = call i64 @sailfin_runtime_string_length(i8* %t54)
  %t56 = icmp eq i64 %t55, 0
  %t57 = load i8*, i8** %l0
  %t58 = load double, double* %l1
  br i1 %t56, label %then11, label %merge12
then11:
  %t59 = call i8* @malloc(i64 19)
  %t60 = bitcast i8* %t59 to [19 x i8]*
  store [19 x i8] c"generated_function\00", [19 x i8]* %t60
  call void @sailfin_runtime_mark_persistent(i8* %t59)
  ret i8* %t59
merge12:
  %t61 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  ret i8* %t61
}

define i8* @sanitize_qualified_identifier(i8* %name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca double
  %l4 = alloca i8
  %t0 = call i8* @trim_text(i8* %name)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sanitize_identifier(i8* %t5)
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  ret i8* %t6
merge1:
  %t7 = call i8* @malloc(i64 1)
  %t8 = bitcast i8* %t7 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t8
  store i8* %t7, i8** %l1
  %t9 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t10 = ptrtoint [0 x i8*]* %t9 to i64
  %t11 = icmp eq i64 %t10, 0
  %t12 = select i1 %t11, i64 1, i64 %t10
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to i8**
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t16 = ptrtoint { i8**, i64 }* %t15 to i64
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to { i8**, i64 }*
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* %t18, i32 0, i32 0
  store i8** %t14, i8*** %t19
  %t20 = getelementptr { i8**, i64 }, { i8**, i64 }* %t18, i32 0, i32 1
  store i64 0, i64* %t20
  store { i8**, i64 }* %t18, { i8**, i64 }** %l2
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l3
  %t22 = load i8*, i8** %l0
  %t23 = load i8*, i8** %l1
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t25 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t83 = phi { i8**, i64 }* [ %t24, %merge1 ], [ %t80, %loop.latch4 ]
  %t84 = phi i8* [ %t23, %merge1 ], [ %t81, %loop.latch4 ]
  %t85 = phi double [ %t25, %merge1 ], [ %t82, %loop.latch4 ]
  store { i8**, i64 }* %t83, { i8**, i64 }** %l2
  store i8* %t84, i8** %l1
  store double %t85, double* %l3
  br label %loop.body3
loop.body3:
  %t26 = load double, double* %l3
  %t27 = load i8*, i8** %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %t27)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t26, %t29
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t34 = load double, double* %l3
  br i1 %t30, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l3
  %t37 = call double @llvm.round.f64(double %t36)
  %t38 = fptosi double %t37 to i64
  %t39 = getelementptr i8, i8* %t35, i64 %t38
  %t40 = load i8, i8* %t39
  store i8 %t40, i8* %l4
  %t41 = load i8, i8* %l4
  %t42 = icmp eq i8 %t41, 46
  %t43 = load i8*, i8** %l0
  %t44 = load i8*, i8** %l1
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t46 = load double, double* %l3
  %t47 = load i8, i8* %l4
  br i1 %t42, label %then8, label %else9
then8:
  %t48 = load i8*, i8** %l1
  %t49 = call i64 @sailfin_runtime_string_length(i8* %t48)
  %t50 = icmp sgt i64 %t49, 0
  %t51 = load i8*, i8** %l0
  %t52 = load i8*, i8** %l1
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t54 = load double, double* %l3
  %t55 = load i8, i8* %l4
  br i1 %t50, label %then11, label %merge12
then11:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t57 = load i8*, i8** %l1
  %t58 = call i8* @sanitize_identifier(i8* %t57)
  %t59 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t56, i8* %t58)
  store { i8**, i64 }* %t59, { i8**, i64 }** %l2
  %t60 = call i8* @malloc(i64 1)
  %t61 = bitcast i8* %t60 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t61
  store i8* %t60, i8** %l1
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t63 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t64 = phi { i8**, i64 }* [ %t62, %then11 ], [ %t53, %then8 ]
  %t65 = phi i8* [ %t63, %then11 ], [ %t52, %then8 ]
  store { i8**, i64 }* %t64, { i8**, i64 }** %l2
  store i8* %t65, i8** %l1
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t67 = load i8*, i8** %l1
  br label %merge10
else9:
  %t68 = load i8*, i8** %l1
  %t69 = load i8, i8* %l4
  %t70 = add i64 0, 2
  %t71 = call i8* @malloc(i64 %t70)
  store i8 %t69, i8* %t71
  %t72 = getelementptr i8, i8* %t71, i64 1
  store i8 0, i8* %t72
  call void @sailfin_runtime_mark_persistent(i8* %t71)
  %t73 = call i8* @sailfin_runtime_string_concat(i8* %t68, i8* %t71)
  store i8* %t73, i8** %l1
  %t74 = load i8*, i8** %l1
  br label %merge10
merge10:
  %t75 = phi { i8**, i64 }* [ %t66, %merge12 ], [ %t45, %else9 ]
  %t76 = phi i8* [ %t67, %merge12 ], [ %t74, %else9 ]
  store { i8**, i64 }* %t75, { i8**, i64 }** %l2
  store i8* %t76, i8** %l1
  %t77 = load double, double* %l3
  %t78 = sitofp i64 1 to double
  %t79 = fadd double %t77, %t78
  store double %t79, double* %l3
  br label %loop.latch4
loop.latch4:
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l3
  %t89 = load i8*, i8** %l1
  %t90 = call i64 @sailfin_runtime_string_length(i8* %t89)
  %t91 = icmp sgt i64 %t90, 0
  %t92 = load i8*, i8** %l0
  %t93 = load i8*, i8** %l1
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t95 = load double, double* %l3
  br i1 %t91, label %then13, label %merge14
then13:
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t97 = load i8*, i8** %l1
  %t98 = call i8* @sanitize_identifier(i8* %t97)
  %t99 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t96, i8* %t98)
  store { i8**, i64 }* %t99, { i8**, i64 }** %l2
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t101 = phi { i8**, i64 }* [ %t100, %then13 ], [ %t94, %afterloop5 ]
  store { i8**, i64 }* %t101, { i8**, i64 }** %l2
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t103 = load { i8**, i64 }, { i8**, i64 }* %t102
  %t104 = extractvalue { i8**, i64 } %t103, 1
  %t105 = icmp eq i64 %t104, 0
  %t106 = load i8*, i8** %l0
  %t107 = load i8*, i8** %l1
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t109 = load double, double* %l3
  br i1 %t105, label %then15, label %merge16
then15:
  %t110 = load i8*, i8** %l0
  %t111 = call i8* @sanitize_identifier(i8* %t110)
  call void @sailfin_runtime_mark_persistent(i8* %t111)
  ret i8* %t111
merge16:
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t113 = add i64 0, 2
  %t114 = call i8* @malloc(i64 %t113)
  store i8 46, i8* %t114
  %t115 = getelementptr i8, i8* %t114, i64 1
  store i8 0, i8* %t115
  call void @sailfin_runtime_mark_persistent(i8* %t114)
  %t116 = call i8* @join_with_separator({ i8**, i64 }* %t112, i8* %t114)
  call void @sailfin_runtime_mark_persistent(i8* %t116)
  ret i8* %t116
}

define i1 @is_identifier_char(i8* %ch) {
block.entry:
  %l0 = alloca double
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 95
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call double @char_code(i8* %ch)
  store double %t2, double* %l0
  %t4 = load double, double* %l0
  %t5 = add i64 0, 2
  %t6 = call i8* @malloc(i64 %t5)
  store i8 97, i8* %t6
  %t7 = getelementptr i8, i8* %t6, i64 1
  store i8 0, i8* %t7
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  %t8 = call double @char_code(i8* %t6)
  %t9 = fcmp oge double %t4, %t8
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t9, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t10 = load double, double* %l0
  %t11 = add i64 0, 2
  %t12 = call i8* @malloc(i64 %t11)
  store i8 122, i8* %t12
  %t13 = getelementptr i8, i8* %t12, i64 1
  store i8 0, i8* %t13
  call void @sailfin_runtime_mark_persistent(i8* %t12)
  %t14 = call double @char_code(i8* %t12)
  %t15 = fcmp ole double %t10, %t14
  br label %logical_and_right_end_3

logical_and_right_end_3:
  br label %logical_and_merge_3

logical_and_merge_3:
  %t16 = phi i1 [ false, %logical_and_entry_3 ], [ %t15, %logical_and_right_end_3 ]
  %t17 = load double, double* %l0
  br i1 %t16, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t19 = load double, double* %l0
  %t20 = add i64 0, 2
  %t21 = call i8* @malloc(i64 %t20)
  store i8 65, i8* %t21
  %t22 = getelementptr i8, i8* %t21, i64 1
  store i8 0, i8* %t22
  call void @sailfin_runtime_mark_persistent(i8* %t21)
  %t23 = call double @char_code(i8* %t21)
  %t24 = fcmp oge double %t19, %t23
  br label %logical_and_entry_18

logical_and_entry_18:
  br i1 %t24, label %logical_and_right_18, label %logical_and_merge_18

logical_and_right_18:
  %t25 = load double, double* %l0
  %t26 = add i64 0, 2
  %t27 = call i8* @malloc(i64 %t26)
  store i8 90, i8* %t27
  %t28 = getelementptr i8, i8* %t27, i64 1
  store i8 0, i8* %t28
  call void @sailfin_runtime_mark_persistent(i8* %t27)
  %t29 = call double @char_code(i8* %t27)
  %t30 = fcmp ole double %t25, %t29
  br label %logical_and_right_end_18

logical_and_right_end_18:
  br label %logical_and_merge_18

logical_and_merge_18:
  %t31 = phi i1 [ false, %logical_and_entry_18 ], [ %t30, %logical_and_right_end_18 ]
  %t32 = load double, double* %l0
  br i1 %t31, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t34 = load double, double* %l0
  %t35 = add i64 0, 2
  %t36 = call i8* @malloc(i64 %t35)
  store i8 48, i8* %t36
  %t37 = getelementptr i8, i8* %t36, i64 1
  store i8 0, i8* %t37
  call void @sailfin_runtime_mark_persistent(i8* %t36)
  %t38 = call double @char_code(i8* %t36)
  %t39 = fcmp oge double %t34, %t38
  br label %logical_and_entry_33

logical_and_entry_33:
  br i1 %t39, label %logical_and_right_33, label %logical_and_merge_33

logical_and_right_33:
  %t40 = load double, double* %l0
  %t41 = add i64 0, 2
  %t42 = call i8* @malloc(i64 %t41)
  store i8 57, i8* %t42
  %t43 = getelementptr i8, i8* %t42, i64 1
  store i8 0, i8* %t43
  call void @sailfin_runtime_mark_persistent(i8* %t42)
  %t44 = call double @char_code(i8* %t42)
  %t45 = fcmp ole double %t40, %t44
  br label %logical_and_right_end_33

logical_and_right_end_33:
  br label %logical_and_merge_33

logical_and_merge_33:
  %t46 = phi i1 [ false, %logical_and_entry_33 ], [ %t45, %logical_and_right_end_33 ]
  %t47 = load double, double* %l0
  br i1 %t46, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define i1 @is_whitespace_char(i8* %ch) {
block.entry:
  %t0 = load i8, i8* %ch
  %t1 = icmp eq i8 %t0, 32
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = load i8, i8* %ch
  %t3 = icmp eq i8 %t2, 10
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 13
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t6 = load i8, i8* %ch
  %t7 = icmp eq i8 %t6, 9
  br i1 %t7, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define i8* @trim_text(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t44 = phi double [ %t3, %block.entry ], [ %t43, %loop.latch2 ]
  store double %t44, double* %l0
  br label %loop.body1
loop.body1:
  %t5 = load double, double* %l0
  %t6 = load double, double* %l1
  %t7 = fcmp oge double %t5, %t6
  %t8 = load double, double* %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l0
  %t11 = load double, double* %l0
  %t12 = sitofp i64 1 to double
  %t13 = fadd double %t11, %t12
  %t14 = call double @llvm.round.f64(double %t10)
  %t15 = fptosi double %t14 to i64
  %t16 = call double @llvm.round.f64(double %t13)
  %t17 = fptosi double %t16 to i64
  %t18 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t15, i64 %t17)
  store i8* %t18, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 32
  br label %logical_or_entry_19

logical_or_entry_19:
  br i1 %t22, label %logical_or_merge_19, label %logical_or_right_19

logical_or_right_19:
  %t24 = load i8*, i8** %l2
  %t25 = load i8, i8* %t24
  %t26 = icmp eq i8 %t25, 10
  br label %logical_or_entry_23

logical_or_entry_23:
  br i1 %t26, label %logical_or_merge_23, label %logical_or_right_23

logical_or_right_23:
  %t28 = load i8*, i8** %l2
  %t29 = load i8, i8* %t28
  %t30 = icmp eq i8 %t29, 13
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t30, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t31 = load i8*, i8** %l2
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 9
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t34 = phi i1 [ true, %logical_or_entry_27 ], [ %t33, %logical_or_right_end_27 ]
  br label %logical_or_right_end_23

logical_or_right_end_23:
  br label %logical_or_merge_23

logical_or_merge_23:
  %t35 = phi i1 [ true, %logical_or_entry_23 ], [ %t34, %logical_or_right_end_23 ]
  br label %logical_or_right_end_19

logical_or_right_end_19:
  br label %logical_or_merge_19

logical_or_merge_19:
  %t36 = phi i1 [ true, %logical_or_entry_19 ], [ %t35, %logical_or_right_end_19 ]
  %t37 = load double, double* %l0
  %t38 = load double, double* %l1
  %t39 = load i8*, i8** %l2
  br i1 %t36, label %then6, label %merge7
then6:
  %t40 = load double, double* %l0
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t43 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t45 = load double, double* %l0
  %t46 = load double, double* %l0
  %t47 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t91 = phi double [ %t47, %afterloop3 ], [ %t90, %loop.latch10 ]
  store double %t91, double* %l1
  br label %loop.body9
loop.body9:
  %t48 = load double, double* %l1
  %t49 = load double, double* %l0
  %t50 = fcmp ole double %t48, %t49
  %t51 = load double, double* %l0
  %t52 = load double, double* %l1
  br i1 %t50, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t53 = load double, double* %l1
  %t54 = sitofp i64 1 to double
  %t55 = fsub double %t53, %t54
  store double %t55, double* %l3
  %t56 = load double, double* %l3
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  %t60 = call double @llvm.round.f64(double %t56)
  %t61 = fptosi double %t60 to i64
  %t62 = call double @llvm.round.f64(double %t59)
  %t63 = fptosi double %t62 to i64
  %t64 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t61, i64 %t63)
  store i8* %t64, i8** %l4
  %t66 = load i8*, i8** %l4
  %t67 = load i8, i8* %t66
  %t68 = icmp eq i8 %t67, 32
  br label %logical_or_entry_65

logical_or_entry_65:
  br i1 %t68, label %logical_or_merge_65, label %logical_or_right_65

logical_or_right_65:
  %t70 = load i8*, i8** %l4
  %t71 = load i8, i8* %t70
  %t72 = icmp eq i8 %t71, 10
  br label %logical_or_entry_69

logical_or_entry_69:
  br i1 %t72, label %logical_or_merge_69, label %logical_or_right_69

logical_or_right_69:
  %t74 = load i8*, i8** %l4
  %t75 = load i8, i8* %t74
  %t76 = icmp eq i8 %t75, 13
  br label %logical_or_entry_73

logical_or_entry_73:
  br i1 %t76, label %logical_or_merge_73, label %logical_or_right_73

logical_or_right_73:
  %t77 = load i8*, i8** %l4
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 9
  br label %logical_or_right_end_73

logical_or_right_end_73:
  br label %logical_or_merge_73

logical_or_merge_73:
  %t80 = phi i1 [ true, %logical_or_entry_73 ], [ %t79, %logical_or_right_end_73 ]
  br label %logical_or_right_end_69

logical_or_right_end_69:
  br label %logical_or_merge_69

logical_or_merge_69:
  %t81 = phi i1 [ true, %logical_or_entry_69 ], [ %t80, %logical_or_right_end_69 ]
  br label %logical_or_right_end_65

logical_or_right_end_65:
  br label %logical_or_merge_65

logical_or_merge_65:
  %t82 = phi i1 [ true, %logical_or_entry_65 ], [ %t81, %logical_or_right_end_65 ]
  %t83 = load double, double* %l0
  %t84 = load double, double* %l1
  %t85 = load double, double* %l3
  %t86 = load i8*, i8** %l4
  br i1 %t82, label %then14, label %merge15
then14:
  %t87 = load double, double* %l1
  %t88 = sitofp i64 1 to double
  %t89 = fsub double %t87, %t88
  store double %t89, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t90 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t92 = load double, double* %l1
  %t94 = load double, double* %l0
  %t95 = sitofp i64 0 to double
  %t96 = fcmp oeq double %t94, %t95
  br label %logical_and_entry_93

logical_and_entry_93:
  br i1 %t96, label %logical_and_right_93, label %logical_and_merge_93

logical_and_right_93:
  %t97 = load double, double* %l1
  %t98 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t99 = sitofp i64 %t98 to double
  %t100 = fcmp oeq double %t97, %t99
  br label %logical_and_right_end_93

logical_and_right_end_93:
  br label %logical_and_merge_93

logical_and_merge_93:
  %t101 = phi i1 [ false, %logical_and_entry_93 ], [ %t100, %logical_and_right_end_93 ]
  %t102 = load double, double* %l0
  %t103 = load double, double* %l1
  br i1 %t101, label %then16, label %merge17
then16:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge17:
  %t104 = load double, double* %l0
  %t105 = load double, double* %l1
  %t106 = call double @llvm.round.f64(double %t104)
  %t107 = fptosi double %t106 to i64
  %t108 = call double @llvm.round.f64(double %t105)
  %t109 = fptosi double %t108 to i64
  %t110 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t107, i64 %t109)
  call void @sailfin_runtime_mark_persistent(i8* %t110)
  ret i8* %t110
}

define i1 @starts_with(i8* %value, i8* %prefix) {
block.entry:
  %l0 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t4 = icmp slt i64 %t2, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  br label %loop.header4
loop.header4:
  %t28 = phi double [ %t6, %merge3 ], [ %t27, %loop.latch6 ]
  store double %t28, double* %l0
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l0
  %t8 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  br i1 %t10, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t12 = load double, double* %l0
  %t13 = call double @llvm.round.f64(double %t12)
  %t14 = fptosi double %t13 to i64
  %t15 = getelementptr i8, i8* %value, i64 %t14
  %t16 = load i8, i8* %t15
  %t17 = load double, double* %l0
  %t18 = call double @llvm.round.f64(double %t17)
  %t19 = fptosi double %t18 to i64
  %t20 = getelementptr i8, i8* %prefix, i64 %t19
  %t21 = load i8, i8* %t20
  %t22 = icmp ne i8 %t16, %t21
  %t23 = load double, double* %l0
  br i1 %t22, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch6
loop.latch6:
  %t27 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t29 = load double, double* %l0
  ret i1 1
}

define i1 @ends_with(i8* %value, i8* %suffix) {
block.entry:
  %l0 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t4 = icmp slt i64 %t2, %t3
  br i1 %t4, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l0
  %t6 = load double, double* %l0
  br label %loop.header4
loop.header4:
  %t33 = phi double [ %t6, %merge3 ], [ %t32, %loop.latch6 ]
  store double %t33, double* %l0
  br label %loop.body5
loop.body5:
  %t7 = load double, double* %l0
  %t8 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load double, double* %l0
  br i1 %t10, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t12 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t13 = call i64 @sailfin_runtime_string_length(i8* %suffix)
  %t14 = sub i64 %t12, %t13
  %t15 = load double, double* %l0
  %t16 = sitofp i64 %t14 to double
  %t17 = fadd double %t16, %t15
  %t18 = call double @llvm.round.f64(double %t17)
  %t19 = fptosi double %t18 to i64
  %t20 = getelementptr i8, i8* %value, i64 %t19
  %t21 = load i8, i8* %t20
  %t22 = load double, double* %l0
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = getelementptr i8, i8* %suffix, i64 %t24
  %t26 = load i8, i8* %t25
  %t27 = icmp ne i8 %t21, %t26
  %t28 = load double, double* %l0
  br i1 %t27, label %then10, label %merge11
then10:
  ret i1 0
merge11:
  %t29 = load double, double* %l0
  %t30 = sitofp i64 1 to double
  %t31 = fadd double %t29, %t30
  store double %t31, double* %l0
  br label %loop.latch6
loop.latch6:
  %t32 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t34 = load double, double* %l0
  ret i1 1
}

define i8* @replace_all(i8* %value, i8* %target, i8* %replacement) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i1
  %l3 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge1:
  %t2 = call i8* @malloc(i64 1)
  %t3 = bitcast i8* %t2 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t3
  store i8* %t2, i8** %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t85 = phi i8* [ %t5, %merge1 ], [ %t83, %loop.latch4 ]
  %t86 = phi double [ %t6, %merge1 ], [ %t84, %loop.latch4 ]
  store i8* %t85, i8** %l0
  store double %t86, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t9 = sitofp i64 %t8 to double
  %t10 = fcmp oge double %t7, %t9
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br i1 %t10, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t13 = load double, double* %l1
  %t14 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t15 = sitofp i64 %t14 to double
  %t16 = fadd double %t13, %t15
  %t17 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp ole double %t16, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then8, label %merge9
then8:
  store i1 1, i1* %l2
  %t22 = sitofp i64 0 to double
  store double %t22, double* %l3
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = load i1, i1* %l2
  %t26 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t57 = phi i1 [ %t25, %then8 ], [ %t55, %loop.latch12 ]
  %t58 = phi double [ %t26, %then8 ], [ %t56, %loop.latch12 ]
  store i1 %t57, i1* %l2
  store double %t58, double* %l3
  br label %loop.body11
loop.body11:
  %t27 = load double, double* %l3
  %t28 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t27, %t29
  %t31 = load i8*, i8** %l0
  %t32 = load double, double* %l1
  %t33 = load i1, i1* %l2
  %t34 = load double, double* %l3
  br i1 %t30, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t35 = load double, double* %l1
  %t36 = load double, double* %l3
  %t37 = fadd double %t35, %t36
  %t38 = call double @llvm.round.f64(double %t37)
  %t39 = fptosi double %t38 to i64
  %t40 = getelementptr i8, i8* %value, i64 %t39
  %t41 = load i8, i8* %t40
  %t42 = load double, double* %l3
  %t43 = call double @llvm.round.f64(double %t42)
  %t44 = fptosi double %t43 to i64
  %t45 = getelementptr i8, i8* %target, i64 %t44
  %t46 = load i8, i8* %t45
  %t47 = icmp ne i8 %t41, %t46
  %t48 = load i8*, i8** %l0
  %t49 = load double, double* %l1
  %t50 = load i1, i1* %l2
  %t51 = load double, double* %l3
  br i1 %t47, label %then16, label %merge17
then16:
  store i1 0, i1* %l2
  br label %afterloop13
merge17:
  %t52 = load double, double* %l3
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  store double %t54, double* %l3
  br label %loop.latch12
loop.latch12:
  %t55 = load i1, i1* %l2
  %t56 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t59 = load i1, i1* %l2
  %t60 = load double, double* %l3
  %t61 = load i1, i1* %l2
  %t62 = load i8*, i8** %l0
  %t63 = load double, double* %l1
  %t64 = load i1, i1* %l2
  %t65 = load double, double* %l3
  br i1 %t61, label %then18, label %merge19
then18:
  %t66 = load i8*, i8** %l0
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %replacement)
  store i8* %t67, i8** %l0
  %t68 = load double, double* %l1
  %t69 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t70 = sitofp i64 %t69 to double
  %t71 = fadd double %t68, %t70
  store double %t71, double* %l1
  br label %loop.latch4
merge19:
  %t72 = load i8*, i8** %l0
  %t73 = load double, double* %l1
  br label %merge9
merge9:
  %t74 = phi i8* [ %t72, %merge19 ], [ %t20, %merge7 ]
  %t75 = phi double [ %t73, %merge19 ], [ %t21, %merge7 ]
  store i8* %t74, i8** %l0
  store double %t75, double* %l1
  %t76 = load i8*, i8** %l0
  %t77 = load double, double* %l1
  %t78 = call i8* @char_at(i8* %value, double %t77)
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t76, i8* %t78)
  store i8* %t79, i8** %l0
  %t80 = load double, double* %l1
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l1
  br label %loop.latch4
loop.latch4:
  %t83 = load i8*, i8** %l0
  %t84 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  %t89 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t89)
  ret i8* %t89
}

define i8* @join_with_separator({ i8**, i64 }* %values, i8* %separator) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %t0 = load { i8**, i64 }, { i8**, i64 }* %values
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = icmp eq i64 %t1, 0
  br i1 %t2, label %then0, label %merge1
then0:
  %t3 = call i8* @malloc(i64 1)
  %t4 = bitcast i8* %t3 to [1 x i8]*
  store [1 x i8] c"\00", [1 x i8]* %t4
  call void @sailfin_runtime_mark_persistent(i8* %t3)
  ret i8* %t3
merge1:
  %t5 = load { i8**, i64 }, { i8**, i64 }* %values
  %t6 = extractvalue { i8**, i64 } %t5, 0
  %t7 = extractvalue { i8**, i64 } %t5, 1
  %t8 = icmp uge i64 0, %t7
  ; bounds check: %t8 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t7)
  %t9 = getelementptr i8*, i8** %t6, i64 0
  %t10 = load i8*, i8** %t9
  store i8* %t10, i8** %l0
  %t11 = sitofp i64 1 to double
  store double %t11, double* %l1
  %t12 = load i8*, i8** %l0
  %t13 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t38 = phi i8* [ %t12, %merge1 ], [ %t36, %loop.latch4 ]
  %t39 = phi double [ %t13, %merge1 ], [ %t37, %loop.latch4 ]
  store i8* %t38, i8** %l0
  store double %t39, double* %l1
  br label %loop.body3
loop.body3:
  %t14 = load double, double* %l1
  %t15 = load { i8**, i64 }, { i8**, i64 }* %values
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp oge double %t14, %t17
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t21 = load i8*, i8** %l0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %separator)
  %t23 = load double, double* %l1
  %t24 = call double @llvm.round.f64(double %t23)
  %t25 = fptosi double %t24 to i64
  %t26 = load { i8**, i64 }, { i8**, i64 }* %values
  %t27 = extractvalue { i8**, i64 } %t26, 0
  %t28 = extractvalue { i8**, i64 } %t26, 1
  %t29 = icmp uge i64 %t25, %t28
  ; bounds check: %t29 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t25, i64 %t28)
  %t30 = getelementptr i8*, i8** %t27, i64 %t25
  %t31 = load i8*, i8** %t30
  %t32 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t31)
  store i8* %t32, i8** %l0
  %t33 = load double, double* %l1
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  store double %t35, double* %l1
  br label %loop.latch4
loop.latch4:
  %t36 = load i8*, i8** %l0
  %t37 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t42)
  ret i8* %t42
}

define { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %diagnostics, i8* %function_name, i8* %detail) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %function_name)
  store i8* %t0, i8** %l0
  %t1 = call i8* @malloc(i64 12)
  %t2 = bitcast i8* %t1 to [12 x i8]*
  store [12 x i8] c"[lowering] \00", [12 x i8]* %t2
  store i8* %t1, i8** %l1
  %t3 = load i8*, i8** %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %t3)
  %t5 = icmp eq i64 %t4, 0
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l1
  br i1 %t5, label %then0, label %else1
then0:
  %t8 = load i8*, i8** %l1
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t8, i8* %detail)
  store i8* %t9, i8** %l1
  %t10 = load i8*, i8** %l1
  br label %merge2
else1:
  %t11 = load i8*, i8** %l1
  %t12 = load i8*, i8** %l0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t12)
  %t14 = call i8* @malloc(i64 3)
  %t15 = bitcast i8* %t14 to [3 x i8]*
  store [3 x i8] c": \00", [3 x i8]* %t15
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t14)
  %t17 = call i8* @sailfin_runtime_string_concat(i8* %t16, i8* %detail)
  store i8* %t17, i8** %l1
  %t18 = load i8*, i8** %l1
  br label %merge2
merge2:
  %t19 = phi i8* [ %t10, %then0 ], [ %t18, %else1 ]
  store i8* %t19, i8** %l1
  %t20 = load i8*, i8** %l1
  %t21 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %diagnostics, i8* %t20)
  ret { i8**, i64 }* %t21
}

define { i8**, i64 }* @append_string({ i8**, i64 }* %values, i8* %value) {
block.entry:
  %t0 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t1 = ptrtoint [1 x i8*]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to i8**
  %t6 = getelementptr i8*, i8** %t5, i64 0
  store i8* %value, i8** %t6
  %t7 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t8 = ptrtoint { i8**, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { i8**, i64 }*
  %t11 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 0
  store i8** %t5, i8*** %t11
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %values, { i8**, i64 }* %t10)
  ret { i8**, i64 }* %t13
}

define i8* @char_at(i8* %value, double %index) {
block.entry:
  %t0 = sitofp i64 1 to double
  %t1 = fadd double %index, %t0
  %t2 = call double @llvm.round.f64(double %index)
  %t3 = fptosi double %t2 to i64
  %t4 = call double @llvm.round.f64(double %t1)
  %t5 = fptosi double %t4 to i64
  %t6 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t3, i64 %t5)
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  ret i8* %t6
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}