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

@.str.len14.h165481004 = private unnamed_addr constant [15 x i8] c"import asyncio\00"
@.str.len46.h744586798 = private unnamed_addr constant [47 x i8] c"from runtime import runtime_support as runtime\00"
@.str.len23.h225115061 = private unnamed_addr constant [24 x i8] c"print = runtime.console\00"
@.str.len21.h464873829 = private unnamed_addr constant [22 x i8] c"sleep = runtime.sleep\00"
@.str.len25.h1882901628 = private unnamed_addr constant [26 x i8] c"channel = runtime.channel\00"
@.str.len27.h1230134945 = private unnamed_addr constant [28 x i8] c"parallel = runtime.parallel\00"
@.str.len21.h1480982861 = private unnamed_addr constant [22 x i8] c"spawn = runtime.spawn\00"
@.str.len15.h2008919863 = private unnamed_addr constant [16 x i8] c"fs = runtime.fs\00"
@.str.len21.h949071414 = private unnamed_addr constant [22 x i8] c"serve = runtime.serve\00"
@.str.len19.h190885179 = private unnamed_addr constant [20 x i8] c"http = runtime.http\00"
@.str.len29.h1075519908 = private unnamed_addr constant [30 x i8] c"websocket = runtime.websocket\00"
@.str.len35.h207688710 = private unnamed_addr constant [36 x i8] c"logExecution = runtime.logExecution\00"
@.str.len29.h1468169 = private unnamed_addr constant [30 x i8] c"array_map = runtime.array_map\00"
@.str.len35.h129830246 = private unnamed_addr constant [36 x i8] c"array_filter = runtime.array_filter\00"
@.str.len35.h1076062162 = private unnamed_addr constant [36 x i8] c"array_reduce = runtime.array_reduce\00"
@.str.len29.h29541381 = private unnamed_addr constant [30 x i8] c"globals()['t' + 'rue'] = True\00"
@.str.len31.h1408297199 = private unnamed_addr constant [32 x i8] c"globals()['f' + 'alse'] = False\00"
@.str.len22.h1699428905 = private unnamed_addr constant [23 x i8] c" = runtime.enum_type('\00"
@.str.len2.h193420823 = private unnamed_addr constant [3 x i8] c"')\00"
@.str.len2.h193425971 = private unnamed_addr constant [3 x i8] c", \00"
@.str.len5.h2115689699 = private unnamed_addr constant [6 x i8] c"from \00"
@.str.len8.h1132499314 = private unnamed_addr constant [9 x i8] c" import \00"
@.str.len4.h175713983 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.len11.h1657754115 = private unnamed_addr constant [12 x i8] c"__all__ = [\00"
@.str.len6.h1267738404 = private unnamed_addr constant [7 x i8] c"class \00"
@.str.len17.h215787497 = private unnamed_addr constant [18 x i8] c"def __init__(self\00"
@.str.len19.h1806641125 = private unnamed_addr constant [20 x i8] c"def __repr__(self):\00"
@.str.len28.h1179318158 = private unnamed_addr constant [29 x i8] c"return runtime.struct_repr('\00"
@.str.len4.h182022329 = private unnamed_addr constant [5 x i8] c"', [\00"
@.str.len2.h193479629 = private unnamed_addr constant [3 x i8] c"])\00"
@.str.len28.h583209964 = private unnamed_addr constant [29 x i8] c"runtime.format_interpolated(\00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len6.h1719661028 = private unnamed_addr constant [7 x i8] c".push(\00"
@.str.len8.h645367897 = private unnamed_addr constant [9 x i8] c".append(\00"
@.str.len4.h256486202 = private unnamed_addr constant [5 x i8] c"def \00"
@.str.len2.h193423562 = private unnamed_addr constant [3 x i8] c"):\00"
@.str.len14.h1077944870 = private unnamed_addr constant [15 x i8] c"__match_value_\00"
@.str.len4.h174361445 = private unnamed_addr constant [5 x i8] c" == \00"
@.str.len10.h626550212 = private unnamed_addr constant [11 x i8] c"0123456789\00"
@.str.len11.h2001621394 = private unnamed_addr constant [12 x i8] c"[lowering] \00"

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
  %s19 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1262256381, i32 0, i32 0
  %t20 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t18, i8* %s19)
  store { i8**, i64 }* %t20, { i8**, i64 }** %l0
  %s21 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t22 = insertvalue %LoweredPythonResult undef, i8* %s21, 0
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = insertvalue %LoweredPythonResult %t22, { i8**, i64 }* %t23, 1
  ret %LoweredPythonResult %t24
merge1:
  %t25 = load %NativeArtifact*, %NativeArtifact** %l1
  %t26 = getelementptr %NativeArtifact, %NativeArtifact* %t25, i32 0, i32 2
  %t27 = load i8*, i8** %t26
  %t28 = call %ParseNativeResult @parse_native_artifact(i8* %t27)
  store %ParseNativeResult %t28, %ParseNativeResult* %l2
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t31 = extractvalue %ParseNativeResult %t30, 6
  %t32 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t29, { i8**, i64 }* %t31)
  store { i8**, i64 }* %t32, { i8**, i64 }** %l0
  %t33 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t34 = extractvalue %ParseNativeResult %t33, 0
  %t35 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t36 = extractvalue %ParseNativeResult %t35, 1
  %t37 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t38 = extractvalue %ParseNativeResult %t37, 2
  %t39 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t40 = extractvalue %ParseNativeResult %t39, 4
  %t41 = load %ParseNativeResult, %ParseNativeResult* %l2
  %t42 = extractvalue %ParseNativeResult %t41, 5
  %t43 = call %PythonModuleEmission @emit_python_module({ %NativeFunction*, i64 }* %t34, { %NativeImport*, i64 }* %t36, { %NativeStruct*, i64 }* %t38, { %NativeEnum*, i64 }* %t40, { %NativeBinding*, i64 }* %t42)
  store %PythonModuleEmission %t43, %PythonModuleEmission* %l3
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t46 = extractvalue %PythonModuleEmission %t45, 1
  %t47 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t44, { i8**, i64 }* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l0
  %t48 = load %PythonModuleEmission, %PythonModuleEmission* %l3
  %t49 = extractvalue %PythonModuleEmission %t48, 0
  %t50 = call i8* @builder_to_string(%PythonBuilder %t49)
  store i8* %t50, i8** %l4
  %t51 = load i8*, i8** %l4
  %t52 = insertvalue %LoweredPythonResult undef, i8* %t51, 0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = insertvalue %LoweredPythonResult %t52, { i8**, i64 }* %t53, 1
  ret %LoweredPythonResult %t54
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
  %s14 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h165481004, i32 0, i32 0
  %t15 = call %PythonBuilder @builder_emit(%PythonBuilder %t13, i8* %s14)
  store %PythonBuilder %t15, %PythonBuilder* %l0
  %t16 = load %PythonBuilder, %PythonBuilder* %l0
  %s17 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.len46.h744586798, i32 0, i32 0
  %t18 = call %PythonBuilder @builder_emit(%PythonBuilder %t16, i8* %s17)
  store %PythonBuilder %t18, %PythonBuilder* %l0
  %t19 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t20 = ptrtoint [0 x i8*]* %t19 to i64
  %t21 = icmp eq i64 %t20, 0
  %t22 = select i1 %t21, i64 1, i64 %t20
  %t23 = call i8* @malloc(i64 %t22)
  %t24 = bitcast i8* %t23 to i8**
  %t25 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t26 = ptrtoint { i8**, i64 }* %t25 to i64
  %t27 = call i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to { i8**, i64 }*
  %t29 = getelementptr { i8**, i64 }, { i8**, i64 }* %t28, i32 0, i32 0
  store i8** %t24, i8*** %t29
  %t30 = getelementptr { i8**, i64 }, { i8**, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { i8**, i64 }* %t28, { i8**, i64 }** %l2
  %t31 = load { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports
  %t32 = extractvalue { %NativeImport*, i64 } %t31, 1
  %t33 = icmp sgt i64 %t32, 0
  %t34 = load %PythonBuilder, %PythonBuilder* %l0
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t33, label %then0, label %merge1
then0:
  %t37 = load %PythonBuilder, %PythonBuilder* %l0
  %t38 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t37)
  store %PythonBuilder %t38, %PythonBuilder* %l0
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %t40 = call %PythonImportEmission @emit_python_imports(%PythonBuilder %t39, { %NativeImport*, i64 }* %imports)
  store %PythonImportEmission %t40, %PythonImportEmission* %l3
  %t41 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t42 = extractvalue %PythonImportEmission %t41, 0
  store %PythonBuilder %t42, %PythonBuilder* %l0
  %t43 = load %PythonImportEmission, %PythonImportEmission* %l3
  %t44 = extractvalue %PythonImportEmission %t43, 1
  store { i8**, i64 }* %t44, { i8**, i64 }** %l2
  %t45 = load %PythonBuilder, %PythonBuilder* %l0
  %t46 = load %PythonBuilder, %PythonBuilder* %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge1
merge1:
  %t48 = phi %PythonBuilder [ %t45, %then0 ], [ %t34, %block.entry ]
  %t49 = phi %PythonBuilder [ %t46, %then0 ], [ %t34, %block.entry ]
  %t50 = phi { i8**, i64 }* [ %t47, %then0 ], [ %t36, %block.entry ]
  store %PythonBuilder %t48, %PythonBuilder* %l0
  store %PythonBuilder %t49, %PythonBuilder* %l0
  store { i8**, i64 }* %t50, { i8**, i64 }** %l2
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t51)
  store %PythonBuilder %t52, %PythonBuilder* %l0
  %t53 = load %PythonBuilder, %PythonBuilder* %l0
  %t54 = call %PythonBuilder @emit_runtime_aliases(%PythonBuilder %t53)
  store %PythonBuilder %t54, %PythonBuilder* %l0
  %t55 = load { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings
  %t56 = extractvalue { %NativeBinding*, i64 } %t55, 1
  %t57 = icmp sgt i64 %t56, 0
  %t58 = load %PythonBuilder, %PythonBuilder* %l0
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t57, label %then2, label %merge3
then2:
  %t61 = load %PythonBuilder, %PythonBuilder* %l0
  %t62 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t61)
  store %PythonBuilder %t62, %PythonBuilder* %l0
  %t63 = load %PythonBuilder, %PythonBuilder* %l0
  %t64 = call %PythonBuilder @emit_top_level_bindings(%PythonBuilder %t63, { %NativeBinding*, i64 }* %bindings)
  store %PythonBuilder %t64, %PythonBuilder* %l0
  %t65 = load %PythonBuilder, %PythonBuilder* %l0
  %t66 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge3
merge3:
  %t67 = phi %PythonBuilder [ %t65, %then2 ], [ %t58, %merge1 ]
  %t68 = phi %PythonBuilder [ %t66, %then2 ], [ %t58, %merge1 ]
  store %PythonBuilder %t67, %PythonBuilder* %l0
  store %PythonBuilder %t68, %PythonBuilder* %l0
  %t69 = load { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums
  %t70 = extractvalue { %NativeEnum*, i64 } %t69, 1
  %t71 = icmp sgt i64 %t70, 0
  %t72 = load %PythonBuilder, %PythonBuilder* %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t71, label %then4, label %merge5
then4:
  %t75 = load %PythonBuilder, %PythonBuilder* %l0
  %t76 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t75)
  store %PythonBuilder %t76, %PythonBuilder* %l0
  %t77 = load %PythonBuilder, %PythonBuilder* %l0
  %t78 = call %PythonBuilder @emit_enum_definitions(%PythonBuilder %t77, { %NativeEnum*, i64 }* %enums)
  store %PythonBuilder %t78, %PythonBuilder* %l0
  %t79 = load %PythonBuilder, %PythonBuilder* %l0
  %t80 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge5
merge5:
  %t81 = phi %PythonBuilder [ %t79, %then4 ], [ %t72, %merge3 ]
  %t82 = phi %PythonBuilder [ %t80, %then4 ], [ %t72, %merge3 ]
  store %PythonBuilder %t81, %PythonBuilder* %l0
  store %PythonBuilder %t82, %PythonBuilder* %l0
  %t83 = load { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs
  %t84 = extractvalue { %NativeStruct*, i64 } %t83, 1
  %t85 = icmp sgt i64 %t84, 0
  %t86 = load %PythonBuilder, %PythonBuilder* %l0
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t85, label %then6, label %merge7
then6:
  %t89 = load %PythonBuilder, %PythonBuilder* %l0
  %t90 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t89)
  store %PythonBuilder %t90, %PythonBuilder* %l0
  %t91 = load %PythonBuilder, %PythonBuilder* %l0
  %t92 = call %PythonStructEmission @emit_struct_definitions(%PythonBuilder %t91, { %NativeStruct*, i64 }* %structs)
  store %PythonStructEmission %t92, %PythonStructEmission* %l4
  %t93 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t94 = extractvalue %PythonStructEmission %t93, 0
  store %PythonBuilder %t94, %PythonBuilder* %l0
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t96 = load %PythonStructEmission, %PythonStructEmission* %l4
  %t97 = extractvalue %PythonStructEmission %t96, 1
  %t98 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t95, { i8**, i64 }* %t97)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l1
  %t99 = load %PythonBuilder, %PythonBuilder* %l0
  %t100 = load %PythonBuilder, %PythonBuilder* %l0
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge7
merge7:
  %t102 = phi %PythonBuilder [ %t99, %then6 ], [ %t86, %merge5 ]
  %t103 = phi %PythonBuilder [ %t100, %then6 ], [ %t86, %merge5 ]
  %t104 = phi { i8**, i64 }* [ %t101, %then6 ], [ %t87, %merge5 ]
  store %PythonBuilder %t102, %PythonBuilder* %l0
  store %PythonBuilder %t103, %PythonBuilder* %l0
  store { i8**, i64 }* %t104, { i8**, i64 }** %l1
  %t105 = load %PythonBuilder, %PythonBuilder* %l0
  %t106 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t105)
  store %PythonBuilder %t106, %PythonBuilder* %l0
  %t107 = sitofp i64 0 to double
  store double %t107, double* %l5
  %t108 = load %PythonBuilder, %PythonBuilder* %l0
  %t109 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t111 = load double, double* %l5
  br label %loop.header8
loop.header8:
  %t160 = phi %PythonBuilder [ %t108, %merge7 ], [ %t157, %loop.latch10 ]
  %t161 = phi { i8**, i64 }* [ %t109, %merge7 ], [ %t158, %loop.latch10 ]
  %t162 = phi double [ %t111, %merge7 ], [ %t159, %loop.latch10 ]
  store %PythonBuilder %t160, %PythonBuilder* %l0
  store { i8**, i64 }* %t161, { i8**, i64 }** %l1
  store double %t162, double* %l5
  br label %loop.body9
loop.body9:
  %t112 = load double, double* %l5
  %t113 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t114 = extractvalue { %NativeFunction*, i64 } %t113, 1
  %t115 = sitofp i64 %t114 to double
  %t116 = fcmp oge double %t112, %t115
  %t117 = load %PythonBuilder, %PythonBuilder* %l0
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t120 = load double, double* %l5
  br i1 %t116, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t121 = load %PythonBuilder, %PythonBuilder* %l0
  %t122 = load double, double* %l5
  %t123 = call double @llvm.round.f64(double %t122)
  %t124 = fptosi double %t123 to i64
  %t125 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t126 = extractvalue { %NativeFunction*, i64 } %t125, 0
  %t127 = extractvalue { %NativeFunction*, i64 } %t125, 1
  %t128 = icmp uge i64 %t124, %t127
  ; bounds check: %t128 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t124, i64 %t127)
  %t129 = getelementptr %NativeFunction, %NativeFunction* %t126, i64 %t124
  %t130 = load %NativeFunction, %NativeFunction* %t129
  %t131 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t121, %NativeFunction %t130)
  store %PythonFunctionEmission %t131, %PythonFunctionEmission* %l6
  %t132 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t133 = extractvalue %PythonFunctionEmission %t132, 0
  store %PythonBuilder %t133, %PythonBuilder* %l0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t135 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  %t136 = extractvalue %PythonFunctionEmission %t135, 1
  %t137 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t134, { i8**, i64 }* %t136)
  store { i8**, i64 }* %t137, { i8**, i64 }** %l1
  %t138 = load double, double* %l5
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  %t141 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions
  %t142 = extractvalue { %NativeFunction*, i64 } %t141, 1
  %t143 = sitofp i64 %t142 to double
  %t144 = fcmp olt double %t140, %t143
  %t145 = load %PythonBuilder, %PythonBuilder* %l0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t148 = load double, double* %l5
  %t149 = load %PythonFunctionEmission, %PythonFunctionEmission* %l6
  br i1 %t144, label %then14, label %merge15
then14:
  %t150 = load %PythonBuilder, %PythonBuilder* %l0
  %t151 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t150)
  store %PythonBuilder %t151, %PythonBuilder* %l0
  %t152 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
merge15:
  %t153 = phi %PythonBuilder [ %t152, %then14 ], [ %t145, %merge13 ]
  store %PythonBuilder %t153, %PythonBuilder* %l0
  %t154 = load double, double* %l5
  %t155 = sitofp i64 1 to double
  %t156 = fadd double %t154, %t155
  store double %t156, double* %l5
  br label %loop.latch10
loop.latch10:
  %t157 = load %PythonBuilder, %PythonBuilder* %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load double, double* %l5
  br label %loop.header8
afterloop11:
  %t163 = load %PythonBuilder, %PythonBuilder* %l0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t165 = load double, double* %l5
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t167 = load { i8**, i64 }, { i8**, i64 }* %t166
  %t168 = extractvalue { i8**, i64 } %t167, 1
  %t169 = icmp sgt i64 %t168, 0
  %t170 = load %PythonBuilder, %PythonBuilder* %l0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t173 = load double, double* %l5
  br i1 %t169, label %then16, label %merge17
then16:
  %t174 = load %PythonBuilder, %PythonBuilder* %l0
  %t175 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t174)
  store %PythonBuilder %t175, %PythonBuilder* %l0
  %t176 = load %PythonBuilder, %PythonBuilder* %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t178 = call %PythonBuilder @emit_export_list(%PythonBuilder %t176, { i8**, i64 }* %t177)
  store %PythonBuilder %t178, %PythonBuilder* %l0
  %t179 = load %PythonBuilder, %PythonBuilder* %l0
  %t180 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge17
merge17:
  %t181 = phi %PythonBuilder [ %t179, %then16 ], [ %t170, %afterloop11 ]
  %t182 = phi %PythonBuilder [ %t180, %then16 ], [ %t170, %afterloop11 ]
  store %PythonBuilder %t181, %PythonBuilder* %l0
  store %PythonBuilder %t182, %PythonBuilder* %l0
  %t183 = load %PythonBuilder, %PythonBuilder* %l0
  %t184 = insertvalue %PythonModuleEmission undef, %PythonBuilder %t183, 0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t186 = insertvalue %PythonModuleEmission %t184, { i8**, i64 }* %t185, 1
  ret %PythonModuleEmission %t186
}

define %PythonBuilder @emit_runtime_aliases(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca %PythonBuilder
  store %PythonBuilder %builder, %PythonBuilder* %l0
  %t0 = load %PythonBuilder, %PythonBuilder* %l0
  %s1 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h225115061, i32 0, i32 0
  %t2 = call %PythonBuilder @builder_emit(%PythonBuilder %t0, i8* %s1)
  store %PythonBuilder %t2, %PythonBuilder* %l0
  %t3 = load %PythonBuilder, %PythonBuilder* %l0
  %s4 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h464873829, i32 0, i32 0
  %t5 = call %PythonBuilder @builder_emit(%PythonBuilder %t3, i8* %s4)
  store %PythonBuilder %t5, %PythonBuilder* %l0
  %t6 = load %PythonBuilder, %PythonBuilder* %l0
  %s7 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h1882901628, i32 0, i32 0
  %t8 = call %PythonBuilder @builder_emit(%PythonBuilder %t6, i8* %s7)
  store %PythonBuilder %t8, %PythonBuilder* %l0
  %t9 = load %PythonBuilder, %PythonBuilder* %l0
  %s10 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.len27.h1230134945, i32 0, i32 0
  %t11 = call %PythonBuilder @builder_emit(%PythonBuilder %t9, i8* %s10)
  store %PythonBuilder %t11, %PythonBuilder* %l0
  %t12 = load %PythonBuilder, %PythonBuilder* %l0
  %s13 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1480982861, i32 0, i32 0
  %t14 = call %PythonBuilder @builder_emit(%PythonBuilder %t12, i8* %s13)
  store %PythonBuilder %t14, %PythonBuilder* %l0
  %t15 = load %PythonBuilder, %PythonBuilder* %l0
  %s16 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h2008919863, i32 0, i32 0
  %t17 = call %PythonBuilder @builder_emit(%PythonBuilder %t15, i8* %s16)
  store %PythonBuilder %t17, %PythonBuilder* %l0
  %t18 = load %PythonBuilder, %PythonBuilder* %l0
  %s19 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h949071414, i32 0, i32 0
  %t20 = call %PythonBuilder @builder_emit(%PythonBuilder %t18, i8* %s19)
  store %PythonBuilder %t20, %PythonBuilder* %l0
  %t21 = load %PythonBuilder, %PythonBuilder* %l0
  %s22 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h190885179, i32 0, i32 0
  %t23 = call %PythonBuilder @builder_emit(%PythonBuilder %t21, i8* %s22)
  store %PythonBuilder %t23, %PythonBuilder* %l0
  %t24 = load %PythonBuilder, %PythonBuilder* %l0
  %s25 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1075519908, i32 0, i32 0
  %t26 = call %PythonBuilder @builder_emit(%PythonBuilder %t24, i8* %s25)
  store %PythonBuilder %t26, %PythonBuilder* %l0
  %t27 = load %PythonBuilder, %PythonBuilder* %l0
  %s28 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h207688710, i32 0, i32 0
  %t29 = call %PythonBuilder @builder_emit(%PythonBuilder %t27, i8* %s28)
  store %PythonBuilder %t29, %PythonBuilder* %l0
  %t30 = load %PythonBuilder, %PythonBuilder* %l0
  %s31 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1468169, i32 0, i32 0
  %t32 = call %PythonBuilder @builder_emit(%PythonBuilder %t30, i8* %s31)
  store %PythonBuilder %t32, %PythonBuilder* %l0
  %t33 = load %PythonBuilder, %PythonBuilder* %l0
  %s34 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h129830246, i32 0, i32 0
  %t35 = call %PythonBuilder @builder_emit(%PythonBuilder %t33, i8* %s34)
  store %PythonBuilder %t35, %PythonBuilder* %l0
  %t36 = load %PythonBuilder, %PythonBuilder* %l0
  %s37 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h1076062162, i32 0, i32 0
  %t38 = call %PythonBuilder @builder_emit(%PythonBuilder %t36, i8* %s37)
  store %PythonBuilder %t38, %PythonBuilder* %l0
  %t39 = load %PythonBuilder, %PythonBuilder* %l0
  %s40 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h29541381, i32 0, i32 0
  %t41 = call %PythonBuilder @builder_emit(%PythonBuilder %t39, i8* %s40)
  store %PythonBuilder %t41, %PythonBuilder* %l0
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  %s43 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1408297199, i32 0, i32 0
  %t44 = call %PythonBuilder @builder_emit(%PythonBuilder %t42, i8* %s43)
  store %PythonBuilder %t44, %PythonBuilder* %l0
  %t45 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t45
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
  %t53 = phi %PythonBuilder [ %t1, %block.entry ], [ %t51, %loop.latch2 ]
  %t54 = phi double [ %t2, %block.entry ], [ %t52, %loop.latch2 ]
  store %PythonBuilder %t53, %PythonBuilder* %l0
  store double %t54, double* %l1
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
  %s23 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t24 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %s23)
  store i8* %t24, i8** %l4
  %t25 = load %NativeBinding, %NativeBinding* %l2
  %t26 = extractvalue %NativeBinding %t25, 3
  %t27 = icmp ne i8* %t26, null
  %t28 = load %PythonBuilder, %PythonBuilder* %l0
  %t29 = load double, double* %l1
  %t30 = load %NativeBinding, %NativeBinding* %l2
  %t31 = load i8*, i8** %l3
  %t32 = load i8*, i8** %l4
  br i1 %t27, label %then6, label %else7
then6:
  %t33 = load %NativeBinding, %NativeBinding* %l2
  %t34 = extractvalue %NativeBinding %t33, 3
  store i8* %t34, i8** %l5
  %t35 = load i8*, i8** %l4
  %t36 = load i8*, i8** %l5
  %t37 = call i8* @lower_expression(i8* %t36)
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t37)
  store i8* %t38, i8** %l4
  %t39 = load i8*, i8** %l4
  br label %merge8
else7:
  %t40 = load i8*, i8** %l4
  %s41 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %s41)
  store i8* %t42, i8** %l4
  %t43 = load i8*, i8** %l4
  br label %merge8
merge8:
  %t44 = phi i8* [ %t39, %then6 ], [ %t43, %else7 ]
  store i8* %t44, i8** %l4
  %t45 = load %PythonBuilder, %PythonBuilder* %l0
  %t46 = load i8*, i8** %l4
  %t47 = call %PythonBuilder @builder_emit(%PythonBuilder %t45, i8* %t46)
  store %PythonBuilder %t47, %PythonBuilder* %l0
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  br label %loop.latch2
loop.latch2:
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t55 = load %PythonBuilder, %PythonBuilder* %l0
  %t56 = load double, double* %l1
  %t57 = load %PythonBuilder, %PythonBuilder* %l0
  ret %PythonBuilder %t57
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
  %t84 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t81, %loop.latch2 ]
  %t85 = phi double [ %t15, %block.entry ], [ %t82, %loop.latch2 ]
  %t86 = phi %PythonBuilder [ %t13, %block.entry ], [ %t83, %loop.latch2 ]
  store { i8**, i64 }* %t84, { i8**, i64 }** %l1
  store double %t85, double* %l2
  store %PythonBuilder %t86, %PythonBuilder* %l0
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
  %s35 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t36 = call i1 @strings_equal(i8* %t34, i8* %s35)
  %t37 = load %PythonBuilder, %PythonBuilder* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load double, double* %l2
  %t40 = load %NativeImport, %NativeImport* %l3
  br i1 %t36, label %then6, label %merge7
then6:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t42 = load %NativeImport, %NativeImport* %l3
  %t43 = extractvalue %NativeImport %t42, 2
  %t44 = call { i8**, i64 }* @collect_export_names({ i8**, i64 }* %t41, { %NativeImportSpecifier*, i64 }* %t43)
  store { i8**, i64 }* %t44, { i8**, i64 }** %l1
  %t45 = load %NativeImport, %NativeImport* %l3
  %t46 = extractvalue %NativeImport %t45, 1
  %t47 = call i8* @trim_text(i8* %t46)
  store i8* %t47, i8** %l4
  %t48 = load i8*, i8** %l4
  %t49 = call i64 @sailfin_runtime_string_length(i8* %t48)
  %t50 = icmp eq i64 %t49, 0
  %t51 = load %PythonBuilder, %PythonBuilder* %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load double, double* %l2
  %t54 = load %NativeImport, %NativeImport* %l3
  %t55 = load i8*, i8** %l4
  br i1 %t50, label %then8, label %merge9
then8:
  %t56 = load double, double* %l2
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l2
  br label %loop.latch2
merge9:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = load double, double* %l2
  br label %merge7
merge7:
  %t61 = phi { i8**, i64 }* [ %t59, %merge9 ], [ %t38, %merge5 ]
  %t62 = phi double [ %t60, %merge9 ], [ %t39, %merge5 ]
  store { i8**, i64 }* %t61, { i8**, i64 }** %l1
  store double %t62, double* %l2
  %t63 = load %NativeImport, %NativeImport* %l3
  %t64 = call i8* @render_python_import(%NativeImport %t63)
  store i8* %t64, i8** %l5
  %t65 = load i8*, i8** %l5
  %t66 = call i64 @sailfin_runtime_string_length(i8* %t65)
  %t67 = icmp sgt i64 %t66, 0
  %t68 = load %PythonBuilder, %PythonBuilder* %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t70 = load double, double* %l2
  %t71 = load %NativeImport, %NativeImport* %l3
  %t72 = load i8*, i8** %l5
  br i1 %t67, label %then10, label %merge11
then10:
  %t73 = load %PythonBuilder, %PythonBuilder* %l0
  %t74 = load i8*, i8** %l5
  %t75 = call %PythonBuilder @builder_emit(%PythonBuilder %t73, i8* %t74)
  store %PythonBuilder %t75, %PythonBuilder* %l0
  %t76 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge11
merge11:
  %t77 = phi %PythonBuilder [ %t76, %then10 ], [ %t68, %merge7 ]
  store %PythonBuilder %t77, %PythonBuilder* %l0
  %t78 = load double, double* %l2
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l2
  br label %loop.latch2
loop.latch2:
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load double, double* %l2
  %t83 = load %PythonBuilder, %PythonBuilder* %l0
  br label %loop.header0
afterloop3:
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = load double, double* %l2
  %t89 = load %PythonBuilder, %PythonBuilder* %l0
  %t90 = load %PythonBuilder, %PythonBuilder* %l0
  %t91 = insertvalue %PythonImportEmission undef, %PythonBuilder %t90, 0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t93 = insertvalue %PythonImportEmission %t91, { i8**, i64 }* %t92, 1
  ret %PythonImportEmission %t93
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
  %s3 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h1699428905, i32 0, i32 0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %t2, i8* %s3)
  %t5 = load i8*, i8** %l0
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t5)
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193420823, i32 0, i32 0
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t6, i8* %s7)
  %t9 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t8)
  store %PythonBuilder %t9, %PythonBuilder* %l1
  %t10 = sitofp i64 0 to double
  store double %t10, double* %l2
  %t11 = load i8*, i8** %l0
  %t12 = load %PythonBuilder, %PythonBuilder* %l1
  %t13 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t61 = phi %PythonBuilder [ %t12, %block.entry ], [ %t59, %loop.latch2 ]
  %t62 = phi double [ %t13, %block.entry ], [ %t60, %loop.latch2 ]
  store %PythonBuilder %t61, %PythonBuilder* %l1
  store double %t62, double* %l2
  br label %loop.body1
loop.body1:
  %t14 = load double, double* %l2
  %t15 = extractvalue %NativeEnum %definition, 1
  %t16 = load { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t15
  %t17 = extractvalue { %NativeEnumVariant*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t14, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load %PythonBuilder, %PythonBuilder* %l1
  %t22 = load double, double* %l2
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t23 = extractvalue %NativeEnum %definition, 1
  %t24 = load double, double* %l2
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = load { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t23
  %t28 = extractvalue { %NativeEnumVariant*, i64 } %t27, 0
  %t29 = extractvalue { %NativeEnumVariant*, i64 } %t27, 1
  %t30 = icmp uge i64 %t26, %t29
  ; bounds check: %t30 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t26, i64 %t29)
  %t31 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t28, i64 %t26
  %t32 = load %NativeEnumVariant, %NativeEnumVariant* %t31
  store %NativeEnumVariant %t32, %NativeEnumVariant* %l3
  %t33 = load %NativeEnumVariant, %NativeEnumVariant* %l3
  %t34 = extractvalue %NativeEnumVariant %t33, 0
  %t35 = call i8* @sanitize_identifier(i8* %t34)
  store i8* %t35, i8** %l4
  %t36 = load i8*, i8** %l0
  %s37 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h568140000, i32 0, i32 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %s37)
  %t39 = load i8*, i8** %l0
  %t40 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t39)
  %s41 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t40, i8* %s41)
  %t43 = load i8*, i8** %l4
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t43)
  %s45 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %s45)
  %t47 = load %NativeEnumVariant, %NativeEnumVariant* %l3
  %t48 = extractvalue %NativeEnumVariant %t47, 1
  %t49 = call i8* @render_enum_variant_fields({ %NativeEnumVariantField*, i64 }* %t48)
  %t50 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t49)
  %s51 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t50, i8* %s51)
  store i8* %t52, i8** %l5
  %t53 = load %PythonBuilder, %PythonBuilder* %l1
  %t54 = load i8*, i8** %l5
  %t55 = call %PythonBuilder @builder_emit(%PythonBuilder %t53, i8* %t54)
  store %PythonBuilder %t55, %PythonBuilder* %l1
  %t56 = load double, double* %l2
  %t57 = sitofp i64 1 to double
  %t58 = fadd double %t56, %t57
  store double %t58, double* %l2
  br label %loop.latch2
loop.latch2:
  %t59 = load %PythonBuilder, %PythonBuilder* %l1
  %t60 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t63 = load %PythonBuilder, %PythonBuilder* %l1
  %t64 = load double, double* %l2
  %t65 = load %PythonBuilder, %PythonBuilder* %l1
  ret %PythonBuilder %t65
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s3)
  ret i8* %s3
merge1:
  %t4 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t5 = ptrtoint [0 x i8*]* %t4 to i64
  %t6 = icmp eq i64 %t5, 0
  %t7 = select i1 %t6, i64 1, i64 %t5
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to i8**
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t9, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 0, i64* %t15
  store { i8**, i64 }* %t13, { i8**, i64 }** %l0
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l1
  %t17 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t18 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t52 = phi { i8**, i64 }* [ %t17, %merge1 ], [ %t50, %loop.latch4 ]
  %t53 = phi double [ %t18, %merge1 ], [ %t51, %loop.latch4 ]
  store { i8**, i64 }* %t52, { i8**, i64 }** %l0
  store double %t53, double* %l1
  br label %loop.body3
loop.body3:
  %t19 = load double, double* %l1
  %t20 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t21 = extractvalue { %NativeEnumVariantField*, i64 } %t20, 1
  %t22 = sitofp i64 %t21 to double
  %t23 = fcmp oge double %t19, %t22
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load double, double* %l1
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = load { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields
  %t31 = extractvalue { %NativeEnumVariantField*, i64 } %t30, 0
  %t32 = extractvalue { %NativeEnumVariantField*, i64 } %t30, 1
  %t33 = icmp uge i64 %t29, %t32
  ; bounds check: %t33 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t29, i64 %t32)
  %t34 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t31, i64 %t29
  %t35 = load %NativeEnumVariantField, %NativeEnumVariantField* %t34
  %t36 = extractvalue %NativeEnumVariantField %t35, 0
  %t37 = call i8* @sanitize_identifier(i8* %t36)
  %t38 = add i64 0, 2
  %t39 = call i8* @malloc(i64 %t38)
  store i8 39, i8* %t39
  %t40 = getelementptr i8, i8* %t39, i64 1
  store i8 0, i8* %t40
  call void @sailfin_runtime_mark_persistent(i8* %t39)
  %t41 = call i8* @sailfin_runtime_string_concat(i8* %t39, i8* %t37)
  %t42 = add i64 0, 2
  %t43 = call i8* @malloc(i64 %t42)
  store i8 39, i8* %t43
  %t44 = getelementptr i8, i8* %t43, i64 1
  store i8 0, i8* %t44
  call void @sailfin_runtime_mark_persistent(i8* %t43)
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t43)
  %t46 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t45)
  store { i8**, i64 }* %t46, { i8**, i64 }** %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch4
loop.latch4:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t51 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s57 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t58 = call i8* @join_with_separator({ i8**, i64 }* %t56, i8* %s57)
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  ret i8* %t58
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
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s6)
  ret i8* %s6
merge1:
  %t7 = extractvalue %NativeImport %entry, 2
  %t8 = load { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t7
  %t9 = extractvalue { %NativeImportSpecifier*, i64 } %t8, 1
  %t10 = icmp eq i64 %t9, 0
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then2, label %merge3
then2:
  %s12 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h919609845, i32 0, i32 0
  %t13 = load i8*, i8** %l0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %s12, i8* %t13)
  call void @sailfin_runtime_mark_persistent(i8* %t14)
  ret i8* %t14
merge3:
  %t15 = extractvalue %NativeImport %entry, 2
  %t16 = call i8* @render_python_specifiers({ %NativeImportSpecifier*, i64 }* %t15)
  store i8* %t16, i8** %l1
  %s17 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2115689699, i32 0, i32 0
  %t18 = load i8*, i8** %l0
  %t19 = call i8* @sailfin_runtime_string_concat(i8* %s17, i8* %t18)
  %s20 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1132499314, i32 0, i32 0
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t19, i8* %s20)
  %t22 = load i8*, i8** %l1
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t22)
  call void @sailfin_runtime_mark_persistent(i8* %t23)
  ret i8* %t23
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
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t45 = call i8* @join_with_separator({ i8**, i64 }* %t43, i8* %s44)
  call void @sailfin_runtime_mark_persistent(i8* %t45)
  ret i8* %t45
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
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175713983, i32 0, i32 0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %s12)
  %t14 = extractvalue %NativeImportSpecifier %specifier, 1
  %t15 = call i8* @sanitize_identifier(i8* %t14)
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %t15)
  call void @sailfin_runtime_mark_persistent(i8* %t16)
  ret i8* %t16
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
  %s7 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2085806463, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  %t10 = load i8*, i8** %l0
  %t11 = add i64 0, 2
  %t12 = call i8* @malloc(i64 %t11)
  store i8 47, i8* %t12
  %t13 = getelementptr i8, i8* %t12, i64 1
  store i8 0, i8* %t13
  call void @sailfin_runtime_mark_persistent(i8* %t12)
  %t14 = add i64 0, 2
  %t15 = call i8* @malloc(i64 %t14)
  store i8 46, i8* %t15
  %t16 = getelementptr i8, i8* %t15, i64 1
  store i8 0, i8* %t16
  call void @sailfin_runtime_mark_persistent(i8* %t15)
  %t17 = call i8* @replace_all(i8* %t10, i8* %t12, i8* %t15)
  store i8* %t17, i8** %l1
  %s18 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1309566598, i32 0, i32 0
  %t19 = load i8*, i8** %l1
  %t20 = call i8* @sailfin_runtime_string_concat(i8* %s18, i8* %t19)
  call void @sailfin_runtime_mark_persistent(i8* %t20)
  ret i8* %t20
merge3:
  %t21 = load i8*, i8** %l0
  %s22 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428644, i32 0, i32 0
  %t23 = call i1 @starts_with(i8* %t21, i8* %s22)
  %t24 = load i8*, i8** %l0
  br i1 %t23, label %then4, label %merge5
then4:
  %t25 = load i8*, i8** %l0
  %t26 = load i8*, i8** %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = call i8* @sailfin_runtime_substring(i8* %t25, i64 2, i64 %t27)
  store i8* %t28, i8** %l2
  %t29 = load i8*, i8** %l2
  %t30 = add i64 0, 2
  %t31 = call i8* @malloc(i64 %t30)
  store i8 47, i8* %t31
  %t32 = getelementptr i8, i8* %t31, i64 1
  store i8 0, i8* %t32
  call void @sailfin_runtime_mark_persistent(i8* %t31)
  %t33 = add i64 0, 2
  %t34 = call i8* @malloc(i64 %t33)
  store i8 46, i8* %t34
  %t35 = getelementptr i8, i8* %t34, i64 1
  store i8 0, i8* %t35
  call void @sailfin_runtime_mark_persistent(i8* %t34)
  %t36 = call i8* @replace_all(i8* %t29, i8* %t31, i8* %t34)
  store i8* %t36, i8** %l2
  %s37 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1309566598, i32 0, i32 0
  %t38 = load i8*, i8** %l2
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %s37, i8* %t38)
  call void @sailfin_runtime_mark_persistent(i8* %t39)
  ret i8* %t39
merge5:
  %t40 = load i8*, i8** %l0
  %t41 = add i64 0, 2
  %t42 = call i8* @malloc(i64 %t41)
  store i8 47, i8* %t42
  %t43 = getelementptr i8, i8* %t42, i64 1
  store i8 0, i8* %t43
  call void @sailfin_runtime_mark_persistent(i8* %t42)
  %t44 = add i64 0, 2
  %t45 = call i8* @malloc(i64 %t44)
  store i8 46, i8* %t45
  %t46 = getelementptr i8, i8* %t45, i64 1
  store i8 0, i8* %t46
  call void @sailfin_runtime_mark_persistent(i8* %t45)
  %t47 = call i8* @replace_all(i8* %t40, i8* %t42, i8* %t45)
  call void @sailfin_runtime_mark_persistent(i8* %t47)
  ret i8* %t47
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
  %s150 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1657754115, i32 0, i32 0
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s152 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t153 = call i8* @join_with_separator({ i8**, i64 }* %t151, i8* %s152)
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %s150, i8* %t153)
  %t155 = add i64 0, 2
  %t156 = call i8* @malloc(i64 %t155)
  store i8 93, i8* %t156
  %t157 = getelementptr i8, i8* %t156, i64 1
  store i8 0, i8* %t157
  call void @sailfin_runtime_mark_persistent(i8* %t156)
  %t158 = call i8* @sailfin_runtime_string_concat(i8* %t154, i8* %t156)
  %t159 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t158)
  ret %PythonBuilder %t159
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
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1267738404, i32 0, i32 0
  %t3 = load i8*, i8** %l0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s2, i8* %t3)
  %t5 = add i64 0, 2
  %t6 = call i8* @malloc(i64 %t5)
  store i8 58, i8* %t6
  %t7 = getelementptr i8, i8* %t6, i64 1
  store i8 0, i8* %t7
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t6)
  %t9 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t8)
  store %PythonBuilder %t9, %PythonBuilder* %l1
  %t10 = load %PythonBuilder, %PythonBuilder* %l1
  %t11 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t10)
  store %PythonBuilder %t11, %PythonBuilder* %l1
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
  store { i8**, i64 }* %t21, { i8**, i64 }** %l2
  %t24 = extractvalue %NativeStruct %definition, 1
  %t25 = call { i8**, i64 }* @render_struct_parameters({ %NativeStructField*, i64 }* %t24)
  store { i8**, i64 }* %t25, { i8**, i64 }** %l3
  %s26 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h215787497, i32 0, i32 0
  store i8* %s26, i8** %l4
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t28 = load { i8**, i64 }, { i8**, i64 }* %t27
  %t29 = extractvalue { i8**, i64 } %t28, 1
  %t30 = icmp sgt i64 %t29, 0
  %t31 = load i8*, i8** %l0
  %t32 = load %PythonBuilder, %PythonBuilder* %l1
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t35 = load i8*, i8** %l4
  br i1 %t30, label %then0, label %merge1
then0:
  %t36 = load i8*, i8** %l4
  %s37 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t38 = call i8* @sailfin_runtime_string_concat(i8* %t36, i8* %s37)
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s40 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t41 = call i8* @join_with_separator({ i8**, i64 }* %t39, i8* %s40)
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t38, i8* %t41)
  store i8* %t42, i8** %l4
  %t43 = load i8*, i8** %l4
  br label %merge1
merge1:
  %t44 = phi i8* [ %t43, %then0 ], [ %t35, %block.entry ]
  store i8* %t44, i8** %l4
  %t45 = load i8*, i8** %l4
  %t46 = add i64 0, 2
  %t47 = call i8* @malloc(i64 %t46)
  store i8 41, i8* %t47
  %t48 = getelementptr i8, i8* %t47, i64 1
  store i8 0, i8* %t48
  call void @sailfin_runtime_mark_persistent(i8* %t47)
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %t47)
  store i8* %t49, i8** %l4
  %t50 = load %PythonBuilder, %PythonBuilder* %l1
  %t51 = load i8*, i8** %l4
  %t52 = add i64 0, 2
  %t53 = call i8* @malloc(i64 %t52)
  store i8 58, i8* %t53
  %t54 = getelementptr i8, i8* %t53, i64 1
  store i8 0, i8* %t54
  call void @sailfin_runtime_mark_persistent(i8* %t53)
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %t53)
  %t56 = call %PythonBuilder @builder_emit(%PythonBuilder %t50, i8* %t55)
  store %PythonBuilder %t56, %PythonBuilder* %l1
  %t57 = load %PythonBuilder, %PythonBuilder* %l1
  %t58 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t57)
  store %PythonBuilder %t58, %PythonBuilder* %l1
  %t59 = extractvalue %NativeStruct %definition, 1
  %t60 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t59
  %t61 = extractvalue { %NativeStructField*, i64 } %t60, 1
  %t62 = icmp eq i64 %t61, 0
  %t63 = load i8*, i8** %l0
  %t64 = load %PythonBuilder, %PythonBuilder* %l1
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t67 = load i8*, i8** %l4
  br i1 %t62, label %then2, label %else3
then2:
  %t68 = load %PythonBuilder, %PythonBuilder* %l1
  %s69 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t70 = call %PythonBuilder @builder_emit(%PythonBuilder %t68, i8* %s69)
  store %PythonBuilder %t70, %PythonBuilder* %l1
  %t71 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
else3:
  %t72 = sitofp i64 0 to double
  store double %t72, double* %l5
  %t73 = load i8*, i8** %l0
  %t74 = load %PythonBuilder, %PythonBuilder* %l1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t77 = load i8*, i8** %l4
  %t78 = load double, double* %l5
  br label %loop.header5
loop.header5:
  %t118 = phi %PythonBuilder [ %t74, %else3 ], [ %t116, %loop.latch7 ]
  %t119 = phi double [ %t78, %else3 ], [ %t117, %loop.latch7 ]
  store %PythonBuilder %t118, %PythonBuilder* %l1
  store double %t119, double* %l5
  br label %loop.body6
loop.body6:
  %t79 = load double, double* %l5
  %t80 = extractvalue %NativeStruct %definition, 1
  %t81 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t80
  %t82 = extractvalue { %NativeStructField*, i64 } %t81, 1
  %t83 = sitofp i64 %t82 to double
  %t84 = fcmp oge double %t79, %t83
  %t85 = load i8*, i8** %l0
  %t86 = load %PythonBuilder, %PythonBuilder* %l1
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t89 = load i8*, i8** %l4
  %t90 = load double, double* %l5
  br i1 %t84, label %then9, label %merge10
then9:
  br label %afterloop8
merge10:
  %t91 = extractvalue %NativeStruct %definition, 1
  %t92 = load double, double* %l5
  %t93 = call double @llvm.round.f64(double %t92)
  %t94 = fptosi double %t93 to i64
  %t95 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t91
  %t96 = extractvalue { %NativeStructField*, i64 } %t95, 0
  %t97 = extractvalue { %NativeStructField*, i64 } %t95, 1
  %t98 = icmp uge i64 %t94, %t97
  ; bounds check: %t98 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t94, i64 %t97)
  %t99 = getelementptr %NativeStructField, %NativeStructField* %t96, i64 %t94
  %t100 = load %NativeStructField, %NativeStructField* %t99
  store %NativeStructField %t100, %NativeStructField* %l6
  %t101 = load %NativeStructField, %NativeStructField* %l6
  %t102 = extractvalue %NativeStructField %t101, 0
  %t103 = call i8* @sanitize_identifier(i8* %t102)
  store i8* %t103, i8** %l7
  %t104 = load %PythonBuilder, %PythonBuilder* %l1
  %s105 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h461434216, i32 0, i32 0
  %t106 = load i8*, i8** %l7
  %t107 = call i8* @sailfin_runtime_string_concat(i8* %s105, i8* %t106)
  %s108 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t109 = call i8* @sailfin_runtime_string_concat(i8* %t107, i8* %s108)
  %t110 = load i8*, i8** %l7
  %t111 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %t110)
  %t112 = call %PythonBuilder @builder_emit(%PythonBuilder %t104, i8* %t111)
  store %PythonBuilder %t112, %PythonBuilder* %l1
  %t113 = load double, double* %l5
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  store double %t115, double* %l5
  br label %loop.latch7
loop.latch7:
  %t116 = load %PythonBuilder, %PythonBuilder* %l1
  %t117 = load double, double* %l5
  br label %loop.header5
afterloop8:
  %t120 = load %PythonBuilder, %PythonBuilder* %l1
  %t121 = load double, double* %l5
  %t122 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
merge4:
  %t123 = phi %PythonBuilder [ %t71, %then2 ], [ %t122, %afterloop8 ]
  store %PythonBuilder %t123, %PythonBuilder* %l1
  %t124 = load %PythonBuilder, %PythonBuilder* %l1
  %t125 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t124)
  store %PythonBuilder %t125, %PythonBuilder* %l1
  %t126 = load %PythonBuilder, %PythonBuilder* %l1
  %t127 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t126)
  store %PythonBuilder %t127, %PythonBuilder* %l1
  %t128 = load %PythonBuilder, %PythonBuilder* %l1
  %s129 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1806641125, i32 0, i32 0
  %t130 = call %PythonBuilder @builder_emit(%PythonBuilder %t128, i8* %s129)
  store %PythonBuilder %t130, %PythonBuilder* %l1
  %t131 = load %PythonBuilder, %PythonBuilder* %l1
  %t132 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t131)
  store %PythonBuilder %t132, %PythonBuilder* %l1
  %t133 = load i8*, i8** %l0
  %t134 = extractvalue %NativeStruct %definition, 1
  %t135 = call i8* @render_struct_repr_fields(i8* %t133, { %NativeStructField*, i64 }* %t134)
  store i8* %t135, i8** %l8
  %t136 = load %PythonBuilder, %PythonBuilder* %l1
  %t137 = load i8*, i8** %l8
  %t138 = call %PythonBuilder @builder_emit(%PythonBuilder %t136, i8* %t137)
  store %PythonBuilder %t138, %PythonBuilder* %l1
  %t139 = load %PythonBuilder, %PythonBuilder* %l1
  %t140 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t139)
  store %PythonBuilder %t140, %PythonBuilder* %l1
  %t141 = load i8*, i8** %l0
  %s142 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h300877395, i32 0, i32 0
  %t143 = call i1 @strings_equal(i8* %t141, i8* %s142)
  %t144 = load i8*, i8** %l0
  %t145 = load %PythonBuilder, %PythonBuilder* %l1
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t148 = load i8*, i8** %l4
  %t149 = load i8*, i8** %l8
  br i1 %t143, label %then11, label %merge12
then11:
  %t150 = load %PythonBuilder, %PythonBuilder* %l1
  %t151 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t150)
  store %PythonBuilder %t151, %PythonBuilder* %l1
  %t152 = load %PythonBuilder, %PythonBuilder* %l1
  %s153 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h430828782, i32 0, i32 0
  %t154 = call %PythonBuilder @builder_emit(%PythonBuilder %t152, i8* %s153)
  store %PythonBuilder %t154, %PythonBuilder* %l1
  %t155 = load %PythonBuilder, %PythonBuilder* %l1
  %t156 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t155)
  store %PythonBuilder %t156, %PythonBuilder* %l1
  %t157 = load %PythonBuilder, %PythonBuilder* %l1
  %s158 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h320851598, i32 0, i32 0
  %t159 = call %PythonBuilder @builder_emit(%PythonBuilder %t157, i8* %s158)
  store %PythonBuilder %t159, %PythonBuilder* %l1
  %t160 = load %PythonBuilder, %PythonBuilder* %l1
  %s161 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t162 = call %PythonBuilder @builder_emit(%PythonBuilder %t160, i8* %s161)
  store %PythonBuilder %t162, %PythonBuilder* %l1
  %t163 = load %PythonBuilder, %PythonBuilder* %l1
  %t164 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t163)
  store %PythonBuilder %t164, %PythonBuilder* %l1
  %t165 = load %PythonBuilder, %PythonBuilder* %l1
  %s166 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h610920064, i32 0, i32 0
  %t167 = call %PythonBuilder @builder_emit(%PythonBuilder %t165, i8* %s166)
  store %PythonBuilder %t167, %PythonBuilder* %l1
  %t168 = load %PythonBuilder, %PythonBuilder* %l1
  %t169 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t168)
  store %PythonBuilder %t169, %PythonBuilder* %l1
  %t170 = load %PythonBuilder, %PythonBuilder* %l1
  %s171 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t172 = call %PythonBuilder @builder_emit(%PythonBuilder %t170, i8* %s171)
  store %PythonBuilder %t172, %PythonBuilder* %l1
  %t173 = load %PythonBuilder, %PythonBuilder* %l1
  %t174 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t173)
  store %PythonBuilder %t174, %PythonBuilder* %l1
  %t175 = load %PythonBuilder, %PythonBuilder* %l1
  %s176 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1088202076, i32 0, i32 0
  %t177 = call %PythonBuilder @builder_emit(%PythonBuilder %t175, i8* %s176)
  store %PythonBuilder %t177, %PythonBuilder* %l1
  %t178 = load %PythonBuilder, %PythonBuilder* %l1
  %s179 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h983476432, i32 0, i32 0
  %t180 = call %PythonBuilder @builder_emit(%PythonBuilder %t178, i8* %s179)
  store %PythonBuilder %t180, %PythonBuilder* %l1
  %t181 = load %PythonBuilder, %PythonBuilder* %l1
  %t182 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t181)
  store %PythonBuilder %t182, %PythonBuilder* %l1
  %t183 = load %PythonBuilder, %PythonBuilder* %l1
  %s184 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1456282769, i32 0, i32 0
  %t185 = call %PythonBuilder @builder_emit(%PythonBuilder %t183, i8* %s184)
  store %PythonBuilder %t185, %PythonBuilder* %l1
  %t186 = load %PythonBuilder, %PythonBuilder* %l1
  %t187 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t186)
  store %PythonBuilder %t187, %PythonBuilder* %l1
  %t188 = load %PythonBuilder, %PythonBuilder* %l1
  %s189 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1977847647, i32 0, i32 0
  %t190 = call %PythonBuilder @builder_emit(%PythonBuilder %t188, i8* %s189)
  store %PythonBuilder %t190, %PythonBuilder* %l1
  %t191 = load %PythonBuilder, %PythonBuilder* %l1
  %t192 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t191)
  store %PythonBuilder %t192, %PythonBuilder* %l1
  %t193 = load %PythonBuilder, %PythonBuilder* %l1
  %s194 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1984174475, i32 0, i32 0
  %t195 = call %PythonBuilder @builder_emit(%PythonBuilder %t193, i8* %s194)
  store %PythonBuilder %t195, %PythonBuilder* %l1
  %t196 = load %PythonBuilder, %PythonBuilder* %l1
  %t197 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t196)
  store %PythonBuilder %t197, %PythonBuilder* %l1
  %t198 = load %PythonBuilder, %PythonBuilder* %l1
  %t199 = load %PythonBuilder, %PythonBuilder* %l1
  %t200 = load %PythonBuilder, %PythonBuilder* %l1
  %t201 = load %PythonBuilder, %PythonBuilder* %l1
  %t202 = load %PythonBuilder, %PythonBuilder* %l1
  %t203 = load %PythonBuilder, %PythonBuilder* %l1
  %t204 = load %PythonBuilder, %PythonBuilder* %l1
  %t205 = load %PythonBuilder, %PythonBuilder* %l1
  %t206 = load %PythonBuilder, %PythonBuilder* %l1
  %t207 = load %PythonBuilder, %PythonBuilder* %l1
  %t208 = load %PythonBuilder, %PythonBuilder* %l1
  %t209 = load %PythonBuilder, %PythonBuilder* %l1
  %t210 = load %PythonBuilder, %PythonBuilder* %l1
  %t211 = load %PythonBuilder, %PythonBuilder* %l1
  %t212 = load %PythonBuilder, %PythonBuilder* %l1
  %t213 = load %PythonBuilder, %PythonBuilder* %l1
  %t214 = load %PythonBuilder, %PythonBuilder* %l1
  %t215 = load %PythonBuilder, %PythonBuilder* %l1
  %t216 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t217 = phi %PythonBuilder [ %t198, %then11 ], [ %t145, %merge4 ]
  %t218 = phi %PythonBuilder [ %t199, %then11 ], [ %t145, %merge4 ]
  %t219 = phi %PythonBuilder [ %t200, %then11 ], [ %t145, %merge4 ]
  %t220 = phi %PythonBuilder [ %t201, %then11 ], [ %t145, %merge4 ]
  %t221 = phi %PythonBuilder [ %t202, %then11 ], [ %t145, %merge4 ]
  %t222 = phi %PythonBuilder [ %t203, %then11 ], [ %t145, %merge4 ]
  %t223 = phi %PythonBuilder [ %t204, %then11 ], [ %t145, %merge4 ]
  %t224 = phi %PythonBuilder [ %t205, %then11 ], [ %t145, %merge4 ]
  %t225 = phi %PythonBuilder [ %t206, %then11 ], [ %t145, %merge4 ]
  %t226 = phi %PythonBuilder [ %t207, %then11 ], [ %t145, %merge4 ]
  %t227 = phi %PythonBuilder [ %t208, %then11 ], [ %t145, %merge4 ]
  %t228 = phi %PythonBuilder [ %t209, %then11 ], [ %t145, %merge4 ]
  %t229 = phi %PythonBuilder [ %t210, %then11 ], [ %t145, %merge4 ]
  %t230 = phi %PythonBuilder [ %t211, %then11 ], [ %t145, %merge4 ]
  %t231 = phi %PythonBuilder [ %t212, %then11 ], [ %t145, %merge4 ]
  %t232 = phi %PythonBuilder [ %t213, %then11 ], [ %t145, %merge4 ]
  %t233 = phi %PythonBuilder [ %t214, %then11 ], [ %t145, %merge4 ]
  %t234 = phi %PythonBuilder [ %t215, %then11 ], [ %t145, %merge4 ]
  %t235 = phi %PythonBuilder [ %t216, %then11 ], [ %t145, %merge4 ]
  store %PythonBuilder %t217, %PythonBuilder* %l1
  store %PythonBuilder %t218, %PythonBuilder* %l1
  store %PythonBuilder %t219, %PythonBuilder* %l1
  store %PythonBuilder %t220, %PythonBuilder* %l1
  store %PythonBuilder %t221, %PythonBuilder* %l1
  store %PythonBuilder %t222, %PythonBuilder* %l1
  store %PythonBuilder %t223, %PythonBuilder* %l1
  store %PythonBuilder %t224, %PythonBuilder* %l1
  store %PythonBuilder %t225, %PythonBuilder* %l1
  store %PythonBuilder %t226, %PythonBuilder* %l1
  store %PythonBuilder %t227, %PythonBuilder* %l1
  store %PythonBuilder %t228, %PythonBuilder* %l1
  store %PythonBuilder %t229, %PythonBuilder* %l1
  store %PythonBuilder %t230, %PythonBuilder* %l1
  store %PythonBuilder %t231, %PythonBuilder* %l1
  store %PythonBuilder %t232, %PythonBuilder* %l1
  store %PythonBuilder %t233, %PythonBuilder* %l1
  store %PythonBuilder %t234, %PythonBuilder* %l1
  store %PythonBuilder %t235, %PythonBuilder* %l1
  %t236 = extractvalue %NativeStruct %definition, 2
  %t237 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t236
  %t238 = extractvalue { %NativeFunction*, i64 } %t237, 1
  %t239 = icmp sgt i64 %t238, 0
  %t240 = load i8*, i8** %l0
  %t241 = load %PythonBuilder, %PythonBuilder* %l1
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t244 = load i8*, i8** %l4
  %t245 = load i8*, i8** %l8
  br i1 %t239, label %then13, label %merge14
then13:
  %t246 = load %PythonBuilder, %PythonBuilder* %l1
  %t247 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t246)
  store %PythonBuilder %t247, %PythonBuilder* %l1
  %t248 = sitofp i64 0 to double
  store double %t248, double* %l9
  %t249 = load i8*, i8** %l0
  %t250 = load %PythonBuilder, %PythonBuilder* %l1
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t253 = load i8*, i8** %l4
  %t254 = load i8*, i8** %l8
  %t255 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t315 = phi %PythonBuilder [ %t250, %then13 ], [ %t312, %loop.latch17 ]
  %t316 = phi { i8**, i64 }* [ %t251, %then13 ], [ %t313, %loop.latch17 ]
  %t317 = phi double [ %t255, %then13 ], [ %t314, %loop.latch17 ]
  store %PythonBuilder %t315, %PythonBuilder* %l1
  store { i8**, i64 }* %t316, { i8**, i64 }** %l2
  store double %t317, double* %l9
  br label %loop.body16
loop.body16:
  %t256 = load double, double* %l9
  %t257 = extractvalue %NativeStruct %definition, 2
  %t258 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t257
  %t259 = extractvalue { %NativeFunction*, i64 } %t258, 1
  %t260 = sitofp i64 %t259 to double
  %t261 = fcmp oge double %t256, %t260
  %t262 = load i8*, i8** %l0
  %t263 = load %PythonBuilder, %PythonBuilder* %l1
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t266 = load i8*, i8** %l4
  %t267 = load i8*, i8** %l8
  %t268 = load double, double* %l9
  br i1 %t261, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t269 = extractvalue %NativeStruct %definition, 2
  %t270 = load double, double* %l9
  %t271 = call double @llvm.round.f64(double %t270)
  %t272 = fptosi double %t271 to i64
  %t273 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t269
  %t274 = extractvalue { %NativeFunction*, i64 } %t273, 0
  %t275 = extractvalue { %NativeFunction*, i64 } %t273, 1
  %t276 = icmp uge i64 %t272, %t275
  ; bounds check: %t276 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t272, i64 %t275)
  %t277 = getelementptr %NativeFunction, %NativeFunction* %t274, i64 %t272
  %t278 = load %NativeFunction, %NativeFunction* %t277
  store %NativeFunction %t278, %NativeFunction* %l10
  %t279 = load %PythonBuilder, %PythonBuilder* %l1
  %t280 = load %NativeFunction, %NativeFunction* %l10
  %t281 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t279, %NativeFunction %t280)
  store %PythonFunctionEmission %t281, %PythonFunctionEmission* %l11
  %t282 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t283 = extractvalue %PythonFunctionEmission %t282, 0
  store %PythonBuilder %t283, %PythonBuilder* %l1
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t285 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t286 = extractvalue %PythonFunctionEmission %t285, 1
  %t287 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t284, { i8**, i64 }* %t286)
  store { i8**, i64 }* %t287, { i8**, i64 }** %l2
  %t288 = load double, double* %l9
  %t289 = sitofp i64 1 to double
  %t290 = fadd double %t288, %t289
  %t291 = extractvalue %NativeStruct %definition, 2
  %t292 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t291
  %t293 = extractvalue { %NativeFunction*, i64 } %t292, 1
  %t294 = sitofp i64 %t293 to double
  %t295 = fcmp olt double %t290, %t294
  %t296 = load i8*, i8** %l0
  %t297 = load %PythonBuilder, %PythonBuilder* %l1
  %t298 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t300 = load i8*, i8** %l4
  %t301 = load i8*, i8** %l8
  %t302 = load double, double* %l9
  %t303 = load %NativeFunction, %NativeFunction* %l10
  %t304 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t295, label %then21, label %merge22
then21:
  %t305 = load %PythonBuilder, %PythonBuilder* %l1
  %t306 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t305)
  store %PythonBuilder %t306, %PythonBuilder* %l1
  %t307 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t308 = phi %PythonBuilder [ %t307, %then21 ], [ %t297, %merge20 ]
  store %PythonBuilder %t308, %PythonBuilder* %l1
  %t309 = load double, double* %l9
  %t310 = sitofp i64 1 to double
  %t311 = fadd double %t309, %t310
  store double %t311, double* %l9
  br label %loop.latch17
loop.latch17:
  %t312 = load %PythonBuilder, %PythonBuilder* %l1
  %t313 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t314 = load double, double* %l9
  br label %loop.header15
afterloop18:
  %t318 = load %PythonBuilder, %PythonBuilder* %l1
  %t319 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t320 = load double, double* %l9
  %t321 = load %PythonBuilder, %PythonBuilder* %l1
  %t322 = load %PythonBuilder, %PythonBuilder* %l1
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t324 = phi %PythonBuilder [ %t321, %afterloop18 ], [ %t241, %merge12 ]
  %t325 = phi %PythonBuilder [ %t322, %afterloop18 ], [ %t241, %merge12 ]
  %t326 = phi { i8**, i64 }* [ %t323, %afterloop18 ], [ %t242, %merge12 ]
  store %PythonBuilder %t324, %PythonBuilder* %l1
  store %PythonBuilder %t325, %PythonBuilder* %l1
  store { i8**, i64 }* %t326, { i8**, i64 }** %l2
  %t327 = load %PythonBuilder, %PythonBuilder* %l1
  %t328 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t327)
  store %PythonBuilder %t328, %PythonBuilder* %l1
  %t329 = load %PythonBuilder, %PythonBuilder* %l1
  %t330 = insertvalue %PythonStructEmission undef, %PythonBuilder %t329, 0
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t332 = insertvalue %PythonStructEmission %t330, { i8**, i64 }* %t331, 1
  ret %PythonStructEmission %t332
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
  %t79 = phi { i8**, i64 }* [ %t26, %block.entry ], [ %t76, %loop.latch2 ]
  %t80 = phi { i8**, i64 }* [ %t25, %block.entry ], [ %t77, %loop.latch2 ]
  %t81 = phi double [ %t27, %block.entry ], [ %t78, %loop.latch2 ]
  store { i8**, i64 }* %t79, { i8**, i64 }** %l1
  store { i8**, i64 }* %t80, { i8**, i64 }** %l0
  store double %t81, double* %l2
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
  %s59 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h468448796, i32 0, i32 0
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %s59)
  store i8* %t60, i8** %l5
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t62 = load i8*, i8** %l5
  %t63 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t61, i8* %t62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l1
  %t64 = load i8*, i8** %l5
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge8
else7:
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l5
  %t68 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t66, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge8
merge8:
  %t70 = phi i8* [ %t64, %then6 ], [ %t57, %else7 ]
  %t71 = phi { i8**, i64 }* [ %t65, %then6 ], [ %t53, %else7 ]
  %t72 = phi { i8**, i64 }* [ %t52, %then6 ], [ %t69, %else7 ]
  store i8* %t70, i8** %l5
  store { i8**, i64 }* %t71, { i8**, i64 }** %l1
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l2
  br label %loop.latch2
loop.latch2:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t78 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t84 = load double, double* %l2
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t85, { i8**, i64 }* %t86)
  ret { i8**, i64 }* %t87
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
  %s3 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1179318158, i32 0, i32 0
  %t4 = call i8* @sailfin_runtime_string_concat(i8* %s3, i8* %class_name)
  %s5 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h653919037, i32 0, i32 0
  %t6 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %s5)
  call void @sailfin_runtime_mark_persistent(i8* %t6)
  ret i8* %t6
merge1:
  %t7 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t8 = ptrtoint [0 x i8*]* %t7 to i64
  %t9 = icmp eq i64 %t8, 0
  %t10 = select i1 %t9, i64 1, i64 %t8
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to i8**
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t14 = ptrtoint { i8**, i64 }* %t13 to i64
  %t15 = call i8* @malloc(i64 %t14)
  %t16 = bitcast i8* %t15 to { i8**, i64 }*
  %t17 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 0
  store i8** %t12, i8*** %t17
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { i8**, i64 }* %t16, { i8**, i64 }** %l0
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l1
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t21 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t59 = phi { i8**, i64 }* [ %t20, %merge1 ], [ %t57, %loop.latch4 ]
  %t60 = phi double [ %t21, %merge1 ], [ %t58, %loop.latch4 ]
  store { i8**, i64 }* %t59, { i8**, i64 }** %l0
  store double %t60, double* %l1
  br label %loop.body3
loop.body3:
  %t22 = load double, double* %l1
  %t23 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t24 = extractvalue { %NativeStructField*, i64 } %t23, 1
  %t25 = sitofp i64 %t24 to double
  %t26 = fcmp oge double %t22, %t25
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load double, double* %l1
  br i1 %t26, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t29 = load double, double* %l1
  %t30 = call double @llvm.round.f64(double %t29)
  %t31 = fptosi double %t30 to i64
  %t32 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields
  %t33 = extractvalue { %NativeStructField*, i64 } %t32, 0
  %t34 = extractvalue { %NativeStructField*, i64 } %t32, 1
  %t35 = icmp uge i64 %t31, %t34
  ; bounds check: %t35 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t31, i64 %t34)
  %t36 = getelementptr %NativeStructField, %NativeStructField* %t33, i64 %t31
  %t37 = load %NativeStructField, %NativeStructField* %t36
  store %NativeStructField %t37, %NativeStructField* %l2
  %t38 = load %NativeStructField, %NativeStructField* %l2
  %t39 = extractvalue %NativeStructField %t38, 0
  %t40 = call i8* @sanitize_identifier(i8* %t39)
  store i8* %t40, i8** %l3
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s42 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h1038501153, i32 0, i32 0
  %t43 = load i8*, i8** %l3
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %s42, i8* %t43)
  %s45 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h104511138, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %s45)
  %t47 = load i8*, i8** %l3
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t47)
  %t49 = add i64 0, 2
  %t50 = call i8* @malloc(i64 %t49)
  store i8 41, i8* %t50
  %t51 = getelementptr i8, i8* %t50, i64 1
  store i8 0, i8* %t51
  call void @sailfin_runtime_mark_persistent(i8* %t50)
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t50)
  %t53 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t41, i8* %t52)
  store { i8**, i64 }* %t53, { i8**, i64 }** %l0
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l1
  br label %loop.latch4
loop.latch4:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load double, double* %l1
  %s63 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1179318158, i32 0, i32 0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %s63, i8* %class_name)
  %s65 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %s65)
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s68 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t69 = call i8* @join_with_separator({ i8**, i64 }* %t67, i8* %s68)
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t69)
  %s71 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %s71)
  call void @sailfin_runtime_mark_persistent(i8* %t72)
  ret i8* %t72
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
  %s7 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193515005, i32 0, i32 0
  %t8 = call double @find_substring(i8* %t6, i8* %s7)
  %t9 = sitofp i64 0 to double
  %t10 = fcmp olt double %t8, %t9
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then4, label %merge5
then4:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge5:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193517249, i32 0, i32 0
  %t14 = call double @find_substring(i8* %t12, i8* %s13)
  %t15 = sitofp i64 0 to double
  %t16 = fcmp olt double %t14, %t15
  %t17 = load i8*, i8** %l0
  br i1 %t16, label %then6, label %merge7
then6:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge7:
  %t18 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t19 = ptrtoint [0 x i8*]* %t18 to i64
  %t20 = icmp eq i64 %t19, 0
  %t21 = select i1 %t20, i64 1, i64 %t19
  %t22 = call i8* @malloc(i64 %t21)
  %t23 = bitcast i8* %t22 to i8**
  %t24 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t25 = ptrtoint { i8**, i64 }* %t24 to i64
  %t26 = call i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to { i8**, i64 }*
  %t28 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 0
  store i8** %t23, i8*** %t28
  %t29 = getelementptr { i8**, i64 }, { i8**, i64 }* %t27, i32 0, i32 1
  store i64 0, i64* %t29
  store { i8**, i64 }* %t27, { i8**, i64 }** %l1
  %t30 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t31 = ptrtoint [0 x i8*]* %t30 to i64
  %t32 = icmp eq i64 %t31, 0
  %t33 = select i1 %t32, i64 1, i64 %t31
  %t34 = call i8* @malloc(i64 %t33)
  %t35 = bitcast i8* %t34 to i8**
  %t36 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t37 = ptrtoint { i8**, i64 }* %t36 to i64
  %t38 = call i8* @malloc(i64 %t37)
  %t39 = bitcast i8* %t38 to { i8**, i64 }*
  %t40 = getelementptr { i8**, i64 }, { i8**, i64 }* %t39, i32 0, i32 0
  store i8** %t35, i8*** %t40
  %t41 = getelementptr { i8**, i64 }, { i8**, i64 }* %t39, i32 0, i32 1
  store i64 0, i64* %t41
  store { i8**, i64 }* %t39, { i8**, i64 }** %l2
  store i64 0, i64* %l3
  %t42 = load i8*, i8** %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load i64, i64* %l3
  br label %loop.header8
loop.header8:
  %t133 = phi { i8**, i64 }* [ %t43, %merge7 ], [ %t130, %loop.latch10 ]
  %t134 = phi { i8**, i64 }* [ %t44, %merge7 ], [ %t131, %loop.latch10 ]
  %t135 = phi i64 [ %t45, %merge7 ], [ %t132, %loop.latch10 ]
  store { i8**, i64 }* %t133, { i8**, i64 }** %l1
  store { i8**, i64 }* %t134, { i8**, i64 }** %l2
  store i64 %t135, i64* %l3
  br label %loop.body9
loop.body9:
  %t46 = load i64, i64* %l3
  %t47 = load i8*, i8** %l0
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = icmp sgt i64 %t46, %t48
  %t50 = load i8*, i8** %l0
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t53 = load i64, i64* %l3
  br i1 %t49, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t54 = load i8*, i8** %l0
  %s55 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193515005, i32 0, i32 0
  %t56 = load i64, i64* %l3
  %t57 = sitofp i64 %t56 to double
  %t58 = call double @find_substring_from(i8* %t54, i8* %s55, double %t57)
  store double %t58, double* %l4
  %t59 = load double, double* %l4
  %t60 = sitofp i64 0 to double
  %t61 = fcmp olt double %t59, %t60
  %t62 = load i8*, i8** %l0
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load i64, i64* %l3
  %t66 = load double, double* %l4
  br i1 %t61, label %then14, label %merge15
then14:
  %t67 = load i8*, i8** %l0
  %t68 = load i64, i64* %l3
  %t69 = load i8*, i8** %l0
  %t70 = call i64 @sailfin_runtime_string_length(i8* %t69)
  %t71 = call i8* @sailfin_runtime_substring(i8* %t67, i64 %t68, i64 %t70)
  store i8* %t71, i8** %l5
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = load i8*, i8** %l5
  %t74 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t72, i8* %t73)
  store { i8**, i64 }* %t74, { i8**, i64 }** %l1
  br label %afterloop11
merge15:
  %t75 = load i8*, i8** %l0
  %t76 = load i64, i64* %l3
  %t77 = load double, double* %l4
  %t78 = call double @llvm.round.f64(double %t77)
  %t79 = fptosi double %t78 to i64
  %t80 = call i8* @sailfin_runtime_substring(i8* %t75, i64 %t76, i64 %t79)
  store i8* %t80, i8** %l6
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t82 = load i8*, i8** %l6
  %t83 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t81, i8* %t82)
  store { i8**, i64 }* %t83, { i8**, i64 }** %l1
  %t84 = load i8*, i8** %l0
  %s85 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193517249, i32 0, i32 0
  %t86 = load double, double* %l4
  %t87 = sitofp i64 2 to double
  %t88 = fadd double %t86, %t87
  %t89 = call double @find_substring_from(i8* %t84, i8* %s85, double %t88)
  store double %t89, double* %l7
  %t90 = load double, double* %l7
  %t91 = sitofp i64 0 to double
  %t92 = fcmp olt double %t90, %t91
  %t93 = load i8*, i8** %l0
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t96 = load i64, i64* %l3
  %t97 = load double, double* %l4
  %t98 = load i8*, i8** %l6
  %t99 = load double, double* %l7
  br i1 %t92, label %then16, label %merge17
then16:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge17:
  %t100 = load i8*, i8** %l0
  %t101 = load double, double* %l4
  %t102 = sitofp i64 2 to double
  %t103 = fadd double %t101, %t102
  %t104 = load double, double* %l7
  %t105 = call double @llvm.round.f64(double %t103)
  %t106 = fptosi double %t105 to i64
  %t107 = call double @llvm.round.f64(double %t104)
  %t108 = fptosi double %t107 to i64
  %t109 = call i8* @sailfin_runtime_substring(i8* %t100, i64 %t106, i64 %t108)
  %t110 = call i8* @trim_text(i8* %t109)
  store i8* %t110, i8** %l8
  %t111 = load i8*, i8** %l8
  %t112 = call i64 @sailfin_runtime_string_length(i8* %t111)
  %t113 = icmp eq i64 %t112, 0
  %t114 = load i8*, i8** %l0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t117 = load i64, i64* %l3
  %t118 = load double, double* %l4
  %t119 = load i8*, i8** %l6
  %t120 = load double, double* %l7
  %t121 = load i8*, i8** %l8
  br i1 %t113, label %then18, label %merge19
then18:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge19:
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t123 = load i8*, i8** %l8
  %t124 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t122, i8* %t123)
  store { i8**, i64 }* %t124, { i8**, i64 }** %l2
  %t125 = load double, double* %l7
  %t126 = sitofp i64 2 to double
  %t127 = fadd double %t125, %t126
  %t128 = call double @llvm.round.f64(double %t127)
  %t129 = fptosi double %t128 to i64
  store i64 %t129, i64* %l3
  br label %loop.latch10
loop.latch10:
  %t130 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t132 = load i64, i64* %l3
  br label %loop.header8
afterloop11:
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t138 = load i64, i64* %l3
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t140 = load { i8**, i64 }, { i8**, i64 }* %t139
  %t141 = extractvalue { i8**, i64 } %t140, 1
  %t142 = icmp eq i64 %t141, 0
  %t143 = load i8*, i8** %l0
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t146 = load i64, i64* %l3
  br i1 %t142, label %then20, label %merge21
then20:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge21:
  %t147 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t148 = ptrtoint [0 x i8*]* %t147 to i64
  %t149 = icmp eq i64 %t148, 0
  %t150 = select i1 %t149, i64 1, i64 %t148
  %t151 = call i8* @malloc(i64 %t150)
  %t152 = bitcast i8* %t151 to i8**
  %t153 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t154 = ptrtoint { i8**, i64 }* %t153 to i64
  %t155 = call i8* @malloc(i64 %t154)
  %t156 = bitcast i8* %t155 to { i8**, i64 }*
  %t157 = getelementptr { i8**, i64 }, { i8**, i64 }* %t156, i32 0, i32 0
  store i8** %t152, i8*** %t157
  %t158 = getelementptr { i8**, i64 }, { i8**, i64 }* %t156, i32 0, i32 1
  store i64 0, i64* %t158
  store { i8**, i64 }* %t156, { i8**, i64 }** %l9
  %t159 = sitofp i64 0 to double
  store double %t159, double* %l10
  %t160 = load i8*, i8** %l0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t163 = load i64, i64* %l3
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t165 = load double, double* %l10
  br label %loop.header22
loop.header22:
  %t196 = phi { i8**, i64 }* [ %t164, %merge21 ], [ %t194, %loop.latch24 ]
  %t197 = phi double [ %t165, %merge21 ], [ %t195, %loop.latch24 ]
  store { i8**, i64 }* %t196, { i8**, i64 }** %l9
  store double %t197, double* %l10
  br label %loop.body23
loop.body23:
  %t166 = load double, double* %l10
  %t167 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t168 = load { i8**, i64 }, { i8**, i64 }* %t167
  %t169 = extractvalue { i8**, i64 } %t168, 1
  %t170 = sitofp i64 %t169 to double
  %t171 = fcmp oge double %t166, %t170
  %t172 = load i8*, i8** %l0
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t175 = load i64, i64* %l3
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t177 = load double, double* %l10
  br i1 %t171, label %then26, label %merge27
then26:
  br label %afterloop25
merge27:
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t180 = load double, double* %l10
  %t181 = call double @llvm.round.f64(double %t180)
  %t182 = fptosi double %t181 to i64
  %t183 = load { i8**, i64 }, { i8**, i64 }* %t179
  %t184 = extractvalue { i8**, i64 } %t183, 0
  %t185 = extractvalue { i8**, i64 } %t183, 1
  %t186 = icmp uge i64 %t182, %t185
  ; bounds check: %t186 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t182, i64 %t185)
  %t187 = getelementptr i8*, i8** %t184, i64 %t182
  %t188 = load i8*, i8** %t187
  %t189 = call i8* @python_string_literal(i8* %t188)
  %t190 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t178, i8* %t189)
  store { i8**, i64 }* %t190, { i8**, i64 }** %l9
  %t191 = load double, double* %l10
  %t192 = sitofp i64 1 to double
  %t193 = fadd double %t191, %t192
  store double %t193, double* %l10
  br label %loop.latch24
loop.latch24:
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t195 = load double, double* %l10
  br label %loop.header22
afterloop25:
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t199 = load double, double* %l10
  %t200 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t201 = ptrtoint [0 x i8*]* %t200 to i64
  %t202 = icmp eq i64 %t201, 0
  %t203 = select i1 %t202, i64 1, i64 %t201
  %t204 = call i8* @malloc(i64 %t203)
  %t205 = bitcast i8* %t204 to i8**
  %t206 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t207 = ptrtoint { i8**, i64 }* %t206 to i64
  %t208 = call i8* @malloc(i64 %t207)
  %t209 = bitcast i8* %t208 to { i8**, i64 }*
  %t210 = getelementptr { i8**, i64 }, { i8**, i64 }* %t209, i32 0, i32 0
  store i8** %t205, i8*** %t210
  %t211 = getelementptr { i8**, i64 }, { i8**, i64 }* %t209, i32 0, i32 1
  store i64 0, i64* %t211
  store { i8**, i64 }* %t209, { i8**, i64 }** %l11
  %t212 = sitofp i64 0 to double
  store double %t212, double* %l10
  %t213 = load i8*, i8** %l0
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t216 = load i64, i64* %l3
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t218 = load double, double* %l10
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br label %loop.header28
loop.header28:
  %t258 = phi { i8**, i64 }* [ %t219, %afterloop25 ], [ %t256, %loop.latch30 ]
  %t259 = phi double [ %t218, %afterloop25 ], [ %t257, %loop.latch30 ]
  store { i8**, i64 }* %t258, { i8**, i64 }** %l11
  store double %t259, double* %l10
  br label %loop.body29
loop.body29:
  %t220 = load double, double* %l10
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t222 = load { i8**, i64 }, { i8**, i64 }* %t221
  %t223 = extractvalue { i8**, i64 } %t222, 1
  %t224 = sitofp i64 %t223 to double
  %t225 = fcmp oge double %t220, %t224
  %t226 = load i8*, i8** %l0
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t229 = load i64, i64* %l3
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %t231 = load double, double* %l10
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l11
  br i1 %t225, label %then32, label %merge33
then32:
  br label %afterloop31
merge33:
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t235 = load double, double* %l10
  %t236 = call double @llvm.round.f64(double %t235)
  %t237 = fptosi double %t236 to i64
  %t238 = load { i8**, i64 }, { i8**, i64 }* %t234
  %t239 = extractvalue { i8**, i64 } %t238, 0
  %t240 = extractvalue { i8**, i64 } %t238, 1
  %t241 = icmp uge i64 %t237, %t240
  ; bounds check: %t241 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t237, i64 %t240)
  %t242 = getelementptr i8*, i8** %t239, i64 %t237
  %t243 = load i8*, i8** %t242
  %t244 = add i64 0, 2
  %t245 = call i8* @malloc(i64 %t244)
  store i8 40, i8* %t245
  %t246 = getelementptr i8, i8* %t245, i64 1
  store i8 0, i8* %t246
  call void @sailfin_runtime_mark_persistent(i8* %t245)
  %t247 = call i8* @sailfin_runtime_string_concat(i8* %t245, i8* %t243)
  %t248 = add i64 0, 2
  %t249 = call i8* @malloc(i64 %t248)
  store i8 41, i8* %t249
  %t250 = getelementptr i8, i8* %t249, i64 1
  store i8 0, i8* %t250
  call void @sailfin_runtime_mark_persistent(i8* %t249)
  %t251 = call i8* @sailfin_runtime_string_concat(i8* %t247, i8* %t249)
  %t252 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t233, i8* %t251)
  store { i8**, i64 }* %t252, { i8**, i64 }** %l11
  %t253 = load double, double* %l10
  %t254 = sitofp i64 1 to double
  %t255 = fadd double %t253, %t254
  store double %t255, double* %l10
  br label %loop.latch30
loop.latch30:
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t257 = load double, double* %l10
  br label %loop.header28
afterloop31:
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t261 = load double, double* %l10
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %s263 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t264 = call i8* @join_with_separator({ i8**, i64 }* %t262, i8* %s263)
  %t265 = add i64 0, 2
  %t266 = call i8* @malloc(i64 %t265)
  store i8 91, i8* %t266
  %t267 = getelementptr i8, i8* %t266, i64 1
  store i8 0, i8* %t267
  call void @sailfin_runtime_mark_persistent(i8* %t266)
  %t268 = call i8* @sailfin_runtime_string_concat(i8* %t266, i8* %t264)
  %t269 = add i64 0, 2
  %t270 = call i8* @malloc(i64 %t269)
  store i8 93, i8* %t270
  %t271 = getelementptr i8, i8* %t270, i64 1
  store i8 0, i8* %t271
  call void @sailfin_runtime_mark_persistent(i8* %t270)
  %t272 = call i8* @sailfin_runtime_string_concat(i8* %t268, i8* %t270)
  store i8* %t272, i8** %l12
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %s274 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t275 = call i8* @join_with_separator({ i8**, i64 }* %t273, i8* %s274)
  %t276 = add i64 0, 2
  %t277 = call i8* @malloc(i64 %t276)
  store i8 91, i8* %t277
  %t278 = getelementptr i8, i8* %t277, i64 1
  store i8 0, i8* %t278
  call void @sailfin_runtime_mark_persistent(i8* %t277)
  %t279 = call i8* @sailfin_runtime_string_concat(i8* %t277, i8* %t275)
  %t280 = add i64 0, 2
  %t281 = call i8* @malloc(i64 %t280)
  store i8 93, i8* %t281
  %t282 = getelementptr i8, i8* %t281, i64 1
  store i8 0, i8* %t282
  call void @sailfin_runtime_mark_persistent(i8* %t281)
  %t283 = call i8* @sailfin_runtime_string_concat(i8* %t279, i8* %t281)
  store i8* %t283, i8** %l13
  %s284 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h583209964, i32 0, i32 0
  %t285 = load i8*, i8** %l12
  %t286 = call i8* @sailfin_runtime_string_concat(i8* %s284, i8* %t285)
  %s287 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t288 = call i8* @sailfin_runtime_string_concat(i8* %t286, i8* %s287)
  %t289 = load i8*, i8** %l13
  %t290 = call i8* @sailfin_runtime_string_concat(i8* %t288, i8* %t289)
  %t291 = add i64 0, 2
  %t292 = call i8* @malloc(i64 %t291)
  store i8 41, i8* %t292
  %t293 = getelementptr i8, i8* %t292, i64 1
  store i8 0, i8* %t293
  call void @sailfin_runtime_mark_persistent(i8* %t292)
  %t294 = call i8* @sailfin_runtime_string_concat(i8* %t290, i8* %t292)
  call void @sailfin_runtime_mark_persistent(i8* %t294)
  ret i8* %t294
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
  %s18 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s18, i8** %l1
  store i64 1, i64* %l2
  %t19 = load i8, i8* %l0
  %t20 = load i8*, i8** %l1
  %t21 = load i64, i64* %l2
  br label %loop.header6
loop.header6:
  %t74 = phi i64 [ %t21, %merge5 ], [ %t72, %loop.latch8 ]
  %t75 = phi i8* [ %t20, %merge5 ], [ %t73, %loop.latch8 ]
  store i64 %t74, i64* %l2
  store i8* %t75, i8** %l1
  br label %loop.body7
loop.body7:
  %t22 = load i64, i64* %l2
  %t23 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t24 = sub i64 %t23, 1
  %t25 = icmp sge i64 %t22, %t24
  %t26 = load i8, i8* %l0
  %t27 = load i8*, i8** %l1
  %t28 = load i64, i64* %l2
  br i1 %t25, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t29 = load i64, i64* %l2
  %t30 = getelementptr i8, i8* %expression, i64 %t29
  %t31 = load i8, i8* %t30
  store i8 %t31, i8* %l3
  %t32 = load i8, i8* %l3
  %t33 = icmp eq i8 %t32, 92
  %t34 = load i8, i8* %l0
  %t35 = load i8*, i8** %l1
  %t36 = load i64, i64* %l2
  %t37 = load i8, i8* %l3
  br i1 %t33, label %then12, label %merge13
then12:
  %t38 = load i64, i64* %l2
  %t39 = add i64 %t38, 1
  store i64 %t39, i64* %l2
  %t40 = load i64, i64* %l2
  %t41 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t42 = sub i64 %t41, 1
  %t43 = icmp sge i64 %t40, %t42
  %t44 = load i8, i8* %l0
  %t45 = load i8*, i8** %l1
  %t46 = load i64, i64* %l2
  %t47 = load i8, i8* %l3
  br i1 %t43, label %then14, label %merge15
then14:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge15:
  %t48 = load i64, i64* %l2
  %t49 = getelementptr i8, i8* %expression, i64 %t48
  %t50 = load i8, i8* %t49
  store i8 %t50, i8* %l4
  %t51 = load i8*, i8** %l1
  %t52 = load i8, i8* %l4
  %t53 = load i8, i8* %l0
  %t54 = add i64 0, 2
  %t55 = call i8* @malloc(i64 %t54)
  store i8 %t52, i8* %t55
  %t56 = getelementptr i8, i8* %t55, i64 1
  store i8 0, i8* %t56
  call void @sailfin_runtime_mark_persistent(i8* %t55)
  %t57 = add i64 0, 2
  %t58 = call i8* @malloc(i64 %t57)
  store i8 %t53, i8* %t58
  %t59 = getelementptr i8, i8* %t58, i64 1
  store i8 0, i8* %t59
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  %t60 = call i8* @decode_escape_sequence(i8* %t55, i8* %t58)
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %t60)
  store i8* %t61, i8** %l1
  %t62 = load i64, i64* %l2
  %t63 = add i64 %t62, 1
  store i64 %t63, i64* %l2
  br label %loop.latch8
merge13:
  %t64 = load i8*, i8** %l1
  %t65 = load i8, i8* %l3
  %t66 = add i64 0, 2
  %t67 = call i8* @malloc(i64 %t66)
  store i8 %t65, i8* %t67
  %t68 = getelementptr i8, i8* %t67, i64 1
  store i8 0, i8* %t68
  call void @sailfin_runtime_mark_persistent(i8* %t67)
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %t67)
  store i8* %t69, i8** %l1
  %t70 = load i64, i64* %l2
  %t71 = add i64 %t70, 1
  store i64 %t71, i64* %l2
  br label %loop.latch8
loop.latch8:
  %t72 = load i64, i64* %l2
  %t73 = load i8*, i8** %l1
  br label %loop.header6
afterloop9:
  %t76 = load i64, i64* %l2
  %t77 = load i8*, i8** %l1
  %t78 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t78)
  ret i8* %t78
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
  %t102 = phi i8 [ %t0, %block.entry ], [ %t100, %loop.latch2 ]
  %t103 = phi i64 [ %t1, %block.entry ], [ %t101, %loop.latch2 ]
  store i8 %t102, i8* %l0
  store i64 %t103, i64* %l1
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
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480223, i32 0, i32 0
  %t17 = add i64 0, 2
  %t18 = call i8* @malloc(i64 %t17)
  store i8 %t15, i8* %t18
  %t19 = getelementptr i8, i8* %t18, i64 1
  store i8 0, i8* %t19
  call void @sailfin_runtime_mark_persistent(i8* %t18)
  %t20 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %s16)
  %t21 = load i8, i8* %t20
  store i8 %t21, i8* %l0
  %t22 = load i8, i8* %l0
  br label %merge8
else7:
  %t23 = load i8, i8* %l2
  %t24 = icmp eq i8 %t23, 39
  %t25 = load i8, i8* %l0
  %t26 = load i64, i64* %l1
  %t27 = load i8, i8* %l2
  br i1 %t24, label %then9, label %else10
then9:
  %t28 = load i8, i8* %l0
  %s29 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193478474, i32 0, i32 0
  %t30 = add i64 0, 2
  %t31 = call i8* @malloc(i64 %t30)
  store i8 %t28, i8* %t31
  %t32 = getelementptr i8, i8* %t31, i64 1
  store i8 0, i8* %t32
  call void @sailfin_runtime_mark_persistent(i8* %t31)
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %s29)
  %t34 = load i8, i8* %t33
  store i8 %t34, i8* %l0
  %t35 = load i8, i8* %l0
  br label %merge11
else10:
  %t36 = load i8, i8* %l2
  %t37 = icmp eq i8 %t36, 10
  %t38 = load i8, i8* %l0
  %t39 = load i64, i64* %l1
  %t40 = load i8, i8* %l2
  br i1 %t37, label %then12, label %else13
then12:
  %t41 = load i8, i8* %l0
  %s42 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480817, i32 0, i32 0
  %t43 = add i64 0, 2
  %t44 = call i8* @malloc(i64 %t43)
  store i8 %t41, i8* %t44
  %t45 = getelementptr i8, i8* %t44, i64 1
  store i8 0, i8* %t45
  call void @sailfin_runtime_mark_persistent(i8* %t44)
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %s42)
  %t47 = load i8, i8* %t46
  store i8 %t47, i8* %l0
  %t48 = load i8, i8* %l0
  br label %merge14
else13:
  %t49 = load i8, i8* %l2
  %t50 = icmp eq i8 %t49, 13
  %t51 = load i8, i8* %l0
  %t52 = load i64, i64* %l1
  %t53 = load i8, i8* %l2
  br i1 %t50, label %then15, label %else16
then15:
  %t54 = load i8, i8* %l0
  %s55 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480949, i32 0, i32 0
  %t56 = add i64 0, 2
  %t57 = call i8* @malloc(i64 %t56)
  store i8 %t54, i8* %t57
  %t58 = getelementptr i8, i8* %t57, i64 1
  store i8 0, i8* %t58
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %s55)
  %t60 = load i8, i8* %t59
  store i8 %t60, i8* %l0
  %t61 = load i8, i8* %l0
  br label %merge17
else16:
  %t62 = load i8, i8* %l2
  %t63 = icmp eq i8 %t62, 9
  %t64 = load i8, i8* %l0
  %t65 = load i64, i64* %l1
  %t66 = load i8, i8* %l2
  br i1 %t63, label %then18, label %else19
then18:
  %t67 = load i8, i8* %l0
  %s68 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193481015, i32 0, i32 0
  %t69 = add i64 0, 2
  %t70 = call i8* @malloc(i64 %t69)
  store i8 %t67, i8* %t70
  %t71 = getelementptr i8, i8* %t70, i64 1
  store i8 0, i8* %t71
  call void @sailfin_runtime_mark_persistent(i8* %t70)
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %s68)
  %t73 = load i8, i8* %t72
  store i8 %t73, i8* %l0
  %t74 = load i8, i8* %l0
  br label %merge20
else19:
  %t75 = load i8, i8* %l0
  %t76 = load i8, i8* %l2
  %t77 = add i8 %t75, %t76
  store i8 %t77, i8* %l0
  %t78 = load i8, i8* %l0
  br label %merge20
merge20:
  %t79 = phi i8 [ %t74, %then18 ], [ %t78, %else19 ]
  store i8 %t79, i8* %l0
  %t80 = load i8, i8* %l0
  %t81 = load i8, i8* %l0
  br label %merge17
merge17:
  %t82 = phi i8 [ %t61, %then15 ], [ %t80, %merge20 ]
  store i8 %t82, i8* %l0
  %t83 = load i8, i8* %l0
  %t84 = load i8, i8* %l0
  %t85 = load i8, i8* %l0
  br label %merge14
merge14:
  %t86 = phi i8 [ %t48, %then12 ], [ %t83, %merge17 ]
  store i8 %t86, i8* %l0
  %t87 = load i8, i8* %l0
  %t88 = load i8, i8* %l0
  %t89 = load i8, i8* %l0
  %t90 = load i8, i8* %l0
  br label %merge11
merge11:
  %t91 = phi i8 [ %t35, %then9 ], [ %t87, %merge14 ]
  store i8 %t91, i8* %l0
  %t92 = load i8, i8* %l0
  %t93 = load i8, i8* %l0
  %t94 = load i8, i8* %l0
  %t95 = load i8, i8* %l0
  %t96 = load i8, i8* %l0
  br label %merge8
merge8:
  %t97 = phi i8 [ %t22, %then6 ], [ %t92, %merge11 ]
  store i8 %t97, i8* %l0
  %t98 = load i64, i64* %l1
  %t99 = add i64 %t98, 1
  store i64 %t99, i64* %l1
  br label %loop.latch2
loop.latch2:
  %t100 = load i8, i8* %l0
  %t101 = load i64, i64* %l1
  br label %loop.header0
afterloop3:
  %t104 = load i8, i8* %l0
  %t105 = load i64, i64* %l1
  %t106 = load i8, i8* %l0
  %t107 = add i8 %t106, 39
  store i8 %t107, i8* %l0
  %t108 = load i8, i8* %l0
  %t109 = add i64 0, 2
  %t110 = call i8* @malloc(i64 %t109)
  store i8 %t108, i8* %t110
  %t111 = getelementptr i8, i8* %t110, i64 1
  store i8 0, i8* %t111
  call void @sailfin_runtime_mark_persistent(i8* %t110)
  call void @sailfin_runtime_mark_persistent(i8* %t110)
  ret i8* %t110
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
  %t206 = phi double [ %t75, %merge7 ], [ %t203, %loop.latch10 ]
  %t207 = phi { i8**, i64 }* [ %t73, %merge7 ], [ %t204, %loop.latch10 ]
  %t208 = phi { i8**, i64 }* [ %t74, %merge7 ], [ %t205, %loop.latch10 ]
  store double %t206, double* %l7
  store { i8**, i64 }* %t207, { i8**, i64 }** %l5
  store { i8**, i64 }* %t208, { i8**, i64 }** %l6
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
  %s188 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h728584192, i32 0, i32 0
  %t189 = load i8*, i8** %l13
  %t190 = call i8* @sailfin_runtime_string_concat(i8* %s188, i8* %t189)
  %s191 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t192 = call i8* @sailfin_runtime_string_concat(i8* %t190, i8* %s191)
  %t193 = load i8*, i8** %l12
  %t194 = call i8* @sailfin_runtime_string_concat(i8* %t192, i8* %t193)
  %t195 = add i64 0, 2
  %t196 = call i8* @malloc(i64 %t195)
  store i8 41, i8* %t196
  %t197 = getelementptr i8, i8* %t196, i64 1
  store i8 0, i8* %t197
  call void @sailfin_runtime_mark_persistent(i8* %t196)
  %t198 = call i8* @sailfin_runtime_string_concat(i8* %t194, i8* %t196)
  %t199 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t187, i8* %t198)
  store { i8**, i64 }* %t199, { i8**, i64 }** %l6
  %t200 = load double, double* %l7
  %t201 = sitofp i64 1 to double
  %t202 = fadd double %t200, %t201
  store double %t202, double* %l7
  br label %loop.latch10
loop.latch10:
  %t203 = load double, double* %l7
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t209 = load double, double* %l7
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t212 = load i8*, i8** %l2
  %t213 = call i8* @sanitize_qualified_identifier(i8* %t212)
  store i8* %t213, i8** %l14
  %t214 = sitofp i64 -1 to double
  store double %t214, double* %l15
  %t215 = sitofp i64 0 to double
  store double %t215, double* %l7
  %t216 = load double, double* %l0
  %t217 = load double, double* %l1
  %t218 = load i8*, i8** %l2
  %t219 = load i8*, i8** %l3
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t223 = load double, double* %l7
  %t224 = load i8*, i8** %l14
  %t225 = load double, double* %l15
  br label %loop.header20
loop.header20:
  %t264 = phi double [ %t225, %afterloop11 ], [ %t262, %loop.latch22 ]
  %t265 = phi double [ %t223, %afterloop11 ], [ %t263, %loop.latch22 ]
  store double %t264, double* %l15
  store double %t265, double* %l7
  br label %loop.body21
loop.body21:
  %t226 = load double, double* %l7
  %t227 = load i8*, i8** %l14
  %t228 = call i64 @sailfin_runtime_string_length(i8* %t227)
  %t229 = sitofp i64 %t228 to double
  %t230 = fcmp oge double %t226, %t229
  %t231 = load double, double* %l0
  %t232 = load double, double* %l1
  %t233 = load i8*, i8** %l2
  %t234 = load i8*, i8** %l3
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t238 = load double, double* %l7
  %t239 = load i8*, i8** %l14
  %t240 = load double, double* %l15
  br i1 %t230, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t241 = load i8*, i8** %l14
  %t242 = load double, double* %l7
  %t243 = call i8* @char_at(i8* %t241, double %t242)
  %t244 = load i8, i8* %t243
  %t245 = icmp eq i8 %t244, 46
  %t246 = load double, double* %l0
  %t247 = load double, double* %l1
  %t248 = load i8*, i8** %l2
  %t249 = load i8*, i8** %l3
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t253 = load double, double* %l7
  %t254 = load i8*, i8** %l14
  %t255 = load double, double* %l15
  br i1 %t245, label %then26, label %merge27
then26:
  %t256 = load double, double* %l7
  store double %t256, double* %l15
  %t257 = load double, double* %l15
  br label %merge27
merge27:
  %t258 = phi double [ %t257, %then26 ], [ %t255, %merge25 ]
  store double %t258, double* %l15
  %t259 = load double, double* %l7
  %t260 = sitofp i64 1 to double
  %t261 = fadd double %t259, %t260
  store double %t261, double* %l7
  br label %loop.latch22
loop.latch22:
  %t262 = load double, double* %l15
  %t263 = load double, double* %l7
  br label %loop.header20
afterloop23:
  %t266 = load double, double* %l15
  %t267 = load double, double* %l7
  %t268 = load double, double* %l15
  %t269 = sitofp i64 0 to double
  %t270 = fcmp oge double %t268, %t269
  %t271 = load double, double* %l0
  %t272 = load double, double* %l1
  %t273 = load i8*, i8** %l2
  %t274 = load i8*, i8** %l3
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t278 = load double, double* %l7
  %t279 = load i8*, i8** %l14
  %t280 = load double, double* %l15
  br i1 %t270, label %then28, label %merge29
then28:
  %t281 = load i8*, i8** %l14
  %t282 = load double, double* %l15
  %t283 = call double @llvm.round.f64(double %t282)
  %t284 = fptosi double %t283 to i64
  %t285 = call i8* @sailfin_runtime_substring(i8* %t281, i64 0, i64 %t284)
  store i8* %t285, i8** %l16
  %t286 = load i8*, i8** %l14
  %t287 = load double, double* %l15
  %t288 = sitofp i64 1 to double
  %t289 = fadd double %t287, %t288
  %t290 = load i8*, i8** %l14
  %t291 = call i64 @sailfin_runtime_string_length(i8* %t290)
  %t292 = call double @llvm.round.f64(double %t289)
  %t293 = fptosi double %t292 to i64
  %t294 = call i8* @sailfin_runtime_substring(i8* %t286, i64 %t293, i64 %t291)
  store i8* %t294, i8** %l17
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s296 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t297 = call i8* @join_with_separator({ i8**, i64 }* %t295, i8* %s296)
  %t298 = add i64 0, 2
  %t299 = call i8* @malloc(i64 %t298)
  store i8 91, i8* %t299
  %t300 = getelementptr i8, i8* %t299, i64 1
  store i8 0, i8* %t300
  call void @sailfin_runtime_mark_persistent(i8* %t299)
  %t301 = call i8* @sailfin_runtime_string_concat(i8* %t299, i8* %t297)
  %t302 = add i64 0, 2
  %t303 = call i8* @malloc(i64 %t302)
  store i8 93, i8* %t303
  %t304 = getelementptr i8, i8* %t303, i64 1
  store i8 0, i8* %t304
  call void @sailfin_runtime_mark_persistent(i8* %t303)
  %t305 = call i8* @sailfin_runtime_string_concat(i8* %t301, i8* %t303)
  store i8* %t305, i8** %l18
  %s306 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h117462910, i32 0, i32 0
  %t307 = load i8*, i8** %l16
  %t308 = call i8* @sailfin_runtime_string_concat(i8* %s306, i8* %t307)
  %s309 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t310 = call i8* @sailfin_runtime_string_concat(i8* %t308, i8* %s309)
  %t311 = load i8*, i8** %l17
  %t312 = call i8* @sailfin_runtime_string_concat(i8* %t310, i8* %t311)
  %s313 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t314 = call i8* @sailfin_runtime_string_concat(i8* %t312, i8* %s313)
  %t315 = load i8*, i8** %l18
  %t316 = call i8* @sailfin_runtime_string_concat(i8* %t314, i8* %t315)
  %t317 = add i64 0, 2
  %t318 = call i8* @malloc(i64 %t317)
  store i8 41, i8* %t318
  %t319 = getelementptr i8, i8* %t318, i64 1
  store i8 0, i8* %t319
  call void @sailfin_runtime_mark_persistent(i8* %t318)
  %t320 = call i8* @sailfin_runtime_string_concat(i8* %t316, i8* %t318)
  call void @sailfin_runtime_mark_persistent(i8* %t320)
  ret i8* %t320
merge29:
  %t321 = load i8*, i8** %l14
  %t322 = add i64 0, 2
  %t323 = call i8* @malloc(i64 %t322)
  store i8 40, i8* %t323
  %t324 = getelementptr i8, i8* %t323, i64 1
  store i8 0, i8* %t324
  call void @sailfin_runtime_mark_persistent(i8* %t323)
  %t325 = call i8* @sailfin_runtime_string_concat(i8* %t321, i8* %t323)
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s327 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t328 = call i8* @join_with_separator({ i8**, i64 }* %t326, i8* %s327)
  %t329 = call i8* @sailfin_runtime_string_concat(i8* %t325, i8* %t328)
  %t330 = add i64 0, 2
  %t331 = call i8* @malloc(i64 %t330)
  store i8 41, i8* %t331
  %t332 = getelementptr i8, i8* %t331, i64 1
  store i8 0, i8* %t332
  call void @sailfin_runtime_mark_persistent(i8* %t331)
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %t329, i8* %t331)
  call void @sailfin_runtime_mark_persistent(i8* %t333)
  ret i8* %t333
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
  %s110 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479167, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s110)
  ret i8* %s110
merge15:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %s112 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t113 = call i8* @join_with_separator({ i8**, i64 }* %t111, i8* %s112)
  store i8* %t113, i8** %l7
  %t114 = load i8*, i8** %l7
  %t115 = add i64 0, 2
  %t116 = call i8* @malloc(i64 %t115)
  store i8 91, i8* %t116
  %t117 = getelementptr i8, i8* %t116, i64 1
  store i8 0, i8* %t117
  call void @sailfin_runtime_mark_persistent(i8* %t116)
  %t118 = call i8* @sailfin_runtime_string_concat(i8* %t116, i8* %t114)
  %t119 = add i64 0, 2
  %t120 = call i8* @malloc(i64 %t119)
  store i8 93, i8* %t120
  %t121 = getelementptr i8, i8* %t120, i64 1
  store i8 0, i8* %t121
  call void @sailfin_runtime_mark_persistent(i8* %t120)
  %t122 = call i8* @sailfin_runtime_string_concat(i8* %t118, i8* %t120)
  call void @sailfin_runtime_mark_persistent(i8* %t122)
  ret i8* %t122
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
  %s6 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h757580446, i32 0, i32 0
  %t7 = call i1 @starts_with(i8* %t5, i8* %s6)
  %t8 = xor i1 %t7, 1
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t10 = load i8*, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = call i64 @sailfin_runtime_string_length(i8* %t11)
  %t13 = call i8* @sailfin_runtime_substring(i8* %t10, i64 9, i64 %t12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l1
  %t15 = load i8*, i8** %l1
  %t16 = call i64 @sailfin_runtime_string_length(i8* %t15)
  %t17 = icmp sgt i64 %t16, 0
  ret i1 %t17
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
  %t170 = phi i8* [ %t31, %merge3 ], [ %t166, %loop.latch6 ]
  %t171 = phi double [ %t34, %merge3 ], [ %t167, %loop.latch6 ]
  %t172 = phi double [ %t33, %merge3 ], [ %t168, %loop.latch6 ]
  %t173 = phi double [ %t32, %merge3 ], [ %t169, %loop.latch6 ]
  store i8* %t170, i8** %l1
  store double %t171, double* %l4
  store double %t172, double* %l3
  store double %t173, double* %l2
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
  %s108 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t109 = call i1 @strings_equal(i8* %t107, i8* %s108)
  %t110 = xor i1 %t109, true
  %t111 = load i8*, i8** %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  %t114 = load double, double* %l3
  %t115 = load double, double* %l4
  %t116 = load %NativeInstruction, %NativeInstruction* %l5
  br i1 %t110, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t117 = load %NativeInstruction, %NativeInstruction* %l5
  %t118 = extractvalue %NativeInstruction %t117, 0
  %t119 = alloca %NativeInstruction
  store %NativeInstruction %t117, %NativeInstruction* %t119
  %t120 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t121 = bitcast [8 x i8]* %t120 to i8*
  %t122 = bitcast i8* %t121 to i8**
  %t123 = load i8*, i8** %t122
  %t124 = icmp eq i32 %t118, 16
  %t125 = select i1 %t124, i8* %t123, i8* null
  %t126 = call i8* @trim_text(i8* %t125)
  store i8* %t126, i8** %l6
  %t127 = load i8*, i8** %l6
  %t128 = call i64 @sailfin_runtime_string_length(i8* %t127)
  %t129 = icmp sgt i64 %t128, 0
  %t130 = load i8*, i8** %l0
  %t131 = load i8*, i8** %l1
  %t132 = load double, double* %l2
  %t133 = load double, double* %l3
  %t134 = load double, double* %l4
  %t135 = load %NativeInstruction, %NativeInstruction* %l5
  %t136 = load i8*, i8** %l6
  br i1 %t129, label %then12, label %merge13
then12:
  %t137 = load i8*, i8** %l1
  %t138 = add i64 0, 2
  %t139 = call i8* @malloc(i64 %t138)
  store i8 32, i8* %t139
  %t140 = getelementptr i8, i8* %t139, i64 1
  store i8 0, i8* %t140
  call void @sailfin_runtime_mark_persistent(i8* %t139)
  %t141 = call i8* @sailfin_runtime_string_concat(i8* %t137, i8* %t139)
  %t142 = load i8*, i8** %l6
  %t143 = call i8* @sailfin_runtime_string_concat(i8* %t141, i8* %t142)
  store i8* %t143, i8** %l1
  %t144 = load i8*, i8** %l1
  br label %merge13
merge13:
  %t145 = phi i8* [ %t144, %then12 ], [ %t131, %merge11 ]
  store i8* %t145, i8** %l1
  %t146 = load double, double* %l4
  %t147 = load i8*, i8** %l6
  %t148 = call double @compute_brace_balance(i8* %t147)
  %t149 = fadd double %t146, %t148
  store double %t149, double* %l4
  %t150 = load double, double* %l3
  %t151 = sitofp i64 1 to double
  %t152 = fadd double %t150, %t151
  store double %t152, double* %l3
  %t153 = load double, double* %l2
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  store double %t155, double* %l2
  %t156 = load double, double* %l4
  %t157 = sitofp i64 0 to double
  %t158 = fcmp ole double %t156, %t157
  %t159 = load i8*, i8** %l0
  %t160 = load i8*, i8** %l1
  %t161 = load double, double* %l2
  %t162 = load double, double* %l3
  %t163 = load double, double* %l4
  %t164 = load %NativeInstruction, %NativeInstruction* %l5
  %t165 = load i8*, i8** %l6
  br i1 %t158, label %then14, label %merge15
then14:
  br label %afterloop7
merge15:
  br label %loop.latch6
loop.latch6:
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l4
  %t168 = load double, double* %l3
  %t169 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t174 = load i8*, i8** %l1
  %t175 = load double, double* %l4
  %t176 = load double, double* %l3
  %t177 = load double, double* %l2
  %t178 = load double, double* %l4
  %t179 = sitofp i64 0 to double
  %t180 = fcmp une double %t178, %t179
  %t181 = load i8*, i8** %l0
  %t182 = load i8*, i8** %l1
  %t183 = load double, double* %l2
  %t184 = load double, double* %l3
  %t185 = load double, double* %l4
  br i1 %t180, label %then16, label %merge17
then16:
  %t186 = load i8*, i8** %l0
  %t187 = insertvalue %StructLiteralCapture undef, i8* %t186, 0
  %t188 = sitofp i64 0 to double
  %t189 = insertvalue %StructLiteralCapture %t187, double %t188, 1
  %t190 = insertvalue %StructLiteralCapture %t189, i1 0, 2
  ret %StructLiteralCapture %t190
merge17:
  %t191 = load double, double* %l3
  %t192 = sitofp i64 0 to double
  %t193 = fcmp oeq double %t191, %t192
  %t194 = load i8*, i8** %l0
  %t195 = load i8*, i8** %l1
  %t196 = load double, double* %l2
  %t197 = load double, double* %l3
  %t198 = load double, double* %l4
  br i1 %t193, label %then18, label %merge19
then18:
  %t199 = load i8*, i8** %l0
  %t200 = insertvalue %StructLiteralCapture undef, i8* %t199, 0
  %t201 = sitofp i64 0 to double
  %t202 = insertvalue %StructLiteralCapture %t200, double %t201, 1
  %t203 = insertvalue %StructLiteralCapture %t202, i1 0, 2
  ret %StructLiteralCapture %t203
merge19:
  %t204 = load i8*, i8** %l1
  %t205 = call i8* @trim_text(i8* %t204)
  %t206 = call i8* @trim_trailing_delimiters(i8* %t205)
  store i8* %t206, i8** %l7
  %t207 = load i8*, i8** %l7
  %t208 = add i64 0, 2
  %t209 = call i8* @malloc(i64 %t208)
  store i8 125, i8* %t209
  %t210 = getelementptr i8, i8* %t209, i64 1
  store i8 0, i8* %t210
  call void @sailfin_runtime_mark_persistent(i8* %t209)
  %t211 = call i1 @ends_with(i8* %t207, i8* %t209)
  %t212 = xor i1 %t211, 1
  %t213 = load i8*, i8** %l0
  %t214 = load i8*, i8** %l1
  %t215 = load double, double* %l2
  %t216 = load double, double* %l3
  %t217 = load double, double* %l4
  %t218 = load i8*, i8** %l7
  br i1 %t212, label %then20, label %merge21
then20:
  %t219 = load i8*, i8** %l0
  %t220 = insertvalue %StructLiteralCapture undef, i8* %t219, 0
  %t221 = sitofp i64 0 to double
  %t222 = insertvalue %StructLiteralCapture %t220, double %t221, 1
  %t223 = insertvalue %StructLiteralCapture %t222, i1 0, 2
  ret %StructLiteralCapture %t223
merge21:
  %t224 = load i8*, i8** %l7
  %t225 = insertvalue %StructLiteralCapture undef, i8* %t224, 0
  %t226 = load double, double* %l3
  %t227 = insertvalue %StructLiteralCapture %t225, double %t226, 1
  %t228 = insertvalue %StructLiteralCapture %t227, i1 1, 2
  ret %StructLiteralCapture %t228
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t195 = phi i8* [ %t4, %merge1 ], [ %t193, %loop.latch4 ]
  %t196 = phi double [ %t5, %merge1 ], [ %t194, %loop.latch4 ]
  store i8* %t195, i8** %l0
  store double %t196, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  %t16 = call double @llvm.round.f64(double %t12)
  %t17 = fptosi double %t16 to i64
  %t18 = call double @llvm.round.f64(double %t15)
  %t19 = fptosi double %t18 to i64
  %t20 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t17, i64 %t19)
  store i8* %t20, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 39
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t24, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t25 = load i8*, i8** %l2
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 34
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t28 = phi i1 [ true, %logical_or_entry_21 ], [ %t27, %logical_or_right_end_21 ]
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then8, label %merge9
then8:
  %t32 = load double, double* %l1
  %t33 = call double @skip_string_literal(i8* %expression, double %t32)
  store double %t33, double* %l3
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l3
  %t37 = call double @llvm.round.f64(double %t35)
  %t38 = fptosi double %t37 to i64
  %t39 = call double @llvm.round.f64(double %t36)
  %t40 = fptosi double %t39 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t38, i64 %t40)
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t41)
  store i8* %t42, i8** %l0
  %t43 = load double, double* %l3
  store double %t43, double* %l1
  br label %loop.latch4
merge9:
  %t44 = load i8*, i8** %l2
  %t45 = load i8, i8* %t44
  %t46 = icmp eq i8 %t45, 38
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load i8*, i8** %l2
  br i1 %t46, label %then10, label %merge11
then10:
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  %t53 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t54 = sitofp i64 %t53 to double
  %t55 = fcmp olt double %t52, %t54
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l1
  %t58 = load i8*, i8** %l2
  br i1 %t55, label %then12, label %merge13
then12:
  %t59 = load double, double* %l1
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  %t62 = load double, double* %l1
  %t63 = sitofp i64 2 to double
  %t64 = fadd double %t62, %t63
  %t65 = call double @llvm.round.f64(double %t61)
  %t66 = fptosi double %t65 to i64
  %t67 = call double @llvm.round.f64(double %t64)
  %t68 = fptosi double %t67 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t66, i64 %t68)
  store i8* %t69, i8** %l4
  %t70 = load i8*, i8** %l4
  %t71 = load i8, i8* %t70
  %t72 = icmp eq i8 %t71, 38
  %t73 = load i8*, i8** %l0
  %t74 = load double, double* %l1
  %t75 = load i8*, i8** %l2
  %t76 = load i8*, i8** %l4
  br i1 %t72, label %then14, label %merge15
then14:
  %t77 = load i8*, i8** %l0
  %s78 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1503489441, i32 0, i32 0
  %t79 = call i8* @sailfin_runtime_string_concat(i8* %t77, i8* %s78)
  store i8* %t79, i8** %l0
  %t80 = load double, double* %l1
  %t81 = sitofp i64 2 to double
  %t82 = fadd double %t80, %t81
  store double %t82, double* %l1
  br label %loop.latch4
merge15:
  %t83 = load i8*, i8** %l0
  %t84 = load double, double* %l1
  br label %merge13
merge13:
  %t85 = phi i8* [ %t83, %merge15 ], [ %t56, %then10 ]
  %t86 = phi double [ %t84, %merge15 ], [ %t57, %then10 ]
  store i8* %t85, i8** %l0
  store double %t86, double* %l1
  %t87 = load i8*, i8** %l0
  %t88 = load double, double* %l1
  br label %merge11
merge11:
  %t89 = phi i8* [ %t87, %merge13 ], [ %t47, %merge9 ]
  %t90 = phi double [ %t88, %merge13 ], [ %t48, %merge9 ]
  store i8* %t89, i8** %l0
  store double %t90, double* %l1
  %t91 = load i8*, i8** %l2
  %t92 = load i8, i8* %t91
  %t93 = icmp eq i8 %t92, 124
  %t94 = load i8*, i8** %l0
  %t95 = load double, double* %l1
  %t96 = load i8*, i8** %l2
  br i1 %t93, label %then16, label %merge17
then16:
  %t97 = load double, double* %l1
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %t97, %t98
  %t100 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t101 = sitofp i64 %t100 to double
  %t102 = fcmp olt double %t99, %t101
  %t103 = load i8*, i8** %l0
  %t104 = load double, double* %l1
  %t105 = load i8*, i8** %l2
  br i1 %t102, label %then18, label %merge19
then18:
  %t106 = load double, double* %l1
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  %t109 = load double, double* %l1
  %t110 = sitofp i64 2 to double
  %t111 = fadd double %t109, %t110
  %t112 = call double @llvm.round.f64(double %t108)
  %t113 = fptosi double %t112 to i64
  %t114 = call double @llvm.round.f64(double %t111)
  %t115 = fptosi double %t114 to i64
  %t116 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t113, i64 %t115)
  store i8* %t116, i8** %l5
  %t117 = load i8*, i8** %l5
  %t118 = load i8, i8* %t117
  %t119 = icmp eq i8 %t118, 124
  %t120 = load i8*, i8** %l0
  %t121 = load double, double* %l1
  %t122 = load i8*, i8** %l2
  %t123 = load i8*, i8** %l5
  br i1 %t119, label %then20, label %merge21
then20:
  %t124 = load i8*, i8** %l0
  %s125 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h176216012, i32 0, i32 0
  %t126 = call i8* @sailfin_runtime_string_concat(i8* %t124, i8* %s125)
  store i8* %t126, i8** %l0
  %t127 = load double, double* %l1
  %t128 = sitofp i64 2 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l1
  br label %loop.latch4
merge21:
  %t130 = load i8*, i8** %l0
  %t131 = load double, double* %l1
  br label %merge19
merge19:
  %t132 = phi i8* [ %t130, %merge21 ], [ %t103, %then16 ]
  %t133 = phi double [ %t131, %merge21 ], [ %t104, %then16 ]
  store i8* %t132, i8** %l0
  store double %t133, double* %l1
  %t134 = load i8*, i8** %l0
  %t135 = load double, double* %l1
  br label %merge17
merge17:
  %t136 = phi i8* [ %t134, %merge19 ], [ %t94, %merge11 ]
  %t137 = phi double [ %t135, %merge19 ], [ %t95, %merge11 ]
  store i8* %t136, i8** %l0
  store double %t137, double* %l1
  %t138 = load i8*, i8** %l2
  %t139 = load i8, i8* %t138
  %t140 = icmp eq i8 %t139, 33
  %t141 = load i8*, i8** %l0
  %t142 = load double, double* %l1
  %t143 = load i8*, i8** %l2
  br i1 %t140, label %then22, label %merge23
then22:
  %t144 = load double, double* %l1
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  %t147 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t148 = sitofp i64 %t147 to double
  %t149 = fcmp olt double %t146, %t148
  %t150 = load i8*, i8** %l0
  %t151 = load double, double* %l1
  %t152 = load i8*, i8** %l2
  br i1 %t149, label %then24, label %merge25
then24:
  %t153 = load double, double* %l1
  %t154 = sitofp i64 1 to double
  %t155 = fadd double %t153, %t154
  %t156 = load double, double* %l1
  %t157 = sitofp i64 2 to double
  %t158 = fadd double %t156, %t157
  %t159 = call double @llvm.round.f64(double %t155)
  %t160 = fptosi double %t159 to i64
  %t161 = call double @llvm.round.f64(double %t158)
  %t162 = fptosi double %t161 to i64
  %t163 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t160, i64 %t162)
  store i8* %t163, i8** %l6
  %t164 = load i8*, i8** %l6
  %t165 = load i8, i8* %t164
  %t166 = icmp eq i8 %t165, 61
  %t167 = load i8*, i8** %l0
  %t168 = load double, double* %l1
  %t169 = load i8*, i8** %l2
  %t170 = load i8*, i8** %l6
  br i1 %t166, label %then26, label %merge27
then26:
  %t171 = load i8*, i8** %l0
  %s172 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193414949, i32 0, i32 0
  %t173 = call i8* @sailfin_runtime_string_concat(i8* %t171, i8* %s172)
  store i8* %t173, i8** %l0
  %t174 = load double, double* %l1
  %t175 = sitofp i64 2 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l1
  br label %loop.latch4
merge27:
  %t177 = load i8*, i8** %l0
  %t178 = load double, double* %l1
  br label %merge25
merge25:
  %t179 = phi i8* [ %t177, %merge27 ], [ %t150, %then22 ]
  %t180 = phi double [ %t178, %merge27 ], [ %t151, %then22 ]
  store i8* %t179, i8** %l0
  store double %t180, double* %l1
  %t181 = load i8*, i8** %l0
  %s182 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268720028, i32 0, i32 0
  %t183 = call i8* @sailfin_runtime_string_concat(i8* %t181, i8* %s182)
  store i8* %t183, i8** %l0
  %t184 = load double, double* %l1
  %t185 = sitofp i64 1 to double
  %t186 = fadd double %t184, %t185
  store double %t186, double* %l1
  br label %loop.latch4
merge23:
  %t187 = load i8*, i8** %l0
  %t188 = load i8*, i8** %l2
  %t189 = call i8* @sailfin_runtime_string_concat(i8* %t187, i8* %t188)
  store i8* %t189, i8** %l0
  %t190 = load double, double* %l1
  %t191 = sitofp i64 1 to double
  %t192 = fadd double %t190, %t191
  store double %t192, double* %l1
  br label %loop.latch4
loop.latch4:
  %t193 = load i8*, i8** %l0
  %t194 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t197 = load i8*, i8** %l0
  %t198 = load double, double* %l1
  %t199 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t199)
  ret i8* %t199
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t148 = phi i8* [ %t4, %merge1 ], [ %t146, %loop.latch4 ]
  %t149 = phi double [ %t5, %merge1 ], [ %t147, %loop.latch4 ]
  store i8* %t148, i8** %l0
  store double %t149, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = load double, double* %l1
  %t14 = sitofp i64 1 to double
  %t15 = fadd double %t13, %t14
  %t16 = call double @llvm.round.f64(double %t12)
  %t17 = fptosi double %t16 to i64
  %t18 = call double @llvm.round.f64(double %t15)
  %t19 = fptosi double %t18 to i64
  %t20 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t17, i64 %t19)
  store i8* %t20, i8** %l2
  %t22 = load i8*, i8** %l2
  %t23 = load i8, i8* %t22
  %t24 = icmp eq i8 %t23, 39
  br label %logical_or_entry_21

logical_or_entry_21:
  br i1 %t24, label %logical_or_merge_21, label %logical_or_right_21

logical_or_right_21:
  %t25 = load i8*, i8** %l2
  %t26 = load i8, i8* %t25
  %t27 = icmp eq i8 %t26, 34
  br label %logical_or_right_end_21

logical_or_right_end_21:
  br label %logical_or_merge_21

logical_or_merge_21:
  %t28 = phi i1 [ true, %logical_or_entry_21 ], [ %t27, %logical_or_right_end_21 ]
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = load i8*, i8** %l2
  br i1 %t28, label %then8, label %merge9
then8:
  %t32 = load double, double* %l1
  %t33 = call double @skip_string_literal(i8* %expression, double %t32)
  store double %t33, double* %l3
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l3
  %t37 = call double @llvm.round.f64(double %t35)
  %t38 = fptosi double %t37 to i64
  %t39 = call double @llvm.round.f64(double %t36)
  %t40 = fptosi double %t39 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t38, i64 %t40)
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %t41)
  store i8* %t42, i8** %l0
  %t43 = load double, double* %l3
  store double %t43, double* %l1
  br label %loop.latch4
merge9:
  %t44 = load i8*, i8** %l2
  %t45 = call i1 @is_identifier_char(i8* %t44)
  %t46 = load i8*, i8** %l0
  %t47 = load double, double* %l1
  %t48 = load i8*, i8** %l2
  br i1 %t45, label %then10, label %merge11
then10:
  %t49 = load double, double* %l1
  store double %t49, double* %l4
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  %t52 = load i8*, i8** %l2
  %t53 = load double, double* %l4
  br label %loop.header12
loop.header12:
  %t83 = phi double [ %t51, %then10 ], [ %t82, %loop.latch14 ]
  store double %t83, double* %l1
  br label %loop.body13
loop.body13:
  %t54 = load double, double* %l1
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l1
  %t57 = load double, double* %l1
  %t58 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t59 = sitofp i64 %t58 to double
  %t60 = fcmp oge double %t57, %t59
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l1
  %t63 = load i8*, i8** %l2
  %t64 = load double, double* %l4
  br i1 %t60, label %then16, label %merge17
then16:
  br label %afterloop15
merge17:
  %t65 = load double, double* %l1
  %t66 = load double, double* %l1
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  %t69 = call double @llvm.round.f64(double %t65)
  %t70 = fptosi double %t69 to i64
  %t71 = call double @llvm.round.f64(double %t68)
  %t72 = fptosi double %t71 to i64
  %t73 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t70, i64 %t72)
  store i8* %t73, i8** %l5
  %t74 = load i8*, i8** %l5
  %t75 = call i1 @is_identifier_char(i8* %t74)
  %t76 = xor i1 %t75, 1
  %t77 = load i8*, i8** %l0
  %t78 = load double, double* %l1
  %t79 = load i8*, i8** %l2
  %t80 = load double, double* %l4
  %t81 = load i8*, i8** %l5
  br i1 %t76, label %then18, label %merge19
then18:
  br label %afterloop15
merge19:
  br label %loop.latch14
loop.latch14:
  %t82 = load double, double* %l1
  br label %loop.header12
afterloop15:
  %t84 = load double, double* %l1
  %t85 = load double, double* %l4
  %t86 = load double, double* %l1
  %t87 = call double @llvm.round.f64(double %t85)
  %t88 = fptosi double %t87 to i64
  %t89 = call double @llvm.round.f64(double %t86)
  %t90 = fptosi double %t89 to i64
  %t91 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t88, i64 %t90)
  store i8* %t91, i8** %l6
  %t92 = load i8*, i8** %l6
  %s93 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268929446, i32 0, i32 0
  %t94 = call i1 @strings_equal(i8* %t92, i8* %s93)
  %t95 = load i8*, i8** %l0
  %t96 = load double, double* %l1
  %t97 = load i8*, i8** %l2
  %t98 = load double, double* %l4
  %t99 = load i8*, i8** %l6
  br i1 %t94, label %then20, label %else21
then20:
  %t100 = load i8*, i8** %l0
  %s101 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t102 = call i8* @sailfin_runtime_string_concat(i8* %t100, i8* %s101)
  store i8* %t102, i8** %l0
  %t103 = load i8*, i8** %l0
  br label %merge22
else21:
  %t104 = load i8*, i8** %l6
  %s105 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275946731, i32 0, i32 0
  %t106 = call i1 @strings_equal(i8* %t104, i8* %s105)
  %t107 = load i8*, i8** %l0
  %t108 = load double, double* %l1
  %t109 = load i8*, i8** %l2
  %t110 = load double, double* %l4
  %t111 = load i8*, i8** %l6
  br i1 %t106, label %then23, label %else24
then23:
  %t112 = load i8*, i8** %l0
  %s113 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h237997259, i32 0, i32 0
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %s113)
  store i8* %t114, i8** %l0
  %t115 = load i8*, i8** %l0
  br label %merge25
else24:
  %t116 = load i8*, i8** %l6
  %s117 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2095430042, i32 0, i32 0
  %t118 = call i1 @strings_equal(i8* %t116, i8* %s117)
  %t119 = load i8*, i8** %l0
  %t120 = load double, double* %l1
  %t121 = load i8*, i8** %l2
  %t122 = load double, double* %l4
  %t123 = load i8*, i8** %l6
  br i1 %t118, label %then26, label %else27
then26:
  %t124 = load i8*, i8** %l0
  %s125 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h843097466, i32 0, i32 0
  %t126 = call i8* @sailfin_runtime_string_concat(i8* %t124, i8* %s125)
  store i8* %t126, i8** %l0
  %t127 = load i8*, i8** %l0
  br label %merge28
else27:
  %t128 = load i8*, i8** %l0
  %t129 = load i8*, i8** %l6
  %t130 = call i8* @sailfin_runtime_string_concat(i8* %t128, i8* %t129)
  store i8* %t130, i8** %l0
  %t131 = load i8*, i8** %l0
  br label %merge28
merge28:
  %t132 = phi i8* [ %t127, %then26 ], [ %t131, %else27 ]
  store i8* %t132, i8** %l0
  %t133 = load i8*, i8** %l0
  %t134 = load i8*, i8** %l0
  br label %merge25
merge25:
  %t135 = phi i8* [ %t115, %then23 ], [ %t133, %merge28 ]
  store i8* %t135, i8** %l0
  %t136 = load i8*, i8** %l0
  %t137 = load i8*, i8** %l0
  %t138 = load i8*, i8** %l0
  br label %merge22
merge22:
  %t139 = phi i8* [ %t103, %then20 ], [ %t136, %merge25 ]
  store i8* %t139, i8** %l0
  br label %loop.latch4
merge11:
  %t140 = load i8*, i8** %l0
  %t141 = load i8*, i8** %l2
  %t142 = call i8* @sailfin_runtime_string_concat(i8* %t140, i8* %t141)
  store i8* %t142, i8** %l0
  %t143 = load double, double* %l1
  %t144 = sitofp i64 1 to double
  %t145 = fadd double %t143, %t144
  store double %t145, double* %l1
  br label %loop.latch4
loop.latch4:
  %t146 = load i8*, i8** %l0
  %t147 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t150 = load i8*, i8** %l0
  %t151 = load double, double* %l1
  %t152 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t152)
  ret i8* %t152
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
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1719661028, i32 0, i32 0
  store i8* %s2, i8** %l0
  %s3 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h645367897, i32 0, i32 0
  store i8* %s3, i8** %l1
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s4, i8** %l2
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l3
  %t6 = load i8*, i8** %l0
  %t7 = load i8*, i8** %l1
  %t8 = load i8*, i8** %l2
  %t9 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t105 = phi i8* [ %t8, %merge1 ], [ %t103, %loop.latch4 ]
  %t106 = phi double [ %t9, %merge1 ], [ %t104, %loop.latch4 ]
  store i8* %t105, i8** %l2
  store double %t106, double* %l3
  br label %loop.body3
loop.body3:
  %t10 = load double, double* %l3
  %t11 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t12 = sitofp i64 %t11 to double
  %t13 = fcmp oge double %t10, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load i8*, i8** %l2
  %t17 = load double, double* %l3
  br i1 %t13, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t18 = load double, double* %l3
  %t19 = load double, double* %l3
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  %t22 = call double @llvm.round.f64(double %t18)
  %t23 = fptosi double %t22 to i64
  %t24 = call double @llvm.round.f64(double %t21)
  %t25 = fptosi double %t24 to i64
  %t26 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t23, i64 %t25)
  store i8* %t26, i8** %l4
  %t28 = load i8*, i8** %l4
  %t29 = load i8, i8* %t28
  %t30 = icmp eq i8 %t29, 39
  br label %logical_or_entry_27

logical_or_entry_27:
  br i1 %t30, label %logical_or_merge_27, label %logical_or_right_27

logical_or_right_27:
  %t31 = load i8*, i8** %l4
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 34
  br label %logical_or_right_end_27

logical_or_right_end_27:
  br label %logical_or_merge_27

logical_or_merge_27:
  %t34 = phi i1 [ true, %logical_or_entry_27 ], [ %t33, %logical_or_right_end_27 ]
  %t35 = load i8*, i8** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load i8*, i8** %l2
  %t38 = load double, double* %l3
  %t39 = load i8*, i8** %l4
  br i1 %t34, label %then8, label %merge9
then8:
  %t40 = load double, double* %l3
  %t41 = call double @skip_string_literal(i8* %expression, double %t40)
  store double %t41, double* %l5
  %t42 = load i8*, i8** %l2
  %t43 = load double, double* %l3
  %t44 = load double, double* %l5
  %t45 = call double @llvm.round.f64(double %t43)
  %t46 = fptosi double %t45 to i64
  %t47 = call double @llvm.round.f64(double %t44)
  %t48 = fptosi double %t47 to i64
  %t49 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t46, i64 %t48)
  %t50 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t49)
  store i8* %t50, i8** %l2
  %t51 = load double, double* %l5
  store double %t51, double* %l3
  br label %loop.latch4
merge9:
  %t52 = load double, double* %l3
  %t53 = load i8*, i8** %l0
  %t54 = call i64 @sailfin_runtime_string_length(i8* %t53)
  %t55 = sitofp i64 %t54 to double
  %t56 = fadd double %t52, %t55
  %t57 = call i64 @sailfin_runtime_string_length(i8* %expression)
  %t58 = sitofp i64 %t57 to double
  %t59 = fcmp ole double %t56, %t58
  %t60 = load i8*, i8** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load i8*, i8** %l2
  %t63 = load double, double* %l3
  %t64 = load i8*, i8** %l4
  br i1 %t59, label %then10, label %merge11
then10:
  %t65 = load double, double* %l3
  %t66 = load double, double* %l3
  %t67 = load i8*, i8** %l0
  %t68 = call i64 @sailfin_runtime_string_length(i8* %t67)
  %t69 = sitofp i64 %t68 to double
  %t70 = fadd double %t66, %t69
  %t71 = call double @llvm.round.f64(double %t65)
  %t72 = fptosi double %t71 to i64
  %t73 = call double @llvm.round.f64(double %t70)
  %t74 = fptosi double %t73 to i64
  %t75 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t72, i64 %t74)
  store i8* %t75, i8** %l6
  %t76 = load i8*, i8** %l6
  %t77 = load i8*, i8** %l0
  %t78 = call i1 @strings_equal(i8* %t76, i8* %t77)
  %t79 = load i8*, i8** %l0
  %t80 = load i8*, i8** %l1
  %t81 = load i8*, i8** %l2
  %t82 = load double, double* %l3
  %t83 = load i8*, i8** %l4
  %t84 = load i8*, i8** %l6
  br i1 %t78, label %then12, label %merge13
then12:
  %t85 = load i8*, i8** %l2
  %t86 = load i8*, i8** %l1
  %t87 = call i8* @sailfin_runtime_string_concat(i8* %t85, i8* %t86)
  store i8* %t87, i8** %l2
  %t88 = load double, double* %l3
  %t89 = load i8*, i8** %l0
  %t90 = call i64 @sailfin_runtime_string_length(i8* %t89)
  %t91 = sitofp i64 %t90 to double
  %t92 = fadd double %t88, %t91
  store double %t92, double* %l3
  br label %loop.latch4
merge13:
  %t93 = load i8*, i8** %l2
  %t94 = load double, double* %l3
  br label %merge11
merge11:
  %t95 = phi i8* [ %t93, %merge13 ], [ %t62, %merge9 ]
  %t96 = phi double [ %t94, %merge13 ], [ %t63, %merge9 ]
  store i8* %t95, i8** %l2
  store double %t96, double* %l3
  %t97 = load i8*, i8** %l2
  %t98 = load i8*, i8** %l4
  %t99 = call i8* @sailfin_runtime_string_concat(i8* %t97, i8* %t98)
  store i8* %t99, i8** %l2
  %t100 = load double, double* %l3
  %t101 = sitofp i64 1 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l3
  br label %loop.latch4
loop.latch4:
  %t103 = load i8*, i8** %l2
  %t104 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t107 = load i8*, i8** %l2
  %t108 = load double, double* %l3
  %t109 = load i8*, i8** %l2
  call void @sailfin_runtime_mark_persistent(i8* %t109)
  ret i8* %t109
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
  %t71 = phi i8* [ %t0, %block.entry ], [ %t70, %loop.latch2 ]
  store i8* %t71, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h757831264, i32 0, i32 0
  %t3 = call double @index_of(i8* %t1, i8* %s2)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp olt double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = call %ExtractedSpan @extract_object_span(i8* %t9, double %t10)
  store %ExtractedSpan %t11, %ExtractedSpan* %l2
  %t12 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t13 = extractvalue %ExtractedSpan %t12, 3
  %t14 = xor i1 %t13, 1
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load %ExtractedSpan, %ExtractedSpan* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t18 = load double, double* %l1
  %t19 = sitofp i64 7 to double
  %t20 = fadd double %t18, %t19
  store double %t20, double* %l3
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l3
  %t23 = call %ExtractedSpan @extract_parenthesized_span(i8* %t21, double %t22)
  store %ExtractedSpan %t23, %ExtractedSpan* %l4
  %t24 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t25 = extractvalue %ExtractedSpan %t24, 3
  %t26 = xor i1 %t25, 1
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t30 = load double, double* %l3
  %t31 = load %ExtractedSpan, %ExtractedSpan* %l4
  br i1 %t26, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t32 = load i8*, i8** %l0
  %t33 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t34 = extractvalue %ExtractedSpan %t33, 1
  %t35 = call double @llvm.round.f64(double %t34)
  %t36 = fptosi double %t35 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %t32, i64 0, i64 %t36)
  store i8* %t37, i8** %l5
  %t38 = load i8*, i8** %l0
  %t39 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t40 = extractvalue %ExtractedSpan %t39, 2
  %t41 = load i8*, i8** %l0
  %t42 = call i64 @sailfin_runtime_string_length(i8* %t41)
  %t43 = call double @llvm.round.f64(double %t40)
  %t44 = fptosi double %t43 to i64
  %t45 = call i8* @sailfin_runtime_substring(i8* %t38, i64 %t44, i64 %t42)
  store i8* %t45, i8** %l6
  %t46 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t47 = extractvalue %ExtractedSpan %t46, 0
  %t48 = call i8* @trim_text(i8* %t47)
  store i8* %t48, i8** %l7
  %t49 = load %ExtractedSpan, %ExtractedSpan* %l4
  %t50 = extractvalue %ExtractedSpan %t49, 0
  %t51 = call i8* @trim_text(i8* %t50)
  store i8* %t51, i8** %l8
  %t52 = load i8*, i8** %l7
  %t53 = add i64 0, 2
  %t54 = call i8* @malloc(i64 %t53)
  store i8 40, i8* %t54
  %t55 = getelementptr i8, i8* %t54, i64 1
  store i8 0, i8* %t55
  call void @sailfin_runtime_mark_persistent(i8* %t54)
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t52)
  %s57 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1776141546, i32 0, i32 0
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %s57)
  %t59 = load i8*, i8** %l8
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t59)
  %t61 = add i64 0, 2
  %t62 = call i8* @malloc(i64 %t61)
  store i8 41, i8* %t62
  %t63 = getelementptr i8, i8* %t62, i64 1
  store i8 0, i8* %t63
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %t62)
  store i8* %t64, i8** %l9
  %t65 = load i8*, i8** %l5
  %t66 = load i8*, i8** %l9
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %t66)
  %t68 = load i8*, i8** %l6
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %t68)
  store i8* %t69, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t70 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t72 = load i8*, i8** %l0
  %t73 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t73)
  ret i8* %t73
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
  %t57 = phi i8* [ %t0, %block.entry ], [ %t56, %loop.latch2 ]
  store i8* %t57, i8** %l0
  br label %loop.body1
loop.body1:
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1558772342, i32 0, i32 0
  %t3 = call double @index_of(i8* %t1, i8* %s2)
  store double %t3, double* %l1
  %t4 = load double, double* %l1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp olt double %t4, %t5
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t9 = load i8*, i8** %l0
  %t10 = load double, double* %l1
  %t11 = call %ExtractedSpan @extract_object_span(i8* %t9, double %t10)
  store %ExtractedSpan %t11, %ExtractedSpan* %l2
  %t12 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t13 = extractvalue %ExtractedSpan %t12, 3
  %t14 = xor i1 %t13, 1
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  %t17 = load %ExtractedSpan, %ExtractedSpan* %l2
  br i1 %t14, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t18 = load i8*, i8** %l0
  %t19 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t20 = extractvalue %ExtractedSpan %t19, 1
  %t21 = call double @llvm.round.f64(double %t20)
  %t22 = fptosi double %t21 to i64
  %t23 = call i8* @sailfin_runtime_substring(i8* %t18, i64 0, i64 %t22)
  store i8* %t23, i8** %l3
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = sitofp i64 7 to double
  %t27 = fadd double %t25, %t26
  %t28 = load i8*, i8** %l0
  %t29 = call i64 @sailfin_runtime_string_length(i8* %t28)
  %t30 = call double @llvm.round.f64(double %t27)
  %t31 = fptosi double %t30 to i64
  %t32 = call i8* @sailfin_runtime_substring(i8* %t24, i64 %t31, i64 %t29)
  store i8* %t32, i8** %l4
  %t33 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t34 = extractvalue %ExtractedSpan %t33, 0
  %t35 = call i8* @trim_text(i8* %t34)
  store i8* %t35, i8** %l5
  %t36 = load i8*, i8** %l5
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = icmp eq i64 %t37, 0
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  %t41 = load %ExtractedSpan, %ExtractedSpan* %l2
  %t42 = load i8*, i8** %l3
  %t43 = load i8*, i8** %l4
  %t44 = load i8*, i8** %l5
  br i1 %t38, label %then8, label %merge9
then8:
  br label %afterloop3
merge9:
  %t45 = load i8*, i8** %l3
  %s46 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h265982546, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %s46)
  %t48 = load i8*, i8** %l5
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t47, i8* %t48)
  %t50 = add i64 0, 2
  %t51 = call i8* @malloc(i64 %t50)
  store i8 41, i8* %t51
  %t52 = getelementptr i8, i8* %t51, i64 1
  store i8 0, i8* %t52
  call void @sailfin_runtime_mark_persistent(i8* %t51)
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t49, i8* %t51)
  %t54 = load i8*, i8** %l4
  %t55 = call i8* @sailfin_runtime_string_concat(i8* %t53, i8* %t54)
  store i8* %t55, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t56 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t58 = load i8*, i8** %l0
  %t59 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t59)
  ret i8* %t59
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t3 = insertvalue %ExtractedSpan undef, i8* %s2, 0
  %t4 = sitofp i64 0 to double
  %t5 = insertvalue %ExtractedSpan %t3, double %t4, 1
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %ExtractedSpan %t5, double %t6, 2
  %t8 = insertvalue %ExtractedSpan %t7, i1 0, 3
  ret %ExtractedSpan %t8
merge1:
  %t9 = sitofp i64 1 to double
  %t10 = fsub double %dot_index, %t9
  store double %t10, double* %l0
  %t11 = sitofp i64 0 to double
  store double %t11, double* %l1
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l2
  %t13 = load double, double* %l0
  %t14 = load double, double* %l1
  %t15 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t129 = phi double [ %t14, %merge1 ], [ %t126, %loop.latch4 ]
  %t130 = phi double [ %t13, %merge1 ], [ %t127, %loop.latch4 ]
  %t131 = phi double [ %t15, %merge1 ], [ %t128, %loop.latch4 ]
  store double %t129, double* %l1
  store double %t130, double* %l0
  store double %t131, double* %l2
  br label %loop.body3
loop.body3:
  %t16 = load double, double* %l0
  %t17 = sitofp i64 0 to double
  %t18 = fcmp olt double %t16, %t17
  %t19 = load double, double* %l0
  %t20 = load double, double* %l1
  %t21 = load double, double* %l2
  br i1 %t18, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t22 = load double, double* %l0
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  %t26 = call double @llvm.round.f64(double %t22)
  %t27 = fptosi double %t26 to i64
  %t28 = call double @llvm.round.f64(double %t25)
  %t29 = fptosi double %t28 to i64
  %t30 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t27, i64 %t29)
  store i8* %t30, i8** %l3
  %t31 = load i8*, i8** %l3
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 93
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  %t36 = load double, double* %l2
  %t37 = load i8*, i8** %l3
  br i1 %t33, label %then8, label %merge9
then8:
  %t38 = load double, double* %l1
  %t39 = sitofp i64 1 to double
  %t40 = fadd double %t38, %t39
  store double %t40, double* %l1
  %t41 = load double, double* %l0
  %t42 = sitofp i64 1 to double
  %t43 = fsub double %t41, %t42
  store double %t43, double* %l0
  br label %loop.latch4
merge9:
  %t44 = load i8*, i8** %l3
  %t45 = load i8, i8* %t44
  %t46 = icmp eq i8 %t45, 91
  %t47 = load double, double* %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  %t50 = load i8*, i8** %l3
  br i1 %t46, label %then10, label %merge11
then10:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 0 to double
  %t53 = fcmp ogt double %t51, %t52
  %t54 = load double, double* %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load i8*, i8** %l3
  br i1 %t53, label %then12, label %merge13
then12:
  %t58 = load double, double* %l1
  %t59 = sitofp i64 1 to double
  %t60 = fsub double %t58, %t59
  store double %t60, double* %l1
  %t61 = load double, double* %l0
  %t62 = sitofp i64 1 to double
  %t63 = fsub double %t61, %t62
  store double %t63, double* %l0
  br label %loop.latch4
merge13:
  br label %afterloop5
merge11:
  %t64 = load i8*, i8** %l3
  %t65 = load i8, i8* %t64
  %t66 = icmp eq i8 %t65, 41
  %t67 = load double, double* %l0
  %t68 = load double, double* %l1
  %t69 = load double, double* %l2
  %t70 = load i8*, i8** %l3
  br i1 %t66, label %then14, label %merge15
then14:
  %t71 = load double, double* %l2
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  store double %t73, double* %l2
  %t74 = load double, double* %l0
  %t75 = sitofp i64 1 to double
  %t76 = fsub double %t74, %t75
  store double %t76, double* %l0
  br label %loop.latch4
merge15:
  %t77 = load i8*, i8** %l3
  %t78 = load i8, i8* %t77
  %t79 = icmp eq i8 %t78, 40
  %t80 = load double, double* %l0
  %t81 = load double, double* %l1
  %t82 = load double, double* %l2
  %t83 = load i8*, i8** %l3
  br i1 %t79, label %then16, label %merge17
then16:
  %t84 = load double, double* %l2
  %t85 = sitofp i64 0 to double
  %t86 = fcmp ogt double %t84, %t85
  %t87 = load double, double* %l0
  %t88 = load double, double* %l1
  %t89 = load double, double* %l2
  %t90 = load i8*, i8** %l3
  br i1 %t86, label %then18, label %merge19
then18:
  %t91 = load double, double* %l2
  %t92 = sitofp i64 1 to double
  %t93 = fsub double %t91, %t92
  store double %t93, double* %l2
  %t94 = load double, double* %l0
  %t95 = sitofp i64 1 to double
  %t96 = fsub double %t94, %t95
  store double %t96, double* %l0
  br label %loop.latch4
merge19:
  br label %afterloop5
merge17:
  %t98 = load double, double* %l1
  %t99 = sitofp i64 0 to double
  %t100 = fcmp ogt double %t98, %t99
  br label %logical_or_entry_97

logical_or_entry_97:
  br i1 %t100, label %logical_or_merge_97, label %logical_or_right_97

logical_or_right_97:
  %t101 = load double, double* %l2
  %t102 = sitofp i64 0 to double
  %t103 = fcmp ogt double %t101, %t102
  br label %logical_or_right_end_97

logical_or_right_end_97:
  br label %logical_or_merge_97

logical_or_merge_97:
  %t104 = phi i1 [ true, %logical_or_entry_97 ], [ %t103, %logical_or_right_end_97 ]
  %t105 = load double, double* %l0
  %t106 = load double, double* %l1
  %t107 = load double, double* %l2
  %t108 = load i8*, i8** %l3
  br i1 %t104, label %then20, label %merge21
then20:
  %t109 = load double, double* %l0
  %t110 = sitofp i64 1 to double
  %t111 = fsub double %t109, %t110
  store double %t111, double* %l0
  br label %loop.latch4
merge21:
  %t113 = load i8*, i8** %l3
  %t114 = call i1 @is_identifier_char(i8* %t113)
  br label %logical_or_entry_112

logical_or_entry_112:
  br i1 %t114, label %logical_or_merge_112, label %logical_or_right_112

logical_or_right_112:
  %t115 = load i8*, i8** %l3
  %t116 = load i8, i8* %t115
  %t117 = icmp eq i8 %t116, 46
  br label %logical_or_right_end_112

logical_or_right_end_112:
  br label %logical_or_merge_112

logical_or_merge_112:
  %t118 = phi i1 [ true, %logical_or_entry_112 ], [ %t117, %logical_or_right_end_112 ]
  %t119 = load double, double* %l0
  %t120 = load double, double* %l1
  %t121 = load double, double* %l2
  %t122 = load i8*, i8** %l3
  br i1 %t118, label %then22, label %merge23
then22:
  %t123 = load double, double* %l0
  %t124 = sitofp i64 1 to double
  %t125 = fsub double %t123, %t124
  store double %t125, double* %l0
  br label %loop.latch4
merge23:
  br label %afterloop5
loop.latch4:
  %t126 = load double, double* %l1
  %t127 = load double, double* %l0
  %t128 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t132 = load double, double* %l1
  %t133 = load double, double* %l0
  %t134 = load double, double* %l2
  %t135 = load double, double* %l0
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l4
  %t138 = load double, double* %l4
  %t139 = fcmp oge double %t138, %dot_index
  %t140 = load double, double* %l0
  %t141 = load double, double* %l1
  %t142 = load double, double* %l2
  %t143 = load double, double* %l4
  br i1 %t139, label %then24, label %merge25
then24:
  %s144 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t145 = insertvalue %ExtractedSpan undef, i8* %s144, 0
  %t146 = load double, double* %l4
  %t147 = insertvalue %ExtractedSpan %t145, double %t146, 1
  %t148 = insertvalue %ExtractedSpan %t147, double %dot_index, 2
  %t149 = insertvalue %ExtractedSpan %t148, i1 0, 3
  ret %ExtractedSpan %t149
merge25:
  %t150 = load double, double* %l4
  %t151 = call double @llvm.round.f64(double %t150)
  %t152 = fptosi double %t151 to i64
  %t153 = call double @llvm.round.f64(double %dot_index)
  %t154 = fptosi double %t153 to i64
  %t155 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t152, i64 %t154)
  store i8* %t155, i8** %l5
  %t156 = load i8*, i8** %l5
  %t157 = insertvalue %ExtractedSpan undef, i8* %t156, 0
  %t158 = load double, double* %l4
  %t159 = insertvalue %ExtractedSpan %t157, double %t158, 1
  %t160 = insertvalue %ExtractedSpan %t159, double %dot_index, 2
  %t161 = insertvalue %ExtractedSpan %t160, i1 1, 3
  ret %ExtractedSpan %t161
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t4 = insertvalue %ExtractedSpan undef, i8* %s3, 0
  %t5 = insertvalue %ExtractedSpan %t4, double %open_index, 1
  %t6 = insertvalue %ExtractedSpan %t5, double %open_index, 2
  %t7 = insertvalue %ExtractedSpan %t6, i1 0, 3
  ret %ExtractedSpan %t7
merge1:
  %t8 = sitofp i64 1 to double
  %t9 = fadd double %open_index, %t8
  %t10 = call double @llvm.round.f64(double %open_index)
  %t11 = fptosi double %t10 to i64
  %t12 = call double @llvm.round.f64(double %t9)
  %t13 = fptosi double %t12 to i64
  %t14 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t11, i64 %t13)
  %t15 = load i8, i8* %t14
  %t16 = icmp ne i8 %t15, 40
  br i1 %t16, label %then2, label %merge3
then2:
  %s17 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t18 = insertvalue %ExtractedSpan undef, i8* %s17, 0
  %t19 = insertvalue %ExtractedSpan %t18, double %open_index, 1
  %t20 = insertvalue %ExtractedSpan %t19, double %open_index, 2
  %t21 = insertvalue %ExtractedSpan %t20, i1 0, 3
  ret %ExtractedSpan %t21
merge3:
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %open_index, %t22
  store double %t23, double* %l0
  %t24 = sitofp i64 1 to double
  store double %t24, double* %l1
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  br label %loop.header4
loop.header4:
  %t111 = phi double [ %t26, %merge3 ], [ %t109, %loop.latch6 ]
  %t112 = phi double [ %t25, %merge3 ], [ %t110, %loop.latch6 ]
  store double %t111, double* %l1
  store double %t112, double* %l0
  br label %loop.body5
loop.body5:
  %t27 = load double, double* %l0
  %t28 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t27, %t29
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  br i1 %t30, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t33 = load double, double* %l0
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  %t37 = call double @llvm.round.f64(double %t33)
  %t38 = fptosi double %t37 to i64
  %t39 = call double @llvm.round.f64(double %t36)
  %t40 = fptosi double %t39 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t38, i64 %t40)
  store i8* %t41, i8** %l2
  %t42 = load i8*, i8** %l2
  %t43 = load i8, i8* %t42
  %t44 = icmp eq i8 %t43, 40
  %t45 = load double, double* %l0
  %t46 = load double, double* %l1
  %t47 = load i8*, i8** %l2
  br i1 %t44, label %then10, label %else11
then10:
  %t48 = load double, double* %l1
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l1
  %t51 = load double, double* %l1
  br label %merge12
else11:
  %t52 = load i8*, i8** %l2
  %t53 = load i8, i8* %t52
  %t54 = icmp eq i8 %t53, 41
  %t55 = load double, double* %l0
  %t56 = load double, double* %l1
  %t57 = load i8*, i8** %l2
  br i1 %t54, label %then13, label %else14
then13:
  %t58 = load double, double* %l1
  %t59 = sitofp i64 1 to double
  %t60 = fsub double %t58, %t59
  store double %t60, double* %l1
  %t61 = load double, double* %l1
  %t62 = sitofp i64 0 to double
  %t63 = fcmp oeq double %t61, %t62
  %t64 = load double, double* %l0
  %t65 = load double, double* %l1
  %t66 = load i8*, i8** %l2
  br i1 %t63, label %then16, label %merge17
then16:
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %open_index, %t67
  %t69 = load double, double* %l0
  %t70 = call double @llvm.round.f64(double %t68)
  %t71 = fptosi double %t70 to i64
  %t72 = call double @llvm.round.f64(double %t69)
  %t73 = fptosi double %t72 to i64
  %t74 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t71, i64 %t73)
  store i8* %t74, i8** %l3
  %t75 = load i8*, i8** %l3
  %t76 = insertvalue %ExtractedSpan undef, i8* %t75, 0
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %open_index, %t77
  %t79 = insertvalue %ExtractedSpan %t76, double %t78, 1
  %t80 = load double, double* %l0
  %t81 = sitofp i64 1 to double
  %t82 = fadd double %t80, %t81
  %t83 = insertvalue %ExtractedSpan %t79, double %t82, 2
  %t84 = insertvalue %ExtractedSpan %t83, i1 1, 3
  ret %ExtractedSpan %t84
merge17:
  %t85 = load double, double* %l1
  br label %merge15
else14:
  %t87 = load i8*, i8** %l2
  %t88 = load i8, i8* %t87
  %t89 = icmp eq i8 %t88, 34
  br label %logical_or_entry_86

logical_or_entry_86:
  br i1 %t89, label %logical_or_merge_86, label %logical_or_right_86

logical_or_right_86:
  %t90 = load i8*, i8** %l2
  %t91 = load i8, i8* %t90
  %t92 = icmp eq i8 %t91, 39
  br label %logical_or_right_end_86

logical_or_right_end_86:
  br label %logical_or_merge_86

logical_or_merge_86:
  %t93 = phi i1 [ true, %logical_or_entry_86 ], [ %t92, %logical_or_right_end_86 ]
  %t94 = load double, double* %l0
  %t95 = load double, double* %l1
  %t96 = load i8*, i8** %l2
  br i1 %t93, label %then18, label %merge19
then18:
  %t97 = load double, double* %l0
  %t98 = call double @skip_string_literal(i8* %text, double %t97)
  store double %t98, double* %l0
  br label %loop.latch6
merge19:
  %t99 = load double, double* %l0
  br label %merge15
merge15:
  %t100 = phi double [ %t85, %merge17 ], [ %t56, %merge19 ]
  %t101 = phi double [ %t55, %merge17 ], [ %t99, %merge19 ]
  store double %t100, double* %l1
  store double %t101, double* %l0
  %t102 = load double, double* %l1
  %t103 = load double, double* %l0
  br label %merge12
merge12:
  %t104 = phi double [ %t51, %then10 ], [ %t102, %merge15 ]
  %t105 = phi double [ %t45, %then10 ], [ %t103, %merge15 ]
  store double %t104, double* %l1
  store double %t105, double* %l0
  %t106 = load double, double* %l0
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l0
  br label %loop.latch6
loop.latch6:
  %t109 = load double, double* %l1
  %t110 = load double, double* %l0
  br label %loop.header4
afterloop7:
  %t113 = load double, double* %l1
  %t114 = load double, double* %l0
  %s115 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t116 = insertvalue %ExtractedSpan undef, i8* %s115, 0
  %t117 = insertvalue %ExtractedSpan %t116, double %open_index, 1
  %t118 = insertvalue %ExtractedSpan %t117, double %open_index, 2
  %t119 = insertvalue %ExtractedSpan %t118, i1 0, 3
  ret %ExtractedSpan %t119
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
  %s53 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t54 = call i1 @strings_equal(i8* %t52, i8* %s53)
  br i1 %t54, label %then0, label %merge1
then0:
  %t55 = extractvalue %NativeInstruction %instruction, 0
  %t56 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t56
  %t57 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t56, i32 0, i32 1
  %t58 = bitcast [8 x i8]* %t57 to i8*
  %t59 = bitcast i8* %t58 to i8**
  %t60 = load i8*, i8** %t59
  %t61 = icmp eq i32 %t55, 16
  %t62 = select i1 %t61, i8* %t60, i8* null
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  ret i8* %t62
merge1:
  %t63 = extractvalue %NativeInstruction %instruction, 0
  %t64 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t65 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t66 = icmp eq i32 %t63, 0
  %t67 = select i1 %t66, i8* %t65, i8* %t64
  %t68 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t69 = icmp eq i32 %t63, 1
  %t70 = select i1 %t69, i8* %t68, i8* %t67
  %t71 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t72 = icmp eq i32 %t63, 2
  %t73 = select i1 %t72, i8* %t71, i8* %t70
  %t74 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t75 = icmp eq i32 %t63, 3
  %t76 = select i1 %t75, i8* %t74, i8* %t73
  %t77 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t78 = icmp eq i32 %t63, 4
  %t79 = select i1 %t78, i8* %t77, i8* %t76
  %t80 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t81 = icmp eq i32 %t63, 5
  %t82 = select i1 %t81, i8* %t80, i8* %t79
  %t83 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t84 = icmp eq i32 %t63, 6
  %t85 = select i1 %t84, i8* %t83, i8* %t82
  %t86 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t87 = icmp eq i32 %t63, 7
  %t88 = select i1 %t87, i8* %t86, i8* %t85
  %t89 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t90 = icmp eq i32 %t63, 8
  %t91 = select i1 %t90, i8* %t89, i8* %t88
  %t92 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t93 = icmp eq i32 %t63, 9
  %t94 = select i1 %t93, i8* %t92, i8* %t91
  %t95 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t96 = icmp eq i32 %t63, 10
  %t97 = select i1 %t96, i8* %t95, i8* %t94
  %t98 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t99 = icmp eq i32 %t63, 11
  %t100 = select i1 %t99, i8* %t98, i8* %t97
  %t101 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t102 = icmp eq i32 %t63, 12
  %t103 = select i1 %t102, i8* %t101, i8* %t100
  %t104 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t105 = icmp eq i32 %t63, 13
  %t106 = select i1 %t105, i8* %t104, i8* %t103
  %t107 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t108 = icmp eq i32 %t63, 14
  %t109 = select i1 %t108, i8* %t107, i8* %t106
  %t110 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t111 = icmp eq i32 %t63, 15
  %t112 = select i1 %t111, i8* %t110, i8* %t109
  %t113 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t114 = icmp eq i32 %t63, 16
  %t115 = select i1 %t114, i8* %t113, i8* %t112
  %s116 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t117 = call i1 @strings_equal(i8* %t115, i8* %s116)
  br i1 %t117, label %then2, label %merge3
then2:
  %t118 = extractvalue %NativeInstruction %instruction, 0
  %t119 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t119
  %t120 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t121 = bitcast [16 x i8]* %t120 to i8*
  %t122 = bitcast i8* %t121 to i8**
  %t123 = load i8*, i8** %t122
  %t124 = icmp eq i32 %t118, 0
  %t125 = select i1 %t124, i8* %t123, i8* null
  %t126 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t127 = bitcast [16 x i8]* %t126 to i8*
  %t128 = bitcast i8* %t127 to i8**
  %t129 = load i8*, i8** %t128
  %t130 = icmp eq i32 %t118, 1
  %t131 = select i1 %t130, i8* %t129, i8* %t125
  %t132 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t119, i32 0, i32 1
  %t133 = bitcast [8 x i8]* %t132 to i8*
  %t134 = bitcast i8* %t133 to i8**
  %t135 = load i8*, i8** %t134
  %t136 = icmp eq i32 %t118, 12
  %t137 = select i1 %t136, i8* %t135, i8* %t131
  call void @sailfin_runtime_mark_persistent(i8* %t137)
  ret i8* %t137
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
  %s2 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193419635, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %segment, i8* %s2)
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %s4 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193516127, i32 0, i32 0
  %t5 = call i1 @starts_with(i8* %segment, i8* %s4)
  br i1 %t5, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t6 = sitofp i64 0 to double
  %t7 = call i8* @char_at(i8* %segment, double %t6)
  store i8* %t7, i8** %l0
  %t9 = load i8*, i8** %l0
  %t10 = load i8, i8* %t9
  %t11 = icmp eq i8 %t10, 46
  br label %logical_or_entry_8

logical_or_entry_8:
  br i1 %t11, label %logical_or_merge_8, label %logical_or_right_8

logical_or_right_8:
  %t13 = load i8*, i8** %l0
  %t14 = load i8, i8* %t13
  %t15 = icmp eq i8 %t14, 41
  br label %logical_or_entry_12

logical_or_entry_12:
  br i1 %t15, label %logical_or_merge_12, label %logical_or_right_12

logical_or_right_12:
  %t17 = load i8*, i8** %l0
  %t18 = load i8, i8* %t17
  %t19 = icmp eq i8 %t18, 93
  br label %logical_or_entry_16

logical_or_entry_16:
  br i1 %t19, label %logical_or_merge_16, label %logical_or_right_16

logical_or_right_16:
  %t20 = load i8*, i8** %l0
  %t21 = load i8, i8* %t20
  %t22 = icmp eq i8 %t21, 125
  br label %logical_or_right_end_16

logical_or_right_end_16:
  br label %logical_or_merge_16

logical_or_merge_16:
  %t23 = phi i1 [ true, %logical_or_entry_16 ], [ %t22, %logical_or_right_end_16 ]
  br label %logical_or_right_end_12

logical_or_right_end_12:
  br label %logical_or_merge_12

logical_or_merge_12:
  %t24 = phi i1 [ true, %logical_or_entry_12 ], [ %t23, %logical_or_right_end_12 ]
  br label %logical_or_right_end_8

logical_or_right_end_8:
  br label %logical_or_merge_8

logical_or_merge_8:
  %t25 = phi i1 [ true, %logical_or_entry_8 ], [ %t24, %logical_or_right_end_8 ]
  %t26 = load i8*, i8** %l0
  br i1 %t25, label %then6, label %merge7
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
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l3
  store i1 0, i1* %l4
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s15, i8** %l5
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = load i1, i1* %l4
  %t21 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t217 = phi i8* [ %t17, %block.entry ], [ %t211, %loop.latch2 ]
  %t218 = phi double [ %t19, %block.entry ], [ %t212, %loop.latch2 ]
  %t219 = phi i1 [ %t20, %block.entry ], [ %t213, %loop.latch2 ]
  %t220 = phi i8* [ %t21, %block.entry ], [ %t214, %loop.latch2 ]
  %t221 = phi double [ %t18, %block.entry ], [ %t215, %loop.latch2 ]
  %t222 = phi { i8**, i64 }* [ %t16, %block.entry ], [ %t216, %loop.latch2 ]
  store i8* %t217, i8** %l1
  store double %t218, double* %l3
  store i1 %t219, i1* %l4
  store i8* %t220, i8** %l5
  store double %t221, double* %l2
  store { i8**, i64 }* %t222, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l3
  %t23 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp oge double %t22, %t24
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load i8*, i8** %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  %t30 = load i1, i1* %l4
  %t31 = load i8*, i8** %l5
  br i1 %t25, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t32 = load double, double* %l3
  %t33 = call i8* @char_at(i8* %text, double %t32)
  store i8* %t33, i8** %l6
  %t34 = load i1, i1* %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = load i1, i1* %l4
  %t40 = load i8*, i8** %l5
  %t41 = load i8*, i8** %l6
  br i1 %t34, label %then6, label %merge7
then6:
  %t42 = load i8*, i8** %l1
  %t43 = load i8*, i8** %l6
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t43)
  store i8* %t44, i8** %l1
  %t45 = load i8*, i8** %l6
  %t46 = load i8, i8* %t45
  %t47 = icmp eq i8 %t46, 92
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load i1, i1* %l4
  %t53 = load i8*, i8** %l5
  %t54 = load i8*, i8** %l6
  br i1 %t47, label %then8, label %else9
then8:
  %t55 = load double, double* %l3
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l3
  %t58 = load double, double* %l3
  %t59 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t60 = sitofp i64 %t59 to double
  %t61 = fcmp olt double %t58, %t60
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l2
  %t65 = load double, double* %l3
  %t66 = load i1, i1* %l4
  %t67 = load i8*, i8** %l5
  %t68 = load i8*, i8** %l6
  br i1 %t61, label %then11, label %merge12
then11:
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l3
  %t71 = call i8* @char_at(i8* %text, double %t70)
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t71)
  store i8* %t72, i8** %l1
  %t73 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t74 = phi i8* [ %t73, %then11 ], [ %t63, %then8 ]
  store i8* %t74, i8** %l1
  %t75 = load double, double* %l3
  %t76 = load i8*, i8** %l1
  br label %merge10
else9:
  %t77 = load i8*, i8** %l6
  %t78 = load i8*, i8** %l5
  %t79 = call i1 @strings_equal(i8* %t77, i8* %t78)
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l2
  %t83 = load double, double* %l3
  %t84 = load i1, i1* %l4
  %t85 = load i8*, i8** %l5
  %t86 = load i8*, i8** %l6
  br i1 %t79, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  %t87 = load i1, i1* %l4
  br label %merge14
merge14:
  %t88 = phi i1 [ %t87, %then13 ], [ %t84, %else9 ]
  store i1 %t88, i1* %l4
  %t89 = load i1, i1* %l4
  br label %merge10
merge10:
  %t90 = phi double [ %t75, %merge12 ], [ %t51, %merge14 ]
  %t91 = phi i8* [ %t76, %merge12 ], [ %t49, %merge14 ]
  %t92 = phi i1 [ %t52, %merge12 ], [ %t89, %merge14 ]
  store double %t90, double* %l3
  store i8* %t91, i8** %l1
  store i1 %t92, i1* %l4
  %t93 = load double, double* %l3
  %t94 = sitofp i64 1 to double
  %t95 = fadd double %t93, %t94
  store double %t95, double* %l3
  br label %loop.latch2
merge7:
  %t97 = load i8*, i8** %l6
  %t98 = load i8, i8* %t97
  %t99 = icmp eq i8 %t98, 34
  br label %logical_or_entry_96

logical_or_entry_96:
  br i1 %t99, label %logical_or_merge_96, label %logical_or_right_96

logical_or_right_96:
  %t100 = load i8*, i8** %l6
  %t101 = load i8, i8* %t100
  %t102 = icmp eq i8 %t101, 39
  br label %logical_or_right_end_96

logical_or_right_end_96:
  br label %logical_or_merge_96

logical_or_merge_96:
  %t103 = phi i1 [ true, %logical_or_entry_96 ], [ %t102, %logical_or_right_end_96 ]
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load double, double* %l2
  %t107 = load double, double* %l3
  %t108 = load i1, i1* %l4
  %t109 = load i8*, i8** %l5
  %t110 = load i8*, i8** %l6
  br i1 %t103, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t111 = load i8*, i8** %l6
  store i8* %t111, i8** %l5
  %t112 = load i8*, i8** %l1
  %t113 = load i8*, i8** %l6
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %t113)
  store i8* %t114, i8** %l1
  %t115 = load double, double* %l3
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l3
  br label %loop.latch2
merge16:
  %t119 = load i8*, i8** %l6
  %t120 = load i8, i8* %t119
  %t121 = icmp eq i8 %t120, 123
  br label %logical_or_entry_118

logical_or_entry_118:
  br i1 %t121, label %logical_or_merge_118, label %logical_or_right_118

logical_or_right_118:
  %t123 = load i8*, i8** %l6
  %t124 = load i8, i8* %t123
  %t125 = icmp eq i8 %t124, 91
  br label %logical_or_entry_122

logical_or_entry_122:
  br i1 %t125, label %logical_or_merge_122, label %logical_or_right_122

logical_or_right_122:
  %t126 = load i8*, i8** %l6
  %t127 = load i8, i8* %t126
  %t128 = icmp eq i8 %t127, 40
  br label %logical_or_right_end_122

logical_or_right_end_122:
  br label %logical_or_merge_122

logical_or_merge_122:
  %t129 = phi i1 [ true, %logical_or_entry_122 ], [ %t128, %logical_or_right_end_122 ]
  br label %logical_or_right_end_118

logical_or_right_end_118:
  br label %logical_or_merge_118

logical_or_merge_118:
  %t130 = phi i1 [ true, %logical_or_entry_118 ], [ %t129, %logical_or_right_end_118 ]
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load i8*, i8** %l1
  %t133 = load double, double* %l2
  %t134 = load double, double* %l3
  %t135 = load i1, i1* %l4
  %t136 = load i8*, i8** %l5
  %t137 = load i8*, i8** %l6
  br i1 %t130, label %then17, label %else18
then17:
  %t138 = load double, double* %l2
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l2
  %t141 = load double, double* %l2
  br label %merge19
else18:
  %t143 = load i8*, i8** %l6
  %t144 = load i8, i8* %t143
  %t145 = icmp eq i8 %t144, 125
  br label %logical_or_entry_142

logical_or_entry_142:
  br i1 %t145, label %logical_or_merge_142, label %logical_or_right_142

logical_or_right_142:
  %t147 = load i8*, i8** %l6
  %t148 = load i8, i8* %t147
  %t149 = icmp eq i8 %t148, 93
  br label %logical_or_entry_146

logical_or_entry_146:
  br i1 %t149, label %logical_or_merge_146, label %logical_or_right_146

logical_or_right_146:
  %t150 = load i8*, i8** %l6
  %t151 = load i8, i8* %t150
  %t152 = icmp eq i8 %t151, 41
  br label %logical_or_right_end_146

logical_or_right_end_146:
  br label %logical_or_merge_146

logical_or_merge_146:
  %t153 = phi i1 [ true, %logical_or_entry_146 ], [ %t152, %logical_or_right_end_146 ]
  br label %logical_or_right_end_142

logical_or_right_end_142:
  br label %logical_or_merge_142

logical_or_merge_142:
  %t154 = phi i1 [ true, %logical_or_entry_142 ], [ %t153, %logical_or_right_end_142 ]
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t156 = load i8*, i8** %l1
  %t157 = load double, double* %l2
  %t158 = load double, double* %l3
  %t159 = load i1, i1* %l4
  %t160 = load i8*, i8** %l5
  %t161 = load i8*, i8** %l6
  br i1 %t154, label %then20, label %merge21
then20:
  %t162 = load double, double* %l2
  %t163 = sitofp i64 0 to double
  %t164 = fcmp ogt double %t162, %t163
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l2
  %t168 = load double, double* %l3
  %t169 = load i1, i1* %l4
  %t170 = load i8*, i8** %l5
  %t171 = load i8*, i8** %l6
  br i1 %t164, label %then22, label %merge23
then22:
  %t172 = load double, double* %l2
  %t173 = sitofp i64 1 to double
  %t174 = fsub double %t172, %t173
  store double %t174, double* %l2
  %t175 = load double, double* %l2
  br label %merge23
merge23:
  %t176 = phi double [ %t175, %then22 ], [ %t167, %then20 ]
  store double %t176, double* %l2
  %t177 = load double, double* %l2
  br label %merge21
merge21:
  %t178 = phi double [ %t177, %merge23 ], [ %t157, %logical_or_merge_142 ]
  store double %t178, double* %l2
  %t179 = load double, double* %l2
  br label %merge19
merge19:
  %t180 = phi double [ %t141, %then17 ], [ %t179, %merge21 ]
  store double %t180, double* %l2
  %t182 = load i8*, i8** %l6
  %t183 = load i8, i8* %t182
  %t184 = icmp eq i8 %t183, 44
  br label %logical_and_entry_181

logical_and_entry_181:
  br i1 %t184, label %logical_and_right_181, label %logical_and_merge_181

logical_and_right_181:
  %t185 = load double, double* %l2
  %t186 = sitofp i64 0 to double
  %t187 = fcmp oeq double %t185, %t186
  br label %logical_and_right_end_181

logical_and_right_end_181:
  br label %logical_and_merge_181

logical_and_merge_181:
  %t188 = phi i1 [ false, %logical_and_entry_181 ], [ %t187, %logical_and_right_end_181 ]
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = load double, double* %l2
  %t192 = load double, double* %l3
  %t193 = load i1, i1* %l4
  %t194 = load i8*, i8** %l5
  %t195 = load i8*, i8** %l6
  br i1 %t188, label %then24, label %else25
then24:
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load i8*, i8** %l1
  %t198 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t196, i8* %t197)
  store { i8**, i64 }* %t198, { i8**, i64 }** %l0
  %s199 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s199, i8** %l1
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t201 = load i8*, i8** %l1
  br label %merge26
else25:
  %t202 = load i8*, i8** %l1
  %t203 = load i8*, i8** %l6
  %t204 = call i8* @sailfin_runtime_string_concat(i8* %t202, i8* %t203)
  store i8* %t204, i8** %l1
  %t205 = load i8*, i8** %l1
  br label %merge26
merge26:
  %t206 = phi { i8**, i64 }* [ %t200, %then24 ], [ %t189, %else25 ]
  %t207 = phi i8* [ %t201, %then24 ], [ %t205, %else25 ]
  store { i8**, i64 }* %t206, { i8**, i64 }** %l0
  store i8* %t207, i8** %l1
  %t208 = load double, double* %l3
  %t209 = sitofp i64 1 to double
  %t210 = fadd double %t208, %t209
  store double %t210, double* %l3
  br label %loop.latch2
loop.latch2:
  %t211 = load i8*, i8** %l1
  %t212 = load double, double* %l3
  %t213 = load i1, i1* %l4
  %t214 = load i8*, i8** %l5
  %t215 = load double, double* %l2
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t223 = load i8*, i8** %l1
  %t224 = load double, double* %l3
  %t225 = load i1, i1* %l4
  %t226 = load i8*, i8** %l5
  %t227 = load double, double* %l2
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load i8*, i8** %l1
  %t230 = call i64 @sailfin_runtime_string_length(i8* %t229)
  %t231 = icmp sgt i64 %t230, 0
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t233 = load i8*, i8** %l1
  %t234 = load double, double* %l2
  %t235 = load double, double* %l3
  %t236 = load i1, i1* %l4
  %t237 = load i8*, i8** %l5
  br i1 %t231, label %then27, label %merge28
then27:
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t239 = load i8*, i8** %l1
  %t240 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t238, i8* %t239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l0
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t242 = phi { i8**, i64 }* [ %t241, %then27 ], [ %t232, %afterloop3 ]
  store { i8**, i64 }* %t242, { i8**, i64 }** %l0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t243
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
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = sitofp i64 0 to double
  store double %t14, double* %l3
  store i1 0, i1* %l4
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s15, i8** %l5
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = load i1, i1* %l4
  %t21 = load i8*, i8** %l5
  br label %loop.header0
loop.header0:
  %t217 = phi i8* [ %t17, %block.entry ], [ %t211, %loop.latch2 ]
  %t218 = phi double [ %t19, %block.entry ], [ %t212, %loop.latch2 ]
  %t219 = phi i1 [ %t20, %block.entry ], [ %t213, %loop.latch2 ]
  %t220 = phi i8* [ %t21, %block.entry ], [ %t214, %loop.latch2 ]
  %t221 = phi double [ %t18, %block.entry ], [ %t215, %loop.latch2 ]
  %t222 = phi { i8**, i64 }* [ %t16, %block.entry ], [ %t216, %loop.latch2 ]
  store i8* %t217, i8** %l1
  store double %t218, double* %l3
  store i1 %t219, i1* %l4
  store i8* %t220, i8** %l5
  store double %t221, double* %l2
  store { i8**, i64 }* %t222, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t22 = load double, double* %l3
  %t23 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t24 = sitofp i64 %t23 to double
  %t25 = fcmp oge double %t22, %t24
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = load i8*, i8** %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  %t30 = load i1, i1* %l4
  %t31 = load i8*, i8** %l5
  br i1 %t25, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t32 = load double, double* %l3
  %t33 = call i8* @char_at(i8* %text, double %t32)
  store i8* %t33, i8** %l6
  %t34 = load i1, i1* %l4
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load double, double* %l2
  %t38 = load double, double* %l3
  %t39 = load i1, i1* %l4
  %t40 = load i8*, i8** %l5
  %t41 = load i8*, i8** %l6
  br i1 %t34, label %then6, label %merge7
then6:
  %t42 = load i8*, i8** %l1
  %t43 = load i8*, i8** %l6
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t43)
  store i8* %t44, i8** %l1
  %t45 = load i8*, i8** %l6
  %t46 = load i8, i8* %t45
  %t47 = icmp eq i8 %t46, 92
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  %t52 = load i1, i1* %l4
  %t53 = load i8*, i8** %l5
  %t54 = load i8*, i8** %l6
  br i1 %t47, label %then8, label %else9
then8:
  %t55 = load double, double* %l3
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l3
  %t58 = load double, double* %l3
  %t59 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t60 = sitofp i64 %t59 to double
  %t61 = fcmp olt double %t58, %t60
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l1
  %t64 = load double, double* %l2
  %t65 = load double, double* %l3
  %t66 = load i1, i1* %l4
  %t67 = load i8*, i8** %l5
  %t68 = load i8*, i8** %l6
  br i1 %t61, label %then11, label %merge12
then11:
  %t69 = load i8*, i8** %l1
  %t70 = load double, double* %l3
  %t71 = call i8* @char_at(i8* %text, double %t70)
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t69, i8* %t71)
  store i8* %t72, i8** %l1
  %t73 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t74 = phi i8* [ %t73, %then11 ], [ %t63, %then8 ]
  store i8* %t74, i8** %l1
  %t75 = load double, double* %l3
  %t76 = load i8*, i8** %l1
  br label %merge10
else9:
  %t77 = load i8*, i8** %l6
  %t78 = load i8*, i8** %l5
  %t79 = call i1 @strings_equal(i8* %t77, i8* %t78)
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l2
  %t83 = load double, double* %l3
  %t84 = load i1, i1* %l4
  %t85 = load i8*, i8** %l5
  %t86 = load i8*, i8** %l6
  br i1 %t79, label %then13, label %merge14
then13:
  store i1 0, i1* %l4
  %t87 = load i1, i1* %l4
  br label %merge14
merge14:
  %t88 = phi i1 [ %t87, %then13 ], [ %t84, %else9 ]
  store i1 %t88, i1* %l4
  %t89 = load i1, i1* %l4
  br label %merge10
merge10:
  %t90 = phi double [ %t75, %merge12 ], [ %t51, %merge14 ]
  %t91 = phi i8* [ %t76, %merge12 ], [ %t49, %merge14 ]
  %t92 = phi i1 [ %t52, %merge12 ], [ %t89, %merge14 ]
  store double %t90, double* %l3
  store i8* %t91, i8** %l1
  store i1 %t92, i1* %l4
  %t93 = load double, double* %l3
  %t94 = sitofp i64 1 to double
  %t95 = fadd double %t93, %t94
  store double %t95, double* %l3
  br label %loop.latch2
merge7:
  %t97 = load i8*, i8** %l6
  %t98 = load i8, i8* %t97
  %t99 = icmp eq i8 %t98, 34
  br label %logical_or_entry_96

logical_or_entry_96:
  br i1 %t99, label %logical_or_merge_96, label %logical_or_right_96

logical_or_right_96:
  %t100 = load i8*, i8** %l6
  %t101 = load i8, i8* %t100
  %t102 = icmp eq i8 %t101, 39
  br label %logical_or_right_end_96

logical_or_right_end_96:
  br label %logical_or_merge_96

logical_or_merge_96:
  %t103 = phi i1 [ true, %logical_or_entry_96 ], [ %t102, %logical_or_right_end_96 ]
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load double, double* %l2
  %t107 = load double, double* %l3
  %t108 = load i1, i1* %l4
  %t109 = load i8*, i8** %l5
  %t110 = load i8*, i8** %l6
  br i1 %t103, label %then15, label %merge16
then15:
  store i1 1, i1* %l4
  %t111 = load i8*, i8** %l6
  store i8* %t111, i8** %l5
  %t112 = load i8*, i8** %l1
  %t113 = load i8*, i8** %l6
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %t113)
  store i8* %t114, i8** %l1
  %t115 = load double, double* %l3
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l3
  br label %loop.latch2
merge16:
  %t119 = load i8*, i8** %l6
  %t120 = load i8, i8* %t119
  %t121 = icmp eq i8 %t120, 123
  br label %logical_or_entry_118

logical_or_entry_118:
  br i1 %t121, label %logical_or_merge_118, label %logical_or_right_118

logical_or_right_118:
  %t123 = load i8*, i8** %l6
  %t124 = load i8, i8* %t123
  %t125 = icmp eq i8 %t124, 91
  br label %logical_or_entry_122

logical_or_entry_122:
  br i1 %t125, label %logical_or_merge_122, label %logical_or_right_122

logical_or_right_122:
  %t126 = load i8*, i8** %l6
  %t127 = load i8, i8* %t126
  %t128 = icmp eq i8 %t127, 40
  br label %logical_or_right_end_122

logical_or_right_end_122:
  br label %logical_or_merge_122

logical_or_merge_122:
  %t129 = phi i1 [ true, %logical_or_entry_122 ], [ %t128, %logical_or_right_end_122 ]
  br label %logical_or_right_end_118

logical_or_right_end_118:
  br label %logical_or_merge_118

logical_or_merge_118:
  %t130 = phi i1 [ true, %logical_or_entry_118 ], [ %t129, %logical_or_right_end_118 ]
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load i8*, i8** %l1
  %t133 = load double, double* %l2
  %t134 = load double, double* %l3
  %t135 = load i1, i1* %l4
  %t136 = load i8*, i8** %l5
  %t137 = load i8*, i8** %l6
  br i1 %t130, label %then17, label %else18
then17:
  %t138 = load double, double* %l2
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l2
  %t141 = load double, double* %l2
  br label %merge19
else18:
  %t143 = load i8*, i8** %l6
  %t144 = load i8, i8* %t143
  %t145 = icmp eq i8 %t144, 125
  br label %logical_or_entry_142

logical_or_entry_142:
  br i1 %t145, label %logical_or_merge_142, label %logical_or_right_142

logical_or_right_142:
  %t147 = load i8*, i8** %l6
  %t148 = load i8, i8* %t147
  %t149 = icmp eq i8 %t148, 93
  br label %logical_or_entry_146

logical_or_entry_146:
  br i1 %t149, label %logical_or_merge_146, label %logical_or_right_146

logical_or_right_146:
  %t150 = load i8*, i8** %l6
  %t151 = load i8, i8* %t150
  %t152 = icmp eq i8 %t151, 41
  br label %logical_or_right_end_146

logical_or_right_end_146:
  br label %logical_or_merge_146

logical_or_merge_146:
  %t153 = phi i1 [ true, %logical_or_entry_146 ], [ %t152, %logical_or_right_end_146 ]
  br label %logical_or_right_end_142

logical_or_right_end_142:
  br label %logical_or_merge_142

logical_or_merge_142:
  %t154 = phi i1 [ true, %logical_or_entry_142 ], [ %t153, %logical_or_right_end_142 ]
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t156 = load i8*, i8** %l1
  %t157 = load double, double* %l2
  %t158 = load double, double* %l3
  %t159 = load i1, i1* %l4
  %t160 = load i8*, i8** %l5
  %t161 = load i8*, i8** %l6
  br i1 %t154, label %then20, label %merge21
then20:
  %t162 = load double, double* %l2
  %t163 = sitofp i64 0 to double
  %t164 = fcmp ogt double %t162, %t163
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t166 = load i8*, i8** %l1
  %t167 = load double, double* %l2
  %t168 = load double, double* %l3
  %t169 = load i1, i1* %l4
  %t170 = load i8*, i8** %l5
  %t171 = load i8*, i8** %l6
  br i1 %t164, label %then22, label %merge23
then22:
  %t172 = load double, double* %l2
  %t173 = sitofp i64 1 to double
  %t174 = fsub double %t172, %t173
  store double %t174, double* %l2
  %t175 = load double, double* %l2
  br label %merge23
merge23:
  %t176 = phi double [ %t175, %then22 ], [ %t167, %then20 ]
  store double %t176, double* %l2
  %t177 = load double, double* %l2
  br label %merge21
merge21:
  %t178 = phi double [ %t177, %merge23 ], [ %t157, %logical_or_merge_142 ]
  store double %t178, double* %l2
  %t179 = load double, double* %l2
  br label %merge19
merge19:
  %t180 = phi double [ %t141, %then17 ], [ %t179, %merge21 ]
  store double %t180, double* %l2
  %t182 = load i8*, i8** %l6
  %t183 = load i8, i8* %t182
  %t184 = icmp eq i8 %t183, 44
  br label %logical_and_entry_181

logical_and_entry_181:
  br i1 %t184, label %logical_and_right_181, label %logical_and_merge_181

logical_and_right_181:
  %t185 = load double, double* %l2
  %t186 = sitofp i64 0 to double
  %t187 = fcmp oeq double %t185, %t186
  br label %logical_and_right_end_181

logical_and_right_end_181:
  br label %logical_and_merge_181

logical_and_merge_181:
  %t188 = phi i1 [ false, %logical_and_entry_181 ], [ %t187, %logical_and_right_end_181 ]
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load i8*, i8** %l1
  %t191 = load double, double* %l2
  %t192 = load double, double* %l3
  %t193 = load i1, i1* %l4
  %t194 = load i8*, i8** %l5
  %t195 = load i8*, i8** %l6
  br i1 %t188, label %then24, label %else25
then24:
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load i8*, i8** %l1
  %t198 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t196, i8* %t197)
  store { i8**, i64 }* %t198, { i8**, i64 }** %l0
  %s199 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s199, i8** %l1
  %t200 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t201 = load i8*, i8** %l1
  br label %merge26
else25:
  %t202 = load i8*, i8** %l1
  %t203 = load i8*, i8** %l6
  %t204 = call i8* @sailfin_runtime_string_concat(i8* %t202, i8* %t203)
  store i8* %t204, i8** %l1
  %t205 = load i8*, i8** %l1
  br label %merge26
merge26:
  %t206 = phi { i8**, i64 }* [ %t200, %then24 ], [ %t189, %else25 ]
  %t207 = phi i8* [ %t201, %then24 ], [ %t205, %else25 ]
  store { i8**, i64 }* %t206, { i8**, i64 }** %l0
  store i8* %t207, i8** %l1
  %t208 = load double, double* %l3
  %t209 = sitofp i64 1 to double
  %t210 = fadd double %t208, %t209
  store double %t210, double* %l3
  br label %loop.latch2
loop.latch2:
  %t211 = load i8*, i8** %l1
  %t212 = load double, double* %l3
  %t213 = load i1, i1* %l4
  %t214 = load i8*, i8** %l5
  %t215 = load double, double* %l2
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t223 = load i8*, i8** %l1
  %t224 = load double, double* %l3
  %t225 = load i1, i1* %l4
  %t226 = load i8*, i8** %l5
  %t227 = load double, double* %l2
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t229 = load i8*, i8** %l1
  %t230 = call i64 @sailfin_runtime_string_length(i8* %t229)
  %t231 = icmp sgt i64 %t230, 0
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t233 = load i8*, i8** %l1
  %t234 = load double, double* %l2
  %t235 = load double, double* %l3
  %t236 = load i1, i1* %l4
  %t237 = load i8*, i8** %l5
  br i1 %t231, label %then27, label %merge28
then27:
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t239 = load i8*, i8** %l1
  %t240 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t238, i8* %t239)
  store { i8**, i64 }* %t240, { i8**, i64 }** %l0
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t242 = phi { i8**, i64 }* [ %t241, %then27 ], [ %t232, %afterloop3 ]
  store { i8**, i64 }* %t242, { i8**, i64 }** %l0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t243
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
  %s14 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h256486202, i32 0, i32 0
  %t15 = extractvalue %NativeFunction %function, 0
  %t16 = call i8* @sanitize_identifier(i8* %t15)
  %t17 = call i8* @sailfin_runtime_string_concat(i8* %s14, i8* %t16)
  %t18 = add i64 0, 2
  %t19 = call i8* @malloc(i64 %t18)
  store i8 40, i8* %t19
  %t20 = getelementptr i8, i8* %t19, i64 1
  store i8 0, i8* %t20
  call void @sailfin_runtime_mark_persistent(i8* %t19)
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t17, i8* %t19)
  %t22 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s23 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t24 = call i8* @join_with_separator({ i8**, i64 }* %t22, i8* %s23)
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t24)
  %s26 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193423562, i32 0, i32 0
  %t27 = call i8* @sailfin_runtime_string_concat(i8* %t25, i8* %s26)
  store i8* %t27, i8** %l3
  %t28 = load %PythonBuilder, %PythonBuilder* %l0
  %t29 = load i8*, i8** %l3
  %t30 = call %PythonBuilder @builder_emit(%PythonBuilder %t28, i8* %t29)
  store %PythonBuilder %t30, %PythonBuilder* %l0
  %t31 = load %PythonBuilder, %PythonBuilder* %l0
  %t32 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t31)
  store %PythonBuilder %t32, %PythonBuilder* %l0
  %t33 = extractvalue %NativeFunction %function, 3
  %t34 = load { i8**, i64 }, { i8**, i64 }* %t33
  %t35 = extractvalue { i8**, i64 } %t34, 1
  %t36 = icmp sgt i64 %t35, 0
  %t37 = load %PythonBuilder, %PythonBuilder* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then0, label %merge1
then0:
  %t41 = load %PythonBuilder, %PythonBuilder* %l0
  %s42 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1779553665, i32 0, i32 0
  %t43 = extractvalue %NativeFunction %function, 3
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t45 = call i8* @join_with_separator({ i8**, i64 }* %t43, i8* %s44)
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %s42, i8* %t45)
  %t47 = call %PythonBuilder @builder_emit(%PythonBuilder %t41, i8* %t46)
  store %PythonBuilder %t47, %PythonBuilder* %l0
  %t48 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge1
merge1:
  %t49 = phi %PythonBuilder [ %t48, %then0 ], [ %t37, %block.entry ]
  store %PythonBuilder %t49, %PythonBuilder* %l0
  %t50 = extractvalue %NativeFunction %function, 4
  %t51 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t50
  %t52 = extractvalue { %NativeInstruction*, i64 } %t51, 1
  %t53 = icmp eq i64 %t52, 0
  %t54 = load %PythonBuilder, %PythonBuilder* %l0
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t57 = load i8*, i8** %l3
  br i1 %t53, label %then2, label %merge3
then2:
  %t58 = load %PythonBuilder, %PythonBuilder* %l0
  %s59 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t60 = call %PythonBuilder @builder_emit(%PythonBuilder %t58, i8* %s59)
  store %PythonBuilder %t60, %PythonBuilder* %l0
  %t61 = load %PythonBuilder, %PythonBuilder* %l0
  %t62 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t61)
  store %PythonBuilder %t62, %PythonBuilder* %l0
  %t63 = load %PythonBuilder, %PythonBuilder* %l0
  %t64 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t63, 0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t66 = insertvalue %PythonFunctionEmission %t64, { i8**, i64 }* %t65, 1
  ret %PythonFunctionEmission %t66
merge3:
  %t67 = sitofp i64 0 to double
  store double %t67, double* %l4
  %t68 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t69 = ptrtoint [0 x %MatchContext]* %t68 to i64
  %t70 = icmp eq i64 %t69, 0
  %t71 = select i1 %t70, i64 1, i64 %t69
  %t72 = call i8* @malloc(i64 %t71)
  %t73 = bitcast i8* %t72 to %MatchContext*
  %t74 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t75 = ptrtoint { %MatchContext*, i64 }* %t74 to i64
  %t76 = call i8* @malloc(i64 %t75)
  %t77 = bitcast i8* %t76 to { %MatchContext*, i64 }*
  %t78 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t77, i32 0, i32 0
  store %MatchContext* %t73, %MatchContext** %t78
  %t79 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t77, i32 0, i32 1
  store i64 0, i64* %t79
  store { %MatchContext*, i64 }* %t77, { %MatchContext*, i64 }** %l5
  %t80 = sitofp i64 0 to double
  store double %t80, double* %l6
  %t81 = sitofp i64 0 to double
  store double %t81, double* %l7
  %t82 = load %PythonBuilder, %PythonBuilder* %l0
  %t83 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t85 = load i8*, i8** %l3
  %t86 = load double, double* %l4
  %t87 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t88 = load double, double* %l6
  %t89 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t2566 = phi %PythonBuilder [ %t82, %merge3 ], [ %t2560, %loop.latch6 ]
  %t2567 = phi double [ %t89, %merge3 ], [ %t2561, %loop.latch6 ]
  %t2568 = phi double [ %t86, %merge3 ], [ %t2562, %loop.latch6 ]
  %t2569 = phi { i8**, i64 }* [ %t83, %merge3 ], [ %t2563, %loop.latch6 ]
  %t2570 = phi double [ %t88, %merge3 ], [ %t2564, %loop.latch6 ]
  %t2571 = phi { %MatchContext*, i64 }* [ %t87, %merge3 ], [ %t2565, %loop.latch6 ]
  store %PythonBuilder %t2566, %PythonBuilder* %l0
  store double %t2567, double* %l7
  store double %t2568, double* %l4
  store { i8**, i64 }* %t2569, { i8**, i64 }** %l1
  store double %t2570, double* %l6
  store { %MatchContext*, i64 }* %t2571, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t90 = load double, double* %l7
  %t91 = extractvalue %NativeFunction %function, 4
  %t92 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t91
  %t93 = extractvalue { %NativeInstruction*, i64 } %t92, 1
  %t94 = sitofp i64 %t93 to double
  %t95 = fcmp oge double %t90, %t94
  %t96 = load %PythonBuilder, %PythonBuilder* %l0
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t99 = load i8*, i8** %l3
  %t100 = load double, double* %l4
  %t101 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t102 = load double, double* %l6
  %t103 = load double, double* %l7
  br i1 %t95, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t104 = extractvalue %NativeFunction %function, 4
  %t105 = load double, double* %l7
  %t106 = call double @llvm.round.f64(double %t105)
  %t107 = fptosi double %t106 to i64
  %t108 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t104
  %t109 = extractvalue { %NativeInstruction*, i64 } %t108, 0
  %t110 = extractvalue { %NativeInstruction*, i64 } %t108, 1
  %t111 = icmp uge i64 %t107, %t110
  ; bounds check: %t111 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t107, i64 %t110)
  %t112 = getelementptr %NativeInstruction, %NativeInstruction* %t109, i64 %t107
  %t113 = load %NativeInstruction, %NativeInstruction* %t112
  store %NativeInstruction %t113, %NativeInstruction* %l8
  %t114 = load %NativeInstruction, %NativeInstruction* %l8
  %t115 = extractvalue %NativeInstruction %t114, 0
  %t116 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t117 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t118 = icmp eq i32 %t115, 0
  %t119 = select i1 %t118, i8* %t117, i8* %t116
  %t120 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t121 = icmp eq i32 %t115, 1
  %t122 = select i1 %t121, i8* %t120, i8* %t119
  %t123 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t124 = icmp eq i32 %t115, 2
  %t125 = select i1 %t124, i8* %t123, i8* %t122
  %t126 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t127 = icmp eq i32 %t115, 3
  %t128 = select i1 %t127, i8* %t126, i8* %t125
  %t129 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t130 = icmp eq i32 %t115, 4
  %t131 = select i1 %t130, i8* %t129, i8* %t128
  %t132 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t133 = icmp eq i32 %t115, 5
  %t134 = select i1 %t133, i8* %t132, i8* %t131
  %t135 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t136 = icmp eq i32 %t115, 6
  %t137 = select i1 %t136, i8* %t135, i8* %t134
  %t138 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t139 = icmp eq i32 %t115, 7
  %t140 = select i1 %t139, i8* %t138, i8* %t137
  %t141 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t142 = icmp eq i32 %t115, 8
  %t143 = select i1 %t142, i8* %t141, i8* %t140
  %t144 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t145 = icmp eq i32 %t115, 9
  %t146 = select i1 %t145, i8* %t144, i8* %t143
  %t147 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t148 = icmp eq i32 %t115, 10
  %t149 = select i1 %t148, i8* %t147, i8* %t146
  %t150 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t151 = icmp eq i32 %t115, 11
  %t152 = select i1 %t151, i8* %t150, i8* %t149
  %t153 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t154 = icmp eq i32 %t115, 12
  %t155 = select i1 %t154, i8* %t153, i8* %t152
  %t156 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t157 = icmp eq i32 %t115, 13
  %t158 = select i1 %t157, i8* %t156, i8* %t155
  %t159 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t160 = icmp eq i32 %t115, 14
  %t161 = select i1 %t160, i8* %t159, i8* %t158
  %t162 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t163 = icmp eq i32 %t115, 15
  %t164 = select i1 %t163, i8* %t162, i8* %t161
  %t165 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t166 = icmp eq i32 %t115, 16
  %t167 = select i1 %t166, i8* %t165, i8* %t164
  %s168 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h536277508, i32 0, i32 0
  %t169 = call i1 @strings_equal(i8* %t167, i8* %s168)
  %t170 = load %PythonBuilder, %PythonBuilder* %l0
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t173 = load i8*, i8** %l3
  %t174 = load double, double* %l4
  %t175 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t176 = load double, double* %l6
  %t177 = load double, double* %l7
  %t178 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t169, label %then10, label %else11
then10:
  %t179 = load %NativeInstruction, %NativeInstruction* %l8
  %t180 = extractvalue %NativeInstruction %t179, 0
  %t181 = alloca %NativeInstruction
  store %NativeInstruction %t179, %NativeInstruction* %t181
  %t182 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t181, i32 0, i32 1
  %t183 = bitcast [16 x i8]* %t182 to i8*
  %t184 = bitcast i8* %t183 to i8**
  %t185 = load i8*, i8** %t184
  %t186 = icmp eq i32 %t180, 0
  %t187 = select i1 %t186, i8* %t185, i8* null
  %t188 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t181, i32 0, i32 1
  %t189 = bitcast [16 x i8]* %t188 to i8*
  %t190 = bitcast i8* %t189 to i8**
  %t191 = load i8*, i8** %t190
  %t192 = icmp eq i32 %t180, 1
  %t193 = select i1 %t192, i8* %t191, i8* %t187
  %t194 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t181, i32 0, i32 1
  %t195 = bitcast [8 x i8]* %t194 to i8*
  %t196 = bitcast i8* %t195 to i8**
  %t197 = load i8*, i8** %t196
  %t198 = icmp eq i32 %t180, 12
  %t199 = select i1 %t198, i8* %t197, i8* %t193
  %t200 = call i64 @sailfin_runtime_string_length(i8* %t199)
  %t201 = icmp eq i64 %t200, 0
  %t202 = load %PythonBuilder, %PythonBuilder* %l0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t205 = load i8*, i8** %l3
  %t206 = load double, double* %l4
  %t207 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t208 = load double, double* %l6
  %t209 = load double, double* %l7
  %t210 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t201, label %then13, label %else14
then13:
  %t211 = load %PythonBuilder, %PythonBuilder* %l0
  %s212 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1061063223, i32 0, i32 0
  %t213 = call %PythonBuilder @builder_emit(%PythonBuilder %t211, i8* %s212)
  store %PythonBuilder %t213, %PythonBuilder* %l0
  %t214 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
else14:
  %t215 = load %NativeInstruction, %NativeInstruction* %l8
  %t216 = extractvalue %NativeInstruction %t215, 0
  %t217 = alloca %NativeInstruction
  store %NativeInstruction %t215, %NativeInstruction* %t217
  %t218 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t217, i32 0, i32 1
  %t219 = bitcast [16 x i8]* %t218 to i8*
  %t220 = bitcast i8* %t219 to i8**
  %t221 = load i8*, i8** %t220
  %t222 = icmp eq i32 %t216, 0
  %t223 = select i1 %t222, i8* %t221, i8* null
  %t224 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t217, i32 0, i32 1
  %t225 = bitcast [16 x i8]* %t224 to i8*
  %t226 = bitcast i8* %t225 to i8**
  %t227 = load i8*, i8** %t226
  %t228 = icmp eq i32 %t216, 1
  %t229 = select i1 %t228, i8* %t227, i8* %t223
  %t230 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t217, i32 0, i32 1
  %t231 = bitcast [8 x i8]* %t230 to i8*
  %t232 = bitcast i8* %t231 to i8**
  %t233 = load i8*, i8** %t232
  %t234 = icmp eq i32 %t216, 12
  %t235 = select i1 %t234, i8* %t233, i8* %t229
  store i8* %t235, i8** %l9
  %t236 = load i8*, i8** %l9
  %t237 = extractvalue %NativeFunction %function, 4
  %t238 = load double, double* %l7
  %t239 = sitofp i64 1 to double
  %t240 = fadd double %t238, %t239
  %t241 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t236, { %NativeInstruction*, i64 }* %t237, double %t240)
  store %StructLiteralCapture %t241, %StructLiteralCapture* %l10
  %t242 = sitofp i64 0 to double
  store double %t242, double* %l11
  %t243 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t244 = extractvalue %StructLiteralCapture %t243, 2
  %t245 = load %PythonBuilder, %PythonBuilder* %l0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t248 = load i8*, i8** %l3
  %t249 = load double, double* %l4
  %t250 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t251 = load double, double* %l6
  %t252 = load double, double* %l7
  %t253 = load %NativeInstruction, %NativeInstruction* %l8
  %t254 = load i8*, i8** %l9
  %t255 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t256 = load double, double* %l11
  br i1 %t244, label %then16, label %else17
then16:
  %t257 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t258 = extractvalue %StructLiteralCapture %t257, 0
  store i8* %t258, i8** %l9
  %t259 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t260 = extractvalue %StructLiteralCapture %t259, 1
  store double %t260, double* %l11
  %t261 = load i8*, i8** %l9
  %t262 = load double, double* %l11
  br label %merge18
else17:
  %t263 = load i8*, i8** %l9
  %t264 = extractvalue %NativeFunction %function, 4
  %t265 = load double, double* %l7
  %t266 = sitofp i64 1 to double
  %t267 = fadd double %t265, %t266
  %t268 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t263, { %NativeInstruction*, i64 }* %t264, double %t267)
  store %ExpressionContinuationCapture %t268, %ExpressionContinuationCapture* %l12
  %t269 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t270 = extractvalue %ExpressionContinuationCapture %t269, 2
  %t271 = load %PythonBuilder, %PythonBuilder* %l0
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t274 = load i8*, i8** %l3
  %t275 = load double, double* %l4
  %t276 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t277 = load double, double* %l6
  %t278 = load double, double* %l7
  %t279 = load %NativeInstruction, %NativeInstruction* %l8
  %t280 = load i8*, i8** %l9
  %t281 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t282 = load double, double* %l11
  %t283 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  br i1 %t270, label %then19, label %merge20
then19:
  %t284 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t285 = extractvalue %ExpressionContinuationCapture %t284, 0
  store i8* %t285, i8** %l9
  %t286 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t287 = extractvalue %ExpressionContinuationCapture %t286, 1
  store double %t287, double* %l11
  %t288 = load i8*, i8** %l9
  %t289 = load double, double* %l11
  br label %merge20
merge20:
  %t290 = phi i8* [ %t288, %then19 ], [ %t280, %else17 ]
  %t291 = phi double [ %t289, %then19 ], [ %t282, %else17 ]
  store i8* %t290, i8** %l9
  store double %t291, double* %l11
  %t292 = load i8*, i8** %l9
  %t293 = load double, double* %l11
  br label %merge18
merge18:
  %t294 = phi i8* [ %t261, %then16 ], [ %t292, %merge20 ]
  %t295 = phi double [ %t262, %then16 ], [ %t293, %merge20 ]
  store i8* %t294, i8** %l9
  store double %t295, double* %l11
  %t296 = load %PythonBuilder, %PythonBuilder* %l0
  %s297 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t298 = load i8*, i8** %l9
  %t299 = call i8* @lower_expression(i8* %t298)
  %t300 = call i8* @sailfin_runtime_string_concat(i8* %s297, i8* %t299)
  %t301 = call %PythonBuilder @builder_emit(%PythonBuilder %t296, i8* %t300)
  store %PythonBuilder %t301, %PythonBuilder* %l0
  %t302 = load double, double* %l7
  %t303 = load double, double* %l11
  %t304 = fadd double %t302, %t303
  store double %t304, double* %l7
  %t305 = load %PythonBuilder, %PythonBuilder* %l0
  %t306 = load double, double* %l7
  br label %merge15
merge15:
  %t307 = phi %PythonBuilder [ %t214, %then13 ], [ %t305, %merge18 ]
  %t308 = phi double [ %t209, %then13 ], [ %t306, %merge18 ]
  store %PythonBuilder %t307, %PythonBuilder* %l0
  store double %t308, double* %l7
  %t309 = load %PythonBuilder, %PythonBuilder* %l0
  %t310 = load %PythonBuilder, %PythonBuilder* %l0
  %t311 = load double, double* %l7
  br label %merge12
else11:
  %t312 = load %NativeInstruction, %NativeInstruction* %l8
  %t313 = extractvalue %NativeInstruction %t312, 0
  %t314 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t315 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t316 = icmp eq i32 %t313, 0
  %t317 = select i1 %t316, i8* %t315, i8* %t314
  %t318 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t319 = icmp eq i32 %t313, 1
  %t320 = select i1 %t319, i8* %t318, i8* %t317
  %t321 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t322 = icmp eq i32 %t313, 2
  %t323 = select i1 %t322, i8* %t321, i8* %t320
  %t324 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t325 = icmp eq i32 %t313, 3
  %t326 = select i1 %t325, i8* %t324, i8* %t323
  %t327 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t328 = icmp eq i32 %t313, 4
  %t329 = select i1 %t328, i8* %t327, i8* %t326
  %t330 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t331 = icmp eq i32 %t313, 5
  %t332 = select i1 %t331, i8* %t330, i8* %t329
  %t333 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t334 = icmp eq i32 %t313, 6
  %t335 = select i1 %t334, i8* %t333, i8* %t332
  %t336 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t337 = icmp eq i32 %t313, 7
  %t338 = select i1 %t337, i8* %t336, i8* %t335
  %t339 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t340 = icmp eq i32 %t313, 8
  %t341 = select i1 %t340, i8* %t339, i8* %t338
  %t342 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t343 = icmp eq i32 %t313, 9
  %t344 = select i1 %t343, i8* %t342, i8* %t341
  %t345 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t346 = icmp eq i32 %t313, 10
  %t347 = select i1 %t346, i8* %t345, i8* %t344
  %t348 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t349 = icmp eq i32 %t313, 11
  %t350 = select i1 %t349, i8* %t348, i8* %t347
  %t351 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t352 = icmp eq i32 %t313, 12
  %t353 = select i1 %t352, i8* %t351, i8* %t350
  %t354 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t355 = icmp eq i32 %t313, 13
  %t356 = select i1 %t355, i8* %t354, i8* %t353
  %t357 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t358 = icmp eq i32 %t313, 14
  %t359 = select i1 %t358, i8* %t357, i8* %t356
  %t360 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t361 = icmp eq i32 %t313, 15
  %t362 = select i1 %t361, i8* %t360, i8* %t359
  %t363 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t364 = icmp eq i32 %t313, 16
  %t365 = select i1 %t364, i8* %t363, i8* %t362
  %s366 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t367 = call i1 @strings_equal(i8* %t365, i8* %s366)
  %t368 = load %PythonBuilder, %PythonBuilder* %l0
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t371 = load i8*, i8** %l3
  %t372 = load double, double* %l4
  %t373 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t374 = load double, double* %l6
  %t375 = load double, double* %l7
  %t376 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t367, label %then21, label %else22
then21:
  %t377 = load %NativeInstruction, %NativeInstruction* %l8
  %t378 = extractvalue %NativeInstruction %t377, 0
  %t379 = alloca %NativeInstruction
  store %NativeInstruction %t377, %NativeInstruction* %t379
  %t380 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t379, i32 0, i32 1
  %t381 = bitcast [16 x i8]* %t380 to i8*
  %t382 = bitcast i8* %t381 to i8**
  %t383 = load i8*, i8** %t382
  %t384 = icmp eq i32 %t378, 0
  %t385 = select i1 %t384, i8* %t383, i8* null
  %t386 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t379, i32 0, i32 1
  %t387 = bitcast [16 x i8]* %t386 to i8*
  %t388 = bitcast i8* %t387 to i8**
  %t389 = load i8*, i8** %t388
  %t390 = icmp eq i32 %t378, 1
  %t391 = select i1 %t390, i8* %t389, i8* %t385
  %t392 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t379, i32 0, i32 1
  %t393 = bitcast [8 x i8]* %t392 to i8*
  %t394 = bitcast i8* %t393 to i8**
  %t395 = load i8*, i8** %t394
  %t396 = icmp eq i32 %t378, 12
  %t397 = select i1 %t396, i8* %t395, i8* %t391
  store i8* %t397, i8** %l13
  %t398 = load i8*, i8** %l13
  %t399 = extractvalue %NativeFunction %function, 4
  %t400 = load double, double* %l7
  %t401 = sitofp i64 1 to double
  %t402 = fadd double %t400, %t401
  %t403 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t398, { %NativeInstruction*, i64 }* %t399, double %t402)
  store %StructLiteralCapture %t403, %StructLiteralCapture* %l14
  %t404 = sitofp i64 0 to double
  store double %t404, double* %l15
  %t405 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t406 = extractvalue %StructLiteralCapture %t405, 2
  %t407 = load %PythonBuilder, %PythonBuilder* %l0
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t410 = load i8*, i8** %l3
  %t411 = load double, double* %l4
  %t412 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t413 = load double, double* %l6
  %t414 = load double, double* %l7
  %t415 = load %NativeInstruction, %NativeInstruction* %l8
  %t416 = load i8*, i8** %l13
  %t417 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t418 = load double, double* %l15
  br i1 %t406, label %then24, label %else25
then24:
  %t419 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t420 = extractvalue %StructLiteralCapture %t419, 0
  store i8* %t420, i8** %l13
  %t421 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t422 = extractvalue %StructLiteralCapture %t421, 1
  store double %t422, double* %l15
  %t423 = load i8*, i8** %l13
  %t424 = load double, double* %l15
  br label %merge26
else25:
  %t425 = load i8*, i8** %l13
  %t426 = extractvalue %NativeFunction %function, 4
  %t427 = load double, double* %l7
  %t428 = sitofp i64 1 to double
  %t429 = fadd double %t427, %t428
  %t430 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t425, { %NativeInstruction*, i64 }* %t426, double %t429)
  store %ExpressionContinuationCapture %t430, %ExpressionContinuationCapture* %l16
  %t431 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t432 = extractvalue %ExpressionContinuationCapture %t431, 2
  %t433 = load %PythonBuilder, %PythonBuilder* %l0
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t436 = load i8*, i8** %l3
  %t437 = load double, double* %l4
  %t438 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t439 = load double, double* %l6
  %t440 = load double, double* %l7
  %t441 = load %NativeInstruction, %NativeInstruction* %l8
  %t442 = load i8*, i8** %l13
  %t443 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t444 = load double, double* %l15
  %t445 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  br i1 %t432, label %then27, label %merge28
then27:
  %t446 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t447 = extractvalue %ExpressionContinuationCapture %t446, 0
  store i8* %t447, i8** %l13
  %t448 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t449 = extractvalue %ExpressionContinuationCapture %t448, 1
  store double %t449, double* %l15
  %t450 = load i8*, i8** %l13
  %t451 = load double, double* %l15
  br label %merge28
merge28:
  %t452 = phi i8* [ %t450, %then27 ], [ %t442, %else25 ]
  %t453 = phi double [ %t451, %then27 ], [ %t444, %else25 ]
  store i8* %t452, i8** %l13
  store double %t453, double* %l15
  %t454 = load i8*, i8** %l13
  %t455 = load double, double* %l15
  br label %merge26
merge26:
  %t456 = phi i8* [ %t423, %then24 ], [ %t454, %merge28 ]
  %t457 = phi double [ %t424, %then24 ], [ %t455, %merge28 ]
  store i8* %t456, i8** %l13
  store double %t457, double* %l15
  %t458 = load %PythonBuilder, %PythonBuilder* %l0
  %t459 = load i8*, i8** %l13
  %t460 = call i8* @lower_expression(i8* %t459)
  %t461 = call %PythonBuilder @builder_emit(%PythonBuilder %t458, i8* %t460)
  store %PythonBuilder %t461, %PythonBuilder* %l0
  %t462 = load double, double* %l7
  %t463 = load double, double* %l15
  %t464 = fadd double %t462, %t463
  store double %t464, double* %l7
  %t465 = load %PythonBuilder, %PythonBuilder* %l0
  %t466 = load double, double* %l7
  br label %merge23
else22:
  %t467 = load %NativeInstruction, %NativeInstruction* %l8
  %t468 = extractvalue %NativeInstruction %t467, 0
  %t469 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t470 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t471 = icmp eq i32 %t468, 0
  %t472 = select i1 %t471, i8* %t470, i8* %t469
  %t473 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t474 = icmp eq i32 %t468, 1
  %t475 = select i1 %t474, i8* %t473, i8* %t472
  %t476 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t477 = icmp eq i32 %t468, 2
  %t478 = select i1 %t477, i8* %t476, i8* %t475
  %t479 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t480 = icmp eq i32 %t468, 3
  %t481 = select i1 %t480, i8* %t479, i8* %t478
  %t482 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t483 = icmp eq i32 %t468, 4
  %t484 = select i1 %t483, i8* %t482, i8* %t481
  %t485 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t486 = icmp eq i32 %t468, 5
  %t487 = select i1 %t486, i8* %t485, i8* %t484
  %t488 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t489 = icmp eq i32 %t468, 6
  %t490 = select i1 %t489, i8* %t488, i8* %t487
  %t491 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t492 = icmp eq i32 %t468, 7
  %t493 = select i1 %t492, i8* %t491, i8* %t490
  %t494 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t495 = icmp eq i32 %t468, 8
  %t496 = select i1 %t495, i8* %t494, i8* %t493
  %t497 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t498 = icmp eq i32 %t468, 9
  %t499 = select i1 %t498, i8* %t497, i8* %t496
  %t500 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t501 = icmp eq i32 %t468, 10
  %t502 = select i1 %t501, i8* %t500, i8* %t499
  %t503 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t504 = icmp eq i32 %t468, 11
  %t505 = select i1 %t504, i8* %t503, i8* %t502
  %t506 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t507 = icmp eq i32 %t468, 12
  %t508 = select i1 %t507, i8* %t506, i8* %t505
  %t509 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t510 = icmp eq i32 %t468, 13
  %t511 = select i1 %t510, i8* %t509, i8* %t508
  %t512 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t513 = icmp eq i32 %t468, 14
  %t514 = select i1 %t513, i8* %t512, i8* %t511
  %t515 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t516 = icmp eq i32 %t468, 15
  %t517 = select i1 %t516, i8* %t515, i8* %t514
  %t518 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t519 = icmp eq i32 %t468, 16
  %t520 = select i1 %t519, i8* %t518, i8* %t517
  %s521 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t522 = call i1 @strings_equal(i8* %t520, i8* %s521)
  %t523 = load %PythonBuilder, %PythonBuilder* %l0
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t526 = load i8*, i8** %l3
  %t527 = load double, double* %l4
  %t528 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t529 = load double, double* %l6
  %t530 = load double, double* %l7
  %t531 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t522, label %then29, label %else30
then29:
  %t532 = load %NativeInstruction, %NativeInstruction* %l8
  %t533 = extractvalue %NativeInstruction %t532, 0
  %t534 = alloca %NativeInstruction
  store %NativeInstruction %t532, %NativeInstruction* %t534
  %t535 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t534, i32 0, i32 1
  %t536 = bitcast [48 x i8]* %t535 to i8*
  %t537 = bitcast i8* %t536 to i8**
  %t538 = load i8*, i8** %t537
  %t539 = icmp eq i32 %t533, 2
  %t540 = select i1 %t539, i8* %t538, i8* null
  %t541 = call i8* @sanitize_identifier(i8* %t540)
  store i8* %t541, i8** %l17
  %t542 = load i8*, i8** %l17
  %s543 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t544 = call i8* @sailfin_runtime_string_concat(i8* %t542, i8* %s543)
  store i8* %t544, i8** %l18
  %t545 = load %NativeInstruction, %NativeInstruction* %l8
  %t546 = extractvalue %NativeInstruction %t545, 0
  %t547 = alloca %NativeInstruction
  store %NativeInstruction %t545, %NativeInstruction* %t547
  %t548 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t547, i32 0, i32 1
  %t549 = bitcast [48 x i8]* %t548 to i8*
  %t550 = getelementptr inbounds i8, i8* %t549, i64 24
  %t551 = bitcast i8* %t550 to i8**
  %t552 = load i8*, i8** %t551
  %t553 = icmp eq i32 %t546, 2
  %t554 = select i1 %t553, i8* %t552, i8* null
  %t555 = icmp ne i8* %t554, null
  %t556 = load %PythonBuilder, %PythonBuilder* %l0
  %t557 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t559 = load i8*, i8** %l3
  %t560 = load double, double* %l4
  %t561 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t562 = load double, double* %l6
  %t563 = load double, double* %l7
  %t564 = load %NativeInstruction, %NativeInstruction* %l8
  %t565 = load i8*, i8** %l17
  %t566 = load i8*, i8** %l18
  br i1 %t555, label %then32, label %else33
then32:
  %t567 = load %NativeInstruction, %NativeInstruction* %l8
  %t568 = extractvalue %NativeInstruction %t567, 0
  %t569 = alloca %NativeInstruction
  store %NativeInstruction %t567, %NativeInstruction* %t569
  %t570 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t569, i32 0, i32 1
  %t571 = bitcast [48 x i8]* %t570 to i8*
  %t572 = getelementptr inbounds i8, i8* %t571, i64 24
  %t573 = bitcast i8* %t572 to i8**
  %t574 = load i8*, i8** %t573
  %t575 = icmp eq i32 %t568, 2
  %t576 = select i1 %t575, i8* %t574, i8* null
  store i8* %t576, i8** %l19
  %t577 = load i8*, i8** %l19
  %t578 = extractvalue %NativeFunction %function, 4
  %t579 = load double, double* %l7
  %t580 = sitofp i64 1 to double
  %t581 = fadd double %t579, %t580
  %t582 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t577, { %NativeInstruction*, i64 }* %t578, double %t581)
  store %StructLiteralCapture %t582, %StructLiteralCapture* %l20
  %t583 = sitofp i64 0 to double
  store double %t583, double* %l21
  %t584 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t585 = extractvalue %StructLiteralCapture %t584, 2
  %t586 = load %PythonBuilder, %PythonBuilder* %l0
  %t587 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t588 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t589 = load i8*, i8** %l3
  %t590 = load double, double* %l4
  %t591 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t592 = load double, double* %l6
  %t593 = load double, double* %l7
  %t594 = load %NativeInstruction, %NativeInstruction* %l8
  %t595 = load i8*, i8** %l17
  %t596 = load i8*, i8** %l18
  %t597 = load i8*, i8** %l19
  %t598 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t599 = load double, double* %l21
  br i1 %t585, label %then35, label %else36
then35:
  %t600 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t601 = extractvalue %StructLiteralCapture %t600, 0
  store i8* %t601, i8** %l19
  %t602 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t603 = extractvalue %StructLiteralCapture %t602, 1
  store double %t603, double* %l21
  %t604 = load i8*, i8** %l19
  %t605 = load double, double* %l21
  br label %merge37
else36:
  %t606 = load i8*, i8** %l19
  %t607 = extractvalue %NativeFunction %function, 4
  %t608 = load double, double* %l7
  %t609 = sitofp i64 1 to double
  %t610 = fadd double %t608, %t609
  %t611 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t606, { %NativeInstruction*, i64 }* %t607, double %t610)
  store %ExpressionContinuationCapture %t611, %ExpressionContinuationCapture* %l22
  %t612 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t613 = extractvalue %ExpressionContinuationCapture %t612, 2
  %t614 = load %PythonBuilder, %PythonBuilder* %l0
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t616 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t617 = load i8*, i8** %l3
  %t618 = load double, double* %l4
  %t619 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t620 = load double, double* %l6
  %t621 = load double, double* %l7
  %t622 = load %NativeInstruction, %NativeInstruction* %l8
  %t623 = load i8*, i8** %l17
  %t624 = load i8*, i8** %l18
  %t625 = load i8*, i8** %l19
  %t626 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t627 = load double, double* %l21
  %t628 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  br i1 %t613, label %then38, label %merge39
then38:
  %t629 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t630 = extractvalue %ExpressionContinuationCapture %t629, 0
  store i8* %t630, i8** %l19
  %t631 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t632 = extractvalue %ExpressionContinuationCapture %t631, 1
  store double %t632, double* %l21
  %t633 = load i8*, i8** %l19
  %t634 = load double, double* %l21
  br label %merge39
merge39:
  %t635 = phi i8* [ %t633, %then38 ], [ %t625, %else36 ]
  %t636 = phi double [ %t634, %then38 ], [ %t627, %else36 ]
  store i8* %t635, i8** %l19
  store double %t636, double* %l21
  %t637 = load i8*, i8** %l19
  %t638 = load double, double* %l21
  br label %merge37
merge37:
  %t639 = phi i8* [ %t604, %then35 ], [ %t637, %merge39 ]
  %t640 = phi double [ %t605, %then35 ], [ %t638, %merge39 ]
  store i8* %t639, i8** %l19
  store double %t640, double* %l21
  %t641 = load i8*, i8** %l18
  %t642 = load i8*, i8** %l19
  %t643 = call i8* @lower_expression(i8* %t642)
  %t644 = call i8* @sailfin_runtime_string_concat(i8* %t641, i8* %t643)
  store i8* %t644, i8** %l18
  %t645 = load double, double* %l7
  %t646 = load double, double* %l21
  %t647 = fadd double %t645, %t646
  store double %t647, double* %l7
  %t648 = load i8*, i8** %l18
  %t649 = load double, double* %l7
  br label %merge34
else33:
  %t650 = load i8*, i8** %l18
  %s651 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t652 = call i8* @sailfin_runtime_string_concat(i8* %t650, i8* %s651)
  store i8* %t652, i8** %l18
  %t653 = load i8*, i8** %l18
  br label %merge34
merge34:
  %t654 = phi i8* [ %t648, %merge37 ], [ %t653, %else33 ]
  %t655 = phi double [ %t649, %merge37 ], [ %t563, %else33 ]
  store i8* %t654, i8** %l18
  store double %t655, double* %l7
  %t656 = load %PythonBuilder, %PythonBuilder* %l0
  %t657 = load i8*, i8** %l18
  %t658 = call %PythonBuilder @builder_emit(%PythonBuilder %t656, i8* %t657)
  store %PythonBuilder %t658, %PythonBuilder* %l0
  %t659 = load double, double* %l7
  %t660 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
else30:
  %t661 = load %NativeInstruction, %NativeInstruction* %l8
  %t662 = extractvalue %NativeInstruction %t661, 0
  %t663 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t664 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t665 = icmp eq i32 %t662, 0
  %t666 = select i1 %t665, i8* %t664, i8* %t663
  %t667 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t668 = icmp eq i32 %t662, 1
  %t669 = select i1 %t668, i8* %t667, i8* %t666
  %t670 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t671 = icmp eq i32 %t662, 2
  %t672 = select i1 %t671, i8* %t670, i8* %t669
  %t673 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t674 = icmp eq i32 %t662, 3
  %t675 = select i1 %t674, i8* %t673, i8* %t672
  %t676 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t677 = icmp eq i32 %t662, 4
  %t678 = select i1 %t677, i8* %t676, i8* %t675
  %t679 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t680 = icmp eq i32 %t662, 5
  %t681 = select i1 %t680, i8* %t679, i8* %t678
  %t682 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t683 = icmp eq i32 %t662, 6
  %t684 = select i1 %t683, i8* %t682, i8* %t681
  %t685 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t686 = icmp eq i32 %t662, 7
  %t687 = select i1 %t686, i8* %t685, i8* %t684
  %t688 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t689 = icmp eq i32 %t662, 8
  %t690 = select i1 %t689, i8* %t688, i8* %t687
  %t691 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t692 = icmp eq i32 %t662, 9
  %t693 = select i1 %t692, i8* %t691, i8* %t690
  %t694 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t695 = icmp eq i32 %t662, 10
  %t696 = select i1 %t695, i8* %t694, i8* %t693
  %t697 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t698 = icmp eq i32 %t662, 11
  %t699 = select i1 %t698, i8* %t697, i8* %t696
  %t700 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t701 = icmp eq i32 %t662, 12
  %t702 = select i1 %t701, i8* %t700, i8* %t699
  %t703 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t704 = icmp eq i32 %t662, 13
  %t705 = select i1 %t704, i8* %t703, i8* %t702
  %t706 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t707 = icmp eq i32 %t662, 14
  %t708 = select i1 %t707, i8* %t706, i8* %t705
  %t709 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t710 = icmp eq i32 %t662, 15
  %t711 = select i1 %t710, i8* %t709, i8* %t708
  %t712 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t713 = icmp eq i32 %t662, 16
  %t714 = select i1 %t713, i8* %t712, i8* %t711
  %s715 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193459862, i32 0, i32 0
  %t716 = call i1 @strings_equal(i8* %t714, i8* %s715)
  %t717 = load %PythonBuilder, %PythonBuilder* %l0
  %t718 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t719 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t720 = load i8*, i8** %l3
  %t721 = load double, double* %l4
  %t722 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t723 = load double, double* %l6
  %t724 = load double, double* %l7
  %t725 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t716, label %then40, label %else41
then40:
  %t726 = load %NativeInstruction, %NativeInstruction* %l8
  %t727 = extractvalue %NativeInstruction %t726, 0
  %t728 = alloca %NativeInstruction
  store %NativeInstruction %t726, %NativeInstruction* %t728
  %t729 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t728, i32 0, i32 1
  %t730 = bitcast [8 x i8]* %t729 to i8*
  %t731 = bitcast i8* %t730 to i8**
  %t732 = load i8*, i8** %t731
  %t733 = icmp eq i32 %t727, 3
  %t734 = select i1 %t733, i8* %t732, i8* null
  %t735 = call i8* @trim_text(i8* %t734)
  %t736 = call i8* @rewrite_expression_intrinsics(i8* %t735)
  store i8* %t736, i8** %l23
  %t737 = load %PythonBuilder, %PythonBuilder* %l0
  %s738 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t739 = load i8*, i8** %l23
  %t740 = call i8* @sailfin_runtime_string_concat(i8* %s738, i8* %t739)
  %t741 = add i64 0, 2
  %t742 = call i8* @malloc(i64 %t741)
  store i8 58, i8* %t742
  %t743 = getelementptr i8, i8* %t742, i64 1
  store i8 0, i8* %t743
  call void @sailfin_runtime_mark_persistent(i8* %t742)
  %t744 = call i8* @sailfin_runtime_string_concat(i8* %t740, i8* %t742)
  %t745 = call %PythonBuilder @builder_emit(%PythonBuilder %t737, i8* %t744)
  store %PythonBuilder %t745, %PythonBuilder* %l0
  %t746 = load %PythonBuilder, %PythonBuilder* %l0
  %t747 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t746)
  store %PythonBuilder %t747, %PythonBuilder* %l0
  %t748 = load double, double* %l4
  %t749 = sitofp i64 1 to double
  %t750 = fadd double %t748, %t749
  store double %t750, double* %l4
  %t751 = load %PythonBuilder, %PythonBuilder* %l0
  %t752 = load %PythonBuilder, %PythonBuilder* %l0
  %t753 = load double, double* %l4
  br label %merge42
else41:
  %t754 = load %NativeInstruction, %NativeInstruction* %l8
  %t755 = extractvalue %NativeInstruction %t754, 0
  %t756 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t757 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t758 = icmp eq i32 %t755, 0
  %t759 = select i1 %t758, i8* %t757, i8* %t756
  %t760 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t761 = icmp eq i32 %t755, 1
  %t762 = select i1 %t761, i8* %t760, i8* %t759
  %t763 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t764 = icmp eq i32 %t755, 2
  %t765 = select i1 %t764, i8* %t763, i8* %t762
  %t766 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t767 = icmp eq i32 %t755, 3
  %t768 = select i1 %t767, i8* %t766, i8* %t765
  %t769 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t770 = icmp eq i32 %t755, 4
  %t771 = select i1 %t770, i8* %t769, i8* %t768
  %t772 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t773 = icmp eq i32 %t755, 5
  %t774 = select i1 %t773, i8* %t772, i8* %t771
  %t775 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t776 = icmp eq i32 %t755, 6
  %t777 = select i1 %t776, i8* %t775, i8* %t774
  %t778 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t779 = icmp eq i32 %t755, 7
  %t780 = select i1 %t779, i8* %t778, i8* %t777
  %t781 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t782 = icmp eq i32 %t755, 8
  %t783 = select i1 %t782, i8* %t781, i8* %t780
  %t784 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t785 = icmp eq i32 %t755, 9
  %t786 = select i1 %t785, i8* %t784, i8* %t783
  %t787 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t788 = icmp eq i32 %t755, 10
  %t789 = select i1 %t788, i8* %t787, i8* %t786
  %t790 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t791 = icmp eq i32 %t755, 11
  %t792 = select i1 %t791, i8* %t790, i8* %t789
  %t793 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t794 = icmp eq i32 %t755, 12
  %t795 = select i1 %t794, i8* %t793, i8* %t792
  %t796 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t797 = icmp eq i32 %t755, 13
  %t798 = select i1 %t797, i8* %t796, i8* %t795
  %t799 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t800 = icmp eq i32 %t755, 14
  %t801 = select i1 %t800, i8* %t799, i8* %t798
  %t802 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t803 = icmp eq i32 %t755, 15
  %t804 = select i1 %t803, i8* %t802, i8* %t801
  %t805 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t806 = icmp eq i32 %t755, 16
  %t807 = select i1 %t806, i8* %t805, i8* %t804
  %s808 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h219990644, i32 0, i32 0
  %t809 = call i1 @strings_equal(i8* %t807, i8* %s808)
  %t810 = load %PythonBuilder, %PythonBuilder* %l0
  %t811 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t812 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t813 = load i8*, i8** %l3
  %t814 = load double, double* %l4
  %t815 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t816 = load double, double* %l6
  %t817 = load double, double* %l7
  %t818 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t809, label %then43, label %else44
then43:
  %t819 = load double, double* %l4
  %t820 = sitofp i64 0 to double
  %t821 = fcmp ogt double %t819, %t820
  %t822 = load %PythonBuilder, %PythonBuilder* %l0
  %t823 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t824 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t825 = load i8*, i8** %l3
  %t826 = load double, double* %l4
  %t827 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t828 = load double, double* %l6
  %t829 = load double, double* %l7
  %t830 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t821, label %then46, label %else47
then46:
  %t831 = load %PythonBuilder, %PythonBuilder* %l0
  %t832 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t831)
  store %PythonBuilder %t832, %PythonBuilder* %l0
  %t833 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge48
else47:
  %t834 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t835 = extractvalue %NativeFunction %function, 0
  %s836 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h2028465620, i32 0, i32 0
  %t837 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t834, i8* %t835, i8* %s836)
  store { i8**, i64 }* %t837, { i8**, i64 }** %l1
  %t838 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t839 = phi %PythonBuilder [ %t833, %then46 ], [ %t822, %else47 ]
  %t840 = phi { i8**, i64 }* [ %t823, %then46 ], [ %t838, %else47 ]
  store %PythonBuilder %t839, %PythonBuilder* %l0
  store { i8**, i64 }* %t840, { i8**, i64 }** %l1
  %t841 = load %PythonBuilder, %PythonBuilder* %l0
  %s842 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t843 = call %PythonBuilder @builder_emit(%PythonBuilder %t841, i8* %s842)
  store %PythonBuilder %t843, %PythonBuilder* %l0
  %t844 = load %PythonBuilder, %PythonBuilder* %l0
  %t845 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t844)
  store %PythonBuilder %t845, %PythonBuilder* %l0
  %t846 = load %PythonBuilder, %PythonBuilder* %l0
  %t847 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t848 = load %PythonBuilder, %PythonBuilder* %l0
  %t849 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
else44:
  %t850 = load %NativeInstruction, %NativeInstruction* %l8
  %t851 = extractvalue %NativeInstruction %t850, 0
  %t852 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t853 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t854 = icmp eq i32 %t851, 0
  %t855 = select i1 %t854, i8* %t853, i8* %t852
  %t856 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t857 = icmp eq i32 %t851, 1
  %t858 = select i1 %t857, i8* %t856, i8* %t855
  %t859 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t860 = icmp eq i32 %t851, 2
  %t861 = select i1 %t860, i8* %t859, i8* %t858
  %t862 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t863 = icmp eq i32 %t851, 3
  %t864 = select i1 %t863, i8* %t862, i8* %t861
  %t865 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t866 = icmp eq i32 %t851, 4
  %t867 = select i1 %t866, i8* %t865, i8* %t864
  %t868 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t869 = icmp eq i32 %t851, 5
  %t870 = select i1 %t869, i8* %t868, i8* %t867
  %t871 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t872 = icmp eq i32 %t851, 6
  %t873 = select i1 %t872, i8* %t871, i8* %t870
  %t874 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t875 = icmp eq i32 %t851, 7
  %t876 = select i1 %t875, i8* %t874, i8* %t873
  %t877 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t878 = icmp eq i32 %t851, 8
  %t879 = select i1 %t878, i8* %t877, i8* %t876
  %t880 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t881 = icmp eq i32 %t851, 9
  %t882 = select i1 %t881, i8* %t880, i8* %t879
  %t883 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t884 = icmp eq i32 %t851, 10
  %t885 = select i1 %t884, i8* %t883, i8* %t882
  %t886 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t887 = icmp eq i32 %t851, 11
  %t888 = select i1 %t887, i8* %t886, i8* %t885
  %t889 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t890 = icmp eq i32 %t851, 12
  %t891 = select i1 %t890, i8* %t889, i8* %t888
  %t892 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t893 = icmp eq i32 %t851, 13
  %t894 = select i1 %t893, i8* %t892, i8* %t891
  %t895 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t896 = icmp eq i32 %t851, 14
  %t897 = select i1 %t896, i8* %t895, i8* %t894
  %t898 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t899 = icmp eq i32 %t851, 15
  %t900 = select i1 %t899, i8* %t898, i8* %t897
  %t901 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t902 = icmp eq i32 %t851, 16
  %t903 = select i1 %t902, i8* %t901, i8* %t900
  %s904 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h819045845, i32 0, i32 0
  %t905 = call i1 @strings_equal(i8* %t903, i8* %s904)
  %t906 = load %PythonBuilder, %PythonBuilder* %l0
  %t907 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t908 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t909 = load i8*, i8** %l3
  %t910 = load double, double* %l4
  %t911 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t912 = load double, double* %l6
  %t913 = load double, double* %l7
  %t914 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t905, label %then49, label %else50
then49:
  %t915 = load double, double* %l4
  %t916 = sitofp i64 0 to double
  %t917 = fcmp ogt double %t915, %t916
  %t918 = load %PythonBuilder, %PythonBuilder* %l0
  %t919 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t920 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t921 = load i8*, i8** %l3
  %t922 = load double, double* %l4
  %t923 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t924 = load double, double* %l6
  %t925 = load double, double* %l7
  %t926 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t917, label %then52, label %else53
then52:
  %t927 = load %PythonBuilder, %PythonBuilder* %l0
  %t928 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t927)
  store %PythonBuilder %t928, %PythonBuilder* %l0
  %t929 = load double, double* %l4
  %t930 = sitofp i64 1 to double
  %t931 = fsub double %t929, %t930
  store double %t931, double* %l4
  %t932 = load %PythonBuilder, %PythonBuilder* %l0
  %t933 = load double, double* %l4
  br label %merge54
else53:
  %t934 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t935 = extractvalue %NativeFunction %function, 0
  %s936 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h458257002, i32 0, i32 0
  %t937 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t934, i8* %t935, i8* %s936)
  store { i8**, i64 }* %t937, { i8**, i64 }** %l1
  %t938 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge54
merge54:
  %t939 = phi %PythonBuilder [ %t932, %then52 ], [ %t918, %else53 ]
  %t940 = phi double [ %t933, %then52 ], [ %t922, %else53 ]
  %t941 = phi { i8**, i64 }* [ %t919, %then52 ], [ %t938, %else53 ]
  store %PythonBuilder %t939, %PythonBuilder* %l0
  store double %t940, double* %l4
  store { i8**, i64 }* %t941, { i8**, i64 }** %l1
  %t942 = load %PythonBuilder, %PythonBuilder* %l0
  %t943 = load double, double* %l4
  %t944 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge51
else50:
  %t945 = load %NativeInstruction, %NativeInstruction* %l8
  %t946 = extractvalue %NativeInstruction %t945, 0
  %t947 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t948 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t949 = icmp eq i32 %t946, 0
  %t950 = select i1 %t949, i8* %t948, i8* %t947
  %t951 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t952 = icmp eq i32 %t946, 1
  %t953 = select i1 %t952, i8* %t951, i8* %t950
  %t954 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t955 = icmp eq i32 %t946, 2
  %t956 = select i1 %t955, i8* %t954, i8* %t953
  %t957 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t958 = icmp eq i32 %t946, 3
  %t959 = select i1 %t958, i8* %t957, i8* %t956
  %t960 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t961 = icmp eq i32 %t946, 4
  %t962 = select i1 %t961, i8* %t960, i8* %t959
  %t963 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t964 = icmp eq i32 %t946, 5
  %t965 = select i1 %t964, i8* %t963, i8* %t962
  %t966 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t967 = icmp eq i32 %t946, 6
  %t968 = select i1 %t967, i8* %t966, i8* %t965
  %t969 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t970 = icmp eq i32 %t946, 7
  %t971 = select i1 %t970, i8* %t969, i8* %t968
  %t972 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t973 = icmp eq i32 %t946, 8
  %t974 = select i1 %t973, i8* %t972, i8* %t971
  %t975 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t976 = icmp eq i32 %t946, 9
  %t977 = select i1 %t976, i8* %t975, i8* %t974
  %t978 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t979 = icmp eq i32 %t946, 10
  %t980 = select i1 %t979, i8* %t978, i8* %t977
  %t981 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t982 = icmp eq i32 %t946, 11
  %t983 = select i1 %t982, i8* %t981, i8* %t980
  %t984 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t985 = icmp eq i32 %t946, 12
  %t986 = select i1 %t985, i8* %t984, i8* %t983
  %t987 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t988 = icmp eq i32 %t946, 13
  %t989 = select i1 %t988, i8* %t987, i8* %t986
  %t990 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t991 = icmp eq i32 %t946, 14
  %t992 = select i1 %t991, i8* %t990, i8* %t989
  %t993 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t994 = icmp eq i32 %t946, 15
  %t995 = select i1 %t994, i8* %t993, i8* %t992
  %t996 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t997 = icmp eq i32 %t946, 16
  %t998 = select i1 %t997, i8* %t996, i8* %t995
  %s999 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089113841, i32 0, i32 0
  %t1000 = call i1 @strings_equal(i8* %t998, i8* %s999)
  %t1001 = load %PythonBuilder, %PythonBuilder* %l0
  %t1002 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1003 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1004 = load i8*, i8** %l3
  %t1005 = load double, double* %l4
  %t1006 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1007 = load double, double* %l6
  %t1008 = load double, double* %l7
  %t1009 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1000, label %then55, label %else56
then55:
  %t1010 = load %NativeInstruction, %NativeInstruction* %l8
  %t1011 = extractvalue %NativeInstruction %t1010, 0
  %t1012 = alloca %NativeInstruction
  store %NativeInstruction %t1010, %NativeInstruction* %t1012
  %t1013 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1012, i32 0, i32 1
  %t1014 = bitcast [16 x i8]* %t1013 to i8*
  %t1015 = getelementptr inbounds i8, i8* %t1014, i64 8
  %t1016 = bitcast i8* %t1015 to i8**
  %t1017 = load i8*, i8** %t1016
  %t1018 = icmp eq i32 %t1011, 6
  %t1019 = select i1 %t1018, i8* %t1017, i8* null
  %t1020 = call i8* @trim_text(i8* %t1019)
  %t1021 = call i8* @rewrite_expression_intrinsics(i8* %t1020)
  store i8* %t1021, i8** %l24
  %t1022 = load %PythonBuilder, %PythonBuilder* %l0
  %s1023 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h259230482, i32 0, i32 0
  %t1024 = load %NativeInstruction, %NativeInstruction* %l8
  %t1025 = extractvalue %NativeInstruction %t1024, 0
  %t1026 = alloca %NativeInstruction
  store %NativeInstruction %t1024, %NativeInstruction* %t1026
  %t1027 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1026, i32 0, i32 1
  %t1028 = bitcast [16 x i8]* %t1027 to i8*
  %t1029 = bitcast i8* %t1028 to i8**
  %t1030 = load i8*, i8** %t1029
  %t1031 = icmp eq i32 %t1025, 6
  %t1032 = select i1 %t1031, i8* %t1030, i8* null
  %t1033 = call i8* @sailfin_runtime_string_concat(i8* %s1023, i8* %t1032)
  %s1034 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  %t1035 = call i8* @sailfin_runtime_string_concat(i8* %t1033, i8* %s1034)
  %t1036 = load i8*, i8** %l24
  %t1037 = call i8* @sailfin_runtime_string_concat(i8* %t1035, i8* %t1036)
  %t1038 = add i64 0, 2
  %t1039 = call i8* @malloc(i64 %t1038)
  store i8 58, i8* %t1039
  %t1040 = getelementptr i8, i8* %t1039, i64 1
  store i8 0, i8* %t1040
  call void @sailfin_runtime_mark_persistent(i8* %t1039)
  %t1041 = call i8* @sailfin_runtime_string_concat(i8* %t1037, i8* %t1039)
  %t1042 = call %PythonBuilder @builder_emit(%PythonBuilder %t1022, i8* %t1041)
  store %PythonBuilder %t1042, %PythonBuilder* %l0
  %t1043 = load %PythonBuilder, %PythonBuilder* %l0
  %t1044 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1043)
  store %PythonBuilder %t1044, %PythonBuilder* %l0
  %t1045 = load double, double* %l4
  %t1046 = sitofp i64 1 to double
  %t1047 = fadd double %t1045, %t1046
  store double %t1047, double* %l4
  %t1048 = load %PythonBuilder, %PythonBuilder* %l0
  %t1049 = load %PythonBuilder, %PythonBuilder* %l0
  %t1050 = load double, double* %l4
  br label %merge57
else56:
  %t1051 = load %NativeInstruction, %NativeInstruction* %l8
  %t1052 = extractvalue %NativeInstruction %t1051, 0
  %t1053 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1054 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1055 = icmp eq i32 %t1052, 0
  %t1056 = select i1 %t1055, i8* %t1054, i8* %t1053
  %t1057 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1052, 1
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1052, 2
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1052, 3
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1052, 4
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1052, 5
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1052, 6
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1052, 7
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1052, 8
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1052, 9
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1052, 10
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %t1087 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1088 = icmp eq i32 %t1052, 11
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1086
  %t1090 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1091 = icmp eq i32 %t1052, 12
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1089
  %t1093 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1094 = icmp eq i32 %t1052, 13
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1092
  %t1096 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1097 = icmp eq i32 %t1052, 14
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1095
  %t1099 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1052, 15
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1052, 16
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %s1105 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1258614714, i32 0, i32 0
  %t1106 = call i1 @strings_equal(i8* %t1104, i8* %s1105)
  %t1107 = load %PythonBuilder, %PythonBuilder* %l0
  %t1108 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1109 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1110 = load i8*, i8** %l3
  %t1111 = load double, double* %l4
  %t1112 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1113 = load double, double* %l6
  %t1114 = load double, double* %l7
  %t1115 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1106, label %then58, label %else59
then58:
  %t1116 = load double, double* %l4
  %t1117 = sitofp i64 0 to double
  %t1118 = fcmp ogt double %t1116, %t1117
  %t1119 = load %PythonBuilder, %PythonBuilder* %l0
  %t1120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1121 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1122 = load i8*, i8** %l3
  %t1123 = load double, double* %l4
  %t1124 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1125 = load double, double* %l6
  %t1126 = load double, double* %l7
  %t1127 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1118, label %then61, label %else62
then61:
  %t1128 = load %PythonBuilder, %PythonBuilder* %l0
  %t1129 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1128)
  store %PythonBuilder %t1129, %PythonBuilder* %l0
  %t1130 = load double, double* %l4
  %t1131 = sitofp i64 1 to double
  %t1132 = fsub double %t1130, %t1131
  store double %t1132, double* %l4
  %t1133 = load %PythonBuilder, %PythonBuilder* %l0
  %t1134 = load double, double* %l4
  br label %merge63
else62:
  %t1135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1136 = extractvalue %NativeFunction %function, 0
  %s1137 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1370567591, i32 0, i32 0
  %t1138 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1135, i8* %t1136, i8* %s1137)
  store { i8**, i64 }* %t1138, { i8**, i64 }** %l1
  %t1139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge63
merge63:
  %t1140 = phi %PythonBuilder [ %t1133, %then61 ], [ %t1119, %else62 ]
  %t1141 = phi double [ %t1134, %then61 ], [ %t1123, %else62 ]
  %t1142 = phi { i8**, i64 }* [ %t1120, %then61 ], [ %t1139, %else62 ]
  store %PythonBuilder %t1140, %PythonBuilder* %l0
  store double %t1141, double* %l4
  store { i8**, i64 }* %t1142, { i8**, i64 }** %l1
  %t1143 = load %PythonBuilder, %PythonBuilder* %l0
  %t1144 = load double, double* %l4
  %t1145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge60
else59:
  %t1146 = load %NativeInstruction, %NativeInstruction* %l8
  %t1147 = extractvalue %NativeInstruction %t1146, 0
  %t1148 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1149 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1150 = icmp eq i32 %t1147, 0
  %t1151 = select i1 %t1150, i8* %t1149, i8* %t1148
  %t1152 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1147, 1
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1147, 2
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1147, 3
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1147, 4
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1147, 5
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1147, 6
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1147, 7
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1147, 8
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1147, 9
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1147, 10
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1147, 11
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1147, 12
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1147, 13
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1147, 14
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1147, 15
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1147, 16
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %s1200 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h228395909, i32 0, i32 0
  %t1201 = call i1 @strings_equal(i8* %t1199, i8* %s1200)
  %t1202 = load %PythonBuilder, %PythonBuilder* %l0
  %t1203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1204 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1205 = load i8*, i8** %l3
  %t1206 = load double, double* %l4
  %t1207 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1208 = load double, double* %l6
  %t1209 = load double, double* %l7
  %t1210 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1201, label %then64, label %else65
then64:
  %t1211 = load %PythonBuilder, %PythonBuilder* %l0
  %s1212 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t1213 = call %PythonBuilder @builder_emit(%PythonBuilder %t1211, i8* %s1212)
  store %PythonBuilder %t1213, %PythonBuilder* %l0
  %t1214 = load %PythonBuilder, %PythonBuilder* %l0
  %t1215 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1214)
  store %PythonBuilder %t1215, %PythonBuilder* %l0
  %t1216 = load double, double* %l4
  %t1217 = sitofp i64 1 to double
  %t1218 = fadd double %t1216, %t1217
  store double %t1218, double* %l4
  %t1219 = load %PythonBuilder, %PythonBuilder* %l0
  %t1220 = load %PythonBuilder, %PythonBuilder* %l0
  %t1221 = load double, double* %l4
  br label %merge66
else65:
  %t1222 = load %NativeInstruction, %NativeInstruction* %l8
  %t1223 = extractvalue %NativeInstruction %t1222, 0
  %t1224 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1225 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1226 = icmp eq i32 %t1223, 0
  %t1227 = select i1 %t1226, i8* %t1225, i8* %t1224
  %t1228 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1223, 1
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %t1231 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1223, 2
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1223, 3
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1223, 4
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %t1240 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1241 = icmp eq i32 %t1223, 5
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1239
  %t1243 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1244 = icmp eq i32 %t1223, 6
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1242
  %t1246 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1247 = icmp eq i32 %t1223, 7
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1245
  %t1249 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1250 = icmp eq i32 %t1223, 8
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1248
  %t1252 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1223, 9
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1223, 10
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1223, 11
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1223, 12
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1223, 13
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1223, 14
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1223, 15
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1223, 16
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %s1276 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h739212033, i32 0, i32 0
  %t1277 = call i1 @strings_equal(i8* %t1275, i8* %s1276)
  %t1278 = load %PythonBuilder, %PythonBuilder* %l0
  %t1279 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1280 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1281 = load i8*, i8** %l3
  %t1282 = load double, double* %l4
  %t1283 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1284 = load double, double* %l6
  %t1285 = load double, double* %l7
  %t1286 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1277, label %then67, label %else68
then67:
  %t1287 = load double, double* %l4
  %t1288 = sitofp i64 0 to double
  %t1289 = fcmp ogt double %t1287, %t1288
  %t1290 = load %PythonBuilder, %PythonBuilder* %l0
  %t1291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1292 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1293 = load i8*, i8** %l3
  %t1294 = load double, double* %l4
  %t1295 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1296 = load double, double* %l6
  %t1297 = load double, double* %l7
  %t1298 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1289, label %then70, label %else71
then70:
  %t1299 = load %PythonBuilder, %PythonBuilder* %l0
  %t1300 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1299)
  store %PythonBuilder %t1300, %PythonBuilder* %l0
  %t1301 = load double, double* %l4
  %t1302 = sitofp i64 1 to double
  %t1303 = fsub double %t1301, %t1302
  store double %t1303, double* %l4
  %t1304 = load %PythonBuilder, %PythonBuilder* %l0
  %t1305 = load double, double* %l4
  br label %merge72
else71:
  %t1306 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1307 = extractvalue %NativeFunction %function, 0
  %s1308 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1122035900, i32 0, i32 0
  %t1309 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1306, i8* %t1307, i8* %s1308)
  store { i8**, i64 }* %t1309, { i8**, i64 }** %l1
  %t1310 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge72
merge72:
  %t1311 = phi %PythonBuilder [ %t1304, %then70 ], [ %t1290, %else71 ]
  %t1312 = phi double [ %t1305, %then70 ], [ %t1294, %else71 ]
  %t1313 = phi { i8**, i64 }* [ %t1291, %then70 ], [ %t1310, %else71 ]
  store %PythonBuilder %t1311, %PythonBuilder* %l0
  store double %t1312, double* %l4
  store { i8**, i64 }* %t1313, { i8**, i64 }** %l1
  %t1314 = load %PythonBuilder, %PythonBuilder* %l0
  %t1315 = load double, double* %l4
  %t1316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge69
else68:
  %t1317 = load %NativeInstruction, %NativeInstruction* %l8
  %t1318 = extractvalue %NativeInstruction %t1317, 0
  %t1319 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1320 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1318, 0
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1318, 1
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1318, 2
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1318, 3
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1318, 4
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1318, 5
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1318, 6
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1318, 7
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1318, 8
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1318, 9
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1318, 10
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1318, 11
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %t1356 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1357 = icmp eq i32 %t1318, 12
  %t1358 = select i1 %t1357, i8* %t1356, i8* %t1355
  %t1359 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1360 = icmp eq i32 %t1318, 13
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1358
  %t1362 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1363 = icmp eq i32 %t1318, 14
  %t1364 = select i1 %t1363, i8* %t1362, i8* %t1361
  %t1365 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1366 = icmp eq i32 %t1318, 15
  %t1367 = select i1 %t1366, i8* %t1365, i8* %t1364
  %t1368 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1369 = icmp eq i32 %t1318, 16
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1367
  %s1371 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h706445588, i32 0, i32 0
  %t1372 = call i1 @strings_equal(i8* %t1370, i8* %s1371)
  %t1373 = load %PythonBuilder, %PythonBuilder* %l0
  %t1374 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1375 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1376 = load i8*, i8** %l3
  %t1377 = load double, double* %l4
  %t1378 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1379 = load double, double* %l6
  %t1380 = load double, double* %l7
  %t1381 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1372, label %then73, label %else74
then73:
  %t1382 = load %PythonBuilder, %PythonBuilder* %l0
  %s1383 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t1384 = call %PythonBuilder @builder_emit(%PythonBuilder %t1382, i8* %s1383)
  store %PythonBuilder %t1384, %PythonBuilder* %l0
  %t1385 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
else74:
  %t1386 = load %NativeInstruction, %NativeInstruction* %l8
  %t1387 = extractvalue %NativeInstruction %t1386, 0
  %t1388 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1389 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1390 = icmp eq i32 %t1387, 0
  %t1391 = select i1 %t1390, i8* %t1389, i8* %t1388
  %t1392 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1387, 1
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1387, 2
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1387, 3
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1387, 4
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1387, 5
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1387, 6
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1387, 7
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1387, 8
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1387, 9
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1387, 10
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1387, 11
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1387, 12
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1387, 13
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1387, 14
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1387, 15
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1387, 16
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %s1440 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h267355070, i32 0, i32 0
  %t1441 = call i1 @strings_equal(i8* %t1439, i8* %s1440)
  %t1442 = load %PythonBuilder, %PythonBuilder* %l0
  %t1443 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1444 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1445 = load i8*, i8** %l3
  %t1446 = load double, double* %l4
  %t1447 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1448 = load double, double* %l6
  %t1449 = load double, double* %l7
  %t1450 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1441, label %then76, label %else77
then76:
  %t1451 = load %PythonBuilder, %PythonBuilder* %l0
  %s1452 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t1453 = call %PythonBuilder @builder_emit(%PythonBuilder %t1451, i8* %s1452)
  store %PythonBuilder %t1453, %PythonBuilder* %l0
  %t1454 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
else77:
  %t1455 = load %NativeInstruction, %NativeInstruction* %l8
  %t1456 = extractvalue %NativeInstruction %t1455, 0
  %t1457 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1458 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1459 = icmp eq i32 %t1456, 0
  %t1460 = select i1 %t1459, i8* %t1458, i8* %t1457
  %t1461 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1456, 1
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1456, 2
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1456, 3
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1456, 4
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1456, 5
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1456, 6
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1456, 7
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1456, 8
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1456, 9
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1456, 10
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1456, 11
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1456, 12
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1456, 13
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1456, 14
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1456, 15
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1456, 16
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %s1509 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1117315388, i32 0, i32 0
  %t1510 = call i1 @strings_equal(i8* %t1508, i8* %s1509)
  %t1511 = load %PythonBuilder, %PythonBuilder* %l0
  %t1512 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1513 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1514 = load i8*, i8** %l3
  %t1515 = load double, double* %l4
  %t1516 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1517 = load double, double* %l6
  %t1518 = load double, double* %l7
  %t1519 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1510, label %then79, label %else80
then79:
  %t1520 = load double, double* %l6
  %t1521 = call i8* @generate_match_subject_name(double %t1520)
  store i8* %t1521, i8** %l25
  %t1522 = load double, double* %l6
  %t1523 = sitofp i64 1 to double
  %t1524 = fadd double %t1522, %t1523
  store double %t1524, double* %l6
  %t1525 = load %NativeInstruction, %NativeInstruction* %l8
  %t1526 = extractvalue %NativeInstruction %t1525, 0
  %t1527 = alloca %NativeInstruction
  store %NativeInstruction %t1525, %NativeInstruction* %t1527
  %t1528 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1527, i32 0, i32 1
  %t1529 = bitcast [16 x i8]* %t1528 to i8*
  %t1530 = bitcast i8* %t1529 to i8**
  %t1531 = load i8*, i8** %t1530
  %t1532 = icmp eq i32 %t1526, 0
  %t1533 = select i1 %t1532, i8* %t1531, i8* null
  %t1534 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1527, i32 0, i32 1
  %t1535 = bitcast [16 x i8]* %t1534 to i8*
  %t1536 = bitcast i8* %t1535 to i8**
  %t1537 = load i8*, i8** %t1536
  %t1538 = icmp eq i32 %t1526, 1
  %t1539 = select i1 %t1538, i8* %t1537, i8* %t1533
  %t1540 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1527, i32 0, i32 1
  %t1541 = bitcast [8 x i8]* %t1540 to i8*
  %t1542 = bitcast i8* %t1541 to i8**
  %t1543 = load i8*, i8** %t1542
  %t1544 = icmp eq i32 %t1526, 12
  %t1545 = select i1 %t1544, i8* %t1543, i8* %t1539
  %t1546 = call i8* @lower_expression(i8* %t1545)
  store i8* %t1546, i8** %l26
  %t1547 = load %PythonBuilder, %PythonBuilder* %l0
  %t1548 = load i8*, i8** %l25
  %s1549 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t1550 = call i8* @sailfin_runtime_string_concat(i8* %t1548, i8* %s1549)
  %t1551 = load i8*, i8** %l26
  %t1552 = call i8* @sailfin_runtime_string_concat(i8* %t1550, i8* %t1551)
  %t1553 = call %PythonBuilder @builder_emit(%PythonBuilder %t1547, i8* %t1552)
  store %PythonBuilder %t1553, %PythonBuilder* %l0
  %t1554 = load i8*, i8** %l25
  %t1555 = insertvalue %MatchContext undef, i8* %t1554, 0
  %t1556 = sitofp i64 0 to double
  %t1557 = insertvalue %MatchContext %t1555, double %t1556, 1
  %t1558 = insertvalue %MatchContext %t1557, i1 0, 2
  store %MatchContext %t1558, %MatchContext* %l27
  %t1559 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1560 = load %MatchContext, %MatchContext* %l27
  %t1561 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t1559, %MatchContext %t1560)
  store { %MatchContext*, i64 }* %t1561, { %MatchContext*, i64 }** %l5
  %t1562 = load double, double* %l6
  %t1563 = load %PythonBuilder, %PythonBuilder* %l0
  %t1564 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge81
else80:
  %t1565 = load %NativeInstruction, %NativeInstruction* %l8
  %t1566 = extractvalue %NativeInstruction %t1565, 0
  %t1567 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1568 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1569 = icmp eq i32 %t1566, 0
  %t1570 = select i1 %t1569, i8* %t1568, i8* %t1567
  %t1571 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1566, 1
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1566, 2
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1566, 3
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1566, 4
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1566, 5
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1566, 6
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1566, 7
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %t1592 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1566, 8
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1566, 9
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1566, 10
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1566, 11
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1566, 12
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1566, 13
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1566, 14
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1566, 15
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %t1616 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1566, 16
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %s1619 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217223495, i32 0, i32 0
  %t1620 = call i1 @strings_equal(i8* %t1618, i8* %s1619)
  %t1621 = load %PythonBuilder, %PythonBuilder* %l0
  %t1622 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1623 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1624 = load i8*, i8** %l3
  %t1625 = load double, double* %l4
  %t1626 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1627 = load double, double* %l6
  %t1628 = load double, double* %l7
  %t1629 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1620, label %then82, label %else83
then82:
  %t1630 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1631 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1630
  %t1632 = extractvalue { %MatchContext*, i64 } %t1631, 1
  %t1633 = icmp eq i64 %t1632, 0
  %t1634 = load %PythonBuilder, %PythonBuilder* %l0
  %t1635 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1636 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1637 = load i8*, i8** %l3
  %t1638 = load double, double* %l4
  %t1639 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1640 = load double, double* %l6
  %t1641 = load double, double* %l7
  %t1642 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1633, label %then85, label %else86
then85:
  %t1643 = load %NativeInstruction, %NativeInstruction* %l8
  %t1644 = extractvalue %NativeInstruction %t1643, 0
  %t1645 = alloca %NativeInstruction
  store %NativeInstruction %t1643, %NativeInstruction* %t1645
  %t1646 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1645, i32 0, i32 1
  %t1647 = bitcast [16 x i8]* %t1646 to i8*
  %t1648 = bitcast i8* %t1647 to i8**
  %t1649 = load i8*, i8** %t1648
  %t1650 = icmp eq i32 %t1644, 13
  %t1651 = select i1 %t1650, i8* %t1649, i8* null
  %t1652 = call i8* @trim_text(i8* %t1651)
  store i8* %t1652, i8** %l28
  %s1653 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h2079567388, i32 0, i32 0
  store i8* %s1653, i8** %l29
  %t1654 = load i8*, i8** %l28
  %t1655 = call i64 @sailfin_runtime_string_length(i8* %t1654)
  %t1656 = icmp sgt i64 %t1655, 0
  %t1657 = load %PythonBuilder, %PythonBuilder* %l0
  %t1658 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1659 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1660 = load i8*, i8** %l3
  %t1661 = load double, double* %l4
  %t1662 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1663 = load double, double* %l6
  %t1664 = load double, double* %l7
  %t1665 = load %NativeInstruction, %NativeInstruction* %l8
  %t1666 = load i8*, i8** %l28
  %t1667 = load i8*, i8** %l29
  br i1 %t1656, label %then88, label %merge89
then88:
  %t1668 = load i8*, i8** %l29
  %s1669 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1460619898, i32 0, i32 0
  %t1670 = call i8* @sailfin_runtime_string_concat(i8* %t1668, i8* %s1669)
  %t1671 = load i8*, i8** %l28
  %t1672 = call i8* @sailfin_runtime_string_concat(i8* %t1670, i8* %t1671)
  %t1673 = add i64 0, 2
  %t1674 = call i8* @malloc(i64 %t1673)
  store i8 41, i8* %t1674
  %t1675 = getelementptr i8, i8* %t1674, i64 1
  store i8 0, i8* %t1675
  call void @sailfin_runtime_mark_persistent(i8* %t1674)
  %t1676 = call i8* @sailfin_runtime_string_concat(i8* %t1672, i8* %t1674)
  store i8* %t1676, i8** %l29
  %t1677 = load i8*, i8** %l29
  br label %merge89
merge89:
  %t1678 = phi i8* [ %t1677, %then88 ], [ %t1667, %then85 ]
  store i8* %t1678, i8** %l29
  %t1679 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1680 = extractvalue %NativeFunction %function, 0
  %t1681 = load i8*, i8** %l29
  %t1682 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1679, i8* %t1680, i8* %t1681)
  store { i8**, i64 }* %t1682, { i8**, i64 }** %l1
  %t1683 = load %PythonBuilder, %PythonBuilder* %l0
  %s1684 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1804821690, i32 0, i32 0
  %t1685 = call %PythonBuilder @builder_emit(%PythonBuilder %t1683, i8* %s1684)
  store %PythonBuilder %t1685, %PythonBuilder* %l0
  %t1686 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1687 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge87
else86:
  %t1688 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1689 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1688
  %t1690 = extractvalue { %MatchContext*, i64 } %t1689, 1
  %t1691 = sub i64 %t1690, 1
  store i64 %t1691, i64* %l30
  %t1692 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1693 = load i64, i64* %l30
  %t1694 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1692
  %t1695 = extractvalue { %MatchContext*, i64 } %t1694, 0
  %t1696 = extractvalue { %MatchContext*, i64 } %t1694, 1
  %t1697 = icmp uge i64 %t1693, %t1696
  ; bounds check: %t1697 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1693, i64 %t1696)
  %t1698 = getelementptr %MatchContext, %MatchContext* %t1695, i64 %t1693
  %t1699 = load %MatchContext, %MatchContext* %t1698
  store %MatchContext %t1699, %MatchContext* %l31
  %t1700 = load %MatchContext, %MatchContext* %l31
  %t1701 = extractvalue %MatchContext %t1700, 2
  %t1702 = load %PythonBuilder, %PythonBuilder* %l0
  %t1703 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1704 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1705 = load i8*, i8** %l3
  %t1706 = load double, double* %l4
  %t1707 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1708 = load double, double* %l6
  %t1709 = load double, double* %l7
  %t1710 = load %NativeInstruction, %NativeInstruction* %l8
  %t1711 = load i64, i64* %l30
  %t1712 = load %MatchContext, %MatchContext* %l31
  br i1 %t1701, label %then90, label %merge91
then90:
  %t1713 = load %PythonBuilder, %PythonBuilder* %l0
  %t1714 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1713)
  store %PythonBuilder %t1714, %PythonBuilder* %l0
  %t1715 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge91
merge91:
  %t1716 = phi %PythonBuilder [ %t1715, %then90 ], [ %t1702, %else86 ]
  store %PythonBuilder %t1716, %PythonBuilder* %l0
  %t1717 = load %MatchContext, %MatchContext* %l31
  %t1718 = extractvalue %MatchContext %t1717, 0
  %t1719 = load %NativeInstruction, %NativeInstruction* %l8
  %t1720 = extractvalue %NativeInstruction %t1719, 0
  %t1721 = alloca %NativeInstruction
  store %NativeInstruction %t1719, %NativeInstruction* %t1721
  %t1722 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1721, i32 0, i32 1
  %t1723 = bitcast [16 x i8]* %t1722 to i8*
  %t1724 = bitcast i8* %t1723 to i8**
  %t1725 = load i8*, i8** %t1724
  %t1726 = icmp eq i32 %t1720, 13
  %t1727 = select i1 %t1726, i8* %t1725, i8* null
  %t1728 = load %NativeInstruction, %NativeInstruction* %l8
  %t1729 = extractvalue %NativeInstruction %t1728, 0
  %t1730 = alloca %NativeInstruction
  store %NativeInstruction %t1728, %NativeInstruction* %t1730
  %t1731 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1730, i32 0, i32 1
  %t1732 = bitcast [16 x i8]* %t1731 to i8*
  %t1733 = getelementptr inbounds i8, i8* %t1732, i64 8
  %t1734 = bitcast i8* %t1733 to i8**
  %t1735 = load i8*, i8** %t1734
  %t1736 = icmp eq i32 %t1729, 13
  %t1737 = select i1 %t1736, i8* %t1735, i8* null
  %t1738 = call %LoweredCaseCondition @lower_match_case_condition(i8* %t1718, i8* %t1727, i8* %t1737)
  store %LoweredCaseCondition %t1738, %LoweredCaseCondition* %l32
  %t1739 = load %MatchContext, %MatchContext* %l31
  %t1740 = extractvalue %MatchContext %t1739, 1
  %t1741 = sitofp i64 0 to double
  %t1742 = fcmp oeq double %t1740, %t1741
  %t1743 = load %PythonBuilder, %PythonBuilder* %l0
  %t1744 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1745 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1746 = load i8*, i8** %l3
  %t1747 = load double, double* %l4
  %t1748 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1749 = load double, double* %l6
  %t1750 = load double, double* %l7
  %t1751 = load %NativeInstruction, %NativeInstruction* %l8
  %t1752 = load i64, i64* %l30
  %t1753 = load %MatchContext, %MatchContext* %l31
  %t1754 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1742, label %then92, label %else93
then92:
  %t1755 = load %PythonBuilder, %PythonBuilder* %l0
  %s1756 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t1757 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1758 = extractvalue %LoweredCaseCondition %t1757, 0
  %t1759 = call i8* @sailfin_runtime_string_concat(i8* %s1756, i8* %t1758)
  %t1760 = add i64 0, 2
  %t1761 = call i8* @malloc(i64 %t1760)
  store i8 58, i8* %t1761
  %t1762 = getelementptr i8, i8* %t1761, i64 1
  store i8 0, i8* %t1762
  call void @sailfin_runtime_mark_persistent(i8* %t1761)
  %t1763 = call i8* @sailfin_runtime_string_concat(i8* %t1759, i8* %t1761)
  %t1764 = call %PythonBuilder @builder_emit(%PythonBuilder %t1755, i8* %t1763)
  store %PythonBuilder %t1764, %PythonBuilder* %l0
  %t1765 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
else93:
  %t1767 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1768 = extractvalue %LoweredCaseCondition %t1767, 1
  br label %logical_and_entry_1766

logical_and_entry_1766:
  br i1 %t1768, label %logical_and_right_1766, label %logical_and_merge_1766

logical_and_right_1766:
  %t1769 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1770 = extractvalue %LoweredCaseCondition %t1769, 2
  %t1771 = xor i1 %t1770, 1
  br label %logical_and_right_end_1766

logical_and_right_end_1766:
  br label %logical_and_merge_1766

logical_and_merge_1766:
  %t1772 = phi i1 [ false, %logical_and_entry_1766 ], [ %t1771, %logical_and_right_end_1766 ]
  %t1773 = load %PythonBuilder, %PythonBuilder* %l0
  %t1774 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1775 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1776 = load i8*, i8** %l3
  %t1777 = load double, double* %l4
  %t1778 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1779 = load double, double* %l6
  %t1780 = load double, double* %l7
  %t1781 = load %NativeInstruction, %NativeInstruction* %l8
  %t1782 = load i64, i64* %l30
  %t1783 = load %MatchContext, %MatchContext* %l31
  %t1784 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1772, label %then95, label %else96
then95:
  %t1785 = load %PythonBuilder, %PythonBuilder* %l0
  %s1786 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t1787 = call %PythonBuilder @builder_emit(%PythonBuilder %t1785, i8* %s1786)
  store %PythonBuilder %t1787, %PythonBuilder* %l0
  %t1788 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
else96:
  %t1789 = load %PythonBuilder, %PythonBuilder* %l0
  %s1790 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069215535, i32 0, i32 0
  %t1791 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1792 = extractvalue %LoweredCaseCondition %t1791, 0
  %t1793 = call i8* @sailfin_runtime_string_concat(i8* %s1790, i8* %t1792)
  %t1794 = add i64 0, 2
  %t1795 = call i8* @malloc(i64 %t1794)
  store i8 58, i8* %t1795
  %t1796 = getelementptr i8, i8* %t1795, i64 1
  store i8 0, i8* %t1796
  call void @sailfin_runtime_mark_persistent(i8* %t1795)
  %t1797 = call i8* @sailfin_runtime_string_concat(i8* %t1793, i8* %t1795)
  %t1798 = call %PythonBuilder @builder_emit(%PythonBuilder %t1789, i8* %t1797)
  store %PythonBuilder %t1798, %PythonBuilder* %l0
  %t1799 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
merge97:
  %t1800 = phi %PythonBuilder [ %t1788, %then95 ], [ %t1799, %else96 ]
  store %PythonBuilder %t1800, %PythonBuilder* %l0
  %t1801 = load %PythonBuilder, %PythonBuilder* %l0
  %t1802 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
merge94:
  %t1803 = phi %PythonBuilder [ %t1765, %then92 ], [ %t1801, %merge97 ]
  store %PythonBuilder %t1803, %PythonBuilder* %l0
  %t1804 = load %PythonBuilder, %PythonBuilder* %l0
  %t1805 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1804)
  store %PythonBuilder %t1805, %PythonBuilder* %l0
  %t1806 = load %MatchContext, %MatchContext* %l31
  %t1807 = extractvalue %MatchContext %t1806, 0
  %t1808 = insertvalue %MatchContext undef, i8* %t1807, 0
  %t1809 = load %MatchContext, %MatchContext* %l31
  %t1810 = extractvalue %MatchContext %t1809, 1
  %t1811 = sitofp i64 1 to double
  %t1812 = fadd double %t1810, %t1811
  %t1813 = insertvalue %MatchContext %t1808, double %t1812, 1
  %t1814 = insertvalue %MatchContext %t1813, i1 1, 2
  store %MatchContext %t1814, %MatchContext* %l33
  %t1815 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1816 = load i64, i64* %l30
  %t1817 = load %MatchContext, %MatchContext* %l33
  %t1818 = sitofp i64 %t1816 to double
  %t1819 = call { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %t1815, double %t1818, %MatchContext %t1817)
  store { %MatchContext*, i64 }* %t1819, { %MatchContext*, i64 }** %l5
  %t1820 = load %PythonBuilder, %PythonBuilder* %l0
  %t1821 = load %PythonBuilder, %PythonBuilder* %l0
  %t1822 = load %PythonBuilder, %PythonBuilder* %l0
  %t1823 = load %PythonBuilder, %PythonBuilder* %l0
  %t1824 = load %PythonBuilder, %PythonBuilder* %l0
  %t1825 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge87
merge87:
  %t1826 = phi { i8**, i64 }* [ %t1686, %merge89 ], [ %t1635, %merge94 ]
  %t1827 = phi %PythonBuilder [ %t1687, %merge89 ], [ %t1820, %merge94 ]
  %t1828 = phi { %MatchContext*, i64 }* [ %t1639, %merge89 ], [ %t1825, %merge94 ]
  store { i8**, i64 }* %t1826, { i8**, i64 }** %l1
  store %PythonBuilder %t1827, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1828, { %MatchContext*, i64 }** %l5
  %t1829 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1830 = load %PythonBuilder, %PythonBuilder* %l0
  %t1831 = load %PythonBuilder, %PythonBuilder* %l0
  %t1832 = load %PythonBuilder, %PythonBuilder* %l0
  %t1833 = load %PythonBuilder, %PythonBuilder* %l0
  %t1834 = load %PythonBuilder, %PythonBuilder* %l0
  %t1835 = load %PythonBuilder, %PythonBuilder* %l0
  %t1836 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge84
else83:
  %t1837 = load %NativeInstruction, %NativeInstruction* %l8
  %t1838 = extractvalue %NativeInstruction %t1837, 0
  %t1839 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1840 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1841 = icmp eq i32 %t1838, 0
  %t1842 = select i1 %t1841, i8* %t1840, i8* %t1839
  %t1843 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1844 = icmp eq i32 %t1838, 1
  %t1845 = select i1 %t1844, i8* %t1843, i8* %t1842
  %t1846 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1847 = icmp eq i32 %t1838, 2
  %t1848 = select i1 %t1847, i8* %t1846, i8* %t1845
  %t1849 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1850 = icmp eq i32 %t1838, 3
  %t1851 = select i1 %t1850, i8* %t1849, i8* %t1848
  %t1852 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1853 = icmp eq i32 %t1838, 4
  %t1854 = select i1 %t1853, i8* %t1852, i8* %t1851
  %t1855 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1856 = icmp eq i32 %t1838, 5
  %t1857 = select i1 %t1856, i8* %t1855, i8* %t1854
  %t1858 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1859 = icmp eq i32 %t1838, 6
  %t1860 = select i1 %t1859, i8* %t1858, i8* %t1857
  %t1861 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1862 = icmp eq i32 %t1838, 7
  %t1863 = select i1 %t1862, i8* %t1861, i8* %t1860
  %t1864 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1865 = icmp eq i32 %t1838, 8
  %t1866 = select i1 %t1865, i8* %t1864, i8* %t1863
  %t1867 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1868 = icmp eq i32 %t1838, 9
  %t1869 = select i1 %t1868, i8* %t1867, i8* %t1866
  %t1870 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1871 = icmp eq i32 %t1838, 10
  %t1872 = select i1 %t1871, i8* %t1870, i8* %t1869
  %t1873 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1874 = icmp eq i32 %t1838, 11
  %t1875 = select i1 %t1874, i8* %t1873, i8* %t1872
  %t1876 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1877 = icmp eq i32 %t1838, 12
  %t1878 = select i1 %t1877, i8* %t1876, i8* %t1875
  %t1879 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1880 = icmp eq i32 %t1838, 13
  %t1881 = select i1 %t1880, i8* %t1879, i8* %t1878
  %t1882 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1883 = icmp eq i32 %t1838, 14
  %t1884 = select i1 %t1883, i8* %t1882, i8* %t1881
  %t1885 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1886 = icmp eq i32 %t1838, 15
  %t1887 = select i1 %t1886, i8* %t1885, i8* %t1884
  %t1888 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1889 = icmp eq i32 %t1838, 16
  %t1890 = select i1 %t1889, i8* %t1888, i8* %t1887
  %s1891 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h794378208, i32 0, i32 0
  %t1892 = call i1 @strings_equal(i8* %t1890, i8* %s1891)
  %t1893 = load %PythonBuilder, %PythonBuilder* %l0
  %t1894 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1895 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1896 = load i8*, i8** %l3
  %t1897 = load double, double* %l4
  %t1898 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1899 = load double, double* %l6
  %t1900 = load double, double* %l7
  %t1901 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1892, label %then98, label %else99
then98:
  %t1902 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1903 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1902
  %t1904 = extractvalue { %MatchContext*, i64 } %t1903, 1
  %t1905 = icmp eq i64 %t1904, 0
  %t1906 = load %PythonBuilder, %PythonBuilder* %l0
  %t1907 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1908 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1909 = load i8*, i8** %l3
  %t1910 = load double, double* %l4
  %t1911 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1912 = load double, double* %l6
  %t1913 = load double, double* %l7
  %t1914 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1905, label %then101, label %else102
then101:
  %t1915 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1916 = extractvalue %NativeFunction %function, 0
  %s1917 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h314404344, i32 0, i32 0
  %t1918 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1915, i8* %t1916, i8* %s1917)
  store { i8**, i64 }* %t1918, { i8**, i64 }** %l1
  %t1919 = load %PythonBuilder, %PythonBuilder* %l0
  %s1920 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h198700275, i32 0, i32 0
  %t1921 = call %PythonBuilder @builder_emit(%PythonBuilder %t1919, i8* %s1920)
  store %PythonBuilder %t1921, %PythonBuilder* %l0
  %t1922 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1923 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge103
else102:
  %t1924 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1925 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1924
  %t1926 = extractvalue { %MatchContext*, i64 } %t1925, 1
  %t1927 = sub i64 %t1926, 1
  store i64 %t1927, i64* %l34
  %t1928 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1929 = load i64, i64* %l34
  %t1930 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1928
  %t1931 = extractvalue { %MatchContext*, i64 } %t1930, 0
  %t1932 = extractvalue { %MatchContext*, i64 } %t1930, 1
  %t1933 = icmp uge i64 %t1929, %t1932
  ; bounds check: %t1933 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1929, i64 %t1932)
  %t1934 = getelementptr %MatchContext, %MatchContext* %t1931, i64 %t1929
  %t1935 = load %MatchContext, %MatchContext* %t1934
  store %MatchContext %t1935, %MatchContext* %l35
  %t1936 = load %MatchContext, %MatchContext* %l35
  %t1937 = extractvalue %MatchContext %t1936, 2
  %t1938 = load %PythonBuilder, %PythonBuilder* %l0
  %t1939 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1940 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1941 = load i8*, i8** %l3
  %t1942 = load double, double* %l4
  %t1943 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1944 = load double, double* %l6
  %t1945 = load double, double* %l7
  %t1946 = load %NativeInstruction, %NativeInstruction* %l8
  %t1947 = load i64, i64* %l34
  %t1948 = load %MatchContext, %MatchContext* %l35
  br i1 %t1937, label %then104, label %merge105
then104:
  %t1949 = load %PythonBuilder, %PythonBuilder* %l0
  %t1950 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1949)
  store %PythonBuilder %t1950, %PythonBuilder* %l0
  %t1951 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge105
merge105:
  %t1952 = phi %PythonBuilder [ %t1951, %then104 ], [ %t1938, %else102 ]
  store %PythonBuilder %t1952, %PythonBuilder* %l0
  %t1953 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1954 = load i64, i64* %l34
  %t1955 = sitofp i64 %t1954 to double
  %t1956 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t1953, double %t1955)
  store { %MatchContext*, i64 }* %t1956, { %MatchContext*, i64 }** %l5
  %t1957 = load %PythonBuilder, %PythonBuilder* %l0
  %t1958 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge103
merge103:
  %t1959 = phi { i8**, i64 }* [ %t1922, %then101 ], [ %t1907, %merge105 ]
  %t1960 = phi %PythonBuilder [ %t1923, %then101 ], [ %t1957, %merge105 ]
  %t1961 = phi { %MatchContext*, i64 }* [ %t1911, %then101 ], [ %t1958, %merge105 ]
  store { i8**, i64 }* %t1959, { i8**, i64 }** %l1
  store %PythonBuilder %t1960, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1961, { %MatchContext*, i64 }** %l5
  %t1962 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1963 = load %PythonBuilder, %PythonBuilder* %l0
  %t1964 = load %PythonBuilder, %PythonBuilder* %l0
  %t1965 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge100
else99:
  %t1966 = load %NativeInstruction, %NativeInstruction* %l8
  %t1967 = extractvalue %NativeInstruction %t1966, 0
  %t1968 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1969 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1970 = icmp eq i32 %t1967, 0
  %t1971 = select i1 %t1970, i8* %t1969, i8* %t1968
  %t1972 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1973 = icmp eq i32 %t1967, 1
  %t1974 = select i1 %t1973, i8* %t1972, i8* %t1971
  %t1975 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1976 = icmp eq i32 %t1967, 2
  %t1977 = select i1 %t1976, i8* %t1975, i8* %t1974
  %t1978 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1979 = icmp eq i32 %t1967, 3
  %t1980 = select i1 %t1979, i8* %t1978, i8* %t1977
  %t1981 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1982 = icmp eq i32 %t1967, 4
  %t1983 = select i1 %t1982, i8* %t1981, i8* %t1980
  %t1984 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1985 = icmp eq i32 %t1967, 5
  %t1986 = select i1 %t1985, i8* %t1984, i8* %t1983
  %t1987 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1988 = icmp eq i32 %t1967, 6
  %t1989 = select i1 %t1988, i8* %t1987, i8* %t1986
  %t1990 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1991 = icmp eq i32 %t1967, 7
  %t1992 = select i1 %t1991, i8* %t1990, i8* %t1989
  %t1993 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1994 = icmp eq i32 %t1967, 8
  %t1995 = select i1 %t1994, i8* %t1993, i8* %t1992
  %t1996 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1997 = icmp eq i32 %t1967, 9
  %t1998 = select i1 %t1997, i8* %t1996, i8* %t1995
  %t1999 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t2000 = icmp eq i32 %t1967, 10
  %t2001 = select i1 %t2000, i8* %t1999, i8* %t1998
  %t2002 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t2003 = icmp eq i32 %t1967, 11
  %t2004 = select i1 %t2003, i8* %t2002, i8* %t2001
  %t2005 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t2006 = icmp eq i32 %t1967, 12
  %t2007 = select i1 %t2006, i8* %t2005, i8* %t2004
  %t2008 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t2009 = icmp eq i32 %t1967, 13
  %t2010 = select i1 %t2009, i8* %t2008, i8* %t2007
  %t2011 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t2012 = icmp eq i32 %t1967, 14
  %t2013 = select i1 %t2012, i8* %t2011, i8* %t2010
  %t2014 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t2015 = icmp eq i32 %t1967, 15
  %t2016 = select i1 %t2015, i8* %t2014, i8* %t2013
  %t2017 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t2018 = icmp eq i32 %t1967, 16
  %t2019 = select i1 %t2018, i8* %t2017, i8* %t2016
  %s2020 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230767751, i32 0, i32 0
  %t2021 = call i1 @strings_equal(i8* %t2019, i8* %s2020)
  %t2022 = load %PythonBuilder, %PythonBuilder* %l0
  %t2023 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2024 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2025 = load i8*, i8** %l3
  %t2026 = load double, double* %l4
  %t2027 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2028 = load double, double* %l6
  %t2029 = load double, double* %l7
  %t2030 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t2021, label %then106, label %else107
then106:
  %t2031 = load %PythonBuilder, %PythonBuilder* %l0
  %s2032 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t2033 = call %PythonBuilder @builder_emit(%PythonBuilder %t2031, i8* %s2032)
  store %PythonBuilder %t2033, %PythonBuilder* %l0
  %t2034 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
else107:
  %t2035 = load %NativeInstruction, %NativeInstruction* %l8
  %t2036 = extractvalue %NativeInstruction %t2035, 0
  %t2037 = alloca %NativeInstruction
  store %NativeInstruction %t2035, %NativeInstruction* %t2037
  %t2038 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2037, i32 0, i32 1
  %t2039 = bitcast [8 x i8]* %t2038 to i8*
  %t2040 = bitcast i8* %t2039 to i8**
  %t2041 = load i8*, i8** %t2040
  %t2042 = icmp eq i32 %t2036, 16
  %t2043 = select i1 %t2042, i8* %t2041, i8* null
  %t2044 = call i8* @trim_text(i8* %t2043)
  store i8* %t2044, i8** %l36
  %s2045 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h9444846, i32 0, i32 0
  store i8* %s2045, i8** %l37
  %t2046 = load i8*, i8** %l36
  %t2047 = call i64 @sailfin_runtime_string_length(i8* %t2046)
  %t2048 = icmp sgt i64 %t2047, 0
  %t2049 = load %PythonBuilder, %PythonBuilder* %l0
  %t2050 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2051 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2052 = load i8*, i8** %l3
  %t2053 = load double, double* %l4
  %t2054 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2055 = load double, double* %l6
  %t2056 = load double, double* %l7
  %t2057 = load %NativeInstruction, %NativeInstruction* %l8
  %t2058 = load i8*, i8** %l36
  %t2059 = load i8*, i8** %l37
  br i1 %t2048, label %then109, label %merge110
then109:
  %t2060 = load i8*, i8** %l37
  %s2061 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t2062 = call i8* @sailfin_runtime_string_concat(i8* %t2060, i8* %s2061)
  %t2063 = load i8*, i8** %l36
  %t2064 = call i8* @sailfin_runtime_string_concat(i8* %t2062, i8* %t2063)
  store i8* %t2064, i8** %l37
  %t2065 = load i8*, i8** %l37
  br label %merge110
merge110:
  %t2066 = phi i8* [ %t2065, %then109 ], [ %t2059, %else107 ]
  store i8* %t2066, i8** %l37
  %t2067 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2068 = extractvalue %NativeFunction %function, 0
  %t2069 = load i8*, i8** %l37
  %t2070 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2067, i8* %t2068, i8* %t2069)
  store { i8**, i64 }* %t2070, { i8**, i64 }** %l1
  %t2071 = load %PythonBuilder, %PythonBuilder* %l0
  %s2072 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1983072220, i32 0, i32 0
  %t2073 = load %NativeInstruction, %NativeInstruction* %l8
  %t2074 = extractvalue %NativeInstruction %t2073, 0
  %t2075 = alloca %NativeInstruction
  store %NativeInstruction %t2073, %NativeInstruction* %t2075
  %t2076 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2075, i32 0, i32 1
  %t2077 = bitcast [8 x i8]* %t2076 to i8*
  %t2078 = bitcast i8* %t2077 to i8**
  %t2079 = load i8*, i8** %t2078
  %t2080 = icmp eq i32 %t2074, 16
  %t2081 = select i1 %t2080, i8* %t2079, i8* null
  %t2082 = call i8* @sailfin_runtime_string_concat(i8* %s2072, i8* %t2081)
  %t2083 = call %PythonBuilder @builder_emit(%PythonBuilder %t2071, i8* %t2082)
  store %PythonBuilder %t2083, %PythonBuilder* %l0
  %t2084 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2085 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
merge108:
  %t2086 = phi %PythonBuilder [ %t2034, %then106 ], [ %t2085, %merge110 ]
  %t2087 = phi { i8**, i64 }* [ %t2023, %then106 ], [ %t2084, %merge110 ]
  store %PythonBuilder %t2086, %PythonBuilder* %l0
  store { i8**, i64 }* %t2087, { i8**, i64 }** %l1
  %t2088 = load %PythonBuilder, %PythonBuilder* %l0
  %t2089 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2090 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge100
merge100:
  %t2091 = phi { i8**, i64 }* [ %t1962, %merge103 ], [ %t2089, %merge108 ]
  %t2092 = phi %PythonBuilder [ %t1963, %merge103 ], [ %t2088, %merge108 ]
  %t2093 = phi { %MatchContext*, i64 }* [ %t1965, %merge103 ], [ %t1898, %merge108 ]
  store { i8**, i64 }* %t2091, { i8**, i64 }** %l1
  store %PythonBuilder %t2092, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2093, { %MatchContext*, i64 }** %l5
  %t2094 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2095 = load %PythonBuilder, %PythonBuilder* %l0
  %t2096 = load %PythonBuilder, %PythonBuilder* %l0
  %t2097 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2098 = load %PythonBuilder, %PythonBuilder* %l0
  %t2099 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2100 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge84
merge84:
  %t2101 = phi { i8**, i64 }* [ %t1829, %merge87 ], [ %t2094, %merge100 ]
  %t2102 = phi %PythonBuilder [ %t1830, %merge87 ], [ %t2095, %merge100 ]
  %t2103 = phi { %MatchContext*, i64 }* [ %t1836, %merge87 ], [ %t2097, %merge100 ]
  store { i8**, i64 }* %t2101, { i8**, i64 }** %l1
  store %PythonBuilder %t2102, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2103, { %MatchContext*, i64 }** %l5
  %t2104 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2105 = load %PythonBuilder, %PythonBuilder* %l0
  %t2106 = load %PythonBuilder, %PythonBuilder* %l0
  %t2107 = load %PythonBuilder, %PythonBuilder* %l0
  %t2108 = load %PythonBuilder, %PythonBuilder* %l0
  %t2109 = load %PythonBuilder, %PythonBuilder* %l0
  %t2110 = load %PythonBuilder, %PythonBuilder* %l0
  %t2111 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2113 = load %PythonBuilder, %PythonBuilder* %l0
  %t2114 = load %PythonBuilder, %PythonBuilder* %l0
  %t2115 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2116 = load %PythonBuilder, %PythonBuilder* %l0
  %t2117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2118 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge81
merge81:
  %t2119 = phi double [ %t1562, %then79 ], [ %t1517, %merge84 ]
  %t2120 = phi %PythonBuilder [ %t1563, %then79 ], [ %t2105, %merge84 ]
  %t2121 = phi { %MatchContext*, i64 }* [ %t1564, %then79 ], [ %t2111, %merge84 ]
  %t2122 = phi { i8**, i64 }* [ %t1512, %then79 ], [ %t2104, %merge84 ]
  store double %t2119, double* %l6
  store %PythonBuilder %t2120, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2121, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2122, { i8**, i64 }** %l1
  %t2123 = load double, double* %l6
  %t2124 = load %PythonBuilder, %PythonBuilder* %l0
  %t2125 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2127 = load %PythonBuilder, %PythonBuilder* %l0
  %t2128 = load %PythonBuilder, %PythonBuilder* %l0
  %t2129 = load %PythonBuilder, %PythonBuilder* %l0
  %t2130 = load %PythonBuilder, %PythonBuilder* %l0
  %t2131 = load %PythonBuilder, %PythonBuilder* %l0
  %t2132 = load %PythonBuilder, %PythonBuilder* %l0
  %t2133 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2134 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2135 = load %PythonBuilder, %PythonBuilder* %l0
  %t2136 = load %PythonBuilder, %PythonBuilder* %l0
  %t2137 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2138 = load %PythonBuilder, %PythonBuilder* %l0
  %t2139 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2140 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
merge78:
  %t2141 = phi %PythonBuilder [ %t1454, %then76 ], [ %t2124, %merge81 ]
  %t2142 = phi double [ %t1448, %then76 ], [ %t2123, %merge81 ]
  %t2143 = phi { %MatchContext*, i64 }* [ %t1447, %then76 ], [ %t2125, %merge81 ]
  %t2144 = phi { i8**, i64 }* [ %t1443, %then76 ], [ %t2126, %merge81 ]
  store %PythonBuilder %t2141, %PythonBuilder* %l0
  store double %t2142, double* %l6
  store { %MatchContext*, i64 }* %t2143, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2144, { i8**, i64 }** %l1
  %t2145 = load %PythonBuilder, %PythonBuilder* %l0
  %t2146 = load double, double* %l6
  %t2147 = load %PythonBuilder, %PythonBuilder* %l0
  %t2148 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2149 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2150 = load %PythonBuilder, %PythonBuilder* %l0
  %t2151 = load %PythonBuilder, %PythonBuilder* %l0
  %t2152 = load %PythonBuilder, %PythonBuilder* %l0
  %t2153 = load %PythonBuilder, %PythonBuilder* %l0
  %t2154 = load %PythonBuilder, %PythonBuilder* %l0
  %t2155 = load %PythonBuilder, %PythonBuilder* %l0
  %t2156 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2158 = load %PythonBuilder, %PythonBuilder* %l0
  %t2159 = load %PythonBuilder, %PythonBuilder* %l0
  %t2160 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2161 = load %PythonBuilder, %PythonBuilder* %l0
  %t2162 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2163 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
merge75:
  %t2164 = phi %PythonBuilder [ %t1385, %then73 ], [ %t2145, %merge78 ]
  %t2165 = phi double [ %t1379, %then73 ], [ %t2146, %merge78 ]
  %t2166 = phi { %MatchContext*, i64 }* [ %t1378, %then73 ], [ %t2148, %merge78 ]
  %t2167 = phi { i8**, i64 }* [ %t1374, %then73 ], [ %t2149, %merge78 ]
  store %PythonBuilder %t2164, %PythonBuilder* %l0
  store double %t2165, double* %l6
  store { %MatchContext*, i64 }* %t2166, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2167, { i8**, i64 }** %l1
  %t2168 = load %PythonBuilder, %PythonBuilder* %l0
  %t2169 = load %PythonBuilder, %PythonBuilder* %l0
  %t2170 = load double, double* %l6
  %t2171 = load %PythonBuilder, %PythonBuilder* %l0
  %t2172 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2174 = load %PythonBuilder, %PythonBuilder* %l0
  %t2175 = load %PythonBuilder, %PythonBuilder* %l0
  %t2176 = load %PythonBuilder, %PythonBuilder* %l0
  %t2177 = load %PythonBuilder, %PythonBuilder* %l0
  %t2178 = load %PythonBuilder, %PythonBuilder* %l0
  %t2179 = load %PythonBuilder, %PythonBuilder* %l0
  %t2180 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2182 = load %PythonBuilder, %PythonBuilder* %l0
  %t2183 = load %PythonBuilder, %PythonBuilder* %l0
  %t2184 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2185 = load %PythonBuilder, %PythonBuilder* %l0
  %t2186 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2187 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge69
merge69:
  %t2188 = phi %PythonBuilder [ %t1314, %merge72 ], [ %t2168, %merge75 ]
  %t2189 = phi double [ %t1315, %merge72 ], [ %t1282, %merge75 ]
  %t2190 = phi { i8**, i64 }* [ %t1316, %merge72 ], [ %t2173, %merge75 ]
  %t2191 = phi double [ %t1284, %merge72 ], [ %t2170, %merge75 ]
  %t2192 = phi { %MatchContext*, i64 }* [ %t1283, %merge72 ], [ %t2172, %merge75 ]
  store %PythonBuilder %t2188, %PythonBuilder* %l0
  store double %t2189, double* %l4
  store { i8**, i64 }* %t2190, { i8**, i64 }** %l1
  store double %t2191, double* %l6
  store { %MatchContext*, i64 }* %t2192, { %MatchContext*, i64 }** %l5
  %t2193 = load %PythonBuilder, %PythonBuilder* %l0
  %t2194 = load double, double* %l4
  %t2195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2196 = load %PythonBuilder, %PythonBuilder* %l0
  %t2197 = load %PythonBuilder, %PythonBuilder* %l0
  %t2198 = load double, double* %l6
  %t2199 = load %PythonBuilder, %PythonBuilder* %l0
  %t2200 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2201 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2202 = load %PythonBuilder, %PythonBuilder* %l0
  %t2203 = load %PythonBuilder, %PythonBuilder* %l0
  %t2204 = load %PythonBuilder, %PythonBuilder* %l0
  %t2205 = load %PythonBuilder, %PythonBuilder* %l0
  %t2206 = load %PythonBuilder, %PythonBuilder* %l0
  %t2207 = load %PythonBuilder, %PythonBuilder* %l0
  %t2208 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2209 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2210 = load %PythonBuilder, %PythonBuilder* %l0
  %t2211 = load %PythonBuilder, %PythonBuilder* %l0
  %t2212 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2213 = load %PythonBuilder, %PythonBuilder* %l0
  %t2214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2215 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge66
merge66:
  %t2216 = phi %PythonBuilder [ %t1219, %then64 ], [ %t2193, %merge69 ]
  %t2217 = phi double [ %t1221, %then64 ], [ %t2194, %merge69 ]
  %t2218 = phi { i8**, i64 }* [ %t1203, %then64 ], [ %t2195, %merge69 ]
  %t2219 = phi double [ %t1208, %then64 ], [ %t2198, %merge69 ]
  %t2220 = phi { %MatchContext*, i64 }* [ %t1207, %then64 ], [ %t2200, %merge69 ]
  store %PythonBuilder %t2216, %PythonBuilder* %l0
  store double %t2217, double* %l4
  store { i8**, i64 }* %t2218, { i8**, i64 }** %l1
  store double %t2219, double* %l6
  store { %MatchContext*, i64 }* %t2220, { %MatchContext*, i64 }** %l5
  %t2221 = load %PythonBuilder, %PythonBuilder* %l0
  %t2222 = load %PythonBuilder, %PythonBuilder* %l0
  %t2223 = load double, double* %l4
  %t2224 = load %PythonBuilder, %PythonBuilder* %l0
  %t2225 = load double, double* %l4
  %t2226 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2227 = load %PythonBuilder, %PythonBuilder* %l0
  %t2228 = load %PythonBuilder, %PythonBuilder* %l0
  %t2229 = load double, double* %l6
  %t2230 = load %PythonBuilder, %PythonBuilder* %l0
  %t2231 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2233 = load %PythonBuilder, %PythonBuilder* %l0
  %t2234 = load %PythonBuilder, %PythonBuilder* %l0
  %t2235 = load %PythonBuilder, %PythonBuilder* %l0
  %t2236 = load %PythonBuilder, %PythonBuilder* %l0
  %t2237 = load %PythonBuilder, %PythonBuilder* %l0
  %t2238 = load %PythonBuilder, %PythonBuilder* %l0
  %t2239 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2240 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2241 = load %PythonBuilder, %PythonBuilder* %l0
  %t2242 = load %PythonBuilder, %PythonBuilder* %l0
  %t2243 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2244 = load %PythonBuilder, %PythonBuilder* %l0
  %t2245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2246 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge60
merge60:
  %t2247 = phi %PythonBuilder [ %t1143, %merge63 ], [ %t2221, %merge66 ]
  %t2248 = phi double [ %t1144, %merge63 ], [ %t2223, %merge66 ]
  %t2249 = phi { i8**, i64 }* [ %t1145, %merge63 ], [ %t2226, %merge66 ]
  %t2250 = phi double [ %t1113, %merge63 ], [ %t2229, %merge66 ]
  %t2251 = phi { %MatchContext*, i64 }* [ %t1112, %merge63 ], [ %t2231, %merge66 ]
  store %PythonBuilder %t2247, %PythonBuilder* %l0
  store double %t2248, double* %l4
  store { i8**, i64 }* %t2249, { i8**, i64 }** %l1
  store double %t2250, double* %l6
  store { %MatchContext*, i64 }* %t2251, { %MatchContext*, i64 }** %l5
  %t2252 = load %PythonBuilder, %PythonBuilder* %l0
  %t2253 = load double, double* %l4
  %t2254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2255 = load %PythonBuilder, %PythonBuilder* %l0
  %t2256 = load %PythonBuilder, %PythonBuilder* %l0
  %t2257 = load double, double* %l4
  %t2258 = load %PythonBuilder, %PythonBuilder* %l0
  %t2259 = load double, double* %l4
  %t2260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2261 = load %PythonBuilder, %PythonBuilder* %l0
  %t2262 = load %PythonBuilder, %PythonBuilder* %l0
  %t2263 = load double, double* %l6
  %t2264 = load %PythonBuilder, %PythonBuilder* %l0
  %t2265 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2266 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2267 = load %PythonBuilder, %PythonBuilder* %l0
  %t2268 = load %PythonBuilder, %PythonBuilder* %l0
  %t2269 = load %PythonBuilder, %PythonBuilder* %l0
  %t2270 = load %PythonBuilder, %PythonBuilder* %l0
  %t2271 = load %PythonBuilder, %PythonBuilder* %l0
  %t2272 = load %PythonBuilder, %PythonBuilder* %l0
  %t2273 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2274 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2275 = load %PythonBuilder, %PythonBuilder* %l0
  %t2276 = load %PythonBuilder, %PythonBuilder* %l0
  %t2277 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2278 = load %PythonBuilder, %PythonBuilder* %l0
  %t2279 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2280 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge57
merge57:
  %t2281 = phi %PythonBuilder [ %t1048, %then55 ], [ %t2252, %merge60 ]
  %t2282 = phi double [ %t1050, %then55 ], [ %t2253, %merge60 ]
  %t2283 = phi { i8**, i64 }* [ %t1002, %then55 ], [ %t2254, %merge60 ]
  %t2284 = phi double [ %t1007, %then55 ], [ %t2263, %merge60 ]
  %t2285 = phi { %MatchContext*, i64 }* [ %t1006, %then55 ], [ %t2265, %merge60 ]
  store %PythonBuilder %t2281, %PythonBuilder* %l0
  store double %t2282, double* %l4
  store { i8**, i64 }* %t2283, { i8**, i64 }** %l1
  store double %t2284, double* %l6
  store { %MatchContext*, i64 }* %t2285, { %MatchContext*, i64 }** %l5
  %t2286 = load %PythonBuilder, %PythonBuilder* %l0
  %t2287 = load %PythonBuilder, %PythonBuilder* %l0
  %t2288 = load double, double* %l4
  %t2289 = load %PythonBuilder, %PythonBuilder* %l0
  %t2290 = load double, double* %l4
  %t2291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2292 = load %PythonBuilder, %PythonBuilder* %l0
  %t2293 = load %PythonBuilder, %PythonBuilder* %l0
  %t2294 = load double, double* %l4
  %t2295 = load %PythonBuilder, %PythonBuilder* %l0
  %t2296 = load double, double* %l4
  %t2297 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2298 = load %PythonBuilder, %PythonBuilder* %l0
  %t2299 = load %PythonBuilder, %PythonBuilder* %l0
  %t2300 = load double, double* %l6
  %t2301 = load %PythonBuilder, %PythonBuilder* %l0
  %t2302 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2303 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2304 = load %PythonBuilder, %PythonBuilder* %l0
  %t2305 = load %PythonBuilder, %PythonBuilder* %l0
  %t2306 = load %PythonBuilder, %PythonBuilder* %l0
  %t2307 = load %PythonBuilder, %PythonBuilder* %l0
  %t2308 = load %PythonBuilder, %PythonBuilder* %l0
  %t2309 = load %PythonBuilder, %PythonBuilder* %l0
  %t2310 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2311 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2312 = load %PythonBuilder, %PythonBuilder* %l0
  %t2313 = load %PythonBuilder, %PythonBuilder* %l0
  %t2314 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2315 = load %PythonBuilder, %PythonBuilder* %l0
  %t2316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2317 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge51
merge51:
  %t2318 = phi %PythonBuilder [ %t942, %merge54 ], [ %t2286, %merge57 ]
  %t2319 = phi double [ %t943, %merge54 ], [ %t2288, %merge57 ]
  %t2320 = phi { i8**, i64 }* [ %t944, %merge54 ], [ %t2291, %merge57 ]
  %t2321 = phi double [ %t912, %merge54 ], [ %t2300, %merge57 ]
  %t2322 = phi { %MatchContext*, i64 }* [ %t911, %merge54 ], [ %t2302, %merge57 ]
  store %PythonBuilder %t2318, %PythonBuilder* %l0
  store double %t2319, double* %l4
  store { i8**, i64 }* %t2320, { i8**, i64 }** %l1
  store double %t2321, double* %l6
  store { %MatchContext*, i64 }* %t2322, { %MatchContext*, i64 }** %l5
  %t2323 = load %PythonBuilder, %PythonBuilder* %l0
  %t2324 = load double, double* %l4
  %t2325 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2326 = load %PythonBuilder, %PythonBuilder* %l0
  %t2327 = load %PythonBuilder, %PythonBuilder* %l0
  %t2328 = load double, double* %l4
  %t2329 = load %PythonBuilder, %PythonBuilder* %l0
  %t2330 = load double, double* %l4
  %t2331 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2332 = load %PythonBuilder, %PythonBuilder* %l0
  %t2333 = load %PythonBuilder, %PythonBuilder* %l0
  %t2334 = load double, double* %l4
  %t2335 = load %PythonBuilder, %PythonBuilder* %l0
  %t2336 = load double, double* %l4
  %t2337 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2338 = load %PythonBuilder, %PythonBuilder* %l0
  %t2339 = load %PythonBuilder, %PythonBuilder* %l0
  %t2340 = load double, double* %l6
  %t2341 = load %PythonBuilder, %PythonBuilder* %l0
  %t2342 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2343 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2344 = load %PythonBuilder, %PythonBuilder* %l0
  %t2345 = load %PythonBuilder, %PythonBuilder* %l0
  %t2346 = load %PythonBuilder, %PythonBuilder* %l0
  %t2347 = load %PythonBuilder, %PythonBuilder* %l0
  %t2348 = load %PythonBuilder, %PythonBuilder* %l0
  %t2349 = load %PythonBuilder, %PythonBuilder* %l0
  %t2350 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2351 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2352 = load %PythonBuilder, %PythonBuilder* %l0
  %t2353 = load %PythonBuilder, %PythonBuilder* %l0
  %t2354 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2355 = load %PythonBuilder, %PythonBuilder* %l0
  %t2356 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2357 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
merge45:
  %t2358 = phi %PythonBuilder [ %t846, %merge48 ], [ %t2323, %merge51 ]
  %t2359 = phi { i8**, i64 }* [ %t847, %merge48 ], [ %t2325, %merge51 ]
  %t2360 = phi double [ %t814, %merge48 ], [ %t2324, %merge51 ]
  %t2361 = phi double [ %t816, %merge48 ], [ %t2340, %merge51 ]
  %t2362 = phi { %MatchContext*, i64 }* [ %t815, %merge48 ], [ %t2342, %merge51 ]
  store %PythonBuilder %t2358, %PythonBuilder* %l0
  store { i8**, i64 }* %t2359, { i8**, i64 }** %l1
  store double %t2360, double* %l4
  store double %t2361, double* %l6
  store { %MatchContext*, i64 }* %t2362, { %MatchContext*, i64 }** %l5
  %t2363 = load %PythonBuilder, %PythonBuilder* %l0
  %t2364 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2365 = load %PythonBuilder, %PythonBuilder* %l0
  %t2366 = load %PythonBuilder, %PythonBuilder* %l0
  %t2367 = load %PythonBuilder, %PythonBuilder* %l0
  %t2368 = load double, double* %l4
  %t2369 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2370 = load %PythonBuilder, %PythonBuilder* %l0
  %t2371 = load %PythonBuilder, %PythonBuilder* %l0
  %t2372 = load double, double* %l4
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
  %t2384 = load double, double* %l6
  %t2385 = load %PythonBuilder, %PythonBuilder* %l0
  %t2386 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2388 = load %PythonBuilder, %PythonBuilder* %l0
  %t2389 = load %PythonBuilder, %PythonBuilder* %l0
  %t2390 = load %PythonBuilder, %PythonBuilder* %l0
  %t2391 = load %PythonBuilder, %PythonBuilder* %l0
  %t2392 = load %PythonBuilder, %PythonBuilder* %l0
  %t2393 = load %PythonBuilder, %PythonBuilder* %l0
  %t2394 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2395 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2396 = load %PythonBuilder, %PythonBuilder* %l0
  %t2397 = load %PythonBuilder, %PythonBuilder* %l0
  %t2398 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2399 = load %PythonBuilder, %PythonBuilder* %l0
  %t2400 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2401 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge42
merge42:
  %t2402 = phi %PythonBuilder [ %t751, %then40 ], [ %t2363, %merge45 ]
  %t2403 = phi double [ %t753, %then40 ], [ %t2368, %merge45 ]
  %t2404 = phi { i8**, i64 }* [ %t718, %then40 ], [ %t2364, %merge45 ]
  %t2405 = phi double [ %t723, %then40 ], [ %t2384, %merge45 ]
  %t2406 = phi { %MatchContext*, i64 }* [ %t722, %then40 ], [ %t2386, %merge45 ]
  store %PythonBuilder %t2402, %PythonBuilder* %l0
  store double %t2403, double* %l4
  store { i8**, i64 }* %t2404, { i8**, i64 }** %l1
  store double %t2405, double* %l6
  store { %MatchContext*, i64 }* %t2406, { %MatchContext*, i64 }** %l5
  %t2407 = load %PythonBuilder, %PythonBuilder* %l0
  %t2408 = load %PythonBuilder, %PythonBuilder* %l0
  %t2409 = load double, double* %l4
  %t2410 = load %PythonBuilder, %PythonBuilder* %l0
  %t2411 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2412 = load %PythonBuilder, %PythonBuilder* %l0
  %t2413 = load %PythonBuilder, %PythonBuilder* %l0
  %t2414 = load %PythonBuilder, %PythonBuilder* %l0
  %t2415 = load double, double* %l4
  %t2416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2417 = load %PythonBuilder, %PythonBuilder* %l0
  %t2418 = load %PythonBuilder, %PythonBuilder* %l0
  %t2419 = load double, double* %l4
  %t2420 = load %PythonBuilder, %PythonBuilder* %l0
  %t2421 = load double, double* %l4
  %t2422 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2423 = load %PythonBuilder, %PythonBuilder* %l0
  %t2424 = load %PythonBuilder, %PythonBuilder* %l0
  %t2425 = load double, double* %l4
  %t2426 = load %PythonBuilder, %PythonBuilder* %l0
  %t2427 = load double, double* %l4
  %t2428 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2429 = load %PythonBuilder, %PythonBuilder* %l0
  %t2430 = load %PythonBuilder, %PythonBuilder* %l0
  %t2431 = load double, double* %l6
  %t2432 = load %PythonBuilder, %PythonBuilder* %l0
  %t2433 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2434 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2435 = load %PythonBuilder, %PythonBuilder* %l0
  %t2436 = load %PythonBuilder, %PythonBuilder* %l0
  %t2437 = load %PythonBuilder, %PythonBuilder* %l0
  %t2438 = load %PythonBuilder, %PythonBuilder* %l0
  %t2439 = load %PythonBuilder, %PythonBuilder* %l0
  %t2440 = load %PythonBuilder, %PythonBuilder* %l0
  %t2441 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2442 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2443 = load %PythonBuilder, %PythonBuilder* %l0
  %t2444 = load %PythonBuilder, %PythonBuilder* %l0
  %t2445 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2446 = load %PythonBuilder, %PythonBuilder* %l0
  %t2447 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2448 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
merge31:
  %t2449 = phi double [ %t659, %merge34 ], [ %t530, %merge42 ]
  %t2450 = phi %PythonBuilder [ %t660, %merge34 ], [ %t2407, %merge42 ]
  %t2451 = phi double [ %t527, %merge34 ], [ %t2409, %merge42 ]
  %t2452 = phi { i8**, i64 }* [ %t524, %merge34 ], [ %t2411, %merge42 ]
  %t2453 = phi double [ %t529, %merge34 ], [ %t2431, %merge42 ]
  %t2454 = phi { %MatchContext*, i64 }* [ %t528, %merge34 ], [ %t2433, %merge42 ]
  store double %t2449, double* %l7
  store %PythonBuilder %t2450, %PythonBuilder* %l0
  store double %t2451, double* %l4
  store { i8**, i64 }* %t2452, { i8**, i64 }** %l1
  store double %t2453, double* %l6
  store { %MatchContext*, i64 }* %t2454, { %MatchContext*, i64 }** %l5
  %t2455 = load double, double* %l7
  %t2456 = load %PythonBuilder, %PythonBuilder* %l0
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
  br label %merge23
merge23:
  %t2499 = phi %PythonBuilder [ %t465, %merge26 ], [ %t2456, %merge31 ]
  %t2500 = phi double [ %t466, %merge26 ], [ %t2455, %merge31 ]
  %t2501 = phi double [ %t372, %merge26 ], [ %t2459, %merge31 ]
  %t2502 = phi { i8**, i64 }* [ %t369, %merge26 ], [ %t2461, %merge31 ]
  %t2503 = phi double [ %t374, %merge26 ], [ %t2481, %merge31 ]
  %t2504 = phi { %MatchContext*, i64 }* [ %t373, %merge26 ], [ %t2483, %merge31 ]
  store %PythonBuilder %t2499, %PythonBuilder* %l0
  store double %t2500, double* %l7
  store double %t2501, double* %l4
  store { i8**, i64 }* %t2502, { i8**, i64 }** %l1
  store double %t2503, double* %l6
  store { %MatchContext*, i64 }* %t2504, { %MatchContext*, i64 }** %l5
  %t2505 = load %PythonBuilder, %PythonBuilder* %l0
  %t2506 = load double, double* %l7
  %t2507 = load double, double* %l7
  %t2508 = load %PythonBuilder, %PythonBuilder* %l0
  %t2509 = load %PythonBuilder, %PythonBuilder* %l0
  %t2510 = load %PythonBuilder, %PythonBuilder* %l0
  %t2511 = load double, double* %l4
  %t2512 = load %PythonBuilder, %PythonBuilder* %l0
  %t2513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2514 = load %PythonBuilder, %PythonBuilder* %l0
  %t2515 = load %PythonBuilder, %PythonBuilder* %l0
  %t2516 = load %PythonBuilder, %PythonBuilder* %l0
  %t2517 = load double, double* %l4
  %t2518 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2519 = load %PythonBuilder, %PythonBuilder* %l0
  %t2520 = load %PythonBuilder, %PythonBuilder* %l0
  %t2521 = load double, double* %l4
  %t2522 = load %PythonBuilder, %PythonBuilder* %l0
  %t2523 = load double, double* %l4
  %t2524 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2525 = load %PythonBuilder, %PythonBuilder* %l0
  %t2526 = load %PythonBuilder, %PythonBuilder* %l0
  %t2527 = load double, double* %l4
  %t2528 = load %PythonBuilder, %PythonBuilder* %l0
  %t2529 = load double, double* %l4
  %t2530 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2531 = load %PythonBuilder, %PythonBuilder* %l0
  %t2532 = load %PythonBuilder, %PythonBuilder* %l0
  %t2533 = load double, double* %l6
  %t2534 = load %PythonBuilder, %PythonBuilder* %l0
  %t2535 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2536 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2537 = load %PythonBuilder, %PythonBuilder* %l0
  %t2538 = load %PythonBuilder, %PythonBuilder* %l0
  %t2539 = load %PythonBuilder, %PythonBuilder* %l0
  %t2540 = load %PythonBuilder, %PythonBuilder* %l0
  %t2541 = load %PythonBuilder, %PythonBuilder* %l0
  %t2542 = load %PythonBuilder, %PythonBuilder* %l0
  %t2543 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2544 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2545 = load %PythonBuilder, %PythonBuilder* %l0
  %t2546 = load %PythonBuilder, %PythonBuilder* %l0
  %t2547 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2548 = load %PythonBuilder, %PythonBuilder* %l0
  %t2549 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2550 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge12
merge12:
  %t2551 = phi %PythonBuilder [ %t309, %merge15 ], [ %t2505, %merge23 ]
  %t2552 = phi double [ %t311, %merge15 ], [ %t2506, %merge23 ]
  %t2553 = phi double [ %t174, %merge15 ], [ %t2511, %merge23 ]
  %t2554 = phi { i8**, i64 }* [ %t171, %merge15 ], [ %t2513, %merge23 ]
  %t2555 = phi double [ %t176, %merge15 ], [ %t2533, %merge23 ]
  %t2556 = phi { %MatchContext*, i64 }* [ %t175, %merge15 ], [ %t2535, %merge23 ]
  store %PythonBuilder %t2551, %PythonBuilder* %l0
  store double %t2552, double* %l7
  store double %t2553, double* %l4
  store { i8**, i64 }* %t2554, { i8**, i64 }** %l1
  store double %t2555, double* %l6
  store { %MatchContext*, i64 }* %t2556, { %MatchContext*, i64 }** %l5
  %t2557 = load double, double* %l7
  %t2558 = sitofp i64 1 to double
  %t2559 = fadd double %t2557, %t2558
  store double %t2559, double* %l7
  br label %loop.latch6
loop.latch6:
  %t2560 = load %PythonBuilder, %PythonBuilder* %l0
  %t2561 = load double, double* %l7
  %t2562 = load double, double* %l4
  %t2563 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2564 = load double, double* %l6
  %t2565 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t2572 = load %PythonBuilder, %PythonBuilder* %l0
  %t2573 = load double, double* %l7
  %t2574 = load double, double* %l4
  %t2575 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2576 = load double, double* %l6
  %t2577 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2578 = load %PythonBuilder, %PythonBuilder* %l0
  %t2579 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2580 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2581 = load i8*, i8** %l3
  %t2582 = load double, double* %l4
  %t2583 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2584 = load double, double* %l6
  %t2585 = load double, double* %l7
  br label %loop.header111
loop.header111:
  %t2637 = phi %PythonBuilder [ %t2578, %afterloop7 ], [ %t2634, %loop.latch113 ]
  %t2638 = phi { i8**, i64 }* [ %t2579, %afterloop7 ], [ %t2635, %loop.latch113 ]
  %t2639 = phi { %MatchContext*, i64 }* [ %t2583, %afterloop7 ], [ %t2636, %loop.latch113 ]
  store %PythonBuilder %t2637, %PythonBuilder* %l0
  store { i8**, i64 }* %t2638, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t2639, { %MatchContext*, i64 }** %l5
  br label %loop.body112
loop.body112:
  %t2586 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2587 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2586
  %t2588 = extractvalue { %MatchContext*, i64 } %t2587, 1
  %t2589 = icmp eq i64 %t2588, 0
  %t2590 = load %PythonBuilder, %PythonBuilder* %l0
  %t2591 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2592 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2593 = load i8*, i8** %l3
  %t2594 = load double, double* %l4
  %t2595 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2596 = load double, double* %l6
  %t2597 = load double, double* %l7
  br i1 %t2589, label %then115, label %merge116
then115:
  br label %afterloop114
merge116:
  %t2598 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2599 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2598
  %t2600 = extractvalue { %MatchContext*, i64 } %t2599, 1
  %t2601 = sub i64 %t2600, 1
  store i64 %t2601, i64* %l38
  %t2602 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2603 = load i64, i64* %l38
  %t2604 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2602
  %t2605 = extractvalue { %MatchContext*, i64 } %t2604, 0
  %t2606 = extractvalue { %MatchContext*, i64 } %t2604, 1
  %t2607 = icmp uge i64 %t2603, %t2606
  ; bounds check: %t2607 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2603, i64 %t2606)
  %t2608 = getelementptr %MatchContext, %MatchContext* %t2605, i64 %t2603
  %t2609 = load %MatchContext, %MatchContext* %t2608
  store %MatchContext %t2609, %MatchContext* %l39
  %t2610 = load %MatchContext, %MatchContext* %l39
  %t2611 = extractvalue %MatchContext %t2610, 2
  %t2612 = load %PythonBuilder, %PythonBuilder* %l0
  %t2613 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2614 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2615 = load i8*, i8** %l3
  %t2616 = load double, double* %l4
  %t2617 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2618 = load double, double* %l6
  %t2619 = load double, double* %l7
  %t2620 = load i64, i64* %l38
  %t2621 = load %MatchContext, %MatchContext* %l39
  br i1 %t2611, label %then117, label %merge118
then117:
  %t2622 = load %PythonBuilder, %PythonBuilder* %l0
  %t2623 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2622)
  store %PythonBuilder %t2623, %PythonBuilder* %l0
  %t2624 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge118
merge118:
  %t2625 = phi %PythonBuilder [ %t2624, %then117 ], [ %t2612, %merge116 ]
  store %PythonBuilder %t2625, %PythonBuilder* %l0
  %t2626 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2627 = extractvalue %NativeFunction %function, 0
  %s2628 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1409903806, i32 0, i32 0
  %t2629 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2626, i8* %t2627, i8* %s2628)
  store { i8**, i64 }* %t2629, { i8**, i64 }** %l1
  %t2630 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2631 = load i64, i64* %l38
  %t2632 = sitofp i64 %t2631 to double
  %t2633 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t2630, double %t2632)
  store { %MatchContext*, i64 }* %t2633, { %MatchContext*, i64 }** %l5
  br label %loop.latch113
loop.latch113:
  %t2634 = load %PythonBuilder, %PythonBuilder* %l0
  %t2635 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2636 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header111
afterloop114:
  %t2640 = load %PythonBuilder, %PythonBuilder* %l0
  %t2641 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2642 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2643 = load %PythonBuilder, %PythonBuilder* %l0
  %t2644 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2645 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2646 = load i8*, i8** %l3
  %t2647 = load double, double* %l4
  %t2648 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2649 = load double, double* %l6
  %t2650 = load double, double* %l7
  br label %loop.header119
loop.header119:
  %t2674 = phi %PythonBuilder [ %t2643, %afterloop114 ], [ %t2671, %loop.latch121 ]
  %t2675 = phi double [ %t2647, %afterloop114 ], [ %t2672, %loop.latch121 ]
  %t2676 = phi { i8**, i64 }* [ %t2644, %afterloop114 ], [ %t2673, %loop.latch121 ]
  store %PythonBuilder %t2674, %PythonBuilder* %l0
  store double %t2675, double* %l4
  store { i8**, i64 }* %t2676, { i8**, i64 }** %l1
  br label %loop.body120
loop.body120:
  %t2651 = load double, double* %l4
  %t2652 = sitofp i64 0 to double
  %t2653 = fcmp ole double %t2651, %t2652
  %t2654 = load %PythonBuilder, %PythonBuilder* %l0
  %t2655 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2656 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2657 = load i8*, i8** %l3
  %t2658 = load double, double* %l4
  %t2659 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2660 = load double, double* %l6
  %t2661 = load double, double* %l7
  br i1 %t2653, label %then123, label %merge124
then123:
  br label %afterloop122
merge124:
  %t2662 = load %PythonBuilder, %PythonBuilder* %l0
  %t2663 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2662)
  store %PythonBuilder %t2663, %PythonBuilder* %l0
  %t2664 = load double, double* %l4
  %t2665 = sitofp i64 1 to double
  %t2666 = fsub double %t2664, %t2665
  store double %t2666, double* %l4
  %t2667 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2668 = extractvalue %NativeFunction %function, 0
  %s2669 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1736570074, i32 0, i32 0
  %t2670 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2667, i8* %t2668, i8* %s2669)
  store { i8**, i64 }* %t2670, { i8**, i64 }** %l1
  br label %loop.latch121
loop.latch121:
  %t2671 = load %PythonBuilder, %PythonBuilder* %l0
  %t2672 = load double, double* %l4
  %t2673 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header119
afterloop122:
  %t2677 = load %PythonBuilder, %PythonBuilder* %l0
  %t2678 = load double, double* %l4
  %t2679 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2680 = load %PythonBuilder, %PythonBuilder* %l0
  %t2681 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2680)
  store %PythonBuilder %t2681, %PythonBuilder* %l0
  %t2682 = load %PythonBuilder, %PythonBuilder* %l0
  %t2683 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t2682, 0
  %t2684 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2685 = insertvalue %PythonFunctionEmission %t2683, { i8**, i64 }* %t2684, 1
  ret %PythonFunctionEmission %t2685
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
  %s0 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1077944870, i32 0, i32 0
  %t1 = call i8* @number_to_string(double %counter)
  %t2 = call i8* @sailfin_runtime_string_concat(i8* %s0, i8* %t1)
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
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
  %s30 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h237997259, i32 0, i32 0
  %t31 = insertvalue %LoweredCaseCondition undef, i8* %s30, 0
  %t32 = insertvalue %LoweredCaseCondition %t31, i1 1, 1
  %t33 = insertvalue %LoweredCaseCondition %t32, i1 0, 2
  ret %LoweredCaseCondition %t33
merge7:
  %t34 = load i8*, i8** %l1
  %t35 = call i8* @lower_expression(i8* %t34)
  store i8* %t35, i8** %l3
  %t36 = load i8*, i8** %l3
  %t37 = insertvalue %LoweredCaseCondition undef, i8* %t36, 0
  %t38 = insertvalue %LoweredCaseCondition %t37, i1 0, 1
  %t39 = insertvalue %LoweredCaseCondition %t38, i1 1, 2
  ret %LoweredCaseCondition %t39
merge5:
  %t40 = load i8*, i8** %l0
  %t41 = call i8* @lower_expression(i8* %t40)
  store i8* %t41, i8** %l4
  %s42 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h174361445, i32 0, i32 0
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %subject_name, i8* %s42)
  %t44 = load i8*, i8** %l4
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %t43, i8* %t44)
  store i8* %t45, i8** %l5
  store i1 0, i1* %l6
  %t46 = load i8*, i8** %l1
  %t47 = icmp ne i8* %t46, null
  %t48 = load i8*, i8** %l0
  %t49 = load i8*, i8** %l1
  %t50 = load i8*, i8** %l4
  %t51 = load i8*, i8** %l5
  %t52 = load i1, i1* %l6
  br i1 %t47, label %then8, label %merge9
then8:
  %t53 = load i8*, i8** %l1
  %t54 = call i8* @lower_expression(i8* %t53)
  store i8* %t54, i8** %l7
  %t55 = load i8*, i8** %l5
  %t56 = add i64 0, 2
  %t57 = call i8* @malloc(i64 %t56)
  store i8 40, i8* %t57
  %t58 = getelementptr i8, i8* %t57, i64 1
  store i8 0, i8* %t58
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %t55)
  %s60 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1543377657, i32 0, i32 0
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %s60)
  %t62 = load i8*, i8** %l7
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t62)
  %t64 = add i64 0, 2
  %t65 = call i8* @malloc(i64 %t64)
  store i8 41, i8* %t65
  %t66 = getelementptr i8, i8* %t65, i64 1
  store i8 0, i8* %t66
  call void @sailfin_runtime_mark_persistent(i8* %t65)
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %t65)
  store i8* %t67, i8** %l5
  store i1 1, i1* %l6
  %t68 = load i8*, i8** %l5
  %t69 = load i1, i1* %l6
  br label %merge9
merge9:
  %t70 = phi i8* [ %t68, %then8 ], [ %t51, %merge5 ]
  %t71 = phi i1 [ %t69, %then8 ], [ %t52, %merge5 ]
  store i8* %t70, i8** %l5
  store i1 %t71, i1* %l6
  %t72 = load i8*, i8** %l5
  %t73 = insertvalue %LoweredCaseCondition undef, i8* %t72, 0
  %t74 = insertvalue %LoweredCaseCondition %t73, i1 0, 1
  %t75 = load i1, i1* %l6
  %t76 = insertvalue %LoweredCaseCondition %t74, i1 %t75, 2
  ret %LoweredCaseCondition %t76
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
  %s5 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h626550212, i32 0, i32 0
  store i8* %s5, i8** %l0
  store double %value, double* %l1
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s6, i8** %l2
  %t7 = load i8*, i8** %l0
  %t8 = load double, double* %l1
  %t9 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t60 = phi i8* [ %t9, %merge1 ], [ %t58, %loop.latch4 ]
  %t61 = phi double [ %t8, %merge1 ], [ %t59, %loop.latch4 ]
  store i8* %t60, i8** %l2
  store double %t61, double* %l1
  br label %loop.body3
loop.body3:
  %t10 = load double, double* %l1
  %t11 = sitofp i64 0 to double
  %t12 = fcmp ole double %t10, %t11
  %t13 = load i8*, i8** %l0
  %t14 = load double, double* %l1
  %t15 = load i8*, i8** %l2
  br i1 %t12, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t16 = load double, double* %l1
  store double %t16, double* %l3
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l4
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  %t20 = load i8*, i8** %l2
  %t21 = load double, double* %l3
  %t22 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t39 = phi double [ %t21, %merge7 ], [ %t37, %loop.latch10 ]
  %t40 = phi double [ %t22, %merge7 ], [ %t38, %loop.latch10 ]
  store double %t39, double* %l3
  store double %t40, double* %l4
  br label %loop.body9
loop.body9:
  %t23 = load double, double* %l3
  %t24 = sitofp i64 10 to double
  %t25 = fcmp olt double %t23, %t24
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load i8*, i8** %l2
  %t29 = load double, double* %l3
  %t30 = load double, double* %l4
  br i1 %t25, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t31 = load double, double* %l3
  %t32 = sitofp i64 10 to double
  %t33 = fsub double %t31, %t32
  store double %t33, double* %l3
  %t34 = load double, double* %l4
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l4
  br label %loop.latch10
loop.latch10:
  %t37 = load double, double* %l3
  %t38 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t41 = load double, double* %l3
  %t42 = load double, double* %l4
  %t43 = load double, double* %l3
  store double %t43, double* %l5
  %t44 = load i8*, i8** %l0
  %t45 = load double, double* %l5
  %t46 = load double, double* %l5
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  %t49 = call double @llvm.round.f64(double %t45)
  %t50 = fptosi double %t49 to i64
  %t51 = call double @llvm.round.f64(double %t48)
  %t52 = fptosi double %t51 to i64
  %t53 = call i8* @sailfin_runtime_substring(i8* %t44, i64 %t50, i64 %t52)
  store i8* %t53, i8** %l6
  %t54 = load i8*, i8** %l6
  %t55 = load i8*, i8** %l2
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t55)
  store i8* %t56, i8** %l2
  %t57 = load double, double* %l4
  store double %t57, double* %l1
  br label %loop.latch4
loop.latch4:
  %t58 = load i8*, i8** %l2
  %t59 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t62 = load i8*, i8** %l2
  %t63 = load double, double* %l1
  %t64 = load i8*, i8** %l2
  call void @sailfin_runtime_mark_persistent(i8* %t64)
  ret i8* %t64
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
  %t71 = phi { i8**, i64 }* [ %t28, %merge1 ], [ %t69, %loop.latch4 ]
  %t72 = phi double [ %t29, %merge1 ], [ %t70, %loop.latch4 ]
  store { i8**, i64 }* %t71, { i8**, i64 }** %l0
  store double %t72, double* %l1
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
  %s56 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %s56)
  %t58 = load %NativeParameter, %NativeParameter* %l2
  %t59 = extractvalue %NativeParameter %t58, 3
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %t59)
  store i8* %t60, i8** %l3
  %t61 = load i8*, i8** %l3
  br label %merge9
merge9:
  %t62 = phi i8* [ %t61, %then8 ], [ %t54, %merge7 ]
  store i8* %t62, i8** %l3
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load i8*, i8** %l3
  %t65 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t63, i8* %t64)
  store { i8**, i64 }* %t65, { i8**, i64 }** %l0
  %t66 = load double, double* %l1
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l1
  br label %loop.latch4
loop.latch4:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load double, double* %l1
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t75
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s3, i8** %l0
  %t4 = sitofp i64 0 to double
  store double %t4, double* %l1
  %t5 = load i8*, i8** %l0
  %t6 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t20 = phi i8* [ %t5, %merge1 ], [ %t18, %loop.latch4 ]
  %t21 = phi double [ %t6, %merge1 ], [ %t19, %loop.latch4 ]
  store i8* %t20, i8** %l0
  store double %t21, double* %l1
  br label %loop.body3
loop.body3:
  %t7 = load double, double* %l1
  %t8 = extractvalue %PythonBuilder %builder, 1
  %t9 = fcmp oge double %t7, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h173287691, i32 0, i32 0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %s13)
  store i8* %t14, i8** %l0
  %t15 = load double, double* %l1
  %t16 = sitofp i64 1 to double
  %t17 = fadd double %t15, %t16
  store double %t17, double* %l1
  br label %loop.latch4
loop.latch4:
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load i8*, i8** %l0
  %t25 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %line)
  store i8* %t25, i8** %l2
  %t26 = extractvalue %PythonBuilder %builder, 0
  %t27 = load i8*, i8** %l2
  %t28 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t27)
  store { i8**, i64 }* %t28, { i8**, i64 }** %l3
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t30 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t29, 0
  %t31 = extractvalue %PythonBuilder %builder, 1
  %t32 = insertvalue %PythonBuilder %t30, double %t31, 1
  ret %PythonBuilder %t32
}

define %PythonBuilder @builder_emit_blank(%PythonBuilder %builder) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %PythonBuilder %builder, 0
  %s1 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t2 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t0, i8* %s1)
  store { i8**, i64 }* %t2, { i8**, i64 }** %l0
  %t3 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t4 = insertvalue %PythonBuilder undef, { i8**, i64 }* %t3, 0
  %t5 = extractvalue %PythonBuilder %builder, 1
  %t6 = insertvalue %PythonBuilder %t4, double %t5, 1
  ret %PythonBuilder %t6
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
  %s9 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s9)
  ret i8* %s9
merge1:
  %t10 = load i8*, i8** %l0
  %t11 = add i64 0, 2
  %t12 = call i8* @malloc(i64 %t11)
  store i8 10, i8* %t12
  %t13 = getelementptr i8, i8* %t12, i64 1
  store i8 0, i8* %t13
  call void @sailfin_runtime_mark_persistent(i8* %t12)
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t12)
  call void @sailfin_runtime_mark_persistent(i8* %t14)
  ret i8* %t14
}

define i8* @sanitize_identifier(i8* %name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t49 = phi i8* [ %t2, %block.entry ], [ %t47, %loop.latch2 ]
  %t50 = phi double [ %t3, %block.entry ], [ %t48, %loop.latch2 ]
  store i8* %t49, i8** %l0
  store double %t50, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t6 = sitofp i64 %t5 to double
  %t7 = fcmp oge double %t4, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t10 = load double, double* %l1
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %name, i64 %t12
  %t14 = load i8, i8* %t13
  store i8 %t14, i8* %l2
  %t15 = load i8, i8* %l2
  %t16 = add i64 0, 2
  %t17 = call i8* @malloc(i64 %t16)
  store i8 %t15, i8* %t17
  %t18 = getelementptr i8, i8* %t17, i64 1
  store i8 0, i8* %t18
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  %t19 = call i1 @is_identifier_char(i8* %t17)
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load i8, i8* %l2
  br i1 %t19, label %then6, label %else7
then6:
  %t23 = load i8*, i8** %l0
  %t24 = load i8, i8* %l2
  %t25 = add i64 0, 2
  %t26 = call i8* @malloc(i64 %t25)
  store i8 %t24, i8* %t26
  %t27 = getelementptr i8, i8* %t26, i64 1
  store i8 0, i8* %t27
  call void @sailfin_runtime_mark_persistent(i8* %t26)
  %t28 = call i8* @sailfin_runtime_string_concat(i8* %t23, i8* %t26)
  store i8* %t28, i8** %l0
  %t29 = load i8*, i8** %l0
  br label %merge8
else7:
  %t30 = load i8, i8* %l2
  %t31 = icmp eq i8 %t30, 32
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  %t34 = load i8, i8* %l2
  br i1 %t31, label %then9, label %merge10
then9:
  %t35 = load i8*, i8** %l0
  %t36 = add i64 0, 2
  %t37 = call i8* @malloc(i64 %t36)
  store i8 95, i8* %t37
  %t38 = getelementptr i8, i8* %t37, i64 1
  store i8 0, i8* %t38
  call void @sailfin_runtime_mark_persistent(i8* %t37)
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t35, i8* %t37)
  store i8* %t39, i8** %l0
  %t40 = load i8*, i8** %l0
  br label %merge10
merge10:
  %t41 = phi i8* [ %t40, %then9 ], [ %t32, %else7 ]
  store i8* %t41, i8** %l0
  %t42 = load i8*, i8** %l0
  br label %merge8
merge8:
  %t43 = phi i8* [ %t29, %then6 ], [ %t42, %merge10 ]
  store i8* %t43, i8** %l0
  %t44 = load double, double* %l1
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  store double %t46, double* %l1
  br label %loop.latch2
loop.latch2:
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t51 = load i8*, i8** %l0
  %t52 = load double, double* %l1
  %t53 = load i8*, i8** %l0
  %t54 = call i64 @sailfin_runtime_string_length(i8* %t53)
  %t55 = icmp eq i64 %t54, 0
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l1
  br i1 %t55, label %then11, label %merge12
then11:
  %s58 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1387621460, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s58)
  ret i8* %s58
merge12:
  %t59 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t59)
  ret i8* %t59
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
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s7, i8** %l1
  %t8 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t9 = ptrtoint [0 x i8*]* %t8 to i64
  %t10 = icmp eq i64 %t9, 0
  %t11 = select i1 %t10, i64 1, i64 %t9
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to i8**
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t15 = ptrtoint { i8**, i64 }* %t14 to i64
  %t16 = call i8* @malloc(i64 %t15)
  %t17 = bitcast i8* %t16 to { i8**, i64 }*
  %t18 = getelementptr { i8**, i64 }, { i8**, i64 }* %t17, i32 0, i32 0
  store i8** %t13, i8*** %t18
  %t19 = getelementptr { i8**, i64 }, { i8**, i64 }* %t17, i32 0, i32 1
  store i64 0, i64* %t19
  store { i8**, i64 }* %t17, { i8**, i64 }** %l2
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load i8*, i8** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t24 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t81 = phi { i8**, i64 }* [ %t23, %merge1 ], [ %t78, %loop.latch4 ]
  %t82 = phi i8* [ %t22, %merge1 ], [ %t79, %loop.latch4 ]
  %t83 = phi double [ %t24, %merge1 ], [ %t80, %loop.latch4 ]
  store { i8**, i64 }* %t81, { i8**, i64 }** %l2
  store i8* %t82, i8** %l1
  store double %t83, double* %l3
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t25, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load i8*, i8** %l1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l3
  %t36 = call double @llvm.round.f64(double %t35)
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %t34, i64 %t37
  %t39 = load i8, i8* %t38
  store i8 %t39, i8* %l4
  %t40 = load i8, i8* %l4
  %t41 = icmp eq i8 %t40, 46
  %t42 = load i8*, i8** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t45 = load double, double* %l3
  %t46 = load i8, i8* %l4
  br i1 %t41, label %then8, label %else9
then8:
  %t47 = load i8*, i8** %l1
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = icmp sgt i64 %t48, 0
  %t50 = load i8*, i8** %l0
  %t51 = load i8*, i8** %l1
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t53 = load double, double* %l3
  %t54 = load i8, i8* %l4
  br i1 %t49, label %then11, label %merge12
then11:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t56 = load i8*, i8** %l1
  %t57 = call i8* @sanitize_identifier(i8* %t56)
  %t58 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t55, i8* %t57)
  store { i8**, i64 }* %t58, { i8**, i64 }** %l2
  %s59 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s59, i8** %l1
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t61 = load i8*, i8** %l1
  br label %merge12
merge12:
  %t62 = phi { i8**, i64 }* [ %t60, %then11 ], [ %t52, %then8 ]
  %t63 = phi i8* [ %t61, %then11 ], [ %t51, %then8 ]
  store { i8**, i64 }* %t62, { i8**, i64 }** %l2
  store i8* %t63, i8** %l1
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t65 = load i8*, i8** %l1
  br label %merge10
else9:
  %t66 = load i8*, i8** %l1
  %t67 = load i8, i8* %l4
  %t68 = add i64 0, 2
  %t69 = call i8* @malloc(i64 %t68)
  store i8 %t67, i8* %t69
  %t70 = getelementptr i8, i8* %t69, i64 1
  store i8 0, i8* %t70
  call void @sailfin_runtime_mark_persistent(i8* %t69)
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t69)
  store i8* %t71, i8** %l1
  %t72 = load i8*, i8** %l1
  br label %merge10
merge10:
  %t73 = phi { i8**, i64 }* [ %t64, %merge12 ], [ %t44, %else9 ]
  %t74 = phi i8* [ %t65, %merge12 ], [ %t72, %else9 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l2
  store i8* %t74, i8** %l1
  %t75 = load double, double* %l3
  %t76 = sitofp i64 1 to double
  %t77 = fadd double %t75, %t76
  store double %t77, double* %l3
  br label %loop.latch4
loop.latch4:
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t79 = load i8*, i8** %l1
  %t80 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t85 = load i8*, i8** %l1
  %t86 = load double, double* %l3
  %t87 = load i8*, i8** %l1
  %t88 = call i64 @sailfin_runtime_string_length(i8* %t87)
  %t89 = icmp sgt i64 %t88, 0
  %t90 = load i8*, i8** %l0
  %t91 = load i8*, i8** %l1
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t93 = load double, double* %l3
  br i1 %t89, label %then13, label %merge14
then13:
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t95 = load i8*, i8** %l1
  %t96 = call i8* @sanitize_identifier(i8* %t95)
  %t97 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t94, i8* %t96)
  store { i8**, i64 }* %t97, { i8**, i64 }** %l2
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t99 = phi { i8**, i64 }* [ %t98, %then13 ], [ %t92, %afterloop5 ]
  store { i8**, i64 }* %t99, { i8**, i64 }** %l2
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t100
  %t102 = extractvalue { i8**, i64 } %t101, 1
  %t103 = icmp eq i64 %t102, 0
  %t104 = load i8*, i8** %l0
  %t105 = load i8*, i8** %l1
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t107 = load double, double* %l3
  br i1 %t103, label %then15, label %merge16
then15:
  %t108 = load i8*, i8** %l0
  %t109 = call i8* @sanitize_identifier(i8* %t108)
  call void @sailfin_runtime_mark_persistent(i8* %t109)
  ret i8* %t109
merge16:
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t111 = add i64 0, 2
  %t112 = call i8* @malloc(i64 %t111)
  store i8 46, i8* %t112
  %t113 = getelementptr i8, i8* %t112, i64 1
  store i8 0, i8* %t113
  call void @sailfin_runtime_mark_persistent(i8* %t112)
  %t114 = call i8* @join_with_separator({ i8**, i64 }* %t110, i8* %t112)
  call void @sailfin_runtime_mark_persistent(i8* %t114)
  ret i8* %t114
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
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s2, i8** %l0
  %t3 = sitofp i64 0 to double
  store double %t3, double* %l1
  %t4 = load i8*, i8** %l0
  %t5 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t84 = phi i8* [ %t4, %merge1 ], [ %t82, %loop.latch4 ]
  %t85 = phi double [ %t5, %merge1 ], [ %t83, %loop.latch4 ]
  store i8* %t84, i8** %l0
  store double %t85, double* %l1
  br label %loop.body3
loop.body3:
  %t6 = load double, double* %l1
  %t7 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  br i1 %t9, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t12 = load double, double* %l1
  %t13 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t14 = sitofp i64 %t13 to double
  %t15 = fadd double %t12, %t14
  %t16 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t17 = sitofp i64 %t16 to double
  %t18 = fcmp ole double %t15, %t17
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  br i1 %t18, label %then8, label %merge9
then8:
  store i1 1, i1* %l2
  %t21 = sitofp i64 0 to double
  store double %t21, double* %l3
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load i1, i1* %l2
  %t25 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t56 = phi i1 [ %t24, %then8 ], [ %t54, %loop.latch12 ]
  %t57 = phi double [ %t25, %then8 ], [ %t55, %loop.latch12 ]
  store i1 %t56, i1* %l2
  store double %t57, double* %l3
  br label %loop.body11
loop.body11:
  %t26 = load double, double* %l3
  %t27 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t26, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load i1, i1* %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t34 = load double, double* %l1
  %t35 = load double, double* %l3
  %t36 = fadd double %t34, %t35
  %t37 = call double @llvm.round.f64(double %t36)
  %t38 = fptosi double %t37 to i64
  %t39 = getelementptr i8, i8* %value, i64 %t38
  %t40 = load i8, i8* %t39
  %t41 = load double, double* %l3
  %t42 = call double @llvm.round.f64(double %t41)
  %t43 = fptosi double %t42 to i64
  %t44 = getelementptr i8, i8* %target, i64 %t43
  %t45 = load i8, i8* %t44
  %t46 = icmp ne i8 %t40, %t45
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load i1, i1* %l2
  %t50 = load double, double* %l3
  br i1 %t46, label %then16, label %merge17
then16:
  store i1 0, i1* %l2
  br label %afterloop13
merge17:
  %t51 = load double, double* %l3
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l3
  br label %loop.latch12
loop.latch12:
  %t54 = load i1, i1* %l2
  %t55 = load double, double* %l3
  br label %loop.header10
afterloop13:
  %t58 = load i1, i1* %l2
  %t59 = load double, double* %l3
  %t60 = load i1, i1* %l2
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l1
  %t63 = load i1, i1* %l2
  %t64 = load double, double* %l3
  br i1 %t60, label %then18, label %merge19
then18:
  %t65 = load i8*, i8** %l0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %replacement)
  store i8* %t66, i8** %l0
  %t67 = load double, double* %l1
  %t68 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t69 = sitofp i64 %t68 to double
  %t70 = fadd double %t67, %t69
  store double %t70, double* %l1
  br label %loop.latch4
merge19:
  %t71 = load i8*, i8** %l0
  %t72 = load double, double* %l1
  br label %merge9
merge9:
  %t73 = phi i8* [ %t71, %merge19 ], [ %t19, %merge7 ]
  %t74 = phi double [ %t72, %merge19 ], [ %t20, %merge7 ]
  store i8* %t73, i8** %l0
  store double %t74, double* %l1
  %t75 = load i8*, i8** %l0
  %t76 = load double, double* %l1
  %t77 = call i8* @char_at(i8* %value, double %t76)
  %t78 = call i8* @sailfin_runtime_string_concat(i8* %t75, i8* %t77)
  store i8* %t78, i8** %l0
  %t79 = load double, double* %l1
  %t80 = sitofp i64 1 to double
  %t81 = fadd double %t79, %t80
  store double %t81, double* %l1
  br label %loop.latch4
loop.latch4:
  %t82 = load i8*, i8** %l0
  %t83 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t86 = load i8*, i8** %l0
  %t87 = load double, double* %l1
  %t88 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t88)
  ret i8* %t88
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
  %s3 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s3)
  ret i8* %s3
merge1:
  %t4 = load { i8**, i64 }, { i8**, i64 }* %values
  %t5 = extractvalue { i8**, i64 } %t4, 0
  %t6 = extractvalue { i8**, i64 } %t4, 1
  %t7 = icmp uge i64 0, %t6
  ; bounds check: %t7 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t6)
  %t8 = getelementptr i8*, i8** %t5, i64 0
  %t9 = load i8*, i8** %t8
  store i8* %t9, i8** %l0
  %t10 = sitofp i64 1 to double
  store double %t10, double* %l1
  %t11 = load i8*, i8** %l0
  %t12 = load double, double* %l1
  br label %loop.header2
loop.header2:
  %t37 = phi i8* [ %t11, %merge1 ], [ %t35, %loop.latch4 ]
  %t38 = phi double [ %t12, %merge1 ], [ %t36, %loop.latch4 ]
  store i8* %t37, i8** %l0
  store double %t38, double* %l1
  br label %loop.body3
loop.body3:
  %t13 = load double, double* %l1
  %t14 = load { i8**, i64 }, { i8**, i64 }* %values
  %t15 = extractvalue { i8**, i64 } %t14, 1
  %t16 = sitofp i64 %t15 to double
  %t17 = fcmp oge double %t13, %t16
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  br i1 %t17, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t20 = load i8*, i8** %l0
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %separator)
  %t22 = load double, double* %l1
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = load { i8**, i64 }, { i8**, i64 }* %values
  %t26 = extractvalue { i8**, i64 } %t25, 0
  %t27 = extractvalue { i8**, i64 } %t25, 1
  %t28 = icmp uge i64 %t24, %t27
  ; bounds check: %t28 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t24, i64 %t27)
  %t29 = getelementptr i8*, i8** %t26, i64 %t24
  %t30 = load i8*, i8** %t29
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %t21, i8* %t30)
  store i8* %t31, i8** %l0
  %t32 = load double, double* %l1
  %t33 = sitofp i64 1 to double
  %t34 = fadd double %t32, %t33
  store double %t34, double* %l1
  br label %loop.latch4
loop.latch4:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t41)
  ret i8* %t41
}

define { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %diagnostics, i8* %function_name, i8* %detail) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_text(i8* %function_name)
  store i8* %t0, i8** %l0
  %s1 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h2001621394, i32 0, i32 0
  store i8* %s1, i8** %l1
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  %t6 = load i8*, i8** %l1
  br i1 %t4, label %then0, label %else1
then0:
  %t7 = load i8*, i8** %l1
  %t8 = call i8* @sailfin_runtime_string_concat(i8* %t7, i8* %detail)
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  br label %merge2
else1:
  %t10 = load i8*, i8** %l1
  %t11 = load i8*, i8** %l0
  %t12 = call i8* @sailfin_runtime_string_concat(i8* %t10, i8* %t11)
  %s13 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t14 = call i8* @sailfin_runtime_string_concat(i8* %t12, i8* %s13)
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t14, i8* %detail)
  store i8* %t15, i8** %l1
  %t16 = load i8*, i8** %l1
  br label %merge2
merge2:
  %t17 = phi i8* [ %t9, %then0 ], [ %t16, %else1 ]
  store i8* %t17, i8** %l1
  %t18 = load i8*, i8** %l1
  %t19 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %diagnostics, i8* %t18)
  ret { i8**, i64 }* %t19
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
@.str.len3.h2087691079 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.len5.h843097466 = private unnamed_addr constant [6 x i8] c"False\00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len8.h794378208 = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len20.h728584192 = private unnamed_addr constant [21 x i8] c"runtime.enum_field('\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len2.h193516127 = private unnamed_addr constant [3 x i8] c"||\00"
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len25.h458257002 = private unnamed_addr constant [26 x i8] c"endif without matching if\00"
@.str.len7.h739212033 = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len22.h1038501153 = private unnamed_addr constant [23 x i8] c"runtime.struct_field('\00"
@.str.len7.h1558772342 = private unnamed_addr constant [8 x i8] c".length\00"
@.str.len5.h461434216 = private unnamed_addr constant [6 x i8] c"self.\00"
@.str.len39.h198700275 = private unnamed_addr constant [40 x i8] c"# unsupported: endmatch without context\00"
@.str.len8.h267355070 = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len10.h1977847647 = private unnamed_addr constant [11 x i8] c"index += 1\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.str.len2.h193478474 = private unnamed_addr constant [3 x i8] c"\5C'\00"
@.str.len31.h568140000 = private unnamed_addr constant [32 x i8] c" = runtime.enum_define_variant(\00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.str.len15.h1983072220 = private unnamed_addr constant [16 x i8] c"# unsupported: \00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.str.len4.h173287691 = private unnamed_addr constant [5 x i8] c"    \00"
@.str.len7.h1543377657 = private unnamed_addr constant [8 x i8] c") and (\00"
@.str.len4.h270590402 = private unnamed_addr constant [5 x i8] c"pass\00"
@.str.len10.h1629914700 = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len8.h104511138 = private unnamed_addr constant [9 x i8] c"', self.\00"
@.str.len5.h1503489441 = private unnamed_addr constant [6 x i8] c" and \00"
@.str.len2.h193459862 = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len3.h2089113841 = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len2.h193480223 = private unnamed_addr constant [3 x i8] c"\5C\5C\00"
@.str.len42.h9444846 = private unnamed_addr constant [43 x i8] c"unsupported instruction emitted as comment\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len2.h193481015 = private unnamed_addr constant [3 x i8] c"\5Ct\00"
@.str.len7.h919609845 = private unnamed_addr constant [8 x i8] c"import \00"
@.str.len25.h117462910 = private unnamed_addr constant [26 x i8] c"runtime.enum_instantiate(\00"
@.str.len22.h983476432 = private unnamed_addr constant [23 x i8] c"if field.name == item:\00"
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len31.h1736570074 = private unnamed_addr constant [32 x i8] c"unterminated control-flow block\00"
@.str.len29.h1409903806 = private unnamed_addr constant [30 x i8] c"unterminated match expression\00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len4.h228395909 = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len24.h2028465620 = private unnamed_addr constant [25 x i8] c"else without matching if\00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len15.h1309566598 = private unnamed_addr constant [16 x i8] c"compiler.build.\00"
@.str.len4.h230766299 = private unnamed_addr constant [5 x i8] c"None\00"
@.str.len2.h193441217 = private unnamed_addr constant [3 x i8] c": \00"
@.str.len8.h757831264 = private unnamed_addr constant [9 x i8] c".concat(\00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len5.h706445588 = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len11.h1898426375 = private unnamed_addr constant [12 x i8] c"while True:\00"
@.str.len18.h1456282769 = private unnamed_addr constant [19 x i8] c"return field.value\00"
@.str.len2.h193479167 = private unnamed_addr constant [3 x i8] c"[]\00"
@.str.len37.h314404344 = private unnamed_addr constant [38 x i8] c"endmatch without active match context\00"
@.str.len26.h1088202076 = private unnamed_addr constant [27 x i8] c"field = self.fields[index]\00"
@.str.len2.h193414949 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len9.h320851598 = private unnamed_addr constant [10 x i8] c"index = 0\00"
@.str.len4.h268720028 = private unnamed_addr constant [5 x i8] c"not \00"
@.str.len6.h536277508 = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len4.h268929446 = private unnamed_addr constant [5 x i8] c"null\00"
@.str.len5.h2069215535 = private unnamed_addr constant [6 x i8] c"elif \00"
@.str.len4.h219990644 = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.len12.h300877395 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.len3.h2088090973 = private unnamed_addr constant [4 x i8] c", '\00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len29.h1122035900 = private unnamed_addr constant [30 x i8] c"endloop without matching loop\00"
@.str.len6.h1258614714 = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len32.h1370567591 = private unnamed_addr constant [33 x i8] c"endfor without matching for loop\00"
@.str.len2.h193428644 = private unnamed_addr constant [3 x i8] c"./\00"
@.str.len5.h2069574674 = private unnamed_addr constant [6 x i8] c"else:\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len29.h610920064 = private unnamed_addr constant [30 x i8] c"if index >= len(self.fields):\00"
@.str.len28.h430828782 = private unnamed_addr constant [29 x i8] c"def __getattr__(self, item):\00"
@.str.len39.h2079567388 = private unnamed_addr constant [40 x i8] c"match case without active match context\00"
@.str.len3.h2090359129 = private unnamed_addr constant [4 x i8] c"if \00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len11.h1460619898 = private unnamed_addr constant [12 x i8] c" (pattern: \00"
@.str.len26.h1984174475 = private unnamed_addr constant [27 x i8] c"raise AttributeError(item)\00"
@.str.len4.h237997259 = private unnamed_addr constant [5 x i8] c"True\00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len4.h217223495 = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len6.h653919037 = private unnamed_addr constant [7 x i8] c"', [])\00"
@.str.len39.h1262256381 = private unnamed_addr constant [40 x i8] c"no sailfin-native-text artifact present\00"
@.str.len11.h1779553665 = private unnamed_addr constant [12 x i8] c"# effects: \00"
@.str.len8.h2085806463 = private unnamed_addr constant [9 x i8] c"runtime/\00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len9.h757580446 = private unnamed_addr constant [10 x i8] c"#element:\00"
@.str.len2.h193517249 = private unnamed_addr constant [3 x i8] c"}}\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len5.h1117315388 = private unnamed_addr constant [6 x i8] c"Match\00"
@.str.len4.h176216012 = private unnamed_addr constant [5 x i8] c" or \00"
@.str.len2.h193419635 = private unnamed_addr constant [3 x i8] c"&&\00"
@.str.len3.h2087924125 = private unnamed_addr constant [4 x i8] c"', \00"
@.str.len4.h259230482 = private unnamed_addr constant [5 x i8] c"for \00"
@.str.len4.h230767751 = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len5.h819045845 = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len6.h1061063223 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.len41.h1804821690 = private unnamed_addr constant [42 x i8] c"# unsupported: match case without context\00"
@.str.len5.h468448796 = private unnamed_addr constant [6 x i8] c"=None\00"
@.str.len2.h193480817 = private unnamed_addr constant [3 x i8] c"\5Cn\00"
@.str.len4.h265982546 = private unnamed_addr constant [5 x i8] c"len(\00"
@.str.len7.h48777630 = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len5.h1776141546 = private unnamed_addr constant [6 x i8] c") + (\00"
@.str.len2.h193515005 = private unnamed_addr constant [3 x i8] c"{{\00"
@.str.len18.h1387621460 = private unnamed_addr constant [19 x i8] c"generated_function\00"
@.str.len2.h193480949 = private unnamed_addr constant [3 x i8] c"\5Cr\00"