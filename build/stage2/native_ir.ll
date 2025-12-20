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
  %t32 = phi double [ %t1, %block.entry ], [ %t31, %loop.latch2 ]
  store double %t32, double* %l0
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
  %t24 = getelementptr %NativeArtifact, %NativeArtifact* null, i32 1
  %t25 = ptrtoint %NativeArtifact* %t24 to i64
  %t26 = call noalias i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to %NativeArtifact*
  store %NativeArtifact %t23, %NativeArtifact* %t27
  call void @sailfin_runtime_mark_persistent(i8* %t26)
  ret %NativeArtifact* %t27
merge7:
  %t28 = load double, double* %l0
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l0
  br label %loop.latch2
loop.latch2:
  %t31 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t33 = load double, double* %l0
  %t34 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t34
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
  %t32 = phi double [ %t1, %block.entry ], [ %t31, %loop.latch2 ]
  store double %t32, double* %l0
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
  %t24 = getelementptr %NativeArtifact, %NativeArtifact* null, i32 1
  %t25 = ptrtoint %NativeArtifact* %t24 to i64
  %t26 = call noalias i8* @malloc(i64 %t25)
  %t27 = bitcast i8* %t26 to %NativeArtifact*
  store %NativeArtifact %t23, %NativeArtifact* %t27
  call void @sailfin_runtime_mark_persistent(i8* %t26)
  ret %NativeArtifact* %t27
merge7:
  %t28 = load double, double* %l0
  %t29 = sitofp i64 1 to double
  %t30 = fadd double %t28, %t29
  store double %t30, double* %l0
  br label %loop.latch2
loop.latch2:
  %t31 = load double, double* %l0
  br label %loop.header0
afterloop3:
  %t33 = load double, double* %l0
  %t34 = bitcast i8* null to %NativeArtifact*
  ret %NativeArtifact* %t34
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
  %t1487 = phi double [ %t100, %block.entry ], [ %t1476, %loop.latch2 ]
  %t1488 = phi { i8**, i64 }* [ %t90, %block.entry ], [ %t1477, %loop.latch2 ]
  %t1489 = phi { %NativeImport*, i64 }* [ %t92, %block.entry ], [ %t1478, %loop.latch2 ]
  %t1490 = phi %NativeSourceSpan* [ %t98, %block.entry ], [ %t1479, %loop.latch2 ]
  %t1491 = phi %NativeSourceSpan* [ %t99, %block.entry ], [ %t1480, %loop.latch2 ]
  %t1492 = phi { %NativeStruct*, i64 }* [ %t93, %block.entry ], [ %t1481, %loop.latch2 ]
  %t1493 = phi { %NativeInterface*, i64 }* [ %t94, %block.entry ], [ %t1482, %loop.latch2 ]
  %t1494 = phi { %NativeEnum*, i64 }* [ %t95, %block.entry ], [ %t1483, %loop.latch2 ]
  %t1495 = phi %NativeFunction* [ %t97, %block.entry ], [ %t1484, %loop.latch2 ]
  %t1496 = phi { %NativeFunction*, i64 }* [ %t91, %block.entry ], [ %t1485, %loop.latch2 ]
  %t1497 = phi { %NativeBinding*, i64 }* [ %t96, %block.entry ], [ %t1486, %loop.latch2 ]
  store double %t1487, double* %l11
  store { i8**, i64 }* %t1488, { i8**, i64 }** %l1
  store { %NativeImport*, i64 }* %t1489, { %NativeImport*, i64 }** %l3
  store %NativeSourceSpan* %t1490, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1491, %NativeSourceSpan** %l10
  store { %NativeStruct*, i64 }* %t1492, { %NativeStruct*, i64 }** %l4
  store { %NativeInterface*, i64 }* %t1493, { %NativeInterface*, i64 }** %l5
  store { %NativeEnum*, i64 }* %t1494, { %NativeEnum*, i64 }** %l6
  store %NativeFunction* %t1495, %NativeFunction** %l8
  store { %NativeFunction*, i64 }* %t1496, { %NativeFunction*, i64 }** %l2
  store { %NativeBinding*, i64 }* %t1497, { %NativeBinding*, i64 }** %l7
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
  %t642 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t643 = ptrtoint %NativeFunction* %t642 to i64
  %t644 = call noalias i8* @malloc(i64 %t643)
  %t645 = bitcast i8* %t644 to %NativeFunction*
  store %NativeFunction %t641, %NativeFunction* %t645
  call void @sailfin_runtime_mark_persistent(i8* %t644)
  store %NativeFunction* %t645, %NativeFunction** %l8
  %t646 = load double, double* %l11
  %t647 = sitofp i64 1 to double
  %t648 = fadd double %t646, %t647
  store double %t648, double* %l11
  br label %loop.latch2
merge45:
  %t649 = load i8*, i8** %l13
  %s650 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1280331335, i32 0, i32 0
  %t651 = call i1 @starts_with(i8* %t649, i8* %s650)
  %t652 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t653 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t654 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t655 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t656 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t657 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t658 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t659 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t660 = load %NativeFunction*, %NativeFunction** %l8
  %t661 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t662 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t663 = load double, double* %l11
  %t664 = load i8*, i8** %l12
  %t665 = load i8*, i8** %l13
  br i1 %t651, label %then48, label %merge49
then48:
  %t666 = load %NativeFunction*, %NativeFunction** %l8
  %t667 = icmp eq %NativeFunction* %t666, null
  %t668 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t669 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t670 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t671 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t672 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t673 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t674 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t675 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t676 = load %NativeFunction*, %NativeFunction** %l8
  %t677 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t678 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t679 = load double, double* %l11
  %t680 = load i8*, i8** %l12
  %t681 = load i8*, i8** %l13
  br i1 %t667, label %then50, label %else51
then50:
  %t682 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s683 = getelementptr inbounds [43 x i8], [43 x i8]* @.str.len42.h1518215675, i32 0, i32 0
  %t684 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t682, i8* %s683)
  store { i8**, i64 }* %t684, { i8**, i64 }** %l1
  %t685 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge52
else51:
  %t686 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t687 = load %NativeFunction*, %NativeFunction** %l8
  %t688 = load %NativeFunction, %NativeFunction* %t687
  %t689 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t686, %NativeFunction %t688)
  store { %NativeFunction*, i64 }* %t689, { %NativeFunction*, i64 }** %l2
  %t690 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t690, %NativeFunction** %l8
  %t691 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t692 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge52
merge52:
  %t693 = phi { i8**, i64 }* [ %t685, %then50 ], [ %t669, %else51 ]
  %t694 = phi { %NativeFunction*, i64 }* [ %t670, %then50 ], [ %t691, %else51 ]
  %t695 = phi %NativeFunction* [ %t676, %then50 ], [ %t692, %else51 ]
  store { i8**, i64 }* %t693, { i8**, i64 }** %l1
  store { %NativeFunction*, i64 }* %t694, { %NativeFunction*, i64 }** %l2
  store %NativeFunction* %t695, %NativeFunction** %l8
  %t696 = load double, double* %l11
  %t697 = sitofp i64 1 to double
  %t698 = fadd double %t696, %t697
  store double %t698, double* %l11
  br label %loop.latch2
merge49:
  %t699 = load i8*, i8** %l13
  %s700 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t701 = call i1 @starts_with(i8* %t699, i8* %s700)
  %t702 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t703 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t704 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t705 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t706 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t707 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t708 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t709 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t710 = load %NativeFunction*, %NativeFunction** %l8
  %t711 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t712 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t713 = load double, double* %l11
  %t714 = load i8*, i8** %l12
  %t715 = load i8*, i8** %l13
  br i1 %t701, label %then53, label %merge54
then53:
  %t716 = load %NativeFunction*, %NativeFunction** %l8
  %t717 = icmp ne %NativeFunction* %t716, null
  %t718 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t719 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t720 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t721 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t722 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t723 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t724 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t725 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t726 = load %NativeFunction*, %NativeFunction** %l8
  %t727 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t728 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t729 = load double, double* %l11
  %t730 = load i8*, i8** %l12
  %t731 = load i8*, i8** %l13
  br i1 %t717, label %then55, label %else56
then55:
  %t732 = load %NativeFunction*, %NativeFunction** %l8
  %t733 = load i8*, i8** %l13
  %s734 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t735 = call i8* @strip_prefix(i8* %t733, i8* %s734)
  %t736 = load %NativeFunction, %NativeFunction* %t732
  %t737 = call %NativeFunction @apply_meta(%NativeFunction %t736, i8* %t735)
  %t738 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t739 = ptrtoint %NativeFunction* %t738 to i64
  %t740 = call noalias i8* @malloc(i64 %t739)
  %t741 = bitcast i8* %t740 to %NativeFunction*
  store %NativeFunction %t737, %NativeFunction* %t741
  call void @sailfin_runtime_mark_persistent(i8* %t740)
  store %NativeFunction* %t741, %NativeFunction** %l8
  %t742 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge57
else56:
  %t743 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s744 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1767333123, i32 0, i32 0
  %t745 = load i8*, i8** %l13
  %t746 = call i8* @sailfin_runtime_string_concat(i8* %s744, i8* %t745)
  %t747 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t743, i8* %t746)
  store { i8**, i64 }* %t747, { i8**, i64 }** %l1
  %t748 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge57
merge57:
  %t749 = phi %NativeFunction* [ %t742, %then55 ], [ %t726, %else56 ]
  %t750 = phi { i8**, i64 }* [ %t719, %then55 ], [ %t748, %else56 ]
  store %NativeFunction* %t749, %NativeFunction** %l8
  store { i8**, i64 }* %t750, { i8**, i64 }** %l1
  %t751 = load double, double* %l11
  %t752 = sitofp i64 1 to double
  %t753 = fadd double %t751, %t752
  store double %t753, double* %l11
  br label %loop.latch2
merge54:
  %t754 = load i8*, i8** %l13
  %s755 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t756 = call i1 @starts_with(i8* %t754, i8* %s755)
  %t757 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t758 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t759 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t760 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t761 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t762 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t763 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t764 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t765 = load %NativeFunction*, %NativeFunction** %l8
  %t766 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t767 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t768 = load double, double* %l11
  %t769 = load i8*, i8** %l12
  %t770 = load i8*, i8** %l13
  br i1 %t756, label %then58, label %merge59
then58:
  %t771 = load %NativeFunction*, %NativeFunction** %l8
  %t772 = icmp ne %NativeFunction* %t771, null
  %t773 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t774 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t775 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t776 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t777 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t778 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t779 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t780 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t781 = load %NativeFunction*, %NativeFunction** %l8
  %t782 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t783 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t784 = load double, double* %l11
  %t785 = load i8*, i8** %l12
  %t786 = load i8*, i8** %l13
  br i1 %t772, label %then60, label %else61
then60:
  %t787 = load i8*, i8** %l13
  %s788 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t789 = call i8* @strip_prefix(i8* %t787, i8* %s788)
  store i8* %t789, i8** %l21
  %t790 = load double, double* %l11
  %t791 = sitofp i64 1 to double
  %t792 = fadd double %t790, %t791
  store double %t792, double* %l22
  %t793 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t794 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t795 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t796 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t797 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t798 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t799 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t800 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t801 = load %NativeFunction*, %NativeFunction** %l8
  %t802 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t803 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t804 = load double, double* %l11
  %t805 = load i8*, i8** %l12
  %t806 = load i8*, i8** %l13
  %t807 = load i8*, i8** %l21
  %t808 = load double, double* %l22
  br label %loop.header63
loop.header63:
  %t920 = phi double [ %t808, %then60 ], [ %t918, %loop.latch65 ]
  %t921 = phi i8* [ %t807, %then60 ], [ %t919, %loop.latch65 ]
  store double %t920, double* %l22
  store i8* %t921, i8** %l21
  br label %loop.body64
loop.body64:
  %t809 = load double, double* %l22
  %t810 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t811 = load { i8**, i64 }, { i8**, i64 }* %t810
  %t812 = extractvalue { i8**, i64 } %t811, 1
  %t813 = sitofp i64 %t812 to double
  %t814 = fcmp oge double %t809, %t813
  %t815 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t816 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t817 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t818 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t819 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t820 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t821 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t822 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t823 = load %NativeFunction*, %NativeFunction** %l8
  %t824 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t825 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t826 = load double, double* %l11
  %t827 = load i8*, i8** %l12
  %t828 = load i8*, i8** %l13
  %t829 = load i8*, i8** %l21
  %t830 = load double, double* %l22
  br i1 %t814, label %then67, label %merge68
then67:
  br label %afterloop66
merge68:
  %t831 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t832 = load double, double* %l22
  %t833 = call double @llvm.round.f64(double %t832)
  %t834 = fptosi double %t833 to i64
  %t835 = load { i8**, i64 }, { i8**, i64 }* %t831
  %t836 = extractvalue { i8**, i64 } %t835, 0
  %t837 = extractvalue { i8**, i64 } %t835, 1
  %t838 = icmp uge i64 %t834, %t837
  ; bounds check: %t838 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t834, i64 %t837)
  %t839 = getelementptr i8*, i8** %t836, i64 %t834
  %t840 = load i8*, i8** %t839
  store i8* %t840, i8** %l23
  %t841 = load i8*, i8** %l23
  %t842 = call i64 @sailfin_runtime_string_length(i8* %t841)
  %t843 = icmp eq i64 %t842, 0
  %t844 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t845 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t846 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t847 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t848 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t849 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t850 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t851 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t852 = load %NativeFunction*, %NativeFunction** %l8
  %t853 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t854 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t855 = load double, double* %l11
  %t856 = load i8*, i8** %l12
  %t857 = load i8*, i8** %l13
  %t858 = load i8*, i8** %l21
  %t859 = load double, double* %l22
  %t860 = load i8*, i8** %l23
  br i1 %t843, label %then69, label %merge70
then69:
  br label %afterloop66
merge70:
  %t861 = load i8*, i8** %l23
  %t862 = call i8* @trim_text(i8* %t861)
  store i8* %t862, i8** %l24
  %t863 = load i8*, i8** %l24
  %t864 = call i64 @sailfin_runtime_string_length(i8* %t863)
  %t865 = icmp eq i64 %t864, 0
  %t866 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t867 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t868 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t869 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t870 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t871 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t872 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t873 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t874 = load %NativeFunction*, %NativeFunction** %l8
  %t875 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t876 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t877 = load double, double* %l11
  %t878 = load i8*, i8** %l12
  %t879 = load i8*, i8** %l13
  %t880 = load i8*, i8** %l21
  %t881 = load double, double* %l22
  %t882 = load i8*, i8** %l23
  %t883 = load i8*, i8** %l24
  br i1 %t865, label %then71, label %merge72
then71:
  %t884 = load double, double* %l22
  %t885 = sitofp i64 1 to double
  %t886 = fadd double %t884, %t885
  store double %t886, double* %l22
  br label %loop.latch65
merge72:
  %t887 = load i8*, i8** %l24
  %t888 = call i1 @line_looks_like_parameter_entry(i8* %t887)
  %t889 = xor i1 %t888, 1
  %t890 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t891 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t892 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t893 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t894 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t895 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t896 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t897 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t898 = load %NativeFunction*, %NativeFunction** %l8
  %t899 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t900 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t901 = load double, double* %l11
  %t902 = load i8*, i8** %l12
  %t903 = load i8*, i8** %l13
  %t904 = load i8*, i8** %l21
  %t905 = load double, double* %l22
  %t906 = load i8*, i8** %l23
  %t907 = load i8*, i8** %l24
  br i1 %t889, label %then73, label %merge74
then73:
  br label %afterloop66
merge74:
  %t908 = load i8*, i8** %l21
  %t909 = add i64 0, 2
  %t910 = call i8* @malloc(i64 %t909)
  store i8 32, i8* %t910
  %t911 = getelementptr i8, i8* %t910, i64 1
  store i8 0, i8* %t911
  call void @sailfin_runtime_mark_persistent(i8* %t910)
  %t912 = call i8* @sailfin_runtime_string_concat(i8* %t908, i8* %t910)
  %t913 = load i8*, i8** %l24
  %t914 = call i8* @sailfin_runtime_string_concat(i8* %t912, i8* %t913)
  store i8* %t914, i8** %l21
  %t915 = load double, double* %l22
  %t916 = sitofp i64 1 to double
  %t917 = fadd double %t915, %t916
  store double %t917, double* %l22
  br label %loop.latch65
loop.latch65:
  %t918 = load double, double* %l22
  %t919 = load i8*, i8** %l21
  br label %loop.header63
afterloop66:
  %t922 = load double, double* %l22
  %t923 = load i8*, i8** %l21
  %t924 = load i8*, i8** %l21
  %t925 = call { i8**, i64 }* @split_parameter_entries(i8* %t924)
  store { i8**, i64 }* %t925, { i8**, i64 }** %l25
  %t926 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t927 = load { i8**, i64 }, { i8**, i64 }* %t926
  %t928 = extractvalue { i8**, i64 } %t927, 1
  %t929 = icmp eq i64 %t928, 0
  %t930 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t931 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t932 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t933 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t934 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t935 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t936 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t937 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t938 = load %NativeFunction*, %NativeFunction** %l8
  %t939 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t940 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t941 = load double, double* %l11
  %t942 = load i8*, i8** %l12
  %t943 = load i8*, i8** %l13
  %t944 = load i8*, i8** %l21
  %t945 = load double, double* %l22
  %t946 = load { i8**, i64 }*, { i8**, i64 }** %l25
  br i1 %t929, label %then75, label %else76
then75:
  %t947 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s948 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1189086491, i32 0, i32 0
  %t949 = load i8*, i8** %l13
  %t950 = call i8* @sailfin_runtime_string_concat(i8* %s948, i8* %t949)
  %t951 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t947, i8* %t950)
  store { i8**, i64 }* %t951, { i8**, i64 }** %l1
  %t952 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t952, %NativeSourceSpan** %l9
  %t953 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t954 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
else76:
  %t955 = sitofp i64 0 to double
  store double %t955, double* %l26
  store i1 0, i1* %l27
  %t956 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t957 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t958 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t959 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t960 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t961 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t962 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t963 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t964 = load %NativeFunction*, %NativeFunction** %l8
  %t965 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t966 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t967 = load double, double* %l11
  %t968 = load i8*, i8** %l12
  %t969 = load i8*, i8** %l13
  %t970 = load i8*, i8** %l21
  %t971 = load double, double* %l22
  %t972 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t973 = load double, double* %l26
  %t974 = load i1, i1* %l27
  br label %loop.header78
loop.header78:
  %t1118 = phi { i8**, i64 }* [ %t957, %else76 ], [ %t1114, %loop.latch80 ]
  %t1119 = phi %NativeFunction* [ %t964, %else76 ], [ %t1115, %loop.latch80 ]
  %t1120 = phi i1 [ %t974, %else76 ], [ %t1116, %loop.latch80 ]
  %t1121 = phi double [ %t973, %else76 ], [ %t1117, %loop.latch80 ]
  store { i8**, i64 }* %t1118, { i8**, i64 }** %l1
  store %NativeFunction* %t1119, %NativeFunction** %l8
  store i1 %t1120, i1* %l27
  store double %t1121, double* %l26
  br label %loop.body79
loop.body79:
  %t975 = load double, double* %l26
  %t976 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t977 = load { i8**, i64 }, { i8**, i64 }* %t976
  %t978 = extractvalue { i8**, i64 } %t977, 1
  %t979 = sitofp i64 %t978 to double
  %t980 = fcmp oge double %t975, %t979
  %t981 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t982 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t983 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t984 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t985 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t986 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t987 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t988 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t989 = load %NativeFunction*, %NativeFunction** %l8
  %t990 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t991 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t992 = load double, double* %l11
  %t993 = load i8*, i8** %l12
  %t994 = load i8*, i8** %l13
  %t995 = load i8*, i8** %l21
  %t996 = load double, double* %l22
  %t997 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t998 = load double, double* %l26
  %t999 = load i1, i1* %l27
  br i1 %t980, label %then82, label %merge83
then82:
  br label %afterloop81
merge83:
  %t1000 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1001 = load double, double* %l26
  %t1002 = call double @llvm.round.f64(double %t1001)
  %t1003 = fptosi double %t1002 to i64
  %t1004 = load { i8**, i64 }, { i8**, i64 }* %t1000
  %t1005 = extractvalue { i8**, i64 } %t1004, 0
  %t1006 = extractvalue { i8**, i64 } %t1004, 1
  %t1007 = icmp uge i64 %t1003, %t1006
  ; bounds check: %t1007 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1003, i64 %t1006)
  %t1008 = getelementptr i8*, i8** %t1005, i64 %t1003
  %t1009 = load i8*, i8** %t1008
  store i8* %t1009, i8** %l28
  %t1010 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1010, %NativeSourceSpan** %l29
  %t1011 = load i1, i1* %l27
  %t1012 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1013 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1014 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1015 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1016 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1017 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1018 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1019 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1020 = load %NativeFunction*, %NativeFunction** %l8
  %t1021 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1022 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1023 = load double, double* %l11
  %t1024 = load i8*, i8** %l12
  %t1025 = load i8*, i8** %l13
  %t1026 = load i8*, i8** %l21
  %t1027 = load double, double* %l22
  %t1028 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1029 = load double, double* %l26
  %t1030 = load i1, i1* %l27
  %t1031 = load i8*, i8** %l28
  %t1032 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br i1 %t1011, label %then84, label %merge85
then84:
  %t1033 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1033, %NativeSourceSpan** %l29
  %t1034 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  br label %merge85
merge85:
  %t1035 = phi %NativeSourceSpan* [ %t1034, %then84 ], [ %t1032, %merge83 ]
  store %NativeSourceSpan* %t1035, %NativeSourceSpan** %l29
  %t1036 = load i8*, i8** %l28
  %t1037 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1038 = call %NativeParameter* @parse_parameter_entry(i8* %t1036, %NativeSourceSpan* %t1037)
  store %NativeParameter* %t1038, %NativeParameter** %l30
  %t1039 = load %NativeParameter*, %NativeParameter** %l30
  %t1040 = icmp eq %NativeParameter* %t1039, null
  %t1041 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1042 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1043 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1044 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1045 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1046 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1047 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1048 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1049 = load %NativeFunction*, %NativeFunction** %l8
  %t1050 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1051 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1052 = load double, double* %l11
  %t1053 = load i8*, i8** %l12
  %t1054 = load i8*, i8** %l13
  %t1055 = load i8*, i8** %l21
  %t1056 = load double, double* %l22
  %t1057 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1058 = load double, double* %l26
  %t1059 = load i1, i1* %l27
  %t1060 = load i8*, i8** %l28
  %t1061 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1062 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1040, label %then86, label %else87
then86:
  %t1063 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1064 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1023685264, i32 0, i32 0
  %t1065 = load i8*, i8** %l28
  %t1066 = call i8* @sailfin_runtime_string_concat(i8* %s1064, i8* %t1065)
  %t1067 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1063, i8* %t1066)
  store { i8**, i64 }* %t1067, { i8**, i64 }** %l1
  %t1068 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge88
else87:
  %t1069 = load %NativeFunction*, %NativeFunction** %l8
  %t1070 = load %NativeParameter*, %NativeParameter** %l30
  %t1071 = load %NativeFunction, %NativeFunction* %t1069
  %t1072 = load %NativeParameter, %NativeParameter* %t1070
  %t1073 = call %NativeFunction @append_parameter(%NativeFunction %t1071, %NativeParameter %t1072)
  %t1074 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t1075 = ptrtoint %NativeFunction* %t1074 to i64
  %t1076 = call noalias i8* @malloc(i64 %t1075)
  %t1077 = bitcast i8* %t1076 to %NativeFunction*
  store %NativeFunction %t1073, %NativeFunction* %t1077
  call void @sailfin_runtime_mark_persistent(i8* %t1076)
  store %NativeFunction* %t1077, %NativeFunction** %l8
  %t1078 = load %NativeParameter*, %NativeParameter** %l30
  %t1079 = getelementptr %NativeParameter, %NativeParameter* %t1078, i32 0, i32 4
  %t1080 = load %NativeSourceSpan*, %NativeSourceSpan** %t1079
  %t1081 = icmp ne %NativeSourceSpan* %t1080, null
  %t1082 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1083 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1084 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1085 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1086 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1087 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1088 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1089 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1090 = load %NativeFunction*, %NativeFunction** %l8
  %t1091 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1092 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1093 = load double, double* %l11
  %t1094 = load i8*, i8** %l12
  %t1095 = load i8*, i8** %l13
  %t1096 = load i8*, i8** %l21
  %t1097 = load double, double* %l22
  %t1098 = load { i8**, i64 }*, { i8**, i64 }** %l25
  %t1099 = load double, double* %l26
  %t1100 = load i1, i1* %l27
  %t1101 = load i8*, i8** %l28
  %t1102 = load %NativeSourceSpan*, %NativeSourceSpan** %l29
  %t1103 = load %NativeParameter*, %NativeParameter** %l30
  br i1 %t1081, label %then89, label %merge90
then89:
  store i1 1, i1* %l27
  %t1104 = load i1, i1* %l27
  br label %merge90
merge90:
  %t1105 = phi i1 [ %t1104, %then89 ], [ %t1100, %else87 ]
  store i1 %t1105, i1* %l27
  %t1106 = load %NativeFunction*, %NativeFunction** %l8
  %t1107 = load i1, i1* %l27
  br label %merge88
merge88:
  %t1108 = phi { i8**, i64 }* [ %t1068, %then86 ], [ %t1042, %merge90 ]
  %t1109 = phi %NativeFunction* [ %t1049, %then86 ], [ %t1106, %merge90 ]
  %t1110 = phi i1 [ %t1059, %then86 ], [ %t1107, %merge90 ]
  store { i8**, i64 }* %t1108, { i8**, i64 }** %l1
  store %NativeFunction* %t1109, %NativeFunction** %l8
  store i1 %t1110, i1* %l27
  %t1111 = load double, double* %l26
  %t1112 = sitofp i64 1 to double
  %t1113 = fadd double %t1111, %t1112
  store double %t1113, double* %l26
  br label %loop.latch80
loop.latch80:
  %t1114 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1115 = load %NativeFunction*, %NativeFunction** %l8
  %t1116 = load i1, i1* %l27
  %t1117 = load double, double* %l26
  br label %loop.header78
afterloop81:
  %t1122 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1123 = load %NativeFunction*, %NativeFunction** %l8
  %t1124 = load i1, i1* %l27
  %t1125 = load double, double* %l26
  %t1126 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1126, %NativeSourceSpan** %l9
  %t1127 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1128 = load %NativeFunction*, %NativeFunction** %l8
  %t1129 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge77
merge77:
  %t1130 = phi { i8**, i64 }* [ %t953, %then75 ], [ %t1127, %afterloop81 ]
  %t1131 = phi %NativeSourceSpan* [ %t954, %then75 ], [ %t1129, %afterloop81 ]
  %t1132 = phi %NativeFunction* [ %t938, %then75 ], [ %t1128, %afterloop81 ]
  store { i8**, i64 }* %t1130, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1131, %NativeSourceSpan** %l9
  store %NativeFunction* %t1132, %NativeFunction** %l8
  %t1133 = load double, double* %l22
  %t1134 = sitofp i64 1 to double
  %t1135 = fsub double %t1133, %t1134
  store double %t1135, double* %l11
  %t1136 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1137 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1138 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1139 = load %NativeFunction*, %NativeFunction** %l8
  %t1140 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1141 = load double, double* %l11
  br label %merge62
else61:
  %t1142 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1143 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h712498791, i32 0, i32 0
  %t1144 = load i8*, i8** %l13
  %t1145 = call i8* @sailfin_runtime_string_concat(i8* %s1143, i8* %t1144)
  %t1146 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1142, i8* %t1145)
  store { i8**, i64 }* %t1146, { i8**, i64 }** %l1
  %t1147 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge62
merge62:
  %t1148 = phi { i8**, i64 }* [ %t1136, %merge77 ], [ %t1147, %else61 ]
  %t1149 = phi %NativeSourceSpan* [ %t1137, %merge77 ], [ %t782, %else61 ]
  %t1150 = phi %NativeFunction* [ %t1139, %merge77 ], [ %t781, %else61 ]
  %t1151 = phi double [ %t1141, %merge77 ], [ %t784, %else61 ]
  store { i8**, i64 }* %t1148, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1149, %NativeSourceSpan** %l9
  store %NativeFunction* %t1150, %NativeFunction** %l8
  store double %t1151, double* %l11
  %t1152 = load double, double* %l11
  %t1153 = sitofp i64 1 to double
  %t1154 = fadd double %t1152, %t1153
  store double %t1154, double* %l11
  br label %loop.latch2
