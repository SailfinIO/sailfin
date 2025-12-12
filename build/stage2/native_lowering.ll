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

declare void @sailfin_runtime_mark_persistent(i8*)

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
  %t54 = phi { i8**, i64 }* [ %t17, %merge1 ], [ %t52, %loop.latch4 ]
  %t55 = phi double [ %t18, %merge1 ], [ %t53, %loop.latch4 ]
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  store double %t55, double* %l1
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
  %t38 = alloca [2 x i8], align 1
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8 39, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 1
  store i8 0, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t37)
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 39, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t46)
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t26, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = sitofp i64 1 to double
  %t51 = fadd double %t49, %t50
  store double %t51, double* %l1
  br label %loop.latch4
loop.latch4:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t57 = load double, double* %l1
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s59 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t60 = call i8* @join_with_separator({ i8**, i64 }* %t58, i8* %s59)
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
  %t11 = alloca [2 x i8], align 1
  %t12 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  store i8 47, i8* %t12
  %t13 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 1
  store i8 0, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t11, i32 0, i32 0
  %t15 = alloca [2 x i8], align 1
  %t16 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  store i8 46, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 1
  store i8 0, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t15, i32 0, i32 0
  %t19 = call i8* @replace_all(i8* %t10, i8* %t14, i8* %t18)
  store i8* %t19, i8** %l1
  %s20 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1309566598, i32 0, i32 0
  %t21 = load i8*, i8** %l1
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %s20, i8* %t21)
  call void @sailfin_runtime_mark_persistent(i8* %t22)
  ret i8* %t22
merge3:
  %t23 = load i8*, i8** %l0
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428644, i32 0, i32 0
  %t25 = call i1 @starts_with(i8* %t23, i8* %s24)
  %t26 = load i8*, i8** %l0
  br i1 %t25, label %then4, label %merge5
then4:
  %t27 = load i8*, i8** %l0
  %t28 = load i8*, i8** %l0
  %t29 = call i64 @sailfin_runtime_string_length(i8* %t28)
  %t30 = call i8* @sailfin_runtime_substring(i8* %t27, i64 2, i64 %t29)
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  %t32 = alloca [2 x i8], align 1
  %t33 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  store i8 47, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 1
  store i8 0, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t32, i32 0, i32 0
  %t36 = alloca [2 x i8], align 1
  %t37 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8 46, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 1
  store i8 0, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  %t40 = call i8* @replace_all(i8* %t31, i8* %t35, i8* %t39)
  store i8* %t40, i8** %l2
  %s41 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1309566598, i32 0, i32 0
  %t42 = load i8*, i8** %l2
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %s41, i8* %t42)
  call void @sailfin_runtime_mark_persistent(i8* %t43)
  ret i8* %t43
merge5:
  %t44 = load i8*, i8** %l0
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 47, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  %t49 = alloca [2 x i8], align 1
  %t50 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  store i8 46, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 1
  store i8 0, i8* %t51
  %t52 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  %t53 = call i8* @replace_all(i8* %t44, i8* %t48, i8* %t52)
  call void @sailfin_runtime_mark_persistent(i8* %t53)
  ret i8* %t53
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
  %t148 = phi { i8**, i64 }* [ %t111, %afterloop3 ], [ %t146, %loop.latch18 ]
  %t149 = phi double [ %t110, %afterloop3 ], [ %t147, %loop.latch18 ]
  store { i8**, i64 }* %t148, { i8**, i64 }** %l5
  store double %t149, double* %l1
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
  %t132 = alloca [2 x i8], align 1
  %t133 = getelementptr [2 x i8], [2 x i8]* %t132, i32 0, i32 0
  store i8 34, i8* %t133
  %t134 = getelementptr [2 x i8], [2 x i8]* %t132, i32 0, i32 1
  store i8 0, i8* %t134
  %t135 = getelementptr [2 x i8], [2 x i8]* %t132, i32 0, i32 0
  %t136 = call i8* @sailfin_runtime_string_concat(i8* %t135, i8* %t131)
  %t137 = alloca [2 x i8], align 1
  %t138 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  store i8 34, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 1
  store i8 0, i8* %t139
  %t140 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  %t141 = call i8* @sailfin_runtime_string_concat(i8* %t136, i8* %t140)
  %t142 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t121, i8* %t141)
  store { i8**, i64 }* %t142, { i8**, i64 }** %l5
  %t143 = load double, double* %l1
  %t144 = sitofp i64 1 to double
  %t145 = fadd double %t143, %t144
  store double %t145, double* %l1
  br label %loop.latch18
loop.latch18:
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t147 = load double, double* %l1
  br label %loop.header16
afterloop19:
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t151 = load double, double* %l1
  %s152 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1657754115, i32 0, i32 0
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s154 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t155 = call i8* @join_with_separator({ i8**, i64 }* %t153, i8* %s154)
  %t156 = call i8* @sailfin_runtime_string_concat(i8* %s152, i8* %t155)
  %t157 = alloca [2 x i8], align 1
  %t158 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 0
  store i8 93, i8* %t158
  %t159 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 1
  store i8 0, i8* %t159
  %t160 = getelementptr [2 x i8], [2 x i8]* %t157, i32 0, i32 0
  %t161 = call i8* @sailfin_runtime_string_concat(i8* %t156, i8* %t160)
  %t162 = call %PythonBuilder @builder_emit(%PythonBuilder %builder, i8* %t161)
  ret %PythonBuilder %t162
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
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 58, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  %t9 = call i8* @sailfin_runtime_string_concat(i8* %t4, i8* %t8)
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
  %s27 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h215787497, i32 0, i32 0
  store i8* %s27, i8** %l4
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t29 = load { i8**, i64 }, { i8**, i64 }* %t28
  %t30 = extractvalue { i8**, i64 } %t29, 1
  %t31 = icmp sgt i64 %t30, 0
  %t32 = load i8*, i8** %l0
  %t33 = load %PythonBuilder, %PythonBuilder* %l1
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t36 = load i8*, i8** %l4
  br i1 %t31, label %then0, label %merge1
then0:
  %t37 = load i8*, i8** %l4
  %s38 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t39 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %s38)
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %s41 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t42 = call i8* @join_with_separator({ i8**, i64 }* %t40, i8* %s41)
  %t43 = call i8* @sailfin_runtime_string_concat(i8* %t39, i8* %t42)
  store i8* %t43, i8** %l4
  %t44 = load i8*, i8** %l4
  br label %merge1
merge1:
  %t45 = phi i8* [ %t44, %then0 ], [ %t36, %block.entry ]
  store i8* %t45, i8** %l4
  %t46 = load i8*, i8** %l4
  %t47 = alloca [2 x i8], align 1
  %t48 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 0
  store i8 41, i8* %t48
  %t49 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 1
  store i8 0, i8* %t49
  %t50 = getelementptr [2 x i8], [2 x i8]* %t47, i32 0, i32 0
  %t51 = call i8* @sailfin_runtime_string_concat(i8* %t46, i8* %t50)
  store i8* %t51, i8** %l4
  %t52 = load %PythonBuilder, %PythonBuilder* %l1
  %t53 = load i8*, i8** %l4
  %t54 = alloca [2 x i8], align 1
  %t55 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8 58, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 1
  store i8 0, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  %t58 = call i8* @sailfin_runtime_string_concat(i8* %t53, i8* %t57)
  %t59 = call %PythonBuilder @builder_emit(%PythonBuilder %t52, i8* %t58)
  store %PythonBuilder %t59, %PythonBuilder* %l1
  %t60 = load %PythonBuilder, %PythonBuilder* %l1
  %t61 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t60)
  store %PythonBuilder %t61, %PythonBuilder* %l1
  %t62 = extractvalue %NativeStruct %definition, 1
  %t63 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t62
  %t64 = extractvalue { %NativeStructField*, i64 } %t63, 1
  %t65 = icmp eq i64 %t64, 0
  %t66 = load i8*, i8** %l0
  %t67 = load %PythonBuilder, %PythonBuilder* %l1
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t70 = load i8*, i8** %l4
  br i1 %t65, label %then2, label %else3
then2:
  %t71 = load %PythonBuilder, %PythonBuilder* %l1
  %s72 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t73 = call %PythonBuilder @builder_emit(%PythonBuilder %t71, i8* %s72)
  store %PythonBuilder %t73, %PythonBuilder* %l1
  %t74 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
else3:
  %t75 = sitofp i64 0 to double
  store double %t75, double* %l5
  %t76 = load i8*, i8** %l0
  %t77 = load %PythonBuilder, %PythonBuilder* %l1
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t80 = load i8*, i8** %l4
  %t81 = load double, double* %l5
  br label %loop.header5
loop.header5:
  %t121 = phi %PythonBuilder [ %t77, %else3 ], [ %t119, %loop.latch7 ]
  %t122 = phi double [ %t81, %else3 ], [ %t120, %loop.latch7 ]
  store %PythonBuilder %t121, %PythonBuilder* %l1
  store double %t122, double* %l5
  br label %loop.body6
loop.body6:
  %t82 = load double, double* %l5
  %t83 = extractvalue %NativeStruct %definition, 1
  %t84 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t83
  %t85 = extractvalue { %NativeStructField*, i64 } %t84, 1
  %t86 = sitofp i64 %t85 to double
  %t87 = fcmp oge double %t82, %t86
  %t88 = load i8*, i8** %l0
  %t89 = load %PythonBuilder, %PythonBuilder* %l1
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t92 = load i8*, i8** %l4
  %t93 = load double, double* %l5
  br i1 %t87, label %then9, label %merge10
then9:
  br label %afterloop8
merge10:
  %t94 = extractvalue %NativeStruct %definition, 1
  %t95 = load double, double* %l5
  %t96 = call double @llvm.round.f64(double %t95)
  %t97 = fptosi double %t96 to i64
  %t98 = load { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t94
  %t99 = extractvalue { %NativeStructField*, i64 } %t98, 0
  %t100 = extractvalue { %NativeStructField*, i64 } %t98, 1
  %t101 = icmp uge i64 %t97, %t100
  ; bounds check: %t101 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t97, i64 %t100)
  %t102 = getelementptr %NativeStructField, %NativeStructField* %t99, i64 %t97
  %t103 = load %NativeStructField, %NativeStructField* %t102
  store %NativeStructField %t103, %NativeStructField* %l6
  %t104 = load %NativeStructField, %NativeStructField* %l6
  %t105 = extractvalue %NativeStructField %t104, 0
  %t106 = call i8* @sanitize_identifier(i8* %t105)
  store i8* %t106, i8** %l7
  %t107 = load %PythonBuilder, %PythonBuilder* %l1
  %s108 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h461434216, i32 0, i32 0
  %t109 = load i8*, i8** %l7
  %t110 = call i8* @sailfin_runtime_string_concat(i8* %s108, i8* %t109)
  %s111 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t112 = call i8* @sailfin_runtime_string_concat(i8* %t110, i8* %s111)
  %t113 = load i8*, i8** %l7
  %t114 = call i8* @sailfin_runtime_string_concat(i8* %t112, i8* %t113)
  %t115 = call %PythonBuilder @builder_emit(%PythonBuilder %t107, i8* %t114)
  store %PythonBuilder %t115, %PythonBuilder* %l1
  %t116 = load double, double* %l5
  %t117 = sitofp i64 1 to double
  %t118 = fadd double %t116, %t117
  store double %t118, double* %l5
  br label %loop.latch7
loop.latch7:
  %t119 = load %PythonBuilder, %PythonBuilder* %l1
  %t120 = load double, double* %l5
  br label %loop.header5
afterloop8:
  %t123 = load %PythonBuilder, %PythonBuilder* %l1
  %t124 = load double, double* %l5
  %t125 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge4
merge4:
  %t126 = phi %PythonBuilder [ %t74, %then2 ], [ %t125, %afterloop8 ]
  store %PythonBuilder %t126, %PythonBuilder* %l1
  %t127 = load %PythonBuilder, %PythonBuilder* %l1
  %t128 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t127)
  store %PythonBuilder %t128, %PythonBuilder* %l1
  %t129 = load %PythonBuilder, %PythonBuilder* %l1
  %t130 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t129)
  store %PythonBuilder %t130, %PythonBuilder* %l1
  %t131 = load %PythonBuilder, %PythonBuilder* %l1
  %s132 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1806641125, i32 0, i32 0
  %t133 = call %PythonBuilder @builder_emit(%PythonBuilder %t131, i8* %s132)
  store %PythonBuilder %t133, %PythonBuilder* %l1
  %t134 = load %PythonBuilder, %PythonBuilder* %l1
  %t135 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t134)
  store %PythonBuilder %t135, %PythonBuilder* %l1
  %t136 = load i8*, i8** %l0
  %t137 = extractvalue %NativeStruct %definition, 1
  %t138 = call i8* @render_struct_repr_fields(i8* %t136, { %NativeStructField*, i64 }* %t137)
  store i8* %t138, i8** %l8
  %t139 = load %PythonBuilder, %PythonBuilder* %l1
  %t140 = load i8*, i8** %l8
  %t141 = call %PythonBuilder @builder_emit(%PythonBuilder %t139, i8* %t140)
  store %PythonBuilder %t141, %PythonBuilder* %l1
  %t142 = load %PythonBuilder, %PythonBuilder* %l1
  %t143 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t142)
  store %PythonBuilder %t143, %PythonBuilder* %l1
  %t144 = load i8*, i8** %l0
  %s145 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h300877395, i32 0, i32 0
  %t146 = call i1 @strings_equal(i8* %t144, i8* %s145)
  %t147 = load i8*, i8** %l0
  %t148 = load %PythonBuilder, %PythonBuilder* %l1
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t151 = load i8*, i8** %l4
  %t152 = load i8*, i8** %l8
  br i1 %t146, label %then11, label %merge12
then11:
  %t153 = load %PythonBuilder, %PythonBuilder* %l1
  %t154 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t153)
  store %PythonBuilder %t154, %PythonBuilder* %l1
  %t155 = load %PythonBuilder, %PythonBuilder* %l1
  %s156 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h430828782, i32 0, i32 0
  %t157 = call %PythonBuilder @builder_emit(%PythonBuilder %t155, i8* %s156)
  store %PythonBuilder %t157, %PythonBuilder* %l1
  %t158 = load %PythonBuilder, %PythonBuilder* %l1
  %t159 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t158)
  store %PythonBuilder %t159, %PythonBuilder* %l1
  %t160 = load %PythonBuilder, %PythonBuilder* %l1
  %s161 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h320851598, i32 0, i32 0
  %t162 = call %PythonBuilder @builder_emit(%PythonBuilder %t160, i8* %s161)
  store %PythonBuilder %t162, %PythonBuilder* %l1
  %t163 = load %PythonBuilder, %PythonBuilder* %l1
  %s164 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t165 = call %PythonBuilder @builder_emit(%PythonBuilder %t163, i8* %s164)
  store %PythonBuilder %t165, %PythonBuilder* %l1
  %t166 = load %PythonBuilder, %PythonBuilder* %l1
  %t167 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t166)
  store %PythonBuilder %t167, %PythonBuilder* %l1
  %t168 = load %PythonBuilder, %PythonBuilder* %l1
  %s169 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h610920064, i32 0, i32 0
  %t170 = call %PythonBuilder @builder_emit(%PythonBuilder %t168, i8* %s169)
  store %PythonBuilder %t170, %PythonBuilder* %l1
  %t171 = load %PythonBuilder, %PythonBuilder* %l1
  %t172 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t171)
  store %PythonBuilder %t172, %PythonBuilder* %l1
  %t173 = load %PythonBuilder, %PythonBuilder* %l1
  %s174 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t175 = call %PythonBuilder @builder_emit(%PythonBuilder %t173, i8* %s174)
  store %PythonBuilder %t175, %PythonBuilder* %l1
  %t176 = load %PythonBuilder, %PythonBuilder* %l1
  %t177 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t176)
  store %PythonBuilder %t177, %PythonBuilder* %l1
  %t178 = load %PythonBuilder, %PythonBuilder* %l1
  %s179 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1088202076, i32 0, i32 0
  %t180 = call %PythonBuilder @builder_emit(%PythonBuilder %t178, i8* %s179)
  store %PythonBuilder %t180, %PythonBuilder* %l1
  %t181 = load %PythonBuilder, %PythonBuilder* %l1
  %s182 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h983476432, i32 0, i32 0
  %t183 = call %PythonBuilder @builder_emit(%PythonBuilder %t181, i8* %s182)
  store %PythonBuilder %t183, %PythonBuilder* %l1
  %t184 = load %PythonBuilder, %PythonBuilder* %l1
  %t185 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t184)
  store %PythonBuilder %t185, %PythonBuilder* %l1
  %t186 = load %PythonBuilder, %PythonBuilder* %l1
  %s187 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1456282769, i32 0, i32 0
  %t188 = call %PythonBuilder @builder_emit(%PythonBuilder %t186, i8* %s187)
  store %PythonBuilder %t188, %PythonBuilder* %l1
  %t189 = load %PythonBuilder, %PythonBuilder* %l1
  %t190 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t189)
  store %PythonBuilder %t190, %PythonBuilder* %l1
  %t191 = load %PythonBuilder, %PythonBuilder* %l1
  %s192 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1977847647, i32 0, i32 0
  %t193 = call %PythonBuilder @builder_emit(%PythonBuilder %t191, i8* %s192)
  store %PythonBuilder %t193, %PythonBuilder* %l1
  %t194 = load %PythonBuilder, %PythonBuilder* %l1
  %t195 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t194)
  store %PythonBuilder %t195, %PythonBuilder* %l1
  %t196 = load %PythonBuilder, %PythonBuilder* %l1
  %s197 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1984174475, i32 0, i32 0
  %t198 = call %PythonBuilder @builder_emit(%PythonBuilder %t196, i8* %s197)
  store %PythonBuilder %t198, %PythonBuilder* %l1
  %t199 = load %PythonBuilder, %PythonBuilder* %l1
  %t200 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t199)
  store %PythonBuilder %t200, %PythonBuilder* %l1
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
  %t217 = load %PythonBuilder, %PythonBuilder* %l1
  %t218 = load %PythonBuilder, %PythonBuilder* %l1
  %t219 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge12
merge12:
  %t220 = phi %PythonBuilder [ %t201, %then11 ], [ %t148, %merge4 ]
  %t221 = phi %PythonBuilder [ %t202, %then11 ], [ %t148, %merge4 ]
  %t222 = phi %PythonBuilder [ %t203, %then11 ], [ %t148, %merge4 ]
  %t223 = phi %PythonBuilder [ %t204, %then11 ], [ %t148, %merge4 ]
  %t224 = phi %PythonBuilder [ %t205, %then11 ], [ %t148, %merge4 ]
  %t225 = phi %PythonBuilder [ %t206, %then11 ], [ %t148, %merge4 ]
  %t226 = phi %PythonBuilder [ %t207, %then11 ], [ %t148, %merge4 ]
  %t227 = phi %PythonBuilder [ %t208, %then11 ], [ %t148, %merge4 ]
  %t228 = phi %PythonBuilder [ %t209, %then11 ], [ %t148, %merge4 ]
  %t229 = phi %PythonBuilder [ %t210, %then11 ], [ %t148, %merge4 ]
  %t230 = phi %PythonBuilder [ %t211, %then11 ], [ %t148, %merge4 ]
  %t231 = phi %PythonBuilder [ %t212, %then11 ], [ %t148, %merge4 ]
  %t232 = phi %PythonBuilder [ %t213, %then11 ], [ %t148, %merge4 ]
  %t233 = phi %PythonBuilder [ %t214, %then11 ], [ %t148, %merge4 ]
  %t234 = phi %PythonBuilder [ %t215, %then11 ], [ %t148, %merge4 ]
  %t235 = phi %PythonBuilder [ %t216, %then11 ], [ %t148, %merge4 ]
  %t236 = phi %PythonBuilder [ %t217, %then11 ], [ %t148, %merge4 ]
  %t237 = phi %PythonBuilder [ %t218, %then11 ], [ %t148, %merge4 ]
  %t238 = phi %PythonBuilder [ %t219, %then11 ], [ %t148, %merge4 ]
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
  store %PythonBuilder %t236, %PythonBuilder* %l1
  store %PythonBuilder %t237, %PythonBuilder* %l1
  store %PythonBuilder %t238, %PythonBuilder* %l1
  %t239 = extractvalue %NativeStruct %definition, 2
  %t240 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t239
  %t241 = extractvalue { %NativeFunction*, i64 } %t240, 1
  %t242 = icmp sgt i64 %t241, 0
  %t243 = load i8*, i8** %l0
  %t244 = load %PythonBuilder, %PythonBuilder* %l1
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t247 = load i8*, i8** %l4
  %t248 = load i8*, i8** %l8
  br i1 %t242, label %then13, label %merge14
then13:
  %t249 = load %PythonBuilder, %PythonBuilder* %l1
  %t250 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t249)
  store %PythonBuilder %t250, %PythonBuilder* %l1
  %t251 = sitofp i64 0 to double
  store double %t251, double* %l9
  %t252 = load i8*, i8** %l0
  %t253 = load %PythonBuilder, %PythonBuilder* %l1
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t256 = load i8*, i8** %l4
  %t257 = load i8*, i8** %l8
  %t258 = load double, double* %l9
  br label %loop.header15
loop.header15:
  %t318 = phi %PythonBuilder [ %t253, %then13 ], [ %t315, %loop.latch17 ]
  %t319 = phi { i8**, i64 }* [ %t254, %then13 ], [ %t316, %loop.latch17 ]
  %t320 = phi double [ %t258, %then13 ], [ %t317, %loop.latch17 ]
  store %PythonBuilder %t318, %PythonBuilder* %l1
  store { i8**, i64 }* %t319, { i8**, i64 }** %l2
  store double %t320, double* %l9
  br label %loop.body16
loop.body16:
  %t259 = load double, double* %l9
  %t260 = extractvalue %NativeStruct %definition, 2
  %t261 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t260
  %t262 = extractvalue { %NativeFunction*, i64 } %t261, 1
  %t263 = sitofp i64 %t262 to double
  %t264 = fcmp oge double %t259, %t263
  %t265 = load i8*, i8** %l0
  %t266 = load %PythonBuilder, %PythonBuilder* %l1
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t269 = load i8*, i8** %l4
  %t270 = load i8*, i8** %l8
  %t271 = load double, double* %l9
  br i1 %t264, label %then19, label %merge20
then19:
  br label %afterloop18
merge20:
  %t272 = extractvalue %NativeStruct %definition, 2
  %t273 = load double, double* %l9
  %t274 = call double @llvm.round.f64(double %t273)
  %t275 = fptosi double %t274 to i64
  %t276 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t272
  %t277 = extractvalue { %NativeFunction*, i64 } %t276, 0
  %t278 = extractvalue { %NativeFunction*, i64 } %t276, 1
  %t279 = icmp uge i64 %t275, %t278
  ; bounds check: %t279 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t275, i64 %t278)
  %t280 = getelementptr %NativeFunction, %NativeFunction* %t277, i64 %t275
  %t281 = load %NativeFunction, %NativeFunction* %t280
  store %NativeFunction %t281, %NativeFunction* %l10
  %t282 = load %PythonBuilder, %PythonBuilder* %l1
  %t283 = load %NativeFunction, %NativeFunction* %l10
  %t284 = call %PythonFunctionEmission @emit_python_function(%PythonBuilder %t282, %NativeFunction %t283)
  store %PythonFunctionEmission %t284, %PythonFunctionEmission* %l11
  %t285 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t286 = extractvalue %PythonFunctionEmission %t285, 0
  store %PythonBuilder %t286, %PythonBuilder* %l1
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t288 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  %t289 = extractvalue %PythonFunctionEmission %t288, 1
  %t290 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t287, { i8**, i64 }* %t289)
  store { i8**, i64 }* %t290, { i8**, i64 }** %l2
  %t291 = load double, double* %l9
  %t292 = sitofp i64 1 to double
  %t293 = fadd double %t291, %t292
  %t294 = extractvalue %NativeStruct %definition, 2
  %t295 = load { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t294
  %t296 = extractvalue { %NativeFunction*, i64 } %t295, 1
  %t297 = sitofp i64 %t296 to double
  %t298 = fcmp olt double %t293, %t297
  %t299 = load i8*, i8** %l0
  %t300 = load %PythonBuilder, %PythonBuilder* %l1
  %t301 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t303 = load i8*, i8** %l4
  %t304 = load i8*, i8** %l8
  %t305 = load double, double* %l9
  %t306 = load %NativeFunction, %NativeFunction* %l10
  %t307 = load %PythonFunctionEmission, %PythonFunctionEmission* %l11
  br i1 %t298, label %then21, label %merge22
then21:
  %t308 = load %PythonBuilder, %PythonBuilder* %l1
  %t309 = call %PythonBuilder @builder_emit_blank(%PythonBuilder %t308)
  store %PythonBuilder %t309, %PythonBuilder* %l1
  %t310 = load %PythonBuilder, %PythonBuilder* %l1
  br label %merge22
merge22:
  %t311 = phi %PythonBuilder [ %t310, %then21 ], [ %t300, %merge20 ]
  store %PythonBuilder %t311, %PythonBuilder* %l1
  %t312 = load double, double* %l9
  %t313 = sitofp i64 1 to double
  %t314 = fadd double %t312, %t313
  store double %t314, double* %l9
  br label %loop.latch17
loop.latch17:
  %t315 = load %PythonBuilder, %PythonBuilder* %l1
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t317 = load double, double* %l9
  br label %loop.header15
afterloop18:
  %t321 = load %PythonBuilder, %PythonBuilder* %l1
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t323 = load double, double* %l9
  %t324 = load %PythonBuilder, %PythonBuilder* %l1
  %t325 = load %PythonBuilder, %PythonBuilder* %l1
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t327 = phi %PythonBuilder [ %t324, %afterloop18 ], [ %t244, %merge12 ]
  %t328 = phi %PythonBuilder [ %t325, %afterloop18 ], [ %t244, %merge12 ]
  %t329 = phi { i8**, i64 }* [ %t326, %afterloop18 ], [ %t245, %merge12 ]
  store %PythonBuilder %t327, %PythonBuilder* %l1
  store %PythonBuilder %t328, %PythonBuilder* %l1
  store { i8**, i64 }* %t329, { i8**, i64 }** %l2
  %t330 = load %PythonBuilder, %PythonBuilder* %l1
  %t331 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t330)
  store %PythonBuilder %t331, %PythonBuilder* %l1
  %t332 = load %PythonBuilder, %PythonBuilder* %l1
  %t333 = insertvalue %PythonStructEmission undef, %PythonBuilder %t332, 0
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t335 = insertvalue %PythonStructEmission %t333, { i8**, i64 }* %t334, 1
  ret %PythonStructEmission %t335
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
  %t60 = phi { i8**, i64 }* [ %t20, %merge1 ], [ %t58, %loop.latch4 ]
  %t61 = phi double [ %t21, %merge1 ], [ %t59, %loop.latch4 ]
  store { i8**, i64 }* %t60, { i8**, i64 }** %l0
  store double %t61, double* %l1
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
  %t49 = alloca [2 x i8], align 1
  %t50 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  store i8 41, i8* %t50
  %t51 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 1
  store i8 0, i8* %t51
  %t52 = getelementptr [2 x i8], [2 x i8]* %t49, i32 0, i32 0
  %t53 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %t52)
  %t54 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t41, i8* %t53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l0
  %t55 = load double, double* %l1
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l1
  br label %loop.latch4
loop.latch4:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t59 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l1
  %s64 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1179318158, i32 0, i32 0
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %s64, i8* %class_name)
  %s66 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h182022329, i32 0, i32 0
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %s66)
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s69 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t70 = call i8* @join_with_separator({ i8**, i64 }* %t68, i8* %s69)
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t67, i8* %t70)
  %s72 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193479629, i32 0, i32 0
  %t73 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %s72)
  call void @sailfin_runtime_mark_persistent(i8* %t73)
  ret i8* %t73
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
  %t6 = alloca [2 x i8], align 1
  %t7 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  store i8 63, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 1
  store i8 0, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  %t10 = call i1 @ends_with(i8* %t5, i8* %t9)
  ret i1 %t10
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
  %t260 = phi { i8**, i64 }* [ %t219, %afterloop25 ], [ %t258, %loop.latch30 ]
  %t261 = phi double [ %t218, %afterloop25 ], [ %t259, %loop.latch30 ]
  store { i8**, i64 }* %t260, { i8**, i64 }** %l11
  store double %t261, double* %l10
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
  %t244 = alloca [2 x i8], align 1
  %t245 = getelementptr [2 x i8], [2 x i8]* %t244, i32 0, i32 0
  store i8 40, i8* %t245
  %t246 = getelementptr [2 x i8], [2 x i8]* %t244, i32 0, i32 1
  store i8 0, i8* %t246
  %t247 = getelementptr [2 x i8], [2 x i8]* %t244, i32 0, i32 0
  %t248 = call i8* @sailfin_runtime_string_concat(i8* %t247, i8* %t243)
  %t249 = alloca [2 x i8], align 1
  %t250 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 0
  store i8 41, i8* %t250
  %t251 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 1
  store i8 0, i8* %t251
  %t252 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 0
  %t253 = call i8* @sailfin_runtime_string_concat(i8* %t248, i8* %t252)
  %t254 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t233, i8* %t253)
  store { i8**, i64 }* %t254, { i8**, i64 }** %l11
  %t255 = load double, double* %l10
  %t256 = sitofp i64 1 to double
  %t257 = fadd double %t255, %t256
  store double %t257, double* %l10
  br label %loop.latch30
loop.latch30:
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t259 = load double, double* %l10
  br label %loop.header28
afterloop31:
  %t262 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %t263 = load double, double* %l10
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l9
  %s265 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t266 = call i8* @join_with_separator({ i8**, i64 }* %t264, i8* %s265)
  %t267 = alloca [2 x i8], align 1
  %t268 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  store i8 91, i8* %t268
  %t269 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 1
  store i8 0, i8* %t269
  %t270 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %t270, i8* %t266)
  %t272 = alloca [2 x i8], align 1
  %t273 = getelementptr [2 x i8], [2 x i8]* %t272, i32 0, i32 0
  store i8 93, i8* %t273
  %t274 = getelementptr [2 x i8], [2 x i8]* %t272, i32 0, i32 1
  store i8 0, i8* %t274
  %t275 = getelementptr [2 x i8], [2 x i8]* %t272, i32 0, i32 0
  %t276 = call i8* @sailfin_runtime_string_concat(i8* %t271, i8* %t275)
  store i8* %t276, i8** %l12
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l11
  %s278 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t279 = call i8* @join_with_separator({ i8**, i64 }* %t277, i8* %s278)
  %t280 = alloca [2 x i8], align 1
  %t281 = getelementptr [2 x i8], [2 x i8]* %t280, i32 0, i32 0
  store i8 91, i8* %t281
  %t282 = getelementptr [2 x i8], [2 x i8]* %t280, i32 0, i32 1
  store i8 0, i8* %t282
  %t283 = getelementptr [2 x i8], [2 x i8]* %t280, i32 0, i32 0
  %t284 = call i8* @sailfin_runtime_string_concat(i8* %t283, i8* %t279)
  %t285 = alloca [2 x i8], align 1
  %t286 = getelementptr [2 x i8], [2 x i8]* %t285, i32 0, i32 0
  store i8 93, i8* %t286
  %t287 = getelementptr [2 x i8], [2 x i8]* %t285, i32 0, i32 1
  store i8 0, i8* %t287
  %t288 = getelementptr [2 x i8], [2 x i8]* %t285, i32 0, i32 0
  %t289 = call i8* @sailfin_runtime_string_concat(i8* %t284, i8* %t288)
  store i8* %t289, i8** %l13
  %s290 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h583209964, i32 0, i32 0
  %t291 = load i8*, i8** %l12
  %t292 = call i8* @sailfin_runtime_string_concat(i8* %s290, i8* %t291)
  %s293 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t294 = call i8* @sailfin_runtime_string_concat(i8* %t292, i8* %s293)
  %t295 = load i8*, i8** %l13
  %t296 = call i8* @sailfin_runtime_string_concat(i8* %t294, i8* %t295)
  %t297 = alloca [2 x i8], align 1
  %t298 = getelementptr [2 x i8], [2 x i8]* %t297, i32 0, i32 0
  store i8 41, i8* %t298
  %t299 = getelementptr [2 x i8], [2 x i8]* %t297, i32 0, i32 1
  store i8 0, i8* %t299
  %t300 = getelementptr [2 x i8], [2 x i8]* %t297, i32 0, i32 0
  %t301 = call i8* @sailfin_runtime_string_concat(i8* %t296, i8* %t300)
  call void @sailfin_runtime_mark_persistent(i8* %t301)
  ret i8* %t301
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
  %t77 = phi i64 [ %t21, %merge5 ], [ %t75, %loop.latch8 ]
  %t78 = phi i8* [ %t20, %merge5 ], [ %t76, %loop.latch8 ]
  store i64 %t77, i64* %l2
  store i8* %t78, i8** %l1
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
  %t54 = alloca [2 x i8], align 1
  %t55 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  store i8 %t52, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 1
  store i8 0, i8* %t56
  %t57 = getelementptr [2 x i8], [2 x i8]* %t54, i32 0, i32 0
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 %t53, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  %t62 = call i8* @decode_escape_sequence(i8* %t57, i8* %t61)
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t51, i8* %t62)
  store i8* %t63, i8** %l1
  %t64 = load i64, i64* %l2
  %t65 = add i64 %t64, 1
  store i64 %t65, i64* %l2
  br label %loop.latch8
