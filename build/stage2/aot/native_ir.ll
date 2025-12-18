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
declare i8* @format_array_expression({ %Expression*, i64 }*)
declare i8* @infer_array_element_type({ %Expression*, i64 }*)
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
declare i8* @join_type_annotations({ %TypeAnnotation*, i64 }*)
declare i8* @char_at(i8*, double)
declare i1 @is_symbol_char(i8*)
declare i8* @sanitize_symbol(i8*)

declare noalias i8* @malloc(i64)

@runtime__native_ir = external global i8**

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

declare void @sailfin_runtime_copy_bytes(i8*, i8*, i64)

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
  %l33 = alloca { %NativeInstruction*, i64 }*
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
  %t1475 = phi double [ %t100, %block.entry ], [ %t1464, %loop.latch2 ]
  %t1476 = phi { i8**, i64 }* [ %t90, %block.entry ], [ %t1465, %loop.latch2 ]
  %t1477 = phi { %NativeImport*, i64 }* [ %t92, %block.entry ], [ %t1466, %loop.latch2 ]
  %t1478 = phi %NativeSourceSpan* [ %t98, %block.entry ], [ %t1467, %loop.latch2 ]
  %t1479 = phi %NativeSourceSpan* [ %t99, %block.entry ], [ %t1468, %loop.latch2 ]
  %t1480 = phi { %NativeStruct*, i64 }* [ %t93, %block.entry ], [ %t1469, %loop.latch2 ]
  %t1481 = phi { %NativeInterface*, i64 }* [ %t94, %block.entry ], [ %t1470, %loop.latch2 ]
  %t1482 = phi { %NativeEnum*, i64 }* [ %t95, %block.entry ], [ %t1471, %loop.latch2 ]
  %t1483 = phi %NativeFunction* [ %t97, %block.entry ], [ %t1472, %loop.latch2 ]
  %t1484 = phi { %NativeFunction*, i64 }* [ %t91, %block.entry ], [ %t1473, %loop.latch2 ]
  %t1485 = phi { %NativeBinding*, i64 }* [ %t96, %block.entry ], [ %t1474, %loop.latch2 ]
  store double %t1475, double* %l11
  store { i8**, i64 }* %t1476, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t1477, { %NativeImport*, i64 }** %l3
  store %NativeSourceSpan* %t1478, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1479, %NativeSourceSpan** %l10
  store { %NativeStruct*, i64 }* %t1480, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1481, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1482, { %NativeEnum*, i64 }** %l6
  store %NativeFunction* %t1483, %NativeFunction** %l8
  store { %NativeFunction*, i64 }* %t1484, { %NativeFunction*, i64 }** %l2
  store { %NativeBinding*, i64 }* %t1485, { %NativeBinding*, i64 }** %l7
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
  %t130 = call i8* @trim_text__native_ir(i8* %t129)
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
  %t152 = add i64 0, 2
  %t153 = call i8* @malloc(i64 %t152)
  store i8 59, i8* %t153
  %t154 = getelementptr i8, i8* %t153, i64 1
  store i8 0, i8* %t154
  call void @sailfin_runtime_mark_persistent(i8* %t153)
  %t155 = call i1 @starts_with(i8* %t151, i8* %t153)
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t158 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t159 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t160 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t161 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t162 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t163 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t164 = load %NativeFunction*, %NativeFunction** %l8
  %t165 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t166 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t167 = load double, double* %l11
  %t168 = load i8*, i8** %l12
  %t169 = load i8*, i8** %l13
  br i1 %t155, label %then8, label %merge9
then8:
  %t170 = load double, double* %l11
  %t171 = sitofp i64 1 to double
  %t172 = fadd double %t170, %t171
  store double %t172, double* %l11
  br label %loop.latch2
merge9:
  %t173 = load i8*, i8** %l13
  %s174 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1370870284, i32 0, i32 0
  %t175 = call i1 @starts_with(i8* %t173, i8* %s174)
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t178 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t179 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t180 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t181 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t182 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t183 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t184 = load %NativeFunction*, %NativeFunction** %l8
  %t185 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t186 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t187 = load double, double* %l11
  %t188 = load i8*, i8** %l12
  %t189 = load i8*, i8** %l13
  br i1 %t175, label %then10, label %merge11
then10:
  %t190 = load double, double* %l11
  %t191 = sitofp i64 1 to double
  %t192 = fadd double %t190, %t191
  store double %t192, double* %l11
  br label %loop.latch2
merge11:
  %t193 = load i8*, i8** %l13
  %s194 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h575595345, i32 0, i32 0
  %t195 = call i1 @starts_with(i8* %t193, i8* %s194)
  %t196 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t197 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t198 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t199 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t200 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t201 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t202 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t203 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t204 = load %NativeFunction*, %NativeFunction** %l8
  %t205 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t206 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t207 = load double, double* %l11
  %t208 = load i8*, i8** %l12
  %t209 = load i8*, i8** %l13
  br i1 %t195, label %then12, label %merge13
then12:
  %s210 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h483393773, i32 0, i32 0
  %t211 = load i8*, i8** %l13
  %s212 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h575595345, i32 0, i32 0
  %t213 = call i8* @strip_prefix(i8* %t211, i8* %s212)
  %t214 = call %NativeImport* @parse_import_entry(i8* %s210, i8* %t213)
  store %NativeImport* %t214, %NativeImport** %l14
  %t215 = load %NativeImport*, %NativeImport** %l14
  %t216 = icmp eq %NativeImport* %t215, null
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t219 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t220 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t221 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t222 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t223 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t224 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t225 = load %NativeFunction*, %NativeFunction** %l8
  %t226 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t227 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t228 = load double, double* %l11
  %t229 = load i8*, i8** %l12
  %t230 = load i8*, i8** %l13
  %t231 = load %NativeImport*, %NativeImport** %l14
  br i1 %t216, label %then14, label %else15
then14:
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s233 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h457168017, i32 0, i32 0
  %t234 = load i8*, i8** %l13
  %t235 = call i8* @sailfin_runtime_string_concat(i8* %s233, i8* %t234)
  %t236 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t232, i8* %t235)
  store { i8**, i64 }* %t236, { i8**, i64 }** %l1
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
else15:
  %t238 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t239 = load %NativeImport*, %NativeImport** %l14
  %t240 = load %NativeImport, %NativeImport* %t239
  %t241 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t238, %NativeImport %t240)
  store { %NativeImport*, i64 }* %t241, { %NativeImport*, i64 }** %l3
  %t242 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge16
merge16:
  %t243 = phi { i8**, i64 }* [ %t237, %then14 ], [ %t218, %else15 ]
  %t244 = phi { %NativeImport*, i64 }* [ %t220, %then14 ], [ %t242, %else15 ]
  store { i8**, i64 }* %t243, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t244, { %NativeImport*, i64 }** %l3
  %t245 = load double, double* %l11
  %t246 = sitofp i64 1 to double
  %t247 = fadd double %t245, %t246
  store double %t247, double* %l11
  br label %loop.latch2
merge13:
  %t248 = load i8*, i8** %l13
  %s249 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1074277327, i32 0, i32 0
  %t250 = call i1 @starts_with(i8* %t248, i8* %s249)
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t253 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t254 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t255 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t256 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t257 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t258 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t259 = load %NativeFunction*, %NativeFunction** %l8
  %t260 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t261 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t262 = load double, double* %l11
  %t263 = load i8*, i8** %l12
  %t264 = load i8*, i8** %l13
  br i1 %t250, label %then17, label %merge18
then17:
  %s265 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h42978514, i32 0, i32 0
  %t266 = load i8*, i8** %l13
  %s267 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1074277327, i32 0, i32 0
  %t268 = call i8* @strip_prefix(i8* %t266, i8* %s267)
  %t269 = call %NativeImport* @parse_import_entry(i8* %s265, i8* %t268)
  store %NativeImport* %t269, %NativeImport** %l15
  %t270 = load %NativeImport*, %NativeImport** %l15
  %t271 = icmp eq %NativeImport* %t270, null
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t274 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t275 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t276 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t277 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t278 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t279 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t280 = load %NativeFunction*, %NativeFunction** %l8
  %t281 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t282 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t283 = load double, double* %l11
  %t284 = load i8*, i8** %l12
  %t285 = load i8*, i8** %l13
  %t286 = load %NativeImport*, %NativeImport** %l15
  br i1 %t271, label %then19, label %else20
then19:
  %t287 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s288 = getelementptr inbounds [25 x i8], [25 x i8]* @.str.len24.h1881287894, i32 0, i32 0
  %t289 = load i8*, i8** %l13
  %t290 = call i8* @sailfin_runtime_string_concat(i8* %s288, i8* %t289)
  %t291 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t287, i8* %t290)
  store { i8**, i64 }* %t291, { i8**, i64 }** %l1
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge21
else20:
  %t293 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t294 = load %NativeImport*, %NativeImport** %l15
  %t295 = load %NativeImport, %NativeImport* %t294
  %t296 = call { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %t293, %NativeImport %t295)
  store { %NativeImport*, i64 }* %t296, { %NativeImport*, i64 }** %l3
  %t297 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  br label %merge21
merge21:
  %t298 = phi { i8**, i64 }* [ %t292, %then19 ], [ %t273, %else20 ]
  %t299 = phi { %NativeImport*, i64 }* [ %t275, %then19 ], [ %t297, %else20 ]
  store { i8**, i64 }* %t298, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t299, { %NativeImport*, i64 }** %l3
  %t300 = load double, double* %l11
  %t301 = sitofp i64 1 to double
  %t302 = fadd double %t300, %t301
  store double %t302, double* %l11
  br label %loop.latch2
merge18:
  %t303 = load i8*, i8** %l13
  %s304 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t305 = call i1 @starts_with(i8* %t303, i8* %s304)
  %t306 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t308 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t309 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t310 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t311 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t312 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t313 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t314 = load %NativeFunction*, %NativeFunction** %l8
  %t315 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t316 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t317 = load double, double* %l11
  %t318 = load i8*, i8** %l12
  %t319 = load i8*, i8** %l13
  br i1 %t305, label %then22, label %merge23
then22:
  %t320 = load i8*, i8** %l13
  %s321 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t322 = call i8* @strip_prefix(i8* %t320, i8* %s321)
  %t323 = call %NativeSourceSpan* @parse_source_span(i8* %t322)
  store %NativeSourceSpan* %t323, %NativeSourceSpan** %l16
  %t324 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  %t325 = icmp eq %NativeSourceSpan* %t324, null
  %t326 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t327 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t328 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t329 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t330 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t331 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t332 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t333 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t334 = load %NativeFunction*, %NativeFunction** %l8
  %t335 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t336 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t337 = load double, double* %l11
  %t338 = load i8*, i8** %l12
  %t339 = load i8*, i8** %l13
  %t340 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  br i1 %t325, label %then24, label %else25
then24:
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s342 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h762677253, i32 0, i32 0
  %t343 = load i8*, i8** %l13
  %t344 = call i8* @sailfin_runtime_string_concat(i8* %s342, i8* %t343)
  %t345 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t341, i8* %t344)
  store { i8**, i64 }* %t345, { i8**, i64 }** %l1
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t347 = load %NativeSourceSpan*, %NativeSourceSpan** %l16
  store %NativeSourceSpan* %t347, %NativeSourceSpan** %l9
  %t348 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge26
merge26:
  %t349 = phi { i8**, i64 }* [ %t346, %then24 ], [ %t327, %else25 ]
  %t350 = phi %NativeSourceSpan* [ %t335, %then24 ], [ %t348, %else25 ]
  store { i8**, i64 }* %t349, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t350, %NativeSourceSpan** %l9
  %t351 = load double, double* %l11
  %t352 = sitofp i64 1 to double
  %t353 = fadd double %t351, %t352
  store double %t353, double* %l11
  br label %loop.latch2
merge23:
  %t354 = load i8*, i8** %l13
  %s355 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t356 = call i1 @starts_with(i8* %t354, i8* %s355)
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t359 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t360 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t361 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t362 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t363 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t364 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t365 = load %NativeFunction*, %NativeFunction** %l8
  %t366 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t367 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t368 = load double, double* %l11
  %t369 = load i8*, i8** %l12
  %t370 = load i8*, i8** %l13
  br i1 %t356, label %then27, label %merge28
then27:
  %t371 = load i8*, i8** %l13
  %s372 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t373 = call i8* @strip_prefix(i8* %t371, i8* %s372)
  %t374 = call %NativeSourceSpan* @parse_source_span(i8* %t373)
  store %NativeSourceSpan* %t374, %NativeSourceSpan** %l17
  %t375 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  %t376 = icmp eq %NativeSourceSpan* %t375, null
  %t377 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t379 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t380 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t381 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t382 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t383 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t384 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t385 = load %NativeFunction*, %NativeFunction** %l8
  %t386 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t387 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t388 = load double, double* %l11
  %t389 = load i8*, i8** %l12
  %t390 = load i8*, i8** %l13
  %t391 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  br i1 %t376, label %then29, label %else30
then29:
  %t392 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s393 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.len43.h1714227133, i32 0, i32 0
  %t394 = load i8*, i8** %l13
  %t395 = call i8* @sailfin_runtime_string_concat(i8* %s393, i8* %t394)
  %t396 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t392, i8* %t395)
  store { i8**, i64 }* %t396, { i8**, i64 }** %l1
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
else30:
  %t398 = load %NativeSourceSpan*, %NativeSourceSpan** %l17
  store %NativeSourceSpan* %t398, %NativeSourceSpan** %l10
  %t399 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge31
merge31:
  %t400 = phi { i8**, i64 }* [ %t397, %then29 ], [ %t378, %else30 ]
  %t401 = phi %NativeSourceSpan* [ %t387, %then29 ], [ %t399, %else30 ]
  store { i8**, i64 }* %t400, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t401, %NativeSourceSpan** %l10
  %t402 = load double, double* %l11
  %t403 = sitofp i64 1 to double
  %t404 = fadd double %t402, %t403
  store double %t404, double* %l11
  br label %loop.latch2
merge28:
  %t405 = load i8*, i8** %l13
  %s406 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2093451461, i32 0, i32 0
  %t407 = call i1 @starts_with(i8* %t405, i8* %s406)
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t409 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t410 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t411 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t412 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t413 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t414 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t415 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t416 = load %NativeFunction*, %NativeFunction** %l8
  %t417 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t418 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t419 = load double, double* %l11
  %t420 = load i8*, i8** %l12
  %t421 = load i8*, i8** %l13
  br i1 %t407, label %then32, label %merge33
then32:
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t423 = load double, double* %l11
  %t424 = call %StructParseResult @parse_struct_definition({ i8**, i64 }* %t422, double %t423)
  store %StructParseResult %t424, %StructParseResult* %l18
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t426 = load %StructParseResult, %StructParseResult* %l18
  %t427 = extractvalue %StructParseResult %t426, 2
  %t428 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t425, { i8**, i64 }* %t427)
  store { i8**, i64 }* %t428, { i8**, i64 }** %l1
  %t429 = load %StructParseResult, %StructParseResult* %l18
  %t430 = extractvalue %StructParseResult %t429, 0
  %t431 = icmp ne %NativeStruct* %t430, null
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t434 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t435 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t436 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t437 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t438 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t439 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t440 = load %NativeFunction*, %NativeFunction** %l8
  %t441 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t442 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t443 = load double, double* %l11
  %t444 = load i8*, i8** %l12
  %t445 = load i8*, i8** %l13
  %t446 = load %StructParseResult, %StructParseResult* %l18
  br i1 %t431, label %then34, label %merge35
then34:
  %t447 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t448 = load %StructParseResult, %StructParseResult* %l18
  %t449 = extractvalue %StructParseResult %t448, 0
  %t450 = load %NativeStruct, %NativeStruct* %t449
  %t451 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t447, %NativeStruct %t450)
  store { %NativeStruct*, i64 }* %t451, { %NativeStruct*, i64 }** %l4
  %t452 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  br label %merge35
merge35:
  %t453 = phi { %NativeStruct*, i64 }* [ %t452, %then34 ], [ %t436, %then32 ]
  store { %NativeStruct*, i64 }* %t453, { %NativeStruct*, i64 }** %l4
  %t454 = load %StructParseResult, %StructParseResult* %l18
  %t455 = extractvalue %StructParseResult %t454, 1
  store double %t455, double* %l11
  br label %loop.latch2
merge33:
  %t456 = load i8*, i8** %l13
  %s457 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h599952843, i32 0, i32 0
  %t458 = call i1 @starts_with(i8* %t456, i8* %s457)
  %t459 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t461 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t462 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t463 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t464 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t465 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t466 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t467 = load %NativeFunction*, %NativeFunction** %l8
  %t468 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t469 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t470 = load double, double* %l11
  %t471 = load i8*, i8** %l12
  %t472 = load i8*, i8** %l13
  br i1 %t458, label %then36, label %merge37
then36:
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t474 = load double, double* %l11
  %t475 = call %InterfaceParseResult @parse_interface_definition({ i8**, i64 }* %t473, double %t474)
  store %InterfaceParseResult %t475, %InterfaceParseResult* %l19
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t477 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t478 = extractvalue %InterfaceParseResult %t477, 2
  %t479 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t476, { i8**, i64 }* %t478)
  store { i8**, i64 }* %t479, { i8**, i64 }** %l1
  %t480 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t481 = extractvalue %InterfaceParseResult %t480, 0
  %t482 = icmp ne %NativeInterface* %t481, null
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t485 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t486 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t487 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t488 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t489 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t490 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t491 = load %NativeFunction*, %NativeFunction** %l8
  %t492 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t493 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t494 = load double, double* %l11
  %t495 = load i8*, i8** %l12
  %t496 = load i8*, i8** %l13
  %t497 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  br i1 %t482, label %then38, label %merge39
then38:
  %t498 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t499 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t500 = extractvalue %InterfaceParseResult %t499, 0
  %t501 = load %NativeInterface, %NativeInterface* %t500
  %t502 = call { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %t498, %NativeInterface %t501)
  store { %NativeInterface*, i64 }* %t502, { %NativeInterface*, i64 }** %l5
  %t503 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  br label %merge39
merge39:
  %t504 = phi { %NativeInterface*, i64 }* [ %t503, %then38 ], [ %t488, %then36 ]
  store { %NativeInterface*, i64 }* %t504, { %NativeInterface*, i64 }** %l5
  %t505 = load %InterfaceParseResult, %InterfaceParseResult* %l19
  %t506 = extractvalue %InterfaceParseResult %t505, 1
  store double %t506, double* %l11
  br label %loop.latch2
merge37:
  %t507 = load i8*, i8** %l13
  %s508 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280947313, i32 0, i32 0
  %t509 = call i1 @starts_with(i8* %t507, i8* %s508)
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t512 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t513 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t514 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t515 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t516 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t517 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t518 = load %NativeFunction*, %NativeFunction** %l8
  %t519 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t520 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t521 = load double, double* %l11
  %t522 = load i8*, i8** %l12
  %t523 = load i8*, i8** %l13
  br i1 %t509, label %then40, label %merge41
then40:
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t525 = load double, double* %l11
  %t526 = call %EnumParseResult @parse_enum_definition({ i8**, i64 }* %t524, double %t525)
  store %EnumParseResult %t526, %EnumParseResult* %l20
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t528 = load %EnumParseResult, %EnumParseResult* %l20
  %t529 = extractvalue %EnumParseResult %t528, 2
  %t530 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t527, { i8**, i64 }* %t529)
  store { i8**, i64 }* %t530, { i8**, i64 }** %l1
  %t531 = load %EnumParseResult, %EnumParseResult* %l20
  %t532 = extractvalue %EnumParseResult %t531, 0
  %t533 = icmp ne %NativeEnum* %t532, null
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t536 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t537 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t538 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t539 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t540 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t541 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t542 = load %NativeFunction*, %NativeFunction** %l8
  %t543 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t544 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t545 = load double, double* %l11
  %t546 = load i8*, i8** %l12
  %t547 = load i8*, i8** %l13
  %t548 = load %EnumParseResult, %EnumParseResult* %l20
  br i1 %t533, label %then42, label %merge43
then42:
  %t549 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t550 = load %EnumParseResult, %EnumParseResult* %l20
  %t551 = extractvalue %EnumParseResult %t550, 0
  %t552 = load %NativeEnum, %NativeEnum* %t551
  %t553 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t549, %NativeEnum %t552)
  store { %NativeEnum*, i64 }* %t553, { %NativeEnum*, i64 }** %l6
  %t554 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  br label %merge43
merge43:
  %t555 = phi { %NativeEnum*, i64 }* [ %t554, %then42 ], [ %t540, %then40 ]
  store { %NativeEnum*, i64 }* %t555, { %NativeEnum*, i64 }** %l6
  %t556 = load %EnumParseResult, %EnumParseResult* %l20
  %t557 = extractvalue %EnumParseResult %t556, 1
  store double %t557, double* %l11
  br label %loop.latch2
merge41:
  %t558 = load i8*, i8** %l13
  %s559 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192491117, i32 0, i32 0
  %t560 = call i1 @starts_with(i8* %t558, i8* %s559)
  %t561 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t562 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t563 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t564 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t565 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t566 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t567 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t568 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t569 = load %NativeFunction*, %NativeFunction** %l8
  %t570 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t571 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t572 = load double, double* %l11
  %t573 = load i8*, i8** %l12
  %t574 = load i8*, i8** %l13
  br i1 %t560, label %then44, label %merge45
then44:
  %t575 = load %NativeFunction*, %NativeFunction** %l8
  %t576 = icmp ne %NativeFunction* %t575, null
  %t577 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t579 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t580 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t581 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t582 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t583 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t584 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t585 = load %NativeFunction*, %NativeFunction** %l8
  %t586 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t587 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t588 = load double, double* %l11
  %t589 = load i8*, i8** %l12
  %t590 = load i8*, i8** %l13
  br i1 %t576, label %then46, label %merge47
then46:
  %t591 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s592 = getelementptr inbounds [58 x i8], [58 x i8]* @.str.len57.h1118233133, i32 0, i32 0
  %t593 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t591, i8* %s592)
  store { i8**, i64 }* %t593, { i8**, i64 }** %l1
  %t594 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t595 = phi { i8**, i64 }* [ %t594, %then46 ], [ %t578, %then44 ]
  store { i8**, i64 }* %t595, { i8**, i64 }** %l1
  %t596 = load i8*, i8** %l13
  %s597 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192491117, i32 0, i32 0
  %t598 = call i8* @strip_prefix(i8* %t596, i8* %s597)
  %t599 = call i8* @parse_function_name(i8* %t598)
  %t600 = insertvalue %NativeFunction undef, i8* %t599, 0
  %t601 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t602 = ptrtoint [0 x %NativeParameter]* %t601 to i64
  %t603 = icmp eq i64 %t602, 0
  %t604 = select i1 %t603, i64 1, i64 %t602
  %t605 = call i8* @malloc(i64 %t604)
  %t606 = bitcast i8* %t605 to %NativeParameter*
  %t607 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t608 = ptrtoint { %NativeParameter*, i64 }* %t607 to i64
  %t609 = call i8* @malloc(i64 %t608)
  %t610 = bitcast i8* %t609 to { %NativeParameter*, i64 }*
  %t611 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t610, i32 0, i32 0
  store %NativeParameter* %t606, %NativeParameter** %t611
  %t612 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t610, i32 0, i32 1
  store i64 0, i64* %t612
  %t613 = insertvalue %NativeFunction %t600, { %NativeParameter*, i64 }* %t610, 1
  %s614 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t615 = insertvalue %NativeFunction %t613, i8* %s614, 2
  %t616 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t617 = ptrtoint [0 x i8*]* %t616 to i64
  %t618 = icmp eq i64 %t617, 0
  %t619 = select i1 %t618, i64 1, i64 %t617
  %t620 = call i8* @malloc(i64 %t619)
  %t621 = bitcast i8* %t620 to i8**
  %t622 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t623 = ptrtoint { i8**, i64 }* %t622 to i64
  %t624 = call i8* @malloc(i64 %t623)
  %t625 = bitcast i8* %t624 to { i8**, i64 }*
  %t626 = getelementptr { i8**, i64 }, { i8**, i64 }* %t625, i32 0, i32 0
  store i8** %t621, i8*** %t626
  %t627 = getelementptr { i8**, i64 }, { i8**, i64 }* %t625, i32 0, i32 1
  store i64 0, i64* %t627
  %t628 = insertvalue %NativeFunction %t615, { i8**, i64 }* %t625, 3
  %t629 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* null, i32 1
  %t630 = ptrtoint [0 x %NativeInstruction]* %t629 to i64
  %t631 = icmp eq i64 %t630, 0
  %t632 = select i1 %t631, i64 1, i64 %t630
  %t633 = call i8* @malloc(i64 %t632)
  %t634 = bitcast i8* %t633 to %NativeInstruction*
  %t635 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t636 = ptrtoint { %NativeInstruction*, i64 }* %t635 to i64
  %t637 = call i8* @malloc(i64 %t636)
  %t638 = bitcast i8* %t637 to { %NativeInstruction*, i64 }*
  %t639 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t638, i32 0, i32 0
  store %NativeInstruction* %t634, %NativeInstruction** %t639
  %t640 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t638, i32 0, i32 1
  store i64 0, i64* %t640
  %t641 = insertvalue %NativeFunction %t628, { %NativeInstruction*, i64 }* %t638, 4
  %t642 = alloca %NativeFunction
  store %NativeFunction %t641, %NativeFunction* %t642
  store %NativeFunction* %t642, %NativeFunction** %l8
  %t643 = load double, double* %l11
  %t644 = sitofp i64 1 to double
  %t645 = fadd double %t643, %t644
  store double %t645, double* %l11
  br label %loop.latch2
merge45:
  %t646 = load i8*, i8** %l13
  %s647 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280331335, i32 0, i32 0
  %t648 = call i1 @starts_with(i8* %t646, i8* %s647)
  %t649 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t651 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t652 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t653 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t654 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t655 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t656 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t657 = load %NativeFunction*, %NativeFunction** %l8
  %t658 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t659 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t660 = load double, double* %l11
  %t661 = load i8*, i8** %l12
  %t662 = load i8*, i8** %l13
  br i1 %t648, label %then48, label %merge49
then48:
  %t663 = load %NativeFunction*, %NativeFunction** %l8
  %t664 = icmp eq %NativeFunction* %t663, null
  %t665 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t666 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t667 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t668 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t669 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t670 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t671 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t672 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t673 = load %NativeFunction*, %NativeFunction** %l8
  %t674 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t675 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t676 = load double, double* %l11
  %t677 = load i8*, i8** %l12
  %t678 = load i8*, i8** %l13
  br i1 %t664, label %then50, label %else51
then50:
  %t679 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s680 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1518215675, i32 0, i32 0
  %t681 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t679, i8* %s680)
  store { i8**, i64 }* %t681, { i8**, i64 }** %l1
  %t682 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge52
else51:
  %t683 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t684 = load %NativeFunction*, %NativeFunction** %l8
  %t685 = load %NativeFunction, %NativeFunction* %t684
  %t686 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t683, %NativeFunction %t685)
  store { %NativeFunction*, i64 }* %t686, { %NativeFunction*, i64 }** %l2
  %t687 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t687, %NativeFunction** %l8
  %t688 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t689 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge52
merge52:
  %t690 = phi { i8**, i64 }* [ %t682, %then50 ], [ %t666, %else51 ]
  %t691 = phi { %NativeFunction*, i64 }* [ %t667, %then50 ], [ %t688, %else51 ]
  %t692 = phi %NativeFunction* [ %t673, %then50 ], [ %t689, %else51 ]
  store { i8**, i64 }* %t690, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t691, { %NativeFunction*, i64 }** %l2
  store %NativeFunction* %t692, %NativeFunction** %l8
  %t693 = load double, double* %l11
  %t694 = sitofp i64 1 to double
  %t695 = fadd double %t693, %t694
  store double %t695, double* %l11
  br label %loop.latch2
merge49:
  %t696 = load i8*, i8** %l13
  %s697 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t698 = call i1 @starts_with(i8* %t696, i8* %s697)
  %t699 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t700 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t701 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t702 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t703 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t704 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t705 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t706 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t707 = load %NativeFunction*, %NativeFunction** %l8
  %t708 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t709 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t710 = load double, double* %l11
  %t711 = load i8*, i8** %l12
  %t712 = load i8*, i8** %l13
  br i1 %t698, label %then53, label %merge54
then53:
  %t713 = load %NativeFunction*, %NativeFunction** %l8
  %t714 = icmp ne %NativeFunction* %t713, null
  %t715 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t716 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t717 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t718 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t719 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t720 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t721 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t722 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t723 = load %NativeFunction*, %NativeFunction** %l8
  %t724 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t725 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t726 = load double, double* %l11
  %t727 = load i8*, i8** %l12
  %t728 = load i8*, i8** %l13
  br i1 %t714, label %then55, label %else56
then55:
  %t729 = load %NativeFunction*, %NativeFunction** %l8
  %t730 = load i8*, i8** %l13
  %s731 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t732 = call i8* @strip_prefix(i8* %t730, i8* %s731)
  %t733 = load %NativeFunction, %NativeFunction* %t729
  %t734 = call %NativeFunction @apply_meta(%NativeFunction %t733, i8* %t732)
  %t735 = alloca %NativeFunction
  store %NativeFunction %t734, %NativeFunction* %t735
  store %NativeFunction* %t735, %NativeFunction** %l8
  %t736 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge57
else56:
  %t737 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s738 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1767333123, i32 0, i32 0
  %t739 = load i8*, i8** %l13
  %t740 = call i8* @sailfin_runtime_string_concat(i8* %s738, i8* %t739)
  %t741 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t737, i8* %t740)
  store { i8**, i64 }* %t741, { i8**, i64 }** %l1
  %t742 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge57
merge57:
  %t743 = phi %NativeFunction* [ %t736, %then55 ], [ %t723, %else56 ]
  %t744 = phi { i8**, i64 }* [ %t716, %then55 ], [ %t742, %else56 ]
  store %NativeFunction* %t743, %NativeFunction** %l8
  store { i8**, i64 }* %t744, { i8**, i64 }** %l1
  %t745 = load double, double* %l11
  %t746 = sitofp i64 1 to double
  %t747 = fadd double %t745, %t746
  store double %t747, double* %l11
  br label %loop.latch2
merge54:
  %t748 = load i8*, i8** %l13
  %s749 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t750 = call i1 @starts_with(i8* %t748, i8* %s749)
  %t751 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t752 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t753 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t754 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t755 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t756 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t757 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t758 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t759 = load %NativeFunction*, %NativeFunction** %l8
  %t760 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t761 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t762 = load double, double* %l11
  %t763 = load i8*, i8** %l12
  %t764 = load i8*, i8** %l13
  br i1 %t750, label %then58, label %merge59
then58:
  %t765 = load %NativeFunction*, %NativeFunction** %l8
  %t766 = icmp ne %NativeFunction* %t765, null
  %t767 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t768 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t769 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t770 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t771 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t772 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t773 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t774 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t775 = load %NativeFunction*, %NativeFunction** %l8
  %t776 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t777 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t778 = load double, double* %l11
  %t779 = load i8*, i8** %l12
  %t780 = load i8*, i8** %l13
  br i1 %t766, label %then60, label %else61
then60:
  %t781 = load i8*, i8** %l13
  %s782 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t783 = call i8* @strip_prefix(i8* %t781, i8* %s782)
  store i8* %t783, i8** %l21
  %t784 = load double, double* %l11
  %t785 = sitofp i64 1 to double
  %t786 = fadd double %t784, %t785
  store double %t786, double* %l22
  %t787 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t788 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t789 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t790 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t791 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t792 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t793 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t794 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t795 = load %NativeFunction*, %NativeFunction** %l8
  %t796 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t797 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t798 = load double, double* %l11
  %t799 = load i8*, i8** %l12
  %t800 = load i8*, i8** %l13
  %t801 = load i8*, i8** %l21
  %t802 = load double, double* %l22
  br label %loop.header63
loop.header63:
  %t914 = phi double [ %t802, %then60 ], [ %t912, %loop.latch65 ]
  %t915 = phi i8* [ %t801, %then60 ], [ %t913, %loop.latch65 ]
  store double %t914, double* %l22
  store i8* %t915, i8** %l21
  br label %loop.body64
loop.body64:
  %t803 = load double, double* %l22
  %t804 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t805 = load { i8**, i64 }, { i8**, i64 }* %t804
  %t806 = extractvalue { i8**, i64 } %t805, 1
  %t807 = sitofp i64 %t806 to double
  %t808 = fcmp oge double %t803, %t807
  %t809 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t810 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t811 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t812 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t813 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t814 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t815 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t816 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t817 = load %NativeFunction*, %NativeFunction** %l8
  %t818 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t819 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t820 = load double, double* %l11
  %t821 = load i8*, i8** %l12
  %t822 = load i8*, i8** %l13
  %t823 = load i8*, i8** %l21
  %t824 = load double, double* %l22
  br i1 %t808, label %then67, label %merge68
then67:
  br label %afterloop66
merge68:
  %t825 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t826 = load double, double* %l22
  %t827 = call double @llvm.round.f64(double %t826)
  %t828 = fptosi double %t827 to i64
  %t829 = load { i8**, i64 }, { i8**, i64 }* %t825
  %t830 = extractvalue { i8**, i64 } %t829, 0
  %t831 = extractvalue { i8**, i64 } %t829, 1
  %t832 = icmp uge i64 %t828, %t831
  ; bounds check: %t832 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t828, i64 %t831)
  %t833 = getelementptr i8*, i8** %t830, i64 %t828
  %t834 = load i8*, i8** %t833
  store i8* %t834, i8** %l23
  %t835 = load i8*, i8** %l23
  %t836 = call i64 @sailfin_runtime_string_length(i8* %t835)
  %t837 = icmp eq i64 %t836, 0
  %t838 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t839 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t840 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t841 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t842 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t843 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t844 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t845 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t846 = load %NativeFunction*, %NativeFunction** %l8
  %t847 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t848 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t849 = load double, double* %l11
  %t850 = load i8*, i8** %l12
  %t851 = load i8*, i8** %l13
  %t852 = load i8*, i8** %l21
  %t853 = load double, double* %l22
  %t854 = load i8*, i8** %l23
  br i1 %t837, label %then69, label %merge70
then69:
  br label %afterloop66
merge70:
  %t855 = load i8*, i8** %l23
  %t856 = call i8* @trim_text__native_ir(i8* %t855)
  store i8* %t856, i8** %l24
  %t857 = load i8*, i8** %l24
  %t858 = call i64 @sailfin_runtime_string_length(i8* %t857)
  %t859 = icmp eq i64 %t858, 0
  %t860 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t861 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t862 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t863 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t864 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t865 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t866 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t867 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t868 = load %NativeFunction*, %NativeFunction** %l8
  %t869 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t870 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t871 = load double, double* %l11
  %t872 = load i8*, i8** %l12
  %t873 = load i8*, i8** %l13
  %t874 = load i8*, i8** %l21
  %t875 = load double, double* %l22
  %t876 = load i8*, i8** %l23
  %t877 = load i8*, i8** %l24
  br i1 %t859, label %then71, label %merge72
then71:
  %t878 = load double, double* %l22
  %t879 = sitofp i64 1 to double
  %t880 = fadd double %t878, %t879
  store double %t880, double* %l22
  br label %loop.latch65
merge72:
  %t881 = load i8*, i8** %l24
  %t882 = call i1 @line_looks_like_parameter_entry(i8* %t881)
  %t883 = xor i1 %t882, 1
  %t884 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t885 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t886 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t887 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t888 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t889 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t890 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t891 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t892 = load %NativeFunction*, %NativeFunction** %l8
  %t893 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t894 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t895 = load double, double* %l11
  %t896 = load i8*, i8** %l12
  %t897 = load i8*, i8** %l13
  %t898 = load i8*, i8** %l21
  %t899 = load double, double* %l22
  %t900 = load i8*, i8** %l23
  %t901 = load i8*, i8** %l24
  br i1 %t883, label %then73, label %merge74
then73:
  br label %afterloop66
merge74:
  %t902 = load i8*, i8** %l21
  %t903 = add i64 0, 2
  %t904 = call i8* @malloc(i64 %t903)
  store i8 32, i8* %t904
  %t905 = getelementptr i8, i8* %t904, i64 1
  store i8 0, i8* %t905
  call void @sailfin_runtime_mark_persistent(i8* %t904)
  %t906 = call i8* @sailfin_runtime_string_concat(i8* %t902, i8* %t904)
  %t907 = load i8*, i8** %l24
  %t908 = call i8* @sailfin_runtime_string_concat(i8* %t906, i8* %t907)
  store i8* %t908, i8** %l21
  %t909 = load double, double* %l22
  %t910 = sitofp i64 1 to double
  %t911 = fadd double %t909, %t910
  store double %t911, double* %l22
  br label %loop.latch65
loop.latch65:
  %t912 = load double, double* %l22
  %t913 = load i8*, i8** %l21
  br label %loop.header63
afterloop66:
  %t916 = load double, double* %l22
  %t917 = load i8*, i8** %l21
  %t918 = load i8*, i8** %l21
  %t919 = call { i8**, i64 }* @split_parameter_entries(i8* %t918)
  store { i8**, i64 }* %t919, { i8**, i64 }** %l25
  %t920 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t921 = load { i8**, i64 }, { i8**, i64 }* %t920
  %t922 = extractvalue { i8**, i64 } %t921, 1
  %t923 = icmp eq i64 %t922, 0
  %t924 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t925 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t926 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t927 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t928 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t929 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t930 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t931 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t932 = load %NativeFunction*, %NativeFunction** %l8
  %t933 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t934 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t935 = load double, double* %l11
  %t936 = load i8*, i8** %l12
  %t937 = load i8*, i8** %l13
  %t938 = load i8*, i8** %l21
  %t939 = load double, double* %l22
  %t940 = load { i8**, i64 }*, { i8**, i64 }** %l25
  br i1 %t923, label %then75, label %else76
then75:
  %t941 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s942 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1189086491, i32 0, i32 0
  %t943 = load i8*, i8** %l13
  %t944 = call i8* @sailfin_runtime_string_concat(i8* %s942, i8* %t943)
  %t945 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t941, i8* %t944)
  store { i8**, i64 }* %t945, { i8**, i64 }** %l1
  %t946 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t946, %NativeSourceSpan** %l9
  %t947 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t948 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
else76:
  %t949 = sitofp i64 0 to double
  store double %t949, double* %l26
  store i1 0, i1* %l27
  %t950 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t951 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t952 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t953 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t954 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t955 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t956 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t957 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t958 = load %NativeFunction*, %NativeFunction** %l8
  %t959 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t960 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t961 = load double, double* %l11
  %t962 = load i8*, i8** %l12
  %t963 = load i8*, i8** %l13
  %t964 = load i8*, i8** %l21
  %t965 = load double, double* %l22
  %t966 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t967 = load double, double* %l26
  %t968 = load i1, i1* %l27
  br label %loop.header78
loop.header78:
  %t1109 = phi { i8**, i64 }* [ %t951, %else76 ], [ %t1105, %loop.latch80 ]
  %t1110 = phi %NativeFunction* [ %t958, %else76 ], [ %t1106, %loop.latch80 ]
  %t1111 = phi i1 [ %t968, %else76 ], [ %t1107, %loop.latch80 ]
  %t1112 = phi double [ %t967, %else76 ], [ %t1108, %loop.latch80 ]
  store { i8**, i64 }* %t1109, { i8**, i64 }** %l1
  store %NativeFunction* %t1110, %NativeFunction** %l8
  store i1 %t1111, i1* %l27
  store double %t1112, double* %l26
  br label %loop.body79
loop.body79:
  %t969 = load double, double* %l26
  %t970 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t971 = load { i8**, i64 }, { i8**, i64 }* %t970
  %t972 = extractvalue { i8**, i64 } %t971, 1
  %t973 = sitofp i64 %t972 to double
  %t974 = fcmp oge double %t969, %t973
  %t975 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t976 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t977 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t978 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t979 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t980 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t981 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t982 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t983 = load %NativeFunction*, %NativeFunction** %l8
  %t984 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t985 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t986 = load double, double* %l11
  %t987 = load i8*, i8** %l12
  %t988 = load i8*, i8** %l13
  %t989 = load i8*, i8** %l21
  %t990 = load double, double* %l22
  %t991 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t992 = load double, double* %l26
  %t993 = load i1, i1* %l27
  br i1 %t974, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t994 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t995 = load double, double* %l26
  %t996 = call double @llvm.round.f64(double %t995)
  %t997 = fptosi double %t996 to i64
  %t998 = load { i8**, i64 }, { i8**, i64 }* %t994
  %t999 = extractvalue { i8**, i64 } %t998, 0
  %t1000 = extractvalue { i8**, i64 } %t998, 1
  %t1001 = icmp uge i64 %t997, %t1000
  ; bounds check: %t1001 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t997, i64 %t1000)
  %t1002 = getelementptr i8*, i8** %t999, i64 %t997
  %t1003 = load i8*, i8** %t1002
  store i8* %t1003, i8** %l28
  %t1004 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1004, %NativeSourceSpan** %l29
  %t1005 = load i1, i1* %l27
  %t1006 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1007 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1008 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1009 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1010 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1011 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1012 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1013 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1014 = load %NativeFunction*, %NativeFunction** %l8
  %t1015 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1016 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1017 = load double, double* %l11
  %t1018 = load i8*, i8** %l12
  %t1019 = load i8*, i8** %l13
  %t1020 = load i8*, i8** %l21
  %t1021 = load double, double* %l22
  %t1022 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1023 = load double, double* %l26
  %t1024 = load i1, i1* %l27
  %t1025 = load i8*, i8** %l28
  %t1026 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br i1 %t1005, label %then84, label %merge85
then84:
  %t1027 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1027, %NativeSourceSpan** %l29
  %t1028 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br label %merge85
merge85:
  %t1029 = phi %NativeSourceSpan* [ %t1028, %then84 ], [ %t1026, %merge83 ]
  store %NativeSourceSpan* %t1029, %NativeSourceSpan** %l29
  %t1030 = load i8*, i8** %l28
  %t1031 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1032 = call %NativeParameter* @parse_parameter_entry(i8* %t1030, %NativeSourceSpan* %t1031)
  store %NativeParameter* %t1032, %NativeParameter** %l30
  %t1033 = load %NativeParameter*, %NativeParameter** %l30
  %t1034 = icmp eq %NativeParameter* %t1033, null
  %t1035 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1036 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1037 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1038 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1039 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1040 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1041 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1042 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1043 = load %NativeFunction*, %NativeFunction** %l8
  %t1044 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1045 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1046 = load double, double* %l11
  %t1047 = load i8*, i8** %l12
  %t1048 = load i8*, i8** %l13
  %t1049 = load i8*, i8** %l21
  %t1050 = load double, double* %l22
  %t1051 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1052 = load double, double* %l26
  %t1053 = load i1, i1* %l27
  %t1054 = load i8*, i8** %l28
  %t1055 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1056 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1034, label %then86, label %else87
then86:
  %t1057 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1058 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1023685264, i32 0, i32 0
  %t1059 = load i8*, i8** %l28
  %t1060 = call i8* @sailfin_runtime_string_concat(i8* %s1058, i8* %t1059)
  %t1061 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1057, i8* %t1060)
  store { i8**, i64 }* %t1061, { i8**, i64 }** %l1
  %t1062 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge88
else87:
  %t1063 = load %NativeFunction*, %NativeFunction** %l8
  %t1064 = load %NativeParameter*, %NativeParameter** %l30
  %t1065 = load %NativeFunction, %NativeFunction* %t1063
  %t1066 = load %NativeParameter, %NativeParameter* %t1064
  %t1067 = call %NativeFunction @append_parameter(%NativeFunction %t1065, %NativeParameter %t1066)
  %t1068 = alloca %NativeFunction
  store %NativeFunction %t1067, %NativeFunction* %t1068
  store %NativeFunction* %t1068, %NativeFunction** %l8
  %t1069 = load %NativeParameter*, %NativeParameter** %l30
  %t1070 = getelementptr %NativeParameter, %NativeParameter* %t1069, i32 0, i32 4
  %t1071 = load %NativeSourceSpan*, %NativeSourceSpan** %t1070
  %t1072 = icmp ne %NativeSourceSpan* %t1071, null
  %t1073 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1074 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1075 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1076 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1077 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1078 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1079 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1080 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1081 = load %NativeFunction*, %NativeFunction** %l8
  %t1082 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1083 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1084 = load double, double* %l11
  %t1085 = load i8*, i8** %l12
  %t1086 = load i8*, i8** %l13
  %t1087 = load i8*, i8** %l21
  %t1088 = load double, double* %l22
  %t1089 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1090 = load double, double* %l26
  %t1091 = load i1, i1* %l27
  %t1092 = load i8*, i8** %l28
  %t1093 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1094 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1072, label %then89, label %merge90
then89:
  store i1 1, i1* %l27
  %t1095 = load i1, i1* %l27
  br label %merge90
merge90:
  %t1096 = phi i1 [ %t1095, %then89 ], [ %t1091, %else87 ]
  store i1 %t1096, i1* %l27
  %t1097 = load %NativeFunction*, %NativeFunction** %l8
  %t1098 = load i1, i1* %l27
  br label %merge88
merge88:
  %t1099 = phi { i8**, i64 }* [ %t1062, %then86 ], [ %t1036, %merge90 ]
  %t1100 = phi %NativeFunction* [ %t1043, %then86 ], [ %t1097, %merge90 ]
  %t1101 = phi i1 [ %t1053, %then86 ], [ %t1098, %merge90 ]
  store { i8**, i64 }* %t1099, { i8**, i64 }** %l1
  store %NativeFunction* %t1100, %NativeFunction** %l8
  store i1 %t1101, i1* %l27
  %t1102 = load double, double* %l26
  %t1103 = sitofp i64 1 to double
  %t1104 = fadd double %t1102, %t1103
  store double %t1104, double* %l26
  br label %loop.latch80
loop.latch80:
  %t1105 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1106 = load %NativeFunction*, %NativeFunction** %l8
  %t1107 = load i1, i1* %l27
  %t1108 = load double, double* %l26
  br label %loop.header78
afterloop81:
  %t1113 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1114 = load %NativeFunction*, %NativeFunction** %l8
  %t1115 = load i1, i1* %l27
  %t1116 = load double, double* %l26
  %t1117 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1117, %NativeSourceSpan** %l9
  %t1118 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1119 = load %NativeFunction*, %NativeFunction** %l8
  %t1120 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
merge77:
  %t1121 = phi { i8**, i64 }* [ %t947, %then75 ], [ %t1118, %afterloop81 ]
  %t1122 = phi %NativeSourceSpan* [ %t948, %then75 ], [ %t1120, %afterloop81 ]
  %t1123 = phi %NativeFunction* [ %t932, %then75 ], [ %t1119, %afterloop81 ]
  store { i8**, i64 }* %t1121, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1122, %NativeSourceSpan** %l9
  store %NativeFunction* %t1123, %NativeFunction** %l8
  %t1124 = load double, double* %l22
  %t1125 = sitofp i64 1 to double
  %t1126 = fsub double %t1124, %t1125
  store double %t1126, double* %l11
  %t1127 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1128 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1129 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1130 = load %NativeFunction*, %NativeFunction** %l8
  %t1131 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1132 = load double, double* %l11
  br label %merge62
else61:
  %t1133 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1134 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h712498791, i32 0, i32 0
  %t1135 = load i8*, i8** %l13
  %t1136 = call i8* @sailfin_runtime_string_concat(i8* %s1134, i8* %t1135)
  %t1137 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1133, i8* %t1136)
  store { i8**, i64 }* %t1137, { i8**, i64 }** %l1
  %t1138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge62
merge62:
  %t1139 = phi { i8**, i64 }* [ %t1127, %merge77 ], [ %t1138, %else61 ]
  %t1140 = phi %NativeSourceSpan* [ %t1128, %merge77 ], [ %t776, %else61 ]
  %t1141 = phi %NativeFunction* [ %t1130, %merge77 ], [ %t775, %else61 ]
  %t1142 = phi double [ %t1132, %merge77 ], [ %t778, %else61 ]
  store { i8**, i64 }* %t1139, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1140, %NativeSourceSpan** %l9
  store %NativeFunction* %t1141, %NativeFunction** %l8
  store double %t1142, double* %l11
  %t1143 = load double, double* %l11
  %t1144 = sitofp i64 1 to double
  %t1145 = fadd double %t1143, %t1144
  store double %t1145, double* %l11
  br label %loop.latch2
merge59:
  %t1146 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1147 = load double, double* %l11
  %t1148 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t1146, double %t1147)
  store %InstructionGatherResult %t1148, %InstructionGatherResult* %l31
  %t1149 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1150 = extractvalue %InstructionGatherResult %t1149, 0
  store i8* %t1150, i8** %l13
  %t1151 = load double, double* %l11
  %t1152 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1153 = extractvalue %InstructionGatherResult %t1152, 1
  %t1154 = fadd double %t1151, %t1153
  store double %t1154, double* %l11
  %t1155 = load i8*, i8** %l13
  %t1156 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1157 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1158 = call %InstructionParseResult @parse_instruction(i8* %t1155, %NativeSourceSpan* %t1156, %NativeSourceSpan* %t1157)
  store %InstructionParseResult %t1158, %InstructionParseResult* %l32
  %t1159 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1160 = extractvalue %InstructionParseResult %t1159, 0
  store { %NativeInstruction*, i64 }* %t1160, { %NativeInstruction*, i64 }** %l33
  %t1161 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1162 = extractvalue %InstructionParseResult %t1161, 1
  %t1163 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1165 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1166 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1167 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1168 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1169 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1170 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1171 = load %NativeFunction*, %NativeFunction** %l8
  %t1172 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1173 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1174 = load double, double* %l11
  %t1175 = load i8*, i8** %l12
  %t1176 = load i8*, i8** %l13
  %t1177 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1178 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1179 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1162, label %then91, label %else92
then91:
  %t1180 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1180, %NativeSourceSpan** %l9
  %t1181 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
else92:
  %t1182 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1183 = icmp ne %NativeSourceSpan* %t1182, null
  %t1184 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1185 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1186 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1187 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1188 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1189 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1190 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1191 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1192 = load %NativeFunction*, %NativeFunction** %l8
  %t1193 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1194 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1195 = load double, double* %l11
  %t1196 = load i8*, i8** %l12
  %t1197 = load i8*, i8** %l13
  %t1198 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1199 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1200 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1183, label %then94, label %merge95
then94:
  %t1201 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1202 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t1203 = load i8*, i8** %l13
  %t1204 = call i8* @sailfin_runtime_string_concat(i8* %s1202, i8* %t1203)
  %t1205 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1201, i8* %t1204)
  store { i8**, i64 }* %t1205, { i8**, i64 }** %l1
  %t1206 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1206, %NativeSourceSpan** %l9
  %t1207 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1208 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge95
merge95:
  %t1209 = phi { i8**, i64 }* [ %t1207, %then94 ], [ %t1185, %else92 ]
  %t1210 = phi %NativeSourceSpan* [ %t1208, %then94 ], [ %t1193, %else92 ]
  store { i8**, i64 }* %t1209, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1210, %NativeSourceSpan** %l9
  %t1211 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1212 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
merge93:
  %t1213 = phi %NativeSourceSpan* [ %t1181, %then91 ], [ %t1212, %merge95 ]
  %t1214 = phi { i8**, i64 }* [ %t1164, %then91 ], [ %t1211, %merge95 ]
  store %NativeSourceSpan* %t1213, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t1214, { i8**, i64 }** %l1
  %t1215 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1216 = extractvalue %InstructionParseResult %t1215, 2
  %t1217 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1219 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1220 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1221 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1222 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1223 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1224 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1225 = load %NativeFunction*, %NativeFunction** %l8
  %t1226 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1227 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1228 = load double, double* %l11
  %t1229 = load i8*, i8** %l12
  %t1230 = load i8*, i8** %l13
  %t1231 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1232 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1233 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1216, label %then96, label %else97
then96:
  %t1234 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1234, %NativeSourceSpan** %l10
  %t1235 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
else97:
  %t1236 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1237 = icmp ne %NativeSourceSpan* %t1236, null
  %t1238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1239 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1240 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1241 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1242 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1243 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1244 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1245 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1246 = load %NativeFunction*, %NativeFunction** %l8
  %t1247 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1248 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1249 = load double, double* %l11
  %t1250 = load i8*, i8** %l12
  %t1251 = load i8*, i8** %l13
  %t1252 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1253 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1254 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1237, label %then99, label %merge100
then99:
  %t1255 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1256 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t1257 = load i8*, i8** %l13
  %t1258 = call i8* @sailfin_runtime_string_concat(i8* %s1256, i8* %t1257)
  %t1259 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1255, i8* %t1258)
  store { i8**, i64 }* %t1259, { i8**, i64 }** %l1
  %t1260 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1260, %NativeSourceSpan** %l10
  %t1261 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1262 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge100
merge100:
  %t1263 = phi { i8**, i64 }* [ %t1261, %then99 ], [ %t1239, %else97 ]
  %t1264 = phi %NativeSourceSpan* [ %t1262, %then99 ], [ %t1248, %else97 ]
  store { i8**, i64 }* %t1263, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1264, %NativeSourceSpan** %l10
  %t1265 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1266 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
merge98:
  %t1267 = phi %NativeSourceSpan* [ %t1235, %then96 ], [ %t1266, %merge100 ]
  %t1268 = phi { i8**, i64 }* [ %t1218, %then96 ], [ %t1265, %merge100 ]
  store %NativeSourceSpan* %t1267, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t1268, { i8**, i64 }** %l1
  %t1269 = load %NativeFunction*, %NativeFunction** %l8
  %t1270 = icmp eq %NativeFunction* %t1269, null
  %t1271 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1273 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1274 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1275 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1276 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1277 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1278 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1279 = load %NativeFunction*, %NativeFunction** %l8
  %t1280 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1281 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1282 = load double, double* %l11
  %t1283 = load i8*, i8** %l12
  %t1284 = load i8*, i8** %l13
  %t1285 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1286 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1287 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1270, label %then101, label %merge102
then101:
  %t1289 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1290 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1289
  %t1291 = extractvalue { %NativeInstruction*, i64 } %t1290, 1
  %t1292 = icmp eq i64 %t1291, 1
  br label %logical_and_entry_1288

logical_and_entry_1288:
  br i1 %t1292, label %logical_and_right_1288, label %logical_and_merge_1288

logical_and_right_1288:
  %t1293 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1294 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1293
  %t1295 = extractvalue { %NativeInstruction*, i64 } %t1294, 0
  %t1296 = extractvalue { %NativeInstruction*, i64 } %t1294, 1
  %t1297 = icmp uge i64 0, %t1296
  ; bounds check: %t1297 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1296)
  %t1298 = getelementptr %NativeInstruction, %NativeInstruction* %t1295, i64 0
  %t1299 = load %NativeInstruction, %NativeInstruction* %t1298
  %t1300 = extractvalue %NativeInstruction %t1299, 0
  %t1301 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1302 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1303 = icmp eq i32 %t1300, 0
  %t1304 = select i1 %t1303, i8* %t1302, i8* %t1301
  %t1305 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1306 = icmp eq i32 %t1300, 1
  %t1307 = select i1 %t1306, i8* %t1305, i8* %t1304
  %t1308 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1309 = icmp eq i32 %t1300, 2
  %t1310 = select i1 %t1309, i8* %t1308, i8* %t1307
  %t1311 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1300, 3
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1300, 4
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1300, 5
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1300, 6
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1300, 7
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1300, 8
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1300, 9
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1300, 10
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1300, 11
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1300, 12
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1300, 13
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1300, 14
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1300, 15
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1300, 16
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %s1353 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t1354 = call i1 @strings_equal(i8* %t1352, i8* %s1353)
  br label %logical_and_right_end_1288

logical_and_right_end_1288:
  br label %logical_and_merge_1288

logical_and_merge_1288:
  %t1355 = phi i1 [ false, %logical_and_entry_1288 ], [ %t1354, %logical_and_right_end_1288 ]
  %t1356 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1357 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1358 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1359 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1360 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1361 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1362 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1363 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1364 = load %NativeFunction*, %NativeFunction** %l8
  %t1365 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1366 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1367 = load double, double* %l11
  %t1368 = load i8*, i8** %l12
  %t1369 = load i8*, i8** %l13
  %t1370 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1371 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1372 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1355, label %then103, label %else104
then103:
  %t1373 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1374 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1375 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1374
  %t1376 = extractvalue { %NativeInstruction*, i64 } %t1375, 0
  %t1377 = extractvalue { %NativeInstruction*, i64 } %t1375, 1
  %t1378 = icmp uge i64 0, %t1377
  ; bounds check: %t1378 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1377)
  %t1379 = getelementptr %NativeInstruction, %NativeInstruction* %t1376, i64 0
  %t1380 = load %NativeInstruction, %NativeInstruction* %t1379
  %t1381 = call %NativeBinding @binding_from_instruction(%NativeInstruction %t1380)
  %t1382 = call { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %t1373, %NativeBinding %t1381)
  store { %NativeBinding*, i64 }* %t1382, { %NativeBinding*, i64 }** %l7
  %t1383 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %merge105
else104:
  %t1384 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1385 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.len47.h1886628617, i32 0, i32 0
  %t1386 = load i8*, i8** %l13
  %t1387 = call i8* @sailfin_runtime_string_concat(i8* %s1385, i8* %t1386)
  %t1388 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1384, i8* %t1387)
  store { i8**, i64 }* %t1388, { i8**, i64 }** %l1
  %t1389 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge105
merge105:
  %t1390 = phi { %NativeBinding*, i64 }* [ %t1383, %then103 ], [ %t1363, %else104 ]
  %t1391 = phi { i8**, i64 }* [ %t1357, %then103 ], [ %t1389, %else104 ]
  store { %NativeBinding*, i64 }* %t1390, { %NativeBinding*, i64 }** %l7
  store { i8**, i64 }* %t1391, { i8**, i64 }** %l1
  %t1392 = load double, double* %l11
  %t1393 = sitofp i64 1 to double
  %t1394 = fadd double %t1392, %t1393
  store double %t1394, double* %l11
  br label %loop.latch2
merge102:
  %t1395 = sitofp i64 0 to double
  store double %t1395, double* %l34
  %t1396 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1398 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1399 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1400 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1401 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1402 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1403 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1404 = load %NativeFunction*, %NativeFunction** %l8
  %t1405 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1406 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1407 = load double, double* %l11
  %t1408 = load i8*, i8** %l12
  %t1409 = load i8*, i8** %l13
  %t1410 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1411 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1412 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1413 = load double, double* %l34
  br label %loop.header106
loop.header106:
  %t1457 = phi %NativeFunction* [ %t1404, %merge102 ], [ %t1455, %loop.latch108 ]
  %t1458 = phi double [ %t1413, %merge102 ], [ %t1456, %loop.latch108 ]
  store %NativeFunction* %t1457, %NativeFunction** %l8
  store double %t1458, double* %l34
  br label %loop.body107
loop.body107:
  %t1414 = load double, double* %l34
  %t1415 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1416 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1415
  %t1417 = extractvalue { %NativeInstruction*, i64 } %t1416, 1
  %t1418 = sitofp i64 %t1417 to double
  %t1419 = fcmp oge double %t1414, %t1418
  %t1420 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1421 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1422 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1423 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1424 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1425 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1426 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1427 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1428 = load %NativeFunction*, %NativeFunction** %l8
  %t1429 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1430 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1431 = load double, double* %l11
  %t1432 = load i8*, i8** %l12
  %t1433 = load i8*, i8** %l13
  %t1434 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1435 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1436 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1437 = load double, double* %l34
  br i1 %t1419, label %then110, label %merge111
then110:
  br label %afterloop109
merge111:
  %t1438 = load %NativeFunction*, %NativeFunction** %l8
  %t1439 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1440 = load double, double* %l34
  %t1441 = call double @llvm.round.f64(double %t1440)
  %t1442 = fptosi double %t1441 to i64
  %t1443 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1439
  %t1444 = extractvalue { %NativeInstruction*, i64 } %t1443, 0
  %t1445 = extractvalue { %NativeInstruction*, i64 } %t1443, 1
  %t1446 = icmp uge i64 %t1442, %t1445
  ; bounds check: %t1446 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1442, i64 %t1445)
  %t1447 = getelementptr %NativeInstruction, %NativeInstruction* %t1444, i64 %t1442
  %t1448 = load %NativeInstruction, %NativeInstruction* %t1447
  %t1449 = load %NativeFunction, %NativeFunction* %t1438
  %t1450 = call %NativeFunction @append_instruction(%NativeFunction %t1449, %NativeInstruction %t1448)
  %t1451 = alloca %NativeFunction
  store %NativeFunction %t1450, %NativeFunction* %t1451
  store %NativeFunction* %t1451, %NativeFunction** %l8
  %t1452 = load double, double* %l34
  %t1453 = sitofp i64 1 to double
  %t1454 = fadd double %t1452, %t1453
  store double %t1454, double* %l34
  br label %loop.latch108
loop.latch108:
  %t1455 = load %NativeFunction*, %NativeFunction** %l8
  %t1456 = load double, double* %l34
  br label %loop.header106
afterloop109:
  %t1459 = load %NativeFunction*, %NativeFunction** %l8
  %t1460 = load double, double* %l34
  %t1461 = load double, double* %l11
  %t1462 = sitofp i64 1 to double
  %t1463 = fadd double %t1461, %t1462
  store double %t1463, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1464 = load double, double* %l11
  %t1465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1466 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1467 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1468 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1469 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1470 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1471 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1472 = load %NativeFunction*, %NativeFunction** %l8
  %t1473 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1474 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %loop.header0
afterloop3:
  %t1486 = load double, double* %l11
  %t1487 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1488 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1489 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1490 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1491 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1492 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1493 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1494 = load %NativeFunction*, %NativeFunction** %l8
  %t1495 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1496 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1497 = load %NativeFunction*, %NativeFunction** %l8
  %t1498 = icmp ne %NativeFunction* %t1497, null
  %t1499 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1500 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1501 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1502 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1503 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1504 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1505 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1506 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1507 = load %NativeFunction*, %NativeFunction** %l8
  %t1508 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1509 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1510 = load double, double* %l11
  br i1 %t1498, label %then112, label %merge113
then112:
  %t1511 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1512 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h1512965366, i32 0, i32 0
  %t1513 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1511, i8* %s1512)
  store { i8**, i64 }* %t1513, { i8**, i64 }** %l1
  %t1514 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge113
merge113:
  %t1515 = phi { i8**, i64 }* [ %t1514, %then112 ], [ %t1500, %afterloop3 ]
  store { i8**, i64 }* %t1515, { i8**, i64 }** %l1
  %t1516 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1517 = insertvalue %ParseNativeResult undef, { %NativeFunction*, i64 }* %t1516, 0
  %t1518 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1519 = insertvalue %ParseNativeResult %t1517, { %NativeImport*, i64 }* %t1518, 1
  %t1520 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1521 = insertvalue %ParseNativeResult %t1519, { %NativeStruct*, i64 }* %t1520, 2
  %t1522 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1523 = insertvalue %ParseNativeResult %t1521, { %NativeInterface*, i64 }* %t1522, 3
  %t1524 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1525 = insertvalue %ParseNativeResult %t1523, { %NativeEnum*, i64 }* %t1524, 4
  %t1526 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1527 = insertvalue %ParseNativeResult %t1525, { %NativeBinding*, i64 }* %t1526, 5
  %t1528 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1529 = insertvalue %ParseNativeResult %t1527, { i8**, i64 }* %t1528, 6
  ret %ParseNativeResult %t1529
}

define %NativeSourceSpan* @parse_source_span(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca %NumberParseResult
  %l3 = alloca %NumberParseResult
  %l4 = alloca %NumberParseResult
  %l5 = alloca %NumberParseResult
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t0 = getelementptr [1 x %NativeFunction], [1 x %NativeFunction]* null, i32 1
  %t1 = ptrtoint [1 x %NativeFunction]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeFunction*
  %t6 = getelementptr %NativeFunction, %NativeFunction* %t5, i64 0
  store %NativeFunction %value, %NativeFunction* %t6
  %t7 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeFunction*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeFunction*, i64 }*
  %t11 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t10, i32 0, i32 0
  store %NativeFunction* %t5, %NativeFunction** %t11
  %t12 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions, i32 0, i32 0
  %t14 = load %NativeFunction*, %NativeFunction** %t13
  %t15 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %functions, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeFunction*, %NativeFunction** %t17
  %t19 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeFunction], [1 x %NativeFunction]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeFunction* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeFunction*
  %t27 = bitcast %NativeFunction* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeFunction* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeFunction* %t18 to i8*
  %t32 = getelementptr %NativeFunction, %NativeFunction* %t26, i64 %t16
  %t33 = bitcast %NativeFunction* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeFunction*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeFunction*, i64 }*
  %t38 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t37, i32 0, i32 0
  store %NativeFunction* %t26, %NativeFunction** %t38
  %t39 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeFunction*, i64 }* %t37
}

define { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %bindings, %NativeBinding %value) {
block.entry:
  %t0 = getelementptr [1 x %NativeBinding], [1 x %NativeBinding]* null, i32 1
  %t1 = ptrtoint [1 x %NativeBinding]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeBinding*
  %t6 = getelementptr %NativeBinding, %NativeBinding* %t5, i64 0
  store %NativeBinding %value, %NativeBinding* %t6
  %t7 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeBinding*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeBinding*, i64 }*
  %t11 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t10, i32 0, i32 0
  store %NativeBinding* %t5, %NativeBinding** %t11
  %t12 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings, i32 0, i32 0
  %t14 = load %NativeBinding*, %NativeBinding** %t13
  %t15 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %bindings, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeBinding*, %NativeBinding** %t17
  %t19 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeBinding], [1 x %NativeBinding]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeBinding* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeBinding*
  %t27 = bitcast %NativeBinding* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeBinding* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeBinding* %t18 to i8*
  %t32 = getelementptr %NativeBinding, %NativeBinding* %t26, i64 %t16
  %t33 = bitcast %NativeBinding* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeBinding*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeBinding*, i64 }*
  %t38 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t37, i32 0, i32 0
  store %NativeBinding* %t26, %NativeBinding** %t38
  %t39 = getelementptr { %NativeBinding*, i64 }, { %NativeBinding*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeBinding*, i64 }* %t37
}

define { %NativeImport*, i64 }* @append_import({ %NativeImport*, i64 }* %imports, %NativeImport %value) {
block.entry:
  %t0 = getelementptr [1 x %NativeImport], [1 x %NativeImport]* null, i32 1
  %t1 = ptrtoint [1 x %NativeImport]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeImport*
  %t6 = getelementptr %NativeImport, %NativeImport* %t5, i64 0
  store %NativeImport %value, %NativeImport* %t6
  %t7 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeImport*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeImport*, i64 }*
  %t11 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t10, i32 0, i32 0
  store %NativeImport* %t5, %NativeImport** %t11
  %t12 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports, i32 0, i32 0
  %t14 = load %NativeImport*, %NativeImport** %t13
  %t15 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %imports, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeImport*, %NativeImport** %t17
  %t19 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeImport], [1 x %NativeImport]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeImport* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeImport*
  %t27 = bitcast %NativeImport* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeImport* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeImport* %t18 to i8*
  %t32 = getelementptr %NativeImport, %NativeImport* %t26, i64 %t16
  %t33 = bitcast %NativeImport* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeImport*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeImport*, i64 }*
  %t38 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t37, i32 0, i32 0
  store %NativeImport* %t26, %NativeImport** %t38
  %t39 = getelementptr { %NativeImport*, i64 }, { %NativeImport*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeImport*, i64 }* %t37
}

define { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %structs, %NativeStruct %value) {
block.entry:
  %t0 = getelementptr [1 x %NativeStruct], [1 x %NativeStruct]* null, i32 1
  %t1 = ptrtoint [1 x %NativeStruct]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeStruct*
  %t6 = getelementptr %NativeStruct, %NativeStruct* %t5, i64 0
  store %NativeStruct %value, %NativeStruct* %t6
  %t7 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeStruct*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeStruct*, i64 }*
  %t11 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t10, i32 0, i32 0
  store %NativeStruct* %t5, %NativeStruct** %t11
  %t12 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs, i32 0, i32 0
  %t14 = load %NativeStruct*, %NativeStruct** %t13
  %t15 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %structs, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeStruct*, %NativeStruct** %t17
  %t19 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeStruct], [1 x %NativeStruct]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeStruct* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeStruct*
  %t27 = bitcast %NativeStruct* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeStruct* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeStruct* %t18 to i8*
  %t32 = getelementptr %NativeStruct, %NativeStruct* %t26, i64 %t16
  %t33 = bitcast %NativeStruct* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeStruct*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeStruct*, i64 }*
  %t38 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t37, i32 0, i32 0
  store %NativeStruct* %t26, %NativeStruct** %t38
  %t39 = getelementptr { %NativeStruct*, i64 }, { %NativeStruct*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeStruct*, i64 }* %t37
}

define { %NativeInterface*, i64 }* @append_interface({ %NativeInterface*, i64 }* %interfaces, %NativeInterface %value) {
block.entry:
  %t0 = getelementptr [1 x %NativeInterface], [1 x %NativeInterface]* null, i32 1
  %t1 = ptrtoint [1 x %NativeInterface]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeInterface*
  %t6 = getelementptr %NativeInterface, %NativeInterface* %t5, i64 0
  store %NativeInterface %value, %NativeInterface* %t6
  %t7 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeInterface*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeInterface*, i64 }*
  %t11 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t10, i32 0, i32 0
  store %NativeInterface* %t5, %NativeInterface** %t11
  %t12 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %interfaces, i32 0, i32 0
  %t14 = load %NativeInterface*, %NativeInterface** %t13
  %t15 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %interfaces, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeInterface*, %NativeInterface** %t17
  %t19 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeInterface], [1 x %NativeInterface]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeInterface* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeInterface*
  %t27 = bitcast %NativeInterface* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeInterface* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeInterface* %t18 to i8*
  %t32 = getelementptr %NativeInterface, %NativeInterface* %t26, i64 %t16
  %t33 = bitcast %NativeInterface* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeInterface*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeInterface*, i64 }*
  %t38 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t37, i32 0, i32 0
  store %NativeInterface* %t26, %NativeInterface** %t38
  %t39 = getelementptr { %NativeInterface*, i64 }, { %NativeInterface*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeInterface*, i64 }* %t37
}

define { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %enums, %NativeEnum %value) {
block.entry:
  %t0 = getelementptr [1 x %NativeEnum], [1 x %NativeEnum]* null, i32 1
  %t1 = ptrtoint [1 x %NativeEnum]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeEnum*
  %t6 = getelementptr %NativeEnum, %NativeEnum* %t5, i64 0
  store %NativeEnum %value, %NativeEnum* %t6
  %t7 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeEnum*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeEnum*, i64 }*
  %t11 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t10, i32 0, i32 0
  store %NativeEnum* %t5, %NativeEnum** %t11
  %t12 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums, i32 0, i32 0
  %t14 = load %NativeEnum*, %NativeEnum** %t13
  %t15 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %enums, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeEnum*, %NativeEnum** %t17
  %t19 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeEnum], [1 x %NativeEnum]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeEnum* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeEnum*
  %t27 = bitcast %NativeEnum* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeEnum* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeEnum* %t18 to i8*
  %t32 = getelementptr %NativeEnum, %NativeEnum* %t26, i64 %t16
  %t33 = bitcast %NativeEnum* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeEnum*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeEnum*, i64 }*
  %t38 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t37, i32 0, i32 0
  store %NativeEnum* %t26, %NativeEnum** %t38
  %t39 = getelementptr { %NativeEnum*, i64 }, { %NativeEnum*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeEnum*, i64 }* %t37
}

define { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %variants, %NativeEnumVariant %value) {
block.entry:
  %t0 = getelementptr [1 x %NativeEnumVariant], [1 x %NativeEnumVariant]* null, i32 1
  %t1 = ptrtoint [1 x %NativeEnumVariant]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeEnumVariant*
  %t6 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t5, i64 0
  store %NativeEnumVariant %value, %NativeEnumVariant* %t6
  %t7 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeEnumVariant*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeEnumVariant*, i64 }*
  %t11 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t10, i32 0, i32 0
  store %NativeEnumVariant* %t5, %NativeEnumVariant** %t11
  %t12 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %variants, i32 0, i32 0
  %t14 = load %NativeEnumVariant*, %NativeEnumVariant** %t13
  %t15 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %variants, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeEnumVariant*, %NativeEnumVariant** %t17
  %t19 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeEnumVariant], [1 x %NativeEnumVariant]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeEnumVariant* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeEnumVariant*
  %t27 = bitcast %NativeEnumVariant* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeEnumVariant* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeEnumVariant* %t18 to i8*
  %t32 = getelementptr %NativeEnumVariant, %NativeEnumVariant* %t26, i64 %t16
  %t33 = bitcast %NativeEnumVariant* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeEnumVariant*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeEnumVariant*, i64 }*
  %t38 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t37, i32 0, i32 0
  store %NativeEnumVariant* %t26, %NativeEnumVariant** %t38
  %t39 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeEnumVariant*, i64 }* %t37
}

define { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %fields, %NativeEnumVariantField %value) {
block.entry:
  %t0 = getelementptr [1 x %NativeEnumVariantField], [1 x %NativeEnumVariantField]* null, i32 1
  %t1 = ptrtoint [1 x %NativeEnumVariantField]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeEnumVariantField*
  %t6 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t5, i64 0
  store %NativeEnumVariantField %value, %NativeEnumVariantField* %t6
  %t7 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeEnumVariantField*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeEnumVariantField*, i64 }*
  %t11 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t10, i32 0, i32 0
  store %NativeEnumVariantField* %t5, %NativeEnumVariantField** %t11
  %t12 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields, i32 0, i32 0
  %t14 = load %NativeEnumVariantField*, %NativeEnumVariantField** %t13
  %t15 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %fields, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeEnumVariantField*, %NativeEnumVariantField** %t17
  %t19 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeEnumVariantField], [1 x %NativeEnumVariantField]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeEnumVariantField* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeEnumVariantField*
  %t27 = bitcast %NativeEnumVariantField* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeEnumVariantField* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeEnumVariantField* %t18 to i8*
  %t32 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* %t26, i64 %t16
  %t33 = bitcast %NativeEnumVariantField* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeEnumVariantField*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeEnumVariantField*, i64 }*
  %t38 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t37, i32 0, i32 0
  store %NativeEnumVariantField* %t26, %NativeEnumVariantField** %t38
  %t39 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeEnumVariantField*, i64 }* %t37
}

define { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %fields, %NativeStructField %field) {
block.entry:
  %t0 = getelementptr [1 x %NativeStructField], [1 x %NativeStructField]* null, i32 1
  %t1 = ptrtoint [1 x %NativeStructField]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeStructField*
  %t6 = getelementptr %NativeStructField, %NativeStructField* %t5, i64 0
  store %NativeStructField %field, %NativeStructField* %t6
  %t7 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeStructField*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeStructField*, i64 }*
  %t11 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t10, i32 0, i32 0
  store %NativeStructField* %t5, %NativeStructField** %t11
  %t12 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields, i32 0, i32 0
  %t14 = load %NativeStructField*, %NativeStructField** %t13
  %t15 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %fields, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeStructField*, %NativeStructField** %t17
  %t19 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeStructField], [1 x %NativeStructField]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeStructField* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeStructField*
  %t27 = bitcast %NativeStructField* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeStructField* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeStructField* %t18 to i8*
  %t32 = getelementptr %NativeStructField, %NativeStructField* %t26, i64 %t16
  %t33 = bitcast %NativeStructField* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeStructField*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeStructField*, i64 }*
  %t38 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t37, i32 0, i32 0
  store %NativeStructField* %t26, %NativeStructField** %t38
  %t39 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeStructField*, i64 }* %t37
}

define { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %fields, %NativeStructLayoutField %field) {
block.entry:
  %t0 = getelementptr [1 x %NativeStructLayoutField], [1 x %NativeStructLayoutField]* null, i32 1
  %t1 = ptrtoint [1 x %NativeStructLayoutField]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeStructLayoutField*
  %t6 = getelementptr %NativeStructLayoutField, %NativeStructLayoutField* %t5, i64 0
  store %NativeStructLayoutField %field, %NativeStructLayoutField* %t6
  %t7 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeStructLayoutField*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeStructLayoutField*, i64 }*
  %t11 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t10, i32 0, i32 0
  store %NativeStructLayoutField* %t5, %NativeStructLayoutField** %t11
  %t12 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %fields, i32 0, i32 0
  %t14 = load %NativeStructLayoutField*, %NativeStructLayoutField** %t13
  %t15 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %fields, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeStructLayoutField*, %NativeStructLayoutField** %t17
  %t19 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeStructLayoutField], [1 x %NativeStructLayoutField]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeStructLayoutField* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeStructLayoutField*
  %t27 = bitcast %NativeStructLayoutField* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeStructLayoutField* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeStructLayoutField* %t18 to i8*
  %t32 = getelementptr %NativeStructLayoutField, %NativeStructLayoutField* %t26, i64 %t16
  %t33 = bitcast %NativeStructLayoutField* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeStructLayoutField*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeStructLayoutField*, i64 }*
  %t38 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t37, i32 0, i32 0
  store %NativeStructLayoutField* %t26, %NativeStructLayoutField** %t38
  %t39 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeStructLayoutField*, i64 }* %t37
}

define { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout__native_ir({ %NativeEnumVariantLayout*, i64 }* %variants, %NativeEnumVariantLayout %value) {
block.entry:
  %t0 = getelementptr [1 x %NativeEnumVariantLayout], [1 x %NativeEnumVariantLayout]* null, i32 1
  %t1 = ptrtoint [1 x %NativeEnumVariantLayout]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeEnumVariantLayout*
  %t6 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t5, i64 0
  store %NativeEnumVariantLayout %value, %NativeEnumVariantLayout* %t6
  %t7 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeEnumVariantLayout*, i64 }*
  %t11 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t10, i32 0, i32 0
  store %NativeEnumVariantLayout* %t5, %NativeEnumVariantLayout** %t11
  %t12 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants, i32 0, i32 0
  %t14 = load %NativeEnumVariantLayout*, %NativeEnumVariantLayout** %t13
  %t15 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeEnumVariantLayout*, %NativeEnumVariantLayout** %t17
  %t19 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeEnumVariantLayout], [1 x %NativeEnumVariantLayout]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeEnumVariantLayout* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeEnumVariantLayout*
  %t27 = bitcast %NativeEnumVariantLayout* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeEnumVariantLayout* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeEnumVariantLayout* %t18 to i8*
  %t32 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t26, i64 %t16
  %t33 = bitcast %NativeEnumVariantLayout* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeEnumVariantLayout*, i64 }*
  %t38 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t37, i32 0, i32 0
  store %NativeEnumVariantLayout* %t26, %NativeEnumVariantLayout** %t38
  %t39 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeEnumVariantLayout*, i64 }* %t37
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
  %t76 = phi { %NativeEnumVariantLayout*, i64 }* [ %t13, %block.entry ], [ %t74, %loop.latch2 ]
  %t77 = phi double [ %t14, %block.entry ], [ %t75, %loop.latch2 ]
  store { %NativeEnumVariantLayout*, i64 }* %t76, { %NativeEnumVariantLayout*, i64 }** %l0
  store double %t77, double* %l1
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
  %t52 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t51, %NativeStructLayoutField %field)
  %t53 = insertvalue %NativeEnumVariantLayout %t49, { %NativeStructLayoutField*, i64 }* %t52, 5
  store %NativeEnumVariantLayout %t53, %NativeEnumVariantLayout* %l3
  %t54 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t55 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l3
  %t56 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout__native_ir({ %NativeEnumVariantLayout*, i64 }* %t54, %NativeEnumVariantLayout %t55)
  store { %NativeEnumVariantLayout*, i64 }* %t56, { %NativeEnumVariantLayout*, i64 }** %l0
  %t57 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
else7:
  %t58 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t59 = load double, double* %l1
  %t60 = call double @llvm.round.f64(double %t59)
  %t61 = fptosi double %t60 to i64
  %t62 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %variants
  %t63 = extractvalue { %NativeEnumVariantLayout*, i64 } %t62, 0
  %t64 = extractvalue { %NativeEnumVariantLayout*, i64 } %t62, 1
  %t65 = icmp uge i64 %t61, %t64
  ; bounds check: %t65 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t61, i64 %t64)
  %t66 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t63, i64 %t61
  %t67 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t66
  %t68 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout__native_ir({ %NativeEnumVariantLayout*, i64 }* %t58, %NativeEnumVariantLayout %t67)
  store { %NativeEnumVariantLayout*, i64 }* %t68, { %NativeEnumVariantLayout*, i64 }** %l0
  %t69 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  br label %merge8
merge8:
  %t70 = phi { %NativeEnumVariantLayout*, i64 }* [ %t57, %then6 ], [ %t69, %else7 ]
  store { %NativeEnumVariantLayout*, i64 }* %t70, { %NativeEnumVariantLayout*, i64 }** %l0
  %t71 = load double, double* %l1
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  store double %t73, double* %l1
  br label %loop.latch2
loop.latch2:
  %t74 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t75 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t78 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  %t79 = load double, double* %l1
  %t80 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l0
  ret { %NativeEnumVariantLayout*, i64 }* %t80
}

define %NativeFunction @append_parameter(%NativeFunction %function, %NativeParameter %parameter) {
block.entry:
  %l0 = alloca { %NativeParameter*, i64 }*
  %t0 = extractvalue %NativeFunction %function, 1
  %t1 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t0, %NativeParameter %parameter)
  store { %NativeParameter*, i64 }* %t1, { %NativeParameter*, i64 }** %l0
  %t2 = extractvalue %NativeFunction %function, 0
  %t3 = insertvalue %NativeFunction undef, i8* %t2, 0
  %t4 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l0
  %t5 = insertvalue %NativeFunction %t3, { %NativeParameter*, i64 }* %t4, 1
  %t6 = extractvalue %NativeFunction %function, 2
  %t7 = insertvalue %NativeFunction %t5, i8* %t6, 2
  %t8 = extractvalue %NativeFunction %function, 3
  %t9 = insertvalue %NativeFunction %t7, { i8**, i64 }* %t8, 3
  %t10 = extractvalue %NativeFunction %function, 4
  %t11 = insertvalue %NativeFunction %t9, { %NativeInstruction*, i64 }* %t10, 4
  ret %NativeFunction %t11
}

define %NativeFunction @append_instruction(%NativeFunction %function, %NativeInstruction %instruction) {
block.entry:
  %l0 = alloca { %NativeInstruction*, i64 }*
  %t0 = extractvalue %NativeFunction %function, 4
  %t1 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t2 = ptrtoint [1 x %NativeInstruction]* %t1 to i64
  %t3 = icmp eq i64 %t2, 0
  %t4 = select i1 %t3, i64 1, i64 %t2
  %t5 = call i8* @malloc(i64 %t4)
  %t6 = bitcast i8* %t5 to %NativeInstruction*
  %t7 = getelementptr %NativeInstruction, %NativeInstruction* %t6, i64 0
  store %NativeInstruction %instruction, %NativeInstruction* %t7
  %t8 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t9 = ptrtoint { %NativeInstruction*, i64 }* %t8 to i64
  %t10 = call i8* @malloc(i64 %t9)
  %t11 = bitcast i8* %t10 to { %NativeInstruction*, i64 }*
  %t12 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t11, i32 0, i32 0
  store %NativeInstruction* %t6, %NativeInstruction** %t12
  %t13 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t11, i32 0, i32 1
  store i64 1, i64* %t13
  %t14 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t0, i32 0, i32 0
  %t15 = load %NativeInstruction*, %NativeInstruction** %t14
  %t16 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t0, i32 0, i32 1
  %t17 = load i64, i64* %t16
  %t18 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t11, i32 0, i32 0
  %t19 = load %NativeInstruction*, %NativeInstruction** %t18
  %t20 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t11, i32 0, i32 1
  %t21 = load i64, i64* %t20
  %t22 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 0, i32 1
  %t23 = ptrtoint %NativeInstruction* %t22 to i64
  %t24 = add i64 %t17, %t21
  %t25 = mul i64 %t23, %t24
  %t26 = call noalias i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to %NativeInstruction*
  %t28 = bitcast %NativeInstruction* %t27 to i8*
  %t29 = mul i64 %t23, %t17
  %t30 = bitcast %NativeInstruction* %t15 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t28, i8* %t30, i64 %t29)
  %t31 = mul i64 %t23, %t21
  %t32 = bitcast %NativeInstruction* %t19 to i8*
  %t33 = getelementptr %NativeInstruction, %NativeInstruction* %t27, i64 %t17
  %t34 = bitcast %NativeInstruction* %t33 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t34, i8* %t32, i64 %t31)
  %t35 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t36 = ptrtoint { %NativeInstruction*, i64 }* %t35 to i64
  %t37 = call i8* @malloc(i64 %t36)
  %t38 = bitcast i8* %t37 to { %NativeInstruction*, i64 }*
  %t39 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t38, i32 0, i32 0
  store %NativeInstruction* %t27, %NativeInstruction** %t39
  %t40 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t38, i32 0, i32 1
  store i64 %t24, i64* %t40
  store { %NativeInstruction*, i64 }* %t38, { %NativeInstruction*, i64 }** %l0
  %t41 = extractvalue %NativeFunction %function, 0
  %t42 = insertvalue %NativeFunction undef, i8* %t41, 0
  %t43 = extractvalue %NativeFunction %function, 1
  %t44 = insertvalue %NativeFunction %t42, { %NativeParameter*, i64 }* %t43, 1
  %t45 = extractvalue %NativeFunction %function, 2
  %t46 = insertvalue %NativeFunction %t44, i8* %t45, 2
  %t47 = extractvalue %NativeFunction %function, 3
  %t48 = insertvalue %NativeFunction %t46, { i8**, i64 }* %t47, 3
  %t49 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l0
  %t50 = insertvalue %NativeFunction %t48, { %NativeInstruction*, i64 }* %t49, 4
  ret %NativeFunction %t50
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
  %t0 = call i8* @trim_text__native_ir(i8* %entry)
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
  %t8 = call i8* @trim_text__native_ir(i8* %t7)
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
  %t19 = call i8* @trim_text__native_ir(i8* %t18)
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
  %t3 = insertvalue %NativeFunction %t1, { %NativeParameter*, i64 }* %t2, 1
  %t4 = insertvalue %NativeFunction %t3, i8* %return_type, 2
  %t5 = insertvalue %NativeFunction %t4, { i8**, i64 }* %effects, 3
  %t6 = extractvalue %NativeFunction %function, 4
  %t7 = insertvalue %NativeFunction %t5, { %NativeInstruction*, i64 }* %t6, 4
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
  %t16 = call i8* @trim_text__native_ir(i8* %t15)
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
  %t122 = phi i8* [ %t51, %merge7 ], [ %t118, %loop.latch10 ]
  %t123 = phi %InstructionDepthState [ %t50, %merge7 ], [ %t119, %loop.latch10 ]
  %t124 = phi double [ %t52, %merge7 ], [ %t120, %loop.latch10 ]
  %t125 = phi double [ %t53, %merge7 ], [ %t121, %loop.latch10 ]
  store i8* %t122, i8** %l2
  store %InstructionDepthState %t123, %InstructionDepthState* %l1
  store double %t124, double* %l3
  store double %t125, double* %l4
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
  %t73 = call i8* @trim_text__native_ir(i8* %t72)
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
  %t84 = add i64 0, 2
  %t85 = call i8* @malloc(i64 %t84)
  store i8 10, i8* %t85
  %t86 = getelementptr i8, i8* %t85, i64 1
  store i8 0, i8* %t86
  call void @sailfin_runtime_mark_persistent(i8* %t85)
  %t87 = call i8* @sailfin_runtime_string_concat(i8* %t83, i8* %t85)
  store i8* %t87, i8** %l2
  %t88 = load i8*, i8** %l2
  br label %merge16
else15:
  %t89 = load i8*, i8** %l2
  %t90 = add i64 0, 2
  %t91 = call i8* @malloc(i64 %t90)
  store i8 10, i8* %t91
  %t92 = getelementptr i8, i8* %t91, i64 1
  store i8 0, i8* %t92
  call void @sailfin_runtime_mark_persistent(i8* %t91)
  %t93 = call i8* @sailfin_runtime_string_concat(i8* %t89, i8* %t91)
  %t94 = load i8*, i8** %l5
  %t95 = call i8* @sailfin_runtime_string_concat(i8* %t93, i8* %t94)
  store i8* %t95, i8** %l2
  %t96 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t97 = load i8*, i8** %l5
  %t98 = call %InstructionDepthState @update_instruction_depth_state(%InstructionDepthState %t96, i8* %t97)
  store %InstructionDepthState %t98, %InstructionDepthState* %l1
  %t99 = load i8*, i8** %l2
  %t100 = load %InstructionDepthState, %InstructionDepthState* %l1
  br label %merge16
merge16:
  %t101 = phi i8* [ %t88, %then14 ], [ %t99, %else15 ]
  %t102 = phi %InstructionDepthState [ %t78, %then14 ], [ %t100, %else15 ]
  store i8* %t101, i8** %l2
  store %InstructionDepthState %t102, %InstructionDepthState* %l1
  %t103 = load double, double* %l3
  %t104 = sitofp i64 1 to double
  %t105 = fadd double %t103, %t104
  store double %t105, double* %l3
  %t106 = load double, double* %l4
  %t107 = sitofp i64 1 to double
  %t108 = fadd double %t106, %t107
  store double %t108, double* %l4
  %t109 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t110 = call i1 @instruction_requires_continuation(%InstructionDepthState %t109)
  %t111 = xor i1 %t110, 1
  %t112 = load i8*, i8** %l0
  %t113 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t114 = load i8*, i8** %l2
  %t115 = load double, double* %l3
  %t116 = load double, double* %l4
  %t117 = load i8*, i8** %l5
  br i1 %t111, label %then17, label %merge18
then17:
  br label %afterloop11
merge18:
  br label %loop.latch10
loop.latch10:
  %t118 = load i8*, i8** %l2
  %t119 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t120 = load double, double* %l3
  %t121 = load double, double* %l4
  br label %loop.header8
afterloop11:
  %t126 = load i8*, i8** %l2
  %t127 = load %InstructionDepthState, %InstructionDepthState* %l1
  %t128 = load double, double* %l3
  %t129 = load double, double* %l4
  %t130 = load i8*, i8** %l2
  %t131 = call i8* @trim_text__native_ir(i8* %t130)
  store i8* %t131, i8** %l6
  %t132 = load i8*, i8** %l6
  %t133 = insertvalue %InstructionGatherResult undef, i8* %t132, 0
  %t134 = load double, double* %l3
  %t135 = insertvalue %InstructionGatherResult %t133, double %t134, 1
  ret %InstructionGatherResult %t135
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
  %t3 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t4 = ptrtoint [1 x %NativeInstruction]* %t3 to i64
  %t5 = icmp eq i64 %t4, 0
  %t6 = select i1 %t5, i64 1, i64 %t4
  %t7 = call i8* @malloc(i64 %t6)
  %t8 = bitcast i8* %t7 to %NativeInstruction*
  %t9 = getelementptr %NativeInstruction, %NativeInstruction* %t8, i64 0
  store %NativeInstruction %t2, %NativeInstruction* %t9
  %t10 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t11 = ptrtoint { %NativeInstruction*, i64 }* %t10 to i64
  %t12 = call i8* @malloc(i64 %t11)
  %t13 = bitcast i8* %t12 to { %NativeInstruction*, i64 }*
  %t14 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t13, i32 0, i32 0
  store %NativeInstruction* %t8, %NativeInstruction** %t14
  %t15 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t13, i32 0, i32 1
  store i64 1, i64* %t15
  %t16 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t13, 0
  %t17 = insertvalue %InstructionParseResult %t16, i1 0, 1
  %t18 = insertvalue %InstructionParseResult %t17, i1 0, 2
  ret %InstructionParseResult %t18
merge1:
  %s19 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192590216, i32 0, i32 0
  %t20 = call i1 @starts_with(i8* %line, i8* %s19)
  br i1 %t20, label %then2, label %merge3
then2:
  %s21 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h192590216, i32 0, i32 0
  %t22 = call i8* @strip_prefix(i8* %line, i8* %s21)
  %t23 = call i8* @trim_text__native_ir(i8* %t22)
  store i8* %t23, i8** %l0
  %t24 = alloca %NativeInstruction
  %t25 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t24, i32 0, i32 0
  store i32 3, i32* %t25
  %t26 = load i8*, i8** %l0
  %t27 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t24, i32 0, i32 1
  %t28 = bitcast [8 x i8]* %t27 to i8*
  %t29 = bitcast i8* %t28 to i8**
  store i8* %t26, i8** %t29
  %t30 = load %NativeInstruction, %NativeInstruction* %t24
  %t31 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t32 = ptrtoint [1 x %NativeInstruction]* %t31 to i64
  %t33 = icmp eq i64 %t32, 0
  %t34 = select i1 %t33, i64 1, i64 %t32
  %t35 = call i8* @malloc(i64 %t34)
  %t36 = bitcast i8* %t35 to %NativeInstruction*
  %t37 = getelementptr %NativeInstruction, %NativeInstruction* %t36, i64 0
  store %NativeInstruction %t30, %NativeInstruction* %t37
  %t38 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t39 = ptrtoint { %NativeInstruction*, i64 }* %t38 to i64
  %t40 = call i8* @malloc(i64 %t39)
  %t41 = bitcast i8* %t40 to { %NativeInstruction*, i64 }*
  %t42 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t41, i32 0, i32 0
  store %NativeInstruction* %t36, %NativeInstruction** %t42
  %t43 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t41, i32 0, i32 1
  store i64 1, i64* %t43
  %t44 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t41, 0
  %t45 = insertvalue %InstructionParseResult %t44, i1 0, 1
  %t46 = insertvalue %InstructionParseResult %t45, i1 0, 2
  ret %InstructionParseResult %t46
merge3:
  %s47 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2056075365, i32 0, i32 0
  %t48 = call i1 @strings_equal(i8* %line, i8* %s47)
  br i1 %t48, label %then4, label %merge5
then4:
  %t49 = insertvalue %NativeInstruction undef, i32 4, 0
  %t50 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t51 = ptrtoint [1 x %NativeInstruction]* %t50 to i64
  %t52 = icmp eq i64 %t51, 0
  %t53 = select i1 %t52, i64 1, i64 %t51
  %t54 = call i8* @malloc(i64 %t53)
  %t55 = bitcast i8* %t54 to %NativeInstruction*
  %t56 = getelementptr %NativeInstruction, %NativeInstruction* %t55, i64 0
  store %NativeInstruction %t49, %NativeInstruction* %t56
  %t57 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t58 = ptrtoint { %NativeInstruction*, i64 }* %t57 to i64
  %t59 = call i8* @malloc(i64 %t58)
  %t60 = bitcast i8* %t59 to { %NativeInstruction*, i64 }*
  %t61 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t60, i32 0, i32 0
  store %NativeInstruction* %t55, %NativeInstruction** %t61
  %t62 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t60, i32 0, i32 1
  store i64 1, i64* %t62
  %t63 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t60, 0
  %t64 = insertvalue %InstructionParseResult %t63, i1 0, 1
  %t65 = insertvalue %InstructionParseResult %t64, i1 0, 2
  ret %InstructionParseResult %t65
merge5:
  %s66 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280334338, i32 0, i32 0
  %t67 = call i1 @strings_equal(i8* %line, i8* %s66)
  br i1 %t67, label %then6, label %merge7
then6:
  %t68 = insertvalue %NativeInstruction undef, i32 5, 0
  %t69 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t70 = ptrtoint [1 x %NativeInstruction]* %t69 to i64
  %t71 = icmp eq i64 %t70, 0
  %t72 = select i1 %t71, i64 1, i64 %t70
  %t73 = call i8* @malloc(i64 %t72)
  %t74 = bitcast i8* %t73 to %NativeInstruction*
  %t75 = getelementptr %NativeInstruction, %NativeInstruction* %t74, i64 0
  store %NativeInstruction %t68, %NativeInstruction* %t75
  %t76 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t77 = ptrtoint { %NativeInstruction*, i64 }* %t76 to i64
  %t78 = call i8* @malloc(i64 %t77)
  %t79 = bitcast i8* %t78 to { %NativeInstruction*, i64 }*
  %t80 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t79, i32 0, i32 0
  store %NativeInstruction* %t74, %NativeInstruction** %t80
  %t81 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t79, i32 0, i32 1
  store i64 1, i64* %t81
  %t82 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t79, 0
  %t83 = insertvalue %InstructionParseResult %t82, i1 0, 1
  %t84 = insertvalue %InstructionParseResult %t83, i1 0, 2
  ret %InstructionParseResult %t84
merge7:
  %s85 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2057365731, i32 0, i32 0
  %t86 = call i1 @starts_with(i8* %line, i8* %s85)
  br i1 %t86, label %then8, label %merge9
then8:
  %s87 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2057365731, i32 0, i32 0
  %t88 = call i8* @strip_prefix(i8* %line, i8* %s87)
  %t89 = call i8* @trim_text__native_ir(i8* %t88)
  store i8* %t89, i8** %l1
  %s90 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h175996034, i32 0, i32 0
  store i8* %s90, i8** %l2
  %t91 = load i8*, i8** %l1
  %t92 = load i8*, i8** %l2
  %t93 = call double @index_of(i8* %t91, i8* %t92)
  store double %t93, double* %l3
  %t94 = load double, double* %l3
  %t95 = sitofp i64 0 to double
  %t96 = fcmp oge double %t94, %t95
  %t97 = load i8*, i8** %l1
  %t98 = load i8*, i8** %l2
  %t99 = load double, double* %l3
  br i1 %t96, label %then10, label %merge11
then10:
  %t100 = load i8*, i8** %l1
  %t101 = load double, double* %l3
  %t102 = call double @llvm.round.f64(double %t101)
  %t103 = fptosi double %t102 to i64
  %t104 = call i8* @sailfin_runtime_substring(i8* %t100, i64 0, i64 %t103)
  %t105 = call i8* @trim_text__native_ir(i8* %t104)
  store i8* %t105, i8** %l4
  %t106 = load i8*, i8** %l1
  %t107 = load double, double* %l3
  %t108 = load i8*, i8** %l2
  %t109 = call i64 @sailfin_runtime_string_length(i8* %t108)
  %t110 = sitofp i64 %t109 to double
  %t111 = fadd double %t107, %t110
  %t112 = load i8*, i8** %l1
  %t113 = call i64 @sailfin_runtime_string_length(i8* %t112)
  %t114 = call double @llvm.round.f64(double %t111)
  %t115 = fptosi double %t114 to i64
  %t116 = call i8* @sailfin_runtime_substring(i8* %t106, i64 %t115, i64 %t113)
  %t117 = call i8* @trim_text__native_ir(i8* %t116)
  store i8* %t117, i8** %l5
  %t118 = alloca %NativeInstruction
  %t119 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t118, i32 0, i32 0
  store i32 6, i32* %t119
  %t120 = load i8*, i8** %l4
  %t121 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t118, i32 0, i32 1
  %t122 = bitcast [16 x i8]* %t121 to i8*
  %t123 = bitcast i8* %t122 to i8**
  store i8* %t120, i8** %t123
  %t124 = load i8*, i8** %l5
  %t125 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t118, i32 0, i32 1
  %t126 = bitcast [16 x i8]* %t125 to i8*
  %t127 = getelementptr inbounds i8, i8* %t126, i64 8
  %t128 = bitcast i8* %t127 to i8**
  store i8* %t124, i8** %t128
  %t129 = load %NativeInstruction, %NativeInstruction* %t118
  %t130 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t131 = ptrtoint [1 x %NativeInstruction]* %t130 to i64
  %t132 = icmp eq i64 %t131, 0
  %t133 = select i1 %t132, i64 1, i64 %t131
  %t134 = call i8* @malloc(i64 %t133)
  %t135 = bitcast i8* %t134 to %NativeInstruction*
  %t136 = getelementptr %NativeInstruction, %NativeInstruction* %t135, i64 0
  store %NativeInstruction %t129, %NativeInstruction* %t136
  %t137 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t138 = ptrtoint { %NativeInstruction*, i64 }* %t137 to i64
  %t139 = call i8* @malloc(i64 %t138)
  %t140 = bitcast i8* %t139 to { %NativeInstruction*, i64 }*
  %t141 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t140, i32 0, i32 0
  store %NativeInstruction* %t135, %NativeInstruction** %t141
  %t142 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t140, i32 0, i32 1
  store i64 1, i64* %t142
  %t143 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t140, 0
  %t144 = insertvalue %InstructionParseResult %t143, i1 0, 1
  %t145 = insertvalue %InstructionParseResult %t144, i1 0, 2
  ret %InstructionParseResult %t145
merge11:
  br label %merge9
merge9:
  %s146 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h1448749422, i32 0, i32 0
  %t147 = call i1 @strings_equal(i8* %line, i8* %s146)
  br i1 %t147, label %then12, label %merge13
then12:
  %t148 = insertvalue %NativeInstruction undef, i32 7, 0
  %t149 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t150 = ptrtoint [1 x %NativeInstruction]* %t149 to i64
  %t151 = icmp eq i64 %t150, 0
  %t152 = select i1 %t151, i64 1, i64 %t150
  %t153 = call i8* @malloc(i64 %t152)
  %t154 = bitcast i8* %t153 to %NativeInstruction*
  %t155 = getelementptr %NativeInstruction, %NativeInstruction* %t154, i64 0
  store %NativeInstruction %t148, %NativeInstruction* %t155
  %t156 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t157 = ptrtoint { %NativeInstruction*, i64 }* %t156 to i64
  %t158 = call i8* @malloc(i64 %t157)
  %t159 = bitcast i8* %t158 to { %NativeInstruction*, i64 }*
  %t160 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t159, i32 0, i32 0
  store %NativeInstruction* %t154, %NativeInstruction** %t160
  %t161 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t159, i32 0, i32 1
  store i64 1, i64* %t161
  %t162 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t159, 0
  %t163 = insertvalue %InstructionParseResult %t162, i1 0, 1
  %t164 = insertvalue %InstructionParseResult %t163, i1 0, 2
  ret %InstructionParseResult %t164
merge13:
  %s165 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064480630, i32 0, i32 0
  %t166 = call i1 @strings_equal(i8* %line, i8* %s165)
  br i1 %t166, label %then14, label %merge15
then14:
  %t167 = insertvalue %NativeInstruction undef, i32 8, 0
  %t168 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t169 = ptrtoint [1 x %NativeInstruction]* %t168 to i64
  %t170 = icmp eq i64 %t169, 0
  %t171 = select i1 %t170, i64 1, i64 %t169
  %t172 = call i8* @malloc(i64 %t171)
  %t173 = bitcast i8* %t172 to %NativeInstruction*
  %t174 = getelementptr %NativeInstruction, %NativeInstruction* %t173, i64 0
  store %NativeInstruction %t167, %NativeInstruction* %t174
  %t175 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t176 = ptrtoint { %NativeInstruction*, i64 }* %t175 to i64
  %t177 = call i8* @malloc(i64 %t176)
  %t178 = bitcast i8* %t177 to { %NativeInstruction*, i64 }*
  %t179 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t178, i32 0, i32 0
  store %NativeInstruction* %t173, %NativeInstruction** %t179
  %t180 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t178, i32 0, i32 1
  store i64 1, i64* %t180
  %t181 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t178, 0
  %t182 = insertvalue %InstructionParseResult %t181, i1 0, 1
  %t183 = insertvalue %InstructionParseResult %t182, i1 0, 2
  ret %InstructionParseResult %t183
merge15:
  %s184 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h571206424, i32 0, i32 0
  %t185 = call i1 @strings_equal(i8* %line, i8* %s184)
  br i1 %t185, label %then16, label %merge17
then16:
  %t186 = insertvalue %NativeInstruction undef, i32 9, 0
  %t187 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t188 = ptrtoint [1 x %NativeInstruction]* %t187 to i64
  %t189 = icmp eq i64 %t188, 0
  %t190 = select i1 %t189, i64 1, i64 %t188
  %t191 = call i8* @malloc(i64 %t190)
  %t192 = bitcast i8* %t191 to %NativeInstruction*
  %t193 = getelementptr %NativeInstruction, %NativeInstruction* %t192, i64 0
  store %NativeInstruction %t186, %NativeInstruction* %t193
  %t194 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t195 = ptrtoint { %NativeInstruction*, i64 }* %t194 to i64
  %t196 = call i8* @malloc(i64 %t195)
  %t197 = bitcast i8* %t196 to { %NativeInstruction*, i64 }*
  %t198 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t197, i32 0, i32 0
  store %NativeInstruction* %t192, %NativeInstruction** %t198
  %t199 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t197, i32 0, i32 1
  store i64 1, i64* %t199
  %t200 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t197, 0
  %t201 = insertvalue %InstructionParseResult %t200, i1 0, 1
  %t202 = insertvalue %InstructionParseResult %t201, i1 0, 2
  ret %InstructionParseResult %t202
merge17:
  %s203 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1958778164, i32 0, i32 0
  %t204 = call i1 @strings_equal(i8* %line, i8* %s203)
  br i1 %t204, label %then18, label %merge19
then18:
  %t205 = insertvalue %NativeInstruction undef, i32 10, 0
  %t206 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t207 = ptrtoint [1 x %NativeInstruction]* %t206 to i64
  %t208 = icmp eq i64 %t207, 0
  %t209 = select i1 %t208, i64 1, i64 %t207
  %t210 = call i8* @malloc(i64 %t209)
  %t211 = bitcast i8* %t210 to %NativeInstruction*
  %t212 = getelementptr %NativeInstruction, %NativeInstruction* %t211, i64 0
  store %NativeInstruction %t205, %NativeInstruction* %t212
  %t213 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t214 = ptrtoint { %NativeInstruction*, i64 }* %t213 to i64
  %t215 = call i8* @malloc(i64 %t214)
  %t216 = bitcast i8* %t215 to { %NativeInstruction*, i64 }*
  %t217 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t216, i32 0, i32 0
  store %NativeInstruction* %t211, %NativeInstruction** %t217
  %t218 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t216, i32 0, i32 1
  store i64 1, i64* %t218
  %t219 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t216, 0
  %t220 = insertvalue %InstructionParseResult %t219, i1 0, 1
  %t221 = insertvalue %InstructionParseResult %t220, i1 0, 2
  ret %InstructionParseResult %t221
merge19:
  %s222 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h528348603, i32 0, i32 0
  %t223 = call i1 @strings_equal(i8* %line, i8* %s222)
  br i1 %t223, label %then20, label %merge21
then20:
  %t224 = insertvalue %NativeInstruction undef, i32 11, 0
  %t225 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t226 = ptrtoint [1 x %NativeInstruction]* %t225 to i64
  %t227 = icmp eq i64 %t226, 0
  %t228 = select i1 %t227, i64 1, i64 %t226
  %t229 = call i8* @malloc(i64 %t228)
  %t230 = bitcast i8* %t229 to %NativeInstruction*
  %t231 = getelementptr %NativeInstruction, %NativeInstruction* %t230, i64 0
  store %NativeInstruction %t224, %NativeInstruction* %t231
  %t232 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t233 = ptrtoint { %NativeInstruction*, i64 }* %t232 to i64
  %t234 = call i8* @malloc(i64 %t233)
  %t235 = bitcast i8* %t234 to { %NativeInstruction*, i64 }*
  %t236 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t235, i32 0, i32 0
  store %NativeInstruction* %t230, %NativeInstruction** %t236
  %t237 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t235, i32 0, i32 1
  store i64 1, i64* %t237
  %t238 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t235, 0
  %t239 = insertvalue %InstructionParseResult %t238, i1 0, 1
  %t240 = insertvalue %InstructionParseResult %t239, i1 0, 2
  ret %InstructionParseResult %t240
merge21:
  %s241 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h553171426, i32 0, i32 0
  %t242 = call i1 @starts_with(i8* %line, i8* %s241)
  br i1 %t242, label %then22, label %merge23
then22:
  %s243 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h553171426, i32 0, i32 0
  %t244 = call i8* @strip_prefix(i8* %line, i8* %s243)
  %t245 = call i8* @trim_text__native_ir(i8* %t244)
  store i8* %t245, i8** %l6
  %t246 = alloca %NativeInstruction
  %t247 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t246, i32 0, i32 0
  store i32 12, i32* %t247
  %t248 = load i8*, i8** %l6
  %t249 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t246, i32 0, i32 1
  %t250 = bitcast [8 x i8]* %t249 to i8*
  %t251 = bitcast i8* %t250 to i8**
  store i8* %t248, i8** %t251
  %t252 = load %NativeInstruction, %NativeInstruction* %t246
  %t253 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t254 = ptrtoint [1 x %NativeInstruction]* %t253 to i64
  %t255 = icmp eq i64 %t254, 0
  %t256 = select i1 %t255, i64 1, i64 %t254
  %t257 = call i8* @malloc(i64 %t256)
  %t258 = bitcast i8* %t257 to %NativeInstruction*
  %t259 = getelementptr %NativeInstruction, %NativeInstruction* %t258, i64 0
  store %NativeInstruction %t252, %NativeInstruction* %t259
  %t260 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t261 = ptrtoint { %NativeInstruction*, i64 }* %t260 to i64
  %t262 = call i8* @malloc(i64 %t261)
  %t263 = bitcast i8* %t262 to { %NativeInstruction*, i64 }*
  %t264 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t263, i32 0, i32 0
  store %NativeInstruction* %t258, %NativeInstruction** %t264
  %t265 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t263, i32 0, i32 1
  store i64 1, i64* %t265
  %t266 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t263, 0
  %t267 = insertvalue %InstructionParseResult %t266, i1 0, 1
  %t268 = insertvalue %InstructionParseResult %t267, i1 0, 2
  ret %InstructionParseResult %t268
merge23:
  %s269 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1187178968, i32 0, i32 0
  %t270 = call i1 @starts_with(i8* %line, i8* %s269)
  br i1 %t270, label %then24, label %merge25
then24:
  %t271 = call %NativeInstruction @parse_case_instruction(i8* %line)
  %t272 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t273 = ptrtoint [1 x %NativeInstruction]* %t272 to i64
  %t274 = icmp eq i64 %t273, 0
  %t275 = select i1 %t274, i64 1, i64 %t273
  %t276 = call i8* @malloc(i64 %t275)
  %t277 = bitcast i8* %t276 to %NativeInstruction*
  %t278 = getelementptr %NativeInstruction, %NativeInstruction* %t277, i64 0
  store %NativeInstruction %t271, %NativeInstruction* %t278
  %t279 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t280 = ptrtoint { %NativeInstruction*, i64 }* %t279 to i64
  %t281 = call i8* @malloc(i64 %t280)
  %t282 = bitcast i8* %t281 to { %NativeInstruction*, i64 }*
  %t283 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t282, i32 0, i32 0
  store %NativeInstruction* %t277, %NativeInstruction** %t283
  %t284 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t282, i32 0, i32 1
  store i64 1, i64* %t284
  %t285 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t282, 0
  %t286 = insertvalue %InstructionParseResult %t285, i1 0, 1
  %t287 = insertvalue %InstructionParseResult %t286, i1 0, 2
  ret %InstructionParseResult %t287
merge25:
  %s288 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1692644020, i32 0, i32 0
  %t289 = call i1 @strings_equal(i8* %line, i8* %s288)
  br i1 %t289, label %then26, label %merge27
then26:
  %t290 = insertvalue %NativeInstruction undef, i32 14, 0
  %t291 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t292 = ptrtoint [1 x %NativeInstruction]* %t291 to i64
  %t293 = icmp eq i64 %t292, 0
  %t294 = select i1 %t293, i64 1, i64 %t292
  %t295 = call i8* @malloc(i64 %t294)
  %t296 = bitcast i8* %t295 to %NativeInstruction*
  %t297 = getelementptr %NativeInstruction, %NativeInstruction* %t296, i64 0
  store %NativeInstruction %t290, %NativeInstruction* %t297
  %t298 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t299 = ptrtoint { %NativeInstruction*, i64 }* %t298 to i64
  %t300 = call i8* @malloc(i64 %t299)
  %t301 = bitcast i8* %t300 to { %NativeInstruction*, i64 }*
  %t302 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t301, i32 0, i32 0
  store %NativeInstruction* %t296, %NativeInstruction** %t302
  %t303 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t301, i32 0, i32 1
  store i64 1, i64* %t303
  %t304 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t301, 0
  %t305 = insertvalue %InstructionParseResult %t304, i1 0, 1
  %t306 = insertvalue %InstructionParseResult %t305, i1 0, 2
  ret %InstructionParseResult %t306
merge27:
  %s307 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064124065, i32 0, i32 0
  %t308 = call i1 @starts_with(i8* %line, i8* %s307)
  br i1 %t308, label %then28, label %merge29
then28:
  %t309 = call %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span)
  %t310 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t311 = ptrtoint [1 x %NativeInstruction]* %t310 to i64
  %t312 = icmp eq i64 %t311, 0
  %t313 = select i1 %t312, i64 1, i64 %t311
  %t314 = call i8* @malloc(i64 %t313)
  %t315 = bitcast i8* %t314 to %NativeInstruction*
  %t316 = getelementptr %NativeInstruction, %NativeInstruction* %t315, i64 0
  store %NativeInstruction %t309, %NativeInstruction* %t316
  %t317 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t318 = ptrtoint { %NativeInstruction*, i64 }* %t317 to i64
  %t319 = call i8* @malloc(i64 %t318)
  %t320 = bitcast i8* %t319 to { %NativeInstruction*, i64 }*
  %t321 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t320, i32 0, i32 0
  store %NativeInstruction* %t315, %NativeInstruction** %t321
  %t322 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t320, i32 0, i32 1
  store i64 1, i64* %t322
  %t323 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t320, 0
  %t324 = insertvalue %InstructionParseResult %t323, i1 1, 1
  %t325 = insertvalue %InstructionParseResult %t324, i1 1, 2
  ret %InstructionParseResult %t325
merge29:
  %s326 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h725262232, i32 0, i32 0
  %t327 = call i1 @starts_with(i8* %line, i8* %s326)
  br i1 %t327, label %then30, label %merge31
then30:
  %s328 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h725262232, i32 0, i32 0
  %t329 = call i8* @strip_prefix(i8* %line, i8* %s328)
  %t330 = call i8* @trim_text__native_ir(i8* %t329)
  store i8* %t330, i8** %l7
  %s331 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s331, i8** %l8
  %t332 = load i8*, i8** %l7
  %t333 = call i64 @sailfin_runtime_string_length(i8* %t332)
  %t334 = icmp sgt i64 %t333, 0
  %t335 = load i8*, i8** %l7
  %t336 = load i8*, i8** %l8
  br i1 %t334, label %then32, label %merge33
then32:
  %t337 = load i8*, i8** %l7
  %t338 = call i8* @trim_trailing_delimiters(i8* %t337)
  store i8* %t338, i8** %l8
  %t339 = load i8*, i8** %l8
  br label %merge33
merge33:
  %t340 = phi i8* [ %t339, %then32 ], [ %t336, %then30 ]
  store i8* %t340, i8** %l8
  %t341 = alloca %NativeInstruction
  %t342 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t341, i32 0, i32 0
  store i32 0, i32* %t342
  %t343 = load i8*, i8** %l8
  %t344 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t341, i32 0, i32 1
  %t345 = bitcast [16 x i8]* %t344 to i8*
  %t346 = bitcast i8* %t345 to i8**
  store i8* %t343, i8** %t346
  %t347 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t341, i32 0, i32 1
  %t348 = bitcast [16 x i8]* %t347 to i8*
  %t349 = getelementptr inbounds i8, i8* %t348, i64 8
  %t350 = bitcast i8* %t349 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t350
  %t351 = load %NativeInstruction, %NativeInstruction* %t341
  %t352 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t353 = ptrtoint [1 x %NativeInstruction]* %t352 to i64
  %t354 = icmp eq i64 %t353, 0
  %t355 = select i1 %t354, i64 1, i64 %t353
  %t356 = call i8* @malloc(i64 %t355)
  %t357 = bitcast i8* %t356 to %NativeInstruction*
  %t358 = getelementptr %NativeInstruction, %NativeInstruction* %t357, i64 0
  store %NativeInstruction %t351, %NativeInstruction* %t358
  %t359 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t360 = ptrtoint { %NativeInstruction*, i64 }* %t359 to i64
  %t361 = call i8* @malloc(i64 %t360)
  %t362 = bitcast i8* %t361 to { %NativeInstruction*, i64 }*
  %t363 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t362, i32 0, i32 0
  store %NativeInstruction* %t357, %NativeInstruction** %t363
  %t364 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t362, i32 0, i32 1
  store i64 1, i64* %t364
  %t365 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t362, 0
  %t366 = insertvalue %InstructionParseResult %t365, i1 1, 1
  %t367 = insertvalue %InstructionParseResult %t366, i1 0, 2
  ret %InstructionParseResult %t367
merge31:
  %s368 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2090684245, i32 0, i32 0
  %t369 = call i1 @starts_with(i8* %line, i8* %s368)
  br i1 %t369, label %then34, label %merge35
then34:
  %t370 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t371 = icmp eq i64 %t370, 3
  br i1 %t371, label %then36, label %merge37
then36:
  %t372 = alloca %NativeInstruction
  %t373 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t372, i32 0, i32 0
  store i32 0, i32* %t373
  %s374 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t375 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t372, i32 0, i32 1
  %t376 = bitcast [16 x i8]* %t375 to i8*
  %t377 = bitcast i8* %t376 to i8**
  store i8* %s374, i8** %t377
  %t378 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t372, i32 0, i32 1
  %t379 = bitcast [16 x i8]* %t378 to i8*
  %t380 = getelementptr inbounds i8, i8* %t379, i64 8
  %t381 = bitcast i8* %t380 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t381
  %t382 = load %NativeInstruction, %NativeInstruction* %t372
  %t383 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t384 = ptrtoint [1 x %NativeInstruction]* %t383 to i64
  %t385 = icmp eq i64 %t384, 0
  %t386 = select i1 %t385, i64 1, i64 %t384
  %t387 = call i8* @malloc(i64 %t386)
  %t388 = bitcast i8* %t387 to %NativeInstruction*
  %t389 = getelementptr %NativeInstruction, %NativeInstruction* %t388, i64 0
  store %NativeInstruction %t382, %NativeInstruction* %t389
  %t390 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t391 = ptrtoint { %NativeInstruction*, i64 }* %t390 to i64
  %t392 = call i8* @malloc(i64 %t391)
  %t393 = bitcast i8* %t392 to { %NativeInstruction*, i64 }*
  %t394 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t393, i32 0, i32 0
  store %NativeInstruction* %t388, %NativeInstruction** %t394
  %t395 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t393, i32 0, i32 1
  store i64 1, i64* %t395
  %t396 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t393, 0
  %t397 = insertvalue %InstructionParseResult %t396, i1 1, 1
  %t398 = insertvalue %InstructionParseResult %t397, i1 0, 2
  ret %InstructionParseResult %t398
merge37:
  %t399 = getelementptr i8, i8* %line, i64 3
  %t400 = load i8, i8* %t399
  store i8 %t400, i8* %l9
  %t402 = load i8, i8* %l9
  %t403 = icmp eq i8 %t402, 32
  br label %logical_or_entry_401

logical_or_entry_401:
  br i1 %t403, label %logical_or_merge_401, label %logical_or_right_401

logical_or_right_401:
  %t404 = load i8, i8* %l9
  %t405 = icmp eq i8 %t404, 9
  br label %logical_or_right_end_401

logical_or_right_end_401:
  br label %logical_or_merge_401

logical_or_merge_401:
  %t406 = phi i1 [ true, %logical_or_entry_401 ], [ %t405, %logical_or_right_end_401 ]
  %t407 = load i8, i8* %l9
  br i1 %t406, label %then38, label %merge39
then38:
  %t408 = call i64 @sailfin_runtime_string_length(i8* %line)
  %t409 = call i8* @sailfin_runtime_substring(i8* %line, i64 3, i64 %t408)
  %t410 = call i8* @trim_text__native_ir(i8* %t409)
  store i8* %t410, i8** %l10
  %t411 = load i8*, i8** %l10
  %t412 = call i64 @sailfin_runtime_string_length(i8* %t411)
  %t413 = icmp eq i64 %t412, 0
  %t414 = load i8, i8* %l9
  %t415 = load i8*, i8** %l10
  br i1 %t413, label %then40, label %merge41
then40:
  %t416 = alloca %NativeInstruction
  %t417 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t416, i32 0, i32 0
  store i32 0, i32* %t417
  %s418 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t419 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t416, i32 0, i32 1
  %t420 = bitcast [16 x i8]* %t419 to i8*
  %t421 = bitcast i8* %t420 to i8**
  store i8* %s418, i8** %t421
  %t422 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t416, i32 0, i32 1
  %t423 = bitcast [16 x i8]* %t422 to i8*
  %t424 = getelementptr inbounds i8, i8* %t423, i64 8
  %t425 = bitcast i8* %t424 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t425
  %t426 = load %NativeInstruction, %NativeInstruction* %t416
  %t427 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t428 = ptrtoint [1 x %NativeInstruction]* %t427 to i64
  %t429 = icmp eq i64 %t428, 0
  %t430 = select i1 %t429, i64 1, i64 %t428
  %t431 = call i8* @malloc(i64 %t430)
  %t432 = bitcast i8* %t431 to %NativeInstruction*
  %t433 = getelementptr %NativeInstruction, %NativeInstruction* %t432, i64 0
  store %NativeInstruction %t426, %NativeInstruction* %t433
  %t434 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t435 = ptrtoint { %NativeInstruction*, i64 }* %t434 to i64
  %t436 = call i8* @malloc(i64 %t435)
  %t437 = bitcast i8* %t436 to { %NativeInstruction*, i64 }*
  %t438 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t437, i32 0, i32 0
  store %NativeInstruction* %t432, %NativeInstruction** %t438
  %t439 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t437, i32 0, i32 1
  store i64 1, i64* %t439
  %t440 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t437, 0
  %t441 = insertvalue %InstructionParseResult %t440, i1 1, 1
  %t442 = insertvalue %InstructionParseResult %t441, i1 0, 2
  ret %InstructionParseResult %t442
merge41:
  %t443 = alloca %NativeInstruction
  %t444 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t443, i32 0, i32 0
  store i32 0, i32* %t444
  %t445 = load i8*, i8** %l10
  %t446 = call i8* @trim_trailing_delimiters(i8* %t445)
  %t447 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t443, i32 0, i32 1
  %t448 = bitcast [16 x i8]* %t447 to i8*
  %t449 = bitcast i8* %t448 to i8**
  store i8* %t446, i8** %t449
  %t450 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t443, i32 0, i32 1
  %t451 = bitcast [16 x i8]* %t450 to i8*
  %t452 = getelementptr inbounds i8, i8* %t451, i64 8
  %t453 = bitcast i8* %t452 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t453
  %t454 = load %NativeInstruction, %NativeInstruction* %t443
  %t455 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t456 = ptrtoint [1 x %NativeInstruction]* %t455 to i64
  %t457 = icmp eq i64 %t456, 0
  %t458 = select i1 %t457, i64 1, i64 %t456
  %t459 = call i8* @malloc(i64 %t458)
  %t460 = bitcast i8* %t459 to %NativeInstruction*
  %t461 = getelementptr %NativeInstruction, %NativeInstruction* %t460, i64 0
  store %NativeInstruction %t454, %NativeInstruction* %t461
  %t462 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t463 = ptrtoint { %NativeInstruction*, i64 }* %t462 to i64
  %t464 = call i8* @malloc(i64 %t463)
  %t465 = bitcast i8* %t464 to { %NativeInstruction*, i64 }*
  %t466 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t465, i32 0, i32 0
  store %NativeInstruction* %t460, %NativeInstruction** %t466
  %t467 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t465, i32 0, i32 1
  store i64 1, i64* %t467
  %t468 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t465, 0
  %t469 = insertvalue %InstructionParseResult %t468, i1 1, 1
  %t470 = insertvalue %InstructionParseResult %t469, i1 0, 2
  ret %InstructionParseResult %t470
merge39:
  br label %merge35
merge35:
  %s471 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h890937508, i32 0, i32 0
  %t472 = call i1 @starts_with(i8* %line, i8* %s471)
  br i1 %t472, label %then42, label %merge43
then42:
  %s473 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h890937508, i32 0, i32 0
  %t474 = call i8* @strip_prefix(i8* %line, i8* %s473)
  %t475 = call i8* @trim_text__native_ir(i8* %t474)
  store i8* %t475, i8** %l11
  store i1 0, i1* %l12
  %t476 = load i8*, i8** %l11
  %s477 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t478 = call i1 @starts_with(i8* %t476, i8* %s477)
  %t479 = load i8*, i8** %l11
  %t480 = load i1, i1* %l12
  br i1 %t478, label %then44, label %merge45
then44:
  store i1 1, i1* %l12
  %t481 = load i8*, i8** %l11
  %s482 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t483 = call i8* @strip_prefix(i8* %t481, i8* %s482)
  %t484 = call i8* @trim_text__native_ir(i8* %t483)
  store i8* %t484, i8** %l11
  %t485 = load i1, i1* %l12
  %t486 = load i8*, i8** %l11
  br label %merge45
merge45:
  %t487 = phi i1 [ %t485, %then44 ], [ %t480, %then42 ]
  %t488 = phi i8* [ %t486, %then44 ], [ %t479, %then42 ]
  store i1 %t487, i1* %l12
  store i8* %t488, i8** %l11
  %t489 = load i8*, i8** %l11
  %t490 = call %BindingComponents @parse_binding_components(i8* %t489)
  store %BindingComponents %t490, %BindingComponents* %l13
  %t491 = alloca %NativeInstruction
  %t492 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t491, i32 0, i32 0
  store i32 2, i32* %t492
  %t493 = load %BindingComponents, %BindingComponents* %l13
  %t494 = extractvalue %BindingComponents %t493, 0
  %t495 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t491, i32 0, i32 1
  %t496 = bitcast [48 x i8]* %t495 to i8*
  %t497 = bitcast i8* %t496 to i8**
  store i8* %t494, i8** %t497
  %t498 = load i1, i1* %l12
  %t499 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t491, i32 0, i32 1
  %t500 = bitcast [48 x i8]* %t499 to i8*
  %t501 = getelementptr inbounds i8, i8* %t500, i64 8
  %t502 = bitcast i8* %t501 to i1*
  store i1 %t498, i1* %t502
  %t503 = load %BindingComponents, %BindingComponents* %l13
  %t504 = extractvalue %BindingComponents %t503, 1
  %t505 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t491, i32 0, i32 1
  %t506 = bitcast [48 x i8]* %t505 to i8*
  %t507 = getelementptr inbounds i8, i8* %t506, i64 16
  %t508 = bitcast i8* %t507 to i8**
  store i8* %t504, i8** %t508
  %t509 = load %BindingComponents, %BindingComponents* %l13
  %t510 = extractvalue %BindingComponents %t509, 2
  %t511 = call i8* @maybe_trim_trailing(i8* %t510)
  %t512 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t491, i32 0, i32 1
  %t513 = bitcast [48 x i8]* %t512 to i8*
  %t514 = getelementptr inbounds i8, i8* %t513, i64 24
  %t515 = bitcast i8* %t514 to i8**
  store i8* %t511, i8** %t515
  %t516 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t491, i32 0, i32 1
  %t517 = bitcast [48 x i8]* %t516 to i8*
  %t518 = getelementptr inbounds i8, i8* %t517, i64 32
  %t519 = bitcast i8* %t518 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t519
  %t520 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t491, i32 0, i32 1
  %t521 = bitcast [48 x i8]* %t520 to i8*
  %t522 = getelementptr inbounds i8, i8* %t521, i64 40
  %t523 = bitcast i8* %t522 to %NativeSourceSpan**
  store %NativeSourceSpan* %value_span, %NativeSourceSpan** %t523
  %t524 = load %NativeInstruction, %NativeInstruction* %t491
  %t525 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t526 = ptrtoint [1 x %NativeInstruction]* %t525 to i64
  %t527 = icmp eq i64 %t526, 0
  %t528 = select i1 %t527, i64 1, i64 %t526
  %t529 = call i8* @malloc(i64 %t528)
  %t530 = bitcast i8* %t529 to %NativeInstruction*
  %t531 = getelementptr %NativeInstruction, %NativeInstruction* %t530, i64 0
  store %NativeInstruction %t524, %NativeInstruction* %t531
  %t532 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t533 = ptrtoint { %NativeInstruction*, i64 }* %t532 to i64
  %t534 = call i8* @malloc(i64 %t533)
  %t535 = bitcast i8* %t534 to { %NativeInstruction*, i64 }*
  %t536 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t535, i32 0, i32 0
  store %NativeInstruction* %t530, %NativeInstruction** %t536
  %t537 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t535, i32 0, i32 1
  store i64 1, i64* %t537
  %t538 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t535, 0
  %t539 = insertvalue %InstructionParseResult %t538, i1 1, 1
  %t540 = insertvalue %InstructionParseResult %t539, i1 1, 2
  ret %InstructionParseResult %t540
merge43:
  %s541 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t542 = call i1 @starts_with(i8* %line, i8* %s541)
  br i1 %t542, label %then46, label %merge47
then46:
  %t543 = alloca %NativeInstruction
  %t544 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t543, i32 0, i32 0
  store i32 1, i32* %t544
  %s545 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2080793783, i32 0, i32 0
  %t546 = call i8* @strip_prefix(i8* %line, i8* %s545)
  %t547 = call i8* @trim_text__native_ir(i8* %t546)
  %t548 = call i8* @trim_trailing_delimiters(i8* %t547)
  %t549 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t543, i32 0, i32 1
  %t550 = bitcast [16 x i8]* %t549 to i8*
  %t551 = bitcast i8* %t550 to i8**
  store i8* %t548, i8** %t551
  %t552 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t543, i32 0, i32 1
  %t553 = bitcast [16 x i8]* %t552 to i8*
  %t554 = getelementptr inbounds i8, i8* %t553, i64 8
  %t555 = bitcast i8* %t554 to %NativeSourceSpan**
  store %NativeSourceSpan* %span, %NativeSourceSpan** %t555
  %t556 = load %NativeInstruction, %NativeInstruction* %t543
  %t557 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t558 = ptrtoint [1 x %NativeInstruction]* %t557 to i64
  %t559 = icmp eq i64 %t558, 0
  %t560 = select i1 %t559, i64 1, i64 %t558
  %t561 = call i8* @malloc(i64 %t560)
  %t562 = bitcast i8* %t561 to %NativeInstruction*
  %t563 = getelementptr %NativeInstruction, %NativeInstruction* %t562, i64 0
  store %NativeInstruction %t556, %NativeInstruction* %t563
  %t564 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t565 = ptrtoint { %NativeInstruction*, i64 }* %t564 to i64
  %t566 = call i8* @malloc(i64 %t565)
  %t567 = bitcast i8* %t566 to { %NativeInstruction*, i64 }*
  %t568 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t567, i32 0, i32 0
  store %NativeInstruction* %t562, %NativeInstruction** %t568
  %t569 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t567, i32 0, i32 1
  store i64 1, i64* %t569
  %t570 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t567, 0
  %t571 = insertvalue %InstructionParseResult %t570, i1 1, 1
  %t572 = insertvalue %InstructionParseResult %t571, i1 0, 2
  ret %InstructionParseResult %t572
merge47:
  %s573 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193445474, i32 0, i32 0
  %t574 = call double @index_of(i8* %line, i8* %s573)
  %t575 = sitofp i64 0 to double
  %t576 = fcmp oge double %t574, %t575
  br i1 %t576, label %then48, label %merge49
then48:
  %t577 = call { %NativeInstruction*, i64 }* @parse_inline_case_instruction(i8* %line)
  %t578 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t577, 0
  %t579 = insertvalue %InstructionParseResult %t578, i1 0, 1
  %t580 = insertvalue %InstructionParseResult %t579, i1 0, 2
  ret %InstructionParseResult %t580
merge49:
  %t581 = alloca %NativeInstruction
  %t582 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t581, i32 0, i32 0
  store i32 16, i32* %t582
  %t583 = getelementptr inbounds %NativeInstruction, %NativeInstruction* %t581, i32 0, i32 1
  %t584 = bitcast [8 x i8]* %t583 to i8*
  %t585 = bitcast i8* %t584 to i8**
  store i8* %line, i8** %t585
  %t586 = load %NativeInstruction, %NativeInstruction* %t581
  %t587 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t588 = ptrtoint [1 x %NativeInstruction]* %t587 to i64
  %t589 = icmp eq i64 %t588, 0
  %t590 = select i1 %t589, i64 1, i64 %t588
  %t591 = call i8* @malloc(i64 %t590)
  %t592 = bitcast i8* %t591 to %NativeInstruction*
  %t593 = getelementptr %NativeInstruction, %NativeInstruction* %t592, i64 0
  store %NativeInstruction %t586, %NativeInstruction* %t593
  %t594 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t595 = ptrtoint { %NativeInstruction*, i64 }* %t594 to i64
  %t596 = call i8* @malloc(i64 %t595)
  %t597 = bitcast i8* %t596 to { %NativeInstruction*, i64 }*
  %t598 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t597, i32 0, i32 0
  store %NativeInstruction* %t592, %NativeInstruction** %t598
  %t599 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t597, i32 0, i32 1
  store i64 1, i64* %t599
  %t600 = insertvalue %InstructionParseResult undef, { %NativeInstruction*, i64 }* %t597, 0
  %t601 = insertvalue %InstructionParseResult %t600, i1 0, 1
  %t602 = insertvalue %InstructionParseResult %t601, i1 0, 2
  ret %InstructionParseResult %t602
}

define %NativeInstruction @parse_case_instruction(i8* %line) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca %CaseComponents
  %s0 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1187178968, i32 0, i32 0
  %t1 = call i8* @strip_prefix(i8* %line, i8* %s0)
  %t2 = call i8* @trim_text__native_ir(i8* %t1)
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
  %t0 = call i8* @trim_text__native_ir(i8* %line)
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
  %t34 = call i8* @trim_text__native_ir(i8* %t33)
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
  %t44 = call i8* @trim_text__native_ir(i8* %t43)
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
  %t75 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t76 = ptrtoint [1 x %NativeInstruction]* %t75 to i64
  %t77 = icmp eq i64 %t76, 0
  %t78 = select i1 %t77, i64 1, i64 %t76
  %t79 = call i8* @malloc(i64 %t78)
  %t80 = bitcast i8* %t79 to %NativeInstruction*
  %t81 = getelementptr %NativeInstruction, %NativeInstruction* %t80, i64 0
  store %NativeInstruction %t74, %NativeInstruction* %t81
  %t82 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t83 = ptrtoint { %NativeInstruction*, i64 }* %t82 to i64
  %t84 = call i8* @malloc(i64 %t83)
  %t85 = bitcast i8* %t84 to { %NativeInstruction*, i64 }*
  %t86 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t85, i32 0, i32 0
  store %NativeInstruction* %t80, %NativeInstruction** %t86
  %t87 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t85, i32 0, i32 1
  store i64 1, i64* %t87
  %t88 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t60, i32 0, i32 0
  %t89 = load %NativeInstruction*, %NativeInstruction** %t88
  %t90 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t60, i32 0, i32 1
  %t91 = load i64, i64* %t90
  %t92 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t85, i32 0, i32 0
  %t93 = load %NativeInstruction*, %NativeInstruction** %t92
  %t94 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t85, i32 0, i32 1
  %t95 = load i64, i64* %t94
  %t96 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 0, i32 1
  %t97 = ptrtoint %NativeInstruction* %t96 to i64
  %t98 = add i64 %t91, %t95
  %t99 = mul i64 %t97, %t98
  %t100 = call noalias i8* @malloc(i64 %t99)
  %t101 = bitcast i8* %t100 to %NativeInstruction*
  %t102 = bitcast %NativeInstruction* %t101 to i8*
  %t103 = mul i64 %t97, %t91
  %t104 = bitcast %NativeInstruction* %t89 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t102, i8* %t104, i64 %t103)
  %t105 = mul i64 %t97, %t95
  %t106 = bitcast %NativeInstruction* %t93 to i8*
  %t107 = getelementptr %NativeInstruction, %NativeInstruction* %t101, i64 %t91
  %t108 = bitcast %NativeInstruction* %t107 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t108, i8* %t106, i64 %t105)
  %t109 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t110 = ptrtoint { %NativeInstruction*, i64 }* %t109 to i64
  %t111 = call i8* @malloc(i64 %t110)
  %t112 = bitcast i8* %t111 to { %NativeInstruction*, i64 }*
  %t113 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t112, i32 0, i32 0
  store %NativeInstruction* %t101, %NativeInstruction** %t113
  %t114 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t112, i32 0, i32 1
  store i64 %t98, i64* %t114
  store { %NativeInstruction*, i64 }* %t112, { %NativeInstruction*, i64 }** %l5
  %t115 = load i8*, i8** %l3
  %t116 = call i64 @sailfin_runtime_string_length(i8* %t115)
  %t117 = icmp eq i64 %t116, 0
  %t118 = load i8*, i8** %l0
  %t119 = load double, double* %l1
  %t120 = load i8*, i8** %l2
  %t121 = load i8*, i8** %l3
  %t122 = load %CaseComponents, %CaseComponents* %l4
  %t123 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  br i1 %t117, label %then2, label %merge3
then2:
  %t124 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t125 = insertvalue %NativeInstruction undef, i32 15, 0
  %t126 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t127 = ptrtoint [1 x %NativeInstruction]* %t126 to i64
  %t128 = icmp eq i64 %t127, 0
  %t129 = select i1 %t128, i64 1, i64 %t127
  %t130 = call i8* @malloc(i64 %t129)
  %t131 = bitcast i8* %t130 to %NativeInstruction*
  %t132 = getelementptr %NativeInstruction, %NativeInstruction* %t131, i64 0
  store %NativeInstruction %t125, %NativeInstruction* %t132
  %t133 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t134 = ptrtoint { %NativeInstruction*, i64 }* %t133 to i64
  %t135 = call i8* @malloc(i64 %t134)
  %t136 = bitcast i8* %t135 to { %NativeInstruction*, i64 }*
  %t137 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t136, i32 0, i32 0
  store %NativeInstruction* %t131, %NativeInstruction** %t137
  %t138 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t136, i32 0, i32 1
  store i64 1, i64* %t138
  %t139 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t124, i32 0, i32 0
  %t140 = load %NativeInstruction*, %NativeInstruction** %t139
  %t141 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t124, i32 0, i32 1
  %t142 = load i64, i64* %t141
  %t143 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t136, i32 0, i32 0
  %t144 = load %NativeInstruction*, %NativeInstruction** %t143
  %t145 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t136, i32 0, i32 1
  %t146 = load i64, i64* %t145
  %t147 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 0, i32 1
  %t148 = ptrtoint %NativeInstruction* %t147 to i64
  %t149 = add i64 %t142, %t146
  %t150 = mul i64 %t148, %t149
  %t151 = call noalias i8* @malloc(i64 %t150)
  %t152 = bitcast i8* %t151 to %NativeInstruction*
  %t153 = bitcast %NativeInstruction* %t152 to i8*
  %t154 = mul i64 %t148, %t142
  %t155 = bitcast %NativeInstruction* %t140 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t153, i8* %t155, i64 %t154)
  %t156 = mul i64 %t148, %t146
  %t157 = bitcast %NativeInstruction* %t144 to i8*
  %t158 = getelementptr %NativeInstruction, %NativeInstruction* %t152, i64 %t142
  %t159 = bitcast %NativeInstruction* %t158 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t159, i8* %t157, i64 %t156)
  %t160 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t161 = ptrtoint { %NativeInstruction*, i64 }* %t160 to i64
  %t162 = call i8* @malloc(i64 %t161)
  %t163 = bitcast i8* %t162 to { %NativeInstruction*, i64 }*
  %t164 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t163, i32 0, i32 0
  store %NativeInstruction* %t152, %NativeInstruction** %t164
  %t165 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t163, i32 0, i32 1
  store i64 %t149, i64* %t165
  store { %NativeInstruction*, i64 }* %t163, { %NativeInstruction*, i64 }** %l5
  %t166 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t166
merge3:
  %t167 = load i8*, i8** %l3
  %t168 = call %NativeInstruction @parse_inline_case_body_instruction(i8* %t167)
  store %NativeInstruction %t168, %NativeInstruction* %l6
  %t169 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  %t170 = load %NativeInstruction, %NativeInstruction* %l6
  %t171 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 1
  %t172 = ptrtoint [1 x %NativeInstruction]* %t171 to i64
  %t173 = icmp eq i64 %t172, 0
  %t174 = select i1 %t173, i64 1, i64 %t172
  %t175 = call i8* @malloc(i64 %t174)
  %t176 = bitcast i8* %t175 to %NativeInstruction*
  %t177 = getelementptr %NativeInstruction, %NativeInstruction* %t176, i64 0
  store %NativeInstruction %t170, %NativeInstruction* %t177
  %t178 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t179 = ptrtoint { %NativeInstruction*, i64 }* %t178 to i64
  %t180 = call i8* @malloc(i64 %t179)
  %t181 = bitcast i8* %t180 to { %NativeInstruction*, i64 }*
  %t182 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t181, i32 0, i32 0
  store %NativeInstruction* %t176, %NativeInstruction** %t182
  %t183 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t181, i32 0, i32 1
  store i64 1, i64* %t183
  %t184 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t169, i32 0, i32 0
  %t185 = load %NativeInstruction*, %NativeInstruction** %t184
  %t186 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t169, i32 0, i32 1
  %t187 = load i64, i64* %t186
  %t188 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t181, i32 0, i32 0
  %t189 = load %NativeInstruction*, %NativeInstruction** %t188
  %t190 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t181, i32 0, i32 1
  %t191 = load i64, i64* %t190
  %t192 = getelementptr [1 x %NativeInstruction], [1 x %NativeInstruction]* null, i32 0, i32 1
  %t193 = ptrtoint %NativeInstruction* %t192 to i64
  %t194 = add i64 %t187, %t191
  %t195 = mul i64 %t193, %t194
  %t196 = call noalias i8* @malloc(i64 %t195)
  %t197 = bitcast i8* %t196 to %NativeInstruction*
  %t198 = bitcast %NativeInstruction* %t197 to i8*
  %t199 = mul i64 %t193, %t187
  %t200 = bitcast %NativeInstruction* %t185 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t198, i8* %t200, i64 %t199)
  %t201 = mul i64 %t193, %t191
  %t202 = bitcast %NativeInstruction* %t189 to i8*
  %t203 = getelementptr %NativeInstruction, %NativeInstruction* %t197, i64 %t187
  %t204 = bitcast %NativeInstruction* %t203 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t204, i8* %t202, i64 %t201)
  %t205 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t206 = ptrtoint { %NativeInstruction*, i64 }* %t205 to i64
  %t207 = call i8* @malloc(i64 %t206)
  %t208 = bitcast i8* %t207 to { %NativeInstruction*, i64 }*
  %t209 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t208, i32 0, i32 0
  store %NativeInstruction* %t197, %NativeInstruction** %t209
  %t210 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t208, i32 0, i32 1
  store i64 %t194, i64* %t210
  store { %NativeInstruction*, i64 }* %t208, { %NativeInstruction*, i64 }** %l5
  %t211 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l5
  ret { %NativeInstruction*, i64 }* %t211
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
  %t8 = call i8* @trim_text__native_ir(i8* %t7)
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
  %t31 = call i8* @trim_text__native_ir(i8* %t30)
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t26 = call i8* @trim_text__native_ir(i8* %t25)
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
  %t38 = call i8* @trim_text__native_ir(i8* %t37)
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
  %t0 = call i8* @trim_text__native_ir(i8* %entry)
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
  %t20 = add i64 0, 2
  %t21 = call i8* @malloc(i64 %t20)
  store i8 123, i8* %t21
  %t22 = getelementptr i8, i8* %t21, i64 1
  store i8 0, i8* %t22
  call void @sailfin_runtime_mark_persistent(i8* %t21)
  %t23 = call double @index_of(i8* %t19, i8* %t21)
  store double %t23, double* %l3
  %t24 = load double, double* %l3
  %t25 = sitofp i64 0 to double
  %t26 = fcmp oge double %t24, %t25
  %t27 = load i8*, i8** %l0
  %t28 = load i8*, i8** %l1
  %t29 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t30 = load double, double* %l3
  br i1 %t26, label %then2, label %merge3
then2:
  %t31 = load i8*, i8** %l0
  %t32 = add i64 0, 2
  %t33 = call i8* @malloc(i64 %t32)
  store i8 125, i8* %t33
  %t34 = getelementptr i8, i8* %t33, i64 1
  store i8 0, i8* %t34
  call void @sailfin_runtime_mark_persistent(i8* %t33)
  %t35 = call double @last_index_of(i8* %t31, i8* %t33)
  store double %t35, double* %l4
  %t37 = load double, double* %l4
  %t38 = sitofp i64 0 to double
  %t39 = fcmp olt double %t37, %t38
  br label %logical_or_entry_36

logical_or_entry_36:
  br i1 %t39, label %logical_or_merge_36, label %logical_or_right_36

logical_or_right_36:
  %t40 = load double, double* %l4
  %t41 = load double, double* %l3
  %t42 = fcmp ole double %t40, %t41
  br label %logical_or_right_end_36

logical_or_right_end_36:
  br label %logical_or_merge_36

logical_or_merge_36:
  %t43 = phi i1 [ true, %logical_or_entry_36 ], [ %t42, %logical_or_right_end_36 ]
  %t44 = load i8*, i8** %l0
  %t45 = load i8*, i8** %l1
  %t46 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t47 = load double, double* %l3
  %t48 = load double, double* %l4
  br i1 %t43, label %then4, label %merge5
then4:
  %t49 = bitcast i8* null to %NativeImport*
  ret %NativeImport* %t49
merge5:
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l3
  %t52 = call double @llvm.round.f64(double %t51)
  %t53 = fptosi double %t52 to i64
  %t54 = call i8* @sailfin_runtime_substring(i8* %t50, i64 0, i64 %t53)
  %t55 = call i8* @trim_text__native_ir(i8* %t54)
  store i8* %t55, i8** %l1
  %t56 = load i8*, i8** %l0
  %t57 = load double, double* %l3
  %t58 = sitofp i64 1 to double
  %t59 = fadd double %t57, %t58
  %t60 = load double, double* %l4
  %t61 = call double @llvm.round.f64(double %t59)
  %t62 = fptosi double %t61 to i64
  %t63 = call double @llvm.round.f64(double %t60)
  %t64 = fptosi double %t63 to i64
  %t65 = call i8* @sailfin_runtime_substring(i8* %t56, i64 %t62, i64 %t64)
  store i8* %t65, i8** %l5
  %t66 = load i8*, i8** %l5
  %t67 = call { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %t66)
  store { %NativeImportSpecifier*, i64 }* %t67, { %NativeImportSpecifier*, i64 }** %l2
  %t68 = load i8*, i8** %l1
  %t69 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge3
merge3:
  %t70 = phi i8* [ %t68, %merge5 ], [ %t28, %merge1 ]
  %t71 = phi { %NativeImportSpecifier*, i64 }* [ %t69, %merge5 ], [ %t29, %merge1 ]
  store i8* %t70, i8** %l1
  store { %NativeImportSpecifier*, i64 }* %t71, { %NativeImportSpecifier*, i64 }** %l2
  %t72 = load i8*, i8** %l1
  %t73 = call i8* @trim_text__native_ir(i8* %t72)
  %t74 = call i8* @strip_quotes(i8* %t73)
  store i8* %t74, i8** %l1
  %t75 = insertvalue %NativeImport undef, i8* %kind, 0
  %t76 = load i8*, i8** %l1
  %t77 = insertvalue %NativeImport %t75, i8* %t76, 1
  %t78 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t79 = insertvalue %NativeImport %t77, { %NativeImportSpecifier*, i64 }* %t78, 2
  %t80 = alloca %NativeImport
  store %NativeImport %t79, %NativeImport* %t80
  ret %NativeImport* %t80
}

define { %NativeImportSpecifier*, i64 }* @parse_import_specifiers(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca { i8**, i64 }*
  %l2 = alloca { %NativeImportSpecifier*, i64 }*
  %l3 = alloca double
  %l4 = alloca %NativeImportSpecifier
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t115 = phi { %NativeImportSpecifier*, i64 }* [ %t34, %merge1 ], [ %t113, %loop.latch4 ]
  %t116 = phi double [ %t35, %merge1 ], [ %t114, %loop.latch4 ]
  store { %NativeImportSpecifier*, i64 }* %t115, { %NativeImportSpecifier*, i64 }** %l2
  store double %t116, double* %l3
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
  %t68 = getelementptr [1 x %NativeImportSpecifier], [1 x %NativeImportSpecifier]* null, i32 1
  %t69 = ptrtoint [1 x %NativeImportSpecifier]* %t68 to i64
  %t70 = icmp eq i64 %t69, 0
  %t71 = select i1 %t70, i64 1, i64 %t69
  %t72 = call i8* @malloc(i64 %t71)
  %t73 = bitcast i8* %t72 to %NativeImportSpecifier*
  %t74 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t73, i64 0
  store %NativeImportSpecifier %t67, %NativeImportSpecifier* %t74
  %t75 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* null, i32 1
  %t76 = ptrtoint { %NativeImportSpecifier*, i64 }* %t75 to i64
  %t77 = call i8* @malloc(i64 %t76)
  %t78 = bitcast i8* %t77 to { %NativeImportSpecifier*, i64 }*
  %t79 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t78, i32 0, i32 0
  store %NativeImportSpecifier* %t73, %NativeImportSpecifier** %t79
  %t80 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t78, i32 0, i32 1
  store i64 1, i64* %t80
  %t81 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t66, i32 0, i32 0
  %t82 = load %NativeImportSpecifier*, %NativeImportSpecifier** %t81
  %t83 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t66, i32 0, i32 1
  %t84 = load i64, i64* %t83
  %t85 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t78, i32 0, i32 0
  %t86 = load %NativeImportSpecifier*, %NativeImportSpecifier** %t85
  %t87 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t78, i32 0, i32 1
  %t88 = load i64, i64* %t87
  %t89 = getelementptr [1 x %NativeImportSpecifier], [1 x %NativeImportSpecifier]* null, i32 0, i32 1
  %t90 = ptrtoint %NativeImportSpecifier* %t89 to i64
  %t91 = add i64 %t84, %t88
  %t92 = mul i64 %t90, %t91
  %t93 = call noalias i8* @malloc(i64 %t92)
  %t94 = bitcast i8* %t93 to %NativeImportSpecifier*
  %t95 = bitcast %NativeImportSpecifier* %t94 to i8*
  %t96 = mul i64 %t90, %t84
  %t97 = bitcast %NativeImportSpecifier* %t82 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t95, i8* %t97, i64 %t96)
  %t98 = mul i64 %t90, %t88
  %t99 = bitcast %NativeImportSpecifier* %t86 to i8*
  %t100 = getelementptr %NativeImportSpecifier, %NativeImportSpecifier* %t94, i64 %t84
  %t101 = bitcast %NativeImportSpecifier* %t100 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t101, i8* %t99, i64 %t98)
  %t102 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* null, i32 1
  %t103 = ptrtoint { %NativeImportSpecifier*, i64 }* %t102 to i64
  %t104 = call i8* @malloc(i64 %t103)
  %t105 = bitcast i8* %t104 to { %NativeImportSpecifier*, i64 }*
  %t106 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t105, i32 0, i32 0
  store %NativeImportSpecifier* %t94, %NativeImportSpecifier** %t106
  %t107 = getelementptr { %NativeImportSpecifier*, i64 }, { %NativeImportSpecifier*, i64 }* %t105, i32 0, i32 1
  store i64 %t91, i64* %t107
  store { %NativeImportSpecifier*, i64 }* %t105, { %NativeImportSpecifier*, i64 }** %l2
  %t108 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  br label %merge9
merge9:
  %t109 = phi { %NativeImportSpecifier*, i64 }* [ %t108, %then8 ], [ %t63, %merge7 ]
  store { %NativeImportSpecifier*, i64 }* %t109, { %NativeImportSpecifier*, i64 }** %l2
  %t110 = load double, double* %l3
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l3
  br label %loop.latch4
loop.latch4:
  %t113 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t114 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t117 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t118 = load double, double* %l3
  %t119 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  ret { %NativeImportSpecifier*, i64 }* %t119
}

define %NativeImportSpecifier @parse_single_specifier(i8* %entry) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i8*
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text__native_ir(i8* %entry)
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
  %t26 = call i8* @trim_text__native_ir(i8* %t25)
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
  %t38 = call i8* @trim_text__native_ir(i8* %t37)
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
  %t20 = call i8* @trim_text__native_ir(i8* %t19)
  store i8* %t20, i8** %l1
  %t21 = load i8*, i8** %l1
  %s22 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h2093451461, i32 0, i32 0
  %t23 = call i8* @strip_prefix(i8* %t21, i8* %s22)
  %t24 = call i8* @trim_text__native_ir(i8* %t23)
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
  %t1250 = phi { i8**, i64 }* [ %t99, %merge1 ], [ %t1238, %loop.latch4 ]
  %t1251 = phi double [ %t115, %merge1 ], [ %t1239, %loop.latch4 ]
  %t1252 = phi { %NativeFunction*, i64 }* [ %t106, %merge1 ], [ %t1240, %loop.latch4 ]
  %t1253 = phi %NativeFunction* [ %t107, %merge1 ], [ %t1241, %loop.latch4 ]
  %t1254 = phi %NativeSourceSpan* [ %t108, %merge1 ], [ %t1242, %loop.latch4 ]
  %t1255 = phi %NativeSourceSpan* [ %t109, %merge1 ], [ %t1243, %loop.latch4 ]
  %t1256 = phi double [ %t111, %merge1 ], [ %t1244, %loop.latch4 ]
  %t1257 = phi double [ %t112, %merge1 ], [ %t1245, %loop.latch4 ]
  %t1258 = phi i1 [ %t113, %merge1 ], [ %t1246, %loop.latch4 ]
  %t1259 = phi { %NativeStructLayoutField*, i64 }* [ %t110, %merge1 ], [ %t1247, %loop.latch4 ]
  %t1260 = phi i1 [ %t114, %merge1 ], [ %t1248, %loop.latch4 ]
  %t1261 = phi { %NativeStructField*, i64 }* [ %t105, %merge1 ], [ %t1249, %loop.latch4 ]
  store { i8**, i64 }* %t1250, { i8**, i64 }** %l0
  store double %t1251, double* %l16
  store { %NativeFunction*, i64 }* %t1252, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t1253, %NativeFunction** %l8
  store %NativeSourceSpan* %t1254, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1255, %NativeSourceSpan** %l10
  store double %t1256, double* %l12
  store double %t1257, double* %l13
  store i1 %t1258, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t1259, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t1260, i1* %l15
  store { %NativeStructField*, i64 }* %t1261, { %NativeStructField*, i64 }** %l6
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
  %t168 = insertvalue %NativeStructLayout %t166, { %NativeStructLayoutField*, i64 }* %t167, 2
  %t169 = alloca %NativeStructLayout
  store %NativeStructLayout %t168, %NativeStructLayout* %t169
  store %NativeStructLayout* %t169, %NativeStructLayout** %l17
  %t170 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br label %merge9
merge9:
  %t171 = phi %NativeStructLayout* [ %t170, %then8 ], [ %t162, %then6 ]
  store %NativeStructLayout* %t171, %NativeStructLayout** %l17
  %t172 = load i8*, i8** %l4
  %t173 = insertvalue %NativeStruct undef, i8* %t172, 0
  %t174 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t175 = insertvalue %NativeStruct %t173, { %NativeStructField*, i64 }* %t174, 1
  %t176 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t177 = insertvalue %NativeStruct %t175, { %NativeFunction*, i64 }* %t176, 2
  %t178 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t179 = insertvalue %NativeStruct %t177, { i8**, i64 }* %t178, 3
  %t180 = load %NativeStructLayout*, %NativeStructLayout** %l17
  %t181 = insertvalue %NativeStruct %t179, %NativeStructLayout* %t180, 4
  %t182 = alloca %NativeStruct
  store %NativeStruct %t181, %NativeStruct* %t182
  %t183 = insertvalue %StructParseResult undef, %NativeStruct* %t182, 0
  %t184 = load double, double* %l16
  %t185 = insertvalue %StructParseResult %t183, double %t184, 1
  %t186 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t187 = insertvalue %StructParseResult %t185, { i8**, i64 }* %t186, 2
  ret %StructParseResult %t187
merge7:
  %t188 = load double, double* %l16
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
  %t197 = call i8* @trim_text__native_ir(i8* %t196)
  store i8* %t197, i8** %l18
  %t199 = load i8*, i8** %l18
  %t200 = call i64 @sailfin_runtime_string_length(i8* %t199)
  %t201 = icmp eq i64 %t200, 0
  br label %logical_or_entry_198

logical_or_entry_198:
  br i1 %t201, label %logical_or_merge_198, label %logical_or_right_198

logical_or_right_198:
  %t202 = load i8*, i8** %l18
  %t203 = add i64 0, 2
  %t204 = call i8* @malloc(i64 %t203)
  store i8 59, i8* %t204
  %t205 = getelementptr i8, i8* %t204, i64 1
  store i8 0, i8* %t205
  call void @sailfin_runtime_mark_persistent(i8* %t204)
  %t206 = call i1 @starts_with(i8* %t202, i8* %t204)
  br label %logical_or_right_end_198

logical_or_right_end_198:
  br label %logical_or_merge_198

logical_or_merge_198:
  %t207 = phi i1 [ true, %logical_or_entry_198 ], [ %t206, %logical_or_right_end_198 ]
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t209 = load i8*, i8** %l1
  %t210 = load i8*, i8** %l2
  %t211 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t212 = load i8*, i8** %l4
  %t213 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t214 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t215 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t216 = load %NativeFunction*, %NativeFunction** %l8
  %t217 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t218 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t219 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t220 = load double, double* %l12
  %t221 = load double, double* %l13
  %t222 = load i1, i1* %l14
  %t223 = load i1, i1* %l15
  %t224 = load double, double* %l16
  %t225 = load i8*, i8** %l18
  br i1 %t207, label %then10, label %merge11
then10:
  %t226 = load double, double* %l16
  %t227 = sitofp i64 1 to double
  %t228 = fadd double %t226, %t227
  store double %t228, double* %l16
  br label %loop.latch4
merge11:
  %t229 = load i8*, i8** %l18
  %s230 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h2070880298, i32 0, i32 0
  %t231 = call i1 @strings_equal(i8* %t229, i8* %s230)
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t233 = load i8*, i8** %l1
  %t234 = load i8*, i8** %l2
  %t235 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t236 = load i8*, i8** %l4
  %t237 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t238 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t239 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t240 = load %NativeFunction*, %NativeFunction** %l8
  %t241 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t242 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t243 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t244 = load double, double* %l12
  %t245 = load double, double* %l13
  %t246 = load i1, i1* %l14
  %t247 = load i1, i1* %l15
  %t248 = load double, double* %l16
  %t249 = load i8*, i8** %l18
  br i1 %t231, label %then12, label %merge13
then12:
  %t250 = load %NativeFunction*, %NativeFunction** %l8
  %t251 = icmp ne %NativeFunction* %t250, null
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t253 = load i8*, i8** %l1
  %t254 = load i8*, i8** %l2
  %t255 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t256 = load i8*, i8** %l4
  %t257 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t258 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t259 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t260 = load %NativeFunction*, %NativeFunction** %l8
  %t261 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t262 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t263 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t264 = load double, double* %l12
  %t265 = load double, double* %l13
  %t266 = load i1, i1* %l14
  %t267 = load i1, i1* %l15
  %t268 = load double, double* %l16
  %t269 = load i8*, i8** %l18
  br i1 %t251, label %then14, label %merge15
then14:
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s271 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h208276320, i32 0, i32 0
  %t272 = load i8*, i8** %l4
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %s271, i8* %t272)
  %t274 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t270, i8* %t273)
  store { i8**, i64 }* %t274, { i8**, i64 }** %l0
  %t275 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t276 = load %NativeFunction*, %NativeFunction** %l8
  %t277 = load %NativeFunction, %NativeFunction* %t276
  %t278 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t275, %NativeFunction %t277)
  store { %NativeFunction*, i64 }* %t278, { %NativeFunction*, i64 }** %l7
  %t279 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t279, %NativeFunction** %l8
  %t280 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t280, %NativeSourceSpan** %l9
  %t281 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t281, %NativeSourceSpan** %l10
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t283 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t284 = load %NativeFunction*, %NativeFunction** %l8
  %t285 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t286 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge15
merge15:
  %t287 = phi { i8**, i64 }* [ %t282, %then14 ], [ %t252, %then12 ]
  %t288 = phi { %NativeFunction*, i64 }* [ %t283, %then14 ], [ %t259, %then12 ]
  %t289 = phi %NativeFunction* [ %t284, %then14 ], [ %t260, %then12 ]
  %t290 = phi %NativeSourceSpan* [ %t285, %then14 ], [ %t261, %then12 ]
  %t291 = phi %NativeSourceSpan* [ %t286, %then14 ], [ %t262, %then12 ]
  store { i8**, i64 }* %t287, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t288, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t289, %NativeFunction** %l8
  store %NativeSourceSpan* %t290, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t291, %NativeSourceSpan** %l10
  %t292 = load double, double* %l16
  %t293 = sitofp i64 1 to double
  %t294 = fadd double %t292, %t293
  store double %t294, double* %l16
  br label %afterloop5
merge13:
  %t295 = load %NativeFunction*, %NativeFunction** %l8
  %t296 = icmp ne %NativeFunction* %t295, null
  %t297 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t298 = load i8*, i8** %l1
  %t299 = load i8*, i8** %l2
  %t300 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t301 = load i8*, i8** %l4
  %t302 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t303 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t304 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t305 = load %NativeFunction*, %NativeFunction** %l8
  %t306 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t307 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t308 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t309 = load double, double* %l12
  %t310 = load double, double* %l13
  %t311 = load i1, i1* %l14
  %t312 = load i1, i1* %l15
  %t313 = load double, double* %l16
  %t314 = load i8*, i8** %l18
  br i1 %t296, label %then16, label %merge17
then16:
  %t315 = load i8*, i8** %l18
  %s316 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h179409731, i32 0, i32 0
  %t317 = call i1 @strings_equal(i8* %t315, i8* %s316)
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t319 = load i8*, i8** %l1
  %t320 = load i8*, i8** %l2
  %t321 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t322 = load i8*, i8** %l4
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t324 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t325 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t326 = load %NativeFunction*, %NativeFunction** %l8
  %t327 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t328 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t329 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t330 = load double, double* %l12
  %t331 = load double, double* %l13
  %t332 = load i1, i1* %l14
  %t333 = load i1, i1* %l15
  %t334 = load double, double* %l16
  %t335 = load i8*, i8** %l18
  br i1 %t317, label %then18, label %merge19
then18:
  %t336 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t337 = load %NativeFunction*, %NativeFunction** %l8
  %t338 = load %NativeFunction, %NativeFunction* %t337
  %t339 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t336, %NativeFunction %t338)
  store { %NativeFunction*, i64 }* %t339, { %NativeFunction*, i64 }** %l7
  %t340 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t340, %NativeFunction** %l8
  %t341 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t341, %NativeSourceSpan** %l9
  %t342 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t342, %NativeSourceSpan** %l10
  %t343 = load double, double* %l16
  %t344 = sitofp i64 1 to double
  %t345 = fadd double %t343, %t344
  store double %t345, double* %l16
  br label %loop.latch4
merge19:
  %t346 = load i8*, i8** %l18
  %s347 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t348 = call i1 @starts_with(i8* %t346, i8* %s347)
  %t349 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t350 = load i8*, i8** %l1
  %t351 = load i8*, i8** %l2
  %t352 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t353 = load i8*, i8** %l4
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t355 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t356 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t357 = load %NativeFunction*, %NativeFunction** %l8
  %t358 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t359 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t360 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t361 = load double, double* %l12
  %t362 = load double, double* %l13
  %t363 = load i1, i1* %l14
  %t364 = load i1, i1* %l15
  %t365 = load double, double* %l16
  %t366 = load i8*, i8** %l18
  br i1 %t348, label %then20, label %merge21
then20:
  %t367 = load %NativeFunction*, %NativeFunction** %l8
  %t368 = load i8*, i8** %l18
  %s369 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t370 = call i8* @strip_prefix(i8* %t368, i8* %s369)
  %t371 = load %NativeFunction, %NativeFunction* %t367
  %t372 = call %NativeFunction @apply_meta(%NativeFunction %t371, i8* %t370)
  %t373 = alloca %NativeFunction
  store %NativeFunction %t372, %NativeFunction* %t373
  store %NativeFunction* %t373, %NativeFunction** %l8
  %t374 = load double, double* %l16
  %t375 = sitofp i64 1 to double
  %t376 = fadd double %t374, %t375
  store double %t376, double* %l16
  br label %loop.latch4
merge21:
  %t377 = load i8*, i8** %l18
  %s378 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t379 = call i1 @starts_with(i8* %t377, i8* %s378)
  %t380 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t381 = load i8*, i8** %l1
  %t382 = load i8*, i8** %l2
  %t383 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t384 = load i8*, i8** %l4
  %t385 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t386 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t387 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t388 = load %NativeFunction*, %NativeFunction** %l8
  %t389 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t390 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t391 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t392 = load double, double* %l12
  %t393 = load double, double* %l13
  %t394 = load i1, i1* %l14
  %t395 = load i1, i1* %l15
  %t396 = load double, double* %l16
  %t397 = load i8*, i8** %l18
  br i1 %t379, label %then22, label %merge23
then22:
  %t398 = load i8*, i8** %l18
  %s399 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t400 = call i8* @strip_prefix(i8* %t398, i8* %s399)
  %t401 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t402 = call %NativeParameter* @parse_parameter_entry(i8* %t400, %NativeSourceSpan* %t401)
  store %NativeParameter* %t402, %NativeParameter** %l19
  %t403 = load %NativeParameter*, %NativeParameter** %l19
  %t404 = icmp eq %NativeParameter* %t403, null
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t406 = load i8*, i8** %l1
  %t407 = load i8*, i8** %l2
  %t408 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t409 = load i8*, i8** %l4
  %t410 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t411 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t412 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t413 = load %NativeFunction*, %NativeFunction** %l8
  %t414 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t415 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t416 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t417 = load double, double* %l12
  %t418 = load double, double* %l13
  %t419 = load i1, i1* %l14
  %t420 = load i1, i1* %l15
  %t421 = load double, double* %l16
  %t422 = load i8*, i8** %l18
  %t423 = load %NativeParameter*, %NativeParameter** %l19
  br i1 %t404, label %then24, label %else25
then24:
  %t424 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s425 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h1211676914, i32 0, i32 0
  %t426 = load i8*, i8** %l18
  %t427 = call i8* @sailfin_runtime_string_concat(i8* %s425, i8* %t426)
  %t428 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t424, i8* %t427)
  store { i8**, i64 }* %t428, { i8**, i64 }** %l0
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge26
else25:
  %t430 = load %NativeFunction*, %NativeFunction** %l8
  %t431 = load %NativeParameter*, %NativeParameter** %l19
  %t432 = load %NativeFunction, %NativeFunction* %t430
  %t433 = load %NativeParameter, %NativeParameter* %t431
  %t434 = call %NativeFunction @append_parameter(%NativeFunction %t432, %NativeParameter %t433)
  %t435 = alloca %NativeFunction
  store %NativeFunction %t434, %NativeFunction* %t435
  store %NativeFunction* %t435, %NativeFunction** %l8
  %t436 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge26
merge26:
  %t437 = phi { i8**, i64 }* [ %t429, %then24 ], [ %t405, %else25 ]
  %t438 = phi %NativeFunction* [ %t413, %then24 ], [ %t436, %else25 ]
  store { i8**, i64 }* %t437, { i8**, i64 }** %l0
  store %NativeFunction* %t438, %NativeFunction** %l8
  %t439 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t439, %NativeSourceSpan** %l9
  %t440 = load double, double* %l16
  %t441 = sitofp i64 1 to double
  %t442 = fadd double %t440, %t441
  store double %t442, double* %l16
  br label %loop.latch4
merge23:
  %t443 = load i8*, i8** %l18
  %s444 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t445 = call i1 @starts_with(i8* %t443, i8* %s444)
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t447 = load i8*, i8** %l1
  %t448 = load i8*, i8** %l2
  %t449 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t450 = load i8*, i8** %l4
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t452 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t453 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t454 = load %NativeFunction*, %NativeFunction** %l8
  %t455 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t456 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t457 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t458 = load double, double* %l12
  %t459 = load double, double* %l13
  %t460 = load i1, i1* %l14
  %t461 = load i1, i1* %l15
  %t462 = load double, double* %l16
  %t463 = load i8*, i8** %l18
  br i1 %t445, label %then27, label %merge28
then27:
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s465 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t466 = load i8*, i8** %l4
  %t467 = call i8* @sailfin_runtime_string_concat(i8* %s465, i8* %t466)
  %t468 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t464, i8* %t467)
  store { i8**, i64 }* %t468, { i8**, i64 }** %l0
  %t469 = load double, double* %l16
  %t470 = sitofp i64 1 to double
  %t471 = fadd double %t469, %t470
  store double %t471, double* %l16
  br label %loop.latch4
merge28:
  %t472 = load i8*, i8** %l18
  %s473 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t474 = call i1 @starts_with(i8* %t472, i8* %s473)
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t476 = load i8*, i8** %l1
  %t477 = load i8*, i8** %l2
  %t478 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t479 = load i8*, i8** %l4
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t481 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t482 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t483 = load %NativeFunction*, %NativeFunction** %l8
  %t484 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t485 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t486 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t487 = load double, double* %l12
  %t488 = load double, double* %l13
  %t489 = load i1, i1* %l14
  %t490 = load i1, i1* %l15
  %t491 = load double, double* %l16
  %t492 = load i8*, i8** %l18
  br i1 %t474, label %then29, label %merge30
then29:
  %t493 = load i8*, i8** %l18
  %s494 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t495 = call i8* @strip_prefix(i8* %t493, i8* %s494)
  %t496 = call %NativeSourceSpan* @parse_source_span(i8* %t495)
  store %NativeSourceSpan* %t496, %NativeSourceSpan** %l20
  %t497 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  %t498 = icmp eq %NativeSourceSpan* %t497, null
  %t499 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t500 = load i8*, i8** %l1
  %t501 = load i8*, i8** %l2
  %t502 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t503 = load i8*, i8** %l4
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t505 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t506 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t507 = load %NativeFunction*, %NativeFunction** %l8
  %t508 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t509 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t510 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t511 = load double, double* %l12
  %t512 = load double, double* %l13
  %t513 = load i1, i1* %l14
  %t514 = load i1, i1* %l15
  %t515 = load double, double* %l16
  %t516 = load i8*, i8** %l18
  %t517 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  br i1 %t498, label %then31, label %else32
then31:
  %t518 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s519 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h762677253, i32 0, i32 0
  %t520 = load i8*, i8** %l18
  %t521 = call i8* @sailfin_runtime_string_concat(i8* %s519, i8* %t520)
  %t522 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t518, i8* %t521)
  store { i8**, i64 }* %t522, { i8**, i64 }** %l0
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge33
else32:
  %t524 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  store %NativeSourceSpan* %t524, %NativeSourceSpan** %l9
  %t525 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge33
merge33:
  %t526 = phi { i8**, i64 }* [ %t523, %then31 ], [ %t499, %else32 ]
  %t527 = phi %NativeSourceSpan* [ %t508, %then31 ], [ %t525, %else32 ]
  store { i8**, i64 }* %t526, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t527, %NativeSourceSpan** %l9
  %t528 = load double, double* %l16
  %t529 = sitofp i64 1 to double
  %t530 = fadd double %t528, %t529
  store double %t530, double* %l16
  br label %loop.latch4
merge30:
  %t531 = load i8*, i8** %l18
  %s532 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t533 = call i1 @starts_with(i8* %t531, i8* %s532)
  %t534 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t535 = load i8*, i8** %l1
  %t536 = load i8*, i8** %l2
  %t537 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t538 = load i8*, i8** %l4
  %t539 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t540 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t541 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t542 = load %NativeFunction*, %NativeFunction** %l8
  %t543 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t544 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t545 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t546 = load double, double* %l12
  %t547 = load double, double* %l13
  %t548 = load i1, i1* %l14
  %t549 = load i1, i1* %l15
  %t550 = load double, double* %l16
  %t551 = load i8*, i8** %l18
  br i1 %t533, label %then34, label %merge35
then34:
  %t552 = load i8*, i8** %l18
  %s553 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t554 = call i8* @strip_prefix(i8* %t552, i8* %s553)
  %t555 = call %NativeSourceSpan* @parse_source_span(i8* %t554)
  store %NativeSourceSpan* %t555, %NativeSourceSpan** %l21
  %t556 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  %t557 = icmp eq %NativeSourceSpan* %t556, null
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t559 = load i8*, i8** %l1
  %t560 = load i8*, i8** %l2
  %t561 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t562 = load i8*, i8** %l4
  %t563 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t564 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t565 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t566 = load %NativeFunction*, %NativeFunction** %l8
  %t567 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t568 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t569 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t570 = load double, double* %l12
  %t571 = load double, double* %l13
  %t572 = load i1, i1* %l14
  %t573 = load i1, i1* %l15
  %t574 = load double, double* %l16
  %t575 = load i8*, i8** %l18
  %t576 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  br i1 %t557, label %then36, label %else37
then36:
  %t577 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s578 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.len43.h1714227133, i32 0, i32 0
  %t579 = load i8*, i8** %l18
  %t580 = call i8* @sailfin_runtime_string_concat(i8* %s578, i8* %t579)
  %t581 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t577, i8* %t580)
  store { i8**, i64 }* %t581, { i8**, i64 }** %l0
  %t582 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t583 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  store %NativeSourceSpan* %t583, %NativeSourceSpan** %l10
  %t584 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge38
merge38:
  %t585 = phi { i8**, i64 }* [ %t582, %then36 ], [ %t558, %else37 ]
  %t586 = phi %NativeSourceSpan* [ %t568, %then36 ], [ %t584, %else37 ]
  store { i8**, i64 }* %t585, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t586, %NativeSourceSpan** %l10
  %t587 = load double, double* %l16
  %t588 = sitofp i64 1 to double
  %t589 = fadd double %t587, %t588
  store double %t589, double* %l16
  br label %loop.latch4
merge35:
  %t590 = load i8*, i8** %l18
  %t591 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t592 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t593 = call %InstructionParseResult @parse_instruction(i8* %t590, %NativeSourceSpan* %t591, %NativeSourceSpan* %t592)
  store %InstructionParseResult %t593, %InstructionParseResult* %l22
  %t594 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t595 = extractvalue %InstructionParseResult %t594, 1
  %t596 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t597 = load i8*, i8** %l1
  %t598 = load i8*, i8** %l2
  %t599 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t600 = load i8*, i8** %l4
  %t601 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t602 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t603 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t604 = load %NativeFunction*, %NativeFunction** %l8
  %t605 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t606 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t607 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t608 = load double, double* %l12
  %t609 = load double, double* %l13
  %t610 = load i1, i1* %l14
  %t611 = load i1, i1* %l15
  %t612 = load double, double* %l16
  %t613 = load i8*, i8** %l18
  %t614 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t595, label %then39, label %else40
then39:
  %t615 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t615, %NativeSourceSpan** %l9
  %t616 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
else40:
  %t617 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t618 = icmp ne %NativeSourceSpan* %t617, null
  %t619 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t620 = load i8*, i8** %l1
  %t621 = load i8*, i8** %l2
  %t622 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t623 = load i8*, i8** %l4
  %t624 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t625 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t626 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t627 = load %NativeFunction*, %NativeFunction** %l8
  %t628 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t629 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t630 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t631 = load double, double* %l12
  %t632 = load double, double* %l13
  %t633 = load i1, i1* %l14
  %t634 = load i1, i1* %l15
  %t635 = load double, double* %l16
  %t636 = load i8*, i8** %l18
  %t637 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t618, label %then42, label %merge43
then42:
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s639 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t640 = load i8*, i8** %l18
  %t641 = call i8* @sailfin_runtime_string_concat(i8* %s639, i8* %t640)
  %t642 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t638, i8* %t641)
  store { i8**, i64 }* %t642, { i8**, i64 }** %l0
  %t643 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t643, %NativeSourceSpan** %l9
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t645 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge43
merge43:
  %t646 = phi { i8**, i64 }* [ %t644, %then42 ], [ %t619, %else40 ]
  %t647 = phi %NativeSourceSpan* [ %t645, %then42 ], [ %t628, %else40 ]
  store { i8**, i64 }* %t646, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t647, %NativeSourceSpan** %l9
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t649 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
merge41:
  %t650 = phi %NativeSourceSpan* [ %t616, %then39 ], [ %t649, %merge43 ]
  %t651 = phi { i8**, i64 }* [ %t596, %then39 ], [ %t648, %merge43 ]
  store %NativeSourceSpan* %t650, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t651, { i8**, i64 }** %l0
  %t652 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t653 = extractvalue %InstructionParseResult %t652, 2
  %t654 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t655 = load i8*, i8** %l1
  %t656 = load i8*, i8** %l2
  %t657 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t658 = load i8*, i8** %l4
  %t659 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t660 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t661 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t662 = load %NativeFunction*, %NativeFunction** %l8
  %t663 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t664 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t665 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t666 = load double, double* %l12
  %t667 = load double, double* %l13
  %t668 = load i1, i1* %l14
  %t669 = load i1, i1* %l15
  %t670 = load double, double* %l16
  %t671 = load i8*, i8** %l18
  %t672 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t653, label %then44, label %else45
then44:
  %t673 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t673, %NativeSourceSpan** %l10
  %t674 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
else45:
  %t675 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t676 = icmp ne %NativeSourceSpan* %t675, null
  %t677 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t678 = load i8*, i8** %l1
  %t679 = load i8*, i8** %l2
  %t680 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t681 = load i8*, i8** %l4
  %t682 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t683 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t684 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t685 = load %NativeFunction*, %NativeFunction** %l8
  %t686 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t687 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t688 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t689 = load double, double* %l12
  %t690 = load double, double* %l13
  %t691 = load i1, i1* %l14
  %t692 = load i1, i1* %l15
  %t693 = load double, double* %l16
  %t694 = load i8*, i8** %l18
  %t695 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t676, label %then47, label %merge48
then47:
  %t696 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s697 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t698 = load i8*, i8** %l18
  %t699 = call i8* @sailfin_runtime_string_concat(i8* %s697, i8* %t698)
  %t700 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t696, i8* %t699)
  store { i8**, i64 }* %t700, { i8**, i64 }** %l0
  %t701 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t701, %NativeSourceSpan** %l10
  %t702 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t703 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge48
merge48:
  %t704 = phi { i8**, i64 }* [ %t702, %then47 ], [ %t677, %else45 ]
  %t705 = phi %NativeSourceSpan* [ %t703, %then47 ], [ %t687, %else45 ]
  store { i8**, i64 }* %t704, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t705, %NativeSourceSpan** %l10
  %t706 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t707 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
merge46:
  %t708 = phi %NativeSourceSpan* [ %t674, %then44 ], [ %t707, %merge48 ]
  %t709 = phi { i8**, i64 }* [ %t654, %then44 ], [ %t706, %merge48 ]
  store %NativeSourceSpan* %t708, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t709, { i8**, i64 }** %l0
  %t710 = sitofp i64 0 to double
  store double %t710, double* %l23
  %t711 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t712 = load i8*, i8** %l1
  %t713 = load i8*, i8** %l2
  %t714 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t715 = load i8*, i8** %l4
  %t716 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t717 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t718 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t719 = load %NativeFunction*, %NativeFunction** %l8
  %t720 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t721 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t722 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t723 = load double, double* %l12
  %t724 = load double, double* %l13
  %t725 = load i1, i1* %l14
  %t726 = load i1, i1* %l15
  %t727 = load double, double* %l16
  %t728 = load i8*, i8** %l18
  %t729 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t730 = load double, double* %l23
  br label %loop.header49
loop.header49:
  %t778 = phi %NativeFunction* [ %t719, %merge46 ], [ %t776, %loop.latch51 ]
  %t779 = phi double [ %t730, %merge46 ], [ %t777, %loop.latch51 ]
  store %NativeFunction* %t778, %NativeFunction** %l8
  store double %t779, double* %l23
  br label %loop.body50
loop.body50:
  %t731 = load double, double* %l23
  %t732 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t733 = extractvalue %InstructionParseResult %t732, 0
  %t734 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t733
  %t735 = extractvalue { %NativeInstruction*, i64 } %t734, 1
  %t736 = sitofp i64 %t735 to double
  %t737 = fcmp oge double %t731, %t736
  %t738 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t739 = load i8*, i8** %l1
  %t740 = load i8*, i8** %l2
  %t741 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t742 = load i8*, i8** %l4
  %t743 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t744 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t745 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t746 = load %NativeFunction*, %NativeFunction** %l8
  %t747 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t748 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t749 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t750 = load double, double* %l12
  %t751 = load double, double* %l13
  %t752 = load i1, i1* %l14
  %t753 = load i1, i1* %l15
  %t754 = load double, double* %l16
  %t755 = load i8*, i8** %l18
  %t756 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t757 = load double, double* %l23
  br i1 %t737, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t758 = load %NativeFunction*, %NativeFunction** %l8
  %t759 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t760 = extractvalue %InstructionParseResult %t759, 0
  %t761 = load double, double* %l23
  %t762 = call double @llvm.round.f64(double %t761)
  %t763 = fptosi double %t762 to i64
  %t764 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t760
  %t765 = extractvalue { %NativeInstruction*, i64 } %t764, 0
  %t766 = extractvalue { %NativeInstruction*, i64 } %t764, 1
  %t767 = icmp uge i64 %t763, %t766
  ; bounds check: %t767 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t763, i64 %t766)
  %t768 = getelementptr %NativeInstruction, %NativeInstruction* %t765, i64 %t763
  %t769 = load %NativeInstruction, %NativeInstruction* %t768
  %t770 = load %NativeFunction, %NativeFunction* %t758
  %t771 = call %NativeFunction @append_instruction(%NativeFunction %t770, %NativeInstruction %t769)
  %t772 = alloca %NativeFunction
  store %NativeFunction %t771, %NativeFunction* %t772
  store %NativeFunction* %t772, %NativeFunction** %l8
  %t773 = load double, double* %l23
  %t774 = sitofp i64 1 to double
  %t775 = fadd double %t773, %t774
  store double %t775, double* %l23
  br label %loop.latch51
loop.latch51:
  %t776 = load %NativeFunction*, %NativeFunction** %l8
  %t777 = load double, double* %l23
  br label %loop.header49
afterloop52:
  %t780 = load %NativeFunction*, %NativeFunction** %l8
  %t781 = load double, double* %l23
  %t782 = load double, double* %l16
  %t783 = sitofp i64 1 to double
  %t784 = fadd double %t782, %t783
  store double %t784, double* %l16
  br label %loop.latch4
merge17:
  %t785 = load i8*, i8** %l18
  %s786 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t787 = call i1 @starts_with(i8* %t785, i8* %s786)
  %t788 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t789 = load i8*, i8** %l1
  %t790 = load i8*, i8** %l2
  %t791 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t792 = load i8*, i8** %l4
  %t793 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t794 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t795 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t796 = load %NativeFunction*, %NativeFunction** %l8
  %t797 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t798 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t799 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t800 = load double, double* %l12
  %t801 = load double, double* %l13
  %t802 = load i1, i1* %l14
  %t803 = load i1, i1* %l15
  %t804 = load double, double* %l16
  %t805 = load i8*, i8** %l18
  br i1 %t787, label %then55, label %merge56
then55:
  %t806 = load i8*, i8** %l18
  %s807 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t808 = call i8* @strip_prefix(i8* %t806, i8* %s807)
  store i8* %t808, i8** %l24
  %t809 = load i8*, i8** %l24
  %s810 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t811 = call i1 @starts_with(i8* %t809, i8* %s810)
  %t812 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t813 = load i8*, i8** %l1
  %t814 = load i8*, i8** %l2
  %t815 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t816 = load i8*, i8** %l4
  %t817 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t818 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t819 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t820 = load %NativeFunction*, %NativeFunction** %l8
  %t821 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t822 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t823 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t824 = load double, double* %l12
  %t825 = load double, double* %l13
  %t826 = load i1, i1* %l14
  %t827 = load i1, i1* %l15
  %t828 = load double, double* %l16
  %t829 = load i8*, i8** %l18
  %t830 = load i8*, i8** %l24
  br i1 %t811, label %then57, label %merge58
then57:
  %t831 = load i8*, i8** %l24
  %s832 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t833 = call i8* @strip_prefix(i8* %t831, i8* %s832)
  %t834 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t833)
  store %StructLayoutHeaderParse %t834, %StructLayoutHeaderParse* %l25
  %t835 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t836 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t837 = extractvalue %StructLayoutHeaderParse %t836, 4
  %t838 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t835, { i8**, i64 }* %t837)
  store { i8**, i64 }* %t838, { i8**, i64 }** %l0
  %t839 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t840 = extractvalue %StructLayoutHeaderParse %t839, 0
  %t841 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t842 = load i8*, i8** %l1
  %t843 = load i8*, i8** %l2
  %t844 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t845 = load i8*, i8** %l4
  %t846 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t847 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t848 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t849 = load %NativeFunction*, %NativeFunction** %l8
  %t850 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t851 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t852 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t853 = load double, double* %l12
  %t854 = load double, double* %l13
  %t855 = load i1, i1* %l14
  %t856 = load i1, i1* %l15
  %t857 = load double, double* %l16
  %t858 = load i8*, i8** %l18
  %t859 = load i8*, i8** %l24
  %t860 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t840, label %then59, label %merge60
then59:
  %t861 = load i1, i1* %l14
  %t862 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t863 = load i8*, i8** %l1
  %t864 = load i8*, i8** %l2
  %t865 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t866 = load i8*, i8** %l4
  %t867 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t868 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t869 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t870 = load %NativeFunction*, %NativeFunction** %l8
  %t871 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t872 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t873 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t874 = load double, double* %l12
  %t875 = load double, double* %l13
  %t876 = load i1, i1* %l14
  %t877 = load i1, i1* %l15
  %t878 = load double, double* %l16
  %t879 = load i8*, i8** %l18
  %t880 = load i8*, i8** %l24
  %t881 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t861, label %then61, label %else62
then61:
  %t882 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s883 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h654371835, i32 0, i32 0
  %t884 = load i8*, i8** %l4
  %t885 = call i8* @sailfin_runtime_string_concat(i8* %s883, i8* %t884)
  %t886 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t882, i8* %t885)
  store { i8**, i64 }* %t886, { i8**, i64 }** %l0
  %t887 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge63
else62:
  %t888 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t889 = extractvalue %StructLayoutHeaderParse %t888, 2
  store double %t889, double* %l12
  %t890 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t891 = extractvalue %StructLayoutHeaderParse %t890, 3
  store double %t891, double* %l13
  store i1 1, i1* %l14
  %t892 = load double, double* %l12
  %t893 = load double, double* %l13
  %t894 = load i1, i1* %l14
  br label %merge63
merge63:
  %t895 = phi { i8**, i64 }* [ %t887, %then61 ], [ %t862, %else62 ]
  %t896 = phi double [ %t874, %then61 ], [ %t892, %else62 ]
  %t897 = phi double [ %t875, %then61 ], [ %t893, %else62 ]
  %t898 = phi i1 [ %t876, %then61 ], [ %t894, %else62 ]
  store { i8**, i64 }* %t895, { i8**, i64 }** %l0
  store double %t896, double* %l12
  store double %t897, double* %l13
  store i1 %t898, i1* %l14
  %t899 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t900 = load double, double* %l12
  %t901 = load double, double* %l13
  %t902 = load i1, i1* %l14
  br label %merge60
merge60:
  %t903 = phi { i8**, i64 }* [ %t899, %merge63 ], [ %t841, %then57 ]
  %t904 = phi double [ %t900, %merge63 ], [ %t853, %then57 ]
  %t905 = phi double [ %t901, %merge63 ], [ %t854, %then57 ]
  %t906 = phi i1 [ %t902, %merge63 ], [ %t855, %then57 ]
  store { i8**, i64 }* %t903, { i8**, i64 }** %l0
  store double %t904, double* %l12
  store double %t905, double* %l13
  store i1 %t906, i1* %l14
  %t907 = load double, double* %l16
  %t908 = sitofp i64 1 to double
  %t909 = fadd double %t907, %t908
  store double %t909, double* %l16
  br label %loop.latch4
merge58:
  %t910 = load i8*, i8** %l24
  %s911 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t912 = call i1 @starts_with(i8* %t910, i8* %s911)
  %t913 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t914 = load i8*, i8** %l1
  %t915 = load i8*, i8** %l2
  %t916 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t917 = load i8*, i8** %l4
  %t918 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t919 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t920 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t921 = load %NativeFunction*, %NativeFunction** %l8
  %t922 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t923 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t924 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t925 = load double, double* %l12
  %t926 = load double, double* %l13
  %t927 = load i1, i1* %l14
  %t928 = load i1, i1* %l15
  %t929 = load double, double* %l16
  %t930 = load i8*, i8** %l18
  %t931 = load i8*, i8** %l24
  br i1 %t912, label %then64, label %merge65
then64:
  %t932 = load i8*, i8** %l24
  %s933 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t934 = call i8* @strip_prefix(i8* %t932, i8* %s933)
  %t935 = load i8*, i8** %l4
  %t936 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t934, i8* %t935)
  store %StructLayoutFieldParse %t936, %StructLayoutFieldParse* %l26
  %t937 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t938 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t939 = extractvalue %StructLayoutFieldParse %t938, 2
  %t940 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t937, { i8**, i64 }* %t939)
  store { i8**, i64 }* %t940, { i8**, i64 }** %l0
  %t941 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t942 = extractvalue %StructLayoutFieldParse %t941, 0
  %t943 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t944 = load i8*, i8** %l1
  %t945 = load i8*, i8** %l2
  %t946 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t947 = load i8*, i8** %l4
  %t948 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t949 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t950 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t951 = load %NativeFunction*, %NativeFunction** %l8
  %t952 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t953 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t954 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t955 = load double, double* %l12
  %t956 = load double, double* %l13
  %t957 = load i1, i1* %l14
  %t958 = load i1, i1* %l15
  %t959 = load double, double* %l16
  %t960 = load i8*, i8** %l18
  %t961 = load i8*, i8** %l24
  %t962 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t942, label %then66, label %merge67
then66:
  %t963 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t964 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t965 = extractvalue %StructLayoutFieldParse %t964, 1
  %t966 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t963, %NativeStructLayoutField %t965)
  store { %NativeStructLayoutField*, i64 }* %t966, { %NativeStructLayoutField*, i64 }** %l11
  %t967 = load i1, i1* %l14
  %t968 = xor i1 %t967, 1
  %t969 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t970 = load i8*, i8** %l1
  %t971 = load i8*, i8** %l2
  %t972 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t973 = load i8*, i8** %l4
  %t974 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t975 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t976 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t977 = load %NativeFunction*, %NativeFunction** %l8
  %t978 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t979 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t980 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t981 = load double, double* %l12
  %t982 = load double, double* %l13
  %t983 = load i1, i1* %l14
  %t984 = load i1, i1* %l15
  %t985 = load double, double* %l16
  %t986 = load i8*, i8** %l18
  %t987 = load i8*, i8** %l24
  %t988 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t968, label %then68, label %merge69
then68:
  %t989 = load i1, i1* %l15
  %t990 = xor i1 %t989, 1
  %t991 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t992 = load i8*, i8** %l1
  %t993 = load i8*, i8** %l2
  %t994 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t995 = load i8*, i8** %l4
  %t996 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t997 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t998 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t999 = load %NativeFunction*, %NativeFunction** %l8
  %t1000 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1001 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1002 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1003 = load double, double* %l12
  %t1004 = load double, double* %l13
  %t1005 = load i1, i1* %l14
  %t1006 = load i1, i1* %l15
  %t1007 = load double, double* %l16
  %t1008 = load i8*, i8** %l18
  %t1009 = load i8*, i8** %l24
  %t1010 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t990, label %then70, label %merge71
then70:
  %t1011 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1012 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t1013 = load i8*, i8** %l4
  %t1014 = call i8* @sailfin_runtime_string_concat(i8* %s1012, i8* %t1013)
  %s1015 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.len46.h1830585629, i32 0, i32 0
  %t1016 = call i8* @sailfin_runtime_string_concat(i8* %t1014, i8* %s1015)
  %t1017 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1011, i8* %t1016)
  store { i8**, i64 }* %t1017, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  %t1018 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1019 = load i1, i1* %l15
  br label %merge71
merge71:
  %t1020 = phi { i8**, i64 }* [ %t1018, %then70 ], [ %t991, %then68 ]
  %t1021 = phi i1 [ %t1019, %then70 ], [ %t1006, %then68 ]
  store { i8**, i64 }* %t1020, { i8**, i64 }** %l0
  store i1 %t1021, i1* %l15
  %t1022 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1023 = load i1, i1* %l15
  br label %merge69
merge69:
  %t1024 = phi { i8**, i64 }* [ %t1022, %merge71 ], [ %t969, %then66 ]
  %t1025 = phi i1 [ %t1023, %merge71 ], [ %t984, %then66 ]
  store { i8**, i64 }* %t1024, { i8**, i64 }** %l0
  store i1 %t1025, i1* %l15
  %t1026 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1027 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1028 = load i1, i1* %l15
  br label %merge67
merge67:
  %t1029 = phi { %NativeStructLayoutField*, i64 }* [ %t1026, %merge69 ], [ %t954, %then64 ]
  %t1030 = phi { i8**, i64 }* [ %t1027, %merge69 ], [ %t943, %then64 ]
  %t1031 = phi i1 [ %t1028, %merge69 ], [ %t958, %then64 ]
  store { %NativeStructLayoutField*, i64 }* %t1029, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t1030, { i8**, i64 }** %l0
  store i1 %t1031, i1* %l15
  %t1032 = load double, double* %l16
  %t1033 = sitofp i64 1 to double
  %t1034 = fadd double %t1032, %t1033
  store double %t1034, double* %l16
  br label %loop.latch4
merge65:
  %t1035 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1036 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h1152036459, i32 0, i32 0
  %t1037 = load i8*, i8** %l18
  %t1038 = call i8* @sailfin_runtime_string_concat(i8* %s1036, i8* %t1037)
  %t1039 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1035, i8* %t1038)
  store { i8**, i64 }* %t1039, { i8**, i64 }** %l0
  %t1040 = load double, double* %l16
  %t1041 = sitofp i64 1 to double
  %t1042 = fadd double %t1040, %t1041
  store double %t1042, double* %l16
  br label %loop.latch4
merge56:
  %t1043 = load i8*, i8** %l18
  %s1044 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t1045 = call i1 @strings_equal(i8* %t1043, i8* %s1044)
  %t1046 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1047 = load i8*, i8** %l1
  %t1048 = load i8*, i8** %l2
  %t1049 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1050 = load i8*, i8** %l4
  %t1051 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1052 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1053 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1054 = load %NativeFunction*, %NativeFunction** %l8
  %t1055 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1056 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1057 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1058 = load double, double* %l12
  %t1059 = load double, double* %l13
  %t1060 = load i1, i1* %l14
  %t1061 = load i1, i1* %l15
  %t1062 = load double, double* %l16
  %t1063 = load i8*, i8** %l18
  br i1 %t1045, label %then72, label %merge73
then72:
  %t1064 = load double, double* %l16
  %t1065 = sitofp i64 1 to double
  %t1066 = fadd double %t1064, %t1065
  store double %t1066, double* %l16
  br label %loop.latch4
merge73:
  %t1067 = load i8*, i8** %l18
  %s1068 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1069 = call i1 @starts_with(i8* %t1067, i8* %s1068)
  %t1070 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1071 = load i8*, i8** %l1
  %t1072 = load i8*, i8** %l2
  %t1073 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1074 = load i8*, i8** %l4
  %t1075 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1076 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1077 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1078 = load %NativeFunction*, %NativeFunction** %l8
  %t1079 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1080 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1081 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1082 = load double, double* %l12
  %t1083 = load double, double* %l13
  %t1084 = load i1, i1* %l14
  %t1085 = load i1, i1* %l15
  %t1086 = load double, double* %l16
  %t1087 = load i8*, i8** %l18
  br i1 %t1069, label %then74, label %merge75
then74:
  %t1088 = load i8*, i8** %l18
  %s1089 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1090 = call i8* @strip_prefix(i8* %t1088, i8* %s1089)
  %t1091 = call %NativeStructField* @parse_struct_field_line(i8* %t1090)
  store %NativeStructField* %t1091, %NativeStructField** %l27
  %t1092 = load %NativeStructField*, %NativeStructField** %l27
  %t1093 = icmp eq %NativeStructField* %t1092, null
  %t1094 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1095 = load i8*, i8** %l1
  %t1096 = load i8*, i8** %l2
  %t1097 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1098 = load i8*, i8** %l4
  %t1099 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1100 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1101 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1102 = load %NativeFunction*, %NativeFunction** %l8
  %t1103 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1104 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1105 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1106 = load double, double* %l12
  %t1107 = load double, double* %l13
  %t1108 = load i1, i1* %l14
  %t1109 = load i1, i1* %l15
  %t1110 = load double, double* %l16
  %t1111 = load i8*, i8** %l18
  %t1112 = load %NativeStructField*, %NativeStructField** %l27
  br i1 %t1093, label %then76, label %else77
then76:
  %t1113 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1114 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h702899578, i32 0, i32 0
  %t1115 = load i8*, i8** %l18
  %t1116 = call i8* @sailfin_runtime_string_concat(i8* %s1114, i8* %t1115)
  %t1117 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1113, i8* %t1116)
  store { i8**, i64 }* %t1117, { i8**, i64 }** %l0
  %t1118 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge78
else77:
  %t1119 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1120 = load %NativeStructField*, %NativeStructField** %l27
  %t1121 = load %NativeStructField, %NativeStructField* %t1120
  %t1122 = call { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %t1119, %NativeStructField %t1121)
  store { %NativeStructField*, i64 }* %t1122, { %NativeStructField*, i64 }** %l6
  %t1123 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %merge78
merge78:
  %t1124 = phi { i8**, i64 }* [ %t1118, %then76 ], [ %t1094, %else77 ]
  %t1125 = phi { %NativeStructField*, i64 }* [ %t1100, %then76 ], [ %t1123, %else77 ]
  store { i8**, i64 }* %t1124, { i8**, i64 }** %l0
  store { %NativeStructField*, i64 }* %t1125, { %NativeStructField*, i64 }** %l6
  %t1126 = load double, double* %l16
  %t1127 = sitofp i64 1 to double
  %t1128 = fadd double %t1126, %t1127
  store double %t1128, double* %l16
  br label %loop.latch4
merge75:
  %t1129 = load i8*, i8** %l18
  %s1130 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1131 = call i1 @starts_with(i8* %t1129, i8* %s1130)
  %t1132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1133 = load i8*, i8** %l1
  %t1134 = load i8*, i8** %l2
  %t1135 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1136 = load i8*, i8** %l4
  %t1137 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1138 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1139 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1140 = load %NativeFunction*, %NativeFunction** %l8
  %t1141 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1142 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1143 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1144 = load double, double* %l12
  %t1145 = load double, double* %l13
  %t1146 = load i1, i1* %l14
  %t1147 = load i1, i1* %l15
  %t1148 = load double, double* %l16
  %t1149 = load i8*, i8** %l18
  br i1 %t1131, label %then79, label %merge80
then79:
  %t1150 = load %NativeFunction*, %NativeFunction** %l8
  %t1151 = icmp ne %NativeFunction* %t1150, null
  %t1152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1153 = load i8*, i8** %l1
  %t1154 = load i8*, i8** %l2
  %t1155 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1156 = load i8*, i8** %l4
  %t1157 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1158 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1159 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1160 = load %NativeFunction*, %NativeFunction** %l8
  %t1161 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1162 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1163 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1164 = load double, double* %l12
  %t1165 = load double, double* %l13
  %t1166 = load i1, i1* %l14
  %t1167 = load i1, i1* %l15
  %t1168 = load double, double* %l16
  %t1169 = load i8*, i8** %l18
  br i1 %t1151, label %then81, label %merge82
then81:
  %t1170 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1171 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t1172 = load i8*, i8** %l4
  %t1173 = call i8* @sailfin_runtime_string_concat(i8* %s1171, i8* %t1172)
  %t1174 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1170, i8* %t1173)
  store { i8**, i64 }* %t1174, { i8**, i64 }** %l0
  %t1175 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge82
merge82:
  %t1176 = phi { i8**, i64 }* [ %t1175, %then81 ], [ %t1152, %then79 ]
  store { i8**, i64 }* %t1176, { i8**, i64 }** %l0
  %t1177 = load i8*, i8** %l18
  %s1178 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1179 = call i8* @strip_prefix(i8* %t1177, i8* %s1178)
  %t1180 = call i8* @parse_function_name(i8* %t1179)
  store i8* %t1180, i8** %l28
  %t1181 = load i8*, i8** %l28
  %t1182 = insertvalue %NativeFunction undef, i8* %t1181, 0
  %t1183 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t1184 = ptrtoint [0 x %NativeParameter]* %t1183 to i64
  %t1185 = icmp eq i64 %t1184, 0
  %t1186 = select i1 %t1185, i64 1, i64 %t1184
  %t1187 = call i8* @malloc(i64 %t1186)
  %t1188 = bitcast i8* %t1187 to %NativeParameter*
  %t1189 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t1190 = ptrtoint { %NativeParameter*, i64 }* %t1189 to i64
  %t1191 = call i8* @malloc(i64 %t1190)
  %t1192 = bitcast i8* %t1191 to { %NativeParameter*, i64 }*
  %t1193 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t1192, i32 0, i32 0
  store %NativeParameter* %t1188, %NativeParameter** %t1193
  %t1194 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t1192, i32 0, i32 1
  store i64 0, i64* %t1194
  %t1195 = insertvalue %NativeFunction %t1182, { %NativeParameter*, i64 }* %t1192, 1
  %s1196 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t1197 = insertvalue %NativeFunction %t1195, i8* %s1196, 2
  %t1198 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1199 = ptrtoint [0 x i8*]* %t1198 to i64
  %t1200 = icmp eq i64 %t1199, 0
  %t1201 = select i1 %t1200, i64 1, i64 %t1199
  %t1202 = call i8* @malloc(i64 %t1201)
  %t1203 = bitcast i8* %t1202 to i8**
  %t1204 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t1205 = ptrtoint { i8**, i64 }* %t1204 to i64
  %t1206 = call i8* @malloc(i64 %t1205)
  %t1207 = bitcast i8* %t1206 to { i8**, i64 }*
  %t1208 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1207, i32 0, i32 0
  store i8** %t1203, i8*** %t1208
  %t1209 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1207, i32 0, i32 1
  store i64 0, i64* %t1209
  %t1210 = insertvalue %NativeFunction %t1197, { i8**, i64 }* %t1207, 3
  %t1211 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* null, i32 1
  %t1212 = ptrtoint [0 x %NativeInstruction]* %t1211 to i64
  %t1213 = icmp eq i64 %t1212, 0
  %t1214 = select i1 %t1213, i64 1, i64 %t1212
  %t1215 = call i8* @malloc(i64 %t1214)
  %t1216 = bitcast i8* %t1215 to %NativeInstruction*
  %t1217 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t1218 = ptrtoint { %NativeInstruction*, i64 }* %t1217 to i64
  %t1219 = call i8* @malloc(i64 %t1218)
  %t1220 = bitcast i8* %t1219 to { %NativeInstruction*, i64 }*
  %t1221 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1220, i32 0, i32 0
  store %NativeInstruction* %t1216, %NativeInstruction** %t1221
  %t1222 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1220, i32 0, i32 1
  store i64 0, i64* %t1222
  %t1223 = insertvalue %NativeFunction %t1210, { %NativeInstruction*, i64 }* %t1220, 4
  %t1224 = alloca %NativeFunction
  store %NativeFunction %t1223, %NativeFunction* %t1224
  store %NativeFunction* %t1224, %NativeFunction** %l8
  %t1225 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1225, %NativeSourceSpan** %l9
  %t1226 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1226, %NativeSourceSpan** %l10
  %t1227 = load double, double* %l16
  %t1228 = sitofp i64 1 to double
  %t1229 = fadd double %t1227, %t1228
  store double %t1229, double* %l16
  br label %loop.latch4
merge80:
  %t1230 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1231 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h211710404, i32 0, i32 0
  %t1232 = load i8*, i8** %l18
  %t1233 = call i8* @sailfin_runtime_string_concat(i8* %s1231, i8* %t1232)
  %t1234 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1230, i8* %t1233)
  store { i8**, i64 }* %t1234, { i8**, i64 }** %l0
  %t1235 = load double, double* %l16
  %t1236 = sitofp i64 1 to double
  %t1237 = fadd double %t1235, %t1236
  store double %t1237, double* %l16
  br label %loop.latch4
loop.latch4:
  %t1238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1239 = load double, double* %l16
  %t1240 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1241 = load %NativeFunction*, %NativeFunction** %l8
  %t1242 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1243 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1244 = load double, double* %l12
  %t1245 = load double, double* %l13
  %t1246 = load i1, i1* %l14
  %t1247 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1248 = load i1, i1* %l15
  %t1249 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %loop.header2
afterloop5:
  %t1262 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1263 = load double, double* %l16
  %t1264 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1265 = load %NativeFunction*, %NativeFunction** %l8
  %t1266 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1267 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1268 = load double, double* %l12
  %t1269 = load double, double* %l13
  %t1270 = load i1, i1* %l14
  %t1271 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1272 = load i1, i1* %l15
  %t1273 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1274 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t1274, %NativeStructLayout** %l29
  %t1275 = load i1, i1* %l14
  %t1276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1277 = load i8*, i8** %l1
  %t1278 = load i8*, i8** %l2
  %t1279 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1280 = load i8*, i8** %l4
  %t1281 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1282 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1283 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1284 = load %NativeFunction*, %NativeFunction** %l8
  %t1285 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1286 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1287 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1288 = load double, double* %l12
  %t1289 = load double, double* %l13
  %t1290 = load i1, i1* %l14
  %t1291 = load i1, i1* %l15
  %t1292 = load double, double* %l16
  %t1293 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br i1 %t1275, label %then83, label %merge84
then83:
  %t1294 = load double, double* %l12
  %t1295 = insertvalue %NativeStructLayout undef, double %t1294, 0
  %t1296 = load double, double* %l13
  %t1297 = insertvalue %NativeStructLayout %t1295, double %t1296, 1
  %t1298 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1299 = insertvalue %NativeStructLayout %t1297, { %NativeStructLayoutField*, i64 }* %t1298, 2
  %t1300 = alloca %NativeStructLayout
  store %NativeStructLayout %t1299, %NativeStructLayout* %t1300
  store %NativeStructLayout* %t1300, %NativeStructLayout** %l29
  %t1301 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br label %merge84
merge84:
  %t1302 = phi %NativeStructLayout* [ %t1301, %then83 ], [ %t1293, %afterloop5 ]
  store %NativeStructLayout* %t1302, %NativeStructLayout** %l29
  %t1303 = load i8*, i8** %l4
  %t1304 = insertvalue %NativeStruct undef, i8* %t1303, 0
  %t1305 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1306 = insertvalue %NativeStruct %t1304, { %NativeStructField*, i64 }* %t1305, 1
  %t1307 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1308 = insertvalue %NativeStruct %t1306, { %NativeFunction*, i64 }* %t1307, 2
  %t1309 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1310 = insertvalue %NativeStruct %t1308, { i8**, i64 }* %t1309, 3
  %t1311 = load %NativeStructLayout*, %NativeStructLayout** %l29
  %t1312 = insertvalue %NativeStruct %t1310, %NativeStructLayout* %t1311, 4
  %t1313 = alloca %NativeStruct
  store %NativeStruct %t1312, %NativeStruct* %t1313
  %t1314 = insertvalue %StructParseResult undef, %NativeStruct* %t1313, 0
  %t1315 = load double, double* %l16
  %t1316 = insertvalue %StructParseResult %t1314, double %t1315, 1
  %t1317 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1318 = insertvalue %StructParseResult %t1316, { i8**, i64 }* %t1317, 2
  ret %StructParseResult %t1318
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
  %t20 = call i8* @trim_text__native_ir(i8* %t19)
  store i8* %t20, i8** %l1
  %t21 = load i8*, i8** %l1
  %s22 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h599952843, i32 0, i32 0
  %t23 = call i8* @strip_prefix(i8* %t21, i8* %s22)
  %t24 = call i8* @trim_text__native_ir(i8* %t23)
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
  %t253 = phi { i8**, i64 }* [ %t67, %merge1 ], [ %t250, %loop.latch4 ]
  %t254 = phi double [ %t73, %merge1 ], [ %t251, %loop.latch4 ]
  %t255 = phi { %NativeInterfaceSignature*, i64 }* [ %t72, %merge1 ], [ %t252, %loop.latch4 ]
  store { i8**, i64 }* %t253, { i8**, i64 }** %l0
  store double %t254, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t255, { %NativeInterfaceSignature*, i64 }** %l5
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
  %t97 = insertvalue %NativeInterface %t95, { %NativeInterfaceSignature*, i64 }* %t96, 2
  %t98 = alloca %NativeInterface
  store %NativeInterface %t97, %NativeInterface* %t98
  %t99 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t98, 0
  %t100 = load double, double* %l6
  %t101 = insertvalue %InterfaceParseResult %t99, double %t100, 1
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = insertvalue %InterfaceParseResult %t101, { i8**, i64 }* %t102, 2
  ret %InterfaceParseResult %t103
merge7:
  %t104 = load double, double* %l6
  %t105 = call double @llvm.round.f64(double %t104)
  %t106 = fptosi double %t105 to i64
  %t107 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t108 = extractvalue { i8**, i64 } %t107, 0
  %t109 = extractvalue { i8**, i64 } %t107, 1
  %t110 = icmp uge i64 %t106, %t109
  ; bounds check: %t110 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t106, i64 %t109)
  %t111 = getelementptr i8*, i8** %t108, i64 %t106
  %t112 = load i8*, i8** %t111
  %t113 = call i8* @trim_text__native_ir(i8* %t112)
  store i8* %t113, i8** %l7
  %t115 = load i8*, i8** %l7
  %t116 = call i64 @sailfin_runtime_string_length(i8* %t115)
  %t117 = icmp eq i64 %t116, 0
  br label %logical_or_entry_114

logical_or_entry_114:
  br i1 %t117, label %logical_or_merge_114, label %logical_or_right_114

logical_or_right_114:
  %t118 = load i8*, i8** %l7
  %t119 = add i64 0, 2
  %t120 = call i8* @malloc(i64 %t119)
  store i8 59, i8* %t120
  %t121 = getelementptr i8, i8* %t120, i64 1
  store i8 0, i8* %t121
  call void @sailfin_runtime_mark_persistent(i8* %t120)
  %t122 = call i1 @starts_with(i8* %t118, i8* %t120)
  br label %logical_or_right_end_114

logical_or_right_end_114:
  br label %logical_or_merge_114

logical_or_merge_114:
  %t123 = phi i1 [ true, %logical_or_entry_114 ], [ %t122, %logical_or_right_end_114 ]
  %t124 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t125 = load i8*, i8** %l1
  %t126 = load i8*, i8** %l2
  %t127 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t128 = load i8*, i8** %l4
  %t129 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t130 = load double, double* %l6
  %t131 = load i8*, i8** %l7
  br i1 %t123, label %then8, label %merge9
then8:
  %t132 = load double, double* %l6
  %t133 = sitofp i64 1 to double
  %t134 = fadd double %t132, %t133
  store double %t134, double* %l6
  br label %loop.latch4
merge9:
  %t135 = load i8*, i8** %l7
  %s136 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1382830532, i32 0, i32 0
  %t137 = call i1 @strings_equal(i8* %t135, i8* %s136)
  %t138 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t139 = load i8*, i8** %l1
  %t140 = load i8*, i8** %l2
  %t141 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t142 = load i8*, i8** %l4
  %t143 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t144 = load double, double* %l6
  %t145 = load i8*, i8** %l7
  br i1 %t137, label %then10, label %merge11
then10:
  %t146 = load double, double* %l6
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  store double %t148, double* %l6
  br label %afterloop5
merge11:
  %t149 = load i8*, i8** %l7
  %s150 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t151 = call i1 @strings_equal(i8* %t149, i8* %s150)
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t153 = load i8*, i8** %l1
  %t154 = load i8*, i8** %l2
  %t155 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t156 = load i8*, i8** %l4
  %t157 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t158 = load double, double* %l6
  %t159 = load i8*, i8** %l7
  br i1 %t151, label %then12, label %merge13
then12:
  %t160 = load double, double* %l6
  %t161 = sitofp i64 1 to double
  %t162 = fadd double %t160, %t161
  store double %t162, double* %l6
  br label %loop.latch4
merge13:
  %t163 = load i8*, i8** %l7
  %s164 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t165 = call i1 @starts_with(i8* %t163, i8* %s164)
  %t166 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t167 = load i8*, i8** %l1
  %t168 = load i8*, i8** %l2
  %t169 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t170 = load i8*, i8** %l4
  %t171 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t172 = load double, double* %l6
  %t173 = load i8*, i8** %l7
  br i1 %t165, label %then14, label %merge15
then14:
  %t174 = load i8*, i8** %l7
  %s175 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t176 = call i8* @strip_prefix(i8* %t174, i8* %s175)
  %t177 = load i8*, i8** %l4
  %t178 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t176, i8* %t177)
  store %InterfaceSignatureParse %t178, %InterfaceSignatureParse* %l8
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t181 = extractvalue %InterfaceSignatureParse %t180, 2
  %t182 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t179, { i8**, i64 }* %t181)
  store { i8**, i64 }* %t182, { i8**, i64 }** %l0
  %t183 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t184 = extractvalue %InterfaceSignatureParse %t183, 0
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t186 = load i8*, i8** %l1
  %t187 = load i8*, i8** %l2
  %t188 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t189 = load i8*, i8** %l4
  %t190 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t191 = load double, double* %l6
  %t192 = load i8*, i8** %l7
  %t193 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t184, label %then16, label %merge17
then16:
  %t194 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t195 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t196 = extractvalue %InterfaceSignatureParse %t195, 1
  %t197 = getelementptr [1 x %NativeInterfaceSignature], [1 x %NativeInterfaceSignature]* null, i32 1
  %t198 = ptrtoint [1 x %NativeInterfaceSignature]* %t197 to i64
  %t199 = icmp eq i64 %t198, 0
  %t200 = select i1 %t199, i64 1, i64 %t198
  %t201 = call i8* @malloc(i64 %t200)
  %t202 = bitcast i8* %t201 to %NativeInterfaceSignature*
  %t203 = getelementptr %NativeInterfaceSignature, %NativeInterfaceSignature* %t202, i64 0
  store %NativeInterfaceSignature %t196, %NativeInterfaceSignature* %t203
  %t204 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* null, i32 1
  %t205 = ptrtoint { %NativeInterfaceSignature*, i64 }* %t204 to i64
  %t206 = call i8* @malloc(i64 %t205)
  %t207 = bitcast i8* %t206 to { %NativeInterfaceSignature*, i64 }*
  %t208 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t207, i32 0, i32 0
  store %NativeInterfaceSignature* %t202, %NativeInterfaceSignature** %t208
  %t209 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t207, i32 0, i32 1
  store i64 1, i64* %t209
  %t210 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t194, i32 0, i32 0
  %t211 = load %NativeInterfaceSignature*, %NativeInterfaceSignature** %t210
  %t212 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t194, i32 0, i32 1
  %t213 = load i64, i64* %t212
  %t214 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t207, i32 0, i32 0
  %t215 = load %NativeInterfaceSignature*, %NativeInterfaceSignature** %t214
  %t216 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t207, i32 0, i32 1
  %t217 = load i64, i64* %t216
  %t218 = getelementptr [1 x %NativeInterfaceSignature], [1 x %NativeInterfaceSignature]* null, i32 0, i32 1
  %t219 = ptrtoint %NativeInterfaceSignature* %t218 to i64
  %t220 = add i64 %t213, %t217
  %t221 = mul i64 %t219, %t220
  %t222 = call noalias i8* @malloc(i64 %t221)
  %t223 = bitcast i8* %t222 to %NativeInterfaceSignature*
  %t224 = bitcast %NativeInterfaceSignature* %t223 to i8*
  %t225 = mul i64 %t219, %t213
  %t226 = bitcast %NativeInterfaceSignature* %t211 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t224, i8* %t226, i64 %t225)
  %t227 = mul i64 %t219, %t217
  %t228 = bitcast %NativeInterfaceSignature* %t215 to i8*
  %t229 = getelementptr %NativeInterfaceSignature, %NativeInterfaceSignature* %t223, i64 %t213
  %t230 = bitcast %NativeInterfaceSignature* %t229 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t230, i8* %t228, i64 %t227)
  %t231 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* null, i32 1
  %t232 = ptrtoint { %NativeInterfaceSignature*, i64 }* %t231 to i64
  %t233 = call i8* @malloc(i64 %t232)
  %t234 = bitcast i8* %t233 to { %NativeInterfaceSignature*, i64 }*
  %t235 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t234, i32 0, i32 0
  store %NativeInterfaceSignature* %t223, %NativeInterfaceSignature** %t235
  %t236 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t234, i32 0, i32 1
  store i64 %t220, i64* %t236
  store { %NativeInterfaceSignature*, i64 }* %t234, { %NativeInterfaceSignature*, i64 }** %l5
  %t237 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t238 = phi { %NativeInterfaceSignature*, i64 }* [ %t237, %then16 ], [ %t190, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t238, { %NativeInterfaceSignature*, i64 }** %l5
  %t239 = load double, double* %l6
  %t240 = sitofp i64 1 to double
  %t241 = fadd double %t239, %t240
  store double %t241, double* %l6
  br label %loop.latch4
merge15:
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s243 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1134984829, i32 0, i32 0
  %t244 = load i8*, i8** %l7
  %t245 = call i8* @sailfin_runtime_string_concat(i8* %s243, i8* %t244)
  %t246 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t242, i8* %t245)
  store { i8**, i64 }* %t246, { i8**, i64 }** %l0
  %t247 = load double, double* %l6
  %t248 = sitofp i64 1 to double
  %t249 = fadd double %t247, %t248
  store double %t249, double* %l6
  br label %loop.latch4
loop.latch4:
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t251 = load double, double* %l6
  %t252 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t256 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t257 = load double, double* %l6
  %t258 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t259 = load i8*, i8** %l4
  %t260 = insertvalue %NativeInterface undef, i8* %t259, 0
  %t261 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t262 = extractvalue %InterfaceHeaderParse %t261, 1
  %t263 = insertvalue %NativeInterface %t260, { i8**, i64 }* %t262, 1
  %t264 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t265 = insertvalue %NativeInterface %t263, { %NativeInterfaceSignature*, i64 }* %t264, 2
  %t266 = alloca %NativeInterface
  store %NativeInterface %t265, %NativeInterface* %t266
  %t267 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t266, 0
  %t268 = load double, double* %l6
  %t269 = insertvalue %InterfaceParseResult %t267, double %t268, 1
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = insertvalue %InterfaceParseResult %t269, { i8**, i64 }* %t270, 2
  ret %InterfaceParseResult %t271
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
  %t33 = call i8* @trim_text__native_ir(i8* %t32)
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
  %t67 = add i64 0, 2
  %t68 = call i8* @malloc(i64 %t67)
  store i8 96, i8* %t68
  %t69 = getelementptr i8, i8* %t68, i64 1
  store i8 0, i8* %t69
  call void @sailfin_runtime_mark_persistent(i8* %t68)
  %t70 = call i8* @sailfin_runtime_string_concat(i8* %t66, i8* %t68)
  %t71 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t57, i8* %t70)
  store { i8**, i64 }* %t71, { i8**, i64 }** %l1
  %t72 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge4
merge4:
  %t73 = phi { i8**, i64 }* [ %t55, %merge7 ], [ %t72, %else3 ]
  %t74 = phi { i8**, i64 }* [ %t56, %merge7 ], [ %t28, %else3 ]
  store { i8**, i64 }* %t73, { i8**, i64 }** %l1
  store { i8**, i64 }* %t74, { i8**, i64 }** %l2
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t76 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t77 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t78 = phi { i8**, i64 }* [ %t75, %merge4 ], [ %t20, %block.entry ]
  %t79 = phi { i8**, i64 }* [ %t76, %merge4 ], [ %t21, %block.entry ]
  %t80 = phi { i8**, i64 }* [ %t77, %merge4 ], [ %t20, %block.entry ]
  store { i8**, i64 }* %t78, { i8**, i64 }** %l1
  store { i8**, i64 }* %t79, { i8**, i64 }** %l2
  store { i8**, i64 }* %t80, { i8**, i64 }** %l1
  %t81 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t82 = extractvalue %HeaderNameParse %t81, 0
  %t83 = insertvalue %StructHeaderParse undef, i8* %t82, 0
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l2
  %t85 = insertvalue %StructHeaderParse %t83, { i8**, i64 }* %t84, 1
  %t86 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t87 = insertvalue %StructHeaderParse %t85, { i8**, i64 }* %t86, 2
  ret %StructHeaderParse %t87
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
  %t19 = add i64 0, 2
  %t20 = call i8* @malloc(i64 %t19)
  store i8 96, i8* %t20
  %t21 = getelementptr i8, i8* %t20, i64 1
  store i8 0, i8* %t21
  call void @sailfin_runtime_mark_persistent(i8* %t20)
  %t22 = call i8* @sailfin_runtime_string_concat(i8* %t18, i8* %t20)
  %t23 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t9, i8* %t22)
  store { i8**, i64 }* %t23, { i8**, i64 }** %l1
  %t24 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge1
merge1:
  %t25 = phi { i8**, i64 }* [ %t24, %then0 ], [ %t8, %block.entry ]
  store { i8**, i64 }* %t25, { i8**, i64 }** %l1
  %t26 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t27 = extractvalue %HeaderNameParse %t26, 0
  %t28 = insertvalue %InterfaceHeaderParse undef, i8* %t27, 0
  %t29 = load %HeaderNameParse, %HeaderNameParse* %l0
  %t30 = extractvalue %HeaderNameParse %t29, 1
  %t31 = insertvalue %InterfaceHeaderParse %t28, { i8**, i64 }* %t30, 1
  %t32 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t33 = insertvalue %InterfaceHeaderParse %t31, { i8**, i64 }* %t32, 2
  ret %InterfaceHeaderParse %t33
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
  %t28 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t29 = ptrtoint [0 x %NativeParameter]* %t28 to i64
  %t30 = icmp eq i64 %t29, 0
  %t31 = select i1 %t30, i64 1, i64 %t29
  %t32 = call i8* @malloc(i64 %t31)
  %t33 = bitcast i8* %t32 to %NativeParameter*
  %t34 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeParameter*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeParameter*, i64 }*
  %t38 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t37, i32 0, i32 0
  store %NativeParameter* %t33, %NativeParameter** %t38
  %t39 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t37, i32 0, i32 1
  store i64 0, i64* %t39
  %t40 = insertvalue %NativeInterfaceSignature %t27, { %NativeParameter*, i64 }* %t37, 3
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
  %t56 = call i8* @trim_text__native_ir(i8* %text)
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
  %t87 = call i8* @trim_text__native_ir(i8* %t86)
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
  %t93 = add i64 0, 2
  %t94 = call i8* @malloc(i64 %t93)
  store i8 40, i8* %t94
  %t95 = getelementptr i8, i8* %t94, i64 1
  store i8 0, i8* %t95
  call void @sailfin_runtime_mark_persistent(i8* %t94)
  %t96 = call double @index_of(i8* %t92, i8* %t94)
  store double %t96, double* %l5
  %t97 = load double, double* %l5
  %t98 = sitofp i64 0 to double
  %t99 = fcmp olt double %t97, %t98
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t102 = load i8*, i8** %l2
  %t103 = load i8*, i8** %l3
  %t104 = load i1, i1* %l4
  %t105 = load double, double* %l5
  br i1 %t99, label %then4, label %merge5
then4:
  %t106 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s107 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t108 = call i8* @sailfin_runtime_string_concat(i8* %s107, i8* %interface_name)
  %s109 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h546841458, i32 0, i32 0
  %t110 = call i8* @sailfin_runtime_string_concat(i8* %t108, i8* %s109)
  %t111 = load i8*, i8** %l2
  %t112 = call i8* @sailfin_runtime_string_concat(i8* %t110, i8* %t111)
  %t113 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t106, i8* %t112)
  store { i8**, i64 }* %t113, { i8**, i64 }** %l0
  %t114 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t115 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t116 = insertvalue %InterfaceSignatureParse %t114, %NativeInterfaceSignature %t115, 1
  %t117 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t118 = insertvalue %InterfaceSignatureParse %t116, { i8**, i64 }* %t117, 2
  ret %InterfaceSignatureParse %t118
merge5:
  %t119 = load i8*, i8** %l3
  %t120 = load double, double* %l5
  %t121 = call double @find_matching_paren(i8* %t119, double %t120)
  store double %t121, double* %l6
  %t122 = load double, double* %l6
  %t123 = sitofp i64 0 to double
  %t124 = fcmp olt double %t122, %t123
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t126 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t127 = load i8*, i8** %l2
  %t128 = load i8*, i8** %l3
  %t129 = load i1, i1* %l4
  %t130 = load double, double* %l5
  %t131 = load double, double* %l6
  br i1 %t124, label %then6, label %merge7
then6:
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s133 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t134 = call i8* @sailfin_runtime_string_concat(i8* %s133, i8* %interface_name)
  %s135 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.len44.h1730891783, i32 0, i32 0
  %t136 = call i8* @sailfin_runtime_string_concat(i8* %t134, i8* %s135)
  %t137 = load i8*, i8** %l2
  %t138 = call i8* @sailfin_runtime_string_concat(i8* %t136, i8* %t137)
  %t139 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t132, i8* %t138)
  store { i8**, i64 }* %t139, { i8**, i64 }** %l0
  %t140 = insertvalue %InterfaceSignatureParse undef, i1 0, 0
  %t141 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t142 = insertvalue %InterfaceSignatureParse %t140, %NativeInterfaceSignature %t141, 1
  %t143 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t144 = insertvalue %InterfaceSignatureParse %t142, { i8**, i64 }* %t143, 2
  ret %InterfaceSignatureParse %t144
merge7:
  %t145 = load i8*, i8** %l3
  %t146 = load double, double* %l5
  %t147 = call double @llvm.round.f64(double %t146)
  %t148 = fptosi double %t147 to i64
  %t149 = call i8* @sailfin_runtime_substring(i8* %t145, i64 0, i64 %t148)
  %t150 = call i8* @trim_text__native_ir(i8* %t149)
  store i8* %t150, i8** %l7
  %t151 = load i8*, i8** %l7
  %t152 = call %HeaderNameParse @parse_header_name_and_remainder(i8* %t151)
  store %HeaderNameParse %t152, %HeaderNameParse* %l8
  %t153 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t154 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t155 = extractvalue %HeaderNameParse %t154, 3
  %t156 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t153, { i8**, i64 }* %t155)
  store { i8**, i64 }* %t156, { i8**, i64 }** %l0
  %t157 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t158 = extractvalue %HeaderNameParse %t157, 2
  %t159 = call i64 @sailfin_runtime_string_length(i8* %t158)
  %t160 = icmp sgt i64 %t159, 0
  %t161 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t162 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t163 = load i8*, i8** %l2
  %t164 = load i8*, i8** %l3
  %t165 = load i1, i1* %l4
  %t166 = load double, double* %l5
  %t167 = load double, double* %l6
  %t168 = load i8*, i8** %l7
  %t169 = load %HeaderNameParse, %HeaderNameParse* %l8
  br i1 %t160, label %then8, label %merge9
then8:
  %t170 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s171 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t172 = call i8* @sailfin_runtime_string_concat(i8* %s171, i8* %interface_name)
  %s173 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t174 = call i8* @sailfin_runtime_string_concat(i8* %t172, i8* %s173)
  %t175 = load i8*, i8** %l2
  %t176 = call i8* @sailfin_runtime_string_concat(i8* %t174, i8* %t175)
  %s177 = getelementptr inbounds [28 x i8], [28 x i8]* @.str.len27.h237652301, i32 0, i32 0
  %t178 = call i8* @sailfin_runtime_string_concat(i8* %t176, i8* %s177)
  %t179 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t180 = extractvalue %HeaderNameParse %t179, 2
  %t181 = call i8* @sailfin_runtime_string_concat(i8* %t178, i8* %t180)
  %t182 = add i64 0, 2
  %t183 = call i8* @malloc(i64 %t182)
  store i8 96, i8* %t183
  %t184 = getelementptr i8, i8* %t183, i64 1
  store i8 0, i8* %t184
  call void @sailfin_runtime_mark_persistent(i8* %t183)
  %t185 = call i8* @sailfin_runtime_string_concat(i8* %t181, i8* %t183)
  %t186 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t170, i8* %t185)
  store { i8**, i64 }* %t186, { i8**, i64 }** %l0
  %t187 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge9
merge9:
  %t188 = phi { i8**, i64 }* [ %t187, %then8 ], [ %t161, %merge7 ]
  store { i8**, i64 }* %t188, { i8**, i64 }** %l0
  %t189 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t190 = extractvalue %HeaderNameParse %t189, 0
  store i8* %t190, i8** %l9
  %t191 = load i8*, i8** %l9
  %t192 = call i64 @sailfin_runtime_string_length(i8* %t191)
  %t193 = icmp eq i64 %t192, 0
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t195 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t196 = load i8*, i8** %l2
  %t197 = load i8*, i8** %l3
  %t198 = load i1, i1* %l4
  %t199 = load double, double* %l5
  %t200 = load double, double* %l6
  %t201 = load i8*, i8** %l7
  %t202 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t203 = load i8*, i8** %l9
  br i1 %t193, label %then10, label %merge11
then10:
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s205 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t206 = call i8* @sailfin_runtime_string_concat(i8* %s205, i8* %interface_name)
  %s207 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t208 = call i8* @sailfin_runtime_string_concat(i8* %t206, i8* %s207)
  %t209 = load i8*, i8** %l2
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t208, i8* %t209)
  %s211 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1219450488, i32 0, i32 0
  %t212 = call i8* @sailfin_runtime_string_concat(i8* %t210, i8* %s211)
  %t213 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t204, i8* %t212)
  store { i8**, i64 }* %t213, { i8**, i64 }** %l0
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge11
merge11:
  %t215 = phi { i8**, i64 }* [ %t214, %then10 ], [ %t194, %merge9 ]
  store { i8**, i64 }* %t215, { i8**, i64 }** %l0
  %t216 = load i8*, i8** %l3
  %t217 = load double, double* %l5
  %t218 = sitofp i64 1 to double
  %t219 = fadd double %t217, %t218
  %t220 = load double, double* %l6
  %t221 = call double @llvm.round.f64(double %t219)
  %t222 = fptosi double %t221 to i64
  %t223 = call double @llvm.round.f64(double %t220)
  %t224 = fptosi double %t223 to i64
  %t225 = call i8* @sailfin_runtime_substring(i8* %t216, i64 %t222, i64 %t224)
  store i8* %t225, i8** %l10
  %t226 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t227 = ptrtoint [0 x %NativeParameter]* %t226 to i64
  %t228 = icmp eq i64 %t227, 0
  %t229 = select i1 %t228, i64 1, i64 %t227
  %t230 = call i8* @malloc(i64 %t229)
  %t231 = bitcast i8* %t230 to %NativeParameter*
  %t232 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t233 = ptrtoint { %NativeParameter*, i64 }* %t232 to i64
  %t234 = call i8* @malloc(i64 %t233)
  %t235 = bitcast i8* %t234 to { %NativeParameter*, i64 }*
  %t236 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t235, i32 0, i32 0
  store %NativeParameter* %t231, %NativeParameter** %t236
  %t237 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t235, i32 0, i32 1
  store i64 0, i64* %t237
  store { %NativeParameter*, i64 }* %t235, { %NativeParameter*, i64 }** %l11
  %t238 = load i8*, i8** %l10
  %t239 = call i8* @trim_text__native_ir(i8* %t238)
  store i8* %t239, i8** %l12
  %t240 = load i8*, i8** %l12
  %t241 = call i64 @sailfin_runtime_string_length(i8* %t240)
  %t242 = icmp sgt i64 %t241, 0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t244 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t245 = load i8*, i8** %l2
  %t246 = load i8*, i8** %l3
  %t247 = load i1, i1* %l4
  %t248 = load double, double* %l5
  %t249 = load double, double* %l6
  %t250 = load i8*, i8** %l7
  %t251 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t252 = load i8*, i8** %l9
  %t253 = load i8*, i8** %l10
  %t254 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t255 = load i8*, i8** %l12
  br i1 %t242, label %then12, label %merge13
then12:
  %t256 = load i8*, i8** %l12
  %t257 = call { i8**, i64 }* @split_parameter_entries(i8* %t256)
  store { i8**, i64 }* %t257, { i8**, i64 }** %l13
  %t258 = sitofp i64 0 to double
  store double %t258, double* %l14
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t260 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t261 = load i8*, i8** %l2
  %t262 = load i8*, i8** %l3
  %t263 = load i1, i1* %l4
  %t264 = load double, double* %l5
  %t265 = load double, double* %l6
  %t266 = load i8*, i8** %l7
  %t267 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t268 = load i8*, i8** %l9
  %t269 = load i8*, i8** %l10
  %t270 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t271 = load i8*, i8** %l12
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t273 = load double, double* %l14
  br label %loop.header14
loop.header14:
  %t364 = phi { i8**, i64 }* [ %t259, %then12 ], [ %t361, %loop.latch16 ]
  %t365 = phi { %NativeParameter*, i64 }* [ %t270, %then12 ], [ %t362, %loop.latch16 ]
  %t366 = phi double [ %t273, %then12 ], [ %t363, %loop.latch16 ]
  store { i8**, i64 }* %t364, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t365, { %NativeParameter*, i64 }** %l11
  store double %t366, double* %l14
  br label %loop.body15
loop.body15:
  %t274 = load double, double* %l14
  %t275 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t276 = load { i8**, i64 }, { i8**, i64 }* %t275
  %t277 = extractvalue { i8**, i64 } %t276, 1
  %t278 = sitofp i64 %t277 to double
  %t279 = fcmp oge double %t274, %t278
  %t280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t281 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t282 = load i8*, i8** %l2
  %t283 = load i8*, i8** %l3
  %t284 = load i1, i1* %l4
  %t285 = load double, double* %l5
  %t286 = load double, double* %l6
  %t287 = load i8*, i8** %l7
  %t288 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t289 = load i8*, i8** %l9
  %t290 = load i8*, i8** %l10
  %t291 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t292 = load i8*, i8** %l12
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t294 = load double, double* %l14
  br i1 %t279, label %then18, label %merge19
then18:
  br label %afterloop17
merge19:
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t296 = load double, double* %l14
  %t297 = call double @llvm.round.f64(double %t296)
  %t298 = fptosi double %t297 to i64
  %t299 = load { i8**, i64 }, { i8**, i64 }* %t295
  %t300 = extractvalue { i8**, i64 } %t299, 0
  %t301 = extractvalue { i8**, i64 } %t299, 1
  %t302 = icmp uge i64 %t298, %t301
  ; bounds check: %t302 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t298, i64 %t301)
  %t303 = getelementptr i8*, i8** %t300, i64 %t298
  %t304 = load i8*, i8** %t303
  %t305 = bitcast i8* null to %NativeSourceSpan*
  %t306 = call %NativeParameter* @parse_parameter_entry(i8* %t304, %NativeSourceSpan* %t305)
  store %NativeParameter* %t306, %NativeParameter** %l15
  %t307 = load %NativeParameter*, %NativeParameter** %l15
  %t308 = icmp eq %NativeParameter* %t307, null
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t310 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t311 = load i8*, i8** %l2
  %t312 = load i8*, i8** %l3
  %t313 = load i1, i1* %l4
  %t314 = load double, double* %l5
  %t315 = load double, double* %l6
  %t316 = load i8*, i8** %l7
  %t317 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t318 = load i8*, i8** %l9
  %t319 = load i8*, i8** %l10
  %t320 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t321 = load i8*, i8** %l12
  %t322 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t323 = load double, double* %l14
  %t324 = load %NativeParameter*, %NativeParameter** %l15
  br i1 %t308, label %then20, label %else21
then20:
  %t325 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s326 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t327 = call i8* @sailfin_runtime_string_concat(i8* %s326, i8* %interface_name)
  %s328 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t329 = call i8* @sailfin_runtime_string_concat(i8* %t327, i8* %s328)
  %t330 = load i8*, i8** %l9
  %t331 = call i8* @sailfin_runtime_string_concat(i8* %t329, i8* %t330)
  %s332 = getelementptr inbounds [26 x i8], [26 x i8]* @.str.len25.h378946335, i32 0, i32 0
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %t331, i8* %s332)
  %t334 = load { i8**, i64 }*, { i8**, i64 }** %l13
  %t335 = load double, double* %l14
  %t336 = call double @llvm.round.f64(double %t335)
  %t337 = fptosi double %t336 to i64
  %t338 = load { i8**, i64 }, { i8**, i64 }* %t334
  %t339 = extractvalue { i8**, i64 } %t338, 0
  %t340 = extractvalue { i8**, i64 } %t338, 1
  %t341 = icmp uge i64 %t337, %t340
  ; bounds check: %t341 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t337, i64 %t340)
  %t342 = getelementptr i8*, i8** %t339, i64 %t337
  %t343 = load i8*, i8** %t342
  %t344 = call i8* @sailfin_runtime_string_concat(i8* %t333, i8* %t343)
  %t345 = add i64 0, 2
  %t346 = call i8* @malloc(i64 %t345)
  store i8 96, i8* %t346
  %t347 = getelementptr i8, i8* %t346, i64 1
  store i8 0, i8* %t347
  call void @sailfin_runtime_mark_persistent(i8* %t346)
  %t348 = call i8* @sailfin_runtime_string_concat(i8* %t344, i8* %t346)
  %t349 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t325, i8* %t348)
  store { i8**, i64 }* %t349, { i8**, i64 }** %l0
  %t350 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge22
else21:
  %t351 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t352 = load %NativeParameter*, %NativeParameter** %l15
  %t353 = load %NativeParameter, %NativeParameter* %t352
  %t354 = call { %NativeParameter*, i64 }* @append_parameter_array({ %NativeParameter*, i64 }* %t351, %NativeParameter %t353)
  store { %NativeParameter*, i64 }* %t354, { %NativeParameter*, i64 }** %l11
  %t355 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge22
merge22:
  %t356 = phi { i8**, i64 }* [ %t350, %then20 ], [ %t309, %else21 ]
  %t357 = phi { %NativeParameter*, i64 }* [ %t320, %then20 ], [ %t355, %else21 ]
  store { i8**, i64 }* %t356, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t357, { %NativeParameter*, i64 }** %l11
  %t358 = load double, double* %l14
  %t359 = sitofp i64 1 to double
  %t360 = fadd double %t358, %t359
  store double %t360, double* %l14
  br label %loop.latch16
loop.latch16:
  %t361 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t362 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t363 = load double, double* %l14
  br label %loop.header14
afterloop17:
  %t367 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t368 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t369 = load double, double* %l14
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t371 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  br label %merge13
merge13:
  %t372 = phi { i8**, i64 }* [ %t370, %afterloop17 ], [ %t243, %merge11 ]
  %t373 = phi { %NativeParameter*, i64 }* [ %t371, %afterloop17 ], [ %t254, %merge11 ]
  store { i8**, i64 }* %t372, { i8**, i64 }** %l0
  store { %NativeParameter*, i64 }* %t373, { %NativeParameter*, i64 }** %l11
  %s374 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  store i8* %s374, i8** %l16
  %t375 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t376 = ptrtoint [0 x i8*]* %t375 to i64
  %t377 = icmp eq i64 %t376, 0
  %t378 = select i1 %t377, i64 1, i64 %t376
  %t379 = call i8* @malloc(i64 %t378)
  %t380 = bitcast i8* %t379 to i8**
  %t381 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t382 = ptrtoint { i8**, i64 }* %t381 to i64
  %t383 = call i8* @malloc(i64 %t382)
  %t384 = bitcast i8* %t383 to { i8**, i64 }*
  %t385 = getelementptr { i8**, i64 }, { i8**, i64 }* %t384, i32 0, i32 0
  store i8** %t380, i8*** %t385
  %t386 = getelementptr { i8**, i64 }, { i8**, i64 }* %t384, i32 0, i32 1
  store i64 0, i64* %t386
  store { i8**, i64 }* %t384, { i8**, i64 }** %l17
  %t387 = load i8*, i8** %l3
  %t388 = load double, double* %l6
  %t389 = sitofp i64 1 to double
  %t390 = fadd double %t388, %t389
  %t391 = load i8*, i8** %l3
  %t392 = call i64 @sailfin_runtime_string_length(i8* %t391)
  %t393 = call double @llvm.round.f64(double %t390)
  %t394 = fptosi double %t393 to i64
  %t395 = call i8* @sailfin_runtime_substring(i8* %t387, i64 %t394, i64 %t392)
  %t396 = call i8* @trim_text__native_ir(i8* %t395)
  store i8* %t396, i8** %l18
  %t397 = load i8*, i8** %l18
  %t398 = call i64 @sailfin_runtime_string_length(i8* %t397)
  %t399 = icmp sgt i64 %t398, 0
  %t400 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t401 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t402 = load i8*, i8** %l2
  %t403 = load i8*, i8** %l3
  %t404 = load i1, i1* %l4
  %t405 = load double, double* %l5
  %t406 = load double, double* %l6
  %t407 = load i8*, i8** %l7
  %t408 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t409 = load i8*, i8** %l9
  %t410 = load i8*, i8** %l10
  %t411 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t412 = load i8*, i8** %l12
  %t413 = load i8*, i8** %l16
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t415 = load i8*, i8** %l18
  br i1 %t399, label %then23, label %merge24
then23:
  %t416 = load i8*, i8** %l18
  %s417 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t418 = call double @index_of(i8* %t416, i8* %s417)
  store double %t418, double* %l19
  %s419 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s419, i8** %l20
  %t420 = load double, double* %l19
  %t421 = sitofp i64 0 to double
  %t422 = fcmp oge double %t420, %t421
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t424 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t425 = load i8*, i8** %l2
  %t426 = load i8*, i8** %l3
  %t427 = load i1, i1* %l4
  %t428 = load double, double* %l5
  %t429 = load double, double* %l6
  %t430 = load i8*, i8** %l7
  %t431 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t432 = load i8*, i8** %l9
  %t433 = load i8*, i8** %l10
  %t434 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t435 = load i8*, i8** %l12
  %t436 = load i8*, i8** %l16
  %t437 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t438 = load i8*, i8** %l18
  %t439 = load double, double* %l19
  %t440 = load i8*, i8** %l20
  br i1 %t422, label %then25, label %merge26
then25:
  %t441 = load i8*, i8** %l18
  %t442 = load double, double* %l19
  %t443 = load i8*, i8** %l18
  %t444 = call i64 @sailfin_runtime_string_length(i8* %t443)
  %t445 = call double @llvm.round.f64(double %t442)
  %t446 = fptosi double %t445 to i64
  %t447 = call i8* @sailfin_runtime_substring(i8* %t441, i64 %t446, i64 %t444)
  %t448 = call i8* @trim_text__native_ir(i8* %t447)
  store i8* %t448, i8** %l20
  %t449 = load i8*, i8** %l18
  %t450 = load double, double* %l19
  %t451 = call double @llvm.round.f64(double %t450)
  %t452 = fptosi double %t451 to i64
  %t453 = call i8* @sailfin_runtime_substring(i8* %t449, i64 0, i64 %t452)
  %t454 = call i8* @trim_text__native_ir(i8* %t453)
  store i8* %t454, i8** %l18
  %t455 = load i8*, i8** %l20
  %t456 = load i8*, i8** %l18
  br label %merge26
merge26:
  %t457 = phi i8* [ %t455, %then25 ], [ %t440, %then23 ]
  %t458 = phi i8* [ %t456, %then25 ], [ %t438, %then23 ]
  store i8* %t457, i8** %l20
  store i8* %t458, i8** %l18
  %t459 = load i8*, i8** %l18
  %t460 = call i64 @sailfin_runtime_string_length(i8* %t459)
  %t461 = icmp sgt i64 %t460, 0
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t463 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t464 = load i8*, i8** %l2
  %t465 = load i8*, i8** %l3
  %t466 = load i1, i1* %l4
  %t467 = load double, double* %l5
  %t468 = load double, double* %l6
  %t469 = load i8*, i8** %l7
  %t470 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t471 = load i8*, i8** %l9
  %t472 = load i8*, i8** %l10
  %t473 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t474 = load i8*, i8** %l12
  %t475 = load i8*, i8** %l16
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t477 = load i8*, i8** %l18
  %t478 = load double, double* %l19
  %t479 = load i8*, i8** %l20
  br i1 %t461, label %then27, label %merge28
then27:
  %t480 = load i8*, i8** %l18
  %s481 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t482 = call i1 @starts_with(i8* %t480, i8* %s481)
  %t483 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t484 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t485 = load i8*, i8** %l2
  %t486 = load i8*, i8** %l3
  %t487 = load i1, i1* %l4
  %t488 = load double, double* %l5
  %t489 = load double, double* %l6
  %t490 = load i8*, i8** %l7
  %t491 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t492 = load i8*, i8** %l9
  %t493 = load i8*, i8** %l10
  %t494 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t495 = load i8*, i8** %l12
  %t496 = load i8*, i8** %l16
  %t497 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t498 = load i8*, i8** %l18
  %t499 = load double, double* %l19
  %t500 = load i8*, i8** %l20
  br i1 %t482, label %then29, label %else30
then29:
  %t501 = load i8*, i8** %l18
  %s502 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t503 = call i8* @strip_prefix(i8* %t501, i8* %s502)
  %t504 = call i8* @trim_text__native_ir(i8* %t503)
  store i8* %t504, i8** %l21
  %t505 = load i8*, i8** %l21
  %t506 = call i64 @sailfin_runtime_string_length(i8* %t505)
  %t507 = icmp sgt i64 %t506, 0
  %t508 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t509 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t510 = load i8*, i8** %l2
  %t511 = load i8*, i8** %l3
  %t512 = load i1, i1* %l4
  %t513 = load double, double* %l5
  %t514 = load double, double* %l6
  %t515 = load i8*, i8** %l7
  %t516 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t517 = load i8*, i8** %l9
  %t518 = load i8*, i8** %l10
  %t519 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t520 = load i8*, i8** %l12
  %t521 = load i8*, i8** %l16
  %t522 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t523 = load i8*, i8** %l18
  %t524 = load double, double* %l19
  %t525 = load i8*, i8** %l20
  %t526 = load i8*, i8** %l21
  br i1 %t507, label %then32, label %merge33
then32:
  %t527 = load i8*, i8** %l21
  store i8* %t527, i8** %l16
  %t528 = load i8*, i8** %l16
  br label %merge33
merge33:
  %t529 = phi i8* [ %t528, %then32 ], [ %t521, %then29 ]
  store i8* %t529, i8** %l16
  %t530 = load i8*, i8** %l16
  br label %merge31
else30:
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s532 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t533 = call i8* @sailfin_runtime_string_concat(i8* %s532, i8* %interface_name)
  %s534 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t535 = call i8* @sailfin_runtime_string_concat(i8* %t533, i8* %s534)
  %t536 = load i8*, i8** %l9
  %t537 = call i8* @sailfin_runtime_string_concat(i8* %t535, i8* %t536)
  %s538 = getelementptr inbounds [27 x i8], [27 x i8]* @.str.len26.h1606904140, i32 0, i32 0
  %t539 = call i8* @sailfin_runtime_string_concat(i8* %t537, i8* %s538)
  %t540 = load i8*, i8** %l18
  %t541 = call i8* @sailfin_runtime_string_concat(i8* %t539, i8* %t540)
  %t542 = add i64 0, 2
  %t543 = call i8* @malloc(i64 %t542)
  store i8 96, i8* %t543
  %t544 = getelementptr i8, i8* %t543, i64 1
  store i8 0, i8* %t544
  call void @sailfin_runtime_mark_persistent(i8* %t543)
  %t545 = call i8* @sailfin_runtime_string_concat(i8* %t541, i8* %t543)
  %t546 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t531, i8* %t545)
  store { i8**, i64 }* %t546, { i8**, i64 }** %l0
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
merge31:
  %t548 = phi i8* [ %t530, %merge33 ], [ %t496, %else30 ]
  %t549 = phi { i8**, i64 }* [ %t483, %merge33 ], [ %t547, %else30 ]
  store i8* %t548, i8** %l16
  store { i8**, i64 }* %t549, { i8**, i64 }** %l0
  %t550 = load i8*, i8** %l16
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge28
merge28:
  %t552 = phi i8* [ %t550, %merge31 ], [ %t475, %merge26 ]
  %t553 = phi { i8**, i64 }* [ %t551, %merge31 ], [ %t462, %merge26 ]
  store i8* %t552, i8** %l16
  store { i8**, i64 }* %t553, { i8**, i64 }** %l0
  %t554 = load i8*, i8** %l20
  %t555 = call i64 @sailfin_runtime_string_length(i8* %t554)
  %t556 = icmp sgt i64 %t555, 0
  %t557 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t558 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t559 = load i8*, i8** %l2
  %t560 = load i8*, i8** %l3
  %t561 = load i1, i1* %l4
  %t562 = load double, double* %l5
  %t563 = load double, double* %l6
  %t564 = load i8*, i8** %l7
  %t565 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t566 = load i8*, i8** %l9
  %t567 = load i8*, i8** %l10
  %t568 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t569 = load i8*, i8** %l12
  %t570 = load i8*, i8** %l16
  %t571 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t572 = load i8*, i8** %l18
  %t573 = load double, double* %l19
  %t574 = load i8*, i8** %l20
  br i1 %t556, label %then34, label %merge35
then34:
  %t576 = load i8*, i8** %l20
  %s577 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193415939, i32 0, i32 0
  %t578 = call i1 @starts_with(i8* %t576, i8* %s577)
  br label %logical_and_entry_575

logical_and_entry_575:
  br i1 %t578, label %logical_and_right_575, label %logical_and_merge_575

logical_and_right_575:
  %t579 = load i8*, i8** %l20
  %t580 = load i8*, i8** %l20
  %t581 = call i64 @sailfin_runtime_string_length(i8* %t580)
  %t582 = sub i64 %t581, 1
  %t583 = getelementptr i8, i8* %t579, i64 %t582
  %t584 = load i8, i8* %t583
  %t585 = icmp eq i8 %t584, 93
  br label %logical_and_right_end_575

logical_and_right_end_575:
  br label %logical_and_merge_575

logical_and_merge_575:
  %t586 = phi i1 [ false, %logical_and_entry_575 ], [ %t585, %logical_and_right_end_575 ]
  %t587 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t588 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l1
  %t589 = load i8*, i8** %l2
  %t590 = load i8*, i8** %l3
  %t591 = load i1, i1* %l4
  %t592 = load double, double* %l5
  %t593 = load double, double* %l6
  %t594 = load i8*, i8** %l7
  %t595 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t596 = load i8*, i8** %l9
  %t597 = load i8*, i8** %l10
  %t598 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t599 = load i8*, i8** %l12
  %t600 = load i8*, i8** %l16
  %t601 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t602 = load i8*, i8** %l18
  %t603 = load double, double* %l19
  %t604 = load i8*, i8** %l20
  br i1 %t586, label %then36, label %else37
then36:
  %t605 = load i8*, i8** %l20
  %t606 = load i8*, i8** %l20
  %t607 = call i64 @sailfin_runtime_string_length(i8* %t606)
  %t608 = sub i64 %t607, 1
  %t609 = call i8* @sailfin_runtime_substring(i8* %t605, i64 2, i64 %t608)
  store i8* %t609, i8** %l22
  %t610 = load i8*, i8** %l22
  %t611 = call { i8**, i64 }* @parse_effect_list(i8* %t610)
  store { i8**, i64 }* %t611, { i8**, i64 }** %l17
  %t612 = load { i8**, i64 }*, { i8**, i64 }** %l17
  br label %merge38
else37:
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s614 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h385719500, i32 0, i32 0
  %t615 = call i8* @sailfin_runtime_string_concat(i8* %s614, i8* %interface_name)
  %s616 = getelementptr inbounds [13 x i8], [13 x i8]* @.str.len12.h841153022, i32 0, i32 0
  %t617 = call i8* @sailfin_runtime_string_concat(i8* %t615, i8* %s616)
  %t618 = load i8*, i8** %l9
  %t619 = call i8* @sailfin_runtime_string_concat(i8* %t617, i8* %t618)
  %s620 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h1377481172, i32 0, i32 0
  %t621 = call i8* @sailfin_runtime_string_concat(i8* %t619, i8* %s620)
  %t622 = load i8*, i8** %l20
  %t623 = call i8* @sailfin_runtime_string_concat(i8* %t621, i8* %t622)
  %t624 = add i64 0, 2
  %t625 = call i8* @malloc(i64 %t624)
  store i8 96, i8* %t625
  %t626 = getelementptr i8, i8* %t625, i64 1
  store i8 0, i8* %t626
  call void @sailfin_runtime_mark_persistent(i8* %t625)
  %t627 = call i8* @sailfin_runtime_string_concat(i8* %t623, i8* %t625)
  %t628 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t613, i8* %t627)
  store { i8**, i64 }* %t628, { i8**, i64 }** %l0
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
merge38:
  %t630 = phi { i8**, i64 }* [ %t612, %then36 ], [ %t601, %else37 ]
  %t631 = phi { i8**, i64 }* [ %t587, %then36 ], [ %t629, %else37 ]
  store { i8**, i64 }* %t630, { i8**, i64 }** %l17
  store { i8**, i64 }* %t631, { i8**, i64 }** %l0
  %t632 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t633 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge35
merge35:
  %t634 = phi { i8**, i64 }* [ %t632, %merge38 ], [ %t571, %merge28 ]
  %t635 = phi { i8**, i64 }* [ %t633, %merge38 ], [ %t557, %merge28 ]
  store { i8**, i64 }* %t634, { i8**, i64 }** %l17
  store { i8**, i64 }* %t635, { i8**, i64 }** %l0
  %t636 = load i8*, i8** %l18
  %t637 = load i8*, i8** %l16
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t639 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t640 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
merge24:
  %t641 = phi i8* [ %t636, %merge35 ], [ %t415, %merge13 ]
  %t642 = phi i8* [ %t637, %merge35 ], [ %t413, %merge13 ]
  %t643 = phi { i8**, i64 }* [ %t638, %merge35 ], [ %t400, %merge13 ]
  %t644 = phi { i8**, i64 }* [ %t639, %merge35 ], [ %t414, %merge13 ]
  %t645 = phi { i8**, i64 }* [ %t640, %merge35 ], [ %t400, %merge13 ]
  store i8* %t641, i8** %l18
  store i8* %t642, i8** %l16
  store { i8**, i64 }* %t643, { i8**, i64 }** %l0
  store { i8**, i64 }* %t644, { i8**, i64 }** %l17
  store { i8**, i64 }* %t645, { i8**, i64 }** %l0
  %t646 = load i8*, i8** %l9
  %t647 = insertvalue %NativeInterfaceSignature undef, i8* %t646, 0
  %t648 = load i1, i1* %l4
  %t649 = insertvalue %NativeInterfaceSignature %t647, i1 %t648, 1
  %t650 = load %HeaderNameParse, %HeaderNameParse* %l8
  %t651 = extractvalue %HeaderNameParse %t650, 1
  %t652 = insertvalue %NativeInterfaceSignature %t649, { i8**, i64 }* %t651, 2
  %t653 = load { %NativeParameter*, i64 }*, { %NativeParameter*, i64 }** %l11
  %t654 = insertvalue %NativeInterfaceSignature %t652, { %NativeParameter*, i64 }* %t653, 3
  %t655 = load i8*, i8** %l16
  %t656 = insertvalue %NativeInterfaceSignature %t654, i8* %t655, 4
  %t657 = load { i8**, i64 }*, { i8**, i64 }** %l17
  %t658 = insertvalue %NativeInterfaceSignature %t656, { i8**, i64 }* %t657, 5
  store %NativeInterfaceSignature %t658, %NativeInterfaceSignature* %l23
  %t660 = load i8*, i8** %l9
  %t661 = call i64 @sailfin_runtime_string_length(i8* %t660)
  %t662 = icmp sgt i64 %t661, 0
  br label %logical_and_entry_659

logical_and_entry_659:
  br i1 %t662, label %logical_and_right_659, label %logical_and_merge_659

logical_and_right_659:
  %t663 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t664 = load { i8**, i64 }, { i8**, i64 }* %t663
  %t665 = extractvalue { i8**, i64 } %t664, 1
  %t666 = icmp eq i64 %t665, 0
  br label %logical_and_right_end_659

logical_and_right_end_659:
  br label %logical_and_merge_659

logical_and_merge_659:
  %t667 = phi i1 [ false, %logical_and_entry_659 ], [ %t666, %logical_and_right_end_659 ]
  store i1 %t667, i1* %l24
  %t668 = load i1, i1* %l24
  %t669 = insertvalue %InterfaceSignatureParse undef, i1 %t668, 0
  %t670 = load %NativeInterfaceSignature, %NativeInterfaceSignature* %l23
  %t671 = insertvalue %InterfaceSignatureParse %t669, %NativeInterfaceSignature %t670, 1
  %t672 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t673 = insertvalue %InterfaceSignatureParse %t671, { i8**, i64 }* %t672, 2
  ret %InterfaceSignatureParse %t673
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
  %t12 = call i8* @trim_text__native_ir(i8* %text)
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
  %t52 = add i64 0, 2
  %t53 = call i8* @malloc(i64 %t52)
  store i8 60, i8* %t53
  %t54 = getelementptr i8, i8* %t53, i64 1
  store i8 0, i8* %t54
  call void @sailfin_runtime_mark_persistent(i8* %t53)
  %t55 = call double @index_of(i8* %t51, i8* %t53)
  store double %t55, double* %l5
  %t56 = load double, double* %l5
  %t57 = sitofp i64 0 to double
  %t58 = fcmp oge double %t56, %t57
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load i8*, i8** %l1
  %t61 = load i8*, i8** %l2
  %t62 = load i8*, i8** %l3
  %t63 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t64 = load double, double* %l5
  br i1 %t58, label %then2, label %else3
then2:
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l5
  %t67 = call double @find_matching_angle(i8* %t65, double %t66)
  store double %t67, double* %l6
  %t68 = load double, double* %l6
  %t69 = sitofp i64 0 to double
  %t70 = fcmp olt double %t68, %t69
  %t71 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t72 = load i8*, i8** %l1
  %t73 = load i8*, i8** %l2
  %t74 = load i8*, i8** %l3
  %t75 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t76 = load double, double* %l5
  %t77 = load double, double* %l6
  br i1 %t70, label %then5, label %merge6
then5:
  %t78 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s79 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h487238491, i32 0, i32 0
  %t80 = call i8* @sailfin_runtime_string_concat(i8* %s79, i8* %text)
  %s81 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1187531435, i32 0, i32 0
  %t82 = call i8* @sailfin_runtime_string_concat(i8* %t80, i8* %s81)
  %t83 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t78, i8* %t82)
  store { i8**, i64 }* %t83, { i8**, i64 }** %l0
  %t84 = load i8*, i8** %l1
  %t85 = call i8* @strip_generics(i8* %t84)
  store i8* %t85, i8** %l2
  %t86 = load i8*, i8** %l2
  %t87 = insertvalue %HeaderNameParse undef, i8* %t86, 0
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t89 = insertvalue %HeaderNameParse %t87, { i8**, i64 }* %t88, 1
  %t90 = load i8*, i8** %l3
  %t91 = insertvalue %HeaderNameParse %t89, i8* %t90, 2
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t93 = insertvalue %HeaderNameParse %t91, { i8**, i64 }* %t92, 3
  ret %HeaderNameParse %t93
merge6:
  %t94 = load i8*, i8** %l1
  %t95 = load double, double* %l5
  %t96 = call double @llvm.round.f64(double %t95)
  %t97 = fptosi double %t96 to i64
  %t98 = call i8* @sailfin_runtime_substring(i8* %t94, i64 0, i64 %t97)
  %t99 = call i8* @trim_text__native_ir(i8* %t98)
  store i8* %t99, i8** %l2
  %t100 = load i8*, i8** %l1
  %t101 = load double, double* %l5
  %t102 = sitofp i64 1 to double
  %t103 = fadd double %t101, %t102
  %t104 = load double, double* %l6
  %t105 = call double @llvm.round.f64(double %t103)
  %t106 = fptosi double %t105 to i64
  %t107 = call double @llvm.round.f64(double %t104)
  %t108 = fptosi double %t107 to i64
  %t109 = call i8* @sailfin_runtime_substring(i8* %t100, i64 %t106, i64 %t108)
  store i8* %t109, i8** %l7
  %t110 = load i8*, i8** %l7
  %t111 = call { i8**, i64 }* @parse_type_parameter_entries(i8* %t110)
  store { i8**, i64 }* %t111, { i8**, i64 }** %l4
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l6
  %t114 = sitofp i64 1 to double
  %t115 = fadd double %t113, %t114
  %t116 = load i8*, i8** %l1
  %t117 = call i64 @sailfin_runtime_string_length(i8* %t116)
  %t118 = call double @llvm.round.f64(double %t115)
  %t119 = fptosi double %t118 to i64
  %t120 = call i8* @sailfin_runtime_substring(i8* %t112, i64 %t119, i64 %t117)
  %t121 = call i8* @trim_text__native_ir(i8* %t120)
  store i8* %t121, i8** %l3
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load i8*, i8** %l2
  %t124 = load i8*, i8** %l2
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t126 = load i8*, i8** %l3
  br label %merge4
else3:
  %t127 = load i8*, i8** %l1
  %t128 = add i64 0, 2
  %t129 = call i8* @malloc(i64 %t128)
  store i8 32, i8* %t129
  %t130 = getelementptr i8, i8* %t129, i64 1
  store i8 0, i8* %t130
  call void @sailfin_runtime_mark_persistent(i8* %t129)
  %t131 = call double @index_of(i8* %t127, i8* %t129)
  store double %t131, double* %l8
  %t132 = load double, double* %l8
  %t133 = sitofp i64 0 to double
  %t134 = fcmp oge double %t132, %t133
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t136 = load i8*, i8** %l1
  %t137 = load i8*, i8** %l2
  %t138 = load i8*, i8** %l3
  %t139 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t140 = load double, double* %l5
  %t141 = load double, double* %l8
  br i1 %t134, label %then7, label %merge8
then7:
  %t142 = load i8*, i8** %l1
  %t143 = load double, double* %l8
  %t144 = call double @llvm.round.f64(double %t143)
  %t145 = fptosi double %t144 to i64
  %t146 = call i8* @sailfin_runtime_substring(i8* %t142, i64 0, i64 %t145)
  %t147 = call i8* @trim_text__native_ir(i8* %t146)
  store i8* %t147, i8** %l2
  %t148 = load i8*, i8** %l1
  %t149 = load double, double* %l8
  %t150 = sitofp i64 1 to double
  %t151 = fadd double %t149, %t150
  %t152 = load i8*, i8** %l1
  %t153 = call i64 @sailfin_runtime_string_length(i8* %t152)
  %t154 = call double @llvm.round.f64(double %t151)
  %t155 = fptosi double %t154 to i64
  %t156 = call i8* @sailfin_runtime_substring(i8* %t148, i64 %t155, i64 %t153)
  %t157 = call i8* @trim_text__native_ir(i8* %t156)
  store i8* %t157, i8** %l3
  %t158 = load i8*, i8** %l2
  %t159 = load i8*, i8** %l3
  br label %merge8
merge8:
  %t160 = phi i8* [ %t158, %then7 ], [ %t137, %else3 ]
  %t161 = phi i8* [ %t159, %then7 ], [ %t138, %else3 ]
  store i8* %t160, i8** %l2
  store i8* %t161, i8** %l3
  %t162 = load i8*, i8** %l2
  %t163 = load i8*, i8** %l3
  br label %merge4
merge4:
  %t164 = phi { i8**, i64 }* [ %t122, %merge6 ], [ %t59, %merge8 ]
  %t165 = phi i8* [ %t123, %merge6 ], [ %t162, %merge8 ]
  %t166 = phi { i8**, i64 }* [ %t125, %merge6 ], [ %t63, %merge8 ]
  %t167 = phi i8* [ %t126, %merge6 ], [ %t163, %merge8 ]
  store { i8**, i64 }* %t164, { i8**, i64 }** %l0
  store i8* %t165, i8** %l2
  store { i8**, i64 }* %t166, { i8**, i64 }** %l4
  store i8* %t167, i8** %l3
  %t168 = load i8*, i8** %l2
  %t169 = call i8* @strip_generics(i8* %t168)
  store i8* %t169, i8** %l2
  %t170 = load i8*, i8** %l2
  %t171 = insertvalue %HeaderNameParse undef, i8* %t170, 0
  %t172 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t173 = insertvalue %HeaderNameParse %t171, { i8**, i64 }* %t172, 1
  %t174 = load i8*, i8** %l3
  %t175 = insertvalue %HeaderNameParse %t173, i8* %t174, 2
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t177 = insertvalue %HeaderNameParse %t175, { i8**, i64 }* %t176, 3
  ret %HeaderNameParse %t177
}

define { i8**, i64 }* @parse_type_parameter_entries(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t479 = phi i8* [ %t20, %block.entry ], [ %t471, %loop.latch2 ]
  %t480 = phi double [ %t21, %block.entry ], [ %t472, %loop.latch2 ]
  %t481 = phi i8* [ %t22, %block.entry ], [ %t473, %loop.latch2 ]
  %t482 = phi double [ %t23, %block.entry ], [ %t474, %loop.latch2 ]
  %t483 = phi double [ %t24, %block.entry ], [ %t475, %loop.latch2 ]
  %t484 = phi double [ %t25, %block.entry ], [ %t476, %loop.latch2 ]
  %t485 = phi double [ %t26, %block.entry ], [ %t477, %loop.latch2 ]
  %t486 = phi { i8**, i64 }* [ %t19, %block.entry ], [ %t478, %loop.latch2 ]
  store i8* %t479, i8** %l1
  store double %t480, double* %l2
  store i8* %t481, i8** %l3
  store double %t482, double* %l4
  store double %t483, double* %l5
  store double %t484, double* %l6
  store double %t485, double* %l7
  store { i8**, i64 }* %t486, { i8**, i64 }** %l0
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
  %t58 = add i64 0, 2
  %t59 = call i8* @malloc(i64 %t58)
  store i8 %t57, i8* %t59
  %t60 = getelementptr i8, i8* %t59, i64 1
  store i8 0, i8* %t60
  call void @sailfin_runtime_mark_persistent(i8* %t59)
  %t61 = call i8* @sailfin_runtime_string_concat(i8* %t56, i8* %t59)
  store i8* %t61, i8** %l1
  %t62 = load i8, i8* %l8
  %t63 = icmp eq i8 %t62, 92
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = load i8*, i8** %l3
  %t68 = load double, double* %l4
  %t69 = load double, double* %l5
  %t70 = load double, double* %l6
  %t71 = load double, double* %l7
  %t72 = load i8, i8* %l8
  br i1 %t63, label %then8, label %merge9
then8:
  %t73 = load double, double* %l2
  %t74 = sitofp i64 1 to double
  %t75 = fadd double %t73, %t74
  %t76 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t77 = sitofp i64 %t76 to double
  %t78 = fcmp olt double %t75, %t77
  %t79 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t80 = load i8*, i8** %l1
  %t81 = load double, double* %l2
  %t82 = load i8*, i8** %l3
  %t83 = load double, double* %l4
  %t84 = load double, double* %l5
  %t85 = load double, double* %l6
  %t86 = load double, double* %l7
  %t87 = load i8, i8* %l8
  br i1 %t78, label %then10, label %merge11
then10:
  %t88 = load i8*, i8** %l1
  %t89 = load double, double* %l2
  %t90 = sitofp i64 1 to double
  %t91 = fadd double %t89, %t90
  %t92 = call double @llvm.round.f64(double %t91)
  %t93 = fptosi double %t92 to i64
  %t94 = getelementptr i8, i8* %text, i64 %t93
  %t95 = load i8, i8* %t94
  %t96 = add i64 0, 2
  %t97 = call i8* @malloc(i64 %t96)
  store i8 %t95, i8* %t97
  %t98 = getelementptr i8, i8* %t97, i64 1
  store i8 0, i8* %t98
  call void @sailfin_runtime_mark_persistent(i8* %t97)
  %t99 = call i8* @sailfin_runtime_string_concat(i8* %t88, i8* %t97)
  store i8* %t99, i8** %l1
  %t100 = load double, double* %l2
  %t101 = sitofp i64 2 to double
  %t102 = fadd double %t100, %t101
  store double %t102, double* %l2
  br label %loop.latch2
merge11:
  %t103 = load i8*, i8** %l1
  %t104 = load double, double* %l2
  br label %merge9
merge9:
  %t105 = phi i8* [ %t103, %merge11 ], [ %t65, %then6 ]
  %t106 = phi double [ %t104, %merge11 ], [ %t66, %then6 ]
  store i8* %t105, i8** %l1
  store double %t106, double* %l2
  %t107 = load i8, i8* %l8
  %t108 = load i8*, i8** %l3
  %t109 = load i8, i8* %t108
  %t110 = icmp eq i8 %t107, %t109
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  %t114 = load i8*, i8** %l3
  %t115 = load double, double* %l4
  %t116 = load double, double* %l5
  %t117 = load double, double* %l6
  %t118 = load double, double* %l7
  %t119 = load i8, i8* %l8
  br i1 %t110, label %then12, label %merge13
then12:
  %s120 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s120, i8** %l3
  %t121 = load i8*, i8** %l3
  br label %merge13
merge13:
  %t122 = phi i8* [ %t121, %then12 ], [ %t114, %merge9 ]
  store i8* %t122, i8** %l3
  %t123 = load double, double* %l2
  %t124 = sitofp i64 1 to double
  %t125 = fadd double %t123, %t124
  store double %t125, double* %l2
  br label %loop.latch2
merge7:
  %t127 = load i8, i8* %l8
  %t128 = icmp eq i8 %t127, 34
  br label %logical_or_entry_126

logical_or_entry_126:
  br i1 %t128, label %logical_or_merge_126, label %logical_or_right_126

logical_or_right_126:
  %t129 = load i8, i8* %l8
  %t130 = icmp eq i8 %t129, 39
  br label %logical_or_right_end_126

logical_or_right_end_126:
  br label %logical_or_merge_126

logical_or_merge_126:
  %t131 = phi i1 [ true, %logical_or_entry_126 ], [ %t130, %logical_or_right_end_126 ]
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load i8*, i8** %l1
  %t134 = load double, double* %l2
  %t135 = load i8*, i8** %l3
  %t136 = load double, double* %l4
  %t137 = load double, double* %l5
  %t138 = load double, double* %l6
  %t139 = load double, double* %l7
  %t140 = load i8, i8* %l8
  br i1 %t131, label %then14, label %merge15
then14:
  %t141 = load i8, i8* %l8
  %t142 = add i64 0, 2
  %t143 = call i8* @malloc(i64 %t142)
  store i8 %t141, i8* %t143
  %t144 = getelementptr i8, i8* %t143, i64 1
  store i8 0, i8* %t144
  call void @sailfin_runtime_mark_persistent(i8* %t143)
  store i8* %t143, i8** %l3
  %t145 = load i8*, i8** %l1
  %t146 = load i8, i8* %l8
  %t147 = add i64 0, 2
  %t148 = call i8* @malloc(i64 %t147)
  store i8 %t146, i8* %t148
  %t149 = getelementptr i8, i8* %t148, i64 1
  store i8 0, i8* %t149
  call void @sailfin_runtime_mark_persistent(i8* %t148)
  %t150 = call i8* @sailfin_runtime_string_concat(i8* %t145, i8* %t148)
  store i8* %t150, i8** %l1
  %t151 = load double, double* %l2
  %t152 = sitofp i64 1 to double
  %t153 = fadd double %t151, %t152
  store double %t153, double* %l2
  br label %loop.latch2
merge15:
  %t154 = load i8, i8* %l8
  %t155 = icmp eq i8 %t154, 60
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t157 = load i8*, i8** %l1
  %t158 = load double, double* %l2
  %t159 = load i8*, i8** %l3
  %t160 = load double, double* %l4
  %t161 = load double, double* %l5
  %t162 = load double, double* %l6
  %t163 = load double, double* %l7
  %t164 = load i8, i8* %l8
  br i1 %t155, label %then16, label %merge17
then16:
  %t165 = load double, double* %l4
  %t166 = sitofp i64 1 to double
  %t167 = fadd double %t165, %t166
  store double %t167, double* %l4
  %t168 = load i8*, i8** %l1
  %t169 = load i8, i8* %l8
  %t170 = add i64 0, 2
  %t171 = call i8* @malloc(i64 %t170)
  store i8 %t169, i8* %t171
  %t172 = getelementptr i8, i8* %t171, i64 1
  store i8 0, i8* %t172
  call void @sailfin_runtime_mark_persistent(i8* %t171)
  %t173 = call i8* @sailfin_runtime_string_concat(i8* %t168, i8* %t171)
  store i8* %t173, i8** %l1
  %t174 = load double, double* %l2
  %t175 = sitofp i64 1 to double
  %t176 = fadd double %t174, %t175
  store double %t176, double* %l2
  br label %loop.latch2
merge17:
  %t177 = load i8, i8* %l8
  %t178 = icmp eq i8 %t177, 62
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load i8*, i8** %l1
  %t181 = load double, double* %l2
  %t182 = load i8*, i8** %l3
  %t183 = load double, double* %l4
  %t184 = load double, double* %l5
  %t185 = load double, double* %l6
  %t186 = load double, double* %l7
  %t187 = load i8, i8* %l8
  br i1 %t178, label %then18, label %merge19
then18:
  %t188 = load double, double* %l4
  %t189 = sitofp i64 0 to double
  %t190 = fcmp ogt double %t188, %t189
  %t191 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t192 = load i8*, i8** %l1
  %t193 = load double, double* %l2
  %t194 = load i8*, i8** %l3
  %t195 = load double, double* %l4
  %t196 = load double, double* %l5
  %t197 = load double, double* %l6
  %t198 = load double, double* %l7
  %t199 = load i8, i8* %l8
  br i1 %t190, label %then20, label %merge21
then20:
  %t200 = load double, double* %l4
  %t201 = sitofp i64 1 to double
  %t202 = fsub double %t200, %t201
  store double %t202, double* %l4
  %t203 = load double, double* %l4
  br label %merge21
merge21:
  %t204 = phi double [ %t203, %then20 ], [ %t195, %then18 ]
  store double %t204, double* %l4
  %t205 = load i8*, i8** %l1
  %t206 = load i8, i8* %l8
  %t207 = add i64 0, 2
  %t208 = call i8* @malloc(i64 %t207)
  store i8 %t206, i8* %t208
  %t209 = getelementptr i8, i8* %t208, i64 1
  store i8 0, i8* %t209
  call void @sailfin_runtime_mark_persistent(i8* %t208)
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t205, i8* %t208)
  store i8* %t210, i8** %l1
  %t211 = load double, double* %l2
  %t212 = sitofp i64 1 to double
  %t213 = fadd double %t211, %t212
  store double %t213, double* %l2
  br label %loop.latch2
merge19:
  %t214 = load i8, i8* %l8
  %t215 = icmp eq i8 %t214, 40
  %t216 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t217 = load i8*, i8** %l1
  %t218 = load double, double* %l2
  %t219 = load i8*, i8** %l3
  %t220 = load double, double* %l4
  %t221 = load double, double* %l5
  %t222 = load double, double* %l6
  %t223 = load double, double* %l7
  %t224 = load i8, i8* %l8
  br i1 %t215, label %then22, label %merge23
then22:
  %t225 = load double, double* %l5
  %t226 = sitofp i64 1 to double
  %t227 = fadd double %t225, %t226
  store double %t227, double* %l5
  %t228 = load i8*, i8** %l1
  %t229 = load i8, i8* %l8
  %t230 = add i64 0, 2
  %t231 = call i8* @malloc(i64 %t230)
  store i8 %t229, i8* %t231
  %t232 = getelementptr i8, i8* %t231, i64 1
  store i8 0, i8* %t232
  call void @sailfin_runtime_mark_persistent(i8* %t231)
  %t233 = call i8* @sailfin_runtime_string_concat(i8* %t228, i8* %t231)
  store i8* %t233, i8** %l1
  %t234 = load double, double* %l2
  %t235 = sitofp i64 1 to double
  %t236 = fadd double %t234, %t235
  store double %t236, double* %l2
  br label %loop.latch2
merge23:
  %t237 = load i8, i8* %l8
  %t238 = icmp eq i8 %t237, 41
  %t239 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t240 = load i8*, i8** %l1
  %t241 = load double, double* %l2
  %t242 = load i8*, i8** %l3
  %t243 = load double, double* %l4
  %t244 = load double, double* %l5
  %t245 = load double, double* %l6
  %t246 = load double, double* %l7
  %t247 = load i8, i8* %l8
  br i1 %t238, label %then24, label %merge25
then24:
  %t248 = load double, double* %l5
  %t249 = sitofp i64 0 to double
  %t250 = fcmp ogt double %t248, %t249
  %t251 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t252 = load i8*, i8** %l1
  %t253 = load double, double* %l2
  %t254 = load i8*, i8** %l3
  %t255 = load double, double* %l4
  %t256 = load double, double* %l5
  %t257 = load double, double* %l6
  %t258 = load double, double* %l7
  %t259 = load i8, i8* %l8
  br i1 %t250, label %then26, label %merge27
then26:
  %t260 = load double, double* %l5
  %t261 = sitofp i64 1 to double
  %t262 = fsub double %t260, %t261
  store double %t262, double* %l5
  %t263 = load double, double* %l5
  br label %merge27
merge27:
  %t264 = phi double [ %t263, %then26 ], [ %t256, %then24 ]
  store double %t264, double* %l5
  %t265 = load i8*, i8** %l1
  %t266 = load i8, i8* %l8
  %t267 = add i64 0, 2
  %t268 = call i8* @malloc(i64 %t267)
  store i8 %t266, i8* %t268
  %t269 = getelementptr i8, i8* %t268, i64 1
  store i8 0, i8* %t269
  call void @sailfin_runtime_mark_persistent(i8* %t268)
  %t270 = call i8* @sailfin_runtime_string_concat(i8* %t265, i8* %t268)
  store i8* %t270, i8** %l1
  %t271 = load double, double* %l2
  %t272 = sitofp i64 1 to double
  %t273 = fadd double %t271, %t272
  store double %t273, double* %l2
  br label %loop.latch2
merge25:
  %t274 = load i8, i8* %l8
  %t275 = icmp eq i8 %t274, 91
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t277 = load i8*, i8** %l1
  %t278 = load double, double* %l2
  %t279 = load i8*, i8** %l3
  %t280 = load double, double* %l4
  %t281 = load double, double* %l5
  %t282 = load double, double* %l6
  %t283 = load double, double* %l7
  %t284 = load i8, i8* %l8
  br i1 %t275, label %then28, label %merge29
then28:
  %t285 = load double, double* %l6
  %t286 = sitofp i64 1 to double
  %t287 = fadd double %t285, %t286
  store double %t287, double* %l6
  %t288 = load i8*, i8** %l1
  %t289 = load i8, i8* %l8
  %t290 = add i64 0, 2
  %t291 = call i8* @malloc(i64 %t290)
  store i8 %t289, i8* %t291
  %t292 = getelementptr i8, i8* %t291, i64 1
  store i8 0, i8* %t292
  call void @sailfin_runtime_mark_persistent(i8* %t291)
  %t293 = call i8* @sailfin_runtime_string_concat(i8* %t288, i8* %t291)
  store i8* %t293, i8** %l1
  %t294 = load double, double* %l2
  %t295 = sitofp i64 1 to double
  %t296 = fadd double %t294, %t295
  store double %t296, double* %l2
  br label %loop.latch2
merge29:
  %t297 = load i8, i8* %l8
  %t298 = icmp eq i8 %t297, 93
  %t299 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t300 = load i8*, i8** %l1
  %t301 = load double, double* %l2
  %t302 = load i8*, i8** %l3
  %t303 = load double, double* %l4
  %t304 = load double, double* %l5
  %t305 = load double, double* %l6
  %t306 = load double, double* %l7
  %t307 = load i8, i8* %l8
  br i1 %t298, label %then30, label %merge31
then30:
  %t308 = load double, double* %l6
  %t309 = sitofp i64 0 to double
  %t310 = fcmp ogt double %t308, %t309
  %t311 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t312 = load i8*, i8** %l1
  %t313 = load double, double* %l2
  %t314 = load i8*, i8** %l3
  %t315 = load double, double* %l4
  %t316 = load double, double* %l5
  %t317 = load double, double* %l6
  %t318 = load double, double* %l7
  %t319 = load i8, i8* %l8
  br i1 %t310, label %then32, label %merge33
then32:
  %t320 = load double, double* %l6
  %t321 = sitofp i64 1 to double
  %t322 = fsub double %t320, %t321
  store double %t322, double* %l6
  %t323 = load double, double* %l6
  br label %merge33
merge33:
  %t324 = phi double [ %t323, %then32 ], [ %t317, %then30 ]
  store double %t324, double* %l6
  %t325 = load i8*, i8** %l1
  %t326 = load i8, i8* %l8
  %t327 = add i64 0, 2
  %t328 = call i8* @malloc(i64 %t327)
  store i8 %t326, i8* %t328
  %t329 = getelementptr i8, i8* %t328, i64 1
  store i8 0, i8* %t329
  call void @sailfin_runtime_mark_persistent(i8* %t328)
  %t330 = call i8* @sailfin_runtime_string_concat(i8* %t325, i8* %t328)
  store i8* %t330, i8** %l1
  %t331 = load double, double* %l2
  %t332 = sitofp i64 1 to double
  %t333 = fadd double %t331, %t332
  store double %t333, double* %l2
  br label %loop.latch2
merge31:
  %t334 = load i8, i8* %l8
  %t335 = icmp eq i8 %t334, 123
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t337 = load i8*, i8** %l1
  %t338 = load double, double* %l2
  %t339 = load i8*, i8** %l3
  %t340 = load double, double* %l4
  %t341 = load double, double* %l5
  %t342 = load double, double* %l6
  %t343 = load double, double* %l7
  %t344 = load i8, i8* %l8
  br i1 %t335, label %then34, label %merge35
then34:
  %t345 = load double, double* %l7
  %t346 = sitofp i64 1 to double
  %t347 = fadd double %t345, %t346
  store double %t347, double* %l7
  %t348 = load i8*, i8** %l1
  %t349 = load i8, i8* %l8
  %t350 = add i64 0, 2
  %t351 = call i8* @malloc(i64 %t350)
  store i8 %t349, i8* %t351
  %t352 = getelementptr i8, i8* %t351, i64 1
  store i8 0, i8* %t352
  call void @sailfin_runtime_mark_persistent(i8* %t351)
  %t353 = call i8* @sailfin_runtime_string_concat(i8* %t348, i8* %t351)
  store i8* %t353, i8** %l1
  %t354 = load double, double* %l2
  %t355 = sitofp i64 1 to double
  %t356 = fadd double %t354, %t355
  store double %t356, double* %l2
  br label %loop.latch2
merge35:
  %t357 = load i8, i8* %l8
  %t358 = icmp eq i8 %t357, 125
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t360 = load i8*, i8** %l1
  %t361 = load double, double* %l2
  %t362 = load i8*, i8** %l3
  %t363 = load double, double* %l4
  %t364 = load double, double* %l5
  %t365 = load double, double* %l6
  %t366 = load double, double* %l7
  %t367 = load i8, i8* %l8
  br i1 %t358, label %then36, label %merge37
then36:
  %t368 = load double, double* %l7
  %t369 = sitofp i64 0 to double
  %t370 = fcmp ogt double %t368, %t369
  %t371 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t372 = load i8*, i8** %l1
  %t373 = load double, double* %l2
  %t374 = load i8*, i8** %l3
  %t375 = load double, double* %l4
  %t376 = load double, double* %l5
  %t377 = load double, double* %l6
  %t378 = load double, double* %l7
  %t379 = load i8, i8* %l8
  br i1 %t370, label %then38, label %merge39
then38:
  %t380 = load double, double* %l7
  %t381 = sitofp i64 1 to double
  %t382 = fsub double %t380, %t381
  store double %t382, double* %l7
  %t383 = load double, double* %l7
  br label %merge39
merge39:
  %t384 = phi double [ %t383, %then38 ], [ %t378, %then36 ]
  store double %t384, double* %l7
  %t385 = load i8*, i8** %l1
  %t386 = load i8, i8* %l8
  %t387 = add i64 0, 2
  %t388 = call i8* @malloc(i64 %t387)
  store i8 %t386, i8* %t388
  %t389 = getelementptr i8, i8* %t388, i64 1
  store i8 0, i8* %t389
  call void @sailfin_runtime_mark_persistent(i8* %t388)
  %t390 = call i8* @sailfin_runtime_string_concat(i8* %t385, i8* %t388)
  store i8* %t390, i8** %l1
  %t391 = load double, double* %l2
  %t392 = sitofp i64 1 to double
  %t393 = fadd double %t391, %t392
  store double %t393, double* %l2
  br label %loop.latch2
merge37:
  %t394 = load i8, i8* %l8
  %t395 = icmp eq i8 %t394, 44
  %t396 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t397 = load i8*, i8** %l1
  %t398 = load double, double* %l2
  %t399 = load i8*, i8** %l3
  %t400 = load double, double* %l4
  %t401 = load double, double* %l5
  %t402 = load double, double* %l6
  %t403 = load double, double* %l7
  %t404 = load i8, i8* %l8
  br i1 %t395, label %then40, label %merge41
then40:
  %t406 = load double, double* %l4
  %t407 = sitofp i64 0 to double
  %t408 = fcmp oeq double %t406, %t407
  br label %logical_and_entry_405

logical_and_entry_405:
  br i1 %t408, label %logical_and_right_405, label %logical_and_merge_405

logical_and_right_405:
  %t410 = load double, double* %l5
  %t411 = sitofp i64 0 to double
  %t412 = fcmp oeq double %t410, %t411
  br label %logical_and_entry_409

logical_and_entry_409:
  br i1 %t412, label %logical_and_right_409, label %logical_and_merge_409

logical_and_right_409:
  %t414 = load double, double* %l6
  %t415 = sitofp i64 0 to double
  %t416 = fcmp oeq double %t414, %t415
  br label %logical_and_entry_413

logical_and_entry_413:
  br i1 %t416, label %logical_and_right_413, label %logical_and_merge_413

logical_and_right_413:
  %t417 = load double, double* %l7
  %t418 = sitofp i64 0 to double
  %t419 = fcmp oeq double %t417, %t418
  br label %logical_and_right_end_413

logical_and_right_end_413:
  br label %logical_and_merge_413

logical_and_merge_413:
  %t420 = phi i1 [ false, %logical_and_entry_413 ], [ %t419, %logical_and_right_end_413 ]
  br label %logical_and_right_end_409

logical_and_right_end_409:
  br label %logical_and_merge_409

logical_and_merge_409:
  %t421 = phi i1 [ false, %logical_and_entry_409 ], [ %t420, %logical_and_right_end_409 ]
  br label %logical_and_right_end_405

logical_and_right_end_405:
  br label %logical_and_merge_405

logical_and_merge_405:
  %t422 = phi i1 [ false, %logical_and_entry_405 ], [ %t421, %logical_and_right_end_405 ]
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t424 = load i8*, i8** %l1
  %t425 = load double, double* %l2
  %t426 = load i8*, i8** %l3
  %t427 = load double, double* %l4
  %t428 = load double, double* %l5
  %t429 = load double, double* %l6
  %t430 = load double, double* %l7
  %t431 = load i8, i8* %l8
  br i1 %t422, label %then42, label %merge43
then42:
  %t432 = load i8*, i8** %l1
  %t433 = call i8* @trim_text__native_ir(i8* %t432)
  store i8* %t433, i8** %l9
  %t434 = load i8*, i8** %l9
  %t435 = call i64 @sailfin_runtime_string_length(i8* %t434)
  %t436 = icmp sgt i64 %t435, 0
  %t437 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t438 = load i8*, i8** %l1
  %t439 = load double, double* %l2
  %t440 = load i8*, i8** %l3
  %t441 = load double, double* %l4
  %t442 = load double, double* %l5
  %t443 = load double, double* %l6
  %t444 = load double, double* %l7
  %t445 = load i8, i8* %l8
  %t446 = load i8*, i8** %l9
  br i1 %t436, label %then44, label %merge45
then44:
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t448 = load i8*, i8** %l9
  %t449 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t447, i8* %t448)
  store { i8**, i64 }* %t449, { i8**, i64 }** %l0
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge45
merge45:
  %t451 = phi { i8**, i64 }* [ %t450, %then44 ], [ %t437, %then42 ]
  store { i8**, i64 }* %t451, { i8**, i64 }** %l0
  %s452 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s452, i8** %l1
  %t453 = load double, double* %l2
  %t454 = sitofp i64 1 to double
  %t455 = fadd double %t453, %t454
  store double %t455, double* %l2
  br label %loop.latch2
merge43:
  %t456 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t457 = load i8*, i8** %l1
  %t458 = load double, double* %l2
  br label %merge41
merge41:
  %t459 = phi { i8**, i64 }* [ %t456, %merge43 ], [ %t396, %merge37 ]
  %t460 = phi i8* [ %t457, %merge43 ], [ %t397, %merge37 ]
  %t461 = phi double [ %t458, %merge43 ], [ %t398, %merge37 ]
  store { i8**, i64 }* %t459, { i8**, i64 }** %l0
  store i8* %t460, i8** %l1
  store double %t461, double* %l2
  %t462 = load i8*, i8** %l1
  %t463 = load i8, i8* %l8
  %t464 = add i64 0, 2
  %t465 = call i8* @malloc(i64 %t464)
  store i8 %t463, i8* %t465
  %t466 = getelementptr i8, i8* %t465, i64 1
  store i8 0, i8* %t466
  call void @sailfin_runtime_mark_persistent(i8* %t465)
  %t467 = call i8* @sailfin_runtime_string_concat(i8* %t462, i8* %t465)
  store i8* %t467, i8** %l1
  %t468 = load double, double* %l2
  %t469 = sitofp i64 1 to double
  %t470 = fadd double %t468, %t469
  store double %t470, double* %l2
  br label %loop.latch2
loop.latch2:
  %t471 = load i8*, i8** %l1
  %t472 = load double, double* %l2
  %t473 = load i8*, i8** %l3
  %t474 = load double, double* %l4
  %t475 = load double, double* %l5
  %t476 = load double, double* %l6
  %t477 = load double, double* %l7
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t487 = load i8*, i8** %l1
  %t488 = load double, double* %l2
  %t489 = load i8*, i8** %l3
  %t490 = load double, double* %l4
  %t491 = load double, double* %l5
  %t492 = load double, double* %l6
  %t493 = load double, double* %l7
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t495 = load i8*, i8** %l1
  %t496 = call i8* @trim_text__native_ir(i8* %t495)
  store i8* %t496, i8** %l10
  %t497 = load i8*, i8** %l10
  %t498 = call i64 @sailfin_runtime_string_length(i8* %t497)
  %t499 = icmp sgt i64 %t498, 0
  %t500 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t501 = load i8*, i8** %l1
  %t502 = load double, double* %l2
  %t503 = load i8*, i8** %l3
  %t504 = load double, double* %l4
  %t505 = load double, double* %l5
  %t506 = load double, double* %l6
  %t507 = load double, double* %l7
  %t508 = load i8*, i8** %l10
  br i1 %t499, label %then46, label %merge47
then46:
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t510 = load i8*, i8** %l10
  %t511 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t509, i8* %t510)
  store { i8**, i64 }* %t511, { i8**, i64 }** %l0
  %t512 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge47
merge47:
  %t513 = phi { i8**, i64 }* [ %t512, %then46 ], [ %t500, %afterloop3 ]
  store { i8**, i64 }* %t513, { i8**, i64 }** %l0
  %t514 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t514
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
  %t20 = call i8* @trim_text__native_ir(i8* %t19)
  store i8* %t20, i8** %l1
  %t21 = load i8*, i8** %l1
  %s22 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280947313, i32 0, i32 0
  %t23 = call i8* @strip_prefix(i8* %t21, i8* %s22)
  %t24 = call i8* @trim_text__native_ir(i8* %t23)
  store i8* %t24, i8** %l2
  %t25 = load i8*, i8** %l2
  store i8* %t25, i8** %l3
  %t26 = load i8*, i8** %l3
  %t27 = add i64 0, 2
  %t28 = call i8* @malloc(i64 %t27)
  store i8 32, i8* %t28
  %t29 = getelementptr i8, i8* %t28, i64 1
  store i8 0, i8* %t29
  call void @sailfin_runtime_mark_persistent(i8* %t28)
  %t30 = call double @index_of(i8* %t26, i8* %t28)
  store double %t30, double* %l4
  %t31 = load double, double* %l4
  %t32 = sitofp i64 0 to double
  %t33 = fcmp oge double %t31, %t32
  %t34 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t35 = load i8*, i8** %l1
  %t36 = load i8*, i8** %l2
  %t37 = load i8*, i8** %l3
  %t38 = load double, double* %l4
  br i1 %t33, label %then0, label %merge1
then0:
  %t39 = load i8*, i8** %l3
  %t40 = load double, double* %l4
  %t41 = call double @llvm.round.f64(double %t40)
  %t42 = fptosi double %t41 to i64
  %t43 = call i8* @sailfin_runtime_substring(i8* %t39, i64 0, i64 %t42)
  %t44 = call i8* @trim_text__native_ir(i8* %t43)
  store i8* %t44, i8** %l3
  %t45 = load i8*, i8** %l3
  br label %merge1
merge1:
  %t46 = phi i8* [ %t45, %then0 ], [ %t37, %block.entry ]
  store i8* %t46, i8** %l3
  %t47 = load i8*, i8** %l3
  %t48 = call i8* @strip_generics(i8* %t47)
  store i8* %t48, i8** %l3
  %t49 = load i8*, i8** %l3
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = icmp eq i64 %t50, 0
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load i8*, i8** %l2
  %t55 = load i8*, i8** %l3
  %t56 = load double, double* %l4
  br i1 %t51, label %then2, label %merge3
then2:
  %t57 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s58 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h668562564, i32 0, i32 0
  %t59 = load i8*, i8** %l1
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %s58, i8* %t59)
  %t61 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t57, i8* %t60)
  store { i8**, i64 }* %t61, { i8**, i64 }** %l0
  %t62 = bitcast i8* null to %NativeEnum*
  %t63 = insertvalue %EnumParseResult undef, %NativeEnum* %t62, 0
  %t64 = sitofp i64 1 to double
  %t65 = fadd double %start_index, %t64
  %t66 = insertvalue %EnumParseResult %t63, double %t65, 1
  %t67 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t68 = insertvalue %EnumParseResult %t66, { i8**, i64 }* %t67, 2
  ret %EnumParseResult %t68
merge3:
  %t69 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* null, i32 1
  %t70 = ptrtoint [0 x %NativeEnumVariant]* %t69 to i64
  %t71 = icmp eq i64 %t70, 0
  %t72 = select i1 %t71, i64 1, i64 %t70
  %t73 = call i8* @malloc(i64 %t72)
  %t74 = bitcast i8* %t73 to %NativeEnumVariant*
  %t75 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* null, i32 1
  %t76 = ptrtoint { %NativeEnumVariant*, i64 }* %t75 to i64
  %t77 = call i8* @malloc(i64 %t76)
  %t78 = bitcast i8* %t77 to { %NativeEnumVariant*, i64 }*
  %t79 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t78, i32 0, i32 0
  store %NativeEnumVariant* %t74, %NativeEnumVariant** %t79
  %t80 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t78, i32 0, i32 1
  store i64 0, i64* %t80
  store { %NativeEnumVariant*, i64 }* %t78, { %NativeEnumVariant*, i64 }** %l5
  %t81 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t82 = ptrtoint [0 x %NativeEnumVariantLayout]* %t81 to i64
  %t83 = icmp eq i64 %t82, 0
  %t84 = select i1 %t83, i64 1, i64 %t82
  %t85 = call i8* @malloc(i64 %t84)
  %t86 = bitcast i8* %t85 to %NativeEnumVariantLayout*
  %t87 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t88 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t87 to i64
  %t89 = call i8* @malloc(i64 %t88)
  %t90 = bitcast i8* %t89 to { %NativeEnumVariantLayout*, i64 }*
  %t91 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t90, i32 0, i32 0
  store %NativeEnumVariantLayout* %t86, %NativeEnumVariantLayout** %t91
  %t92 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t90, i32 0, i32 1
  store i64 0, i64* %t92
  store { %NativeEnumVariantLayout*, i64 }* %t90, { %NativeEnumVariantLayout*, i64 }** %l6
  %t93 = sitofp i64 0 to double
  store double %t93, double* %l7
  %t94 = sitofp i64 0 to double
  store double %t94, double* %l8
  %s95 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s95, i8** %l9
  %t96 = sitofp i64 0 to double
  store double %t96, double* %l10
  %t97 = sitofp i64 0 to double
  store double %t97, double* %l11
  store i1 0, i1* %l12
  store i1 0, i1* %l13
  %t98 = sitofp i64 1 to double
  %t99 = fadd double %start_index, %t98
  store double %t99, double* %l14
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t101 = load i8*, i8** %l1
  %t102 = load i8*, i8** %l2
  %t103 = load i8*, i8** %l3
  %t104 = load double, double* %l4
  %t105 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t106 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t107 = load double, double* %l7
  %t108 = load double, double* %l8
  %t109 = load i8*, i8** %l9
  %t110 = load double, double* %l10
  %t111 = load double, double* %l11
  %t112 = load i1, i1* %l12
  %t113 = load i1, i1* %l13
  %t114 = load double, double* %l14
  br label %loop.header4
loop.header4:
  %t817 = phi { i8**, i64 }* [ %t100, %merge3 ], [ %t806, %loop.latch6 ]
  %t818 = phi double [ %t114, %merge3 ], [ %t807, %loop.latch6 ]
  %t819 = phi double [ %t107, %merge3 ], [ %t808, %loop.latch6 ]
  %t820 = phi double [ %t108, %merge3 ], [ %t809, %loop.latch6 ]
  %t821 = phi i8* [ %t109, %merge3 ], [ %t810, %loop.latch6 ]
  %t822 = phi double [ %t110, %merge3 ], [ %t811, %loop.latch6 ]
  %t823 = phi double [ %t111, %merge3 ], [ %t812, %loop.latch6 ]
  %t824 = phi i1 [ %t112, %merge3 ], [ %t813, %loop.latch6 ]
  %t825 = phi { %NativeEnumVariantLayout*, i64 }* [ %t106, %merge3 ], [ %t814, %loop.latch6 ]
  %t826 = phi i1 [ %t113, %merge3 ], [ %t815, %loop.latch6 ]
  %t827 = phi { %NativeEnumVariant*, i64 }* [ %t105, %merge3 ], [ %t816, %loop.latch6 ]
  store { i8**, i64 }* %t817, { i8**, i64 }** %l0
  store double %t818, double* %l14
  store double %t819, double* %l7
  store double %t820, double* %l8
  store i8* %t821, i8** %l9
  store double %t822, double* %l10
  store double %t823, double* %l11
  store i1 %t824, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t825, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t826, i1* %l13
  store { %NativeEnumVariant*, i64 }* %t827, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.body5
loop.body5:
  %t115 = load double, double* %l14
  %t116 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t117 = extractvalue { i8**, i64 } %t116, 1
  %t118 = sitofp i64 %t117 to double
  %t119 = fcmp oge double %t115, %t118
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t121 = load i8*, i8** %l1
  %t122 = load i8*, i8** %l2
  %t123 = load i8*, i8** %l3
  %t124 = load double, double* %l4
  %t125 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t126 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t127 = load double, double* %l7
  %t128 = load double, double* %l8
  %t129 = load i8*, i8** %l9
  %t130 = load double, double* %l10
  %t131 = load double, double* %l11
  %t132 = load i1, i1* %l12
  %t133 = load i1, i1* %l13
  %t134 = load double, double* %l14
  br i1 %t119, label %then8, label %merge9
then8:
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s136 = getelementptr inbounds [19 x i8], [19 x i8]* @.str.len18.h1997941781, i32 0, i32 0
  %t137 = load i8*, i8** %l3
  %t138 = call i8* @sailfin_runtime_string_concat(i8* %s136, i8* %t137)
  %t139 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t135, i8* %t138)
  store { i8**, i64 }* %t139, { i8**, i64 }** %l0
  %t140 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t140, %NativeEnumLayout** %l15
  %t141 = load i1, i1* %l12
  %t142 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t143 = load i8*, i8** %l1
  %t144 = load i8*, i8** %l2
  %t145 = load i8*, i8** %l3
  %t146 = load double, double* %l4
  %t147 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t148 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t149 = load double, double* %l7
  %t150 = load double, double* %l8
  %t151 = load i8*, i8** %l9
  %t152 = load double, double* %l10
  %t153 = load double, double* %l11
  %t154 = load i1, i1* %l12
  %t155 = load i1, i1* %l13
  %t156 = load double, double* %l14
  %t157 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br i1 %t141, label %then10, label %merge11
then10:
  %t158 = load double, double* %l7
  %t159 = insertvalue %NativeEnumLayout undef, double %t158, 0
  %t160 = load double, double* %l8
  %t161 = insertvalue %NativeEnumLayout %t159, double %t160, 1
  %t162 = load i8*, i8** %l9
  %t163 = insertvalue %NativeEnumLayout %t161, i8* %t162, 2
  %t164 = load double, double* %l10
  %t165 = insertvalue %NativeEnumLayout %t163, double %t164, 3
  %t166 = load double, double* %l11
  %t167 = insertvalue %NativeEnumLayout %t165, double %t166, 4
  %t168 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t169 = insertvalue %NativeEnumLayout %t167, { %NativeEnumVariantLayout*, i64 }* %t168, 5
  %t170 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t169, %NativeEnumLayout* %t170
  store %NativeEnumLayout* %t170, %NativeEnumLayout** %l15
  %t171 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br label %merge11
merge11:
  %t172 = phi %NativeEnumLayout* [ %t171, %then10 ], [ %t157, %then8 ]
  store %NativeEnumLayout* %t172, %NativeEnumLayout** %l15
  %t173 = load i8*, i8** %l3
  %t174 = insertvalue %NativeEnum undef, i8* %t173, 0
  %t175 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t176 = insertvalue %NativeEnum %t174, { %NativeEnumVariant*, i64 }* %t175, 1
  %t177 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  %t178 = insertvalue %NativeEnum %t176, %NativeEnumLayout* %t177, 2
  %t179 = alloca %NativeEnum
  store %NativeEnum %t178, %NativeEnum* %t179
  %t180 = insertvalue %EnumParseResult undef, %NativeEnum* %t179, 0
  %t181 = load double, double* %l14
  %t182 = insertvalue %EnumParseResult %t180, double %t181, 1
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t184 = insertvalue %EnumParseResult %t182, { i8**, i64 }* %t183, 2
  ret %EnumParseResult %t184
merge9:
  %t185 = load double, double* %l14
  %t186 = call double @llvm.round.f64(double %t185)
  %t187 = fptosi double %t186 to i64
  %t188 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t189 = extractvalue { i8**, i64 } %t188, 0
  %t190 = extractvalue { i8**, i64 } %t188, 1
  %t191 = icmp uge i64 %t187, %t190
  ; bounds check: %t191 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t187, i64 %t190)
  %t192 = getelementptr i8*, i8** %t189, i64 %t187
  %t193 = load i8*, i8** %t192
  %t194 = call i8* @trim_text__native_ir(i8* %t193)
  store i8* %t194, i8** %l16
  %t196 = load i8*, i8** %l16
  %t197 = call i64 @sailfin_runtime_string_length(i8* %t196)
  %t198 = icmp eq i64 %t197, 0
  br label %logical_or_entry_195

logical_or_entry_195:
  br i1 %t198, label %logical_or_merge_195, label %logical_or_right_195

logical_or_right_195:
  %t199 = load i8*, i8** %l16
  %t200 = add i64 0, 2
  %t201 = call i8* @malloc(i64 %t200)
  store i8 59, i8* %t201
  %t202 = getelementptr i8, i8* %t201, i64 1
  store i8 0, i8* %t202
  call void @sailfin_runtime_mark_persistent(i8* %t201)
  %t203 = call i1 @starts_with(i8* %t199, i8* %t201)
  br label %logical_or_right_end_195

logical_or_right_end_195:
  br label %logical_or_merge_195

logical_or_merge_195:
  %t204 = phi i1 [ true, %logical_or_entry_195 ], [ %t203, %logical_or_right_end_195 ]
  %t205 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t206 = load i8*, i8** %l1
  %t207 = load i8*, i8** %l2
  %t208 = load i8*, i8** %l3
  %t209 = load double, double* %l4
  %t210 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t211 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t212 = load double, double* %l7
  %t213 = load double, double* %l8
  %t214 = load i8*, i8** %l9
  %t215 = load double, double* %l10
  %t216 = load double, double* %l11
  %t217 = load i1, i1* %l12
  %t218 = load i1, i1* %l13
  %t219 = load double, double* %l14
  %t220 = load i8*, i8** %l16
  br i1 %t204, label %then12, label %merge13
then12:
  %t221 = load double, double* %l14
  %t222 = sitofp i64 1 to double
  %t223 = fadd double %t221, %t222
  store double %t223, double* %l14
  br label %loop.latch6
merge13:
  %t224 = load i8*, i8** %l16
  %s225 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t226 = call i1 @strings_equal(i8* %t224, i8* %s225)
  %t227 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t228 = load i8*, i8** %l1
  %t229 = load i8*, i8** %l2
  %t230 = load i8*, i8** %l3
  %t231 = load double, double* %l4
  %t232 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t233 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t234 = load double, double* %l7
  %t235 = load double, double* %l8
  %t236 = load i8*, i8** %l9
  %t237 = load double, double* %l10
  %t238 = load double, double* %l11
  %t239 = load i1, i1* %l12
  %t240 = load i1, i1* %l13
  %t241 = load double, double* %l14
  %t242 = load i8*, i8** %l16
  br i1 %t226, label %then14, label %merge15
then14:
  %t243 = load double, double* %l14
  %t244 = sitofp i64 1 to double
  %t245 = fadd double %t243, %t244
  store double %t245, double* %l14
  br label %loop.latch6
merge15:
  %t246 = load i8*, i8** %l16
  %s247 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t248 = call i1 @starts_with(i8* %t246, i8* %s247)
  %t249 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t250 = load i8*, i8** %l1
  %t251 = load i8*, i8** %l2
  %t252 = load i8*, i8** %l3
  %t253 = load double, double* %l4
  %t254 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t255 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t256 = load double, double* %l7
  %t257 = load double, double* %l8
  %t258 = load i8*, i8** %l9
  %t259 = load double, double* %l10
  %t260 = load double, double* %l11
  %t261 = load i1, i1* %l12
  %t262 = load i1, i1* %l13
  %t263 = load double, double* %l14
  %t264 = load i8*, i8** %l16
  br i1 %t248, label %then16, label %merge17
then16:
  %t265 = load i8*, i8** %l16
  %s266 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t267 = call i8* @strip_prefix(i8* %t265, i8* %s266)
  store i8* %t267, i8** %l17
  %t268 = load i8*, i8** %l17
  %s269 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t270 = call i1 @starts_with(i8* %t268, i8* %s269)
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t272 = load i8*, i8** %l1
  %t273 = load i8*, i8** %l2
  %t274 = load i8*, i8** %l3
  %t275 = load double, double* %l4
  %t276 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t277 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t278 = load double, double* %l7
  %t279 = load double, double* %l8
  %t280 = load i8*, i8** %l9
  %t281 = load double, double* %l10
  %t282 = load double, double* %l11
  %t283 = load i1, i1* %l12
  %t284 = load i1, i1* %l13
  %t285 = load double, double* %l14
  %t286 = load i8*, i8** %l16
  %t287 = load i8*, i8** %l17
  br i1 %t270, label %then18, label %merge19
then18:
  %t288 = load i8*, i8** %l17
  %s289 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t290 = call i8* @strip_prefix(i8* %t288, i8* %s289)
  %t291 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t290)
  store %EnumLayoutHeaderParse %t291, %EnumLayoutHeaderParse* %l18
  %t292 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t293 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t294 = extractvalue %EnumLayoutHeaderParse %t293, 7
  %t295 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t292, { i8**, i64 }* %t294)
  store { i8**, i64 }* %t295, { i8**, i64 }** %l0
  %t296 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t297 = extractvalue %EnumLayoutHeaderParse %t296, 0
  %t298 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t299 = load i8*, i8** %l1
  %t300 = load i8*, i8** %l2
  %t301 = load i8*, i8** %l3
  %t302 = load double, double* %l4
  %t303 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t304 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t305 = load double, double* %l7
  %t306 = load double, double* %l8
  %t307 = load i8*, i8** %l9
  %t308 = load double, double* %l10
  %t309 = load double, double* %l11
  %t310 = load i1, i1* %l12
  %t311 = load i1, i1* %l13
  %t312 = load double, double* %l14
  %t313 = load i8*, i8** %l16
  %t314 = load i8*, i8** %l17
  %t315 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t297, label %then20, label %merge21
then20:
  %t316 = load i1, i1* %l12
  %t317 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t318 = load i8*, i8** %l1
  %t319 = load i8*, i8** %l2
  %t320 = load i8*, i8** %l3
  %t321 = load double, double* %l4
  %t322 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t323 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t324 = load double, double* %l7
  %t325 = load double, double* %l8
  %t326 = load i8*, i8** %l9
  %t327 = load double, double* %l10
  %t328 = load double, double* %l11
  %t329 = load i1, i1* %l12
  %t330 = load i1, i1* %l13
  %t331 = load double, double* %l14
  %t332 = load i8*, i8** %l16
  %t333 = load i8*, i8** %l17
  %t334 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t316, label %then22, label %else23
then22:
  %t335 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s336 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1822658020, i32 0, i32 0
  %t337 = load i8*, i8** %l3
  %t338 = call i8* @sailfin_runtime_string_concat(i8* %s336, i8* %t337)
  %t339 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t335, i8* %t338)
  store { i8**, i64 }* %t339, { i8**, i64 }** %l0
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t341 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t342 = extractvalue %EnumLayoutHeaderParse %t341, 2
  store double %t342, double* %l7
  %t343 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t344 = extractvalue %EnumLayoutHeaderParse %t343, 3
  store double %t344, double* %l8
  %t345 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t346 = extractvalue %EnumLayoutHeaderParse %t345, 4
  store i8* %t346, i8** %l9
  %t347 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t348 = extractvalue %EnumLayoutHeaderParse %t347, 5
  store double %t348, double* %l10
  %t349 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t350 = extractvalue %EnumLayoutHeaderParse %t349, 6
  store double %t350, double* %l11
  store i1 1, i1* %l12
  %t351 = load double, double* %l7
  %t352 = load double, double* %l8
  %t353 = load i8*, i8** %l9
  %t354 = load double, double* %l10
  %t355 = load double, double* %l11
  %t356 = load i1, i1* %l12
  br label %merge24
merge24:
  %t357 = phi { i8**, i64 }* [ %t340, %then22 ], [ %t317, %else23 ]
  %t358 = phi double [ %t324, %then22 ], [ %t351, %else23 ]
  %t359 = phi double [ %t325, %then22 ], [ %t352, %else23 ]
  %t360 = phi i8* [ %t326, %then22 ], [ %t353, %else23 ]
  %t361 = phi double [ %t327, %then22 ], [ %t354, %else23 ]
  %t362 = phi double [ %t328, %then22 ], [ %t355, %else23 ]
  %t363 = phi i1 [ %t329, %then22 ], [ %t356, %else23 ]
  store { i8**, i64 }* %t357, { i8**, i64 }** %l0
  store double %t358, double* %l7
  store double %t359, double* %l8
  store i8* %t360, i8** %l9
  store double %t361, double* %l10
  store double %t362, double* %l11
  store i1 %t363, i1* %l12
  %t364 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t365 = load double, double* %l7
  %t366 = load double, double* %l8
  %t367 = load i8*, i8** %l9
  %t368 = load double, double* %l10
  %t369 = load double, double* %l11
  %t370 = load i1, i1* %l12
  br label %merge21
merge21:
  %t371 = phi { i8**, i64 }* [ %t364, %merge24 ], [ %t298, %then18 ]
  %t372 = phi double [ %t365, %merge24 ], [ %t305, %then18 ]
  %t373 = phi double [ %t366, %merge24 ], [ %t306, %then18 ]
  %t374 = phi i8* [ %t367, %merge24 ], [ %t307, %then18 ]
  %t375 = phi double [ %t368, %merge24 ], [ %t308, %then18 ]
  %t376 = phi double [ %t369, %merge24 ], [ %t309, %then18 ]
  %t377 = phi i1 [ %t370, %merge24 ], [ %t310, %then18 ]
  store { i8**, i64 }* %t371, { i8**, i64 }** %l0
  store double %t372, double* %l7
  store double %t373, double* %l8
  store i8* %t374, i8** %l9
  store double %t375, double* %l10
  store double %t376, double* %l11
  store i1 %t377, i1* %l12
  %t378 = load double, double* %l14
  %t379 = sitofp i64 1 to double
  %t380 = fadd double %t378, %t379
  store double %t380, double* %l14
  br label %loop.latch6
merge19:
  %t381 = load i8*, i8** %l17
  %s382 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t383 = call i1 @starts_with(i8* %t381, i8* %s382)
  %t384 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t385 = load i8*, i8** %l1
  %t386 = load i8*, i8** %l2
  %t387 = load i8*, i8** %l3
  %t388 = load double, double* %l4
  %t389 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t390 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t391 = load double, double* %l7
  %t392 = load double, double* %l8
  %t393 = load i8*, i8** %l9
  %t394 = load double, double* %l10
  %t395 = load double, double* %l11
  %t396 = load i1, i1* %l12
  %t397 = load i1, i1* %l13
  %t398 = load double, double* %l14
  %t399 = load i8*, i8** %l16
  %t400 = load i8*, i8** %l17
  br i1 %t383, label %then25, label %merge26
then25:
  %t401 = load i8*, i8** %l17
  %s402 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t403 = call i8* @strip_prefix(i8* %t401, i8* %s402)
  %t404 = load i8*, i8** %l3
  %t405 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t403, i8* %t404)
  store %EnumLayoutVariantParse %t405, %EnumLayoutVariantParse* %l19
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t407 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t408 = extractvalue %EnumLayoutVariantParse %t407, 2
  %t409 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t406, { i8**, i64 }* %t408)
  store { i8**, i64 }* %t409, { i8**, i64 }** %l0
  %t410 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t411 = extractvalue %EnumLayoutVariantParse %t410, 0
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t413 = load i8*, i8** %l1
  %t414 = load i8*, i8** %l2
  %t415 = load i8*, i8** %l3
  %t416 = load double, double* %l4
  %t417 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t418 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t419 = load double, double* %l7
  %t420 = load double, double* %l8
  %t421 = load i8*, i8** %l9
  %t422 = load double, double* %l10
  %t423 = load double, double* %l11
  %t424 = load i1, i1* %l12
  %t425 = load i1, i1* %l13
  %t426 = load double, double* %l14
  %t427 = load i8*, i8** %l16
  %t428 = load i8*, i8** %l17
  %t429 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t411, label %then27, label %merge28
then27:
  %t430 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t431 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t432 = extractvalue %EnumLayoutVariantParse %t431, 1
  %t433 = extractvalue %NativeEnumVariantLayout %t432, 0
  %t434 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t430, i8* %t433)
  store double %t434, double* %l20
  %t435 = load double, double* %l20
  %t436 = sitofp i64 0 to double
  %t437 = fcmp oge double %t435, %t436
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t439 = load i8*, i8** %l1
  %t440 = load i8*, i8** %l2
  %t441 = load i8*, i8** %l3
  %t442 = load double, double* %l4
  %t443 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t444 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t445 = load double, double* %l7
  %t446 = load double, double* %l8
  %t447 = load i8*, i8** %l9
  %t448 = load double, double* %l10
  %t449 = load double, double* %l11
  %t450 = load i1, i1* %l12
  %t451 = load i1, i1* %l13
  %t452 = load double, double* %l14
  %t453 = load i8*, i8** %l16
  %t454 = load i8*, i8** %l17
  %t455 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t456 = load double, double* %l20
  br i1 %t437, label %then29, label %else30
then29:
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s458 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1924917952, i32 0, i32 0
  %t459 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t460 = extractvalue %EnumLayoutVariantParse %t459, 1
  %t461 = extractvalue %NativeEnumVariantLayout %t460, 0
  %t462 = call i8* @sailfin_runtime_string_concat(i8* %s458, i8* %t461)
  %s463 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1783417286, i32 0, i32 0
  %t464 = call i8* @sailfin_runtime_string_concat(i8* %t462, i8* %s463)
  %t465 = load i8*, i8** %l3
  %t466 = call i8* @sailfin_runtime_string_concat(i8* %t464, i8* %t465)
  %t467 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t457, i8* %t466)
  store { i8**, i64 }* %t467, { i8**, i64 }** %l0
  %t468 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
else30:
  %t469 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t470 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t471 = extractvalue %EnumLayoutVariantParse %t470, 1
  %t472 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout__native_ir({ %NativeEnumVariantLayout*, i64 }* %t469, %NativeEnumVariantLayout %t471)
  store { %NativeEnumVariantLayout*, i64 }* %t472, { %NativeEnumVariantLayout*, i64 }** %l6
  %t473 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t474 = phi { i8**, i64 }* [ %t468, %then29 ], [ %t438, %else30 ]
  %t475 = phi { %NativeEnumVariantLayout*, i64 }* [ %t444, %then29 ], [ %t473, %else30 ]
  store { i8**, i64 }* %t474, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t475, { %NativeEnumVariantLayout*, i64 }** %l6
  %t476 = load i1, i1* %l12
  %t477 = xor i1 %t476, 1
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t479 = load i8*, i8** %l1
  %t480 = load i8*, i8** %l2
  %t481 = load i8*, i8** %l3
  %t482 = load double, double* %l4
  %t483 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t484 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t485 = load double, double* %l7
  %t486 = load double, double* %l8
  %t487 = load i8*, i8** %l9
  %t488 = load double, double* %l10
  %t489 = load double, double* %l11
  %t490 = load i1, i1* %l12
  %t491 = load i1, i1* %l13
  %t492 = load double, double* %l14
  %t493 = load i8*, i8** %l16
  %t494 = load i8*, i8** %l17
  %t495 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t496 = load double, double* %l20
  br i1 %t477, label %then32, label %merge33
then32:
  %t497 = load i1, i1* %l13
  %t498 = xor i1 %t497, 1
  %t499 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t500 = load i8*, i8** %l1
  %t501 = load i8*, i8** %l2
  %t502 = load i8*, i8** %l3
  %t503 = load double, double* %l4
  %t504 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t505 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t506 = load double, double* %l7
  %t507 = load double, double* %l8
  %t508 = load i8*, i8** %l9
  %t509 = load double, double* %l10
  %t510 = load double, double* %l11
  %t511 = load i1, i1* %l12
  %t512 = load i1, i1* %l13
  %t513 = load double, double* %l14
  %t514 = load i8*, i8** %l16
  %t515 = load i8*, i8** %l17
  %t516 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t517 = load double, double* %l20
  br i1 %t498, label %then34, label %merge35
then34:
  %t518 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s519 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t520 = load i8*, i8** %l3
  %t521 = call i8* @sailfin_runtime_string_concat(i8* %s519, i8* %t520)
  %s522 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h235936117, i32 0, i32 0
  %t523 = call i8* @sailfin_runtime_string_concat(i8* %t521, i8* %s522)
  %t524 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t518, i8* %t523)
  store { i8**, i64 }* %t524, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t525 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t526 = load i1, i1* %l13
  br label %merge35
merge35:
  %t527 = phi { i8**, i64 }* [ %t525, %then34 ], [ %t499, %then32 ]
  %t528 = phi i1 [ %t526, %then34 ], [ %t512, %then32 ]
  store { i8**, i64 }* %t527, { i8**, i64 }** %l0
  store i1 %t528, i1* %l13
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t530 = load i1, i1* %l13
  br label %merge33
merge33:
  %t531 = phi { i8**, i64 }* [ %t529, %merge35 ], [ %t478, %merge31 ]
  %t532 = phi i1 [ %t530, %merge35 ], [ %t491, %merge31 ]
  store { i8**, i64 }* %t531, { i8**, i64 }** %l0
  store i1 %t532, i1* %l13
  %t533 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t534 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t536 = load i1, i1* %l13
  br label %merge28
merge28:
  %t537 = phi { i8**, i64 }* [ %t533, %merge33 ], [ %t412, %then25 ]
  %t538 = phi { %NativeEnumVariantLayout*, i64 }* [ %t534, %merge33 ], [ %t418, %then25 ]
  %t539 = phi { i8**, i64 }* [ %t535, %merge33 ], [ %t412, %then25 ]
  %t540 = phi i1 [ %t536, %merge33 ], [ %t425, %then25 ]
  store { i8**, i64 }* %t537, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t538, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t539, { i8**, i64 }** %l0
  store i1 %t540, i1* %l13
  %t541 = load double, double* %l14
  %t542 = sitofp i64 1 to double
  %t543 = fadd double %t541, %t542
  store double %t543, double* %l14
  br label %loop.latch6
merge26:
  %t544 = load i8*, i8** %l17
  %s545 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t546 = call i1 @starts_with(i8* %t544, i8* %s545)
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t548 = load i8*, i8** %l1
  %t549 = load i8*, i8** %l2
  %t550 = load i8*, i8** %l3
  %t551 = load double, double* %l4
  %t552 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t553 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t554 = load double, double* %l7
  %t555 = load double, double* %l8
  %t556 = load i8*, i8** %l9
  %t557 = load double, double* %l10
  %t558 = load double, double* %l11
  %t559 = load i1, i1* %l12
  %t560 = load i1, i1* %l13
  %t561 = load double, double* %l14
  %t562 = load i8*, i8** %l16
  %t563 = load i8*, i8** %l17
  br i1 %t546, label %then36, label %merge37
then36:
  %t564 = load i8*, i8** %l17
  %s565 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t566 = call i8* @strip_prefix(i8* %t564, i8* %s565)
  %t567 = load i8*, i8** %l3
  %t568 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t566, i8* %t567)
  store %EnumLayoutPayloadParse %t568, %EnumLayoutPayloadParse* %l21
  %t569 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t570 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t571 = extractvalue %EnumLayoutPayloadParse %t570, 3
  %t572 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t569, { i8**, i64 }* %t571)
  store { i8**, i64 }* %t572, { i8**, i64 }** %l0
  %t573 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t574 = extractvalue %EnumLayoutPayloadParse %t573, 0
  %t575 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t576 = load i8*, i8** %l1
  %t577 = load i8*, i8** %l2
  %t578 = load i8*, i8** %l3
  %t579 = load double, double* %l4
  %t580 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t581 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t582 = load double, double* %l7
  %t583 = load double, double* %l8
  %t584 = load i8*, i8** %l9
  %t585 = load double, double* %l10
  %t586 = load double, double* %l11
  %t587 = load i1, i1* %l12
  %t588 = load i1, i1* %l13
  %t589 = load double, double* %l14
  %t590 = load i8*, i8** %l16
  %t591 = load i8*, i8** %l17
  %t592 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t574, label %then38, label %merge39
then38:
  %t593 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t594 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t595 = extractvalue %EnumLayoutPayloadParse %t594, 1
  %t596 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t593, i8* %t595)
  store double %t596, double* %l22
  %t597 = load double, double* %l22
  %t598 = sitofp i64 0 to double
  %t599 = fcmp olt double %t597, %t598
  %t600 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t601 = load i8*, i8** %l1
  %t602 = load i8*, i8** %l2
  %t603 = load i8*, i8** %l3
  %t604 = load double, double* %l4
  %t605 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t606 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t607 = load double, double* %l7
  %t608 = load double, double* %l8
  %t609 = load i8*, i8** %l9
  %t610 = load double, double* %l10
  %t611 = load double, double* %l11
  %t612 = load i1, i1* %l12
  %t613 = load i1, i1* %l13
  %t614 = load double, double* %l14
  %t615 = load i8*, i8** %l16
  %t616 = load i8*, i8** %l17
  %t617 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t618 = load double, double* %l22
  br i1 %t599, label %then40, label %else41
then40:
  %t619 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s620 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t621 = load i8*, i8** %l3
  %t622 = call i8* @sailfin_runtime_string_concat(i8* %s620, i8* %t621)
  %s623 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.len44.h1623843, i32 0, i32 0
  %t624 = call i8* @sailfin_runtime_string_concat(i8* %t622, i8* %s623)
  %t625 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t626 = extractvalue %EnumLayoutPayloadParse %t625, 1
  %t627 = call i8* @sailfin_runtime_string_concat(i8* %t624, i8* %t626)
  %t628 = add i64 0, 2
  %t629 = call i8* @malloc(i64 %t628)
  store i8 96, i8* %t629
  %t630 = getelementptr i8, i8* %t629, i64 1
  store i8 0, i8* %t630
  call void @sailfin_runtime_mark_persistent(i8* %t629)
  %t631 = call i8* @sailfin_runtime_string_concat(i8* %t627, i8* %t629)
  %t632 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t619, i8* %t631)
  store { i8**, i64 }* %t632, { i8**, i64 }** %l0
  %t633 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t634 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t635 = load double, double* %l22
  %t636 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t637 = extractvalue %EnumLayoutPayloadParse %t636, 2
  %t638 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t634, double %t635, %NativeStructLayoutField %t637)
  store { %NativeEnumVariantLayout*, i64 }* %t638, { %NativeEnumVariantLayout*, i64 }** %l6
  %t639 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t640 = phi { i8**, i64 }* [ %t633, %then40 ], [ %t600, %else41 ]
  %t641 = phi { %NativeEnumVariantLayout*, i64 }* [ %t606, %then40 ], [ %t639, %else41 ]
  store { i8**, i64 }* %t640, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t641, { %NativeEnumVariantLayout*, i64 }** %l6
  %t642 = load i1, i1* %l12
  %t643 = xor i1 %t642, 1
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t645 = load i8*, i8** %l1
  %t646 = load i8*, i8** %l2
  %t647 = load i8*, i8** %l3
  %t648 = load double, double* %l4
  %t649 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t650 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t651 = load double, double* %l7
  %t652 = load double, double* %l8
  %t653 = load i8*, i8** %l9
  %t654 = load double, double* %l10
  %t655 = load double, double* %l11
  %t656 = load i1, i1* %l12
  %t657 = load i1, i1* %l13
  %t658 = load double, double* %l14
  %t659 = load i8*, i8** %l16
  %t660 = load i8*, i8** %l17
  %t661 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t662 = load double, double* %l22
  br i1 %t643, label %then43, label %merge44
then43:
  %t663 = load i1, i1* %l13
  %t664 = xor i1 %t663, 1
  %t665 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t666 = load i8*, i8** %l1
  %t667 = load i8*, i8** %l2
  %t668 = load i8*, i8** %l3
  %t669 = load double, double* %l4
  %t670 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t671 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t672 = load double, double* %l7
  %t673 = load double, double* %l8
  %t674 = load i8*, i8** %l9
  %t675 = load double, double* %l10
  %t676 = load double, double* %l11
  %t677 = load i1, i1* %l12
  %t678 = load i1, i1* %l13
  %t679 = load double, double* %l14
  %t680 = load i8*, i8** %l16
  %t681 = load i8*, i8** %l17
  %t682 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t683 = load double, double* %l22
  br i1 %t664, label %then45, label %merge46
then45:
  %t684 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s685 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t686 = load i8*, i8** %l3
  %t687 = call i8* @sailfin_runtime_string_concat(i8* %s685, i8* %t686)
  %s688 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h807033739, i32 0, i32 0
  %t689 = call i8* @sailfin_runtime_string_concat(i8* %t687, i8* %s688)
  %t690 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t684, i8* %t689)
  store { i8**, i64 }* %t690, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t691 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t692 = load i1, i1* %l13
  br label %merge46
merge46:
  %t693 = phi { i8**, i64 }* [ %t691, %then45 ], [ %t665, %then43 ]
  %t694 = phi i1 [ %t692, %then45 ], [ %t678, %then43 ]
  store { i8**, i64 }* %t693, { i8**, i64 }** %l0
  store i1 %t694, i1* %l13
  %t695 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t696 = load i1, i1* %l13
  br label %merge44
merge44:
  %t697 = phi { i8**, i64 }* [ %t695, %merge46 ], [ %t644, %merge42 ]
  %t698 = phi i1 [ %t696, %merge46 ], [ %t657, %merge42 ]
  store { i8**, i64 }* %t697, { i8**, i64 }** %l0
  store i1 %t698, i1* %l13
  %t699 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t700 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t701 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t702 = load i1, i1* %l13
  br label %merge39
merge39:
  %t703 = phi { i8**, i64 }* [ %t699, %merge44 ], [ %t575, %then36 ]
  %t704 = phi { %NativeEnumVariantLayout*, i64 }* [ %t700, %merge44 ], [ %t581, %then36 ]
  %t705 = phi { i8**, i64 }* [ %t701, %merge44 ], [ %t575, %then36 ]
  %t706 = phi i1 [ %t702, %merge44 ], [ %t588, %then36 ]
  store { i8**, i64 }* %t703, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t704, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t705, { i8**, i64 }** %l0
  store i1 %t706, i1* %l13
  %t707 = load double, double* %l14
  %t708 = sitofp i64 1 to double
  %t709 = fadd double %t707, %t708
  store double %t709, double* %l14
  br label %loop.latch6
merge37:
  %t710 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s711 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h2058816325, i32 0, i32 0
  %t712 = load i8*, i8** %l16
  %t713 = call i8* @sailfin_runtime_string_concat(i8* %s711, i8* %t712)
  %t714 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t710, i8* %t713)
  store { i8**, i64 }* %t714, { i8**, i64 }** %l0
  %t715 = load double, double* %l14
  %t716 = sitofp i64 1 to double
  %t717 = fadd double %t715, %t716
  store double %t717, double* %l14
  br label %loop.latch6
merge17:
  %t718 = load i8*, i8** %l16
  %s719 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h562875475, i32 0, i32 0
  %t720 = call i1 @strings_equal(i8* %t718, i8* %s719)
  %t721 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t722 = load i8*, i8** %l1
  %t723 = load i8*, i8** %l2
  %t724 = load i8*, i8** %l3
  %t725 = load double, double* %l4
  %t726 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t727 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t728 = load double, double* %l7
  %t729 = load double, double* %l8
  %t730 = load i8*, i8** %l9
  %t731 = load double, double* %l10
  %t732 = load double, double* %l11
  %t733 = load i1, i1* %l12
  %t734 = load i1, i1* %l13
  %t735 = load double, double* %l14
  %t736 = load i8*, i8** %l16
  br i1 %t720, label %then47, label %merge48
then47:
  %t737 = load double, double* %l14
  %t738 = sitofp i64 1 to double
  %t739 = fadd double %t737, %t738
  store double %t739, double* %l14
  br label %afterloop7
merge48:
  %t740 = load i8*, i8** %l16
  %s741 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t742 = call i1 @starts_with(i8* %t740, i8* %s741)
  %t743 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t744 = load i8*, i8** %l1
  %t745 = load i8*, i8** %l2
  %t746 = load i8*, i8** %l3
  %t747 = load double, double* %l4
  %t748 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t749 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t750 = load double, double* %l7
  %t751 = load double, double* %l8
  %t752 = load i8*, i8** %l9
  %t753 = load double, double* %l10
  %t754 = load double, double* %l11
  %t755 = load i1, i1* %l12
  %t756 = load i1, i1* %l13
  %t757 = load double, double* %l14
  %t758 = load i8*, i8** %l16
  br i1 %t742, label %then49, label %merge50
then49:
  %t759 = load i8*, i8** %l16
  %s760 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t761 = call i8* @strip_prefix(i8* %t759, i8* %s760)
  %t762 = call %NativeEnumVariant* @parse_enum_variant_line(i8* %t761)
  store %NativeEnumVariant* %t762, %NativeEnumVariant** %l23
  %t763 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t764 = icmp eq %NativeEnumVariant* %t763, null
  %t765 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t766 = load i8*, i8** %l1
  %t767 = load i8*, i8** %l2
  %t768 = load i8*, i8** %l3
  %t769 = load double, double* %l4
  %t770 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t771 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t772 = load double, double* %l7
  %t773 = load double, double* %l8
  %t774 = load i8*, i8** %l9
  %t775 = load double, double* %l10
  %t776 = load double, double* %l11
  %t777 = load i1, i1* %l12
  %t778 = load i1, i1* %l13
  %t779 = load double, double* %l14
  %t780 = load i8*, i8** %l16
  %t781 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  br i1 %t764, label %then51, label %else52
then51:
  %t782 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s783 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h829706524, i32 0, i32 0
  %t784 = load i8*, i8** %l16
  %t785 = call i8* @sailfin_runtime_string_concat(i8* %s783, i8* %t784)
  %t786 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t782, i8* %t785)
  store { i8**, i64 }* %t786, { i8**, i64 }** %l0
  %t787 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge53
else52:
  %t788 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t789 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t790 = load %NativeEnumVariant, %NativeEnumVariant* %t789
  %t791 = call { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %t788, %NativeEnumVariant %t790)
  store { %NativeEnumVariant*, i64 }* %t791, { %NativeEnumVariant*, i64 }** %l5
  %t792 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %merge53
merge53:
  %t793 = phi { i8**, i64 }* [ %t787, %then51 ], [ %t765, %else52 ]
  %t794 = phi { %NativeEnumVariant*, i64 }* [ %t770, %then51 ], [ %t792, %else52 ]
  store { i8**, i64 }* %t793, { i8**, i64 }** %l0
  store { %NativeEnumVariant*, i64 }* %t794, { %NativeEnumVariant*, i64 }** %l5
  %t795 = load double, double* %l14
  %t796 = sitofp i64 1 to double
  %t797 = fadd double %t795, %t796
  store double %t797, double* %l14
  br label %loop.latch6
merge50:
  %t798 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s799 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1471254674, i32 0, i32 0
  %t800 = load i8*, i8** %l16
  %t801 = call i8* @sailfin_runtime_string_concat(i8* %s799, i8* %t800)
  %t802 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t798, i8* %t801)
  store { i8**, i64 }* %t802, { i8**, i64 }** %l0
  %t803 = load double, double* %l14
  %t804 = sitofp i64 1 to double
  %t805 = fadd double %t803, %t804
  store double %t805, double* %l14
  br label %loop.latch6
loop.latch6:
  %t806 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t807 = load double, double* %l14
  %t808 = load double, double* %l7
  %t809 = load double, double* %l8
  %t810 = load i8*, i8** %l9
  %t811 = load double, double* %l10
  %t812 = load double, double* %l11
  %t813 = load i1, i1* %l12
  %t814 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t815 = load i1, i1* %l13
  %t816 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t828 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t829 = load double, double* %l14
  %t830 = load double, double* %l7
  %t831 = load double, double* %l8
  %t832 = load i8*, i8** %l9
  %t833 = load double, double* %l10
  %t834 = load double, double* %l11
  %t835 = load i1, i1* %l12
  %t836 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t837 = load i1, i1* %l13
  %t838 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t839 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t839, %NativeEnumLayout** %l24
  %t840 = load i1, i1* %l12
  %t841 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t842 = load i8*, i8** %l1
  %t843 = load i8*, i8** %l2
  %t844 = load i8*, i8** %l3
  %t845 = load double, double* %l4
  %t846 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t847 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t848 = load double, double* %l7
  %t849 = load double, double* %l8
  %t850 = load i8*, i8** %l9
  %t851 = load double, double* %l10
  %t852 = load double, double* %l11
  %t853 = load i1, i1* %l12
  %t854 = load i1, i1* %l13
  %t855 = load double, double* %l14
  %t856 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br i1 %t840, label %then54, label %merge55
then54:
  %t857 = load double, double* %l7
  %t858 = insertvalue %NativeEnumLayout undef, double %t857, 0
  %t859 = load double, double* %l8
  %t860 = insertvalue %NativeEnumLayout %t858, double %t859, 1
  %t861 = load i8*, i8** %l9
  %t862 = insertvalue %NativeEnumLayout %t860, i8* %t861, 2
  %t863 = load double, double* %l10
  %t864 = insertvalue %NativeEnumLayout %t862, double %t863, 3
  %t865 = load double, double* %l11
  %t866 = insertvalue %NativeEnumLayout %t864, double %t865, 4
  %t867 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t868 = insertvalue %NativeEnumLayout %t866, { %NativeEnumVariantLayout*, i64 }* %t867, 5
  %t869 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t868, %NativeEnumLayout* %t869
  store %NativeEnumLayout* %t869, %NativeEnumLayout** %l24
  %t870 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br label %merge55
merge55:
  %t871 = phi %NativeEnumLayout* [ %t870, %then54 ], [ %t856, %afterloop7 ]
  store %NativeEnumLayout* %t871, %NativeEnumLayout** %l24
  %t872 = load i8*, i8** %l3
  %t873 = insertvalue %NativeEnum undef, i8* %t872, 0
  %t874 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t875 = insertvalue %NativeEnum %t873, { %NativeEnumVariant*, i64 }* %t874, 1
  %t876 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  %t877 = insertvalue %NativeEnum %t875, %NativeEnumLayout* %t876, 2
  %t878 = alloca %NativeEnum
  store %NativeEnum %t877, %NativeEnum* %t878
  %t879 = insertvalue %EnumParseResult undef, %NativeEnum* %t878, 0
  %t880 = load double, double* %l14
  %t881 = insertvalue %EnumParseResult %t879, double %t880, 1
  %t882 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t883 = insertvalue %EnumParseResult %t881, { i8**, i64 }* %t882, 2
  ret %EnumParseResult %t883
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t8 = add i64 0, 2
  %t9 = call i8* @malloc(i64 %t8)
  store i8 123, i8* %t9
  %t10 = getelementptr i8, i8* %t9, i64 1
  store i8 0, i8* %t10
  call void @sailfin_runtime_mark_persistent(i8* %t9)
  %t11 = call double @index_of(i8* %t7, i8* %t9)
  store double %t11, double* %l1
  %t12 = load double, double* %l1
  %t13 = sitofp i64 0 to double
  %t14 = fcmp olt double %t12, %t13
  %t15 = load i8*, i8** %l0
  %t16 = load double, double* %l1
  br i1 %t14, label %then2, label %merge3
then2:
  %t17 = load i8*, i8** %l0
  %t18 = call i8* @strip_generics(i8* %t17)
  %t19 = insertvalue %NativeEnumVariant undef, i8* %t18, 0
  %t20 = getelementptr [0 x %NativeEnumVariantField], [0 x %NativeEnumVariantField]* null, i32 1
  %t21 = ptrtoint [0 x %NativeEnumVariantField]* %t20 to i64
  %t22 = icmp eq i64 %t21, 0
  %t23 = select i1 %t22, i64 1, i64 %t21
  %t24 = call i8* @malloc(i64 %t23)
  %t25 = bitcast i8* %t24 to %NativeEnumVariantField*
  %t26 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* null, i32 1
  %t27 = ptrtoint { %NativeEnumVariantField*, i64 }* %t26 to i64
  %t28 = call i8* @malloc(i64 %t27)
  %t29 = bitcast i8* %t28 to { %NativeEnumVariantField*, i64 }*
  %t30 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t29, i32 0, i32 0
  store %NativeEnumVariantField* %t25, %NativeEnumVariantField** %t30
  %t31 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t29, i32 0, i32 1
  store i64 0, i64* %t31
  %t32 = insertvalue %NativeEnumVariant %t19, { %NativeEnumVariantField*, i64 }* %t29, 1
  %t33 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t32, %NativeEnumVariant* %t33
  ret %NativeEnumVariant* %t33
merge3:
  %t34 = load i8*, i8** %l0
  %t35 = add i64 0, 2
  %t36 = call i8* @malloc(i64 %t35)
  store i8 125, i8* %t36
  %t37 = getelementptr i8, i8* %t36, i64 1
  store i8 0, i8* %t37
  call void @sailfin_runtime_mark_persistent(i8* %t36)
  %t38 = call double @last_index_of(i8* %t34, i8* %t36)
  store double %t38, double* %l2
  %t40 = load double, double* %l2
  %t41 = sitofp i64 0 to double
  %t42 = fcmp olt double %t40, %t41
  br label %logical_or_entry_39

logical_or_entry_39:
  br i1 %t42, label %logical_or_merge_39, label %logical_or_right_39

logical_or_right_39:
  %t43 = load double, double* %l2
  %t44 = load double, double* %l1
  %t45 = fcmp ole double %t43, %t44
  br label %logical_or_right_end_39

logical_or_right_end_39:
  br label %logical_or_merge_39

logical_or_merge_39:
  %t46 = phi i1 [ true, %logical_or_entry_39 ], [ %t45, %logical_or_right_end_39 ]
  %t47 = load i8*, i8** %l0
  %t48 = load double, double* %l1
  %t49 = load double, double* %l2
  br i1 %t46, label %then4, label %merge5
then4:
  %t50 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t50
merge5:
  %t51 = load i8*, i8** %l0
  %t52 = load double, double* %l1
  %t53 = call double @llvm.round.f64(double %t52)
  %t54 = fptosi double %t53 to i64
  %t55 = call i8* @sailfin_runtime_substring(i8* %t51, i64 0, i64 %t54)
  %t56 = call i8* @trim_text__native_ir(i8* %t55)
  %t57 = call i8* @strip_generics(i8* %t56)
  store i8* %t57, i8** %l3
  %t58 = load i8*, i8** %l3
  %t59 = call i64 @sailfin_runtime_string_length(i8* %t58)
  %t60 = icmp eq i64 %t59, 0
  %t61 = load i8*, i8** %l0
  %t62 = load double, double* %l1
  %t63 = load double, double* %l2
  %t64 = load i8*, i8** %l3
  br i1 %t60, label %then6, label %merge7
then6:
  %t65 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t65
merge7:
  %t66 = load i8*, i8** %l0
  %t67 = load double, double* %l1
  %t68 = sitofp i64 1 to double
  %t69 = fadd double %t67, %t68
  %t70 = load double, double* %l2
  %t71 = call double @llvm.round.f64(double %t69)
  %t72 = fptosi double %t71 to i64
  %t73 = call double @llvm.round.f64(double %t70)
  %t74 = fptosi double %t73 to i64
  %t75 = call i8* @sailfin_runtime_substring(i8* %t66, i64 %t72, i64 %t74)
  store i8* %t75, i8** %l4
  %t76 = load i8*, i8** %l4
  %t77 = call { i8**, i64 }* @split_enum_field_entries(i8* %t76)
  store { i8**, i64 }* %t77, { i8**, i64 }** %l5
  %t78 = getelementptr [0 x %NativeEnumVariantField], [0 x %NativeEnumVariantField]* null, i32 1
  %t79 = ptrtoint [0 x %NativeEnumVariantField]* %t78 to i64
  %t80 = icmp eq i64 %t79, 0
  %t81 = select i1 %t80, i64 1, i64 %t79
  %t82 = call i8* @malloc(i64 %t81)
  %t83 = bitcast i8* %t82 to %NativeEnumVariantField*
  %t84 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* null, i32 1
  %t85 = ptrtoint { %NativeEnumVariantField*, i64 }* %t84 to i64
  %t86 = call i8* @malloc(i64 %t85)
  %t87 = bitcast i8* %t86 to { %NativeEnumVariantField*, i64 }*
  %t88 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t87, i32 0, i32 0
  store %NativeEnumVariantField* %t83, %NativeEnumVariantField** %t88
  %t89 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t87, i32 0, i32 1
  store i64 0, i64* %t89
  store { %NativeEnumVariantField*, i64 }* %t87, { %NativeEnumVariantField*, i64 }** %l6
  %t90 = sitofp i64 0 to double
  store double %t90, double* %l7
  %t91 = load i8*, i8** %l0
  %t92 = load double, double* %l1
  %t93 = load double, double* %l2
  %t94 = load i8*, i8** %l3
  %t95 = load i8*, i8** %l4
  %t96 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t97 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t98 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t164 = phi double [ %t98, %merge7 ], [ %t162, %loop.latch10 ]
  %t165 = phi { %NativeEnumVariantField*, i64 }* [ %t97, %merge7 ], [ %t163, %loop.latch10 ]
  store double %t164, double* %l7
  store { %NativeEnumVariantField*, i64 }* %t165, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t99 = load double, double* %l7
  %t100 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t101 = load { i8**, i64 }, { i8**, i64 }* %t100
  %t102 = extractvalue { i8**, i64 } %t101, 1
  %t103 = sitofp i64 %t102 to double
  %t104 = fcmp oge double %t99, %t103
  %t105 = load i8*, i8** %l0
  %t106 = load double, double* %l1
  %t107 = load double, double* %l2
  %t108 = load i8*, i8** %l3
  %t109 = load i8*, i8** %l4
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t111 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t112 = load double, double* %l7
  br i1 %t104, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t114 = load double, double* %l7
  %t115 = call double @llvm.round.f64(double %t114)
  %t116 = fptosi double %t115 to i64
  %t117 = load { i8**, i64 }, { i8**, i64 }* %t113
  %t118 = extractvalue { i8**, i64 } %t117, 0
  %t119 = extractvalue { i8**, i64 } %t117, 1
  %t120 = icmp uge i64 %t116, %t119
  ; bounds check: %t120 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t116, i64 %t119)
  %t121 = getelementptr i8*, i8** %t118, i64 %t116
  %t122 = load i8*, i8** %t121
  %t123 = call i8* @trim_text__native_ir(i8* %t122)
  %t124 = call i8* @trim_trailing_delimiters(i8* %t123)
  store i8* %t124, i8** %l8
  %t125 = load i8*, i8** %l8
  %t126 = call i64 @sailfin_runtime_string_length(i8* %t125)
  %t127 = icmp eq i64 %t126, 0
  %t128 = load i8*, i8** %l0
  %t129 = load double, double* %l1
  %t130 = load double, double* %l2
  %t131 = load i8*, i8** %l3
  %t132 = load i8*, i8** %l4
  %t133 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t134 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t135 = load double, double* %l7
  %t136 = load i8*, i8** %l8
  br i1 %t127, label %then14, label %merge15
then14:
  %t137 = load double, double* %l7
  %t138 = sitofp i64 1 to double
  %t139 = fadd double %t137, %t138
  store double %t139, double* %l7
  br label %loop.latch10
merge15:
  %t140 = load i8*, i8** %l8
  %t141 = call %NativeEnumVariantField* @parse_enum_variant_field(i8* %t140)
  store %NativeEnumVariantField* %t141, %NativeEnumVariantField** %l9
  %t142 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t143 = icmp eq %NativeEnumVariantField* %t142, null
  %t144 = load i8*, i8** %l0
  %t145 = load double, double* %l1
  %t146 = load double, double* %l2
  %t147 = load i8*, i8** %l3
  %t148 = load i8*, i8** %l4
  %t149 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t150 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t151 = load double, double* %l7
  %t152 = load i8*, i8** %l8
  %t153 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  br i1 %t143, label %then16, label %merge17
then16:
  %t154 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t154
merge17:
  %t155 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t156 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t157 = load %NativeEnumVariantField, %NativeEnumVariantField* %t156
  %t158 = call { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %t155, %NativeEnumVariantField %t157)
  store { %NativeEnumVariantField*, i64 }* %t158, { %NativeEnumVariantField*, i64 }** %l6
  %t159 = load double, double* %l7
  %t160 = sitofp i64 1 to double
  %t161 = fadd double %t159, %t160
  store double %t161, double* %l7
  br label %loop.latch10
loop.latch10:
  %t162 = load double, double* %l7
  %t163 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t166 = load double, double* %l7
  %t167 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t168 = load i8*, i8** %l3
  %t169 = insertvalue %NativeEnumVariant undef, i8* %t168, 0
  %t170 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t171 = insertvalue %NativeEnumVariant %t169, { %NativeEnumVariantField*, i64 }* %t170, 1
  %t172 = alloca %NativeEnumVariant
  store %NativeEnumVariant %t171, %NativeEnumVariant* %t172
  ret %NativeEnumVariant* %t172
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
  %t117 = phi double [ %t17, %block.entry ], [ %t113, %loop.latch2 ]
  %t118 = phi { i8**, i64 }* [ %t15, %block.entry ], [ %t114, %loop.latch2 ]
  %t119 = phi i8* [ %t16, %block.entry ], [ %t115, %loop.latch2 ]
  %t120 = phi double [ %t18, %block.entry ], [ %t116, %loop.latch2 ]
  store double %t117, double* %l2
  store { i8**, i64 }* %t118, { i8**, i64 }** %l0
  store i8* %t119, i8** %l1
  store double %t120, double* %l3
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
  %t103 = add i64 0, 2
  %t104 = call i8* @malloc(i64 %t103)
  store i8 %t102, i8* %t104
  %t105 = getelementptr i8, i8* %t104, i64 1
  store i8 0, i8* %t105
  call void @sailfin_runtime_mark_persistent(i8* %t104)
  %t106 = call i8* @sailfin_runtime_string_concat(i8* %t101, i8* %t104)
  store i8* %t106, i8** %l1
  %t107 = load i8*, i8** %l1
  br label %merge15
merge15:
  %t108 = phi { i8**, i64 }* [ %t99, %then13 ], [ %t90, %else14 ]
  %t109 = phi i8* [ %t100, %then13 ], [ %t107, %else14 ]
  store { i8**, i64 }* %t108, { i8**, i64 }** %l0
  store i8* %t109, i8** %l1
  %t110 = load double, double* %l3
  %t111 = sitofp i64 1 to double
  %t112 = fadd double %t110, %t111
  store double %t112, double* %l3
  br label %loop.latch2
loop.latch2:
  %t113 = load double, double* %l2
  %t114 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t115 = load i8*, i8** %l1
  %t116 = load double, double* %l3
  br label %loop.header0
afterloop3:
  %t121 = load double, double* %l2
  %t122 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t123 = load i8*, i8** %l1
  %t124 = load double, double* %l3
  %t125 = load i8*, i8** %l1
  %t126 = call i64 @sailfin_runtime_string_length(i8* %t125)
  %t127 = icmp sgt i64 %t126, 0
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t129 = load i8*, i8** %l1
  %t130 = load double, double* %l2
  %t131 = load double, double* %l3
  br i1 %t127, label %then16, label %merge17
then16:
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t133 = load i8*, i8** %l1
  %t134 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t132, i8* %t133)
  store { i8**, i64 }* %t134, { i8**, i64 }** %l0
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge17
merge17:
  %t136 = phi { i8**, i64 }* [ %t135, %then16 ], [ %t128, %afterloop3 ]
  store { i8**, i64 }* %t136, { i8**, i64 }** %l0
  %t137 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t137
}

define %NativeEnumVariantField* @parse_enum_variant_field(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca double
  %l3 = alloca i8*
  %l4 = alloca i8*
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t14 = call i8* @trim_text__native_ir(i8* %t13)
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
  %t34 = call i8* @trim_text__native_ir(i8* %t33)
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
  %t52 = call i8* @trim_text__native_ir(i8* %t51)
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t14 = call i8* @trim_text__native_ir(i8* %t13)
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
  %t34 = call i8* @trim_text__native_ir(i8* %t33)
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
  %t52 = call i8* @trim_text__native_ir(i8* %t51)
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t242 = phi i8* [ %t41, %merge1 ], [ %t234, %loop.latch4 ]
  %t243 = phi i1 [ %t38, %merge1 ], [ %t235, %loop.latch4 ]
  %t244 = phi i1 [ %t39, %merge1 ], [ %t236, %loop.latch4 ]
  %t245 = phi double [ %t42, %merge1 ], [ %t237, %loop.latch4 ]
  %t246 = phi { i8**, i64 }* [ %t37, %merge1 ], [ %t238, %loop.latch4 ]
  %t247 = phi i1 [ %t40, %merge1 ], [ %t239, %loop.latch4 ]
  %t248 = phi double [ %t43, %merge1 ], [ %t240, %loop.latch4 ]
  %t249 = phi double [ %t44, %merge1 ], [ %t241, %loop.latch4 ]
  store i8* %t242, i8** %l5
  store i1 %t243, i1* %l2
  store i1 %t244, i1* %l3
  store double %t245, double* %l6
  store { i8**, i64 }* %t246, { i8**, i64 }** %l1
  store i1 %t247, i1* %l4
  store double %t248, double* %l7
  store double %t249, double* %l8
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
  %t130 = add i64 0, 2
  %t131 = call i8* @malloc(i64 %t130)
  store i8 96, i8* %t131
  %t132 = getelementptr i8, i8* %t131, i64 1
  store i8 0, i8* %t132
  call void @sailfin_runtime_mark_persistent(i8* %t131)
  %t133 = call i8* @sailfin_runtime_string_concat(i8* %t129, i8* %t131)
  %t134 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t126, i8* %t133)
  store { i8**, i64 }* %t134, { i8**, i64 }** %l1
  %t135 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t136 = phi i1 [ %t124, %then14 ], [ %t113, %else15 ]
  %t137 = phi double [ %t125, %then14 ], [ %t116, %else15 ]
  %t138 = phi { i8**, i64 }* [ %t111, %then14 ], [ %t135, %else15 ]
  store i1 %t136, i1* %l3
  store double %t137, double* %l6
  store { i8**, i64 }* %t138, { i8**, i64 }** %l1
  %t139 = load i1, i1* %l3
  %t140 = load double, double* %l6
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t142 = load i8*, i8** %l9
  %s143 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t144 = call i1 @starts_with(i8* %t142, i8* %s143)
  %t145 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t146 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t147 = load i1, i1* %l2
  %t148 = load i1, i1* %l3
  %t149 = load i1, i1* %l4
  %t150 = load i8*, i8** %l5
  %t151 = load double, double* %l6
  %t152 = load double, double* %l7
  %t153 = load double, double* %l8
  %t154 = load i8*, i8** %l9
  br i1 %t144, label %then17, label %else18
then17:
  %t155 = load i8*, i8** %l9
  %t156 = load i8*, i8** %l9
  %t157 = call i64 @sailfin_runtime_string_length(i8* %t156)
  %t158 = call i8* @sailfin_runtime_substring(i8* %t155, i64 6, i64 %t157)
  store i8* %t158, i8** %l12
  %t159 = load i8*, i8** %l12
  %t160 = call %NumberParseResult @parse_decimal_number(i8* %t159)
  store %NumberParseResult %t160, %NumberParseResult* %l13
  %t161 = load %NumberParseResult, %NumberParseResult* %l13
  %t162 = extractvalue %NumberParseResult %t161, 0
  %t163 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t164 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t165 = load i1, i1* %l2
  %t166 = load i1, i1* %l3
  %t167 = load i1, i1* %l4
  %t168 = load i8*, i8** %l5
  %t169 = load double, double* %l6
  %t170 = load double, double* %l7
  %t171 = load double, double* %l8
  %t172 = load i8*, i8** %l9
  %t173 = load i8*, i8** %l12
  %t174 = load %NumberParseResult, %NumberParseResult* %l13
  br i1 %t162, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t175 = load %NumberParseResult, %NumberParseResult* %l13
  %t176 = extractvalue %NumberParseResult %t175, 1
  store double %t176, double* %l7
  %t177 = load i1, i1* %l4
  %t178 = load double, double* %l7
  br label %merge22
else21:
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s180 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h1650449248, i32 0, i32 0
  %t181 = load i8*, i8** %l12
  %t182 = call i8* @sailfin_runtime_string_concat(i8* %s180, i8* %t181)
  %t183 = add i64 0, 2
  %t184 = call i8* @malloc(i64 %t183)
  store i8 96, i8* %t184
  %t185 = getelementptr i8, i8* %t184, i64 1
  store i8 0, i8* %t185
  call void @sailfin_runtime_mark_persistent(i8* %t184)
  %t186 = call i8* @sailfin_runtime_string_concat(i8* %t182, i8* %t184)
  %t187 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t179, i8* %t186)
  store { i8**, i64 }* %t187, { i8**, i64 }** %l1
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t189 = phi i1 [ %t177, %then20 ], [ %t167, %else21 ]
  %t190 = phi double [ %t178, %then20 ], [ %t170, %else21 ]
  %t191 = phi { i8**, i64 }* [ %t164, %then20 ], [ %t188, %else21 ]
  store i1 %t189, i1* %l4
  store double %t190, double* %l7
  store { i8**, i64 }* %t191, { i8**, i64 }** %l1
  %t192 = load i1, i1* %l4
  %t193 = load double, double* %l7
  %t194 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t195 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s196 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1415177535, i32 0, i32 0
  %t197 = load i8*, i8** %l9
  %t198 = call i8* @sailfin_runtime_string_concat(i8* %s196, i8* %t197)
  %t199 = add i64 0, 2
  %t200 = call i8* @malloc(i64 %t199)
  store i8 96, i8* %t200
  %t201 = getelementptr i8, i8* %t200, i64 1
  store i8 0, i8* %t201
  call void @sailfin_runtime_mark_persistent(i8* %t200)
  %t202 = call i8* @sailfin_runtime_string_concat(i8* %t198, i8* %t200)
  %t203 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t195, i8* %t202)
  store { i8**, i64 }* %t203, { i8**, i64 }** %l1
  %t204 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t205 = phi i1 [ %t192, %merge22 ], [ %t149, %else18 ]
  %t206 = phi double [ %t193, %merge22 ], [ %t152, %else18 ]
  %t207 = phi { i8**, i64 }* [ %t194, %merge22 ], [ %t204, %else18 ]
  store i1 %t205, i1* %l4
  store double %t206, double* %l7
  store { i8**, i64 }* %t207, { i8**, i64 }** %l1
  %t208 = load i1, i1* %l4
  %t209 = load double, double* %l7
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t212 = phi i1 [ %t139, %merge16 ], [ %t95, %merge19 ]
  %t213 = phi double [ %t140, %merge16 ], [ %t98, %merge19 ]
  %t214 = phi { i8**, i64 }* [ %t141, %merge16 ], [ %t210, %merge19 ]
  %t215 = phi i1 [ %t96, %merge16 ], [ %t208, %merge19 ]
  %t216 = phi double [ %t99, %merge16 ], [ %t209, %merge19 ]
  store i1 %t212, i1* %l3
  store double %t213, double* %l6
  store { i8**, i64 }* %t214, { i8**, i64 }** %l1
  store i1 %t215, i1* %l4
  store double %t216, double* %l7
  %t217 = load i1, i1* %l3
  %t218 = load double, double* %l6
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t220 = load i1, i1* %l4
  %t221 = load double, double* %l7
  %t222 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t224 = phi i8* [ %t87, %then8 ], [ %t78, %merge13 ]
  %t225 = phi i1 [ %t88, %then8 ], [ %t75, %merge13 ]
  %t226 = phi i1 [ %t76, %then8 ], [ %t217, %merge13 ]
  %t227 = phi double [ %t79, %then8 ], [ %t218, %merge13 ]
  %t228 = phi { i8**, i64 }* [ %t74, %then8 ], [ %t219, %merge13 ]
  %t229 = phi i1 [ %t77, %then8 ], [ %t220, %merge13 ]
  %t230 = phi double [ %t80, %then8 ], [ %t221, %merge13 ]
  store i8* %t224, i8** %l5
  store i1 %t225, i1* %l2
  store i1 %t226, i1* %l3
  store double %t227, double* %l6
  store { i8**, i64 }* %t228, { i8**, i64 }** %l1
  store i1 %t229, i1* %l4
  store double %t230, double* %l7
  %t231 = load double, double* %l8
  %t232 = sitofp i64 1 to double
  %t233 = fadd double %t231, %t232
  store double %t233, double* %l8
  br label %loop.latch4
loop.latch4:
  %t234 = load i8*, i8** %l5
  %t235 = load i1, i1* %l2
  %t236 = load i1, i1* %l3
  %t237 = load double, double* %l6
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t239 = load i1, i1* %l4
  %t240 = load double, double* %l7
  %t241 = load double, double* %l8
  br label %loop.header2
afterloop5:
  %t250 = load i8*, i8** %l5
  %t251 = load i1, i1* %l2
  %t252 = load i1, i1* %l3
  %t253 = load double, double* %l6
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t255 = load i1, i1* %l4
  %t256 = load double, double* %l7
  %t257 = load double, double* %l8
  %t258 = load i1, i1* %l3
  %t259 = xor i1 %t258, 1
  %t260 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t261 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t262 = load i1, i1* %l2
  %t263 = load i1, i1* %l3
  %t264 = load i1, i1* %l4
  %t265 = load i8*, i8** %l5
  %t266 = load double, double* %l6
  %t267 = load double, double* %l7
  %t268 = load double, double* %l8
  br i1 %t259, label %then23, label %merge24
then23:
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s270 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h1399971520, i32 0, i32 0
  %t271 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t269, i8* %s270)
  store { i8**, i64 }* %t271, { i8**, i64 }** %l1
  %t272 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge24
merge24:
  %t273 = phi { i8**, i64 }* [ %t272, %then23 ], [ %t261, %afterloop5 ]
  store { i8**, i64 }* %t273, { i8**, i64 }** %l1
  %t274 = load i1, i1* %l4
  %t275 = xor i1 %t274, 1
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t278 = load i1, i1* %l2
  %t279 = load i1, i1* %l3
  %t280 = load i1, i1* %l4
  %t281 = load i8*, i8** %l5
  %t282 = load double, double* %l6
  %t283 = load double, double* %l7
  %t284 = load double, double* %l8
  br i1 %t275, label %then25, label %merge26
then25:
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s286 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h318366654, i32 0, i32 0
  %t287 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t285, i8* %s286)
  store { i8**, i64 }* %t287, { i8**, i64 }** %l1
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t289 = phi { i8**, i64 }* [ %t288, %then25 ], [ %t277, %merge24 ]
  store { i8**, i64 }* %t289, { i8**, i64 }** %l1
  %t291 = load i1, i1* %l3
  br label %logical_and_entry_290

logical_and_entry_290:
  br i1 %t291, label %logical_and_right_290, label %logical_and_merge_290

logical_and_right_290:
  %t293 = load i1, i1* %l4
  br label %logical_and_entry_292

logical_and_entry_292:
  br i1 %t293, label %logical_and_right_292, label %logical_and_merge_292

logical_and_right_292:
  %t294 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t295 = load { i8**, i64 }, { i8**, i64 }* %t294
  %t296 = extractvalue { i8**, i64 } %t295, 1
  %t297 = icmp eq i64 %t296, 0
  br label %logical_and_right_end_292

logical_and_right_end_292:
  br label %logical_and_merge_292

logical_and_merge_292:
  %t298 = phi i1 [ false, %logical_and_entry_292 ], [ %t297, %logical_and_right_end_292 ]
  br label %logical_and_right_end_290

logical_and_right_end_290:
  br label %logical_and_merge_290

logical_and_merge_290:
  %t299 = phi i1 [ false, %logical_and_entry_290 ], [ %t298, %logical_and_right_end_290 ]
  store i1 %t299, i1* %l14
  %t300 = load i1, i1* %l14
  %t301 = insertvalue %StructLayoutHeaderParse undef, i1 %t300, 0
  %t302 = load i8*, i8** %l5
  %t303 = insertvalue %StructLayoutHeaderParse %t301, i8* %t302, 1
  %t304 = load double, double* %l6
  %t305 = insertvalue %StructLayoutHeaderParse %t303, double %t304, 2
  %t306 = load double, double* %l7
  %t307 = insertvalue %StructLayoutHeaderParse %t305, double %t306, 3
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t309 = insertvalue %StructLayoutHeaderParse %t307, { i8**, i64 }* %t308, 4
  ret %StructLayoutHeaderParse %t309
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t433 = phi i8* [ %t97, %merge5 ], [ %t424, %loop.latch8 ]
  %t434 = phi i1 [ %t98, %merge5 ], [ %t425, %loop.latch8 ]
  %t435 = phi double [ %t101, %merge5 ], [ %t426, %loop.latch8 ]
  %t436 = phi { i8**, i64 }* [ %t93, %merge5 ], [ %t427, %loop.latch8 ]
  %t437 = phi i1 [ %t99, %merge5 ], [ %t428, %loop.latch8 ]
  %t438 = phi double [ %t102, %merge5 ], [ %t429, %loop.latch8 ]
  %t439 = phi i1 [ %t100, %merge5 ], [ %t430, %loop.latch8 ]
  %t440 = phi double [ %t103, %merge5 ], [ %t431, %loop.latch8 ]
  %t441 = phi double [ %t104, %merge5 ], [ %t432, %loop.latch8 ]
  store i8* %t433, i8** %l5
  store i1 %t434, i1* %l6
  store double %t435, double* %l9
  store { i8**, i64 }* %t436, { i8**, i64 }** %l1
  store i1 %t437, i1* %l7
  store double %t438, double* %l10
  store i1 %t439, i1* %l8
  store double %t440, double* %l11
  store double %t441, double* %l12
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
  %t212 = add i64 0, 2
  %t213 = call i8* @malloc(i64 %t212)
  store i8 96, i8* %t213
  %t214 = getelementptr i8, i8* %t213, i64 1
  store i8 0, i8* %t214
  call void @sailfin_runtime_mark_persistent(i8* %t213)
  %t215 = call i8* @sailfin_runtime_string_concat(i8* %t211, i8* %t213)
  %t216 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t201, i8* %t215)
  store { i8**, i64 }* %t216, { i8**, i64 }** %l1
  %t217 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t218 = phi i1 [ %t199, %then18 ], [ %t187, %else19 ]
  %t219 = phi double [ %t200, %then18 ], [ %t190, %else19 ]
  %t220 = phi { i8**, i64 }* [ %t182, %then18 ], [ %t217, %else19 ]
  store i1 %t218, i1* %l6
  store double %t219, double* %l9
  store { i8**, i64 }* %t220, { i8**, i64 }** %l1
  %t221 = load i1, i1* %l6
  %t222 = load double, double* %l9
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t224 = load i8*, i8** %l13
  %s225 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t226 = call i1 @starts_with(i8* %t224, i8* %s225)
  %t227 = load i8*, i8** %l0
  %t228 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t229 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t230 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t231 = load i8*, i8** %l4
  %t232 = load i8*, i8** %l5
  %t233 = load i1, i1* %l6
  %t234 = load i1, i1* %l7
  %t235 = load i1, i1* %l8
  %t236 = load double, double* %l9
  %t237 = load double, double* %l10
  %t238 = load double, double* %l11
  %t239 = load double, double* %l12
  %t240 = load i8*, i8** %l13
  br i1 %t226, label %then21, label %else22
then21:
  %t241 = load i8*, i8** %l13
  %t242 = load i8*, i8** %l13
  %t243 = call i64 @sailfin_runtime_string_length(i8* %t242)
  %t244 = call i8* @sailfin_runtime_substring(i8* %t241, i64 5, i64 %t243)
  store i8* %t244, i8** %l16
  %t245 = load i8*, i8** %l16
  %t246 = call %NumberParseResult @parse_decimal_number(i8* %t245)
  store %NumberParseResult %t246, %NumberParseResult* %l17
  %t247 = load %NumberParseResult, %NumberParseResult* %l17
  %t248 = extractvalue %NumberParseResult %t247, 0
  %t249 = load i8*, i8** %l0
  %t250 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t251 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t252 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t253 = load i8*, i8** %l4
  %t254 = load i8*, i8** %l5
  %t255 = load i1, i1* %l6
  %t256 = load i1, i1* %l7
  %t257 = load i1, i1* %l8
  %t258 = load double, double* %l9
  %t259 = load double, double* %l10
  %t260 = load double, double* %l11
  %t261 = load double, double* %l12
  %t262 = load i8*, i8** %l13
  %t263 = load i8*, i8** %l16
  %t264 = load %NumberParseResult, %NumberParseResult* %l17
  br i1 %t248, label %then24, label %else25
then24:
  store i1 1, i1* %l7
  %t265 = load %NumberParseResult, %NumberParseResult* %l17
  %t266 = extractvalue %NumberParseResult %t265, 1
  store double %t266, double* %l10
  %t267 = load i1, i1* %l7
  %t268 = load double, double* %l10
  br label %merge26
else25:
  %t269 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s270 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t271 = call i8* @sailfin_runtime_string_concat(i8* %s270, i8* %struct_name)
  %s272 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t273 = call i8* @sailfin_runtime_string_concat(i8* %t271, i8* %s272)
  %t274 = load i8*, i8** %l4
  %t275 = call i8* @sailfin_runtime_string_concat(i8* %t273, i8* %t274)
  %s276 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t277 = call i8* @sailfin_runtime_string_concat(i8* %t275, i8* %s276)
  %t278 = load i8*, i8** %l16
  %t279 = call i8* @sailfin_runtime_string_concat(i8* %t277, i8* %t278)
  %t280 = add i64 0, 2
  %t281 = call i8* @malloc(i64 %t280)
  store i8 96, i8* %t281
  %t282 = getelementptr i8, i8* %t281, i64 1
  store i8 0, i8* %t282
  call void @sailfin_runtime_mark_persistent(i8* %t281)
  %t283 = call i8* @sailfin_runtime_string_concat(i8* %t279, i8* %t281)
  %t284 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t269, i8* %t283)
  store { i8**, i64 }* %t284, { i8**, i64 }** %l1
  %t285 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t286 = phi i1 [ %t267, %then24 ], [ %t256, %else25 ]
  %t287 = phi double [ %t268, %then24 ], [ %t259, %else25 ]
  %t288 = phi { i8**, i64 }* [ %t250, %then24 ], [ %t285, %else25 ]
  store i1 %t286, i1* %l7
  store double %t287, double* %l10
  store { i8**, i64 }* %t288, { i8**, i64 }** %l1
  %t289 = load i1, i1* %l7
  %t290 = load double, double* %l10
  %t291 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t292 = load i8*, i8** %l13
  %s293 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t294 = call i1 @starts_with(i8* %t292, i8* %s293)
  %t295 = load i8*, i8** %l0
  %t296 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t297 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t298 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t299 = load i8*, i8** %l4
  %t300 = load i8*, i8** %l5
  %t301 = load i1, i1* %l6
  %t302 = load i1, i1* %l7
  %t303 = load i1, i1* %l8
  %t304 = load double, double* %l9
  %t305 = load double, double* %l10
  %t306 = load double, double* %l11
  %t307 = load double, double* %l12
  %t308 = load i8*, i8** %l13
  br i1 %t294, label %then27, label %else28
then27:
  %t309 = load i8*, i8** %l13
  %t310 = load i8*, i8** %l13
  %t311 = call i64 @sailfin_runtime_string_length(i8* %t310)
  %t312 = call i8* @sailfin_runtime_substring(i8* %t309, i64 6, i64 %t311)
  store i8* %t312, i8** %l18
  %t313 = load i8*, i8** %l18
  %t314 = call %NumberParseResult @parse_decimal_number(i8* %t313)
  store %NumberParseResult %t314, %NumberParseResult* %l19
  %t315 = load %NumberParseResult, %NumberParseResult* %l19
  %t316 = extractvalue %NumberParseResult %t315, 0
  %t317 = load i8*, i8** %l0
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t319 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t320 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t321 = load i8*, i8** %l4
  %t322 = load i8*, i8** %l5
  %t323 = load i1, i1* %l6
  %t324 = load i1, i1* %l7
  %t325 = load i1, i1* %l8
  %t326 = load double, double* %l9
  %t327 = load double, double* %l10
  %t328 = load double, double* %l11
  %t329 = load double, double* %l12
  %t330 = load i8*, i8** %l13
  %t331 = load i8*, i8** %l18
  %t332 = load %NumberParseResult, %NumberParseResult* %l19
  br i1 %t316, label %then30, label %else31
then30:
  store i1 1, i1* %l8
  %t333 = load %NumberParseResult, %NumberParseResult* %l19
  %t334 = extractvalue %NumberParseResult %t333, 1
  store double %t334, double* %l11
  %t335 = load i1, i1* %l8
  %t336 = load double, double* %l11
  br label %merge32
else31:
  %t337 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s338 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t339 = call i8* @sailfin_runtime_string_concat(i8* %s338, i8* %struct_name)
  %s340 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t341 = call i8* @sailfin_runtime_string_concat(i8* %t339, i8* %s340)
  %t342 = load i8*, i8** %l4
  %t343 = call i8* @sailfin_runtime_string_concat(i8* %t341, i8* %t342)
  %s344 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t345 = call i8* @sailfin_runtime_string_concat(i8* %t343, i8* %s344)
  %t346 = load i8*, i8** %l18
  %t347 = call i8* @sailfin_runtime_string_concat(i8* %t345, i8* %t346)
  %t348 = add i64 0, 2
  %t349 = call i8* @malloc(i64 %t348)
  store i8 96, i8* %t349
  %t350 = getelementptr i8, i8* %t349, i64 1
  store i8 0, i8* %t350
  call void @sailfin_runtime_mark_persistent(i8* %t349)
  %t351 = call i8* @sailfin_runtime_string_concat(i8* %t347, i8* %t349)
  %t352 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t337, i8* %t351)
  store { i8**, i64 }* %t352, { i8**, i64 }** %l1
  %t353 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t354 = phi i1 [ %t335, %then30 ], [ %t325, %else31 ]
  %t355 = phi double [ %t336, %then30 ], [ %t328, %else31 ]
  %t356 = phi { i8**, i64 }* [ %t318, %then30 ], [ %t353, %else31 ]
  store i1 %t354, i1* %l8
  store double %t355, double* %l11
  store { i8**, i64 }* %t356, { i8**, i64 }** %l1
  %t357 = load i1, i1* %l8
  %t358 = load double, double* %l11
  %t359 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s361 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t362 = call i8* @sailfin_runtime_string_concat(i8* %s361, i8* %struct_name)
  %s363 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t364 = call i8* @sailfin_runtime_string_concat(i8* %t362, i8* %s363)
  %t365 = load i8*, i8** %l4
  %t366 = call i8* @sailfin_runtime_string_concat(i8* %t364, i8* %t365)
  %s367 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t368 = call i8* @sailfin_runtime_string_concat(i8* %t366, i8* %s367)
  %t369 = load i8*, i8** %l13
  %t370 = call i8* @sailfin_runtime_string_concat(i8* %t368, i8* %t369)
  %t371 = add i64 0, 2
  %t372 = call i8* @malloc(i64 %t371)
  store i8 96, i8* %t372
  %t373 = getelementptr i8, i8* %t372, i64 1
  store i8 0, i8* %t373
  call void @sailfin_runtime_mark_persistent(i8* %t372)
  %t374 = call i8* @sailfin_runtime_string_concat(i8* %t370, i8* %t372)
  %t375 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t360, i8* %t374)
  store { i8**, i64 }* %t375, { i8**, i64 }** %l1
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t377 = phi i1 [ %t357, %merge32 ], [ %t303, %else28 ]
  %t378 = phi double [ %t358, %merge32 ], [ %t306, %else28 ]
  %t379 = phi { i8**, i64 }* [ %t359, %merge32 ], [ %t376, %else28 ]
  store i1 %t377, i1* %l8
  store double %t378, double* %l11
  store { i8**, i64 }* %t379, { i8**, i64 }** %l1
  %t380 = load i1, i1* %l8
  %t381 = load double, double* %l11
  %t382 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t384 = phi i1 [ %t289, %merge26 ], [ %t234, %merge29 ]
  %t385 = phi double [ %t290, %merge26 ], [ %t237, %merge29 ]
  %t386 = phi { i8**, i64 }* [ %t291, %merge26 ], [ %t382, %merge29 ]
  %t387 = phi i1 [ %t235, %merge26 ], [ %t380, %merge29 ]
  %t388 = phi double [ %t238, %merge26 ], [ %t381, %merge29 ]
  store i1 %t384, i1* %l7
  store double %t385, double* %l10
  store { i8**, i64 }* %t386, { i8**, i64 }** %l1
  store i1 %t387, i1* %l8
  store double %t388, double* %l11
  %t389 = load i1, i1* %l7
  %t390 = load double, double* %l10
  %t391 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t392 = load i1, i1* %l8
  %t393 = load double, double* %l11
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t395 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t396 = phi i1 [ %t221, %merge20 ], [ %t165, %merge23 ]
  %t397 = phi double [ %t222, %merge20 ], [ %t168, %merge23 ]
  %t398 = phi { i8**, i64 }* [ %t223, %merge20 ], [ %t391, %merge23 ]
  %t399 = phi i1 [ %t166, %merge20 ], [ %t389, %merge23 ]
  %t400 = phi double [ %t169, %merge20 ], [ %t390, %merge23 ]
  %t401 = phi i1 [ %t167, %merge20 ], [ %t392, %merge23 ]
  %t402 = phi double [ %t170, %merge20 ], [ %t393, %merge23 ]
  store i1 %t396, i1* %l6
  store double %t397, double* %l9
  store { i8**, i64 }* %t398, { i8**, i64 }** %l1
  store i1 %t399, i1* %l7
  store double %t400, double* %l10
  store i1 %t401, i1* %l8
  store double %t402, double* %l11
  %t403 = load i1, i1* %l6
  %t404 = load double, double* %l9
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t406 = load i1, i1* %l7
  %t407 = load double, double* %l10
  %t408 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t409 = load i1, i1* %l8
  %t410 = load double, double* %l11
  %t411 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t413 = phi i8* [ %t155, %then12 ], [ %t142, %merge17 ]
  %t414 = phi i1 [ %t143, %then12 ], [ %t403, %merge17 ]
  %t415 = phi double [ %t146, %then12 ], [ %t404, %merge17 ]
  %t416 = phi { i8**, i64 }* [ %t138, %then12 ], [ %t405, %merge17 ]
  %t417 = phi i1 [ %t144, %then12 ], [ %t406, %merge17 ]
  %t418 = phi double [ %t147, %then12 ], [ %t407, %merge17 ]
  %t419 = phi i1 [ %t145, %then12 ], [ %t409, %merge17 ]
  %t420 = phi double [ %t148, %then12 ], [ %t410, %merge17 ]
  store i8* %t413, i8** %l5
  store i1 %t414, i1* %l6
  store double %t415, double* %l9
  store { i8**, i64 }* %t416, { i8**, i64 }** %l1
  store i1 %t417, i1* %l7
  store double %t418, double* %l10
  store i1 %t419, i1* %l8
  store double %t420, double* %l11
  %t421 = load double, double* %l12
  %t422 = sitofp i64 1 to double
  %t423 = fadd double %t421, %t422
  store double %t423, double* %l12
  br label %loop.latch8
loop.latch8:
  %t424 = load i8*, i8** %l5
  %t425 = load i1, i1* %l6
  %t426 = load double, double* %l9
  %t427 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t428 = load i1, i1* %l7
  %t429 = load double, double* %l10
  %t430 = load i1, i1* %l8
  %t431 = load double, double* %l11
  %t432 = load double, double* %l12
  br label %loop.header6
afterloop9:
  %t442 = load i8*, i8** %l5
  %t443 = load i1, i1* %l6
  %t444 = load double, double* %l9
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t446 = load i1, i1* %l7
  %t447 = load double, double* %l10
  %t448 = load i1, i1* %l8
  %t449 = load double, double* %l11
  %t450 = load double, double* %l12
  %t451 = load i8*, i8** %l5
  %t452 = call i64 @sailfin_runtime_string_length(i8* %t451)
  %t453 = icmp eq i64 %t452, 0
  %t454 = load i8*, i8** %l0
  %t455 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t456 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t458 = load i8*, i8** %l4
  %t459 = load i8*, i8** %l5
  %t460 = load i1, i1* %l6
  %t461 = load i1, i1* %l7
  %t462 = load i1, i1* %l8
  %t463 = load double, double* %l9
  %t464 = load double, double* %l10
  %t465 = load double, double* %l11
  %t466 = load double, double* %l12
  br i1 %t453, label %then33, label %merge34
then33:
  %t467 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s468 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t469 = call i8* @sailfin_runtime_string_concat(i8* %s468, i8* %struct_name)
  %s470 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t471 = call i8* @sailfin_runtime_string_concat(i8* %t469, i8* %s470)
  %t472 = load i8*, i8** %l4
  %t473 = call i8* @sailfin_runtime_string_concat(i8* %t471, i8* %t472)
  %s474 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1568429285, i32 0, i32 0
  %t475 = call i8* @sailfin_runtime_string_concat(i8* %t473, i8* %s474)
  %t476 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t467, i8* %t475)
  store { i8**, i64 }* %t476, { i8**, i64 }** %l1
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t478 = phi { i8**, i64 }* [ %t477, %then33 ], [ %t455, %afterloop9 ]
  store { i8**, i64 }* %t478, { i8**, i64 }** %l1
  %t479 = load i1, i1* %l6
  %t480 = xor i1 %t479, 1
  %t481 = load i8*, i8** %l0
  %t482 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t483 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t485 = load i8*, i8** %l4
  %t486 = load i8*, i8** %l5
  %t487 = load i1, i1* %l6
  %t488 = load i1, i1* %l7
  %t489 = load i1, i1* %l8
  %t490 = load double, double* %l9
  %t491 = load double, double* %l10
  %t492 = load double, double* %l11
  %t493 = load double, double* %l12
  br i1 %t480, label %then35, label %merge36
then35:
  %t494 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s495 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t496 = call i8* @sailfin_runtime_string_concat(i8* %s495, i8* %struct_name)
  %s497 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t498 = call i8* @sailfin_runtime_string_concat(i8* %t496, i8* %s497)
  %t499 = load i8*, i8** %l4
  %t500 = call i8* @sailfin_runtime_string_concat(i8* %t498, i8* %t499)
  %s501 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t502 = call i8* @sailfin_runtime_string_concat(i8* %t500, i8* %s501)
  %t503 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t494, i8* %t502)
  store { i8**, i64 }* %t503, { i8**, i64 }** %l1
  %t504 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t505 = phi { i8**, i64 }* [ %t504, %then35 ], [ %t482, %merge34 ]
  store { i8**, i64 }* %t505, { i8**, i64 }** %l1
  %t506 = load i1, i1* %l7
  %t507 = xor i1 %t506, 1
  %t508 = load i8*, i8** %l0
  %t509 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t510 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t512 = load i8*, i8** %l4
  %t513 = load i8*, i8** %l5
  %t514 = load i1, i1* %l6
  %t515 = load i1, i1* %l7
  %t516 = load i1, i1* %l8
  %t517 = load double, double* %l9
  %t518 = load double, double* %l10
  %t519 = load double, double* %l11
  %t520 = load double, double* %l12
  br i1 %t507, label %then37, label %merge38
then37:
  %t521 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s522 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t523 = call i8* @sailfin_runtime_string_concat(i8* %s522, i8* %struct_name)
  %s524 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t525 = call i8* @sailfin_runtime_string_concat(i8* %t523, i8* %s524)
  %t526 = load i8*, i8** %l4
  %t527 = call i8* @sailfin_runtime_string_concat(i8* %t525, i8* %t526)
  %s528 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t529 = call i8* @sailfin_runtime_string_concat(i8* %t527, i8* %s528)
  %t530 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t521, i8* %t529)
  store { i8**, i64 }* %t530, { i8**, i64 }** %l1
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t532 = phi { i8**, i64 }* [ %t531, %then37 ], [ %t509, %merge36 ]
  store { i8**, i64 }* %t532, { i8**, i64 }** %l1
  %t533 = load i1, i1* %l8
  %t534 = xor i1 %t533, 1
  %t535 = load i8*, i8** %l0
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t537 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t538 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t539 = load i8*, i8** %l4
  %t540 = load i8*, i8** %l5
  %t541 = load i1, i1* %l6
  %t542 = load i1, i1* %l7
  %t543 = load i1, i1* %l8
  %t544 = load double, double* %l9
  %t545 = load double, double* %l10
  %t546 = load double, double* %l11
  %t547 = load double, double* %l12
  br i1 %t534, label %then39, label %merge40
then39:
  %t548 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s549 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t550 = call i8* @sailfin_runtime_string_concat(i8* %s549, i8* %struct_name)
  %s551 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h506269955, i32 0, i32 0
  %t552 = call i8* @sailfin_runtime_string_concat(i8* %t550, i8* %s551)
  %t553 = load i8*, i8** %l4
  %t554 = call i8* @sailfin_runtime_string_concat(i8* %t552, i8* %t553)
  %s555 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t556 = call i8* @sailfin_runtime_string_concat(i8* %t554, i8* %s555)
  %t557 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t548, i8* %t556)
  store { i8**, i64 }* %t557, { i8**, i64 }** %l1
  %t558 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t559 = phi { i8**, i64 }* [ %t558, %then39 ], [ %t536, %merge38 ]
  store { i8**, i64 }* %t559, { i8**, i64 }** %l1
  %t561 = load i8*, i8** %l5
  %t562 = call i64 @sailfin_runtime_string_length(i8* %t561)
  %t563 = icmp sgt i64 %t562, 0
  br label %logical_and_entry_560

logical_and_entry_560:
  br i1 %t563, label %logical_and_right_560, label %logical_and_merge_560

logical_and_right_560:
  %t565 = load i1, i1* %l6
  br label %logical_and_entry_564

logical_and_entry_564:
  br i1 %t565, label %logical_and_right_564, label %logical_and_merge_564

logical_and_right_564:
  %t567 = load i1, i1* %l7
  br label %logical_and_entry_566

logical_and_entry_566:
  br i1 %t567, label %logical_and_right_566, label %logical_and_merge_566

logical_and_right_566:
  %t569 = load i1, i1* %l8
  br label %logical_and_entry_568

logical_and_entry_568:
  br i1 %t569, label %logical_and_right_568, label %logical_and_merge_568

logical_and_right_568:
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t571 = load { i8**, i64 }, { i8**, i64 }* %t570
  %t572 = extractvalue { i8**, i64 } %t571, 1
  %t573 = icmp eq i64 %t572, 0
  br label %logical_and_right_end_568

logical_and_right_end_568:
  br label %logical_and_merge_568

logical_and_merge_568:
  %t574 = phi i1 [ false, %logical_and_entry_568 ], [ %t573, %logical_and_right_end_568 ]
  br label %logical_and_right_end_566

logical_and_right_end_566:
  br label %logical_and_merge_566

logical_and_merge_566:
  %t575 = phi i1 [ false, %logical_and_entry_566 ], [ %t574, %logical_and_right_end_566 ]
  br label %logical_and_right_end_564

logical_and_right_end_564:
  br label %logical_and_merge_564

logical_and_merge_564:
  %t576 = phi i1 [ false, %logical_and_entry_564 ], [ %t575, %logical_and_right_end_564 ]
  br label %logical_and_right_end_560

logical_and_right_end_560:
  br label %logical_and_merge_560

logical_and_merge_560:
  %t577 = phi i1 [ false, %logical_and_entry_560 ], [ %t576, %logical_and_right_end_560 ]
  store i1 %t577, i1* %l20
  %t578 = load i8*, i8** %l4
  %t579 = insertvalue %NativeStructLayoutField undef, i8* %t578, 0
  %t580 = load i8*, i8** %l5
  %t581 = insertvalue %NativeStructLayoutField %t579, i8* %t580, 1
  %t582 = load double, double* %l9
  %t583 = insertvalue %NativeStructLayoutField %t581, double %t582, 2
  %t584 = load double, double* %l10
  %t585 = insertvalue %NativeStructLayoutField %t583, double %t584, 3
  %t586 = load double, double* %l11
  %t587 = insertvalue %NativeStructLayoutField %t585, double %t586, 4
  store %NativeStructLayoutField %t587, %NativeStructLayoutField* %l21
  %t588 = load i1, i1* %l20
  %t589 = insertvalue %StructLayoutFieldParse undef, i1 %t588, 0
  %t590 = load %NativeStructLayoutField, %NativeStructLayoutField* %l21
  %t591 = insertvalue %StructLayoutFieldParse %t589, %NativeStructLayoutField %t590, 1
  %t592 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t593 = insertvalue %StructLayoutFieldParse %t591, { i8**, i64 }* %t592, 2
  ret %StructLayoutFieldParse %t593
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t502 = phi i8* [ %t50, %merge1 ], [ %t489, %loop.latch4 ]
  %t503 = phi i1 [ %t47, %merge1 ], [ %t490, %loop.latch4 ]
  %t504 = phi i1 [ %t48, %merge1 ], [ %t491, %loop.latch4 ]
  %t505 = phi double [ %t54, %merge1 ], [ %t492, %loop.latch4 ]
  %t506 = phi { i8**, i64 }* [ %t46, %merge1 ], [ %t493, %loop.latch4 ]
  %t507 = phi i1 [ %t49, %merge1 ], [ %t494, %loop.latch4 ]
  %t508 = phi double [ %t55, %merge1 ], [ %t495, %loop.latch4 ]
  %t509 = phi i8* [ %t51, %merge1 ], [ %t496, %loop.latch4 ]
  %t510 = phi i1 [ %t52, %merge1 ], [ %t497, %loop.latch4 ]
  %t511 = phi double [ %t56, %merge1 ], [ %t498, %loop.latch4 ]
  %t512 = phi i1 [ %t53, %merge1 ], [ %t499, %loop.latch4 ]
  %t513 = phi double [ %t57, %merge1 ], [ %t500, %loop.latch4 ]
  %t514 = phi double [ %t58, %merge1 ], [ %t501, %loop.latch4 ]
  store i8* %t502, i8** %l5
  store i1 %t503, i1* %l2
  store i1 %t504, i1* %l3
  store double %t505, double* %l9
  store { i8**, i64 }* %t506, { i8**, i64 }** %l1
  store i1 %t507, i1* %l4
  store double %t508, double* %l10
  store i8* %t509, i8** %l6
  store i1 %t510, i1* %l7
  store double %t511, double* %l11
  store i1 %t512, i1* %l8
  store double %t513, double* %l12
  store double %t514, double* %l13
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
  %t164 = add i64 0, 2
  %t165 = call i8* @malloc(i64 %t164)
  store i8 96, i8* %t165
  %t166 = getelementptr i8, i8* %t165, i64 1
  store i8 0, i8* %t166
  call void @sailfin_runtime_mark_persistent(i8* %t165)
  %t167 = call i8* @sailfin_runtime_string_concat(i8* %t163, i8* %t165)
  %t168 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t160, i8* %t167)
  store { i8**, i64 }* %t168, { i8**, i64 }** %l1
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge16
merge16:
  %t170 = phi i1 [ %t158, %then14 ], [ %t142, %else15 ]
  %t171 = phi double [ %t159, %then14 ], [ %t148, %else15 ]
  %t172 = phi { i8**, i64 }* [ %t140, %then14 ], [ %t169, %else15 ]
  store i1 %t170, i1* %l3
  store double %t171, double* %l9
  store { i8**, i64 }* %t172, { i8**, i64 }** %l1
  %t173 = load i1, i1* %l3
  %t174 = load double, double* %l9
  %t175 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
else12:
  %t176 = load i8*, i8** %l14
  %s177 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t178 = call i1 @starts_with(i8* %t176, i8* %s177)
  %t179 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t180 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t181 = load i1, i1* %l2
  %t182 = load i1, i1* %l3
  %t183 = load i1, i1* %l4
  %t184 = load i8*, i8** %l5
  %t185 = load i8*, i8** %l6
  %t186 = load i1, i1* %l7
  %t187 = load i1, i1* %l8
  %t188 = load double, double* %l9
  %t189 = load double, double* %l10
  %t190 = load double, double* %l11
  %t191 = load double, double* %l12
  %t192 = load double, double* %l13
  %t193 = load i8*, i8** %l14
  br i1 %t178, label %then17, label %else18
then17:
  %t194 = load i8*, i8** %l14
  %t195 = load i8*, i8** %l14
  %t196 = call i64 @sailfin_runtime_string_length(i8* %t195)
  %t197 = call i8* @sailfin_runtime_substring(i8* %t194, i64 6, i64 %t196)
  store i8* %t197, i8** %l17
  %t198 = load i8*, i8** %l17
  %t199 = call %NumberParseResult @parse_decimal_number(i8* %t198)
  store %NumberParseResult %t199, %NumberParseResult* %l18
  %t200 = load %NumberParseResult, %NumberParseResult* %l18
  %t201 = extractvalue %NumberParseResult %t200, 0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t204 = load i1, i1* %l2
  %t205 = load i1, i1* %l3
  %t206 = load i1, i1* %l4
  %t207 = load i8*, i8** %l5
  %t208 = load i8*, i8** %l6
  %t209 = load i1, i1* %l7
  %t210 = load i1, i1* %l8
  %t211 = load double, double* %l9
  %t212 = load double, double* %l10
  %t213 = load double, double* %l11
  %t214 = load double, double* %l12
  %t215 = load double, double* %l13
  %t216 = load i8*, i8** %l14
  %t217 = load i8*, i8** %l17
  %t218 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t201, label %then20, label %else21
then20:
  store i1 1, i1* %l4
  %t219 = load %NumberParseResult, %NumberParseResult* %l18
  %t220 = extractvalue %NumberParseResult %t219, 1
  store double %t220, double* %l10
  %t221 = load i1, i1* %l4
  %t222 = load double, double* %l10
  br label %merge22
else21:
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s224 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h1235260132, i32 0, i32 0
  %t225 = load i8*, i8** %l17
  %t226 = call i8* @sailfin_runtime_string_concat(i8* %s224, i8* %t225)
  %t227 = add i64 0, 2
  %t228 = call i8* @malloc(i64 %t227)
  store i8 96, i8* %t228
  %t229 = getelementptr i8, i8* %t228, i64 1
  store i8 0, i8* %t229
  call void @sailfin_runtime_mark_persistent(i8* %t228)
  %t230 = call i8* @sailfin_runtime_string_concat(i8* %t226, i8* %t228)
  %t231 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t223, i8* %t230)
  store { i8**, i64 }* %t231, { i8**, i64 }** %l1
  %t232 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge22
merge22:
  %t233 = phi i1 [ %t221, %then20 ], [ %t206, %else21 ]
  %t234 = phi double [ %t222, %then20 ], [ %t212, %else21 ]
  %t235 = phi { i8**, i64 }* [ %t203, %then20 ], [ %t232, %else21 ]
  store i1 %t233, i1* %l4
  store double %t234, double* %l10
  store { i8**, i64 }* %t235, { i8**, i64 }** %l1
  %t236 = load i1, i1* %l4
  %t237 = load double, double* %l10
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
else18:
  %t239 = load i8*, i8** %l14
  %s240 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1228988541, i32 0, i32 0
  %t241 = call i1 @starts_with(i8* %t239, i8* %s240)
  %t242 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t244 = load i1, i1* %l2
  %t245 = load i1, i1* %l3
  %t246 = load i1, i1* %l4
  %t247 = load i8*, i8** %l5
  %t248 = load i8*, i8** %l6
  %t249 = load i1, i1* %l7
  %t250 = load i1, i1* %l8
  %t251 = load double, double* %l9
  %t252 = load double, double* %l10
  %t253 = load double, double* %l11
  %t254 = load double, double* %l12
  %t255 = load double, double* %l13
  %t256 = load i8*, i8** %l14
  br i1 %t241, label %then23, label %else24
then23:
  %t257 = load i8*, i8** %l14
  %t258 = load i8*, i8** %l14
  %t259 = call i64 @sailfin_runtime_string_length(i8* %t258)
  %t260 = call i8* @sailfin_runtime_substring(i8* %t257, i64 9, i64 %t259)
  store i8* %t260, i8** %l6
  %t261 = load i8*, i8** %l6
  br label %merge25
else24:
  %t262 = load i8*, i8** %l14
  %s263 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1171237782, i32 0, i32 0
  %t264 = call i1 @starts_with(i8* %t262, i8* %s263)
  %t265 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t267 = load i1, i1* %l2
  %t268 = load i1, i1* %l3
  %t269 = load i1, i1* %l4
  %t270 = load i8*, i8** %l5
  %t271 = load i8*, i8** %l6
  %t272 = load i1, i1* %l7
  %t273 = load i1, i1* %l8
  %t274 = load double, double* %l9
  %t275 = load double, double* %l10
  %t276 = load double, double* %l11
  %t277 = load double, double* %l12
  %t278 = load double, double* %l13
  %t279 = load i8*, i8** %l14
  br i1 %t264, label %then26, label %else27
then26:
  %t280 = load i8*, i8** %l14
  %t281 = load i8*, i8** %l14
  %t282 = call i64 @sailfin_runtime_string_length(i8* %t281)
  %t283 = call i8* @sailfin_runtime_substring(i8* %t280, i64 9, i64 %t282)
  store i8* %t283, i8** %l19
  %t284 = load i8*, i8** %l19
  %t285 = call %NumberParseResult @parse_decimal_number(i8* %t284)
  store %NumberParseResult %t285, %NumberParseResult* %l20
  %t286 = load %NumberParseResult, %NumberParseResult* %l20
  %t287 = extractvalue %NumberParseResult %t286, 0
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t289 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t290 = load i1, i1* %l2
  %t291 = load i1, i1* %l3
  %t292 = load i1, i1* %l4
  %t293 = load i8*, i8** %l5
  %t294 = load i8*, i8** %l6
  %t295 = load i1, i1* %l7
  %t296 = load i1, i1* %l8
  %t297 = load double, double* %l9
  %t298 = load double, double* %l10
  %t299 = load double, double* %l11
  %t300 = load double, double* %l12
  %t301 = load double, double* %l13
  %t302 = load i8*, i8** %l14
  %t303 = load i8*, i8** %l19
  %t304 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t287, label %then29, label %else30
then29:
  store i1 1, i1* %l7
  %t305 = load %NumberParseResult, %NumberParseResult* %l20
  %t306 = extractvalue %NumberParseResult %t305, 1
  store double %t306, double* %l11
  %t307 = load i1, i1* %l7
  %t308 = load double, double* %l11
  br label %merge31
else30:
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s310 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h1384306956, i32 0, i32 0
  %t311 = load i8*, i8** %l19
  %t312 = call i8* @sailfin_runtime_string_concat(i8* %s310, i8* %t311)
  %t313 = add i64 0, 2
  %t314 = call i8* @malloc(i64 %t313)
  store i8 96, i8* %t314
  %t315 = getelementptr i8, i8* %t314, i64 1
  store i8 0, i8* %t315
  call void @sailfin_runtime_mark_persistent(i8* %t314)
  %t316 = call i8* @sailfin_runtime_string_concat(i8* %t312, i8* %t314)
  %t317 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t309, i8* %t316)
  store { i8**, i64 }* %t317, { i8**, i64 }** %l1
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge31
merge31:
  %t319 = phi i1 [ %t307, %then29 ], [ %t295, %else30 ]
  %t320 = phi double [ %t308, %then29 ], [ %t299, %else30 ]
  %t321 = phi { i8**, i64 }* [ %t289, %then29 ], [ %t318, %else30 ]
  store i1 %t319, i1* %l7
  store double %t320, double* %l11
  store { i8**, i64 }* %t321, { i8**, i64 }** %l1
  %t322 = load i1, i1* %l7
  %t323 = load double, double* %l11
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
else27:
  %t325 = load i8*, i8** %l14
  %s326 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h469410318, i32 0, i32 0
  %t327 = call i1 @starts_with(i8* %t325, i8* %s326)
  %t328 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t330 = load i1, i1* %l2
  %t331 = load i1, i1* %l3
  %t332 = load i1, i1* %l4
  %t333 = load i8*, i8** %l5
  %t334 = load i8*, i8** %l6
  %t335 = load i1, i1* %l7
  %t336 = load i1, i1* %l8
  %t337 = load double, double* %l9
  %t338 = load double, double* %l10
  %t339 = load double, double* %l11
  %t340 = load double, double* %l12
  %t341 = load double, double* %l13
  %t342 = load i8*, i8** %l14
  br i1 %t327, label %then32, label %else33
then32:
  %t343 = load i8*, i8** %l14
  %t344 = load i8*, i8** %l14
  %t345 = call i64 @sailfin_runtime_string_length(i8* %t344)
  %t346 = call i8* @sailfin_runtime_substring(i8* %t343, i64 10, i64 %t345)
  store i8* %t346, i8** %l21
  %t347 = load i8*, i8** %l21
  %t348 = call %NumberParseResult @parse_decimal_number(i8* %t347)
  store %NumberParseResult %t348, %NumberParseResult* %l22
  %t349 = load %NumberParseResult, %NumberParseResult* %l22
  %t350 = extractvalue %NumberParseResult %t349, 0
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t353 = load i1, i1* %l2
  %t354 = load i1, i1* %l3
  %t355 = load i1, i1* %l4
  %t356 = load i8*, i8** %l5
  %t357 = load i8*, i8** %l6
  %t358 = load i1, i1* %l7
  %t359 = load i1, i1* %l8
  %t360 = load double, double* %l9
  %t361 = load double, double* %l10
  %t362 = load double, double* %l11
  %t363 = load double, double* %l12
  %t364 = load double, double* %l13
  %t365 = load i8*, i8** %l14
  %t366 = load i8*, i8** %l21
  %t367 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t350, label %then35, label %else36
then35:
  store i1 1, i1* %l8
  %t368 = load %NumberParseResult, %NumberParseResult* %l22
  %t369 = extractvalue %NumberParseResult %t368, 1
  store double %t369, double* %l12
  %t370 = load i1, i1* %l8
  %t371 = load double, double* %l12
  br label %merge37
else36:
  %t372 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s373 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1171387022, i32 0, i32 0
  %t374 = load i8*, i8** %l21
  %t375 = call i8* @sailfin_runtime_string_concat(i8* %s373, i8* %t374)
  %t376 = add i64 0, 2
  %t377 = call i8* @malloc(i64 %t376)
  store i8 96, i8* %t377
  %t378 = getelementptr i8, i8* %t377, i64 1
  store i8 0, i8* %t378
  call void @sailfin_runtime_mark_persistent(i8* %t377)
  %t379 = call i8* @sailfin_runtime_string_concat(i8* %t375, i8* %t377)
  %t380 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t372, i8* %t379)
  store { i8**, i64 }* %t380, { i8**, i64 }** %l1
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t382 = phi i1 [ %t370, %then35 ], [ %t359, %else36 ]
  %t383 = phi double [ %t371, %then35 ], [ %t363, %else36 ]
  %t384 = phi { i8**, i64 }* [ %t352, %then35 ], [ %t381, %else36 ]
  store i1 %t382, i1* %l8
  store double %t383, double* %l12
  store { i8**, i64 }* %t384, { i8**, i64 }** %l1
  %t385 = load i1, i1* %l8
  %t386 = load double, double* %l12
  %t387 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
else33:
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s389 = getelementptr inbounds [40 x i8], [40 x i8]* @.str.len39.h598838653, i32 0, i32 0
  %t390 = load i8*, i8** %l14
  %t391 = call i8* @sailfin_runtime_string_concat(i8* %s389, i8* %t390)
  %t392 = add i64 0, 2
  %t393 = call i8* @malloc(i64 %t392)
  store i8 96, i8* %t393
  %t394 = getelementptr i8, i8* %t393, i64 1
  store i8 0, i8* %t394
  call void @sailfin_runtime_mark_persistent(i8* %t393)
  %t395 = call i8* @sailfin_runtime_string_concat(i8* %t391, i8* %t393)
  %t396 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t388, i8* %t395)
  store { i8**, i64 }* %t396, { i8**, i64 }** %l1
  %t397 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t398 = phi i1 [ %t385, %merge37 ], [ %t336, %else33 ]
  %t399 = phi double [ %t386, %merge37 ], [ %t340, %else33 ]
  %t400 = phi { i8**, i64 }* [ %t387, %merge37 ], [ %t397, %else33 ]
  store i1 %t398, i1* %l8
  store double %t399, double* %l12
  store { i8**, i64 }* %t400, { i8**, i64 }** %l1
  %t401 = load i1, i1* %l8
  %t402 = load double, double* %l12
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t404 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge28
merge28:
  %t405 = phi i1 [ %t322, %merge31 ], [ %t272, %merge34 ]
  %t406 = phi double [ %t323, %merge31 ], [ %t276, %merge34 ]
  %t407 = phi { i8**, i64 }* [ %t324, %merge31 ], [ %t403, %merge34 ]
  %t408 = phi i1 [ %t273, %merge31 ], [ %t401, %merge34 ]
  %t409 = phi double [ %t277, %merge31 ], [ %t402, %merge34 ]
  store i1 %t405, i1* %l7
  store double %t406, double* %l11
  store { i8**, i64 }* %t407, { i8**, i64 }** %l1
  store i1 %t408, i1* %l8
  store double %t409, double* %l12
  %t410 = load i1, i1* %l7
  %t411 = load double, double* %l11
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t413 = load i1, i1* %l8
  %t414 = load double, double* %l12
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t416 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge25
merge25:
  %t417 = phi i8* [ %t261, %then23 ], [ %t248, %merge28 ]
  %t418 = phi i1 [ %t249, %then23 ], [ %t410, %merge28 ]
  %t419 = phi double [ %t253, %then23 ], [ %t411, %merge28 ]
  %t420 = phi { i8**, i64 }* [ %t243, %then23 ], [ %t412, %merge28 ]
  %t421 = phi i1 [ %t250, %then23 ], [ %t413, %merge28 ]
  %t422 = phi double [ %t254, %then23 ], [ %t414, %merge28 ]
  store i8* %t417, i8** %l6
  store i1 %t418, i1* %l7
  store double %t419, double* %l11
  store { i8**, i64 }* %t420, { i8**, i64 }** %l1
  store i1 %t421, i1* %l8
  store double %t422, double* %l12
  %t423 = load i8*, i8** %l6
  %t424 = load i1, i1* %l7
  %t425 = load double, double* %l11
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t427 = load i1, i1* %l8
  %t428 = load double, double* %l12
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge19
merge19:
  %t431 = phi i1 [ %t236, %merge22 ], [ %t183, %merge25 ]
  %t432 = phi double [ %t237, %merge22 ], [ %t189, %merge25 ]
  %t433 = phi { i8**, i64 }* [ %t238, %merge22 ], [ %t426, %merge25 ]
  %t434 = phi i8* [ %t185, %merge22 ], [ %t423, %merge25 ]
  %t435 = phi i1 [ %t186, %merge22 ], [ %t424, %merge25 ]
  %t436 = phi double [ %t190, %merge22 ], [ %t425, %merge25 ]
  %t437 = phi i1 [ %t187, %merge22 ], [ %t427, %merge25 ]
  %t438 = phi double [ %t191, %merge22 ], [ %t428, %merge25 ]
  store i1 %t431, i1* %l4
  store double %t432, double* %l10
  store { i8**, i64 }* %t433, { i8**, i64 }** %l1
  store i8* %t434, i8** %l6
  store i1 %t435, i1* %l7
  store double %t436, double* %l11
  store i1 %t437, i1* %l8
  store double %t438, double* %l12
  %t439 = load i1, i1* %l4
  %t440 = load double, double* %l10
  %t441 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t442 = load i8*, i8** %l6
  %t443 = load i1, i1* %l7
  %t444 = load double, double* %l11
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t446 = load i1, i1* %l8
  %t447 = load double, double* %l12
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge13
merge13:
  %t450 = phi i1 [ %t173, %merge16 ], [ %t119, %merge19 ]
  %t451 = phi double [ %t174, %merge16 ], [ %t125, %merge19 ]
  %t452 = phi { i8**, i64 }* [ %t175, %merge16 ], [ %t441, %merge19 ]
  %t453 = phi i1 [ %t120, %merge16 ], [ %t439, %merge19 ]
  %t454 = phi double [ %t126, %merge16 ], [ %t440, %merge19 ]
  %t455 = phi i8* [ %t122, %merge16 ], [ %t442, %merge19 ]
  %t456 = phi i1 [ %t123, %merge16 ], [ %t443, %merge19 ]
  %t457 = phi double [ %t127, %merge16 ], [ %t444, %merge19 ]
  %t458 = phi i1 [ %t124, %merge16 ], [ %t446, %merge19 ]
  %t459 = phi double [ %t128, %merge16 ], [ %t447, %merge19 ]
  store i1 %t450, i1* %l3
  store double %t451, double* %l9
  store { i8**, i64 }* %t452, { i8**, i64 }** %l1
  store i1 %t453, i1* %l4
  store double %t454, double* %l10
  store i8* %t455, i8** %l6
  store i1 %t456, i1* %l7
  store double %t457, double* %l11
  store i1 %t458, i1* %l8
  store double %t459, double* %l12
  %t460 = load i1, i1* %l3
  %t461 = load double, double* %l9
  %t462 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t463 = load i1, i1* %l4
  %t464 = load double, double* %l10
  %t465 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t466 = load i8*, i8** %l6
  %t467 = load i1, i1* %l7
  %t468 = load double, double* %l11
  %t469 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t470 = load i1, i1* %l8
  %t471 = load double, double* %l12
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge10
merge10:
  %t474 = phi i8* [ %t111, %then8 ], [ %t97, %merge13 ]
  %t475 = phi i1 [ %t112, %then8 ], [ %t94, %merge13 ]
  %t476 = phi i1 [ %t95, %then8 ], [ %t460, %merge13 ]
  %t477 = phi double [ %t101, %then8 ], [ %t461, %merge13 ]
  %t478 = phi { i8**, i64 }* [ %t93, %then8 ], [ %t462, %merge13 ]
  %t479 = phi i1 [ %t96, %then8 ], [ %t463, %merge13 ]
  %t480 = phi double [ %t102, %then8 ], [ %t464, %merge13 ]
  %t481 = phi i8* [ %t98, %then8 ], [ %t466, %merge13 ]
  %t482 = phi i1 [ %t99, %then8 ], [ %t467, %merge13 ]
  %t483 = phi double [ %t103, %then8 ], [ %t468, %merge13 ]
  %t484 = phi i1 [ %t100, %then8 ], [ %t470, %merge13 ]
  %t485 = phi double [ %t104, %then8 ], [ %t471, %merge13 ]
  store i8* %t474, i8** %l5
  store i1 %t475, i1* %l2
  store i1 %t476, i1* %l3
  store double %t477, double* %l9
  store { i8**, i64 }* %t478, { i8**, i64 }** %l1
  store i1 %t479, i1* %l4
  store double %t480, double* %l10
  store i8* %t481, i8** %l6
  store i1 %t482, i1* %l7
  store double %t483, double* %l11
  store i1 %t484, i1* %l8
  store double %t485, double* %l12
  %t486 = load double, double* %l13
  %t487 = sitofp i64 1 to double
  %t488 = fadd double %t486, %t487
  store double %t488, double* %l13
  br label %loop.latch4
loop.latch4:
  %t489 = load i8*, i8** %l5
  %t490 = load i1, i1* %l2
  %t491 = load i1, i1* %l3
  %t492 = load double, double* %l9
  %t493 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t494 = load i1, i1* %l4
  %t495 = load double, double* %l10
  %t496 = load i8*, i8** %l6
  %t497 = load i1, i1* %l7
  %t498 = load double, double* %l11
  %t499 = load i1, i1* %l8
  %t500 = load double, double* %l12
  %t501 = load double, double* %l13
  br label %loop.header2
afterloop5:
  %t515 = load i8*, i8** %l5
  %t516 = load i1, i1* %l2
  %t517 = load i1, i1* %l3
  %t518 = load double, double* %l9
  %t519 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t520 = load i1, i1* %l4
  %t521 = load double, double* %l10
  %t522 = load i8*, i8** %l6
  %t523 = load i1, i1* %l7
  %t524 = load double, double* %l11
  %t525 = load i1, i1* %l8
  %t526 = load double, double* %l12
  %t527 = load double, double* %l13
  %t528 = load i1, i1* %l3
  %t529 = xor i1 %t528, 1
  %t530 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t532 = load i1, i1* %l2
  %t533 = load i1, i1* %l3
  %t534 = load i1, i1* %l4
  %t535 = load i8*, i8** %l5
  %t536 = load i8*, i8** %l6
  %t537 = load i1, i1* %l7
  %t538 = load i1, i1* %l8
  %t539 = load double, double* %l9
  %t540 = load double, double* %l10
  %t541 = load double, double* %l11
  %t542 = load double, double* %l12
  %t543 = load double, double* %l13
  br i1 %t529, label %then38, label %merge39
then38:
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s545 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h2038142650, i32 0, i32 0
  %t546 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t544, i8* %s545)
  store { i8**, i64 }* %t546, { i8**, i64 }** %l1
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t548 = phi { i8**, i64 }* [ %t547, %then38 ], [ %t531, %afterloop5 ]
  store { i8**, i64 }* %t548, { i8**, i64 }** %l1
  %t549 = load i1, i1* %l4
  %t550 = xor i1 %t549, 1
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t552 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t553 = load i1, i1* %l2
  %t554 = load i1, i1* %l3
  %t555 = load i1, i1* %l4
  %t556 = load i8*, i8** %l5
  %t557 = load i8*, i8** %l6
  %t558 = load i1, i1* %l7
  %t559 = load i1, i1* %l8
  %t560 = load double, double* %l9
  %t561 = load double, double* %l10
  %t562 = load double, double* %l11
  %t563 = load double, double* %l12
  %t564 = load double, double* %l13
  br i1 %t550, label %then40, label %merge41
then40:
  %t565 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s566 = getelementptr inbounds [39 x i8], [39 x i8]* @.str.len38.h2050661185, i32 0, i32 0
  %t567 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t565, i8* %s566)
  store { i8**, i64 }* %t567, { i8**, i64 }** %l1
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t569 = phi { i8**, i64 }* [ %t568, %then40 ], [ %t552, %merge39 ]
  store { i8**, i64 }* %t569, { i8**, i64 }** %l1
  %t570 = load i8*, i8** %l6
  %t571 = call i64 @sailfin_runtime_string_length(i8* %t570)
  %t572 = icmp eq i64 %t571, 0
  %t573 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t574 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t575 = load i1, i1* %l2
  %t576 = load i1, i1* %l3
  %t577 = load i1, i1* %l4
  %t578 = load i8*, i8** %l5
  %t579 = load i8*, i8** %l6
  %t580 = load i1, i1* %l7
  %t581 = load i1, i1* %l8
  %t582 = load double, double* %l9
  %t583 = load double, double* %l10
  %t584 = load double, double* %l11
  %t585 = load double, double* %l12
  %t586 = load double, double* %l13
  br i1 %t572, label %then42, label %merge43
then42:
  %t587 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s588 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h881857818, i32 0, i32 0
  %t589 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t587, i8* %s588)
  store { i8**, i64 }* %t589, { i8**, i64 }** %l1
  %t590 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t591 = phi { i8**, i64 }* [ %t590, %then42 ], [ %t574, %merge41 ]
  store { i8**, i64 }* %t591, { i8**, i64 }** %l1
  %t592 = load i1, i1* %l7
  %t593 = xor i1 %t592, 1
  %t594 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t595 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t596 = load i1, i1* %l2
  %t597 = load i1, i1* %l3
  %t598 = load i1, i1* %l4
  %t599 = load i8*, i8** %l5
  %t600 = load i8*, i8** %l6
  %t601 = load i1, i1* %l7
  %t602 = load i1, i1* %l8
  %t603 = load double, double* %l9
  %t604 = load double, double* %l10
  %t605 = load double, double* %l11
  %t606 = load double, double* %l12
  %t607 = load double, double* %l13
  br i1 %t593, label %then44, label %merge45
then44:
  %t608 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s609 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h2069276858, i32 0, i32 0
  %t610 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t608, i8* %s609)
  store { i8**, i64 }* %t610, { i8**, i64 }** %l1
  %t611 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t612 = phi { i8**, i64 }* [ %t611, %then44 ], [ %t595, %merge43 ]
  store { i8**, i64 }* %t612, { i8**, i64 }** %l1
  %t613 = load i1, i1* %l8
  %t614 = xor i1 %t613, 1
  %t615 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t616 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t617 = load i1, i1* %l2
  %t618 = load i1, i1* %l3
  %t619 = load i1, i1* %l4
  %t620 = load i8*, i8** %l5
  %t621 = load i8*, i8** %l6
  %t622 = load i1, i1* %l7
  %t623 = load i1, i1* %l8
  %t624 = load double, double* %l9
  %t625 = load double, double* %l10
  %t626 = load double, double* %l11
  %t627 = load double, double* %l12
  %t628 = load double, double* %l13
  br i1 %t614, label %then46, label %merge47
then46:
  %t629 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s630 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h930606274, i32 0, i32 0
  %t631 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t629, i8* %s630)
  store { i8**, i64 }* %t631, { i8**, i64 }** %l1
  %t632 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge47
merge47:
  %t633 = phi { i8**, i64 }* [ %t632, %then46 ], [ %t616, %merge45 ]
  store { i8**, i64 }* %t633, { i8**, i64 }** %l1
  %t635 = load i1, i1* %l3
  br label %logical_and_entry_634

logical_and_entry_634:
  br i1 %t635, label %logical_and_right_634, label %logical_and_merge_634

logical_and_right_634:
  %t637 = load i1, i1* %l4
  br label %logical_and_entry_636

logical_and_entry_636:
  br i1 %t637, label %logical_and_right_636, label %logical_and_merge_636

logical_and_right_636:
  %t639 = load i8*, i8** %l6
  %t640 = call i64 @sailfin_runtime_string_length(i8* %t639)
  %t641 = icmp sgt i64 %t640, 0
  br label %logical_and_entry_638

logical_and_entry_638:
  br i1 %t641, label %logical_and_right_638, label %logical_and_merge_638

logical_and_right_638:
  %t643 = load i1, i1* %l7
  br label %logical_and_entry_642

logical_and_entry_642:
  br i1 %t643, label %logical_and_right_642, label %logical_and_merge_642

logical_and_right_642:
  %t645 = load i1, i1* %l8
  br label %logical_and_entry_644

logical_and_entry_644:
  br i1 %t645, label %logical_and_right_644, label %logical_and_merge_644

logical_and_right_644:
  %t646 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t647 = load { i8**, i64 }, { i8**, i64 }* %t646
  %t648 = extractvalue { i8**, i64 } %t647, 1
  %t649 = icmp eq i64 %t648, 0
  br label %logical_and_right_end_644

logical_and_right_end_644:
  br label %logical_and_merge_644

logical_and_merge_644:
  %t650 = phi i1 [ false, %logical_and_entry_644 ], [ %t649, %logical_and_right_end_644 ]
  br label %logical_and_right_end_642

logical_and_right_end_642:
  br label %logical_and_merge_642

logical_and_merge_642:
  %t651 = phi i1 [ false, %logical_and_entry_642 ], [ %t650, %logical_and_right_end_642 ]
  br label %logical_and_right_end_638

logical_and_right_end_638:
  br label %logical_and_merge_638

logical_and_merge_638:
  %t652 = phi i1 [ false, %logical_and_entry_638 ], [ %t651, %logical_and_right_end_638 ]
  br label %logical_and_right_end_636

logical_and_right_end_636:
  br label %logical_and_merge_636

logical_and_merge_636:
  %t653 = phi i1 [ false, %logical_and_entry_636 ], [ %t652, %logical_and_right_end_636 ]
  br label %logical_and_right_end_634

logical_and_right_end_634:
  br label %logical_and_merge_634

logical_and_merge_634:
  %t654 = phi i1 [ false, %logical_and_entry_634 ], [ %t653, %logical_and_right_end_634 ]
  store i1 %t654, i1* %l23
  %t655 = load i1, i1* %l23
  %t656 = insertvalue %EnumLayoutHeaderParse undef, i1 %t655, 0
  %t657 = load i8*, i8** %l5
  %t658 = insertvalue %EnumLayoutHeaderParse %t656, i8* %t657, 1
  %t659 = load double, double* %l9
  %t660 = insertvalue %EnumLayoutHeaderParse %t658, double %t659, 2
  %t661 = load double, double* %l10
  %t662 = insertvalue %EnumLayoutHeaderParse %t660, double %t661, 3
  %t663 = load i8*, i8** %l6
  %t664 = insertvalue %EnumLayoutHeaderParse %t662, i8* %t663, 4
  %t665 = load double, double* %l11
  %t666 = insertvalue %EnumLayoutHeaderParse %t664, double %t665, 5
  %t667 = load double, double* %l12
  %t668 = insertvalue %EnumLayoutHeaderParse %t666, double %t667, 6
  %t669 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t670 = insertvalue %EnumLayoutHeaderParse %t668, { i8**, i64 }* %t669, 7
  ret %EnumLayoutHeaderParse %t670
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t23 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t24 = ptrtoint [0 x %NativeStructLayoutField]* %t23 to i64
  %t25 = icmp eq i64 %t24, 0
  %t26 = select i1 %t25, i64 1, i64 %t24
  %t27 = call i8* @malloc(i64 %t26)
  %t28 = bitcast i8* %t27 to %NativeStructLayoutField*
  %t29 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t30 = ptrtoint { %NativeStructLayoutField*, i64 }* %t29 to i64
  %t31 = call i8* @malloc(i64 %t30)
  %t32 = bitcast i8* %t31 to { %NativeStructLayoutField*, i64 }*
  %t33 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t32, i32 0, i32 0
  store %NativeStructLayoutField* %t28, %NativeStructLayoutField** %t33
  %t34 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t32, i32 0, i32 1
  store i64 0, i64* %t34
  %t35 = insertvalue %NativeEnumVariantLayout %t22, { %NativeStructLayoutField*, i64 }* %t32, 5
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
  %t504 = phi i1 [ %t110, %merge5 ], [ %t494, %loop.latch8 ]
  %t505 = phi double [ %t114, %merge5 ], [ %t495, %loop.latch8 ]
  %t506 = phi { i8**, i64 }* [ %t106, %merge5 ], [ %t496, %loop.latch8 ]
  %t507 = phi i1 [ %t111, %merge5 ], [ %t497, %loop.latch8 ]
  %t508 = phi double [ %t115, %merge5 ], [ %t498, %loop.latch8 ]
  %t509 = phi i1 [ %t112, %merge5 ], [ %t499, %loop.latch8 ]
  %t510 = phi double [ %t116, %merge5 ], [ %t500, %loop.latch8 ]
  %t511 = phi i1 [ %t113, %merge5 ], [ %t501, %loop.latch8 ]
  %t512 = phi double [ %t117, %merge5 ], [ %t502, %loop.latch8 ]
  %t513 = phi double [ %t118, %merge5 ], [ %t503, %loop.latch8 ]
  store i1 %t504, i1* %l5
  store double %t505, double* %l9
  store { i8**, i64 }* %t506, { i8**, i64 }** %l1
  store i1 %t507, i1* %l6
  store double %t508, double* %l10
  store i1 %t509, i1* %l7
  store double %t510, double* %l11
  store i1 %t511, i1* %l8
  store double %t512, double* %l12
  store double %t513, double* %l13
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
  %t207 = add i64 0, 2
  %t208 = call i8* @malloc(i64 %t207)
  store i8 96, i8* %t208
  %t209 = getelementptr i8, i8* %t208, i64 1
  store i8 0, i8* %t209
  call void @sailfin_runtime_mark_persistent(i8* %t208)
  %t210 = call i8* @sailfin_runtime_string_concat(i8* %t206, i8* %t208)
  %t211 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t196, i8* %t210)
  store { i8**, i64 }* %t211, { i8**, i64 }** %l1
  %t212 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t213 = phi i1 [ %t194, %then15 ], [ %t180, %else16 ]
  %t214 = phi double [ %t195, %then15 ], [ %t184, %else16 ]
  %t215 = phi { i8**, i64 }* [ %t176, %then15 ], [ %t212, %else16 ]
  store i1 %t213, i1* %l5
  store double %t214, double* %l9
  store { i8**, i64 }* %t215, { i8**, i64 }** %l1
  %t216 = load i1, i1* %l5
  %t217 = load double, double* %l9
  %t218 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
else13:
  %t219 = load i8*, i8** %l14
  %s220 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t221 = call i1 @starts_with(i8* %t219, i8* %s220)
  %t222 = load i8*, i8** %l0
  %t223 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t224 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t225 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t226 = load i8*, i8** %l4
  %t227 = load i1, i1* %l5
  %t228 = load i1, i1* %l6
  %t229 = load i1, i1* %l7
  %t230 = load i1, i1* %l8
  %t231 = load double, double* %l9
  %t232 = load double, double* %l10
  %t233 = load double, double* %l11
  %t234 = load double, double* %l12
  %t235 = load double, double* %l13
  %t236 = load i8*, i8** %l14
  br i1 %t221, label %then18, label %else19
then18:
  %t237 = load i8*, i8** %l14
  %t238 = load i8*, i8** %l14
  %t239 = call i64 @sailfin_runtime_string_length(i8* %t238)
  %t240 = call i8* @sailfin_runtime_substring(i8* %t237, i64 7, i64 %t239)
  store i8* %t240, i8** %l17
  %t241 = load i8*, i8** %l17
  %t242 = call %NumberParseResult @parse_decimal_number(i8* %t241)
  store %NumberParseResult %t242, %NumberParseResult* %l18
  %t243 = load %NumberParseResult, %NumberParseResult* %l18
  %t244 = extractvalue %NumberParseResult %t243, 0
  %t245 = load i8*, i8** %l0
  %t246 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t247 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t249 = load i8*, i8** %l4
  %t250 = load i1, i1* %l5
  %t251 = load i1, i1* %l6
  %t252 = load i1, i1* %l7
  %t253 = load i1, i1* %l8
  %t254 = load double, double* %l9
  %t255 = load double, double* %l10
  %t256 = load double, double* %l11
  %t257 = load double, double* %l12
  %t258 = load double, double* %l13
  %t259 = load i8*, i8** %l14
  %t260 = load i8*, i8** %l17
  %t261 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t244, label %then21, label %else22
then21:
  store i1 1, i1* %l6
  %t262 = load %NumberParseResult, %NumberParseResult* %l18
  %t263 = extractvalue %NumberParseResult %t262, 1
  store double %t263, double* %l10
  %t264 = load i1, i1* %l6
  %t265 = load double, double* %l10
  br label %merge23
else22:
  %t266 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s267 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t268 = call i8* @sailfin_runtime_string_concat(i8* %s267, i8* %enum_name)
  %s269 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t270 = call i8* @sailfin_runtime_string_concat(i8* %t268, i8* %s269)
  %t271 = load i8*, i8** %l4
  %t272 = call i8* @sailfin_runtime_string_concat(i8* %t270, i8* %t271)
  %s273 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t274 = call i8* @sailfin_runtime_string_concat(i8* %t272, i8* %s273)
  %t275 = load i8*, i8** %l17
  %t276 = call i8* @sailfin_runtime_string_concat(i8* %t274, i8* %t275)
  %t277 = add i64 0, 2
  %t278 = call i8* @malloc(i64 %t277)
  store i8 96, i8* %t278
  %t279 = getelementptr i8, i8* %t278, i64 1
  store i8 0, i8* %t279
  call void @sailfin_runtime_mark_persistent(i8* %t278)
  %t280 = call i8* @sailfin_runtime_string_concat(i8* %t276, i8* %t278)
  %t281 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t266, i8* %t280)
  store { i8**, i64 }* %t281, { i8**, i64 }** %l1
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t283 = phi i1 [ %t264, %then21 ], [ %t251, %else22 ]
  %t284 = phi double [ %t265, %then21 ], [ %t255, %else22 ]
  %t285 = phi { i8**, i64 }* [ %t246, %then21 ], [ %t282, %else22 ]
  store i1 %t283, i1* %l6
  store double %t284, double* %l10
  store { i8**, i64 }* %t285, { i8**, i64 }** %l1
  %t286 = load i1, i1* %l6
  %t287 = load double, double* %l10
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
else19:
  %t289 = load i8*, i8** %l14
  %s290 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t291 = call i1 @starts_with(i8* %t289, i8* %s290)
  %t292 = load i8*, i8** %l0
  %t293 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t294 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t295 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t296 = load i8*, i8** %l4
  %t297 = load i1, i1* %l5
  %t298 = load i1, i1* %l6
  %t299 = load i1, i1* %l7
  %t300 = load i1, i1* %l8
  %t301 = load double, double* %l9
  %t302 = load double, double* %l10
  %t303 = load double, double* %l11
  %t304 = load double, double* %l12
  %t305 = load double, double* %l13
  %t306 = load i8*, i8** %l14
  br i1 %t291, label %then24, label %else25
then24:
  %t307 = load i8*, i8** %l14
  %t308 = load i8*, i8** %l14
  %t309 = call i64 @sailfin_runtime_string_length(i8* %t308)
  %t310 = call i8* @sailfin_runtime_substring(i8* %t307, i64 5, i64 %t309)
  store i8* %t310, i8** %l19
  %t311 = load i8*, i8** %l19
  %t312 = call %NumberParseResult @parse_decimal_number(i8* %t311)
  store %NumberParseResult %t312, %NumberParseResult* %l20
  %t313 = load %NumberParseResult, %NumberParseResult* %l20
  %t314 = extractvalue %NumberParseResult %t313, 0
  %t315 = load i8*, i8** %l0
  %t316 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t317 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t318 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t319 = load i8*, i8** %l4
  %t320 = load i1, i1* %l5
  %t321 = load i1, i1* %l6
  %t322 = load i1, i1* %l7
  %t323 = load i1, i1* %l8
  %t324 = load double, double* %l9
  %t325 = load double, double* %l10
  %t326 = load double, double* %l11
  %t327 = load double, double* %l12
  %t328 = load double, double* %l13
  %t329 = load i8*, i8** %l14
  %t330 = load i8*, i8** %l19
  %t331 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t314, label %then27, label %else28
then27:
  store i1 1, i1* %l7
  %t332 = load %NumberParseResult, %NumberParseResult* %l20
  %t333 = extractvalue %NumberParseResult %t332, 1
  store double %t333, double* %l11
  %t334 = load i1, i1* %l7
  %t335 = load double, double* %l11
  br label %merge29
else28:
  %t336 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s337 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t338 = call i8* @sailfin_runtime_string_concat(i8* %s337, i8* %enum_name)
  %s339 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t340 = call i8* @sailfin_runtime_string_concat(i8* %t338, i8* %s339)
  %t341 = load i8*, i8** %l4
  %t342 = call i8* @sailfin_runtime_string_concat(i8* %t340, i8* %t341)
  %s343 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t344 = call i8* @sailfin_runtime_string_concat(i8* %t342, i8* %s343)
  %t345 = load i8*, i8** %l19
  %t346 = call i8* @sailfin_runtime_string_concat(i8* %t344, i8* %t345)
  %t347 = add i64 0, 2
  %t348 = call i8* @malloc(i64 %t347)
  store i8 96, i8* %t348
  %t349 = getelementptr i8, i8* %t348, i64 1
  store i8 0, i8* %t349
  call void @sailfin_runtime_mark_persistent(i8* %t348)
  %t350 = call i8* @sailfin_runtime_string_concat(i8* %t346, i8* %t348)
  %t351 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t336, i8* %t350)
  store { i8**, i64 }* %t351, { i8**, i64 }** %l1
  %t352 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t353 = phi i1 [ %t334, %then27 ], [ %t322, %else28 ]
  %t354 = phi double [ %t335, %then27 ], [ %t326, %else28 ]
  %t355 = phi { i8**, i64 }* [ %t316, %then27 ], [ %t352, %else28 ]
  store i1 %t353, i1* %l7
  store double %t354, double* %l11
  store { i8**, i64 }* %t355, { i8**, i64 }** %l1
  %t356 = load i1, i1* %l7
  %t357 = load double, double* %l11
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
else25:
  %t359 = load i8*, i8** %l14
  %s360 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t361 = call i1 @starts_with(i8* %t359, i8* %s360)
  %t362 = load i8*, i8** %l0
  %t363 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t364 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t365 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t366 = load i8*, i8** %l4
  %t367 = load i1, i1* %l5
  %t368 = load i1, i1* %l6
  %t369 = load i1, i1* %l7
  %t370 = load i1, i1* %l8
  %t371 = load double, double* %l9
  %t372 = load double, double* %l10
  %t373 = load double, double* %l11
  %t374 = load double, double* %l12
  %t375 = load double, double* %l13
  %t376 = load i8*, i8** %l14
  br i1 %t361, label %then30, label %else31
then30:
  %t377 = load i8*, i8** %l14
  %t378 = load i8*, i8** %l14
  %t379 = call i64 @sailfin_runtime_string_length(i8* %t378)
  %t380 = call i8* @sailfin_runtime_substring(i8* %t377, i64 6, i64 %t379)
  store i8* %t380, i8** %l21
  %t381 = load i8*, i8** %l21
  %t382 = call %NumberParseResult @parse_decimal_number(i8* %t381)
  store %NumberParseResult %t382, %NumberParseResult* %l22
  %t383 = load %NumberParseResult, %NumberParseResult* %l22
  %t384 = extractvalue %NumberParseResult %t383, 0
  %t385 = load i8*, i8** %l0
  %t386 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t387 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t388 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t389 = load i8*, i8** %l4
  %t390 = load i1, i1* %l5
  %t391 = load i1, i1* %l6
  %t392 = load i1, i1* %l7
  %t393 = load i1, i1* %l8
  %t394 = load double, double* %l9
  %t395 = load double, double* %l10
  %t396 = load double, double* %l11
  %t397 = load double, double* %l12
  %t398 = load double, double* %l13
  %t399 = load i8*, i8** %l14
  %t400 = load i8*, i8** %l21
  %t401 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t384, label %then33, label %else34
then33:
  store i1 1, i1* %l8
  %t402 = load %NumberParseResult, %NumberParseResult* %l22
  %t403 = extractvalue %NumberParseResult %t402, 1
  store double %t403, double* %l12
  %t404 = load i1, i1* %l8
  %t405 = load double, double* %l12
  br label %merge35
else34:
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s407 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t408 = call i8* @sailfin_runtime_string_concat(i8* %s407, i8* %enum_name)
  %s409 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t410 = call i8* @sailfin_runtime_string_concat(i8* %t408, i8* %s409)
  %t411 = load i8*, i8** %l4
  %t412 = call i8* @sailfin_runtime_string_concat(i8* %t410, i8* %t411)
  %s413 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t414 = call i8* @sailfin_runtime_string_concat(i8* %t412, i8* %s413)
  %t415 = load i8*, i8** %l21
  %t416 = call i8* @sailfin_runtime_string_concat(i8* %t414, i8* %t415)
  %t417 = add i64 0, 2
  %t418 = call i8* @malloc(i64 %t417)
  store i8 96, i8* %t418
  %t419 = getelementptr i8, i8* %t418, i64 1
  store i8 0, i8* %t419
  call void @sailfin_runtime_mark_persistent(i8* %t418)
  %t420 = call i8* @sailfin_runtime_string_concat(i8* %t416, i8* %t418)
  %t421 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t406, i8* %t420)
  store { i8**, i64 }* %t421, { i8**, i64 }** %l1
  %t422 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge35
merge35:
  %t423 = phi i1 [ %t404, %then33 ], [ %t393, %else34 ]
  %t424 = phi double [ %t405, %then33 ], [ %t397, %else34 ]
  %t425 = phi { i8**, i64 }* [ %t386, %then33 ], [ %t422, %else34 ]
  store i1 %t423, i1* %l8
  store double %t424, double* %l12
  store { i8**, i64 }* %t425, { i8**, i64 }** %l1
  %t426 = load i1, i1* %l8
  %t427 = load double, double* %l12
  %t428 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
else31:
  %t429 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s430 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t431 = call i8* @sailfin_runtime_string_concat(i8* %s430, i8* %enum_name)
  %s432 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t433 = call i8* @sailfin_runtime_string_concat(i8* %t431, i8* %s432)
  %t434 = load i8*, i8** %l4
  %t435 = call i8* @sailfin_runtime_string_concat(i8* %t433, i8* %t434)
  %s436 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t437 = call i8* @sailfin_runtime_string_concat(i8* %t435, i8* %s436)
  %t438 = load i8*, i8** %l14
  %t439 = call i8* @sailfin_runtime_string_concat(i8* %t437, i8* %t438)
  %t440 = add i64 0, 2
  %t441 = call i8* @malloc(i64 %t440)
  store i8 96, i8* %t441
  %t442 = getelementptr i8, i8* %t441, i64 1
  store i8 0, i8* %t442
  call void @sailfin_runtime_mark_persistent(i8* %t441)
  %t443 = call i8* @sailfin_runtime_string_concat(i8* %t439, i8* %t441)
  %t444 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t429, i8* %t443)
  store { i8**, i64 }* %t444, { i8**, i64 }** %l1
  %t445 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t446 = phi i1 [ %t426, %merge35 ], [ %t370, %else31 ]
  %t447 = phi double [ %t427, %merge35 ], [ %t374, %else31 ]
  %t448 = phi { i8**, i64 }* [ %t428, %merge35 ], [ %t445, %else31 ]
  store i1 %t446, i1* %l8
  store double %t447, double* %l12
  store { i8**, i64 }* %t448, { i8**, i64 }** %l1
  %t449 = load i1, i1* %l8
  %t450 = load double, double* %l12
  %t451 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t452 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t453 = phi i1 [ %t356, %merge29 ], [ %t299, %merge32 ]
  %t454 = phi double [ %t357, %merge29 ], [ %t303, %merge32 ]
  %t455 = phi { i8**, i64 }* [ %t358, %merge29 ], [ %t451, %merge32 ]
  %t456 = phi i1 [ %t300, %merge29 ], [ %t449, %merge32 ]
  %t457 = phi double [ %t304, %merge29 ], [ %t450, %merge32 ]
  store i1 %t453, i1* %l7
  store double %t454, double* %l11
  store { i8**, i64 }* %t455, { i8**, i64 }** %l1
  store i1 %t456, i1* %l8
  store double %t457, double* %l12
  %t458 = load i1, i1* %l7
  %t459 = load double, double* %l11
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t461 = load i1, i1* %l8
  %t462 = load double, double* %l12
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t464 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t465 = phi i1 [ %t286, %merge23 ], [ %t228, %merge26 ]
  %t466 = phi double [ %t287, %merge23 ], [ %t232, %merge26 ]
  %t467 = phi { i8**, i64 }* [ %t288, %merge23 ], [ %t460, %merge26 ]
  %t468 = phi i1 [ %t229, %merge23 ], [ %t458, %merge26 ]
  %t469 = phi double [ %t233, %merge23 ], [ %t459, %merge26 ]
  %t470 = phi i1 [ %t230, %merge23 ], [ %t461, %merge26 ]
  %t471 = phi double [ %t234, %merge23 ], [ %t462, %merge26 ]
  store i1 %t465, i1* %l6
  store double %t466, double* %l10
  store { i8**, i64 }* %t467, { i8**, i64 }** %l1
  store i1 %t468, i1* %l7
  store double %t469, double* %l11
  store i1 %t470, i1* %l8
  store double %t471, double* %l12
  %t472 = load i1, i1* %l6
  %t473 = load double, double* %l10
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t475 = load i1, i1* %l7
  %t476 = load double, double* %l11
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t478 = load i1, i1* %l8
  %t479 = load double, double* %l12
  %t480 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t481 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t482 = phi i1 [ %t216, %merge17 ], [ %t157, %merge20 ]
  %t483 = phi double [ %t217, %merge17 ], [ %t161, %merge20 ]
  %t484 = phi { i8**, i64 }* [ %t218, %merge17 ], [ %t474, %merge20 ]
  %t485 = phi i1 [ %t158, %merge17 ], [ %t472, %merge20 ]
  %t486 = phi double [ %t162, %merge17 ], [ %t473, %merge20 ]
  %t487 = phi i1 [ %t159, %merge17 ], [ %t475, %merge20 ]
  %t488 = phi double [ %t163, %merge17 ], [ %t476, %merge20 ]
  %t489 = phi i1 [ %t160, %merge17 ], [ %t478, %merge20 ]
  %t490 = phi double [ %t164, %merge17 ], [ %t479, %merge20 ]
  store i1 %t482, i1* %l5
  store double %t483, double* %l9
  store { i8**, i64 }* %t484, { i8**, i64 }** %l1
  store i1 %t485, i1* %l6
  store double %t486, double* %l10
  store i1 %t487, i1* %l7
  store double %t488, double* %l11
  store i1 %t489, i1* %l8
  store double %t490, double* %l12
  %t491 = load double, double* %l13
  %t492 = sitofp i64 1 to double
  %t493 = fadd double %t491, %t492
  store double %t493, double* %l13
  br label %loop.latch8
loop.latch8:
  %t494 = load i1, i1* %l5
  %t495 = load double, double* %l9
  %t496 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t497 = load i1, i1* %l6
  %t498 = load double, double* %l10
  %t499 = load i1, i1* %l7
  %t500 = load double, double* %l11
  %t501 = load i1, i1* %l8
  %t502 = load double, double* %l12
  %t503 = load double, double* %l13
  br label %loop.header6
afterloop9:
  %t514 = load i1, i1* %l5
  %t515 = load double, double* %l9
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t517 = load i1, i1* %l6
  %t518 = load double, double* %l10
  %t519 = load i1, i1* %l7
  %t520 = load double, double* %l11
  %t521 = load i1, i1* %l8
  %t522 = load double, double* %l12
  %t523 = load double, double* %l13
  %t524 = load i1, i1* %l5
  %t525 = xor i1 %t524, 1
  %t526 = load i8*, i8** %l0
  %t527 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t528 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t529 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t530 = load i8*, i8** %l4
  %t531 = load i1, i1* %l5
  %t532 = load i1, i1* %l6
  %t533 = load i1, i1* %l7
  %t534 = load i1, i1* %l8
  %t535 = load double, double* %l9
  %t536 = load double, double* %l10
  %t537 = load double, double* %l11
  %t538 = load double, double* %l12
  %t539 = load double, double* %l13
  br i1 %t525, label %then36, label %merge37
then36:
  %t540 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s541 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t542 = call i8* @sailfin_runtime_string_concat(i8* %s541, i8* %enum_name)
  %s543 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t544 = call i8* @sailfin_runtime_string_concat(i8* %t542, i8* %s543)
  %t545 = load i8*, i8** %l4
  %t546 = call i8* @sailfin_runtime_string_concat(i8* %t544, i8* %t545)
  %s547 = getelementptr inbounds [20 x i8], [20 x i8]* @.str.len19.h1697653870, i32 0, i32 0
  %t548 = call i8* @sailfin_runtime_string_concat(i8* %t546, i8* %s547)
  %t549 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t540, i8* %t548)
  store { i8**, i64 }* %t549, { i8**, i64 }** %l1
  %t550 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge37
merge37:
  %t551 = phi { i8**, i64 }* [ %t550, %then36 ], [ %t527, %afterloop9 ]
  store { i8**, i64 }* %t551, { i8**, i64 }** %l1
  %t552 = load i1, i1* %l6
  %t553 = xor i1 %t552, 1
  %t554 = load i8*, i8** %l0
  %t555 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t556 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t557 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t558 = load i8*, i8** %l4
  %t559 = load i1, i1* %l5
  %t560 = load i1, i1* %l6
  %t561 = load i1, i1* %l7
  %t562 = load i1, i1* %l8
  %t563 = load double, double* %l9
  %t564 = load double, double* %l10
  %t565 = load double, double* %l11
  %t566 = load double, double* %l12
  %t567 = load double, double* %l13
  br i1 %t553, label %then38, label %merge39
then38:
  %t568 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s569 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t570 = call i8* @sailfin_runtime_string_concat(i8* %s569, i8* %enum_name)
  %s571 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t572 = call i8* @sailfin_runtime_string_concat(i8* %t570, i8* %s571)
  %t573 = load i8*, i8** %l4
  %t574 = call i8* @sailfin_runtime_string_concat(i8* %t572, i8* %t573)
  %s575 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t576 = call i8* @sailfin_runtime_string_concat(i8* %t574, i8* %s575)
  %t577 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t568, i8* %t576)
  store { i8**, i64 }* %t577, { i8**, i64 }** %l1
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge39
merge39:
  %t579 = phi { i8**, i64 }* [ %t578, %then38 ], [ %t555, %merge37 ]
  store { i8**, i64 }* %t579, { i8**, i64 }** %l1
  %t580 = load i1, i1* %l7
  %t581 = xor i1 %t580, 1
  %t582 = load i8*, i8** %l0
  %t583 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t584 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t585 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t586 = load i8*, i8** %l4
  %t587 = load i1, i1* %l5
  %t588 = load i1, i1* %l6
  %t589 = load i1, i1* %l7
  %t590 = load i1, i1* %l8
  %t591 = load double, double* %l9
  %t592 = load double, double* %l10
  %t593 = load double, double* %l11
  %t594 = load double, double* %l12
  %t595 = load double, double* %l13
  br i1 %t581, label %then40, label %merge41
then40:
  %t596 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s597 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t598 = call i8* @sailfin_runtime_string_concat(i8* %s597, i8* %enum_name)
  %s599 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t600 = call i8* @sailfin_runtime_string_concat(i8* %t598, i8* %s599)
  %t601 = load i8*, i8** %l4
  %t602 = call i8* @sailfin_runtime_string_concat(i8* %t600, i8* %t601)
  %s603 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t604 = call i8* @sailfin_runtime_string_concat(i8* %t602, i8* %s603)
  %t605 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t596, i8* %t604)
  store { i8**, i64 }* %t605, { i8**, i64 }** %l1
  %t606 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge41
merge41:
  %t607 = phi { i8**, i64 }* [ %t606, %then40 ], [ %t583, %merge39 ]
  store { i8**, i64 }* %t607, { i8**, i64 }** %l1
  %t608 = load i1, i1* %l8
  %t609 = xor i1 %t608, 1
  %t610 = load i8*, i8** %l0
  %t611 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t612 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l2
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t614 = load i8*, i8** %l4
  %t615 = load i1, i1* %l5
  %t616 = load i1, i1* %l6
  %t617 = load i1, i1* %l7
  %t618 = load i1, i1* %l8
  %t619 = load double, double* %l9
  %t620 = load double, double* %l10
  %t621 = load double, double* %l11
  %t622 = load double, double* %l12
  %t623 = load double, double* %l13
  br i1 %t609, label %then42, label %merge43
then42:
  %t624 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s625 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t626 = call i8* @sailfin_runtime_string_concat(i8* %s625, i8* %enum_name)
  %s627 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h293109504, i32 0, i32 0
  %t628 = call i8* @sailfin_runtime_string_concat(i8* %t626, i8* %s627)
  %t629 = load i8*, i8** %l4
  %t630 = call i8* @sailfin_runtime_string_concat(i8* %t628, i8* %t629)
  %s631 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t632 = call i8* @sailfin_runtime_string_concat(i8* %t630, i8* %s631)
  %t633 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t624, i8* %t632)
  store { i8**, i64 }* %t633, { i8**, i64 }** %l1
  %t634 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge43
merge43:
  %t635 = phi { i8**, i64 }* [ %t634, %then42 ], [ %t611, %merge41 ]
  store { i8**, i64 }* %t635, { i8**, i64 }** %l1
  %t637 = load i1, i1* %l5
  br label %logical_and_entry_636

logical_and_entry_636:
  br i1 %t637, label %logical_and_right_636, label %logical_and_merge_636

logical_and_right_636:
  %t639 = load i1, i1* %l6
  br label %logical_and_entry_638

logical_and_entry_638:
  br i1 %t639, label %logical_and_right_638, label %logical_and_merge_638

logical_and_right_638:
  %t641 = load i1, i1* %l7
  br label %logical_and_entry_640

logical_and_entry_640:
  br i1 %t641, label %logical_and_right_640, label %logical_and_merge_640

logical_and_right_640:
  %t643 = load i1, i1* %l8
  br label %logical_and_entry_642

logical_and_entry_642:
  br i1 %t643, label %logical_and_right_642, label %logical_and_merge_642

logical_and_right_642:
  %t644 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t645 = load { i8**, i64 }, { i8**, i64 }* %t644
  %t646 = extractvalue { i8**, i64 } %t645, 1
  %t647 = icmp eq i64 %t646, 0
  br label %logical_and_right_end_642

logical_and_right_end_642:
  br label %logical_and_merge_642

logical_and_merge_642:
  %t648 = phi i1 [ false, %logical_and_entry_642 ], [ %t647, %logical_and_right_end_642 ]
  br label %logical_and_right_end_640

logical_and_right_end_640:
  br label %logical_and_merge_640

logical_and_merge_640:
  %t649 = phi i1 [ false, %logical_and_entry_640 ], [ %t648, %logical_and_right_end_640 ]
  br label %logical_and_right_end_638

logical_and_right_end_638:
  br label %logical_and_merge_638

logical_and_merge_638:
  %t650 = phi i1 [ false, %logical_and_entry_638 ], [ %t649, %logical_and_right_end_638 ]
  br label %logical_and_right_end_636

logical_and_right_end_636:
  br label %logical_and_merge_636

logical_and_merge_636:
  %t651 = phi i1 [ false, %logical_and_entry_636 ], [ %t650, %logical_and_right_end_636 ]
  store i1 %t651, i1* %l23
  %t652 = load i8*, i8** %l4
  %t653 = insertvalue %NativeEnumVariantLayout undef, i8* %t652, 0
  %t654 = load double, double* %l9
  %t655 = insertvalue %NativeEnumVariantLayout %t653, double %t654, 1
  %t656 = load double, double* %l10
  %t657 = insertvalue %NativeEnumVariantLayout %t655, double %t656, 2
  %t658 = load double, double* %l11
  %t659 = insertvalue %NativeEnumVariantLayout %t657, double %t658, 3
  %t660 = load double, double* %l12
  %t661 = insertvalue %NativeEnumVariantLayout %t659, double %t660, 4
  %t662 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t663 = ptrtoint [0 x %NativeStructLayoutField]* %t662 to i64
  %t664 = icmp eq i64 %t663, 0
  %t665 = select i1 %t664, i64 1, i64 %t663
  %t666 = call i8* @malloc(i64 %t665)
  %t667 = bitcast i8* %t666 to %NativeStructLayoutField*
  %t668 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t669 = ptrtoint { %NativeStructLayoutField*, i64 }* %t668 to i64
  %t670 = call i8* @malloc(i64 %t669)
  %t671 = bitcast i8* %t670 to { %NativeStructLayoutField*, i64 }*
  %t672 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t671, i32 0, i32 0
  store %NativeStructLayoutField* %t667, %NativeStructLayoutField** %t672
  %t673 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t671, i32 0, i32 1
  store i64 0, i64* %t673
  %t674 = insertvalue %NativeEnumVariantLayout %t661, { %NativeStructLayoutField*, i64 }* %t671, 5
  store %NativeEnumVariantLayout %t674, %NativeEnumVariantLayout* %l24
  %t675 = load i1, i1* %l23
  %t676 = insertvalue %EnumLayoutVariantParse undef, i1 %t675, 0
  %t677 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l24
  %t678 = insertvalue %EnumLayoutVariantParse %t676, %NativeEnumVariantLayout %t677, 1
  %t679 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t680 = insertvalue %EnumLayoutVariantParse %t678, { i8**, i64 }* %t679, 2
  ret %EnumLayoutVariantParse %t680
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t73 = add i64 0, 2
  %t74 = call i8* @malloc(i64 %t73)
  store i8 46, i8* %t74
  %t75 = getelementptr i8, i8* %t74, i64 1
  store i8 0, i8* %t75
  call void @sailfin_runtime_mark_persistent(i8* %t74)
  %t76 = call double @index_of(i8* %t72, i8* %t74)
  store double %t76, double* %l5
  %t78 = load double, double* %l5
  %t79 = sitofp i64 0 to double
  %t80 = fcmp ole double %t78, %t79
  br label %logical_or_entry_77

logical_or_entry_77:
  br i1 %t80, label %logical_or_merge_77, label %logical_or_right_77

logical_or_right_77:
  %t81 = load double, double* %l5
  %t82 = sitofp i64 1 to double
  %t83 = fadd double %t81, %t82
  %t84 = load i8*, i8** %l4
  %t85 = call i64 @sailfin_runtime_string_length(i8* %t84)
  %t86 = sitofp i64 %t85 to double
  %t87 = fcmp oge double %t83, %t86
  br label %logical_or_right_end_77

logical_or_right_end_77:
  br label %logical_or_merge_77

logical_or_merge_77:
  %t88 = phi i1 [ true, %logical_or_entry_77 ], [ %t87, %logical_or_right_end_77 ]
  %t89 = load i8*, i8** %l0
  %t90 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t91 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t92 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t93 = load i8*, i8** %l4
  %t94 = load double, double* %l5
  br i1 %t88, label %then4, label %merge5
then4:
  %t95 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s96 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t97 = call i8* @sailfin_runtime_string_concat(i8* %s96, i8* %enum_name)
  %s98 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h497146076, i32 0, i32 0
  %t99 = call i8* @sailfin_runtime_string_concat(i8* %t97, i8* %s98)
  %t100 = load i8*, i8** %l4
  %t101 = call i8* @sailfin_runtime_string_concat(i8* %t99, i8* %t100)
  %s102 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1123073249, i32 0, i32 0
  %t103 = call i8* @sailfin_runtime_string_concat(i8* %t101, i8* %s102)
  %t104 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t95, i8* %t103)
  store { i8**, i64 }* %t104, { i8**, i64 }** %l1
  %t105 = insertvalue %EnumLayoutPayloadParse undef, i1 0, 0
  %s106 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  %t107 = insertvalue %EnumLayoutPayloadParse %t105, i8* %s106, 1
  %t108 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t109 = insertvalue %EnumLayoutPayloadParse %t107, %NativeStructLayoutField %t108, 2
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t111 = insertvalue %EnumLayoutPayloadParse %t109, { i8**, i64 }* %t110, 3
  ret %EnumLayoutPayloadParse %t111
merge5:
  %t112 = load i8*, i8** %l4
  %t113 = load double, double* %l5
  %t114 = call double @llvm.round.f64(double %t113)
  %t115 = fptosi double %t114 to i64
  %t116 = call i8* @sailfin_runtime_substring(i8* %t112, i64 0, i64 %t115)
  store i8* %t116, i8** %l6
  %t117 = load i8*, i8** %l4
  %t118 = load double, double* %l5
  %t119 = sitofp i64 1 to double
  %t120 = fadd double %t118, %t119
  %t121 = load i8*, i8** %l4
  %t122 = call i64 @sailfin_runtime_string_length(i8* %t121)
  %t123 = call double @llvm.round.f64(double %t120)
  %t124 = fptosi double %t123 to i64
  %t125 = call i8* @sailfin_runtime_substring(i8* %t117, i64 %t124, i64 %t122)
  store i8* %t125, i8** %l7
  %s126 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s126, i8** %l8
  store i1 0, i1* %l9
  store i1 0, i1* %l10
  store i1 0, i1* %l11
  %t127 = sitofp i64 0 to double
  store double %t127, double* %l12
  %t128 = sitofp i64 0 to double
  store double %t128, double* %l13
  %t129 = sitofp i64 0 to double
  store double %t129, double* %l14
  %t130 = sitofp i64 1 to double
  store double %t130, double* %l15
  %t131 = load i8*, i8** %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t135 = load i8*, i8** %l4
  %t136 = load double, double* %l5
  %t137 = load i8*, i8** %l6
  %t138 = load i8*, i8** %l7
  %t139 = load i8*, i8** %l8
  %t140 = load i1, i1* %l9
  %t141 = load i1, i1* %l10
  %t142 = load i1, i1* %l11
  %t143 = load double, double* %l12
  %t144 = load double, double* %l13
  %t145 = load double, double* %l14
  %t146 = load double, double* %l15
  br label %loop.header6
loop.header6:
  %t499 = phi i8* [ %t139, %merge5 ], [ %t490, %loop.latch8 ]
  %t500 = phi i1 [ %t140, %merge5 ], [ %t491, %loop.latch8 ]
  %t501 = phi double [ %t143, %merge5 ], [ %t492, %loop.latch8 ]
  %t502 = phi { i8**, i64 }* [ %t132, %merge5 ], [ %t493, %loop.latch8 ]
  %t503 = phi i1 [ %t141, %merge5 ], [ %t494, %loop.latch8 ]
  %t504 = phi double [ %t144, %merge5 ], [ %t495, %loop.latch8 ]
  %t505 = phi i1 [ %t142, %merge5 ], [ %t496, %loop.latch8 ]
  %t506 = phi double [ %t145, %merge5 ], [ %t497, %loop.latch8 ]
  %t507 = phi double [ %t146, %merge5 ], [ %t498, %loop.latch8 ]
  store i8* %t499, i8** %l8
  store i1 %t500, i1* %l9
  store double %t501, double* %l12
  store { i8**, i64 }* %t502, { i8**, i64 }** %l1
  store i1 %t503, i1* %l10
  store double %t504, double* %l13
  store i1 %t505, i1* %l11
  store double %t506, double* %l14
  store double %t507, double* %l15
  br label %loop.body7
loop.body7:
  %t147 = load double, double* %l15
  %t148 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t149 = load { i8**, i64 }, { i8**, i64 }* %t148
  %t150 = extractvalue { i8**, i64 } %t149, 1
  %t151 = sitofp i64 %t150 to double
  %t152 = fcmp oge double %t147, %t151
  %t153 = load i8*, i8** %l0
  %t154 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t155 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t156 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t157 = load i8*, i8** %l4
  %t158 = load double, double* %l5
  %t159 = load i8*, i8** %l6
  %t160 = load i8*, i8** %l7
  %t161 = load i8*, i8** %l8
  %t162 = load i1, i1* %l9
  %t163 = load i1, i1* %l10
  %t164 = load i1, i1* %l11
  %t165 = load double, double* %l12
  %t166 = load double, double* %l13
  %t167 = load double, double* %l14
  %t168 = load double, double* %l15
  br i1 %t152, label %then10, label %merge11
then10:
  br label %afterloop9
merge11:
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t170 = load double, double* %l15
  %t171 = call double @llvm.round.f64(double %t170)
  %t172 = fptosi double %t171 to i64
  %t173 = load { i8**, i64 }, { i8**, i64 }* %t169
  %t174 = extractvalue { i8**, i64 } %t173, 0
  %t175 = extractvalue { i8**, i64 } %t173, 1
  %t176 = icmp uge i64 %t172, %t175
  ; bounds check: %t176 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t172, i64 %t175)
  %t177 = getelementptr i8*, i8** %t174, i64 %t172
  %t178 = load i8*, i8** %t177
  store i8* %t178, i8** %l16
  %t179 = load i8*, i8** %l16
  %s180 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h524431183, i32 0, i32 0
  %t181 = call i1 @starts_with(i8* %t179, i8* %s180)
  %t182 = load i8*, i8** %l0
  %t183 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t184 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t185 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t186 = load i8*, i8** %l4
  %t187 = load double, double* %l5
  %t188 = load i8*, i8** %l6
  %t189 = load i8*, i8** %l7
  %t190 = load i8*, i8** %l8
  %t191 = load i1, i1* %l9
  %t192 = load i1, i1* %l10
  %t193 = load i1, i1* %l11
  %t194 = load double, double* %l12
  %t195 = load double, double* %l13
  %t196 = load double, double* %l14
  %t197 = load double, double* %l15
  %t198 = load i8*, i8** %l16
  br i1 %t181, label %then12, label %else13
then12:
  %t199 = load i8*, i8** %l16
  %t200 = load i8*, i8** %l16
  %t201 = call i64 @sailfin_runtime_string_length(i8* %t200)
  %t202 = call i8* @sailfin_runtime_substring(i8* %t199, i64 5, i64 %t201)
  store i8* %t202, i8** %l8
  %t203 = load i8*, i8** %l8
  br label %merge14
else13:
  %t204 = load i8*, i8** %l16
  %s205 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h242296049, i32 0, i32 0
  %t206 = call i1 @starts_with(i8* %t204, i8* %s205)
  %t207 = load i8*, i8** %l0
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t209 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t210 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t211 = load i8*, i8** %l4
  %t212 = load double, double* %l5
  %t213 = load i8*, i8** %l6
  %t214 = load i8*, i8** %l7
  %t215 = load i8*, i8** %l8
  %t216 = load i1, i1* %l9
  %t217 = load i1, i1* %l10
  %t218 = load i1, i1* %l11
  %t219 = load double, double* %l12
  %t220 = load double, double* %l13
  %t221 = load double, double* %l14
  %t222 = load double, double* %l15
  %t223 = load i8*, i8** %l16
  br i1 %t206, label %then15, label %else16
then15:
  %t224 = load i8*, i8** %l16
  %t225 = load i8*, i8** %l16
  %t226 = call i64 @sailfin_runtime_string_length(i8* %t225)
  %t227 = call i8* @sailfin_runtime_substring(i8* %t224, i64 7, i64 %t226)
  store i8* %t227, i8** %l17
  %t228 = load i8*, i8** %l17
  %t229 = call %NumberParseResult @parse_decimal_number(i8* %t228)
  store %NumberParseResult %t229, %NumberParseResult* %l18
  %t230 = load %NumberParseResult, %NumberParseResult* %l18
  %t231 = extractvalue %NumberParseResult %t230, 0
  %t232 = load i8*, i8** %l0
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t234 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t236 = load i8*, i8** %l4
  %t237 = load double, double* %l5
  %t238 = load i8*, i8** %l6
  %t239 = load i8*, i8** %l7
  %t240 = load i8*, i8** %l8
  %t241 = load i1, i1* %l9
  %t242 = load i1, i1* %l10
  %t243 = load i1, i1* %l11
  %t244 = load double, double* %l12
  %t245 = load double, double* %l13
  %t246 = load double, double* %l14
  %t247 = load double, double* %l15
  %t248 = load i8*, i8** %l16
  %t249 = load i8*, i8** %l17
  %t250 = load %NumberParseResult, %NumberParseResult* %l18
  br i1 %t231, label %then18, label %else19
then18:
  store i1 1, i1* %l9
  %t251 = load %NumberParseResult, %NumberParseResult* %l18
  %t252 = extractvalue %NumberParseResult %t251, 1
  store double %t252, double* %l12
  %t253 = load i1, i1* %l9
  %t254 = load double, double* %l12
  br label %merge20
else19:
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s256 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t257 = call i8* @sailfin_runtime_string_concat(i8* %s256, i8* %enum_name)
  %s258 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t259 = call i8* @sailfin_runtime_string_concat(i8* %t257, i8* %s258)
  %t260 = load i8*, i8** %l4
  %t261 = call i8* @sailfin_runtime_string_concat(i8* %t259, i8* %t260)
  %s262 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h24304067, i32 0, i32 0
  %t263 = call i8* @sailfin_runtime_string_concat(i8* %t261, i8* %s262)
  %t264 = load i8*, i8** %l17
  %t265 = call i8* @sailfin_runtime_string_concat(i8* %t263, i8* %t264)
  %t266 = add i64 0, 2
  %t267 = call i8* @malloc(i64 %t266)
  store i8 96, i8* %t267
  %t268 = getelementptr i8, i8* %t267, i64 1
  store i8 0, i8* %t268
  call void @sailfin_runtime_mark_persistent(i8* %t267)
  %t269 = call i8* @sailfin_runtime_string_concat(i8* %t265, i8* %t267)
  %t270 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t255, i8* %t269)
  store { i8**, i64 }* %t270, { i8**, i64 }** %l1
  %t271 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge20
merge20:
  %t272 = phi i1 [ %t253, %then18 ], [ %t241, %else19 ]
  %t273 = phi double [ %t254, %then18 ], [ %t244, %else19 ]
  %t274 = phi { i8**, i64 }* [ %t233, %then18 ], [ %t271, %else19 ]
  store i1 %t272, i1* %l9
  store double %t273, double* %l12
  store { i8**, i64 }* %t274, { i8**, i64 }** %l1
  %t275 = load i1, i1* %l9
  %t276 = load double, double* %l12
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
else16:
  %t278 = load i8*, i8** %l16
  %s279 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h466680424, i32 0, i32 0
  %t280 = call i1 @starts_with(i8* %t278, i8* %s279)
  %t281 = load i8*, i8** %l0
  %t282 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t283 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t284 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t285 = load i8*, i8** %l4
  %t286 = load double, double* %l5
  %t287 = load i8*, i8** %l6
  %t288 = load i8*, i8** %l7
  %t289 = load i8*, i8** %l8
  %t290 = load i1, i1* %l9
  %t291 = load i1, i1* %l10
  %t292 = load i1, i1* %l11
  %t293 = load double, double* %l12
  %t294 = load double, double* %l13
  %t295 = load double, double* %l14
  %t296 = load double, double* %l15
  %t297 = load i8*, i8** %l16
  br i1 %t280, label %then21, label %else22
then21:
  %t298 = load i8*, i8** %l16
  %t299 = load i8*, i8** %l16
  %t300 = call i64 @sailfin_runtime_string_length(i8* %t299)
  %t301 = call i8* @sailfin_runtime_substring(i8* %t298, i64 5, i64 %t300)
  store i8* %t301, i8** %l19
  %t302 = load i8*, i8** %l19
  %t303 = call %NumberParseResult @parse_decimal_number(i8* %t302)
  store %NumberParseResult %t303, %NumberParseResult* %l20
  %t304 = load %NumberParseResult, %NumberParseResult* %l20
  %t305 = extractvalue %NumberParseResult %t304, 0
  %t306 = load i8*, i8** %l0
  %t307 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t308 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t309 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t310 = load i8*, i8** %l4
  %t311 = load double, double* %l5
  %t312 = load i8*, i8** %l6
  %t313 = load i8*, i8** %l7
  %t314 = load i8*, i8** %l8
  %t315 = load i1, i1* %l9
  %t316 = load i1, i1* %l10
  %t317 = load i1, i1* %l11
  %t318 = load double, double* %l12
  %t319 = load double, double* %l13
  %t320 = load double, double* %l14
  %t321 = load double, double* %l15
  %t322 = load i8*, i8** %l16
  %t323 = load i8*, i8** %l19
  %t324 = load %NumberParseResult, %NumberParseResult* %l20
  br i1 %t305, label %then24, label %else25
then24:
  store i1 1, i1* %l10
  %t325 = load %NumberParseResult, %NumberParseResult* %l20
  %t326 = extractvalue %NumberParseResult %t325, 1
  store double %t326, double* %l13
  %t327 = load i1, i1* %l10
  %t328 = load double, double* %l13
  br label %merge26
else25:
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s330 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t331 = call i8* @sailfin_runtime_string_concat(i8* %s330, i8* %enum_name)
  %s332 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t333 = call i8* @sailfin_runtime_string_concat(i8* %t331, i8* %s332)
  %t334 = load i8*, i8** %l4
  %t335 = call i8* @sailfin_runtime_string_concat(i8* %t333, i8* %t334)
  %s336 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h151690315, i32 0, i32 0
  %t337 = call i8* @sailfin_runtime_string_concat(i8* %t335, i8* %s336)
  %t338 = load i8*, i8** %l19
  %t339 = call i8* @sailfin_runtime_string_concat(i8* %t337, i8* %t338)
  %t340 = add i64 0, 2
  %t341 = call i8* @malloc(i64 %t340)
  store i8 96, i8* %t341
  %t342 = getelementptr i8, i8* %t341, i64 1
  store i8 0, i8* %t342
  call void @sailfin_runtime_mark_persistent(i8* %t341)
  %t343 = call i8* @sailfin_runtime_string_concat(i8* %t339, i8* %t341)
  %t344 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t329, i8* %t343)
  store { i8**, i64 }* %t344, { i8**, i64 }** %l1
  %t345 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge26
merge26:
  %t346 = phi i1 [ %t327, %then24 ], [ %t316, %else25 ]
  %t347 = phi double [ %t328, %then24 ], [ %t319, %else25 ]
  %t348 = phi { i8**, i64 }* [ %t307, %then24 ], [ %t345, %else25 ]
  store i1 %t346, i1* %l10
  store double %t347, double* %l13
  store { i8**, i64 }* %t348, { i8**, i64 }** %l1
  %t349 = load i1, i1* %l10
  %t350 = load double, double* %l13
  %t351 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
else22:
  %t352 = load i8*, i8** %l16
  %s353 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h841337749, i32 0, i32 0
  %t354 = call i1 @starts_with(i8* %t352, i8* %s353)
  %t355 = load i8*, i8** %l0
  %t356 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t357 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t359 = load i8*, i8** %l4
  %t360 = load double, double* %l5
  %t361 = load i8*, i8** %l6
  %t362 = load i8*, i8** %l7
  %t363 = load i8*, i8** %l8
  %t364 = load i1, i1* %l9
  %t365 = load i1, i1* %l10
  %t366 = load i1, i1* %l11
  %t367 = load double, double* %l12
  %t368 = load double, double* %l13
  %t369 = load double, double* %l14
  %t370 = load double, double* %l15
  %t371 = load i8*, i8** %l16
  br i1 %t354, label %then27, label %else28
then27:
  %t372 = load i8*, i8** %l16
  %t373 = load i8*, i8** %l16
  %t374 = call i64 @sailfin_runtime_string_length(i8* %t373)
  %t375 = call i8* @sailfin_runtime_substring(i8* %t372, i64 6, i64 %t374)
  store i8* %t375, i8** %l21
  %t376 = load i8*, i8** %l21
  %t377 = call %NumberParseResult @parse_decimal_number(i8* %t376)
  store %NumberParseResult %t377, %NumberParseResult* %l22
  %t378 = load %NumberParseResult, %NumberParseResult* %l22
  %t379 = extractvalue %NumberParseResult %t378, 0
  %t380 = load i8*, i8** %l0
  %t381 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t382 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t383 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t384 = load i8*, i8** %l4
  %t385 = load double, double* %l5
  %t386 = load i8*, i8** %l6
  %t387 = load i8*, i8** %l7
  %t388 = load i8*, i8** %l8
  %t389 = load i1, i1* %l9
  %t390 = load i1, i1* %l10
  %t391 = load i1, i1* %l11
  %t392 = load double, double* %l12
  %t393 = load double, double* %l13
  %t394 = load double, double* %l14
  %t395 = load double, double* %l15
  %t396 = load i8*, i8** %l16
  %t397 = load i8*, i8** %l21
  %t398 = load %NumberParseResult, %NumberParseResult* %l22
  br i1 %t379, label %then30, label %else31
then30:
  store i1 1, i1* %l11
  %t399 = load %NumberParseResult, %NumberParseResult* %l22
  %t400 = extractvalue %NumberParseResult %t399, 1
  store double %t400, double* %l14
  %t401 = load i1, i1* %l11
  %t402 = load double, double* %l14
  br label %merge32
else31:
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s404 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t405 = call i8* @sailfin_runtime_string_concat(i8* %s404, i8* %enum_name)
  %s406 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t407 = call i8* @sailfin_runtime_string_concat(i8* %t405, i8* %s406)
  %t408 = load i8*, i8** %l4
  %t409 = call i8* @sailfin_runtime_string_concat(i8* %t407, i8* %t408)
  %s410 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h1297227834, i32 0, i32 0
  %t411 = call i8* @sailfin_runtime_string_concat(i8* %t409, i8* %s410)
  %t412 = load i8*, i8** %l21
  %t413 = call i8* @sailfin_runtime_string_concat(i8* %t411, i8* %t412)
  %t414 = add i64 0, 2
  %t415 = call i8* @malloc(i64 %t414)
  store i8 96, i8* %t415
  %t416 = getelementptr i8, i8* %t415, i64 1
  store i8 0, i8* %t416
  call void @sailfin_runtime_mark_persistent(i8* %t415)
  %t417 = call i8* @sailfin_runtime_string_concat(i8* %t413, i8* %t415)
  %t418 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t403, i8* %t417)
  store { i8**, i64 }* %t418, { i8**, i64 }** %l1
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge32
merge32:
  %t420 = phi i1 [ %t401, %then30 ], [ %t391, %else31 ]
  %t421 = phi double [ %t402, %then30 ], [ %t394, %else31 ]
  %t422 = phi { i8**, i64 }* [ %t381, %then30 ], [ %t419, %else31 ]
  store i1 %t420, i1* %l11
  store double %t421, double* %l14
  store { i8**, i64 }* %t422, { i8**, i64 }** %l1
  %t423 = load i1, i1* %l11
  %t424 = load double, double* %l14
  %t425 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
else28:
  %t426 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s427 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t428 = call i8* @sailfin_runtime_string_concat(i8* %s427, i8* %enum_name)
  %s429 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t430 = call i8* @sailfin_runtime_string_concat(i8* %t428, i8* %s429)
  %t431 = load i8*, i8** %l4
  %t432 = call i8* @sailfin_runtime_string_concat(i8* %t430, i8* %t431)
  %s433 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h496289716, i32 0, i32 0
  %t434 = call i8* @sailfin_runtime_string_concat(i8* %t432, i8* %s433)
  %t435 = load i8*, i8** %l16
  %t436 = call i8* @sailfin_runtime_string_concat(i8* %t434, i8* %t435)
  %t437 = add i64 0, 2
  %t438 = call i8* @malloc(i64 %t437)
  store i8 96, i8* %t438
  %t439 = getelementptr i8, i8* %t438, i64 1
  store i8 0, i8* %t439
  call void @sailfin_runtime_mark_persistent(i8* %t438)
  %t440 = call i8* @sailfin_runtime_string_concat(i8* %t436, i8* %t438)
  %t441 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t426, i8* %t440)
  store { i8**, i64 }* %t441, { i8**, i64 }** %l1
  %t442 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge29
merge29:
  %t443 = phi i1 [ %t423, %merge32 ], [ %t366, %else28 ]
  %t444 = phi double [ %t424, %merge32 ], [ %t369, %else28 ]
  %t445 = phi { i8**, i64 }* [ %t425, %merge32 ], [ %t442, %else28 ]
  store i1 %t443, i1* %l11
  store double %t444, double* %l14
  store { i8**, i64 }* %t445, { i8**, i64 }** %l1
  %t446 = load i1, i1* %l11
  %t447 = load double, double* %l14
  %t448 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge23
merge23:
  %t450 = phi i1 [ %t349, %merge26 ], [ %t291, %merge29 ]
  %t451 = phi double [ %t350, %merge26 ], [ %t294, %merge29 ]
  %t452 = phi { i8**, i64 }* [ %t351, %merge26 ], [ %t448, %merge29 ]
  %t453 = phi i1 [ %t292, %merge26 ], [ %t446, %merge29 ]
  %t454 = phi double [ %t295, %merge26 ], [ %t447, %merge29 ]
  store i1 %t450, i1* %l10
  store double %t451, double* %l13
  store { i8**, i64 }* %t452, { i8**, i64 }** %l1
  store i1 %t453, i1* %l11
  store double %t454, double* %l14
  %t455 = load i1, i1* %l10
  %t456 = load double, double* %l13
  %t457 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t458 = load i1, i1* %l11
  %t459 = load double, double* %l14
  %t460 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t461 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge17
merge17:
  %t462 = phi i1 [ %t275, %merge20 ], [ %t216, %merge23 ]
  %t463 = phi double [ %t276, %merge20 ], [ %t219, %merge23 ]
  %t464 = phi { i8**, i64 }* [ %t277, %merge20 ], [ %t457, %merge23 ]
  %t465 = phi i1 [ %t217, %merge20 ], [ %t455, %merge23 ]
  %t466 = phi double [ %t220, %merge20 ], [ %t456, %merge23 ]
  %t467 = phi i1 [ %t218, %merge20 ], [ %t458, %merge23 ]
  %t468 = phi double [ %t221, %merge20 ], [ %t459, %merge23 ]
  store i1 %t462, i1* %l9
  store double %t463, double* %l12
  store { i8**, i64 }* %t464, { i8**, i64 }** %l1
  store i1 %t465, i1* %l10
  store double %t466, double* %l13
  store i1 %t467, i1* %l11
  store double %t468, double* %l14
  %t469 = load i1, i1* %l9
  %t470 = load double, double* %l12
  %t471 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t472 = load i1, i1* %l10
  %t473 = load double, double* %l13
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t475 = load i1, i1* %l11
  %t476 = load double, double* %l14
  %t477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t478 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge14
merge14:
  %t479 = phi i8* [ %t203, %then12 ], [ %t190, %merge17 ]
  %t480 = phi i1 [ %t191, %then12 ], [ %t469, %merge17 ]
  %t481 = phi double [ %t194, %then12 ], [ %t470, %merge17 ]
  %t482 = phi { i8**, i64 }* [ %t183, %then12 ], [ %t471, %merge17 ]
  %t483 = phi i1 [ %t192, %then12 ], [ %t472, %merge17 ]
  %t484 = phi double [ %t195, %then12 ], [ %t473, %merge17 ]
  %t485 = phi i1 [ %t193, %then12 ], [ %t475, %merge17 ]
  %t486 = phi double [ %t196, %then12 ], [ %t476, %merge17 ]
  store i8* %t479, i8** %l8
  store i1 %t480, i1* %l9
  store double %t481, double* %l12
  store { i8**, i64 }* %t482, { i8**, i64 }** %l1
  store i1 %t483, i1* %l10
  store double %t484, double* %l13
  store i1 %t485, i1* %l11
  store double %t486, double* %l14
  %t487 = load double, double* %l15
  %t488 = sitofp i64 1 to double
  %t489 = fadd double %t487, %t488
  store double %t489, double* %l15
  br label %loop.latch8
loop.latch8:
  %t490 = load i8*, i8** %l8
  %t491 = load i1, i1* %l9
  %t492 = load double, double* %l12
  %t493 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t494 = load i1, i1* %l10
  %t495 = load double, double* %l13
  %t496 = load i1, i1* %l11
  %t497 = load double, double* %l14
  %t498 = load double, double* %l15
  br label %loop.header6
afterloop9:
  %t508 = load i8*, i8** %l8
  %t509 = load i1, i1* %l9
  %t510 = load double, double* %l12
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t512 = load i1, i1* %l10
  %t513 = load double, double* %l13
  %t514 = load i1, i1* %l11
  %t515 = load double, double* %l14
  %t516 = load double, double* %l15
  %t517 = load i8*, i8** %l8
  %t518 = call i64 @sailfin_runtime_string_length(i8* %t517)
  %t519 = icmp eq i64 %t518, 0
  %t520 = load i8*, i8** %l0
  %t521 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t522 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t523 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t524 = load i8*, i8** %l4
  %t525 = load double, double* %l5
  %t526 = load i8*, i8** %l6
  %t527 = load i8*, i8** %l7
  %t528 = load i8*, i8** %l8
  %t529 = load i1, i1* %l9
  %t530 = load i1, i1* %l10
  %t531 = load i1, i1* %l11
  %t532 = load double, double* %l12
  %t533 = load double, double* %l13
  %t534 = load double, double* %l14
  %t535 = load double, double* %l15
  br i1 %t519, label %then33, label %merge34
then33:
  %t536 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s537 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t538 = call i8* @sailfin_runtime_string_concat(i8* %s537, i8* %enum_name)
  %s539 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t540 = call i8* @sailfin_runtime_string_concat(i8* %t538, i8* %s539)
  %t541 = load i8*, i8** %l4
  %t542 = call i8* @sailfin_runtime_string_concat(i8* %t540, i8* %t541)
  %s543 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h1568429285, i32 0, i32 0
  %t544 = call i8* @sailfin_runtime_string_concat(i8* %t542, i8* %s543)
  %t545 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t536, i8* %t544)
  store { i8**, i64 }* %t545, { i8**, i64 }** %l1
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge34
merge34:
  %t547 = phi { i8**, i64 }* [ %t546, %then33 ], [ %t521, %afterloop9 ]
  store { i8**, i64 }* %t547, { i8**, i64 }** %l1
  %t548 = load i1, i1* %l9
  %t549 = xor i1 %t548, 1
  %t550 = load i8*, i8** %l0
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t552 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t554 = load i8*, i8** %l4
  %t555 = load double, double* %l5
  %t556 = load i8*, i8** %l6
  %t557 = load i8*, i8** %l7
  %t558 = load i8*, i8** %l8
  %t559 = load i1, i1* %l9
  %t560 = load i1, i1* %l10
  %t561 = load i1, i1* %l11
  %t562 = load double, double* %l12
  %t563 = load double, double* %l13
  %t564 = load double, double* %l14
  %t565 = load double, double* %l15
  br i1 %t549, label %then35, label %merge36
then35:
  %t566 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s567 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t568 = call i8* @sailfin_runtime_string_concat(i8* %s567, i8* %enum_name)
  %s569 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t570 = call i8* @sailfin_runtime_string_concat(i8* %t568, i8* %s569)
  %t571 = load i8*, i8** %l4
  %t572 = call i8* @sailfin_runtime_string_concat(i8* %t570, i8* %t571)
  %s573 = getelementptr inbounds [23 x i8], [23 x i8]* @.str.len22.h625556084, i32 0, i32 0
  %t574 = call i8* @sailfin_runtime_string_concat(i8* %t572, i8* %s573)
  %t575 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t566, i8* %t574)
  store { i8**, i64 }* %t575, { i8**, i64 }** %l1
  %t576 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge36
merge36:
  %t577 = phi { i8**, i64 }* [ %t576, %then35 ], [ %t551, %merge34 ]
  store { i8**, i64 }* %t577, { i8**, i64 }** %l1
  %t578 = load i1, i1* %l10
  %t579 = xor i1 %t578, 1
  %t580 = load i8*, i8** %l0
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t582 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t583 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t584 = load i8*, i8** %l4
  %t585 = load double, double* %l5
  %t586 = load i8*, i8** %l6
  %t587 = load i8*, i8** %l7
  %t588 = load i8*, i8** %l8
  %t589 = load i1, i1* %l9
  %t590 = load i1, i1* %l10
  %t591 = load i1, i1* %l11
  %t592 = load double, double* %l12
  %t593 = load double, double* %l13
  %t594 = load double, double* %l14
  %t595 = load double, double* %l15
  br i1 %t579, label %then37, label %merge38
then37:
  %t596 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s597 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t598 = call i8* @sailfin_runtime_string_concat(i8* %s597, i8* %enum_name)
  %s599 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t600 = call i8* @sailfin_runtime_string_concat(i8* %t598, i8* %s599)
  %t601 = load i8*, i8** %l4
  %t602 = call i8* @sailfin_runtime_string_concat(i8* %t600, i8* %t601)
  %s603 = getelementptr inbounds [21 x i8], [21 x i8]* @.str.len20.h608364678, i32 0, i32 0
  %t604 = call i8* @sailfin_runtime_string_concat(i8* %t602, i8* %s603)
  %t605 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t596, i8* %t604)
  store { i8**, i64 }* %t605, { i8**, i64 }** %l1
  %t606 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge38
merge38:
  %t607 = phi { i8**, i64 }* [ %t606, %then37 ], [ %t581, %merge36 ]
  store { i8**, i64 }* %t607, { i8**, i64 }** %l1
  %t608 = load i1, i1* %l11
  %t609 = xor i1 %t608, 1
  %t610 = load i8*, i8** %l0
  %t611 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t612 = load %NativeStructLayoutField, %NativeStructLayoutField* %l2
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l3
  %t614 = load i8*, i8** %l4
  %t615 = load double, double* %l5
  %t616 = load i8*, i8** %l6
  %t617 = load i8*, i8** %l7
  %t618 = load i8*, i8** %l8
  %t619 = load i1, i1* %l9
  %t620 = load i1, i1* %l10
  %t621 = load i1, i1* %l11
  %t622 = load double, double* %l12
  %t623 = load double, double* %l13
  %t624 = load double, double* %l14
  %t625 = load double, double* %l15
  br i1 %t609, label %then39, label %merge40
then39:
  %t626 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s627 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t628 = call i8* @sailfin_runtime_string_concat(i8* %s627, i8* %enum_name)
  %s629 = getelementptr inbounds [18 x i8], [18 x i8]* @.str.len17.h1973869273, i32 0, i32 0
  %t630 = call i8* @sailfin_runtime_string_concat(i8* %t628, i8* %s629)
  %t631 = load i8*, i8** %l4
  %t632 = call i8* @sailfin_runtime_string_concat(i8* %t630, i8* %t631)
  %s633 = getelementptr inbounds [22 x i8], [22 x i8]* @.str.len21.h2112628887, i32 0, i32 0
  %t634 = call i8* @sailfin_runtime_string_concat(i8* %t632, i8* %s633)
  %t635 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t626, i8* %t634)
  store { i8**, i64 }* %t635, { i8**, i64 }** %l1
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge40
merge40:
  %t637 = phi { i8**, i64 }* [ %t636, %then39 ], [ %t611, %merge38 ]
  store { i8**, i64 }* %t637, { i8**, i64 }** %l1
  %t639 = load i8*, i8** %l8
  %t640 = call i64 @sailfin_runtime_string_length(i8* %t639)
  %t641 = icmp sgt i64 %t640, 0
  br label %logical_and_entry_638

logical_and_entry_638:
  br i1 %t641, label %logical_and_right_638, label %logical_and_merge_638

logical_and_right_638:
  %t643 = load i1, i1* %l9
  br label %logical_and_entry_642

logical_and_entry_642:
  br i1 %t643, label %logical_and_right_642, label %logical_and_merge_642

logical_and_right_642:
  %t645 = load i1, i1* %l10
  br label %logical_and_entry_644

logical_and_entry_644:
  br i1 %t645, label %logical_and_right_644, label %logical_and_merge_644

logical_and_right_644:
  %t647 = load i1, i1* %l11
  br label %logical_and_entry_646

logical_and_entry_646:
  br i1 %t647, label %logical_and_right_646, label %logical_and_merge_646

logical_and_right_646:
  %t648 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t649 = load { i8**, i64 }, { i8**, i64 }* %t648
  %t650 = extractvalue { i8**, i64 } %t649, 1
  %t651 = icmp eq i64 %t650, 0
  br label %logical_and_right_end_646

logical_and_right_end_646:
  br label %logical_and_merge_646

logical_and_merge_646:
  %t652 = phi i1 [ false, %logical_and_entry_646 ], [ %t651, %logical_and_right_end_646 ]
  br label %logical_and_right_end_644

logical_and_right_end_644:
  br label %logical_and_merge_644

logical_and_merge_644:
  %t653 = phi i1 [ false, %logical_and_entry_644 ], [ %t652, %logical_and_right_end_644 ]
  br label %logical_and_right_end_642

logical_and_right_end_642:
  br label %logical_and_merge_642

logical_and_merge_642:
  %t654 = phi i1 [ false, %logical_and_entry_642 ], [ %t653, %logical_and_right_end_642 ]
  br label %logical_and_right_end_638

logical_and_right_end_638:
  br label %logical_and_merge_638

logical_and_merge_638:
  %t655 = phi i1 [ false, %logical_and_entry_638 ], [ %t654, %logical_and_right_end_638 ]
  store i1 %t655, i1* %l23
  %t656 = load i8*, i8** %l7
  %t657 = insertvalue %NativeStructLayoutField undef, i8* %t656, 0
  %t658 = load i8*, i8** %l8
  %t659 = insertvalue %NativeStructLayoutField %t657, i8* %t658, 1
  %t660 = load double, double* %l12
  %t661 = insertvalue %NativeStructLayoutField %t659, double %t660, 2
  %t662 = load double, double* %l13
  %t663 = insertvalue %NativeStructLayoutField %t661, double %t662, 3
  %t664 = load double, double* %l14
  %t665 = insertvalue %NativeStructLayoutField %t663, double %t664, 4
  store %NativeStructLayoutField %t665, %NativeStructLayoutField* %l24
  %t666 = load i1, i1* %l23
  %t667 = insertvalue %EnumLayoutPayloadParse undef, i1 %t666, 0
  %t668 = load i8*, i8** %l6
  %t669 = insertvalue %EnumLayoutPayloadParse %t667, i8* %t668, 1
  %t670 = load %NativeStructLayoutField, %NativeStructLayoutField* %l24
  %t671 = insertvalue %EnumLayoutPayloadParse %t669, %NativeStructLayoutField %t670, 2
  %t672 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t673 = insertvalue %EnumLayoutPayloadParse %t671, { i8**, i64 }* %t672, 3
  ret %EnumLayoutPayloadParse %t673
}

define %NativeInstruction @parse_let_instruction(i8* %line, %NativeSourceSpan* %span, %NativeSourceSpan* %value_span) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca i1
  %l2 = alloca i8*
  %l3 = alloca %BindingComponents
  %s0 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2064124065, i32 0, i32 0
  %t1 = call i8* @strip_prefix(i8* %line, i8* %s0)
  %t2 = call i8* @trim_text__native_ir(i8* %t1)
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
  %t13 = call i8* @trim_text__native_ir(i8* %t12)
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
  %t39 = phi i8* [ %t2, %block.entry ], [ %t37, %loop.latch2 ]
  %t40 = phi double [ %t3, %block.entry ], [ %t38, %loop.latch2 ]
  store i8* %t39, i8** %l0
  store double %t40, double* %l1
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
  %t30 = add i64 0, 2
  %t31 = call i8* @malloc(i64 %t30)
  store i8 %t29, i8* %t31
  %t32 = getelementptr i8, i8* %t31, i64 1
  store i8 0, i8* %t32
  call void @sailfin_runtime_mark_persistent(i8* %t31)
  %t33 = call i8* @sailfin_runtime_string_concat(i8* %t28, i8* %t31)
  store i8* %t33, i8** %l0
  %t34 = load double, double* %l1
  %t35 = sitofp i64 1 to double
  %t36 = fadd double %t34, %t35
  store double %t36, double* %l1
  br label %loop.latch2
loop.latch2:
  %t37 = load i8*, i8** %l0
  %t38 = load double, double* %l1
  br label %loop.header0
afterloop3:
  %t41 = load i8*, i8** %l0
  %t42 = load double, double* %l1
  %t43 = load i8*, i8** %l0
  %t44 = call i8* @trim_text__native_ir(i8* %t43)
  store i8* %t44, i8** %l0
  %s45 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s45, i8** %l3
  store i8* null, i8** %l4
  %t46 = load double, double* %l1
  %t47 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t48 = call double @llvm.round.f64(double %t46)
  %t49 = fptosi double %t48 to i64
  %t50 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t49, i64 %t47)
  %t51 = call i8* @trim_text__native_ir(i8* %t50)
  store i8* %t51, i8** %l5
  %t52 = load i8*, i8** %l5
  %t53 = call i64 @sailfin_runtime_string_length(i8* %t52)
  %t54 = icmp sgt i64 %t53, 0
  %t55 = load i8*, i8** %l0
  %t56 = load double, double* %l1
  %t57 = load i8*, i8** %l3
  %t58 = load i8*, i8** %l4
  %t59 = load i8*, i8** %l5
  br i1 %t54, label %then8, label %merge9
then8:
  %t60 = load i8*, i8** %l5
  %s61 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t62 = call i1 @starts_with(i8* %t60, i8* %s61)
  %t63 = load i8*, i8** %l0
  %t64 = load double, double* %l1
  %t65 = load i8*, i8** %l3
  %t66 = load i8*, i8** %l4
  %t67 = load i8*, i8** %l5
  br i1 %t62, label %then10, label %else11
then10:
  %t68 = load i8*, i8** %l5
  %s69 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t70 = call i8* @strip_prefix(i8* %t68, i8* %s69)
  %t71 = call i8* @trim_text__native_ir(i8* %t70)
  store i8* %t71, i8** %l5
  %t72 = load i8*, i8** %l5
  %t73 = add i64 0, 2
  %t74 = call i8* @malloc(i64 %t73)
  store i8 61, i8* %t74
  %t75 = getelementptr i8, i8* %t74, i64 1
  store i8 0, i8* %t75
  call void @sailfin_runtime_mark_persistent(i8* %t74)
  %t76 = call double @index_of(i8* %t72, i8* %t74)
  store double %t76, double* %l6
  %t77 = load double, double* %l6
  %t78 = sitofp i64 0 to double
  %t79 = fcmp oge double %t77, %t78
  %t80 = load i8*, i8** %l0
  %t81 = load double, double* %l1
  %t82 = load i8*, i8** %l3
  %t83 = load i8*, i8** %l4
  %t84 = load i8*, i8** %l5
  %t85 = load double, double* %l6
  br i1 %t79, label %then13, label %else14
then13:
  %t86 = load i8*, i8** %l5
  %t87 = load double, double* %l6
  %t88 = call double @llvm.round.f64(double %t87)
  %t89 = fptosi double %t88 to i64
  %t90 = call i8* @sailfin_runtime_substring(i8* %t86, i64 0, i64 %t89)
  %t91 = call i8* @trim_text__native_ir(i8* %t90)
  store i8* %t91, i8** %l3
  %t92 = load i8*, i8** %l5
  %t93 = load double, double* %l6
  %t94 = sitofp i64 1 to double
  %t95 = fadd double %t93, %t94
  %t96 = load i8*, i8** %l5
  %t97 = call i64 @sailfin_runtime_string_length(i8* %t96)
  %t98 = call double @llvm.round.f64(double %t95)
  %t99 = fptosi double %t98 to i64
  %t100 = call i8* @sailfin_runtime_substring(i8* %t92, i64 %t99, i64 %t97)
  %t101 = call i8* @trim_text__native_ir(i8* %t100)
  store i8* %t101, i8** %l7
  %t102 = load i8*, i8** %l7
  %t103 = call i64 @sailfin_runtime_string_length(i8* %t102)
  %t104 = icmp sgt i64 %t103, 0
  %t105 = load i8*, i8** %l0
  %t106 = load double, double* %l1
  %t107 = load i8*, i8** %l3
  %t108 = load i8*, i8** %l4
  %t109 = load i8*, i8** %l5
  %t110 = load double, double* %l6
  %t111 = load i8*, i8** %l7
  br i1 %t104, label %then16, label %merge17
then16:
  %t112 = load i8*, i8** %l7
  store i8* %t112, i8** %l4
  %t113 = load i8*, i8** %l4
  br label %merge17
merge17:
  %t114 = phi i8* [ %t113, %then16 ], [ %t108, %then13 ]
  store i8* %t114, i8** %l4
  %t115 = load i8*, i8** %l3
  %t116 = load i8*, i8** %l4
  br label %merge15
else14:
  %t117 = load i8*, i8** %l5
  %t118 = call i8* @trim_text__native_ir(i8* %t117)
  store i8* %t118, i8** %l3
  %t119 = load i8*, i8** %l3
  br label %merge15
merge15:
  %t120 = phi i8* [ %t115, %merge17 ], [ %t119, %else14 ]
  %t121 = phi i8* [ %t116, %merge17 ], [ %t83, %else14 ]
  store i8* %t120, i8** %l3
  store i8* %t121, i8** %l4
  %t122 = load i8*, i8** %l5
  %t123 = load i8*, i8** %l3
  %t124 = load i8*, i8** %l4
  %t125 = load i8*, i8** %l3
  br label %merge12
else11:
  %t126 = load i8*, i8** %l5
  %t127 = add i64 0, 2
  %t128 = call i8* @malloc(i64 %t127)
  store i8 58, i8* %t128
  %t129 = getelementptr i8, i8* %t128, i64 1
  store i8 0, i8* %t129
  call void @sailfin_runtime_mark_persistent(i8* %t128)
  %t130 = call i1 @starts_with(i8* %t126, i8* %t128)
  %t131 = load i8*, i8** %l0
  %t132 = load double, double* %l1
  %t133 = load i8*, i8** %l3
  %t134 = load i8*, i8** %l4
  %t135 = load i8*, i8** %l5
  br i1 %t130, label %then18, label %else19
then18:
  %t136 = load i8*, i8** %l5
  %t137 = add i64 0, 2
  %t138 = call i8* @malloc(i64 %t137)
  store i8 58, i8* %t138
  %t139 = getelementptr i8, i8* %t138, i64 1
  store i8 0, i8* %t139
  call void @sailfin_runtime_mark_persistent(i8* %t138)
  %t140 = call i8* @strip_prefix(i8* %t136, i8* %t138)
  %t141 = call i8* @trim_text__native_ir(i8* %t140)
  store i8* %t141, i8** %l5
  %t142 = load i8*, i8** %l5
  %t143 = add i64 0, 2
  %t144 = call i8* @malloc(i64 %t143)
  store i8 61, i8* %t144
  %t145 = getelementptr i8, i8* %t144, i64 1
  store i8 0, i8* %t145
  call void @sailfin_runtime_mark_persistent(i8* %t144)
  %t146 = call double @index_of(i8* %t142, i8* %t144)
  store double %t146, double* %l8
  %t147 = load double, double* %l8
  %t148 = sitofp i64 0 to double
  %t149 = fcmp oge double %t147, %t148
  %t150 = load i8*, i8** %l0
  %t151 = load double, double* %l1
  %t152 = load i8*, i8** %l3
  %t153 = load i8*, i8** %l4
  %t154 = load i8*, i8** %l5
  %t155 = load double, double* %l8
  br i1 %t149, label %then21, label %else22
then21:
  %t156 = load i8*, i8** %l5
  %t157 = load double, double* %l8
  %t158 = call double @llvm.round.f64(double %t157)
  %t159 = fptosi double %t158 to i64
  %t160 = call i8* @sailfin_runtime_substring(i8* %t156, i64 0, i64 %t159)
  %t161 = call i8* @trim_text__native_ir(i8* %t160)
  store i8* %t161, i8** %l3
  %t162 = load i8*, i8** %l5
  %t163 = load double, double* %l8
  %t164 = sitofp i64 1 to double
  %t165 = fadd double %t163, %t164
  %t166 = load i8*, i8** %l5
  %t167 = call i64 @sailfin_runtime_string_length(i8* %t166)
  %t168 = call double @llvm.round.f64(double %t165)
  %t169 = fptosi double %t168 to i64
  %t170 = call i8* @sailfin_runtime_substring(i8* %t162, i64 %t169, i64 %t167)
  %t171 = call i8* @trim_text__native_ir(i8* %t170)
  store i8* %t171, i8** %l9
  %t172 = load i8*, i8** %l9
  %t173 = call i64 @sailfin_runtime_string_length(i8* %t172)
  %t174 = icmp sgt i64 %t173, 0
  %t175 = load i8*, i8** %l0
  %t176 = load double, double* %l1
  %t177 = load i8*, i8** %l3
  %t178 = load i8*, i8** %l4
  %t179 = load i8*, i8** %l5
  %t180 = load double, double* %l8
  %t181 = load i8*, i8** %l9
  br i1 %t174, label %then24, label %merge25
then24:
  %t182 = load i8*, i8** %l9
  store i8* %t182, i8** %l4
  %t183 = load i8*, i8** %l4
  br label %merge25
merge25:
  %t184 = phi i8* [ %t183, %then24 ], [ %t178, %then21 ]
  store i8* %t184, i8** %l4
  %t185 = load i8*, i8** %l3
  %t186 = load i8*, i8** %l4
  br label %merge23
else22:
  %t187 = load i8*, i8** %l5
  %t188 = call i8* @trim_text__native_ir(i8* %t187)
  store i8* %t188, i8** %l3
  %t189 = load i8*, i8** %l3
  br label %merge23
merge23:
  %t190 = phi i8* [ %t185, %merge25 ], [ %t189, %else22 ]
  %t191 = phi i8* [ %t186, %merge25 ], [ %t153, %else22 ]
  store i8* %t190, i8** %l3
  store i8* %t191, i8** %l4
  %t192 = load i8*, i8** %l5
  %t193 = load i8*, i8** %l3
  %t194 = load i8*, i8** %l4
  %t195 = load i8*, i8** %l3
  br label %merge20
else19:
  %t196 = load i8*, i8** %l5
  %t197 = add i64 0, 2
  %t198 = call i8* @malloc(i64 %t197)
  store i8 61, i8* %t198
  %t199 = getelementptr i8, i8* %t198, i64 1
  store i8 0, i8* %t199
  call void @sailfin_runtime_mark_persistent(i8* %t198)
  %t200 = call i1 @starts_with(i8* %t196, i8* %t198)
  %t201 = load i8*, i8** %l0
  %t202 = load double, double* %l1
  %t203 = load i8*, i8** %l3
  %t204 = load i8*, i8** %l4
  %t205 = load i8*, i8** %l5
  br i1 %t200, label %then26, label %else27
then26:
  %t206 = load i8*, i8** %l5
  %t207 = add i64 0, 2
  %t208 = call i8* @malloc(i64 %t207)
  store i8 61, i8* %t208
  %t209 = getelementptr i8, i8* %t208, i64 1
  store i8 0, i8* %t209
  call void @sailfin_runtime_mark_persistent(i8* %t208)
  %t210 = call i8* @strip_prefix(i8* %t206, i8* %t208)
  %t211 = call i8* @trim_text__native_ir(i8* %t210)
  store i8* %t211, i8** %l10
  %t212 = load i8*, i8** %l10
  %t213 = call i64 @sailfin_runtime_string_length(i8* %t212)
  %t214 = icmp sgt i64 %t213, 0
  %t215 = load i8*, i8** %l0
  %t216 = load double, double* %l1
  %t217 = load i8*, i8** %l3
  %t218 = load i8*, i8** %l4
  %t219 = load i8*, i8** %l5
  %t220 = load i8*, i8** %l10
  br i1 %t214, label %then29, label %merge30
then29:
  %t221 = load i8*, i8** %l10
  store i8* %t221, i8** %l4
  %t222 = load i8*, i8** %l4
  br label %merge30
merge30:
  %t223 = phi i8* [ %t222, %then29 ], [ %t218, %then26 ]
  store i8* %t223, i8** %l4
  %t224 = load i8*, i8** %l4
  br label %merge28
else27:
  %t225 = load i8*, i8** %l5
  store i8* %t225, i8** %l4
  %t226 = load i8*, i8** %l4
  br label %merge28
merge28:
  %t227 = phi i8* [ %t224, %merge30 ], [ %t226, %else27 ]
  store i8* %t227, i8** %l4
  %t228 = load i8*, i8** %l4
  %t229 = load i8*, i8** %l4
  br label %merge20
merge20:
  %t230 = phi i8* [ %t192, %merge23 ], [ %t135, %merge28 ]
  %t231 = phi i8* [ %t193, %merge23 ], [ %t133, %merge28 ]
  %t232 = phi i8* [ %t194, %merge23 ], [ %t228, %merge28 ]
  store i8* %t230, i8** %l5
  store i8* %t231, i8** %l3
  store i8* %t232, i8** %l4
  %t233 = load i8*, i8** %l5
  %t234 = load i8*, i8** %l3
  %t235 = load i8*, i8** %l4
  %t236 = load i8*, i8** %l3
  %t237 = load i8*, i8** %l4
  %t238 = load i8*, i8** %l4
  br label %merge12
merge12:
  %t239 = phi i8* [ %t122, %merge15 ], [ %t233, %merge20 ]
  %t240 = phi i8* [ %t123, %merge15 ], [ %t234, %merge20 ]
  %t241 = phi i8* [ %t124, %merge15 ], [ %t235, %merge20 ]
  store i8* %t239, i8** %l5
  store i8* %t240, i8** %l3
  store i8* %t241, i8** %l4
  %t242 = load i8*, i8** %l5
  %t243 = load i8*, i8** %l3
  %t244 = load i8*, i8** %l4
  %t245 = load i8*, i8** %l3
  %t246 = load i8*, i8** %l5
  %t247 = load i8*, i8** %l3
  %t248 = load i8*, i8** %l4
  %t249 = load i8*, i8** %l3
  %t250 = load i8*, i8** %l4
  %t251 = load i8*, i8** %l4
  br label %merge9
merge9:
  %t252 = phi i8* [ %t242, %merge12 ], [ %t59, %afterloop3 ]
  %t253 = phi i8* [ %t243, %merge12 ], [ %t57, %afterloop3 ]
  %t254 = phi i8* [ %t244, %merge12 ], [ %t58, %afterloop3 ]
  %t255 = phi i8* [ %t245, %merge12 ], [ %t57, %afterloop3 ]
  %t256 = phi i8* [ %t246, %merge12 ], [ %t59, %afterloop3 ]
  %t257 = phi i8* [ %t247, %merge12 ], [ %t57, %afterloop3 ]
  %t258 = phi i8* [ %t248, %merge12 ], [ %t58, %afterloop3 ]
  %t259 = phi i8* [ %t249, %merge12 ], [ %t57, %afterloop3 ]
  %t260 = phi i8* [ %t250, %merge12 ], [ %t58, %afterloop3 ]
  %t261 = phi i8* [ %t251, %merge12 ], [ %t58, %afterloop3 ]
  store i8* %t252, i8** %l5
  store i8* %t253, i8** %l3
  store i8* %t254, i8** %l4
  store i8* %t255, i8** %l3
  store i8* %t256, i8** %l5
  store i8* %t257, i8** %l3
  store i8* %t258, i8** %l4
  store i8* %t259, i8** %l3
  store i8* %t260, i8** %l4
  store i8* %t261, i8** %l4
  %t262 = load i8*, i8** %l0
  %t263 = insertvalue %BindingComponents undef, i8* %t262, 0
  %t264 = load i8*, i8** %l3
  %t265 = insertvalue %BindingComponents %t263, i8* %t264, 1
  %t266 = load i8*, i8** %l4
  %t267 = insertvalue %BindingComponents %t265, i8* %t266, 2
  ret %BindingComponents %t267
}

define i8* @parse_function_name(i8* %header) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %t0 = call i8* @trim_text__native_ir(i8* %header)
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
  %t8 = call i8* @trim_text__native_ir(i8* %t7)
  store i8* %t8, i8** %l0
  %t9 = load i8*, i8** %l0
  br label %merge1
merge1:
  %t10 = phi i8* [ %t9, %then0 ], [ %t4, %block.entry ]
  store i8* %t10, i8** %l0
  %t11 = load i8*, i8** %l0
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 40, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  %t15 = call double @index_of(i8* %t11, i8* %t13)
  store double %t15, double* %l1
  %t16 = load i8*, i8** %l0
  store i8* %t16, i8** %l2
  %t17 = load double, double* %l1
  %t18 = sitofp i64 0 to double
  %t19 = fcmp oge double %t17, %t18
  %t20 = load i8*, i8** %l0
  %t21 = load double, double* %l1
  %t22 = load i8*, i8** %l2
  br i1 %t19, label %then2, label %merge3
then2:
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  %t25 = call double @llvm.round.f64(double %t24)
  %t26 = fptosi double %t25 to i64
  %t27 = call i8* @sailfin_runtime_substring(i8* %t23, i64 0, i64 %t26)
  %t28 = call i8* @trim_text__native_ir(i8* %t27)
  store i8* %t28, i8** %l2
  %t29 = load i8*, i8** %l2
  br label %merge3
merge3:
  %t30 = phi i8* [ %t29, %then2 ], [ %t22, %merge1 ]
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  %t32 = add i64 0, 2
  %t33 = call i8* @malloc(i64 %t32)
  store i8 46, i8* %t33
  %t34 = getelementptr i8, i8* %t33, i64 1
  store i8 0, i8* %t34
  call void @sailfin_runtime_mark_persistent(i8* %t33)
  %t35 = call double @last_index_of(i8* %t31, i8* %t33)
  store double %t35, double* %l3
  %t36 = load double, double* %l3
  %t37 = sitofp i64 0 to double
  %t38 = fcmp oge double %t36, %t37
  %t39 = load i8*, i8** %l0
  %t40 = load double, double* %l1
  %t41 = load i8*, i8** %l2
  %t42 = load double, double* %l3
  br i1 %t38, label %then4, label %merge5
then4:
  %t43 = load i8*, i8** %l2
  %t44 = load double, double* %l3
  %t45 = sitofp i64 1 to double
  %t46 = fadd double %t44, %t45
  %t47 = load i8*, i8** %l2
  %t48 = call i64 @sailfin_runtime_string_length(i8* %t47)
  %t49 = call double @llvm.round.f64(double %t46)
  %t50 = fptosi double %t49 to i64
  %t51 = call i8* @sailfin_runtime_substring(i8* %t43, i64 %t50, i64 %t48)
  %t52 = call i8* @trim_text__native_ir(i8* %t51)
  store i8* %t52, i8** %l2
  %t53 = load i8*, i8** %l2
  br label %merge5
merge5:
  %t54 = phi i8* [ %t53, %then4 ], [ %t41, %merge3 ]
  store i8* %t54, i8** %l2
  %t55 = load i8*, i8** %l2
  %t56 = call i8* @strip_generics(i8* %t55)
  call void @sailfin_runtime_mark_persistent(i8* %t56)
  ret i8* %t56
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
  %t0 = call i8* @trim_text__native_ir(i8* %body)
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
  %t14 = call i8* @trim_text__native_ir(i8* %t13)
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
  %t66 = phi i8* [ %t23, %merge3 ], [ %t64, %loop.latch6 ]
  %t67 = phi double [ %t24, %merge3 ], [ %t65, %loop.latch6 ]
  store i8* %t66, i8** %l2
  store double %t67, double* %l3
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
  %t57 = add i64 0, 2
  %t58 = call i8* @malloc(i64 %t57)
  store i8 %t56, i8* %t58
  %t59 = getelementptr i8, i8* %t58, i64 1
  store i8 0, i8* %t59
  call void @sailfin_runtime_mark_persistent(i8* %t58)
  %t60 = call i8* @sailfin_runtime_string_concat(i8* %t55, i8* %t58)
  store i8* %t60, i8** %l2
  %t61 = load double, double* %l3
  %t62 = sitofp i64 1 to double
  %t63 = fadd double %t61, %t62
  store double %t63, double* %l3
  br label %loop.latch6
loop.latch6:
  %t64 = load i8*, i8** %l2
  %t65 = load double, double* %l3
  br label %loop.header4
afterloop7:
  %t68 = load i8*, i8** %l2
  %t69 = load double, double* %l3
  %t70 = load i8*, i8** %l2
  %t71 = call i8* @trim_text__native_ir(i8* %t70)
  store i8* %t71, i8** %l2
  %t72 = load i8*, i8** %l2
  %t73 = call i64 @sailfin_runtime_string_length(i8* %t72)
  %t74 = icmp eq i64 %t73, 0
  %t75 = load i8*, i8** %l0
  %t76 = load i1, i1* %l1
  %t77 = load i8*, i8** %l2
  %t78 = load double, double* %l3
  br i1 %t74, label %then12, label %merge13
then12:
  %t79 = bitcast i8* null to %NativeParameter*
  ret %NativeParameter* %t79
merge13:
  %s80 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s80, i8** %l5
  store i8* null, i8** %l6
  %t81 = load i8*, i8** %l0
  %t82 = load double, double* %l3
  %t83 = load i8*, i8** %l0
  %t84 = call i64 @sailfin_runtime_string_length(i8* %t83)
  %t85 = call double @llvm.round.f64(double %t82)
  %t86 = fptosi double %t85 to i64
  %t87 = call i8* @sailfin_runtime_substring(i8* %t81, i64 %t86, i64 %t84)
  %t88 = call i8* @trim_text__native_ir(i8* %t87)
  store i8* %t88, i8** %l7
  %t89 = load i8*, i8** %l7
  %t90 = call i64 @sailfin_runtime_string_length(i8* %t89)
  %t91 = icmp sgt i64 %t90, 0
  %t92 = load i8*, i8** %l0
  %t93 = load i1, i1* %l1
  %t94 = load i8*, i8** %l2
  %t95 = load double, double* %l3
  %t96 = load i8*, i8** %l5
  %t97 = load i8*, i8** %l6
  %t98 = load i8*, i8** %l7
  br i1 %t91, label %then14, label %merge15
then14:
  %t99 = load i8*, i8** %l7
  %s100 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t101 = call i1 @starts_with(i8* %t99, i8* %s100)
  %t102 = load i8*, i8** %l0
  %t103 = load i1, i1* %l1
  %t104 = load i8*, i8** %l2
  %t105 = load double, double* %l3
  %t106 = load i8*, i8** %l5
  %t107 = load i8*, i8** %l6
  %t108 = load i8*, i8** %l7
  br i1 %t101, label %then16, label %else17
then16:
  %t109 = load i8*, i8** %l7
  %s110 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t111 = call i8* @strip_prefix(i8* %t109, i8* %s110)
  %t112 = call i8* @trim_text__native_ir(i8* %t111)
  store i8* %t112, i8** %l7
  %t113 = load i8*, i8** %l7
  %t114 = add i64 0, 2
  %t115 = call i8* @malloc(i64 %t114)
  store i8 61, i8* %t115
  %t116 = getelementptr i8, i8* %t115, i64 1
  store i8 0, i8* %t116
  call void @sailfin_runtime_mark_persistent(i8* %t115)
  %t117 = call double @index_of(i8* %t113, i8* %t115)
  store double %t117, double* %l8
  %t118 = load double, double* %l8
  %t119 = sitofp i64 0 to double
  %t120 = fcmp oge double %t118, %t119
  %t121 = load i8*, i8** %l0
  %t122 = load i1, i1* %l1
  %t123 = load i8*, i8** %l2
  %t124 = load double, double* %l3
  %t125 = load i8*, i8** %l5
  %t126 = load i8*, i8** %l6
  %t127 = load i8*, i8** %l7
  %t128 = load double, double* %l8
  br i1 %t120, label %then19, label %else20
then19:
  %t129 = load i8*, i8** %l7
  %t130 = load double, double* %l8
  %t131 = call double @llvm.round.f64(double %t130)
  %t132 = fptosi double %t131 to i64
  %t133 = call i8* @sailfin_runtime_substring(i8* %t129, i64 0, i64 %t132)
  %t134 = call i8* @trim_text__native_ir(i8* %t133)
  store i8* %t134, i8** %l5
  %t135 = load i8*, i8** %l7
  %t136 = load double, double* %l8
  %t137 = sitofp i64 1 to double
  %t138 = fadd double %t136, %t137
  %t139 = load i8*, i8** %l7
  %t140 = call i64 @sailfin_runtime_string_length(i8* %t139)
  %t141 = call double @llvm.round.f64(double %t138)
  %t142 = fptosi double %t141 to i64
  %t143 = call i8* @sailfin_runtime_substring(i8* %t135, i64 %t142, i64 %t140)
  %t144 = call i8* @trim_text__native_ir(i8* %t143)
  store i8* %t144, i8** %l9
  %t145 = load i8*, i8** %l9
  %t146 = call i64 @sailfin_runtime_string_length(i8* %t145)
  %t147 = icmp sgt i64 %t146, 0
  %t148 = load i8*, i8** %l0
  %t149 = load i1, i1* %l1
  %t150 = load i8*, i8** %l2
  %t151 = load double, double* %l3
  %t152 = load i8*, i8** %l5
  %t153 = load i8*, i8** %l6
  %t154 = load i8*, i8** %l7
  %t155 = load double, double* %l8
  %t156 = load i8*, i8** %l9
  br i1 %t147, label %then22, label %merge23
then22:
  %t157 = load i8*, i8** %l9
  store i8* %t157, i8** %l6
  %t158 = load i8*, i8** %l6
  br label %merge23
merge23:
  %t159 = phi i8* [ %t158, %then22 ], [ %t153, %then19 ]
  store i8* %t159, i8** %l6
  %t160 = load i8*, i8** %l5
  %t161 = load i8*, i8** %l6
  br label %merge21
else20:
  %t162 = load i8*, i8** %l7
  %t163 = call i8* @trim_text__native_ir(i8* %t162)
  store i8* %t163, i8** %l5
  %t164 = load i8*, i8** %l5
  br label %merge21
merge21:
  %t165 = phi i8* [ %t160, %merge23 ], [ %t164, %else20 ]
  %t166 = phi i8* [ %t161, %merge23 ], [ %t126, %else20 ]
  store i8* %t165, i8** %l5
  store i8* %t166, i8** %l6
  %t167 = load i8*, i8** %l7
  %t168 = load i8*, i8** %l5
  %t169 = load i8*, i8** %l6
  %t170 = load i8*, i8** %l5
  br label %merge18
else17:
  %t171 = load i8*, i8** %l7
  %t172 = add i64 0, 2
  %t173 = call i8* @malloc(i64 %t172)
  store i8 61, i8* %t173
  %t174 = getelementptr i8, i8* %t173, i64 1
  store i8 0, i8* %t174
  call void @sailfin_runtime_mark_persistent(i8* %t173)
  %t175 = call i1 @starts_with(i8* %t171, i8* %t173)
  %t176 = load i8*, i8** %l0
  %t177 = load i1, i1* %l1
  %t178 = load i8*, i8** %l2
  %t179 = load double, double* %l3
  %t180 = load i8*, i8** %l5
  %t181 = load i8*, i8** %l6
  %t182 = load i8*, i8** %l7
  br i1 %t175, label %then24, label %merge25
then24:
  %t183 = load i8*, i8** %l7
  %t184 = add i64 0, 2
  %t185 = call i8* @malloc(i64 %t184)
  store i8 61, i8* %t185
  %t186 = getelementptr i8, i8* %t185, i64 1
  store i8 0, i8* %t186
  call void @sailfin_runtime_mark_persistent(i8* %t185)
  %t187 = call i8* @strip_prefix(i8* %t183, i8* %t185)
  %t188 = call i8* @trim_text__native_ir(i8* %t187)
  store i8* %t188, i8** %l10
  %t189 = load i8*, i8** %l10
  %t190 = call i64 @sailfin_runtime_string_length(i8* %t189)
  %t191 = icmp sgt i64 %t190, 0
  %t192 = load i8*, i8** %l0
  %t193 = load i1, i1* %l1
  %t194 = load i8*, i8** %l2
  %t195 = load double, double* %l3
  %t196 = load i8*, i8** %l5
  %t197 = load i8*, i8** %l6
  %t198 = load i8*, i8** %l7
  %t199 = load i8*, i8** %l10
  br i1 %t191, label %then26, label %merge27
then26:
  %t200 = load i8*, i8** %l10
  store i8* %t200, i8** %l6
  %t201 = load i8*, i8** %l6
  br label %merge27
merge27:
  %t202 = phi i8* [ %t201, %then26 ], [ %t197, %then24 ]
  store i8* %t202, i8** %l6
  %t203 = load i8*, i8** %l6
  br label %merge25
merge25:
  %t204 = phi i8* [ %t203, %merge27 ], [ %t181, %else17 ]
  store i8* %t204, i8** %l6
  %t205 = load i8*, i8** %l6
  br label %merge18
merge18:
  %t206 = phi i8* [ %t167, %merge21 ], [ %t108, %merge25 ]
  %t207 = phi i8* [ %t168, %merge21 ], [ %t106, %merge25 ]
  %t208 = phi i8* [ %t169, %merge21 ], [ %t205, %merge25 ]
  store i8* %t206, i8** %l7
  store i8* %t207, i8** %l5
  store i8* %t208, i8** %l6
  %t209 = load i8*, i8** %l7
  %t210 = load i8*, i8** %l5
  %t211 = load i8*, i8** %l6
  %t212 = load i8*, i8** %l5
  %t213 = load i8*, i8** %l6
  br label %merge15
merge15:
  %t214 = phi i8* [ %t209, %merge18 ], [ %t98, %merge13 ]
  %t215 = phi i8* [ %t210, %merge18 ], [ %t96, %merge13 ]
  %t216 = phi i8* [ %t211, %merge18 ], [ %t97, %merge13 ]
  %t217 = phi i8* [ %t212, %merge18 ], [ %t96, %merge13 ]
  %t218 = phi i8* [ %t213, %merge18 ], [ %t97, %merge13 ]
  store i8* %t214, i8** %l7
  store i8* %t215, i8** %l5
  store i8* %t216, i8** %l6
  store i8* %t217, i8** %l5
  store i8* %t218, i8** %l6
  %t219 = load i8*, i8** %l2
  %t220 = insertvalue %NativeParameter undef, i8* %t219, 0
  %t221 = load i8*, i8** %l5
  %t222 = insertvalue %NativeParameter %t220, i8* %t221, 1
  %t223 = load i1, i1* %l1
  %t224 = insertvalue %NativeParameter %t222, i1 %t223, 2
  %t225 = load i8*, i8** %l6
  %t226 = insertvalue %NativeParameter %t224, i8* %t225, 3
  %t227 = insertvalue %NativeParameter %t226, %NativeSourceSpan* %span, 4
  %t228 = alloca %NativeParameter
  store %NativeParameter %t227, %NativeParameter* %t228
  ret %NativeParameter* %t228
}

define i1 @line_looks_like_parameter_entry(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %l1 = alloca double
  %l2 = alloca i8*
  %l3 = alloca double
  %l4 = alloca i8*
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t6 = add i64 0, 2
  %t7 = call i8* @malloc(i64 %t6)
  store i8 46, i8* %t7
  %t8 = getelementptr i8, i8* %t7, i64 1
  store i8 0, i8* %t8
  call void @sailfin_runtime_mark_persistent(i8* %t7)
  %t9 = call i1 @starts_with(i8* %t5, i8* %t7)
  %t10 = load i8*, i8** %l0
  br i1 %t9, label %then2, label %merge3
then2:
  ret i1 0
merge3:
  %t11 = load i8*, i8** %l0
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 59, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  %t15 = call i1 @starts_with(i8* %t11, i8* %t13)
  %t16 = load i8*, i8** %l0
  br i1 %t15, label %then4, label %merge5
then4:
  ret i1 0
merge5:
  %t17 = load i8*, i8** %l0
  %s18 = getelementptr inbounds [3 x i8], [3 x i8]* @.str.len2.h193428050, i32 0, i32 0
  %t19 = call double @index_of(i8* %t17, i8* %s18)
  store double %t19, double* %l1
  %t20 = load double, double* %l1
  %t21 = sitofp i64 0 to double
  %t22 = fcmp oge double %t20, %t21
  %t23 = load i8*, i8** %l0
  %t24 = load double, double* %l1
  br i1 %t22, label %then6, label %merge7
then6:
  %t25 = load i8*, i8** %l0
  %t26 = load double, double* %l1
  %t27 = call double @llvm.round.f64(double %t26)
  %t28 = fptosi double %t27 to i64
  %t29 = call i8* @sailfin_runtime_substring(i8* %t25, i64 0, i64 %t28)
  %t30 = call i8* @trim_text__native_ir(i8* %t29)
  store i8* %t30, i8** %l2
  %t31 = load i8*, i8** %l2
  %t32 = call i64 @sailfin_runtime_string_length(i8* %t31)
  %t33 = icmp eq i64 %t32, 0
  %t34 = load i8*, i8** %l0
  %t35 = load double, double* %l1
  %t36 = load i8*, i8** %l2
  br i1 %t33, label %then8, label %merge9
then8:
  ret i1 0
merge9:
  %t37 = load i8*, i8** %l2
  %s38 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t39 = call i1 @starts_with(i8* %t37, i8* %s38)
  %t40 = load i8*, i8** %l0
  %t41 = load double, double* %l1
  %t42 = load i8*, i8** %l2
  br i1 %t39, label %then10, label %merge11
then10:
  %t43 = load i8*, i8** %l2
  %s44 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t45 = call i8* @strip_prefix(i8* %t43, i8* %s44)
  %t46 = call i8* @trim_text__native_ir(i8* %t45)
  store i8* %t46, i8** %l2
  %t47 = load i8*, i8** %l2
  br label %merge11
merge11:
  %t48 = phi i8* [ %t47, %then10 ], [ %t42, %merge9 ]
  store i8* %t48, i8** %l2
  %t49 = load i8*, i8** %l2
  %t50 = call i64 @sailfin_runtime_string_length(i8* %t49)
  %t51 = icmp eq i64 %t50, 0
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  %t54 = load i8*, i8** %l2
  br i1 %t51, label %then12, label %merge13
then12:
  ret i1 0
merge13:
  %t55 = load i8*, i8** %l2
  %t56 = add i64 0, 2
  %t57 = call i8* @malloc(i64 %t56)
  store i8 32, i8* %t57
  %t58 = getelementptr i8, i8* %t57, i64 1
  store i8 0, i8* %t58
  call void @sailfin_runtime_mark_persistent(i8* %t57)
  %t59 = call double @index_of(i8* %t55, i8* %t57)
  %t60 = sitofp i64 0 to double
  %t61 = fcmp oge double %t59, %t60
  %t62 = load i8*, i8** %l0
  %t63 = load double, double* %l1
  %t64 = load i8*, i8** %l2
  br i1 %t61, label %then14, label %merge15
then14:
  ret i1 0
merge15:
  %t65 = load i8*, i8** %l2
  %t66 = add i64 0, 2
  %t67 = call i8* @malloc(i64 %t66)
  store i8 9, i8* %t67
  %t68 = getelementptr i8, i8* %t67, i64 1
  store i8 0, i8* %t68
  call void @sailfin_runtime_mark_persistent(i8* %t67)
  %t69 = call double @index_of(i8* %t65, i8* %t67)
  %t70 = sitofp i64 0 to double
  %t71 = fcmp oge double %t69, %t70
  %t72 = load i8*, i8** %l0
  %t73 = load double, double* %l1
  %t74 = load i8*, i8** %l2
  br i1 %t71, label %then16, label %merge17
then16:
  ret i1 0
merge17:
  ret i1 1
merge7:
  %t75 = load i8*, i8** %l0
  %t76 = add i64 0, 2
  %t77 = call i8* @malloc(i64 %t76)
  store i8 61, i8* %t77
  %t78 = getelementptr i8, i8* %t77, i64 1
  store i8 0, i8* %t78
  call void @sailfin_runtime_mark_persistent(i8* %t77)
  %t79 = call double @index_of(i8* %t75, i8* %t77)
  store double %t79, double* %l3
  %t80 = load double, double* %l3
  %t81 = sitofp i64 0 to double
  %t82 = fcmp oge double %t80, %t81
  %t83 = load i8*, i8** %l0
  %t84 = load double, double* %l1
  %t85 = load double, double* %l3
  br i1 %t82, label %then18, label %merge19
then18:
  %t86 = load i8*, i8** %l0
  %t87 = load double, double* %l3
  %t88 = call double @llvm.round.f64(double %t87)
  %t89 = fptosi double %t88 to i64
  %t90 = call i8* @sailfin_runtime_substring(i8* %t86, i64 0, i64 %t89)
  %t91 = call i8* @trim_text__native_ir(i8* %t90)
  store i8* %t91, i8** %l4
  %t92 = load i8*, i8** %l4
  %t93 = call i64 @sailfin_runtime_string_length(i8* %t92)
  %t94 = icmp eq i64 %t93, 0
  %t95 = load i8*, i8** %l0
  %t96 = load double, double* %l1
  %t97 = load double, double* %l3
  %t98 = load i8*, i8** %l4
  br i1 %t94, label %then20, label %merge21
then20:
  ret i1 0
merge21:
  %t99 = load i8*, i8** %l4
  %s100 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t101 = call i1 @starts_with(i8* %t99, i8* %s100)
  %t102 = load i8*, i8** %l0
  %t103 = load double, double* %l1
  %t104 = load double, double* %l3
  %t105 = load i8*, i8** %l4
  br i1 %t101, label %then22, label %merge23
then22:
  %t106 = load i8*, i8** %l4
  %s107 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h267749729, i32 0, i32 0
  %t108 = call i8* @strip_prefix(i8* %t106, i8* %s107)
  %t109 = call i8* @trim_text__native_ir(i8* %t108)
  store i8* %t109, i8** %l4
  %t110 = load i8*, i8** %l4
  br label %merge23
merge23:
  %t111 = phi i8* [ %t110, %then22 ], [ %t105, %merge21 ]
  store i8* %t111, i8** %l4
  %t112 = load i8*, i8** %l4
  %t113 = call i64 @sailfin_runtime_string_length(i8* %t112)
  %t114 = icmp eq i64 %t113, 0
  %t115 = load i8*, i8** %l0
  %t116 = load double, double* %l1
  %t117 = load double, double* %l3
  %t118 = load i8*, i8** %l4
  br i1 %t114, label %then24, label %merge25
then24:
  ret i1 0
merge25:
  %t119 = load i8*, i8** %l4
  %t120 = add i64 0, 2
  %t121 = call i8* @malloc(i64 %t120)
  store i8 32, i8* %t121
  %t122 = getelementptr i8, i8* %t121, i64 1
  store i8 0, i8* %t122
  call void @sailfin_runtime_mark_persistent(i8* %t121)
  %t123 = call double @index_of(i8* %t119, i8* %t121)
  %t124 = sitofp i64 0 to double
  %t125 = fcmp oge double %t123, %t124
  %t126 = load i8*, i8** %l0
  %t127 = load double, double* %l1
  %t128 = load double, double* %l3
  %t129 = load i8*, i8** %l4
  br i1 %t125, label %then26, label %merge27
then26:
  ret i1 0
merge27:
  %t130 = load i8*, i8** %l4
  %t131 = add i64 0, 2
  %t132 = call i8* @malloc(i64 %t131)
  store i8 9, i8* %t132
  %t133 = getelementptr i8, i8* %t132, i64 1
  store i8 0, i8* %t133
  call void @sailfin_runtime_mark_persistent(i8* %t132)
  %t134 = call double @index_of(i8* %t130, i8* %t132)
  %t135 = sitofp i64 0 to double
  %t136 = fcmp oge double %t134, %t135
  %t137 = load i8*, i8** %l0
  %t138 = load double, double* %l1
  %t139 = load double, double* %l3
  %t140 = load i8*, i8** %l4
  br i1 %t136, label %then28, label %merge29
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
  %t255 = phi i8* [ %t17, %block.entry ], [ %t250, %loop.latch2 ]
  %t256 = phi double [ %t18, %block.entry ], [ %t251, %loop.latch2 ]
  %t257 = phi i8* [ %t20, %block.entry ], [ %t252, %loop.latch2 ]
  %t258 = phi double [ %t19, %block.entry ], [ %t253, %loop.latch2 ]
  %t259 = phi { i8**, i64 }* [ %t16, %block.entry ], [ %t254, %loop.latch2 ]
  store i8* %t255, i8** %l1
  store double %t256, double* %l2
  store i8* %t257, i8** %l4
  store double %t258, double* %l3
  store { i8**, i64 }* %t259, { i8**, i64 }** %l0
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
  %t46 = add i64 0, 2
  %t47 = call i8* @malloc(i64 %t46)
  store i8 %t45, i8* %t47
  %t48 = getelementptr i8, i8* %t47, i64 1
  store i8 0, i8* %t48
  call void @sailfin_runtime_mark_persistent(i8* %t47)
  %t49 = call i8* @sailfin_runtime_string_concat(i8* %t44, i8* %t47)
  store i8* %t49, i8** %l1
  %t50 = load i8, i8* %l5
  %t51 = icmp eq i8 %t50, 92
  %t52 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t53 = load i8*, i8** %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load i8*, i8** %l4
  %t57 = load i8, i8* %l5
  br i1 %t51, label %then8, label %merge9
then8:
  %t58 = load double, double* %l2
  %t59 = sitofp i64 1 to double
  %t60 = fadd double %t58, %t59
  %t61 = call i64 @sailfin_runtime_string_length(i8* %body)
  %t62 = sitofp i64 %t61 to double
  %t63 = fcmp olt double %t60, %t62
  %t64 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t65 = load i8*, i8** %l1
  %t66 = load double, double* %l2
  %t67 = load double, double* %l3
  %t68 = load i8*, i8** %l4
  %t69 = load i8, i8* %l5
  br i1 %t63, label %then10, label %merge11
then10:
  %t70 = load i8*, i8** %l1
  %t71 = load double, double* %l2
  %t72 = sitofp i64 1 to double
  %t73 = fadd double %t71, %t72
  %t74 = call double @llvm.round.f64(double %t73)
  %t75 = fptosi double %t74 to i64
  %t76 = getelementptr i8, i8* %body, i64 %t75
  %t77 = load i8, i8* %t76
  %t78 = add i64 0, 2
  %t79 = call i8* @malloc(i64 %t78)
  store i8 %t77, i8* %t79
  %t80 = getelementptr i8, i8* %t79, i64 1
  store i8 0, i8* %t80
  call void @sailfin_runtime_mark_persistent(i8* %t79)
  %t81 = call i8* @sailfin_runtime_string_concat(i8* %t70, i8* %t79)
  store i8* %t81, i8** %l1
  %t82 = load double, double* %l2
  %t83 = sitofp i64 2 to double
  %t84 = fadd double %t82, %t83
  store double %t84, double* %l2
  br label %loop.latch2
merge11:
  %t85 = load i8*, i8** %l1
  %t86 = load double, double* %l2
  br label %merge9
merge9:
  %t87 = phi i8* [ %t85, %merge11 ], [ %t53, %then6 ]
  %t88 = phi double [ %t86, %merge11 ], [ %t54, %then6 ]
  store i8* %t87, i8** %l1
  store double %t88, double* %l2
  %t89 = load i8, i8* %l5
  %t90 = load i8*, i8** %l4
  %t91 = load i8, i8* %t90
  %t92 = icmp eq i8 %t89, %t91
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load i8*, i8** %l1
  %t95 = load double, double* %l2
  %t96 = load double, double* %l3
  %t97 = load i8*, i8** %l4
  %t98 = load i8, i8* %l5
  br i1 %t92, label %then12, label %merge13
then12:
  %s99 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s99, i8** %l4
  %t100 = load i8*, i8** %l4
  br label %merge13
merge13:
  %t101 = phi i8* [ %t100, %then12 ], [ %t97, %merge9 ]
  store i8* %t101, i8** %l4
  %t102 = load double, double* %l2
  %t103 = sitofp i64 1 to double
  %t104 = fadd double %t102, %t103
  store double %t104, double* %l2
  br label %loop.latch2
merge7:
  %t106 = load i8, i8* %l5
  %t107 = icmp eq i8 %t106, 34
  br label %logical_or_entry_105

logical_or_entry_105:
  br i1 %t107, label %logical_or_merge_105, label %logical_or_right_105

logical_or_right_105:
  %t108 = load i8, i8* %l5
  %t109 = icmp eq i8 %t108, 39
  br label %logical_or_right_end_105

logical_or_right_end_105:
  br label %logical_or_merge_105

logical_or_merge_105:
  %t110 = phi i1 [ true, %logical_or_entry_105 ], [ %t109, %logical_or_right_end_105 ]
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t112 = load i8*, i8** %l1
  %t113 = load double, double* %l2
  %t114 = load double, double* %l3
  %t115 = load i8*, i8** %l4
  %t116 = load i8, i8* %l5
  br i1 %t110, label %then14, label %merge15
then14:
  %t117 = load i8, i8* %l5
  %t118 = add i64 0, 2
  %t119 = call i8* @malloc(i64 %t118)
  store i8 %t117, i8* %t119
  %t120 = getelementptr i8, i8* %t119, i64 1
  store i8 0, i8* %t120
  call void @sailfin_runtime_mark_persistent(i8* %t119)
  store i8* %t119, i8** %l4
  %t121 = load i8*, i8** %l1
  %t122 = load i8, i8* %l5
  %t123 = add i64 0, 2
  %t124 = call i8* @malloc(i64 %t123)
  store i8 %t122, i8* %t124
  %t125 = getelementptr i8, i8* %t124, i64 1
  store i8 0, i8* %t125
  call void @sailfin_runtime_mark_persistent(i8* %t124)
  %t126 = call i8* @sailfin_runtime_string_concat(i8* %t121, i8* %t124)
  store i8* %t126, i8** %l1
  %t127 = load double, double* %l2
  %t128 = sitofp i64 1 to double
  %t129 = fadd double %t127, %t128
  store double %t129, double* %l2
  br label %loop.latch2
merge15:
  %t131 = load i8, i8* %l5
  %t132 = icmp eq i8 %t131, 40
  br label %logical_or_entry_130

logical_or_entry_130:
  br i1 %t132, label %logical_or_merge_130, label %logical_or_right_130

logical_or_right_130:
  %t134 = load i8, i8* %l5
  %t135 = icmp eq i8 %t134, 91
  br label %logical_or_entry_133

logical_or_entry_133:
  br i1 %t135, label %logical_or_merge_133, label %logical_or_right_133

logical_or_right_133:
  %t136 = load i8, i8* %l5
  %t137 = icmp eq i8 %t136, 123
  br label %logical_or_right_end_133

logical_or_right_end_133:
  br label %logical_or_merge_133

logical_or_merge_133:
  %t138 = phi i1 [ true, %logical_or_entry_133 ], [ %t137, %logical_or_right_end_133 ]
  br label %logical_or_right_end_130

logical_or_right_end_130:
  br label %logical_or_merge_130

logical_or_merge_130:
  %t139 = phi i1 [ true, %logical_or_entry_130 ], [ %t138, %logical_or_right_end_130 ]
  %t140 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t141 = load i8*, i8** %l1
  %t142 = load double, double* %l2
  %t143 = load double, double* %l3
  %t144 = load i8*, i8** %l4
  %t145 = load i8, i8* %l5
  br i1 %t139, label %then16, label %merge17
then16:
  %t146 = load double, double* %l3
  %t147 = sitofp i64 1 to double
  %t148 = fadd double %t146, %t147
  store double %t148, double* %l3
  %t149 = load i8*, i8** %l1
  %t150 = load i8, i8* %l5
  %t151 = add i64 0, 2
  %t152 = call i8* @malloc(i64 %t151)
  store i8 %t150, i8* %t152
  %t153 = getelementptr i8, i8* %t152, i64 1
  store i8 0, i8* %t153
  call void @sailfin_runtime_mark_persistent(i8* %t152)
  %t154 = call i8* @sailfin_runtime_string_concat(i8* %t149, i8* %t152)
  store i8* %t154, i8** %l1
  %t155 = load double, double* %l2
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l2
  br label %loop.latch2
merge17:
  %t159 = load i8, i8* %l5
  %t160 = icmp eq i8 %t159, 41
  br label %logical_or_entry_158

logical_or_entry_158:
  br i1 %t160, label %logical_or_merge_158, label %logical_or_right_158

logical_or_right_158:
  %t162 = load i8, i8* %l5
  %t163 = icmp eq i8 %t162, 93
  br label %logical_or_entry_161

logical_or_entry_161:
  br i1 %t163, label %logical_or_merge_161, label %logical_or_right_161

logical_or_right_161:
  %t164 = load i8, i8* %l5
  %t165 = icmp eq i8 %t164, 125
  br label %logical_or_right_end_161

logical_or_right_end_161:
  br label %logical_or_merge_161

logical_or_merge_161:
  %t166 = phi i1 [ true, %logical_or_entry_161 ], [ %t165, %logical_or_right_end_161 ]
  br label %logical_or_right_end_158

logical_or_right_end_158:
  br label %logical_or_merge_158

logical_or_merge_158:
  %t167 = phi i1 [ true, %logical_or_entry_158 ], [ %t166, %logical_or_right_end_158 ]
  %t168 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t169 = load i8*, i8** %l1
  %t170 = load double, double* %l2
  %t171 = load double, double* %l3
  %t172 = load i8*, i8** %l4
  %t173 = load i8, i8* %l5
  br i1 %t167, label %then18, label %merge19
then18:
  %t174 = load double, double* %l3
  %t175 = sitofp i64 0 to double
  %t176 = fcmp ogt double %t174, %t175
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t178 = load i8*, i8** %l1
  %t179 = load double, double* %l2
  %t180 = load double, double* %l3
  %t181 = load i8*, i8** %l4
  %t182 = load i8, i8* %l5
  br i1 %t176, label %then20, label %merge21
then20:
  %t183 = load double, double* %l3
  %t184 = sitofp i64 1 to double
  %t185 = fsub double %t183, %t184
  store double %t185, double* %l3
  %t186 = load double, double* %l3
  br label %merge21
merge21:
  %t187 = phi double [ %t186, %then20 ], [ %t180, %then18 ]
  store double %t187, double* %l3
  %t188 = load i8*, i8** %l1
  %t189 = load i8, i8* %l5
  %t190 = add i64 0, 2
  %t191 = call i8* @malloc(i64 %t190)
  store i8 %t189, i8* %t191
  %t192 = getelementptr i8, i8* %t191, i64 1
  store i8 0, i8* %t192
  call void @sailfin_runtime_mark_persistent(i8* %t191)
  %t193 = call i8* @sailfin_runtime_string_concat(i8* %t188, i8* %t191)
  store i8* %t193, i8** %l1
  %t194 = load double, double* %l2
  %t195 = sitofp i64 1 to double
  %t196 = fadd double %t194, %t195
  store double %t196, double* %l2
  br label %loop.latch2
merge19:
  %t197 = load i8, i8* %l5
  %t198 = icmp eq i8 %t197, 44
  %t199 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t200 = load i8*, i8** %l1
  %t201 = load double, double* %l2
  %t202 = load double, double* %l3
  %t203 = load i8*, i8** %l4
  %t204 = load i8, i8* %l5
  br i1 %t198, label %then22, label %merge23
then22:
  %t205 = load double, double* %l3
  %t206 = sitofp i64 0 to double
  %t207 = fcmp oeq double %t205, %t206
  %t208 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t209 = load i8*, i8** %l1
  %t210 = load double, double* %l2
  %t211 = load double, double* %l3
  %t212 = load i8*, i8** %l4
  %t213 = load i8, i8* %l5
  br i1 %t207, label %then24, label %merge25
then24:
  %t214 = load i8*, i8** %l1
  %t215 = call i8* @trim_text__native_ir(i8* %t214)
  store i8* %t215, i8** %l6
  %t216 = load i8*, i8** %l6
  %t217 = call i64 @sailfin_runtime_string_length(i8* %t216)
  %t218 = icmp sgt i64 %t217, 0
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t220 = load i8*, i8** %l1
  %t221 = load double, double* %l2
  %t222 = load double, double* %l3
  %t223 = load i8*, i8** %l4
  %t224 = load i8, i8* %l5
  %t225 = load i8*, i8** %l6
  br i1 %t218, label %then26, label %merge27
then26:
  %t226 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t227 = load i8*, i8** %l6
  %t228 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t226, i8* %t227)
  store { i8**, i64 }* %t228, { i8**, i64 }** %l0
  %t229 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge27
merge27:
  %t230 = phi { i8**, i64 }* [ %t229, %then26 ], [ %t219, %then24 ]
  store { i8**, i64 }* %t230, { i8**, i64 }** %l0
  %s231 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s231, i8** %l1
  %t232 = load double, double* %l2
  %t233 = sitofp i64 1 to double
  %t234 = fadd double %t232, %t233
  store double %t234, double* %l2
  br label %loop.latch2
merge25:
  %t235 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t236 = load i8*, i8** %l1
  %t237 = load double, double* %l2
  br label %merge23
merge23:
  %t238 = phi { i8**, i64 }* [ %t235, %merge25 ], [ %t199, %merge19 ]
  %t239 = phi i8* [ %t236, %merge25 ], [ %t200, %merge19 ]
  %t240 = phi double [ %t237, %merge25 ], [ %t201, %merge19 ]
  store { i8**, i64 }* %t238, { i8**, i64 }** %l0
  store i8* %t239, i8** %l1
  store double %t240, double* %l2
  %t241 = load i8*, i8** %l1
  %t242 = load i8, i8* %l5
  %t243 = add i64 0, 2
  %t244 = call i8* @malloc(i64 %t243)
  store i8 %t242, i8* %t244
  %t245 = getelementptr i8, i8* %t244, i64 1
  store i8 0, i8* %t245
  call void @sailfin_runtime_mark_persistent(i8* %t244)
  %t246 = call i8* @sailfin_runtime_string_concat(i8* %t241, i8* %t244)
  store i8* %t246, i8** %l1
  %t247 = load double, double* %l2
  %t248 = sitofp i64 1 to double
  %t249 = fadd double %t247, %t248
  store double %t249, double* %l2
  br label %loop.latch2
loop.latch2:
  %t250 = load i8*, i8** %l1
  %t251 = load double, double* %l2
  %t252 = load i8*, i8** %l4
  %t253 = load double, double* %l3
  %t254 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %loop.header0
afterloop3:
  %t260 = load i8*, i8** %l1
  %t261 = load double, double* %l2
  %t262 = load i8*, i8** %l4
  %t263 = load double, double* %l3
  %t264 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t265 = load i8*, i8** %l1
  %t266 = call i8* @trim_text__native_ir(i8* %t265)
  store i8* %t266, i8** %l7
  %t267 = load i8*, i8** %l7
  %t268 = call i64 @sailfin_runtime_string_length(i8* %t267)
  %t269 = icmp sgt i64 %t268, 0
  %t270 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t271 = load i8*, i8** %l1
  %t272 = load double, double* %l2
  %t273 = load double, double* %l3
  %t274 = load i8*, i8** %l4
  %t275 = load i8*, i8** %l7
  br i1 %t269, label %then28, label %merge29
then28:
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t277 = load i8*, i8** %l7
  %t278 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t276, i8* %t277)
  store { i8**, i64 }* %t278, { i8**, i64 }** %l0
  %t279 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge29
merge29:
  %t280 = phi { i8**, i64 }* [ %t279, %then28 ], [ %t270, %afterloop3 ]
  store { i8**, i64 }* %t280, { i8**, i64 }** %l0
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t281
}

define { i8**, i64 }* @parse_effect_list(i8* %text) {
block.entry:
  %l0 = alloca i8*
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t0 = call i8* @trim_text__native_ir(i8* %text)
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
  %t8 = add i64 0, 2
  %t9 = call i8* @malloc(i64 %t8)
  store i8 48, i8* %t9
  %t10 = getelementptr i8, i8* %t9, i64 1
  store i8 0, i8* %t10
  call void @sailfin_runtime_mark_persistent(i8* %t9)
  %t11 = call double @char_code(i8* %t9)
  store double %t11, double* %l1
  %t12 = add i64 0, 2
  %t13 = call i8* @malloc(i64 %t12)
  store i8 57, i8* %t13
  %t14 = getelementptr i8, i8* %t13, i64 1
  store i8 0, i8* %t14
  call void @sailfin_runtime_mark_persistent(i8* %t13)
  %t15 = call double @char_code(i8* %t13)
  store double %t15, double* %l2
  %t16 = sitofp i64 0 to double
  store double %t16, double* %l3
  %t17 = sitofp i64 0 to double
  store double %t17, double* %l4
  %t18 = load i8*, i8** %l0
  %t19 = load double, double* %l1
  %t20 = load double, double* %l2
  %t21 = load double, double* %l3
  %t22 = load double, double* %l4
  br label %loop.header2
loop.header2:
  %t75 = phi double [ %t22, %merge1 ], [ %t73, %loop.latch4 ]
  %t76 = phi double [ %t21, %merge1 ], [ %t74, %loop.latch4 ]
  store double %t75, double* %l4
  store double %t76, double* %l3
  br label %loop.body3
loop.body3:
  %t23 = load double, double* %l3
  %t24 = load i8*, i8** %l0
  %t25 = call i64 @sailfin_runtime_string_length(i8* %t24)
  %t26 = sitofp i64 %t25 to double
  %t27 = fcmp oge double %t23, %t26
  %t28 = load i8*, i8** %l0
  %t29 = load double, double* %l1
  %t30 = load double, double* %l2
  %t31 = load double, double* %l3
  %t32 = load double, double* %l4
  br i1 %t27, label %then6, label %merge7
then6:
  br label %afterloop5
merge7:
  %t33 = load i8*, i8** %l0
  %t34 = load double, double* %l3
  %t35 = call double @llvm.round.f64(double %t34)
  %t36 = fptosi double %t35 to i64
  %t37 = getelementptr i8, i8* %t33, i64 %t36
  %t38 = load i8, i8* %t37
  store i8 %t38, i8* %l5
  %t39 = load i8, i8* %l5
  %t40 = add i64 0, 2
  %t41 = call i8* @malloc(i64 %t40)
  store i8 %t39, i8* %t41
  %t42 = getelementptr i8, i8* %t41, i64 1
  store i8 0, i8* %t42
  call void @sailfin_runtime_mark_persistent(i8* %t41)
  %t43 = call double @char_code(i8* %t41)
  store double %t43, double* %l6
  %t45 = load double, double* %l6
  %t46 = load double, double* %l1
  %t47 = fcmp olt double %t45, %t46
  br label %logical_or_entry_44

logical_or_entry_44:
  br i1 %t47, label %logical_or_merge_44, label %logical_or_right_44

logical_or_right_44:
  %t48 = load double, double* %l6
  %t49 = load double, double* %l2
  %t50 = fcmp ogt double %t48, %t49
  br label %logical_or_right_end_44

logical_or_right_end_44:
  br label %logical_or_merge_44

logical_or_merge_44:
  %t51 = phi i1 [ true, %logical_or_entry_44 ], [ %t50, %logical_or_right_end_44 ]
  %t52 = load i8*, i8** %l0
  %t53 = load double, double* %l1
  %t54 = load double, double* %l2
  %t55 = load double, double* %l3
  %t56 = load double, double* %l4
  %t57 = load i8, i8* %l5
  %t58 = load double, double* %l6
  br i1 %t51, label %then8, label %merge9
then8:
  %t59 = insertvalue %NumberParseResult undef, i1 0, 0
  %t60 = sitofp i64 0 to double
  %t61 = insertvalue %NumberParseResult %t59, double %t60, 1
  ret %NumberParseResult %t61
merge9:
  %t62 = load double, double* %l6
  %t63 = load double, double* %l1
  %t64 = fsub double %t62, %t63
  store double %t64, double* %l7
  %t65 = load double, double* %l4
  %t66 = sitofp i64 10 to double
  %t67 = fmul double %t65, %t66
  %t68 = load double, double* %l7
  %t69 = fadd double %t67, %t68
  store double %t69, double* %l4
  %t70 = load double, double* %l3
  %t71 = sitofp i64 1 to double
  %t72 = fadd double %t70, %t71
  store double %t72, double* %l3
  br label %loop.latch4
loop.latch4:
  %t73 = load double, double* %l4
  %t74 = load double, double* %l3
  br label %loop.header2
afterloop5:
  %t77 = load double, double* %l4
  %t78 = load double, double* %l3
  %t79 = insertvalue %NumberParseResult undef, i1 1, 0
  %t80 = load double, double* %l4
  %t81 = insertvalue %NumberParseResult %t79, double %t80, 1
  ret %NumberParseResult %t81
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
  %t56 = phi { i8**, i64 }* [ %t14, %block.entry ], [ %t53, %loop.latch2 ]
  %t57 = phi i8* [ %t15, %block.entry ], [ %t54, %loop.latch2 ]
  %t58 = phi double [ %t16, %block.entry ], [ %t55, %loop.latch2 ]
  store { i8**, i64 }* %t56, { i8**, i64 }** %l0
  store i8* %t57, i8** %l1
  store double %t58, double* %l2
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
  %t43 = add i64 0, 2
  %t44 = call i8* @malloc(i64 %t43)
  store i8 %t42, i8* %t44
  %t45 = getelementptr i8, i8* %t44, i64 1
  store i8 0, i8* %t45
  call void @sailfin_runtime_mark_persistent(i8* %t44)
  %t46 = call i8* @sailfin_runtime_string_concat(i8* %t41, i8* %t44)
  store i8* %t46, i8** %l1
  %t47 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t48 = phi { i8**, i64 }* [ %t39, %then6 ], [ %t31, %else7 ]
  %t49 = phi i8* [ %t40, %then6 ], [ %t47, %else7 ]
  store { i8**, i64 }* %t48, { i8**, i64 }** %l0
  store i8* %t49, i8** %l1
  %t50 = load double, double* %l2
  %t51 = sitofp i64 1 to double
  %t52 = fadd double %t50, %t51
  store double %t52, double* %l2
  br label %loop.latch2
loop.latch2:
  %t53 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t54 = load i8*, i8** %l1
  %t55 = load double, double* %l2
  br label %loop.header0
afterloop3:
  %t59 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t60 = load i8*, i8** %l1
  %t61 = load double, double* %l2
  %t62 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t63 = load i8*, i8** %l1
  %t64 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t62, i8* %t63)
  store { i8**, i64 }* %t64, { i8**, i64 }** %l0
  %t65 = load { i8**, i64 }*, { i8**, i64 }** %l0
  ret { i8**, i64 }* %t65
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
  %t30 = icmp eq i8 %t29, 44
  %t31 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t32 = load i8*, i8** %l1
  %t33 = load double, double* %l2
  %t34 = load i8, i8* %l3
  br i1 %t30, label %then6, label %else7
then6:
  %t35 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t36 = load i8*, i8** %l1
  %t37 = call i8* @trim_text__native_ir(i8* %t36)
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
  %t44 = add i64 0, 2
  %t45 = call i8* @malloc(i64 %t44)
  store i8 %t43, i8* %t45
  %t46 = getelementptr i8, i8* %t45, i64 1
  store i8 0, i8* %t46
  call void @sailfin_runtime_mark_persistent(i8* %t45)
  %t47 = call i8* @sailfin_runtime_string_concat(i8* %t42, i8* %t45)
  store i8* %t47, i8** %l1
  %t48 = load i8*, i8** %l1
  br label %merge8
merge8:
  %t49 = phi { i8**, i64 }* [ %t40, %then6 ], [ %t31, %else7 ]
  %t50 = phi i8* [ %t41, %then6 ], [ %t48, %else7 ]
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
  %t63 = load i8*, i8** %l1
  %t64 = call i64 @sailfin_runtime_string_length(i8* %t63)
  %t65 = icmp sgt i64 %t64, 0
  %t66 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t67 = load i8*, i8** %l1
  %t68 = load double, double* %l2
  br i1 %t65, label %then9, label %merge10
then9:
  %t69 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t70 = load i8*, i8** %l1
  %t71 = call i8* @trim_text__native_ir(i8* %t70)
  %t72 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t69, i8* %t71)
  store { i8**, i64 }* %t72, { i8**, i64 }** %l0
  %t73 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge10
merge10:
  %t74 = phi { i8**, i64 }* [ %t73, %then9 ], [ %t66, %afterloop3 ]
  store { i8**, i64 }* %t74, { i8**, i64 }** %l0
  %t75 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t76 = ptrtoint [0 x i8*]* %t75 to i64
  %t77 = icmp eq i64 %t76, 0
  %t78 = select i1 %t77, i64 1, i64 %t76
  %t79 = call i8* @malloc(i64 %t78)
  %t80 = bitcast i8* %t79 to i8**
  %t81 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t82 = ptrtoint { i8**, i64 }* %t81 to i64
  %t83 = call i8* @malloc(i64 %t82)
  %t84 = bitcast i8* %t83 to { i8**, i64 }*
  %t85 = getelementptr { i8**, i64 }, { i8**, i64 }* %t84, i32 0, i32 0
  store i8** %t80, i8*** %t85
  %t86 = getelementptr { i8**, i64 }, { i8**, i64 }* %t84, i32 0, i32 1
  store i64 0, i64* %t86
  store { i8**, i64 }* %t84, { i8**, i64 }** %l4
  %t87 = sitofp i64 0 to double
  store double %t87, double* %l2
  %t88 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t89 = load i8*, i8** %l1
  %t90 = load double, double* %l2
  %t91 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %loop.header11
loop.header11:
  %t130 = phi { i8**, i64 }* [ %t91, %merge10 ], [ %t128, %loop.latch13 ]
  %t131 = phi double [ %t90, %merge10 ], [ %t129, %loop.latch13 ]
  store { i8**, i64 }* %t130, { i8**, i64 }** %l4
  store double %t131, double* %l2
  br label %loop.body12
loop.body12:
  %t92 = load double, double* %l2
  %t93 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t94 = load { i8**, i64 }, { i8**, i64 }* %t93
  %t95 = extractvalue { i8**, i64 } %t94, 1
  %t96 = sitofp i64 %t95 to double
  %t97 = fcmp oge double %t92, %t96
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t99 = load i8*, i8** %l1
  %t100 = load double, double* %l2
  %t101 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br i1 %t97, label %then15, label %merge16
then15:
  br label %afterloop14
merge16:
  %t102 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t103 = load double, double* %l2
  %t104 = call double @llvm.round.f64(double %t103)
  %t105 = fptosi double %t104 to i64
  %t106 = load { i8**, i64 }, { i8**, i64 }* %t102
  %t107 = extractvalue { i8**, i64 } %t106, 0
  %t108 = extractvalue { i8**, i64 } %t106, 1
  %t109 = icmp uge i64 %t105, %t108
  ; bounds check: %t109 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t105, i64 %t108)
  %t110 = getelementptr i8*, i8** %t107, i64 %t105
  %t111 = load i8*, i8** %t110
  store i8* %t111, i8** %l5
  %t112 = load i8*, i8** %l5
  %t113 = call i64 @sailfin_runtime_string_length(i8* %t112)
  %t114 = icmp sgt i64 %t113, 0
  %t115 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t116 = load i8*, i8** %l1
  %t117 = load double, double* %l2
  %t118 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t119 = load i8*, i8** %l5
  br i1 %t114, label %then17, label %merge18
then17:
  %t120 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t121 = load i8*, i8** %l5
  %t122 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t120, i8* %t121)
  store { i8**, i64 }* %t122, { i8**, i64 }** %l4
  %t123 = load { i8**, i64 }*, { i8**, i64 }** %l4
  br label %merge18
merge18:
  %t124 = phi { i8**, i64 }* [ %t123, %then17 ], [ %t118, %merge16 ]
  store { i8**, i64 }* %t124, { i8**, i64 }** %l4
  %t125 = load double, double* %l2
  %t126 = sitofp i64 1 to double
  %t127 = fadd double %t125, %t126
  store double %t127, double* %l2
  br label %loop.latch13
loop.latch13:
  %t128 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t129 = load double, double* %l2
  br label %loop.header11
afterloop14:
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l4
  %t133 = load double, double* %l2
  %t134 = load { i8**, i64 }*, { i8**, i64 }** %l4
  ret { i8**, i64 }* %t134
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
  %t72 = phi double [ %t4, %block.entry ], [ %t69, %loop.latch2 ]
  %t73 = phi double [ %t5, %block.entry ], [ %t70, %loop.latch2 ]
  %t74 = phi i8* [ %t3, %block.entry ], [ %t71, %loop.latch2 ]
  store double %t72, double* %l1
  store double %t73, double* %l2
  store i8* %t74, i8** %l0
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
  %t60 = add i64 0, 2
  %t61 = call i8* @malloc(i64 %t60)
  store i8 %t59, i8* %t61
  %t62 = getelementptr i8, i8* %t61, i64 1
  store i8 0, i8* %t62
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  %t63 = call i8* @sailfin_runtime_string_concat(i8* %t58, i8* %t61)
  store i8* %t63, i8** %l0
  %t64 = load i8*, i8** %l0
  br label %merge13
merge13:
  %t65 = phi i8* [ %t64, %then12 ], [ %t54, %merge9 ]
  store i8* %t65, i8** %l0
  %t66 = load double, double* %l2
  %t67 = sitofp i64 1 to double
  %t68 = fadd double %t66, %t67
  store double %t68, double* %l2
  br label %loop.latch2
loop.latch2:
  %t69 = load double, double* %l1
  %t70 = load double, double* %l2
  %t71 = load i8*, i8** %l0
  br label %loop.header0
afterloop3:
  %t75 = load double, double* %l1
  %t76 = load double, double* %l2
  %t77 = load i8*, i8** %l0
  %t78 = load i8*, i8** %l0
  %t79 = call i8* @trim_text__native_ir(i8* %t78)
  call void @sailfin_runtime_mark_persistent(i8* %t79)
  ret i8* %t79
}

define i8* @trim_text__native_ir(i8* %value) {
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
  %t27 = phi double [ %t3, %block.entry ], [ %t26, %loop.latch2 ]
  store double %t27, double* %l0
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
  %t16 = add i64 0, 2
  %t17 = call i8* @malloc(i64 %t16)
  store i8 %t15, i8* %t17
  %t18 = getelementptr i8, i8* %t17, i64 1
  store i8 0, i8* %t18
  call void @sailfin_runtime_mark_persistent(i8* %t17)
  %t19 = call i1 @is_trim_char__native_ir(i8* %t17)
  %t20 = load double, double* %l0
  %t21 = load double, double* %l1
  %t22 = load i8, i8* %l2
  br i1 %t19, label %then6, label %merge7
then6:
  %t23 = load double, double* %l0
  %t24 = sitofp i64 1 to double
  %t25 = fadd double %t23, %t24
  store double %t25, double* %l0
  br label %loop.latch2
merge7:
  br label %afterloop3
loop.latch2:
  %t26 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t28 = load double, double* %l0
  %t29 = load double, double* %l0
  %t30 = load double, double* %l1
  br label %loop.header8
loop.header8:
  %t55 = phi double [ %t30, %afterloop3 ], [ %t54, %loop.latch10 ]
  store double %t55, double* %l1
  br label %loop.body9
loop.body9:
  %t31 = load double, double* %l1
  %t32 = load double, double* %l0
  %t33 = fcmp ole double %t31, %t32
  %t34 = load double, double* %l0
  %t35 = load double, double* %l1
  br i1 %t33, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t36 = load double, double* %l1
  %t37 = sitofp i64 1 to double
  %t38 = fsub double %t36, %t37
  %t39 = call double @llvm.round.f64(double %t38)
  %t40 = fptosi double %t39 to i64
  %t41 = getelementptr i8, i8* %value, i64 %t40
  %t42 = load i8, i8* %t41
  store i8 %t42, i8* %l3
  %t43 = load i8, i8* %l3
  %t44 = add i64 0, 2
  %t45 = call i8* @malloc(i64 %t44)
  store i8 %t43, i8* %t45
  %t46 = getelementptr i8, i8* %t45, i64 1
  store i8 0, i8* %t46
  call void @sailfin_runtime_mark_persistent(i8* %t45)
  %t47 = call i1 @is_trim_char__native_ir(i8* %t45)
  %t48 = load double, double* %l0
  %t49 = load double, double* %l1
  %t50 = load i8, i8* %l3
  br i1 %t47, label %then14, label %merge15
then14:
  %t51 = load double, double* %l1
  %t52 = sitofp i64 1 to double
  %t53 = fsub double %t51, %t52
  store double %t53, double* %l1
  br label %loop.latch10
merge15:
  br label %afterloop11
loop.latch10:
  %t54 = load double, double* %l1
  br label %loop.header8
afterloop11:
  %t56 = load double, double* %l1
  %t58 = load double, double* %l0
  %t59 = sitofp i64 0 to double
  %t60 = fcmp oeq double %t58, %t59
  br label %logical_and_entry_57

logical_and_entry_57:
  br i1 %t60, label %logical_and_right_57, label %logical_and_merge_57

logical_and_right_57:
  %t61 = load double, double* %l1
  %t62 = call i64 @sailfin_runtime_string_length(i8* %value)
  %t63 = sitofp i64 %t62 to double
  %t64 = fcmp oeq double %t61, %t63
  br label %logical_and_right_end_57

logical_and_right_end_57:
  br label %logical_and_merge_57

logical_and_merge_57:
  %t65 = phi i1 [ false, %logical_and_entry_57 ], [ %t64, %logical_and_right_end_57 ]
  %t66 = load double, double* %l0
  %t67 = load double, double* %l1
  br i1 %t65, label %then16, label %merge17
then16:
  call void @sailfin_runtime_mark_persistent(i8* %value)
  ret i8* %value
merge17:
  %t68 = load double, double* %l0
  %t69 = load double, double* %l1
  %t70 = call double @llvm.round.f64(double %t68)
  %t71 = fptosi double %t70 to i64
  %t72 = call double @llvm.round.f64(double %t69)
  %t73 = fptosi double %t72 to i64
  %t74 = call i8* @sailfin_runtime_substring(i8* %value, i64 %t71, i64 %t73)
  call void @sailfin_runtime_mark_persistent(i8* %t74)
  ret i8* %t74
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
  %t714 = phi double [ %t42, %block.entry ], [ %t710, %loop.latch2 ]
  %t715 = phi { i8**, i64 }* [ %t39, %block.entry ], [ %t711, %loop.latch2 ]
  %t716 = phi { %NativeStruct*, i64 }* [ %t40, %block.entry ], [ %t712, %loop.latch2 ]
  %t717 = phi { %NativeEnum*, i64 }* [ %t41, %block.entry ], [ %t713, %loop.latch2 ]
  store double %t714, double* %l4
  store { i8**, i64 }* %t715, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t716, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t717, { %NativeEnum*, i64 }** %l3
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
  %t65 = call i8* @trim_text__native_ir(i8* %t64)
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
  %t80 = add i64 0, 2
  %t81 = call i8* @malloc(i64 %t80)
  store i8 59, i8* %t81
  %t82 = getelementptr i8, i8* %t81, i64 1
  store i8 0, i8* %t82
  call void @sailfin_runtime_mark_persistent(i8* %t81)
  %t83 = call i1 @starts_with(i8* %t79, i8* %t81)
  %t84 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t85 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t86 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t87 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t88 = load double, double* %l4
  %t89 = load i8*, i8** %l5
  %t90 = load i8*, i8** %l6
  br i1 %t83, label %then8, label %merge9
then8:
  %t91 = load double, double* %l4
  %t92 = sitofp i64 1 to double
  %t93 = fadd double %t91, %t92
  store double %t93, double* %l4
  br label %loop.latch2
merge9:
  %t94 = load i8*, i8** %l6
  %s95 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h1219235236, i32 0, i32 0
  %t96 = call i1 @starts_with(i8* %t94, i8* %s95)
  %t97 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t98 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t99 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t100 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t101 = load double, double* %l4
  %t102 = load i8*, i8** %l5
  %t103 = load i8*, i8** %l6
  br i1 %t96, label %then10, label %merge11
then10:
  %t104 = load double, double* %l4
  %t105 = sitofp i64 1 to double
  %t106 = fadd double %t104, %t105
  store double %t106, double* %l4
  br label %loop.latch2
merge11:
  %t107 = load i8*, i8** %l6
  %s108 = getelementptr inbounds [16 x i8], [16 x i8]* @.str.len15.h87749209, i32 0, i32 0
  %t109 = call i1 @starts_with(i8* %t107, i8* %s108)
  %t110 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t111 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t112 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t113 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t114 = load double, double* %l4
  %t115 = load i8*, i8** %l5
  %t116 = load i8*, i8** %l6
  br i1 %t109, label %then12, label %merge13
then12:
  %t117 = load i8*, i8** %l6
  %s118 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t119 = call i8* @strip_prefix(i8* %t117, i8* %s118)
  store i8* %t119, i8** %l7
  %t120 = load i8*, i8** %l7
  %s121 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t122 = call i8* @strip_prefix(i8* %t120, i8* %s121)
  store i8* %t122, i8** %l8
  %t123 = load i8*, i8** %l8
  %t124 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t123)
  store %StructLayoutHeaderParse %t124, %StructLayoutHeaderParse* %l9
  %t125 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t126 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t127 = extractvalue %StructLayoutHeaderParse %t126, 4
  %t128 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t125, { i8**, i64 }* %t127)
  store { i8**, i64 }* %t128, { i8**, i64 }** %l1
  %t129 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t130 = extractvalue %StructLayoutHeaderParse %t129, 0
  %t131 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t132 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t133 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t134 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t135 = load double, double* %l4
  %t136 = load i8*, i8** %l5
  %t137 = load i8*, i8** %l6
  %t138 = load i8*, i8** %l7
  %t139 = load i8*, i8** %l8
  %t140 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  br i1 %t130, label %then14, label %merge15
then14:
  %t141 = getelementptr [0 x %NativeStructLayoutField], [0 x %NativeStructLayoutField]* null, i32 1
  %t142 = ptrtoint [0 x %NativeStructLayoutField]* %t141 to i64
  %t143 = icmp eq i64 %t142, 0
  %t144 = select i1 %t143, i64 1, i64 %t142
  %t145 = call i8* @malloc(i64 %t144)
  %t146 = bitcast i8* %t145 to %NativeStructLayoutField*
  %t147 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* null, i32 1
  %t148 = ptrtoint { %NativeStructLayoutField*, i64 }* %t147 to i64
  %t149 = call i8* @malloc(i64 %t148)
  %t150 = bitcast i8* %t149 to { %NativeStructLayoutField*, i64 }*
  %t151 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t150, i32 0, i32 0
  store %NativeStructLayoutField* %t146, %NativeStructLayoutField** %t151
  %t152 = getelementptr { %NativeStructLayoutField*, i64 }, { %NativeStructLayoutField*, i64 }* %t150, i32 0, i32 1
  store i64 0, i64* %t152
  store { %NativeStructLayoutField*, i64 }* %t150, { %NativeStructLayoutField*, i64 }** %l10
  %t153 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t154 = extractvalue %StructLayoutHeaderParse %t153, 1
  store i8* %t154, i8** %l11
  %t155 = load double, double* %l4
  %t156 = sitofp i64 1 to double
  %t157 = fadd double %t155, %t156
  store double %t157, double* %l4
  %t158 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t159 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t160 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t161 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t162 = load double, double* %l4
  %t163 = load i8*, i8** %l5
  %t164 = load i8*, i8** %l6
  %t165 = load i8*, i8** %l7
  %t166 = load i8*, i8** %l8
  %t167 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t168 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t169 = load i8*, i8** %l11
  br label %loop.header16
loop.header16:
  %t276 = phi i8* [ %t165, %then14 ], [ %t272, %loop.latch18 ]
  %t277 = phi { i8**, i64 }* [ %t159, %then14 ], [ %t273, %loop.latch18 ]
  %t278 = phi { %NativeStructLayoutField*, i64 }* [ %t168, %then14 ], [ %t274, %loop.latch18 ]
  %t279 = phi double [ %t162, %then14 ], [ %t275, %loop.latch18 ]
  store i8* %t276, i8** %l7
  store { i8**, i64 }* %t277, { i8**, i64 }** %l1
  store { %NativeStructLayoutField*, i64 }* %t278, { %NativeStructLayoutField*, i64 }** %l10
  store double %t279, double* %l4
  br label %loop.body17
loop.body17:
  %t170 = load double, double* %l4
  %t171 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t172 = load { i8**, i64 }, { i8**, i64 }* %t171
  %t173 = extractvalue { i8**, i64 } %t172, 1
  %t174 = sitofp i64 %t173 to double
  %t175 = fcmp oge double %t170, %t174
  %t176 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t177 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t178 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t179 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t180 = load double, double* %l4
  %t181 = load i8*, i8** %l5
  %t182 = load i8*, i8** %l6
  %t183 = load i8*, i8** %l7
  %t184 = load i8*, i8** %l8
  %t185 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t186 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t187 = load i8*, i8** %l11
  br i1 %t175, label %then20, label %merge21
then20:
  br label %afterloop19
merge21:
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = load double, double* %l4
  %t190 = call double @llvm.round.f64(double %t189)
  %t191 = fptosi double %t190 to i64
  %t192 = load { i8**, i64 }, { i8**, i64 }* %t188
  %t193 = extractvalue { i8**, i64 } %t192, 0
  %t194 = extractvalue { i8**, i64 } %t192, 1
  %t195 = icmp uge i64 %t191, %t194
  ; bounds check: %t195 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t191, i64 %t194)
  %t196 = getelementptr i8*, i8** %t193, i64 %t191
  %t197 = load i8*, i8** %t196
  %t198 = call i8* @trim_text__native_ir(i8* %t197)
  store i8* %t198, i8** %l12
  %t199 = load i8*, i8** %l12
  %t200 = call i64 @sailfin_runtime_string_length(i8* %t199)
  %t201 = icmp eq i64 %t200, 0
  %t202 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t203 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t204 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t205 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t206 = load double, double* %l4
  %t207 = load i8*, i8** %l5
  %t208 = load i8*, i8** %l6
  %t209 = load i8*, i8** %l7
  %t210 = load i8*, i8** %l8
  %t211 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t212 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t213 = load i8*, i8** %l11
  %t214 = load i8*, i8** %l12
  br i1 %t201, label %then22, label %merge23
then22:
  br label %afterloop19
merge23:
  %t215 = load i8*, i8** %l12
  %s216 = getelementptr inbounds [15 x i8], [15 x i8]* @.str.len14.h1053492670, i32 0, i32 0
  %t217 = call i1 @starts_with(i8* %t215, i8* %s216)
  %t218 = xor i1 %t217, 1
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t221 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t222 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t223 = load double, double* %l4
  %t224 = load i8*, i8** %l5
  %t225 = load i8*, i8** %l6
  %t226 = load i8*, i8** %l7
  %t227 = load i8*, i8** %l8
  %t228 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t229 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t230 = load i8*, i8** %l11
  %t231 = load i8*, i8** %l12
  br i1 %t218, label %then24, label %merge25
then24:
  br label %afterloop19
merge25:
  %t232 = load i8*, i8** %l12
  %s233 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t234 = call i8* @strip_prefix(i8* %t232, i8* %s233)
  store i8* %t234, i8** %l13
  %t235 = load i8*, i8** %l7
  %s236 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t237 = call i8* @strip_prefix(i8* %t235, i8* %s236)
  store i8* %t237, i8** %l14
  %t238 = load i8*, i8** %l14
  %t239 = load i8*, i8** %l11
  %t240 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t238, i8* %t239)
  store %StructLayoutFieldParse %t240, %StructLayoutFieldParse* %l15
  %t241 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t242 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t243 = extractvalue %StructLayoutFieldParse %t242, 2
  %t244 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t241, { i8**, i64 }* %t243)
  store { i8**, i64 }* %t244, { i8**, i64 }** %l1
  %t245 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t246 = extractvalue %StructLayoutFieldParse %t245, 0
  %t247 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t249 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t250 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t251 = load double, double* %l4
  %t252 = load i8*, i8** %l5
  %t253 = load i8*, i8** %l6
  %t254 = load i8*, i8** %l7
  %t255 = load i8*, i8** %l8
  %t256 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t257 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t258 = load i8*, i8** %l11
  %t259 = load i8*, i8** %l12
  %t260 = load i8*, i8** %l13
  %t261 = load i8*, i8** %l14
  %t262 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  br i1 %t246, label %then26, label %merge27
then26:
  %t263 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t264 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l15
  %t265 = extractvalue %StructLayoutFieldParse %t264, 1
  %t266 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t263, %NativeStructLayoutField %t265)
  store { %NativeStructLayoutField*, i64 }* %t266, { %NativeStructLayoutField*, i64 }** %l10
  %t267 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  br label %merge27
merge27:
  %t268 = phi { %NativeStructLayoutField*, i64 }* [ %t267, %then26 ], [ %t257, %merge25 ]
  store { %NativeStructLayoutField*, i64 }* %t268, { %NativeStructLayoutField*, i64 }** %l10
  %t269 = load double, double* %l4
  %t270 = sitofp i64 1 to double
  %t271 = fadd double %t269, %t270
  store double %t271, double* %l4
  br label %loop.latch18
loop.latch18:
  %t272 = load i8*, i8** %l7
  %t273 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t274 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t275 = load double, double* %l4
  br label %loop.header16
afterloop19:
  %t280 = load i8*, i8** %l7
  %t281 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t282 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t283 = load double, double* %l4
  %t284 = load i8*, i8** %l11
  %t285 = insertvalue %NativeStruct undef, i8* %t284, 0
  %t286 = getelementptr [0 x %NativeStructField], [0 x %NativeStructField]* null, i32 1
  %t287 = ptrtoint [0 x %NativeStructField]* %t286 to i64
  %t288 = icmp eq i64 %t287, 0
  %t289 = select i1 %t288, i64 1, i64 %t287
  %t290 = call i8* @malloc(i64 %t289)
  %t291 = bitcast i8* %t290 to %NativeStructField*
  %t292 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* null, i32 1
  %t293 = ptrtoint { %NativeStructField*, i64 }* %t292 to i64
  %t294 = call i8* @malloc(i64 %t293)
  %t295 = bitcast i8* %t294 to { %NativeStructField*, i64 }*
  %t296 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t295, i32 0, i32 0
  store %NativeStructField* %t291, %NativeStructField** %t296
  %t297 = getelementptr { %NativeStructField*, i64 }, { %NativeStructField*, i64 }* %t295, i32 0, i32 1
  store i64 0, i64* %t297
  %t298 = insertvalue %NativeStruct %t285, { %NativeStructField*, i64 }* %t295, 1
  %t299 = getelementptr [0 x %NativeFunction], [0 x %NativeFunction]* null, i32 1
  %t300 = ptrtoint [0 x %NativeFunction]* %t299 to i64
  %t301 = icmp eq i64 %t300, 0
  %t302 = select i1 %t301, i64 1, i64 %t300
  %t303 = call i8* @malloc(i64 %t302)
  %t304 = bitcast i8* %t303 to %NativeFunction*
  %t305 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* null, i32 1
  %t306 = ptrtoint { %NativeFunction*, i64 }* %t305 to i64
  %t307 = call i8* @malloc(i64 %t306)
  %t308 = bitcast i8* %t307 to { %NativeFunction*, i64 }*
  %t309 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t308, i32 0, i32 0
  store %NativeFunction* %t304, %NativeFunction** %t309
  %t310 = getelementptr { %NativeFunction*, i64 }, { %NativeFunction*, i64 }* %t308, i32 0, i32 1
  store i64 0, i64* %t310
  %t311 = insertvalue %NativeStruct %t298, { %NativeFunction*, i64 }* %t308, 2
  %t312 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t313 = ptrtoint [0 x i8*]* %t312 to i64
  %t314 = icmp eq i64 %t313, 0
  %t315 = select i1 %t314, i64 1, i64 %t313
  %t316 = call i8* @malloc(i64 %t315)
  %t317 = bitcast i8* %t316 to i8**
  %t318 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t319 = ptrtoint { i8**, i64 }* %t318 to i64
  %t320 = call i8* @malloc(i64 %t319)
  %t321 = bitcast i8* %t320 to { i8**, i64 }*
  %t322 = getelementptr { i8**, i64 }, { i8**, i64 }* %t321, i32 0, i32 0
  store i8** %t317, i8*** %t322
  %t323 = getelementptr { i8**, i64 }, { i8**, i64 }* %t321, i32 0, i32 1
  store i64 0, i64* %t323
  %t324 = insertvalue %NativeStruct %t311, { i8**, i64 }* %t321, 3
  %t325 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t326 = extractvalue %StructLayoutHeaderParse %t325, 2
  %t327 = insertvalue %NativeStructLayout undef, double %t326, 0
  %t328 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l9
  %t329 = extractvalue %StructLayoutHeaderParse %t328, 3
  %t330 = insertvalue %NativeStructLayout %t327, double %t329, 1
  %t331 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l10
  %t332 = insertvalue %NativeStructLayout %t330, { %NativeStructLayoutField*, i64 }* %t331, 2
  %t333 = alloca %NativeStructLayout
  store %NativeStructLayout %t332, %NativeStructLayout* %t333
  %t334 = insertvalue %NativeStruct %t324, %NativeStructLayout* %t333, 4
  store %NativeStruct %t334, %NativeStruct* %l16
  %t335 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t336 = load %NativeStruct, %NativeStruct* %l16
  %t337 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t335, %NativeStruct %t336)
  store { %NativeStruct*, i64 }* %t337, { %NativeStruct*, i64 }** %l2
  %t338 = load double, double* %l4
  %t339 = load i8*, i8** %l7
  %t340 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t341 = load double, double* %l4
  %t342 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  br label %merge15
merge15:
  %t343 = phi double [ %t338, %afterloop19 ], [ %t135, %then12 ]
  %t344 = phi i8* [ %t339, %afterloop19 ], [ %t138, %then12 ]
  %t345 = phi { i8**, i64 }* [ %t340, %afterloop19 ], [ %t132, %then12 ]
  %t346 = phi double [ %t341, %afterloop19 ], [ %t135, %then12 ]
  %t347 = phi { %NativeStruct*, i64 }* [ %t342, %afterloop19 ], [ %t133, %then12 ]
  store double %t343, double* %l4
  store i8* %t344, i8** %l7
  store { i8**, i64 }* %t345, { i8**, i64 }** %l1
  store double %t346, double* %l4
  store { %NativeStruct*, i64 }* %t347, { %NativeStruct*, i64 }** %l2
  %t348 = load double, double* %l4
  %t349 = sitofp i64 1 to double
  %t350 = fadd double %t348, %t349
  store double %t350, double* %l4
  br label %loop.latch2
merge13:
  %t351 = load i8*, i8** %l6
  %s352 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h259593098, i32 0, i32 0
  %t353 = call i1 @starts_with(i8* %t351, i8* %s352)
  %t354 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t356 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t357 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t358 = load double, double* %l4
  %t359 = load i8*, i8** %l5
  %t360 = load i8*, i8** %l6
  br i1 %t353, label %then28, label %merge29
then28:
  %t361 = load i8*, i8** %l6
  %s362 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t363 = call i8* @strip_prefix(i8* %t361, i8* %s362)
  store i8* %t363, i8** %l17
  %t364 = load i8*, i8** %l17
  %s365 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t366 = call i8* @strip_prefix(i8* %t364, i8* %s365)
  store i8* %t366, i8** %l18
  %t367 = load i8*, i8** %l18
  %t368 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t367)
  store %EnumLayoutHeaderParse %t368, %EnumLayoutHeaderParse* %l19
  %t369 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t370 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t371 = extractvalue %EnumLayoutHeaderParse %t370, 7
  %t372 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t369, { i8**, i64 }* %t371)
  store { i8**, i64 }* %t372, { i8**, i64 }** %l1
  %t373 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t374 = extractvalue %EnumLayoutHeaderParse %t373, 0
  %t375 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t376 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t377 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t378 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t379 = load double, double* %l4
  %t380 = load i8*, i8** %l5
  %t381 = load i8*, i8** %l6
  %t382 = load i8*, i8** %l17
  %t383 = load i8*, i8** %l18
  %t384 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t374, label %then30, label %else31
then30:
  %t385 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t386 = ptrtoint [0 x %NativeEnumVariantLayout]* %t385 to i64
  %t387 = icmp eq i64 %t386, 0
  %t388 = select i1 %t387, i64 1, i64 %t386
  %t389 = call i8* @malloc(i64 %t388)
  %t390 = bitcast i8* %t389 to %NativeEnumVariantLayout*
  %t391 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t392 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t391 to i64
  %t393 = call i8* @malloc(i64 %t392)
  %t394 = bitcast i8* %t393 to { %NativeEnumVariantLayout*, i64 }*
  %t395 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t394, i32 0, i32 0
  store %NativeEnumVariantLayout* %t390, %NativeEnumVariantLayout** %t395
  %t396 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t394, i32 0, i32 1
  store i64 0, i64* %t396
  store { %NativeEnumVariantLayout*, i64 }* %t394, { %NativeEnumVariantLayout*, i64 }** %l20
  %t397 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t398 = extractvalue %EnumLayoutHeaderParse %t397, 1
  store i8* %t398, i8** %l21
  %t399 = load double, double* %l4
  %t400 = sitofp i64 1 to double
  %t401 = fadd double %t399, %t400
  store double %t401, double* %l4
  %t402 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t403 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t404 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t405 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t406 = load double, double* %l4
  %t407 = load i8*, i8** %l5
  %t408 = load i8*, i8** %l6
  %t409 = load i8*, i8** %l17
  %t410 = load i8*, i8** %l18
  %t411 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t412 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t413 = load i8*, i8** %l21
  br label %loop.header33
loop.header33:
  %t649 = phi double [ %t406, %then30 ], [ %t645, %loop.latch35 ]
  %t650 = phi i8* [ %t409, %then30 ], [ %t646, %loop.latch35 ]
  %t651 = phi { i8**, i64 }* [ %t403, %then30 ], [ %t647, %loop.latch35 ]
  %t652 = phi { %NativeEnumVariantLayout*, i64 }* [ %t412, %then30 ], [ %t648, %loop.latch35 ]
  store double %t649, double* %l4
  store i8* %t650, i8** %l17
  store { i8**, i64 }* %t651, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t652, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body34
loop.body34:
  %t414 = load double, double* %l4
  %t415 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t416 = load { i8**, i64 }, { i8**, i64 }* %t415
  %t417 = extractvalue { i8**, i64 } %t416, 1
  %t418 = sitofp i64 %t417 to double
  %t419 = fcmp oge double %t414, %t418
  %t420 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t421 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t422 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t423 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t424 = load double, double* %l4
  %t425 = load i8*, i8** %l5
  %t426 = load i8*, i8** %l6
  %t427 = load i8*, i8** %l17
  %t428 = load i8*, i8** %l18
  %t429 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t430 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t431 = load i8*, i8** %l21
  br i1 %t419, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t432 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t433 = load double, double* %l4
  %t434 = call double @llvm.round.f64(double %t433)
  %t435 = fptosi double %t434 to i64
  %t436 = load { i8**, i64 }, { i8**, i64 }* %t432
  %t437 = extractvalue { i8**, i64 } %t436, 0
  %t438 = extractvalue { i8**, i64 } %t436, 1
  %t439 = icmp uge i64 %t435, %t438
  ; bounds check: %t439 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t435, i64 %t438)
  %t440 = getelementptr i8*, i8** %t437, i64 %t435
  %t441 = load i8*, i8** %t440
  %t442 = call i8* @trim_text__native_ir(i8* %t441)
  store i8* %t442, i8** %l22
  %t443 = load i8*, i8** %l22
  %t444 = call i64 @sailfin_runtime_string_length(i8* %t443)
  %t445 = icmp eq i64 %t444, 0
  %t446 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t447 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t448 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t449 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t450 = load double, double* %l4
  %t451 = load i8*, i8** %l5
  %t452 = load i8*, i8** %l6
  %t453 = load i8*, i8** %l17
  %t454 = load i8*, i8** %l18
  %t455 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t456 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t457 = load i8*, i8** %l21
  %t458 = load i8*, i8** %l22
  br i1 %t445, label %then39, label %merge40
then39:
  %t459 = load double, double* %l4
  %t460 = sitofp i64 1 to double
  %t461 = fadd double %t459, %t460
  store double %t461, double* %l4
  br label %afterloop36
merge40:
  %t463 = load i8*, i8** %l22
  %s464 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t465 = call i1 @starts_with(i8* %t463, i8* %s464)
  br label %logical_and_entry_462

logical_and_entry_462:
  br i1 %t465, label %logical_and_right_462, label %logical_and_merge_462

logical_and_right_462:
  %t466 = load i8*, i8** %l22
  %s467 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t468 = call i1 @starts_with(i8* %t466, i8* %s467)
  %t469 = xor i1 %t468, 1
  br label %logical_and_right_end_462

logical_and_right_end_462:
  br label %logical_and_merge_462

logical_and_merge_462:
  %t470 = phi i1 [ false, %logical_and_entry_462 ], [ %t469, %logical_and_right_end_462 ]
  %t471 = xor i1 %t470, 1
  %t472 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t473 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t474 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t475 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t476 = load double, double* %l4
  %t477 = load i8*, i8** %l5
  %t478 = load i8*, i8** %l6
  %t479 = load i8*, i8** %l17
  %t480 = load i8*, i8** %l18
  %t481 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t482 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t483 = load i8*, i8** %l21
  %t484 = load i8*, i8** %l22
  br i1 %t471, label %then41, label %merge42
then41:
  br label %afterloop36
merge42:
  %t485 = load i8*, i8** %l22
  %s486 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t487 = call i1 @starts_with(i8* %t485, i8* %s486)
  %t488 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t489 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t490 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t491 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t492 = load double, double* %l4
  %t493 = load i8*, i8** %l5
  %t494 = load i8*, i8** %l6
  %t495 = load i8*, i8** %l17
  %t496 = load i8*, i8** %l18
  %t497 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t498 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t499 = load i8*, i8** %l21
  %t500 = load i8*, i8** %l22
  br i1 %t487, label %then43, label %else44
then43:
  %t501 = load i8*, i8** %l22
  %s502 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t503 = call i8* @strip_prefix(i8* %t501, i8* %s502)
  store i8* %t503, i8** %l23
  %t504 = load i8*, i8** %l17
  %s505 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t506 = call i8* @strip_prefix(i8* %t504, i8* %s505)
  store i8* %t506, i8** %l24
  %t507 = load i8*, i8** %l24
  %t508 = load i8*, i8** %l21
  %t509 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t507, i8* %t508)
  store %EnumLayoutVariantParse %t509, %EnumLayoutVariantParse* %l25
  %t510 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t511 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t512 = extractvalue %EnumLayoutVariantParse %t511, 2
  %t513 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t510, { i8**, i64 }* %t512)
  store { i8**, i64 }* %t513, { i8**, i64 }** %l1
  %t514 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t515 = extractvalue %EnumLayoutVariantParse %t514, 0
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t517 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t518 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t519 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t520 = load double, double* %l4
  %t521 = load i8*, i8** %l5
  %t522 = load i8*, i8** %l6
  %t523 = load i8*, i8** %l17
  %t524 = load i8*, i8** %l18
  %t525 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t526 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t527 = load i8*, i8** %l21
  %t528 = load i8*, i8** %l22
  %t529 = load i8*, i8** %l23
  %t530 = load i8*, i8** %l24
  %t531 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t515, label %then46, label %merge47
then46:
  %t532 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t533 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t534 = extractvalue %EnumLayoutVariantParse %t533, 1
  %t535 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout__native_ir({ %NativeEnumVariantLayout*, i64 }* %t532, %NativeEnumVariantLayout %t534)
  store { %NativeEnumVariantLayout*, i64 }* %t535, { %NativeEnumVariantLayout*, i64 }** %l20
  %t536 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge47
merge47:
  %t537 = phi { %NativeEnumVariantLayout*, i64 }* [ %t536, %then46 ], [ %t526, %then43 ]
  store { %NativeEnumVariantLayout*, i64 }* %t537, { %NativeEnumVariantLayout*, i64 }** %l20
  %t538 = load i8*, i8** %l17
  %t539 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t540 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge45
else44:
  %t541 = load i8*, i8** %l22
  %s542 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t543 = call i1 @starts_with(i8* %t541, i8* %s542)
  %t544 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t545 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t546 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t547 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t548 = load double, double* %l4
  %t549 = load i8*, i8** %l5
  %t550 = load i8*, i8** %l6
  %t551 = load i8*, i8** %l17
  %t552 = load i8*, i8** %l18
  %t553 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t554 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t555 = load i8*, i8** %l21
  %t556 = load i8*, i8** %l22
  br i1 %t543, label %then48, label %merge49
then48:
  %t557 = load i8*, i8** %l22
  %s558 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t559 = call i8* @strip_prefix(i8* %t557, i8* %s558)
  store i8* %t559, i8** %l26
  %t560 = load i8*, i8** %l17
  %s561 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t562 = call i8* @strip_prefix(i8* %t560, i8* %s561)
  store i8* %t562, i8** %l27
  %t563 = load i8*, i8** %l27
  %t564 = load i8*, i8** %l21
  %t565 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t563, i8* %t564)
  store %EnumLayoutPayloadParse %t565, %EnumLayoutPayloadParse* %l28
  %t566 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t567 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t568 = extractvalue %EnumLayoutPayloadParse %t567, 3
  %t569 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t566, { i8**, i64 }* %t568)
  store { i8**, i64 }* %t569, { i8**, i64 }** %l1
  %t571 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t572 = extractvalue %EnumLayoutPayloadParse %t571, 0
  br label %logical_and_entry_570

logical_and_entry_570:
  br i1 %t572, label %logical_and_right_570, label %logical_and_merge_570

logical_and_right_570:
  %t573 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t574 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t573
  %t575 = extractvalue { %NativeEnumVariantLayout*, i64 } %t574, 1
  %t576 = icmp sgt i64 %t575, 0
  br label %logical_and_right_end_570

logical_and_right_end_570:
  br label %logical_and_merge_570

logical_and_merge_570:
  %t577 = phi i1 [ false, %logical_and_entry_570 ], [ %t576, %logical_and_right_end_570 ]
  %t578 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t579 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t580 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t581 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t582 = load double, double* %l4
  %t583 = load i8*, i8** %l5
  %t584 = load i8*, i8** %l6
  %t585 = load i8*, i8** %l17
  %t586 = load i8*, i8** %l18
  %t587 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t588 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t589 = load i8*, i8** %l21
  %t590 = load i8*, i8** %l22
  %t591 = load i8*, i8** %l26
  %t592 = load i8*, i8** %l27
  %t593 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t577, label %then50, label %merge51
then50:
  %t594 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t595 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t594
  %t596 = extractvalue { %NativeEnumVariantLayout*, i64 } %t595, 1
  %t597 = sub i64 %t596, 1
  store i64 %t597, i64* %l29
  %t598 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t599 = load i64, i64* %l29
  %t600 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t598
  %t601 = extractvalue { %NativeEnumVariantLayout*, i64 } %t600, 0
  %t602 = extractvalue { %NativeEnumVariantLayout*, i64 } %t600, 1
  %t603 = icmp uge i64 %t599, %t602
  ; bounds check: %t603 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t599, i64 %t602)
  %t604 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t601, i64 %t599
  %t605 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t604
  store %NativeEnumVariantLayout %t605, %NativeEnumVariantLayout* %l30
  %t606 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t607 = extractvalue %NativeEnumVariantLayout %t606, 5
  %t608 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t609 = extractvalue %EnumLayoutPayloadParse %t608, 2
  %t610 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t607, %NativeStructLayoutField %t609)
  store { %NativeStructLayoutField*, i64 }* %t610, { %NativeStructLayoutField*, i64 }** %l31
  %t611 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t612 = extractvalue %NativeEnumVariantLayout %t611, 0
  %t613 = insertvalue %NativeEnumVariantLayout undef, i8* %t612, 0
  %t614 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t615 = extractvalue %NativeEnumVariantLayout %t614, 1
  %t616 = insertvalue %NativeEnumVariantLayout %t613, double %t615, 1
  %t617 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t618 = extractvalue %NativeEnumVariantLayout %t617, 2
  %t619 = insertvalue %NativeEnumVariantLayout %t616, double %t618, 2
  %t620 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t621 = extractvalue %NativeEnumVariantLayout %t620, 3
  %t622 = insertvalue %NativeEnumVariantLayout %t619, double %t621, 3
  %t623 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t624 = extractvalue %NativeEnumVariantLayout %t623, 4
  %t625 = insertvalue %NativeEnumVariantLayout %t622, double %t624, 4
  %t626 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l31
  %t627 = insertvalue %NativeEnumVariantLayout %t625, { %NativeStructLayoutField*, i64 }* %t626, 5
  %t628 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t629 = load i64, i64* %l29
  %t630 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t628, i32 0, i32 0
  %t632 = load %NativeEnumVariantLayout*, %NativeEnumVariantLayout** %t630
  %t631 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t632, i64 %t629
  store %NativeEnumVariantLayout %t627, %NativeEnumVariantLayout* %t631
  br label %merge51
merge51:
  %t633 = load i8*, i8** %l17
  %t634 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge49
merge49:
  %t635 = phi i8* [ %t633, %merge51 ], [ %t551, %else44 ]
  %t636 = phi { i8**, i64 }* [ %t634, %merge51 ], [ %t545, %else44 ]
  store i8* %t635, i8** %l17
  store { i8**, i64 }* %t636, { i8**, i64 }** %l1
  %t637 = load i8*, i8** %l17
  %t638 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t639 = phi i8* [ %t538, %merge47 ], [ %t637, %merge49 ]
  %t640 = phi { i8**, i64 }* [ %t539, %merge47 ], [ %t638, %merge49 ]
  %t641 = phi { %NativeEnumVariantLayout*, i64 }* [ %t540, %merge47 ], [ %t498, %merge49 ]
  store i8* %t639, i8** %l17
  store { i8**, i64 }* %t640, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t641, { %NativeEnumVariantLayout*, i64 }** %l20
  %t642 = load double, double* %l4
  %t643 = sitofp i64 1 to double
  %t644 = fadd double %t642, %t643
  store double %t644, double* %l4
  br label %loop.latch35
loop.latch35:
  %t645 = load double, double* %l4
  %t646 = load i8*, i8** %l17
  %t647 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t648 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header33
afterloop36:
  %t653 = load double, double* %l4
  %t654 = load i8*, i8** %l17
  %t655 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t656 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t657 = load i8*, i8** %l21
  %t658 = insertvalue %NativeEnum undef, i8* %t657, 0
  %t659 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* null, i32 1
  %t660 = ptrtoint [0 x %NativeEnumVariant]* %t659 to i64
  %t661 = icmp eq i64 %t660, 0
  %t662 = select i1 %t661, i64 1, i64 %t660
  %t663 = call i8* @malloc(i64 %t662)
  %t664 = bitcast i8* %t663 to %NativeEnumVariant*
  %t665 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* null, i32 1
  %t666 = ptrtoint { %NativeEnumVariant*, i64 }* %t665 to i64
  %t667 = call i8* @malloc(i64 %t666)
  %t668 = bitcast i8* %t667 to { %NativeEnumVariant*, i64 }*
  %t669 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t668, i32 0, i32 0
  store %NativeEnumVariant* %t664, %NativeEnumVariant** %t669
  %t670 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t668, i32 0, i32 1
  store i64 0, i64* %t670
  %t671 = insertvalue %NativeEnum %t658, { %NativeEnumVariant*, i64 }* %t668, 1
  %t672 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t673 = extractvalue %EnumLayoutHeaderParse %t672, 2
  %t674 = insertvalue %NativeEnumLayout undef, double %t673, 0
  %t675 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t676 = extractvalue %EnumLayoutHeaderParse %t675, 3
  %t677 = insertvalue %NativeEnumLayout %t674, double %t676, 1
  %t678 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t679 = extractvalue %EnumLayoutHeaderParse %t678, 4
  %t680 = insertvalue %NativeEnumLayout %t677, i8* %t679, 2
  %t681 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t682 = extractvalue %EnumLayoutHeaderParse %t681, 5
  %t683 = insertvalue %NativeEnumLayout %t680, double %t682, 3
  %t684 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t685 = extractvalue %EnumLayoutHeaderParse %t684, 6
  %t686 = insertvalue %NativeEnumLayout %t683, double %t685, 4
  %t687 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t688 = insertvalue %NativeEnumLayout %t686, { %NativeEnumVariantLayout*, i64 }* %t687, 5
  %t689 = alloca %NativeEnumLayout
  store %NativeEnumLayout %t688, %NativeEnumLayout* %t689
  %t690 = insertvalue %NativeEnum %t671, %NativeEnumLayout* %t689, 2
  store %NativeEnum %t690, %NativeEnum* %l32
  %t691 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t692 = load %NativeEnum, %NativeEnum* %l32
  %t693 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t691, %NativeEnum %t692)
  store { %NativeEnum*, i64 }* %t693, { %NativeEnum*, i64 }** %l3
  %t694 = load double, double* %l4
  %t695 = load double, double* %l4
  %t696 = load i8*, i8** %l17
  %t697 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t698 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %merge32
else31:
  %t699 = load double, double* %l4
  %t700 = sitofp i64 1 to double
  %t701 = fadd double %t699, %t700
  store double %t701, double* %l4
  %t702 = load double, double* %l4
  br label %merge32
merge32:
  %t703 = phi double [ %t694, %afterloop36 ], [ %t702, %else31 ]
  %t704 = phi i8* [ %t696, %afterloop36 ], [ %t382, %else31 ]
  %t705 = phi { i8**, i64 }* [ %t697, %afterloop36 ], [ %t376, %else31 ]
  %t706 = phi { %NativeEnum*, i64 }* [ %t698, %afterloop36 ], [ %t378, %else31 ]
  store double %t703, double* %l4
  store i8* %t704, i8** %l17
  store { i8**, i64 }* %t705, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t706, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge29:
  %t707 = load double, double* %l4
  %t708 = sitofp i64 1 to double
  %t709 = fadd double %t707, %t708
  store double %t709, double* %l4
  br label %loop.latch2
loop.latch2:
  %t710 = load double, double* %l4
  %t711 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t712 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t713 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t718 = load double, double* %l4
  %t719 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t720 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t721 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t722 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t723 = insertvalue %LayoutManifest undef, { %NativeStruct*, i64 }* %t722, 0
  %t724 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t725 = insertvalue %LayoutManifest %t723, { %NativeEnum*, i64 }* %t724, 1
  %t726 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t727 = insertvalue %LayoutManifest %t725, { i8**, i64 }* %t726, 2
  ret %LayoutManifest %t727
}

define i1 @is_trim_char__native_ir(i8* %ch) {
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

define { i8**, i64 }* @append_string__native_ir({ i8**, i64 }* %values, i8* %value) {
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
  %t0 = getelementptr [1 x %NativeParameter], [1 x %NativeParameter]* null, i32 1
  %t1 = ptrtoint [1 x %NativeParameter]* %t0 to i64
  %t2 = icmp eq i64 %t1, 0
  %t3 = select i1 %t2, i64 1, i64 %t1
  %t4 = call i8* @malloc(i64 %t3)
  %t5 = bitcast i8* %t4 to %NativeParameter*
  %t6 = getelementptr %NativeParameter, %NativeParameter* %t5, i64 0
  store %NativeParameter %parameter, %NativeParameter* %t6
  %t7 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t8 = ptrtoint { %NativeParameter*, i64 }* %t7 to i64
  %t9 = call i8* @malloc(i64 %t8)
  %t10 = bitcast i8* %t9 to { %NativeParameter*, i64 }*
  %t11 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t10, i32 0, i32 0
  store %NativeParameter* %t5, %NativeParameter** %t11
  %t12 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t10, i32 0, i32 1
  store i64 1, i64* %t12
  %t13 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %values, i32 0, i32 0
  %t14 = load %NativeParameter*, %NativeParameter** %t13
  %t15 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %values, i32 0, i32 1
  %t16 = load i64, i64* %t15
  %t17 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t10, i32 0, i32 0
  %t18 = load %NativeParameter*, %NativeParameter** %t17
  %t19 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t10, i32 0, i32 1
  %t20 = load i64, i64* %t19
  %t21 = getelementptr [1 x %NativeParameter], [1 x %NativeParameter]* null, i32 0, i32 1
  %t22 = ptrtoint %NativeParameter* %t21 to i64
  %t23 = add i64 %t16, %t20
  %t24 = mul i64 %t22, %t23
  %t25 = call noalias i8* @malloc(i64 %t24)
  %t26 = bitcast i8* %t25 to %NativeParameter*
  %t27 = bitcast %NativeParameter* %t26 to i8*
  %t28 = mul i64 %t22, %t16
  %t29 = bitcast %NativeParameter* %t14 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t27, i8* %t29, i64 %t28)
  %t30 = mul i64 %t22, %t20
  %t31 = bitcast %NativeParameter* %t18 to i8*
  %t32 = getelementptr %NativeParameter, %NativeParameter* %t26, i64 %t16
  %t33 = bitcast %NativeParameter* %t32 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t33, i8* %t31, i64 %t30)
  %t34 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t35 = ptrtoint { %NativeParameter*, i64 }* %t34 to i64
  %t36 = call i8* @malloc(i64 %t35)
  %t37 = bitcast i8* %t36 to { %NativeParameter*, i64 }*
  %t38 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t37, i32 0, i32 0
  store %NativeParameter* %t26, %NativeParameter** %t38
  %t39 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t37, i32 0, i32 1
  store i64 %t23, i64* %t39
  ret { %NativeParameter*, i64 }* %t37
}

define double @add__native_ir(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len4.h273104342 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.len8.h1926252274 = private unnamed_addr constant [9 x i8] c"variant \00"
@.str.len3.h2090684245 = private unnamed_addr constant [4 x i8] c"ret\00"
@.str.len34.h1377481172 = private unnamed_addr constant [35 x i8] c"` has invalid effects annotation `\00"
@.str.len31.h329133056 = private unnamed_addr constant [32 x i8] c" layout payload missing content\00"
@.str.len26.h130324785 = private unnamed_addr constant [27 x i8] c" layout field missing name\00"
@.str.len8.h787332764 = private unnamed_addr constant [9 x i8] c"effects \00"
@.str.len34.h805939531 = private unnamed_addr constant [35 x i8] c"unable to parse interface header: \00"
@.str.len44.h1623843 = private unnamed_addr constant [45 x i8] c" layout payload references unknown variant `\00"
@.str.len30.h211710404 = private unnamed_addr constant [31 x i8] c"unsupported struct directive: \00"
@.str.len31.h755263238 = private unnamed_addr constant [32 x i8] c" layout payload missing entries\00"
@.str.len8.h1370870284 = private unnamed_addr constant [9 x i8] c".module \00"
@.str.len10.h2070880298 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.str.len32.h1767333123 = private unnamed_addr constant [33 x i8] c"metadata outside function body: \00"
@.str.len42.h1518215675 = private unnamed_addr constant [43 x i8] c"encountered .endfn without active function\00"
@.str.len31.h238974215 = private unnamed_addr constant [32 x i8] c" layout variant missing entries\00"
@.str.len16.h1290415774 = private unnamed_addr constant [17 x i8] c".layout payload \00"
@.str.len19.h1697653870 = private unnamed_addr constant [20 x i8] c"` missing tag entry\00"
@.str.len23.h1564009733 = private unnamed_addr constant [24 x i8] c"unterminated interface \00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len34.h183092327 = private unnamed_addr constant [35 x i8] c"enum layout header missing entries\00"
@.str.len27.h237652301 = private unnamed_addr constant [28 x i8] c"` has unsupported segment `\00"
@.str.len21.h1187531435 = private unnamed_addr constant [22 x i8] c"` missing closing `>`\00"
@.str.len8.h1074277327 = private unnamed_addr constant [9 x i8] c".export \00"
@.str.len20.h608364678 = private unnamed_addr constant [21 x i8] c"` missing size entry\00"
@.str.len10.h469410318 = private unnamed_addr constant [11 x i8] c"tag_align=\00"
@.str.len22.h625556084 = private unnamed_addr constant [23 x i8] c"` missing offset entry\00"
@.str.len42.h930606274 = private unnamed_addr constant [43 x i8] c"enum layout header missing tag_align entry\00"
@.str.len31.h1478667446 = private unnamed_addr constant [32 x i8] c"unable to parse struct header: \00"
@.str.len15.h87749209 = private unnamed_addr constant [16 x i8] c".layout struct \00"
@.str.len7.h1448749422 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.str.len20.h1568429285 = private unnamed_addr constant [21 x i8] c"` missing type entry\00"
@.str.len31.h1868156648 = private unnamed_addr constant [32 x i8] c" header missing implements list\00"
@.str.len7.h130169768 = private unnamed_addr constant [8 x i8] c".param \00"
@.str.len39.h943297157 = private unnamed_addr constant [40 x i8] c"struct layout header has invalid size `\00"
@.str.len28.h1605654048 = private unnamed_addr constant [29 x i8] c" layout variant missing name\00"
@.str.len30.h208276320 = private unnamed_addr constant [31 x i8] c"unterminated method in struct \00"
@.str.len5.h261048910 = private unnamed_addr constant [6 x i8] c"name=\00"
@.str.len26.h1834305347 = private unnamed_addr constant [27 x i8] c" signature missing content\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len9.h1311191977 = private unnamed_addr constant [10 x i8] c".variant \00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len18.h1997941781 = private unnamed_addr constant [19 x i8] c"unterminated enum \00"
@.str.len5.h466680424 = private unnamed_addr constant [6 x i8] c"size=\00"
@.str.len37.h1581468287 = private unnamed_addr constant [38 x i8] c"enum layout header has invalid size `\00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len9.h1171237782 = private unnamed_addr constant [10 x i8] c"tag_size=\00"
@.str.len40.h1512965366 = private unnamed_addr constant [41 x i8] c"unterminated function at end of artifact\00"
@.str.len13.h1382830532 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.len24.h1881287894 = private unnamed_addr constant [25 x i8] c"unable to parse export: \00"
@.str.len19.h879467198 = private unnamed_addr constant [20 x i8] c"` has invalid tag `\00"
@.str.len4.h192590216 = private unnamed_addr constant [5 x i8] c".if \00"
@.str.len9.h1228988541 = private unnamed_addr constant [10 x i8] c"tag_type=\00"
@.str.len10.h1219235236 = private unnamed_addr constant [11 x i8] c".manifest \00"
@.str.len6.h1280331335 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.len5.h2072026244 = private unnamed_addr constant [6 x i8] c"enum \00"
@.str.len30.h829706524 = private unnamed_addr constant [31 x i8] c"unable to parse enum variant: \00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len4.h192491117 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.len48.h807033739 = private unnamed_addr constant [49 x i8] c" layout payload encountered before layout header\00"
@.str.len30.h702899578 = private unnamed_addr constant [31 x i8] c"unable to parse struct field: \00"
@.str.len11.h908744813 = private unnamed_addr constant [12 x i8] c"implements \00"
@.str.len8.h1616485352 = private unnamed_addr constant [9 x i8] c".layout \00"
@.str.len32.h1822658020 = private unnamed_addr constant [33 x i8] c"duplicate enum layout header in \00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len4.h275319236 = private unnamed_addr constant [5 x i8] c"tag=\00"
@.str.len9.h1692644020 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.len26.h1606904140 = private unnamed_addr constant [27 x i8] c"` has unsupported suffix `\00"
@.str.len6.h1830497006 = private unnamed_addr constant [7 x i8] c".span \00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len6.h1583308163 = private unnamed_addr constant [7 x i8] c".meta \00"
@.str.len36.h414094739 = private unnamed_addr constant [37 x i8] c"struct layout header missing entries\00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.len21.h1297227834 = private unnamed_addr constant [22 x i8] c"` has invalid align `\00"
@.str.len29.h128952257 = private unnamed_addr constant [30 x i8] c" layout field missing content\00"
@.str.len2.h193415939 = private unnamed_addr constant [3 x i8] c"![\00"
@.str.len8.h1521657554 = private unnamed_addr constant [9 x i8] c"payload \00"
@.str.len41.h2069276858 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_size entry\00"
@.str.len11.h1513373193 = private unnamed_addr constant [12 x i8] c".init-span \00"
@.str.len39.h1399971520 = private unnamed_addr constant [40 x i8] c"struct layout header missing size entry\00"
@.str.len4.h267749729 = private unnamed_addr constant [5 x i8] c"mut \00"
@.str.len44.h1730891783 = private unnamed_addr constant [45 x i8] c" signature has unterminated parameter list: \00"
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len40.h318366654 = private unnamed_addr constant [41 x i8] c"struct layout header missing align entry\00"
@.str.len17.h1973869273 = private unnamed_addr constant [18 x i8] c" layout payload `\00"
@.str.len7.h553171426 = private unnamed_addr constant [8 x i8] c".match \00"
@.str.len16.h1695010494 = private unnamed_addr constant [17 x i8] c".layout variant \00"
@.str.len41.h35508704 = private unnamed_addr constant [42 x i8] c"unused initializer span metadata before: \00"
@.str.len10.h179409731 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.len29.h1601547567 = private unnamed_addr constant [30 x i8] c"unused span metadata before: \00"
@.str.len34.h1211676914 = private unnamed_addr constant [35 x i8] c"unable to parse method parameter: \00"
@.str.len29.h555082439 = private unnamed_addr constant [30 x i8] c" layout field missing entries\00"
@.str.len7.h242296049 = private unnamed_addr constant [8 x i8] c"offset=\00"
@.str.len20.h1216366549 = private unnamed_addr constant [21 x i8] c"unterminated struct \00"
@.str.len31.h1924917952 = private unnamed_addr constant [32 x i8] c"duplicate enum layout variant `\00"
@.str.len5.h2056075365 = private unnamed_addr constant [6 x i8] c".else\00"
@.str.len10.h385719500 = private unnamed_addr constant [11 x i8] c"interface \00"
@.str.len48.h235936117 = private unnamed_addr constant [49 x i8] c" layout variant encountered before layout header\00"
@.str.len32.h1189086491 = private unnamed_addr constant [33 x i8] c"unable to parse parameter line: \00"
@.str.len38.h1235260132 = private unnamed_addr constant [39 x i8] c"enum layout header has invalid align `\00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len41.h1384306956 = private unnamed_addr constant [42 x i8] c"enum layout header has invalid tag_size `\00"
@.str.len5.h2080793783 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.len43.h1714227133 = private unnamed_addr constant [44 x i8] c"unable to parse initializer span metadata: \00"
@.str.len41.h1415177535 = private unnamed_addr constant [42 x i8] c"struct layout header unrecognized token `\00"
@.str.len8.h571206424 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.len46.h1830585629 = private unnamed_addr constant [47 x i8] c" layout field encountered before layout header\00"
@.str.len39.h598838653 = private unnamed_addr constant [40 x i8] c"enum layout header unrecognized token `\00"
@.str.len41.h881857818 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_type entry\00"
@.str.len29.h668562564 = private unnamed_addr constant [30 x i8] c"unable to parse enum header: \00"
@.str.len17.h293109504 = private unnamed_addr constant [18 x i8] c" layout variant `\00"
@.str.len5.h2072555103 = private unnamed_addr constant [6 x i8] c".sig \00"
@.str.len20.h151690315 = private unnamed_addr constant [21 x i8] c"` has invalid size `\00"
@.str.len6.h734244628 = private unnamed_addr constant [7 x i8] c"field \00"
@.str.len5.h2057365731 = private unnamed_addr constant [6 x i8] c".for \00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len33.h1023685264 = private unnamed_addr constant [34 x i8] c"unable to parse parameter entry: \00"
@.str.len7.h725262232 = private unnamed_addr constant [8 x i8] c".return\00"
@.str.len42.h1171387022 = private unnamed_addr constant [43 x i8] c"enum layout header has invalid tag_align `\00"
@.str.len5.h524431183 = private unnamed_addr constant [6 x i8] c"type=\00"
@.str.len28.h1471254674 = private unnamed_addr constant [29 x i8] c"unsupported enum directive: \00"
@.str.len9.h1123073249 = private unnamed_addr constant [10 x i8] c"` invalid\00"
@.str.len22.h496289716 = private unnamed_addr constant [23 x i8] c"` unrecognized token `\00"
@.str.len28.h497146076 = private unnamed_addr constant [29 x i8] c" layout payload identifier `\00"
@.str.len34.h654371835 = private unnamed_addr constant [35 x i8] c"duplicate struct layout header in \00"
@.str.len6.h1280334338 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.len5.h2064480630 = private unnamed_addr constant [6 x i8] c".loop\00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.str.len37.h1152036459 = private unnamed_addr constant [38 x i8] c"unsupported struct layout directive: \00"
@.str.len57.h1118233133 = private unnamed_addr constant [58 x i8] c"encountered nested .fn while previous function still open\00"
@.str.len33.h1134984829 = private unnamed_addr constant [34 x i8] c"unsupported interface directive: \00"
@.str.len6.h841337749 = private unnamed_addr constant [7 x i8] c"align=\00"
@.str.len40.h1650449248 = private unnamed_addr constant [41 x i8] c"struct layout header has invalid align `\00"
@.str.len13.h259593098 = private unnamed_addr constant [14 x i8] c".layout enum \00"
@.str.len36.h736848621 = private unnamed_addr constant [37 x i8] c"nested method declaration in struct \00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.str.len7.h398443637 = private unnamed_addr constant [8 x i8] c".field \00"
@.str.len8.h562875475 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.len15.h506269955 = private unnamed_addr constant [16 x i8] c" layout field `\00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len7.h289982314 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.len21.h2112628887 = private unnamed_addr constant [22 x i8] c"` missing align entry\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len25.h378946335 = private unnamed_addr constant [26 x i8] c"` has invalid parameter `\00"
@.str.len6.h1134498859 = private unnamed_addr constant [7 x i8] c"async \00"
@.str.len4.h268717223 = private unnamed_addr constant [5 x i8] c"noop\00"
@.str.len5.h1783417286 = private unnamed_addr constant [6 x i8] c"` in \00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len8.h1951948513 = private unnamed_addr constant [9 x i8] c".method \00"
@.str.len31.h1960327680 = private unnamed_addr constant [32 x i8] c" layout variant missing content\00"
@.str.len33.h1132321576 = private unnamed_addr constant [34 x i8] c" header has unsupported segment `\00"
@.str.len37.h2038142650 = private unnamed_addr constant [38 x i8] c"enum layout header missing size entry\00"
@.str.len14.h1219450488 = private unnamed_addr constant [15 x i8] c"` missing name\00"
@.str.len19.h1782433603 = private unnamed_addr constant [20 x i8] c"sailfin-native-text\00"
@.str.len12.h841153022 = private unnamed_addr constant [13 x i8] c" signature `\00"
@.str.len9.h890937508 = private unnamed_addr constant [10 x i8] c"eval let \00"
@.str.len14.h1053492670 = private unnamed_addr constant [15 x i8] c".layout field \00"
@.str.len8.h575595345 = private unnamed_addr constant [9 x i8] c".import \00"
@.str.len8.h487238491 = private unnamed_addr constant [9 x i8] c"header `\00"
@.str.len23.h668778749 = private unnamed_addr constant [24 x i8] c"sailfin-layout-manifest\00"
@.str.len6.h483393773 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.len31.h762677253 = private unnamed_addr constant [32 x i8] c"unable to parse span metadata: \00"
@.str.len33.h712498791 = private unnamed_addr constant [34 x i8] c"parameter outside function body: \00"
@.str.len47.h1886628617 = private unnamed_addr constant [48 x i8] c"top-level directive not supported in lowering: \00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len38.h2050661185 = private unnamed_addr constant [39 x i8] c"enum layout header missing align entry\00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len24.h457168017 = private unnamed_addr constant [25 x i8] c"unable to parse import: \00"
@.str.len35.h2058816325 = private unnamed_addr constant [36 x i8] c"unsupported enum layout directive: \00"
@.str.len22.h24304067 = private unnamed_addr constant [23 x i8] c"` has invalid offset `\00"
@.str.len4.h268715771 = private unnamed_addr constant [5 x i8] c"none\00"
@.str.len35.h546841458 = private unnamed_addr constant [36 x i8] c" signature missing parameter list: \00"