merge59:
  %t1155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1156 = load double, double* %l11
  %t1157 = call %InstructionGatherResult @gather_instruction({ i8**, i64 }* %t1155, double %t1156)
  store %InstructionGatherResult %t1157, %InstructionGatherResult* %l31
  %t1158 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1159 = extractvalue %InstructionGatherResult %t1158, 0
  store i8* %t1159, i8** %l13
  %t1160 = load double, double* %l11
  %t1161 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1162 = extractvalue %InstructionGatherResult %t1161, 1
  %t1163 = fadd double %t1160, %t1162
  store double %t1163, double* %l11
  %t1164 = load i8*, i8** %l13
  %t1165 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1166 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1167 = call %InstructionParseResult @parse_instruction(i8* %t1164, %NativeSourceSpan* %t1165, %NativeSourceSpan* %t1166)
  store %InstructionParseResult %t1167, %InstructionParseResult* %l32
  %t1168 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1169 = extractvalue %InstructionParseResult %t1168, 0
  store { %NativeInstruction*, i64 }* %t1169, { %NativeInstruction*, i64 }** %l33
  %t1170 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1171 = extractvalue %InstructionParseResult %t1170, 1
  %t1172 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1173 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1174 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1175 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1176 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1177 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1178 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1179 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1180 = load %NativeFunction*, %NativeFunction** %l8
  %t1181 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1182 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1183 = load double, double* %l11
  %t1184 = load i8*, i8** %l12
  %t1185 = load i8*, i8** %l13
  %t1186 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1187 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1188 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1171, label %then91, label %else92
then91:
  %t1189 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1189, %NativeSourceSpan** %l9
  %t1190 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
else92:
  %t1191 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1192 = icmp ne %NativeSourceSpan* %t1191, null
  %t1193 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1194 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1195 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1196 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1197 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1198 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1199 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1200 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1201 = load %NativeFunction*, %NativeFunction** %l8
  %t1202 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1203 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1204 = load double, double* %l11
  %t1205 = load i8*, i8** %l12
  %t1206 = load i8*, i8** %l13
  %t1207 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1208 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1209 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1192, label %then94, label %merge95
then94:
  %t1210 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1211 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t1212 = load i8*, i8** %l13
  %t1213 = call i8* @sailfin_runtime_string_concat(i8* %s1211, i8* %t1212)
  %t1214 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1210, i8* %t1213)
  store { i8**, i64 }* %t1214, { i8**, i64 }** %l1
  %t1215 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1215, %NativeSourceSpan** %l9
  %t1216 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1217 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge95
merge95:
  %t1218 = phi { i8**, i64 }* [ %t1216, %then94 ], [ %t1194, %else92 ]
  %t1219 = phi %NativeSourceSpan* [ %t1217, %then94 ], [ %t1202, %else92 ]
  store { i8**, i64 }* %t1218, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1219, %NativeSourceSpan** %l9
  %t1220 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1221 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge93
merge93:
  %t1222 = phi %NativeSourceSpan* [ %t1190, %then91 ], [ %t1221, %merge95 ]
  %t1223 = phi { i8**, i64 }* [ %t1173, %then91 ], [ %t1220, %merge95 ]
  store %NativeSourceSpan* %t1222, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t1223, { i8**, i64 }** %l1
  %t1224 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1225 = extractvalue %InstructionParseResult %t1224, 2
  %t1226 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1227 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1228 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1229 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1230 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1231 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1232 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1233 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1234 = load %NativeFunction*, %NativeFunction** %l8
  %t1235 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1236 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1237 = load double, double* %l11
  %t1238 = load i8*, i8** %l12
  %t1239 = load i8*, i8** %l13
  %t1240 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1241 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1242 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1225, label %then96, label %else97
then96:
  %t1243 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1243, %NativeSourceSpan** %l10
  %t1244 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
else97:
  %t1245 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1246 = icmp ne %NativeSourceSpan* %t1245, null
  %t1247 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1248 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1249 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1250 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1251 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1252 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1253 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1254 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1255 = load %NativeFunction*, %NativeFunction** %l8
  %t1256 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1257 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1258 = load double, double* %l11
  %t1259 = load i8*, i8** %l12
  %t1260 = load i8*, i8** %l13
  %t1261 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1262 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1263 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1246, label %then99, label %merge100
then99:
  %t1264 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1265 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t1266 = load i8*, i8** %l13
  %t1267 = call i8* @sailfin_runtime_string_concat(i8* %s1265, i8* %t1266)
  %t1268 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1264, i8* %t1267)
  store { i8**, i64 }* %t1268, { i8**, i64 }** %l1
  %t1269 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1269, %NativeSourceSpan** %l10
  %t1270 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1271 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge100
merge100:
  %t1272 = phi { i8**, i64 }* [ %t1270, %then99 ], [ %t1248, %else97 ]
  %t1273 = phi %NativeSourceSpan* [ %t1271, %then99 ], [ %t1257, %else97 ]
  store { i8**, i64 }* %t1272, { i8**, i64 }** %l1
  store %NativeSourceSpan* %t1273, %NativeSourceSpan** %l10
  %t1274 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1275 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge98
merge98:
  %t1276 = phi %NativeSourceSpan* [ %t1244, %then96 ], [ %t1275, %merge100 ]
  %t1277 = phi { i8**, i64 }* [ %t1227, %then96 ], [ %t1274, %merge100 ]
  store %NativeSourceSpan* %t1276, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t1277, { i8**, i64 }** %l1
  %t1278 = load %NativeFunction*, %NativeFunction** %l8
  %t1279 = icmp eq %NativeFunction* %t1278, null
  %t1280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1281 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1282 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1283 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1284 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1285 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1286 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1287 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1288 = load %NativeFunction*, %NativeFunction** %l8
  %t1289 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1290 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1291 = load double, double* %l11
  %t1292 = load i8*, i8** %l12
  %t1293 = load i8*, i8** %l13
  %t1294 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1295 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1296 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1279, label %then101, label %merge102
then101:
  %t1298 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1299 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1298
  %t1300 = extractvalue { %NativeInstruction*, i64 } %t1299, 1
  %t1301 = icmp eq i64 %t1300, 1
  br label %logical_and_entry_1297

logical_and_entry_1297:
  br i1 %t1301, label %logical_and_right_1297, label %logical_and_merge_1297

logical_and_right_1297:
  %t1302 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1303 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1302
  %t1304 = extractvalue { %NativeInstruction*, i64 } %t1303, 0
  %t1305 = extractvalue { %NativeInstruction*, i64 } %t1303, 1
  %t1306 = icmp uge i64 0, %t1305
  ; bounds check: %t1306 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1305)
  %t1307 = getelementptr %NativeInstruction, %NativeInstruction* %t1304, i64 0
  %t1308 = load %NativeInstruction, %NativeInstruction* %t1307
  %t1309 = extractvalue %NativeInstruction %t1308, 0
  %t1310 = getelementptr inbounds [1 x i8], [1 x i8]* @.enum.NativeInstruction.variant.default, i32 0, i32 0
  %t1311 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.Return.variant, i32 0, i32 0
  %t1312 = icmp eq i32 %t1309, 0
  %t1313 = select i1 %t1312, i8* %t1311, i8* %t1310
  %t1314 = getelementptr inbounds [11 x i8], [11 x i8]* @.enum.NativeInstruction.Expression.variant, i32 0, i32 0
  %t1315 = icmp eq i32 %t1309, 1
  %t1316 = select i1 %t1315, i8* %t1314, i8* %t1313
  %t1317 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.Let.variant, i32 0, i32 0
  %t1318 = icmp eq i32 %t1309, 2
  %t1319 = select i1 %t1318, i8* %t1317, i8* %t1316
  %t1320 = getelementptr inbounds [3 x i8], [3 x i8]* @.enum.NativeInstruction.If.variant, i32 0, i32 0
  %t1321 = icmp eq i32 %t1309, 3
  %t1322 = select i1 %t1321, i8* %t1320, i8* %t1319
  %t1323 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Else.variant, i32 0, i32 0
  %t1324 = icmp eq i32 %t1309, 4
  %t1325 = select i1 %t1324, i8* %t1323, i8* %t1322
  %t1326 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.EndIf.variant, i32 0, i32 0
  %t1327 = icmp eq i32 %t1309, 5
  %t1328 = select i1 %t1327, i8* %t1326, i8* %t1325
  %t1329 = getelementptr inbounds [4 x i8], [4 x i8]* @.enum.NativeInstruction.For.variant, i32 0, i32 0
  %t1330 = icmp eq i32 %t1309, 6
  %t1331 = select i1 %t1330, i8* %t1329, i8* %t1328
  %t1332 = getelementptr inbounds [7 x i8], [7 x i8]* @.enum.NativeInstruction.EndFor.variant, i32 0, i32 0
  %t1333 = icmp eq i32 %t1309, 7
  %t1334 = select i1 %t1333, i8* %t1332, i8* %t1331
  %t1335 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Loop.variant, i32 0, i32 0
  %t1336 = icmp eq i32 %t1309, 8
  %t1337 = select i1 %t1336, i8* %t1335, i8* %t1334
  %t1338 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.EndLoop.variant, i32 0, i32 0
  %t1339 = icmp eq i32 %t1309, 9
  %t1340 = select i1 %t1339, i8* %t1338, i8* %t1337
  %t1341 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Break.variant, i32 0, i32 0
  %t1342 = icmp eq i32 %t1309, 10
  %t1343 = select i1 %t1342, i8* %t1341, i8* %t1340
  %t1344 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.Continue.variant, i32 0, i32 0
  %t1345 = icmp eq i32 %t1309, 11
  %t1346 = select i1 %t1345, i8* %t1344, i8* %t1343
  %t1347 = getelementptr inbounds [6 x i8], [6 x i8]* @.enum.NativeInstruction.Match.variant, i32 0, i32 0
  %t1348 = icmp eq i32 %t1309, 12
  %t1349 = select i1 %t1348, i8* %t1347, i8* %t1346
  %t1350 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Case.variant, i32 0, i32 0
  %t1351 = icmp eq i32 %t1309, 13
  %t1352 = select i1 %t1351, i8* %t1350, i8* %t1349
  %t1353 = getelementptr inbounds [9 x i8], [9 x i8]* @.enum.NativeInstruction.EndMatch.variant, i32 0, i32 0
  %t1354 = icmp eq i32 %t1309, 14
  %t1355 = select i1 %t1354, i8* %t1353, i8* %t1352
  %t1356 = getelementptr inbounds [5 x i8], [5 x i8]* @.enum.NativeInstruction.Noop.variant, i32 0, i32 0
  %t1357 = icmp eq i32 %t1309, 15
  %t1358 = select i1 %t1357, i8* %t1356, i8* %t1355
  %t1359 = getelementptr inbounds [8 x i8], [8 x i8]* @.enum.NativeInstruction.Unknown.variant, i32 0, i32 0
  %t1360 = icmp eq i32 %t1309, 16
  %t1361 = select i1 %t1360, i8* %t1359, i8* %t1358
  %s1362 = getelementptr inbounds [4 x i8], [4 x i8]* @.str.len3.h2089318639, i32 0, i32 0
  %t1363 = call i1 @strings_equal(i8* %t1361, i8* %s1362)
  br label %logical_and_right_end_1297

logical_and_right_end_1297:
  br label %logical_and_merge_1297

logical_and_merge_1297:
  %t1364 = phi i1 [ false, %logical_and_entry_1297 ], [ %t1363, %logical_and_right_end_1297 ]
  %t1365 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1366 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1367 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1368 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1369 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1370 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1371 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1372 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1373 = load %NativeFunction*, %NativeFunction** %l8
  %t1374 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1375 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1376 = load double, double* %l11
  %t1377 = load i8*, i8** %l12
  %t1378 = load i8*, i8** %l13
  %t1379 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1380 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1381 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  br i1 %t1364, label %then103, label %else104
then103:
  %t1382 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1383 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1384 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1383
  %t1385 = extractvalue { %NativeInstruction*, i64 } %t1384, 0
  %t1386 = extractvalue { %NativeInstruction*, i64 } %t1384, 1
  %t1387 = icmp uge i64 0, %t1386
  ; bounds check: %t1387 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 0, i64 %t1386)
  %t1388 = getelementptr %NativeInstruction, %NativeInstruction* %t1385, i64 0
  %t1389 = load %NativeInstruction, %NativeInstruction* %t1388
  %t1390 = call %NativeBinding @binding_from_instruction(%NativeInstruction %t1389)
  %t1391 = call { %NativeBinding*, i64 }* @append_binding({ %NativeBinding*, i64 }* %t1382, %NativeBinding %t1390)
  store { %NativeBinding*, i64 }* %t1391, { %NativeBinding*, i64 }** %l7
  %t1392 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %merge105
else104:
  %t1393 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1394 = getelementptr inbounds [48 x i8], [48 x i8]* @.str.len47.h1886628617, i32 0, i32 0
  %t1395 = load i8*, i8** %l13
  %t1396 = call i8* @sailfin_runtime_string_concat(i8* %s1394, i8* %t1395)
  %t1397 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1393, i8* %t1396)
  store { i8**, i64 }* %t1397, { i8**, i64 }** %l1
  %t1398 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge105
merge105:
  %t1399 = phi { %NativeBinding*, i64 }* [ %t1392, %then103 ], [ %t1372, %else104 ]
  %t1400 = phi { i8**, i64 }* [ %t1366, %then103 ], [ %t1398, %else104 ]
  store { %NativeBinding*, i64 }* %t1399, { %NativeBinding*, i64 }** %l7
  store { i8**, i64 }* %t1400, { i8**, i64 }** %l1
  %t1401 = load double, double* %l11
  %t1402 = sitofp i64 1 to double
  %t1403 = fadd double %t1401, %t1402
  store double %t1403, double* %l11
  br label %loop.latch2
merge102:
  %t1404 = sitofp i64 0 to double
  store double %t1404, double* %l34
  %t1405 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1407 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1408 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1409 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1410 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1411 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1412 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1413 = load %NativeFunction*, %NativeFunction** %l8
  %t1414 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1415 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1416 = load double, double* %l11
  %t1417 = load i8*, i8** %l12
  %t1418 = load i8*, i8** %l13
  %t1419 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1420 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1421 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1422 = load double, double* %l34
  br label %loop.header106
loop.header106:
  %t1469 = phi %NativeFunction* [ %t1413, %merge102 ], [ %t1467, %loop.latch108 ]
  %t1470 = phi double [ %t1422, %merge102 ], [ %t1468, %loop.latch108 ]
  store %NativeFunction* %t1469, %NativeFunction** %l8
  store double %t1470, double* %l34
  br label %loop.body107
loop.body107:
  %t1423 = load double, double* %l34
  %t1424 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1425 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1424
  %t1426 = extractvalue { %NativeInstruction*, i64 } %t1425, 1
  %t1427 = sitofp i64 %t1426 to double
  %t1428 = fcmp oge double %t1423, %t1427
  %t1429 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1430 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1431 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1432 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1433 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1434 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1435 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1436 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1437 = load %NativeFunction*, %NativeFunction** %l8
  %t1438 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1439 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1440 = load double, double* %l11
  %t1441 = load i8*, i8** %l12
  %t1442 = load i8*, i8** %l13
  %t1443 = load %InstructionGatherResult, %InstructionGatherResult* %l31
  %t1444 = load %InstructionParseResult, %InstructionParseResult* %l32
  %t1445 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1446 = load double, double* %l34
  br i1 %t1428, label %then110, label %merge111
then110:
  br label %afterloop109
merge111:
  %t1447 = load %NativeFunction*, %NativeFunction** %l8
  %t1448 = load { %NativeInstruction*, i64 }*, { %NativeInstruction*, i64 }** %l33
  %t1449 = load double, double* %l34
  %t1450 = call double @llvm.round.f64(double %t1449)
  %t1451 = fptosi double %t1450 to i64
  %t1452 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1448
  %t1453 = extractvalue { %NativeInstruction*, i64 } %t1452, 0
  %t1454 = extractvalue { %NativeInstruction*, i64 } %t1452, 1
  %t1455 = icmp uge i64 %t1451, %t1454
  ; bounds check: %t1455 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t1451, i64 %t1454)
  %t1456 = getelementptr %NativeInstruction, %NativeInstruction* %t1453, i64 %t1451
  %t1457 = load %NativeInstruction, %NativeInstruction* %t1456
  %t1458 = load %NativeFunction, %NativeFunction* %t1447
  %t1459 = call %NativeFunction @append_instruction(%NativeFunction %t1458, %NativeInstruction %t1457)
  %t1460 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t1461 = ptrtoint %NativeFunction* %t1460 to i64
  %t1462 = call noalias i8* @malloc(i64 %t1461)
  %t1463 = bitcast i8* %t1462 to %NativeFunction*
  store %NativeFunction %t1459, %NativeFunction* %t1463
  call void @sailfin_runtime_mark_persistent(i8* %t1462)
  store %NativeFunction* %t1463, %NativeFunction** %l8
  %t1464 = load double, double* %l34
  %t1465 = sitofp i64 1 to double
  %t1466 = fadd double %t1464, %t1465
  store double %t1466, double* %l34
  br label %loop.latch108
loop.latch108:
  %t1467 = load %NativeFunction*, %NativeFunction** %l8
  %t1468 = load double, double* %l34
  br label %loop.header106
afterloop109:
  %t1471 = load %NativeFunction*, %NativeFunction** %l8
  %t1472 = load double, double* %l34
  %t1473 = load double, double* %l11
  %t1474 = sitofp i64 1 to double
  %t1475 = fadd double %t1473, %t1474
  store double %t1475, double* %l11
  br label %loop.latch2
loop.latch2:
  %t1476 = load double, double* %l11
  %t1477 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1478 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1479 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1480 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1481 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1482 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1483 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1484 = load %NativeFunction*, %NativeFunction** %l8
  %t1485 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1486 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  br label %loop.header0
afterloop3:
  %t1498 = load double, double* %l11
  %t1499 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1500 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1501 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1502 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1503 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1504 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1505 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1506 = load %NativeFunction*, %NativeFunction** %l8
  %t1507 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1508 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1509 = load %NativeFunction*, %NativeFunction** %l8
  %t1510 = icmp ne %NativeFunction* %t1509, null
  %t1511 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1512 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1513 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1514 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1515 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1516 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1517 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1518 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1519 = load %NativeFunction*, %NativeFunction** %l8
  %t1520 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1521 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1522 = load double, double* %l11
  br i1 %t1510, label %then112, label %merge113
then112:
  %t1523 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %s1524 = getelementptr inbounds [41 x i8], [41 x i8]* @.str.len40.h1512965366, i32 0, i32 0
  %t1525 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1523, i8* %s1524)
  store { i8**, i64 }* %t1525, { i8**, i64 }** %l1
  %t1526 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge113
merge113:
  %t1527 = phi { i8**, i64 }* [ %t1526, %then112 ], [ %t1512, %afterloop3 ]
  store { i8**, i64 }* %t1527, { i8**, i64 }** %l1
  %t1528 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l2
  %t1529 = insertvalue %ParseNativeResult undef, { %NativeFunction*, i64 }* %t1528, 0
  %t1530 = load { %NativeImport*, i64 }*, { %NativeImport*, i64 }** %l3
  %t1531 = insertvalue %ParseNativeResult %t1529, { %NativeImport*, i64 }* %t1530, 1
  %t1532 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l4
  %t1533 = insertvalue %ParseNativeResult %t1531, { %NativeStruct*, i64 }* %t1532, 2
  %t1534 = load { %NativeInterface*, i64 }*, { %NativeInterface*, i64 }** %l5
  %t1535 = insertvalue %ParseNativeResult %t1533, { %NativeInterface*, i64 }* %t1534, 3
  %t1536 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l6
  %t1537 = insertvalue %ParseNativeResult %t1535, { %NativeEnum*, i64 }* %t1536, 4
  %t1538 = load { %NativeBinding*, i64 }*, { %NativeBinding*, i64 }** %l7
  %t1539 = insertvalue %ParseNativeResult %t1537, { %NativeBinding*, i64 }* %t1538, 5
  %t1540 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t1541 = insertvalue %ParseNativeResult %t1539, { i8**, i64 }* %t1540, 6
  ret %ParseNativeResult %t1541
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
  %t93 = getelementptr %NativeSourceSpan, %NativeSourceSpan* null, i32 1
  %t94 = ptrtoint %NativeSourceSpan* %t93 to i64
  %t95 = call noalias i8* @malloc(i64 %t94)
  %t96 = bitcast i8* %t95 to %NativeSourceSpan*
  store %NativeSourceSpan %t92, %NativeSourceSpan* %t96
  call void @sailfin_runtime_mark_persistent(i8* %t95)
  ret %NativeSourceSpan* %t96
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

define { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %variants, %NativeEnumVariantLayout %value) {
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
  %t56 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t54, %NativeEnumVariantLayout %t55)
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
  %t68 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t58, %NativeEnumVariantLayout %t67)
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
  %t131 = call i8* @trim_text(i8* %t130)
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
  %t23 = call i8* @trim_text(i8* %t22)
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
  %t89 = call i8* @trim_text(i8* %t88)
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
  %t105 = call i8* @trim_text(i8* %t104)
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
  %t117 = call i8* @trim_text(i8* %t116)
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
  %t245 = call i8* @trim_text(i8* %t244)
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
  %t330 = call i8* @trim_text(i8* %t329)
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
  %t410 = call i8* @trim_text(i8* %t409)
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
  %t475 = call i8* @trim_text(i8* %t474)
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
  %t484 = call i8* @trim_text(i8* %t483)
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
  %t547 = call i8* @trim_text(i8* %t546)
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
  %t55 = call i8* @trim_text(i8* %t54)
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
  %t73 = call i8* @trim_text(i8* %t72)
  %t74 = call i8* @strip_quotes(i8* %t73)
  store i8* %t74, i8** %l1
  %t75 = insertvalue %NativeImport undef, i8* %kind, 0
  %t76 = load i8*, i8** %l1
  %t77 = insertvalue %NativeImport %t75, i8* %t76, 1
  %t78 = load { %NativeImportSpecifier*, i64 }*, { %NativeImportSpecifier*, i64 }** %l2
  %t79 = insertvalue %NativeImport %t77, { %NativeImportSpecifier*, i64 }* %t78, 2
  %t80 = getelementptr %NativeImport, %NativeImport* null, i32 1
  %t81 = ptrtoint %NativeImport* %t80 to i64
  %t82 = call noalias i8* @malloc(i64 %t81)
  %t83 = bitcast i8* %t82 to %NativeImport*
  store %NativeImport %t79, %NativeImport* %t83
  call void @sailfin_runtime_mark_persistent(i8* %t82)
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
  %t1268 = phi { i8**, i64 }* [ %t99, %merge1 ], [ %t1256, %loop.latch4 ]
  %t1269 = phi double [ %t115, %merge1 ], [ %t1257, %loop.latch4 ]
  %t1270 = phi { %NativeFunction*, i64 }* [ %t106, %merge1 ], [ %t1258, %loop.latch4 ]
  %t1271 = phi %NativeFunction* [ %t107, %merge1 ], [ %t1259, %loop.latch4 ]
  %t1272 = phi %NativeSourceSpan* [ %t108, %merge1 ], [ %t1260, %loop.latch4 ]
  %t1273 = phi %NativeSourceSpan* [ %t109, %merge1 ], [ %t1261, %loop.latch4 ]
  %t1274 = phi double [ %t111, %merge1 ], [ %t1262, %loop.latch4 ]
  %t1275 = phi double [ %t112, %merge1 ], [ %t1263, %loop.latch4 ]
  %t1276 = phi i1 [ %t113, %merge1 ], [ %t1264, %loop.latch4 ]
  %t1277 = phi { %NativeStructLayoutField*, i64 }* [ %t110, %merge1 ], [ %t1265, %loop.latch4 ]
  %t1278 = phi i1 [ %t114, %merge1 ], [ %t1266, %loop.latch4 ]
  %t1279 = phi { %NativeStructField*, i64 }* [ %t105, %merge1 ], [ %t1267, %loop.latch4 ]
  store { i8**, i64 }* %t1268, { i8**, i64 }** %l0
  store double %t1269, double* %l16
  store { %NativeFunction*, i64 }* %t1270, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t1271, %NativeFunction** %l8
  store %NativeSourceSpan* %t1272, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t1273, %NativeSourceSpan** %l10
  store double %t1274, double* %l12
  store double %t1275, double* %l13
  store i1 %t1276, i1* %l14
  store { %NativeStructLayoutField*, i64 }* %t1277, { %NativeStructLayoutField*, i64 }** %l11
  store i1 %t1278, i1* %l15
  store { %NativeStructField*, i64 }* %t1279, { %NativeStructField*, i64 }** %l6
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
  %t169 = getelementptr %NativeStructLayout, %NativeStructLayout* null, i32 1
  %t170 = ptrtoint %NativeStructLayout* %t169 to i64
  %t171 = call noalias i8* @malloc(i64 %t170)
  %t172 = bitcast i8* %t171 to %NativeStructLayout*
  store %NativeStructLayout %t168, %NativeStructLayout* %t172
  call void @sailfin_runtime_mark_persistent(i8* %t171)
  store %NativeStructLayout* %t172, %NativeStructLayout** %l17
  %t173 = load %NativeStructLayout*, %NativeStructLayout** %l17
  br label %merge9
merge9:
  %t174 = phi %NativeStructLayout* [ %t173, %then8 ], [ %t162, %then6 ]
  store %NativeStructLayout* %t174, %NativeStructLayout** %l17
  %t175 = load i8*, i8** %l4
  %t176 = insertvalue %NativeStruct undef, i8* %t175, 0
  %t177 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t178 = insertvalue %NativeStruct %t176, { %NativeStructField*, i64 }* %t177, 1
  %t179 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t180 = insertvalue %NativeStruct %t178, { %NativeFunction*, i64 }* %t179, 2
  %t181 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t182 = insertvalue %NativeStruct %t180, { i8**, i64 }* %t181, 3
  %t183 = load %NativeStructLayout*, %NativeStructLayout** %l17
  %t184 = insertvalue %NativeStruct %t182, %NativeStructLayout* %t183, 4
  %t185 = getelementptr %NativeStruct, %NativeStruct* null, i32 1
  %t186 = ptrtoint %NativeStruct* %t185 to i64
  %t187 = call noalias i8* @malloc(i64 %t186)
  %t188 = bitcast i8* %t187 to %NativeStruct*
  store %NativeStruct %t184, %NativeStruct* %t188
  call void @sailfin_runtime_mark_persistent(i8* %t187)
  %t189 = insertvalue %StructParseResult undef, %NativeStruct* %t188, 0
  %t190 = load double, double* %l16
  %t191 = insertvalue %StructParseResult %t189, double %t190, 1
  %t192 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t193 = insertvalue %StructParseResult %t191, { i8**, i64 }* %t192, 2
  ret %StructParseResult %t193
merge7:
  %t194 = load double, double* %l16
  %t195 = call double @llvm.round.f64(double %t194)
  %t196 = fptosi double %t195 to i64
  %t197 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t198 = extractvalue { i8**, i64 } %t197, 0
  %t199 = extractvalue { i8**, i64 } %t197, 1
  %t200 = icmp uge i64 %t196, %t199
  ; bounds check: %t200 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t196, i64 %t199)
  %t201 = getelementptr i8*, i8** %t198, i64 %t196
  %t202 = load i8*, i8** %t201
  %t203 = call i8* @trim_text(i8* %t202)
  store i8* %t203, i8** %l18
  %t205 = load i8*, i8** %l18
  %t206 = call i64 @sailfin_runtime_string_length(i8* %t205)
  %t207 = icmp eq i64 %t206, 0
  br label %logical_or_entry_204

logical_or_entry_204:
  br i1 %t207, label %logical_or_merge_204, label %logical_or_right_204

logical_or_right_204:
  %t208 = load i8*, i8** %l18
  %t209 = add i64 0, 2
  %t210 = call i8* @malloc(i64 %t209)
  store i8 59, i8* %t210
  %t211 = getelementptr i8, i8* %t210, i64 1
  store i8 0, i8* %t211
  call void @sailfin_runtime_mark_persistent(i8* %t210)
  %t212 = call i1 @starts_with(i8* %t208, i8* %t210)
  br label %logical_or_right_end_204