merge13:
  %t66 = load i8*, i8** %l1
  %t67 = load i8, i8* %l3
  %t68 = alloca [2 x i8], align 1
  %t69 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8 %t67, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 1
  store i8 0, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t71)
  store i8* %t72, i8** %l1
  %t73 = load i64, i64* %l2
  %t74 = add i64 %t73, 1
  store i64 %t74, i64* %l2
  br label %loop.latch8
loop.latch8:
  %t75 = load i64, i64* %l2
  %t76 = load i8*, i8** %l1
  br label %loop.header6
afterloop9:
  %t79 = load i64, i64* %l2
  %t80 = load i8*, i8** %l1
  %t81 = load i8*, i8** %l1
  call void @sailfin_runtime_mark_persistent(i8* %t81)
  ret i8* %t81
}

define i8* @decode_escape_sequence(i8* %escape, i8* %quote) {
block.entry:
  %t0 = load i8, i8* %escape
  %t1 = icmp eq i8 %t0, 110
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 10, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
merge1:
  %t6 = load i8, i8* %escape
  %t7 = icmp eq i8 %t6, 114
  br i1 %t7, label %then2, label %merge3
then2:
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 13, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %t11)
  ret i8* %t11
merge3:
  %t12 = load i8, i8* %escape
  %t13 = icmp eq i8 %t12, 116
  br i1 %t13, label %then4, label %merge5
then4:
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 9, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  ret i8* %t17
merge5:
  %t18 = load i8, i8* %escape
  %t19 = icmp eq i8 %t18, 92
  br i1 %t19, label %then6, label %merge7
then6:
  %t20 = alloca [2 x i8], align 1
  %t21 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  store i8 92, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 1
  store i8 0, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %t23)
  ret i8* %t23
merge7:
  %t24 = call i1 @strings_equal(i8* %escape, i8* %quote)
  br i1 %t24, label %then8, label %merge9
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
  %s16 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480223, i32 0, i32 0
  %t17 = alloca [2 x i8], align 1
  %t18 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  store i8 %t15, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 1
  store i8 0, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t17, i32 0, i32 0
  %t21 = call i8* @sailfin_runtime_string_concat(i8* %t20, i8* %s16)
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
  %s30 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193478474, i32 0, i32 0
  %t31 = alloca [2 x i8], align 1
  %t32 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  store i8 %t29, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 1
  store i8 0, i8* %t33
  %t34 = getelementptr [2 x i8], [2 x i8]* %t31, i32 0, i32 0
  %t35 = call i8* @sailfin_runtime_string_concat(i8* %t34, i8* %s30)
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
  %s44 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480817, i32 0, i32 0
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 %t43, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t48, i8* %s44)
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
  %s58 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193480949, i32 0, i32 0
  %t59 = alloca [2 x i8], align 1
  %t60 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  store i8 %t57, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 1
  store i8 0, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t59, i32 0, i32 0
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %s58)
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
  %s72 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193481015, i32 0, i32 0
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 %t71, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  %t77 = call i8* @sailfin_runtime_string_concat(i8* %t76, i8* %s72)
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
  %t114 = alloca [2 x i8], align 1
  %t115 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  store i8 %t113, i8* %t115
  %t116 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 1
  store i8 0, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t114, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %t117)
  ret i8* %t117
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
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 123, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = call double @index_of(i8* %expression, i8* %t3)
  store double %t4, double* %l0
  %t5 = load double, double* %l0
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load double, double* %l0
  br i1 %t7, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge1:
  %t9 = load double, double* %l0
  %t10 = call double @find_matching_brace(i8* %expression, double %t9)
  store double %t10, double* %l1
  %t11 = load double, double* %l1
  %t12 = sitofp i64 0 to double
  %t13 = fcmp olt double %t11, %t12
  %t14 = load double, double* %l0
  %t15 = load double, double* %l1
  br i1 %t13, label %then2, label %merge3
then2:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge3:
  %t16 = load double, double* %l0
  %t17 = call double @llvm.round.f64(double %t16)
  %t18 = fptosi double %t17 to i64
  %t19 = call i8* @sailfin_runtime_substring(i8* %expression, i64 0, i64 %t18)
  %t20 = call i8* @trim_text(i8* %t19)
  store i8* %t20, i8** %l2
  %t21 = load i8*, i8** %l2
  %t22 = call i64 @sailfin_runtime_string_length(i8* %t21)
  %t23 = icmp eq i64 %t22, 0
  %t24 = load double, double* %l0
  %t25 = load double, double* %l1
  %t26 = load i8*, i8** %l2
  br i1 %t23, label %then4, label %merge5
then4:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge5:
  %t27 = load i8*, i8** %l2
  %t28 = call i1 @is_struct_literal_type_candidate(i8* %t27)
  %t29 = xor i1 %t28, 1
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  %t32 = load i8*, i8** %l2
  br i1 %t29, label %then6, label %merge7
then6:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge7:
  %t33 = load double, double* %l0
  %t34 = sitofp i64 1 to double
  %t35 = fadd double %t33, %t34
  %t36 = load double, double* %l1
  %t37 = call double @llvm.round.f64(double %t35)
  %t38 = fptosi double %t37 to i64
  %t39 = call double @llvm.round.f64(double %t36)
  %t40 = fptosi double %t39 to i64
  %t41 = call i8* @sailfin_runtime_substring(i8* %expression, i64 %t38, i64 %t40)
  store i8* %t41, i8** %l3
  %t42 = load i8*, i8** %l3
  %t43 = call { i8**, i64 }* @split_struct_field_entries(i8* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l4
  %t44 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t45 = ptrtoint [0 x i8*]* %t44 to i64
  %t46 = icmp eq i64 %t45, 0
  %t47 = select i1 %t46, i64 1, i64 %t45
  %t48 = call i8* @malloc(i64 %t47)
  %t49 = bitcast i8* %t48 to i8**
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t51 = ptrtoint { i8**, i64 }* %t50 to i64
  %t52 = call i8* @malloc(i64 %t51)
  %t53 = bitcast i8* %t52 to { i8**, i64 }*
  %t54 = getelementptr { i8**, i64 }, { i8**, i64 }* %t53, i32 0, i32 0
  store i8** %t49, i8*** %t54
  %t55 = getelementptr { i8**, i64 }, { i8**, i64 }* %t53, i32 0, i32 1
  store i64 0, i64* %t55
  store { i8**, i64 }* %t53, { i8**, i64 }** %l5
  %t56 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t57 = ptrtoint [0 x i8*]* %t56 to i64
  %t58 = icmp eq i64 %t57, 0
  %t59 = select i1 %t58, i64 1, i64 %t57
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to i8**
  %t62 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t63 = ptrtoint { i8**, i64 }* %t62 to i64
  %t64 = call i8* @malloc(i64 %t63)
  %t65 = bitcast i8* %t64 to { i8**, i64 }*
  %t66 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 0
  store i8** %t61, i8*** %t66
  %t67 = getelementptr { i8**, i64 }, { i8**, i64 }* %t65, i32 0, i32 1
  store i64 0, i64* %t67
  store { i8**, i64 }* %t65, { i8**, i64 }** %l6
  %t68 = sitofp i64 0 to double
  store double %t68, double* %l7
  %t69 = load double, double* %l0
  %t70 = load double, double* %l1
  %t71 = load i8*, i8** %l2
  %t72 = load i8*, i8** %l3
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t76 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t210 = phi double [ %t76, %merge7 ], [ %t207, %loop.latch10 ]
  %t211 = phi { i8**, i64 }* [ %t74, %merge7 ], [ %t208, %loop.latch10 ]
  %t212 = phi { i8**, i64 }* [ %t75, %merge7 ], [ %t209, %loop.latch10 ]
  store double %t210, double* %l7
  store { i8**, i64 }* %t211, { i8**, i64 }** %l5
  store { i8**, i64 }* %t212, { i8**, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t77 = load double, double* %l7
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t79 = load { i8**, i64 }, { i8**, i64 }* %t78
  %t80 = extractvalue { i8**, i64 } %t79, 1
  %t81 = sitofp i64 %t80 to double
  %t82 = fcmp oge double %t77, %t81
  %t83 = load double, double* %l0
  %t84 = load double, double* %l1
  %t85 = load i8*, i8** %l2
  %t86 = load i8*, i8** %l3
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t90 = load double, double* %l7
  br i1 %t82, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t92 = load double, double* %l7
  %t93 = call double @llvm.round.f64(double %t92)
  %t94 = fptosi double %t93 to i64
  %t95 = load { i8**, i64 }, { i8**, i64 }* %t91
  %t96 = extractvalue { i8**, i64 } %t95, 0
  %t97 = extractvalue { i8**, i64 } %t95, 1
  %t98 = icmp uge i64 %t94, %t97
  ; bounds check: %t98 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t94, i64 %t97)
  %t99 = getelementptr i8*, i8** %t96, i64 %t94
  %t100 = load i8*, i8** %t99
  %t101 = call i8* @trim_text(i8* %t100)
  %t102 = call i8* @trim_trailing_delimiters(i8* %t101)
  store i8* %t102, i8** %l8
  %t103 = load i8*, i8** %l8
  %t104 = call i64 @sailfin_runtime_string_length(i8* %t103)
  %t105 = icmp eq i64 %t104, 0
  %t106 = load double, double* %l0
  %t107 = load double, double* %l1
  %t108 = load i8*, i8** %l2
  %t109 = load i8*, i8** %l3
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t113 = load double, double* %l7
  %t114 = load i8*, i8** %l8
  br i1 %t105, label %then14, label %merge15
then14:
  %t115 = load double, double* %l7
  %t116 = sitofp i64 1 to double
  %t117 = fadd double %t115, %t116
  store double %t117, double* %l7
  br label %loop.latch10
merge15:
  %t118 = load i8*, i8** %l8
  %t119 = alloca [2 x i8], align 1
  %t120 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 0
  store i8 58, i8* %t120
  %t121 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 1
  store i8 0, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t119, i32 0, i32 0
  %t123 = call double @index_of(i8* %t118, i8* %t122)
  store double %t123, double* %l9
  %t124 = load double, double* %l9
  %t125 = sitofp i64 0 to double
  %t126 = fcmp olt double %t124, %t125
  %t127 = load double, double* %l0
  %t128 = load double, double* %l1
  %t129 = load i8*, i8** %l2
  %t130 = load i8*, i8** %l3
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t134 = load double, double* %l7
  %t135 = load i8*, i8** %l8
  %t136 = load double, double* %l9
  br i1 %t126, label %then16, label %merge17
then16:
  %t137 = load double, double* %l7
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  store double %t139, double* %l7
  br label %loop.latch10
merge17:
  %t140 = load i8*, i8** %l8
  %t141 = load double, double* %l9
  %t142 = call double @llvm.round.f64(double %t141)
  %t143 = fptosi double %t142 to i64
  %t144 = call i8* @sailfin_runtime_substring(i8* %t140, i64 0, i64 %t143)
  %t145 = call i8* @trim_text(i8* %t144)
  store i8* %t145, i8** %l10
  %t146 = load i8*, i8** %l8
  %t147 = load double, double* %l9
  %t148 = sitofp i64 1 to double
  %t149 = fadd double %t147, %t148
  %t150 = load i8*, i8** %l8
  %t151 = call i64 @sailfin_runtime_string_length(i8* %t150)
  %t152 = call double @llvm.round.f64(double %t149)
  %t153 = fptosi double %t152 to i64
  %t154 = call i8* @sailfin_runtime_substring(i8* %t146, i64 %t153, i64 %t151)
  %t155 = call i8* @trim_text(i8* %t154)
  store i8* %t155, i8** %l11
  %t156 = load i8*, i8** %l10
  %t157 = call i64 @sailfin_runtime_string_length(i8* %t156)
  %t158 = icmp eq i64 %t157, 0
  %t159 = load double, double* %l0
  %t160 = load double, double* %l1
  %t161 = load i8*, i8** %l2
  %t162 = load i8*, i8** %l3
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t166 = load double, double* %l7
  %t167 = load i8*, i8** %l8
  %t168 = load double, double* %l9
  %t169 = load i8*, i8** %l10
  %t170 = load i8*, i8** %l11
  br i1 %t158, label %then18, label %merge19
then18:
  %t171 = load double, double* %l7
  %t172 = sitofp i64 1 to double
  %t173 = fadd double %t171, %t172
  store double %t173, double* %l7
  br label %loop.latch10
merge19:
  %t174 = load i8*, i8** %l11
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %depth, %t175
  %t177 = call i8* @lower_expression_with_depth(i8* %t174, double %t176)
  store i8* %t177, i8** %l12
  %t178 = load i8*, i8** %l10
  %t179 = call i8* @sanitize_identifier(i8* %t178)
  store i8* %t179, i8** %l13
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t181 = load i8*, i8** %l13
  %t182 = alloca [2 x i8], align 1
  %t183 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  store i8 61, i8* %t183
  %t184 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 1
  store i8 0, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t182, i32 0, i32 0
  %t186 = call i8* @sailfin_runtime_string_concat(i8* %t181, i8* %t185)
  %t187 = load i8*, i8** %l12
  %t188 = call i8* @sailfin_runtime_string_concat(i8* %t186, i8* %t187)
  %t189 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t180, i8* %t188)
  store { i8**, i64 }* %t189, { i8**, i64 }** %l5
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s191 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h728584192, i32 0, i32 0
  %t192 = load i8*, i8** %l13
  %t193 = call i8* @sailfin_runtime_string_concat(i8* %s191, i8* %t192)
  %s194 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t195 = call i8* @sailfin_runtime_string_concat(i8* %t193, i8* %s194)
  %t196 = load i8*, i8** %l12
  %t197 = call i8* @sailfin_runtime_string_concat(i8* %t195, i8* %t196)
  %t198 = alloca [2 x i8], align 1
  %t199 = getelementptr [2 x i8], [2 x i8]* %t198, i32 0, i32 0
  store i8 41, i8* %t199
  %t200 = getelementptr [2 x i8], [2 x i8]* %t198, i32 0, i32 1
  store i8 0, i8* %t200
  %t201 = getelementptr [2 x i8], [2 x i8]* %t198, i32 0, i32 0
  %t202 = call i8* @sailfin_runtime_string_concat(i8* %t197, i8* %t201)
  %t203 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t190, i8* %t202)
  store { i8**, i64 }* %t203, { i8**, i64 }** %l6
  %t204 = load double, double* %l7
  %t205 = sitofp i64 1 to double
  %t206 = fadd double %t204, %t205
  store double %t206, double* %l7
  br label %loop.latch10
loop.latch10:
  %t207 = load double, double* %l7
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t213 = load double, double* %l7
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t215 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t216 = load i8*, i8** %l2
  %t217 = call i8* @sanitize_qualified_identifier(i8* %t216)
  store i8* %t217, i8** %l14
  %t218 = sitofp i64 -1 to double
  store double %t218, double* %l15
  %t219 = sitofp i64 0 to double
  store double %t219, double* %l7
  %t220 = load double, double* %l0
  %t221 = load double, double* %l1
  %t222 = load i8*, i8** %l2
  %t223 = load i8*, i8** %l3
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t227 = load double, double* %l7
  %t228 = load i8*, i8** %l14
  %t229 = load double, double* %l15
  br label %loop.header20
loop.header20:
  %t268 = phi double [ %t229, %afterloop11 ], [ %t266, %loop.latch22 ]
  %t269 = phi double [ %t227, %afterloop11 ], [ %t267, %loop.latch22 ]
  store double %t268, double* %l15
  store double %t269, double* %l7
  br label %loop.body21
loop.body21:
  %t230 = load double, double* %l7
  %t231 = load i8*, i8** %l14
  %t232 = call i64 @sailfin_runtime_string_length(i8* %t231)
  %t233 = sitofp i64 %t232 to double
  %t234 = fcmp oge double %t230, %t233
  %t235 = load double, double* %l0
  %t236 = load double, double* %l1
  %t237 = load i8*, i8** %l2
  %t238 = load i8*, i8** %l3
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t242 = load double, double* %l7
  %t243 = load i8*, i8** %l14
  %t244 = load double, double* %l15
  br i1 %t234, label %then24, label %merge25
then24:
  br label %afterloop23
merge25:
  %t245 = load i8*, i8** %l14
  %t246 = load double, double* %l7
  %t247 = call i8* @char_at(i8* %t245, double %t246)
  %t248 = load i8, i8* %t247
  %t249 = icmp eq i8 %t248, 46
  %t250 = load double, double* %l0
  %t251 = load double, double* %l1
  %t252 = load i8*, i8** %l2
  %t253 = load i8*, i8** %l3
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t257 = load double, double* %l7
  %t258 = load i8*, i8** %l14
  %t259 = load double, double* %l15
  br i1 %t249, label %then26, label %merge27
then26:
  %t260 = load double, double* %l7
  store double %t260, double* %l15
  %t261 = load double, double* %l15
  br label %merge27
merge27:
  %t262 = phi double [ %t261, %then26 ], [ %t259, %merge25 ]
  store double %t262, double* %l15
  %t263 = load double, double* %l7
  %t264 = sitofp i64 1 to double
  %t265 = fadd double %t263, %t264
  store double %t265, double* %l7
  br label %loop.latch22
loop.latch22:
  %t266 = load double, double* %l15
  %t267 = load double, double* %l7
  br label %loop.header20
afterloop23:
  %t270 = load double, double* %l15
  %t271 = load double, double* %l7
  %t272 = load double, double* %l15
  %t273 = sitofp i64 0 to double
  %t274 = fcmp oge double %t272, %t273
  %t275 = load double, double* %l0
  %t276 = load double, double* %l1
  %t277 = load i8*, i8** %l2
  %t278 = load i8*, i8** %l3
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %t282 = load double, double* %l7
  %t283 = load i8*, i8** %l14
  %t284 = load double, double* %l15
  br i1 %t274, label %then28, label %merge29
then28:
  %t285 = load i8*, i8** %l14
  %t286 = load double, double* %l15
  %t287 = call double @llvm.round.f64(double %t286)
  %t288 = fptosi double %t287 to i64
  %t289 = call i8* @sailfin_runtime_substring(i8* %t285, i64 0, i64 %t288)
  store i8* %t289, i8** %l16
  %t290 = load i8*, i8** %l14
  %t291 = load double, double* %l15
  %t292 = sitofp i64 1 to double
  %t293 = fadd double %t291, %t292
  %t294 = load i8*, i8** %l14
  %t295 = call i64 @sailfin_runtime_string_length(i8* %t294)
  %t296 = call double @llvm.round.f64(double %t293)
  %t297 = fptosi double %t296 to i64
  %t298 = call i8* @sailfin_runtime_substring(i8* %t290, i64 %t297, i64 %t295)
  store i8* %t298, i8** %l17
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l6
  %s300 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t301 = call i8* @join_with_separator({ i8**, i64 }* %t299, i8* %s300)
  %t302 = alloca [2 x i8], align 1
  %t303 = getelementptr [2 x i8], [2 x i8]* %t302, i32 0, i32 0
  store i8 91, i8* %t303
  %t304 = getelementptr [2 x i8], [2 x i8]* %t302, i32 0, i32 1
  store i8 0, i8* %t304
  %t305 = getelementptr [2 x i8], [2 x i8]* %t302, i32 0, i32 0
  %t306 = call i8* @sailfin_runtime_string_concat(i8* %t305, i8* %t301)
  %t307 = alloca [2 x i8], align 1
  %t308 = getelementptr [2 x i8], [2 x i8]* %t307, i32 0, i32 0
  store i8 93, i8* %t308
  %t309 = getelementptr [2 x i8], [2 x i8]* %t307, i32 0, i32 1
  store i8 0, i8* %t309
  %t310 = getelementptr [2 x i8], [2 x i8]* %t307, i32 0, i32 0
  %t311 = call i8* @sailfin_runtime_string_concat(i8* %t306, i8* %t310)
  store i8* %t311, i8** %l18
  %s312 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h117462910, i32 0, i32 0
  %t313 = load i8*, i8** %l16
  %t314 = call i8* @sailfin_runtime_string_concat(i8* %s312, i8* %t313)
  %s315 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2088090973, i32 0, i32 0
  %t316 = call i8* @sailfin_runtime_string_concat(i8* %t314, i8* %s315)
  %t317 = load i8*, i8** %l17
  %t318 = call i8* @sailfin_runtime_string_concat(i8* %t316, i8* %t317)
  %s319 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087924125, i32 0, i32 0
  %t320 = call i8* @sailfin_runtime_string_concat(i8* %t318, i8* %s319)
  %t321 = load i8*, i8** %l18
  %t322 = call i8* @sailfin_runtime_string_concat(i8* %t320, i8* %t321)
  %t323 = alloca [2 x i8], align 1
  %t324 = getelementptr [2 x i8], [2 x i8]* %t323, i32 0, i32 0
  store i8 41, i8* %t324
  %t325 = getelementptr [2 x i8], [2 x i8]* %t323, i32 0, i32 1
  store i8 0, i8* %t325
  %t326 = getelementptr [2 x i8], [2 x i8]* %t323, i32 0, i32 0
  %t327 = call i8* @sailfin_runtime_string_concat(i8* %t322, i8* %t326)
  call void @sailfin_runtime_mark_persistent(i8* %t327)
  ret i8* %t327
merge29:
  %t328 = load i8*, i8** %l14
  %t329 = alloca [2 x i8], align 1
  %t330 = getelementptr [2 x i8], [2 x i8]* %t329, i32 0, i32 0
  store i8 40, i8* %t330
  %t331 = getelementptr [2 x i8], [2 x i8]* %t329, i32 0, i32 1
  store i8 0, i8* %t331
  %t332 = getelementptr [2 x i8], [2 x i8]* %t329, i32 0, i32 0
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %t328, i8* %t332)
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %s335 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t336 = call i8* @join_with_separator({ i8**, i64 }* %t334, i8* %s335)
  %t337 = call i8* @sailfin_runtime_string_concat(i8* %t333, i8* %t336)
  %t338 = alloca [2 x i8], align 1
  %t339 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 0
  store i8 41, i8* %t339
  %t340 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 1
  store i8 0, i8* %t340
  %t341 = getelementptr [2 x i8], [2 x i8]* %t338, i32 0, i32 0
  %t342 = call i8* @sailfin_runtime_string_concat(i8* %t337, i8* %t341)
  call void @sailfin_runtime_mark_persistent(i8* %t342)
  ret i8* %t342
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
  %t115 = alloca [2 x i8], align 1
  %t116 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  store i8 91, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 1
  store i8 0, i8* %t117
  %t118 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  %t119 = call i8* @sailfin_runtime_string_concat(i8* %t118, i8* %t114)
  %t120 = alloca [2 x i8], align 1
  %t121 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  store i8 93, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 1
  store i8 0, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  %t124 = call i8* @sailfin_runtime_string_concat(i8* %t119, i8* %t123)
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
  %t14 = alloca [2 x i8], align 1
  %t15 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  store i8 123, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 1
  store i8 0, i8* %t16
  %t17 = getelementptr [2 x i8], [2 x i8]* %t14, i32 0, i32 0
  %t18 = call double @find_substring_from(i8* %t12, i8* %t17, double %t13)
  store double %t18, double* %l2
  %t19 = load double, double* %l2
  %t20 = sitofp i64 0 to double
  %t21 = fcmp olt double %t19, %t20
  %t22 = load i8*, i8** %l0
  %t23 = load double, double* %l1
  %t24 = load double, double* %l2
  br i1 %t21, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t25 = load double, double* %l2
  store double %t25, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = load double, double* %l1
  %t28 = load double, double* %l2
  %t29 = load double, double* %l3
  br label %loop.header10
loop.header10:
  %t58 = phi double [ %t29, %merge9 ], [ %t57, %loop.latch12 ]
  store double %t58, double* %l3
  br label %loop.body11
loop.body11:
  %t30 = load double, double* %l3
  %t31 = sitofp i64 0 to double
  %t32 = fcmp ole double %t30, %t31
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l1
  %t35 = load double, double* %l2
  %t36 = load double, double* %l3
  br i1 %t32, label %then14, label %merge15
then14:
  br label %afterloop13
merge15:
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l3
  %t39 = sitofp i64 1 to double
  %t40 = fsub double %t38, %t39
  %t41 = load double, double* %l3
  %t42 = call double @llvm.round.f64(double %t40)
  %t43 = fptosi double %t42 to i64
  %t44 = call double @llvm.round.f64(double %t41)
  %t45 = fptosi double %t44 to i64
  %t46 = call i8* @sailfin_runtime_substring(i8* %t37, i64 %t43, i64 %t45)
  store i8* %t46, i8** %l4
  %t47 = load i8*, i8** %l4
  %t48 = call i1 @sailfin_runtime_is_whitespace_char(i8* %t47)
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
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 123, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  %t6 = call i1 @ends_with(i8* %t1, i8* %t5)
  %t7 = xor i1 %t6, 1
  %t8 = load i8*, i8** %l0
  br i1 %t7, label %then0, label %merge1
then0:
  %t9 = load i8*, i8** %l0
  %t10 = insertvalue %StructLiteralCapture undef, i8* %t9, 0
  %t11 = sitofp i64 0 to double
  %t12 = insertvalue %StructLiteralCapture %t10, double %t11, 1
  %t13 = insertvalue %StructLiteralCapture %t12, i1 0, 2
  ret %StructLiteralCapture %t13
merge1:
  %t14 = load i8*, i8** %l0
  store i8* %t14, i8** %l1
  store double %start_index, double* %l2
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l3
  %t16 = load i8*, i8** %l0
  %t17 = call double @compute_brace_balance(i8* %t16)
  store double %t17, double* %l4
  %t18 = load double, double* %l4
  %t19 = sitofp i64 0 to double
  %t20 = fcmp ole double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  %t24 = load double, double* %l3
  %t25 = load double, double* %l4
  br i1 %t20, label %then2, label %merge3
then2:
  %t26 = load i8*, i8** %l0
  %t27 = insertvalue %StructLiteralCapture undef, i8* %t26, 0
  %t28 = sitofp i64 0 to double
  %t29 = insertvalue %StructLiteralCapture %t27, double %t28, 1
  %t30 = insertvalue %StructLiteralCapture %t29, i1 0, 2
  ret %StructLiteralCapture %t30
merge3:
  %t31 = load i8*, i8** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load double, double* %l3
  %t35 = load double, double* %l4
  br label %loop.header4
loop.header4:
  %t172 = phi i8* [ %t32, %merge3 ], [ %t168, %loop.latch6 ]
  %t173 = phi double [ %t35, %merge3 ], [ %t169, %loop.latch6 ]
  %t174 = phi double [ %t34, %merge3 ], [ %t170, %loop.latch6 ]
  %t175 = phi double [ %t33, %merge3 ], [ %t171, %loop.latch6 ]
  store i8* %t172, i8** %l1
  store double %t173, double* %l4
  store double %t174, double* %l3
  store double %t175, double* %l2
  br label %loop.body5
loop.body5:
  %t36 = load double, double* %l2
  %t37 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t38 = extractvalue { %NativeInstruction*, i64 } %t37, 1
  %t39 = sitofp i64 %t38 to double
  %t40 = fcmp oge double %t36, %t39
  %t41 = load i8*, i8** %l0
  %t42 = load i8*, i8** %l1
  %t43 = load double, double* %l2
  %t44 = load double, double* %l3
  %t45 = load double, double* %l4
  br i1 %t40, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t46 = load double, double* %l2
  %t47 = call double @llvm.round.f64(double %t46)
  %t48 = fptosi double %t47 to i64
  %t49 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t50 = extractvalue { %NativeInstruction*, i64 } %t49, 0
  %t51 = extractvalue { %NativeInstruction*, i64 } %t49, 1
  %t52 = icmp uge i64 %t48, %t51
  ; bounds check: %t52 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t48, i64 %t51)
  %t53 = getelementptr %NativeInstruction, %NativeInstruction* %t50, i64 %t48
  %t54 = load %NativeInstruction, %NativeInstruction* %t53
  store %NativeInstruction %t54, %NativeInstruction* %l5
  %t55 = load %NativeInstruction, %NativeInstruction* %l5
  %t56 = extractvalue %NativeInstruction %t55, 0
  %t57 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t58 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t59 = icmp eq i32 %t56, 0
  %t60 = select i1 %t59, i8* %t58, i8* %t57
  %t61 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t62 = icmp eq i32 %t56, 1
  %t63 = select i1 %t62, i8* %t61, i8* %t60
  %t64 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t65 = icmp eq i32 %t56, 2
  %t66 = select i1 %t65, i8* %t64, i8* %t63
  %t67 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t68 = icmp eq i32 %t56, 3
  %t69 = select i1 %t68, i8* %t67, i8* %t66
  %t70 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t71 = icmp eq i32 %t56, 4
  %t72 = select i1 %t71, i8* %t70, i8* %t69
  %t73 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t74 = icmp eq i32 %t56, 5
  %t75 = select i1 %t74, i8* %t73, i8* %t72
  %t76 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t77 = icmp eq i32 %t56, 6
  %t78 = select i1 %t77, i8* %t76, i8* %t75
  %t79 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t80 = icmp eq i32 %t56, 7
  %t81 = select i1 %t80, i8* %t79, i8* %t78
  %t82 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t83 = icmp eq i32 %t56, 8
  %t84 = select i1 %t83, i8* %t82, i8* %t81
  %t85 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t86 = icmp eq i32 %t56, 9
  %t87 = select i1 %t86, i8* %t85, i8* %t84
  %t88 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t89 = icmp eq i32 %t56, 10
  %t90 = select i1 %t89, i8* %t88, i8* %t87
  %t91 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t92 = icmp eq i32 %t56, 11
  %t93 = select i1 %t92, i8* %t91, i8* %t90
  %t94 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t95 = icmp eq i32 %t56, 12
  %t96 = select i1 %t95, i8* %t94, i8* %t93
  %t97 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t98 = icmp eq i32 %t56, 13
  %t99 = select i1 %t98, i8* %t97, i8* %t96
  %t100 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t101 = icmp eq i32 %t56, 14
  %t102 = select i1 %t101, i8* %t100, i8* %t99
  %t103 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t104 = icmp eq i32 %t56, 15
  %t105 = select i1 %t104, i8* %t103, i8* %t102
  %t106 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t107 = icmp eq i32 %t56, 16
  %t108 = select i1 %t107, i8* %t106, i8* %t105
  %s109 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h48777630, i32 0, i32 0
  %t110 = call i1 @strings_equal(i8* %t108, i8* %s109)
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
  %t139 = alloca [2 x i8], align 1
  %t140 = getelementptr [2 x i8], [2 x i8]* %t139, i32 0, i32 0
  store i8 32, i8* %t140
  %t141 = getelementptr [2 x i8], [2 x i8]* %t139, i32 0, i32 1
  store i8 0, i8* %t141
  %t142 = getelementptr [2 x i8], [2 x i8]* %t139, i32 0, i32 0
  %t143 = call i8* @sailfin_runtime_string_concat(i8* %t138, i8* %t142)
  %t144 = load i8*, i8** %l6
  %t145 = call i8* @sailfin_runtime_string_concat(i8* %t143, i8* %t144)
  store i8* %t145, i8** %l1
  %t146 = load i8*, i8** %l1
  br label %merge13
merge13:
  %t147 = phi i8* [ %t146, %then12 ], [ %t132, %merge11 ]
  store i8* %t147, i8** %l1
  %t148 = load double, double* %l4
  %t149 = load i8*, i8** %l6
  %t150 = call double @compute_brace_balance(i8* %t149)
  %t151 = fadd double %t148, %t150
  store double %t151, double* %l4
  %t152 = load double, double* %l3
  %t153 = sitofp i64 1 to double
  %t154 = fadd double %t152, %t153
  store double %t154, double* %l3
  %t155 = load double, double* %l2
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l2
  %t158 = load double, double* %l4
  %t159 = sitofp i64 0 to double
  %t160 = fcmp ole double %t158, %t159
  %t161 = load i8*, i8** %l0
  %t162 = load i8*, i8** %l1
  %t163 = load double, double* %l2
  %t164 = load double, double* %l3
  %t165 = load double, double* %l4
  %t166 = load %NativeInstruction, %NativeInstruction* %l5
  %t167 = load i8*, i8** %l6
  br i1 %t160, label %then14, label %merge15
