; ModuleID = 'sailfin'
source_filename = "sailfin"

%SourceSpan = type opaque
%TypeAnnotation = type opaque
%Expression = type opaque
%Statement = type opaque
%NativeSourceSpan = type { double, double, double, double }
%NativeParameter = type { i8*, i8*, i1, i8*, %NativeSourceSpan* }
%NativeFunction = type { i8*, { %NativeParameter**, i64 }*, i8*, { i8**, i64 }*, { %NativeInstruction**, i64 }* }
%NativeImportSpecifier = type { i8*, i8* }
%NativeImport = type { i8*, i8*, { %NativeImportSpecifier**, i64 }* }
%NativeStructField = type { i8*, i8*, i1 }
%NativeStructLayoutField = type { i8*, i8*, double, double, double }
%NativeStructLayout = type { double, double, { %NativeStructLayoutField**, i64 }* }
%NativeStruct = type { i8*, { %NativeStructField**, i64 }*, { %NativeFunction**, i64 }*, { i8**, i64 }*, %NativeStructLayout* }
%NativeInterfaceSignature = type { i8*, i1, { i8**, i64 }*, { %NativeParameter**, i64 }*, i8*, { i8**, i64 }* }
%NativeInterface = type { i8*, { i8**, i64 }*, { %NativeInterfaceSignature**, i64 }* }
%NativeEnumVariantField = type { i8*, i8*, i1 }
%NativeEnumVariant = type { i8*, { %NativeEnumVariantField**, i64 }* }
%NativeEnumVariantLayout = type { i8*, double, double, double, double, { %NativeStructLayoutField**, i64 }* }
%NativeEnumLayout = type { double, double, i8*, double, double, { %NativeEnumVariantLayout**, i64 }* }
%NativeEnum = type { i8*, { %NativeEnumVariant**, i64 }*, %NativeEnumLayout* }
%NativeBinding = type { i8*, i1, i8*, i8* }
%EnumParseResult = type { %NativeEnum*, double, { i8**, i64 }* }
%CaseComponents = type { i8*, i8* }
%InstructionParseResult = type { { %NativeInstruction**, i64 }*, i1, i1 }
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
%ParseNativeResult = type { { %NativeFunction**, i64 }*, { %NativeImport**, i64 }*, { %NativeStruct**, i64 }*, { %NativeInterface**, i64 }*, { %NativeEnum**, i64 }*, { %NativeBinding**, i64 }*, { i8**, i64 }* }
%EnumLayoutHeaderParse = type { i1, i8*, double, double, i8*, double, double, { i8**, i64 }* }
%EnumLayoutVariantParse = type { i1, %NativeEnumVariantLayout, { i8**, i64 }* }
%EnumLayoutPayloadParse = type { i1, i8*, %NativeStructLayoutField, { i8**, i64 }* }
%NumberParseResult = type { i1, double }
%LayoutManifest = type { { %NativeStruct**, i64 }*, { %NativeEnum**, i64 }*, { i8**, i64 }* }
%BindingComponents = type { i8*, i8*, i8* }
%NativeArtifact = type { i8*, i8*, i8* }
%NativeModule = type { { %NativeArtifact**, i64 }*, { i8**, i64 }*, double }
%EmitNativeResult = type { %NativeModule, { i8**, i64 }* }
%TextBuilder = type { { i8**, i64 }*, double }
%NativeState = type { %TextBuilder, { i8**, i64 }*, %LayoutContext }
%LayoutEmitResult = type { { i8**, i64 }*, { i8**, i64 }* }
%StructFieldLayoutDescriptor = type { i8*, i8*, double, double, double }
%RecordLayoutResult = type { double, double, { %StructFieldLayoutDescriptor**, i64 }*, { i8**, i64 }* }
%EnumVariantLayoutDescriptor = type { i8*, double, double, double, double, { %StructFieldLayoutDescriptor**, i64 }* }
%EnumAggregateLayout = type { double, double, double, double, { %EnumVariantLayoutDescriptor**, i64 }*, { i8**, i64 }* }
%TypeLayoutInfo = type { double, double, { i8**, i64 }* }
%LayoutFieldInput = type { i8*, i8* }
%LayoutStructDefinition = type { i8*, { %LayoutFieldInput**, i64 }* }
%LayoutEnumVariantDefinition = type { i8*, { %LayoutFieldInput**, i64 }* }
%LayoutEnumDefinition = type { i8*, { %LayoutEnumVariantDefinition**, i64 }* }
%CanonicalTypeLayout = type { i8*, double, double }
%LayoutContext = type { { %LayoutStructDefinition**, i64 }*, { %LayoutEnumDefinition**, i64 }* }

%NativeInstruction = type { i32, [48 x i8] }

declare void @sailfin_runtime_bounds_check(i64, i64)
declare i8* @sailfin_runtime_substring(i8*, i64, i64)
declare i64 @sailfin_runtime_string_length(i8*)
declare i8* @sailfin_runtime_string_concat(i8*, i8*)
declare i1 @strings_equal(i8*, i8*)
declare double @char_code(i8*)
declare { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }*, i8*)
declare { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }*, { i8**, i64 }*)
declare i8* @sailfin_runtime_get_field(i8*, i8*)

declare %LayoutContext @build_layout_context(i8*)
declare %EmitNativeResult @emit_native(i8*)
declare %NativeState @emit_statement(%NativeState, i8*)
declare i8* @render_native_specifiers({ i8**, i64 }*)
declare i8* @render_export_specifiers({ i8**, i64 }*)
declare i8* @format_native_specifier(i8*, i8*)
declare %NativeState @emit_span_if_present(%NativeState, %SourceSpan*)
declare %NativeState @emit_initializer_span_if_present(%NativeState, %SourceSpan*)
declare i8* @append_optional_type_annotation(i8*, %TypeAnnotation*)
declare i8* @append_optional_initializer(i8*, %Expression*)
declare i8* @format_span(i8*)
declare %NativeState @emit_variable(%NativeState, i8*)
declare %NativeState @emit_function(%NativeState, i8*, i8*, { i8**, i64 }*)
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
declare %NativeState @emit_decorators(%NativeState, { i8**, i64 }*)
declare %NativeState @emit_signature_metadata(%NativeState, i8*)
declare %NativeState @emit_parameter_metadata(%NativeState, { i8**, i64 }*)
declare i8* @format_decorator(i8*)
declare i8* @format_function_signature(i8*)
declare i8* @format_parameters({ i8**, i64 }*)
declare i8* @format_type_parameters({ i8**, i64 }*)
declare i8* @format_field(i8*)
declare i8* @format_enum_variant(i8*)
declare %LayoutEmitResult @compute_struct_layout_lines(%LayoutContext, i8*, { i8**, i64 }*)
declare %LayoutEmitResult @compute_enum_layout_lines(%LayoutContext, i8*)
declare %EnumAggregateLayout @infer_enum_aggregate_layout(%LayoutContext, i8*, { %LayoutEnumVariantDefinition*, i64 }*, { i8**, i64 }*)
declare %RecordLayoutResult @calculate_record_layout(%LayoutContext, { %LayoutFieldInput*, i64 }*, i8*, i8*, { i8**, i64 }*)
declare %TypeLayoutInfo @analyze_type_layout(%LayoutContext, { i8**, i64 }*, i8*, i8*, i8*, i8*)
declare { %LayoutFieldInput*, i64 }* @convert_struct_fields({ i8**, i64 }*)
declare { %LayoutFieldInput*, i64 }* @convert_variant_fields(i8*)
declare { %StructFieldLayoutDescriptor*, i64 }* @append_struct_field_layout({ %StructFieldLayoutDescriptor*, i64 }*, %StructFieldLayoutDescriptor)
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
declare i1 @ends_with(i8*, i8*)
declare i8* @number_to_string(double)
declare i8* @format_expression(i8*)
declare i8* @format_array_expression({ i8**, i64 }*)
declare i8* @infer_array_element_type({ i8**, i64 }*)
declare i8* @infer_expression_type(i8*)
declare i8* @quote_string(i8*)
declare i8* @escape_string_char(i8*)
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
declare %TextBuilder @builder_new()
declare %TextBuilder @builder_emit_line(%TextBuilder, i8*)
declare %TextBuilder @builder_emit_blank(%TextBuilder)
declare %TextBuilder @builder_push_indent(%TextBuilder)
declare %TextBuilder @builder_pop_indent(%TextBuilder)
declare i8* @builder_to_string(%TextBuilder)
declare i8* @trim_right(i8*)
declare i8* @join_with_separator({ i8**, i64 }*, i8*)
declare i8* @join_type_annotations({ i8**, i64 }*)
declare i8* @char_at(i8*, double)
declare i1 @is_symbol_char(i8*)
declare i8* @sanitize_symbol(i8*)

declare noalias i8* @malloc(i64)

@runtime = external global i8**

@.str.len6.h1187178968 = private unnamed_addr constant [7 x i8] c".case \00"
@.str.len2.h193445474 = private unnamed_addr constant [3 x i8] c"=>\00"
@.str.len4.h175987322 = private unnamed_addr constant [5 x i8] c" if \00"
@.str.len4.h175713983 = private unnamed_addr constant [5 x i8] c" as \00"
@.str.len8.h2093451461 = private unnamed_addr constant [9 x i8] c".struct \00"
@.str.len11.h599952843 = private unnamed_addr constant [12 x i8] c".interface \00"
@.str.len0.h177573 = private unnamed_addr constant [1 x i8] c"\00"
@.str.len4.h278197661 = private unnamed_addr constant [5 x i8] c"void\00"
@.str.len6.h1280947313 = private unnamed_addr constant [7 x i8] c".enum \00"
@.str.len2.h193428050 = private unnamed_addr constant [3 x i8] c"->\00"
@.str.len5.h2064124065 = private unnamed_addr constant [6 x i8] c".let \00"

declare void @sailfin_runtime_mark_persistent(i8*)

define %NativeArtifact* @select_text_artifact({ %NativeArtifact*, i64 }* %artifacts) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %NativeArtifact
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t29 = phi double [ %t1, %block.entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t4 = extractvalue { %NativeArtifact*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = call double @llvm.round.f64(double %t8)
  %t10 = fptosi double %t9 to i64
  %t11 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t12 = extractvalue { %NativeArtifact*, i64 } %t11, 0
  %t13 = extractvalue { %NativeArtifact*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr %NativeArtifact, %NativeArtifact* %t12, i64 %t10
  %t16 = load %NativeArtifact, %NativeArtifact* %t15
  store %NativeArtifact %t16, %NativeArtifact* %l1
  %t17 = load %NativeArtifact, %NativeArtifact* %l1
  %t18 = extractvalue %NativeArtifact %t17, 1
  %s19 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1782433603, i32 0, i32 0
  %t20 = call i1 @strings_equal(i8* %t18, i8* %s19)
  %t21 = load double, double* %l0
  %t22 = load %NativeArtifact, %NativeArtifact* %l1
  br i1 %t20, label %then6, label %merge7
then6:
  %t23 = load %NativeArtifact, %NativeArtifact* %l1
  %t24 = alloca %NativeArtifact
  store %NativeArtifact %t23, %NativeArtifact* %t24
  ret %NativeArtifact* %t24
merge7:
  %t25 = load double, double* %l0
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l0
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t30 = load double, double* %l0
  %t31 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t31
}

define %NativeArtifact* @select_layout_manifest_artifact({ %NativeArtifact*, i64 }* %artifacts) {
block.entry:
  %l0 = alloca double
  %l1 = alloca %NativeArtifact
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t29 = phi double [ %t1, %block.entry ], [ %t28, %loop.latch2 ]
  store double %t29, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t4 = extractvalue { %NativeArtifact*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = call double @llvm.round.f64(double %t8)
  %t10 = fptosi double %t9 to i64
  %t11 = load { %NativeArtifact*, i64 }, { %NativeArtifact*, i64 }* %artifacts
  %t12 = extractvalue { %NativeArtifact*, i64 } %t11, 0
  %t13 = extractvalue { %NativeArtifact*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr %NativeArtifact, %NativeArtifact* %t12, i64 %t10
  %t16 = load %NativeArtifact, %NativeArtifact* %t15
  store %NativeArtifact %t16, %NativeArtifact* %l1
  %t17 = load %NativeArtifact, %NativeArtifact* %l1
  %t18 = extractvalue %NativeArtifact %t17, 1
  %s19 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h668778749, i32 0, i32 0
  %t20 = call i1 @strings_equal(i8* %t18, i8* %s19)
  %t21 = load double, double* %l0
  %t22 = load %NativeArtifact, %NativeArtifact* %l1
  br i1 %t20, label %then6, label %merge7
then6:
  %t23 = load %NativeArtifact, %NativeArtifact* %l1
  %t24 = alloca %NativeArtifact
  store %NativeArtifact %t23, %NativeArtifact* %t24
  ret %NativeArtifact* %t24
merge7:
  %t25 = load double, double* %l0
  %t26 = sitofp i64 1 to double
  %t27 = fadd double %t25, %t26
  store double %t27, double* %l0
  br label %loop.latch2
loop.latch2:
  %t28 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t30 = load double, double* %l0
  %t31 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t31
}

define %ParseNativeResult @parse_native_artifact(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeFunction*, i64 }*
  %l3 = alloca { %NativeImport*, i64 }*
  %l4 = alloca { %NativeStruct*, i64 }*
  %l5 = alloca { %NativeInterface*, i64 }*
  %l6 = alloca { %NativeEnum*, i64 }*
  %l7 = alloca { %NativeBinding*, i64 }*
  %l8 = alloca %NativeFunction*
  %l9 = alloca %NativeSourceSpan*
  %l10 = alloca %NativeSourceSpan*
  %l11 = alloca double
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca %NativeImport*
  %l15 = alloca %NativeImport*
  %l16 = alloca %NativeSourceSpan*
  %l17 = alloca %NativeSourceSpan*
  %l18 = alloca %StructParseResult
  %l19 = alloca %InterfaceParseResult
  %l20 = alloca %EnumParseResult
  %l21 = alloca i8*
  %l22 = alloca double
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca { i8**, i64 }*
  %l26 = alloca double
  %l27 = alloca i1
  %l28 = alloca i8*
  %l29 = alloca %NativeSourceSpan*
  %l30 = alloca %NativeParameter*
  %l31 = alloca %InstructionGatherResult
  %l32 = alloca %InstructionParseResult
  %l33 = alloca { %NativeInstruction**, i64 }*
  %l34 = alloca double
  %t0 = call { i8**, i64 }* @split_lines(i8* %text)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
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
  %t13 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* null, i32 1
  %t14 = ptrtoint [0 x %NativeFunction]* %t13 to i64
  %t15 = icmp eq i64 %t14, 0
  %t16 = select i1 %t15, i64 1, i64 %t14
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to %NativeFunction*
  %t19 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* null, i32 1
  %t20 = ptrtoint { %NativeFunction*, i64 }* %t19 to i64
  %t21 = call i8* @malloc(i64 %t20)
  %t22 = bitcast i8* %t21 to { %NativeFunction*, i64 }*
  %t23 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t22, i32 0, i32 0
  store %NativeFunction* %t18, %NativeFunction** %t23
  %t24 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  store { %NativeFunction*, i64 }* %t22, { %NativeFunction*, i64 }** %l2
  %t25 = getelementptr [0 x %NativeImport], [0 x %NativeImport]* null, i32 1
  %t26 = ptrtoint [0 x %NativeImport]* %t25 to i64
  %t27 = icmp eq i64 %t26, 0
  %t28 = select i1 %t27, i64 1, i64 %t26
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to %NativeImport*
  %t31 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* null, i32 1
  %t32 = ptrtoint { %NativeImport*, i64 }* %t31 to i64
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to { %NativeImport*, i64 }*
  %t35 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t34, i32 0, i32 0
  store %NativeImport* %t30, %NativeImport** %t35
  %t36 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { %NativeImport*, i64 }* %t34, { %NativeImport*, i64 }** %l3
  %t37 = getelementptr [0 x %NativeStruct], [0 x %NativeStruct]* null, i32 1
  %t38 = ptrtoint [0 x %NativeStruct]* %t37 to i64
  %t39 = icmp eq i64 %t38, 0
  %t40 = select i1 %t39, i64 1, i64 %t38
  %t41 = call i8* @malloc(i64 %t40)
  %t42 = bitcast i8* %t41 to %NativeStruct*
  %t43 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* null, i32 1
  %t44 = ptrtoint { %NativeStruct*, i64 }* %t43 to i64
  %t45 = call i8* @malloc(i64 %t44)
  %t46 = bitcast i8* %t45 to { %NativeStruct*, i64 }*
  %t47 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t46, i32 0, i32 0
  store %NativeStruct* %t42, %NativeStruct** %t47
  %t48 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t46, i32 0, i32 1
  store i64 0, i64* %t48
  store { %NativeStruct*, i64 }* %t46, { %NativeStruct*, i64 }** %l4
  %t49 = getelementptr [0 x %NativeInterface], [0 x %NativeInterface]* null, i32 1
  %t50 = ptrtoint [0 x %NativeInterface]* %t49 to i64
  %t51 = icmp eq i64 %t50, 0
  %t52 = select i1 %t51, i64 1, i64 %t50
  %t53 = call i8* @malloc(i64 %t52)
  %t54 = bitcast i8* %t53 to %NativeInterface*
  %t55 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* null, i32 1
  %t56 = ptrtoint { %NativeInterface*, i64 }* %t55 to i64
  %t57 = call i8* @malloc(i64 %t56)
  %t58 = bitcast i8* %t57 to { %NativeInterface*, i64 }*
  %t59 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t58, i32 0, i32 0
  store %NativeInterface* %t54, %NativeInterface** %t59
  %t60 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t58, i32 0, i32 1
  store i64 0, i64* %t60
  store { %NativeInterface*, i64 }* %t58, { %NativeInterface*, i64 }** %l5
  %t61 = getelementptr [0 x %NativeEnum], [0 x %NativeEnum]* null, i32 1
  %t62 = ptrtoint [0 x %NativeEnum]* %t61 to i64
  %t63 = icmp eq i64 %t62, 0
  %t64 = select i1 %t63, i64 1, i64 %t62
  %t65 = call i8* @malloc(i64 %t64)
  %t66 = bitcast i8* %t65 to %NativeEnum*
  %t67 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* null, i32 1
  %t68 = ptrtoint { %NativeEnum*, i64 }* %t67 to i64
  %t69 = call i8* @malloc(i64 %t68)
  %t70 = bitcast i8* %t69 to { %NativeEnum*, i64 }*
  %t71 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t70, i32 0, i32 0
  store %NativeEnum* %t66, %NativeEnum** %t71
  %t72 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t70, i32 0, i32 1
  store i64 0, i64* %t72
  store { %NativeEnum*, i64 }* %t70, { %NativeEnum*, i64 }** %l6
  %t73 = getelementptr [0 x %NativeBinding], [0 x %NativeBinding]* null, i32 1
  %t74 = ptrtoint [0 x %NativeBinding]* %t73 to i64
  %t75 = icmp eq i64 %t74, 0
  %t76 = select i1 %t75, i64 1, i64 %t74
  %t77 = call i8* @malloc(i64 %t76)
  %t78 = bitcast i8* %t77 to %NativeBinding*
  %t79 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* null, i32 1
  %t80 = ptrtoint { %NativeBinding*, i64 }* %t79 to i64
  %t81 = call i8* @malloc(i64 %t80)
  %t82 = bitcast i8* %t81 to { %NativeBinding*, i64 }*
  %t83 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t82, i32 0, i32 0
  store %NativeBinding* %t78, %NativeBinding** %t83
  %t84 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t82, i32 0, i32 1
  store i64 0, i64* %t84
  store { %NativeBinding*, i64 }* %t82, { %NativeBinding*, i64 }** %l7
  %t85 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t85, %NativeFunction** %l8
  %t86 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t86, %NativeSourceSpan** %l9
  %t87 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t87, %NativeSourceSpan** %l10
  %t88 = sitofp i64 0 to double
  store double %t88, double* %l11
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t91 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t92 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t93 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t94 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t95 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t96 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t97 = load %NativeFunction*, %NativeFunction** %l8
  %t98 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t99 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t100 = load double, double* %l11
  br label %loop.header0
loop.header0:
  %t1480 = phi double [ %t100, %block.entry ], [ %t1469, %loop.latch2 ]
  %t1481 = phi { i8**, i64 }* [ %t90, %block.entry ], [ %t1470, %loop.latch2 ]
  %t1482 = phi { %NativeImport*, i64 }* [ %t92, %block.entry ], [ %t1471, %loop.latch2 ]
  %t1483 = phi %NativeSourceSpan* [ %t98, %block.entry ], [ %t1472, %loop.latch2 ]
  %t1484 = phi %NativeSourceSpan* [ %t99, %block.entry ], [ %t1473, %loop.latch2 ]
  %t1485 = phi { %NativeStruct*, i64 }* [ %t93, %block.entry ], [ %t1474, %loop.latch2 ]
  %t1486 = phi { %NativeInterface*, i64 }* [ %t94, %block.entry ], [ %t1475, %loop.latch2 ]
  %t1487 = phi { %NativeEnum*, i64 }* [ %t95, %block.entry ], [ %t1476, %loop.latch2 ]
  %t1488 = phi %NativeFunction* [ %t97, %block.entry ], [ %t1477, %loop.latch2 ]
  %t1489 = phi { %NativeFunction*, i64 }* [ %t91, %block.entry ], [ %t1478, %loop.latch2 ]
  %t1490 = phi { %NativeBinding*, i64 }* [ %t96, %block.entry ], [ %t1479, %loop.latch2 ]
  store double %t1480, double* %l11
  store { i8**, i64 }* %t1481, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t1482, { %NativeImport*, i64 }** %l3
  store %NativeSourceSpan* %t1483, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1484, %NativeSourceSpan** %l10
  store { %NativeStruct*, i64 }* %t1485, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1486, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1487, { %NativeEnum*, i64 }** %l6
  store %NativeFunction* %t1488, %NativeFunction** %l8
  store { %NativeFunction*, i64 }* %t1489, { %NativeFunction*, i64 }** %l2
  store { %NativeBinding*, i64 }* %t1490, { %NativeBinding*, i64 }** %l7
  br label %loop.body1
loop.body1:
  %t101 = load double, double* %l11
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load { i8**, i64 }, { i8**, i64 }* %t102
  %t104 = extractvalue { i8**, i64 } %t103, 1
  %t105 = sitofp i64 %t104 to double
  %t106 = fcmp oge double %t101, %t105
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t109 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t110 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t111 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t112 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t113 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t114 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t115 = load %NativeFunction*, %NativeFunction** %l8
  %t116 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t117 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t118 = load double, double* %l11
  br i1 %t106, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t120 = load double, double* %l11
  %t121 = call double @llvm.round.f64(double %t120)
  %t122 = fptosi double %t121 to i64
  %t123 = load { i8**, i64 }, { i8**, i64 }* %t119
  %t124 = extractvalue { i8**, i64 } %t123, 0
  %t125 = extractvalue { i8**, i64 } %t123, 1
  %t126 = icmp uge i64 %t122, %t125
  ; bounds check: %t126 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t122, i64 %t125)
  %t127 = getelementptr i8*, i8** %t124, i64 %t122
  %t128 = load i8*, i8** %t127
  store i8* %t128, i8** %l12
  %t129 = load i8*, i8** %l12
  %t130 = call i8* @trim_text(i8* %t129)
  store i8* %t130, i8** %l13
  %t131 = load i8*, i8** %l13
  %t132 = call i64 @sailfin_runtime_string_length(i8* %t131)
  %t133 = icmp eq i64 %t132, 0
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t136 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t137 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t138 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t139 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t140 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t141 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t142 = load %NativeFunction*, %NativeFunction** %l8
  %t143 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t144 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t145 = load double, double* %l11
  %t146 = load i8*, i8** %l12
  %t147 = load i8*, i8** %l13
  br i1 %t133, label %then6, label %merge7
then6:
  %t148 = load double, double* %l11
  %t149 = sitofp i64 1 to double
  %t150 = fadd double %t148, %t149
  store double %t150, double* %l11
  br label %loop.latch2
merge7:
  %t151 = load i8*, i8** %l13
  %t152 = alloca [2 x i8], align 1
  %t153 = getelementptr [2 x i8], [2 x i8]* %t152, i32 0, i32 0
  store i8 59, i8* %t153
  %t154 = getelementptr [2 x i8], [2 x i8]* %t152, i32 0, i32 1
  store i8 0, i8* %t154
  %t155 = getelementptr [2 x i8], [2 x i8]* %t152, i32 0, i32 0
  %t156 = call i1 @starts_with(i8* %t151, i8* %t155)
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t159 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t160 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t161 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t162 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t163 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t164 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t165 = load %NativeFunction*, %NativeFunction** %l8
  %t166 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t167 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t168 = load double, double* %l11
  %t169 = load i8*, i8** %l12
  %t170 = load i8*, i8** %l13
  br i1 %t156, label %then8, label %merge9
then8:
  %t171 = load double, double* %l11
  %t172 = sitofp i64 1 to double
  %t173 = fadd double %t171, %t172
  store double %t173, double* %l11
  br label %loop.latch2
merge9:
  %t174 = load i8*, i8** %l13
  %s175 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1370870284, i32 0, i32 0
  %t176 = call i1 @starts_with(i8* %t174, i8* %s175)
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t179 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t180 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t181 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t182 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t183 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t184 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t185 = load %NativeFunction*, %NativeFunction** %l8
  %t186 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t187 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t188 = load double, double* %l11
  %t189 = load i8*, i8** %l12
  %t190 = load i8*, i8** %l13
  br i1 %t176, label %then10, label %merge11
then10:
  %t191 = load double, double* %l11
  %t192 = sitofp i64 1 to double
  %t193 = fadd double %t191, %t192
  store double %t193, double* %l11
  br label %loop.latch2
merge11:
  %t194 = load i8*, i8** %l13
  %s195 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h575595345, i32 0, i32 0
  %t196 = call i1 @starts_with(i8* %t194, i8* %s195)
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t198 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t199 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t200 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t201 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t202 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t203 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t204 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t205 = load %NativeFunction*, %NativeFunction** %l8
  %t206 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t207 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t208 = load double, double* %l11
  %t209 = load i8*, i8** %l12
  %t210 = load i8*, i8** %l13
  br i1 %t196, label %then12, label %merge13
then12:
  %s211 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h483393773, i32 0, i32 0
  %t212 = load i8*, i8** %l13
  %s213 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h575595345, i32 0, i32 0
  %t214 = call i8* @strip_prefix(i8* %t212, i8* %s213)
  %t215 = call %NativeImport* @parse_import_entry(i8* %s211, i8* %t214)
  store %NativeImport* %t215, %NativeImport** %l14
  %t216 = load %NativeImport*, %NativeImport** %l14
  %t217 = icmp eq %NativeImport* %t216, null
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t221 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t222 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t223 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t224 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t225 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t226 = load %NativeFunction*, %NativeFunction** %l8
  %t227 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t228 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t229 = load double, double* %l11
  %t230 = load i8*, i8** %l12
  %t231 = load i8*, i8** %l13
  %t232 = load %NativeImport*, %NativeImport** %l14
  br i1 %t217, label %then14, label %else15
then14:
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s234 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h457168017, i32 0, i32 0
  %t235 = load i8*, i8** %l13
  %t236 = call i8* @sailfin_runtime_string_concat(i8* %s234, i8* %t235)
  %t237 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t233, i8* %t236)
  store { i8**, i64 }* %t237, { i8**, i64 }** %l1
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
else15:
  %t239 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t240 = load %NativeImport*, %NativeImport** %l14
  %t241 = load %NativeImport, %NativeImport* %t240
  %t242 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t239, %NativeImport %t241)
  store { %NativeImport*, i64 }* %t242, { %NativeImport*, i64 }** %l3
  %t243 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge16
merge16:
  %t244 = phi { i8**, i64 }* [ %t238, %then14 ], [ %t219, %else15 ]
  %t245 = phi { %NativeImport*, i64 }* [ %t221, %then14 ], [ %t243, %else15 ]
  store { i8**, i64 }* %t244, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t245, { %NativeImport*, i64 }** %l3
  %t246 = load double, double* %l11
  %t247 = sitofp i64 1 to double
  %t248 = fadd double %t246, %t247
  store double %t248, double* %l11
  br label %loop.latch2
merge13:
  %t249 = load i8*, i8** %l13
  %s250 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1074277327, i32 0, i32 0
  %t251 = call i1 @starts_with(i8* %t249, i8* %s250)
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t254 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t255 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t256 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t257 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t258 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t259 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t260 = load %NativeFunction*, %NativeFunction** %l8
  %t261 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t262 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t263 = load double, double* %l11
  %t264 = load i8*, i8** %l12
  %t265 = load i8*, i8** %l13
  br i1 %t251, label %then17, label %merge18
then17:
  %s266 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t267 = load i8*, i8** %l13
  %s268 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1074277327, i32 0, i32 0
  %t269 = call i8* @strip_prefix(i8* %t267, i8* %s268)
  %t270 = call %NativeImport* @parse_import_entry(i8* %s266, i8* %t269)
  store %NativeImport* %t270, %NativeImport** %l15
  %t271 = load %NativeImport*, %NativeImport** %l15
  %t272 = icmp eq %NativeImport* %t271, null
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t275 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t276 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t277 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t278 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t279 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t280 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t281 = load %NativeFunction*, %NativeFunction** %l8
  %t282 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t283 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t284 = load double, double* %l11
  %t285 = load i8*, i8** %l12
  %t286 = load i8*, i8** %l13
  %t287 = load %NativeImport*, %NativeImport** %l15
  br i1 %t272, label %then19, label %else20
then19:
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s289 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h1881287894, i32 0, i32 0
  %t290 = load i8*, i8** %l13
  %t291 = call i8* @sailfin_runtime_string_concat(i8* %s289, i8* %t290)
  %t292 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t288, i8* %t291)
  store { i8**, i64 }* %t292, { i8**, i64 }** %l1
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t294 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t295 = load %NativeImport*, %NativeImport** %l15
  %t296 = load %NativeImport, %NativeImport* %t295
  %t297 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t294, %NativeImport %t296)
  store { %NativeImport*, i64 }* %t297, { %NativeImport*, i64 }** %l3
  %t298 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge21
merge21:
  %t299 = phi { i8**, i64 }* [ %t293, %then19 ], [ %t274, %else20 ]
  %t300 = phi { %NativeImport*, i64 }* [ %t276, %then19 ], [ %t298, %else20 ]
  store { i8**, i64 }* %t299, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t300, { %NativeImport*, i64 }** %l3
  %t301 = load double, double* %l11
  %t302 = sitofp i64 1 to double
  %t303 = fadd double %t301, %t302
  store double %t303, double* %l11
  br label %loop.latch2
merge18:
  %t304 = load i8*, i8** %l13
  %s305 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t306 = call i1 @starts_with(i8* %t304, i8* %s305)
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t309 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t310 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t311 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t312 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t313 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t314 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t315 = load %NativeFunction*, %NativeFunction** %l8
  %t316 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t317 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t318 = load double, double* %l11
  %t319 = load i8*, i8** %l12
  %t320 = load i8*, i8** %l13
  br i1 %t306, label %then22, label %merge23
then22:
  %t321 = load i8*, i8** %l13
  %s322 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t323 = call i8* @strip_prefix(i8* %t321, i8* %s322)
  %t324 = call %NativeSourceSpan* @parse_source_span(i8* %t323)
  store %NativeSourceSpan* %t324, %NativeSourceSpan** %l16
  %t325 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  %t326 = icmp eq %NativeSourceSpan* %t325, null
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t329 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t330 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t331 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t332 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t333 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t334 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t335 = load %NativeFunction*, %NativeFunction** %l8
  %t336 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t337 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t338 = load double, double* %l11
  %t339 = load i8*, i8** %l12
  %t340 = load i8*, i8** %l13
  %t341 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  br i1 %t326, label %then24, label %else25
then24:
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s343 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h762677253, i32 0, i32 0
  %t344 = load i8*, i8** %l13
  %t345 = call i8* @sailfin_runtime_string_concat(i8* %s343, i8* %t344)
  %t346 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t342, i8* %t345)
  store { i8**, i64 }* %t346, { i8**, i64 }** %l1
  %t347 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t348 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  store %NativeSourceSpan* %t348, %NativeSourceSpan** %l9
  %t349 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge26
merge26:
  %t350 = phi { i8**, i64 }* [ %t347, %then24 ], [ %t328, %else25 ]
  %t351 = phi %NativeSourceSpan* [ %t336, %then24 ], [ %t349, %else25 ]
  store { i8**, i64 }* %t350, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t351, %NativeSourceSpan** %l9
  %t352 = load double, double* %l11
  %t353 = sitofp i64 1 to double
  %t354 = fadd double %t352, %t353
  store double %t354, double* %l11
  br label %loop.latch2
merge23:
  %t355 = load i8*, i8** %l13
  %s356 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t357 = call i1 @starts_with(i8* %t355, i8* %s356)
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t360 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t361 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t362 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t363 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t364 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t365 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t366 = load %NativeFunction*, %NativeFunction** %l8
  %t367 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t368 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t369 = load double, double* %l11
  %t370 = load i8*, i8** %l12
  %t371 = load i8*, i8** %l13
  br i1 %t357, label %then27, label %merge28
then27:
  %t372 = load i8*, i8** %l13
  %s373 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t374 = call i8* @strip_prefix(i8* %t372, i8* %s373)
  %t375 = call %NativeSourceSpan* @parse_source_span(i8* %t374)
  store %NativeSourceSpan* %t375, %NativeSourceSpan** %l17
  %t376 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  %t377 = icmp eq %NativeSourceSpan* %t376, null
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t380 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t381 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t382 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t383 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t384 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t385 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t386 = load %NativeFunction*, %NativeFunction** %l8
  %t387 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t388 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t389 = load double, double* %l11
  %t390 = load i8*, i8** %l12
  %t391 = load i8*, i8** %l13
  %t392 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  br i1 %t377, label %then29, label %else30
then29:
  %t393 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s394 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.len43.h1714227133, i32 0, i32 0
  %t395 = load i8*, i8** %l13
  %t396 = call i8* @sailfin_runtime_string_concat(i8* %s394, i8* %t395)
  %t397 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t393, i8* %t396)
  store { i8**, i64 }* %t397, { i8**, i64 }** %l1
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
else30:
  %t399 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  store %NativeSourceSpan* %t399, %NativeSourceSpan** %l10
  %t400 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge31
merge31:
  %t401 = phi { i8**, i64 }* [ %t398, %then29 ], [ %t379, %else30 ]
  %t402 = phi %NativeSourceSpan* [ %t388, %then29 ], [ %t400, %else30 ]
  store { i8**, i64 }* %t401, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t402, %NativeSourceSpan** %l10
  %t403 = load double, double* %l11
  %t404 = sitofp i64 1 to double
  %t405 = fadd double %t403, %t404
  store double %t405, double* %l11
  br label %loop.latch2
merge28:
  %t406 = load i8*, i8** %l13
  %s407 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2093451461, i32 0, i32 0
  %t408 = call i1 @starts_with(i8* %t406, i8* %s407)
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t410 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t411 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t412 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t413 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t414 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t415 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t416 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t417 = load %NativeFunction*, %NativeFunction** %l8
  %t418 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t419 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t420 = load double, double* %l11
  %t421 = load i8*, i8** %l12
  %t422 = load i8*, i8** %l13
  br i1 %t408, label %then32, label %merge33
then32:
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t424 = load double, double* %l11
  %t425 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t423, double %t424)
  store %StructParseResult %t425, %StructParseResult* %l18
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t427 = load %StructParseResult, %StructParseResult* %l18
  %t428 = extractvalue %StructParseResult %t427, 2
  %t429 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t426, { i8**, i64 }* %t428)
  store { i8**, i64 }* %t429, { i8**, i64 }** %l1
  %t430 = load %StructParseResult, %StructParseResult* %l18
  %t431 = extractvalue %StructParseResult %t430, 0
  %t432 = icmp ne %NativeStruct* %t431, null
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t435 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t436 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t437 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t438 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t439 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t440 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t441 = load %NativeFunction*, %NativeFunction** %l8
  %t442 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t443 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t444 = load double, double* %l11
  %t445 = load i8*, i8** %l12
  %t446 = load i8*, i8** %l13
  %t447 = load %StructParseResult, %StructParseResult* %l18
  br i1 %t432, label %then34, label %merge35
then34:
  %t448 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t449 = load %StructParseResult, %StructParseResult* %l18
  %t450 = extractvalue %StructParseResult %t449, 0
  %t451 = load %NativeStruct, %NativeStruct* %t450
  %t452 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t448, %NativeStruct %t451)
  store { %NativeStruct*, i64 }* %t452, { %NativeStruct*, i64 }** %l4
  %t453 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  br label %merge35
merge35:
  %t454 = phi { %NativeStruct*, i64 }* [ %t453, %then34 ], [ %t437, %then32 ]
  store { %NativeStruct*, i64 }* %t454, { %NativeStruct*, i64 }** %l4
  %t455 = load %StructParseResult, %StructParseResult* %l18
  %t456 = extractvalue %StructParseResult %t455, 1
  store double %t456, double* %l11
  br label %loop.latch2
merge33:
  %t457 = load i8*, i8** %l13
  %s458 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h599952843, i32 0, i32 0
  %t459 = call i1 @starts_with(i8* %t457, i8* %s458)
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t462 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t463 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t464 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t465 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t466 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t467 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t468 = load %NativeFunction*, %NativeFunction** %l8
  %t469 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t470 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t471 = load double, double* %l11
  %t472 = load i8*, i8** %l12
  %t473 = load i8*, i8** %l13
  br i1 %t459, label %then36, label %merge37
then36:
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t475 = load double, double* %l11
  %t476 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t474, double %t475)
  store %InterfaceParseResult %t476, %InterfaceParseResult* %l19
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t478 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t479 = extractvalue %InterfaceParseResult %t478, 2
  %t480 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t477, { i8**, i64 }* %t479)
  store { i8**, i64 }* %t480, { i8**, i64 }** %l1
  %t481 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t482 = extractvalue %InterfaceParseResult %t481, 0
  %t483 = icmp ne %NativeInterface* %t482, null
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t486 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t487 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t488 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t489 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t490 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t491 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t492 = load %NativeFunction*, %NativeFunction** %l8
  %t493 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t494 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t495 = load double, double* %l11
  %t496 = load i8*, i8** %l12
  %t497 = load i8*, i8** %l13
  %t498 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  br i1 %t483, label %then38, label %merge39
then38:
  %t499 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t500 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t501 = extractvalue %InterfaceParseResult %t500, 0
  %t502 = load %NativeInterface, %NativeInterface* %t501
  %t503 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t499, %NativeInterface %t502)
  store { %NativeInterface*, i64 }* %t503, { %NativeInterface*, i64 }** %l5
  %t504 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  br label %merge39
merge39:
  %t505 = phi { %NativeInterface*, i64 }* [ %t504, %then38 ], [ %t489, %then36 ]
  store { %NativeInterface*, i64 }* %t505, { %NativeInterface*, i64 }** %l5
  %t506 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t507 = extractvalue %InterfaceParseResult %t506, 1
  store double %t507, double* %l11
  br label %loop.latch2
merge37:
  %t508 = load i8*, i8** %l13
  %s509 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280947313, i32 0, i32 0
  %t510 = call i1 @starts_with(i8* %t508, i8* %s509)
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t513 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t514 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t515 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t516 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t517 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t518 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t519 = load %NativeFunction*, %NativeFunction** %l8
  %t520 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t521 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t522 = load double, double* %l11
  %t523 = load i8*, i8** %l12
  %t524 = load i8*, i8** %l13
  br i1 %t510, label %then40, label %merge41
then40:
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t526 = load double, double* %l11
  %t527 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t525, double %t526)
  store %EnumParseResult %t527, %EnumParseResult* %l20
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t529 = load %EnumParseResult, %EnumParseResult* %l20
  %t530 = extractvalue %EnumParseResult %t529, 2
  %t531 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t528, { i8**, i64 }* %t530)
  store { i8**, i64 }* %t531, { i8**, i64 }** %l1
  %t532 = load %EnumParseResult, %EnumParseResult* %l20
  %t533 = extractvalue %EnumParseResult %t532, 0
  %t534 = icmp ne %NativeEnum* %t533, null
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t537 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t538 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t539 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t540 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t541 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t542 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t543 = load %NativeFunction*, %NativeFunction** %l8
  %t544 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t545 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t546 = load double, double* %l11
  %t547 = load i8*, i8** %l12
  %t548 = load i8*, i8** %l13
  %t549 = load %EnumParseResult, %EnumParseResult* %l20
  br i1 %t534, label %then42, label %merge43
then42:
  %t550 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t551 = load %EnumParseResult, %EnumParseResult* %l20
  %t552 = extractvalue %EnumParseResult %t551, 0
  %t553 = load %NativeEnum, %NativeEnum* %t552
  %t554 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t550, %NativeEnum %t553)
  store { %NativeEnum*, i64 }* %t554, { %NativeEnum*, i64 }** %l6
  %t555 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  br label %merge43
merge43:
  %t556 = phi { %NativeEnum*, i64 }* [ %t555, %then42 ], [ %t541, %then40 ]
  store { %NativeEnum*, i64 }* %t556, { %NativeEnum*, i64 }** %l6
  %t557 = load %EnumParseResult, %EnumParseResult* %l20
  %t558 = extractvalue %EnumParseResult %t557, 1
  store double %t558, double* %l11
  br label %loop.latch2
merge41:
  %t559 = load i8*, i8** %l13
  %s560 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192491117, i32 0, i32 0
  %t561 = call i1 @starts_with(i8* %t559, i8* %s560)
  %t562 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t563 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t564 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t565 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t566 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t567 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t568 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t569 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t570 = load %NativeFunction*, %NativeFunction** %l8
  %t571 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t572 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t573 = load double, double* %l11
  %t574 = load i8*, i8** %l12
  %t575 = load i8*, i8** %l13
  br i1 %t561, label %then44, label %merge45
then44:
  %t576 = load %NativeFunction*, %NativeFunction** %l8
  %t577 = icmp ne %NativeFunction* %t576, null
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t580 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t581 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t582 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t583 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t584 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t585 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t586 = load %NativeFunction*, %NativeFunction** %l8
  %t587 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t588 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t589 = load double, double* %l11
  %t590 = load i8*, i8** %l12
  %t591 = load i8*, i8** %l13
  br i1 %t577, label %then46, label %merge47
then46:
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s593 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.len57.h1118233133, i32 0, i32 0
  %t594 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t592, i8* %s593)
  store { i8**, i64 }* %t594, { i8**, i64 }** %l1
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t596 = phi { i8**, i64 }* [ %t595, %then46 ], [ %t579, %then44 ]
  store { i8**, i64 }* %t596, { i8**, i64 }** %l1
  %t597 = load i8*, i8** %l13
  %s598 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192491117, i32 0, i32 0
  %t599 = call i8* @strip_prefix(i8* %t597, i8* %s598)
  %t600 = call i8* @parse_function_name(i8* %t599)
  %t601 = insertvalue %NativeFunction undef, i8* %t600, 0
  %t602 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* null, i32 1
  %t603 = ptrtoint [0 x %NativeParameter*]* %t602 to i64
  %t604 = icmp eq i64 %t603, 0
  %t605 = select i1 %t604, i64 1, i64 %t603
  %t606 = call i8* @malloc(i64 %t605)
  %t607 = bitcast i8* %t606 to %NativeParameter**
  %t608 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* null, i32 1
  %t609 = ptrtoint { %NativeParameter**, i64 }* %t608 to i64
  %t610 = call i8* @malloc(i64 %t609)
  %t611 = bitcast i8* %t610 to { %NativeParameter**, i64 }*
  %t612 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t611, i32 0, i32 0
  store %NativeParameter** %t607, %NativeParameter*** %t612
  %t613 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t611, i32 0, i32 1
  store i64 0, i64* %t613
  %t614 = insertvalue %NativeFunction %t601, { %NativeParameter**, i64 }* %t611, 1
  %s615 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t616 = insertvalue %NativeFunction %t614, i8* %s615, 2
  %t617 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t618 = ptrtoint [0 x i8*]* %t617 to i64
  %t619 = icmp eq i64 %t618, 0
  %t620 = select i1 %t619, i64 1, i64 %t618
  %t621 = call i8* @malloc(i64 %t620)
  %t622 = bitcast i8* %t621 to i8**
  %t623 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t624 = ptrtoint { i8**, i64 }* %t623 to i64
  %t625 = call i8* @malloc(i64 %t624)
  %t626 = bitcast i8* %t625 to { i8**, i64 }*
  %t627 = getelementptr { i8**, i64 }, { i8**, i64 }* %t626, i32 0, i32 0
  store i8** %t622, i8*** %t627
  %t628 = getelementptr { i8**, i64 }, { i8**, i64 }* %t626, i32 0, i32 1
  store i64 0, i64* %t628
  %t629 = insertvalue %NativeFunction %t616, { i8**, i64 }* %t626, 3
  %t630 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* null, i32 1
  %t631 = ptrtoint [0 x %NativeInstruction*]* %t630 to i64
  %t632 = icmp eq i64 %t631, 0
  %t633 = select i1 %t632, i64 1, i64 %t631
  %t634 = call i8* @malloc(i64 %t633)
  %t635 = bitcast i8* %t634 to %NativeInstruction**
  %t636 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t637 = ptrtoint { %NativeInstruction**, i64 }* %t636 to i64
  %t638 = call i8* @malloc(i64 %t637)
  %t639 = bitcast i8* %t638 to { %NativeInstruction**, i64 }*
  %t640 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t639, i32 0, i32 0
  store %NativeInstruction** %t635, %NativeInstruction*** %t640
  %t641 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t639, i32 0, i32 1
  store i64 0, i64* %t641
  %t642 = insertvalue %NativeFunction %t629, { %NativeInstruction**, i64 }* %t639, 4
  %t643 = alloca %NativeFunction
  store %NativeFunction %t642, %NativeFunction* %t643
  store %NativeFunction* %t643, %NativeFunction** %l8
  %t644 = load double, double* %l11
  %t645 = sitofp i64 1 to double
  %t646 = fadd double %t644, %t645
  store double %t646, double* %l11
  br label %loop.latch2
merge45:
  %t647 = load i8*, i8** %l13
  %s648 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280331335, i32 0, i32 0
  %t649 = call i1 @starts_with(i8* %t647, i8* %s648)
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t651 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t652 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t653 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t654 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t655 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t656 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t657 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t658 = load %NativeFunction*, %NativeFunction** %l8
  %t659 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t660 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t661 = load double, double* %l11
  %t662 = load i8*, i8** %l12
  %t663 = load i8*, i8** %l13
  br i1 %t649, label %then48, label %merge49
then48:
  %t664 = load %NativeFunction*, %NativeFunction** %l8
  %t665 = icmp eq %NativeFunction* %t664, null
  %t666 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t667 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t668 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t669 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t670 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t671 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t672 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t673 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t674 = load %NativeFunction*, %NativeFunction** %l8
  %t675 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t676 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t677 = load double, double* %l11
  %t678 = load i8*, i8** %l12
  %t679 = load i8*, i8** %l13
  br i1 %t665, label %then50, label %else51
then50:
  %t680 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s681 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1518215675, i32 0, i32 0
  %t682 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t680, i8* %s681)
  store { i8**, i64 }* %t682, { i8**, i64 }** %l1
  %t683 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge52
else51:
  %t684 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t685 = load %NativeFunction*, %NativeFunction** %l8
  %t686 = load %NativeFunction, %NativeFunction* %t685
  %t687 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t684, %NativeFunction %t686)
  store { %NativeFunction*, i64 }* %t687, { %NativeFunction*, i64 }** %l2
  %t688 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t688, %NativeFunction** %l8
  %t689 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t690 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge52
merge52:
  %t691 = phi { i8**, i64 }* [ %t683, %then50 ], [ %t667, %else51 ]
  %t692 = phi { %NativeFunction*, i64 }* [ %t668, %then50 ], [ %t689, %else51 ]
  %t693 = phi %NativeFunction* [ %t674, %then50 ], [ %t690, %else51 ]
  store { i8**, i64 }* %t691, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t692, { %NativeFunction*, i64 }** %l2
  store %NativeFunction* %t693, %NativeFunction** %l8
  %t694 = load double, double* %l11
  %t695 = sitofp i64 1 to double
  %t696 = fadd double %t694, %t695
  store double %t696, double* %l11
  br label %loop.latch2
merge49:
  %t697 = load i8*, i8** %l13
  %s698 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t699 = call i1 @starts_with(i8* %t697, i8* %s698)
  %t700 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t701 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t702 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t703 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t704 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t705 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t706 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t707 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t708 = load %NativeFunction*, %NativeFunction** %l8
  %t709 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t710 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t711 = load double, double* %l11
  %t712 = load i8*, i8** %l12
  %t713 = load i8*, i8** %l13
  br i1 %t699, label %then53, label %merge54
then53:
  %t714 = load %NativeFunction*, %NativeFunction** %l8
  %t715 = icmp ne %NativeFunction* %t714, null
  %t716 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t717 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t718 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t719 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t720 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t721 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t722 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t723 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t724 = load %NativeFunction*, %NativeFunction** %l8
  %t725 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t726 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t727 = load double, double* %l11
  %t728 = load i8*, i8** %l12
  %t729 = load i8*, i8** %l13
  br i1 %t715, label %then55, label %else56
then55:
  %t730 = load %NativeFunction*, %NativeFunction** %l8
  %t731 = load i8*, i8** %l13
  %s732 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t733 = call i8* @strip_prefix(i8* %t731, i8* %s732)
  %t734 = load %NativeFunction, %NativeFunction* %t730
  %t735 = call %NativeFunction @apply_meta(%NativeFunction %t734, i8* %t733)
  %t736 = alloca %NativeFunction
  store %NativeFunction %t735, %NativeFunction* %t736
  store %NativeFunction* %t736, %NativeFunction** %l8
  %t737 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge57
else56:
  %t738 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s739 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1767333123, i32 0, i32 0
  %t740 = load i8*, i8** %l13
  %t741 = call i8* @sailfin_runtime_string_concat(i8* %s739, i8* %t740)
  %t742 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t738, i8* %t741)
  store { i8**, i64 }* %t742, { i8**, i64 }** %l1
  %t743 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge57
merge57:
  %t744 = phi %NativeFunction* [ %t737, %then55 ], [ %t724, %else56 ]
  %t745 = phi { i8**, i64 }* [ %t717, %then55 ], [ %t743, %else56 ]
  store %NativeFunction* %t744, %NativeFunction** %l8
  store { i8**, i64 }* %t745, { i8**, i64 }** %l1
  %t746 = load double, double* %l11
  %t747 = sitofp i64 1 to double
  %t748 = fadd double %t746, %t747
  store double %t748, double* %l11
  br label %loop.latch2
merge54:
  %t749 = load i8*, i8** %l13
  %s750 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t751 = call i1 @starts_with(i8* %t749, i8* %s750)
  %t752 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t753 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t754 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t755 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t756 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t757 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t758 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t759 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t760 = load %NativeFunction*, %NativeFunction** %l8
  %t761 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t762 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t763 = load double, double* %l11
  %t764 = load i8*, i8** %l12
  %t765 = load i8*, i8** %l13
  br i1 %t751, label %then58, label %merge59
then58:
  %t766 = load %NativeFunction*, %NativeFunction** %l8
  %t767 = icmp ne %NativeFunction* %t766, null
  %t768 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t769 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t770 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t771 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t772 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t773 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t774 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t775 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t776 = load %NativeFunction*, %NativeFunction** %l8
  %t777 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t778 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t779 = load double, double* %l11
  %t780 = load i8*, i8** %l12
  %t781 = load i8*, i8** %l13
  br i1 %t767, label %then60, label %else61
then60:
  %t782 = load i8*, i8** %l13
  %s783 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t784 = call i8* @strip_prefix(i8* %t782, i8* %s783)
  store i8* %t784, i8** %l21
  %t785 = load double, double* %l11
  %t786 = sitofp i64 1 to double
  %t787 = fadd double %t785, %t786
  store double %t787, double* %l22
  %t788 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t789 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t790 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t791 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t792 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t793 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t794 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t795 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t796 = load %NativeFunction*, %NativeFunction** %l8
  %t797 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t798 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t799 = load double, double* %l11
  %t800 = load i8*, i8** %l12
  %t801 = load i8*, i8** %l13
  %t802 = load i8*, i8** %l21
  %t803 = load double, double* %l22
  br label %loop.header63
loop.header63:
  %t916 = phi double [ %t803, %then60 ], [ %t914, %loop.latch65 ]
  %t917 = phi i8* [ %t802, %then60 ], [ %t915, %loop.latch65 ]
  store double %t916, double* %l22
  store i8* %t917, i8** %l21
  br label %loop.body64
loop.body64:
  %t804 = load double, double* %l22
  %t805 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t806 = load { i8**, i64 }, { i8**, i64 }* %t805
  %t807 = extractvalue { i8**, i64 } %t806, 1
  %t808 = sitofp i64 %t807 to double
  %t809 = fcmp oge double %t804, %t808
  %t810 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t811 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t812 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t813 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t814 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t815 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t816 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t817 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t818 = load %NativeFunction*, %NativeFunction** %l8
  %t819 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t820 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t821 = load double, double* %l11
  %t822 = load i8*, i8** %l12
  %t823 = load i8*, i8** %l13
  %t824 = load i8*, i8** %l21
  %t825 = load double, double* %l22
  br i1 %t809, label %then67, label %merge68
then67:
  br label %afterloop66
merge68:
  %t826 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t827 = load double, double* %l22
  %t828 = call double @llvm.round.f64(double %t827)
  %t829 = fptosi double %t828 to i64
  %t830 = load { i8**, i64 }, { i8**, i64 }* %t826
  %t831 = extractvalue { i8**, i64 } %t830, 0
  %t832 = extractvalue { i8**, i64 } %t830, 1
  %t833 = icmp uge i64 %t829, %t832
  ; bounds check: %t833 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t829, i64 %t832)
  %t834 = getelementptr i8*, i8** %t831, i64 %t829
  %t835 = load i8*, i8** %t834
  store i8* %t835, i8** %l23
  %t836 = load i8*, i8** %l23
  %t837 = call i64 @sailfin_runtime_string_length(i8* %t836)
  %t838 = icmp eq i64 %t837, 0
  %t839 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t840 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t841 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t842 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t843 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t844 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t845 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t846 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t847 = load %NativeFunction*, %NativeFunction** %l8
  %t848 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t849 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t850 = load double, double* %l11
  %t851 = load i8*, i8** %l12
  %t852 = load i8*, i8** %l13
  %t853 = load i8*, i8** %l21
  %t854 = load double, double* %l22
  %t855 = load i8*, i8** %l23
  br i1 %t838, label %then69, label %merge70
then69:
  br label %afterloop66
merge70:
  %t856 = load i8*, i8** %l23
  %t857 = call i8* @trim_text(i8* %t856)
  store i8* %t857, i8** %l24
  %t858 = load i8*, i8** %l24
  %t859 = call i64 @sailfin_runtime_string_length(i8* %t858)
  %t860 = icmp eq i64 %t859, 0
  %t861 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t862 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t863 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t864 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t865 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t866 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t867 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t868 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t869 = load %NativeFunction*, %NativeFunction** %l8
  %t870 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t871 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t872 = load double, double* %l11
  %t873 = load i8*, i8** %l12
  %t874 = load i8*, i8** %l13
  %t875 = load i8*, i8** %l21
  %t876 = load double, double* %l22
  %t877 = load i8*, i8** %l23
  %t878 = load i8*, i8** %l24
  br i1 %t860, label %then71, label %merge72
then71:
  %t879 = load double, double* %l22
  %t880 = sitofp i64 1 to double
  %t881 = fadd double %t879, %t880
  store double %t881, double* %l22
  br label %loop.latch65
merge72:
  %t882 = load i8*, i8** %l24
  %t883 = call i1 @line_looks_like_parameter_entry(i8* %t882)
  %t884 = xor i1 %t883, 1
  %t885 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t886 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t887 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t888 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t889 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t890 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t891 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t892 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t893 = load %NativeFunction*, %NativeFunction** %l8
  %t894 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t895 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t896 = load double, double* %l11
  %t897 = load i8*, i8** %l12
  %t898 = load i8*, i8** %l13
  %t899 = load i8*, i8** %l21
  %t900 = load double, double* %l22
  %t901 = load i8*, i8** %l23
  %t902 = load i8*, i8** %l24
  br i1 %t884, label %then73, label %merge74
then73:
  br label %afterloop66
merge74:
  %t903 = load i8*, i8** %l21
  %t904 = alloca [2 x i8], align 1
  %t905 = getelementptr [2 x i8], [2 x i8]* %t904, i32 0, i32 0
  store i8 32, i8* %t905
  %t906 = getelementptr [2 x i8], [2 x i8]* %t904, i32 0, i32 1
  store i8 0, i8* %t906
  %t907 = getelementptr [2 x i8], [2 x i8]* %t904, i32 0, i32 0
  %t908 = call i8* @sailfin_runtime_string_concat(i8* %t903, i8* %t907)
  %t909 = load i8*, i8** %l24
  %t910 = call i8* @sailfin_runtime_string_concat(i8* %t908, i8* %t909)
  store i8* %t910, i8** %l21
  %t911 = load double, double* %l22
  %t912 = sitofp i64 1 to double
  %t913 = fadd double %t911, %t912
  store double %t913, double* %l22
  br label %loop.latch65
loop.latch65:
  %t914 = load double, double* %l22
  %t915 = load i8*, i8** %l21
  br label %loop.header63
afterloop66:
  %t918 = load double, double* %l22
  %t919 = load i8*, i8** %l21
  %t920 = load i8*, i8** %l21
  %t921 = call { i8**, i64 }* @split_parameter_entries(i8* %t920)
  store { i8**, i64 }* %t921, { i8**, i64 }** %l25
  %t922 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t923 = load { i8**, i64 }, { i8**, i64 }* %t922
  %t924 = extractvalue { i8**, i64 } %t923, 1
  %t925 = icmp eq i64 %t924, 0
  %t926 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t927 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t928 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t929 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t930 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t931 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t932 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t933 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t934 = load %NativeFunction*, %NativeFunction** %l8
  %t935 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t936 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t937 = load double, double* %l11
  %t938 = load i8*, i8** %l12
  %t939 = load i8*, i8** %l13
  %t940 = load i8*, i8** %l21
  %t941 = load double, double* %l22
  %t942 = load { i8**, i64 }*, { i8**, i64 }** %l25
  br i1 %t925, label %then75, label %else76
then75:
  %t943 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s944 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1189086491, i32 0, i32 0
  %t945 = load i8*, i8** %l13
  %t946 = call i8* @sailfin_runtime_string_concat(i8* %s944, i8* %t945)
  %t947 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t943, i8* %t946)
  store { i8**, i64 }* %t947, { i8**, i64 }** %l1
  %t948 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t948, %NativeSourceSpan** %l9
  %t949 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t950 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
else76:
  %t951 = sitofp i64 0 to double
  store double %t951, double* %l26
  store i1 0, i1* %l27
  %t952 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t954 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t955 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t956 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t957 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t958 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t959 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t960 = load %NativeFunction*, %NativeFunction** %l8
  %t961 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t962 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t963 = load double, double* %l11
  %t964 = load i8*, i8** %l12
  %t965 = load i8*, i8** %l13
  %t966 = load i8*, i8** %l21
  %t967 = load double, double* %l22
  %t968 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t969 = load double, double* %l26
  %t970 = load i1, i1* %l27
  br label %loop.header78
loop.header78:
  %t1111 = phi { i8**, i64 }* [ %t953, %else76 ], [ %t1107, %loop.latch80 ]
  %t1112 = phi %NativeFunction* [ %t960, %else76 ], [ %t1108, %loop.latch80 ]
  %t1113 = phi i1 [ %t970, %else76 ], [ %t1109, %loop.latch80 ]
  %t1114 = phi double [ %t969, %else76 ], [ %t1110, %loop.latch80 ]
  store { i8**, i64 }* %t1111, { i8**, i64 }** %l1
  store %NativeFunction* %t1112, %NativeFunction** %l8
  store i1 %t1113, i1* %l27
  store double %t1114, double* %l26
  br label %loop.body79
loop.body79:
  %t971 = load double, double* %l26
  %t972 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t973 = load { i8**, i64 }, { i8**, i64 }* %t972
  %t974 = extractvalue { i8**, i64 } %t973, 1
  %t975 = sitofp i64 %t974 to double
  %t976 = fcmp oge double %t971, %t975
  %t977 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t978 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t979 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t980 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t981 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t982 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t983 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t984 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t985 = load %NativeFunction*, %NativeFunction** %l8
  %t986 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t987 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t988 = load double, double* %l11
  %t989 = load i8*, i8** %l12
  %t990 = load i8*, i8** %l13
  %t991 = load i8*, i8** %l21
  %t992 = load double, double* %l22
  %t993 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t994 = load double, double* %l26
  %t995 = load i1, i1* %l27
  br i1 %t976, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t996 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t997 = load double, double* %l26
  %t998 = call double @llvm.round.f64(double %t997)
  %t999 = fptosi double %t998 to i64
  %t1000 = load { i8**, i64 }, { i8**, i64 }* %t996
  %t1001 = extractvalue { i8**, i64 } %t1000, 0
  %t1002 = extractvalue { i8**, i64 } %t1000, 1
  %t1003 = icmp uge i64 %t999, %t1002
  ; bounds check: %t1003 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t999, i64 %t1002)
  %t1004 = getelementptr i8*, i8** %t1001, i64 %t999
  %t1005 = load i8*, i8** %t1004
  store i8* %t1005, i8** %l28
  %t1006 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1006, %NativeSourceSpan** %l29
  %t1007 = load i1, i1* %l27
  %t1008 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1009 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1010 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1011 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1012 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1013 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1014 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1015 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1016 = load %NativeFunction*, %NativeFunction** %l8
  %t1017 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1018 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1019 = load double, double* %l11
  %t1020 = load i8*, i8** %l12
  %t1021 = load i8*, i8** %l13
  %t1022 = load i8*, i8** %l21
  %t1023 = load double, double* %l22
  %t1024 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1025 = load double, double* %l26
  %t1026 = load i1, i1* %l27
  %t1027 = load i8*, i8** %l28
  %t1028 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br i1 %t1007, label %then84, label %merge85
then84:
  %t1029 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1029, %NativeSourceSpan** %l29
  %t1030 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br label %merge85
merge85:
  %t1031 = phi %NativeSourceSpan* [ %t1030, %then84 ], [ %t1028, %merge83 ]
  store %NativeSourceSpan* %t1031, %NativeSourceSpan** %l29
  %t1032 = load i8*, i8** %l28
  %t1033 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1034 = call %NativeParameter* @parse_parameter_entry(i8* %t1032, %NativeSourceSpan* %t1033)
  store %NativeParameter* %t1034, %NativeParameter** %l30
  %t1035 = load %NativeParameter*, %NativeParameter** %l30
  %t1036 = icmp eq %NativeParameter* %t1035, null
  %t1037 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1038 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1039 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1040 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1041 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1042 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1043 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1044 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1045 = load %NativeFunction*, %NativeFunction** %l8
  %t1046 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1047 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1048 = load double, double* %l11
  %t1049 = load i8*, i8** %l12
  %t1050 = load i8*, i8** %l13
  %t1051 = load i8*, i8** %l21
  %t1052 = load double, double* %l22
  %t1053 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1054 = load double, double* %l26
  %t1055 = load i1, i1* %l27
  %t1056 = load i8*, i8** %l28
  %t1057 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1058 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1036, label %then86, label %else87
then86:
  %t1059 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1060 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1023685264, i32 0, i32 0
  %t1061 = load i8*, i8** %l28
  %t1062 = call i8* @sailfin_runtime_string_concat(i8* %s1060, i8* %t1061)
  %t1063 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1059, i8* %t1062)
  store { i8**, i64 }* %t1063, { i8**, i64 }** %l1
  %t1064 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge88
else87:
  %t1065 = load %NativeFunction*, %NativeFunction** %l8
  %t1066 = load %NativeParameter*, %NativeParameter** %l30
  %t1067 = load %NativeFunction, %NativeFunction* %t1065
  %t1068 = load %NativeParameter, %NativeParameter* %t1066
  %t1069 = call %NativeFunction @append_parameter(%NativeFunction %t1067, %NativeParameter %t1068)
  %t1070 = alloca %NativeFunction
  store %NativeFunction %t1069, %NativeFunction* %t1070
  store %NativeFunction* %t1070, %NativeFunction** %l8
  %t1071 = load %NativeParameter*, %NativeParameter** %l30
  %t1072 = getelementptr %NativeParameter, %NativeParameter* %t1071, i32 0, i32 4
  %t1073 = load %NativeSourceSpan*, %NativeSourceSpan** %t1072
  %t1074 = icmp ne %NativeSourceSpan* %t1073, null
  %t1075 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1076 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1077 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1078 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1079 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1080 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1081 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1082 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1083 = load %NativeFunction*, %NativeFunction** %l8
  %t1084 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1085 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1086 = load double, double* %l11
  %t1087 = load i8*, i8** %l12
  %t1088 = load i8*, i8** %l13
  %t1089 = load i8*, i8** %l21
  %t1090 = load double, double* %l22
  %t1091 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1092 = load double, double* %l26
  %t1093 = load i1, i1* %l27
  %t1094 = load i8*, i8** %l28
  %t1095 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1096 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1074, label %then89, label %merge90
then89:
  store i1 1, i1* %l27
  %t1097 = load i1, i1* %l27
  br label %merge90
merge90:
  %t1098 = phi i1 [ %t1097, %then89 ], [ %t1093, %else87 ]
  store i1 %t1098, i1* %l27
  %t1099 = load %NativeFunction*, %NativeFunction** %l8
  %t1100 = load i1, i1* %l27
  br label %merge88
merge88:
  %t1101 = phi { i8**, i64 }* [ %t1064, %then86 ], [ %t1038, %merge90 ]
  %t1102 = phi %NativeFunction* [ %t1045, %then86 ], [ %t1099, %merge90 ]
  %t1103 = phi i1 [ %t1055, %then86 ], [ %t1100, %merge90 ]
  store { i8**, i64 }* %t1101, { i8**, i64 }** %l1
  store %NativeFunction* %t1102, %NativeFunction** %l8
  store i1 %t1103, i1* %l27
  %t1104 = load double, double* %l26
  %t1105 = sitofp i64 1 to double
  %t1106 = fadd double %t1104, %t1105
  store double %t1106, double* %l26
  br label %loop.latch80
loop.latch80:
  %t1107 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1108 = load %NativeFunction*, %NativeFunction** %l8
  %t1109 = load i1, i1* %l27
  %t1110 = load double, double* %l26
  br label %loop.header78
afterloop81:
  %t1115 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1116 = load %NativeFunction*, %NativeFunction** %l8
  %t1117 = load i1, i1* %l27
  %t1118 = load double, double* %l26
  %t1119 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1119, %NativeSourceSpan** %l9
  %t1120 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1121 = load %NativeFunction*, %NativeFunction** %l8
  %t1122 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
merge77:
  %t1123 = phi { i8**, i64 }* [ %t949, %then75 ], [ %t1120, %afterloop81 ]
  %t1124 = phi %NativeSourceSpan* [ %t950, %then75 ], [ %t1122, %afterloop81 ]
  %t1125 = phi %NativeFunction* [ %t934, %then75 ], [ %t1121, %afterloop81 ]
  store { i8**, i64 }* %t1123, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1124, %NativeSourceSpan** %l9
  store %NativeFunction* %t1125, %NativeFunction** %l8
  %t1126 = load double, double* %l22
  %t1127 = sitofp i64 1 to double
  %t1128 = fsub double %t1126, %t1127
  store double %t1128, double* %l11
  %t1129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1130 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1131 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1132 = load %NativeFunction*, %NativeFunction** %l8
  %t1133 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1134 = load double, double* %l11
  br label %merge62
else61:
  %t1135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1136 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h712498791, i32 0, i32 0
  %t1137 = load i8*, i8** %l13
  %t1138 = call i8* @sailfin_runtime_string_concat(i8* %s1136, i8* %t1137)
  %t1139 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1135, i8* %t1138)
  store { i8**, i64 }* %t1139, { i8**, i64 }** %l1
  %t1140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge62
merge62:
  %t1141 = phi { i8**, i64 }* [ %t1129, %merge77 ], [ %t1140, %else61 ]
  %t1142 = phi %NativeSourceSpan* [ %t1130, %merge77 ], [ %t777, %else61 ]
  %t1143 = phi %NativeFunction* [ %t1132, %merge77 ], [ %t776, %else61 ]
  %t1144 = phi double [ %t1134, %merge77 ], [ %t779, %else61 ]
  store { i8**, i64 }* %t1141, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1142, %NativeSourceSpan** %l9
  store %NativeFunction* %t1143, %NativeFunction** %l8
  store double %t1144, double* %l11
  %t1145 = load double, double* %l11
  %t1146 = sitofp i64 1 to double
  %t1147 = fadd double %t1145, %t1146
  store double %t1147, double* %l11
  br label %loop.latch2
merge59:
  %t1148 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1149 = load double, double* %l11
  %t1150 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t1148, double %t1149)
  store %InstructionGatherResult %t1150, %InstructionGatherResult* %l31
  %t1151 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1152 = extractvalue %InstructionGatherResult %t1151, 0
  store i8* %t1152, i8** %l13
  %t1153 = load double, double* %l11
  %t1154 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1155 = extractvalue %InstructionGatherResult %t1154, 1
  %t1156 = fadd double %t1153, %t1155
  store double %t1156, double* %l11
  %t1157 = load i8*, i8** %l13
  %t1158 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1159 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1160 = call %InstructionParseResult @parse_instruction(i8* %t1157, %NativeSourceSpan* %t1158, %NativeSourceSpan* %t1159)
  store %InstructionParseResult %t1160, %InstructionParseResult* %l32
  %t1161 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1162 = extractvalue %InstructionParseResult %t1161, 0
  store { %NativeInstruction**, i64 }* %t1162, { %NativeInstruction**, i64 }** %l33
  %t1163 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1164 = extractvalue %InstructionParseResult %t1163, 1
  %t1165 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1166 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1167 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1168 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1169 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1170 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1171 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1172 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1173 = load %NativeFunction*, %NativeFunction** %l8
  %t1174 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1175 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1176 = load double, double* %l11
  %t1177 = load i8*, i8** %l12
  %t1178 = load i8*, i8** %l13
  %t1179 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1180 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1181 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1164, label %then91, label %else92
then91:
  %t1182 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1182, %NativeSourceSpan** %l9
  %t1183 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
else92:
  %t1184 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1185 = icmp ne %NativeSourceSpan* %t1184, null
  %t1186 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1187 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1188 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1189 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1190 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1191 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1192 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1193 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1194 = load %NativeFunction*, %NativeFunction** %l8
  %t1195 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1196 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1197 = load double, double* %l11
  %t1198 = load i8*, i8** %l12
  %t1199 = load i8*, i8** %l13
  %t1200 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1201 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1202 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1185, label %then94, label %merge95
then94:
  %t1203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1204 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t1205 = load i8*, i8** %l13
  %t1206 = call i8* @sailfin_runtime_string_concat(i8* %s1204, i8* %t1205)
  %t1207 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1203, i8* %t1206)
  store { i8**, i64 }* %t1207, { i8**, i64 }** %l1
  %t1208 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1208, %NativeSourceSpan** %l9
  %t1209 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1210 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge95
merge95:
  %t1211 = phi { i8**, i64 }* [ %t1209, %then94 ], [ %t1187, %else92 ]
  %t1212 = phi %NativeSourceSpan* [ %t1210, %then94 ], [ %t1195, %else92 ]
  store { i8**, i64 }* %t1211, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1212, %NativeSourceSpan** %l9
  %t1213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1214 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
merge93:
  %t1215 = phi %NativeSourceSpan* [ %t1183, %then91 ], [ %t1214, %merge95 ]
  %t1216 = phi { i8**, i64 }* [ %t1166, %then91 ], [ %t1213, %merge95 ]
  store %NativeSourceSpan* %t1215, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t1216, { i8**, i64 }** %l1
  %t1217 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1218 = extractvalue %InstructionParseResult %t1217, 2
  %t1219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1221 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1222 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1223 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1224 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1225 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1226 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1227 = load %NativeFunction*, %NativeFunction** %l8
  %t1228 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1229 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1230 = load double, double* %l11
  %t1231 = load i8*, i8** %l12
  %t1232 = load i8*, i8** %l13
  %t1233 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1234 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1235 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1218, label %then96, label %else97
then96:
  %t1236 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1236, %NativeSourceSpan** %l10
  %t1237 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
else97:
  %t1238 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1239 = icmp ne %NativeSourceSpan* %t1238, null
  %t1240 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1241 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1242 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1243 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1244 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1245 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1246 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1247 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1248 = load %NativeFunction*, %NativeFunction** %l8
  %t1249 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1250 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1251 = load double, double* %l11
  %t1252 = load i8*, i8** %l12
  %t1253 = load i8*, i8** %l13
  %t1254 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1255 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1256 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1239, label %then99, label %merge100
then99:
  %t1257 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1258 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t1259 = load i8*, i8** %l13
  %t1260 = call i8* @sailfin_runtime_string_concat(i8* %s1258, i8* %t1259)
  %t1261 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1257, i8* %t1260)
  store { i8**, i64 }* %t1261, { i8**, i64 }** %l1
  %t1262 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1262, %NativeSourceSpan** %l10
  %t1263 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1264 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge100
merge100:
  %t1265 = phi { i8**, i64 }* [ %t1263, %then99 ], [ %t1241, %else97 ]
  %t1266 = phi %NativeSourceSpan* [ %t1264, %then99 ], [ %t1250, %else97 ]
  store { i8**, i64 }* %t1265, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1266, %NativeSourceSpan** %l10
  %t1267 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1268 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
merge98:
  %t1269 = phi %NativeSourceSpan* [ %t1237, %then96 ], [ %t1268, %merge100 ]
  %t1270 = phi { i8**, i64 }* [ %t1220, %then96 ], [ %t1267, %merge100 ]
  store %NativeSourceSpan* %t1269, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t1270, { i8**, i64 }** %l1
  %t1271 = load %NativeFunction*, %NativeFunction** %l8
  %t1272 = icmp eq %NativeFunction* %t1271, null
  %t1273 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1274 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1275 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1276 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1277 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1278 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1279 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1280 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1281 = load %NativeFunction*, %NativeFunction** %l8
  %t1282 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1283 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1284 = load double, double* %l11
  %t1285 = load i8*, i8** %l12
  %t1286 = load i8*, i8** %l13
  %t1287 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1288 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1289 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1272, label %then101, label %merge102
then101:
  %t1291 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1292 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1291
  %t1293 = extractvalue { %NativeInstruction**, i64 } %t1292, 1
  %t1294 = icmp eq i64 %t1293, 1
  br label %logical_and_entry_1290

logical_and_entry_1290:
  br i1 %t1294, label %logical_and_right_1290, label %logical_and_merge_1290

logical_and_right_1290:
  %t1295 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1296 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1295
  %t1297 = extractvalue { %NativeInstruction**, i64 } %t1296, 0
  %t1298 = extractvalue { %NativeInstruction**, i64 } %t1296, 1
  %t1299 = icmp uge i64 0, %t1298
  ; bounds check: %t1299 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1298)
  %t1300 = getelementptr %NativeInstruction*, %NativeInstruction** %t1297, i64 0
  %t1301 = load %NativeInstruction*, %NativeInstruction** %t1300
  %t1302 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1301, i32 0, i32 0
  %t1303 = load i32, i32* %t1302
  %t1304 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1305 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1303, 0
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1303, 1
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1303, 2
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1303, 3
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1303, 4
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1303, 5
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1303, 6
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1303, 7
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1303, 8
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1303, 9
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1303, 10
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1303, 11
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1303, 12
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1303, 13
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1303, 14
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1303, 15
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1303, 16
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %s1356 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t1357 = call i1 @strings_equal(i8* %t1355, i8* %s1356)
  br label %logical_and_right_end_1290

logical_and_right_end_1290:
  br label %logical_and_merge_1290

logical_and_merge_1290:
  %t1358 = phi i1 [ false, %logical_and_entry_1290 ], [ %t1357, %logical_and_right_end_1290 ]
  %t1359 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1361 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1362 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1363 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1364 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1365 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1366 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1367 = load %NativeFunction*, %NativeFunction** %l8
  %t1368 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1369 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1370 = load double, double* %l11
  %t1371 = load i8*, i8** %l12
  %t1372 = load i8*, i8** %l13
  %t1373 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1374 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1375 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  br i1 %t1358, label %then103, label %else104
then103:
  %t1376 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1377 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1378 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1377
  %t1379 = extractvalue { %NativeInstruction**, i64 } %t1378, 0
  %t1380 = extractvalue { %NativeInstruction**, i64 } %t1378, 1
  %t1381 = icmp uge i64 0, %t1380
  ; bounds check: %t1381 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1380)
  %t1382 = getelementptr %NativeInstruction*, %NativeInstruction** %t1379, i64 0
  %t1383 = load %NativeInstruction*, %NativeInstruction** %t1382
  %t1384 = load %NativeInstruction, %NativeInstruction* %t1383
  %t1385 = call %NativeBinding @binding_from_instruction(%NativeInstruction %t1384)
  %t1386 = call { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %t1376, %NativeBinding %t1385)
  store { %NativeBinding*, i64 }* %t1386, { %NativeBinding*, i64 }** %l7
  %t1387 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %merge105
else104:
  %t1388 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1389 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.len47.h1886628617, i32 0, i32 0
  %t1390 = load i8*, i8** %l13
  %t1391 = call i8* @sailfin_runtime_string_concat(i8* %s1389, i8* %t1390)
  %t1392 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1388, i8* %t1391)
  store { i8**, i64 }* %t1392, { i8**, i64 }** %l1
  %t1393 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge105
merge105:
  %t1394 = phi { %NativeBinding*, i64 }* [ %t1387, %then103 ], [ %t1366, %else104 ]
  %t1395 = phi { i8**, i64 }* [ %t1360, %then103 ], [ %t1393, %else104 ]
  store { %NativeBinding*, i64 }* %t1394, { %NativeBinding*, i64 }** %l7
  store { i8**, i64 }* %t1395, { i8**, i64 }** %l1
  %t1396 = load double, double* %l11
  %t1397 = sitofp i64 1 to double
  %t1398 = fadd double %t1396, %t1397
  store double %t1398, double* %l11
  br label %loop.latch2
merge102:
  %t1399 = sitofp i64 0 to double
  store double %t1399, double* %l34
  %t1400 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1401 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1402 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1403 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1404 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1405 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1406 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1407 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1408 = load %NativeFunction*, %NativeFunction** %l8
  %t1409 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1410 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1411 = load double, double* %l11
  %t1412 = load i8*, i8** %l12
  %t1413 = load i8*, i8** %l13
  %t1414 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1415 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1416 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1417 = load double, double* %l34
  br label %loop.header106
loop.header106:
  %t1462 = phi %NativeFunction* [ %t1408, %merge102 ], [ %t1460, %loop.latch108 ]
  %t1463 = phi double [ %t1417, %merge102 ], [ %t1461, %loop.latch108 ]
  store %NativeFunction* %t1462, %NativeFunction** %l8
  store double %t1463, double* %l34
  br label %loop.body107
loop.body107:
  %t1418 = load double, double* %l34
  %t1419 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1420 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1419
  %t1421 = extractvalue { %NativeInstruction**, i64 } %t1420, 1
  %t1422 = sitofp i64 %t1421 to double
  %t1423 = fcmp oge double %t1418, %t1422
  %t1424 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1425 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1426 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1427 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1428 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1429 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1430 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1431 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1432 = load %NativeFunction*, %NativeFunction** %l8
  %t1433 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1434 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1435 = load double, double* %l11
  %t1436 = load i8*, i8** %l12
  %t1437 = load i8*, i8** %l13
  %t1438 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1439 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1440 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1441 = load double, double* %l34
  br i1 %t1423, label %then110, label %merge111
then110:
  br label %afterloop109
merge111:
  %t1442 = load %NativeFunction*, %NativeFunction** %l8
  %t1443 = load { %NativeInstruction**, i64 }*, { %NativeInstruction**, i64 }** %l33
  %t1444 = load double, double* %l34
  %t1445 = call double @llvm.round.f64(double %t1444)
  %t1446 = fptosi double %t1445 to i64
  %t1447 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1443
  %t1448 = extractvalue { %NativeInstruction**, i64 } %t1447, 0
  %t1449 = extractvalue { %NativeInstruction**, i64 } %t1447, 1
  %t1450 = icmp uge i64 %t1446, %t1449
  ; bounds check: %t1450 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1446, i64 %t1449)
  %t1451 = getelementptr %NativeInstruction*, %NativeInstruction** %t1448, i64 %t1446
  %t1452 = load %NativeInstruction*, %NativeInstruction** %t1451
  %t1453 = load %NativeFunction, %NativeFunction* %t1442
  %t1454 = load %NativeInstruction, %NativeInstruction* %t1452
  %t1455 = call %NativeFunction @append_instruction(%NativeFunction %t1453, %NativeInstruction %t1454)
  %t1456 = alloca %NativeFunction
  store %NativeFunction %t1455, %NativeFunction* %t1456
  store %NativeFunction* %t1456, %NativeFunction** %l8
  %t1457 = load double, double* %l34
  %t1458 = sitofp i64 1 to double
  %t1459 = fadd double %t1457, %t1458
  store double %t1459, double* %l34
  br label %loop.latch108
loop.latch108:
  %t1460 = load %NativeFunction*, %NativeFunction** %l8
  %t1461 = load double, double* %l34
  br label %loop.header106
afterloop109:
  %t1464 = load %NativeFunction*, %NativeFunction** %l8
  %t1465 = load double, double* %l34
  %t1466 = load double, double* %l11
  %t1467 = sitofp i64 1 to double
  %t1468 = fadd double %t1466, %t1467
  store double %t1468, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1469 = load double, double* %l11
  %t1470 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1471 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1472 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1473 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1474 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1475 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1476 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1477 = load %NativeFunction*, %NativeFunction** %l8
  %t1478 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1479 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %loop.header0
afterloop3:
  %t1491 = load double, double* %l11
  %t1492 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1493 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1494 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1495 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1496 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1497 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1498 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1499 = load %NativeFunction*, %NativeFunction** %l8
  %t1500 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1501 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1502 = load %NativeFunction*, %NativeFunction** %l8
  %t1503 = icmp ne %NativeFunction* %t1502, null
  %t1504 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1505 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1506 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1507 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1508 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1509 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1510 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1511 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1512 = load %NativeFunction*, %NativeFunction** %l8
  %t1513 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1514 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1515 = load double, double* %l11
  br i1 %t1503, label %then112, label %merge113
then112:
  %t1516 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1517 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h1512965366, i32 0, i32 0
  %t1518 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1516, i8* %s1517)
  store { i8**, i64 }* %t1518, { i8**, i64 }** %l1
  %t1519 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge113
merge113:
  %t1520 = phi { i8**, i64 }* [ %t1519, %then112 ], [ %t1505, %afterloop3 ]
  store { i8**, i64 }* %t1520, { i8**, i64 }** %l1
  %t1521 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1522 = bitcast { %NativeFunction*, i64 }* %t1521 to { %NativeFunction**, i64 }*
  %t1523 = insertvalue %ParseNativeResult undef, { %NativeFunction**, i64 }* %t1522, 0
  %t1524 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1525 = bitcast { %NativeImport*, i64 }* %t1524 to { %NativeImport**, i64 }*
  %t1526 = insertvalue %ParseNativeResult %t1523, { %NativeImport**, i64 }* %t1525, 1
  %t1527 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1528 = bitcast { %NativeStruct*, i64 }* %t1527 to { %NativeStruct**, i64 }*
  %t1529 = insertvalue %ParseNativeResult %t1526, { %NativeStruct**, i64 }* %t1528, 2
  %t1530 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1531 = bitcast { %NativeInterface*, i64 }* %t1530 to { %NativeInterface**, i64 }*
  %t1532 = insertvalue %ParseNativeResult %t1529, { %NativeInterface**, i64 }* %t1531, 3
  %t1533 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1534 = bitcast { %NativeEnum*, i64 }* %t1533 to { %NativeEnum**, i64 }*
  %t1535 = insertvalue %ParseNativeResult %t1532, { %NativeEnum**, i64 }* %t1534, 4
  %t1536 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1537 = bitcast { %NativeBinding*, i64 }* %t1536 to { %NativeBinding**, i64 }*
  %t1538 = insertvalue %ParseNativeResult %t1535, { %NativeBinding**, i64 }* %t1537, 5
  %t1539 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1540 = insertvalue %ParseNativeResult %t1538, { i8**, i64 }* %t1539, 6
  ret %ParseNativeResult %t1540
}

define %NativeSourceSpan* @parse_source_span(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NumberParseResult
  %l3 = alloca %NumberParseResult
  %l4 = alloca %NumberParseResult
  %l5 = alloca %NumberParseResult
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t5
merge1:
  %t6 = load i8*, i8** %l0
  %t7 = call { i8**, i64 }* @split_whitespace(i8* %t6)
  store { i8**, i64 }* %t7, { i8**, i64 }** %l1
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t9 = load { i8**, i64 }, { i8**, i64 }* %t8
  %t10 = extractvalue { i8**, i64 } %t9, 1
  %t11 = icmp ne i64 %t10, 4
  %t12 = load i8*, i8** %l0
  %t13 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t11, label %then2, label %merge3
then2:
  %t14 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t14
merge3:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t16 = load { i8**, i64 }, { i8**, i64 }* %t15
  %t17 = extractvalue { i8**, i64 } %t16, 0
  %t18 = extractvalue { i8**, i64 } %t16, 1
  %t19 = icmp uge i64 0, %t18
  ; bounds check: %t19 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t18)
  %t20 = getelementptr i8*, i8** %t17, i64 0
  %t21 = load i8*, i8** %t20
  %t22 = call %NumberParseResult @parse_decimal_number(i8* %t21)
  store %NumberParseResult %t22, %NumberParseResult* %l2
  %t23 = load %NumberParseResult, %NumberParseResult* %l2
  %t24 = extractvalue %NumberParseResult %t23, 0
  %t25 = xor i1 %t24, 1
  %t26 = load i8*, i8** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load %NumberParseResult, %NumberParseResult* %l2
  br i1 %t25, label %then4, label %merge5
then4:
  %t29 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t29
merge5:
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = load { i8**, i64 }, { i8**, i64 }* %t30
  %t32 = extractvalue { i8**, i64 } %t31, 0
  %t33 = extractvalue { i8**, i64 } %t31, 1
  %t34 = icmp uge i64 1, %t33
  ; bounds check: %t34 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 1, i64 %t33)
  %t35 = getelementptr i8*, i8** %t32, i64 1
  %t36 = load i8*, i8** %t35
  %t37 = call %NumberParseResult @parse_decimal_number(i8* %t36)
  store %NumberParseResult %t37, %NumberParseResult* %l3
  %t38 = load %NumberParseResult, %NumberParseResult* %l3
  %t39 = extractvalue %NumberParseResult %t38, 0
  %t40 = xor i1 %t39, 1
  %t41 = load i8*, i8** %l0
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t43 = load %NumberParseResult, %NumberParseResult* %l2
  %t44 = load %NumberParseResult, %NumberParseResult* %l3
  br i1 %t40, label %then6, label %merge7
then6:
  %t45 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t45
merge7:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 0
  %t49 = extractvalue { i8**, i64 } %t47, 1
  %t50 = icmp uge i64 2, %t49
  ; bounds check: %t50 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 2, i64 %t49)
  %t51 = getelementptr i8*, i8** %t48, i64 2
  %t52 = load i8*, i8** %t51
  %t53 = call %NumberParseResult @parse_decimal_number(i8* %t52)
  store %NumberParseResult %t53, %NumberParseResult* %l4
  %t54 = load %NumberParseResult, %NumberParseResult* %l4
  %t55 = extractvalue %NumberParseResult %t54, 0
  %t56 = xor i1 %t55, 1
  %t57 = load i8*, i8** %l0
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t59 = load %NumberParseResult, %NumberParseResult* %l2
  %t60 = load %NumberParseResult, %NumberParseResult* %l3
  %t61 = load %NumberParseResult, %NumberParseResult* %l4
  br i1 %t56, label %then8, label %merge9
then8:
  %t62 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t62
merge9:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t63
  %t65 = extractvalue { i8**, i64 } %t64, 0
  %t66 = extractvalue { i8**, i64 } %t64, 1
  %t67 = icmp uge i64 3, %t66
  ; bounds check: %t67 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 3, i64 %t66)
  %t68 = getelementptr i8*, i8** %t65, i64 3
  %t69 = load i8*, i8** %t68
  %t70 = call %NumberParseResult @parse_decimal_number(i8* %t69)
  store %NumberParseResult %t70, %NumberParseResult* %l5
  %t71 = load %NumberParseResult, %NumberParseResult* %l5
  %t72 = extractvalue %NumberParseResult %t71, 0
  %t73 = xor i1 %t72, 1
  %t74 = load i8*, i8** %l0
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load %NumberParseResult, %NumberParseResult* %l2
  %t77 = load %NumberParseResult, %NumberParseResult* %l3
  %t78 = load %NumberParseResult, %NumberParseResult* %l4
  %t79 = load %NumberParseResult, %NumberParseResult* %l5
  br i1 %t73, label %then10, label %merge11
then10:
  %t80 = bitcast i8* null to %NativeSourceSpan*
  ret %NativeSourceSpan* %t80
merge11:
  %t81 = load %NumberParseResult, %NumberParseResult* %l2
  %t82 = extractvalue %NumberParseResult %t81, 1
  %t83 = insertvalue %NativeSourceSpan undef, double %t82, 0
  %t84 = load %NumberParseResult, %NumberParseResult* %l3
  %t85 = extractvalue %NumberParseResult %t84, 1
  %t86 = insertvalue %NativeSourceSpan %t83, double %t85, 1
  %t87 = load %NumberParseResult, %NumberParseResult* %l4
  %t88 = extractvalue %NumberParseResult %t87, 1
  %t89 = insertvalue %NativeSourceSpan %t86, double %t88, 2
  %t90 = load %NumberParseResult, %NumberParseResult* %l5
  %t91 = extractvalue %NumberParseResult %t90, 1
  %t92 = insertvalue %NativeSourceSpan %t89, double %t91, 3
  %t93 = alloca %NativeSourceSpan
  store %NativeSourceSpan %t92, %NativeSourceSpan* %t93
  ret %NativeSourceSpan* %t93
}

define { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %functions, %NativeFunction %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeFunction*
  store %NativeFunction %value, %NativeFunction* %t1
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
  %t15 = bitcast { %NativeFunction*, i64 }* %functions to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeFunction*, i64 }*
  ret { %NativeFunction*, i64 }* %t17
}

define { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %bindings, %NativeBinding %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 32)
  %t1 = bitcast i8* %t0 to %NativeBinding*
  store %NativeBinding %value, %NativeBinding* %t1
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
  %t15 = bitcast { %NativeBinding*, i64 }* %bindings to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeBinding*, i64 }*
  ret { %NativeBinding*, i64 }* %t17
}

define { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %imports, %NativeImport %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeImport*
  store %NativeImport %value, %NativeImport* %t1
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
  %t15 = bitcast { %NativeImport*, i64 }* %imports to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeImport*, i64 }*
  ret { %NativeImport*, i64 }* %t17
}

define { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %structs, %NativeStruct %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeStruct*
  store %NativeStruct %value, %NativeStruct* %t1
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
  %t15 = bitcast { %NativeStruct*, i64 }* %structs to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeStruct*, i64 }*
  ret { %NativeStruct*, i64 }* %t17
}

define { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %interfaces, %NativeInterface %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeInterface*
  store %NativeInterface %value, %NativeInterface* %t1
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
  %t15 = bitcast { %NativeInterface*, i64 }* %interfaces to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeInterface*, i64 }*
  ret { %NativeInterface*, i64 }* %t17
}

define { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %enums, %NativeEnum %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeEnum*
  store %NativeEnum %value, %NativeEnum* %t1
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
  %t15 = bitcast { %NativeEnum*, i64 }* %enums to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeEnum*, i64 }*
  ret { %NativeEnum*, i64 }* %t17
}

define { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %variants, %NativeEnumVariant %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 16)
  %t1 = bitcast i8* %t0 to %NativeEnumVariant*
  store %NativeEnumVariant %value, %NativeEnumVariant* %t1
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
  %t15 = bitcast { %NativeEnumVariant*, i64 }* %variants to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeEnumVariant*, i64 }*
  ret { %NativeEnumVariant*, i64 }* %t17
}

define { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %fields, %NativeEnumVariantField %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeEnumVariantField*
  store %NativeEnumVariantField %value, %NativeEnumVariantField* %t1
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
  %t15 = bitcast { %NativeEnumVariantField*, i64 }* %fields to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeEnumVariantField*, i64 }*
  ret { %NativeEnumVariantField*, i64 }* %t17
}

define { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %fields, %NativeStructField %field) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 24)
  %t1 = bitcast i8* %t0 to %NativeStructField*
  store %NativeStructField %field, %NativeStructField* %t1
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
  %t15 = bitcast { %NativeStructField*, i64 }* %fields to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeStructField*, i64 }*
  ret { %NativeStructField*, i64 }* %t17
}

define { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %fields, %NativeStructLayoutField %field) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeStructLayoutField*
  store %NativeStructLayoutField %field, %NativeStructLayoutField* %t1
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
  %t15 = bitcast { %NativeStructLayoutField*, i64 }* %fields to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeStructLayoutField*, i64 }*
  ret { %NativeStructLayoutField*, i64 }* %t17
}

define { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %variants, %NativeEnumVariantLayout %value) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 48)
  %t1 = bitcast i8* %t0 to %NativeEnumVariantLayout*
  store %NativeEnumVariantLayout %value, %NativeEnumVariantLayout* %t1
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
  %t15 = bitcast { %NativeEnumVariantLayout*, i64 }* %variants to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeEnumVariantLayout*, i64 }*
  ret { %NativeEnumVariantLayout*, i64 }* %t17
}

define double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %variants, i8* %name) {
block.entry:
  %l0 = alloca double
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = load double, double* %l0
  br label %loop.header0
loop.header0:
  %t25 = phi double [ %t1, %block.entry ], [ %t24, %loop.latch2 ]
  store double %t25, double* %l0
  br label %loop.body1
loop.body1:
  %t2 = load double, double* %l0
  %t3 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t4 = extractvalue { %NativeEnumVariantLayout*, i64 } %t3, 1
  %t5 = sitofp i64 %t4 to double
  %t6 = fcmp oge double %t2, %t5
  %t7 = load double, double* %l0
  br i1 %t6, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t8 = load double, double* %l0
  %t9 = call double @llvm.round.f64(double %t8)
  %t10 = fptosi double %t9 to i64
  %t11 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t12 = extractvalue { %NativeEnumVariantLayout*, i64 } %t11, 0
  %t13 = extractvalue { %NativeEnumVariantLayout*, i64 } %t11, 1
  %t14 = icmp uge i64 %t10, %t13
  ; bounds check: %t14 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t10, i64 %t13)
  %t15 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t12, i64 %t10
  %t16 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t15
  %t17 = extractvalue %NativeEnumVariantLayout %t16, 0
  %t18 = call i1 @strings_equal(i8* %t17, i8* %name)
  %t19 = load double, double* %l0
  br i1 %t18, label %then6, label %merge7
then6:
  %t20 = load double, double* %l0
  ret double %t20
merge7:
  %t21 = load double, double* %l0
  %t22 = sitofp i64 1 to double
  %t23 = fadd double %t21, %t22
  store double %t23, double* %l0
  br label %loop.latch2
loop.latch2:
  %t24 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t26 = load double, double* %l0
  %t27 = sitofp i64 -1 to double
  ret double %t27
}

define { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %variants, double %index, %NativeStructLayoutField %field) {
block.entry:
  %l0 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l1 = alloca double
  %l2 = alloca %NativeEnumVariantLayout
  %l3 = alloca %NativeEnumVariantLayout
  %t0 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t1 = ptrtoint [0 x %NativeEnumVariantLayout]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeEnumVariantLayout*
  %t6 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t7 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t6 to i64
  %t8 = call i8* @malloc(i64 %t7)
  %t9 = bitcast i8* %t8 to { %NativeEnumVariantLayout*, i64 }*
  %t10 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t9, i32 0, i32 0
  store %NativeEnumVariantLayout* %t5, %NativeEnumVariantLayout** %t10
  %t11 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t9, i32 0, i32 1
  store i64 0, i64* %t11
  store { %NativeEnumVariantLayout*, i64 }* %t9, { %NativeEnumVariantLayout*, i64 }** %l0
  %t12 = sitofp i64 0 to double
  store double %t12, double* %l1
  %t13 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t14 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t78 = phi { %NativeEnumVariantLayout*, i64 }* [ %t13, %block.entry ], [ %t76, %loop.latch2 ]
  %t79 = phi double [ %t14, %block.entry ], [ %t77, %loop.latch2 ]
  store { %NativeEnumVariantLayout*, i64 }* %t78, { %NativeEnumVariantLayout*, i64 }** %l0
  store double %t79, double* %l1
  br label %loop.body1
loop.body1:
  %t15 = load double, double* %l1
  %t16 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t17 = extractvalue { %NativeEnumVariantLayout*, i64 } %t16, 1
  %t18 = sitofp i64 %t17 to double
  %t19 = fcmp oge double %t15, %t18
  %t20 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t21 = load double, double* %l1
  br i1 %t19, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l1
  %t23 = fcmp oeq double %t22, %index
  %t24 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t25 = load double, double* %l1
  br i1 %t23, label %then6, label %else7
then6:
  %t26 = load double, double* %l1
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t30 = extractvalue { %NativeEnumVariantLayout*, i64 } %t29, 0
  %t31 = extractvalue { %NativeEnumVariantLayout*, i64 } %t29, 1
  %t32 = icmp uge i64 %t28, %t31
  ; bounds check: %t32 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t28, i64 %t31)
  %t33 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t30, i64 %t28
  %t34 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t33
  store %NativeEnumVariantLayout %t34, %NativeEnumVariantLayout* %l2
  %t35 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t36 = extractvalue %NativeEnumVariantLayout %t35, 0
  %t37 = insertvalue %NativeEnumVariantLayout undef, i8* %t36, 0
  %t38 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t39 = extractvalue %NativeEnumVariantLayout %t38, 1
  %t40 = insertvalue %NativeEnumVariantLayout %t37, double %t39, 1
  %t41 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t42 = extractvalue %NativeEnumVariantLayout %t41, 2
  %t43 = insertvalue %NativeEnumVariantLayout %t40, double %t42, 2
  %t44 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t45 = extractvalue %NativeEnumVariantLayout %t44, 3
  %t46 = insertvalue %NativeEnumVariantLayout %t43, double %t45, 3
  %t47 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t48 = extractvalue %NativeEnumVariantLayout %t47, 4
  %t49 = insertvalue %NativeEnumVariantLayout %t46, double %t48, 4
  %t50 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t51 = extractvalue %NativeEnumVariantLayout %t50, 5
  %t52 = bitcast { %NativeStructLayoutField**, i64 }* %t51 to { %NativeStructLayoutField*, i64 }*
  %t53 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t52, %NativeStructLayoutField %field)
  %t54 = bitcast { %NativeStructLayoutField*, i64 }* %t53 to { %NativeStructLayoutField**, i64 }*
  %t55 = insertvalue %NativeEnumVariantLayout %t49, { %NativeStructLayoutField**, i64 }* %t54, 5
  store %NativeEnumVariantLayout %t55, %NativeEnumVariantLayout* %l3
  %t56 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t57 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l3
  %t58 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t56, %NativeEnumVariantLayout %t57)
  store { %NativeEnumVariantLayout*, i64 }* %t58, { %NativeEnumVariantLayout*, i64 }** %l0
  %t59 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
else7:
  %t60 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t61 = load double, double* %l1
  %t62 = call double @llvm.round.f64(double %t61)
  %t63 = fptosi double %t62 to i64
  %t64 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t65 = extractvalue { %NativeEnumVariantLayout*, i64 } %t64, 0
  %t66 = extractvalue { %NativeEnumVariantLayout*, i64 } %t64, 1
  %t67 = icmp uge i64 %t63, %t66
  ; bounds check: %t67 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t63, i64 %t66)
  %t68 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t65, i64 %t63
  %t69 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t68
  %t70 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t60, %NativeEnumVariantLayout %t69)
  store { %NativeEnumVariantLayout*, i64 }* %t70, { %NativeEnumVariantLayout*, i64 }** %l0
  %t71 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
merge8:
  %t72 = phi { %NativeEnumVariantLayout*, i64 }* [ %t59, %then6 ], [ %t71, %else7 ]
  store { %NativeEnumVariantLayout*, i64 }* %t72, { %NativeEnumVariantLayout*, i64 }** %l0
  %t73 = load double, double* %l1
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l1
  br label %loop.latch2
loop.latch2:
  %t76 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t77 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t80 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t81 = load double, double* %l1
  %t82 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  ret { %NativeEnumVariantLayout*, i64 }* %t82
}

define %NativeFunction @append_parameter(%NativeFunction %function, %NativeParameter %parameter) {
block.entry:
  %l0 = alloca { %NativeParameter*, i64 }*
  %t0 = extractvalue %NativeFunction %function, 1
  %t1 = bitcast { %NativeParameter**, i64 }* %t0 to { %NativeParameter*, i64 }*
  %t2 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t1, %NativeParameter %parameter)
  store { %NativeParameter*, i64 }* %t2, { %NativeParameter*, i64 }** %l0
  %t3 = extractvalue %NativeFunction %function, 0
  %t4 = insertvalue %NativeFunction undef, i8* %t3, 0
  %t5 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l0
  %t6 = bitcast { %NativeParameter*, i64 }* %t5 to { %NativeParameter**, i64 }*
  %t7 = insertvalue %NativeFunction %t4, { %NativeParameter**, i64 }* %t6, 1
  %t8 = extractvalue %NativeFunction %function, 2
  %t9 = insertvalue %NativeFunction %t7, i8* %t8, 2
  %t10 = extractvalue %NativeFunction %function, 3
  %t11 = insertvalue %NativeFunction %t9, { i8**, i64 }* %t10, 3
  %t12 = extractvalue %NativeFunction %function, 4
  %t13 = insertvalue %NativeFunction %t11, { %NativeInstruction**, i64 }* %t12, 4
  ret %NativeFunction %t13
}

define %NativeFunction @append_instruction(%NativeFunction %function, %NativeInstruction %instruction) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %t0 = extractvalue %NativeFunction %function, 4
  %t1 = call noalias i8* @malloc(i64 56)
  %t2 = bitcast i8* %t1 to %NativeInstruction*
  store %NativeInstruction %instruction, %NativeInstruction* %t2
  %t3 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t4 = ptrtoint [1 x i8*]* %t3 to i64
  %t5 = icmp eq i64 %t4, 0
  %t6 = select i1 %t5, i64 1, i64 %t4
  %t7 = call i8* @malloc(i64 %t6)
  %t8 = bitcast i8* %t7 to i8**
  %t9 = getelementptr i8*, i8** %t8, i64 0
  store i8* %t1, i8** %t9
  %t10 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t11 = ptrtoint { i8**, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { i8**, i64 }*
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 0
  store i8** %t8, i8*** %t14
  %t15 = getelementptr { i8**, i64 }, { i8**, i64 }* %t13, i32 0, i32 1
  store i64 1, i64* %t15
  %t16 = bitcast { %NativeInstruction**, i64 }* %t0 to { i8**, i64 }*
  %t17 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t16, { i8**, i64 }* %t13)
  store { i8**, i64 }* %t17, { i8**, i64 }** %l0
  %t18 = extractvalue %NativeFunction %function, 0
  %t19 = insertvalue %NativeFunction undef, i8* %t18, 0
  %t20 = extractvalue %NativeFunction %function, 1
  %t21 = insertvalue %NativeFunction %t19, { %NativeParameter**, i64 }* %t20, 1
  %t22 = extractvalue %NativeFunction %function, 2
  %t23 = insertvalue %NativeFunction %t21, i8* %t22, 2
  %t24 = extractvalue %NativeFunction %function, 3
  %t25 = insertvalue %NativeFunction %t23, { i8**, i64 }* %t24, 3
  %t26 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t27 = bitcast { i8**, i64 }* %t26 to { %NativeInstruction**, i64 }*
  %t28 = insertvalue %NativeFunction %t25, { %NativeInstruction**, i64 }* %t27, 4
  ret %NativeFunction %t28
}

define %NativeBinding @binding_from_instruction(%NativeInstruction %instruction) {
block.entry:
  %t0 = extractvalue %NativeInstruction %instruction, 0
  %t1 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t1
  %t2 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t1, i32 0, i32 1
  %t3 = bitcast [48 x i8]* %t2 to i8*
  %t4 = bitcast i8* %t3 to i8**
  %t5 = load i8*, i8** %t4
  %t6 = icmp eq i32 %t0, 2
  %t7 = select i1 %t6, i8* %t5, i8* null
  %t8 = insertvalue %NativeBinding undef, i8* %t7, 0
  %t9 = extractvalue %NativeInstruction %instruction, 0
  %t10 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t10
  %t11 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t12 = bitcast [48 x i8]* %t11 to i8*
  %t13 = getelementptr inbounds i8, i8* %t12, i64 8
  %t14 = bitcast i8* %t13 to i1*
  %t15 = load i1, i1* %t14
  %t16 = icmp eq i32 %t9, 2
  %t17 = select i1 %t16, i1 %t15, i1 false
  %t18 = insertvalue %NativeBinding %t8, i1 %t17, 1
  %t19 = extractvalue %NativeInstruction %instruction, 0
  %t20 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t20
  %t21 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t22 = bitcast [48 x i8]* %t21 to i8*
  %t23 = getelementptr inbounds i8, i8* %t22, i64 16
  %t24 = bitcast i8* %t23 to i8**
  %t25 = load i8*, i8** %t24
  %t26 = icmp eq i32 %t19, 2
  %t27 = select i1 %t26, i8* %t25, i8* null
  %t28 = insertvalue %NativeBinding %t18, i8* %t27, 2
  %t29 = extractvalue %NativeInstruction %instruction, 0
  %t30 = alloca %NativeInstruction
  store %NativeInstruction %instruction, %NativeInstruction* %t30
  %t31 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t30, i32 0, i32 1
  %t32 = bitcast [48 x i8]* %t31 to i8*
  %t33 = getelementptr inbounds i8, i8* %t32, i64 24
  %t34 = bitcast i8* %t33 to i8**
  %t35 = load i8*, i8** %t34
  %t36 = icmp eq i32 %t29, 2
  %t37 = select i1 %t36, i8* %t35, i8* null
  %t38 = insertvalue %NativeBinding %t28, i8* %t37, 3
  ret %NativeBinding %t38
}

define %NativeFunction @apply_meta(%NativeFunction %function, i8* %entry) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca { i8**, i64 }*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l1
  %t9 = load i8*, i8** %l1
  %t10 = extractvalue %NativeFunction %function, 3
  %t11 = call %NativeFunction @update_function_meta(%NativeFunction %function, i8* %t9, { i8**, i64 }* %t10)
  ret %NativeFunction %t11
merge1:
  %t12 = load i8*, i8** %l0
  %s13 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h787332764, i32 0, i32 0
  %t14 = call i1 @starts_with(i8* %t12, i8* %s13)
  %t15 = load i8*, i8** %l0
  br i1 %t14, label %then2, label %merge3
then2:
  %t16 = load i8*, i8** %l0
  %s17 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h787332764, i32 0, i32 0
  %t18 = call i8* @strip_prefix(i8* %t16, i8* %s17)
  %t19 = call i8* @trim_text(i8* %t18)
  store i8* %t19, i8** %l2
  %t20 = load i8*, i8** %l2
  %t21 = call { i8**, i64 }* @parse_effect_list(i8* %t20)
  store { i8**, i64 }* %t21, { i8**, i64 }** %l3
  %t22 = extractvalue %NativeFunction %function, 2
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t24 = call %NativeFunction @update_function_meta(%NativeFunction %function, i8* %t22, { i8**, i64 }* %t23)
  ret %NativeFunction %t24
merge3:
  ret %NativeFunction %function
}

define %NativeFunction @update_function_meta(%NativeFunction %function, i8* %return_type, { i8**, i64 }* %effects) {
block.entry:
  %t0 = extractvalue %NativeFunction %function, 0
  %t1 = insertvalue %NativeFunction undef, i8* %t0, 0
  %t2 = extractvalue %NativeFunction %function, 1
  %t3 = insertvalue %NativeFunction %t1, { %NativeParameter**, i64 }* %t2, 1
  %t4 = insertvalue %NativeFunction %t3, i8* %return_type, 2
  %t5 = insertvalue %NativeFunction %t4, { i8**, i64 }* %effects, 3
  %t6 = extractvalue %NativeFunction %function, 4
  %t7 = insertvalue %NativeFunction %t5, { %NativeInstruction**, i64 }* %t6, 4
  ret %NativeFunction %t7
}

define %InstructionGatherResult @gather_instruction({ i8**, i64 }* %lines, double %start_index) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %InstructionDepthState
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %t0 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t1 = extractvalue { i8**, i64 } %t0, 1
  %t2 = sitofp i64 %t1 to double
  %t3 = fcmp oge double %start_index, %t2
  br i1 %t3, label %then0, label %merge1
then0:
  %s4 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t5 = insertvalue %InstructionGatherResult undef, i8* %s4, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %InstructionGatherResult %t5, double %t6, 1
  ret %InstructionGatherResult %t7
merge1:
  %t8 = call double @llvm.round.f64(double %start_index)
  %t9 = fptosi double %t8 to i64
  %t10 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t11 = extractvalue { i8**, i64 } %t10, 0
  %t12 = extractvalue { i8**, i64 } %t10, 1
  %t13 = icmp uge i64 %t9, %t12
  ; bounds check: %t13 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t9, i64 %t12)
  %t14 = getelementptr i8*, i8** %t11, i64 %t9
  %t15 = load i8*, i8** %t14
  %t16 = call i8* @trim_text(i8* %t15)
  store i8* %t16, i8** %l0
  %t17 = load i8*, i8** %l0
  %t18 = call i64 @sailfin_runtime_string_length(i8* %t17)
  %t19 = icmp eq i64 %t18, 0
  %t20 = load i8*, i8** %l0
  br i1 %t19, label %then2, label %merge3
then2:
  %t21 = load i8*, i8** %l0
  %t22 = insertvalue %InstructionGatherResult undef, i8* %t21, 0
  %t23 = sitofp i64 0 to double
  %t24 = insertvalue %InstructionGatherResult %t22, double %t23, 1
  ret %InstructionGatherResult %t24
merge3:
  %t25 = load i8*, i8** %l0
  %t26 = call i1 @instruction_supports_multiline(i8* %t25)
  %t27 = xor i1 %t26, 1
  %t28 = load i8*, i8** %l0
  br i1 %t27, label %then4, label %merge5
then4:
  %t29 = load i8*, i8** %l0
  %t30 = insertvalue %InstructionGatherResult undef, i8* %t29, 0
  %t31 = sitofp i64 0 to double
  %t32 = insertvalue %InstructionGatherResult %t30, double %t31, 1
  ret %InstructionGatherResult %t32
merge5:
  %t33 = call %InstructionDepthState @initial_instruction_depth_state()
  %t34 = load i8*, i8** %l0
  %t35 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t33, i8* %t34)
  store %InstructionDepthState %t35, %InstructionDepthState* %l1
  %t36 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t37 = call i1 @instruction_requires_continuation(%InstructionDepthState %t36)
  %t38 = xor i1 %t37, 1
  %t39 = load i8*, i8** %l0
  %t40 = load %InstructionDepthState, %InstructionDepthState* %l1
  br i1 %t38, label %then6, label %merge7
then6:
  %t41 = load i8*, i8** %l0
  %t42 = insertvalue %InstructionGatherResult undef, i8* %t41, 0
  %t43 = sitofp i64 0 to double
  %t44 = insertvalue %InstructionGatherResult %t42, double %t43, 1
  ret %InstructionGatherResult %t44
merge7:
  %t45 = load i8*, i8** %l0
  store i8* %t45, i8** %l2
  %t46 = sitofp i64 0 to double
  store double %t46, double* %l3
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %start_index, %t47
  store double %t48, double* %l4
  %t49 = load i8*, i8** %l0
  %t50 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t51 = load i8*, i8** %l2
  %t52 = load double, double* %l3
  %t53 = load double, double* %l4
  br label %loop.header8
loop.header8:
  %t124 = phi i8* [ %t51, %merge7 ], [ %t120, %loop.latch10 ]
  %t125 = phi %InstructionDepthState [ %t50, %merge7 ], [ %t121, %loop.latch10 ]
  %t126 = phi double [ %t52, %merge7 ], [ %t122, %loop.latch10 ]
  %t127 = phi double [ %t53, %merge7 ], [ %t123, %loop.latch10 ]
  store i8* %t124, i8** %l2
  store %InstructionDepthState %t125, %InstructionDepthState* %l1
  store double %t126, double* %l3
  store double %t127, double* %l4
  br label %loop.body9
loop.body9:
  %t54 = load double, double* %l4
  %t55 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t56 = extractvalue { i8**, i64 } %t55, 1
  %t57 = sitofp i64 %t56 to double
  %t58 = fcmp oge double %t54, %t57
  %t59 = load i8*, i8** %l0
  %t60 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t61 = load i8*, i8** %l2
  %t62 = load double, double* %l3
  %t63 = load double, double* %l4
  br i1 %t58, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t64 = load double, double* %l4
  %t65 = call double @llvm.round.f64(double %t64)
  %t66 = fptosi double %t65 to i64
  %t67 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t68 = extractvalue { i8**, i64 } %t67, 0
  %t69 = extractvalue { i8**, i64 } %t67, 1
  %t70 = icmp uge i64 %t66, %t69
  ; bounds check: %t70 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t66, i64 %t69)
  %t71 = getelementptr i8*, i8** %t68, i64 %t66
  %t72 = load i8*, i8** %t71
  %t73 = call i8* @trim_text(i8* %t72)
  store i8* %t73, i8** %l5
  %t74 = load i8*, i8** %l5
  %t75 = call i64 @sailfin_runtime_string_length(i8* %t74)
  %t76 = icmp eq i64 %t75, 0
  %t77 = load i8*, i8** %l0
  %t78 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t79 = load i8*, i8** %l2
  %t80 = load double, double* %l3
  %t81 = load double, double* %l4
  %t82 = load i8*, i8** %l5
  br i1 %t76, label %then14, label %else15
then14:
  %t83 = load i8*, i8** %l2
  %t84 = alloca [2 x i8], align 1
  %t85 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 0
  store i8 10, i8* %t85
  %t86 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 1
  store i8 0, i8* %t86
  %t87 = getelementptr [2 x i8], [2 x i8]* %t84, i32 0, i32 0
  %t88 = call i8* @sailfin_runtime_string_concat(i8* %t83, i8* %t87)
  store i8* %t88, i8** %l2
  %t89 = load i8*, i8** %l2
  br label %merge16
else15:
  %t90 = load i8*, i8** %l2
  %t91 = alloca [2 x i8], align 1
  %t92 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  store i8 10, i8* %t92
  %t93 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 1
  store i8 0, i8* %t93
  %t94 = getelementptr [2 x i8], [2 x i8]* %t91, i32 0, i32 0
  %t95 = call i8* @sailfin_runtime_string_concat(i8* %t90, i8* %t94)
  %t96 = load i8*, i8** %l5
  %t97 = call i8* @sailfin_runtime_string_concat(i8* %t95, i8* %t96)
  store i8* %t97, i8** %l2
  %t98 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t99 = load i8*, i8** %l5
  %t100 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t98, i8* %t99)
  store %InstructionDepthState %t100, %InstructionDepthState* %l1
  %t101 = load i8*, i8** %l2
  %t102 = load %InstructionDepthState, %InstructionDepthState* %l1
  br label %merge16
merge16:
  %t103 = phi i8* [ %t89, %then14 ], [ %t101, %else15 ]
  %t104 = phi %InstructionDepthState [ %t78, %then14 ], [ %t102, %else15 ]
  store i8* %t103, i8** %l2
  store %InstructionDepthState %t104, %InstructionDepthState* %l1
  %t105 = load double, double* %l3
  %t106 = sitofp i64 1 to double
  %t107 = fadd double %t105, %t106
  store double %t107, double* %l3
  %t108 = load double, double* %l4
  %t109 = sitofp i64 1 to double
  %t110 = fadd double %t108, %t109
  store double %t110, double* %l4
  %t111 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t112 = call i1 @instruction_requires_continuation(%InstructionDepthState %t111)
  %t113 = xor i1 %t112, 1
  %t114 = load i8*, i8** %l0
  %t115 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t116 = load i8*, i8** %l2
  %t117 = load double, double* %l3
  %t118 = load double, double* %l4
  %t119 = load i8*, i8** %l5
  br i1 %t113, label %then17, label %merge18
then17:
  br label %afterloop11
merge18:
  br label %loop.latch10
loop.latch10:
  %t120 = load i8*, i8** %l2
  %t121 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t122 = load double, double* %l3
  %t123 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t128 = load i8*, i8** %l2
  %t129 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t130 = load double, double* %l3
  %t131 = load double, double* %l4
  %t132 = load i8*, i8** %l2
  %t133 = call i8* @trim_text(i8* %t132)
  store i8* %t133, i8** %l6
  %t134 = load i8*, i8** %l6
  %t135 = insertvalue %InstructionGatherResult undef, i8* %t134, 0
  %t136 = load double, double* %l3
  %t137 = insertvalue %InstructionGatherResult %t135, double %t136, 1
  ret %InstructionGatherResult %t137
}

define i1 @instruction_supports_multiline(i8* %line) {
block.entry:
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t1 = call i1 @starts_with(i8* %line, i8* %s0)
  br i1 %t1, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h273104342, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %line, i8* %s2)
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  ret i1 0
}

define i1 @instruction_requires_continuation(%InstructionDepthState %state) {
block.entry:
  %t0 = extractvalue %InstructionDepthState %state, 3
  br i1 %t0, label %then0, label %merge1
then0:
  ret i1 1
merge1:
  %t1 = extractvalue %InstructionDepthState %state, 0
  %t2 = sitofp i64 0 to double
  %t3 = fcmp ogt double %t1, %t2
  br i1 %t3, label %then2, label %merge3
then2:
  ret i1 1
merge3:
  %t4 = extractvalue %InstructionDepthState %state, 1
  %t5 = sitofp i64 0 to double
  %t6 = fcmp ogt double %t4, %t5
  br i1 %t6, label %then4, label %merge5
then4:
  ret i1 1
merge5:
  %t7 = extractvalue %InstructionDepthState %state, 2
  %t8 = sitofp i64 0 to double
  %t9 = fcmp ogt double %t7, %t8
  br i1 %t9, label %then6, label %merge7
then6:
  ret i1 1
merge7:
  ret i1 0
}

define %InstructionDepthState @initial_instruction_depth_state() {
block.entry:
  %t0 = sitofp i64 0 to double
  %t1 = insertvalue %InstructionDepthState undef, double %t0, 0
  %t2 = sitofp i64 0 to double
  %t3 = insertvalue %InstructionDepthState %t1, double %t2, 1
  %t4 = sitofp i64 0 to double
  %t5 = insertvalue %InstructionDepthState %t3, double %t4, 2
  %t6 = insertvalue %InstructionDepthState %t5, i1 0, 3
  %t7 = insertvalue %InstructionDepthState %t6, i1 0, 4
  ret %InstructionDepthState %t7
}

define %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %state, i8* %text) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca double
  %l6 = alloca i8
  %t0 = extractvalue %InstructionDepthState %state, 0
  store double %t0, double* %l0
  %t1 = extractvalue %InstructionDepthState %state, 1
  store double %t1, double* %l1
  %t2 = extractvalue %InstructionDepthState %state, 2
  store double %t2, double* %l2
  %t3 = extractvalue %InstructionDepthState %state, 3
  store i1 %t3, i1* %l3
  %t4 = extractvalue %InstructionDepthState %state, 4
  store i1 %t4, i1* %l4
  %t5 = sitofp i64 0 to double
  store double %t5, double* %l5
  %t6 = load double, double* %l0
  %t7 = load double, double* %l1
  %t8 = load double, double* %l2
  %t9 = load i1, i1* %l3
  %t10 = load i1, i1* %l4
  %t11 = load double, double* %l5
  br label %loop.header0
loop.header0:
  %t219 = phi i1 [ %t10, %block.entry ], [ %t213, %loop.latch2 ]
  %t220 = phi double [ %t11, %block.entry ], [ %t214, %loop.latch2 ]
  %t221 = phi i1 [ %t9, %block.entry ], [ %t215, %loop.latch2 ]
  %t222 = phi double [ %t6, %block.entry ], [ %t216, %loop.latch2 ]
  %t223 = phi double [ %t7, %block.entry ], [ %t217, %loop.latch2 ]
  %t224 = phi double [ %t8, %block.entry ], [ %t218, %loop.latch2 ]
  store i1 %t219, i1* %l4
  store double %t220, double* %l5
  store i1 %t221, i1* %l3
  store double %t222, double* %l0
  store double %t223, double* %l1
  store double %t224, double* %l2
  br label %loop.body1
loop.body1:
  %t12 = load double, double* %l5
  %t13 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t14 = sitofp i64 %t13 to double
  %t15 = fcmp oge double %t12, %t14
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load double, double* %l2
  %t19 = load i1, i1* %l3
  %t20 = load i1, i1* %l4
  %t21 = load double, double* %l5
  br i1 %t15, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t22 = load double, double* %l5
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = getelementptr i8, i8* %text, i64 %t24
  %t26 = load i8, i8* %t25
  store i8 %t26, i8* %l6
  %t27 = load i1, i1* %l3
  %t28 = load double, double* %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  %t31 = load i1, i1* %l3
  %t32 = load i1, i1* %l4
  %t33 = load double, double* %l5
  %t34 = load i8, i8* %l6
  br i1 %t27, label %then6, label %merge7
then6:
  %t35 = load i1, i1* %l4
  %t36 = load double, double* %l0
  %t37 = load double, double* %l1
  %t38 = load double, double* %l2
  %t39 = load i1, i1* %l3
  %t40 = load i1, i1* %l4
  %t41 = load double, double* %l5
  %t42 = load i8, i8* %l6
  br i1 %t35, label %then8, label %merge9
then8:
  store i1 0, i1* %l4
  %t43 = load double, double* %l5
  %t44 = sitofp i64 1 to double
  %t45 = fadd double %t43, %t44
  store double %t45, double* %l5
  br label %loop.latch2
merge9:
  %t46 = load i8, i8* %l6
  %t47 = icmp eq i8 %t46, 92
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  %t51 = load i1, i1* %l3
  %t52 = load i1, i1* %l4
  %t53 = load double, double* %l5
  %t54 = load i8, i8* %l6
  br i1 %t47, label %then10, label %merge11
then10:
  store i1 1, i1* %l4
  %t55 = load double, double* %l5
  %t56 = sitofp i64 1 to double
  %t57 = fadd double %t55, %t56
  store double %t57, double* %l5
  br label %loop.latch2
merge11:
  %t58 = load i8, i8* %l6
  %t59 = icmp eq i8 %t58, 34
  %t60 = load double, double* %l0
  %t61 = load double, double* %l1
  %t62 = load double, double* %l2
  %t63 = load i1, i1* %l3
  %t64 = load i1, i1* %l4
  %t65 = load double, double* %l5
  %t66 = load i8, i8* %l6
  br i1 %t59, label %then12, label %merge13
then12:
  store i1 0, i1* %l3
  %t67 = load i1, i1* %l3
  br label %merge13
merge13:
  %t68 = phi i1 [ %t67, %then12 ], [ %t63, %merge11 ]
  store i1 %t68, i1* %l3
  %t69 = load double, double* %l5
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  store double %t71, double* %l5
  br label %loop.latch2
merge7:
  %t72 = load i8, i8* %l6
  %t73 = icmp eq i8 %t72, 34
  %t74 = load double, double* %l0
  %t75 = load double, double* %l1
  %t76 = load double, double* %l2
  %t77 = load i1, i1* %l3
  %t78 = load i1, i1* %l4
  %t79 = load double, double* %l5
  %t80 = load i8, i8* %l6
  br i1 %t73, label %then14, label %merge15
then14:
  store i1 1, i1* %l3
  %t81 = load double, double* %l5
  %t82 = sitofp i64 1 to double
  %t83 = fadd double %t81, %t82
  store double %t83, double* %l5
  br label %loop.latch2
merge15:
  %t84 = load i8, i8* %l6
  %t85 = icmp eq i8 %t84, 40
  %t86 = load double, double* %l0
  %t87 = load double, double* %l1
  %t88 = load double, double* %l2
  %t89 = load i1, i1* %l3
  %t90 = load i1, i1* %l4
  %t91 = load double, double* %l5
  %t92 = load i8, i8* %l6
  br i1 %t85, label %then16, label %merge17
then16:
  %t93 = load double, double* %l0
  %t94 = sitofp i64 1 to double
  %t95 = fadd double %t93, %t94
  store double %t95, double* %l0
  %t96 = load double, double* %l5
  %t97 = sitofp i64 1 to double
  %t98 = fadd double %t96, %t97
  store double %t98, double* %l5
  br label %loop.latch2
merge17:
  %t99 = load i8, i8* %l6
  %t100 = icmp eq i8 %t99, 41
  %t101 = load double, double* %l0
  %t102 = load double, double* %l1
  %t103 = load double, double* %l2
  %t104 = load i1, i1* %l3
  %t105 = load i1, i1* %l4
  %t106 = load double, double* %l5
  %t107 = load i8, i8* %l6
  br i1 %t100, label %then18, label %merge19
then18:
  %t108 = load double, double* %l0
  %t109 = sitofp i64 0 to double
  %t110 = fcmp ogt double %t108, %t109
  %t111 = load double, double* %l0
  %t112 = load double, double* %l1
  %t113 = load double, double* %l2
  %t114 = load i1, i1* %l3
  %t115 = load i1, i1* %l4
  %t116 = load double, double* %l5
  %t117 = load i8, i8* %l6
  br i1 %t110, label %then20, label %merge21
then20:
  %t118 = load double, double* %l0
  %t119 = sitofp i64 1 to double
  %t120 = fsub double %t118, %t119
  store double %t120, double* %l0
  %t121 = load double, double* %l0
  br label %merge21
merge21:
  %t122 = phi double [ %t121, %then20 ], [ %t111, %then18 ]
  store double %t122, double* %l0
  %t123 = load double, double* %l5
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %t123, %t124
  store double %t125, double* %l5
  br label %loop.latch2
merge19:
  %t126 = load i8, i8* %l6
  %t127 = icmp eq i8 %t126, 91
  %t128 = load double, double* %l0
  %t129 = load double, double* %l1
  %t130 = load double, double* %l2
  %t131 = load i1, i1* %l3
  %t132 = load i1, i1* %l4
  %t133 = load double, double* %l5
  %t134 = load i8, i8* %l6
  br i1 %t127, label %then22, label %merge23
then22:
  %t135 = load double, double* %l1
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l1
  %t138 = load double, double* %l5
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  store double %t140, double* %l5
  br label %loop.latch2
merge23:
  %t141 = load i8, i8* %l6
  %t142 = icmp eq i8 %t141, 93
  %t143 = load double, double* %l0
  %t144 = load double, double* %l1
  %t145 = load double, double* %l2
  %t146 = load i1, i1* %l3
  %t147 = load i1, i1* %l4
  %t148 = load double, double* %l5
  %t149 = load i8, i8* %l6
  br i1 %t142, label %then24, label %merge25
then24:
  %t150 = load double, double* %l1
  %t151 = sitofp i64 0 to double
  %t152 = fcmp ogt double %t150, %t151
  %t153 = load double, double* %l0
  %t154 = load double, double* %l1
  %t155 = load double, double* %l2
  %t156 = load i1, i1* %l3
  %t157 = load i1, i1* %l4
  %t158 = load double, double* %l5
  %t159 = load i8, i8* %l6
  br i1 %t152, label %then26, label %merge27
then26:
  %t160 = load double, double* %l1
  %t161 = sitofp i64 1 to double
  %t162 = fsub double %t160, %t161
  store double %t162, double* %l1
  %t163 = load double, double* %l1
  br label %merge27
merge27:
  %t164 = phi double [ %t163, %then26 ], [ %t154, %then24 ]
  store double %t164, double* %l1
  %t165 = load double, double* %l5
  %t166 = sitofp i64 1 to double
  %t167 = fadd double %t165, %t166
  store double %t167, double* %l5
  br label %loop.latch2
merge25:
  %t168 = load i8, i8* %l6
  %t169 = icmp eq i8 %t168, 123
  %t170 = load double, double* %l0
  %t171 = load double, double* %l1
  %t172 = load double, double* %l2
  %t173 = load i1, i1* %l3
  %t174 = load i1, i1* %l4
  %t175 = load double, double* %l5
  %t176 = load i8, i8* %l6
  br i1 %t169, label %then28, label %merge29
then28:
  %t177 = load double, double* %l2
  %t178 = sitofp i64 1 to double
  %t179 = fadd double %t177, %t178
  store double %t179, double* %l2
  %t180 = load double, double* %l5
  %t181 = sitofp i64 1 to double
  %t182 = fadd double %t180, %t181
  store double %t182, double* %l5
  br label %loop.latch2
merge29:
  %t183 = load i8, i8* %l6
  %t184 = icmp eq i8 %t183, 125
  %t185 = load double, double* %l0
  %t186 = load double, double* %l1
  %t187 = load double, double* %l2
  %t188 = load i1, i1* %l3
  %t189 = load i1, i1* %l4
  %t190 = load double, double* %l5
  %t191 = load i8, i8* %l6
  br i1 %t184, label %then30, label %merge31
then30:
  %t192 = load double, double* %l2
  %t193 = sitofp i64 0 to double
  %t194 = fcmp ogt double %t192, %t193
  %t195 = load double, double* %l0
  %t196 = load double, double* %l1
  %t197 = load double, double* %l2
  %t198 = load i1, i1* %l3
  %t199 = load i1, i1* %l4
  %t200 = load double, double* %l5
  %t201 = load i8, i8* %l6
  br i1 %t194, label %then32, label %merge33
then32:
  %t202 = load double, double* %l2
  %t203 = sitofp i64 1 to double
  %t204 = fsub double %t202, %t203
  store double %t204, double* %l2
  %t205 = load double, double* %l2
  br label %merge33
merge33:
  %t206 = phi double [ %t205, %then32 ], [ %t197, %then30 ]
  store double %t206, double* %l2
  %t207 = load double, double* %l5
  %t208 = sitofp i64 1 to double
  %t209 = fadd double %t207, %t208
  store double %t209, double* %l5
  br label %loop.latch2
merge31:
  %t210 = load double, double* %l5
  %t211 = sitofp i64 1 to double
  %t212 = fadd double %t210, %t211
  store double %t212, double* %l5
  br label %loop.latch2
loop.latch2:
  %t213 = load i1, i1* %l4
  %t214 = load double, double* %l5
  %t215 = load i1, i1* %l3
  %t216 = load double, double* %l0
  %t217 = load double, double* %l1
  %t218 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t225 = load i1, i1* %l4
  %t226 = load double, double* %l5
  %t227 = load i1, i1* %l3
  %t228 = load double, double* %l0
  %t229 = load double, double* %l1
  %t230 = load double, double* %l2
  %t231 = load double, double* %l0
  %t232 = insertvalue %InstructionDepthState undef, double %t231, 0
  %t233 = load double, double* %l1
  %t234 = insertvalue %InstructionDepthState %t232, double %t233, 1
  %t235 = load double, double* %l2
  %t236 = insertvalue %InstructionDepthState %t234, double %t235, 2
  %t237 = load i1, i1* %l3
  %t238 = insertvalue %InstructionDepthState %t236, i1 %t237, 3
  %t239 = load i1, i1* %l4
  %t240 = insertvalue %InstructionDepthState %t238, i1 %t239, 4
  ret %InstructionDepthState %t240
}

define %InstructionParseResult @parse_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i8
  %l10 = alloca i8*
  %l11 = alloca i8*
  %l12 = alloca i1
  %l13 = alloca %BindingComponents
  %s0 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t1 = call i1 @strings_equal(i8* %line, i8* %s0)
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = insertvalue %NativeInstruction undef, i32 15, 0
  %t3 = call noalias i8* @malloc(i64 56)
  %t4 = bitcast i8* %t3 to %NativeInstruction*
  store %NativeInstruction %t2, %NativeInstruction* %t4
  %t5 = bitcast i8* %t3 to %NativeInstruction*
  %t6 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t7 = ptrtoint [1 x %NativeInstruction*]* %t6 to i64
  %t8 = icmp eq i64 %t7, 0
  %t9 = select i1 %t8, i64 1, i64 %t7
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to %NativeInstruction**
  %t12 = getelementptr %NativeInstruction*, %NativeInstruction** %t11, i64 0
  store %NativeInstruction* %t5, %NativeInstruction** %t12
  %t13 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t14 = ptrtoint { %NativeInstruction**, i64 }* %t13 to i64
  %t15 = call i8* @malloc(i64 %t14)
  %t16 = bitcast i8* %t15 to { %NativeInstruction**, i64 }*
  %t17 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t16, i32 0, i32 0
  store %NativeInstruction** %t11, %NativeInstruction*** %t17
  %t18 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t16, i32 0, i32 1
  store i64 1, i64* %t18
  %t19 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t16, 0
  %t20 = insertvalue %InstructionParseResult %t19, i1 0, 1
  %t21 = insertvalue %InstructionParseResult %t20, i1 0, 2
  ret %InstructionParseResult %t21
merge1:
  %s22 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192590216, i32 0, i32 0
  %t23 = call i1 @starts_with(i8* %line, i8* %s22)
  br i1 %t23, label %then2, label %merge3
then2:
  %s24 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192590216, i32 0, i32 0
  %t25 = call i8* @strip_prefix(i8* %line, i8* %s24)
  %t26 = call i8* @trim_text(i8* %t25)
  store i8* %t26, i8** %l0
  %t27 = alloca %NativeInstruction
  %t28 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t27, i32 0, i32 0
  store i32 3, i32* %t28
  %t29 = load i8*, i8** %l0
  %t30 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t27, i32 0, i32 1
  %t31 = bitcast [8 x i8]* %t30 to i8*
  %t32 = bitcast i8* %t31 to i8**
  store i8* %t29, i8** %t32
  %t33 = load %NativeInstruction, %NativeInstruction* %t27
  %t34 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t35 = ptrtoint [1 x %NativeInstruction]* %t34 to i64
  %t36 = icmp eq i64 %t35, 0
  %t37 = select i1 %t36, i64 1, i64 %t35
  %t38 = call i8* @malloc(i64 %t37)
  %t39 = bitcast i8* %t38 to %NativeInstruction*
  %t40 = getelementptr %NativeInstruction, %NativeInstruction* %t39, i64 0
  store %NativeInstruction %t33, %NativeInstruction* %t40
  %t41 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t42 = ptrtoint { %NativeInstruction*, i64 }* %t41 to i64
  %t43 = call i8* @malloc(i64 %t42)
  %t44 = bitcast i8* %t43 to { %NativeInstruction*, i64 }*
  %t45 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t44, i32 0, i32 0
  store %NativeInstruction* %t39, %NativeInstruction** %t45
  %t46 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t44, i32 0, i32 1
  store i64 1, i64* %t46
  %t47 = bitcast { %NativeInstruction*, i64 }* %t44 to { %NativeInstruction**, i64 }*
  %t48 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t47, 0
  %t49 = insertvalue %InstructionParseResult %t48, i1 0, 1
  %t50 = insertvalue %InstructionParseResult %t49, i1 0, 2
  ret %InstructionParseResult %t50
merge3:
  %s51 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2056075365, i32 0, i32 0
  %t52 = call i1 @strings_equal(i8* %line, i8* %s51)
  br i1 %t52, label %then4, label %merge5
then4:
  %t53 = insertvalue %NativeInstruction undef, i32 4, 0
  %t54 = call noalias i8* @malloc(i64 56)
  %t55 = bitcast i8* %t54 to %NativeInstruction*
  store %NativeInstruction %t53, %NativeInstruction* %t55
  %t56 = bitcast i8* %t54 to %NativeInstruction*
  %t57 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t58 = ptrtoint [1 x %NativeInstruction*]* %t57 to i64
  %t59 = icmp eq i64 %t58, 0
  %t60 = select i1 %t59, i64 1, i64 %t58
  %t61 = call i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to %NativeInstruction**
  %t63 = getelementptr %NativeInstruction*, %NativeInstruction** %t62, i64 0
  store %NativeInstruction* %t56, %NativeInstruction** %t63
  %t64 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t65 = ptrtoint { %NativeInstruction**, i64 }* %t64 to i64
  %t66 = call i8* @malloc(i64 %t65)
  %t67 = bitcast i8* %t66 to { %NativeInstruction**, i64 }*
  %t68 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t67, i32 0, i32 0
  store %NativeInstruction** %t62, %NativeInstruction*** %t68
  %t69 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t67, i32 0, i32 1
  store i64 1, i64* %t69
  %t70 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t67, 0
  %t71 = insertvalue %InstructionParseResult %t70, i1 0, 1
  %t72 = insertvalue %InstructionParseResult %t71, i1 0, 2
  ret %InstructionParseResult %t72
merge5:
  %s73 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280334338, i32 0, i32 0
  %t74 = call i1 @strings_equal(i8* %line, i8* %s73)
  br i1 %t74, label %then6, label %merge7
then6:
  %t75 = insertvalue %NativeInstruction undef, i32 5, 0
  %t76 = call noalias i8* @malloc(i64 56)
  %t77 = bitcast i8* %t76 to %NativeInstruction*
  store %NativeInstruction %t75, %NativeInstruction* %t77
  %t78 = bitcast i8* %t76 to %NativeInstruction*
  %t79 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t80 = ptrtoint [1 x %NativeInstruction*]* %t79 to i64
  %t81 = icmp eq i64 %t80, 0
  %t82 = select i1 %t81, i64 1, i64 %t80
  %t83 = call i8* @malloc(i64 %t82)
  %t84 = bitcast i8* %t83 to %NativeInstruction**
  %t85 = getelementptr %NativeInstruction*, %NativeInstruction** %t84, i64 0
  store %NativeInstruction* %t78, %NativeInstruction** %t85
  %t86 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t87 = ptrtoint { %NativeInstruction**, i64 }* %t86 to i64
  %t88 = call i8* @malloc(i64 %t87)
  %t89 = bitcast i8* %t88 to { %NativeInstruction**, i64 }*
  %t90 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t89, i32 0, i32 0
  store %NativeInstruction** %t84, %NativeInstruction*** %t90
  %t91 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t89, i32 0, i32 1
  store i64 1, i64* %t91
  %t92 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t89, 0
  %t93 = insertvalue %InstructionParseResult %t92, i1 0, 1
  %t94 = insertvalue %InstructionParseResult %t93, i1 0, 2
  ret %InstructionParseResult %t94
merge7:
  %s95 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2057365731, i32 0, i32 0
  %t96 = call i1 @starts_with(i8* %line, i8* %s95)
  br i1 %t96, label %then8, label %merge9
then8:
  %s97 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2057365731, i32 0, i32 0
  %t98 = call i8* @strip_prefix(i8* %line, i8* %s97)
  %t99 = call i8* @trim_text(i8* %t98)
  store i8* %t99, i8** %l1
  %s100 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  store i8* %s100, i8** %l2
  %t101 = load i8*, i8** %l1
  %t102 = load i8*, i8** %l2
  %t103 = call double @index_of(i8* %t101, i8* %t102)
  store double %t103, double* %l3
  %t104 = load double, double* %l3
  %t105 = sitofp i64 0 to double
  %t106 = fcmp oge double %t104, %t105
  %t107 = load i8*, i8** %l1
  %t108 = load i8*, i8** %l2
  %t109 = load double, double* %l3
  br i1 %t106, label %then10, label %merge11
then10:
  %t110 = load i8*, i8** %l1
  %t111 = load double, double* %l3
  %t112 = call double @llvm.round.f64(double %t111)
  %t113 = fptosi double %t112 to i64
  %t114 = call i8* @sailfin_runtime_substring(i8* %t110, i64 0, i64 %t113)
  %t115 = call i8* @trim_text(i8* %t114)
  store i8* %t115, i8** %l4
  %t116 = load i8*, i8** %l1
  %t117 = load double, double* %l3
  %t118 = load i8*, i8** %l2
  %t119 = call i64 @sailfin_runtime_string_length(i8* %t118)
  %t120 = sitofp i64 %t119 to double
  %t121 = fadd double %t117, %t120
  %t122 = load i8*, i8** %l1
  %t123 = call i64 @sailfin_runtime_string_length(i8* %t122)
  %t124 = call double @llvm.round.f64(double %t121)
  %t125 = fptosi double %t124 to i64
  %t126 = call i8* @sailfin_runtime_substring(i8* %t116, i64 %t125, i64 %t123)
  %t127 = call i8* @trim_text(i8* %t126)
  store i8* %t127, i8** %l5
  %t128 = alloca %NativeInstruction
  %t129 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t128, i32 0, i32 0
  store i32 6, i32* %t129
  %t130 = load i8*, i8** %l4
  %t131 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t128, i32 0, i32 1
  %t132 = bitcast [16 x i8]* %t131 to i8*
  %t133 = bitcast i8* %t132 to i8**
  store i8* %t130, i8** %t133
  %t134 = load i8*, i8** %l5
  %t135 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t128, i32 0, i32 1
  %t136 = bitcast [16 x i8]* %t135 to i8*
  %t137 = getelementptr inbounds i8, i8* %t136, i64 8
  %t138 = bitcast i8* %t137 to i8**
  store i8* %t134, i8** %t138
  %t139 = load %NativeInstruction, %NativeInstruction* %t128
  %t140 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t141 = ptrtoint [1 x %NativeInstruction]* %t140 to i64
  %t142 = icmp eq i64 %t141, 0
  %t143 = select i1 %t142, i64 1, i64 %t141
  %t144 = call i8* @malloc(i64 %t143)
  %t145 = bitcast i8* %t144 to %NativeInstruction*
  %t146 = getelementptr %NativeInstruction, %NativeInstruction* %t145, i64 0
  store %NativeInstruction %t139, %NativeInstruction* %t146
  %t147 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t148 = ptrtoint { %NativeInstruction*, i64 }* %t147 to i64
  %t149 = call i8* @malloc(i64 %t148)
  %t150 = bitcast i8* %t149 to { %NativeInstruction*, i64 }*
  %t151 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t150, i32 0, i32 0
  store %NativeInstruction* %t145, %NativeInstruction** %t151
  %t152 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t150, i32 0, i32 1
  store i64 1, i64* %t152
  %t153 = bitcast { %NativeInstruction*, i64 }* %t150 to { %NativeInstruction**, i64 }*
  %t154 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t153, 0
  %t155 = insertvalue %InstructionParseResult %t154, i1 0, 1
  %t156 = insertvalue %InstructionParseResult %t155, i1 0, 2
  ret %InstructionParseResult %t156
merge11:
  br label %merge9
merge9:
  %s157 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1448749422, i32 0, i32 0
  %t158 = call i1 @strings_equal(i8* %line, i8* %s157)
  br i1 %t158, label %then12, label %merge13
then12:
  %t159 = insertvalue %NativeInstruction undef, i32 7, 0
  %t160 = call noalias i8* @malloc(i64 56)
  %t161 = bitcast i8* %t160 to %NativeInstruction*
  store %NativeInstruction %t159, %NativeInstruction* %t161
  %t162 = bitcast i8* %t160 to %NativeInstruction*
  %t163 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t164 = ptrtoint [1 x %NativeInstruction*]* %t163 to i64
  %t165 = icmp eq i64 %t164, 0
  %t166 = select i1 %t165, i64 1, i64 %t164
  %t167 = call i8* @malloc(i64 %t166)
  %t168 = bitcast i8* %t167 to %NativeInstruction**
  %t169 = getelementptr %NativeInstruction*, %NativeInstruction** %t168, i64 0
  store %NativeInstruction* %t162, %NativeInstruction** %t169
  %t170 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t171 = ptrtoint { %NativeInstruction**, i64 }* %t170 to i64
  %t172 = call i8* @malloc(i64 %t171)
  %t173 = bitcast i8* %t172 to { %NativeInstruction**, i64 }*
  %t174 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t173, i32 0, i32 0
  store %NativeInstruction** %t168, %NativeInstruction*** %t174
  %t175 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t173, i32 0, i32 1
  store i64 1, i64* %t175
  %t176 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t173, 0
  %t177 = insertvalue %InstructionParseResult %t176, i1 0, 1
  %t178 = insertvalue %InstructionParseResult %t177, i1 0, 2
  ret %InstructionParseResult %t178
merge13:
  %s179 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064480630, i32 0, i32 0
  %t180 = call i1 @strings_equal(i8* %line, i8* %s179)
  br i1 %t180, label %then14, label %merge15
then14:
  %t181 = insertvalue %NativeInstruction undef, i32 8, 0
  %t182 = call noalias i8* @malloc(i64 56)
  %t183 = bitcast i8* %t182 to %NativeInstruction*
  store %NativeInstruction %t181, %NativeInstruction* %t183
  %t184 = bitcast i8* %t182 to %NativeInstruction*
  %t185 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t186 = ptrtoint [1 x %NativeInstruction*]* %t185 to i64
  %t187 = icmp eq i64 %t186, 0
  %t188 = select i1 %t187, i64 1, i64 %t186
  %t189 = call i8* @malloc(i64 %t188)
  %t190 = bitcast i8* %t189 to %NativeInstruction**
  %t191 = getelementptr %NativeInstruction*, %NativeInstruction** %t190, i64 0
  store %NativeInstruction* %t184, %NativeInstruction** %t191
  %t192 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t193 = ptrtoint { %NativeInstruction**, i64 }* %t192 to i64
  %t194 = call i8* @malloc(i64 %t193)
  %t195 = bitcast i8* %t194 to { %NativeInstruction**, i64 }*
  %t196 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t195, i32 0, i32 0
  store %NativeInstruction** %t190, %NativeInstruction*** %t196
  %t197 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t195, i32 0, i32 1
  store i64 1, i64* %t197
  %t198 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t195, 0
  %t199 = insertvalue %InstructionParseResult %t198, i1 0, 1
  %t200 = insertvalue %InstructionParseResult %t199, i1 0, 2
  ret %InstructionParseResult %t200
merge15:
  %s201 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h571206424, i32 0, i32 0
  %t202 = call i1 @strings_equal(i8* %line, i8* %s201)
  br i1 %t202, label %then16, label %merge17
then16:
  %t203 = insertvalue %NativeInstruction undef, i32 9, 0
  %t204 = call noalias i8* @malloc(i64 56)
  %t205 = bitcast i8* %t204 to %NativeInstruction*
  store %NativeInstruction %t203, %NativeInstruction* %t205
  %t206 = bitcast i8* %t204 to %NativeInstruction*
  %t207 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t208 = ptrtoint [1 x %NativeInstruction*]* %t207 to i64
  %t209 = icmp eq i64 %t208, 0
  %t210 = select i1 %t209, i64 1, i64 %t208
  %t211 = call i8* @malloc(i64 %t210)
  %t212 = bitcast i8* %t211 to %NativeInstruction**
  %t213 = getelementptr %NativeInstruction*, %NativeInstruction** %t212, i64 0
  store %NativeInstruction* %t206, %NativeInstruction** %t213
  %t214 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t215 = ptrtoint { %NativeInstruction**, i64 }* %t214 to i64
  %t216 = call i8* @malloc(i64 %t215)
  %t217 = bitcast i8* %t216 to { %NativeInstruction**, i64 }*
  %t218 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t217, i32 0, i32 0
  store %NativeInstruction** %t212, %NativeInstruction*** %t218
  %t219 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t217, i32 0, i32 1
  store i64 1, i64* %t219
  %t220 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t217, 0
  %t221 = insertvalue %InstructionParseResult %t220, i1 0, 1
  %t222 = insertvalue %InstructionParseResult %t221, i1 0, 2
  ret %InstructionParseResult %t222
merge17:
  %s223 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t224 = call i1 @strings_equal(i8* %line, i8* %s223)
  br i1 %t224, label %then18, label %merge19
then18:
  %t225 = insertvalue %NativeInstruction undef, i32 10, 0
  %t226 = call noalias i8* @malloc(i64 56)
  %t227 = bitcast i8* %t226 to %NativeInstruction*
  store %NativeInstruction %t225, %NativeInstruction* %t227
  %t228 = bitcast i8* %t226 to %NativeInstruction*
  %t229 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t230 = ptrtoint [1 x %NativeInstruction*]* %t229 to i64
  %t231 = icmp eq i64 %t230, 0
  %t232 = select i1 %t231, i64 1, i64 %t230
  %t233 = call i8* @malloc(i64 %t232)
  %t234 = bitcast i8* %t233 to %NativeInstruction**
  %t235 = getelementptr %NativeInstruction*, %NativeInstruction** %t234, i64 0
  store %NativeInstruction* %t228, %NativeInstruction** %t235
  %t236 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t237 = ptrtoint { %NativeInstruction**, i64 }* %t236 to i64
  %t238 = call i8* @malloc(i64 %t237)
  %t239 = bitcast i8* %t238 to { %NativeInstruction**, i64 }*
  %t240 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t239, i32 0, i32 0
  store %NativeInstruction** %t234, %NativeInstruction*** %t240
  %t241 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t239, i32 0, i32 1
  store i64 1, i64* %t241
  %t242 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t239, 0
  %t243 = insertvalue %InstructionParseResult %t242, i1 0, 1
  %t244 = insertvalue %InstructionParseResult %t243, i1 0, 2
  ret %InstructionParseResult %t244
merge19:
  %s245 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t246 = call i1 @strings_equal(i8* %line, i8* %s245)
  br i1 %t246, label %then20, label %merge21
then20:
  %t247 = insertvalue %NativeInstruction undef, i32 11, 0
  %t248 = call noalias i8* @malloc(i64 56)
  %t249 = bitcast i8* %t248 to %NativeInstruction*
  store %NativeInstruction %t247, %NativeInstruction* %t249
  %t250 = bitcast i8* %t248 to %NativeInstruction*
  %t251 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t252 = ptrtoint [1 x %NativeInstruction*]* %t251 to i64
  %t253 = icmp eq i64 %t252, 0
  %t254 = select i1 %t253, i64 1, i64 %t252
  %t255 = call i8* @malloc(i64 %t254)
  %t256 = bitcast i8* %t255 to %NativeInstruction**
  %t257 = getelementptr %NativeInstruction*, %NativeInstruction** %t256, i64 0
  store %NativeInstruction* %t250, %NativeInstruction** %t257
  %t258 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t259 = ptrtoint { %NativeInstruction**, i64 }* %t258 to i64
  %t260 = call i8* @malloc(i64 %t259)
  %t261 = bitcast i8* %t260 to { %NativeInstruction**, i64 }*
  %t262 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t261, i32 0, i32 0
  store %NativeInstruction** %t256, %NativeInstruction*** %t262
  %t263 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t261, i32 0, i32 1
  store i64 1, i64* %t263
  %t264 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t261, 0
  %t265 = insertvalue %InstructionParseResult %t264, i1 0, 1
  %t266 = insertvalue %InstructionParseResult %t265, i1 0, 2
  ret %InstructionParseResult %t266
merge21:
  %s267 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h553171426, i32 0, i32 0
  %t268 = call i1 @starts_with(i8* %line, i8* %s267)
  br i1 %t268, label %then22, label %merge23
then22:
  %s269 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h553171426, i32 0, i32 0
  %t270 = call i8* @strip_prefix(i8* %line, i8* %s269)
  %t271 = call i8* @trim_text(i8* %t270)
  store i8* %t271, i8** %l6
  %t272 = alloca %NativeInstruction
  %t273 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t272, i32 0, i32 0
  store i32 12, i32* %t273
  %t274 = load i8*, i8** %l6
  %t275 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t272, i32 0, i32 1
  %t276 = bitcast [8 x i8]* %t275 to i8*
  %t277 = bitcast i8* %t276 to i8**
  store i8* %t274, i8** %t277
  %t278 = load %NativeInstruction, %NativeInstruction* %t272
  %t279 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t280 = ptrtoint [1 x %NativeInstruction]* %t279 to i64
  %t281 = icmp eq i64 %t280, 0
  %t282 = select i1 %t281, i64 1, i64 %t280
  %t283 = call i8* @malloc(i64 %t282)
  %t284 = bitcast i8* %t283 to %NativeInstruction*
  %t285 = getelementptr %NativeInstruction, %NativeInstruction* %t284, i64 0
  store %NativeInstruction %t278, %NativeInstruction* %t285
  %t286 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t287 = ptrtoint { %NativeInstruction*, i64 }* %t286 to i64
  %t288 = call i8* @malloc(i64 %t287)
  %t289 = bitcast i8* %t288 to { %NativeInstruction*, i64 }*
  %t290 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t289, i32 0, i32 0
  store %NativeInstruction* %t284, %NativeInstruction** %t290
  %t291 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t289, i32 0, i32 1
  store i64 1, i64* %t291
  %t292 = bitcast { %NativeInstruction*, i64 }* %t289 to { %NativeInstruction**, i64 }*
  %t293 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t292, 0
  %t294 = insertvalue %InstructionParseResult %t293, i1 0, 1
  %t295 = insertvalue %InstructionParseResult %t294, i1 0, 2
  ret %InstructionParseResult %t295
merge23:
  %s296 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1187178968, i32 0, i32 0
  %t297 = call i1 @starts_with(i8* %line, i8* %s296)
  br i1 %t297, label %then24, label %merge25
then24:
  %t298 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t299 = call noalias i8* @malloc(i64 56)
  %t300 = bitcast i8* %t299 to %NativeInstruction*
  store %NativeInstruction %t298, %NativeInstruction* %t300
  %t301 = bitcast i8* %t299 to %NativeInstruction*
  %t302 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t303 = ptrtoint [1 x %NativeInstruction*]* %t302 to i64
  %t304 = icmp eq i64 %t303, 0
  %t305 = select i1 %t304, i64 1, i64 %t303
  %t306 = call i8* @malloc(i64 %t305)
  %t307 = bitcast i8* %t306 to %NativeInstruction**
  %t308 = getelementptr %NativeInstruction*, %NativeInstruction** %t307, i64 0
  store %NativeInstruction* %t301, %NativeInstruction** %t308
  %t309 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t310 = ptrtoint { %NativeInstruction**, i64 }* %t309 to i64
  %t311 = call i8* @malloc(i64 %t310)
  %t312 = bitcast i8* %t311 to { %NativeInstruction**, i64 }*
  %t313 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t312, i32 0, i32 0
  store %NativeInstruction** %t307, %NativeInstruction*** %t313
  %t314 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t312, i32 0, i32 1
  store i64 1, i64* %t314
  %t315 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t312, 0
  %t316 = insertvalue %InstructionParseResult %t315, i1 0, 1
  %t317 = insertvalue %InstructionParseResult %t316, i1 0, 2
  ret %InstructionParseResult %t317
merge25:
  %s318 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1692644020, i32 0, i32 0
  %t319 = call i1 @strings_equal(i8* %line, i8* %s318)
  br i1 %t319, label %then26, label %merge27
then26:
  %t320 = insertvalue %NativeInstruction undef, i32 14, 0
  %t321 = call noalias i8* @malloc(i64 56)
  %t322 = bitcast i8* %t321 to %NativeInstruction*
  store %NativeInstruction %t320, %NativeInstruction* %t322
  %t323 = bitcast i8* %t321 to %NativeInstruction*
  %t324 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t325 = ptrtoint [1 x %NativeInstruction*]* %t324 to i64
  %t326 = icmp eq i64 %t325, 0
  %t327 = select i1 %t326, i64 1, i64 %t325
  %t328 = call i8* @malloc(i64 %t327)
  %t329 = bitcast i8* %t328 to %NativeInstruction**
  %t330 = getelementptr %NativeInstruction*, %NativeInstruction** %t329, i64 0
  store %NativeInstruction* %t323, %NativeInstruction** %t330
  %t331 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t332 = ptrtoint { %NativeInstruction**, i64 }* %t331 to i64
  %t333 = call i8* @malloc(i64 %t332)
  %t334 = bitcast i8* %t333 to { %NativeInstruction**, i64 }*
  %t335 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t334, i32 0, i32 0
  store %NativeInstruction** %t329, %NativeInstruction*** %t335
  %t336 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t334, i32 0, i32 1
  store i64 1, i64* %t336
  %t337 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t334, 0
  %t338 = insertvalue %InstructionParseResult %t337, i1 0, 1
  %t339 = insertvalue %InstructionParseResult %t338, i1 0, 2
  ret %InstructionParseResult %t339
merge27:
  %s340 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064124065, i32 0, i32 0
  %t341 = call i1 @starts_with(i8* %line, i8* %s340)
  br i1 %t341, label %then28, label %merge29
then28:
  %t342 = call %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span)
  %t343 = call noalias i8* @malloc(i64 56)
  %t344 = bitcast i8* %t343 to %NativeInstruction*
  store %NativeInstruction %t342, %NativeInstruction* %t344
  %t345 = bitcast i8* %t343 to %NativeInstruction*
  %t346 = getelementptr [1 x %NativeInstruction*], [1 x %NativeInstruction*]* null, i32 1
  %t347 = ptrtoint [1 x %NativeInstruction*]* %t346 to i64
  %t348 = icmp eq i64 %t347, 0
  %t349 = select i1 %t348, i64 1, i64 %t347
  %t350 = call i8* @malloc(i64 %t349)
  %t351 = bitcast i8* %t350 to %NativeInstruction**
  %t352 = getelementptr %NativeInstruction*, %NativeInstruction** %t351, i64 0
  store %NativeInstruction* %t345, %NativeInstruction** %t352
  %t353 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t354 = ptrtoint { %NativeInstruction**, i64 }* %t353 to i64
  %t355 = call i8* @malloc(i64 %t354)
  %t356 = bitcast i8* %t355 to { %NativeInstruction**, i64 }*
  %t357 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t356, i32 0, i32 0
  store %NativeInstruction** %t351, %NativeInstruction*** %t357
  %t358 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t356, i32 0, i32 1
  store i64 1, i64* %t358
  %t359 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t356, 0
  %t360 = insertvalue %InstructionParseResult %t359, i1 1, 1
  %t361 = insertvalue %InstructionParseResult %t360, i1 1, 2
  ret %InstructionParseResult %t361
merge29:
  %s362 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h725262232, i32 0, i32 0
  %t363 = call i1 @starts_with(i8* %line, i8* %s362)
  br i1 %t363, label %then30, label %merge31
then30:
  %s364 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h725262232, i32 0, i32 0
  %t365 = call i8* @strip_prefix(i8* %line, i8* %s364)
  %t366 = call i8* @trim_text(i8* %t365)
  store i8* %t366, i8** %l7
  %s367 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s367, i8** %l8
  %t368 = load i8*, i8** %l7
  %t369 = call i64 @sailfin_runtime_string_length(i8* %t368)
  %t370 = icmp sgt i64 %t369, 0
  %t371 = load i8*, i8** %l7
  %t372 = load i8*, i8** %l8
  br i1 %t370, label %then32, label %merge33
then32:
  %t373 = load i8*, i8** %l7
  %t374 = call i8* @trim_trailing_delimiters(i8* %t373)
  store i8* %t374, i8** %l8
  %t375 = load i8*, i8** %l8
  br label %merge33
merge33:
  %t376 = phi i8* [ %t375, %then32 ], [ %t372, %then30 ]
  store i8* %t376, i8** %l8
  %t377 = alloca %NativeInstruction
  %t378 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t377, i32 0, i32 0
  store i32 0, i32* %t378
  %t379 = load i8*, i8** %l8
  %t380 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t377, i32 0, i32 1
  %t381 = bitcast [16 x i8]* %t380 to i8*
  %t382 = bitcast i8* %t381 to i8**
  store i8* %t379, i8** %t382
  %t383 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t377, i32 0, i32 1
  %t384 = bitcast [16 x i8]* %t383 to i8*
  %t385 = getelementptr inbounds i8, i8* %t384, i64 8
  %t386 = bitcast i8* %t385 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t386
  %t387 = load %NativeInstruction, %NativeInstruction* %t377
  %t388 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t389 = ptrtoint [1 x %NativeInstruction]* %t388 to i64
  %t390 = icmp eq i64 %t389, 0
  %t391 = select i1 %t390, i64 1, i64 %t389
  %t392 = call i8* @malloc(i64 %t391)
  %t393 = bitcast i8* %t392 to %NativeInstruction*
  %t394 = getelementptr %NativeInstruction, %NativeInstruction* %t393, i64 0
  store %NativeInstruction %t387, %NativeInstruction* %t394
  %t395 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t396 = ptrtoint { %NativeInstruction*, i64 }* %t395 to i64
  %t397 = call i8* @malloc(i64 %t396)
  %t398 = bitcast i8* %t397 to { %NativeInstruction*, i64 }*
  %t399 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t398, i32 0, i32 0
  store %NativeInstruction* %t393, %NativeInstruction** %t399
  %t400 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t398, i32 0, i32 1
  store i64 1, i64* %t400
  %t401 = bitcast { %NativeInstruction*, i64 }* %t398 to { %NativeInstruction**, i64 }*
  %t402 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t401, 0
  %t403 = insertvalue %InstructionParseResult %t402, i1 1, 1
  %t404 = insertvalue %InstructionParseResult %t403, i1 0, 2
  ret %InstructionParseResult %t404
merge31:
  %s405 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090684245, i32 0, i32 0
  %t406 = call i1 @starts_with(i8* %line, i8* %s405)
  br i1 %t406, label %then34, label %merge35
then34:
  %t407 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t408 = icmp eq i64 %t407, 3
  br i1 %t408, label %then36, label %merge37
then36:
  %t409 = alloca %NativeInstruction
  %t410 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t409, i32 0, i32 0
  store i32 0, i32* %t410
  %s411 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t412 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t409, i32 0, i32 1
  %t413 = bitcast [16 x i8]* %t412 to i8*
  %t414 = bitcast i8* %t413 to i8**
  store i8* %s411, i8** %t414
  %t415 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t409, i32 0, i32 1
  %t416 = bitcast [16 x i8]* %t415 to i8*
  %t417 = getelementptr inbounds i8, i8* %t416, i64 8
  %t418 = bitcast i8* %t417 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t418
  %t419 = load %NativeInstruction, %NativeInstruction* %t409
  %t420 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t421 = ptrtoint [1 x %NativeInstruction]* %t420 to i64
  %t422 = icmp eq i64 %t421, 0
  %t423 = select i1 %t422, i64 1, i64 %t421
  %t424 = call i8* @malloc(i64 %t423)
  %t425 = bitcast i8* %t424 to %NativeInstruction*
  %t426 = getelementptr %NativeInstruction, %NativeInstruction* %t425, i64 0
  store %NativeInstruction %t419, %NativeInstruction* %t426
  %t427 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t428 = ptrtoint { %NativeInstruction*, i64 }* %t427 to i64
  %t429 = call i8* @malloc(i64 %t428)
  %t430 = bitcast i8* %t429 to { %NativeInstruction*, i64 }*
  %t431 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t430, i32 0, i32 0
  store %NativeInstruction* %t425, %NativeInstruction** %t431
  %t432 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t430, i32 0, i32 1
  store i64 1, i64* %t432
  %t433 = bitcast { %NativeInstruction*, i64 }* %t430 to { %NativeInstruction**, i64 }*
  %t434 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t433, 0
  %t435 = insertvalue %InstructionParseResult %t434, i1 1, 1
  %t436 = insertvalue %InstructionParseResult %t435, i1 0, 2
  ret %InstructionParseResult %t436
merge37:
  %t437 = getelementptr i8, i8* %line, i64 3
  %t438 = load i8, i8* %t437
  store i8 %t438, i8* %l9
  %t440 = load i8, i8* %l9
  %t441 = icmp eq i8 %t440, 32
  br label %logical_or_entry_439

logical_or_entry_439:
  br i1 %t441, label %logical_or_merge_439, label %logical_or_right_439

logical_or_right_439:
  %t442 = load i8, i8* %l9
  %t443 = icmp eq i8 %t442, 9
  br label %logical_or_right_end_439

logical_or_right_end_439:
  br label %logical_or_merge_439

logical_or_merge_439:
  %t444 = phi i1 [ true, %logical_or_entry_439 ], [ %t443, %logical_or_right_end_439 ]
  %t445 = load i8, i8* %l9
  br i1 %t444, label %then38, label %merge39
then38:
  %t446 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t447 = call i8* @sailfin_runtime_substring(i8* %line, i64 3, i64 %t446)
  %t448 = call i8* @trim_text(i8* %t447)
  store i8* %t448, i8** %l10
  %t449 = load i8*, i8** %l10
  %t450 = call i64 @sailfin_runtime_string_length(i8* %t449)
  %t451 = icmp eq i64 %t450, 0
  %t452 = load i8, i8* %l9
  %t453 = load i8*, i8** %l10
  br i1 %t451, label %then40, label %merge41
then40:
  %t454 = alloca %NativeInstruction
  %t455 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t454, i32 0, i32 0
  store i32 0, i32* %t455
  %s456 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t457 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t454, i32 0, i32 1
  %t458 = bitcast [16 x i8]* %t457 to i8*
  %t459 = bitcast i8* %t458 to i8**
  store i8* %s456, i8** %t459
  %t460 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t454, i32 0, i32 1
  %t461 = bitcast [16 x i8]* %t460 to i8*
  %t462 = getelementptr inbounds i8, i8* %t461, i64 8
  %t463 = bitcast i8* %t462 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t463
  %t464 = load %NativeInstruction, %NativeInstruction* %t454
  %t465 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t466 = ptrtoint [1 x %NativeInstruction]* %t465 to i64
  %t467 = icmp eq i64 %t466, 0
  %t468 = select i1 %t467, i64 1, i64 %t466
  %t469 = call i8* @malloc(i64 %t468)
  %t470 = bitcast i8* %t469 to %NativeInstruction*
  %t471 = getelementptr %NativeInstruction, %NativeInstruction* %t470, i64 0
  store %NativeInstruction %t464, %NativeInstruction* %t471
  %t472 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t473 = ptrtoint { %NativeInstruction*, i64 }* %t472 to i64
  %t474 = call i8* @malloc(i64 %t473)
  %t475 = bitcast i8* %t474 to { %NativeInstruction*, i64 }*
  %t476 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t475, i32 0, i32 0
  store %NativeInstruction* %t470, %NativeInstruction** %t476
  %t477 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t475, i32 0, i32 1
  store i64 1, i64* %t477
  %t478 = bitcast { %NativeInstruction*, i64 }* %t475 to { %NativeInstruction**, i64 }*
  %t479 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t478, 0
  %t480 = insertvalue %InstructionParseResult %t479, i1 1, 1
  %t481 = insertvalue %InstructionParseResult %t480, i1 0, 2
  ret %InstructionParseResult %t481
merge41:
  %t482 = alloca %NativeInstruction
  %t483 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t482, i32 0, i32 0
  store i32 0, i32* %t483
  %t484 = load i8*, i8** %l10
  %t485 = call i8* @trim_trailing_delimiters(i8* %t484)
  %t486 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t482, i32 0, i32 1
  %t487 = bitcast [16 x i8]* %t486 to i8*
  %t488 = bitcast i8* %t487 to i8**
  store i8* %t485, i8** %t488
  %t489 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t482, i32 0, i32 1
  %t490 = bitcast [16 x i8]* %t489 to i8*
  %t491 = getelementptr inbounds i8, i8* %t490, i64 8
  %t492 = bitcast i8* %t491 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t492
  %t493 = load %NativeInstruction, %NativeInstruction* %t482
  %t494 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t495 = ptrtoint [1 x %NativeInstruction]* %t494 to i64
  %t496 = icmp eq i64 %t495, 0
  %t497 = select i1 %t496, i64 1, i64 %t495
  %t498 = call i8* @malloc(i64 %t497)
  %t499 = bitcast i8* %t498 to %NativeInstruction*
  %t500 = getelementptr %NativeInstruction, %NativeInstruction* %t499, i64 0
  store %NativeInstruction %t493, %NativeInstruction* %t500
  %t501 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t502 = ptrtoint { %NativeInstruction*, i64 }* %t501 to i64
  %t503 = call i8* @malloc(i64 %t502)
  %t504 = bitcast i8* %t503 to { %NativeInstruction*, i64 }*
  %t505 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t504, i32 0, i32 0
  store %NativeInstruction* %t499, %NativeInstruction** %t505
  %t506 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t504, i32 0, i32 1
  store i64 1, i64* %t506
  %t507 = bitcast { %NativeInstruction*, i64 }* %t504 to { %NativeInstruction**, i64 }*
  %t508 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t507, 0
  %t509 = insertvalue %InstructionParseResult %t508, i1 1, 1
  %t510 = insertvalue %InstructionParseResult %t509, i1 0, 2
  ret %InstructionParseResult %t510
merge39:
  br label %merge35
merge35:
  %s511 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h890937508, i32 0, i32 0
  %t512 = call i1 @starts_with(i8* %line, i8* %s511)
  br i1 %t512, label %then42, label %merge43
then42:
  %s513 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h890937508, i32 0, i32 0
  %t514 = call i8* @strip_prefix(i8* %line, i8* %s513)
  %t515 = call i8* @trim_text(i8* %t514)
  store i8* %t515, i8** %l11
  store i1 0, i1* %l12
  %t516 = load i8*, i8** %l11
  %s517 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t518 = call i1 @starts_with(i8* %t516, i8* %s517)
  %t519 = load i8*, i8** %l11
  %t520 = load i1, i1* %l12
  br i1 %t518, label %then44, label %merge45
then44:
  store i1 1, i1* %l12
  %t521 = load i8*, i8** %l11
  %s522 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t523 = call i8* @strip_prefix(i8* %t521, i8* %s522)
  %t524 = call i8* @trim_text(i8* %t523)
  store i8* %t524, i8** %l11
  %t525 = load i1, i1* %l12
  %t526 = load i8*, i8** %l11
  br label %merge45
merge45:
  %t527 = phi i1 [ %t525, %then44 ], [ %t520, %then42 ]
  %t528 = phi i8* [ %t526, %then44 ], [ %t519, %then42 ]
  store i1 %t527, i1* %l12
  store i8* %t528, i8** %l11
  %t529 = load i8*, i8** %l11
  %t530 = call %BindingComponents @parse_binding_components(i8* %t529)
  store %BindingComponents %t530, %BindingComponents* %l13
  %t531 = alloca %NativeInstruction
  %t532 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t531, i32 0, i32 0
  store i32 2, i32* %t532
  %t533 = load %BindingComponents, %BindingComponents* %l13
  %t534 = extractvalue %BindingComponents %t533, 0
  %t535 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t531, i32 0, i32 1
  %t536 = bitcast [48 x i8]* %t535 to i8*
  %t537 = bitcast i8* %t536 to i8**
  store i8* %t534, i8** %t537
  %t538 = load i1, i1* %l12
  %t539 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t531, i32 0, i32 1
  %t540 = bitcast [48 x i8]* %t539 to i8*
  %t541 = getelementptr inbounds i8, i8* %t540, i64 8
  %t542 = bitcast i8* %t541 to i1*
  store i1 %t538, i1* %t542
  %t543 = load %BindingComponents, %BindingComponents* %l13
  %t544 = extractvalue %BindingComponents %t543, 1
  %t545 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t531, i32 0, i32 1
  %t546 = bitcast [48 x i8]* %t545 to i8*
  %t547 = getelementptr inbounds i8, i8* %t546, i64 16
  %t548 = bitcast i8* %t547 to i8**
  store i8* %t544, i8** %t548
  %t549 = load %BindingComponents, %BindingComponents* %l13
  %t550 = extractvalue %BindingComponents %t549, 2
  %t551 = call i8* @maybe_trim_trailing(i8* %t550)
  %t552 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t531, i32 0, i32 1
  %t553 = bitcast [48 x i8]* %t552 to i8*
  %t554 = getelementptr inbounds i8, i8* %t553, i64 24
  %t555 = bitcast i8* %t554 to i8**
  store i8* %t551, i8** %t555
  %t556 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t531, i32 0, i32 1
  %t557 = bitcast [48 x i8]* %t556 to i8*
  %t558 = getelementptr inbounds i8, i8* %t557, i64 32
  %t559 = bitcast i8* %t558 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t559
  %t560 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t531, i32 0, i32 1
  %t561 = bitcast [48 x i8]* %t560 to i8*
  %t562 = getelementptr inbounds i8, i8* %t561, i64 40
  %t563 = bitcast i8* %t562 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t563
  %t564 = load %NativeInstruction, %NativeInstruction* %t531
  %t565 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t566 = ptrtoint [1 x %NativeInstruction]* %t565 to i64
  %t567 = icmp eq i64 %t566, 0
  %t568 = select i1 %t567, i64 1, i64 %t566
  %t569 = call i8* @malloc(i64 %t568)
  %t570 = bitcast i8* %t569 to %NativeInstruction*
  %t571 = getelementptr %NativeInstruction, %NativeInstruction* %t570, i64 0
  store %NativeInstruction %t564, %NativeInstruction* %t571
  %t572 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t573 = ptrtoint { %NativeInstruction*, i64 }* %t572 to i64
  %t574 = call i8* @malloc(i64 %t573)
  %t575 = bitcast i8* %t574 to { %NativeInstruction*, i64 }*
  %t576 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t575, i32 0, i32 0
  store %NativeInstruction* %t570, %NativeInstruction** %t576
  %t577 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t575, i32 0, i32 1
  store i64 1, i64* %t577
  %t578 = bitcast { %NativeInstruction*, i64 }* %t575 to { %NativeInstruction**, i64 }*
  %t579 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t578, 0
  %t580 = insertvalue %InstructionParseResult %t579, i1 1, 1
  %t581 = insertvalue %InstructionParseResult %t580, i1 1, 2
  ret %InstructionParseResult %t581
merge43:
  %s582 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t583 = call i1 @starts_with(i8* %line, i8* %s582)
  br i1 %t583, label %then46, label %merge47
then46:
  %t584 = alloca %NativeInstruction
  %t585 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t584, i32 0, i32 0
  store i32 1, i32* %t585
  %s586 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t587 = call i8* @strip_prefix(i8* %line, i8* %s586)
  %t588 = call i8* @trim_text(i8* %t587)
  %t589 = call i8* @trim_trailing_delimiters(i8* %t588)
  %t590 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t584, i32 0, i32 1
  %t591 = bitcast [16 x i8]* %t590 to i8*
  %t592 = bitcast i8* %t591 to i8**
  store i8* %t589, i8** %t592
  %t593 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t584, i32 0, i32 1
  %t594 = bitcast [16 x i8]* %t593 to i8*
  %t595 = getelementptr inbounds i8, i8* %t594, i64 8
  %t596 = bitcast i8* %t595 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t596
  %t597 = load %NativeInstruction, %NativeInstruction* %t584
  %t598 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t599 = ptrtoint [1 x %NativeInstruction]* %t598 to i64
  %t600 = icmp eq i64 %t599, 0
  %t601 = select i1 %t600, i64 1, i64 %t599
  %t602 = call i8* @malloc(i64 %t601)
  %t603 = bitcast i8* %t602 to %NativeInstruction*
  %t604 = getelementptr %NativeInstruction, %NativeInstruction* %t603, i64 0
  store %NativeInstruction %t597, %NativeInstruction* %t604
  %t605 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t606 = ptrtoint { %NativeInstruction*, i64 }* %t605 to i64
  %t607 = call i8* @malloc(i64 %t606)
  %t608 = bitcast i8* %t607 to { %NativeInstruction*, i64 }*
  %t609 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t608, i32 0, i32 0
  store %NativeInstruction* %t603, %NativeInstruction** %t609
  %t610 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t608, i32 0, i32 1
  store i64 1, i64* %t610
  %t611 = bitcast { %NativeInstruction*, i64 }* %t608 to { %NativeInstruction**, i64 }*
  %t612 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t611, 0
  %t613 = insertvalue %InstructionParseResult %t612, i1 1, 1
  %t614 = insertvalue %InstructionParseResult %t613, i1 0, 2
  ret %InstructionParseResult %t614
merge47:
  %s615 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
  %t616 = call double @index_of(i8* %line, i8* %s615)
  %t617 = sitofp i64 0 to double
  %t618 = fcmp oge double %t616, %t617
  br i1 %t618, label %then48, label %merge49
then48:
  %t619 = call { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line)
  %t620 = bitcast { %NativeInstruction*, i64 }* %t619 to { %NativeInstruction**, i64 }*
  %t621 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t620, 0
  %t622 = insertvalue %InstructionParseResult %t621, i1 0, 1
  %t623 = insertvalue %InstructionParseResult %t622, i1 0, 2
  ret %InstructionParseResult %t623
merge49:
  %t624 = alloca %NativeInstruction
  %t625 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t624, i32 0, i32 0
  store i32 16, i32* %t625
  %t626 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t624, i32 0, i32 1
  %t627 = bitcast [8 x i8]* %t626 to i8*
  %t628 = bitcast i8* %t627 to i8**
  store i8* %line, i8** %t628
  %t629 = load %NativeInstruction, %NativeInstruction* %t624
  %t630 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t631 = ptrtoint [1 x %NativeInstruction]* %t630 to i64
  %t632 = icmp eq i64 %t631, 0
  %t633 = select i1 %t632, i64 1, i64 %t631
  %t634 = call i8* @malloc(i64 %t633)
  %t635 = bitcast i8* %t634 to %NativeInstruction*
  %t636 = getelementptr %NativeInstruction, %NativeInstruction* %t635, i64 0
  store %NativeInstruction %t629, %NativeInstruction* %t636
  %t637 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t638 = ptrtoint { %NativeInstruction*, i64 }* %t637 to i64
  %t639 = call i8* @malloc(i64 %t638)
  %t640 = bitcast i8* %t639 to { %NativeInstruction*, i64 }*
  %t641 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t640, i32 0, i32 0
  store %NativeInstruction* %t635, %NativeInstruction** %t641
  %t642 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t640, i32 0, i32 1
  store i64 1, i64* %t642
  %t643 = bitcast { %NativeInstruction*, i64 }* %t640 to { %NativeInstruction**, i64 }*
  %t644 = insertvalue %InstructionParseResult undef, { %NativeInstruction**, i64 }* %t643, 0
  %t645 = insertvalue %InstructionParseResult %t644, i1 0, 1
  %t646 = insertvalue %InstructionParseResult %t645, i1 0, 2
  ret %InstructionParseResult %t646
}

define %NativeInstruction @parse_case_instruction(i8* %line) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %CaseComponents
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1187178968, i32 0, i32 0
  %t1 = call i8* @strip_prefix(i8* %line, i8* %s0)
  %t2 = call i8* @trim_text(i8* %t1)
  store i8* %t2, i8** %l0
  %t3 = load i8*, i8** %l0
  %t4 = call %CaseComponents @split_case_components(i8* %t3)
  store %CaseComponents %t4, %CaseComponents* %l1
  %t5 = alloca %NativeInstruction
  %t6 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t5, i32 0, i32 0
  store i32 13, i32* %t6
  %t7 = load %CaseComponents, %CaseComponents* %l1
  %t8 = extractvalue %CaseComponents %t7, 0
  %t9 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t5, i32 0, i32 1
  %t10 = bitcast [16 x i8]* %t9 to i8*
  %t11 = bitcast i8* %t10 to i8**
  store i8* %t8, i8** %t11
  %t12 = load %CaseComponents, %CaseComponents* %l1
  %t13 = extractvalue %CaseComponents %t12, 1
  %t14 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t5, i32 0, i32 1
  %t15 = bitcast [16 x i8]* %t14 to i8*
  %t16 = getelementptr inbounds i8, i8* %t15, i64 8
  %t17 = bitcast i8* %t16 to i8**
  store i8* %t13, i8** %t17
  %t18 = load %NativeInstruction, %NativeInstruction* %t5
  ret %NativeInstruction %t18
}

define { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca %CaseComponents
  %l5 = alloca { %NativeInstruction*, i64 }*
  %l6 = alloca %NativeInstruction
  %t0 = call i8* @trim_text(i8* %line)
  %t1 = call i8* @trim_trailing_delimiters(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %s3 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
  %t4 = call double @index_of(i8* %t2, i8* %s3)
  store double %t4, double* %l1
  %t5 = load double, double* %l1
  %t6 = sitofp i64 0 to double
  %t7 = fcmp olt double %t5, %t6
  %t8 = load i8*, i8** %l0
  %t9 = load double, double* %l1
  br i1 %t7, label %then0, label %merge1
then0:
  %t10 = alloca %NativeInstruction
  %t11 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 0
  store i32 16, i32* %t11
  %t12 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t13 = bitcast [8 x i8]* %t12 to i8*
  %t14 = bitcast i8* %t13 to i8**
  store i8* %line, i8** %t14
  %t15 = load %NativeInstruction, %NativeInstruction* %t10
  %t16 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t17 = ptrtoint [1 x %NativeInstruction]* %t16 to i64
  %t18 = icmp eq i64 %t17, 0
  %t19 = select i1 %t18, i64 1, i64 %t17
  %t20 = call i8* @malloc(i64 %t19)
  %t21 = bitcast i8* %t20 to %NativeInstruction*
  %t22 = getelementptr %NativeInstruction, %NativeInstruction* %t21, i64 0
  store %NativeInstruction %t15, %NativeInstruction* %t22
  %t23 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t24 = ptrtoint { %NativeInstruction*, i64 }* %t23 to i64
  %t25 = call i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to { %NativeInstruction*, i64 }*
  %t27 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t26, i32 0, i32 0
  store %NativeInstruction* %t21, %NativeInstruction** %t27
  %t28 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t26, i32 0, i32 1
  store i64 1, i64* %t28
  ret { %NativeInstruction*, i64 }* %t26
merge1:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l1
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = call i8* @sailfin_runtime_substring(i8* %t29, i64 0, i64 %t32)
  %t34 = call i8* @trim_text(i8* %t33)
  store i8* %t34, i8** %l2
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l1
  %t37 = sitofp i64 2 to double
  %t38 = fadd double %t36, %t37
  %t39 = load i8*, i8** %l0
  %t40 = call i64 @sailfin_runtime_string_length(i8* %t39)
  %t41 = call double @llvm.round.f64(double %t38)
  %t42 = fptosi double %t41 to i64
  %t43 = call i8* @sailfin_runtime_substring(i8* %t35, i64 %t42, i64 %t40)
  %t44 = call i8* @trim_text(i8* %t43)
  %t45 = call i8* @trim_trailing_delimiters(i8* %t44)
  store i8* %t45, i8** %l3
  %t46 = load i8*, i8** %l2
  %t47 = call %CaseComponents @split_case_components(i8* %t46)
  store %CaseComponents %t47, %CaseComponents* %l4
  %t48 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* null, i32 1
  %t49 = ptrtoint [0 x %NativeInstruction]* %t48 to i64
  %t50 = icmp eq i64 %t49, 0
  %t51 = select i1 %t50, i64 1, i64 %t49
  %t52 = call i8* @malloc(i64 %t51)
  %t53 = bitcast i8* %t52 to %NativeInstruction*
  %t54 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t55 = ptrtoint { %NativeInstruction*, i64 }* %t54 to i64
  %t56 = call i8* @malloc(i64 %t55)
  %t57 = bitcast i8* %t56 to { %NativeInstruction*, i64 }*
  %t58 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t57, i32 0, i32 0
  store %NativeInstruction* %t53, %NativeInstruction** %t58
  %t59 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t57, i32 0, i32 1
  store i64 0, i64* %t59
  store { %NativeInstruction*, i64 }* %t57, { %NativeInstruction*, i64 }** %l5
  %t60 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t61 = alloca %NativeInstruction
  %t62 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t61, i32 0, i32 0
  store i32 13, i32* %t62
  %t63 = load %CaseComponents, %CaseComponents* %l4
  %t64 = extractvalue %CaseComponents %t63, 0
  %t65 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t61, i32 0, i32 1
  %t66 = bitcast [16 x i8]* %t65 to i8*
  %t67 = bitcast i8* %t66 to i8**
  store i8* %t64, i8** %t67
  %t68 = load %CaseComponents, %CaseComponents* %l4
  %t69 = extractvalue %CaseComponents %t68, 1
  %t70 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t61, i32 0, i32 1
  %t71 = bitcast [16 x i8]* %t70 to i8*
  %t72 = getelementptr inbounds i8, i8* %t71, i64 8
  %t73 = bitcast i8* %t72 to i8**
  store i8* %t69, i8** %t73
  %t74 = load %NativeInstruction, %NativeInstruction* %t61
  %t75 = call noalias i8* @malloc(i64 56)
  %t76 = bitcast i8* %t75 to %NativeInstruction*
  store %NativeInstruction %t74, %NativeInstruction* %t76
  %t77 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t78 = ptrtoint [1 x i8*]* %t77 to i64
  %t79 = icmp eq i64 %t78, 0
  %t80 = select i1 %t79, i64 1, i64 %t78
  %t81 = call i8* @malloc(i64 %t80)
  %t82 = bitcast i8* %t81 to i8**
  %t83 = getelementptr i8*, i8** %t82, i64 0
  store i8* %t75, i8** %t83
  %t84 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t85 = ptrtoint { i8**, i64 }* %t84 to i64
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to { i8**, i64 }*
  %t88 = getelementptr { i8**, i64 }, { i8**, i64 }* %t87, i32 0, i32 0
  store i8** %t82, i8*** %t88
  %t89 = getelementptr { i8**, i64 }, { i8**, i64 }* %t87, i32 0, i32 1
  store i64 1, i64* %t89
  %t90 = bitcast { %NativeInstruction*, i64 }* %t60 to { i8**, i64 }*
  %t91 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t90, { i8**, i64 }* %t87)
  %t92 = bitcast { i8**, i64 }* %t91 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t92, { %NativeInstruction*, i64 }** %l5
  %t93 = load i8*, i8** %l3
  %t94 = call i64 @sailfin_runtime_string_length(i8* %t93)
  %t95 = icmp eq i64 %t94, 0
  %t96 = load i8*, i8** %l0
  %t97 = load double, double* %l1
  %t98 = load i8*, i8** %l2
  %t99 = load i8*, i8** %l3
  %t100 = load %CaseComponents, %CaseComponents* %l4
  %t101 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  br i1 %t95, label %then2, label %merge3
then2:
  %t102 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t103 = insertvalue %NativeInstruction undef, i32 15, 0
  %t104 = call noalias i8* @malloc(i64 56)
  %t105 = bitcast i8* %t104 to %NativeInstruction*
  store %NativeInstruction %t103, %NativeInstruction* %t105
  %t106 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t107 = ptrtoint [1 x i8*]* %t106 to i64
  %t108 = icmp eq i64 %t107, 0
  %t109 = select i1 %t108, i64 1, i64 %t107
  %t110 = call i8* @malloc(i64 %t109)
  %t111 = bitcast i8* %t110 to i8**
  %t112 = getelementptr i8*, i8** %t111, i64 0
  store i8* %t104, i8** %t112
  %t113 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t114 = ptrtoint { i8**, i64 }* %t113 to i64
  %t115 = call i8* @malloc(i64 %t114)
  %t116 = bitcast i8* %t115 to { i8**, i64 }*
  %t117 = getelementptr { i8**, i64 }, { i8**, i64 }* %t116, i32 0, i32 0
  store i8** %t111, i8*** %t117
  %t118 = getelementptr { i8**, i64 }, { i8**, i64 }* %t116, i32 0, i32 1
  store i64 1, i64* %t118
  %t119 = bitcast { %NativeInstruction*, i64 }* %t102 to { i8**, i64 }*
  %t120 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t119, { i8**, i64 }* %t116)
  %t121 = bitcast { i8**, i64 }* %t120 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t121, { %NativeInstruction*, i64 }** %l5
  %t122 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t122
merge3:
  %t123 = load i8*, i8** %l3
  %t124 = call %NativeInstruction @parse_inline_case_body_instruction(i8* %t123)
  store %NativeInstruction %t124, %NativeInstruction* %l6
  %t125 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t126 = load %NativeInstruction, %NativeInstruction* %l6
  %t127 = call noalias i8* @malloc(i64 56)
  %t128 = bitcast i8* %t127 to %NativeInstruction*
  store %NativeInstruction %t126, %NativeInstruction* %t128
  %t129 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t130 = ptrtoint [1 x i8*]* %t129 to i64
  %t131 = icmp eq i64 %t130, 0
  %t132 = select i1 %t131, i64 1, i64 %t130
  %t133 = call i8* @malloc(i64 %t132)
  %t134 = bitcast i8* %t133 to i8**
  %t135 = getelementptr i8*, i8** %t134, i64 0
  store i8* %t127, i8** %t135
  %t136 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t137 = ptrtoint { i8**, i64 }* %t136 to i64
  %t138 = call i8* @malloc(i64 %t137)
  %t139 = bitcast i8* %t138 to { i8**, i64 }*
  %t140 = getelementptr { i8**, i64 }, { i8**, i64 }* %t139, i32 0, i32 0
  store i8** %t134, i8*** %t140
  %t141 = getelementptr { i8**, i64 }, { i8**, i64 }* %t139, i32 0, i32 1
  store i64 1, i64* %t141
  %t142 = bitcast { %NativeInstruction*, i64 }* %t125 to { i8**, i64 }*
  %t143 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t142, { i8**, i64 }* %t139)
  %t144 = bitcast { i8**, i64 }* %t143 to { %NativeInstruction*, i64 }*
  store { %NativeInstruction*, i64 }* %t144, { %NativeInstruction*, i64 }** %l5
  %t145 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t145
}

define %NativeInstruction @parse_inline_case_body_instruction(i8* %body) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %t0 = call i8* @trim_trailing_delimiters(i8* %body)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h655348872, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  %t9 = call i8* @trim_trailing_delimiters(i8* %t8)
  store i8* %t9, i8** %l1
  %t10 = alloca %NativeInstruction
  %t11 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 0
  store i32 0, i32* %t11
  %t12 = load i8*, i8** %l1
  %t13 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t14 = bitcast [16 x i8]* %t13 to i8*
  %t15 = bitcast i8* %t14 to i8**
  store i8* %t12, i8** %t15
  %t16 = bitcast i8* null to %NativeSourceSpan*
  %t17 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t10, i32 0, i32 1
  %t18 = bitcast [16 x i8]* %t17 to i8*
  %t19 = getelementptr inbounds i8, i8* %t18, i64 8
  %t20 = bitcast i8* %t19 to %NativeSourceSpan**
  store %NativeSourceSpan* %t16, %NativeSourceSpan** %t20
  %t21 = load %NativeInstruction, %NativeInstruction* %t10
  ret %NativeInstruction %t21
merge1:
  %t22 = load i8*, i8** %l0
  %s23 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t24 = call i1 @starts_with(i8* %t22, i8* %s23)
  %t25 = load i8*, i8** %l0
  br i1 %t24, label %then2, label %merge3
then2:
  %t26 = alloca %NativeInstruction
  %t27 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 0
  store i32 1, i32* %t27
  %t28 = load i8*, i8** %l0
  %s29 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t30 = call i8* @strip_prefix(i8* %t28, i8* %s29)
  %t31 = call i8* @trim_text(i8* %t30)
  %t32 = call i8* @trim_trailing_delimiters(i8* %t31)
  %t33 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 1
  %t34 = bitcast [16 x i8]* %t33 to i8*
  %t35 = bitcast i8* %t34 to i8**
  store i8* %t32, i8** %t35
  %t36 = bitcast i8* null to %NativeSourceSpan*
  %t37 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t26, i32 0, i32 1
  %t38 = bitcast [16 x i8]* %t37 to i8*
  %t39 = getelementptr inbounds i8, i8* %t38, i64 8
  %t40 = bitcast i8* %t39 to %NativeSourceSpan**
  store %NativeSourceSpan* %t36, %NativeSourceSpan** %t40
  %t41 = load %NativeInstruction, %NativeInstruction* %t26
  ret %NativeInstruction %t41
merge3:
  %t42 = alloca %NativeInstruction
  %t43 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t42, i32 0, i32 0
  store i32 1, i32* %t43
  %t44 = load i8*, i8** %l0
  %t45 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t42, i32 0, i32 1
  %t46 = bitcast [16 x i8]* %t45 to i8*
  %t47 = bitcast i8* %t46 to i8**
  store i8* %t44, i8** %t47
  %t48 = bitcast i8* null to %NativeSourceSpan*
  %t49 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t42, i32 0, i32 1
  %t50 = bitcast [16 x i8]* %t49 to i8*
  %t51 = getelementptr inbounds i8, i8* %t50, i64 8
  %t52 = bitcast i8* %t51 to %NativeSourceSpan**
  store %NativeSourceSpan* %t48, %NativeSourceSpan** %t52
  %t53 = load %NativeInstruction, %NativeInstruction* %t42
  ret %NativeInstruction %t53
}

define %CaseComponents @split_case_components(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %t6 = insertvalue %CaseComponents undef, i8* %t5, 0
  %t7 = insertvalue %CaseComponents %t6, i8* null, 1
  ret %CaseComponents %t7
merge1:
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175987322, i32 0, i32 0
  store i8* %s8, i8** %l1
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = call double @last_index_of(i8* %t9, i8* %t10)
  store double %t11, double* %l2
  %t12 = load double, double* %l2
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then2, label %merge3
then2:
  %t18 = load i8*, i8** %l0
  %t19 = insertvalue %CaseComponents undef, i8* %t18, 0
  %t20 = insertvalue %CaseComponents %t19, i8* null, 1
  ret %CaseComponents %t20
merge3:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l2
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = call i8* @sailfin_runtime_substring(i8* %t21, i64 0, i64 %t24)
  %t26 = call i8* @trim_text(i8* %t25)
  store i8* %t26, i8** %l3
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l2
  %t29 = load i8*, i8** %l1
  %t30 = call i64 @sailfin_runtime_string_length(i8* %t29)
  %t31 = sitofp i64 %t30 to double
  %t32 = fadd double %t28, %t31
  %t33 = load i8*, i8** %l0
  %t34 = call i64 @sailfin_runtime_string_length(i8* %t33)
  %t35 = call double @llvm.round.f64(double %t32)
  %t36 = fptosi double %t35 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %t27, i64 %t36, i64 %t34)
  %t38 = call i8* @trim_text(i8* %t37)
  store i8* %t38, i8** %l4
  %t39 = load i8*, i8** %l4
  %t40 = call i64 @sailfin_runtime_string_length(i8* %t39)
  %t41 = icmp eq i64 %t40, 0
  %t42 = load i8*, i8** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l2
  %t45 = load i8*, i8** %l3
  %t46 = load i8*, i8** %l4
  br i1 %t41, label %then4, label %merge5
then4:
  %t47 = load i8*, i8** %l3
  %t48 = insertvalue %CaseComponents undef, i8* %t47, 0
  %t49 = insertvalue %CaseComponents %t48, i8* null, 1
  ret %CaseComponents %t49
merge5:
  %t50 = load i8*, i8** %l3
  %t51 = insertvalue %CaseComponents undef, i8* %t50, 0
  %t52 = load i8*, i8** %l4
  %t53 = insertvalue %CaseComponents %t51, i8* %t52, 1
  ret %CaseComponents %t53
}

define %NativeImport* @parse_import_entry(i8* %kind, i8* %entry) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca { %NativeImportSpecifier*, i64 }*
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeImport*
  ret %NativeImport* %t5
merge1:
  %t6 = load i8*, i8** %l0
  store i8* %t6, i8** %l1
  %t7 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* null, i32 1
  %t8 = ptrtoint [0 x %NativeImportSpecifier]* %t7 to i64
  %t9 = icmp eq i64 %t8, 0
  %t10 = select i1 %t9, i64 1, i64 %t8
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to %NativeImportSpecifier*
  %t13 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* null, i32 1
  %t14 = ptrtoint { %NativeImportSpecifier*, i64 }* %t13 to i64
  %t15 = call i8* @malloc(i64 %t14)
  %t16 = bitcast i8* %t15 to { %NativeImportSpecifier*, i64 }*
  %t17 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t16, i32 0, i32 0
  store %NativeImportSpecifier* %t12, %NativeImportSpecifier** %t17
  %t18 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t16, i32 0, i32 1
  store i64 0, i64* %t18
  store { %NativeImportSpecifier*, i64 }* %t16, { %NativeImportSpecifier*, i64 }** %l2
  %t19 = load i8*, i8** %l0
  %t20 = alloca [2 x i8], align 1
  %t21 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  store i8 123, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 1
  store i8 0, i8* %t22
  %t23 = getelementptr [2 x i8], [2 x i8]* %t20, i32 0, i32 0
  %t24 = call double @index_of(i8* %t19, i8* %t23)
  store double %t24, double* %l3
  %t25 = load double, double* %l3
  %t26 = sitofp i64 0 to double
  %t27 = fcmp oge double %t25, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load i8*, i8** %l1
  %t30 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t31 = load double, double* %l3
  br i1 %t27, label %then2, label %merge3
then2:
  %t32 = load i8*, i8** %l0
  %t33 = alloca [2 x i8], align 1
  %t34 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  store i8 125, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 1
  store i8 0, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  %t37 = call double @last_index_of(i8* %t32, i8* %t36)
  store double %t37, double* %l4
  %t39 = load double, double* %l4
  %t40 = sitofp i64 0 to double
  %t41 = fcmp olt double %t39, %t40
  br label %logical_or_entry_38

logical_or_entry_38:
  br i1 %t41, label %logical_or_merge_38, label %logical_or_right_38

logical_or_right_38:
  %t42 = load double, double* %l4
  %t43 = load double, double* %l3
  %t44 = fcmp ole double %t42, %t43
  br label %logical_or_right_end_38

logical_or_right_end_38:
  br label %logical_or_merge_38

logical_or_merge_38:
  %t45 = phi i1 [ true, %logical_or_entry_38 ], [ %t44, %logical_or_right_end_38 ]
  %t46 = load i8*, i8** %l0
  %t47 = load i8*, i8** %l1
  %t48 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t49 = load double, double* %l3
  %t50 = load double, double* %l4
  br i1 %t45, label %then4, label %merge5
then4:
  %t51 = bitcast i8* null to %NativeImport*
  ret %NativeImport* %t51
merge5:
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l3
  %t54 = call double @llvm.round.f64(double %t53)
  %t55 = fptosi double %t54 to i64
  %t56 = call i8* @sailfin_runtime_substring(i8* %t52, i64 0, i64 %t55)
  %t57 = call i8* @trim_text(i8* %t56)
  store i8* %t57, i8** %l1
  %t58 = load i8*, i8** %l0
  %t59 = load double, double* %l3
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  %t62 = load double, double* %l4
  %t63 = call double @llvm.round.f64(double %t61)
  %t64 = fptosi double %t63 to i64
  %t65 = call double @llvm.round.f64(double %t62)
  %t66 = fptosi double %t65 to i64
  %t67 = call i8* @sailfin_runtime_substring(i8* %t58, i64 %t64, i64 %t66)
  store i8* %t67, i8** %l5
  %t68 = load i8*, i8** %l5
  %t69 = call { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %t68)
  store { %NativeImportSpecifier*, i64 }* %t69, { %NativeImportSpecifier*, i64 }** %l2
  %t70 = load i8*, i8** %l1
  %t71 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge3
merge3:
  %t72 = phi i8* [ %t70, %merge5 ], [ %t29, %merge1 ]
  %t73 = phi { %NativeImportSpecifier*, i64 }* [ %t71, %merge5 ], [ %t30, %merge1 ]
  store i8* %t72, i8** %l1
  store { %NativeImportSpecifier*, i64 }* %t73, { %NativeImportSpecifier*, i64 }** %l2
  %t74 = load i8*, i8** %l1
  %t75 = call i8* @trim_text(i8* %t74)
  %t76 = call i8* @strip_quotes(i8* %t75)
  store i8* %t76, i8** %l1
  %t77 = insertvalue %NativeImport undef, i8* %kind, 0
  %t78 = load i8*, i8** %l1
  %t79 = insertvalue %NativeImport %t77, i8* %t78, 1
  %t80 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t81 = bitcast { %NativeImportSpecifier*, i64 }* %t80 to { %NativeImportSpecifier**, i64 }*
  %t82 = insertvalue %NativeImport %t79, { %NativeImportSpecifier**, i64 }* %t81, 2
  %t83 = alloca %NativeImport
  store %NativeImport %t82, %NativeImport* %t83
  ret %NativeImport* %t83
}

define { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeImportSpecifier*, i64 }*
  %l3 = alloca double
  %l4 = alloca %NativeImportSpecifier
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* null, i32 1
  %t6 = ptrtoint [0 x %NativeImportSpecifier]* %t5 to i64
  %t7 = icmp eq i64 %t6, 0
  %t8 = select i1 %t7, i64 1, i64 %t6
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to %NativeImportSpecifier*
  %t11 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* null, i32 1
  %t12 = ptrtoint { %NativeImportSpecifier*, i64 }* %t11 to i64
  %t13 = call i8* @malloc(i64 %t12)
  %t14 = bitcast i8* %t13 to { %NativeImportSpecifier*, i64 }*
  %t15 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t14, i32 0, i32 0
  store %NativeImportSpecifier* %t10, %NativeImportSpecifier** %t15
  %t16 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t14, i32 0, i32 1
  store i64 0, i64* %t16
  ret { %NativeImportSpecifier*, i64 }* %t14
merge1:
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_comma_separated(i8* %t17)
  store { i8**, i64 }* %t18, { i8**, i64 }** %l1
  %t19 = getelementptr [0 x %NativeImportSpecifier], [0 x %NativeImportSpecifier]* null, i32 1
  %t20 = ptrtoint [0 x %NativeImportSpecifier]* %t19 to i64
  %t21 = icmp eq i64 %t20, 0
  %t22 = select i1 %t21, i64 1, i64 %t20
  %t23 = call i8* @malloc(i64 %t22)
  %t24 = bitcast i8* %t23 to %NativeImportSpecifier*
  %t25 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* null, i32 1
  %t26 = ptrtoint { %NativeImportSpecifier*, i64 }* %t25 to i64
  %t27 = call i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to { %NativeImportSpecifier*, i64 }*
  %t29 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t28, i32 0, i32 0
  store %NativeImportSpecifier* %t24, %NativeImportSpecifier** %t29
  %t30 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t28, i32 0, i32 1
  store i64 0, i64* %t30
  store { %NativeImportSpecifier*, i64 }* %t28, { %NativeImportSpecifier*, i64 }** %l2
  %t31 = sitofp i64 0 to double
  store double %t31, double* %l3
  %t32 = load i8*, i8** %l0
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t35 = load double, double* %l3
  br label %loop.header2
loop.header2:
  %t93 = phi { %NativeImportSpecifier*, i64 }* [ %t34, %merge1 ], [ %t91, %loop.latch4 ]
  %t94 = phi double [ %t35, %merge1 ], [ %t92, %loop.latch4 ]
  store { %NativeImportSpecifier*, i64 }* %t93, { %NativeImportSpecifier*, i64 }** %l2
  store double %t94, double* %l3
  br label %loop.body3
loop.body3:
  %t36 = load double, double* %l3
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load { i8**, i64 }, { i8**, i64 }* %t37
  %t39 = extractvalue { i8**, i64 } %t38, 1
  %t40 = sitofp i64 %t39 to double
  %t41 = fcmp oge double %t36, %t40
  %t42 = load i8*, i8** %l0
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t44 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t45 = load double, double* %l3
  br i1 %t41, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load double, double* %l3
  %t48 = call double @llvm.round.f64(double %t47)
  %t49 = fptosi double %t48 to i64
  %t50 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t51 = extractvalue { i8**, i64 } %t50, 0
  %t52 = extractvalue { i8**, i64 } %t50, 1
  %t53 = icmp uge i64 %t49, %t52
  ; bounds check: %t53 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t49, i64 %t52)
  %t54 = getelementptr i8*, i8** %t51, i64 %t49
  %t55 = load i8*, i8** %t54
  %t56 = call %NativeImportSpecifier @parse_single_specifier(i8* %t55)
  store %NativeImportSpecifier %t56, %NativeImportSpecifier* %l4
  %t57 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t58 = extractvalue %NativeImportSpecifier %t57, 0
  %t59 = call i64 @sailfin_runtime_string_length(i8* %t58)
  %t60 = icmp sgt i64 %t59, 0
  %t61 = load i8*, i8** %l0
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t63 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t64 = load double, double* %l3
  %t65 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  br i1 %t60, label %then8, label %merge9
then8:
  %t66 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t67 = load %NativeImportSpecifier, %NativeImportSpecifier* %l4
  %t68 = call noalias i8* @malloc(i64 16)
  %t69 = bitcast i8* %t68 to %NativeImportSpecifier*
  store %NativeImportSpecifier %t67, %NativeImportSpecifier* %t69
  %t70 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t71 = ptrtoint [1 x i8*]* %t70 to i64
  %t72 = icmp eq i64 %t71, 0
  %t73 = select i1 %t72, i64 1, i64 %t71
  %t74 = call i8* @malloc(i64 %t73)
  %t75 = bitcast i8* %t74 to i8**
  %t76 = getelementptr i8*, i8** %t75, i64 0
  store i8* %t68, i8** %t76
  %t77 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t78 = ptrtoint { i8**, i64 }* %t77 to i64
  %t79 = call i8* @malloc(i64 %t78)
  %t80 = bitcast i8* %t79 to { i8**, i64 }*
  %t81 = getelementptr { i8**, i64 }, { i8**, i64 }* %t80, i32 0, i32 0
  store i8** %t75, i8*** %t81
  %t82 = getelementptr { i8**, i64 }, { i8**, i64 }* %t80, i32 0, i32 1
  store i64 1, i64* %t82
  %t83 = bitcast { %NativeImportSpecifier*, i64 }* %t66 to { i8**, i64 }*
  %t84 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t83, { i8**, i64 }* %t80)
  %t85 = bitcast { i8**, i64 }* %t84 to { %NativeImportSpecifier*, i64 }*
  store { %NativeImportSpecifier*, i64 }* %t85, { %NativeImportSpecifier*, i64 }** %l2
  %t86 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge9
merge9:
  %t87 = phi { %NativeImportSpecifier*, i64 }* [ %t86, %then8 ], [ %t63, %merge7 ]
  store { %NativeImportSpecifier*, i64 }* %t87, { %NativeImportSpecifier*, i64 }** %l2
  %t88 = load double, double* %l3
  %t89 = sitofp i64 1 to double
  %t90 = fadd double %t88, %t89
  store double %t90, double* %l3
  br label %loop.latch4
loop.latch4:
  %t91 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t92 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t95 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t96 = load double, double* %l3
  %t97 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t97
}

define %NativeImportSpecifier @parse_single_specifier(i8* %entry) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %entry)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %s5 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t6 = insertvalue %NativeImportSpecifier undef, i8* %s5, 0
  %t7 = insertvalue %NativeImportSpecifier %t6, i8* null, 1
  ret %NativeImportSpecifier %t7
merge1:
  %s8 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175713983, i32 0, i32 0
  store i8* %s8, i8** %l1
  %t9 = load i8*, i8** %l0
  %t10 = load i8*, i8** %l1
  %t11 = call double @index_of(i8* %t9, i8* %t10)
  store double %t11, double* %l2
  %t12 = load double, double* %l2
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  br i1 %t14, label %then2, label %merge3
then2:
  %t18 = load i8*, i8** %l0
  %t19 = insertvalue %NativeImportSpecifier undef, i8* %t18, 0
  %t20 = insertvalue %NativeImportSpecifier %t19, i8* null, 1
  ret %NativeImportSpecifier %t20
merge3:
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l2
  %t23 = call double @llvm.round.f64(double %t22)
  %t24 = fptosi double %t23 to i64
  %t25 = call i8* @sailfin_runtime_substring(i8* %t21, i64 0, i64 %t24)
  %t26 = call i8* @trim_text(i8* %t25)
  store i8* %t26, i8** %l3
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l2
  %t29 = load i8*, i8** %l1
  %t30 = call i64 @sailfin_runtime_string_length(i8* %t29)
  %t31 = sitofp i64 %t30 to double
  %t32 = fadd double %t28, %t31
  %t33 = load i8*, i8** %l0
  %t34 = call i64 @sailfin_runtime_string_length(i8* %t33)
  %t35 = call double @llvm.round.f64(double %t32)
  %t36 = fptosi double %t35 to i64
  %t37 = call i8* @sailfin_runtime_substring(i8* %t27, i64 %t36, i64 %t34)
  %t38 = call i8* @trim_text(i8* %t37)
  store i8* %t38, i8** %l4
  %t39 = load i8*, i8** %l4
  %t40 = call i64 @sailfin_runtime_string_length(i8* %t39)
  %t41 = icmp eq i64 %t40, 0
  %t42 = load i8*, i8** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l2
  %t45 = load i8*, i8** %l3
  %t46 = load i8*, i8** %l4
  br i1 %t41, label %then4, label %merge5
then4:
  %t47 = load i8*, i8** %l3
  %t48 = insertvalue %NativeImportSpecifier undef, i8* %t47, 0
  %t49 = insertvalue %NativeImportSpecifier %t48, i8* null, 1
  ret %NativeImportSpecifier %t49
merge5:
  %t50 = load i8*, i8** %l3
  %t51 = insertvalue %NativeImportSpecifier undef, i8* %t50, 0
  %t52 = load i8*, i8** %l4
  %t53 = insertvalue %NativeImportSpecifier %t51, i8* %t52, 1
  ret %NativeImportSpecifier %t53
}

define %StructParseResult @parse_struct_definition({ i8**, i64 }* %lines, double %start_index) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca %StructHeaderParse
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { %NativeStructField*, i64 }*
  %l7 = alloca { %NativeFunction*, i64 }*
  %l8 = alloca %NativeFunction*
  %l9 = alloca %NativeSourceSpan*
  %l10 = alloca %NativeSourceSpan*
  %l11 = alloca { %NativeStructLayoutField*, i64 }*
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i1
  %l15 = alloca i1
  %l16 = alloca double
  %l17 = alloca %NativeStructLayout*
  %l18 = alloca i8*
  %l19 = alloca %NativeParameter*
  %l20 = alloca %NativeSourceSpan*
  %l21 = alloca %NativeSourceSpan*
  %l22 = alloca %InstructionParseResult
  %l23 = alloca double
  %l24 = alloca i8*
  %l25 = alloca %StructLayoutHeaderParse
  %l26 = alloca %StructLayoutFieldParse
  %l27 = alloca %NativeStructField*
  %l28 = alloca i8*
  %l29 = alloca %NativeStructLayout*
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
  %t12 = call double @llvm.round.f64(double %start_index)
  %t13 = fptosi double %t12 to i64
  %t14 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t15 = extractvalue { i8**, i64 } %t14, 0
  %t16 = extractvalue { i8**, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t13, i64 %t16)
  %t18 = getelementptr i8*, i8** %t15, i64 %t13
  %t19 = load i8*, i8** %t18
  %t20 = call i8* @trim_text(i8* %t19)
  store i8* %t20, i8** %l1
  %t21 = load i8*, i8** %l1
  %s22 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2093451461, i32 0, i32 0
  %t23 = call i8* @strip_prefix(i8* %t21, i8* %s22)
  %t24 = call i8* @trim_text(i8* %t23)
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l2
  %t26 = call %StructHeaderParse @parse_struct_header(i8* %t25)
  store %StructHeaderParse %t26, %StructHeaderParse* %l3
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t29 = extractvalue %StructHeaderParse %t28, 2
  %t30 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t27, { i8**, i64 }* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  %t31 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t32 = extractvalue %StructHeaderParse %t31, 0
  store i8* %t32, i8** %l4
  %t33 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t34 = extractvalue %StructHeaderParse %t33, 1
  store { i8**, i64 }* %t34, { i8**, i64 }** %l5
  %t35 = load i8*, i8** %l4
  %t36 = call i64 @sailfin_runtime_string_length(i8* %t35)
  %t37 = icmp eq i64 %t36, 0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load i8*, i8** %l1
  %t40 = load i8*, i8** %l2
  %t41 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t42 = load i8*, i8** %l4
  %t43 = load { i8**, i64 }*, { i8**, i64 }** %l5
  br i1 %t37, label %then0, label %merge1
then0:
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s45 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1478667446, i32 0, i32 0
  %t46 = load i8*, i8** %l1
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %s45, i8* %t46)
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t44, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  %t49 = bitcast i8* null to %NativeStruct*
  %t50 = insertvalue %StructParseResult undef, %NativeStruct* %t49, 0
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %start_index, %t51
  %t53 = insertvalue %StructParseResult %t50, double %t52, 1
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = insertvalue %StructParseResult %t53, { i8**, i64 }* %t54, 2
  ret %StructParseResult %t55
merge1:
  %t56 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* null, i32 1
  %t57 = ptrtoint [0 x %NativeStructField]* %t56 to i64
  %t58 = icmp eq i64 %t57, 0
  %t59 = select i1 %t58, i64 1, i64 %t57
  %t60 = call i8* @malloc(i64 %t59)
  %t61 = bitcast i8* %t60 to %NativeStructField*
  %t62 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* null, i32 1
  %t63 = ptrtoint { %NativeStructField*, i64 }* %t62 to i64
  %t64 = call i8* @malloc(i64 %t63)
  %t65 = bitcast i8* %t64 to { %NativeStructField*, i64 }*
  %t66 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t65, i32 0, i32 0
  store %NativeStructField* %t61, %NativeStructField** %t66
  %t67 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t65, i32 0, i32 1
  store i64 0, i64* %t67
  store { %NativeStructField*, i64 }* %t65, { %NativeStructField*, i64 }** %l6
  %t68 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* null, i32 1
  %t69 = ptrtoint [0 x %NativeFunction]* %t68 to i64
  %t70 = icmp eq i64 %t69, 0
  %t71 = select i1 %t70, i64 1, i64 %t69
  %t72 = call i8* @malloc(i64 %t71)
  %t73 = bitcast i8* %t72 to %NativeFunction*
  %t74 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* null, i32 1
  %t75 = ptrtoint { %NativeFunction*, i64 }* %t74 to i64
  %t76 = call i8* @malloc(i64 %t75)
  %t77 = bitcast i8* %t76 to { %NativeFunction*, i64 }*
  %t78 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t77, i32 0, i32 0
  store %NativeFunction* %t73, %NativeFunction** %t78
  %t79 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t77, i32 0, i32 1
  store i64 0, i64* %t79
  store { %NativeFunction*, i64 }* %t77, { %NativeFunction*, i64 }** %l7
  %t80 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t80, %NativeFunction** %l8
  %t81 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t81, %NativeSourceSpan** %l9
  %t82 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t82, %NativeSourceSpan** %l10
  %t83 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t84 = ptrtoint [0 x %NativeStructLayoutField]* %t83 to i64
  %t85 = icmp eq i64 %t84, 0
  %t86 = select i1 %t85, i64 1, i64 %t84
  %t87 = call i8* @malloc(i64 %t86)
  %t88 = bitcast i8* %t87 to %NativeStructLayoutField*
  %t89 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t90 = ptrtoint { %NativeStructLayoutField*, i64 }* %t89 to i64
  %t91 = call i8* @malloc(i64 %t90)
  %t92 = bitcast i8* %t91 to { %NativeStructLayoutField*, i64 }*
  %t93 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t92, i32 0, i32 0
  store %NativeStructLayoutField* %t88, %NativeStructLayoutField** %t93
  %t94 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t92, i32 0, i32 1
  store i64 0, i64* %t94
  store { %NativeStructLayoutField*, i64 }* %t92, { %NativeStructLayoutField*, i64 }** %l11
  %t95 = sitofp i64 0 to double
  store double %t95, double* %l12
  %t96 = sitofp i64 0 to double
  store double %t96, double* %l13
  store i1 0, i1* %l14
  store i1 0, i1* %l15
  %t97 = sitofp i64 1 to double
  %t98 = fadd double %start_index, %t97
  store double %t98, double* %l16
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load i8*, i8** %l1
  %t101 = load i8*, i8** %l2
  %t102 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t103 = load i8*, i8** %l4
  %t104 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t105 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t106 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t107 = load %NativeFunction*, %NativeFunction** %l8
  %t108 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t109 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t110 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t111 = load double, double* %l12
  %t112 = load double, double* %l13
  %t113 = load i1, i1* %l14
  %t114 = load i1, i1* %l15
  %t115 = load double, double* %l16
  br label %loop.header2
loop.header2:
  %t1255 = phi { i8**, i64 }* [ %t99, %merge1 ], [ %t1243, %loop.latch4 ]
  %t1256 = phi double [ %t115, %merge1 ], [ %t1244, %loop.latch4 ]
  %t1257 = phi { %NativeFunction*, i64 }* [ %t106, %merge1 ], [ %t1245, %loop.latch4 ]
  %t1258 = phi %NativeFunction* [ %t107, %merge1 ], [ %t1246, %loop.latch4 ]
  %t1259 = phi %NativeSourceSpan* [ %t108, %merge1 ], [ %t1247, %loop.latch4 ]
  %t1260 = phi %NativeSourceSpan* [ %t109, %merge1 ], [ %t1248, %loop.latch4 ]
  %t1261 = phi double [ %t111, %merge1 ], [ %t1249, %loop.latch4 ]
  %t1262 = phi double [ %t112, %merge1 ], [ %t1250, %loop.latch4 ]
  %t1263 = phi i1 [ %t113, %merge1 ], [ %t1251, %loop.latch4 ]
  %t1264 = phi { %NativeStructLayoutField*, i64 }* [ %t110, %merge1 ], [ %t1252, %loop.latch4 ]
  %t1265 = phi i1 [ %t114, %merge1 ], [ %t1253, %loop.latch4 ]
  %t1266 = phi { %NativeStructField*, i64 }* [ %t105, %merge1 ], [ %t1254, %loop.latch4 ]
  store { i8**, i64 }* %t1255, { i8**, i64 }** %l0
  store double %t1256, double* %l16
  store { %NativeFunction*, i64 }* %t1257, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t1258, %NativeFunction** %l8
  store %NativeSourceSpan* %t1259, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1260, %NativeSourceSpan** %l10
  store double %t1261, double* %l12
  store double %t1262, double* %l13
  store i1 %t1263, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t1264, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t1265, i1* %l15
  store { %NativeStructField*, i64 }* %t1266, { %NativeStructField*, i64 }** %l6
  br label %loop.body3
loop.body3:
  %t116 = load double, double* %l16
  %t117 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t118 = extractvalue { i8**, i64 } %t117, 1
  %t119 = sitofp i64 %t118 to double
  %t120 = fcmp oge double %t116, %t119
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t122 = load i8*, i8** %l1
  %t123 = load i8*, i8** %l2
  %t124 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t125 = load i8*, i8** %l4
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t127 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t128 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t129 = load %NativeFunction*, %NativeFunction** %l8
  %t130 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t131 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t132 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t133 = load double, double* %l12
  %t134 = load double, double* %l13
  %t135 = load i1, i1* %l14
  %t136 = load i1, i1* %l15
  %t137 = load double, double* %l16
  br i1 %t120, label %then6, label %merge7
then6:
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s139 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1216366549, i32 0, i32 0
  %t140 = load i8*, i8** %l4
  %t141 = call i8* @sailfin_runtime_string_concat(i8* %s139, i8* %t140)
  %t142 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t138, i8* %t141)
  store { i8**, i64 }* %t142, { i8**, i64 }** %l0
  %t143 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t143, %NativeStructLayout** %l17
  %t144 = load i1, i1* %l14
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t146 = load i8*, i8** %l1
  %t147 = load i8*, i8** %l2
  %t148 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t149 = load i8*, i8** %l4
  %t150 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t151 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t152 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t153 = load %NativeFunction*, %NativeFunction** %l8
  %t154 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t155 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t156 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t157 = load double, double* %l12
  %t158 = load double, double* %l13
  %t159 = load i1, i1* %l14
  %t160 = load i1, i1* %l15
  %t161 = load double, double* %l16
  %t162 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br i1 %t144, label %then8, label %merge9
then8:
  %t163 = load double, double* %l12
  %t164 = insertvalue %NativeStructLayout undef, double %t163, 0
  %t165 = load double, double* %l13
  %t166 = insertvalue %NativeStructLayout %t164, double %t165, 1
  %t167 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t168 = bitcast { %NativeStructLayoutField*, i64 }* %t167 to { %NativeStructLayoutField**, i64 }*
  %t169 = insertvalue %NativeStructLayout %t166, { %NativeStructLayoutField**, i64 }* %t168, 2
  %t170 = alloca %NativeStructLayout
  store %NativeStructLayout %t169, %NativeStructLayout* %t170
  store %NativeStructLayout* %t170, %NativeStructLayout** %l17
  %t171 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br label %merge9
merge9:
  %t172 = phi %NativeStructLayout* [ %t171, %then8 ], [ %t162, %then6 ]
  store %NativeStructLayout* %t172, %NativeStructLayout** %l17
  %t173 = load i8*, i8** %l4
  %t174 = insertvalue %NativeStruct undef, i8* %t173, 0
  %t175 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t176 = bitcast { %NativeStructField*, i64 }* %t175 to { %NativeStructField**, i64 }*
  %t177 = insertvalue %NativeStruct %t174, { %NativeStructField**, i64 }* %t176, 1
  %t178 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t179 = bitcast { %NativeFunction*, i64 }* %t178 to { %NativeFunction**, i64 }*
  %t180 = insertvalue %NativeStruct %t177, { %NativeFunction**, i64 }* %t179, 2
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t182 = insertvalue %NativeStruct %t180, { i8**, i64 }* %t181, 3
  %t183 = load %NativeStructLayout*, %NativeStructLayout** %l17
  %t184 = insertvalue %NativeStruct %t182, %NativeStructLayout* %t183, 4
  %t185 = alloca %NativeStruct
  store %NativeStruct %t184, %NativeStruct* %t185
  %t186 = insertvalue %StructParseResult undef, %NativeStruct* %t185, 0
  %t187 = load double, double* %l16
  %t188 = insertvalue %StructParseResult %t186, double %t187, 1
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = insertvalue %StructParseResult %t188, { i8**, i64 }* %t189, 2
  ret %StructParseResult %t190
merge7:
  %t191 = load double, double* %l16
  %t192 = call double @llvm.round.f64(double %t191)
  %t193 = fptosi double %t192 to i64
  %t194 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t195 = extractvalue { i8**, i64 } %t194, 0
  %t196 = extractvalue { i8**, i64 } %t194, 1
  %t197 = icmp uge i64 %t193, %t196
  ; bounds check: %t197 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t193, i64 %t196)
  %t198 = getelementptr i8*, i8** %t195, i64 %t193
  %t199 = load i8*, i8** %t198
  %t200 = call i8* @trim_text(i8* %t199)
  store i8* %t200, i8** %l18
  %t202 = load i8*, i8** %l18
  %t203 = call i64 @sailfin_runtime_string_length(i8* %t202)
  %t204 = icmp eq i64 %t203, 0
  br label %logical_or_entry_201

logical_or_entry_201:
  br i1 %t204, label %logical_or_merge_201, label %logical_or_right_201

logical_or_right_201:
  %t205 = load i8*, i8** %l18
  %t206 = alloca [2 x i8], align 1
  %t207 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 0
  store i8 59, i8* %t207
  %t208 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 1
  store i8 0, i8* %t208
  %t209 = getelementptr [2 x i8], [2 x i8]* %t206, i32 0, i32 0
  %t210 = call i1 @starts_with(i8* %t205, i8* %t209)
  br label %logical_or_right_end_201

logical_or_right_end_201:
  br label %logical_or_merge_201

logical_or_merge_201:
  %t211 = phi i1 [ true, %logical_or_entry_201 ], [ %t210, %logical_or_right_end_201 ]
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t213 = load i8*, i8** %l1
  %t214 = load i8*, i8** %l2
  %t215 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t216 = load i8*, i8** %l4
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t218 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t219 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t220 = load %NativeFunction*, %NativeFunction** %l8
  %t221 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t222 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t223 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t224 = load double, double* %l12
  %t225 = load double, double* %l13
  %t226 = load i1, i1* %l14
  %t227 = load i1, i1* %l15
  %t228 = load double, double* %l16
  %t229 = load i8*, i8** %l18
  br i1 %t211, label %then10, label %merge11
then10:
  %t230 = load double, double* %l16
  %t231 = sitofp i64 1 to double
  %t232 = fadd double %t230, %t231
  store double %t232, double* %l16
  br label %loop.latch4
merge11:
  %t233 = load i8*, i8** %l18
  %s234 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h2070880298, i32 0, i32 0
  %t235 = call i1 @strings_equal(i8* %t233, i8* %s234)
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t237 = load i8*, i8** %l1
  %t238 = load i8*, i8** %l2
  %t239 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t240 = load i8*, i8** %l4
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t242 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t243 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t244 = load %NativeFunction*, %NativeFunction** %l8
  %t245 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t246 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t247 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t248 = load double, double* %l12
  %t249 = load double, double* %l13
  %t250 = load i1, i1* %l14
  %t251 = load i1, i1* %l15
  %t252 = load double, double* %l16
  %t253 = load i8*, i8** %l18
  br i1 %t235, label %then12, label %merge13
then12:
  %t254 = load %NativeFunction*, %NativeFunction** %l8
  %t255 = icmp ne %NativeFunction* %t254, null
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t257 = load i8*, i8** %l1
  %t258 = load i8*, i8** %l2
  %t259 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t260 = load i8*, i8** %l4
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t262 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t263 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t264 = load %NativeFunction*, %NativeFunction** %l8
  %t265 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t266 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t267 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t268 = load double, double* %l12
  %t269 = load double, double* %l13
  %t270 = load i1, i1* %l14
  %t271 = load i1, i1* %l15
  %t272 = load double, double* %l16
  %t273 = load i8*, i8** %l18
  br i1 %t255, label %then14, label %merge15
then14:
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s275 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h208276320, i32 0, i32 0
  %t276 = load i8*, i8** %l4
  %t277 = call i8* @sailfin_runtime_string_concat(i8* %s275, i8* %t276)
  %t278 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t274, i8* %t277)
  store { i8**, i64 }* %t278, { i8**, i64 }** %l0
  %t279 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t280 = load %NativeFunction*, %NativeFunction** %l8
  %t281 = load %NativeFunction, %NativeFunction* %t280
  %t282 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t279, %NativeFunction %t281)
  store { %NativeFunction*, i64 }* %t282, { %NativeFunction*, i64 }** %l7
  %t283 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t283, %NativeFunction** %l8
  %t284 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t284, %NativeSourceSpan** %l9
  %t285 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t285, %NativeSourceSpan** %l10
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t287 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t288 = load %NativeFunction*, %NativeFunction** %l8
  %t289 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t290 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge15
merge15:
  %t291 = phi { i8**, i64 }* [ %t286, %then14 ], [ %t256, %then12 ]
  %t292 = phi { %NativeFunction*, i64 }* [ %t287, %then14 ], [ %t263, %then12 ]
  %t293 = phi %NativeFunction* [ %t288, %then14 ], [ %t264, %then12 ]
  %t294 = phi %NativeSourceSpan* [ %t289, %then14 ], [ %t265, %then12 ]
  %t295 = phi %NativeSourceSpan* [ %t290, %then14 ], [ %t266, %then12 ]
  store { i8**, i64 }* %t291, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t292, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t293, %NativeFunction** %l8
  store %NativeSourceSpan* %t294, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t295, %NativeSourceSpan** %l10
  %t296 = load double, double* %l16
  %t297 = sitofp i64 1 to double
  %t298 = fadd double %t296, %t297
  store double %t298, double* %l16
  br label %afterloop5
merge13:
  %t299 = load %NativeFunction*, %NativeFunction** %l8
  %t300 = icmp ne %NativeFunction* %t299, null
  %t301 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t302 = load i8*, i8** %l1
  %t303 = load i8*, i8** %l2
  %t304 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t305 = load i8*, i8** %l4
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t307 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t308 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t309 = load %NativeFunction*, %NativeFunction** %l8
  %t310 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t311 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t312 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t313 = load double, double* %l12
  %t314 = load double, double* %l13
  %t315 = load i1, i1* %l14
  %t316 = load i1, i1* %l15
  %t317 = load double, double* %l16
  %t318 = load i8*, i8** %l18
  br i1 %t300, label %then16, label %merge17
then16:
  %t319 = load i8*, i8** %l18
  %s320 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h179409731, i32 0, i32 0
  %t321 = call i1 @strings_equal(i8* %t319, i8* %s320)
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t323 = load i8*, i8** %l1
  %t324 = load i8*, i8** %l2
  %t325 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t326 = load i8*, i8** %l4
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t328 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t329 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t330 = load %NativeFunction*, %NativeFunction** %l8
  %t331 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t332 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t333 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t334 = load double, double* %l12
  %t335 = load double, double* %l13
  %t336 = load i1, i1* %l14
  %t337 = load i1, i1* %l15
  %t338 = load double, double* %l16
  %t339 = load i8*, i8** %l18
  br i1 %t321, label %then18, label %merge19
then18:
  %t340 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t341 = load %NativeFunction*, %NativeFunction** %l8
  %t342 = load %NativeFunction, %NativeFunction* %t341
  %t343 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t340, %NativeFunction %t342)
  store { %NativeFunction*, i64 }* %t343, { %NativeFunction*, i64 }** %l7
  %t344 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t344, %NativeFunction** %l8
  %t345 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t345, %NativeSourceSpan** %l9
  %t346 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t346, %NativeSourceSpan** %l10
  %t347 = load double, double* %l16
  %t348 = sitofp i64 1 to double
  %t349 = fadd double %t347, %t348
  store double %t349, double* %l16
  br label %loop.latch4
merge19:
  %t350 = load i8*, i8** %l18
  %s351 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t352 = call i1 @starts_with(i8* %t350, i8* %s351)
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t354 = load i8*, i8** %l1
  %t355 = load i8*, i8** %l2
  %t356 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t357 = load i8*, i8** %l4
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t359 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t360 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t361 = load %NativeFunction*, %NativeFunction** %l8
  %t362 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t363 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t364 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t365 = load double, double* %l12
  %t366 = load double, double* %l13
  %t367 = load i1, i1* %l14
  %t368 = load i1, i1* %l15
  %t369 = load double, double* %l16
  %t370 = load i8*, i8** %l18
  br i1 %t352, label %then20, label %merge21
then20:
  %t371 = load %NativeFunction*, %NativeFunction** %l8
  %t372 = load i8*, i8** %l18
  %s373 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t374 = call i8* @strip_prefix(i8* %t372, i8* %s373)
  %t375 = load %NativeFunction, %NativeFunction* %t371
  %t376 = call %NativeFunction @apply_meta(%NativeFunction %t375, i8* %t374)
  %t377 = alloca %NativeFunction
  store %NativeFunction %t376, %NativeFunction* %t377
  store %NativeFunction* %t377, %NativeFunction** %l8
  %t378 = load double, double* %l16
  %t379 = sitofp i64 1 to double
  %t380 = fadd double %t378, %t379
  store double %t380, double* %l16
  br label %loop.latch4
merge21:
  %t381 = load i8*, i8** %l18
  %s382 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t383 = call i1 @starts_with(i8* %t381, i8* %s382)
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t385 = load i8*, i8** %l1
  %t386 = load i8*, i8** %l2
  %t387 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t388 = load i8*, i8** %l4
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t390 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t391 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t392 = load %NativeFunction*, %NativeFunction** %l8
  %t393 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t394 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t395 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t396 = load double, double* %l12
  %t397 = load double, double* %l13
  %t398 = load i1, i1* %l14
  %t399 = load i1, i1* %l15
  %t400 = load double, double* %l16
  %t401 = load i8*, i8** %l18
  br i1 %t383, label %then22, label %merge23
then22:
  %t402 = load i8*, i8** %l18
  %s403 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t404 = call i8* @strip_prefix(i8* %t402, i8* %s403)
  %t405 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t406 = call %NativeParameter* @parse_parameter_entry(i8* %t404, %NativeSourceSpan* %t405)
  store %NativeParameter* %t406, %NativeParameter** %l19
  %t407 = load %NativeParameter*, %NativeParameter** %l19
  %t408 = icmp eq %NativeParameter* %t407, null
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t410 = load i8*, i8** %l1
  %t411 = load i8*, i8** %l2
  %t412 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t413 = load i8*, i8** %l4
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t415 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t416 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t417 = load %NativeFunction*, %NativeFunction** %l8
  %t418 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t419 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t420 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t421 = load double, double* %l12
  %t422 = load double, double* %l13
  %t423 = load i1, i1* %l14
  %t424 = load i1, i1* %l15
  %t425 = load double, double* %l16
  %t426 = load i8*, i8** %l18
  %t427 = load %NativeParameter*, %NativeParameter** %l19
  br i1 %t408, label %then24, label %else25
then24:
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s429 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h1211676914, i32 0, i32 0
  %t430 = load i8*, i8** %l18
  %t431 = call i8* @sailfin_runtime_string_concat(i8* %s429, i8* %t430)
  %t432 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t428, i8* %t431)
  store { i8**, i64 }* %t432, { i8**, i64 }** %l0
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge26
else25:
  %t434 = load %NativeFunction*, %NativeFunction** %l8
  %t435 = load %NativeParameter*, %NativeParameter** %l19
  %t436 = load %NativeFunction, %NativeFunction* %t434
  %t437 = load %NativeParameter, %NativeParameter* %t435
  %t438 = call %NativeFunction @append_parameter(%NativeFunction %t436, %NativeParameter %t437)
  %t439 = alloca %NativeFunction
  store %NativeFunction %t438, %NativeFunction* %t439
  store %NativeFunction* %t439, %NativeFunction** %l8
  %t440 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge26
merge26:
  %t441 = phi { i8**, i64 }* [ %t433, %then24 ], [ %t409, %else25 ]
  %t442 = phi %NativeFunction* [ %t417, %then24 ], [ %t440, %else25 ]
  store { i8**, i64 }* %t441, { i8**, i64 }** %l0
  store %NativeFunction* %t442, %NativeFunction** %l8
  %t443 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t443, %NativeSourceSpan** %l9
  %t444 = load double, double* %l16
  %t445 = sitofp i64 1 to double
  %t446 = fadd double %t444, %t445
  store double %t446, double* %l16
  br label %loop.latch4
merge23:
  %t447 = load i8*, i8** %l18
  %s448 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t449 = call i1 @starts_with(i8* %t447, i8* %s448)
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t451 = load i8*, i8** %l1
  %t452 = load i8*, i8** %l2
  %t453 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t454 = load i8*, i8** %l4
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t456 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t457 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t458 = load %NativeFunction*, %NativeFunction** %l8
  %t459 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t460 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t461 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t462 = load double, double* %l12
  %t463 = load double, double* %l13
  %t464 = load i1, i1* %l14
  %t465 = load i1, i1* %l15
  %t466 = load double, double* %l16
  %t467 = load i8*, i8** %l18
  br i1 %t449, label %then27, label %merge28
then27:
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s469 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t470 = load i8*, i8** %l4
  %t471 = call i8* @sailfin_runtime_string_concat(i8* %s469, i8* %t470)
  %t472 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t468, i8* %t471)
  store { i8**, i64 }* %t472, { i8**, i64 }** %l0
  %t473 = load double, double* %l16
  %t474 = sitofp i64 1 to double
  %t475 = fadd double %t473, %t474
  store double %t475, double* %l16
  br label %loop.latch4
merge28:
  %t476 = load i8*, i8** %l18
  %s477 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t478 = call i1 @starts_with(i8* %t476, i8* %s477)
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t480 = load i8*, i8** %l1
  %t481 = load i8*, i8** %l2
  %t482 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t483 = load i8*, i8** %l4
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t485 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t486 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t487 = load %NativeFunction*, %NativeFunction** %l8
  %t488 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t489 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t490 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t491 = load double, double* %l12
  %t492 = load double, double* %l13
  %t493 = load i1, i1* %l14
  %t494 = load i1, i1* %l15
  %t495 = load double, double* %l16
  %t496 = load i8*, i8** %l18
  br i1 %t478, label %then29, label %merge30
then29:
  %t497 = load i8*, i8** %l18
  %s498 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t499 = call i8* @strip_prefix(i8* %t497, i8* %s498)
  %t500 = call %NativeSourceSpan* @parse_source_span(i8* %t499)
  store %NativeSourceSpan* %t500, %NativeSourceSpan** %l20
  %t501 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  %t502 = icmp eq %NativeSourceSpan* %t501, null
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t504 = load i8*, i8** %l1
  %t505 = load i8*, i8** %l2
  %t506 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t507 = load i8*, i8** %l4
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t509 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t510 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t511 = load %NativeFunction*, %NativeFunction** %l8
  %t512 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t513 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t514 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t515 = load double, double* %l12
  %t516 = load double, double* %l13
  %t517 = load i1, i1* %l14
  %t518 = load i1, i1* %l15
  %t519 = load double, double* %l16
  %t520 = load i8*, i8** %l18
  %t521 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  br i1 %t502, label %then31, label %else32
then31:
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s523 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h762677253, i32 0, i32 0
  %t524 = load i8*, i8** %l18
  %t525 = call i8* @sailfin_runtime_string_concat(i8* %s523, i8* %t524)
  %t526 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t522, i8* %t525)
  store { i8**, i64 }* %t526, { i8**, i64 }** %l0
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge33
else32:
  %t528 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  store %NativeSourceSpan* %t528, %NativeSourceSpan** %l9
  %t529 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge33
merge33:
  %t530 = phi { i8**, i64 }* [ %t527, %then31 ], [ %t503, %else32 ]
  %t531 = phi %NativeSourceSpan* [ %t512, %then31 ], [ %t529, %else32 ]
  store { i8**, i64 }* %t530, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t531, %NativeSourceSpan** %l9
  %t532 = load double, double* %l16
  %t533 = sitofp i64 1 to double
  %t534 = fadd double %t532, %t533
  store double %t534, double* %l16
  br label %loop.latch4
merge30:
  %t535 = load i8*, i8** %l18
  %s536 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t537 = call i1 @starts_with(i8* %t535, i8* %s536)
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t539 = load i8*, i8** %l1
  %t540 = load i8*, i8** %l2
  %t541 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t542 = load i8*, i8** %l4
  %t543 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t544 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t545 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t546 = load %NativeFunction*, %NativeFunction** %l8
  %t547 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t548 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t549 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t550 = load double, double* %l12
  %t551 = load double, double* %l13
  %t552 = load i1, i1* %l14
  %t553 = load i1, i1* %l15
  %t554 = load double, double* %l16
  %t555 = load i8*, i8** %l18
  br i1 %t537, label %then34, label %merge35
then34:
  %t556 = load i8*, i8** %l18
  %s557 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t558 = call i8* @strip_prefix(i8* %t556, i8* %s557)
  %t559 = call %NativeSourceSpan* @parse_source_span(i8* %t558)
  store %NativeSourceSpan* %t559, %NativeSourceSpan** %l21
  %t560 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  %t561 = icmp eq %NativeSourceSpan* %t560, null
  %t562 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t563 = load i8*, i8** %l1
  %t564 = load i8*, i8** %l2
  %t565 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t566 = load i8*, i8** %l4
  %t567 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t568 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t569 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t570 = load %NativeFunction*, %NativeFunction** %l8
  %t571 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t572 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t573 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t574 = load double, double* %l12
  %t575 = load double, double* %l13
  %t576 = load i1, i1* %l14
  %t577 = load i1, i1* %l15
  %t578 = load double, double* %l16
  %t579 = load i8*, i8** %l18
  %t580 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  br i1 %t561, label %then36, label %else37
then36:
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s582 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.len43.h1714227133, i32 0, i32 0
  %t583 = load i8*, i8** %l18
  %t584 = call i8* @sailfin_runtime_string_concat(i8* %s582, i8* %t583)
  %t585 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t581, i8* %t584)
  store { i8**, i64 }* %t585, { i8**, i64 }** %l0
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t587 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  store %NativeSourceSpan* %t587, %NativeSourceSpan** %l10
  %t588 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge38
merge38:
  %t589 = phi { i8**, i64 }* [ %t586, %then36 ], [ %t562, %else37 ]
  %t590 = phi %NativeSourceSpan* [ %t572, %then36 ], [ %t588, %else37 ]
  store { i8**, i64 }* %t589, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t590, %NativeSourceSpan** %l10
  %t591 = load double, double* %l16
  %t592 = sitofp i64 1 to double
  %t593 = fadd double %t591, %t592
  store double %t593, double* %l16
  br label %loop.latch4
merge35:
  %t594 = load i8*, i8** %l18
  %t595 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t596 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t597 = call %InstructionParseResult @parse_instruction(i8* %t594, %NativeSourceSpan* %t595, %NativeSourceSpan* %t596)
  store %InstructionParseResult %t597, %InstructionParseResult* %l22
  %t598 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t599 = extractvalue %InstructionParseResult %t598, 1
  %t600 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t601 = load i8*, i8** %l1
  %t602 = load i8*, i8** %l2
  %t603 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t604 = load i8*, i8** %l4
  %t605 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t606 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t607 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t608 = load %NativeFunction*, %NativeFunction** %l8
  %t609 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t610 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t611 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t612 = load double, double* %l12
  %t613 = load double, double* %l13
  %t614 = load i1, i1* %l14
  %t615 = load i1, i1* %l15
  %t616 = load double, double* %l16
  %t617 = load i8*, i8** %l18
  %t618 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t599, label %then39, label %else40
then39:
  %t619 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t619, %NativeSourceSpan** %l9
  %t620 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
else40:
  %t621 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t622 = icmp ne %NativeSourceSpan* %t621, null
  %t623 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t624 = load i8*, i8** %l1
  %t625 = load i8*, i8** %l2
  %t626 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t627 = load i8*, i8** %l4
  %t628 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t629 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t630 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t631 = load %NativeFunction*, %NativeFunction** %l8
  %t632 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t633 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t634 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t635 = load double, double* %l12
  %t636 = load double, double* %l13
  %t637 = load i1, i1* %l14
  %t638 = load i1, i1* %l15
  %t639 = load double, double* %l16
  %t640 = load i8*, i8** %l18
  %t641 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t622, label %then42, label %merge43
then42:
  %t642 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s643 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t644 = load i8*, i8** %l18
  %t645 = call i8* @sailfin_runtime_string_concat(i8* %s643, i8* %t644)
  %t646 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t642, i8* %t645)
  store { i8**, i64 }* %t646, { i8**, i64 }** %l0
  %t647 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t647, %NativeSourceSpan** %l9
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t649 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge43
merge43:
  %t650 = phi { i8**, i64 }* [ %t648, %then42 ], [ %t623, %else40 ]
  %t651 = phi %NativeSourceSpan* [ %t649, %then42 ], [ %t632, %else40 ]
  store { i8**, i64 }* %t650, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t651, %NativeSourceSpan** %l9
  %t652 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t653 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
merge41:
  %t654 = phi %NativeSourceSpan* [ %t620, %then39 ], [ %t653, %merge43 ]
  %t655 = phi { i8**, i64 }* [ %t600, %then39 ], [ %t652, %merge43 ]
  store %NativeSourceSpan* %t654, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t655, { i8**, i64 }** %l0
  %t656 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t657 = extractvalue %InstructionParseResult %t656, 2
  %t658 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t659 = load i8*, i8** %l1
  %t660 = load i8*, i8** %l2
  %t661 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t662 = load i8*, i8** %l4
  %t663 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t664 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t665 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t666 = load %NativeFunction*, %NativeFunction** %l8
  %t667 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t668 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t669 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t670 = load double, double* %l12
  %t671 = load double, double* %l13
  %t672 = load i1, i1* %l14
  %t673 = load i1, i1* %l15
  %t674 = load double, double* %l16
  %t675 = load i8*, i8** %l18
  %t676 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t657, label %then44, label %else45
then44:
  %t677 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t677, %NativeSourceSpan** %l10
  %t678 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
else45:
  %t679 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t680 = icmp ne %NativeSourceSpan* %t679, null
  %t681 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t682 = load i8*, i8** %l1
  %t683 = load i8*, i8** %l2
  %t684 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t685 = load i8*, i8** %l4
  %t686 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t687 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t688 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t689 = load %NativeFunction*, %NativeFunction** %l8
  %t690 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t691 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t692 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t693 = load double, double* %l12
  %t694 = load double, double* %l13
  %t695 = load i1, i1* %l14
  %t696 = load i1, i1* %l15
  %t697 = load double, double* %l16
  %t698 = load i8*, i8** %l18
  %t699 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t680, label %then47, label %merge48
then47:
  %t700 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s701 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t702 = load i8*, i8** %l18
  %t703 = call i8* @sailfin_runtime_string_concat(i8* %s701, i8* %t702)
  %t704 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t700, i8* %t703)
  store { i8**, i64 }* %t704, { i8**, i64 }** %l0
  %t705 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t705, %NativeSourceSpan** %l10
  %t706 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t707 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge48
merge48:
  %t708 = phi { i8**, i64 }* [ %t706, %then47 ], [ %t681, %else45 ]
  %t709 = phi %NativeSourceSpan* [ %t707, %then47 ], [ %t691, %else45 ]
  store { i8**, i64 }* %t708, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t709, %NativeSourceSpan** %l10
  %t710 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t711 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
merge46:
  %t712 = phi %NativeSourceSpan* [ %t678, %then44 ], [ %t711, %merge48 ]
  %t713 = phi { i8**, i64 }* [ %t658, %then44 ], [ %t710, %merge48 ]
  store %NativeSourceSpan* %t712, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t713, { i8**, i64 }** %l0
  %t714 = sitofp i64 0 to double
  store double %t714, double* %l23
  %t715 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t716 = load i8*, i8** %l1
  %t717 = load i8*, i8** %l2
  %t718 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t719 = load i8*, i8** %l4
  %t720 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t721 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t722 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t723 = load %NativeFunction*, %NativeFunction** %l8
  %t724 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t725 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t726 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t727 = load double, double* %l12
  %t728 = load double, double* %l13
  %t729 = load i1, i1* %l14
  %t730 = load i1, i1* %l15
  %t731 = load double, double* %l16
  %t732 = load i8*, i8** %l18
  %t733 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t734 = load double, double* %l23
  br label %loop.header49
loop.header49:
  %t783 = phi %NativeFunction* [ %t723, %merge46 ], [ %t781, %loop.latch51 ]
  %t784 = phi double [ %t734, %merge46 ], [ %t782, %loop.latch51 ]
  store %NativeFunction* %t783, %NativeFunction** %l8
  store double %t784, double* %l23
  br label %loop.body50
loop.body50:
  %t735 = load double, double* %l23
  %t736 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t737 = extractvalue %InstructionParseResult %t736, 0
  %t738 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t737
  %t739 = extractvalue { %NativeInstruction**, i64 } %t738, 1
  %t740 = sitofp i64 %t739 to double
  %t741 = fcmp oge double %t735, %t740
  %t742 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t743 = load i8*, i8** %l1
  %t744 = load i8*, i8** %l2
  %t745 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t746 = load i8*, i8** %l4
  %t747 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t748 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t749 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t750 = load %NativeFunction*, %NativeFunction** %l8
  %t751 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t752 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t753 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t754 = load double, double* %l12
  %t755 = load double, double* %l13
  %t756 = load i1, i1* %l14
  %t757 = load i1, i1* %l15
  %t758 = load double, double* %l16
  %t759 = load i8*, i8** %l18
  %t760 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t761 = load double, double* %l23
  br i1 %t741, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t762 = load %NativeFunction*, %NativeFunction** %l8
  %t763 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t764 = extractvalue %InstructionParseResult %t763, 0
  %t765 = load double, double* %l23
  %t766 = call double @llvm.round.f64(double %t765)
  %t767 = fptosi double %t766 to i64
  %t768 = load { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t764
  %t769 = extractvalue { %NativeInstruction**, i64 } %t768, 0
  %t770 = extractvalue { %NativeInstruction**, i64 } %t768, 1
  %t771 = icmp uge i64 %t767, %t770
  ; bounds check: %t771 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t767, i64 %t770)
  %t772 = getelementptr %NativeInstruction*, %NativeInstruction** %t769, i64 %t767
  %t773 = load %NativeInstruction*, %NativeInstruction** %t772
  %t774 = load %NativeFunction, %NativeFunction* %t762
  %t775 = load %NativeInstruction, %NativeInstruction* %t773
  %t776 = call %NativeFunction @append_instruction(%NativeFunction %t774, %NativeInstruction %t775)
  %t777 = alloca %NativeFunction
  store %NativeFunction %t776, %NativeFunction* %t777
  store %NativeFunction* %t777, %NativeFunction** %l8
  %t778 = load double, double* %l23
  %t779 = sitofp i64 1 to double
  %t780 = fadd double %t778, %t779
  store double %t780, double* %l23
  br label %loop.latch51
loop.latch51:
  %t781 = load %NativeFunction*, %NativeFunction** %l8
  %t782 = load double, double* %l23
  br label %loop.header49
afterloop52:
  %t785 = load %NativeFunction*, %NativeFunction** %l8
  %t786 = load double, double* %l23
  %t787 = load double, double* %l16
  %t788 = sitofp i64 1 to double
  %t789 = fadd double %t787, %t788
  store double %t789, double* %l16
  br label %loop.latch4
merge17:
  %t790 = load i8*, i8** %l18
  %s791 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t792 = call i1 @starts_with(i8* %t790, i8* %s791)
  %t793 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t794 = load i8*, i8** %l1
  %t795 = load i8*, i8** %l2
  %t796 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t797 = load i8*, i8** %l4
  %t798 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t799 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t800 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t801 = load %NativeFunction*, %NativeFunction** %l8
  %t802 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t803 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t804 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t805 = load double, double* %l12
  %t806 = load double, double* %l13
  %t807 = load i1, i1* %l14
  %t808 = load i1, i1* %l15
  %t809 = load double, double* %l16
  %t810 = load i8*, i8** %l18
  br i1 %t792, label %then55, label %merge56
then55:
  %t811 = load i8*, i8** %l18
  %s812 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t813 = call i8* @strip_prefix(i8* %t811, i8* %s812)
  store i8* %t813, i8** %l24
  %t814 = load i8*, i8** %l24
  %s815 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t816 = call i1 @starts_with(i8* %t814, i8* %s815)
  %t817 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t818 = load i8*, i8** %l1
  %t819 = load i8*, i8** %l2
  %t820 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t821 = load i8*, i8** %l4
  %t822 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t823 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t824 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t825 = load %NativeFunction*, %NativeFunction** %l8
  %t826 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t827 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t828 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t829 = load double, double* %l12
  %t830 = load double, double* %l13
  %t831 = load i1, i1* %l14
  %t832 = load i1, i1* %l15
  %t833 = load double, double* %l16
  %t834 = load i8*, i8** %l18
  %t835 = load i8*, i8** %l24
  br i1 %t816, label %then57, label %merge58
then57:
  %t836 = load i8*, i8** %l24
  %s837 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t838 = call i8* @strip_prefix(i8* %t836, i8* %s837)
  %t839 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t838)
  store %StructLayoutHeaderParse %t839, %StructLayoutHeaderParse* %l25
  %t840 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t841 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t842 = extractvalue %StructLayoutHeaderParse %t841, 4
  %t843 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t840, { i8**, i64 }* %t842)
  store { i8**, i64 }* %t843, { i8**, i64 }** %l0
  %t844 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t845 = extractvalue %StructLayoutHeaderParse %t844, 0
  %t846 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t847 = load i8*, i8** %l1
  %t848 = load i8*, i8** %l2
  %t849 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t850 = load i8*, i8** %l4
  %t851 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t852 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t853 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t854 = load %NativeFunction*, %NativeFunction** %l8
  %t855 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t856 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t857 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t858 = load double, double* %l12
  %t859 = load double, double* %l13
  %t860 = load i1, i1* %l14
  %t861 = load i1, i1* %l15
  %t862 = load double, double* %l16
  %t863 = load i8*, i8** %l18
  %t864 = load i8*, i8** %l24
  %t865 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t845, label %then59, label %merge60
then59:
  %t866 = load i1, i1* %l14
  %t867 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t868 = load i8*, i8** %l1
  %t869 = load i8*, i8** %l2
  %t870 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t871 = load i8*, i8** %l4
  %t872 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t873 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t874 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t875 = load %NativeFunction*, %NativeFunction** %l8
  %t876 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t877 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t878 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t879 = load double, double* %l12
  %t880 = load double, double* %l13
  %t881 = load i1, i1* %l14
  %t882 = load i1, i1* %l15
  %t883 = load double, double* %l16
  %t884 = load i8*, i8** %l18
  %t885 = load i8*, i8** %l24
  %t886 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t866, label %then61, label %else62
then61:
  %t887 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s888 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h654371835, i32 0, i32 0
  %t889 = load i8*, i8** %l4
  %t890 = call i8* @sailfin_runtime_string_concat(i8* %s888, i8* %t889)
  %t891 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t887, i8* %t890)
  store { i8**, i64 }* %t891, { i8**, i64 }** %l0
  %t892 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge63
else62:
  %t893 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t894 = extractvalue %StructLayoutHeaderParse %t893, 2
  store double %t894, double* %l12
  %t895 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t896 = extractvalue %StructLayoutHeaderParse %t895, 3
  store double %t896, double* %l13
  store i1 1, i1* %l14
  %t897 = load double, double* %l12
  %t898 = load double, double* %l13
  %t899 = load i1, i1* %l14
  br label %merge63
merge63:
  %t900 = phi { i8**, i64 }* [ %t892, %then61 ], [ %t867, %else62 ]
  %t901 = phi double [ %t879, %then61 ], [ %t897, %else62 ]
  %t902 = phi double [ %t880, %then61 ], [ %t898, %else62 ]
  %t903 = phi i1 [ %t881, %then61 ], [ %t899, %else62 ]
  store { i8**, i64 }* %t900, { i8**, i64 }** %l0
  store double %t901, double* %l12
  store double %t902, double* %l13
  store i1 %t903, i1* %l14
  %t904 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t905 = load double, double* %l12
  %t906 = load double, double* %l13
  %t907 = load i1, i1* %l14
  br label %merge60
merge60:
  %t908 = phi { i8**, i64 }* [ %t904, %merge63 ], [ %t846, %then57 ]
  %t909 = phi double [ %t905, %merge63 ], [ %t858, %then57 ]
  %t910 = phi double [ %t906, %merge63 ], [ %t859, %then57 ]
  %t911 = phi i1 [ %t907, %merge63 ], [ %t860, %then57 ]
  store { i8**, i64 }* %t908, { i8**, i64 }** %l0
  store double %t909, double* %l12
  store double %t910, double* %l13
  store i1 %t911, i1* %l14
  %t912 = load double, double* %l16
  %t913 = sitofp i64 1 to double
  %t914 = fadd double %t912, %t913
  store double %t914, double* %l16
  br label %loop.latch4
merge58:
  %t915 = load i8*, i8** %l24
  %s916 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t917 = call i1 @starts_with(i8* %t915, i8* %s916)
  %t918 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t919 = load i8*, i8** %l1
  %t920 = load i8*, i8** %l2
  %t921 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t922 = load i8*, i8** %l4
  %t923 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t924 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t925 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t926 = load %NativeFunction*, %NativeFunction** %l8
  %t927 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t928 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t929 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t930 = load double, double* %l12
  %t931 = load double, double* %l13
  %t932 = load i1, i1* %l14
  %t933 = load i1, i1* %l15
  %t934 = load double, double* %l16
  %t935 = load i8*, i8** %l18
  %t936 = load i8*, i8** %l24
  br i1 %t917, label %then64, label %merge65
then64:
  %t937 = load i8*, i8** %l24
  %s938 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t939 = call i8* @strip_prefix(i8* %t937, i8* %s938)
  %t940 = load i8*, i8** %l4
  %t941 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t939, i8* %t940)
  store %StructLayoutFieldParse %t941, %StructLayoutFieldParse* %l26
  %t942 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t943 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t944 = extractvalue %StructLayoutFieldParse %t943, 2
  %t945 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t942, { i8**, i64 }* %t944)
  store { i8**, i64 }* %t945, { i8**, i64 }** %l0
  %t946 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t947 = extractvalue %StructLayoutFieldParse %t946, 0
  %t948 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t949 = load i8*, i8** %l1
  %t950 = load i8*, i8** %l2
  %t951 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t952 = load i8*, i8** %l4
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t954 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t955 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t956 = load %NativeFunction*, %NativeFunction** %l8
  %t957 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t958 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t959 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t960 = load double, double* %l12
  %t961 = load double, double* %l13
  %t962 = load i1, i1* %l14
  %t963 = load i1, i1* %l15
  %t964 = load double, double* %l16
  %t965 = load i8*, i8** %l18
  %t966 = load i8*, i8** %l24
  %t967 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t947, label %then66, label %merge67
then66:
  %t968 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t969 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t970 = extractvalue %StructLayoutFieldParse %t969, 1
  %t971 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t968, %NativeStructLayoutField %t970)
  store { %NativeStructLayoutField*, i64 }* %t971, { %NativeStructLayoutField*, i64 }** %l11
  %t972 = load i1, i1* %l14
  %t973 = xor i1 %t972, 1
  %t974 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t975 = load i8*, i8** %l1
  %t976 = load i8*, i8** %l2
  %t977 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t978 = load i8*, i8** %l4
  %t979 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t980 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t981 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t982 = load %NativeFunction*, %NativeFunction** %l8
  %t983 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t984 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t985 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t986 = load double, double* %l12
  %t987 = load double, double* %l13
  %t988 = load i1, i1* %l14
  %t989 = load i1, i1* %l15
  %t990 = load double, double* %l16
  %t991 = load i8*, i8** %l18
  %t992 = load i8*, i8** %l24
  %t993 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t973, label %then68, label %merge69
then68:
  %t994 = load i1, i1* %l15
  %t995 = xor i1 %t994, 1
  %t996 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t997 = load i8*, i8** %l1
  %t998 = load i8*, i8** %l2
  %t999 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1000 = load i8*, i8** %l4
  %t1001 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1002 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1003 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1004 = load %NativeFunction*, %NativeFunction** %l8
  %t1005 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1006 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1007 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1008 = load double, double* %l12
  %t1009 = load double, double* %l13
  %t1010 = load i1, i1* %l14
  %t1011 = load i1, i1* %l15
  %t1012 = load double, double* %l16
  %t1013 = load i8*, i8** %l18
  %t1014 = load i8*, i8** %l24
  %t1015 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t995, label %then70, label %merge71
then70:
  %t1016 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1017 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t1018 = load i8*, i8** %l4
  %t1019 = call i8* @sailfin_runtime_string_concat(i8* %s1017, i8* %t1018)
  %s1020 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.len46.h1830585629, i32 0, i32 0
  %t1021 = call i8* @sailfin_runtime_string_concat(i8* %t1019, i8* %s1020)
  %t1022 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1016, i8* %t1021)
  store { i8**, i64 }* %t1022, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  %t1023 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1024 = load i1, i1* %l15
  br label %merge71
merge71:
  %t1025 = phi { i8**, i64 }* [ %t1023, %then70 ], [ %t996, %then68 ]
  %t1026 = phi i1 [ %t1024, %then70 ], [ %t1011, %then68 ]
  store { i8**, i64 }* %t1025, { i8**, i64 }** %l0
  store i1 %t1026, i1* %l15
  %t1027 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1028 = load i1, i1* %l15
  br label %merge69
merge69:
  %t1029 = phi { i8**, i64 }* [ %t1027, %merge71 ], [ %t974, %then66 ]
  %t1030 = phi i1 [ %t1028, %merge71 ], [ %t989, %then66 ]
  store { i8**, i64 }* %t1029, { i8**, i64 }** %l0
  store i1 %t1030, i1* %l15
  %t1031 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1032 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1033 = load i1, i1* %l15
  br label %merge67
merge67:
  %t1034 = phi { %NativeStructLayoutField*, i64 }* [ %t1031, %merge69 ], [ %t959, %then64 ]
  %t1035 = phi { i8**, i64 }* [ %t1032, %merge69 ], [ %t948, %then64 ]
  %t1036 = phi i1 [ %t1033, %merge69 ], [ %t963, %then64 ]
  store { %NativeStructLayoutField*, i64 }* %t1034, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t1035, { i8**, i64 }** %l0
  store i1 %t1036, i1* %l15
  %t1037 = load double, double* %l16
  %t1038 = sitofp i64 1 to double
  %t1039 = fadd double %t1037, %t1038
  store double %t1039, double* %l16
  br label %loop.latch4
merge65:
  %t1040 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1041 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h1152036459, i32 0, i32 0
  %t1042 = load i8*, i8** %l18
  %t1043 = call i8* @sailfin_runtime_string_concat(i8* %s1041, i8* %t1042)
  %t1044 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1040, i8* %t1043)
  store { i8**, i64 }* %t1044, { i8**, i64 }** %l0
  %t1045 = load double, double* %l16
  %t1046 = sitofp i64 1 to double
  %t1047 = fadd double %t1045, %t1046
  store double %t1047, double* %l16
  br label %loop.latch4
merge56:
  %t1048 = load i8*, i8** %l18
  %s1049 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t1050 = call i1 @strings_equal(i8* %t1048, i8* %s1049)
  %t1051 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1052 = load i8*, i8** %l1
  %t1053 = load i8*, i8** %l2
  %t1054 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1055 = load i8*, i8** %l4
  %t1056 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1057 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1058 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1059 = load %NativeFunction*, %NativeFunction** %l8
  %t1060 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1061 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1062 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1063 = load double, double* %l12
  %t1064 = load double, double* %l13
  %t1065 = load i1, i1* %l14
  %t1066 = load i1, i1* %l15
  %t1067 = load double, double* %l16
  %t1068 = load i8*, i8** %l18
  br i1 %t1050, label %then72, label %merge73
then72:
  %t1069 = load double, double* %l16
  %t1070 = sitofp i64 1 to double
  %t1071 = fadd double %t1069, %t1070
  store double %t1071, double* %l16
  br label %loop.latch4
merge73:
  %t1072 = load i8*, i8** %l18
  %s1073 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1074 = call i1 @starts_with(i8* %t1072, i8* %s1073)
  %t1075 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1076 = load i8*, i8** %l1
  %t1077 = load i8*, i8** %l2
  %t1078 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1079 = load i8*, i8** %l4
  %t1080 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1081 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1082 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1083 = load %NativeFunction*, %NativeFunction** %l8
  %t1084 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1085 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1086 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1087 = load double, double* %l12
  %t1088 = load double, double* %l13
  %t1089 = load i1, i1* %l14
  %t1090 = load i1, i1* %l15
  %t1091 = load double, double* %l16
  %t1092 = load i8*, i8** %l18
  br i1 %t1074, label %then74, label %merge75
then74:
  %t1093 = load i8*, i8** %l18
  %s1094 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1095 = call i8* @strip_prefix(i8* %t1093, i8* %s1094)
  %t1096 = call %NativeStructField* @parse_struct_field_line(i8* %t1095)
  store %NativeStructField* %t1096, %NativeStructField** %l27
  %t1097 = load %NativeStructField*, %NativeStructField** %l27
  %t1098 = icmp eq %NativeStructField* %t1097, null
  %t1099 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1100 = load i8*, i8** %l1
  %t1101 = load i8*, i8** %l2
  %t1102 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1103 = load i8*, i8** %l4
  %t1104 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1105 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1106 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1107 = load %NativeFunction*, %NativeFunction** %l8
  %t1108 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1109 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1110 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1111 = load double, double* %l12
  %t1112 = load double, double* %l13
  %t1113 = load i1, i1* %l14
  %t1114 = load i1, i1* %l15
  %t1115 = load double, double* %l16
  %t1116 = load i8*, i8** %l18
  %t1117 = load %NativeStructField*, %NativeStructField** %l27
  br i1 %t1098, label %then76, label %else77
then76:
  %t1118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1119 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h702899578, i32 0, i32 0
  %t1120 = load i8*, i8** %l18
  %t1121 = call i8* @sailfin_runtime_string_concat(i8* %s1119, i8* %t1120)
  %t1122 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1118, i8* %t1121)
  store { i8**, i64 }* %t1122, { i8**, i64 }** %l0
  %t1123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge78
else77:
  %t1124 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1125 = load %NativeStructField*, %NativeStructField** %l27
  %t1126 = load %NativeStructField, %NativeStructField* %t1125
  %t1127 = call { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %t1124, %NativeStructField %t1126)
  store { %NativeStructField*, i64 }* %t1127, { %NativeStructField*, i64 }** %l6
  %t1128 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %merge78
merge78:
  %t1129 = phi { i8**, i64 }* [ %t1123, %then76 ], [ %t1099, %else77 ]
  %t1130 = phi { %NativeStructField*, i64 }* [ %t1105, %then76 ], [ %t1128, %else77 ]
  store { i8**, i64 }* %t1129, { i8**, i64 }** %l0
  store { %NativeStructField*, i64 }* %t1130, { %NativeStructField*, i64 }** %l6
  %t1131 = load double, double* %l16
  %t1132 = sitofp i64 1 to double
  %t1133 = fadd double %t1131, %t1132
  store double %t1133, double* %l16
  br label %loop.latch4
merge75:
  %t1134 = load i8*, i8** %l18
  %s1135 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1136 = call i1 @starts_with(i8* %t1134, i8* %s1135)
  %t1137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1138 = load i8*, i8** %l1
  %t1139 = load i8*, i8** %l2
  %t1140 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1141 = load i8*, i8** %l4
  %t1142 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1143 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1144 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1145 = load %NativeFunction*, %NativeFunction** %l8
  %t1146 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1147 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1148 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1149 = load double, double* %l12
  %t1150 = load double, double* %l13
  %t1151 = load i1, i1* %l14
  %t1152 = load i1, i1* %l15
  %t1153 = load double, double* %l16
  %t1154 = load i8*, i8** %l18
  br i1 %t1136, label %then79, label %merge80
then79:
  %t1155 = load %NativeFunction*, %NativeFunction** %l8
  %t1156 = icmp ne %NativeFunction* %t1155, null
  %t1157 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1158 = load i8*, i8** %l1
  %t1159 = load i8*, i8** %l2
  %t1160 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1161 = load i8*, i8** %l4
  %t1162 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1163 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1164 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1165 = load %NativeFunction*, %NativeFunction** %l8
  %t1166 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1167 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1168 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1169 = load double, double* %l12
  %t1170 = load double, double* %l13
  %t1171 = load i1, i1* %l14
  %t1172 = load i1, i1* %l15
  %t1173 = load double, double* %l16
  %t1174 = load i8*, i8** %l18
  br i1 %t1156, label %then81, label %merge82
then81:
  %t1175 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1176 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t1177 = load i8*, i8** %l4
  %t1178 = call i8* @sailfin_runtime_string_concat(i8* %s1176, i8* %t1177)
  %t1179 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1175, i8* %t1178)
  store { i8**, i64 }* %t1179, { i8**, i64 }** %l0
  %t1180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge82
merge82:
  %t1181 = phi { i8**, i64 }* [ %t1180, %then81 ], [ %t1157, %then79 ]
  store { i8**, i64 }* %t1181, { i8**, i64 }** %l0
  %t1182 = load i8*, i8** %l18
  %s1183 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1184 = call i8* @strip_prefix(i8* %t1182, i8* %s1183)
  %t1185 = call i8* @parse_function_name(i8* %t1184)
  store i8* %t1185, i8** %l28
  %t1186 = load i8*, i8** %l28
  %t1187 = insertvalue %NativeFunction undef, i8* %t1186, 0
  %t1188 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* null, i32 1
  %t1189 = ptrtoint [0 x %NativeParameter*]* %t1188 to i64
  %t1190 = icmp eq i64 %t1189, 0
  %t1191 = select i1 %t1190, i64 1, i64 %t1189
  %t1192 = call i8* @malloc(i64 %t1191)
  %t1193 = bitcast i8* %t1192 to %NativeParameter**
  %t1194 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* null, i32 1
  %t1195 = ptrtoint { %NativeParameter**, i64 }* %t1194 to i64
  %t1196 = call i8* @malloc(i64 %t1195)
  %t1197 = bitcast i8* %t1196 to { %NativeParameter**, i64 }*
  %t1198 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t1197, i32 0, i32 0
  store %NativeParameter** %t1193, %NativeParameter*** %t1198
  %t1199 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t1197, i32 0, i32 1
  store i64 0, i64* %t1199
  %t1200 = insertvalue %NativeFunction %t1187, { %NativeParameter**, i64 }* %t1197, 1
  %s1201 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t1202 = insertvalue %NativeFunction %t1200, i8* %s1201, 2
  %t1203 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1204 = ptrtoint [0 x i8*]* %t1203 to i64
  %t1205 = icmp eq i64 %t1204, 0
  %t1206 = select i1 %t1205, i64 1, i64 %t1204
  %t1207 = call i8* @malloc(i64 %t1206)
  %t1208 = bitcast i8* %t1207 to i8**
  %t1209 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t1210 = ptrtoint { i8**, i64 }* %t1209 to i64
  %t1211 = call i8* @malloc(i64 %t1210)
  %t1212 = bitcast i8* %t1211 to { i8**, i64 }*
  %t1213 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1212, i32 0, i32 0
  store i8** %t1208, i8*** %t1213
  %t1214 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1212, i32 0, i32 1
  store i64 0, i64* %t1214
  %t1215 = insertvalue %NativeFunction %t1202, { i8**, i64 }* %t1212, 3
  %t1216 = getelementptr [0 x %NativeInstruction*], [0 x %NativeInstruction*]* null, i32 1
  %t1217 = ptrtoint [0 x %NativeInstruction*]* %t1216 to i64
  %t1218 = icmp eq i64 %t1217, 0
  %t1219 = select i1 %t1218, i64 1, i64 %t1217
  %t1220 = call i8* @malloc(i64 %t1219)
  %t1221 = bitcast i8* %t1220 to %NativeInstruction**
  %t1222 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* null, i32 1
  %t1223 = ptrtoint { %NativeInstruction**, i64 }* %t1222 to i64
  %t1224 = call i8* @malloc(i64 %t1223)
  %t1225 = bitcast i8* %t1224 to { %NativeInstruction**, i64 }*
  %t1226 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1225, i32 0, i32 0
  store %NativeInstruction** %t1221, %NativeInstruction*** %t1226
  %t1227 = getelementptr { %NativeInstruction**, i64 }, { %NativeInstruction**, i64 }* %t1225, i32 0, i32 1
  store i64 0, i64* %t1227
  %t1228 = insertvalue %NativeFunction %t1215, { %NativeInstruction**, i64 }* %t1225, 4
  %t1229 = alloca %NativeFunction
  store %NativeFunction %t1228, %NativeFunction* %t1229
  store %NativeFunction* %t1229, %NativeFunction** %l8
  %t1230 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1230, %NativeSourceSpan** %l9
  %t1231 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1231, %NativeSourceSpan** %l10
  %t1232 = load double, double* %l16
  %t1233 = sitofp i64 1 to double
  %t1234 = fadd double %t1232, %t1233
  store double %t1234, double* %l16
  br label %loop.latch4
merge80:
  %t1235 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1236 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h211710404, i32 0, i32 0
  %t1237 = load i8*, i8** %l18
  %t1238 = call i8* @sailfin_runtime_string_concat(i8* %s1236, i8* %t1237)
  %t1239 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1235, i8* %t1238)
  store { i8**, i64 }* %t1239, { i8**, i64 }** %l0
  %t1240 = load double, double* %l16
  %t1241 = sitofp i64 1 to double
  %t1242 = fadd double %t1240, %t1241
  store double %t1242, double* %l16
  br label %loop.latch4
loop.latch4:
  %t1243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1244 = load double, double* %l16
  %t1245 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1246 = load %NativeFunction*, %NativeFunction** %l8
  %t1247 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1248 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1249 = load double, double* %l12
  %t1250 = load double, double* %l13
  %t1251 = load i1, i1* %l14
  %t1252 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1253 = load i1, i1* %l15
  %t1254 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %loop.header2
afterloop5:
  %t1267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1268 = load double, double* %l16
  %t1269 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1270 = load %NativeFunction*, %NativeFunction** %l8
  %t1271 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1272 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1273 = load double, double* %l12
  %t1274 = load double, double* %l13
  %t1275 = load i1, i1* %l14
  %t1276 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1277 = load i1, i1* %l15
  %t1278 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1279 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t1279, %NativeStructLayout** %l29
  %t1280 = load i1, i1* %l14
  %t1281 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1282 = load i8*, i8** %l1
  %t1283 = load i8*, i8** %l2
  %t1284 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1285 = load i8*, i8** %l4
  %t1286 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1287 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1288 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1289 = load %NativeFunction*, %NativeFunction** %l8
  %t1290 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1291 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1292 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1293 = load double, double* %l12
  %t1294 = load double, double* %l13
  %t1295 = load i1, i1* %l14
  %t1296 = load i1, i1* %l15
  %t1297 = load double, double* %l16
  %t1298 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br i1 %t1280, label %then83, label %merge84
then83:
  %t1299 = load double, double* %l12
  %t1300 = insertvalue %NativeStructLayout undef, double %t1299, 0
  %t1301 = load double, double* %l13
  %t1302 = insertvalue %NativeStructLayout %t1300, double %t1301, 1
  %t1303 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1304 = bitcast { %NativeStructLayoutField*, i64 }* %t1303 to { %NativeStructLayoutField**, i64 }*
  %t1305 = insertvalue %NativeStructLayout %t1302, { %NativeStructLayoutField**, i64 }* %t1304, 2
  %t1306 = alloca %NativeStructLayout
  store %NativeStructLayout %t1305, %NativeStructLayout* %t1306
  store %NativeStructLayout* %t1306, %NativeStructLayout** %l29
  %t1307 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br label %merge84
merge84:
  %t1308 = phi %NativeStructLayout* [ %t1307, %then83 ], [ %t1298, %afterloop5 ]
  store %NativeStructLayout* %t1308, %NativeStructLayout** %l29
  %t1309 = load i8*, i8** %l4
  %t1310 = insertvalue %NativeStruct undef, i8* %t1309, 0
  %t1311 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1312 = bitcast { %NativeStructField*, i64 }* %t1311 to { %NativeStructField**, i64 }*
  %t1313 = insertvalue %NativeStruct %t1310, { %NativeStructField**, i64 }* %t1312, 1
  %t1314 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1315 = bitcast { %NativeFunction*, i64 }* %t1314 to { %NativeFunction**, i64 }*
  %t1316 = insertvalue %NativeStruct %t1313, { %NativeFunction**, i64 }* %t1315, 2
  %t1317 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1318 = insertvalue %NativeStruct %t1316, { i8**, i64 }* %t1317, 3
  %t1319 = load %NativeStructLayout*, %NativeStructLayout** %l29
  %t1320 = insertvalue %NativeStruct %t1318, %NativeStructLayout* %t1319, 4
  %t1321 = alloca %NativeStruct
  store %NativeStruct %t1320, %NativeStruct* %t1321
  %t1322 = insertvalue %StructParseResult undef, %NativeStruct* %t1321, 0
  %t1323 = load double, double* %l16
  %t1324 = insertvalue %StructParseResult %t1322, double %t1323, 1
  %t1325 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1326 = insertvalue %StructParseResult %t1324, { i8**, i64 }* %t1325, 2
  ret %StructParseResult %t1326
}

define %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %lines, double %start_index) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca %InterfaceHeaderParse
  %l4 = alloca i8*
  %l5 = alloca { %NativeInterfaceSignature*, i64 }*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca %InterfaceSignatureParse
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
  %t12 = call double @llvm.round.f64(double %start_index)
  %t13 = fptosi double %t12 to i64
  %t14 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t15 = extractvalue { i8**, i64 } %t14, 0
  %t16 = extractvalue { i8**, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t13, i64 %t16)
  %t18 = getelementptr i8*, i8** %t15, i64 %t13
  %t19 = load i8*, i8** %t18
  %t20 = call i8* @trim_text(i8* %t19)
  store i8* %t20, i8** %l1
  %t21 = load i8*, i8** %l1
  %s22 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h599952843, i32 0, i32 0
  %t23 = call i8* @strip_prefix(i8* %t21, i8* %s22)
  %t24 = call i8* @trim_text(i8* %t23)
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l2
  %t26 = call %InterfaceHeaderParse @parse_interface_header(i8* %t25)
  store %InterfaceHeaderParse %t26, %InterfaceHeaderParse* %l3
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t28 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t29 = extractvalue %InterfaceHeaderParse %t28, 2
  %t30 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t27, { i8**, i64 }* %t29)
  store { i8**, i64 }* %t30, { i8**, i64 }** %l0
  %t31 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t32 = extractvalue %InterfaceHeaderParse %t31, 0
  store i8* %t32, i8** %l4
  %t33 = load i8*, i8** %l4
  %t34 = call i64 @sailfin_runtime_string_length(i8* %t33)
  %t35 = icmp eq i64 %t34, 0
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load i8*, i8** %l1
  %t38 = load i8*, i8** %l2
  %t39 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t40 = load i8*, i8** %l4
  br i1 %t35, label %then0, label %merge1
then0:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s42 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h805939531, i32 0, i32 0
  %t43 = load i8*, i8** %l1
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %s42, i8* %t43)
  %t45 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t41, i8* %t44)
  store { i8**, i64 }* %t45, { i8**, i64 }** %l0
  %t46 = bitcast i8* null to %NativeInterface*
  %t47 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t46, 0
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %start_index, %t48
  %t50 = insertvalue %InterfaceParseResult %t47, double %t49, 1
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = insertvalue %InterfaceParseResult %t50, { i8**, i64 }* %t51, 2
  ret %InterfaceParseResult %t52
merge1:
  %t53 = getelementptr [0 x %NativeInterfaceSignature], [0 x %NativeInterfaceSignature]* null, i32 1
  %t54 = ptrtoint [0 x %NativeInterfaceSignature]* %t53 to i64
  %t55 = icmp eq i64 %t54, 0
  %t56 = select i1 %t55, i64 1, i64 %t54
  %t57 = call i8* @malloc(i64 %t56)
  %t58 = bitcast i8* %t57 to %NativeInterfaceSignature*
  %t59 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* null, i32 1
  %t60 = ptrtoint { %NativeInterfaceSignature*, i64 }* %t59 to i64
  %t61 = call i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to { %NativeInterfaceSignature*, i64 }*
  %t63 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t62, i32 0, i32 0
  store %NativeInterfaceSignature* %t58, %NativeInterfaceSignature** %t63
  %t64 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t62, i32 0, i32 1
  store i64 0, i64* %t64
  store { %NativeInterfaceSignature*, i64 }* %t62, { %NativeInterfaceSignature*, i64 }** %l5
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %start_index, %t65
  store double %t66, double* %l6
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load i8*, i8** %l2
  %t70 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t71 = load i8*, i8** %l4
  %t72 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t73 = load double, double* %l6
  br label %loop.header2
loop.header2:
  %t233 = phi { i8**, i64 }* [ %t67, %merge1 ], [ %t230, %loop.latch4 ]
  %t234 = phi double [ %t73, %merge1 ], [ %t231, %loop.latch4 ]
  %t235 = phi { %NativeInterfaceSignature*, i64 }* [ %t72, %merge1 ], [ %t232, %loop.latch4 ]
  store { i8**, i64 }* %t233, { i8**, i64 }** %l0
  store double %t234, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t235, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.body3
loop.body3:
  %t74 = load double, double* %l6
  %t75 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t76 = extractvalue { i8**, i64 } %t75, 1
  %t77 = sitofp i64 %t76 to double
  %t78 = fcmp oge double %t74, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load i8*, i8** %l1
  %t81 = load i8*, i8** %l2
  %t82 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t83 = load i8*, i8** %l4
  %t84 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t85 = load double, double* %l6
  br i1 %t78, label %then6, label %merge7
then6:
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s87 = getelementptr inbounds [24 x i8], [24 x i8]* @.str.len23.h1564009733, i32 0, i32 0
  %t88 = load i8*, i8** %l4
  %t89 = call i8* @sailfin_runtime_string_concat(i8* %s87, i8* %t88)
  %t90 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t86, i8* %t89)
  store { i8**, i64 }* %t90, { i8**, i64 }** %l0
  %t91 = load i8*, i8** %l4
  %t92 = insertvalue %NativeInterface undef, i8* %t91, 0
  %t93 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t94 = extractvalue %InterfaceHeaderParse %t93, 1
  %t95 = insertvalue %NativeInterface %t92, { i8**, i64 }* %t94, 1
  %t96 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t97 = bitcast { %NativeInterfaceSignature*, i64 }* %t96 to { %NativeInterfaceSignature**, i64 }*
  %t98 = insertvalue %NativeInterface %t95, { %NativeInterfaceSignature**, i64 }* %t97, 2
  %t99 = alloca %NativeInterface
  store %NativeInterface %t98, %NativeInterface* %t99
  %t100 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t99, 0
  %t101 = load double, double* %l6
  %t102 = insertvalue %InterfaceParseResult %t100, double %t101, 1
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = insertvalue %InterfaceParseResult %t102, { i8**, i64 }* %t103, 2
  ret %InterfaceParseResult %t104
merge7:
  %t105 = load double, double* %l6
  %t106 = call double @llvm.round.f64(double %t105)
  %t107 = fptosi double %t106 to i64
  %t108 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t109 = extractvalue { i8**, i64 } %t108, 0
  %t110 = extractvalue { i8**, i64 } %t108, 1
  %t111 = icmp uge i64 %t107, %t110
  ; bounds check: %t111 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t107, i64 %t110)
  %t112 = getelementptr i8*, i8** %t109, i64 %t107
  %t113 = load i8*, i8** %t112
  %t114 = call i8* @trim_text(i8* %t113)
  store i8* %t114, i8** %l7
  %t116 = load i8*, i8** %l7
  %t117 = call i64 @sailfin_runtime_string_length(i8* %t116)
  %t118 = icmp eq i64 %t117, 0
  br label %logical_or_entry_115

logical_or_entry_115:
  br i1 %t118, label %logical_or_merge_115, label %logical_or_right_115

logical_or_right_115:
  %t119 = load i8*, i8** %l7
  %t120 = alloca [2 x i8], align 1
  %t121 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  store i8 59, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 1
  store i8 0, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  %t124 = call i1 @starts_with(i8* %t119, i8* %t123)
  br label %logical_or_right_end_115

logical_or_right_end_115:
  br label %logical_or_merge_115

logical_or_merge_115:
  %t125 = phi i1 [ true, %logical_or_entry_115 ], [ %t124, %logical_or_right_end_115 ]
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load i8*, i8** %l1
  %t128 = load i8*, i8** %l2
  %t129 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t130 = load i8*, i8** %l4
  %t131 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t132 = load double, double* %l6
  %t133 = load i8*, i8** %l7
  br i1 %t125, label %then8, label %merge9
then8:
  %t134 = load double, double* %l6
  %t135 = sitofp i64 1 to double
  %t136 = fadd double %t134, %t135
  store double %t136, double* %l6
  br label %loop.latch4
merge9:
  %t137 = load i8*, i8** %l7
  %s138 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1382830532, i32 0, i32 0
  %t139 = call i1 @strings_equal(i8* %t137, i8* %s138)
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = load i8*, i8** %l1
  %t142 = load i8*, i8** %l2
  %t143 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t144 = load i8*, i8** %l4
  %t145 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t146 = load double, double* %l6
  %t147 = load i8*, i8** %l7
  br i1 %t139, label %then10, label %merge11
then10:
  %t148 = load double, double* %l6
  %t149 = sitofp i64 1 to double
  %t150 = fadd double %t148, %t149
  store double %t150, double* %l6
  br label %afterloop5
merge11:
  %t151 = load i8*, i8** %l7
  %s152 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t153 = call i1 @strings_equal(i8* %t151, i8* %s152)
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load i8*, i8** %l1
  %t156 = load i8*, i8** %l2
  %t157 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t158 = load i8*, i8** %l4
  %t159 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t160 = load double, double* %l6
  %t161 = load i8*, i8** %l7
  br i1 %t153, label %then12, label %merge13
then12:
  %t162 = load double, double* %l6
  %t163 = sitofp i64 1 to double
  %t164 = fadd double %t162, %t163
  store double %t164, double* %l6
  br label %loop.latch4
merge13:
  %t165 = load i8*, i8** %l7
  %s166 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t167 = call i1 @starts_with(i8* %t165, i8* %s166)
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t169 = load i8*, i8** %l1
  %t170 = load i8*, i8** %l2
  %t171 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t172 = load i8*, i8** %l4
  %t173 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t174 = load double, double* %l6
  %t175 = load i8*, i8** %l7
  br i1 %t167, label %then14, label %merge15
then14:
  %t176 = load i8*, i8** %l7
  %s177 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t178 = call i8* @strip_prefix(i8* %t176, i8* %s177)
  %t179 = load i8*, i8** %l4
  %t180 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t178, i8* %t179)
  store %InterfaceSignatureParse %t180, %InterfaceSignatureParse* %l8
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t182 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t183 = extractvalue %InterfaceSignatureParse %t182, 2
  %t184 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t181, { i8**, i64 }* %t183)
  store { i8**, i64 }* %t184, { i8**, i64 }** %l0
  %t185 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t186 = extractvalue %InterfaceSignatureParse %t185, 0
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t188 = load i8*, i8** %l1
  %t189 = load i8*, i8** %l2
  %t190 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t191 = load i8*, i8** %l4
  %t192 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t193 = load double, double* %l6
  %t194 = load i8*, i8** %l7
  %t195 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t186, label %then16, label %merge17
then16:
  %t196 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t197 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t198 = extractvalue %InterfaceSignatureParse %t197, 1
  %t199 = call noalias i8* @malloc(i64 48)
  %t200 = bitcast i8* %t199 to %NativeInterfaceSignature*
  store %NativeInterfaceSignature %t198, %NativeInterfaceSignature* %t200
  %t201 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t202 = ptrtoint [1 x i8*]* %t201 to i64
  %t203 = icmp eq i64 %t202, 0
  %t204 = select i1 %t203, i64 1, i64 %t202
  %t205 = call i8* @malloc(i64 %t204)
  %t206 = bitcast i8* %t205 to i8**
  %t207 = getelementptr i8*, i8** %t206, i64 0
  store i8* %t199, i8** %t207
  %t208 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t209 = ptrtoint { i8**, i64 }* %t208 to i64
  %t210 = call i8* @malloc(i64 %t209)
  %t211 = bitcast i8* %t210 to { i8**, i64 }*
  %t212 = getelementptr { i8**, i64 }, { i8**, i64 }* %t211, i32 0, i32 0
  store i8** %t206, i8*** %t212
  %t213 = getelementptr { i8**, i64 }, { i8**, i64 }* %t211, i32 0, i32 1
  store i64 1, i64* %t213
  %t214 = bitcast { %NativeInterfaceSignature*, i64 }* %t196 to { i8**, i64 }*
  %t215 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t214, { i8**, i64 }* %t211)
  %t216 = bitcast { i8**, i64 }* %t215 to { %NativeInterfaceSignature*, i64 }*
  store { %NativeInterfaceSignature*, i64 }* %t216, { %NativeInterfaceSignature*, i64 }** %l5
  %t217 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t218 = phi { %NativeInterfaceSignature*, i64 }* [ %t217, %then16 ], [ %t192, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t218, { %NativeInterfaceSignature*, i64 }** %l5
  %t219 = load double, double* %l6
  %t220 = sitofp i64 1 to double
  %t221 = fadd double %t219, %t220
  store double %t221, double* %l6
  br label %loop.latch4
merge15:
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s223 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1134984829, i32 0, i32 0
  %t224 = load i8*, i8** %l7
  %t225 = call i8* @sailfin_runtime_string_concat(i8* %s223, i8* %t224)
  %t226 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t222, i8* %t225)
  store { i8**, i64 }* %t226, { i8**, i64 }** %l0
  %t227 = load double, double* %l6
  %t228 = sitofp i64 1 to double
  %t229 = fadd double %t227, %t228
  store double %t229, double* %l6
  br label %loop.latch4
loop.latch4:
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t231 = load double, double* %l6
  %t232 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t237 = load double, double* %l6
  %t238 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t239 = load i8*, i8** %l4
  %t240 = insertvalue %NativeInterface undef, i8* %t239, 0
  %t241 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t242 = extractvalue %InterfaceHeaderParse %t241, 1
  %t243 = insertvalue %NativeInterface %t240, { i8**, i64 }* %t242, 1
  %t244 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t245 = bitcast { %NativeInterfaceSignature*, i64 }* %t244 to { %NativeInterfaceSignature**, i64 }*
  %t246 = insertvalue %NativeInterface %t243, { %NativeInterfaceSignature**, i64 }* %t245, 2
  %t247 = alloca %NativeInterface
  store %NativeInterface %t246, %NativeInterface* %t247
  %t248 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t247, 0
  %t249 = load double, double* %l6
  %t250 = insertvalue %InterfaceParseResult %t248, double %t249, 1
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = insertvalue %InterfaceParseResult %t250, { i8**, i64 }* %t251, 2
  ret %InterfaceParseResult %t252
}

define %StructHeaderParse @parse_struct_header(i8* %text) {
block.entry:
  %l0 = alloca %HeaderNameParse
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { i8**, i64 }*
  %l3 = alloca i8*
  %t0 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %text)
  store %HeaderNameParse %t0, %HeaderNameParse* %l0
  %t1 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t2 = extractvalue %HeaderNameParse %t1, 3
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
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
  store { i8**, i64 }* %t12, { i8**, i64 }** %l2
  %t15 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t16 = extractvalue %HeaderNameParse %t15, 2
  %t17 = call i64 @sailfin_runtime_string_length(i8* %t16)
  %t18 = icmp sgt i64 %t17, 0
  %t19 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t18, label %then0, label %merge1
then0:
  %t22 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t23 = extractvalue %HeaderNameParse %t22, 2
  %s24 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h908744813, i32 0, i32 0
  %t25 = call i1 @starts_with(i8* %t23, i8* %s24)
  %t26 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br i1 %t25, label %then2, label %else3
then2:
  %t29 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t30 = extractvalue %HeaderNameParse %t29, 2
  %s31 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h908744813, i32 0, i32 0
  %t32 = call i8* @strip_prefix(i8* %t30, i8* %s31)
  %t33 = call i8* @trim_text(i8* %t32)
  store i8* %t33, i8** %l3
  %t34 = load i8*, i8** %l3
  %t35 = call i64 @sailfin_runtime_string_length(i8* %t34)
  %t36 = icmp eq i64 %t35, 0
  %t37 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t40 = load i8*, i8** %l3
  br i1 %t36, label %then5, label %else6
then5:
  %t41 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s42 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t43 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t44 = extractvalue %HeaderNameParse %t43, 0
  %t45 = call i8* @sailfin_runtime_string_concat(i8* %s42, i8* %t44)
  %s46 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1868156648, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t45, i8* %s46)
  %t48 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t41, i8* %t47)
  store { i8**, i64 }* %t48, { i8**, i64 }** %l1
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge7
else6:
  %t50 = load i8*, i8** %l3
  %t51 = call { i8**, i64 }* @parse_implements_list(i8* %t50)
  store { i8**, i64 }* %t51, { i8**, i64 }** %l2
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge7
merge7:
  %t53 = phi { i8**, i64 }* [ %t49, %then5 ], [ %t38, %else6 ]
  %t54 = phi { i8**, i64 }* [ %t39, %then5 ], [ %t52, %else6 ]
  store { i8**, i64 }* %t53, { i8**, i64 }** %l1
  store { i8**, i64 }* %t54, { i8**, i64 }** %l2
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t56 = load { i8**, i64 }*, { i8**, i64 }** %l2
  br label %merge4
else3:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s58 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t59 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t60 = extractvalue %HeaderNameParse %t59, 0
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %s58, i8* %t60)
  %s62 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1132321576, i32 0, i32 0
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t61, i8* %s62)
  %t64 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t65 = extractvalue %HeaderNameParse %t64, 2
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %t63, i8* %t65)
  %t67 = alloca [2 x i8], align 1
  %t68 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  store i8 96, i8* %t68
  %t69 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 1
  store i8 0, i8* %t69
  %t70 = getelementptr [2 x i8], [2 x i8]* %t67, i32 0, i32 0
  %t71 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t70)
  %t72 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t57, i8* %t71)
  store { i8**, i64 }* %t72, { i8**, i64 }** %l1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge4
merge4:
  %t74 = phi { i8**, i64 }* [ %t55, %merge7 ], [ %t73, %else3 ]
  %t75 = phi { i8**, i64 }* [ %t56, %merge7 ], [ %t28, %else3 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l1
  store { i8**, i64 }* %t75, { i8**, i64 }** %l2
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t79 = phi { i8**, i64 }* [ %t76, %merge4 ], [ %t20, %block.entry ]
  %t80 = phi { i8**, i64 }* [ %t77, %merge4 ], [ %t21, %block.entry ]
  %t81 = phi { i8**, i64 }* [ %t78, %merge4 ], [ %t20, %block.entry ]
  store { i8**, i64 }* %t79, { i8**, i64 }** %l1
  store { i8**, i64 }* %t80, { i8**, i64 }** %l2
  store { i8**, i64 }* %t81, { i8**, i64 }** %l1
  %t82 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t83 = extractvalue %HeaderNameParse %t82, 0
  %t84 = insertvalue %StructHeaderParse undef, i8* %t83, 0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t86 = insertvalue %StructHeaderParse %t84, { i8**, i64 }* %t85, 1
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t88 = insertvalue %StructHeaderParse %t86, { i8**, i64 }* %t87, 2
  ret %StructHeaderParse %t88
}

define %InterfaceHeaderParse @parse_interface_header(i8* %text) {
block.entry:
  %l0 = alloca %HeaderNameParse
  %l1 = alloca { i8**, i64 }*
  %t0 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %text)
  store %HeaderNameParse %t0, %HeaderNameParse* %l0
  %t1 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t2 = extractvalue %HeaderNameParse %t1, 3
  store { i8**, i64 }* %t2, { i8**, i64 }** %l1
  %t3 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t4 = extractvalue %HeaderNameParse %t3, 2
  %t5 = call i64 @sailfin_runtime_string_length(i8* %t4)
  %t6 = icmp sgt i64 %t5, 0
  %t7 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t8 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t6, label %then0, label %merge1
then0:
  %t9 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s10 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t11 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t12 = extractvalue %HeaderNameParse %t11, 0
  %t13 = call i8* @sailfin_runtime_string_concat(i8* %s10, i8* %t12)
  %s14 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1132321576, i32 0, i32 0
  %t15 = call i8* @sailfin_runtime_string_concat(i8* %t13, i8* %s14)
  %t16 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t17 = extractvalue %HeaderNameParse %t16, 2
  %t18 = call i8* @sailfin_runtime_string_concat(i8* %t15, i8* %t17)
  %t19 = alloca [2 x i8], align 1
  %t20 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  store i8 96, i8* %t20
  %t21 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 1
  store i8 0, i8* %t21
  %t22 = getelementptr [2 x i8], [2 x i8]* %t19, i32 0, i32 0
  %t23 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %t22)
  %t24 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t9, i8* %t23)
  store { i8**, i64 }* %t24, { i8**, i64 }** %l1
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t26 = phi { i8**, i64 }* [ %t25, %then0 ], [ %t8, %block.entry ]
  store { i8**, i64 }* %t26, { i8**, i64 }** %l1
  %t27 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t28 = extractvalue %HeaderNameParse %t27, 0
  %t29 = insertvalue %InterfaceHeaderParse undef, i8* %t28, 0
  %t30 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t31 = extractvalue %HeaderNameParse %t30, 1
  %t32 = insertvalue %InterfaceHeaderParse %t29, { i8**, i64 }* %t31, 1
  %t33 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t34 = insertvalue %InterfaceHeaderParse %t32, { i8**, i64 }* %t33, 2
  ret %InterfaceHeaderParse %t34
}

define %InterfaceSignatureParse @parse_interface_signature(i8* %text, i8* %interface_name) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca %NativeInterfaceSignature
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca i1
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca %HeaderNameParse
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca { %NativeParameter*, i64 }*
  %l12 = alloca i8*
  %l13 = alloca { i8**, i64 }*
  %l14 = alloca double
  %l15 = alloca %NativeParameter*
  %l16 = alloca i8*
  %l17 = alloca { i8**, i64 }*
  %l18 = alloca i8*
  %l19 = alloca double
  %l20 = alloca i8*
  %l21 = alloca i8*
  %l22 = alloca i8*
  %l23 = alloca %NativeInterfaceSignature
  %l24 = alloca i1
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
  %t13 = insertvalue %NativeInterfaceSignature undef, i8* %s12, 0
  %t14 = insertvalue %NativeInterfaceSignature %t13, i1 0, 1
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
  %t27 = insertvalue %NativeInterfaceSignature %t14, { i8**, i64 }* %t24, 2
  %t28 = getelementptr [0 x %NativeParameter*], [0 x %NativeParameter*]* null, i32 1
  %t29 = ptrtoint [0 x %NativeParameter*]* %t28 to i64
  %t30 = icmp eq i64 %t29, 0
  %t31 = select i1 %t30, i64 1, i64 %t29
  %t32 = call i8* @malloc(i64 %t31)
  %t33 = bitcast i8* %t32 to %NativeParameter**
  %t34 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeParameter**, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeParameter**, i64 }*
  %t38 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t37, i32 0, i32 0
  store %NativeParameter** %t33, %NativeParameter*** %t38
  %t39 = getelementptr { %NativeParameter**, i64 }, { %NativeParameter**, i64 }* %t37, i32 0, i32 1
  store i64 0, i64* %t39
  %t40 = insertvalue %NativeInterfaceSignature %t27, { %NativeParameter**, i64 }* %t37, 3
  %s41 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t42 = insertvalue %NativeInterfaceSignature %t40, i8* %s41, 4
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
  %t55 = insertvalue %NativeInterfaceSignature %t42, { i8**, i64 }* %t52, 5
  store %NativeInterfaceSignature %t55, %NativeInterfaceSignature* %l1
  %t56 = call i8* @trim_text(i8* %text)
  %t57 = call i8* @trim_trailing_delimiters(i8* %t56)
  store i8* %t57, i8** %l2
  %t58 = load i8*, i8** %l2
  %t59 = call i64 @sailfin_runtime_string_length(i8* %t58)
  %t60 = icmp eq i64 %t59, 0
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t63 = load i8*, i8** %l2
  br i1 %t60, label %then0, label %merge1
then0:
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s65 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t66 = call i8* @sailfin_runtime_string_concat(i8* %s65, i8* %interface_name)
  %s67 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1834305347, i32 0, i32 0
  %t68 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %s67)
  %t69 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t64, i8* %t68)
  store { i8**, i64 }* %t69, { i8**, i64 }** %l0
  %t70 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t71 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t72 = insertvalue %InterfaceSignatureParse %t70, %NativeInterfaceSignature %t71, 1
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = insertvalue %InterfaceSignatureParse %t72, { i8**, i64 }* %t73, 2
  ret %InterfaceSignatureParse %t74
merge1:
  %t75 = load i8*, i8** %l2
  store i8* %t75, i8** %l3
  store i1 0, i1* %l4
  %t76 = load i8*, i8** %l3
  %s77 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t78 = call i1 @starts_with(i8* %t76, i8* %s77)
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t81 = load i8*, i8** %l2
  %t82 = load i8*, i8** %l3
  %t83 = load i1, i1* %l4
  br i1 %t78, label %then2, label %merge3
then2:
  store i1 1, i1* %l4
  %t84 = load i8*, i8** %l3
  %s85 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t86 = call i8* @strip_prefix(i8* %t84, i8* %s85)
  %t87 = call i8* @trim_text(i8* %t86)
  store i8* %t87, i8** %l3
  %t88 = load i1, i1* %l4
  %t89 = load i8*, i8** %l3
  br label %merge3
merge3:
  %t90 = phi i1 [ %t88, %then2 ], [ %t83, %merge1 ]
  %t91 = phi i8* [ %t89, %then2 ], [ %t82, %merge1 ]
  store i1 %t90, i1* %l4
  store i8* %t91, i8** %l3
  %t92 = load i8*, i8** %l3
  %t93 = alloca [2 x i8], align 1
  %t94 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 0
  store i8 40, i8* %t94
  %t95 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 1
  store i8 0, i8* %t95
  %t96 = getelementptr [2 x i8], [2 x i8]* %t93, i32 0, i32 0
  %t97 = call double @index_of(i8* %t92, i8* %t96)
  store double %t97, double* %l5
  %t98 = load double, double* %l5
  %t99 = sitofp i64 0 to double
  %t100 = fcmp olt double %t98, %t99
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t103 = load i8*, i8** %l2
  %t104 = load i8*, i8** %l3
  %t105 = load i1, i1* %l4
  %t106 = load double, double* %l5
  br i1 %t100, label %then4, label %merge5
then4:
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s108 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t109 = call i8* @sailfin_runtime_string_concat(i8* %s108, i8* %interface_name)
  %s110 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h546841458, i32 0, i32 0
  %t111 = call i8* @sailfin_runtime_string_concat(i8* %t109, i8* %s110)
  %t112 = load i8*, i8** %l2
  %t113 = call i8* @sailfin_runtime_string_concat(i8* %t111, i8* %t112)
  %t114 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t107, i8* %t113)
  store { i8**, i64 }* %t114, { i8**, i64 }** %l0
  %t115 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t116 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t117 = insertvalue %InterfaceSignatureParse %t115, %NativeInterfaceSignature %t116, 1
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t119 = insertvalue %InterfaceSignatureParse %t117, { i8**, i64 }* %t118, 2
  ret %InterfaceSignatureParse %t119
merge5:
  %t120 = load i8*, i8** %l3
  %t121 = load double, double* %l5
  %t122 = call double @find_matching_paren(i8* %t120, double %t121)
  store double %t122, double* %l6
  %t123 = load double, double* %l6
  %t124 = sitofp i64 0 to double
  %t125 = fcmp olt double %t123, %t124
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t127 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t128 = load i8*, i8** %l2
  %t129 = load i8*, i8** %l3
  %t130 = load i1, i1* %l4
  %t131 = load double, double* %l5
  %t132 = load double, double* %l6
  br i1 %t125, label %then6, label %merge7
then6:
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s134 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t135 = call i8* @sailfin_runtime_string_concat(i8* %s134, i8* %interface_name)
  %s136 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.len44.h1730891783, i32 0, i32 0
  %t137 = call i8* @sailfin_runtime_string_concat(i8* %t135, i8* %s136)
  %t138 = load i8*, i8** %l2
  %t139 = call i8* @sailfin_runtime_string_concat(i8* %t137, i8* %t138)
  %t140 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t133, i8* %t139)
  store { i8**, i64 }* %t140, { i8**, i64 }** %l0
  %t141 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t142 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t143 = insertvalue %InterfaceSignatureParse %t141, %NativeInterfaceSignature %t142, 1
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = insertvalue %InterfaceSignatureParse %t143, { i8**, i64 }* %t144, 2
  ret %InterfaceSignatureParse %t145
merge7:
  %t146 = load i8*, i8** %l3
  %t147 = load double, double* %l5
  %t148 = call double @llvm.round.f64(double %t147)
  %t149 = fptosi double %t148 to i64
  %t150 = call i8* @sailfin_runtime_substring(i8* %t146, i64 0, i64 %t149)
  %t151 = call i8* @trim_text(i8* %t150)
  store i8* %t151, i8** %l7
  %t152 = load i8*, i8** %l7
  %t153 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %t152)
  store %HeaderNameParse %t153, %HeaderNameParse* %l8
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t155 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t156 = extractvalue %HeaderNameParse %t155, 3
  %t157 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t154, { i8**, i64 }* %t156)
  store { i8**, i64 }* %t157, { i8**, i64 }** %l0
  %t158 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t159 = extractvalue %HeaderNameParse %t158, 2
  %t160 = call i64 @sailfin_runtime_string_length(i8* %t159)
  %t161 = icmp sgt i64 %t160, 0
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t163 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t164 = load i8*, i8** %l2
  %t165 = load i8*, i8** %l3
  %t166 = load i1, i1* %l4
  %t167 = load double, double* %l5
  %t168 = load double, double* %l6
  %t169 = load i8*, i8** %l7
  %t170 = load %HeaderNameParse, %HeaderNameParse* %l8
  br i1 %t161, label %then8, label %merge9
then8:
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s172 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t173 = call i8* @sailfin_runtime_string_concat(i8* %s172, i8* %interface_name)
  %s174 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t175 = call i8* @sailfin_runtime_string_concat(i8* %t173, i8* %s174)
  %t176 = load i8*, i8** %l2
  %t177 = call i8* @sailfin_runtime_string_concat(i8* %t175, i8* %t176)
  %s178 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.len27.h237652301, i32 0, i32 0
  %t179 = call i8* @sailfin_runtime_string_concat(i8* %t177, i8* %s178)
  %t180 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t181 = extractvalue %HeaderNameParse %t180, 2
  %t182 = call i8* @sailfin_runtime_string_concat(i8* %t179, i8* %t181)
  %t183 = alloca [2 x i8], align 1
  %t184 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 0
  store i8 96, i8* %t184
  %t185 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 1
  store i8 0, i8* %t185
  %t186 = getelementptr [2 x i8], [2 x i8]* %t183, i32 0, i32 0
  %t187 = call i8* @sailfin_runtime_string_concat(i8* %t182, i8* %t186)
  %t188 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t171, i8* %t187)
  store { i8**, i64 }* %t188, { i8**, i64 }** %l0
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t190 = phi { i8**, i64 }* [ %t189, %then8 ], [ %t162, %merge7 ]
  store { i8**, i64 }* %t190, { i8**, i64 }** %l0
  %t191 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t192 = extractvalue %HeaderNameParse %t191, 0
  store i8* %t192, i8** %l9
  %t193 = load i8*, i8** %l9
  %t194 = call i64 @sailfin_runtime_string_length(i8* %t193)
  %t195 = icmp eq i64 %t194, 0
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t198 = load i8*, i8** %l2
  %t199 = load i8*, i8** %l3
  %t200 = load i1, i1* %l4
  %t201 = load double, double* %l5
  %t202 = load double, double* %l6
  %t203 = load i8*, i8** %l7
  %t204 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t205 = load i8*, i8** %l9
  br i1 %t195, label %then10, label %merge11
then10:
  %t206 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s207 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t208 = call i8* @sailfin_runtime_string_concat(i8* %s207, i8* %interface_name)
  %s209 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t208, i8* %s209)
  %t211 = load i8*, i8** %l2
  %t212 = call i8* @sailfin_runtime_string_concat(i8* %t210, i8* %t211)
  %s213 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1219450488, i32 0, i32 0
  %t214 = call i8* @sailfin_runtime_string_concat(i8* %t212, i8* %s213)
  %t215 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t206, i8* %t214)
  store { i8**, i64 }* %t215, { i8**, i64 }** %l0
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t217 = phi { i8**, i64 }* [ %t216, %then10 ], [ %t196, %merge9 ]
  store { i8**, i64 }* %t217, { i8**, i64 }** %l0
  %t218 = load i8*, i8** %l3
  %t219 = load double, double* %l5
  %t220 = sitofp i64 1 to double
  %t221 = fadd double %t219, %t220
  %t222 = load double, double* %l6
  %t223 = call double @llvm.round.f64(double %t221)
  %t224 = fptosi double %t223 to i64
  %t225 = call double @llvm.round.f64(double %t222)
  %t226 = fptosi double %t225 to i64
  %t227 = call i8* @sailfin_runtime_substring(i8* %t218, i64 %t224, i64 %t226)
  store i8* %t227, i8** %l10
  %t228 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t229 = ptrtoint [0 x %NativeParameter]* %t228 to i64
  %t230 = icmp eq i64 %t229, 0
  %t231 = select i1 %t230, i64 1, i64 %t229
  %t232 = call i8* @malloc(i64 %t231)
  %t233 = bitcast i8* %t232 to %NativeParameter*
  %t234 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t235 = ptrtoint { %NativeParameter*, i64 }* %t234 to i64
  %t236 = call i8* @malloc(i64 %t235)
  %t237 = bitcast i8* %t236 to { %NativeParameter*, i64 }*
  %t238 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t237, i32 0, i32 0
  store %NativeParameter* %t233, %NativeParameter** %t238
  %t239 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t237, i32 0, i32 1
  store i64 0, i64* %t239
  store { %NativeParameter*, i64 }* %t237, { %NativeParameter*, i64 }** %l11
  %t240 = load i8*, i8** %l10
  %t241 = call i8* @trim_text(i8* %t240)
  store i8* %t241, i8** %l12
  %t242 = load i8*, i8** %l12
  %t243 = call i64 @sailfin_runtime_string_length(i8* %t242)
  %t244 = icmp sgt i64 %t243, 0
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t246 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t247 = load i8*, i8** %l2
  %t248 = load i8*, i8** %l3
  %t249 = load i1, i1* %l4
  %t250 = load double, double* %l5
  %t251 = load double, double* %l6
  %t252 = load i8*, i8** %l7
  %t253 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t254 = load i8*, i8** %l9
  %t255 = load i8*, i8** %l10
  %t256 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t257 = load i8*, i8** %l12
  br i1 %t244, label %then12, label %merge13
then12:
  %t258 = load i8*, i8** %l12
  %t259 = call { i8**, i64 }* @split_parameter_entries(i8* %t258)
  store { i8**, i64 }* %t259, { i8**, i64 }** %l13
  %t260 = sitofp i64 0 to double
  store double %t260, double* %l14
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t262 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t263 = load i8*, i8** %l2
  %t264 = load i8*, i8** %l3
  %t265 = load i1, i1* %l4
  %t266 = load double, double* %l5
  %t267 = load double, double* %l6
  %t268 = load i8*, i8** %l7
  %t269 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t270 = load i8*, i8** %l9
  %t271 = load i8*, i8** %l10
  %t272 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t273 = load i8*, i8** %l12
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t275 = load double, double* %l14
  br label %loop.header14
loop.header14:
  %t367 = phi { i8**, i64 }* [ %t261, %then12 ], [ %t364, %loop.latch16 ]
  %t368 = phi { %NativeParameter*, i64 }* [ %t272, %then12 ], [ %t365, %loop.latch16 ]
  %t369 = phi double [ %t275, %then12 ], [ %t366, %loop.latch16 ]
  store { i8**, i64 }* %t367, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t368, { %NativeParameter*, i64 }** %l11
  store double %t369, double* %l14
  br label %loop.body15
loop.body15:
  %t276 = load double, double* %l14
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t278 = load { i8**, i64 }, { i8**, i64 }* %t277
  %t279 = extractvalue { i8**, i64 } %t278, 1
  %t280 = sitofp i64 %t279 to double
  %t281 = fcmp oge double %t276, %t280
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t283 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t284 = load i8*, i8** %l2
  %t285 = load i8*, i8** %l3
  %t286 = load i1, i1* %l4
  %t287 = load double, double* %l5
  %t288 = load double, double* %l6
  %t289 = load i8*, i8** %l7
  %t290 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t291 = load i8*, i8** %l9
  %t292 = load i8*, i8** %l10
  %t293 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t294 = load i8*, i8** %l12
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t296 = load double, double* %l14
  br i1 %t281, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t298 = load double, double* %l14
  %t299 = call double @llvm.round.f64(double %t298)
  %t300 = fptosi double %t299 to i64
  %t301 = load { i8**, i64 }, { i8**, i64 }* %t297
  %t302 = extractvalue { i8**, i64 } %t301, 0
  %t303 = extractvalue { i8**, i64 } %t301, 1
  %t304 = icmp uge i64 %t300, %t303
  ; bounds check: %t304 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t300, i64 %t303)
  %t305 = getelementptr i8*, i8** %t302, i64 %t300
  %t306 = load i8*, i8** %t305
  %t307 = bitcast i8* null to %NativeSourceSpan*
  %t308 = call %NativeParameter* @parse_parameter_entry(i8* %t306, %NativeSourceSpan* %t307)
  store %NativeParameter* %t308, %NativeParameter** %l15
  %t309 = load %NativeParameter*, %NativeParameter** %l15
  %t310 = icmp eq %NativeParameter* %t309, null
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t312 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t313 = load i8*, i8** %l2
  %t314 = load i8*, i8** %l3
  %t315 = load i1, i1* %l4
  %t316 = load double, double* %l5
  %t317 = load double, double* %l6
  %t318 = load i8*, i8** %l7
  %t319 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t320 = load i8*, i8** %l9
  %t321 = load i8*, i8** %l10
  %t322 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t323 = load i8*, i8** %l12
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t325 = load double, double* %l14
  %t326 = load %NativeParameter*, %NativeParameter** %l15
  br i1 %t310, label %then20, label %else21
then20:
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s328 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t329 = call i8* @sailfin_runtime_string_concat(i8* %s328, i8* %interface_name)
  %s330 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t331 = call i8* @sailfin_runtime_string_concat(i8* %t329, i8* %s330)
  %t332 = load i8*, i8** %l9
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %t331, i8* %t332)
  %s334 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h378946335, i32 0, i32 0
  %t335 = call i8* @sailfin_runtime_string_concat(i8* %t333, i8* %s334)
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t337 = load double, double* %l14
  %t338 = call double @llvm.round.f64(double %t337)
  %t339 = fptosi double %t338 to i64
  %t340 = load { i8**, i64 }, { i8**, i64 }* %t336
  %t341 = extractvalue { i8**, i64 } %t340, 0
  %t342 = extractvalue { i8**, i64 } %t340, 1
  %t343 = icmp uge i64 %t339, %t342
  ; bounds check: %t343 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t339, i64 %t342)
  %t344 = getelementptr i8*, i8** %t341, i64 %t339
  %t345 = load i8*, i8** %t344
  %t346 = call i8* @sailfin_runtime_string_concat(i8* %t335, i8* %t345)
  %t347 = alloca [2 x i8], align 1
  %t348 = getelementptr [2 x i8], [2 x i8]* %t347, i32 0, i32 0
  store i8 96, i8* %t348
  %t349 = getelementptr [2 x i8], [2 x i8]* %t347, i32 0, i32 1
  store i8 0, i8* %t349
  %t350 = getelementptr [2 x i8], [2 x i8]* %t347, i32 0, i32 0
  %t351 = call i8* @sailfin_runtime_string_concat(i8* %t346, i8* %t350)
  %t352 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t327, i8* %t351)
  store { i8**, i64 }* %t352, { i8**, i64 }** %l0
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge22
else21:
  %t354 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t355 = load %NativeParameter*, %NativeParameter** %l15
  %t356 = load %NativeParameter, %NativeParameter* %t355
  %t357 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t354, %NativeParameter %t356)
  store { %NativeParameter*, i64 }* %t357, { %NativeParameter*, i64 }** %l11
  %t358 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge22
merge22:
  %t359 = phi { i8**, i64 }* [ %t353, %then20 ], [ %t311, %else21 ]
  %t360 = phi { %NativeParameter*, i64 }* [ %t322, %then20 ], [ %t358, %else21 ]
  store { i8**, i64 }* %t359, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t360, { %NativeParameter*, i64 }** %l11
  %t361 = load double, double* %l14
  %t362 = sitofp i64 1 to double
  %t363 = fadd double %t361, %t362
  store double %t363, double* %l14
  br label %loop.latch16
loop.latch16:
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t365 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t366 = load double, double* %l14
  br label %loop.header14
afterloop17:
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t371 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t372 = load double, double* %l14
  %t373 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t374 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge13
merge13:
  %t375 = phi { i8**, i64 }* [ %t373, %afterloop17 ], [ %t245, %merge11 ]
  %t376 = phi { %NativeParameter*, i64 }* [ %t374, %afterloop17 ], [ %t256, %merge11 ]
  store { i8**, i64 }* %t375, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t376, { %NativeParameter*, i64 }** %l11
  %s377 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  store i8* %s377, i8** %l16
  %t378 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t379 = ptrtoint [0 x i8*]* %t378 to i64
  %t380 = icmp eq i64 %t379, 0
  %t381 = select i1 %t380, i64 1, i64 %t379
  %t382 = call i8* @malloc(i64 %t381)
  %t383 = bitcast i8* %t382 to i8**
  %t384 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t385 = ptrtoint { i8**, i64 }* %t384 to i64
  %t386 = call i8* @malloc(i64 %t385)
  %t387 = bitcast i8* %t386 to { i8**, i64 }*
  %t388 = getelementptr { i8**, i64 }, { i8**, i64 }* %t387, i32 0, i32 0
  store i8** %t383, i8*** %t388
  %t389 = getelementptr { i8**, i64 }, { i8**, i64 }* %t387, i32 0, i32 1
  store i64 0, i64* %t389
  store { i8**, i64 }* %t387, { i8**, i64 }** %l17
  %t390 = load i8*, i8** %l3
  %t391 = load double, double* %l6
  %t392 = sitofp i64 1 to double
  %t393 = fadd double %t391, %t392
  %t394 = load i8*, i8** %l3
  %t395 = call i64 @sailfin_runtime_string_length(i8* %t394)
  %t396 = call double @llvm.round.f64(double %t393)
  %t397 = fptosi double %t396 to i64
  %t398 = call i8* @sailfin_runtime_substring(i8* %t390, i64 %t397, i64 %t395)
  %t399 = call i8* @trim_text(i8* %t398)
  store i8* %t399, i8** %l18
  %t400 = load i8*, i8** %l18
  %t401 = call i64 @sailfin_runtime_string_length(i8* %t400)
  %t402 = icmp sgt i64 %t401, 0
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t404 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t405 = load i8*, i8** %l2
  %t406 = load i8*, i8** %l3
  %t407 = load i1, i1* %l4
  %t408 = load double, double* %l5
  %t409 = load double, double* %l6
  %t410 = load i8*, i8** %l7
  %t411 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t412 = load i8*, i8** %l9
  %t413 = load i8*, i8** %l10
  %t414 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t415 = load i8*, i8** %l12
  %t416 = load i8*, i8** %l16
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t418 = load i8*, i8** %l18
  br i1 %t402, label %then23, label %merge24
then23:
  %t419 = load i8*, i8** %l18
  %s420 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t421 = call double @index_of(i8* %t419, i8* %s420)
  store double %t421, double* %l19
  %s422 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s422, i8** %l20
  %t423 = load double, double* %l19
  %t424 = sitofp i64 0 to double
  %t425 = fcmp oge double %t423, %t424
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t427 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t428 = load i8*, i8** %l2
  %t429 = load i8*, i8** %l3
  %t430 = load i1, i1* %l4
  %t431 = load double, double* %l5
  %t432 = load double, double* %l6
  %t433 = load i8*, i8** %l7
  %t434 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t435 = load i8*, i8** %l9
  %t436 = load i8*, i8** %l10
  %t437 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t438 = load i8*, i8** %l12
  %t439 = load i8*, i8** %l16
  %t440 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t441 = load i8*, i8** %l18
  %t442 = load double, double* %l19
  %t443 = load i8*, i8** %l20
  br i1 %t425, label %then25, label %merge26
then25:
  %t444 = load i8*, i8** %l18
  %t445 = load double, double* %l19
  %t446 = load i8*, i8** %l18
  %t447 = call i64 @sailfin_runtime_string_length(i8* %t446)
  %t448 = call double @llvm.round.f64(double %t445)
  %t449 = fptosi double %t448 to i64
  %t450 = call i8* @sailfin_runtime_substring(i8* %t444, i64 %t449, i64 %t447)
  %t451 = call i8* @trim_text(i8* %t450)
  store i8* %t451, i8** %l20
  %t452 = load i8*, i8** %l18
  %t453 = load double, double* %l19
  %t454 = call double @llvm.round.f64(double %t453)
  %t455 = fptosi double %t454 to i64
  %t456 = call i8* @sailfin_runtime_substring(i8* %t452, i64 0, i64 %t455)
  %t457 = call i8* @trim_text(i8* %t456)
  store i8* %t457, i8** %l18
  %t458 = load i8*, i8** %l20
  %t459 = load i8*, i8** %l18
  br label %merge26
merge26:
  %t460 = phi i8* [ %t458, %then25 ], [ %t443, %then23 ]
  %t461 = phi i8* [ %t459, %then25 ], [ %t441, %then23 ]
  store i8* %t460, i8** %l20
  store i8* %t461, i8** %l18
  %t462 = load i8*, i8** %l18
  %t463 = call i64 @sailfin_runtime_string_length(i8* %t462)
  %t464 = icmp sgt i64 %t463, 0
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t466 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t467 = load i8*, i8** %l2
  %t468 = load i8*, i8** %l3
  %t469 = load i1, i1* %l4
  %t470 = load double, double* %l5
  %t471 = load double, double* %l6
  %t472 = load i8*, i8** %l7
  %t473 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t474 = load i8*, i8** %l9
  %t475 = load i8*, i8** %l10
  %t476 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t477 = load i8*, i8** %l12
  %t478 = load i8*, i8** %l16
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t480 = load i8*, i8** %l18
  %t481 = load double, double* %l19
  %t482 = load i8*, i8** %l20
  br i1 %t464, label %then27, label %merge28
then27:
  %t483 = load i8*, i8** %l18
  %s484 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t485 = call i1 @starts_with(i8* %t483, i8* %s484)
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t487 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t488 = load i8*, i8** %l2
  %t489 = load i8*, i8** %l3
  %t490 = load i1, i1* %l4
  %t491 = load double, double* %l5
  %t492 = load double, double* %l6
  %t493 = load i8*, i8** %l7
  %t494 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t495 = load i8*, i8** %l9
  %t496 = load i8*, i8** %l10
  %t497 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t498 = load i8*, i8** %l12
  %t499 = load i8*, i8** %l16
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t501 = load i8*, i8** %l18
  %t502 = load double, double* %l19
  %t503 = load i8*, i8** %l20
  br i1 %t485, label %then29, label %else30
then29:
  %t504 = load i8*, i8** %l18
  %s505 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t506 = call i8* @strip_prefix(i8* %t504, i8* %s505)
  %t507 = call i8* @trim_text(i8* %t506)
  store i8* %t507, i8** %l21
  %t508 = load i8*, i8** %l21
  %t509 = call i64 @sailfin_runtime_string_length(i8* %t508)
  %t510 = icmp sgt i64 %t509, 0
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t512 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t513 = load i8*, i8** %l2
  %t514 = load i8*, i8** %l3
  %t515 = load i1, i1* %l4
  %t516 = load double, double* %l5
  %t517 = load double, double* %l6
  %t518 = load i8*, i8** %l7
  %t519 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t520 = load i8*, i8** %l9
  %t521 = load i8*, i8** %l10
  %t522 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t523 = load i8*, i8** %l12
  %t524 = load i8*, i8** %l16
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t526 = load i8*, i8** %l18
  %t527 = load double, double* %l19
  %t528 = load i8*, i8** %l20
  %t529 = load i8*, i8** %l21
  br i1 %t510, label %then32, label %merge33
then32:
  %t530 = load i8*, i8** %l21
  store i8* %t530, i8** %l16
  %t531 = load i8*, i8** %l16
  br label %merge33
merge33:
  %t532 = phi i8* [ %t531, %then32 ], [ %t524, %then29 ]
  store i8* %t532, i8** %l16
  %t533 = load i8*, i8** %l16
  br label %merge31
else30:
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s535 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t536 = call i8* @sailfin_runtime_string_concat(i8* %s535, i8* %interface_name)
  %s537 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t538 = call i8* @sailfin_runtime_string_concat(i8* %t536, i8* %s537)
  %t539 = load i8*, i8** %l9
  %t540 = call i8* @sailfin_runtime_string_concat(i8* %t538, i8* %t539)
  %s541 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1606904140, i32 0, i32 0
  %t542 = call i8* @sailfin_runtime_string_concat(i8* %t540, i8* %s541)
  %t543 = load i8*, i8** %l18
  %t544 = call i8* @sailfin_runtime_string_concat(i8* %t542, i8* %t543)
  %t545 = alloca [2 x i8], align 1
  %t546 = getelementptr [2 x i8], [2 x i8]* %t545, i32 0, i32 0
  store i8 96, i8* %t546
  %t547 = getelementptr [2 x i8], [2 x i8]* %t545, i32 0, i32 1
  store i8 0, i8* %t547
  %t548 = getelementptr [2 x i8], [2 x i8]* %t545, i32 0, i32 0
  %t549 = call i8* @sailfin_runtime_string_concat(i8* %t544, i8* %t548)
  %t550 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t534, i8* %t549)
  store { i8**, i64 }* %t550, { i8**, i64 }** %l0
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
merge31:
  %t552 = phi i8* [ %t533, %merge33 ], [ %t499, %else30 ]
  %t553 = phi { i8**, i64 }* [ %t486, %merge33 ], [ %t551, %else30 ]
  store i8* %t552, i8** %l16
  store { i8**, i64 }* %t553, { i8**, i64 }** %l0
  %t554 = load i8*, i8** %l16
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t556 = phi i8* [ %t554, %merge31 ], [ %t478, %merge26 ]
  %t557 = phi { i8**, i64 }* [ %t555, %merge31 ], [ %t465, %merge26 ]
  store i8* %t556, i8** %l16
  store { i8**, i64 }* %t557, { i8**, i64 }** %l0
  %t558 = load i8*, i8** %l20
  %t559 = call i64 @sailfin_runtime_string_length(i8* %t558)
  %t560 = icmp sgt i64 %t559, 0
  %t561 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t562 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t563 = load i8*, i8** %l2
  %t564 = load i8*, i8** %l3
  %t565 = load i1, i1* %l4
  %t566 = load double, double* %l5
  %t567 = load double, double* %l6
  %t568 = load i8*, i8** %l7
  %t569 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t570 = load i8*, i8** %l9
  %t571 = load i8*, i8** %l10
  %t572 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t573 = load i8*, i8** %l12
  %t574 = load i8*, i8** %l16
  %t575 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t576 = load i8*, i8** %l18
  %t577 = load double, double* %l19
  %t578 = load i8*, i8** %l20
  br i1 %t560, label %then34, label %merge35
then34:
  %t580 = load i8*, i8** %l20
  %s581 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t582 = call i1 @starts_with(i8* %t580, i8* %s581)
  br label %logical_and_entry_579

logical_and_entry_579:
  br i1 %t582, label %logical_and_right_579, label %logical_and_merge_579

logical_and_right_579:
  %t583 = load i8*, i8** %l20
  %t584 = load i8*, i8** %l20
  %t585 = call i64 @sailfin_runtime_string_length(i8* %t584)
  %t586 = sub i64 %t585, 1
  %t587 = getelementptr i8, i8* %t583, i64 %t586
  %t588 = load i8, i8* %t587
  %t589 = icmp eq i8 %t588, 93
  br label %logical_and_right_end_579

logical_and_right_end_579:
  br label %logical_and_merge_579

logical_and_merge_579:
  %t590 = phi i1 [ false, %logical_and_entry_579 ], [ %t589, %logical_and_right_end_579 ]
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t592 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t593 = load i8*, i8** %l2
  %t594 = load i8*, i8** %l3
  %t595 = load i1, i1* %l4
  %t596 = load double, double* %l5
  %t597 = load double, double* %l6
  %t598 = load i8*, i8** %l7
  %t599 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t600 = load i8*, i8** %l9
  %t601 = load i8*, i8** %l10
  %t602 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t603 = load i8*, i8** %l12
  %t604 = load i8*, i8** %l16
  %t605 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t606 = load i8*, i8** %l18
  %t607 = load double, double* %l19
  %t608 = load i8*, i8** %l20
  br i1 %t590, label %then36, label %else37
then36:
  %t609 = load i8*, i8** %l20
  %t610 = load i8*, i8** %l20
  %t611 = call i64 @sailfin_runtime_string_length(i8* %t610)
  %t612 = sub i64 %t611, 1
  %t613 = call i8* @sailfin_runtime_substring(i8* %t609, i64 2, i64 %t612)
  store i8* %t613, i8** %l22
  %t614 = load i8*, i8** %l22
  %t615 = call { i8**, i64 }* @parse_effect_list(i8* %t614)
  store { i8**, i64 }* %t615, { i8**, i64 }** %l17
  %t616 = load { i8**, i64 }*, { i8**, i64 }** %l17
  br label %merge38
else37:
  %t617 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s618 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t619 = call i8* @sailfin_runtime_string_concat(i8* %s618, i8* %interface_name)
  %s620 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t621 = call i8* @sailfin_runtime_string_concat(i8* %t619, i8* %s620)
  %t622 = load i8*, i8** %l9
  %t623 = call i8* @sailfin_runtime_string_concat(i8* %t621, i8* %t622)
  %s624 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h1377481172, i32 0, i32 0
  %t625 = call i8* @sailfin_runtime_string_concat(i8* %t623, i8* %s624)
  %t626 = load i8*, i8** %l20
  %t627 = call i8* @sailfin_runtime_string_concat(i8* %t625, i8* %t626)
  %t628 = alloca [2 x i8], align 1
  %t629 = getelementptr [2 x i8], [2 x i8]* %t628, i32 0, i32 0
  store i8 96, i8* %t629
  %t630 = getelementptr [2 x i8], [2 x i8]* %t628, i32 0, i32 1
  store i8 0, i8* %t630
  %t631 = getelementptr [2 x i8], [2 x i8]* %t628, i32 0, i32 0
  %t632 = call i8* @sailfin_runtime_string_concat(i8* %t627, i8* %t631)
  %t633 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t617, i8* %t632)
  store { i8**, i64 }* %t633, { i8**, i64 }** %l0
  %t634 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
merge38:
  %t635 = phi { i8**, i64 }* [ %t616, %then36 ], [ %t605, %else37 ]
  %t636 = phi { i8**, i64 }* [ %t591, %then36 ], [ %t634, %else37 ]
  store { i8**, i64 }* %t635, { i8**, i64 }** %l17
  store { i8**, i64 }* %t636, { i8**, i64 }** %l0
  %t637 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge35
merge35:
  %t639 = phi { i8**, i64 }* [ %t637, %merge38 ], [ %t575, %merge28 ]
  %t640 = phi { i8**, i64 }* [ %t638, %merge38 ], [ %t561, %merge28 ]
  store { i8**, i64 }* %t639, { i8**, i64 }** %l17
  store { i8**, i64 }* %t640, { i8**, i64 }** %l0
  %t641 = load i8*, i8** %l18
  %t642 = load i8*, i8** %l16
  %t643 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t645 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
merge24:
  %t646 = phi i8* [ %t641, %merge35 ], [ %t418, %merge13 ]
  %t647 = phi i8* [ %t642, %merge35 ], [ %t416, %merge13 ]
  %t648 = phi { i8**, i64 }* [ %t643, %merge35 ], [ %t403, %merge13 ]
  %t649 = phi { i8**, i64 }* [ %t644, %merge35 ], [ %t417, %merge13 ]
  %t650 = phi { i8**, i64 }* [ %t645, %merge35 ], [ %t403, %merge13 ]
  store i8* %t646, i8** %l18
  store i8* %t647, i8** %l16
  store { i8**, i64 }* %t648, { i8**, i64 }** %l0
  store { i8**, i64 }* %t649, { i8**, i64 }** %l17
  store { i8**, i64 }* %t650, { i8**, i64 }** %l0
  %t651 = load i8*, i8** %l9
  %t652 = insertvalue %NativeInterfaceSignature undef, i8* %t651, 0
  %t653 = load i1, i1* %l4
  %t654 = insertvalue %NativeInterfaceSignature %t652, i1 %t653, 1
  %t655 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t656 = extractvalue %HeaderNameParse %t655, 1
  %t657 = insertvalue %NativeInterfaceSignature %t654, { i8**, i64 }* %t656, 2
  %t658 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t659 = bitcast { %NativeParameter*, i64 }* %t658 to { %NativeParameter**, i64 }*
  %t660 = insertvalue %NativeInterfaceSignature %t657, { %NativeParameter**, i64 }* %t659, 3
  %t661 = load i8*, i8** %l16
  %t662 = insertvalue %NativeInterfaceSignature %t660, i8* %t661, 4
  %t663 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t664 = insertvalue %NativeInterfaceSignature %t662, { i8**, i64 }* %t663, 5
  store %NativeInterfaceSignature %t664, %NativeInterfaceSignature* %l23
  %t666 = load i8*, i8** %l9
  %t667 = call i64 @sailfin_runtime_string_length(i8* %t666)
  %t668 = icmp sgt i64 %t667, 0
  br label %logical_and_entry_665

logical_and_entry_665:
  br i1 %t668, label %logical_and_right_665, label %logical_and_merge_665

logical_and_right_665:
  %t669 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t670 = load { i8**, i64 }, { i8**, i64 }* %t669
  %t671 = extractvalue { i8**, i64 } %t670, 1
  %t672 = icmp eq i64 %t671, 0
  br label %logical_and_right_end_665

logical_and_right_end_665:
  br label %logical_and_merge_665

logical_and_merge_665:
  %t673 = phi i1 [ false, %logical_and_entry_665 ], [ %t672, %logical_and_right_end_665 ]
  store i1 %t673, i1* %l24
  %t674 = load i1, i1* %l24
  %t675 = insertvalue %InterfaceSignatureParse undef, i1 %t674, 0
  %t676 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l23
  %t677 = insertvalue %InterfaceSignatureParse %t675, %NativeInterfaceSignature %t676, 1
  %t678 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t679 = insertvalue %InterfaceSignatureParse %t677, { i8**, i64 }* %t678, 2
  ret %InterfaceSignatureParse %t679
}

define %HeaderNameParse @parse_header_name_and_remainder(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca { i8**, i64 }*
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
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
  %t12 = call i8* @trim_text(i8* %text)
  store i8* %t12, i8** %l1
  %t13 = load i8*, i8** %l1
  %t14 = call i64 @sailfin_runtime_string_length(i8* %t13)
  %t15 = icmp eq i64 %t14, 0
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  br i1 %t15, label %then0, label %merge1
then0:
  %s18 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t19 = insertvalue %HeaderNameParse undef, i8* %s18, 0
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
  %t32 = insertvalue %HeaderNameParse %t19, { i8**, i64 }* %t29, 1
  %s33 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t34 = insertvalue %HeaderNameParse %t32, i8* %s33, 2
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = insertvalue %HeaderNameParse %t34, { i8**, i64 }* %t35, 3
  ret %HeaderNameParse %t36
merge1:
  %t37 = load i8*, i8** %l1
  store i8* %t37, i8** %l2
  %s38 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s38, i8** %l3
  %t39 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t40 = ptrtoint [0 x i8*]* %t39 to i64
  %t41 = icmp eq i64 %t40, 0
  %t42 = select i1 %t41, i64 1, i64 %t40
  %t43 = call i8* @malloc(i64 %t42)
  %t44 = bitcast i8* %t43 to i8**
  %t45 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t46 = ptrtoint { i8**, i64 }* %t45 to i64
  %t47 = call i8* @malloc(i64 %t46)
  %t48 = bitcast i8* %t47 to { i8**, i64 }*
  %t49 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 0
  store i8** %t44, i8*** %t49
  %t50 = getelementptr { i8**, i64 }, { i8**, i64 }* %t48, i32 0, i32 1
  store i64 0, i64* %t50
  store { i8**, i64 }* %t48, { i8**, i64 }** %l4
  %t51 = load i8*, i8** %l1
  %t52 = alloca [2 x i8], align 1
  %t53 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  store i8 60, i8* %t53
  %t54 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 1
  store i8 0, i8* %t54
  %t55 = getelementptr [2 x i8], [2 x i8]* %t52, i32 0, i32 0
  %t56 = call double @index_of(i8* %t51, i8* %t55)
  store double %t56, double* %l5
  %t57 = load double, double* %l5
  %t58 = sitofp i64 0 to double
  %t59 = fcmp oge double %t57, %t58
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load i8*, i8** %l2
  %t63 = load i8*, i8** %l3
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t65 = load double, double* %l5
  br i1 %t59, label %then2, label %else3
then2:
  %t66 = load i8*, i8** %l1
  %t67 = load double, double* %l5
  %t68 = call double @find_matching_angle(i8* %t66, double %t67)
  store double %t68, double* %l6
  %t69 = load double, double* %l6
  %t70 = sitofp i64 0 to double
  %t71 = fcmp olt double %t69, %t70
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load i8*, i8** %l1
  %t74 = load i8*, i8** %l2
  %t75 = load i8*, i8** %l3
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t77 = load double, double* %l5
  %t78 = load double, double* %l6
  br i1 %t71, label %then5, label %merge6
then5:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s80 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h487238491, i32 0, i32 0
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %s80, i8* %text)
  %s82 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1187531435, i32 0, i32 0
  %t83 = call i8* @sailfin_runtime_string_concat(i8* %t81, i8* %s82)
  %t84 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t79, i8* %t83)
  store { i8**, i64 }* %t84, { i8**, i64 }** %l0
  %t85 = load i8*, i8** %l1
  %t86 = call i8* @strip_generics(i8* %t85)
  store i8* %t86, i8** %l2
  %t87 = load i8*, i8** %l2
  %t88 = insertvalue %HeaderNameParse undef, i8* %t87, 0
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t90 = insertvalue %HeaderNameParse %t88, { i8**, i64 }* %t89, 1
  %t91 = load i8*, i8** %l3
  %t92 = insertvalue %HeaderNameParse %t90, i8* %t91, 2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = insertvalue %HeaderNameParse %t92, { i8**, i64 }* %t93, 3
  ret %HeaderNameParse %t94
merge6:
  %t95 = load i8*, i8** %l1
  %t96 = load double, double* %l5
  %t97 = call double @llvm.round.f64(double %t96)
  %t98 = fptosi double %t97 to i64
  %t99 = call i8* @sailfin_runtime_substring(i8* %t95, i64 0, i64 %t98)
  %t100 = call i8* @trim_text(i8* %t99)
  store i8* %t100, i8** %l2
  %t101 = load i8*, i8** %l1
  %t102 = load double, double* %l5
  %t103 = sitofp i64 1 to double
  %t104 = fadd double %t102, %t103
  %t105 = load double, double* %l6
  %t106 = call double @llvm.round.f64(double %t104)
  %t107 = fptosi double %t106 to i64
  %t108 = call double @llvm.round.f64(double %t105)
  %t109 = fptosi double %t108 to i64
  %t110 = call i8* @sailfin_runtime_substring(i8* %t101, i64 %t107, i64 %t109)
  store i8* %t110, i8** %l7
  %t111 = load i8*, i8** %l7
  %t112 = call { i8**, i64 }* @parse_type_parameter_entries(i8* %t111)
  store { i8**, i64 }* %t112, { i8**, i64 }** %l4
  %t113 = load i8*, i8** %l1
  %t114 = load double, double* %l6
  %t115 = sitofp i64 1 to double
  %t116 = fadd double %t114, %t115
  %t117 = load i8*, i8** %l1
  %t118 = call i64 @sailfin_runtime_string_length(i8* %t117)
  %t119 = call double @llvm.round.f64(double %t116)
  %t120 = fptosi double %t119 to i64
  %t121 = call i8* @sailfin_runtime_substring(i8* %t113, i64 %t120, i64 %t118)
  %t122 = call i8* @trim_text(i8* %t121)
  store i8* %t122, i8** %l3
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load i8*, i8** %l2
  %t125 = load i8*, i8** %l2
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t127 = load i8*, i8** %l3
  br label %merge4
else3:
  %t128 = load i8*, i8** %l1
  %t129 = alloca [2 x i8], align 1
  %t130 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  store i8 32, i8* %t130
  %t131 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 1
  store i8 0, i8* %t131
  %t132 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  %t133 = call double @index_of(i8* %t128, i8* %t132)
  store double %t133, double* %l8
  %t134 = load double, double* %l8
  %t135 = sitofp i64 0 to double
  %t136 = fcmp oge double %t134, %t135
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t138 = load i8*, i8** %l1
  %t139 = load i8*, i8** %l2
  %t140 = load i8*, i8** %l3
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t142 = load double, double* %l5
  %t143 = load double, double* %l8
  br i1 %t136, label %then7, label %merge8
then7:
  %t144 = load i8*, i8** %l1
  %t145 = load double, double* %l8
  %t146 = call double @llvm.round.f64(double %t145)
  %t147 = fptosi double %t146 to i64
  %t148 = call i8* @sailfin_runtime_substring(i8* %t144, i64 0, i64 %t147)
  %t149 = call i8* @trim_text(i8* %t148)
  store i8* %t149, i8** %l2
  %t150 = load i8*, i8** %l1
  %t151 = load double, double* %l8
  %t152 = sitofp i64 1 to double
  %t153 = fadd double %t151, %t152
  %t154 = load i8*, i8** %l1
  %t155 = call i64 @sailfin_runtime_string_length(i8* %t154)
  %t156 = call double @llvm.round.f64(double %t153)
  %t157 = fptosi double %t156 to i64
  %t158 = call i8* @sailfin_runtime_substring(i8* %t150, i64 %t157, i64 %t155)
  %t159 = call i8* @trim_text(i8* %t158)
  store i8* %t159, i8** %l3
  %t160 = load i8*, i8** %l2
  %t161 = load i8*, i8** %l3
  br label %merge8
merge8:
  %t162 = phi i8* [ %t160, %then7 ], [ %t139, %else3 ]
  %t163 = phi i8* [ %t161, %then7 ], [ %t140, %else3 ]
  store i8* %t162, i8** %l2
  store i8* %t163, i8** %l3
  %t164 = load i8*, i8** %l2
  %t165 = load i8*, i8** %l3
  br label %merge4
merge4:
  %t166 = phi { i8**, i64 }* [ %t123, %merge6 ], [ %t60, %merge8 ]
  %t167 = phi i8* [ %t124, %merge6 ], [ %t164, %merge8 ]
  %t168 = phi { i8**, i64 }* [ %t126, %merge6 ], [ %t64, %merge8 ]
  %t169 = phi i8* [ %t127, %merge6 ], [ %t165, %merge8 ]
  store { i8**, i64 }* %t166, { i8**, i64 }** %l0
  store i8* %t167, i8** %l2
  store { i8**, i64 }* %t168, { i8**, i64 }** %l4
  store i8* %t169, i8** %l3
  %t170 = load i8*, i8** %l2
  %t171 = call i8* @strip_generics(i8* %t170)
  store i8* %t171, i8** %l2
  %t172 = load i8*, i8** %l2
  %t173 = insertvalue %HeaderNameParse undef, i8* %t172, 0
  %t174 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t175 = insertvalue %HeaderNameParse %t173, { i8**, i64 }* %t174, 1
  %t176 = load i8*, i8** %l3
  %t177 = insertvalue %HeaderNameParse %t175, i8* %t176, 2
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t179 = insertvalue %HeaderNameParse %t177, { i8**, i64 }* %t178, 3
  ret %HeaderNameParse %t179
}

define { i8**, i64 }* @parse_type_parameter_entries(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
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
  ret { i8**, i64 }* %t14
merge1:
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_top_level_commas(i8* %t17)
  ret { i8**, i64 }* %t18
}

define { i8**, i64 }* @parse_implements_list(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
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
  ret { i8**, i64 }* %t14
merge1:
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_top_level_commas(i8* %t17)
  ret { i8**, i64 }* %t18
}

define { i8**, i64 }* @split_top_level_commas(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca double
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca i8
  %l9 = alloca i8*
  %l10 = alloca i8*
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
  %s14 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s14, i8** %l3
  %t15 = sitofp i64 0 to double
  store double %t15, double* %l4
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l5
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l6
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l7
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t20 = load i8*, i8** %l1
  %t21 = load double, double* %l2
  %t22 = load i8*, i8** %l3
  %t23 = load double, double* %l4
  %t24 = load double, double* %l5
  %t25 = load double, double* %l6
  %t26 = load double, double* %l7
  br label %loop.header0
loop.header0:
  %t492 = phi i8* [ %t20, %block.entry ], [ %t484, %loop.latch2 ]
  %t493 = phi double [ %t21, %block.entry ], [ %t485, %loop.latch2 ]
  %t494 = phi i8* [ %t22, %block.entry ], [ %t486, %loop.latch2 ]
  %t495 = phi double [ %t23, %block.entry ], [ %t487, %loop.latch2 ]
  %t496 = phi double [ %t24, %block.entry ], [ %t488, %loop.latch2 ]
  %t497 = phi double [ %t25, %block.entry ], [ %t489, %loop.latch2 ]
  %t498 = phi double [ %t26, %block.entry ], [ %t490, %loop.latch2 ]
  %t499 = phi { i8**, i64 }* [ %t19, %block.entry ], [ %t491, %loop.latch2 ]
  store i8* %t492, i8** %l1
  store double %t493, double* %l2
  store i8* %t494, i8** %l3
  store double %t495, double* %l4
  store double %t496, double* %l5
  store double %t497, double* %l6
  store double %t498, double* %l7
  store { i8**, i64 }* %t499, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t27 = load double, double* %l2
  %t28 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t29 = sitofp i64 %t28 to double
  %t30 = fcmp oge double %t27, %t29
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load i8*, i8** %l3
  %t35 = load double, double* %l4
  %t36 = load double, double* %l5
  %t37 = load double, double* %l6
  %t38 = load double, double* %l7
  br i1 %t30, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t39 = load double, double* %l2
  %t40 = call double @llvm.round.f64(double %t39)
  %t41 = fptosi double %t40 to i64
  %t42 = getelementptr i8, i8* %text, i64 %t41
  %t43 = load i8, i8* %t42
  store i8 %t43, i8* %l8
  %t44 = load i8*, i8** %l3
  %t45 = call i64 @sailfin_runtime_string_length(i8* %t44)
  %t46 = icmp sgt i64 %t45, 0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t48 = load i8*, i8** %l1
  %t49 = load double, double* %l2
  %t50 = load i8*, i8** %l3
  %t51 = load double, double* %l4
  %t52 = load double, double* %l5
  %t53 = load double, double* %l6
  %t54 = load double, double* %l7
  %t55 = load i8, i8* %l8
  br i1 %t46, label %then6, label %merge7
then6:
  %t56 = load i8*, i8** %l1
  %t57 = load i8, i8* %l8
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 %t57, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  %t62 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t61)
  store i8* %t62, i8** %l1
  %t63 = load i8, i8* %l8
  %t64 = icmp eq i8 %t63, 92
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l1
  %t67 = load double, double* %l2
  %t68 = load i8*, i8** %l3
  %t69 = load double, double* %l4
  %t70 = load double, double* %l5
  %t71 = load double, double* %l6
  %t72 = load double, double* %l7
  %t73 = load i8, i8* %l8
  br i1 %t64, label %then8, label %merge9
then8:
  %t74 = load double, double* %l2
  %t75 = sitofp i64 1 to double
  %t76 = fadd double %t74, %t75
  %t77 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t78 = sitofp i64 %t77 to double
  %t79 = fcmp olt double %t76, %t78
  %t80 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t81 = load i8*, i8** %l1
  %t82 = load double, double* %l2
  %t83 = load i8*, i8** %l3
  %t84 = load double, double* %l4
  %t85 = load double, double* %l5
  %t86 = load double, double* %l6
  %t87 = load double, double* %l7
  %t88 = load i8, i8* %l8
  br i1 %t79, label %then10, label %merge11
then10:
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l2
  %t91 = sitofp i64 1 to double
  %t92 = fadd double %t90, %t91
  %t93 = call double @llvm.round.f64(double %t92)
  %t94 = fptosi double %t93 to i64
  %t95 = getelementptr i8, i8* %text, i64 %t94
  %t96 = load i8, i8* %t95
  %t97 = alloca [2 x i8], align 1
  %t98 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  store i8 %t96, i8* %t98
  %t99 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 1
  store i8 0, i8* %t99
  %t100 = getelementptr [2 x i8], [2 x i8]* %t97, i32 0, i32 0
  %t101 = call i8* @sailfin_runtime_string_concat(i8* %t89, i8* %t100)
  store i8* %t101, i8** %l1
  %t102 = load double, double* %l2
  %t103 = sitofp i64 2 to double
  %t104 = fadd double %t102, %t103
  store double %t104, double* %l2
  br label %loop.latch2
merge11:
  %t105 = load i8*, i8** %l1
  %t106 = load double, double* %l2
  br label %merge9
merge9:
  %t107 = phi i8* [ %t105, %merge11 ], [ %t66, %then6 ]
  %t108 = phi double [ %t106, %merge11 ], [ %t67, %then6 ]
  store i8* %t107, i8** %l1
  store double %t108, double* %l2
  %t109 = load i8, i8* %l8
  %t110 = load i8*, i8** %l3
  %t111 = load i8, i8* %t110
  %t112 = icmp eq i8 %t109, %t111
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load i8*, i8** %l1
  %t115 = load double, double* %l2
  %t116 = load i8*, i8** %l3
  %t117 = load double, double* %l4
  %t118 = load double, double* %l5
  %t119 = load double, double* %l6
  %t120 = load double, double* %l7
  %t121 = load i8, i8* %l8
  br i1 %t112, label %then12, label %merge13
then12:
  %s122 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s122, i8** %l3
  %t123 = load i8*, i8** %l3
  br label %merge13
merge13:
  %t124 = phi i8* [ %t123, %then12 ], [ %t116, %merge9 ]
  store i8* %t124, i8** %l3
  %t125 = load double, double* %l2
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l2
  br label %loop.latch2
merge7:
  %t129 = load i8, i8* %l8
  %t130 = icmp eq i8 %t129, 34
  br label %logical_or_entry_128

logical_or_entry_128:
  br i1 %t130, label %logical_or_merge_128, label %logical_or_right_128

logical_or_right_128:
  %t131 = load i8, i8* %l8
  %t132 = icmp eq i8 %t131, 39
  br label %logical_or_right_end_128

logical_or_right_end_128:
  br label %logical_or_merge_128

logical_or_merge_128:
  %t133 = phi i1 [ true, %logical_or_entry_128 ], [ %t132, %logical_or_right_end_128 ]
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t135 = load i8*, i8** %l1
  %t136 = load double, double* %l2
  %t137 = load i8*, i8** %l3
  %t138 = load double, double* %l4
  %t139 = load double, double* %l5
  %t140 = load double, double* %l6
  %t141 = load double, double* %l7
  %t142 = load i8, i8* %l8
  br i1 %t133, label %then14, label %merge15
then14:
  %t143 = load i8, i8* %l8
  %t144 = alloca [2 x i8], align 1
  %t145 = getelementptr [2 x i8], [2 x i8]* %t144, i32 0, i32 0
  store i8 %t143, i8* %t145
  %t146 = getelementptr [2 x i8], [2 x i8]* %t144, i32 0, i32 1
  store i8 0, i8* %t146
  %t147 = getelementptr [2 x i8], [2 x i8]* %t144, i32 0, i32 0
  store i8* %t147, i8** %l3
  %t148 = load i8*, i8** %l1
  %t149 = load i8, i8* %l8
  %t150 = alloca [2 x i8], align 1
  %t151 = getelementptr [2 x i8], [2 x i8]* %t150, i32 0, i32 0
  store i8 %t149, i8* %t151
  %t152 = getelementptr [2 x i8], [2 x i8]* %t150, i32 0, i32 1
  store i8 0, i8* %t152
  %t153 = getelementptr [2 x i8], [2 x i8]* %t150, i32 0, i32 0
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %t148, i8* %t153)
  store i8* %t154, i8** %l1
  %t155 = load double, double* %l2
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l2
  br label %loop.latch2
merge15:
  %t158 = load i8, i8* %l8
  %t159 = icmp eq i8 %t158, 60
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t161 = load i8*, i8** %l1
  %t162 = load double, double* %l2
  %t163 = load i8*, i8** %l3
  %t164 = load double, double* %l4
  %t165 = load double, double* %l5
  %t166 = load double, double* %l6
  %t167 = load double, double* %l7
  %t168 = load i8, i8* %l8
  br i1 %t159, label %then16, label %merge17
then16:
  %t169 = load double, double* %l4
  %t170 = sitofp i64 1 to double
  %t171 = fadd double %t169, %t170
  store double %t171, double* %l4
  %t172 = load i8*, i8** %l1
  %t173 = load i8, i8* %l8
  %t174 = alloca [2 x i8], align 1
  %t175 = getelementptr [2 x i8], [2 x i8]* %t174, i32 0, i32 0
  store i8 %t173, i8* %t175
  %t176 = getelementptr [2 x i8], [2 x i8]* %t174, i32 0, i32 1
  store i8 0, i8* %t176
  %t177 = getelementptr [2 x i8], [2 x i8]* %t174, i32 0, i32 0
  %t178 = call i8* @sailfin_runtime_string_concat(i8* %t172, i8* %t177)
  store i8* %t178, i8** %l1
  %t179 = load double, double* %l2
  %t180 = sitofp i64 1 to double
  %t181 = fadd double %t179, %t180
  store double %t181, double* %l2
  br label %loop.latch2
merge17:
  %t182 = load i8, i8* %l8
  %t183 = icmp eq i8 %t182, 62
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t185 = load i8*, i8** %l1
  %t186 = load double, double* %l2
  %t187 = load i8*, i8** %l3
  %t188 = load double, double* %l4
  %t189 = load double, double* %l5
  %t190 = load double, double* %l6
  %t191 = load double, double* %l7
  %t192 = load i8, i8* %l8
  br i1 %t183, label %then18, label %merge19
then18:
  %t193 = load double, double* %l4
  %t194 = sitofp i64 0 to double
  %t195 = fcmp ogt double %t193, %t194
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load i8*, i8** %l1
  %t198 = load double, double* %l2
  %t199 = load i8*, i8** %l3
  %t200 = load double, double* %l4
  %t201 = load double, double* %l5
  %t202 = load double, double* %l6
  %t203 = load double, double* %l7
  %t204 = load i8, i8* %l8
  br i1 %t195, label %then20, label %merge21
then20:
  %t205 = load double, double* %l4
  %t206 = sitofp i64 1 to double
  %t207 = fsub double %t205, %t206
  store double %t207, double* %l4
  %t208 = load double, double* %l4
  br label %merge21
merge21:
  %t209 = phi double [ %t208, %then20 ], [ %t200, %then18 ]
  store double %t209, double* %l4
  %t210 = load i8*, i8** %l1
  %t211 = load i8, i8* %l8
  %t212 = alloca [2 x i8], align 1
  %t213 = getelementptr [2 x i8], [2 x i8]* %t212, i32 0, i32 0
  store i8 %t211, i8* %t213
  %t214 = getelementptr [2 x i8], [2 x i8]* %t212, i32 0, i32 1
  store i8 0, i8* %t214
  %t215 = getelementptr [2 x i8], [2 x i8]* %t212, i32 0, i32 0
  %t216 = call i8* @sailfin_runtime_string_concat(i8* %t210, i8* %t215)
  store i8* %t216, i8** %l1
  %t217 = load double, double* %l2
  %t218 = sitofp i64 1 to double
  %t219 = fadd double %t217, %t218
  store double %t219, double* %l2
  br label %loop.latch2
merge19:
  %t220 = load i8, i8* %l8
  %t221 = icmp eq i8 %t220, 40
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t223 = load i8*, i8** %l1
  %t224 = load double, double* %l2
  %t225 = load i8*, i8** %l3
  %t226 = load double, double* %l4
  %t227 = load double, double* %l5
  %t228 = load double, double* %l6
  %t229 = load double, double* %l7
  %t230 = load i8, i8* %l8
  br i1 %t221, label %then22, label %merge23
then22:
  %t231 = load double, double* %l5
  %t232 = sitofp i64 1 to double
  %t233 = fadd double %t231, %t232
  store double %t233, double* %l5
  %t234 = load i8*, i8** %l1
  %t235 = load i8, i8* %l8
  %t236 = alloca [2 x i8], align 1
  %t237 = getelementptr [2 x i8], [2 x i8]* %t236, i32 0, i32 0
  store i8 %t235, i8* %t237
  %t238 = getelementptr [2 x i8], [2 x i8]* %t236, i32 0, i32 1
  store i8 0, i8* %t238
  %t239 = getelementptr [2 x i8], [2 x i8]* %t236, i32 0, i32 0
  %t240 = call i8* @sailfin_runtime_string_concat(i8* %t234, i8* %t239)
  store i8* %t240, i8** %l1
  %t241 = load double, double* %l2
  %t242 = sitofp i64 1 to double
  %t243 = fadd double %t241, %t242
  store double %t243, double* %l2
  br label %loop.latch2
merge23:
  %t244 = load i8, i8* %l8
  %t245 = icmp eq i8 %t244, 41
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t247 = load i8*, i8** %l1
  %t248 = load double, double* %l2
  %t249 = load i8*, i8** %l3
  %t250 = load double, double* %l4
  %t251 = load double, double* %l5
  %t252 = load double, double* %l6
  %t253 = load double, double* %l7
  %t254 = load i8, i8* %l8
  br i1 %t245, label %then24, label %merge25
then24:
  %t255 = load double, double* %l5
  %t256 = sitofp i64 0 to double
  %t257 = fcmp ogt double %t255, %t256
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t259 = load i8*, i8** %l1
  %t260 = load double, double* %l2
  %t261 = load i8*, i8** %l3
  %t262 = load double, double* %l4
  %t263 = load double, double* %l5
  %t264 = load double, double* %l6
  %t265 = load double, double* %l7
  %t266 = load i8, i8* %l8
  br i1 %t257, label %then26, label %merge27
then26:
  %t267 = load double, double* %l5
  %t268 = sitofp i64 1 to double
  %t269 = fsub double %t267, %t268
  store double %t269, double* %l5
  %t270 = load double, double* %l5
  br label %merge27
merge27:
  %t271 = phi double [ %t270, %then26 ], [ %t263, %then24 ]
  store double %t271, double* %l5
  %t272 = load i8*, i8** %l1
  %t273 = load i8, i8* %l8
  %t274 = alloca [2 x i8], align 1
  %t275 = getelementptr [2 x i8], [2 x i8]* %t274, i32 0, i32 0
  store i8 %t273, i8* %t275
  %t276 = getelementptr [2 x i8], [2 x i8]* %t274, i32 0, i32 1
  store i8 0, i8* %t276
  %t277 = getelementptr [2 x i8], [2 x i8]* %t274, i32 0, i32 0
  %t278 = call i8* @sailfin_runtime_string_concat(i8* %t272, i8* %t277)
  store i8* %t278, i8** %l1
  %t279 = load double, double* %l2
  %t280 = sitofp i64 1 to double
  %t281 = fadd double %t279, %t280
  store double %t281, double* %l2
  br label %loop.latch2
merge25:
  %t282 = load i8, i8* %l8
  %t283 = icmp eq i8 %t282, 91
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t285 = load i8*, i8** %l1
  %t286 = load double, double* %l2
  %t287 = load i8*, i8** %l3
  %t288 = load double, double* %l4
  %t289 = load double, double* %l5
  %t290 = load double, double* %l6
  %t291 = load double, double* %l7
  %t292 = load i8, i8* %l8
  br i1 %t283, label %then28, label %merge29
then28:
  %t293 = load double, double* %l6
  %t294 = sitofp i64 1 to double
  %t295 = fadd double %t293, %t294
  store double %t295, double* %l6
  %t296 = load i8*, i8** %l1
  %t297 = load i8, i8* %l8
  %t298 = alloca [2 x i8], align 1
  %t299 = getelementptr [2 x i8], [2 x i8]* %t298, i32 0, i32 0
  store i8 %t297, i8* %t299
  %t300 = getelementptr [2 x i8], [2 x i8]* %t298, i32 0, i32 1
  store i8 0, i8* %t300
  %t301 = getelementptr [2 x i8], [2 x i8]* %t298, i32 0, i32 0
  %t302 = call i8* @sailfin_runtime_string_concat(i8* %t296, i8* %t301)
  store i8* %t302, i8** %l1
  %t303 = load double, double* %l2
  %t304 = sitofp i64 1 to double
  %t305 = fadd double %t303, %t304
  store double %t305, double* %l2
  br label %loop.latch2
merge29:
  %t306 = load i8, i8* %l8
  %t307 = icmp eq i8 %t306, 93
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t309 = load i8*, i8** %l1
  %t310 = load double, double* %l2
  %t311 = load i8*, i8** %l3
  %t312 = load double, double* %l4
  %t313 = load double, double* %l5
  %t314 = load double, double* %l6
  %t315 = load double, double* %l7
  %t316 = load i8, i8* %l8
  br i1 %t307, label %then30, label %merge31
then30:
  %t317 = load double, double* %l6
  %t318 = sitofp i64 0 to double
  %t319 = fcmp ogt double %t317, %t318
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t321 = load i8*, i8** %l1
  %t322 = load double, double* %l2
  %t323 = load i8*, i8** %l3
  %t324 = load double, double* %l4
  %t325 = load double, double* %l5
  %t326 = load double, double* %l6
  %t327 = load double, double* %l7
  %t328 = load i8, i8* %l8
  br i1 %t319, label %then32, label %merge33
then32:
  %t329 = load double, double* %l6
  %t330 = sitofp i64 1 to double
  %t331 = fsub double %t329, %t330
  store double %t331, double* %l6
  %t332 = load double, double* %l6
  br label %merge33
merge33:
  %t333 = phi double [ %t332, %then32 ], [ %t326, %then30 ]
  store double %t333, double* %l6
  %t334 = load i8*, i8** %l1
  %t335 = load i8, i8* %l8
  %t336 = alloca [2 x i8], align 1
  %t337 = getelementptr [2 x i8], [2 x i8]* %t336, i32 0, i32 0
  store i8 %t335, i8* %t337
  %t338 = getelementptr [2 x i8], [2 x i8]* %t336, i32 0, i32 1
  store i8 0, i8* %t338
  %t339 = getelementptr [2 x i8], [2 x i8]* %t336, i32 0, i32 0
  %t340 = call i8* @sailfin_runtime_string_concat(i8* %t334, i8* %t339)
  store i8* %t340, i8** %l1
  %t341 = load double, double* %l2
  %t342 = sitofp i64 1 to double
  %t343 = fadd double %t341, %t342
  store double %t343, double* %l2
  br label %loop.latch2
merge31:
  %t344 = load i8, i8* %l8
  %t345 = icmp eq i8 %t344, 123
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t347 = load i8*, i8** %l1
  %t348 = load double, double* %l2
  %t349 = load i8*, i8** %l3
  %t350 = load double, double* %l4
  %t351 = load double, double* %l5
  %t352 = load double, double* %l6
  %t353 = load double, double* %l7
  %t354 = load i8, i8* %l8
  br i1 %t345, label %then34, label %merge35
then34:
  %t355 = load double, double* %l7
  %t356 = sitofp i64 1 to double
  %t357 = fadd double %t355, %t356
  store double %t357, double* %l7
  %t358 = load i8*, i8** %l1
  %t359 = load i8, i8* %l8
  %t360 = alloca [2 x i8], align 1
  %t361 = getelementptr [2 x i8], [2 x i8]* %t360, i32 0, i32 0
  store i8 %t359, i8* %t361
  %t362 = getelementptr [2 x i8], [2 x i8]* %t360, i32 0, i32 1
  store i8 0, i8* %t362
  %t363 = getelementptr [2 x i8], [2 x i8]* %t360, i32 0, i32 0
  %t364 = call i8* @sailfin_runtime_string_concat(i8* %t358, i8* %t363)
  store i8* %t364, i8** %l1
  %t365 = load double, double* %l2
  %t366 = sitofp i64 1 to double
  %t367 = fadd double %t365, %t366
  store double %t367, double* %l2
  br label %loop.latch2
merge35:
  %t368 = load i8, i8* %l8
  %t369 = icmp eq i8 %t368, 125
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t371 = load i8*, i8** %l1
  %t372 = load double, double* %l2
  %t373 = load i8*, i8** %l3
  %t374 = load double, double* %l4
  %t375 = load double, double* %l5
  %t376 = load double, double* %l6
  %t377 = load double, double* %l7
  %t378 = load i8, i8* %l8
  br i1 %t369, label %then36, label %merge37
then36:
  %t379 = load double, double* %l7
  %t380 = sitofp i64 0 to double
  %t381 = fcmp ogt double %t379, %t380
  %t382 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t383 = load i8*, i8** %l1
  %t384 = load double, double* %l2
  %t385 = load i8*, i8** %l3
  %t386 = load double, double* %l4
  %t387 = load double, double* %l5
  %t388 = load double, double* %l6
  %t389 = load double, double* %l7
  %t390 = load i8, i8* %l8
  br i1 %t381, label %then38, label %merge39
then38:
  %t391 = load double, double* %l7
  %t392 = sitofp i64 1 to double
  %t393 = fsub double %t391, %t392
  store double %t393, double* %l7
  %t394 = load double, double* %l7
  br label %merge39
merge39:
  %t395 = phi double [ %t394, %then38 ], [ %t389, %then36 ]
  store double %t395, double* %l7
  %t396 = load i8*, i8** %l1
  %t397 = load i8, i8* %l8
  %t398 = alloca [2 x i8], align 1
  %t399 = getelementptr [2 x i8], [2 x i8]* %t398, i32 0, i32 0
  store i8 %t397, i8* %t399
  %t400 = getelementptr [2 x i8], [2 x i8]* %t398, i32 0, i32 1
  store i8 0, i8* %t400
  %t401 = getelementptr [2 x i8], [2 x i8]* %t398, i32 0, i32 0
  %t402 = call i8* @sailfin_runtime_string_concat(i8* %t396, i8* %t401)
  store i8* %t402, i8** %l1
  %t403 = load double, double* %l2
  %t404 = sitofp i64 1 to double
  %t405 = fadd double %t403, %t404
  store double %t405, double* %l2
  br label %loop.latch2
merge37:
  %t406 = load i8, i8* %l8
  %t407 = icmp eq i8 %t406, 44
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t409 = load i8*, i8** %l1
  %t410 = load double, double* %l2
  %t411 = load i8*, i8** %l3
  %t412 = load double, double* %l4
  %t413 = load double, double* %l5
  %t414 = load double, double* %l6
  %t415 = load double, double* %l7
  %t416 = load i8, i8* %l8
  br i1 %t407, label %then40, label %merge41
then40:
  %t418 = load double, double* %l4
  %t419 = sitofp i64 0 to double
  %t420 = fcmp oeq double %t418, %t419
  br label %logical_and_entry_417

logical_and_entry_417:
  br i1 %t420, label %logical_and_right_417, label %logical_and_merge_417

logical_and_right_417:
  %t422 = load double, double* %l5
  %t423 = sitofp i64 0 to double
  %t424 = fcmp oeq double %t422, %t423
  br label %logical_and_entry_421

logical_and_entry_421:
  br i1 %t424, label %logical_and_right_421, label %logical_and_merge_421

logical_and_right_421:
  %t426 = load double, double* %l6
  %t427 = sitofp i64 0 to double
  %t428 = fcmp oeq double %t426, %t427
  br label %logical_and_entry_425

logical_and_entry_425:
  br i1 %t428, label %logical_and_right_425, label %logical_and_merge_425

logical_and_right_425:
  %t429 = load double, double* %l7
  %t430 = sitofp i64 0 to double
  %t431 = fcmp oeq double %t429, %t430
  br label %logical_and_right_end_425

logical_and_right_end_425:
  br label %logical_and_merge_425

logical_and_merge_425:
  %t432 = phi i1 [ false, %logical_and_entry_425 ], [ %t431, %logical_and_right_end_425 ]
  br label %logical_and_right_end_421

logical_and_right_end_421:
  br label %logical_and_merge_421

logical_and_merge_421:
  %t433 = phi i1 [ false, %logical_and_entry_421 ], [ %t432, %logical_and_right_end_421 ]
  br label %logical_and_right_end_417

logical_and_right_end_417:
  br label %logical_and_merge_417

logical_and_merge_417:
  %t434 = phi i1 [ false, %logical_and_entry_417 ], [ %t433, %logical_and_right_end_417 ]
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t436 = load i8*, i8** %l1
  %t437 = load double, double* %l2
  %t438 = load i8*, i8** %l3
  %t439 = load double, double* %l4
  %t440 = load double, double* %l5
  %t441 = load double, double* %l6
  %t442 = load double, double* %l7
  %t443 = load i8, i8* %l8
  br i1 %t434, label %then42, label %merge43
then42:
  %t444 = load i8*, i8** %l1
  %t445 = call i8* @trim_text(i8* %t444)
  store i8* %t445, i8** %l9
  %t446 = load i8*, i8** %l9
  %t447 = call i64 @sailfin_runtime_string_length(i8* %t446)
  %t448 = icmp sgt i64 %t447, 0
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t450 = load i8*, i8** %l1
  %t451 = load double, double* %l2
  %t452 = load i8*, i8** %l3
  %t453 = load double, double* %l4
  %t454 = load double, double* %l5
  %t455 = load double, double* %l6
  %t456 = load double, double* %l7
  %t457 = load i8, i8* %l8
  %t458 = load i8*, i8** %l9
  br i1 %t448, label %then44, label %merge45
then44:
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t460 = load i8*, i8** %l9
  %t461 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t459, i8* %t460)
  store { i8**, i64 }* %t461, { i8**, i64 }** %l0
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge45
merge45:
  %t463 = phi { i8**, i64 }* [ %t462, %then44 ], [ %t449, %then42 ]
  store { i8**, i64 }* %t463, { i8**, i64 }** %l0
  %s464 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s464, i8** %l1
  %t465 = load double, double* %l2
  %t466 = sitofp i64 1 to double
  %t467 = fadd double %t465, %t466
  store double %t467, double* %l2
  br label %loop.latch2
merge43:
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t469 = load i8*, i8** %l1
  %t470 = load double, double* %l2
  br label %merge41
merge41:
  %t471 = phi { i8**, i64 }* [ %t468, %merge43 ], [ %t408, %merge37 ]
  %t472 = phi i8* [ %t469, %merge43 ], [ %t409, %merge37 ]
  %t473 = phi double [ %t470, %merge43 ], [ %t410, %merge37 ]
  store { i8**, i64 }* %t471, { i8**, i64 }** %l0
  store i8* %t472, i8** %l1
  store double %t473, double* %l2
  %t474 = load i8*, i8** %l1
  %t475 = load i8, i8* %l8
  %t476 = alloca [2 x i8], align 1
  %t477 = getelementptr [2 x i8], [2 x i8]* %t476, i32 0, i32 0
  store i8 %t475, i8* %t477
  %t478 = getelementptr [2 x i8], [2 x i8]* %t476, i32 0, i32 1
  store i8 0, i8* %t478
  %t479 = getelementptr [2 x i8], [2 x i8]* %t476, i32 0, i32 0
  %t480 = call i8* @sailfin_runtime_string_concat(i8* %t474, i8* %t479)
  store i8* %t480, i8** %l1
  %t481 = load double, double* %l2
  %t482 = sitofp i64 1 to double
  %t483 = fadd double %t481, %t482
  store double %t483, double* %l2
  br label %loop.latch2
loop.latch2:
  %t484 = load i8*, i8** %l1
  %t485 = load double, double* %l2
  %t486 = load i8*, i8** %l3
  %t487 = load double, double* %l4
  %t488 = load double, double* %l5
  %t489 = load double, double* %l6
  %t490 = load double, double* %l7
  %t491 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t500 = load i8*, i8** %l1
  %t501 = load double, double* %l2
  %t502 = load i8*, i8** %l3
  %t503 = load double, double* %l4
  %t504 = load double, double* %l5
  %t505 = load double, double* %l6
  %t506 = load double, double* %l7
  %t507 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t508 = load i8*, i8** %l1
  %t509 = call i8* @trim_text(i8* %t508)
  store i8* %t509, i8** %l10
  %t510 = load i8*, i8** %l10
  %t511 = call i64 @sailfin_runtime_string_length(i8* %t510)
  %t512 = icmp sgt i64 %t511, 0
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t514 = load i8*, i8** %l1
  %t515 = load double, double* %l2
  %t516 = load i8*, i8** %l3
  %t517 = load double, double* %l4
  %t518 = load double, double* %l5
  %t519 = load double, double* %l6
  %t520 = load double, double* %l7
  %t521 = load i8*, i8** %l10
  br i1 %t512, label %then46, label %merge47
then46:
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t523 = load i8*, i8** %l10
  %t524 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t522, i8* %t523)
  store { i8**, i64 }* %t524, { i8**, i64 }** %l0
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge47
merge47:
  %t526 = phi { i8**, i64 }* [ %t525, %then46 ], [ %t513, %afterloop3 ]
  store { i8**, i64 }* %t526, { i8**, i64 }** %l0
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t527
}

define double @find_matching_angle(i8* %text, double %start_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %start_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t55 = phi double [ %t1, %block.entry ], [ %t53, %loop.latch2 ]
  %t56 = phi double [ %t2, %block.entry ], [ %t54, %loop.latch2 ]
  store double %t55, double* %l0
  store double %t56, double* %l1
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
  %t10 = call double @llvm.round.f64(double %t9)
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %text, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t14 = load i8, i8* %l2
  %t15 = icmp eq i8 %t14, 60
  %t16 = load double, double* %l0
  %t17 = load double, double* %l1
  %t18 = load i8, i8* %l2
  br i1 %t15, label %then6, label %else7
then6:
  %t19 = load double, double* %l0
  %t20 = sitofp i64 1 to double
  %t21 = fadd double %t19, %t20
  store double %t21, double* %l0
  %t22 = load double, double* %l0
  br label %merge8
else7:
  %t23 = load i8, i8* %l2
  %t24 = icmp eq i8 %t23, 62
  %t25 = load double, double* %l0
  %t26 = load double, double* %l1
  %t27 = load i8, i8* %l2
  br i1 %t24, label %then9, label %merge10
then9:
  %t28 = load double, double* %l0
  %t29 = sitofp i64 0 to double
  %t30 = fcmp ogt double %t28, %t29
  %t31 = load double, double* %l0
  %t32 = load double, double* %l1
  %t33 = load i8, i8* %l2
  br i1 %t30, label %then11, label %else12
then11:
  %t34 = load double, double* %l0
  %t35 = sitofp i64 1 to double
  %t36 = fsub double %t34, %t35
  store double %t36, double* %l0
  %t37 = load double, double* %l0
  %t38 = sitofp i64 0 to double
  %t39 = fcmp oeq double %t37, %t38
  %t40 = load double, double* %l0
  %t41 = load double, double* %l1
  %t42 = load i8, i8* %l2
  br i1 %t39, label %then14, label %merge15
then14:
  %t43 = load double, double* %l1
  ret double %t43
merge15:
  %t44 = load double, double* %l0
  br label %merge13
else12:
  %t45 = load double, double* %l1
  ret double %t45
merge13:
  %t46 = load double, double* %l0
  br label %merge10
merge10:
  %t47 = phi double [ %t46, %merge13 ], [ %t25, %else7 ]
  store double %t47, double* %l0
  %t48 = load double, double* %l0
  br label %merge8
merge8:
  %t49 = phi double [ %t22, %then6 ], [ %t48, %merge10 ]
  store double %t49, double* %l0
  %t50 = load double, double* %l1
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l1
  br label %loop.latch2
loop.latch2:
  %t53 = load double, double* %l0
  %t54 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t57 = load double, double* %l0
  %t58 = load double, double* %l1
  %t59 = sitofp i64 -1 to double
  ret double %t59
}

define double @find_matching_paren(i8* %text, double %start_index) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca double
  %l4 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  store double %start_index, double* %l1
  %t1 = load double, double* %l0
  %t2 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t118 = phi double [ %t2, %block.entry ], [ %t116, %loop.latch2 ]
  %t119 = phi double [ %t1, %block.entry ], [ %t117, %loop.latch2 ]
  store double %t118, double* %l1
  store double %t119, double* %l0
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
  %t10 = call double @llvm.round.f64(double %t9)
  %t11 = fptosi double %t10 to i64
  %t12 = getelementptr i8, i8* %text, i64 %t11
  %t13 = load i8, i8* %t12
  store i8 %t13, i8* %l2
  %t15 = load i8, i8* %l2
  %t16 = icmp eq i8 %t15, 34
  br label %logical_or_entry_14

logical_or_entry_14:
  br i1 %t16, label %logical_or_merge_14, label %logical_or_right_14

logical_or_right_14:
  %t17 = load i8, i8* %l2
  %t18 = icmp eq i8 %t17, 39
  br label %logical_or_right_end_14

logical_or_right_end_14:
  br label %logical_or_merge_14

logical_or_merge_14:
  %t19 = phi i1 [ true, %logical_or_entry_14 ], [ %t18, %logical_or_right_end_14 ]
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load i8, i8* %l2
  br i1 %t19, label %then6, label %else7
then6:
  %t23 = load double, double* %l1
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l3
  %t26 = load double, double* %l0
  %t27 = load double, double* %l1
  %t28 = load i8, i8* %l2
  %t29 = load double, double* %l3
  br label %loop.header9
loop.header9:
  %t68 = phi double [ %t29, %then6 ], [ %t66, %loop.latch11 ]
  %t69 = phi double [ %t27, %then6 ], [ %t67, %loop.latch11 ]
  store double %t68, double* %l3
  store double %t69, double* %l1
  br label %loop.body10
loop.body10:
  %t30 = load double, double* %l3
  %t31 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t32 = sitofp i64 %t31 to double
  %t33 = fcmp oge double %t30, %t32
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  %t36 = load i8, i8* %l2
  %t37 = load double, double* %l3
  br i1 %t33, label %then13, label %merge14
then13:
  %t38 = sitofp i64 -1 to double
  ret double %t38
merge14:
  %t39 = load double, double* %l3
  %t40 = call double @llvm.round.f64(double %t39)
  %t41 = fptosi double %t40 to i64
  %t42 = getelementptr i8, i8* %text, i64 %t41
  %t43 = load i8, i8* %t42
  store i8 %t43, i8* %l4
  %t44 = load i8, i8* %l4
  %t45 = icmp eq i8 %t44, 92
  %t46 = load double, double* %l0
  %t47 = load double, double* %l1
  %t48 = load i8, i8* %l2
  %t49 = load double, double* %l3
  %t50 = load i8, i8* %l4
  br i1 %t45, label %then15, label %merge16
then15:
  %t51 = load double, double* %l3
  %t52 = sitofp i64 2 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l3
  br label %loop.latch11
merge16:
  %t54 = load i8, i8* %l4
  %t55 = load i8, i8* %l2
  %t56 = icmp eq i8 %t54, %t55
  %t57 = load double, double* %l0
  %t58 = load double, double* %l1
  %t59 = load i8, i8* %l2
  %t60 = load double, double* %l3
  %t61 = load i8, i8* %l4
  br i1 %t56, label %then17, label %merge18
then17:
  %t62 = load double, double* %l3
  store double %t62, double* %l1
  br label %afterloop12
merge18:
  %t63 = load double, double* %l3
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %t63, %t64
  store double %t65, double* %l3
  br label %loop.latch11
loop.latch11:
  %t66 = load double, double* %l3
  %t67 = load double, double* %l1
  br label %loop.header9
afterloop12:
  %t70 = load double, double* %l3
  %t71 = load double, double* %l1
  %t72 = load double, double* %l1
  br label %merge8
else7:
  %t73 = load i8, i8* %l2
  %t74 = icmp eq i8 %t73, 40
  %t75 = load double, double* %l0
  %t76 = load double, double* %l1
  %t77 = load i8, i8* %l2
  br i1 %t74, label %then19, label %else20
then19:
  %t78 = load double, double* %l0
  %t79 = sitofp i64 1 to double
  %t80 = fadd double %t78, %t79
  store double %t80, double* %l0
  %t81 = load double, double* %l0
  br label %merge21
else20:
  %t82 = load i8, i8* %l2
  %t83 = icmp eq i8 %t82, 41
  %t84 = load double, double* %l0
  %t85 = load double, double* %l1
  %t86 = load i8, i8* %l2
  br i1 %t83, label %then22, label %merge23
then22:
  %t87 = load double, double* %l0
  %t88 = sitofp i64 0 to double
  %t89 = fcmp ogt double %t87, %t88
  %t90 = load double, double* %l0
  %t91 = load double, double* %l1
  %t92 = load i8, i8* %l2
  br i1 %t89, label %then24, label %else25
then24:
  %t93 = load double, double* %l0
  %t94 = sitofp i64 1 to double
  %t95 = fsub double %t93, %t94
  store double %t95, double* %l0
  %t96 = load double, double* %l0
  %t97 = sitofp i64 0 to double
  %t98 = fcmp oeq double %t96, %t97
  %t99 = load double, double* %l0
  %t100 = load double, double* %l1
  %t101 = load i8, i8* %l2
  br i1 %t98, label %then27, label %merge28
then27:
  %t102 = load double, double* %l1
  ret double %t102
merge28:
  %t103 = load double, double* %l0
  br label %merge26
else25:
  %t104 = sitofp i64 -1 to double
  ret double %t104
merge26:
  %t105 = load double, double* %l0
  br label %merge23
merge23:
  %t106 = phi double [ %t105, %merge26 ], [ %t84, %else20 ]
  store double %t106, double* %l0
  %t107 = load double, double* %l0
  br label %merge21
merge21:
  %t108 = phi double [ %t81, %then19 ], [ %t107, %merge23 ]
  store double %t108, double* %l0
  %t109 = load double, double* %l0
  %t110 = load double, double* %l0
  br label %merge8
merge8:
  %t111 = phi double [ %t72, %afterloop12 ], [ %t21, %merge21 ]
  %t112 = phi double [ %t20, %afterloop12 ], [ %t109, %merge21 ]
  store double %t111, double* %l1
  store double %t112, double* %l0
  %t113 = load double, double* %l1
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  store double %t115, double* %l1
  br label %loop.latch2
loop.latch2:
  %t116 = load double, double* %l1
  %t117 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t120 = load double, double* %l1
  %t121 = load double, double* %l0
  %t122 = sitofp i64 -1 to double
  ret double %t122
}

define %EnumParseResult @parse_enum_definition({ i8**, i64 }* %lines, double %start_index) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca i8*
  %l3 = alloca i8*
  %l4 = alloca double
  %l5 = alloca { %NativeEnumVariant*, i64 }*
  %l6 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca i1
  %l13 = alloca i1
  %l14 = alloca double
  %l15 = alloca %NativeEnumLayout*
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca %EnumLayoutHeaderParse
  %l19 = alloca %EnumLayoutVariantParse
  %l20 = alloca double
  %l21 = alloca %EnumLayoutPayloadParse
  %l22 = alloca double
  %l23 = alloca %NativeEnumVariant*
  %l24 = alloca %NativeEnumLayout*
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
  %t12 = call double @llvm.round.f64(double %start_index)
  %t13 = fptosi double %t12 to i64
  %t14 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t15 = extractvalue { i8**, i64 } %t14, 0
  %t16 = extractvalue { i8**, i64 } %t14, 1
  %t17 = icmp uge i64 %t13, %t16
  ; bounds check: %t17 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t13, i64 %t16)
  %t18 = getelementptr i8*, i8** %t15, i64 %t13
  %t19 = load i8*, i8** %t18
  %t20 = call i8* @trim_text(i8* %t19)
  store i8* %t20, i8** %l1
  %t21 = load i8*, i8** %l1
  %s22 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280947313, i32 0, i32 0
  %t23 = call i8* @strip_prefix(i8* %t21, i8* %s22)
  %t24 = call i8* @trim_text(i8* %t23)
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l2
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l3
  %t27 = alloca [2 x i8], align 1
  %t28 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  store i8 32, i8* %t28
  %t29 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 1
  store i8 0, i8* %t29
  %t30 = getelementptr [2 x i8], [2 x i8]* %t27, i32 0, i32 0
  %t31 = call double @index_of(i8* %t26, i8* %t30)
  store double %t31, double* %l4
  %t32 = load double, double* %l4
  %t33 = sitofp i64 0 to double
  %t34 = fcmp oge double %t32, %t33
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = load i8*, i8** %l2
  %t38 = load i8*, i8** %l3
  %t39 = load double, double* %l4
  br i1 %t34, label %then0, label %merge1
then0:
  %t40 = load i8*, i8** %l3
  %t41 = load double, double* %l4
  %t42 = call double @llvm.round.f64(double %t41)
  %t43 = fptosi double %t42 to i64
  %t44 = call i8* @sailfin_runtime_substring(i8* %t40, i64 0, i64 %t43)
  %t45 = call i8* @trim_text(i8* %t44)
  store i8* %t45, i8** %l3
  %t46 = load i8*, i8** %l3
  br label %merge1
merge1:
  %t47 = phi i8* [ %t46, %then0 ], [ %t38, %block.entry ]
  store i8* %t47, i8** %l3
  %t48 = load i8*, i8** %l3
  %t49 = call i8* @strip_generics(i8* %t48)
  store i8* %t49, i8** %l3
  %t50 = load i8*, i8** %l3
  %t51 = call i64 @sailfin_runtime_string_length(i8* %t50)
  %t52 = icmp eq i64 %t51, 0
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load i8*, i8** %l2
  %t56 = load i8*, i8** %l3
  %t57 = load double, double* %l4
  br i1 %t52, label %then2, label %merge3
then2:
  %t58 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s59 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h668562564, i32 0, i32 0
  %t60 = load i8*, i8** %l1
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %s59, i8* %t60)
  %t62 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t58, i8* %t61)
  store { i8**, i64 }* %t62, { i8**, i64 }** %l0
  %t63 = bitcast i8* null to %NativeEnum*
  %t64 = insertvalue %EnumParseResult undef, %NativeEnum* %t63, 0
  %t65 = sitofp i64 1 to double
  %t66 = fadd double %start_index, %t65
  %t67 = insertvalue %EnumParseResult %t64, double %t66, 1
  %t68 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t69 = insertvalue %EnumParseResult %t67, { i8**, i64 }* %t68, 2
  ret %EnumParseResult %t69
merge3:
  %t70 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* null, i32 1
  %t71 = ptrtoint [0 x %NativeEnumVariant]* %t70 to i64
  %t72 = icmp eq i64 %t71, 0
  %t73 = select i1 %t72, i64 1, i64 %t71
  %t74 = call i8* @malloc(i64 %t73)
  %t75 = bitcast i8* %t74 to %NativeEnumVariant*
  %t76 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* null, i32 1
  %t77 = ptrtoint { %NativeEnumVariant*, i64 }* %t76 to i64
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to { %NativeEnumVariant*, i64 }*
  %t80 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t79, i32 0, i32 0
  store %NativeEnumVariant* %t75, %NativeEnumVariant** %t80
  %t81 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t79, i32 0, i32 1
  store i64 0, i64* %t81
  store { %NativeEnumVariant*, i64 }* %t79, { %NativeEnumVariant*, i64 }** %l5
  %t82 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t83 = ptrtoint [0 x %NativeEnumVariantLayout]* %t82 to i64
  %t84 = icmp eq i64 %t83, 0
  %t85 = select i1 %t84, i64 1, i64 %t83
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to %NativeEnumVariantLayout*
  %t88 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t89 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t88 to i64
  %t90 = call i8* @malloc(i64 %t89)
  %t91 = bitcast i8* %t90 to { %NativeEnumVariantLayout*, i64 }*
  %t92 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t91, i32 0, i32 0
  store %NativeEnumVariantLayout* %t87, %NativeEnumVariantLayout** %t92
  %t93 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t91, i32 0, i32 1
  store i64 0, i64* %t93
  store { %NativeEnumVariantLayout*, i64 }* %t91, { %NativeEnumVariantLayout*, i64 }** %l6
  %t94 = sitofp i64 0 to double
  store double %t94, double* %l7
  %t95 = sitofp i64 0 to double
  store double %t95, double* %l8
  %s96 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s96, i8** %l9
  %t97 = sitofp i64 0 to double
  store double %t97, double* %l10
  %t98 = sitofp i64 0 to double
  store double %t98, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t99 = sitofp i64 1 to double
  %t100 = fadd double %start_index, %t99
  store double %t100, double* %l14
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load i8*, i8** %l1
  %t103 = load i8*, i8** %l2
  %t104 = load i8*, i8** %l3
  %t105 = load double, double* %l4
  %t106 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t107 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t108 = load double, double* %l7
  %t109 = load double, double* %l8
  %t110 = load i8*, i8** %l9
  %t111 = load double, double* %l10
  %t112 = load double, double* %l11
  %t113 = load i1, i1* %l12
  %t114 = load i1, i1* %l13
  %t115 = load double, double* %l14
  br label %loop.header4
loop.header4:
  %t822 = phi { i8**, i64 }* [ %t101, %merge3 ], [ %t811, %loop.latch6 ]
  %t823 = phi double [ %t115, %merge3 ], [ %t812, %loop.latch6 ]
  %t824 = phi double [ %t108, %merge3 ], [ %t813, %loop.latch6 ]
  %t825 = phi double [ %t109, %merge3 ], [ %t814, %loop.latch6 ]
  %t826 = phi i8* [ %t110, %merge3 ], [ %t815, %loop.latch6 ]
  %t827 = phi double [ %t111, %merge3 ], [ %t816, %loop.latch6 ]
  %t828 = phi double [ %t112, %merge3 ], [ %t817, %loop.latch6 ]
  %t829 = phi i1 [ %t113, %merge3 ], [ %t818, %loop.latch6 ]
  %t830 = phi { %NativeEnumVariantLayout*, i64 }* [ %t107, %merge3 ], [ %t819, %loop.latch6 ]
  %t831 = phi i1 [ %t114, %merge3 ], [ %t820, %loop.latch6 ]
  %t832 = phi { %NativeEnumVariant*, i64 }* [ %t106, %merge3 ], [ %t821, %loop.latch6 ]
  store { i8**, i64 }* %t822, { i8**, i64 }** %l0
  store double %t823, double* %l14
  store double %t824, double* %l7
  store double %t825, double* %l8
  store i8* %t826, i8** %l9
  store double %t827, double* %l10
  store double %t828, double* %l11
  store i1 %t829, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t830, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t831, i1* %l13
  store { %NativeEnumVariant*, i64 }* %t832, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t116 = load double, double* %l14
  %t117 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t118 = extractvalue { i8**, i64 } %t117, 1
  %t119 = sitofp i64 %t118 to double
  %t120 = fcmp oge double %t116, %t119
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t122 = load i8*, i8** %l1
  %t123 = load i8*, i8** %l2
  %t124 = load i8*, i8** %l3
  %t125 = load double, double* %l4
  %t126 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t127 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t128 = load double, double* %l7
  %t129 = load double, double* %l8
  %t130 = load i8*, i8** %l9
  %t131 = load double, double* %l10
  %t132 = load double, double* %l11
  %t133 = load i1, i1* %l12
  %t134 = load i1, i1* %l13
  %t135 = load double, double* %l14
  br i1 %t120, label %then8, label %merge9
then8:
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s137 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1997941781, i32 0, i32 0
  %t138 = load i8*, i8** %l3
  %t139 = call i8* @sailfin_runtime_string_concat(i8* %s137, i8* %t138)
  %t140 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t136, i8* %t139)
  store { i8**, i64 }* %t140, { i8**, i64 }** %l0
  %t141 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t141, %NativeEnumLayout** %l15
  %t142 = load i1, i1* %l12
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = load i8*, i8** %l1
  %t145 = load i8*, i8** %l2
  %t146 = load i8*, i8** %l3
  %t147 = load double, double* %l4
  %t148 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t149 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t150 = load double, double* %l7
  %t151 = load double, double* %l8
  %t152 = load i8*, i8** %l9
  %t153 = load double, double* %l10
  %t154 = load double, double* %l11
  %t155 = load i1, i1* %l12
  %t156 = load i1, i1* %l13
  %t157 = load double, double* %l14
  %t158 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br i1 %t142, label %then10, label %merge11
then10:
  %t159 = load double, double* %l7
  %t160 = insertvalue %NativeEnumLayout undef, double %t159, 0
  %t161 = load double, double* %l8
  %t162 = insertvalue %NativeEnumLayout %t160, double %t161, 1
  %t163 = load i8*, i8** %l9
  %t164 = insertvalue %NativeEnumLayout %t162, i8* %t163, 2
  %t165 = load double, double* %l10
  %t166 = insertvalue %NativeEnumLayout %t164, double %t165, 3
  %t167 = load double, double* %l11
  %t168 = insertvalue %NativeEnumLayout %t166, double %t167, 4
  %t169 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t170 = bitcast { %NativeEnumVariantLayout*, i64 }* %t169 to { %NativeEnumVariantLayout**, i64 }*
  %t171 = insertvalue %NativeEnumLayout %t168, { %NativeEnumVariantLayout**, i64 }* %t170, 5
  %t172 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t171, %NativeEnumLayout* %t172
  store %NativeEnumLayout* %t172, %NativeEnumLayout** %l15
  %t173 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br label %merge11
merge11:
  %t174 = phi %NativeEnumLayout* [ %t173, %then10 ], [ %t158, %then8 ]
  store %NativeEnumLayout* %t174, %NativeEnumLayout** %l15
  %t175 = load i8*, i8** %l3
  %t176 = insertvalue %NativeEnum undef, i8* %t175, 0
  %t177 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t178 = bitcast { %NativeEnumVariant*, i64 }* %t177 to { %NativeEnumVariant**, i64 }*
  %t179 = insertvalue %NativeEnum %t176, { %NativeEnumVariant**, i64 }* %t178, 1
  %t180 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  %t181 = insertvalue %NativeEnum %t179, %NativeEnumLayout* %t180, 2
  %t182 = alloca %NativeEnum
  store %NativeEnum %t181, %NativeEnum* %t182
  %t183 = insertvalue %EnumParseResult undef, %NativeEnum* %t182, 0
  %t184 = load double, double* %l14
  %t185 = insertvalue %EnumParseResult %t183, double %t184, 1
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t187 = insertvalue %EnumParseResult %t185, { i8**, i64 }* %t186, 2
  ret %EnumParseResult %t187
merge9:
  %t188 = load double, double* %l14
  %t189 = call double @llvm.round.f64(double %t188)
  %t190 = fptosi double %t189 to i64
  %t191 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t192 = extractvalue { i8**, i64 } %t191, 0
  %t193 = extractvalue { i8**, i64 } %t191, 1
  %t194 = icmp uge i64 %t190, %t193
  ; bounds check: %t194 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t190, i64 %t193)
  %t195 = getelementptr i8*, i8** %t192, i64 %t190
  %t196 = load i8*, i8** %t195
  %t197 = call i8* @trim_text(i8* %t196)
  store i8* %t197, i8** %l16
  %t199 = load i8*, i8** %l16
  %t200 = call i64 @sailfin_runtime_string_length(i8* %t199)
  %t201 = icmp eq i64 %t200, 0
  br label %logical_or_entry_198

logical_or_entry_198:
  br i1 %t201, label %logical_or_merge_198, label %logical_or_right_198

logical_or_right_198:
  %t202 = load i8*, i8** %l16
  %t203 = alloca [2 x i8], align 1
  %t204 = getelementptr [2 x i8], [2 x i8]* %t203, i32 0, i32 0
  store i8 59, i8* %t204
  %t205 = getelementptr [2 x i8], [2 x i8]* %t203, i32 0, i32 1
  store i8 0, i8* %t205
  %t206 = getelementptr [2 x i8], [2 x i8]* %t203, i32 0, i32 0
  %t207 = call i1 @starts_with(i8* %t202, i8* %t206)
  br label %logical_or_right_end_198

logical_or_right_end_198:
  br label %logical_or_merge_198

logical_or_merge_198:
  %t208 = phi i1 [ true, %logical_or_entry_198 ], [ %t207, %logical_or_right_end_198 ]
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t210 = load i8*, i8** %l1
  %t211 = load i8*, i8** %l2
  %t212 = load i8*, i8** %l3
  %t213 = load double, double* %l4
  %t214 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t215 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t216 = load double, double* %l7
  %t217 = load double, double* %l8
  %t218 = load i8*, i8** %l9
  %t219 = load double, double* %l10
  %t220 = load double, double* %l11
  %t221 = load i1, i1* %l12
  %t222 = load i1, i1* %l13
  %t223 = load double, double* %l14
  %t224 = load i8*, i8** %l16
  br i1 %t208, label %then12, label %merge13
then12:
  %t225 = load double, double* %l14
  %t226 = sitofp i64 1 to double
  %t227 = fadd double %t225, %t226
  store double %t227, double* %l14
  br label %loop.latch6
merge13:
  %t228 = load i8*, i8** %l16
  %s229 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t230 = call i1 @strings_equal(i8* %t228, i8* %s229)
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t232 = load i8*, i8** %l1
  %t233 = load i8*, i8** %l2
  %t234 = load i8*, i8** %l3
  %t235 = load double, double* %l4
  %t236 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t237 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t238 = load double, double* %l7
  %t239 = load double, double* %l8
  %t240 = load i8*, i8** %l9
  %t241 = load double, double* %l10
  %t242 = load double, double* %l11
  %t243 = load i1, i1* %l12
  %t244 = load i1, i1* %l13
  %t245 = load double, double* %l14
  %t246 = load i8*, i8** %l16
  br i1 %t230, label %then14, label %merge15
then14:
  %t247 = load double, double* %l14
  %t248 = sitofp i64 1 to double
  %t249 = fadd double %t247, %t248
  store double %t249, double* %l14
  br label %loop.latch6
merge15:
  %t250 = load i8*, i8** %l16
  %s251 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t252 = call i1 @starts_with(i8* %t250, i8* %s251)
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t254 = load i8*, i8** %l1
  %t255 = load i8*, i8** %l2
  %t256 = load i8*, i8** %l3
  %t257 = load double, double* %l4
  %t258 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t259 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t260 = load double, double* %l7
  %t261 = load double, double* %l8
  %t262 = load i8*, i8** %l9
  %t263 = load double, double* %l10
  %t264 = load double, double* %l11
  %t265 = load i1, i1* %l12
  %t266 = load i1, i1* %l13
  %t267 = load double, double* %l14
  %t268 = load i8*, i8** %l16
  br i1 %t252, label %then16, label %merge17
then16:
  %t269 = load i8*, i8** %l16
  %s270 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t271 = call i8* @strip_prefix(i8* %t269, i8* %s270)
  store i8* %t271, i8** %l17
  %t272 = load i8*, i8** %l17
  %s273 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t274 = call i1 @starts_with(i8* %t272, i8* %s273)
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t276 = load i8*, i8** %l1
  %t277 = load i8*, i8** %l2
  %t278 = load i8*, i8** %l3
  %t279 = load double, double* %l4
  %t280 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t281 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t282 = load double, double* %l7
  %t283 = load double, double* %l8
  %t284 = load i8*, i8** %l9
  %t285 = load double, double* %l10
  %t286 = load double, double* %l11
  %t287 = load i1, i1* %l12
  %t288 = load i1, i1* %l13
  %t289 = load double, double* %l14
  %t290 = load i8*, i8** %l16
  %t291 = load i8*, i8** %l17
  br i1 %t274, label %then18, label %merge19
then18:
  %t292 = load i8*, i8** %l17
  %s293 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t294 = call i8* @strip_prefix(i8* %t292, i8* %s293)
  %t295 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t294)
  store %EnumLayoutHeaderParse %t295, %EnumLayoutHeaderParse* %l18
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t297 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t298 = extractvalue %EnumLayoutHeaderParse %t297, 7
  %t299 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t296, { i8**, i64 }* %t298)
  store { i8**, i64 }* %t299, { i8**, i64 }** %l0
  %t300 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t301 = extractvalue %EnumLayoutHeaderParse %t300, 0
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t303 = load i8*, i8** %l1
  %t304 = load i8*, i8** %l2
  %t305 = load i8*, i8** %l3
  %t306 = load double, double* %l4
  %t307 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t308 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t309 = load double, double* %l7
  %t310 = load double, double* %l8
  %t311 = load i8*, i8** %l9
  %t312 = load double, double* %l10
  %t313 = load double, double* %l11
  %t314 = load i1, i1* %l12
  %t315 = load i1, i1* %l13
  %t316 = load double, double* %l14
  %t317 = load i8*, i8** %l16
  %t318 = load i8*, i8** %l17
  %t319 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t301, label %then20, label %merge21
then20:
  %t320 = load i1, i1* %l12
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t322 = load i8*, i8** %l1
  %t323 = load i8*, i8** %l2
  %t324 = load i8*, i8** %l3
  %t325 = load double, double* %l4
  %t326 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t327 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t328 = load double, double* %l7
  %t329 = load double, double* %l8
  %t330 = load i8*, i8** %l9
  %t331 = load double, double* %l10
  %t332 = load double, double* %l11
  %t333 = load i1, i1* %l12
  %t334 = load i1, i1* %l13
  %t335 = load double, double* %l14
  %t336 = load i8*, i8** %l16
  %t337 = load i8*, i8** %l17
  %t338 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t320, label %then22, label %else23
then22:
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s340 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1822658020, i32 0, i32 0
  %t341 = load i8*, i8** %l3
  %t342 = call i8* @sailfin_runtime_string_concat(i8* %s340, i8* %t341)
  %t343 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t339, i8* %t342)
  store { i8**, i64 }* %t343, { i8**, i64 }** %l0
  %t344 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t345 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t346 = extractvalue %EnumLayoutHeaderParse %t345, 2
  store double %t346, double* %l7
  %t347 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t348 = extractvalue %EnumLayoutHeaderParse %t347, 3
  store double %t348, double* %l8
  %t349 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t350 = extractvalue %EnumLayoutHeaderParse %t349, 4
  store i8* %t350, i8** %l9
  %t351 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t352 = extractvalue %EnumLayoutHeaderParse %t351, 5
  store double %t352, double* %l10
  %t353 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t354 = extractvalue %EnumLayoutHeaderParse %t353, 6
  store double %t354, double* %l11
  store i1 1, i1* %l12
  %t355 = load double, double* %l7
  %t356 = load double, double* %l8
  %t357 = load i8*, i8** %l9
  %t358 = load double, double* %l10
  %t359 = load double, double* %l11
  %t360 = load i1, i1* %l12
  br label %merge24
merge24:
  %t361 = phi { i8**, i64 }* [ %t344, %then22 ], [ %t321, %else23 ]
  %t362 = phi double [ %t328, %then22 ], [ %t355, %else23 ]
  %t363 = phi double [ %t329, %then22 ], [ %t356, %else23 ]
  %t364 = phi i8* [ %t330, %then22 ], [ %t357, %else23 ]
  %t365 = phi double [ %t331, %then22 ], [ %t358, %else23 ]
  %t366 = phi double [ %t332, %then22 ], [ %t359, %else23 ]
  %t367 = phi i1 [ %t333, %then22 ], [ %t360, %else23 ]
  store { i8**, i64 }* %t361, { i8**, i64 }** %l0
  store double %t362, double* %l7
  store double %t363, double* %l8
  store i8* %t364, i8** %l9
  store double %t365, double* %l10
  store double %t366, double* %l11
  store i1 %t367, i1* %l12
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t369 = load double, double* %l7
  %t370 = load double, double* %l8
  %t371 = load i8*, i8** %l9
  %t372 = load double, double* %l10
  %t373 = load double, double* %l11
  %t374 = load i1, i1* %l12
  br label %merge21
merge21:
  %t375 = phi { i8**, i64 }* [ %t368, %merge24 ], [ %t302, %then18 ]
  %t376 = phi double [ %t369, %merge24 ], [ %t309, %then18 ]
  %t377 = phi double [ %t370, %merge24 ], [ %t310, %then18 ]
  %t378 = phi i8* [ %t371, %merge24 ], [ %t311, %then18 ]
  %t379 = phi double [ %t372, %merge24 ], [ %t312, %then18 ]
  %t380 = phi double [ %t373, %merge24 ], [ %t313, %then18 ]
  %t381 = phi i1 [ %t374, %merge24 ], [ %t314, %then18 ]
  store { i8**, i64 }* %t375, { i8**, i64 }** %l0
  store double %t376, double* %l7
  store double %t377, double* %l8
  store i8* %t378, i8** %l9
  store double %t379, double* %l10
  store double %t380, double* %l11
  store i1 %t381, i1* %l12
  %t382 = load double, double* %l14
  %t383 = sitofp i64 1 to double
  %t384 = fadd double %t382, %t383
  store double %t384, double* %l14
  br label %loop.latch6
merge19:
  %t385 = load i8*, i8** %l17
  %s386 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t387 = call i1 @starts_with(i8* %t385, i8* %s386)
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t389 = load i8*, i8** %l1
  %t390 = load i8*, i8** %l2
  %t391 = load i8*, i8** %l3
  %t392 = load double, double* %l4
  %t393 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t394 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t395 = load double, double* %l7
  %t396 = load double, double* %l8
  %t397 = load i8*, i8** %l9
  %t398 = load double, double* %l10
  %t399 = load double, double* %l11
  %t400 = load i1, i1* %l12
  %t401 = load i1, i1* %l13
  %t402 = load double, double* %l14
  %t403 = load i8*, i8** %l16
  %t404 = load i8*, i8** %l17
  br i1 %t387, label %then25, label %merge26
then25:
  %t405 = load i8*, i8** %l17
  %s406 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t407 = call i8* @strip_prefix(i8* %t405, i8* %s406)
  %t408 = load i8*, i8** %l3
  %t409 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t407, i8* %t408)
  store %EnumLayoutVariantParse %t409, %EnumLayoutVariantParse* %l19
  %t410 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t411 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t412 = extractvalue %EnumLayoutVariantParse %t411, 2
  %t413 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t410, { i8**, i64 }* %t412)
  store { i8**, i64 }* %t413, { i8**, i64 }** %l0
  %t414 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t415 = extractvalue %EnumLayoutVariantParse %t414, 0
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t417 = load i8*, i8** %l1
  %t418 = load i8*, i8** %l2
  %t419 = load i8*, i8** %l3
  %t420 = load double, double* %l4
  %t421 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t422 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t423 = load double, double* %l7
  %t424 = load double, double* %l8
  %t425 = load i8*, i8** %l9
  %t426 = load double, double* %l10
  %t427 = load double, double* %l11
  %t428 = load i1, i1* %l12
  %t429 = load i1, i1* %l13
  %t430 = load double, double* %l14
  %t431 = load i8*, i8** %l16
  %t432 = load i8*, i8** %l17
  %t433 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t415, label %then27, label %merge28
then27:
  %t434 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t435 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t436 = extractvalue %EnumLayoutVariantParse %t435, 1
  %t437 = extractvalue %NativeEnumVariantLayout %t436, 0
  %t438 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t434, i8* %t437)
  store double %t438, double* %l20
  %t439 = load double, double* %l20
  %t440 = sitofp i64 0 to double
  %t441 = fcmp oge double %t439, %t440
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t443 = load i8*, i8** %l1
  %t444 = load i8*, i8** %l2
  %t445 = load i8*, i8** %l3
  %t446 = load double, double* %l4
  %t447 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t448 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t449 = load double, double* %l7
  %t450 = load double, double* %l8
  %t451 = load i8*, i8** %l9
  %t452 = load double, double* %l10
  %t453 = load double, double* %l11
  %t454 = load i1, i1* %l12
  %t455 = load i1, i1* %l13
  %t456 = load double, double* %l14
  %t457 = load i8*, i8** %l16
  %t458 = load i8*, i8** %l17
  %t459 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t460 = load double, double* %l20
  br i1 %t441, label %then29, label %else30
then29:
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s462 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1924917952, i32 0, i32 0
  %t463 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t464 = extractvalue %EnumLayoutVariantParse %t463, 1
  %t465 = extractvalue %NativeEnumVariantLayout %t464, 0
  %t466 = call i8* @sailfin_runtime_string_concat(i8* %s462, i8* %t465)
  %s467 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1783417286, i32 0, i32 0
  %t468 = call i8* @sailfin_runtime_string_concat(i8* %t466, i8* %s467)
  %t469 = load i8*, i8** %l3
  %t470 = call i8* @sailfin_runtime_string_concat(i8* %t468, i8* %t469)
  %t471 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t461, i8* %t470)
  store { i8**, i64 }* %t471, { i8**, i64 }** %l0
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
else30:
  %t473 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t474 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t475 = extractvalue %EnumLayoutVariantParse %t474, 1
  %t476 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t473, %NativeEnumVariantLayout %t475)
  store { %NativeEnumVariantLayout*, i64 }* %t476, { %NativeEnumVariantLayout*, i64 }** %l6
  %t477 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t478 = phi { i8**, i64 }* [ %t472, %then29 ], [ %t442, %else30 ]
  %t479 = phi { %NativeEnumVariantLayout*, i64 }* [ %t448, %then29 ], [ %t477, %else30 ]
  store { i8**, i64 }* %t478, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t479, { %NativeEnumVariantLayout*, i64 }** %l6
  %t480 = load i1, i1* %l12
  %t481 = xor i1 %t480, 1
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t483 = load i8*, i8** %l1
  %t484 = load i8*, i8** %l2
  %t485 = load i8*, i8** %l3
  %t486 = load double, double* %l4
  %t487 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t488 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t489 = load double, double* %l7
  %t490 = load double, double* %l8
  %t491 = load i8*, i8** %l9
  %t492 = load double, double* %l10
  %t493 = load double, double* %l11
  %t494 = load i1, i1* %l12
  %t495 = load i1, i1* %l13
  %t496 = load double, double* %l14
  %t497 = load i8*, i8** %l16
  %t498 = load i8*, i8** %l17
  %t499 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t500 = load double, double* %l20
  br i1 %t481, label %then32, label %merge33
then32:
  %t501 = load i1, i1* %l13
  %t502 = xor i1 %t501, 1
  %t503 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t504 = load i8*, i8** %l1
  %t505 = load i8*, i8** %l2
  %t506 = load i8*, i8** %l3
  %t507 = load double, double* %l4
  %t508 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t509 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t510 = load double, double* %l7
  %t511 = load double, double* %l8
  %t512 = load i8*, i8** %l9
  %t513 = load double, double* %l10
  %t514 = load double, double* %l11
  %t515 = load i1, i1* %l12
  %t516 = load i1, i1* %l13
  %t517 = load double, double* %l14
  %t518 = load i8*, i8** %l16
  %t519 = load i8*, i8** %l17
  %t520 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t521 = load double, double* %l20
  br i1 %t502, label %then34, label %merge35
then34:
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s523 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t524 = load i8*, i8** %l3
  %t525 = call i8* @sailfin_runtime_string_concat(i8* %s523, i8* %t524)
  %s526 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h235936117, i32 0, i32 0
  %t527 = call i8* @sailfin_runtime_string_concat(i8* %t525, i8* %s526)
  %t528 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t522, i8* %t527)
  store { i8**, i64 }* %t528, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t530 = load i1, i1* %l13
  br label %merge35
merge35:
  %t531 = phi { i8**, i64 }* [ %t529, %then34 ], [ %t503, %then32 ]
  %t532 = phi i1 [ %t530, %then34 ], [ %t516, %then32 ]
  store { i8**, i64 }* %t531, { i8**, i64 }** %l0
  store i1 %t532, i1* %l13
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t534 = load i1, i1* %l13
  br label %merge33
merge33:
  %t535 = phi { i8**, i64 }* [ %t533, %merge35 ], [ %t482, %merge31 ]
  %t536 = phi i1 [ %t534, %merge35 ], [ %t495, %merge31 ]
  store { i8**, i64 }* %t535, { i8**, i64 }** %l0
  store i1 %t536, i1* %l13
  %t537 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t538 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t539 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t540 = load i1, i1* %l13
  br label %merge28
merge28:
  %t541 = phi { i8**, i64 }* [ %t537, %merge33 ], [ %t416, %then25 ]
  %t542 = phi { %NativeEnumVariantLayout*, i64 }* [ %t538, %merge33 ], [ %t422, %then25 ]
  %t543 = phi { i8**, i64 }* [ %t539, %merge33 ], [ %t416, %then25 ]
  %t544 = phi i1 [ %t540, %merge33 ], [ %t429, %then25 ]
  store { i8**, i64 }* %t541, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t542, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t543, { i8**, i64 }** %l0
  store i1 %t544, i1* %l13
  %t545 = load double, double* %l14
  %t546 = sitofp i64 1 to double
  %t547 = fadd double %t545, %t546
  store double %t547, double* %l14
  br label %loop.latch6
merge26:
  %t548 = load i8*, i8** %l17
  %s549 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t550 = call i1 @starts_with(i8* %t548, i8* %s549)
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t552 = load i8*, i8** %l1
  %t553 = load i8*, i8** %l2
  %t554 = load i8*, i8** %l3
  %t555 = load double, double* %l4
  %t556 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t557 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t558 = load double, double* %l7
  %t559 = load double, double* %l8
  %t560 = load i8*, i8** %l9
  %t561 = load double, double* %l10
  %t562 = load double, double* %l11
  %t563 = load i1, i1* %l12
  %t564 = load i1, i1* %l13
  %t565 = load double, double* %l14
  %t566 = load i8*, i8** %l16
  %t567 = load i8*, i8** %l17
  br i1 %t550, label %then36, label %merge37
then36:
  %t568 = load i8*, i8** %l17
  %s569 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t570 = call i8* @strip_prefix(i8* %t568, i8* %s569)
  %t571 = load i8*, i8** %l3
  %t572 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t570, i8* %t571)
  store %EnumLayoutPayloadParse %t572, %EnumLayoutPayloadParse* %l21
  %t573 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t574 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t575 = extractvalue %EnumLayoutPayloadParse %t574, 3
  %t576 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t573, { i8**, i64 }* %t575)
  store { i8**, i64 }* %t576, { i8**, i64 }** %l0
  %t577 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t578 = extractvalue %EnumLayoutPayloadParse %t577, 0
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t580 = load i8*, i8** %l1
  %t581 = load i8*, i8** %l2
  %t582 = load i8*, i8** %l3
  %t583 = load double, double* %l4
  %t584 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t585 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t586 = load double, double* %l7
  %t587 = load double, double* %l8
  %t588 = load i8*, i8** %l9
  %t589 = load double, double* %l10
  %t590 = load double, double* %l11
  %t591 = load i1, i1* %l12
  %t592 = load i1, i1* %l13
  %t593 = load double, double* %l14
  %t594 = load i8*, i8** %l16
  %t595 = load i8*, i8** %l17
  %t596 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t578, label %then38, label %merge39
then38:
  %t597 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t598 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t599 = extractvalue %EnumLayoutPayloadParse %t598, 1
  %t600 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t597, i8* %t599)
  store double %t600, double* %l22
  %t601 = load double, double* %l22
  %t602 = sitofp i64 0 to double
  %t603 = fcmp olt double %t601, %t602
  %t604 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t605 = load i8*, i8** %l1
  %t606 = load i8*, i8** %l2
  %t607 = load i8*, i8** %l3
  %t608 = load double, double* %l4
  %t609 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t610 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t611 = load double, double* %l7
  %t612 = load double, double* %l8
  %t613 = load i8*, i8** %l9
  %t614 = load double, double* %l10
  %t615 = load double, double* %l11
  %t616 = load i1, i1* %l12
  %t617 = load i1, i1* %l13
  %t618 = load double, double* %l14
  %t619 = load i8*, i8** %l16
  %t620 = load i8*, i8** %l17
  %t621 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t622 = load double, double* %l22
  br i1 %t603, label %then40, label %else41
then40:
  %t623 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s624 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t625 = load i8*, i8** %l3
  %t626 = call i8* @sailfin_runtime_string_concat(i8* %s624, i8* %t625)
  %s627 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.len44.h1623843, i32 0, i32 0
  %t628 = call i8* @sailfin_runtime_string_concat(i8* %t626, i8* %s627)
  %t629 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t630 = extractvalue %EnumLayoutPayloadParse %t629, 1
  %t631 = call i8* @sailfin_runtime_string_concat(i8* %t628, i8* %t630)
  %t632 = alloca [2 x i8], align 1
  %t633 = getelementptr [2 x i8], [2 x i8]* %t632, i32 0, i32 0
  store i8 96, i8* %t633
  %t634 = getelementptr [2 x i8], [2 x i8]* %t632, i32 0, i32 1
  store i8 0, i8* %t634
  %t635 = getelementptr [2 x i8], [2 x i8]* %t632, i32 0, i32 0
  %t636 = call i8* @sailfin_runtime_string_concat(i8* %t631, i8* %t635)
  %t637 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t623, i8* %t636)
  store { i8**, i64 }* %t637, { i8**, i64 }** %l0
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t639 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t640 = load double, double* %l22
  %t641 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t642 = extractvalue %EnumLayoutPayloadParse %t641, 2
  %t643 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t639, double %t640, %NativeStructLayoutField %t642)
  store { %NativeEnumVariantLayout*, i64 }* %t643, { %NativeEnumVariantLayout*, i64 }** %l6
  %t644 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t645 = phi { i8**, i64 }* [ %t638, %then40 ], [ %t604, %else41 ]
  %t646 = phi { %NativeEnumVariantLayout*, i64 }* [ %t610, %then40 ], [ %t644, %else41 ]
  store { i8**, i64 }* %t645, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t646, { %NativeEnumVariantLayout*, i64 }** %l6
  %t647 = load i1, i1* %l12
  %t648 = xor i1 %t647, 1
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t650 = load i8*, i8** %l1
  %t651 = load i8*, i8** %l2
  %t652 = load i8*, i8** %l3
  %t653 = load double, double* %l4
  %t654 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t655 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t656 = load double, double* %l7
  %t657 = load double, double* %l8
  %t658 = load i8*, i8** %l9
  %t659 = load double, double* %l10
  %t660 = load double, double* %l11
  %t661 = load i1, i1* %l12
  %t662 = load i1, i1* %l13
  %t663 = load double, double* %l14
  %t664 = load i8*, i8** %l16
  %t665 = load i8*, i8** %l17
  %t666 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t667 = load double, double* %l22
  br i1 %t648, label %then43, label %merge44
then43:
  %t668 = load i1, i1* %l13
  %t669 = xor i1 %t668, 1
  %t670 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t671 = load i8*, i8** %l1
  %t672 = load i8*, i8** %l2
  %t673 = load i8*, i8** %l3
  %t674 = load double, double* %l4
  %t675 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t676 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t677 = load double, double* %l7
  %t678 = load double, double* %l8
  %t679 = load i8*, i8** %l9
  %t680 = load double, double* %l10
  %t681 = load double, double* %l11
  %t682 = load i1, i1* %l12
  %t683 = load i1, i1* %l13
  %t684 = load double, double* %l14
  %t685 = load i8*, i8** %l16
  %t686 = load i8*, i8** %l17
  %t687 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t688 = load double, double* %l22
  br i1 %t669, label %then45, label %merge46
then45:
  %t689 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s690 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t691 = load i8*, i8** %l3
  %t692 = call i8* @sailfin_runtime_string_concat(i8* %s690, i8* %t691)
  %s693 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h807033739, i32 0, i32 0
  %t694 = call i8* @sailfin_runtime_string_concat(i8* %t692, i8* %s693)
  %t695 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t689, i8* %t694)
  store { i8**, i64 }* %t695, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t696 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t697 = load i1, i1* %l13
  br label %merge46
merge46:
  %t698 = phi { i8**, i64 }* [ %t696, %then45 ], [ %t670, %then43 ]
  %t699 = phi i1 [ %t697, %then45 ], [ %t683, %then43 ]
  store { i8**, i64 }* %t698, { i8**, i64 }** %l0
  store i1 %t699, i1* %l13
  %t700 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t701 = load i1, i1* %l13
  br label %merge44
merge44:
  %t702 = phi { i8**, i64 }* [ %t700, %merge46 ], [ %t649, %merge42 ]
  %t703 = phi i1 [ %t701, %merge46 ], [ %t662, %merge42 ]
  store { i8**, i64 }* %t702, { i8**, i64 }** %l0
  store i1 %t703, i1* %l13
  %t704 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t705 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t706 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t707 = load i1, i1* %l13
  br label %merge39
merge39:
  %t708 = phi { i8**, i64 }* [ %t704, %merge44 ], [ %t579, %then36 ]
  %t709 = phi { %NativeEnumVariantLayout*, i64 }* [ %t705, %merge44 ], [ %t585, %then36 ]
  %t710 = phi { i8**, i64 }* [ %t706, %merge44 ], [ %t579, %then36 ]
  %t711 = phi i1 [ %t707, %merge44 ], [ %t592, %then36 ]
  store { i8**, i64 }* %t708, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t709, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t710, { i8**, i64 }** %l0
  store i1 %t711, i1* %l13
  %t712 = load double, double* %l14
  %t713 = sitofp i64 1 to double
  %t714 = fadd double %t712, %t713
  store double %t714, double* %l14
  br label %loop.latch6
merge37:
  %t715 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s716 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h2058816325, i32 0, i32 0
  %t717 = load i8*, i8** %l16
  %t718 = call i8* @sailfin_runtime_string_concat(i8* %s716, i8* %t717)
  %t719 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t715, i8* %t718)
  store { i8**, i64 }* %t719, { i8**, i64 }** %l0
  %t720 = load double, double* %l14
  %t721 = sitofp i64 1 to double
  %t722 = fadd double %t720, %t721
  store double %t722, double* %l14
  br label %loop.latch6
merge17:
  %t723 = load i8*, i8** %l16
  %s724 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h562875475, i32 0, i32 0
  %t725 = call i1 @strings_equal(i8* %t723, i8* %s724)
  %t726 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t727 = load i8*, i8** %l1
  %t728 = load i8*, i8** %l2
  %t729 = load i8*, i8** %l3
  %t730 = load double, double* %l4
  %t731 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t732 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t733 = load double, double* %l7
  %t734 = load double, double* %l8
  %t735 = load i8*, i8** %l9
  %t736 = load double, double* %l10
  %t737 = load double, double* %l11
  %t738 = load i1, i1* %l12
  %t739 = load i1, i1* %l13
  %t740 = load double, double* %l14
  %t741 = load i8*, i8** %l16
  br i1 %t725, label %then47, label %merge48
then47:
  %t742 = load double, double* %l14
  %t743 = sitofp i64 1 to double
  %t744 = fadd double %t742, %t743
  store double %t744, double* %l14
  br label %afterloop7
merge48:
  %t745 = load i8*, i8** %l16
  %s746 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t747 = call i1 @starts_with(i8* %t745, i8* %s746)
  %t748 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t749 = load i8*, i8** %l1
  %t750 = load i8*, i8** %l2
  %t751 = load i8*, i8** %l3
  %t752 = load double, double* %l4
  %t753 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t754 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t755 = load double, double* %l7
  %t756 = load double, double* %l8
  %t757 = load i8*, i8** %l9
  %t758 = load double, double* %l10
  %t759 = load double, double* %l11
  %t760 = load i1, i1* %l12
  %t761 = load i1, i1* %l13
  %t762 = load double, double* %l14
  %t763 = load i8*, i8** %l16
  br i1 %t747, label %then49, label %merge50
then49:
  %t764 = load i8*, i8** %l16
  %s765 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t766 = call i8* @strip_prefix(i8* %t764, i8* %s765)
  %t767 = call %NativeEnumVariant* @parse_enum_variant_line(i8* %t766)
  store %NativeEnumVariant* %t767, %NativeEnumVariant** %l23
  %t768 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t769 = icmp eq %NativeEnumVariant* %t768, null
  %t770 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t771 = load i8*, i8** %l1
  %t772 = load i8*, i8** %l2
  %t773 = load i8*, i8** %l3
  %t774 = load double, double* %l4
  %t775 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t776 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t777 = load double, double* %l7
  %t778 = load double, double* %l8
  %t779 = load i8*, i8** %l9
  %t780 = load double, double* %l10
  %t781 = load double, double* %l11
  %t782 = load i1, i1* %l12
  %t783 = load i1, i1* %l13
  %t784 = load double, double* %l14
  %t785 = load i8*, i8** %l16
  %t786 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  br i1 %t769, label %then51, label %else52
then51:
  %t787 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s788 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h829706524, i32 0, i32 0
  %t789 = load i8*, i8** %l16
  %t790 = call i8* @sailfin_runtime_string_concat(i8* %s788, i8* %t789)
  %t791 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t787, i8* %t790)
  store { i8**, i64 }* %t791, { i8**, i64 }** %l0
  %t792 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge53
else52:
  %t793 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t794 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t795 = load %NativeEnumVariant, %NativeEnumVariant* %t794
  %t796 = call { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %t793, %NativeEnumVariant %t795)
  store { %NativeEnumVariant*, i64 }* %t796, { %NativeEnumVariant*, i64 }** %l5
  %t797 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %merge53
merge53:
  %t798 = phi { i8**, i64 }* [ %t792, %then51 ], [ %t770, %else52 ]
  %t799 = phi { %NativeEnumVariant*, i64 }* [ %t775, %then51 ], [ %t797, %else52 ]
  store { i8**, i64 }* %t798, { i8**, i64 }** %l0
  store { %NativeEnumVariant*, i64 }* %t799, { %NativeEnumVariant*, i64 }** %l5
  %t800 = load double, double* %l14
  %t801 = sitofp i64 1 to double
  %t802 = fadd double %t800, %t801
  store double %t802, double* %l14
  br label %loop.latch6
merge50:
  %t803 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s804 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1471254674, i32 0, i32 0
  %t805 = load i8*, i8** %l16
  %t806 = call i8* @sailfin_runtime_string_concat(i8* %s804, i8* %t805)
  %t807 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t803, i8* %t806)
  store { i8**, i64 }* %t807, { i8**, i64 }** %l0
  %t808 = load double, double* %l14
  %t809 = sitofp i64 1 to double
  %t810 = fadd double %t808, %t809
  store double %t810, double* %l14
  br label %loop.latch6
loop.latch6:
  %t811 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t812 = load double, double* %l14
  %t813 = load double, double* %l7
  %t814 = load double, double* %l8
  %t815 = load i8*, i8** %l9
  %t816 = load double, double* %l10
  %t817 = load double, double* %l11
  %t818 = load i1, i1* %l12
  %t819 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t820 = load i1, i1* %l13
  %t821 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t833 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t834 = load double, double* %l14
  %t835 = load double, double* %l7
  %t836 = load double, double* %l8
  %t837 = load i8*, i8** %l9
  %t838 = load double, double* %l10
  %t839 = load double, double* %l11
  %t840 = load i1, i1* %l12
  %t841 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t842 = load i1, i1* %l13
  %t843 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t844 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t844, %NativeEnumLayout** %l24
  %t845 = load i1, i1* %l12
  %t846 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t847 = load i8*, i8** %l1
  %t848 = load i8*, i8** %l2
  %t849 = load i8*, i8** %l3
  %t850 = load double, double* %l4
  %t851 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t852 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t853 = load double, double* %l7
  %t854 = load double, double* %l8
  %t855 = load i8*, i8** %l9
  %t856 = load double, double* %l10
  %t857 = load double, double* %l11
  %t858 = load i1, i1* %l12
  %t859 = load i1, i1* %l13
  %t860 = load double, double* %l14
  %t861 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br i1 %t845, label %then54, label %merge55
then54:
  %t862 = load double, double* %l7
  %t863 = insertvalue %NativeEnumLayout undef, double %t862, 0
  %t864 = load double, double* %l8
  %t865 = insertvalue %NativeEnumLayout %t863, double %t864, 1
  %t866 = load i8*, i8** %l9
  %t867 = insertvalue %NativeEnumLayout %t865, i8* %t866, 2
  %t868 = load double, double* %l10
  %t869 = insertvalue %NativeEnumLayout %t867, double %t868, 3
  %t870 = load double, double* %l11
  %t871 = insertvalue %NativeEnumLayout %t869, double %t870, 4
  %t872 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t873 = bitcast { %NativeEnumVariantLayout*, i64 }* %t872 to { %NativeEnumVariantLayout**, i64 }*
  %t874 = insertvalue %NativeEnumLayout %t871, { %NativeEnumVariantLayout**, i64 }* %t873, 5
  %t875 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t874, %NativeEnumLayout* %t875
  store %NativeEnumLayout* %t875, %NativeEnumLayout** %l24
  %t876 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br label %merge55
merge55:
  %t877 = phi %NativeEnumLayout* [ %t876, %then54 ], [ %t861, %afterloop7 ]
  store %NativeEnumLayout* %t877, %NativeEnumLayout** %l24
  %t878 = load i8*, i8** %l3
  %t879 = insertvalue %NativeEnum undef, i8* %t878, 0
  %t880 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t881 = bitcast { %NativeEnumVariant*, i64 }* %t880 to { %NativeEnumVariant**, i64 }*
  %t882 = insertvalue %NativeEnum %t879, { %NativeEnumVariant**, i64 }* %t881, 1
  %t883 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  %t884 = insertvalue %NativeEnum %t882, %NativeEnumLayout* %t883, 2
  %t885 = alloca %NativeEnum
  store %NativeEnum %t884, %NativeEnum* %t885
  %t886 = insertvalue %EnumParseResult undef, %NativeEnum* %t885, 0
  %t887 = load double, double* %l14
  %t888 = insertvalue %EnumParseResult %t886, double %t887, 1
  %t889 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t890 = insertvalue %EnumParseResult %t888, { i8**, i64 }* %t889, 2
  ret %EnumParseResult %t890
}

define %NativeEnumVariant* @parse_enum_variant_line(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca { i8**, i64 }*
  %l6 = alloca { %NativeEnumVariantField*, i64 }*
  %l7 = alloca double
  %l8 = alloca i8*
  %l9 = alloca %NativeEnumVariantField*
  %t0 = call i8* @trim_text(i8* %text)
  %t1 = call i8* @trim_trailing_delimiters(i8* %t0)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  %t3 = call i64 @sailfin_runtime_string_length(i8* %t2)
  %t4 = icmp eq i64 %t3, 0
  %t5 = load i8*, i8** %l0
  br i1 %t4, label %then0, label %merge1
then0:
  %t6 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t6
merge1:
  %t7 = load i8*, i8** %l0
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 123, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  %t12 = call double @index_of(i8* %t7, i8* %t11)
  store double %t12, double* %l1
  %t13 = load double, double* %l1
  %t14 = sitofp i64 0 to double
  %t15 = fcmp olt double %t13, %t14
  %t16 = load i8*, i8** %l0
  %t17 = load double, double* %l1
  br i1 %t15, label %then2, label %merge3
then2:
  %t18 = load i8*, i8** %l0
  %t19 = call i8* @strip_generics(i8* %t18)
  %t20 = insertvalue %NativeEnumVariant undef, i8* %t19, 0
  %t21 = getelementptr [0 x %NativeEnumVariantField*], [0 x %NativeEnumVariantField*]* null, i32 1
  %t22 = ptrtoint [0 x %NativeEnumVariantField*]* %t21 to i64
  %t23 = icmp eq i64 %t22, 0
  %t24 = select i1 %t23, i64 1, i64 %t22
  %t25 = call i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeEnumVariantField**
  %t27 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* null, i32 1
  %t28 = ptrtoint { %NativeEnumVariantField**, i64 }* %t27 to i64
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to { %NativeEnumVariantField**, i64 }*
  %t31 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* %t30, i32 0, i32 0
  store %NativeEnumVariantField** %t26, %NativeEnumVariantField*** %t31
  %t32 = getelementptr { %NativeEnumVariantField**, i64 }, { %NativeEnumVariantField**, i64 }* %t30, i32 0, i32 1
  store i64 0, i64* %t32
  %t33 = insertvalue %NativeEnumVariant %t20, { %NativeEnumVariantField**, i64 }* %t30, 1
  %t34 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t33, %NativeEnumVariant* %t34
  ret %NativeEnumVariant* %t34
merge3:
  %t35 = load i8*, i8** %l0
  %t36 = alloca [2 x i8], align 1
  %t37 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  store i8 125, i8* %t37
  %t38 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 1
  store i8 0, i8* %t38
  %t39 = getelementptr [2 x i8], [2 x i8]* %t36, i32 0, i32 0
  %t40 = call double @last_index_of(i8* %t35, i8* %t39)
  store double %t40, double* %l2
  %t42 = load double, double* %l2
  %t43 = sitofp i64 0 to double
  %t44 = fcmp olt double %t42, %t43
  br label %logical_or_entry_41

logical_or_entry_41:
  br i1 %t44, label %logical_or_merge_41, label %logical_or_right_41

logical_or_right_41:
  %t45 = load double, double* %l2
  %t46 = load double, double* %l1
  %t47 = fcmp ole double %t45, %t46
  br label %logical_or_right_end_41

logical_or_right_end_41:
  br label %logical_or_merge_41

logical_or_merge_41:
  %t48 = phi i1 [ true, %logical_or_entry_41 ], [ %t47, %logical_or_right_end_41 ]
  %t49 = load i8*, i8** %l0
  %t50 = load double, double* %l1
  %t51 = load double, double* %l2
  br i1 %t48, label %then4, label %merge5
then4:
  %t52 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t52
merge5:
  %t53 = load i8*, i8** %l0
  %t54 = load double, double* %l1
  %t55 = call double @llvm.round.f64(double %t54)
  %t56 = fptosi double %t55 to i64
  %t57 = call i8* @sailfin_runtime_substring(i8* %t53, i64 0, i64 %t56)
  %t58 = call i8* @trim_text(i8* %t57)
  %t59 = call i8* @strip_generics(i8* %t58)
  store i8* %t59, i8** %l3
  %t60 = load i8*, i8** %l3
  %t61 = call i64 @sailfin_runtime_string_length(i8* %t60)
  %t62 = icmp eq i64 %t61, 0
  %t63 = load i8*, i8** %l0
  %t64 = load double, double* %l1
  %t65 = load double, double* %l2
  %t66 = load i8*, i8** %l3
  br i1 %t62, label %then6, label %merge7
then6:
  %t67 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t67
merge7:
  %t68 = load i8*, i8** %l0
  %t69 = load double, double* %l1
  %t70 = sitofp i64 1 to double
  %t71 = fadd double %t69, %t70
  %t72 = load double, double* %l2
  %t73 = call double @llvm.round.f64(double %t71)
  %t74 = fptosi double %t73 to i64
  %t75 = call double @llvm.round.f64(double %t72)
  %t76 = fptosi double %t75 to i64
  %t77 = call i8* @sailfin_runtime_substring(i8* %t68, i64 %t74, i64 %t76)
  store i8* %t77, i8** %l4
  %t78 = load i8*, i8** %l4
  %t79 = call { i8**, i64 }* @split_enum_field_entries(i8* %t78)
  store { i8**, i64 }* %t79, { i8**, i64 }** %l5
  %t80 = getelementptr [0 x %NativeEnumVariantField], [0 x %NativeEnumVariantField]* null, i32 1
  %t81 = ptrtoint [0 x %NativeEnumVariantField]* %t80 to i64
  %t82 = icmp eq i64 %t81, 0
  %t83 = select i1 %t82, i64 1, i64 %t81
  %t84 = call i8* @malloc(i64 %t83)
  %t85 = bitcast i8* %t84 to %NativeEnumVariantField*
  %t86 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* null, i32 1
  %t87 = ptrtoint { %NativeEnumVariantField*, i64 }* %t86 to i64
  %t88 = call i8* @malloc(i64 %t87)
  %t89 = bitcast i8* %t88 to { %NativeEnumVariantField*, i64 }*
  %t90 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t89, i32 0, i32 0
  store %NativeEnumVariantField* %t85, %NativeEnumVariantField** %t90
  %t91 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t89, i32 0, i32 1
  store i64 0, i64* %t91
  store { %NativeEnumVariantField*, i64 }* %t89, { %NativeEnumVariantField*, i64 }** %l6
  %t92 = sitofp i64 0 to double
  store double %t92, double* %l7
  %t93 = load i8*, i8** %l0
  %t94 = load double, double* %l1
  %t95 = load double, double* %l2
  %t96 = load i8*, i8** %l3
  %t97 = load i8*, i8** %l4
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t99 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t100 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t166 = phi double [ %t100, %merge7 ], [ %t164, %loop.latch10 ]
  %t167 = phi { %NativeEnumVariantField*, i64 }* [ %t99, %merge7 ], [ %t165, %loop.latch10 ]
  store double %t166, double* %l7
  store { %NativeEnumVariantField*, i64 }* %t167, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t101 = load double, double* %l7
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t103 = load { i8**, i64 }, { i8**, i64 }* %t102
  %t104 = extractvalue { i8**, i64 } %t103, 1
  %t105 = sitofp i64 %t104 to double
  %t106 = fcmp oge double %t101, %t105
  %t107 = load i8*, i8** %l0
  %t108 = load double, double* %l1
  %t109 = load double, double* %l2
  %t110 = load i8*, i8** %l3
  %t111 = load i8*, i8** %l4
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t113 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t114 = load double, double* %l7
  br i1 %t106, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t116 = load double, double* %l7
  %t117 = call double @llvm.round.f64(double %t116)
  %t118 = fptosi double %t117 to i64
  %t119 = load { i8**, i64 }, { i8**, i64 }* %t115
  %t120 = extractvalue { i8**, i64 } %t119, 0
  %t121 = extractvalue { i8**, i64 } %t119, 1
  %t122 = icmp uge i64 %t118, %t121
  ; bounds check: %t122 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t118, i64 %t121)
  %t123 = getelementptr i8*, i8** %t120, i64 %t118
  %t124 = load i8*, i8** %t123
  %t125 = call i8* @trim_text(i8* %t124)
  %t126 = call i8* @trim_trailing_delimiters(i8* %t125)
  store i8* %t126, i8** %l8
  %t127 = load i8*, i8** %l8
  %t128 = call i64 @sailfin_runtime_string_length(i8* %t127)
  %t129 = icmp eq i64 %t128, 0
  %t130 = load i8*, i8** %l0
  %t131 = load double, double* %l1
  %t132 = load double, double* %l2
  %t133 = load i8*, i8** %l3
  %t134 = load i8*, i8** %l4
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t136 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t137 = load double, double* %l7
  %t138 = load i8*, i8** %l8
  br i1 %t129, label %then14, label %merge15
then14:
  %t139 = load double, double* %l7
  %t140 = sitofp i64 1 to double
  %t141 = fadd double %t139, %t140
  store double %t141, double* %l7
  br label %loop.latch10
merge15:
  %t142 = load i8*, i8** %l8
  %t143 = call %NativeEnumVariantField* @parse_enum_variant_field(i8* %t142)
  store %NativeEnumVariantField* %t143, %NativeEnumVariantField** %l9
  %t144 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t145 = icmp eq %NativeEnumVariantField* %t144, null
  %t146 = load i8*, i8** %l0
  %t147 = load double, double* %l1
  %t148 = load double, double* %l2
  %t149 = load i8*, i8** %l3
  %t150 = load i8*, i8** %l4
  %t151 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t152 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t153 = load double, double* %l7
  %t154 = load i8*, i8** %l8
  %t155 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  br i1 %t145, label %then16, label %merge17
then16:
  %t156 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t156
merge17:
  %t157 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t158 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t159 = load %NativeEnumVariantField, %NativeEnumVariantField* %t158
  %t160 = call { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %t157, %NativeEnumVariantField %t159)
  store { %NativeEnumVariantField*, i64 }* %t160, { %NativeEnumVariantField*, i64 }** %l6
  %t161 = load double, double* %l7
  %t162 = sitofp i64 1 to double
  %t163 = fadd double %t161, %t162
  store double %t163, double* %l7
  br label %loop.latch10
loop.latch10:
  %t164 = load double, double* %l7
  %t165 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t168 = load double, double* %l7
  %t169 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t170 = load i8*, i8** %l3
  %t171 = insertvalue %NativeEnumVariant undef, i8* %t170, 0
  %t172 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t173 = bitcast { %NativeEnumVariantField*, i64 }* %t172 to { %NativeEnumVariantField**, i64 }*
  %t174 = insertvalue %NativeEnumVariant %t171, { %NativeEnumVariantField**, i64 }* %t173, 1
  %t175 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t174, %NativeEnumVariant* %t175
  ret %NativeEnumVariant* %t175
}

define { i8**, i64 }* @split_enum_field_entries(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8
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
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t16 = load i8*, i8** %l1
  %t17 = load double, double* %l2
  %t18 = load double, double* %l3
  br label %loop.header0
loop.header0:
  %t118 = phi double [ %t17, %block.entry ], [ %t114, %loop.latch2 ]
  %t119 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t115, %loop.latch2 ]
  %t120 = phi i8* [ %t16, %block.entry ], [ %t116, %loop.latch2 ]
  %t121 = phi double [ %t18, %block.entry ], [ %t117, %loop.latch2 ]
  store double %t118, double* %l2
  store { i8**, i64 }* %t119, { i8**, i64 }** %l0
  store i8* %t120, i8** %l1
  store double %t121, double* %l3
  br label %loop.body1
loop.body1:
  %t19 = load double, double* %l3
  %t20 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t21 = sitofp i64 %t20 to double
  %t22 = fcmp oge double %t19, %t21
  %t23 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t24 = load i8*, i8** %l1
  %t25 = load double, double* %l2
  %t26 = load double, double* %l3
  br i1 %t22, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t27 = load double, double* %l3
  %t28 = call double @llvm.round.f64(double %t27)
  %t29 = fptosi double %t28 to i64
  %t30 = getelementptr i8, i8* %text, i64 %t29
  %t31 = load i8, i8* %t30
  store i8 %t31, i8* %l4
  %t33 = load i8, i8* %l4
  %t34 = icmp eq i8 %t33, 123
  br label %logical_or_entry_32

logical_or_entry_32:
  br i1 %t34, label %logical_or_merge_32, label %logical_or_right_32

logical_or_right_32:
  %t36 = load i8, i8* %l4
  %t37 = icmp eq i8 %t36, 91
  br label %logical_or_entry_35

logical_or_entry_35:
  br i1 %t37, label %logical_or_merge_35, label %logical_or_right_35

logical_or_right_35:
  %t38 = load i8, i8* %l4
  %t39 = icmp eq i8 %t38, 40
  br label %logical_or_right_end_35

logical_or_right_end_35:
  br label %logical_or_merge_35

logical_or_merge_35:
  %t40 = phi i1 [ true, %logical_or_entry_35 ], [ %t39, %logical_or_right_end_35 ]
  br label %logical_or_right_end_32

logical_or_right_end_32:
  br label %logical_or_merge_32

logical_or_merge_32:
  %t41 = phi i1 [ true, %logical_or_entry_32 ], [ %t40, %logical_or_right_end_32 ]
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t43 = load i8*, i8** %l1
  %t44 = load double, double* %l2
  %t45 = load double, double* %l3
  %t46 = load i8, i8* %l4
  br i1 %t41, label %then6, label %else7
then6:
  %t47 = load double, double* %l2
  %t48 = sitofp i64 1 to double
  %t49 = fadd double %t47, %t48
  store double %t49, double* %l2
  %t50 = load double, double* %l2
  br label %merge8
else7:
  %t52 = load i8, i8* %l4
  %t53 = icmp eq i8 %t52, 125
  br label %logical_or_entry_51

logical_or_entry_51:
  br i1 %t53, label %logical_or_merge_51, label %logical_or_right_51

logical_or_right_51:
  %t55 = load i8, i8* %l4
  %t56 = icmp eq i8 %t55, 93
  br label %logical_or_entry_54

logical_or_entry_54:
  br i1 %t56, label %logical_or_merge_54, label %logical_or_right_54

logical_or_right_54:
  %t57 = load i8, i8* %l4
  %t58 = icmp eq i8 %t57, 41
  br label %logical_or_right_end_54

logical_or_right_end_54:
  br label %logical_or_merge_54

logical_or_merge_54:
  %t59 = phi i1 [ true, %logical_or_entry_54 ], [ %t58, %logical_or_right_end_54 ]
  br label %logical_or_right_end_51

logical_or_right_end_51:
  br label %logical_or_merge_51

logical_or_merge_51:
  %t60 = phi i1 [ true, %logical_or_entry_51 ], [ %t59, %logical_or_right_end_51 ]
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l2
  %t64 = load double, double* %l3
  %t65 = load i8, i8* %l4
  br i1 %t60, label %then9, label %merge10
then9:
  %t66 = load double, double* %l2
  %t67 = sitofp i64 0 to double
  %t68 = fcmp ogt double %t66, %t67
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = load double, double* %l3
  %t73 = load i8, i8* %l4
  br i1 %t68, label %then11, label %merge12
then11:
  %t74 = load double, double* %l2
  %t75 = sitofp i64 1 to double
  %t76 = fsub double %t74, %t75
  store double %t76, double* %l2
  %t77 = load double, double* %l2
  br label %merge12
merge12:
  %t78 = phi double [ %t77, %then11 ], [ %t71, %then9 ]
  store double %t78, double* %l2
  %t79 = load double, double* %l2
  br label %merge10
merge10:
  %t80 = phi double [ %t79, %merge12 ], [ %t63, %logical_or_merge_51 ]
  store double %t80, double* %l2
  %t81 = load double, double* %l2
  br label %merge8
merge8:
  %t82 = phi double [ %t50, %then6 ], [ %t81, %merge10 ]
  store double %t82, double* %l2
  %t84 = load i8, i8* %l4
  %t85 = icmp eq i8 %t84, 59
  br label %logical_and_entry_83

logical_and_entry_83:
  br i1 %t85, label %logical_and_right_83, label %logical_and_merge_83

logical_and_right_83:
  %t86 = load double, double* %l2
  %t87 = sitofp i64 0 to double
  %t88 = fcmp oeq double %t86, %t87
  br label %logical_and_right_end_83

logical_and_right_end_83:
  br label %logical_and_merge_83

logical_and_merge_83:
  %t89 = phi i1 [ false, %logical_and_entry_83 ], [ %t88, %logical_and_right_end_83 ]
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t91 = load i8*, i8** %l1
  %t92 = load double, double* %l2
  %t93 = load double, double* %l3
  %t94 = load i8, i8* %l4
  br i1 %t89, label %then13, label %else14
then13:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load i8*, i8** %l1
  %t97 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t95, i8* %t96)
  store { i8**, i64 }* %t97, { i8**, i64 }** %l0
  %s98 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s98, i8** %l1
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load i8*, i8** %l1
  br label %merge15
else14:
  %t101 = load i8*, i8** %l1
  %t102 = load i8, i8* %l4
  %t103 = alloca [2 x i8], align 1
  %t104 = getelementptr [2 x i8], [2 x i8]* %t103, i32 0, i32 0
  store i8 %t102, i8* %t104
  %t105 = getelementptr [2 x i8], [2 x i8]* %t103, i32 0, i32 1
  store i8 0, i8* %t105
  %t106 = getelementptr [2 x i8], [2 x i8]* %t103, i32 0, i32 0
  %t107 = call i8* @sailfin_runtime_string_concat(i8* %t101, i8* %t106)
  store i8* %t107, i8** %l1
  %t108 = load i8*, i8** %l1
  br label %merge15
merge15:
  %t109 = phi { i8**, i64 }* [ %t99, %then13 ], [ %t90, %else14 ]
  %t110 = phi i8* [ %t100, %then13 ], [ %t108, %else14 ]
  store { i8**, i64 }* %t109, { i8**, i64 }** %l0
  store i8* %t110, i8** %l1
  %t111 = load double, double* %l3
  %t112 = sitofp i64 1 to double
  %t113 = fadd double %t111, %t112
  store double %t113, double* %l3
  br label %loop.latch2
loop.latch2:
  %t114 = load double, double* %l2
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load i8*, i8** %l1
  %t117 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t122 = load double, double* %l2
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t124 = load i8*, i8** %l1
  %t125 = load double, double* %l3
  %t126 = load i8*, i8** %l1
  %t127 = call i64 @sailfin_runtime_string_length(i8* %t126)
  %t128 = icmp sgt i64 %t127, 0
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t130 = load i8*, i8** %l1
  %t131 = load double, double* %l2
  %t132 = load double, double* %l3
  br i1 %t128, label %then16, label %merge17
then16:
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t134 = load i8*, i8** %l1
  %t135 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t133, i8* %t134)
  store { i8**, i64 }* %t135, { i8**, i64 }** %l0
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge17
merge17:
  %t137 = phi { i8**, i64 }* [ %t136, %then16 ], [ %t129, %afterloop3 ]
  store { i8**, i64 }* %t137, { i8**, i64 }** %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t138
}

define %NativeEnumVariantField* @parse_enum_variant_field(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t5
merge1:
  store i1 0, i1* %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i1, i1* %l1
  %t16 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t17 = phi i1 [ %t15, %then2 ], [ %t10, %merge1 ]
  %t18 = phi i8* [ %t16, %then2 ], [ %t9, %merge1 ]
  store i1 %t17, i1* %l1
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t21 = call double @index_of(i8* %t19, i8* %s20)
  store double %t21, double* %l2
  %t22 = load double, double* %l2
  %t23 = sitofp i64 0 to double
  %t24 = fcmp olt double %t22, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load i1, i1* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then4, label %merge5
then4:
  %t28 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t28
merge5:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l2
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = call i8* @sailfin_runtime_substring(i8* %t29, i64 0, i64 %t32)
  %t34 = call i8* @trim_text(i8* %t33)
  store i8* %t34, i8** %l3
  %t35 = load i8*, i8** %l3
  %t36 = call i64 @sailfin_runtime_string_length(i8* %t35)
  %t37 = icmp eq i64 %t36, 0
  %t38 = load i8*, i8** %l0
  %t39 = load i1, i1* %l1
  %t40 = load double, double* %l2
  %t41 = load i8*, i8** %l3
  br i1 %t37, label %then6, label %merge7
then6:
  %t42 = bitcast i8* null to %NativeEnumVariantField*
  ret %NativeEnumVariantField* %t42
merge7:
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l2
  %t45 = sitofp i64 2 to double
  %t46 = fadd double %t44, %t45
  %t47 = load i8*, i8** %l0
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = call double @llvm.round.f64(double %t46)
  %t50 = fptosi double %t49 to i64
  %t51 = call i8* @sailfin_runtime_substring(i8* %t43, i64 %t50, i64 %t48)
  %t52 = call i8* @trim_text(i8* %t51)
  store i8* %t52, i8** %l4
  %t53 = load i8*, i8** %l3
  %t54 = insertvalue %NativeEnumVariantField undef, i8* %t53, 0
  %t55 = load i8*, i8** %l4
  %t56 = insertvalue %NativeEnumVariantField %t54, i8* %t55, 1
  %t57 = load i1, i1* %l1
  %t58 = insertvalue %NativeEnumVariantField %t56, i1 %t57, 2
  %t59 = alloca %NativeEnumVariantField
  store %NativeEnumVariantField %t58, %NativeEnumVariantField* %t59
  ret %NativeEnumVariantField* %t59
}

define i8* @text_char_at(i8* %value, double %index) {
block.entry:
  %t0 = sitofp i64 0 to double
  %t1 = fcmp olt double %index, %t0
  br i1 %t1, label %then0, label %merge1
then0:
  %s2 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s2)
  ret i8* %s2
merge1:
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = sitofp i64 %t3 to double
  %t5 = fcmp oge double %index, %t4
  br i1 %t5, label %then2, label %merge3
then2:
  %s6 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  call void @sailfin_runtime_mark_persistent(i8* %s6)
  ret i8* %s6
merge3:
  %t7 = sitofp i64 1 to double
  %t8 = fadd double %index, %t7
  %t9 = call double @llvm.round.f64(double %index)
  %t10 = fptosi double %t9 to i64
  %t11 = call double @llvm.round.f64(double %t8)
  %t12 = fptosi double %t11 to i64
  %t13 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t10, i64 %t12)
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  ret i8* %t13
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
  %t10 = call i8* @text_char_at(i8* %text, double %t9)
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

define i8* @maybe_trim_trailing(i8* %value) {
block.entry:
  %l0 = alloca i8*
  %t0 = icmp eq i8* %value, null
  br i1 %t0, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* null)
  ret i8* null
merge1:
  %t1 = call i8* @trim_trailing_delimiters(i8* %value)
  store i8* %t1, i8** %l0
  %t2 = load i8*, i8** %l0
  call void @sailfin_runtime_mark_persistent(i8* %t2)
  ret i8* %t2
}

define %NativeStructField* @parse_struct_field_line(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t5
merge1:
  store i1 0, i1* %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i1, i1* %l1
  %t16 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t17 = phi i1 [ %t15, %then2 ], [ %t10, %merge1 ]
  %t18 = phi i8* [ %t16, %then2 ], [ %t9, %merge1 ]
  store i1 %t17, i1* %l1
  store i8* %t18, i8** %l0
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t21 = call double @index_of(i8* %t19, i8* %s20)
  store double %t21, double* %l2
  %t22 = load double, double* %l2
  %t23 = sitofp i64 0 to double
  %t24 = fcmp olt double %t22, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load i1, i1* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then4, label %merge5
then4:
  %t28 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t28
merge5:
  %t29 = load i8*, i8** %l0
  %t30 = load double, double* %l2
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = call i8* @sailfin_runtime_substring(i8* %t29, i64 0, i64 %t32)
  %t34 = call i8* @trim_text(i8* %t33)
  store i8* %t34, i8** %l3
  %t35 = load i8*, i8** %l3
  %t36 = call i64 @sailfin_runtime_string_length(i8* %t35)
  %t37 = icmp eq i64 %t36, 0
  %t38 = load i8*, i8** %l0
  %t39 = load i1, i1* %l1
  %t40 = load double, double* %l2
  %t41 = load i8*, i8** %l3
  br i1 %t37, label %then6, label %merge7
then6:
  %t42 = bitcast i8* null to %NativeStructField*
  ret %NativeStructField* %t42
merge7:
  %t43 = load i8*, i8** %l0
  %t44 = load double, double* %l2
  %t45 = sitofp i64 2 to double
  %t46 = fadd double %t44, %t45
  %t47 = load i8*, i8** %l0
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = call double @llvm.round.f64(double %t46)
  %t50 = fptosi double %t49 to i64
  %t51 = call i8* @sailfin_runtime_substring(i8* %t43, i64 %t50, i64 %t48)
  %t52 = call i8* @trim_text(i8* %t51)
  store i8* %t52, i8** %l4
  %t53 = load i8*, i8** %l3
  %t54 = insertvalue %NativeStructField undef, i8* %t53, 0
  %t55 = load i8*, i8** %l4
  %t56 = insertvalue %NativeStructField %t54, i8* %t55, 1
  %t57 = load i1, i1* %l1
  %t58 = insertvalue %NativeStructField %t56, i1 %t57, 2
  %t59 = alloca %NativeStructField
  store %NativeStructField %t58, %NativeStructField* %t59
  ret %NativeStructField* %t59
}

define %StructLayoutHeaderParse @parse_struct_layout_header(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca double
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i8*
  %l11 = alloca %NumberParseResult
  %l12 = alloca i8*
  %l13 = alloca %NumberParseResult
  %l14 = alloca i1
  %t0 = call i8* @trim_text(i8* %text)
  %t1 = call { i8**, i64 }* @split_whitespace(i8* %t0)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  %t2 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t3 = ptrtoint [0 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t9 = ptrtoint { i8**, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { i8**, i64 }*
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 0
  store i8** %t7, i8*** %t12
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { i8**, i64 }* %t11, { i8**, i64 }** %l1
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t14
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = icmp eq i64 %t16, 0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t17, label %then0, label %merge1
then0:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s21 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h414094739, i32 0, i32 0
  %t22 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t20, i8* %s21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l1
  %t23 = insertvalue %StructLayoutHeaderParse undef, i1 0, 0
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t25 = insertvalue %StructLayoutHeaderParse %t23, i8* %s24, 1
  %t26 = sitofp i64 0 to double
  %t27 = insertvalue %StructLayoutHeaderParse %t25, double %t26, 2
  %t28 = sitofp i64 0 to double
  %t29 = insertvalue %StructLayoutHeaderParse %t27, double %t28, 3
  %t30 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t31 = insertvalue %StructLayoutHeaderParse %t29, { i8**, i64 }* %t30, 4
  ret %StructLayoutHeaderParse %t31
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s32 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s32, i8** %l5
  %t33 = sitofp i64 0 to double
  store double %t33, double* %l6
  %t34 = sitofp i64 0 to double
  store double %t34, double* %l7
  %t35 = sitofp i64 0 to double
  store double %t35, double* %l8
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t38 = load i1, i1* %l2
  %t39 = load i1, i1* %l3
  %t40 = load i1, i1* %l4
  %t41 = load i8*, i8** %l5
  %t42 = load double, double* %l6
  %t43 = load double, double* %l7
  %t44 = load double, double* %l8
  br label %loop.header2
loop.header2:
  %t245 = phi i8* [ %t41, %merge1 ], [ %t237, %loop.latch4 ]
  %t246 = phi i1 [ %t38, %merge1 ], [ %t238, %loop.latch4 ]
  %t247 = phi i1 [ %t39, %merge1 ], [ %t239, %loop.latch4 ]
  %t248 = phi double [ %t42, %merge1 ], [ %t240, %loop.latch4 ]
  %t249 = phi { i8**, i64 }* [ %t37, %merge1 ], [ %t241, %loop.latch4 ]
  %t250 = phi i1 [ %t40, %merge1 ], [ %t242, %loop.latch4 ]
  %t251 = phi double [ %t43, %merge1 ], [ %t243, %loop.latch4 ]
  %t252 = phi double [ %t44, %merge1 ], [ %t244, %loop.latch4 ]
  store i8* %t245, i8** %l5
  store i1 %t246, i1* %l2
  store i1 %t247, i1* %l3
  store double %t248, double* %l6
  store { i8**, i64 }* %t249, { i8**, i64 }** %l1
  store i1 %t250, i1* %l4
  store double %t251, double* %l7
  store double %t252, double* %l8
  br label %loop.body3
loop.body3:
  %t45 = load double, double* %l8
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t47 = load { i8**, i64 }, { i8**, i64 }* %t46
  %t48 = extractvalue { i8**, i64 } %t47, 1
  %t49 = sitofp i64 %t48 to double
  %t50 = fcmp oge double %t45, %t49
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t53 = load i1, i1* %l2
  %t54 = load i1, i1* %l3
  %t55 = load i1, i1* %l4
  %t56 = load i8*, i8** %l5
  %t57 = load double, double* %l6
  %t58 = load double, double* %l7
  %t59 = load double, double* %l8
  br i1 %t50, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load double, double* %l8
  %t62 = call double @llvm.round.f64(double %t61)
  %t63 = fptosi double %t62 to i64
  %t64 = load { i8**, i64 }, { i8**, i64 }* %t60
  %t65 = extractvalue { i8**, i64 } %t64, 0
  %t66 = extractvalue { i8**, i64 } %t64, 1
  %t67 = icmp uge i64 %t63, %t66
  ; bounds check: %t67 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t63, i64 %t66)
  %t68 = getelementptr i8*, i8** %t65, i64 %t63
  %t69 = load i8*, i8** %t68
  store i8* %t69, i8** %l9
  %t70 = load i8*, i8** %l9
  %s71 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h261048910, i32 0, i32 0
  %t72 = call i1 @starts_with(i8* %t70, i8* %s71)
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t75 = load i1, i1* %l2
  %t76 = load i1, i1* %l3
  %t77 = load i1, i1* %l4
  %t78 = load i8*, i8** %l5
  %t79 = load double, double* %l6
  %t80 = load double, double* %l7
  %t81 = load double, double* %l8
  %t82 = load i8*, i8** %l9
  br i1 %t72, label %then8, label %else9
then8:
  %t83 = load i8*, i8** %l9
  %t84 = load i8*, i8** %l9
  %t85 = call i64 @sailfin_runtime_string_length(i8* %t84)
  %t86 = call i8* @sailfin_runtime_substring(i8* %t83, i64 5, i64 %t85)
  store i8* %t86, i8** %l5
  store i1 1, i1* %l2
  %t87 = load i8*, i8** %l5
  %t88 = load i1, i1* %l2
  br label %merge10
else9:
  %t89 = load i8*, i8** %l9
  %s90 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t91 = call i1 @starts_with(i8* %t89, i8* %s90)
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load i1, i1* %l2
  %t95 = load i1, i1* %l3
  %t96 = load i1, i1* %l4
  %t97 = load i8*, i8** %l5
  %t98 = load double, double* %l6
  %t99 = load double, double* %l7
  %t100 = load double, double* %l8
  %t101 = load i8*, i8** %l9
  br i1 %t91, label %then11, label %else12
then11:
  %t102 = load i8*, i8** %l9
  %t103 = load i8*, i8** %l9
  %t104 = call i64 @sailfin_runtime_string_length(i8* %t103)
  %t105 = call i8* @sailfin_runtime_substring(i8* %t102, i64 5, i64 %t104)
  store i8* %t105, i8** %l10
  %t106 = load i8*, i8** %l10
  %t107 = call %NumberParseResult @parse_decimal_number(i8* %t106)
  store %NumberParseResult %t107, %NumberParseResult* %l11
  %t108 = load %NumberParseResult, %NumberParseResult* %l11
  %t109 = extractvalue %NumberParseResult %t108, 0
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = load i1, i1* %l2
  %t113 = load i1, i1* %l3
  %t114 = load i1, i1* %l4
  %t115 = load i8*, i8** %l5
  %t116 = load double, double* %l6
  %t117 = load double, double* %l7
  %t118 = load double, double* %l8
  %t119 = load i8*, i8** %l9
  %t120 = load i8*, i8** %l10
  %t121 = load %NumberParseResult, %NumberParseResult* %l11
  br i1 %t109, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t122 = load %NumberParseResult, %NumberParseResult* %l11
  %t123 = extractvalue %NumberParseResult %t122, 1
  store double %t123, double* %l6
  %t124 = load i1, i1* %l3
  %t125 = load double, double* %l6
  br label %merge16
else15:
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s127 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h943297157, i32 0, i32 0
  %t128 = load i8*, i8** %l10
  %t129 = call i8* @sailfin_runtime_string_concat(i8* %s127, i8* %t128)
  %t130 = alloca [2 x i8], align 1
  %t131 = getelementptr [2 x i8], [2 x i8]* %t130, i32 0, i32 0
  store i8 96, i8* %t131
  %t132 = getelementptr [2 x i8], [2 x i8]* %t130, i32 0, i32 1
  store i8 0, i8* %t132
  %t133 = getelementptr [2 x i8], [2 x i8]* %t130, i32 0, i32 0
  %t134 = call i8* @sailfin_runtime_string_concat(i8* %t129, i8* %t133)
  %t135 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t126, i8* %t134)
  store { i8**, i64 }* %t135, { i8**, i64 }** %l1
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t137 = phi i1 [ %t124, %then14 ], [ %t113, %else15 ]
  %t138 = phi double [ %t125, %then14 ], [ %t116, %else15 ]
  %t139 = phi { i8**, i64 }* [ %t111, %then14 ], [ %t136, %else15 ]
  store i1 %t137, i1* %l3
  store double %t138, double* %l6
  store { i8**, i64 }* %t139, { i8**, i64 }** %l1
  %t140 = load i1, i1* %l3
  %t141 = load double, double* %l6
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t143 = load i8*, i8** %l9
  %s144 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t145 = call i1 @starts_with(i8* %t143, i8* %s144)
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t148 = load i1, i1* %l2
  %t149 = load i1, i1* %l3
  %t150 = load i1, i1* %l4
  %t151 = load i8*, i8** %l5
  %t152 = load double, double* %l6
  %t153 = load double, double* %l7
  %t154 = load double, double* %l8
  %t155 = load i8*, i8** %l9
  br i1 %t145, label %then17, label %else18
then17:
  %t156 = load i8*, i8** %l9
  %t157 = load i8*, i8** %l9
  %t158 = call i64 @sailfin_runtime_string_length(i8* %t157)
  %t159 = call i8* @sailfin_runtime_substring(i8* %t156, i64 6, i64 %t158)
  store i8* %t159, i8** %l12
  %t160 = load i8*, i8** %l12
  %t161 = call %NumberParseResult @parse_decimal_number(i8* %t160)
  store %NumberParseResult %t161, %NumberParseResult* %l13
  %t162 = load %NumberParseResult, %NumberParseResult* %l13
  %t163 = extractvalue %NumberParseResult %t162, 0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t165 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t166 = load i1, i1* %l2
  %t167 = load i1, i1* %l3
  %t168 = load i1, i1* %l4
  %t169 = load i8*, i8** %l5
  %t170 = load double, double* %l6
  %t171 = load double, double* %l7
  %t172 = load double, double* %l8
  %t173 = load i8*, i8** %l9
  %t174 = load i8*, i8** %l12
  %t175 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t163, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t176 = load %NumberParseResult, %NumberParseResult* %l13
  %t177 = extractvalue %NumberParseResult %t176, 1
  store double %t177, double* %l7
  %t178 = load i1, i1* %l4
  %t179 = load double, double* %l7
  br label %merge22
else21:
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s181 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h1650449248, i32 0, i32 0
  %t182 = load i8*, i8** %l12
  %t183 = call i8* @sailfin_runtime_string_concat(i8* %s181, i8* %t182)
  %t184 = alloca [2 x i8], align 1
  %t185 = getelementptr [2 x i8], [2 x i8]* %t184, i32 0, i32 0
  store i8 96, i8* %t185
  %t186 = getelementptr [2 x i8], [2 x i8]* %t184, i32 0, i32 1
  store i8 0, i8* %t186
  %t187 = getelementptr [2 x i8], [2 x i8]* %t184, i32 0, i32 0
  %t188 = call i8* @sailfin_runtime_string_concat(i8* %t183, i8* %t187)
  %t189 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t180, i8* %t188)
  store { i8**, i64 }* %t189, { i8**, i64 }** %l1
  %t190 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t191 = phi i1 [ %t178, %then20 ], [ %t168, %else21 ]
  %t192 = phi double [ %t179, %then20 ], [ %t171, %else21 ]
  %t193 = phi { i8**, i64 }* [ %t165, %then20 ], [ %t190, %else21 ]
  store i1 %t191, i1* %l4
  store double %t192, double* %l7
  store { i8**, i64 }* %t193, { i8**, i64 }** %l1
  %t194 = load i1, i1* %l4
  %t195 = load double, double* %l7
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s198 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1415177535, i32 0, i32 0
  %t199 = load i8*, i8** %l9
  %t200 = call i8* @sailfin_runtime_string_concat(i8* %s198, i8* %t199)
  %t201 = alloca [2 x i8], align 1
  %t202 = getelementptr [2 x i8], [2 x i8]* %t201, i32 0, i32 0
  store i8 96, i8* %t202
  %t203 = getelementptr [2 x i8], [2 x i8]* %t201, i32 0, i32 1
  store i8 0, i8* %t203
  %t204 = getelementptr [2 x i8], [2 x i8]* %t201, i32 0, i32 0
  %t205 = call i8* @sailfin_runtime_string_concat(i8* %t200, i8* %t204)
  %t206 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t197, i8* %t205)
  store { i8**, i64 }* %t206, { i8**, i64 }** %l1
  %t207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t208 = phi i1 [ %t194, %merge22 ], [ %t150, %else18 ]
  %t209 = phi double [ %t195, %merge22 ], [ %t153, %else18 ]
  %t210 = phi { i8**, i64 }* [ %t196, %merge22 ], [ %t207, %else18 ]
  store i1 %t208, i1* %l4
  store double %t209, double* %l7
  store { i8**, i64 }* %t210, { i8**, i64 }** %l1
  %t211 = load i1, i1* %l4
  %t212 = load double, double* %l7
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t215 = phi i1 [ %t140, %merge16 ], [ %t95, %merge19 ]
  %t216 = phi double [ %t141, %merge16 ], [ %t98, %merge19 ]
  %t217 = phi { i8**, i64 }* [ %t142, %merge16 ], [ %t213, %merge19 ]
  %t218 = phi i1 [ %t96, %merge16 ], [ %t211, %merge19 ]
  %t219 = phi double [ %t99, %merge16 ], [ %t212, %merge19 ]
  store i1 %t215, i1* %l3
  store double %t216, double* %l6
  store { i8**, i64 }* %t217, { i8**, i64 }** %l1
  store i1 %t218, i1* %l4
  store double %t219, double* %l7
  %t220 = load i1, i1* %l3
  %t221 = load double, double* %l6
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load i1, i1* %l4
  %t224 = load double, double* %l7
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t227 = phi i8* [ %t87, %then8 ], [ %t78, %merge13 ]
  %t228 = phi i1 [ %t88, %then8 ], [ %t75, %merge13 ]
  %t229 = phi i1 [ %t76, %then8 ], [ %t220, %merge13 ]
  %t230 = phi double [ %t79, %then8 ], [ %t221, %merge13 ]
  %t231 = phi { i8**, i64 }* [ %t74, %then8 ], [ %t222, %merge13 ]
  %t232 = phi i1 [ %t77, %then8 ], [ %t223, %merge13 ]
  %t233 = phi double [ %t80, %then8 ], [ %t224, %merge13 ]
  store i8* %t227, i8** %l5
  store i1 %t228, i1* %l2
  store i1 %t229, i1* %l3
  store double %t230, double* %l6
  store { i8**, i64 }* %t231, { i8**, i64 }** %l1
  store i1 %t232, i1* %l4
  store double %t233, double* %l7
  %t234 = load double, double* %l8
  %t235 = sitofp i64 1 to double
  %t236 = fadd double %t234, %t235
  store double %t236, double* %l8
  br label %loop.latch4
loop.latch4:
  %t237 = load i8*, i8** %l5
  %t238 = load i1, i1* %l2
  %t239 = load i1, i1* %l3
  %t240 = load double, double* %l6
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t242 = load i1, i1* %l4
  %t243 = load double, double* %l7
  %t244 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t253 = load i8*, i8** %l5
  %t254 = load i1, i1* %l2
  %t255 = load i1, i1* %l3
  %t256 = load double, double* %l6
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t258 = load i1, i1* %l4
  %t259 = load double, double* %l7
  %t260 = load double, double* %l8
  %t261 = load i1, i1* %l3
  %t262 = xor i1 %t261, 1
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t265 = load i1, i1* %l2
  %t266 = load i1, i1* %l3
  %t267 = load i1, i1* %l4
  %t268 = load i8*, i8** %l5
  %t269 = load double, double* %l6
  %t270 = load double, double* %l7
  %t271 = load double, double* %l8
  br i1 %t262, label %then23, label %merge24
then23:
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s273 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1399971520, i32 0, i32 0
  %t274 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t272, i8* %s273)
  store { i8**, i64 }* %t274, { i8**, i64 }** %l1
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t276 = phi { i8**, i64 }* [ %t275, %then23 ], [ %t264, %afterloop5 ]
  store { i8**, i64 }* %t276, { i8**, i64 }** %l1
  %t277 = load i1, i1* %l4
  %t278 = xor i1 %t277, 1
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t281 = load i1, i1* %l2
  %t282 = load i1, i1* %l3
  %t283 = load i1, i1* %l4
  %t284 = load i8*, i8** %l5
  %t285 = load double, double* %l6
  %t286 = load double, double* %l7
  %t287 = load double, double* %l8
  br i1 %t278, label %then25, label %merge26
then25:
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s289 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h318366654, i32 0, i32 0
  %t290 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t288, i8* %s289)
  store { i8**, i64 }* %t290, { i8**, i64 }** %l1
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t292 = phi { i8**, i64 }* [ %t291, %then25 ], [ %t280, %merge24 ]
  store { i8**, i64 }* %t292, { i8**, i64 }** %l1
  %t294 = load i1, i1* %l3
  br label %logical_and_entry_293

logical_and_entry_293:
  br i1 %t294, label %logical_and_right_293, label %logical_and_merge_293

logical_and_right_293:
  %t296 = load i1, i1* %l4
  br label %logical_and_entry_295

logical_and_entry_295:
  br i1 %t296, label %logical_and_right_295, label %logical_and_merge_295

logical_and_right_295:
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t298 = load { i8**, i64 }, { i8**, i64 }* %t297
  %t299 = extractvalue { i8**, i64 } %t298, 1
  %t300 = icmp eq i64 %t299, 0
  br label %logical_and_right_end_295

logical_and_right_end_295:
  br label %logical_and_merge_295

logical_and_merge_295:
  %t301 = phi i1 [ false, %logical_and_entry_295 ], [ %t300, %logical_and_right_end_295 ]
  br label %logical_and_right_end_293

logical_and_right_end_293:
  br label %logical_and_merge_293

logical_and_merge_293:
  %t302 = phi i1 [ false, %logical_and_entry_293 ], [ %t301, %logical_and_right_end_293 ]
  store i1 %t302, i1* %l14
  %t303 = load i1, i1* %l14
  %t304 = insertvalue %StructLayoutHeaderParse undef, i1 %t303, 0
  %t305 = load i8*, i8** %l5
  %t306 = insertvalue %StructLayoutHeaderParse %t304, i8* %t305, 1
  %t307 = load double, double* %l6
  %t308 = insertvalue %StructLayoutHeaderParse %t306, double %t307, 2
  %t309 = load double, double* %l7
  %t310 = insertvalue %StructLayoutHeaderParse %t308, double %t309, 3
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t312 = insertvalue %StructLayoutHeaderParse %t310, { i8**, i64 }* %t311, 4
  ret %StructLayoutHeaderParse %t312
}

define %StructLayoutFieldParse @parse_struct_layout_field(i8* %text, i8* %struct_name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeStructLayoutField
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca i1
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca %NumberParseResult
  %l16 = alloca i8*
  %l17 = alloca %NumberParseResult
  %l18 = alloca i8*
  %l19 = alloca %NumberParseResult
  %l20 = alloca i1
  %l21 = alloca %NativeStructLayoutField
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
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
  %s13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t14 = insertvalue %NativeStructLayoutField undef, i8* %s13, 0
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t16 = insertvalue %NativeStructLayoutField %t14, i8* %s15, 1
  %t17 = sitofp i64 0 to double
  %t18 = insertvalue %NativeStructLayoutField %t16, double %t17, 2
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %NativeStructLayoutField %t18, double %t19, 3
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %NativeStructLayoutField %t20, double %t21, 4
  store %NativeStructLayoutField %t22, %NativeStructLayoutField* %l2
  %t23 = load i8*, i8** %l0
  %t24 = call i64 @sailfin_runtime_string_length(i8* %t23)
  %t25 = icmp eq i64 %t24, 0
  %t26 = load i8*, i8** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t25, label %then0, label %merge1
then0:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s30 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %s30, i8* %struct_name)
  %s32 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h128952257, i32 0, i32 0
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %s32)
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t29, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l1
  %t35 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t36 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t37 = insertvalue %StructLayoutFieldParse %t35, %NativeStructLayoutField %t36, 1
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t39 = insertvalue %StructLayoutFieldParse %t37, { i8**, i64 }* %t38, 2
  ret %StructLayoutFieldParse %t39
merge1:
  %t40 = load i8*, i8** %l0
  %t41 = call { i8**, i64 }* @split_whitespace(i8* %t40)
  store { i8**, i64 }* %t41, { i8**, i64 }** %l3
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t43 = load { i8**, i64 }, { i8**, i64 }* %t42
  %t44 = extractvalue { i8**, i64 } %t43, 1
  %t45 = icmp eq i64 %t44, 0
  %t46 = load i8*, i8** %l0
  %t47 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t48 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t45, label %then2, label %merge3
then2:
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s51 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t52 = call i8* @sailfin_runtime_string_concat(i8* %s51, i8* %struct_name)
  %s53 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h555082439, i32 0, i32 0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %t52, i8* %s53)
  %t55 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t50, i8* %t54)
  store { i8**, i64 }* %t55, { i8**, i64 }** %l1
  %t56 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t57 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t58 = insertvalue %StructLayoutFieldParse %t56, %NativeStructLayoutField %t57, 1
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t60 = insertvalue %StructLayoutFieldParse %t58, { i8**, i64 }* %t59, 2
  ret %StructLayoutFieldParse %t60
merge3:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t62 = load { i8**, i64 }, { i8**, i64 }* %t61
  %t63 = extractvalue { i8**, i64 } %t62, 0
  %t64 = extractvalue { i8**, i64 } %t62, 1
  %t65 = icmp uge i64 0, %t64
  ; bounds check: %t65 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t64)
  %t66 = getelementptr i8*, i8** %t63, i64 0
  %t67 = load i8*, i8** %t66
  store i8* %t67, i8** %l4
  %t68 = load i8*, i8** %l4
  %t69 = call i64 @sailfin_runtime_string_length(i8* %t68)
  %t70 = icmp eq i64 %t69, 0
  %t71 = load i8*, i8** %l0
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load i8*, i8** %l4
  br i1 %t70, label %then4, label %merge5
then4:
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s77 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t78 = call i8* @sailfin_runtime_string_concat(i8* %s77, i8* %struct_name)
  %s79 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h130324785, i32 0, i32 0
  %t80 = call i8* @sailfin_runtime_string_concat(i8* %t78, i8* %s79)
  %t81 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t76, i8* %t80)
  store { i8**, i64 }* %t81, { i8**, i64 }** %l1
  %t82 = insertvalue %StructLayoutFieldParse undef, i1 0, 0
  %t83 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t84 = insertvalue %StructLayoutFieldParse %t82, %NativeStructLayoutField %t83, 1
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = insertvalue %StructLayoutFieldParse %t84, { i8**, i64 }* %t85, 2
  ret %StructLayoutFieldParse %t86
merge5:
  %s87 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s87, i8** %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t88 = sitofp i64 0 to double
  store double %t88, double* %l9
  %t89 = sitofp i64 0 to double
  store double %t89, double* %l10
  %t90 = sitofp i64 0 to double
  store double %t90, double* %l11
  %t91 = sitofp i64 1 to double
  store double %t91, double* %l12
  %t92 = load i8*, i8** %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t96 = load i8*, i8** %l4
  %t97 = load i8*, i8** %l5
  %t98 = load i1, i1* %l6
  %t99 = load i1, i1* %l7
  %t100 = load i1, i1* %l8
  %t101 = load double, double* %l9
  %t102 = load double, double* %l10
  %t103 = load double, double* %l11
  %t104 = load double, double* %l12
  br label %loop.header6
loop.header6:
  %t437 = phi i8* [ %t97, %merge5 ], [ %t428, %loop.latch8 ]
  %t438 = phi i1 [ %t98, %merge5 ], [ %t429, %loop.latch8 ]
  %t439 = phi double [ %t101, %merge5 ], [ %t430, %loop.latch8 ]
  %t440 = phi { i8**, i64 }* [ %t93, %merge5 ], [ %t431, %loop.latch8 ]
  %t441 = phi i1 [ %t99, %merge5 ], [ %t432, %loop.latch8 ]
  %t442 = phi double [ %t102, %merge5 ], [ %t433, %loop.latch8 ]
  %t443 = phi i1 [ %t100, %merge5 ], [ %t434, %loop.latch8 ]
  %t444 = phi double [ %t103, %merge5 ], [ %t435, %loop.latch8 ]
  %t445 = phi double [ %t104, %merge5 ], [ %t436, %loop.latch8 ]
  store i8* %t437, i8** %l5
  store i1 %t438, i1* %l6
  store double %t439, double* %l9
  store { i8**, i64 }* %t440, { i8**, i64 }** %l1
  store i1 %t441, i1* %l7
  store double %t442, double* %l10
  store i1 %t443, i1* %l8
  store double %t444, double* %l11
  store double %t445, double* %l12
  br label %loop.body7
loop.body7:
  %t105 = load double, double* %l12
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t107 = load { i8**, i64 }, { i8**, i64 }* %t106
  %t108 = extractvalue { i8**, i64 } %t107, 1
  %t109 = sitofp i64 %t108 to double
  %t110 = fcmp oge double %t105, %t109
  %t111 = load i8*, i8** %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t115 = load i8*, i8** %l4
  %t116 = load i8*, i8** %l5
  %t117 = load i1, i1* %l6
  %t118 = load i1, i1* %l7
  %t119 = load i1, i1* %l8
  %t120 = load double, double* %l9
  %t121 = load double, double* %l10
  %t122 = load double, double* %l11
  %t123 = load double, double* %l12
  br i1 %t110, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t125 = load double, double* %l12
  %t126 = call double @llvm.round.f64(double %t125)
  %t127 = fptosi double %t126 to i64
  %t128 = load { i8**, i64 }, { i8**, i64 }* %t124
  %t129 = extractvalue { i8**, i64 } %t128, 0
  %t130 = extractvalue { i8**, i64 } %t128, 1
  %t131 = icmp uge i64 %t127, %t130
  ; bounds check: %t131 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t127, i64 %t130)
  %t132 = getelementptr i8*, i8** %t129, i64 %t127
  %t133 = load i8*, i8** %t132
  store i8* %t133, i8** %l13
  %t134 = load i8*, i8** %l13
  %s135 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h524431183, i32 0, i32 0
  %t136 = call i1 @starts_with(i8* %t134, i8* %s135)
  %t137 = load i8*, i8** %l0
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t139 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t141 = load i8*, i8** %l4
  %t142 = load i8*, i8** %l5
  %t143 = load i1, i1* %l6
  %t144 = load i1, i1* %l7
  %t145 = load i1, i1* %l8
  %t146 = load double, double* %l9
  %t147 = load double, double* %l10
  %t148 = load double, double* %l11
  %t149 = load double, double* %l12
  %t150 = load i8*, i8** %l13
  br i1 %t136, label %then12, label %else13
then12:
  %t151 = load i8*, i8** %l13
  %t152 = load i8*, i8** %l13
  %t153 = call i64 @sailfin_runtime_string_length(i8* %t152)
  %t154 = call i8* @sailfin_runtime_substring(i8* %t151, i64 5, i64 %t153)
  store i8* %t154, i8** %l5
  %t155 = load i8*, i8** %l5
  br label %merge14
else13:
  %t156 = load i8*, i8** %l13
  %s157 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t158 = call i1 @starts_with(i8* %t156, i8* %s157)
  %t159 = load i8*, i8** %l0
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t161 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t162 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t163 = load i8*, i8** %l4
  %t164 = load i8*, i8** %l5
  %t165 = load i1, i1* %l6
  %t166 = load i1, i1* %l7
  %t167 = load i1, i1* %l8
  %t168 = load double, double* %l9
  %t169 = load double, double* %l10
  %t170 = load double, double* %l11
  %t171 = load double, double* %l12
  %t172 = load i8*, i8** %l13
  br i1 %t158, label %then15, label %else16
then15:
  %t173 = load i8*, i8** %l13
  %t174 = load i8*, i8** %l13
  %t175 = call i64 @sailfin_runtime_string_length(i8* %t174)
  %t176 = call i8* @sailfin_runtime_substring(i8* %t173, i64 7, i64 %t175)
  store i8* %t176, i8** %l14
  %t177 = load i8*, i8** %l14
  %t178 = call %NumberParseResult @parse_decimal_number(i8* %t177)
  store %NumberParseResult %t178, %NumberParseResult* %l15
  %t179 = load %NumberParseResult, %NumberParseResult* %l15
  %t180 = extractvalue %NumberParseResult %t179, 0
  %t181 = load i8*, i8** %l0
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t183 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t185 = load i8*, i8** %l4
  %t186 = load i8*, i8** %l5
  %t187 = load i1, i1* %l6
  %t188 = load i1, i1* %l7
  %t189 = load i1, i1* %l8
  %t190 = load double, double* %l9
  %t191 = load double, double* %l10
  %t192 = load double, double* %l11
  %t193 = load double, double* %l12
  %t194 = load i8*, i8** %l13
  %t195 = load i8*, i8** %l14
  %t196 = load %NumberParseResult, %NumberParseResult* %l15
  br i1 %t180, label %then18, label %else19
then18:
  store i1 1, i1* %l6
  %t197 = load %NumberParseResult, %NumberParseResult* %l15
  %t198 = extractvalue %NumberParseResult %t197, 1
  store double %t198, double* %l9
  %t199 = load i1, i1* %l6
  %t200 = load double, double* %l9
  br label %merge20
else19:
  %t201 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s202 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t203 = call i8* @sailfin_runtime_string_concat(i8* %s202, i8* %struct_name)
  %s204 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t205 = call i8* @sailfin_runtime_string_concat(i8* %t203, i8* %s204)
  %t206 = load i8*, i8** %l4
  %t207 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %t206)
  %s208 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t209 = call i8* @sailfin_runtime_string_concat(i8* %t207, i8* %s208)
  %t210 = load i8*, i8** %l14
  %t211 = call i8* @sailfin_runtime_string_concat(i8* %t209, i8* %t210)
  %t212 = alloca [2 x i8], align 1
  %t213 = getelementptr [2 x i8], [2 x i8]* %t212, i32 0, i32 0
  store i8 96, i8* %t213
  %t214 = getelementptr [2 x i8], [2 x i8]* %t212, i32 0, i32 1
  store i8 0, i8* %t214
  %t215 = getelementptr [2 x i8], [2 x i8]* %t212, i32 0, i32 0
  %t216 = call i8* @sailfin_runtime_string_concat(i8* %t211, i8* %t215)
  %t217 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t201, i8* %t216)
  store { i8**, i64 }* %t217, { i8**, i64 }** %l1
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t219 = phi i1 [ %t199, %then18 ], [ %t187, %else19 ]
  %t220 = phi double [ %t200, %then18 ], [ %t190, %else19 ]
  %t221 = phi { i8**, i64 }* [ %t182, %then18 ], [ %t218, %else19 ]
  store i1 %t219, i1* %l6
  store double %t220, double* %l9
  store { i8**, i64 }* %t221, { i8**, i64 }** %l1
  %t222 = load i1, i1* %l6
  %t223 = load double, double* %l9
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t225 = load i8*, i8** %l13
  %s226 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t227 = call i1 @starts_with(i8* %t225, i8* %s226)
  %t228 = load i8*, i8** %l0
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t230 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t231 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t232 = load i8*, i8** %l4
  %t233 = load i8*, i8** %l5
  %t234 = load i1, i1* %l6
  %t235 = load i1, i1* %l7
  %t236 = load i1, i1* %l8
  %t237 = load double, double* %l9
  %t238 = load double, double* %l10
  %t239 = load double, double* %l11
  %t240 = load double, double* %l12
  %t241 = load i8*, i8** %l13
  br i1 %t227, label %then21, label %else22
then21:
  %t242 = load i8*, i8** %l13
  %t243 = load i8*, i8** %l13
  %t244 = call i64 @sailfin_runtime_string_length(i8* %t243)
  %t245 = call i8* @sailfin_runtime_substring(i8* %t242, i64 5, i64 %t244)
  store i8* %t245, i8** %l16
  %t246 = load i8*, i8** %l16
  %t247 = call %NumberParseResult @parse_decimal_number(i8* %t246)
  store %NumberParseResult %t247, %NumberParseResult* %l17
  %t248 = load %NumberParseResult, %NumberParseResult* %l17
  %t249 = extractvalue %NumberParseResult %t248, 0
  %t250 = load i8*, i8** %l0
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t252 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t254 = load i8*, i8** %l4
  %t255 = load i8*, i8** %l5
  %t256 = load i1, i1* %l6
  %t257 = load i1, i1* %l7
  %t258 = load i1, i1* %l8
  %t259 = load double, double* %l9
  %t260 = load double, double* %l10
  %t261 = load double, double* %l11
  %t262 = load double, double* %l12
  %t263 = load i8*, i8** %l13
  %t264 = load i8*, i8** %l16
  %t265 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t249, label %then24, label %else25
then24:
  store i1 1, i1* %l7
  %t266 = load %NumberParseResult, %NumberParseResult* %l17
  %t267 = extractvalue %NumberParseResult %t266, 1
  store double %t267, double* %l10
  %t268 = load i1, i1* %l7
  %t269 = load double, double* %l10
  br label %merge26
else25:
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s271 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t272 = call i8* @sailfin_runtime_string_concat(i8* %s271, i8* %struct_name)
  %s273 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t274 = call i8* @sailfin_runtime_string_concat(i8* %t272, i8* %s273)
  %t275 = load i8*, i8** %l4
  %t276 = call i8* @sailfin_runtime_string_concat(i8* %t274, i8* %t275)
  %s277 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t278 = call i8* @sailfin_runtime_string_concat(i8* %t276, i8* %s277)
  %t279 = load i8*, i8** %l16
  %t280 = call i8* @sailfin_runtime_string_concat(i8* %t278, i8* %t279)
  %t281 = alloca [2 x i8], align 1
  %t282 = getelementptr [2 x i8], [2 x i8]* %t281, i32 0, i32 0
  store i8 96, i8* %t282
  %t283 = getelementptr [2 x i8], [2 x i8]* %t281, i32 0, i32 1
  store i8 0, i8* %t283
  %t284 = getelementptr [2 x i8], [2 x i8]* %t281, i32 0, i32 0
  %t285 = call i8* @sailfin_runtime_string_concat(i8* %t280, i8* %t284)
  %t286 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t270, i8* %t285)
  store { i8**, i64 }* %t286, { i8**, i64 }** %l1
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t288 = phi i1 [ %t268, %then24 ], [ %t257, %else25 ]
  %t289 = phi double [ %t269, %then24 ], [ %t260, %else25 ]
  %t290 = phi { i8**, i64 }* [ %t251, %then24 ], [ %t287, %else25 ]
  store i1 %t288, i1* %l7
  store double %t289, double* %l10
  store { i8**, i64 }* %t290, { i8**, i64 }** %l1
  %t291 = load i1, i1* %l7
  %t292 = load double, double* %l10
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t294 = load i8*, i8** %l13
  %s295 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t296 = call i1 @starts_with(i8* %t294, i8* %s295)
  %t297 = load i8*, i8** %l0
  %t298 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t299 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t300 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t301 = load i8*, i8** %l4
  %t302 = load i8*, i8** %l5
  %t303 = load i1, i1* %l6
  %t304 = load i1, i1* %l7
  %t305 = load i1, i1* %l8
  %t306 = load double, double* %l9
  %t307 = load double, double* %l10
  %t308 = load double, double* %l11
  %t309 = load double, double* %l12
  %t310 = load i8*, i8** %l13
  br i1 %t296, label %then27, label %else28
then27:
  %t311 = load i8*, i8** %l13
  %t312 = load i8*, i8** %l13
  %t313 = call i64 @sailfin_runtime_string_length(i8* %t312)
  %t314 = call i8* @sailfin_runtime_substring(i8* %t311, i64 6, i64 %t313)
  store i8* %t314, i8** %l18
  %t315 = load i8*, i8** %l18
  %t316 = call %NumberParseResult @parse_decimal_number(i8* %t315)
  store %NumberParseResult %t316, %NumberParseResult* %l19
  %t317 = load %NumberParseResult, %NumberParseResult* %l19
  %t318 = extractvalue %NumberParseResult %t317, 0
  %t319 = load i8*, i8** %l0
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t321 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t323 = load i8*, i8** %l4
  %t324 = load i8*, i8** %l5
  %t325 = load i1, i1* %l6
  %t326 = load i1, i1* %l7
  %t327 = load i1, i1* %l8
  %t328 = load double, double* %l9
  %t329 = load double, double* %l10
  %t330 = load double, double* %l11
  %t331 = load double, double* %l12
  %t332 = load i8*, i8** %l13
  %t333 = load i8*, i8** %l18
  %t334 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t318, label %then30, label %else31
then30:
  store i1 1, i1* %l8
  %t335 = load %NumberParseResult, %NumberParseResult* %l19
  %t336 = extractvalue %NumberParseResult %t335, 1
  store double %t336, double* %l11
  %t337 = load i1, i1* %l8
  %t338 = load double, double* %l11
  br label %merge32
else31:
  %t339 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s340 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t341 = call i8* @sailfin_runtime_string_concat(i8* %s340, i8* %struct_name)
  %s342 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t343 = call i8* @sailfin_runtime_string_concat(i8* %t341, i8* %s342)
  %t344 = load i8*, i8** %l4
  %t345 = call i8* @sailfin_runtime_string_concat(i8* %t343, i8* %t344)
  %s346 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t347 = call i8* @sailfin_runtime_string_concat(i8* %t345, i8* %s346)
  %t348 = load i8*, i8** %l18
  %t349 = call i8* @sailfin_runtime_string_concat(i8* %t347, i8* %t348)
  %t350 = alloca [2 x i8], align 1
  %t351 = getelementptr [2 x i8], [2 x i8]* %t350, i32 0, i32 0
  store i8 96, i8* %t351
  %t352 = getelementptr [2 x i8], [2 x i8]* %t350, i32 0, i32 1
  store i8 0, i8* %t352
  %t353 = getelementptr [2 x i8], [2 x i8]* %t350, i32 0, i32 0
  %t354 = call i8* @sailfin_runtime_string_concat(i8* %t349, i8* %t353)
  %t355 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t339, i8* %t354)
  store { i8**, i64 }* %t355, { i8**, i64 }** %l1
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t357 = phi i1 [ %t337, %then30 ], [ %t327, %else31 ]
  %t358 = phi double [ %t338, %then30 ], [ %t330, %else31 ]
  %t359 = phi { i8**, i64 }* [ %t320, %then30 ], [ %t356, %else31 ]
  store i1 %t357, i1* %l8
  store double %t358, double* %l11
  store { i8**, i64 }* %t359, { i8**, i64 }** %l1
  %t360 = load i1, i1* %l8
  %t361 = load double, double* %l11
  %t362 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s364 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t365 = call i8* @sailfin_runtime_string_concat(i8* %s364, i8* %struct_name)
  %s366 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t367 = call i8* @sailfin_runtime_string_concat(i8* %t365, i8* %s366)
  %t368 = load i8*, i8** %l4
  %t369 = call i8* @sailfin_runtime_string_concat(i8* %t367, i8* %t368)
  %s370 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t371 = call i8* @sailfin_runtime_string_concat(i8* %t369, i8* %s370)
  %t372 = load i8*, i8** %l13
  %t373 = call i8* @sailfin_runtime_string_concat(i8* %t371, i8* %t372)
  %t374 = alloca [2 x i8], align 1
  %t375 = getelementptr [2 x i8], [2 x i8]* %t374, i32 0, i32 0
  store i8 96, i8* %t375
  %t376 = getelementptr [2 x i8], [2 x i8]* %t374, i32 0, i32 1
  store i8 0, i8* %t376
  %t377 = getelementptr [2 x i8], [2 x i8]* %t374, i32 0, i32 0
  %t378 = call i8* @sailfin_runtime_string_concat(i8* %t373, i8* %t377)
  %t379 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t363, i8* %t378)
  store { i8**, i64 }* %t379, { i8**, i64 }** %l1
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t381 = phi i1 [ %t360, %merge32 ], [ %t305, %else28 ]
  %t382 = phi double [ %t361, %merge32 ], [ %t308, %else28 ]
  %t383 = phi { i8**, i64 }* [ %t362, %merge32 ], [ %t380, %else28 ]
  store i1 %t381, i1* %l8
  store double %t382, double* %l11
  store { i8**, i64 }* %t383, { i8**, i64 }** %l1
  %t384 = load i1, i1* %l8
  %t385 = load double, double* %l11
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t388 = phi i1 [ %t291, %merge26 ], [ %t235, %merge29 ]
  %t389 = phi double [ %t292, %merge26 ], [ %t238, %merge29 ]
  %t390 = phi { i8**, i64 }* [ %t293, %merge26 ], [ %t386, %merge29 ]
  %t391 = phi i1 [ %t236, %merge26 ], [ %t384, %merge29 ]
  %t392 = phi double [ %t239, %merge26 ], [ %t385, %merge29 ]
  store i1 %t388, i1* %l7
  store double %t389, double* %l10
  store { i8**, i64 }* %t390, { i8**, i64 }** %l1
  store i1 %t391, i1* %l8
  store double %t392, double* %l11
  %t393 = load i1, i1* %l7
  %t394 = load double, double* %l10
  %t395 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t396 = load i1, i1* %l8
  %t397 = load double, double* %l11
  %t398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t399 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t400 = phi i1 [ %t222, %merge20 ], [ %t165, %merge23 ]
  %t401 = phi double [ %t223, %merge20 ], [ %t168, %merge23 ]
  %t402 = phi { i8**, i64 }* [ %t224, %merge20 ], [ %t395, %merge23 ]
  %t403 = phi i1 [ %t166, %merge20 ], [ %t393, %merge23 ]
  %t404 = phi double [ %t169, %merge20 ], [ %t394, %merge23 ]
  %t405 = phi i1 [ %t167, %merge20 ], [ %t396, %merge23 ]
  %t406 = phi double [ %t170, %merge20 ], [ %t397, %merge23 ]
  store i1 %t400, i1* %l6
  store double %t401, double* %l9
  store { i8**, i64 }* %t402, { i8**, i64 }** %l1
  store i1 %t403, i1* %l7
  store double %t404, double* %l10
  store i1 %t405, i1* %l8
  store double %t406, double* %l11
  %t407 = load i1, i1* %l6
  %t408 = load double, double* %l9
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t410 = load i1, i1* %l7
  %t411 = load double, double* %l10
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t413 = load i1, i1* %l8
  %t414 = load double, double* %l11
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t417 = phi i8* [ %t155, %then12 ], [ %t142, %merge17 ]
  %t418 = phi i1 [ %t143, %then12 ], [ %t407, %merge17 ]
  %t419 = phi double [ %t146, %then12 ], [ %t408, %merge17 ]
  %t420 = phi { i8**, i64 }* [ %t138, %then12 ], [ %t409, %merge17 ]
  %t421 = phi i1 [ %t144, %then12 ], [ %t410, %merge17 ]
  %t422 = phi double [ %t147, %then12 ], [ %t411, %merge17 ]
  %t423 = phi i1 [ %t145, %then12 ], [ %t413, %merge17 ]
  %t424 = phi double [ %t148, %then12 ], [ %t414, %merge17 ]
  store i8* %t417, i8** %l5
  store i1 %t418, i1* %l6
  store double %t419, double* %l9
  store { i8**, i64 }* %t420, { i8**, i64 }** %l1
  store i1 %t421, i1* %l7
  store double %t422, double* %l10
  store i1 %t423, i1* %l8
  store double %t424, double* %l11
  %t425 = load double, double* %l12
  %t426 = sitofp i64 1 to double
  %t427 = fadd double %t425, %t426
  store double %t427, double* %l12
  br label %loop.latch8
loop.latch8:
  %t428 = load i8*, i8** %l5
  %t429 = load i1, i1* %l6
  %t430 = load double, double* %l9
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t432 = load i1, i1* %l7
  %t433 = load double, double* %l10
  %t434 = load i1, i1* %l8
  %t435 = load double, double* %l11
  %t436 = load double, double* %l12
  br label %loop.header6
afterloop9:
  %t446 = load i8*, i8** %l5
  %t447 = load i1, i1* %l6
  %t448 = load double, double* %l9
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t450 = load i1, i1* %l7
  %t451 = load double, double* %l10
  %t452 = load i1, i1* %l8
  %t453 = load double, double* %l11
  %t454 = load double, double* %l12
  %t455 = load i8*, i8** %l5
  %t456 = call i64 @sailfin_runtime_string_length(i8* %t455)
  %t457 = icmp eq i64 %t456, 0
  %t458 = load i8*, i8** %l0
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t460 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t462 = load i8*, i8** %l4
  %t463 = load i8*, i8** %l5
  %t464 = load i1, i1* %l6
  %t465 = load i1, i1* %l7
  %t466 = load i1, i1* %l8
  %t467 = load double, double* %l9
  %t468 = load double, double* %l10
  %t469 = load double, double* %l11
  %t470 = load double, double* %l12
  br i1 %t457, label %then33, label %merge34
then33:
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s472 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t473 = call i8* @sailfin_runtime_string_concat(i8* %s472, i8* %struct_name)
  %s474 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t475 = call i8* @sailfin_runtime_string_concat(i8* %t473, i8* %s474)
  %t476 = load i8*, i8** %l4
  %t477 = call i8* @sailfin_runtime_string_concat(i8* %t475, i8* %t476)
  %s478 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1568429285, i32 0, i32 0
  %t479 = call i8* @sailfin_runtime_string_concat(i8* %t477, i8* %s478)
  %t480 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t471, i8* %t479)
  store { i8**, i64 }* %t480, { i8**, i64 }** %l1
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t482 = phi { i8**, i64 }* [ %t481, %then33 ], [ %t459, %afterloop9 ]
  store { i8**, i64 }* %t482, { i8**, i64 }** %l1
  %t483 = load i1, i1* %l6
  %t484 = xor i1 %t483, 1
  %t485 = load i8*, i8** %l0
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t487 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t489 = load i8*, i8** %l4
  %t490 = load i8*, i8** %l5
  %t491 = load i1, i1* %l6
  %t492 = load i1, i1* %l7
  %t493 = load i1, i1* %l8
  %t494 = load double, double* %l9
  %t495 = load double, double* %l10
  %t496 = load double, double* %l11
  %t497 = load double, double* %l12
  br i1 %t484, label %then35, label %merge36
then35:
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s499 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t500 = call i8* @sailfin_runtime_string_concat(i8* %s499, i8* %struct_name)
  %s501 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t502 = call i8* @sailfin_runtime_string_concat(i8* %t500, i8* %s501)
  %t503 = load i8*, i8** %l4
  %t504 = call i8* @sailfin_runtime_string_concat(i8* %t502, i8* %t503)
  %s505 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t506 = call i8* @sailfin_runtime_string_concat(i8* %t504, i8* %s505)
  %t507 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t498, i8* %t506)
  store { i8**, i64 }* %t507, { i8**, i64 }** %l1
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t509 = phi { i8**, i64 }* [ %t508, %then35 ], [ %t486, %merge34 ]
  store { i8**, i64 }* %t509, { i8**, i64 }** %l1
  %t510 = load i1, i1* %l7
  %t511 = xor i1 %t510, 1
  %t512 = load i8*, i8** %l0
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t514 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t515 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t516 = load i8*, i8** %l4
  %t517 = load i8*, i8** %l5
  %t518 = load i1, i1* %l6
  %t519 = load i1, i1* %l7
  %t520 = load i1, i1* %l8
  %t521 = load double, double* %l9
  %t522 = load double, double* %l10
  %t523 = load double, double* %l11
  %t524 = load double, double* %l12
  br i1 %t511, label %then37, label %merge38
then37:
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s526 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t527 = call i8* @sailfin_runtime_string_concat(i8* %s526, i8* %struct_name)
  %s528 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t529 = call i8* @sailfin_runtime_string_concat(i8* %t527, i8* %s528)
  %t530 = load i8*, i8** %l4
  %t531 = call i8* @sailfin_runtime_string_concat(i8* %t529, i8* %t530)
  %s532 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t533 = call i8* @sailfin_runtime_string_concat(i8* %t531, i8* %s532)
  %t534 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t525, i8* %t533)
  store { i8**, i64 }* %t534, { i8**, i64 }** %l1
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t536 = phi { i8**, i64 }* [ %t535, %then37 ], [ %t513, %merge36 ]
  store { i8**, i64 }* %t536, { i8**, i64 }** %l1
  %t537 = load i1, i1* %l8
  %t538 = xor i1 %t537, 1
  %t539 = load i8*, i8** %l0
  %t540 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t541 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t542 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t543 = load i8*, i8** %l4
  %t544 = load i8*, i8** %l5
  %t545 = load i1, i1* %l6
  %t546 = load i1, i1* %l7
  %t547 = load i1, i1* %l8
  %t548 = load double, double* %l9
  %t549 = load double, double* %l10
  %t550 = load double, double* %l11
  %t551 = load double, double* %l12
  br i1 %t538, label %then39, label %merge40
then39:
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s553 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t554 = call i8* @sailfin_runtime_string_concat(i8* %s553, i8* %struct_name)
  %s555 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t556 = call i8* @sailfin_runtime_string_concat(i8* %t554, i8* %s555)
  %t557 = load i8*, i8** %l4
  %t558 = call i8* @sailfin_runtime_string_concat(i8* %t556, i8* %t557)
  %s559 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t560 = call i8* @sailfin_runtime_string_concat(i8* %t558, i8* %s559)
  %t561 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t552, i8* %t560)
  store { i8**, i64 }* %t561, { i8**, i64 }** %l1
  %t562 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t563 = phi { i8**, i64 }* [ %t562, %then39 ], [ %t540, %merge38 ]
  store { i8**, i64 }* %t563, { i8**, i64 }** %l1
  %t565 = load i8*, i8** %l5
  %t566 = call i64 @sailfin_runtime_string_length(i8* %t565)
  %t567 = icmp sgt i64 %t566, 0
  br label %logical_and_entry_564

logical_and_entry_564:
  br i1 %t567, label %logical_and_right_564, label %logical_and_merge_564

logical_and_right_564:
  %t569 = load i1, i1* %l6
  br label %logical_and_entry_568

logical_and_entry_568:
  br i1 %t569, label %logical_and_right_568, label %logical_and_merge_568

logical_and_right_568:
  %t571 = load i1, i1* %l7
  br label %logical_and_entry_570

logical_and_entry_570:
  br i1 %t571, label %logical_and_right_570, label %logical_and_merge_570

logical_and_right_570:
  %t573 = load i1, i1* %l8
  br label %logical_and_entry_572

logical_and_entry_572:
  br i1 %t573, label %logical_and_right_572, label %logical_and_merge_572

logical_and_right_572:
  %t574 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t575 = load { i8**, i64 }, { i8**, i64 }* %t574
  %t576 = extractvalue { i8**, i64 } %t575, 1
  %t577 = icmp eq i64 %t576, 0
  br label %logical_and_right_end_572

logical_and_right_end_572:
  br label %logical_and_merge_572

logical_and_merge_572:
  %t578 = phi i1 [ false, %logical_and_entry_572 ], [ %t577, %logical_and_right_end_572 ]
  br label %logical_and_right_end_570

logical_and_right_end_570:
  br label %logical_and_merge_570

logical_and_merge_570:
  %t579 = phi i1 [ false, %logical_and_entry_570 ], [ %t578, %logical_and_right_end_570 ]
  br label %logical_and_right_end_568

logical_and_right_end_568:
  br label %logical_and_merge_568

logical_and_merge_568:
  %t580 = phi i1 [ false, %logical_and_entry_568 ], [ %t579, %logical_and_right_end_568 ]
  br label %logical_and_right_end_564

logical_and_right_end_564:
  br label %logical_and_merge_564

logical_and_merge_564:
  %t581 = phi i1 [ false, %logical_and_entry_564 ], [ %t580, %logical_and_right_end_564 ]
  store i1 %t581, i1* %l20
  %t582 = load i8*, i8** %l4
  %t583 = insertvalue %NativeStructLayoutField undef, i8* %t582, 0
  %t584 = load i8*, i8** %l5
  %t585 = insertvalue %NativeStructLayoutField %t583, i8* %t584, 1
  %t586 = load double, double* %l9
  %t587 = insertvalue %NativeStructLayoutField %t585, double %t586, 2
  %t588 = load double, double* %l10
  %t589 = insertvalue %NativeStructLayoutField %t587, double %t588, 3
  %t590 = load double, double* %l11
  %t591 = insertvalue %NativeStructLayoutField %t589, double %t590, 4
  store %NativeStructLayoutField %t591, %NativeStructLayoutField* %l21
  %t592 = load i1, i1* %l20
  %t593 = insertvalue %StructLayoutFieldParse undef, i1 %t592, 0
  %t594 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t595 = insertvalue %StructLayoutFieldParse %t593, %NativeStructLayoutField %t594, 1
  %t596 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t597 = insertvalue %StructLayoutFieldParse %t595, { i8**, i64 }* %t596, 2
  ret %StructLayoutFieldParse %t597
}

define %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca i1
  %l3 = alloca i1
  %l4 = alloca i1
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca %NumberParseResult
  %l17 = alloca i8*
  %l18 = alloca %NumberParseResult
  %l19 = alloca i8*
  %l20 = alloca %NumberParseResult
  %l21 = alloca i8*
  %l22 = alloca %NumberParseResult
  %l23 = alloca i1
  %t0 = call i8* @trim_text(i8* %text)
  %t1 = call { i8**, i64 }* @split_whitespace(i8* %t0)
  store { i8**, i64 }* %t1, { i8**, i64 }** %l0
  %t2 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t3 = ptrtoint [0 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t9 = ptrtoint { i8**, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { i8**, i64 }*
  %t12 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 0
  store i8** %t7, i8*** %t12
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t11, i32 0, i32 1
  store i64 0, i64* %t13
  store { i8**, i64 }* %t11, { i8**, i64 }** %l1
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load { i8**, i64 }, { i8**, i64 }* %t14
  %t16 = extractvalue { i8**, i64 } %t15, 1
  %t17 = icmp eq i64 %t16, 0
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br i1 %t17, label %then0, label %merge1
then0:
  %t20 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s21 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h183092327, i32 0, i32 0
  %t22 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t20, i8* %s21)
  store { i8**, i64 }* %t22, { i8**, i64 }** %l1
  %t23 = insertvalue %EnumLayoutHeaderParse undef, i1 0, 0
  %s24 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t25 = insertvalue %EnumLayoutHeaderParse %t23, i8* %s24, 1
  %t26 = sitofp i64 0 to double
  %t27 = insertvalue %EnumLayoutHeaderParse %t25, double %t26, 2
  %t28 = sitofp i64 0 to double
  %t29 = insertvalue %EnumLayoutHeaderParse %t27, double %t28, 3
  %s30 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t31 = insertvalue %EnumLayoutHeaderParse %t29, i8* %s30, 4
  %t32 = sitofp i64 0 to double
  %t33 = insertvalue %EnumLayoutHeaderParse %t31, double %t32, 5
  %t34 = sitofp i64 0 to double
  %t35 = insertvalue %EnumLayoutHeaderParse %t33, double %t34, 6
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t37 = insertvalue %EnumLayoutHeaderParse %t35, { i8**, i64 }* %t36, 7
  ret %EnumLayoutHeaderParse %t37
merge1:
  store i1 0, i1* %l2
  store i1 0, i1* %l3
  store i1 0, i1* %l4
  %s38 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s38, i8** %l5
  %s39 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s39, i8** %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t40 = sitofp i64 0 to double
  store double %t40, double* %l9
  %t41 = sitofp i64 0 to double
  store double %t41, double* %l10
  %t42 = sitofp i64 0 to double
  store double %t42, double* %l11
  %t43 = sitofp i64 0 to double
  store double %t43, double* %l12
  %t44 = sitofp i64 0 to double
  store double %t44, double* %l13
  %t45 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t46 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t47 = load i1, i1* %l2
  %t48 = load i1, i1* %l3
  %t49 = load i1, i1* %l4
  %t50 = load i8*, i8** %l5
  %t51 = load i8*, i8** %l6
  %t52 = load i1, i1* %l7
  %t53 = load i1, i1* %l8
  %t54 = load double, double* %l9
  %t55 = load double, double* %l10
  %t56 = load double, double* %l11
  %t57 = load double, double* %l12
  %t58 = load double, double* %l13
  br label %loop.header2
loop.header2:
  %t507 = phi i8* [ %t50, %merge1 ], [ %t494, %loop.latch4 ]
  %t508 = phi i1 [ %t47, %merge1 ], [ %t495, %loop.latch4 ]
  %t509 = phi i1 [ %t48, %merge1 ], [ %t496, %loop.latch4 ]
  %t510 = phi double [ %t54, %merge1 ], [ %t497, %loop.latch4 ]
  %t511 = phi { i8**, i64 }* [ %t46, %merge1 ], [ %t498, %loop.latch4 ]
  %t512 = phi i1 [ %t49, %merge1 ], [ %t499, %loop.latch4 ]
  %t513 = phi double [ %t55, %merge1 ], [ %t500, %loop.latch4 ]
  %t514 = phi i8* [ %t51, %merge1 ], [ %t501, %loop.latch4 ]
  %t515 = phi i1 [ %t52, %merge1 ], [ %t502, %loop.latch4 ]
  %t516 = phi double [ %t56, %merge1 ], [ %t503, %loop.latch4 ]
  %t517 = phi i1 [ %t53, %merge1 ], [ %t504, %loop.latch4 ]
  %t518 = phi double [ %t57, %merge1 ], [ %t505, %loop.latch4 ]
  %t519 = phi double [ %t58, %merge1 ], [ %t506, %loop.latch4 ]
  store i8* %t507, i8** %l5
  store i1 %t508, i1* %l2
  store i1 %t509, i1* %l3
  store double %t510, double* %l9
  store { i8**, i64 }* %t511, { i8**, i64 }** %l1
  store i1 %t512, i1* %l4
  store double %t513, double* %l10
  store i8* %t514, i8** %l6
  store i1 %t515, i1* %l7
  store double %t516, double* %l11
  store i1 %t517, i1* %l8
  store double %t518, double* %l12
  store double %t519, double* %l13
  br label %loop.body3
loop.body3:
  %t59 = load double, double* %l13
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load { i8**, i64 }, { i8**, i64 }* %t60
  %t62 = extractvalue { i8**, i64 } %t61, 1
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp oge double %t59, %t63
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t67 = load i1, i1* %l2
  %t68 = load i1, i1* %l3
  %t69 = load i1, i1* %l4
  %t70 = load i8*, i8** %l5
  %t71 = load i8*, i8** %l6
  %t72 = load i1, i1* %l7
  %t73 = load i1, i1* %l8
  %t74 = load double, double* %l9
  %t75 = load double, double* %l10
  %t76 = load double, double* %l11
  %t77 = load double, double* %l12
  %t78 = load double, double* %l13
  br i1 %t64, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load double, double* %l13
  %t81 = call double @llvm.round.f64(double %t80)
  %t82 = fptosi double %t81 to i64
  %t83 = load { i8**, i64 }, { i8**, i64 }* %t79
  %t84 = extractvalue { i8**, i64 } %t83, 0
  %t85 = extractvalue { i8**, i64 } %t83, 1
  %t86 = icmp uge i64 %t82, %t85
  ; bounds check: %t86 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t82, i64 %t85)
  %t87 = getelementptr i8*, i8** %t84, i64 %t82
  %t88 = load i8*, i8** %t87
  store i8* %t88, i8** %l14
  %t89 = load i8*, i8** %l14
  %s90 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h261048910, i32 0, i32 0
  %t91 = call i1 @starts_with(i8* %t89, i8* %s90)
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t94 = load i1, i1* %l2
  %t95 = load i1, i1* %l3
  %t96 = load i1, i1* %l4
  %t97 = load i8*, i8** %l5
  %t98 = load i8*, i8** %l6
  %t99 = load i1, i1* %l7
  %t100 = load i1, i1* %l8
  %t101 = load double, double* %l9
  %t102 = load double, double* %l10
  %t103 = load double, double* %l11
  %t104 = load double, double* %l12
  %t105 = load double, double* %l13
  %t106 = load i8*, i8** %l14
  br i1 %t91, label %then8, label %else9
then8:
  %t107 = load i8*, i8** %l14
  %t108 = load i8*, i8** %l14
  %t109 = call i64 @sailfin_runtime_string_length(i8* %t108)
  %t110 = call i8* @sailfin_runtime_substring(i8* %t107, i64 5, i64 %t109)
  store i8* %t110, i8** %l5
  store i1 1, i1* %l2
  %t111 = load i8*, i8** %l5
  %t112 = load i1, i1* %l2
  br label %merge10
else9:
  %t113 = load i8*, i8** %l14
  %s114 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t115 = call i1 @starts_with(i8* %t113, i8* %s114)
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t118 = load i1, i1* %l2
  %t119 = load i1, i1* %l3
  %t120 = load i1, i1* %l4
  %t121 = load i8*, i8** %l5
  %t122 = load i8*, i8** %l6
  %t123 = load i1, i1* %l7
  %t124 = load i1, i1* %l8
  %t125 = load double, double* %l9
  %t126 = load double, double* %l10
  %t127 = load double, double* %l11
  %t128 = load double, double* %l12
  %t129 = load double, double* %l13
  %t130 = load i8*, i8** %l14
  br i1 %t115, label %then11, label %else12
then11:
  %t131 = load i8*, i8** %l14
  %t132 = load i8*, i8** %l14
  %t133 = call i64 @sailfin_runtime_string_length(i8* %t132)
  %t134 = call i8* @sailfin_runtime_substring(i8* %t131, i64 5, i64 %t133)
  store i8* %t134, i8** %l15
  %t135 = load i8*, i8** %l15
  %t136 = call %NumberParseResult @parse_decimal_number(i8* %t135)
  store %NumberParseResult %t136, %NumberParseResult* %l16
  %t137 = load %NumberParseResult, %NumberParseResult* %l16
  %t138 = extractvalue %NumberParseResult %t137, 0
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t141 = load i1, i1* %l2
  %t142 = load i1, i1* %l3
  %t143 = load i1, i1* %l4
  %t144 = load i8*, i8** %l5
  %t145 = load i8*, i8** %l6
  %t146 = load i1, i1* %l7
  %t147 = load i1, i1* %l8
  %t148 = load double, double* %l9
  %t149 = load double, double* %l10
  %t150 = load double, double* %l11
  %t151 = load double, double* %l12
  %t152 = load double, double* %l13
  %t153 = load i8*, i8** %l14
  %t154 = load i8*, i8** %l15
  %t155 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t138, label %then14, label %else15
then14:
  store i1 1, i1* %l3
  %t156 = load %NumberParseResult, %NumberParseResult* %l16
  %t157 = extractvalue %NumberParseResult %t156, 1
  store double %t157, double* %l9
  %t158 = load i1, i1* %l3
  %t159 = load double, double* %l9
  br label %merge16
else15:
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s161 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h1581468287, i32 0, i32 0
  %t162 = load i8*, i8** %l15
  %t163 = call i8* @sailfin_runtime_string_concat(i8* %s161, i8* %t162)
  %t164 = alloca [2 x i8], align 1
  %t165 = getelementptr [2 x i8], [2 x i8]* %t164, i32 0, i32 0
  store i8 96, i8* %t165
  %t166 = getelementptr [2 x i8], [2 x i8]* %t164, i32 0, i32 1
  store i8 0, i8* %t166
  %t167 = getelementptr [2 x i8], [2 x i8]* %t164, i32 0, i32 0
  %t168 = call i8* @sailfin_runtime_string_concat(i8* %t163, i8* %t167)
  %t169 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t160, i8* %t168)
  store { i8**, i64 }* %t169, { i8**, i64 }** %l1
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t171 = phi i1 [ %t158, %then14 ], [ %t142, %else15 ]
  %t172 = phi double [ %t159, %then14 ], [ %t148, %else15 ]
  %t173 = phi { i8**, i64 }* [ %t140, %then14 ], [ %t170, %else15 ]
  store i1 %t171, i1* %l3
  store double %t172, double* %l9
  store { i8**, i64 }* %t173, { i8**, i64 }** %l1
  %t174 = load i1, i1* %l3
  %t175 = load double, double* %l9
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t177 = load i8*, i8** %l14
  %s178 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t179 = call i1 @starts_with(i8* %t177, i8* %s178)
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t182 = load i1, i1* %l2
  %t183 = load i1, i1* %l3
  %t184 = load i1, i1* %l4
  %t185 = load i8*, i8** %l5
  %t186 = load i8*, i8** %l6
  %t187 = load i1, i1* %l7
  %t188 = load i1, i1* %l8
  %t189 = load double, double* %l9
  %t190 = load double, double* %l10
  %t191 = load double, double* %l11
  %t192 = load double, double* %l12
  %t193 = load double, double* %l13
  %t194 = load i8*, i8** %l14
  br i1 %t179, label %then17, label %else18
then17:
  %t195 = load i8*, i8** %l14
  %t196 = load i8*, i8** %l14
  %t197 = call i64 @sailfin_runtime_string_length(i8* %t196)
  %t198 = call i8* @sailfin_runtime_substring(i8* %t195, i64 6, i64 %t197)
  store i8* %t198, i8** %l17
  %t199 = load i8*, i8** %l17
  %t200 = call %NumberParseResult @parse_decimal_number(i8* %t199)
  store %NumberParseResult %t200, %NumberParseResult* %l18
  %t201 = load %NumberParseResult, %NumberParseResult* %l18
  %t202 = extractvalue %NumberParseResult %t201, 0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = load i1, i1* %l2
  %t206 = load i1, i1* %l3
  %t207 = load i1, i1* %l4
  %t208 = load i8*, i8** %l5
  %t209 = load i8*, i8** %l6
  %t210 = load i1, i1* %l7
  %t211 = load i1, i1* %l8
  %t212 = load double, double* %l9
  %t213 = load double, double* %l10
  %t214 = load double, double* %l11
  %t215 = load double, double* %l12
  %t216 = load double, double* %l13
  %t217 = load i8*, i8** %l14
  %t218 = load i8*, i8** %l17
  %t219 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t202, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t220 = load %NumberParseResult, %NumberParseResult* %l18
  %t221 = extractvalue %NumberParseResult %t220, 1
  store double %t221, double* %l10
  %t222 = load i1, i1* %l4
  %t223 = load double, double* %l10
  br label %merge22
else21:
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s225 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h1235260132, i32 0, i32 0
  %t226 = load i8*, i8** %l17
  %t227 = call i8* @sailfin_runtime_string_concat(i8* %s225, i8* %t226)
  %t228 = alloca [2 x i8], align 1
  %t229 = getelementptr [2 x i8], [2 x i8]* %t228, i32 0, i32 0
  store i8 96, i8* %t229
  %t230 = getelementptr [2 x i8], [2 x i8]* %t228, i32 0, i32 1
  store i8 0, i8* %t230
  %t231 = getelementptr [2 x i8], [2 x i8]* %t228, i32 0, i32 0
  %t232 = call i8* @sailfin_runtime_string_concat(i8* %t227, i8* %t231)
  %t233 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t224, i8* %t232)
  store { i8**, i64 }* %t233, { i8**, i64 }** %l1
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t235 = phi i1 [ %t222, %then20 ], [ %t207, %else21 ]
  %t236 = phi double [ %t223, %then20 ], [ %t213, %else21 ]
  %t237 = phi { i8**, i64 }* [ %t204, %then20 ], [ %t234, %else21 ]
  store i1 %t235, i1* %l4
  store double %t236, double* %l10
  store { i8**, i64 }* %t237, { i8**, i64 }** %l1
  %t238 = load i1, i1* %l4
  %t239 = load double, double* %l10
  %t240 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t241 = load i8*, i8** %l14
  %s242 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1228988541, i32 0, i32 0
  %t243 = call i1 @starts_with(i8* %t241, i8* %s242)
  %t244 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t246 = load i1, i1* %l2
  %t247 = load i1, i1* %l3
  %t248 = load i1, i1* %l4
  %t249 = load i8*, i8** %l5
  %t250 = load i8*, i8** %l6
  %t251 = load i1, i1* %l7
  %t252 = load i1, i1* %l8
  %t253 = load double, double* %l9
  %t254 = load double, double* %l10
  %t255 = load double, double* %l11
  %t256 = load double, double* %l12
  %t257 = load double, double* %l13
  %t258 = load i8*, i8** %l14
  br i1 %t243, label %then23, label %else24
then23:
  %t259 = load i8*, i8** %l14
  %t260 = load i8*, i8** %l14
  %t261 = call i64 @sailfin_runtime_string_length(i8* %t260)
  %t262 = call i8* @sailfin_runtime_substring(i8* %t259, i64 9, i64 %t261)
  store i8* %t262, i8** %l6
  %t263 = load i8*, i8** %l6
  br label %merge25
else24:
  %t264 = load i8*, i8** %l14
  %s265 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1171237782, i32 0, i32 0
  %t266 = call i1 @starts_with(i8* %t264, i8* %s265)
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t268 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t269 = load i1, i1* %l2
  %t270 = load i1, i1* %l3
  %t271 = load i1, i1* %l4
  %t272 = load i8*, i8** %l5
  %t273 = load i8*, i8** %l6
  %t274 = load i1, i1* %l7
  %t275 = load i1, i1* %l8
  %t276 = load double, double* %l9
  %t277 = load double, double* %l10
  %t278 = load double, double* %l11
  %t279 = load double, double* %l12
  %t280 = load double, double* %l13
  %t281 = load i8*, i8** %l14
  br i1 %t266, label %then26, label %else27
then26:
  %t282 = load i8*, i8** %l14
  %t283 = load i8*, i8** %l14
  %t284 = call i64 @sailfin_runtime_string_length(i8* %t283)
  %t285 = call i8* @sailfin_runtime_substring(i8* %t282, i64 9, i64 %t284)
  store i8* %t285, i8** %l19
  %t286 = load i8*, i8** %l19
  %t287 = call %NumberParseResult @parse_decimal_number(i8* %t286)
  store %NumberParseResult %t287, %NumberParseResult* %l20
  %t288 = load %NumberParseResult, %NumberParseResult* %l20
  %t289 = extractvalue %NumberParseResult %t288, 0
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t292 = load i1, i1* %l2
  %t293 = load i1, i1* %l3
  %t294 = load i1, i1* %l4
  %t295 = load i8*, i8** %l5
  %t296 = load i8*, i8** %l6
  %t297 = load i1, i1* %l7
  %t298 = load i1, i1* %l8
  %t299 = load double, double* %l9
  %t300 = load double, double* %l10
  %t301 = load double, double* %l11
  %t302 = load double, double* %l12
  %t303 = load double, double* %l13
  %t304 = load i8*, i8** %l14
  %t305 = load i8*, i8** %l19
  %t306 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t289, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t307 = load %NumberParseResult, %NumberParseResult* %l20
  %t308 = extractvalue %NumberParseResult %t307, 1
  store double %t308, double* %l11
  %t309 = load i1, i1* %l7
  %t310 = load double, double* %l11
  br label %merge31
else30:
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s312 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1384306956, i32 0, i32 0
  %t313 = load i8*, i8** %l19
  %t314 = call i8* @sailfin_runtime_string_concat(i8* %s312, i8* %t313)
  %t315 = alloca [2 x i8], align 1
  %t316 = getelementptr [2 x i8], [2 x i8]* %t315, i32 0, i32 0
  store i8 96, i8* %t316
  %t317 = getelementptr [2 x i8], [2 x i8]* %t315, i32 0, i32 1
  store i8 0, i8* %t317
  %t318 = getelementptr [2 x i8], [2 x i8]* %t315, i32 0, i32 0
  %t319 = call i8* @sailfin_runtime_string_concat(i8* %t314, i8* %t318)
  %t320 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t311, i8* %t319)
  store { i8**, i64 }* %t320, { i8**, i64 }** %l1
  %t321 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t322 = phi i1 [ %t309, %then29 ], [ %t297, %else30 ]
  %t323 = phi double [ %t310, %then29 ], [ %t301, %else30 ]
  %t324 = phi { i8**, i64 }* [ %t291, %then29 ], [ %t321, %else30 ]
  store i1 %t322, i1* %l7
  store double %t323, double* %l11
  store { i8**, i64 }* %t324, { i8**, i64 }** %l1
  %t325 = load i1, i1* %l7
  %t326 = load double, double* %l11
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t328 = load i8*, i8** %l14
  %s329 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h469410318, i32 0, i32 0
  %t330 = call i1 @starts_with(i8* %t328, i8* %s329)
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t332 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t333 = load i1, i1* %l2
  %t334 = load i1, i1* %l3
  %t335 = load i1, i1* %l4
  %t336 = load i8*, i8** %l5
  %t337 = load i8*, i8** %l6
  %t338 = load i1, i1* %l7
  %t339 = load i1, i1* %l8
  %t340 = load double, double* %l9
  %t341 = load double, double* %l10
  %t342 = load double, double* %l11
  %t343 = load double, double* %l12
  %t344 = load double, double* %l13
  %t345 = load i8*, i8** %l14
  br i1 %t330, label %then32, label %else33
then32:
  %t346 = load i8*, i8** %l14
  %t347 = load i8*, i8** %l14
  %t348 = call i64 @sailfin_runtime_string_length(i8* %t347)
  %t349 = call i8* @sailfin_runtime_substring(i8* %t346, i64 10, i64 %t348)
  store i8* %t349, i8** %l21
  %t350 = load i8*, i8** %l21
  %t351 = call %NumberParseResult @parse_decimal_number(i8* %t350)
  store %NumberParseResult %t351, %NumberParseResult* %l22
  %t352 = load %NumberParseResult, %NumberParseResult* %l22
  %t353 = extractvalue %NumberParseResult %t352, 0
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t356 = load i1, i1* %l2
  %t357 = load i1, i1* %l3
  %t358 = load i1, i1* %l4
  %t359 = load i8*, i8** %l5
  %t360 = load i8*, i8** %l6
  %t361 = load i1, i1* %l7
  %t362 = load i1, i1* %l8
  %t363 = load double, double* %l9
  %t364 = load double, double* %l10
  %t365 = load double, double* %l11
  %t366 = load double, double* %l12
  %t367 = load double, double* %l13
  %t368 = load i8*, i8** %l14
  %t369 = load i8*, i8** %l21
  %t370 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t353, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t371 = load %NumberParseResult, %NumberParseResult* %l22
  %t372 = extractvalue %NumberParseResult %t371, 1
  store double %t372, double* %l12
  %t373 = load i1, i1* %l8
  %t374 = load double, double* %l12
  br label %merge37
else36:
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s376 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1171387022, i32 0, i32 0
  %t377 = load i8*, i8** %l21
  %t378 = call i8* @sailfin_runtime_string_concat(i8* %s376, i8* %t377)
  %t379 = alloca [2 x i8], align 1
  %t380 = getelementptr [2 x i8], [2 x i8]* %t379, i32 0, i32 0
  store i8 96, i8* %t380
  %t381 = getelementptr [2 x i8], [2 x i8]* %t379, i32 0, i32 1
  store i8 0, i8* %t381
  %t382 = getelementptr [2 x i8], [2 x i8]* %t379, i32 0, i32 0
  %t383 = call i8* @sailfin_runtime_string_concat(i8* %t378, i8* %t382)
  %t384 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t375, i8* %t383)
  store { i8**, i64 }* %t384, { i8**, i64 }** %l1
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t386 = phi i1 [ %t373, %then35 ], [ %t362, %else36 ]
  %t387 = phi double [ %t374, %then35 ], [ %t366, %else36 ]
  %t388 = phi { i8**, i64 }* [ %t355, %then35 ], [ %t385, %else36 ]
  store i1 %t386, i1* %l8
  store double %t387, double* %l12
  store { i8**, i64 }* %t388, { i8**, i64 }** %l1
  %t389 = load i1, i1* %l8
  %t390 = load double, double* %l12
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s393 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h598838653, i32 0, i32 0
  %t394 = load i8*, i8** %l14
  %t395 = call i8* @sailfin_runtime_string_concat(i8* %s393, i8* %t394)
  %t396 = alloca [2 x i8], align 1
  %t397 = getelementptr [2 x i8], [2 x i8]* %t396, i32 0, i32 0
  store i8 96, i8* %t397
  %t398 = getelementptr [2 x i8], [2 x i8]* %t396, i32 0, i32 1
  store i8 0, i8* %t398
  %t399 = getelementptr [2 x i8], [2 x i8]* %t396, i32 0, i32 0
  %t400 = call i8* @sailfin_runtime_string_concat(i8* %t395, i8* %t399)
  %t401 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t392, i8* %t400)
  store { i8**, i64 }* %t401, { i8**, i64 }** %l1
  %t402 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t403 = phi i1 [ %t389, %merge37 ], [ %t339, %else33 ]
  %t404 = phi double [ %t390, %merge37 ], [ %t343, %else33 ]
  %t405 = phi { i8**, i64 }* [ %t391, %merge37 ], [ %t402, %else33 ]
  store i1 %t403, i1* %l8
  store double %t404, double* %l12
  store { i8**, i64 }* %t405, { i8**, i64 }** %l1
  %t406 = load i1, i1* %l8
  %t407 = load double, double* %l12
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t410 = phi i1 [ %t325, %merge31 ], [ %t274, %merge34 ]
  %t411 = phi double [ %t326, %merge31 ], [ %t278, %merge34 ]
  %t412 = phi { i8**, i64 }* [ %t327, %merge31 ], [ %t408, %merge34 ]
  %t413 = phi i1 [ %t275, %merge31 ], [ %t406, %merge34 ]
  %t414 = phi double [ %t279, %merge31 ], [ %t407, %merge34 ]
  store i1 %t410, i1* %l7
  store double %t411, double* %l11
  store { i8**, i64 }* %t412, { i8**, i64 }** %l1
  store i1 %t413, i1* %l8
  store double %t414, double* %l12
  %t415 = load i1, i1* %l7
  %t416 = load double, double* %l11
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t418 = load i1, i1* %l8
  %t419 = load double, double* %l12
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge25
merge25:
  %t422 = phi i8* [ %t263, %then23 ], [ %t250, %merge28 ]
  %t423 = phi i1 [ %t251, %then23 ], [ %t415, %merge28 ]
  %t424 = phi double [ %t255, %then23 ], [ %t416, %merge28 ]
  %t425 = phi { i8**, i64 }* [ %t245, %then23 ], [ %t417, %merge28 ]
  %t426 = phi i1 [ %t252, %then23 ], [ %t418, %merge28 ]
  %t427 = phi double [ %t256, %then23 ], [ %t419, %merge28 ]
  store i8* %t422, i8** %l6
  store i1 %t423, i1* %l7
  store double %t424, double* %l11
  store { i8**, i64 }* %t425, { i8**, i64 }** %l1
  store i1 %t426, i1* %l8
  store double %t427, double* %l12
  %t428 = load i8*, i8** %l6
  %t429 = load i1, i1* %l7
  %t430 = load double, double* %l11
  %t431 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t432 = load i1, i1* %l8
  %t433 = load double, double* %l12
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t436 = phi i1 [ %t238, %merge22 ], [ %t184, %merge25 ]
  %t437 = phi double [ %t239, %merge22 ], [ %t190, %merge25 ]
  %t438 = phi { i8**, i64 }* [ %t240, %merge22 ], [ %t431, %merge25 ]
  %t439 = phi i8* [ %t186, %merge22 ], [ %t428, %merge25 ]
  %t440 = phi i1 [ %t187, %merge22 ], [ %t429, %merge25 ]
  %t441 = phi double [ %t191, %merge22 ], [ %t430, %merge25 ]
  %t442 = phi i1 [ %t188, %merge22 ], [ %t432, %merge25 ]
  %t443 = phi double [ %t192, %merge22 ], [ %t433, %merge25 ]
  store i1 %t436, i1* %l4
  store double %t437, double* %l10
  store { i8**, i64 }* %t438, { i8**, i64 }** %l1
  store i8* %t439, i8** %l6
  store i1 %t440, i1* %l7
  store double %t441, double* %l11
  store i1 %t442, i1* %l8
  store double %t443, double* %l12
  %t444 = load i1, i1* %l4
  %t445 = load double, double* %l10
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t447 = load i8*, i8** %l6
  %t448 = load i1, i1* %l7
  %t449 = load double, double* %l11
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t451 = load i1, i1* %l8
  %t452 = load double, double* %l12
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t455 = phi i1 [ %t174, %merge16 ], [ %t119, %merge19 ]
  %t456 = phi double [ %t175, %merge16 ], [ %t125, %merge19 ]
  %t457 = phi { i8**, i64 }* [ %t176, %merge16 ], [ %t446, %merge19 ]
  %t458 = phi i1 [ %t120, %merge16 ], [ %t444, %merge19 ]
  %t459 = phi double [ %t126, %merge16 ], [ %t445, %merge19 ]
  %t460 = phi i8* [ %t122, %merge16 ], [ %t447, %merge19 ]
  %t461 = phi i1 [ %t123, %merge16 ], [ %t448, %merge19 ]
  %t462 = phi double [ %t127, %merge16 ], [ %t449, %merge19 ]
  %t463 = phi i1 [ %t124, %merge16 ], [ %t451, %merge19 ]
  %t464 = phi double [ %t128, %merge16 ], [ %t452, %merge19 ]
  store i1 %t455, i1* %l3
  store double %t456, double* %l9
  store { i8**, i64 }* %t457, { i8**, i64 }** %l1
  store i1 %t458, i1* %l4
  store double %t459, double* %l10
  store i8* %t460, i8** %l6
  store i1 %t461, i1* %l7
  store double %t462, double* %l11
  store i1 %t463, i1* %l8
  store double %t464, double* %l12
  %t465 = load i1, i1* %l3
  %t466 = load double, double* %l9
  %t467 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t468 = load i1, i1* %l4
  %t469 = load double, double* %l10
  %t470 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t471 = load i8*, i8** %l6
  %t472 = load i1, i1* %l7
  %t473 = load double, double* %l11
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t475 = load i1, i1* %l8
  %t476 = load double, double* %l12
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t479 = phi i8* [ %t111, %then8 ], [ %t97, %merge13 ]
  %t480 = phi i1 [ %t112, %then8 ], [ %t94, %merge13 ]
  %t481 = phi i1 [ %t95, %then8 ], [ %t465, %merge13 ]
  %t482 = phi double [ %t101, %then8 ], [ %t466, %merge13 ]
  %t483 = phi { i8**, i64 }* [ %t93, %then8 ], [ %t467, %merge13 ]
  %t484 = phi i1 [ %t96, %then8 ], [ %t468, %merge13 ]
  %t485 = phi double [ %t102, %then8 ], [ %t469, %merge13 ]
  %t486 = phi i8* [ %t98, %then8 ], [ %t471, %merge13 ]
  %t487 = phi i1 [ %t99, %then8 ], [ %t472, %merge13 ]
  %t488 = phi double [ %t103, %then8 ], [ %t473, %merge13 ]
  %t489 = phi i1 [ %t100, %then8 ], [ %t475, %merge13 ]
  %t490 = phi double [ %t104, %then8 ], [ %t476, %merge13 ]
  store i8* %t479, i8** %l5
  store i1 %t480, i1* %l2
  store i1 %t481, i1* %l3
  store double %t482, double* %l9
  store { i8**, i64 }* %t483, { i8**, i64 }** %l1
  store i1 %t484, i1* %l4
  store double %t485, double* %l10
  store i8* %t486, i8** %l6
  store i1 %t487, i1* %l7
  store double %t488, double* %l11
  store i1 %t489, i1* %l8
  store double %t490, double* %l12
  %t491 = load double, double* %l13
  %t492 = sitofp i64 1 to double
  %t493 = fadd double %t491, %t492
  store double %t493, double* %l13
  br label %loop.latch4
loop.latch4:
  %t494 = load i8*, i8** %l5
  %t495 = load i1, i1* %l2
  %t496 = load i1, i1* %l3
  %t497 = load double, double* %l9
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t499 = load i1, i1* %l4
  %t500 = load double, double* %l10
  %t501 = load i8*, i8** %l6
  %t502 = load i1, i1* %l7
  %t503 = load double, double* %l11
  %t504 = load i1, i1* %l8
  %t505 = load double, double* %l12
  %t506 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t520 = load i8*, i8** %l5
  %t521 = load i1, i1* %l2
  %t522 = load i1, i1* %l3
  %t523 = load double, double* %l9
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t525 = load i1, i1* %l4
  %t526 = load double, double* %l10
  %t527 = load i8*, i8** %l6
  %t528 = load i1, i1* %l7
  %t529 = load double, double* %l11
  %t530 = load i1, i1* %l8
  %t531 = load double, double* %l12
  %t532 = load double, double* %l13
  %t533 = load i1, i1* %l3
  %t534 = xor i1 %t533, 1
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t537 = load i1, i1* %l2
  %t538 = load i1, i1* %l3
  %t539 = load i1, i1* %l4
  %t540 = load i8*, i8** %l5
  %t541 = load i8*, i8** %l6
  %t542 = load i1, i1* %l7
  %t543 = load i1, i1* %l8
  %t544 = load double, double* %l9
  %t545 = load double, double* %l10
  %t546 = load double, double* %l11
  %t547 = load double, double* %l12
  %t548 = load double, double* %l13
  br i1 %t534, label %then38, label %merge39
then38:
  %t549 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s550 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h2038142650, i32 0, i32 0
  %t551 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t549, i8* %s550)
  store { i8**, i64 }* %t551, { i8**, i64 }** %l1
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t553 = phi { i8**, i64 }* [ %t552, %then38 ], [ %t536, %afterloop5 ]
  store { i8**, i64 }* %t553, { i8**, i64 }** %l1
  %t554 = load i1, i1* %l4
  %t555 = xor i1 %t554, 1
  %t556 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t557 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t558 = load i1, i1* %l2
  %t559 = load i1, i1* %l3
  %t560 = load i1, i1* %l4
  %t561 = load i8*, i8** %l5
  %t562 = load i8*, i8** %l6
  %t563 = load i1, i1* %l7
  %t564 = load i1, i1* %l8
  %t565 = load double, double* %l9
  %t566 = load double, double* %l10
  %t567 = load double, double* %l11
  %t568 = load double, double* %l12
  %t569 = load double, double* %l13
  br i1 %t555, label %then40, label %merge41
then40:
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s571 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h2050661185, i32 0, i32 0
  %t572 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t570, i8* %s571)
  store { i8**, i64 }* %t572, { i8**, i64 }** %l1
  %t573 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t574 = phi { i8**, i64 }* [ %t573, %then40 ], [ %t557, %merge39 ]
  store { i8**, i64 }* %t574, { i8**, i64 }** %l1
  %t575 = load i8*, i8** %l6
  %t576 = call i64 @sailfin_runtime_string_length(i8* %t575)
  %t577 = icmp eq i64 %t576, 0
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t580 = load i1, i1* %l2
  %t581 = load i1, i1* %l3
  %t582 = load i1, i1* %l4
  %t583 = load i8*, i8** %l5
  %t584 = load i8*, i8** %l6
  %t585 = load i1, i1* %l7
  %t586 = load i1, i1* %l8
  %t587 = load double, double* %l9
  %t588 = load double, double* %l10
  %t589 = load double, double* %l11
  %t590 = load double, double* %l12
  %t591 = load double, double* %l13
  br i1 %t577, label %then42, label %merge43
then42:
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s593 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h881857818, i32 0, i32 0
  %t594 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t592, i8* %s593)
  store { i8**, i64 }* %t594, { i8**, i64 }** %l1
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t596 = phi { i8**, i64 }* [ %t595, %then42 ], [ %t579, %merge41 ]
  store { i8**, i64 }* %t596, { i8**, i64 }** %l1
  %t597 = load i1, i1* %l7
  %t598 = xor i1 %t597, 1
  %t599 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t600 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t601 = load i1, i1* %l2
  %t602 = load i1, i1* %l3
  %t603 = load i1, i1* %l4
  %t604 = load i8*, i8** %l5
  %t605 = load i8*, i8** %l6
  %t606 = load i1, i1* %l7
  %t607 = load i1, i1* %l8
  %t608 = load double, double* %l9
  %t609 = load double, double* %l10
  %t610 = load double, double* %l11
  %t611 = load double, double* %l12
  %t612 = load double, double* %l13
  br i1 %t598, label %then44, label %merge45
then44:
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s614 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h2069276858, i32 0, i32 0
  %t615 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t613, i8* %s614)
  store { i8**, i64 }* %t615, { i8**, i64 }** %l1
  %t616 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t617 = phi { i8**, i64 }* [ %t616, %then44 ], [ %t600, %merge43 ]
  store { i8**, i64 }* %t617, { i8**, i64 }** %l1
  %t618 = load i1, i1* %l8
  %t619 = xor i1 %t618, 1
  %t620 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t621 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t622 = load i1, i1* %l2
  %t623 = load i1, i1* %l3
  %t624 = load i1, i1* %l4
  %t625 = load i8*, i8** %l5
  %t626 = load i8*, i8** %l6
  %t627 = load i1, i1* %l7
  %t628 = load i1, i1* %l8
  %t629 = load double, double* %l9
  %t630 = load double, double* %l10
  %t631 = load double, double* %l11
  %t632 = load double, double* %l12
  %t633 = load double, double* %l13
  br i1 %t619, label %then46, label %merge47
then46:
  %t634 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s635 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h930606274, i32 0, i32 0
  %t636 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t634, i8* %s635)
  store { i8**, i64 }* %t636, { i8**, i64 }** %l1
  %t637 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t638 = phi { i8**, i64 }* [ %t637, %then46 ], [ %t621, %merge45 ]
  store { i8**, i64 }* %t638, { i8**, i64 }** %l1
  %t640 = load i1, i1* %l3
  br label %logical_and_entry_639

logical_and_entry_639:
  br i1 %t640, label %logical_and_right_639, label %logical_and_merge_639

logical_and_right_639:
  %t642 = load i1, i1* %l4
  br label %logical_and_entry_641

logical_and_entry_641:
  br i1 %t642, label %logical_and_right_641, label %logical_and_merge_641

logical_and_right_641:
  %t644 = load i8*, i8** %l6
  %t645 = call i64 @sailfin_runtime_string_length(i8* %t644)
  %t646 = icmp sgt i64 %t645, 0
  br label %logical_and_entry_643

logical_and_entry_643:
  br i1 %t646, label %logical_and_right_643, label %logical_and_merge_643

logical_and_right_643:
  %t648 = load i1, i1* %l7
  br label %logical_and_entry_647

logical_and_entry_647:
  br i1 %t648, label %logical_and_right_647, label %logical_and_merge_647

logical_and_right_647:
  %t650 = load i1, i1* %l8
  br label %logical_and_entry_649

logical_and_entry_649:
  br i1 %t650, label %logical_and_right_649, label %logical_and_merge_649

logical_and_right_649:
  %t651 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t652 = load { i8**, i64 }, { i8**, i64 }* %t651
  %t653 = extractvalue { i8**, i64 } %t652, 1
  %t654 = icmp eq i64 %t653, 0
  br label %logical_and_right_end_649

logical_and_right_end_649:
  br label %logical_and_merge_649

logical_and_merge_649:
  %t655 = phi i1 [ false, %logical_and_entry_649 ], [ %t654, %logical_and_right_end_649 ]
  br label %logical_and_right_end_647

logical_and_right_end_647:
  br label %logical_and_merge_647

logical_and_merge_647:
  %t656 = phi i1 [ false, %logical_and_entry_647 ], [ %t655, %logical_and_right_end_647 ]
  br label %logical_and_right_end_643

logical_and_right_end_643:
  br label %logical_and_merge_643

logical_and_merge_643:
  %t657 = phi i1 [ false, %logical_and_entry_643 ], [ %t656, %logical_and_right_end_643 ]
  br label %logical_and_right_end_641

logical_and_right_end_641:
  br label %logical_and_merge_641

logical_and_merge_641:
  %t658 = phi i1 [ false, %logical_and_entry_641 ], [ %t657, %logical_and_right_end_641 ]
  br label %logical_and_right_end_639

logical_and_right_end_639:
  br label %logical_and_merge_639

logical_and_merge_639:
  %t659 = phi i1 [ false, %logical_and_entry_639 ], [ %t658, %logical_and_right_end_639 ]
  store i1 %t659, i1* %l23
  %t660 = load i1, i1* %l23
  %t661 = insertvalue %EnumLayoutHeaderParse undef, i1 %t660, 0
  %t662 = load i8*, i8** %l5
  %t663 = insertvalue %EnumLayoutHeaderParse %t661, i8* %t662, 1
  %t664 = load double, double* %l9
  %t665 = insertvalue %EnumLayoutHeaderParse %t663, double %t664, 2
  %t666 = load double, double* %l10
  %t667 = insertvalue %EnumLayoutHeaderParse %t665, double %t666, 3
  %t668 = load i8*, i8** %l6
  %t669 = insertvalue %EnumLayoutHeaderParse %t667, i8* %t668, 4
  %t670 = load double, double* %l11
  %t671 = insertvalue %EnumLayoutHeaderParse %t669, double %t670, 5
  %t672 = load double, double* %l12
  %t673 = insertvalue %EnumLayoutHeaderParse %t671, double %t672, 6
  %t674 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t675 = insertvalue %EnumLayoutHeaderParse %t673, { i8**, i64 }* %t674, 7
  ret %EnumLayoutHeaderParse %t675
}

define %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %text, i8* %enum_name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeEnumVariantLayout
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca i1
  %l6 = alloca i1
  %l7 = alloca i1
  %l8 = alloca i1
  %l9 = alloca double
  %l10 = alloca double
  %l11 = alloca double
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca i8*
  %l15 = alloca i8*
  %l16 = alloca %NumberParseResult
  %l17 = alloca i8*
  %l18 = alloca %NumberParseResult
  %l19 = alloca i8*
  %l20 = alloca %NumberParseResult
  %l21 = alloca i8*
  %l22 = alloca %NumberParseResult
  %l23 = alloca i1
  %l24 = alloca %NativeEnumVariantLayout
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
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
  %s13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t14 = insertvalue %NativeEnumVariantLayout undef, i8* %s13, 0
  %t15 = sitofp i64 0 to double
  %t16 = insertvalue %NativeEnumVariantLayout %t14, double %t15, 1
  %t17 = sitofp i64 0 to double
  %t18 = insertvalue %NativeEnumVariantLayout %t16, double %t17, 2
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %NativeEnumVariantLayout %t18, double %t19, 3
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %NativeEnumVariantLayout %t20, double %t21, 4
  %t23 = getelementptr [0 x %NativeStructLayoutField*], [0 x %NativeStructLayoutField*]* null, i32 1
  %t24 = ptrtoint [0 x %NativeStructLayoutField*]* %t23 to i64
  %t25 = icmp eq i64 %t24, 0
  %t26 = select i1 %t25, i64 1, i64 %t24
  %t27 = call i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to %NativeStructLayoutField**
  %t29 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* null, i32 1
  %t30 = ptrtoint { %NativeStructLayoutField**, i64 }* %t29 to i64
  %t31 = call i8* @malloc(i64 %t30)
  %t32 = bitcast i8* %t31 to { %NativeStructLayoutField**, i64 }*
  %t33 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t32, i32 0, i32 0
  store %NativeStructLayoutField** %t28, %NativeStructLayoutField*** %t33
  %t34 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  %t35 = insertvalue %NativeEnumVariantLayout %t22, { %NativeStructLayoutField**, i64 }* %t32, 5
  store %NativeEnumVariantLayout %t35, %NativeEnumVariantLayout* %l2
  %t36 = load i8*, i8** %l0
  %t37 = call i64 @sailfin_runtime_string_length(i8* %t36)
  %t38 = icmp eq i64 %t37, 0
  %t39 = load i8*, i8** %l0
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  br i1 %t38, label %then0, label %merge1
then0:
  %t42 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s43 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t44 = call i8* @sailfin_runtime_string_concat(i8* %s43, i8* %enum_name)
  %s45 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1960327680, i32 0, i32 0
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %s45)
  %t47 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t42, i8* %t46)
  store { i8**, i64 }* %t47, { i8**, i64 }** %l1
  %t48 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t49 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t50 = insertvalue %EnumLayoutVariantParse %t48, %NativeEnumVariantLayout %t49, 1
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t52 = insertvalue %EnumLayoutVariantParse %t50, { i8**, i64 }* %t51, 2
  ret %EnumLayoutVariantParse %t52
merge1:
  %t53 = load i8*, i8** %l0
  %t54 = call { i8**, i64 }* @split_whitespace(i8* %t53)
  store { i8**, i64 }* %t54, { i8**, i64 }** %l3
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t56 = load { i8**, i64 }, { i8**, i64 }* %t55
  %t57 = extractvalue { i8**, i64 } %t56, 1
  %t58 = icmp eq i64 %t57, 0
  %t59 = load i8*, i8** %l0
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t61 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t58, label %then2, label %merge3
then2:
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s64 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t65 = call i8* @sailfin_runtime_string_concat(i8* %s64, i8* %enum_name)
  %s66 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h238974215, i32 0, i32 0
  %t67 = call i8* @sailfin_runtime_string_concat(i8* %t65, i8* %s66)
  %t68 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t63, i8* %t67)
  store { i8**, i64 }* %t68, { i8**, i64 }** %l1
  %t69 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t70 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t71 = insertvalue %EnumLayoutVariantParse %t69, %NativeEnumVariantLayout %t70, 1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t73 = insertvalue %EnumLayoutVariantParse %t71, { i8**, i64 }* %t72, 2
  ret %EnumLayoutVariantParse %t73
merge3:
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t75 = load { i8**, i64 }, { i8**, i64 }* %t74
  %t76 = extractvalue { i8**, i64 } %t75, 0
  %t77 = extractvalue { i8**, i64 } %t75, 1
  %t78 = icmp uge i64 0, %t77
  ; bounds check: %t78 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t77)
  %t79 = getelementptr i8*, i8** %t76, i64 0
  %t80 = load i8*, i8** %t79
  store i8* %t80, i8** %l4
  %t81 = load i8*, i8** %l4
  %t82 = call i64 @sailfin_runtime_string_length(i8* %t81)
  %t83 = icmp eq i64 %t82, 0
  %t84 = load i8*, i8** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t87 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t88 = load i8*, i8** %l4
  br i1 %t83, label %then4, label %merge5
then4:
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s90 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t91 = call i8* @sailfin_runtime_string_concat(i8* %s90, i8* %enum_name)
  %s92 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1605654048, i32 0, i32 0
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t91, i8* %s92)
  %t94 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t89, i8* %t93)
  store { i8**, i64 }* %t94, { i8**, i64 }** %l1
  %t95 = insertvalue %EnumLayoutVariantParse undef, i1 0, 0
  %t96 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t97 = insertvalue %EnumLayoutVariantParse %t95, %NativeEnumVariantLayout %t96, 1
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = insertvalue %EnumLayoutVariantParse %t97, { i8**, i64 }* %t98, 2
  ret %EnumLayoutVariantParse %t99
merge5:
  store i1 0, i1* %l5
  store i1 0, i1* %l6
  store i1 0, i1* %l7
  store i1 0, i1* %l8
  %t100 = sitofp i64 0 to double
  store double %t100, double* %l9
  %t101 = sitofp i64 0 to double
  store double %t101, double* %l10
  %t102 = sitofp i64 0 to double
  store double %t102, double* %l11
  %t103 = sitofp i64 0 to double
  store double %t103, double* %l12
  %t104 = sitofp i64 1 to double
  store double %t104, double* %l13
  %t105 = load i8*, i8** %l0
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t107 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t108 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t109 = load i8*, i8** %l4
  %t110 = load i1, i1* %l5
  %t111 = load i1, i1* %l6
  %t112 = load i1, i1* %l7
  %t113 = load i1, i1* %l8
  %t114 = load double, double* %l9
  %t115 = load double, double* %l10
  %t116 = load double, double* %l11
  %t117 = load double, double* %l12
  %t118 = load double, double* %l13
  br label %loop.header6
loop.header6:
  %t509 = phi i1 [ %t110, %merge5 ], [ %t499, %loop.latch8 ]
  %t510 = phi double [ %t114, %merge5 ], [ %t500, %loop.latch8 ]
  %t511 = phi { i8**, i64 }* [ %t106, %merge5 ], [ %t501, %loop.latch8 ]
  %t512 = phi i1 [ %t111, %merge5 ], [ %t502, %loop.latch8 ]
  %t513 = phi double [ %t115, %merge5 ], [ %t503, %loop.latch8 ]
  %t514 = phi i1 [ %t112, %merge5 ], [ %t504, %loop.latch8 ]
  %t515 = phi double [ %t116, %merge5 ], [ %t505, %loop.latch8 ]
  %t516 = phi i1 [ %t113, %merge5 ], [ %t506, %loop.latch8 ]
  %t517 = phi double [ %t117, %merge5 ], [ %t507, %loop.latch8 ]
  %t518 = phi double [ %t118, %merge5 ], [ %t508, %loop.latch8 ]
  store i1 %t509, i1* %l5
  store double %t510, double* %l9
  store { i8**, i64 }* %t511, { i8**, i64 }** %l1
  store i1 %t512, i1* %l6
  store double %t513, double* %l10
  store i1 %t514, i1* %l7
  store double %t515, double* %l11
  store i1 %t516, i1* %l8
  store double %t517, double* %l12
  store double %t518, double* %l13
  br label %loop.body7
loop.body7:
  %t119 = load double, double* %l13
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t121 = load { i8**, i64 }, { i8**, i64 }* %t120
  %t122 = extractvalue { i8**, i64 } %t121, 1
  %t123 = sitofp i64 %t122 to double
  %t124 = fcmp oge double %t119, %t123
  %t125 = load i8*, i8** %l0
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t129 = load i8*, i8** %l4
  %t130 = load i1, i1* %l5
  %t131 = load i1, i1* %l6
  %t132 = load i1, i1* %l7
  %t133 = load i1, i1* %l8
  %t134 = load double, double* %l9
  %t135 = load double, double* %l10
  %t136 = load double, double* %l11
  %t137 = load double, double* %l12
  %t138 = load double, double* %l13
  br i1 %t124, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t140 = load double, double* %l13
  %t141 = call double @llvm.round.f64(double %t140)
  %t142 = fptosi double %t141 to i64
  %t143 = load { i8**, i64 }, { i8**, i64 }* %t139
  %t144 = extractvalue { i8**, i64 } %t143, 0
  %t145 = extractvalue { i8**, i64 } %t143, 1
  %t146 = icmp uge i64 %t142, %t145
  ; bounds check: %t146 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t142, i64 %t145)
  %t147 = getelementptr i8*, i8** %t144, i64 %t142
  %t148 = load i8*, i8** %t147
  store i8* %t148, i8** %l14
  %t149 = load i8*, i8** %l14
  %s150 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h275319236, i32 0, i32 0
  %t151 = call i1 @starts_with(i8* %t149, i8* %s150)
  %t152 = load i8*, i8** %l0
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t154 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t156 = load i8*, i8** %l4
  %t157 = load i1, i1* %l5
  %t158 = load i1, i1* %l6
  %t159 = load i1, i1* %l7
  %t160 = load i1, i1* %l8
  %t161 = load double, double* %l9
  %t162 = load double, double* %l10
  %t163 = load double, double* %l11
  %t164 = load double, double* %l12
  %t165 = load double, double* %l13
  %t166 = load i8*, i8** %l14
  br i1 %t151, label %then12, label %else13
then12:
  %t167 = load i8*, i8** %l14
  %t168 = load i8*, i8** %l14
  %t169 = call i64 @sailfin_runtime_string_length(i8* %t168)
  %t170 = call i8* @sailfin_runtime_substring(i8* %t167, i64 4, i64 %t169)
  store i8* %t170, i8** %l15
  %t171 = load i8*, i8** %l15
  %t172 = call %NumberParseResult @parse_decimal_number(i8* %t171)
  store %NumberParseResult %t172, %NumberParseResult* %l16
  %t173 = load %NumberParseResult, %NumberParseResult* %l16
  %t174 = extractvalue %NumberParseResult %t173, 0
  %t175 = load i8*, i8** %l0
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t177 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t179 = load i8*, i8** %l4
  %t180 = load i1, i1* %l5
  %t181 = load i1, i1* %l6
  %t182 = load i1, i1* %l7
  %t183 = load i1, i1* %l8
  %t184 = load double, double* %l9
  %t185 = load double, double* %l10
  %t186 = load double, double* %l11
  %t187 = load double, double* %l12
  %t188 = load double, double* %l13
  %t189 = load i8*, i8** %l14
  %t190 = load i8*, i8** %l15
  %t191 = load %NumberParseResult, %NumberParseResult* %l16
  br i1 %t174, label %then15, label %else16
then15:
  store i1 1, i1* %l5
  %t192 = load %NumberParseResult, %NumberParseResult* %l16
  %t193 = extractvalue %NumberParseResult %t192, 1
  store double %t193, double* %l9
  %t194 = load i1, i1* %l5
  %t195 = load double, double* %l9
  br label %merge17
else16:
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s197 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t198 = call i8* @sailfin_runtime_string_concat(i8* %s197, i8* %enum_name)
  %s199 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t200 = call i8* @sailfin_runtime_string_concat(i8* %t198, i8* %s199)
  %t201 = load i8*, i8** %l4
  %t202 = call i8* @sailfin_runtime_string_concat(i8* %t200, i8* %t201)
  %s203 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h879467198, i32 0, i32 0
  %t204 = call i8* @sailfin_runtime_string_concat(i8* %t202, i8* %s203)
  %t205 = load i8*, i8** %l15
  %t206 = call i8* @sailfin_runtime_string_concat(i8* %t204, i8* %t205)
  %t207 = alloca [2 x i8], align 1
  %t208 = getelementptr [2 x i8], [2 x i8]* %t207, i32 0, i32 0
  store i8 96, i8* %t208
  %t209 = getelementptr [2 x i8], [2 x i8]* %t207, i32 0, i32 1
  store i8 0, i8* %t209
  %t210 = getelementptr [2 x i8], [2 x i8]* %t207, i32 0, i32 0
  %t211 = call i8* @sailfin_runtime_string_concat(i8* %t206, i8* %t210)
  %t212 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t196, i8* %t211)
  store { i8**, i64 }* %t212, { i8**, i64 }** %l1
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t214 = phi i1 [ %t194, %then15 ], [ %t180, %else16 ]
  %t215 = phi double [ %t195, %then15 ], [ %t184, %else16 ]
  %t216 = phi { i8**, i64 }* [ %t176, %then15 ], [ %t213, %else16 ]
  store i1 %t214, i1* %l5
  store double %t215, double* %l9
  store { i8**, i64 }* %t216, { i8**, i64 }** %l1
  %t217 = load i1, i1* %l5
  %t218 = load double, double* %l9
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
else13:
  %t220 = load i8*, i8** %l14
  %s221 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t222 = call i1 @starts_with(i8* %t220, i8* %s221)
  %t223 = load i8*, i8** %l0
  %t224 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t225 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t227 = load i8*, i8** %l4
  %t228 = load i1, i1* %l5
  %t229 = load i1, i1* %l6
  %t230 = load i1, i1* %l7
  %t231 = load i1, i1* %l8
  %t232 = load double, double* %l9
  %t233 = load double, double* %l10
  %t234 = load double, double* %l11
  %t235 = load double, double* %l12
  %t236 = load double, double* %l13
  %t237 = load i8*, i8** %l14
  br i1 %t222, label %then18, label %else19
then18:
  %t238 = load i8*, i8** %l14
  %t239 = load i8*, i8** %l14
  %t240 = call i64 @sailfin_runtime_string_length(i8* %t239)
  %t241 = call i8* @sailfin_runtime_substring(i8* %t238, i64 7, i64 %t240)
  store i8* %t241, i8** %l17
  %t242 = load i8*, i8** %l17
  %t243 = call %NumberParseResult @parse_decimal_number(i8* %t242)
  store %NumberParseResult %t243, %NumberParseResult* %l18
  %t244 = load %NumberParseResult, %NumberParseResult* %l18
  %t245 = extractvalue %NumberParseResult %t244, 0
  %t246 = load i8*, i8** %l0
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t248 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t250 = load i8*, i8** %l4
  %t251 = load i1, i1* %l5
  %t252 = load i1, i1* %l6
  %t253 = load i1, i1* %l7
  %t254 = load i1, i1* %l8
  %t255 = load double, double* %l9
  %t256 = load double, double* %l10
  %t257 = load double, double* %l11
  %t258 = load double, double* %l12
  %t259 = load double, double* %l13
  %t260 = load i8*, i8** %l14
  %t261 = load i8*, i8** %l17
  %t262 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t245, label %then21, label %else22
then21:
  store i1 1, i1* %l6
  %t263 = load %NumberParseResult, %NumberParseResult* %l18
  %t264 = extractvalue %NumberParseResult %t263, 1
  store double %t264, double* %l10
  %t265 = load i1, i1* %l6
  %t266 = load double, double* %l10
  br label %merge23
else22:
  %t267 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s268 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t269 = call i8* @sailfin_runtime_string_concat(i8* %s268, i8* %enum_name)
  %s270 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %t269, i8* %s270)
  %t272 = load i8*, i8** %l4
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %t271, i8* %t272)
  %s274 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t275 = call i8* @sailfin_runtime_string_concat(i8* %t273, i8* %s274)
  %t276 = load i8*, i8** %l17
  %t277 = call i8* @sailfin_runtime_string_concat(i8* %t275, i8* %t276)
  %t278 = alloca [2 x i8], align 1
  %t279 = getelementptr [2 x i8], [2 x i8]* %t278, i32 0, i32 0
  store i8 96, i8* %t279
  %t280 = getelementptr [2 x i8], [2 x i8]* %t278, i32 0, i32 1
  store i8 0, i8* %t280
  %t281 = getelementptr [2 x i8], [2 x i8]* %t278, i32 0, i32 0
  %t282 = call i8* @sailfin_runtime_string_concat(i8* %t277, i8* %t281)
  %t283 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t267, i8* %t282)
  store { i8**, i64 }* %t283, { i8**, i64 }** %l1
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t285 = phi i1 [ %t265, %then21 ], [ %t252, %else22 ]
  %t286 = phi double [ %t266, %then21 ], [ %t256, %else22 ]
  %t287 = phi { i8**, i64 }* [ %t247, %then21 ], [ %t284, %else22 ]
  store i1 %t285, i1* %l6
  store double %t286, double* %l10
  store { i8**, i64 }* %t287, { i8**, i64 }** %l1
  %t288 = load i1, i1* %l6
  %t289 = load double, double* %l10
  %t290 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
else19:
  %t291 = load i8*, i8** %l14
  %s292 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t293 = call i1 @starts_with(i8* %t291, i8* %s292)
  %t294 = load i8*, i8** %l0
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t296 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t298 = load i8*, i8** %l4
  %t299 = load i1, i1* %l5
  %t300 = load i1, i1* %l6
  %t301 = load i1, i1* %l7
  %t302 = load i1, i1* %l8
  %t303 = load double, double* %l9
  %t304 = load double, double* %l10
  %t305 = load double, double* %l11
  %t306 = load double, double* %l12
  %t307 = load double, double* %l13
  %t308 = load i8*, i8** %l14
  br i1 %t293, label %then24, label %else25
then24:
  %t309 = load i8*, i8** %l14
  %t310 = load i8*, i8** %l14
  %t311 = call i64 @sailfin_runtime_string_length(i8* %t310)
  %t312 = call i8* @sailfin_runtime_substring(i8* %t309, i64 5, i64 %t311)
  store i8* %t312, i8** %l19
  %t313 = load i8*, i8** %l19
  %t314 = call %NumberParseResult @parse_decimal_number(i8* %t313)
  store %NumberParseResult %t314, %NumberParseResult* %l20
  %t315 = load %NumberParseResult, %NumberParseResult* %l20
  %t316 = extractvalue %NumberParseResult %t315, 0
  %t317 = load i8*, i8** %l0
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t319 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t321 = load i8*, i8** %l4
  %t322 = load i1, i1* %l5
  %t323 = load i1, i1* %l6
  %t324 = load i1, i1* %l7
  %t325 = load i1, i1* %l8
  %t326 = load double, double* %l9
  %t327 = load double, double* %l10
  %t328 = load double, double* %l11
  %t329 = load double, double* %l12
  %t330 = load double, double* %l13
  %t331 = load i8*, i8** %l14
  %t332 = load i8*, i8** %l19
  %t333 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t316, label %then27, label %else28
then27:
  store i1 1, i1* %l7
  %t334 = load %NumberParseResult, %NumberParseResult* %l20
  %t335 = extractvalue %NumberParseResult %t334, 1
  store double %t335, double* %l11
  %t336 = load i1, i1* %l7
  %t337 = load double, double* %l11
  br label %merge29
else28:
  %t338 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s339 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t340 = call i8* @sailfin_runtime_string_concat(i8* %s339, i8* %enum_name)
  %s341 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t342 = call i8* @sailfin_runtime_string_concat(i8* %t340, i8* %s341)
  %t343 = load i8*, i8** %l4
  %t344 = call i8* @sailfin_runtime_string_concat(i8* %t342, i8* %t343)
  %s345 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t346 = call i8* @sailfin_runtime_string_concat(i8* %t344, i8* %s345)
  %t347 = load i8*, i8** %l19
  %t348 = call i8* @sailfin_runtime_string_concat(i8* %t346, i8* %t347)
  %t349 = alloca [2 x i8], align 1
  %t350 = getelementptr [2 x i8], [2 x i8]* %t349, i32 0, i32 0
  store i8 96, i8* %t350
  %t351 = getelementptr [2 x i8], [2 x i8]* %t349, i32 0, i32 1
  store i8 0, i8* %t351
  %t352 = getelementptr [2 x i8], [2 x i8]* %t349, i32 0, i32 0
  %t353 = call i8* @sailfin_runtime_string_concat(i8* %t348, i8* %t352)
  %t354 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t338, i8* %t353)
  store { i8**, i64 }* %t354, { i8**, i64 }** %l1
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t356 = phi i1 [ %t336, %then27 ], [ %t324, %else28 ]
  %t357 = phi double [ %t337, %then27 ], [ %t328, %else28 ]
  %t358 = phi { i8**, i64 }* [ %t318, %then27 ], [ %t355, %else28 ]
  store i1 %t356, i1* %l7
  store double %t357, double* %l11
  store { i8**, i64 }* %t358, { i8**, i64 }** %l1
  %t359 = load i1, i1* %l7
  %t360 = load double, double* %l11
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t362 = load i8*, i8** %l14
  %s363 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t364 = call i1 @starts_with(i8* %t362, i8* %s363)
  %t365 = load i8*, i8** %l0
  %t366 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t367 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t368 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t369 = load i8*, i8** %l4
  %t370 = load i1, i1* %l5
  %t371 = load i1, i1* %l6
  %t372 = load i1, i1* %l7
  %t373 = load i1, i1* %l8
  %t374 = load double, double* %l9
  %t375 = load double, double* %l10
  %t376 = load double, double* %l11
  %t377 = load double, double* %l12
  %t378 = load double, double* %l13
  %t379 = load i8*, i8** %l14
  br i1 %t364, label %then30, label %else31
then30:
  %t380 = load i8*, i8** %l14
  %t381 = load i8*, i8** %l14
  %t382 = call i64 @sailfin_runtime_string_length(i8* %t381)
  %t383 = call i8* @sailfin_runtime_substring(i8* %t380, i64 6, i64 %t382)
  store i8* %t383, i8** %l21
  %t384 = load i8*, i8** %l21
  %t385 = call %NumberParseResult @parse_decimal_number(i8* %t384)
  store %NumberParseResult %t385, %NumberParseResult* %l22
  %t386 = load %NumberParseResult, %NumberParseResult* %l22
  %t387 = extractvalue %NumberParseResult %t386, 0
  %t388 = load i8*, i8** %l0
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t390 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t392 = load i8*, i8** %l4
  %t393 = load i1, i1* %l5
  %t394 = load i1, i1* %l6
  %t395 = load i1, i1* %l7
  %t396 = load i1, i1* %l8
  %t397 = load double, double* %l9
  %t398 = load double, double* %l10
  %t399 = load double, double* %l11
  %t400 = load double, double* %l12
  %t401 = load double, double* %l13
  %t402 = load i8*, i8** %l14
  %t403 = load i8*, i8** %l21
  %t404 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t387, label %then33, label %else34
then33:
  store i1 1, i1* %l8
  %t405 = load %NumberParseResult, %NumberParseResult* %l22
  %t406 = extractvalue %NumberParseResult %t405, 1
  store double %t406, double* %l12
  %t407 = load i1, i1* %l8
  %t408 = load double, double* %l12
  br label %merge35
else34:
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s410 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t411 = call i8* @sailfin_runtime_string_concat(i8* %s410, i8* %enum_name)
  %s412 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t413 = call i8* @sailfin_runtime_string_concat(i8* %t411, i8* %s412)
  %t414 = load i8*, i8** %l4
  %t415 = call i8* @sailfin_runtime_string_concat(i8* %t413, i8* %t414)
  %s416 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t417 = call i8* @sailfin_runtime_string_concat(i8* %t415, i8* %s416)
  %t418 = load i8*, i8** %l21
  %t419 = call i8* @sailfin_runtime_string_concat(i8* %t417, i8* %t418)
  %t420 = alloca [2 x i8], align 1
  %t421 = getelementptr [2 x i8], [2 x i8]* %t420, i32 0, i32 0
  store i8 96, i8* %t421
  %t422 = getelementptr [2 x i8], [2 x i8]* %t420, i32 0, i32 1
  store i8 0, i8* %t422
  %t423 = getelementptr [2 x i8], [2 x i8]* %t420, i32 0, i32 0
  %t424 = call i8* @sailfin_runtime_string_concat(i8* %t419, i8* %t423)
  %t425 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t409, i8* %t424)
  store { i8**, i64 }* %t425, { i8**, i64 }** %l1
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t427 = phi i1 [ %t407, %then33 ], [ %t396, %else34 ]
  %t428 = phi double [ %t408, %then33 ], [ %t400, %else34 ]
  %t429 = phi { i8**, i64 }* [ %t389, %then33 ], [ %t426, %else34 ]
  store i1 %t427, i1* %l8
  store double %t428, double* %l12
  store { i8**, i64 }* %t429, { i8**, i64 }** %l1
  %t430 = load i1, i1* %l8
  %t431 = load double, double* %l12
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
else31:
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s434 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t435 = call i8* @sailfin_runtime_string_concat(i8* %s434, i8* %enum_name)
  %s436 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t437 = call i8* @sailfin_runtime_string_concat(i8* %t435, i8* %s436)
  %t438 = load i8*, i8** %l4
  %t439 = call i8* @sailfin_runtime_string_concat(i8* %t437, i8* %t438)
  %s440 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t441 = call i8* @sailfin_runtime_string_concat(i8* %t439, i8* %s440)
  %t442 = load i8*, i8** %l14
  %t443 = call i8* @sailfin_runtime_string_concat(i8* %t441, i8* %t442)
  %t444 = alloca [2 x i8], align 1
  %t445 = getelementptr [2 x i8], [2 x i8]* %t444, i32 0, i32 0
  store i8 96, i8* %t445
  %t446 = getelementptr [2 x i8], [2 x i8]* %t444, i32 0, i32 1
  store i8 0, i8* %t446
  %t447 = getelementptr [2 x i8], [2 x i8]* %t444, i32 0, i32 0
  %t448 = call i8* @sailfin_runtime_string_concat(i8* %t443, i8* %t447)
  %t449 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t433, i8* %t448)
  store { i8**, i64 }* %t449, { i8**, i64 }** %l1
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t451 = phi i1 [ %t430, %merge35 ], [ %t373, %else31 ]
  %t452 = phi double [ %t431, %merge35 ], [ %t377, %else31 ]
  %t453 = phi { i8**, i64 }* [ %t432, %merge35 ], [ %t450, %else31 ]
  store i1 %t451, i1* %l8
  store double %t452, double* %l12
  store { i8**, i64 }* %t453, { i8**, i64 }** %l1
  %t454 = load i1, i1* %l8
  %t455 = load double, double* %l12
  %t456 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t458 = phi i1 [ %t359, %merge29 ], [ %t301, %merge32 ]
  %t459 = phi double [ %t360, %merge29 ], [ %t305, %merge32 ]
  %t460 = phi { i8**, i64 }* [ %t361, %merge29 ], [ %t456, %merge32 ]
  %t461 = phi i1 [ %t302, %merge29 ], [ %t454, %merge32 ]
  %t462 = phi double [ %t306, %merge29 ], [ %t455, %merge32 ]
  store i1 %t458, i1* %l7
  store double %t459, double* %l11
  store { i8**, i64 }* %t460, { i8**, i64 }** %l1
  store i1 %t461, i1* %l8
  store double %t462, double* %l12
  %t463 = load i1, i1* %l7
  %t464 = load double, double* %l11
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t466 = load i1, i1* %l8
  %t467 = load double, double* %l12
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t470 = phi i1 [ %t288, %merge23 ], [ %t229, %merge26 ]
  %t471 = phi double [ %t289, %merge23 ], [ %t233, %merge26 ]
  %t472 = phi { i8**, i64 }* [ %t290, %merge23 ], [ %t465, %merge26 ]
  %t473 = phi i1 [ %t230, %merge23 ], [ %t463, %merge26 ]
  %t474 = phi double [ %t234, %merge23 ], [ %t464, %merge26 ]
  %t475 = phi i1 [ %t231, %merge23 ], [ %t466, %merge26 ]
  %t476 = phi double [ %t235, %merge23 ], [ %t467, %merge26 ]
  store i1 %t470, i1* %l6
  store double %t471, double* %l10
  store { i8**, i64 }* %t472, { i8**, i64 }** %l1
  store i1 %t473, i1* %l7
  store double %t474, double* %l11
  store i1 %t475, i1* %l8
  store double %t476, double* %l12
  %t477 = load i1, i1* %l6
  %t478 = load double, double* %l10
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t480 = load i1, i1* %l7
  %t481 = load double, double* %l11
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t483 = load i1, i1* %l8
  %t484 = load double, double* %l12
  %t485 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t486 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t487 = phi i1 [ %t217, %merge17 ], [ %t157, %merge20 ]
  %t488 = phi double [ %t218, %merge17 ], [ %t161, %merge20 ]
  %t489 = phi { i8**, i64 }* [ %t219, %merge17 ], [ %t479, %merge20 ]
  %t490 = phi i1 [ %t158, %merge17 ], [ %t477, %merge20 ]
  %t491 = phi double [ %t162, %merge17 ], [ %t478, %merge20 ]
  %t492 = phi i1 [ %t159, %merge17 ], [ %t480, %merge20 ]
  %t493 = phi double [ %t163, %merge17 ], [ %t481, %merge20 ]
  %t494 = phi i1 [ %t160, %merge17 ], [ %t483, %merge20 ]
  %t495 = phi double [ %t164, %merge17 ], [ %t484, %merge20 ]
  store i1 %t487, i1* %l5
  store double %t488, double* %l9
  store { i8**, i64 }* %t489, { i8**, i64 }** %l1
  store i1 %t490, i1* %l6
  store double %t491, double* %l10
  store i1 %t492, i1* %l7
  store double %t493, double* %l11
  store i1 %t494, i1* %l8
  store double %t495, double* %l12
  %t496 = load double, double* %l13
  %t497 = sitofp i64 1 to double
  %t498 = fadd double %t496, %t497
  store double %t498, double* %l13
  br label %loop.latch8
loop.latch8:
  %t499 = load i1, i1* %l5
  %t500 = load double, double* %l9
  %t501 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t502 = load i1, i1* %l6
  %t503 = load double, double* %l10
  %t504 = load i1, i1* %l7
  %t505 = load double, double* %l11
  %t506 = load i1, i1* %l8
  %t507 = load double, double* %l12
  %t508 = load double, double* %l13
  br label %loop.header6
afterloop9:
  %t519 = load i1, i1* %l5
  %t520 = load double, double* %l9
  %t521 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t522 = load i1, i1* %l6
  %t523 = load double, double* %l10
  %t524 = load i1, i1* %l7
  %t525 = load double, double* %l11
  %t526 = load i1, i1* %l8
  %t527 = load double, double* %l12
  %t528 = load double, double* %l13
  %t529 = load i1, i1* %l5
  %t530 = xor i1 %t529, 1
  %t531 = load i8*, i8** %l0
  %t532 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t533 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t535 = load i8*, i8** %l4
  %t536 = load i1, i1* %l5
  %t537 = load i1, i1* %l6
  %t538 = load i1, i1* %l7
  %t539 = load i1, i1* %l8
  %t540 = load double, double* %l9
  %t541 = load double, double* %l10
  %t542 = load double, double* %l11
  %t543 = load double, double* %l12
  %t544 = load double, double* %l13
  br i1 %t530, label %then36, label %merge37
then36:
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s546 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t547 = call i8* @sailfin_runtime_string_concat(i8* %s546, i8* %enum_name)
  %s548 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t549 = call i8* @sailfin_runtime_string_concat(i8* %t547, i8* %s548)
  %t550 = load i8*, i8** %l4
  %t551 = call i8* @sailfin_runtime_string_concat(i8* %t549, i8* %t550)
  %s552 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1697653870, i32 0, i32 0
  %t553 = call i8* @sailfin_runtime_string_concat(i8* %t551, i8* %s552)
  %t554 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t545, i8* %t553)
  store { i8**, i64 }* %t554, { i8**, i64 }** %l1
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t556 = phi { i8**, i64 }* [ %t555, %then36 ], [ %t532, %afterloop9 ]
  store { i8**, i64 }* %t556, { i8**, i64 }** %l1
  %t557 = load i1, i1* %l6
  %t558 = xor i1 %t557, 1
  %t559 = load i8*, i8** %l0
  %t560 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t561 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t562 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t563 = load i8*, i8** %l4
  %t564 = load i1, i1* %l5
  %t565 = load i1, i1* %l6
  %t566 = load i1, i1* %l7
  %t567 = load i1, i1* %l8
  %t568 = load double, double* %l9
  %t569 = load double, double* %l10
  %t570 = load double, double* %l11
  %t571 = load double, double* %l12
  %t572 = load double, double* %l13
  br i1 %t558, label %then38, label %merge39
then38:
  %t573 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s574 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t575 = call i8* @sailfin_runtime_string_concat(i8* %s574, i8* %enum_name)
  %s576 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t577 = call i8* @sailfin_runtime_string_concat(i8* %t575, i8* %s576)
  %t578 = load i8*, i8** %l4
  %t579 = call i8* @sailfin_runtime_string_concat(i8* %t577, i8* %t578)
  %s580 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t581 = call i8* @sailfin_runtime_string_concat(i8* %t579, i8* %s580)
  %t582 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t573, i8* %t581)
  store { i8**, i64 }* %t582, { i8**, i64 }** %l1
  %t583 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t584 = phi { i8**, i64 }* [ %t583, %then38 ], [ %t560, %merge37 ]
  store { i8**, i64 }* %t584, { i8**, i64 }** %l1
  %t585 = load i1, i1* %l7
  %t586 = xor i1 %t585, 1
  %t587 = load i8*, i8** %l0
  %t588 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t589 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t590 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t591 = load i8*, i8** %l4
  %t592 = load i1, i1* %l5
  %t593 = load i1, i1* %l6
  %t594 = load i1, i1* %l7
  %t595 = load i1, i1* %l8
  %t596 = load double, double* %l9
  %t597 = load double, double* %l10
  %t598 = load double, double* %l11
  %t599 = load double, double* %l12
  %t600 = load double, double* %l13
  br i1 %t586, label %then40, label %merge41
then40:
  %t601 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s602 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t603 = call i8* @sailfin_runtime_string_concat(i8* %s602, i8* %enum_name)
  %s604 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t605 = call i8* @sailfin_runtime_string_concat(i8* %t603, i8* %s604)
  %t606 = load i8*, i8** %l4
  %t607 = call i8* @sailfin_runtime_string_concat(i8* %t605, i8* %t606)
  %s608 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t609 = call i8* @sailfin_runtime_string_concat(i8* %t607, i8* %s608)
  %t610 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t601, i8* %t609)
  store { i8**, i64 }* %t610, { i8**, i64 }** %l1
  %t611 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t612 = phi { i8**, i64 }* [ %t611, %then40 ], [ %t588, %merge39 ]
  store { i8**, i64 }* %t612, { i8**, i64 }** %l1
  %t613 = load i1, i1* %l8
  %t614 = xor i1 %t613, 1
  %t615 = load i8*, i8** %l0
  %t616 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t617 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t618 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t619 = load i8*, i8** %l4
  %t620 = load i1, i1* %l5
  %t621 = load i1, i1* %l6
  %t622 = load i1, i1* %l7
  %t623 = load i1, i1* %l8
  %t624 = load double, double* %l9
  %t625 = load double, double* %l10
  %t626 = load double, double* %l11
  %t627 = load double, double* %l12
  %t628 = load double, double* %l13
  br i1 %t614, label %then42, label %merge43
then42:
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s630 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t631 = call i8* @sailfin_runtime_string_concat(i8* %s630, i8* %enum_name)
  %s632 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t633 = call i8* @sailfin_runtime_string_concat(i8* %t631, i8* %s632)
  %t634 = load i8*, i8** %l4
  %t635 = call i8* @sailfin_runtime_string_concat(i8* %t633, i8* %t634)
  %s636 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t637 = call i8* @sailfin_runtime_string_concat(i8* %t635, i8* %s636)
  %t638 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t629, i8* %t637)
  store { i8**, i64 }* %t638, { i8**, i64 }** %l1
  %t639 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t640 = phi { i8**, i64 }* [ %t639, %then42 ], [ %t616, %merge41 ]
  store { i8**, i64 }* %t640, { i8**, i64 }** %l1
  %t642 = load i1, i1* %l5
  br label %logical_and_entry_641

logical_and_entry_641:
  br i1 %t642, label %logical_and_right_641, label %logical_and_merge_641

logical_and_right_641:
  %t644 = load i1, i1* %l6
  br label %logical_and_entry_643

logical_and_entry_643:
  br i1 %t644, label %logical_and_right_643, label %logical_and_merge_643

logical_and_right_643:
  %t646 = load i1, i1* %l7
  br label %logical_and_entry_645

logical_and_entry_645:
  br i1 %t646, label %logical_and_right_645, label %logical_and_merge_645

logical_and_right_645:
  %t648 = load i1, i1* %l8
  br label %logical_and_entry_647

logical_and_entry_647:
  br i1 %t648, label %logical_and_right_647, label %logical_and_merge_647

logical_and_right_647:
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t650 = load { i8**, i64 }, { i8**, i64 }* %t649
  %t651 = extractvalue { i8**, i64 } %t650, 1
  %t652 = icmp eq i64 %t651, 0
  br label %logical_and_right_end_647

logical_and_right_end_647:
  br label %logical_and_merge_647

logical_and_merge_647:
  %t653 = phi i1 [ false, %logical_and_entry_647 ], [ %t652, %logical_and_right_end_647 ]
  br label %logical_and_right_end_645

logical_and_right_end_645:
  br label %logical_and_merge_645

logical_and_merge_645:
  %t654 = phi i1 [ false, %logical_and_entry_645 ], [ %t653, %logical_and_right_end_645 ]
  br label %logical_and_right_end_643

logical_and_right_end_643:
  br label %logical_and_merge_643

logical_and_merge_643:
  %t655 = phi i1 [ false, %logical_and_entry_643 ], [ %t654, %logical_and_right_end_643 ]
  br label %logical_and_right_end_641

logical_and_right_end_641:
  br label %logical_and_merge_641

logical_and_merge_641:
  %t656 = phi i1 [ false, %logical_and_entry_641 ], [ %t655, %logical_and_right_end_641 ]
  store i1 %t656, i1* %l23
  %t657 = load i8*, i8** %l4
  %t658 = insertvalue %NativeEnumVariantLayout undef, i8* %t657, 0
  %t659 = load double, double* %l9
  %t660 = insertvalue %NativeEnumVariantLayout %t658, double %t659, 1
  %t661 = load double, double* %l10
  %t662 = insertvalue %NativeEnumVariantLayout %t660, double %t661, 2
  %t663 = load double, double* %l11
  %t664 = insertvalue %NativeEnumVariantLayout %t662, double %t663, 3
  %t665 = load double, double* %l12
  %t666 = insertvalue %NativeEnumVariantLayout %t664, double %t665, 4
  %t667 = getelementptr [0 x %NativeStructLayoutField*], [0 x %NativeStructLayoutField*]* null, i32 1
  %t668 = ptrtoint [0 x %NativeStructLayoutField*]* %t667 to i64
  %t669 = icmp eq i64 %t668, 0
  %t670 = select i1 %t669, i64 1, i64 %t668
  %t671 = call i8* @malloc(i64 %t670)
  %t672 = bitcast i8* %t671 to %NativeStructLayoutField**
  %t673 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* null, i32 1
  %t674 = ptrtoint { %NativeStructLayoutField**, i64 }* %t673 to i64
  %t675 = call i8* @malloc(i64 %t674)
  %t676 = bitcast i8* %t675 to { %NativeStructLayoutField**, i64 }*
  %t677 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t676, i32 0, i32 0
  store %NativeStructLayoutField** %t672, %NativeStructLayoutField*** %t677
  %t678 = getelementptr { %NativeStructLayoutField**, i64 }, { %NativeStructLayoutField**, i64 }* %t676, i32 0, i32 1
  store i64 0, i64* %t678
  %t679 = insertvalue %NativeEnumVariantLayout %t666, { %NativeStructLayoutField**, i64 }* %t676, 5
  store %NativeEnumVariantLayout %t679, %NativeEnumVariantLayout* %l24
  %t680 = load i1, i1* %l23
  %t681 = insertvalue %EnumLayoutVariantParse undef, i1 %t680, 0
  %t682 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t683 = insertvalue %EnumLayoutVariantParse %t681, %NativeEnumVariantLayout %t682, 1
  %t684 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t685 = insertvalue %EnumLayoutVariantParse %t683, { i8**, i64 }* %t684, 2
  ret %EnumLayoutVariantParse %t685
}

define %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %text, i8* %enum_name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NativeStructLayoutField
  %l3 = alloca { i8**, i64 }*
  %l4 = alloca i8*
  %l5 = alloca double
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca i1
  %l10 = alloca i1
  %l11 = alloca i1
  %l12 = alloca double
  %l13 = alloca double
  %l14 = alloca double
  %l15 = alloca double
  %l16 = alloca i8*
  %l17 = alloca i8*
  %l18 = alloca %NumberParseResult
  %l19 = alloca i8*
  %l20 = alloca %NumberParseResult
  %l21 = alloca i8*
  %l22 = alloca %NumberParseResult
  %l23 = alloca i1
  %l24 = alloca %NativeStructLayoutField
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
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
  %s13 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t14 = insertvalue %NativeStructLayoutField undef, i8* %s13, 0
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t16 = insertvalue %NativeStructLayoutField %t14, i8* %s15, 1
  %t17 = sitofp i64 0 to double
  %t18 = insertvalue %NativeStructLayoutField %t16, double %t17, 2
  %t19 = sitofp i64 0 to double
  %t20 = insertvalue %NativeStructLayoutField %t18, double %t19, 3
  %t21 = sitofp i64 0 to double
  %t22 = insertvalue %NativeStructLayoutField %t20, double %t21, 4
  store %NativeStructLayoutField %t22, %NativeStructLayoutField* %l2
  %t23 = load i8*, i8** %l0
  %t24 = call i64 @sailfin_runtime_string_length(i8* %t23)
  %t25 = icmp eq i64 %t24, 0
  %t26 = load i8*, i8** %l0
  %t27 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t28 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  br i1 %t25, label %then0, label %merge1
then0:
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s30 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t31 = call i8* @sailfin_runtime_string_concat(i8* %s30, i8* %enum_name)
  %s32 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h329133056, i32 0, i32 0
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t31, i8* %s32)
  %t34 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t29, i8* %t33)
  store { i8**, i64 }* %t34, { i8**, i64 }** %l1
  %t35 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s36 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t37 = insertvalue %EnumLayoutPayloadParse %t35, i8* %s36, 1
  %t38 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t39 = insertvalue %EnumLayoutPayloadParse %t37, %NativeStructLayoutField %t38, 2
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t41 = insertvalue %EnumLayoutPayloadParse %t39, { i8**, i64 }* %t40, 3
  ret %EnumLayoutPayloadParse %t41
merge1:
  %t42 = load i8*, i8** %l0
  %t43 = call { i8**, i64 }* @split_whitespace(i8* %t42)
  store { i8**, i64 }* %t43, { i8**, i64 }** %l3
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = icmp eq i64 %t46, 0
  %t48 = load i8*, i8** %l0
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t50 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t51 = load { i8**, i64 }*, { i8**, i64 }** %l3
  br i1 %t47, label %then2, label %merge3
then2:
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s53 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t54 = call i8* @sailfin_runtime_string_concat(i8* %s53, i8* %enum_name)
  %s55 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h755263238, i32 0, i32 0
  %t56 = call i8* @sailfin_runtime_string_concat(i8* %t54, i8* %s55)
  %t57 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t52, i8* %t56)
  store { i8**, i64 }* %t57, { i8**, i64 }** %l1
  %t58 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s59 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t60 = insertvalue %EnumLayoutPayloadParse %t58, i8* %s59, 1
  %t61 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t62 = insertvalue %EnumLayoutPayloadParse %t60, %NativeStructLayoutField %t61, 2
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t64 = insertvalue %EnumLayoutPayloadParse %t62, { i8**, i64 }* %t63, 3
  ret %EnumLayoutPayloadParse %t64
merge3:
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t66 = load { i8**, i64 }, { i8**, i64 }* %t65
  %t67 = extractvalue { i8**, i64 } %t66, 0
  %t68 = extractvalue { i8**, i64 } %t66, 1
  %t69 = icmp uge i64 0, %t68
  ; bounds check: %t69 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t68)
  %t70 = getelementptr i8*, i8** %t67, i64 0
  %t71 = load i8*, i8** %t70
  store i8* %t71, i8** %l4
  %t72 = load i8*, i8** %l4
  %t73 = alloca [2 x i8], align 1
  %t74 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  store i8 46, i8* %t74
  %t75 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 1
  store i8 0, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t73, i32 0, i32 0
  %t77 = call double @index_of(i8* %t72, i8* %t76)
  store double %t77, double* %l5
  %t79 = load double, double* %l5
  %t80 = sitofp i64 0 to double
  %t81 = fcmp ole double %t79, %t80
  br label %logical_or_entry_78

logical_or_entry_78:
  br i1 %t81, label %logical_or_merge_78, label %logical_or_right_78

logical_or_right_78:
  %t82 = load double, double* %l5
  %t83 = sitofp i64 1 to double
  %t84 = fadd double %t82, %t83
  %t85 = load i8*, i8** %l4
  %t86 = call i64 @sailfin_runtime_string_length(i8* %t85)
  %t87 = sitofp i64 %t86 to double
  %t88 = fcmp oge double %t84, %t87
  br label %logical_or_right_end_78

logical_or_right_end_78:
  br label %logical_or_merge_78

logical_or_merge_78:
  %t89 = phi i1 [ true, %logical_or_entry_78 ], [ %t88, %logical_or_right_end_78 ]
  %t90 = load i8*, i8** %l0
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t92 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t94 = load i8*, i8** %l4
  %t95 = load double, double* %l5
  br i1 %t89, label %then4, label %merge5
then4:
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s97 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t98 = call i8* @sailfin_runtime_string_concat(i8* %s97, i8* %enum_name)
  %s99 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h497146076, i32 0, i32 0
  %t100 = call i8* @sailfin_runtime_string_concat(i8* %t98, i8* %s99)
  %t101 = load i8*, i8** %l4
  %t102 = call i8* @sailfin_runtime_string_concat(i8* %t100, i8* %t101)
  %s103 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1123073249, i32 0, i32 0
  %t104 = call i8* @sailfin_runtime_string_concat(i8* %t102, i8* %s103)
  %t105 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t96, i8* %t104)
  store { i8**, i64 }* %t105, { i8**, i64 }** %l1
  %t106 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s107 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t108 = insertvalue %EnumLayoutPayloadParse %t106, i8* %s107, 1
  %t109 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t110 = insertvalue %EnumLayoutPayloadParse %t108, %NativeStructLayoutField %t109, 2
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = insertvalue %EnumLayoutPayloadParse %t110, { i8**, i64 }* %t111, 3
  ret %EnumLayoutPayloadParse %t112
merge5:
  %t113 = load i8*, i8** %l4
  %t114 = load double, double* %l5
  %t115 = call double @llvm.round.f64(double %t114)
  %t116 = fptosi double %t115 to i64
  %t117 = call i8* @sailfin_runtime_substring(i8* %t113, i64 0, i64 %t116)
  store i8* %t117, i8** %l6
  %t118 = load i8*, i8** %l4
  %t119 = load double, double* %l5
  %t120 = sitofp i64 1 to double
  %t121 = fadd double %t119, %t120
  %t122 = load i8*, i8** %l4
  %t123 = call i64 @sailfin_runtime_string_length(i8* %t122)
  %t124 = call double @llvm.round.f64(double %t121)
  %t125 = fptosi double %t124 to i64
  %t126 = call i8* @sailfin_runtime_substring(i8* %t118, i64 %t125, i64 %t123)
  store i8* %t126, i8** %l7
  %s127 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s127, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t128 = sitofp i64 0 to double
  store double %t128, double* %l12
  %t129 = sitofp i64 0 to double
  store double %t129, double* %l13
  %t130 = sitofp i64 0 to double
  store double %t130, double* %l14
  %t131 = sitofp i64 1 to double
  store double %t131, double* %l15
  %t132 = load i8*, i8** %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t136 = load i8*, i8** %l4
  %t137 = load double, double* %l5
  %t138 = load i8*, i8** %l6
  %t139 = load i8*, i8** %l7
  %t140 = load i8*, i8** %l8
  %t141 = load i1, i1* %l9
  %t142 = load i1, i1* %l10
  %t143 = load i1, i1* %l11
  %t144 = load double, double* %l12
  %t145 = load double, double* %l13
  %t146 = load double, double* %l14
  %t147 = load double, double* %l15
  br label %loop.header6
loop.header6:
  %t504 = phi i8* [ %t140, %merge5 ], [ %t495, %loop.latch8 ]
  %t505 = phi i1 [ %t141, %merge5 ], [ %t496, %loop.latch8 ]
  %t506 = phi double [ %t144, %merge5 ], [ %t497, %loop.latch8 ]
  %t507 = phi { i8**, i64 }* [ %t133, %merge5 ], [ %t498, %loop.latch8 ]
  %t508 = phi i1 [ %t142, %merge5 ], [ %t499, %loop.latch8 ]
  %t509 = phi double [ %t145, %merge5 ], [ %t500, %loop.latch8 ]
  %t510 = phi i1 [ %t143, %merge5 ], [ %t501, %loop.latch8 ]
  %t511 = phi double [ %t146, %merge5 ], [ %t502, %loop.latch8 ]
  %t512 = phi double [ %t147, %merge5 ], [ %t503, %loop.latch8 ]
  store i8* %t504, i8** %l8
  store i1 %t505, i1* %l9
  store double %t506, double* %l12
  store { i8**, i64 }* %t507, { i8**, i64 }** %l1
  store i1 %t508, i1* %l10
  store double %t509, double* %l13
  store i1 %t510, i1* %l11
  store double %t511, double* %l14
  store double %t512, double* %l15
  br label %loop.body7
loop.body7:
  %t148 = load double, double* %l15
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t150 = load { i8**, i64 }, { i8**, i64 }* %t149
  %t151 = extractvalue { i8**, i64 } %t150, 1
  %t152 = sitofp i64 %t151 to double
  %t153 = fcmp oge double %t148, %t152
  %t154 = load i8*, i8** %l0
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t156 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t158 = load i8*, i8** %l4
  %t159 = load double, double* %l5
  %t160 = load i8*, i8** %l6
  %t161 = load i8*, i8** %l7
  %t162 = load i8*, i8** %l8
  %t163 = load i1, i1* %l9
  %t164 = load i1, i1* %l10
  %t165 = load i1, i1* %l11
  %t166 = load double, double* %l12
  %t167 = load double, double* %l13
  %t168 = load double, double* %l14
  %t169 = load double, double* %l15
  br i1 %t153, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t171 = load double, double* %l15
  %t172 = call double @llvm.round.f64(double %t171)
  %t173 = fptosi double %t172 to i64
  %t174 = load { i8**, i64 }, { i8**, i64 }* %t170
  %t175 = extractvalue { i8**, i64 } %t174, 0
  %t176 = extractvalue { i8**, i64 } %t174, 1
  %t177 = icmp uge i64 %t173, %t176
  ; bounds check: %t177 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t173, i64 %t176)
  %t178 = getelementptr i8*, i8** %t175, i64 %t173
  %t179 = load i8*, i8** %t178
  store i8* %t179, i8** %l16
  %t180 = load i8*, i8** %l16
  %s181 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h524431183, i32 0, i32 0
  %t182 = call i1 @starts_with(i8* %t180, i8* %s181)
  %t183 = load i8*, i8** %l0
  %t184 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t185 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t187 = load i8*, i8** %l4
  %t188 = load double, double* %l5
  %t189 = load i8*, i8** %l6
  %t190 = load i8*, i8** %l7
  %t191 = load i8*, i8** %l8
  %t192 = load i1, i1* %l9
  %t193 = load i1, i1* %l10
  %t194 = load i1, i1* %l11
  %t195 = load double, double* %l12
  %t196 = load double, double* %l13
  %t197 = load double, double* %l14
  %t198 = load double, double* %l15
  %t199 = load i8*, i8** %l16
  br i1 %t182, label %then12, label %else13
then12:
  %t200 = load i8*, i8** %l16
  %t201 = load i8*, i8** %l16
  %t202 = call i64 @sailfin_runtime_string_length(i8* %t201)
  %t203 = call i8* @sailfin_runtime_substring(i8* %t200, i64 5, i64 %t202)
  store i8* %t203, i8** %l8
  %t204 = load i8*, i8** %l8
  br label %merge14
else13:
  %t205 = load i8*, i8** %l16
  %s206 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t207 = call i1 @starts_with(i8* %t205, i8* %s206)
  %t208 = load i8*, i8** %l0
  %t209 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t210 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t212 = load i8*, i8** %l4
  %t213 = load double, double* %l5
  %t214 = load i8*, i8** %l6
  %t215 = load i8*, i8** %l7
  %t216 = load i8*, i8** %l8
  %t217 = load i1, i1* %l9
  %t218 = load i1, i1* %l10
  %t219 = load i1, i1* %l11
  %t220 = load double, double* %l12
  %t221 = load double, double* %l13
  %t222 = load double, double* %l14
  %t223 = load double, double* %l15
  %t224 = load i8*, i8** %l16
  br i1 %t207, label %then15, label %else16
then15:
  %t225 = load i8*, i8** %l16
  %t226 = load i8*, i8** %l16
  %t227 = call i64 @sailfin_runtime_string_length(i8* %t226)
  %t228 = call i8* @sailfin_runtime_substring(i8* %t225, i64 7, i64 %t227)
  store i8* %t228, i8** %l17
  %t229 = load i8*, i8** %l17
  %t230 = call %NumberParseResult @parse_decimal_number(i8* %t229)
  store %NumberParseResult %t230, %NumberParseResult* %l18
  %t231 = load %NumberParseResult, %NumberParseResult* %l18
  %t232 = extractvalue %NumberParseResult %t231, 0
  %t233 = load i8*, i8** %l0
  %t234 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t235 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t236 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t237 = load i8*, i8** %l4
  %t238 = load double, double* %l5
  %t239 = load i8*, i8** %l6
  %t240 = load i8*, i8** %l7
  %t241 = load i8*, i8** %l8
  %t242 = load i1, i1* %l9
  %t243 = load i1, i1* %l10
  %t244 = load i1, i1* %l11
  %t245 = load double, double* %l12
  %t246 = load double, double* %l13
  %t247 = load double, double* %l14
  %t248 = load double, double* %l15
  %t249 = load i8*, i8** %l16
  %t250 = load i8*, i8** %l17
  %t251 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t232, label %then18, label %else19
then18:
  store i1 1, i1* %l9
  %t252 = load %NumberParseResult, %NumberParseResult* %l18
  %t253 = extractvalue %NumberParseResult %t252, 1
  store double %t253, double* %l12
  %t254 = load i1, i1* %l9
  %t255 = load double, double* %l12
  br label %merge20
else19:
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s257 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t258 = call i8* @sailfin_runtime_string_concat(i8* %s257, i8* %enum_name)
  %s259 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t260 = call i8* @sailfin_runtime_string_concat(i8* %t258, i8* %s259)
  %t261 = load i8*, i8** %l4
  %t262 = call i8* @sailfin_runtime_string_concat(i8* %t260, i8* %t261)
  %s263 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t264 = call i8* @sailfin_runtime_string_concat(i8* %t262, i8* %s263)
  %t265 = load i8*, i8** %l17
  %t266 = call i8* @sailfin_runtime_string_concat(i8* %t264, i8* %t265)
  %t267 = alloca [2 x i8], align 1
  %t268 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  store i8 96, i8* %t268
  %t269 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 1
  store i8 0, i8* %t269
  %t270 = getelementptr [2 x i8], [2 x i8]* %t267, i32 0, i32 0
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %t266, i8* %t270)
  %t272 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t256, i8* %t271)
  store { i8**, i64 }* %t272, { i8**, i64 }** %l1
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t274 = phi i1 [ %t254, %then18 ], [ %t242, %else19 ]
  %t275 = phi double [ %t255, %then18 ], [ %t245, %else19 ]
  %t276 = phi { i8**, i64 }* [ %t234, %then18 ], [ %t273, %else19 ]
  store i1 %t274, i1* %l9
  store double %t275, double* %l12
  store { i8**, i64 }* %t276, { i8**, i64 }** %l1
  %t277 = load i1, i1* %l9
  %t278 = load double, double* %l12
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t280 = load i8*, i8** %l16
  %s281 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t282 = call i1 @starts_with(i8* %t280, i8* %s281)
  %t283 = load i8*, i8** %l0
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t285 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t287 = load i8*, i8** %l4
  %t288 = load double, double* %l5
  %t289 = load i8*, i8** %l6
  %t290 = load i8*, i8** %l7
  %t291 = load i8*, i8** %l8
  %t292 = load i1, i1* %l9
  %t293 = load i1, i1* %l10
  %t294 = load i1, i1* %l11
  %t295 = load double, double* %l12
  %t296 = load double, double* %l13
  %t297 = load double, double* %l14
  %t298 = load double, double* %l15
  %t299 = load i8*, i8** %l16
  br i1 %t282, label %then21, label %else22
then21:
  %t300 = load i8*, i8** %l16
  %t301 = load i8*, i8** %l16
  %t302 = call i64 @sailfin_runtime_string_length(i8* %t301)
  %t303 = call i8* @sailfin_runtime_substring(i8* %t300, i64 5, i64 %t302)
  store i8* %t303, i8** %l19
  %t304 = load i8*, i8** %l19
  %t305 = call %NumberParseResult @parse_decimal_number(i8* %t304)
  store %NumberParseResult %t305, %NumberParseResult* %l20
  %t306 = load %NumberParseResult, %NumberParseResult* %l20
  %t307 = extractvalue %NumberParseResult %t306, 0
  %t308 = load i8*, i8** %l0
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t310 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t312 = load i8*, i8** %l4
  %t313 = load double, double* %l5
  %t314 = load i8*, i8** %l6
  %t315 = load i8*, i8** %l7
  %t316 = load i8*, i8** %l8
  %t317 = load i1, i1* %l9
  %t318 = load i1, i1* %l10
  %t319 = load i1, i1* %l11
  %t320 = load double, double* %l12
  %t321 = load double, double* %l13
  %t322 = load double, double* %l14
  %t323 = load double, double* %l15
  %t324 = load i8*, i8** %l16
  %t325 = load i8*, i8** %l19
  %t326 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t307, label %then24, label %else25
then24:
  store i1 1, i1* %l10
  %t327 = load %NumberParseResult, %NumberParseResult* %l20
  %t328 = extractvalue %NumberParseResult %t327, 1
  store double %t328, double* %l13
  %t329 = load i1, i1* %l10
  %t330 = load double, double* %l13
  br label %merge26
else25:
  %t331 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s332 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %s332, i8* %enum_name)
  %s334 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t335 = call i8* @sailfin_runtime_string_concat(i8* %t333, i8* %s334)
  %t336 = load i8*, i8** %l4
  %t337 = call i8* @sailfin_runtime_string_concat(i8* %t335, i8* %t336)
  %s338 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t339 = call i8* @sailfin_runtime_string_concat(i8* %t337, i8* %s338)
  %t340 = load i8*, i8** %l19
  %t341 = call i8* @sailfin_runtime_string_concat(i8* %t339, i8* %t340)
  %t342 = alloca [2 x i8], align 1
  %t343 = getelementptr [2 x i8], [2 x i8]* %t342, i32 0, i32 0
  store i8 96, i8* %t343
  %t344 = getelementptr [2 x i8], [2 x i8]* %t342, i32 0, i32 1
  store i8 0, i8* %t344
  %t345 = getelementptr [2 x i8], [2 x i8]* %t342, i32 0, i32 0
  %t346 = call i8* @sailfin_runtime_string_concat(i8* %t341, i8* %t345)
  %t347 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t331, i8* %t346)
  store { i8**, i64 }* %t347, { i8**, i64 }** %l1
  %t348 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t349 = phi i1 [ %t329, %then24 ], [ %t318, %else25 ]
  %t350 = phi double [ %t330, %then24 ], [ %t321, %else25 ]
  %t351 = phi { i8**, i64 }* [ %t309, %then24 ], [ %t348, %else25 ]
  store i1 %t349, i1* %l10
  store double %t350, double* %l13
  store { i8**, i64 }* %t351, { i8**, i64 }** %l1
  %t352 = load i1, i1* %l10
  %t353 = load double, double* %l13
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t355 = load i8*, i8** %l16
  %s356 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t357 = call i1 @starts_with(i8* %t355, i8* %s356)
  %t358 = load i8*, i8** %l0
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t360 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t362 = load i8*, i8** %l4
  %t363 = load double, double* %l5
  %t364 = load i8*, i8** %l6
  %t365 = load i8*, i8** %l7
  %t366 = load i8*, i8** %l8
  %t367 = load i1, i1* %l9
  %t368 = load i1, i1* %l10
  %t369 = load i1, i1* %l11
  %t370 = load double, double* %l12
  %t371 = load double, double* %l13
  %t372 = load double, double* %l14
  %t373 = load double, double* %l15
  %t374 = load i8*, i8** %l16
  br i1 %t357, label %then27, label %else28
then27:
  %t375 = load i8*, i8** %l16
  %t376 = load i8*, i8** %l16
  %t377 = call i64 @sailfin_runtime_string_length(i8* %t376)
  %t378 = call i8* @sailfin_runtime_substring(i8* %t375, i64 6, i64 %t377)
  store i8* %t378, i8** %l21
  %t379 = load i8*, i8** %l21
  %t380 = call %NumberParseResult @parse_decimal_number(i8* %t379)
  store %NumberParseResult %t380, %NumberParseResult* %l22
  %t381 = load %NumberParseResult, %NumberParseResult* %l22
  %t382 = extractvalue %NumberParseResult %t381, 0
  %t383 = load i8*, i8** %l0
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t385 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t387 = load i8*, i8** %l4
  %t388 = load double, double* %l5
  %t389 = load i8*, i8** %l6
  %t390 = load i8*, i8** %l7
  %t391 = load i8*, i8** %l8
  %t392 = load i1, i1* %l9
  %t393 = load i1, i1* %l10
  %t394 = load i1, i1* %l11
  %t395 = load double, double* %l12
  %t396 = load double, double* %l13
  %t397 = load double, double* %l14
  %t398 = load double, double* %l15
  %t399 = load i8*, i8** %l16
  %t400 = load i8*, i8** %l21
  %t401 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t382, label %then30, label %else31
then30:
  store i1 1, i1* %l11
  %t402 = load %NumberParseResult, %NumberParseResult* %l22
  %t403 = extractvalue %NumberParseResult %t402, 1
  store double %t403, double* %l14
  %t404 = load i1, i1* %l11
  %t405 = load double, double* %l14
  br label %merge32
else31:
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s407 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t408 = call i8* @sailfin_runtime_string_concat(i8* %s407, i8* %enum_name)
  %s409 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t410 = call i8* @sailfin_runtime_string_concat(i8* %t408, i8* %s409)
  %t411 = load i8*, i8** %l4
  %t412 = call i8* @sailfin_runtime_string_concat(i8* %t410, i8* %t411)
  %s413 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t414 = call i8* @sailfin_runtime_string_concat(i8* %t412, i8* %s413)
  %t415 = load i8*, i8** %l21
  %t416 = call i8* @sailfin_runtime_string_concat(i8* %t414, i8* %t415)
  %t417 = alloca [2 x i8], align 1
  %t418 = getelementptr [2 x i8], [2 x i8]* %t417, i32 0, i32 0
  store i8 96, i8* %t418
  %t419 = getelementptr [2 x i8], [2 x i8]* %t417, i32 0, i32 1
  store i8 0, i8* %t419
  %t420 = getelementptr [2 x i8], [2 x i8]* %t417, i32 0, i32 0
  %t421 = call i8* @sailfin_runtime_string_concat(i8* %t416, i8* %t420)
  %t422 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t406, i8* %t421)
  store { i8**, i64 }* %t422, { i8**, i64 }** %l1
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t424 = phi i1 [ %t404, %then30 ], [ %t394, %else31 ]
  %t425 = phi double [ %t405, %then30 ], [ %t397, %else31 ]
  %t426 = phi { i8**, i64 }* [ %t384, %then30 ], [ %t423, %else31 ]
  store i1 %t424, i1* %l11
  store double %t425, double* %l14
  store { i8**, i64 }* %t426, { i8**, i64 }** %l1
  %t427 = load i1, i1* %l11
  %t428 = load double, double* %l14
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s431 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t432 = call i8* @sailfin_runtime_string_concat(i8* %s431, i8* %enum_name)
  %s433 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t434 = call i8* @sailfin_runtime_string_concat(i8* %t432, i8* %s433)
  %t435 = load i8*, i8** %l4
  %t436 = call i8* @sailfin_runtime_string_concat(i8* %t434, i8* %t435)
  %s437 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t438 = call i8* @sailfin_runtime_string_concat(i8* %t436, i8* %s437)
  %t439 = load i8*, i8** %l16
  %t440 = call i8* @sailfin_runtime_string_concat(i8* %t438, i8* %t439)
  %t441 = alloca [2 x i8], align 1
  %t442 = getelementptr [2 x i8], [2 x i8]* %t441, i32 0, i32 0
  store i8 96, i8* %t442
  %t443 = getelementptr [2 x i8], [2 x i8]* %t441, i32 0, i32 1
  store i8 0, i8* %t443
  %t444 = getelementptr [2 x i8], [2 x i8]* %t441, i32 0, i32 0
  %t445 = call i8* @sailfin_runtime_string_concat(i8* %t440, i8* %t444)
  %t446 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t430, i8* %t445)
  store { i8**, i64 }* %t446, { i8**, i64 }** %l1
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t448 = phi i1 [ %t427, %merge32 ], [ %t369, %else28 ]
  %t449 = phi double [ %t428, %merge32 ], [ %t372, %else28 ]
  %t450 = phi { i8**, i64 }* [ %t429, %merge32 ], [ %t447, %else28 ]
  store i1 %t448, i1* %l11
  store double %t449, double* %l14
  store { i8**, i64 }* %t450, { i8**, i64 }** %l1
  %t451 = load i1, i1* %l11
  %t452 = load double, double* %l14
  %t453 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t454 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t455 = phi i1 [ %t352, %merge26 ], [ %t293, %merge29 ]
  %t456 = phi double [ %t353, %merge26 ], [ %t296, %merge29 ]
  %t457 = phi { i8**, i64 }* [ %t354, %merge26 ], [ %t453, %merge29 ]
  %t458 = phi i1 [ %t294, %merge26 ], [ %t451, %merge29 ]
  %t459 = phi double [ %t297, %merge26 ], [ %t452, %merge29 ]
  store i1 %t455, i1* %l10
  store double %t456, double* %l13
  store { i8**, i64 }* %t457, { i8**, i64 }** %l1
  store i1 %t458, i1* %l11
  store double %t459, double* %l14
  %t460 = load i1, i1* %l10
  %t461 = load double, double* %l13
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t463 = load i1, i1* %l11
  %t464 = load double, double* %l14
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t466 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t467 = phi i1 [ %t277, %merge20 ], [ %t217, %merge23 ]
  %t468 = phi double [ %t278, %merge20 ], [ %t220, %merge23 ]
  %t469 = phi { i8**, i64 }* [ %t279, %merge20 ], [ %t462, %merge23 ]
  %t470 = phi i1 [ %t218, %merge20 ], [ %t460, %merge23 ]
  %t471 = phi double [ %t221, %merge20 ], [ %t461, %merge23 ]
  %t472 = phi i1 [ %t219, %merge20 ], [ %t463, %merge23 ]
  %t473 = phi double [ %t222, %merge20 ], [ %t464, %merge23 ]
  store i1 %t467, i1* %l9
  store double %t468, double* %l12
  store { i8**, i64 }* %t469, { i8**, i64 }** %l1
  store i1 %t470, i1* %l10
  store double %t471, double* %l13
  store i1 %t472, i1* %l11
  store double %t473, double* %l14
  %t474 = load i1, i1* %l9
  %t475 = load double, double* %l12
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t477 = load i1, i1* %l10
  %t478 = load double, double* %l13
  %t479 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t480 = load i1, i1* %l11
  %t481 = load double, double* %l14
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t484 = phi i8* [ %t204, %then12 ], [ %t191, %merge17 ]
  %t485 = phi i1 [ %t192, %then12 ], [ %t474, %merge17 ]
  %t486 = phi double [ %t195, %then12 ], [ %t475, %merge17 ]
  %t487 = phi { i8**, i64 }* [ %t184, %then12 ], [ %t476, %merge17 ]
  %t488 = phi i1 [ %t193, %then12 ], [ %t477, %merge17 ]
  %t489 = phi double [ %t196, %then12 ], [ %t478, %merge17 ]
  %t490 = phi i1 [ %t194, %then12 ], [ %t480, %merge17 ]
  %t491 = phi double [ %t197, %then12 ], [ %t481, %merge17 ]
  store i8* %t484, i8** %l8
  store i1 %t485, i1* %l9
  store double %t486, double* %l12
  store { i8**, i64 }* %t487, { i8**, i64 }** %l1
  store i1 %t488, i1* %l10
  store double %t489, double* %l13
  store i1 %t490, i1* %l11
  store double %t491, double* %l14
  %t492 = load double, double* %l15
  %t493 = sitofp i64 1 to double
  %t494 = fadd double %t492, %t493
  store double %t494, double* %l15
  br label %loop.latch8
loop.latch8:
  %t495 = load i8*, i8** %l8
  %t496 = load i1, i1* %l9
  %t497 = load double, double* %l12
  %t498 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t499 = load i1, i1* %l10
  %t500 = load double, double* %l13
  %t501 = load i1, i1* %l11
  %t502 = load double, double* %l14
  %t503 = load double, double* %l15
  br label %loop.header6
afterloop9:
  %t513 = load i8*, i8** %l8
  %t514 = load i1, i1* %l9
  %t515 = load double, double* %l12
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t517 = load i1, i1* %l10
  %t518 = load double, double* %l13
  %t519 = load i1, i1* %l11
  %t520 = load double, double* %l14
  %t521 = load double, double* %l15
  %t522 = load i8*, i8** %l8
  %t523 = call i64 @sailfin_runtime_string_length(i8* %t522)
  %t524 = icmp eq i64 %t523, 0
  %t525 = load i8*, i8** %l0
  %t526 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t527 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t528 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t529 = load i8*, i8** %l4
  %t530 = load double, double* %l5
  %t531 = load i8*, i8** %l6
  %t532 = load i8*, i8** %l7
  %t533 = load i8*, i8** %l8
  %t534 = load i1, i1* %l9
  %t535 = load i1, i1* %l10
  %t536 = load i1, i1* %l11
  %t537 = load double, double* %l12
  %t538 = load double, double* %l13
  %t539 = load double, double* %l14
  %t540 = load double, double* %l15
  br i1 %t524, label %then33, label %merge34
then33:
  %t541 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s542 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t543 = call i8* @sailfin_runtime_string_concat(i8* %s542, i8* %enum_name)
  %s544 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t545 = call i8* @sailfin_runtime_string_concat(i8* %t543, i8* %s544)
  %t546 = load i8*, i8** %l4
  %t547 = call i8* @sailfin_runtime_string_concat(i8* %t545, i8* %t546)
  %s548 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1568429285, i32 0, i32 0
  %t549 = call i8* @sailfin_runtime_string_concat(i8* %t547, i8* %s548)
  %t550 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t541, i8* %t549)
  store { i8**, i64 }* %t550, { i8**, i64 }** %l1
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t552 = phi { i8**, i64 }* [ %t551, %then33 ], [ %t526, %afterloop9 ]
  store { i8**, i64 }* %t552, { i8**, i64 }** %l1
  %t553 = load i1, i1* %l9
  %t554 = xor i1 %t553, 1
  %t555 = load i8*, i8** %l0
  %t556 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t557 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t559 = load i8*, i8** %l4
  %t560 = load double, double* %l5
  %t561 = load i8*, i8** %l6
  %t562 = load i8*, i8** %l7
  %t563 = load i8*, i8** %l8
  %t564 = load i1, i1* %l9
  %t565 = load i1, i1* %l10
  %t566 = load i1, i1* %l11
  %t567 = load double, double* %l12
  %t568 = load double, double* %l13
  %t569 = load double, double* %l14
  %t570 = load double, double* %l15
  br i1 %t554, label %then35, label %merge36
then35:
  %t571 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s572 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t573 = call i8* @sailfin_runtime_string_concat(i8* %s572, i8* %enum_name)
  %s574 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t575 = call i8* @sailfin_runtime_string_concat(i8* %t573, i8* %s574)
  %t576 = load i8*, i8** %l4
  %t577 = call i8* @sailfin_runtime_string_concat(i8* %t575, i8* %t576)
  %s578 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t579 = call i8* @sailfin_runtime_string_concat(i8* %t577, i8* %s578)
  %t580 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t571, i8* %t579)
  store { i8**, i64 }* %t580, { i8**, i64 }** %l1
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t582 = phi { i8**, i64 }* [ %t581, %then35 ], [ %t556, %merge34 ]
  store { i8**, i64 }* %t582, { i8**, i64 }** %l1
  %t583 = load i1, i1* %l10
  %t584 = xor i1 %t583, 1
  %t585 = load i8*, i8** %l0
  %t586 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t587 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t588 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t589 = load i8*, i8** %l4
  %t590 = load double, double* %l5
  %t591 = load i8*, i8** %l6
  %t592 = load i8*, i8** %l7
  %t593 = load i8*, i8** %l8
  %t594 = load i1, i1* %l9
  %t595 = load i1, i1* %l10
  %t596 = load i1, i1* %l11
  %t597 = load double, double* %l12
  %t598 = load double, double* %l13
  %t599 = load double, double* %l14
  %t600 = load double, double* %l15
  br i1 %t584, label %then37, label %merge38
then37:
  %t601 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s602 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t603 = call i8* @sailfin_runtime_string_concat(i8* %s602, i8* %enum_name)
  %s604 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t605 = call i8* @sailfin_runtime_string_concat(i8* %t603, i8* %s604)
  %t606 = load i8*, i8** %l4
  %t607 = call i8* @sailfin_runtime_string_concat(i8* %t605, i8* %t606)
  %s608 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t609 = call i8* @sailfin_runtime_string_concat(i8* %t607, i8* %s608)
  %t610 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t601, i8* %t609)
  store { i8**, i64 }* %t610, { i8**, i64 }** %l1
  %t611 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t612 = phi { i8**, i64 }* [ %t611, %then37 ], [ %t586, %merge36 ]
  store { i8**, i64 }* %t612, { i8**, i64 }** %l1
  %t613 = load i1, i1* %l11
  %t614 = xor i1 %t613, 1
  %t615 = load i8*, i8** %l0
  %t616 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t617 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t618 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t619 = load i8*, i8** %l4
  %t620 = load double, double* %l5
  %t621 = load i8*, i8** %l6
  %t622 = load i8*, i8** %l7
  %t623 = load i8*, i8** %l8
  %t624 = load i1, i1* %l9
  %t625 = load i1, i1* %l10
  %t626 = load i1, i1* %l11
  %t627 = load double, double* %l12
  %t628 = load double, double* %l13
  %t629 = load double, double* %l14
  %t630 = load double, double* %l15
  br i1 %t614, label %then39, label %merge40
then39:
  %t631 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s632 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t633 = call i8* @sailfin_runtime_string_concat(i8* %s632, i8* %enum_name)
  %s634 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t635 = call i8* @sailfin_runtime_string_concat(i8* %t633, i8* %s634)
  %t636 = load i8*, i8** %l4
  %t637 = call i8* @sailfin_runtime_string_concat(i8* %t635, i8* %t636)
  %s638 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t639 = call i8* @sailfin_runtime_string_concat(i8* %t637, i8* %s638)
  %t640 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t631, i8* %t639)
  store { i8**, i64 }* %t640, { i8**, i64 }** %l1
  %t641 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t642 = phi { i8**, i64 }* [ %t641, %then39 ], [ %t616, %merge38 ]
  store { i8**, i64 }* %t642, { i8**, i64 }** %l1
  %t644 = load i8*, i8** %l8
  %t645 = call i64 @sailfin_runtime_string_length(i8* %t644)
  %t646 = icmp sgt i64 %t645, 0
  br label %logical_and_entry_643

logical_and_entry_643:
  br i1 %t646, label %logical_and_right_643, label %logical_and_merge_643

logical_and_right_643:
  %t648 = load i1, i1* %l9
  br label %logical_and_entry_647

logical_and_entry_647:
  br i1 %t648, label %logical_and_right_647, label %logical_and_merge_647

logical_and_right_647:
  %t650 = load i1, i1* %l10
  br label %logical_and_entry_649

logical_and_entry_649:
  br i1 %t650, label %logical_and_right_649, label %logical_and_merge_649

logical_and_right_649:
  %t652 = load i1, i1* %l11
  br label %logical_and_entry_651

logical_and_entry_651:
  br i1 %t652, label %logical_and_right_651, label %logical_and_merge_651

logical_and_right_651:
  %t653 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t654 = load { i8**, i64 }, { i8**, i64 }* %t653
  %t655 = extractvalue { i8**, i64 } %t654, 1
  %t656 = icmp eq i64 %t655, 0
  br label %logical_and_right_end_651

logical_and_right_end_651:
  br label %logical_and_merge_651

logical_and_merge_651:
  %t657 = phi i1 [ false, %logical_and_entry_651 ], [ %t656, %logical_and_right_end_651 ]
  br label %logical_and_right_end_649

logical_and_right_end_649:
  br label %logical_and_merge_649

logical_and_merge_649:
  %t658 = phi i1 [ false, %logical_and_entry_649 ], [ %t657, %logical_and_right_end_649 ]
  br label %logical_and_right_end_647

logical_and_right_end_647:
  br label %logical_and_merge_647

logical_and_merge_647:
  %t659 = phi i1 [ false, %logical_and_entry_647 ], [ %t658, %logical_and_right_end_647 ]
  br label %logical_and_right_end_643

logical_and_right_end_643:
  br label %logical_and_merge_643

logical_and_merge_643:
  %t660 = phi i1 [ false, %logical_and_entry_643 ], [ %t659, %logical_and_right_end_643 ]
  store i1 %t660, i1* %l23
  %t661 = load i8*, i8** %l7
  %t662 = insertvalue %NativeStructLayoutField undef, i8* %t661, 0
  %t663 = load i8*, i8** %l8
  %t664 = insertvalue %NativeStructLayoutField %t662, i8* %t663, 1
  %t665 = load double, double* %l12
  %t666 = insertvalue %NativeStructLayoutField %t664, double %t665, 2
  %t667 = load double, double* %l13
  %t668 = insertvalue %NativeStructLayoutField %t666, double %t667, 3
  %t669 = load double, double* %l14
  %t670 = insertvalue %NativeStructLayoutField %t668, double %t669, 4
  store %NativeStructLayoutField %t670, %NativeStructLayoutField* %l24
  %t671 = load i1, i1* %l23
  %t672 = insertvalue %EnumLayoutPayloadParse undef, i1 %t671, 0
  %t673 = load i8*, i8** %l6
  %t674 = insertvalue %EnumLayoutPayloadParse %t672, i8* %t673, 1
  %t675 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t676 = insertvalue %EnumLayoutPayloadParse %t674, %NativeStructLayoutField %t675, 2
  %t677 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t678 = insertvalue %EnumLayoutPayloadParse %t676, { i8**, i64 }* %t677, 3
  ret %EnumLayoutPayloadParse %t678
}

define %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca %BindingComponents
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064124065, i32 0, i32 0
  %t1 = call i8* @strip_prefix(i8* %line, i8* %s0)
  %t2 = call i8* @trim_text(i8* %t1)
  store i8* %t2, i8** %l0
  store i1 0, i1* %l1
  %t3 = load i8*, i8** %l0
  store i8* %t3, i8** %l2
  %t4 = load i8*, i8** %l2
  %s5 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t6 = call i1 @starts_with(i8* %t4, i8* %s5)
  %t7 = load i8*, i8** %l0
  %t8 = load i1, i1* %l1
  %t9 = load i8*, i8** %l2
  br i1 %t6, label %then0, label %merge1
then0:
  store i1 1, i1* %l1
  %t10 = load i8*, i8** %l2
  %s11 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t12 = call i8* @strip_prefix(i8* %t10, i8* %s11)
  %t13 = call i8* @trim_text(i8* %t12)
  store i8* %t13, i8** %l2
  %t14 = load i1, i1* %l1
  %t15 = load i8*, i8** %l2
  br label %merge1
merge1:
  %t16 = phi i1 [ %t14, %then0 ], [ %t8, %block.entry ]
  %t17 = phi i8* [ %t15, %then0 ], [ %t9, %block.entry ]
  store i1 %t16, i1* %l1
  store i8* %t17, i8** %l2
  %t18 = load i8*, i8** %l2
  %t19 = call %BindingComponents @parse_binding_components(i8* %t18)
  store %BindingComponents %t19, %BindingComponents* %l3
  %t20 = alloca %NativeInstruction
  %t21 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 0
  store i32 2, i32* %t21
  %t22 = load %BindingComponents, %BindingComponents* %l3
  %t23 = extractvalue %BindingComponents %t22, 0
  %t24 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t25 = bitcast [48 x i8]* %t24 to i8*
  %t26 = bitcast i8* %t25 to i8**
  store i8* %t23, i8** %t26
  %t27 = load i1, i1* %l1
  %t28 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t29 = bitcast [48 x i8]* %t28 to i8*
  %t30 = getelementptr inbounds i8, i8* %t29, i64 8
  %t31 = bitcast i8* %t30 to i1*
  store i1 %t27, i1* %t31
  %t32 = load %BindingComponents, %BindingComponents* %l3
  %t33 = extractvalue %BindingComponents %t32, 1
  %t34 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t35 = bitcast [48 x i8]* %t34 to i8*
  %t36 = getelementptr inbounds i8, i8* %t35, i64 16
  %t37 = bitcast i8* %t36 to i8**
  store i8* %t33, i8** %t37
  %t38 = load %BindingComponents, %BindingComponents* %l3
  %t39 = extractvalue %BindingComponents %t38, 2
  %t40 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t41 = bitcast [48 x i8]* %t40 to i8*
  %t42 = getelementptr inbounds i8, i8* %t41, i64 24
  %t43 = bitcast i8* %t42 to i8**
  store i8* %t39, i8** %t43
  %t44 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t45 = bitcast [48 x i8]* %t44 to i8*
  %t46 = getelementptr inbounds i8, i8* %t45, i64 32
  %t47 = bitcast i8* %t46 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t47
  %t48 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t20, i32 0, i32 1
  %t49 = bitcast [48 x i8]* %t48 to i8*
  %t50 = getelementptr inbounds i8, i8* %t49, i64 40
  %t51 = bitcast i8* %t50 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t51
  %t52 = load %NativeInstruction, %NativeInstruction* %t20
  ret %NativeInstruction %t52
}

define %BindingComponents @parse_binding_components(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8*
  %l4 = alloca i8*
  %l5 = alloca i8*
  %l6 = alloca double
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i8*
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = load i8*, i8** %l0
  %t3 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t40 = phi i8* [ %t2, %block.entry ], [ %t38, %loop.latch2 ]
  %t41 = phi double [ %t3, %block.entry ], [ %t39, %loop.latch2 ]
  store i8* %t40, i8** %l0
  store double %t41, double* %l1
  br label %loop.body1
loop.body1:
  %t4 = load double, double* %l1
  %t5 = call i64 @sailfin_runtime_string_length(i8* %text)
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
  %t13 = getelementptr i8, i8* %text, i64 %t12
  %t14 = load i8, i8* %t13
  store i8 %t14, i8* %l2
  %t16 = load i8, i8* %l2
  %t17 = icmp eq i8 %t16, 32
  br label %logical_or_entry_15

logical_or_entry_15:
  br i1 %t17, label %logical_or_merge_15, label %logical_or_right_15

logical_or_right_15:
  %t19 = load i8, i8* %l2
  %t20 = icmp eq i8 %t19, 58
  br label %logical_or_entry_18

logical_or_entry_18:
  br i1 %t20, label %logical_or_merge_18, label %logical_or_right_18

logical_or_right_18:
  %t21 = load i8, i8* %l2
  %t22 = icmp eq i8 %t21, 61
  br label %logical_or_right_end_18

logical_or_right_end_18:
  br label %logical_or_merge_18

logical_or_merge_18:
  %t23 = phi i1 [ true, %logical_or_entry_18 ], [ %t22, %logical_or_right_end_18 ]
  br label %logical_or_right_end_15

logical_or_right_end_15:
  br label %logical_or_merge_15

logical_or_merge_15:
  %t24 = phi i1 [ true, %logical_or_entry_15 ], [ %t23, %logical_or_right_end_15 ]
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = load i8, i8* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop3
merge7:
  %t28 = load i8*, i8** %l0
  %t29 = load i8, i8* %l2
  %t30 = alloca [2 x i8], align 1
  %t31 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 0
  store i8 %t29, i8* %t31
  %t32 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 1
  store i8 0, i8* %t32
  %t33 = getelementptr [2 x i8], [2 x i8]* %t30, i32 0, i32 0
  %t34 = call i8* @sailfin_runtime_string_concat(i8* %t28, i8* %t33)
  store i8* %t34, i8** %l0
  %t35 = load double, double* %l1
  %t36 = sitofp i64 1 to double
  %t37 = fadd double %t35, %t36
  store double %t37, double* %l1
  br label %loop.latch2
loop.latch2:
  %t38 = load i8*, i8** %l0
  %t39 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l0
  %t45 = call i8* @trim_text(i8* %t44)
  store i8* %t45, i8** %l0
  %s46 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s46, i8** %l3
  store i8* null, i8** %l4
  %t47 = load double, double* %l1
  %t48 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t49 = call double @llvm.round.f64(double %t47)
  %t50 = fptosi double %t49 to i64
  %t51 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t50, i64 %t48)
  %t52 = call i8* @trim_text(i8* %t51)
  store i8* %t52, i8** %l5
  %t53 = load i8*, i8** %l5
  %t54 = call i64 @sailfin_runtime_string_length(i8* %t53)
  %t55 = icmp sgt i64 %t54, 0
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l1
  %t58 = load i8*, i8** %l3
  %t59 = load i8*, i8** %l4
  %t60 = load i8*, i8** %l5
  br i1 %t55, label %then8, label %merge9
then8:
  %t61 = load i8*, i8** %l5
  %s62 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t63 = call i1 @starts_with(i8* %t61, i8* %s62)
  %t64 = load i8*, i8** %l0
  %t65 = load double, double* %l1
  %t66 = load i8*, i8** %l3
  %t67 = load i8*, i8** %l4
  %t68 = load i8*, i8** %l5
  br i1 %t63, label %then10, label %else11
then10:
  %t69 = load i8*, i8** %l5
  %s70 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t71 = call i8* @strip_prefix(i8* %t69, i8* %s70)
  %t72 = call i8* @trim_text(i8* %t71)
  store i8* %t72, i8** %l5
  %t73 = load i8*, i8** %l5
  %t74 = alloca [2 x i8], align 1
  %t75 = getelementptr [2 x i8], [2 x i8]* %t74, i32 0, i32 0
  store i8 61, i8* %t75
  %t76 = getelementptr [2 x i8], [2 x i8]* %t74, i32 0, i32 1
  store i8 0, i8* %t76
  %t77 = getelementptr [2 x i8], [2 x i8]* %t74, i32 0, i32 0
  %t78 = call double @index_of(i8* %t73, i8* %t77)
  store double %t78, double* %l6
  %t79 = load double, double* %l6
  %t80 = sitofp i64 0 to double
  %t81 = fcmp oge double %t79, %t80
  %t82 = load i8*, i8** %l0
  %t83 = load double, double* %l1
  %t84 = load i8*, i8** %l3
  %t85 = load i8*, i8** %l4
  %t86 = load i8*, i8** %l5
  %t87 = load double, double* %l6
  br i1 %t81, label %then13, label %else14
then13:
  %t88 = load i8*, i8** %l5
  %t89 = load double, double* %l6
  %t90 = call double @llvm.round.f64(double %t89)
  %t91 = fptosi double %t90 to i64
  %t92 = call i8* @sailfin_runtime_substring(i8* %t88, i64 0, i64 %t91)
  %t93 = call i8* @trim_text(i8* %t92)
  store i8* %t93, i8** %l3
  %t94 = load i8*, i8** %l5
  %t95 = load double, double* %l6
  %t96 = sitofp i64 1 to double
  %t97 = fadd double %t95, %t96
  %t98 = load i8*, i8** %l5
  %t99 = call i64 @sailfin_runtime_string_length(i8* %t98)
  %t100 = call double @llvm.round.f64(double %t97)
  %t101 = fptosi double %t100 to i64
  %t102 = call i8* @sailfin_runtime_substring(i8* %t94, i64 %t101, i64 %t99)
  %t103 = call i8* @trim_text(i8* %t102)
  store i8* %t103, i8** %l7
  %t104 = load i8*, i8** %l7
  %t105 = call i64 @sailfin_runtime_string_length(i8* %t104)
  %t106 = icmp sgt i64 %t105, 0
  %t107 = load i8*, i8** %l0
  %t108 = load double, double* %l1
  %t109 = load i8*, i8** %l3
  %t110 = load i8*, i8** %l4
  %t111 = load i8*, i8** %l5
  %t112 = load double, double* %l6
  %t113 = load i8*, i8** %l7
  br i1 %t106, label %then16, label %merge17
then16:
  %t114 = load i8*, i8** %l7
  store i8* %t114, i8** %l4
  %t115 = load i8*, i8** %l4
  br label %merge17
merge17:
  %t116 = phi i8* [ %t115, %then16 ], [ %t110, %then13 ]
  store i8* %t116, i8** %l4
  %t117 = load i8*, i8** %l3
  %t118 = load i8*, i8** %l4
  br label %merge15
else14:
  %t119 = load i8*, i8** %l5
  %t120 = call i8* @trim_text(i8* %t119)
  store i8* %t120, i8** %l3
  %t121 = load i8*, i8** %l3
  br label %merge15
merge15:
  %t122 = phi i8* [ %t117, %merge17 ], [ %t121, %else14 ]
  %t123 = phi i8* [ %t118, %merge17 ], [ %t85, %else14 ]
  store i8* %t122, i8** %l3
  store i8* %t123, i8** %l4
  %t124 = load i8*, i8** %l5
  %t125 = load i8*, i8** %l3
  %t126 = load i8*, i8** %l4
  %t127 = load i8*, i8** %l3
  br label %merge12
else11:
  %t128 = load i8*, i8** %l5
  %t129 = alloca [2 x i8], align 1
  %t130 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  store i8 58, i8* %t130
  %t131 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 1
  store i8 0, i8* %t131
  %t132 = getelementptr [2 x i8], [2 x i8]* %t129, i32 0, i32 0
  %t133 = call i1 @starts_with(i8* %t128, i8* %t132)
  %t134 = load i8*, i8** %l0
  %t135 = load double, double* %l1
  %t136 = load i8*, i8** %l3
  %t137 = load i8*, i8** %l4
  %t138 = load i8*, i8** %l5
  br i1 %t133, label %then18, label %else19
then18:
  %t139 = load i8*, i8** %l5
  %t140 = alloca [2 x i8], align 1
  %t141 = getelementptr [2 x i8], [2 x i8]* %t140, i32 0, i32 0
  store i8 58, i8* %t141
  %t142 = getelementptr [2 x i8], [2 x i8]* %t140, i32 0, i32 1
  store i8 0, i8* %t142
  %t143 = getelementptr [2 x i8], [2 x i8]* %t140, i32 0, i32 0
  %t144 = call i8* @strip_prefix(i8* %t139, i8* %t143)
  %t145 = call i8* @trim_text(i8* %t144)
  store i8* %t145, i8** %l5
  %t146 = load i8*, i8** %l5
  %t147 = alloca [2 x i8], align 1
  %t148 = getelementptr [2 x i8], [2 x i8]* %t147, i32 0, i32 0
  store i8 61, i8* %t148
  %t149 = getelementptr [2 x i8], [2 x i8]* %t147, i32 0, i32 1
  store i8 0, i8* %t149
  %t150 = getelementptr [2 x i8], [2 x i8]* %t147, i32 0, i32 0
  %t151 = call double @index_of(i8* %t146, i8* %t150)
  store double %t151, double* %l8
  %t152 = load double, double* %l8
  %t153 = sitofp i64 0 to double
  %t154 = fcmp oge double %t152, %t153
  %t155 = load i8*, i8** %l0
  %t156 = load double, double* %l1
  %t157 = load i8*, i8** %l3
  %t158 = load i8*, i8** %l4
  %t159 = load i8*, i8** %l5
  %t160 = load double, double* %l8
  br i1 %t154, label %then21, label %else22
then21:
  %t161 = load i8*, i8** %l5
  %t162 = load double, double* %l8
  %t163 = call double @llvm.round.f64(double %t162)
  %t164 = fptosi double %t163 to i64
  %t165 = call i8* @sailfin_runtime_substring(i8* %t161, i64 0, i64 %t164)
  %t166 = call i8* @trim_text(i8* %t165)
  store i8* %t166, i8** %l3
  %t167 = load i8*, i8** %l5
  %t168 = load double, double* %l8
  %t169 = sitofp i64 1 to double
  %t170 = fadd double %t168, %t169
  %t171 = load i8*, i8** %l5
  %t172 = call i64 @sailfin_runtime_string_length(i8* %t171)
  %t173 = call double @llvm.round.f64(double %t170)
  %t174 = fptosi double %t173 to i64
  %t175 = call i8* @sailfin_runtime_substring(i8* %t167, i64 %t174, i64 %t172)
  %t176 = call i8* @trim_text(i8* %t175)
  store i8* %t176, i8** %l9
  %t177 = load i8*, i8** %l9
  %t178 = call i64 @sailfin_runtime_string_length(i8* %t177)
  %t179 = icmp sgt i64 %t178, 0
  %t180 = load i8*, i8** %l0
  %t181 = load double, double* %l1
  %t182 = load i8*, i8** %l3
  %t183 = load i8*, i8** %l4
  %t184 = load i8*, i8** %l5
  %t185 = load double, double* %l8
  %t186 = load i8*, i8** %l9
  br i1 %t179, label %then24, label %merge25
then24:
  %t187 = load i8*, i8** %l9
  store i8* %t187, i8** %l4
  %t188 = load i8*, i8** %l4
  br label %merge25
merge25:
  %t189 = phi i8* [ %t188, %then24 ], [ %t183, %then21 ]
  store i8* %t189, i8** %l4
  %t190 = load i8*, i8** %l3
  %t191 = load i8*, i8** %l4
  br label %merge23
else22:
  %t192 = load i8*, i8** %l5
  %t193 = call i8* @trim_text(i8* %t192)
  store i8* %t193, i8** %l3
  %t194 = load i8*, i8** %l3
  br label %merge23
merge23:
  %t195 = phi i8* [ %t190, %merge25 ], [ %t194, %else22 ]
  %t196 = phi i8* [ %t191, %merge25 ], [ %t158, %else22 ]
  store i8* %t195, i8** %l3
  store i8* %t196, i8** %l4
  %t197 = load i8*, i8** %l5
  %t198 = load i8*, i8** %l3
  %t199 = load i8*, i8** %l4
  %t200 = load i8*, i8** %l3
  br label %merge20
else19:
  %t201 = load i8*, i8** %l5
  %t202 = alloca [2 x i8], align 1
  %t203 = getelementptr [2 x i8], [2 x i8]* %t202, i32 0, i32 0
  store i8 61, i8* %t203
  %t204 = getelementptr [2 x i8], [2 x i8]* %t202, i32 0, i32 1
  store i8 0, i8* %t204
  %t205 = getelementptr [2 x i8], [2 x i8]* %t202, i32 0, i32 0
  %t206 = call i1 @starts_with(i8* %t201, i8* %t205)
  %t207 = load i8*, i8** %l0
  %t208 = load double, double* %l1
  %t209 = load i8*, i8** %l3
  %t210 = load i8*, i8** %l4
  %t211 = load i8*, i8** %l5
  br i1 %t206, label %then26, label %else27
then26:
  %t212 = load i8*, i8** %l5
  %t213 = alloca [2 x i8], align 1
  %t214 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  store i8 61, i8* %t214
  %t215 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 1
  store i8 0, i8* %t215
  %t216 = getelementptr [2 x i8], [2 x i8]* %t213, i32 0, i32 0
  %t217 = call i8* @strip_prefix(i8* %t212, i8* %t216)
  %t218 = call i8* @trim_text(i8* %t217)
  store i8* %t218, i8** %l10
  %t219 = load i8*, i8** %l10
  %t220 = call i64 @sailfin_runtime_string_length(i8* %t219)
  %t221 = icmp sgt i64 %t220, 0
  %t222 = load i8*, i8** %l0
  %t223 = load double, double* %l1
  %t224 = load i8*, i8** %l3
  %t225 = load i8*, i8** %l4
  %t226 = load i8*, i8** %l5
  %t227 = load i8*, i8** %l10
  br i1 %t221, label %then29, label %merge30
then29:
  %t228 = load i8*, i8** %l10
  store i8* %t228, i8** %l4
  %t229 = load i8*, i8** %l4
  br label %merge30
merge30:
  %t230 = phi i8* [ %t229, %then29 ], [ %t225, %then26 ]
  store i8* %t230, i8** %l4
  %t231 = load i8*, i8** %l4
  br label %merge28
else27:
  %t232 = load i8*, i8** %l5
  store i8* %t232, i8** %l4
  %t233 = load i8*, i8** %l4
  br label %merge28
merge28:
  %t234 = phi i8* [ %t231, %merge30 ], [ %t233, %else27 ]
  store i8* %t234, i8** %l4
  %t235 = load i8*, i8** %l4
  %t236 = load i8*, i8** %l4
  br label %merge20
merge20:
  %t237 = phi i8* [ %t197, %merge23 ], [ %t138, %merge28 ]
  %t238 = phi i8* [ %t198, %merge23 ], [ %t136, %merge28 ]
  %t239 = phi i8* [ %t199, %merge23 ], [ %t235, %merge28 ]
  store i8* %t237, i8** %l5
  store i8* %t238, i8** %l3
  store i8* %t239, i8** %l4
  %t240 = load i8*, i8** %l5
  %t241 = load i8*, i8** %l3
  %t242 = load i8*, i8** %l4
  %t243 = load i8*, i8** %l3
  %t244 = load i8*, i8** %l4
  %t245 = load i8*, i8** %l4
  br label %merge12
merge12:
  %t246 = phi i8* [ %t124, %merge15 ], [ %t240, %merge20 ]
  %t247 = phi i8* [ %t125, %merge15 ], [ %t241, %merge20 ]
  %t248 = phi i8* [ %t126, %merge15 ], [ %t242, %merge20 ]
  store i8* %t246, i8** %l5
  store i8* %t247, i8** %l3
  store i8* %t248, i8** %l4
  %t249 = load i8*, i8** %l5
  %t250 = load i8*, i8** %l3
  %t251 = load i8*, i8** %l4
  %t252 = load i8*, i8** %l3
  %t253 = load i8*, i8** %l5
  %t254 = load i8*, i8** %l3
  %t255 = load i8*, i8** %l4
  %t256 = load i8*, i8** %l3
  %t257 = load i8*, i8** %l4
  %t258 = load i8*, i8** %l4
  br label %merge9
merge9:
  %t259 = phi i8* [ %t249, %merge12 ], [ %t60, %afterloop3 ]
  %t260 = phi i8* [ %t250, %merge12 ], [ %t58, %afterloop3 ]
  %t261 = phi i8* [ %t251, %merge12 ], [ %t59, %afterloop3 ]
  %t262 = phi i8* [ %t252, %merge12 ], [ %t58, %afterloop3 ]
  %t263 = phi i8* [ %t253, %merge12 ], [ %t60, %afterloop3 ]
  %t264 = phi i8* [ %t254, %merge12 ], [ %t58, %afterloop3 ]
  %t265 = phi i8* [ %t255, %merge12 ], [ %t59, %afterloop3 ]
  %t266 = phi i8* [ %t256, %merge12 ], [ %t58, %afterloop3 ]
  %t267 = phi i8* [ %t257, %merge12 ], [ %t59, %afterloop3 ]
  %t268 = phi i8* [ %t258, %merge12 ], [ %t59, %afterloop3 ]
  store i8* %t259, i8** %l5
  store i8* %t260, i8** %l3
  store i8* %t261, i8** %l4
  store i8* %t262, i8** %l3
  store i8* %t263, i8** %l5
  store i8* %t264, i8** %l3
  store i8* %t265, i8** %l4
  store i8* %t266, i8** %l3
  store i8* %t267, i8** %l4
  store i8* %t268, i8** %l4
  %t269 = load i8*, i8** %l0
  %t270 = insertvalue %BindingComponents undef, i8* %t269, 0
  %t271 = load i8*, i8** %l3
  %t272 = insertvalue %BindingComponents %t270, i8* %t271, 1
  %t273 = load i8*, i8** %l4
  %t274 = insertvalue %BindingComponents %t272, i8* %t273, 2
  ret %BindingComponents %t274
}

define i8* @parse_function_name(i8* %header) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = call i8* @trim_text(i8* %header)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t3 = call i1 @starts_with(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = load i8*, i8** %l0
  %s6 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1134498859, i32 0, i32 0
  %t7 = call i8* @strip_prefix(i8* %t5, i8* %s6)
  %t8 = call i8* @trim_text(i8* %t7)
  store i8* %t8, i8** %l0
  %t9 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t10 = phi i8* [ %t9, %then0 ], [ %t4, %block.entry ]
  store i8* %t10, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = alloca [2 x i8], align 1
  %t13 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  store i8 40, i8* %t13
  %t14 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 1
  store i8 0, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t12, i32 0, i32 0
  %t16 = call double @index_of(i8* %t11, i8* %t15)
  store double %t16, double* %l1
  %t17 = load i8*, i8** %l0
  store i8* %t17, i8** %l2
  %t18 = load double, double* %l1
  %t19 = sitofp i64 0 to double
  %t20 = fcmp oge double %t18, %t19
  %t21 = load i8*, i8** %l0
  %t22 = load double, double* %l1
  %t23 = load i8*, i8** %l2
  br i1 %t20, label %then2, label %merge3
then2:
  %t24 = load i8*, i8** %l0
  %t25 = load double, double* %l1
  %t26 = call double @llvm.round.f64(double %t25)
  %t27 = fptosi double %t26 to i64
  %t28 = call i8* @sailfin_runtime_substring(i8* %t24, i64 0, i64 %t27)
  %t29 = call i8* @trim_text(i8* %t28)
  store i8* %t29, i8** %l2
  %t30 = load i8*, i8** %l2
  br label %merge3
merge3:
  %t31 = phi i8* [ %t30, %then2 ], [ %t23, %merge1 ]
  store i8* %t31, i8** %l2
  %t32 = load i8*, i8** %l2
  %t33 = alloca [2 x i8], align 1
  %t34 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  store i8 46, i8* %t34
  %t35 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 1
  store i8 0, i8* %t35
  %t36 = getelementptr [2 x i8], [2 x i8]* %t33, i32 0, i32 0
  %t37 = call double @last_index_of(i8* %t32, i8* %t36)
  store double %t37, double* %l3
  %t38 = load double, double* %l3
  %t39 = sitofp i64 0 to double
  %t40 = fcmp oge double %t38, %t39
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l3
  br i1 %t40, label %then4, label %merge5
then4:
  %t45 = load i8*, i8** %l2
  %t46 = load double, double* %l3
  %t47 = sitofp i64 1 to double
  %t48 = fadd double %t46, %t47
  %t49 = load i8*, i8** %l2
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = call double @llvm.round.f64(double %t48)
  %t52 = fptosi double %t51 to i64
  %t53 = call i8* @sailfin_runtime_substring(i8* %t45, i64 %t52, i64 %t50)
  %t54 = call i8* @trim_text(i8* %t53)
  store i8* %t54, i8** %l2
  %t55 = load i8*, i8** %l2
  br label %merge5
merge5:
  %t56 = phi i8* [ %t55, %then4 ], [ %t43, %merge3 ]
  store i8* %t56, i8** %l2
  %t57 = load i8*, i8** %l2
  %t58 = call i8* @strip_generics(i8* %t57)
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  ret i8* %t58
}

define %NativeParameter* @parse_parameter_entry(i8* %body, %NativeSourceSpan* %span) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca double
  %l9 = alloca i8*
  %l10 = alloca i8*
  %t0 = call i8* @trim_text(i8* %body)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = bitcast i8* null to %NativeParameter*
  ret %NativeParameter* %t5
merge1:
  store i1 0, i1* %l1
  %t6 = load i8*, i8** %l0
  %s7 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t8 = call i1 @starts_with(i8* %t6, i8* %s7)
  %t9 = load i8*, i8** %l0
  %t10 = load i1, i1* %l1
  br i1 %t8, label %then2, label %merge3
then2:
  store i1 1, i1* %l1
  %t11 = load i8*, i8** %l0
  %s12 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t13 = call i8* @strip_prefix(i8* %t11, i8* %s12)
  %t14 = call i8* @trim_text(i8* %t13)
  store i8* %t14, i8** %l0
  %t15 = load i1, i1* %l1
  %t16 = load i8*, i8** %l0
  br label %merge3
merge3:
  %t17 = phi i1 [ %t15, %then2 ], [ %t10, %merge1 ]
  %t18 = phi i8* [ %t16, %then2 ], [ %t9, %merge1 ]
  store i1 %t17, i1* %l1
  store i8* %t18, i8** %l0
  %s19 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s19, i8** %l2
  %t20 = sitofp i64 0 to double
  store double %t20, double* %l3
  %t21 = load i8*, i8** %l0
  %t22 = load i1, i1* %l1
  %t23 = load i8*, i8** %l2
  %t24 = load double, double* %l3
  br label %loop.header4
loop.header4:
  %t67 = phi i8* [ %t23, %merge3 ], [ %t65, %loop.latch6 ]
  %t68 = phi double [ %t24, %merge3 ], [ %t66, %loop.latch6 ]
  store i8* %t67, i8** %l2
  store double %t68, double* %l3
  br label %loop.body5
loop.body5:
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t25, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load i1, i1* %l1
  %t32 = load i8*, i8** %l2
  %t33 = load double, double* %l3
  br i1 %t29, label %then8, label %merge9
then8:
  br label %afterloop7
merge9:
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l3
  %t36 = call double @llvm.round.f64(double %t35)
  %t37 = fptosi double %t36 to i64
  %t38 = getelementptr i8, i8* %t34, i64 %t37
  %t39 = load i8, i8* %t38
  store i8 %t39, i8* %l4
  %t41 = load i8, i8* %l4
  %t42 = icmp eq i8 %t41, 32
  br label %logical_or_entry_40

logical_or_entry_40:
  br i1 %t42, label %logical_or_merge_40, label %logical_or_right_40

logical_or_right_40:
  %t44 = load i8, i8* %l4
  %t45 = icmp eq i8 %t44, 45
  br label %logical_or_entry_43

logical_or_entry_43:
  br i1 %t45, label %logical_or_merge_43, label %logical_or_right_43

logical_or_right_43:
  %t46 = load i8, i8* %l4
  %t47 = icmp eq i8 %t46, 61
  br label %logical_or_right_end_43

logical_or_right_end_43:
  br label %logical_or_merge_43

logical_or_merge_43:
  %t48 = phi i1 [ true, %logical_or_entry_43 ], [ %t47, %logical_or_right_end_43 ]
  br label %logical_or_right_end_40

logical_or_right_end_40:
  br label %logical_or_merge_40

logical_or_merge_40:
  %t49 = phi i1 [ true, %logical_or_entry_40 ], [ %t48, %logical_or_right_end_40 ]
  %t50 = load i8*, i8** %l0
  %t51 = load i1, i1* %l1
  %t52 = load i8*, i8** %l2
  %t53 = load double, double* %l3
  %t54 = load i8, i8* %l4
  br i1 %t49, label %then10, label %merge11
then10:
  br label %afterloop7
merge11:
  %t55 = load i8*, i8** %l2
  %t56 = load i8, i8* %l4
  %t57 = alloca [2 x i8], align 1
  %t58 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  store i8 %t56, i8* %t58
  %t59 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 1
  store i8 0, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t57, i32 0, i32 0
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t60)
  store i8* %t61, i8** %l2
  %t62 = load double, double* %l3
  %t63 = sitofp i64 1 to double
  %t64 = fadd double %t62, %t63
  store double %t64, double* %l3
  br label %loop.latch6
loop.latch6:
  %t65 = load i8*, i8** %l2
  %t66 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t69 = load i8*, i8** %l2
  %t70 = load double, double* %l3
  %t71 = load i8*, i8** %l2
  %t72 = call i8* @trim_text(i8* %t71)
  store i8* %t72, i8** %l2
  %t73 = load i8*, i8** %l2
  %t74 = call i64 @sailfin_runtime_string_length(i8* %t73)
  %t75 = icmp eq i64 %t74, 0
  %t76 = load i8*, i8** %l0
  %t77 = load i1, i1* %l1
  %t78 = load i8*, i8** %l2
  %t79 = load double, double* %l3
  br i1 %t75, label %then12, label %merge13
then12:
  %t80 = bitcast i8* null to %NativeParameter*
  ret %NativeParameter* %t80
merge13:
  %s81 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s81, i8** %l5
  store i8* null, i8** %l6
  %t82 = load i8*, i8** %l0
  %t83 = load double, double* %l3
  %t84 = load i8*, i8** %l0
  %t85 = call i64 @sailfin_runtime_string_length(i8* %t84)
  %t86 = call double @llvm.round.f64(double %t83)
  %t87 = fptosi double %t86 to i64
  %t88 = call i8* @sailfin_runtime_substring(i8* %t82, i64 %t87, i64 %t85)
  %t89 = call i8* @trim_text(i8* %t88)
  store i8* %t89, i8** %l7
  %t90 = load i8*, i8** %l7
  %t91 = call i64 @sailfin_runtime_string_length(i8* %t90)
  %t92 = icmp sgt i64 %t91, 0
  %t93 = load i8*, i8** %l0
  %t94 = load i1, i1* %l1
  %t95 = load i8*, i8** %l2
  %t96 = load double, double* %l3
  %t97 = load i8*, i8** %l5
  %t98 = load i8*, i8** %l6
  %t99 = load i8*, i8** %l7
  br i1 %t92, label %then14, label %merge15
then14:
  %t100 = load i8*, i8** %l7
  %s101 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t102 = call i1 @starts_with(i8* %t100, i8* %s101)
  %t103 = load i8*, i8** %l0
  %t104 = load i1, i1* %l1
  %t105 = load i8*, i8** %l2
  %t106 = load double, double* %l3
  %t107 = load i8*, i8** %l5
  %t108 = load i8*, i8** %l6
  %t109 = load i8*, i8** %l7
  br i1 %t102, label %then16, label %else17
then16:
  %t110 = load i8*, i8** %l7
  %s111 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t112 = call i8* @strip_prefix(i8* %t110, i8* %s111)
  %t113 = call i8* @trim_text(i8* %t112)
  store i8* %t113, i8** %l7
  %t114 = load i8*, i8** %l7
  %t115 = alloca [2 x i8], align 1
  %t116 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  store i8 61, i8* %t116
  %t117 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 1
  store i8 0, i8* %t117
  %t118 = getelementptr [2 x i8], [2 x i8]* %t115, i32 0, i32 0
  %t119 = call double @index_of(i8* %t114, i8* %t118)
  store double %t119, double* %l8
  %t120 = load double, double* %l8
  %t121 = sitofp i64 0 to double
  %t122 = fcmp oge double %t120, %t121
  %t123 = load i8*, i8** %l0
  %t124 = load i1, i1* %l1
  %t125 = load i8*, i8** %l2
  %t126 = load double, double* %l3
  %t127 = load i8*, i8** %l5
  %t128 = load i8*, i8** %l6
  %t129 = load i8*, i8** %l7
  %t130 = load double, double* %l8
  br i1 %t122, label %then19, label %else20
then19:
  %t131 = load i8*, i8** %l7
  %t132 = load double, double* %l8
  %t133 = call double @llvm.round.f64(double %t132)
  %t134 = fptosi double %t133 to i64
  %t135 = call i8* @sailfin_runtime_substring(i8* %t131, i64 0, i64 %t134)
  %t136 = call i8* @trim_text(i8* %t135)
  store i8* %t136, i8** %l5
  %t137 = load i8*, i8** %l7
  %t138 = load double, double* %l8
  %t139 = sitofp i64 1 to double
  %t140 = fadd double %t138, %t139
  %t141 = load i8*, i8** %l7
  %t142 = call i64 @sailfin_runtime_string_length(i8* %t141)
  %t143 = call double @llvm.round.f64(double %t140)
  %t144 = fptosi double %t143 to i64
  %t145 = call i8* @sailfin_runtime_substring(i8* %t137, i64 %t144, i64 %t142)
  %t146 = call i8* @trim_text(i8* %t145)
  store i8* %t146, i8** %l9
  %t147 = load i8*, i8** %l9
  %t148 = call i64 @sailfin_runtime_string_length(i8* %t147)
  %t149 = icmp sgt i64 %t148, 0
  %t150 = load i8*, i8** %l0
  %t151 = load i1, i1* %l1
  %t152 = load i8*, i8** %l2
  %t153 = load double, double* %l3
  %t154 = load i8*, i8** %l5
  %t155 = load i8*, i8** %l6
  %t156 = load i8*, i8** %l7
  %t157 = load double, double* %l8
  %t158 = load i8*, i8** %l9
  br i1 %t149, label %then22, label %merge23
then22:
  %t159 = load i8*, i8** %l9
  store i8* %t159, i8** %l6
  %t160 = load i8*, i8** %l6
  br label %merge23
merge23:
  %t161 = phi i8* [ %t160, %then22 ], [ %t155, %then19 ]
  store i8* %t161, i8** %l6
  %t162 = load i8*, i8** %l5
  %t163 = load i8*, i8** %l6
  br label %merge21
else20:
  %t164 = load i8*, i8** %l7
  %t165 = call i8* @trim_text(i8* %t164)
  store i8* %t165, i8** %l5
  %t166 = load i8*, i8** %l5
  br label %merge21
merge21:
  %t167 = phi i8* [ %t162, %merge23 ], [ %t166, %else20 ]
  %t168 = phi i8* [ %t163, %merge23 ], [ %t128, %else20 ]
  store i8* %t167, i8** %l5
  store i8* %t168, i8** %l6
  %t169 = load i8*, i8** %l7
  %t170 = load i8*, i8** %l5
  %t171 = load i8*, i8** %l6
  %t172 = load i8*, i8** %l5
  br label %merge18
else17:
  %t173 = load i8*, i8** %l7
  %t174 = alloca [2 x i8], align 1
  %t175 = getelementptr [2 x i8], [2 x i8]* %t174, i32 0, i32 0
  store i8 61, i8* %t175
  %t176 = getelementptr [2 x i8], [2 x i8]* %t174, i32 0, i32 1
  store i8 0, i8* %t176
  %t177 = getelementptr [2 x i8], [2 x i8]* %t174, i32 0, i32 0
  %t178 = call i1 @starts_with(i8* %t173, i8* %t177)
  %t179 = load i8*, i8** %l0
  %t180 = load i1, i1* %l1
  %t181 = load i8*, i8** %l2
  %t182 = load double, double* %l3
  %t183 = load i8*, i8** %l5
  %t184 = load i8*, i8** %l6
  %t185 = load i8*, i8** %l7
  br i1 %t178, label %then24, label %merge25
then24:
  %t186 = load i8*, i8** %l7
  %t187 = alloca [2 x i8], align 1
  %t188 = getelementptr [2 x i8], [2 x i8]* %t187, i32 0, i32 0
  store i8 61, i8* %t188
  %t189 = getelementptr [2 x i8], [2 x i8]* %t187, i32 0, i32 1
  store i8 0, i8* %t189
  %t190 = getelementptr [2 x i8], [2 x i8]* %t187, i32 0, i32 0
  %t191 = call i8* @strip_prefix(i8* %t186, i8* %t190)
  %t192 = call i8* @trim_text(i8* %t191)
  store i8* %t192, i8** %l10
  %t193 = load i8*, i8** %l10
  %t194 = call i64 @sailfin_runtime_string_length(i8* %t193)
  %t195 = icmp sgt i64 %t194, 0
  %t196 = load i8*, i8** %l0
  %t197 = load i1, i1* %l1
  %t198 = load i8*, i8** %l2
  %t199 = load double, double* %l3
  %t200 = load i8*, i8** %l5
  %t201 = load i8*, i8** %l6
  %t202 = load i8*, i8** %l7
  %t203 = load i8*, i8** %l10
  br i1 %t195, label %then26, label %merge27
then26:
  %t204 = load i8*, i8** %l10
  store i8* %t204, i8** %l6
  %t205 = load i8*, i8** %l6
  br label %merge27
merge27:
  %t206 = phi i8* [ %t205, %then26 ], [ %t201, %then24 ]
  store i8* %t206, i8** %l6
  %t207 = load i8*, i8** %l6
  br label %merge25
merge25:
  %t208 = phi i8* [ %t207, %merge27 ], [ %t184, %else17 ]
  store i8* %t208, i8** %l6
  %t209 = load i8*, i8** %l6
  br label %merge18
merge18:
  %t210 = phi i8* [ %t169, %merge21 ], [ %t109, %merge25 ]
  %t211 = phi i8* [ %t170, %merge21 ], [ %t107, %merge25 ]
  %t212 = phi i8* [ %t171, %merge21 ], [ %t209, %merge25 ]
  store i8* %t210, i8** %l7
  store i8* %t211, i8** %l5
  store i8* %t212, i8** %l6
  %t213 = load i8*, i8** %l7
  %t214 = load i8*, i8** %l5
  %t215 = load i8*, i8** %l6
  %t216 = load i8*, i8** %l5
  %t217 = load i8*, i8** %l6
  br label %merge15
merge15:
  %t218 = phi i8* [ %t213, %merge18 ], [ %t99, %merge13 ]
  %t219 = phi i8* [ %t214, %merge18 ], [ %t97, %merge13 ]
  %t220 = phi i8* [ %t215, %merge18 ], [ %t98, %merge13 ]
  %t221 = phi i8* [ %t216, %merge18 ], [ %t97, %merge13 ]
  %t222 = phi i8* [ %t217, %merge18 ], [ %t98, %merge13 ]
  store i8* %t218, i8** %l7
  store i8* %t219, i8** %l5
  store i8* %t220, i8** %l6
  store i8* %t221, i8** %l5
  store i8* %t222, i8** %l6
  %t223 = load i8*, i8** %l2
  %t224 = insertvalue %NativeParameter undef, i8* %t223, 0
  %t225 = load i8*, i8** %l5
  %t226 = insertvalue %NativeParameter %t224, i8* %t225, 1
  %t227 = load i1, i1* %l1
  %t228 = insertvalue %NativeParameter %t226, i1 %t227, 2
  %t229 = load i8*, i8** %l6
  %t230 = insertvalue %NativeParameter %t228, i8* %t229, 3
  %t231 = insertvalue %NativeParameter %t230, %NativeSourceSpan* %span, 4
  %t232 = alloca %NativeParameter
  store %NativeParameter %t231, %NativeParameter* %t232
  ret %NativeParameter* %t232
}

define i1 @line_looks_like_parameter_entry(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
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
  %t6 = alloca [2 x i8], align 1
  %t7 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  store i8 46, i8* %t7
  %t8 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 1
  store i8 0, i8* %t8
  %t9 = getelementptr [2 x i8], [2 x i8]* %t6, i32 0, i32 0
  %t10 = call i1 @starts_with(i8* %t5, i8* %t9)
  %t11 = load i8*, i8** %l0
  br i1 %t10, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t12 = load i8*, i8** %l0
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 59, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  %t17 = call i1 @starts_with(i8* %t12, i8* %t16)
  %t18 = load i8*, i8** %l0
  br i1 %t17, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t19 = load i8*, i8** %l0
  %s20 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t21 = call double @index_of(i8* %t19, i8* %s20)
  store double %t21, double* %l1
  %t22 = load double, double* %l1
  %t23 = sitofp i64 0 to double
  %t24 = fcmp oge double %t22, %t23
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  br i1 %t24, label %then6, label %merge7
then6:
  %t27 = load i8*, i8** %l0
  %t28 = load double, double* %l1
  %t29 = call double @llvm.round.f64(double %t28)
  %t30 = fptosi double %t29 to i64
  %t31 = call i8* @sailfin_runtime_substring(i8* %t27, i64 0, i64 %t30)
  %t32 = call i8* @trim_text(i8* %t31)
  store i8* %t32, i8** %l2
  %t33 = load i8*, i8** %l2
  %t34 = call i64 @sailfin_runtime_string_length(i8* %t33)
  %t35 = icmp eq i64 %t34, 0
  %t36 = load i8*, i8** %l0
  %t37 = load double, double* %l1
  %t38 = load i8*, i8** %l2
  br i1 %t35, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t39 = load i8*, i8** %l2
  %s40 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t41 = call i1 @starts_with(i8* %t39, i8* %s40)
  %t42 = load i8*, i8** %l0
  %t43 = load double, double* %l1
  %t44 = load i8*, i8** %l2
  br i1 %t41, label %then10, label %merge11
then10:
  %t45 = load i8*, i8** %l2
  %s46 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t47 = call i8* @strip_prefix(i8* %t45, i8* %s46)
  %t48 = call i8* @trim_text(i8* %t47)
  store i8* %t48, i8** %l2
  %t49 = load i8*, i8** %l2
  br label %merge11
merge11:
  %t50 = phi i8* [ %t49, %then10 ], [ %t44, %merge9 ]
  store i8* %t50, i8** %l2
  %t51 = load i8*, i8** %l2
  %t52 = call i64 @sailfin_runtime_string_length(i8* %t51)
  %t53 = icmp eq i64 %t52, 0
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load i8*, i8** %l2
  br i1 %t53, label %then12, label %merge13
then12:
  ret i1 0
merge13:
  %t57 = load i8*, i8** %l2
  %t58 = alloca [2 x i8], align 1
  %t59 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  store i8 32, i8* %t59
  %t60 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 1
  store i8 0, i8* %t60
  %t61 = getelementptr [2 x i8], [2 x i8]* %t58, i32 0, i32 0
  %t62 = call double @index_of(i8* %t57, i8* %t61)
  %t63 = sitofp i64 0 to double
  %t64 = fcmp oge double %t62, %t63
  %t65 = load i8*, i8** %l0
  %t66 = load double, double* %l1
  %t67 = load i8*, i8** %l2
  br i1 %t64, label %then14, label %merge15
then14:
  ret i1 0
merge15:
  %t68 = load i8*, i8** %l2
  %t69 = alloca [2 x i8], align 1
  %t70 = getelementptr [2 x i8], [2 x i8]* %t69, i32 0, i32 0
  store i8 9, i8* %t70
  %t71 = getelementptr [2 x i8], [2 x i8]* %t69, i32 0, i32 1
  store i8 0, i8* %t71
  %t72 = getelementptr [2 x i8], [2 x i8]* %t69, i32 0, i32 0
  %t73 = call double @index_of(i8* %t68, i8* %t72)
  %t74 = sitofp i64 0 to double
  %t75 = fcmp oge double %t73, %t74
  %t76 = load i8*, i8** %l0
  %t77 = load double, double* %l1
  %t78 = load i8*, i8** %l2
  br i1 %t75, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  ret i1 1
merge7:
  %t79 = load i8*, i8** %l0
  %t80 = alloca [2 x i8], align 1
  %t81 = getelementptr [2 x i8], [2 x i8]* %t80, i32 0, i32 0
  store i8 61, i8* %t81
  %t82 = getelementptr [2 x i8], [2 x i8]* %t80, i32 0, i32 1
  store i8 0, i8* %t82
  %t83 = getelementptr [2 x i8], [2 x i8]* %t80, i32 0, i32 0
  %t84 = call double @index_of(i8* %t79, i8* %t83)
  store double %t84, double* %l3
  %t85 = load double, double* %l3
  %t86 = sitofp i64 0 to double
  %t87 = fcmp oge double %t85, %t86
  %t88 = load i8*, i8** %l0
  %t89 = load double, double* %l1
  %t90 = load double, double* %l3
  br i1 %t87, label %then18, label %merge19
then18:
  %t91 = load i8*, i8** %l0
  %t92 = load double, double* %l3
  %t93 = call double @llvm.round.f64(double %t92)
  %t94 = fptosi double %t93 to i64
  %t95 = call i8* @sailfin_runtime_substring(i8* %t91, i64 0, i64 %t94)
  %t96 = call i8* @trim_text(i8* %t95)
  store i8* %t96, i8** %l4
  %t97 = load i8*, i8** %l4
  %t98 = call i64 @sailfin_runtime_string_length(i8* %t97)
  %t99 = icmp eq i64 %t98, 0
  %t100 = load i8*, i8** %l0
  %t101 = load double, double* %l1
  %t102 = load double, double* %l3
  %t103 = load i8*, i8** %l4
  br i1 %t99, label %then20, label %merge21
then20:
  ret i1 0
merge21:
  %t104 = load i8*, i8** %l4
  %s105 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t106 = call i1 @starts_with(i8* %t104, i8* %s105)
  %t107 = load i8*, i8** %l0
  %t108 = load double, double* %l1
  %t109 = load double, double* %l3
  %t110 = load i8*, i8** %l4
  br i1 %t106, label %then22, label %merge23
then22:
  %t111 = load i8*, i8** %l4
  %s112 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t113 = call i8* @strip_prefix(i8* %t111, i8* %s112)
  %t114 = call i8* @trim_text(i8* %t113)
  store i8* %t114, i8** %l4
  %t115 = load i8*, i8** %l4
  br label %merge23
merge23:
  %t116 = phi i8* [ %t115, %then22 ], [ %t110, %merge21 ]
  store i8* %t116, i8** %l4
  %t117 = load i8*, i8** %l4
  %t118 = call i64 @sailfin_runtime_string_length(i8* %t117)
  %t119 = icmp eq i64 %t118, 0
  %t120 = load i8*, i8** %l0
  %t121 = load double, double* %l1
  %t122 = load double, double* %l3
  %t123 = load i8*, i8** %l4
  br i1 %t119, label %then24, label %merge25
then24:
  ret i1 0
merge25:
  %t124 = load i8*, i8** %l4
  %t125 = alloca [2 x i8], align 1
  %t126 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  store i8 32, i8* %t126
  %t127 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 1
  store i8 0, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t125, i32 0, i32 0
  %t129 = call double @index_of(i8* %t124, i8* %t128)
  %t130 = sitofp i64 0 to double
  %t131 = fcmp oge double %t129, %t130
  %t132 = load i8*, i8** %l0
  %t133 = load double, double* %l1
  %t134 = load double, double* %l3
  %t135 = load i8*, i8** %l4
  br i1 %t131, label %then26, label %merge27
then26:
  ret i1 0
merge27:
  %t136 = load i8*, i8** %l4
  %t137 = alloca [2 x i8], align 1
  %t138 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  store i8 9, i8* %t138
  %t139 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 1
  store i8 0, i8* %t139
  %t140 = getelementptr [2 x i8], [2 x i8]* %t137, i32 0, i32 0
  %t141 = call double @index_of(i8* %t136, i8* %t140)
  %t142 = sitofp i64 0 to double
  %t143 = fcmp oge double %t141, %t142
  %t144 = load i8*, i8** %l0
  %t145 = load double, double* %l1
  %t146 = load double, double* %l3
  %t147 = load i8*, i8** %l4
  br i1 %t143, label %then28, label %merge29
then28:
  ret i1 0
merge29:
  ret i1 1
merge19:
  ret i1 0
}

define { i8**, i64 }* @split_parameter_entries(i8* %body) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca i8*
  %l5 = alloca i8
  %l6 = alloca i8*
  %l7 = alloca i8*
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
  %s15 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s15, i8** %l4
  %t16 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t17 = load i8*, i8** %l1
  %t18 = load double, double* %l2
  %t19 = load double, double* %l3
  %t20 = load i8*, i8** %l4
  br label %loop.header0
loop.header0:
  %t262 = phi i8* [ %t17, %block.entry ], [ %t257, %loop.latch2 ]
  %t263 = phi double [ %t18, %block.entry ], [ %t258, %loop.latch2 ]
  %t264 = phi i8* [ %t20, %block.entry ], [ %t259, %loop.latch2 ]
  %t265 = phi double [ %t19, %block.entry ], [ %t260, %loop.latch2 ]
  %t266 = phi { i8**, i64 }* [ %t16, %block.entry ], [ %t261, %loop.latch2 ]
  store i8* %t262, i8** %l1
  store double %t263, double* %l2
  store i8* %t264, i8** %l4
  store double %t265, double* %l3
  store { i8**, i64 }* %t266, { i8**, i64 }** %l0
  br label %loop.body1
loop.body1:
  %t21 = load double, double* %l2
  %t22 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t21, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load i8*, i8** %l1
  %t27 = load double, double* %l2
  %t28 = load double, double* %l3
  %t29 = load i8*, i8** %l4
  br i1 %t24, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t30 = load double, double* %l2
  %t31 = call double @llvm.round.f64(double %t30)
  %t32 = fptosi double %t31 to i64
  %t33 = getelementptr i8, i8* %body, i64 %t32
  %t34 = load i8, i8* %t33
  store i8 %t34, i8* %l5
  %t35 = load i8*, i8** %l4
  %t36 = call i64 @sailfin_runtime_string_length(i8* %t35)
  %t37 = icmp sgt i64 %t36, 0
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load i8*, i8** %l1
  %t40 = load double, double* %l2
  %t41 = load double, double* %l3
  %t42 = load i8*, i8** %l4
  %t43 = load i8, i8* %l5
  br i1 %t37, label %then6, label %merge7
then6:
  %t44 = load i8*, i8** %l1
  %t45 = load i8, i8* %l5
  %t46 = alloca [2 x i8], align 1
  %t47 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  store i8 %t45, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 1
  store i8 0, i8* %t48
  %t49 = getelementptr [2 x i8], [2 x i8]* %t46, i32 0, i32 0
  %t50 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %t49)
  store i8* %t50, i8** %l1
  %t51 = load i8, i8* %l5
  %t52 = icmp eq i8 %t51, 92
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l2
  %t56 = load double, double* %l3
  %t57 = load i8*, i8** %l4
  %t58 = load i8, i8* %l5
  br i1 %t52, label %then8, label %merge9
then8:
  %t59 = load double, double* %l2
  %t60 = sitofp i64 1 to double
  %t61 = fadd double %t59, %t60
  %t62 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp olt double %t61, %t63
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t66 = load i8*, i8** %l1
  %t67 = load double, double* %l2
  %t68 = load double, double* %l3
  %t69 = load i8*, i8** %l4
  %t70 = load i8, i8* %l5
  br i1 %t64, label %then10, label %merge11
then10:
  %t71 = load i8*, i8** %l1
  %t72 = load double, double* %l2
  %t73 = sitofp i64 1 to double
  %t74 = fadd double %t72, %t73
  %t75 = call double @llvm.round.f64(double %t74)
  %t76 = fptosi double %t75 to i64
  %t77 = getelementptr i8, i8* %body, i64 %t76
  %t78 = load i8, i8* %t77
  %t79 = alloca [2 x i8], align 1
  %t80 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  store i8 %t78, i8* %t80
  %t81 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 1
  store i8 0, i8* %t81
  %t82 = getelementptr [2 x i8], [2 x i8]* %t79, i32 0, i32 0
  %t83 = call i8* @sailfin_runtime_string_concat(i8* %t71, i8* %t82)
  store i8* %t83, i8** %l1
  %t84 = load double, double* %l2
  %t85 = sitofp i64 2 to double
  %t86 = fadd double %t84, %t85
  store double %t86, double* %l2
  br label %loop.latch2
merge11:
  %t87 = load i8*, i8** %l1
  %t88 = load double, double* %l2
  br label %merge9
merge9:
  %t89 = phi i8* [ %t87, %merge11 ], [ %t54, %then6 ]
  %t90 = phi double [ %t88, %merge11 ], [ %t55, %then6 ]
  store i8* %t89, i8** %l1
  store double %t90, double* %l2
  %t91 = load i8, i8* %l5
  %t92 = load i8*, i8** %l4
  %t93 = load i8, i8* %t92
  %t94 = icmp eq i8 %t91, %t93
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load i8*, i8** %l1
  %t97 = load double, double* %l2
  %t98 = load double, double* %l3
  %t99 = load i8*, i8** %l4
  %t100 = load i8, i8* %l5
  br i1 %t94, label %then12, label %merge13
then12:
  %s101 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s101, i8** %l4
  %t102 = load i8*, i8** %l4
  br label %merge13
merge13:
  %t103 = phi i8* [ %t102, %then12 ], [ %t99, %merge9 ]
  store i8* %t103, i8** %l4
  %t104 = load double, double* %l2
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  store double %t106, double* %l2
  br label %loop.latch2
merge7:
  %t108 = load i8, i8* %l5
  %t109 = icmp eq i8 %t108, 34
  br label %logical_or_entry_107

logical_or_entry_107:
  br i1 %t109, label %logical_or_merge_107, label %logical_or_right_107

logical_or_right_107:
  %t110 = load i8, i8* %l5
  %t111 = icmp eq i8 %t110, 39
  br label %logical_or_right_end_107

logical_or_right_end_107:
  br label %logical_or_merge_107

logical_or_merge_107:
  %t112 = phi i1 [ true, %logical_or_entry_107 ], [ %t111, %logical_or_right_end_107 ]
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t114 = load i8*, i8** %l1
  %t115 = load double, double* %l2
  %t116 = load double, double* %l3
  %t117 = load i8*, i8** %l4
  %t118 = load i8, i8* %l5
  br i1 %t112, label %then14, label %merge15
then14:
  %t119 = load i8, i8* %l5
  %t120 = alloca [2 x i8], align 1
  %t121 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  store i8 %t119, i8* %t121
  %t122 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 1
  store i8 0, i8* %t122
  %t123 = getelementptr [2 x i8], [2 x i8]* %t120, i32 0, i32 0
  store i8* %t123, i8** %l4
  %t124 = load i8*, i8** %l1
  %t125 = load i8, i8* %l5
  %t126 = alloca [2 x i8], align 1
  %t127 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  store i8 %t125, i8* %t127
  %t128 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 1
  store i8 0, i8* %t128
  %t129 = getelementptr [2 x i8], [2 x i8]* %t126, i32 0, i32 0
  %t130 = call i8* @sailfin_runtime_string_concat(i8* %t124, i8* %t129)
  store i8* %t130, i8** %l1
  %t131 = load double, double* %l2
  %t132 = sitofp i64 1 to double
  %t133 = fadd double %t131, %t132
  store double %t133, double* %l2
  br label %loop.latch2
merge15:
  %t135 = load i8, i8* %l5
  %t136 = icmp eq i8 %t135, 40
  br label %logical_or_entry_134

logical_or_entry_134:
  br i1 %t136, label %logical_or_merge_134, label %logical_or_right_134

logical_or_right_134:
  %t138 = load i8, i8* %l5
  %t139 = icmp eq i8 %t138, 91
  br label %logical_or_entry_137

logical_or_entry_137:
  br i1 %t139, label %logical_or_merge_137, label %logical_or_right_137

logical_or_right_137:
  %t140 = load i8, i8* %l5
  %t141 = icmp eq i8 %t140, 123
  br label %logical_or_right_end_137

logical_or_right_end_137:
  br label %logical_or_merge_137

logical_or_merge_137:
  %t142 = phi i1 [ true, %logical_or_entry_137 ], [ %t141, %logical_or_right_end_137 ]
  br label %logical_or_right_end_134

logical_or_right_end_134:
  br label %logical_or_merge_134

logical_or_merge_134:
  %t143 = phi i1 [ true, %logical_or_entry_134 ], [ %t142, %logical_or_right_end_134 ]
  %t144 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t145 = load i8*, i8** %l1
  %t146 = load double, double* %l2
  %t147 = load double, double* %l3
  %t148 = load i8*, i8** %l4
  %t149 = load i8, i8* %l5
  br i1 %t143, label %then16, label %merge17
then16:
  %t150 = load double, double* %l3
  %t151 = sitofp i64 1 to double
  %t152 = fadd double %t150, %t151
  store double %t152, double* %l3
  %t153 = load i8*, i8** %l1
  %t154 = load i8, i8* %l5
  %t155 = alloca [2 x i8], align 1
  %t156 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  store i8 %t154, i8* %t156
  %t157 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 1
  store i8 0, i8* %t157
  %t158 = getelementptr [2 x i8], [2 x i8]* %t155, i32 0, i32 0
  %t159 = call i8* @sailfin_runtime_string_concat(i8* %t153, i8* %t158)
  store i8* %t159, i8** %l1
  %t160 = load double, double* %l2
  %t161 = sitofp i64 1 to double
  %t162 = fadd double %t160, %t161
  store double %t162, double* %l2
  br label %loop.latch2
merge17:
  %t164 = load i8, i8* %l5
  %t165 = icmp eq i8 %t164, 41
  br label %logical_or_entry_163

logical_or_entry_163:
  br i1 %t165, label %logical_or_merge_163, label %logical_or_right_163

logical_or_right_163:
  %t167 = load i8, i8* %l5
  %t168 = icmp eq i8 %t167, 93
  br label %logical_or_entry_166

logical_or_entry_166:
  br i1 %t168, label %logical_or_merge_166, label %logical_or_right_166

logical_or_right_166:
  %t169 = load i8, i8* %l5
  %t170 = icmp eq i8 %t169, 125
  br label %logical_or_right_end_166

logical_or_right_end_166:
  br label %logical_or_merge_166

logical_or_merge_166:
  %t171 = phi i1 [ true, %logical_or_entry_166 ], [ %t170, %logical_or_right_end_166 ]
  br label %logical_or_right_end_163

logical_or_right_end_163:
  br label %logical_or_merge_163

logical_or_merge_163:
  %t172 = phi i1 [ true, %logical_or_entry_163 ], [ %t171, %logical_or_right_end_163 ]
  %t173 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t174 = load i8*, i8** %l1
  %t175 = load double, double* %l2
  %t176 = load double, double* %l3
  %t177 = load i8*, i8** %l4
  %t178 = load i8, i8* %l5
  br i1 %t172, label %then18, label %merge19
then18:
  %t179 = load double, double* %l3
  %t180 = sitofp i64 0 to double
  %t181 = fcmp ogt double %t179, %t180
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load i8*, i8** %l1
  %t184 = load double, double* %l2
  %t185 = load double, double* %l3
  %t186 = load i8*, i8** %l4
  %t187 = load i8, i8* %l5
  br i1 %t181, label %then20, label %merge21
then20:
  %t188 = load double, double* %l3
  %t189 = sitofp i64 1 to double
  %t190 = fsub double %t188, %t189
  store double %t190, double* %l3
  %t191 = load double, double* %l3
  br label %merge21
merge21:
  %t192 = phi double [ %t191, %then20 ], [ %t185, %then18 ]
  store double %t192, double* %l3
  %t193 = load i8*, i8** %l1
  %t194 = load i8, i8* %l5
  %t195 = alloca [2 x i8], align 1
  %t196 = getelementptr [2 x i8], [2 x i8]* %t195, i32 0, i32 0
  store i8 %t194, i8* %t196
  %t197 = getelementptr [2 x i8], [2 x i8]* %t195, i32 0, i32 1
  store i8 0, i8* %t197
  %t198 = getelementptr [2 x i8], [2 x i8]* %t195, i32 0, i32 0
  %t199 = call i8* @sailfin_runtime_string_concat(i8* %t193, i8* %t198)
  store i8* %t199, i8** %l1
  %t200 = load double, double* %l2
  %t201 = sitofp i64 1 to double
  %t202 = fadd double %t200, %t201
  store double %t202, double* %l2
  br label %loop.latch2
merge19:
  %t203 = load i8, i8* %l5
  %t204 = icmp eq i8 %t203, 44
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t206 = load i8*, i8** %l1
  %t207 = load double, double* %l2
  %t208 = load double, double* %l3
  %t209 = load i8*, i8** %l4
  %t210 = load i8, i8* %l5
  br i1 %t204, label %then22, label %merge23
then22:
  %t211 = load double, double* %l3
  %t212 = sitofp i64 0 to double
  %t213 = fcmp oeq double %t211, %t212
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t215 = load i8*, i8** %l1
  %t216 = load double, double* %l2
  %t217 = load double, double* %l3
  %t218 = load i8*, i8** %l4
  %t219 = load i8, i8* %l5
  br i1 %t213, label %then24, label %merge25
then24:
  %t220 = load i8*, i8** %l1
  %t221 = call i8* @trim_text(i8* %t220)
  store i8* %t221, i8** %l6
  %t222 = load i8*, i8** %l6
  %t223 = call i64 @sailfin_runtime_string_length(i8* %t222)
  %t224 = icmp sgt i64 %t223, 0
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t226 = load i8*, i8** %l1
  %t227 = load double, double* %l2
  %t228 = load double, double* %l3
  %t229 = load i8*, i8** %l4
  %t230 = load i8, i8* %l5
  %t231 = load i8*, i8** %l6
  br i1 %t224, label %then26, label %merge27
then26:
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t233 = load i8*, i8** %l6
  %t234 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t232, i8* %t233)
  store { i8**, i64 }* %t234, { i8**, i64 }** %l0
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t236 = phi { i8**, i64 }* [ %t235, %then26 ], [ %t225, %then24 ]
  store { i8**, i64 }* %t236, { i8**, i64 }** %l0
  %s237 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s237, i8** %l1
  %t238 = load double, double* %l2
  %t239 = sitofp i64 1 to double
  %t240 = fadd double %t238, %t239
  store double %t240, double* %l2
  br label %loop.latch2
merge25:
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t242 = load i8*, i8** %l1
  %t243 = load double, double* %l2
  br label %merge23
merge23:
  %t244 = phi { i8**, i64 }* [ %t241, %merge25 ], [ %t205, %merge19 ]
  %t245 = phi i8* [ %t242, %merge25 ], [ %t206, %merge19 ]
  %t246 = phi double [ %t243, %merge25 ], [ %t207, %merge19 ]
  store { i8**, i64 }* %t244, { i8**, i64 }** %l0
  store i8* %t245, i8** %l1
  store double %t246, double* %l2
  %t247 = load i8*, i8** %l1
  %t248 = load i8, i8* %l5
  %t249 = alloca [2 x i8], align 1
  %t250 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 0
  store i8 %t248, i8* %t250
  %t251 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 1
  store i8 0, i8* %t251
  %t252 = getelementptr [2 x i8], [2 x i8]* %t249, i32 0, i32 0
  %t253 = call i8* @sailfin_runtime_string_concat(i8* %t247, i8* %t252)
  store i8* %t253, i8** %l1
  %t254 = load double, double* %l2
  %t255 = sitofp i64 1 to double
  %t256 = fadd double %t254, %t255
  store double %t256, double* %l2
  br label %loop.latch2
loop.latch2:
  %t257 = load i8*, i8** %l1
  %t258 = load double, double* %l2
  %t259 = load i8*, i8** %l4
  %t260 = load double, double* %l3
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t267 = load i8*, i8** %l1
  %t268 = load double, double* %l2
  %t269 = load i8*, i8** %l4
  %t270 = load double, double* %l3
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t272 = load i8*, i8** %l1
  %t273 = call i8* @trim_text(i8* %t272)
  store i8* %t273, i8** %l7
  %t274 = load i8*, i8** %l7
  %t275 = call i64 @sailfin_runtime_string_length(i8* %t274)
  %t276 = icmp sgt i64 %t275, 0
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t278 = load i8*, i8** %l1
  %t279 = load double, double* %l2
  %t280 = load double, double* %l3
  %t281 = load i8*, i8** %l4
  %t282 = load i8*, i8** %l7
  br i1 %t276, label %then28, label %merge29
then28:
  %t283 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t284 = load i8*, i8** %l7
  %t285 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t283, i8* %t284)
  store { i8**, i64 }* %t285, { i8**, i64 }** %l0
  %t286 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t287 = phi { i8**, i64 }* [ %t286, %then28 ], [ %t277, %afterloop3 ]
  store { i8**, i64 }* %t287, { i8**, i64 }** %l0
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t288
}

define { i8**, i64 }* @parse_effect_list(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %s2 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268715771, i32 0, i32 0
  %t3 = call i1 @strings_equal(i8* %t1, i8* %s2)
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
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
  ret { i8**, i64 }* %t14
merge1:
  %t17 = load i8*, i8** %l0
  %t18 = call { i8**, i64 }* @split_comma_separated(i8* %t17)
  ret { i8**, i64 }* %t18
}

define { i8**, i64 }* @split_whitespace(i8* %value) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i1
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
  %t12 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t13 = icmp eq i64 %t12, 0
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br i1 %t13, label %then0, label %merge1
then0:
  %t15 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t15
merge1:
  %t16 = sitofp i64 -1 to double
  store double %t16, double* %l1
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l2
  %t18 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t98 = phi { i8**, i64 }* [ %t18, %merge1 ], [ %t95, %loop.latch4 ]
  %t99 = phi double [ %t19, %merge1 ], [ %t96, %loop.latch4 ]
  %t100 = phi double [ %t20, %merge1 ], [ %t97, %loop.latch4 ]
  store { i8**, i64 }* %t98, { i8**, i64 }** %l0
  store double %t99, double* %l1
  store double %t100, double* %l2
  br label %loop.body3
loop.body3:
  %t21 = load double, double* %l2
  %t22 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t23 = sitofp i64 %t22 to double
  %t24 = fcmp oge double %t21, %t23
  %t25 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t26 = load double, double* %l1
  %t27 = load double, double* %l2
  br i1 %t24, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t28 = load double, double* %l2
  %t29 = call i8* @text_char_at(i8* %value, double %t28)
  store i8* %t29, i8** %l3
  %t31 = load i8*, i8** %l3
  %t32 = load i8, i8* %t31
  %t33 = icmp eq i8 %t32, 32
  br label %logical_or_entry_30

logical_or_entry_30:
  br i1 %t33, label %logical_or_merge_30, label %logical_or_right_30

logical_or_right_30:
  %t35 = load i8*, i8** %l3
  %t36 = load i8, i8* %t35
  %t37 = icmp eq i8 %t36, 9
  br label %logical_or_entry_34

logical_or_entry_34:
  br i1 %t37, label %logical_or_merge_34, label %logical_or_right_34

logical_or_right_34:
  %t39 = load i8*, i8** %l3
  %t40 = load i8, i8* %t39
  %t41 = icmp eq i8 %t40, 10
  br label %logical_or_entry_38

logical_or_entry_38:
  br i1 %t41, label %logical_or_merge_38, label %logical_or_right_38

logical_or_right_38:
  %t42 = load i8*, i8** %l3
  %t43 = load i8, i8* %t42
  %t44 = icmp eq i8 %t43, 13
  br label %logical_or_right_end_38

logical_or_right_end_38:
  br label %logical_or_merge_38

logical_or_merge_38:
  %t45 = phi i1 [ true, %logical_or_entry_38 ], [ %t44, %logical_or_right_end_38 ]
  br label %logical_or_right_end_34

logical_or_right_end_34:
  br label %logical_or_merge_34

logical_or_merge_34:
  %t46 = phi i1 [ true, %logical_or_entry_34 ], [ %t45, %logical_or_right_end_34 ]
  br label %logical_or_right_end_30

logical_or_right_end_30:
  br label %logical_or_merge_30

logical_or_merge_30:
  %t47 = phi i1 [ true, %logical_or_entry_30 ], [ %t46, %logical_or_right_end_30 ]
  store i1 %t47, i1* %l4
  %t48 = load i1, i1* %l4
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load double, double* %l1
  %t51 = load double, double* %l2
  %t52 = load i8*, i8** %l3
  %t53 = load i1, i1* %l4
  br i1 %t48, label %then8, label %else9
then8:
  %t54 = load double, double* %l1
  %t55 = sitofp i64 0 to double
  %t56 = fcmp oge double %t54, %t55
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t58 = load double, double* %l1
  %t59 = load double, double* %l2
  %t60 = load i8*, i8** %l3
  %t61 = load i1, i1* %l4
  br i1 %t56, label %then11, label %merge12
then11:
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load double, double* %l1
  %t64 = load double, double* %l2
  %t65 = call double @llvm.round.f64(double %t63)
  %t66 = fptosi double %t65 to i64
  %t67 = call double @llvm.round.f64(double %t64)
  %t68 = fptosi double %t67 to i64
  %t69 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t66, i64 %t68)
  %t70 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t62, i8* %t69)
  store { i8**, i64 }* %t70, { i8**, i64 }** %l0
  %t71 = sitofp i64 -1 to double
  store double %t71, double* %l1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t73 = load double, double* %l1
  br label %merge12
merge12:
  %t74 = phi { i8**, i64 }* [ %t72, %then11 ], [ %t57, %then8 ]
  %t75 = phi double [ %t73, %then11 ], [ %t58, %then8 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l0
  store double %t75, double* %l1
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t77 = load double, double* %l1
  br label %merge10
else9:
  %t78 = load double, double* %l1
  %t79 = sitofp i64 0 to double
  %t80 = fcmp olt double %t78, %t79
  %t81 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t82 = load double, double* %l1
  %t83 = load double, double* %l2
  %t84 = load i8*, i8** %l3
  %t85 = load i1, i1* %l4
  br i1 %t80, label %then13, label %merge14
then13:
  %t86 = load double, double* %l2
  store double %t86, double* %l1
  %t87 = load double, double* %l1
  br label %merge14
merge14:
  %t88 = phi double [ %t87, %then13 ], [ %t82, %else9 ]
  store double %t88, double* %l1
  %t89 = load double, double* %l1
  br label %merge10
merge10:
  %t90 = phi { i8**, i64 }* [ %t76, %merge12 ], [ %t49, %merge14 ]
  %t91 = phi double [ %t77, %merge12 ], [ %t89, %merge14 ]
  store { i8**, i64 }* %t90, { i8**, i64 }** %l0
  store double %t91, double* %l1
  %t92 = load double, double* %l2
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l2
  br label %loop.latch4
loop.latch4:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t102 = load double, double* %l1
  %t103 = load double, double* %l2
  %t104 = load double, double* %l1
  %t105 = sitofp i64 0 to double
  %t106 = fcmp oge double %t104, %t105
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t108 = load double, double* %l1
  %t109 = load double, double* %l2
  br i1 %t106, label %then15, label %merge16
then15:
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load double, double* %l1
  %t112 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t113 = call double @llvm.round.f64(double %t111)
  %t114 = fptosi double %t113 to i64
  %t115 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t114, i64 %t112)
  %t116 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t110, i8* %t115)
  store { i8**, i64 }* %t116, { i8**, i64 }** %l0
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge16
merge16:
  %t118 = phi { i8**, i64 }* [ %t117, %then15 ], [ %t107, %afterloop5 ]
  store { i8**, i64 }* %t118, { i8**, i64 }** %l0
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t119
}

define %NumberParseResult @parse_decimal_number(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %l5 = alloca i8
  %l6 = alloca double
  %l7 = alloca double
  %t0 = call i8* @trim_text(i8* %text)
  store i8* %t0, i8** %l0
  %t1 = load i8*, i8** %l0
  %t2 = call i64 @sailfin_runtime_string_length(i8* %t1)
  %t3 = icmp eq i64 %t2, 0
  %t4 = load i8*, i8** %l0
  br i1 %t3, label %then0, label %merge1
then0:
  %t5 = insertvalue %NumberParseResult undef, i1 0, 0
  %t6 = sitofp i64 0 to double
  %t7 = insertvalue %NumberParseResult %t5, double %t6, 1
  ret %NumberParseResult %t7
merge1:
  %t8 = alloca [2 x i8], align 1
  %t9 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  store i8 48, i8* %t9
  %t10 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 1
  store i8 0, i8* %t10
  %t11 = getelementptr [2 x i8], [2 x i8]* %t8, i32 0, i32 0
  %t12 = call double @char_code(i8* %t11)
  store double %t12, double* %l1
  %t13 = alloca [2 x i8], align 1
  %t14 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  store i8 57, i8* %t14
  %t15 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 1
  store i8 0, i8* %t15
  %t16 = getelementptr [2 x i8], [2 x i8]* %t13, i32 0, i32 0
  %t17 = call double @char_code(i8* %t16)
  store double %t17, double* %l2
  %t18 = sitofp i64 0 to double
  store double %t18, double* %l3
  %t19 = sitofp i64 0 to double
  store double %t19, double* %l4
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  %t23 = load double, double* %l3
  %t24 = load double, double* %l4
  br label %loop.header2
loop.header2:
  %t78 = phi double [ %t24, %merge1 ], [ %t76, %loop.latch4 ]
  %t79 = phi double [ %t23, %merge1 ], [ %t77, %loop.latch4 ]
  store double %t78, double* %l4
  store double %t79, double* %l3
  br label %loop.body3
loop.body3:
  %t25 = load double, double* %l3
  %t26 = load i8*, i8** %l0
  %t27 = call i64 @sailfin_runtime_string_length(i8* %t26)
  %t28 = sitofp i64 %t27 to double
  %t29 = fcmp oge double %t25, %t28
  %t30 = load i8*, i8** %l0
  %t31 = load double, double* %l1
  %t32 = load double, double* %l2
  %t33 = load double, double* %l3
  %t34 = load double, double* %l4
  br i1 %t29, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t35 = load i8*, i8** %l0
  %t36 = load double, double* %l3
  %t37 = call double @llvm.round.f64(double %t36)
  %t38 = fptosi double %t37 to i64
  %t39 = getelementptr i8, i8* %t35, i64 %t38
  %t40 = load i8, i8* %t39
  store i8 %t40, i8* %l5
  %t41 = load i8, i8* %l5
  %t42 = alloca [2 x i8], align 1
  %t43 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  store i8 %t41, i8* %t43
  %t44 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 1
  store i8 0, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t42, i32 0, i32 0
  %t46 = call double @char_code(i8* %t45)
  store double %t46, double* %l6
  %t48 = load double, double* %l6
  %t49 = load double, double* %l1
  %t50 = fcmp olt double %t48, %t49
  br label %logical_or_entry_47

logical_or_entry_47:
  br i1 %t50, label %logical_or_merge_47, label %logical_or_right_47

logical_or_right_47:
  %t51 = load double, double* %l6
  %t52 = load double, double* %l2
  %t53 = fcmp ogt double %t51, %t52
  br label %logical_or_right_end_47

logical_or_right_end_47:
  br label %logical_or_merge_47

logical_or_merge_47:
  %t54 = phi i1 [ true, %logical_or_entry_47 ], [ %t53, %logical_or_right_end_47 ]
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l2
  %t58 = load double, double* %l3
  %t59 = load double, double* %l4
  %t60 = load i8, i8* %l5
  %t61 = load double, double* %l6
  br i1 %t54, label %then8, label %merge9
then8:
  %t62 = insertvalue %NumberParseResult undef, i1 0, 0
  %t63 = sitofp i64 0 to double
  %t64 = insertvalue %NumberParseResult %t62, double %t63, 1
  ret %NumberParseResult %t64
merge9:
  %t65 = load double, double* %l6
  %t66 = load double, double* %l1
  %t67 = fsub double %t65, %t66
  store double %t67, double* %l7
  %t68 = load double, double* %l4
  %t69 = sitofp i64 10 to double
  %t70 = fmul double %t68, %t69
  %t71 = load double, double* %l7
  %t72 = fadd double %t70, %t71
  store double %t72, double* %l4
  %t73 = load double, double* %l3
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  store double %t75, double* %l3
  br label %loop.latch4
loop.latch4:
  %t76 = load double, double* %l4
  %t77 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t80 = load double, double* %l4
  %t81 = load double, double* %l3
  %t82 = insertvalue %NumberParseResult undef, i1 1, 0
  %t83 = load double, double* %l4
  %t84 = insertvalue %NumberParseResult %t82, double %t83, 1
  ret %NumberParseResult %t84
}

define { i8**, i64 }* @split_lines(i8* %value) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
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
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t57 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t54, %loop.latch2 ]
  %t58 = phi i8* [ %t15, %block.entry ], [ %t55, %loop.latch2 ]
  %t59 = phi double [ %t16, %block.entry ], [ %t56, %loop.latch2 ]
  store { i8**, i64 }* %t57, { i8**, i64 }** %l0
  store i8* %t58, i8** %l1
  store double %t59, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t17, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load double, double* %l2
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = getelementptr i8, i8* %value, i64 %t26
  %t28 = load i8, i8* %t27
  store i8 %t28, i8* %l3
  %t29 = load i8, i8* %l3
  %t30 = icmp eq i8 %t29, 10
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load i8, i8* %l3
  br i1 %t30, label %then6, label %else7
then6:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t35, i8* %t36)
  store { i8**, i64 }* %t37, { i8**, i64 }** %l0
  %s38 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s38, i8** %l1
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t40 = load i8*, i8** %l1
  br label %merge8
else7:
  %t41 = load i8*, i8** %l1
  %t42 = load i8, i8* %l3
  %t43 = alloca [2 x i8], align 1
  %t44 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  store i8 %t42, i8* %t44
  %t45 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 1
  store i8 0, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t43, i32 0, i32 0
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t46)
  store i8* %t47, i8** %l1
  %t48 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t49 = phi { i8**, i64 }* [ %t39, %then6 ], [ %t31, %else7 ]
  %t50 = phi i8* [ %t40, %then6 ], [ %t48, %else7 ]
  store { i8**, i64 }* %t49, { i8**, i64 }** %l0
  store i8* %t50, i8** %l1
  %t51 = load double, double* %l2
  %t52 = sitofp i64 1 to double
  %t53 = fadd double %t51, %t52
  store double %t53, double* %l2
  br label %loop.latch2
loop.latch2:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load i8*, i8** %l1
  %t56 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t60 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t61 = load i8*, i8** %l1
  %t62 = load double, double* %l2
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t64 = load i8*, i8** %l1
  %t65 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t63, i8* %t64)
  store { i8**, i64 }* %t65, { i8**, i64 }** %l0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t66
}

define { i8**, i64 }* @split_comma_separated(i8* %value) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8
  %l4 = alloca { i8**, i64 }*
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
  %s12 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s12, i8** %l1
  %t13 = sitofp i64 0 to double
  store double %t13, double* %l2
  %t14 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t15 = load i8*, i8** %l1
  %t16 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t58 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t55, %loop.latch2 ]
  %t59 = phi i8* [ %t15, %block.entry ], [ %t56, %loop.latch2 ]
  %t60 = phi double [ %t16, %block.entry ], [ %t57, %loop.latch2 ]
  store { i8**, i64 }* %t58, { i8**, i64 }** %l0
  store i8* %t59, i8** %l1
  store double %t60, double* %l2
  br label %loop.body1
loop.body1:
  %t17 = load double, double* %l2
  %t18 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t19 = sitofp i64 %t18 to double
  %t20 = fcmp oge double %t17, %t19
  %t21 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t22 = load i8*, i8** %l1
  %t23 = load double, double* %l2
  br i1 %t20, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t24 = load double, double* %l2
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = getelementptr i8, i8* %value, i64 %t26
  %t28 = load i8, i8* %t27
  store i8 %t28, i8* %l3
  %t29 = load i8, i8* %l3
  %t30 = icmp eq i8 %t29, 44
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load i8, i8* %l3
  br i1 %t30, label %then6, label %else7
then6:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = call i8* @trim_text(i8* %t36)
  %t38 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t35, i8* %t37)
  store { i8**, i64 }* %t38, { i8**, i64 }** %l0
  %s39 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s39, i8** %l1
  %t40 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t41 = load i8*, i8** %l1
  br label %merge8
else7:
  %t42 = load i8*, i8** %l1
  %t43 = load i8, i8* %l3
  %t44 = alloca [2 x i8], align 1
  %t45 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  store i8 %t43, i8* %t45
  %t46 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 1
  store i8 0, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t44, i32 0, i32 0
  %t48 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t47)
  store i8* %t48, i8** %l1
  %t49 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t50 = phi { i8**, i64 }* [ %t40, %then6 ], [ %t31, %else7 ]
  %t51 = phi i8* [ %t41, %then6 ], [ %t49, %else7 ]
  store { i8**, i64 }* %t50, { i8**, i64 }** %l0
  store i8* %t51, i8** %l1
  %t52 = load double, double* %l2
  %t53 = sitofp i64 1 to double
  %t54 = fadd double %t52, %t53
  store double %t54, double* %l2
  br label %loop.latch2
loop.latch2:
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load i8*, i8** %l1
  %t57 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t61 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t62 = load i8*, i8** %l1
  %t63 = load double, double* %l2
  %t64 = load i8*, i8** %l1
  %t65 = call i64 @sailfin_runtime_string_length(i8* %t64)
  %t66 = icmp sgt i64 %t65, 0
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = load i8*, i8** %l1
  %t69 = load double, double* %l2
  br i1 %t66, label %then9, label %merge10
then9:
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t71 = load i8*, i8** %l1
  %t72 = call i8* @trim_text(i8* %t71)
  %t73 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t70, i8* %t72)
  store { i8**, i64 }* %t73, { i8**, i64 }** %l0
  %t74 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t75 = phi { i8**, i64 }* [ %t74, %then9 ], [ %t67, %afterloop3 ]
  store { i8**, i64 }* %t75, { i8**, i64 }** %l0
  %t76 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t77 = ptrtoint [0 x i8*]* %t76 to i64
  %t78 = icmp eq i64 %t77, 0
  %t79 = select i1 %t78, i64 1, i64 %t77
  %t80 = call i8* @malloc(i64 %t79)
  %t81 = bitcast i8* %t80 to i8**
  %t82 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t83 = ptrtoint { i8**, i64 }* %t82 to i64
  %t84 = call i8* @malloc(i64 %t83)
  %t85 = bitcast i8* %t84 to { i8**, i64 }*
  %t86 = getelementptr { i8**, i64 }, { i8**, i64 }* %t85, i32 0, i32 0
  store i8** %t81, i8*** %t86
  %t87 = getelementptr { i8**, i64 }, { i8**, i64 }* %t85, i32 0, i32 1
  store i64 0, i64* %t87
  store { i8**, i64 }* %t85, { i8**, i64 }** %l4
  %t88 = sitofp i64 0 to double
  store double %t88, double* %l2
  %t89 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t90 = load i8*, i8** %l1
  %t91 = load double, double* %l2
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header11
loop.header11:
  %t131 = phi { i8**, i64 }* [ %t92, %merge10 ], [ %t129, %loop.latch13 ]
  %t132 = phi double [ %t91, %merge10 ], [ %t130, %loop.latch13 ]
  store { i8**, i64 }* %t131, { i8**, i64 }** %l4
  store double %t132, double* %l2
  br label %loop.body12
loop.body12:
  %t93 = load double, double* %l2
  %t94 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t95 = load { i8**, i64 }, { i8**, i64 }* %t94
  %t96 = extractvalue { i8**, i64 } %t95, 1
  %t97 = sitofp i64 %t96 to double
  %t98 = fcmp oge double %t93, %t97
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t100 = load i8*, i8** %l1
  %t101 = load double, double* %l2
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t98, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t104 = load double, double* %l2
  %t105 = call double @llvm.round.f64(double %t104)
  %t106 = fptosi double %t105 to i64
  %t107 = load { i8**, i64 }, { i8**, i64 }* %t103
  %t108 = extractvalue { i8**, i64 } %t107, 0
  %t109 = extractvalue { i8**, i64 } %t107, 1
  %t110 = icmp uge i64 %t106, %t109
  ; bounds check: %t110 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t106, i64 %t109)
  %t111 = getelementptr i8*, i8** %t108, i64 %t106
  %t112 = load i8*, i8** %t111
  store i8* %t112, i8** %l5
  %t113 = load i8*, i8** %l5
  %t114 = call i64 @sailfin_runtime_string_length(i8* %t113)
  %t115 = icmp sgt i64 %t114, 0
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t117 = load i8*, i8** %l1
  %t118 = load double, double* %l2
  %t119 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t120 = load i8*, i8** %l5
  br i1 %t115, label %then17, label %merge18
then17:
  %t121 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t122 = load i8*, i8** %l5
  %t123 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t121, i8* %t122)
  store { i8**, i64 }* %t123, { i8**, i64 }** %l4
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge18
merge18:
  %t125 = phi { i8**, i64 }* [ %t124, %then17 ], [ %t119, %merge16 ]
  store { i8**, i64 }* %t125, { i8**, i64 }** %l4
  %t126 = load double, double* %l2
  %t127 = sitofp i64 1 to double
  %t128 = fadd double %t126, %t127
  store double %t128, double* %l2
  br label %loop.latch13
loop.latch13:
  %t129 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t130 = load double, double* %l2
  br label %loop.header11
afterloop14:
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t134 = load double, double* %l2
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t135
}

define i8* @strip_generics(i8* %name) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca i8
  %s0 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s0, i8** %l0
  %t1 = sitofp i64 0 to double
  store double %t1, double* %l1
  %t2 = sitofp i64 0 to double
  store double %t2, double* %l2
  %t3 = load i8*, i8** %l0
  %t4 = load double, double* %l1
  %t5 = load double, double* %l2
  br label %loop.header0
loop.header0:
  %t73 = phi double [ %t4, %block.entry ], [ %t70, %loop.latch2 ]
  %t74 = phi double [ %t5, %block.entry ], [ %t71, %loop.latch2 ]
  %t75 = phi i8* [ %t3, %block.entry ], [ %t72, %loop.latch2 ]
  store double %t73, double* %l1
  store double %t74, double* %l2
  store i8* %t75, i8** %l0
  br label %loop.body1
loop.body1:
  %t6 = load double, double* %l2
  %t7 = call i64 @sailfin_runtime_string_length(i8* %name)
  %t8 = sitofp i64 %t7 to double
  %t9 = fcmp oge double %t6, %t8
  %t10 = load i8*, i8** %l0
  %t11 = load double, double* %l1
  %t12 = load double, double* %l2
  br i1 %t9, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t13 = load double, double* %l2
  %t14 = call double @llvm.round.f64(double %t13)
  %t15 = fptosi double %t14 to i64
  %t16 = getelementptr i8, i8* %name, i64 %t15
  %t17 = load i8, i8* %t16
  store i8 %t17, i8* %l3
  %t18 = load i8, i8* %l3
  %t19 = icmp eq i8 %t18, 60
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load double, double* %l2
  %t23 = load i8, i8* %l3
  br i1 %t19, label %then6, label %merge7
then6:
  %t24 = load double, double* %l1
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l1
  %t27 = load double, double* %l2
  %t28 = sitofp i64 1 to double
  %t29 = fadd double %t27, %t28
  store double %t29, double* %l2
  br label %loop.latch2
merge7:
  %t30 = load i8, i8* %l3
  %t31 = icmp eq i8 %t30, 62
  %t32 = load i8*, i8** %l0
  %t33 = load double, double* %l1
  %t34 = load double, double* %l2
  %t35 = load i8, i8* %l3
  br i1 %t31, label %then8, label %merge9
then8:
  %t36 = load double, double* %l1
  %t37 = sitofp i64 0 to double
  %t38 = fcmp ogt double %t36, %t37
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  %t41 = load double, double* %l2
  %t42 = load i8, i8* %l3
  br i1 %t38, label %then10, label %merge11
then10:
  %t43 = load double, double* %l1
  %t44 = sitofp i64 1 to double
  %t45 = fsub double %t43, %t44
  store double %t45, double* %l1
  %t46 = load double, double* %l1
  br label %merge11
merge11:
  %t47 = phi double [ %t46, %then10 ], [ %t40, %then8 ]
  store double %t47, double* %l1
  %t48 = load double, double* %l2
  %t49 = sitofp i64 1 to double
  %t50 = fadd double %t48, %t49
  store double %t50, double* %l2
  br label %loop.latch2
merge9:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 0 to double
  %t53 = fcmp oeq double %t51, %t52
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = load double, double* %l2
  %t57 = load i8, i8* %l3
  br i1 %t53, label %then12, label %merge13
then12:
  %t58 = load i8*, i8** %l0
  %t59 = load i8, i8* %l3
  %t60 = alloca [2 x i8], align 1
  %t61 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  store i8 %t59, i8* %t61
  %t62 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 1
  store i8 0, i8* %t62
  %t63 = getelementptr [2 x i8], [2 x i8]* %t60, i32 0, i32 0
  %t64 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t63)
  store i8* %t64, i8** %l0
  %t65 = load i8*, i8** %l0
  br label %merge13
merge13:
  %t66 = phi i8* [ %t65, %then12 ], [ %t54, %merge9 ]
  store i8* %t66, i8** %l0
  %t67 = load double, double* %l2
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l2
  br label %loop.latch2
loop.latch2:
  %t70 = load double, double* %l1
  %t71 = load double, double* %l2
  %t72 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t76 = load double, double* %l1
  %t77 = load double, double* %l2
  %t78 = load i8*, i8** %l0
  %t79 = load i8*, i8** %l0
  %t80 = call i8* @trim_text(i8* %t79)
  call void @sailfin_runtime_mark_persistent(i8* %t80)
  ret i8* %t80
}

define i8* @trim_text(i8* %value) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i8
  %l3 = alloca i8
  %t0 = sitofp i64 0 to double
  store double %t0, double* %l0
  %t1 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t2 = sitofp i64 %t1 to double
  store double %t2, double* %l1
  %t3 = load double, double* %l0
  %t4 = load double, double* %l1
  br label %loop.header0
loop.header0:
  %t28 = phi double [ %t3, %block.entry ], [ %t27, %loop.latch2 ]
  store double %t28, double* %l0
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
  %t11 = call double @llvm.round.f64(double %t10)
  %t12 = fptosi double %t11 to i64
  %t13 = getelementptr i8, i8* %value, i64 %t12
  %t14 = load i8, i8* %t13
  store i8 %t14, i8* %l2
  %t15 = load i8, i8* %l2
  %t16 = alloca [2 x i8], align 1
  %t17 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  store i8 %t15, i8* %t17
  %t18 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 1
  store i8 0, i8* %t18
  %t19 = getelementptr [2 x i8], [2 x i8]* %t16, i32 0, i32 0
  %t20 = call i1 @is_trim_char(i8* %t19)
  %t21 = load double, double* %l0
  %t22 = load double, double* %l1
  %t23 = load i8, i8* %l2
  br i1 %t20, label %then6, label %merge7
then6:
  %t24 = load double, double* %l0
  %t25 = sitofp i64 1 to double
  %t26 = fadd double %t24, %t25
  store double %t26, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t27 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t29 = load double, double* %l0
  %t30 = load double, double* %l0
  %t31 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t57 = phi double [ %t31, %afterloop3 ], [ %t56, %loop.latch10 ]
  store double %t57, double* %l1
  br label %loop.body9
loop.body9:
  %t32 = load double, double* %l1
  %t33 = load double, double* %l0
  %t34 = fcmp ole double %t32, %t33
  %t35 = load double, double* %l0
  %t36 = load double, double* %l1
  br i1 %t34, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t37 = load double, double* %l1
  %t38 = sitofp i64 1 to double
  %t39 = fsub double %t37, %t38
  %t40 = call double @llvm.round.f64(double %t39)
  %t41 = fptosi double %t40 to i64
  %t42 = getelementptr i8, i8* %value, i64 %t41
  %t43 = load i8, i8* %t42
  store i8 %t43, i8* %l3
  %t44 = load i8, i8* %l3
  %t45 = alloca [2 x i8], align 1
  %t46 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  store i8 %t44, i8* %t46
  %t47 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 1
  store i8 0, i8* %t47
  %t48 = getelementptr [2 x i8], [2 x i8]* %t45, i32 0, i32 0
  %t49 = call i1 @is_trim_char(i8* %t48)
  %t50 = load double, double* %l0
  %t51 = load double, double* %l1
  %t52 = load i8, i8* %l3
  br i1 %t49, label %then14, label %merge15
then14:
  %t53 = load double, double* %l1
  %t54 = sitofp i64 1 to double
  %t55 = fsub double %t53, %t54
  store double %t55, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t56 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t58 = load double, double* %l1
  %t60 = load double, double* %l0
  %t61 = sitofp i64 0 to double
  %t62 = fcmp oeq double %t60, %t61
  br label %logical_and_entry_59

logical_and_entry_59:
  br i1 %t62, label %logical_and_right_59, label %logical_and_merge_59

logical_and_right_59:
  %t63 = load double, double* %l1
  %t64 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t65 = sitofp i64 %t64 to double
  %t66 = fcmp oeq double %t63, %t65
  br label %logical_and_right_end_59

logical_and_right_end_59:
  br label %logical_and_merge_59

logical_and_merge_59:
  %t67 = phi i1 [ false, %logical_and_entry_59 ], [ %t66, %logical_and_right_end_59 ]
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  br i1 %t67, label %then16, label %merge17
then16:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge17:
  %t70 = load double, double* %l0
  %t71 = load double, double* %l1
  %t72 = call double @llvm.round.f64(double %t70)
  %t73 = fptosi double %t72 to i64
  %t74 = call double @llvm.round.f64(double %t71)
  %t75 = fptosi double %t74 to i64
  %t76 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t73, i64 %t75)
  call void @sailfin_runtime_mark_persistent(i8* %t76)
  ret i8* %t76
}

define %LayoutManifest @parse_layout_manifest(i8* %text) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeStruct*, i64 }*
  %l3 = alloca { %NativeEnum*, i64 }*
  %l4 = alloca double
  %l5 = alloca i8*
  %l6 = alloca i8*
  %l7 = alloca i8*
  %l8 = alloca i8*
  %l9 = alloca %StructLayoutHeaderParse
  %l10 = alloca { %NativeStructLayoutField*, i64 }*
  %l11 = alloca i8*
  %l12 = alloca i8*
  %l13 = alloca i8*
  %l14 = alloca i8*
  %l15 = alloca %StructLayoutFieldParse
  %l16 = alloca %NativeStruct
  %l17 = alloca i8*
  %l18 = alloca i8*
  %l19 = alloca %EnumLayoutHeaderParse
  %l20 = alloca { %NativeEnumVariantLayout*, i64 }*
  %l21 = alloca i8*
  %l22 = alloca i8*
  %l23 = alloca i8*
  %l24 = alloca i8*
  %l25 = alloca %EnumLayoutVariantParse
  %l26 = alloca i8*
  %l27 = alloca i8*
  %l28 = alloca %EnumLayoutPayloadParse
  %l29 = alloca i64
  %l30 = alloca %NativeEnumVariantLayout
  %l31 = alloca { %NativeStructLayoutField*, i64 }*
  %l32 = alloca %NativeEnum
  %t0 = call { i8**, i64 }* @split_lines(i8* %text)
  store { i8**, i64 }* %t0, { i8**, i64 }** %l0
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
  %t13 = getelementptr [0 x %NativeStruct], [0 x %NativeStruct]* null, i32 1
  %t14 = ptrtoint [0 x %NativeStruct]* %t13 to i64
  %t15 = icmp eq i64 %t14, 0
  %t16 = select i1 %t15, i64 1, i64 %t14
  %t17 = call i8* @malloc(i64 %t16)
  %t18 = bitcast i8* %t17 to %NativeStruct*
  %t19 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* null, i32 1
  %t20 = ptrtoint { %NativeStruct*, i64 }* %t19 to i64
  %t21 = call i8* @malloc(i64 %t20)
  %t22 = bitcast i8* %t21 to { %NativeStruct*, i64 }*
  %t23 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t22, i32 0, i32 0
  store %NativeStruct* %t18, %NativeStruct** %t23
  %t24 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t22, i32 0, i32 1
  store i64 0, i64* %t24
  store { %NativeStruct*, i64 }* %t22, { %NativeStruct*, i64 }** %l2
  %t25 = getelementptr [0 x %NativeEnum], [0 x %NativeEnum]* null, i32 1
  %t26 = ptrtoint [0 x %NativeEnum]* %t25 to i64
  %t27 = icmp eq i64 %t26, 0
  %t28 = select i1 %t27, i64 1, i64 %t26
  %t29 = call i8* @malloc(i64 %t28)
  %t30 = bitcast i8* %t29 to %NativeEnum*
  %t31 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* null, i32 1
  %t32 = ptrtoint { %NativeEnum*, i64 }* %t31 to i64
  %t33 = call i8* @malloc(i64 %t32)
  %t34 = bitcast i8* %t33 to { %NativeEnum*, i64 }*
  %t35 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t34, i32 0, i32 0
  store %NativeEnum* %t30, %NativeEnum** %t35
  %t36 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t34, i32 0, i32 1
  store i64 0, i64* %t36
  store { %NativeEnum*, i64 }* %t34, { %NativeEnum*, i64 }** %l3
  %t37 = sitofp i64 0 to double
  store double %t37, double* %l4
  %t38 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t39 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t40 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t41 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t42 = load double, double* %l4
  br label %loop.header0
loop.header0:
  %t719 = phi double [ %t42, %block.entry ], [ %t715, %loop.latch2 ]
  %t720 = phi { i8**, i64 }* [ %t39, %block.entry ], [ %t716, %loop.latch2 ]
  %t721 = phi { %NativeStruct*, i64 }* [ %t40, %block.entry ], [ %t717, %loop.latch2 ]
  %t722 = phi { %NativeEnum*, i64 }* [ %t41, %block.entry ], [ %t718, %loop.latch2 ]
  store double %t719, double* %l4
  store { i8**, i64 }* %t720, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t721, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t722, { %NativeEnum*, i64 }** %l3
  br label %loop.body1
loop.body1:
  %t43 = load double, double* %l4
  %t44 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t45 = load { i8**, i64 }, { i8**, i64 }* %t44
  %t46 = extractvalue { i8**, i64 } %t45, 1
  %t47 = sitofp i64 %t46 to double
  %t48 = fcmp oge double %t43, %t47
  %t49 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t50 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t51 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t52 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t53 = load double, double* %l4
  br i1 %t48, label %then4, label %merge5
then4:
  br label %afterloop3
merge5:
  %t54 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t55 = load double, double* %l4
  %t56 = call double @llvm.round.f64(double %t55)
  %t57 = fptosi double %t56 to i64
  %t58 = load { i8**, i64 }, { i8**, i64 }* %t54
  %t59 = extractvalue { i8**, i64 } %t58, 0
  %t60 = extractvalue { i8**, i64 } %t58, 1
  %t61 = icmp uge i64 %t57, %t60
  ; bounds check: %t61 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t57, i64 %t60)
  %t62 = getelementptr i8*, i8** %t59, i64 %t57
  %t63 = load i8*, i8** %t62
  store i8* %t63, i8** %l5
  %t64 = load i8*, i8** %l5
  %t65 = call i8* @trim_text(i8* %t64)
  store i8* %t65, i8** %l6
  %t66 = load i8*, i8** %l6
  %t67 = call i64 @sailfin_runtime_string_length(i8* %t66)
  %t68 = icmp eq i64 %t67, 0
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t71 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t72 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t73 = load double, double* %l4
  %t74 = load i8*, i8** %l5
  %t75 = load i8*, i8** %l6
  br i1 %t68, label %then6, label %merge7
then6:
  %t76 = load double, double* %l4
  %t77 = sitofp i64 1 to double
  %t78 = fadd double %t76, %t77
  store double %t78, double* %l4
  br label %loop.latch2
merge7:
  %t79 = load i8*, i8** %l6
  %t80 = alloca [2 x i8], align 1
  %t81 = getelementptr [2 x i8], [2 x i8]* %t80, i32 0, i32 0
  store i8 59, i8* %t81
  %t82 = getelementptr [2 x i8], [2 x i8]* %t80, i32 0, i32 1
  store i8 0, i8* %t82
  %t83 = getelementptr [2 x i8], [2 x i8]* %t80, i32 0, i32 0
  %t84 = call i1 @starts_with(i8* %t79, i8* %t83)
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t88 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t89 = load double, double* %l4
  %t90 = load i8*, i8** %l5
  %t91 = load i8*, i8** %l6
  br i1 %t84, label %then8, label %merge9
then8:
  %t92 = load double, double* %l4
  %t93 = sitofp i64 1 to double
  %t94 = fadd double %t92, %t93
  store double %t94, double* %l4
  br label %loop.latch2
merge9:
  %t95 = load i8*, i8** %l6
  %s96 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1219235236, i32 0, i32 0
  %t97 = call i1 @starts_with(i8* %t95, i8* %s96)
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t100 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t101 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t102 = load double, double* %l4
  %t103 = load i8*, i8** %l5
  %t104 = load i8*, i8** %l6
  br i1 %t97, label %then10, label %merge11
then10:
  %t105 = load double, double* %l4
  %t106 = sitofp i64 1 to double
  %t107 = fadd double %t105, %t106
  store double %t107, double* %l4
  br label %loop.latch2
merge11:
  %t108 = load i8*, i8** %l6
  %s109 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h87749209, i32 0, i32 0
  %t110 = call i1 @starts_with(i8* %t108, i8* %s109)
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t113 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t114 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t115 = load double, double* %l4
  %t116 = load i8*, i8** %l5
  %t117 = load i8*, i8** %l6
  br i1 %t110, label %then12, label %merge13
then12:
  %t118 = load i8*, i8** %l6
  %s119 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t120 = call i8* @strip_prefix(i8* %t118, i8* %s119)
  store i8* %t120, i8** %l7
  %t121 = load i8*, i8** %l7
  %s122 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t123 = call i8* @strip_prefix(i8* %t121, i8* %s122)
  store i8* %t123, i8** %l8
  %t124 = load i8*, i8** %l8
  %t125 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t124)
  store %StructLayoutHeaderParse %t125, %StructLayoutHeaderParse* %l9
  %t126 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t127 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t128 = extractvalue %StructLayoutHeaderParse %t127, 4
  %t129 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t126, { i8**, i64 }* %t128)
  store { i8**, i64 }* %t129, { i8**, i64 }** %l1
  %t130 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t131 = extractvalue %StructLayoutHeaderParse %t130, 0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t134 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t135 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t136 = load double, double* %l4
  %t137 = load i8*, i8** %l5
  %t138 = load i8*, i8** %l6
  %t139 = load i8*, i8** %l7
  %t140 = load i8*, i8** %l8
  %t141 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t131, label %then14, label %merge15
then14:
  %t142 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t143 = ptrtoint [0 x %NativeStructLayoutField]* %t142 to i64
  %t144 = icmp eq i64 %t143, 0
  %t145 = select i1 %t144, i64 1, i64 %t143
  %t146 = call i8* @malloc(i64 %t145)
  %t147 = bitcast i8* %t146 to %NativeStructLayoutField*
  %t148 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t149 = ptrtoint { %NativeStructLayoutField*, i64 }* %t148 to i64
  %t150 = call i8* @malloc(i64 %t149)
  %t151 = bitcast i8* %t150 to { %NativeStructLayoutField*, i64 }*
  %t152 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t151, i32 0, i32 0
  store %NativeStructLayoutField* %t147, %NativeStructLayoutField** %t152
  %t153 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t151, i32 0, i32 1
  store i64 0, i64* %t153
  store { %NativeStructLayoutField*, i64 }* %t151, { %NativeStructLayoutField*, i64 }** %l10
  %t154 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t155 = extractvalue %StructLayoutHeaderParse %t154, 1
  store i8* %t155, i8** %l11
  %t156 = load double, double* %l4
  %t157 = sitofp i64 1 to double
  %t158 = fadd double %t156, %t157
  store double %t158, double* %l4
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t160 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t161 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t162 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t163 = load double, double* %l4
  %t164 = load i8*, i8** %l5
  %t165 = load i8*, i8** %l6
  %t166 = load i8*, i8** %l7
  %t167 = load i8*, i8** %l8
  %t168 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t169 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t170 = load i8*, i8** %l11
  br label %loop.header16
loop.header16:
  %t277 = phi i8* [ %t166, %then14 ], [ %t273, %loop.latch18 ]
  %t278 = phi { i8**, i64 }* [ %t160, %then14 ], [ %t274, %loop.latch18 ]
  %t279 = phi { %NativeStructLayoutField*, i64 }* [ %t169, %then14 ], [ %t275, %loop.latch18 ]
  %t280 = phi double [ %t163, %then14 ], [ %t276, %loop.latch18 ]
  store i8* %t277, i8** %l7
  store { i8**, i64 }* %t278, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t279, { %NativeStructLayoutField*, i64 }** %l10
  store double %t280, double* %l4
  br label %loop.body17
loop.body17:
  %t171 = load double, double* %l4
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t173 = load { i8**, i64 }, { i8**, i64 }* %t172
  %t174 = extractvalue { i8**, i64 } %t173, 1
  %t175 = sitofp i64 %t174 to double
  %t176 = fcmp oge double %t171, %t175
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t179 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t180 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t181 = load double, double* %l4
  %t182 = load i8*, i8** %l5
  %t183 = load i8*, i8** %l6
  %t184 = load i8*, i8** %l7
  %t185 = load i8*, i8** %l8
  %t186 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t187 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t188 = load i8*, i8** %l11
  br i1 %t176, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = load double, double* %l4
  %t191 = call double @llvm.round.f64(double %t190)
  %t192 = fptosi double %t191 to i64
  %t193 = load { i8**, i64 }, { i8**, i64 }* %t189
  %t194 = extractvalue { i8**, i64 } %t193, 0
  %t195 = extractvalue { i8**, i64 } %t193, 1
  %t196 = icmp uge i64 %t192, %t195
  ; bounds check: %t196 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t192, i64 %t195)
  %t197 = getelementptr i8*, i8** %t194, i64 %t192
  %t198 = load i8*, i8** %t197
  %t199 = call i8* @trim_text(i8* %t198)
  store i8* %t199, i8** %l12
  %t200 = load i8*, i8** %l12
  %t201 = call i64 @sailfin_runtime_string_length(i8* %t200)
  %t202 = icmp eq i64 %t201, 0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t205 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t206 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t207 = load double, double* %l4
  %t208 = load i8*, i8** %l5
  %t209 = load i8*, i8** %l6
  %t210 = load i8*, i8** %l7
  %t211 = load i8*, i8** %l8
  %t212 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t213 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t214 = load i8*, i8** %l11
  %t215 = load i8*, i8** %l12
  br i1 %t202, label %then22, label %merge23
then22:
  br label %afterloop19
merge23:
  %t216 = load i8*, i8** %l12
  %s217 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1053492670, i32 0, i32 0
  %t218 = call i1 @starts_with(i8* %t216, i8* %s217)
  %t219 = xor i1 %t218, 1
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t221 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t222 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t223 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t224 = load double, double* %l4
  %t225 = load i8*, i8** %l5
  %t226 = load i8*, i8** %l6
  %t227 = load i8*, i8** %l7
  %t228 = load i8*, i8** %l8
  %t229 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t230 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t231 = load i8*, i8** %l11
  %t232 = load i8*, i8** %l12
  br i1 %t219, label %then24, label %merge25
then24:
  br label %afterloop19
merge25:
  %t233 = load i8*, i8** %l12
  %s234 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t235 = call i8* @strip_prefix(i8* %t233, i8* %s234)
  store i8* %t235, i8** %l13
  %t236 = load i8*, i8** %l7
  %s237 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t238 = call i8* @strip_prefix(i8* %t236, i8* %s237)
  store i8* %t238, i8** %l14
  %t239 = load i8*, i8** %l14
  %t240 = load i8*, i8** %l11
  %t241 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t239, i8* %t240)
  store %StructLayoutFieldParse %t241, %StructLayoutFieldParse* %l15
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t243 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t244 = extractvalue %StructLayoutFieldParse %t243, 2
  %t245 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t242, { i8**, i64 }* %t244)
  store { i8**, i64 }* %t245, { i8**, i64 }** %l1
  %t246 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t247 = extractvalue %StructLayoutFieldParse %t246, 0
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t250 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t251 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t252 = load double, double* %l4
  %t253 = load i8*, i8** %l5
  %t254 = load i8*, i8** %l6
  %t255 = load i8*, i8** %l7
  %t256 = load i8*, i8** %l8
  %t257 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t258 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t259 = load i8*, i8** %l11
  %t260 = load i8*, i8** %l12
  %t261 = load i8*, i8** %l13
  %t262 = load i8*, i8** %l14
  %t263 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t247, label %then26, label %merge27
then26:
  %t264 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t265 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t266 = extractvalue %StructLayoutFieldParse %t265, 1
  %t267 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t264, %NativeStructLayoutField %t266)
  store { %NativeStructLayoutField*, i64 }* %t267, { %NativeStructLayoutField*, i64 }** %l10
  %t268 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge27
merge27:
  %t269 = phi { %NativeStructLayoutField*, i64 }* [ %t268, %then26 ], [ %t258, %merge25 ]
  store { %NativeStructLayoutField*, i64 }* %t269, { %NativeStructLayoutField*, i64 }** %l10
  %t270 = load double, double* %l4
  %t271 = sitofp i64 1 to double
  %t272 = fadd double %t270, %t271
  store double %t272, double* %l4
  br label %loop.latch18
loop.latch18:
  %t273 = load i8*, i8** %l7
  %t274 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t275 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t276 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t281 = load i8*, i8** %l7
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t283 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t284 = load double, double* %l4
  %t285 = load i8*, i8** %l11
  %t286 = insertvalue %NativeStruct undef, i8* %t285, 0
  %t287 = getelementptr [0 x %NativeStructField*], [0 x %NativeStructField*]* null, i32 1
  %t288 = ptrtoint [0 x %NativeStructField*]* %t287 to i64
  %t289 = icmp eq i64 %t288, 0
  %t290 = select i1 %t289, i64 1, i64 %t288
  %t291 = call i8* @malloc(i64 %t290)
  %t292 = bitcast i8* %t291 to %NativeStructField**
  %t293 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* null, i32 1
  %t294 = ptrtoint { %NativeStructField**, i64 }* %t293 to i64
  %t295 = call i8* @malloc(i64 %t294)
  %t296 = bitcast i8* %t295 to { %NativeStructField**, i64 }*
  %t297 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t296, i32 0, i32 0
  store %NativeStructField** %t292, %NativeStructField*** %t297
  %t298 = getelementptr { %NativeStructField**, i64 }, { %NativeStructField**, i64 }* %t296, i32 0, i32 1
  store i64 0, i64* %t298
  %t299 = insertvalue %NativeStruct %t286, { %NativeStructField**, i64 }* %t296, 1
  %t300 = getelementptr [0 x %NativeFunction*], [0 x %NativeFunction*]* null, i32 1
  %t301 = ptrtoint [0 x %NativeFunction*]* %t300 to i64
  %t302 = icmp eq i64 %t301, 0
  %t303 = select i1 %t302, i64 1, i64 %t301
  %t304 = call i8* @malloc(i64 %t303)
  %t305 = bitcast i8* %t304 to %NativeFunction**
  %t306 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* null, i32 1
  %t307 = ptrtoint { %NativeFunction**, i64 }* %t306 to i64
  %t308 = call i8* @malloc(i64 %t307)
  %t309 = bitcast i8* %t308 to { %NativeFunction**, i64 }*
  %t310 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t309, i32 0, i32 0
  store %NativeFunction** %t305, %NativeFunction*** %t310
  %t311 = getelementptr { %NativeFunction**, i64 }, { %NativeFunction**, i64 }* %t309, i32 0, i32 1
  store i64 0, i64* %t311
  %t312 = insertvalue %NativeStruct %t299, { %NativeFunction**, i64 }* %t309, 2
  %t313 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t314 = ptrtoint [0 x i8*]* %t313 to i64
  %t315 = icmp eq i64 %t314, 0
  %t316 = select i1 %t315, i64 1, i64 %t314
  %t317 = call i8* @malloc(i64 %t316)
  %t318 = bitcast i8* %t317 to i8**
  %t319 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t320 = ptrtoint { i8**, i64 }* %t319 to i64
  %t321 = call i8* @malloc(i64 %t320)
  %t322 = bitcast i8* %t321 to { i8**, i64 }*
  %t323 = getelementptr { i8**, i64 }, { i8**, i64 }* %t322, i32 0, i32 0
  store i8** %t318, i8*** %t323
  %t324 = getelementptr { i8**, i64 }, { i8**, i64 }* %t322, i32 0, i32 1
  store i64 0, i64* %t324
  %t325 = insertvalue %NativeStruct %t312, { i8**, i64 }* %t322, 3
  %t326 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t327 = extractvalue %StructLayoutHeaderParse %t326, 2
  %t328 = insertvalue %NativeStructLayout undef, double %t327, 0
  %t329 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t330 = extractvalue %StructLayoutHeaderParse %t329, 3
  %t331 = insertvalue %NativeStructLayout %t328, double %t330, 1
  %t332 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t333 = bitcast { %NativeStructLayoutField*, i64 }* %t332 to { %NativeStructLayoutField**, i64 }*
  %t334 = insertvalue %NativeStructLayout %t331, { %NativeStructLayoutField**, i64 }* %t333, 2
  %t335 = alloca %NativeStructLayout
  store %NativeStructLayout %t334, %NativeStructLayout* %t335
  %t336 = insertvalue %NativeStruct %t325, %NativeStructLayout* %t335, 4
  store %NativeStruct %t336, %NativeStruct* %l16
  %t337 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t338 = load %NativeStruct, %NativeStruct* %l16
  %t339 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t337, %NativeStruct %t338)
  store { %NativeStruct*, i64 }* %t339, { %NativeStruct*, i64 }** %l2
  %t340 = load double, double* %l4
  %t341 = load i8*, i8** %l7
  %t342 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t343 = load double, double* %l4
  %t344 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  br label %merge15
merge15:
  %t345 = phi double [ %t340, %afterloop19 ], [ %t136, %then12 ]
  %t346 = phi i8* [ %t341, %afterloop19 ], [ %t139, %then12 ]
  %t347 = phi { i8**, i64 }* [ %t342, %afterloop19 ], [ %t133, %then12 ]
  %t348 = phi double [ %t343, %afterloop19 ], [ %t136, %then12 ]
  %t349 = phi { %NativeStruct*, i64 }* [ %t344, %afterloop19 ], [ %t134, %then12 ]
  store double %t345, double* %l4
  store i8* %t346, i8** %l7
  store { i8**, i64 }* %t347, { i8**, i64 }** %l1
  store double %t348, double* %l4
  store { %NativeStruct*, i64 }* %t349, { %NativeStruct*, i64 }** %l2
  %t350 = load double, double* %l4
  %t351 = sitofp i64 1 to double
  %t352 = fadd double %t350, %t351
  store double %t352, double* %l4
  br label %loop.latch2
merge13:
  %t353 = load i8*, i8** %l6
  %s354 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h259593098, i32 0, i32 0
  %t355 = call i1 @starts_with(i8* %t353, i8* %s354)
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t358 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t359 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t360 = load double, double* %l4
  %t361 = load i8*, i8** %l5
  %t362 = load i8*, i8** %l6
  br i1 %t355, label %then28, label %merge29
then28:
  %t363 = load i8*, i8** %l6
  %s364 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t365 = call i8* @strip_prefix(i8* %t363, i8* %s364)
  store i8* %t365, i8** %l17
  %t366 = load i8*, i8** %l17
  %s367 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t368 = call i8* @strip_prefix(i8* %t366, i8* %s367)
  store i8* %t368, i8** %l18
  %t369 = load i8*, i8** %l18
  %t370 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t369)
  store %EnumLayoutHeaderParse %t370, %EnumLayoutHeaderParse* %l19
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t372 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t373 = extractvalue %EnumLayoutHeaderParse %t372, 7
  %t374 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t371, { i8**, i64 }* %t373)
  store { i8**, i64 }* %t374, { i8**, i64 }** %l1
  %t375 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t376 = extractvalue %EnumLayoutHeaderParse %t375, 0
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t379 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t380 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t381 = load double, double* %l4
  %t382 = load i8*, i8** %l5
  %t383 = load i8*, i8** %l6
  %t384 = load i8*, i8** %l17
  %t385 = load i8*, i8** %l18
  %t386 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t376, label %then30, label %else31
then30:
  %t387 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t388 = ptrtoint [0 x %NativeEnumVariantLayout]* %t387 to i64
  %t389 = icmp eq i64 %t388, 0
  %t390 = select i1 %t389, i64 1, i64 %t388
  %t391 = call i8* @malloc(i64 %t390)
  %t392 = bitcast i8* %t391 to %NativeEnumVariantLayout*
  %t393 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t394 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t393 to i64
  %t395 = call i8* @malloc(i64 %t394)
  %t396 = bitcast i8* %t395 to { %NativeEnumVariantLayout*, i64 }*
  %t397 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t396, i32 0, i32 0
  store %NativeEnumVariantLayout* %t392, %NativeEnumVariantLayout** %t397
  %t398 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t396, i32 0, i32 1
  store i64 0, i64* %t398
  store { %NativeEnumVariantLayout*, i64 }* %t396, { %NativeEnumVariantLayout*, i64 }** %l20
  %t399 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t400 = extractvalue %EnumLayoutHeaderParse %t399, 1
  store i8* %t400, i8** %l21
  %t401 = load double, double* %l4
  %t402 = sitofp i64 1 to double
  %t403 = fadd double %t401, %t402
  store double %t403, double* %l4
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t406 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t407 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t408 = load double, double* %l4
  %t409 = load i8*, i8** %l5
  %t410 = load i8*, i8** %l6
  %t411 = load i8*, i8** %l17
  %t412 = load i8*, i8** %l18
  %t413 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t414 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t415 = load i8*, i8** %l21
  br label %loop.header33
loop.header33:
  %t653 = phi double [ %t408, %then30 ], [ %t649, %loop.latch35 ]
  %t654 = phi i8* [ %t411, %then30 ], [ %t650, %loop.latch35 ]
  %t655 = phi { i8**, i64 }* [ %t405, %then30 ], [ %t651, %loop.latch35 ]
  %t656 = phi { %NativeEnumVariantLayout*, i64 }* [ %t414, %then30 ], [ %t652, %loop.latch35 ]
  store double %t653, double* %l4
  store i8* %t654, i8** %l17
  store { i8**, i64 }* %t655, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t656, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body34
loop.body34:
  %t416 = load double, double* %l4
  %t417 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t418 = load { i8**, i64 }, { i8**, i64 }* %t417
  %t419 = extractvalue { i8**, i64 } %t418, 1
  %t420 = sitofp i64 %t419 to double
  %t421 = fcmp oge double %t416, %t420
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t424 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t425 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t426 = load double, double* %l4
  %t427 = load i8*, i8** %l5
  %t428 = load i8*, i8** %l6
  %t429 = load i8*, i8** %l17
  %t430 = load i8*, i8** %l18
  %t431 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t432 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t433 = load i8*, i8** %l21
  br i1 %t421, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t434 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t435 = load double, double* %l4
  %t436 = call double @llvm.round.f64(double %t435)
  %t437 = fptosi double %t436 to i64
  %t438 = load { i8**, i64 }, { i8**, i64 }* %t434
  %t439 = extractvalue { i8**, i64 } %t438, 0
  %t440 = extractvalue { i8**, i64 } %t438, 1
  %t441 = icmp uge i64 %t437, %t440
  ; bounds check: %t441 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t437, i64 %t440)
  %t442 = getelementptr i8*, i8** %t439, i64 %t437
  %t443 = load i8*, i8** %t442
  %t444 = call i8* @trim_text(i8* %t443)
  store i8* %t444, i8** %l22
  %t445 = load i8*, i8** %l22
  %t446 = call i64 @sailfin_runtime_string_length(i8* %t445)
  %t447 = icmp eq i64 %t446, 0
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t450 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t451 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t452 = load double, double* %l4
  %t453 = load i8*, i8** %l5
  %t454 = load i8*, i8** %l6
  %t455 = load i8*, i8** %l17
  %t456 = load i8*, i8** %l18
  %t457 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t458 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t459 = load i8*, i8** %l21
  %t460 = load i8*, i8** %l22
  br i1 %t447, label %then39, label %merge40
then39:
  %t461 = load double, double* %l4
  %t462 = sitofp i64 1 to double
  %t463 = fadd double %t461, %t462
  store double %t463, double* %l4
  br label %afterloop36
merge40:
  %t465 = load i8*, i8** %l22
  %s466 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t467 = call i1 @starts_with(i8* %t465, i8* %s466)
  br label %logical_and_entry_464

logical_and_entry_464:
  br i1 %t467, label %logical_and_right_464, label %logical_and_merge_464

logical_and_right_464:
  %t468 = load i8*, i8** %l22
  %s469 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t470 = call i1 @starts_with(i8* %t468, i8* %s469)
  %t471 = xor i1 %t470, 1
  br label %logical_and_right_end_464

logical_and_right_end_464:
  br label %logical_and_merge_464

logical_and_merge_464:
  %t472 = phi i1 [ false, %logical_and_entry_464 ], [ %t471, %logical_and_right_end_464 ]
  %t473 = xor i1 %t472, 1
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t476 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t477 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t478 = load double, double* %l4
  %t479 = load i8*, i8** %l5
  %t480 = load i8*, i8** %l6
  %t481 = load i8*, i8** %l17
  %t482 = load i8*, i8** %l18
  %t483 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t484 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t485 = load i8*, i8** %l21
  %t486 = load i8*, i8** %l22
  br i1 %t473, label %then41, label %merge42
then41:
  br label %afterloop36
merge42:
  %t487 = load i8*, i8** %l22
  %s488 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t489 = call i1 @starts_with(i8* %t487, i8* %s488)
  %t490 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t491 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t492 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t493 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t494 = load double, double* %l4
  %t495 = load i8*, i8** %l5
  %t496 = load i8*, i8** %l6
  %t497 = load i8*, i8** %l17
  %t498 = load i8*, i8** %l18
  %t499 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t500 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t501 = load i8*, i8** %l21
  %t502 = load i8*, i8** %l22
  br i1 %t489, label %then43, label %else44
then43:
  %t503 = load i8*, i8** %l22
  %s504 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t505 = call i8* @strip_prefix(i8* %t503, i8* %s504)
  store i8* %t505, i8** %l23
  %t506 = load i8*, i8** %l17
  %s507 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t508 = call i8* @strip_prefix(i8* %t506, i8* %s507)
  store i8* %t508, i8** %l24
  %t509 = load i8*, i8** %l24
  %t510 = load i8*, i8** %l21
  %t511 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t509, i8* %t510)
  store %EnumLayoutVariantParse %t511, %EnumLayoutVariantParse* %l25
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t513 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t514 = extractvalue %EnumLayoutVariantParse %t513, 2
  %t515 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t512, { i8**, i64 }* %t514)
  store { i8**, i64 }* %t515, { i8**, i64 }** %l1
  %t516 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t517 = extractvalue %EnumLayoutVariantParse %t516, 0
  %t518 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t519 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t520 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t521 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t522 = load double, double* %l4
  %t523 = load i8*, i8** %l5
  %t524 = load i8*, i8** %l6
  %t525 = load i8*, i8** %l17
  %t526 = load i8*, i8** %l18
  %t527 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t528 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t529 = load i8*, i8** %l21
  %t530 = load i8*, i8** %l22
  %t531 = load i8*, i8** %l23
  %t532 = load i8*, i8** %l24
  %t533 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t517, label %then46, label %merge47
then46:
  %t534 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t535 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t536 = extractvalue %EnumLayoutVariantParse %t535, 1
  %t537 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t534, %NativeEnumVariantLayout %t536)
  store { %NativeEnumVariantLayout*, i64 }* %t537, { %NativeEnumVariantLayout*, i64 }** %l20
  %t538 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge47
merge47:
  %t539 = phi { %NativeEnumVariantLayout*, i64 }* [ %t538, %then46 ], [ %t528, %then43 ]
  store { %NativeEnumVariantLayout*, i64 }* %t539, { %NativeEnumVariantLayout*, i64 }** %l20
  %t540 = load i8*, i8** %l17
  %t541 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t542 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge45
else44:
  %t543 = load i8*, i8** %l22
  %s544 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t545 = call i1 @starts_with(i8* %t543, i8* %s544)
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t548 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t549 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t550 = load double, double* %l4
  %t551 = load i8*, i8** %l5
  %t552 = load i8*, i8** %l6
  %t553 = load i8*, i8** %l17
  %t554 = load i8*, i8** %l18
  %t555 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t556 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t557 = load i8*, i8** %l21
  %t558 = load i8*, i8** %l22
  br i1 %t545, label %then48, label %merge49
then48:
  %t559 = load i8*, i8** %l22
  %s560 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t561 = call i8* @strip_prefix(i8* %t559, i8* %s560)
  store i8* %t561, i8** %l26
  %t562 = load i8*, i8** %l17
  %s563 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t564 = call i8* @strip_prefix(i8* %t562, i8* %s563)
  store i8* %t564, i8** %l27
  %t565 = load i8*, i8** %l27
  %t566 = load i8*, i8** %l21
  %t567 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t565, i8* %t566)
  store %EnumLayoutPayloadParse %t567, %EnumLayoutPayloadParse* %l28
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t569 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t570 = extractvalue %EnumLayoutPayloadParse %t569, 3
  %t571 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t568, { i8**, i64 }* %t570)
  store { i8**, i64 }* %t571, { i8**, i64 }** %l1
  %t573 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t574 = extractvalue %EnumLayoutPayloadParse %t573, 0
  br label %logical_and_entry_572

logical_and_entry_572:
  br i1 %t574, label %logical_and_right_572, label %logical_and_merge_572

logical_and_right_572:
  %t575 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t576 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t575
  %t577 = extractvalue { %NativeEnumVariantLayout*, i64 } %t576, 1
  %t578 = icmp sgt i64 %t577, 0
  br label %logical_and_right_end_572

logical_and_right_end_572:
  br label %logical_and_merge_572

logical_and_merge_572:
  %t579 = phi i1 [ false, %logical_and_entry_572 ], [ %t578, %logical_and_right_end_572 ]
  %t580 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t582 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t583 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t584 = load double, double* %l4
  %t585 = load i8*, i8** %l5
  %t586 = load i8*, i8** %l6
  %t587 = load i8*, i8** %l17
  %t588 = load i8*, i8** %l18
  %t589 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t590 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t591 = load i8*, i8** %l21
  %t592 = load i8*, i8** %l22
  %t593 = load i8*, i8** %l26
  %t594 = load i8*, i8** %l27
  %t595 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t579, label %then50, label %merge51
then50:
  %t596 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t597 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t596
  %t598 = extractvalue { %NativeEnumVariantLayout*, i64 } %t597, 1
  %t599 = sub i64 %t598, 1
  store i64 %t599, i64* %l29
  %t600 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t601 = load i64, i64* %l29
  %t602 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t600
  %t603 = extractvalue { %NativeEnumVariantLayout*, i64 } %t602, 0
  %t604 = extractvalue { %NativeEnumVariantLayout*, i64 } %t602, 1
  %t605 = icmp uge i64 %t601, %t604
  ; bounds check: %t605 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t601, i64 %t604)
  %t606 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t603, i64 %t601
  %t607 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t606
  store %NativeEnumVariantLayout %t607, %NativeEnumVariantLayout* %l30
  %t608 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t609 = extractvalue %NativeEnumVariantLayout %t608, 5
  %t610 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t611 = extractvalue %EnumLayoutPayloadParse %t610, 2
  %t612 = bitcast { %NativeStructLayoutField**, i64 }* %t609 to { %NativeStructLayoutField*, i64 }*
  %t613 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t612, %NativeStructLayoutField %t611)
  store { %NativeStructLayoutField*, i64 }* %t613, { %NativeStructLayoutField*, i64 }** %l31
  %t614 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t615 = extractvalue %NativeEnumVariantLayout %t614, 0
  %t616 = insertvalue %NativeEnumVariantLayout undef, i8* %t615, 0
  %t617 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t618 = extractvalue %NativeEnumVariantLayout %t617, 1
  %t619 = insertvalue %NativeEnumVariantLayout %t616, double %t618, 1
  %t620 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t621 = extractvalue %NativeEnumVariantLayout %t620, 2
  %t622 = insertvalue %NativeEnumVariantLayout %t619, double %t621, 2
  %t623 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t624 = extractvalue %NativeEnumVariantLayout %t623, 3
  %t625 = insertvalue %NativeEnumVariantLayout %t622, double %t624, 3
  %t626 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t627 = extractvalue %NativeEnumVariantLayout %t626, 4
  %t628 = insertvalue %NativeEnumVariantLayout %t625, double %t627, 4
  %t629 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l31
  %t630 = bitcast { %NativeStructLayoutField*, i64 }* %t629 to { %NativeStructLayoutField**, i64 }*
  %t631 = insertvalue %NativeEnumVariantLayout %t628, { %NativeStructLayoutField**, i64 }* %t630, 5
  %t632 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t633 = load i64, i64* %l29
  %t634 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t632, i32 0, i32 0
  %t636 = load %NativeEnumVariantLayout*, %NativeEnumVariantLayout** %t634
  %t635 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t636, i64 %t633
  store %NativeEnumVariantLayout %t631, %NativeEnumVariantLayout* %t635
  br label %merge51
merge51:
  %t637 = load i8*, i8** %l17
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge49
merge49:
  %t639 = phi i8* [ %t637, %merge51 ], [ %t553, %else44 ]
  %t640 = phi { i8**, i64 }* [ %t638, %merge51 ], [ %t547, %else44 ]
  store i8* %t639, i8** %l17
  store { i8**, i64 }* %t640, { i8**, i64 }** %l1
  %t641 = load i8*, i8** %l17
  %t642 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t643 = phi i8* [ %t540, %merge47 ], [ %t641, %merge49 ]
  %t644 = phi { i8**, i64 }* [ %t541, %merge47 ], [ %t642, %merge49 ]
  %t645 = phi { %NativeEnumVariantLayout*, i64 }* [ %t542, %merge47 ], [ %t500, %merge49 ]
  store i8* %t643, i8** %l17
  store { i8**, i64 }* %t644, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t645, { %NativeEnumVariantLayout*, i64 }** %l20
  %t646 = load double, double* %l4
  %t647 = sitofp i64 1 to double
  %t648 = fadd double %t646, %t647
  store double %t648, double* %l4
  br label %loop.latch35
loop.latch35:
  %t649 = load double, double* %l4
  %t650 = load i8*, i8** %l17
  %t651 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t652 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header33
afterloop36:
  %t657 = load double, double* %l4
  %t658 = load i8*, i8** %l17
  %t659 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t660 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t661 = load i8*, i8** %l21
  %t662 = insertvalue %NativeEnum undef, i8* %t661, 0
  %t663 = getelementptr [0 x %NativeEnumVariant*], [0 x %NativeEnumVariant*]* null, i32 1
  %t664 = ptrtoint [0 x %NativeEnumVariant*]* %t663 to i64
  %t665 = icmp eq i64 %t664, 0
  %t666 = select i1 %t665, i64 1, i64 %t664
  %t667 = call i8* @malloc(i64 %t666)
  %t668 = bitcast i8* %t667 to %NativeEnumVariant**
  %t669 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* null, i32 1
  %t670 = ptrtoint { %NativeEnumVariant**, i64 }* %t669 to i64
  %t671 = call i8* @malloc(i64 %t670)
  %t672 = bitcast i8* %t671 to { %NativeEnumVariant**, i64 }*
  %t673 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t672, i32 0, i32 0
  store %NativeEnumVariant** %t668, %NativeEnumVariant*** %t673
  %t674 = getelementptr { %NativeEnumVariant**, i64 }, { %NativeEnumVariant**, i64 }* %t672, i32 0, i32 1
  store i64 0, i64* %t674
  %t675 = insertvalue %NativeEnum %t662, { %NativeEnumVariant**, i64 }* %t672, 1
  %t676 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t677 = extractvalue %EnumLayoutHeaderParse %t676, 2
  %t678 = insertvalue %NativeEnumLayout undef, double %t677, 0
  %t679 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t680 = extractvalue %EnumLayoutHeaderParse %t679, 3
  %t681 = insertvalue %NativeEnumLayout %t678, double %t680, 1
  %t682 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t683 = extractvalue %EnumLayoutHeaderParse %t682, 4
  %t684 = insertvalue %NativeEnumLayout %t681, i8* %t683, 2
  %t685 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t686 = extractvalue %EnumLayoutHeaderParse %t685, 5
  %t687 = insertvalue %NativeEnumLayout %t684, double %t686, 3
  %t688 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t689 = extractvalue %EnumLayoutHeaderParse %t688, 6
  %t690 = insertvalue %NativeEnumLayout %t687, double %t689, 4
  %t691 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t692 = bitcast { %NativeEnumVariantLayout*, i64 }* %t691 to { %NativeEnumVariantLayout**, i64 }*
  %t693 = insertvalue %NativeEnumLayout %t690, { %NativeEnumVariantLayout**, i64 }* %t692, 5
  %t694 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t693, %NativeEnumLayout* %t694
  %t695 = insertvalue %NativeEnum %t675, %NativeEnumLayout* %t694, 2
  store %NativeEnum %t695, %NativeEnum* %l32
  %t696 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t697 = load %NativeEnum, %NativeEnum* %l32
  %t698 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t696, %NativeEnum %t697)
  store { %NativeEnum*, i64 }* %t698, { %NativeEnum*, i64 }** %l3
  %t699 = load double, double* %l4
  %t700 = load double, double* %l4
  %t701 = load i8*, i8** %l17
  %t702 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t703 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %merge32
else31:
  %t704 = load double, double* %l4
  %t705 = sitofp i64 1 to double
  %t706 = fadd double %t704, %t705
  store double %t706, double* %l4
  %t707 = load double, double* %l4
  br label %merge32
merge32:
  %t708 = phi double [ %t699, %afterloop36 ], [ %t707, %else31 ]
  %t709 = phi i8* [ %t701, %afterloop36 ], [ %t384, %else31 ]
  %t710 = phi { i8**, i64 }* [ %t702, %afterloop36 ], [ %t378, %else31 ]
  %t711 = phi { %NativeEnum*, i64 }* [ %t703, %afterloop36 ], [ %t380, %else31 ]
  store double %t708, double* %l4
  store i8* %t709, i8** %l17
  store { i8**, i64 }* %t710, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t711, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge29:
  %t712 = load double, double* %l4
  %t713 = sitofp i64 1 to double
  %t714 = fadd double %t712, %t713
  store double %t714, double* %l4
  br label %loop.latch2
loop.latch2:
  %t715 = load double, double* %l4
  %t716 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t717 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t718 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t723 = load double, double* %l4
  %t724 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t725 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t726 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t727 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t728 = bitcast { %NativeStruct*, i64 }* %t727 to { %NativeStruct**, i64 }*
  %t729 = insertvalue %LayoutManifest undef, { %NativeStruct**, i64 }* %t728, 0
  %t730 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t731 = bitcast { %NativeEnum*, i64 }* %t730 to { %NativeEnum**, i64 }*
  %t732 = insertvalue %LayoutManifest %t729, { %NativeEnum**, i64 }* %t731, 1
  %t733 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t734 = insertvalue %LayoutManifest %t732, { i8**, i64 }* %t733, 2
  ret %LayoutManifest %t734
}

define i1 @is_trim_char(i8* %ch) {
block.entry:
  %t1 = load i8, i8* %ch
  %t2 = icmp eq i8 %t1, 32
  br label %logical_or_entry_0

logical_or_entry_0:
  br i1 %t2, label %logical_or_merge_0, label %logical_or_right_0

logical_or_right_0:
  %t4 = load i8, i8* %ch
  %t5 = icmp eq i8 %t4, 10
  br label %logical_or_entry_3

logical_or_entry_3:
  br i1 %t5, label %logical_or_merge_3, label %logical_or_right_3

logical_or_right_3:
  %t7 = load i8, i8* %ch
  %t8 = icmp eq i8 %t7, 13
  br label %logical_or_entry_6

logical_or_entry_6:
  br i1 %t8, label %logical_or_merge_6, label %logical_or_right_6

logical_or_right_6:
  %t9 = load i8, i8* %ch
  %t10 = icmp eq i8 %t9, 9
  br label %logical_or_right_end_6

logical_or_right_end_6:
  br label %logical_or_merge_6

logical_or_merge_6:
  %t11 = phi i1 [ true, %logical_or_entry_6 ], [ %t10, %logical_or_right_end_6 ]
  br label %logical_or_right_end_3

logical_or_right_end_3:
  br label %logical_or_merge_3

logical_or_merge_3:
  %t12 = phi i1 [ true, %logical_or_entry_3 ], [ %t11, %logical_or_right_end_3 ]
  br label %logical_or_right_end_0

logical_or_right_end_0:
  br label %logical_or_merge_0

logical_or_merge_0:
  %t13 = phi i1 [ true, %logical_or_entry_0 ], [ %t12, %logical_or_right_end_0 ]
  ret i1 %t13
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

define i8* @strip_prefix(i8* %value, i8* %prefix) {
block.entry:
  %t0 = call i1 @starts_with(i8* %value, i8* %prefix)
  %t1 = xor i1 %t0, 1
  br i1 %t1, label %then0, label %merge1
then0:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge1:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %prefix)
  %t3 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t4 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t2, i64 %t3)
  call void @sailfin_runtime_mark_persistent(i8* %t4)
  ret i8* %t4
}

define double @index_of(i8* %value, i8* %target) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
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
  %t58 = phi double [ %t4, %merge1 ], [ %t57, %loop.latch4 ]
  store double %t58, double* %l0
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
  %t45 = phi i1 [ %t16, %merge7 ], [ %t43, %loop.latch10 ]
  %t46 = phi double [ %t15, %merge7 ], [ %t44, %loop.latch10 ]
  store i1 %t45, i1* %l2
  store double %t46, double* %l1
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
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = getelementptr i8, i8* %value, i64 %t28
  %t30 = load i8, i8* %t29
  %t31 = load double, double* %l1
  %t32 = call double @llvm.round.f64(double %t31)
  %t33 = fptosi double %t32 to i64
  %t34 = getelementptr i8, i8* %target, i64 %t33
  %t35 = load i8, i8* %t34
  %t36 = icmp ne i8 %t30, %t35
  %t37 = load double, double* %l0
  %t38 = load double, double* %l1
  %t39 = load i1, i1* %l2
  br i1 %t36, label %then14, label %merge15
then14:
  store i1 0, i1* %l2
  br label %afterloop11
merge15:
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch10
loop.latch10:
  %t43 = load i1, i1* %l2
  %t44 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t47 = load i1, i1* %l2
  %t48 = load double, double* %l1
  %t49 = load i1, i1* %l2
  %t50 = load double, double* %l0
  %t51 = load double, double* %l1
  %t52 = load i1, i1* %l2
  br i1 %t49, label %then16, label %merge17
then16:
  %t53 = load double, double* %l0
  ret double %t53
merge17:
  %t54 = load double, double* %l0
  %t55 = sitofp i64 1 to double
  %t56 = fadd double %t54, %t55
  store double %t56, double* %l0
  br label %loop.latch4
loop.latch4:
  %t57 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t59 = load double, double* %l0
  %t60 = sitofp i64 -1 to double
  ret double %t60
}

define double @last_index_of(i8* %value, i8* %target) {
block.entry:
  %l0 = alloca double
  %l1 = alloca double
  %l2 = alloca i1
  %t0 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t3 = sitofp i64 %t2 to double
  ret double %t3
merge1:
  %t4 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t5 = call i64 @sailfin_runtime_string_length(i8* %target)
  %t6 = sub i64 %t4, %t5
  %t7 = sitofp i64 %t6 to double
  store double %t7, double* %l0
  %t8 = load double, double* %l0
  br label %loop.header2
loop.header2:
  %t58 = phi double [ %t8, %merge1 ], [ %t57, %loop.latch4 ]
  store double %t58, double* %l0
  br label %loop.body3
loop.body3:
  %t9 = load double, double* %l0
  %t10 = sitofp i64 0 to double
  %t11 = fcmp olt double %t9, %t10
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
  %t45 = phi i1 [ %t16, %merge7 ], [ %t43, %loop.latch10 ]
  %t46 = phi double [ %t15, %merge7 ], [ %t44, %loop.latch10 ]
  store i1 %t45, i1* %l2
  store double %t46, double* %l1
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
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = getelementptr i8, i8* %value, i64 %t28
  %t30 = load i8, i8* %t29
  %t31 = load double, double* %l1
  %t32 = call double @llvm.round.f64(double %t31)
  %t33 = fptosi double %t32 to i64
  %t34 = getelementptr i8, i8* %target, i64 %t33
  %t35 = load i8, i8* %t34
  %t36 = icmp ne i8 %t30, %t35
  %t37 = load double, double* %l0
  %t38 = load double, double* %l1
  %t39 = load i1, i1* %l2
  br i1 %t36, label %then14, label %merge15
then14:
  store i1 0, i1* %l2
  br label %afterloop11
merge15:
  %t40 = load double, double* %l1
  %t41 = sitofp i64 1 to double
  %t42 = fadd double %t40, %t41
  store double %t42, double* %l1
  br label %loop.latch10
loop.latch10:
  %t43 = load i1, i1* %l2
  %t44 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t47 = load i1, i1* %l2
  %t48 = load double, double* %l1
  %t49 = load i1, i1* %l2
  %t50 = load double, double* %l0
  %t51 = load double, double* %l1
  %t52 = load i1, i1* %l2
  br i1 %t49, label %then16, label %merge17
then16:
  %t53 = load double, double* %l0
  ret double %t53
merge17:
  %t54 = load double, double* %l0
  %t55 = sitofp i64 1 to double
  %t56 = fsub double %t54, %t55
  store double %t56, double* %l0
  br label %loop.latch4
loop.latch4:
  %t57 = load double, double* %l0
  br label %loop.header2
afterloop5:
  %t59 = load double, double* %l0
  %t60 = sitofp i64 -1 to double
  ret double %t60
}

define i8* @strip_quotes(i8* %value) {
block.entry:
  %l0 = alloca i8
  %l1 = alloca i8
  %l2 = alloca i1
  %l3 = alloca i1
  %t0 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t1 = icmp sge i64 %t0, 2
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = getelementptr i8, i8* %value, i64 0
  %t3 = load i8, i8* %t2
  store i8 %t3, i8* %l0
  %t4 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t5 = sub i64 %t4, 1
  %t6 = getelementptr i8, i8* %value, i64 %t5
  %t7 = load i8, i8* %t6
  store i8 %t7, i8* %l1
  %t9 = load i8, i8* %l0
  %t10 = icmp eq i8 %t9, 34
  br label %logical_and_entry_8

logical_and_entry_8:
  br i1 %t10, label %logical_and_right_8, label %logical_and_merge_8

logical_and_right_8:
  %t11 = load i8, i8* %l1
  %t12 = icmp eq i8 %t11, 34
  br label %logical_and_right_end_8

logical_and_right_end_8:
  br label %logical_and_merge_8

logical_and_merge_8:
  %t13 = phi i1 [ false, %logical_and_entry_8 ], [ %t12, %logical_and_right_end_8 ]
  store i1 %t13, i1* %l2
  %t15 = load i8, i8* %l0
  %t16 = icmp eq i8 %t15, 39
  br label %logical_and_entry_14

logical_and_entry_14:
  br i1 %t16, label %logical_and_right_14, label %logical_and_merge_14

logical_and_right_14:
  %t17 = load i8, i8* %l1
  %t18 = icmp eq i8 %t17, 39
  br label %logical_and_right_end_14

logical_and_right_end_14:
  br label %logical_and_merge_14

logical_and_merge_14:
  %t19 = phi i1 [ false, %logical_and_entry_14 ], [ %t18, %logical_and_right_end_14 ]
  store i1 %t19, i1* %l3
  %t21 = load i1, i1* %l2
  br label %logical_or_entry_20

logical_or_entry_20:
  br i1 %t21, label %logical_or_merge_20, label %logical_or_right_20

logical_or_right_20:
  %t22 = load i1, i1* %l3
  br label %logical_or_right_end_20

logical_or_right_end_20:
  br label %logical_or_merge_20

logical_or_merge_20:
  %t23 = phi i1 [ true, %logical_or_entry_20 ], [ %t22, %logical_or_right_end_20 ]
  %t24 = load i8, i8* %l0
  %t25 = load i8, i8* %l1
  %t26 = load i1, i1* %l2
  %t27 = load i1, i1* %l3
  br i1 %t23, label %then2, label %merge3
then2:
  %t28 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t29 = sub i64 %t28, 1
  %t30 = call i8* @sailfin_runtime_substring(i8* %value, i64 1, i64 %t29)
  call void @sailfin_runtime_mark_persistent(i8* %t30)
  ret i8* %t30
merge3:
  br label %merge1
merge1:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
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

define { i8**, i64 }* @split_text(i8* %value, i8* %delimiter) {
block.entry:
  %l0 = alloca { i8**, i64 }*
  %l1 = alloca double
  %l2 = alloca double
  %l3 = alloca double
  %l4 = alloca double
  %t0 = call i64 @sailfin_runtime_string_length(i8* %delimiter)
  %t1 = icmp eq i64 %t0, 0
  br i1 %t1, label %then0, label %merge1
then0:
  %t2 = getelementptr [1 x i8*], [1 x i8*]* null, i32 1
  %t3 = ptrtoint [1 x i8*]* %t2 to i64
  %t4 = icmp eq i64 %t3, 0
  %t5 = select i1 %t4, i64 1, i64 %t3
  %t6 = call i8* @malloc(i64 %t5)
  %t7 = bitcast i8* %t6 to i8**
  %t8 = getelementptr i8*, i8** %t7, i64 0
  store i8* %value, i8** %t8
  %t9 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t10 = ptrtoint { i8**, i64 }* %t9 to i64
  %t11 = call i8* @malloc(i64 %t10)
  %t12 = bitcast i8* %t11 to { i8**, i64 }*
  %t13 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 0
  store i8** %t7, i8*** %t13
  %t14 = getelementptr { i8**, i64 }, { i8**, i64 }* %t12, i32 0, i32 1
  store i64 1, i64* %t14
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
  %t28 = sitofp i64 0 to double
  store double %t28, double* %l2
  %t29 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t30 = load double, double* %l1
  %t31 = load double, double* %l2
  br label %loop.header2
loop.header2:
  %t72 = phi { i8**, i64 }* [ %t29, %merge1 ], [ %t69, %loop.latch4 ]
  %t73 = phi double [ %t30, %merge1 ], [ %t70, %loop.latch4 ]
  %t74 = phi double [ %t31, %merge1 ], [ %t71, %loop.latch4 ]
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  store double %t73, double* %l1
  store double %t74, double* %l2
  br label %loop.body3
loop.body3:
  %t32 = load double, double* %l2
  %t33 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t34 = sitofp i64 %t33 to double
  %t35 = fcmp oge double %t32, %t34
  %t36 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t37 = load double, double* %l1
  %t38 = load double, double* %l2
  br i1 %t35, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t39 = load double, double* %l2
  %t40 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t41 = call double @llvm.round.f64(double %t39)
  %t42 = fptosi double %t41 to i64
  %t43 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t42, i64 %t40)
  %t44 = call double @index_of(i8* %t43, i8* %delimiter)
  store double %t44, double* %l3
  %t45 = load double, double* %l3
  %t46 = sitofp i64 0 to double
  %t47 = fcmp olt double %t45, %t46
  %t48 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t49 = load double, double* %l1
  %t50 = load double, double* %l2
  %t51 = load double, double* %l3
  br i1 %t47, label %then8, label %merge9
then8:
  br label %afterloop5
merge9:
  %t52 = load double, double* %l2
  %t53 = load double, double* %l3
  %t54 = fadd double %t52, %t53
  store double %t54, double* %l4
  %t55 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t56 = load double, double* %l1
  %t57 = load double, double* %l4
  %t58 = call double @llvm.round.f64(double %t56)
  %t59 = fptosi double %t58 to i64
  %t60 = call double @llvm.round.f64(double %t57)
  %t61 = fptosi double %t60 to i64
  %t62 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t59, i64 %t61)
  %t63 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t55, i8* %t62)
  store { i8**, i64 }* %t63, { i8**, i64 }** %l0
  %t64 = load double, double* %l4
  %t65 = call i64 @sailfin_runtime_string_length(i8* %delimiter)
  %t66 = sitofp i64 %t65 to double
  %t67 = fadd double %t64, %t66
  store double %t67, double* %l1
  %t68 = load double, double* %l1
  store double %t68, double* %l2
  br label %loop.latch4
loop.latch4:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load double, double* %l1
  %t71 = load double, double* %l2
  br label %loop.header2
afterloop5:
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t76 = load double, double* %l1
  %t77 = load double, double* %l2
  %t78 = load double, double* %l1
  %t79 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t80 = sitofp i64 %t79 to double
  %t81 = fcmp olt double %t78, %t80
  %t82 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t83 = load double, double* %l1
  %t84 = load double, double* %l2
  br i1 %t81, label %then10, label %else11
then10:
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t86 = load double, double* %l1
  %t87 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t88 = call double @llvm.round.f64(double %t86)
  %t89 = fptosi double %t88 to i64
  %t90 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t89, i64 %t87)
  %t91 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t85, i8* %t90)
  store { i8**, i64 }* %t91, { i8**, i64 }** %l0
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge12
else11:
  %t93 = load double, double* %l1
  %t94 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t95 = sitofp i64 %t94 to double
  %t96 = fcmp oeq double %t93, %t95
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load double, double* %l1
  %t99 = load double, double* %l2
  br i1 %t96, label %then13, label %merge14
then13:
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s101 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t102 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t100, i8* %s101)
  store { i8**, i64 }* %t102, { i8**, i64 }** %l0
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge14
merge14:
  %t104 = phi { i8**, i64 }* [ %t103, %then13 ], [ %t97, %else11 ]
  store { i8**, i64 }* %t104, { i8**, i64 }** %l0
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge12
merge12:
  %t106 = phi { i8**, i64 }* [ %t92, %then10 ], [ %t105, %merge14 ]
  store { i8**, i64 }* %t106, { i8**, i64 }** %l0
  %t107 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t107
}

define { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %values, %NativeParameter %parameter) {
block.entry:
  %t0 = call noalias i8* @malloc(i64 40)
  %t1 = bitcast i8* %t0 to %NativeParameter*
  store %NativeParameter %parameter, %NativeParameter* %t1
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
  %t15 = bitcast { %NativeParameter*, i64 }* %values to { i8**, i64 }*
  %t16 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t15, { i8**, i64 }* %t12)
  %t17 = bitcast { i8**, i64 }* %t16 to { %NativeParameter*, i64 }*
  ret { %NativeParameter*, i64 }* %t17
}

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len39.h943297157 = private unnamed_addr constant [40 x i8] c"struct layout header has invalid size `\00"
@.str.len8.h1074277327 = private unnamed_addr constant [9 x i8] c".export \00"
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len30.h829706524 = private unnamed_addr constant [31 x i8] c"unable to parse enum variant: \00"
@.str.len21.h1187531435 = private unnamed_addr constant [22 x i8] c"` missing closing `>`\00"
@.str.len7.h398443637 = private unnamed_addr constant [8 x i8] c".field \00"
@.str.len23.h668778749 = private unnamed_addr constant [24 x i8] c"sailfin-layout-manifest\00"
@.str.len5.h2072026244 = private unnamed_addr constant [6 x i8] c"enum \00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.str.len34.h1377481172 = private unnamed_addr constant [35 x i8] c"` has invalid effects annotation `\00"
@.str.len15.h87749209 = private unnamed_addr constant [16 x i8] c".layout struct \00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len7.h130169768 = private unnamed_addr constant [8 x i8] c".param \00"
@.str.len46.h1830585629 = private unnamed_addr constant [47 x i8] c" layout field encountered before layout header\00"
@.str.len44.h1623843 = private unnamed_addr constant [45 x i8] c" layout payload references unknown variant `\00"
@.str.len34.h805939531 = private unnamed_addr constant [35 x i8] c"unable to parse interface header: \00"
@.str.len44.h1730891783 = private unnamed_addr constant [45 x i8] c" signature has unterminated parameter list: \00"
@.str.len16.h1290415774 = private unnamed_addr constant [17 x i8] c".layout payload \00"
@.str.len17.h293109504 = private unnamed_addr constant [18 x i8] c" layout variant `\00"
@.str.len26.h130324785 = private unnamed_addr constant [27 x i8] c" layout field missing name\00"
@.str.len29.h668562564 = private unnamed_addr constant [30 x i8] c"unable to parse enum header: \00"
@.str.len9.h1228988541 = private unnamed_addr constant [10 x i8] c"tag_type=\00"
@.str.len8.h487238491 = private unnamed_addr constant [9 x i8] c"header `\00"
@.str.len31.h755263238 = private unnamed_addr constant [32 x i8] c" layout payload missing entries\00"
@.str.len5.h2072555103 = private unnamed_addr constant [6 x i8] c".sig \00"
@.str.len42.h1518215675 = private unnamed_addr constant [43 x i8] c"encountered .endfn without active function\00"
@.str.len29.h555082439 = private unnamed_addr constant [30 x i8] c" layout field missing entries\00"
@.str.len33.h1134984829 = private unnamed_addr constant [34 x i8] c"unsupported interface directive: \00"
@.str.len48.h807033739 = private unnamed_addr constant [49 x i8] c" layout payload encountered before layout header\00"
@.str.len4.h192491117 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.len9.h1123073249 = private unnamed_addr constant [10 x i8] c"` invalid\00"
@.str.len32.h1822658020 = private unnamed_addr constant [33 x i8] c"duplicate enum layout header in \00"
@.str.len43.h1714227133 = private unnamed_addr constant [44 x i8] c"unable to parse initializer span metadata: \00"
@.str.len32.h1767333123 = private unnamed_addr constant [33 x i8] c"metadata outside function body: \00"
@.str.len6.h1280331335 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.len20.h151690315 = private unnamed_addr constant [21 x i8] c"` has invalid size `\00"
@.str.len7.h242296049 = private unnamed_addr constant [8 x i8] c"offset=\00"
@.str.len10.h1219235236 = private unnamed_addr constant [11 x i8] c".manifest \00"
@.str.len10.h179409731 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.len48.h235936117 = private unnamed_addr constant [49 x i8] c" layout variant encountered before layout header\00"
@.str.len8.h787332764 = private unnamed_addr constant [9 x i8] c"effects \00"
@.str.len5.h2080793783 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.len4.h192590216 = private unnamed_addr constant [5 x i8] c".if \00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len34.h183092327 = private unnamed_addr constant [35 x i8] c"enum layout header missing entries\00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len31.h1478667446 = private unnamed_addr constant [32 x i8] c"unable to parse struct header: \00"
@.str.len28.h497146076 = private unnamed_addr constant [29 x i8] c" layout payload identifier `\00"
@.str.len41.h35508704 = private unnamed_addr constant [42 x i8] c"unused initializer span metadata before: \00"
@.str.len27.h237652301 = private unnamed_addr constant [28 x i8] c"` has unsupported segment `\00"
@.str.len9.h1692644020 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.len40.h1650449248 = private unnamed_addr constant [41 x i8] c"struct layout header has invalid align `\00"
@.str.len4.h273104342 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len4.h268715771 = private unnamed_addr constant [5 x i8] c"none\00"
@.str.len7.h1448749422 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.str.len20.h1568429285 = private unnamed_addr constant [21 x i8] c"` missing type entry\00"
@.str.len30.h702899578 = private unnamed_addr constant [31 x i8] c"unable to parse struct field: \00"
@.str.len29.h128952257 = private unnamed_addr constant [30 x i8] c" layout field missing content\00"
@.str.len4.h268717223 = private unnamed_addr constant [5 x i8] c"noop\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len13.h259593098 = private unnamed_addr constant [14 x i8] c".layout enum \00"
@.str.len26.h1834305347 = private unnamed_addr constant [27 x i8] c" signature missing content\00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len22.h625556084 = private unnamed_addr constant [23 x i8] c"` missing offset entry\00"
@.str.len22.h24304067 = private unnamed_addr constant [23 x i8] c"` has invalid offset `\00"
@.str.len31.h762677253 = private unnamed_addr constant [32 x i8] c"unable to parse span metadata: \00"
@.str.len5.h2056075365 = private unnamed_addr constant [6 x i8] c".else\00"
@.str.len31.h1924917952 = private unnamed_addr constant [32 x i8] c"duplicate enum layout variant `\00"
@.str.len29.h1601547567 = private unnamed_addr constant [30 x i8] c"unused span metadata before: \00"
@.str.len34.h1211676914 = private unnamed_addr constant [35 x i8] c"unable to parse method parameter: \00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len57.h1118233133 = private unnamed_addr constant [58 x i8] c"encountered nested .fn while previous function still open\00"
@.str.len8.h571206424 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.len31.h1868156648 = private unnamed_addr constant [32 x i8] c" header missing implements list\00"
@.str.len39.h1399971520 = private unnamed_addr constant [40 x i8] c"struct layout header missing size entry\00"
@.str.len20.h1216366549 = private unnamed_addr constant [21 x i8] c"unterminated struct \00"
@.str.len40.h1512965366 = private unnamed_addr constant [41 x i8] c"unterminated function at end of artifact\00"
@.str.len19.h1697653870 = private unnamed_addr constant [20 x i8] c"` missing tag entry\00"
@.str.len6.h841337749 = private unnamed_addr constant [7 x i8] c"align=\00"
@.str.len38.h2050661185 = private unnamed_addr constant [39 x i8] c"enum layout header missing align entry\00"
@.str.len19.h879467198 = private unnamed_addr constant [20 x i8] c"` has invalid tag `\00"
@.str.len31.h329133056 = private unnamed_addr constant [32 x i8] c" layout payload missing content\00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.str.len42.h930606274 = private unnamed_addr constant [43 x i8] c"enum layout header missing tag_align entry\00"
@.str.len11.h908744813 = private unnamed_addr constant [12 x i8] c"implements \00"
@.str.len30.h208276320 = private unnamed_addr constant [31 x i8] c"unterminated method in struct \00"
@.str.len10.h2070880298 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.str.len6.h1830497006 = private unnamed_addr constant [7 x i8] c".span \00"
@.str.len5.h2064480630 = private unnamed_addr constant [6 x i8] c".loop\00"
@.str.len10.h385719500 = private unnamed_addr constant [11 x i8] c"interface \00"
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len17.h1973869273 = private unnamed_addr constant [18 x i8] c" layout payload `\00"
@.str.len22.h496289716 = private unnamed_addr constant [23 x i8] c"` unrecognized token `\00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.len30.h211710404 = private unnamed_addr constant [31 x i8] c"unsupported struct directive: \00"
@.str.len8.h1616485352 = private unnamed_addr constant [9 x i8] c".layout \00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len6.h734244628 = private unnamed_addr constant [7 x i8] c"field \00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len36.h414094739 = private unnamed_addr constant [37 x i8] c"struct layout header missing entries\00"
@.str.len34.h654371835 = private unnamed_addr constant [35 x i8] c"duplicate struct layout header in \00"
@.str.len2.h193415939 = private unnamed_addr constant [3 x i8] c"![\00"
@.str.len38.h1235260132 = private unnamed_addr constant [39 x i8] c"enum layout header has invalid align `\00"
@.str.len41.h881857818 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_type entry\00"
@.str.len5.h1783417286 = private unnamed_addr constant [6 x i8] c"` in \00"
@.str.len9.h1311191977 = private unnamed_addr constant [10 x i8] c".variant \00"
@.str.len14.h1219450488 = private unnamed_addr constant [15 x i8] c"` missing name\00"
@.str.len24.h457168017 = private unnamed_addr constant [25 x i8] c"unable to parse import: \00"
@.str.len4.h275319236 = private unnamed_addr constant [5 x i8] c"tag=\00"
@.str.len7.h553171426 = private unnamed_addr constant [8 x i8] c".match \00"
@.str.len37.h1152036459 = private unnamed_addr constant [38 x i8] c"unsupported struct layout directive: \00"
@.str.len37.h2038142650 = private unnamed_addr constant [38 x i8] c"enum layout header missing size entry\00"
@.str.len35.h546841458 = private unnamed_addr constant [36 x i8] c" signature missing parameter list: \00"
@.str.len41.h1415177535 = private unnamed_addr constant [42 x i8] c"struct layout header unrecognized token `\00"
@.str.len23.h1564009733 = private unnamed_addr constant [24 x i8] c"unterminated interface \00"
@.str.len4.h267749729 = private unnamed_addr constant [5 x i8] c"mut \00"
@.str.len3.h2090684245 = private unnamed_addr constant [4 x i8] c"ret\00"
@.str.len21.h1297227834 = private unnamed_addr constant [22 x i8] c"` has invalid align `\00"
@.str.len41.h1384306956 = private unnamed_addr constant [42 x i8] c"enum layout header has invalid tag_size `\00"
@.str.len25.h378946335 = private unnamed_addr constant [26 x i8] c"` has invalid parameter `\00"
@.str.len5.h466680424 = private unnamed_addr constant [6 x i8] c"size=\00"
@.str.len8.h562875475 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.len5.h261048910 = private unnamed_addr constant [6 x i8] c"name=\00"
@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len26.h1606904140 = private unnamed_addr constant [27 x i8] c"` has unsupported suffix `\00"
@.str.len14.h1053492670 = private unnamed_addr constant [15 x i8] c".layout field \00"
@.str.len15.h506269955 = private unnamed_addr constant [16 x i8] c" layout field `\00"
@.str.len31.h238974215 = private unnamed_addr constant [32 x i8] c" layout variant missing entries\00"
@.str.len9.h890937508 = private unnamed_addr constant [10 x i8] c"eval let \00"
@.str.len6.h1280334338 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.len28.h1605654048 = private unnamed_addr constant [29 x i8] c" layout variant missing name\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.str.len6.h1583308163 = private unnamed_addr constant [7 x i8] c".meta \00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len33.h712498791 = private unnamed_addr constant [34 x i8] c"parameter outside function body: \00"
@.str.len36.h736848621 = private unnamed_addr constant [37 x i8] c"nested method declaration in struct \00"
@.str.len7.h289982314 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.len8.h1951948513 = private unnamed_addr constant [9 x i8] c".method \00"
@.str.len8.h1926252274 = private unnamed_addr constant [9 x i8] c"variant \00"
@.str.len40.h318366654 = private unnamed_addr constant [41 x i8] c"struct layout header missing align entry\00"
@.str.len31.h1960327680 = private unnamed_addr constant [32 x i8] c" layout variant missing content\00"
@.str.len5.h2057365731 = private unnamed_addr constant [6 x i8] c".for \00"
@.str.len33.h1132321576 = private unnamed_addr constant [34 x i8] c" header has unsupported segment `\00"
@.str.len5.h524431183 = private unnamed_addr constant [6 x i8] c"type=\00"
@.str.len28.h1471254674 = private unnamed_addr constant [29 x i8] c"unsupported enum directive: \00"
@.str.len10.h469410318 = private unnamed_addr constant [11 x i8] c"tag_align=\00"
@.str.len8.h1521657554 = private unnamed_addr constant [9 x i8] c"payload \00"
@.str.len12.h841153022 = private unnamed_addr constant [13 x i8] c" signature `\00"
@.str.len18.h1997941781 = private unnamed_addr constant [19 x i8] c"unterminated enum \00"
@.str.len20.h608364678 = private unnamed_addr constant [21 x i8] c"` missing size entry\00"
@.str.len41.h2069276858 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_size entry\00"
@.str.len21.h2112628887 = private unnamed_addr constant [22 x i8] c"` missing align entry\00"
@.str.len8.h575595345 = private unnamed_addr constant [9 x i8] c".import \00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len7.h725262232 = private unnamed_addr constant [8 x i8] c".return\00"
@.str.len39.h598838653 = private unnamed_addr constant [40 x i8] c"enum layout header unrecognized token `\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len32.h1189086491 = private unnamed_addr constant [33 x i8] c"unable to parse parameter line: \00"
@.str.len6.h1134498859 = private unnamed_addr constant [7 x i8] c"async \00"
@.str.len16.h1695010494 = private unnamed_addr constant [17 x i8] c".layout variant \00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len13.h1382830532 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.len9.h1171237782 = private unnamed_addr constant [10 x i8] c"tag_size=\00"
@.str.len33.h1023685264 = private unnamed_addr constant [34 x i8] c"unable to parse parameter entry: \00"
@.str.len6.h483393773 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.len11.h1513373193 = private unnamed_addr constant [12 x i8] c".init-span \00"
@.str.len19.h1782433603 = private unnamed_addr constant [20 x i8] c"sailfin-native-text\00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len37.h1581468287 = private unnamed_addr constant [38 x i8] c"enum layout header has invalid size `\00"
@.str.len47.h1886628617 = private unnamed_addr constant [48 x i8] c"top-level directive not supported in lowering: \00"
@.str.len8.h1370870284 = private unnamed_addr constant [9 x i8] c".module \00"
@.str.len35.h2058816325 = private unnamed_addr constant [36 x i8] c"unsupported enum layout directive: \00"
@.str.len24.h1881287894 = private unnamed_addr constant [25 x i8] c"unable to parse export: \00"
@.str.len42.h1171387022 = private unnamed_addr constant [43 x i8] c"enum layout header has invalid tag_align `\00"