logical_or_right_end_204:
  br label %logical_or_merge_204

logical_or_merge_204:
  %t213 = phi i1 [ true, %logical_or_entry_204 ], [ %t212, %logical_or_right_end_204 ]
  %t214 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t215 = load i8*, i8** %l1
  %t216 = load i8*, i8** %l2
  %t217 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t218 = load i8*, i8** %l4
  %t219 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t220 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t221 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t222 = load %NativeFunction*, %NativeFunction** %l8
  %t223 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t224 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t225 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t226 = load double, double* %l12
  %t227 = load double, double* %l13
  %t228 = load i1, i1* %l14
  %t229 = load i1, i1* %l15
  %t230 = load double, double* %l16
  %t231 = load i8*, i8** %l18
  br i1 %t213, label %then10, label %merge11
then10:
  %t232 = load double, double* %l16
  %t233 = sitofp i64 1 to double
  %t234 = fadd double %t232, %t233
  store double %t234, double* %l16
  br label %loop.latch4
merge11:
  %t235 = load i8*, i8** %l18
  %s236 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h2070880298, i32 0, i32 0
  %t237 = call i1 @strings_equal(i8* %t235, i8* %s236)
  %t238 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t239 = load i8*, i8** %l1
  %t240 = load i8*, i8** %l2
  %t241 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t242 = load i8*, i8** %l4
  %t243 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t244 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t245 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t246 = load %NativeFunction*, %NativeFunction** %l8
  %t247 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t248 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t249 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t250 = load double, double* %l12
  %t251 = load double, double* %l13
  %t252 = load i1, i1* %l14
  %t253 = load i1, i1* %l15
  %t254 = load double, double* %l16
  %t255 = load i8*, i8** %l18
  br i1 %t237, label %then12, label %merge13
then12:
  %t256 = load %NativeFunction*, %NativeFunction** %l8
  %t257 = icmp ne %NativeFunction* %t256, null
  %t258 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t259 = load i8*, i8** %l1
  %t260 = load i8*, i8** %l2
  %t261 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t262 = load i8*, i8** %l4
  %t263 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t264 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t265 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t266 = load %NativeFunction*, %NativeFunction** %l8
  %t267 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t268 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t269 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t270 = load double, double* %l12
  %t271 = load double, double* %l13
  %t272 = load i1, i1* %l14
  %t273 = load i1, i1* %l15
  %t274 = load double, double* %l16
  %t275 = load i8*, i8** %l18
  br i1 %t257, label %then14, label %merge15
then14:
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s277 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h208276320, i32 0, i32 0
  %t278 = load i8*, i8** %l4
  %t279 = call i8* @sailfin_runtime_string_concat(i8* %s277, i8* %t278)
  %t280 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t276, i8* %t279)
  store { i8**, i64 }* %t280, { i8**, i64 }** %l0
  %t281 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t282 = load %NativeFunction*, %NativeFunction** %l8
  %t283 = load %NativeFunction, %NativeFunction* %t282
  %t284 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t281, %NativeFunction %t283)
  store { %NativeFunction*, i64 }* %t284, { %NativeFunction*, i64 }** %l7
  %t285 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t285, %NativeFunction** %l8
  %t286 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t286, %NativeSourceSpan** %l9
  %t287 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t287, %NativeSourceSpan** %l10
  %t288 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t289 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t290 = load %NativeFunction*, %NativeFunction** %l8
  %t291 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t292 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge15
merge15:
  %t293 = phi { i8**, i64 }* [ %t288, %then14 ], [ %t258, %then12 ]
  %t294 = phi { %NativeFunction*, i64 }* [ %t289, %then14 ], [ %t265, %then12 ]
  %t295 = phi %NativeFunction* [ %t290, %then14 ], [ %t266, %then12 ]
  %t296 = phi %NativeSourceSpan* [ %t291, %then14 ], [ %t267, %then12 ]
  %t297 = phi %NativeSourceSpan* [ %t292, %then14 ], [ %t268, %then12 ]
  store { i8**, i64 }* %t293, { i8**, i64 }** %l0
  store { %NativeFunction*, i64 }* %t294, { %NativeFunction*, i64 }** %l7
  store %NativeFunction* %t295, %NativeFunction** %l8
  store %NativeSourceSpan* %t296, %NativeSourceSpan** %l9
  store %NativeSourceSpan* %t297, %NativeSourceSpan** %l10
  %t298 = load double, double* %l16
  %t299 = sitofp i64 1 to double
  %t300 = fadd double %t298, %t299
  store double %t300, double* %l16
  br label %afterloop5
merge13:
  %t301 = load %NativeFunction*, %NativeFunction** %l8
  %t302 = icmp ne %NativeFunction* %t301, null
  %t303 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t304 = load i8*, i8** %l1
  %t305 = load i8*, i8** %l2
  %t306 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t307 = load i8*, i8** %l4
  %t308 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t309 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t310 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t311 = load %NativeFunction*, %NativeFunction** %l8
  %t312 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t313 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t314 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t315 = load double, double* %l12
  %t316 = load double, double* %l13
  %t317 = load i1, i1* %l14
  %t318 = load i1, i1* %l15
  %t319 = load double, double* %l16
  %t320 = load i8*, i8** %l18
  br i1 %t302, label %then16, label %merge17
then16:
  %t321 = load i8*, i8** %l18
  %s322 = getelementptr inbounds [11 x i8], [11 x i8]* @.str.len10.h179409731, i32 0, i32 0
  %t323 = call i1 @strings_equal(i8* %t321, i8* %s322)
  %t324 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t325 = load i8*, i8** %l1
  %t326 = load i8*, i8** %l2
  %t327 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t328 = load i8*, i8** %l4
  %t329 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t330 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t331 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t332 = load %NativeFunction*, %NativeFunction** %l8
  %t333 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t334 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t335 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t336 = load double, double* %l12
  %t337 = load double, double* %l13
  %t338 = load i1, i1* %l14
  %t339 = load i1, i1* %l15
  %t340 = load double, double* %l16
  %t341 = load i8*, i8** %l18
  br i1 %t323, label %then18, label %merge19
then18:
  %t342 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t343 = load %NativeFunction*, %NativeFunction** %l8
  %t344 = load %NativeFunction, %NativeFunction* %t343
  %t345 = call { %NativeFunction*, i64 }* @append_function({ %NativeFunction*, i64 }* %t342, %NativeFunction %t344)
  store { %NativeFunction*, i64 }* %t345, { %NativeFunction*, i64 }** %l7
  %t346 = bitcast i8* null to %NativeFunction*
  store %NativeFunction* %t346, %NativeFunction** %l8
  %t347 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t347, %NativeSourceSpan** %l9
  %t348 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t348, %NativeSourceSpan** %l10
  %t349 = load double, double* %l16
  %t350 = sitofp i64 1 to double
  %t351 = fadd double %t349, %t350
  store double %t351, double* %l16
  br label %loop.latch4
merge19:
  %t352 = load i8*, i8** %l18
  %s353 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t354 = call i1 @starts_with(i8* %t352, i8* %s353)
  %t355 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t356 = load i8*, i8** %l1
  %t357 = load i8*, i8** %l2
  %t358 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t359 = load i8*, i8** %l4
  %t360 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t361 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t362 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t363 = load %NativeFunction*, %NativeFunction** %l8
  %t364 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t365 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t366 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t367 = load double, double* %l12
  %t368 = load double, double* %l13
  %t369 = load i1, i1* %l14
  %t370 = load i1, i1* %l15
  %t371 = load double, double* %l16
  %t372 = load i8*, i8** %l18
  br i1 %t354, label %then20, label %merge21
then20:
  %t373 = load %NativeFunction*, %NativeFunction** %l8
  %t374 = load i8*, i8** %l18
  %s375 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1583308163, i32 0, i32 0
  %t376 = call i8* @strip_prefix(i8* %t374, i8* %s375)
  %t377 = load %NativeFunction, %NativeFunction* %t373
  %t378 = call %NativeFunction @apply_meta(%NativeFunction %t377, i8* %t376)
  %t379 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t380 = ptrtoint %NativeFunction* %t379 to i64
  %t381 = call noalias i8* @malloc(i64 %t380)
  %t382 = bitcast i8* %t381 to %NativeFunction*
  store %NativeFunction %t378, %NativeFunction* %t382
  call void @sailfin_runtime_mark_persistent(i8* %t381)
  store %NativeFunction* %t382, %NativeFunction** %l8
  %t383 = load double, double* %l16
  %t384 = sitofp i64 1 to double
  %t385 = fadd double %t383, %t384
  store double %t385, double* %l16
  br label %loop.latch4
merge21:
  %t386 = load i8*, i8** %l18
  %s387 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t388 = call i1 @starts_with(i8* %t386, i8* %s387)
  %t389 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t390 = load i8*, i8** %l1
  %t391 = load i8*, i8** %l2
  %t392 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t393 = load i8*, i8** %l4
  %t394 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t395 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t396 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t397 = load %NativeFunction*, %NativeFunction** %l8
  %t398 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t399 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t400 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t401 = load double, double* %l12
  %t402 = load double, double* %l13
  %t403 = load i1, i1* %l14
  %t404 = load i1, i1* %l15
  %t405 = load double, double* %l16
  %t406 = load i8*, i8** %l18
  br i1 %t388, label %then22, label %merge23
then22:
  %t407 = load i8*, i8** %l18
  %s408 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h130169768, i32 0, i32 0
  %t409 = call i8* @strip_prefix(i8* %t407, i8* %s408)
  %t410 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t411 = call %NativeParameter* @parse_parameter_entry(i8* %t409, %NativeSourceSpan* %t410)
  store %NativeParameter* %t411, %NativeParameter** %l19
  %t412 = load %NativeParameter*, %NativeParameter** %l19
  %t413 = icmp eq %NativeParameter* %t412, null
  %t414 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t415 = load i8*, i8** %l1
  %t416 = load i8*, i8** %l2
  %t417 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t418 = load i8*, i8** %l4
  %t419 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t420 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t421 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t422 = load %NativeFunction*, %NativeFunction** %l8
  %t423 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t424 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t425 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t426 = load double, double* %l12
  %t427 = load double, double* %l13
  %t428 = load i1, i1* %l14
  %t429 = load i1, i1* %l15
  %t430 = load double, double* %l16
  %t431 = load i8*, i8** %l18
  %t432 = load %NativeParameter*, %NativeParameter** %l19
  br i1 %t413, label %then24, label %else25
then24:
  %t433 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s434 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h1211676914, i32 0, i32 0
  %t435 = load i8*, i8** %l18
  %t436 = call i8* @sailfin_runtime_string_concat(i8* %s434, i8* %t435)
  %t437 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t433, i8* %t436)
  store { i8**, i64 }* %t437, { i8**, i64 }** %l0
  %t438 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge26
else25:
  %t439 = load %NativeFunction*, %NativeFunction** %l8
  %t440 = load %NativeParameter*, %NativeParameter** %l19
  %t441 = load %NativeFunction, %NativeFunction* %t439
  %t442 = load %NativeParameter, %NativeParameter* %t440
  %t443 = call %NativeFunction @append_parameter(%NativeFunction %t441, %NativeParameter %t442)
  %t444 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t445 = ptrtoint %NativeFunction* %t444 to i64
  %t446 = call noalias i8* @malloc(i64 %t445)
  %t447 = bitcast i8* %t446 to %NativeFunction*
  store %NativeFunction %t443, %NativeFunction* %t447
  call void @sailfin_runtime_mark_persistent(i8* %t446)
  store %NativeFunction* %t447, %NativeFunction** %l8
  %t448 = load %NativeFunction*, %NativeFunction** %l8
  br label %merge26
merge26:
  %t449 = phi { i8**, i64 }* [ %t438, %then24 ], [ %t414, %else25 ]
  %t450 = phi %NativeFunction* [ %t422, %then24 ], [ %t448, %else25 ]
  store { i8**, i64 }* %t449, { i8**, i64 }** %l0
  store %NativeFunction* %t450, %NativeFunction** %l8
  %t451 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t451, %NativeSourceSpan** %l9
  %t452 = load double, double* %l16
  %t453 = sitofp i64 1 to double
  %t454 = fadd double %t452, %t453
  store double %t454, double* %l16
  br label %loop.latch4
merge23:
  %t455 = load i8*, i8** %l18
  %s456 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t457 = call i1 @starts_with(i8* %t455, i8* %s456)
  %t458 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t459 = load i8*, i8** %l1
  %t460 = load i8*, i8** %l2
  %t461 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t462 = load i8*, i8** %l4
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t464 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t465 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t466 = load %NativeFunction*, %NativeFunction** %l8
  %t467 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t468 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t469 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t470 = load double, double* %l12
  %t471 = load double, double* %l13
  %t472 = load i1, i1* %l14
  %t473 = load i1, i1* %l15
  %t474 = load double, double* %l16
  %t475 = load i8*, i8** %l18
  br i1 %t457, label %then27, label %merge28
then27:
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s477 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t478 = load i8*, i8** %l4
  %t479 = call i8* @sailfin_runtime_string_concat(i8* %s477, i8* %t478)
  %t480 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t476, i8* %t479)
  store { i8**, i64 }* %t480, { i8**, i64 }** %l0
  %t481 = load double, double* %l16
  %t482 = sitofp i64 1 to double
  %t483 = fadd double %t481, %t482
  store double %t483, double* %l16
  br label %loop.latch4
merge28:
  %t484 = load i8*, i8** %l18
  %s485 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t486 = call i1 @starts_with(i8* %t484, i8* %s485)
  %t487 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t488 = load i8*, i8** %l1
  %t489 = load i8*, i8** %l2
  %t490 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t491 = load i8*, i8** %l4
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t493 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t494 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t495 = load %NativeFunction*, %NativeFunction** %l8
  %t496 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t497 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t498 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t499 = load double, double* %l12
  %t500 = load double, double* %l13
  %t501 = load i1, i1* %l14
  %t502 = load i1, i1* %l15
  %t503 = load double, double* %l16
  %t504 = load i8*, i8** %l18
  br i1 %t486, label %then29, label %merge30
then29:
  %t505 = load i8*, i8** %l18
  %s506 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h1830497006, i32 0, i32 0
  %t507 = call i8* @strip_prefix(i8* %t505, i8* %s506)
  %t508 = call %NativeSourceSpan* @parse_source_span(i8* %t507)
  store %NativeSourceSpan* %t508, %NativeSourceSpan** %l20
  %t509 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  %t510 = icmp eq %NativeSourceSpan* %t509, null
  %t511 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t512 = load i8*, i8** %l1
  %t513 = load i8*, i8** %l2
  %t514 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t515 = load i8*, i8** %l4
  %t516 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t517 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t518 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t519 = load %NativeFunction*, %NativeFunction** %l8
  %t520 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t521 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t522 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t523 = load double, double* %l12
  %t524 = load double, double* %l13
  %t525 = load i1, i1* %l14
  %t526 = load i1, i1* %l15
  %t527 = load double, double* %l16
  %t528 = load i8*, i8** %l18
  %t529 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  br i1 %t510, label %then31, label %else32
then31:
  %t530 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s531 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h762677253, i32 0, i32 0
  %t532 = load i8*, i8** %l18
  %t533 = call i8* @sailfin_runtime_string_concat(i8* %s531, i8* %t532)
  %t534 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t530, i8* %t533)
  store { i8**, i64 }* %t534, { i8**, i64 }** %l0
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge33
else32:
  %t536 = load %NativeSourceSpan*, %NativeSourceSpan** %l20
  store %NativeSourceSpan* %t536, %NativeSourceSpan** %l9
  %t537 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge33
merge33:
  %t538 = phi { i8**, i64 }* [ %t535, %then31 ], [ %t511, %else32 ]
  %t539 = phi %NativeSourceSpan* [ %t520, %then31 ], [ %t537, %else32 ]
  store { i8**, i64 }* %t538, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t539, %NativeSourceSpan** %l9
  %t540 = load double, double* %l16
  %t541 = sitofp i64 1 to double
  %t542 = fadd double %t540, %t541
  store double %t542, double* %l16
  br label %loop.latch4
merge30:
  %t543 = load i8*, i8** %l18
  %s544 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t545 = call i1 @starts_with(i8* %t543, i8* %s544)
  %t546 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t547 = load i8*, i8** %l1
  %t548 = load i8*, i8** %l2
  %t549 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t550 = load i8*, i8** %l4
  %t551 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t552 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t553 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t554 = load %NativeFunction*, %NativeFunction** %l8
  %t555 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t556 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t557 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t558 = load double, double* %l12
  %t559 = load double, double* %l13
  %t560 = load i1, i1* %l14
  %t561 = load i1, i1* %l15
  %t562 = load double, double* %l16
  %t563 = load i8*, i8** %l18
  br i1 %t545, label %then34, label %merge35
then34:
  %t564 = load i8*, i8** %l18
  %s565 = getelementptr inbounds [12 x i8], [12 x i8]* @.str.len11.h1513373193, i32 0, i32 0
  %t566 = call i8* @strip_prefix(i8* %t564, i8* %s565)
  %t567 = call %NativeSourceSpan* @parse_source_span(i8* %t566)
  store %NativeSourceSpan* %t567, %NativeSourceSpan** %l21
  %t568 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  %t569 = icmp eq %NativeSourceSpan* %t568, null
  %t570 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t571 = load i8*, i8** %l1
  %t572 = load i8*, i8** %l2
  %t573 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t574 = load i8*, i8** %l4
  %t575 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t576 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t577 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t578 = load %NativeFunction*, %NativeFunction** %l8
  %t579 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t580 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t581 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t582 = load double, double* %l12
  %t583 = load double, double* %l13
  %t584 = load i1, i1* %l14
  %t585 = load i1, i1* %l15
  %t586 = load double, double* %l16
  %t587 = load i8*, i8** %l18
  %t588 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  br i1 %t569, label %then36, label %else37
then36:
  %t589 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s590 = getelementptr inbounds [44 x i8], [44 x i8]* @.str.len43.h1714227133, i32 0, i32 0
  %t591 = load i8*, i8** %l18
  %t592 = call i8* @sailfin_runtime_string_concat(i8* %s590, i8* %t591)
  %t593 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t589, i8* %t592)
  store { i8**, i64 }* %t593, { i8**, i64 }** %l0
  %t594 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge38
else37:
  %t595 = load %NativeSourceSpan*, %NativeSourceSpan** %l21
  store %NativeSourceSpan* %t595, %NativeSourceSpan** %l10
  %t596 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge38
merge38:
  %t597 = phi { i8**, i64 }* [ %t594, %then36 ], [ %t570, %else37 ]
  %t598 = phi %NativeSourceSpan* [ %t580, %then36 ], [ %t596, %else37 ]
  store { i8**, i64 }* %t597, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t598, %NativeSourceSpan** %l10
  %t599 = load double, double* %l16
  %t600 = sitofp i64 1 to double
  %t601 = fadd double %t599, %t600
  store double %t601, double* %l16
  br label %loop.latch4
merge35:
  %t602 = load i8*, i8** %l18
  %t603 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t604 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t605 = call %InstructionParseResult @parse_instruction(i8* %t602, %NativeSourceSpan* %t603, %NativeSourceSpan* %t604)
  store %InstructionParseResult %t605, %InstructionParseResult* %l22
  %t606 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t607 = extractvalue %InstructionParseResult %t606, 1
  %t608 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t609 = load i8*, i8** %l1
  %t610 = load i8*, i8** %l2
  %t611 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t612 = load i8*, i8** %l4
  %t613 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t614 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t615 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t616 = load %NativeFunction*, %NativeFunction** %l8
  %t617 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t618 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t619 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t620 = load double, double* %l12
  %t621 = load double, double* %l13
  %t622 = load i1, i1* %l14
  %t623 = load i1, i1* %l15
  %t624 = load double, double* %l16
  %t625 = load i8*, i8** %l18
  %t626 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t607, label %then39, label %else40
then39:
  %t627 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t627, %NativeSourceSpan** %l9
  %t628 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
else40:
  %t629 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t630 = icmp ne %NativeSourceSpan* %t629, null
  %t631 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t632 = load i8*, i8** %l1
  %t633 = load i8*, i8** %l2
  %t634 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t635 = load i8*, i8** %l4
  %t636 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t637 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t638 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t639 = load %NativeFunction*, %NativeFunction** %l8
  %t640 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t641 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t642 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t643 = load double, double* %l12
  %t644 = load double, double* %l13
  %t645 = load i1, i1* %l14
  %t646 = load i1, i1* %l15
  %t647 = load double, double* %l16
  %t648 = load i8*, i8** %l18
  %t649 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t630, label %then42, label %merge43
then42:
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s651 = getelementptr inbounds [30 x i8], [30 x i8]* @.str.len29.h1601547567, i32 0, i32 0
  %t652 = load i8*, i8** %l18
  %t653 = call i8* @sailfin_runtime_string_concat(i8* %s651, i8* %t652)
  %t654 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t650, i8* %t653)
  store { i8**, i64 }* %t654, { i8**, i64 }** %l0
  %t655 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t655, %NativeSourceSpan** %l9
  %t656 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t657 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge43
merge43:
  %t658 = phi { i8**, i64 }* [ %t656, %then42 ], [ %t631, %else40 ]
  %t659 = phi %NativeSourceSpan* [ %t657, %then42 ], [ %t640, %else40 ]
  store { i8**, i64 }* %t658, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t659, %NativeSourceSpan** %l9
  %t660 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t661 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  br label %merge41
merge41:
  %t662 = phi %NativeSourceSpan* [ %t628, %then39 ], [ %t661, %merge43 ]
  %t663 = phi { i8**, i64 }* [ %t608, %then39 ], [ %t660, %merge43 ]
  store %NativeSourceSpan* %t662, %NativeSourceSpan** %l9
  store { i8**, i64 }* %t663, { i8**, i64 }** %l0
  %t664 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t665 = extractvalue %InstructionParseResult %t664, 2
  %t666 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t667 = load i8*, i8** %l1
  %t668 = load i8*, i8** %l2
  %t669 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t670 = load i8*, i8** %l4
  %t671 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t672 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t673 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t674 = load %NativeFunction*, %NativeFunction** %l8
  %t675 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t676 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t677 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t678 = load double, double* %l12
  %t679 = load double, double* %l13
  %t680 = load i1, i1* %l14
  %t681 = load i1, i1* %l15
  %t682 = load double, double* %l16
  %t683 = load i8*, i8** %l18
  %t684 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t665, label %then44, label %else45
then44:
  %t685 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t685, %NativeSourceSpan** %l10
  %t686 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
else45:
  %t687 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t688 = icmp ne %NativeSourceSpan* %t687, null
  %t689 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t690 = load i8*, i8** %l1
  %t691 = load i8*, i8** %l2
  %t692 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t693 = load i8*, i8** %l4
  %t694 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t695 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t696 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t697 = load %NativeFunction*, %NativeFunction** %l8
  %t698 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t699 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t700 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t701 = load double, double* %l12
  %t702 = load double, double* %l13
  %t703 = load i1, i1* %l14
  %t704 = load i1, i1* %l15
  %t705 = load double, double* %l16
  %t706 = load i8*, i8** %l18
  %t707 = load %InstructionParseResult, %InstructionParseResult* %l22
  br i1 %t688, label %then47, label %merge48
then47:
  %t708 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s709 = getelementptr inbounds [42 x i8], [42 x i8]* @.str.len41.h35508704, i32 0, i32 0
  %t710 = load i8*, i8** %l18
  %t711 = call i8* @sailfin_runtime_string_concat(i8* %s709, i8* %t710)
  %t712 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t708, i8* %t711)
  store { i8**, i64 }* %t712, { i8**, i64 }** %l0
  %t713 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t713, %NativeSourceSpan** %l10
  %t714 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t715 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge48
merge48:
  %t716 = phi { i8**, i64 }* [ %t714, %then47 ], [ %t689, %else45 ]
  %t717 = phi %NativeSourceSpan* [ %t715, %then47 ], [ %t699, %else45 ]
  store { i8**, i64 }* %t716, { i8**, i64 }** %l0
  store %NativeSourceSpan* %t717, %NativeSourceSpan** %l10
  %t718 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t719 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  br label %merge46
merge46:
  %t720 = phi %NativeSourceSpan* [ %t686, %then44 ], [ %t719, %merge48 ]
  %t721 = phi { i8**, i64 }* [ %t666, %then44 ], [ %t718, %merge48 ]
  store %NativeSourceSpan* %t720, %NativeSourceSpan** %l10
  store { i8**, i64 }* %t721, { i8**, i64 }** %l0
  %t722 = sitofp i64 0 to double
  store double %t722, double* %l23
  %t723 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t724 = load i8*, i8** %l1
  %t725 = load i8*, i8** %l2
  %t726 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t727 = load i8*, i8** %l4
  %t728 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t729 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t730 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t731 = load %NativeFunction*, %NativeFunction** %l8
  %t732 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t733 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t734 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t735 = load double, double* %l12
  %t736 = load double, double* %l13
  %t737 = load i1, i1* %l14
  %t738 = load i1, i1* %l15
  %t739 = load double, double* %l16
  %t740 = load i8*, i8** %l18
  %t741 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t742 = load double, double* %l23
  br label %loop.header49
loop.header49:
  %t793 = phi %NativeFunction* [ %t731, %merge46 ], [ %t791, %loop.latch51 ]
  %t794 = phi double [ %t742, %merge46 ], [ %t792, %loop.latch51 ]
  store %NativeFunction* %t793, %NativeFunction** %l8
  store double %t794, double* %l23
  br label %loop.body50
loop.body50:
  %t743 = load double, double* %l23
  %t744 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t745 = extractvalue %InstructionParseResult %t744, 0
  %t746 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t745
  %t747 = extractvalue { %NativeInstruction*, i64 } %t746, 1
  %t748 = sitofp i64 %t747 to double
  %t749 = fcmp oge double %t743, %t748
  %t750 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t751 = load i8*, i8** %l1
  %t752 = load i8*, i8** %l2
  %t753 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t754 = load i8*, i8** %l4
  %t755 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t756 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t757 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t758 = load %NativeFunction*, %NativeFunction** %l8
  %t759 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t760 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t761 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t762 = load double, double* %l12
  %t763 = load double, double* %l13
  %t764 = load i1, i1* %l14
  %t765 = load i1, i1* %l15
  %t766 = load double, double* %l16
  %t767 = load i8*, i8** %l18
  %t768 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t769 = load double, double* %l23
  br i1 %t749, label %then53, label %merge54
then53:
  br label %afterloop52
merge54:
  %t770 = load %NativeFunction*, %NativeFunction** %l8
  %t771 = load %InstructionParseResult, %InstructionParseResult* %l22
  %t772 = extractvalue %InstructionParseResult %t771, 0
  %t773 = load double, double* %l23
  %t774 = call double @llvm.round.f64(double %t773)
  %t775 = fptosi double %t774 to i64
  %t776 = load { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t772
  %t777 = extractvalue { %NativeInstruction*, i64 } %t776, 0
  %t778 = extractvalue { %NativeInstruction*, i64 } %t776, 1
  %t779 = icmp uge i64 %t775, %t778
  ; bounds check: %t779 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t775, i64 %t778)
  %t780 = getelementptr %NativeInstruction, %NativeInstruction* %t777, i64 %t775
  %t781 = load %NativeInstruction, %NativeInstruction* %t780
  %t782 = load %NativeFunction, %NativeFunction* %t770
  %t783 = call %NativeFunction @append_instruction(%NativeFunction %t782, %NativeInstruction %t781)
  %t784 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t785 = ptrtoint %NativeFunction* %t784 to i64
  %t786 = call noalias i8* @malloc(i64 %t785)
  %t787 = bitcast i8* %t786 to %NativeFunction*
  store %NativeFunction %t783, %NativeFunction* %t787
  call void @sailfin_runtime_mark_persistent(i8* %t786)
  store %NativeFunction* %t787, %NativeFunction** %l8
  %t788 = load double, double* %l23
  %t789 = sitofp i64 1 to double
  %t790 = fadd double %t788, %t789
  store double %t790, double* %l23
  br label %loop.latch51
loop.latch51:
  %t791 = load %NativeFunction*, %NativeFunction** %l8
  %t792 = load double, double* %l23
  br label %loop.header49