then14:
  br label %afterloop7
merge15:
  br label %loop.latch6
loop.latch6:
  %t168 = load i8*, i8** %l1
  %t169 = load double, double* %l4
  %t170 = load double, double* %l3
  %t171 = load double, double* %l2
  br label %loop.header4
afterloop7:
  %t176 = load i8*, i8** %l1
  %t177 = load double, double* %l4
  %t178 = load double, double* %l3
  %t179 = load double, double* %l2
  %t180 = load double, double* %l4
  %t181 = sitofp i64 0 to double
  %t182 = fcmp une double %t180, %t181
  %t183 = load i8*, i8** %l0
  %t184 = load i8*, i8** %l1
  %t185 = load double, double* %l2
  %t186 = load double, double* %l3
  %t187 = load double, double* %l4
  br i1 %t182, label %then16, label %merge17
then16:
  %t188 = load i8*, i8** %l0
  %t189 = insertvalue %StructLiteralCapture undef, i8* %t188, 0
  %t190 = sitofp i64 0 to double
  %t191 = insertvalue %StructLiteralCapture %t189, double %t190, 1
  %t192 = insertvalue %StructLiteralCapture %t191, i1 0, 2
  ret %StructLiteralCapture %t192
merge17:
  %t193 = load double, double* %l3
  %t194 = sitofp i64 0 to double
  %t195 = fcmp oeq double %t193, %t194
  %t196 = load i8*, i8** %l0
  %t197 = load i8*, i8** %l1
  %t198 = load double, double* %l2
  %t199 = load double, double* %l3
  %t200 = load double, double* %l4
  br i1 %t195, label %then18, label %merge19
then18:
  %t201 = load i8*, i8** %l0
  %t202 = insertvalue %StructLiteralCapture undef, i8* %t201, 0
  %t203 = sitofp i64 0 to double
  %t204 = insertvalue %StructLiteralCapture %t202, double %t203, 1
  %t205 = insertvalue %StructLiteralCapture %t204, i1 0, 2
  ret %StructLiteralCapture %t205
merge19:
  %t206 = load i8*, i8** %l1
  %t207 = call i8* @trim_text(i8* %t206)
  %t208 = call i8* @trim_trailing_delimiters(i8* %t207)
  store i8* %t208, i8** %l7
  %t209 = load i8*, i8** %l7
  %t210 = alloca [2 x i8], align 1
  %t211 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  store i8 125, i8* %t211
  %t212 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 1
  store i8 0, i8* %t212
  %t213 = getelementptr [2 x i8], [2 x i8]* %t210, i32 0, i32 0
  %t214 = call i1 @ends_with(i8* %t209, i8* %t213)
  %t215 = xor i1 %t214, 1
  %t216 = load i8*, i8** %l0
  %t217 = load i8*, i8** %l1
  %t218 = load double, double* %l2
  %t219 = load double, double* %l3
  %t220 = load double, double* %l4
  %t221 = load i8*, i8** %l7
  br i1 %t215, label %then20, label %merge21
then20:
  %t222 = load i8*, i8** %l0
  %t223 = insertvalue %StructLiteralCapture undef, i8* %t222, 0
  %t224 = sitofp i64 0 to double
  %t225 = insertvalue %StructLiteralCapture %t223, double %t224, 1
  %t226 = insertvalue %StructLiteralCapture %t225, i1 0, 2
  ret %StructLiteralCapture %t226
merge21:
  %t227 = load i8*, i8** %l7
  %t228 = insertvalue %StructLiteralCapture undef, i8* %t227, 0
  %t229 = load double, double* %l3
  %t230 = insertvalue %StructLiteralCapture %t228, double %t229, 1
  %t231 = insertvalue %StructLiteralCapture %t230, i1 1, 2
  ret %StructLiteralCapture %t231
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
  %t73 = phi i8* [ %t0, %block.entry ], [ %t72, %loop.latch2 ]
  store i8* %t73, i8** %l0
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
  %t53 = alloca [2 x i8], align 1
  %t54 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  store i8 40, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 1
  store i8 0, i8* %t55
  %t56 = getelementptr [2 x i8], [2 x i8]* %t53, i32 0, i32 0
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t52)
  %s58 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1776141546, i32 0, i32 0
  %t59 = call i8* @sailfin_runtime_string_concat(i8* %t57, i8* %s58)
  %t60 = load i8*, i8** %l8
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %t60)
  %t62 = alloca [2 x i8], align 1
  %t63 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  store i8 41, i8* %t63
  %t64 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 1
  store i8 0, i8* %t64
  %t65 = getelementptr [2 x i8], [2 x i8]* %t62, i32 0, i32 0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %t65)
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
  %t58 = phi i8* [ %t0, %block.entry ], [ %t57, %loop.latch2 ]
  store i8* %t58, i8** %l0
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
  %t50 = alloca [2 x i8], align 1
  %t51 = getelementptr [2 x i8], [2 x i8]* %t50, i32 0, i32 0
  store i8 41, i8* %t51
  %t52 = getelementptr [2 x i8], [2 x i8]* %t50, i32 0, i32 1
  store i8 0, i8* %t52
  %t53 = getelementptr [2 x i8], [2 x i8]* %t50, i32 0, i32 0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %t49, i8* %t53)
  %t55 = load i8*, i8** %l4
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %t55)
  store i8* %t56, i8** %l0
  br label %loop.latch2
loop.latch2:
  %t57 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t59 = load i8*, i8** %l0
  %t60 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t60)
  ret i8* %t60
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
  %t299 = phi double [ %t36, %logical_or_merge_18 ], [ %t292, %loop.latch4 ]
  %t300 = phi double [ %t37, %logical_or_merge_18 ], [ %t293, %loop.latch4 ]
  %t301 = phi i1 [ %t38, %logical_or_merge_18 ], [ %t294, %loop.latch4 ]
  %t302 = phi i8* [ %t35, %logical_or_merge_18 ], [ %t295, %loop.latch4 ]
  %t303 = phi double [ %t32, %logical_or_merge_18 ], [ %t296, %loop.latch4 ]
  %t304 = phi double [ %t33, %logical_or_merge_18 ], [ %t297, %loop.latch4 ]
  %t305 = phi double [ %t34, %logical_or_merge_18 ], [ %t298, %loop.latch4 ]
  store double %t299, double* %l5
  store double %t300, double* %l6
  store i1 %t301, i1* %l7
  store i8* %t302, i8** %l4
  store double %t303, double* %l1
  store double %t304, double* %l2
  store double %t305, double* %l3
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
  %t122 = alloca [2 x i8], align 1
  %t123 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 0
  store i8 32, i8* %t123
  %t124 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 1
  store i8 0, i8* %t124
  %t125 = getelementptr [2 x i8], [2 x i8]* %t122, i32 0, i32 0
  %t126 = call i8* @sailfin_runtime_string_concat(i8* %t121, i8* %t125)
  %t127 = load i8*, i8** %l9
  %t128 = call i8* @sailfin_runtime_string_concat(i8* %t126, i8* %t127)
  store i8* %t128, i8** %l4
  %t129 = load double, double* %l1
  %t130 = load i8*, i8** %l9
  %t131 = call double @compute_parenthesis_balance(i8* %t130)
  %t132 = fadd double %t129, %t131
  store double %t132, double* %l1
  %t133 = load double, double* %l2
  %t134 = load i8*, i8** %l9
  %t135 = call double @compute_brace_balance(i8* %t134)
  %t136 = fadd double %t133, %t135
  store double %t136, double* %l2
  %t137 = load double, double* %l3
  %t138 = load i8*, i8** %l9
  %t139 = call double @compute_bracket_balance(i8* %t138)
  %t140 = fadd double %t137, %t139
  store double %t140, double* %l3
  %t141 = load double, double* %l6
  %t142 = sitofp i64 1 to double
  %t143 = fadd double %t141, %t142
  store double %t143, double* %l6
  %t144 = load double, double* %l5
  %t145 = sitofp i64 1 to double
  %t146 = fadd double %t144, %t145
  store double %t146, double* %l5
  %t148 = load double, double* %l1
  %t149 = sitofp i64 0 to double
  %t150 = fcmp ole double %t148, %t149
  br label %logical_and_entry_147

logical_and_entry_147:
  br i1 %t150, label %logical_and_right_147, label %logical_and_merge_147

logical_and_right_147:
  %t152 = load double, double* %l2
  %t153 = sitofp i64 0 to double
  %t154 = fcmp ole double %t152, %t153
  br label %logical_and_entry_151

logical_and_entry_151:
  br i1 %t154, label %logical_and_right_151, label %logical_and_merge_151

logical_and_right_151:
  %t155 = load double, double* %l3
  %t156 = sitofp i64 0 to double
  %t157 = fcmp ole double %t155, %t156
  br label %logical_and_right_end_151

logical_and_right_end_151:
  br label %logical_and_merge_151

logical_and_merge_151:
  %t158 = phi i1 [ false, %logical_and_entry_151 ], [ %t157, %logical_and_right_end_151 ]
  br label %logical_and_right_end_147

logical_and_right_end_147:
  br label %logical_and_merge_147

logical_and_merge_147:
  %t159 = phi i1 [ false, %logical_and_entry_147 ], [ %t158, %logical_and_right_end_147 ]
  %t160 = load i8*, i8** %l0
  %t161 = load double, double* %l1
  %t162 = load double, double* %l2
  %t163 = load double, double* %l3
  %t164 = load i8*, i8** %l4
  %t165 = load double, double* %l5
  %t166 = load double, double* %l6
  %t167 = load i1, i1* %l7
  %t168 = load i8*, i8** %l8
  %t169 = load i8*, i8** %l9
  br i1 %t159, label %then16, label %merge17
then16:
  store i1 1, i1* %l10
  %t170 = load double, double* %l5
  store double %t170, double* %l11
  %t171 = load i8*, i8** %l0
  %t172 = load double, double* %l1
  %t173 = load double, double* %l2
  %t174 = load double, double* %l3
  %t175 = load i8*, i8** %l4
  %t176 = load double, double* %l5
  %t177 = load double, double* %l6
  %t178 = load i1, i1* %l7
  %t179 = load i8*, i8** %l8
  %t180 = load i8*, i8** %l9
  %t181 = load i1, i1* %l10
  %t182 = load double, double* %l11
  br label %loop.header18
loop.header18:
  %t267 = phi double [ %t182, %then16 ], [ %t265, %loop.latch20 ]
  %t268 = phi i1 [ %t181, %then16 ], [ %t266, %loop.latch20 ]
  store double %t267, double* %l11
  store i1 %t268, i1* %l10
  br label %loop.body19
loop.body19:
  %t183 = load double, double* %l11
  %t184 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t185 = extractvalue { %NativeInstruction*, i64 } %t184, 1
  %t186 = sitofp i64 %t185 to double
  %t187 = fcmp oge double %t183, %t186
  %t188 = load i8*, i8** %l0
  %t189 = load double, double* %l1
  %t190 = load double, double* %l2
  %t191 = load double, double* %l3
  %t192 = load i8*, i8** %l4
  %t193 = load double, double* %l5
  %t194 = load double, double* %l6
  %t195 = load i1, i1* %l7
  %t196 = load i8*, i8** %l8
  %t197 = load i8*, i8** %l9
  %t198 = load i1, i1* %l10
  %t199 = load double, double* %l11
  br i1 %t187, label %then22, label %merge23
then22:
  br label %afterloop21
merge23:
  %t200 = load double, double* %l11
  %t201 = call double @llvm.round.f64(double %t200)
  %t202 = fptosi double %t201 to i64
  %t203 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %instructions
  %t204 = extractvalue { %NativeInstruction*, i64 } %t203, 0
  %t205 = extractvalue { %NativeInstruction*, i64 } %t203, 1
  %t206 = icmp uge i64 %t202, %t205
  ; bounds check: %t206 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t202, i64 %t205)
  %t207 = getelementptr %NativeInstruction, %NativeInstruction* %t204, i64 %t202
  %t208 = load %NativeInstruction, %NativeInstruction* %t207
  %t209 = call i8* @continuation_segment_text(%NativeInstruction %t208)
  store i8* %t209, i8** %l12
  %t210 = load i8*, i8** %l12
  %t211 = icmp eq i8* %t210, null
  %t212 = load i8*, i8** %l0
  %t213 = load double, double* %l1
  %t214 = load double, double* %l2
  %t215 = load double, double* %l3
  %t216 = load i8*, i8** %l4
  %t217 = load double, double* %l5
  %t218 = load double, double* %l6
  %t219 = load i1, i1* %l7
  %t220 = load i8*, i8** %l8
  %t221 = load i8*, i8** %l9
  %t222 = load i1, i1* %l10
  %t223 = load double, double* %l11
  %t224 = load i8*, i8** %l12
  br i1 %t211, label %then24, label %merge25
then24:
  br label %afterloop21
merge25:
  %t225 = load i8*, i8** %l12
  %t226 = call i8* @trim_text(i8* %t225)
  store i8* %t226, i8** %l13
  %t227 = load i8*, i8** %l13
  %t228 = call i64 @sailfin_runtime_string_length(i8* %t227)
  %t229 = icmp eq i64 %t228, 0
  %t230 = load i8*, i8** %l0
  %t231 = load double, double* %l1
  %t232 = load double, double* %l2
  %t233 = load double, double* %l3
  %t234 = load i8*, i8** %l4
  %t235 = load double, double* %l5
  %t236 = load double, double* %l6
  %t237 = load i1, i1* %l7
  %t238 = load i8*, i8** %l8
  %t239 = load i8*, i8** %l9
  %t240 = load i1, i1* %l10
  %t241 = load double, double* %l11
  %t242 = load i8*, i8** %l12
  %t243 = load i8*, i8** %l13
  br i1 %t229, label %then26, label %merge27
then26:
  %t244 = load double, double* %l11
  %t245 = sitofp i64 1 to double
  %t246 = fadd double %t244, %t245
  store double %t246, double* %l11
  br label %loop.latch20
merge27:
  %t247 = load i8*, i8** %l13
  %t248 = call i1 @segment_signals_expression_continuation(i8* %t247)
  %t249 = load i8*, i8** %l0
  %t250 = load double, double* %l1
  %t251 = load double, double* %l2
  %t252 = load double, double* %l3
  %t253 = load i8*, i8** %l4
  %t254 = load double, double* %l5
  %t255 = load double, double* %l6
  %t256 = load i1, i1* %l7
  %t257 = load i8*, i8** %l8
  %t258 = load i8*, i8** %l9
  %t259 = load i1, i1* %l10
  %t260 = load double, double* %l11
  %t261 = load i8*, i8** %l12
  %t262 = load i8*, i8** %l13
  br i1 %t248, label %then28, label %merge29
then28:
  store i1 0, i1* %l10
  %t263 = load i1, i1* %l10
  br label %merge29
merge29:
  %t264 = phi i1 [ %t263, %then28 ], [ %t259, %merge27 ]
  store i1 %t264, i1* %l10
  br label %afterloop21
loop.latch20:
  %t265 = load double, double* %l11
  %t266 = load i1, i1* %l10
  br label %loop.header18
afterloop21:
  %t269 = load double, double* %l11
  %t270 = load i1, i1* %l10
  %t271 = load i1, i1* %l10
  %t272 = load i8*, i8** %l0
  %t273 = load double, double* %l1
  %t274 = load double, double* %l2
  %t275 = load double, double* %l3
  %t276 = load i8*, i8** %l4
  %t277 = load double, double* %l5
  %t278 = load double, double* %l6
  %t279 = load i1, i1* %l7
  %t280 = load i8*, i8** %l8
  %t281 = load i8*, i8** %l9
  %t282 = load i1, i1* %l10
  %t283 = load double, double* %l11
  br i1 %t271, label %then30, label %merge31
then30:
  %t284 = load i8*, i8** %l4
  %t285 = call i8* @trim_text(i8* %t284)
  %t286 = call i8* @trim_trailing_delimiters(i8* %t285)
  store i8* %t286, i8** %l14
  %t287 = load i8*, i8** %l14
  %t288 = insertvalue %ExpressionContinuationCapture undef, i8* %t287, 0
  %t289 = load double, double* %l6
  %t290 = insertvalue %ExpressionContinuationCapture %t288, double %t289, 1
  %t291 = insertvalue %ExpressionContinuationCapture %t290, i1 1, 2
  ret %ExpressionContinuationCapture %t291
merge31:
  br label %merge17
merge17:
  br label %loop.latch4
loop.latch4:
  %t292 = load double, double* %l5
  %t293 = load double, double* %l6
  %t294 = load i1, i1* %l7
  %t295 = load i8*, i8** %l4
  %t296 = load double, double* %l1
  %t297 = load double, double* %l2
  %t298 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t306 = load double, double* %l5
  %t307 = load double, double* %l6
  %t308 = load i1, i1* %l7
  %t309 = load i8*, i8** %l4
  %t310 = load double, double* %l1
  %t311 = load double, double* %l2
  %t312 = load double, double* %l3
  %t314 = load i1, i1* %l7
  br label %logical_or_entry_313

logical_or_entry_313:
  br i1 %t314, label %logical_or_merge_313, label %logical_or_right_313

logical_or_right_313:
  %t315 = load double, double* %l6
  %t316 = sitofp i64 0 to double
  %t317 = fcmp oeq double %t315, %t316
  br label %logical_or_right_end_313

logical_or_right_end_313:
  br label %logical_or_merge_313

logical_or_merge_313:
  %t318 = phi i1 [ true, %logical_or_entry_313 ], [ %t317, %logical_or_right_end_313 ]
  %t319 = xor i1 %t318, 1
  %t320 = load i8*, i8** %l0
  %t321 = load double, double* %l1
  %t322 = load double, double* %l2
  %t323 = load double, double* %l3
  %t324 = load i8*, i8** %l4
  %t325 = load double, double* %l5
  %t326 = load double, double* %l6
  %t327 = load i1, i1* %l7
  br i1 %t319, label %then32, label %merge33
then32:
  %t328 = load i8*, i8** %l0
  %t329 = insertvalue %ExpressionContinuationCapture undef, i8* %t328, 0
  %t330 = sitofp i64 0 to double
  %t331 = insertvalue %ExpressionContinuationCapture %t329, double %t330, 1
  %t332 = insertvalue %ExpressionContinuationCapture %t331, i1 0, 2
  ret %ExpressionContinuationCapture %t332
merge33:
  %t334 = load double, double* %l1
  %t335 = sitofp i64 0 to double
  %t336 = fcmp ole double %t334, %t335
  br label %logical_and_entry_333

logical_and_entry_333:
  br i1 %t336, label %logical_and_right_333, label %logical_and_merge_333

logical_and_right_333:
  %t338 = load double, double* %l2
  %t339 = sitofp i64 0 to double
  %t340 = fcmp ole double %t338, %t339
  br label %logical_and_entry_337

logical_and_entry_337:
  br i1 %t340, label %logical_and_right_337, label %logical_and_merge_337

logical_and_right_337:
  %t341 = load double, double* %l3
  %t342 = sitofp i64 0 to double
  %t343 = fcmp ole double %t341, %t342
  br label %logical_and_right_end_337

logical_and_right_end_337:
  br label %logical_and_merge_337

logical_and_merge_337:
  %t344 = phi i1 [ false, %logical_and_entry_337 ], [ %t343, %logical_and_right_end_337 ]
  br label %logical_and_right_end_333

logical_and_right_end_333:
  br label %logical_and_merge_333

logical_and_merge_333:
  %t345 = phi i1 [ false, %logical_and_entry_333 ], [ %t344, %logical_and_right_end_333 ]
  %t346 = load i8*, i8** %l0
  %t347 = load double, double* %l1
  %t348 = load double, double* %l2
  %t349 = load double, double* %l3
  %t350 = load i8*, i8** %l4
  %t351 = load double, double* %l5
  %t352 = load double, double* %l6
  %t353 = load i1, i1* %l7
  br i1 %t345, label %then34, label %merge35
then34:
  %t354 = load i8*, i8** %l4
  %t355 = call i8* @trim_text(i8* %t354)
  %t356 = call i8* @trim_trailing_delimiters(i8* %t355)
  store i8* %t356, i8** %l15
  %t357 = load i8*, i8** %l15
  %t358 = insertvalue %ExpressionContinuationCapture undef, i8* %t357, 0
  %t359 = load double, double* %l6
  %t360 = insertvalue %ExpressionContinuationCapture %t358, double %t359, 1
  %t361 = insertvalue %ExpressionContinuationCapture %t360, i1 1, 2
  ret %ExpressionContinuationCapture %t361
merge35:
  %t362 = load i8*, i8** %l0
  %t363 = insertvalue %ExpressionContinuationCapture undef, i8* %t362, 0
  %t364 = sitofp i64 0 to double
  %t365 = insertvalue %ExpressionContinuationCapture %t363, double %t364, 1
  %t366 = insertvalue %ExpressionContinuationCapture %t365, i1 0, 2
  ret %ExpressionContinuationCapture %t366
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
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 40, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = alloca [2 x i8], align 1
  %t5 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8 41, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 1
  store i8 0, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  %t8 = call double @compute_symbol_balance(i8* %text, i8* %t3, i8* %t7)
  ret double %t8
}

define double @compute_bracket_balance(i8* %text) {
block.entry:
  %t0 = alloca [2 x i8], align 1
  %t1 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  store i8 91, i8* %t1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 1
  store i8 0, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t0, i32 0, i32 0
  %t4 = alloca [2 x i8], align 1
  %t5 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  store i8 93, i8* %t5
  %t6 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 1
  store i8 0, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t4, i32 0, i32 0
  %t8 = call double @compute_symbol_balance(i8* %text, i8* %t3, i8* %t7)
  ret double %t8
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
  br label %logical_and_entry_19

logical_and_entry_19:
  br i1 %t20, label %logical_and_right_19, label %logical_and_merge_19

logical_and_right_19:
  %t21 = load double, double* %l0
  %t22 = call i1 @is_escaped_quote(i8* %text, double %t21)
  %t23 = xor i1 %t22, 1
  br label %logical_and_right_end_19

logical_and_right_end_19:
  br label %logical_and_merge_19

logical_and_merge_19:
  %t24 = phi i1 [ false, %logical_and_entry_19 ], [ %t23, %logical_and_right_end_19 ]
  %t25 = xor i1 %t24, 1
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
  br label %logical_and_entry_44

logical_and_entry_44:
  br i1 %t45, label %logical_and_right_44, label %logical_and_merge_44

logical_and_right_44:
  %t46 = load double, double* %l0
  %t47 = call i1 @is_escaped_quote(i8* %text, double %t46)
  %t48 = xor i1 %t47, 1
  br label %logical_and_right_end_44

logical_and_right_end_44:
  br label %logical_and_merge_44

logical_and_merge_44:
  %t49 = phi i1 [ false, %logical_and_entry_44 ], [ %t48, %logical_and_right_end_44 ]
  %t50 = xor i1 %t49, 1
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
  br label %logical_and_entry_62

logical_and_entry_62:
  br i1 %t63, label %logical_and_right_62, label %logical_and_merge_62

logical_and_right_62:
  %t64 = load i1, i1* %l2
  %t65 = xor i1 %t64, 1
  br label %logical_and_right_end_62

logical_and_right_end_62:
  br label %logical_and_merge_62

logical_and_merge_62:
  %t66 = phi i1 [ false, %logical_and_entry_62 ], [ %t65, %logical_and_right_end_62 ]
  %t67 = xor i1 %t66, 1
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
  br label %logical_and_entry_25

logical_and_entry_25:
  br i1 %t26, label %logical_and_right_25, label %logical_and_merge_25

logical_and_right_25:
  %t27 = load double, double* %l1
  %t28 = call i1 @is_escaped_quote(i8* %text, double %t27)
  %t29 = xor i1 %t28, 1
  br label %logical_and_right_end_25

logical_and_right_end_25:
  br label %logical_and_merge_25

logical_and_merge_25:
  %t30 = phi i1 [ false, %logical_and_entry_25 ], [ %t29, %logical_and_right_end_25 ]
  %t31 = xor i1 %t30, 1
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
  br label %logical_and_entry_51

logical_and_entry_51:
  br i1 %t52, label %logical_and_right_51, label %logical_and_merge_51

logical_and_right_51:
  %t53 = load double, double* %l1
  %t54 = call i1 @is_escaped_quote(i8* %text, double %t53)
  %t55 = xor i1 %t54, 1
  br label %logical_and_right_end_51

logical_and_right_end_51:
  br label %logical_and_merge_51

logical_and_merge_51:
  %t56 = phi i1 [ false, %logical_and_entry_51 ], [ %t55, %logical_and_right_end_51 ]
  %t57 = xor i1 %t56, 1
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
  br label %logical_and_entry_70

logical_and_entry_70:
  br i1 %t71, label %logical_and_right_70, label %logical_and_merge_70

logical_and_right_70:
  %t72 = load i1, i1* %l3
  %t73 = xor i1 %t72, 1
  br label %logical_and_right_end_70

logical_and_right_end_70:
  br label %logical_and_merge_70

logical_and_merge_70:
  %t74 = phi i1 [ false, %logical_and_entry_70 ], [ %t73, %logical_and_right_end_70 ]
  %t75 = xor i1 %t74, 1
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
  %t18 = alloca [2 x i8], align 1
  %t19 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  store i8 40, i8* %t19
  %t20 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 1
  store i8 0, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t18, i32 0, i32 0
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t17, i8* %t21)
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %s24 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t25 = call i8* @join_with_separator({ i8**, i64 }* %t23, i8* %s24)
  %t26 = call i8* @sailfin_runtime_string_concat(i8* %t22, i8* %t25)
  %s27 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193423562, i32 0, i32 0
  %t28 = call i8* @sailfin_runtime_string_concat(i8* %t26, i8* %s27)
  store i8* %t28, i8** %l3
  %t29 = load %PythonBuilder, %PythonBuilder* %l0
  %t30 = load i8*, i8** %l3
  %t31 = call %PythonBuilder @builder_emit(%PythonBuilder %t29, i8* %t30)
  store %PythonBuilder %t31, %PythonBuilder* %l0
  %t32 = load %PythonBuilder, %PythonBuilder* %l0
  %t33 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t32)
  store %PythonBuilder %t33, %PythonBuilder* %l0
  %t34 = extractvalue %NativeFunction %function, 3
  %t35 = load { i8**, i64 }, { i8**, i64 }* %t34
  %t36 = extractvalue { i8**, i64 } %t35, 1
  %t37 = icmp sgt i64 %t36, 0
  %t38 = load %PythonBuilder, %PythonBuilder* %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t41 = load i8*, i8** %l3
  br i1 %t37, label %then0, label %merge1
then0:
  %t42 = load %PythonBuilder, %PythonBuilder* %l0
  %s43 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1779553665, i32 0, i32 0
  %t44 = extractvalue %NativeFunction %function, 3
  %s45 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193425971, i32 0, i32 0
  %t46 = call i8* @join_with_separator({ i8**, i64 }* %t44, i8* %s45)
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %s43, i8* %t46)
  %t48 = call %PythonBuilder @builder_emit(%PythonBuilder %t42, i8* %t47)
  store %PythonBuilder %t48, %PythonBuilder* %l0
  %t49 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge1
merge1:
  %t50 = phi %PythonBuilder [ %t49, %then0 ], [ %t38, %block.entry ]
  store %PythonBuilder %t50, %PythonBuilder* %l0
  %t51 = extractvalue %NativeFunction %function, 4
  %t52 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t51
  %t53 = extractvalue { %NativeInstruction*, i64 } %t52, 1
  %t54 = icmp eq i64 %t53, 0
  %t55 = load %PythonBuilder, %PythonBuilder* %l0
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t58 = load i8*, i8** %l3
  br i1 %t54, label %then2, label %merge3
then2:
  %t59 = load %PythonBuilder, %PythonBuilder* %l0
  %s60 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t61 = call %PythonBuilder @builder_emit(%PythonBuilder %t59, i8* %s60)
  store %PythonBuilder %t61, %PythonBuilder* %l0
  %t62 = load %PythonBuilder, %PythonBuilder* %l0
  %t63 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t62)
  store %PythonBuilder %t63, %PythonBuilder* %l0
  %t64 = load %PythonBuilder, %PythonBuilder* %l0
  %t65 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t64, 0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = insertvalue %PythonFunctionEmission %t65, { i8**, i64 }* %t66, 1
  ret %PythonFunctionEmission %t67