afterloop52:
  %t795 = load %NativeFunction*, %NativeFunction** %l8
  %t796 = load double, double* %l23
  %t797 = load double, double* %l16
  %t798 = sitofp i64 1 to double
  %t799 = fadd double %t797, %t798
  store double %t799, double* %l16
  br label %loop.latch4
merge17:
  %t800 = load i8*, i8** %l18
  %s801 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t802 = call i1 @starts_with(i8* %t800, i8* %s801)
  %t803 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t804 = load i8*, i8** %l1
  %t805 = load i8*, i8** %l2
  %t806 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t807 = load i8*, i8** %l4
  %t808 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t809 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t810 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t811 = load %NativeFunction*, %NativeFunction** %l8
  %t812 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t813 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t814 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t815 = load double, double* %l12
  %t816 = load double, double* %l13
  %t817 = load i1, i1* %l14
  %t818 = load i1, i1* %l15
  %t819 = load double, double* %l16
  %t820 = load i8*, i8** %l18
  br i1 %t802, label %then55, label %merge56
then55:
  %t821 = load i8*, i8** %l18
  %s822 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t823 = call i8* @strip_prefix(i8* %t821, i8* %s822)
  store i8* %t823, i8** %l24
  %t824 = load i8*, i8** %l24
  %s825 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t826 = call i1 @starts_with(i8* %t824, i8* %s825)
  %t827 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t828 = load i8*, i8** %l1
  %t829 = load i8*, i8** %l2
  %t830 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t831 = load i8*, i8** %l4
  %t832 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t833 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t834 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t835 = load %NativeFunction*, %NativeFunction** %l8
  %t836 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t837 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t838 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t839 = load double, double* %l12
  %t840 = load double, double* %l13
  %t841 = load i1, i1* %l14
  %t842 = load i1, i1* %l15
  %t843 = load double, double* %l16
  %t844 = load i8*, i8** %l18
  %t845 = load i8*, i8** %l24
  br i1 %t826, label %then57, label %merge58
then57:
  %t846 = load i8*, i8** %l24
  %s847 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t848 = call i8* @strip_prefix(i8* %t846, i8* %s847)
  %t849 = call %StructLayoutHeaderParse @parse_struct_layout_header(i8* %t848)
  store %StructLayoutHeaderParse %t849, %StructLayoutHeaderParse* %l25
  %t850 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t851 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t852 = extractvalue %StructLayoutHeaderParse %t851, 4
  %t853 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t850, { i8**, i64 }* %t852)
  store { i8**, i64 }* %t853, { i8**, i64 }** %l0
  %t854 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t855 = extractvalue %StructLayoutHeaderParse %t854, 0
  %t856 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t857 = load i8*, i8** %l1
  %t858 = load i8*, i8** %l2
  %t859 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t860 = load i8*, i8** %l4
  %t861 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t862 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t863 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t864 = load %NativeFunction*, %NativeFunction** %l8
  %t865 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t866 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t867 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t868 = load double, double* %l12
  %t869 = load double, double* %l13
  %t870 = load i1, i1* %l14
  %t871 = load i1, i1* %l15
  %t872 = load double, double* %l16
  %t873 = load i8*, i8** %l18
  %t874 = load i8*, i8** %l24
  %t875 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t855, label %then59, label %merge60
then59:
  %t876 = load i1, i1* %l14
  %t877 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t878 = load i8*, i8** %l1
  %t879 = load i8*, i8** %l2
  %t880 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t881 = load i8*, i8** %l4
  %t882 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t883 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t884 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t885 = load %NativeFunction*, %NativeFunction** %l8
  %t886 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t887 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t888 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t889 = load double, double* %l12
  %t890 = load double, double* %l13
  %t891 = load i1, i1* %l14
  %t892 = load i1, i1* %l15
  %t893 = load double, double* %l16
  %t894 = load i8*, i8** %l18
  %t895 = load i8*, i8** %l24
  %t896 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  br i1 %t876, label %then61, label %else62
then61:
  %t897 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s898 = getelementptr inbounds [35 x i8], [35 x i8]* @.str.len34.h654371835, i32 0, i32 0
  %t899 = load i8*, i8** %l4
  %t900 = call i8* @sailfin_runtime_string_concat(i8* %s898, i8* %t899)
  %t901 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t897, i8* %t900)
  store { i8**, i64 }* %t901, { i8**, i64 }** %l0
  %t902 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge63
else62:
  %t903 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t904 = extractvalue %StructLayoutHeaderParse %t903, 2
  store double %t904, double* %l12
  %t905 = load %StructLayoutHeaderParse, %StructLayoutHeaderParse* %l25
  %t906 = extractvalue %StructLayoutHeaderParse %t905, 3
  store double %t906, double* %l13
  store i1 1, i1* %l14
  %t907 = load double, double* %l12
  %t908 = load double, double* %l13
  %t909 = load i1, i1* %l14
  br label %merge63
merge63:
  %t910 = phi { i8**, i64 }* [ %t902, %then61 ], [ %t877, %else62 ]
  %t911 = phi double [ %t889, %then61 ], [ %t907, %else62 ]
  %t912 = phi double [ %t890, %then61 ], [ %t908, %else62 ]
  %t913 = phi i1 [ %t891, %then61 ], [ %t909, %else62 ]
  store { i8**, i64 }* %t910, { i8**, i64 }** %l0
  store double %t911, double* %l12
  store double %t912, double* %l13
  store i1 %t913, i1* %l14
  %t914 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t915 = load double, double* %l12
  %t916 = load double, double* %l13
  %t917 = load i1, i1* %l14
  br label %merge60
merge60:
  %t918 = phi { i8**, i64 }* [ %t914, %merge63 ], [ %t856, %then57 ]
  %t919 = phi double [ %t915, %merge63 ], [ %t868, %then57 ]
  %t920 = phi double [ %t916, %merge63 ], [ %t869, %then57 ]
  %t921 = phi i1 [ %t917, %merge63 ], [ %t870, %then57 ]
  store { i8**, i64 }* %t918, { i8**, i64 }** %l0
  store double %t919, double* %l12
  store double %t920, double* %l13
  store i1 %t921, i1* %l14
  %t922 = load double, double* %l16
  %t923 = sitofp i64 1 to double
  %t924 = fadd double %t922, %t923
  store double %t924, double* %l16
  br label %loop.latch4
merge58:
  %t925 = load i8*, i8** %l24
  %s926 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t927 = call i1 @starts_with(i8* %t925, i8* %s926)
  %t928 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t929 = load i8*, i8** %l1
  %t930 = load i8*, i8** %l2
  %t931 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t932 = load i8*, i8** %l4
  %t933 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t934 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t935 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t936 = load %NativeFunction*, %NativeFunction** %l8
  %t937 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t938 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t939 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t940 = load double, double* %l12
  %t941 = load double, double* %l13
  %t942 = load i1, i1* %l14
  %t943 = load i1, i1* %l15
  %t944 = load double, double* %l16
  %t945 = load i8*, i8** %l18
  %t946 = load i8*, i8** %l24
  br i1 %t927, label %then64, label %merge65
then64:
  %t947 = load i8*, i8** %l24
  %s948 = getelementptr inbounds [7 x i8], [7 x i8]* @.str.len6.h734244628, i32 0, i32 0
  %t949 = call i8* @strip_prefix(i8* %t947, i8* %s948)
  %t950 = load i8*, i8** %l4
  %t951 = call %StructLayoutFieldParse @parse_struct_layout_field(i8* %t949, i8* %t950)
  store %StructLayoutFieldParse %t951, %StructLayoutFieldParse* %l26
  %t952 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t953 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t954 = extractvalue %StructLayoutFieldParse %t953, 2
  %t955 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t952, { i8**, i64 }* %t954)
  store { i8**, i64 }* %t955, { i8**, i64 }** %l0
  %t956 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t957 = extractvalue %StructLayoutFieldParse %t956, 0
  %t958 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t959 = load i8*, i8** %l1
  %t960 = load i8*, i8** %l2
  %t961 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t962 = load i8*, i8** %l4
  %t963 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t964 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t965 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t966 = load %NativeFunction*, %NativeFunction** %l8
  %t967 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t968 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t969 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t970 = load double, double* %l12
  %t971 = load double, double* %l13
  %t972 = load i1, i1* %l14
  %t973 = load i1, i1* %l15
  %t974 = load double, double* %l16
  %t975 = load i8*, i8** %l18
  %t976 = load i8*, i8** %l24
  %t977 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t957, label %then66, label %merge67
then66:
  %t978 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t979 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  %t980 = extractvalue %StructLayoutFieldParse %t979, 1
  %t981 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t978, %NativeStructLayoutField %t980)
  store { %NativeStructLayoutField*, i64 }* %t981, { %NativeStructLayoutField*, i64 }** %l11
  %t982 = load i1, i1* %l14
  %t983 = xor i1 %t982, 1
  %t984 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t985 = load i8*, i8** %l1
  %t986 = load i8*, i8** %l2
  %t987 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t988 = load i8*, i8** %l4
  %t989 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t990 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t991 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t992 = load %NativeFunction*, %NativeFunction** %l8
  %t993 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t994 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t995 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t996 = load double, double* %l12
  %t997 = load double, double* %l13
  %t998 = load i1, i1* %l14
  %t999 = load i1, i1* %l15
  %t1000 = load double, double* %l16
  %t1001 = load i8*, i8** %l18
  %t1002 = load i8*, i8** %l24
  %t1003 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t983, label %then68, label %merge69
then68:
  %t1004 = load i1, i1* %l15
  %t1005 = xor i1 %t1004, 1
  %t1006 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1007 = load i8*, i8** %l1
  %t1008 = load i8*, i8** %l2
  %t1009 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1010 = load i8*, i8** %l4
  %t1011 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1012 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1013 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1014 = load %NativeFunction*, %NativeFunction** %l8
  %t1015 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1016 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1017 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1018 = load double, double* %l12
  %t1019 = load double, double* %l13
  %t1020 = load i1, i1* %l14
  %t1021 = load i1, i1* %l15
  %t1022 = load double, double* %l16
  %t1023 = load i8*, i8** %l18
  %t1024 = load i8*, i8** %l24
  %t1025 = load %StructLayoutFieldParse, %StructLayoutFieldParse* %l26
  br i1 %t1005, label %then70, label %merge71
then70:
  %t1026 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1027 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h289982314, i32 0, i32 0
  %t1028 = load i8*, i8** %l4
  %t1029 = call i8* @sailfin_runtime_string_concat(i8* %s1027, i8* %t1028)
  %s1030 = getelementptr inbounds [47 x i8], [47 x i8]* @.str.len46.h1830585629, i32 0, i32 0
  %t1031 = call i8* @sailfin_runtime_string_concat(i8* %t1029, i8* %s1030)
  %t1032 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1026, i8* %t1031)
  store { i8**, i64 }* %t1032, { i8**, i64 }** %l0
  store i1 1, i1* %l15
  %t1033 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1034 = load i1, i1* %l15
  br label %merge71
merge71:
  %t1035 = phi { i8**, i64 }* [ %t1033, %then70 ], [ %t1006, %then68 ]
  %t1036 = phi i1 [ %t1034, %then70 ], [ %t1021, %then68 ]
  store { i8**, i64 }* %t1035, { i8**, i64 }** %l0
  store i1 %t1036, i1* %l15
  %t1037 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1038 = load i1, i1* %l15
  br label %merge69
merge69:
  %t1039 = phi { i8**, i64 }* [ %t1037, %merge71 ], [ %t984, %then66 ]
  %t1040 = phi i1 [ %t1038, %merge71 ], [ %t999, %then66 ]
  store { i8**, i64 }* %t1039, { i8**, i64 }** %l0
  store i1 %t1040, i1* %l15
  %t1041 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1042 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1043 = load i1, i1* %l15
  br label %merge67
merge67:
  %t1044 = phi { %NativeStructLayoutField*, i64 }* [ %t1041, %merge69 ], [ %t969, %then64 ]
  %t1045 = phi { i8**, i64 }* [ %t1042, %merge69 ], [ %t958, %then64 ]
  %t1046 = phi i1 [ %t1043, %merge69 ], [ %t973, %then64 ]
  store { %NativeStructLayoutField*, i64 }* %t1044, { %NativeStructLayoutField*, i64 }** %l11
  store { i8**, i64 }* %t1045, { i8**, i64 }** %l0
  store i1 %t1046, i1* %l15
  %t1047 = load double, double* %l16
  %t1048 = sitofp i64 1 to double
  %t1049 = fadd double %t1047, %t1048
  store double %t1049, double* %l16
  br label %loop.latch4
merge65:
  %t1050 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1051 = getelementptr inbounds [38 x i8], [38 x i8]* @.str.len37.h1152036459, i32 0, i32 0
  %t1052 = load i8*, i8** %l18
  %t1053 = call i8* @sailfin_runtime_string_concat(i8* %s1051, i8* %t1052)
  %t1054 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1050, i8* %t1053)
  store { i8**, i64 }* %t1054, { i8**, i64 }** %l0
  %t1055 = load double, double* %l16
  %t1056 = sitofp i64 1 to double
  %t1057 = fadd double %t1055, %t1056
  store double %t1057, double* %l16
  br label %loop.latch4
merge56:
  %t1058 = load i8*, i8** %l18
  %s1059 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t1060 = call i1 @strings_equal(i8* %t1058, i8* %s1059)
  %t1061 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1062 = load i8*, i8** %l1
  %t1063 = load i8*, i8** %l2
  %t1064 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1065 = load i8*, i8** %l4
  %t1066 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1067 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1068 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1069 = load %NativeFunction*, %NativeFunction** %l8
  %t1070 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1071 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1072 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1073 = load double, double* %l12
  %t1074 = load double, double* %l13
  %t1075 = load i1, i1* %l14
  %t1076 = load i1, i1* %l15
  %t1077 = load double, double* %l16
  %t1078 = load i8*, i8** %l18
  br i1 %t1060, label %then72, label %merge73
then72:
  %t1079 = load double, double* %l16
  %t1080 = sitofp i64 1 to double
  %t1081 = fadd double %t1079, %t1080
  store double %t1081, double* %l16
  br label %loop.latch4
merge73:
  %t1082 = load i8*, i8** %l18
  %s1083 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1084 = call i1 @starts_with(i8* %t1082, i8* %s1083)
  %t1085 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1086 = load i8*, i8** %l1
  %t1087 = load i8*, i8** %l2
  %t1088 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1089 = load i8*, i8** %l4
  %t1090 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1091 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1092 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1093 = load %NativeFunction*, %NativeFunction** %l8
  %t1094 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1095 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1096 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1097 = load double, double* %l12
  %t1098 = load double, double* %l13
  %t1099 = load i1, i1* %l14
  %t1100 = load i1, i1* %l15
  %t1101 = load double, double* %l16
  %t1102 = load i8*, i8** %l18
  br i1 %t1084, label %then74, label %merge75
then74:
  %t1103 = load i8*, i8** %l18
  %s1104 = getelementptr inbounds [8 x i8], [8 x i8]* @.str.len7.h398443637, i32 0, i32 0
  %t1105 = call i8* @strip_prefix(i8* %t1103, i8* %s1104)
  %t1106 = call %NativeStructField* @parse_struct_field_line(i8* %t1105)
  store %NativeStructField* %t1106, %NativeStructField** %l27
  %t1107 = load %NativeStructField*, %NativeStructField** %l27
  %t1108 = icmp eq %NativeStructField* %t1107, null
  %t1109 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1110 = load i8*, i8** %l1
  %t1111 = load i8*, i8** %l2
  %t1112 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1113 = load i8*, i8** %l4
  %t1114 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1115 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1116 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1117 = load %NativeFunction*, %NativeFunction** %l8
  %t1118 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1119 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1120 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1121 = load double, double* %l12
  %t1122 = load double, double* %l13
  %t1123 = load i1, i1* %l14
  %t1124 = load i1, i1* %l15
  %t1125 = load double, double* %l16
  %t1126 = load i8*, i8** %l18
  %t1127 = load %NativeStructField*, %NativeStructField** %l27
  br i1 %t1108, label %then76, label %else77
then76:
  %t1128 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1129 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h702899578, i32 0, i32 0
  %t1130 = load i8*, i8** %l18
  %t1131 = call i8* @sailfin_runtime_string_concat(i8* %s1129, i8* %t1130)
  %t1132 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1128, i8* %t1131)
  store { i8**, i64 }* %t1132, { i8**, i64 }** %l0
  %t1133 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge78
else77:
  %t1134 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1135 = load %NativeStructField*, %NativeStructField** %l27
  %t1136 = load %NativeStructField, %NativeStructField* %t1135
  %t1137 = call { %NativeStructField*, i64 }* @append_struct_field({ %NativeStructField*, i64 }* %t1134, %NativeStructField %t1136)
  store { %NativeStructField*, i64 }* %t1137, { %NativeStructField*, i64 }** %l6
  %t1138 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %merge78
merge78:
  %t1139 = phi { i8**, i64 }* [ %t1133, %then76 ], [ %t1109, %else77 ]
  %t1140 = phi { %NativeStructField*, i64 }* [ %t1115, %then76 ], [ %t1138, %else77 ]
  store { i8**, i64 }* %t1139, { i8**, i64 }** %l0
  store { %NativeStructField*, i64 }* %t1140, { %NativeStructField*, i64 }** %l6
  %t1141 = load double, double* %l16
  %t1142 = sitofp i64 1 to double
  %t1143 = fadd double %t1141, %t1142
  store double %t1143, double* %l16
  br label %loop.latch4
merge75:
  %t1144 = load i8*, i8** %l18
  %s1145 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1146 = call i1 @starts_with(i8* %t1144, i8* %s1145)
  %t1147 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1148 = load i8*, i8** %l1
  %t1149 = load i8*, i8** %l2
  %t1150 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1151 = load i8*, i8** %l4
  %t1152 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1153 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1154 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1155 = load %NativeFunction*, %NativeFunction** %l8
  %t1156 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1157 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1158 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1159 = load double, double* %l12
  %t1160 = load double, double* %l13
  %t1161 = load i1, i1* %l14
  %t1162 = load i1, i1* %l15
  %t1163 = load double, double* %l16
  %t1164 = load i8*, i8** %l18
  br i1 %t1146, label %then79, label %merge80
then79:
  %t1165 = load %NativeFunction*, %NativeFunction** %l8
  %t1166 = icmp ne %NativeFunction* %t1165, null
  %t1167 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1168 = load i8*, i8** %l1
  %t1169 = load i8*, i8** %l2
  %t1170 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1171 = load i8*, i8** %l4
  %t1172 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1173 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1174 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1175 = load %NativeFunction*, %NativeFunction** %l8
  %t1176 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1177 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1178 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1179 = load double, double* %l12
  %t1180 = load double, double* %l13
  %t1181 = load i1, i1* %l14
  %t1182 = load i1, i1* %l15
  %t1183 = load double, double* %l16
  %t1184 = load i8*, i8** %l18
  br i1 %t1166, label %then81, label %merge82
then81:
  %t1185 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1186 = getelementptr inbounds [37 x i8], [37 x i8]* @.str.len36.h736848621, i32 0, i32 0
  %t1187 = load i8*, i8** %l4
  %t1188 = call i8* @sailfin_runtime_string_concat(i8* %s1186, i8* %t1187)
  %t1189 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1185, i8* %t1188)
  store { i8**, i64 }* %t1189, { i8**, i64 }** %l0
  %t1190 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge82
merge82:
  %t1191 = phi { i8**, i64 }* [ %t1190, %then81 ], [ %t1167, %then79 ]
  store { i8**, i64 }* %t1191, { i8**, i64 }** %l0
  %t1192 = load i8*, i8** %l18
  %s1193 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1951948513, i32 0, i32 0
  %t1194 = call i8* @strip_prefix(i8* %t1192, i8* %s1193)
  %t1195 = call i8* @parse_function_name(i8* %t1194)
  store i8* %t1195, i8** %l28
  %t1196 = load i8*, i8** %l28
  %t1197 = insertvalue %NativeFunction undef, i8* %t1196, 0
  %t1198 = getelementptr [0 x %NativeParameter], [0 x %NativeParameter]* null, i32 1
  %t1199 = ptrtoint [0 x %NativeParameter]* %t1198 to i64
  %t1200 = icmp eq i64 %t1199, 0
  %t1201 = select i1 %t1200, i64 1, i64 %t1199
  %t1202 = call i8* @malloc(i64 %t1201)
  %t1203 = bitcast i8* %t1202 to %NativeParameter*
  %t1204 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* null, i32 1
  %t1205 = ptrtoint { %NativeParameter*, i64 }* %t1204 to i64
  %t1206 = call i8* @malloc(i64 %t1205)
  %t1207 = bitcast i8* %t1206 to { %NativeParameter*, i64 }*
  %t1208 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t1207, i32 0, i32 0
  store %NativeParameter* %t1203, %NativeParameter** %t1208
  %t1209 = getelementptr { %NativeParameter*, i64 }, { %NativeParameter*, i64 }* %t1207, i32 0, i32 1
  store i64 0, i64* %t1209
  %t1210 = insertvalue %NativeFunction %t1197, { %NativeParameter*, i64 }* %t1207, 1
  %s1211 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h278197661, i32 0, i32 0
  %t1212 = insertvalue %NativeFunction %t1210, i8* %s1211, 2
  %t1213 = getelementptr [0 x i8*], [0 x i8*]* null, i32 1
  %t1214 = ptrtoint [0 x i8*]* %t1213 to i64
  %t1215 = icmp eq i64 %t1214, 0
  %t1216 = select i1 %t1215, i64 1, i64 %t1214
  %t1217 = call i8* @malloc(i64 %t1216)
  %t1218 = bitcast i8* %t1217 to i8**
  %t1219 = getelementptr { i8**, i64 }, { i8**, i64 }* null, i32 1
  %t1220 = ptrtoint { i8**, i64 }* %t1219 to i64
  %t1221 = call i8* @malloc(i64 %t1220)
  %t1222 = bitcast i8* %t1221 to { i8**, i64 }*
  %t1223 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1222, i32 0, i32 0
  store i8** %t1218, i8*** %t1223
  %t1224 = getelementptr { i8**, i64 }, { i8**, i64 }* %t1222, i32 0, i32 1
  store i64 0, i64* %t1224
  %t1225 = insertvalue %NativeFunction %t1212, { i8**, i64 }* %t1222, 3
  %t1226 = getelementptr [0 x %NativeInstruction], [0 x %NativeInstruction]* null, i32 1
  %t1227 = ptrtoint [0 x %NativeInstruction]* %t1226 to i64
  %t1228 = icmp eq i64 %t1227, 0
  %t1229 = select i1 %t1228, i64 1, i64 %t1227
  %t1230 = call i8* @malloc(i64 %t1229)
  %t1231 = bitcast i8* %t1230 to %NativeInstruction*
  %t1232 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* null, i32 1
  %t1233 = ptrtoint { %NativeInstruction*, i64 }* %t1232 to i64
  %t1234 = call i8* @malloc(i64 %t1233)
  %t1235 = bitcast i8* %t1234 to { %NativeInstruction*, i64 }*
  %t1236 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1235, i32 0, i32 0
  store %NativeInstruction* %t1231, %NativeInstruction** %t1236
  %t1237 = getelementptr { %NativeInstruction*, i64 }, { %NativeInstruction*, i64 }* %t1235, i32 0, i32 1
  store i64 0, i64* %t1237
  %t1238 = insertvalue %NativeFunction %t1225, { %NativeInstruction*, i64 }* %t1235, 4
  %t1239 = getelementptr %NativeFunction, %NativeFunction* null, i32 1
  %t1240 = ptrtoint %NativeFunction* %t1239 to i64
  %t1241 = call noalias i8* @malloc(i64 %t1240)
  %t1242 = bitcast i8* %t1241 to %NativeFunction*
  store %NativeFunction %t1238, %NativeFunction* %t1242
  call void @sailfin_runtime_mark_persistent(i8* %t1241)
  store %NativeFunction* %t1242, %NativeFunction** %l8
  %t1243 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1243, %NativeSourceSpan** %l9
  %t1244 = bitcast i8* null to %NativeSourceSpan*
  store %NativeSourceSpan* %t1244, %NativeSourceSpan** %l10
  %t1245 = load double, double* %l16
  %t1246 = sitofp i64 1 to double
  %t1247 = fadd double %t1245, %t1246
  store double %t1247, double* %l16
  br label %loop.latch4
merge80:
  %t1248 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s1249 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h211710404, i32 0, i32 0
  %t1250 = load i8*, i8** %l18
  %t1251 = call i8* @sailfin_runtime_string_concat(i8* %s1249, i8* %t1250)
  %t1252 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t1248, i8* %t1251)
  store { i8**, i64 }* %t1252, { i8**, i64 }** %l0
  %t1253 = load double, double* %l16
  %t1254 = sitofp i64 1 to double
  %t1255 = fadd double %t1253, %t1254
  store double %t1255, double* %l16
  br label %loop.latch4
loop.latch4:
  %t1256 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1257 = load double, double* %l16
  %t1258 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1259 = load %NativeFunction*, %NativeFunction** %l8
  %t1260 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1261 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1262 = load double, double* %l12
  %t1263 = load double, double* %l13
  %t1264 = load i1, i1* %l14
  %t1265 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1266 = load i1, i1* %l15
  %t1267 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  br label %loop.header2
afterloop5:
  %t1280 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1281 = load double, double* %l16
  %t1282 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1283 = load %NativeFunction*, %NativeFunction** %l8
  %t1284 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1285 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1286 = load double, double* %l12
  %t1287 = load double, double* %l13
  %t1288 = load i1, i1* %l14
  %t1289 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1290 = load i1, i1* %l15
  %t1291 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1292 = bitcast i8* null to %NativeStructLayout*
  store %NativeStructLayout* %t1292, %NativeStructLayout** %l29
  %t1293 = load i1, i1* %l14
  %t1294 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1295 = load i8*, i8** %l1
  %t1296 = load i8*, i8** %l2
  %t1297 = load %StructHeaderParse, %StructHeaderParse* %l3
  %t1298 = load i8*, i8** %l4
  %t1299 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1300 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1301 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1302 = load %NativeFunction*, %NativeFunction** %l8
  %t1303 = load %NativeSourceSpan*, %NativeSourceSpan** %l9
  %t1304 = load %NativeSourceSpan*, %NativeSourceSpan** %l10
  %t1305 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1306 = load double, double* %l12
  %t1307 = load double, double* %l13
  %t1308 = load i1, i1* %l14
  %t1309 = load i1, i1* %l15
  %t1310 = load double, double* %l16
  %t1311 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br i1 %t1293, label %then83, label %merge84
then83:
  %t1312 = load double, double* %l12
  %t1313 = insertvalue %NativeStructLayout undef, double %t1312, 0
  %t1314 = load double, double* %l13
  %t1315 = insertvalue %NativeStructLayout %t1313, double %t1314, 1
  %t1316 = load { %NativeStructLayoutField*, i64 }*, { %NativeStructLayoutField*, i64 }** %l11
  %t1317 = insertvalue %NativeStructLayout %t1315, { %NativeStructLayoutField*, i64 }* %t1316, 2
  %t1318 = getelementptr %NativeStructLayout, %NativeStructLayout* null, i32 1
  %t1319 = ptrtoint %NativeStructLayout* %t1318 to i64
  %t1320 = call noalias i8* @malloc(i64 %t1319)
  %t1321 = bitcast i8* %t1320 to %NativeStructLayout*
  store %NativeStructLayout %t1317, %NativeStructLayout* %t1321
  call void @sailfin_runtime_mark_persistent(i8* %t1320)
  store %NativeStructLayout* %t1321, %NativeStructLayout** %l29
  %t1322 = load %NativeStructLayout*, %NativeStructLayout** %l29
  br label %merge84