merge3:
  %t68 = sitofp i64 0 to double
  store double %t68, double* %l4
  %t69 = getelementptr [0 x %MatchContext], [0 x %MatchContext]* null, i32 1
  %t70 = ptrtoint [0 x %MatchContext]* %t69 to i64
  %t71 = icmp eq i64 %t70, 0
  %t72 = select i1 %t71, i64 1, i64 %t70
  %t73 = call i8* @malloc(i64 %t72)
  %t74 = bitcast i8* %t73 to %MatchContext*
  %t75 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* null, i32 1
  %t76 = ptrtoint { %MatchContext*, i64 }* %t75 to i64
  %t77 = call i8* @malloc(i64 %t76)
  %t78 = bitcast i8* %t77 to { %MatchContext*, i64 }*
  %t79 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t78, i32 0, i32 0
  store %MatchContext* %t74, %MatchContext** %t79
  %t80 = getelementptr { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t78, i32 0, i32 1
  store i64 0, i64* %t80
  store { %MatchContext*, i64 }* %t78, { %MatchContext*, i64 }** %l5
  %t81 = sitofp i64 0 to double
  store double %t81, double* %l6
  %t82 = sitofp i64 0 to double
  store double %t82, double* %l7
  %t83 = load %PythonBuilder, %PythonBuilder* %l0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = load i8*, i8** %l3
  %t87 = load double, double* %l4
  %t88 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t89 = load double, double* %l6
  %t90 = load double, double* %l7
  br label %loop.header4
loop.header4:
  %t2572 = phi %PythonBuilder [ %t83, %merge3 ], [ %t2566, %loop.latch6 ]
  %t2573 = phi double [ %t90, %merge3 ], [ %t2567, %loop.latch6 ]
  %t2574 = phi double [ %t87, %merge3 ], [ %t2568, %loop.latch6 ]
  %t2575 = phi { i8**, i64 }* [ %t84, %merge3 ], [ %t2569, %loop.latch6 ]
  %t2576 = phi double [ %t89, %merge3 ], [ %t2570, %loop.latch6 ]
  %t2577 = phi { %MatchContext*, i64 }* [ %t88, %merge3 ], [ %t2571, %loop.latch6 ]
  store %PythonBuilder %t2572, %PythonBuilder* %l0
  store double %t2573, double* %l7
  store double %t2574, double* %l4
  store { i8**, i64 }* %t2575, { i8**, i64 }** %l1
  store double %t2576, double* %l6
  store { %MatchContext*, i64 }* %t2577, { %MatchContext*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t91 = load double, double* %l7
  %t92 = extractvalue %NativeFunction %function, 4
  %t93 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t92
  %t94 = extractvalue { %NativeInstruction*, i64 } %t93, 1
  %t95 = sitofp i64 %t94 to double
  %t96 = fcmp oge double %t91, %t95
  %t97 = load %PythonBuilder, %PythonBuilder* %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t100 = load i8*, i8** %l3
  %t101 = load double, double* %l4
  %t102 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t103 = load double, double* %l6
  %t104 = load double, double* %l7
  br i1 %t96, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t105 = extractvalue %NativeFunction %function, 4
  %t106 = load double, double* %l7
  %t107 = call double @llvm.round.f64(double %t106)
  %t108 = fptosi double %t107 to i64
  %t109 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t105
  %t110 = extractvalue { %NativeInstruction*, i64 } %t109, 0
  %t111 = extractvalue { %NativeInstruction*, i64 } %t109, 1
  %t112 = icmp uge i64 %t108, %t111
  ; bounds check: %t112 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t108, i64 %t111)
  %t113 = getelementptr %NativeInstruction, %NativeInstruction* %t110, i64 %t108
  %t114 = load %NativeInstruction, %NativeInstruction* %t113
  store %NativeInstruction %t114, %NativeInstruction* %l8
  %t115 = load %NativeInstruction, %NativeInstruction* %l8
  %t116 = extractvalue %NativeInstruction %t115, 0
  %t117 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t118 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t119 = icmp eq i32 %t116, 0
  %t120 = select i1 %t119, i8* %t118, i8* %t117
  %t121 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t122 = icmp eq i32 %t116, 1
  %t123 = select i1 %t122, i8* %t121, i8* %t120
  %t124 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t125 = icmp eq i32 %t116, 2
  %t126 = select i1 %t125, i8* %t124, i8* %t123
  %t127 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t128 = icmp eq i32 %t116, 3
  %t129 = select i1 %t128, i8* %t127, i8* %t126
  %t130 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t131 = icmp eq i32 %t116, 4
  %t132 = select i1 %t131, i8* %t130, i8* %t129
  %t133 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t134 = icmp eq i32 %t116, 5
  %t135 = select i1 %t134, i8* %t133, i8* %t132
  %t136 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t137 = icmp eq i32 %t116, 6
  %t138 = select i1 %t137, i8* %t136, i8* %t135
  %t139 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t140 = icmp eq i32 %t116, 7
  %t141 = select i1 %t140, i8* %t139, i8* %t138
  %t142 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t143 = icmp eq i32 %t116, 8
  %t144 = select i1 %t143, i8* %t142, i8* %t141
  %t145 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t146 = icmp eq i32 %t116, 9
  %t147 = select i1 %t146, i8* %t145, i8* %t144
  %t148 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t149 = icmp eq i32 %t116, 10
  %t150 = select i1 %t149, i8* %t148, i8* %t147
  %t151 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t152 = icmp eq i32 %t116, 11
  %t153 = select i1 %t152, i8* %t151, i8* %t150
  %t154 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t155 = icmp eq i32 %t116, 12
  %t156 = select i1 %t155, i8* %t154, i8* %t153
  %t157 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t158 = icmp eq i32 %t116, 13
  %t159 = select i1 %t158, i8* %t157, i8* %t156
  %t160 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t161 = icmp eq i32 %t116, 14
  %t162 = select i1 %t161, i8* %t160, i8* %t159
  %t163 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t164 = icmp eq i32 %t116, 15
  %t165 = select i1 %t164, i8* %t163, i8* %t162
  %t166 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t167 = icmp eq i32 %t116, 16
  %t168 = select i1 %t167, i8* %t166, i8* %t165
  %s169 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h536277508, i32 0, i32 0
  %t170 = call i1 @strings_equal(i8* %t168, i8* %s169)
  %t171 = load %PythonBuilder, %PythonBuilder* %l0
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t174 = load i8*, i8** %l3
  %t175 = load double, double* %l4
  %t176 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t177 = load double, double* %l6
  %t178 = load double, double* %l7
  %t179 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t170, label %then10, label %else11
then10:
  %t180 = load %NativeInstruction, %NativeInstruction* %l8
  %t181 = extractvalue %NativeInstruction %t180, 0
  %t182 = alloca %NativeInstruction
  store %NativeInstruction %t180, %NativeInstruction* %t182
  %t183 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t182, i32 0, i32 1
  %t184 = bitcast [16 x i8]* %t183 to i8*
  %t185 = bitcast i8* %t184 to i8**
  %t186 = load i8*, i8** %t185
  %t187 = icmp eq i32 %t181, 0
  %t188 = select i1 %t187, i8* %t186, i8* null
  %t189 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t182, i32 0, i32 1
  %t190 = bitcast [16 x i8]* %t189 to i8*
  %t191 = bitcast i8* %t190 to i8**
  %t192 = load i8*, i8** %t191
  %t193 = icmp eq i32 %t181, 1
  %t194 = select i1 %t193, i8* %t192, i8* %t188
  %t195 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t182, i32 0, i32 1
  %t196 = bitcast [8 x i8]* %t195 to i8*
  %t197 = bitcast i8* %t196 to i8**
  %t198 = load i8*, i8** %t197
  %t199 = icmp eq i32 %t181, 12
  %t200 = select i1 %t199, i8* %t198, i8* %t194
  %t201 = call i64 @sailfin_runtime_string_length(i8* %t200)
  %t202 = icmp eq i64 %t201, 0
  %t203 = load %PythonBuilder, %PythonBuilder* %l0
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t206 = load i8*, i8** %l3
  %t207 = load double, double* %l4
  %t208 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t209 = load double, double* %l6
  %t210 = load double, double* %l7
  %t211 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t202, label %then13, label %else14
then13:
  %t212 = load %PythonBuilder, %PythonBuilder* %l0
  %s213 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1061063223, i32 0, i32 0
  %t214 = call %PythonBuilder @builder_emit(%PythonBuilder %t212, i8* %s213)
  store %PythonBuilder %t214, %PythonBuilder* %l0
  %t215 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge15
else14:
  %t216 = load %NativeInstruction, %NativeInstruction* %l8
  %t217 = extractvalue %NativeInstruction %t216, 0
  %t218 = alloca %NativeInstruction
  store %NativeInstruction %t216, %NativeInstruction* %t218
  %t219 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t218, i32 0, i32 1
  %t220 = bitcast [16 x i8]* %t219 to i8*
  %t221 = bitcast i8* %t220 to i8**
  %t222 = load i8*, i8** %t221
  %t223 = icmp eq i32 %t217, 0
  %t224 = select i1 %t223, i8* %t222, i8* null
  %t225 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t218, i32 0, i32 1
  %t226 = bitcast [16 x i8]* %t225 to i8*
  %t227 = bitcast i8* %t226 to i8**
  %t228 = load i8*, i8** %t227
  %t229 = icmp eq i32 %t217, 1
  %t230 = select i1 %t229, i8* %t228, i8* %t224
  %t231 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t218, i32 0, i32 1
  %t232 = bitcast [8 x i8]* %t231 to i8*
  %t233 = bitcast i8* %t232 to i8**
  %t234 = load i8*, i8** %t233
  %t235 = icmp eq i32 %t217, 12
  %t236 = select i1 %t235, i8* %t234, i8* %t230
  store i8* %t236, i8** %l9
  %t237 = load i8*, i8** %l9
  %t238 = extractvalue %NativeFunction %function, 4
  %t239 = load double, double* %l7
  %t240 = sitofp i64 1 to double
  %t241 = fadd double %t239, %t240
  %t242 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t237, { %NativeInstruction*, i64 }* %t238, double %t241)
  store %StructLiteralCapture %t242, %StructLiteralCapture* %l10
  %t243 = sitofp i64 0 to double
  store double %t243, double* %l11
  %t244 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t245 = extractvalue %StructLiteralCapture %t244, 2
  %t246 = load %PythonBuilder, %PythonBuilder* %l0
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t249 = load i8*, i8** %l3
  %t250 = load double, double* %l4
  %t251 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t252 = load double, double* %l6
  %t253 = load double, double* %l7
  %t254 = load %NativeInstruction, %NativeInstruction* %l8
  %t255 = load i8*, i8** %l9
  %t256 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t257 = load double, double* %l11
  br i1 %t245, label %then16, label %else17
then16:
  %t258 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t259 = extractvalue %StructLiteralCapture %t258, 0
  store i8* %t259, i8** %l9
  %t260 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t261 = extractvalue %StructLiteralCapture %t260, 1
  store double %t261, double* %l11
  %t262 = load i8*, i8** %l9
  %t263 = load double, double* %l11
  br label %merge18
else17:
  %t264 = load i8*, i8** %l9
  %t265 = extractvalue %NativeFunction %function, 4
  %t266 = load double, double* %l7
  %t267 = sitofp i64 1 to double
  %t268 = fadd double %t266, %t267
  %t269 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t264, { %NativeInstruction*, i64 }* %t265, double %t268)
  store %ExpressionContinuationCapture %t269, %ExpressionContinuationCapture* %l12
  %t270 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t271 = extractvalue %ExpressionContinuationCapture %t270, 2
  %t272 = load %PythonBuilder, %PythonBuilder* %l0
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t275 = load i8*, i8** %l3
  %t276 = load double, double* %l4
  %t277 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t278 = load double, double* %l6
  %t279 = load double, double* %l7
  %t280 = load %NativeInstruction, %NativeInstruction* %l8
  %t281 = load i8*, i8** %l9
  %t282 = load %StructLiteralCapture, %StructLiteralCapture* %l10
  %t283 = load double, double* %l11
  %t284 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  br i1 %t271, label %then19, label %merge20
then19:
  %t285 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t286 = extractvalue %ExpressionContinuationCapture %t285, 0
  store i8* %t286, i8** %l9
  %t287 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l12
  %t288 = extractvalue %ExpressionContinuationCapture %t287, 1
  store double %t288, double* %l11
  %t289 = load i8*, i8** %l9
  %t290 = load double, double* %l11
  br label %merge20
merge20:
  %t291 = phi i8* [ %t289, %then19 ], [ %t281, %else17 ]
  %t292 = phi double [ %t290, %then19 ], [ %t283, %else17 ]
  store i8* %t291, i8** %l9
  store double %t292, double* %l11
  %t293 = load i8*, i8** %l9
  %t294 = load double, double* %l11
  br label %merge18
merge18:
  %t295 = phi i8* [ %t262, %then16 ], [ %t293, %merge20 ]
  %t296 = phi double [ %t263, %then16 ], [ %t294, %merge20 ]
  store i8* %t295, i8** %l9
  store double %t296, double* %l11
  %t297 = load %PythonBuilder, %PythonBuilder* %l0
  %s298 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t299 = load i8*, i8** %l9
  %t300 = call i8* @lower_expression(i8* %t299)
  %t301 = call i8* @sailfin_runtime_string_concat(i8* %s298, i8* %t300)
  %t302 = call %PythonBuilder @builder_emit(%PythonBuilder %t297, i8* %t301)
  store %PythonBuilder %t302, %PythonBuilder* %l0
  %t303 = load double, double* %l7
  %t304 = load double, double* %l11
  %t305 = fadd double %t303, %t304
  store double %t305, double* %l7
  %t306 = load %PythonBuilder, %PythonBuilder* %l0
  %t307 = load double, double* %l7
  br label %merge15
merge15:
  %t308 = phi %PythonBuilder [ %t215, %then13 ], [ %t306, %merge18 ]
  %t309 = phi double [ %t210, %then13 ], [ %t307, %merge18 ]
  store %PythonBuilder %t308, %PythonBuilder* %l0
  store double %t309, double* %l7
  %t310 = load %PythonBuilder, %PythonBuilder* %l0
  %t311 = load %PythonBuilder, %PythonBuilder* %l0
  %t312 = load double, double* %l7
  br label %merge12
else11:
  %t313 = load %NativeInstruction, %NativeInstruction* %l8
  %t314 = extractvalue %NativeInstruction %t313, 0
  %t315 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t316 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t317 = icmp eq i32 %t314, 0
  %t318 = select i1 %t317, i8* %t316, i8* %t315
  %t319 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t320 = icmp eq i32 %t314, 1
  %t321 = select i1 %t320, i8* %t319, i8* %t318
  %t322 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t323 = icmp eq i32 %t314, 2
  %t324 = select i1 %t323, i8* %t322, i8* %t321
  %t325 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t326 = icmp eq i32 %t314, 3
  %t327 = select i1 %t326, i8* %t325, i8* %t324
  %t328 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t329 = icmp eq i32 %t314, 4
  %t330 = select i1 %t329, i8* %t328, i8* %t327
  %t331 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t332 = icmp eq i32 %t314, 5
  %t333 = select i1 %t332, i8* %t331, i8* %t330
  %t334 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t335 = icmp eq i32 %t314, 6
  %t336 = select i1 %t335, i8* %t334, i8* %t333
  %t337 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t338 = icmp eq i32 %t314, 7
  %t339 = select i1 %t338, i8* %t337, i8* %t336
  %t340 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t341 = icmp eq i32 %t314, 8
  %t342 = select i1 %t341, i8* %t340, i8* %t339
  %t343 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t344 = icmp eq i32 %t314, 9
  %t345 = select i1 %t344, i8* %t343, i8* %t342
  %t346 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t347 = icmp eq i32 %t314, 10
  %t348 = select i1 %t347, i8* %t346, i8* %t345
  %t349 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t350 = icmp eq i32 %t314, 11
  %t351 = select i1 %t350, i8* %t349, i8* %t348
  %t352 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t353 = icmp eq i32 %t314, 12
  %t354 = select i1 %t353, i8* %t352, i8* %t351
  %t355 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t356 = icmp eq i32 %t314, 13
  %t357 = select i1 %t356, i8* %t355, i8* %t354
  %t358 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t359 = icmp eq i32 %t314, 14
  %t360 = select i1 %t359, i8* %t358, i8* %t357
  %t361 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t362 = icmp eq i32 %t314, 15
  %t363 = select i1 %t362, i8* %t361, i8* %t360
  %t364 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t365 = icmp eq i32 %t314, 16
  %t366 = select i1 %t365, i8* %t364, i8* %t363
  %s367 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1629914700, i32 0, i32 0
  %t368 = call i1 @strings_equal(i8* %t366, i8* %s367)
  %t369 = load %PythonBuilder, %PythonBuilder* %l0
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t372 = load i8*, i8** %l3
  %t373 = load double, double* %l4
  %t374 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t375 = load double, double* %l6
  %t376 = load double, double* %l7
  %t377 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t368, label %then21, label %else22
then21:
  %t378 = load %NativeInstruction, %NativeInstruction* %l8
  %t379 = extractvalue %NativeInstruction %t378, 0
  %t380 = alloca %NativeInstruction
  store %NativeInstruction %t378, %NativeInstruction* %t380
  %t381 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t380, i32 0, i32 1
  %t382 = bitcast [16 x i8]* %t381 to i8*
  %t383 = bitcast i8* %t382 to i8**
  %t384 = load i8*, i8** %t383
  %t385 = icmp eq i32 %t379, 0
  %t386 = select i1 %t385, i8* %t384, i8* null
  %t387 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t380, i32 0, i32 1
  %t388 = bitcast [16 x i8]* %t387 to i8*
  %t389 = bitcast i8* %t388 to i8**
  %t390 = load i8*, i8** %t389
  %t391 = icmp eq i32 %t379, 1
  %t392 = select i1 %t391, i8* %t390, i8* %t386
  %t393 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t380, i32 0, i32 1
  %t394 = bitcast [8 x i8]* %t393 to i8*
  %t395 = bitcast i8* %t394 to i8**
  %t396 = load i8*, i8** %t395
  %t397 = icmp eq i32 %t379, 12
  %t398 = select i1 %t397, i8* %t396, i8* %t392
  store i8* %t398, i8** %l13
  %t399 = load i8*, i8** %l13
  %t400 = extractvalue %NativeFunction %function, 4
  %t401 = load double, double* %l7
  %t402 = sitofp i64 1 to double
  %t403 = fadd double %t401, %t402
  %t404 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t399, { %NativeInstruction*, i64 }* %t400, double %t403)
  store %StructLiteralCapture %t404, %StructLiteralCapture* %l14
  %t405 = sitofp i64 0 to double
  store double %t405, double* %l15
  %t406 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t407 = extractvalue %StructLiteralCapture %t406, 2
  %t408 = load %PythonBuilder, %PythonBuilder* %l0
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t410 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t411 = load i8*, i8** %l3
  %t412 = load double, double* %l4
  %t413 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t414 = load double, double* %l6
  %t415 = load double, double* %l7
  %t416 = load %NativeInstruction, %NativeInstruction* %l8
  %t417 = load i8*, i8** %l13
  %t418 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t419 = load double, double* %l15
  br i1 %t407, label %then24, label %else25
then24:
  %t420 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t421 = extractvalue %StructLiteralCapture %t420, 0
  store i8* %t421, i8** %l13
  %t422 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t423 = extractvalue %StructLiteralCapture %t422, 1
  store double %t423, double* %l15
  %t424 = load i8*, i8** %l13
  %t425 = load double, double* %l15
  br label %merge26
else25:
  %t426 = load i8*, i8** %l13
  %t427 = extractvalue %NativeFunction %function, 4
  %t428 = load double, double* %l7
  %t429 = sitofp i64 1 to double
  %t430 = fadd double %t428, %t429
  %t431 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t426, { %NativeInstruction*, i64 }* %t427, double %t430)
  store %ExpressionContinuationCapture %t431, %ExpressionContinuationCapture* %l16
  %t432 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t433 = extractvalue %ExpressionContinuationCapture %t432, 2
  %t434 = load %PythonBuilder, %PythonBuilder* %l0
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t436 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t437 = load i8*, i8** %l3
  %t438 = load double, double* %l4
  %t439 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t440 = load double, double* %l6
  %t441 = load double, double* %l7
  %t442 = load %NativeInstruction, %NativeInstruction* %l8
  %t443 = load i8*, i8** %l13
  %t444 = load %StructLiteralCapture, %StructLiteralCapture* %l14
  %t445 = load double, double* %l15
  %t446 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  br i1 %t433, label %then27, label %merge28
then27:
  %t447 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t448 = extractvalue %ExpressionContinuationCapture %t447, 0
  store i8* %t448, i8** %l13
  %t449 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l16
  %t450 = extractvalue %ExpressionContinuationCapture %t449, 1
  store double %t450, double* %l15
  %t451 = load i8*, i8** %l13
  %t452 = load double, double* %l15
  br label %merge28
merge28:
  %t453 = phi i8* [ %t451, %then27 ], [ %t443, %else25 ]
  %t454 = phi double [ %t452, %then27 ], [ %t445, %else25 ]
  store i8* %t453, i8** %l13
  store double %t454, double* %l15
  %t455 = load i8*, i8** %l13
  %t456 = load double, double* %l15
  br label %merge26
merge26:
  %t457 = phi i8* [ %t424, %then24 ], [ %t455, %merge28 ]
  %t458 = phi double [ %t425, %then24 ], [ %t456, %merge28 ]
  store i8* %t457, i8** %l13
  store double %t458, double* %l15
  %t459 = load %PythonBuilder, %PythonBuilder* %l0
  %t460 = load i8*, i8** %l13
  %t461 = call i8* @lower_expression(i8* %t460)
  %t462 = call %PythonBuilder @builder_emit(%PythonBuilder %t459, i8* %t461)
  store %PythonBuilder %t462, %PythonBuilder* %l0
  %t463 = load double, double* %l7
  %t464 = load double, double* %l15
  %t465 = fadd double %t463, %t464
  store double %t465, double* %l7
  %t466 = load %PythonBuilder, %PythonBuilder* %l0
  %t467 = load double, double* %l7
  br label %merge23
else22:
  %t468 = load %NativeInstruction, %NativeInstruction* %l8
  %t469 = extractvalue %NativeInstruction %t468, 0
  %t470 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t471 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t472 = icmp eq i32 %t469, 0
  %t473 = select i1 %t472, i8* %t471, i8* %t470
  %t474 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t475 = icmp eq i32 %t469, 1
  %t476 = select i1 %t475, i8* %t474, i8* %t473
  %t477 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t478 = icmp eq i32 %t469, 2
  %t479 = select i1 %t478, i8* %t477, i8* %t476
  %t480 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t481 = icmp eq i32 %t469, 3
  %t482 = select i1 %t481, i8* %t480, i8* %t479
  %t483 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t484 = icmp eq i32 %t469, 4
  %t485 = select i1 %t484, i8* %t483, i8* %t482
  %t486 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t487 = icmp eq i32 %t469, 5
  %t488 = select i1 %t487, i8* %t486, i8* %t485
  %t489 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t490 = icmp eq i32 %t469, 6
  %t491 = select i1 %t490, i8* %t489, i8* %t488
  %t492 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t493 = icmp eq i32 %t469, 7
  %t494 = select i1 %t493, i8* %t492, i8* %t491
  %t495 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t496 = icmp eq i32 %t469, 8
  %t497 = select i1 %t496, i8* %t495, i8* %t494
  %t498 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t499 = icmp eq i32 %t469, 9
  %t500 = select i1 %t499, i8* %t498, i8* %t497
  %t501 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t502 = icmp eq i32 %t469, 10
  %t503 = select i1 %t502, i8* %t501, i8* %t500
  %t504 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t505 = icmp eq i32 %t469, 11
  %t506 = select i1 %t505, i8* %t504, i8* %t503
  %t507 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t508 = icmp eq i32 %t469, 12
  %t509 = select i1 %t508, i8* %t507, i8* %t506
  %t510 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t511 = icmp eq i32 %t469, 13
  %t512 = select i1 %t511, i8* %t510, i8* %t509
  %t513 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t514 = icmp eq i32 %t469, 14
  %t515 = select i1 %t514, i8* %t513, i8* %t512
  %t516 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t517 = icmp eq i32 %t469, 15
  %t518 = select i1 %t517, i8* %t516, i8* %t515
  %t519 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t520 = icmp eq i32 %t469, 16
  %t521 = select i1 %t520, i8* %t519, i8* %t518
  %s522 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t523 = call i1 @strings_equal(i8* %t521, i8* %s522)
  %t524 = load %PythonBuilder, %PythonBuilder* %l0
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t527 = load i8*, i8** %l3
  %t528 = load double, double* %l4
  %t529 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t530 = load double, double* %l6
  %t531 = load double, double* %l7
  %t532 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t523, label %then29, label %else30
then29:
  %t533 = load %NativeInstruction, %NativeInstruction* %l8
  %t534 = extractvalue %NativeInstruction %t533, 0
  %t535 = alloca %NativeInstruction
  store %NativeInstruction %t533, %NativeInstruction* %t535
  %t536 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t535, i32 0, i32 1
  %t537 = bitcast [48 x i8]* %t536 to i8*
  %t538 = bitcast i8* %t537 to i8**
  %t539 = load i8*, i8** %t538
  %t540 = icmp eq i32 %t534, 2
  %t541 = select i1 %t540, i8* %t539, i8* null
  %t542 = call i8* @sanitize_identifier(i8* %t541)
  store i8* %t542, i8** %l17
  %t543 = load i8*, i8** %l17
  %s544 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t545 = call i8* @sailfin_runtime_string_concat(i8* %t543, i8* %s544)
  store i8* %t545, i8** %l18
  %t546 = load %NativeInstruction, %NativeInstruction* %l8
  %t547 = extractvalue %NativeInstruction %t546, 0
  %t548 = alloca %NativeInstruction
  store %NativeInstruction %t546, %NativeInstruction* %t548
  %t549 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t548, i32 0, i32 1
  %t550 = bitcast [48 x i8]* %t549 to i8*
  %t551 = getelementptr inbounds i8, i8* %t550, i64 24
  %t552 = bitcast i8* %t551 to i8**
  %t553 = load i8*, i8** %t552
  %t554 = icmp eq i32 %t547, 2
  %t555 = select i1 %t554, i8* %t553, i8* null
  %t556 = icmp ne i8* %t555, null
  %t557 = load %PythonBuilder, %PythonBuilder* %l0
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t559 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t560 = load i8*, i8** %l3
  %t561 = load double, double* %l4
  %t562 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t563 = load double, double* %l6
  %t564 = load double, double* %l7
  %t565 = load %NativeInstruction, %NativeInstruction* %l8
  %t566 = load i8*, i8** %l17
  %t567 = load i8*, i8** %l18
  br i1 %t556, label %then32, label %else33
then32:
  %t568 = load %NativeInstruction, %NativeInstruction* %l8
  %t569 = extractvalue %NativeInstruction %t568, 0
  %t570 = alloca %NativeInstruction
  store %NativeInstruction %t568, %NativeInstruction* %t570
  %t571 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t570, i32 0, i32 1
  %t572 = bitcast [48 x i8]* %t571 to i8*
  %t573 = getelementptr inbounds i8, i8* %t572, i64 24
  %t574 = bitcast i8* %t573 to i8**
  %t575 = load i8*, i8** %t574
  %t576 = icmp eq i32 %t569, 2
  %t577 = select i1 %t576, i8* %t575, i8* null
  store i8* %t577, i8** %l19
  %t578 = load i8*, i8** %l19
  %t579 = extractvalue %NativeFunction %function, 4
  %t580 = load double, double* %l7
  %t581 = sitofp i64 1 to double
  %t582 = fadd double %t580, %t581
  %t583 = call %StructLiteralCapture @capture_struct_literal_expression(i8* %t578, { %NativeInstruction*, i64 }* %t579, double %t582)
  store %StructLiteralCapture %t583, %StructLiteralCapture* %l20
  %t584 = sitofp i64 0 to double
  store double %t584, double* %l21
  %t585 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t586 = extractvalue %StructLiteralCapture %t585, 2
  %t587 = load %PythonBuilder, %PythonBuilder* %l0
  %t588 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t589 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t590 = load i8*, i8** %l3
  %t591 = load double, double* %l4
  %t592 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t593 = load double, double* %l6
  %t594 = load double, double* %l7
  %t595 = load %NativeInstruction, %NativeInstruction* %l8
  %t596 = load i8*, i8** %l17
  %t597 = load i8*, i8** %l18
  %t598 = load i8*, i8** %l19
  %t599 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t600 = load double, double* %l21
  br i1 %t586, label %then35, label %else36
then35:
  %t601 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t602 = extractvalue %StructLiteralCapture %t601, 0
  store i8* %t602, i8** %l19
  %t603 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t604 = extractvalue %StructLiteralCapture %t603, 1
  store double %t604, double* %l21
  %t605 = load i8*, i8** %l19
  %t606 = load double, double* %l21
  br label %merge37
else36:
  %t607 = load i8*, i8** %l19
  %t608 = extractvalue %NativeFunction %function, 4
  %t609 = load double, double* %l7
  %t610 = sitofp i64 1 to double
  %t611 = fadd double %t609, %t610
  %t612 = call %ExpressionContinuationCapture @capture_expression_continuation(i8* %t607, { %NativeInstruction*, i64 }* %t608, double %t611)
  store %ExpressionContinuationCapture %t612, %ExpressionContinuationCapture* %l22
  %t613 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t614 = extractvalue %ExpressionContinuationCapture %t613, 2
  %t615 = load %PythonBuilder, %PythonBuilder* %l0
  %t616 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t618 = load i8*, i8** %l3
  %t619 = load double, double* %l4
  %t620 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t621 = load double, double* %l6
  %t622 = load double, double* %l7
  %t623 = load %NativeInstruction, %NativeInstruction* %l8
  %t624 = load i8*, i8** %l17
  %t625 = load i8*, i8** %l18
  %t626 = load i8*, i8** %l19
  %t627 = load %StructLiteralCapture, %StructLiteralCapture* %l20
  %t628 = load double, double* %l21
  %t629 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  br i1 %t614, label %then38, label %merge39
then38:
  %t630 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t631 = extractvalue %ExpressionContinuationCapture %t630, 0
  store i8* %t631, i8** %l19
  %t632 = load %ExpressionContinuationCapture, %ExpressionContinuationCapture* %l22
  %t633 = extractvalue %ExpressionContinuationCapture %t632, 1
  store double %t633, double* %l21
  %t634 = load i8*, i8** %l19
  %t635 = load double, double* %l21
  br label %merge39
merge39:
  %t636 = phi i8* [ %t634, %then38 ], [ %t626, %else36 ]
  %t637 = phi double [ %t635, %then38 ], [ %t628, %else36 ]
  store i8* %t636, i8** %l19
  store double %t637, double* %l21
  %t638 = load i8*, i8** %l19
  %t639 = load double, double* %l21
  br label %merge37
merge37:
  %t640 = phi i8* [ %t605, %then35 ], [ %t638, %merge39 ]
  %t641 = phi double [ %t606, %then35 ], [ %t639, %merge39 ]
  store i8* %t640, i8** %l19
  store double %t641, double* %l21
  %t642 = load i8*, i8** %l18
  %t643 = load i8*, i8** %l19
  %t644 = call i8* @lower_expression(i8* %t643)
  %t645 = call i8* @sailfin_runtime_string_concat(i8* %t642, i8* %t644)
  store i8* %t645, i8** %l18
  %t646 = load double, double* %l7
  %t647 = load double, double* %l21
  %t648 = fadd double %t646, %t647
  store double %t648, double* %l7
  %t649 = load i8*, i8** %l18
  %t650 = load double, double* %l7
  br label %merge34
else33:
  %t651 = load i8*, i8** %l18
  %s652 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230766299, i32 0, i32 0
  %t653 = call i8* @sailfin_runtime_string_concat(i8* %t651, i8* %s652)
  store i8* %t653, i8** %l18
  %t654 = load i8*, i8** %l18
  br label %merge34
merge34:
  %t655 = phi i8* [ %t649, %merge37 ], [ %t654, %else33 ]
  %t656 = phi double [ %t650, %merge37 ], [ %t564, %else33 ]
  store i8* %t655, i8** %l18
  store double %t656, double* %l7
  %t657 = load %PythonBuilder, %PythonBuilder* %l0
  %t658 = load i8*, i8** %l18
  %t659 = call %PythonBuilder @builder_emit(%PythonBuilder %t657, i8* %t658)
  store %PythonBuilder %t659, %PythonBuilder* %l0
  %t660 = load double, double* %l7
  %t661 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
else30:
  %t662 = load %NativeInstruction, %NativeInstruction* %l8
  %t663 = extractvalue %NativeInstruction %t662, 0
  %t664 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t665 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t666 = icmp eq i32 %t663, 0
  %t667 = select i1 %t666, i8* %t665, i8* %t664
  %t668 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t669 = icmp eq i32 %t663, 1
  %t670 = select i1 %t669, i8* %t668, i8* %t667
  %t671 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t672 = icmp eq i32 %t663, 2
  %t673 = select i1 %t672, i8* %t671, i8* %t670
  %t674 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t675 = icmp eq i32 %t663, 3
  %t676 = select i1 %t675, i8* %t674, i8* %t673
  %t677 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t678 = icmp eq i32 %t663, 4
  %t679 = select i1 %t678, i8* %t677, i8* %t676
  %t680 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t681 = icmp eq i32 %t663, 5
  %t682 = select i1 %t681, i8* %t680, i8* %t679
  %t683 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t684 = icmp eq i32 %t663, 6
  %t685 = select i1 %t684, i8* %t683, i8* %t682
  %t686 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t687 = icmp eq i32 %t663, 7
  %t688 = select i1 %t687, i8* %t686, i8* %t685
  %t689 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t690 = icmp eq i32 %t663, 8
  %t691 = select i1 %t690, i8* %t689, i8* %t688
  %t692 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t693 = icmp eq i32 %t663, 9
  %t694 = select i1 %t693, i8* %t692, i8* %t691
  %t695 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t696 = icmp eq i32 %t663, 10
  %t697 = select i1 %t696, i8* %t695, i8* %t694
  %t698 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t699 = icmp eq i32 %t663, 11
  %t700 = select i1 %t699, i8* %t698, i8* %t697
  %t701 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t702 = icmp eq i32 %t663, 12
  %t703 = select i1 %t702, i8* %t701, i8* %t700
  %t704 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t705 = icmp eq i32 %t663, 13
  %t706 = select i1 %t705, i8* %t704, i8* %t703
  %t707 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t708 = icmp eq i32 %t663, 14
  %t709 = select i1 %t708, i8* %t707, i8* %t706
  %t710 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t711 = icmp eq i32 %t663, 15
  %t712 = select i1 %t711, i8* %t710, i8* %t709
  %t713 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t714 = icmp eq i32 %t663, 16
  %t715 = select i1 %t714, i8* %t713, i8* %t712
  %s716 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193459862, i32 0, i32 0
  %t717 = call i1 @strings_equal(i8* %t715, i8* %s716)
  %t718 = load %PythonBuilder, %PythonBuilder* %l0
  %t719 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t720 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t721 = load i8*, i8** %l3
  %t722 = load double, double* %l4
  %t723 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t724 = load double, double* %l6
  %t725 = load double, double* %l7
  %t726 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t717, label %then40, label %else41
then40:
  %t727 = load %NativeInstruction, %NativeInstruction* %l8
  %t728 = extractvalue %NativeInstruction %t727, 0
  %t729 = alloca %NativeInstruction
  store %NativeInstruction %t727, %NativeInstruction* %t729
  %t730 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t729, i32 0, i32 1
  %t731 = bitcast [8 x i8]* %t730 to i8*
  %t732 = bitcast i8* %t731 to i8**
  %t733 = load i8*, i8** %t732
  %t734 = icmp eq i32 %t728, 3
  %t735 = select i1 %t734, i8* %t733, i8* null
  %t736 = call i8* @trim_text(i8* %t735)
  %t737 = call i8* @rewrite_expression_intrinsics(i8* %t736)
  store i8* %t737, i8** %l23
  %t738 = load %PythonBuilder, %PythonBuilder* %l0
  %s739 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t740 = load i8*, i8** %l23
  %t741 = call i8* @sailfin_runtime_string_concat(i8* %s739, i8* %t740)
  %t742 = alloca [2 x i8], align 1
  %t743 = getelementptr [2 x i8], [2 x i8]* %t742, i32 0, i32 0
  store i8 58, i8* %t743
  %t744 = getelementptr [2 x i8], [2 x i8]* %t742, i32 0, i32 1
  store i8 0, i8* %t744
  %t745 = getelementptr [2 x i8], [2 x i8]* %t742, i32 0, i32 0
  %t746 = call i8* @sailfin_runtime_string_concat(i8* %t741, i8* %t745)
  %t747 = call %PythonBuilder @builder_emit(%PythonBuilder %t738, i8* %t746)
  store %PythonBuilder %t747, %PythonBuilder* %l0
  %t748 = load %PythonBuilder, %PythonBuilder* %l0
  %t749 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t748)
  store %PythonBuilder %t749, %PythonBuilder* %l0
  %t750 = load double, double* %l4
  %t751 = sitofp i64 1 to double
  %t752 = fadd double %t750, %t751
  store double %t752, double* %l4
  %t753 = load %PythonBuilder, %PythonBuilder* %l0
  %t754 = load %PythonBuilder, %PythonBuilder* %l0
  %t755 = load double, double* %l4
  br label %merge42
else41:
  %t756 = load %NativeInstruction, %NativeInstruction* %l8
  %t757 = extractvalue %NativeInstruction %t756, 0
  %t758 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t759 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t760 = icmp eq i32 %t757, 0
  %t761 = select i1 %t760, i8* %t759, i8* %t758
  %t762 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t763 = icmp eq i32 %t757, 1
  %t764 = select i1 %t763, i8* %t762, i8* %t761
  %t765 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t766 = icmp eq i32 %t757, 2
  %t767 = select i1 %t766, i8* %t765, i8* %t764
  %t768 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t769 = icmp eq i32 %t757, 3
  %t770 = select i1 %t769, i8* %t768, i8* %t767
  %t771 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t772 = icmp eq i32 %t757, 4
  %t773 = select i1 %t772, i8* %t771, i8* %t770
  %t774 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t775 = icmp eq i32 %t757, 5
  %t776 = select i1 %t775, i8* %t774, i8* %t773
  %t777 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t778 = icmp eq i32 %t757, 6
  %t779 = select i1 %t778, i8* %t777, i8* %t776
  %t780 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t781 = icmp eq i32 %t757, 7
  %t782 = select i1 %t781, i8* %t780, i8* %t779
  %t783 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t784 = icmp eq i32 %t757, 8
  %t785 = select i1 %t784, i8* %t783, i8* %t782
  %t786 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t787 = icmp eq i32 %t757, 9
  %t788 = select i1 %t787, i8* %t786, i8* %t785
  %t789 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t790 = icmp eq i32 %t757, 10
  %t791 = select i1 %t790, i8* %t789, i8* %t788
  %t792 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t793 = icmp eq i32 %t757, 11
  %t794 = select i1 %t793, i8* %t792, i8* %t791
  %t795 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t796 = icmp eq i32 %t757, 12
  %t797 = select i1 %t796, i8* %t795, i8* %t794
  %t798 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t799 = icmp eq i32 %t757, 13
  %t800 = select i1 %t799, i8* %t798, i8* %t797
  %t801 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t802 = icmp eq i32 %t757, 14
  %t803 = select i1 %t802, i8* %t801, i8* %t800
  %t804 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t805 = icmp eq i32 %t757, 15
  %t806 = select i1 %t805, i8* %t804, i8* %t803
  %t807 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t808 = icmp eq i32 %t757, 16
  %t809 = select i1 %t808, i8* %t807, i8* %t806
  %s810 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h219990644, i32 0, i32 0
  %t811 = call i1 @strings_equal(i8* %t809, i8* %s810)
  %t812 = load %PythonBuilder, %PythonBuilder* %l0
  %t813 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t814 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t815 = load i8*, i8** %l3
  %t816 = load double, double* %l4
  %t817 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t818 = load double, double* %l6
  %t819 = load double, double* %l7
  %t820 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t811, label %then43, label %else44
then43:
  %t821 = load double, double* %l4
  %t822 = sitofp i64 0 to double
  %t823 = fcmp ogt double %t821, %t822
  %t824 = load %PythonBuilder, %PythonBuilder* %l0
  %t825 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t826 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t827 = load i8*, i8** %l3
  %t828 = load double, double* %l4
  %t829 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t830 = load double, double* %l6
  %t831 = load double, double* %l7
  %t832 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t823, label %then46, label %else47
then46:
  %t833 = load %PythonBuilder, %PythonBuilder* %l0
  %t834 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t833)
  store %PythonBuilder %t834, %PythonBuilder* %l0
  %t835 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge48
else47:
  %t836 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t837 = extractvalue %NativeFunction %function, 0
  %s838 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h2028465620, i32 0, i32 0
  %t839 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t836, i8* %t837, i8* %s838)
  store { i8**, i64 }* %t839, { i8**, i64 }** %l1
  %t840 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge48
merge48:
  %t841 = phi %PythonBuilder [ %t835, %then46 ], [ %t824, %else47 ]
  %t842 = phi { i8**, i64 }* [ %t825, %then46 ], [ %t840, %else47 ]
  store %PythonBuilder %t841, %PythonBuilder* %l0
  store { i8**, i64 }* %t842, { i8**, i64 }** %l1
  %t843 = load %PythonBuilder, %PythonBuilder* %l0
  %s844 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t845 = call %PythonBuilder @builder_emit(%PythonBuilder %t843, i8* %s844)
  store %PythonBuilder %t845, %PythonBuilder* %l0
  %t846 = load %PythonBuilder, %PythonBuilder* %l0
  %t847 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t846)
  store %PythonBuilder %t847, %PythonBuilder* %l0
  %t848 = load %PythonBuilder, %PythonBuilder* %l0
  %t849 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t850 = load %PythonBuilder, %PythonBuilder* %l0
  %t851 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
else44:
  %t852 = load %NativeInstruction, %NativeInstruction* %l8
  %t853 = extractvalue %NativeInstruction %t852, 0
  %t854 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t855 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t856 = icmp eq i32 %t853, 0
  %t857 = select i1 %t856, i8* %t855, i8* %t854
  %t858 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t859 = icmp eq i32 %t853, 1
  %t860 = select i1 %t859, i8* %t858, i8* %t857
  %t861 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t862 = icmp eq i32 %t853, 2
  %t863 = select i1 %t862, i8* %t861, i8* %t860
  %t864 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t865 = icmp eq i32 %t853, 3
  %t866 = select i1 %t865, i8* %t864, i8* %t863
  %t867 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t868 = icmp eq i32 %t853, 4
  %t869 = select i1 %t868, i8* %t867, i8* %t866
  %t870 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t871 = icmp eq i32 %t853, 5
  %t872 = select i1 %t871, i8* %t870, i8* %t869
  %t873 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t874 = icmp eq i32 %t853, 6
  %t875 = select i1 %t874, i8* %t873, i8* %t872
  %t876 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t877 = icmp eq i32 %t853, 7
  %t878 = select i1 %t877, i8* %t876, i8* %t875
  %t879 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t880 = icmp eq i32 %t853, 8
  %t881 = select i1 %t880, i8* %t879, i8* %t878
  %t882 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t883 = icmp eq i32 %t853, 9
  %t884 = select i1 %t883, i8* %t882, i8* %t881
  %t885 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t886 = icmp eq i32 %t853, 10
  %t887 = select i1 %t886, i8* %t885, i8* %t884
  %t888 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t889 = icmp eq i32 %t853, 11
  %t890 = select i1 %t889, i8* %t888, i8* %t887
  %t891 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t892 = icmp eq i32 %t853, 12
  %t893 = select i1 %t892, i8* %t891, i8* %t890
  %t894 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t895 = icmp eq i32 %t853, 13
  %t896 = select i1 %t895, i8* %t894, i8* %t893
  %t897 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t898 = icmp eq i32 %t853, 14
  %t899 = select i1 %t898, i8* %t897, i8* %t896
  %t900 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t901 = icmp eq i32 %t853, 15
  %t902 = select i1 %t901, i8* %t900, i8* %t899
  %t903 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t904 = icmp eq i32 %t853, 16
  %t905 = select i1 %t904, i8* %t903, i8* %t902
  %s906 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h819045845, i32 0, i32 0
  %t907 = call i1 @strings_equal(i8* %t905, i8* %s906)
  %t908 = load %PythonBuilder, %PythonBuilder* %l0
  %t909 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t910 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t911 = load i8*, i8** %l3
  %t912 = load double, double* %l4
  %t913 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t914 = load double, double* %l6
  %t915 = load double, double* %l7
  %t916 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t907, label %then49, label %else50
then49:
  %t917 = load double, double* %l4
  %t918 = sitofp i64 0 to double
  %t919 = fcmp ogt double %t917, %t918
  %t920 = load %PythonBuilder, %PythonBuilder* %l0
  %t921 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t922 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t923 = load i8*, i8** %l3
  %t924 = load double, double* %l4
  %t925 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t926 = load double, double* %l6
  %t927 = load double, double* %l7
  %t928 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t919, label %then52, label %else53
then52:
  %t929 = load %PythonBuilder, %PythonBuilder* %l0
  %t930 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t929)
  store %PythonBuilder %t930, %PythonBuilder* %l0
  %t931 = load double, double* %l4
  %t932 = sitofp i64 1 to double
  %t933 = fsub double %t931, %t932
  store double %t933, double* %l4
  %t934 = load %PythonBuilder, %PythonBuilder* %l0
  %t935 = load double, double* %l4
  br label %merge54
else53:
  %t936 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t937 = extractvalue %NativeFunction %function, 0
  %s938 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h458257002, i32 0, i32 0
  %t939 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t936, i8* %t937, i8* %s938)
  store { i8**, i64 }* %t939, { i8**, i64 }** %l1
  %t940 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge54
merge54:
  %t941 = phi %PythonBuilder [ %t934, %then52 ], [ %t920, %else53 ]
  %t942 = phi double [ %t935, %then52 ], [ %t924, %else53 ]
  %t943 = phi { i8**, i64 }* [ %t921, %then52 ], [ %t940, %else53 ]
  store %PythonBuilder %t941, %PythonBuilder* %l0
  store double %t942, double* %l4
  store { i8**, i64 }* %t943, { i8**, i64 }** %l1
  %t944 = load %PythonBuilder, %PythonBuilder* %l0
  %t945 = load double, double* %l4
  %t946 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge51
else50:
  %t947 = load %NativeInstruction, %NativeInstruction* %l8
  %t948 = extractvalue %NativeInstruction %t947, 0
  %t949 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t950 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t951 = icmp eq i32 %t948, 0
  %t952 = select i1 %t951, i8* %t950, i8* %t949
  %t953 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t954 = icmp eq i32 %t948, 1
  %t955 = select i1 %t954, i8* %t953, i8* %t952
  %t956 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t957 = icmp eq i32 %t948, 2
  %t958 = select i1 %t957, i8* %t956, i8* %t955
  %t959 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t960 = icmp eq i32 %t948, 3
  %t961 = select i1 %t960, i8* %t959, i8* %t958
  %t962 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t963 = icmp eq i32 %t948, 4
  %t964 = select i1 %t963, i8* %t962, i8* %t961
  %t965 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t966 = icmp eq i32 %t948, 5
  %t967 = select i1 %t966, i8* %t965, i8* %t964
  %t968 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t969 = icmp eq i32 %t948, 6
  %t970 = select i1 %t969, i8* %t968, i8* %t967
  %t971 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t972 = icmp eq i32 %t948, 7
  %t973 = select i1 %t972, i8* %t971, i8* %t970
  %t974 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t975 = icmp eq i32 %t948, 8
  %t976 = select i1 %t975, i8* %t974, i8* %t973
  %t977 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t978 = icmp eq i32 %t948, 9
  %t979 = select i1 %t978, i8* %t977, i8* %t976
  %t980 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t981 = icmp eq i32 %t948, 10
  %t982 = select i1 %t981, i8* %t980, i8* %t979
  %t983 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t984 = icmp eq i32 %t948, 11
  %t985 = select i1 %t984, i8* %t983, i8* %t982
  %t986 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t987 = icmp eq i32 %t948, 12
  %t988 = select i1 %t987, i8* %t986, i8* %t985
  %t989 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t990 = icmp eq i32 %t948, 13
  %t991 = select i1 %t990, i8* %t989, i8* %t988
  %t992 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t993 = icmp eq i32 %t948, 14
  %t994 = select i1 %t993, i8* %t992, i8* %t991
  %t995 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t996 = icmp eq i32 %t948, 15
  %t997 = select i1 %t996, i8* %t995, i8* %t994
  %t998 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t999 = icmp eq i32 %t948, 16
  %t1000 = select i1 %t999, i8* %t998, i8* %t997
  %s1001 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089113841, i32 0, i32 0
  %t1002 = call i1 @strings_equal(i8* %t1000, i8* %s1001)
  %t1003 = load %PythonBuilder, %PythonBuilder* %l0
  %t1004 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1005 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1006 = load i8*, i8** %l3
  %t1007 = load double, double* %l4
  %t1008 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1009 = load double, double* %l6
  %t1010 = load double, double* %l7
  %t1011 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1002, label %then55, label %else56
then55:
  %t1012 = load %NativeInstruction, %NativeInstruction* %l8
  %t1013 = extractvalue %NativeInstruction %t1012, 0
  %t1014 = alloca %NativeInstruction
  store %NativeInstruction %t1012, %NativeInstruction* %t1014
  %t1015 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1014, i32 0, i32 1
  %t1016 = bitcast [16 x i8]* %t1015 to i8*
  %t1017 = getelementptr inbounds i8, i8* %t1016, i64 8
  %t1018 = bitcast i8* %t1017 to i8**
  %t1019 = load i8*, i8** %t1018
  %t1020 = icmp eq i32 %t1013, 6
  %t1021 = select i1 %t1020, i8* %t1019, i8* null
  %t1022 = call i8* @trim_text(i8* %t1021)
  %t1023 = call i8* @rewrite_expression_intrinsics(i8* %t1022)
  store i8* %t1023, i8** %l24
  %t1024 = load %PythonBuilder, %PythonBuilder* %l0
  %s1025 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h259230482, i32 0, i32 0
  %t1026 = load %NativeInstruction, %NativeInstruction* %l8
  %t1027 = extractvalue %NativeInstruction %t1026, 0
  %t1028 = alloca %NativeInstruction
  store %NativeInstruction %t1026, %NativeInstruction* %t1028
  %t1029 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1028, i32 0, i32 1
  %t1030 = bitcast [16 x i8]* %t1029 to i8*
  %t1031 = bitcast i8* %t1030 to i8**
  %t1032 = load i8*, i8** %t1031
  %t1033 = icmp eq i32 %t1027, 6
  %t1034 = select i1 %t1033, i8* %t1032, i8* null
  %t1035 = call i8* @sailfin_runtime_string_concat(i8* %s1025, i8* %t1034)
  %s1036 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  %t1037 = call i8* @sailfin_runtime_string_concat(i8* %t1035, i8* %s1036)
  %t1038 = load i8*, i8** %l24
  %t1039 = call i8* @sailfin_runtime_string_concat(i8* %t1037, i8* %t1038)
  %t1040 = alloca [2 x i8], align 1
  %t1041 = getelementptr [2 x i8], [2 x i8]* %t1040, i32 0, i32 0
  store i8 58, i8* %t1041
  %t1042 = getelementptr [2 x i8], [2 x i8]* %t1040, i32 0, i32 1
  store i8 0, i8* %t1042
  %t1043 = getelementptr [2 x i8], [2 x i8]* %t1040, i32 0, i32 0
  %t1044 = call i8* @sailfin_runtime_string_concat(i8* %t1039, i8* %t1043)
  %t1045 = call %PythonBuilder @builder_emit(%PythonBuilder %t1024, i8* %t1044)
  store %PythonBuilder %t1045, %PythonBuilder* %l0
  %t1046 = load %PythonBuilder, %PythonBuilder* %l0
  %t1047 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1046)
  store %PythonBuilder %t1047, %PythonBuilder* %l0
  %t1048 = load double, double* %l4
  %t1049 = sitofp i64 1 to double
  %t1050 = fadd double %t1048, %t1049
  store double %t1050, double* %l4
  %t1051 = load %PythonBuilder, %PythonBuilder* %l0
  %t1052 = load %PythonBuilder, %PythonBuilder* %l0
  %t1053 = load double, double* %l4
  br label %merge57
else56:
  %t1054 = load %NativeInstruction, %NativeInstruction* %l8
  %t1055 = extractvalue %NativeInstruction %t1054, 0
  %t1056 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1057 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1058 = icmp eq i32 %t1055, 0
  %t1059 = select i1 %t1058, i8* %t1057, i8* %t1056
  %t1060 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1061 = icmp eq i32 %t1055, 1
  %t1062 = select i1 %t1061, i8* %t1060, i8* %t1059
  %t1063 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1064 = icmp eq i32 %t1055, 2
  %t1065 = select i1 %t1064, i8* %t1063, i8* %t1062
  %t1066 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1067 = icmp eq i32 %t1055, 3
  %t1068 = select i1 %t1067, i8* %t1066, i8* %t1065
  %t1069 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1070 = icmp eq i32 %t1055, 4
  %t1071 = select i1 %t1070, i8* %t1069, i8* %t1068
  %t1072 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1073 = icmp eq i32 %t1055, 5
  %t1074 = select i1 %t1073, i8* %t1072, i8* %t1071
  %t1075 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1076 = icmp eq i32 %t1055, 6
  %t1077 = select i1 %t1076, i8* %t1075, i8* %t1074
  %t1078 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1079 = icmp eq i32 %t1055, 7
  %t1080 = select i1 %t1079, i8* %t1078, i8* %t1077
  %t1081 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1082 = icmp eq i32 %t1055, 8
  %t1083 = select i1 %t1082, i8* %t1081, i8* %t1080
  %t1084 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1085 = icmp eq i32 %t1055, 9
  %t1086 = select i1 %t1085, i8* %t1084, i8* %t1083
  %t1087 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1088 = icmp eq i32 %t1055, 10
  %t1089 = select i1 %t1088, i8* %t1087, i8* %t1086
  %t1090 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1091 = icmp eq i32 %t1055, 11
  %t1092 = select i1 %t1091, i8* %t1090, i8* %t1089
  %t1093 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1094 = icmp eq i32 %t1055, 12
  %t1095 = select i1 %t1094, i8* %t1093, i8* %t1092
  %t1096 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1097 = icmp eq i32 %t1055, 13
  %t1098 = select i1 %t1097, i8* %t1096, i8* %t1095
  %t1099 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1100 = icmp eq i32 %t1055, 14
  %t1101 = select i1 %t1100, i8* %t1099, i8* %t1098
  %t1102 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1103 = icmp eq i32 %t1055, 15
  %t1104 = select i1 %t1103, i8* %t1102, i8* %t1101
  %t1105 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1106 = icmp eq i32 %t1055, 16
  %t1107 = select i1 %t1106, i8* %t1105, i8* %t1104
  %s1108 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1258614714, i32 0, i32 0
  %t1109 = call i1 @strings_equal(i8* %t1107, i8* %s1108)
  %t1110 = load %PythonBuilder, %PythonBuilder* %l0
  %t1111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1112 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1113 = load i8*, i8** %l3
  %t1114 = load double, double* %l4
  %t1115 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1116 = load double, double* %l6
  %t1117 = load double, double* %l7
  %t1118 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1109, label %then58, label %else59
then58:
  %t1119 = load double, double* %l4
  %t1120 = sitofp i64 0 to double
  %t1121 = fcmp ogt double %t1119, %t1120
  %t1122 = load %PythonBuilder, %PythonBuilder* %l0
  %t1123 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1124 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1125 = load i8*, i8** %l3
  %t1126 = load double, double* %l4
  %t1127 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1128 = load double, double* %l6
  %t1129 = load double, double* %l7
  %t1130 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1121, label %then61, label %else62
then61:
  %t1131 = load %PythonBuilder, %PythonBuilder* %l0
  %t1132 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1131)
  store %PythonBuilder %t1132, %PythonBuilder* %l0
  %t1133 = load double, double* %l4
  %t1134 = sitofp i64 1 to double
  %t1135 = fsub double %t1133, %t1134
  store double %t1135, double* %l4
  %t1136 = load %PythonBuilder, %PythonBuilder* %l0
  %t1137 = load double, double* %l4
  br label %merge63
else62:
  %t1138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1139 = extractvalue %NativeFunction %function, 0
  %s1140 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1370567591, i32 0, i32 0
  %t1141 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1138, i8* %t1139, i8* %s1140)
  store { i8**, i64 }* %t1141, { i8**, i64 }** %l1
  %t1142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge63
merge63:
  %t1143 = phi %PythonBuilder [ %t1136, %then61 ], [ %t1122, %else62 ]
  %t1144 = phi double [ %t1137, %then61 ], [ %t1126, %else62 ]
  %t1145 = phi { i8**, i64 }* [ %t1123, %then61 ], [ %t1142, %else62 ]
  store %PythonBuilder %t1143, %PythonBuilder* %l0
  store double %t1144, double* %l4
  store { i8**, i64 }* %t1145, { i8**, i64 }** %l1
  %t1146 = load %PythonBuilder, %PythonBuilder* %l0
  %t1147 = load double, double* %l4
  %t1148 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge60
else59:
  %t1149 = load %NativeInstruction, %NativeInstruction* %l8
  %t1150 = extractvalue %NativeInstruction %t1149, 0
  %t1151 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1152 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1153 = icmp eq i32 %t1150, 0
  %t1154 = select i1 %t1153, i8* %t1152, i8* %t1151
  %t1155 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1156 = icmp eq i32 %t1150, 1
  %t1157 = select i1 %t1156, i8* %t1155, i8* %t1154
  %t1158 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1159 = icmp eq i32 %t1150, 2
  %t1160 = select i1 %t1159, i8* %t1158, i8* %t1157
  %t1161 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1162 = icmp eq i32 %t1150, 3
  %t1163 = select i1 %t1162, i8* %t1161, i8* %t1160
  %t1164 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1165 = icmp eq i32 %t1150, 4
  %t1166 = select i1 %t1165, i8* %t1164, i8* %t1163
  %t1167 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1168 = icmp eq i32 %t1150, 5
  %t1169 = select i1 %t1168, i8* %t1167, i8* %t1166
  %t1170 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1171 = icmp eq i32 %t1150, 6
  %t1172 = select i1 %t1171, i8* %t1170, i8* %t1169
  %t1173 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1174 = icmp eq i32 %t1150, 7
  %t1175 = select i1 %t1174, i8* %t1173, i8* %t1172
  %t1176 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1177 = icmp eq i32 %t1150, 8
  %t1178 = select i1 %t1177, i8* %t1176, i8* %t1175
  %t1179 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1180 = icmp eq i32 %t1150, 9
  %t1181 = select i1 %t1180, i8* %t1179, i8* %t1178
  %t1182 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1183 = icmp eq i32 %t1150, 10
  %t1184 = select i1 %t1183, i8* %t1182, i8* %t1181
  %t1185 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1186 = icmp eq i32 %t1150, 11
  %t1187 = select i1 %t1186, i8* %t1185, i8* %t1184
  %t1188 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1189 = icmp eq i32 %t1150, 12
  %t1190 = select i1 %t1189, i8* %t1188, i8* %t1187
  %t1191 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1192 = icmp eq i32 %t1150, 13
  %t1193 = select i1 %t1192, i8* %t1191, i8* %t1190
  %t1194 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1195 = icmp eq i32 %t1150, 14
  %t1196 = select i1 %t1195, i8* %t1194, i8* %t1193
  %t1197 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1198 = icmp eq i32 %t1150, 15
  %t1199 = select i1 %t1198, i8* %t1197, i8* %t1196
  %t1200 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1201 = icmp eq i32 %t1150, 16
  %t1202 = select i1 %t1201, i8* %t1200, i8* %t1199
  %s1203 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h228395909, i32 0, i32 0
  %t1204 = call i1 @strings_equal(i8* %t1202, i8* %s1203)
  %t1205 = load %PythonBuilder, %PythonBuilder* %l0
  %t1206 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1207 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1208 = load i8*, i8** %l3
  %t1209 = load double, double* %l4
  %t1210 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1211 = load double, double* %l6
  %t1212 = load double, double* %l7
  %t1213 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1204, label %then64, label %else65
then64:
  %t1214 = load %PythonBuilder, %PythonBuilder* %l0
  %s1215 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1898426375, i32 0, i32 0
  %t1216 = call %PythonBuilder @builder_emit(%PythonBuilder %t1214, i8* %s1215)
  store %PythonBuilder %t1216, %PythonBuilder* %l0
  %t1217 = load %PythonBuilder, %PythonBuilder* %l0
  %t1218 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1217)
  store %PythonBuilder %t1218, %PythonBuilder* %l0
  %t1219 = load double, double* %l4
  %t1220 = sitofp i64 1 to double
  %t1221 = fadd double %t1219, %t1220
  store double %t1221, double* %l4
  %t1222 = load %PythonBuilder, %PythonBuilder* %l0
  %t1223 = load %PythonBuilder, %PythonBuilder* %l0
  %t1224 = load double, double* %l4
  br label %merge66
else65:
  %t1225 = load %NativeInstruction, %NativeInstruction* %l8
  %t1226 = extractvalue %NativeInstruction %t1225, 0
  %t1227 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1228 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1229 = icmp eq i32 %t1226, 0
  %t1230 = select i1 %t1229, i8* %t1228, i8* %t1227
  %t1231 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1232 = icmp eq i32 %t1226, 1
  %t1233 = select i1 %t1232, i8* %t1231, i8* %t1230
  %t1234 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1235 = icmp eq i32 %t1226, 2
  %t1236 = select i1 %t1235, i8* %t1234, i8* %t1233
  %t1237 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1238 = icmp eq i32 %t1226, 3
  %t1239 = select i1 %t1238, i8* %t1237, i8* %t1236
  %t1240 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1241 = icmp eq i32 %t1226, 4
  %t1242 = select i1 %t1241, i8* %t1240, i8* %t1239
  %t1243 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1244 = icmp eq i32 %t1226, 5
  %t1245 = select i1 %t1244, i8* %t1243, i8* %t1242
  %t1246 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1247 = icmp eq i32 %t1226, 6
  %t1248 = select i1 %t1247, i8* %t1246, i8* %t1245
  %t1249 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1250 = icmp eq i32 %t1226, 7
  %t1251 = select i1 %t1250, i8* %t1249, i8* %t1248
  %t1252 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1253 = icmp eq i32 %t1226, 8
  %t1254 = select i1 %t1253, i8* %t1252, i8* %t1251
  %t1255 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1256 = icmp eq i32 %t1226, 9
  %t1257 = select i1 %t1256, i8* %t1255, i8* %t1254
  %t1258 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1259 = icmp eq i32 %t1226, 10
  %t1260 = select i1 %t1259, i8* %t1258, i8* %t1257
  %t1261 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1262 = icmp eq i32 %t1226, 11
  %t1263 = select i1 %t1262, i8* %t1261, i8* %t1260
  %t1264 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1265 = icmp eq i32 %t1226, 12
  %t1266 = select i1 %t1265, i8* %t1264, i8* %t1263
  %t1267 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1268 = icmp eq i32 %t1226, 13
  %t1269 = select i1 %t1268, i8* %t1267, i8* %t1266
  %t1270 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1271 = icmp eq i32 %t1226, 14
  %t1272 = select i1 %t1271, i8* %t1270, i8* %t1269
  %t1273 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1274 = icmp eq i32 %t1226, 15
  %t1275 = select i1 %t1274, i8* %t1273, i8* %t1272
  %t1276 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1277 = icmp eq i32 %t1226, 16
  %t1278 = select i1 %t1277, i8* %t1276, i8* %t1275
  %s1279 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h739212033, i32 0, i32 0
  %t1280 = call i1 @strings_equal(i8* %t1278, i8* %s1279)
  %t1281 = load %PythonBuilder, %PythonBuilder* %l0
  %t1282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1283 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1284 = load i8*, i8** %l3
  %t1285 = load double, double* %l4
  %t1286 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1287 = load double, double* %l6
  %t1288 = load double, double* %l7
  %t1289 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1280, label %then67, label %else68
then67:
  %t1290 = load double, double* %l4
  %t1291 = sitofp i64 0 to double
  %t1292 = fcmp ogt double %t1290, %t1291
  %t1293 = load %PythonBuilder, %PythonBuilder* %l0
  %t1294 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1295 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1296 = load i8*, i8** %l3
  %t1297 = load double, double* %l4
  %t1298 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1299 = load double, double* %l6
  %t1300 = load double, double* %l7
  %t1301 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1292, label %then70, label %else71
then70:
  %t1302 = load %PythonBuilder, %PythonBuilder* %l0
  %t1303 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1302)
  store %PythonBuilder %t1303, %PythonBuilder* %l0
  %t1304 = load double, double* %l4
  %t1305 = sitofp i64 1 to double
  %t1306 = fsub double %t1304, %t1305
  store double %t1306, double* %l4
  %t1307 = load %PythonBuilder, %PythonBuilder* %l0
  %t1308 = load double, double* %l4
  br label %merge72
else71:
  %t1309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1310 = extractvalue %NativeFunction %function, 0
  %s1311 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1122035900, i32 0, i32 0
  %t1312 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1309, i8* %t1310, i8* %s1311)
  store { i8**, i64 }* %t1312, { i8**, i64 }** %l1
  %t1313 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge72
merge72:
  %t1314 = phi %PythonBuilder [ %t1307, %then70 ], [ %t1293, %else71 ]
  %t1315 = phi double [ %t1308, %then70 ], [ %t1297, %else71 ]
  %t1316 = phi { i8**, i64 }* [ %t1294, %then70 ], [ %t1313, %else71 ]
  store %PythonBuilder %t1314, %PythonBuilder* %l0
  store double %t1315, double* %l4
  store { i8**, i64 }* %t1316, { i8**, i64 }** %l1
  %t1317 = load %PythonBuilder, %PythonBuilder* %l0
  %t1318 = load double, double* %l4
  %t1319 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge69
else68:
  %t1320 = load %NativeInstruction, %NativeInstruction* %l8
  %t1321 = extractvalue %NativeInstruction %t1320, 0
  %t1322 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1323 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1321, 0
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1321, 1
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1321, 2
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1321, 3
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1321, 4
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1321, 5
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1321, 6
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1321, 7
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1321, 8
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1321, 9
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1321, 10
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %t1356 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1357 = icmp eq i32 %t1321, 11
  %t1358 = select i1 %t1357, i8* %t1356, i8* %t1355
  %t1359 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1360 = icmp eq i32 %t1321, 12
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1358
  %t1362 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1363 = icmp eq i32 %t1321, 13
  %t1364 = select i1 %t1363, i8* %t1362, i8* %t1361
  %t1365 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1366 = icmp eq i32 %t1321, 14
  %t1367 = select i1 %t1366, i8* %t1365, i8* %t1364
  %t1368 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1369 = icmp eq i32 %t1321, 15
  %t1370 = select i1 %t1369, i8* %t1368, i8* %t1367
  %t1371 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1372 = icmp eq i32 %t1321, 16
  %t1373 = select i1 %t1372, i8* %t1371, i8* %t1370
  %s1374 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h706445588, i32 0, i32 0
  %t1375 = call i1 @strings_equal(i8* %t1373, i8* %s1374)
  %t1376 = load %PythonBuilder, %PythonBuilder* %l0
  %t1377 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1378 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1379 = load i8*, i8** %l3
  %t1380 = load double, double* %l4
  %t1381 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1382 = load double, double* %l6
  %t1383 = load double, double* %l7
  %t1384 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1375, label %then73, label %else74
then73:
  %t1385 = load %PythonBuilder, %PythonBuilder* %l0
  %s1386 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t1387 = call %PythonBuilder @builder_emit(%PythonBuilder %t1385, i8* %s1386)
  store %PythonBuilder %t1387, %PythonBuilder* %l0
  %t1388 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
else74:
  %t1389 = load %NativeInstruction, %NativeInstruction* %l8
  %t1390 = extractvalue %NativeInstruction %t1389, 0
  %t1391 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1392 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1393 = icmp eq i32 %t1390, 0
  %t1394 = select i1 %t1393, i8* %t1392, i8* %t1391
  %t1395 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1396 = icmp eq i32 %t1390, 1
  %t1397 = select i1 %t1396, i8* %t1395, i8* %t1394
  %t1398 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1399 = icmp eq i32 %t1390, 2
  %t1400 = select i1 %t1399, i8* %t1398, i8* %t1397
  %t1401 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1402 = icmp eq i32 %t1390, 3
  %t1403 = select i1 %t1402, i8* %t1401, i8* %t1400
  %t1404 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1405 = icmp eq i32 %t1390, 4
  %t1406 = select i1 %t1405, i8* %t1404, i8* %t1403
  %t1407 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1408 = icmp eq i32 %t1390, 5
  %t1409 = select i1 %t1408, i8* %t1407, i8* %t1406
  %t1410 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1411 = icmp eq i32 %t1390, 6
  %t1412 = select i1 %t1411, i8* %t1410, i8* %t1409
  %t1413 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1414 = icmp eq i32 %t1390, 7
  %t1415 = select i1 %t1414, i8* %t1413, i8* %t1412
  %t1416 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1417 = icmp eq i32 %t1390, 8
  %t1418 = select i1 %t1417, i8* %t1416, i8* %t1415
  %t1419 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1420 = icmp eq i32 %t1390, 9
  %t1421 = select i1 %t1420, i8* %t1419, i8* %t1418
  %t1422 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1423 = icmp eq i32 %t1390, 10
  %t1424 = select i1 %t1423, i8* %t1422, i8* %t1421
  %t1425 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1426 = icmp eq i32 %t1390, 11
  %t1427 = select i1 %t1426, i8* %t1425, i8* %t1424
  %t1428 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1429 = icmp eq i32 %t1390, 12
  %t1430 = select i1 %t1429, i8* %t1428, i8* %t1427
  %t1431 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1432 = icmp eq i32 %t1390, 13
  %t1433 = select i1 %t1432, i8* %t1431, i8* %t1430
  %t1434 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1435 = icmp eq i32 %t1390, 14
  %t1436 = select i1 %t1435, i8* %t1434, i8* %t1433
  %t1437 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1438 = icmp eq i32 %t1390, 15
  %t1439 = select i1 %t1438, i8* %t1437, i8* %t1436
  %t1440 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1441 = icmp eq i32 %t1390, 16
  %t1442 = select i1 %t1441, i8* %t1440, i8* %t1439
  %s1443 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h267355070, i32 0, i32 0
  %t1444 = call i1 @strings_equal(i8* %t1442, i8* %s1443)
  %t1445 = load %PythonBuilder, %PythonBuilder* %l0
  %t1446 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1447 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1448 = load i8*, i8** %l3
  %t1449 = load double, double* %l4
  %t1450 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1451 = load double, double* %l6
  %t1452 = load double, double* %l7
  %t1453 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1444, label %then76, label %else77