merge84:
  %t1323 = phi %NativeStructLayout* [ %t1322, %then83 ], [ %t1311, %afterloop5 ]
  store %NativeStructLayout* %t1323, %NativeStructLayout** %l29
  %t1324 = load i8*, i8** %l4
  %t1325 = insertvalue %NativeStruct undef, i8* %t1324, 0
  %t1326 = load { %NativeStructField*, i64 }*, { %NativeStructField*, i64 }** %l6
  %t1327 = insertvalue %NativeStruct %t1325, { %NativeStructField*, i64 }* %t1326, 1
  %t1328 = load { %NativeFunction*, i64 }*, { %NativeFunction*, i64 }** %l7
  %t1329 = insertvalue %NativeStruct %t1327, { %NativeFunction*, i64 }* %t1328, 2
  %t1330 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t1331 = insertvalue %NativeStruct %t1329, { i8**, i64 }* %t1330, 3
  %t1332 = load %NativeStructLayout*, %NativeStructLayout** %l29
  %t1333 = insertvalue %NativeStruct %t1331, %NativeStructLayout* %t1332, 4
  %t1334 = getelementptr %NativeStruct, %NativeStruct* null, i32 1
  %t1335 = ptrtoint %NativeStruct* %t1334 to i64
  %t1336 = call noalias i8* @malloc(i64 %t1335)
  %t1337 = bitcast i8* %t1336 to %NativeStruct*
  store %NativeStruct %t1333, %NativeStruct* %t1337
  call void @sailfin_runtime_mark_persistent(i8* %t1336)
  %t1338 = insertvalue %StructParseResult undef, %NativeStruct* %t1337, 0
  %t1339 = load double, double* %l16
  %t1340 = insertvalue %StructParseResult %t1338, double %t1339, 1
  %t1341 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t1342 = insertvalue %StructParseResult %t1340, { i8**, i64 }* %t1341, 2
  ret %StructParseResult %t1342
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
  %t256 = phi { i8**, i64 }* [ %t67, %merge1 ], [ %t253, %loop.latch4 ]
  %t257 = phi double [ %t73, %merge1 ], [ %t254, %loop.latch4 ]
  %t258 = phi { %NativeInterfaceSignature*, i64 }* [ %t72, %merge1 ], [ %t255, %loop.latch4 ]
  store { i8**, i64 }* %t256, { i8**, i64 }** %l0
  store double %t257, double* %l6
  store { %NativeInterfaceSignature*, i64 }* %t258, { %NativeInterfaceSignature*, i64 }** %l5
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
  %t98 = getelementptr %NativeInterface, %NativeInterface* null, i32 1
  %t99 = ptrtoint %NativeInterface* %t98 to i64
  %t100 = call noalias i8* @malloc(i64 %t99)
  %t101 = bitcast i8* %t100 to %NativeInterface*
  store %NativeInterface %t97, %NativeInterface* %t101
  call void @sailfin_runtime_mark_persistent(i8* %t100)
  %t102 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t101, 0
  %t103 = load double, double* %l6
  %t104 = insertvalue %InterfaceParseResult %t102, double %t103, 1
  %t105 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t106 = insertvalue %InterfaceParseResult %t104, { i8**, i64 }* %t105, 2
  ret %InterfaceParseResult %t106
merge7:
  %t107 = load double, double* %l6
  %t108 = call double @llvm.round.f64(double %t107)
  %t109 = fptosi double %t108 to i64
  %t110 = load { i8**, i64 }, { i8**, i64 }* %lines
  %t111 = extractvalue { i8**, i64 } %t110, 0
  %t112 = extractvalue { i8**, i64 } %t110, 1
  %t113 = icmp uge i64 %t109, %t112
  ; bounds check: %t113 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t109, i64 %t112)
  %t114 = getelementptr i8*, i8** %t111, i64 %t109
  %t115 = load i8*, i8** %t114
  %t116 = call i8* @trim_text(i8* %t115)
  store i8* %t116, i8** %l7
  %t118 = load i8*, i8** %l7
  %t119 = call i64 @sailfin_runtime_string_length(i8* %t118)
  %t120 = icmp eq i64 %t119, 0
  br label %logical_or_entry_117

logical_or_entry_117:
  br i1 %t120, label %logical_or_merge_117, label %logical_or_right_117

logical_or_right_117:
  %t121 = load i8*, i8** %l7
  %t122 = add i64 0, 2
  %t123 = call i8* @malloc(i64 %t122)
  store i8 59, i8* %t123
  %t124 = getelementptr i8, i8* %t123, i64 1
  store i8 0, i8* %t124
  call void @sailfin_runtime_mark_persistent(i8* %t123)
  %t125 = call i1 @starts_with(i8* %t121, i8* %t123)
  br label %logical_or_right_end_117

logical_or_right_end_117:
  br label %logical_or_merge_117

logical_or_merge_117:
  %t126 = phi i1 [ true, %logical_or_entry_117 ], [ %t125, %logical_or_right_end_117 ]
  %t127 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t128 = load i8*, i8** %l1
  %t129 = load i8*, i8** %l2
  %t130 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t131 = load i8*, i8** %l4
  %t132 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t133 = load double, double* %l6
  %t134 = load i8*, i8** %l7
  br i1 %t126, label %then8, label %merge9
then8:
  %t135 = load double, double* %l6
  %t136 = sitofp i64 1 to double
  %t137 = fadd double %t135, %t136
  store double %t137, double* %l6
  br label %loop.latch4
merge9:
  %t138 = load i8*, i8** %l7
  %s139 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h1382830532, i32 0, i32 0
  %t140 = call i1 @strings_equal(i8* %t138, i8* %s139)
  %t141 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t142 = load i8*, i8** %l1
  %t143 = load i8*, i8** %l2
  %t144 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t145 = load i8*, i8** %l4
  %t146 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t147 = load double, double* %l6
  %t148 = load i8*, i8** %l7
  br i1 %t140, label %then10, label %merge11
then10:
  %t149 = load double, double* %l6
  %t150 = sitofp i64 1 to double
  %t151 = fadd double %t149, %t150
  store double %t151, double* %l6
  br label %afterloop5
merge11:
  %t152 = load i8*, i8** %l7
  %s153 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t154 = call i1 @strings_equal(i8* %t152, i8* %s153)
  %t155 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t156 = load i8*, i8** %l1
  %t157 = load i8*, i8** %l2
  %t158 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t159 = load i8*, i8** %l4
  %t160 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t161 = load double, double* %l6
  %t162 = load i8*, i8** %l7
  br i1 %t154, label %then12, label %merge13
then12:
  %t163 = load double, double* %l6
  %t164 = sitofp i64 1 to double
  %t165 = fadd double %t163, %t164
  store double %t165, double* %l6
  br label %loop.latch4
merge13:
  %t166 = load i8*, i8** %l7
  %s167 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t168 = call i1 @starts_with(i8* %t166, i8* %s167)
  %t169 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t170 = load i8*, i8** %l1
  %t171 = load i8*, i8** %l2
  %t172 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t173 = load i8*, i8** %l4
  %t174 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t175 = load double, double* %l6
  %t176 = load i8*, i8** %l7
  br i1 %t168, label %then14, label %merge15
then14:
  %t177 = load i8*, i8** %l7
  %s178 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072555103, i32 0, i32 0
  %t179 = call i8* @strip_prefix(i8* %t177, i8* %s178)
  %t180 = load i8*, i8** %l4
  %t181 = call %InterfaceSignatureParse @parse_interface_signature(i8* %t179, i8* %t180)
  store %InterfaceSignatureParse %t181, %InterfaceSignatureParse* %l8
  %t182 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t183 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t184 = extractvalue %InterfaceSignatureParse %t183, 2
  %t185 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t182, { i8**, i64 }* %t184)
  store { i8**, i64 }* %t185, { i8**, i64 }** %l0
  %t186 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t187 = extractvalue %InterfaceSignatureParse %t186, 0
  %t188 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t189 = load i8*, i8** %l1
  %t190 = load i8*, i8** %l2
  %t191 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t192 = load i8*, i8** %l4
  %t193 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t194 = load double, double* %l6
  %t195 = load i8*, i8** %l7
  %t196 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  br i1 %t187, label %then16, label %merge17
then16:
  %t197 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t198 = load %InterfaceSignatureParse, %InterfaceSignatureParse* %l8
  %t199 = extractvalue %InterfaceSignatureParse %t198, 1
  %t200 = getelementptr [1 x %NativeInterfaceSignature], [1 x %NativeInterfaceSignature]* null, i32 1
  %t201 = ptrtoint [1 x %NativeInterfaceSignature]* %t200 to i64
  %t202 = icmp eq i64 %t201, 0
  %t203 = select i1 %t202, i64 1, i64 %t201
  %t204 = call i8* @malloc(i64 %t203)
  %t205 = bitcast i8* %t204 to %NativeInterfaceSignature*
  %t206 = getelementptr %NativeInterfaceSignature, %NativeInterfaceSignature* %t205, i64 0
  store %NativeInterfaceSignature %t199, %NativeInterfaceSignature* %t206
  %t207 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* null, i32 1
  %t208 = ptrtoint { %NativeInterfaceSignature*, i64 }* %t207 to i64
  %t209 = call i8* @malloc(i64 %t208)
  %t210 = bitcast i8* %t209 to { %NativeInterfaceSignature*, i64 }*
  %t211 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t210, i32 0, i32 0
  store %NativeInterfaceSignature* %t205, %NativeInterfaceSignature** %t211
  %t212 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t210, i32 0, i32 1
  store i64 1, i64* %t212
  %t213 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t197, i32 0, i32 0
  %t214 = load %NativeInterfaceSignature*, %NativeInterfaceSignature** %t213
  %t215 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t197, i32 0, i32 1
  %t216 = load i64, i64* %t215
  %t217 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t210, i32 0, i32 0
  %t218 = load %NativeInterfaceSignature*, %NativeInterfaceSignature** %t217
  %t219 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t210, i32 0, i32 1
  %t220 = load i64, i64* %t219
  %t221 = getelementptr [1 x %NativeInterfaceSignature], [1 x %NativeInterfaceSignature]* null, i32 0, i32 1
  %t222 = ptrtoint %NativeInterfaceSignature* %t221 to i64
  %t223 = add i64 %t216, %t220
  %t224 = mul i64 %t222, %t223
  %t225 = call noalias i8* @malloc(i64 %t224)
  %t226 = bitcast i8* %t225 to %NativeInterfaceSignature*
  %t227 = bitcast %NativeInterfaceSignature* %t226 to i8*
  %t228 = mul i64 %t222, %t216
  %t229 = bitcast %NativeInterfaceSignature* %t214 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t227, i8* %t229, i64 %t228)
  %t230 = mul i64 %t222, %t220
  %t231 = bitcast %NativeInterfaceSignature* %t218 to i8*
  %t232 = getelementptr %NativeInterfaceSignature, %NativeInterfaceSignature* %t226, i64 %t216
  %t233 = bitcast %NativeInterfaceSignature* %t232 to i8*
  call void @sailfin_runtime_copy_bytes(i8* %t233, i8* %t231, i64 %t230)
  %t234 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* null, i32 1
  %t235 = ptrtoint { %NativeInterfaceSignature*, i64 }* %t234 to i64
  %t236 = call i8* @malloc(i64 %t235)
  %t237 = bitcast i8* %t236 to { %NativeInterfaceSignature*, i64 }*
  %t238 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t237, i32 0, i32 0
  store %NativeInterfaceSignature* %t226, %NativeInterfaceSignature** %t238
  %t239 = getelementptr { %NativeInterfaceSignature*, i64 }, { %NativeInterfaceSignature*, i64 }* %t237, i32 0, i32 1
  store i64 %t223, i64* %t239
  store { %NativeInterfaceSignature*, i64 }* %t237, { %NativeInterfaceSignature*, i64 }** %l5
  %t240 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %merge17
merge17:
  %t241 = phi { %NativeInterfaceSignature*, i64 }* [ %t240, %then16 ], [ %t193, %then14 ]
  store { %NativeInterfaceSignature*, i64 }* %t241, { %NativeInterfaceSignature*, i64 }** %l5
  %t242 = load double, double* %l6
  %t243 = sitofp i64 1 to double
  %t244 = fadd double %t242, %t243
  store double %t244, double* %l6
  br label %loop.latch4
merge15:
  %t245 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s246 = getelementptr inbounds [34 x i8], [34 x i8]* @.str.len33.h1134984829, i32 0, i32 0
  %t247 = load i8*, i8** %l7
  %t248 = call i8* @sailfin_runtime_string_concat(i8* %s246, i8* %t247)
  %t249 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t245, i8* %t248)
  store { i8**, i64 }* %t249, { i8**, i64 }** %l0
  %t250 = load double, double* %l6
  %t251 = sitofp i64 1 to double
  %t252 = fadd double %t250, %t251
  store double %t252, double* %l6
  br label %loop.latch4
loop.latch4:
  %t253 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t254 = load double, double* %l6
  %t255 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  br label %loop.header2
afterloop5:
  %t259 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t260 = load double, double* %l6
  %t261 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t262 = load i8*, i8** %l4
  %t263 = insertvalue %NativeInterface undef, i8* %t262, 0
  %t264 = load %InterfaceHeaderParse, %InterfaceHeaderParse* %l3
  %t265 = extractvalue %InterfaceHeaderParse %t264, 1
  %t266 = insertvalue %NativeInterface %t263, { i8**, i64 }* %t265, 1
  %t267 = load { %NativeInterfaceSignature*, i64 }*, { %NativeInterfaceSignature*, i64 }** %l5
  %t268 = insertvalue %NativeInterface %t266, { %NativeInterfaceSignature*, i64 }* %t267, 2
  %t269 = getelementptr %NativeInterface, %NativeInterface* null, i32 1
  %t270 = ptrtoint %NativeInterface* %t269 to i64
  %t271 = call noalias i8* @malloc(i64 %t270)
  %t272 = bitcast i8* %t271 to %NativeInterface*
  store %NativeInterface %t268, %NativeInterface* %t272
  call void @sailfin_runtime_mark_persistent(i8* %t271)
  %t273 = insertvalue %InterfaceParseResult undef, %NativeInterface* %t272, 0
  %t274 = load double, double* %l6
  %t275 = insertvalue %InterfaceParseResult %t273, double %t274, 1
  %t276 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t277 = insertvalue %InterfaceParseResult %t275, { i8**, i64 }* %t276, 2
  ret %InterfaceParseResult %t277
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
  %t150 = call i8* @trim_text(i8* %t149)
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
  %t239 = call i8* @trim_text(i8* %t238)
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
  %t396 = call i8* @trim_text(i8* %t395)
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
  %t448 = call i8* @trim_text(i8* %t447)
  store i8* %t448, i8** %l20
  %t449 = load i8*, i8** %l18
  %t450 = load double, double* %l19
  %t451 = call double @llvm.round.f64(double %t450)
  %t452 = fptosi double %t451 to i64
  %t453 = call i8* @sailfin_runtime_substring(i8* %t449, i64 0, i64 %t452)
  %t454 = call i8* @trim_text(i8* %t453)
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
  %t504 = call i8* @trim_text(i8* %t503)
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
  %t99 = call i8* @trim_text(i8* %t98)
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
  %t121 = call i8* @trim_text(i8* %t120)
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
  %t147 = call i8* @trim_text(i8* %t146)
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
  %t157 = call i8* @trim_text(i8* %t156)
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
  %t433 = call i8* @trim_text(i8* %t432)
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
  %t496 = call i8* @trim_text(i8* %t495)
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
  %t44 = call i8* @trim_text(i8* %t43)
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
  %t823 = phi { i8**, i64 }* [ %t100, %merge3 ], [ %t812, %loop.latch6 ]
  %t824 = phi double [ %t114, %merge3 ], [ %t813, %loop.latch6 ]
  %t825 = phi double [ %t107, %merge3 ], [ %t814, %loop.latch6 ]
  %t826 = phi double [ %t108, %merge3 ], [ %t815, %loop.latch6 ]
  %t827 = phi i8* [ %t109, %merge3 ], [ %t816, %loop.latch6 ]
  %t828 = phi double [ %t110, %merge3 ], [ %t817, %loop.latch6 ]
  %t829 = phi double [ %t111, %merge3 ], [ %t818, %loop.latch6 ]
  %t830 = phi i1 [ %t112, %merge3 ], [ %t819, %loop.latch6 ]
  %t831 = phi { %NativeEnumVariantLayout*, i64 }* [ %t106, %merge3 ], [ %t820, %loop.latch6 ]
  %t832 = phi i1 [ %t113, %merge3 ], [ %t821, %loop.latch6 ]
  %t833 = phi { %NativeEnumVariant*, i64 }* [ %t105, %merge3 ], [ %t822, %loop.latch6 ]
  store { i8**, i64 }* %t823, { i8**, i64 }** %l0
  store double %t824, double* %l14
  store double %t825, double* %l7
  store double %t826, double* %l8
  store i8* %t827, i8** %l9
  store double %t828, double* %l10
  store double %t829, double* %l11
  store i1 %t830, i1* %l12
  store { %NativeEnumVariantLayout*, i64 }* %t831, { %NativeEnumVariantLayout*, i64 }** %l6
  store i1 %t832, i1* %l13
  store { %NativeEnumVariant*, i64 }* %t833, { %NativeEnumVariant*, i64 }** %l5
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
  %t170 = getelementptr %NativeEnumLayout, %NativeEnumLayout* null, i32 1
  %t171 = ptrtoint %NativeEnumLayout* %t170 to i64
  %t172 = call noalias i8* @malloc(i64 %t171)
  %t173 = bitcast i8* %t172 to %NativeEnumLayout*
  store %NativeEnumLayout %t169, %NativeEnumLayout* %t173
  call void @sailfin_runtime_mark_persistent(i8* %t172)
  store %NativeEnumLayout* %t173, %NativeEnumLayout** %l15
  %t174 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  br label %merge11
merge11:
  %t175 = phi %NativeEnumLayout* [ %t174, %then10 ], [ %t157, %then8 ]
  store %NativeEnumLayout* %t175, %NativeEnumLayout** %l15
  %t176 = load i8*, i8** %l3
  %t177 = insertvalue %NativeEnum undef, i8* %t176, 0
  %t178 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t179 = insertvalue %NativeEnum %t177, { %NativeEnumVariant*, i64 }* %t178, 1
  %t180 = load %NativeEnumLayout*, %NativeEnumLayout** %l15
  %t181 = insertvalue %NativeEnum %t179, %NativeEnumLayout* %t180, 2
  %t182 = getelementptr %NativeEnum, %NativeEnum* null, i32 1
  %t183 = ptrtoint %NativeEnum* %t182 to i64
  %t184 = call noalias i8* @malloc(i64 %t183)
  %t185 = bitcast i8* %t184 to %NativeEnum*
  store %NativeEnum %t181, %NativeEnum* %t185
  call void @sailfin_runtime_mark_persistent(i8* %t184)
  %t186 = insertvalue %EnumParseResult undef, %NativeEnum* %t185, 0
  %t187 = load double, double* %l14
  %t188 = insertvalue %EnumParseResult %t186, double %t187, 1
  %t189 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t190 = insertvalue %EnumParseResult %t188, { i8**, i64 }* %t189, 2
  ret %EnumParseResult %t190
merge9:
  %t191 = load double, double* %l14
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
  store i8* %t200, i8** %l16
  %t202 = load i8*, i8** %l16
  %t203 = call i64 @sailfin_runtime_string_length(i8* %t202)
  %t204 = icmp eq i64 %t203, 0
  br label %logical_or_entry_201

logical_or_entry_201:
  br i1 %t204, label %logical_or_merge_201, label %logical_or_right_201

logical_or_right_201:
  %t205 = load i8*, i8** %l16
  %t206 = add i64 0, 2
  %t207 = call i8* @malloc(i64 %t206)
  store i8 59, i8* %t207
  %t208 = getelementptr i8, i8* %t207, i64 1
  store i8 0, i8* %t208
  call void @sailfin_runtime_mark_persistent(i8* %t207)
  %t209 = call i1 @starts_with(i8* %t205, i8* %t207)
  br label %logical_or_right_end_201

logical_or_right_end_201:
  br label %logical_or_merge_201

logical_or_merge_201:
  %t210 = phi i1 [ true, %logical_or_entry_201 ], [ %t209, %logical_or_right_end_201 ]
  %t211 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t212 = load i8*, i8** %l1
  %t213 = load i8*, i8** %l2
  %t214 = load i8*, i8** %l3
  %t215 = load double, double* %l4
  %t216 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t217 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t218 = load double, double* %l7
  %t219 = load double, double* %l8
  %t220 = load i8*, i8** %l9
  %t221 = load double, double* %l10
  %t222 = load double, double* %l11
  %t223 = load i1, i1* %l12
  %t224 = load i1, i1* %l13
  %t225 = load double, double* %l14
  %t226 = load i8*, i8** %l16
  br i1 %t210, label %then12, label %merge13
then12:
  %t227 = load double, double* %l14
  %t228 = sitofp i64 1 to double
  %t229 = fadd double %t227, %t228
  store double %t229, double* %l14
  br label %loop.latch6
merge13:
  %t230 = load i8*, i8** %l16
  %s231 = getelementptr inbounds [5 x i8], [5 x i8]* @.str.len4.h268717223, i32 0, i32 0
  %t232 = call i1 @strings_equal(i8* %t230, i8* %s231)
  %t233 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t234 = load i8*, i8** %l1
  %t235 = load i8*, i8** %l2
  %t236 = load i8*, i8** %l3
  %t237 = load double, double* %l4
  %t238 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t239 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t240 = load double, double* %l7
  %t241 = load double, double* %l8
  %t242 = load i8*, i8** %l9
  %t243 = load double, double* %l10
  %t244 = load double, double* %l11
  %t245 = load i1, i1* %l12
  %t246 = load i1, i1* %l13
  %t247 = load double, double* %l14
  %t248 = load i8*, i8** %l16
  br i1 %t232, label %then14, label %merge15
then14:
  %t249 = load double, double* %l14
  %t250 = sitofp i64 1 to double
  %t251 = fadd double %t249, %t250
  store double %t251, double* %l14
  br label %loop.latch6
merge15:
  %t252 = load i8*, i8** %l16
  %s253 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t254 = call i1 @starts_with(i8* %t252, i8* %s253)
  %t255 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t256 = load i8*, i8** %l1
  %t257 = load i8*, i8** %l2
  %t258 = load i8*, i8** %l3
  %t259 = load double, double* %l4
  %t260 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t261 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t262 = load double, double* %l7
  %t263 = load double, double* %l8
  %t264 = load i8*, i8** %l9
  %t265 = load double, double* %l10
  %t266 = load double, double* %l11
  %t267 = load i1, i1* %l12
  %t268 = load i1, i1* %l13
  %t269 = load double, double* %l14
  %t270 = load i8*, i8** %l16
  br i1 %t254, label %then16, label %merge17
then16:
  %t271 = load i8*, i8** %l16
  %s272 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t273 = call i8* @strip_prefix(i8* %t271, i8* %s272)
  store i8* %t273, i8** %l17
  %t274 = load i8*, i8** %l17
  %s275 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t276 = call i1 @starts_with(i8* %t274, i8* %s275)
  %t277 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t278 = load i8*, i8** %l1
  %t279 = load i8*, i8** %l2
  %t280 = load i8*, i8** %l3
  %t281 = load double, double* %l4
  %t282 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t283 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t284 = load double, double* %l7
  %t285 = load double, double* %l8
  %t286 = load i8*, i8** %l9
  %t287 = load double, double* %l10
  %t288 = load double, double* %l11
  %t289 = load i1, i1* %l12
  %t290 = load i1, i1* %l13
  %t291 = load double, double* %l14
  %t292 = load i8*, i8** %l16
  %t293 = load i8*, i8** %l17
  br i1 %t276, label %then18, label %merge19
then18:
  %t294 = load i8*, i8** %l17
  %s295 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t296 = call i8* @strip_prefix(i8* %t294, i8* %s295)
  %t297 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t296)
  store %EnumLayoutHeaderParse %t297, %EnumLayoutHeaderParse* %l18
  %t298 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t299 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t300 = extractvalue %EnumLayoutHeaderParse %t299, 7
  %t301 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t298, { i8**, i64 }* %t300)
  store { i8**, i64 }* %t301, { i8**, i64 }** %l0
  %t302 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t303 = extractvalue %EnumLayoutHeaderParse %t302, 0
  %t304 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t305 = load i8*, i8** %l1
  %t306 = load i8*, i8** %l2
  %t307 = load i8*, i8** %l3
  %t308 = load double, double* %l4
  %t309 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t310 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t311 = load double, double* %l7
  %t312 = load double, double* %l8
  %t313 = load i8*, i8** %l9
  %t314 = load double, double* %l10
  %t315 = load double, double* %l11
  %t316 = load i1, i1* %l12
  %t317 = load i1, i1* %l13
  %t318 = load double, double* %l14
  %t319 = load i8*, i8** %l16
  %t320 = load i8*, i8** %l17
  %t321 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t303, label %then20, label %merge21
then20:
  %t322 = load i1, i1* %l12
  %t323 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t324 = load i8*, i8** %l1
  %t325 = load i8*, i8** %l2
  %t326 = load i8*, i8** %l3
  %t327 = load double, double* %l4
  %t328 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t329 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t330 = load double, double* %l7
  %t331 = load double, double* %l8
  %t332 = load i8*, i8** %l9
  %t333 = load double, double* %l10
  %t334 = load double, double* %l11
  %t335 = load i1, i1* %l12
  %t336 = load i1, i1* %l13
  %t337 = load double, double* %l14
  %t338 = load i8*, i8** %l16
  %t339 = load i8*, i8** %l17
  %t340 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  br i1 %t322, label %then22, label %else23
then22:
  %t341 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s342 = getelementptr inbounds [33 x i8], [33 x i8]* @.str.len32.h1822658020, i32 0, i32 0
  %t343 = load i8*, i8** %l3
  %t344 = call i8* @sailfin_runtime_string_concat(i8* %s342, i8* %t343)
  %t345 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t341, i8* %t344)
  store { i8**, i64 }* %t345, { i8**, i64 }** %l0
  %t346 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge24
else23:
  %t347 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t348 = extractvalue %EnumLayoutHeaderParse %t347, 2
  store double %t348, double* %l7
  %t349 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t350 = extractvalue %EnumLayoutHeaderParse %t349, 3
  store double %t350, double* %l8
  %t351 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t352 = extractvalue %EnumLayoutHeaderParse %t351, 4
  store i8* %t352, i8** %l9
  %t353 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t354 = extractvalue %EnumLayoutHeaderParse %t353, 5
  store double %t354, double* %l10
  %t355 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l18
  %t356 = extractvalue %EnumLayoutHeaderParse %t355, 6
  store double %t356, double* %l11
  store i1 1, i1* %l12
  %t357 = load double, double* %l7
  %t358 = load double, double* %l8
  %t359 = load i8*, i8** %l9
  %t360 = load double, double* %l10
  %t361 = load double, double* %l11
  %t362 = load i1, i1* %l12
  br label %merge24
merge24:
  %t363 = phi { i8**, i64 }* [ %t346, %then22 ], [ %t323, %else23 ]
  %t364 = phi double [ %t330, %then22 ], [ %t357, %else23 ]
  %t365 = phi double [ %t331, %then22 ], [ %t358, %else23 ]
  %t366 = phi i8* [ %t332, %then22 ], [ %t359, %else23 ]
  %t367 = phi double [ %t333, %then22 ], [ %t360, %else23 ]
  %t368 = phi double [ %t334, %then22 ], [ %t361, %else23 ]
  %t369 = phi i1 [ %t335, %then22 ], [ %t362, %else23 ]
  store { i8**, i64 }* %t363, { i8**, i64 }** %l0
  store double %t364, double* %l7
  store double %t365, double* %l8
  store i8* %t366, i8** %l9
  store double %t367, double* %l10
  store double %t368, double* %l11
  store i1 %t369, i1* %l12
  %t370 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t371 = load double, double* %l7
  %t372 = load double, double* %l8
  %t373 = load i8*, i8** %l9
  %t374 = load double, double* %l10
  %t375 = load double, double* %l11
  %t376 = load i1, i1* %l12
  br label %merge21
merge21:
  %t377 = phi { i8**, i64 }* [ %t370, %merge24 ], [ %t304, %then18 ]
  %t378 = phi double [ %t371, %merge24 ], [ %t311, %then18 ]
  %t379 = phi double [ %t372, %merge24 ], [ %t312, %then18 ]
  %t380 = phi i8* [ %t373, %merge24 ], [ %t313, %then18 ]
  %t381 = phi double [ %t374, %merge24 ], [ %t314, %then18 ]
  %t382 = phi double [ %t375, %merge24 ], [ %t315, %then18 ]
  %t383 = phi i1 [ %t376, %merge24 ], [ %t316, %then18 ]
  store { i8**, i64 }* %t377, { i8**, i64 }** %l0
  store double %t378, double* %l7
  store double %t379, double* %l8
  store i8* %t380, i8** %l9
  store double %t381, double* %l10
  store double %t382, double* %l11
  store i1 %t383, i1* %l12
  %t384 = load double, double* %l14
  %t385 = sitofp i64 1 to double
  %t386 = fadd double %t384, %t385
  store double %t386, double* %l14
  br label %loop.latch6
merge19:
  %t387 = load i8*, i8** %l17
  %s388 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t389 = call i1 @starts_with(i8* %t387, i8* %s388)
  %t390 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t391 = load i8*, i8** %l1
  %t392 = load i8*, i8** %l2
  %t393 = load i8*, i8** %l3
  %t394 = load double, double* %l4
  %t395 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t396 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t397 = load double, double* %l7
  %t398 = load double, double* %l8
  %t399 = load i8*, i8** %l9
  %t400 = load double, double* %l10
  %t401 = load double, double* %l11
  %t402 = load i1, i1* %l12
  %t403 = load i1, i1* %l13
  %t404 = load double, double* %l14
  %t405 = load i8*, i8** %l16
  %t406 = load i8*, i8** %l17
  br i1 %t389, label %then25, label %merge26
then25:
  %t407 = load i8*, i8** %l17
  %s408 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t409 = call i8* @strip_prefix(i8* %t407, i8* %s408)
  %t410 = load i8*, i8** %l3
  %t411 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t409, i8* %t410)
  store %EnumLayoutVariantParse %t411, %EnumLayoutVariantParse* %l19
  %t412 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t413 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t414 = extractvalue %EnumLayoutVariantParse %t413, 2
  %t415 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t412, { i8**, i64 }* %t414)
  store { i8**, i64 }* %t415, { i8**, i64 }** %l0
  %t416 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t417 = extractvalue %EnumLayoutVariantParse %t416, 0
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t419 = load i8*, i8** %l1
  %t420 = load i8*, i8** %l2
  %t421 = load i8*, i8** %l3
  %t422 = load double, double* %l4
  %t423 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t424 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t425 = load double, double* %l7
  %t426 = load double, double* %l8
  %t427 = load i8*, i8** %l9
  %t428 = load double, double* %l10
  %t429 = load double, double* %l11
  %t430 = load i1, i1* %l12
  %t431 = load i1, i1* %l13
  %t432 = load double, double* %l14
  %t433 = load i8*, i8** %l16
  %t434 = load i8*, i8** %l17
  %t435 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  br i1 %t417, label %then27, label %merge28
then27:
  %t436 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t437 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t438 = extractvalue %EnumLayoutVariantParse %t437, 1
  %t439 = extractvalue %NativeEnumVariantLayout %t438, 0
  %t440 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t436, i8* %t439)
  store double %t440, double* %l20
  %t441 = load double, double* %l20
  %t442 = sitofp i64 0 to double
  %t443 = fcmp oge double %t441, %t442
  %t444 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t445 = load i8*, i8** %l1
  %t446 = load i8*, i8** %l2
  %t447 = load i8*, i8** %l3
  %t448 = load double, double* %l4
  %t449 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t450 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t451 = load double, double* %l7
  %t452 = load double, double* %l8
  %t453 = load i8*, i8** %l9
  %t454 = load double, double* %l10
  %t455 = load double, double* %l11
  %t456 = load i1, i1* %l12
  %t457 = load i1, i1* %l13
  %t458 = load double, double* %l14
  %t459 = load i8*, i8** %l16
  %t460 = load i8*, i8** %l17
  %t461 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t462 = load double, double* %l20
  br i1 %t443, label %then29, label %else30
then29:
  %t463 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s464 = getelementptr inbounds [32 x i8], [32 x i8]* @.str.len31.h1924917952, i32 0, i32 0
  %t465 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t466 = extractvalue %EnumLayoutVariantParse %t465, 1
  %t467 = extractvalue %NativeEnumVariantLayout %t466, 0
  %t468 = call i8* @sailfin_runtime_string_concat(i8* %s464, i8* %t467)
  %s469 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h1783417286, i32 0, i32 0
  %t470 = call i8* @sailfin_runtime_string_concat(i8* %t468, i8* %s469)
  %t471 = load i8*, i8** %l3
  %t472 = call i8* @sailfin_runtime_string_concat(i8* %t470, i8* %t471)
  %t473 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t463, i8* %t472)
  store { i8**, i64 }* %t473, { i8**, i64 }** %l0
  %t474 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge31
else30:
  %t475 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t476 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t477 = extractvalue %EnumLayoutVariantParse %t476, 1
  %t478 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t475, %NativeEnumVariantLayout %t477)
  store { %NativeEnumVariantLayout*, i64 }* %t478, { %NativeEnumVariantLayout*, i64 }** %l6
  %t479 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge31
merge31:
  %t480 = phi { i8**, i64 }* [ %t474, %then29 ], [ %t444, %else30 ]
  %t481 = phi { %NativeEnumVariantLayout*, i64 }* [ %t450, %then29 ], [ %t479, %else30 ]
  store { i8**, i64 }* %t480, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t481, { %NativeEnumVariantLayout*, i64 }** %l6
  %t482 = load i1, i1* %l12
  %t483 = xor i1 %t482, 1
  %t484 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t485 = load i8*, i8** %l1
  %t486 = load i8*, i8** %l2
  %t487 = load i8*, i8** %l3
  %t488 = load double, double* %l4
  %t489 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t490 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t491 = load double, double* %l7
  %t492 = load double, double* %l8
  %t493 = load i8*, i8** %l9
  %t494 = load double, double* %l10
  %t495 = load double, double* %l11
  %t496 = load i1, i1* %l12
  %t497 = load i1, i1* %l13
  %t498 = load double, double* %l14
  %t499 = load i8*, i8** %l16
  %t500 = load i8*, i8** %l17
  %t501 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t502 = load double, double* %l20
  br i1 %t483, label %then32, label %merge33
then32:
  %t503 = load i1, i1* %l13
  %t504 = xor i1 %t503, 1
  %t505 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t506 = load i8*, i8** %l1
  %t507 = load i8*, i8** %l2
  %t508 = load i8*, i8** %l3
  %t509 = load double, double* %l4
  %t510 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t511 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t512 = load double, double* %l7
  %t513 = load double, double* %l8
  %t514 = load i8*, i8** %l9
  %t515 = load double, double* %l10
  %t516 = load double, double* %l11
  %t517 = load i1, i1* %l12
  %t518 = load i1, i1* %l13
  %t519 = load double, double* %l14
  %t520 = load i8*, i8** %l16
  %t521 = load i8*, i8** %l17
  %t522 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l19
  %t523 = load double, double* %l20
  br i1 %t504, label %then34, label %merge35
then34:
  %t524 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s525 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t526 = load i8*, i8** %l3
  %t527 = call i8* @sailfin_runtime_string_concat(i8* %s525, i8* %t526)
  %s528 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h235936117, i32 0, i32 0
  %t529 = call i8* @sailfin_runtime_string_concat(i8* %t527, i8* %s528)
  %t530 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t524, i8* %t529)
  store { i8**, i64 }* %t530, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t531 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t532 = load i1, i1* %l13
  br label %merge35
merge35:
  %t533 = phi { i8**, i64 }* [ %t531, %then34 ], [ %t505, %then32 ]
  %t534 = phi i1 [ %t532, %then34 ], [ %t518, %then32 ]
  store { i8**, i64 }* %t533, { i8**, i64 }** %l0
  store i1 %t534, i1* %l13
  %t535 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t536 = load i1, i1* %l13
  br label %merge33
merge33:
  %t537 = phi { i8**, i64 }* [ %t535, %merge35 ], [ %t484, %merge31 ]
  %t538 = phi i1 [ %t536, %merge35 ], [ %t497, %merge31 ]
  store { i8**, i64 }* %t537, { i8**, i64 }** %l0
  store i1 %t538, i1* %l13
  %t539 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t540 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t541 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t542 = load i1, i1* %l13
  br label %merge28
merge28:
  %t543 = phi { i8**, i64 }* [ %t539, %merge33 ], [ %t418, %then25 ]
  %t544 = phi { %NativeEnumVariantLayout*, i64 }* [ %t540, %merge33 ], [ %t424, %then25 ]
  %t545 = phi { i8**, i64 }* [ %t541, %merge33 ], [ %t418, %then25 ]
  %t546 = phi i1 [ %t542, %merge33 ], [ %t431, %then25 ]
  store { i8**, i64 }* %t543, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t544, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t545, { i8**, i64 }** %l0
  store i1 %t546, i1* %l13
  %t547 = load double, double* %l14
  %t548 = sitofp i64 1 to double
  %t549 = fadd double %t547, %t548
  store double %t549, double* %l14
  br label %loop.latch6
merge26:
  %t550 = load i8*, i8** %l17
  %s551 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t552 = call i1 @starts_with(i8* %t550, i8* %s551)
  %t553 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t554 = load i8*, i8** %l1
  %t555 = load i8*, i8** %l2
  %t556 = load i8*, i8** %l3
  %t557 = load double, double* %l4
  %t558 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t559 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t560 = load double, double* %l7
  %t561 = load double, double* %l8
  %t562 = load i8*, i8** %l9
  %t563 = load double, double* %l10
  %t564 = load double, double* %l11
  %t565 = load i1, i1* %l12
  %t566 = load i1, i1* %l13
  %t567 = load double, double* %l14
  %t568 = load i8*, i8** %l16
  %t569 = load i8*, i8** %l17
  br i1 %t552, label %then36, label %merge37
then36:
  %t570 = load i8*, i8** %l17
  %s571 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t572 = call i8* @strip_prefix(i8* %t570, i8* %s571)
  %t573 = load i8*, i8** %l3
  %t574 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t572, i8* %t573)
  store %EnumLayoutPayloadParse %t574, %EnumLayoutPayloadParse* %l21
  %t575 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t576 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t577 = extractvalue %EnumLayoutPayloadParse %t576, 3
  %t578 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t575, { i8**, i64 }* %t577)
  store { i8**, i64 }* %t578, { i8**, i64 }** %l0
  %t579 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t580 = extractvalue %EnumLayoutPayloadParse %t579, 0
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t582 = load i8*, i8** %l1
  %t583 = load i8*, i8** %l2
  %t584 = load i8*, i8** %l3
  %t585 = load double, double* %l4
  %t586 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t587 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t588 = load double, double* %l7
  %t589 = load double, double* %l8
  %t590 = load i8*, i8** %l9
  %t591 = load double, double* %l10
  %t592 = load double, double* %l11
  %t593 = load i1, i1* %l12
  %t594 = load i1, i1* %l13
  %t595 = load double, double* %l14
  %t596 = load i8*, i8** %l16
  %t597 = load i8*, i8** %l17
  %t598 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  br i1 %t580, label %then38, label %merge39
then38:
  %t599 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t600 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t601 = extractvalue %EnumLayoutPayloadParse %t600, 1
  %t602 = call double @find_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t599, i8* %t601)
  store double %t602, double* %l22
  %t603 = load double, double* %l22
  %t604 = sitofp i64 0 to double
  %t605 = fcmp olt double %t603, %t604
  %t606 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t607 = load i8*, i8** %l1
  %t608 = load i8*, i8** %l2
  %t609 = load i8*, i8** %l3
  %t610 = load double, double* %l4
  %t611 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t612 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t613 = load double, double* %l7
  %t614 = load double, double* %l8
  %t615 = load i8*, i8** %l9
  %t616 = load double, double* %l10
  %t617 = load double, double* %l11
  %t618 = load i1, i1* %l12
  %t619 = load i1, i1* %l13
  %t620 = load double, double* %l14
  %t621 = load i8*, i8** %l16
  %t622 = load i8*, i8** %l17
  %t623 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t624 = load double, double* %l22
  br i1 %t605, label %then40, label %else41
then40:
  %t625 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s626 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t627 = load i8*, i8** %l3
  %t628 = call i8* @sailfin_runtime_string_concat(i8* %s626, i8* %t627)
  %s629 = getelementptr inbounds [45 x i8], [45 x i8]* @.str.len44.h1623843, i32 0, i32 0
  %t630 = call i8* @sailfin_runtime_string_concat(i8* %t628, i8* %s629)
  %t631 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t632 = extractvalue %EnumLayoutPayloadParse %t631, 1
  %t633 = call i8* @sailfin_runtime_string_concat(i8* %t630, i8* %t632)
  %t634 = add i64 0, 2
  %t635 = call i8* @malloc(i64 %t634)
  store i8 96, i8* %t635
  %t636 = getelementptr i8, i8* %t635, i64 1
  store i8 0, i8* %t636
  call void @sailfin_runtime_mark_persistent(i8* %t635)
  %t637 = call i8* @sailfin_runtime_string_concat(i8* %t633, i8* %t635)
  %t638 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t625, i8* %t637)
  store { i8**, i64 }* %t638, { i8**, i64 }** %l0
  %t639 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge42
else41:
  %t640 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t641 = load double, double* %l22
  %t642 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t643 = extractvalue %EnumLayoutPayloadParse %t642, 2
  %t644 = call { %NativeEnumVariantLayout*, i64 }* @update_enum_variant_fields({ %NativeEnumVariantLayout*, i64 }* %t640, double %t641, %NativeStructLayoutField %t643)
  store { %NativeEnumVariantLayout*, i64 }* %t644, { %NativeEnumVariantLayout*, i64 }** %l6
  %t645 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  br label %merge42
merge42:
  %t646 = phi { i8**, i64 }* [ %t639, %then40 ], [ %t606, %else41 ]
  %t647 = phi { %NativeEnumVariantLayout*, i64 }* [ %t612, %then40 ], [ %t645, %else41 ]
  store { i8**, i64 }* %t646, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t647, { %NativeEnumVariantLayout*, i64 }** %l6
  %t648 = load i1, i1* %l12
  %t649 = xor i1 %t648, 1
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t651 = load i8*, i8** %l1
  %t652 = load i8*, i8** %l2
  %t653 = load i8*, i8** %l3
  %t654 = load double, double* %l4
  %t655 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t656 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t657 = load double, double* %l7
  %t658 = load double, double* %l8
  %t659 = load i8*, i8** %l9
  %t660 = load double, double* %l10
  %t661 = load double, double* %l11
  %t662 = load i1, i1* %l12
  %t663 = load i1, i1* %l13
  %t664 = load double, double* %l14
  %t665 = load i8*, i8** %l16
  %t666 = load i8*, i8** %l17
  %t667 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t668 = load double, double* %l22
  br i1 %t649, label %then43, label %merge44
then43:
  %t669 = load i1, i1* %l13
  %t670 = xor i1 %t669, 1
  %t671 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t672 = load i8*, i8** %l1
  %t673 = load i8*, i8** %l2
  %t674 = load i8*, i8** %l3
  %t675 = load double, double* %l4
  %t676 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t677 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t678 = load double, double* %l7
  %t679 = load double, double* %l8
  %t680 = load i8*, i8** %l9
  %t681 = load double, double* %l10
  %t682 = load double, double* %l11
  %t683 = load i1, i1* %l12
  %t684 = load i1, i1* %l13
  %t685 = load double, double* %l14
  %t686 = load i8*, i8** %l16
  %t687 = load i8*, i8** %l17
  %t688 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l21
  %t689 = load double, double* %l22
  br i1 %t670, label %then45, label %merge46
then45:
  %t690 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s691 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t692 = load i8*, i8** %l3
  %t693 = call i8* @sailfin_runtime_string_concat(i8* %s691, i8* %t692)
  %s694 = getelementptr inbounds [49 x i8], [49 x i8]* @.str.len48.h807033739, i32 0, i32 0
  %t695 = call i8* @sailfin_runtime_string_concat(i8* %t693, i8* %s694)
  %t696 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t690, i8* %t695)
  store { i8**, i64 }* %t696, { i8**, i64 }** %l0
  store i1 1, i1* %l13
  %t697 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t698 = load i1, i1* %l13
  br label %merge46
merge46:
  %t699 = phi { i8**, i64 }* [ %t697, %then45 ], [ %t671, %then43 ]
  %t700 = phi i1 [ %t698, %then45 ], [ %t684, %then43 ]
  store { i8**, i64 }* %t699, { i8**, i64 }** %l0
  store i1 %t700, i1* %l13
  %t701 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t702 = load i1, i1* %l13
  br label %merge44
merge44:
  %t703 = phi { i8**, i64 }* [ %t701, %merge46 ], [ %t650, %merge42 ]
  %t704 = phi i1 [ %t702, %merge46 ], [ %t663, %merge42 ]
  store { i8**, i64 }* %t703, { i8**, i64 }** %l0
  store i1 %t704, i1* %l13
  %t705 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t706 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t707 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t708 = load i1, i1* %l13
  br label %merge39
merge39:
  %t709 = phi { i8**, i64 }* [ %t705, %merge44 ], [ %t581, %then36 ]
  %t710 = phi { %NativeEnumVariantLayout*, i64 }* [ %t706, %merge44 ], [ %t587, %then36 ]
  %t711 = phi { i8**, i64 }* [ %t707, %merge44 ], [ %t581, %then36 ]
  %t712 = phi i1 [ %t708, %merge44 ], [ %t594, %then36 ]
  store { i8**, i64 }* %t709, { i8**, i64 }** %l0
  store { %NativeEnumVariantLayout*, i64 }* %t710, { %NativeEnumVariantLayout*, i64 }** %l6
  store { i8**, i64 }* %t711, { i8**, i64 }** %l0
  store i1 %t712, i1* %l13
  %t713 = load double, double* %l14
  %t714 = sitofp i64 1 to double
  %t715 = fadd double %t713, %t714
  store double %t715, double* %l14
  br label %loop.latch6
merge37:
  %t716 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s717 = getelementptr inbounds [36 x i8], [36 x i8]* @.str.len35.h2058816325, i32 0, i32 0
  %t718 = load i8*, i8** %l16
  %t719 = call i8* @sailfin_runtime_string_concat(i8* %s717, i8* %t718)
  %t720 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t716, i8* %t719)
  store { i8**, i64 }* %t720, { i8**, i64 }** %l0
  %t721 = load double, double* %l14
  %t722 = sitofp i64 1 to double
  %t723 = fadd double %t721, %t722
  store double %t723, double* %l14
  br label %loop.latch6
merge17:
  %t724 = load i8*, i8** %l16
  %s725 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h562875475, i32 0, i32 0
  %t726 = call i1 @strings_equal(i8* %t724, i8* %s725)
  %t727 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t728 = load i8*, i8** %l1
  %t729 = load i8*, i8** %l2
  %t730 = load i8*, i8** %l3
  %t731 = load double, double* %l4
  %t732 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t733 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t734 = load double, double* %l7
  %t735 = load double, double* %l8
  %t736 = load i8*, i8** %l9
  %t737 = load double, double* %l10
  %t738 = load double, double* %l11
  %t739 = load i1, i1* %l12
  %t740 = load i1, i1* %l13
  %t741 = load double, double* %l14
  %t742 = load i8*, i8** %l16
  br i1 %t726, label %then47, label %merge48
then47:
  %t743 = load double, double* %l14
  %t744 = sitofp i64 1 to double
  %t745 = fadd double %t743, %t744
  store double %t745, double* %l14
  br label %afterloop7
merge48:
  %t746 = load i8*, i8** %l16
  %s747 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t748 = call i1 @starts_with(i8* %t746, i8* %s747)
  %t749 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t750 = load i8*, i8** %l1
  %t751 = load i8*, i8** %l2
  %t752 = load i8*, i8** %l3
  %t753 = load double, double* %l4
  %t754 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t755 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t756 = load double, double* %l7
  %t757 = load double, double* %l8
  %t758 = load i8*, i8** %l9
  %t759 = load double, double* %l10
  %t760 = load double, double* %l11
  %t761 = load i1, i1* %l12
  %t762 = load i1, i1* %l13
  %t763 = load double, double* %l14
  %t764 = load i8*, i8** %l16
  br i1 %t748, label %then49, label %merge50
then49:
  %t765 = load i8*, i8** %l16
  %s766 = getelementptr inbounds [10 x i8], [10 x i8]* @.str.len9.h1311191977, i32 0, i32 0
  %t767 = call i8* @strip_prefix(i8* %t765, i8* %s766)
  %t768 = call %NativeEnumVariant* @parse_enum_variant_line(i8* %t767)
  store %NativeEnumVariant* %t768, %NativeEnumVariant** %l23
  %t769 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t770 = icmp eq %NativeEnumVariant* %t769, null
  %t771 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t772 = load i8*, i8** %l1
  %t773 = load i8*, i8** %l2
  %t774 = load i8*, i8** %l3
  %t775 = load double, double* %l4
  %t776 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t777 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t778 = load double, double* %l7
  %t779 = load double, double* %l8
  %t780 = load i8*, i8** %l9
  %t781 = load double, double* %l10
  %t782 = load double, double* %l11
  %t783 = load i1, i1* %l12
  %t784 = load i1, i1* %l13
  %t785 = load double, double* %l14
  %t786 = load i8*, i8** %l16
  %t787 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  br i1 %t770, label %then51, label %else52
then51:
  %t788 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s789 = getelementptr inbounds [31 x i8], [31 x i8]* @.str.len30.h829706524, i32 0, i32 0
  %t790 = load i8*, i8** %l16
  %t791 = call i8* @sailfin_runtime_string_concat(i8* %s789, i8* %t790)
  %t792 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t788, i8* %t791)
  store { i8**, i64 }* %t792, { i8**, i64 }** %l0
  %t793 = load { i8**, i64 }*, { i8**, i64 }** %l0
  br label %merge53
else52:
  %t794 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t795 = load %NativeEnumVariant*, %NativeEnumVariant** %l23
  %t796 = load %NativeEnumVariant, %NativeEnumVariant* %t795
  %t797 = call { %NativeEnumVariant*, i64 }* @append_enum_variant({ %NativeEnumVariant*, i64 }* %t794, %NativeEnumVariant %t796)
  store { %NativeEnumVariant*, i64 }* %t797, { %NativeEnumVariant*, i64 }** %l5
  %t798 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %merge53
merge53:
  %t799 = phi { i8**, i64 }* [ %t793, %then51 ], [ %t771, %else52 ]
  %t800 = phi { %NativeEnumVariant*, i64 }* [ %t776, %then51 ], [ %t798, %else52 ]
  store { i8**, i64 }* %t799, { i8**, i64 }** %l0
  store { %NativeEnumVariant*, i64 }* %t800, { %NativeEnumVariant*, i64 }** %l5
  %t801 = load double, double* %l14
  %t802 = sitofp i64 1 to double
  %t803 = fadd double %t801, %t802
  store double %t803, double* %l14
  br label %loop.latch6
merge50:
  %t804 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %s805 = getelementptr inbounds [29 x i8], [29 x i8]* @.str.len28.h1471254674, i32 0, i32 0
  %t806 = load i8*, i8** %l16
  %t807 = call i8* @sailfin_runtime_string_concat(i8* %s805, i8* %t806)
  %t808 = call { i8**, i64 }* @sailfin_runtime_append_string({ i8**, i64 }* %t804, i8* %t807)
  store { i8**, i64 }* %t808, { i8**, i64 }** %l0
  %t809 = load double, double* %l14
  %t810 = sitofp i64 1 to double
  %t811 = fadd double %t809, %t810
  store double %t811, double* %l14
  br label %loop.latch6
loop.latch6:
  %t812 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t813 = load double, double* %l14
  %t814 = load double, double* %l7
  %t815 = load double, double* %l8
  %t816 = load i8*, i8** %l9
  %t817 = load double, double* %l10
  %t818 = load double, double* %l11
  %t819 = load i1, i1* %l12
  %t820 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t821 = load i1, i1* %l13
  %t822 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  br label %loop.header4
afterloop7:
  %t834 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t835 = load double, double* %l14
  %t836 = load double, double* %l7
  %t837 = load double, double* %l8
  %t838 = load i8*, i8** %l9
  %t839 = load double, double* %l10
  %t840 = load double, double* %l11
  %t841 = load i1, i1* %l12
  %t842 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t843 = load i1, i1* %l13
  %t844 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t845 = bitcast i8* null to %NativeEnumLayout*
  store %NativeEnumLayout* %t845, %NativeEnumLayout** %l24
  %t846 = load i1, i1* %l12
  %t847 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t848 = load i8*, i8** %l1
  %t849 = load i8*, i8** %l2
  %t850 = load i8*, i8** %l3
  %t851 = load double, double* %l4
  %t852 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t853 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t854 = load double, double* %l7
  %t855 = load double, double* %l8
  %t856 = load i8*, i8** %l9
  %t857 = load double, double* %l10
  %t858 = load double, double* %l11
  %t859 = load i1, i1* %l12
  %t860 = load i1, i1* %l13
  %t861 = load double, double* %l14
  %t862 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br i1 %t846, label %then54, label %merge55
then54:
  %t863 = load double, double* %l7
  %t864 = insertvalue %NativeEnumLayout undef, double %t863, 0
  %t865 = load double, double* %l8
  %t866 = insertvalue %NativeEnumLayout %t864, double %t865, 1
  %t867 = load i8*, i8** %l9
  %t868 = insertvalue %NativeEnumLayout %t866, i8* %t867, 2
  %t869 = load double, double* %l10
  %t870 = insertvalue %NativeEnumLayout %t868, double %t869, 3
  %t871 = load double, double* %l11
  %t872 = insertvalue %NativeEnumLayout %t870, double %t871, 4
  %t873 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l6
  %t874 = insertvalue %NativeEnumLayout %t872, { %NativeEnumVariantLayout*, i64 }* %t873, 5
  %t875 = getelementptr %NativeEnumLayout, %NativeEnumLayout* null, i32 1
  %t876 = ptrtoint %NativeEnumLayout* %t875 to i64
  %t877 = call noalias i8* @malloc(i64 %t876)
  %t878 = bitcast i8* %t877 to %NativeEnumLayout*
  store %NativeEnumLayout %t874, %NativeEnumLayout* %t878
  call void @sailfin_runtime_mark_persistent(i8* %t877)
  store %NativeEnumLayout* %t878, %NativeEnumLayout** %l24
  %t879 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  br label %merge55
merge55:
  %t880 = phi %NativeEnumLayout* [ %t879, %then54 ], [ %t862, %afterloop7 ]
  store %NativeEnumLayout* %t880, %NativeEnumLayout** %l24
  %t881 = load i8*, i8** %l3
  %t882 = insertvalue %NativeEnum undef, i8* %t881, 0
  %t883 = load { %NativeEnumVariant*, i64 }*, { %NativeEnumVariant*, i64 }** %l5
  %t884 = insertvalue %NativeEnum %t882, { %NativeEnumVariant*, i64 }* %t883, 1
  %t885 = load %NativeEnumLayout*, %NativeEnumLayout** %l24
  %t886 = insertvalue %NativeEnum %t884, %NativeEnumLayout* %t885, 2
  %t887 = getelementptr %NativeEnum, %NativeEnum* null, i32 1
  %t888 = ptrtoint %NativeEnum* %t887 to i64
  %t889 = call noalias i8* @malloc(i64 %t888)
  %t890 = bitcast i8* %t889 to %NativeEnum*
  store %NativeEnum %t886, %NativeEnum* %t890
  call void @sailfin_runtime_mark_persistent(i8* %t889)
  %t891 = insertvalue %EnumParseResult undef, %NativeEnum* %t890, 0
  %t892 = load double, double* %l14
  %t893 = insertvalue %EnumParseResult %t891, double %t892, 1
  %t894 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t895 = insertvalue %EnumParseResult %t893, { i8**, i64 }* %t894, 2
  ret %EnumParseResult %t895
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
  %t33 = getelementptr %NativeEnumVariant, %NativeEnumVariant* null, i32 1
  %t34 = ptrtoint %NativeEnumVariant* %t33 to i64
  %t35 = call noalias i8* @malloc(i64 %t34)
  %t36 = bitcast i8* %t35 to %NativeEnumVariant*
  store %NativeEnumVariant %t32, %NativeEnumVariant* %t36
  call void @sailfin_runtime_mark_persistent(i8* %t35)
  ret %NativeEnumVariant* %t36
merge3:
  %t37 = load i8*, i8** %l0
  %t38 = add i64 0, 2
  %t39 = call i8* @malloc(i64 %t38)
  store i8 125, i8* %t39
  %t40 = getelementptr i8, i8* %t39, i64 1
  store i8 0, i8* %t40
  call void @sailfin_runtime_mark_persistent(i8* %t39)
  %t41 = call double @last_index_of(i8* %t37, i8* %t39)
  store double %t41, double* %l2
  %t43 = load double, double* %l2
  %t44 = sitofp i64 0 to double
  %t45 = fcmp olt double %t43, %t44
  br label %logical_or_entry_42