then76:
  %t1454 = load %PythonBuilder, %PythonBuilder* %l0
  %s1455 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t1456 = call %PythonBuilder @builder_emit(%PythonBuilder %t1454, i8* %s1455)
  store %PythonBuilder %t1456, %PythonBuilder* %l0
  %t1457 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
else77:
  %t1458 = load %NativeInstruction, %NativeInstruction* %l8
  %t1459 = extractvalue %NativeInstruction %t1458, 0
  %t1460 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1461 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1462 = icmp eq i32 %t1459, 0
  %t1463 = select i1 %t1462, i8* %t1461, i8* %t1460
  %t1464 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1465 = icmp eq i32 %t1459, 1
  %t1466 = select i1 %t1465, i8* %t1464, i8* %t1463
  %t1467 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1468 = icmp eq i32 %t1459, 2
  %t1469 = select i1 %t1468, i8* %t1467, i8* %t1466
  %t1470 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1471 = icmp eq i32 %t1459, 3
  %t1472 = select i1 %t1471, i8* %t1470, i8* %t1469
  %t1473 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1474 = icmp eq i32 %t1459, 4
  %t1475 = select i1 %t1474, i8* %t1473, i8* %t1472
  %t1476 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1477 = icmp eq i32 %t1459, 5
  %t1478 = select i1 %t1477, i8* %t1476, i8* %t1475
  %t1479 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1480 = icmp eq i32 %t1459, 6
  %t1481 = select i1 %t1480, i8* %t1479, i8* %t1478
  %t1482 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1483 = icmp eq i32 %t1459, 7
  %t1484 = select i1 %t1483, i8* %t1482, i8* %t1481
  %t1485 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1486 = icmp eq i32 %t1459, 8
  %t1487 = select i1 %t1486, i8* %t1485, i8* %t1484
  %t1488 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1489 = icmp eq i32 %t1459, 9
  %t1490 = select i1 %t1489, i8* %t1488, i8* %t1487
  %t1491 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1492 = icmp eq i32 %t1459, 10
  %t1493 = select i1 %t1492, i8* %t1491, i8* %t1490
  %t1494 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1495 = icmp eq i32 %t1459, 11
  %t1496 = select i1 %t1495, i8* %t1494, i8* %t1493
  %t1497 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1498 = icmp eq i32 %t1459, 12
  %t1499 = select i1 %t1498, i8* %t1497, i8* %t1496
  %t1500 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1501 = icmp eq i32 %t1459, 13
  %t1502 = select i1 %t1501, i8* %t1500, i8* %t1499
  %t1503 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1504 = icmp eq i32 %t1459, 14
  %t1505 = select i1 %t1504, i8* %t1503, i8* %t1502
  %t1506 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1507 = icmp eq i32 %t1459, 15
  %t1508 = select i1 %t1507, i8* %t1506, i8* %t1505
  %t1509 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1510 = icmp eq i32 %t1459, 16
  %t1511 = select i1 %t1510, i8* %t1509, i8* %t1508
  %s1512 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1117315388, i32 0, i32 0
  %t1513 = call i1 @strings_equal(i8* %t1511, i8* %s1512)
  %t1514 = load %PythonBuilder, %PythonBuilder* %l0
  %t1515 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1516 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1517 = load i8*, i8** %l3
  %t1518 = load double, double* %l4
  %t1519 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1520 = load double, double* %l6
  %t1521 = load double, double* %l7
  %t1522 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1513, label %then79, label %else80
then79:
  %t1523 = load double, double* %l6
  %t1524 = call i8* @generate_match_subject_name(double %t1523)
  store i8* %t1524, i8** %l25
  %t1525 = load double, double* %l6
  %t1526 = sitofp i64 1 to double
  %t1527 = fadd double %t1525, %t1526
  store double %t1527, double* %l6
  %t1528 = load %NativeInstruction, %NativeInstruction* %l8
  %t1529 = extractvalue %NativeInstruction %t1528, 0
  %t1530 = alloca %NativeInstruction
  store %NativeInstruction %t1528, %NativeInstruction* %t1530
  %t1531 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1530, i32 0, i32 1
  %t1532 = bitcast [16 x i8]* %t1531 to i8*
  %t1533 = bitcast i8* %t1532 to i8**
  %t1534 = load i8*, i8** %t1533
  %t1535 = icmp eq i32 %t1529, 0
  %t1536 = select i1 %t1535, i8* %t1534, i8* null
  %t1537 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1530, i32 0, i32 1
  %t1538 = bitcast [16 x i8]* %t1537 to i8*
  %t1539 = bitcast i8* %t1538 to i8**
  %t1540 = load i8*, i8** %t1539
  %t1541 = icmp eq i32 %t1529, 1
  %t1542 = select i1 %t1541, i8* %t1540, i8* %t1536
  %t1543 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1530, i32 0, i32 1
  %t1544 = bitcast [8 x i8]* %t1543 to i8*
  %t1545 = bitcast i8* %t1544 to i8**
  %t1546 = load i8*, i8** %t1545
  %t1547 = icmp eq i32 %t1529, 12
  %t1548 = select i1 %t1547, i8* %t1546, i8* %t1542
  %t1549 = call i8* @lower_expression(i8* %t1548)
  store i8* %t1549, i8** %l26
  %t1550 = load %PythonBuilder, %PythonBuilder* %l0
  %t1551 = load i8*, i8** %l25
  %s1552 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2087691079, i32 0, i32 0
  %t1553 = call i8* @sailfin_runtime_string_concat(i8* %t1551, i8* %s1552)
  %t1554 = load i8*, i8** %l26
  %t1555 = call i8* @sailfin_runtime_string_concat(i8* %t1553, i8* %t1554)
  %t1556 = call %PythonBuilder @builder_emit(%PythonBuilder %t1550, i8* %t1555)
  store %PythonBuilder %t1556, %PythonBuilder* %l0
  %t1557 = load i8*, i8** %l25
  %t1558 = insertvalue %MatchContext undef, i8* %t1557, 0
  %t1559 = sitofp i64 0 to double
  %t1560 = insertvalue %MatchContext %t1558, double %t1559, 1
  %t1561 = insertvalue %MatchContext %t1560, i1 0, 2
  store %MatchContext %t1561, %MatchContext* %l27
  %t1562 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1563 = load %MatchContext, %MatchContext* %l27
  %t1564 = call { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %t1562, %MatchContext %t1563)
  store { %MatchContext*, i64 }* %t1564, { %MatchContext*, i64 }** %l5
  %t1565 = load double, double* %l6
  %t1566 = load %PythonBuilder, %PythonBuilder* %l0
  %t1567 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge81
else80:
  %t1568 = load %NativeInstruction, %NativeInstruction* %l8
  %t1569 = extractvalue %NativeInstruction %t1568, 0
  %t1570 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1571 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1572 = icmp eq i32 %t1569, 0
  %t1573 = select i1 %t1572, i8* %t1571, i8* %t1570
  %t1574 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1575 = icmp eq i32 %t1569, 1
  %t1576 = select i1 %t1575, i8* %t1574, i8* %t1573
  %t1577 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1578 = icmp eq i32 %t1569, 2
  %t1579 = select i1 %t1578, i8* %t1577, i8* %t1576
  %t1580 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1581 = icmp eq i32 %t1569, 3
  %t1582 = select i1 %t1581, i8* %t1580, i8* %t1579
  %t1583 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1584 = icmp eq i32 %t1569, 4
  %t1585 = select i1 %t1584, i8* %t1583, i8* %t1582
  %t1586 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1587 = icmp eq i32 %t1569, 5
  %t1588 = select i1 %t1587, i8* %t1586, i8* %t1585
  %t1589 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1590 = icmp eq i32 %t1569, 6
  %t1591 = select i1 %t1590, i8* %t1589, i8* %t1588
  %t1592 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1593 = icmp eq i32 %t1569, 7
  %t1594 = select i1 %t1593, i8* %t1592, i8* %t1591
  %t1595 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1596 = icmp eq i32 %t1569, 8
  %t1597 = select i1 %t1596, i8* %t1595, i8* %t1594
  %t1598 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1599 = icmp eq i32 %t1569, 9
  %t1600 = select i1 %t1599, i8* %t1598, i8* %t1597
  %t1601 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1602 = icmp eq i32 %t1569, 10
  %t1603 = select i1 %t1602, i8* %t1601, i8* %t1600
  %t1604 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1605 = icmp eq i32 %t1569, 11
  %t1606 = select i1 %t1605, i8* %t1604, i8* %t1603
  %t1607 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1608 = icmp eq i32 %t1569, 12
  %t1609 = select i1 %t1608, i8* %t1607, i8* %t1606
  %t1610 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1611 = icmp eq i32 %t1569, 13
  %t1612 = select i1 %t1611, i8* %t1610, i8* %t1609
  %t1613 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1614 = icmp eq i32 %t1569, 14
  %t1615 = select i1 %t1614, i8* %t1613, i8* %t1612
  %t1616 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1617 = icmp eq i32 %t1569, 15
  %t1618 = select i1 %t1617, i8* %t1616, i8* %t1615
  %t1619 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1620 = icmp eq i32 %t1569, 16
  %t1621 = select i1 %t1620, i8* %t1619, i8* %t1618
  %s1622 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h217223495, i32 0, i32 0
  %t1623 = call i1 @strings_equal(i8* %t1621, i8* %s1622)
  %t1624 = load %PythonBuilder, %PythonBuilder* %l0
  %t1625 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1626 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1627 = load i8*, i8** %l3
  %t1628 = load double, double* %l4
  %t1629 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1630 = load double, double* %l6
  %t1631 = load double, double* %l7
  %t1632 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1623, label %then82, label %else83
then82:
  %t1633 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1634 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1633
  %t1635 = extractvalue { %MatchContext*, i64 } %t1634, 1
  %t1636 = icmp eq i64 %t1635, 0
  %t1637 = load %PythonBuilder, %PythonBuilder* %l0
  %t1638 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1639 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1640 = load i8*, i8** %l3
  %t1641 = load double, double* %l4
  %t1642 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1643 = load double, double* %l6
  %t1644 = load double, double* %l7
  %t1645 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1636, label %then85, label %else86
then85:
  %t1646 = load %NativeInstruction, %NativeInstruction* %l8
  %t1647 = extractvalue %NativeInstruction %t1646, 0
  %t1648 = alloca %NativeInstruction
  store %NativeInstruction %t1646, %NativeInstruction* %t1648
  %t1649 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1648, i32 0, i32 1
  %t1650 = bitcast [16 x i8]* %t1649 to i8*
  %t1651 = bitcast i8* %t1650 to i8**
  %t1652 = load i8*, i8** %t1651
  %t1653 = icmp eq i32 %t1647, 13
  %t1654 = select i1 %t1653, i8* %t1652, i8* null
  %t1655 = call i8* @trim_text(i8* %t1654)
  store i8* %t1655, i8** %l28
  %s1656 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h2079567388, i32 0, i32 0
  store i8* %s1656, i8** %l29
  %t1657 = load i8*, i8** %l28
  %t1658 = call i64 @sailfin_runtime_string_length(i8* %t1657)
  %t1659 = icmp sgt i64 %t1658, 0
  %t1660 = load %PythonBuilder, %PythonBuilder* %l0
  %t1661 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1662 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1663 = load i8*, i8** %l3
  %t1664 = load double, double* %l4
  %t1665 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1666 = load double, double* %l6
  %t1667 = load double, double* %l7
  %t1668 = load %NativeInstruction, %NativeInstruction* %l8
  %t1669 = load i8*, i8** %l28
  %t1670 = load i8*, i8** %l29
  br i1 %t1659, label %then88, label %merge89
then88:
  %t1671 = load i8*, i8** %l29
  %s1672 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1460619898, i32 0, i32 0
  %t1673 = call i8* @sailfin_runtime_string_concat(i8* %t1671, i8* %s1672)
  %t1674 = load i8*, i8** %l28
  %t1675 = call i8* @sailfin_runtime_string_concat(i8* %t1673, i8* %t1674)
  %t1676 = alloca [2 x i8], align 1
  %t1677 = getelementptr [2 x i8], [2 x i8]* %t1676, i32 0, i32 0
  store i8 41, i8* %t1677
  %t1678 = getelementptr [2 x i8], [2 x i8]* %t1676, i32 0, i32 1
  store i8 0, i8* %t1678
  %t1679 = getelementptr [2 x i8], [2 x i8]* %t1676, i32 0, i32 0
  %t1680 = call i8* @sailfin_runtime_string_concat(i8* %t1675, i8* %t1679)
  store i8* %t1680, i8** %l29
  %t1681 = load i8*, i8** %l29
  br label %merge89
merge89:
  %t1682 = phi i8* [ %t1681, %then88 ], [ %t1670, %then85 ]
  store i8* %t1682, i8** %l29
  %t1683 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1684 = extractvalue %NativeFunction %function, 0
  %t1685 = load i8*, i8** %l29
  %t1686 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1683, i8* %t1684, i8* %t1685)
  store { i8**, i64 }* %t1686, { i8**, i64 }** %l1
  %t1687 = load %PythonBuilder, %PythonBuilder* %l0
  %s1688 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1804821690, i32 0, i32 0
  %t1689 = call %PythonBuilder @builder_emit(%PythonBuilder %t1687, i8* %s1688)
  store %PythonBuilder %t1689, %PythonBuilder* %l0
  %t1690 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1691 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge87
else86:
  %t1692 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1693 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1692
  %t1694 = extractvalue { %MatchContext*, i64 } %t1693, 1
  %t1695 = sub i64 %t1694, 1
  store i64 %t1695, i64* %l30
  %t1696 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1697 = load i64, i64* %l30
  %t1698 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1696
  %t1699 = extractvalue { %MatchContext*, i64 } %t1698, 0
  %t1700 = extractvalue { %MatchContext*, i64 } %t1698, 1
  %t1701 = icmp uge i64 %t1697, %t1700
  ; bounds check: %t1701 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1697, i64 %t1700)
  %t1702 = getelementptr %MatchContext, %MatchContext* %t1699, i64 %t1697
  %t1703 = load %MatchContext, %MatchContext* %t1702
  store %MatchContext %t1703, %MatchContext* %l31
  %t1704 = load %MatchContext, %MatchContext* %l31
  %t1705 = extractvalue %MatchContext %t1704, 2
  %t1706 = load %PythonBuilder, %PythonBuilder* %l0
  %t1707 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1708 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1709 = load i8*, i8** %l3
  %t1710 = load double, double* %l4
  %t1711 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1712 = load double, double* %l6
  %t1713 = load double, double* %l7
  %t1714 = load %NativeInstruction, %NativeInstruction* %l8
  %t1715 = load i64, i64* %l30
  %t1716 = load %MatchContext, %MatchContext* %l31
  br i1 %t1705, label %then90, label %merge91
then90:
  %t1717 = load %PythonBuilder, %PythonBuilder* %l0
  %t1718 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1717)
  store %PythonBuilder %t1718, %PythonBuilder* %l0
  %t1719 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge91
merge91:
  %t1720 = phi %PythonBuilder [ %t1719, %then90 ], [ %t1706, %else86 ]
  store %PythonBuilder %t1720, %PythonBuilder* %l0
  %t1721 = load %MatchContext, %MatchContext* %l31
  %t1722 = extractvalue %MatchContext %t1721, 0
  %t1723 = load %NativeInstruction, %NativeInstruction* %l8
  %t1724 = extractvalue %NativeInstruction %t1723, 0
  %t1725 = alloca %NativeInstruction
  store %NativeInstruction %t1723, %NativeInstruction* %t1725
  %t1726 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1725, i32 0, i32 1
  %t1727 = bitcast [16 x i8]* %t1726 to i8*
  %t1728 = bitcast i8* %t1727 to i8**
  %t1729 = load i8*, i8** %t1728
  %t1730 = icmp eq i32 %t1724, 13
  %t1731 = select i1 %t1730, i8* %t1729, i8* null
  %t1732 = load %NativeInstruction, %NativeInstruction* %l8
  %t1733 = extractvalue %NativeInstruction %t1732, 0
  %t1734 = alloca %NativeInstruction
  store %NativeInstruction %t1732, %NativeInstruction* %t1734
  %t1735 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1734, i32 0, i32 1
  %t1736 = bitcast [16 x i8]* %t1735 to i8*
  %t1737 = getelementptr inbounds i8, i8* %t1736, i64 8
  %t1738 = bitcast i8* %t1737 to i8**
  %t1739 = load i8*, i8** %t1738
  %t1740 = icmp eq i32 %t1733, 13
  %t1741 = select i1 %t1740, i8* %t1739, i8* null
  %t1742 = call %LoweredCaseCondition @lower_match_case_condition(i8* %t1722, i8* %t1731, i8* %t1741)
  store %LoweredCaseCondition %t1742, %LoweredCaseCondition* %l32
  %t1743 = load %MatchContext, %MatchContext* %l31
  %t1744 = extractvalue %MatchContext %t1743, 1
  %t1745 = sitofp i64 0 to double
  %t1746 = fcmp oeq double %t1744, %t1745
  %t1747 = load %PythonBuilder, %PythonBuilder* %l0
  %t1748 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1749 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1750 = load i8*, i8** %l3
  %t1751 = load double, double* %l4
  %t1752 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1753 = load double, double* %l6
  %t1754 = load double, double* %l7
  %t1755 = load %NativeInstruction, %NativeInstruction* %l8
  %t1756 = load i64, i64* %l30
  %t1757 = load %MatchContext, %MatchContext* %l31
  %t1758 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1746, label %then92, label %else93
then92:
  %t1759 = load %PythonBuilder, %PythonBuilder* %l0
  %s1760 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090359129, i32 0, i32 0
  %t1761 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1762 = extractvalue %LoweredCaseCondition %t1761, 0
  %t1763 = call i8* @sailfin_runtime_string_concat(i8* %s1760, i8* %t1762)
  %t1764 = alloca [2 x i8], align 1
  %t1765 = getelementptr [2 x i8], [2 x i8]* %t1764, i32 0, i32 0
  store i8 58, i8* %t1765
  %t1766 = getelementptr [2 x i8], [2 x i8]* %t1764, i32 0, i32 1
  store i8 0, i8* %t1766
  %t1767 = getelementptr [2 x i8], [2 x i8]* %t1764, i32 0, i32 0
  %t1768 = call i8* @sailfin_runtime_string_concat(i8* %t1763, i8* %t1767)
  %t1769 = call %PythonBuilder @builder_emit(%PythonBuilder %t1759, i8* %t1768)
  store %PythonBuilder %t1769, %PythonBuilder* %l0
  %t1770 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
else93:
  %t1772 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1773 = extractvalue %LoweredCaseCondition %t1772, 1
  br label %logical_and_entry_1771

logical_and_entry_1771:
  br i1 %t1773, label %logical_and_right_1771, label %logical_and_merge_1771

logical_and_right_1771:
  %t1774 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1775 = extractvalue %LoweredCaseCondition %t1774, 2
  %t1776 = xor i1 %t1775, 1
  br label %logical_and_right_end_1771

logical_and_right_end_1771:
  br label %logical_and_merge_1771

logical_and_merge_1771:
  %t1777 = phi i1 [ false, %logical_and_entry_1771 ], [ %t1776, %logical_and_right_end_1771 ]
  %t1778 = load %PythonBuilder, %PythonBuilder* %l0
  %t1779 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1780 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1781 = load i8*, i8** %l3
  %t1782 = load double, double* %l4
  %t1783 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1784 = load double, double* %l6
  %t1785 = load double, double* %l7
  %t1786 = load %NativeInstruction, %NativeInstruction* %l8
  %t1787 = load i64, i64* %l30
  %t1788 = load %MatchContext, %MatchContext* %l31
  %t1789 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  br i1 %t1777, label %then95, label %else96
then95:
  %t1790 = load %PythonBuilder, %PythonBuilder* %l0
  %s1791 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069574674, i32 0, i32 0
  %t1792 = call %PythonBuilder @builder_emit(%PythonBuilder %t1790, i8* %s1791)
  store %PythonBuilder %t1792, %PythonBuilder* %l0
  %t1793 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
else96:
  %t1794 = load %PythonBuilder, %PythonBuilder* %l0
  %s1795 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2069215535, i32 0, i32 0
  %t1796 = load %LoweredCaseCondition, %LoweredCaseCondition* %l32
  %t1797 = extractvalue %LoweredCaseCondition %t1796, 0
  %t1798 = call i8* @sailfin_runtime_string_concat(i8* %s1795, i8* %t1797)
  %t1799 = alloca [2 x i8], align 1
  %t1800 = getelementptr [2 x i8], [2 x i8]* %t1799, i32 0, i32 0
  store i8 58, i8* %t1800
  %t1801 = getelementptr [2 x i8], [2 x i8]* %t1799, i32 0, i32 1
  store i8 0, i8* %t1801
  %t1802 = getelementptr [2 x i8], [2 x i8]* %t1799, i32 0, i32 0
  %t1803 = call i8* @sailfin_runtime_string_concat(i8* %t1798, i8* %t1802)
  %t1804 = call %PythonBuilder @builder_emit(%PythonBuilder %t1794, i8* %t1803)
  store %PythonBuilder %t1804, %PythonBuilder* %l0
  %t1805 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge97
merge97:
  %t1806 = phi %PythonBuilder [ %t1793, %then95 ], [ %t1805, %else96 ]
  store %PythonBuilder %t1806, %PythonBuilder* %l0
  %t1807 = load %PythonBuilder, %PythonBuilder* %l0
  %t1808 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge94
merge94:
  %t1809 = phi %PythonBuilder [ %t1770, %then92 ], [ %t1807, %merge97 ]
  store %PythonBuilder %t1809, %PythonBuilder* %l0
  %t1810 = load %PythonBuilder, %PythonBuilder* %l0
  %t1811 = call %PythonBuilder @builder_push_indent(%PythonBuilder %t1810)
  store %PythonBuilder %t1811, %PythonBuilder* %l0
  %t1812 = load %MatchContext, %MatchContext* %l31
  %t1813 = extractvalue %MatchContext %t1812, 0
  %t1814 = insertvalue %MatchContext undef, i8* %t1813, 0
  %t1815 = load %MatchContext, %MatchContext* %l31
  %t1816 = extractvalue %MatchContext %t1815, 1
  %t1817 = sitofp i64 1 to double
  %t1818 = fadd double %t1816, %t1817
  %t1819 = insertvalue %MatchContext %t1814, double %t1818, 1
  %t1820 = insertvalue %MatchContext %t1819, i1 1, 2
  store %MatchContext %t1820, %MatchContext* %l33
  %t1821 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1822 = load i64, i64* %l30
  %t1823 = load %MatchContext, %MatchContext* %l33
  %t1824 = sitofp i64 %t1822 to double
  %t1825 = call { %MatchContext*, i64 }* @replace_match_context({ %MatchContext*, i64 }* %t1821, double %t1824, %MatchContext %t1823)
  store { %MatchContext*, i64 }* %t1825, { %MatchContext*, i64 }** %l5
  %t1826 = load %PythonBuilder, %PythonBuilder* %l0
  %t1827 = load %PythonBuilder, %PythonBuilder* %l0
  %t1828 = load %PythonBuilder, %PythonBuilder* %l0
  %t1829 = load %PythonBuilder, %PythonBuilder* %l0
  %t1830 = load %PythonBuilder, %PythonBuilder* %l0
  %t1831 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge87
merge87:
  %t1832 = phi { i8**, i64 }* [ %t1690, %merge89 ], [ %t1638, %merge94 ]
  %t1833 = phi %PythonBuilder [ %t1691, %merge89 ], [ %t1826, %merge94 ]
  %t1834 = phi { %MatchContext*, i64 }* [ %t1642, %merge89 ], [ %t1831, %merge94 ]
  store { i8**, i64 }* %t1832, { i8**, i64 }** %l1
  store %PythonBuilder %t1833, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1834, { %MatchContext*, i64 }** %l5
  %t1835 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1836 = load %PythonBuilder, %PythonBuilder* %l0
  %t1837 = load %PythonBuilder, %PythonBuilder* %l0
  %t1838 = load %PythonBuilder, %PythonBuilder* %l0
  %t1839 = load %PythonBuilder, %PythonBuilder* %l0
  %t1840 = load %PythonBuilder, %PythonBuilder* %l0
  %t1841 = load %PythonBuilder, %PythonBuilder* %l0
  %t1842 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge84
else83:
  %t1843 = load %NativeInstruction, %NativeInstruction* %l8
  %t1844 = extractvalue %NativeInstruction %t1843, 0
  %t1845 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1846 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1847 = icmp eq i32 %t1844, 0
  %t1848 = select i1 %t1847, i8* %t1846, i8* %t1845
  %t1849 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1850 = icmp eq i32 %t1844, 1
  %t1851 = select i1 %t1850, i8* %t1849, i8* %t1848
  %t1852 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1853 = icmp eq i32 %t1844, 2
  %t1854 = select i1 %t1853, i8* %t1852, i8* %t1851
  %t1855 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1856 = icmp eq i32 %t1844, 3
  %t1857 = select i1 %t1856, i8* %t1855, i8* %t1854
  %t1858 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1859 = icmp eq i32 %t1844, 4
  %t1860 = select i1 %t1859, i8* %t1858, i8* %t1857
  %t1861 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1862 = icmp eq i32 %t1844, 5
  %t1863 = select i1 %t1862, i8* %t1861, i8* %t1860
  %t1864 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1865 = icmp eq i32 %t1844, 6
  %t1866 = select i1 %t1865, i8* %t1864, i8* %t1863
  %t1867 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1868 = icmp eq i32 %t1844, 7
  %t1869 = select i1 %t1868, i8* %t1867, i8* %t1866
  %t1870 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1871 = icmp eq i32 %t1844, 8
  %t1872 = select i1 %t1871, i8* %t1870, i8* %t1869
  %t1873 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1874 = icmp eq i32 %t1844, 9
  %t1875 = select i1 %t1874, i8* %t1873, i8* %t1872
  %t1876 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1877 = icmp eq i32 %t1844, 10
  %t1878 = select i1 %t1877, i8* %t1876, i8* %t1875
  %t1879 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1880 = icmp eq i32 %t1844, 11
  %t1881 = select i1 %t1880, i8* %t1879, i8* %t1878
  %t1882 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1883 = icmp eq i32 %t1844, 12
  %t1884 = select i1 %t1883, i8* %t1882, i8* %t1881
  %t1885 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1886 = icmp eq i32 %t1844, 13
  %t1887 = select i1 %t1886, i8* %t1885, i8* %t1884
  %t1888 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1889 = icmp eq i32 %t1844, 14
  %t1890 = select i1 %t1889, i8* %t1888, i8* %t1887
  %t1891 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1892 = icmp eq i32 %t1844, 15
  %t1893 = select i1 %t1892, i8* %t1891, i8* %t1890
  %t1894 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1895 = icmp eq i32 %t1844, 16
  %t1896 = select i1 %t1895, i8* %t1894, i8* %t1893
  %s1897 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h794378208, i32 0, i32 0
  %t1898 = call i1 @strings_equal(i8* %t1896, i8* %s1897)
  %t1899 = load %PythonBuilder, %PythonBuilder* %l0
  %t1900 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1901 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1902 = load i8*, i8** %l3
  %t1903 = load double, double* %l4
  %t1904 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1905 = load double, double* %l6
  %t1906 = load double, double* %l7
  %t1907 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1898, label %then98, label %else99
then98:
  %t1908 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1909 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1908
  %t1910 = extractvalue { %MatchContext*, i64 } %t1909, 1
  %t1911 = icmp eq i64 %t1910, 0
  %t1912 = load %PythonBuilder, %PythonBuilder* %l0
  %t1913 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1914 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1915 = load i8*, i8** %l3
  %t1916 = load double, double* %l4
  %t1917 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1918 = load double, double* %l6
  %t1919 = load double, double* %l7
  %t1920 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t1911, label %then101, label %else102
then101:
  %t1921 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1922 = extractvalue %NativeFunction %function, 0
  %s1923 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h314404344, i32 0, i32 0
  %t1924 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t1921, i8* %t1922, i8* %s1923)
  store { i8**, i64 }* %t1924, { i8**, i64 }** %l1
  %t1925 = load %PythonBuilder, %PythonBuilder* %l0
  %s1926 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h198700275, i32 0, i32 0
  %t1927 = call %PythonBuilder @builder_emit(%PythonBuilder %t1925, i8* %s1926)
  store %PythonBuilder %t1927, %PythonBuilder* %l0
  %t1928 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1929 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge103
else102:
  %t1930 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1931 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1930
  %t1932 = extractvalue { %MatchContext*, i64 } %t1931, 1
  %t1933 = sub i64 %t1932, 1
  store i64 %t1933, i64* %l34
  %t1934 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1935 = load i64, i64* %l34
  %t1936 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t1934
  %t1937 = extractvalue { %MatchContext*, i64 } %t1936, 0
  %t1938 = extractvalue { %MatchContext*, i64 } %t1936, 1
  %t1939 = icmp uge i64 %t1935, %t1938
  ; bounds check: %t1939 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1935, i64 %t1938)
  %t1940 = getelementptr %MatchContext, %MatchContext* %t1937, i64 %t1935
  %t1941 = load %MatchContext, %MatchContext* %t1940
  store %MatchContext %t1941, %MatchContext* %l35
  %t1942 = load %MatchContext, %MatchContext* %l35
  %t1943 = extractvalue %MatchContext %t1942, 2
  %t1944 = load %PythonBuilder, %PythonBuilder* %l0
  %t1945 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1946 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t1947 = load i8*, i8** %l3
  %t1948 = load double, double* %l4
  %t1949 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1950 = load double, double* %l6
  %t1951 = load double, double* %l7
  %t1952 = load %NativeInstruction, %NativeInstruction* %l8
  %t1953 = load i64, i64* %l34
  %t1954 = load %MatchContext, %MatchContext* %l35
  br i1 %t1943, label %then104, label %merge105
then104:
  %t1955 = load %PythonBuilder, %PythonBuilder* %l0
  %t1956 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t1955)
  store %PythonBuilder %t1956, %PythonBuilder* %l0
  %t1957 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge105
merge105:
  %t1958 = phi %PythonBuilder [ %t1957, %then104 ], [ %t1944, %else102 ]
  store %PythonBuilder %t1958, %PythonBuilder* %l0
  %t1959 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t1960 = load i64, i64* %l34
  %t1961 = sitofp i64 %t1960 to double
  %t1962 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t1959, double %t1961)
  store { %MatchContext*, i64 }* %t1962, { %MatchContext*, i64 }** %l5
  %t1963 = load %PythonBuilder, %PythonBuilder* %l0
  %t1964 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge103
merge103:
  %t1965 = phi { i8**, i64 }* [ %t1928, %then101 ], [ %t1913, %merge105 ]
  %t1966 = phi %PythonBuilder [ %t1929, %then101 ], [ %t1963, %merge105 ]
  %t1967 = phi { %MatchContext*, i64 }* [ %t1917, %then101 ], [ %t1964, %merge105 ]
  store { i8**, i64 }* %t1965, { i8**, i64 }** %l1
  store %PythonBuilder %t1966, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t1967, { %MatchContext*, i64 }** %l5
  %t1968 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1969 = load %PythonBuilder, %PythonBuilder* %l0
  %t1970 = load %PythonBuilder, %PythonBuilder* %l0
  %t1971 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %merge100
else99:
  %t1972 = load %NativeInstruction, %NativeInstruction* %l8
  %t1973 = extractvalue %NativeInstruction %t1972, 0
  %t1974 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1975 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1976 = icmp eq i32 %t1973, 0
  %t1977 = select i1 %t1976, i8* %t1975, i8* %t1974
  %t1978 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1979 = icmp eq i32 %t1973, 1
  %t1980 = select i1 %t1979, i8* %t1978, i8* %t1977
  %t1981 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1982 = icmp eq i32 %t1973, 2
  %t1983 = select i1 %t1982, i8* %t1981, i8* %t1980
  %t1984 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1985 = icmp eq i32 %t1973, 3
  %t1986 = select i1 %t1985, i8* %t1984, i8* %t1983
  %t1987 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1988 = icmp eq i32 %t1973, 4
  %t1989 = select i1 %t1988, i8* %t1987, i8* %t1986
  %t1990 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1991 = icmp eq i32 %t1973, 5
  %t1992 = select i1 %t1991, i8* %t1990, i8* %t1989
  %t1993 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1994 = icmp eq i32 %t1973, 6
  %t1995 = select i1 %t1994, i8* %t1993, i8* %t1992
  %t1996 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1997 = icmp eq i32 %t1973, 7
  %t1998 = select i1 %t1997, i8* %t1996, i8* %t1995
  %t1999 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t2000 = icmp eq i32 %t1973, 8
  %t2001 = select i1 %t2000, i8* %t1999, i8* %t1998
  %t2002 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t2003 = icmp eq i32 %t1973, 9
  %t2004 = select i1 %t2003, i8* %t2002, i8* %t2001
  %t2005 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t2006 = icmp eq i32 %t1973, 10
  %t2007 = select i1 %t2006, i8* %t2005, i8* %t2004
  %t2008 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t2009 = icmp eq i32 %t1973, 11
  %t2010 = select i1 %t2009, i8* %t2008, i8* %t2007
  %t2011 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t2012 = icmp eq i32 %t1973, 12
  %t2013 = select i1 %t2012, i8* %t2011, i8* %t2010
  %t2014 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t2015 = icmp eq i32 %t1973, 13
  %t2016 = select i1 %t2015, i8* %t2014, i8* %t2013
  %t2017 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t2018 = icmp eq i32 %t1973, 14
  %t2019 = select i1 %t2018, i8* %t2017, i8* %t2016
  %t2020 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t2021 = icmp eq i32 %t1973, 15
  %t2022 = select i1 %t2021, i8* %t2020, i8* %t2019
  %t2023 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t2024 = icmp eq i32 %t1973, 16
  %t2025 = select i1 %t2024, i8* %t2023, i8* %t2022
  %s2026 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h230767751, i32 0, i32 0
  %t2027 = call i1 @strings_equal(i8* %t2025, i8* %s2026)
  %t2028 = load %PythonBuilder, %PythonBuilder* %l0
  %t2029 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2030 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2031 = load i8*, i8** %l3
  %t2032 = load double, double* %l4
  %t2033 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2034 = load double, double* %l6
  %t2035 = load double, double* %l7
  %t2036 = load %NativeInstruction, %NativeInstruction* %l8
  br i1 %t2027, label %then106, label %else107
then106:
  %t2037 = load %PythonBuilder, %PythonBuilder* %l0
  %s2038 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h270590402, i32 0, i32 0
  %t2039 = call %PythonBuilder @builder_emit(%PythonBuilder %t2037, i8* %s2038)
  store %PythonBuilder %t2039, %PythonBuilder* %l0
  %t2040 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
else107:
  %t2041 = load %NativeInstruction, %NativeInstruction* %l8
  %t2042 = extractvalue %NativeInstruction %t2041, 0
  %t2043 = alloca %NativeInstruction
  store %NativeInstruction %t2041, %NativeInstruction* %t2043
  %t2044 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2043, i32 0, i32 1
  %t2045 = bitcast [8 x i8]* %t2044 to i8*
  %t2046 = bitcast i8* %t2045 to i8**
  %t2047 = load i8*, i8** %t2046
  %t2048 = icmp eq i32 %t2042, 16
  %t2049 = select i1 %t2048, i8* %t2047, i8* null
  %t2050 = call i8* @trim_text(i8* %t2049)
  store i8* %t2050, i8** %l36
  %s2051 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h9444846, i32 0, i32 0
  store i8* %s2051, i8** %l37
  %t2052 = load i8*, i8** %l36
  %t2053 = call i64 @sailfin_runtime_string_length(i8* %t2052)
  %t2054 = icmp sgt i64 %t2053, 0
  %t2055 = load %PythonBuilder, %PythonBuilder* %l0
  %t2056 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2057 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2058 = load i8*, i8** %l3
  %t2059 = load double, double* %l4
  %t2060 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2061 = load double, double* %l6
  %t2062 = load double, double* %l7
  %t2063 = load %NativeInstruction, %NativeInstruction* %l8
  %t2064 = load i8*, i8** %l36
  %t2065 = load i8*, i8** %l37
  br i1 %t2054, label %then109, label %merge110
then109:
  %t2066 = load i8*, i8** %l37
  %s2067 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193441217, i32 0, i32 0
  %t2068 = call i8* @sailfin_runtime_string_concat(i8* %t2066, i8* %s2067)
  %t2069 = load i8*, i8** %l36
  %t2070 = call i8* @sailfin_runtime_string_concat(i8* %t2068, i8* %t2069)
  store i8* %t2070, i8** %l37
  %t2071 = load i8*, i8** %l37
  br label %merge110
merge110:
  %t2072 = phi i8* [ %t2071, %then109 ], [ %t2065, %else107 ]
  store i8* %t2072, i8** %l37
  %t2073 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2074 = extractvalue %NativeFunction %function, 0
  %t2075 = load i8*, i8** %l37
  %t2076 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2073, i8* %t2074, i8* %t2075)
  store { i8**, i64 }* %t2076, { i8**, i64 }** %l1
  %t2077 = load %PythonBuilder, %PythonBuilder* %l0
  %s2078 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h1983072220, i32 0, i32 0
  %t2079 = load %NativeInstruction, %NativeInstruction* %l8
  %t2080 = extractvalue %NativeInstruction %t2079, 0
  %t2081 = alloca %NativeInstruction
  store %NativeInstruction %t2079, %NativeInstruction* %t2081
  %t2082 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t2081, i32 0, i32 1
  %t2083 = bitcast [8 x i8]* %t2082 to i8*
  %t2084 = bitcast i8* %t2083 to i8**
  %t2085 = load i8*, i8** %t2084
  %t2086 = icmp eq i32 %t2080, 16
  %t2087 = select i1 %t2086, i8* %t2085, i8* null
  %t2088 = call i8* @sailfin_runtime_string_concat(i8* %s2078, i8* %t2087)
  %t2089 = call %PythonBuilder @builder_emit(%PythonBuilder %t2077, i8* %t2088)
  store %PythonBuilder %t2089, %PythonBuilder* %l0
  %t2090 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2091 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge108
merge108:
  %t2092 = phi %PythonBuilder [ %t2040, %then106 ], [ %t2091, %merge110 ]
  %t2093 = phi { i8**, i64 }* [ %t2029, %then106 ], [ %t2090, %merge110 ]
  store %PythonBuilder %t2092, %PythonBuilder* %l0
  store { i8**, i64 }* %t2093, { i8**, i64 }** %l1
  %t2094 = load %PythonBuilder, %PythonBuilder* %l0
  %t2095 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2096 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge100
merge100:
  %t2097 = phi { i8**, i64 }* [ %t1968, %merge103 ], [ %t2095, %merge108 ]
  %t2098 = phi %PythonBuilder [ %t1969, %merge103 ], [ %t2094, %merge108 ]
  %t2099 = phi { %MatchContext*, i64 }* [ %t1971, %merge103 ], [ %t1904, %merge108 ]
  store { i8**, i64 }* %t2097, { i8**, i64 }** %l1
  store %PythonBuilder %t2098, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2099, { %MatchContext*, i64 }** %l5
  %t2100 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2101 = load %PythonBuilder, %PythonBuilder* %l0
  %t2102 = load %PythonBuilder, %PythonBuilder* %l0
  %t2103 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2104 = load %PythonBuilder, %PythonBuilder* %l0
  %t2105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2106 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge84
merge84:
  %t2107 = phi { i8**, i64 }* [ %t1835, %merge87 ], [ %t2100, %merge100 ]
  %t2108 = phi %PythonBuilder [ %t1836, %merge87 ], [ %t2101, %merge100 ]
  %t2109 = phi { %MatchContext*, i64 }* [ %t1842, %merge87 ], [ %t2103, %merge100 ]
  store { i8**, i64 }* %t2107, { i8**, i64 }** %l1
  store %PythonBuilder %t2108, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2109, { %MatchContext*, i64 }** %l5
  %t2110 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2111 = load %PythonBuilder, %PythonBuilder* %l0
  %t2112 = load %PythonBuilder, %PythonBuilder* %l0
  %t2113 = load %PythonBuilder, %PythonBuilder* %l0
  %t2114 = load %PythonBuilder, %PythonBuilder* %l0
  %t2115 = load %PythonBuilder, %PythonBuilder* %l0
  %t2116 = load %PythonBuilder, %PythonBuilder* %l0
  %t2117 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2119 = load %PythonBuilder, %PythonBuilder* %l0
  %t2120 = load %PythonBuilder, %PythonBuilder* %l0
  %t2121 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2122 = load %PythonBuilder, %PythonBuilder* %l0
  %t2123 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2124 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge81
merge81:
  %t2125 = phi double [ %t1565, %then79 ], [ %t1520, %merge84 ]
  %t2126 = phi %PythonBuilder [ %t1566, %then79 ], [ %t2111, %merge84 ]
  %t2127 = phi { %MatchContext*, i64 }* [ %t1567, %then79 ], [ %t2117, %merge84 ]
  %t2128 = phi { i8**, i64 }* [ %t1515, %then79 ], [ %t2110, %merge84 ]
  store double %t2125, double* %l6
  store %PythonBuilder %t2126, %PythonBuilder* %l0
  store { %MatchContext*, i64 }* %t2127, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2128, { i8**, i64 }** %l1
  %t2129 = load double, double* %l6
  %t2130 = load %PythonBuilder, %PythonBuilder* %l0
  %t2131 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2133 = load %PythonBuilder, %PythonBuilder* %l0
  %t2134 = load %PythonBuilder, %PythonBuilder* %l0
  %t2135 = load %PythonBuilder, %PythonBuilder* %l0
  %t2136 = load %PythonBuilder, %PythonBuilder* %l0
  %t2137 = load %PythonBuilder, %PythonBuilder* %l0
  %t2138 = load %PythonBuilder, %PythonBuilder* %l0
  %t2139 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2141 = load %PythonBuilder, %PythonBuilder* %l0
  %t2142 = load %PythonBuilder, %PythonBuilder* %l0
  %t2143 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2144 = load %PythonBuilder, %PythonBuilder* %l0
  %t2145 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2146 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge78
merge78:
  %t2147 = phi %PythonBuilder [ %t1457, %then76 ], [ %t2130, %merge81 ]
  %t2148 = phi double [ %t1451, %then76 ], [ %t2129, %merge81 ]
  %t2149 = phi { %MatchContext*, i64 }* [ %t1450, %then76 ], [ %t2131, %merge81 ]
  %t2150 = phi { i8**, i64 }* [ %t1446, %then76 ], [ %t2132, %merge81 ]
  store %PythonBuilder %t2147, %PythonBuilder* %l0
  store double %t2148, double* %l6
  store { %MatchContext*, i64 }* %t2149, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2150, { i8**, i64 }** %l1
  %t2151 = load %PythonBuilder, %PythonBuilder* %l0
  %t2152 = load double, double* %l6
  %t2153 = load %PythonBuilder, %PythonBuilder* %l0
  %t2154 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2156 = load %PythonBuilder, %PythonBuilder* %l0
  %t2157 = load %PythonBuilder, %PythonBuilder* %l0
  %t2158 = load %PythonBuilder, %PythonBuilder* %l0
  %t2159 = load %PythonBuilder, %PythonBuilder* %l0
  %t2160 = load %PythonBuilder, %PythonBuilder* %l0
  %t2161 = load %PythonBuilder, %PythonBuilder* %l0
  %t2162 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2163 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2164 = load %PythonBuilder, %PythonBuilder* %l0
  %t2165 = load %PythonBuilder, %PythonBuilder* %l0
  %t2166 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2167 = load %PythonBuilder, %PythonBuilder* %l0
  %t2168 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2169 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge75
merge75:
  %t2170 = phi %PythonBuilder [ %t1388, %then73 ], [ %t2151, %merge78 ]
  %t2171 = phi double [ %t1382, %then73 ], [ %t2152, %merge78 ]
  %t2172 = phi { %MatchContext*, i64 }* [ %t1381, %then73 ], [ %t2154, %merge78 ]
  %t2173 = phi { i8**, i64 }* [ %t1377, %then73 ], [ %t2155, %merge78 ]
  store %PythonBuilder %t2170, %PythonBuilder* %l0
  store double %t2171, double* %l6
  store { %MatchContext*, i64 }* %t2172, { %MatchContext*, i64 }** %l5
  store { i8**, i64 }* %t2173, { i8**, i64 }** %l1
  %t2174 = load %PythonBuilder, %PythonBuilder* %l0
  %t2175 = load %PythonBuilder, %PythonBuilder* %l0
  %t2176 = load double, double* %l6
  %t2177 = load %PythonBuilder, %PythonBuilder* %l0
  %t2178 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2180 = load %PythonBuilder, %PythonBuilder* %l0
  %t2181 = load %PythonBuilder, %PythonBuilder* %l0
  %t2182 = load %PythonBuilder, %PythonBuilder* %l0
  %t2183 = load %PythonBuilder, %PythonBuilder* %l0
  %t2184 = load %PythonBuilder, %PythonBuilder* %l0
  %t2185 = load %PythonBuilder, %PythonBuilder* %l0
  %t2186 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2187 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2188 = load %PythonBuilder, %PythonBuilder* %l0
  %t2189 = load %PythonBuilder, %PythonBuilder* %l0
  %t2190 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2191 = load %PythonBuilder, %PythonBuilder* %l0
  %t2192 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2193 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge69
merge69:
  %t2194 = phi %PythonBuilder [ %t1317, %merge72 ], [ %t2174, %merge75 ]
  %t2195 = phi double [ %t1318, %merge72 ], [ %t1285, %merge75 ]
  %t2196 = phi { i8**, i64 }* [ %t1319, %merge72 ], [ %t2179, %merge75 ]
  %t2197 = phi double [ %t1287, %merge72 ], [ %t2176, %merge75 ]
  %t2198 = phi { %MatchContext*, i64 }* [ %t1286, %merge72 ], [ %t2178, %merge75 ]
  store %PythonBuilder %t2194, %PythonBuilder* %l0
  store double %t2195, double* %l4
  store { i8**, i64 }* %t2196, { i8**, i64 }** %l1
  store double %t2197, double* %l6
  store { %MatchContext*, i64 }* %t2198, { %MatchContext*, i64 }** %l5
  %t2199 = load %PythonBuilder, %PythonBuilder* %l0
  %t2200 = load double, double* %l4
  %t2201 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2202 = load %PythonBuilder, %PythonBuilder* %l0
  %t2203 = load %PythonBuilder, %PythonBuilder* %l0
  %t2204 = load double, double* %l6
  %t2205 = load %PythonBuilder, %PythonBuilder* %l0
  %t2206 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2208 = load %PythonBuilder, %PythonBuilder* %l0
  %t2209 = load %PythonBuilder, %PythonBuilder* %l0
  %t2210 = load %PythonBuilder, %PythonBuilder* %l0
  %t2211 = load %PythonBuilder, %PythonBuilder* %l0
  %t2212 = load %PythonBuilder, %PythonBuilder* %l0
  %t2213 = load %PythonBuilder, %PythonBuilder* %l0
  %t2214 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2215 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2216 = load %PythonBuilder, %PythonBuilder* %l0
  %t2217 = load %PythonBuilder, %PythonBuilder* %l0
  %t2218 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2219 = load %PythonBuilder, %PythonBuilder* %l0
  %t2220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2221 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge66
merge66:
  %t2222 = phi %PythonBuilder [ %t1222, %then64 ], [ %t2199, %merge69 ]
  %t2223 = phi double [ %t1224, %then64 ], [ %t2200, %merge69 ]
  %t2224 = phi { i8**, i64 }* [ %t1206, %then64 ], [ %t2201, %merge69 ]
  %t2225 = phi double [ %t1211, %then64 ], [ %t2204, %merge69 ]
  %t2226 = phi { %MatchContext*, i64 }* [ %t1210, %then64 ], [ %t2206, %merge69 ]
  store %PythonBuilder %t2222, %PythonBuilder* %l0
  store double %t2223, double* %l4
  store { i8**, i64 }* %t2224, { i8**, i64 }** %l1
  store double %t2225, double* %l6
  store { %MatchContext*, i64 }* %t2226, { %MatchContext*, i64 }** %l5
  %t2227 = load %PythonBuilder, %PythonBuilder* %l0
  %t2228 = load %PythonBuilder, %PythonBuilder* %l0
  %t2229 = load double, double* %l4
  %t2230 = load %PythonBuilder, %PythonBuilder* %l0
  %t2231 = load double, double* %l4
  %t2232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2233 = load %PythonBuilder, %PythonBuilder* %l0
  %t2234 = load %PythonBuilder, %PythonBuilder* %l0
  %t2235 = load double, double* %l6
  %t2236 = load %PythonBuilder, %PythonBuilder* %l0
  %t2237 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2239 = load %PythonBuilder, %PythonBuilder* %l0
  %t2240 = load %PythonBuilder, %PythonBuilder* %l0
  %t2241 = load %PythonBuilder, %PythonBuilder* %l0
  %t2242 = load %PythonBuilder, %PythonBuilder* %l0
  %t2243 = load %PythonBuilder, %PythonBuilder* %l0
  %t2244 = load %PythonBuilder, %PythonBuilder* %l0
  %t2245 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2247 = load %PythonBuilder, %PythonBuilder* %l0
  %t2248 = load %PythonBuilder, %PythonBuilder* %l0
  %t2249 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2250 = load %PythonBuilder, %PythonBuilder* %l0
  %t2251 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2252 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge60
merge60:
  %t2253 = phi %PythonBuilder [ %t1146, %merge63 ], [ %t2227, %merge66 ]
  %t2254 = phi double [ %t1147, %merge63 ], [ %t2229, %merge66 ]
  %t2255 = phi { i8**, i64 }* [ %t1148, %merge63 ], [ %t2232, %merge66 ]
  %t2256 = phi double [ %t1116, %merge63 ], [ %t2235, %merge66 ]
  %t2257 = phi { %MatchContext*, i64 }* [ %t1115, %merge63 ], [ %t2237, %merge66 ]
  store %PythonBuilder %t2253, %PythonBuilder* %l0
  store double %t2254, double* %l4
  store { i8**, i64 }* %t2255, { i8**, i64 }** %l1
  store double %t2256, double* %l6
  store { %MatchContext*, i64 }* %t2257, { %MatchContext*, i64 }** %l5
  %t2258 = load %PythonBuilder, %PythonBuilder* %l0
  %t2259 = load double, double* %l4
  %t2260 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2261 = load %PythonBuilder, %PythonBuilder* %l0
  %t2262 = load %PythonBuilder, %PythonBuilder* %l0
  %t2263 = load double, double* %l4
  %t2264 = load %PythonBuilder, %PythonBuilder* %l0
  %t2265 = load double, double* %l4
  %t2266 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2267 = load %PythonBuilder, %PythonBuilder* %l0
  %t2268 = load %PythonBuilder, %PythonBuilder* %l0
  %t2269 = load double, double* %l6
  %t2270 = load %PythonBuilder, %PythonBuilder* %l0
  %t2271 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2273 = load %PythonBuilder, %PythonBuilder* %l0
  %t2274 = load %PythonBuilder, %PythonBuilder* %l0
  %t2275 = load %PythonBuilder, %PythonBuilder* %l0
  %t2276 = load %PythonBuilder, %PythonBuilder* %l0
  %t2277 = load %PythonBuilder, %PythonBuilder* %l0
  %t2278 = load %PythonBuilder, %PythonBuilder* %l0
  %t2279 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2280 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2281 = load %PythonBuilder, %PythonBuilder* %l0
  %t2282 = load %PythonBuilder, %PythonBuilder* %l0
  %t2283 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2284 = load %PythonBuilder, %PythonBuilder* %l0
  %t2285 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2286 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge57
merge57:
  %t2287 = phi %PythonBuilder [ %t1051, %then55 ], [ %t2258, %merge60 ]
  %t2288 = phi double [ %t1053, %then55 ], [ %t2259, %merge60 ]
  %t2289 = phi { i8**, i64 }* [ %t1004, %then55 ], [ %t2260, %merge60 ]
  %t2290 = phi double [ %t1009, %then55 ], [ %t2269, %merge60 ]
  %t2291 = phi { %MatchContext*, i64 }* [ %t1008, %then55 ], [ %t2271, %merge60 ]
  store %PythonBuilder %t2287, %PythonBuilder* %l0
  store double %t2288, double* %l4
  store { i8**, i64 }* %t2289, { i8**, i64 }** %l1
  store double %t2290, double* %l6
  store { %MatchContext*, i64 }* %t2291, { %MatchContext*, i64 }** %l5
  %t2292 = load %PythonBuilder, %PythonBuilder* %l0
  %t2293 = load %PythonBuilder, %PythonBuilder* %l0
  %t2294 = load double, double* %l4
  %t2295 = load %PythonBuilder, %PythonBuilder* %l0
  %t2296 = load double, double* %l4
  %t2297 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2298 = load %PythonBuilder, %PythonBuilder* %l0
  %t2299 = load %PythonBuilder, %PythonBuilder* %l0
  %t2300 = load double, double* %l4
  %t2301 = load %PythonBuilder, %PythonBuilder* %l0
  %t2302 = load double, double* %l4
  %t2303 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2304 = load %PythonBuilder, %PythonBuilder* %l0
  %t2305 = load %PythonBuilder, %PythonBuilder* %l0
  %t2306 = load double, double* %l6
  %t2307 = load %PythonBuilder, %PythonBuilder* %l0
  %t2308 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2310 = load %PythonBuilder, %PythonBuilder* %l0
  %t2311 = load %PythonBuilder, %PythonBuilder* %l0
  %t2312 = load %PythonBuilder, %PythonBuilder* %l0
  %t2313 = load %PythonBuilder, %PythonBuilder* %l0
  %t2314 = load %PythonBuilder, %PythonBuilder* %l0
  %t2315 = load %PythonBuilder, %PythonBuilder* %l0
  %t2316 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2317 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2318 = load %PythonBuilder, %PythonBuilder* %l0
  %t2319 = load %PythonBuilder, %PythonBuilder* %l0
  %t2320 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2321 = load %PythonBuilder, %PythonBuilder* %l0
  %t2322 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2323 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge51
merge51:
  %t2324 = phi %PythonBuilder [ %t944, %merge54 ], [ %t2292, %merge57 ]
  %t2325 = phi double [ %t945, %merge54 ], [ %t2294, %merge57 ]
  %t2326 = phi { i8**, i64 }* [ %t946, %merge54 ], [ %t2297, %merge57 ]
  %t2327 = phi double [ %t914, %merge54 ], [ %t2306, %merge57 ]
  %t2328 = phi { %MatchContext*, i64 }* [ %t913, %merge54 ], [ %t2308, %merge57 ]
  store %PythonBuilder %t2324, %PythonBuilder* %l0
  store double %t2325, double* %l4
  store { i8**, i64 }* %t2326, { i8**, i64 }** %l1
  store double %t2327, double* %l6
  store { %MatchContext*, i64 }* %t2328, { %MatchContext*, i64 }** %l5
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
  %t2340 = load double, double* %l4
  %t2341 = load %PythonBuilder, %PythonBuilder* %l0
  %t2342 = load double, double* %l4
  %t2343 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2344 = load %PythonBuilder, %PythonBuilder* %l0
  %t2345 = load %PythonBuilder, %PythonBuilder* %l0
  %t2346 = load double, double* %l6
  %t2347 = load %PythonBuilder, %PythonBuilder* %l0
  %t2348 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2349 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2350 = load %PythonBuilder, %PythonBuilder* %l0
  %t2351 = load %PythonBuilder, %PythonBuilder* %l0
  %t2352 = load %PythonBuilder, %PythonBuilder* %l0
  %t2353 = load %PythonBuilder, %PythonBuilder* %l0
  %t2354 = load %PythonBuilder, %PythonBuilder* %l0
  %t2355 = load %PythonBuilder, %PythonBuilder* %l0
  %t2356 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2357 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2358 = load %PythonBuilder, %PythonBuilder* %l0
  %t2359 = load %PythonBuilder, %PythonBuilder* %l0
  %t2360 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2361 = load %PythonBuilder, %PythonBuilder* %l0
  %t2362 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2363 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge45
merge45:
  %t2364 = phi %PythonBuilder [ %t848, %merge48 ], [ %t2329, %merge51 ]
  %t2365 = phi { i8**, i64 }* [ %t849, %merge48 ], [ %t2331, %merge51 ]
  %t2366 = phi double [ %t816, %merge48 ], [ %t2330, %merge51 ]
  %t2367 = phi double [ %t818, %merge48 ], [ %t2346, %merge51 ]
  %t2368 = phi { %MatchContext*, i64 }* [ %t817, %merge48 ], [ %t2348, %merge51 ]
  store %PythonBuilder %t2364, %PythonBuilder* %l0
  store { i8**, i64 }* %t2365, { i8**, i64 }** %l1
  store double %t2366, double* %l4
  store double %t2367, double* %l6
  store { %MatchContext*, i64 }* %t2368, { %MatchContext*, i64 }** %l5
  %t2369 = load %PythonBuilder, %PythonBuilder* %l0
  %t2370 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2371 = load %PythonBuilder, %PythonBuilder* %l0
  %t2372 = load %PythonBuilder, %PythonBuilder* %l0
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
  br label %merge42
merge42:
  %t2408 = phi %PythonBuilder [ %t753, %then40 ], [ %t2369, %merge45 ]
  %t2409 = phi double [ %t755, %then40 ], [ %t2374, %merge45 ]
  %t2410 = phi { i8**, i64 }* [ %t719, %then40 ], [ %t2370, %merge45 ]
  %t2411 = phi double [ %t724, %then40 ], [ %t2390, %merge45 ]
  %t2412 = phi { %MatchContext*, i64 }* [ %t723, %then40 ], [ %t2392, %merge45 ]
  store %PythonBuilder %t2408, %PythonBuilder* %l0
  store double %t2409, double* %l4
  store { i8**, i64 }* %t2410, { i8**, i64 }** %l1
  store double %t2411, double* %l6
  store { %MatchContext*, i64 }* %t2412, { %MatchContext*, i64 }** %l5
  %t2413 = load %PythonBuilder, %PythonBuilder* %l0
  %t2414 = load %PythonBuilder, %PythonBuilder* %l0
  %t2415 = load double, double* %l4
  %t2416 = load %PythonBuilder, %PythonBuilder* %l0
  %t2417 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2418 = load %PythonBuilder, %PythonBuilder* %l0
  %t2419 = load %PythonBuilder, %PythonBuilder* %l0
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
  %t2431 = load double, double* %l4
  %t2432 = load %PythonBuilder, %PythonBuilder* %l0
  %t2433 = load double, double* %l4
  %t2434 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2435 = load %PythonBuilder, %PythonBuilder* %l0
  %t2436 = load %PythonBuilder, %PythonBuilder* %l0
  %t2437 = load double, double* %l6
  %t2438 = load %PythonBuilder, %PythonBuilder* %l0
  %t2439 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2440 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2441 = load %PythonBuilder, %PythonBuilder* %l0
  %t2442 = load %PythonBuilder, %PythonBuilder* %l0
  %t2443 = load %PythonBuilder, %PythonBuilder* %l0
  %t2444 = load %PythonBuilder, %PythonBuilder* %l0
  %t2445 = load %PythonBuilder, %PythonBuilder* %l0
  %t2446 = load %PythonBuilder, %PythonBuilder* %l0
  %t2447 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2448 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2449 = load %PythonBuilder, %PythonBuilder* %l0
  %t2450 = load %PythonBuilder, %PythonBuilder* %l0
  %t2451 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2452 = load %PythonBuilder, %PythonBuilder* %l0
  %t2453 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2454 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge31
merge31:
  %t2455 = phi double [ %t660, %merge34 ], [ %t531, %merge42 ]
  %t2456 = phi %PythonBuilder [ %t661, %merge34 ], [ %t2413, %merge42 ]
  %t2457 = phi double [ %t528, %merge34 ], [ %t2415, %merge42 ]
  %t2458 = phi { i8**, i64 }* [ %t525, %merge34 ], [ %t2417, %merge42 ]
  %t2459 = phi double [ %t530, %merge34 ], [ %t2437, %merge42 ]
  %t2460 = phi { %MatchContext*, i64 }* [ %t529, %merge34 ], [ %t2439, %merge42 ]
  store double %t2455, double* %l7
  store %PythonBuilder %t2456, %PythonBuilder* %l0
  store double %t2457, double* %l4
  store { i8**, i64 }* %t2458, { i8**, i64 }** %l1
  store double %t2459, double* %l6
  store { %MatchContext*, i64 }* %t2460, { %MatchContext*, i64 }** %l5
  %t2461 = load double, double* %l7
  %t2462 = load %PythonBuilder, %PythonBuilder* %l0
  %t2463 = load %PythonBuilder, %PythonBuilder* %l0
  %t2464 = load %PythonBuilder, %PythonBuilder* %l0
  %t2465 = load double, double* %l4
  %t2466 = load %PythonBuilder, %PythonBuilder* %l0
  %t2467 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2468 = load %PythonBuilder, %PythonBuilder* %l0
  %t2469 = load %PythonBuilder, %PythonBuilder* %l0
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
  %t2481 = load double, double* %l4
  %t2482 = load %PythonBuilder, %PythonBuilder* %l0
  %t2483 = load double, double* %l4
  %t2484 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2485 = load %PythonBuilder, %PythonBuilder* %l0
  %t2486 = load %PythonBuilder, %PythonBuilder* %l0
  %t2487 = load double, double* %l6
  %t2488 = load %PythonBuilder, %PythonBuilder* %l0
  %t2489 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2490 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2491 = load %PythonBuilder, %PythonBuilder* %l0
  %t2492 = load %PythonBuilder, %PythonBuilder* %l0
  %t2493 = load %PythonBuilder, %PythonBuilder* %l0
  %t2494 = load %PythonBuilder, %PythonBuilder* %l0
  %t2495 = load %PythonBuilder, %PythonBuilder* %l0
  %t2496 = load %PythonBuilder, %PythonBuilder* %l0
  %t2497 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2498 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2499 = load %PythonBuilder, %PythonBuilder* %l0
  %t2500 = load %PythonBuilder, %PythonBuilder* %l0
  %t2501 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2502 = load %PythonBuilder, %PythonBuilder* %l0
  %t2503 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2504 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge23
merge23:
  %t2505 = phi %PythonBuilder [ %t466, %merge26 ], [ %t2462, %merge31 ]
  %t2506 = phi double [ %t467, %merge26 ], [ %t2461, %merge31 ]
  %t2507 = phi double [ %t373, %merge26 ], [ %t2465, %merge31 ]
  %t2508 = phi { i8**, i64 }* [ %t370, %merge26 ], [ %t2467, %merge31 ]
  %t2509 = phi double [ %t375, %merge26 ], [ %t2487, %merge31 ]
  %t2510 = phi { %MatchContext*, i64 }* [ %t374, %merge26 ], [ %t2489, %merge31 ]
  store %PythonBuilder %t2505, %PythonBuilder* %l0
  store double %t2506, double* %l7
  store double %t2507, double* %l4
  store { i8**, i64 }* %t2508, { i8**, i64 }** %l1
  store double %t2509, double* %l6
  store { %MatchContext*, i64 }* %t2510, { %MatchContext*, i64 }** %l5
  %t2511 = load %PythonBuilder, %PythonBuilder* %l0
  %t2512 = load double, double* %l7
  %t2513 = load double, double* %l7
  %t2514 = load %PythonBuilder, %PythonBuilder* %l0
  %t2515 = load %PythonBuilder, %PythonBuilder* %l0
  %t2516 = load %PythonBuilder, %PythonBuilder* %l0
  %t2517 = load double, double* %l4
  %t2518 = load %PythonBuilder, %PythonBuilder* %l0
  %t2519 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2520 = load %PythonBuilder, %PythonBuilder* %l0
  %t2521 = load %PythonBuilder, %PythonBuilder* %l0
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
  %t2533 = load double, double* %l4
  %t2534 = load %PythonBuilder, %PythonBuilder* %l0
  %t2535 = load double, double* %l4
  %t2536 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2537 = load %PythonBuilder, %PythonBuilder* %l0
  %t2538 = load %PythonBuilder, %PythonBuilder* %l0
  %t2539 = load double, double* %l6
  %t2540 = load %PythonBuilder, %PythonBuilder* %l0
  %t2541 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2542 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2543 = load %PythonBuilder, %PythonBuilder* %l0
  %t2544 = load %PythonBuilder, %PythonBuilder* %l0
  %t2545 = load %PythonBuilder, %PythonBuilder* %l0
  %t2546 = load %PythonBuilder, %PythonBuilder* %l0
  %t2547 = load %PythonBuilder, %PythonBuilder* %l0
  %t2548 = load %PythonBuilder, %PythonBuilder* %l0
  %t2549 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2550 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2551 = load %PythonBuilder, %PythonBuilder* %l0
  %t2552 = load %PythonBuilder, %PythonBuilder* %l0
  %t2553 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2554 = load %PythonBuilder, %PythonBuilder* %l0
  %t2555 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2556 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge12