logical_or_entry_42:
  br i1 %t45, label %logical_or_merge_42, label %logical_or_right_42

logical_or_right_42:
  %t46 = load double, double* %l2
  %t47 = load double, double* %l1
  %t48 = fcmp ole double %t46, %t47
  br label %logical_or_right_end_42

logical_or_right_end_42:
  br label %logical_or_merge_42

logical_or_merge_42:
  %t49 = phi i1 [ true, %logical_or_entry_42 ], [ %t48, %logical_or_right_end_42 ]
  %t50 = load i8*, i8** %l0
  %t51 = load double, double* %l1
  %t52 = load double, double* %l2
  br i1 %t49, label %then4, label %merge5
then4:
  %t53 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t53
merge5:
  %t54 = load i8*, i8** %l0
  %t55 = load double, double* %l1
  %t56 = call double @llvm.round.f64(double %t55)
  %t57 = fptosi double %t56 to i64
  %t58 = call i8* @sailfin_runtime_substring(i8* %t54, i64 0, i64 %t57)
  %t59 = call i8* @trim_text(i8* %t58)
  %t60 = call i8* @strip_generics(i8* %t59)
  store i8* %t60, i8** %l3
  %t61 = load i8*, i8** %l3
  %t62 = call i64 @sailfin_runtime_string_length(i8* %t61)
  %t63 = icmp eq i64 %t62, 0
  %t64 = load i8*, i8** %l0
  %t65 = load double, double* %l1
  %t66 = load double, double* %l2
  %t67 = load i8*, i8** %l3
  br i1 %t63, label %then6, label %merge7
then6:
  %t68 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t68
merge7:
  %t69 = load i8*, i8** %l0
  %t70 = load double, double* %l1
  %t71 = sitofp i64 1 to double
  %t72 = fadd double %t70, %t71
  %t73 = load double, double* %l2
  %t74 = call double @llvm.round.f64(double %t72)
  %t75 = fptosi double %t74 to i64
  %t76 = call double @llvm.round.f64(double %t73)
  %t77 = fptosi double %t76 to i64
  %t78 = call i8* @sailfin_runtime_substring(i8* %t69, i64 %t75, i64 %t77)
  store i8* %t78, i8** %l4
  %t79 = load i8*, i8** %l4
  %t80 = call { i8**, i64 }* @split_enum_field_entries(i8* %t79)
  store { i8**, i64 }* %t80, { i8**, i64 }** %l5
  %t81 = getelementptr [0 x %NativeEnumVariantField], [0 x %NativeEnumVariantField]* null, i32 1
  %t82 = ptrtoint [0 x %NativeEnumVariantField]* %t81 to i64
  %t83 = icmp eq i64 %t82, 0
  %t84 = select i1 %t83, i64 1, i64 %t82
  %t85 = call i8* @malloc(i64 %t84)
  %t86 = bitcast i8* %t85 to %NativeEnumVariantField*
  %t87 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* null, i32 1
  %t88 = ptrtoint { %NativeEnumVariantField*, i64 }* %t87 to i64
  %t89 = call i8* @malloc(i64 %t88)
  %t90 = bitcast i8* %t89 to { %NativeEnumVariantField*, i64 }*
  %t91 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t90, i32 0, i32 0
  store %NativeEnumVariantField* %t86, %NativeEnumVariantField** %t91
  %t92 = getelementptr { %NativeEnumVariantField*, i64 }, { %NativeEnumVariantField*, i64 }* %t90, i32 0, i32 1
  store i64 0, i64* %t92
  store { %NativeEnumVariantField*, i64 }* %t90, { %NativeEnumVariantField*, i64 }** %l6
  %t93 = sitofp i64 0 to double
  store double %t93, double* %l7
  %t94 = load i8*, i8** %l0
  %t95 = load double, double* %l1
  %t96 = load double, double* %l2
  %t97 = load i8*, i8** %l3
  %t98 = load i8*, i8** %l4
  %t99 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t100 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t101 = load double, double* %l7
  br label %loop.header8
loop.header8:
  %t167 = phi double [ %t101, %merge7 ], [ %t165, %loop.latch10 ]
  %t168 = phi { %NativeEnumVariantField*, i64 }* [ %t100, %merge7 ], [ %t166, %loop.latch10 ]
  store double %t167, double* %l7
  store { %NativeEnumVariantField*, i64 }* %t168, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.body9
loop.body9:
  %t102 = load double, double* %l7
  %t103 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t104 = load { i8**, i64 }, { i8**, i64 }* %t103
  %t105 = extractvalue { i8**, i64 } %t104, 1
  %t106 = sitofp i64 %t105 to double
  %t107 = fcmp oge double %t102, %t106
  %t108 = load i8*, i8** %l0
  %t109 = load double, double* %l1
  %t110 = load double, double* %l2
  %t111 = load i8*, i8** %l3
  %t112 = load i8*, i8** %l4
  %t113 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t114 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t115 = load double, double* %l7
  br i1 %t107, label %then12, label %merge13
then12:
  br label %afterloop11
merge13:
  %t116 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t117 = load double, double* %l7
  %t118 = call double @llvm.round.f64(double %t117)
  %t119 = fptosi double %t118 to i64
  %t120 = load { i8**, i64 }, { i8**, i64 }* %t116
  %t121 = extractvalue { i8**, i64 } %t120, 0
  %t122 = extractvalue { i8**, i64 } %t120, 1
  %t123 = icmp uge i64 %t119, %t122
  ; bounds check: %t123 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t119, i64 %t122)
  %t124 = getelementptr i8*, i8** %t121, i64 %t119
  %t125 = load i8*, i8** %t124
  %t126 = call i8* @trim_text(i8* %t125)
  %t127 = call i8* @trim_trailing_delimiters(i8* %t126)
  store i8* %t127, i8** %l8
  %t128 = load i8*, i8** %l8
  %t129 = call i64 @sailfin_runtime_string_length(i8* %t128)
  %t130 = icmp eq i64 %t129, 0
  %t131 = load i8*, i8** %l0
  %t132 = load double, double* %l1
  %t133 = load double, double* %l2
  %t134 = load i8*, i8** %l3
  %t135 = load i8*, i8** %l4
  %t136 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t137 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t138 = load double, double* %l7
  %t139 = load i8*, i8** %l8
  br i1 %t130, label %then14, label %merge15
then14:
  %t140 = load double, double* %l7
  %t141 = sitofp i64 1 to double
  %t142 = fadd double %t140, %t141
  store double %t142, double* %l7
  br label %loop.latch10
merge15:
  %t143 = load i8*, i8** %l8
  %t144 = call %NativeEnumVariantField* @parse_enum_variant_field(i8* %t143)
  store %NativeEnumVariantField* %t144, %NativeEnumVariantField** %l9
  %t145 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t146 = icmp eq %NativeEnumVariantField* %t145, null
  %t147 = load i8*, i8** %l0
  %t148 = load double, double* %l1
  %t149 = load double, double* %l2
  %t150 = load i8*, i8** %l3
  %t151 = load i8*, i8** %l4
  %t152 = load { i8**, i64 }*, { i8**, i64 }** %l5
  %t153 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t154 = load double, double* %l7
  %t155 = load i8*, i8** %l8
  %t156 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  br i1 %t146, label %then16, label %merge17
then16:
  %t157 = bitcast i8* null to %NativeEnumVariant*
  ret %NativeEnumVariant* %t157
merge17:
  %t158 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t159 = load %NativeEnumVariantField*, %NativeEnumVariantField** %l9
  %t160 = load %NativeEnumVariantField, %NativeEnumVariantField* %t159
  %t161 = call { %NativeEnumVariantField*, i64 }* @append_enum_variant_field({ %NativeEnumVariantField*, i64 }* %t158, %NativeEnumVariantField %t160)
  store { %NativeEnumVariantField*, i64 }* %t161, { %NativeEnumVariantField*, i64 }** %l6
  %t162 = load double, double* %l7
  %t163 = sitofp i64 1 to double
  %t164 = fadd double %t162, %t163
  store double %t164, double* %l7
  br label %loop.latch10
loop.latch10:
  %t165 = load double, double* %l7
  %t166 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  br label %loop.header8
afterloop11:
  %t169 = load double, double* %l7
  %t170 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t171 = load i8*, i8** %l3
  %t172 = insertvalue %NativeEnumVariant undef, i8* %t171, 0
  %t173 = load { %NativeEnumVariantField*, i64 }*, { %NativeEnumVariantField*, i64 }** %l6
  %t174 = insertvalue %NativeEnumVariant %t172, { %NativeEnumVariantField*, i64 }* %t173, 1
  %t175 = getelementptr %NativeEnumVariant, %NativeEnumVariant* null, i32 1
  %t176 = ptrtoint %NativeEnumVariant* %t175 to i64
  %t177 = call noalias i8* @malloc(i64 %t176)
  %t178 = bitcast i8* %t177 to %NativeEnumVariant*
  store %NativeEnumVariant %t174, %NativeEnumVariant* %t178
  call void @sailfin_runtime_mark_persistent(i8* %t177)
  ret %NativeEnumVariant* %t178
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
  %t59 = getelementptr %NativeEnumVariantField, %NativeEnumVariantField* null, i32 1
  %t60 = ptrtoint %NativeEnumVariantField* %t59 to i64
  %t61 = call noalias i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to %NativeEnumVariantField*
  store %NativeEnumVariantField %t58, %NativeEnumVariantField* %t62
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  ret %NativeEnumVariantField* %t62
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
  %t59 = getelementptr %NativeStructField, %NativeStructField* null, i32 1
  %t60 = ptrtoint %NativeStructField* %t59 to i64
  %t61 = call noalias i8* @malloc(i64 %t60)
  %t62 = bitcast i8* %t61 to %NativeStructField*
  store %NativeStructField %t58, %NativeStructField* %t62
  call void @sailfin_runtime_mark_persistent(i8* %t61)
  ret %NativeStructField* %t62
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
  %t44 = call i8* @trim_text(i8* %t43)
  store i8* %t44, i8** %l0
  %s45 = getelementptr inbounds [1 x i8], [1 x i8]* @.str.len0.h177573, i32 0, i32 0
  store i8* %s45, i8** %l3
  store i8* null, i8** %l4
  %t46 = load double, double* %l1
  %t47 = call i64 @sailfin_runtime_string_length(i8* %text)
  %t48 = call double @llvm.round.f64(double %t46)
  %t49 = fptosi double %t48 to i64
  %t50 = call i8* @sailfin_runtime_substring(i8* %text, i64 %t49, i64 %t47)
  %t51 = call i8* @trim_text(i8* %t50)
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
  %t71 = call i8* @trim_text(i8* %t70)
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
  %t91 = call i8* @trim_text(i8* %t90)
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
  %t101 = call i8* @trim_text(i8* %t100)
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
  %t118 = call i8* @trim_text(i8* %t117)
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
  %t141 = call i8* @trim_text(i8* %t140)
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
  %t161 = call i8* @trim_text(i8* %t160)
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
  %t171 = call i8* @trim_text(i8* %t170)
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
  %t188 = call i8* @trim_text(i8* %t187)
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
  %t211 = call i8* @trim_text(i8* %t210)
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
  %t28 = call i8* @trim_text(i8* %t27)
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
  %t52 = call i8* @trim_text(i8* %t51)
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
  %t71 = call i8* @trim_text(i8* %t70)
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
  %t88 = call i8* @trim_text(i8* %t87)
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
  %t112 = call i8* @trim_text(i8* %t111)
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
  %t134 = call i8* @trim_text(i8* %t133)
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
  %t144 = call i8* @trim_text(i8* %t143)
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
  %t163 = call i8* @trim_text(i8* %t162)
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
  %t188 = call i8* @trim_text(i8* %t187)
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
  %t228 = getelementptr %NativeParameter, %NativeParameter* null, i32 1
  %t229 = ptrtoint %NativeParameter* %t228 to i64
  %t230 = call noalias i8* @malloc(i64 %t229)
  %t231 = bitcast i8* %t230 to %NativeParameter*
  store %NativeParameter %t227, %NativeParameter* %t231
  call void @sailfin_runtime_mark_persistent(i8* %t230)
  ret %NativeParameter* %t231
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
  %t30 = call i8* @trim_text(i8* %t29)
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
  %t46 = call i8* @trim_text(i8* %t45)
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
  %t91 = call i8* @trim_text(i8* %t90)
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
  %t109 = call i8* @trim_text(i8* %t108)
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
  %t215 = call i8* @trim_text(i8* %t214)
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
  %t266 = call i8* @trim_text(i8* %t265)
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
  %t71 = call i8* @trim_text(i8* %t70)
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
  %t79 = call i8* @trim_text(i8* %t78)
  call void @sailfin_runtime_mark_persistent(i8* %t79)
  ret i8* %t79
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
  %t19 = call i1 @is_trim_char(i8* %t17)
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
  %t47 = call i1 @is_trim_char(i8* %t45)
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
  %t720 = phi double [ %t42, %block.entry ], [ %t716, %loop.latch2 ]
  %t721 = phi { i8**, i64 }* [ %t39, %block.entry ], [ %t717, %loop.latch2 ]
  %t722 = phi { %NativeStruct*, i64 }* [ %t40, %block.entry ], [ %t718, %loop.latch2 ]
  %t723 = phi { %NativeEnum*, i64 }* [ %t41, %block.entry ], [ %t719, %loop.latch2 ]
  store double %t720, double* %l4
  store { i8**, i64 }* %t721, { i8**, i64 }** %l1
  store { %NativeStruct*, i64 }* %t722, { %NativeStruct*, i64 }** %l2
  store { %NativeEnum*, i64 }* %t723, { %NativeEnum*, i64 }** %l3
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
  %t198 = call i8* @trim_text(i8* %t197)
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
  %t333 = getelementptr %NativeStructLayout, %NativeStructLayout* null, i32 1
  %t334 = ptrtoint %NativeStructLayout* %t333 to i64
  %t335 = call noalias i8* @malloc(i64 %t334)
  %t336 = bitcast i8* %t335 to %NativeStructLayout*
  store %NativeStructLayout %t332, %NativeStructLayout* %t336
  call void @sailfin_runtime_mark_persistent(i8* %t335)
  %t337 = insertvalue %NativeStruct %t324, %NativeStructLayout* %t336, 4
  store %NativeStruct %t337, %NativeStruct* %l16
  %t338 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t339 = load %NativeStruct, %NativeStruct* %l16
  %t340 = call { %NativeStruct*, i64 }* @append_struct({ %NativeStruct*, i64 }* %t338, %NativeStruct %t339)
  store { %NativeStruct*, i64 }* %t340, { %NativeStruct*, i64 }** %l2
  %t341 = load double, double* %l4
  %t342 = load i8*, i8** %l7
  %t343 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t344 = load double, double* %l4
  %t345 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  br label %merge15
merge15:
  %t346 = phi double [ %t341, %afterloop19 ], [ %t135, %then12 ]
  %t347 = phi i8* [ %t342, %afterloop19 ], [ %t138, %then12 ]
  %t348 = phi { i8**, i64 }* [ %t343, %afterloop19 ], [ %t132, %then12 ]
  %t349 = phi double [ %t344, %afterloop19 ], [ %t135, %then12 ]
  %t350 = phi { %NativeStruct*, i64 }* [ %t345, %afterloop19 ], [ %t133, %then12 ]
  store double %t346, double* %l4
  store i8* %t347, i8** %l7
  store { i8**, i64 }* %t348, { i8**, i64 }** %l1
  store double %t349, double* %l4
  store { %NativeStruct*, i64 }* %t350, { %NativeStruct*, i64 }** %l2
  %t351 = load double, double* %l4
  %t352 = sitofp i64 1 to double
  %t353 = fadd double %t351, %t352
  store double %t353, double* %l4
  br label %loop.latch2
merge13:
  %t354 = load i8*, i8** %l6
  %s355 = getelementptr inbounds [14 x i8], [14 x i8]* @.str.len13.h259593098, i32 0, i32 0
  %t356 = call i1 @starts_with(i8* %t354, i8* %s355)
  %t357 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t358 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t359 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t360 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t361 = load double, double* %l4
  %t362 = load i8*, i8** %l5
  %t363 = load i8*, i8** %l6
  br i1 %t356, label %then28, label %merge29
then28:
  %t364 = load i8*, i8** %l6
  %s365 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t366 = call i8* @strip_prefix(i8* %t364, i8* %s365)
  store i8* %t366, i8** %l17
  %t367 = load i8*, i8** %l17
  %s368 = getelementptr inbounds [6 x i8], [6 x i8]* @.str.len5.h2072026244, i32 0, i32 0
  %t369 = call i8* @strip_prefix(i8* %t367, i8* %s368)
  store i8* %t369, i8** %l18
  %t370 = load i8*, i8** %l18
  %t371 = call %EnumLayoutHeaderParse @parse_enum_layout_header(i8* %t370)
  store %EnumLayoutHeaderParse %t371, %EnumLayoutHeaderParse* %l19
  %t372 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t373 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t374 = extractvalue %EnumLayoutHeaderParse %t373, 7
  %t375 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t372, { i8**, i64 }* %t374)
  store { i8**, i64 }* %t375, { i8**, i64 }** %l1
  %t376 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t377 = extractvalue %EnumLayoutHeaderParse %t376, 0
  %t378 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t379 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t380 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t381 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t382 = load double, double* %l4
  %t383 = load i8*, i8** %l5
  %t384 = load i8*, i8** %l6
  %t385 = load i8*, i8** %l17
  %t386 = load i8*, i8** %l18
  %t387 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  br i1 %t377, label %then30, label %else31
then30:
  %t388 = getelementptr [0 x %NativeEnumVariantLayout], [0 x %NativeEnumVariantLayout]* null, i32 1
  %t389 = ptrtoint [0 x %NativeEnumVariantLayout]* %t388 to i64
  %t390 = icmp eq i64 %t389, 0
  %t391 = select i1 %t390, i64 1, i64 %t389
  %t392 = call i8* @malloc(i64 %t391)
  %t393 = bitcast i8* %t392 to %NativeEnumVariantLayout*
  %t394 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* null, i32 1
  %t395 = ptrtoint { %NativeEnumVariantLayout*, i64 }* %t394 to i64
  %t396 = call i8* @malloc(i64 %t395)
  %t397 = bitcast i8* %t396 to { %NativeEnumVariantLayout*, i64 }*
  %t398 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t397, i32 0, i32 0
  store %NativeEnumVariantLayout* %t393, %NativeEnumVariantLayout** %t398
  %t399 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t397, i32 0, i32 1
  store i64 0, i64* %t399
  store { %NativeEnumVariantLayout*, i64 }* %t397, { %NativeEnumVariantLayout*, i64 }** %l20
  %t400 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t401 = extractvalue %EnumLayoutHeaderParse %t400, 1
  store i8* %t401, i8** %l21
  %t402 = load double, double* %l4
  %t403 = sitofp i64 1 to double
  %t404 = fadd double %t402, %t403
  store double %t404, double* %l4
  %t405 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t406 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t407 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t408 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t409 = load double, double* %l4
  %t410 = load i8*, i8** %l5
  %t411 = load i8*, i8** %l6
  %t412 = load i8*, i8** %l17
  %t413 = load i8*, i8** %l18
  %t414 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t415 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t416 = load i8*, i8** %l21
  br label %loop.header33
loop.header33:
  %t652 = phi double [ %t409, %then30 ], [ %t648, %loop.latch35 ]
  %t653 = phi i8* [ %t412, %then30 ], [ %t649, %loop.latch35 ]
  %t654 = phi { i8**, i64 }* [ %t406, %then30 ], [ %t650, %loop.latch35 ]
  %t655 = phi { %NativeEnumVariantLayout*, i64 }* [ %t415, %then30 ], [ %t651, %loop.latch35 ]
  store double %t652, double* %l4
  store i8* %t653, i8** %l17
  store { i8**, i64 }* %t654, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t655, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.body34
loop.body34:
  %t417 = load double, double* %l4
  %t418 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t419 = load { i8**, i64 }, { i8**, i64 }* %t418
  %t420 = extractvalue { i8**, i64 } %t419, 1
  %t421 = sitofp i64 %t420 to double
  %t422 = fcmp oge double %t417, %t421
  %t423 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t424 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t425 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t426 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t427 = load double, double* %l4
  %t428 = load i8*, i8** %l5
  %t429 = load i8*, i8** %l6
  %t430 = load i8*, i8** %l17
  %t431 = load i8*, i8** %l18
  %t432 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t433 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t434 = load i8*, i8** %l21
  br i1 %t422, label %then37, label %merge38
then37:
  br label %afterloop36
merge38:
  %t435 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t436 = load double, double* %l4
  %t437 = call double @llvm.round.f64(double %t436)
  %t438 = fptosi double %t437 to i64
  %t439 = load { i8**, i64 }, { i8**, i64 }* %t435
  %t440 = extractvalue { i8**, i64 } %t439, 0
  %t441 = extractvalue { i8**, i64 } %t439, 1
  %t442 = icmp uge i64 %t438, %t441
  ; bounds check: %t442 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t438, i64 %t441)
  %t443 = getelementptr i8*, i8** %t440, i64 %t438
  %t444 = load i8*, i8** %t443
  %t445 = call i8* @trim_text(i8* %t444)
  store i8* %t445, i8** %l22
  %t446 = load i8*, i8** %l22
  %t447 = call i64 @sailfin_runtime_string_length(i8* %t446)
  %t448 = icmp eq i64 %t447, 0
  %t449 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t450 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t451 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t452 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t453 = load double, double* %l4
  %t454 = load i8*, i8** %l5
  %t455 = load i8*, i8** %l6
  %t456 = load i8*, i8** %l17
  %t457 = load i8*, i8** %l18
  %t458 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t459 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t460 = load i8*, i8** %l21
  %t461 = load i8*, i8** %l22
  br i1 %t448, label %then39, label %merge40
then39:
  %t462 = load double, double* %l4
  %t463 = sitofp i64 1 to double
  %t464 = fadd double %t462, %t463
  store double %t464, double* %l4
  br label %afterloop36
merge40:
  %t466 = load i8*, i8** %l22
  %s467 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t468 = call i1 @starts_with(i8* %t466, i8* %s467)
  %t469 = xor i1 %t468, 1
  br label %logical_and_entry_465

logical_and_entry_465:
  br i1 %t469, label %logical_and_right_465, label %logical_and_merge_465

logical_and_right_465:
  %t470 = load i8*, i8** %l22
  %s471 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t472 = call i1 @starts_with(i8* %t470, i8* %s471)
  %t473 = xor i1 %t472, 1
  br label %logical_and_right_end_465

logical_and_right_end_465:
  br label %logical_and_merge_465

logical_and_merge_465:
  %t474 = phi i1 [ false, %logical_and_entry_465 ], [ %t473, %logical_and_right_end_465 ]
  %t475 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t476 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t477 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t478 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t479 = load double, double* %l4
  %t480 = load i8*, i8** %l5
  %t481 = load i8*, i8** %l6
  %t482 = load i8*, i8** %l17
  %t483 = load i8*, i8** %l18
  %t484 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t485 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t486 = load i8*, i8** %l21
  %t487 = load i8*, i8** %l22
  br i1 %t474, label %then41, label %merge42
then41:
  br label %afterloop36
merge42:
  %t488 = load i8*, i8** %l22
  %s489 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1695010494, i32 0, i32 0
  %t490 = call i1 @starts_with(i8* %t488, i8* %s489)
  %t491 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t492 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t493 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t494 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t495 = load double, double* %l4
  %t496 = load i8*, i8** %l5
  %t497 = load i8*, i8** %l6
  %t498 = load i8*, i8** %l17
  %t499 = load i8*, i8** %l18
  %t500 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t501 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t502 = load i8*, i8** %l21
  %t503 = load i8*, i8** %l22
  br i1 %t490, label %then43, label %else44
then43:
  %t504 = load i8*, i8** %l22
  %s505 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t506 = call i8* @strip_prefix(i8* %t504, i8* %s505)
  store i8* %t506, i8** %l23
  %t507 = load i8*, i8** %l17
  %s508 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1926252274, i32 0, i32 0
  %t509 = call i8* @strip_prefix(i8* %t507, i8* %s508)
  store i8* %t509, i8** %l24
  %t510 = load i8*, i8** %l24
  %t511 = load i8*, i8** %l21
  %t512 = call %EnumLayoutVariantParse @parse_enum_variant_layout(i8* %t510, i8* %t511)
  store %EnumLayoutVariantParse %t512, %EnumLayoutVariantParse* %l25
  %t513 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t514 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t515 = extractvalue %EnumLayoutVariantParse %t514, 2
  %t516 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t513, { i8**, i64 }* %t515)
  store { i8**, i64 }* %t516, { i8**, i64 }** %l1
  %t517 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t518 = extractvalue %EnumLayoutVariantParse %t517, 0
  %t519 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t520 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t521 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t522 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t523 = load double, double* %l4
  %t524 = load i8*, i8** %l5
  %t525 = load i8*, i8** %l6
  %t526 = load i8*, i8** %l17
  %t527 = load i8*, i8** %l18
  %t528 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t529 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t530 = load i8*, i8** %l21
  %t531 = load i8*, i8** %l22
  %t532 = load i8*, i8** %l23
  %t533 = load i8*, i8** %l24
  %t534 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  br i1 %t518, label %then46, label %merge47
then46:
  %t535 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t536 = load %EnumLayoutVariantParse, %EnumLayoutVariantParse* %l25
  %t537 = extractvalue %EnumLayoutVariantParse %t536, 1
  %t538 = call { %NativeEnumVariantLayout*, i64 }* @append_enum_variant_layout({ %NativeEnumVariantLayout*, i64 }* %t535, %NativeEnumVariantLayout %t537)
  store { %NativeEnumVariantLayout*, i64 }* %t538, { %NativeEnumVariantLayout*, i64 }** %l20
  %t539 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge47
merge47:
  %t540 = phi { %NativeEnumVariantLayout*, i64 }* [ %t539, %then46 ], [ %t529, %then43 ]
  store { %NativeEnumVariantLayout*, i64 }* %t540, { %NativeEnumVariantLayout*, i64 }** %l20
  %t541 = load i8*, i8** %l17
  %t542 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t543 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %merge45
else44:
  %t544 = load i8*, i8** %l22
  %s545 = getelementptr inbounds [17 x i8], [17 x i8]* @.str.len16.h1290415774, i32 0, i32 0
  %t546 = call i1 @starts_with(i8* %t544, i8* %s545)
  %t547 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t548 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t549 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t550 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t551 = load double, double* %l4
  %t552 = load i8*, i8** %l5
  %t553 = load i8*, i8** %l6
  %t554 = load i8*, i8** %l17
  %t555 = load i8*, i8** %l18
  %t556 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t557 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t558 = load i8*, i8** %l21
  %t559 = load i8*, i8** %l22
  br i1 %t546, label %then48, label %merge49
then48:
  %t560 = load i8*, i8** %l22
  %s561 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1616485352, i32 0, i32 0
  %t562 = call i8* @strip_prefix(i8* %t560, i8* %s561)
  store i8* %t562, i8** %l26
  %t563 = load i8*, i8** %l17
  %s564 = getelementptr inbounds [9 x i8], [9 x i8]* @.str.len8.h1521657554, i32 0, i32 0
  %t565 = call i8* @strip_prefix(i8* %t563, i8* %s564)
  store i8* %t565, i8** %l27
  %t566 = load i8*, i8** %l27
  %t567 = load i8*, i8** %l21
  %t568 = call %EnumLayoutPayloadParse @parse_enum_payload_layout(i8* %t566, i8* %t567)
  store %EnumLayoutPayloadParse %t568, %EnumLayoutPayloadParse* %l28
  %t569 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t570 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t571 = extractvalue %EnumLayoutPayloadParse %t570, 3
  %t572 = call { i8**, i64 }* @sailfin_runtime_concat({ i8**, i64 }* %t569, { i8**, i64 }* %t571)
  store { i8**, i64 }* %t572, { i8**, i64 }** %l1
  %t574 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t575 = extractvalue %EnumLayoutPayloadParse %t574, 0
  br label %logical_and_entry_573

logical_and_entry_573:
  br i1 %t575, label %logical_and_right_573, label %logical_and_merge_573

logical_and_right_573:
  %t576 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t577 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t576
  %t578 = extractvalue { %NativeEnumVariantLayout*, i64 } %t577, 1
  %t579 = icmp sgt i64 %t578, 0
  br label %logical_and_right_end_573