merge12:
  %t2557 = phi %PythonBuilder [ %t310, %merge15 ], [ %t2511, %merge23 ]
  %t2558 = phi double [ %t312, %merge15 ], [ %t2512, %merge23 ]
  %t2559 = phi double [ %t175, %merge15 ], [ %t2517, %merge23 ]
  %t2560 = phi { i8**, i64 }* [ %t172, %merge15 ], [ %t2519, %merge23 ]
  %t2561 = phi double [ %t177, %merge15 ], [ %t2539, %merge23 ]
  %t2562 = phi { %MatchContext*, i64 }* [ %t176, %merge15 ], [ %t2541, %merge23 ]
  store %PythonBuilder %t2557, %PythonBuilder* %l0
  store double %t2558, double* %l7
  store double %t2559, double* %l4
  store { i8**, i64 }* %t2560, { i8**, i64 }** %l1
  store double %t2561, double* %l6
  store { %MatchContext*, i64 }* %t2562, { %MatchContext*, i64 }** %l5
  %t2563 = load double, double* %l7
  %t2564 = sitofp i64 1 to double
  %t2565 = fadd double %t2563, %t2564
  store double %t2565, double* %l7
  br label %loop.latch6
loop.latch6:
  %t2566 = load %PythonBuilder, %PythonBuilder* %l0
  %t2567 = load double, double* %l7
  %t2568 = load double, double* %l4
  %t2569 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2570 = load double, double* %l6
  %t2571 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t2578 = load %PythonBuilder, %PythonBuilder* %l0
  %t2579 = load double, double* %l7
  %t2580 = load double, double* %l4
  %t2581 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2582 = load double, double* %l6
  %t2583 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2584 = load %PythonBuilder, %PythonBuilder* %l0
  %t2585 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2586 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2587 = load i8*, i8** %l3
  %t2588 = load double, double* %l4
  %t2589 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2590 = load double, double* %l6
  %t2591 = load double, double* %l7
  br label %loop.header111
loop.header111:
  %t2643 = phi %PythonBuilder [ %t2584, %afterloop7 ], [ %t2640, %loop.latch113 ]
  %t2644 = phi { i8**, i64 }* [ %t2585, %afterloop7 ], [ %t2641, %loop.latch113 ]
  %t2645 = phi { %MatchContext*, i64 }* [ %t2589, %afterloop7 ], [ %t2642, %loop.latch113 ]
  store %PythonBuilder %t2643, %PythonBuilder* %l0
  store { i8**, i64 }* %t2644, { i8**, i64 }** %l1
  store { %MatchContext*, i64 }* %t2645, { %MatchContext*, i64 }** %l5
  br label %loop.body112
loop.body112:
  %t2592 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2593 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2592
  %t2594 = extractvalue { %MatchContext*, i64 } %t2593, 1
  %t2595 = icmp eq i64 %t2594, 0
  %t2596 = load %PythonBuilder, %PythonBuilder* %l0
  %t2597 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2598 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2599 = load i8*, i8** %l3
  %t2600 = load double, double* %l4
  %t2601 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2602 = load double, double* %l6
  %t2603 = load double, double* %l7
  br i1 %t2595, label %then115, label %merge116
then115:
  br label %afterloop114
merge116:
  %t2604 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2605 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2604
  %t2606 = extractvalue { %MatchContext*, i64 } %t2605, 1
  %t2607 = sub i64 %t2606, 1
  store i64 %t2607, i64* %l38
  %t2608 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2609 = load i64, i64* %l38
  %t2610 = load { %MatchContext*, i64 }, { %MatchContext*, i64 }* %t2608
  %t2611 = extractvalue { %MatchContext*, i64 } %t2610, 0
  %t2612 = extractvalue { %MatchContext*, i64 } %t2610, 1
  %t2613 = icmp uge i64 %t2609, %t2612
  ; bounds check: %t2613 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t2609, i64 %t2612)
  %t2614 = getelementptr %MatchContext, %MatchContext* %t2611, i64 %t2609
  %t2615 = load %MatchContext, %MatchContext* %t2614
  store %MatchContext %t2615, %MatchContext* %l39
  %t2616 = load %MatchContext, %MatchContext* %l39
  %t2617 = extractvalue %MatchContext %t2616, 2
  %t2618 = load %PythonBuilder, %PythonBuilder* %l0
  %t2619 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2620 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2621 = load i8*, i8** %l3
  %t2622 = load double, double* %l4
  %t2623 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2624 = load double, double* %l6
  %t2625 = load double, double* %l7
  %t2626 = load i64, i64* %l38
  %t2627 = load %MatchContext, %MatchContext* %l39
  br i1 %t2617, label %then117, label %merge118
then117:
  %t2628 = load %PythonBuilder, %PythonBuilder* %l0
  %t2629 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2628)
  store %PythonBuilder %t2629, %PythonBuilder* %l0
  %t2630 = load %PythonBuilder, %PythonBuilder* %l0
  br label %merge118
merge118:
  %t2631 = phi %PythonBuilder [ %t2630, %then117 ], [ %t2618, %merge116 ]
  store %PythonBuilder %t2631, %PythonBuilder* %l0
  %t2632 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2633 = extractvalue %NativeFunction %function, 0
  %s2634 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1409903806, i32 0, i32 0
  %t2635 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2632, i8* %t2633, i8* %s2634)
  store { i8**, i64 }* %t2635, { i8**, i64 }** %l1
  %t2636 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2637 = load i64, i64* %l38
  %t2638 = sitofp i64 %t2637 to double
  %t2639 = call { %MatchContext*, i64 }* @truncate_match_contexts({ %MatchContext*, i64 }* %t2636, double %t2638)
  store { %MatchContext*, i64 }* %t2639, { %MatchContext*, i64 }** %l5
  br label %loop.latch113
loop.latch113:
  %t2640 = load %PythonBuilder, %PythonBuilder* %l0
  %t2641 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2642 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  br label %loop.header111
afterloop114:
  %t2646 = load %PythonBuilder, %PythonBuilder* %l0
  %t2647 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2648 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2649 = load %PythonBuilder, %PythonBuilder* %l0
  %t2650 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2651 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2652 = load i8*, i8** %l3
  %t2653 = load double, double* %l4
  %t2654 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2655 = load double, double* %l6
  %t2656 = load double, double* %l7
  br label %loop.header119
loop.header119:
  %t2680 = phi %PythonBuilder [ %t2649, %afterloop114 ], [ %t2677, %loop.latch121 ]
  %t2681 = phi double [ %t2653, %afterloop114 ], [ %t2678, %loop.latch121 ]
  %t2682 = phi { i8**, i64 }* [ %t2650, %afterloop114 ], [ %t2679, %loop.latch121 ]
  store %PythonBuilder %t2680, %PythonBuilder* %l0
  store double %t2681, double* %l4
  store { i8**, i64 }* %t2682, { i8**, i64 }** %l1
  br label %loop.body120
loop.body120:
  %t2657 = load double, double* %l4
  %t2658 = sitofp i64 0 to double
  %t2659 = fcmp ole double %t2657, %t2658
  %t2660 = load %PythonBuilder, %PythonBuilder* %l0
  %t2661 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2662 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t2663 = load i8*, i8** %l3
  %t2664 = load double, double* %l4
  %t2665 = load { %MatchContext*, i64 }*, { %MatchContext*, i64 }** %l5
  %t2666 = load double, double* %l6
  %t2667 = load double, double* %l7
  br i1 %t2659, label %then123, label %merge124
then123:
  br label %afterloop122
merge124:
  %t2668 = load %PythonBuilder, %PythonBuilder* %l0
  %t2669 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2668)
  store %PythonBuilder %t2669, %PythonBuilder* %l0
  %t2670 = load double, double* %l4
  %t2671 = sitofp i64 1 to double
  %t2672 = fsub double %t2670, %t2671
  store double %t2672, double* %l4
  %t2673 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2674 = extractvalue %NativeFunction %function, 0
  %s2675 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1736570074, i32 0, i32 0
  %t2676 = call { i8**, i64 }* @append_lowering_diagnostic({ i8**, i64 }* %t2673, i8* %t2674, i8* %s2675)
  store { i8**, i64 }* %t2676, { i8**, i64 }** %l1
  br label %loop.latch121
loop.latch121:
  %t2677 = load %PythonBuilder, %PythonBuilder* %l0
  %t2678 = load double, double* %l4
  %t2679 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %loop.header119
afterloop122:
  %t2683 = load %PythonBuilder, %PythonBuilder* %l0
  %t2684 = load double, double* %l4
  %t2685 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2686 = load %PythonBuilder, %PythonBuilder* %l0
  %t2687 = call %PythonBuilder @builder_pop_indent(%PythonBuilder %t2686)
  store %PythonBuilder %t2687, %PythonBuilder* %l0
  %t2688 = load %PythonBuilder, %PythonBuilder* %l0
  %t2689 = insertvalue %PythonFunctionEmission undef, %PythonBuilder %t2688, 0
  %t2690 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t2691 = insertvalue %PythonFunctionEmission %t2689, { i8**, i64 }* %t2690, 1
  ret %PythonFunctionEmission %t2691
}

define { %MatchContext*, i64 }* @append_match_context({ %MatchContext*, i64 }* %values, %MatchContext %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %MatchContext*
  store %MatchContext %value, %MatchContext* %t1
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %t0, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
  %t15 = bitcast { %MatchContext*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %MatchContext*, i64 }*
  ret { %MatchContext*, i64 }* %t17
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
  %t56 = alloca [2 x i8], align 1
  %t57 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  store i8 40, i8* %t57
  %t58 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 1
  store i8 0, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t56, i32 0, i32 0
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t59, i8* %t55)
  %s61 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1543377657, i32 0, i32 0
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t60, i8* %s61)
  %t63 = load i8*, i8** %l7
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t62, i8* %t63)
  %t65 = alloca [2 x i8], align 1
  %t66 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  store i8 41, i8* %t66
  %t67 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 1
  store i8 0, i8* %t67
  %t68 = getelementptr [2 x i8], [2 x i8]* %t65, i32 0, i32 0
  %t69 = call i8* @sailfin_runtime_string_concat(i8* %t64, i8* %t68)
  store i8* %t69, i8** %l5
  store i1 1, i1* %l6
  %t70 = load i8*, i8** %l5
  %t71 = load i1, i1* %l6
  br label %merge9
merge9:
  %t72 = phi i8* [ %t70, %then8 ], [ %t51, %merge5 ]
  %t73 = phi i1 [ %t71, %then8 ], [ %t52, %merge5 ]
  store i8* %t72, i8** %l5
  store i1 %t73, i1* %l6
  %t74 = load i8*, i8** %l5
  %t75 = insertvalue %LoweredCaseCondition undef, i8* %t74, 0
  %t76 = insertvalue %LoweredCaseCondition %t75, i1 0, 1
  %t77 = load i1, i1* %l6
  %t78 = insertvalue %LoweredCaseCondition %t76, i1 %t77, 2
  ret %LoweredCaseCondition %t78
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
  %t2 = alloca [2 x i8], align 1
  %t3 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  store i8 48, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 1
  store i8 0, i8* %t4
  %t5 = getelementptr [2 x i8], [2 x i8]* %t2, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %t5)
  ret i8* %t5
merge1:
  %s6 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h626550212, i32 0, i32 0
  store i8* %s6, i8** %l0
  store double %value, double* %l1
  %s7 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s7, i8** %l2
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  %t10 = load i8*, i8** %l2
  br label %loop.header2
loop.header2:
  %t61 = phi i8* [ %t10, %merge1 ], [ %t59, %loop.latch4 ]
  %t62 = phi double [ %t9, %merge1 ], [ %t60, %loop.latch4 ]
  store i8* %t61, i8** %l2
  store double %t62, double* %l1
  br label %loop.body3
loop.body3:
  %t11 = load double, double* %l1
  %t12 = sitofp i64 0 to double
  %t13 = fcmp ole double %t11, %t12
  %t14 = load i8*, i8** %l0
  %t15 = load double, double* %l1
  %t16 = load i8*, i8** %l2
  br i1 %t13, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t17 = load double, double* %l1
  store double %t17, double* %l3
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l4
  %t19 = load i8*, i8** %l0
  %t20 = load double, double* %l1
  %t21 = load i8*, i8** %l2
  %t22 = load double, double* %l3
  %t23 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t40 = phi double [ %t22, %merge7 ], [ %t38, %loop.latch10 ]
  %t41 = phi double [ %t23, %merge7 ], [ %t39, %loop.latch10 ]
  store double %t40, double* %l3
  store double %t41, double* %l4
  br label %loop.body9
loop.body9:
  %t24 = load double, double* %l3
  %t25 = sitofp i64 10 to double
  %t26 = fcmp olt double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = load i8*, i8** %l2
  %t30 = load double, double* %l3
  %t31 = load double, double* %l4
  br i1 %t26, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t32 = load double, double* %l3
  %t33 = sitofp i64 10 to double
  %t34 = fsub double %t32, %t33
  store double %t34, double* %l3
  %t35 = load double, double* %l4
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l4
  br label %loop.latch10
loop.latch10:
  %t38 = load double, double* %l3
  %t39 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t42 = load double, double* %l3
  %t43 = load double, double* %l4
  %t44 = load double, double* %l3
  store double %t44, double* %l5
  %t45 = load i8*, i8** %l0
  %t46 = load double, double* %l5
  %t47 = load double, double* %l5
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  %t50 = call double @llvm.round.f64(double %t46)
  %t51 = fptosi double %t50 to i64
  %t52 = call double @llvm.round.f64(double %t49)
  %t53 = fptosi double %t52 to i64
  %t54 = call i8* @sailfin_runtime_substring(i8* %t45, i64 %t51, i64 %t53)
  store i8* %t54, i8** %l6
  %t55 = load i8*, i8** %l6
  %t56 = load i8*, i8** %l2
  %t57 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t56)
  store i8* %t57, i8** %l2
  %t58 = load double, double* %l4
  store double %t58, double* %l1
  br label %loop.latch4
loop.latch4:
  %t59 = load i8*, i8** %l2
  %t60 = load double, double* %l1
  br label %loop.header2
afterloop5:
  %t63 = load i8*, i8** %l2
  %t64 = load double, double* %l1
  %t65 = load i8*, i8** %l2
  call void @sailfin_runtime_mark_persistent(i8* %t65)
  ret i8* %t65
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
  %t1 = alloca [2 x i8], align 1
  %t2 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  store i8 10, i8* %t2
  %t3 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 1
  store i8 0, i8* %t3
  %t4 = getelementptr [2 x i8], [2 x i8]* %t1, i32 0, i32 0
  %t5 = call i8* @join_with_separator({ i8**, i64 }* %t0, i8* %t4)
  store i8* %t5, i8** %l0
  %t6 = load i8*, i8** %l0
  %t7 = call i64 @sailfin_runtime_string_length(i8* %t6)
  %t8 = icmp eq i64 %t7, 0
  %t9 = load i8*, i8** %l0
  br i1 %t8, label %then0, label %merge1
then0:
  %s10 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s10)
  ret i8* %s10
merge1:
  %t11 = load i8*, i8** %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 10, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call i8* @sailfin_runtime_string_concat(i8* %t11, i8* %t15)
  call void @sailfin_runtime_mark_persistent(i8* %t16)
  ret i8* %t16
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
  %t52 = phi i8* [ %t2, %block.entry ], [ %t50, %loop.latch2 ]
  %t53 = phi double [ %t3, %block.entry ], [ %t51, %loop.latch2 ]
  store i8* %t52, i8** %l0
  store double %t53, double* %l1
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
  %t16 = alloca [2 x i8], align 1
  %t17 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  store i8 %t15, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 1
  store i8 0, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  %t20 = call i1 @is_identifier_char(i8* %t19)
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load i8, i8* %l2
  br i1 %t20, label %then6, label %else7
then6:
  %t24 = load i8*, i8** %l0
  %t25 = load i8, i8* %l2
  %t26 = alloca [2 x i8], align 1
  %t27 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  store i8 %t25, i8* %t27
  %t28 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 1
  store i8 0, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t26, i32 0, i32 0
  %t30 = call i8* @sailfin_runtime_string_concat(i8* %t24, i8* %t29)
  store i8* %t30, i8** %l0
  %t31 = load i8*, i8** %l0
  br label %merge8
else7:
  %t32 = load i8, i8* %l2
  %t33 = icmp eq i8 %t32, 32
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load i8, i8* %l2
  br i1 %t33, label %then9, label %merge10
then9:
  %t37 = load i8*, i8** %l0
  %t38 = alloca [2 x i8], align 1
  %t39 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  store i8 95, i8* %t39
  %t40 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 1
  store i8 0, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t38, i32 0, i32 0
  %t42 = call i8* @sailfin_runtime_string_concat(i8* %t37, i8* %t41)
  store i8* %t42, i8** %l0
  %t43 = load i8*, i8** %l0
  br label %merge10
merge10:
  %t44 = phi i8* [ %t43, %then9 ], [ %t34, %else7 ]
  store i8* %t44, i8** %l0
  %t45 = load i8*, i8** %l0
  br label %merge8
merge8:
  %t46 = phi i8* [ %t31, %then6 ], [ %t45, %merge10 ]
  store i8* %t46, i8** %l0
  %t47 = load double, double* %l1
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l1
  br label %loop.latch2
loop.latch2:
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load i8*, i8** %l0
  %t57 = call i64 @sailfin_runtime_string_length(i8* %t56)
  %t58 = icmp eq i64 %t57, 0
  %t59 = load i8*, i8** %l0
  %t60 = load double, double* %l1
  br i1 %t58, label %then11, label %merge12
then11:
  %s61 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1387621460, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s61)
  ret i8* %s61
merge12:
  %t62 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t62)
  ret i8* %t62
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
  %t82 = phi { i8**, i64 }* [ %t23, %merge1 ], [ %t79, %loop.latch4 ]
  %t83 = phi i8* [ %t22, %merge1 ], [ %t80, %loop.latch4 ]
  %t84 = phi double [ %t24, %merge1 ], [ %t81, %loop.latch4 ]
  store { i8**, i64 }* %t82, { i8**, i64 }** %l2
  store i8* %t83, i8** %l1
  store double %t84, double* %l3
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
  %t68 = alloca [2 x i8], align 1
  %t69 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  store i8 %t67, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 1
  store i8 0, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t68, i32 0, i32 0
  %t72 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t71)
  store i8* %t72, i8** %l1
  %t73 = load i8*, i8** %l1
  br label %merge10
merge10:
  %t74 = phi { i8**, i64 }* [ %t64, %merge12 ], [ %t44, %else9 ]
  %t75 = phi i8* [ %t65, %merge12 ], [ %t73, %else9 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l2
  store i8* %t75, i8** %l1
  %t76 = load double, double* %l3
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %t76, %t77
  store double %t78, double* %l3
  br label %loop.latch4
loop.latch4:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = load i8*, i8** %l1
  %t87 = load double, double* %l3
  %t88 = load i8*, i8** %l1
  %t89 = call i64 @sailfin_runtime_string_length(i8* %t88)
  %t90 = icmp sgt i64 %t89, 0
  %t91 = load i8*, i8** %l0
  %t92 = load i8*, i8** %l1
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t94 = load double, double* %l3
  br i1 %t90, label %then13, label %merge14
then13:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t96 = load i8*, i8** %l1
  %t97 = call i8* @sanitize_identifier(i8* %t96)
  %t98 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t95, i8* %t97)
  store { i8**, i64 }* %t98, { i8**, i64 }** %l2
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge14
merge14:
  %t100 = phi { i8**, i64 }* [ %t99, %then13 ], [ %t93, %afterloop5 ]
  store { i8**, i64 }* %t100, { i8**, i64 }** %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t102 = load { i8**, i64 }, { i8**, i64 }* %t101
  %t103 = extractvalue { i8**, i64 } %t102, 1
  %t104 = icmp eq i64 %t103, 0
  %t105 = load i8*, i8** %l0
  %t106 = load i8*, i8** %l1
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t108 = load double, double* %l3
  br i1 %t104, label %then15, label %merge16
then15:
  %t109 = load i8*, i8** %l0
  %t110 = call i8* @sanitize_identifier(i8* %t109)
  call void @sailfin_runtime_mark_persistent(i8* %t110)
  ret i8* %t110
merge16:
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t112 = alloca [2 x i8], align 1
  %t113 = getelementptr [2 x i8], [2 x i8]* %t112, i32 0, i32 0
  store i8 46, i8* %t113
  %t114 = getelementptr [2 x i8], [2 x i8]* %t112, i32 0, i32 1
  store i8 0, i8* %t114
  %t115 = getelementptr [2 x i8], [2 x i8]* %t112, i32 0, i32 0
  %t116 = call i8* @join_with_separator({ i8**, i64 }* %t111, i8* %t115)
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
  %t5 = alloca [2 x i8], align 1
  %t6 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  store i8 97, i8* %t6
  %t7 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 1
  store i8 0, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t5, i32 0, i32 0
  %t9 = call double @char_code(i8* %t8)
  %t10 = fcmp oge double %t4, %t9
  br label %logical_and_entry_3

logical_and_entry_3:
  br i1 %t10, label %logical_and_right_3, label %logical_and_merge_3

logical_and_right_3:
  %t11 = load double, double* %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 122, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call double @char_code(i8* %t15)
  %t17 = fcmp ole double %t11, %t16
  br label %logical_and_right_end_3

logical_and_right_end_3:
  br label %logical_and_merge_3

logical_and_merge_3:
  %t18 = phi i1 [ false, %logical_and_entry_3 ], [ %t17, %logical_and_right_end_3 ]
  %t19 = load double, double* %l0
  br i1 %t18, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t21 = load double, double* %l0
  %t22 = alloca [2 x i8], align 1
  %t23 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  store i8 65, i8* %t23
  %t24 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 1
  store i8 0, i8* %t24
  %t25 = getelementptr [2 x i8], [2 x i8]* %t22, i32 0, i32 0
  %t26 = call double @char_code(i8* %t25)
  %t27 = fcmp oge double %t21, %t26
  br label %logical_and_entry_20

logical_and_entry_20:
  br i1 %t27, label %logical_and_right_20, label %logical_and_merge_20

logical_and_right_20:
  %t28 = load double, double* %l0
  %t29 = alloca [2 x i8], align 1
  %t30 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  store i8 90, i8* %t30
  %t31 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 1
  store i8 0, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t29, i32 0, i32 0
  %t33 = call double @char_code(i8* %t32)
  %t34 = fcmp ole double %t28, %t33
  br label %logical_and_right_end_20

logical_and_right_end_20:
  br label %logical_and_merge_20

logical_and_merge_20:
  %t35 = phi i1 [ false, %logical_and_entry_20 ], [ %t34, %logical_and_right_end_20 ]
  %t36 = load double, double* %l0
  br i1 %t35, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t38 = load double, double* %l0
  %t39 = alloca [2 x i8], align 1
  %t40 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  store i8 48, i8* %t40
  %t41 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 1
  store i8 0, i8* %t41
  %t42 = getelementptr [2 x i8], [2 x i8]* %t39, i32 0, i32 0
  %t43 = call double @char_code(i8* %t42)
  %t44 = fcmp oge double %t38, %t43
  br label %logical_and_entry_37

logical_and_entry_37:
  br i1 %t44, label %logical_and_right_37, label %logical_and_merge_37

logical_and_right_37:
  %t45 = load double, double* %l0
  %t46 = alloca [2 x i8], align 1
  %t47 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  store i8 57, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 1
  store i8 0, i8* %t48
  %t49 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  %t50 = call double @char_code(i8* %t49)
  %t51 = fcmp ole double %t45, %t50
  br label %logical_and_right_end_37

logical_and_right_end_37:
  br label %logical_and_merge_37

logical_and_merge_37:
  %t52 = phi i1 [ false, %logical_and_entry_37 ], [ %t51, %logical_and_right_end_37 ]
  %t53 = load double, double* %l0
  br i1 %t52, label %then6, label %merge7
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
@.str.len5.h2095430042 = private unnamed_addr constant [6 x i8] c"false\00"
@.str.len5.h1776141546 = private unnamed_addr constant [6 x i8] c") + (\00"
@.str.len22.h1038501153 = private unnamed_addr constant [23 x i8] c"runtime.struct_field('\00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len4.h217223495 = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len4.h219990644 = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len11.h1898426375 = private unnamed_addr constant [12 x i8] c"while True:\00"
@.str.len4.h230767751 = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len4.h265982546 = private unnamed_addr constant [5 x i8] c"len(\00"
@.str.len2.h193480949 = private unnamed_addr constant [3 x i8] c"\5Cr\00"
@.str.len7.h1543377657 = private unnamed_addr constant [8 x i8] c") and (\00"
@.str.len32.h1370567591 = private unnamed_addr constant [33 x i8] c"endfor without matching for loop\00"
@.str.len39.h2079567388 = private unnamed_addr constant [40 x i8] c"match case without active match context\00"
@.str.len11.h1460619898 = private unnamed_addr constant [12 x i8] c" (pattern: \00"
@.str.len29.h1122035900 = private unnamed_addr constant [30 x i8] c"endloop without matching loop\00"
@.str.len2.h193481015 = private unnamed_addr constant [3 x i8] c"\5Ct\00"
@.str.len5.h2069574674 = private unnamed_addr constant [6 x i8] c"else:\00"
@.str.len5.h468448796 = private unnamed_addr constant [6 x i8] c"=None\00"
@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len20.h728584192 = private unnamed_addr constant [21 x i8] c"runtime.enum_field('\00"
@.str.len10.h1977847647 = private unnamed_addr constant [11 x i8] c"index += 1\00"
@.str.len41.h1804821690 = private unnamed_addr constant [42 x i8] c"# unsupported: match case without context\00"
@.str.len4.h270590402 = private unnamed_addr constant [5 x i8] c"pass\00"
@.str.len29.h1409903806 = private unnamed_addr constant [30 x i8] c"unterminated match expression\00"
@.str.len42.h9444846 = private unnamed_addr constant [43 x i8] c"unsupported instruction emitted as comment\00"
@.str.len29.h610920064 = private unnamed_addr constant [30 x i8] c"if index >= len(self.fields):\00"
@.str.len15.h1983072220 = private unnamed_addr constant [16 x i8] c"# unsupported: \00"
@.str.len3.h2090359129 = private unnamed_addr constant [4 x i8] c"if \00"
@.str.len8.h267355070 = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len11.h1779553665 = private unnamed_addr constant [12 x i8] c"# effects: \00"
@.str.len3.h2089113841 = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len39.h198700275 = private unnamed_addr constant [40 x i8] c"# unsupported: endmatch without context\00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len6.h1258614714 = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len5.h461434216 = private unnamed_addr constant [6 x i8] c"self.\00"
@.str.len5.h843097466 = private unnamed_addr constant [6 x i8] c"False\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len28.h430828782 = private unnamed_addr constant [29 x i8] c"def __getattr__(self, item):\00"
@.str.len5.h1503489441 = private unnamed_addr constant [6 x i8] c" and \00"
@.str.len25.h117462910 = private unnamed_addr constant [26 x i8] c"runtime.enum_instantiate(\00"
@.str.len4.h173287691 = private unnamed_addr constant [5 x i8] c"    \00"
@.str.len7.h739212033 = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len18.h1387621460 = private unnamed_addr constant [19 x i8] c"generated_function\00"
@.str.len8.h104511138 = private unnamed_addr constant [9 x i8] c"', self.\00"
@.str.len26.h1984174475 = private unnamed_addr constant [27 x i8] c"raise AttributeError(item)\00"
@.str.len37.h314404344 = private unnamed_addr constant [38 x i8] c"endmatch without active match context\00"
@.str.len31.h1736570074 = private unnamed_addr constant [32 x i8] c"unterminated control-flow block\00"
@.str.len26.h1088202076 = private unnamed_addr constant [27 x i8] c"field = self.fields[index]\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len7.h1558772342 = private unnamed_addr constant [8 x i8] c".length\00"
@.str.len6.h653919037 = private unnamed_addr constant [7 x i8] c"', [])\00"
@.str.len4.h230766299 = private unnamed_addr constant [5 x i8] c"None\00"
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len2.h193428644 = private unnamed_addr constant [3 x i8] c"./\00"
@.str.len31.h568140000 = private unnamed_addr constant [32 x i8] c" = runtime.enum_define_variant(\00"
@.str.len2.h193419635 = private unnamed_addr constant [3 x i8] c"&&\00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len24.h2028465620 = private unnamed_addr constant [25 x i8] c"else without matching if\00"
@.str.len5.h706445588 = private unnamed_addr constant [6 x i8] c"Break\00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.str.len10.h1629914700 = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len12.h300877395 = private unnamed_addr constant [13 x i8] c"EnumInstance\00"
@.str.len8.h757831264 = private unnamed_addr constant [9 x i8] c".concat(\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len7.h919609845 = private unnamed_addr constant [8 x i8] c"import \00"
@.str.len8.h794378208 = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len4.h268929446 = private unnamed_addr constant [5 x i8] c"null\00"
@.str.len9.h320851598 = private unnamed_addr constant [10 x i8] c"index = 0\00"
@.str.len2.h193414949 = private unnamed_addr constant [3 x i8] c"!=\00"
@.str.len5.h819045845 = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len15.h1309566598 = private unnamed_addr constant [16 x i8] c"compiler.build.\00"
@.str.len25.h458257002 = private unnamed_addr constant [26 x i8] c"endif without matching if\00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len5.h2069215535 = private unnamed_addr constant [6 x i8] c"elif \00"
@.str.len4.h268720028 = private unnamed_addr constant [5 x i8] c"not \00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len2.h193479167 = private unnamed_addr constant [3 x i8] c"[]\00"
@.str.len4.h228395909 = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len2.h193516127 = private unnamed_addr constant [3 x i8] c"||\00"
@.str.len2.h193478474 = private unnamed_addr constant [3 x i8] c"\5C'\00"
@.str.len4.h237997259 = private unnamed_addr constant [5 x i8] c"True\00"
@.str.len2.h193459862 = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len9.h757580446 = private unnamed_addr constant [10 x i8] c"#element:\00"
@.str.len4.h275946731 = private unnamed_addr constant [5 x i8] c"true\00"
@.str.len8.h2085806463 = private unnamed_addr constant [9 x i8] c"runtime/\00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len6.h536277508 = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len2.h193517249 = private unnamed_addr constant [3 x i8] c"}}\00"
@.str.len22.h983476432 = private unnamed_addr constant [23 x i8] c"if field.name == item:\00"
@.str.len2.h193480817 = private unnamed_addr constant [3 x i8] c"\5Cn\00"
@.str.len39.h1262256381 = private unnamed_addr constant [40 x i8] c"no sailfin-native-text artifact present\00"
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len6.h1061063223 = private unnamed_addr constant [7 x i8] c"return\00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len2.h193515005 = private unnamed_addr constant [3 x i8] c"{{\00"
@.str.len4.h176216012 = private unnamed_addr constant [5 x i8] c" or \00"
@.str.len3.h2087691079 = private unnamed_addr constant [4 x i8] c" = \00"
@.str.len7.h48777630 = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len2.h193441217 = private unnamed_addr constant [3 x i8] c": \00"
@.str.len5.h1117315388 = private unnamed_addr constant [6 x i8] c"Match\00"
@.str.len3.h2088090973 = private unnamed_addr constant [4 x i8] c", '\00"
@.str.len18.h1456282769 = private unnamed_addr constant [19 x i8] c"return field.value\00"
@.str.len3.h2087924125 = private unnamed_addr constant [4 x i8] c"', \00"
@.str.len2.h193480223 = private unnamed_addr constant [3 x i8] c"\5C\5C\00"
@.str.len4.h259230482 = private unnamed_addr constant [5 x i8] c"for \00"