logical_and_right_end_573:
  br label %logical_and_merge_573

logical_and_merge_573:
  %t580 = phi i1 [ false, %logical_and_entry_573 ], [ %t579, %logical_and_right_end_573 ]
  %t581 = load { i8**, i64 }*, { i8**, i64 }** %l0
  %t582 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t583 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t584 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t585 = load double, double* %l4
  %t586 = load i8*, i8** %l5
  %t587 = load i8*, i8** %l6
  %t588 = load i8*, i8** %l17
  %t589 = load i8*, i8** %l18
  %t590 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t591 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t592 = load i8*, i8** %l21
  %t593 = load i8*, i8** %l22
  %t594 = load i8*, i8** %l26
  %t595 = load i8*, i8** %l27
  %t596 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  br i1 %t580, label %then50, label %merge51
then50:
  %t597 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t598 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t597
  %t599 = extractvalue { %NativeEnumVariantLayout*, i64 } %t598, 1
  %t600 = sub i64 %t599, 1
  store i64 %t600, i64* %l29
  %t601 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t602 = load i64, i64* %l29
  %t603 = load { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t601
  %t604 = extractvalue { %NativeEnumVariantLayout*, i64 } %t603, 0
  %t605 = extractvalue { %NativeEnumVariantLayout*, i64 } %t603, 1
  %t606 = icmp uge i64 %t602, %t605
  ; bounds check: %t606 (if true, out of bounds)
  call void @sailfin_runtime_bounds_check(i64 %t602, i64 %t605)
  %t607 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t604, i64 %t602
  %t608 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t607
  store %NativeEnumVariantLayout %t608, %NativeEnumVariantLayout* %l30
  %t609 = load %NativeEnumVariantLayout, %NativeEnumVariantLayout* %l30
  %t610 = extractvalue %NativeEnumVariantLayout %t609, 5
  %t611 = load %EnumLayoutPayloadParse, %EnumLayoutPayloadParse* %l28
  %t612 = extractvalue %EnumLayoutPayloadParse %t611, 2
  %t613 = call { %NativeStructLayoutField*, i64 }* @append_struct_layout_field({ %NativeStructLayoutField*, i64 }* %t610, %NativeStructLayoutField %t612)
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
  %t630 = insertvalue %NativeEnumVariantLayout %t628, { %NativeStructLayoutField*, i64 }* %t629, 5
  %t631 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t632 = load i64, i64* %l29
  %t633 = getelementptr { %NativeEnumVariantLayout*, i64 }, { %NativeEnumVariantLayout*, i64 }* %t631, i32 0, i32 0
  %t635 = load %NativeEnumVariantLayout*, %NativeEnumVariantLayout** %t633
  %t634 = getelementptr %NativeEnumVariantLayout, %NativeEnumVariantLayout* %t635, i64 %t632
  store %NativeEnumVariantLayout %t630, %NativeEnumVariantLayout* %t634
  br label %merge51
merge51:
  %t636 = load i8*, i8** %l17
  %t637 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge49
merge49:
  %t638 = phi i8* [ %t636, %merge51 ], [ %t554, %else44 ]
  %t639 = phi { i8**, i64 }* [ %t637, %merge51 ], [ %t548, %else44 ]
  store i8* %t638, i8** %l17
  store { i8**, i64 }* %t639, { i8**, i64 }** %l1
  %t640 = load i8*, i8** %l17
  %t641 = load { i8**, i64 }*, { i8**, i64 }** %l1
  br label %merge45
merge45:
  %t642 = phi i8* [ %t541, %merge47 ], [ %t640, %merge49 ]
  %t643 = phi { i8**, i64 }* [ %t542, %merge47 ], [ %t641, %merge49 ]
  %t644 = phi { %NativeEnumVariantLayout*, i64 }* [ %t543, %merge47 ], [ %t501, %merge49 ]
  store i8* %t642, i8** %l17
  store { i8**, i64 }* %t643, { i8**, i64 }** %l1
  store { %NativeEnumVariantLayout*, i64 }* %t644, { %NativeEnumVariantLayout*, i64 }** %l20
  %t645 = load double, double* %l4
  %t646 = sitofp i64 1 to double
  %t647 = fadd double %t645, %t646
  store double %t647, double* %l4
  br label %loop.latch35
loop.latch35:
  %t648 = load double, double* %l4
  %t649 = load i8*, i8** %l17
  %t650 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t651 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  br label %loop.header33
afterloop36:
  %t656 = load double, double* %l4
  %t657 = load i8*, i8** %l17
  %t658 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t659 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t660 = load i8*, i8** %l21
  %t661 = insertvalue %NativeEnum undef, i8* %t660, 0
  %t662 = getelementptr [0 x %NativeEnumVariant], [0 x %NativeEnumVariant]* null, i32 1
  %t663 = ptrtoint [0 x %NativeEnumVariant]* %t662 to i64
  %t664 = icmp eq i64 %t663, 0
  %t665 = select i1 %t664, i64 1, i64 %t663
  %t666 = call i8* @malloc(i64 %t665)
  %t667 = bitcast i8* %t666 to %NativeEnumVariant*
  %t668 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* null, i32 1
  %t669 = ptrtoint { %NativeEnumVariant*, i64 }* %t668 to i64
  %t670 = call i8* @malloc(i64 %t669)
  %t671 = bitcast i8* %t670 to { %NativeEnumVariant*, i64 }*
  %t672 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t671, i32 0, i32 0
  store %NativeEnumVariant* %t667, %NativeEnumVariant** %t672
  %t673 = getelementptr { %NativeEnumVariant*, i64 }, { %NativeEnumVariant*, i64 }* %t671, i32 0, i32 1
  store i64 0, i64* %t673
  %t674 = insertvalue %NativeEnum %t661, { %NativeEnumVariant*, i64 }* %t671, 1
  %t675 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t676 = extractvalue %EnumLayoutHeaderParse %t675, 2
  %t677 = insertvalue %NativeEnumLayout undef, double %t676, 0
  %t678 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t679 = extractvalue %EnumLayoutHeaderParse %t678, 3
  %t680 = insertvalue %NativeEnumLayout %t677, double %t679, 1
  %t681 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t682 = extractvalue %EnumLayoutHeaderParse %t681, 4
  %t683 = insertvalue %NativeEnumLayout %t680, i8* %t682, 2
  %t684 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t685 = extractvalue %EnumLayoutHeaderParse %t684, 5
  %t686 = insertvalue %NativeEnumLayout %t683, double %t685, 3
  %t687 = load %EnumLayoutHeaderParse, %EnumLayoutHeaderParse* %l19
  %t688 = extractvalue %EnumLayoutHeaderParse %t687, 6
  %t689 = insertvalue %NativeEnumLayout %t686, double %t688, 4
  %t690 = load { %NativeEnumVariantLayout*, i64 }*, { %NativeEnumVariantLayout*, i64 }** %l20
  %t691 = insertvalue %NativeEnumLayout %t689, { %NativeEnumVariantLayout*, i64 }* %t690, 5
  %t692 = getelementptr %NativeEnumLayout, %NativeEnumLayout* null, i32 1
  %t693 = ptrtoint %NativeEnumLayout* %t692 to i64
  %t694 = call noalias i8* @malloc(i64 %t693)
  %t695 = bitcast i8* %t694 to %NativeEnumLayout*
  store %NativeEnumLayout %t691, %NativeEnumLayout* %t695
  call void @sailfin_runtime_mark_persistent(i8* %t694)
  %t696 = insertvalue %NativeEnum %t674, %NativeEnumLayout* %t695, 2
  store %NativeEnum %t696, %NativeEnum* %l32
  %t697 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t698 = load %NativeEnum, %NativeEnum* %l32
  %t699 = call { %NativeEnum*, i64 }* @append_enum({ %NativeEnum*, i64 }* %t697, %NativeEnum %t698)
  store { %NativeEnum*, i64 }* %t699, { %NativeEnum*, i64 }** %l3
  %t700 = load double, double* %l4
  %t701 = load double, double* %l4
  %t702 = load i8*, i8** %l17
  %t703 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t704 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %merge32
else31:
  %t705 = load double, double* %l4
  %t706 = sitofp i64 1 to double
  %t707 = fadd double %t705, %t706
  store double %t707, double* %l4
  %t708 = load double, double* %l4
  br label %merge32
merge32:
  %t709 = phi double [ %t700, %afterloop36 ], [ %t708, %else31 ]
  %t710 = phi i8* [ %t702, %afterloop36 ], [ %t385, %else31 ]
  %t711 = phi { i8**, i64 }* [ %t703, %afterloop36 ], [ %t379, %else31 ]
  %t712 = phi { %NativeEnum*, i64 }* [ %t704, %afterloop36 ], [ %t381, %else31 ]
  store double %t709, double* %l4
  store i8* %t710, i8** %l17
  store { i8**, i64 }* %t711, { i8**, i64 }** %l1
  store { %NativeEnum*, i64 }* %t712, { %NativeEnum*, i64 }** %l3
  br label %loop.latch2
merge29:
  %t713 = load double, double* %l4
  %t714 = sitofp i64 1 to double
  %t715 = fadd double %t713, %t714
  store double %t715, double* %l4
  br label %loop.latch2
loop.latch2:
  %t716 = load double, double* %l4
  %t717 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t718 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t719 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  br label %loop.header0
afterloop3:
  %t724 = load double, double* %l4
  %t725 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t726 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t727 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t728 = load { %NativeStruct*, i64 }*, { %NativeStruct*, i64 }** %l2
  %t729 = insertvalue %LayoutManifest undef, { %NativeStruct*, i64 }* %t728, 0
  %t730 = load { %NativeEnum*, i64 }*, { %NativeEnum*, i64 }** %l3
  %t731 = insertvalue %LayoutManifest %t729, { %NativeEnum*, i64 }* %t730, 1
  %t732 = load { i8**, i64 }*, { i8**, i64 }** %l1
  %t733 = insertvalue %LayoutManifest %t731, { i8**, i64 }* %t732, 2
  ret %LayoutManifest %t733
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

define double @add(double %a, double %b) {
entry:
  %t0 = fadd double %a, %b
  ret double %t0
}
@.str.len14.h1053492670 = private unnamed_addr constant [15 x i8] c".layout field \00"
@.str.len9.h1171237782 = private unnamed_addr constant [10 x i8] c"tag_size=\00"
@.str.len4.h192491117 = private unnamed_addr constant [5 x i8] c".fn \00"
@.str.len47.h1886628617 = private unnamed_addr constant [48 x i8] c"top-level directive not supported in lowering: \00"
@.str.len31.h238974215 = private unnamed_addr constant [32 x i8] c" layout variant missing entries\00"
@.str.len11.h1513373193 = private unnamed_addr constant [12 x i8] c".init-span \00"
@.str.len29.h1601547567 = private unnamed_addr constant [30 x i8] c"unused span metadata before: \00"
@.str.len33.h1134984829 = private unnamed_addr constant [34 x i8] c"unsupported interface directive: \00"
@.str.len33.h1132321576 = private unnamed_addr constant [34 x i8] c" header has unsupported segment `\00"
@.str.len21.h1187531435 = private unnamed_addr constant [22 x i8] c"` missing closing `>`\00"
@.str.len26.h130324785 = private unnamed_addr constant [27 x i8] c" layout field missing name\00"
@.str.len8.h575595345 = private unnamed_addr constant [9 x i8] c".import \00"
@.enum.NativeInstruction.Return.variant = private unnamed_addr constant [7 x i8] c"Return\00"
@.str.len30.h702899578 = private unnamed_addr constant [31 x i8] c"unable to parse struct field: \00"
@.str.len2.h193415939 = private unnamed_addr constant [3 x i8] c"![\00"
@.enum.NativeInstruction.Continue.variant = private unnamed_addr constant [9 x i8] c"Continue\00"
@.str.len28.h1471254674 = private unnamed_addr constant [29 x i8] c"unsupported enum directive: \00"
@.str.len5.h2080793783 = private unnamed_addr constant [6 x i8] c"eval \00"
@.str.len25.h378946335 = private unnamed_addr constant [26 x i8] c"` has invalid parameter `\00"
@.str.len31.h1924917952 = private unnamed_addr constant [32 x i8] c"duplicate enum layout variant `\00"
@.str.len10.h179409731 = private unnamed_addr constant [11 x i8] c".endmethod\00"
@.str.len38.h2050661185 = private unnamed_addr constant [39 x i8] c"enum layout header missing align entry\00"
@.enum.NativeInstruction.EndFor.variant = private unnamed_addr constant [7 x i8] c"EndFor\00"
@.str.len23.h668778749 = private unnamed_addr constant [24 x i8] c"sailfin-layout-manifest\00"
@.str.len48.h235936117 = private unnamed_addr constant [49 x i8] c" layout variant encountered before layout header\00"
@.str.len3.h2090684245 = private unnamed_addr constant [4 x i8] c"ret\00"
@.str.len13.h259593098 = private unnamed_addr constant [14 x i8] c".layout enum \00"
@.str.len5.h2057365731 = private unnamed_addr constant [6 x i8] c".for \00"
@.str.len11.h908744813 = private unnamed_addr constant [12 x i8] c"implements \00"
@.str.len10.h469410318 = private unnamed_addr constant [11 x i8] c"tag_align=\00"
@.str.len20.h151690315 = private unnamed_addr constant [21 x i8] c"` has invalid size `\00"
@.str.len7.h553171426 = private unnamed_addr constant [8 x i8] c".match \00"
@.str.len5.h261048910 = private unnamed_addr constant [6 x i8] c"name=\00"
@.str.len16.h1290415774 = private unnamed_addr constant [17 x i8] c".layout payload \00"
@.str.len19.h1697653870 = private unnamed_addr constant [20 x i8] c"` missing tag entry\00"
@.str.len31.h755263238 = private unnamed_addr constant [32 x i8] c" layout payload missing entries\00"
@.enum.NativeInstruction.variant.default = private unnamed_addr constant [1 x i8] c"\00"
@.str.len5.h2072026244 = private unnamed_addr constant [6 x i8] c"enum \00"
@.str.len28.h497146076 = private unnamed_addr constant [29 x i8] c" layout payload identifier `\00"
@.str.len5.h1783417286 = private unnamed_addr constant [6 x i8] c"` in \00"
@.str.len31.h1478667446 = private unnamed_addr constant [32 x i8] c"unable to parse struct header: \00"
@.str.len6.h1280331335 = private unnamed_addr constant [7 x i8] c".endfn\00"
@.str.len35.h546841458 = private unnamed_addr constant [36 x i8] c" signature missing parameter list: \00"
@.str.len15.h87749209 = private unnamed_addr constant [16 x i8] c".layout struct \00"
@.str.len17.h1973869273 = private unnamed_addr constant [18 x i8] c" layout payload `\00"
@.str.len8.h571206424 = private unnamed_addr constant [9 x i8] c".endloop\00"
@.str.len6.h1583308163 = private unnamed_addr constant [7 x i8] c".meta \00"
@.str.len4.h273104342 = private unnamed_addr constant [5 x i8] c"ret \00"
@.str.len31.h1960327680 = private unnamed_addr constant [32 x i8] c" layout variant missing content\00"
@.str.len31.h329133056 = private unnamed_addr constant [32 x i8] c" layout payload missing content\00"
@.str.len23.h1564009733 = private unnamed_addr constant [24 x i8] c"unterminated interface \00"
@.str.len20.h1568429285 = private unnamed_addr constant [21 x i8] c"` missing type entry\00"
@.str.len5.h2064480630 = private unnamed_addr constant [6 x i8] c".loop\00"
@.str.len41.h2069276858 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_size entry\00"
@.str.len8.h487238491 = private unnamed_addr constant [9 x i8] c"header `\00"
@.str.len8.h1616485352 = private unnamed_addr constant [9 x i8] c".layout \00"
@.str.len7.h289982314 = private unnamed_addr constant [8 x i8] c"struct \00"
@.str.len44.h1623843 = private unnamed_addr constant [45 x i8] c" layout payload references unknown variant `\00"
@.enum.NativeInstruction.Break.variant = private unnamed_addr constant [6 x i8] c"Break\00"
@.str.len41.h35508704 = private unnamed_addr constant [42 x i8] c"unused initializer span metadata before: \00"
@.enum.NativeInstruction.Unknown.variant = private unnamed_addr constant [8 x i8] c"Unknown\00"
@.str.len8.h1370870284 = private unnamed_addr constant [9 x i8] c".module \00"
@.str.len32.h1822658020 = private unnamed_addr constant [33 x i8] c"duplicate enum layout header in \00"
@.str.len24.h457168017 = private unnamed_addr constant [25 x i8] c"unable to parse import: \00"
@.str.len8.h1521657554 = private unnamed_addr constant [9 x i8] c"payload \00"
@.str.len6.h734244628 = private unnamed_addr constant [7 x i8] c"field \00"
@.str.len10.h2070880298 = private unnamed_addr constant [11 x i8] c".endstruct\00"
@.enum.NativeInstruction.Match.variant = private unnamed_addr constant [6 x i8] c"Match\00"
@.enum.NativeInstruction.Let.variant = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len8.h1074277327 = private unnamed_addr constant [9 x i8] c".export \00"
@.str.len37.h1581468287 = private unnamed_addr constant [38 x i8] c"enum layout header has invalid size `\00"
@.str.len22.h625556084 = private unnamed_addr constant [23 x i8] c"` missing offset entry\00"
@.enum.NativeInstruction.EndMatch.variant = private unnamed_addr constant [9 x i8] c"EndMatch\00"
@.str.len9.h890937508 = private unnamed_addr constant [10 x i8] c"eval let \00"
@.str.len34.h654371835 = private unnamed_addr constant [35 x i8] c"duplicate struct layout header in \00"
@.str.len6.h42978514 = private unnamed_addr constant [7 x i8] c"export\00"
@.str.len29.h668562564 = private unnamed_addr constant [30 x i8] c"unable to parse enum header: \00"
@.str.len31.h1868156648 = private unnamed_addr constant [32 x i8] c" header missing implements list\00"
@.str.len39.h943297157 = private unnamed_addr constant [40 x i8] c"struct layout header has invalid size `\00"
@.str.len6.h1134498859 = private unnamed_addr constant [7 x i8] c"async \00"
@.str.len34.h1377481172 = private unnamed_addr constant [35 x i8] c"` has invalid effects annotation `\00"
@.str.len7.h398443637 = private unnamed_addr constant [8 x i8] c".field \00"
@.str.len35.h2058816325 = private unnamed_addr constant [36 x i8] c"unsupported enum layout directive: \00"
@.str.len5.h466680424 = private unnamed_addr constant [6 x i8] c"size=\00"
@.str.len40.h1512965366 = private unnamed_addr constant [41 x i8] c"unterminated function at end of artifact\00"
@.str.len39.h1399971520 = private unnamed_addr constant [40 x i8] c"struct layout header missing size entry\00"
@.str.len7.h1448749422 = private unnamed_addr constant [8 x i8] c".endfor\00"
@.str.len22.h496289716 = private unnamed_addr constant [23 x i8] c"` unrecognized token `\00"
@.str.len9.h1228988541 = private unnamed_addr constant [10 x i8] c"tag_type=\00"
@.enum.NativeInstruction.For.variant = private unnamed_addr constant [4 x i8] c"For\00"
@.str.len38.h1235260132 = private unnamed_addr constant [39 x i8] c"enum layout header has invalid align `\00"
@.str.len57.h1118233133 = private unnamed_addr constant [58 x i8] c"encountered nested .fn while previous function still open\00"
@.str.len8.h1926252274 = private unnamed_addr constant [9 x i8] c"variant \00"
@.str.len36.h414094739 = private unnamed_addr constant [37 x i8] c"struct layout header missing entries\00"
@.str.len41.h1415177535 = private unnamed_addr constant [42 x i8] c"struct layout header unrecognized token `\00"
@.str.len42.h1518215675 = private unnamed_addr constant [43 x i8] c"encountered .endfn without active function\00"
@.str.len8.h528348603 = private unnamed_addr constant [9 x i8] c"continue\00"
@.str.len42.h930606274 = private unnamed_addr constant [43 x i8] c"enum layout header missing tag_align entry\00"
@.str.len4.h268715771 = private unnamed_addr constant [5 x i8] c"none\00"
@.str.len19.h879467198 = private unnamed_addr constant [20 x i8] c"` has invalid tag `\00"
@.str.len28.h1605654048 = private unnamed_addr constant [29 x i8] c" layout variant missing name\00"
@.str.len24.h1881287894 = private unnamed_addr constant [25 x i8] c"unable to parse export: \00"
@.str.len41.h881857818 = private unnamed_addr constant [42 x i8] c"enum layout header missing tag_type entry\00"
@.str.len32.h1189086491 = private unnamed_addr constant [33 x i8] c"unable to parse parameter line: \00"
@.str.len5.h524431183 = private unnamed_addr constant [6 x i8] c"type=\00"
@.str.len19.h1782433603 = private unnamed_addr constant [20 x i8] c"sailfin-native-text\00"
@.str.len5.h2056075365 = private unnamed_addr constant [6 x i8] c".else\00"
@.str.len34.h1211676914 = private unnamed_addr constant [35 x i8] c"unable to parse method parameter: \00"
@.str.len33.h712498791 = private unnamed_addr constant [34 x i8] c"parameter outside function body: \00"
@.str.len8.h787332764 = private unnamed_addr constant [9 x i8] c"effects \00"
@.str.len10.h385719500 = private unnamed_addr constant [11 x i8] c"interface \00"
@.str.len36.h736848621 = private unnamed_addr constant [37 x i8] c"nested method declaration in struct \00"
@.str.len4.h175996034 = private unnamed_addr constant [5 x i8] c" in \00"
@.enum.NativeInstruction.EndIf.variant = private unnamed_addr constant [6 x i8] c"EndIf\00"
@.str.len7.h242296049 = private unnamed_addr constant [8 x i8] c"offset=\00"
@.str.len6.h841337749 = private unnamed_addr constant [7 x i8] c"align=\00"
@.str.len21.h2112628887 = private unnamed_addr constant [22 x i8] c"` missing align entry\00"
@.str.len10.h1219235236 = private unnamed_addr constant [11 x i8] c".manifest \00"
@.str.len7.h655348872 = private unnamed_addr constant [8 x i8] c"return \00"
@.str.len34.h183092327 = private unnamed_addr constant [35 x i8] c"enum layout header missing entries\00"
@.str.len31.h762677253 = private unnamed_addr constant [32 x i8] c"unable to parse span metadata: \00"
@.str.len7.h725262232 = private unnamed_addr constant [8 x i8] c".return\00"
@.str.len6.h1280334338 = private unnamed_addr constant [7 x i8] c".endif\00"
@.str.len30.h211710404 = private unnamed_addr constant [31 x i8] c"unsupported struct directive: \00"
@.str.len27.h237652301 = private unnamed_addr constant [28 x i8] c"` has unsupported segment `\00"
@.str.len29.h128952257 = private unnamed_addr constant [30 x i8] c" layout field missing content\00"
@.enum.NativeInstruction.Expression.variant = private unnamed_addr constant [11 x i8] c"Expression\00"
@.str.len16.h1695010494 = private unnamed_addr constant [17 x i8] c".layout variant \00"
@.str.len13.h1382830532 = private unnamed_addr constant [14 x i8] c".endinterface\00"
@.str.len6.h483393773 = private unnamed_addr constant [7 x i8] c"import\00"
@.str.len21.h1297227834 = private unnamed_addr constant [22 x i8] c"` has invalid align `\00"
@.str.len4.h268717223 = private unnamed_addr constant [5 x i8] c"noop\00"
@.str.len4.h267749729 = private unnamed_addr constant [5 x i8] c"mut \00"
@.str.len40.h318366654 = private unnamed_addr constant [41 x i8] c"struct layout header missing align entry\00"
@.str.len15.h506269955 = private unnamed_addr constant [16 x i8] c" layout field `\00"
@.str.len12.h841153022 = private unnamed_addr constant [13 x i8] c" signature `\00"
@.str.len20.h608364678 = private unnamed_addr constant [21 x i8] c"` missing size entry\00"
@.enum.NativeInstruction.Loop.variant = private unnamed_addr constant [5 x i8] c"Loop\00"
@.str.len48.h807033739 = private unnamed_addr constant [49 x i8] c" layout payload encountered before layout header\00"
@.str.len18.h1997941781 = private unnamed_addr constant [19 x i8] c"unterminated enum \00"
@.str.len6.h1830497006 = private unnamed_addr constant [7 x i8] c".span \00"
@.enum.NativeInstruction.Noop.variant = private unnamed_addr constant [5 x i8] c"Noop\00"
@.str.len46.h1830585629 = private unnamed_addr constant [47 x i8] c" layout field encountered before layout header\00"
@.str.len5.h1958778164 = private unnamed_addr constant [6 x i8] c"break\00"
@.str.len37.h2038142650 = private unnamed_addr constant [38 x i8] c"enum layout header missing size entry\00"
@.str.len5.h2072555103 = private unnamed_addr constant [6 x i8] c".sig \00"
@.str.len9.h1123073249 = private unnamed_addr constant [10 x i8] c"` invalid\00"
@.str.len9.h1311191977 = private unnamed_addr constant [10 x i8] c".variant \00"
@.str.len32.h1767333123 = private unnamed_addr constant [33 x i8] c"metadata outside function body: \00"
@.str.len34.h805939531 = private unnamed_addr constant [35 x i8] c"unable to parse interface header: \00"
@.enum.NativeInstruction.EndLoop.variant = private unnamed_addr constant [8 x i8] c"EndLoop\00"
@.str.len17.h293109504 = private unnamed_addr constant [18 x i8] c" layout variant `\00"
@.str.len14.h1219450488 = private unnamed_addr constant [15 x i8] c"` missing name\00"
@.str.len4.h192590216 = private unnamed_addr constant [5 x i8] c".if \00"
@.str.len26.h1606904140 = private unnamed_addr constant [27 x i8] c"` has unsupported suffix `\00"
@.str.len3.h2089318639 = private unnamed_addr constant [4 x i8] c"Let\00"
@.str.len40.h1650449248 = private unnamed_addr constant [41 x i8] c"struct layout header has invalid align `\00"
@.enum.NativeInstruction.Else.variant = private unnamed_addr constant [5 x i8] c"Else\00"
@.str.len8.h562875475 = private unnamed_addr constant [9 x i8] c".endenum\00"
@.str.len43.h1714227133 = private unnamed_addr constant [44 x i8] c"unable to parse initializer span metadata: \00"
@.str.len4.h275319236 = private unnamed_addr constant [5 x i8] c"tag=\00"
@.str.len37.h1152036459 = private unnamed_addr constant [38 x i8] c"unsupported struct layout directive: \00"
@.str.len30.h829706524 = private unnamed_addr constant [31 x i8] c"unable to parse enum variant: \00"
@.str.len30.h208276320 = private unnamed_addr constant [31 x i8] c"unterminated method in struct \00"
@.enum.NativeInstruction.Case.variant = private unnamed_addr constant [5 x i8] c"Case\00"
@.str.len22.h24304067 = private unnamed_addr constant [23 x i8] c"` has invalid offset `\00"
@.str.len8.h1951948513 = private unnamed_addr constant [9 x i8] c".method \00"
@.str.len39.h598838653 = private unnamed_addr constant [40 x i8] c"enum layout header unrecognized token `\00"
@.str.len33.h1023685264 = private unnamed_addr constant [34 x i8] c"unable to parse parameter entry: \00"
@.str.len42.h1171387022 = private unnamed_addr constant [43 x i8] c"enum layout header has invalid tag_align `\00"
@.str.len26.h1834305347 = private unnamed_addr constant [27 x i8] c" signature missing content\00"
@.str.len9.h1692644020 = private unnamed_addr constant [10 x i8] c".endmatch\00"
@.str.len41.h1384306956 = private unnamed_addr constant [42 x i8] c"enum layout header has invalid tag_size `\00"
@.str.len29.h555082439 = private unnamed_addr constant [30 x i8] c" layout field missing entries\00"
@.str.len20.h1216366549 = private unnamed_addr constant [21 x i8] c"unterminated struct \00"
@.enum.NativeInstruction.If.variant = private unnamed_addr constant [3 x i8] c"If\00"
@.str.len7.h130169768 = private unnamed_addr constant [8 x i8] c".param \00"
@.str.len44.h1730891783 = private unnamed_addr constant [45 x i8] c" signature has unterminated parameter list: \00"